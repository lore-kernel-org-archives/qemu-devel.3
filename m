Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C062FD006A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0S-0000Kr-RU; Sun, 01 Mar 2026 09:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0L-0000KA-Vr
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0K-0005jV-FS
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMTCCM66b1mqlLHWGeewn1cec2fDx8v9kVEs608meFw=;
 b=het5Wr40dDmK2+N0i3nBeM5h+cHw6FrUPSXIwLS9if/01jVst9GE42Jt/gqcca3XLzDJyr
 SRJA4zG6p0PZ94HR7cItFqcAUKuWRqnEmIULTJD3Vcf4VDHsqOSOnvAF/jOpE99OWoi3jl
 F+uPJn0O1N4e9Y5/i9M78c3PV1vWdto=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-xYasKo4dMdmY5Ku3UPjn3w-1; Sun, 01 Mar 2026 09:42:42 -0500
X-MC-Unique: xYasKo4dMdmY5Ku3UPjn3w-1
X-Mimecast-MFC-AGG-ID: xYasKo4dMdmY5Ku3UPjn3w_1772376161
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439ab866bc1so1182866f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376161; x=1772980961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eMTCCM66b1mqlLHWGeewn1cec2fDx8v9kVEs608meFw=;
 b=gsUzm0N8D9osQbr7azxI2Rgbm8rfTreJdU7Hz0z1F1tS1knbPmRLt/5vzW/GOLJLG7
 ucmDtvECtXIp6A78tuYYI56OTgrAJ10YQi5xncRDhZXfcJGB2EI+c82h8gCtrjTaIVBe
 8SCxwOxJ+xbtvbawtQMxd+nWwb5sN0Z2WsdZd0W/VkuNXqOzNNby+I/HCLofJkj1FAkL
 AeWd+ueIPf5KbVnhBu6gGFGQ/HNEmJKnXIsKjEV8UGMmifydniEhsGDzpU/UMpHEWi57
 /mhR+YQ9jAgTRgHXIa1UWduPJ9LCC2PcdZU0GA2gNNbswvd4mN8xfkgQH/xA28nPqLu4
 Su9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376161; x=1772980961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eMTCCM66b1mqlLHWGeewn1cec2fDx8v9kVEs608meFw=;
 b=Qr5i0Zf4I0BDA37XRfkI7/T7wOsqCaIIusQSqxG2VHlAplAfmwI0IvixjGu5HxuA2u
 r3/CpL9QEXp5OIImIn9YmlI8IlVFTqueKNdMGMZt2FgsrBDM7odbu3LrVXDoXJ3NcEi8
 CkhVpkzPDXQS1X1fVSccDXOFpFGX8Cj4HsooAzAFyAKzK56qjxx9XyaBRtWpzhGiSHAq
 kbiqX+f5tyYsU5e2D148HQfoAqhCA1rs2mJINwHp6B5iz8eJPuQpOS1a9k3txwRn+ySG
 LbvAf04iCBw6XrMPjft632loIc92J9EWB0NJpfhZ88/LX9CkZCUt5f/ZWnnBekmlkZ3M
 WpcQ==
X-Gm-Message-State: AOJu0Yx7uMQrSloFvyWL+3RvmEyUE4F90NTh3fRlw7gB543v0aC7i2y2
 2ZOtHYvkCNhlg71lTIIgbXDd/Cqrcm1beS/A5xn3djCQ2T1VJ5In7kInt4PgNxppXr4+VaIzr7K
 yN1gIwMWTKQmQeieIudbMd3icmXRr0JOgO4A/RUX1OelRLeIs+AGb7x+kxGc8P+aik3ji5h/YVi
 K2OCaTdfzI698oxfufyeFXiHaovY0yNc5sYt8cDGCV
X-Gm-Gg: ATEYQzy8euiSMhjfdghhoCTVYPDU/euanVOfC11hP37iCMSkhyKx4kJZuMKYKBUrjfu
 a/QRLobWa73Dq8L+F57ay44nGpIYDa5j9LrDMy6uLO4SRqHKInNBwKqsUyUeuCR6tT/F0789EBj
 RIpuYMmnv1U0vEHoj3dIKC17tkofTIZ73kWKugYyJMdj3aU+9fx6RYJAbOsQ2fHA44z5xdxh13l
 BvYx2yhuPQmTkOE3g3gT/IjCl7V5zKSzpl2qrW0uYZAYatwv/ZtBNa0TH1TP6uqUZBQw0lLISse
 IMhCHQ4qQ2NoctdORZEvQlnb/atyNuQ0SwOIMTH9khmhOAoX0NtFDF1rJPyt0+EejCP+uXb1YmG
 SxAiviw0hqvAtIb2sljW7ZTVFjqBkAjSQS1K1bB8F51puUxm7MqMWc5Pl8jbo3fbcotMPA6TRFQ
 3+OCPDeOAgTMZmOQsu9LIqUKo2ipE=
X-Received: by 2002:a05:6000:40dc:b0:439:b736:bd0e with SMTP id
 ffacd0b85a97d-439b736be50mr624178f8f.44.1772376160966; 
 Sun, 01 Mar 2026 06:42:40 -0800 (PST)
X-Received: by 2002:a05:6000:40dc:b0:439:b736:bd0e with SMTP id
 ffacd0b85a97d-439b736be50mr624129f8f.44.1772376160329; 
 Sun, 01 Mar 2026 06:42:40 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c60f8e5sm23838561f8f.4.2026.03.01.06.42.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/18] target/i386/tcg: move VEX validation early
Date: Sun,  1 Mar 2026 15:42:09 +0100
Message-ID: <20260301144218.458140-10-pbonzini@redhat.com>
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
index 3205a046a6b..a17fc8550fb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2610,6 +2610,22 @@ static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_f
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
 
@@ -2716,9 +2732,9 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
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
@@ -2735,10 +2751,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 
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
@@ -2763,19 +2776,6 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
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
@@ -3118,6 +3118,16 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         get_modrm(s, env);
     }
 
+    if (decode.e.vex_class == 0) {
+        if (s->prefix & (PREFIX_VEX | PREFIX_EVEX)) {
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
@@ -3179,10 +3189,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
2.52.0


