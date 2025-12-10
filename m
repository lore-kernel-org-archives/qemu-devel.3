Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8668DD3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4M-0004rA-4b; Wed, 10 Dec 2025 08:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4F-0004oe-1z
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4D-0003AU-2F
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbq89kgPm8GFjPP2curBskdd3QXdCCJ3Vto4Vw5h5zw=;
 b=GXj1W1CXapvN0T6Wt3jrF5MLXjpAFBPwebFAAxlt+e+kSQj75/SOaV/HngviYC3oYzF0E6
 VW7fyWMAjMPqGrPqRIDrIhip8nnWE1XjTyCeAsrRBWGVaGRyXfF6KY1euyPHbRLgcQ6KnN
 pTwkSktoz2wTYl6Z/oDW048XSQozGoU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-QrH419oyP62OIKnBeYL7sw-1; Wed, 10 Dec 2025 08:17:14 -0500
X-MC-Unique: QrH419oyP62OIKnBeYL7sw-1
X-Mimecast-MFC-AGG-ID: QrH419oyP62OIKnBeYL7sw_1765372633
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477a0ddd1d4so39910175e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372632; x=1765977432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pbq89kgPm8GFjPP2curBskdd3QXdCCJ3Vto4Vw5h5zw=;
 b=Ib6h9a9oApgr5+W+0i8b0hMqrHIma8NCGf5XV2cY/SyNCECByLj9gURwkeabD63kOw
 P4OE+mz5mIvg31coSfveefyQdxX81yNx47d8MRDmQkRK/W/waekrj93loHwsuWulB6pR
 R0bRJZHCperLKrBC6dYOIiEGfRikRqGH7J2BA91SlkyCmYrZTfKaEx5W7hu08hnJVqBI
 V0rPzWzBcsygNkTH8BBdDMhKBHmYlp6ogYnMR0m3fB6gK2XHI9W8gsbHAlFTqRYtNFu2
 C8O0vVqyk5DMSh+1OWTJdOO/OT6bJYK41YWOqZo3yEVReIhnFojixwNeqJUe89/7DLi9
 0CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372632; x=1765977432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pbq89kgPm8GFjPP2curBskdd3QXdCCJ3Vto4Vw5h5zw=;
 b=Pnk2XE7tXO4ZcJBth8Ocv5TWUz26xIQqGw4tfaR9Q3C71YfD/qZw90u3T8XntUoY1q
 cAS6XxX9+HGtQHkOsfacsNxQfuuifIPrNPkNAPAoVKsBivF6Qa8mt+CDa+AgaQZZoaUP
 H7KkQthjcQZIPd/sVBXeUjU1LdQhrDsw0yLS2W4OqFsHLju5ViBBFy0mO4HlTlZcOKEi
 oHBgbORkwNTA3wThk2DdMoZ3xOpJ9Tu80XKDsRdZL6oCvhgqbcwAeXIk4RDhSuBT2IRi
 t50K+SwOItfYN0YhWcqHVPqexrqdwVBV4YASFW0I2AyGxfe/uz5RJ0ANj0KlQpQQEpsb
 55wQ==
X-Gm-Message-State: AOJu0YzrPu0cp7TyB7PG+/jqCUSOAzPjnDnaPKUg73hMopYmuIEqw0L4
 +kmHsG2mp/LqeD08jC69F9iFmExlNDCqW/6FGyEouAHko81aBIpNwdsyOiC3pbrtlHAgnSfmCQa
 Zv0F+v+YVhoEgSiFqjo+8QJX4qeYnAnizAuM0Qgkxa4tbt8PkBI8v/FDHc2XOoWBGIoJwwftWhk
 krZeJftBeutE+gib3NfE0OT9m1sM5HnNIg86Bd9FT8
X-Gm-Gg: ASbGncvCA5YLLIYMCT7RKV5/j54OmXr1XsO9h06RNmfBAF14jipu+W3bPITYG0doKKA
 4E++vDuAseLfh1fEj6VkR4BJ3X6m2G4INNG14aJ4vNXYzE5+R5GTLcZ8ZW3Pob0I0aZUHOzRqvP
 Ojegc81ks6I6007t3AWgr3bPTN0mP0HinAqRoxo2V4CR3a8y7JHOLeBDT0j9oBmQLSFFcKn3PnE
 nhBoLa9mLgcz91hDTaiqbrRMPKkc+DBhxKBOBLZKStbaj+QJvCv9rWdaCi6VjcdrrV8RZ9vJAXp
 FH+sWetmmhOj4ehRpg1DyKq91QeeccYXQh0Uy9eu+nAm8/NPQhHH/08Df5bw/SJjtuZIt5fVlZc
 BDqEbeKNfgbVIeQPiI0XYg/y/g9V9ZdINqyqZOrGatPtZm8k5QzVki9zzaJmVmUJpPdofhVHsi3
 k7UM5iqbTP++s2KE0=
