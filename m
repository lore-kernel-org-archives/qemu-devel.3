Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFB8CFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMclN-0001Va-JF; Fri, 21 Nov 2025 20:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMbRo-0005jG-P5
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:25:55 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMbPl-0002fW-N4
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:25:49 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-37b9d8122fdso20479331fa.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763771004; x=1764375804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQ3G/f5z9MwEGa9QMBSOfQ0OhqIrmAfETxxhBlriST8=;
 b=Z73HXqDlrfLyQu+y4dXSyjNBdJjh6a4ZU0dwzunro+MOhY3lg32AQQ0CncnlwoCbxW
 2d54fLQLDl69gM/7MVvS2IP7/qGVP31tYshd+66nJnuMx3PI5io78OBqAmDN9/Rj4AP3
 H+3NQSjoH0daHiHu+T9ROQviRiWc2AppvGFD3g8NJXU+mWDatF2EcKwMqBAeePtc7oNr
 1LA15+slrKTBRjOb4BFkzuhryzAHpU8Yd96nsljRd/uesSyAN5yh2A9kxu0dAEgyhDRP
 qvtKWliTy5QOJAWc3VAK2ExyyKQ9ft+EUeuk3MiHDXQfHmuqX2nopYc+JOSiFlYdZEFS
 HrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771004; x=1764375804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yQ3G/f5z9MwEGa9QMBSOfQ0OhqIrmAfETxxhBlriST8=;
 b=iY5X0IgsrYUvFO8vy2+PkZa1a+BA74PgSOYTLxPPkP/lkjsxBVL5sbO4M9ety3cUr8
 63qNqc7g3EKfUt6QeTmcAjBfHIhOUFZ6zEwU28GaTWXV2N9WT1cxawMebJV/oCmeE553
 ejtsPAnqEdfY0qbWxq7WTUX3x7sSLnFI6fUEbSaPJsAF7CQ+yi7cLXB9b0f0jQi9OABs
 gm+whHtcDaI/MP8k60ko35w2Lyyr3PGDakTLIa+Av8DApg/n5ySCmFDXi6V2dMClHekX
 xswjnnu1JsAtsIBN0XuwzqalpONjfHam5LXDQdNBUpFuCBQOu9hg7m51SsqgQhjapP1N
 LwKQ==
X-Gm-Message-State: AOJu0YwwUR4BfMYMXB4XKVnB5X4X96mdKGnfPU7oPLwQUS/8z+WGwAdk
 C3fj44Ea+HTjZ02NJ2p5g3BL0Bk77Z1intzs0Z/tsGK0qF9UlC+KglKbazlYRt5dCZ1hoXNdB5k
 EfPMOphkS6w==
X-Gm-Gg: ASbGnctu/NVVVK3F4Bb2Mi+f+StWsSR+KNQj7dQENRnidxHImEBowLc8zeNb9+TBLcW
 peABlqSlikQrMgAhaQ/L/QrivUMdBrPxWKZ7vvLVaeUWW5Wn0aBkss+mDO436lxRZH8WT1UtSqW
 /qOT3X6/GV9EDKViwkd+QujEGHk4Aooh537KF4zeCMBR1Pr3vYyzpMzYcjxz6GqgCKvs6pGSpvG
 +LPF2URVQXNz7Wu5o7klTTZNmScDWZ+AMkqjbhRJVPBawdG9aNe6laR3QvdqkydAnaMHJojFE39
 kB9YKZ6ZsmfEu6w4Q8Tyh0oD4COewNwLB7ca0vo3e0pDCRxXQIUNOGJC+Bbn2UxfUnUAMq/xDj0
 XdtVAxdQwML9g9gbgxg3W2KzMZN7piTZnSx0wgZCjrl60uq6nG5YODF6doemdcr/BP3cQhMn7cH
 3x7jUB6tWrbDGB9EgHe8HBEpX7J3wL67NLcdsH1xPnc7mPYm1Y//8k3rOtzugY
X-Google-Smtp-Source: AGHT+IFbF4f4MylMWtflv3T7K6D1FOB2iY1tVyDtTNkEg2MW4/BeMV+80VdGErsxIt8RwoWpfU+jzg==
X-Received: by 2002:a05:600c:4684:b0:477:9c73:2680 with SMTP id
 5b1f17b1804b1-477c01bf658mr25170915e9.23.1763732831887; 
 Fri, 21 Nov 2025 05:47:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1e872esm45046375e9.5.2025.11.21.05.47.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:47:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 19/21] target/sh4: Replace cpu_stl_data() by
 explicit endianness variants
Date: Fri, 21 Nov 2025 14:45:01 +0100
Message-ID: <20251121134503.30914-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

See commit 852d481faf7 ("SH: Improve movca.l/ocbi emulation")
for more context on this code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/op_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 557b1bf4972..63515cc5e6c 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -143,7 +143,11 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
         if ((a & ~0x1F) == (address & ~0x1F))
         {
             memory_content *next = (*current)->next;
-            cpu_stl_data(env, a, (*current)->value);
+            if (TARGET_BIG_ENDIAN) {
+                cpu_stl_be_data(env, a, (*current)->value);
+            } else {
+                cpu_stl_le_data(env, a, (*current)->value);
+            }
 
             if (next == NULL)
             {
-- 
2.51.0


