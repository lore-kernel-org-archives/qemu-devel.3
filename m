Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20A2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 14:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL0nz-0007B8-5F; Tue, 10 Dec 2024 09:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL0nh-0007AH-Vo
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:01:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL0ng-00070o-4p
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:01:21 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434acf1f9abso53996535e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733839277; x=1734444077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Datbz+9X6Gzq1er7ALCf4IjQlEIK6u8ufTgOUCXC0FQ=;
 b=kyflqbPbAg+Xz/Hp4kFkRyRp/x78pOgD+VpPC/ZqbA3Bg2GIwNW7QoKz9DmBekWVAC
 EcYf8wNtu6OPlPZGFa3qYFzSCAT2JX0QQz6piBkngG55R7/qxGA05AwozCcJr2OQFbND
 FIMkcgWHr6KIH0AxtP218J0V+ElOC+vl5cqfZozKluf4mfRls1wLIzQ+y3TbYm+vhwuM
 2r7P20RM3DLqJaOFXM76NTMIGTehHfE3Nh++mHqMcVfVB2jck/j45QndBDwSCwKHx6tf
 LqexcWWB6gO6/f7YoyPneg3+Bu4VSQWeV9FPXEiQ6IvO8jh/MrLomJuuNcahW4ohOvya
 9Epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733839277; x=1734444077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Datbz+9X6Gzq1er7ALCf4IjQlEIK6u8ufTgOUCXC0FQ=;
 b=M/JxjohEZWluEkCDv6BL+mSbP+6GPKslieHXY+pr71pdxIEfX2bUTn+S01n9WMFfGd
 hgpwFFJE8tbz9+BeMdPifTdrrqYjEkAN2D8qKqnQnXY6N75ya4x9t0l3ViYBNezDC5FD
 uiI+7dXp3QnPsH6b4QErNnmYUt8uF6StJLKdTRmzhIKCEpmjGiHxeItRBZpwVS2HqF1m
 nLxP91+MWPyvPzigchC2YyCKezvQyh0mVGG5nNG4odv7JEUiJH4Bcn8PZ2LYOJA5mxK+
 kkeqZsnRqL4fBkXrqxe1MxDIeg00BstXm0BnzRgeJRryQKM/ehtvzbAVTxf0Bp3wlS1B
 33mA==
X-Gm-Message-State: AOJu0Yzp0GJjbZeff/snwXt6A9HUNs/lrKKO+z0Thxh+cwTgSn6XKcci
 3IBygrRu/xA7zxonML8UO7zVHpUIzVf9AqYCv7j/mhJgfsEpU2QIVYXmPj7hoB3slzu06n+dIuZ
 NVBY=
X-Gm-Gg: ASbGncsBQ+9/1UxgunkI9VR6yWlju5TV+anD3JQMmBCPGlOTy1fmBpVdBuHEm1GirRL
 x9zKqXOH/brXiiVV4sCzdmwtxbJVvxppIUGXX0NJ4sDC166H75/h20Bvnx1gwaUk+aSYuJbKhdh
 bHnoNCHIi03GO8a73SKZv9zm7FlPw0afdjqQc5h8G55wjGIQ4gXV8FqJegk4ZMzoEmVSKDNsOJx
 pGPelgbNLZJqlPeEpfBIlTgZ/+QUC6OXJTPUd9+09HxsdDcITVdr+a1rorR6I5cfIeCUNnAeebP
 sLh1ot4er1KzAVQJX5rXTcT4
X-Google-Smtp-Source: AGHT+IFk0FofuuPUg4CzQGsQal5SK1OvYDomzbSurC7tkuK1IKglha2OfhuIJY4coz2RvcgbRscX0g==
X-Received: by 2002:a05:600c:4f03:b0:430:5887:c238 with SMTP id
 5b1f17b1804b1-434fff3a2fbmr39337315e9.11.1733839277326; 
 Tue, 10 Dec 2024 06:01:17 -0800 (PST)
Received: from localhost.localdomain (223.132.22.93.rev.sfr.net.
 [93.22.132.223]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-435d4cd4a78sm17931215e9.28.2024.12.10.06.01.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Dec 2024 06:01:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] bulk: Remove legacy cpu_physical_memory_rw() API
