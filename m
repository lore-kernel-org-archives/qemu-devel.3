Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18DAC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHw-0004kt-Bu; Tue, 25 Aug 2026 08:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHt-0004kO-VL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHr-0000Ok-Q1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8m4ur/qwy5DWW9MB3GXE0pSnBIOrBsa+dBSKNVkWdM=;
 b=KSLtCsVtkeKRg8tc0mm5MStbEPAtmPXfT3GJvswL12rTkkeW6ETSrEZlO4WpmJqXpFLYuf
 GiwvRe9iLevxmG0qk2jDa64sWAI5ZWUhTaTgdFSlc68XoCMhqidB5l25BZDNUTRd4Ye0Dm
 slj9XC91QLUj9ag0+2D0h096O0X3L24=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-_GWVYv_8N_W8TobPeSLCrg-1; Tue, 25 Aug 2026 08:29:52 -0400
X-MC-Unique: _GWVYv_8N_W8TobPeSLCrg-1
X-Mimecast-MFC-AGG-ID: _GWVYv_8N_W8TobPeSLCrg_1787660991
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c1f548718d0so502900366b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660991; x=1788265791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V8m4ur/qwy5DWW9MB3GXE0pSnBIOrBsa+dBSKNVkWdM=;
 b=LAFKiwHxykLD5ivDVDl2m10qQ76BDMxB7B2TF4akQ2NJ8nOvEWWY9pJWdJYzAuSTmJ
 qYxyT+98r8nbCWbsYTowxVj7pPkj55FKMI9MDf0H+jeePJ+LLhg6BD1vX+C6ws76qIwz
 T1qSZKLZcXsQI2bmqn4/Y+OIvPjDVgKZZgpkoLDzNgf6U2YlIDlYArME50whr8vdKk8Y
 36y0jravwqWsz40oNmuImq/p3zOP1wB6aKC6TrGGYQmyJ4e5IQU4yrZMYU8klts2Fx/8
 TNrMqseg5tT0TPFGR45rraEgRVa+XWh8+tAo1G2gMYhCIdME9I1Qobyme1hJN+HEuumM
 j78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660991; x=1788265791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=V8m4ur/qwy5DWW9MB3GXE0pSnBIOrBsa+dBSKNVkWdM=;
 b=tJ8LV86DZJfr90jkV0NUiCfbFtW8zF9rCO+NJZ4z8lD1hpamaUnMepK5UAUZFEYLS/
 apAO2MixHo3KrViN/kMkYO3mpWpm/aQZctx0Tv5Opn8mpP1Svosszwx9GhV5B0KhQWra
 47DKccVtHlxgpjYyupGqul7hr0AQw+jpaYcEC2O6Ubz2ZCM/JYB8mRmkScmtfsfKNq98
 L8a/3BIYtOEwLq0PyOURsCV2+uqygzIxDtSDHp7aJJerBJpUjPth33KqQKMtStldyAQf
 MTw65C+ua/USl0RzwNSQb5ed8MuEXq3u7rZ/qOwvJe5PA64jqSxJNTIdM9ntzJ0SNUlQ
 sqBA==
X-Gm-Message-State: AFuF++ma39CrAww0ywXPzvxLgwqfTve7F0eyxANSxYBIwAuj+aCF3Hje
 ywUvJ/T6nMbLlc0QwEb3hAw043edtk0tNEdsPIsee6EzXCrexapza262WrrxLqaJ5OSA6Pk47iG
 hVIGOiLREsPCl4pnU1mgVe7O0CNZmWQA/pKTSuxCeQfoVUN7IxtRiSSsrtA5dK3NHP0m+qdwMRM
 6RuGYrKZwUP+IgzYjVLtymele+v4AUaRZel/VpOrk0
X-Gm-Gg: AR+sD11GMzTWBT9wBe3x5tYEuhXXY/3PY6M+4G/Hr8K6/OPkSjrQt/8e+U7HNZ81DkB
 0jRGD1KSuw8FBZKXqOC4uFjmwNUTY6AyvbmZs40dX5gJQMm+/dR1heFfttIBSIH6XHylQg9Sr4Y
 ECJZgEitV4szpYoshLS1r3KV7sfCwGOMIkMpMCwkxAwBUibKzfcQQi1zNZF7SM+Qd7jaSQ7dLaO
 zVmJFJURxQq7xy3kqM199DZzsvLvpEu0LJCrucLwY0lcimVt19x35EL/4TYAwSEvavNmoowJ3R9
 ntsNaBRbrYuLFlznxAvY2W4GL+24UkVTIVpMNyA4ESRcg4viIqWlSm/ugP4AwjJF/nNE5bxdER5
 3IqQJ9nvO29J+a18ycIIrATN3RTN1ovO8UCh7DFlnT/FaMn7rjaYa2IBzZuPTThsqob+w1et+NS
 9hOgg=
