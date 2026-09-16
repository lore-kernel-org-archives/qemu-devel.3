Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BE6C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOO-0000YU-Ft; Wed, 16 Sep 2026 09:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNX-0006zO-KF
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:47 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNV-0001W2-KX
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:47 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6b1ae72186eso609754eaf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564124; x=1790168924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iH0DpoHspAJZ8ewpz8NyTpdAhIjvq3CgOw2ddD6E1RU=;
 b=qezE82GnWGGlq6GzuL+po0rfXZbVer5LV+4cdmJ/Vpty1aWUEGZ+3GtCG5Hs+EKezZ
 /Xfc5aEhniho55wSzc/TbECGUHG0hwHlexMVftVoXYqAF8tXxd+X8YH38cduzPREIt14
 bJGsoKmWRbpb03KsrRnDe0ioajx7VIrrsMTNp6gVdxfu+1SVR7wTac78AotE3+0A1oQu
 nSlK57zjjgEvVjpgL2AByWnHoFIVThoV1yJUcHTiPS8kmEiDR6DFsgJ6r3AOpMx5hpPc
 2n6n99RTUDzW7eFQE/JZ7CeG1ZSR32Och/oZJx8k8+HE9mJfJEJQkNmSca7RU+AA13ti
 UpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564124; x=1790168924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iH0DpoHspAJZ8ewpz8NyTpdAhIjvq3CgOw2ddD6E1RU=;
 b=vDFtpf2xhL7y2ndHKsaiJ6OKLmQgfUtWSkbupKO9Aa2KnZeTVYYBqm3jWJpHWU1IMF
 VlZg9tKNmz4WBr7CSLpYyZym8o258EFV556BndjM1eE1MGVQMctmEp3dCz2FufDHB0UE
 sOVptS8osSjKbUQPvrGWDUH1euvbXODoTN+0w+l9jQAkcXqKFSBE1LWuZ9CquLVxHmeH
 GY7au85GVkGha0g9rgkiEjNUOMD9kN8/cZHZhW5TREsN+VQfcLTKTYvPcYW8s7RFyENc
 /C8Ewk+elsFcdt6pxWAVyXO0leL57OM8wQttLGMtrBdSAe9MHlYyqQ/Cg+uFUtAIBe82
 j3vw==
X-Gm-Message-State: AFuF++lCX0xRI2aluNvsPvVSxeNiDUus7ukAI35+ulemj/fexkNHEbso
 ORcksIrJAmiEGFsCaVM+cE9Nh7nsXWlTa53MKR5pvJjT+4uSCs7h4vumzLuj9gkpTeYAP6JJz8h
 E1W9gIGI=
X-Gm-Gg: AYBFou1z/xvC7FGCiMgPbRzCsUoRaeQC111kqu+OStMgePHb0cE3WyLGeKXo5pBT+20
 MdycV5blG+C5HEOJ2suf2IqXym31CP0J/DjH+acuGmWcZut/ywAc+7/FHe0XWeAVFZ1eP28+s8y
 GBcoECJcL96F6W5A4W9gLX77J3p1T5hNL41U2Jw401NG36ooxYSvR7CHmuvUIWD3xZeu2DEzkha
 6Vi6i1WXsd9HVLasrF0LCHOpaavO26uUDS8w0u79ooE/nxitAhJXi40hnPKx12ED8k9n9naSb+5
 OLCTn2L6N77c8E4VvBl78yRnW/bjhdSXdxCmwg8TUi2R89xFZ09Yts98lrJvsJBUX8MdUbXVrHR
 9OcHdKT/8fzxbaduEaom36x//v4P+iv+jzlzyjXSSrysjoT3ZMfdFtS62plQcFlNnk/PwkiH7Hs
 JfkN0K0CoiFbBiNyzI7D+kBg7KrdwMa7niGJhq5BAfu003Mg3TItcz2ucoX6JITVeK0SjEHAPtu
 N6uMqc=
X-Received: by 2002:a05:6820:610:b0:6c3:2390:dc55 with SMTP id
 006d021491bc7-6c7d15d09e3mr2507976eaf.18.1789564124037; 
 Wed, 16 Sep 2026 06:08:44 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 71/92] tcg: Generic expansion of tcg_gen_smin_*
Date: Wed, 16 Sep 2026 03:03:46 -1000
Message-ID: <20260916130409.3382710-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0c.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 84902f5ef72..ada613805fe 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -189,7 +188,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c31c819ebdc..2ccdddc8eeb 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -54,6 +54,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cb729a07789..2882593d909 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1133,6 +1133,15 @@ static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smin, type, 0)) {
+        gen_op_ttt(INDEX_op_smin, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_LT, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1449,15 +1458,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
@@ -1989,15 +1989,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_smin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-- 
2.53.0


