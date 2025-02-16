Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3E2C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnt9-00026G-JY; Sun, 16 Feb 2025 18:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt1-0001cV-Q8
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:20 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnsy-0005zk-J1
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:19 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22128b7d587so7779465ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747834; x=1740352634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fSC2EsX0/WhXShf2+ndFfKEWyKRgAqBPjTdEn8UDJ2c=;
 b=jAs3Fx5wHIvYMfPHa/W6aCYwW+6CduPRCZq7UR+z/CwUE7PWxhrtoHPGTQ17CRel8b
 Xiko3+mYdi+cLf+Zf/sCH11TyrQ34EMV+deKFTMyxnFLHAu0Rkp0TewTPhvXY653az1K
 HbtLvYfmogB5N3tjM0vpEHqcnwC1Y2IgBa9rwCU7CSK6BWNM7HkiUJfs8zVBQwwTkIBh
 dLwrMmtvsWqa5g1rbwF0n4PNgPeTmYAua6SUV9NPAxlJwND9cy6jIVt4jq6aU1Bpac2J
 VYapPOWEFH6SG2EtfmJhkCke95p+SMdMzhbgMsUJRZwRbTABFiNo9DDlKgX7CUcdL8Ty
 WcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747834; x=1740352634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSC2EsX0/WhXShf2+ndFfKEWyKRgAqBPjTdEn8UDJ2c=;
 b=uPIIfkAxNc8hS9iRTHnYr5awQKktpCi2i37b+ynKjLOBeYQA9V6XUwN3/Asuhp0/WL
 geZ6ibrbxt03n39iXO9tvek02WiT/hv/RUxwH/PCX0kXdSXdoCkFQ4RxQigHma4NlJQW
 LWaqu35HB0bdkSlM0NKMtX3FVdWgs/00Al1sKyHzM+53OGyUIEpbyJr/P1DTRSJEi6WX
 v2XDq0WwoXIjE/kHo+dVJ3+F+ijEW+s5z/8k+JOC5e0tcrXffLOVaAQPQX9PC5Qkvm0Q
 u6CV1W1I4et1r3KV6AgG9s7y0WT2O6LhyEDGuWOktbcVKUw7xhDTz75hhPfqwu9TgD6y
 ssKw==
X-Gm-Message-State: AOJu0YwRAI0BC1JhFdR2XnG4bNNyDKf6Mhnu/gvYKZl0h+XvLrzYcSin
 0EmiW9PKWuv2QQ2YOTVcy1zAjrEgzoTpU4DnbQV+lrj2by2Ts7cQaziaVM5LkzHKbVnb0g9aM0L
 B
X-Gm-Gg: ASbGncvZ7F2UlTEk2hVMipI4/HfHqSHSgFfLGz85EvdsPkS7iqjprIJ9i1dRkCT0zAO
 UJXh4OrXsXr37mDHYS+CUsmaxeSrE5knZR9gVLPhsQTeuxU6MGFV9Am+T/GLfMiZTcvqIehPag4
 Ck+fUhGLi8D1eL3WuuxCQLCQbk/iPi5hH88jWmmz0KROQ8GfhjapEF7t1XIs/LgELxbMZCsRW1d
 DhqMdwfuFPNmCKoF+4AWIvRAFWGe7auP11t86TRCkz0YUu0mRZu5m4BShIm31F9uD7swDzNu0pA
 ZTilNBmVyxwEkHKbQTtMCJNKuE47uprGGDmdfFGkowYZkjo=
X-Google-Smtp-Source: AGHT+IGeWwFYzU4uWeq89R2D9iTFYEAlZi6bqPMxCY/wCeFq6ON/0uNYsijYPArZEiypGXhzk5vlWg==
X-Received: by 2002:a17:902:da8c:b0:220:c2bf:e8c6 with SMTP id
 d9443c01a7336-221040c0b88mr121922525ad.53.1739747834622; 
 Sun, 16 Feb 2025 15:17:14 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 082/162] tcg/arm: Expand arguments to tcg_out_cmp2
Date: Sun, 16 Feb 2025 15:08:51 -0800
Message-ID: <20250216231012.2808572-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Pass explicit arguments instead of arrays.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index a5c1325805..993564d424 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1260,17 +1260,9 @@ static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
     }
 }
 
-static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
-                            const int *const_args)
+static TCGCond tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                            TCGArg bl, bool const_bl, TCGArg bh, bool const_bh)
 {
-    TCGReg al = args[0];
-    TCGReg ah = args[1];
-    TCGArg bl = args[2];
-    TCGArg bh = args[3];
-    TCGCond cond = args[4];
-    int const_bl = const_args[2];
-    int const_bh = const_args[3];
-
     switch (cond) {
     case TCG_COND_EQ:
     case TCG_COND_NE:
@@ -2350,11 +2342,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_brcond2_i32:
-        c = tcg_out_cmp2(s, args, const_args);
+        c = tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
+                         args[3], const_args[3]);
         tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[5]));
         break;
     case INDEX_op_setcond2_i32:
-        c = tcg_out_cmp2(s, args + 1, const_args + 1);
+        c = tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
+                         args[4], const_args[4]);
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c], ARITH_MOV, args[0], 0, 1);
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
                         ARITH_MOV, args[0], 0, 0);
-- 
2.43.0


