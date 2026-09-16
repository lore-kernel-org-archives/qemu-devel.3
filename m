Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4144AC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNg-0007Ob-QW; Wed, 16 Sep 2026 09:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNC-0006jy-EW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:34 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN9-0001Q4-O9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:26 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-39647184c73so1749653a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564102; x=1790168902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=04S0qWop5fX0Gcp0Ft47jb0t0Af6HcVbG2drnJ91rdE=;
 b=likLCPKjKRkNg66k3Z4DcaOuV6U7KAGxyLGmnlO+10OBBNe93LS3lRi1ST6AGym8mn
 o2rHFnvIBY5Y1w1kD1+lFjPnBm94IGCPwp+j4eMc4SqwqpTkHTrtzXc02nCHmsvQxSQh
 OyHNrSJtRa/VXoCKmy7PwD+/7Id7tFDRaALv6dFjM2YM8TAz4nzbpPPVtG8mwZcCqKp7
 /JRJaeoJB0VVLgme/guUXQoHw3iRin0E/wDbKO4SyqmBmTrM0ILm2DbRP4lCYgIqSwm4
 DB5EYPEQAIHrd5W7Sf74V5I9NJ01ClHN3HGIRJ8QyXbe8EHHWtAMjUP2RZuoqDcqoFHt
 7JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564102; x=1790168902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=04S0qWop5fX0Gcp0Ft47jb0t0Af6HcVbG2drnJ91rdE=;
 b=iURwiQETcaHR9n6CPgNkgg7Wl/5TqRPteKlONj7RaPnos3uc4brUoOYFw/x4ZoYIIR
 6iV0LNVQiokgZSQmVZlBm74vwxAJmo2Fsf6Q3qXab7amcF/P4MlhGHWPTE2U2J9NnGzg
 ySQKvNOQ/aSkngMQ+tg2joWkZMvkYCG8EJZA9FmFSIJ7d9ygY78qB2W7PdNmogy68G/p
 TR/AcAYV3e9EyP7GU4uu2Srj+vyPA6CIFAKr81YbT8KI9o/QokV1dYSsMOO/Xg7tlYVk
 iH+nsZnkwL5xNLcpXZPBy6RRTsw84OcPpNT62H4br2oX1eSbiCV96dzJrj5Z3xQsgeDV
 C25A==
X-Gm-Message-State: AFuF++ktakiyHPKvMvWBjb+aGunhBAEI79dpVGrQ/h6Aim1AaEJRWqaW
 u13ncZO5Cbne1iqcFFVTgKA7y66EJe2vwrwu8Rwm/bp0Ca1cv4nMx72jpIwk/kwylw2MxVOccum
 q+OaUIbM=
X-Gm-Gg: AYBFou3RTK+7EdDWm7sSGpwcYKTUT1NcE7YShxvl1fARyNltpq7hjsoQFj8dPvL9nPr
 jQ+OeXiDRFZFIDSuYqbDGYHmBYXE1hkEX47Lta/JVXoUUpddvWT6lrZAg5VoDBPCNHNt2R4M9/K
 0gfn+QOfUmVe2Z7mYevODITC0/OC+W7QunugOPFbjuhLynDqB8AhOlSj63ny3+MMxlPbweqBcjI
 J/UkuczZY4hM3wF3bxbhVvQM2xcfnaNkvWFgb14NAzZHZq5FHGSMExbfenTZFS/Py/4EdFZWT9I
 BQySJbidJNOCtRE2cR4HnXYbfxYfJ4Dw3qYoGXZkrVWXzMYLAg9W5Bs0o4gEvq+XHn9AgRrf9z2
 55mHYHhmx1P9hW4Y9IoiqZ3ZXDt3iubkaxFPgUeynXLHb/4J4C0lscqi6D+hdF5HwXxKkyg8ozY
 g5T0bH6TCC8dd/FnFaEdclzaNKINgMquVMqyDuodXc/zt4L2U1QKzsivNxjfxPsLlNRjhamhFpN
 qNSMUs=
X-Received: by 2002:a17:90b:5650:b0:398:9beb:a2b4 with SMTP id
 98e67ed59e1d1-39dfe1c41c5mr8906327a91.22.1789564101758; 
 Wed, 16 Sep 2026 06:08:21 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 48/92] tcg: Split out gen_extu_i32_i64
Date: Wed, 16 Sep 2026 03:03:23 -1000
Message-ID: <20260916130409.3382710-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 861b1ede949..017bfcdd3e7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -412,6 +412,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF6
 
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
 /*
  * Generic expansions for templated operations.
@@ -544,6 +545,11 @@ static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
 }
 
+static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -2291,8 +2297,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_extu_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    gen_extu_i32_i64(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
-- 
2.53.0


