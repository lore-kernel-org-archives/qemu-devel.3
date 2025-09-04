Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3A4CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 03:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu0OZ-00072V-Hp; Wed, 03 Sep 2025 23:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0OX-00071V-2N; Wed, 03 Sep 2025 23:12:17 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0OT-000153-Rd; Wed, 03 Sep 2025 23:12:16 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3f33ecb34c0so6652835ab.0; 
 Wed, 03 Sep 2025 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756955532; x=1757560332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S0VnlZ3wCCZPtxyqn4pLPV7wgEZ/16CGDaee3yvZYTY=;
 b=J4bao294dO4bsUW8fMuMwuSgo0i7DTm9ZbMt2f7OEM0ukBKDEOgQwl8j2TluaanpLc
 oFOBzOSMIcn+QLCKqE0YZFPFUXB+yqgA9LluL6epXa2RH8HbvUPlYKB7Om2OX6qrcFhG
 92IV3GgtHfnFzjMhFQJorQOpmnvdXosX5F8VC23vHtukOTjkTmHncXDTShcW0j6rjVCa
 xemVofda82RIFJa0hIXZZolJuHofvn+BEG+4R9VPjMCTMbI3Qo3gK/Ujf48nKJkKR1av
 berJIiE+VQpeMQLLHBvdzuC+tG/tk3poACGNyp/qTVxwJ31CjcRVlpKHtJOkwuyJ7hfi
 G7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756955532; x=1757560332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S0VnlZ3wCCZPtxyqn4pLPV7wgEZ/16CGDaee3yvZYTY=;
 b=k0AQpudFAiYG9GzBovtl75vEIeU5mPWXdYqd9dRyyH9ase3EvWH4qNxg2QCPAVVwm4
 61hFNzsCbn4eiMXsgd19VtzebNwElqHc/Ncs5ExdJxcWwN5YCtZRQgRskLpIgyj2/5NW
 GhPpYuMWfm03Ofp0CvcU6dXETrumC+uHFXBdZo8gBJ6ZZw14Dz8qrP7/mUd76RVyfdVk
 lOfkJbf6XM27+B7RhSJcPtwLmVpOlw8Dj+b4OQKcHPjQb0nVmVIpxhMdXAj8b826YAm6
 iU6eFt6HZJxscrnLxpNc4enhjkdM1xchl/DT7JRphcUXIsZ3sv1rtNEdqxWPYybMjN8Q
 Qxog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyzJFZ29Swd7zyNrFLicrxIqD4pYJHDnePa4TiL8O+emIfz2QKa+/aE2hKasT+Sp5V5NFHOyeSFv7KWQ==@nongnu.org,
 AJvYcCVoerTjjFiUIjHO7Y7RPuw9FTMRREOzVJrXVz3TRMq3iysEYwJD4YQG4skEBnhrB/HbNPlPQAXb/G+F@nongnu.org
X-Gm-Message-State: AOJu0YyStGoHmMFxJWrugv0MZKCFnezrO0NCh96/7ePMdzY4MXcKV2Iw
 F0fUAev2t64xVrfouoyT7d8Dd3tGuarCSPU0EZeZrOmbKYsnvZDFgtvvM4vUGA==
X-Gm-Gg: ASbGncv+42kpQ+/oF97AAArWkys6LbhNBLWtOIdzMDVQU0EN3iPQOlNiX4HI7bLp1dl
 lhLNJrYiFqEcqPFGHWbgcKtdPbhqbLT9Ci255tf3TxfsfIvz/J4l3JxxsouSKgUyEsdzL6hJ3R2
 LHtY7PYgX6cL7AEwl6BBiSdg7K4d47+dVKufWSVHerHkeA7aSC1z4s7Acp0UwEXutstDR4EgMqr
 XkO2R6gwrbuoiCmLFY1P5h0jDyiwQC614nAHtZYgZ5ve4zVGOCQ4ApfpUFacWxtB91uSqxpAsgj
 9pGzTGCEzRlALUMJIxiDcG2MFUYWZ/fROfzPBGZlF/N87HYsxWIIiu5nXonKhcxalOjZlQkresL
 O/QPETNmWLnA2EaSkHNDpPqcNB/NtPZFWr8yi
X-Google-Smtp-Source: AGHT+IH+vJCm7YlxRag/ehO+Jl9vpBwHTwcb6QQZue+SjjBMozVa046p57ZnVZXshFDJmIm/Ndsylw==
X-Received: by 2002:a17:902:e750:b0:24b:12ce:48bd with SMTP id
 d9443c01a7336-24b12ce4946mr106190325ad.17.1756955520221; 
 Wed, 03 Sep 2025 20:12:00 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490375a9ccsm176497715ad.63.2025.09.03.20.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 20:11:59 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dlemoal@kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v4 0/5] NVMe: Add SPDM over the storage transport support
Date: Thu,  4 Sep 2025 13:10:54 +1000
Message-ID: <20250904031058.367667-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-il1-x12c.google.com
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
 include/system/spdm-socket.h |  66 ++++++++-
 7 files changed, 407 insertions(+), 28 deletions(-)

-- 
2.51.0


