Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F4DC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGRZ-0000QG-TQ; Mon, 30 Jun 2025 11:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRY-0000Ny-7e
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:16 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRU-0008Cm-SZ
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:15 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73af5dc0066so977071a34.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297344; x=1751902144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEnCNhfCm6D5wZcrz5VqZsMscK+PR14Jrfi+YIMhByM=;
 b=Kaq0fLPV9DdCzlaco/4hlWJUHCfJ8R2fRrx827VgFgpOxliYse5u0TREAxVdeQ9vjV
 vHociOKi4lSjujthIKcAxj9/Y8ubIh6DXl5t03Muk7EMbHN47DUD+Hwa0DDTUinfRi2p
 dau4k0BCRkk6ioieyRWgrwQTmqP1cRfWvyKPoDnmKrKlDvMiMqFzodukYpR4CcNMcb2I
 CaYJJ6FWy1rWnTIsO70xzgNvkXQQsPvyz6pICeL90ddrFdrOKtwEggr6PtE3ZJCw86sY
 zFvbpzIkLcY1GCWohL6Ggl4ScYWa11PkQDs2lex/ZwwX8/7YuajeBIWekL0reWgU6G3D
 GMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297344; x=1751902144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEnCNhfCm6D5wZcrz5VqZsMscK+PR14Jrfi+YIMhByM=;
 b=mAwXSZuVLAGsNxjl0OuRbppKBmxkwXlyrY2ZV/x+0x97B7yJiPgIdXwTkih+Oc6bEe
 BoE5ZeSjzLdAKiNSiSXdSRIOsSOEvWlJiA9G81MRnfYs3otFnQxTubsMxConhy3E1kbd
 kcuWx3L7fRON8ERxTV0pLVueWBTveIT+QFJWkT/gHKXl2/Es94CsEoDa+qg4d5ZC0qCl
 TAA3O4PPS+uEBXXylCg1jMk+by7KY5bzQ+AJqMkabAzmC67QlloTkYGsVLalg6jrHjCC
 vgDVl5AwUXTaJFZS3hcvzElJ73ochFNFZ9IAr+wNBmZ26whzdgEalY6yljqdOttj9y+n
 SURw==
X-Gm-Message-State: AOJu0YzD/Y1XOpz68WWnkc75HroVkYdJeWvoulboNRZfCW2Pn03iyT/1
 np1FYa4zzZPNHYA+RBlED4P2+3bdWT0GtpgAbvORJMsQNV1XXd9B/PYt4Ar5kkZdH5cW+zSK0ZM
 cxE5R
X-Gm-Gg: ASbGnct4khj3yJnLoCE302OWiQWUyxjDzuilDXK3vM/U5xbwy4N8Jtl7V48vt6Ora4E
 muOJhIRPfiFlHBa6GAnKHdUd9GdodEerz50d/s4vaxLe+ypjlVLiw3o8radrdcUyiu1HtFYTOXk
 eFetKsnkSDPDnFa2/Adcm9Vq3lKBia9acwzYbbgM0FA+h+pA0Zwy9snGOnzdIbkaEMJ9LfPMaVi
 Ojn1L6LRwtI6h5qbOiuA7J8b/WXRH+eVm4wsobrahuD8sJLD8GvXHH5G0sPOt0MxG00q8/39WIn
 Jo5r8JkfpSqxIr7pgkx8hKNUcbXngnhEnIsFhQn+EK/e1J1yMi91SRZVR+YJBoocHKwJ9w==
X-Google-Smtp-Source: AGHT+IHqkSinxrWjFPDoshhGjjlFnCX5VJNqr+lQveNzq+Xw56P8FgfEVVOkYOs/AVPvNEwvB10FjA==
X-Received: by 2002:a05:6830:600c:b0:72b:84a7:47e0 with SMTP id
 46e09a7af769-73afc4313d0mr7784699a34.1.1751297344070; 
 Mon, 30 Jun 2025 08:29:04 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/29] tcg/optimize: Build and use z_bits and o_bits in
 fold_nand
Date: Mon, 30 Jun 2025 09:28:33 -0600
Message-ID: <20250630152855.148018-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6d35a2e58b..758f7b142e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2197,16 +2197,22 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 
 static bool fold_nand(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, -1)) {
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    z_mask = ~(t1->o_mask & t2->o_mask);
+    o_mask = ~(t1->z_mask & t2->z_mask);
+    s_mask = t1->s_mask & t2->s_mask;
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
-- 
2.43.0


