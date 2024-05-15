Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3446AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rr-0004HO-30; Wed, 15 May 2024 03:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rl-0004Bk-T3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rh-0001cM-Qk
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41fd5dc0480so40696285e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759584; x=1716364384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIimXBciSNwwzH7l+M6cptiwOdaQNdn1djFTj7g5Tr8=;
 b=i7l63MY8knV0mvfj7TkMh8nap6zU1+rYqVQJgXH14P2VxwG9OI/6fCLoighK/nEC5P
 3J8rlxhK70Q8f6p7l/zbsg/cQ4QfK85B666vkMDwvebcgKLGXZdHrrEe09SRQHuDXOOt
 9iS5aQLLOxHJPBts38O1avdSUo7gBwBkSnWLWHO+va62hxZbK4yYM3fwlG1xPSUj2X8r
 +1kFQ4l5odYVdazROcducMrotEUowK4LquJEgWCKXFEmubX0eD2EZAnfO7mpZtUVhiHh
 SDGuGmwfBJ4uKdIhe5HgrNIeDxUEQNUcLZzZzz9BG1krCXnpYuRkSwfW9KjYHR80Nk5v
 sXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759584; x=1716364384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JIimXBciSNwwzH7l+M6cptiwOdaQNdn1djFTj7g5Tr8=;
 b=fapwd0yeAQJ+cUR/ac6xTW8616jB0rzp+0b6TelMt12OslA5P2LkvkfgqFZnfeV+Mt
 pinmomA61jK6kvDj+cNcNTpPoZSWz8PEyyBm0yqm9YeT6dOVDIwkVr9Gifz6qwyB6Zqe
 kwawq0CcD+zrr+U+GJfZj3aKnGG/NW6Pv6zsmgtY9sfSFkg5jl2y2jY4gq1cNkg6ykW4
 wEJn8csF8wqYsFFgwqsUANWQwARXXjD/hp6pPUwwGWAqkiGoqe4VtuTYBNfXEIIafVEn
 imxNrrtBRm8ODltWJUaBYNRTp4lk5dcpe3DiR4BOneIhGybkCXTg9BA9yWVC9OdP0GQf
 ye2w==
X-Gm-Message-State: AOJu0YyDkSd4H4xyBKbmYzeZyFt/RNLFUjbSD/5/nmAYd6+Tb/yCT/hj
 VVRNVRAgoTVL6cpJoZxh2+dMT+aSP4vgCU9tPvuB7mGHWt11a9RIbYzOl9q0/QlMpDnISxYg/py
 z+yg=
X-Google-Smtp-Source: AGHT+IELfxbKtSpQASuFe4lO1A0rLcvtcLuyLwXMKL7FHymyr8QPzLj/dlGGt2whZfWTruVHP7KWdw==
X-Received: by 2002:a05:600c:4f42:b0:41b:a670:a9f1 with SMTP id
 5b1f17b1804b1-41feaa2f409mr95686345e9.7.1715759584328; 
 Wed, 15 May 2024 00:53:04 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/34] target/hexagon: Use translator_ldl in pkt_crosses_page
Date: Wed, 15 May 2024 09:52:36 +0200
Message-Id: <20240515075247.68024-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 61302d4f46..4b1bee3c6d 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -25,7 +25,6 @@
 #include "exec/translation-block.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
-#include "exec/cpu_ldst.h"
 #include "internal.h"
 #include "attribs.h"
 #include "insn.h"
@@ -1023,7 +1022,7 @@ static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
     int nwords;
 
     for (nwords = 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++) {
-        uint32_t word = cpu_ldl_code(env,
+        uint32_t word = translator_ldl(env, &ctx->base,
                             ctx->base.pc_next + nwords * sizeof(uint32_t));
         found_end = is_packet_end(word);
     }
-- 
2.34.1


