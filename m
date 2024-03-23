Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ECAC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 17:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro5C7-0002l9-3a; Sat, 23 Mar 2024 13:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5C4-0002kU-IR
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:08 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5C2-00065f-RX
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:08 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e0b213efa3so628515ad.0
 for <qemu-devel@nongnu.org>; Sat, 23 Mar 2024 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711215005; x=1711819805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RF8MIQWUQ8ggE/MlTolxsgSJT5vy8jgQgVDGU2A+dUw=;
 b=qO0SLNpjo2ernSZmuk9kzJeQwnm9pqZde5znaOZpLHKzGXeK8z6ffCKtRl8y8wUb5z
 JNSc6e3ivhcvrcSMOup+/2trKi03n7MZMUSsPkGgnqTQ0NTew8GoMxWRna0568HTVcJ/
 6HY1czKEuCjPqgqoZLSui6gCEtFyqX72qOCKYXuaQt/rbNf9UGjS/Br4vfjCF3hbK305
 IT7GQYRASh50OtuD+sVZTUMmzYSuFG4DeL1BvhsBUAq15L2CRSJ6/RjmN/sgqHr7+n0s
 9opb5dxZ/CuvYmGZOlZK4wEPjPGRsYwP4P+OqliG6z818eP07d6mlUSrUyqdBdOf1lCe
 ngNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711215005; x=1711819805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RF8MIQWUQ8ggE/MlTolxsgSJT5vy8jgQgVDGU2A+dUw=;
 b=ml4DMcic0Xr2NV8xCyWvTR9KXLEPQILXka1t1hG6sONC1GMjIOdVcXwLaniLbdAT/0
 kbT1FC87il9o4/QJD6+5fElqi1Zcj7lJpdNalrRPGVhlQ0zaAAC/wAsFyfKvUXghyH0Q
 EsfmStSPQKd/QpGiFHsxyHJRLPfZXS0V9HlLLGk2ZoqCWBvlf6GSuubdr25hwCfT7z7c
 Gh+jB++Old8fj0hWOMEiC7yglJjFywwfM4KaVR5NqdnjmUVtU875xTSz6ll+srD4bg++
 6g2oQ+EzPU8A/GlrzDu7klvzfkGcTyZqE79GBkMm+iF3WxpkUsCie6pXR7I/iz8rcY/I
 UaRQ==
X-Gm-Message-State: AOJu0YxijKo3qignh++dk20hlC42FkC+c9mBQfxqxf5WtQcBR7WB8R7M
 LCliYF9kNYnbt8HzXO+LkEkfMDZSYK9q/eG5dd+RJSOIc4zOarCxs5R0dKh+YBMIu3DmTIx8YTg
 l
X-Google-Smtp-Source: AGHT+IGfjxIo8Hl1YsHZ+qQ22LcH6XsCHK8+eLrREr8y4AdToXKj/lANl45kTDBeJv6bIqpYVmNwAA==
X-Received: by 2002:a17:903:442:b0:1e0:319a:2677 with SMTP id
 iw2-20020a170903044200b001e0319a2677mr2720704plb.8.1711215005543; 
 Sat, 23 Mar 2024 10:30:05 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm1811758plc.104.2024.03.23.10.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Mar 2024 10:30:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH v2 5/7] target/hppa: Mark interval timer write as io
Date: Sat, 23 Mar 2024 07:29:52 -1000
Message-Id: <20240323172954.1041480-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240323172954.1041480-1-richard.henderson@linaro.org>
References: <20240323172954.1041480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 target/hppa/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ceb739c54a..8c1a564c5d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2162,6 +2162,9 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 
     switch (ctl) {
     case CR_IT:
+        if (translator_io_start(&ctx->base)) {
+            ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+        }
         gen_helper_write_interval_timer(tcg_env, reg);
         break;
     case CR_EIRR:
-- 
2.34.1


