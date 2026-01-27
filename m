Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C498D19515
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfYA-0001Cb-6F; Tue, 27 Jan 2026 04:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXy-0000qY-7W
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXw-000055-LA
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lmfFVbcWrJT9uS49KjY7zFbZY9+4XrAi7p8S+g1LodY=;
 b=cyb8JmdWLp6Xh57TQIhr3bWqaE7Ljnn6jSxkBdeqS+mqNYmg8XDHEOTKoXm3Fw0HzhxSNS
 in6g4pmcsmkDFl0IUQdijlnh3+zOBoPhs0NDOxjtxfCzglNsxpySyDU4VxYAwtnyx22naE
 phVH2SvOorpE2ti2EubQUvQl1vs7v58=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-OorYdARFM7KWmbBDEWDqtA-1; Tue, 27 Jan 2026 04:39:38 -0500
X-MC-Unique: OorYdARFM7KWmbBDEWDqtA-1
X-Mimecast-MFC-AGG-ID: OorYdARFM7KWmbBDEWDqtA_1769506777
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435add03f12so2500902f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506776; x=1770111576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmfFVbcWrJT9uS49KjY7zFbZY9+4XrAi7p8S+g1LodY=;
 b=DKhhvvBew9i/fFgmyWyj+anh2x1C06shVykWsQdn5L4j1DWUT8a+zNgXNNux92Tu/+
 naAItv9f4An6E0darHRL4qWiL0JqqxwCEHde0OTfyhwZBoDS/XrLgFnCkW1KAbr+GkzP
 ivUe+C+WwxsB0jtPWAozieLnz2a4iw9Z+h00pqqdm3OrfYAI1e4elQ25N/CzjLG6ZAth
 KDrpPiRcARvZ5yiIb4wSqe1r8b+/TIE64ttCA2f55FRaVCxhTQLUCRzTGBSsW2MlYau0
 JsP83R6a3zyOMgC6AiXs2lG0X+O5hjcVAIMo/aSQyRaE7DFUmrvjSmgnPThBQuL/7izK
 f2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506776; x=1770111576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lmfFVbcWrJT9uS49KjY7zFbZY9+4XrAi7p8S+g1LodY=;
 b=WvJXR0NrbEqMOgN3kLAYBfCuWzjb20WjOEf0RYst9q4ikzok9oiIBaHfEgicIhUjBG
 IblhWmF5eeY/qINGgnb+Ug977C+tlmisFKP7mtqfXXnpCJPp7m5DqMTh8JDwvID3bYXB
 HvANFhGL6aYJnYDfoSvke9lVSnfJ7O9tfeFwWsNV6yjwtXyHFXf362vBQvYF3Uyms8Su
 poWFFspvAhPs3o6Mz+PPSs9RNVOnpYnPm3pzi7BZ/10caSh1ldt7+xqxsFtEPc84svmb
 qTPdTVXvj0+ueyc8NK6ZoGKGrmKRt7YI/t7tIQ5k6U5qp/k6IgublcCeIBNh0PRDpdon
 7nIg==
X-Gm-Message-State: AOJu0YzkFGtNVaTe62bo2M2wwrt7jy886KbEOBA3G095YyBYjM1trnWN
 lUqD5OtCcXLwViTooOR0pGE2je2Y7PPVWerYBm1eESqa795mk/pFhvkDUYmwMaerHh6axB1Lsuy
 QPPua6REz1LrnoQdZRFEe5zisHcs9qEHlxzi2CmLR/HzSL/n+a6uy/uwv/ecQfgtq/iY52cM+I7
 hN9qRcDYJQTKPW1tNUQEHHQ4DWf53H4sxGCaplJ/pj
X-Gm-Gg: AZuq6aJP5Mz44vfGvm+tDeFOu4gLenjScM1Zjl5p+ulTV1dTzDmH8tvWfziIV7jhMg4
 ZYhC1bkk4h76MRzN0t/aPgw8bb+RWQisU6BontuBTMTDFwokdBQ0bJZ1qZeXtc9G92CLqsW++Ql
 YkvLjDY5kva5Gh+AvfvYS79aPy32Ro0Yq1G2Vs77jTQ0CAV3pAYpqH22XQy7sa4UeoZlUF6u2Xv
 XklQVGiMqUNW2uDHWEX+ieeEucuE41qAxDjG0kEEMUteJFEjbOvVJhyAWzFYULbKH5pLgdd7TfB
 QcarpRV0QaWflATj/Up1SjWanlZ9bEwV1kpe0anjeoNUOVMVfIdMbRpQysJh1iOgWY1GqeL6XFi
 mLD0SFDZW1J6ThHcJeEuuA/BsaBiYxmFALEX+R5kt0za7ioidi4moYX3Qw0PGnTEc/W7FWvbfTy
 TmA3cbaahfqchUyQ==
X-Received: by 2002:a05:6000:40ce:b0:435:a59c:c33e with SMTP id
 ffacd0b85a97d-435dd1d85bdmr1458893f8f.60.1769506775902; 
 Tue, 27 Jan 2026 01:39:35 -0800 (PST)
X-Received: by 2002:a05:6000:40ce:b0:435:a59c:c33e with SMTP id
 ffacd0b85a97d-435dd1d85bdmr1458841f8f.60.1769506775317; 
 Tue, 27 Jan 2026 01:39:35 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f74b15sm36627493f8f.35.2026.01.27.01.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/13] target/i386/tcg: cleanup #ifdef TARGET_X86_64
Date: Tue, 27 Jan 2026 10:39:05 +0100
Message-ID: <20260127093906.353741-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
+	g_assert_not_reached();
     }
 
     return cc_src;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index f23c401189b..ce636b6c56c 100644
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
 
@@ -2876,7 +2882,7 @@ static inline void gen_pextr(DisasContext *s, X86DecodedInsn *decode, MemOp ot)
         tcg_gen_ld_tl(s->T0, tcg_env, vector_elem_offset(&decode->op[1], ot, val));
         break;
     default:
-        abort();
+        g_assert_not_reached();
     }
 }
 
@@ -2923,7 +2929,7 @@ static inline void gen_pinsr(DisasContext *s, X86DecodedInsn *decode, MemOp ot)
         tcg_gen_st_tl(s->T1, tcg_env, vector_elem_offset(&decode->op[0], ot, val));
         break;
     default:
-        abort();
+        g_assert_not_reached();
     }
 }
 
-- 
2.52.0


