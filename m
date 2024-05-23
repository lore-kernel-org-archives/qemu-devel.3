Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6F1C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 16:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAB77-000595-NQ; Thu, 23 May 2024 12:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6p-000515-Lu
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:12 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAB6m-0002Yo-0H
 for qemu-devel@nongnu.org; Thu, 23 May 2024 12:16:03 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f44ed6e82fso2649190b3a.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716480958; x=1717085758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UWacmcJvifrn2h1svRsx1ekY33Etna0YPOTwfPRLIos=;
 b=V1qSH/PNG+eD/VMYQLwL5fvJGKIW9eDZ9sKUrCQTnFpWaYsvIz1oUo7k7PF+ubL34e
 P862B426wMrhCHrBd/FkLZgEcC3/PrSWRofVhQm3/9sAI1VfiVQ4LuadhS0G1FUqNcgW
 G8OMZXm4O6UMnWfaqUrbivqkINYetE0tZfPWA7g56VeJBezmK9mmNodbUrKWQJrdw7K0
 RwwwlFh4v0dQmC5mfC0VFz8Ss7hI3VPdTAre+gJQ4G4nm7WNtRAuJY3InOfCKtq7StGr
 m9FL/JX8sTu1BzmBhnerKeeuyVgJA9l+GTakg+co3r5iBbg7uS8jz4Z3/OKFJ2Ex56zk
 HRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716480958; x=1717085758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWacmcJvifrn2h1svRsx1ekY33Etna0YPOTwfPRLIos=;
 b=USr0KsmmVT36XgxVRdoCtF7XX3FGlfI9W63qqicHLtfhVeuSQzBZkixR54qMbTfYO/
 FlD/ibn4v1swpl55JoYBnuHhv7e1mS6kyaXyTM3U8XSw0jfMIgSwcTABT+TWId9cXcJF
 MhR2JSqmA3IAoajgy0SCVFwujPJjsi1aej8yytd/jTf3MpANLyfviuSbkUlCQzqhsrsk
 OiKkFekruWweq5U/Tc+Mf/8oUqPt2c90p/GXgRf0pAn89MKcYBxRK14LFkza+p6UvMeC
 7/xoZSjo4UPEkxUa0X37e3ng5KLD42tdEqTyERGgkQrVNbxdNf986KFr5AqNximiBcqO
 zBpw==
X-Gm-Message-State: AOJu0YwJhas6FYN8CpRQgSC8Y0S/g3hLQ1vhVWMRI9gC1T8Z7w0yxYuJ
 7nUuHw5/Ima7J664tPuqIsYZmsw/t+iZSIuHKZX0rI+7slDcAmWNwqrT2RuW0GIkd09rwwkWVLQ
 A
X-Google-Smtp-Source: AGHT+IGUj0Rw+wOKGQHjSrslOtYl9f3xBS2Ldgre/SQv14JybQbcgeNDLCk3G490S86MHU0ilyNT+A==
X-Received: by 2002:a05:6a21:2792:b0:1b1:ea57:d6ac with SMTP id
 adf61e73a8af0-1b1f8a749c2mr5167051637.51.1716480957009; 
 Thu, 23 May 2024 09:15:57 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a9d9acsm24890255b3a.90.2024.05.23.09.15.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 09:15:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] tcg: Expand TCG_COND_TST* if not TCG_TARGET_HAS_tst_vec
Date: Thu, 23 May 2024 09:15:50 -0700
Message-Id: <20240523161553.774673-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523161553.774673-1-richard.henderson@linaro.org>
References: <20240523161553.774673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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


