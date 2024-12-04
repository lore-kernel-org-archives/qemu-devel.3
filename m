Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209A1E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvz0-0003AQ-2J; Wed, 04 Dec 2024 15:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyu-0002hZ-Dc
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:20 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyr-0003Af-T1
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:20 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so94661f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344096; x=1733948896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYu2t8Q4K67n2tT9qceLBDjYsH4wW4eKuLgzo6hScDA=;
 b=dYzfBRLRD0fTFjAs/fq+wBKrnGNAcuIsmmF9jx+5hXU9q1WJqKwu+BU22g+J5hz2bK
 wvTRrdWnfUpbFTG2A5u4fIPWDLH78sA+ILOFpplm95ziB+f6c9m4MUJ0lbaSQi3QO2hU
 JAXbkfqVeMHntqr95Uobu2aWWwBz2zUC1lEcpP5b7VZW4JhrdideLaZAspjQyoiG6uBq
 tMPahGblKgUttfwvDsR9DcejxlDwnLpPGUFANVb/HvQ6teM4/m2wpwt/P00+1flVF1cT
 GljokPxb88LLkfWcFLfJ1yPWyDfzWvxzkmZ1olLeRTajfv+Lq3pMuyhHcDoX4IdsA2Sp
 F4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344096; x=1733948896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYu2t8Q4K67n2tT9qceLBDjYsH4wW4eKuLgzo6hScDA=;
 b=f+wen5WAmiVTaxXjCTTQJadwLQ4McfiHy2c/MKZ/Ko47JItkgUedtj0sjaer7lmaXz
 +q9M4u/JUTJK5iZQKY6k19WxysVbSERNVt1Z+ilm7T9aqWc3LmCxgT1iNjmtPBgJveR9
 nTwYRJvLFibQWtR8d+vdK3PP8KQioFYHmzagz1h67wRGjGTjoJeyomwePrs66umOmz+x
 6Xq7z2gf4whjavAiFJrawmnT2ctAJPtF5GpUFdcnfAqYvzwmUvSWkmIC7s1RDrn17nAD
 TZXnuzHB8wVFoH4EObdqBNtj6ANUNipgrlEb6tg239zWu4Y4x65nm+XEICXxxwqVchsC
 coxA==
X-Gm-Message-State: AOJu0Yw8sGEuBonTr7QDQOewkD27MNj8MIzVLU3iwV/paCd51e0ujDXy
 fip3CEb7bUC5T6gaSvHOqduYiCWYncvhkTueEHEJ9TeQUPvxZ7EO+F76I3Z6HrTy1+YJRYHhhu6
 0
X-Gm-Gg: ASbGncspeikuK7QC1w1WP75wPBIGG8TSV64PhgZBd8+j47b+fhYYAGQFkFw4xvdCAZ2
 ONBeeOwCE09bYOhOEqTWLY4zKbfkQewjM62Yooq1YOPyVanYYxFdFp5SOU07q+jr9ENRW/KJDi9
 N3dMpruxGU/2kM7t8e5IwswEDbID10PwMXsmiklRybMQEw79+nELKKfxOPwwI6VeQQno+XksRR4
 YIbKPMH/0Pyx0Z3R8jInqWBJi8K/TwIsKimpIkxXlROJibi54Wml3ajG/CheANYRnaJ1dUj6kmJ
 odGCZQEjDFz2XjIuGhWfZ8vb
X-Google-Smtp-Source: AGHT+IF4snyZRj1x+fZto74C7GPyLBpTIZREW05o8Ez4NAPz1TUe9+xBdT4v+C8HGPWrLN9B4UYDYg==
X-Received: by 2002:a05:6000:1acb:b0:385:fa2e:a354 with SMTP id
 ffacd0b85a97d-38607c23f80mr5121998f8f.47.1733344095986; 
 Wed, 04 Dec 2024 12:28:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527e287sm35412065e9.12.2024.12.04.12.28.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:28:14 -0800 (PST)
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
Subject: [PATCH 17/20] disas: Use cpu_datapath_is_big_endian()
Date: Wed,  4 Dec 2024 21:25:59 +0100
Message-ID: <20241204202602.58083-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
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

Rather that using the binary endianness, use the vCPU one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 disas/disas-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/disas/disas-common.c b/disas/disas-common.c
index 7377de0715c..ef91c43449e 100644
--- a/disas/disas-common.c
+++ b/disas/disas-common.c
@@ -7,7 +7,6 @@
 #include "disas/disas.h"
 #include "disas/capstone.h"
 #include "hw/core/cpu.h"
-#include "exec/tswap.h"
 #include "disas-internal.h"
 
 
@@ -61,7 +60,7 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
 
     s->cpu = cpu;
     s->info.print_address_func = print_address;
-    if (qemu_binary_is_bigendian()) {
+    if (cpu_datapath_is_big_endian(cpu)) {
         s->info.endian = BFD_ENDIAN_BIG;
     } else {
         s->info.endian =  BFD_ENDIAN_LITTLE;
-- 
2.45.2


