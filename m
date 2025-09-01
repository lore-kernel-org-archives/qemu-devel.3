Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CADDCA1006
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usvXt-0002Rf-DR; Sun, 31 Aug 2025 23:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvXr-0002Qr-AP; Sun, 31 Aug 2025 23:49:27 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvXp-0005fK-H3; Sun, 31 Aug 2025 23:49:27 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b475dfb4f42so2627402a12.0; 
 Sun, 31 Aug 2025 20:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756698557; x=1757303357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7+oad1CSplaz3wuj7Cv7dFvBC220ZlV3qe6DZIehNPU=;
 b=Y7cKYcecBh7VACssj9iXWt2MDamhvgzfSQ+lMQuzuHUxF93w01FFru8aM6r33VN0ld
 RDL96Kn2fjQIg2eBRUhFjASlPz5s6IK0Ptanw9mTAdBg7EwcQlV2+RzNWBnn5kHM/jv6
 3/4g/3eYRCGNkKKJI1YQXDLN43MQVRXeUS1hvNf1UKPKVrzvk5qnosWCyz64BibNm57x
 fJJQpU7GqRATCeFffT6e1SVIgXpdcVc4BZPbFnb62xEeIk8j4sdsIm8JGUqgfr3BCOho
 LjsTcu07Im+MPXmmzyLKDImN5ZqZzRaceVLtny3G9moQytj7eqBnV247bGfDpMrMnupk
 bHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756698557; x=1757303357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7+oad1CSplaz3wuj7Cv7dFvBC220ZlV3qe6DZIehNPU=;
 b=kWz8kISyy5skftuKRMye4nyO3Efo3Dbf+lGH1+2CNrQ9ZEdtvvMZAJXsZWibinKvbU
 heygBe3ILppP73MlNDhJmzQLFZmaQ3x5nCX/VqZR1rItciiV0kAT8D5WfH8Yr0NcKySa
 ArIzWLsjidWWHSn/cMsQ0S+M/Om3dJszJjTnC32I8ewRqXFtt0/YGqYeo/i+K6Q+VIB2
 eeQslmL/K9+QhgNf/n8SpTAuskWDWfyZebw+bYHK+r5vnQFMvwlUjammrq4Hez6kkXkS
 E5l/lMH98lgq3gHMCNmwrH6zojKpkKwa7dFnmBYNDp7T1bents98oVp+V6cDrD/Odxjm
 onQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUzaG9AD59CrqMMLd4Vty21BkvjiX3GZcpHLagu1rrzu2Kix9WYKYKLWH3sGohpfr3YiGe1P5VZ1aWEA==@nongnu.org,
 AJvYcCWwGFIy++7G+jZLzTTU1rRxoNEiCHMlqw46VseoPhdfBrlzpGjmedcXppOwIUbBfiJ3TI+JpmZekVHK@nongnu.org
X-Gm-Message-State: AOJu0YxA5Jwju2utonT0Fht5EnQy76ci/aAsVxySPuIxQN0+nyY8+8ID
 dqigmJqr7FIiJ+0XYlcd6LX/iEEOIFW6nwWo1AQW0+RqlQy1DI/LqD66UGb7sQ==
X-Gm-Gg: ASbGnctZMxiueOUeXbdgcrpIOhyjiHwiW56wPLIZVo1aSCGfa2/aLzWoCgKhWOPOnLd
 RX974BnthDeC0LtI2JAc5C3aGFS6jAmqt2DKBru5m4m5WBTePpQ//knPcMdMwEsz9REyhxEzmuO
 CASpS9WD+/68iCocRqzVppU4bytDShOTFgptUk4wAtKTSBboD80Cs1decPiZ/wDOgtcegycI213
 aYce5RZJACPlod2l4XDN8NunpbjgtSSr9p0gELL3rLa6uqWqecqo3Dq+OXsTGaaVx/G+O5/Ec0h
 Bfd9pvwnzzbE98Cj39JyN0DxBQYi78NzpVPen5Y3UqIeCs6atUke9sT64kuA6B6ROi3uB7eyxFM
 SG9P/goM87hyFwDu0MlumxZ2aH/XqO7iBNRVP
X-Google-Smtp-Source: AGHT+IGNcFvEYrlaGre044I8SoITq7suDCDRLc1OrPE6mHP4K8C1fE6QKHQ/CDDocGCDQXXbSq1opg==
X-Received: by 2002:a17:902:f707:b0:246:80e9:85b0 with SMTP id
 d9443c01a7336-24944ad14edmr81328615ad.41.1756698556675; 
 Sun, 31 Aug 2025 20:49:16 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da26b9sm89802815ad.93.2025.08.31.20.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 20:49:15 -0700 (PDT)
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
Date: Mon,  1 Sep 2025 13:47:55 +1000
Message-ID: <20250901034759.85042-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pg1-x532.google.com
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

Wilfred Mallawa (5):
  spdm-socket: add seperate send/recv functions
  spdm: add spdm storage transport virtual header
  hw/nvme: add NVMe Admin Security SPDM support
  spdm: define SPDM transport enum types
  hw/nvme: connect SPDM over NVMe Security Send/Recv

 backends/spdm-socket.c       |  79 ++++++++++--
 docs/specs/spdm.rst          |  10 +-
 hw/nvme/ctrl.c               | 233 +++++++++++++++++++++++++++++++++--
 hw/nvme/nvme.h               |   5 +
 include/block/nvme.h         |  15 +++
 include/hw/pci/pci_device.h  |   2 +
 include/system/spdm-socket.h |  66 +++++++++-
 7 files changed, 382 insertions(+), 28 deletions(-)

-- 
2.51.0


