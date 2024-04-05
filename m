Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629C8C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglP-00068Z-B3; Fri, 05 Apr 2024 06:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglL-000669-4Q
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:35 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglJ-0004ng-Jn
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:34 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c5d940525fso985381b6e.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312732; x=1712917532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQu8+R8TpKFXj2TBf9M0KEgMGt+uMfxKhhpkx/uTdnQ=;
 b=BOxQRMn7kJDyJLP6p4RTyKXT05Weoc9MAJl7fvAHYAc+DJ8N7d5bLS1O8n5fEwzPJK
 YNGnu1WsMN6a6jVce7KgISYf8avMCg2Jxk9fmSkiO7VpUsmegV9bN4HgjHUsTJntsVTf
 LjhqCnjdWHz4ZElaXruRgak6RNfoWnDIqWraZqGz7DwoWnXcSY2Ixg/7AuwwKwErF/e+
 Yp2neAKtYcAIXkEjl6BwgwSWk9Mz7ttf/qmi91aCW9Yy/y5rvP2o3ZuInW/Yx/w/RAJL
 3i3K71gMPBvF6ukzIgtS9zW5JJ9daoGlGi+Xt7szb7AARUG9wraqlgT9pFn8gY2ECkBq
 BQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312732; x=1712917532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQu8+R8TpKFXj2TBf9M0KEgMGt+uMfxKhhpkx/uTdnQ=;
 b=sDcLUzdn6+Y5xyPdeY1P8581AjLQf2wzP93Lzt8PQJ0FVl8TmnrkRvR7Pm37nQ17a1
 oqV9U6xg1dgmzxo53SvLypeMLqgv2HLmAgZnvK0Ym7KIrBP3gJ0ZBP0D9QFNP/P5SDYS
 X2kY7JmSw6o1IsBMeF/z1ciqgyVeb2/Yk6r84LRSehn1ro0FE4GR9EprBUlscsxb1RvI
 /aZUVN11naec0y7DzRt8HoNqfk/kY5vcilYqXwxLopHfXhjqW1/AFKdH6o0G+BgIjrBT
 yrq596Ip1hMXnckn7BrawTaMFUWH0yfnCGsFkc6iMpSHeJzQVaze5iUnpq48RpSIfCn8
 4wbw==
X-Gm-Message-State: AOJu0YwkxCmQyT8IsAbTCmIdNRUpNIR0eoTRlGfMOuf22abapG7wnqnY
 7C5/MQQie4nDKrZcFvPnsI3wwlnqyDz8m22DytD1RljDn2oPoiWkA2dQ3OupKKPhVycHlQz9RXw
 y
X-Google-Smtp-Source: AGHT+IEJEKjqSPiv8ZYWN/3rjpng/FXqKaTIpr0+xGY70pucdEf3UP7eVUrroCv30R6i2joJD7QyOQ==
X-Received: by 2002:a05:6870:6122:b0:22e:b382:8b87 with SMTP id
 s34-20020a056870612200b0022eb3828b87mr1118423oae.41.1712312731384; 
 Fri, 05 Apr 2024 03:25:31 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>
Subject: [PATCH 23/32] target/hexagon: Use translator_ldl in pkt_crosses_page
Date: Fri,  5 Apr 2024 00:24:50 -1000
Message-Id: <20240405102459.462551-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Cc: Brian Cain <bcain@quicinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 1344a3e4ab..37dec8b5c5 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -24,7 +24,6 @@
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
 #include "exec/log.h"
-#include "exec/cpu_ldst.h"
 #include "internal.h"
 #include "attribs.h"
 #include "insn.h"
@@ -1085,7 +1084,7 @@ static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
     int nwords;
 
     for (nwords = 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++) {
-        uint32_t word = cpu_ldl_code(env,
+        uint32_t word = translator_ldl(env, &ctx->base,
                             ctx->base.pc_next + nwords * sizeof(uint32_t));
         found_end = is_packet_end(word);
     }
-- 
2.34.1


