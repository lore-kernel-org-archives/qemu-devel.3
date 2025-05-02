Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C009C3ABA5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh7D-00047A-Qi; Thu, 01 May 2025 23:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh79-00043U-ON
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:04 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh75-0001Dw-Pq
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:01 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso1492153a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156657; x=1746761457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=30ZFIhc++9MoqbudscPtyZp5zXhPuw3g4MrVdzAXBYs=;
 b=ZYjNWEYW3dq8vdjRqn2quphdjj9ebuo+6oilbaLlWCLA+VkIM88fhHC+ZgbYGp2FJf
 7c3oH58kf+Rdeb1QkODJ/JZPzBNOdTZzq5jhHNhlngilwIsJkTIKIFjq7ZfcDlihY1ze
 kBwcN2PidGKhBJA2qyUJ1DNRmhRSw5F7jj4zpMPXVyxEPe2xKodGZyPTJ4eshlYNEm3O
 PtFRMt0dpZpl+DJELtgw8d/8FqhS1YRlPvh28jOzws1cQXp2GBs+cZ4DG+L2Q31hxb8n
 LiwlwV3/VTEbVK29T2radoKI2dL0t31tDS1l14DUOmSewSFTctNQVN70CiRfz4xeCCol
 4JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156657; x=1746761457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30ZFIhc++9MoqbudscPtyZp5zXhPuw3g4MrVdzAXBYs=;
 b=NX52zYXKmFMwwancmn0qr2tXS9d5wdhsXaNG/cFafT+aiDdx2of/cdqg3OKxapzxMR
 F0oEJ/H3RuDreLz9Kr6yC1hm5gQFqHPwYtL5mPHhWwY5NYnGKfVv2AEDl5JoOJqWJYZQ
 /fF3cIMfT4yVQ+4PY93CIgvy/hV8bwbxZLN2N8y5Pa3LZtM7eQ8In31vnPj4mjJmFctW
 mhkOziu8Q6k+OdRJ2ZHy3yVqznkNb4j36T9JtpcV6kjZ3RWpZQA1g/0Lznt1I+sraoGN
 xLASBCsLnp71DGDedakiZi6EaTGZaOhVfFzzGsTK682CIr+LwhzqrV0/aE+ADVMPyDhg
 zz9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0mI48dzv/QqNaDucxpOYY5N5rXuxEImwsc5F2JIN2kzhsK2tHmWlerLpDd87USAT8siYxLHCyPjqn@nongnu.org
X-Gm-Message-State: AOJu0YykwnQixakhhaaL/HYphN87pUdYhh1WR8G1mGguOGV3r8LuuVeR
 KUTDxcHY7B9ylzWI80fVtJiznAUzrgQ2av7PYXR9oCzrunfGIhua
X-Gm-Gg: ASbGncviLzbXoqYQN2kb81Tf8KkjQ1bDVuZf/zj4KsNg2W39gEEeDuJ5OPrr6dhbxWA
 o9xU5MT1VAfBTK2NZad5eFEJpWvySFOTg0i166/6B1KpEa/rkNo3/Cr89TRkUp4Q881K4xigX93
 JXrGaxiSBK3dD2OFIqrxTChtHqHA2lORYsulIeIrVIMJynygYFZGi32ApaxGscroMarvwoKKDhp
 lhqAImSyz/6p4Y7Vk+LjCv6oBL/XG/WY+uMO65WBNKK87asrPyGWfZWfp2BR+pmc+jal/Dz+eZO
 tqTdRZlyOMCr0IStiLGr9zyPUvtz8jUkQ14MyPuevFBE
X-Google-Smtp-Source: AGHT+IHB3hlpJFij0bFtxTmtmE9ETNh7hfaV+e75BauZDueA3wnar+coVO+6+gjGdKITPVFfOgYfOg==
X-Received: by 2002:a05:6a21:8cc7:b0:1ee:b5f4:b1d7 with SMTP id
 adf61e73a8af0-20ccbf33d54mr2225204637.7.1746156656684; 
 Thu, 01 May 2025 20:30:56 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:30:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 00/22] usb/xhci and usb/msd improvements and tests
