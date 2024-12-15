Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAA2E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaD-0004WH-QO; Sun, 15 Dec 2024 04:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaA-0004VI-Kj
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMka9-0006xm-0U
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWGGAB5XdcB3pXdVxuTkeezPYKORB6/K7AYCSGtJfhg=;
 b=cFgKsDnQPeg4cwvQ/2OBq91zm/HHTeXohAw55N8sKylPd+106qQ3p+E2ddCiWtqDRSza5D
 vmEyaPWgCGtt4aAzGxhyr/6T1OiTS6BM58GY7gIB96oo+0ZwFC6fu41JtYkJqAkrHbfX2X
 vWNFHBXePcryR8OPOO82pTsk2rI3VCU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-UZwQwHsvNUSFCDEtU5SRfg-1; Sun, 15 Dec 2024 04:06:30 -0500
X-MC-Unique: UZwQwHsvNUSFCDEtU5SRfg-1
X-Mimecast-MFC-AGG-ID: UZwQwHsvNUSFCDEtU5SRfg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362552ce62so16871455e9.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253587; x=1734858387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWGGAB5XdcB3pXdVxuTkeezPYKORB6/K7AYCSGtJfhg=;
 b=UsgbLQDfYmijbroetfo3W2JZA68w9fqDvh9JCzYiYWMaswd+ciCVR6uP5r7/FzWC4e
 39wNAHwJrryEAz9BWShYZOP894/ze15XnXAS2G670hDQMaSNSDKlEkz2quFuddC/Q0GI
 kA5NWxy/pKQIJQBw9GUpgj4tFs4z2BjtZzGcnILDZDt1vGgAGaWWW3UP0sNqZLuUDygG
 qvO8yOrhw+lugV4zl64L1BHS8DdR1ZoZnLWrHxt0yZS8zlNtLIRQyf5YVMsXNTk74PFR
 Xh1v26NBlLLse16TKeW4JVvvOzVuKsvpYsmqL3x4BY8oQzpe8/Z/OTQCaFeVIJTJftiI
 lP0w==
X-Gm-Message-State: AOJu0YyAcW2gwj2LAu5/7fG4S52kL2mdfXcflbN8QZApEAEHXN4jv/V1
 wBYRxQghmm9iOpK+F/S0Udiz60WGscRCVD5AcNJdycDbj2wxQ6PW47OfzwkMvMTvS2wXKupQYt3
 GPQxsEPHed1h0z/PbJiFdi6Z2q8kZL3cWmRust9o3bgqwtOi7fdxG26BMUKji1R03dDfKYQW0lJ
 DaoTyHZLVNaFSyBpewEqy1ksFTBp93G5z7JdoQ
X-Gm-Gg: ASbGncvu729yz+2RIGPvyTkE+49ppF7obdRmU+e32WNz8KPkOWVVV4ErumRW10bK3VE
 UPkFJFva9ug4wylYw89O2a33uOQfXZDCJIg8QDomIl1aRladroHsec0rQv53VcoBUFy68e65N1L
 mGzjrsPKCFSLC8etkLhBKjuKrlJSeNRESr6sFntxwnfQkLVHBok5uOMISXa63CcP3TnDZqVe6OP
 GgSmDspYIfcyG4KK6ym+MVD/nZJZfWy6og5m8FHs0viSQnY5CxJ/D10xGE=
X-Received: by 2002:a7b:cb89:0:b0:434:f609:1af7 with SMTP id
 5b1f17b1804b1-4362aa1b8b7mr70035375e9.4.1734253587525; 
 Sun, 15 Dec 2024 01:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcAGny48HTP4vXyDylRpMDew+hC6I3hTf1IlYLkzKABiVKleioHELcWDkBG9kmvwEEBwqHtQ==
X-Received: by 2002:a7b:cb89:0:b0:434:f609:1af7 with SMTP id
 5b1f17b1804b1-4362aa1b8b7mr70035105e9.4.1734253587098; 
 Sun, 15 Dec 2024 01:06:27 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361ec97d13sm83866495e9.1.2024.12.15.01.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 04/13] target/i386: unify choice between single and repeated
 string instructions
