Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25EAFF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHepA-0003OD-Jg; Tue, 28 Apr 2026 05:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHep8-0003MB-NC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:33:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHep6-0007QK-Vb
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:33:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso83459735e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777368823; x=1777973623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cvYLVcnk1qS3FA5lQP8W94koZO4vK3ygKeMeP+mRXU=;
 b=aeDDAU6SBs+NtD1I1J1pLZa0oKuSE4dJ/CGwLIpUWSNQhsPiGZb7l4hKGvvrCAgFr1
 HFGk0elPnj0+MTJ+8VJ7sTjlyBK1XI5btiNOjPQjNS//PKAR7kB42gTKNjmtxKzvY8iK
 DlbTqFr04jsDO4YJW6RI9KT8QNq/QMM+OPQ5FFXSxR8lf11b7n766ltbV0UdlN2LKtwN
 RZJZ+Iso8BSwER/Dsn/eqeunOPgNOWcrnrxKw9tV7EkPrVJ0Lt/x9cyQ6L33c8HH/BtS
 sdXw7w29JaYzrBNjmHxl3l0QUabpqEr6rJhLLR3wjQnAhNg+MipCEX0omptU6kad0e73
 9Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777368823; x=1777973623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2cvYLVcnk1qS3FA5lQP8W94koZO4vK3ygKeMeP+mRXU=;
 b=DbuNheGwvBM6QsfrRGPtwBm3lR2s//dbI35HxMC0EKkXkA6E+hQyHrZuRUu/3itm9W
 Pl2PhUuFgPtnPJ+CeZfSX5nHvLcnR/2UiK3TI3Vd4EzN602JsnFzvEJJ8AnEsfdiTajh
 UJGsOXjWO2F+OzUQAousowzL18V9wuA9Krr1jFJBnjrfU6XtskAyk2ih63NAbjDNSm2R
 4RHYcBUrvaAZIJpBWJtAnX9jfwUVJs3iaWp9mTG6RBdyj9MClKfmhZfz6Xg2inFfxoA+
 15igL1q/zFihkrWxOzG6++Brcw5BsXv/MqmlqmND34u3mND3bvLI8bWQ6ePXc6DR2bNA
 8hig==
X-Gm-Message-State: AOJu0YztW9D5SXtSlnkGYIEF6n+bh1KM2WhJV7JwRF5Ay+dFTIMq5yU7
 4RHqiOKl/iLiQqoGhTxF/n8Bikhqcl5AZBYHO+kk7Iyzp3JrzW4knWvJDNOHrrUgSlaGLWl6mHr
 tGuyp
X-Gm-Gg: AeBDieurofJXdCllGOEOTTHLWYQI3+Fo62eEo/lRLOhwo0sgDIFjL20tvwmDSydQi8o
 mEJI4OL2yygzYuNI01tPX60Y4UV6YDdcqM2J6ivdt/qFmEi2AF/NmwKQILEf7Y7aplyFOZYEaMz
 1BWoDJn//cDuhe+dOrj8mxC5ju/iVkrFSw30FoacStV+Mr/jMCj94035S5Vu9hnSMfB+slU7sfO
 QNpH31F7Fjg+5Q7zrNWUsPGorhyFyLcG5uvu8DqzYF3DwF6aajQo4Qm9lvVu+BX13bvbrEaRlHh
 XGura112IfHUVOVeY0R+b3MOUscIck3WD0G3ypV0LsV2B4ypxIuGbNPhc7sL45YSM2rRtKdnAfO
 jdWkK5Mg+FAWnA3GDMt+eDFBMLnKZi3myj/iy2AV0zG36GfmzvqPgtZW4awNPtNxnICgtFRrYlz
 GDf8KLriW1hoqS8Z0WS0lH55z9iQChkPjOqy8C6c14WbB8fgVKgQNg9HyggsuE/HF78vm2Xu8AB
 Vfsqi0MvZE/M3fyiA4euM3Ua2hgUuIkqtM8mZ968A==
X-Received: by 2002:a05:600c:3386:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-48a77e64f29mr18307465e9.16.1777368823314; 
 Tue, 28 Apr 2026 02:33:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a774d7a1fsm19665595e9.4.2026.04.28.02.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 02:33:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 1/4] hw/riscv: iommu-trap: remove .impl.unaligned = true
Date: Tue, 28 Apr 2026 10:33:36 +0100
Message-ID: <20260428093339.2087081-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428093339.2087081-1-peter.maydell@linaro.org>
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: CJ Chen <cjchen@igel.co.jp>

The riscv_iommu_trap_ops MemoryRegionOps specifies that
unaligned accesses are not valid for this device but that
it does implement them. This doesn't make much sense, and
we want to add an assertion that registered MRs don't specify
this invalid combination of settings.

Drop .impl.unaligned = true, with no behaviour change.

Signed-off-by: CJ Chen <cjchen@igel.co.jp>
Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
[PMM: reworded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/riscv/riscv-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c3c9ed6469..f0de264a10 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2433,7 +2433,6 @@ static const MemoryRegionOps riscv_iommu_trap_ops = {
     .impl = {
         .min_access_size = 4,
         .max_access_size = 8,
-        .unaligned = true,
     },
     .valid = {
         .min_access_size = 4,
-- 
2.43.0


