Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376BFC8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGS8-0000cR-0P; Mon, 30 Jun 2025 11:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRl-0000T1-TY
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:34 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRb-0008F3-GL
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:29 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7382a999970so2421266a34.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297356; x=1751902156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePUHGe7gQBW0tgnDTQB1WBsKviMpiMLipvjg21yNeZI=;
 b=PastALWr++51CHa1xQkdW4/m/NEy2dZKS9lYsis1sFbLTob3XrEwpkH6MBJnj7moA+
 TLzjSY3zxhZi9dIdK+SkcsjWUpYa7viZtWru6MbbpVvzvlhfHy/K98OesArJSrMKwgQj
 3est7lmOTEno0ZIHEChc1I3n+zunRFyMSklguJWl9ZSSYwEHqJAaEFSUlBNsxtSNYj6P
 Ukqz1ZMZ6pC5LMx+rqAvlIlHWUZp6kGU4yry/yhI/eYfcnDL3OKB0HGVaf/r2cJNbmfb
 bbHS0jQDGcE1PtzcBafLAwz3oGCUfDXc0g6beVIlBwLOz9BJh89tjJxnhH4ofGBsh4WY
 PoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297356; x=1751902156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePUHGe7gQBW0tgnDTQB1WBsKviMpiMLipvjg21yNeZI=;
 b=efGxN5Nzep4j8hkAZhM8Eq0yCMSaCg2oPcVu1QMlnfWNOyx8nHXwNZZE+E/5LPDi8S
 lst80SZNnbqrIXFnhwgk4brb7F8d62BPZrBx3VFQFGAnIUfcw8R/c3BTefKhN1RYmxkI
 OAW0RlcugcfGjNaYQRlYL2chmu8xpD8BVTHodJ/nCalbCvneWdNm+8e1E51K/gM9bc1p
 JOAmY/O/PTomhYoJdfxaHLeFdF3ep+rN3PiHZpFrBkV+LM6uv/SJr74IZQO70hItsb3a
 5AhVVDARa84mCsCVycN7jr1kDYNlrdMsfLwZnH/toI7j5CyFb9ZufvgmAQI7r4kEIPCI
 JG1w==
X-Gm-Message-State: AOJu0YwmulWOWbKrvkgahPxxgxdjYSU2qv8alyvITseffrPt7fHU+ap1
 JpR1NiH6Urjkq+HneW83YoKGoc6c6a0JjqSjM0tkJlkROPCLP7tb/nvxjwTzDY7RODIIAaMD2qd
 STFA2
X-Gm-Gg: ASbGncsKkquGF/Efg9QGicm7pNx8EOAfDxaqPr7AQGWr5VEMXlAlqqdI68cKEdRbCrr
 5oCHBAOc5sMbGewvd+qoeyLOZfo7PK6UcLPcqL70saGPf0PLWz6llitPK0+JSxBFFxdXeVv1FRF
 QoJoSGGKJjqnoC8Tp89QrJGodH+Dlue307IVrs98zIsVIPCG1jOJMqS6IHzIEmyjF6AkMotYPFV
 nHIfc5JLZq6yqs52YHCbPTFL9B96nPXDBO5gWktwIdjFYiWUnATvv8HJOZSJzVuNLZ1y7a6jFEI
 b3wteG6tBdwov0kM5Y5y4ZlGr1dFIqtlB46BYn7ErIKMO6jmxlPWkxFUq+an4W0vujjNHQ==
X-Google-Smtp-Source: AGHT+IFM6VQOtUnsSfH5Mq7WLgn3j7xwiiLm9jZVnze+lQCrvlbfJhJpHJxDsuAmw30kv1eT0saMMg==
X-Received: by 2002:a05:6830:6687:b0:72b:93c9:41a6 with SMTP id
 46e09a7af769-73afc640c34mr10986312a34.20.1751297355870; 
 Mon, 30 Jun 2025 08:29:15 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 18/29] tcg/optimize: Build and use o_bits in fold_extu
Date: Mon, 30 Jun 2025 09:28:44 -0600
Message-ID: <20250630152855.148018-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 103c94b12f..42d5ee23c0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2039,25 +2039,31 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask;
+    uint64_t z_mask, o_mask;
+    TempOptInfo *t1;
 
     if (fold_const1(ctx, op)) {
         return true;
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
+    t1 = arg_info(op->args[1]);
+    z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
+
     switch (op->opc) {
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extu_i32_i64:
         z_mask = (uint32_t)z_mask;
+        o_mask = (uint32_t)o_mask;
         break;
     case INDEX_op_extrh_i64_i32:
         z_mask >>= 32;
+        o_mask >>= 32;
         break;
     default:
         g_assert_not_reached();
     }
-    return fold_masks_z(ctx, op, z_mask);
+    return fold_masks_zo(ctx, op, z_mask, o_mask);
 }
 
 static bool fold_mb(OptContext *ctx, TCGOp *op)
-- 
2.43.0


