Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F1BD3C546
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4E-0004oW-S7; Wed, 10 Dec 2025 08:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK42-0004lt-0B
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK3y-0002xX-53
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jBtFYWwdIR8B69gtY/Q+wADcN5do127ZO/G3eZnzAQ=;
 b=BiSRCmPOOdl4YTZ5o4W10uMLTPWf1CWhi8J4S8KTrP0zBK0rlnnRZku6iqpvCee7ANjwPh
 nKe6wQPo2YCdW7CVKVPaC2Dx8zsJwm1MMd6KggtIMVU7Tq3TK+wd/D855tmvba3u+upSh1
 jJhRpxpMloTBHZqSMALTlsLWWG0GMU4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-4Yw7rOD0OpmXr2uiWTcM1A-1; Wed, 10 Dec 2025 08:16:59 -0500
X-MC-Unique: 4Yw7rOD0OpmXr2uiWTcM1A-1
X-Mimecast-MFC-AGG-ID: 4Yw7rOD0OpmXr2uiWTcM1A_1765372618
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42e2e3c2cccso5060653f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372617; x=1765977417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6jBtFYWwdIR8B69gtY/Q+wADcN5do127ZO/G3eZnzAQ=;
 b=EoP3+rp+BKk0BfB4FNqUgkB+ARfPlXNDwVDZfnDwa4R8GNQSJEYxOY8G6ZnT/c7knw
 ltoLJZ4znwXFjxJpyFgB8JgvgCRYH/2wwMP0ZHHzcLM2so+qyrwZVbOvt+TXv4VmRTtJ
 DMyFoq60R5po9XRQ5SxPnveVab/wqT+tLRg2DgWqQFM1dHf0agmPVVeWIEaamYN/wHh5
 VxQsLylhdZoC+84NhM/GHHgvAWjXpbJAzFqDDhK3r0OCJfoJNELxkrHxiIcbl2jecCpW
 t4wISW7aKSi9FHl7RR8N+n+A3j50oL7eZOXrYFEXxIoOEHQ681dL//jiHnndUvEo916s
 uqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372617; x=1765977417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6jBtFYWwdIR8B69gtY/Q+wADcN5do127ZO/G3eZnzAQ=;
 b=l47QelvMdMqsLM2pJJUGKtlTEQ6iqjagzrzpiVZy1IiWE+hmr9w7Ivs+CBIeYj3C3q
 NszY5gjsFtY7OIbS2m4S8ux2O+o2gqz/vfJkgAJ9S2XhDnPcd3tPQz5+xeLKcX6w+1l2
 qgtVfgKi6EiYZENtvvSvp5OdaYv3VikppY8Dki6txeGty1nIsaUPfeQUwI2KiFjkHZJZ
 dO9hQ5qlw/9JwUxAOlBk40GnfETz82JeesVSvWfH+7x89X3TI//cuB3xvsjRtqRn5xVx
 1Tk4yvA7yHroKVAq81BjXslTUInmDWkFPBkYynhY7taXDxshJej3EldRfNI3jJ5oxAR7
 575Q==
X-Gm-Message-State: AOJu0YzbLF7Sr4CtgEh8XL4z6kITJrDedARGyIC96lDiXsQS93XMOtF3
 lfc+gMoox7XmrfQE/re3Cj5fqj0Zs78l/gwQkJ3Rd4LMbK/wZS6/6taVpJ8AlIkupOYGoP7VZe+
 MsEKIOKOSasR2cwsTawJMvnVtWvMjV3f7G2yP5MECbv/bQ0EiiIUxW4pT2HioEepuIVDEV7wvlh
 ODFvITnBR96OjrgYvHlkzJCPfvluzAJWxgxUm/sbfu
X-Gm-Gg: AY/fxX7hDB7PZgMweaV3siyZoB22dMxlm/dA77YHsVcGb7eAUqkXp+trliSFZsPgwi1
 zl1rEpfFRMGCTOs/QCnZKxr0d5wVmoOIslGVc6aitfdKsLIsTEO6s/c/VuxjsZEWY4uOV1LPBkz
 94DAoD8xAvOZPxpjNDNxm1luvcjGSkUfMooUmtJSxK5s3lqlku2iY6ZLQ+WIiD8sTwo4nkx4V9k
 ARtYJG+ejtg3T/CQmhNzwliAYTKzAmDWTCh8ONQtx5oQwAAwlCQTX43gaJINjpseB/sPPRICmlY
 FBCaCXOS/MQy1M8yMknm1kDUw6k9LEMCR5s4Ft0ZeU+vKK+H7impRi2NLMUM/ScJFAae/9YHErs
 j+wJBKzKNx8gynfHwmFdl1q+fGil6ax3/fjb0NzfxISSNwb2KGuCbn3J9Ra+t5orqm+twymr08L
 eMtJ2MilUGNAJhoHk=
