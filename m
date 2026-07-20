Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBDEC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlxU9-0002SH-Mk; Mon, 20 Jul 2026 19:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wlxU4-0002O6-Rt
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:33:17 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wlxU0-00050M-GH
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:33:16 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 827684016FB;
 Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com
 (100-103-99-190.trex-nlb.outbound.svc.cluster.local [100.103.99.190])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id EFA77401DAA;
 Mon, 20 Jul 2026 23:33:06 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Robust-Bitter: 7ee8ba5a48fd37f7_1784590387231_2039064562
X-MC-Loop-Signature: 1784590387231:1777061217
X-MC-Ingress-Time: 1784590387231
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.103.99.190 (trex/8.0.2); Mon, 20 Jul 2026 23:33:07 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xdt3g1kz2x; 
 Mon, 20 Jul 2026 16:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1784590386;
 bh=qVPr/UgYAhoiY9M1ZZZNrrvDLAPjpjaAzUUl1S432Is=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=VpAB7emUzBxYsLCoPOVutG+Yo5M1t+UGy7EuNVu4YGEg+ECkW6G0iSMxqT9P6VHHC
 12tSXa3NX5v9hNPMPaWZz90I1CPk1PAmk7O4/JSG5D/n0hz1i17gIU/ejXztFGbM5o
 MttImMFDte81gOihdiU1Q78WbnmkvFbJbsEE1iJVlhtX4LTuGcA/YpVZqd1kHNhodj
 BPozdff0RUscQRpKBxCJSDfdPjwo4bIJ0LVTV5g4NxXUQj4VR2SACUD/DZI37IGko+
 7ycQtyry64CZiOjYO4PopzGnF8ZTRjvhF7W8sPTAUv+/lhxD5C263xrP8I7oeIAXj9
 yMEs7fTfzhe+Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	mst@redhat.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v2 0/5] hw/cxl: hw/cxl: Host-only default CFMW restrictions
 and per-window options
Date: Mon, 20 Jul 2026 16:32:37 -0700
Message-Id: <20260720233242.901544-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.222.61; envelope-from=dave@stgolabs.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Changes since v1 [0]:
 - Keep device-coherent (HDM-D) in the default alongside host-only -- 0x0f
   rather than v1's 0xe, dropping only Back-Invalidate. (Jonathan)
 - Give the mixed HDM-DB / host-only docs example a window per host bridge
   so the mapping is explicit and both windows are exercised (Jonathan).
 - Add qtests (new patch 5).

[0] https://lore.kernel.org/all/20260602231806.2469011-1-dave@stgolabs.net/

As of commit e6742e71c24 CXL emulation is incurring in an (per spec)
undefined behaviour scenario, by allowing the CXL Window to publish
all three coherency models. This series addresses this issue.

The CEDT CFMWS "Window Restrictions" field (CXL r4.0 9.18.1.3) advertises
which coherency models and memory types a CXL Fixed Memory Window (CFMW)
permits.

 - Patches 1-3 drop Back-Invalidate from the default Window Restrictions
   (0x2f -> 0x0f), keeping both the device-coherent and host-only coherency
   models plus volatile and persistent, so an unconfigured window is
   spec-compliant out of the box. It is split into three patches as the
   bios-tables-test workflow requires (exclude CEDT.cxl, change the value,
   regenerate the blob, please shout if I'm doing something silly).

 - Patch 4 makes the restrictions configurable per window via named machine
   properties -- device-coherent, host-only, volatile, persistent,
   fixed-config, back-invalidate. 

 - Patch 5 adds qtests.

Thanks!

Davidlohr Bueso (5):
  tests/bios-tables-test: Exclude CEDT.cxl for the CFMW restriction
    change
  hw/cxl: Drop Back-Invalidate from default CFMW window restrictions
  tests/acpi/cxl: Update CEDT.cxl for the default CFMW restrictions
  hw/cxl: Add configurable CXL Fixed Memory Window restriction flags
  tests/qtest/cxl: Add CXL Fixed Memory Window restriction flag tests

 docs/system/devices/cxl.rst      |  25 ++++----
 hw/acpi/cxl.c                    |   2 +-
 hw/cxl/cxl-host.c                |  46 +++++++++++++++
 include/hw/cxl/cxl.h             |  12 ++++
 qapi/machine.json                |  28 +++++++++
 tests/data/acpi/x86/q35/CEDT.cxl | Bin 184 -> 184 bytes
 tests/qtest/cxl-test.c           |  95 +++++++++++++++++++++++++++++++
 7 files changed, 197 insertions(+), 11 deletions(-)


base-commit: b9e9a55f9950b78ef4c940d0599409c614f36766
-- 
2.39.5


