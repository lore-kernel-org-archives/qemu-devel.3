Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D96CF9C6C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHp-00027h-Is; Sun, 22 Sep 2024 08:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHE-0000uv-A0
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:27 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHB-0002Mh-O0
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:19 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so385212566b.0
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006476; x=1727611276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tN0OHUrqQbUaQCGulY54+8M9t2g2sAjn/2PDGh46k0c=;
 b=mf12EP4ZMWiB8OTaS6Zp8eSqEgw+5cl22ll95th01aUo/10Ei//cvNYJtIci4W6Ahi
 XjciAERfJsuViTH0OgL88CYZvdpt+6UMBDPkJCBiFwbABib+NnapLSQ6UAKkBjtGrE7S
 Qqwx++W7HA3XzPzuLluDJRB7r60jvx4sAdAgKK0xsOyaelsBulqM+0czaPR5G323W3xK
 b+r0T/M7zmVfPvQ2XeqITj8ni7uUElsXkzA3BLJJqsnMm3b0+bUHdMXqlUUZpA8JMxRo
 X/fZxwH1g7r5799bsUI5JYGi8s8MPshd2B+BekhUU8sW2/UMYhRrtH+qhPTEcdWwIj+X
 ZVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006476; x=1727611276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tN0OHUrqQbUaQCGulY54+8M9t2g2sAjn/2PDGh46k0c=;
 b=Na+Wlf9IYydMetG+FtYKUogZexDLFkqyIupOSxkgHm61FCuk9xaRCdg71zjzenJj51
 WOiFGsNJbMo1sZbKHXOUKm9dXXDvo1wt3W6CoetDro2mMsA7M5wofvhcAn3BRMWGChWF
 RWOvgu2MYdokLNC4XkseOkhHO9vDluX26LoOusdpNDNgmxOF9uDqACjvjQGjXOrEzkcJ
 U79Dfm+liDXHLRY5ygg/AAF3OgsROQwuq3Wewnc0M7mpxVW+/lCb29JvqUhK1mLTU6AL
 b2JgGfDUyFt+0IS0poKwI4va3ZYDaDNsy7HTlHSKUt2qm6/KXTIaspxYHXJlr4EmnRKD
 Ssmg==
X-Gm-Message-State: AOJu0YwAp5x6C+bxCnbMWzHPcfzBTu2sMzAMhXzoEUpOiNDwXsHJ9Oiu
 mYNcBZXcEWfaquPvX6pl11sAus653pPQK4hHavmoDxM6HuT3v8i4CjU+p2iWmxWlRxKhCOE8Tjk
 rPz0=
X-Google-Smtp-Source: AGHT+IGHgQ9jvZVBF+10ELyJfLqZHh1WnHYjBc6CNy2I+eCS41NZaDiQG6GFn5rVQ3xEhWJaLhYUqQ==
X-Received: by 2002:a17:906:6a07:b0:a90:c411:24e6 with SMTP id
 a640c23a62f3a-a90d5160783mr762794266b.61.1727006476100; 
 Sun, 22 Sep 2024 05:01:16 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/31] tcg: Export vec_gen_6
Date: Sun, 22 Sep 2024 14:00:45 +0200
Message-ID: <20240922120112.5067-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
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

Add declaration to tcg-internal.h, making it available for
use from tcg backend vector expanders.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 2 ++
 tcg/tcg-op-vec.c   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index d18f49f5d3..8099248076 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -102,5 +102,7 @@ TCGOp *tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
 void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
+void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
+               TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 84af210bc0..d4bb4aee74 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -172,8 +172,8 @@ void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
     op->args[3] = c;
 }
 
-static void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
-                      TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
+void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
+               TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
 {
     TCGOp *op = tcg_emit_op(opc, 6);
     TCGOP_VECL(op) = type - TCG_TYPE_V64;
-- 
2.43.0


