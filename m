Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4ADC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXDF-0005iH-Cl; Mon, 29 Jan 2024 14:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDC-0005ho-2c; Mon, 29 Jan 2024 14:22:30 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDA-0002dV-DB; Mon, 29 Jan 2024 14:22:29 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33ae3154cf8so1487476f8f.3; 
 Mon, 29 Jan 2024 11:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706556146; x=1707160946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w37w4z8ZiX6T0MrniHH1TZKFqrVjdmfQwDPneQhjUj4=;
 b=DD2rqE+1/xW+1HACufkc0G+G84wINk9I8i+ug2kDij0UdcLc2oby4DjJf7PMEdPIrU
 9Ch9PVjh+UEBEYnataJkvxdmqHbl92CF9rxtDKbLwZFtmb/NeQQ8FofxsFc9hR17v6Rg
 i42no0jskNN5fKb5DL288tQk4EyI15KPeIzuZKv0Z6ESs2mCIJ4788sqrPZ2aukGIT3R
 05ZIDxeVIZ1l2aEp8EymjlG5TB0e7ZgmJ4zG/TNoc9PmYz15rFDn2U1RJPueS4tYQ8y2
 k4vBHDSJITqFbGzXN2aXQwpvAB8yq8ba47jRkUphq2iUWPG5XTlBE5JzE1zMaNyPefVb
 OVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706556146; x=1707160946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w37w4z8ZiX6T0MrniHH1TZKFqrVjdmfQwDPneQhjUj4=;
 b=bwHi+aMX5QdQeIIMneYX7gYG+koPQQnbv0aGPXzDwUAfPRNzYlAPx+pDYYalczRxPp
 uUUXz9QN76fNRn2D+YF0wZEL7FrkeGFXdRZFQEABECzCJqwmkXa4XPNFCOWd4OW+0FJz
 KQTgCYEHaADuqpiW16j/etJMIH2bmEgMp+Qzr4Era3mUIwVrJnKtsD5OBL/L5ZdqWbax
 ceU0b/f1v+VWIfCKJb1nG/whiI1WYgTdhgUEKvaQjb5EkCfSHUmZ3HwaL6A6COzt4MeB
 pW7YFSq13gstUkAh+K3y5bwj9LZUYt/w8KBAjzb0q0XVw1knDdQ7pq1CWaE+2SnrN/X2
 Dv1A==
X-Gm-Message-State: AOJu0YxQaCo5GXtwYXZ3kWKH9eFc06MuOxnxFmXaFXGvKfou67s/C5w5
 Zjzru6fbYbyF9z5n0kaw+FaHpfEU6b6K1FE6scBcvFoKnC15kGxw
X-Google-Smtp-Source: AGHT+IFwxSRnFC6RQx1tSPkmB/r1Bhp4mZcV8ND42ggCwee6LwtpuV2gc4TijqvrJGgReDFZdl+GZw==
X-Received: by 2002:a5d:6283:0:b0:33a:f1e5:b657 with SMTP id
 k3-20020a5d6283000000b0033af1e5b657mr2032183wru.69.1706556145740; 
 Mon, 29 Jan 2024 11:22:25 -0800 (PST)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 co28-20020a0560000a1c00b0033af0cb2a35sm2577206wrb.108.2024.01.29.11.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 11:22:25 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v5 0/6] Pointer Masking update for Zjpm v0.8
Date: Mon, 29 Jan 2024 19:22:01 +0000
Message-Id: <20240129192207.2946870-1-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=baturo.alexey@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_POST=0.62, TVD_PH_BODY_META_ALL=2.564,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Hi,

This patch series targets Zjpm v0.8 extension.
The spec itself could be found here: https://github.com/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf
This patch series is updated after the suggested comments:
- add "x-" to the extension names to indicate experimental

[v4]:
Patch series updated after the suggested comments:
- removed J-letter extension as it's unused
- renamed and fixed function to detect if address should be sign-extended
- zeroed unused context variables and moved computation logic to another patch
- bumped pointer masking version_id and minimum_version_id by 1

Thanks

[v3]:
There patches are updated after Richard's comments:
- moved new tb flags to the end
- used tcg_gen_(s)extract to get the final address
- properly handle CONFIG_USER_ONLY

Thanks

[v2]:
As per Richard's suggestion I made pmm field part of tb_flags.
It allowed to get rid of global variable to store pmlen.
Also it allowed to simplify all the machinery around it.

Thanks

[v1]:
Hi all,

It looks like Zjpm v0.8 is almost frozen and we don't expect it change drastically anymore.
Compared to the original implementation with explicit base and mask CSRs, we now only have
several fixed options for number of masked bits which are set using existing CSRs.
The changes have been tested with handwritten assembly tests and LLVM HWASAN
test suite.

Thanks

Alexey Baturo (6):
  target/riscv: Remove obsolete pointer masking extension code.
  target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
    of Zjpm v0.8
  target/riscv: Add helper functions to calculate current number of
    masked bits for pointer masking
  target/riscv: Add pointer masking tb flags
  target/riscv: Update address modify functions to take into account
    pointer masking
  target/riscv: Enable updates for pointer masking variables and thus
    enable pointer masking extension

 target/riscv/cpu.c           |  22 ++-
 target/riscv/cpu.h           |  46 +++--
 target/riscv/cpu_bits.h      |  90 +---------
 target/riscv/cpu_cfg.h       |   3 +
 target/riscv/cpu_helper.c    |  97 +++++-----
 target/riscv/csr.c           | 337 ++---------------------------------
 target/riscv/machine.c       |  20 +--
 target/riscv/pmp.c           |  13 +-
 target/riscv/pmp.h           |  11 +-
 target/riscv/tcg/tcg-cpu.c   |   5 +-
 target/riscv/translate.c     |  46 ++---
 target/riscv/vector_helper.c |  15 +-
 12 files changed, 158 insertions(+), 547 deletions(-)

-- 
2.34.1


