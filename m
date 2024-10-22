Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B02D2C55F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3FuO-0001oB-4Q; Tue, 22 Oct 2024 10:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t3Ftt-0001ab-4v
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t3Ftq-0007Fp-Vb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729607417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S70GhYB7laEL2fnTCNmkV4yqr3u8YRvyEUuIY22drcU=;
 b=Xnk6PrwSwdGNp2mw4Ci37rnG5UNSJuPTapSWyrOa6zsm9BAvFoAJ+adRYxJ2ANZZQbFjqD
 lbcOI+yH5+XHKlAYDJ4UA8eUPElC/Bn0QnBvu+sS81RZyG7ZoPXOeeUdCdCmsqifsPkO3W
 8deVkLGUrA6VO3xj7YscUjgShlACEkw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-w2NRoPHROc-4vH9Is8SCCQ-1; Tue,
 22 Oct 2024 10:30:14 -0400
X-MC-Unique: w2NRoPHROc-4vH9Is8SCCQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6732819560AD; Tue, 22 Oct 2024 14:30:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.80])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D05391955F42; Tue, 22 Oct 2024 14:30:09 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH v4 3/5] qemu-ga:  Avoiding freeing line prematurely
Date: Tue, 22 Oct 2024 22:29:46 +0800
Message-Id: <20241022142948.531325-4-demeng@redhat.com>
In-Reply-To: <20241022142948.531325-1-demeng@redhat.com>
References: <20241022142948.531325-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

It's now only freed at the end of the function.

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-linux.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 32bf1b8ce7..c6bda78de6 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2137,8 +2137,7 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
         is_ipv6 = (i == 1);
         fp = fopen(routeFiles[i], "r");
         if (fp == NULL) {
-            error_setg_errno(errp, errno, "open(\"%s\")", routeFiles[i]);
-            free(line);
+            error_setg_errno(errp, errno, "open(\"%s\")", route_files[i]);
             continue;
         }
 
@@ -2226,9 +2225,8 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
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


