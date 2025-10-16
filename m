Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDF5CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mza-0006VM-Tw; Thu, 16 Oct 2025 08:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mxd-0004S2-U3
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MxT-00007v-Ta
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:01 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so6404665e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617185; x=1761221985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pC9RqIYu/OpuJxSwTbOA7/FjgnXnjZkCPpqL03xQwls=;
 b=cgujehRL3kVrOPFBaQJIYMo9/OPdMBuo4nFB71YifidlAJ5avBmivOj01W1N02d8JH
 sMFn9PfxIn4/Ei3DPHQoXGa+FmNoRW2AlwZDi6bJq99dw/MsMRrNA6ShF8M9cOLkRkys
 OUWT4xZymogg7QQzRAnlHqzxrJBHv9D9IVmQR6Nzolb3ZsNx/es7ou1imJb3Gz5oG80X
 7bfRd65ne0WMX72E2fPvbaSKwXMj834ZAS73SyzIPBwr0l+W8x0N3CdhuOxMozewNGbd
 gD3AMl98Vup4gxPwh3zTdS9wVwGSKIwUKJ9yRMB0sIWV4/J8TzVZGyy9z0AZ1aAj/YNp
 zQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617185; x=1761221985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pC9RqIYu/OpuJxSwTbOA7/FjgnXnjZkCPpqL03xQwls=;
 b=dbFLTmweoeNfYYFZf4l7g1KYcJ5Aw9CbhhxLmgwKXPQcxN+q6V/GTEPbufE3HGJ3IM
 coqDpBjzIH80AB2hW51AIQoU5zNZJ2b1Z7geIjzqAZVq/cQwX/0fhlcPlBCe7sFLInu6
 L7vAVesmozGiQ8pQRVHhsHnYlVGl/M2fv0dcKNykgQ+rsng1LNeIqYUCcr5z1dPw/x7j
 Jidd8AKMEjYW1NzSPQ6/JqRnAVOGofdSC7RgKXi/BjdpCdDym041+E9v/a3RBpj+NaMm
 nwZAMkqrmw+wN/SmCjU3cCwZajrzHtpfNN58SGQWNmVhbJ2xbKeD04UHKX8mBFaUe9BX
 WQ/A==
X-Gm-Message-State: AOJu0Ywjuqn0+xJtjzlS5x18qKtvj16xnfTdg7nUaZoovaG7V0PfNphj
 ZPSAtq53SQ/9KrVSsu9YfTXn/HKbN4A2e3zYmOHsHrhCSFUXJaguJkOCJs7pe8RdwuknLd380Gp
 5k6zVnTA=
X-Gm-Gg: ASbGncs+mkGk59oRrM+1urWAC6aNS3PszqypoGT3BqDDTkJ7j+eoDyzMLRcHa+Ls5M7
 81+C2ceNJcrUwI/rgh2zd6Wcacr4yNHmLTWQ7d865feDajE2QZIJp21u8bxnw+Bk72z8dfnbvig
 CASQsU4Q3KQJ1Xoh9VsEcwvQc90OSaZk5O+zSCWRj1hACRZ9mQ70kCcLjl4NrWdb8Kjx5oKvsGo
 f3gtTe/KKZuaHZc5wtld3iaSl47dxddHvhgwCq2zEgY46lRTc3X4j4RmcLh+wR4z3+roEyVXWOY
 ndl2e/XGFRDNDumBplASlkihZK556l7vChcw+47JCHm2d4ukEf0kdrLJjZdbxE9Oenfcm1vFOHP
 jMWirzbf1iBiZPS+zHiUoOm0HyYreu0WO16aqKe6zGqDully7zZ+4KWBQLLoylcnzIp8ZaV9wMw
 ubPDPStN73HAELjZb1eUXfSTg54C6UiXVdz4aOw5fksMfWXO8b+6zBARVIYZNP183o
X-Google-Smtp-Source: AGHT+IG+SUGKjFFVRkk32Pqa//KFWYhWPwwqDAyXYeclhBPEv7Wwsea60LTb9WQZ76u6X4VldmywlA==
X-Received: by 2002:a05:6000:1a8b:b0:410:3a4f:1298 with SMTP id
 ffacd0b85a97d-42667177dd6mr23614321f8f.15.1760617185340; 
 Thu, 16 Oct 2025 05:19:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e10e8sm34477746f8f.39.2025.10.16.05.19.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/75] target/sh4: Use hwaddr type for hardware addresses
Date: Thu, 16 Oct 2025 14:15:10 +0200
Message-ID: <20251016121532.14042-55-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
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

The CPUClass::get_phys_page_debug() handler returns a 'hwaddr' type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20251008064814.90520-4-philmd@linaro.org>
---
 target/sh4/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 4f1e2072296..55ab1dc9947 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -325,7 +325,7 @@ static int find_utlb_entry(CPUSH4State * env, target_ulong address, int use_asid
    MMU_ITLB_MULTIPLE, MMU_ITLB_VIOLATION,
    MMU_IADDR_ERROR, MMU_DADDR_ERROR_READ, MMU_DADDR_ERROR_WRITE.
 */
-static int get_mmu_address(CPUSH4State * env, target_ulong * physical,
+static int get_mmu_address(CPUSH4State *env, hwaddr *physical,
                            int *prot, target_ulong address,
                            MMUAccessType access_type)
 {
@@ -392,7 +392,7 @@ static int get_mmu_address(CPUSH4State * env, target_ulong * physical,
     return n;
 }
 
-static int get_physical_address(CPUSH4State * env, target_ulong * physical,
+static int get_physical_address(CPUSH4State *env, hwaddr* physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type)
 {
@@ -433,7 +433,7 @@ static int get_physical_address(CPUSH4State * env, target_ulong * physical,
 
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    target_ulong physical;
+    hwaddr physical;
     int prot;
 
     if (get_physical_address(cpu_env(cs), &physical, &prot, addr, MMU_DATA_LOAD)
@@ -800,7 +800,7 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPUSH4State *env = cpu_env(cs);
     int ret;
 
-    target_ulong physical;
+    hwaddr physical;
     int prot;
 
     ret = get_physical_address(env, &physical, &prot, address, access_type);
-- 
2.51.0


