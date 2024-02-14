Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55902C4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7af-0005mc-2R; Wed, 14 Feb 2024 00:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7ad-0005lG-BA
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:13:47 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7ab-0007mj-Ih
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:13:47 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d94323d547so44857645ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 21:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707887624; x=1708492424;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nWxU/4yM5GizaWCUiJ2NPCFG40EAIJWszf2ugKOTMeg=;
 b=wPu2poQ9+ECtzhRX6Bq4rcA/R01chBvwe3OOyq6aurUHYTteX+WwL9gNFM06l6OwD+
 t20QTEf4fJTb5L96bbAmq2RvtwKdH7A9H9W7I5HHNYjhhooNNVXaj+16PT18JD/dnP/Q
 evsZJ2FHs+1mRZczEOPayo7j37/Sz6MSul0SG04gmXLUHsGyg1Pj9hq7vJ8urR5AIyue
 MuxjaBGeafaqGD0bXwkO/gyDaIiMg0s8XPje+7UPtwrz58LbLAUaTvM6JTyO411mA+H1
 VvHFLQqeekSVCGuYgU7IVzlNbZsxduKZDhIu0Gwq6kvXkRf492c756V/cK5iokLqPoMY
 MxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707887624; x=1708492424;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nWxU/4yM5GizaWCUiJ2NPCFG40EAIJWszf2ugKOTMeg=;
 b=O0E+wH4KBzGm1ImiZ8/9vm7ossQGVupQUP2niwO2z5m8jweqsaBKCypd1Phb7DaiRr
 Qkn/9ytW0WExXaLkz++LJ7TbqtvU941vWWzj5frsm/UXFwlWZWp3eKayZeBipau66FXD
 48tCGqkXHb4N0Gu6PTlEJT9pVPWI/SKebQbr8C88/xFhM7+gp7mu7Wvv7BSzSvl2FWte
 QtmSb3dev7qlq4swTXWAtoL/8OncdNioef5jDDJeYltgZTfic80skv2MB/MXg/uXY/jE
 GRweghejtk/m+BXOpylySp9jAiW6IUn9xhg994km1WAg0BZxlikqINRlb1w4fYxVQt58
 MKJQ==
X-Gm-Message-State: AOJu0YwnR+K8GLO9La1+kjkL6hdXt+KjiOD/s2C8PFxKdkBzuIS2/c2o
 0ELJRj4JtNfDoOjBRXL13O1dFv2r/lC/MPMfVFUkehjBUJkP17tY0cw12WL9kxM=
X-Google-Smtp-Source: AGHT+IHkAWux9B3BWif7h0lEywdTlXw7w2ecZ8zj0eO+63GNuZQZ1ogCwggjEVapSJ3GQdHwhfKh8g==
X-Received: by 2002:a17:90a:db45:b0:297:eca:8381 with SMTP id
 u5-20020a17090adb4500b002970eca8381mr1522805pjx.16.1707887623995; 
 Tue, 13 Feb 2024 21:13:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX/nsO7Ucw2O1FVJeUFIFDw036Z4d9AUo7cPAGgM8T51mnGFWwIAqEW0Hy59BnO6Xq6jQeB8bGX2P8CEz1B4gNpqY+p2G5lkmsntgnqmqbsfTRPOA7hXRG91sFfMpDbrdDPTu6VZC4mZlYCoFzxgNPhgMLrCD2hpGSkK/hL8xUsyYisGfhRAPyYdvHgsQYC3Du6LSYbvC+5RlyaAQ0jKzeLYvjAuN6bid0P80ij+R2LC2drDZ8kHgi5ZOXFp4GogkzsyyuUNmNzN+EARUA/JpuHW2HN6RYn+cFtY7JzsJTyGjV4OU0yqTj63zP3oFWO7zwsvrXXUQc6l1XWWYGyh8QD46RNavnUymdV3x5TjmsAYTGSMYE3oiXI6qFHhRzhc+oY2SbbXlnoEQnUmFMsCyJRUUzMYHJffTSV9Fguv/NH43GgrPTdCGoOZLbQBcg=
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 bb4-20020a17090b008400b00298b72ab7ddsm431254pjb.14.2024.02.13.21.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 21:13:43 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/9] hw/pci: SR-IOV related fixes and improvements
Date: Wed, 14 Feb 2024 14:13:38 +0900
Message-Id: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAJMzGUC/2XMQQ6CMBCF4auQrq1ppwWKK+9hXLRlkC4E02oDI
 dzdgpJgXL7JfP9EAnqHgZyyiXiMLri+S0MeMmJb3d2QujptAgwk41BRj6+AtNEaAQznlZAk/T4
 8Nm5YO5dr2q0Lz96Pazby5fopABPfQuSU0dygsrnFQgh1rvXYueFo+ztZEhF2jLONQWIgjQadM
 ygq+GNiz2BjIjHFeGkKVVksmx82z/MbNbVaYQkBAAA=
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I submitted a RFC series[1] to add support for SR-IOV emulation to
virtio-net-pci. During the development of the series, I fixed some
trivial bugs and made improvements that I think are independently
useful. This series extracts those fixes and improvements from the RFC
series. Below is an explanation of the patches:

