Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63F0FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHkur-0004kB-Ev; Tue, 28 Apr 2026 12:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHksN-00035L-2V
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:31 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHksJ-0003i0-IV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:30 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82f8cebc935so5048315b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777392079; x=1777996879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VyoGF5YcIVUpEcCgmiuR0pwDd2z2nWE4y3v+c++TnM8=;
 b=nrbtPPiuypevr45iv3H3c99PrAuWzRZyzOyZX905IFzMZJxtcLH/JZ9cqdM4uJP6aU
 p43g5dNVJ1rZn89i+ZvAIs1r2wIHMI2nUwQEwb4jKuW1R5CJq/N6ZPFgMWc0rMvDh5Uy
 0ryI9cXI8loImxy5L8Dc763go98JAurI18v8GMDJ7nqeCtctLoL2MxpcjaVSGcpCj950
 Ei8VBWVZp9ZbXvRPDklwrsMjHxdvLeMqJTwVh8sQcDZV9AStfxTUAlwGrsFEw+pOAFTp
 6irYfibl3NZ88/JDxAnecu1aHXebKTLQYAQeh7lDZrvy4p6mrjkOGNCTuzSOYlaODNo+
 Zzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777392079; x=1777996879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyoGF5YcIVUpEcCgmiuR0pwDd2z2nWE4y3v+c++TnM8=;
 b=ene24z0ZT+1JqHxEiM6BKWbvEuwZoYccdII0TBKmipAN9kzMsMJTNa5ihaVEeTVr29
 OAMzW4PXe72F2fLLaS5YUsxk5wkdrOwapzXBVjwHzftJtniscnx9n9n25odudiHO8bB6
 0RgXldo8jJucdGL+Yo5Pyq0YqxtqTNieNV5piHMHJyrKhBnf4Z+04dQQkIU5rhe89XWB
 mkexY5JO1gGGnnEJgkgZ3f2w0QEIjcyekvXmhuH9WwEOKUD2V18bXZKTtsInu+BbK9/C
 9Vi/lbzDBoPf3XCsuz2lbzot4Im2dgFOs5gAzG8hZ0umNrZxnZbBEn6LGsWCBIuKx4Y5
 JIkA==
X-Gm-Message-State: AOJu0YxJGDjlrfaLopuSijfco800rRVedalwl4v0zV3U4AVK20qaqcDZ
 56t6O+bavAzL0Pc8eGisIvNoqxbyPA0fFAVKX1qII+TjmOlPxGz2P3P7ZUe/lB40gwdgagZqEPM
 diWoMc6jkDoXhzcXNT7RZl1C7u0eKpwOOiDi91//oQs84a/0BmaPkpb8q1029NVNpyu6H9yr26U
 LEFyGyGMoSm0fzunNWouDptJPcA3ynGJE0tIwFGq6r
X-Gm-Gg: AeBDieskuNFiHFqV4Dv2ZVRXIL9AReEIHKVTKEpa1L78Ls3Pkoc87wRc8T5KeYe7/WM
 +z2yXJ5tnwDgDEOeRcyqqKwji7pQofTBXBet0+uQ7BhOd2mtmCb2e5yf9+rgczRcQ08FCfydo5A
 /l/nwG/BysFlNtRLk3bDHdiz/mC6jgYDlnQtJaWsy2LjyWExvup20IJm4uyhKMNuISycnbz+LoG
 WRhlV+dkNAkCrE0DV32HbEEVfIsxpfzkPQ/XsJrwACrPCi/61wIt3iisIuy7ZHJh6HpwoXcl7YL
 j4Jfap2sD9oh4GRk5yOxsKmZbI7LXYJViUsWqtbMyvtSSCISflXdPfeGPFAoviUPbRlvHVEwFfl
 t8cMSkOReaePlF+nqM0ewWZePTouj4os0+OZ2+FeLycwQClwcikPXmWl3zR5gAIMsB5vf2CArpF
 NWIakFjbHn7EPylfn/4wR6m889SjOg/mv/Fjc+A5Ot8eITuKTf99FSqpg=
X-Received: by 2002:a05:6a00:17aa:b0:82f:761:2b44 with SMTP id
 d2e1a72fcca58-834ddc91865mr3590851b3a.50.1777392078417; 
 Tue, 28 Apr 2026 09:01:18 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834daf30fbfsm3002331b3a.33.2026.04.28.09.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 09:01:17 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 0/4] Minor fixes and enhancements of RISC-V AIA devices
Date: Wed, 29 Apr 2026 00:00:59 +0800
Message-ID: <20260428160103.3551125-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42a.google.com
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

Bugfix:
  - APLIC should also clear pending bit from rectified value when it is
    in the both level-trigger mode and direct delivery mode.

Enhancements:
  - Add reset API to APLIC and IMSIC device
  - Add trace events of APLIC read/write function

Jim Shu (4):
  hw/intc: riscv_aplic: Fix level trigger IRQ in direct delivery mode
  hw/intc: riscv_aplic: Add reset API to APLIC
  hw/intc: riscv_imsic: Add reset API to IMSIC
  hw/intc: riscv_aplic: add trace events of APLIC read/write function

 hw/intc/riscv_aplic.c | 116 +++++++++++++++++++++++++++++-------------
 hw/intc/riscv_imsic.c |  19 +++++++
 hw/intc/trace-events  |   4 ++
 3 files changed, 105 insertions(+), 34 deletions(-)

-- 
2.43.0


