Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F84BC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHo-0004jM-8V; Tue, 25 Aug 2026 08:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHl-0004iN-98
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHh-0000LM-UJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmvF/j/A1GG/fGBSSgcyXowpztKEbwaQjCcPtJOE5Wo=;
 b=NFMz6xKd6dMV3vhyr5S17cr0XGtJj3Mt1C3w/Y3suIa7ZobEqcLKXSMcEXLOOjwQKJjjqn
 03VJY/57oqCHR1cxz3clzEBO0HvH9jEvA02drg6Dv6m29KkrhLcgdDfg1vF86YTiuLdO03
 FZYPEOl2hmjZQ5ieNjxUUFKWD6ECnbE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-tpyu7capPC-BticxU5uy_g-1; Tue, 25 Aug 2026 08:29:43 -0400
X-MC-Unique: tpyu7capPC-BticxU5uy_g-1
X-Mimecast-MFC-AGG-ID: tpyu7capPC-BticxU5uy_g_1787660983
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c20e5890680so229706566b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660982; x=1788265782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KmvF/j/A1GG/fGBSSgcyXowpztKEbwaQjCcPtJOE5Wo=;
 b=t/ZxWO5tHFpw2cB1GSZIfN/bHG/4kem5DtfAOlmqDeZBXE4cfbkr+EZnheBDdxuqxR
 fZTusefQqynYpGqdS5CGdTk/yVzBNrJWGyxKA32mqBgG1NG37NtxRXE2wQ9b3+CVFu9B
 PBYw+5TOGmliywMiyuoSSRkFeI5hknkU0DfT9LCIWcQlsEWtAcDmBFQTLtDiEvZuhqgV
 8GEKEF6AlGjR3Z03ka/UNrxVTWa+rRD6Up1P93AiBXci2t8g1LJAOOabR7y15ZxkADsP
 YqyVIgnT+Fg/Ulo+aR7dIpb7smHNo51EJahKVC/crpUjZ0q9UMo/6nvM4CvxnTZUVVXj
 g9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660982; x=1788265782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KmvF/j/A1GG/fGBSSgcyXowpztKEbwaQjCcPtJOE5Wo=;
 b=X/Abn4VR9mQGZ79sdlX1UCKn2La/xPkuj12yUMfxJ8o5Gx8a5+pch4BmeV2Pexk3ki
 c068TJDBKRrxzX8NqTT2PvClZuzi6xr61S/pA7WpokztPxEVWyLGuRuG8RALnaouMqq2
 zCWF5apwt10/uk1TUX6TejfsRr8G0nmaFh6vyB4ey8mqr/ArL7LuBux1Z9Rh2VEnMEk8
 YLc+TYPCRT1giX3tXbaR+NBHOdBdPoajXAPNbQEHnmqJYovwEDVCiCITauQf5Ax6Dvkq
 HtsabD7QeRILMIyHqNSsKms2so071EM4EdjiNUZP4Z+uP+ZQmnakEjf8NgTynWhr8k2G
 mTjA==
X-Gm-Message-State: AFuF++mUZAISJ/s70nouoJerJIHu9JK5gXCEYB5HVg0cMSh3tA+IDDui
 ag1qMU1FQWq/V0TlZfQrzTVBkcR4lpG+a5KyLfVZWlVaD9KwUVOsbjuSBfPvKwd/Dse3auUFZ3n
 Cf09vdweFbAVXoOdItVLgUkBkIhhqnnEzc8Q+HSbfw5A9cAAH2QRwzxStKFmTb/T5AeWSaYnV/W
 b8ikbPPHVBIMeJ11RkwbSZIccF1zZkzEru8LlnI/fZ
X-Gm-Gg: AR+sD123Dlom0aPgpoDal6YV0GmsVerV2/r3MJx74MK44jZt98bZu/cbRRMghOIk+/a
 WByHbv8xpFt6v3h+QAjxP9BAwWerc9eba88e5y871ytxjCblJnYgYrL5LblPXdcg4dzxsbyoojv
 TUGQ2WyOEai48pXJJduGkAOVnylPWdqPuInhFJx6XHxooLDj3bziMkfX1+YJvN0WtYdZCRaAlM3
 By9CBfOsnZtzVTVKpU7f9JBh2KVVrNBm7BkXeFbe38Chd+XDaNCi/v8HsbYgeXDjvJ3cKQZ1vUu
 BJFH0/ud/HKMUNYXnV+nb7zkM8c9+jt+G1r+xF5xBJFneZqrQAMpXREWxzLXByxhSxwBEI7alrC
 EGuz5KoCCifHfLlGNlb8OAPLMB5NAQDAiOZAw62p3uHdvLA94M8Tq+ZP5XSxKhOc62RvO3GQzEo
 bic/M=
X-Received: by 2002:a17:907:c8c6:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c249257c128mr2955001166b.1.1787660982596; 
 Tue, 25 Aug 2026 05:29:42 -0700 (PDT)
X-Received: by 2002:a17:907:c8c6:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c249257c128mr2954991566b.1.1787660982106; 
 Tue, 25 Aug 2026 05:29:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b59fsm1995590966b.12.2026.08.25.05.29.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/20] target/i386/tcg: mark XSAVE* as not allowing REX2
Date: Tue, 25 Aug 2026 14:29:09 +0200
Message-ID: <20260825122921.431739-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  3 +++
 target/i386/tcg/decode-new.c.inc | 21 ++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 92822969003..c974ca9d7c5 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -181,6 +181,9 @@ typedef enum X86InsnCheck {
     /* Vendor-specific checks for Intel/AMD differences */
     X86_CHECK_i64_amd = 2048,
     X86_CHECK_o64_intel = 4096,
+
+    /* No REX2 prefix allowed */
+    X86_CHECK_no_rex2 = 8192,
 } X86InsnCheck;
 
 typedef enum X86InsnSpecial {
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 47bc30a22fc..a7e3ecec8a2 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -481,9 +481,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [1] = X86_OP_ENTRYr(FXRSTOR,    M,y, cpuid(FXSR) p_00),
         [2] = X86_OP_ENTRYr(LDMXCSR,    E,d, vex5 chk(VEX128) p_00),
         [3] = X86_OP_ENTRYw(STMXCSR,    E,d, vex5 chk(VEX128) p_00),
-        [4] = X86_OP_ENTRYw(XSAVE,      M,y, cpuid(XSAVE) p_00),
-        [5] = X86_OP_ENTRYr(XRSTOR,     M,y, cpuid(XSAVE) p_00),
-        [6] = X86_OP_ENTRYw(XSAVEOPT,   M,b, cpuid(XSAVEOPT) p_00),
+        [4] = X86_OP_ENTRYw(XSAVE,      M,y, cpuid(XSAVE) p_00 chk(no_rex2)),
+        [5] = X86_OP_ENTRYr(XRSTOR,     M,y, cpuid(XSAVE) p_00 chk(no_rex2)),
+        [6] = X86_OP_ENTRYw(XSAVEOPT,   M,b, cpuid(XSAVEOPT) p_00 chk(no_rex2)),
         [7] = X86_OP_ENTRYw(NOP,        M,b, cpuid(CLFLUSH) p_00),
     };
 
@@ -2972,15 +2972,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
+        if ((decode.e.check & X86_CHECK_no_rex2) && (s->prefix & PREFIX_REX2)) {
+            goto illegal_op;
         }
         if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
             goto illegal_op;
-- 
2.55.0


