Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49837C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Yzd-0006A1-5t; Mon, 07 Sep 2026 09:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YzX-00067r-BT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YzV-0004zz-A0
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4956869750eso30824205e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788786148; x=1789390948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BjmanBQ6cdorW9qdGQW5sVUyC1W6a6RSIT+PlHeq248=;
 b=XBTYi+cDx8T1qaduZQJqvI5nNO2AlilAAZED0LuKI3NqptyqcOJVJq8C7zkRSW7bxz
 zZMmo2YixJsJ8VRUBvgk5ZvYOkVVHs0avuZaH05XAKIThfAVr3tXBGJxbxtjjQGuPiQc
 OpAvEU2rgP3BlDDao8RiWapkx4wqPbRDBdTIMT1bS7rFk8EvEevVjQoKw6wKZtIm3Dei
 Gqfxa2YUBz+XaECx2OezKbXW4CpW6XbOiWuruzmR5OKd21EvfabWJSdBZCtApLu7xBVx
 pgk0A/pSwNKo2rWeJt5xFkSecpUt4TSyHmj8FB9UnyzjXDBvPdMBqcTUP+JXf7eHW2Mj
 b08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786148; x=1789390948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BjmanBQ6cdorW9qdGQW5sVUyC1W6a6RSIT+PlHeq248=;
 b=sln7Zh/ghUICIjAqWbRn5RgaCk/Y/RCfNOSpuMvHMrGq46AQ0d6MdiwGcr4tiJNrnI
 gGBDc1KGtYRehGc8jWlIczKEOHh+iOIIc1thKe9VgsHsnipKvH8m4VT0jNkRKfjVrDMU
 elz8yEgj3D6pUNgTCvL6vxu2++ZGnC5kyubSCruRZIYsYj4JghBkKw32XOrkCZtWqlcn
 +BruNyzlx54zOEk/xSJ9diSg8tsRg41je3G97wGl7k8dSQcaOecsyjmsfOBmgMRpphEe
 eR7D1aPJWxsD7LYyFWT7JPV+vbMSPsR7q4t0yfnwtngDZFpEHiYQnoPUlba9wLlj8VK1
 3t7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMbFTEOFimBv5dNnpmTfjS+WJaDs+nFZgelPUFG3sNe4bTlawcu4W1zLsJ7TH4bGuvnuOHPdQh11E9@nongnu.org
X-Gm-Message-State: AFuF++ncVd26Qw/wbBIxepFka3NHhxGGnbIE0LclXqHnbWQtnQnsSEjw
 eyKmGjY8wh8QMm8F6UR6+f3QucXQeSFk8yjeHIl3p7DOPto4bwC8rGe7OD8AC5xu7vQ=
X-Gm-Gg: AYBFou011DVydmrNtI9ujwJdFxHJFt+W4FF5TVo/xz1rNZRy9c6uL4rUWBHGoKdomrR
 Xb0ekBhE6pc5eWUfu15KaGtHshTwZnKnzYG8g9Ibf1dVHpGlIAim41mBm9xHby8rYTHEj/cPrzX
 Ilj0SHL0JC5jvNuWV85dnlmY8dK7EBYY70Ila5Gh9Z9IVKOZ+xLCuehx0Hw5P3j2YTd7l1Xez5K
 fNw2Oe0sXwiAgiNnH1L0qrhNFT7juyW3Lhw4x12UJ9mxZKbCL6bc6cR75/Si4V5ljRqrP+cLwE4
 /j4rlarwgzZjjIPNo77kiZCiOw39XH7fGhcz+XWcfXhCCgfpGG9q1nbJvk8AWB773TLPBh5NzYH
 TbIvpPTNMYKxSsxdDWO8Q/dtrSqZo++0gg+Jdjw62brQ8dnf4W8nlOgQ5fpK2sskE9r57Tzbb10
 W+on0931witVL2v/SbVKV45N7pzTqI485icoXQfS9PyghtYcbIylTCjcL4XF94FyDSArfR8uVh1
 D+vS734je1Bq9J9e8gFkB/gSOnmw7USxuRQe6eVvim7fsUqREQFp8ZxPaAaeg3hAjUG+A==
X-Received: by 2002:a05:600c:3495:b0:49c:dadb:18a7 with SMTP id
 5b1f17b1804b1-49cf8244260mr225172095e9.10.1788786147628; 
 Mon, 07 Sep 2026 06:02:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm468589935e9.9.2026.09.07.06.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:02:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
Subject: [PATCH 2/8] target/arm: Don't assume secure-banked registers are
 migrated by 64-bit regs
Date: Mon,  7 Sep 2026 14:02:17 +0100
Message-ID: <20260907130223.3148989-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907130223.3148989-1-peter.maydell@linaro.org>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In add_cpreg_to_hashtable() we have some code that automatically
marks the secure version of an AArch32 banked cpreg as ARM_CP_ALIAS
under two conditions:

 1) If the register has both 32-bit and 64-bit instances then we can
    count on the 64-bit instance taking care of the non-secure bank.

 2) If ARMv8 is enabled then we can count on a 64-bit version taking
    care of the secure bank.  This requires that separate 32 and
    64-bit definitions are provided.

