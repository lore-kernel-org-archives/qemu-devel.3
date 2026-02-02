Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8BEE73170
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu46-0006nc-PN; Mon, 02 Feb 2026 08:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu44-0006mI-ST
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu43-0002cj-6g
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806f80cac9so23351865e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039242; x=1770644042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=am4mHMPcOaDWpeUBgMJCWJAj5MoT8YrEI2sYfgIQm8s=;
 b=bpaqVTv7GezAUC0vv0PSljSo8uEdC8tWC5Q9AoLOQih2XFJo0EBwhRz12b/2CZ3HXe
 86LjQpeTsOXxbRFuLzT2EOHqgponM5CMwYI2jy8LcLMdZOkTu4jGlQ7lCwnwugsIKuNf
 ikXx/x013GOIXFUnyAzKLvDg+W8z3nlEw9etDTk0cBQgJjVdgD9eKvAM0v6pV4ygA3S3
 EsDDWs7oCRlwYCWkoCj6Dlw62xZjt53J57fd9Yx5eRP5RJmFUW6chM7QaWP4nN4Lhuvh
 YhjK37M5xV131k92P20J9flvwwQPAP8YLOJmqaw8x/1R8jgtQW3Y8W6YHYA469fdVovL
 GLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039242; x=1770644042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=am4mHMPcOaDWpeUBgMJCWJAj5MoT8YrEI2sYfgIQm8s=;
 b=OIssqcSdIFdIBzQegYXIiHob36O3xQXm/JqetFNtBpvEGm6ARIUPpceI5hFUq3U/3a
 TPqM67oUnggxzftj9P2NXg+nEja753V7znvcwbPDtT8nmzaGhWbjIwYtn6uOkxFdL1t6
 2E4kbLZM3Q41wUCECbS4Ya1xlLPvhh3didVlGeRRyFps/5jFYtGzOSt5iTenciFtkkU/
 YrupjZk9Z5nUcSqM3GX9rEoL+MMVUTMVSpMebMvc/QBoZq2ZunFhAIoVRNUkK2Lh7ivJ
 gb+1F/YY+yR68CUkPPKhZLq2ggtWJZU5zWGh6PAZuVLlH91gMh1xdzKeQmRYSetbYqOH
 yh2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj5/8KmxCG4clyoomByA420zGHbm0T6TokQ2QZHhLYSrHqpU3qbVTWwiO8oSF3A8ZTojxKBFrjKtiR@nongnu.org
X-Gm-Message-State: AOJu0Yxfiy8/Is+k/YiXcjHfydJnbjV+pmO3GPhORmVA8K0laZy59j5J
 OEkre+8mbaTHPNVBl5YvAEjGQLJTzS2NIK4WhdOO/ip5yLLD2D+xKYzNDmA9HClNmtA=
X-Gm-Gg: AZuq6aJo2e0/EMy/sIs6e9FWQim7BPXfLqJcAPbyNLGEfwFA6YAcxg4kzenQvFoXfQQ
 a6W5xT3OjByNEqzboxiegXh4uU5xTIlwOuowjrpdwltBA0pQGWv27waw4KcTQntLH+wOKC5/o3u
 wi1NB2NU+YBht3CPSB1SNnYSMikuj4sJATN/iQCRhR13CtUvSa/gs11dfFd3jooF56N4ErRp88S
 tn7V2qCquoc+iu1Np+Km26EkoHaoWt0rX/IFY4Y9CJ62TOKCOAfeHFKGerodbwKSh0x0nmCy9E4
 JCPXHRtrRLp4w/OXMEYRXP6Bw3s4SlsI+tLI/Wlm7Un7iAbeWKnRuU8o6y95qlwoJqx6E5GHVmr
 OyZJ6NkjDWzWWSaYotp+K6sYH2rpYvg0gHH4XruNS819cW5N3AsurhVYCPxRHNk9wdRRWjO++Cg
 UhqIDreVYEjPWax+xJV8i34DnNpyViBw==
X-Received: by 2002:a05:600c:1e0d:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-482db4d8565mr149415205e9.20.1770039241639; 
 Mon, 02 Feb 2026 05:34:01 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:34:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 05/15] target/arm: Don't let 'sme=on' downgrade SME
Date: Mon,  2 Feb 2026 13:33:43 +0000
Message-ID: <20260202133353.2231685-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

In our handling of the boolean 'sme' CPU property, we write this 0/1
value directly to ID_AA64PFR1_EL1.SME.  This worked when the only
valid values in that field were 0 (for no SME) and 1 (for SME1).
However, with the addition of SME2 the SME field can now also read 2.
This means that "-cpu max,sme=on" will result in an inconsistent set
of ID registers, where ID_AA64PFR1_EL1.SME claims SME1 but
ID_AA64SMFR0_EL1.SMEver claims SME2p1.  This isn't a valid thing to
report, and confuses Linux into reporting SME2 to userspace but not
actually enabling userspace access for it.

Fix this bug by having arm_cpu_sme_finalize() fix up the
ID_AA64PFR1_EL1.SME field to match ID_AA64SMFR0.SMEver.  This means
the "sme" property's semantics are "off" for "no SME" and "on" for
"enable at whatever the default SME version this CPU provides is".

Update the documentation to clarify what 'sve=on' and 'sme=on' do.
(We don't have the equivalent bug for 'sve=on' because
ID_AA64PFR0_EL1.SVE only has 0 and 1 as valid values, but the
semantics of the property are the same.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cpu-features.rst | 10 ++++++++++
 target/arm/cpu64.c               | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 37d5dfd15b..024119449c 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -318,6 +318,11 @@ SVE CPU Property Parsing Semantics
      provided an error will be generated.  To avoid this error, one must
      enable at least one vector length prior to enabling SVE.
 
+  10) Enabling SVE (with ``sve=on`` or by default) enables all the SVE
+      sub-features that the CPU supports (for example, it may also
+      enable SVE2). There are not generally any lower-level controls
+      for disabling specific SVE sub-features.
+
 SVE CPU Property Examples
 -------------------------
 
@@ -430,6 +435,11 @@ and all vector lengths must be powers of 2.  The maximum vector
 length supported by qemu is 2048 bits.  Otherwise, there are no
 additional constraints on the set of vector lengths supported by SME.
 
+As with SVE, ``sme=on`` enables all the SME sub-features the CPU
+supports (for example, it may also enable SME2), and there are
+no lower-level controls for fine-grained disabling of specific
+SME sub-features.
+
 SME User-mode Default Vector Length Property
 --------------------------------------------
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4dfc03973e..26873a39b4 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -363,6 +363,16 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
 
     cpu->sme_vq.map = vq_map;
     cpu->sme_max_vq = 32 - clz32(vq_map);
+
+    /*
+     * The "sme" property setter writes a bool value into ID_AA64PFR1_EL1.SME
+     * (and at this point we know it's not 0). Correct that value to report
+     * the same SME version as ID_AA64SMFR0_EL1.SMEver.
+     */
+    if (FIELD_EX64_IDREG(&cpu->isar, ID_AA64SMFR0, SMEVER) != 0) {
+        /* SME2 or better */
+        FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR1, SME, 2);
+    }
 }
 
 static bool cpu_arm_get_sme(Object *obj, Error **errp)
@@ -375,6 +385,11 @@ static void cpu_arm_set_sme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
+    /*
+     * For now, write 0 for "off" and 1 for "on" into the PFR1 field.
+     * We will correct this value to report the right SME
+     * level (SME vs SME2) in arm_cpu_sme_finalize() later.
+     */
     FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR1, SME, value);
 }
 
-- 
2.43.0