Patch 1 adds a function to check if ROM BAR is explicitly enabled. It
is used in the RFC series to report an error if the user requests to
enable ROM BAR for SR-IOV VF. Patch 2 and 3 use it for vfio to remove
hacky device option dictionary inspection.

Patch 4 adds SR-IOV NumVFs validation to fix potential buffer overflow.

Patch 5 changes to realize SR-IOV VFs when the PF is being realized to
validate VF configuration.

Patch 6 fixes memory leak that occurs if a SR-IOV VF fails to realize.

[1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Reverted the change to pci_rom_bar_explicitly_enabled().
  (Michael S. Tsirkin)
- Added patch "pcie_sriov: Do not reset NumVFs after unregistering VFs".
- Added patch "hw/nvme: Refer to dev->exp.sriov_pf.num_vfs".
- Link to v3: https://lore.kernel.org/r/20240212-reuse-v3-0-8017b689ce7f@daynix.com

Changes in v3:
- Extracted patch "hw/pci: Use -1 as a default value for rombar" from
  patch "hw/pci: Determine if rombar is explicitly enabled"
  (Philippe Mathieu-Daudé)
- Added an audit result of PCIDevice::rom_bar to the message of patch
  "hw/pci: Use -1 as a default value for rombar"
  (Philippe Mathieu-Daudé)
- Link to v2: https://lore.kernel.org/r/20240210-reuse-v2-0-24ba2a502692@daynix.com

Changes in v2:
- Reset after enabling a function so that NVMe VF state gets updated.
- Link to v1: https://lore.kernel.org/r/20240203-reuse-v1-0-5be8c5ce6338@daynix.com

---
Akihiko Odaki (9):
      hw/pci: Use -1 as a default value for rombar
      hw/pci: Determine if rombar is explicitly enabled
      vfio: Avoid inspecting option QDict for rombar
      hw/qdev: Remove opts member
      pcie_sriov: Validate NumVFs
      pcie_sriov: Reuse SR-IOV VF device instances
      pcie_sriov: Release VFs failed to realize
      pcie_sriov: Do not reset NumVFs after unregistering VFs
      hw/nvme: Refer to dev->exp.sriov_pf.num_vfs

 docs/pcie_sriov.txt         |   8 ++--
 include/hw/pci/pci.h        |   2 +-
 include/hw/pci/pci_device.h |   7 ++-
 include/hw/pci/pcie_sriov.h |   6 +--
 include/hw/qdev-core.h      |   4 --
 hw/core/qdev.c              |   1 -
 hw/net/igb.c                |  13 ++++--
 hw/nvme/ctrl.c              |  29 +++++++-----
 hw/pci/pci.c                |  20 +++++----
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie.c               |   4 +-
 hw/pci/pcie_sriov.c         | 106 +++++++++++++++++++++-----------------------
 hw/vfio/pci.c               |   3 +-
 system/qdev-monitor.c       |  12 ++---
 14 files changed, 118 insertions(+), 101 deletions(-)
---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


