Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F1BE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBwV-0001Et-4w; Thu, 05 Dec 2024 08:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwH-0001Ao-R5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:42 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBw9-0004XY-Cw
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:38 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7259a26ad10so722371b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733405410; x=1734010210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=La9AioGkA3IusDhLuH/rTBZX5ITtR1iR2EKKg8Y6I7E=;
 b=R5Cepis8O6ONBsroFE+hz49VtpvdAaTK9apT5Nv+DtuP1ydDhkN66HCjcMbD/27/4G
 mcJ36t50fkTd7hYgAraFCnnD4HdGZAzlUR53G7yQixUWt7j50AqnZDgMcXJmDUI/IhQd
 L5sy2FnZhpMM+5FEeUIbIrs8JTbsb6GOO36k3GmS01oL/cG4E8cnLTAIO696D8fSUUXA
 CnGA6SVamR20ocUhJkYueqzL7ST6F+r14I0ND/m4ar3S+SnKT5Gs6qBOqWef6/8u/h+K
 vCqoaNjIYEljGxCHthkGBb5GCx+ILs/cNDESfNDfQ5b5sjINfo9p4Xs5eLbn0HFuyDMW
 zRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405410; x=1734010210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=La9AioGkA3IusDhLuH/rTBZX5ITtR1iR2EKKg8Y6I7E=;
 b=baf8Ja2+roB3KSvg/CBVqWa7Tw5nYpuYaDmdjXZ/AoFJLKnPbYk5SCmtp1Vr0hMiM7
 W6FneQn8nM3/GPCkMdoQbhQWwXTFEMwzBN0EKYKHQJUd1kmfjU5q43fRwEUiVx9X17fa
 pOY93LIyYZAGZf4OjE/CdKjQaR/ca7rwjf6GJBmfzzOjoG0XPygkS0WGgeSgv/AKtaWR
 DwQfCU4U9xsW7Lfu0WXdy/EVzjHUanJB4Z4XNgNMFA2KMqljTz1HZ9QXYlKQW6eVZxgJ
 0Alq9MLbGDS3EKHnICNwTPAYhW7aLtcRyklgPzBZx7UCK8dfK6My2oWByImY+pxv+BpP
 BvTg==
X-Gm-Message-State: AOJu0Yw7Rt742tkmQqiwcaPEXBBQ3AdthoZO4gs5oSBWk+lOwFJhz71i
 o22W7BhhVBmH1vnH5gJU/50345CpcWfLs1KQlgSI5rtNH4bVG1+rbW/n4vbXDnmyWVxuJ2CyD53
 b
X-Gm-Gg: ASbGnct5QLlY+IWiGYXxbMSi7Dw2ABXGpI19mNtvT4815E2Ct25k8QmNB+UlbooQ9qG
 LzVHkapCaKCq6Zd5+FJBmk57yjqschiG4ZORtCUtcM0JbbrmVrV7enOtoaH/VNIuwQfRTtrYl9a
 F8ruEb361MntovxxmT2r7VrjNTfQkv5iBfW0nZb7v6/s45m+KyzdSNlJAARAJcmZyRpOc+2ZFs9
 7qgpRkvvKTe8NfY+VIYTJdLwpZO8phxYOadipnHRQ6lcqoUzxzgB2iL5MKTOHm9IQi6NSiv0oiw
 nn60
X-Google-Smtp-Source: AGHT+IF9YYzqlSAKUXfyaj4VMeZmZAOzTxHX46IijiI1A4xpHtgYf2Y39ev7oO2iREwvdyXWUgJ7pw==
X-Received: by 2002:a05:6a00:2789:b0:725:9253:62c8 with SMTP id
 d2e1a72fcca58-7259d5734afmr5469096b3a.2.1733405410097; 
 Thu, 05 Dec 2024 05:30:10 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a8f512sm1250315b3a.126.2024.12.05.05.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 05:30:09 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH for-10.0 00/11] riscv: IOMMU HPM support
Date: Thu,  5 Dec 2024 10:29:52 -0300
Message-ID: <20241205133003.184581-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

Hi,

This is a re-submission of the original Hardware Performance Monitor
IOMMU support sent by Tomasz back in July 2023 [1] in the first version
of the IOMMU emulation. In the second version of that work [2] sent in
February 2024 I said:

----
- I'm not contributing the HPM support that was present in v1. It shaved
  off 600 lines of code from the series, which is already large enough
  as is. We'll introduce HPM in later versions or as a follow-up;
-----

So here I am keeping my end of the deal. The code is basically the same that
Tomasz sent in v1 with some tweaks:

- Code was split across several patches for easier review;
- A separated file was created, riscv-iommu-hpm.c, to host all the HPM
  related code. The base emulation will use HPM via public helpers. The
  idea is to avoid clogging riscv-iommu.c;
- There was a lock in use to read/write the HPM registers in the
  original posting. Based on the current design of the merged IOMMU
  support, a lock-less design, I also removed the locks from HPM;
- Other minor tweaks such as not naming functions using "__name" and so
  on.

Patch 1 is a header fix required to put the helpers in riscv-iommu-hpm.
Patches 10 and 11 are new. The original HPM code is split in patches
2-9.

Series based on alistair/riscv-to-apply.next.

[1] https://lore.kernel.org/qemu-riscv/cover.1689819031.git.tjeznach@rivosinc.com/
[2] https://lore.kernel.org/qemu-riscv/20240307160319.675044-1-dbarboza@ventanamicro.com/

Cc: Tomasz Jeznach <tjeznach@rivosinc.com>

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
2.47.1


