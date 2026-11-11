Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE666606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFRFNa7x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzNx-0000AK-3J; Tue, 10 Nov 2026 22:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNu-00006P-9d
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNs-0007OB-DB
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794369147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4QDAx78KWHUqPNjDA4H6eTXFRcl1oPkhjcemO9bHjY=;
 b=FFRFNa7xO2KwSqjQSzDQ1Of6mO03sI9Mz49NBenmhnV5KpygdVhiZ3bwTlxZ7XcTVmJJ9R
 iKSbgMaotsZ92kD7YjtQdV0XMQGjtIrHkNR4tvPuemW/gIq3g9MdMR0yjo/joDX7xJZ0mM
 XjtTYnAVizObRc0Z97/WdLSOkdjBb7E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-LkYeFxC8Ni2eVtfzD4iGjA-1; Tue,
 10 Nov 2026 22:52:20 -0500
X-MC-Unique: LkYeFxC8Ni2eVtfzD4iGjA-1
X-Mimecast-MFC-AGG-ID: LkYeFxC8Ni2eVtfzD4iGjA_1794369135
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE4EB1956054; Wed, 11 Nov 2026 03:52:14 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3A04300019F; Wed, 11 Nov 2026 03:52:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Feifan Qian <bea1e@proton.me>,
 Haotian Jiang <jianghaotian.sunday@gmail.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 5/8] nbd/server: Reject rather than assert on non-compliant
 BLOCK_STATUS
Date: Tue, 10 Nov 2026 21:51:30 -0600
Message-ID: <20261111035200.1751734-15-eblake@redhat.com>
In-Reply-To: <20261111035200.1751734-10-eblake@redhat.com>
References: <20261111035200.1751734-10-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NBD spec is clear that a client must not send NBD_BLOCK_STATUS
requests to a server if it did not negotiate any metacontexts with
NBD_OPT_SET_META_CONTEXT for the current export.  However, if the
non-compliant client uses NBD_OPT_EXTENDED_HEADERS and then passes in
the relatively new NBD_CMD_FLAG_PAYLOAD_LEN flag alongside an
inappropriate block status request, this was enough to trigger an
assertion in qemu.  The assertion can also be tripped by initially
requesting the context for one export, then using NBD_OPT_GO on a
different export (nbd_check_meta_export() sets contexts.count to 0,
but did not wipe contexts.exp). Forcing the client command to be
rejected if contexts.count is 0 solves both triggers, and allows the
assertion to still operate cleanly at a later location.

If you do not use recommended practice to prevent unwanted clients
from connecting to QEMU's NBD server, then any client can cause a
denial of service with minimal effort.  However, with TLS and x509
certs in place, an attacker must first chain in an attack to convince
the client to send unwanted traffic, which is a factor in declaring
this a lower-risk denial of service.

Fixes: CVE-2026-124559
Fixes: 2dcbb11b ("nbd/server: Add FLAG_PAYLOAD support to CMD_BLOCK_STATUS", v8.2.0)
Reported-by: Feifan Qian <bea1e@proton.me>
Reported-by: https://gitlab.com/qemu-project/qemu/-/work_items/3796
CC: Haotian Jiang <jianghaotian.sunday@gmail.com>
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261110155356.1520433-9-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 nbd/server.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index e6c47f8c2e3..8a01c27de07 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2584,17 +2584,18 @@ nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
         return -EINVAL;
     }

-    assert(client->contexts.exp == client->exp);
     nr_bitmaps = client->exp->nr_export_bitmaps;
     request->contexts = g_new0(NBDMetaContexts, 1);
     request->contexts->exp = client->exp;

-    if (payload_len % sizeof(uint32_t) ||
+    if (!client->contexts.count ||
+        payload_len % sizeof(uint32_t) ||
         payload_len < sizeof(NBDBlockStatusPayload) ||
         payload_len > (sizeof(NBDBlockStatusPayload) +
                        sizeof(id) * client->contexts.count)) {
         goto skip;
     }
+    assert(client->contexts.exp == client->exp);

     buf = g_malloc(payload_len);
     if (nbd_read(client->ioc, buf, payload_len,
-- 
2.56.0


