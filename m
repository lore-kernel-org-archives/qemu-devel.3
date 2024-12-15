Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7AAE77183
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMkaL-0004Yr-VC; Sun, 15 Dec 2024 04:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaJ-0004YP-Nb
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkaI-0006yZ-0C
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4DOvj8ea+R+4uCgyE0WisdYjtGttU2oS4PXE8TXzoY=;
 b=OcjNxbPzix2yBBoXvmkYFSOK0BVWw9DJxzVub9MRSnYM7NESbTSHPdSuRkKYmEwREjCHpU
 r7L0q8FLK7fhFuOA1GP9XSr9PFo5BvxcOb9U7iMaTxUDn6hBSStsqSzOxXSO1+FULwvJZ3
 /aL95aaeO+/dEkqJ3DrfoSxO8Ef8dhU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-lQB2gfseO9uiscaMScozzQ-1; Sun, 15 Dec 2024 04:06:36 -0500
X-MC-Unique: lQB2gfseO9uiscaMScozzQ-1
X-Mimecast-MFC-AGG-ID: lQB2gfseO9uiscaMScozzQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso17281115e9.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253594; x=1734858394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4DOvj8ea+R+4uCgyE0WisdYjtGttU2oS4PXE8TXzoY=;
 b=HVbS5uFwCV2lbEq208fxjiNPm/amTAiGzmWvlRcaa+wyBtg7JfSzPEVWOXDM8lPoSN
 yI9y319Qj0pdZx4JGVQkM7tk42BkCk1zl56SojnXIP14l6jVZM8snKaZj+/DWYuavVSB
 brTEIOaer51a9ZsCg70NilMOK0RKo1t4Y6RMQ8PfW6FNC8n9yd+8zLmFKRLt/LOdQMlp
 aVfSKkEts9egjImBkNLaxUuOjWypGRjEvsHMjj007pnQY7jncUZDVh7NXwh15x80yP9S
 +B9nxh1YKo1uFrTRhcc1rzIJBqADP45qq0Y+nEKl3Yyinap9ZzVUfe3cD+q/G9LaWDXa
 7ALg==
X-Gm-Message-State: AOJu0Yzfg0ASLjdHuR5UnL99qjdqa+3GiWwDXGPInym+GEYA9H70oIJh
 ogP64yNuNj2p/IHL2Ye0bMfw7KQVpV+WJpkD3e+diqjdIv8eheC6rsruopq6fQAeAZp7cKHLmMV
 3Z1H6slsziBeAfvzfIFfToWLT12Nk5nBlOo8Nv6+1YMJwzGwOSbltRugeeRFKO8FCaVaGnfypoP
 AeoZRYWBfmBE9Cz3XQPdl5jBEOl5lhNTtlaOoR
X-Gm-Gg: ASbGncudvHSVPPk/ZiVmQ2pUO8Msr8YaVs+b74BgXX2FPYx1NF7ubUf4DywRSx0al3T
 RBvq4RETdHfXOfGglQ4uAoKUik5vc1ag8Oxhxn+S/WdBucXa0Y8crWEBe9CjjD+3E0Aax9gIHBm
 tGENJHt2hD/TS5Nfav7iqBJJ0My+uJbCuO3ng8epBybclOZt94ByIJ9Qd1TwBOFLQYf0CqWLTCa
 kNUIAgOMFr+/CwvShzzG62Z1OoOyYf4xDbhoKfpq09eDPiC93ft1jNY7/k=
X-Received: by 2002:a05:600c:1c07:b0:434:9fac:b158 with SMTP id
 5b1f17b1804b1-4362aa34e8amr66686565e9.1.1734253593983; 
 Sun, 15 Dec 2024 01:06:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc17yO0imPYbv18wiVlrvIXjcZ5jDUNimWVX4Jej1xi0CXP5bbcyUl6dfRb6WIqymS+yt1bg==
