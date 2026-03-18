Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CE6103E17A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2rSu-0002qN-9y; Wed, 18 Mar 2026 10:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w2rSp-0002n5-5E
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:01:36 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w2rSm-0005nK-KM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773842493; x=1805378493;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=482T7NbGblsuvsjZFboPfT+pkuzemfVXyB8k6UhHv7E=;
 b=XzILZ3veEcvw5Ra4jKRlOKObcKL398eO/sICqmVShAvtbtx+Y1KGx3ky
 9qW8pmYKNbOzuNiymiljebNogS19Jv3hVnTqrxnoI2rubLtbOnUp1A9on
 vUwGGrjYyXj2DJOuYtHTK4MIr/YXsxet4JQUaZsDY1PAeNZ0VOFBxdEfx
 zfCcLl/G0se45WtHrx6cu2mBUNIyiqGuyxnZb9H2CjA3ljfsXGzjelyUc
 vMPzD04oTHP0PwaepT9k5LOc7a8wIQK3NmpYyZs/Q8DH3tEU5pG/5Ec+E
 Ggp/5KuYU/QmpCkDKDcXqqemqEeXzOJuEeoxJhQnZovKjvvXFOEQa5BTM Q==;
X-CSE-ConnectionGUID: gG7LUq2/RGKEshgdSEFdXA==
X-CSE-MsgGUID: ZzwBpGNaT660ZAacw9tuoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74925778"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74925778"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 07:01:31 -0700
X-CSE-ConnectionGUID: TYI1HMJWR1aOBe+v7fPZGg==
X-CSE-MsgGUID: xQKW/ACnTSisSBBw40XDtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="218205218"
Received: from junjieca-mobl.ccr.corp.intel.com ([10.124.242.111])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 07:01:29 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 junjie.cao@intel.com
Subject: [PATCH v2 1/3] io/channel: introduce qio_channel_pread{v,
 }_all() and preadv_all_eof()
Date: Wed, 18 Mar 2026 22:01:11 +0800
Message-ID: <20260318140113.434-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20260318140113.434-1-junjie.cao@intel.com>
References: <20260318140113.434-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qio_channel_pread() and qio_channel_preadv() perform a single read
and may return a short result.  Callers that need all bytes currently
have to open-code a retry loop or simply treat a short read as an
error.

Introduce three new helpers following the existing read_all / readv_all
pattern:

  qio_channel_preadv_all_eof()  – retry loop; returns 1 on success,
                                   0 on clean EOF, -1 on error.
  qio_channel_preadv_all()      – wraps _eof; treats early EOF as
                                   error; returns 0 / -1.
  qio_channel_pread_all()       – single-buffer convenience wrapper
                                   around preadv_all().

These advance the file offset internally after each partial read, so
callers only need a single call.  All three are marked
coroutine_mixed_fn, consistent with the existing _all helpers.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 include/io/channel.h | 63 ++++++++++++++++++++++++++++++++
 io/channel.c         | 85 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 1b02350437..d5b14c8c77 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -634,6 +634,69 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
 ssize_t qio_channel_pread(QIOChannel *ioc, void *buf, size_t buflen,
                           off_t offset, Error **errp);
 