Date: Tue, 10 Dec 2024 15:01:09 +0100
Message-ID: <20241210140112.43313-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

cpu_physical_memory_rw() API is documented as legacy
since 2017 (commit b7ecba0f6f6). Replace it by a more
recent API. Noticed while discussing with Peter:
https://lore.kernel.org/qemu-devel/e979b3ba-e701-4ac6-962a-19e4598ba947@linaro.org

Philippe Mathieu-Daudé (3):
  dump/dump: Include missing 'exec/memory.h' header
  bulk: Replace legacy cpu_physical_memory_rw() API
  system: Remove mentions of cpu_physical_memory_rw() API

 docs/devel/loads-stores.rst            | 23 -------
 scripts/coccinelle/exec_rw_const.cocci | 29 ---------
 hw/xtensa/bootparam.h                  |  7 +-
 include/exec/cpu-common.h              | 12 ----
 accel/kvm/kvm-all.c                    |  5 +-
 dump/dump.c                            |  5 +-
 gdbstub/system.c                       |  7 +-
 hw/acpi/ghes.c                         | 19 ++++--
 hw/acpi/nvdimm.c                       | 21 ++++--
 hw/acpi/vmgenid.c                      |  6 +-
 hw/arm/omap1.c                         | 18 ++++--
 hw/audio/marvell_88w8618.c             |  4 +-
 hw/char/riscv_htif.c                   |  8 ++-
 hw/display/omap_lcdc.c                 | 13 ++--
 hw/dma/i8257.c                         | 17 +++--
 hw/dma/omap_dma.c                      | 15 +++--
 hw/dma/rc4030.c                        |  3 +-
 hw/dma/sifive_pdma.c                   | 13 ++--
 hw/gpio/zaurus.c                       |  5 +-
 hw/i386/kvm/clock.c                    |  4 +-
 hw/i386/vapic.c                        | 42 +++++++-----
 hw/intc/apic.c                         |  6 +-
 hw/m68k/next-cube.c                    |  4 +-
 hw/microblaze/boot.c                   |  4 +-
 hw/net/fsl_etsec/rings.c               | 24 ++++---
 hw/net/mcf_fec.c                       | 16 +++--
 hw/net/opencores_eth.c                 | 15 +++--
 hw/net/xgmac.c                         | 13 ++--
 hw/ppc/e500.c                          |  4 +-
 hw/ppc/pegasos2.c                      |  6 +-
 hw/ppc/pnv.c                           |  4 +-
 hw/ppc/ppc405_boards.c                 |  5 +-
 hw/ppc/spapr.c                         |  4 +-
 hw/ppc/spapr_drc.c                     |  7 +-
 hw/ppc/spapr_events.c                  | 21 +++---
 hw/ppc/spapr_hcall.c                   | 15 +++--
 hw/ppc/spapr_rtas.c                    |  7 +-
 hw/ppc/spapr_tpm_proxy.c               |  7 +-
 hw/ppc/virtex_ml507.c                  |  4 +-
 hw/s390x/css.c                         |  6 +-
 hw/s390x/ipl.c                         |  8 ++-
 hw/s390x/sclp.c                        | 11 ++--
 hw/scsi/vmw_pvscsi.c                   | 16 +++--
 hw/xen/xen-hvm-common.c                | 10 ++-
 hw/xen/xen_pt_graphics.c               |  4 +-
 hw/xtensa/xtfpga.c                     |  7 +-
 system/cpus.c                          |  4 +-
 system/physmem.c                       |  7 --
 target/i386/kvm/xen-emu.c              |  3 +-
 target/i386/monitor.c                  | 90 ++++++++++++++++++--------
 target/i386/nvmm/nvmm-all.c            |  3 +-
 target/i386/whpx/whpx-all.c            |  5 +-
 target/riscv/kvm/kvm-cpu.c             |  6 +-
 target/riscv/monitor.c                 |  4 +-
 target/s390x/diag.c                    | 13 +++-
 target/s390x/helper.c                  |  5 +-
 target/s390x/mmu_helper.c              |  6 +-
 57 files changed, 391 insertions(+), 259 deletions(-)

-- 
2.45.2


