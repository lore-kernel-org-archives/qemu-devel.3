Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02933C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 17:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8NEe-0000xe-Jl; Fri, 25 Apr 2025 13:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8NEZ-0000rZ-E1
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8NEW-0007Oj-Mj
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745603581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4ozch4TBcSxWT6mWofezs7YGXKJYIStqh6TzLVyI/o=;
 b=XuMOJmfH0oKTfwQq/4DHp038MLfp1x7X/DjkEvrfr6fSkG1gpIylATfFRq+Jq56SqUsXP9
 +CgvnTze8bGWg2+qghATP79+eaVlFqNvkHeBf3T5X5oEh/9hL7PEG7y0zyJnB5YFPsF1We
 dOdkRmUsC3anaQ52rD84tjiYFDiXKw0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-CCeOqygkNt6DqOdAujA_oQ-1; Fri,
 25 Apr 2025 13:52:59 -0400
X-MC-Unique: CCeOqygkNt6DqOdAujA_oQ-1
X-Mimecast-MFC-AGG-ID: CCeOqygkNt6DqOdAujA_oQ_1745603578
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DA5D195609F; Fri, 25 Apr 2025 17:52:58 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.183])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08B061800378; Fri, 25 Apr 2025 17:52:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 1/4] file-posix: probe discard alignment on Linux block devices
Date: Fri, 25 Apr 2025 19:52:49 +0200
Message-ID: <20250425175252.316807-2-kwolf@redhat.com>
In-Reply-To: <20250425175252.316807-1-kwolf@redhat.com>
References: <20250425175252.316807-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Populate the pdiscard_alignment block limit so the block layer is able
align discard requests correctly.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250417150528.76470-2-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 67 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..0d6e12f880 100644
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
@@ -1527,6 +1568,30 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
         }
     }
 
+    if (S_ISBLK(st.st_mode)) {
+        uint32_t dalign = 0;
+        int ret;
+
+        ret = hdev_get_pdiscard_alignment(&st, &dalign);
+        if (ret == 0) {
+            uint32_t ralign = bs->bl.request_alignment;
+
+            /* Probably never happens, but handle it just in case */
+            if (dalign < ralign && (ralign % dalign == 0)) {
+                dalign = ralign;
+            }
+
+            /* The block layer requires a multiple of request_alignment */
+            if (dalign % ralign != 0) {
+                error_setg(errp, "Invalid pdiscard_alignment limit %u is not a "
+                        "multiple of request_alignment %u", dalign, ralign);
+                return;
+            }
+
+            bs->bl.pdiscard_alignment = dalign;
+        }
+    }
+
     raw_refresh_zoned_limits(bs, &st, errp);
 }
 
-- 
2.49.0


