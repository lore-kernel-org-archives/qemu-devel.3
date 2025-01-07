Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C525E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 14:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVABG-0000T8-0z; Tue, 07 Jan 2025 09:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=095394c9e=wilfred.mallawa@wdc.com>)
 id 1tV3cH-0007rS-J4; Tue, 07 Jan 2025 02:03:06 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=095394c9e=wilfred.mallawa@wdc.com>)
 id 1tV3cC-0004yp-L0; Tue, 07 Jan 2025 02:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1736233380; x=1767769380;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MO9quQIkU1aO8QNR5oX56XnmLD+IKPj86582WD5pnSE=;
 b=Lv8fgbP7UeIR4EUpMUlfbig0JmNEvrh9ww1E5Z72GR2nMdk/NfjWj57o
 7kw/RKhkMIFMVehiHCQEZ6aJi5ezNpBrKZUkGqdT2Ete9sIryJRVybyw8
 tfm5FDlj3RCu6frwPg6mG1z04Mu4onwpEPtz5AXwYmnpoZSGo12+UTCuF
 O19vXXc4ZnZLRUlyTQWbGWJr4a9yd57BNjyNU/vyQivsrlqGyRDzJ3Y1k
 qVe178wgI3noywaxaHL1IlweB5Uy+K2xb+o8d0ltgVZ5c4xC8rDsMisth
 Y4fJhTj3mkiCohkiRFJb7qHOYWtwTUHo+mmBujyR8HXM2qEelauYYpnNc A==;
X-CSE-ConnectionGUID: TmRgWp0EQ2iHzMjx811tpw==
X-CSE-MsgGUID: 5/GnOSUUSnqjRLKKNPsP2w==
X-IronPort-AV: E=Sophos;i="6.12,294,1728921600"; d="scan'208";a="34683283"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2025 15:02:52 +0800
IronPort-SDR: 677cc2cd_jprl8lKthfpG3yFWldt9cUVw+bhJnQE6AfDNnsvC0UPR5bm
 4lH+Q1BhmXHiWrUv296i2oxoLuiGJ8Qi6qDmxRg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Jan 2025 21:59:42 -0800
WDCIronportException: Internal
Received: from unknown (HELO fedora.wdc.com) ([10.225.165.88])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Jan 2025 23:02:46 -0800
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: alistair.francis@wdc.com, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, stefanha@redhat.com, fam@euphon.net, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 0/4] Add SPDM over Storage transport support for NVMe
Date: Tue,  7 Jan 2025 15:29:03 +1000
Message-ID: <20250107052906.249973-2-wilfred.mallawa@wdc.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=095394c9e=wilfred.mallawa@wdc.com; helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Jan 2025 09:03:36 -0500
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
Reply-to:  Wilfred Mallawa <wilfred.mallawa@wdc.com>
From:  Wilfred Mallawa via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds support for SPDM to be used over the storage transport, as
defined by the DMTF DSP0286 [1] for NVMe. That is, using the admin
NVMe Security Send/Receive commands, support transport for SPDM as per
DSP0286 [1]. The binding specification (DSP0286) is still currently a draft
specification that has an "Expected release Q4 2024" [2].

In anticipation of it's release, this series is an RFC.

[1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0286_1.0.0WIP90.pdf
[2] https://www.dmtf.org/content/now-available-%E2%80%93-spdm-storage-binding-specification-wip

Wilfred Mallawa (4):
  spdm-socket: add seperate send/recv functions
  spdm: add spdm storage transport virtual header
  hw/nvme: add NVMe Admin Security SPDM support
  hw/nvme: connect SPDM over NVMe Security Send/Recv

 backends/spdm-socket.c       |  25 ++++
 docs/specs/spdm.rst          |  10 +-
 hw/nvme/ctrl.c               | 269 +++++++++++++++++++++++++++++++++--
 hw/nvme/nvme.h               |   5 +
 include/block/nvme.h         |  15 ++
 include/hw/pci/pci_device.h  |   1 +
 include/system/spdm-socket.h |  47 ++++++
 7 files changed, 358 insertions(+), 14 deletions(-)

-- 
2.47.1


