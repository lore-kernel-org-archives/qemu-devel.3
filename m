Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4475CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 04:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvq3T-0006Df-3i; Tue, 09 Sep 2025 00:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uvq3R-0006DH-LF; Tue, 09 Sep 2025 00:34:05 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uvq3O-0003Cz-NC; Tue, 09 Sep 2025 00:34:05 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso4535402b3a.1; 
 Mon, 08 Sep 2025 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757392437; x=1757997237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r+LzdvH/MSm2nFyhJhYF1Hdf4lF91PS6FH/Nu87PnTk=;
 b=PXfkxzF71ZOAvzlCO3T7DcH6H24hlKLG+d+Zkfz9wC+v2zORTPiQ4DiYRDxCx86Kjx
 aYrwIp7OrxVbVM7jjoDHbKiyoA11VMetg4yKMVi0s1J5DCfgDOqdpJAQsD4GujGfzEPX
 mw4IZ1z6VGjPQEAd9FadzrrUU87FsrCUkSZkB/HSGKcROO7lRjARS/idC0TakpUhEnjU
 eqTMWaTgDkeReZ/eEE5gM67PjfoxGbSDGizP61EzR7RH4bh1J4n6ybpsbPXh9ipbygRE
 uVMx6DcieWY30v3sMv+kEd0n/im/NCq9FG5DLh2XDCTood5Dra3SL2Dllj+qsWEZ+TRe
 LCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757392437; x=1757997237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r+LzdvH/MSm2nFyhJhYF1Hdf4lF91PS6FH/Nu87PnTk=;
 b=ilzDPcuMN4ERHWxYmzCVLv7dKRLE2T3hqdGwpMc0g7buqwlIejFrVnWVyjUXUka+iV
 nGxm1JoNHNuseVj/hEQ+13LW4nkiEId6H7KFWyHHZ1PNsDv4mL5LGCb/jE3keb/cnT6K
 N2bmzRHxa3Ai8hpkA1pKZAIPOwdZgnWZ4Q6u9dUldPqHvf1UZHt+FW83NmxrlUb4rFys
 gM/+FMwOkcQrRIe6K8IYDp5G1tu1++xNFUUewrVjOg0nuFG9ZeaxZqPcHSfY0fXWKMt6
 j6NxQguP/qjGTQC2PLNZqTVFwwCG8+hlGZ68ifqsMJeG/X7Li92tgyPucoQ80laPMa9u
 cOnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsk7NhMK6rH7185y56YJQjc/lJvBotLZPsqC4/RV7XHuNsvPW2SBoHldlbisMkz3GH5xR8sV4if6Ws@nongnu.org
X-Gm-Message-State: AOJu0YwYYnLSsbYP6JiS4WRiAwzTMG8KEj3jLmo67zgqHR79eFG5l8Vc
 vTNP3NC30cup/tv7RUUyGS7lPYCjYsd6BwI6j+0iqoaCn8bj3qcWKdON
X-Gm-Gg: ASbGncv4KFla2AvgOUMRpCMtm6Q24svGHe5jnA7bJmLNzRCb0K1Xc5+KlnaGMEmxcpg
 uE3dSoz3trXJfeQ1xYc7Lc/1Y3FuvY82Tz2SZEPSQQx3e63LD8W8STTFMrTAJm5vFtpkBIgE97a
 2AVs0MZnS09bgJz9iN0tUvqMH3RtTxX6TNLUXUJ2ZcZVmCJ5IQqPxicgUAQO6ci5Ztwvszrq0nT
 9464L6EJj1CC+28a0rGnKicO8kM42SkLL2hZm+m0KedWaRbpUjoIHY72EvMt34T3VWSG8AiB7ze
 STlpa8l1/2cX+/nmGox4br0Wccdid20Rfpdz2esggFKedwd1npCeEokUKKpQX6Vwc8wWz4yiHjX
 mCsPQOjGPMXHwNuH0rJI0WzEekBs5F9MbD9qdfFr8WQ==
X-Google-Smtp-Source: AGHT+IGP6GLzHoc4o+pPYP5Yi1S3pe2cBmwAutNw34V4kh/UIL5AKSOgZB+RRUL2UwFv/pYcMPCjqg==
X-Received: by 2002:a05:6a00:188b:b0:772:63ba:11b with SMTP id
 d2e1a72fcca58-7742ded355emr12683187b3a.28.1757392436771; 
 Mon, 08 Sep 2025 21:33:56 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-774661247cdsm606534b3a.33.2025.09.08.21.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 21:33:56 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v5 0/5] NVMe: Add SPDM over the storage transport support
Date: Tue,  9 Sep 2025 14:32:55 +1000
Message-ID: <20250909043259.93140-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x42b.google.com
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

Wilfred Mallawa (5):
  spdm-socket: add seperate send/recv functions
  spdm: add spdm storage transport virtual header
  hw/nvme: add NVMe Admin Security SPDM support
  spdm: define SPDM transport enum types
  hw/nvme: connect SPDM over NVMe Security Send/Recv

 backends/spdm-socket.c       |  78 +++++++++--
 docs/specs/spdm.rst          |  10 +-
 hw/nvme/ctrl.c               | 258 +++++++++++++++++++++++++++++++++--
 hw/nvme/nvme.h               |   5 +
 include/block/nvme.h         |  15 ++
 include/hw/pci/pci_device.h  |   2 +
 include/system/spdm-socket.h |  63 ++++++++-
 7 files changed, 403 insertions(+), 28 deletions(-)

-- 
2.51.0


