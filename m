Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA6FFD006A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0o-0000V7-7e; Sun, 01 Mar 2026 09:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0d-0000OT-1Y
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0b-0005lH-Hs
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cz9b2qHIJZxeyAf7wx+q3kZGz28BSD7HKNGdvO+EqWo=;
 b=OMXPDb1vUUj5kAxg/zmM4C0aMw4hoVjC0+udiGssTLnC4vsFbAhgAmFDoHjzwd22wQ/GqZ
 bscAPdWO8MalCKodBHuxBAuGTFNULYeCELMlqnFbW0cht5trRh6XE4Na+KUU/NmeC/cXGS
 tgVUFwXIVAyBzfCbSMdoFIhjvgQeqIA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-kw-GXLJiOrumTnC-7tIAbg-1; Sun, 01 Mar 2026 09:42:58 -0500
X-MC-Unique: kw-GXLJiOrumTnC-7tIAbg-1
X-Mimecast-MFC-AGG-ID: kw-GXLJiOrumTnC-7tIAbg_1772376177
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837a718f41so18212105e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376177; x=1772980977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cz9b2qHIJZxeyAf7wx+q3kZGz28BSD7HKNGdvO+EqWo=;
 b=kZQEcJeMrZEIFfHO/QqoIDkQ0yoy0rr4HUbkhZbDIBTltfqKW/SgmW898JeEQTqLxN
 DY1JisusPOrjeApkJVTkuvK23QscLhh43mk+P/wOHGd2u+3Av4EJgtS4gmUkZKOgErO0
 JGd7DF4+e98LqXG/vPSp9Nydu4YRuh4VqDdaRMKL5CmnD3Myx7yGDKZKzSvPmgHc05LH
 8UC0TTYc/s2W1lEIuJQUwv/5ge92lPe4s4tTIQzBE5TmjkYkbt3DYlN6q5hhSQ5Bc3M0
 hv240i5+4T03P8YEFE3wyzn9ipFt1cA/OjZWgfuMhPxrHzz89SNKqpRuGBBwDrUcxPsl
 oBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376177; x=1772980977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cz9b2qHIJZxeyAf7wx+q3kZGz28BSD7HKNGdvO+EqWo=;
 b=NCR6TY+mvL+mKSWJPHtLCEqYgcBYghq7ZyqDz3eXq7YJ7dBgN2F23TRzPLMBNZE9Lu
 UWA39S7Q/rh7DK6LIvOzIummBbjmNMdDLiKDrdxdR9AFdskOSlvqE/bVl4cBR+T/3WIi
 OfAGklZ5Qtzac00BAoJAl4LLOCIsMm5vg5R7RQ089F1JEN4YF24D1KDqUA139vKoSXcm
 HFL1RYf+OulosXMnB6k35xe581xvkKhpny9FqHynlSgaZS1RdBmeA6TACLf2bVjjzYtC
 4XQwQc3wisn/oteb+zZl9AKwUlaPBpT1T/6zZQZa4Ldvd1f8k4JJ3VA65139KAgV1Hsa
 rKxQ==
X-Gm-Message-State: AOJu0Yyzg3RkWQ3q/DKZDjexxA4/8vrCkipMHh4pFA9Q0wQyCHomXLJG
 sqReyCrZObpASZZZFaNDQpwplWV8ddGZDbI4ucBCuoV7Xnrgjg26DfCSYLaRNgPD5W2LxC0ApIP
 4mpuI05Kc9M5RVEcrpthxPN4gnN+gZ+36Q7pvD6ufxWAfOvK9tg22NB354onAAZxN04g9Id03sT
 Z+ic9Og1I/myblbhAskn3ZpWpEe49/gIPVEb1hJXvX
X-Gm-Gg: ATEYQzwFFp+/vZ4+2h+k8xdO+jFNLdlajMZGEctxTKEuvwalepZk9M90jhPb7hXvVsg
 geWBoMooUMy1fNs2QIWe70MvDRDH/grQwE6XyMly8RlIm7E6ZQMsFAfjR5SowA8HdNGj5uSWMxa
 wJ/MG7PeyLFkxZY2oLOfk5MvhrzZ7KGG1VcFb89QKZh+hMsiDzDajgj0Q23YsYceGw8SF09kCc5
 l19Tx9xit3FlWNpl8/zD6bIBzbUZkWRfbjlo4D6L8gVvnsRCxi3zoWShb5zXuKbJyf046bDAmNF
 yDpGHVwI2/k+cSvytsv4ty7l7qVA28oheHF/3Mz01RLMJi9CcWkblYJuqkODmv0WYKGmQGqTLo/
 EwI6IjOy/VmbuQtHDMN70MeEohK3lPawB51gCno7aEMemYZ8vBo9qE4ZdmlneatcxHhGuOqJI8Z
 Hk3YsAhG8s9bqAeGCo4YDAO//yPeQ=
X-Received: by 2002:a05:600c:350d:b0:47e:e779:36d with SMTP id
 5b1f17b1804b1-483c9bc5721mr169878545e9.23.1772376176774; 
 Sun, 01 Mar 2026 06:42:56 -0800 (PST)
X-Received: by 2002:a05:600c:350d:b0:47e:e779:36d with SMTP id
 5b1f17b1804b1-483c9bc5721mr169878035e9.23.1772376176177; 
 Sun, 01 Mar 2026 06:42:56 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ae0e7abasm7920812f8f.23.2026.03.01.06.42.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/18] target/i386/tcg: mark APX as supported
Date: Sun,  1 Mar 2026 15:42:17 +0100
Message-ID: <20260301144218.458140-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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
 target/i386/cpu.c                     | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/configs/targets/x86_64-bsd-user.mak b/configs/targets/x86_64-bsd-user.mak
index d62d656f2c6..913d24139ab 100644
--- a/configs/targets/x86_64-bsd-user.mak
+++ b/configs/targets/x86_64-bsd-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_XML_FILES= gdb-xml/i386-64bit.xml
+TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index b093ab5a167..7a29bde6666 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -2,5 +2,5 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
-TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-linux.xml
+TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-linux.xml gdb-xml/i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 45f0b80deb0..f34515f5b2f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1001,7 +1001,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
 #define TCG_7_1_ECX_FEATURES 0
-#define TCG_7_1_EDX_FEATURES 0
+#define TCG_7_1_EDX_FEATURES CPUID_7_1_EDX_APXF
 #define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
@@ -1550,7 +1550,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
-            XSTATE_PKRU_MASK,
+            XSTATE_PKRU_MASK | XSTATE_APX_MASK,
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
@@ -9424,6 +9424,17 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      * inside x86_cpu_parse_featurestr() too.
      */
     if (xcc->max_features) {
+        /*
+         * TCG supports both MPX and APX.  Since they they cannot be enabled together,
+         * disable one---prefer APX if none was chosen explicitly.
+         */
+        if ((x86_cpu_get_supported_feature_word(cpu, FEAT_7_1_EDX) & CPUID_7_1_EDX_APXF) &&
+            env->user_features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX) {
+            feature_word_info[FEAT_7_1_EDX].no_autoenable_flags |= CPUID_7_1_EDX_APXF;
+        } else {
+            feature_word_info[FEAT_7_0_EBX].no_autoenable_flags |= CPUID_7_0_EBX_MPX;
+        }
+
         for (w = 0; w < FEATURE_WORDS; w++) {
             /* Override only features that weren't set explicitly
              * by the user.
-- 
2.52.0


