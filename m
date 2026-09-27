Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208D1C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAknu-0004dA-Ox; Sun, 27 Sep 2026 05:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknm-0004R8-J0
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:09 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkni-0007bx-HW
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:04 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0d2c37b0bso559094a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499838; x=1791104638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iTIACFZlpb8fjn4V2Ry/VlSxOGd96VijXrnH2l6hUuk=;
 b=zNCiKthCnqp1mpi/i/n+Xl8DKkH46lV2tUyLTneryrcIwiw8ml6nlOerXHHWdOWe8J
 E3EY40sPqnM6TkeEZOkOJosWFTL86elT88a7cZlU7Hoh180BpNImYIIMMy8V3CcDkKdV
 QKRnwju2hjeT6aDSX5ymtg97VQeI/hBJKMQKYDw2fvnfyRYiSJM6loRW2Dm+hWgxt0bO
 wTk8hzZXD6UVq5q6gLetKDGQiwH+pFiJIF5r5oTs+OKSnlnBW4K5dOQKiXWOu+9f06pO
 a7iDa3KcOBMWL8mePmbc7bEj9R3v6GBo9gHh/jVtsQqle4ffQcFGR+PwfdbFYaX78PZH
 ZV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499838; x=1791104638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iTIACFZlpb8fjn4V2Ry/VlSxOGd96VijXrnH2l6hUuk=;
 b=MAXdizVgAHplTJyWJxX6DOMeCBynybaWVXfdN2F0cs9/RAnYjjTkWAfWAuxhl+OW1L
 uC8xxNe/NwoVXZOYCLNOFQlPGOioDmTcny0oiEKepoVInVvyHi3ukWMiJDLiHMVO+c1Q
 T0UTc6sRjnEwUoeVX4/yOXiDr/hP8DuMlPeV4GGuvL2+RmPFmm/Sws30XaR0rc+AiArM
 Goj7c3nfiD1z/W1VyECMsJr0in7zhYNYQRdguiQEO6mJnUFqi9JdrWJ+CP4GXGvsp3VK
 ph0PSfcb6iNUTNqV/2rGEy5uP49dNASVYCrsvLxUTXAclr+N3HJs5x8jxalkLtVlN4Mj
 SZfQ==
X-Gm-Message-State: AFq9FYIlsEmDLOOVjihNmupkPtJQLUAUMLlvaSnceTEIYPWLmgY80ndh
 6mJVfHIddz/+NZ77IeSyt2oeJBta/m7oNzcYP5yXQOOrh8AzlqKOzx3dBSL+sDtNm2FSH8Sfe9I
 f0gwL
X-Gm-Gg: AYBFou2vAE3TwZCm6scKrn5Jl9obP+RN5+QHmQFIIWKY2b4gGLUB325uYOuJfwgYPPp
 RMl67ZVO2TvSTPzPwd7zEpFS1OJxUJBiVHvjAY8LITU2TSqLBV1b8e1kR794NS0xvUJwyDTEMId
 8SUZ4AEFEBUtalfHoik9f7aC45Fu+sSwcqx7Lm4AltC+IJiX1vPAZeFIvwx26+/VNt6LARihItc
 /VpXe6rb3m9Nj+7WjJI1pd/3+Oi71CnIJOzYV6RGmuDsPuADgLdw/WquAdusDMalS8hEyCyV7jj
 1Is+0ZOimb+EAO1p5sPoBkhXZumUUSeB5b7w3+fGEsov8No1yEG537QfgwviS6qazCUOaze2Qca
 MXqBl8ljP2hgt69pECeJRhjOv5zLIG7eolBgKrpeOx4I+Qp9Xe5vI+GmAlnaIJgol9YGKnbTf4L
 0EQfksm/5PnD/qQJWrNzcjzxwToj507cHRrxB5+22L9NUdqyrh93rQbKJ4sdzen8L9MHp2EVJzG
 j0qw7xCBVcswB16W7oGAaP1rSif4f7kxoC8a2VpLw==
X-Received: by 2002:a17:90b:4a82:b0:3a0:e1f7:9b04 with SMTP id
 98e67ed59e1d1-3a0e1f79c82mr3093202a91.12.1790499837518; 
 Sun, 27 Sep 2026 02:03:57 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:03:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 044/101] tcg: Generic expansion of tcg_gen_brcondi_*
Date: Sun, 27 Sep 2026 01:59:14 -0700
Message-ID: <20260927090011.10724-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 20 ++++++--------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e1dcd18bf0d..8540c30a58a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -218,7 +217,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 10ed0438fd5..a863215ffe3 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
+DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9a22791be0d..75d965d40ab 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -426,6 +426,12 @@ void tcg_gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
     }
 }
 
+void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
+                     int64_t src2, TCGLabel *l)
+{
+    tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -685,15 +691,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
-    }
-}
-
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1484,11 +1481,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
-{
-    tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-}
-
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2)
 {
-- 
2.53.0