Item 1 is correct: if the ARMCPRegInfo has ARM_CP_STATE_BOTH then we
will always add it as an AA32 entry (which then splits into an S
entry with bank_fieldoffsets[0] and an NS entry with
bank_fieldoffsets[1]) and as an AA64 entry (which uses
bank_fieldoffsets[1]), so the AA64 entry will always be present to
cover the NS banked AA32 entry.

Item 2 is not correct: the idea was that because typically AArch32
Secure banked registers are (non-architecturally) mapped to EL3
AArch64 registers, the AArch64 EL3 register would handle things
(and that we would be adding the AArch64 register to the hashtable
even if the CPU didn't have AArch64).

However, this fails in several cases:
 (a) registers like CSSELR, where there is only a CSSELR_EL1, and
     no _EL3 version. CSSELR_S's underlying state isn't migrated
 (b) registers like TPIDRURW, where the secure banked register
     isn't mapped to any AArch64 register, so the state isn't
     migrated
 (c) IFAR_S and DFAR_S are odd special cases, because they map to
     AArch32 HIFAR and HDFAR, which in turn map to AArch64 FAR_EL2.
     If the CPU doesn't have EL2, we don't register FAR_EL2 and
     the IFAR_S and DFAR_S registers don't get migrated.

More generally, the architecture dropped the concept of documenting
secure AArch32 registers as being "non-architecturally mapped" to EL3
AArch64 registers and relegated it to an implementation detail, which
is why TPIDRURW and friends got mishandled.

It also conflates "has 64-bit registers" with "is ARMv8", which is
wrong for the qemu-system-arm "max" type and for any AArch64 CPU
started with "aarch64=off".

Instead of marking the S-banked register as an alias if
ARM_FEATURE_V8, don't put it into the hashtable at all if
ARM_FEATURE_AARCH64 is present.

There are not all that many banked registers, and they're easy to
find by searching for regdefs that set bank_fieldoffsets:
 DACR, IFAR, DFAR, IFSR, DFSR, CSSELR, MAIR0, MAIR1,
 TPIDRURW, TPIDRURO, TPIDRPRW, TTBR0, TTBR1, TTBCR, TTBCR2,
 PAR, VBAR, SCTLR

None of these do complicated things on reset, so having both an
AArch64 view and an AArch32 view reset the same register state to the
same value and migrate the same data twice is harmless.  This is
better than sometimes not migrating or resetting it at all.

This changes the set of cpregs we will try to migrate for CPUs with
ARM_FEATURE_V8 but not ARM_FEATURE_AARCH64, and is a migration break
there.  However, the only such CPUs are the qemu-system-aarch32 "max"
CPU and AArch64 CPUs with "aarch64=off".

In an ideal world we would also not bother putting the S cpreg into
the hashtable if the CPU is AArch32 without EL3 (i.e.  it doesn't
implement Secure state at all), because nothing will ever look up the
S version of the register (access_secure_reg() always returns false).
But that would be a migration compat break for those CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c3f607e6d6b..1b024adc703 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7787,18 +7787,33 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
         if (state == ARM_CP_STATE_AA32) {
             if (isbanked) {
                 /*
-                 * If the register is banked then we don't need to migrate or
-                 * reset the 32-bit instance in certain cases:
+                 * If this is an AArch64 CPU then AArch32 cpregs are never
+                 * banked, and if we put an NS version into the hash table
+                 * it would never be accessed (compare the condition we test
+                 * in access_secure_reg()). So drop it rather than adding it.
                  *
-                 * 1) If the register has both 32-bit and 64-bit instances
-                 *    then we can count on the 64-bit instance taking care
-                 *    of the non-secure bank.
-                 * 2) If ARMv8 is enabled then we can count on a 64-bit
-                 *    version taking care of the secure bank.  This requires
-                 *    that separate 32 and 64-bit definitions are provided.
+                 * Ideally we would also ignore the S banked register here
+                 * for an AArch32 register without EL3; however, that would
+                 * be a migration compatibility break for those CPUs, so we
+                 * continue with having the cpregs in the hashtable.
                  */
-                if ((r->state == ARM_CP_STATE_BOTH && ns) ||
-                    (arm_feature(env, ARM_FEATURE_V8) && !ns)) {
+                if (!ns && arm_feature(env, ARM_FEATURE_AARCH64)) {
+                    g_free(r);
+                    return;
+                }
+                /*
+                 * If the register is banked then we don't need to migrate or
+                 * reset the 32-bit instance if this is a STATE_BOTH regdef.
+                 * This is because we can know for certain that there's a
+                 * 64-bit regdef that's using bank_fieldoffsets[1] as its
+                 * fieldoffset, because the code that handles STATE_BOTH
+                 * always registers it. In other situations either the NS
+                 * or the S banked register might be aliased (architecturally
+                 * or non-architecturally) to a 64-bit register, but it might
+                 * not be. For those we must manually mark the alias in the
+                 * regdef struct if we care.
+                 */
+                if (r->state == ARM_CP_STATE_BOTH && ns) {
                     r->type |= ARM_CP_ALIAS;
                 }
             } else if ((secstate != r->secure) && !ns) {
-- 
2.43.0


