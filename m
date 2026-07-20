Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E592DC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlxU6-0002PF-DZ; Mon, 20 Jul 2026 19:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wlxU3-0002N4-Il
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:33:15 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wlxTz-00050L-Pg
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:33:15 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 82A0180270D;
 Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com
 (100-104-243-177.trex-nlb.outbound.svc.cluster.local [100.104.243.177])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 7EF55802BCA;
 Mon, 20 Jul 2026 23:33:07 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Bitter: 7d61d5b35271f909_1784590387770_910987872
X-MC-Loop-Signature: 1784590387770:750604934
X-MC-Ingress-Time: 1784590387769
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.104.243.177 (trex/8.0.2); Mon, 20 Jul 2026 23:33:07 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xdv02rpz1P9; 
 Mon, 20 Jul 2026 16:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1784590387;
 bh=OMIOmwFct7Bvsigsxau0j7OtTsPfP7cD/QiB88tlONg=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=ojRTW46VnMvqW441pkcsACYeRrh7pfXSWzf6w2FufXdcVa+8Ko0uCYfyhRkU2E7aa
 rn1Y4v5DPqjW27qStJWhWW5DNvN9TzT+7NVYM2lugTrHr98tmbfsph8P6meOtv5F/s
 S59p1fwlflkDU9ythsFVu6gQTErPB2Gd4DMy3qvKszETr/EbZzO+2pwCcNmzHTGNtR
 v0DQFjfVVYCWcmT2Bbj2Ik3s2TIx5CoSWD2JSvxAISQkj07iPA91xY8Syb8x9HQ+Lz
 LRIK/QWdFX4Qnv/9KXuoptyt4/Ga5ctZrsWCvU2ZjyiYlzjIViRm+rUMYjA7j4RJkt
 UNj0zVrq0oPDA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	mst@redhat.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v2 1/5] tests/bios-tables-test: Exclude CEDT.cxl for the CFMW
 restriction change
Date: Mon, 20 Jul 2026 16:32:38 -0700
Message-Id: <20260720233242.901544-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720233242.901544-1-dave@stgolabs.net>
References: <20260720233242.901544-1-dave@stgolabs.net>
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

The next patch changes the default CXL Fixed Memory Window restrictions,
dropping Back-Invalidate.  Add CEDT.cxl to the allowed-diff list so the
comparison passes until the expected blob is regenerated.

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


