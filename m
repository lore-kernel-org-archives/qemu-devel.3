Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047DFC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl6k-0004j7-Tf; Mon, 11 Mar 2024 15:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4w-0003OP-OF
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4u-0000NG-30
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41332865abfso401455e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184369; x=1710789169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xdS6BQ4zGUSaBLNVAflAeEIqw3hx2MqgTFA3HutXwAc=;
 b=Bk9RdLGqNjvuwE5QOLlO7CTtzqxxhcBDPVnFcjRR8UnwOPKOkiv2nehlyIZTuenP6N
 XSJ2Lf8zhJztfk/C1lzQjRL7Zqmumqm1Cn/0WFBxa5ShExlMQ9uTP240jGDFC5aoqlIG
 6Sad2Uhbdkk/MAh0KE4zVgxbekCc5ulG8LkZRpSFK/2RpcvIvhbZWuwkRh4MZyaFJhA0
 LGuYRWW+YOUOIc0HfJO4xega5IJAHYOemwXzNPhcgiNGQFLfzuOKfVjwg60AfnL9SSdG
 Vq6+0f4JiBPbtvjdmYA7oN2h4jkyXYg3Fou+KRoYPMSnhX3YL0HEKhCK3IuM5ox0Uu5k
 iFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184369; x=1710789169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdS6BQ4zGUSaBLNVAflAeEIqw3hx2MqgTFA3HutXwAc=;
 b=deYfCLABo+acZTRUWKXRxFoGHEEO+ImCHMfquhEzSmPOQQo3mp56WZwW1b+i/izNbh
 6wYCnNLsL4/gMucyNvIzTz34kpj39sv5f/AiMdItw22bQCfGNfNzeZK9LDTG6FiYJzo5
 6x6y6h0PGwOARoL+J+7ITq+SCPoj878/0YKazi3R0Yc/ANM/Kxefo6MZ2mKXspfDPZPb
 Tyh2RndcXZqv8iaCqkpHOYvURaZB5YM1zt4lUum/L5QvBS4wQG7igmPX2p0wPYP4Ki0R
 BSFjxU9b6Uo+TS3Taou08gBs6LWo/VjWmylHjhaKcFS6DHxYVgkjZZM26uQV04JvAUoB
 kSdw==
X-Gm-Message-State: AOJu0Yys7jufSwSh2cSSDQ3bf6VzkfNpVqDsCClCstTYf2NxMVXFSZB5
 +Tutq2ASsobmEeAW8m9pt1k2J9w/Jnt7vRAE5JWHBlnokDh6ke1Qr2l4xIGtIKT4oQhP9Bp5omU
 n
X-Google-Smtp-Source: AGHT+IFFvljOoWhYMP0CxJNPCnuKR/OIhkiTi+3u0QXWnuOCdXDqqlCCPkk35Im9522eTwd+FYyXMg==
X-Received: by 2002:a05:600c:1990:b0:413:21ea:968e with SMTP id
 t16-20020a05600c199000b0041321ea968emr5900386wmq.41.1710184369667; 
 Mon, 11 Mar 2024 12:12:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] contrib/elf2dmp: Use rol64() to decode
Date: Mon, 11 Mar 2024 19:12:36 +0000
Message-Id: <20240311191241.4177990-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

rol64() is roubust against too large shift values and fixes UBSan
warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240307-elf2dmp-v4-14-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 32dc8bac6a3..d046a72ae67 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 
 #include "err.h"
 #include "addrspace.h"
@@ -47,11 +48,6 @@ static const uint64_t SharedUserData = 0xfffff78000000000;
     s ? printf(#s" = 0x%016"PRIx64"\n", s) :\
     eprintf("Failed to resolve "#s"\n"), s)
 
-static uint64_t rol(uint64_t x, uint64_t y)
-{
-    return (x << y) | (x >> (64 - y));
-}
-
 /*
  * Decoding algorithm can be found in Volatility project
  */
@@ -64,7 +60,7 @@ static void kdbg_decode(uint64_t *dst, uint64_t *src, size_t size,
         uint64_t block;
 
         block = src[i];
-        block = rol(block ^ kwn, (uint8_t)kwn);
+        block = rol64(block ^ kwn, kwn);
         block = __builtin_bswap64(block ^ kdbe) ^ kwa;
         dst[i] = block;
     }
-- 
2.34.1


