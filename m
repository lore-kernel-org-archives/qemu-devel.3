Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B36E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjtt-0003fp-Ti; Thu, 12 Dec 2024 09:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjtr-0003fP-1x
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:10:43 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjtp-0002fk-HC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:10:42 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso6603145e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734012639; x=1734617439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaGVoGgymsYq6sy3eZaaquvyYzqgHMU5IlSKupTJhl4=;
 b=fEI1pXOD5R4ulSOKWT2Y73StOnc6F2ANel1YiMw5kVTHEJrH+l3umkinvckI+t8v2K
 0IdevsOFCdtSeN1jpYIznaRz1FVXErog/xdwgXLrtzBovKsQVJj3YQnPxTasMitW1G7Y
 9uRrTS4kpYU5sBtLyx73/PZXZE+i0UaruS34B+vs1cMXeAOBGnsalsVbsjmPT+uW+G/O
 rlFPnSKvF3HA2x5r/kSnzLi2IREBrS74l5i2Wy5ra70iFRL24BuxmKqZT1PvGWbcRgU3
 AE64dJR7Y48mvIZ9kzXXtRC39mRojTAa4BSXMj1zebTHOInylDLD27FvUqS+3nxgvv9t
 Yxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012639; x=1734617439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MaGVoGgymsYq6sy3eZaaquvyYzqgHMU5IlSKupTJhl4=;
 b=QvHzUuq61kP8ejvNxBthMjTDvZB86Su6aR5k4sYv6YHsgfTs+r3jgNnGijPNShCje+
 51NG+ZbpInD8sv57isFWDuVQI7UmW1UvmBCRqNMT/0+HIBp9jgePE6GOlyS4uDpoSAGw
 H8vlLR3FZQcSH8xL2ZBxAwABmp0rB8kVlp6+oe5rg/VowLelzrBjtsw60lMWKMOzhdvm
 q+ShNARkcD7rNxE3r5p2xNmTViw9nbjzYpukGrDWRIuoq6KDD1YNmLRVpZpBHACAa9Ss
 8TsEhkHaMI+WgKkj3P9DHdy9z8BQQmpTHZ4xwWmwRcgATCheiZSAljtQt4/7k9a0rI2n
 bRPg==
X-Gm-Message-State: AOJu0YztQHaB4u86lWPR6SJy38bDAgIh0RhVjgoc1+dPtcSPL1/68iOG
 VEHuJCzz4C8lr2Wwa4CyGcAO//k76AKorX2iX7GfmoaRQ9PvTYazPwpSJe/cmFwJWczJesh+6ih
 c
X-Gm-Gg: ASbGnct9pag67WT+FihLQOE/P0c37xpf2MzRSOaKYVU2Berg+jymwWP4pvKHWkaR2Xy
 G+jQ/QK3BD5P8Mlx+R37K1oL86kk7UVaYC8NF8lT7IvGCgNC3HWY9yHkFTtrPJJid6zRyJ9MMV7
 RUNy5puUObnvrp2n6eL0EOqvZR59sYRt5QhglSxj3pk0GXILZ8IXgfx7tRozu2N6eubIj8Z8zDy
 /MH3Nb74qiqwpU+wXNXHI/FkeYaaBk7RUuMwzqvZQAIA8vtW8Turhn8D2umw0A1qNeNcr7tXulb
 +JOb+F/mtBdtL+aN9O2PRi5TCPLv2uI=
X-Google-Smtp-Source: AGHT+IFxPk85C+oe4412jrTkEbEoKjxrfL4NW2N5CLseX21FA72mhnu12fF8Hk/p2As7fCqHnyrJig==
X-Received: by 2002:a05:600c:3acf:b0:434:f8a0:9dd8 with SMTP id
 5b1f17b1804b1-4361c345006mr55413915e9.1.1734012639097; 
 Thu, 12 Dec 2024 06:10:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256b7c62sm17778065e9.34.2024.12.12.06.10.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 06:10:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] qemu/atomic128: Include missing 'qemu/atomic.h' header
Date: Thu, 12 Dec 2024 15:10:18 +0100
Message-ID: <20241212141018.59428-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212141018.59428-1-philmd@linaro.org>
References: <20241212141018.59428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

qatomic_cmpxchg__nocheck() is declared in "qemu/atomic.h".
Include it in order to avoid when refactoring unrelated headers:

    In file included from ../../accel/tcg/tcg-runtime-gvec.c:22:
    In file included from include/exec/helper-proto-common.h:10:
    In file included from include/qemu/atomic128.h:61:
    host/include/generic/host/atomic128-cas.h.inc:23:11: error: call to undeclared function 'qatomic_cmpxchg__nocheck'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
       23 |     r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
          |           ^
    1 error generated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/atomic128.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index 448fb644799..31e5c48d8fa 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -13,6 +13,7 @@
 #ifndef QEMU_ATOMIC128_H
 #define QEMU_ATOMIC128_H
 
+#include "qemu/atomic.h"
 #include "qemu/int128.h"
 
 /*
-- 
2.45.2


