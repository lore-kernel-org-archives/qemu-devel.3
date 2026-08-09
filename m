Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C29C5B560
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7r-0000sV-MG; Sun, 09 Aug 2026 18:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7q-0000rc-0g
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:14 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7o-0007Nf-HU
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:13 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so16958005ad.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314971; x=1786919771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l6unakGYlzTSlPOKHPQMuQDjocKYB9JF76ypQ1cTERk=;
 b=udeAbo+9HQxmMkf+Jkhbs2VGKAWgvLo8el6mnPJ0NgygUpabVVd5LCm0dqgsFkw6cQ
 ZMYyf1QP/xcg82pLXuFwHOv910z7ZCaE4EU3V1E6SXknFZHBVGv2JvF0zSArI0OdZ1pv
 MSx6+QOg5jFH6nBlIjRo1up1tvgtsVqHUkszWNdxlbhCnUbN6hUSIroqPfUOjmbOyN+V
 0xDlG5C0PQTfll7zzwFLVh2+6Ns5GQcZjzUqqIB89VFk9yEZ4jzFlN1WW0ClCqJl7A+O
 4mDNSwrAG5Me5s3yXbxys25g+vcppBj6iFuCXw6iu79q391f3+YZfHV6RcGN1dS239cF
 0VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314971; x=1786919771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l6unakGYlzTSlPOKHPQMuQDjocKYB9JF76ypQ1cTERk=;
 b=B9P3ffr1RvlthzLACUthDSMDKnFQLk9Qtq/6JOM2flj1Ew1l+RDGVf5H3SlKfUVSCS
 05Eg0/EOzJt19LKmps2KyroF6bBtfECPuC2oaYgqVIbfjYb9pGPXpdP3W/232TYsmv3F
 YW2v7357XFXuuKfANPTkHHDjxQ1k7Vf+UQjQPvXdN7CY/c+3EEqroLUEZCNuAHBguCVK
 c5M29VJKIFMcauWLqMmG4ZH0ZgI8eJSVh95fTidZVnzRCsaKpG3FriP4kqjNJPOFtUdS
 qS7U6M2fPl1XEB0QqcrgFlgAhSCcw/IUSBCwyzNUs+GkGnPcyhUuOHfnm3QPU+0GwKr+
 at2A==
X-Gm-Message-State: AOJu0YxcrZuOARPA7proKq9B12Awa9Mu+vLnF0w3M+hcHsiG/k5tVvm4
 1/LJwd8mB4aqfmcA4ck7zvfuyrOpgQTKcZNygVlOFUqY9/BkSdfRHscaD96s30nbIdA3BfbtFWH
 Vch4j
X-Gm-Gg: AR+sD133pk501vJ0bLnvi4d8cL/raIib2FwJFYbHPkYoIx/Py6FHwTyIOTtaZ1u9K1U
 21p1lPa0r00D2nHuIg0fY5cU2aCMPPzC1vL+B6jrFDhXNY3N/CKUkMCzjFZxZlVlLuyOb7NOCn+
 hD5xtFMxc3KOex1dUzSpsRMzQtH42SJKIbOApT+XcNuba2YVzgy6quRzGM6roxObr6amVIkoybD
 rUn4phiWtGfkxgFQvrsng7ovFyDwG5RqcPKcBloV4ebL31LnVtFuY01HEWzVhHYEZBTG6qG9DyR
 ouqS9OOYVXoecQPDL6VCS77GAjPqyVIdPlG/jYrvjY9Dhf5WRRh2M8ocOXZelBiOlID4LVrcbM1
 WAD44JOwmcdjbQwko/WDfViUMhnJRUoFdsA3roVtcTAWO5DGB/oXIScJ9Poog/znTyqeCTVcY4F
 V1Gli/Z5lb4jHRL0871Iireh45DBM8TM/O5W66szuZQ556Ru8ckrFvNsOs8q+1xWuxOxE27tMah
 dPNkJ/mdb0OzRVS1WSY
X-Received: by 2002:a05:6a21:6b85:b0:3c3:935a:af2c with SMTP id
 adf61e73a8af0-3cbc0104349mr20129839637.3.1786314970798; 
 Sun, 09 Aug 2026 15:36:10 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 19/56] disas/riscv: Simplify c.addi
Date: Sun,  9 Aug 2026 15:35:08 -0700
Message-ID: <20260809223545.730664-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

While c.addi with imm == 0 and rd == 0 is c.nop,
other c.addi with imm == 0 and rd != 0 are not illegal,
but are reserved as HINTs.  Go ahead and disassemble as
c.addi rather than falling back to invalid.

Further, there's no reason to differentiate c.nop, since we have
  c.addi -> addi -> nop
vs
  c.nop -> addi -> nop
via decompress and pseudo translation steps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 8a957e6a1e..7978ffb378 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -263,7 +263,6 @@ typedef enum {
     rv_op_c_fsd = 231,
     rv_op_c_sw = 232,
     rv_op_c_fsw = 233,
-    rv_op_c_nop = 234,
     rv_op_c_addi = 235,
     rv_op_c_jal = 236,
     rv_op_c_li = 237,
@@ -1896,10 +1895,9 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw, rv_op_sw,
       rv_op_sw },
     { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0, 0 },
-    { "c.nop", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_addi, rv_op_addi,
-      rv_op_addi },
+    { },
     { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
-      rv_op_addi, rvcd_imm_nz },
+      rv_op_addi },
     { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, rv_op_jal, 0, 0 },
     { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
       rv_op_addi },
@@ -3010,10 +3008,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
     case 1:
         switch ((inst >> 13) & 0b111) {
         case 0:
-            switch ((inst >> 2) & 0b11111111111) {
-            case 0: op = rv_op_c_nop; break;
-            default: op = rv_op_c_addi; break;
-            }
+            op = rv_op_c_addi; /* or unspecified HINT */
             break;
         case 1:
             if (isa == rv32) {
-- 
2.43.0


