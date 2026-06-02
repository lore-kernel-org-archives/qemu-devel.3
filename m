Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E834ACD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 23:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUYNr-000351-07; Tue, 02 Jun 2026 19:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wUYNo-000340-U8
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 19:18:52 -0400
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wUYNn-0008MI-BL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 19:18:52 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id AFC4C721ED6;
 Tue, 02 Jun 2026 23:18:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com
 (100-109-199-18.trex-nlb.outbound.svc.cluster.local [100.109.199.18])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2DD507208C6;
 Tue, 02 Jun 2026 23:18:49 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ski-Bored: 3126b925763d1e9f_1780442329622_3306041104
X-MC-Loop-Signature: 1780442329622:256772112
X-MC-Ingress-Time: 1780442329621
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.109.199.18 (trex/7.1.5); Tue, 02 Jun 2026 23:18:49 +0000
Received: from localhost.localdomain (unknown [181.212.92.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gVRbW4jzTz107X;
 Tue,  2 Jun 2026 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1780442329;
 bh=EUCYD7G0hS4r9cU0to/bYQKfqUIG9pVGYsJSpBxIsk8=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=Qsm48XZINYSgLbaLokaL/Wyj6m/ApOOvZssuEmoSBw2jF8zMhy56SZZRYg8BxGqxt
 3p2kHGoGp1t2r3vGkWzyV08xSGxNcpLGYXeF2+RMiJK+PaZqsggAGLoVdahBTjs/GL
 BiVrh4VN962urZ/lfrOyHiUeuE0I2f7NVsoq4/b1GJo8HZfNTt3p6w35JvrRp5wYHE
 UwrW1iGJBbFdhD4fBESi3u037hCw2MJ17Y57SLfWYlPQ8RRHNH0UHhflC1GS5PePMO
 vYe+F0+VSqNG8H6LUBYFEEwbYWvu6dAomrw4Lv/1iLJSfRLxAPQLFwuQQBb/eHjGIo
 6JY9EEzm20i/w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 2/4] hw/cxl: Use host-only coherency for default CFMW
 restrictions
Date: Tue,  2 Jun 2026 16:18:04 -0700
Message-Id: <20260602231806.2469011-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260602231806.2469011-1-dave@stgolabs.net>
References: <20260602231806.2469011-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.218.253; envelope-from=dave@stgolabs.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Change the default CXL Fixed Memory Window restrictions from 0x2f to
0xe, dropping Device Coherent and Back-Invalidate.

host-only coherent combined with Back-Invalidate is undefined behavior.
Device Coherent alongside host-only coherent is permitted by the spec
(multiple restriction bits may be set) but advertises conflicting
coherency modes; neither belongs in the host-only default.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/acpi/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index f92f7fa3d558..5ce5e8e083ba 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0x2f, 2);
+    build_append_int_noprefix(table_data, 0xe, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
-- 
2.39.5


