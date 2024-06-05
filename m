Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E9FC27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydj-0001la-Ot; Wed, 05 Jun 2024 17:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydh-0001kE-St
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:49 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydg-0003r6-9c
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:49 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7024791a950so993844b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624667; x=1718229467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqJiYcxvLTtBfrkGq1JS6zQ0ORon0JfeSUXl0F2Pjw0=;
 b=IJjguOA+wV76QeGHf1bPQswLwsRlKjCgXnCZGMcpbUmDxjkVDekFZvkEUynDcRt6Ah
 O1GXkEf+cOt0FoWvEEDD7a7e0pW+1otDUEqYdzCTZbv7VKdYKBrHKI3er3Ub/MqpANqQ
 nIOTPd7jpKss7OsMmwe+l1hR77QkoU40Q9yF8JSCeYegmNc72P6j1UUsgdg9P80pgyG7
 bUeN8zyO6ynkQSA17QGm7zhfnVncgfJ9Cz0B2J5vmo3+RaGF/TeXqmQrbyYsfYYoy2x/
 n4o+NRcPpUcMPlP6nc0FcOzuUIZq1Puzvv03QIVXOVLVLmFjXC+C4cXrt/nkrscqkta7
 aXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624667; x=1718229467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqJiYcxvLTtBfrkGq1JS6zQ0ORon0JfeSUXl0F2Pjw0=;
 b=sUyyonhCfI1i+wA4Hb97yUyWYj5MsbzwfwKCNkE5zTgrPbAe7v7PdRpibH08I6TPCw
 R/CYJBbxRczA3aKbVkGI1XtplzVs85GmFWUOD6ngm7s1W5C7Ed5N9v42dMgvB9rTfpOM
 mIOImaC8Q8E/9EHOCl5aRQWz68vYPcgxg+68q7t7pzQOAd8/kpK9hMbNy23CCs74f61X
 dxg+1RjIHa24oBS5bAkpeP/OLV92XVK7txyJL9DlX6OPnvVQRJ6Ndxj7luPVhvcAD6f5
 djoGBjdmgZzFjyuYdEr93e8QDO6UfDsP/cuNoEbBJ8rRbnWzGlkcIN0XYj6Mfa027NPV
 P/TA==
X-Gm-Message-State: AOJu0YxdvwfP4iOjPLDU0EaQeS/kaH8dIoOwqNGKLLYq82cwu6cjipLJ
 Y8VmhxOFOrHR7WGPUsy0RCHSoEyBSLYN98EjOsV1nIL31c+QZ+Qh+6KjzX4OYa+HCzYgeNLOjO+
 J
X-Google-Smtp-Source: AGHT+IEU/n0+Cd/+x13+8albmCF6ZvlsR+3nUdVjH2KEtjQ+w4jU7vlY46HSJ9HQRvLGLho1kzN+vA==
X-Received: by 2002:a05:6a00:6611:b0:702:454a:f543 with SMTP id
 d2e1a72fcca58-703f83ce2f4mr1043707b3a.0.1717624666963; 
 Wed, 05 Jun 2024 14:57:46 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PATCH v2 06/10] target/s390x: Use deposit in save_link_info
Date: Wed,  5 Jun 2024 14:57:35 -0700
Message-Id: <20240605215739.4758-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
References: <20240605215739.4758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Replace manual masking and oring with deposits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 2654c85a8e..0f0688424f 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1418,24 +1418,32 @@ static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
 
 static void save_link_info(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 t;
+    TCGv_i64 t1, t2;
 
     if (s->base.tb->flags & (FLAG_MASK_32 | FLAG_MASK_64)) {
         pc_to_link_info(o->out, s);
         return;
     }
+
     gen_op_calc_cc(s);
-    t = tcg_temp_new_i64();
-    tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
-    gen_psw_addr_disp(s, t, s->ilen);
-    tcg_gen_or_i64(o->out, o->out, t);
-    tcg_gen_ori_i64(o->out, o->out, (s->ilen / 2) << 30);
-    tcg_gen_shri_i64(t, psw_mask, 16);
-    tcg_gen_andi_i64(t, t, 0x0f000000);
-    tcg_gen_or_i64(o->out, o->out, t);
-    tcg_gen_extu_i32_i64(t, cc_op);
-    tcg_gen_shli_i64(t, t, 28);
-    tcg_gen_or_i64(o->out, o->out, t);
+    t1 = tcg_temp_new_i64();
+    t2 = tcg_temp_new_i64();
+
+    /* Shift program mask into place, garbage outside of [27:24]. */
+    tcg_gen_shri_i64(t1, psw_mask, 16);
+    /* Deposit pc to replace garbage bits below program mask. */
+    gen_psw_addr_disp(s, t2, s->ilen);
+    tcg_gen_deposit_i64(t1, t1, t2, 0, 24);
+    /*
+     * Deposit cc to replace garbage bits above program mask.
+     * Note that cc is in [0-3], thus [63:30] are set to zero.
+     */
+    tcg_gen_extu_i32_i64(t2, cc_op);
+    tcg_gen_deposit_i64(t1, t1, t2, 28, 64 - 28);
+    /* Install ilen. */
+    tcg_gen_ori_i64(t1, t1, (s->ilen / 2) << 30);
+
+    tcg_gen_deposit_i64(o->out, o->out, t1, 0, 32);
 }
 
 static DisasJumpType op_bal(DisasContext *s, DisasOps *o)
-- 
2.34.1


