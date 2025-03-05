Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42229C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxB-0001Zs-5x; Tue, 04 Mar 2025 20:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdx9-0001XG-Uk
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:43 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdx8-0008Ns-3z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:43 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2feb867849fso8670364a91.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139620; x=1741744420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7V7shzd0k2XqS82f1i2WoT6RekEWouTlUxcHoij3AFI=;
 b=QbeP5dVgPIjAWfQSBobDG37WgI/eVQzHYe32Neu8FtytQqCFh0NI1Ovtsh/0XNPi6E
 XHBaewvn0nBfBsYv/llWglPjrl2xTqp6zGxUKID5TzBOLMsfL+kXTaOy8RBbIPJeqrrE
 FgoWx0WjD1cEUNVVyjlIRZG0XbVViLEygcaNOcZ1lEHCJcoZYppSMh35v7p8YxZzCEkF
 Kz7Ho+vv2h2qdjNXfRmWPvgHcZNMGKW5ruNgqazOIOtnK0ewQPF+rtf3aXL8A1zXvvaL
 z3PA8AUnuD1uRpkfVgUSr9RqUzGmTX1M/CgePSk71CV/M3eYg1yjXNLSHlpPcpoHSExt
 4b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139620; x=1741744420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7V7shzd0k2XqS82f1i2WoT6RekEWouTlUxcHoij3AFI=;
 b=tHlFwXV0t0OWAl17TqnDMmeIvMG/Q9or3Q92FsD6jJpSb1rZa6OtaxAHMXpVxG8aVB
 k7fmMqTTo1A3Ot1OZFlJbK4MsuEWlpg16hZ9IqTadCjScsjfgdRRP2OE8ROcQq1LH9qe
 coD+Jf/1A8LYGYZjfT0D73UVBx/NOaNOwVCEOF/Nkm+RDmgnZNdb9/KskperDA/xtCI+
 32K9Kr/VjWeK5KiS3L0b/gbHsVCOcaCBY+sCj/K2jlgBKdBFyBPlO7JpRqyBgJcst5YO
 X8424hw74JQJMW+HdTd5B2H0rboGnu83Kvs11LBeeu92WuZphzveu30ySug596pj7yEV
 YU7w==
X-Gm-Message-State: AOJu0YwMMs1ePdcyq31+nCkSAPJSt8kIt3AX6PQ+in0Zl10CvuIpDmTX
 Umrr39oB8ICU3dLOc9VHQms+N5BnGXO2KhKViT6czd/MnFF1yPp6rZc8w9AiRE8=
X-Gm-Gg: ASbGncsZxzjEKYU7CMJJYRasZYQSrA9EvFSoSlWDvXw7ezu3K+yv7WYzAazWysGp8Z+
 i+y1WAFLNb143JqS/87fgej1lRvecfQ7inRZEhLgID9OItxMXC+4IA8YIFkk4wG6hz7PDGaReN6
 +68hdwaQW9tkzq95zVwv9DoCtgB+JByFoDqB6lxij71/TWWAry5vgvBL/91nV1Eksc94JH2Kysr
 RujOrfHHTTyGKoRLVY/qH4jG5zXHZ0WbQgSKbTgOtouSr1KhZ4FAGtbhZ/Bw3aZ/6pgo0h8PmQP
 IueSy8VmU7kFyEXymjwQ/oUqulbamcQw3LsNlqs2YVRzezqr+sqc4HznxsNwE5Ay/3/nh9rUPdQ
 YPH+L7mUMPK81q9o9C0X1fMfB4NSu63I6NNib4reXmKn9uReIQQg=
X-Google-Smtp-Source: AGHT+IFgoCkMHHSQl6ebRoEDPt5fXFnqUEdES3JqPkZFS6EyXenweLPuXdUqFMN+4aM6NIileDeogg==
X-Received: by 2002:a17:90b:3e86:b0:2fe:8c4f:e7c4 with SMTP id
 98e67ed59e1d1-2ff4975338dmr2548323a91.15.1741139620107; 
 Tue, 04 Mar 2025 17:53:40 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:39 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/59] target/riscv: throw debug exception before page fault
Date: Wed,  5 Mar 2025 11:52:17 +1000
Message-ID: <20250305015307.1463560-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

In the RISC-V privileged ISA section 3.1.15 table 15, it is determined
that a debug exception that is triggered from a load/store has a higher
priority than a possible fault that this access might trigger.

This is not the case ATM as shown in [1]. Adding a breakpoint in an
address that deliberately will fault is causing a load page fault
instead of a debug exception. The reason is that we're throwing in the
page fault as soon as the fault occurs (end of riscv_cpu_tlb_fill(),
raise_mmu_exception()), not allowing the installed watchpoints to
trigger.

Call cpu_check_watchpoint() in the page fault path to search and execute
any watchpoints that might exist for the address, never returning back
to the fault path. If no watchpoints are found cpu_check_watchpoint()
will return and we'll fall-through the regular path to
raise_mmu_exception().

[1] https://gitlab.com/qemu-project/qemu/-/issues/2627

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2627
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250121170626.1992570-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 1de8e0e494..29dc721c5d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -27,6 +27,7 @@
 #include "exec/page-protection.h"
 #include "instmap.h"
 #include "tcg/tcg-op.h"
+#include "hw/core/tcg-cpu-ops.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
 #include "system/cpu-timers.h"
@@ -1697,6 +1698,23 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
+        int wp_access = 0;
+
+        if (access_type == MMU_DATA_LOAD) {
+            wp_access |= BP_MEM_READ;
+        } else if (access_type == MMU_DATA_STORE) {
+            wp_access |= BP_MEM_WRITE;
+        }
+
+        /*
+         * If a watchpoint isn't found for 'addr' this will
+         * be a no-op and we'll resume the mmu_exception path.
+         * Otherwise we'll throw a debug exception and execution
+         * will continue elsewhere.
+         */
+        cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
+                             wp_access, retaddr);
+
         raise_mmu_exception(env, address, access_type, pmp_violation,
                             first_stage_error, two_stage_lookup,
                             two_stage_indirect_error);
-- 
2.48.1


