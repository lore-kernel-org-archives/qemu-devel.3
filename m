Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED77C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pd-0002G8-4I; Wed, 19 Jun 2024 17:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PT-0002Bx-7C
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PR-0000KZ-Ae
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:02 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f992388bbbso1611725ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830800; x=1719435600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSym0G/iFtizMEI4s23S5kDZbe1VjgaGmtsZd8eQAfk=;
 b=w1vHW7FkE4gls4yEC01Xjkhx81HNDG4gxx5N1sCFYqj9rXI6n1h1ji6WiHLJWh4wOF
 TZNk8+TkTT1F97n/ie694uNxrYvCYTRre3ick6LO7rfW/BZL2ag0U5GDLnaCbFh9Hoft
 3CZiTA9zI5LDflULQzQzxr+td6WsYixJ5Bp47t/vIjX4C4pQ2W+/uqAE+jckmPsrvMMm
 A6B3gwOWny3lURh1Dm3GGzHJ7pkkGUU66ar8XX4IFV7uj0uOoadnMZAjiAM9yDgMx2rd
 w3TB0+/dxI2018Ihvb8S8F83Gp41ScpvKYXRhzyQnu1cVCML0coIZ6UNNCT/DtjJtzWT
 TiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830800; x=1719435600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSym0G/iFtizMEI4s23S5kDZbe1VjgaGmtsZd8eQAfk=;
 b=wu0vOSVtqcWXU4K59SWCOHAEbR6lQSEWJWx/dU3PQn6OP143STqOkcm6C5jGu9hvXG
 mi0aq0jR2tGrp0LYHyq5GsV/Wfs3w47CVgZdaDgbczlfVu+P7ythM17QlsiVAVBiEPzb
 8DWx6SFcLVLPuGQaFSdesR98soNX2K4jcAQZo9HDuLFPPPv6Sb0eMySGYcTq0bE9lRlz
 bolsxctfyLQil/Y/7PTJ54eWjzdjrPipKgPRrIsfLQszuYZQeUIPncG73OvrYyO57Uam
 CreNmcklsdTOYKwOf2yA1gTFXbf8Mn/1zUkFH4JydjqYciVcGb4HWgcJhN54XYIbYOhx
 dFag==
X-Gm-Message-State: AOJu0YxfY12dZCsfB3CWTAvLqA5gcwuCIAf/rbKhFPGTHsN9EaD8CjqW
 a82J7seyofRyxCh5mX/zOv0fiodzlgtISP3LprOqB304xT3t+MjBDsh+cK1xDpCss+24j/8WPeB
 T
X-Google-Smtp-Source: AGHT+IFOyRDje2S1ZPT1toaa738rVE8UrCzX2ShRxgeQx2sn4KiT1iNUN697h/sGFotZgkNyHhibvw==
X-Received: by 2002:a17:902:c948:b0:1f7:843:e367 with SMTP id
 d9443c01a7336-1f9aa4878cfmr37773255ad.63.1718830799778; 
 Wed, 19 Jun 2024 13:59:59 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.13.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:59:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 07/24] tcg/loongarch64: Support LASX in tcg_out_dup_vec
Date: Wed, 19 Jun 2024 13:59:35 -0700
Message-Id: <20240619205952.235946-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b1d652355d..cc54bc4a53 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1674,12 +1674,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
-    static const LoongArchInsn repl_insn[4] = {
-        OPC_VREPLGR2VR_B, OPC_VREPLGR2VR_H, OPC_VREPLGR2VR_W, OPC_VREPLGR2VR_D
+    static const LoongArchInsn repl_insn[2][4] = {
+        { OPC_VREPLGR2VR_B, OPC_VREPLGR2VR_H,
+          OPC_VREPLGR2VR_W, OPC_VREPLGR2VR_D },
+        { OPC_XVREPLGR2VR_B, OPC_XVREPLGR2VR_H,
+          OPC_XVREPLGR2VR_W, OPC_XVREPLGR2VR_D },
     };
+    bool lasx = type == TCG_TYPE_V256;
 
     tcg_debug_assert(vece <= MO_64);
-    tcg_out32(s, encode_vdj_insn(repl_insn[vece], rd, rs));
+    tcg_out32(s, encode_vdj_insn(repl_insn[lasx][vece], rd, rs));
     return true;
 }
 
-- 
2.34.1


