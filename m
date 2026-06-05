Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E63CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWkJ-0006Hc-5i; Fri, 05 Jun 2026 11:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjv-0005j2-Qa
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjt-0006MZ-1j
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvtgUw0LsKgXWb3LBOponuFZWLxF4j1rwT2ki82oRjQ=;
 b=DRFhXor84nX9JpvYwq6Ppy2VsIYkIhHa/dsoAr+C/qhwPm2LNa9CfuWB7Lsi0ohFwleRu6
 NKyL+uyBGr1O6FyGdPSj4tgIeetsUQqYZjfc7Rei8Lf+0moNDAJnOkv6vBfTmWasb2GF5t
 xMeW+EgjRjqLY1R8B9MkgKEt0fjESrY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-6iooWXW3MaiT-1n6tvDGPA-1; Fri,
 05 Jun 2026 11:45:32 -0400
X-MC-Unique: 6iooWXW3MaiT-1n6tvDGPA-1
X-Mimecast-MFC-AGG-ID: 6iooWXW3MaiT-1n6tvDGPA_1780674331
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71DC9195608C
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:45:31 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BB411955BC0; Fri,  5 Jun 2026 15:45:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:32 +0400
Subject: [GIT PULL 12/23] net/filter: free old values in property setters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-12-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vSCX1oIavb9OdWbiPaCqHhj5OIrYz9DIRgOhx0so1ts=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7V0hswmctlCcN/6a9g6va7JgUe4cYdNNUxH
 4aiMxjnpbeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5SKPD/9DqIXNDcuVu8Cm22ErlNw2mGiQZWo7Z/9Fk8+Q4NYV+q5c5Qx1KkJnb5A0c44QC/aybn1
 q1XjNht5930SUpytBNAIQ//AIB9asZ51PPGv5mvjRGzkhJoY6bO5Jk2uXey8pnRxQh7Jf1xMQ3g
 rqY4Orkn5bzPPxyOBjwcLYzcVWH7IdWGvr9ZDTowSB3rU5DI8vHLTLqeH5kPOjEwVoLHVbVmjcK
 y94vfVUj1N4HSmcNH9O5m+b+6Gr9HJ0E+s+BZBwEBZQzBHO8Ct511EXGvHhL2DJ6ES5Y5HyjaXR
 VDGYspu2QOpTpnAKmcsufXF0XVh67QOjaTHo2g9aUZfRG7kYIhmAskP4ays6ktL2UQekeyKbWlP
 Gy+ng0HGJFpGRlKw0xfKoAm2q3wqyuyo67bULh1KA4KOsB6KYb9bw7FtgGrqQBCmNKFuT+Z4plw
 qiokw9lMzx+4rEay2RVQKVBAgv929cxq1HSbdjCzbb7LJITfnA1XUiP3mgDgJCxUqpU9y4sYcFh
 fCbaWBybXN5vgICUOLmMTGGdQGCJa3P9aNW+wRuDPOpaOu7F968mvRZ0cVtb1voWQxlz9gcPAcE
 7Hp6ZxGU7iopbLN+IqHEAM/TlMGipi3E+Xa0hjQlP7ZQpAp3ZqplBNIs06Ddu4PWPSfjpMRIOff
 N2LFjqVHDrNZXPQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

netfilter_set_position and netfilter_set_netdev_id overwrote their
respective fields with g_strdup without freeing the previous value,
leaking memory on each property write.

Fixes: fdccce459621 ("init/cleanup of netfilter object")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/filter.c b/net/filter.c
index c7cc6615dc9..389f3b0bfef 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -130,6 +130,7 @@ static void netfilter_set_netdev_id(Object *obj, const char *str, Error **errp)
 {
     NetFilterState *nf = NETFILTER(obj);
 
+    g_free(nf->netdev_id);
     nf->netdev_id = g_strdup(str);
 }
 
@@ -182,6 +183,7 @@ static void netfilter_set_position(Object *obj, const char *str, Error **errp)
 {
     NetFilterState *nf = NETFILTER(obj);
 
+    g_free(nf->position);
     nf->position = g_strdup(str);
 }
 

-- 
2.54.0


