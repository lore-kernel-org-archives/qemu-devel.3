Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311CAC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 18:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2wxY-0005ZQ-Mc; Thu, 10 Apr 2025 14:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2wxF-0005Y4-3E
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 14:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2wxC-0006lG-1D
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 14:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744310922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05QS0QHdDxiiuQhSNYD6PZLJSNQ2FxI3qlDTmUS6LBg=;
 b=XLGuU3CVHssJaf8bSe23tGzVOcSx4Pw2e/rvX/u7XvOVjEEMYu6xlGY+T0L/Ao8OAbIwcP
 fVQY5j1G7666HsGZzTNtBoD0SKLmj9MGbuIkPrBgJWsroaQzyF9XDNi6/beHmmSY1KXkI3
 LQBXIzwUn4YEW1dVFpyjjEhEiU1tIZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-SsUeSmyHNZuctj4yi70ifw-1; Thu,
 10 Apr 2025 14:48:40 -0400
X-MC-Unique: SsUeSmyHNZuctj4yi70ifw-1
X-Mimecast-MFC-AGG-ID: SsUeSmyHNZuctj4yi70ifw_1744310920
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D11DF18007E1; Thu, 10 Apr 2025 18:48:39 +0000 (UTC)
Received: from localhost (unknown [10.2.17.97])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E87E03001D0E; Thu, 10 Apr 2025 18:48:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 <qemu-block@nongnu.org>
Subject: [PATCH v2 1/2] file-posix: probe discard alignment on Linux block
 devices
Date: Thu, 10 Apr 2025 14:41:02 -0400
Message-ID: <20250410184103.23385-2-stefanha@redhat.com>
In-Reply-To: <20250410184103.23385-1-stefanha@redhat.com>
References: <20250410184103.23385-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Populate the pdiscard_alignment block limit so the block layer is able
align discard requests correctly.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..2a1e1f48c0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1276,10 +1276,10 @@ static int get_sysfs_zoned_model(struct stat *st, BlockZoneModel *zoned)
 }
 #endif /* defined(CONFIG_BLKZONED) */
 
+#ifdef CONFIG_LINUX
 /*
  * Get a sysfs attribute value as a long integer.
  */
-#ifdef CONFIG_LINUX
 static long get_sysfs_long_val(struct stat *st, const char *attribute)
 {
     g_autofree char *str = NULL;
@@ -1299,6 +1299,30 @@ static long get_sysfs_long_val(struct stat *st, const char *attribute)
     }
     return ret;
 }
+
+/*
+ * Get a sysfs attribute value as a uint32_t.
+ */
+static int get_sysfs_u32_val(struct stat *st, const char *attribute,
+                             uint32_t *u32)
+{
+    g_autofree char *str = NULL;
+    const char *end;
+    unsigned int val;
+    int ret;
+
+    ret = get_sysfs_str_val(st, attribute, &str);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* The file is ended with '\n', pass 'end' to accept that. */
+    ret = qemu_strtoui(str, &end, 10, &val);
+    if (ret == 0 && end && *end == '\0') {
+        *u32 = val;
+    }
+    return ret;
+}
 #endif
 
 static int hdev_get_max_segments(int fd, struct stat *st)
@@ -1318,6 +1342,23 @@ static int hdev_get_max_segments(int fd, struct stat *st)
 #endif
 }
 
+/*
+ * Fills in *dalign with the discard alignment and returns 0 on success,
+ * -errno otherwise.
+ */
+static int hdev_get_pdiscard_alignment(struct stat *st, uint32_t *dalign)
+{
+#ifdef CONFIG_LINUX
+    /*
+     * Note that Linux "discard_granularity" is QEMU "discard_alignment". Linux
+     * "discard_alignment" is something else.
+     */
+    return get_sysfs_u32_val(st, "discard_granularity", dalign);
+#else
+    return -ENOTSUP;
+#endif
+}
+
 #if defined(CONFIG_BLKZONED)
 /*
  * If the reset_all flag is true, then the wps of zone whose state is
@@ -1527,6 +1568,19 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
         }
     }
 
+    if (S_ISBLK(st.st_mode)) {
+        uint32_t dalign = 0;
+        int ret;
+
+        ret = hdev_get_pdiscard_alignment(&st, &dalign);
+        if (ret == 0) {
+            /* Must be a multiple of request_alignment */
+            assert(dalign % bs->bl.request_alignment == 0);
+
+            bs->bl.pdiscard_alignment = dalign;
+        }
+    }
+
     raw_refresh_zoned_limits(bs, &st, errp);
 }
 
-- 
2.49.0


