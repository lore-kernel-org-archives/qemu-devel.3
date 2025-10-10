Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8020ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77Dy-0001dp-WC; Fri, 10 Oct 2025 03:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Dx-0001dK-59
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Ds-0007xT-1K
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e52279279so11653615e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080043; x=1760684843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdXB7ylLc7Vhz3ZaX5Klsde0ekKLRZrXew/WW8Z5jnE=;
 b=fRXuKAA9IIKverx769MaAU4ZSW12xMIjRsn6sWSnM62lzY6UOmHo+RETeqs892dH7A
 IoqkNtb8JkiyrJZbkvJFKjd7Awno1iFbwNHLWcf7/W13H6AJdIuGHZPaaHpqJ5PIDxPQ
 gqfIiOz5+xnfKNyw2bwVscbp2/3Le0D29fn9qcRi2IkD7S++sRyNJp7kwT5NTGGvxM1b
 OZSWYfhnzK6iePmkbw4TnA1qGYlCXhyYsoa486TdQpTwncACc/UFQ5D/ITJpAJC068j5
 aoif6UGZEfJ/grGMfT7CxKBXS23cmoolfDF7BP4AjjNJgwW5/lJiGNdNjbunlTyCY0pE
 aICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080043; x=1760684843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdXB7ylLc7Vhz3ZaX5Klsde0ekKLRZrXew/WW8Z5jnE=;
 b=ZbvbNJRjhnBVP7UVJUq3dvEL0Ik3+ai4bC2x2pbfG2CmAzH8Qs+JygcJ1zQRppaXmo
 v/9UdXioD9yUG3KCAaSjJUtpLPu1DUWapTPFm0KS3szZe8tH+0bsBpCyA7aL//KL40KE
 QaZH8gMTuLTFh8bOFKo86lx7kZ/RuapMN1EUqmrhjIyVjaY/WtKgsBfH0JH9BDwyKEQq
 dLlM0Fr7gTWZ6A7sVL5HAYsBrgd7zblJcLc86HyauwAdaQ/YTitWwJSjwKKcXadFOJ2q
 zZzTIKw/+4e+tUSuo975vMGJdInTTKJHAl2pGrAUEnD0HfqvybIUHg22spy+2fjotszo
 cC+w==
X-Gm-Message-State: AOJu0YxQvy3jMOs0MhGLm7+RnYy3CDAC632e2H83aBO7lx60USguSCoi
 CkGSYfdhDQoB3EMSCdeLzgj2BhRp0OqVdWNEkUCoy0O/4ZQyUpP1M0yWe2Yxx75L/3JPjfjTTl3
 YaZzNvyMSWg==
X-Gm-Gg: ASbGnct2pRLreXYw7dEcic76BqS7v85PrHWieSIXGbd+WfhoX3SasbQlbuHoRtOtksu
 GQgKGUfFEiONMMQO0bCSok/DSi5P0Nn9ZUC63d3OWG3+epq/AbGRu+FYzMXWUCjxAeBm7Ffr48R
 mtsV/AMo0BShhNYVf6BWBIn77nYrkHdrTiYkgpfbUDMEL/Kh7msQNSDyj29wHA1N/WxjwsN1OAT
 QrM2DgkgBo6DySoXfWOczoZL+8ba/l8j7eTEwypY7n7M7Gk84bzybqPL1lV4hynGP+6IJHJVgiC
 6Wy8V3frzRQXIGaM6q1RlMqAJ+RJBnMUQQ3mEHlx/TwDZGfP2inTasTqw+DEpq0Ph8tkHXjz/5s
 QutReX3l3qx00BqGP+bTdaRAC8odVy3HLEcmPFpNprZ3mFt26t7Kiykv1VHPQbTbmo5GKFD/pwB
 ZgomJno+vehWU7pTP+Rvpm0o2z
X-Google-Smtp-Source: AGHT+IGnMlG8AVlvQ3dQHjGkrHdxEmcdXTZ5LQFOn7/LfrfBqXqk6k3FNJlW+0ced2X+AYg9kUydDQ==
X-Received: by 2002:a05:600c:1395:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-46fa9a9efaamr72727875e9.9.1760080043573; 
 Fri, 10 Oct 2025 00:07:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3d438fsm54961675e9.2.2025.10.10.00.07.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/13] target/openrisc: Remove target_ulong use in
 raise_mmu_exception()
Date: Fri, 10 Oct 2025 09:06:52 +0200
Message-ID: <20251010070702.51484-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
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

TCGCPUOps::tlb_fill() handler provides a vaddr type (since commit
7510454e3e7 "cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").

Do not inline get_phys_nommu(), rely on the linker to optimize at
linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/mmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index acea50c41eb..ffb732e0d1f 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -28,15 +28,14 @@
 #include "qemu/host-utils.h"
 #include "hw/loader.h"
 
-static inline void get_phys_nommu(hwaddr *phys_addr, int *prot,
-                                  target_ulong address)
+static void get_phys_nommu(hwaddr *phys_addr, int *prot, vaddr address)
 {
     *phys_addr = address;
     *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
 }
 
 static int get_phys_mmu(OpenRISCCPU *cpu, hwaddr *phys_addr, int *prot,
-                        target_ulong addr, int need, bool super)
+                        vaddr addr, int need, bool super)
 {
     int idx = (addr >> TARGET_PAGE_BITS) & TLB_MASK;
     uint32_t imr = cpu->env.tlb.itlb[idx].mr;
@@ -95,7 +94,7 @@ static int get_phys_mmu(OpenRISCCPU *cpu, hwaddr *phys_addr, int *prot,
     }
 }
 
-static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
+static void raise_mmu_exception(OpenRISCCPU *cpu, vaddr address,
                                 int exception)
 {
     CPUState *cs = CPU(cpu);
-- 
2.51.0


