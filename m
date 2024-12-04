Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7274E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvyW-00017H-FW; Wed, 04 Dec 2024 15:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyM-0000iP-8U
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:27:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyJ-0001Ks-K4
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:27:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434aa472617so1353735e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344062; x=1733948862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWutDH14OyliM2KY1fyQJ86hTSYSkrVk4NaKh8Buzj4=;
 b=DqEQNvciOkFoZV4ac9GQYzv3HLZTdD98nipn8uGlH398rnFrXG6IjWmLIWCSI7ck6C
 Tss6W0hSiTw/MC36E24hBHA1iTTdDG/DA5ZSuVa66Z+qRpDsjKnV+fcoCW+xrIM6tnW4
 OJP/ajP07oxDhzVXy9O0Vg2jnARQ+pPbe5jweaV8MLilrUaiY+PtKpkEJ2dPa1Nj9Fj4
 ozQv4bYd1q/miICbXBMEOmUkGNDY5XKhPyJvPCIEIemJkYpRAdUJkcP0Y1RDYs7goXfr
 nBNBLqP/lxmEwczRR8nYpNmL053crbQRC+Mn6Aejyn3++scB8/O3ZXiov46E6umBWQiK
 fBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344062; x=1733948862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWutDH14OyliM2KY1fyQJ86hTSYSkrVk4NaKh8Buzj4=;
 b=oeGQrfxK089v3vXXKMZkPq7sMw9TnWlSveW+HWL78rPazpKvliH4aWFp0eYhbbmxNH
 o4oHhXsZagqU7P4PjqYPZUZ0AT5PbN61h0TgKXgjREp0tX8rbAa3jQ/LFnXEp5K+19RL
 PXcfzrLWvu0ty/kVjEGOTX2Tf9H4ZM1TFizo5c8BHs8TCaPXbbrTkW+CezIrpezAM0E6
 /Rv1UUDXhko3OnRxvKnOoGmpU76rvD8RHV9ntPsSWpcupbE+OfVF8dn4KdhXqlhnXSFM
 +vAb7GfGfikfyhgdR7JuTxj5e+JqSxt6KDeRRJShE4vaDkJCPkrt69QuArjzOv/oImCJ
 h56w==
X-Gm-Message-State: AOJu0YxqWRmCVmv0G1hskLhXrq0q9vytzrJj3aP8zFr159riRAAVO6cG
 1qNla/8DX5x5rzCaUhFLjRg3t3ckibyBZ25eilR6BvTXQe67HRnvp4LGemzVyLbdpytG053Np8m
 p
X-Gm-Gg: ASbGncvMOJk3I2UH150us3LFKWKdnmduuHickBZ5HM8bv6cx+oh0pPhoZe62Ux1KVe6
 mp59zvf+o3tfuEEs3uOcnhzM2YOz1EOYL2CVl/fp7UfODUO1DvWLODRsym65/aOqdgiMgsoQriN
 iyDAKd7sa+9Gsf/4THtCc+XddU032t+LdVZfI16Clqm/ijjmHkNpszvoEf2WX9kkcs9aTYNArnN
 /TIja5h797ZSbaCtM9CDQQpfDgcxLCLUw2+t+ANQx7AIkjeS082NFr4KIHKoBd3WccZW8SrJoBq
 ljRjt1Van3DNrVD34d5tlTj7
X-Google-Smtp-Source: AGHT+IERrsgR2EegsKjGUlPd2gxFhYeU+ZCs7pMAENN4A6q2kGfKfkwC+dy29o1+ADoNHMpp5fQ2qA==
X-Received: by 2002:a05:6000:a11:b0:382:4b52:ffcc with SMTP id
 ffacd0b85a97d-385fd370b69mr7242995f8f.0.1733344061965; 
 Wed, 04 Dec 2024 12:27:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52c0dd4sm35612765e9.34.2024.12.04.12.27.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:27:40 -0800 (PST)
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
Subject: [PATCH 11/20] target/mips: Implement CPUClass::datapath_is_big_endian
Date: Wed,  4 Dec 2024 21:25:53 +0100
Message-ID: <20241204202602.58083-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Implement MIPS datapath_is_big_endian() handler using
the already existing mips_env_is_bigendian() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d0a43b6d5c7..13d0ceaa8af 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -27,6 +27,7 @@
 #include "internal.h"
 #include "kvm_mips.h"
 #include "qemu/module.h"
+#include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
 #include "exec/exec-all.h"
@@ -132,6 +133,13 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
     return cpu->env.active_tc.PC;
 }
 
+static bool mips_cpu_datapath_is_big_endian(CPUState *cs)
+{
+    cpu_synchronize_state(cs);
+
+    return mips_env_is_bigendian(cpu_env(cs));
+}
+
 static bool mips_cpu_has_work(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
@@ -581,6 +589,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
+    cc->datapath_is_big_endian = mips_cpu_datapath_is_big_endian;
     cc->has_work = mips_cpu_has_work;
     cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
-- 
2.45.2


