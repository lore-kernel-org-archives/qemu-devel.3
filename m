Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57008CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 11:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4e9M-0002zQ-Ez; Fri, 03 Oct 2025 07:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1v4e9F-0002wI-TA
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:40:30 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1v4e96-0006Zg-M6
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:40:28 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-33292adb180so2167569a91.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 04:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759491610; x=1760096410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P34TOThblPdq+SOtXIrLztPvSwZRojJMS+lGUJJfySI=;
 b=AeRHZcTZXtUxG+aE/Tnhp5xqFCPMl3KOcHfCjyyL/Msb/g8cdOyUKdGa2KwGcVYgyS
 /hLIT97vIcgdc0koi5IWgafyMVcokdIg1lwxU0v/zwoTWNHxuWUgd6eeinVvd/jaYvOP
 ILfvuU/xWhK2N6zr390E9Nofy04OudbygwKBZZop4wxQg5CNFCa71b7xNxLHbW9rVXP8
 b8b17I+n8gz9ZNosmNETKMcbQTep6GTUpXhqM66oGcI/OHFmvgffgj6QyzHYbB4jQHsy
 TK372QG6FNuNOAMgpknPVQaQ6cCRfdaMMWXZm1uJavvY66d/FxF3EA/xio/hSjfbztDK
 to3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759491610; x=1760096410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P34TOThblPdq+SOtXIrLztPvSwZRojJMS+lGUJJfySI=;
 b=G0y2AM6jfE7qhHzOB350bUBjY4G18/WrVyVOnPc3fYo0QAZwuonTKaMA7EqGEMoUHz
 /frlYd8WPNVatj5TqSzSbDbyLvycE6czbwz6/Xq5PsjWseQgI1x7zNi3eX6+yDqyDZqx
 HLZI9OUD7GcS7bDsyFe9LQzNDpUC5aW4o3j2TQFgtI9AC5yZg+eCm8yyOC2rxeSF1+ST
 b9Vi8kcvvSbFgwB89xEyiNaanR69iAUSptO7IMdgzxBtkCCH4EdzSx7n5OXO2S5PcpEL
 PCOt/oWa3aX7St01+PyMj2af802ew+qNTL71zamlYdGRimA6yCkgJ8MwY7I7vqzr6ZRo
 ZJ+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFVzmv1kIt7p467jz2gMuUyhGMB/245fzYH6X6RGpuRZIbEO+ZIavVG9Nb+Nptp2YT8/ur7SsEyvcF@nongnu.org
X-Gm-Message-State: AOJu0YxaFg6v/CLESK/jfIdadcYN1kjf7Fbb0ep5zJiFCa1XJ9ogav1I
 O//rOsYRE4iacxIfX0aDVlilS2lSGR3HUrUHqOojzVZtKryLeSWFGBEF
X-Gm-Gg: ASbGncvkCn6wCmt0JuiDX+XQrPoRfyj9d2ocr63ynvd4dncjLgidZrFaJpdfoVWw1Kt
 VJCQ+xA0lAF441RwlN7eOXZhhvKRHKKlgSNSf3UvKxFfjXnRhUnwV15clO3Ecr3pHnsLTacFjiR
 K0lQFEXBqMTVkf4/fs5L+tm01yiFDCYoJH7+7tMN9fq45N9hCvGWTR12Djzbes7LrECxAYWpf9l
 GBb142EZDioAEYEwwM758h9pHg1Rjha08F4bxmkMRKBZRqfq36OFDiCQc4SWBfg1GoCmjRAWlKz
 ktb1vIER0NacJSPG7zyQcWHBeCTyf/Qr/GNP8KkJ+Mm+kgc4CpYnTOaQ5Ueb2E1Q6NDeBI3AGs+
 66/kRfaCNxH7zHHjz2K9vB4tkOFYSH9SrYL6kYV5jmp6UZi2iJt2GrpXXc1ULMA==
X-Google-Smtp-Source: AGHT+IG1YxNFowZUCc2+qUp2oix6GSX36+UFc9UipegU/YYQQIf1QV1d63JTWMBQE9nGfr9ParQdkw==
X-Received: by 2002:a17:90b:3b8c:b0:32e:32e4:9789 with SMTP id
 98e67ed59e1d1-339c2707f74mr3543096a91.3.1759491610055; 
 Fri, 03 Oct 2025 04:40:10 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6ff26f8sm7804995a91.13.2025.10.03.04.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 04:40:09 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v8 0/5] NVMe: Add SPDM over the storage transport support
Date: Fri,  3 Oct 2025 21:39:41 +1000
Message-ID: <20251003113945.87962-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Changes V7 -> V8:
    - Added specification references for StorageSpdmTransportHeader

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
 include/system/spdm-socket.h |  65 ++++++++-
 7 files changed, 404 insertions(+), 29 deletions(-)

-- 
2.51.0