X-Received: by 2002:a17:907:5c6:b0:c21:96e8:578d with SMTP id
 a640c23a62f3a-c24e5fd3199mr824948566b.15.1787660990876; 
 Tue, 25 Aug 2026 05:29:50 -0700 (PDT)
X-Received: by 2002:a17:907:5c6:b0:c21:96e8:578d with SMTP id
 a640c23a62f3a-c24e5fd3199mr824937466b.15.1787660990419; 
 Tue, 25 Aug 2026 05:29:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496296a46sm1883910566b.21.2026.08.25.05.29.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/20] target/i386/tcg: move VEX validation early
Date: Tue, 25 Aug 2026 14:29:13 +0200
Message-ID: <20260825122921.431739-13-pbonzini@redhat.com>
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

Perform the X86_VEX_REPScalar transformation on X86OpEntry instead of
X86DecodedOp; everything else can be checked equally well before
immediates are fetched etc.

This is especially important for APX, which may decode operands
differently depending on the NDD bit: if EVEX.NDD=0, VEX.vvvv is
ignored and must be zero.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 54 ++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 2033776ce1c..d49f467cc84 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2611,6 +2611,22 @@ static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_f
         decode->immediate = insn_get_signed(env, s, MO_8);
     }
 
+    if (e->vex_class == 12) {
+        /* Check no overlap between registers.  */
+        if (!decode->op[0].has_ea &&
+            (decode->op[0].n == decode->mem.index || decode->op[0].n == decode->op[1].n)) {
+            return false;
+        }
+        assert(!decode->op[1].has_ea);
+        if (decode->op[1].n == decode->mem.index) {
+            return false;
+        }
+        if (!decode->op[2].has_ea &&
+            (decode->op[2].n == decode->mem.index || decode->op[2].n == decode->op[1].n)) {
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -2717,9 +2733,9 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
             if (s->vex_l) {
                 goto illegal;
             }
-            assert(decode->e.s2 == X86_SIZE_x);
-            if (decode->op[2].has_ea) {
-                decode->op[2].ot = s->prefix & PREFIX_REPZ ? MO_32 : MO_64;
+            assert(e->op2 == X86_TYPE_W && e->s2 == X86_SIZE_x);
+            if ((s->modrm >> 6) != 3) {
+                e->s2 = s->prefix & PREFIX_REPNZ ? X86_SIZE_sd : X86_SIZE_ss;
             }
         }
         break;
@@ -2736,10 +2752,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 
     switch (e->vex_class) {
     case 0:
-        if (s->prefix & PREFIX_VEX) {
-            goto illegal;
-        }
-        return true;
+        g_assert_not_reached();
     case 1:
     case 2:
     case 3:
@@ -2764,19 +2777,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
             goto illegal;
         }
 
-        /* Check no overlap between registers.  */
-        if (!decode->op[0].has_ea &&
-            (decode->op[0].n == decode->mem.index || decode->op[0].n == decode->op[1].n)) {
-            goto illegal;
-        }
-        assert(!decode->op[1].has_ea);
-        if (decode->op[1].n == decode->mem.index) {
-            goto illegal;
-        }
-        if (!decode->op[2].has_ea &&
-            (decode->op[2].n == decode->mem.index || decode->op[2].n == decode->op[1].n)) {
-            goto illegal;
-        }
         /* fall through */
     case 6:
     case 11:
@@ -3127,6 +3127,16 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         get_modrm(s, env);
     }
 
+    if (decode.e.vex_class == 0) {
+        if (s->prefix & PREFIX_VEX) {
+            goto illegal_op;
+        }
+    } else {
+        if (!validate_vex(s, &decode)) {
+            return;
+        }
+    }
+
     if (!decode_ops(s, env, decode_func, &decode)) {
         goto illegal_op;
     }
@@ -3188,10 +3198,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         goto illegal_op;
     }
 
-    if (!validate_vex(s, &decode)) {
-        return;
-    }
-
     /*
      * Checks that result in #GP or VMEXIT come second.  Intercepts are
      * generally checked after non-memory exceptions (i.e. after all
-- 
2.55.0


