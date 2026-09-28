Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDEACA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB2w-0006ld-Ie; Mon, 28 Sep 2026 09:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1X-0005nH-Sb
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB1W-0004Sp-5a
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3LJcrFsY6gDI05Rg2w/j7BQ0U1fMQIzC7scyP9KnJQ=;
 b=R/qCTBMgY/Qgo3MQPIoY//6C4JFg/ge8MV8/I3i3qDtxGuDHjLIrOnNDFrBOfAptdEdO7b
 Y3GPyovTwOz6/NVUSFVYJ0SYJ8pLeTvh/4Vn8+Br5T8d1wz691QngVsmltxN6jN7ZnyXEl
 6Jt7Xwcbj1N9DezY8r8zkkZe3mnA4KY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-mTnJxWE6NWWJ2C26bQz3Wg-1; Mon, 28 Sep 2026 09:03:59 -0400
X-MC-Unique: mTnJxWE6NWWJ2C26bQz3Wg-1
X-Mimecast-MFC-AGG-ID: mTnJxWE6NWWJ2C26bQz3Wg_1790600638
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso33158475e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600638; x=1791205438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F3LJcrFsY6gDI05Rg2w/j7BQ0U1fMQIzC7scyP9KnJQ=;
 b=S6zlsQIbiU8XzpiXqsls3g0aZL462XV6FVMYNmQTc2yJV3xxdgtrt0noFwhqkh4DkJ
 XCwNFSPRkmQegjJeEn0eGKpkz9vk+1xbuDGThfTOOP7Z7IVy1QFyTAUhjih1GAt5ogOe
 ehXBiO8Xr4WLQwlhyD7WPttBNMmro+S/a/XPVafWlXduMeV5MxvOJ6oCuq/j7zrgQNO/
 MoLuU5I2OQGs53ef6Tntw3jzJRswXj3E9Yhcwl5A0+LnLRIerWq70pp0Oie3yJW/T7Sl
 4jsuXYzGZdx8Cw15EiIQuUFHs/kh6ynfq3o4IoDL8B5YuILjHGUqlIjmIn90VEsVnO+x
 BAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600638; x=1791205438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=F3LJcrFsY6gDI05Rg2w/j7BQ0U1fMQIzC7scyP9KnJQ=;
 b=WXiRRSW65r1Oxoh9GqVZYYpjvtkX8UGKU43BMI7BTRCXJwr14/aXHMKEhdJmKUbajL
 SHOKJqjjxtrLjHca7T0IcBQuYxRdiHg6glydHBj+sXN1ECjXxqAsaH+/O9cGudZCch6/
 ApvHFHq9m9Hq+C4vg/Vn4iV0kZL5WW/9XXxCZeKYInMIeXP2hZcWeMNd/hofO/PYeRfe
 UxZD9zVAYCxOZnAY3uoiU15m5F9whzu2BWemHNztsiRnHnWI6eMGMxrOUL1Qq/qDtSDl
 n5pyVIuo0Q+8TNmzyy7VliI7uJwtMxxeiyYnAE55rhJplGhM1Hx7YnwaaORx3HYVN39q
 /oiw==
X-Gm-Message-State: AFuF++mk4r3cy32M7YZd1z1mOxbyrZJ3dTLO6+/EZGhHA7R6QaSOEJow
 Qi6niuOfV6kfgR1wnBoXpz8ys04tSxB+5JoFbwtntMhF2vzLaJsFZSJ25x6Sdog2weZyijZXUDG
 1ay+RJ+KZNo9JRW+yyg/H/dAm2KAjh7t1kPpkn33dbM+4aO1BuYvs5adclHJSurEanvJQOO8DMA
 hMeZhO6Yqxtiu5CKQQP8zIBgJP3lMu8tAzBCI/btEE
X-Gm-Gg: AYBFou1SytpxEZe+fYJJWl+HmBiqEJr0CYd0BU4VcRx4eLSiicmE8rxRcD8R780Tjj8
 5YIUHvgJb5suDpxaEIQ9eEfo2caHFN4KY+Afi8q8ZSCEyklwKESWIRj8s4VvW3AY04NInpeNK1l
 OizfYyMP7Rmq597t+4Uqrmipxhnr7SLh8zxiIP3Y8O7ZRoKVx3/0GQ8oQ+Vx5/OjUgXopQLkMWc
 VFVs4MtfxdLaSA7K9fCrAA0DzGy7uAg5GxBkf0FMVIrcVnM5ch086wvClR2cihpGbtxpa0tqN1p
 cV+FbqWG2yCUc1G/YYzbA3YfW0YHne7tXRPPNXAOSX1hAePj5aFMfKwFfKLIBKlT1Bh0o8QDSQz
 E2JItwqOw3E0Ltb7VYaM8qnB0cA+KfMg3Y6mk8x7rpdbppmXg6IVpmdkhS9igcYThn6WJTQoxVS
 gOU86a
