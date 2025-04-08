Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C12AC369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 11:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u275a-0007WQ-Sp; Tue, 08 Apr 2025 07:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u275Y-0007WC-AO
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1u275W-0006NG-H0
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744111553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZYjj3TSQknbpghdbxSdQf+QPw46EKUTI+qxJHOAmRg=;
 b=VRM3ezGE8zEKtMeVdeyVCpwaMEfbbTSQLAYZt7EBsF/24avj8yvMbojRbwaUxP4tXB59Sl
 z6telflKgu5heWi7hWLZhTrJFMBeNTZxAfZX3cVIyA0vwjUKLpvQxm6SYlys35S91HEN9S
 KRQPpGjGAFUnH5Si/yoOQfTS0YX0IWk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-KFGmRhtJM0-UIAUkiu1m4g-1; Tue,
 08 Apr 2025 07:25:48 -0400
X-MC-Unique: KFGmRhtJM0-UIAUkiu1m4g-1
X-Mimecast-MFC-AGG-ID: KFGmRhtJM0-UIAUkiu1m4g_1744111547
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E197818001FA; Tue,  8 Apr 2025 11:25:46 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.44.34.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0E7719560AD; Tue,  8 Apr 2025 11:25:44 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 1/5] io: Fix partial struct copy in
 qio_dns_resolver_lookup_sync_inet()
Date: Tue,  8 Apr 2025 13:25:00 +0200
Message-ID: <20250408112508.1638722-2-jmarcin@redhat.com>
In-Reply-To: <20250408112508.1638722-1-jmarcin@redhat.com>
References: <20250408112508.1638722-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

Commit aec21d3175 (qapi: Add InetSocketAddress member keep-alive)
introduces the keep-alive flag, but this flag is not copied together
with other options in qio_dns_resolver_lookup_sync_inet().

This patch fixes this issue and also prevents future ones by copying the
entire structure first and only then overriding a few attributes that
need to be different.

Fixes: aec21d31756c (qapi: Add InetSocketAddress member keep-alive)
Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 io/dns-resolver.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 53b0e8407a..3712438f82 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -111,22 +111,11 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
                     uaddr, INET6_ADDRSTRLEN, uport, 32,
                     NI_NUMERICHOST | NI_NUMERICSERV);
 
-        newaddr->u.inet = (InetSocketAddress){
-            .host = g_strdup(uaddr),
-            .port = g_strdup(uport),
-            .has_numeric = true,
-            .numeric = true,
-            .has_to = iaddr->has_to,
-            .to = iaddr->to,
-            .has_ipv4 = iaddr->has_ipv4,
-            .ipv4 = iaddr->ipv4,
-            .has_ipv6 = iaddr->has_ipv6,
-            .ipv6 = iaddr->ipv6,
-#ifdef HAVE_IPPROTO_MPTCP
-            .has_mptcp = iaddr->has_mptcp,
-            .mptcp = iaddr->mptcp,
-#endif
-        };
+        newaddr->u.inet = *iaddr;
+        newaddr->u.inet.host = g_strdup(uaddr),
+        newaddr->u.inet.port = g_strdup(uport),
+        newaddr->u.inet.has_numeric = true,
+        newaddr->u.inet.numeric = true,
 
         (*addrs)[i] = newaddr;
     }
-- 
2.48.1