+/**
+ * qio_channel_preadv_all_eof:
+ * @ioc: the channel object
+ * @iov: the array of memory regions to read data into
+ * @niov: the length of the @iov array
+ * @offset: the starting offset in the channel to read from
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Reads data contiguously from the channel into @iov starting at
+ * @offset, retrying on short reads until all requested bytes have
+ * been read.  The offset is advanced internally after each partial
+ * read.
+ *
+ * Returns: 1 if all bytes were read, 0 if no data could be read
+ *          before encountering end-of-file, or -1 on error
+ */
+int coroutine_mixed_fn qio_channel_preadv_all_eof(QIOChannel *ioc,
+                                                  const struct iovec *iov,
+                                                  size_t niov,
+                                                  off_t offset,
+                                                  Error **errp);
+
+/**
+ * qio_channel_preadv_all:
+ * @ioc: the channel object
+ * @iov: the array of memory regions to read data into
+ * @niov: the length of the @iov array
+ * @offset: the starting offset in the channel to read from
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Reads data contiguously from the channel into @iov starting at
+ * @offset, retrying on short reads until all requested bytes have
+ * been read.  Unlike qio_channel_preadv_all_eof(), end-of-file
+ * before all data has been read is treated as an error.
+ *
+ * Returns: 0 if all bytes were read, or -1 on error
+ */
+int coroutine_mixed_fn qio_channel_preadv_all(QIOChannel *ioc,
+                                              const struct iovec *iov,
+                                              size_t niov,
+                                              off_t offset,
+                                              Error **errp);
+
+/**
+ * qio_channel_pread_all:
+ * @ioc: the channel object
+ * @buf: the memory region to read data into
+ * @buflen: the number of bytes to read into @buf
+ * @offset: the starting offset in the channel to read from
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Reads @buflen bytes contiguously from the channel at @offset
+ * into @buf, retrying on short reads.  End-of-file before all data
+ * has been read is treated as an error.
+ *
+ * Returns: 0 if all bytes were read, or -1 on error
+ */
+int coroutine_mixed_fn qio_channel_pread_all(QIOChannel *ioc,
+                                             void *buf,
+                                             size_t buflen,
+                                             off_t offset,
+                                             Error **errp);
+
 /**
  * qio_channel_shutdown:
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index cc02d997a4..e18c40aa0b 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -507,6 +507,91 @@ ssize_t qio_channel_pread(QIOChannel *ioc, void *buf, size_t buflen,
     return qio_channel_preadv(ioc, &iov, 1, offset, errp);
 }
 
+int coroutine_mixed_fn qio_channel_preadv_all_eof(QIOChannel *ioc,
+                                                  const struct iovec *iov,
+                                                  size_t niov,
+                                                  off_t offset,
+                                                  Error **errp)
+{
+    int ret = -1;
+    struct iovec *local_iov = g_new(struct iovec, niov);
+    struct iovec *local_iov_head = local_iov;
+    unsigned int nlocal_iov = niov;
+    bool partial = false;
+
+    nlocal_iov = iov_copy(local_iov, nlocal_iov,
+                          iov, niov,
+                          0, iov_size(iov, niov));
+
+    while (nlocal_iov > 0) {
+        ssize_t len;
+        len = qio_channel_preadv(ioc, local_iov, nlocal_iov, offset, errp);
+
+        if (len == QIO_CHANNEL_ERR_BLOCK) {
+            qio_channel_wait_cond(ioc, G_IO_IN);
+            continue;
+        }
+
+        if (len == 0) {
+            if (!partial) {
+                ret = 0;
+                goto cleanup;
+            }
+            error_setg(errp,
+                       "Unexpected end-of-file before all data were read");
+            goto cleanup;
+        }
+
+        if (len < 0) {
+            goto cleanup;
+        }
+
+        partial = true;
+        offset += len;
+        iov_discard_front(&local_iov, &nlocal_iov, len);
+    }
+
+    ret = 1;
+
+ cleanup:
+    g_free(local_iov_head);
+    return ret;
+}
+
+int coroutine_mixed_fn qio_channel_preadv_all(QIOChannel *ioc,
+                                              const struct iovec *iov,
+                                              size_t niov,
+                                              off_t offset,
+                                              Error **errp)
+{
+    int ret = qio_channel_preadv_all_eof(ioc, iov, niov, offset, errp);
+
+    if (ret == 0) {
+        error_setg(errp,
+                   "Unexpected end-of-file before all data were read");
+        return -1;
+    }
+    if (ret == 1) {
+        return 0;
+    }
+
+    return ret;
+}
+
+int coroutine_mixed_fn qio_channel_pread_all(QIOChannel *ioc,
+                                             void *buf,
+                                             size_t buflen,
+                                             off_t offset,
+                                             Error **errp)
+{
+    struct iovec iov = {
+        .iov_base = buf,
+        .iov_len = buflen
+    };
+
+    return qio_channel_preadv_all(ioc, &iov, 1, offset, errp);
+}
+
 int qio_channel_shutdown(QIOChannel *ioc,
                          QIOChannelShutdown how,
                          Error **errp)
-- 
2.43.0


