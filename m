Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBF3CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 06:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwaNN-00018e-IP; Thu, 11 Sep 2025 02:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNL-00018I-WD
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 02:01:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNK-0000Yk-6A
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 02:01:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77251d7cca6so318146b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 23:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757570500; x=1758175300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dxxsWkVNx4V3bnV63cBcq40zBbZmNjJ7Ngz09pXqBL4=;
 b=Bi9Ql/5wI1A8xKfqwlxB5uz0SO6xtgMW6+XUuaoY964oUVS2TGPBBmJlgu+SHyXHQv
 7Ag4uqD+kzkAyvMeXvGubXS0D22VXwgT/oNGhFOZhK3R2CwEWL1zq1nHWQgsXf7ja7t+
 sQzJLT2X9Ai8bOy1DyP96jbfnPX/RMQZFJdqoH/EmKI5NYribPsApKrbsoA393OKMl9v
 VKha77t3hKepUcCwotDb+1JoYDlWxC4U1olifJ8GUdUtIj/ndWrrBJD5zkaUZjgHbvO6
 8kX3TnoJDXDzKKKRTrFRo18QP/FrEzdfSN10PFr8hrp5yyJ+P2sN/IF34Kqvn+yivXyX
 zKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757570500; x=1758175300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dxxsWkVNx4V3bnV63cBcq40zBbZmNjJ7Ngz09pXqBL4=;
 b=dkhDEVnM4JkSMfclsFnROOD4Wf47aEVmAlg6U6RpHejALwOhfGWR4+d2yA0DY1YirN
 yNmSBCbPN5RT2LZPJdo5QmZskgJW4o6nCdF0BLtNiccxoL2w9JgjVmTOrk7p/uGBBK0f
 b4AjykS0TzGK0RxtunuIBwBEZbJNfH+HKjD2KBtjpQFyKyhzutIQy9c45ayLf4/HnrwE
 4Dp81rbyy6URumRGHXo2NP0/52dL5ps1GfcTCujX1bYvIr7iE+So/HyftmItEEpnp6tL
 Br4Y+68d8d505sPJpFTNjU0LU5nxbAJ0tAYuR4YhfV5mb/hE6IbjH5Xs6q6nfBAL5XJ1
 ukyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8RkC3I2fT8wb+jtDtPi1zpbQI8PU2ZFBC2t5yECgD1Z+JJrCzPnM5XCPEsQs5Q4mYJoNCMNFGYOnQ@nongnu.org
X-Gm-Message-State: AOJu0YyjKYM0hHYwsU0M6M2m8kWseHEsHnLg4bziV3WTDWVKv5VRJXWY
 7WGxtj2XZAb4bvxbRKf22N4vJEW7JXbtYhpqae1h0mJvL+FYMgl+nAlx
X-Gm-Gg: ASbGncs2MPZrLAqkZrVlP1f7JvRboZUJ3+pMKbBPxUMJwVW4sKa0FtR4xXksur9+GxY
 Wssb5aabLYbKCu1VzugOkbSDoJrhxecLP/hVqJLch3SI/oBEkpnVDGslEyWpb02agYMHCKC2/YL
 kX8PpTjxHbdUeRCj3V3H6C4TUBj1z3hXQ1vL36EbDJGFmqpne8k+jxcQMRwxY31vcI4R/u/MrOB
 cw2AZd7wSUImRB9s3V1ipAKhhxmbYMqzJlmKyERL0D38r8aDUQNgkGB4xwHHfYJYMUAkWgHFQiv
 PcU0Rr2fbuBoiz1189rpMa/IZt4mGZ+VIlzZ3lKz9NHjGAKC/H29CCAhhZ5BAdsDVZj54zB1TMl
 oVnYh7CXrPsc2zWLOzcin3sWOCdUWPP0l0hd4DWu2hQ==
X-Google-Smtp-Source: AGHT+IEuSuQ82Gv/XaxXiJV36dnzBBXeJjWNIXgXFnT+peOk5aUtAhj+a8dqrI+9UVIT6Ht2mi1jyQ==
X-Received: by 2002:a05:6a20:3ca3:b0:246:3a6:3e40 with SMTP id
 adf61e73a8af0-2533d608501mr27985192637.12.1757570499590; 
 Wed, 10 Sep 2025 23:01:39 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607c54a71sm795381b3a.102.2025.09.10.23.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 23:01:39 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v6 0/5] NVMe: Add SPDM over the storage transport support
Date: Thu, 11 Sep 2025 16:00:26 +1000
Message-ID: <20250911060031.124683-1-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Changes V2 -> V3:
	- Fixed up the incorrect use of `NVME_NO_COMPLETE` to more appropriate
	 NVMe error codes in Patch [3/5]. Note that DSP0286 does not define
	 error codes for transport level failures.
	
	- Removed NULL check for g_malloc0(). Should abort instead.

Changes V3 -> V4:
    - Added integer overflow and MDTS checking for spdm_sends
    - Use g_try_malloc0() over g_malloc0()
    - Fixed up endian conversion for command status received from
      the server.
    - Added check to only accept SPDM send/receive if the socket
      has been setup.
    - Only show SPDM as a supported protocol if the socket
      has been setup.
      
Changes V4 -> V5:
    - Init spdm_socket fd to -1 for NVMe. Allow 0 to be a valid file descriptor
      for the socket.
    - Move transport definitions to the patches they are used in.
    - Avoid splitting SPSP0/SPSP1. Use a uint16 instead.
    - Fixup up incorrect (uint8_t *) casting in calls to
      spdm_socket_receive/send().
    - Default to SPDM over DoE if transport is not specified.
    - Fixup alignment (style).

Changes V5 -> V6:
    - Minor comment style fixup for the description of StorageSpdmTransportHeader
    - Change spdm_socket_rsp() to directly return spdm_socket_receive() 

Wilfred Mallawa (5):
  spdm-socket: add seperate send/recv functions
  spdm: add spdm storage transport virtual header
  hw/nvme: add NVMe Admin Security SPDM support
  spdm: define SPDM transport enum types
  hw/nvme: connect SPDM over NVMe Security Send/Recv

 backends/spdm-socket.c       |  79 +++++++++--
 docs/specs/spdm.rst          |  10 +-
 hw/nvme/ctrl.c               | 258 +++++++++++++++++++++++++++++++++--
 hw/nvme/nvme.h               |   5 +
 include/block/nvme.h         |  15 ++
 include/hw/pci/pci_device.h  |   2 +
 include/system/spdm-socket.h |  63 ++++++++-
 7 files changed, 403 insertions(+), 29 deletions(-)

-- 
2.51.0


