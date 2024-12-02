Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123BED78322
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Zv-0005Ps-6h; Mon, 02 Dec 2024 08:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lo-00081l-J9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Li-0005nX-Ni
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:29 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26X3oZ015184;
 Mon, 2 Dec 2024 13:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=rPSayIr1as1CoNo4I53Fie8Y5xVuvIsQZGh4MXjNa5c=; b=
 eIWwuVdqyf2Q5Z1NqcHm7LSjT6NKwBZltyBCkNJMBmrX8aCSZ83/ReeNwUh5TRQO
 RfHSOxqkzHqOty3w0N0VpupLcalGX7qcTrvOiZChydf8s8QXdk5xdQQ9Lv7HdLjb
 ESOnmHOvTC+mbkq3KROTw5OmMED5uTfegFAtel54QhOT2rVLTEGhFlJ/iY0xtyPY
 7Oij1jwtCbtuPSB/PhnAGWYZmhvzA6SeMcA5ZleN9ciMrvToiE26pB/bQq9VbYKj
 1GOmjrhyRLT13cZ0/eMblgpoJ9jyuJhjiveyCOppZkf3duzH1Tc3kcGQvoXX+flp
 Ajt+2hKdLWJxnGUkd+2xQQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smab02u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2CQxAM032065; Mon, 2 Dec 2024 13:20:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCEt032806;
 Mon, 2 Dec 2024 13:20:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-12; Mon, 02 Dec 2024 13:20:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 11/19] migration: SCM_RIGHTS for QEMUFile
Date: Mon,  2 Dec 2024 05:20:03 -0800
Message-Id: <1733145611-62315-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_09,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020116
X-Proofpoint-ORIG-GUID: PIeb2vryjAh79XhXqFEUGuZ3qUdcKQNJ
X-Proofpoint-GUID: PIeb2vryjAh79XhXqFEUGuZ3qUdcKQNJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define functions to put/get file descriptors to/from a QEMUFile, for qio
channels that support SCM_RIGHTS.  Maintain ordering such that
  put(A), put(fd), put(B)
followed by
  get(A), get(fd), get(B)
always succeeds.  Other get orderings may succeed but are not guaranteed.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/qemu-file.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
 migration/qemu-file.h  |  2 ++
 migration/trace-events |  2 ++
 3 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6d2f58..728c7dd 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -37,6 +37,11 @@
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
 
+typedef struct FdEntry {
+    QTAILQ_ENTRY(FdEntry) entry;
+    int fd;
+} FdEntry;
+
 struct QEMUFile {
     QIOChannel *ioc;
     bool is_writable;
@@ -51,6 +56,9 @@ struct QEMUFile {
 
     int last_error;
     Error *last_error_obj;
+
+    bool can_pass_fd;
+    QTAILQ_HEAD(, FdEntry) fds;
 };
 
 /*
@@ -109,6 +117,8 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
     object_ref(ioc);
     f->ioc = ioc;
     f->is_writable = is_writable;
+    f->can_pass_fd = qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS);
+    QTAILQ_INIT(&f->fds);
 
     return f;
 }
@@ -310,6 +320,10 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
     int len;
     int pending;
     Error *local_error = NULL;
+    g_autofree int *fds = NULL;
+    size_t nfd = 0;
+    int **pfds = f->can_pass_fd ? &fds : NULL;
+    size_t *pnfd = f->can_pass_fd ? &nfd : NULL;
 
     assert(!qemu_file_is_writable(f));
 
@@ -325,10 +339,9 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
     }
 
     do {
-        len = qio_channel_read(f->ioc,
-                               (char *)f->buf + pending,
-                               IO_BUF_SIZE - pending,
-                               &local_error);
+        struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
+        len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,
+                                     &local_error);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
             if (qemu_in_coroutine()) {
                 qio_channel_yield(f->ioc, G_IO_IN);
@@ -348,9 +361,65 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
         qemu_file_set_error_obj(f, len, local_error);
     }
 
+    for (int i = 0; i < nfd; i++) {
+        FdEntry *fde = g_new0(FdEntry, 1);
+        fde->fd = fds[i];
+        QTAILQ_INSERT_TAIL(&f->fds, fde, entry);
+    }
+
     return len;
 }
 
+int qemu_file_put_fd(QEMUFile *f, int fd)
+{
+    int ret = 0;
+    QIOChannel *ioc = qemu_file_get_ioc(f);
+    Error *err = NULL;
+    struct iovec iov = { (void *)" ", 1 };
+
+    /*
+     * Send a dummy byte so qemu_fill_buffer on the receiving side does not
+     * fail with a len=0 error.  Flush first to maintain ordering wrt other
+     * data.
+     */
+
+    qemu_fflush(f);
+    if (qio_channel_writev_full(ioc, &iov, 1, &fd, 1, 0, &err) < 1) {
+        error_report_err(error_copy(err));
+        qemu_file_set_error_obj(f, -EIO, err);
+        ret = -1;
+    }
+    trace_qemu_file_put_fd(f->ioc->name, fd, ret);
+    return ret;
+}
+
+int qemu_file_get_fd(QEMUFile *f)
+{
+    int fd = -1;
+    FdEntry *fde;
+
+    if (!f->can_pass_fd) {
+        Error *err = NULL;
+        error_setg(&err, "%s does not support fd passing", f->ioc->name);
+        error_report_err(error_copy(err));
+        qemu_file_set_error_obj(f, -EIO, err);
+        goto out;
+    }
+
+    /* Force the dummy byte and its fd passenger to appear. */
+    qemu_peek_byte(f, 0);
+
+    fde = QTAILQ_FIRST(&f->fds);
+    if (fde) {
+        qemu_get_byte(f);       /* Drop the dummy byte */
+        fd = fde->fd;
+        QTAILQ_REMOVE(&f->fds, fde, entry);
+    }
+out:
+    trace_qemu_file_get_fd(f->ioc->name, fd);
+    return fd;
+}
+
 /** Closes the file
  *
  * Returns negative error value if any error happened on previous operations or
@@ -361,11 +430,17 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
  */
 int qemu_fclose(QEMUFile *f)
 {
+    FdEntry *fde, *next;
     int ret = qemu_fflush(f);
     int ret2 = qio_channel_close(f->ioc, NULL);
     if (ret >= 0) {
         ret = ret2;
     }
+    QTAILQ_FOREACH_SAFE(fde, &f->fds, entry, next) {
+        warn_report("qemu_fclose: received fd %d was never claimed", fde->fd);
+        close(fde->fd);
+        g_free(fde);
+    }
     g_clear_pointer(&f->ioc, object_unref);
     error_free(f->last_error_obj);
     g_free(f);
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 11c2120..3e47a20 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -79,5 +79,7 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                           off_t pos);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
+int qemu_file_put_fd(QEMUFile *f, int fd);
+int qemu_file_get_fd(QEMUFile *f);
 
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index 89c0244..9388f81 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -88,6 +88,8 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
 
 # qemu-file.c
 qemu_file_fclose(void) ""
+qemu_file_put_fd(const char *name, int fd, int ret) "ioc %s, fd %d -> status %d"
+qemu_file_get_fd(const char *name, int fd) "ioc %s -> fd %d"
 
 # ram.c
 get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
-- 
1.8.3.1


