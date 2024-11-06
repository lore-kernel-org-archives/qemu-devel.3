Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318A9D29FB3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 08:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8bc9-0005WD-N5; Wed, 06 Nov 2024 03:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t8bc7-0005VM-9S
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:42:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t8bc5-0007Uj-LF
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730882524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuKheEd+RIhCNNVlsfYRfvUtD5CnI0aqPx70+3FcBsM=;
 b=gweZJbfjhh8tu35cPXxzdsmreO46nyS7mXaLWtYW2AoRQ4UFZLQF4IeCtT8p9Bso7aBmYD
 8hkB576bLyZBHXeeFij6iroswgFl7Qc6j43KXsS+lUttbNLvEP94Psi5n+6s4K7+y7ZODL
 A/EVf7GQjJ6rb/0zRFcygKy56J22Qqw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-eDi7X9LaOWWCVs0cCHKRgQ-1; Wed,
 06 Nov 2024 03:41:59 -0500
X-MC-Unique: eDi7X9LaOWWCVs0cCHKRgQ-1
X-Mimecast-MFC-AGG-ID: eDi7X9LaOWWCVs0cCHKRgQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76AC71955F3E; Wed,  6 Nov 2024 08:41:58 +0000 (UTC)
Received: from fedora.nay.redhat.com (unknown [10.66.57.68])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C9861955F40; Wed,  6 Nov 2024 08:41:54 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH v5 3/3] qemu-ga: Avoiding freeing line prematurely
Date: Wed,  6 Nov 2024 16:41:34 +0800
Message-Id: <20241106084134.1133061-4-demeng@redhat.com>
In-Reply-To: <20241106084134.1133061-1-demeng@redhat.com>
References: <20241106084134.1133061-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

It's now only freed at the end of the function.

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-linux.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 55c35bfc8f..70020621bf 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2138,8 +2138,7 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
         is_ipv6 = (i == 1);
         fp = fopen(routeFiles[i], "r");
         if (fp == NULL) {
-            error_setg_errno(errp, errno, "open(\"%s\")", routeFiles[i]);
-            free(line);
+            error_setg_errno(errp, errno, "open(\"%s\")", route_files[i]);
             continue;
         }
 
@@ -2148,7 +2147,6 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                 firstLine = 0;
                 continue;
             }
-            
             if (is_ipv6) {
                 char destination[33], source[33], next_hop[33];
                 int des_prefixlen, src_prefixlen, metric, refcnt, use, flags;
@@ -2215,9 +2213,8 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
             QAPI_LIST_APPEND(tail, route);
         }
 
-        free(line);
         fclose(fp);
     }
-
+    free(line);
     return head;
 }
-- 
2.40.1


