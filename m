Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7067CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O46-0005wu-09; Mon, 13 Oct 2025 15:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O3s-0005gb-3Z
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O3o-0001pq-Kr
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso39713745e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383099; x=1760987899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yFEI1kGhRN6aaxid2CLTaTbl1TgQpQbBIzoQ3rTUwW4=;
 b=kNd/J7vo8V6QCOQ2NZNHpHs6zMKEo+foVZm20oGiu6K91krpnlraqSBh08daeGtSI/
 e9O6UrPUfNSFRei9QbbcdfF9A5nobb8dca5ROMZsGQB7OJZV0IjaHLhN1mEeXC4zbJ/j
 lNv14ztyXbfRHsVAOqNr9nK3Ks00SjuUaabC65ZK8CGU+l1xQgd1uSN5X1Cu3XVzi0Il
 5bCtwjsDCyVLyjG5nt/owjx/zPTdKGMNkjVXtj8SX0H5gi1twH0n3Y4xoLzVsr6J1qym
 dtIbp9iQgXgDIbCvne8YRwKWzZRTiTBOVlrqZNg2wUWwQIwQBqIfb1bTlNcmiGuXlD3W
 YBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383099; x=1760987899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFEI1kGhRN6aaxid2CLTaTbl1TgQpQbBIzoQ3rTUwW4=;
 b=g5cLdNOLrwsKXIkcEIzbClncACXGVuQiIIQEGXm7XdUhpowYAMtHVKUiGbCdCgkDv0
 YexQnUYMDjc6S80WH4Jf0Qk5ZOrfYxFwG4g9ECV5lr3/ISmb+d5HVV9ObTLiCtLhk5Co
 lkF6O1GgcXaSmGJgLUXP4+eRRO0R0XdciR7VsUF123RCWnOlOg0LK5njKOrmFBduD5SJ
 gEXWAVV4SU3Io5TwbeRR+bB3GxPHW4oaRvQz5u8vWhWyenD99w2l31gzur/03v6d3H6w
 abLtYMWDdOSiagb9UYiWf3s3tvZRTFxUAeRvmyfN/Rz87AVUDAt7lsDZf0U4+dPqLTu+
 CxiQ==
X-Gm-Message-State: AOJu0YyCoBZdijqav8SXN5pIQrgSLtrdCeVUWvwnwQrgngK90c0t6MOZ
 BfiI6skoxoiy62zHWKFXzjU6eqLzb07Mr/vmxpawW733oahgphDT8a/143NfHDYp2F3ue46GEGn
 EJ+SYOUIydg==
X-Gm-Gg: ASbGnctf0runYyNKJy7DbWPHb3UiOGmPyRYdT/4Oc5swkHldKAKgEavsoiqDE+ZAI1y
 PB5qnPv2+iD/EmVqJYrhiDa1/BW8XKYmET1/MyML/xs4dQnH9TJw0lqFXlyXn/Akr6buKnfQt9P
 OyRp13xoEynN08KV+T6MBC0e18K/i+D0/hk03HJQKXsUEo66GzKuSd9Tl7e3fpKy4dmAfbRE/2w
 Y9p7n9q8FXRl+yXkAUAM7WVI7jAtk0Jqp+ckuvbXTS1ZauDh6DUHmfkUJlxznam8B3XCp6eoNfu
 SIq6O2iDUsC5BkH0a6F0DRy99raiiw9QWWWoHAfLBpDOTCIftUmk3Nfg6awlLQizCDVWEgwalqc
 eF12V49XpgniwdLMcGIzUTO3EzSGh1ubBEe8nnXWZxYXsqraFBxIC+ywg5JQnTsn4vPO5cIYvfP
 5sK/NnxLeFw7KCQ02EUwI=
X-Google-Smtp-Source: AGHT+IG4SpoIqMIxX+8zL8jnXkriNkz5+rO7968hRKfgCS7QmpcEhY9oduMIAvQdntCAz+dn8elxOA==
X-Received: by 2002:a5d:64c5:0:b0:3d2:9cbf:5b73 with SMTP id
 ffacd0b85a97d-42666ab9929mr11268632f8f.6.1760383098653; 
 Mon, 13 Oct 2025 12:18:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426e50ef821sm4964802f8f.38.2025.10.13.12.18.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] hw/ppc: Do not open-code cpu_resume() in spin_kick()
Date: Mon, 13 Oct 2025 21:17:57 +0200
Message-ID: <20251013191807.84550-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
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

In order to make the code easier to follow / review,
use the cpu_resume() helper instead of open-coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250924173028.53658-2-philmd@linaro.org>
---
 hw/ppc/ppce500_spin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index 2310f62a91e..bc70e50e926 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -99,8 +99,7 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
 
     cs->halted = 0;
     cs->exception_index = -1;
-    cs->stopped = false;
-    qemu_cpu_kick(cs);
+    cpu_resume(cs);
 }
 
 static void spin_write(void *opaque, hwaddr addr, uint64_t value,
-- 
2.51.0


