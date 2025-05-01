Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EACC3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLv-00016B-BL; Thu, 01 May 2025 17:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLX-0000nR-Lu
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:34 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLW-0001UC-12
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:31 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-309f3bf23b8so1913260a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134488; x=1746739288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=84tjELxZo3OHkn1vNfCFL8Aeapp0cte03BwJX6LEACI=;
 b=VHi4+Oqrz21MCIFPOn3tYrG3SRTzRLCHM2yVpdZxD6F3YRK2ERuVJsKjyNhmn8QQlr
 /cSl2cXBhAibwfAjwyPnuFhcZXKLHL4X8eeJR0FbdXCbBB6Wvi4Cp8fqjzkEc8QW8an0
 QggBD2cBil4YnEpDYIcZAPpZvufKCaC/I40bklCLtGFFJBS4fKUZg3RLCFmlFYAyLXEh
 78ANDq9HAuUIfZjWgrnxtakf3u/Eqien/zFsZAsjnti9Q3yWj6/p92trGXTOtHJhPy+R
 Q5xQp4+6GO8JWBXrEzCuuG/uxNUEBKjnjL8GzIgTeeDgH/htrE4Ar6O3R9ndWPaMsfgC
 Bl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134488; x=1746739288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84tjELxZo3OHkn1vNfCFL8Aeapp0cte03BwJX6LEACI=;
 b=ay9vMQ+MGhmiV51bgzoaFEi9t4HYjokQbk8HaQSf1MNQcvl9I+7zUESJXE2hROahRW
 wFYMCgV/TSnteGgAPDfDCYzmMQg0hmuNRmxU/FV7C9DSy3g7nhFx8Af+Ll4eLRjabhJT
 Gzr0XfaAgXwmRZ8DzofrG61sTEF0ewsz9ngSPv+r0ZbA1tM+oLMBZ9plDFsrEjdynVUy
 qlYy3rb94uPUI7S6naNJ/mEi4I8fwg9ICoIbUs+zSZMGgfrrrYVkDlX6wAW+ZZIiWqeJ
 MHritwnKpzh5SGLwA2DlxVs0BXtlvY0xUenoZaMDEpTerV6TqxG3IaF5kLVRVyNy7znG
 jV4A==
X-Gm-Message-State: AOJu0YwoNeYq6Gfen+cURn0uGOye4Yo7f3ZGguQ11+SnFE98AQojjpuO
 Yli0w7GTbXFDKlbb2NuRgUVKfdmbnMnML2Y2J4Zqfg6I6EX9CWfr/c/YbxTUxJfwpOhXDQrBsQO
 +
X-Gm-Gg: ASbGncvR0HRlmnANUNOC+rmJuy2v7N/dGa7Hp0LJpVWTLkw5mofqpxix+RzKyY0c9Ff
 qzucOnU/3BEVqmqBZIPX5cRCTS///elWfaRzvSxyAGQBp4DQ9AFs8HsYIGrkPZXWsk4uHIDwlyG
 7sSu5fO9FoEzgeLcqGs2IKIxjCWNEYqQzF2B2cc9dUHd334EIctuXfsRNbv+BaN6Re803o3NE5s
 VKB4Zs5WlJRbzZCKXlw6ZOa/ZIqWmIkqsTkUNo4qMOOJK9alHJmtASrMeNG9Q6oNdQo8on02dPO
 4Nq2u1oNaMPtiGU35WE2r2ujyl5v6C6VahP73hxstmRwsCTqP5t3axcUkwHEzarBk54avgxZIXQ
 =
X-Google-Smtp-Source: AGHT+IEo9Wp9WgdYwhdeFur5MQl4e/xJSKY5b6PuZUyUMGN5yqRZ20413rUS3qWavSwgLkOo4FuBZQ==
X-Received: by 2002:a17:90b:4b85:b0:30a:4d18:c71b with SMTP id
 98e67ed59e1d1-30a4e5cb3a6mr812427a91.20.1746134488527; 
 Thu, 01 May 2025 14:21:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/59] accel/tcg: Remove #error for non-tcg in getpc.h
Date: Thu,  1 May 2025 14:20:31 -0700
Message-ID: <20250501212113.2961531-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
 include/accel/tcg/getpc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/accel/tcg/getpc.h b/include/accel/tcg/getpc.h
index 8a97ce34e7..0fc08addcf 100644
--- a/include/accel/tcg/getpc.h
+++ b/include/accel/tcg/getpc.h
@@ -8,10 +8,6 @@
 #ifndef ACCEL_TCG_GETPC_H
 #define ACCEL_TCG_GETPC_H
 
-#ifndef CONFIG_TCG
-#error Can only include this header with TCG
-#endif
-
 /* GETPC is the true target of the return instruction that we'll execute.  */
 #ifdef CONFIG_TCG_INTERPRETER
 extern __thread uintptr_t tci_tb_ptr;
-- 
2.43.0


