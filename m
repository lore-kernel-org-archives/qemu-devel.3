Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E728D1118E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM2p-0003la-6Z; Wed, 26 Nov 2025 15:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2n-0003gJ-Qf
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:17 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM2l-0002TA-OW
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:17 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47755de027eso687545e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188594; x=1764793394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6h9P9iv/p2bvUhSVVmHLosiz6MFHN9Sri9gbONaHVNg=;
 b=qV5q3Kd8nfI3qzjJdAqvprEQtO+PN3Oh6Lu5k8phYUHuoY38WgDueSW3obAKud8P2u
 8bciPQsEO5wfNGyKpxsJDVCok66emH4Il6t0uhTJd9ZA5K5Y9g/FCRCxx5bT4widMCt/
 YcL9dp76p0inNCpBg/SfJtX3eLWLmP0UDSvgu02IeZuguXLY/uqhR0y4z3Y18SlVyiKk
 mPUXYdZ8LqG0qQPEecRdgiS+0CpV6Csha8r08Ef5m7rfI8GHBBIEGykEs9+/5ft80lqL
 ut07MndY53O0+Qk7V7fU7BXmKTAN7BNYYd4BVxACmwyQN5g/DEJV+zO24r+8qVgY9Qdi
 +QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188594; x=1764793394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6h9P9iv/p2bvUhSVVmHLosiz6MFHN9Sri9gbONaHVNg=;
 b=wiPf/zVJy1lth92kuo2x/RRBAeKU6Mnfu/Q9Fu7av2uSIQD/rpg/4qh4T4uB5AViGL
 AKyT9bn27ggpbDjKNlh+OEWZzBySIfkDY9+5T4DiwBa8sojo05LLsUooYzMROIkXZFj1
 ZzgbdzbjvBTmhMJhKfLMX0II6Yc86thZfA+nknVCF4FHHgeNCOCvyJ2qmgBanLld5ZUx
 6ycTThy9lHJ3z4x4GvECPsh+wvau3n/yd+3DYsMDOlpz/yY+clELajbWGt+RWOd8517f
 RPdHQWfA6rMJPDOhFba1WHLvYqVic19EWGrm+VEX1JpHtVWTLQ8RRzUGs+E52K7r9rJZ
 HTEQ==
X-Gm-Message-State: AOJu0Yxq2pH0Bq1p2LPt6NT3HD+ngLeaHHhz9VrD+VIWnvqM1ywowUiZ
 qu9khh6Gp15Mh/Wf7HqN3hxGqAVN/0j+sBCy7k8rkxKGtCNblBs524zZ7GbmZlitv2kLcj7/o35
 K8kcpqrC1+6Bz
X-Gm-Gg: ASbGncvjPRRvuaa60rznpsbmhtVBMk7h09tJgNchd56yLnIh8Sh7M831aYFc5O83D00
 ty04qmBMJeUE2Zs00smk98mgvZovXUhhiccf+KlcLyAlGslyQeQ8hvBrEthFndXmWFNDzV0DTfT
 3se8r/mgttsV7FLdrFg3PyK0gkDDqqTkNHCJb1aCYD/vNDTDNY45wZbJp+UfCClCFdwl2wXOIii
 wTzbDgZZcwwvpauvMj7NTEW6u6/ZjRpLsWSmFxGURefmOICdbkdG1WJY1jLArQKy/B9EBF46/NG
 uk+Ebb2ZxngPcxFNg0M+SXx9afG6whFLDrQ9rU9Uc9WEuEibDLw7wBQMSM/xpBT/Xez6Lajs9pI
 XEtO7n4On2SKt9eqX/riuqSioMMj57k98OzK8n1EY08yYTcOhbWYShr3bUvqrV3imYDJoAvUecI
 ewtkhP1lyvgpfbZTCOmqMY39ojSfpGGHHSQPNjJcgP6pfwm6eArX4RwkkCcmEeSlUKcFpf3Dc=
X-Google-Smtp-Source: AGHT+IGEB4a8fUsY9oL6v+VZHuR+VkxWKVybhu8Ftb1MCD36QEhJbY9XwPArVBaG4vIVkeWDxSuUrQ==
X-Received: by 2002:a05:600c:3541:b0:477:7991:5d1e with SMTP id
 5b1f17b1804b1-47904b24871mr81746675e9.25.1764188593749; 
 Wed, 26 Nov 2025 12:23:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790add2648sm65371565e9.4.2025.11.26.12.23.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:23:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH-for-11.0 v3 10/22] target/sh4: Replace cpu_stl_data() call in
 OCBI helper
Date: Wed, 26 Nov 2025 21:21:46 +0100
Message-ID: <20251126202200.23100-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

In preparation of removing the cpu_stl_data() call,
inline it. Set the return address argument.

See commit 852d481faf7 ("SH: Improve movca.l/ocbi
emulation") for more context on this code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/op_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 557b1bf4972..669bc84cb64 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -136,6 +136,8 @@ void helper_discard_movcal_backup(CPUSH4State *env)
 
 void helper_ocbi(CPUSH4State *env, uint32_t address)
 {
+    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_UNALN, mmu_idx);
     memory_content **current = &(env->movcal_backup);
     while (*current)
     {
@@ -143,7 +145,8 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
         if ((a & ~0x1F) == (address & ~0x1F))
         {
             memory_content *next = (*current)->next;
-            cpu_stl_data(env, a, (*current)->value);
+
+            cpu_stl_mmu(env, a, (*current)->value, oi, GETPC());
 
             if (next == NULL)
             {
-- 
2.51.0


