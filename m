Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EACD15D8C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 13:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2sTc-0006V6-6f; Mon, 21 Oct 2024 09:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t2sTX-0006ND-FU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t2sTV-0000ie-8h
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729517372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S70GhYB7laEL2fnTCNmkV4yqr3u8YRvyEUuIY22drcU=;
 b=W0PffRVo29fnNH+cFTzYSqgSaJP6jtQ8Lg9s17Zmxc6hKErt3x+ErS9ehUXqEyMF5cxuu1
 izeAu21hapVnZNnSnFL8y3ew4nlObw+gDGxOtNBTt8RZTm1IchusTDFG6ThsjBdeMFQZMH
 UOAVhMgqbDFEQGmKn8gL3tTaUDQWWBQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-fH6WnoLZOgGCFlOyS_A4hw-1; Mon,
 21 Oct 2024 09:29:29 -0400
X-MC-Unique: fH6WnoLZOgGCFlOyS_A4hw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26FA41955D64; Mon, 21 Oct 2024 13:29:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.80])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72C0B1955E83; Mon, 21 Oct 2024 13:29:24 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH v3 3/4] qemu-ga: Avoiding freeing line prematurely
Date: Mon, 21 Oct 2024 21:28:38 +0800
Message-Id: <20241021132839.463255-9-demeng@redhat.com>
In-Reply-To: <20241021132839.463255-1-demeng@redhat.com>
References: <20241021132839.463255-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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