Date: Sun, 15 Dec 2024 10:06:03 +0100
Message-ID: <20241215090613.89588-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215090613.89588-1-pbonzini@redhat.com>
References: <20241215090613.89588-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The same "if" is present in all generator functions for string instructions.
Push it inside gen_repz() and gen_repz_nz() instead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 12 +++++++++--
 target/i386/tcg/emit.c.inc  | 42 +++++++------------------------------
 2 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8bf6aa1fcf6..63a39d9f15a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1340,13 +1340,21 @@ static void gen_repz(DisasContext *s, MemOp ot,
                      void (*fn)(DisasContext *s, MemOp ot))
 
 {
-    do_gen_rep(s, ot, fn, false);
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        do_gen_rep(s, ot, fn, false);
+    } else {
+        fn(s, ot);
+    }
 }
 
 static void gen_repz_nz(DisasContext *s, MemOp ot,
                         void (*fn)(DisasContext *s, MemOp ot))
 {
-    do_gen_rep(s, ot, fn, true);
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        do_gen_rep(s, ot, fn, true);
+    } else {
+        fn(s, ot);
+    }
 }
 
 static void gen_helper_fp_arith_ST0_FT0(int op)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a05ba019026..c346bf53c5f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1722,11 +1722,7 @@ static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
 static void gen_CMPS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz_nz(s, ot, gen_cmps);
-    } else {
-        gen_cmps(s, ot);
-    }
+    gen_repz_nz(s, ot, gen_cmps);
 }
 
 static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
@@ -2217,11 +2213,7 @@ static void gen_INS(DisasContext *s, X86DecodedInsn *decode)
     }
 
     translator_io_start(&s->base);
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz(s, ot, gen_ins);
-    } else {
-        gen_ins(s, ot);
-    }
+    gen_repz(s, ot, gen_ins);
 }
 
 static void gen_INSERTQ_i(DisasContext *s, X86DecodedInsn *decode)
@@ -2406,11 +2398,7 @@ static void gen_LGS(DisasContext *s, X86DecodedInsn *decode)
 static void gen_LODS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz(s, ot, gen_lods);
-    } else {
-        gen_lods(s, ot);
-    }
+    gen_repz(s, ot, gen_lods);
 }
 
 static void gen_LOOP(DisasContext *s, X86DecodedInsn *decode)
@@ -2608,11 +2596,7 @@ static void gen_MOVq_dq(DisasContext *s, X86DecodedInsn *decode)
 static void gen_MOVS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz(s, ot, gen_movs);
-    } else {
-        gen_movs(s, ot);
-    }
+    gen_repz(s, ot, gen_movs);
 }
 
 static void gen_MUL(DisasContext *s, X86DecodedInsn *decode)
@@ -2774,11 +2758,7 @@ static void gen_OUTS(DisasContext *s, X86DecodedInsn *decode)
     }
 
     translator_io_start(&s->base);
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz(s, ot, gen_outs);
-    } else {
-        gen_outs(s, ot);
-    }
+    gen_repz(s, ot, gen_outs);
 }
 
 static void gen_PALIGNR(DisasContext *s, X86DecodedInsn *decode)
@@ -3859,11 +3839,7 @@ static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
 static void gen_SCAS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz_nz(s, ot, gen_scas);
-    } else {
-        gen_scas(s, ot);
-    }
+    gen_repz_nz(s, ot, gen_scas);
 }
 
 static void gen_SETcc(DisasContext *s, X86DecodedInsn *decode)
@@ -4069,11 +4045,7 @@ static void gen_STMXCSR(DisasContext *s, X86DecodedInsn *decode)
 static void gen_STOS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz(s, ot, gen_stos);
-    } else {
-        gen_stos(s, ot);
-    }
+    gen_repz(s, ot, gen_stos);
 }
 
 static void gen_SUB(DisasContext *s, X86DecodedInsn *decode)
-- 
2.47.1


