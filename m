Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C43D75E29
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 11:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tERhY-0007c3-DL; Fri, 22 Nov 2024 06:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tERhW-0007b2-G6
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:19:50 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tERhS-00068r-5X
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:19:50 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-382376fcc4fso1170165f8f.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 03:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732274383; x=1732879183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mHjwH8Omq3FoUPGkcn+klfTPJMxEmXl+LJ5UDCnqOj8=;
 b=bcaoGH6XCRlmUrwfCRb+8BTb9d8P0vKSPHlAZO4pe4MAljSB7ILRK9RZsKRukxlhDI
 OSonueNCg73FWzSaq41OtxNa9bcpT0AeZRCnoTztlk63xxZvmRdeXJd8Zjwv/jpajP4c
 /Q0+wHvU9+L0l3b1e0JNAq/UXhE4YEuaIOnohoU02vW8MrTBBe02iVcNImZBQBuTEb5d
 KPfNB3G1LFDJoVeA9WPaTDvp94yt0pZhtiLrIbEJ1rO1e0tAaJGGX/7mj9g7mM2wO7lL
 ZqEnYUtNzQQ1rAJojHya/RuoWWjFsbBSk9Q7h4mMLJfLwitOAWHQ9GfrmspZhQyK78fF
 Tlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732274383; x=1732879183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mHjwH8Omq3FoUPGkcn+klfTPJMxEmXl+LJ5UDCnqOj8=;
 b=TyGX5NIVsigZCoSpCwqPUtTyzrlZVl9JVkZQg7rf/BJL7tTnQ72yCKyb2G1FiE9Kds
 c0fQNOc+aca6l08cl07ed+WSWIC6oVaDUVxaEb/X0caVmx8ZfEB1A2TJqZPujek03cH6
 Rntqx8wSQ1ksbhmAeUITYD/aE19DW1SJ7ao7kfs1i8cM2PJAbMKyDqO4BSAiIhBoiKvi
 81iwvYegG2vOpREOrwP5kKJwzW27dJ+vMGLBZQ5HA/tXkZhn8CCBtcGtvAEWg1R+ArbS
 ib96cwDZXICjclKjaprWXqi5IBl8bz8XUUvwwmObxGKZUKjO+Egj8qYy6SM59q/roNdF
 aD4A==
X-Gm-Message-State: AOJu0Yyc7Kcez+6mDJfiudGLMxXHpLSse4r8zYjBKOke8nY7Xvh95arT
 HLR445TeM+BjgU5scAoeEdKjyKda8iKQGOV4wFNATuNK5wupJMRZTPEVOKFEg9T9A78v0pjnGEs
 X
X-Gm-Gg: ASbGncv5J95COzXy9e65QH+Ng05zwKei/ByFYHjBDRhnFmN8ublPnJqTnAemrFLXX/j
 fkorSTDgXFtaG686ODHD949BAkp5ir9lg/E05/cpiJzw2qoLFfCpAUzb+brjGcXMJ0lpXnsibTY
 5CKVheazcQdpxCGN9GBQp9+D9rbv1yK7DTAaG6LTEr9cSOdPauK2XP6CDgfgNyi2pX8HLxmLMu7
 kzkk1AyfHtD4M/TY8A8yVcfLpwRE7OvZe2WfIN7+RMCZXd2dcpUyi8ycL0YVpmLzqGwqUhXbInF
X-Google-Smtp-Source: AGHT+IE6AAZnk0MXFi+XCLgtgIydcTH/X4VSLTj0V2OLyRRgDXSUUD52pssq4JNWMtCVjoR4xpQIag==
X-Received: by 2002:a05:6000:184e:b0:382:319f:3abd with SMTP id
 ffacd0b85a97d-38260bcb8a6mr2234003f8f.36.1732274383309; 
 Fri, 22 Nov 2024 03:19:43 -0800 (PST)
Received: from localhost.localdomain ([176.187.211.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad61b0sm2155786f8f.7.2024.11.22.03.19.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Nov 2024 03:19:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Helge Deller <deller@gmx.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 0/3] hw/scsi: Cleanup around scsi_bus_legacy_handle_cmdline()
Date: Fri, 22 Nov 2024 12:19:36 +0100
Message-ID: <20241122111939.11936-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

When a device model requires legacy command line handling,
call scsi_bus_legacy_handle_cmdline() in its realize handler
instead of having each user call it.

This applies to:
 - spapr_vscsi
 - lsi53c810 / lsi53c895a
 - sysbus_esp

Note, scsi_bus_legacy_handle_cmdline() prototype could be
made private to hw/scsi/ to restrict its use to scsi device
implementations.

Philippe Mathieu-Daudé (3):
  hw/scsi/spapr_vscsi: Call scsi_bus_legacy_handle_cmdline() in REALIZE
  hw/scsi/lsi53c895a: Call scsi_bus_legacy_handle_cmdline() once
  hw/scsi/esp: Call scsi_bus_legacy_handle_cmdline() once

 include/hw/pci/pci.h  | 2 --
 hw/arm/realview.c     | 3 +--
 hw/arm/versatilepb.c  | 3 +--
 hw/hppa/machine.c     | 3 +--
 hw/m68k/next-cube.c   | 2 --
 hw/m68k/q800.c        | 2 --
 hw/mips/jazz.c        | 2 --
 hw/ppc/prep.c         | 1 -
 hw/scsi/esp.c         | 1 +
 hw/scsi/lsi53c895a.c  | 8 +-------
 hw/scsi/spapr_vscsi.c | 4 ++--
 hw/sparc/sun4m.c      | 1 -
 12 files changed, 7 insertions(+), 25 deletions(-)

-- 
2.45.2


