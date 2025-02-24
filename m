Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A31C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc2f-0006tF-9o; Mon, 24 Feb 2025 12:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2d-0006ss-Qg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:51 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2b-0005XE-PD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:51 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220bff984a0so99008425ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417288; x=1741022088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dx37ot/VelrdYJ0OavN6CSRIKXW1vB1HPsDSEvZ03mk=;
 b=NacsUI6Z1/xkb2i5y25dSJ3vxgku4Zk9VhQU7jHdBhp2U3PeCnbvMro36nSSls5280
 QELvatbqrQTjHVcR3Dbd5P6igMHmYSQt5PeRZ6sL/5TEK7v9Sj7wSrbxgPf0E2i4Qp0C
 Ptv5G3d00zy7E5VUtzzzy7XxizV+9WwiiZkWeyWSuS0uA+pUvhs5kDkMBDmtmrby62pM
 KGSuWmxR0dmFRx7jyo3gouejapR3tVbAi+6OaqJoHgokA0Cs2yEsQYZtPoCiQASAaM28
 oYiHeKskqXpgf0hnew9nVZ9oLr0nZrhI4bJS7bK4ZsRgtFTwiK5gBLzeXBlCyaziFulL
 X5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417288; x=1741022088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dx37ot/VelrdYJ0OavN6CSRIKXW1vB1HPsDSEvZ03mk=;
 b=o2ZnZ0KEwcxi+uc0GHxKeUyjMLQmhxsVVi4Pk4fMyjMxtE+YKiIjBXE0lNpJqSNosz
 MsnUdnO/Rgm719CQBKA3VJQ///SLTl3Hr7g+j/c+8CfhDxAM9A6QOk4p5wwDI5swymB8
 lyDmvGes/boejamFXiTjdPIjXkUNyCjJDyDH2mwAzhv7gPgktmRb7aEsLjVLS1+LgClJ
 +lClUFWAExzqT9jc0+j1FQbcEGjsSpjAsvdkW1/c+Yp1xFpMIFaPEjKpan0Gj8axj+pI
 fkIc9ulXn68LKYMBFAghFQ1NQF3zvjcwDy3rSCDb4CXOHmfc7F8qgV8wVhiWrIxl8QbX
 LwGA==
X-Gm-Message-State: AOJu0YxpLko4J64DB32sXVxXzLDVeAq/n14/2pjjDnOHtKLIXSLCxi5e
 gRYj92i/ukNtAtNOtIcqonTTojM0VOHniEFJATxMtzrIcUqho8+BdGYL2MtrYt2+SsJRjv2LZ7y
 e
X-Gm-Gg: ASbGncuw9lUlVQu4ATBxRrRHRBB4N6PX2HRRXA1DE5YkF1ld0AOChB3jg/6zS99vSXO
 tiSn5TTTxE3OHF+gY78gDDedUnwHDhFxb3zpwsxePWnD4SKFHETtDHoYT8BhoqEYE/JKKd4OvyH
 bDuSSD2jvblHYsIB7Zaovp8WFvQsS1zs8ErG0rg+LJ5s9tHEfwMKXtVO1DN9D2xPv+u25adqMBk
 P2wXwRLTuHKAMO9juZnjNEvHFjl1uKz+Cbu3GAUHBzhiHm4jDdzeBCgDyiF8jKm2GXiSQQGc16j
 fzMSS+3LVuA1g4Y/AW+/yEz7f3byB/4/yBQ=
X-Google-Smtp-Source: AGHT+IFW3SDO+PAQw7ED9m3jEmNiZmGHt3rc2RKJe7ZKSZ7m+4XC1ri6/u+CYkR8yCHg0LmoheP5Pw==
X-Received: by 2002:a62:e40a:0:b0:732:5954:a815 with SMTP id
 d2e1a72fcca58-73426d8d80emr17445254b3a.22.1740417287983; 
 Mon, 24 Feb 2025 09:14:47 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:14:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v4 00/24] target/m68k: fpu improvements
Date: Mon, 24 Feb 2025 09:14:20 -0800
Message-ID: <20250224171444.440135-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

v3: https://lore.kernel.org/qemu-devel/20240909172823.649837-1-richard.henderson@linaro.org/

Changes for v4:
  - Rebase from September.  :-/
  - Reorg update_fpsr(); do not expose as a separate helper.
    Fixes raising of exceptions from FCMP (e.g. invalid).
  - Fix a few comment typos.


r~


Richard Henderson (24):
  target/m68k: Add FPSR exception bit defines
  target/m68k: Restore fp rounding mode on vm load
  target/m68k: Keep FPSR up-to-date
  target/m68k: Update FPSR.EXC
  target/m68k: Update FPSR for FMOVECR
  target/m68k: Introduce M68K_FEATURE_FPU_PACKED_DECIMAL
  target/m68k: Merge gen_ea into SRC_EA and DEST_EA
  target/m68k: Use g_assert_not_reached in gen_lea_mode and gen_ea_mode
  target/m68k: Use OS_UNSIZED in LEA, PEA, JMP
  target/m68k: Move pre-dec/post-inc to gen_lea_mode
  target/m68k: Split gen_ea_mode for load/store
  target/m68k: Remove env argument to gen_lea_indexed
  target/m68k: Remove env argument to gen_lea_mode
  target/m68k: Remove env argument to gen_load_mode
  target/m68k: Remove env argument to gen_store_mode
  target/m68k: Remove env argument to gen_ea_mode_fp
  target/m68k: Split gen_ea_mode_fp for load/store
  target/m68k: Move gen_addr_fault into gen_{load,store}_mode_fp
  target/m68k: Merge gen_load_fp, gen_load_mode_fp
  target/m68k: Merge gen_store_fp, gen_store_mode_fp
  target/m68k: Implement packed decimal real loads and stores
  tests/tcg/m68k: Add packed decimal tests
  target/m68k: Make vmstate variables static
  target/m68k: Implement FPIAR

 target/m68k/cpu.h                |   27 +-
 target/m68k/helper.h             |    5 +-
 target/m68k/cpu.c                |   38 +-
 target/m68k/fpu_helper.c         |  330 +-
 target/m68k/gen-floatx80-pow10.c |   33 +
 target/m68k/helper.c             |   18 +-
 target/m68k/translate.c          |  789 +++--
 tests/tcg/m68k/packeddecimal-1.c |   41 +
 tests/tcg/m68k/packeddecimal-2.c |   46 +
 target/m68k/floatx80-pow10.c.inc | 4935 ++++++++++++++++++++++++++++++
 tests/tcg/m68k/Makefile.target   |    4 +-
 11 files changed, 5746 insertions(+), 520 deletions(-)
 create mode 100644 target/m68k/gen-floatx80-pow10.c
 create mode 100644 tests/tcg/m68k/packeddecimal-1.c
 create mode 100644 tests/tcg/m68k/packeddecimal-2.c
 create mode 100644 target/m68k/floatx80-pow10.c.inc

-- 
2.43.0


