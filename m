Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5F6E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Me-0007Dz-AK; Thu, 19 Feb 2026 05:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MX-00078d-Ow
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MT-00064s-TB
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:25 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483a2338616so1762605e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497259; x=1772102059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ohMJCnxM63AagK7D0igHWCyyjIwb/ZPxENrfJ55pD20=;
 b=Qcr0RFWic02MHJFpcOnFSVYqryyaAM/A4cb3sJ75n8xBScomDbIu3haOCj2R3PU60r
 kEPCUAZzNWKRJdrqxJ/XRX/wVYFWH90QzKcV0bt6YdKbWZxHsdakseOugufoi8RXlgwy
 f6iuZ5hYw2tpkyA3FFoshq0EyIdyDAy1YVlp0GcuwHt/IYyQ92l7lIK0Ch1PfDPhBGnK
 /OYPkfZdFvx2as9D/iC0583OB+GDZafR0z5n2tvuuvYr1vrJ49+yru+bn+oRPopQpAkI
 iQrCw6rlyACTMFw9TVeSPB5Lr2ImsNARfxg607Z2TXDc/nrlKyd8mfTKESp0Qy6RLY39
 IzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497259; x=1772102059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ohMJCnxM63AagK7D0igHWCyyjIwb/ZPxENrfJ55pD20=;
 b=qW2huDTzZXcYtvVLkfdsrAnWQKcsqgcTDOL9geJaYTwRNNGSEQJ191BnpYjhkEmqdv
 rvYLOJmrIKRGjjf1uhWOpU7W12/F2GCJtCy7EuB/XnAlDP40Gc6oc7QXHZ6CtC5xh3J+
 OCSx1u1oZZnbgVVSYJL/AfrsbxkfLd3OZ4dV8QS5eykeJqtxDgWqyyUsa5K/vHraHThx
 JI5TnzPorc+85c3TcVMIfE2lzoD6noxtRTf9wcHzeKq7DOKvNTfxNHHqs4gQZ+PJ+E+y
 sTAV3gn+XGeRBhi/cAHRPHNt/yWhALMImJJ5Ydo5lC33f2XSvJVt8DuOxq06GKA996xA
 C9kQ==
X-Gm-Message-State: AOJu0YwrFKFsK3hurl72arggauessGWiUhT1sizfG7WXbek0OAYN/Tur
 tV8RCKHJdoZYpBimNalsg8yRc5I8w1Y/Ooc+Qu4uNjx6DoirIrbRWCt9iHmd4KZvLV3uSdUh8Vs
 RAtV/
X-Gm-Gg: AZuq6aIG40l+G5VjpwWeeDwjJgGdF6WvHa7SseCx/4Ze0pd73wtHZ5WJ/WDnyvBWEMH
 QyX9SsMUOm594w8dB5c2pzcc9CRUngPk5o+DC3lf9JBKoGWsmIG7D3bF4ZKrLLbimGsSiDlcVHU
 hBmfXN0RgYIqxy5rG2BjyP6YI+uXXAqhPAESL4lP9Ul1KgBjBI+ZGWYiRhSd4S35XXuiSKMc2Rd
 cPtKt4AfjLFY+Y795uNOYbNyU0VCZNzxiNDz1tAr/X0uKqCJ61rR0CWus8PIrRZ5WP4XKyPxSGQ
 L7wnvVo38/ipn8ePFh2wz9E2W54MBjmO/5iHv8NMKm7bX86lJ/gt4E1PoNZA8LrsUvK0I4hApv7
 B956BCmV/w6s7ZDhAExnq31A1pvE50ENBcbpAfDb/jo0WjGeRLUej3Usak1Zkz+AMuREUa+brwx
 8VEyAFf/rYIXjY6W/VDxiRPxZJFuLaYMg+jX19S8PpmYAD/7GB+2ILhpMIeXRoQv5exH9numkBD
 tzfdohs40OaG9vdRyI1/Int+9OPEms=
