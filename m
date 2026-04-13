Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CAFF34C4E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHcS-00052V-TW; Mon, 13 Apr 2026 09:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCHcO-00050D-D0
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:46:26 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCHcM-0002Fp-9e
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776087982; x=1807623982;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=folrTF5beoC9lFULQ16CJB+/2zzJLPZS9SYdJ6UdO6M=;
 b=lIcmUOZXkcZjJ66AXInKSDtd03RcubRXn3UrEk3i9BVZWLZPI9JvF+jK
 1rMOmtSIPdm28ao4bBdgOQJMMrbu7JKZG0gPDG3Kys70BLHcw2ZP53R4i
 jBbOg9EL3ps71EL7x/XqmzMSxJsBXtjqUh6L6bDIcdUmCtXOaP+AJXQtu
 /NxV7VUIl4xPyBVmddjVCTYQszWjg8wuC6EMt1QeOImsc4LrZsXQSww09
 T6ct9b1jtphqAVce8WwRS4nfl0joVqQVRvnHNgVDA/EmNqcVxX0D6tTtZ
 V2mONT86sn4LXsV3+OdJEWvzro/bfiA3C0L8A4SjbK/gy+A0bxoIJBf5B A==;
X-CSE-ConnectionGUID: 1dtrLPWRRWqWSM3XDMuOZQ==
X-CSE-MsgGUID: DgEqc80fThWhN714Xoapmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80885643"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="80885643"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 06:46:21 -0700
X-CSE-ConnectionGUID: Fy0io/UwR3KsF7LqnGC31A==
X-CSE-MsgGUID: JUj+E3HsQ4qFcRY37r6ppg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="234770409"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 06:46:20 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 junjie.cao@intel.com
Subject: [PATCH v3 2/4] io/channel: introduce qio_channel_pwrite{v,}_all()
Date: Tue, 14 Apr 2026 05:45:47 +0800
Message-ID: <20260413214549.926435-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413214549.926435-1-junjie.cao@intel.com>
References: <20260413214549.926435-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.54, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add positioned write helpers that retry on short writes, matching
the pread_all family from the previous patch.

  qio_channel_pwritev_all()  -- retry loop; returns 0 on success,
                                 -1 on error.
  qio_channel_pwrite_all()   -- single-buffer convenience wrapper.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 include/io/channel.h | 41 +++++++++++++++++++++++++++++++++++++
 io/channel.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 47af409ede..287d10cd6f 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -598,6 +598,47 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
 ssize_t qio_channel_pwrite(QIOChannel *ioc, void *buf, size_t buflen,
                            off_t offset, Error **errp);
 
+/**
+ * qio_channel_pwritev_all:
+ * @ioc: the channel object
+ * @iov: the array of memory regions to write data from
+ * @niov: the length of the @iov array
+ * @offset: the starting offset in the channel to write to
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Writes @iov, possibly blocking or (if the channel is non-blocking)
+ * yielding from the current coroutine multiple times until the entire
+ * content is written.  Otherwise behaves as qio_channel_pwritev().
+ *
+ * Returns: 0 if all bytes were written, or -1 on error
+ */
+int coroutine_mixed_fn qio_channel_pwritev_all(QIOChannel *ioc,
+                                               const struct iovec *iov,
+                                               size_t niov,
+                                               off_t offset,
+                                               Error **errp);
+
+/**
+ * qio_channel_pwrite_all:
+ * @ioc: the channel object
+ * @buf: the memory region to write data from
+ * @buflen: the number of bytes to write from @buf
+ * @offset: the starting offset in the channel to write to
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Writes @buflen bytes from @buf, possibly blocking or (if the
+ * channel is non-blocking) yielding from the current coroutine
+ * multiple times until the entire content is written.  Otherwise
+ * behaves as qio_channel_pwrite().
+ *
+ * Returns: 0 if all bytes were written, or -1 on error
+ */
+int coroutine_mixed_fn qio_channel_pwrite_all(QIOChannel *ioc,
+                                              const void *buf,
+                                              size_t buflen,
+                                              off_t offset,
+                                              Error **errp);
+
 /**
  * qio_channel_preadv
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index 52c1abfcbc..2853dadb68 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -478,6 +478,54 @@ ssize_t qio_channel_pwrite(QIOChannel *ioc, void *buf, size_t buflen,
     return qio_channel_pwritev(ioc, &iov, 1, offset, errp);
 }
 
+int coroutine_mixed_fn qio_channel_pwritev_all(QIOChannel *ioc,
+                                               const struct iovec *iov,
+                                               size_t niov,
+                                               off_t offset,
+                                               Error **errp)
+{
+    int ret = -1;
+    struct iovec *local_iov = g_new(struct iovec, niov);
+    struct iovec *local_iov_head = local_iov;
+    unsigned int nlocal_iov = niov;
+
+    nlocal_iov = iov_copy(local_iov, nlocal_iov,
+                          iov, niov,
+                          0, iov_size(iov, niov));
+
+    while (nlocal_iov > 0) {
+        ssize_t len;
+
+        len = qio_channel_pwritev(ioc, local_iov, nlocal_iov, offset, errp);
+
+        if (len == QIO_CHANNEL_ERR_BLOCK) {
+            qio_channel_wait_cond(ioc, G_IO_OUT);
+            continue;
+        }
+        if (len < 0) {
+            goto cleanup;
+        }
+
+        offset += len;
+        iov_discard_front(&local_iov, &nlocal_iov, len);
+    }
+
+    ret = 0;
+ cleanup:
+    g_free(local_iov_head);
+    return ret;
+}
+
+int coroutine_mixed_fn qio_channel_pwrite_all(QIOChannel *ioc,
+                                              const void *buf,
+                                              size_t buflen,
+                                              off_t offset,
+                                              Error **errp)
+{
+    struct iovec iov = { .iov_base = (char *)buf, .iov_len = buflen };
+    return qio_channel_pwritev_all(ioc, &iov, 1, offset, errp);
+}
+
 ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
                            size_t niov, off_t offset, Error **errp)
 {
-- 
2.43.0


