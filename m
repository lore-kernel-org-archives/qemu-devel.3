Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B2ECD5BA6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJvj-000652-6F; Tue, 19 May 2026 08:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJvg-000634-Jo
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJvd-00006P-Hy
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779195128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6ycJyS58u8wV36TEg6I3IuF42L1x613e3hNw/t4uT4=;
 b=SbSsuqyPhemrysFKuycS6HOZx4Qd8jAdXlxtYGZMa2cZwjKQl7476MhtbKV98joIzU1Xvd
 6GZwUei6OCEXcPxdPNlwD/AwsM9iUwwgf0/m4oSI54839lodWq6RZf7VcdZzSwKQTe1dMs
 pVI1ZXq8OpyacfNAsQvETfs76S213PA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-eJeTi2rNMJeYEH5-rI6e-A-1; Tue,
 19 May 2026 08:52:06 -0400
X-MC-Unique: eJeTi2rNMJeYEH5-rI6e-A-1
X-Mimecast-MFC-AGG-ID: eJeTi2rNMJeYEH5-rI6e-A_1779195125
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF70B19560AA; Tue, 19 May 2026 12:52:03 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 562FB1800347; Tue, 19 May 2026 12:51:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, Tejus GK <tejus.gk@nutanix.com>
Subject: [PULL 01/28] io: invert the return semantics of qio_channel_flush
Date: Tue, 19 May 2026 13:51:25 +0100
Message-ID: <20260519125153.1015315-2-berrange@redhat.com>
In-Reply-To: <20260519125153.1015315-1-berrange@redhat.com>
References: <20260519125153.1015315-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

From: Tejus GK <tejus.gk@nutanix.com>

With the kernel's zerocopy notification mechanism, the caller can
determine whether
 * All syscalls successfully used zero copy
 * At least one syscall failed to use zero copy

But, as of now QEMU's IO channel flush function semantics are like
 * 1 => all syscalls failed to use zero copy
 * 0 => at least one syscall successfully used zero copy

This is not aligned with what the kernel reports, and ends up reporting
false negatives for cases like when there's just a single successful
zerocopy amongst a collection of deferred zero-copies during a flush.

Fix this by inverting the return semantics of the IO flush function.

Suggested-by: Peter Xu <peterx@redhat.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel-socket.h |  6 +-----
 include/io/channel.h        |  4 ++--
 io/channel-socket.c         | 16 ++++++++--------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index a1ef3136ea..b07cd61477 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -50,11 +50,7 @@ struct QIOChannelSocket {
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
     bool blocking;
-    /**
-     * This flag indicates whether any new data was successfully sent with
-     * zerocopy since the last qio_channel_socket_flush() call.
-     */
-    bool new_zero_copy_sent_success;
+    bool zero_copy_fallback;
 };
 
 
diff --git a/include/io/channel.h b/include/io/channel.h
index 287d10cd6f..98485c9280 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -1147,8 +1147,8 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
  * If not implemented, acts as a no-op, and returns 0.
  *
  * Returns -1 if any error is found,
- *          1 if every send failed to use zero copy.
- *          0 otherwise.
+ *          1 if at least one send failed to use zero copy.
+ *          0 if every send successfully used zero copy.
  */
 
 int qio_channel_flush(QIOChannel *ioc,
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3053b35ad8..ea2ec84108 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -72,7 +72,7 @@ qio_channel_socket_new(void)
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
     sioc->blocking = false;
-    sioc->new_zero_copy_sent_success = false;
+    sioc->zero_copy_fallback = false;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -880,9 +880,9 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
 
-        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
-        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            sioc->new_zero_copy_sent_success = true;
+        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
+            /* If any sendmsg() fell back to a copy, mark fallback as true */
+            sioc->zero_copy_fallback = true;
         }
     }
 
@@ -900,12 +900,12 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         return ret;
     }
 
-    if (sioc->new_zero_copy_sent_success) {
-        sioc->new_zero_copy_sent_success = false;
-        return 0;
+    if (sioc->zero_copy_fallback) {
+        sioc->zero_copy_fallback = false;
+        return 1;
     }
 
-    return 1;
+    return 0;
 }
 
 #endif /* QEMU_MSG_ZEROCOPY */
-- 
2.54.0