X-Received: by 2002:a05:600c:3e16:b0:477:9d54:58d7 with SMTP id
 5b1f17b1804b1-47a8379c15dmr23370265e9.29.1765372632097; 
 Wed, 10 Dec 2025 05:17:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBGJD5OUoh1sN4EfxDy1fba7O2u4Q5lKjltZETS4c6sTXQzmhAEbdQvsttmYUaZY0XJs/fbQ==
X-Received: by 2002:a05:600c:3e16:b0:477:9d54:58d7 with SMTP id
 5b1f17b1804b1-47a8379c15dmr23369965e9.29.1765372631518; 
 Wed, 10 Dec 2025 05:17:11 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82cb12fbsm44137535e9.0.2025.12.10.05.17.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/18] target/i386/tcg: unnest switch statements in
 disas_insn_x87
Date: Wed, 10 Dec 2025 14:16:44 +0100
Message-ID: <20251210131653.852163-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 290 +++++++++++++++++-------------------
 1 file changed, 134 insertions(+), 156 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2ab3c2ac663..c755329b3d9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2457,36 +2457,32 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
 
         switch (op) {
         case 0x00 ... 0x07: /* fxxxs */
-        case 0x10 ... 0x17: /* fixxxl */
-        case 0x20 ... 0x27: /* fxxxl */
-        case 0x30 ... 0x37: /* fixxx */
-            {
-                int op1;
-                op1 = op & 7;
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
+            goto fp_arith_ST0_FT0;
 
-                switch (op >> 4) {
-                case 0:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
-                    break;
-                case 1:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
-                    break;
-                case 2:
-                    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
-                                        s->mem_index, MO_LEUQ);
-                    gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
-                    break;
-                case 3:
-                default:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LESW);
-                    gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
-                    break;
-                }
+        case 0x10 ... 0x17: /* fixxxl */
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
+            goto fp_arith_ST0_FT0;
+
+        case 0x20 ... 0x27: /* fxxxl */
+            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
+                                s->mem_index, MO_LEUQ);
+            gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
+            goto fp_arith_ST0_FT0;
+
+        case 0x30 ... 0x37: /* fixxx */
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LESW);
+            gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
+            goto fp_arith_ST0_FT0;
+
+fp_arith_ST0_FT0:
+            {
+                int op1 = op & 7;
 
                 gen_helper_fp_arith_ST0_FT0(op1);
                 if (op1 == 3) {
@@ -2495,88 +2491,78 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 }
             }
             break;
+
         case 0x08: /* flds */
