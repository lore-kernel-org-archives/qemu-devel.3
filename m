Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B30C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg94-0001OC-8h; Mon, 23 Jun 2025 08:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8v-0001Kk-E7
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8s-0000Tk-At
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso45773995e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681153; x=1751285953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPGemtR2ZdzEfUCvxZ4Y78uZrjiue5vwaeOrBHsS2Jw=;
 b=O8XxNpvtb0g2J494y1JuG1+NTzOAOdi7dHX2nzQ1VpMZlpvODCWDyDSwCJWiQYgX9J
 HCwjhIP0xU2dECKIYV8nO1i9virxgRE0b0x1U/SFzQCnLN/2otDCY5iA7y3ue2M7RCBL
 K+WvOtjThmgfYsywS/4xFzAb3H6r59T4UEPRVLyzhpPS/awRQ1RE8OMnax0LGa6wi3CZ
 aDilqNzQpX3WI1xeAbUXrJqpoFxXgE6oeNAx1GUyhxezsf8LMcaqaF/vt+YIB5Fa5U0x
 zKw03Pvh928LfBrZbH3QV+3ktqdFg3mW3I802OpYGW9BcXMAaEDzVjIwYUoA4wYeuddj
 T93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681153; x=1751285953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPGemtR2ZdzEfUCvxZ4Y78uZrjiue5vwaeOrBHsS2Jw=;
 b=H/z98dWoVDH9RzWGBN2DrePR8YRyrbKtMFymVK9QxhDSjRQSWGibJ9STSt5AEHWfg3
 lGkF7fqRsjwLc6bybpO08V04hdj6mSlT3RrCE1B8xJXJsW9ZbFDa+QgsWNmRfOXzMiu8
 xZo6bDmYhcaMt824Wy4BaZoA7vtSk/Mv4x/zXtn6noV0StE+MtP499ec/FbVMU2+R/rh
 0VJC87hmRwGZyfGQkd+8CkliAyiZzIWLlZFmHNEwecP6LTY4ZcteiUfwNf5bTJhUMGPi
 hrwQhwVw2BbBagvqsoUjY89swymAHh/3XsmEga/585Xfa/rKpk0byNNF+vYz8pjGLVdQ
 V41Q==
X-Gm-Message-State: AOJu0YzJUy45ZiXgykRO4vHYwTNlaIxEWqX43pXpR//zdrykHlPuPZnE
 xgG3ALbmaXqicgYKQm/K7Bz7CEQJvdiWSk4SFPgXyHltHxGkUni3ukR47ybOkR3v3Y7wiMfpsCq
 ltmE/
X-Gm-Gg: ASbGncsylUKKw3+cBAIfrteAoKWTAzA3zZ8Cq3sAf7rJp23/qe/VEwp8bMUJI0Gkm5u
 44tDp/eFdF8GUdXogpIft8fy4rquVafs1L+/gzHEFC6Uw7aHHqrgP0GABgmwnk2/viOA/XEGyIf
 KVf9LINkneA7AxMgQFIu93x8ru9czCet39E98cu1LOGUF4PPR7pj2T3sqkY5RCXrwjcCtpFeFMP
 igFEjNSgMKdh4ISHLEzzaeYot30GAeh6BGiM7ZVDxttqytDsZC3rLWRYPWxCUwfsMFSYKN3eWyM
 MIMH81mrEJ1viX4lh41LLXIjFbZ+KGYEBbZyZERfkwUjbgRAN+QMWLbi5CANWhXq5QJgxm7ogVL
 heacDCSpjgwAIM/Ov6gJwwAt4Re7wiuyumpnS
X-Google-Smtp-Source: AGHT+IFc5MQF2NU8xSghyO4Yhud3yuPLg4Ae8wD9rvl4pDNx1QI2WiEDWAGMHEB+0CpNqwj6XAaSXQ==
X-Received: by 2002:a05:600c:34c4:b0:450:30e4:bdf6 with SMTP id
 5b1f17b1804b1-453659dccb8mr105349215e9.19.1750681153473; 
 Mon, 23 Jun 2025 05:19:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1d87fsm9323283f8f.45.2025.06.23.05.19.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:19:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 05/26] target/arm/hvf: Directly re-lock BQL after
 hv_vcpu_run()
Date: Mon, 23 Jun 2025 14:18:24 +0200
Message-ID: <20250623121845.7214-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Keep bql_unlock() / bql_lock() close.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c1ed8b510db..ef76dcd28de 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1914,7 +1914,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     flush_cpu_state(cpu);
 
     bql_unlock();
-    assert_hvf_ok(hv_vcpu_run(cpu->accel->fd));
+    r = hv_vcpu_run(cpu->accel->fd);
+    bql_lock();
+    assert_hvf_ok(r);
 
     /* handle VMEXIT */
     uint64_t exit_reason = hvf_exit->reason;
@@ -1922,7 +1924,6 @@ int hvf_vcpu_exec(CPUState *cpu)
     uint32_t ec = syn_get_ec(syndrome);
 
     ret = 0;
-    bql_lock();
     switch (exit_reason) {
     case HV_EXIT_REASON_EXCEPTION:
         /* This is the main one, handle below. */
-- 
2.49.0


