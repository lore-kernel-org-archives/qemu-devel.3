Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1635FCC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4O-0002Db-N6; Thu, 15 Oct 2026 06:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4M-0002DK-MN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4K-0007o1-RV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so41901175e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061534; x=1792666334; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=COhMiLUjqvR/jkvSvuk4iw4ke68Qg5bw+7Rh0Vv4z0c=;
 b=aUxXo4qgJdXKNOPXgZfl2yqlqvwpUGe0G9RJsURmT1c8rkE+tP4oF9CPnKNrUqvXfZ
 ZhsMxyXkT9RaWoZFLvRLhATlFO4FUgOrLGz/QSTszBYv1ZEgHqi3yOZixgRtAzqsCeYZ
 2DIVCVi3rYewDhQClj1vlTC54pk8EcP0ZqKZ9D/fKHAxMz/uvixGJLo4p784U91hJAhF
 dycnYLQlHTEndp2idm9YqKBeCeSC4KzifjGvvsSJjo+VrjYVRZZLb4cTaK3KF6WXV6Ve
 TqCnixROBaDkFlMVuNxEagTbi5oGJAdN2tk6zR4rv+sQ+9nQsAgiHdPnxBk1NB6wPAF3
 dHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061534; x=1792666334;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=COhMiLUjqvR/jkvSvuk4iw4ke68Qg5bw+7Rh0Vv4z0c=;
 b=ms5i5YOnzmoAKfrRvlRcGg2U3/H3sA063tnTqEuMdQnW8fmSRBUluttR46/D0zbBpA
 u/1Dz5feDXrcROYEfClC/dJ5IHW8Vm5vpSaQDcXTerQRiJGE6b+eedlCNAn7FiYJf6U2
 iQm1zUm5+nxeQ4zPCYz4rRvKJiIXm/z9MjbImRLrZFe5OZO9DJbNhLbe6By+g4c1/CtX
 HiYROp4h6fPAJ0Oc4lsnxSOuttc7xays7WoXJ0kg2BF1nMQaSrjP4bjIDTWta8xtcXH5
 gSNoES8k0aIReSu8Oe//eKEI31EVb50wv54LF3e67Fv5gAHEtwB6pkR7xmUTNvWvcvt3
 RcNw==
X-Gm-Message-State: AFq9FYK0NL/0Bwt/p6mRyR/lxNq6jhjVYZT2cgoHOUrhieR6+ASml46T
 h9Wf9HGxhiw8ReDuILdQuQo1rUhaI34ixZh9DoZS4AAJm88gMxnY8f/4UUPfu9NmoXADcQuEqVn
 XpykCL8Q=
X-Gm-Gg: AYBFou3NOunltIBKfuR/Tm4Im13Q6L8W/Ww/eDMRb752xxbu5raoAQsSE0GTcqolHJF
 xXQcSKo0CYtJhH1Vd1GVq1NRaNTqeSai9EaCH4rT2n2dXyv2xNvp58ky7Bsg7YWJuPjAB9N0361
 ukd/cULA7P7aU3KfUfw0IoxK+M1iM8S3WOVCcqMJBCs4QX3kiafJblrbw1mA2R9isxXElDQHT8T
 LRn7aDKb16Zd6kXCF9shNptM5RJxyD6q09v7kfhUaNLnqeRY464nQONt+fBf2714EWjg+jthTy9
 6pbWClXRIVDjxUZdVAO62CND6Uu6U8abEtph/yGnlSK7rftsZ5QpNx4YzK7OqBMVlyFc33vyEim
 E7GSzKrq9qBoYepj7lf/JGAn6YbIWtyM06muKyp0Zj0yBloKZ1i0M70Fe+oDDLXh2pZjuRnWyN/
 GriiyinR1vwSqhYnkjiKy1+2FRD8DBKiJkga0GxaDnbeKO0df6wlOCR0OkpTftqNu3MYpvt+8TG
 AHaNC8eJOoNUwnD2RO6n9BT7K1nJx1Z8b0R9O/kJSgt/XMRw/yFB1E1xrXDyAqyS+Ize+QRjpPq
 Izi3m8Izn7xnHlv3
X-Received: by 2002:a05:600c:19ca:b0:4a0:2484:2800 with SMTP id
 5b1f17b1804b1-4a18e4464famr360319105e9.3.1792061534514; 
 Thu, 15 Oct 2026 03:52:14 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] tcg patch queue 2026-10-15
Date: Thu, 15 Oct 2026 12:51:52 +0200
Message-ID: <20261015105212.356392-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

The following changes since commit c61ea024f6d58261394b1b408e0f220e30c136a4:

  Merge tag 'qemu-macppc-20261013' of https://github.com/mcayland/qemu into staging (2026-10-14 10:04:07 +0200)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20261015

for you to fetch changes up to 512b06299114d08458019a6c3944f73ae26cb5fc:

  tcg/riscv64: Fall back when AUIPC pairs are out of range (2026-10-15 11:54:47 +0200)

----------------------------------------------------------------
tcg: Introduce tcg_type_bits() helper
tcg/riscv64: Remove vector min/max ops with immediates
tcg/optimize: Do not derive s_mask from rotated s_mask
tcg/aarch64/tcg-target.c.inc: Correct register MIN/MAX instuctions
tcg/riscv64: Validate AUIPC relocation range

----------------------------------------------------------------
Aurelien Jarno (1):
      tcg/riscv64: Remove vector min/max ops with immediates

Dominic P (2):
      tcg/optimize: Do not derive s_mask from rotated s_mask
      tests/tcg: Add tests for sign extension after rotate

Jim MacArthur (1):
      tcg/aarch64/tcg-target.c.inc: Correct register MIN/MAX instuctions

Max Chou (2):
      tcg/riscv64: Validate AUIPC relocation range
      tcg/riscv64: Fall back when AUIPC pairs are out of range

Philippe Mathieu-Daudé (1):
      tcg: Introduce tcg_type_bits() helper

Richard Henderson (9):
      tcg/riscv64: Return tcg_insn_unit from insn encoders
      tcg/riscv64: Rename sb-type to b-type format
      tcg/riscv64: Rename uj-type to j-type format
      tcg/riscv64: Use signed type for encoding immediates
      tcg/riscv64: Adjust sign of lui immediate in tcg_out_movi
      tcg/riscv64: Assert immediate in range for {i,s,u,vi}-type insns
      tcg/riscv64: Return success from encode_jimm
      tcg/riscv64: Return success from encode_bimm
      tcg/riscv64: Fix off-by-one in branch range tests

 include/tcg/tcg.h                  |  11 ++
 tcg/optimize.c                     |  23 +++-
 tcg/tcg.c                          |   4 +-
 tests/tcg/arm/test-arm-opt-ror.c   |  21 +++
 tests/tcg/i386/test-i386-opt-rol.c |  21 +++
 tcg/aarch64/tcg-target.c.inc       |   8 +-
 tcg/riscv64/tcg-target.c.inc       | 253 +++++++++++++++++++------------------
 tests/tcg/arm/meson.build          |   1 +
 tests/tcg/i386/meson.build         |   1 +
 9 files changed, 208 insertions(+), 135 deletions(-)
 create mode 100644 tests/tcg/arm/test-arm-opt-ror.c
 create mode 100644 tests/tcg/i386/test-i386-opt-rol.c

