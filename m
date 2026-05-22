Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97897CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDRB-00073y-HM; Thu, 21 May 2026 20:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOd-000374-1V
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:51 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOa-0004oC-UD
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:46 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2bd2051167eso31328165ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408344; x=1780013144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=809jTw0II5N5ij9MlXizdCEqzNW0NW8czul7ViHGw3M=;
 b=F9RLfYkeIg0O1aGXtVlX9DzeaYNXou0U8OmG9RLzO3lTI5gcI5dAJyIdg7ocj0SqAm
 4JClmqbAGTsRGQnODpaQ4fpCg3p30SntlcUc2z54BD8SeXprnRduZO45wRnG9xCR1L8p
 ost3gjwn0lYiW9kBe5nFntblu0qVTVjCcCsNZTUtvCOKc5/oKWpC6ha5UIp2guG06aMN
 uf1lWpaMU/RmE5gcX7IMgiZebzfFbhgnxcZ7R2qPpna6GkUnsfIMBj2fKghxZUj8UpYT
 uWZB2/IuYvXAxYincv110jVZEfT5OAV20vohE4dwJVX/4jLF7yOgKFcFrROoTZTdGbWA
 h1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408344; x=1780013144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=809jTw0II5N5ij9MlXizdCEqzNW0NW8czul7ViHGw3M=;
 b=mHXGyw1FYG/7vdTf7ENsaYs4m62xqS109fPX0IqqejTj85s8/ez1YDMG/3N0bCUfRW
 rG7yxdYhROEAN3dSKqVjsHKPDz3u+KbC7BhyiCchsQulrBm9kx/cKAe30TDy2zPawiTK
 UOsjU99iMKk0HeG+IPLBy4h+wNDIlDFuNma72xjrUJPJM2R8YDD9x7rBGEZQ3v+8Y3/b
 fC61UfYRcniR1YkRWBLHJDUtuYe8WmetTF3OmtvUTP1PG2BupbkehmJfDsiVYt8RKRSO
 hyD2AjZd6qXngf5Yu7c1hCDwPFEnGT95BB/FSx7jYniWyngKaQTd1npuuu2No3rp6Rbx
 55Vg==
X-Gm-Message-State: AOJu0YzrBNiZ1EHP1PRtFA2CfVA0urjjXVyGIXoDq7TWY4HqP3PmJLO4
 m8KLn/G0mZZkLKgnNFI5sZMwd/ezX656zrmIrMu5R28994Ls+uIKgZ/3yOGXCD27
X-Gm-Gg: Acq92OFd9YOzbc5IPqNNPhSXz54XsfWGVR4XvdgJnxwdQCRO6nD4CVkOan7y5+RUxg9
 z5wM8UFK55pJ71/HD+cOBaQMBRP7nb0eHYo9R8vL2PjksYgF3u+bm8wyP5IzG+SmF9O7ZGR3njB
 ns6UcSWfLSxW7M4sjtpCBZkpK/E6nzzV+XeMcjhhy9teaVTviBv6iCNSfnrjal6CK51eXHTSvqG
 MrI9yIio5IV+ubVzyvcV5j15V8mnsek//FEtLcWgBPZPsBvfZhccFjinFLnjARRfTsp4YfG+e7H
 QHNO4RITy6SmCK224kEpBb8EP3vdBJqDSBPbUNgF/St+QNcNzpR69VOeeQRRI0th2hf3BdTrPEr
 HZDvJVQJmJf4CjQvC1qcqoJNpwg3cYpVWSsPuZbq9r2FCPgTqpJquGLAghNft5npoWdIBZb8VXp
 Tabi8wc/TNQALgrtS8hMueB7YBJ00w3qQYFtR/79yubw==
X-Received: by 2002:a17:903:3905:b0:2b4:59bf:5728 with SMTP id
 d9443c01a7336-2beb05e4149mr12450455ad.25.1779408343671; 
 Thu, 21 May 2026 17:05:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Fangyu Yu <fangyu.yu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/48] hw/riscv/riscv-iommu: Fix IOCOUNTINH.CY toggle detection
Date: Fri, 22 May 2026 10:03:16 +1000
Message-ID: <20260522000324.23255-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Fix IOCOUNTINH.CY toggle detection by comparing normalized CY bit
rather than XORing whole register with boolean.

Fixes: 2cf2a6c027ba ("hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260509074941.99295-1-fangyu.yu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index e8d284ac8b..5bf80a8db9 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -245,7 +245,8 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_inh)
         s, RISCV_IOMMU_REG_IOCOUNTINH);
 
     /* We only need to process CY bit toggle. */
-    if (!(inhibit ^ prev_cy_inh)) {
+    bool cy_inh = !!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY);
+    if (cy_inh == prev_cy_inh) {
         return;
     }
 
-- 
2.53.0


