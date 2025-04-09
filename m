Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06609C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 18:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2aB4-0003d1-A8; Wed, 09 Apr 2025 14:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2aB0-0003ZU-BB
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 14:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2aAy-0003DC-1L
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 14:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744223367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05QS0QHdDxiiuQhSNYD6PZLJSNQ2FxI3qlDTmUS6LBg=;
 b=ZqYHxGLbZlWSLRF4+5Dz7gkQL00I/N5vAvcCv5z29rM+Hs/Ka4AsFRkeuUxUv2ehgbT4kk
 w6xNGX2z7AMS2IrjriVn0sTXZIGHwHwkB9Orc3QpeByPe1GWyFQLQc6d/djylBFMSOCtMD
 h4RGPKy35+EyZGK2kOhb/x3WKol8PSI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-5EyBneETOp2No7KPys6uRQ-1; Wed,
 09 Apr 2025 14:29:24 -0400
X-MC-Unique: 5EyBneETOp2No7KPys6uRQ-1
X-Mimecast-MFC-AGG-ID: 5EyBneETOp2No7KPys6uRQ_1744223362
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04A0D1809CA3; Wed,  9 Apr 2025 18:29:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.144])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F100E180B48C; Wed,  9 Apr 2025 18:29:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 1/2] file-posix: probe discard alignment on Linux block devices
Date: Wed,  9 Apr 2025 14:29:13 -0400
Message-ID: <20250409182914.4725-2-stefanha@redhat.com>
In-Reply-To: <20250409182914.4725-1-stefanha@redhat.com>
References: <20250409182914.4725-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


