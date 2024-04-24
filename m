Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D694CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5d-0005qZ-Hk; Wed, 24 Apr 2024 19:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5V-0005m0-WF
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:42 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5T-0003R5-Uz
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:41 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ad8fb779d2so400936a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001497; x=1714606297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0iznKbTX8oBcbpJPieQQMWlAI4HDAUpQMvJb/sM2VnA=;
 b=oHeRMg/2+/cO2VyzeYyA/D0BWR3Pcj7Ks/aQSA4VTYFAZrikXn0VBX9vIqLK3dvUrw
 Ibm25juYs3PAgzj8rCfCnF29UhYo1u0Co3mzb/Z42LfnvaIUxx/SduaPZVjxVDGr5NNs
 X9M0s+ytzse01W2v3NPhtWIgeq34WPruzpBJfZ59lJE/lnaWYMqsE9HQHS1jshyJK0yR
 pIvmg5x4ZtB7ocAugrKqheR1lWs2AeCjNqNTMCa7zdynDVCx4uT3cO8EvJFPdJsPmBRJ
 v1wzbyNj9RJG6+MtlhqmdEdqrZrtHBQFNgv1reGzq9ujF1bb1trrYeFdP4qSuRjE3+Vj
 jwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001497; x=1714606297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0iznKbTX8oBcbpJPieQQMWlAI4HDAUpQMvJb/sM2VnA=;
 b=i75OTOAdkDKQ2Vq8o/oAtZAZCpmUtFLaunqYNWKa3XySsN/FjWKx3Ms2EIPk3Ndx2b
 7RAQqboBVXZC+SyA2ol8hoNusqW6XMmcUV/5CjLY2Rqz1WmoIuR11US1+4507gVs4hQS
 7WvKwadDbHFiWGs2N1/DPncZoecL5hKcX695BQnLTiIDQARb76GLzNTxsXexRYTbHMlT
 f/2gpGGoZh/13KXTbyqV7JVtmWZ53EYEn9v6jnCxN9GBIgbg3ODQQoHeRkdSVQNP5aPx
 odnr5ZJtNb0r7reXmjMb30x2zCQFK9pytHu+jHBjHXCAlVIBlxj86kaJBv3HAmOCN2cy
 brpA==
X-Gm-Message-State: AOJu0YyrgErurnF2I3I4BSL6CQ5v482DAvBhu7AEkkmgrYYg++CRrPOl
 +Utcfm1mEEGrTHbikq06uFJArp9SGa3TLvBsLxmM1YM0OIt8bGY79jVtXzuwlSTwCL1a6avHMKR
 Y
X-Google-Smtp-Source: AGHT+IHJwcW96T4N7rMwIeykLtr2sHl2+5giJtsgk38y5tHpn52wXkWDxpzXrpJXUJzKlWvbB9XbTw==
X-Received: by 2002:a17:90b:1d0e:b0:2a2:f284:5196 with SMTP id
 on14-20020a17090b1d0e00b002a2f2845196mr3902965pjb.45.1714001497549; 
 Wed, 24 Apr 2024 16:31:37 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/33] accel/tcg: Cap the translation block when we
 encounter mmio
Date: Wed, 24 Apr 2024 16:31:03 -0700
Message-Id: <20240424233131.988727-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Do not allow translation to proceed beyond one insn with mmio,
as we will not be caching the TranslationBlock.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index dbd54e25a2..c3f4d0e252 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -239,6 +239,8 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
 
     /* Use slow path if first page is MMIO. */
     if (unlikely(tb_page_addr0(tb) == -1)) {
+        /* We capped translation with first page MMIO in tb_gen_code. */
+        tcg_debug_assert(db->max_insns == 1);
         return false;
     }
 
@@ -287,6 +289,8 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
         if (unlikely(new_page1 == -1)) {
             tb_unlock_pages(tb);
             tb_set_page_addr0(tb, -1);
+            /* Require that this be the final insn. */
+            db->max_insns = db->num_insns;
             return false;
         }
 
-- 
2.34.1


