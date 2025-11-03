Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC868CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG0kX-0006DT-6x; Mon, 03 Nov 2025 15:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vG0kU-0006CS-0J
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:01:54 -0500
Received: from butterfly.birch.relay.mailchannels.net ([23.83.209.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1vG0kN-0000cb-Dl
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:01:52 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 6DC20120C92;
 Mon, 03 Nov 2025 19:53:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a475.dreamhost.com
 (100-121-54-118.trex-nlb.outbound.svc.cluster.local [100.121.54.118])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id DA6E2121B24;
 Mon, 03 Nov 2025 19:53:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762199592; a=rsa-sha256;
 cv=none;
 b=Ws9uQEojG/MjLnhYdFeWX5nHFiSVoJbrvY88p8apTGSPU96fnGXeCvH3PISaRwyirNwfbD
 nfca5qS60ui7Ep+e6gB0DGr7Tfu50nOMegc7QsDSBjBtZ1gGlu3kRTZym7Y31M7ZURiAQJ
 j+dqMv3+yOjybo1Ija8rLCGGN8Kw5YgFgmvIkGT8nRWjoRB8K9CuTDIivciWezIpgJgi4k
 CJQsUEckb96F9W0wv/VFMxGoIIfYXEgJ7T2qwMjIbP743JRbynaSi8o1hlGuVpWpAeSoo3
 0ZKCmCB5H8PJEuiCqxaLRMFdcZVwnsLdx+Q7IxYKG8oHWu4ClJ/VDfQCzMn4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1762199591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=AmFoDFrxSC+IPGq7rdCR2qUi0cncf4yoFgbBTnBlvy8=;
 b=o9+HGTQoaZmadgEbYYOCWwqXdWRp7klbSYSmUfz5UVv032LlZa9xUJg/RAswj7V5Sr4lYc
 wi8lVMdNj0wYFAzYDowM77uvTvh/gBWJMP031eBHeASuQHM3ifDwAxnXqeXFzDW8pjqMyt
 1CQghanDq14LyOm+RTky05gfRX2wpel7UlPu2oMRc1JCAsLcHxIp6IpdIGSLl7ZJHfzS8o
 2eOJQtIEXzLvEfPL2aTFJnSwOFmE1MumChx7Csb/dh603Tppovn6qiQ36FkM0qO3etUFfw
 mfwan+Emdyjc+sq0H7m/kkx5py4C2+6FKAabHqtgve8/nejOZmc30iSZe1ZJfg==
ARC-Authentication-Results: i=1; rspamd-768b565cdb-k86dj;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Bored: 04d8a3331abfc5d1_1762199592187_3518719076
X-MC-Loop-Signature: 1762199592187:897472234
X-MC-Ingress-Time: 1762199592187
Received: from pdx1-sub0-mail-a475.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.121.54.118 (trex/7.1.3); Mon, 03 Nov 2025 19:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1762199591;
 bh=AmFoDFrxSC+IPGq7rdCR2qUi0cncf4yoFgbBTnBlvy8=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=LO9CJrH3Ut1TrBMfRuCiVBERhuXMQUEFwF7zYQZ0GxJy3VdJFSfehgTpOU3GNqnm1
 yy/Px/FCT+TqUfbgHH6G/DwvIW2j8tjjRKIJI/xgaVAwnBQb5hvy2RXf4743K2DR6i
 AyrBCtHlIQUJfgwYlODWXfrEzbN2KU21IfqSzLczNhoaGUkxW36vDIixqbLjB6olET
 a6qrWUQse6DKt485orERn76ySWmgnB6ohWZuMg3GtdvI/3RDnjnwkZt60b3v5qT7Dp
 I4Mtl4tnirs4r15hXTcE6uISZpIbBZfQvTYxPlQzAStv0b4SWBOpmqylHYFCQdL3K1
 8A7mzfRI3NuJQ==
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a475.dreamhost.com (Postfix) with ESMTPSA id 4d0j1f5rq7z1wdh;
 Mon,  3 Nov 2025 11:53:10 -0800 (PST)
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 dongjoo.seo1@samsung.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 armbru@redhat.com, linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 dave@stgolabs.net
Subject: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Date: Mon,  3 Nov 2025 11:52:04 -0800
Message-Id: <20251103195209.1319917-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.209.27; envelope-from=dave@stgolabs.net;
 helo=butterfly.birch.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

The following allows support for component basic back invalidation discovery
and config, by exposing the BI routing table and decoder registers. Instead
of going the type2[0] route, this series proposes adding support for type3
hdm-db, which allows a more direct way of supporting BI in qemu.

Changes from v3 (https://lore.kernel.org/all/20250930032153.1127773-1-dave@stgolabs.net/):
  o Fix Flexbus caps bits in patch 1. (Jonathan)
  o Flipped the bi arg to true for hard-configured components in patch 4 (Jonathan).
  o Expose the BI routing table only if the sw upstream port is in Flit mode.
  o Removed the mem-path= arg in the documentation as it deals with volatile (Donjoo). 

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

Applies against branch 'origin/cxl-2025-10-03-draft' from Jonathan's repository.

Thanks!

Davidlohr Bueso (4):
  hw/pcie: Support enabling flit mode
  hw/cxl: Allow BI by default in Window restrictions
  hw/cxl: Support type3 HDM-DB
  hw/cxl: Remove register special_ops->read()

Ira Weiny (1):
  hw/cxl: Refactor component register initialization

 docs/system/devices/cxl.rst               |  23 +++
 hw/cxl/cxl-component-utils.c              | 211 ++++++++++++++++------
 hw/cxl/cxl-host.c                         |   2 +-
 hw/mem/cxl_type3.c                        |  15 +-
 hw/pci-bridge/cxl_downstream.c            |  10 +-
 hw/pci-bridge/cxl_root_port.c             |  11 +-
 hw/pci-bridge/cxl_upstream.c              |  18 +-
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
 17 files changed, 319 insertions(+), 99 deletions(-)

--
2.39.5


