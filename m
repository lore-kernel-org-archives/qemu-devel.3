Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A3C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFP-00005e-09; Thu, 02 May 2024 01:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PFD-0008Oj-JR
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:36 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF7-0002dX-ME
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:35 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5aa20adda1dso4763077eaf.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628668; x=1715233468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vaaa9XarhFGZUE0t2SjhtfY2cRwW+ttdC8tie4SkVgY=;
 b=C8fpeXoMjFJB/YbKrn0M8KsZ0g36rwW/3kpBh3nio2eouoJhUp4DJqRuY8DXiBb6ud
 gTZ+rezNj4K+ytgNmPcbKYHcWeL+M5wFXtxSGMt0XBM8BP8R96jfV1NyhWE1gB/F8Xs/
 W01x5T5ItSuRqfwKjCrUbVrVc+8HhH5HC8XWXGjoy33793sFQKn7S/DuWi5mM/Xk/uTM
 t+cWbz1CsenUuwTeAyuN1+hgpY+DQoqLpJH8alLpJmcUxZiAgRknfYz/DABr4DWK1SV+
 ifnB/O1YeLqNIh4rzuXqqSshd6VqwfF5Ht362YYsMaiz3A2gkp4hlwOf4zg/N0hjdkus
 Naxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628668; x=1715233468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vaaa9XarhFGZUE0t2SjhtfY2cRwW+ttdC8tie4SkVgY=;
 b=Dsj6Gis1wZWnSkFb2Fl8iUd863vTIVev7dv9xiMrN4pcaEE4zhJ4k3/CpTPNjp253P
 pSQRLTKRrcSi/R4Yx58YWr083AgB6UYXEqozu1PxaBxep5I9D/UasrVj1sPsvr4utzOZ
 qArdYS/qO32J2nM5gVHdU4mue4DHmhJF8Fm20hNL7maOnaYpqiw/cJrYU+BRtTojRoNZ
 8L4JlMx6pWj6N8w+Ly1qwIfZP9p+vqNPTTkWGYiHB1TrYCQZR8UNpE/yNGF21g7K85c8
 YXEH51bOB6OanHcWxlZOHgVQ+1c9dNZglv34ASkiI2OwpcIIXFwECC+cej4FM8TtTXk3
 5Quw==
X-Gm-Message-State: AOJu0Yztk33avNdicblNoB01HxInzJozS6kW0MI8OY9e7FiPA82eH4bp
 qVyse1TiMiKd0eU2RqQtpvBBocADD748aiiIGd5nxm6ttF7PM7xBjsZzKKpV1KhI5l0QKmw2ya4
 s
X-Google-Smtp-Source: AGHT+IHS2KUvGqlXRtfNRtD9pCJMccIwhGUDAg5y9uEAq3vVV0qTxU2ncUM0jJ1fUknRnT5D6HPuLQ==
X-Received: by 2002:a05:6358:2799:b0:17e:f422:5e48 with SMTP id
 l25-20020a056358279900b0017ef4225e48mr5188538rwb.13.1714628667845; 
 Wed, 01 May 2024 22:44:27 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 08/14] target/s390x: Split per_breaking_event from per_branch_*
Date: Wed,  1 May 2024 22:44:11 -0700
Message-Id: <20240502054417.234340-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

The breaking-event-address register is updated regardless
of PER being enabled.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index e77660ee50..a384192d15 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -346,8 +346,6 @@ static void update_psw_addr(DisasContext *s)
 static void per_branch(DisasContext *s, bool to_next)
 {
 #ifndef CONFIG_USER_ONLY
-    tcg_gen_movi_i64(gbea, s->base.pc_next);
-
     if (s->base.tb->flags & FLAG_MASK_PER_BRANCH) {
         TCGv_i64 next_pc = to_next ? tcg_constant_i64(s->pc_tmp) : psw_addr;
         gen_helper_per_branch(tcg_env, gbea, next_pc);
@@ -1083,13 +1081,13 @@ struct DisasInsn {
 
 static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
 {
+    per_breaking_event(s);
     if (dest == s->pc_tmp) {
         per_branch(s, true);
         return DISAS_NEXT;
     }
     if (use_goto_tb(s, dest)) {
         update_cc_op(s);
-        per_breaking_event(s);
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(psw_addr, dest);
         tcg_gen_exit_tb(s->base.tb, 0);
@@ -1103,6 +1101,7 @@ static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
 
 static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
 {
+    per_breaking_event(s);
     tcg_gen_mov_i64(psw_addr, dest);
     per_branch(s, false);
     return DISAS_PC_UPDATED;
@@ -1161,6 +1160,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
     }
 
     /* Branch taken.  */
+    per_breaking_event(s);
     if (is_imm) {
         tcg_gen_movi_i64(psw_addr, dest);
     } else {
-- 
2.34.1


