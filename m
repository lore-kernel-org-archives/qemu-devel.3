Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5450F34C4E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHcE-0004zj-0P; Mon, 13 Apr 2026 09:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCHcD-0004za-12
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:46:13 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCHcB-0002B8-2T
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776087971; x=1807623971;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7MG2x1Tpck0f/s3FRgTmVdtUJNJSEk2UYFSH4EpXP04=;
 b=JEEBKhg1mNrMasBylcYCSk4ua14iXtBF8RSQxvN+XBKh7IQfzGCmYztk
 Bk2jRX4JSEkxb7lhHKls5HahljNvlage3SWHn+0/D8PHzm2QYYv9WGErI
 QJEedV9jeTKI90MpN/nY5hc9Rh4tGfVgqk10I99hkoqyXtc5IvDMZACdX
 f92yZZRUohBR1qoSxvy89PHXXgE0FFInpxSnR7IIzLqsvRkasbsKkk1Ik
 cTgX/tNm0rgwwqzDshV9IXUIzdjwY9lUxBWcHkhmRffNLe603s0pLADxA
 8f/41JVhPLRZY5meqvdM1jblgXKtGO4IpoubcltbDwcvTScfEfJ9QfRZp g==;
X-CSE-ConnectionGUID: cpdLLcBOQuGeWD62R4hJmw==
X-CSE-MsgGUID: hFBq0FW2SUuZaVFc/jp04w==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80885625"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="80885625"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 06:46:11 -0700
X-CSE-ConnectionGUID: x3I1tAg6R8Cc1jAormWLEg==
X-CSE-MsgGUID: QflxPTWTT1mZkJxiG56OOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="234770373"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 06:46:09 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 junjie.cao@intel.com
Subject: [PATCH v3 1/4] io/channel: introduce qio_channel_pread{v, }_all{,
 _eof}()
Date: Tue, 14 Apr 2026 05:45:46 +0800
Message-ID: <20260413214549.926435-2-junjie.cao@intel.com>
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

qio_channel_pread() and qio_channel_preadv() perform a single
positioned read and may return a short result.  Callers that need all
bytes currently have to open-code a retry loop or simply treat a short
read as an error.

Introduce four new helpers following the existing read_all / readv_all
pattern:

  qio_channel_preadv_all_eof()  -- retry loop; returns 1 on success,
                                    0 on clean EOF, -1 on error.
  qio_channel_preadv_all()      -- wraps _eof; treats early EOF as
                                    error; returns 0 / -1.
  qio_channel_pread_all_eof()   -- single-buffer convenience wrapper
                                    around preadv_all_eof().
  qio_channel_pread_all()       -- single-buffer convenience wrapper
                                    around preadv_all().

These advance the file offset internally after each partial read.
All four are marked coroutine_mixed_fn, consistent with the existing
_all helpers.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 include/io/channel.h | 92 ++++++++++++++++++++++++++++++++++++++++++++
 io/channel.c         | 91 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 1b02350437..47af409ede 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -634,6 +634,98 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
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
+ * Reads @iov, possibly blocking or (if the channel is non-blocking)
+ * yielding from the current coroutine multiple times until the entire
+ * content is read.  If end-of-file occurs immediately it is not an
+ * error, but if it occurs after data has been read it will return
+ * an error rather than a short-read.  Otherwise behaves as
+ * qio_channel_preadv().
+ *
+ * Returns: 1 if all bytes were read, 0 if end-of-file occurs
+ *          without data, or -1 on error
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
+ * Reads @iov, possibly blocking or (if the channel is non-blocking)
+ * yielding from the current coroutine multiple times until the entire
+ * content is read.  If end-of-file occurs before all requested data
+ * has been read, an error will be reported.  Otherwise behaves as
+ * qio_channel_preadv().
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
+ * qio_channel_pread_all_eof:
+ * @ioc: the channel object
+ * @buf: the memory region to read data into
+ * @buflen: the number of bytes to read into @buf
+ * @offset: the starting offset in the channel to read from
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Reads @buflen bytes, possibly blocking or (if the channel is
+ * non-blocking) yielding from the current coroutine multiple times
+ * until the entire content is read.  If end-of-file occurs
+ * immediately it is not an error, but if it occurs after data has
+ * been read it will return an error rather than a short-read.
+ * Otherwise behaves as qio_channel_pread().
+ *
+ * Returns: 1 if all bytes were read, 0 if end-of-file occurs
+ *          without data, or -1 on error
+ */
+int coroutine_mixed_fn qio_channel_pread_all_eof(QIOChannel *ioc,
+                                                 void *buf,
+                                                 size_t buflen,
+                                                 off_t offset,
+                                                 Error **errp);
+
+/**
+ * qio_channel_pread_all:
+ * @ioc: the channel object
+ * @buf: the memory region to read data into
+ * @buflen: the number of bytes to read into @buf
+ * @offset: the starting offset in the channel to read from
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Reads @buflen bytes, possibly blocking or (if the channel is
+ * non-blocking) yielding from the current coroutine multiple times
+ * until the entire content is read.  If end-of-file occurs before
+ * all requested data has been read, an error will be reported.
+ * Otherwise behaves as qio_channel_pread().
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
index cc02d997a4..52c1abfcbc 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -507,6 +507,97 @@ ssize_t qio_channel_pread(QIOChannel *ioc, void *buf, size_t buflen,
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
+int coroutine_mixed_fn qio_channel_pread_all_eof(QIOChannel *ioc,
+                                                 void *buf,
+                                                 size_t buflen,
+                                                 off_t offset,
+                                                 Error **errp)
+{
+    struct iovec iov = { .iov_base = buf, .iov_len = buflen };
+    return qio_channel_preadv_all_eof(ioc, &iov, 1, offset, errp);
+}
+
+int coroutine_mixed_fn qio_channel_pread_all(QIOChannel *ioc,
+                                             void *buf,
+                                             size_t buflen,
+                                             off_t offset,
+                                             Error **errp)
+{
+    struct iovec iov = { .iov_base = buf, .iov_len = buflen };
+    return qio_channel_preadv_all(ioc, &iov, 1, offset, errp);
+}
+
 int qio_channel_shutdown(QIOChannel *ioc,
                          QIOChannelShutdown how,
                          Error **errp)
-- 
2.43.0


