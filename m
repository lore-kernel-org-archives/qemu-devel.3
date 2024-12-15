Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552CFE7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaZ-0004fm-7n; Sun, 15 Dec 2024 04:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaY-0004fM-3a
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaW-000704-Ct
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qSvxAgvi/iO/49Wv7FHDDVXKQuBKeLKv7IQubFUeUk=;
 b=gFXoDpUUeIVUThe6xjT4KzzXSGjC5voAqPWEzxUgkfWnEN7rpOaWU1zFF+y3FC30b67a6C
 GIy0hF/fe7FJoUMVBX4oMtiiDrzeVAGvmeKrSEto6gdeYYEMYqBgAhEmAkEZ+W9eIXCikR
 DSdBlTSLGWMPQ3M2FzfyFw0Bo+wdkNI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-578W1KbUNH6t7WV7UQhyOA-1; Sun, 15 Dec 2024 04:06:52 -0500
X-MC-Unique: 578W1KbUNH6t7WV7UQhyOA-1
X-Mimecast-MFC-AGG-ID: 578W1KbUNH6t7WV7UQhyOA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362f893bfaso10208085e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253611; x=1734858411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qSvxAgvi/iO/49Wv7FHDDVXKQuBKeLKv7IQubFUeUk=;
 b=De6H4LQNUCHod+rzk1PurTaCMYzMNCa8wnWQQM2gHvX5vVjZ6KnQp+0UkhhPm9TR+l
 PatesYvoBQAnj0Dby6EkdRKrx5thnoqbqbRf7AjGwwxa81oc1b9zu49Hi1DQINpEazGK
 GsVuLdADpLyPRGCqQln8GF5/81C3p9Hmrl8aV0G98rpVHxKcCvUIA7uAeedYupRupEjE
 CHr+wMy2y0XsH99RbhhxoCtf1wS161YqLECcj+NaN77s1YbfCVIZOCZKYdebTkEdCjpE
 GEWZRDzfH4YMzLv/jyyZ+X8q2IAB4x6S/lCDnPRXBM69a3reQDfNAK0PkKG/KxB/zzuF
 Wl5w==
X-Gm-Message-State: AOJu0YzqdjKbLqRUxe2cHsWyCmgl0yNausuM+L90ym4rwAMsi2Btbmtb
 s6FLQHMloSVzvXY6P1TuFI3SPRXoRPLFQGgr5IuZj53kPmR3JBkbN5UxHPTbr6ghHvHAYw9KLVh
 MbOoRFfAYe5f7NkKnjOKNAyU91+1EEKG9BIkIzk5gyH+gPtpznMy5D1S9ovw2GaTRUqrk1xi5LF
 ioQt1vIJjRumeRhmZspadmY0mEuObj7N3mEHdQ
X-Gm-Gg: ASbGncvRymRu+pxjCS42Nq48qJlsIiz79Uv1Yy6/+73A57TiqTXNcbzP4k0QHWgT4IO
 MB033yYzBw69zMEDf1nBdQuCOuYUmC4N2FjFOcvIKgyF0EQ7aQclEiFnCI2zD06Z809Q6u1aKeh
 RmHUQ+MziglSlMmpPgoBtxkGCZwWDBNnS3qlx+v09nN3kmPxFgAkGAKMhU4LlqxkAAii1zWxrDi
 MRvoTyIac0lWIWCzULcuYMJ6jVFfQl7CXkQVNCx4aRUcSaPmEdspCby738=
X-Received: by 2002:a05:600c:4709:b0:42c:de2f:da27 with SMTP id
 5b1f17b1804b1-4362aa34d7bmr88880975e9.2.1734253610927; 
 Sun, 15 Dec 2024 01:06:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4ISHZrDX6b/xTH4Cf1MN1fyCDJ8scktNcsSMm+1xq/ClLYGUh47DCl2pwO3OwW1MnylMEUw==
X-Received: by 2002:a05:600c:4709:b0:42c:de2f:da27 with SMTP id
 5b1f17b1804b1-4362aa34d7bmr88880625e9.2.1734253610500; 
 Sun, 15 Dec 2024 01:06:50 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625706c77sm103226235e9.34.2024.12.15.01.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 12/13] target/i386: pull computation of string update value
 out of loop
Date: Sun, 15 Dec 2024 10:06:11 +0100
Message-ID: <20241215090613.89588-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215090613.89588-1-pbonzini@redhat.com>
References: <20241215090613.89588-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

This is a common operation that is executed many times in rep
movs or rep stos loops.  It can improve performance by several
percentage points.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 54 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e0f9f7748bc..4b652cc23e1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -831,16 +831,13 @@ static bool gen_check_io(DisasContext *s, MemOp ot, TCGv_i32 port,
 #endif
 }
 
-static void gen_movs(DisasContext *s, MemOp ot)
+static void gen_movs(DisasContext *s, MemOp ot, TCGv dshift)
 {
-    TCGv dshift;
-
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
     gen_string_movl_A0_EDI(s);
     gen_op_st_v(s, ot, s->T0, s->A0);
 
-    dshift = gen_compute_Dshift(s, ot);
     gen_op_add_reg(s, s->aflag, R_ESI, dshift);
     gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
@@ -1244,22 +1241,22 @@ static inline void gen_jcc(DisasContext *s, int b, TCGLabel *l1)
     }
 }
 