X-Received: by 2002:a05:600c:198a:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-48398b5e372mr75019275e9.21.1771497259153; 
 Thu, 19 Feb 2026 02:34:19 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/32] target/arm: Don't squash all ID_AA64ZFR0_EL1 fields for
 non-SVE
Date: Thu, 19 Feb 2026 10:33:46 +0000
Message-ID: <20260219103405.3793357-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The ID register ID_AA64ZFR0_EL1's fields are not all for SVE
exclusive features; some are also used to describe SME on an
SME-only CPU:

SVE-only fields:
 * F64MM, F32MM, F16MM, SM4, B16B16, SVEVer

Fields used for SVE and SME (in some cases there is also a
field for SME in ID_AA64SMFR0_EL1, but it is just a "present
or absent" single bit flag and the ZFR0 field then tells you
what level of support is present):
 * I8MM, SHA3, BF16, BitPerm, EltPerm, AES

Currently we zero the whole ID_AA64ZFR0_EL1 register in
arm_cpu_sve_finalize() if SVE is not present, which wipes also the
fields we need for SME.  Only clear the fields which are SVE-specific
here, and clear the rest in arm_cpu_sme_finalize() if we
have neither SME nor SVE.

This requires us to update our ID_AA64ZFR0 field definitions
to match the rev M.a.a Arm ARM, as the F16MM SVE-only field
is not one we had a definition for previously.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-14-peter.maydell@linaro.org
---
 target/arm/cpu-features.h |  2 ++
 target/arm/cpu64.c        | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 83db3fd950..b683c9551a 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -368,12 +368,14 @@ FIELD(ID_AA64DFR0, HPMN0, 60, 4)
 
 FIELD(ID_AA64ZFR0, SVEVER, 0, 4)
 FIELD(ID_AA64ZFR0, AES, 4, 4)
+FIELD(ID_AA64ZFR0, ELTPERM, 12, 4)
 FIELD(ID_AA64ZFR0, BITPERM, 16, 4)
 FIELD(ID_AA64ZFR0, BFLOAT16, 20, 4)
 FIELD(ID_AA64ZFR0, B16B16, 24, 4)
 FIELD(ID_AA64ZFR0, SHA3, 32, 4)
 FIELD(ID_AA64ZFR0, SM4, 40, 4)
 FIELD(ID_AA64ZFR0, I8MM, 44, 4)
+FIELD(ID_AA64ZFR0, F16MM, 48, 4)
 FIELD(ID_AA64ZFR0, F32MM, 52, 4)
 FIELD(ID_AA64ZFR0, F64MM, 56, 4)
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4d316f5a71..b2be8c9fba 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -136,9 +136,17 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
         if (!cpu_isar_feature(aa64_sve, cpu)) {
             /*
              * SVE is disabled and so are all vector lengths.  Good.
-             * Disable all SVE extensions as well.
+             * Disable all SVE extensions as well. Note that some ZFR0
+             * fields are used also by SME so must not be wiped in
+             * an SME-no-SVE config. We will clear the rest in
+             * arm_cpu_sme_finalize() if necessary.
              */
-            SET_IDREG(&cpu->isar, ID_AA64ZFR0, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, F64MM, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, F32MM, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, F16MM, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, SM4, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, B16B16, 0);
+            FIELD_DP64_IDREG(&cpu->isar, ID_AA64ZFR0, SVEVER, 0);
             return;
         }
 
@@ -338,6 +346,10 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
     if (vq_map == 0) {
         if (!cpu_isar_feature(aa64_sme, cpu)) {
             SET_IDREG(&cpu->isar, ID_AA64SMFR0, 0);
+            if (!cpu_isar_feature(aa64_sve, cpu)) {
+                /* This clears the "SVE or SME" fields in ZFR0 */
+                SET_IDREG(&cpu->isar, ID_AA64ZFR0, 0);
+            }
             return;
         }
 
-- 
2.43.0


