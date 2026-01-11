Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B7FD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 07:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vepc4-00064x-7I; Sun, 11 Jan 2026 02:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vepc2-00060x-QA
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 02:11:46 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vepc1-0000MA-4U
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 02:11:46 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-81f4ba336b4so367843b3a.1
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 23:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768115503; x=1768720303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UFFBcTCfMaU4vQX0sO3sPB0bXVQeaJ0Mkpe/eadYyoc=;
 b=NyHEERRYJ5uokf3FtjVaf/zaK0ANpkQ98ABqcon2Nyok/ZJUqowGWnLdGKHCB8lvzC
 K7vY4l0NBlGzHcDhPdMd+UByI8wehZfSCka1rssG6lRQ52Ykf9vPjTMT94V1OZa524sT
 nSmdVU6t8UN7FLU+GFWpkPAmWHFPptwUdxKGM2Cyxyi3OLyxnwmXEJgA+bIDDSIVMXVI
 1Lyhyu/3Y8gwxmDVpjBbVpD8gJpnV9G2701Pfecy90F/bzOXMEPmg1NCmmXQYoLZbOFt
 xVfQ4u4XXtn0uBFr1wvg2hi+Djg94bHv3k/+3gFKhNjfNwFpa36KKR178NsOFvEDUk2t
 Sr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768115503; x=1768720303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFFBcTCfMaU4vQX0sO3sPB0bXVQeaJ0Mkpe/eadYyoc=;
 b=CfuUVMTxnwegiHL9/6WcALajIeojtbH4ipbj7Ka2a7+vndCiVOx1vLhSNDznaUBcsr
 JRPZoN76dHJ/VZ191G7MGCUUqbxN9mWCHA+dhgaJi/z0NcDuDUxVAIkqY8zSQmJ1N+wz
 vI0PwInFj4YxE0xbB+cJNDaP46LYEHOCBzSEUuLojaUuEh35SZ4QI3UizGIlGiJUNsjC
 CE2JOdNH1T0W8O9Tg5InYnpmsIKkJ9Qm/ZtuRBJcH2NJAagiTgw/IcxdNasxkkECOuf2
 HPv9liBhfagVFGWe1PgHDNgfr/pa2bvvV0hIHQ/soY2xkAE4qmgLzT0wzqceNpXexcde
 /Y7g==
X-Gm-Message-State: AOJu0Yy3ojWz27veuCK04xlgkaRrtNeODcPnwY6M8CrODZOyQfNQ3P3m
 cjFmxktILqx8DW0viR6h5MjiILvicqOEd0pzM6ulCuVV0yMugsgedbCEUvSfoBtXeeSHte1RMBZ
 y+95uOfI=
X-Gm-Gg: AY/fxX4k/cIxRbYcDXU8CHtuwG4+IwIA918xJg9USj+LeZepOvAQ9lMIR8Ct4zNJZdV
 TRj9e05h5YOhDOvNLS3vs9DijHyD3oqs3ot/qL6vK/0DVvhJko6NyvVnlTma2NHY6puRoPlKXwW
 APLat8AsUuwY+sBx36LluDQUXTVA7WMEmp9P6rqshnsvHdOyvsD2faU4mOAYuRSPArJHZnmH7l4
 wqIb3TGM8fUSUklQPeXVPfW8G9BX5dWAjB82d4ar2DQN1sI8ks4BROX0obmwMpU2YgGbfEJ/SCy
 9pfZLkY5SB8vCVQ5MGcTFwIdmzhnP/cKoBrovImZxnK6L8QfSXEU4pZDbSP3211RguhDgvNvD3+
 Nuh/aWfBTtdQjHl9PcUmbvf8Ubbg6rIkHzZ+jwDArTQ+U1uYnWI24FBCvpqsKVk05Wc/FcyqXA+
 kI8RZpKB6REBBosJ0=
X-Google-Smtp-Source: AGHT+IGsEWrxIlTwgu6KliuFZaZh+Hq2PzU9pP56BE7pGiI/0H4m6jLlmIVPRroQoz3UEp/350lhng==
X-Received: by 2002:a05:6a00:8d8c:b0:81b:14e1:a17b with SMTP id
 d2e1a72fcca58-81b801ce30fmr13384470b3a.70.1768115503013; 
 Sat, 10 Jan 2026 23:11:43 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f4433488esm2625797b3a.2.2026.01.10.23.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 23:11:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH] tcg/optimize: Fix a_mask computation for orc
Date: Sun, 11 Jan 2026 18:11:36 +1100
Message-ID: <20260111071137.433005-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

In computing a_mask, for or, we remove the bits from t1->o_mask
which are known to be zero.  For orc, the bits known to be zero
are the inverse of those known to be one.

Cc: qemu-stable@nongnu.org
Fixes: cc4033ee47c ("tcg/optimize: Build and use zero, one and affected bits in fold_orc")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 23278799af..5ae26e4a10 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2360,7 +2360,7 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
     s_mask = t1->s_mask & t2->s_mask;
 
     /* Affected bits are those not known one, masked by those known one. */
-    a_mask = ~t1->o_mask & t2->o_mask;
+    a_mask = ~t1->o_mask & ~t2->o_mask;
 
     return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
-- 
2.43.0


