Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C357CC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqIE-0004uH-3e; Tue, 25 Aug 2026 08:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqIB-0004py-OY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqI9-0000kU-SD
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787661013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16X1xBZPA6wfWb+bX9FtyS6bqUNIjSAl6ADzdUkrS7A=;
 b=CDUzXdRCJ7JCA0WqJtsd7kCKWoAFQ6dDycPSOK8/8c2GSLQ0fSRh/O1+zn0xaNddiOkbrX
 f75gibvusp3scOlwamBZK8qrhcwfvRr0Jtn9QEazF5Ux2+lYHqjthOGOdzSO/nYXWpaLML
 oltV3rQD6+m8YzARcdG3uOBYnEPOFeM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-ULYaGZ43O4a9HRuHo2lL5Q-1; Tue, 25 Aug 2026 08:30:10 -0400
X-MC-Unique: ULYaGZ43O4a9HRuHo2lL5Q-1
X-Mimecast-MFC-AGG-ID: ULYaGZ43O4a9HRuHo2lL5Q_1787661009
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c15fff01a30so295113766b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787661009; x=1788265809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=16X1xBZPA6wfWb+bX9FtyS6bqUNIjSAl6ADzdUkrS7A=;
 b=WlOUiMzfxTIPDec1fhzH7BkYI59ogoeqhoHYW4o37SgbiBWVT1KH6sPkeTBOeZS7NG
 lkwgg8N9+4TtbLxxX/mO4E7rhlaEoMYVFtZhLH8eGhrsELy1iRa2jgnyWQartP2eIZtx
 vgr/voiczbnQcMRtNOBKpMGImtvH0XfLNlERKvAtfwXBE9r8dXJVU+xRN+2a/2hG1qTP
 ycdXf/YNuEyXM+RmBVq40M97yZmR0riGonpIzbXbJlcM2BFdP4WgKPFFnthrCCJRIqzX
 shxdQciE2WZ53zDw0afbjZT+0RSFkAVOh788MWmhZLMs3EYUOrwRMQnDF/OOsbP4P8sJ
 PG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661009; x=1788265809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=16X1xBZPA6wfWb+bX9FtyS6bqUNIjSAl6ADzdUkrS7A=;
 b=NmFcEF0enk4GSfbLDb4Lr7SlWH/Map3fqhmylfkEMoDCT2qeo8l9Zo+5kfmN67eGvA
 RnQjqYZhGQbrnwjpISEHBRHHtxN1MzD/wkqzbm01OI+/9QTYxRQ5kc8hekZkxSnGd8c5
 R4R6QIHVdtAOzITVf5DP1Af7oEiJwfAK10bI+3p8gPN1pGvA01Nh/b4dPcqaCZPHoFuP
 ITHW5WZ+g/eqzl685WMD3A/1wHYqaNDsO0szxEF+2Id2UxexsOgllUS1nyFqLeG2PN9+
 eMnDoILmfTVC4UvS470q6cQXkFSHWw+BEwAc5EQ/ZeD3DjDDQoKbOMS299kL0rqLdCHo
 Iacg==
X-Gm-Message-State: AFuF++mYIhu4Yk68ty49PSlkLk3XKvwUPVkipYSWbrzumKQZF1wG1Fvo
 ubyHwUlBd9PvdxYoCC+ZKA0udmcMYT9pVIv+YH26YbWPaA/tltgM6jyoE1Y4bv23OwHUGyoViyr
 PUJaAbey8BxI6EcVxQbTiQ6UnuPb85RUlO6GEqvvkVA5/oC0sYiRlOx2tNDznnIfhOBHKJQsdBW
 ujcmxJAxGMGqmeLREFt1LF6KBN9GYtm0vaCXIDdtHT
X-Gm-Gg: AR+sD123esPk2gAYokONalXB6eg1JxVNaNeeXzfdBRfCyn1TRFzxcOLtAvMv3aoajtO
 Bz7vFjw5bDHivFe45lufT0xfG9nJX9xxH1iqh/6PqnSE1XcQEM7hRjJc0eUFAm7Kvcn7+n5cxYP
 Z80gTfq+4ANgGgUZo+ujlnrWzk3gMRto49E6qaNg8k/VVEVlq4CShPU3XYBYzpvBHmah47Tlqhc
 NB0yqhgH84Nk8dyUyRp1EhZpOHcOlqo3PyASKv5G5lhGWIo761vdPaY/gmV86ZWwa8G1NIEIrCh
 JU3yogObyy2qVZvaxiAAHEy7SbyGtTO/8EiQkZ6Ka9zHw3pwhdhJH0z/bELxN/1ogyiGfoFjzN9
 btWvafBgvHdJFEsO4z8tyWxyBxF7fTySLRAg1K6Q79xJArc5k7pjzUk7404jyDgP2s4eWb8tY94
 xkSw==
X-Received: by 2002:a17:907:1ca7:b0:c20:33db:41d3 with SMTP id
 a640c23a62f3a-c24e5ade69dmr729784766b.11.1787661009380; 
 Tue, 25 Aug 2026 05:30:09 -0700 (PDT)
X-Received: by 2002:a17:907:1ca7:b0:c20:33db:41d3 with SMTP id
 a640c23a62f3a-c24e5ade69dmr729775066b.11.1787661008801; 
 Tue, 25 Aug 2026 05:30:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496738e8bsm1693574966b.44.2026.08.25.05.30.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:30:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/20] target/i386/tcg: mark APX as supported
Date: Tue, 25 Aug 2026 14:29:20 +0200
Message-ID: <20260825122921.431739-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 target/i386/cpu.c                     | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

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
index e5ffb10d156..e966bd8049b 100644
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
@@ -1554,7 +1554,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
-            XSTATE_PKRU_MASK,
+            XSTATE_PKRU_MASK | XSTATE_APX_MASK,
         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
@@ -9722,6 +9722,17 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
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
2.55.0


