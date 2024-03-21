Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26CBC6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 17:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnM8S-0000ge-Ms; Thu, 21 Mar 2024 13:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rnM8H-0000bi-LA
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rnM8F-0000Oq-DO
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711041789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZtMkdMPnn3gWTWNHxqBn2Ma4oUNK5BoJuVGcB9DoCc=;
 b=JgzNAGvqIkUQEqUoOq3u3WS8Fe4JoVXccJ4laXgVuKzoLjJl5JqqOVl1RAXlcOb2iOPf9w
 L6Mi31d4LGuibcRovHXuTUPBS1Vm/oQzBdQF4rjnCjCWY4gc5wvocp1dAwtrvRqaDwgKlg
 Vp84LzbLsvGc7XfOuqiQJQoNNUvnTp8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-RF6BD03bPQO_NAzj7ySxXg-1; Thu, 21 Mar 2024 13:23:06 -0400
X-MC-Unique: RF6BD03bPQO_NAzj7ySxXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04D078007B8;
 Thu, 21 Mar 2024 17:23:06 +0000 (UTC)
Received: from localhost (unknown [10.39.194.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F588C51464;
 Thu, 21 Mar 2024 17:23:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL for-9.0 1/1] coroutine: reserve 5,000 mappings
Date: Thu, 21 Mar 2024 13:22:51 -0400
Message-ID: <20240321172251.1542718-2-stefanha@redhat.com>
In-Reply-To: <20240321172251.1542718-1-stefanha@redhat.com>
References: <20240321172251.1542718-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrangé <berrange@redhat.com> pointed out that the coroutine
pool size heuristic is very conservative. Instead of halving
max_map_count, he suggested reserving 5,000 mappings for non-coroutine
users based on observations of guests he has access to.

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240320181232.1464819-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/qemu-coroutine.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 2790959eaf..eb4eebefdf 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -377,12 +377,17 @@ static unsigned int get_global_pool_hard_max_size(void)
                             NULL) &&
         qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
         /*
-         * This is a conservative upper bound that avoids exceeding
-         * max_map_count. Leave half for non-coroutine users like library
-         * dependencies, vhost-user, etc. Each coroutine takes up 2 VMAs so
-         * halve the amount again.
+         * This is an upper bound that avoids exceeding max_map_count. Leave a
+         * fixed amount for non-coroutine users like library dependencies,
+         * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
+         * remaining amount.
          */
-        return max_map_count / 4;
+        if (max_map_count > 5000) {
+            return (max_map_count - 5000) / 2;
+        } else {
+            /* Disable the global pool but threads still have local pools */
+            return 0;
+        }
     }
 #endif
 
-- 
2.44.0


