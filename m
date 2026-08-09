Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8ACC5AD7B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7f-0000kD-IN; Sun, 09 Aug 2026 18:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7e-0000jh-Ab
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:02 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7c-0007JM-Ob
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:02 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso1158324b3a.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314959; x=1786919759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HnLRGuMW42rvAMRt2MSYf/VtSYGI2TWo02Xgy50qrvY=;
 b=YDOy3S0R2auLeuvEqbk2OOUVW2zB0U1lNI+yOrfpykAePLOULuEAhVvwpF7gaV9qps
 DsZyidAREN566i4iO4+7CxtdiXiR3Dz80TPX0lOlO6sxeAXX7buQDhxi+PUJXCptPu+i
 vc6cNxJGIAfBqgMgcVNbqz2iqJZH0gUzyEKvlAA1u3IA9jqSsLumIdvWwsXcM7bkFZ8Q
 M3PcG4H6bWyt3uUlUkikwRYX6Yl72BvJ5MSydLfKY72ZrgWBjw5RW2nfG35Z7s+h0Ybx
 6+Isg+Zwz7ug+c4pLnig9HPoAJo8+o4G0RDBix0xseKWzqiUijXK1QR0ePQ3VrjdzDCZ
 xs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314959; x=1786919759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HnLRGuMW42rvAMRt2MSYf/VtSYGI2TWo02Xgy50qrvY=;
 b=NAdGH4D8nsnZSM2AtSy+t/Z4SKf3gJNrAcDM4IiOYB2ouvXv9IkiE/5dqfRvin+1kK
 YXeh+uKaqgrCau86KhAmL6sYnYqYMnThkWX9HqgcAB8AwY6MdgYCKUVV+95lPxgENDyt
 WATGbOXWlup4E0AVycItoSWc43mSS4VmK9smwglZZgyY+BWBSFJ9udhvOdJz1WLlvUDm
 IZOXJADEGX9NCeMLMA9HaC7C33HMIktYW5Y6Wg5oESl/HQvusy+QdfbLAC2Tu50z8F8b
 TN3WbFbeY01979vVpxRA6xiGBViZOz41ULr1/YL9rpCwrfvY9GYKI6l2xJeswN/Eu1Vh
 qiHg==
X-Gm-Message-State: AOJu0YzMY/g9fwUC+/X3dVo0AISFNob4Q0s2pwJUdMeYyGtL1U+/4RN8
 cN30VF6Z0QWts6gzryUiTVtiIPwwVadatHmV8dbMUnsPFkAYwdkpDAt2malTqHci//FzQSEY2V4
 JGklc
X-Gm-Gg: AR+sD12IjkbWDYjcBGSPxLnUJlira9dBlxDKQFU8S+UQPlALdtujOZpRg8DVCPDcz4T
 0zpfUUNnuog7BNYAwZ7wz1r49XzmJXjrsk7I+QBgQEP0WdJZdU7XMzqsESaChU4aHoplNdO8r4y
 vQANolsoqso+qSC9j6QLUm8xKsr2fu9LTVR1QTcGs/OHxDCo0GKMUJBAsYuBr0a4EwxY0BwHg2i
 4ya5QhHU39Ha2o+n87GsqVt/htt2aXfyZloxNp6PWqMVDz/OxWoAv05EYoicM/wVEcmQ+biJwqj
 JTnUHjnSCIjLAJ9drpYn/kg6iCUhXTkGFHwOFWRIWw3Edllqq/tPNjDpb/Y/6+eqAQxdVl52EYY
 8USdDprXBK5EqXimLCbb5OhZdq3BeThYGNMH0Vi1f7BOC5M9DY6GS1d1mfoGdPSa9m5PbOm0oCQ
 2xoW6x/tc4G1ZzCktO5eH4PTYUi2GRhWlsJpwJqSpCb4PY2EHOdQWtarSXlwQn0+i+TDbtp64fB
 kmIBjde2XLa7FBWy8eJ
X-Received: by 2002:a05:6a00:8785:b0:84f:37c1:f887 with SMTP id
 d2e1a72fcca58-84f37c1fa4emr27054146b3a.12.1786314959056; 
 Sun, 09 Aug 2026 15:35:59 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:35:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 09/56] disas/riscv: Pass rv_opcode_data pointer to
 decode_inst_operands
Date: Sun,  9 Aug 2026 15:34:58 -0700
Message-ID: <20260809223545.730664-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 disas/riscv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 986dc6b752..af43940732 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4595,11 +4595,12 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
 
 /* decode operands */
 
-static void decode_inst_operands(rv_decode *dec, rv_isa isa)
+static void decode_inst_operands(rv_decode *dec, rv_isa isa,
+                                 const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
     rv_inst inst = dec->inst;
-    dec->codec = opcode_data[dec->op].codec;
+
+    dec->codec = op->codec;
     switch (dec->codec) {
     case rv_codec_none:
         dec->rd = dec->rs1 = dec->rs2 = rv_ireg_zero;
@@ -5468,6 +5469,8 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
     };
 
+    const rv_opcode_data *op;
+
     for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
         bool (*guard_func)(const RISCVCPUConfig *) = decoders[i].guard_func;
         const rv_opcode_data *opcode_data = decoders[i].opcode_data;
@@ -5486,7 +5489,8 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         dec.opcode_data = rvi_opcode_data;
     }
 
-    decode_inst_operands(&dec, isa);
+    op = &dec.opcode_data[dec.op];
+    decode_inst_operands(&dec, isa, op);
     decode_inst_decompress(&dec, isa);
     decode_inst_lift_pseudo(&dec);
     return format_inst(24, &dec);
-- 
2.43.0


