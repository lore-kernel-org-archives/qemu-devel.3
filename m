Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8A5C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNoM-0005Vf-Ly; Thu, 03 Jul 2025 13:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoI-0005Ut-Jn
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoE-00081V-Sj
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so31142f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751563996; x=1752168796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAzT+CGbAi3kvmYQ13E5MHk/eJNqjsj98Rjqkr8WsQ8=;
 b=dfm9Uy8f3bONLmL5tOxwnyj8A7st6aOQKBdntnZS7p9U8vQKpPXRyHQaNAEpMXeTBQ
 AXUB1ZTs8ACC9Rz2ikPtd7rF/XJ9yz6e29IEm+e49fGzwxJXokpRYIp1EJj+s4+dfUcH
 vTmUifdf4yJbJUU8iTK5Y1BF5zlwLlT1C68Rcl3WqaMo/RSqVVX51l/MzyiVXbOgkkYq
 ZQJAA7oSEWJ3+/5PlemAZDTKc28Y0AvuS6zJSOylbaCMk3sn79JZK3zDrTnsBKEP0FC4
 zK3Tm+7Xid9f1ay4nue8uX+PJTXU3Hwv+rHKfwbdEE7EYJJhTvtGt0rQYi0H1cfeYqXc
 p4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563996; x=1752168796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAzT+CGbAi3kvmYQ13E5MHk/eJNqjsj98Rjqkr8WsQ8=;
 b=txc1vFyURGiNXBfp0GWuLMB196xnuUy4cDQSIcFzFlxGUqelEJAQjaVLKfOuZh71pD
 nTBs7Crqdn/p/AgRtJU2Gi//IJbAWkjSxZdLcr05c0EzoDQoChCfueuPBVyc0lBuuQiO
 wlThTbDmzpLQTeRmC563ejHLE0SkfuVWiCkeKGiuZ6NbxNj9Y/PzAaXgrHR+XroUPRWm
 fhiLufiwYWNqUSZdf6InlmL+zhx+dfUVS+4arUCRyWD7w5OC1q0BlX5NyEC2x41LpvjR
 QXE6a98NsucKU1THMcjIiJtaxyBSuxyH4jt2Htzd/j/yPtJz+n7WaSwQ6fOCqm70rvus
 5akA==
X-Gm-Message-State: AOJu0Yxi1OjhMNGwjAm8Gq/1xSWT2dnNfbS2LquLOn6ZWoZ8mkYVwQsa
 zl8b57ygXI9QQD//00tQeHCnX39ERFipwfEZv9Sr0Dpp8WbITWpUrVPJkAD9EVFHBQM7DMMX/Hb
 ggmefnjI=
X-Gm-Gg: ASbGnctZ+Z8JYnFHCf1cObHDWw4/78DTgMg43Bc/yJpxVAj6tHTKMjrgSSWoagaE0od
 wPehm6LrDQvV556qRSTZPqgOkWDJ+rP2squXAPtu/8AM7Puzq1czed8iHEPdVxhCe3Z4qCh7iqy
 U7IHbu7fXp0GJlFIB6lDhh58yVpyXnaPLHXodUUK9lQz1Ijd7joz9NouWehS4u0/5wx+OaBSPo9
 eoK16YouxXgsnwWMKdkD4c+nu0JbtUjxVgpUmLc536QHKSdgWHihFU799KKVSo8CxFDAeQpmV74
 oF0izdJk3RSld2NS28j5UnvSnAi2YCBPmUrYEI/6eJBma77Ekbgp8jWQs7ieehz5EKsJ7NrdvIs
 pOhWL5ZlVaetAErVoNy6Ojn8jDuHActAR/3R3
X-Google-Smtp-Source: AGHT+IGh9RS69JWNJgwXCxoG24NZSngb1bZPnTE9GAXQAWzmNTnSn2b0+ZIFTnOK3Brqe8Us0t3MKw==
X-Received: by 2002:a05:6000:26cd:b0:3a5:3a3b:6a3a with SMTP id
 ffacd0b85a97d-3b201ba1ebdmr6134479f8f.54.1751563995936; 
 Thu, 03 Jul 2025 10:33:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a2dcsm309045f8f.71.2025.07.03.10.33.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v6 05/39] accel/kvm: Remove kvm_init_cpu_signals() stub
Date: Thu,  3 Jul 2025 19:32:11 +0200
Message-ID: <20250703173248.44995-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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