X-Received: by 2002:a05:600c:1c07:b0:434:9fac:b158 with SMTP id
 5b1f17b1804b1-4362aa34e8amr66686255e9.1.1734253593497; 
 Sun, 15 Dec 2024 01:06:33 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ed8dsm106580625e9.23.2024.12.15.01.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 06/13] target/i386: tcg: move gen_set/reset_* earlier in the
 file
Date: Sun, 15 Dec 2024 10:06:05 +0100
Message-ID: <20241215090613.89588-7-pbonzini@redhat.com>
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

Allow using them in the code that translates REP/REPZ, without
forward declarations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 80 ++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3732d05d5f5..0fe7ed4ec8d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -724,6 +724,46 @@ static inline void gen_op_jnz_ecx(DisasContext *s, TCGLabel *label1)
     gen_op_j_ecx(s, TCG_COND_NE, label1);
 }
 
+static void gen_set_hflag(DisasContext *s, uint32_t mask)
+{
+    if ((s->flags & mask) == 0) {
+        TCGv_i32 t = tcg_temp_new_i32();
+        tcg_gen_ld_i32(t, tcg_env, offsetof(CPUX86State, hflags));
+        tcg_gen_ori_i32(t, t, mask);
+        tcg_gen_st_i32(t, tcg_env, offsetof(CPUX86State, hflags));
+        s->flags |= mask;
+    }
+}
+
+static void gen_reset_hflag(DisasContext *s, uint32_t mask)
+{
+    if (s->flags & mask) {
+        TCGv_i32 t = tcg_temp_new_i32();
+        tcg_gen_ld_i32(t, tcg_env, offsetof(CPUX86State, hflags));
+        tcg_gen_andi_i32(t, t, ~mask);
+        tcg_gen_st_i32(t, tcg_env, offsetof(CPUX86State, hflags));
+        s->flags &= ~mask;
+    }
+}
+
+static void gen_set_eflags(DisasContext *s, target_ulong mask)
+{
+    TCGv t = tcg_temp_new();
+
+    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+    tcg_gen_ori_tl(t, t, mask);
+    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+}
+
+static void gen_reset_eflags(DisasContext *s, target_ulong mask)
+{
+    TCGv t = tcg_temp_new();
+
+    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+    tcg_gen_andi_tl(t, t, ~mask);
+    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+}
+
 static void gen_helper_in_func(MemOp ot, TCGv v, TCGv_i32 n)
 {
     switch (ot) {
@@ -2083,46 +2123,6 @@ static void gen_interrupt(DisasContext *s, uint8_t intno)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_set_hflag(DisasContext *s, uint32_t mask)
-{
-    if ((s->flags & mask) == 0) {
-        TCGv_i32 t = tcg_temp_new_i32();
-        tcg_gen_ld_i32(t, tcg_env, offsetof(CPUX86State, hflags));
-        tcg_gen_ori_i32(t, t, mask);
-        tcg_gen_st_i32(t, tcg_env, offsetof(CPUX86State, hflags));
-        s->flags |= mask;
-    }
-}
-
-static void gen_reset_hflag(DisasContext *s, uint32_t mask)
-{
-    if (s->flags & mask) {
-        TCGv_i32 t = tcg_temp_new_i32();
-        tcg_gen_ld_i32(t, tcg_env, offsetof(CPUX86State, hflags));
-        tcg_gen_andi_i32(t, t, ~mask);
-        tcg_gen_st_i32(t, tcg_env, offsetof(CPUX86State, hflags));
-        s->flags &= ~mask;
-    }
-}
-
-static void gen_set_eflags(DisasContext *s, target_ulong mask)
-{
-    TCGv t = tcg_temp_new();
-
-    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
-    tcg_gen_ori_tl(t, t, mask);
-    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
-}
-
-static void gen_reset_eflags(DisasContext *s, target_ulong mask)
-{
-    TCGv t = tcg_temp_new();
-
-    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
-    tcg_gen_andi_tl(t, t, ~mask);
-    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
-}
-
 /* Clear BND registers during legacy branches.  */
 static void gen_bnd_jmp(DisasContext *s)
 {
-- 
2.47.1


