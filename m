Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEA6D41174
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLbj-0003VI-DU; Thu, 15 Jan 2026 06:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbT-0001rA-0y
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbR-0003zY-09
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768476804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GIEIKKsDu75oTOgKWohyN3yLE0yP/Hdhh/xZUygdU8=;
 b=TIqNPubm5JD59nWq7ioNplWFZLAUt/isWPfd3K/30SicI+HGCYubKi24QfrF1Tm1vIEFBp
 83M0jAVpWXPrPrXDTTVDtW6LeQUmRFgw/O13OSoTQC8VP5/UsN+2g62mvwGr1OCtaWsnTw
 KYY1MdTqQEt1xT2qcPn1CS++lriXOWI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-cNzW7x17OVOJ6TQHXRkXMg-1; Thu, 15 Jan 2026 06:33:23 -0500
X-MC-Unique: cNzW7x17OVOJ6TQHXRkXMg-1
X-Mimecast-MFC-AGG-ID: cNzW7x17OVOJ6TQHXRkXMg_1768476802
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ee71f0244so8581545e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768476801; x=1769081601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GIEIKKsDu75oTOgKWohyN3yLE0yP/Hdhh/xZUygdU8=;
 b=KBj8PQDFG6da8Jx9tu2U1Zogc25NjLAWHDlnBmRnGxGuREgJhk7JuuYOCS0fxhpA8A
 ip12PNZXwdx4JEV0f1WlbNKwNzmMADdi1pONaZa4dlA5ZIbCFWG0cTidFYzODZj/hN1U
 G3AlAoKNSNSYGQw23MIBuIi6JpaFP8yfiGBdE+noYchdf/rhUmGXttJHItDmt+4rGfyX
 oEKrKlP0ClkBVWZPs43GARpxnMfgaXP6jfmDDinPh9Q626Dvu0GZT8xOpc+KcTYdLBan
 qImyUC7TWJAh66OFRajA8n+r+YX/RotU6kWIFT5VZIvC9aeydVpRbK1MFsrlII9LUleH
 aO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768476801; x=1769081601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3GIEIKKsDu75oTOgKWohyN3yLE0yP/Hdhh/xZUygdU8=;
 b=CSETk9uaw5vgYeahTmYSZVHzAe3r8TcDDzM3Jo9AT7zJu2PqZgWBHEdjREpqJ8/hIn
 twn4Eq12WlwZd7t0DPIGZ9facMW3qlmyIYu9o7p4rHVYe/7LFfDso3ylSK2wjQsMYJya
 OlvU7Phi/NQrjPY+rk7uWkF/giQYtJq9q5CuIr2nl1mBkrrdbT4td7+sp1TZu3LCER8Q
 tIAfR+0FDamxNsE+FkJHlFjdAC5G/thJSbWQjIynazmalQJevQ6t+725YbUsb2ry5p+C
 kKFvxn4fSM53SOC1PwCIw7/ARmjMOwcDbMln7qwyc+qum+1CCRIxQxMXW8EryKh7mXys
 zlbA==
X-Gm-Message-State: AOJu0Yx+bGJotu/kfVOzhj31iNrh2c4aIltoaDStX9vjThVz/OvnaiTt
 I16zJ64lCaMdZhIoxAs4iRu8/8BNQFghJwUUH3m1Rf+ZSWNpKRArrymbqoWWcHX3E1oqe7Vxx6k
 bOsN+tjxKDqauAykVpXu8KAoHpFxA26Dl45VQamQehPogSkOrlHFtx1VZHk3ftBgGRZohCAJNQy
 PrbvESrS377cy5RKUZR6olO+0w+ysJR0jcK0Ju2ZYk
X-Gm-Gg: AY/fxX6vkWQV3pKNJg2B71LNjty66JSRwfX5SiJu6GZOjGKGfkQeTV2fVfWmbSgBhW/
 xKLfM8rlsMv5GTlozT6kHxESX55LiJcv6Y4UB57I879E7WN9FQZ402LL3khGsqhlGzJO+1puKni
 uFM7KVv4b7Q+8K2Ll3ZeiE4aDJrWjXY9ZXQ9iF9Zy43Nqoka/WVp7Va6JttuL+uIuqmXVL2AefB
 mx14NiCZCOzY9DTGHrfSzOg+2uaXOedNXKXttL6jazSxyxDWHqzjW2EwnFQnqLxhzX1xuFCmGe6
 4KIla85JMjyfbjMEthJr45ycSRv1+yLPNF6qzAmuX7TAlGO6zWmU7x4ahu0G2bmWTg8O9gPMfLJ
 V9fbA0+1/DsU7+HFboU9WreWOyfL0wZ/cwzWajym+QI0OA5CHyvUw+iYsFuuCIaaXrRt1ZyAb3G
 d4y8oy+VlwJE2XFg==
X-Received: by 2002:a05:600c:3487:b0:477:9f34:17b8 with SMTP id
 5b1f17b1804b1-47ee47bbe36mr68749875e9.1.1768476801321; 
 Thu, 15 Jan 2026 03:33:21 -0800 (PST)
X-Received: by 2002:a05:600c:3487:b0:477:9f34:17b8 with SMTP id
 5b1f17b1804b1-47ee47bbe36mr68749335e9.1.1768476800740; 
 Thu, 15 Jan 2026 03:33:20 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428afd9csm42300215e9.6.2026.01.15.03.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:33:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 6/6] target/i386/tcg: cleanup #ifdef TARGET_X86_64
