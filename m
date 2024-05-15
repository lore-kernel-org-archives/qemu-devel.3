Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D55C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7G6C-0005G2-Ct; Wed, 15 May 2024 10:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G68-0005EF-9j
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G5x-00078y-I3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42011507a57so30727065e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785143; x=1716389943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWacmcJvifrn2h1svRsx1ekY33Etna0YPOTwfPRLIos=;
 b=R0snUELRb9f+qEXOJ7oaxi0HazuD65FDv1mnD6P1EaKZNSn6lVXqZDaLCSsZH51ahP
 mtIqNzg17qmxbzfhZ+d/BdVu0E/3w+QPCbmJE5LAfSk3YfIDi8Hq+rwqkyIWVQs1s5tW
 NT+A30coUtY5A5vidnOVkdgiu14vEeVox2YvrYPc+0cb++KIgsDVgKC4gdIKzEL66vfb
 kkrcSwW4EHABYwPxnPLoeqQ2wrAcgbFeN1xXPclrshQRqaoMb8D0bMMlOL1Y2Su0nO1E
 6gYAUxZRPTd0ijeBeWgAhs+7CylFmiSJUA+j2qYe1pIRhhNbvwxGmJhi1HnujE5TApG/
 YfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785143; x=1716389943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWacmcJvifrn2h1svRsx1ekY33Etna0YPOTwfPRLIos=;
 b=SA46reBlec3E+zvhVoE92Vw0SyNur3iiIP1PTcg5DHx23dcZHXn6i2xzgKHoyrzfCg
 PeJibd806rpWMiKTk29E9jcs/bzMAsFnwPFhcbzb9sxIoFZMtfMPMJZYdI6A+5QUtyvp
 yo0I/Gj6IhIAFkUJRbPEOtDrDK4mfNVGHqHCHsYwh26UD9J4owmcg0xhfOg4uhyi73Fk
 ZnMl4rF8lwo47ErIc4IFClI6+Hr3Bv/lFCAy3vsp3dHh5y8ruK60q3fNbd3lBeXqSKuh
 +Jv8J6wj9s8eLOTAZEclRrDNG/5TblGOcYS+KkddEl++bkwddSaysnL5YQwjlj4ekFtA
 wr5Q==
X-Gm-Message-State: AOJu0Yz4WK63WGHQ1hMb8354v/4umkUuXUALrrMPZ7/6T6NqQ2Rephux
 h4nRLFAkR2WSJgSg+it4RBg4xpXd/j71fjK5BZVgJtQbtx/bExQa4LWROPOGKkMw58dChKv0aB6
 3Of8=
X-Google-Smtp-Source: AGHT+IE7zL6Fxi+gelknHaxO/VZ9BB2z123z6SJFMC+FUyhaINEonAtLpVD+gg93Kou+wtaseQcsCA==
X-Received: by 2002:a05:600c:314e:b0:418:3eb7:e8c6 with SMTP id
 5b1f17b1804b1-41fea927e69mr136973615e9.5.1715785142815; 
 Wed, 15 May 2024 07:59:02 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88111033sm272134645e9.34.2024.05.15.07.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 07:59:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/5] tcg: Expand TCG_COND_TST* if not TCG_TARGET_HAS_tst_vec
Date: Wed, 15 May 2024 16:58:57 +0200
Message-Id: <20240515145900.252870-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515145900.252870-1-richard.henderson@linaro.org>
References: <20240515145900.252870-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 094298bb27..84af210bc0 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -508,9 +508,11 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
     TCGTemp *rt = tcgv_vec_temp(r);
     TCGTemp *at = tcgv_vec_temp(a);
     TCGTemp *bt = tcgv_vec_temp(b);
+    TCGTemp *tt = NULL;
     TCGArg ri = temp_arg(rt);
     TCGArg ai = temp_arg(at);
     TCGArg bi = temp_arg(bt);
+    TCGArg ti;
     TCGType type = rt->base_type;
     int can;
 
@@ -518,6 +520,18 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
     tcg_debug_assert(bt->base_type >= type);
     tcg_assert_listed_vecop(INDEX_op_cmp_vec);
     can = tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece);
+
+    if (!TCG_TARGET_HAS_tst_vec && is_tst_cond(cond)) {
+        tt = tcg_temp_new_internal(type, TEMP_EBB);
+        ti = temp_arg(tt);
+        vec_gen_3(INDEX_op_and_vec, type, 0, ti, ai, bi);
+        at = tt;
+        ai = ti;
+        bt = tcg_constant_internal(type, 0);
+        bi = temp_arg(bt);
+        cond = tcg_tst_eqne_cond(cond);
+    }
+
     if (can > 0) {
         vec_gen_4(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
     } else {
@@ -526,6 +540,10 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
         tcg_expand_vec_op(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
         tcg_swap_vecop_list(hold_list);
     }
+
+    if (tt) {
+        tcg_temp_free_internal(tt);
+    }
 }
 
 static bool do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
-- 
2.34.1


