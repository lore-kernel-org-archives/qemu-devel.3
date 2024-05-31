Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D934FC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCwhQ-0004MB-AI; Fri, 31 May 2024 03:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sCwhO-0004LG-0w
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sCwhM-0003Y1-FJ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717140552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yvvHCsFGcQy3avS2tqQfsLMqNzxPdKw9AyVqslnxSY=;
 b=YgkhqZPCSwr1ss7G9aSEPeeW+dosxshfJ6d00M8jQIHPPhT98BJY7Qh9cfBl2vO3vkzD+Y
 AAOijYOHnwoMWzTv5K0Ws510vd5aJwAwF3JXJrmelpoDVNMKPP6YNLPv3wKBvD78miNGit
 M0Q8thhp0bSa+vSQY7G2IcrzyuQqyj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-DO92o0PrOp-8hmP6x2A4IQ-1; Fri, 31 May 2024 03:29:09 -0400
X-MC-Unique: DO92o0PrOp-8hmP6x2A4IQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45FBF185A783
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 07:29:09 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79CA1491032;
 Fri, 31 May 2024 07:29:08 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com,
	imammedo@redhat.com
Subject: [PATCH v2 1/4] osdep: Make qemu_madvise() to set errno in all cases
Date: Fri, 31 May 2024 09:28:57 +0200
Message-ID: <e2250aa1d69faffcfd12b6d809d98b0c8157ce36.1717140354.git.mprivozn@redhat.com>
In-Reply-To: <cover.1717140354.git.mprivozn@redhat.com>
References: <cover.1717140354.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The unspoken premise of qemu_madvise() is that errno is set on
error. And it is mostly the case except for posix_madvise() which
is documented to return either zero (on success) or a positive
error number. This means, we must set errno ourselves. And while
at it, make the function return a negative value on error, just
like other error paths do.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 util/osdep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/osdep.c b/util/osdep.c
index e996c4744a..e42f4e8121 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -57,7 +57,12 @@ int qemu_madvise(void *addr, size_t len, int advice)
 #if defined(CONFIG_MADVISE)
     return madvise(addr, len, advice);
 #elif defined(CONFIG_POSIX_MADVISE)
-    return posix_madvise(addr, len, advice);
+    int rc = posix_madvise(addr, len, advice);
+    if (rc) {
+        errno = rc;
+        return -1;
+    }
+    return 0;
 #else
     errno = EINVAL;
     return -1;
-- 
2.44.1


