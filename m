Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A840C36013
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 14:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyXQi-0007sj-R9; Sat, 29 Mar 2025 10:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQg-0007rr-BH
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:44:58 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXQd-0004DZ-SZ
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:44:58 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so8319895a91.1
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743259493; x=1743864293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zM2u2LTkRWOnZXtO1N1ga0RMqgVI4wtD5r/xNpvZR/Y=;
 b=WXgg0gxN9ufc172r18+p7HhRNSFYMvjh/Lz0njfUKUEyhIrrXXzVPMqLK8O3WFx0V4
 QW7N/9St+UIHGjP2JB3el9A1/x0wBvgG7nhmbgezty9a96bR4KN0zoGQyqt0qVZLMxiy
 xyPYkrt5PbybU4ZfFdvNuiH7S7kg5T0ikwA5xU+ReAmQHzS4pgXcblQpeQa/AbUEHlfh
 9ak4oEnBcSzgRpxZ/8ACbn/ZAOZkhLIWUQBJiaUJ1o097BuyYq8ecEWp2d+J4vLWXSj4
 IJImdJ3u79IXdCNf/l1k2ljjaeejq7oLmgK+SpR04tgpcFW11i4E2R2D52QyLtsYdrap
 x5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743259493; x=1743864293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zM2u2LTkRWOnZXtO1N1ga0RMqgVI4wtD5r/xNpvZR/Y=;
 b=wwM14II47z+zbxyOvTVRCTgA8xzhwE1j+c0dmvQ7dd7fX9DcDKj0mninMG+m1En0Jy
 Ad0Ldl1Xxznj7qxGu1f22SOh3LRf9A0LV6c53IuHXGCOra2s0C16OS7N3k/3D1weGraQ
 94CP6Bz0C/rkievgTwDQnz9gLFs5RsTO9xjIPtBV5JIc1n/RsWxRDTAcPnROw7N67vIt
 /oYHI1mI/NfwZ+/J/zaZRQhdHbvZ1UBPq8NItseKAqJldzhn7d6f5ZdT9q+Ew2YtBa0y
 QcUWSm8J0JtoRiqdGHYBN5IgkPLcBThKwNMm7I0zpfYCLVarCmgLUnp7tXqCaWjoyTkR
 si0A==
X-Gm-Message-State: AOJu0YyRVvh0CzyEjb5U3XB3aAdUgn/jJM1e96tDCS5Ha8qlcrZhECiV
 RwGzO4M4yysc9M6bFa3zZ+1E+GH0UGSeF9K+AVQyEULt8qmZ/bZlyklThhcNThikrCzvvjRWVdP
 XzmQmSqsBMNTUPakw8TYy1nUIKRmM6pZ+no8+IhCMR2zv4G1X7hyBEFQyTyhA90kdx3l0VqSiRP
 8ur4bexVkDKlekNZnGcgvhGNpiD9bO7ZWxNYKP1Q==
X-Gm-Gg: ASbGncu9TEkwBjWvxyHWpx388Sj187UFPLztwMqWpSxJUjwaO2e+mv58Sx4ggWTZ3A3
 elA2j4XnffEnU9LenfL+fEyoyztiGksvPnXQ6gTZyjCm7WZobNuuXqJtnUc9IJgRc0C7saCOvav
 GNs0FwCU7LewIPVmS3he4HDnT/GkNwoQbo8uQdJrSxX7/bd1tx2d5TbFF9PtAaGCQqU5NqCC028
 cFkuUY24pBu2+rYuJLxo/s3UDo4Zea9fAUOb4ZxLOljaoMMfo3FjBS55KtCJ+EScRYEaUvMUb2E
 0qcSALdiq+XSMTyDOFzE73gMEvEcnpkQQcIPnUk6V59fovTy34aiHjrX1cLvlZySrWwqghDvXrd
 DPYOBWT/s/Llenw==
X-Google-Smtp-Source: AGHT+IG8lTBMNsyvG1bgKegabKsHhXv4wTPfqZc0h5zbPMHa98IHRQ/OPC+b2xOYCRQEXikqcAbGcg==
X-Received: by 2002:a17:90a:c887:b0:2fc:aaf:74d3 with SMTP id
 98e67ed59e1d1-3051c85e2a7mr10433961a91.4.1743259493264; 
 Sat, 29 Mar 2025 07:44:53 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b6bcbsm6737196a91.45.2025.03.29.07.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 07:44:52 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 00/12] Fix RVV encoding corner cases
Date: Sat, 29 Mar 2025 22:44:34 +0800
Message-ID: <20250329144446.2619306-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102a.google.com
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

This patch series fixes several corner cases of RISC-V vector
instruction's encoding constraints.

Building on Anton's original work, this v2 series specifically
addresses:

1. Illegal overlaps between source registers
2. Corner cases in complex vector instructions like vrgatherei16
3. Handling of register overlaps in vector widening/narrowing
instructions
4. Fix unmasked RVV instruction encoding (e.g. vcompress.vm)


Anton Blanchard (2):
  target/riscv: rvv: Source vector registers cannot overlap mask
    register
  target/riscv: rvv: Add CHECK arg to GEN_OPFVF_WIDEN_TRANS

Max Chou (10):
  target/riscv: Add vext_check_input_eew to check mismatched input EEWs
    encoding constraint
  target/riscv: rvv: Apply vext_check_input_eew to vector register
    gather instructions
  target/riscv: rvv: Apply vext_check_input_eew to
    OPIVI/OPIVX/OPFVF(vext_check_ss) instructions
  target/riscv: rvv: Apply vext_check_input_eew to
    OPIVV/OPFVV(vext_check_sss) instructions
  target/riscv: rvv: Apply vext_check_input_eew to vector slide
    instructions(OPIVI/OPIVX)
  target/riscv: rvv: Apply vext_check_input_eew to vector integer
    extension instructions(OPMVV)
  target/riscv: rvv: Apply vext_check_input_eew to vector widen
    instructions(OPMVV/OPMVX/etc.)
  target/riscv: rvv: Apply vext_check_input_eew to vector narrow
    instructions
  target/riscv: rvv: Apply vext_check_input_eew to vector indexed
    load/store instructions
  target/riscv: Fix the rvv reserved encoding of unmasked instructions

 target/riscv/insn32.decode                 |  18 +--
 target/riscv/insn_trans/trans_rvbf16.c.inc |   9 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 167 +++++++++++++++++----
 3 files changed, 154 insertions(+), 40 deletions(-)

-- 
2.43.0


