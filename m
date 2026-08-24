Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8BBC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbA-0004p6-3U; Mon, 24 Aug 2026 01:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZm-00031W-Eg
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:31 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZk-0002S3-7b
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:30 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2503117a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550627; x=1788155427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HiY1OdOtBijExrR7AqCE72zrQVCis7QsYpBlu+X6Ymk=;
 b=NKXJt7tGJ5dLKxTh5Q91TLXa8lBbcwsewsVlkl3UYvtMJR3cbGcdMTz4z8PV+bGU2u
 794/ld4ybIssKRTP1CvK8XBJMIbjRRJRAYRYo0ibx80YiFJ8bvXh6pA0r3b1PjYcWflA
 PkUjmsZ5BCntCBnjHibqnTZqq7QtaVK2V9RGuiR/dfNb3d8EMZKRPRF593Vw6W4cDSkR
 iwOSKGkskqQv+76UFOAkBS2MFbUZ088+ckSrcHYJVKIL3h7DzGdidUfBV9zUs4GAOtXO
 03N/kU/xMFB0V6hruPoZDr50+j0xP96ULBuABJF3YLxLc+3GGpdxLHKs8aMGUejChBFi
 kjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550627; x=1788155427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HiY1OdOtBijExrR7AqCE72zrQVCis7QsYpBlu+X6Ymk=;
 b=QFHVj6OIprCZ7aoHqAFJq1z0Nas02vYFC6vNZ+74nqU5TAL6Ik6OBI4WsIp4IPza1A
 wQK1Q5rME8gYfH2q7cBza0MKXcIGNubWw5nzHlgxtMDWUOFjFv6w5lNbAy2wqGlBMTsa
 EDbVN4/zLpQG1nseIQmJ0yRSujek53jIv0vthM88EAVkNqwWL+80oz5l2lbgdsAA+jV6
 F59wveJPrQtedncouTxh6kh3oU11qJxl6ePqMNcVxJcZsih6OkfbnXV3AQjAfbFZ1XU/
 S6VeLp4qq0gc6jBQOLF6PXh2lyxY18h06tRyQKnGW6+z+rPXqolXgerkRyrRmOcjdgh4
 DttA==
X-Gm-Message-State: AFuF++kvr28TugGh6OuAAoxMz2gER1fcecJxpis/ai9SPQwm+lKUWpfH
 xu08juxElx9v7XVSUCHrQ/Lhjyk0nIATkTSvbSorqSAWaYxVLeOAFoPVrGW41w==
X-Gm-Gg: AR+sD12eMQzXmZPGjUpc9A+/nUZ8SrzgZd1+a1iIpSVMIgDNMdxT55j1X8okw3JUIsH
 UIyC1Gn+G48HEMtrpvrzrDfbv8geE4qG+RFrNSufssLjKkz60wxJy5rR8xjcIw3j7C04HHsSohc
 FYBR3iy6J3b7bUhHOS0XnJi1cI4EsSiQZ9s8COpzWH2ERQzfxoKSfQOQJhfZK7lFUnrGI+MKB/q
 kfoyxr5nflWbtviKx1+bBhynEn+QGwqPcF5lIUhtfGfkuxlHLpPgHLX+9jOiocDlhXkByVyTO3J
 ddyBKPCg+LidtQnHWXP8pNOD6MIFtgP1QF2yiS2BgCJ15AuE8/9w9hDnMsai6FcAO7vk5PABTV3
 qg1vcWqIEJzReT3uDSnjDxgog5gkSQr8lzG5NC205Jms+NiINscfAQUWnJFevzw1lm31xK9uthw
 9bC6p+KIks4xxL6QrL568zX+IM4gb2zB5Us1je1gq1BHEqlvGoVP7mjga5oJYELmN8V8nVryL4x
 NqTcA==
X-Received: by 2002:a17:90b:3e8d:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-395c4fa444bmr14521579a91.5.1787550626649; 
 Sun, 23 Aug 2026 22:50:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 41/96] disas/riscv: Tidy disasm_inst main loop
