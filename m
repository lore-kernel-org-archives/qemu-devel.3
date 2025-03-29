Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0391FC3600C
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 14:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyXQx-0007z8-3L; Sat, 29 Mar 2025 10:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQl-0007uX-VO
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:06 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQk-0004EW-30
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:03 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-301d6cbbd5bso5099618a91.3
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743259500; x=1743864300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtSo8S5OEBT4DMRlalXCu7rqXrD21r5pPZJo/XU9Y9s=;
 b=S7/ett0nxXThRZ511gpWet+GPl0EH9IYf7Svni1OCDkJqjVzlaRgdjmb+9z1+CJCdp
 C/bX6jdf6KBqX6Fj/e8d6Nuu5qfqanNPwGmmtmXNhqBt0/tmFz1Cy9Mi93sImGxmarlK
 8G+Nz3c91RKWUuJGui8ZZM+U+uUv3nHMpOdr0a5nzoXQsxGrCvampPtJAWTlHbh/vUoN
 kijMQPLHDWwmKxliotjR7rhamkU81CJVuGuH8/C5gUHc4siwZvkGmcivY+hGLnHh8rnO
 NA7527c2ZoyJQzPnfl2tSuAfCWVQktv6Ud6XSRnnFRcPaC72SiS3JzzhEFsjPQwKTL21
 YsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743259500; x=1743864300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtSo8S5OEBT4DMRlalXCu7rqXrD21r5pPZJo/XU9Y9s=;
 b=e/2tTLK0vfs2Uam6UI/rnFGe/Xv616D0OkhPyHtfCDqbiLWdfUxQz3jxSw62b//Pdh
 MBaj0XCwWnwnr1vZ/Xnt8btcjdq0H6RgnLHBwJG4aNihteMAIkOmz1W4x3+VBfi+Sz6k
 FTtKOqKGEh5Svoh6HEalgK8zFLPS749op+QqZEiV/Q0Tr+NLlc1LA0tFkuFevtwTxQH2
 4OyXjoTthbXt2UcHME9D9BmG+qgUNPK6k0XwPMBH00r+F+Kd95YCr9FIDctdemWY7+lu
 xrPBRBzYQmU/pjG6RY/ED4YlMeW0zElN397BKqtVuTNnw4SuKxAeKa4FGJXWCTirqBGF
 II6Q==
X-Gm-Message-State: AOJu0Yx6yhC+nrWvZBqgEOyY/va209uW0M3PkG87yUWb6RCdmOS4c9To
 e6tDrzDciOJQut6lTb6dj+Ubfvuq1CDwkZaMmZMZ00OVUG6bFHv1LL+sefh9XNmUnmUHhk47oe4
 3ZKUaDdfT9C5yZwV61omq/ExXdQcjalJLzkmo/JGrr1AUvNmiOpwuf1Bl7Wsl4gHE90BNXIag4L
 +JCe5dTUH8aOXj3lKzQi373/jv6gvB0/hheK9RIg==
X-Gm-Gg: ASbGncuyGt16UE9YT0877YOmG4waJwg7IraXFHafc13simLWb4Uv59O7TQ7W4M3V3qO
 FpbPrafEyWdomxKYhF6JplhDoddZkyAIsiDxh0zPFcTDpqjlzOAxPbmjLnoz9Md1pQ93qgUQ22x
 rr0HrgrWz6VArmiE6eq0399kV/SXA+Q8pk//KOyLqTmJgiTYjc/x+VcLbZ9eriL0dV9r/Yc3All
 WR2QSDKSaP1KIL3WZD2rHdX/E6XPdH0msK1W8qarKlX3fHk5AwyECkLX3OjjUA9XJCPy/bPTelC
 QsbWIXSR6kTDtnabwvr1EGh7DptmyhdCoRL6cH6ru8/LE5vp+57pDhcNBC3NrUxmosla46KWj7Z
 fJhUmvjvh1eiNkw==
X-Google-Smtp-Source: AGHT+IGhMkJTmTKVty3lDI0HZVYQlybcZIK0+t+SGMbZYc8kAdoU+OBLajVmCqeIOk+Myg5KCKNk2g==
X-Received: by 2002:a17:90b:56cb:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-30531f94677mr5273778a91.11.1743259500126; 
 Sat, 29 Mar 2025 07:45:00 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b6bcbsm6737196a91.45.2025.03.29.07.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 07:44:59 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 02/12] target/riscv: rvv: Add CHECK arg to
 GEN_OPFVF_WIDEN_TRANS
Date: Sat, 29 Mar 2025 22:44:36 +0800
Message-ID: <20250329144446.2619306-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329144446.2619306-1-max.chou@sifive.com>
References: <20250329144446.2619306-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1030.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 20b1cb127b4..e630f8661e1 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2403,10 +2403,10 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
 }
 
 /* OPFVF with WIDEN */
-#define GEN_OPFVF_WIDEN_TRANS(NAME)                              \
+#define GEN_OPFVF_WIDEN_TRANS(NAME, CHECK)                       \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
 {                                                                \
-    if (opfvf_widen_check(s, a)) {                               \
+    if (CHECK(s, a)) {                                           \
         uint32_t data = 0;                                       \
         static gen_helper_opfvf *const fns[2] = {                \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
@@ -2422,8 +2422,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
     return false;                                                \
 }
 
-GEN_OPFVF_WIDEN_TRANS(vfwadd_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwadd_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwsub_vf, opfvf_widen_check)
 
 static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
 {
@@ -2505,7 +2505,7 @@ GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
 
 /* Vector Widening Floating-Point Multiply */
 GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwmul_vf, opfvf_widen_check)
 
 /* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
 GEN_OPFVV_TRANS(vfmacc_vv, opfvv_check)
@@ -2530,10 +2530,10 @@ GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_widen_check)
 
 /* Vector Floating-Point Square-Root Instruction */
 
-- 
2.43.0


