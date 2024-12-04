Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8545AE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvxD-0007Z7-C6; Wed, 04 Dec 2024 15:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvxA-0007Wv-R2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:26:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvx7-00072d-Ro
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:26:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a752140eso1302345e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733343988; x=1733948788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6SfGh7GwB5WuWE7gr65NVDyXlneJEDYoQOKqsCWiWk=;
 b=sT0hZJDC+GwnGQlQVDh4fYQpoLq6MW1ldnlYoK3cSUxFKXPsAP/IYMRrnC3FqUQNkh
 NpVUxnTZox4Z9SEnKyJLsjNjivPPUOyNEd8MyEkRxV6n313r5PKGWtLR/gvbGKw2jMNc
 rf1mxdU3zEJlBqd0iROokOEhzLpTzE7/dXWus5vrqRfrXZsbk2VMjOUBuczuHL3w2mCB
 mbrz7G2Ur8xbot9vcZ6rcawkxpo42Hi4fmm7VU/yfPBUKJ1RoKS3AMM5rJhD7zx8NMYv
 Zd92TCeELqglX2OasuGl+anxG5rRDyU3t/ObbABb6D6rcfNmwtSU8VRCdnVp4tKFeWcB
 qDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733343988; x=1733948788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6SfGh7GwB5WuWE7gr65NVDyXlneJEDYoQOKqsCWiWk=;
 b=ZDAaY/XpVPpV1BAGlRx/6IXfnELSqW2tUjUFvH2ES+KUgiX3IQQZHGvnFKuDQq35v1
 Izz+IZBROBGxuk5E9uXrIUZQCObwrxz7KyUjmp8XEHN4+eYKGcuBAY5V+J+fDz98ANzV
 yeX5MlW99V89/K8WEImYcKAF88Rv7cKgSmdTnTNRKYQMTlKL1VuCTBvQohfzBqXQG/e5
 0GaGeqEV35ZPuUF1MQfdRUjqWFBZIVwS2gd0PoIQ8cbIkSx7P8MLo6K9RxwKd1KTJiaI
 p3GswXgioo5lyUozgN4OppDNmipz9kbIX1x1HyPiy0fftTypYWD+LDtdxj0iK4+iOLcP
 K7wg==
X-Gm-Message-State: AOJu0Yz8usSy51OGalV2ofDFOrIQKn71uHy+epR5jKcWXB/Gh7A+1hUO
 d51wjBDAEzsWncvS34RbChVA5adMCfAmd267Dq6r7DwV/svq4NKs9QH6+waGvWJ0oYZib2u2UC6
 o
X-Gm-Gg: ASbGncvbZKSRLVH4PhA+TaLq5Pp1h5elI2Q1xEKCtVReksKOgluVeixaTnYkzM3poek
 w8RKnJrEXbONoTNLYdBy6IcoXZTTrBSqp17MuViDrpnvkSwBxGlw939lxyirgJ72SxJJPCK11xI
 ZLvNHrbv1gFFw0QpqOnZ+5TfopJOVmv89KNLZWN4zSb5LbWx8aHgNqSOr2isdawJLOsJvGpKJus
 V51oSqCoWy/gc825fbGxJLs2Ce0VpFuiZvEQtUK7q4nJGSmyTIyd/LQnAKSRGlc03DbCrdTS/3S
 bxYMEu+STe/FAMyG9WQCHFnC
X-Google-Smtp-Source: AGHT+IEOHgCnajvpNJwxbTXBPSEWnBrXE5gN7EA5gyH/dJhw50wp4GdKdH99KUQbUu1SHNqfDE4veQ==
X-Received: by 2002:a05:600c:1c07:b0:434:942c:145f with SMTP id
 5b1f17b1804b1-434d0a1cdb5mr64737145e9.29.1733343987773; 
 Wed, 04 Dec 2024 12:26:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dfb2d7e0sm16066857f8f.44.2024.12.04.12.26.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:26:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/20] target/ppc: Register CPUClass::datapath_is_big_endian
Date: Wed,  4 Dec 2024 21:25:46 +0100
Message-ID: <20241204202602.58083-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
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

ppc_cpu_is_big_endian() already returns whether
the data path is in big endian. Re-use that,
exposing this helper for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu_init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index efcb80d1c25..9650acb4850 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7285,15 +7285,15 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
-
-static bool ppc_cpu_is_big_endian(CPUState *cs)
+static bool ppc_cpu_datapath_is_big_endian(CPUState *cs)
 {
     cpu_synchronize_state(cs);
 
     return !FIELD_EX64(cpu_env(cs)->msr, MSR, LE);
 }
 
+#ifndef CONFIG_USER_ONLY
+
 static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
                               uint64_t **irq_counts, unsigned int *nb_irqs)
 {
@@ -7407,7 +7407,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
-    .virtio_is_big_endian = ppc_cpu_is_big_endian,
+    .virtio_is_big_endian = ppc_cpu_datapath_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
 #endif
@@ -7455,6 +7455,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
+    cc->datapath_is_big_endian = ppc_cpu_datapath_is_big_endian;
     cc->has_work = ppc_cpu_has_work;
     cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
-- 
2.45.2


