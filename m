Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA8CE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfC-0001mT-3R; Thu, 02 Jan 2025 13:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPee-0007OT-Nt
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:47 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPec-0006FX-La
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:44 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216634dd574so105949335ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841441; x=1736446241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TLlqagyGEk1xKe+ALxsyxLkqQQTDbuWTxU1MrSTDCnI=;
 b=Ff716/xY+SOx13z4cM7cuJ0Xxyr3j2sQsx6zj5GqSNpDj9DLA0s40ymaYUaa6GZgVO
 JWhMBTFiX7N6yqAHmUDr5aKCzS3n93sqOwn5tDb7Hh08/Cq25VHdiuZbIGIpz7W1BbPQ
 7XC9lut7+lPm3aR25gvPD/l/KQq7BYQRAJCkXt4puhy6O2HBvmR2MixcLdqRCbSDgjSM
 jEGeBxKuAPsDnpXuhS7yRvTCKs3n0dKTptLOTBUVKF+h55ujU8rqhr3czJVhwK+FtdMW
 vT9AnN09lCO8WUhYz1zDDvnnJnWFhlhET9jI5UvkLeHSA+NiZ3j5u1YoNtRLYjRP3KXp
 4shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841441; x=1736446241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLlqagyGEk1xKe+ALxsyxLkqQQTDbuWTxU1MrSTDCnI=;
 b=hK9W1gKaAdnlUL9yGlOHdwNQKkG0VfrInmswyVxrMf+Dtl9Wkpe7/7YagVX2Qc56b9
 0kzwdL2iOepKDyg3A6IBwWbEwTW8x3MJNbwt3frZEXsuFSwaJHIuQ/02iC8X4Z8hVxue
 OCUvIe/lddmDAgf+eo7feTmzscXfu/05ZaziL8el4ZK2p6XATZnBTGkisaVDTHRdhLN4
 z7IxOGMU7/PhqEi3i0YVtL+cSKNdPJCSPiDgtlitWMWBH+jPRsnFRqbRcNI1hpJ7k9Pt
 jo3YjY777JBK+9WKqu6WBxzPZmj3oH6qDh7ELX3+KIoTF28gQtDn4aSHoLuf/mnKReic
 mUdQ==
X-Gm-Message-State: AOJu0Yxkq3bsIWTP6/rwrJrt8v2RHrAGPGRvmwoB+MaMC6rVaiUCPAco
 4Y53P1QwHty3Yk0gAKRLxy/K8CD3NSe1DCPdO0Yt9CPSV1IUXunM89gCSlogartwBsWmWY2B/M6
 s
X-Gm-Gg: ASbGncvz+XL0N2zPwoierqh4UYUe3xQ0viJYFcGNCOPje69Acd06DmoTuTmj7rj9mIQ
 LnjEqBACmOzuH2n9EJ5P+Ht5Lq/r6qa1LFFDA1pTCPbiOljN7tTC2ewV3XdWUERXwyJ/wCdM8Or
 IeDORbu3PveTy+Yr14IK9Eo0y05FpOi12nMvzfdWPcGeRy8THwBXeFkYgV3vN+ckAoFibYaEBYO
 qoTKpCFdhPy3tjS5F+gJOpBfNBTiIzdaNQp1PbB62VWixVSRwF+1RGSwSLeVw==
X-Google-Smtp-Source: AGHT+IESQXxQ8OkHjqkBOBrolhxk9kSiyr8gGv6TNsiFbDaz71WkAQleO+7WkZZF1S8tkOO5bCwAeA==
X-Received: by 2002:a05:6a00:399a:b0:725:96f2:9e63 with SMTP id
 d2e1a72fcca58-72abdeba91emr76301952b3a.24.1735841441179; 
 Thu, 02 Jan 2025 10:10:41 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 59/73] tcg: Remove TCG_OPF_64BIT
Date: Thu,  2 Jan 2025 10:06:39 -0800
Message-ID: <20250102180654.1420056-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

We now get this information from the stored TCGOp.type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h | 114 +++++++++++++++++++++---------------------
 include/tcg/tcg.h     |   2 -
 2 files changed, 57 insertions(+), 59 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 706d2a9794..561ddbc016 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -92,64 +92,64 @@ DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
 
-DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
-DEF(setcond_i64, 1, 2, 1, TCG_OPF_64BIT)
-DEF(negsetcond_i64, 1, 2, 1, TCG_OPF_64BIT)
-DEF(movcond_i64, 1, 4, 1, TCG_OPF_64BIT)
+DEF(mov_i64, 1, 1, 0, TCG_OPF_NOT_PRESENT)
+DEF(setcond_i64, 1, 2, 1, 0)
+DEF(negsetcond_i64, 1, 2, 1, 0)
+DEF(movcond_i64, 1, 4, 1, 0)
 /* load/store */
-DEF(ld_i64, 1, 1, 2, TCG_OPF_64BIT)
-DEF(st_i64, 0, 2, 2, TCG_OPF_64BIT)
+DEF(ld_i64, 1, 1, 2, 0)
+DEF(st_i64, 0, 2, 2, 0)
 /* arith */
