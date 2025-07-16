Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26649C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc3bA-0000Fz-Kd; Wed, 16 Jul 2025 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uc3KV-0000Tc-DZ
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:41:56 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uc3KT-0004Bz-21
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:41:55 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-31a93a4b399so14102a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752676909; x=1753281709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sBiX9Qv2y3zYZPcpMCcNdMelG6HGZjKASmpE9pXFX6c=;
 b=TJ1lPCzr864IDk0vl4aTUiWRBL5gqS+ZiPlNhnewAYBWfa+cfYO9JlnxArshOKPE2q
 Ua0BTwC8par83FWrby5Isi8x+asRIk79pHgT8yFumBKjy5zsKPeGoP5SrDQtPk0VqbvG
 NfhokdQ533p7gPTpbbyMFYomqU8CgB98BCHmFFPwLtqPtVtqTccDCM15eEf8eAnN7Hsw
 UsD40XNTOTIukBmnAu3xi+1CtT3Bi/5BG2myZG3BOeZLkx1lJlJ+25k/DSBv3HOH/HWh
 4Uh9IIURn6rjxj/mnP2Xfp5uS/0t0XpOjB/Fk5ZbeD7ycKd1kflvpggpLtYxME+QprIL
 5sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752676909; x=1753281709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sBiX9Qv2y3zYZPcpMCcNdMelG6HGZjKASmpE9pXFX6c=;
 b=l59niD/EBaD+DqY4txbi86Ipzij52xt7v8PP26tdcw+PNhm/h7to9W1U9pz7UJ30f2
 SSP/YEhJFaODkWigrZL+NxFJyJr3v5KSxpbQRtgR8LRId/Yh6JCz+xbd5ztp+KRALNNm
 L+gedCGCg+1fYuYjhwh1buhuzFbdwWyrRezSCIZNnYF1P8u1U2WpJNp1Od8eT3WOIbm3
 LptLfxjcgzJnAYJhOpKJpPiHuFuptmN3hT+yaYPJU/geZYt+Jgj0lsb6M5q0YFPQVDxG
 Q5TTKD0ABNd6VcmopP/R+QSfxeGg3e6RHBTQag6l2QDtao9TCAdQRAJv7VI7dWb66vC4
 zqcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVD4ZNN9kG/MqMbKb9Oaz9JKGAmd1P41p+NWXfV5o1tGywpQm18+Wy7NVABlNINncAAGdKg/JdhOAL@nongnu.org
X-Gm-Message-State: AOJu0YyO+ZFhr6DFXajdRqmk2yo5lBsR+0fHqQsC/3MeGeQX6MbBTr8A
 EhTJOXmOL7Rb247iVeDckd5nAJliLQZ4REeB5kuUzu2lBs95s8UOBXruKw8c5VP0t4c=
X-Gm-Gg: ASbGnct91q1iqYGF95ffquJ4wMzRHVdv6YhVtOVdYIAQ2UpJJ8ynoGv0oIh9KmFBCVN
 T9KmcYyNom6a4eXMt78Nd/vp/8BCuJWvca+tC34pB/nERNF7PvTvJ7+c3OrssoVFZ9ZuJBvNq6G
 1Lt5/IG6+WgocGyJ3kKy5/OAjaNpMSO6zYIizz/hTleqygmh275IJsSRpDjIgdyKTwaB5XlAtZm
 +1iAW+P/W1c09P5AM/w4KxPXLuR5EewtEVNQbd7gbWe74up0jVnNDCAs1pf9TcXt+lg+KeLJcW2
 5h2iCLdgl9PcPcHQ4mP2N2XSppcONnm9YyTH51/ULe2MHHl/aimwtbEOYb5DN9dagYnLz4mZL8v
 kOIp+xUZhZXg4tP+fbrCroRWpAd9iqeyM
X-Google-Smtp-Source: AGHT+IFXxgy9VmS/fdIfJkVrDghoxLMv8+ztk1vVXfWTeLKn1JR8efa6KrQCL6YvWShMGmRZy51yNg==
X-Received: by 2002:a17:90b:4cd2:b0:31c:39c2:b027 with SMTP id
 98e67ed59e1d1-31c9e6e4200mr4995522a91.7.1752676909388; 
 Wed, 16 Jul 2025 07:41:49 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f2879fcsm1622950a91.28.2025.07.16.07.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 07:41:48 -0700 (PDT)
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
Subject: [PATCH 0/3] RISC-V: ACPI: Update FADT and MADT versions
Date: Wed, 16 Jul 2025 20:11:37 +0530
Message-ID: <20250716144140.3954431-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x1030.google.com
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

Sunil V L (3):
  bios-tables-test-allowed-diff.h: Allow RISC-V FADT and MADT changes
  hw/riscv/virt-acpi-build.c: Update FADT and MADT versions
  tests/data/acpi/riscv64: Update expected FADT and MADT

 hw/riscv/virt-acpi-build.c        |   4 ++--
 tests/data/acpi/riscv64/virt/APIC | Bin 116 -> 116 bytes
 tests/data/acpi/riscv64/virt/FACP | Bin 276 -> 276 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0


