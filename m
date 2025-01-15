Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C130C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3mg-0005u1-Cg; Wed, 15 Jan 2025 08:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3md-0005tO-RN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:12 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3mb-0007q3-9l
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:11 -0500
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-3eb790888c6so1805522b6e.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736949007; x=1737553807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4/zMR1ds0rMewx+rvOE2sEE1ZAiNyaqJegyvUM7C3to=;
 b=n5It5pXanZvE+NG085rILl0Dh7cf0cCBpQ7VfQgBmAGFcz7bhTuKxfOgztf/KjUHIM
 4jP8Aia6ZJNS7aeDmAWfl8CKurSaI+uW+5FACcbaB9UiGgn0rvyGDkEFZyVf0+9W/GlM
 x9OvLeiqPU+iQWc6m9dsFnpljNnmNX/D9Bi9aIGO9NahcuG/Gxj3+EnBNLnsOz/qJ5SQ
 6gCwJbyxsH8h0blYiJuHWYpF8MgvkCyumN0JoBpsAnOB917IBAjasxvTUhEHllYTiddE
 CrOf/mixW6/ho6oDaoIcvuzjZ3nOoGIduxqji9+2y6UyCv0y05NXA4geqoWWbY/SGGOt
 Jmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949007; x=1737553807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/zMR1ds0rMewx+rvOE2sEE1ZAiNyaqJegyvUM7C3to=;
 b=aL0iwuoWD7pGAA2pDg8Jw50TdWxf2b3cCwIqXFj0hgR7alNvtvIffKMETAx2cDVLsN
 4kIQ1Ikj7fWJ3M0esEHko1idYbjOlSF2DnYNeO+7SJ0W9a4dFWZdqrk1FUCBnvpbOBFI
 8pJf4pKEAeLt5gnciUGCvH6W33GMV7UwX1Vgu9Yx7UT72xdFYYQJY0Na6mpOFrQdzKcD
 +i2j/+X3X5jxSxHmtZ7qy4q6cac6EtqTudQHqNd8cxbS1/o0sSa2FNW8bwetFimxJ5TL
 //cz26epma8HNoJO9HXp+tgCT7Kh9Zx1NeCdNEOoMGxhN+eGrR1O5ztMV1OJFuMN9s2n
 /Mbw==
X-Gm-Message-State: AOJu0YzTDyPkXUq6uuGqoxyRooN13EoTIuYIcrXagAft9WSDRZL1vaIU
 /ka7UbUjE8KUTzhHjBGQRw2uHyk252fNYF9b1eibYKJFBQv4frAwviEZYugzGJ+IzuVJW6j8gqv
 qvn6Akw==
X-Gm-Gg: ASbGncun7EoKrbID2zWWpdmkN+9EAY7q40gqSLlZcMu4NxvpU5K0D+vhq7lAIoow/Sm
 ana5umD83fP6peZCOru6Mkc0yt/uLCetjAFee/KDHP1OcJfA8tFe+NGW3dgmDL2zehtOMjjzs/6
 VgFUm1sFM/aOwj2LbcYRmOk/x3lsXikflH9nMooPpptylsECTE8dyVxHEBrixFKDl5XH4jG/KdP
 46z1+QmBmpO2Pw9zWwVyxlEMNC/It6kHeinvQ2KV33YzTSVmGyo9XQ0JjI=
X-Google-Smtp-Source: AGHT+IGb0vdGFASrX+ZEbujEPC4Om/XnCvnQxX/Vao9ha9jYDCrw1bx8847R9IvBLQfOILXdYsF+sg==
X-Received: by 2002:a05:6808:11c1:b0:3eb:6326:78e3 with SMTP id
 5614622812f47-3ef2ee3b6bamr17483593b6e.38.1736949007666; 
 Wed, 15 Jan 2025 05:50:07 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f0379eff69sm4952177b6e.41.2025.01.15.05.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:50:06 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 0/6] target/riscv: RVA23 profile support
Date: Wed, 15 Jan 2025 10:49:51 -0300
Message-ID: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x244.google.com
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

In this new version we're now implementing u-mode and s-mode profile
dependencies, as suggested by Drew in v2. This makes implementing s-mode
profiles easier since those profiles usually inherits from both their
equivalent u-mode profiles and from a previous s-mode profile.

This is done in patch 3. Patch 4 is a change made to prevent a warning
that will occur after patch 6, where we're adding RVA23S64 by making it
dependent on both RVA23U64 and RVA22S64.

Patches based on alistair/riscv-to-apply.next.

Changes from v2:
- patch 3 (new):
  - add u_parent and s_parent attributes in RISCVCPUProfile
- patch 4 (new):
  - do not issue warnings when a profile runs in a newer priv_ver 
- patch 6 (former 4):
  - add RVA22S64 as the s_parent of RVA23S64. Declare RVA23S64 by listing
    just its own exclusive extensions
- v2 link: https://lore.kernel.org/qemu-riscv/20250114190001.1650942-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (6):
  target/riscv: add ssu64xl
  target/riscv: use RVB in RVA22U64
  target/riscv: add profile u_parent and s_parent
  target/riscv: change priv_ver check in validate_profile()
  target/riscv: add RVA23U64 profile
  target/riscv: add RVA23S64 profile

 target/riscv/cpu-qom.h            |   2 +
 target/riscv/cpu.c                |  81 ++++++++++++++++++++++++++++--
 target/riscv/cpu.h                |   3 +-
 target/riscv/tcg/tcg-cpu.c        |  37 ++++++++++----
 tests/data/acpi/riscv64/virt/RHCT | Bin 390 -> 400 bytes
 5 files changed, 109 insertions(+), 14 deletions(-)

-- 
2.47.1


