Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED38C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcAY-0005oE-5w; Tue, 01 Jul 2025 10:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAU-0005al-Az
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAN-0006rA-U8
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so33900365e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380858; x=1751985658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAzT+CGbAi3kvmYQ13E5MHk/eJNqjsj98Rjqkr8WsQ8=;
 b=Zw1BVUKafcGzXRpdd611MtyaAEYoSEHvClW8y4m34+AmUnTyD3XYCZ+6Wsnz0d7OQl
 xnmHk2eH0153s+SrKEGIQ9GFKu2ipW31MPVr5wiSeBFB8bcYdapt3RluE36P3D0fiTgP
 oIAfK//1IJFAC0RL79xRI3ePaW/OeEfYa2OsgIzaPwoKQaZ//4UsUbIC5llaStKa1thB
 0EsqTYyZoWtmcAi6/OdUjT2C3bKARwgZyxrVOSaC5E08fSf3SzU+WaCn+vW8Jpn5Nmon
 P9jIpF1RrPZ3JM40m7VJGsCc96pYXAEmmd6ZGTMFjl8RWGjnPqH5trwl7O57NZfCKjYS
 YGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380858; x=1751985658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAzT+CGbAi3kvmYQ13E5MHk/eJNqjsj98Rjqkr8WsQ8=;
 b=Ktogak5KEexqEPOyho99531hdgzSOlomDlmL+kqP8C7YXpzWrB1vxg+8+TshwuvAT2
 xoE80Tg8QZosv643kMKUykqUdO4xy/90kuHBclw8t8DCsDJscZS6Nue49abd0d9WLi2f
 zReSiMKpkvC8Gx8RGGJNobo7u8khJpKp6PmwJ9uR9+975wJAj/2avkQzMC0+8RkhIxMd
 FXJdRZyweg7CWfakjuA0eEWkabJW1/7asvTrGRTn3GtKPHsAwP35kXv9/nZMxW69sskd
 NcctWe8oNmjQomFmaBRurKPryOqT5WeHYPKCFBwQpknOFvV98Ufk9v4Q+4+dgbsKpmme
 t27A==
X-Gm-Message-State: AOJu0YyPyHOiu/1eNiMpa1PrmAlFGwX4f3CGK0MC5vIDvhEufbuUzjA1
 HC4jqKSZ5zmBrHuc9cUG3doiqlXUX2vCHM/zw6aDprobQm4u7mtgM4jN2TxSF2rt/S7ExKjDYUh
 fxFPV
X-Gm-Gg: ASbGncsTGXSN2vljpHrtNldUHKygn6EKMV4XbbiFbex0Oz2d8AZHWSZQVghxWg5+kHn
 sMKkpcuHPZxRP5u/8k5VJUviDR1eFeiEj7ig5vdcuh4LVSwnax57v3eYMQ7sE0D1f2TQyTvljM6
 5uQQd5SYKfVqGAetjBv5n4nEV31GGcdITgae7GZ/OhTfwyIxYjXB9LAenMyTDlCb5Zgr4kCOOB3
 WFBXOVvaIG6RQFwo4FLuuz3WV9ckA9AN3bT9U1qmGvzpktoevEUodOZQTcQmDl84zKHRxBu2prG
 K5QHXeiEu1ylaHFeBg9RYB+W8vbcL9ul7Ec4ZCBThrzFisystSyV9jOC/EyTql9RRZNRCYdgsqJ
 KNSf39YoPTl9UEEP2s/8C5/8ybr2fl8Xdh7Zm
X-Google-Smtp-Source: AGHT+IEAzjJ09ClXunxfbnU7OfXcEup8Be9O4Qw9kppwK6aWZ8ecu6i9eh5ChbbKiuk35AN3XTx6/A==
X-Received: by 2002:a05:600c:4f54:b0:442:dc75:5625 with SMTP id
 5b1f17b1804b1-4538ee50b15mr171956105e9.5.1751380857627; 
 Tue, 01 Jul 2025 07:40:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823c42e1sm196647755e9.37.2025.07.01.07.40.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:40:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/68] accel/kvm: Remove kvm_init_cpu_signals() stub
Date: Tue,  1 Jul 2025 16:39:15 +0200
Message-ID: <20250701144017.43487-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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


