Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36F5C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QE-0006rG-3s; Mon, 05 May 2025 16:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q8-0006my-9Z
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:12 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q4-0000Pu-5N
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:10 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so4934963b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476885; x=1747081685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x2Y0NbHwSVautraRUSm70pcB+uKrHArjhxj6kfxjpLE=;
 b=bM4+lO4LinN16I7fzhUPbeuX688TWoEIREA0PcDLNKzJRVRyjepsT/uf2upz8Mnr3+
 bu5K/7olD/biC/bWWnvm8qFDJFXumKSGVBSWWcUuJMP3iTDeMlBmFsR5OGg45ncGlLuY
 pck1rE3kzedhOl1tUg/XoPj8O4RObWxXeu83VaZd7xeyt8avK4rdAF8dxDZhj/6/ML3+
 LZXS3CBFgK5Ma1aLiYwGTc/oWkE93zO1gBjtM0+Z1KlJotAMe4huTRNJGcIdyT9TtmNq
 noECP+/OgRLkH5v9T29h2cVZP3Wdb6Q19u7O04Ktg/jzoAyATUf6SEhtWEJ7IrBYY6so
 B/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476885; x=1747081685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2Y0NbHwSVautraRUSm70pcB+uKrHArjhxj6kfxjpLE=;
 b=cfMpzX3jCXfAHuC74PTLZVi0HXEUNnLlWlq1BwgryWAPsP0ZVWGdbtx1c6pvVhg/Wq
 sa9XGlEo1CQH7nFL+DQuJ8hcDt/zoIPucXlny98QldunUXDasCGHPBFlq7sKU7o6Qaoy
 MB0KmzhIh3C4vqMTL/V/sMh99sT27tHkA1HVQszYV/Lb83+dkeWU1OoYeVmKzYys1T8S
 L/JDu9xb2E/DcBYFT5k5r59cFblVR+UnwVmTcuNxXf7m5mQmuFsD77ASUvpyIXhuu2XA
 3u/0X6/iYMWHVWESaftShgRPvkRiK7142t2ynngNMEjIZrfLdvh8ypDNLJh2Tihd7O15
 bOWw==
X-Gm-Message-State: AOJu0YyYdAH8EngBmhiMxJnpqlCwixxQSUjMBhS5U5xzDevmvkETZyaX
 VGZHXF8Fz+G5W4/CcD+aUEWQI6cWmvQXDLRltyaWz+gqYdlVdFerww0Je3gO1qilod8EKa5v9MM
 Q
X-Gm-Gg: ASbGncvUi1ZL/zlfCALiI7RCHSeaAgzwm+yvKZ5vgybMbRNY6XbuAeQ01ht7k3xMWsB
 wzFrFZ81eXM0cH+fAEkU7+WKilGYe7OIwcN3xD2x7Ujfq20H4Bw0WWiqIdd4T/Qr6G+V5kxwrCC
 bBcIZkEcYszvnDgreCPYFYCnJOQAfrD1fI3VHdhcu59Nh8GSdnfy1qak1c4pFGgqzTSa/a85/gl
 XvyUCYfqjrxD02uqZIMoVZGhrn4V2x3EsQhjhP5Ab23bZ2gOSNK6JpEMXlHk5Phs4mVzLDH3Oe1
 81OVT+bNE2Fyg3LLnEzV6QU0C5WpUydDyiRfR4Vtx0y0BjHZC/7IhoXu5rSpJyFBzAoH7vTPdDI
 =
X-Google-Smtp-Source: AGHT+IEsTa5uoZOymy4ehTykwFajrc9EJ4N86QXSPPPFJpaxUVezO+Wh67TMNjVzsBToUU9koUKiew==
X-Received: by 2002:a05:6a00:428e:b0:736:2a73:6756 with SMTP id
 d2e1a72fcca58-74091ac95camr606099b3a.21.1746476885190; 
 Mon, 05 May 2025 13:28:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/20] tcg/optimize: Build and use o_bits in fold_extract
Date: Mon,  5 May 2025 13:27:45 -0700
Message-ID: <20250505202751.3510517-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 886947b82b..c5243392af 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1091,6 +1091,12 @@ static bool fold_masks_zos(OptContext *ctx, TCGOp *op, uint64_t z_mask,
     return true;
 }
 
+static bool fold_masks_zo(OptContext *ctx, TCGOp *op,
+                          uint64_t z_mask, uint64_t o_mask)
+{
+    return fold_masks_zos(ctx, op, z_mask, o_mask, 0);
+}
+
 static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
                           uint64_t z_mask, uint64_t s_mask)
 {
@@ -1958,7 +1964,7 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask_old, z_mask;
+    uint64_t z_mask_old, z_mask, o_mask;
     TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
@@ -1974,7 +1980,8 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    return fold_masks_z(ctx, op, z_mask);
+    o_mask = extract64(t1->o_mask, pos, len);
+    return fold_masks_zo(ctx, op, z_mask, o_mask);
 }
 
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


