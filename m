Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65EFD3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nqk-0006WK-Ge; Tue, 29 Oct 2024 11:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t5nqi-0006Vl-QH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t5nqf-0007Jn-Ev
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730214567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mE+VKNyaO+nL5L+9GQV3DwO8jHatnhKEZ6MnmFcS1Y=;
 b=T9tj3/qn6Dzrekf+LGRmNEN04awA9pIX5LqdbGYM7tj4pFgsTOVh1gCSTJBBURL2vlNfWu
 +VB3PUAJlxwEg6y4AlKXZDuC/oxy7H9q1K4kPVYl0s9RGfybEwsNVBdK3xQlwRIul+Vuu3
 j8JFca38uypyGfoZ+JZH9lTTPbO2Ed8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-5LFhq5_YMGyqXwtJh7EztQ-1; Tue,
 29 Oct 2024 11:09:24 -0400
X-MC-Unique: 5LFhq5_YMGyqXwtJh7EztQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8EEB19560BD; Tue, 29 Oct 2024 15:09:22 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.130])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41AAA1956088; Tue, 29 Oct 2024 15:09:19 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH 1/5] migration/multifd: move macros to multifd header
Date: Tue, 29 Oct 2024 20:39:04 +0530
Message-ID: <20241029150908.1136894-2-ppandit@redhat.com>
In-Reply-To: <20241029150908.1136894-1-ppandit@redhat.com>
References: <20241029150908.1136894-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Move MULTIFD_ macros to the header file so that
they are accessible from other files.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/multifd.c | 4 ----
 migration/multifd.h | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 9b200f4ad9..97f6b6242a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -33,10 +33,6 @@
 #include "io/channel-socket.h"
 #include "yank_functions.h"
 
-/* Multiple fd's */
-
-#define MULTIFD_MAGIC 0x11223344U
-#define MULTIFD_VERSION 1
 
 typedef struct {
     uint32_t magic;
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


