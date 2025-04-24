Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0926C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8384-0008OS-CH; Thu, 24 Apr 2025 16:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8380-0008Jh-Pq
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:25:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837z-00051W-4S
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:25:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1817042f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526297; x=1746131097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+m03iEv/CwRKZ4DaA6A5ejhgsU3RRDvCte3j43cohVM=;
 b=hKArBLqehK9zmbpbYY/EFVD9gURgHRWgFCoij/JDBlV9yJcwGyafaq+W/BN0E2nr7o
 l0iMGF0VNQA569EY26K+v/F9UTe8AYITMZ828D2w+8yDRTsr/i/xBpl2472fWb/kS22H
 ZPbO/r/RmD4ZzEw+0DnHMZ4kk9lmFpsmX4lUecOoNHRleCNKl06iP2mpzv3xq3Q3zNvM
 LABoP8pkUz/ydwZpsSwrqmiDaMoL8EzIaWy7H1XRwv6EfiLqUh8HVSzIFw7jPnBlqQ1/
 DLmqPVcoQRmLKj4jKNQjEe/hQSsJF6UDIcB0CqPLUM4wIGZYwtjL//CXdZilYOQEyoJr
 uBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526297; x=1746131097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+m03iEv/CwRKZ4DaA6A5ejhgsU3RRDvCte3j43cohVM=;
 b=o1t42KX2UqhRJ4wGXxz3sViBxKLuX/Kc9fQTgby8LX6L6mUvVV9eK/LsRP8RpORgyb
 VZK7S32agPEYNVuW4uzVbb02he0cRJRc3vylMW51yofm5kTevkGK4cqQBGEP4NKEg7Tv
 yCJmK+PoQcOxC3AhxAiN31dt5kXaKoYSjj7tXTyPHukfKuDfnSOw+csAuGieLdZsfVfo
 BbC3pyTypw0mmbhE0C4I5R7xba8Ws3SruJBb8XrIusZ37/NxSVP1A92moB9VR2bcIud6
 Ty6XMSf+vZ7Y2LtVQX+h8UXdiMJt/fOtRmckV6MVYkCnwKeIfZxasE3hcuv5I7cJyG2A
 96yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULgY/l5AlmJCHG3lwa0UncU7S45p5X1psCpVCUi3VV9eEC8fmPs2xJ0lctZWAKqkO2vY2Yh/6sEGJo@nongnu.org
X-Gm-Message-State: AOJu0Yyk7epSq0vqUonIL42SUT2W7sgQS7cuy0RlYzurEWxuyg9XKoI+
 CccesmRMtcei+s9WPXwW8Wkuk3kbp0pEW6lXoNsYFvBhJxY+24jux0xKs1dW5X0=
X-Gm-Gg: ASbGncsXmx474RdbsdzPLOekELpaPb5yvPHFHmPj8x67+7BSQ2NKq41+7ZyTg8K4X83
 DQA0mjo414eXQ74qJK/FceHK4B59GKtxsbWG9CzWSIFlNBZQmBcX9/Vh1j1IGEwKM2KB9Q7P29Y
 1nBZbugdjsVlcWRtcS2hf3/ftKd9QLiMKSP06VHHC4/OgBX48B4RdmvUf5H7ZDbCOgsaqyEJ3Iv
 UKobEuobl1QmeBtcKSl1XQaCoLkuZG+wRxwo30YjcPzudtH6qwmHsLEovo2eFMEEfYR7sH+0ewo
 h68yuVKbn/a/kls5O2Iwj67stEWmihnYIjWm6AKPcjMl6081EJpOwZzkGHVxZ0iW/MaMf/Vrmqw
 Vxz9NNbbwMnB12fI=
X-Google-Smtp-Source: AGHT+IFLDObW6g+1nAatJhcEGrBxQCoX0zwwcKHwOZIsazXK7egcTujbs6/eNrPeoAfhmUHGjRpEOg==
X-Received: by 2002:a05:6000:2510:b0:39f:c05:c220 with SMTP id
 ffacd0b85a97d-3a06d6dc253mr3665833f8f.22.1745526297657; 
 Thu, 24 Apr 2025 13:24:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5310ad2sm801495e9.21.2025.04.24.13.24.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:24:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/13] accel/tcg: Include 'accel/tcg/getpc.h' in
 'exec/helper-proto'
Date: Thu, 24 Apr 2025 22:24:08 +0200
Message-ID: <20250424202412.91612-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Most files including "exec/helper-proto.h" call GETPC().
Include it there (in the common part) instead of the
unspecific "exec/exec-all.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h            | 1 -
 include/exec/helper-proto-common.h | 2 ++
 accel/tcg/translate-all.c          | 1 +
 target/avr/helper.c                | 1 -
 4 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4c5ad98c6a9..816274bf905 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -26,7 +26,6 @@
 #include "exec/vaddr.h"
 
 #if defined(CONFIG_TCG)
-#include "accel/tcg/getpc.h"
 
 /**
  * probe_access:
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 16782ef46c8..76e6c25becb 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -13,4 +13,6 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#include "accel/tcg/getpc.h"
+
 #endif /* HELPER_PROTO_COMMON_H */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 38819a507b2..0408e2522a8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -61,6 +61,7 @@
 #include "system/tcg.h"
 #include "qapi/error.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/getpc.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
diff --git a/target/avr/helper.c b/target/avr/helper.c
index afa591470fe..b9cd6d5ef27 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -23,7 +23,6 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
-#include "accel/tcg/getpc.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-- 
2.47.1


