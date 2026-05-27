Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46E2CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKeb-0006xA-HS; Wed, 27 May 2026 16:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKeZ-0006s8-QA
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:59 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKeY-0005OU-3f
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-452169ae568so7822705f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912895; x=1780517695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeblK7/EUpTWApgaalqExSacjBZVjtrb39D4H9GOeNI=;
 b=LSYyblJyObQ0eaTDCf7C5Q0v0NHMnRvZIwSbw1jPJAmGskcA+jjl0475q1cKi54YTI
 05l3p4Hldv+2yPPweCg6mcvuHxEhhg3weYjikkzTfrJePsfh+a2fe1LeQ4wEchrAzIgs
 3Py+IosL2p1mmsu4WUuqF8IH2yTwti5kAwv59isPQmlY6f/xLK2HdQHpuQMqS2r4dMi6
 8GfrGleb6dOnTyDwvUW3tJAmZyWRpdW7kvzNNbgagav7Kg6VGRjHVeE4A41AyEZMzkNT
 FSW/FMz6/Uas1QnyEnqVCD0893W5n6oN98dLYVC6QwvmFdSu+9m9PQBjrfotbDrKljVJ
 4IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912895; x=1780517695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TeblK7/EUpTWApgaalqExSacjBZVjtrb39D4H9GOeNI=;
 b=mw94wgAfczQuLHP1D3ZRt4TdxLiu/NcMbE3n8O/m+DfcjVN2Jl76coSAJs0f3EkNPn
 aEsJa4nBBTwixk61gC4pO9Fyo80A3BfRattrtxx/rlA+4reLEK3BDIMSQuQy379P2rV5
 DzsZZNp4aGoqIyftG6DN843lovNash7m3villf5e+rUiqEAy04byBIfd3DGWKikcWWd8
 Mm2jKe5wNwh9imIe9XvyUEAl6SoPYxrphaYxd2D4KbpHtuU73W8ZMmivxlIME14eRVrA
 sC+xUlgvlpN9G40tAfiL7rsoUug5E75DqxMfym96UQcg6RnUUzJusjCeV3use7MgWtCT
 J9xA==
X-Gm-Message-State: AOJu0Yy68Aa0gRr5hLL2J92vL0EqTn87FisjTNcJfZpVY7zauslCq3rL
 N6W9rv9Zc8XDGDl1GFffTlhB4lAmz3sAj11fL7ZQGdXGfuDC+STDZCinqImd1SwvjyTv1cHfJQi
 cXifCNd1+UA==
X-Gm-Gg: Acq92OF1Kx18e5sX3E3iRji95plNSeK/yBG55ge0g0e5k5v717fhvR76VJOt7m7Iz8h
 2oNnkJ8CitxyvM9QxlEGsoKF+yv7H0Sfxwx5whCsIhSwKkd12RSNkisHb4kQb61QLpIfAmJquD+
 z2L9/zkEEiHs9XEI3834JOPkrSi/C2aVBH6tEiMl6mA1Kfzoz1QmMj6V/QNte+lAfcPvnccZfyd
 TcbWNv7otYKY6FGuy7K4RYjiyceIkCxEMO4SIxwJZrB8FizIT9UFRnF2DwNZBWNibwSjjtbAGe8
 Uve7xgnfsQYEsJOjJ0WAA95wA9Lto/BkLLX+SZ3a/4njxFdrO8umnGH/qVF5Gi8Jb8qIb4nezy6
 m7ZBVf0ZMmHKMf/tH0StnmUoOHo6O82czW6Fzo3eblXAPyC1GG6Ls4jg8xinJkV9shPc1lMlqn9
 3nQj8xlZZIo4HeYqwkotZdDt+nHj1tHUuBVvfw2iitlaStsZEF+FyPtROfj03Yyqs3JQ==
X-Received: by 2002:a05:6000:2f82:b0:45e:d3d4:c230 with SMTP id
 ffacd0b85a97d-45ed3d4d1cbmr19415767f8f.38.1779912895146; 
 Wed, 27 May 2026 13:14:55 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557679sm14753300f8f.10.2026.05.27.13.14.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:14:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 08/12] hw/riscv/boot: Replace cpu_to_le32() -> const_le32()
Date: Wed, 27 May 2026 22:13:44 +0200
Message-ID: <20260527201348.29511-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rather than adapting the array endianness when it it
filled, directly initialize the CODE words with the
correct endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/boot.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index c6ab1cc8cfb..4297949f6be 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -454,40 +454,36 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                uint64_t kernel_entry,
                                uint64_t fdt_load_addr)
 {
-    int i;
     const bool rv32 = riscv_is_32bit(harts);
     uint32_t reset_vec[CODE_WORDS + DATA_WORDS];
 
-    /* .text */
-    reset_vec[0] = 0x00000297;                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
-    reset_vec[1] = 0x02828613;                  /*     addi   a2, t0, %pcrel_lo(1b) */
+    /* .text (RISC-V instructions are always little-endian) */
+    reset_vec[0] = const_le32(0x00000297);      /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
+    reset_vec[1] = const_le32(0x02828613);      /*     addi   a2, t0, %pcrel_lo(1b) */
+    reset_vec[2] = const_le32(0xf1402573);      /*     csrr   a0, mhartid  */
     if (harts->harts[0].cfg.ext_zicsr) {
-        reset_vec[2] = 0xf1402573;              /*     csrr   a0, mhartid  */
+        reset_vec[2] = const_le32(0xf1402573);  /*     csrr   a0, mhartid  */
     } else {
         /*
          * The Zicsr extension has been disabled, so let's ensure we don't
          * run the CSR instruction. Let's fill the address with a non
          * compressed nop.
          */
-        reset_vec[2] = 0x00000013;              /*     addi   x0, x0, 0 */
+        reset_vec[2] = const_le32(0x00000013);  /*     addi   x0, x0, 0 */
     }
     if (rv32) {
-        reset_vec[3] = 0x0202a583;              /*     lw     a1, 32(t0) */
-        reset_vec[4] = 0x0182a283;              /*     lw     t0, 24(t0) */
+        reset_vec[3] = const_le32(0x0202a583);  /*     lw     a1, 32(t0) */
+        reset_vec[4] = const_le32(0x0182a283);  /*     lw     t0, 24(t0) */
     } else {
-        reset_vec[3] = 0x0202b583;              /*     ld     a1, 32(t0) */
-        reset_vec[4] = 0x0182b283;              /*     ld     t0, 24(t0) */
+        reset_vec[3] = const_le32(0x0202b583);  /*     ld     a1, 32(t0) */
+        reset_vec[4] = const_le32(0x0182b283);  /*     ld     t0, 24(t0) */
     }
-    reset_vec[5] = 0x00028067;                  /*     jr     t0 */
+    reset_vec[5] = const_le32(0x00028067);      /*     jr     t0 */
 
     /* .data */
-    stq_p(&reset_vec[6], start_addr);           /* start:       .dword */
-    stq_p(&reset_vec[8], fdt_load_addr);        /* fdt_laddr:   .dword */
+    stq_le_p(&reset_vec[6], start_addr);        /* start:       .dword */
+    stq_le_p(&reset_vec[8], fdt_load_addr);     /* fdt_laddr:   .dword */
 
-    /* copy in the reset vector in little_endian byte order */
-    for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
-        reset_vec[i] = cpu_to_le32(reset_vec[i]);
-    }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
     riscv_rom_copy_firmware_info(machine, harts,
-- 
2.53.0


