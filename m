Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0A4CD6E64
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 23:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUYNo-00033z-IR; Tue, 02 Jun 2026 19:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wUYNn-00033j-Pd
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 19:18:51 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wUYNm-0008M8-5z
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 19:18:51 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id BD56A402C75;
 Tue, 02 Jun 2026 23:18:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com
 (100-103-80-215.trex-nlb.outbound.svc.cluster.local [100.103.80.215])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 60884402C7E;
 Tue, 02 Jun 2026 23:18:47 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Absorbed: 1af98fc53376dabc_1780442327626_2445509738
X-MC-Loop-Signature: 1780442327626:3667555747
X-MC-Ingress-Time: 1780442327626
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.103.80.215 (trex/7.1.5); Tue, 02 Jun 2026 23:18:47 +0000
Received: from localhost.localdomain (unknown [181.212.92.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gVRbT732Vz1041;
 Tue,  2 Jun 2026 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1780442327;
 bh=Y60gMEITJfCqStaTYSFD8uzsncBlRLgD4z5UccFv+RI=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=LP1V0C+nvIbxNEFifrTaPCggxU0rWlDpZrnVmZ/XRqr2y7EZLhEekoxx9FeyV4INf
 sew8BRzpkOSu4atWRRBw3yl69MCaFhTja3UDToYu5TgK7tHjXC9SohsLVif1gEwyBk
 dEJTTNX6wKtuTSxAJlVFysxyA8xTpB55RcQVRSEp2QHmTr6gzR0gPoqymUq/yvU9c1
 eKnz9PuckKHoCJ2UpyUUYUUG0xWzFv9SKp7Ko0HDpcpp7w+Z4YliPZlg/rsDEr3YDg
 KF0mlz5x/Ha54v/i0+rSXrBkBedPG69synmMc1Z3buMNkKOTRIzO+yHwGzkSiDrCXa
 4mK7eJpiKb9dQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 1/4] tests/bios-tables-test: Exclude CEDT.cxl for host-only
 restriction default
Date: Tue,  2 Jun 2026 16:18:03 -0700
Message-Id: <20260602231806.2469011-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260602231806.2469011-1-dave@stgolabs.net>
References: <20260602231806.2469011-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.222.61; envelope-from=dave@stgolabs.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

The next patch changes the default CXL Fixed Memory Window restrictions
to host-only coherency, dropping Device Coherent and Back-Invalidate.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..b4646b5b3147 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/CEDT.cxl",
-- 
2.39.5


