Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71FCC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u169b-0000Xv-6N; Sat, 05 Apr 2025 12:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169Z-0000Xh-Iq
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169Y-0005Er-01
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so1632352f8f.3
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869630; x=1744474430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUBhKNJ33VGc0tAXVv72Kq3hUC0BPxTHmotqIBCHglo=;
 b=DantRVHwtu842+rh/6bFTywAsNRxAsazbIAV2AmODzxaQmlScYvOjV2N3hQcxIYFCs
 8x9wjzY8O1yP5aRuV02s4eqVswoHis7X6umQ90oMqXMB/6ef4JrEPWqTKu7b1f+iT2Io
 yC1QXT+F5c9+/lAj7NS6gY3L+B6U1P+pHVJiP/8+DlqD4vJcEtMlGOmuQNkPtZU+VMOJ
 iuu+lHCqFxAxWp1tzkvGckxPywkWTDajNcr20S6pNGi5p56o1ySXIuXJspPuQEFy9lFf
 5JvFuyMiaJK8QEP7mN+ksLmfnCRXz/cVv2OeNk4mx7aOo4r91QNbJHFXSj3U2yK4KHZW
 NR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869630; x=1744474430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUBhKNJ33VGc0tAXVv72Kq3hUC0BPxTHmotqIBCHglo=;
 b=B8+wUrfabLE3ETonLpnVyMdIQ4msMKSapVt34THv1C8XO/2YNKauafeZPNVZLPcgrS
 yBW0a1x0UVdkaxG0Fwu4zPIZOTqleO7uqRPT20nzTc9zvGSHgdGgDGVaqDd3hwtlywBQ
 YSe/BkVv15DIp2jWiNDKxQSzjHVV+gpRBakUUJF2lSR1IvyxeWBmYNfjH4Klg6sEE0s0
 QZoAn0le6kEhcs5LdM2zi8aJQ2NRKhVjGq793JV+mfDXYHaAWgNE++ZidPI+qodYGVQR
 zArfQLqP9bc4iZqHbqToqmoDTxWr7c/+7RSMqWje5qXavqNdPvWNswvN/FzIPGAC3YAf
 ykcQ==
X-Gm-Message-State: AOJu0YwlmWCqHISnEuFeGFM00DQbXNpuHaVUEwIcc1cdnjraEjouTmtm
 GEVT2KSSTTJ0c9XGTKgmmfPJQZaY8FAFUyJRCb0TWpLU57oF0pcQOF4Ozrux8ZniWCOHO/oM++U
 G
X-Gm-Gg: ASbGncuI/1fpFtGDfs+wZtKNaXwurXAI678J5kzt1qEKyJFWwD1RR9YK0tr/+s3wVg+
 yfDkuuuNYY2pxqz8xgcJAghBeGvYmxyiAUfVPIugYGWNmvBn+HJ2NrIY4IAfCk0aG3bgiSkLYqD
 m+sEK9GVxJhkElYxZA7p3zNgkxHuxCglV/FVHNO6keW4yeIoeYGLF/533WxhSgus/lcXzvZRyvu
 34FfseIUz4o2UhVD+hJi3OtJn3K9FdWBg8rWjqkFkyncacCoHl42YeyB9+U5yCAB+j5eN4MhTFf
 vohhLoR5pyp3L8RaEh73mhZ5hzNfWEgP34vq9QvqnuN2KXSTwtxmBpb4J/FqMyccPXN37H3/yFQ
 hZDEL5EW6Y+A/TugqhulXGYuP
X-Google-Smtp-Source: AGHT+IGmbs3GdNz7lwqzvWivopRAvn+yEA5dQsxptJf8E2OU/CB23zkxyl/lzjmkhuZLxj67HQqD7A==
X-Received: by 2002:a5d:64cd:0:b0:391:2f15:c1f4 with SMTP id
 ffacd0b85a97d-39cba93d7e4mr6060196f8f.55.1743869629960; 
 Sat, 05 Apr 2025 09:13:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a67b7sm7124528f8f.25.2025.04.05.09.13.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:13:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v4 06/16] tcg: Simplify tcg_req_mo() macro
Date: Sat,  5 Apr 2025 18:13:10 +0200
Message-ID: <20250405161320.76854-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
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

Now that TCG_GUEST_DEFAULT_MO is always defined,
simplify the tcg_req_mo() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/internal-target.h | 9 +--------
 accel/tcg/tcg-all.c         | 3 ---
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 05abaeb8e0e..1a46a7c87dc 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -52,17 +52,10 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
  *
- * If TCG_GUEST_DEFAULT_MO is not defined, assume that the
- * guest requires strict ordering.
- *
  * This is a macro so that it's constant even without optimization.
  */
-#ifdef TCG_GUEST_DEFAULT_MO
-# define tcg_req_mo(type) \
+#define tcg_req_mo(type) \
     ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
-#else
-# define tcg_req_mo(type) ((type) & ~TCG_TARGET_DEFAULT_MO)
-#endif
 
 /**
  * cpu_req_mo:
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7a5b810b88c..a5a1fd6a11e 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -77,9 +77,6 @@ static bool default_mttcg_enabled(void)
         return false;
     }
 #ifdef TARGET_SUPPORTS_MTTCG
-# ifndef TCG_GUEST_DEFAULT_MO
-#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
-# endif
     return true;
 #else
     return false;
-- 
2.47.1


