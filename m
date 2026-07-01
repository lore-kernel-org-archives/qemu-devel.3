Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E25FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wezYQ-00086L-Ex; Wed, 01 Jul 2026 14:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wezYI-00084F-Gp
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 14:20:53 -0400
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wezYG-0007C0-FE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 14:20:50 -0400
Received: by mail-pj2-x04.google.com with SMTP id
 98e67ed59e1d1-37d4eeb6d43so323083a91.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782930045; x=1783534845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dOnr6Y+NQPywOblP983nPUtaNV61EYqITfZ0uxBTVC4=;
 b=VGID1FtzjnoIiRHetO0YkB0Ld3klGH8EfNabXiFuUagWmzz/60IcMeDNqU98+AWRym
 54DPDvlPfDHCKL/pVpbb9M7bK6HgYzgY9Zm4Q+m30OqWfyNEaASjZBu81bM0J8mDiZJK
 kcUc245vcYrM5eLmChINlrq8W3TECzTHaWNtnsFoLBGw0tzAj8SztaXKubaXOEd5cG9N
 FYyV7vH3z2Fg15XfwpG8ybb6HlReA6/jtmJ91DfV5xjSSRE2rBORJttXb8GeTJQVybY2
 A97GS6YjKKJO3Y4l/97z2t6MHVxHDL2jP671x0H8fFfgB4/nIzU7OfeFEAKSQgcvXN9d
 I/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930045; x=1783534845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOnr6Y+NQPywOblP983nPUtaNV61EYqITfZ0uxBTVC4=;
 b=DPhHEcADAZE9AFXuEiDfRmzwwslclsjTH3aKEenaTaqbXfVF299D7S7q/4cR1Pk0Kc
 lks2r5M1+WYwEFtKSFKF2QrcUo3bB7jRiMYpR+Ph5W98wsnM7ipnapCtoImEraM8ENHN
 5F5FkJvadohoQWUBORWE26L6eqJqaaaHEK30AgASGez1hqxmxlVSMIhK704Exx7znV7E
 WqHg54ymJUJDyUVs7/Ttq0alvZuIK2JyqFbKItnLpzMYPG7aufYDhk5vW8YRVSizJbfq
 UxNsus+4fkx3ZZFPiNKa8iewz4Y9WfERMOkeyyO+KkQMQe35efE9mkljX3ghOARQcZoB
 VfKA==
X-Gm-Message-State: AOJu0YynG9KUWtcpNtzW51KvbG2UpvTiyyS7m7KeCFUwLMDiBtV2FSqc
 cYUzdOoXCpHppR6RrL8Kpyx10gQzBQtBCVV6mijrVcBM6dDdx9B/W1bJ2Pmjq67F2A==
X-Gm-Gg: AfdE7ck1t9PpflYYO+1DGZF+epWWH91lzNAnTZQLWODH3iCQhe4pbXVLbXrwKj5gdM1
 xoXoNZEfXm2Mp134TQ+K08ivr7evCsLrFeVDE9xJm8dZYRKHTxA5V9st9JDJbcOadMt+ojcMVBJ
 EcdzWB9A5aNqaOsKMIvshaEvecYp28pVnKMQbyHqZxQANhgo13qLeG/aHqjGytDn6PXiKZyZObm
 JD2sPzexPFtJea9L92jN5WCJdnTALO2ADGgULYeUyv4LKCWcS1HgjZtFLpz8BU/UDl71koonEdi
 DXvb0FlIzv4fO8FwflqaWCWXtZ26NKV5LY6xXBjNtoTKsUMnLFvMUJd1DhwjX6m1DySrIhXXcvw
 G8HD1PWdFHcl3XoeUJNr5c7gC1sipvvicd4HUG5Z84LvTyzKjL+lJCHMVENIhOUcgoivh2eVdf1
 pliNEF8fxkt7yMla8ogA==
