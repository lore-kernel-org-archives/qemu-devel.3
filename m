Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1422FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHepD-0003Qr-4k; Tue, 28 Apr 2026 05:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHep9-0003NR-O5
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:33:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHep8-0007Qo-3c
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:33:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso88560305e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777368824; x=1777973624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVC3itSIffFeC7Z8GlSjGgA9Tg3i0GpOS5eY/5lxrn4=;
 b=rj7zdTA8M/AZW7o8vRqn91sKKqoXjmGfBR0Pv3NXWQh4kjT5S1hNDBT9K8yhs9Quh8
 02+Xn0ZBMYwv12pcIjRVo4fN+T8fK4UisSRsBRowVX1tPMu50lzcccMQ6yE9T8UnWf6G
 FWNYThWxIWBW0E1FX4cPndl1eVfAnNo/TQQxqzLxcbdn6vNB4oU/CrgGwWhQOMxaJduT
 KwHcb604gg+ACBDtq4iAwA5BSVNKRUd86k1SngxYnXj0EIQ4Tc+2NqZj0eNPibG+Iq9O
 jw5uquvw+AVsZoEbOZg/By9WQRUmQE67f/krqDOC2jAIYpBFoAEAGOpJhS2HZ3PUqY9P
 b1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777368824; x=1777973624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WVC3itSIffFeC7Z8GlSjGgA9Tg3i0GpOS5eY/5lxrn4=;
 b=p2zuq9PEo09PA2UyiPgqWqtVpYeQOOGLak2zZ6CLiG4IVu/6QrXqZG7XJkF14vLhIa
 vnEdw16A167w9Ft885e8izaKGu9wXv3SJPCMV8qeylOcXQlP4cpLiNmBGdyRHG0x0+bN
 dFOmIwToYim10kp1cAVlAjEcwDhDaJ4mZE8iqEgSBWoC3o7k54Pq+6Z4meLmwNcTYaSJ
 CFjQCfGBM2lj+0L7Q/FaJJhm12LzvtnHOYHqbN61aiBQ5uFy4nB82DBUEngNdOoN14VO
 l/Y3pNkECvOdnx234R9ExqU3VDl2gfeGAc21LeHx64jh1zZ0HMKnFtNQ/i6YfzmZ9nF6
 p6Xg==
X-Gm-Message-State: AOJu0Yz4ngLdqmO4/s3jtC8RbEaRpugsJu/eBvU40k+3UNFazJ7OiyCu
 b9SDVrg1kgRFOUrrp7Eji0Hon13K5ebMABx1ICmub+9dlBvGOgamXD8IbSxMB91dkQAP8Ic+Gt6
 XGvj5
X-Gm-Gg: AeBDietiL9CEtn5DHEhqCnW6AP2s2RYw6GTr7tVqhHDantxe55KZbA/GJVRzycvptwN
 +Mb28q3Yx6ET/SKtxJokCQXAX1d6UBjvghPWSuJ4YSJZDMuxl1Kjkj8eMQMTECbKhAwm955OleB
 bBVh5lhtnc51X38dNtNDY27GiXjR5mvmhWSlkIxVsew0Q+c2+ILT1GPmN306uxdBWvhOt9gD4ZU
 pGJ/SqyfZZwEwAkQbx/TUs3MBGQ0frHHb4OljTBoSq5J95ZW6HrG0hAElrOkJuBFcZc+Br4Z3mG
 jC//1EPsegRAH2Vcx+7ecZPyRywwS/ZtZBLOzD/FdSjMeetCzzgZGkQLTRDzDoIjy0S6xonOnA7
 ZyFxf3SvXZWnuJqtDwfkr2JN5pxQYmTITjQukjqXoJBIfnbCU6N9hF4XXNXVh2wfg89kOlHadK1
 WVsn5tvPsp0HABoAhhI/Bwvq8Vnn+oMRVDbvxAAi8EzBz7Qs0KTJccLdVBkOcGIeTnpoSvATUl6
 4Ivbwp3iuJG9fEUc3mGRDXU51GRxb+yDIYR9XVqnw==
X-Received: by 2002:a05:600c:6995:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-48a77aee4a3mr37301045e9.3.1777368824444; 
 Tue, 28 Apr 2026 02:33:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a774d7a1fsm19665595e9.4.2026.04.28.02.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 02:33:43 -0700 (PDT)
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
Subject: [PATCH 2/4] hw/npcm7xx_fiu: Specify .impl for npcm7xx_fiu_flash_ops
Date: Tue, 28 Apr 2026 10:33:37 +0100
Message-ID: <20260428093339.2087081-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428093339.2087081-1-peter.maydell@linaro.org>
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently npcm7xx_fiu_flash_ops provides no .impl substruct; this
means that it gets the default of "implements 1, 2 and 4 byte aligned
accesses".  This is more constrained than the device permits in its
.valid substruct, and also narrower than the functions are written to
handle.

Add a .impl substruct matching the .valid substruct; this means that
all guest accesses are handled directly by the read and write
functions, and are never synthesized by the memory subsystem
performing multiple accesses to the device (which would not behave
correctly, as these read and write fucntions have side effects).

Based-on-a-patch-by: CJ Chen <cjchen@igel.co.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/npcm7xx_fiu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 02707de350..2d5bed005a 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -250,6 +250,11 @@ static const MemoryRegionOps npcm7xx_fiu_flash_ops = {
     .read = npcm7xx_fiu_flash_read,
     .write = npcm7xx_fiu_flash_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
-- 
2.43.0


