Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53854C44524
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlxU7-0002Pp-6l; Mon, 20 Jul 2026 19:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wlxU3-0002N3-Hu
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:33:15 -0400
Received: from cyan.elm.relay.mailchannels.net ([23.83.212.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1wlxTz-00050K-VA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:33:15 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 6714F462DC5;
 Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com
 (trex-green-4.trex.outbound.svc.cluster.local [100.103.95.92])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 0ADD8462D36;
 Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Duck: 2aab881147c254fa_1784590388283_1795428076
X-MC-Loop-Signature: 1784590388283:2343086391
X-MC-Ingress-Time: 1784590388283
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.103.95.92 (trex/8.0.2); Mon, 20 Jul 2026 23:33:08 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xdv3slCz1Pv; 
 Mon, 20 Jul 2026 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1784590387;
 bh=hnKcICFiOcSlluv0YXDs2SsxD7mzY5SwQEcsVTozuQI=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=gZkm89AAhy3ELFaf5S+nJeWWtKrnIQncNTCzAwyNdynoMjU7dHheW128gUlJCOxsk
 IvBXols7dF6i+T5YZ+w7mv/CvbyjuGrBDcapfvz9rtePgLN84wlvrts34oRxLuHJbt
 Ycpq/aSK+xswY+BoPmJei+7EmMxMfs+PKnIMFGneVuKreSQX7oUU2DalHnvVYc6cyM
 Uougnw93g09EVNpCUNywqBzFgkIBN0kijQamny9rMDrLTqdRIPe6A5SCaMwcZxEu3I
 zNZsfy0KjXa8KOIvaqsNItCYyX90Hy/m6vM+qBu8a2Zfw8ZMw0UavYN7+e2S7ICka7
 eUY/OHB9v8LPQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	mst@redhat.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v2 2/5] hw/cxl: Drop Back-Invalidate from default CFMW window
 restrictions
Date: Mon, 20 Jul 2026 16:32:39 -0700
Message-Id: <20260720233242.901544-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720233242.901544-1-dave@stgolabs.net>
References: <20260720233242.901544-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.212.47; envelope-from=dave@stgolabs.net;
 helo=cyan.elm.relay.mailchannels.net
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The default CXL Fixed Memory Window restrictions advertised host-only
coherent together with Back-Invalidate.  A window advertising both
simultaneously is undefined behavior per CXL r4.0 9.18.1.3.

Drop Back-Invalidate from the default, leaving device-coherent +
host-only + volatile + persistent.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/acpi/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index f92f7fa3d558..75edb2c0a652 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0x2f, 2);
+    build_append_int_noprefix(table_data, 0x0f, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
-- 
2.39.5


