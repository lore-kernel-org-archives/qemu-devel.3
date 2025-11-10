Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED61CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ7u-0003Mi-St; Mon, 10 Nov 2025 06:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnU-0004uR-Qf
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:10:57 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnT-0004KH-A4
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:10:56 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-44fff8c46bbso413232b6e.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762773053; x=1763377853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YLfkVi5M5AkSw/2s5VwSvjNTs56k54sKTHppQSSpW4=;
 b=o4U3DV/04E2/VFk2cSRKuFFplR8C/n4LZLMZaZdykKqM1S0P1lXTPRl2TcCROKLREQ
 XeAi3+ikNKfMd1hJbKSt2E7c3mv6k639rxoT0nCt+df6ESufOXWGaCBIP3ay0zUYGcsg
 R2xlWKbyW7Rysyba03U79O07sohMUU9UO0jOQqy3P7+FizQiiCf12jkuYqlZ2MxHQ5cz
 NlqZAzhOw5Zu45oKZlz/9qtkkQJR89DDuvBIobpBm+wLwLkRQOqn1mYYjclTtMgS/UcT
 xuUM678UGHiKqkgK+OlHm9G4EZ2RvUBHeLpzJJDv/hYTpeyy8ZESQpPl9wotfBGBI8E9
 tJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762773053; x=1763377853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7YLfkVi5M5AkSw/2s5VwSvjNTs56k54sKTHppQSSpW4=;
 b=i+J5QkdvwIhQ+aJMMgqN7VqcTW7Ks0VtsgItP8nmjE4BHyfP/w4AeD4HyrMTLGuMfU
 OEOQohbWsIx6MsrCYHNXkEcdSCqafEuriUn3JBxCv4C+EsxJZS87sKp1wNO8g+9+F450
 ehMidFnAsAYrXboAfT3CR015+Rq5mrObGIZwQWHAbsurriqNdeTE3UD01BDY2t97q0qB
 DQDTjcCCRoKDxcg9PtVAGd0FFXB5jkFzzKojWxCE4uAqTOVVL9DW9obIFrzfg4/gHwWG
 h1cAiBnBScxy+iVkXy2RaOriyalpvFr0HPfntc41xz3sQsDQjughWcRxNVCgDOHx5pW0
 Ykog==
X-Gm-Message-State: AOJu0YwbpqR0vtpA4NZjb8LkU0sdM7rsXVsdW1QAKa5od1qKGpydq/t8
 FSlxeGFPh1n0QgHCVpalYTmwV64/zkAyvvhHJovtHH3QXknK2YnRqa1N/0wkAp5bSy5+MX4B8f8
 eoLmg
X-Gm-Gg: ASbGncu46uRe1wLwjm90B958AqpR0oQNwLs2XGp5xlhxNL0nLeRrySNE92wYapV+hCu
 B/MDjQKBuG9kPeMzv+DaxLRsYhn0yieEi42YyryDdiy1laxgwvvDw/0uF36aEjmzcYfCSJNLWOG
 MjbCnAi34hN4WbmDeZW/6d2PpzhItev54J6KSVygfIYMXM8VMAx9WEMhoYI13r+KIz6s2+B9nu5
 lMkZOyFzFJ/Q++EV1NLGibtueiJTIqORhxWqJEI3Yaon4iDXpmOThVjnRqQTwO+FCzBzFxKy9jQ
 MHoPZCT1enFHy6KlfYnDVcFllGHtMqRurVIchub2qDrWWAp5l3l14RbfowJx1xzc+we45Kcx0ss
 mVgw37B3WZDC0xDwiqW272dDH2PdPBI266ulkprYBxwSX1qHaTe4J39NBXSWo4hmCQlzXyhLL+P
 CT3RddVG1iS3YPfbAczi/VKnJp7qmPeKnNMFo+Q0vZ
X-Google-Smtp-Source: AGHT+IHJTHqqDs6gAZkp/H7tVSfQgyc7YXYWYgk5BXE+cncyGjPZC9+A4yuioWzf6iFsip4WuHNZbg==
X-Received: by 2002:a05:6808:1587:b0:450:b3a:539e with SMTP id
 5614622812f47-4502a2046admr3513985b6e.28.1762773053645; 
 Mon, 10 Nov 2025 03:10:53 -0800 (PST)
Received: from stoup.. ([172.58.183.226]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450426be56dsm1603412b6e.18.2025.11.10.03.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 03:10:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] accel/tcg: Trace tb_flush() calls
Date: Mon, 10 Nov 2025 12:10:41 +0100
Message-ID: <20251110111046.33990-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110111046.33990-1-richard.henderson@linaro.org>
References: <20251110111046.33990-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250925035610.80605-2-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c   | 3 ++-
 accel/tcg/trace-events | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 5a8d0784e7..cd7c32361b 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -40,7 +40,7 @@
 #else
 #include "system/runstate.h"
 #endif
-
+#include "trace.h"
 
 /* List iterators for lists of tagged pointers in TranslationBlock. */
 #define TB_FOR_EACH_TAGGED(head, tb, n, field)                          \
@@ -771,6 +771,7 @@ void tb_flush__exclusive_or_serial(void)
 {
     CPUState *cpu;
 
+    trace_tb_flush();
     assert(tcg_enabled());
     /* Note that cpu_in_serial_context checks cpu_in_exclusive_context. */
     assert(!runstate_is_running() ||
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 14f638810c..121d6b5081 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -24,3 +24,6 @@ store_atom2_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIx
 store_atom4_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
 store_atom8_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
 store_atom16_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
+
+# tb-maint.c
+tb_flush(void) ""
-- 
2.43.0


