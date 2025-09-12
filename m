Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC3DCAC58E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 02:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwtGn-0002Cd-TQ; Thu, 11 Sep 2025 22:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwtGm-0002Bl-D1
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:12:12 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwtGk-00054a-Gu
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:12:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-24cbd9d9f09so17866305ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757643128; x=1758247928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rYrb1daHYgOTFYRlcqopV4rGy5pFWnKtEiBmHFiZtkA=;
 b=bbBGJg9nwpuiKH0R9bgCw8/WVrbmTVEz7tABXRNuJ3tviR8aGRQuiCHYsz0cWSEnWl
 YpalHL8abf1vFSyyeDiypsQCEokmlNft2nav82Z8Ldr6L2EJxCdod9izCW993CAdzCyD
 2C6yklBmgKNSZV+Z0meWsxCJcf1Uad9i47qPDDCO7wwXcjFf+a+8A21/WOMMtdT1/AjM
 nviX4PUACW/Mp4KDZB18H5ElBNlwsqX66Yg0iuYmqbmytEa+gUVY5XRCz+yR+wRExbYh
 FvosWdkOoC75r86qmwD0tqvEndO5YyK3vuRCute6Howef1/L3ijEy6cLzC35pjAR526b
 ZDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757643128; x=1758247928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rYrb1daHYgOTFYRlcqopV4rGy5pFWnKtEiBmHFiZtkA=;
 b=kPmC2K/K/cMl6artt3ei++G5x3SF2r691PmUnGHfcdQHbeO+eiQjWbcwmvCbqn39EM
 BOXtocSbpsQXUCe+iyMbACtxpOOSksJXnD/u5LAV1GAgrZbS2U8U+o8jT90udvF0f6Bo
 Cl6m3mZDdQ4GhbtY0ZVOS+xRS2NqbpbC3UtpmIXEupmQF2umM1LgZInBjbLmsq2gZ2gu
 rg1Gd8zdKeLXc239ELUbVJ0QHsJui55sQc9Tx/ER4lzMTnl8KBNXeAuJvMEBXRy56kUj
 shBx4qqKSOooX+qJrvplXT/ecf7QM9pJ/wRcJ7FKr9+gG/SIPwPWd/X5rCjr2kQA8SBi
 Q4HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQX1lC16yHy0KUqXuWRJcXrPQoz8BTDsIz6M+3PolLeaL6CQqrq3G6LO3hd007zqLYpoQo8brcOq+K@nongnu.org
X-Gm-Message-State: AOJu0YwtuYKmPXfFSMLLS7Re4zEtvOts3bvvGFFFd2IkITcCqV1EU3Yb
 QYuNr80gInNnbnWV9MaKMiwX28JlDQEDBERJA/stz8V/Od6FcRoKZvrp
X-Gm-Gg: ASbGncuk/RVCG+9d/D7dWmkeqtRddgwjme7qUbAskbZaNcF698ixBlmXnZkBFxOfpBS
 yqNK27gCRJGvtoEVLxaZieYV2rV9Asz8q9KX8IS+0lFmwuCZXvpWv6bPUFwHZW4TFAleXVxiVTt
 XYsF64Ge7kWrEur7ieiy5z+/kZ/k2WloYW6pqJBcTMVNxGtS+vXGpDeM59E2H0sCdW+eQfztRjz
 3cJTRDqQMiKPQnx6lMfLQsTgH7wZ48fli8dufgdjjJiv0iBKSHnsjk9A1YRnYhcs8Vq7ssmEAEX
 FC7peaRqm12/oJncwSqCRBo8kDQabx1UNdJiECWgvbc1f5HnWsB3WcG9/ZYE+hNRwoo19p3Iosr
 mKm/XHtTgNfvN6AhWvsh1Rw38mbUmlkzfhqchYZm/Hg==
X-Google-Smtp-Source: AGHT+IH6qvVLAAi5cRMWov+mofoBo4m4hmV4iPUYy7I4xYzk7NygnT5IJ1DQdrddHCotqXlySHNzow==
X-Received: by 2002:a17:903:38cd:b0:24e:49ea:1c6b with SMTP id
 d9443c01a7336-25d27d207e1mr15146125ad.46.1757643128201; 
 Thu, 11 Sep 2025 19:12:08 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25c3ad3349fsm32853205ad.104.2025.09.11.19.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 19:12:07 -0700 (PDT)
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
Subject: [PATCH v7 0/5] NVMe: Add SPDM over the storage transport support
Date: Fri, 12 Sep 2025 12:11:47 +1000
Message-ID: <20250912021152.46556-1-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x62f.google.com
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

Changes V6 -> V7:
    - Added an assert() to check that only one spdm socket was setup in
      nvme_exit().
    - Merged spdm_socket_close() calls into an else if for DoE/NVMe.
    
Wilfred Mallawa (5):
  spdm-socket: add seperate send/recv functions
  spdm: add spdm storage transport virtual header
  hw/nvme: add NVMe Admin Security SPDM support
  spdm: define SPDM transport enum types
  hw/nvme: connect SPDM over NVMe Security Send/Recv

 backends/spdm-socket.c       |  79 +++++++++--
 docs/specs/spdm.rst          |  10 +-
 hw/nvme/ctrl.c               | 257 +++++++++++++++++++++++++++++++++--
 hw/nvme/nvme.h               |   5 +
 include/block/nvme.h         |  15 ++
 include/hw/pci/pci_device.h  |   2 +
 include/system/spdm-socket.h |  63 ++++++++-
 7 files changed, 402 insertions(+), 29 deletions(-)

-- 
2.51.0


