Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA1CC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqZV-0001LN-VU; Fri, 02 Feb 2024 05:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZU-0001L8-Cz; Fri, 02 Feb 2024 05:14:56 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZS-00043l-QD; Fri, 02 Feb 2024 05:14:56 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so275262866b.0; 
 Fri, 02 Feb 2024 02:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706868892; x=1707473692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lZlVYUMXV1uG1lPKruohH2q+GDTjW2b2ufZSNU1KiIQ=;
 b=Hx6MxDZeSrFAbAgdYkzZmydOmcrLaN+SHyb8HLypPV1tiROsh6Vb8BSaw0CDtGD8SK
 mxSXaA3VmEeVo7aAGwHdvKU+fjN1+1oXLyhAOvwOzXaNvqf42oAmN+Z5s44Vky63LT+n
 sYuj1jh6pb1EC3Xi7RV6kUYyYZemKFBC69goU7otJVNuqyTEY/lwTtsr+dsUmO0R3Auf
 ru8bcg4ctDzeYoafuXwaqJJ+dauFSW3B8tezj7xNSNb29T3EOdGz381mPrREGC3gTyqD
 Yr39+2d0ILeHIeUziza63CEA5js22RLUL7OJHHJZBHrkst3ShGFTpJhQEse4TgtNgm/w
 L2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706868892; x=1707473692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lZlVYUMXV1uG1lPKruohH2q+GDTjW2b2ufZSNU1KiIQ=;
 b=CSqSonoL6dPXmkz3PiCOBh6X7jtZRh+YJCzs3yHS3gp6U6Dxy8ezJgg7rdggrH7UTm
 pKFNAcs8pDmlnYiTKYJLfDbktaCFwI569zupT07LNXJiNWAVTh/upZYtAvUaDPNCa7na
 LxN+ITtucB+WnhW8CVpmxKBfCkav52JEyyP4utdz/JoYFC5p6Y10ijaciALOgLGsXKwj
 Qrx5f7UMQN8C4wK+04NTfsZ9wOzDdK1LW2ranc4kVTlZtveL0xEyZvL3O7HIHnThroqa
 SgfLy6iDDkei6EYdA+kQZAWXo4uCxluFPH+qZpgfk8WzF00cZT5DK5BXHc5VdnDukBdg
 vXig==
X-Gm-Message-State: AOJu0YzdWtBLr/E+PDcZHpP1zHSgLyjz7zTENDOxVjxh1wbhhJ7Q0Ysa
 mywLQ3tgCWtLUF2UYHuITBhNLMYJF+dD74AnpZxRXgH3HvgDVXaI
X-Google-Smtp-Source: AGHT+IGaEVyW84PteCebThNbRH+aqsJsEhuVNfykEn5Yr/jJH2rP1zLz+P9s+Ijfn0JOEEZs4aB78g==
X-Received: by 2002:a17:907:9502:b0:a36:cd96:4b34 with SMTP id
 ew2-20020a170907950200b00a36cd964b34mr973635ejc.54.1706868892328; 
 Fri, 02 Feb 2024 02:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWWvQn9wWb4IYYUaChZ7YIbERTk9BtSuQZOES8ZI5rYDlhRmbgqVKsENFcmzFLjAJwPX+cv1u5iH6MNQBxfnv2Zh22huYzKguBdZnD+YMDVs94TZEIKvRnP50jsYc4gaW7ydkhjmDoV4qbG+uCE0ku2/XzEXIzz3Yaq2WS6JZS5TAA/eEE3BMPSinHL0m5lXrwlHboOHfIpfEtrUxe3heu8BxaSRAtknO4lMerVfXo+m/4pME61xtJpqRGpmqBWmhOnddNhN2MFnjm3XwzfXAgJRSm3+2oH9dcC1E7vdgjL/o5DW6O9xs56vr+TFDymB/ZLimgmmwQgrAW5BNjDH7Co
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 ll5-20020a170907190500b00a36fe6fe976sm579722ejc.190.2024.02.02.02.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 02:14:51 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v7 0/6] Pointer Masking update for Zjpm v0.8
Date: Fri,  2 Feb 2024 10:14:33 +0000
Message-Id: <20240202101439.3714106-1-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_POST=0.693, TVD_PH_BODY_META_ALL=2.546,
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

I'm terribly sorry, but previous rebase went wrong and somehow I missed it.
This time I double-checked rebased version.
This patch series is properly rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next 

Thanks

[v6]:
This patch series is rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next 

[v5]:
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

[v3]:
There patches are updated after Richard's comments:
- moved new tb flags to the end
- used tcg_gen_(s)extract to get the final address
- properly handle CONFIG_USER_ONLY

[v2]:
As per Richard's suggestion I made pmm field part of tb_flags.
It allowed to get rid of global variable to store pmlen.
Also it allowed to simplify all the machinery around it.

[v1]:
It looks like Zjpm v0.8 is almost frozen and we don't expect it change drastically anymore.
Compared to the original implementation with explicit base and mask CSRs, we now only have
several fixed options for number of masked bits which are set using existing CSRs.
The changes have been tested with handwritten assembly tests and LLVM HWASAN
test suite.

Alexey Baturo (6):
  target/riscv: Remove obsolete pointer masking  extension code.
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
 target/riscv/cpu.h           |  45 +++--
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
 12 files changed, 158 insertions(+), 546 deletions(-)

-- 
2.34.1


