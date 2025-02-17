Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258D6C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pa-0002CZ-2E; Mon, 17 Feb 2025 14:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6oy-0001vZ-5o
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:28 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ov-0008NR-N2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:23 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2211acda7f6so33379685ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820620; x=1740425420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0w1nAz3ZZyz0kW9yi4rO7ndLN0hIyYSz6AGDjBaQFXE=;
 b=SkMrefKC/kpBk8qF0PSXfU24VR8dvw0z4VDHVjQkSTM18CL4ElRgdD4o0yZ/Mz9i/E
 7TRHn0cbWMt9oUNIUFqhXNW5USDalHbaDrXuMc8zN/5swQ4wPT0nGc8xSrGsuuWVrCB7
 CiAiv+UDDrONMl2AK7s3P0FpT2DxbMGlQvFhZ8CFqHcNGsAj9st92hvUoU/ktCrnN9Pc
 Z/1E2v4luQdvJ7UKWUaZtevRZxXhJ2p+hglMUryEV4gcvP3t+5w1/Qub9AEPq3U8SHxa
 37TedIV3JrCY14Tu83pykHEghoLdpA++xA5wRU5FR7t68VIAPinHqZ+SvxZVmsHshEpV
 aRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820620; x=1740425420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0w1nAz3ZZyz0kW9yi4rO7ndLN0hIyYSz6AGDjBaQFXE=;
 b=YUrwlE8CUNoSBi2F1S3K6J+/NpG0/wDst6ppOP4jl6PYoQ5YQoUsWq7CUYMTZ7sFrg
 6I/YnqdW3hLr83CDr9/MPtX0376dCdEtpScGDU+/W12ahHkzU46m/cj8/3Bu1Roewnn0
 16wcuheTpfEwaUqpCGTD8yIDSvy29Yrx4C3YXc/AQDCMaaNkWgUV6S/wHeKU4GV7omZ7
 y0RfgDopO7ytJGh1RqHXZN45eykJ6GmYYjIgrwcqvbIUV8yk02dFqt/sYADL4xZlTtct
 dFzWVeC3X8fjl8Q7JQ1aqWSp7l6wbyuB0dyV27rVy+XUjuJbNYzH8Tua3vRueShAM8V0
 PLdQ==
X-Gm-Message-State: AOJu0Yx7I/N5UfU7J21BgcHRrM2q74WuWO600kxyui+WzALPSQHW2IWA
 vYQGIgs+6b+VoAd14+C+cvoLfKJi1I7YN0SayUU94vTn1wCxoYNb6g5NfEpsTVrqbUqB7k4ia/h
 S
X-Gm-Gg: ASbGnctsCCwrMcmbppW35h3W1PHbN0W7ywOcrDpjbJdMBgIne7V7DzA7oMyDuAlKrrF
 Ch42LlbIt+WUbhL2hhqz4fwRwnOzjvQAlaZ6L1HuAiDlgiqPduDmMQF3uz1aKP9MCgk+AsXdrAt
 qPc5WizL9Aun6KvkMT/xQRmdJ8qzPUeB8XcYHkfzyJdipVV2tTC2UfUDQUKP2mfN/U10rWgnNxJ
 O0H4h8rJ6RMVkY0rziqfV2m8MrjLTmEyKOwbZlFpXGk7A0TCXir0wus5+9S7EWXlCjeVKuhcGbu
 P4aC2nURj7Uf3z7i5D+NsB9WtYNwZgqfFPBmtry3R6akV7A=
X-Google-Smtp-Source: AGHT+IFsZkL+es4Js8L70y2uFqnpdO4PnLCqUFFbCBAo7g/e4+YEJRMWVtgzlsOmgGDrcClSEWVN3g==
X-Received: by 2002:a05:6a21:33a1:b0:1ee:62e4:78cc with SMTP id
 adf61e73a8af0-1ee8cc1420bmr18591901637.36.1739820620112; 
 Mon, 17 Feb 2025 11:30:20 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 13/27] include/exec: Change vaddr to uintptr_t
Date: Mon, 17 Feb 2025 11:29:54 -0800
Message-ID: <20250217193009.2873875-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Since we no longer support 64-bit guests on 32-bit hosts,
we can use a 32-bit type on a 32-bit host.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/vaddr.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/exec/vaddr.h b/include/exec/vaddr.h
index b9844afc77..28bec632fb 100644
--- a/include/exec/vaddr.h
+++ b/include/exec/vaddr.h
@@ -6,13 +6,15 @@
 /**
  * vaddr:
  * Type wide enough to contain any #target_ulong virtual address.
+ * We do not support 64-bit guest on 32-host and detect at configure time.
+ * Therefore, a host pointer width will always fit a guest pointer.
  */
-typedef uint64_t vaddr;
-#define VADDR_PRId PRId64
-#define VADDR_PRIu PRIu64
-#define VADDR_PRIo PRIo64
-#define VADDR_PRIx PRIx64
-#define VADDR_PRIX PRIX64
-#define VADDR_MAX UINT64_MAX
+typedef uintptr_t vaddr;
+#define VADDR_PRId PRIdPTR
+#define VADDR_PRIu PRIuPTR
+#define VADDR_PRIo PRIoPTR
+#define VADDR_PRIx PRIxPTR
+#define VADDR_PRIX PRIXPTR
+#define VADDR_MAX UINTPTR_MAX
 
 #endif
-- 
2.43.0


