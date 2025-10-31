Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E5FCCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtx0-0004tn-U0; Fri, 31 Oct 2025 14:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwx-0004sH-Op
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwQ-0006Eq-Mp
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso1797507f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935614; x=1762540414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yxFpFZHpZvf91gNqpi2WxKJQUxaoggcUXU1IuJQju8s=;
 b=YuU/vkcV+Gnx5r/G7JaJRCi7mNZNrLHOTsx44NpJq7bDsbLuwOLnlNoOtQRD7iBF39
 SbSiVNrHrZVasyafBSycLwC2Xy6gi0/Ssr8wzLpz9/lWk+JDWM77RQ3PxjRV/4WMU4M2
 U3u7EcEunyg03KMBrakfnqGryhFrHoY+C9EVAH4LEF4BTfDf47VycFf/yPOGWQaomeLu
 XRL1IrTYQaXf3EjXwbhyzCCjtBAKCGGN97yucIjyoXlc2G5rDCp+5RT2AsrpegOn9L39
 EHwyffGl3X2FyG5aK5bu5mi9p1dBakgdE2nMhtyyGYpQZFiPD9j80EtkxE/t2cW9rozZ
 nO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935614; x=1762540414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxFpFZHpZvf91gNqpi2WxKJQUxaoggcUXU1IuJQju8s=;
 b=qwve8pjG2Z2W8Jgx/KWGWxecvtRbSAfjb2Hldc8CZvwMxXpsa7hX8BrHxnSXe9lNe1
 2V820vpBxateIDi5ogNXJBhCKbqqP1mukVijXpmHvs+SK7dv8V68gXzhyDpstXmmdi8c
 r7P6EgTr+EhozP5rkPMK/5Dzfp+vJ2EXpD6y7VjStVMB7p/Z3u+IYoXDAsjUNPgn6Wpv
 DUfeTSzQo1pl8pgKiB13bqLWIQXmXEmrBksUQolrQ0HaswnH4bQWGMkojtw1Ie6hvCzt
 jy6UE8B2WiWHzU9mN09zJ4SFXWKG2BsA1wgFyUCTtpsKEj5aHRyvVJJ8FL51xwzOEjlu
 Ro9w==
X-Gm-Message-State: AOJu0Yyhi0dJSChe4vrjq7hfSE9G6MUhNHodJtdfkdQj6VpK6eZ4WqmU
 HWmgxq0hcXVufzcJ92UEgxXRgDmVIcNp+HDtG6y0s18fy9ILYmMqDDlK7TvPvqTAE/TesMCuT2f
 SQM5Q
X-Gm-Gg: ASbGncsL3FPMpDY/W89iWczEKeNbcISzFnRURJOjH9fz408LhnXLyvBYOYU9DCYV2Ae
 MHmZIrSWrqKVqO95uRgJ6fiF645a8Yb1yRgkp/K1aTVRfm4aJxJpnBEuBHsbZ1Jh/OJA4D4DCnM
 K7EhDMFfe6zgjbqQJ2vsgeIjYnVO6a0NOh1TYRWKnBrQY4k42Ewfvdobprj6RmN8yA77S04tAKw
 +cQFCW4qbINo/oPyTQJ/1/8Tl4mjx5xLys1Z5EBR0Jb3tt3skAhUKtuyaU9eeFOBTv6OftCLPJ4
 fYZxse7eRnlzZhS1ByuMF2TZ5xxWSbqw3vBx74o8sZ6TBLCESeqJ9oNehUY6Yrc0rSASZSJK4Vx
 zIO2PnqC3iQrd57pdM5uYwbsd4PrfRjMClWPajoTIimhkFcvDrDulaouroVdaVMZTYzvj18HyNg
 nRqOPJvA==
X-Google-Smtp-Source: AGHT+IEyNhA0u3kd2uTTXsFoEZZX8rEWtEbCY55Ru5n+2LQ1gqrqDFpn2pMyjYa6YzFsS5qJo+IKLw==
X-Received: by 2002:a05:6000:1846:b0:3f9:bc33:2fab with SMTP id
 ffacd0b85a97d-429bd6c18a5mr4400889f8f.60.1761935614337; 
 Fri, 31 Oct 2025 11:33:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/38] target/arm/hvf: Hardcode Apple MIDR
Date: Fri, 31 Oct 2025 18:32:54 +0000
Message-ID: <20251031183310.3778349-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Hardcode MIDR because Apple deliberately doesn't expose
a divergent MIDR across systems.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d13ccf5508c..890e9266f93 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -763,6 +763,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     hv_vcpu_t fd;
     hv_return_t r = HV_SUCCESS;
     hv_vcpu_exit_t *exit;
+    uint64_t t;
     int i;
 
     ahcf->dtb_compatible = "arm,armv8";
@@ -781,9 +782,19 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
         r |= hv_vcpu_get_sys_reg(fd, regs[i].reg, regs[i].val);
     }
-    r |= hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);
     r |= hv_vcpu_destroy(fd);
 
+    /*
+     * Hardcode MIDR because Apple deliberately doesn't expose a divergent
+     * MIDR across systems.
+     */
+    t = FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0x61); /* Apple */
+    t = FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf); /* v7 or later */
+    t = FIELD_DP64(t, MIDR_EL1, PARTNUM, 0);
+    t = FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
+    t = FIELD_DP64(t, MIDR_EL1, REVISION, 0);
+    ahcf->midr = t;
+
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
     /*
-- 
2.43.0


