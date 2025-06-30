Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94F4C8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSY-0001IX-FM; Mon, 30 Jun 2025 11:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRt-0000UK-Jx
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:43 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRg-0008Ev-Vq
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:37 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-735b9d558f9so991277a34.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297357; x=1751902157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jATSbSJ+A/6hV81CQNrcRjhOil/0/zy3N0rZ0dVrd5E=;
 b=RzN/QbadWUJLJRM7bp6inzASxeYh5yhiry8J8dIOusZ96iJMKZ/iaajEWr/dHdeHQI
 rcy3VH76mm/ULUCRJ2ZHkq0jTRl/HsvrHsJDZ1kvQXW9zp5cfSeAd+lD2e7gg4ohFuQZ
 ok+W+//gkFpIS89NQzvOH0allmpt9Q2H0Ym+E5aVb8YbSCK9x3Hmxajrbx966sqe8nQE
 Xr+I+mQuck+PLNhfDQRj+yHdQmNgz1lUGEEdV3wolmMXqR4olN/y42snbs0jj5inO3NN
 OLopB3Kl1Jo89iW8sApjpku7njce9Uh4KhhDdKZKIVt5Y4pjdCxWdzWJXAr8K452LBUk
 ve5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297357; x=1751902157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jATSbSJ+A/6hV81CQNrcRjhOil/0/zy3N0rZ0dVrd5E=;
 b=JMrUgAlOqDT/4XsKGtuVjXt5lDbYfDZezoOripqKvV31UJXZI4M5u/E55vEW8a7c2J
 myU9OFEsnVmmCv2YTsexYQEPKq7ZpEa04OEBC6o3oeW9TZT1I4vQfoKHm91G1XwKS6Uw
 EaG0nuWU8o+oJLZlLL/LfSZBVJgoFVPG8OJOuWUWAj8UfU3MFaeaBOZXHvzvIx6IFtKR
 NQGynDnKl9p4NL4rzsgtk5hqx83jXqSTfEmoJDS+fE2RdQS9V14nXrT+LSIuVM7Wf+8n
 DHRG7G1BaOyccVuCrrAGITw2tIGvOx/+qLLua09I411CzjH6uQW3lIH3H9ROllYRdkNQ
 964g==
X-Gm-Message-State: AOJu0YyGIL0yejAtTZjiiS2ggzbfNIRQvaf4DNSZdoCQASOQO3c+RQTd
 mSvMAZUqsOU4ln6uyXf4RPEh6VuJQ5IP2Q97CnFFWYAJYFoNudrLvc4up15bhU33pVyCwr7Fosi
 pJxj6
X-Gm-Gg: ASbGncsMYJQkR06hsgwKfnuIEn2SWOo8ALmrXpMQVRmIQB3qs+bJ7nDYDFims54lab6
 VxiBsQ17HbWCiLafAjFejL6Rha4O1ioS6lZDihEOd5u01FxnOYqx6D6BFyG4U1H7yEQwGjxj5te
 GnGfzPAFCPXc/bQLy9ci+QG3iTEnXizy7s8ZpqFE2LClPs/tXEZKyzvOQGTdOURmsYUhZ2QrjGD
 GoGl3zOzK7UTx3DgDBSkM9rkdL0nbTNRK1AbSEzHG4AduxE8xSOVqR0R/ix1VvWiHeQ/pvbyudI
 kUKcyPCKfqmzU+vBxLnrL2GryNA+MMFWPI3zQaf0KBOUzz2ot5e/8ve6JEvvdxdBe5UVoA==
X-Google-Smtp-Source: AGHT+IEl1JcnW8ChWE0clN2oKZy9369urTls19mcMvkU2K3XPtUhD9PhMGdscG/yyNrJTZJgwXw2yw==
X-Received: by 2002:a05:6830:6c15:b0:73a:96e5:19cd with SMTP id
 46e09a7af769-73afc55e1b6mr8786075a34.10.1751297356570; 
 Mon, 30 Jun 2025 08:29:16 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 19/29] tcg/optimize: Build and use o_bits in fold_movcond
Date: Mon, 30 Jun 2025 09:28:45 -0600
Message-ID: <20250630152855.148018-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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
 tcg/optimize.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 42d5ee23c0..abcbee9111 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2097,7 +2097,7 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
 
 static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *tt, *ft;
     int i;
 
@@ -2123,6 +2123,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
     tt = arg_info(op->args[3]);
     ft = arg_info(op->args[4]);
     z_mask = tt->z_mask | ft->z_mask;
+    o_mask = tt->o_mask & ft->o_mask;
     s_mask = tt->s_mask & ft->s_mask;
 
     if (ti_is_const(tt) && ti_is_const(ft)) {
@@ -2145,7 +2146,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         }
     }
 
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_mul(OptContext *ctx, TCGOp *op)
-- 
2.43.0