-        case 0x0a: /* fsts */
-        case 0x0b: /* fstps */
-        case 0x18 ... 0x1b: /* fildl, fisttpl, fistl, fistpl */
-        case 0x28 ... 0x2b: /* fldl, fisttpll, fstl, fstpl */
-        case 0x38 ... 0x3b: /* filds, fisttps, fists, fistps */
-            switch (op & 7) {
-            case 0:
-                switch (op >> 4) {
-                case 0:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    gen_helper_flds_ST0(tcg_env, s->tmp2_i32);
-                    break;
-                case 1:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
-                    break;
-                case 2:
-                    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
-                                        s->mem_index, MO_LEUQ);
-                    gen_helper_fldl_ST0(tcg_env, s->tmp1_i64);
-                    break;
-                case 3:
-                default:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LESW);
-                    gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
-                    break;
-                }
-                break;
-            case 1:
-                /* XXX: the corresponding CPUID bit must be tested ! */
-                switch (op >> 4) {
-                case 1:
-                    gen_helper_fisttl_ST0(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    break;
-                case 2:
-                    gen_helper_fisttll_ST0(s->tmp1_i64, tcg_env);
-                    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
-                                        s->mem_index, MO_LEUQ);
-                    break;
-                case 3:
-                default:
-                    gen_helper_fistt_ST0(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUW);
-                    break;
-                }
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            gen_helper_flds_ST0(tcg_env, s->tmp2_i32);
+            break;
+        case 0x18: /* fildl */
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
+            break;
+        case 0x28: /* fldl */
+            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
+                                s->mem_index, MO_LEUQ);
+            gen_helper_fldl_ST0(tcg_env, s->tmp1_i64);
+            break;
+        case 0x38: /* filds */
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LESW);
+            gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
+            break;
+
+        case 0x19: /* fisttpl */
+            gen_helper_fisttl_ST0(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            gen_helper_fpop(tcg_env);
+            break;
+        case 0x29: /* fisttpll */
+            gen_helper_fisttll_ST0(s->tmp1_i64, tcg_env);
+            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
+                                s->mem_index, MO_LEUQ);
+            gen_helper_fpop(tcg_env);
+            break;
+        case 0x39: /* fisttps */
+            gen_helper_fistt_ST0(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUW);
+            gen_helper_fpop(tcg_env);
+            break;
+
+        case 0x0a: case 0x0b: /* fsts, fstps */
+            gen_helper_fsts_ST0(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            if ((op & 7) == 3) {
+                gen_helper_fpop(tcg_env);
+            }
+            break;
+        case 0x1a: case 0x1b: /* fistl, fistpl */
+            gen_helper_fistl_ST0(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            if ((op & 7) == 3) {
+                gen_helper_fpop(tcg_env);
+            }
+            break;
+        case 0x2a: case 0x2b: /* fstl, fstpl */
+            gen_helper_fstl_ST0(s->tmp1_i64, tcg_env);
+            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
+                                s->mem_index, MO_LEUQ);
+            if ((op & 7) == 3) {
+                gen_helper_fpop(tcg_env);
+            }
+            break;
+
+        case 0x3a: case 0x3b: /* fists, fistps */
+            gen_helper_fist_ST0(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUW);
+            if ((op & 7) == 3) {
                 gen_helper_fpop(tcg_env);
-                break;
-            default:
-                switch (op >> 4) {
-                case 0:
-                    gen_helper_fsts_ST0(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    break;
-                case 1:
-                    gen_helper_fistl_ST0(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    break;
-                case 2:
-                    gen_helper_fstl_ST0(s->tmp1_i64, tcg_env);
-                    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
-                                        s->mem_index, MO_LEUQ);
-                    break;
-                case 3:
-                default:
-                    gen_helper_fist_ST0(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUW);
-                    break;
-                }
-                if ((op & 7) == 3) {
-                    gen_helper_fpop(tcg_env);
-                }
-                break;
             }
             break;
         case 0x0c: /* fldenv mem */
@@ -2707,39 +2693,37 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             }
             break;
         case 0x0d: /* grp d9/5 */
-            {
-                switch (rm) {
-                case 0:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fld1_ST0(tcg_env);
-                    break;
-                case 1:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldl2t_ST0(tcg_env);
-                    break;
-                case 2:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldl2e_ST0(tcg_env);
-                    break;
-                case 3:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldpi_ST0(tcg_env);
-                    break;
-                case 4:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldlg2_ST0(tcg_env);
-                    break;
-                case 5:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldln2_ST0(tcg_env);
-                    break;
-                case 6:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldz_ST0(tcg_env);
-                    break;
-                default:
-                    goto illegal_op;
-                }
+            switch (rm) {
+            case 0:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fld1_ST0(tcg_env);
+                break;
+            case 1:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldl2t_ST0(tcg_env);
+                break;
+            case 2:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldl2e_ST0(tcg_env);
+                break;
+            case 3:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldpi_ST0(tcg_env);
+                break;
+            case 4:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldlg2_ST0(tcg_env);
+                break;
+            case 5:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldln2_ST0(tcg_env);
+                break;
+            case 6:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldz_ST0(tcg_env);
+                break;
+            default:
+                goto illegal_op;
             }
             break;
         case 0x0e: /* grp d9/6 */
@@ -2801,22 +2785,16 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             }
             break;
         case 0x00: case 0x01: case 0x04 ... 0x07: /* fxxx st, sti */
+            gen_helper_fmov_FT0_STN(tcg_env,
+                                    tcg_constant_i32(opreg));
+            gen_helper_fp_arith_ST0_FT0(op & 7);
+            break;
+
         case 0x20: case 0x21: case 0x24 ... 0x27: /* fxxx sti, st */
         case 0x30: case 0x31: case 0x34 ... 0x37: /* fxxxp sti, st */
-            {
-                int op1;
-
-                op1 = op & 7;
-                if (op >= 0x20) {
-                    gen_helper_fp_arith_STN_ST0(op1, opreg);
-                    if (op >= 0x30) {
-                        gen_helper_fpop(tcg_env);
-                    }
-                } else {
-                    gen_helper_fmov_FT0_STN(tcg_env,
-                                            tcg_constant_i32(opreg));
-                    gen_helper_fp_arith_ST0_FT0(op1);
-                }
+            gen_helper_fp_arith_STN_ST0(op & 7, opreg);
+            if (op >= 0x30) {
+                gen_helper_fpop(tcg_env);
             }
             break;
         case 0x02: /* fcom */
-- 
2.52.0


