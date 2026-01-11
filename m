Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ADBD25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 21:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3SG-0005Jc-6R; Sun, 11 Jan 2026 16:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SD-0005J9-RJ
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:33 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SC-0003qI-DR
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:33 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so38068175ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168711; x=1768773511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gUDBYmRE/wZQT2imf8AjVvWO7YLx14zwpMuc1zAE/Y=;
 b=xrYSRUmo/+YsERzrQ1cu9F7d/RUOUYxrMjYgYxxqkL3/BykfFS4oqz1ZlFrJEzH5YV
 +/C/eUAfMQhJzDLZulyTw8PIaqYXbyBx6Yj02VMFFCohTl7kXlcbfl/ciO7eI0Goau86
 tRsSWgpJvjqJeDf5rJwxHfP+wXro1PyxJuP4x43ALy12gmP7P232PkLkwH5DTU2y4rGa
 nvXl420IPRgmpssUQOOVNbOXVOG4yKcar4qm9UUfSjjUrW+aDvGyBUtFqYzU2IfV4d6h
 nG9P7AQY9opsLrSM4Y3R2uh02eV7AExqZmdhMw2Hf+GoifvjoifMYDcNjljNjXaMgSem
 LxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168711; x=1768773511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9gUDBYmRE/wZQT2imf8AjVvWO7YLx14zwpMuc1zAE/Y=;
 b=YD3LcFMdfqU9om8i0zcS003DYkKbLyCDNy6dQJBL0ltNIy8a0DsAi41Lyv7HuCXtRJ
 +vxawb18WZPEkWgdyNuFGyaFUt1GPQu1ScjLil/kN2Lz2UehQ2sf1K+vCwVwr2Om01hY
 XZE34tMxyUQFZs2HFeUY18494k/Bt3yNfziHEEym7n95E+ihtqZJRKQ6TqNC8EM5J9W8
 Kh6txbG/GmGHeHfsZbDx82YrM1nTUmBpMfu6fJDIr3aOgo/Qgg4NFtl85ItgAra5r75j
 iKk6ECWZiGQqLSXzGkS3le3eh/Ba35OztPnr21OW1wOc6EnKQaHV1CF14aQfTsuiIXv6
 Y1Wg==
X-Gm-Message-State: AOJu0Yw4gQpFFtF0le+Avue/991eycaF7ft6QQmoYn2hnC5Ms/YwSJ2C
 DT9s65nlPLAnHuJkjvXkg4BiktT5dqjjAkZUc8au/X5m0L1Jw6S3xeulegaAxb1QQqFPXO7hhOD
 Jg1hE1Q0=
X-Gm-Gg: AY/fxX5fViWOj2K3JT1VBytGEAqt+QwkRDuH18D1iKd8zzxX97P4zMfs1Rs/paUgWZw
 QxhOkf7i0gt0fcrHl37dyxRwjQi/XmDL2PpRa0SLsn2vv/JZfYJupOxpd7lYWYveiuvqOPbixe8
 XbCehLjDmhQy90v6RBl7lSCLc3cm1GMfglTqInjuF4hAeahxHLYGeLcYoqC41w6NcvcUAla3TFV
 0GeAaSm0NngQv3quKQJjqix6Nfw6ytzDbl7JhnOVGdb+iXMKhgajpDkbMUadVgU0HJLYZjUA1tY
 hd0ZQY5daVGmLI3G6FCbSBtdLh9tcS/3cOV6pqOTuV5T2l+TRw/l7YkiCyKMC55gYvrQLAEbou4
 8n6pb9Inh4MmvBD6gh4AmvjdJ8oUadKflEHcV6ZTyPoHA1VeBd2rf4OiVm6ehmZXXmNR8B8DgRk
 DBodoLQwrdlPetc01lmydgCRIiLg==
X-Google-Smtp-Source: AGHT+IHLDMhxQDmQ+XzLFTY2UjuwupVE3Gda+hgkYCBj8l8pzWsEKB19JNoO2GvACRJ2+hBTmteUDQ==
X-Received: by 2002:a17:902:ef50:b0:2a0:b7d3:1bf4 with SMTP id
 d9443c01a7336-2a3ee438a24mr179061745ad.5.1768168710930; 
 Sun, 11 Jan 2026 13:58:30 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/13] tcg/optimize: Fix a_mask computation for orc
Date: Mon, 12 Jan 2026 08:58:07 +1100
Message-ID: <20260111215819.569209-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1f95da487b..db1d89396b 100644
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