-static void gen_stos(DisasContext *s, MemOp ot)
+static void gen_stos(DisasContext *s, MemOp ot, TCGv dshift)
 {
     gen_string_movl_A0_EDI(s);
     gen_op_st_v(s, ot, s->T0, s->A0);
-    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
+    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
 
-static void gen_lods(DisasContext *s, MemOp ot)
+static void gen_lods(DisasContext *s, MemOp ot, TCGv dshift)
 {
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
     gen_op_mov_reg_v(s, ot, R_EAX, s->T0);
-    gen_op_add_reg(s, s->aflag, R_ESI, gen_compute_Dshift(s, ot));
+    gen_op_add_reg(s, s->aflag, R_ESI, dshift);
 }
 
-static void gen_scas(DisasContext *s, MemOp ot)
+static void gen_scas(DisasContext *s, MemOp ot, TCGv dshift)
 {
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
@@ -1268,13 +1265,11 @@ static void gen_scas(DisasContext *s, MemOp ot)
     tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
     set_cc_op(s, CC_OP_SUBB + ot);
 
-    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
+    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
 
-static void gen_cmps(DisasContext *s, MemOp ot)
+static void gen_cmps(DisasContext *s, MemOp ot, TCGv dshift)
 {
-    TCGv dshift;
-
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
     gen_string_movl_A0_ESI(s);
@@ -1284,7 +1279,6 @@ static void gen_cmps(DisasContext *s, MemOp ot)
     tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
     set_cc_op(s, CC_OP_SUBB + ot);
 
-    dshift = gen_compute_Dshift(s, ot);
     gen_op_add_reg(s, s->aflag, R_ESI, dshift);
     gen_op_add_reg(s, s->aflag, R_EDI, dshift);
 }
@@ -1303,7 +1297,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
     }
 }
 
-static void gen_ins(DisasContext *s, MemOp ot)
+static void gen_ins(DisasContext *s, MemOp ot, TCGv dshift)
 {
     gen_string_movl_A0_EDI(s);
     /* Note: we must do this dummy write first to be restartable in
@@ -1314,11 +1308,11 @@ static void gen_ins(DisasContext *s, MemOp ot)
     tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
     gen_helper_in_func(ot, s->T0, s->tmp2_i32);
     gen_op_st_v(s, ot, s->T0, s->A0);
-    gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
+    gen_op_add_reg(s, s->aflag, R_EDI, dshift);
     gen_bpt_io(s, s->tmp2_i32, ot);
 }
 
-static void gen_outs(DisasContext *s, MemOp ot)
+static void gen_outs(DisasContext *s, MemOp ot, TCGv dshift)
 {
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
@@ -1327,14 +1321,14 @@ static void gen_outs(DisasContext *s, MemOp ot)
     tcg_gen_andi_i32(s->tmp2_i32, s->tmp2_i32, 0xffff);
     tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T0);
     gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
-    gen_op_add_reg(s, s->aflag, R_ESI, gen_compute_Dshift(s, ot));
+    gen_op_add_reg(s, s->aflag, R_ESI, dshift);
     gen_bpt_io(s, s->tmp2_i32, ot);
 }
 
 #define REP_MAX 65535
 
-static void do_gen_rep(DisasContext *s, MemOp ot,
-                       void (*fn)(DisasContext *s, MemOp ot),
+static void do_gen_rep(DisasContext *s, MemOp ot, TCGv dshift,
+                       void (*fn)(DisasContext *s, MemOp ot, TCGv dshift),
                        bool is_repz_nz)
 {
     TCGLabel *last = gen_new_label();
@@ -1399,7 +1393,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
     }
 
     gen_set_label(loop);
-    fn(s, ot);
+    fn(s, ot, dshift);
     tcg_gen_mov_tl(cpu_regs[R_ECX], cx_next);
     gen_update_cc_op(s);
 
@@ -1434,7 +1428,7 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
          */
         gen_set_label(last);
         set_cc_op(s, CC_OP_DYNAMIC);
-        fn(s, ot);
+        fn(s, ot, dshift);
         tcg_gen_mov_tl(cpu_regs[R_ECX], cx_next);
         gen_update_cc_op(s);
     }
@@ -1449,23 +1443,27 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
 }
 
 static void gen_repz(DisasContext *s, MemOp ot,
-                     void (*fn)(DisasContext *s, MemOp ot))
+                     void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
 
 {
+    TCGv dshift = gen_compute_Dshift(s, ot);
+
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        do_gen_rep(s, ot, fn, false);
+        do_gen_rep(s, ot, dshift, fn, false);
     } else {
-        fn(s, ot);
+        fn(s, ot, dshift);
     }
 }
 
 static void gen_repz_nz(DisasContext *s, MemOp ot,
-                        void (*fn)(DisasContext *s, MemOp ot))
+                        void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
 {
+    TCGv dshift = gen_compute_Dshift(s, ot);
+
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        do_gen_rep(s, ot, fn, true);
+        do_gen_rep(s, ot, dshift, fn, true);
     } else {
-        fn(s, ot);
+        fn(s, ot, dshift);
     }
 }
 
-- 
2.47.1


