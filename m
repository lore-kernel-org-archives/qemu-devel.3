Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24281D3B986
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFuCp-0004P9-Nh; Tue, 26 Nov 2024 06:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tFuCm-0004OK-1w
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tFuCk-00031l-Mk
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732622285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jz6MlvqtoCSAhcS9Y8+lKtw4u/dNjdteJMJrfLPaG4Q=;
 b=cYjjwPXNhmhCQ96H7TrxDS68+yrT8UwbgWEWv5chI7tb3sBeTxtTZz1AeGU1CBktb6LyG8
 /J4d5v/TJ3Fhi8ORb9Vl5VXbl/kIuGOyOJeqzewGkSj5Gy0dMCyPnMaDasqPiXhWvinUWp
 LEn8ivsQLgr2NOPnXcl8PuA+x0JEzy0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-kO8J5yefPsa9PxZMriVy-g-1; Tue,
 26 Nov 2024 06:58:04 -0500
X-MC-Unique: kO8J5yefPsa9PxZMriVy-g-1
X-Mimecast-MFC-AGG-ID: kO8J5yefPsa9PxZMriVy-g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F6001955BFC; Tue, 26 Nov 2024 11:58:02 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7A6D19560A3; Tue, 26 Nov 2024 11:57:58 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v1 1/4] migration/multifd: move macros to multifd header
Date: Tue, 26 Nov 2024 17:27:45 +0530
Message-ID: <20241126115748.118683-2-ppandit@redhat.com>
In-Reply-To: <20241126115748.118683-1-ppandit@redhat.com>
References: <20241126115748.118683-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Move MULTIFD_ macros to the header file so that
they are accessible from other source files.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/multifd.c | 5 -----
 migration/multifd.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 498e71fd10..f8914276c4 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -33,11 +33,6 @@
 #include "io/channel-socket.h"
 #include "yank_functions.h"
 
-/* Multiple fd's */
-
-#define MULTIFD_MAGIC 0x11223344U
-#define MULTIFD_VERSION 1
-
 typedef struct {
     uint32_t magic;
     uint32_t version;
diff --git a/migration/multifd.h b/migration/multifd.h
index 50d58c0c9c..519dffeb9e 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -33,6 +33,11 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 bool multifd_recv(void);
 MultiFDRecvData *multifd_get_recv_data(void);
 
+/* Multiple fd's */
+
+#define MULTIFD_MAGIC 0x11223344U
+#define MULTIFD_VERSION 1
+
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
 
-- 
2.47.0


