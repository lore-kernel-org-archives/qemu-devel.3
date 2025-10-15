Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3EDCCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95ko-0007dR-NK; Wed, 15 Oct 2025 13:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95kn-0007d9-8Y
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95kl-0005T1-0J
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so58143155e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551050; x=1761155850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9t3e/KyULfBPeswO6U630O9UE06JlPP7NTUsO6O4Tg=;
 b=BUfNm6sVi69scjZwNzgBYtYYrdO1SbWpY4iHTWO+KwicIAYrfUIHg8fLVdB4miIEmN
 TOVJSvBV+yFcQCteEKwtOXgNUUiGjz46LZ3XwLhicwCIO4SJqYO7n4CY5z12Na8b28m0
 ZSS4XTDOoNnD4xu9nPTusZX3ofHVenMqz9P0GpAMkSMgzWMIok52d36eQE9dp0xqwQl0
 plQzIrqnBo/yeqUTiRH04h1u93V8JTrSNT2ttJcXGE0KEqbrX6Bky3QWx8kUDhhzpabn
 GQsw3HqQocH9tSBhyV9iW5qMhuksOQIfvHJmiuqDIwmVjTd/e/QsLxv/cZfj96YlFMQ5
 HXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551050; x=1761155850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9t3e/KyULfBPeswO6U630O9UE06JlPP7NTUsO6O4Tg=;
 b=pPlViIHYMpC3/UDXbyuOq+B0b9tI7Wn9AwMyk/NpYQPScdBrRNKiy2dWiUOVhHm+ds
 ilRFu2mGPNIsIxmVeIk6na2JzOeiJkxnR3D2+FdUh4N97Ugk3DUqJf+KtCSmdZlf6a5q
 Sc0JeuM1uITF5VejF+3zqmWwAZrJwtx2Biua22XpQpdz6Ku4j8nIZ81afNxyXT9MYxW9
 wLZxiR8GmMHZvqxZHm28ZKmkjMuwlHBpLCTklyhMF1vAhvZCc22/Ijs3cwvDdbTcR/gi
 DryfZcPjfwV2X1SIfRAPPQUwMp0CmnMnPT2YRjEwsg8qIPK+sIxt+hDFjlRZRrS01c2i
 vzTw==
X-Gm-Message-State: AOJu0YzSf6CJzTadFh7LjoH69ROfH13co4PosqCLnKQiLW8yn2zeaOLi
 C0PR+x+ZjSssusuyju2n9PaIyifaPG6Zk/nd5e3kBr8bjniMuYYAnA2skSgblo88UOR1+LOcXDD
 qyxMwSnOmoQ==
X-Gm-Gg: ASbGnctCbjPtR//7p9ZDCNjnrHQ/DeBQysnd+rfKwRrtvtyXh9AnYou1gb4WCR+ikrl
 WmGgKLFWQHsF1wZv6CisE9OAx6rgZ2j+E3Entg3rslrvLgMJ63xAf4FZf2OLuFdy46l73unM5qB
 3WPgXADbqcXeIMFkYI+ygkQhQszK+gjBsKD1bHSII+cbuHT9bj0frI92aCzBJ6FxeM/vXpm6Z3v
 lLQbAQgMO5lBiHdYybG40/6kCjAIEa/KkMeUbglvsm7IT/4VQspmz9hAiYoPZHYDdOnH6jPJBmx
 h050RyfMM4vaumPZn1tm7DQGAfgULAtSK/ktjLWFMapUJMewhTZD9pjNcX6W/BSCGY+VPn04QU/
 jVBABipfxFPZiPJnJYx+O7LG+YR2qyjkB7VbBN1uYiLnc2QGDshRM4+jsV1ICd8GVXXsb66Ssg4
 flEfx9gIpEVv7rss+y8dAEvW92fqZgmsXPnD5K0Fff
X-Google-Smtp-Source: AGHT+IGqgQWfe/egh3Wdd2AGMMIdnIOdq9GKdxCDso6DCiDN2raIdxY2BtsmciW0F8SUNidV/1bvIw==
X-Received: by 2002:a05:6000:2c0c:b0:3ff:d5c5:6b0d with SMTP id
 ffacd0b85a97d-42666abb559mr17497104f8f.4.1760551050100; 
 Wed, 15 Oct 2025 10:57:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101be3468sm41805785e9.2.2025.10.15.10.57.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 10:57:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/7] target/microblaze: Remove target_ulong uses in
 get_phys_page_attrs_debug
Date: Wed, 15 Oct 2025 19:57:12 +0200
Message-ID: <20251015175717.93945-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015175717.93945-1-philmd@linaro.org>
References: <20251015175717.93945-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The CPUClass::get_phys_page_debug() handler takes a 'vaddr' address
and return a 'hwaddr' type since commit 00b941e581b ("cpu: Turn
cpu_get_phys_page_debug() into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/microblaze/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index ef0e2f973fa..cf577a72268 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -274,7 +274,8 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                         MemTxAttrs *attrs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    target_ulong vaddr, paddr = 0;
+    vaddr vaddr;
+    hwaddr paddr = 0;
     MicroBlazeMMULookup lu;
     int mmu_idx = cpu_mmu_index(cs, false);
     unsigned int hit;
-- 
2.51.0


