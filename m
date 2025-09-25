Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1524ACAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 02:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1c8z-0001wh-42; Wed, 24 Sep 2025 22:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1c8w-0001w1-Ni
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:55:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1c8q-0002Ut-JD
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:55:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so2464775e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758768928; x=1759373728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMXAhv3XdLrPB0PV3Q+hnkb3wlEo+D3tstmtaGw0sUA=;
 b=bFzsYGAw1Q/x2tctwIgYs7Gwk77D4GxYlTGn07PfLSq1NvWBss8QREd8oWuuFaEUuM
 BYnFcs/rCQ/3Uu4bDTDCuyFX81zQtdFIRQp1w6TI3OvbjSajLsIapap2mNIVybXAEKFl
 xSfp0LdLNL9PRKeWcn1TyGS2CZ95MCEANeor1JKxflr5/+3gKzPQtsUnn3EDDQat2gie
 jXd8otgOUSdOc5s09BFhpql13R0ivMJYFqGMqFlYhHOnWqXQEqjOvLjZDv3/mwRfnWC4
 CNWEGEBrkfovzomz2uqzB0T7Brip63FhwB1hq/fpTJHzo1w56XRa5ds1u8lgZyWRIDlC
 gYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758768928; x=1759373728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMXAhv3XdLrPB0PV3Q+hnkb3wlEo+D3tstmtaGw0sUA=;
 b=cCSjOeceMKZrehVmk92spHdyx6TchCRiYE0D0zIbv3N7hF9/ETWIPMQSNFor1rBsjI
 HAdAL3NyMBoMRloABYirGVukW3dn50SUzc69MVO/TMTvpUA7pwapWjFFxIw6eBG5MSeZ
 a1yITjtjF3GKLWihMHGQ4F14vCdjpuriM/MIkc92ZhOaJkGxYGwUo1v3jQVhe3gKkhUI
 8qZQm0fEIzgU2bpwHnuHJVa7SB2ZxIu+swh99GteaQkmoGe9rK3JqnLQP6q0n4UzEn2u
 4ArCK7mwzZ1q9S3IIV+DguxPzeqYsO3NdSEeJPscIqp56Dq234hV2FonamA+VijLFRif
 dqLw==
X-Gm-Message-State: AOJu0YyGT5rp6HjefJWt/btIKjaBYx0qWcM8Eij4tTzmUIHGbduKwqM7
 OX6N0VxECw9K/nQVJS0uUwGq8pxQrsJ3EGD/V/gXT8sVIvAEgBKBHkYy4DiG0SdvZs095oIKVsg
 h7pc7X8SPtw==
X-Gm-Gg: ASbGnctFK88YoHQaJYJvsmqKhj1VVmNM/1E2VismHINn71rI1OxV7qIQQECuJ359Y5n
 imFPtpCkj/rWVhpQgoDKkhgnZC+bnm9n8wTb4cYI8sRmkmOQVVR/MnyNFjqDqsbmccDfKgW9Wg2
 U7Ktqh0zLRk9Wg5qwHNreXBpOYnd3VkH9yqemj7gxKwN0NeRcJHbAAAoReW5d2VJFvY/68mMAHp
 Ad6mDqeClZyQ7Ac16pB1rEtIi2D4D7KqbhhTJtkoANT1Ut2WOGzbV22+3EHabcYL5XJp99xajR/
 LSVzPXv3jMRb9Uhdi8ibefh2dlBU7Yab9SkML4ZDWSb+dNqH3DV01bDtywy7MhTUfilquoy00lz
 LiPGqkXVi+dlh0BK8/iqih81Q3bZlMbzcn2g/RpX8YvACx113PXH+fiElpbk+jxSvw61t9ExW
X-Google-Smtp-Source: AGHT+IH5E3wc5wHlQSYSl0mVroUeAkhs1XovCn8+Atd2LZ5Czjlzr3ICvgFp2XHl6kTU62gS8zjStg==
X-Received: by 2002:a05:600c:698c:b0:46e:1abc:1839 with SMTP id
 5b1f17b1804b1-46e329ba122mr16536745e9.15.1758768928608; 
 Wed, 24 Sep 2025 19:55:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fbb27sm923650f8f.4.2025.09.24.19.55.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 19:55:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 1/4] cpus: Only resume halted CPUs
Date: Thu, 25 Sep 2025 04:55:16 +0200
Message-ID: <20250925025520.71805-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925025520.71805-1-philmd@linaro.org>
References: <20250925025520.71805-1-philmd@linaro.org>
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

Avoid kicking running CPUs, trying to resume them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/cpus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/cpus.c b/system/cpus.c
index aa7bfcf56e5..6062226d4ac 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -666,7 +666,9 @@ void resume_all_vcpus(void)
 
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
     CPU_FOREACH(cpu) {
-        cpu_resume(cpu);
+        if (cpu->halted) {
+            cpu_resume(cpu);
+        }
     }
 }
 
-- 
2.51.0