-DEF(add_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(sub_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(mul_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(div_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(divu_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(rem_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(remu_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(div2_i64, 2, 3, 0, TCG_OPF_64BIT)
-DEF(divu2_i64, 2, 3, 0, TCG_OPF_64BIT)
-DEF(and_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(or_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(xor_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(add_i64, 1, 2, 0, 0)
+DEF(sub_i64, 1, 2, 0, 0)
+DEF(mul_i64, 1, 2, 0, 0)
+DEF(div_i64, 1, 2, 0, 0)
+DEF(divu_i64, 1, 2, 0, 0)
+DEF(rem_i64, 1, 2, 0, 0)
+DEF(remu_i64, 1, 2, 0, 0)
+DEF(div2_i64, 2, 3, 0, 0)
+DEF(divu2_i64, 2, 3, 0, 0)
+DEF(and_i64, 1, 2, 0, 0)
+DEF(or_i64, 1, 2, 0, 0)
+DEF(xor_i64, 1, 2, 0, 0)
 /* shifts/rotates */
-DEF(shl_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(shr_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(sar_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(rotl_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(rotr_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(deposit_i64, 1, 2, 2, TCG_OPF_64BIT)
-DEF(extract_i64, 1, 1, 2, TCG_OPF_64BIT)
-DEF(sextract_i64, 1, 1, 2, TCG_OPF_64BIT)
-DEF(extract2_i64, 1, 2, 1, TCG_OPF_64BIT)
+DEF(shl_i64, 1, 2, 0, 0)
+DEF(shr_i64, 1, 2, 0, 0)
+DEF(sar_i64, 1, 2, 0, 0)
+DEF(rotl_i64, 1, 2, 0, 0)
+DEF(rotr_i64, 1, 2, 0, 0)
+DEF(deposit_i64, 1, 2, 2, 0)
+DEF(extract_i64, 1, 1, 2, 0)
+DEF(sextract_i64, 1, 1, 2, 0)
+DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
-DEF(ext_i32_i64, 1, 1, 0, TCG_OPF_64BIT)
-DEF(extu_i32_i64, 1, 1, 0, TCG_OPF_64BIT)
+DEF(ext_i32_i64, 1, 1, 0, 0)
+DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | TCG_OPF_64BIT)
-DEF(bswap16_i64, 1, 1, 1, TCG_OPF_64BIT)
-DEF(bswap32_i64, 1, 1, 1, TCG_OPF_64BIT)
-DEF(bswap64_i64, 1, 1, 1, TCG_OPF_64BIT)
-DEF(not_i64, 1, 1, 0, TCG_OPF_64BIT)
-DEF(neg_i64, 1, 1, 0, TCG_OPF_64BIT)
-DEF(andc_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(orc_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(eqv_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(nand_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(nor_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(clz_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(ctz_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(ctpop_i64, 1, 1, 0, TCG_OPF_64BIT)
+DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
+DEF(bswap16_i64, 1, 1, 1, 0)
+DEF(bswap32_i64, 1, 1, 1, 0)
+DEF(bswap64_i64, 1, 1, 1, 0)
+DEF(not_i64, 1, 1, 0, 0)
+DEF(neg_i64, 1, 1, 0, 0)
+DEF(andc_i64, 1, 2, 0, 0)
+DEF(orc_i64, 1, 2, 0, 0)
+DEF(eqv_i64, 1, 2, 0, 0)
+DEF(nand_i64, 1, 2, 0, 0)
+DEF(nor_i64, 1, 2, 0, 0)
+DEF(clz_i64, 1, 2, 0, 0)
+DEF(ctz_i64, 1, 2, 0, 0)
+DEF(ctpop_i64, 1, 1, 0, 0)
 
-DEF(add2_i64, 2, 4, 0, TCG_OPF_64BIT)
-DEF(sub2_i64, 2, 4, 0, TCG_OPF_64BIT)
-DEF(mulu2_i64, 2, 2, 0, TCG_OPF_64BIT)
-DEF(muls2_i64, 2, 2, 0, TCG_OPF_64BIT)
-DEF(muluh_i64, 1, 2, 0, TCG_OPF_64BIT)
-DEF(mulsh_i64, 1, 2, 0, TCG_OPF_64BIT)
+DEF(add2_i64, 2, 4, 0, 0)
+DEF(sub2_i64, 2, 4, 0, 0)
+DEF(mulu2_i64, 2, 2, 0, 0)
+DEF(muls2_i64, 2, 2, 0, 0)
+DEF(muluh_i64, 1, 2, 0, 0)
+DEF(mulsh_i64, 1, 2, 0, 0)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
@@ -169,28 +169,28 @@ DEF(qemu_ld_a32_i32, 1, 1, 1,
 DEF(qemu_st_a32_i32, 0, 1 + 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_ld_a32_i64, DATA64_ARGS, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a32_i64, 0, DATA64_ARGS + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 DEF(qemu_ld_a64_i32, 1, DATA64_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a64_i32, 0, 1 + DATA64_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_ld_a64_i64, DATA64_ARGS, DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a64_i64, 0, DATA64_ARGS + DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Only for 64-bit hosts at the moment. */
 DEF(qemu_ld_a32_i128, 2, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_ld_a64_i128, 2, 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a32_i128, 0, 3, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_a64_i128, 0, 3, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Host vector support.  */
 
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index b5ef89a6a9..90e5e4dfb8 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -695,8 +695,6 @@ enum {
     /* Instruction has side effects: it cannot be removed if its outputs
        are not used, and might trigger exceptions.  */
     TCG_OPF_SIDE_EFFECTS = 0x08,
-    /* Instruction operands are 64-bits (otherwise 32-bits).  */
-    TCG_OPF_64BIT        = 0x10,
     /* Instruction is optional and not implemented by the host, or insn
        is generic and should not be implemented by the host.  */
     TCG_OPF_NOT_PRESENT  = 0x20,
-- 
2.43.0


