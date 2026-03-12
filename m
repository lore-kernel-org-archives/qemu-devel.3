Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4751FFED2DD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0aFl-0004WU-2D; Thu, 12 Mar 2026 03:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aFj-0004WK-PC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:14:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aFi-0008F8-4C
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773299677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZaFMGlDzOF4JQOTYPrBkznSs7aelIBgPXoOpxZ186U=;
 b=R54ERMrl+ksaVbYtC0ZUy7bpAal3gdmAV1NZ84cLH9j34O/ud2E/AtujVR0qxsEcky8YjG
 ADxaSoir0xeB6CAHMKqCANyHZ4OZ2AMzKSI2nU4rxZ6MBFIRD5OIjXjX4C8d4cjf89MIB4
 EpaUzJoPex/K+ZBpb4nR/lbN9jtIqJ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-Fguhd8W3Poeg38Qs_jKU_g-1; Thu,
 12 Mar 2026 03:14:34 -0400
X-MC-Unique: Fguhd8W3Poeg38Qs_jKU_g-1
X-Mimecast-MFC-AGG-ID: Fguhd8W3Poeg38Qs_jKU_g_1773299673
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3861518002C9; Thu, 12 Mar 2026 07:14:33 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C116C1800361; Thu, 12 Mar 2026 07:14:29 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v2 1/9] net/filter: allow redirector on vhost TAP backends
Date: Thu, 12 Mar 2026 15:09:29 +0800
Message-ID: <20260312071415.1836655-2-lulu@redhat.com>
In-Reply-To: <20260312071415.1836655-1-lulu@redhat.com>
References: <20260312071415.1836655-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

netfilter_complete() currently rejects every filter attached to a
vhost-backed netdev. That prevents filter-redirector from being used on
the TAP backends that handle switchover capture and replay.

Permit filter-redirector on vhost-backed TAP netdevs, but keep the gate
narrow: other filters are still rejected and non-TAP backends remain
unsupported. Later commits can widen the filter set without duplicating
the backend restriction.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/filter.c b/net/filter.c
index 76345c1a9d..b9646b9e00 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -255,8 +255,19 @@ static void netfilter_complete(UserCreatable *uc, Error **errp)
     }
 
     if (get_vhost_net(ncs[0])) {
-        error_setg(errp, "Vhost is not supported");
-        return;
+        bool redirector = object_dynamic_cast(OBJECT(uc),
+                                              "filter-redirector");
+        bool buffer = object_dynamic_cast(OBJECT(uc), "filter-buffer");
+        bool vhost_filter = redirector || buffer;
+
+        if (!redirector) {
+            error_setg(errp, "Vhost is not supported");
+            return;
+        }
+        if (vhost_filter && ncs[0]->info->type != NET_CLIENT_DRIVER_TAP) {
+            error_setg(errp, "Vhost filter support requires a TAP backend");
+            return;
+        }
     }
 
     if (strcmp(nf->position, "head") && strcmp(nf->position, "tail")) {
-- 
2.52.0


