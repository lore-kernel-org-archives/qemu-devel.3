Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CF5CD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 23:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUYNp-00034N-UA; Tue, 02 Jun 2026 19:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wUYNo-00033q-0b
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 19:18:52 -0400
Received: from butterfly.birch.relay.mailchannels.net ([23.83.209.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wUYNm-0008M7-8w
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 19:18:51 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D0A42801CEA;
 Tue, 02 Jun 2026 23:18:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com
 (100-109-202-128.trex-nlb.outbound.svc.cluster.local [100.109.202.128])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 26BF5801E1F;
 Tue, 02 Jun 2026 23:18:47 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bored-Blushing: 14292ab73114efe5_1780442327636_591365789
X-MC-Loop-Signature: 1780442327636:130476261
X-MC-Ingress-Time: 1780442327636
Received: from pdx1-sub0-mail-a251.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.109.202.128 (trex/7.1.5); Tue, 02 Jun 2026 23:18:47 +0000
Received: from localhost.localdomain (unknown [181.212.92.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gVRbS1zR9z107p;
 Tue,  2 Jun 2026 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1780442325;
 bh=PNR2zmPZNrltlaAyMs5BB8X7/xQzarCvrNRYiQEXme4=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=IdQToCVo6fcTXvzsB9QZah1Lb5gIipy3BwkKYGYLw3jbLT3EdDSO8e8MxDGZvWtBx
 lgiRMD3OTvPPPQWfv2fVqMGby/cXOqwXVzM7DY1zv89YCcrcBV2hh7j4DP5rh+Evxq
 RuP1jq2X6ucy3ASrC2q0BvJ0QCzLSyRCG7aGzH8LhNlfFxzpvy/M11MP1p49gqMneG
 WtARK6deQ8FUGfsGRj4sexQMDdKKUbPRkoO7qiw6hFkUAvNiN53V9q7xqmh/LLKpzv
 YucQEQ8wZTHhFAJWaCjUUJjhYd+JR7lIE0ZVx7Fh/oqyCYfdoLFXXcTTyFY9yhJHnL
 K9rRpWXmh4NnA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH -qemu 0/4] hw/cxl: Host-only default CFMW restrictions and
 per-window options
Date: Tue,  2 Jun 2026 16:18:02 -0700
Message-Id: <20260602231806.2469011-1-dave@stgolabs.net>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The CEDT CFMWS "Window Restrictions" field (CXL r4.0 9.18.1.3) advertises
which coherency models and memory types a CXL Fixed Memory Window (CFMW)
permits. Qemu hardcodes this to 0x2f, which advertises Device Coherent,
host-only coherent and Back-Invalidate (BI) simultaneously, which is a
spec violation/UB.

 - Patches 1-3 fix the default Window Restrictions from 0x2f to
   0xe (host-only coherent, volatile, persistent), so an unconfigured
   window is spec-compliant out of the box. I have split it in 3 patches
   as indicated by the bios-tables-test, please shout if I did something
   stupid updating the binary (this was a bit confusing).

 - Patch 4 makes the restrictions configurable per window via named machine
   properties -- device-coherent, host-only, volatile, persistent, fixed-config,
   back-invalidate.

Without patch 4 the HDM-DB support is effectively untestable upstream.

Davidlohr Bueso (4):
  tests/bios-tables-test: Exclude CEDT.cxl for host-only restriction default
  hw/cxl: Use host-only coherency for default CFMW restrictions
  tests/acpi/cxl: Update CEDT.cxl for host-only default restrictions
  hw/cxl: Add per-capability CXL Fixed Memory Window restriction flags

 docs/system/devices/cxl.rst      |  13 +++-----
 hw/acpi/cxl.c                    |   2 +-
 hw/cxl/cxl-host.c                |  55 +++++++++++++++++++++++++++++++
 include/hw/cxl/cxl.h             |  12 +++++++
 qapi/machine.json                |  29 ++++++++++++++++
 tests/data/acpi/x86/q35/CEDT.cxl | Bin 184 -> 184 bytes
 6 files changed, 101 insertions(+), 10 deletions(-)

-- 
2.39.5


