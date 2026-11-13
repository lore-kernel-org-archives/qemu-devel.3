Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1227606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HGljZjJh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsLx-0002pq-Mu; Fri, 13 Nov 2026 09:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRsJq-0008HE-9M
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRsJm-0007Ke-Hh
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794580313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrZedr75GGg9WN9k+O0G0oSPPKkMM+sHh5y9JswdQsU=;
 b=HGljZjJhZzGS6aUjHYm4tbJTUYNQZ1K42zOfg8VUVHgMCShTiV/5GZPDt8F5ryT4zCNAS+
 OG05XTN+Jhj5knZUjMVQAOPIAeRm2Nybq6TJp754iabKmXBVfbRtNULCCpWmYTOl0Qi8rs
 LJHtCQJr8DkYB0EC9NzdRa3p/fvAD0I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-EvKyk0B-MCy1Gwmsy7G-qA-1; Fri,
 13 Nov 2026 09:31:49 -0500
X-MC-Unique: EvKyk0B-MCy1Gwmsy7G-qA-1
X-Mimecast-MFC-AGG-ID: EvKyk0B-MCy1Gwmsy7G-qA_1794580306
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9547418005BA; Fri, 13 Nov 2026 14:31:46 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F0B344B; Fri, 13 Nov 2026 14:31:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL v2 5/6] nbd/server: Reject rather than assert on non-compliant
 NBD_OPT_SET_META_CONTEXT
Date: Fri, 13 Nov 2026 08:30:33 -0600
Message-ID: <20261113143132.2414774-13-eblake@redhat.com>
In-Reply-To: <20261113143132.2414774-8-eblake@redhat.com>
References: <20261113143132.2414774-8-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The NBD protocol says that NBD_OPT_{LIST,SET}_META_CONTEXT sends
several lengths that must be consistent: an overall option reply
length, then a series of smaller lengths/data pairs representing the
export name and zero or more context names. If the smaller lengths
within the payload do not add up to the larger value, the client has
sent garbage bytes that will trigger the server's parse of the
client's next option to be out of sync.  However, QEMU was dying with
an assertion failure rather than diagnosing the issue, which a
malicious client can then exploit to mount a denial-of-service attack
against QEMU as the NBD server.

As with several other recent NBD protocol violations, the likelihood
of this attack can be reduced by using TLS and x509 certs to reject
unwanted clients (a "trusted" client can still trigger the problem,
but you first have to compromise the trusted client into sending
arbitrary traffic).

Fixes: CVE-2026-125683
Fixes: e7b1948d51 ("nbd: BLOCK_STATUS for standard get_block_status function: server part", v2.12.0)
Reported-by: TonySD via https://gitlab.com/qemu-project/qemu/-/work_items/4843
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261110155356.1520433-11-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 nbd/server.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 8a01c27de07..8c45f9fc43f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1095,6 +1095,11 @@ nbd_negotiate_meta_queries(NBDClient *client, Error **errp)
             }
         }
     }
+    if (client->optlen > 0) {
+        return nbd_opt_invalid(client, errp,
+                               "Inconsistent lengths in option %s",
+                               nbd_opt_lookup(client->opt));
+    }

     if (meta->base_allocation) {
         ret = nbd_negotiate_send_meta_context(client, "base:allocation",
-- 
2.56.0


