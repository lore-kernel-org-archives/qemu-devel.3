Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6C0C021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdpL-0005kZ-Gb; Mon, 24 Feb 2025 14:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdoh-0005bC-Ik
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:42 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdof-0004m2-LT
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:35 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220c92c857aso82094045ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424112; x=1741028912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1xWuCmj3O1yQqtKxdDQcXHiLCpQRQJeKsi37lap4zeM=;
 b=eFeJiJ7vgcj81AzFEfxTQc3ibDEUWFgGBK38nCAjC1GRmZ1IfchFJXgQnMTG74PLSK
 A9x0L8U1w4XwEH/vYNbE2t0HwUsHs0sGqQWVTtHD2qBlimYd3bDnSCAB9MF3a5doBaDY
 G+qt9LhJw4K0dicGS22iuCx+hGLLCOI0YB4sbzcVrT9MiZtfnJI0/ti3wrIcyB68N97e
 Qr3sklqtx/GpyUvONbjzUPFrQ2ZvALfh5Qh446MbiBnTQh9FV0KzIi1xfJhpKGVz+xg/
 fQKzZ2RjvXsUIFL0QJA0WALQkm4FyEIsoKxSSxGKWo8cnWJtTAwD7r+id0H4dGvb7Ft5
 vAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424112; x=1741028912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1xWuCmj3O1yQqtKxdDQcXHiLCpQRQJeKsi37lap4zeM=;
 b=lS6TQdONmOpHOX/XHbf8ZyIgRaivepCa0KShcqHmhbgqQuyfb6TNfqBjv6F3lcH5R/
 wF348fUB9lgnrMyP8tDgSVM4oDgG2yFjNeczMQFh40wTmwM/wJEFwvJ/VLHqvM8VC9C9
 ldxiBJ31qdH1xpBFI+C2Ihg8yONMyHCTYNynpD4Dal35d5Gw5gPzA8t/badkKOHv5l0H
 hKc3C654ANKfmZ4hta6q0eO0CBlWvqsWvo+5ypkz8hDyFZOnsK1jbPVpgSs9GGMOQBSB
 kYrytSTaV/95T3XNBY/exXlNhQP4gOjw23WyKxwhMAFrd0pehqILnSS7/tmeFn5/l0DP
 kq5Q==
X-Gm-Message-State: AOJu0YyOpTHHqxNWNHndxZuDx5ixJ1JRllvdy3nkr54mgdthkP4y+sGL
 P3ujcI8bqyHsnIfgkaDA5JoDwrO6DgaHLrhfUH4RVZr2TsPoP88nFet81/lLWKoovZXqiyZuCai
 e
X-Gm-Gg: ASbGncsMfA7RsORw1NzTY25DtOFEkpN0y5vN1jkTTCvAtyo8aCRjmIKXigvjczk/Mfg
 gRZ4AC4MgKQKeGhC88P4T4yTk5g0XrG7SfmsGmhDiYJ+f3e2UiZ4DuAiNm8tyB31zjMpv5BMVQ6
 SpdpbI0PFfIosW/GGYJ54pCzasCcDQ0lLHee/AhgP2js+exFhNhXBYzkLPU1mUtsJz0lsLc8KY/
 mHMrbrICCqgb0/FP8Gjd9Xd3FbH092PZW2yIZFq3f4dFzyIb6ZHEDnkTeM3hDraR6y/0YhXRvLB
 aR7iGjNS9YM9oLIrhB3bkWQXI5JfPg==
X-Google-Smtp-Source: AGHT+IGDx1Z8+pZNQjfM9/e6KW8X8lUodMRKxgcS79dgu+/M8SZZC0ZwkHZ0qTdb1WsOxi1T+SOOuA==
X-Received: by 2002:a17:903:2bcb:b0:216:4676:dfb5 with SMTP id
 d9443c01a7336-221a000ea3emr221301075ad.21.1740424111800; 
 Mon, 24 Feb 2025 11:08:31 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:08:31 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 00/11] riscv: IOMMU HPM support
Date: Mon, 24 Feb 2025 16:08:15 -0300
Message-ID: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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

Hi,

In this version no major changes were made. Just a rebase with
alistair/riscv-to-apply.next and acks from Alistair.

All patches acked.

v1 link: https://lore.kernel.org/qemu-riscv/20241205133003.184581-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (3):
  hw/riscv/riscv-iommu.h: add missing headers
  hw/riscv: add IOMMU HPM trace events
  docs/specs/riscv-iommu.rst: add HPM support info

Tomasz Jeznach (8):
  hw/riscv/riscv-iommu-bits.h: HPM bits
  hw/riscv/riscv-iommu: add riscv-iommu-hpm file
  hw/riscv/riscv-iommu: add riscv_iommu_hpm_incr_ctr()
  hw/riscv/riscv-iommu: instantiate hpm_timer
  hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes
  hw/riscv/riscv-iommu: add IOHPMCYCLES mmio write
  hw/riscv/riscv-iommu: add hpm events mmio write
  hw/riscv/riscv-iommu.c: add RISCV_IOMMU_CAP_HPM cap

 docs/specs/riscv-iommu.rst  |   2 +
 hw/riscv/meson.build        |   3 +-
 hw/riscv/riscv-iommu-bits.h |  47 +++++
 hw/riscv/riscv-iommu-hpm.c  | 381 ++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-hpm.h  |  33 ++++
 hw/riscv/riscv-iommu.c      | 131 +++++++++++--
 hw/riscv/riscv-iommu.h      |  27 +++
 hw/riscv/trace-events       |   5 +
 8 files changed, 612 insertions(+), 17 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-hpm.c
 create mode 100644 hw/riscv/riscv-iommu-hpm.h

-- 
2.48.1


