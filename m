Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE8606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MO9oRLf2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNSLA-0006ia-L7; Sun, 01 Nov 2026 04:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSL8-0006hm-8O
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xNSL6-0007tF-Os
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793527139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mVqWofxzxr+R41ROxlFMUfJeczvCtanxN0ktKWM0nA=;
 b=MO9oRLf24V5mQwq5tPdDx6u59eKISX1xUR55cRi2Kw9sbqPO7xk+2+nxYMIcO8z+Uf9jFE
 lBn7aA0MNye7Pzg6KI3dAzQBnJiRoPivUvWjUlNmrdjFWZe7ObXFsdg0BTtWqFHqEOShYV
 BBa3ymDv20RB2lBgp4DQ0ZBgYfpybR0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-tlYK0KiMN-GJCydjYw6EDQ-1; Sun,
 01 Nov 2026 04:58:58 -0500
X-MC-Unique: tlYK0KiMN-GJCydjYw6EDQ-1
X-Mimecast-MFC-AGG-ID: tlYK0KiMN-GJCydjYw6EDQ_1793527137
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7D0B1955F1A
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 09:58:56 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 312561800446
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 09:58:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] target/i386/tcg: change popl_esp_hack to an
 X86InsnSpecial
Date: Sun,  1 Nov 2026 10:58:43 +0100
Message-ID: <20261101095851.1557351-3-pbonzini@redhat.com>
In-Reply-To: <20261101095851.1557351-1-pbonzini@redhat.com>
References: <20261101095851.1557351-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 6 ++++++
 target/i386/tcg/translate.c      | 1 -
 target/i386/tcg/decode-new.c.inc | 8 +++-----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 5f76b0c1b7a..a823143bbdf 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -242,6 +242,12 @@ typedef enum X86InsnSpecial {
 
     /* Memory operand size of MOV from segment register is MO_16 */
     X86_SPECIAL_Op0_Mw,
+
+    /*
+     * If the address uses ESP as the base register, use the value
+     * of ESP after the pop.
+     */
+    X86_SPECIAL_PopESP,
 } X86InsnSpecial;
 
 /*
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5199c330ac7..b2cbce046cb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -108,7 +108,6 @@ typedef struct DisasContext {
     uint8_t vex_v;  /* vex vvvv register, without 1's complement.  */
     bool vex_ndd; /* is this a 3-operand instruction? */
     bool vex_w; /* used by AVX even on 32-bit processors */
-    uint8_t popl_esp_hack; /* for correct popl with esp base handling */
     uint8_t rip_offset; /* only used in x86_64, but left for simplicity */
 
     uint8_t rex_r; /* 0 for i386, but left for simplicity */
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 3845fab5c85..2756953c744 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1615,8 +1615,7 @@ static void decode_group1A(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         *entry = UNKNOWN_OPCODE;
     } else {
         entry->gen = gen_POP;
-        /* The address must use the value of ESP after the pop.  */
-        s->popl_esp_hack = 1 << mo_pushpop(s, s->dflag);
+        entry->special = X86_SPECIAL_PopESP;
     }
 }
 
@@ -2360,8 +2359,8 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
         }
 
         /* For correct popl handling with esp.  */
-        if (base == R_ESP && s->popl_esp_hack) {
-            disp += s->popl_esp_hack;
+        if (base == R_ESP && decode->e.special == X86_SPECIAL_PopESP) {
+            disp += 1 << mo_pushpop(s, s->dflag);
         }
         if (base == R_EBP || base == R_ESP) {
             def_seg = R_SS;
@@ -3287,7 +3286,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     s->pc = s->base.pc_next;
     s->override = -1;
-    s->popl_esp_hack = 0;
 #ifdef TARGET_X86_64
     s->rex_r = 0;
     s->rex_x = 0;
-- 
2.56.0



