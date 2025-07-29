Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB0AC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 17:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugoZh-0002EJ-Dl; Tue, 29 Jul 2025 13:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ugnbY-00039B-7C
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:55:08 -0400
Received: from barb.cherry.relay.mailchannels.net ([23.83.223.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ugnbU-0006BI-5s
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:55:07 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 926728466EA;
 Tue, 29 Jul 2025 16:54:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com
 (trex-blue-3.trex.outbound.svc.cluster.local [100.96.207.233])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2F3478465D5;
 Tue, 29 Jul 2025 16:54:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1753808098; a=rsa-sha256;
 cv=none;
 b=pyN5J/yIl8jmhEEwpQWeprYxzVoq8DILRg8KSV37wctlhWtEOS4DueL8yQv3YAUsHZWM5l
 awqfoVKGsWp2n+VbkOz5U6lPge1luQQrjycWPD+rpPGLZdehq2SdPvohDBN2vDhm0SYKmD
 JujC+CxJcXGDeVBd19TjBE6bPBcwWAitdYxnAWl/W+zNj8RYS8LA1AcvJoYMv6Fz0WDAEM
 00UVS1HqDA0LVox9s70dffMbz8XAHOVzQLDQM0bEcux/U2VPi6gGFtWSt1b9pnp6QSa4/y
 jCbVxSQhsteXBb0RNRivgQeSy3DfXQfa9+TcDxXWOJRsgjJtaDLhvYwVKmB6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1753808098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=1+NW2dZNPLP28QYPnv1p42CLMJoehjs1NoMynLHcXRY=;
 b=+Gf0hmvzFUXmys9bxyJifBxJ67P9EXteTj9YvB7BZgDNCR9d3y5g7oeUao7PxnZEV+MDBC
 rGST27P0vLGt0ExGsb+v3qmWaVma8OqmXfP74Z7H9P+9ZXDNBX0taThsQSszwOub1D58JB
 az/oQl5gSkjSw5WDtlIrqd//wB3fHkctUC7b+KyAWosA88hVPny9cLZXPtPEgNLt7ep4Eh
 0DupgL9ql2ezCa3TwBUK1q87DuDupeNtRJvo9Wek3k8KEcc1Z1V7gXYCNYEhxhIQXZ/nL1
 J8ziBrlS5T0YfkAT5SDwy/QKsh9g4eouvKMcc9X2REwVTGNDsxXfA8s4aqH7TQ==
ARC-Authentication-Results: i=1; rspamd-696f8998d-588f2;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Keen-Share: 30b1cf845b711aa7_1753808098450_1242008667
X-MC-Loop-Signature: 1753808098450:2403573240
X-MC-Ingress-Time: 1753808098450
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.207.233 (trex/7.1.3); Tue, 29 Jul 2025 16:54:58 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4bs1fn3sjKzKB; 
 Tue, 29 Jul 2025 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1753808098;
 bh=1+NW2dZNPLP28QYPnv1p42CLMJoehjs1NoMynLHcXRY=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=eylE3zsX0fP1e5yl4+AfxeMyPRAGwCGnZwbXhRK4pL21gY275qfiJw0BUjnDTZm5L
 RxjsQamjl/tRAA5JmMBY1HXgmdTdWos8xjdB0qMk45WRD5pfgg6EW1575PQc1+asH7
 NVvmVlZjq91fsM+hVMnODoEC7ngsRqp8gj+hUj/LceTpmIt86Lc2fWRFkmLz3wfJID
 OMi/KRyPHnDAjAq95gIq1vLM+vVRBe2BcT2Jj2iCrfUQQhDAhoftZ9iqBBRmQFNAHI
 igO3vHpoVRCxFqACrRaGfUMeJ3VubulkINCABYGk24h8qA7pvKCZtAlkvVRFoMwFmj
 g4hBR06gdpYKw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH RFC -qemu 0/2] hw/cxl: Support Back Invalidation
Date: Tue, 29 Jul 2025 09:54:39 -0700
Message-Id: <20250729165441.1898150-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.10; envelope-from=dave@stgolabs.net;
 helo=barb.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
of going the type2[1] route, this series proposes adding support for type3
hdm-db, which allows a more direct way of supporting BI in qemu.

Caveats/RFC: Just as in Ira's series, there is the question about the whole topology
allowing BI, not just the endpoint device. That series left the rest of topology
(dsp, rp) non-BI capable, for which any kernel counterpart testing would fail
when using type2, but at the same time is also consistent with flit 68B when not
using a type2 device.

This series blindly enables BI capabilities for ports even when no type3 hdm-db
is being used. While it is handy, it is inconsistent with the driver seeing 68B
and the BI registers in such cases. I've been going back and forth with possible
workarounds, but don't really have a good answer, and this will ultimately
affect not only BI but all goodies that come with 256B flit. Any suggestions welcome.

Patch 1: is lifted from Ira's series with some small (but non-trivial) changes.
Patch 2: adds BI decoder/rt register support.

Testing wise, this has passed relevant kernel side BI register IO flows and
setup.

Applies against branch 'origin/cxl-2025-07-03' from the jic23 repository.

Thanks!

[1] https://lore.kernel.org/linux-cxl/20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com/

Davidlohr Bueso (1):
  hw/cxl: Support Type3 HDM-DB

Ira Weiny (1):
  hw/cxl: Refactor component register initialization

 hw/cxl/cxl-component-utils.c   | 206 ++++++++++++++++++++++++---------
 hw/mem/cxl_type3.c             |   5 +-
 include/hw/cxl/cxl_component.h |  87 +++++++++++---
 include/hw/cxl/cxl_device.h    |   3 +
 4 files changed, 232 insertions(+), 69 deletions(-)

--
2.39.5


