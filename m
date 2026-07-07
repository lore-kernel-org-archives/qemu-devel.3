Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70874C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whCs2-0004Oa-N7; Tue, 07 Jul 2026 16:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCs1-0004No-D7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:21 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCrz-0003Uz-R7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:21 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2caed617615so204555ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783457898; x=1784062698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uewRDOC/H1Jp6765rXTUlsAYMglZskvHQznabA1q3mc=;
 b=lKEixj3fvhF0cHL787A/dfIz2fy5aatW6vIBqDqsYXuXiFzyh55hzc7rwVBE+eJiKV
 870mZvtnbrcullKApIbcD2OXO+4YAV7YYcPG2BgnPA+h/oLexSt2Bnsin1iBb0cATg5d
 R/4b04LhmAbQf9RQyXYxrErqDqxxrE007lwmey86MztHnIq64PPrXkQp/+t7WHc1Thrm
 Gxqsl25EneyzIh4hoMddyV9EBVqIG7RVEOQ6N24uijeSvK4RsxY+pzSJgDjk0nmxxrJP
 +woyzozhILGr4sGmX76mSaQgfvoPAEYOAU3z97CDKDO7LcbHxwdTiH7vuUTVWwAytRMH
 /NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783457898; x=1784062698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uewRDOC/H1Jp6765rXTUlsAYMglZskvHQznabA1q3mc=;
 b=ZpOPfN2oWp1CUysT8s8VQcOtKqFZa9ypJAeCkpwHioTasRNnQSM9bTzfo28TPxnx6Y
 EjW+6GlJ6EFOWkKq6vuHXNlMK7hJPuc+1b+m9SxSpePgy3C2mz2nzgbxLtWvEP4GlL+P
 2XLXfCV8hwIKBrEQ2WH8HWjcD97UilSMyvW70fyqaU6OQzUboVvKo/uKldXQRmoE5/Dy
 VPpf1cdsdIVBjen1Pf4I87EXabJ65bY27R0WfMzEGzM0aohaRudOfU8Fi2SWtiG2B8IA
 U5s5itqaVWNrhrAvLMlQTrf+iiA8Q764W11Tg+Nq1E1oRCuAOQt1LbpMtf8S2nVEOyw2
 2Ecw==
X-Gm-Message-State: AOJu0YxQrQKf4GDAOL0fK/rNgYhHog3tGP3ljUjnzIwDjmiqFIDbTuf8
 6+QI1lr7QmHASyc6RNJpPw4KrhX2dmeo35FdSG9IT5du4DT/EZqVe9fFwDZdPaUoD3wRViKWY5V
 iDN/d
X-Gm-Gg: AfdE7ckTwKhyUKaMP1E2Fal6HxV+DOcJTnJXJQhae4cVlisd7d9PBzPeecnd6GLpU9L
 bUUWrrpmYqQs0xrwgnIP8GjBnpFFVp0OEcjQC8hZj0+M1Vh1L9bQfwCvLIV9+PvxmvsR8k4MFVX
 zQC5K8pYpu0l+SfM54xr1822kO9cJJp4qoxYEd2FTipkr2Dka7xVySAByDL4J3LRW9xFITdUtr9
 hMHEmtzijSBREkjQL9UbeJKDf8m6ODJTx2LIisYrODXHgzAVnG37Asnrx2rTWTJC/IxrqFju/KS
 4GuomPmoGHY+7F5Qa3zffRPY3eZWlAeID0yqHUFmCRtBAcaa3VioXs4mdqn1Q8sy/3Bu/od45+Q
 xJqEkaoKL494qO8TRCd2o4AM4cTieJDjEfEunM2rppdBwk/3T9qKBXyuJ7KZryZgwnQkYEE49Gg
 upRt6cHdmFdUv/TgE1h7WCoYDxnpWeTajHSYoc32iz7RkmOxw=
X-Received: by 2002:a17:902:f607:b0:2ca:bf68:2a54 with SMTP id
 d9443c01a7336-2ccbed285cdmr59370625ad.22.1783457898243; 
 Tue, 07 Jul 2026 13:58:18 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc2asm17980575ad.69.2026.07.07.13.58.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 13:58:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] tcg/loongarch64: Fix cmp_vec with TCG_COND_NE
Date: Tue,  7 Jul 2026 13:58:10 -0700
Message-ID: <20260707205810.303376-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707205810.303376-1-richard.henderson@linaro.org>
References: <20260707205810.303376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

For NE we need to invert EQ, not swap operands.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3589
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260623140609.645445-1-richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 39 +++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c3350c90fc..182dcfd5eb 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2371,19 +2371,36 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                 default:
                     g_assert_not_reached();
                 }
-                break;
-            }
-
-            insn = cmp_vec_insn[cond][lasx][vece];
-            if (insn == 0) {
-                TCGArg t;
-                t = a1, a1 = a2, a2 = t;
-                cond = tcg_swap_cond(cond);
-                insn = cmp_vec_insn[cond][lasx][vece];
-                tcg_debug_assert(insn != 0);
+            } else {
+                switch (cond) {
+                case TCG_COND_EQ:
+                case TCG_COND_LE:
+                case TCG_COND_LEU:
+                case TCG_COND_LT:
+                case TCG_COND_LTU:
+                    insn = cmp_vec_insn[cond][lasx][vece];
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+                    break;
+                case TCG_COND_GE:
+                case TCG_COND_GEU:
+                case TCG_COND_GT:
+                case TCG_COND_GTU:
+                    insn = cmp_vec_insn[tcg_swap_cond(cond)][lasx][vece];
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a2, a1));
+                    break;
+                case TCG_COND_NE:
+                    /* ne -> not(eq) */
+                    insn = cmp_vec_insn[TCG_COND_EQ][lasx][vece];
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+                    insn = lasx ? OPC_XVNOR_V : OPC_VNOR_V;
+                    tcg_out32(s, encode_vdvjvk_insn(insn, a0, a0, a0));
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
             }
         }
-        goto vdvjvk;
+        break;
     case INDEX_op_add_vec:
         tcg_out_addsub_vec(s, lasx, vece, a0, a1, a2, const_args[2], true);
         break;
-- 
2.43.0


