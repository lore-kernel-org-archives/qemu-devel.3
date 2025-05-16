Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E3BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFxRN-0008Q1-PW; Fri, 16 May 2025 11:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRM-0008Pt-CP
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRK-0002cX-Um
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747411056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVKDOWFdrwGJNR46YeE3iOgMzM7afZeL0i/xV90sWQg=;
 b=BaarPSiRYPcxfpGa4pSVEV7ZVDFub9SJpbTrLWMfoSk1ck5lKqSnmjVnxy3//rY6mDGYej
 mU6JoXlg+HamtsQXBQzfhr4Nm294R4/9x5OUF+wtGc0DRVqvkfQGETcQ3fpQ2yf8jFzhVR
 ix6joixF76aHZtIX8C3M+TpTaJYakZI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-25EWm5fxMXOSn-MkQ4KmWg-1; Fri,
 16 May 2025 11:57:33 -0400
X-MC-Unique: 25EWm5fxMXOSn-MkQ4KmWg-1
X-Mimecast-MFC-AGG-ID: 25EWm5fxMXOSn-MkQ4KmWg_1747411052
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B40861800366; Fri, 16 May 2025 15:57:31 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CB6018003FC; Fri, 16 May 2025 15:57:29 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 1/7] io: Fix partial struct copy in
 qio_dns_resolver_lookup_sync_inet()
Date: Fri, 16 May 2025 17:56:53 +0200
Message-ID: <20250516155710.2246148-2-jmarcin@redhat.com>
In-Reply-To: <20250516155710.2246148-1-jmarcin@redhat.com>
References: <20250516155710.2246148-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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


