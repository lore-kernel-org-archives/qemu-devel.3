Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B177D2C55F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3FuJ-0001cL-So; Tue, 22 Oct 2024 10:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t3Ftm-0001RY-89
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t3Ftk-0007F2-TS
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729607412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89BuzVL2Ofdj6f7IOw3BkvNQfFJUf/0FqCtxr/n1RD0=;
 b=fLyCQPS6K8AJ4YDsSFSDogLxF3btW/bGKz2FOWQ+6bVY8wjftq2F9NokHLFP3s6Q1kzm6s
 emoBoFmpenmn0x4dfIi8LX99jLJkyDsln5NXrq1rZJ743DY8hY441Vx2wnhhImtx1Pa0rC
 CevccuUC7T0OakWV3kPitH9bRXW7cCQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-XZSS0MzbNtGiW8gM8BCIRg-1; Tue,
 22 Oct 2024 10:30:10 -0400
X-MC-Unique: XZSS0MzbNtGiW8gM8BCIRg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01C3919560AA; Tue, 22 Oct 2024 14:30:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.80])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65B8E19560AE; Tue, 22 Oct 2024 14:30:04 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH v4 2/5] qemu-ga: Initialize correctly so getline works properly
Date: Tue, 22 Oct 2024 22:29:45 +0800
Message-Id: <20241022142948.531325-3-demeng@redhat.com>
In-Reply-To: <20241022142948.531325-1-demeng@redhat.com>
References: <20241022142948.531325-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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

Proper initialization of param 'size_t n' to '0' for
getline to function correctly.

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index f0e9cdd27c..32bf1b8ce7 100644
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


