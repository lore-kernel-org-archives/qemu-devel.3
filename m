Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E373C87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 23:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uktCq-0005j1-SS; Sat, 09 Aug 2025 19:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uktCn-0005i6-EY
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:42:31 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uktCl-0005hI-UJ
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:42:29 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4af123c6fc4so32601251cf.0
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 16:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754782947; x=1755387747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1G3tyzVolSQP8KoEaSpUQ9g+A1OBOYb9Sx6tiF8VyrU=;
 b=DdRArAb/VU1mvSPtWEeUaeqV1AUmOlUDHlmGHEWWoKg/peTAn7ZZHcGpFI39i26Vkp
 H21XQ0L7a3iSBOya3b5/7f2oj06gi9pd2pHmyTJQ1XKgGRPJRpFKSlU26qI2n4w2m2c3
 BIBAIAtbsZaCB66ZTME/2nw8YaFy00KfIpw0KyDl6NQkkLG7meODS/4awcb7PKnh2zpk
 7lpO8o745fE/5uxMTKIaO+fz24JmeDguZmTjoI5vkqTlZj2VRc6eQOXadjusvzhkENA5
 dMzmswxcoUFGt90+RFZOqIG71sYD7B2KuZ8RQ2ndQRHZb4DO+v3jnBNBLqlTEiaWn3Ga
 04Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754782947; x=1755387747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1G3tyzVolSQP8KoEaSpUQ9g+A1OBOYb9Sx6tiF8VyrU=;
 b=xKn+sk8aecMrd1ps8YEw5/Ih+vmbHYXGyBQPPTtdoQtKIr2duPB1XDF/QkHHSIWGb/
 1jIUhokXBZ+E8KPFUzzTH8NI3sCcGM2O0xvDROvaIdK8wl973leB+MjbBKW3RwhGxSNL
 VDEqfzY1jrg+ZG7QF3YQwX05b3BbkO9auuEHaHerixZrbLS7IR3GLydAwajMwoELN/1r
 2lTcMjcYP9aUWqiioUV78I7HU3kzgr5ZrXqSaMlOeevL/dSOaaNXQOE5uo4JVQIXrIS2
 8Qxt8D+4IiMvK4r2DMZRMdUA39Gsil3XK2cbz7OCzqgSBvGvtZVytgQk4sdFt9OUHG0D
 GyXQ==
X-Gm-Message-State: AOJu0YxtB5T/K1Dbb96IrjDlfmMIfeaMemXbYM1VTTqQ8TyXXGf849fh
 Mj02tS/BMC/UyaJcXs/GjzDS+1J4n+2jGG6lwIJw6CkXXueFxoPuhlQtoRtwfztDQIZ9wmiCYOj
 DrIMO
X-Gm-Gg: ASbGncuLbdskMlzRAiIihr8SFP511LbcBlzZ2uJhS62AIYI5vwstHEqAu8T4U1zmlbX
 7jQg8SkPnIQKuhYKDj9lztKBrJ3r37eE2KE8Tdp25QQcz6yMNfcCgvBaLfRX96nxJbGkeTG041s
 eORfHB8PF/p+Lj1vrKFl5+yWKHVeUFkqMopeoKhxEBEwzYJ9yYl68a11wBkqgPFKpmP/Yi5KYfS
 Z0k+FozvV/R7zNdQYS3+HXawVSgVCHK4HX163vlmmr9Cg692zzWccegbawq6Qc5BhbfP0XYxU2r
 htQsjFaz1hX50LNP4h2ct4yO9r/JYe2HZ6J48bqjQ+wCNsju/a8UCLy57JwKL9jbMtzBDBhDWfu
 yCVzluWW4Jp5dawEpVmKROHN0HYgEF+o/qzywe+4Tsej+DmMTSt8b89SUSWs3LAQpcLPpIp4MnV
 /+6DYVQj3rTNaciRA=
X-Google-Smtp-Source: AGHT+IG6ggpVHmSVNk2CXSnmU9eSl/24yzgwXrGosTdvYV0PzaaG6CW/7xd44h4+RytRe2tLULaBVw==
X-Received: by 2002:ac8:5850:0:b0:4b0:89c2:68e0 with SMTP id
 d75a77b69052e-4b0aed91060mr131000931cf.60.1754782946766; 
 Sat, 09 Aug 2025 16:42:26 -0700 (PDT)
Received: from stoup.. ([172.58.166.125]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077cd56226sm132135636d6.44.2025.08.09.16.42.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Aug 2025 16:42:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] tcg/i386: Add INDEX_op_x86_vgf2p8affineqb_vec
Date: Sun, 10 Aug 2025 09:42:07 +1000
Message-ID: <20250809234208.12158-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250809234208.12158-1-richard.henderson@linaro.org>
References: <20250809234208.12158-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a backend-specific opcode for expanding the
GFNI vgf2p8affineqb instruction, which we can use
for expanding 8-bit immediate shifts and rotates.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-opc.h.inc | 1 +
 tcg/i386/tcg-target.c.inc     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tcg/i386/tcg-target-opc.h.inc b/tcg/i386/tcg-target-opc.h.inc
index 8cc0dbaeaf..8a5cb34dbe 100644
--- a/tcg/i386/tcg-target-opc.h.inc
+++ b/tcg/i386/tcg-target-opc.h.inc
@@ -35,3 +35,4 @@ DEF(x86_punpckh_vec, 1, 2, 0, TCG_OPF_VECTOR)
 DEF(x86_vpshldi_vec, 1, 2, 1, TCG_OPF_VECTOR)
 DEF(x86_vpshldv_vec, 1, 3, 0, TCG_OPF_VECTOR)
 DEF(x86_vpshrdv_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(x86_vgf2p8affineqb_vec, 1, 2, 1, TCG_OPF_VECTOR)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 088c6c9264..9dd588fc41 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -451,6 +451,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_VPBROADCASTW (0x79 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTD (0x58 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTQ (0x59 | P_EXT38 | P_DATA16)
+#define OPC_VGF2P8AFFINEQB (0xce | P_EXT3A | P_DATA16 | P_VEXW)
 #define OPC_VPMOVM2B    (0x28 | P_EXT38 | P_SIMDF3 | P_EVEX)
 #define OPC_VPMOVM2W    (0x28 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
 #define OPC_VPMOVM2D    (0x38 | P_EXT38 | P_SIMDF3 | P_EVEX)
@@ -4084,6 +4085,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = vpshldi_insn[vece];
         sub = args[3];
         goto gen_simd_imm8;
+    case INDEX_op_x86_vgf2p8affineqb_vec:
+        insn = OPC_VGF2P8AFFINEQB;
+        sub = args[3];
+        goto gen_simd_imm8;
 
     case INDEX_op_not_vec:
         insn = OPC_VPTERNLOGQ;
@@ -4188,6 +4193,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_x86_punpckl_vec:
     case INDEX_op_x86_punpckh_vec:
     case INDEX_op_x86_vpshldi_vec:
+    case INDEX_op_x86_vgf2p8affineqb_vec:
 #if TCG_TARGET_REG_BITS == 32
     case INDEX_op_dup2_vec:
 #endif
-- 
2.43.0


