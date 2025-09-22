Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7528CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lj4-0001qR-JY; Mon, 22 Sep 2025 14:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lgS-0006Ax-Uu
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfW-00052m-1N
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:44 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-269af38418aso50838615ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567221; x=1759172021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TShQhvQkk0r8kwmD31rsIF74/vVO8BlgWjtZI7/oTSM=;
 b=h8SVZk/wCX05ogDQzo3UluFNQyOThW7cXup6Z4irKkPh9q8zyJBkczMfEhcJw2Fijm
 AHGZwKuHF1DLx2nfA7VyxXKoWZVhlV0oq73tRevMDZucgGB0t6mCnAocIH/Ox+grTkyP
 SUUhinoZ2YZi45pGojOOfF04Yz5f06uL38/U9GbjL+8rYGHDAhHsEoox9tD1Ue5RFQlX
 Gf7L1wPuQcxeY7ONeitV5XNCzJj3549nIgH5zLUiCVbl4DwmyKSGk/R1U0TCMZEqthyD
 9ot04QX7iAtKwklkblvEE8KFdcwPtKRP3udS12SlJMHNI84+zVI/7nbU35DgdF5Chsw2
 w4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567221; x=1759172021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TShQhvQkk0r8kwmD31rsIF74/vVO8BlgWjtZI7/oTSM=;
 b=vOJSVe8ubzXNzgI0RHfVAy3FeWosszoi7XBIsV4tCe1n5hRjU7IQEs4pYh09/j6qfi
 sIi7iavBBxH12x4UsK2a9XFKusxJdWo8oFAq4JE1+rgruINXdGPxtgFQFt9niqb9HbjQ
 7i1x2iTUay1lgFutcnu0hfyQiB1k9vpITblZVoT0VEXm5j0DWuUSmzbtfwd5tyJ1Lix1
 ErripqxAzFiR0/47QEQVxYZSgLN7B3IxvSLJD289aWnCNpl2fqqUA/r9s+sqDpzSlzMk
 UXReiIj7hw1yNylz5Tpc4lJwLoRnZ+JvsP5Ked29EV0JgUPmZGVR8/iDVShCEG5dtJvz
 ASJA==
X-Gm-Message-State: AOJu0YxMcCFRdgi8z0UkjYUGJbjx0KJZ6GclC4zJriXg+GCGx2+hTa72
 ScwNPh0R6iUL7knpj6qoTDlzWYp3WbvxCzi9or8BYnQaD4bJ2k0m10Qg+Tytk6pweetbfuUyTPj
 A/Azb
X-Gm-Gg: ASbGncsCgMselcgu0WpnajKIO0V0VkO0gDCoBfUxdVWK0aUNpjmzjiWlMZaFxJ/ipju
 /VulsbR6JF0C46lb4AFz53eJVaQ1rRRISMxZmPrPpjYFNIlitVcmF72WUoEsDoqcLcGNP2tn8pq
 s1ePvYnca6wBdLnVg6iw+3eHg6wWkLfRtAXlTLFcN0H9e9ysSlpQJhrZBiOdaOQgnBKYqJl9zN5
 40hoIEMVbqsArrb2EMilIauy+ECR2i+vLCbfjr5vcFN67yZ8d0ISpnH4GcOMJOPiKkUru8gXVFK
 o6wqgFpzvLKcFO1aDdvz0NDPJerDYqqwTymeIGPGbIYY9by2dL/SfnscyaJMD1fHD7HTAOrPDng
 tycX1DE1jjcCYb/WRiycOnZcTp912
X-Google-Smtp-Source: AGHT+IHy+NiEq0EnPsUFsqcW5xhWtpj3DbTWRLQCxEVHdXkA/yKAveRZoFM44VEFLntx/Jj0IvlLGw==
X-Received: by 2002:a17:902:ecce:b0:268:500:5ec7 with SMTP id
 d9443c01a7336-269ba3ec4e2mr195656955ad.2.1758567221608; 
 Mon, 22 Sep 2025 11:53:41 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 71/76] linux-user/aarch64: Inject SIGSEGV for GCS faults
Date: Mon, 22 Sep 2025 11:49:19 -0700
Message-ID: <20250922184924.2754205-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_signal.h | 1 +
 linux-user/aarch64/cpu_loop.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 6f66a50bfd..e509ac1032 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -7,6 +7,7 @@
 
 #define TARGET_SEGV_MTEAERR  8  /* Asynchronous ARM MTE error */
 #define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
+#define TARGET_SEGV_CPERR   10  /* Control protection fault */
 
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 6060572eed..41d6b35498 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -89,6 +89,11 @@ static void signal_for_exception(CPUARMState *env, vaddr addr)
         si_code = TARGET_ILL_ILLOPN;
         break;
 
+    case EC_GCS:
+        si_signo = TARGET_SIGSEGV;
+        si_code = TARGET_SEGV_CPERR;
+        break;
+
     case EC_MOP:
         /*
          * FIXME: The kernel fixes up wrong-option exceptions.
-- 
2.43.0


