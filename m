Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AFDCA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 07:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urX1L-0004GD-O9; Thu, 28 Aug 2025 03:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1urX1I-0004FN-CG; Thu, 28 Aug 2025 03:26:04 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1urX1F-0005MH-SX; Thu, 28 Aug 2025 03:26:03 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b471737b347so457832a12.1; 
 Thu, 28 Aug 2025 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756365956; x=1756970756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VKtLunagY1QESZQoSB7dxK22AzBeHX0dHDUaM5QgB4o=;
 b=R3dsu6bbTRbbJ1Xh7xBvDJq1nLeB8jYwjln8lfar+q/c7KkWVai0n8aMUaiq8XHHPT
 Lpo+b4aSEoMcNtCQqcttYxfH7rkFWFJ5XCIbYbHWAq4r+lx6Yo6j7TzRFZGrJDnRow8l
 3n3bX3Cjkk+G0sFmgHC3SpXUWwEzbRBWgNFSkXzQpobd8FG+nMTa6enNj2BUII3wDKAp
 KV600rpcn8eliTNORQR2OAGZcLaUCLNpt3rpUxDT5VML+Z8x8lAUkLy0XwIqWkDfMvSM
 EsFE1Pjgy8MorJ3b+1X6IFWIbH2bKOXbZyBwZMw99Krbve6lJIUuGN3b+1bw0dUj2P5s
 LYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756365956; x=1756970756;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VKtLunagY1QESZQoSB7dxK22AzBeHX0dHDUaM5QgB4o=;
 b=M7Tq8icNKh2kYYujt8pzSwJuBSac3VhY3Pe86g81xRJBcQRPLp+aIzIQf2/N/jwuaR
 CoodcaWB1+FdzkqcRUCGBG3VwAAnQ3C7Ud2+7ya3A6CKqDNYx22EKy5r1O/Qze0I9uwz
 OOKIiflNt1l3ttP0d0C2izhrvPY5rT2aJqCDOxy6fXKoZf3B8CLVnmXJ/baf5baJlqb+
 mX6Y3ujGkQZuA2cJYqrF6sXtNVhz11nsL1T0gDMGfihnJ5jZHUePJ3TI7HEsgR/7AD9t
 +4b8M6KXDS2/fNjwR4Z7lCrdahVaG/iFXnPQT/OAjM0MgV+nGe1Q/mcCWs82thGAfzrz
 TO8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAZK9vAlWKANylrjB78apJpOrIV/d/b2Hd0zC9rTxzOzq6t8cmVv9ZKjHTSIz9TJb6faun1js9hjDz@nongnu.org,
 AJvYcCW4FIfz2jc78PorwMSqo+OqXXIxrPtKdV91ujN5FB4LfmI/jf5M6mVbe3sH+A/mDcVS9sX8SHiDCsya/A==@nongnu.org
X-Gm-Message-State: AOJu0Yz2X726Kz6GqcLnvMYGT5dV2dfloyXR5Sfglh9ZImBDd6AuUxMD
 2yJl7+bk42uEO3BKcBIghmSoMsitnCYyMgKNLVe+WQEKuSu/aEa8na65
X-Gm-Gg: ASbGncvPqGx8V4jzBrPLfRUyuxJq+ufvbCFx15DJdFyCYT1NPn00gSY3aHkbKd3WmOQ
 rheDxSu+v0yPoMTFv1ZYfuJtlNfOc8WMmi3Ssgl6S1SFQWF+dbwQOAZk2U24XNO4lstzrUPTWsQ
 jbN70kpwBZhhhHKnvGnlGxkcjLqJXjw72sMo8biuOwq09GUCHGJ5SmvTENt4ZTCZZ5tQGByuZD3
 iQEhLk8n/8hhMOru/jm9UpAabsDR3ordclMCIHTdxsi3HbrWcjzIky8bFO8iJ3X5kVNbc4e4eFH
 6Qe+ZvGOYHn+ZJ2ygkOqwpLp1bh4IJJYGbQ3nF8RftyGGcgJWrmSAlS9OL1J/c0f9KqtZIpSmxw
 zUx82jU0tabWF0Ug1JvGCSRyG/g==
X-Google-Smtp-Source: AGHT+IFbi2w7IsPUlbM+B5wBwfScb8mfYMeSjdtjaGgzsM2OguQI+JNPrxjVh6eLlz+fT9dpkkaA5Q==
X-Received: by 2002:a17:903:37ce:b0:248:e0a2:aa31 with SMTP id
 d9443c01a7336-248e0a2b09cmr9750775ad.32.1756365955584; 
 Thu, 28 Aug 2025 00:25:55 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24884a629fcsm51009775ad.19.2025.08.28.00.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 00:25:54 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v2 0/5] NVMe: Add SPDM over the storage transport support
Date: Thu, 28 Aug 2025 17:25:28 +1000
Message-ID: <20250828072532.425592-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pg1-x52f.google.com
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This series extends the existing SPDM support in QEMU to support the DSP0286
SPDM Storage Transport [1] for NVMe. SPDM Storage Transport uses the NVMe
Admin Security Send/Receive commands, as such, support for these commands have
also been added.

With the addition of a new `spdm-trans` CLI argument for NVMe controllers,
users can specify `spdm_trans=nvme` or `spdm_trans=doe`. This allows for the
selection of the SPDM transport. The `doe` option is the current default,
`nvme` would select SPDM Storage Transport for the controller, where SPDM
communication happens over the NVMe Admin Security Send/Receive commands.

Support for DSP0286 already exists in `libspdm` [2] and support for the QEMU
SPDM server is being upstreamed for `spdm-utils` [3]. This series was tested by
using `spdm-utils` as the qemu SPDM server with SPDM Storage Transport support
built with `libspdm` v3.8.0, and `spdm-utils` also as the SPDM requester.

Changes V1 -> V2:
	- spdm_socket_rsp() now uses the new spdm_socket_send/receive()
	  functions. spdm_socket_command_valid() is added to parse the
	  command value incase some bytes were received (result = true) but
	  with an invalid command.

	- Added inline comments to describe fields of
	  StorageSpdmTransportHeader. Checkpatch generates warnings, but lots of
	  existing code does this. The QEMU_PACKED attribute now follows the
	  StorageSpdmTransportHeader struct definition.

	- Use extract32() instead of manual shifting/masking in
	  nvme_sec_prot_spdm_send/recv().

	- Use g_autofree for send/recv buffer allocation
	  in nvme_sec_prot_spdm_send/recv().
	
	- Added explicit fallthrough comment for checking `secp` in
	  nvme_security_receive()
	
	- Added enum support for SPDM transport type, such that a user defined
	  transport type string, can be mapped to the respective enum for
	  internal use.

Wilfred Mallawa (5):
  spdm-socket: add seperate send/recv functions
  spdm: add spdm storage transport virtual header
  hw/nvme: add NVMe Admin Security SPDM support
  spdm: define SPDM transport enum types
  hw/nvme: connect SPDM over NVMe Security Send/Recv

 backends/spdm-socket.c       |  79 ++++++++++--
 docs/specs/spdm.rst          |  10 +-
 hw/nvme/ctrl.c               | 242 +++++++++++++++++++++++++++++++++--
 hw/nvme/nvme.h               |   5 +
 include/block/nvme.h         |  15 +++
 include/hw/pci/pci_device.h  |   2 +
 include/system/spdm-socket.h |  66 +++++++++-
 7 files changed, 391 insertions(+), 28 deletions(-)

-- 
2.51.0


