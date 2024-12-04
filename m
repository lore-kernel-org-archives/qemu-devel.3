Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1C4E77171
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvyN-0000ew-LZ; Wed, 04 Dec 2024 15:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyB-0000RM-8V
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:27:37 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvy8-0000OB-V3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:27:35 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385dece873cso127814f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344051; x=1733948851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gEXG14yGHmTwK2PkgnJuKn3fmfO28N4tNUnsroDG+o=;
 b=Glp+Z1yU/0jga31NZn4x61NUaTQLfZabWAkdUbej0ntLhq01Qbg8L7rJYBeFC4S+s4
 w1lZsmj15fGTG2Hhiput/kT/tkpeFmGEPUyxaEu0UJMNgmxpHj+sAAUJ58hARdlrAs6e
 sTTLvzt7tULHWHMwCHs3EtCbNAL4DNP8wRrb1M8Jmw8TKjpIMuiN3W7oFZ1le9vcA5mc
 xJYvkqdbWxjBHLdRQdLjJubx1zyxwT3YamIr3k+ZCZnUJrJRVHxzJqt2dsZFzBalyigJ
 e3liYxZX1yL2hhffiui1lOvLlvS8b4P9tLFikL3T8HU/4p/Oxm0d9aHdZnFisdmOIP5w
 7NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344051; x=1733948851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gEXG14yGHmTwK2PkgnJuKn3fmfO28N4tNUnsroDG+o=;
 b=LsWeJ1+KTxk5c8OLW5LdIGIO81sMIucQkol2aptbB/Ct5PM01CujemZYU6Jl0WjqHY
 IqeBbvlMQraNMXnv2c1lEB2RxjcR2A8s2KHr2DRmbvmgZ5udTckoNTx9J0mTnjvFVVdp
 oGv1WqqiabTn2Rma7KlygibZnCUtbI3+3nwG9sTLlimhTi/++fNI3IQTT4bH/ZXNzu2s
 4DoueA4YNcQ6AnWtUIvHmVniQUZZc0xgjsF2i6XBVow1ZPG/WcxH9LricRpYksGWSz4k
 iJzz32tBBudbnzYDm5PDJ/IgWGECf0COB6rJXgmxy51XClu4AUEqzP21OMT/WWRifwCn
 6pOQ==
X-Gm-Message-State: AOJu0YxG7ARGxM8NB+tl8u0Pri4Dkl1FmunO5ldwzJ9yY7V/dtifNYcT
 rlgQ+mRZSI991NSpkVKlVV5fQ3SNakzOpaX3U4zag5xNmjwP60yLW0apP42DSo24tR68yxFm0+z
 r
X-Gm-Gg: ASbGnctZO+XQI6yM9RuAfMSbj72s6Iv/Nqg3Ueu8Q3dCyoa9zZlCfSTw2/B/2YtK9T0
 gQFEyImC4KeX3TmiBiNnUkZBqkKziQpJkO8102q8Xui9d/gduuAHMEDTEORCcfkd+nDZMXR+a+m
 KpHPpV5jMYoAVnm/6Hjld2YzS5pwRt+8Nqat+EKG4s+ZQcK5uBTprXnRretMHUzQP/1H301q/+3
 mRRHOZyy0x8nvJP9e0kmyPu5MSWvUIKTzrhLx4UMGVWOLdZEobkmD3eomQrULnJXrkg63peCBk+
 pAy8egvIW0yMwnv6P3FJmGDL
X-Google-Smtp-Source: AGHT+IFXYVhD80X21fzRVCtI4Kv4SHZg7u65q+NnEYqhq4wJBmfcpp42XTcYcbdPKtSgLElOINMl1g==
X-Received: by 2002:a05:6000:1885:b0:382:5010:c8de with SMTP id
 ffacd0b85a97d-38607c164f8mr4720969f8f.46.1733344051161; 
 Wed, 04 Dec 2024 12:27:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385d80a77a0sm17412914f8f.58.2024.12.04.12.27.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:27:30 -0800 (PST)
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
Subject: [PATCH 09/20] target/sh4: Implement CPUClass::datapath_is_big_endian
Date: Wed,  4 Dec 2024 21:25:51 +0100
Message-ID: <20241204202602.58083-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Implement SH4 datapath_is_big_endian() helper, returning
the 'little_endian' property set at reset.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index f54005644c9..69108c1676e 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -29,6 +29,13 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
+static bool superh_cpu_datapath_is_big_endian(CPUState *cs)
+{
+    SuperHCPU *cpu = SUPERH_CPU(cs);
+
+    return !cpu->env.little_endian;
+}
+
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
@@ -283,6 +290,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
+    cc->datapath_is_big_endian = superh_cpu_datapath_is_big_endian;
     cc->has_work = superh_cpu_has_work;
     cc->mmu_index = sh4_cpu_mmu_index;
     cc->dump_state = superh_cpu_dump_state;
-- 
2.45.2