X-Received: by 2002:a05:6000:2681:b0:42b:3592:1bbd with SMTP id
 ffacd0b85a97d-42fa3b01833mr2554515f8f.33.1765372616661; 
 Wed, 10 Dec 2025 05:16:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbGGucd7hsJVDgYg8QHJJt4D+DnO+e1hdzwo1iqeAfjMbXjAXPZKkNDNNUwr4QrrHdOFCdiA==
X-Received: by 2002:a05:6000:2681:b0:42b:3592:1bbd with SMTP id
 ffacd0b85a97d-42fa3b01833mr2554483f8f.33.1765372616127; 
 Wed, 10 Dec 2025 05:16:56 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d352a52sm38531284f8f.38.2025.12.10.05.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:16:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 01/18] target/i386/tcg: fix check for invalid VSIB instruction
Date: Wed, 10 Dec 2025 14:16:36 +0100
Message-ID: <20251210131653.852163-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VSIB instructions (VEX class 12) must not have an address prefix.
Checking s->aflag == MO_16 is not enough because in 64-bit mode
the address prefix changes aflag to MO_32.  Add a specific check
bit instead.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  3 +++
 target/i386/tcg/decode-new.c.inc | 27 +++++++++++++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 7f23d373ea7..38882b5c6ab 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -181,6 +181,9 @@ typedef enum X86InsnCheck {
     /* Vendor-specific checks for Intel/AMD differences */
     X86_CHECK_i64_amd = 2048,
     X86_CHECK_o64_intel = 4096,
+
+    /* No 0x67 prefix allowed */
+    X86_CHECK_no_adr = 8192,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0f8c5d16938..0b85b0f6513 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -623,10 +623,10 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x46] = X86_OP_ENTRY3(VPSRAV,      V,x,  H,x,       W,x,  vex6 chk(W0) cpuid(AVX2) p_66),
     [0x47] = X86_OP_ENTRY3(VPSLLV,      V,x,  H,x,       W,x,  vex6 cpuid(AVX2) p_66),
 
-    [0x90] = X86_OP_ENTRY3(VPGATHERD, V,x,  H,x,  M,d,  vex12 cpuid(AVX2) p_66), /* vpgatherdd/q */
-    [0x91] = X86_OP_ENTRY3(VPGATHERQ, V,x,  H,x,  M,q,  vex12 cpuid(AVX2) p_66), /* vpgatherqd/q */
-    [0x92] = X86_OP_ENTRY3(VPGATHERD, V,x,  H,x,  M,d,  vex12 cpuid(AVX2) p_66), /* vgatherdps/d */
-    [0x93] = X86_OP_ENTRY3(VPGATHERQ, V,x,  H,x,  M,q,  vex12 cpuid(AVX2) p_66), /* vgatherqps/d */
+    [0x90] = X86_OP_ENTRY3(VPGATHERD, V,x,  H,x,  M,d,  vex12 chk(no_adr) cpuid(AVX2) p_66), /* vpgatherdd/q */
+    [0x91] = X86_OP_ENTRY3(VPGATHERQ, V,x,  H,x,  M,q,  vex12 chk(no_adr) cpuid(AVX2) p_66), /* vpgatherqd/q */
+    [0x92] = X86_OP_ENTRY3(VPGATHERD, V,x,  H,x,  M,d,  vex12 chk(no_adr) cpuid(AVX2) p_66), /* vgatherdps/d */
+    [0x93] = X86_OP_ENTRY3(VPGATHERQ, V,x,  H,x,  M,q,  vex12 chk(no_adr) cpuid(AVX2) p_66), /* vgatherqps/d */
 
     /* Should be exception type 2 but they do not have legacy SSE equivalents? */
     [0x96] = X86_OP_ENTRY3(VFMADDSUB132Px, V,x,  H,x, W,x,  vex6 cpuid(FMA) p_66),
@@ -2435,8 +2435,8 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         break;
     case 12:
         /* Must have a VSIB byte and no address prefix.  */
-        assert(s->has_modrm);
-        if ((s->modrm & 7) != 4 || s->aflag == MO_16) {
+        assert(s->has_modrm && (decode->e.check & X86_CHECK_no_adr));
+        if ((s->modrm & 7) != 4) {
             goto illegal;
         }
 
@@ -2740,15 +2740,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
         }
-        if (decode.e.check & X86_CHECK_prot_or_vm86) {
-            if (!PE(s)) {
-                goto illegal_op;
-            }
+        if ((decode.e.check & X86_CHECK_prot_or_vm86) && !PE(s)) {
+            goto illegal_op;
         }
-        if (decode.e.check & X86_CHECK_no_vm86) {
-            if (VM86(s)) {
-                goto illegal_op;
-            }
+        if ((decode.e.check & X86_CHECK_no_vm86) && VM86(s)) {
+            goto illegal_op;
+        }
+        if ((decode.e.check & X86_CHECK_no_adr) && (s->prefix & PREFIX_ADR)) {
+            goto illegal_op;
         }
     }
 
-- 
2.52.0


