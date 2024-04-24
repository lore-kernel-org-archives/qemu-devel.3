Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D727BC19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5m-0005yE-DB; Wed, 24 Apr 2024 19:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5k-0005wc-63
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:56 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5i-0003cb-MA
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:55 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so1176353a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001513; x=1714606313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W9eiE29Bj7CMVURG9HseqahFmYGTQEZ0wVZgUH4CDAc=;
 b=q4ne7GwS5Zv1dTNDaIMTCadg3GLNYpudrwiN/no7RoQHpfSgYHBqwXF/VPFhtsB3Lt
 iuUtfHv17P0596RyeZudeY8hf54RuKuVJr7sbp5YZBzTRXTMU53Dg1ytrDwnosoMxRjs
 jAZDg+h+t1OoIFi7M+/4kTWm7NrK0sSiCs6tZbxU9Pt+Uzi6yyaG7c6A1U/rKxV2AUv6
 6cBOCECeEZUjhoLqAlN/EoCH49NjoSVjaxByl2dxRJl6QlaGM0yJlpids2ldZhIV5x8A
 ICXOTyRpFDtXIFD7cvKSveP6ltdYFOZ+VnA+O15aCf89DD0QlOgx2JnKd8RgCKvZXA/0
 +eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001513; x=1714606313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9eiE29Bj7CMVURG9HseqahFmYGTQEZ0wVZgUH4CDAc=;
 b=gcf3yj9HBsPjLhPy9Gpv2EW+wlWrqhPKpj/rDj/PCCrAWkPIeZ2ncLCAq0YIBqRpa9
 UPbLCnf6SY37IzPagonJ/OBIIFgFlUJLse5rTyI6qu69szikF+JoLYYCBN8hMRirOf6T
 J9Fb0QBxHCjzbWgdaDibYJNK38pgwETyTHmnBdwVXG1at9ca+Q61CHUyb0s5NxTzz2cO
 BJD09/aqIsz7i5dDea8cF9wyoILHzNs1Lu6zXQ/q7lT6eH5do7/3EcpvJy5oS2nDquCs
 yJrVytFmGyU0bbRrU077AkBkBek/K7jNIKkRVlrqNqIfD7VwjfM/ZmPtSdpZd9rAH8yQ
 llQw==
X-Gm-Message-State: AOJu0YxECxvvAK1Aa13PEvxx6wx0l7iCiDIV9qcwccfJ347OP7zbq40R
 wslj4v0K7owzxwiUtzrUNDyHTeEqavmbzI2dGEk/RhPFsNONj0d7f7UY9IzNHN3AsKZxkm2MHqw
 n
X-Google-Smtp-Source: AGHT+IEa1gvPyZ8hUTp+zz7GBq6VYYaHpRHMWWM3r4Rv/VcnjyMbFvX2QGIdKONR+9qSCrpgojyoiw==
X-Received: by 2002:a17:90a:b104:b0:2aa:b377:d29e with SMTP id
 z4-20020a17090ab10400b002aab377d29emr1705370pjq.3.1714001513151; 
 Wed, 24 Apr 2024 16:31:53 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/33] target/hexagon: Use translator_ldl in
 pkt_crosses_page
Date: Wed, 24 Apr 2024 16:31:21 -0700
Message-Id: <20240424233131.988727-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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


