Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B66CF885C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 20:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swotG-0007ls-AP; Fri, 04 Oct 2024 16:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swotA-0007l0-MT
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:27:02 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swot9-0007sI-7U
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:27:00 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fad15b3eeeso30447031fa.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728073617; x=1728678417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gS6SPuWgrLj7oyIxESBEyqXFsjeDNxz6I9pqGa/5SWw=;
 b=DFoSuCZq0ns0CWg3oFPr9xAGIYzVEQXA+m5fwIMXKqwH82adt9X33lSJQIJVOHmzQE
 8WA7ObU0GCWLyqypE6fpiEexmZW1TL1zICQ7ZNpc8183DFhpb6b9iuVSM536nsxC/B5/
 yIdrVx1Bu0bijR7JJa3YvlmbKN9UhSmbfxzH6zkD+Dru2yytNaUDWjvnBQxsRGllkqQT
 b20sr4jt5kmiF/cx8DSVS5yC0gLmHVlQ6xHAN3N2JkvEt2Do4wJLS3DCXQqXJSvNK12V
 V1XZbgKlnpr85WbSlSa/AGjVReYoA4HbUrWl2l+gkCQawSVP5+lYr5AY2G7zSQBPqFnJ
 WmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728073617; x=1728678417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gS6SPuWgrLj7oyIxESBEyqXFsjeDNxz6I9pqGa/5SWw=;
 b=qUBAkFPTXoWBg1Hiho6ZMIJXttts5PSw4tETZyqqpe2n8d+YgnzrWJswR6Lta7WRPR
 /KT5I8ZTZDj9XqDKuBv7CWmrRqNIYL3GvIUBhbuBfUBvOmdEpAypQonhcTHpAiaFY8WV
 lily8fKLDzBwXf820PhAjTNKL7x1R00++aCtdbvvyzpk9caTFqHSkQ9K9+Q6tw0IIRy6
 kcmRmfjftPZFYIaoLGu8SHqXN/hgVHrXsBQeP6ps25tYpGikTGAbaA2SW6SL52b7E/5I
 6BXB3NfbhwUxxVdKZ6Tl4hgOeHLd4wJwf20j6k395ScA1m/INyddke6oDGcIqMozx4mK
 yIcg==
X-Gm-Message-State: AOJu0YxaqurFfUXb4mNE9Q21F37dT050DlLl8+dJaU2uha6is9mITIeK
 RrAb2GMhbEl12kX7a4bzXbpu2djI+F9NTradFRofI3ayyyYtOkcxQAkStSjuVayXHyI7c34Inz2
 yLHweCw==
X-Google-Smtp-Source: AGHT+IGuXzpPSeaeIsOXQuK44wcQBDI9B0vzoELUhRCBpVKUpQ80KDCeUPVnvHdF24sfSiFX0WMJEQ==
X-Received: by 2002:a2e:e11:0:b0:2f9:c337:aca9 with SMTP id
 38308e7fff4ca-2faf3d8e286mr17458741fa.44.1728073616823; 
 Fri, 04 Oct 2024 13:26:56 -0700 (PDT)
Received: from localhost.localdomain ([91.209.212.135])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9adcc90sm629791fa.70.2024.10.04.13.26.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 13:26:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/tricore: Use tcg_constant_tl() instead of
 tcg_gen_movi_tl()
Date: Fri,  4 Oct 2024 17:26:20 -0300
Message-ID: <20241004202621.4321-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004202621.4321-1-philmd@linaro.org>
References: <20241004202621.4321-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Directly use tcg_constant_tl() for constant integer,
this save a call to tcg_gen_movi_tl().

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index a46a03e1fd8..4a12d2ca191 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -2732,8 +2732,7 @@ static inline void gen_insert(TCGv ret, TCGv r1, TCGv r2, TCGv width, TCGv pos)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
 
-    tcg_gen_movi_tl(mask, 1);
-    tcg_gen_shl_tl(mask, mask, width);
+    tcg_gen_shl_tl(mask, tcg_constant_tl(1), width);
     tcg_gen_subi_tl(mask, mask, 1);
     tcg_gen_shl_tl(mask, mask, pos);
 
-- 
2.45.2


