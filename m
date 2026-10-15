Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E22CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4o-0002UN-Fc; Thu, 15 Oct 2026 06:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4m-0002Ti-7c
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:44 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4k-0007rZ-N5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:43 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso336884f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061561; x=1792666361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQvoD4jx0GKlHk1zeIwZk8ip4UUerKEMCgllTFeHpFQ=;
 b=ts94krNzBWDLhxU177IG6QnYgvr08A75aYV9VKZT/UehJrkCsBLPU3DKz6jBJmjiOE
 3326U5MGNamfiKYxtsBYmo5Cn5bLkn+MDcWzjBS/H+PXXnGz7c8VD3WrXWkoXLqD1WOh
 ZuRMECGym9p61BAPB/Ym52yvUmR3Yyc8uSJRsFYaGpHyxXuh2bMU1QbPcjxSnF0Qracu
 2/L/M4NqLjzHzw64PQc+tVInV/4mGmvkRPRji1tYbzHKt8A+r/Rq05H0+p1BR7jHlQL8
 Rfgo3xtyOY8vJriGp4rpBaSBC4sc0UENr5BqWYeDsQHFAwuoVcGpGeeDcllBgfq6naOL
 IaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061561; x=1792666361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bQvoD4jx0GKlHk1zeIwZk8ip4UUerKEMCgllTFeHpFQ=;
 b=CQ/MzZCamzjY3G2Cc+1srdcYN+sVsZolvjmM4aOxHbPlPT3UZBmjT6AoozFDKa44dq
 my7VhaGukru7pTMKjMhJcmx9gXPbSz62f+qpXMZP+Azf58KXKuN8AIgISHu7/I016A/K
 xjhPZ0xgs+ZXjOfvRvgTDigj/iJmLX1d0qbO/JTFOrSeMNwJ7VJcl2tgxJMch0eSDR6K
 iIPx51DKdbFb7Uyy9oeqrtDE4RZEVrTsW0U0QpTBIR8kYCNFtA7b1RGrvVewH5x0o8cq
 mW8+golApY5gBTluIYBi5IrXPcqZyZlh1RZSSEUHEs1VWrz38yycruOuacgLeveP/jfa
 nDLw==
X-Gm-Message-State: AFq9FYLhzuy0yQ2J3HPz3/dGX1WCOFXSHCJT4SoDqBOZVAZpffHqDwO5
 ZJB3DZcnSz/sLM/g7g8MIibBEtEqwhwOUClE4Y3dOoG08CxI2+UIoCbqJ99cCnWCLvX0tBoAZMg
 XkEGMiO0=
X-Gm-Gg: AYBFou02fGSo9ka+6yxervcBYopUwbGd3tvJi20IiUK742Ubwy3WHkDRHI9K0m3hWUu
 VPKN8oac/KzScJVtQbhVFLzFY+2hMkWv4ME1+VILqYVTNSMUShpoAoiK1NKYa/9TvsaLoTu4bkp
 3f6GD26Cii6dFLWlyV0P0l2lwBX8bcWIh7qevE4FhsGMXh+q8U3EhnMJiWpRPfKfs9MCC1K6hRm
 4XPNpPmqLAlV8NAp1NJjRGUdJzDsWbqdguUgajhZXdteinn8WR+WIcFEPQaCmNtdTcZ6AEFUcEe
 YBclwLDFBNd7tEmQRZ+h8/xOoKPAff4cSS2UXCtp3z0zo8lyr6Jq5eg4flPEz/48q8IMi8qmO4T
 M+6G4Rc35HD/4+g8CvMzbS9x+VAtzd/LrFyLZNL/FEDkdl19jLXC6SKjOr2+ZqYEl0pmLxbxmbY
 lDsazKkPDV8ZdiQ8lYHuh6iAZafjlVpLjOhy0QXD+BBB5pF++4O1uTA3dL55DvIS6MbGlO074uS
 bEzWmLfH8howp+YRcmbGGVmJxqlGQvJL32l0MV6XnL4qCKCvIF9g8YFkqg68TSR5j1ha9pCfdFa
 1UCJ
X-Received: by 2002:a5d:55c8:0:b0:48c:7d67:8ee5 with SMTP id
 ffacd0b85a97d-48dbaae35c2mr27964893f8f.43.1792061561314; 
 Thu, 15 Oct 2026 03:52:41 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>
Subject: [PULL 13/16] tcg/riscv64: Return success from encode_bimm
Date: Thu, 15 Oct 2026 12:52:05 +0200
Message-ID: <20261015105212.356392-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

Centralize the range test for this encoding.
Directly OR into the insn value.
Assert success in encode_b.

Reviewed-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index c8f91612d37..e4e1ce91eaf 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -474,22 +474,25 @@ static tcg_insn_unit encode_s(RISCVInsn opc, TCGReg rs1,
 
 /* Type-B */
 
-static tcg_insn_unit encode_bimm12(tcg_target_long imm)
+static bool encode_bimm12(tcg_insn_unit *insn, tcg_target_long imm)
 {
-    tcg_insn_unit ret = 0;
-
-    ret |= (imm & 0x1000) << 19;
-    ret |= (imm & 0x7e0) << 20;
-    ret |= (imm & 0x1e) << 7;
-    ret |= (imm & 0x800) >> 4;
-
-    return ret;
+    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 12)) {
+        *insn |= ((imm & 0x1000) << 19
+                  | (imm & 0x7e0) << 20
+                  | (imm & 0x1e) << 7
+                  | (imm & 0x800) >> 4);
+        return true;
+    }
+    return false;
 }
 
 static tcg_insn_unit encode_b(RISCVInsn opc, TCGReg rs1,
                               TCGReg rs2, tcg_target_long imm)
 {
-    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_bimm12(imm);
+    tcg_insn_unit insn = opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20;
+    bool ok = encode_bimm12(&insn, imm);
+    tcg_debug_assert(ok);
+    return insn;
 }
 
 /* Type-U */
@@ -623,12 +626,7 @@ static bool reloc_bimm12(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
 
     tcg_debug_assert((offset & 1) == 0);
-    if (offset == sextreg(offset, 0, 12)) {
-        *src_rw |= encode_bimm12(offset);
-        return true;
-    }
-
-    return false;
+    return encode_bimm12(src_rw, offset);
 }
 
 static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
-- 
2.53.0


