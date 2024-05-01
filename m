Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54238C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6F-0002qh-K5; Wed, 01 May 2024 10:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5g-0002el-7J
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5d-00026o-Oq
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso60800885ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574264; x=1715179064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luXE4K25FW6HOCJ1kHOE0xkHZzSsFeoNOQtESvbBF/8=;
 b=cK9RlXqZlJ/cxNAF1uxSjKcLYeTlh8rVuLVg6xRE2MAg1l0pV0efStmVlC6kTjKxsF
 4dbxbi38ipibRY8/dYzndLiGWoFlZj/w74loJVROhdk/T2zyAJbWu2I1zFlZQfDlNlCn
 HK2kj9lPmIamH/nvPgJ5jWJ3mKNROliFPvdbfCRaWw/txBirUDzVji8Qt3AtRZamu0rT
 p5K7rwgl9PnPnMCiPFNfozXDqpQRbsshcqTkefmnge110Zy1KnFYZcYEWJFLZudSezki
 7y6OY2H4Q4IfaLp87/oUlQNyHsC8YBw24QaUIXpZa01C5Vzcw1qowwQDftOc4hE1LEUV
 OHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574264; x=1715179064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=luXE4K25FW6HOCJ1kHOE0xkHZzSsFeoNOQtESvbBF/8=;
 b=oCGfN1UrFQR29aaeJlhCn1tl+ncRVqPxScOWG+DSQozU46KQurZYp7XQ7BNE/z5WpE
 DEOJsp0/ktumD89BHirqSX5EJtoB82p9Z4mEhd3EMlw5CwXDHvZYyOm3oOsqTpNPzrM6
 HkMw1kgnZNuh1rvIuohSys0LpqaqtZHg9BWit5nd5CAudZQn+di2akQ0PiJJJmprY9CZ
 /rOE5d5wm3mr92ELVndXIYtwiZZosTKP/BPfgDIzDOEtBLzmZ5DOfONTSTJ0Wv4DDLNP
 VwICOJhEB80yU4v//HxBow/bhvpKMYumHDjW/enuRoHA58aMHJbuFLgC1/43g4YON26H
 giyw==
X-Gm-Message-State: AOJu0Yz+izIS3bIAct97bNE44xd7VSJp22nmKaX1621zF+yjlTmjqQmQ
 nQCx7V6UEqk9TYCUYY5ilfcKNPBot+0JwanZIV3nYKIqMmicNcO3R3a+GbXpvvbkMoB7eQn5myz
 C
X-Google-Smtp-Source: AGHT+IGWl8nSjQVZSMAEUmVtCLpOn77iheK9Kbd7T8LX1T5iCtCmyyZp9ASIZ+ygMdUf7p3byq1QVg==
X-Received: by 2002:a17:903:40c9:b0:1e7:d482:9d96 with SMTP id
 t9-20020a17090340c900b001e7d4829d96mr3120107pld.10.1714574264387; 
 Wed, 01 May 2024 07:37:44 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/20] plugins: Zero new qemu_plugin_dyn_cb entries
Date: Wed,  1 May 2024 07:37:22 -0700
Message-Id: <20240501143739.10541-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/core.c b/plugins/core.c
index 11ca20e626..4487cb7c48 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -307,7 +307,7 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
     GArray *cbs = *arr;
 
     if (!cbs) {
-        cbs = g_array_sized_new(false, false,
+        cbs = g_array_sized_new(false, true,
                                 sizeof(struct qemu_plugin_dyn_cb), 1);
         *arr = cbs;
     }
-- 
2.34.1