X-Received: by 2002:a05:600c:5493:b0:4a0:2c6:165d with SMTP id
 5b1f17b1804b1-4a002c618b1mr60316075e9.5.1790600638308; 
 Mon, 28 Sep 2026 06:03:58 -0700 (PDT)
X-Received: by 2002:a05:600c:5493:b0:4a0:2c6:165d with SMTP id
 5b1f17b1804b1-4a002c618b1mr60315515e9.5.1790600637736; 
 Mon, 28 Sep 2026 06:03:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00c075b59sm2545695e9.0.2026.09.28.06.03.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/30] target/i386/tcg: mark APX as supported
Date: Mon, 28 Sep 2026 15:02:27 +0200
Message-ID: <20260928130228.877003-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Finally allow TCG to set the CPUID bit for the APXF feature.  The effect
of APX is about 0.5% larger binaries and about 1% less TCG ops.
QEMU seems to produce about 1% *more* assembly instructions, because
the optimizer could already produce roughly the same ops as NDD or
NF instructions, and the new PUSH2/POP2 instructions include a stack
alignment check that isn't there in non-APX code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/targets/x86_64-bsd-user.mak   |  2 +-
 configs/targets/x86_64-linux-user.mak |  2 +-
 target/i386/cpu.c                     | 34 ++++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/configs/targets/x86_64-bsd-user.mak b/configs/targets/x86_64-bsd-user.mak
index d754186347f..26b7cfad4e2 100644
--- a/configs/targets/x86_64-bsd-user.mak
+++ b/configs/targets/x86_64-bsd-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_XML_FILES= i386-64bit.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index 7f9527fd1de..cad68746bdb 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -2,5 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
-TARGET_XML_FILES= i386-64bit.xml i386-64bit-linux.xml
+TARGET_XML_FILES= i386-64bit.xml i386-64bit-linux.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b6ad69d5047..62cce7d3105 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1005,7 +1005,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
 #define TCG_7_1_ECX_FEATURES 0
-#define TCG_7_1_EDX_FEATURES 0
+#define TCG_7_1_EDX_FEATURES CPUID_7_1_EDX_APXF
 #define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
@@ -1017,7 +1017,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 #define TCG_24_0_EBX_FEATURES 0
-#define TCG_29_0_EBX_FEATURES 0
+#define TCG_29_0_EBX_FEATURES CPUID_29_0_EBX_APX_NCI_NDD_NF
 #define TCG_1E_1_EAX_FEATURES 0
 #define TCG_24_1_ECX_FEATURES 0
 
@@ -1554,7 +1554,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
-            XSTATE_PKRU_MASK,
+            XSTATE_PKRU_MASK | XSTATE_APX_MASK,
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
@@ -9722,9 +9722,37 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      * inside x86_cpu_parse_featurestr() too.
      */
     if (xcc->max_features) {
+        /*
+         * TCG supports both MPX and APX.  Since they they cannot be enabled together,
+         * disable one---prefer APX if none was chosen explicitly.
+         */
+        uint64_t feat7_1_edx = env->user_features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF
+            ? env->features[FEAT_7_1_EDX]
+            : x86_cpu_get_supported_feature_word(cpu, FEAT_7_1_EDX);
+        uint64_t feat7_0_ebx = env->user_features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX
+            ? env->features[FEAT_7_0_EBX]
+            : x86_cpu_get_supported_feature_word(cpu, FEAT_7_0_EBX);
+
+        bool apx = feat7_1_edx & CPUID_7_1_EDX_APXF;
+        bool mpx = feat7_0_ebx & CPUID_7_0_EBX_MPX;
+        if (apx && mpx) {
+            if (env->user_features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF
+                || !(env->user_features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX)) {
+                mpx = false;
+            } else {
+                apx = false;
+            }
+        }
+
         for (w = 0; w < FEATURE_WORDS; w++) {
             /* Override only features that weren't set explicitly by the user.  */
             uint64_t no_autoenable_flags = env->user_features[w] | feature_word_info[w].no_autoenable_flags;
+            if (w == FEAT_7_1_EDX && mpx) {
+                no_autoenable_flags |= CPUID_7_1_EDX_APXF;
+            }
+            if (w == FEAT_7_0_EBX && apx) {
+                no_autoenable_flags |= CPUID_7_0_EBX_MPX;
+            }
 
             env->features[w] |= x86_cpu_get_supported_feature_word(cpu, w) & ~no_autoenable_flags;
         }
-- 
2.55.0


