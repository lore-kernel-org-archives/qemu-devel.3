Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2595ECD0437
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 05:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd05f-0005iI-0P; Tue, 06 Jan 2026 00:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05e-0005gd-9N
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:46 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05c-0002yW-M9
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:46 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-34c213f7690so606689a91.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679123; x=1768283923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=140Fa9Slt48n47q7OyJgPgIXB0Rzk61cwVmwPgxtuDI=;
 b=JPbIOojCE3R4DrInzltvYiryWwE1hrYXaKOdnGWYjVFAY3JFjLjJS/eJD+yDdTD5mk
 E8Q7qZSNrmwGg/Oyb+ZbAfDe/cV3ElYE7IT03LRz9uTwtXnUXTolVv4ZS/X+coURtjgC
 DkeGzOLiz33z+w3oaFqDlknRBnZbwhpaItaRS0UARRywurbIarWR22GuTnrUKjJVamjp
 qoskTv1B+Nq5ZrFWqGjVFdpu81KuTZ2hBfXjEErAbQkgX8Xae7MVoJNVBnaTEHXpkMR8
 C1PntoLvwQo2ZBPy1mqW38shv06xyCyjdD14jlRrL/4nqhtDAmGm0aVszlsR2QZ23lVD
 67bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679123; x=1768283923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=140Fa9Slt48n47q7OyJgPgIXB0Rzk61cwVmwPgxtuDI=;
 b=bjcBJR3SZ8dgSXDTk03G9w5a7q85lwXBJ0Vn7ZT95/r6OvMtsMUFM979p9oLDUcGu7
 KscwyvAeMGzYqYu3s+kptpFJT/ij7iDn9osOBv6MaynnnlnjsJ4xnz8G0swywi9N6t1R
 mQNhY1fXzSFYb8D4tG5B6icN9BmjqUbQmJEqKQ8xT0+Z3eyopHAm/D39+ww43V7Iim1L
 H/sMf27Mnu9WZPMnkjAd0lcvUf550J8z3MSdcESf8+9JOtxJpeWKw5XTs3MIGZ2Frxl1
 MEJIk4n9038RLVOZiU90p0T0RgVUlPaTXaRYLM45ErJuP/qU65vbI22Wd5ZfngLGGX9y
 WSOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvPVXlDopIsdTpGBC4Wxo0xx4/PoWgQlmc51BGSRB+pDzl4y9cw9yNizHAI2GaVfSiVsqEzCeGJ5Uy@nongnu.org
X-Gm-Message-State: AOJu0YxQCafbebJjUV6dSLV9IdwrjpOVrYS0NDI3FQSb0tS9B0nPAOpA
 ypBbxGT/ekfNq5zqgg9Dg3FaHlm9Vyyo2tE1s8O4WJyxLIBRXMHtNDn3vgdc7Q==
X-Gm-Gg: AY/fxX76XJ3Vi5LMocUd5SsjbXc/7cxmP5nLNLoIXe0oHEVyfgER7oEp7ye6Wfapq5R
 7L9qF/KNT4P7mrz3hpkq7aO/6lznHXAVFH7uxc8/woE+301p1qOcMl9IhfQAsBoCWB9/pnNGBWG
 8OTaPR8QAzXNog5qfpyEUJLH1OFKwkuG2+pd53hdw3vUq6BBMu3De2fAd2taYlmVV2CaSX5I4ua
 FCSPho68pNP0YkERtlpUkZv80wDFNa/jfS+tZMV61PEzF6ZXl5vXeOzqhRVu59/VIRLYNIpv2al
 oBOqhWUknn0LM/t9eN14NU3Skj7tWxbqA6WtwmmZfoudhgyDDIT+VQd6drrJCJvgoJFGqKneJsl
 WFjydzBnxi7EKuc6AaHeVf6+BVgn46d/TZpVI3AxO7bN8ULyxNkCCHLsYQMT5kxfmVoQ1QRDw3/
 8gEfOqnoLOP5z9Sowl1HuHurH7+/HF2pw=
X-Google-Smtp-Source: AGHT+IHAb3OyGj16b3dYUc/y+rZBmhqMa0uStTqK/yvSlFYhLVaXIFmTk5aoo6oVuIV1J9h3H5nBtw==
X-Received: by 2002:a17:90b:3a4f:b0:34a:adf1:677d with SMTP id
 98e67ed59e1d1-34f5f28d6b2mr1305808a91.9.1767679123150; 
 Mon, 05 Jan 2026 21:58:43 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:58:42 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 15/16] hw/riscv/boot: Provide a simple halting payload
Date: Tue,  6 Jan 2026 16:26:55 +1030
Message-ID: <20260106055658.209029-16-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

OpenSBI hangs before any console output if the domain init code sees the
next stage is not in an executable region.

If no kernel payload is provided to QEMU, the next stage address is
NULL, and the riscv virt machine memory map ends up covering the 0
address with the catch all S-mode RWX region and so OpenSBI prints
console messages and does not hang until the next stage boot.

The TT Atlantis address map has RAM starting at 0 and it loads OpenSBI
there, so it is M-mode and not accessible by S-mode, tripping the early
check and hang.

Add a helper to set up a simple payload that gets OpenSBI messages
to console.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/boot.h |  2 ++
 hw/riscv/boot.c         | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index e025162a77b1..d26302d3e987 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -78,6 +78,8 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                hwaddr rom_base, hwaddr rom_size,
                                uint64_t kernel_entry,
                                uint64_t fdt_load_addr);
+void riscv_setup_halting_payload(MachineState *machine,
+                                 RISCVBootInfo *info, hwaddr addr);
 void riscv_rom_copy_firmware_info(MachineState *machine,
                                   RISCVHartArrayState *harts,
                                   hwaddr rom_base,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 9f940c915620..3913bb1183f4 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -518,6 +518,27 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                  kernel_entry);
 }
 
+/* Simple payload so OpenSBI does not hang early with no output */
+void riscv_setup_halting_payload(MachineState *machine,
+                                 RISCVBootInfo *info, hwaddr addr)
+{
+    int i;
+    uint32_t payload_vec[] = {
+        0x10500073,                     /* 1: wfi           */
+        0xffdff06f,                     /* j       1b       */
+    };
+    /* copy in the payload vector in little_endian byte order */
+    for (i = 0; i < ARRAY_SIZE(payload_vec); i++) {
+        payload_vec[i] = cpu_to_le32(payload_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_vec),
+                          addr, &address_space_memory);
+
+    info->kernel_size = sizeof(payload_vec);
+    info->image_low_addr = addr;
+    info->image_high_addr = info->image_low_addr + info->kernel_size;
+}
+
 void riscv_setup_direct_kernel(hwaddr kernel_addr, hwaddr fdt_addr)
 {
     CPUState *cs;
-- 
2.47.3


