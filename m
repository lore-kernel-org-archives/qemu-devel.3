Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367EBC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3CT-0003jo-0q; Thu, 22 May 2025 06:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3CB-0003Qu-Lp
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3C6-0006eM-VB
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQNziEu5Fj9POumjoD3nKCDjlCm27YhHDF1NDBvBs5M=;
 b=icfSfwEJW6K7XnVdJlw68knnE7f94+akyVmzTbao8bUAvgS/CnxJRqt4gds57HdotYB+rX
 osa3t3+tz5UDBJ/n0pEeZaa5Oznpgy6jH+OUIlK6cuZAQNwyqcMTuB+Dq/xyxqsAW5n5Z+
 jqOxXRTVacAnLzK/sWXqG1fNd6eoLms=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-gOmYWhcqPc6UOApYrE21dQ-1; Thu,
 22 May 2025 06:30:32 -0400
X-MC-Unique: gOmYWhcqPc6UOApYrE21dQ-1
X-Mimecast-MFC-AGG-ID: gOmYWhcqPc6UOApYrE21dQ_1747909831
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 437D51800264; Thu, 22 May 2025 10:30:31 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D7131958014; Thu, 22 May 2025 10:30:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 17/23] io: Fix partial struct copy in
 qio_dns_resolver_lookup_sync_inet()
Date: Thu, 22 May 2025 11:29:17 +0100
Message-ID: <20250522102923.309452-18-berrange@redhat.com>
In-Reply-To: <20250522102923.309452-1-berrange@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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