Date: Mon, 24 Aug 2026 15:47:11 +1000
Message-ID: <20260824054806.2790041-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Unroll first iteration, so that always_true_p is not used,
Drop some local variables and use 'decoders' directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-9-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 65 +++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 70ea41f125..9880b8de20 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5419,41 +5419,40 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         .inst = inst,
         .cfg = cfg,
     };
-
-    static const struct {
-        bool (*guard_func)(const RISCVCPUConfig *);
-        const rv_opcode_data *opcode_data;
-        void (*decode_func)(rv_decode *, rv_isa);
-    } decoders[] = {
-        { always_true_p, rvi_opcode_data, decode_inst_opcode },
-        { has_xtheadba_p, xthead_opcode_data, decode_xtheadba },
-        { has_xtheadbb_p, xthead_opcode_data, decode_xtheadbb },
-        { has_xtheadbs_p, xthead_opcode_data, decode_xtheadbs },
-        { has_xtheadcmo_p, xthead_opcode_data, decode_xtheadcmo },
-        { has_xtheadcondmov_p, xthead_opcode_data, decode_xtheadcondmov },
-        { has_xtheadfmemidx_p, xthead_opcode_data, decode_xtheadfmemidx },
-        { has_xtheadfmv_p, xthead_opcode_data, decode_xtheadfmv },
-        { has_xtheadmac_p, xthead_opcode_data, decode_xtheadmac },
-        { has_xtheadmemidx_p, xthead_opcode_data, decode_xtheadmemidx },
-        { has_xtheadmempair_p, xthead_opcode_data, decode_xtheadmempair },
-        { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
-        { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
-        { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
-    };
-
     const rv_opcode_data *op;
 
-    for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
-        bool (*guard_func)(const RISCVCPUConfig *) = decoders[i].guard_func;
-        const rv_opcode_data *opcode_data = decoders[i].opcode_data;
-        void (*decode_func)(rv_decode *, rv_isa) = decoders[i].decode_func;
-
-        /* always_true_p don't dereference cfg */
-        if (((i == 0) || cfg) && guard_func(cfg)) {
-            dec.opcode_data = opcode_data;
-            decode_func(&dec, isa);
-            if (dec.op != rv_op_illegal)
-                break;
+    dec.opcode_data = rvi_opcode_data;
+    decode_inst_opcode(&dec, isa);
+
+    if (dec.op == rv_op_illegal && cfg) {
+        static const struct {
+            bool (*guard_func)(const RISCVCPUConfig *);
+            const rv_opcode_data *opcode_data;
+            void (*decode_func)(rv_decode *, rv_isa);
+        } decoders[] = {
+            { has_xtheadba_p, xthead_opcode_data, decode_xtheadba },
+            { has_xtheadbb_p, xthead_opcode_data, decode_xtheadbb },
+            { has_xtheadbs_p, xthead_opcode_data, decode_xtheadbs },
+            { has_xtheadcmo_p, xthead_opcode_data, decode_xtheadcmo },
+            { has_xtheadcondmov_p, xthead_opcode_data, decode_xtheadcondmov },
+            { has_xtheadfmemidx_p, xthead_opcode_data, decode_xtheadfmemidx },
+            { has_xtheadfmv_p, xthead_opcode_data, decode_xtheadfmv },
+            { has_xtheadmac_p, xthead_opcode_data, decode_xtheadmac },
+            { has_xtheadmemidx_p, xthead_opcode_data, decode_xtheadmemidx },
+            { has_xtheadmempair_p, xthead_opcode_data, decode_xtheadmempair },
+            { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
+            { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
+            { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
+        };
+
+        for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
+            if (decoders[i].guard_func(cfg)) {
+                dec.opcode_data = decoders[i].opcode_data;
+                decoders[i].decode_func(&dec, isa);
+                if (dec.op != rv_op_illegal) {
+                    break;
+                }
+            }
         }
     }
 
-- 
2.54.0


