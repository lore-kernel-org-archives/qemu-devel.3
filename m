Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F723C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvFY-0000VN-9C; Tue, 29 Jul 2025 21:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCY-0003Fq-Jj
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:50 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCW-0004jm-IX
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:50 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b3bdab4bf19so323122a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837307; x=1754442107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43YL6LeHtMqajzX1/nmmW+RggwtVTRuMuUjwY036hyw=;
 b=L5aD0G/9r9PBakSsOxWpBdHL8AxuGsJ9zEFW8HMZedSdUzrb0dVf9aIJWC7HeKnohA
 MDc3J1ylRueTBWYZAlt8LGQ02h0nEfDc5vDKk5n6Kx8wDMazSCErq6SzkVazlo8HDSIW
 FNHZIcE+TZba1XRJq4uNjmNEqaW5NDz5411S0o7ICdaNVNb6SQ3DZskt8huNq+bN+4jC
 O+zqB3/eBIgeGjfW4rbV+EXzTKDTKMLPexUDks4W4sidP/+4lqrAQ0HqBRHlfccXvsl0
 HgKKVgH0994KofWaQL/wLTpYNRw4XxADQGronSJTCFGj0aFAOuh7420GMSFsfkCNU1AO
 ihtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837307; x=1754442107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43YL6LeHtMqajzX1/nmmW+RggwtVTRuMuUjwY036hyw=;
 b=lnN7eK+8ikWQoaU311xJhIHS4uqovdRUAMvEMFPuBd1E/QV5qlHzJKKVkHVZZdO4Po
 EQgkjoPgsQ/5tFRok04OZILmL0YvugggAhAGiFTJiKfSkRNXq8LvlqccLK+gxUD7QDrL
 3wmm5+cYKETiuAMzrtEJ3LlnuQ43/YUDdJzqnk6fHb0FdJj8fsDHERz5EICulg6MLptb
 gLRE907EXy5GIGzWtFUw/CULEc521GrrikCs1dBNqbKQz84aUrSVM5M4uik/OCRROAyK
 /FPnzIPlzkzGKcTqI42kzesdtOps4eFHtqr0EfeM00bWVi4SGqTtE8YTh5zlwtxX3iLc
 bqsQ==
X-Gm-Message-State: AOJu0Ywn1ghPlEkxt0YbxasJQDVGA/GIpXtn0CSl1n9NXqCpFYCKeOEV
 CBrZq5crJfxo3E6de7I6v69UOeSForpHWFhvT1+HzTDFS/F41NbU+O7l+anShw==
X-Gm-Gg: ASbGnctI8ngPRrI4qmtZHQqYo3h2PdRIeCtvWEipuFiHCr+FcheU4r1t3oV2ZfhjSZt
 DIbIeldB0+mRrG3eNqFapWwGNdcNMK36xANa8fMWKE985QCox52JNNy5h+/6DtM2V2OJzdw/qUW
 Q6deagQk3UsEujYr2zF6J0K8SlRFTaJXHdpgu06SWm3vEPMgJHEb6hENmz4HCbwSHSk96dAwcSD
 jMNBCL7C7h86HOIZ+rnyUa2OrFpzF5pY00XWPakUn8WUXsYvr89UdO14FFXmBz8YSRxxQEi60VL
 CZu6ljPRi/T6ACjWzpkqx3OgvwZDKHAgP9m1oxuO3uEnBxZyp7+nE8QlB4cie40OJHKQMJEo4ba
 Voq+XBxLdykqNI8dNRWFmTsEN+9Z71Y5rRzGeD2x9S6+Styh2PauiopNpc+f50ZfUlYSrx/FKKw
 k/DjFUpBuTp6638bQkX7CRTEgy5Zg=
X-Google-Smtp-Source: AGHT+IEI3I4Il2xuj62KHbRQG9fdomHh71xX5e4C21oq9svbfkQV2Ms7qbhtAy/GUyTL/cW9dgih1A==
X-Received: by 2002:a17:90b:57c5:b0:31f:12d:ee4f with SMTP id
 98e67ed59e1d1-31f5de6b9b2mr2015554a91.23.1753837306655; 
 Tue, 29 Jul 2025 18:01:46 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:01:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yang Jialong <z_bajeer@yeah.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/11] intc/riscv_aplic: Fix target register read when source
 is inactive
Date: Wed, 30 Jul 2025 11:01:16 +1000
Message-ID: <20250730010122.4193496-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Yang Jialong <z_bajeer@yeah.net>

The RISC-V Advanced interrupt Architecture:
4.5.16. Interrupt targets:
If interrupt source i is inactive in this domain, register target[i] is
read-only zero.

Signed-off-by: Yang Jialong <z_bajeer@yeah.net>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250728055114.252024-1-z_bajeer@yeah.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 4fa5f7597b..a1d9fa5085 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -628,7 +628,7 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
 
 static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
 {
-    uint32_t irq, word, idc;
+    uint32_t irq, word, idc, sm;
     RISCVAPLICState *aplic = opaque;
 
     /* Reads must be 4 byte words */
@@ -696,6 +696,10 @@ static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
     } else if ((APLIC_TARGET_BASE <= addr) &&
             (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
         irq = ((addr - APLIC_TARGET_BASE) >> 2) + 1;
+        sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
+        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+            return 0;
+        }
         return aplic->target[irq];
     } else if (!aplic->msimode && (APLIC_IDC_BASE <= addr) &&
             (addr < (APLIC_IDC_BASE + aplic->num_harts * APLIC_IDC_SIZE))) {
-- 
2.50.0


