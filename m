Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA02C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHda-0004zo-NG; Thu, 03 Jul 2025 06:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcG-00046o-Nx
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHcE-00011o-CF
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:56:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453608ed113so57019105e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540184; x=1752144984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAzT+CGbAi3kvmYQ13E5MHk/eJNqjsj98Rjqkr8WsQ8=;
 b=LdFGemtaN/yvZ3tN9gvY9bIdFMphftHhlMzsbwX+plijl/VlP+cQMb/jKsJTdZ3pcl
 3oXfuxXR4kUSRxGCk5KxJCaAtMBoKgkVCdf9m7AdPzeyWJyjy7NLkxvZ9Nqmb76i+WEa
 HiRswr96JIhSuGKiHiUAXWtPPgt1NnmtMDTufbzd3UoSUjmwxhq9mAwflr6zIXGxyDAT
 AwDwiRQzO8XcyhvevsT1YD5hBbIPs2xREN+XmZ8lEdgTu6GKnDUUbLNfzafciR99hMoc
 s9dN6/XSeiMLmBRfiCmmeKCfg2lXsPLTISCY0qMdVE2G1bSkuJGbeFmP3zVCMqL2XA9n
 /gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540184; x=1752144984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAzT+CGbAi3kvmYQ13E5MHk/eJNqjsj98Rjqkr8WsQ8=;
 b=qfMl5rkRV99OZgYrNRvy81uZ4oXv6h4MaFZUY7y0jK4akKCgsCBhxZZQN1gOw2yDfW
 7c8BM4r2O8riYg5qb9ZxC8IuOx6B31Hj+4Mz8rDpZojdujZPpULz7pSLIjPWk6X1MXTe
 w4tgiBH0NtfqY04ngB8HGkd64R3uICWw79v8h51UHFBxLSaHTiE71On1/7wd0JLVTJjm
 sDYp4WIVR0MTiV1SKFWnx76O4o+HsQmXna9rVxkJCYnYkZ4MRUwPi+ONaOE9VymZAa+0
 sBgNXLRbWEfwgCjVuOHNyz78FdHJ+GE8W3Gy8TOc8Bf+eWjf5sV+oTejCVEAQ0C8DQiW
 XjAQ==
X-Gm-Message-State: AOJu0YxRfxY45nY23vcv8KlPca1h4lw4yd0t3w8FwVzdekvOTZVAgt+Y
 yE7iAdq8/bn2pqPEit3R5SekygX1ocp2aGMbwFdmjOPmV8Wt9JUVQeaJZ/7rquJkitm62x4eFlb
 vf1ewYeg=
X-Gm-Gg: ASbGncvw1P+rptafrG8jvNckdvfoQksj16W1s96FYH2FeJGeZj9gK6qJuOHQycWM1Ek
 N0VSAAcxRLS40GXnTBSEwTbCY3mZtcFCmLMagxHOGYpwKnfLjbDeSluFh4xvBrJICoS77wsW1AF
 ZlEvbwNtxrkeJWIyAb0p/w0H6o2HixRfj9wqMj/QM7ag8ZBdzDXC3wbFY75wXbzOtvuq6fotLCh
 dO0hwA7uO024IV4dshXGE5n9h4/pC/Gk/V6zx+QLGikcDjqnAc/Uyy9x0YNXDGwwtIvYF6bshBM
 6uAb8IOIirIGFsxR4kzgP6dJU8NT8/Bby0uK7vIXZCmIwRn9QBLAgNmuBz3KsbmLkZgU3nVWABH
 jcqcOw7+hpIM=
X-Google-Smtp-Source: AGHT+IE76e2TUYigPs3T1c0SvOpyckwxGPcmZStVjGAVMA/07iDRifoqinW9ikXlsT4NJ0pneko+hQ==
X-Received: by 2002:a05:600c:5308:b0:44d:a244:4983 with SMTP id
 5b1f17b1804b1-454a9c605e4mr38453455e9.3.1751540184293; 
 Thu, 03 Jul 2025 03:56:24 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9989423sm23505035e9.19.2025.07.03.03.56.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:56:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 08/69] accel/kvm: Remove kvm_init_cpu_signals() stub
Date: Thu,  3 Jul 2025 12:54:34 +0200
Message-ID: <20250703105540.67664-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
to accel/kvm") the kvm_init_cpu_signals() stub is not necessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/kvm-stub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index ecfd7636f5f..b9b4427c919 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -105,11 +105,6 @@ unsigned int kvm_get_free_memslots(void)
     return 0;
 }
 
-void kvm_init_cpu_signals(CPUState *cpu)
-{
-    abort();
-}
-
 bool kvm_arm_supports_user_irq(void)
 {
     return false;
-- 
2.49.0


