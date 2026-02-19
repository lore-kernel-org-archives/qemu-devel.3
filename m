Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B37E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mc-0007Ci-Jk; Thu, 19 Feb 2026 05:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MT-00075e-Io
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MM-00062y-GQ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:17 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso6969955e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497252; x=1772102052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ymWsJOl3EYWNePVYcoHaSpgh8B6NORXwc2lcKaczgL4=;
 b=dXu0AxhBlF2UB3Vkx22FKgAZvN8g92FEu2IUXA+Vx0Izv1jpnYBZTF6ScjnbgBA5EN
 S5KSE4x3K1XwWo3kgpE0+AQX3E9e7/Sz/d3EHpjWBlIl2LPw4yAcFFeDWhq2NmLHA55x
 1G0vhUT0k0WES6MBYcPOTVJj7O3xuKWty1v/FigKp/I7EdKualehYjoDFKVut56Wa8N2
 TvK+3S9cPur79IViq/FzWrzKqExoqk2AWXQYzbHYGyCTkitKFHhbh4ietQ0KWNzbhSxD
 rQcrSzSgR2eKy47WpVjJJ/iGyJi0Gqn9c3E4ga/9FWFHqqdyoXy9gtjSlr9MDXgyQqRM
 gH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497252; x=1772102052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ymWsJOl3EYWNePVYcoHaSpgh8B6NORXwc2lcKaczgL4=;
 b=MD/EKtkPnimeBVaqlEgW2CGhK3nkMRq10fHjPoIb1X7pgT+VHVe9NCSd8JTz2zn4lA
 hC+BRm/MaKlmJytOYXLnSqQDk4wUzmjetleQo0/reVfHJEGMCf65OMzPpvG+JspaNcsk
 icx5Re+ZMgqPHNBs8J5krtfwEDo3/SQhTG3nJM+8sNaNRwvrh67sC7hfX3Znzrq7QAUP
 mf4cko2JrlrMY7GuIKlU9IZ9Kr3mqC/X6Fu2skkEaNTLQYGecAZhfNptUC1aqU2yENmZ
 W/lyvDYhbTCJiy901mOHO5CQIo2tFfBuzK+emJB/5YGow53hy55LRTWyhFyB8b7v+rzt
 uR4Q==
X-Gm-Message-State: AOJu0YzACWNwxyPFAsiXMIBdsmwPBHTBcfftb8hsX2bJYj0kpDYk5POb
 TQQpmVwwFW0ZxflaFoX3QkzjIGHUupFY2Hp6PPXXe73b+7WffDL81i2KM6p/zZf40SOSZ6X8T1Y
 H8nG0
X-Gm-Gg: AZuq6aKkdwdshrOejkQeiMT0VrHbO2gQYPq4TshT4SDM48ZY1TDDgpUE2pXcT7NJW2w
 IS3UjpfMxjjqwL7mdsN8ZDYyQTNsRa7GxzajwyBVP4dTURJnpKor3p2MKmrvVCU0DypZWtJG+Ew
 P4LEwN/6e2MsN31HK3x+rEgfD1kglCRYHeGCQYk0GAaD2wArsOCRoJY7nHvkO/QHUpE56GEZCGf
 C0KaMwmCxnSYcOm1Vc9cOXKIlfZX4fumG8m6Qqgnlxl8qoxsTZvq45gfrKIiXaZ7WGUDCR5YnBq
 87/I2kzA21cF7Hkzr8tMeElIHNWJhyMj8fNmd30VvnEy/pcrWP7xaQR0LtEmGlXpQMFtKw+8laq
 zdIaGMdAJ9g2JrOVCXNznvGrHDCCbq3FZvOUbPzp3TUhvGW6CJgUMay3EVa6K1H5HSrz789lJTu
 VCgz7rW179MzGD9yLtdRPjrtOVxNcmMadY702T+f8t1WQhcHHml2HadtEBSCjkgaW9oPNOjzHgD
 8d35Xuah2+pZBkuGLDaR/hm96v5uyM=
X-Received: by 2002:a05:600c:6912:b0:483:709e:f22d with SMTP id
 5b1f17b1804b1-4837108fc46mr350480895e9.27.1771497252205; 
 Thu, 19 Feb 2026 02:34:12 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/32] target/arm: Don't let 'sme=on' downgrade SME
Date: Thu, 19 Feb 2026 10:33:38 +0000
Message-ID: <20260219103405.3793357-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20260202133353.2231685-6-peter.maydell@linaro.org
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
index 5d7c6b7fbb..4d316f5a71 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -366,6 +366,16 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
 
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
@@ -378,6 +388,11 @@ static void cpu_arm_set_sme(Object *obj, bool value, Error **errp)
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


