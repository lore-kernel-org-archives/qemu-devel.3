Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C31606A924
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XewJyV5M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvW-0006NE-Sy; Mon, 02 Nov 2026 11:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvS-0006Gd-1f
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvP-00024T-G0
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KZMvZJgLHfmqG2/0ual+JaGILY+/w260pI2hBjKAOXc=;
 b=XewJyV5MvuVe/AMbdplnoMpo+5OdwOvt/VjbspOCR4sTQj1z/QGItD0vdrczGVWvXJ6U/g
 o9yZt2psXSj1mEpv8DBvUF1B0lh7OxwmDGHzrzvjTYGdlRC4NNW7wOtzbfQwGXI1VkM6SS
 C9+IcXz2Iark3bihYwyOLfQ1kHh1Sk4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-lBQje-UPM6uKiGFSTxGN8w-1; Mon,
 02 Nov 2026 11:30:13 -0500
X-MC-Unique: lBQje-UPM6uKiGFSTxGN8w-1
X-Mimecast-MFC-AGG-ID: lBQje-UPM6uKiGFSTxGN8w_1793637012
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD8C41801359; Mon,  2 Nov 2026 16:30:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 656C21956087; Mon,  2 Nov 2026 16:30:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 05/17] util/coroutine: Reduce default idle pool max size
Date: Mon,  2 Nov 2026 17:29:43 +0100
Message-ID: <20261102162955.268763-6-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wesley Hershberger <wesley.hershberger@canonical.com>

If g_file_get_contents fails (AppArmor, etc), use a more conservative
default max size for the idle coroutine pool.

This avoids any possibility of the failure described in 86a637e48104
unless the host kernel is configured with a lower-than-default
vm.max_map_count.

This change is motivated by a discussion of backport risk:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2168803/comments/8

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
Message-ID: <20261016-set-default-pool-size-v5-2-719e9e4d3f9c@canonical.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/qemu-coroutine.c | 73 +++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 5af61995437..fc9ed66f475 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -361,42 +361,61 @@ void qemu_coroutine_dec_pool_size(unsigned int removing_pool_size)
     global_pool_max_size -= removing_pool_size;
 }
 
-static unsigned int get_global_pool_hard_max_size(void)
-{
 #ifdef __linux__
-    g_autofree char *contents = NULL;
-    int max_map_count;
+/*
+ * include/linux/mm.h
+ */
+#define DEFAULT_MAX_MAP_COUNT 65530
 
-    /*
-     * Linux processes can have up to max_map_count virtual memory areas
-     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
-     * must limit the coroutine pool to a safe size to avoid running out of
-     * VMAs.
-     */
-    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
-                            NULL)) {
+static unsigned int get_max_map_count(void)
+{
+    g_autofree char *contents = NULL;
+    unsigned int max_map_count = 0;
+    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents,
+                            NULL, NULL)) {
         /* contents has trailing newline, remove it before conversion */
         g_strchomp(contents);
-        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
-            return UINT_MAX;
-        }
-        /*
-         * This is an upper bound that avoids exceeding max_map_count. Leave a
-         * fixed amount for non-coroutine users like library dependencies,
-         * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
-         * remaining amount.
-         */
-        if (max_map_count > 5000) {
-            return (max_map_count - 5000) / 2;
-        } else {
-            /* Disable the global pool but threads still have local pools */
-            return 0;
+        if (qemu_strtoui(contents, NULL, 10, &max_map_count) == 0) {
+            return max_map_count;
         }
     }
-#endif
 
+    /*
+     * Read from /proc might fail due to mandatory access control (AppArmor,
+     * SELinux, etc). Use the kernel's default in that case.
+     */
+    return DEFAULT_MAX_MAP_COUNT;
+}
+
+/*
+ * Linux processes can have up to max_map_count virtual memory areas
+ * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
+ * must limit the coroutine pool to a safe size to avoid running out of
+ * VMAs.
+ */
+static unsigned int get_global_pool_hard_max_size(void)
+{
+    unsigned int max_map_count = get_max_map_count();
+
+    /*
+     * This is an upper bound that avoids exceeding max_map_count. Leave a
+     * fixed amount for non-coroutine users like library dependencies,
+     * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
+     * remaining amount.
+     */
+    if (max_map_count > 5000) {
+        return (max_map_count - 5000) / 2;
+    } else {
+        /* Disable the global pool but threads still have local pools */
+        return 0;
+    }
+}
+#else
+static unsigned int get_global_pool_hard_max_size(void)
+{
     return UINT_MAX;
 }
+#endif
 
 static void __attribute__((constructor)) qemu_coroutine_init(void)
 {
-- 
2.56.0


