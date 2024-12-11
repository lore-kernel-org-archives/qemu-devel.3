Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74ACE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSu-0001ns-5r; Wed, 11 Dec 2024 11:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSc-00017V-5j
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:15 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSY-0007r3-Th
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:13 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434e3953b65so32390595e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934069; x=1734538869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9o6ZrjR1RXdiifOcsykBiN0/Ne/2VfOey1zb2DGye7w=;
 b=nbCQ141YnlGsGTxPBqyHsTALXTdBHXmDUpH/Tb0PDeOeTNIti+i8b4TUp+RwMCMmrX
 7EhXk2AXp0VlZ7dGbgY6kq50hPseGEQKiYUFPp4hr9ICXD7+NLDZPzzDnnOFAAoppon1
 EZY5hQV3g5h5aq3oW666SkvUuWBxi0RlIcYewesVrQSdp2lvb3UAF12WCYqCfJI7y7qG
 FQDBtJDWvvfx+GbcxQNFJefOi2OUKfxoNMwMYijDY+uoqZdo/NwPZJ7ivwFuMf45lp25
 yLKsfmnkBO/7lld4PrbDUW0Y4lAjMXnF4FdnWZXZ62R3dcL6e0bJpJNZS61/KBfffccZ
 fvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934069; x=1734538869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9o6ZrjR1RXdiifOcsykBiN0/Ne/2VfOey1zb2DGye7w=;
 b=UtCIQfVw0Bbkbc/vzM+DPG/oLF4bE35ktK65qM704JNNxLyhhp6PvtO60PKPtvpCzb
 TfRvn00CEVF6vACiIYLYvcfmuTVh2zIlh4FajbNKc6bsthZ/8qq2kYYrs8+hvRz6sT1p
 wb07aqYzNIO2nay658La/hv7ramUX1Dq4MWKdleDr+i/li+VZwpgibZzPJ6qW+yQXYPS
 HpNSjWDoaRAdledGnhBr+IJohzDy7Ss34odBTiSXDQRNgFjiUiCCDB0NAvTjt1crsfki
 6D+ts8Y1qYqP/peoMiF2QgQRw2c0aGr46NxZMQVqj/UEqdpnPRhDCVBydzFj+TNLFI8Y
 LX3w==
X-Gm-Message-State: AOJu0YzfLcq8faK+6h7A2uWOVaCTmsN+iCfF4MiAilvwa/KKP0ibPNL4
 80GvO1ht+twcjoJtfr3p9ySTdNHgcjFUE4p7FP6bWt9cjhSf8OYSKPkjpfKhy85CeAWoP/yepZh
 L
X-Gm-Gg: ASbGncuhzMMjTff/aBiTAC67Doy4d9QmMn9Jayyx+WCGXX1PodcfLyPZGWrZNfHUNAs
 J5I6NY6A6SKzEle+0Tc3dmmHDeZ/1bClyUz/f3kC1H0Umj/I1fX6YI2gYJ1zNOtGFjeCZD6ERvJ
 x4UmyxR1hAXs6R0qGVzZ27l4Ko6PE51oMqNw6T89OMehmp33NoKteDu4VhEg6oW80XiPg2geUjr
 k9DKrv7/Z1xM+0/I1LgnqlOr5G8O1NXy6n0jPdp9Fhhuhi8TmfnwtVFRGoO
X-Google-Smtp-Source: AGHT+IHqVR88LkgRBnC6+5ARv7C3/HiWXj7511XV75AsnDMYaXnkkpS2Gd65CSgTwrvX1clpp51mOQ==
X-Received: by 2002:a05:600c:8507:b0:434:a29d:6c71 with SMTP id
 5b1f17b1804b1-4361c411ab0mr25219625e9.27.1733934069518; 
 Wed, 11 Dec 2024 08:21:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/72] target/sparc: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:47 +0000
Message-Id: <20241211162004.2795499-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Set the default NaN pattern explicitly for SPARC, and remove
the ifdef from parts64_default_nan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-50-peter.maydell@linaro.org
---
 target/sparc/cpu.c             | 2 ++
 fpu/softfloat-specialize.c.inc | 5 +----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 0f2997a85e6..6b66ecb3f59 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -818,6 +818,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     set_float_3nan_prop_rule(float_3nan_prop_s_cba, &env->fp_status);
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
+    /* Default NaN value: sign bit clear, all frac bits set */
+    set_float_default_nan_pattern(0b01111111, &env->fp_status);
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ecb7a52ae7c..06185237d0f 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -136,10 +136,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     uint8_t dnan_pattern = status->default_nan_pattern;
 
     if (dnan_pattern == 0) {
-#if defined(TARGET_SPARC)
-        /* Sign bit clear, all frac bits set */
-        dnan_pattern = 0b01111111;
-#elif defined(TARGET_HEXAGON)
+#if defined(TARGET_HEXAGON)
         /* Sign bit set, all frac bits set. */
         dnan_pattern = 0b11111111;
 #else
-- 
2.34.1


