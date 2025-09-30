Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15C6CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Qx1-00025I-Td; Mon, 29 Sep 2025 23:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1v3Qwy-00024g-I9
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:22:48 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1v3Qws-00027v-S1
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:22:46 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 28651421FC3;
 Tue, 30 Sep 2025 03:22:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com
 (100-111-81-75.trex-nlb.outbound.svc.cluster.local [100.111.81.75])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id B91F742251A;
 Tue, 30 Sep 2025 03:22:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759202552; a=rsa-sha256;
 cv=none;
 b=u4wNwauwjghOq98QsLvNW33A1qBxKHf8lgpNptbUE1Xxpx4V+9cNR4br8loyvL5UXN3BL5
 0xtRTMmFM6ljKhqDBC28dJBs36H0u2VlU5KvXqk3A5EzYIOzXa6vLJtZ4jhWJTLjHENp7j
 dObOtmlP+Cv5Esk7l6nYynJDQAhb2Nh1odiziE+5SzYcg1pSWlcspsOlQKyjrw5uFfOurz
 jfrNhviXDrw1ZC+Hi0YsDGFIKuvn+Rx13HHeJLFOzTsvZo7qiMzdVcNInaFoRHHdjszqgk
 fGKTlxFmF2nxVddMv95cx6WCjxVUgpxadhnyy+Zg12PP2CdOkP2qlKIbPOG4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1759202552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=4HKJL5h1ARnqVldpjrYAQKbNdJpIoNaPV8mz4ta3ep8=;
 b=MEL9ba2pVPDKNdXVTENJSek2fbBCGQlLuNfOyqulYifzYi90eeST3I4MYlLVg0aUSj2qUa
 y3Em9ikEZvZ6VODgiRlEufgo1Q1SDisqfkFvP/eywU7Ai+eaIC7RpZLHbk5Zz1r+emzbvv
 ZdZSgzlED8mU9AVMUAk21X6yiafXS60Z8bWn4IWWACtkWmZXuNc+1CIp0xMp8WkOU7hBEk
 McTpzB0cEoWa/sZ72res6zqwA0rtO/8yaAqibS/06rPAaRfEntzKl23SS9v9x1pp0pGurK
 nidaNog+uWb/2uN07UTYTejYRtqS9uZ+pHzeqhVlW0cidwrjLnzL9HU054p1Cg==
ARC-Authentication-Results: i=1; rspamd-867694b6c6-kkwjg;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Ruddy: 0b037e9f5b2ff185_1759202553029_2640901499
X-MC-Loop-Signature: 1759202553029:3492559014
X-MC-Ingress-Time: 1759202553029
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.81.75 (trex/7.1.3); Tue, 30 Sep 2025 03:22:33 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4cbNfJ0CXlzR4; 
 Mon, 29 Sep 2025 20:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1759202552;
 bh=4HKJL5h1ARnqVldpjrYAQKbNdJpIoNaPV8mz4ta3ep8=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=kwJgGbM5MNibHxtXtt7p6ZAZeoHbXFdfUuB8jaW2BAdUwu3e41HrrIIr2B7wVS0Vx
 VQyGgfmdu8SWpSiM3ADjqU29tbdQUVUG+z3NhvuOeYG2dmlySBrdvvYSsfi2WplsYi
 mlHazcw6iRY5ysG2XNjDuMO1g+aDsUbfATjJYNlmYOt/VEvul+oMGHifTwVtpDSOpE
 mm94JBIlJK70Nga4gyQMXbSenoRtyinxfYTng9BBxTzcSVVeRS6zkZ+/kGim+pu1DH
 l6djMlbsNKQjUr/isaWXWbUF7JZrdOX3e8/qaEB+lrDF4uRm7OJm46bHjw1AWuC284
 mdcA5cYuQ7RVg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, lucerop@amd.com, a.manzanares@samsung.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, dave@stgolabs.net
Subject: [PATCH v3 -qemu 0/5] hw/cxl: Support Back-Invalidate
Date: Mon, 29 Sep 2025 20:21:48 -0700
Message-Id: <20250930032153.1127773-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.222.61; envelope-from=dave@stgolabs.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

The following allows support for component basic back invalidation discovery
and config, by exposing the BI routing table and decoder registers. Instead
of going the type2[0] route, this series proposes adding support for type3
hdm-db, which allows a more direct way of supporting BI in qemu.

Changes from v2 (https://lore.kernel.org/linux-cxl/20250811033405.332295-1-dave@stgolabs.net/):
  o Renamed 256b-flit to x-256b-flit (mst)
  o Added a brief description of flit mode in patch 1 changelog (Markus)
  o Added missing hdm-db parameter which went missing in v2.
  o Replaced the new CXL3_TYPE3_DEVICE with passing 'bi' params. (Jonathan)
  o Fixed writemask bits in patch 4. (Jonathan)
  o Misc cleanups in patch 4. (Jonathan)
  o New patch 5 to remove register special_ops read() cb. (Jonathan)

Changes from v1 (https://lore.kernel.org/qemu-devel/20250806055708.196851-1-dave@stgolabs.net/):
  o Further lnk training in patch 1. (Jonathan)
  o Flit parameter changed to bool in patch 1. (Jonathan)
  o Do not set 68B in component Flexbus Port when in flitmode in patch 1.
  o Doc build fixlet in patch 3.
  o Pass the exact type3 type in cxl_component_create_dvsec() - unused, but better
    for keeping track, in patch 4.
  o Change doc example to volatile device in patch 4.

Changes from rfc (https://lore.kernel.org/qemu-devel/20250729165441.1898150-1-dave@stgolabs.net/):
  o Added 256b-flit parameter, per Jonathan.
  o Added window restrictions changes.
  o Dropped rfc tag.

Patch 1 introduces the flit mode parameter.
Patch 2 is lifted from Ira's series with some small (but non-trivial) changes.
Patch 3 updates the cfmw restrictions option.
Patch 4 adds BI decoder/rt register support to enable type3 HDM-DB.
Patch 5 is a small cleanup.

Testing wise, this has passed relevant kernel side BI register IO flows for
BI-ID setup and deallocation.

The next step for this would be to add UIO support to qemu.

Applies against branch 'origin/cxl-2025-07-03' from Jonathan's repository.

Thanks!

Davidlohr Bueso (4):
  hw/pcie: Support enabling flit mode
  hw/cxl: Allow BI by default in Window restrictions
  hw/cxl: Support type3 HDM-DB
  hw/cxl: Remove register special_ops->read()

Ira Weiny (1):
  hw/cxl: Refactor component register initialization

 docs/system/devices/cxl.rst               |  23 +++
 hw/cxl/cxl-component-utils.c              | 214 ++++++++++++++++------
 hw/cxl/cxl-host.c                         |   2 +-
 hw/mem/cxl_type3.c                        |  18 +-
 hw/pci-bridge/cxl_downstream.c            |  13 +-
 hw/pci-bridge/cxl_root_port.c             |  14 +-
 hw/pci-bridge/cxl_upstream.c              |  21 ++-
 hw/pci-bridge/gen_pcie_root_port.c        |   1 +
 hw/pci-bridge/pci_expander_bridge.c       |   2 +-
 hw/pci/pcie.c                             |  23 ++-
 include/hw/cxl/cxl_component.h            |  87 +++++++--
 include/hw/cxl/cxl_device.h               |   4 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 include/hw/pci/pcie.h                     |   2 +-
 include/hw/pci/pcie_port.h                |   1 +
 qapi/machine.json                         |   3 +-
 qemu-options.hx                           |   4 +-
 17 files changed, 329 insertions(+), 104 deletions(-)

--
2.39.5


