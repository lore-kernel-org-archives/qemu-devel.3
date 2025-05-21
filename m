Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96994C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHjuq-0008C8-62; Wed, 21 May 2025 09:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uHjuY-000848-J5
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uHjuW-00073l-Nq
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747835708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVKDOWFdrwGJNR46YeE3iOgMzM7afZeL0i/xV90sWQg=;
 b=hGlsg0Y9BfY3Soby+rMJxr7HpFLGCeqKpSbFzJdMlvyJgiRFk7wbC9VRosZhaEKs9/WvdC
 qhxth7FVpfhRe72wA8MjWawuNh+HZw1nR0CCeMcjbSyunFPksENpzUuNX460bQabgt7U04
 KieCzITs+fLLvL6sr+0SUgOlW9xKNM0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-8U5x5RFUNdmBuPgYwwSbwQ-1; Wed,
 21 May 2025 09:55:04 -0400
X-MC-Unique: 8U5x5RFUNdmBuPgYwwSbwQ-1
X-Mimecast-MFC-AGG-ID: 8U5x5RFUNdmBuPgYwwSbwQ_1747835703
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9F1A1956050; Wed, 21 May 2025 13:55:03 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D601619560AB; Wed, 21 May 2025 13:55:01 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 1/6] io: Fix partial struct copy in
 qio_dns_resolver_lookup_sync_inet()
Date: Wed, 21 May 2025 15:52:30 +0200
Message-ID: <20250521135240.3941598-2-jmarcin@redhat.com>
In-Reply-To: <20250521135240.3941598-1-jmarcin@redhat.com>
References: <20250521135240.3941598-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.49.0