Date: Fri,  2 May 2025 13:30:24 +1000
Message-ID: <20250502033047.102465-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52b.google.com
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

This is merged from two series now because code especially the test
cases have started to depend on one another.

The series are "usb/xhci: TR NOOP, TI HCD device, more qtests" from:
https://lore.kernel.org/qemu-devel/20250411080431.207579-1-npiggin@gmail.com/

And "usb/msd: Permit relaxed ordering of IN packets" from:
https://lore.kernel.org/qemu-devel/20250411080431.207579-1-npiggin@gmail.com/

The qtests also depends on the qtest fixes:
https://lore.kernel.org/qemu-devel/20250502030446.88310-1-npiggin@gmail.com/

This series adds better support qtests support for the xhci controller,
adds support for the "TR NOOP" command used by AIX, and adds a new USB
controller model from TI that PowerVM and AIX use.

It also permits relaxed ordering of USB mass-storage
packets from the host, as allowed by the usbmassbulk 1.0 spec, but
not usually seen in drivers. AIX drivers do require this ordering.

Since previous posting the usb/msd series had some changes that Phil
noted. But otherwise the qemu code is mostly unchanged. The qtest code
has had some big changes, cleaned up a lot and started adding some USB
Mass Storage Device tests including one which verifies the relaxed
ordering change. It would be nice if we could plug these into more
comprehensive SCSI tests, but so far it mainly just tests the USB MSD
protocol.

Nicholas Piggin (22):
  hw/usb/xhci: Move HCD constants to a header and add register constants
  hw/usb/xhci: Rename and move HCD register region constants to header
  tests/qtest/xhci: test the qemu-xhci device
  tests/qtest/xhci: Add controller and device setup and ring tests
  tests/qtest/xhci: Add basic USB Mass Storage tests
  hw/usb/xhci: Support TR NOOP commands
  tests/qtest/xhci: add a test for TR NOOP commands
  tests/qtest/usb-hcd-xhci: Deliver msix interrupts
  hw/usb/hcd-xhci-pci: Make PCI device more configurable
  hw/usb/hcd-xhci-pci: Add TI TUSB73X0 XHCI controller model
  usb/msd: Split in and out packet handling
  usb/msd: Ensure packet structure layout is correct
  usb/msd: Improved handling of mass storage reset
  usb/msd: Improve packet validation error logging
  usb/msd: Allow CBW packet size greater than 31
  usb/msd: Split async packet tracking into data and csw
  usb/msd: Add some additional assertions
  usb/msd: Rename mode to cbw_state, and tweak names
  usb/msd: Add NODATA CBW state
  usb/msd: Permit a DATA-IN or CSW packet before CBW packet
  tests/qtest/xhci: Test USB Mass Storage relaxed CSW order
  usb/msd: Add more tracing

 hw/usb/hcd-xhci-pci.h           |    9 +
 hw/usb/hcd-xhci.h               |  237 +++++++
 include/hw/pci/pci_ids.h        |    1 +
 include/hw/usb/msd.h            |   21 +-
 include/hw/usb/xhci.h           |    1 +
 hw/usb/dev-storage.c            |  532 +++++++++++-----
 hw/usb/hcd-xhci-pci.c           |  118 +++-
 hw/usb/hcd-xhci-ti.c            |   77 +++
 hw/usb/hcd-xhci.c               |  527 ++++++---------
 tests/qtest/usb-hcd-xhci-test.c | 1056 ++++++++++++++++++++++++++++++-
 hw/usb/Kconfig                  |    5 +
 hw/usb/meson.build              |    1 +
 hw/usb/trace-events             |   11 +-
 13 files changed, 2043 insertions(+), 553 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-ti.c

-- 
2.47.1


