Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D200C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 01:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYENq-0003X7-6b; Wed, 15 Jan 2025 20:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=104bc4e84=wilfred.mallawa@wdc.com>)
 id 1tYENn-0003Wh-Tx; Wed, 15 Jan 2025 20:09:15 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=104bc4e84=wilfred.mallawa@wdc.com>)
 id 1tYENm-0004DC-2S; Wed, 15 Jan 2025 20:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1736989754; x=1768525754;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1STTjrDBmra11zsVfv/orRLamkndqjMZdOyKZ2Vt5iw=;
 b=l5DAMcfCuTUOHgOBqoJSHUtRU4GZ9lYGB9yUvvaJBeaiYVcR8NF1q6ch
 7tdn89s1pC35IQSEv/T6iODGuObW4KDUtqHS13f8Acl45p5eCeGWf35c4
 lQipQC5Lwfn1909Bcl5F/AbH6tbK4igGA9LfPAfILRIVshz/umyqS2OFj
 wfFtj0VDJZdFvFMKB3H5AZjLTEYtM2I+dfZqyIP33I146KBie+ApkXeK0
 t6H2EYEgHuZLcXgqHcfSdp0lk0ITaEnUgFf6nTQ4atPpDfQQadlz7k79y
 bwWHpVnmpd0S4RBsXi+znwCNnOC3aBprQLr1HBny7KlILHuStMbPa2pvk w==;
X-CSE-ConnectionGUID: vxadmS+2T/GnCg63oOWX7g==
X-CSE-MsgGUID: ww4uvH6bS2mpfqvp/JT2gQ==
X-IronPort-AV: E=Sophos;i="6.13,207,1732550400"; d="scan'208";a="35419683"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2025 09:09:10 +0800
IronPort-SDR: 67884d5d_g8wf2fbRwusVW+Uo769kq8wxsUtOR+miB9lUtUEHWSFEsiV
 z58foXs9sB3J5/0W7oqq4e3SnFGO3z5kjEPETOA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 15 Jan 2025 16:05:49 -0800
WDCIronportException: Internal
Received: from unknown (HELO fedora.wdc.com) ([10.225.165.91])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Jan 2025 17:09:05 -0800
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: alistair.francis@wdc.com, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, stefanha@redhat.com, fam@euphon.net, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC v2 0/3] Add SPDM over Storage transport support for NVMe
Date: Thu, 16 Jan 2025 11:08:54 +1000
Message-ID: <20250116010856.95115-2-wilfred.mallawa@wdc.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=104bc4e84=wilfred.mallawa@wdc.com; helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Changes V1 -> V2:
  - Split out the SPDM Socket API patch for separate send/recv functions
  - Addressed comments from Klaus Jensen
    - Dropped unnecessary allocation length check
    - Dropped unnecessary alloc_len alignment check
    - Fixed up `nvme_security_receive: dw10` SPSP bit-masking

Wilfred Mallawa (3):
  spdm: add spdm storage transport virtual header
  hw/nvme: add NVMe Admin Security SPDM support
  hw/nvme: connect SPDM over NVMe Security Send/Recv

 docs/specs/spdm.rst          |  10 +-
 hw/nvme/ctrl.c               | 265 +++++++++++++++++++++++++++++++++--
 hw/nvme/nvme.h               |   5 +
 include/block/nvme.h         |  15 ++
 include/hw/pci/pci_device.h  |   1 +
 include/system/spdm-socket.h |  12 ++
 6 files changed, 294 insertions(+), 14 deletions(-)

-- 
2.48.0


