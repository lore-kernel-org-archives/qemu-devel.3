Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2660C001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA2g-00040F-OY; Wed, 17 Apr 2024 14:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2Z-0003pe-AF
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:53 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2V-0003iu-KO
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:49 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-570423c4f80so36972a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378585; x=1713983385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHZqwbv+wjH/HmWZ9HfsbsxWvnOGugUAYDu3jydEASY=;
 b=UWShZDhtgBhQH/+qCwmmIrsBli8sr8QxxH+AEfAMXYABQRgb3F32P4NcgSb/vPOJjP
 So83dk2p0P1LUQUvlirJ0dGJbzQORxC4bcpHBhCrbdqLL62J1m/XIl4I1rtEdaPk6T9A
 Ln8/6E1KfKoVaXXesz5UtSlhwflHe8Heu8oYzN3W73BkdkyQm80MUpWj95r/hP/UBerx
 zLcSJrbncanMtPJsJPQUSTNkgl72X5fuc+/t7jrv5tRkTOjxW45/KsSUeQS5SWprmzcs
 xLW/qqL4Aeo5JhwpLSnVtdI7Pul/GIGb51zbK2Wc6m+KDjKpa3v2HAi51t9newIfKtS4
 ArSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378585; x=1713983385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHZqwbv+wjH/HmWZ9HfsbsxWvnOGugUAYDu3jydEASY=;
 b=ZHbwM+OkUTdhiZ3ngJGKcIxW4gnvMpdH+F/3PgJ+Q5tEvvXEsy+uCcUBD86Md0J2xn
 UMsjdazs/leeBJfN5tciV5h2MJpxfmqintW2d2isvkifN2LZKZV9awSXeDp+YEkCOXbD
 +6fY/Ryca7SFTkLWuS8fusQW+WzyAV3IGjan9K3HkO4r4gLlGdpEYxQYx1ZuMeUgvkch
 YGiQ260Ba+s13ZucDpWHlX5ZF1psSlufz1pZeRgMWE77PuX/3/XEPsoCy9ov2wI2Nbjk
 pEyVGVmKpSu4DOoMNiwfYDg3ulJ7h0toFs4m/CajdQn3BIIEQEujz8U5o5CrYDqQ77mp
 SPJA==
X-Gm-Message-State: AOJu0Yzb1sQ0dvkjqVvSEjnG326Iy8eSEj+3P7ahFM8c/95PLezCTVI5
 BNdEXjZTRlUNE6OfLA+2bcA+KxRTNRfWMSEiL4OHcLNwn+UknUan/bN79kiWMN5r9cqLSf6AmfB
 G
X-Google-Smtp-Source: AGHT+IHt210+SU5PvtLJuGRrjHHbWPU1NbMi+AZRdW04Mb9m8nhAqkIg80h3jRtnIsEedIoQlIUdyg==
X-Received: by 2002:a17:906:2a89:b0:a52:671a:aaf2 with SMTP id
 l9-20020a1709062a8900b00a52671aaaf2mr179854eje.72.1713378585444; 
 Wed, 17 Apr 2024 11:29:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 rh4-20020a17090720e400b00a5255afc856sm5615193ejb.84.2024.04.17.11.29.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 17/21] exec/cpu-all: Remove unused tswapls() definitions
Date: Wed, 17 Apr 2024 20:28:02 +0200
Message-ID: <20240417182806.69446-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Last use of tswapls() was removed 2 years ago in commit
aee14c77f4 ("linux-user: Rewrite do_getdents, do_getdents64").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20231212123401.37493-15-philmd@linaro.org>
---
 include/exec/cpu-all.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 4de0d5a0d7..7c44ffb3af 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -38,11 +38,9 @@
 
 #if TARGET_LONG_SIZE == 4
 #define tswapl(s) tswap32(s)
-#define tswapls(s) tswap32s((uint32_t *)(s))
 #define bswaptls(s) bswap32s(s)
 #else
 #define tswapl(s) tswap64(s)
-#define tswapls(s) tswap64s((uint64_t *)(s))
 #define bswaptls(s) bswap64s(s)
 #endif
 
-- 
2.41.0