Date: Thu, 15 Jan 2026 12:33:06 +0100
Message-ID: <20260115113306.126905-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115113306.126905-1-pbonzini@redhat.com>
References: <20260115113306.126905-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

32-bit TCG opcodes produced for the i386 target usually looks the same
as 64-bit TCG opcodes produced for the x86_64.  The special one that
needs extensions is 32-bit TCG opcodes produced for the x86_64 target.
Make all #ifdefs look the same, like this:

    case MO_32:
  #ifdef TARGET_X86_64
      /* code using 32-bit opcodes */

    case MO_64:
  #endif
      /* code using target_long opcodes */

  default:
    g_assert_not_reached();

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 11 ++++++-----
 target/i386/tcg/emit.c.inc  | 18 ++++++++++++------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 20aa94347b0..7186517239c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -430,17 +430,15 @@ static TCGv gen_op_deposit_reg_v(DisasContext *s, MemOp ot, int reg, TCGv dest,
         tcg_gen_deposit_tl(dest, cpu_regs[reg], t0, 0, 16);
         break;
     case MO_32:
-        /* For x86_64, this sets the higher half of register to zero.
-           For i386, this is equivalent to a mov. */
+#ifdef TARGET_X86_64
         dest = dest ? dest : cpu_regs[reg];
         tcg_gen_ext32u_tl(dest, t0);
         break;
-#ifdef TARGET_X86_64
     case MO_64:
+#endif
         dest = dest ? dest : cpu_regs[reg];
         tcg_gen_mov_tl(dest, t0);
         break;
-#endif
     default:
         g_assert_not_reached();
     }
@@ -1585,8 +1583,8 @@ static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
             tcg_gen_shri_i64(s->T0, s->T0, 32);
         }
         break;
+    case MO_64:
 #endif
-    default:
         hishift = tcg_temp_new();
         tcg_gen_subi_tl(tmp, count, 1);
         if (is_right) {
@@ -1615,6 +1613,9 @@ static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
                            tcg_constant_tl(0), s->T1);
         tcg_gen_or_tl(s->T0, s->T0, s->T1);
         break;
+
+    default:
+        g_assert_not_reached();
     }
 
     return cc_src;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index f5f12e48b77..ca0ee4d630d 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1236,8 +1236,8 @@ static void gen_ADCOX(DisasContext *s, X86DecodedInsn *decode, int cc_op)
     }
 
     switch (ot) {
-#ifdef TARGET_X86_64
     case MO_32:
+#ifdef TARGET_X86_64
         /* If TL is 64-bit just do everything in 64-bit arithmetic.  */
         tcg_gen_ext32u_tl(s->T0, s->T0);
         tcg_gen_ext32u_tl(s->T1, s->T1);
@@ -1245,12 +1245,16 @@ static void gen_ADCOX(DisasContext *s, X86DecodedInsn *decode, int cc_op)
         tcg_gen_add_i64(s->T0, s->T0, carry_in);
         tcg_gen_shri_i64(*carry_out, s->T0, 32);
         break;
+
+    case MO_64:
 #endif
-    default:
         zero = tcg_constant_tl(0);
         tcg_gen_add2_tl(s->T0, *carry_out, s->T0, zero, carry_in, zero);
         tcg_gen_add2_tl(s->T0, *carry_out, s->T0, *carry_out, s->T1, zero);
         break;
+
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -1991,7 +1995,6 @@ static void gen_DIV(DisasContext *s, X86DecodedInsn *decode)
     case MO_16:
         gen_helper_divw_AX(tcg_env, s->T0);
         break;
-    default:
     case MO_32:
         gen_helper_divl_EAX(tcg_env, s->T0);
         break;
@@ -2000,6 +2003,8 @@ static void gen_DIV(DisasContext *s, X86DecodedInsn *decode)
         gen_helper_divq_EAX(tcg_env, s->T0);
         break;
 #endif
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -2065,7 +2070,6 @@ static void gen_IDIV(DisasContext *s, X86DecodedInsn *decode)
     case MO_16:
         gen_helper_idivw_AX(tcg_env, s->T0);
         break;
-    default:
     case MO_32:
         gen_helper_idivl_EAX(tcg_env, s->T0);
         break;
@@ -2074,6 +2078,8 @@ static void gen_IDIV(DisasContext *s, X86DecodedInsn *decode)
         gen_helper_idivq_EAX(tcg_env, s->T0);
         break;
 #endif
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -2895,7 +2901,7 @@ static inline void gen_pextr(DisasContext *s, X86DecodedInsn *decode, MemOp ot)
         tcg_gen_ld_tl(s->T0, tcg_env, vector_elem_offset(&decode->op[1], ot, val));
         break;
     default:
-        abort();
+        g_assert_not_reached();
     }
 }
 
@@ -2942,7 +2948,7 @@ static inline void gen_pinsr(DisasContext *s, X86DecodedInsn *decode, MemOp ot)
         tcg_gen_st_tl(s->T1, tcg_env, vector_elem_offset(&decode->op[0], ot, val));
         break;
     default:
-        abort();
+        g_assert_not_reached();
     }
 }
 
-- 
2.52.0


