Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F69C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXukF-0006ZO-CI; Wed, 07 Feb 2024 22:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujy-0006IQ-AC
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujw-0004Mo-Iy
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nU6Ac8DCGPpdvPW3rUwbnDqO5IX17ELyXMrLfPktHk=;
 b=AClL6raaacWWCB/fcUt2tFDvc3i527/n1a/LgsKKx0rfAhbxjl5UYm1bmCqggNJYHQgVUK
 2vmLJkqjSPYRTAygCLfrVgBkP0/B+stxWrA/SdmdostTgdtISgZAG/q/qMHugYo8PSU9IE
 BU9h1bxc8rpdRfVBHHJVBRHQJnJnj30=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-AajobNSKND6xAk2vnJ_G9Q-1; Wed,
 07 Feb 2024 22:06:13 -0500
X-MC-Unique: AajobNSKND6xAk2vnJ_G9Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5FC529AC010;
 Thu,  8 Feb 2024 03:06:13 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 641D5492BC7;
 Thu,  8 Feb 2024 03:06:11 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 13/34] migration/multifd: multifd_send_prepare_header()
Date: Thu,  8 Feb 2024 11:05:07 +0800
Message-ID: <20240208030528.368214-14-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Introduce a helper multifd_send_prepare_header() to setup the header packet
for multifd sender.

It's fine to setup the IOV[0] _before_ send_prepare() because the packet
buffer is already ready, even if the content is to be filled in.

With this helper, we can already slightly clean up the zero copy path.

Note that I explicitly put it into multifd.h, because I want it inlined
directly into multifd*.c where necessary later.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-13-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h |  8 ++++++++
 migration/multifd.c | 16 ++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 2e4ad0dc56..4ec005f53f 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -209,5 +209,13 @@ typedef struct {
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
 
+static inline void multifd_send_prepare_header(MultiFDSendParams *p)
+{
+    p->iov[0].iov_len = p->packet_len;
+    p->iov[0].iov_base = p->packet;
+    p->iovs_num++;
+}
+
+
 #endif
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 44163e4e28..cd4467aff4 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -712,10 +712,14 @@ static void *multifd_send_thread(void *opaque)
         if (qatomic_read(&p->pending_job)) {
             MultiFDPages_t *pages = p->pages;
 
-            if (use_zero_copy_send) {
-                p->iovs_num = 0;
-            } else {
-                p->iovs_num = 1;
+            p->iovs_num = 0;
+
+            if (!use_zero_copy_send) {
+                /*
+                 * Only !zerocopy needs the header in IOV; zerocopy will
+                 * send it separately.
+                 */
+                multifd_send_prepare_header(p);
             }
 
             assert(pages->num);
@@ -735,10 +739,6 @@ static void *multifd_send_thread(void *opaque)
                 if (ret != 0) {
                     break;
                 }
-            } else {
-                /* Send header using the same writev call */
-                p->iov[0].iov_len = p->packet_len;
-                p->iov[0].iov_base = p->packet;
             }
 
             ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
-- 
2.43.0


