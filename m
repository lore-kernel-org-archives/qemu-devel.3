Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F9EC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetkB-0007ty-5L; Thu, 24 Jul 2025 07:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uetk2-0007Fs-HG
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:04:03 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uetjz-0000YB-Vt
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:04:01 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-74931666cbcso794358b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1753355038; x=1753959838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hBMx1ZFliy34yrVUFuRLjpCpKWV+U6kEM0DDy4g1qqY=;
 b=Uo4QNjRBPa0HBdpcPF0LcgdFMRZxR9ueg6+3/HAHeo7WOXFM2cY9jnG1ymGhIzvw06
 Q8ByWypKEY4tFEzBECeb0jm12zWXVbAAOFi9IXtV7gOEtjo3myOu1g5yzPvOybBX+v3p
 //CzLX0kT37ByakkdTYQG+JEEih0IM4spHawgJjOYKzB5N0ysYRTdR2TMKwft/VEmaut
 8zNHr1XXzsQvsfvv4E1wA7JckBgamV8I4Hg7/9tviSUkji9K0dk3xAAgrNlkXysI2gLU
 Pt8OA2Duz5Ofiz63gcL8m5WiLSeKDILmeU90dI9RVSM5dp1D/m70tTZIy4dmxRyzBKGH
 Dtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355038; x=1753959838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBMx1ZFliy34yrVUFuRLjpCpKWV+U6kEM0DDy4g1qqY=;
 b=sVj3xPJVQLoBBkQ/3SeJG2+zkpi8vCWc4Kq2wYmbHHvCwnbUYhu1lBek95IeVqnlVz
 Lnwrx1gfpWlL3v9nWG8mCJlM4G20xusHebABNoI4kgD6JKjUIYLFqde1jwlWDB7hXkl+
 BtMO1cEyF4jTParMomtL6PaBoPGnKhi9syb9YbHWopWGpnUaAXTgCOCwsBMI49Y98df/
 /0P3pYZc2rFUJNFI9bI1cd/z1EnQ1eNESy/yiEnNd6t+Tc0WRbF7JDjAaLLbutMoLFLz
 6oLTy4CuYKL3wsR/qBNQ1EbOB2iqq62hzI8gr9W+91/ZJqHOFcvt3uOQEoyHDYgUxjTa
 /xOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1FmEGB3SO1Ya7fLV43TGj5vjVmUmMdBBFs8rVqLda5jUcI4Jt/5W1t0qeqprcOFdEOHk4j4G1Lqvx@nongnu.org
X-Gm-Message-State: AOJu0Yychh7r8a9Q+JM/0ZDU1xWyVPTiwpoqhGE27c8bivGVNj7RDDFI
 H3JRO5aH7El4EcBNHJCSsOAWi9olFsQ+7wxokVA3PWmQ9vlYsQQ+zHgUNX4hJFbhjmY=
X-Gm-Gg: ASbGncvswu9JMfBVE+0uGZ+J8c8Ob7c7yokUxZIFkHcCYUct3F6272/LmhLcqMzxUKL
 k/FjdFj830cek/096rOys33aF1rGlgbcA4+fBlUhm6inyw//yAuzI2b94HIJAdu+frKQEUYYNyY
 GrnWxifjgO7y6z4QMpOfcRc7hX5P0piJ8ydr0Rrwvw9VvPL0ULK81OMvNpUImCPoz3zeirzfZCx
 hrZLh2J4HCxDrquhYyS2r715/aDWBu6ixxE7J95V6dRGy2hQG+4H+uI5CprnsOAQCDfycwRB4T1
 A8JAaeRHTtZzu20+e7GmvTaqPTaV6o0PLuR50cTYnO8lOl7CXNUObZuqGK/0mbdUqoQHPCgHYf/
 ycNj4Jj8yqO8DffTMpx3orbJVgaYHz6b4bzBOpxOgQcG4A5I0
X-Google-Smtp-Source: AGHT+IF/Q3qUB3u9FBCxsaqywOnvvPhKV2G6wFV9t7+kZdgbV/b5sajpx6NG5lGc25YqdoE20XRP+w==
X-Received: by 2002:a05:6a00:22d2:b0:746:227c:a808 with SMTP id
 d2e1a72fcca58-760367de961mr9472647b3a.24.1753355037942; 
 Thu, 24 Jul 2025 04:03:57 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.219])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761add64fd1sm1430578b3a.13.2025.07.24.04.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 04:03:57 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 0/3] RISC-V: ACPI: Update FADT and MADT versions
Date: Thu, 24 Jul 2025 16:33:47 +0530
Message-ID: <20250724110350.452828-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x432.google.com
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

Since RISC-V support is added only in ACPI 6.6, it should adhere to the
expected FADT and MADT versions. Update them.

Changes since v1:
	1) Updated code comments to reflect ACPI 6.6 chapter number.
	2) Added Michael's Ack.
	
Sunil V L (3):
  bios-tables-test-allowed-diff.h: Allow RISC-V FADT and MADT changes
  hw/riscv/virt-acpi-build.c: Update FADT and MADT versions
  tests/data/acpi/riscv64: Update expected FADT and MADT

 hw/riscv/virt-acpi-build.c        |  25 ++++++++++---------------
 tests/data/acpi/riscv64/virt/APIC | Bin 116 -> 116 bytes
 tests/data/acpi/riscv64/virt/FACP | Bin 276 -> 276 bytes
 3 files changed, 10 insertions(+), 15 deletions(-)

-- 
2.43.0


