Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F95E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBAx-0004lE-IB; Fri, 13 Dec 2024 14:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB94-00014b-Fb
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:16:16 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB8y-00083T-Ux
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:16:14 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71e1d6c7738so1121440a34.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117368; x=1734722168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5mnyXonXiy4zaF6iAQaiGzQHiUuvaz9CiX/0uI1U14=;
 b=EwFYGakBG+P52gtY4MP4YEt/AAthic1qFKZoOD2kbasKrfPtsbX+5V/U+UAr4cT3Jh
 /A2pjxFZoa1x18Stb9WEiZtGV5DOCLBHOOeBfF7qSCglVDk38vzna4ag0nEc5Zfn7QCj
 ofFuhVrukMo4/l/6qwSLBpvaaVTfJX4OaiGV/IKt9AGa65oymCN88H5eOLpevplooCu1
 cHNN8HoqA3B8DnDxUgvfVlUTrkZsC/rnISpKqdfm464nin2rdsS73aQymPDJuVoGPLRV
 c33JtyXvv4s8bIpwUZOjU6A72AdTeEDLBqr4iZUByPKo6JocQzohIAgGO/nLjysVm+Sx
 y2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117368; x=1734722168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5mnyXonXiy4zaF6iAQaiGzQHiUuvaz9CiX/0uI1U14=;
 b=Mse2UjDjBJSFd8FPo35Jkz943+uKtKmjs+t7w/C4wccyvD5+tjNDikVg8UzeD+lYUM
 pdOOD51cW60/fCq1WhabLBrnecn3FONH2B0uO87dK5Eta0whmBwspVgLKT4TNRfarvWt
 NQjIjn9XvlLZB+Eko8jaAUW/n4Pm6gvAjdGYrlvuU7EvkGFZQZrUuBzT/7defXuLj+h6
 cSB4afug8+KwWNh9Vax+cSzNUiopbWNnOgOdYZjwlFHkYRjJqifHygATIhPQ2i3iUAfd
 MjI2Q51pH0dtHa+f6zsEjRULY/sn9mNJUn+x98jN1k3rRHWnYY3IdRikUhTMj3gKrSco
 p58w==
X-Gm-Message-State: AOJu0Yz/N+sUUkx8HvUfYYei8tivbvXmN6tV0R4Jahv48ooHMeN38kq8
 VoqQcEIfk2uJyak813f1ATo2Lps1OCuIVaK33M3/Ew9DTfP2Ynz289irsUW4n6Ni/dBlGvyTQgb
 bV3GG5oRo
X-Gm-Gg: ASbGncskNx7kASK74driSsCsederVlTC37XrF7xOwRs2Uyk8kOMf9A52/M7ctXbTn7c
 6OFSSygzevZXYi9Qvqagjj72vj43gN/rU63qIrBsbcM+L9w0sf6fnkcLMxqj/GOQWEHUMy+8csa
 CzHIzD1MOpfrfT11t8+D8x4zbCJsCAxkwbuPqyWAZOSSc0qAlW7rFJsBS0cWlw5ygF9FeUsqy3/
 BSbQnT7+Tru/uJrQi/muHK7n/9NqvPv2jgoK5qUm6KCVRT70wPJiD0IZvWWMYW0
X-Google-Smtp-Source: AGHT+IEJ015TDxooW1bcwkHq7R9aa7avAnhNp6/EbYwYtTQCLhkaK7I4Y49PNsTHyeblDmwhqU7/ww==
X-Received: by 2002:a05:6870:7007:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2a3ac99010amr2092273fac.30.1734116883097; 
 Fri, 13 Dec 2024 11:08:03 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Artemev <roman.artemev@syntacore.com>, qemu-stable@nongnu.org,
 Denis Tomashev <denis.tomashev@syntacore.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG target)
Subject: [PULL 2/4] tcg/riscv: Fix StoreStore barrier generation
Date: Fri, 13 Dec 2024 13:06:34 -0600
Message-ID: <20241213190750.2513964-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

From: Roman Artemev <roman.artemev@syntacore.com>

On RISC-V to StoreStore barrier corresponds
`fence w, w` not `fence r, r`

Cc: qemu-stable@nongnu.org
Fixes: efbea94c76b ("tcg/riscv: Add slowpath load and store instructions")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Denis Tomashev <denis.tomashev@syntacore.com>
Signed-off-by: Roman Artemev <roman.artemev@syntacore.com>
Message-ID: <e2f2131e294a49e79959d4fa9ec02cf4@syntacore.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f8331e4688..96f9a7e348 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1624,7 +1624,7 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
         insn |= 0x02100000;
     }
     if (a0 & TCG_MO_ST_ST) {
-        insn |= 0x02200000;
+        insn |= 0x01100000;
     }
     tcg_out32(s, insn);
 }
-- 
2.43.0


