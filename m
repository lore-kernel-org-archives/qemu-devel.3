Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F46FC5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBD-0005r7-8f; Sun, 09 Aug 2026 18:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBB-0005px-CY
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:41 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCB9-000829-AO
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:40 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so1118465a91.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315178; x=1786919978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5DQbRX5f/62CNinSFDzMgqzdrZpodmgnCW/Zss7oPVw=;
 b=EGV05ZvFGCAtGbwI7X10VXMPbXUnrFlz4n9oC9mE1kJ6Q0qib3wbXdTdx1D6QuHk33
 UAlmZwMF5idklplrZOFRMNKKY3toopHk6Qp5CRRK3AWqbZqu3zld2f0yOaLu6wNROcg3
 /+2itht6Z33znJllcxBqcU9HaQJrgudt4NSc7iOVLBR/xt1uN8u7JivFteKO8wma/PZp
 26zYg881tO+X2Y2mTDRpfBFxbx8zLhY6uvVH9kO+/811Zl6Yl6rpowUl5Yk0R58zGkpU
 whoT2QwJ1rSFyHvUB3WzMdFEgTDBWrFFklZE7pfc33RMYCD1Rlv0szcIGkNV3t6iQhLe
 XeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315178; x=1786919978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5DQbRX5f/62CNinSFDzMgqzdrZpodmgnCW/Zss7oPVw=;
 b=QMtJT5A7KZeBnKI9Q6ci23pxftwHEu8KfKX8Spy/p57s1CeasGN09U+CmeHVEgWgcB
 WS/5RUbaAcXfUKgOCk2I0te+mbd4snFpBMyK/L+P/wg+/CYsP0tp/izg1kUHNK+Kssj3
 K4BVAXVfxCCbfpPBITjqqbNUX3GV/4vtCXD07Ajlr1K1okg/SbY07Jh4Lowd3/CI1cyn
 QpnFIO5NZ6ZaKqXSXj4wRaALsqqARgQjWJRpavc+uLleeR9yVWLcSBExWG8YFnmHLNLc
 WocYyld/ISMUCtxmP3RhQD8/FW9eRKvdSbjjBfbzsBxc0gt9t+Nxsw+yHUAZDG5tBCs7
 ICVg==
X-Gm-Message-State: AOJu0YxO+CE+zY8vI0hvTQSHlF4q8zX3acwkkr3itvxQpr21L6IXKwKK
 LzBplIanS7Eg+ADop4mfktq6fuobez8HnS8B22uld8XgCzNRalvJ18vDX4hgfHU6atanqMIUASk
 +eVx9
X-Gm-Gg: AR+sD10iM/wYTXDeX093VG5eDob5RltS4luR9CEKbc1LRpy6t4y/x9aLhMa54bIA0rt
 puuJOVGfydQ9jHedQArq+PXL1LAyN/rtft744wBV+ATO6cqeKQrlSNNAVGAFq5QVOpkuurM9ZNT
 ecNS2MfbrciDeXyVoio9iBRqqXZXqHZp7TDnBzoRh6INCXS7tScKvcMyvywD6ju94/yCfBURXVU
 u9Jds4TDpnlblnZHnE5jrV8p7u4fp5RPCsOWoX1gkov3I8SGDlmge/oHtkTT0iNFchhI3QTAq7y
 8Lr/FHhYxVHKoBCi7idzKzFCYVRRG8V3WBINcKUPAkPwgh9xp0HunOekVBJ7T8xQfGEip+RJ/+K
 hoD/D/xWYZ4kLlAAXGiAhrcofQstWsJn1KNYwKNkSU3FwZnkOSJoDeEqZ4cYwYIzV/cz77fMKUU
 qrRTE++Sq5hkMixOTrbpC1sPuTjYNqzWmUfvy1ONesV0iSyOf4l2sla/PTUqYRy6LuZ3ehgNs8X
 WhVC+PHKrnvWf7BRoLX
X-Received: by 2002:a17:90b:1d8d:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-3903c56c2eamr35641523a91.9.1786315177588; 
 Sun, 09 Aug 2026 15:39:37 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH 42/56] disas/riscv: Fix rv32 encoding of zext.h
Date: Sun,  9 Aug 2026 15:35:31 -0700
Message-ID: <20260809223545.730664-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

For rv64, pack with rs2 = 0 does not encode zext.h.

Cc: qemu-stable@nongnu.org
Fixes: 02c1b569a15 ("disas/riscv: Add Zb[abcs] instructions")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index f51d45674e..9442a6c115 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3506,9 +3506,10 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 14: op = rv_op_rem; break;
             case 15: op = rv_op_remu; break;
             case 36:
-                switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_zext_h; break;
-                default: op = rv_op_pack; break;
+                if (isa == rv32 && !((inst >> 20) & 0b11111)) {
+                    op = rv_op_zext_h;
+                } else {
+                    op = rv_op_pack;
                 }
                 break;
             case 39: op = rv_op_packh; break;
-- 
2.43.0