X-Received: by 2002:a05:6a20:431d:b0:3bf:b182:94e with SMTP id
 adf61e73a8af0-3bfed0f6c9amr2730962637.5.1782930044947; 
 Wed, 01 Jul 2026 11:20:44 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffe:590:494:7c85:ae9c:cba8])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm187109eec.27.2026.07.01.11.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 11:20:44 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v4 0/4] vfio/igd: Fix garbled screen on IGD passthrough with
 legacy VBIOS
Date: Thu,  2 Jul 2026 02:20:31 +0800
Message-ID: <20260701182035.96010-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x04.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series fixes the regression that on IGD passthrough with legacy
BIOS boot and VBIOS, the screen is garbled during BIOS POST and GRUB
(which uses standard VGA output routines), starting from QEMU 10.0.
Though the kernel i915 driver still works, it reports an error about
the initial GTT programmed by VBIOS is using invalid address.

i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])

With the help of AI disassembling the VBIOS image dumped from host, it
is found that the VBIOS itself implements a routine like:

    uint32_t get_BDSM() {
        static uint32_t saved = 0;
        if (saved != 0) {
            return saved;
        }
        return read_pci_config(BDSM_REG);
    }

And the saved value is not cleared after initialization. Given that IGD
devices don't have a real ROM BAR, the VBIOS image read by default from
host is actually the VBIOS shadow RAM region, containing host-side
modifications like the saved BDSM value above during POST. When the
image is executed in guest, it still uses the saved host BDSM (HPA)
instead of the value programmed by SeaBIOS in config space (GPA). This
address mismatch leads to the garbled screen and i915 error.

The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
values in MMIO BAR0 and IO BAR4. Considering it's unsafe to expose HPA
to guest, a ROM quirk clearing the saved value in VBIOS image is
introduced to fix the issue.

During debugging, it is also found that IGD VBIOS ROM doesn't always
match the actual IGD device ID, due to the fact that IGD of the same
CPU family has multiple device IDs but shares the same ROM image.
However, SeaBIOS checks the device ID strictly and refuses to run if
IDs does not match. Currently only the default path, reading ROM from
kernel patches the device ID, but the romfile path doesn't. So the ROM
ID patching logic is also refactored in this patch series to also handle
the romfile path.

These changes are tested on Haswell platform with legacy BIOS boot, by
K S Maan. Thanks to K S Maan for continuous help on locating and testing
the issue!

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
Reported-by: K S Maan <kirandeepmaan45@gmail.com>

Changelog:
v4:
* Reworked per review feedback to keep IGD-specific workarounds out of
  the generic PCI code. Instead of recalculating the checksum in
  hw/pci/pci.c, a single generic romfile_fixup hook is added for device-
  specific ROM patching. Now both kernel ROM BAR and romfile paths share
  the same quirk, so the saved BDSM in user-provided romfile will also
  get cleared.
* Reduced from 7 to 4 patches.
Link: https://lore.kernel.org/all/20260617100646.28326-1-tomitamoeko@gmail.com/t

v3:
* Refactor ROM checksum calculation and patching logic as Alex's comment
* Fix boundary checks as comments in v2.
Link: https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t

v2:
* New patch 2/7 to fix regression with EFI option ROMs
* Refine logic in ROM ID and checksum patching
* Reorder patch 4 and 5 for cleaner bisection
* Address comments from v1
Link: https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t

Tomita Moeko (4):
  hw/pci: Introduce romfile_fixup hook in PCIDevice
  vfio/igd: Refactor option ROM patching
  vfio/igd: Setup romfile_fixup hook
  vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time

 hw/pci/pci.c                |   4 ++
 hw/vfio/igd-stubs.c         |   5 ++
 hw/vfio/igd.c               | 128 ++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c        |   5 ++
 hw/vfio/pci.c               |  30 +--------
 hw/vfio/pci.h               |   3 +
 hw/vfio/trace-events        |   1 +
 include/hw/pci/pci_device.h |   1 +
 8 files changed, 148 insertions(+), 29 deletions(-)

-- 
2.53.0


