Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02297D24463
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 03:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6C9-0001if-Pb; Thu, 10 Oct 2024 23:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sz6C8-0001iF-6o
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 23:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sz6C6-0002an-U0
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 23:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728616798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KgdZ+HD0518zqi0YLO1K0m739vSttIHyUWJfEt1DIKY=;
 b=hHLljgTnppBY/5V1FRkc1P14MmlpqJ/klNRSWUgHCNF4N6eGyRt7wYR+kT+Ka+pl+79nvJ
 /UJ3WuHzbY4wJzfiJOf2hbQxiQKrR1i13LIa7Pv7ZfkEHw98K1r0kJqqKX30f2snDF5dXJ
 nAUseEb9uVnTbL2PmuXFTJZpkt+KTGo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-zt3eNu1xMuWFlRV4c8G8LQ-1; Thu,
 10 Oct 2024 23:19:55 -0400
X-MC-Unique: zt3eNu1xMuWFlRV4c8G8LQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B453619560A7; Fri, 11 Oct 2024 03:19:54 +0000 (UTC)
Received: from fedora.nay.redhat.com (unknown [10.66.57.68])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC1F51956089; Fri, 11 Oct 2024 03:19:50 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org
Subject: [PATCH v2 2/4] Proper initialization of n to 0 for getline to
 function correctly.
Date: Fri, 11 Oct 2024 11:19:35 +0800
Message-Id: <20241011031937.92216-3-demeng@redhat.com>
In-Reply-To: <20241011031937.92216-1-demeng@redhat.com>
References: <20241011031937.92216-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 2c2b5f4ff2..b905f33a57 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2126,7 +2126,7 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
     GuestNetworkRouteList *head = NULL, **tail = &head;
     const char *routeFiles[] = {"/proc/net/route", "/proc/net/ipv6_route"};
     FILE *fp;
-    size_t n;
+    size_t n = 0;
     char *line = NULL;
     int firstLine;
     int is_ipv6;
-- 
2.40.1


