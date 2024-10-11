Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880DFD24468
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 03:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6CH-0001mw-5i; Thu, 10 Oct 2024 23:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sz6CE-0001lQ-JD
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 23:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sz6CD-0002n4-97
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 23:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728616804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=En4E4bV6p0hB9ksV+UIpl4B2QQPRkJ/JelXvBFQNfuk=;
 b=hGA1BL/xJZ8IVr1sSg+ri/KwohK/vUE6rs6dSR0j7FlKt5NYXcTDJYQoO6idqfFJfG2cSM
 ynWRD0q8ymcdazykFHOIhO+7EkQRUvn8SVUwgjjMegVG3vivzTO5OviqjQ6U1YaUeicTyr
 VuqlMcsSSkmGWd3RTYzvL1hUw0DHeM4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-YjUdR7vEMOOpSOyOvv8Nxw-1; Thu,
 10 Oct 2024 23:20:00 -0400
X-MC-Unique: YjUdR7vEMOOpSOyOvv8Nxw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61A69195608C; Fri, 11 Oct 2024 03:19:59 +0000 (UTC)
Received: from fedora.nay.redhat.com (unknown [10.66.57.68])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8789B1956089; Fri, 11 Oct 2024 03:19:55 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org
Subject: [PATCH v2 3/4] Avoiding freeing line prematurely. It's now only freed
 at the end of the function.
Date: Fri, 11 Oct 2024 11:19:36 +0800
Message-Id: <20241011031937.92216-4-demeng@redhat.com>
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
 qga/commands-linux.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index b905f33a57..4f0e38be81 100644
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
 
@@ -2218,9 +2217,8 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
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


