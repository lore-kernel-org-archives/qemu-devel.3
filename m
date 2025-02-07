Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D10BC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 09:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgL8K-00041c-KJ; Fri, 07 Feb 2025 04:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <9a0dd4b3e4e0b06ec35c5ac370f54a36ea1846ed@kylie.crudebyte.com>)
 id 1tgL8H-0003uW-7X
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:58:45 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <9a0dd4b3e4e0b06ec35c5ac370f54a36ea1846ed@kylie.crudebyte.com>)
 id 1tgL8F-0001KE-CY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=647mmsLP3uA3INY74GivlMfueppYt8qBzVKkJaljaRo=; b=EXx4p
 AWH3yB61T6D5l96cN6mWGyCniam89WVJqri1xl6nG4++0HdVqTHJcXd4mXd5geIirPrveIP/oWhsj
 plGIzyNHZv6BsiK1DlSamaVv23htIbfMx2OzitYTp4z/GTTu/IsJXppni7+5ufiYCo06m/fjuLKFb
 mqenQtYZqxVOMzr5I0wFMg7myvVLmAuYZhL3u3co0qM5UiEdrTh8Y+SM+su/gY/F+XS3SjLmuKOlX
 xAGJiNq2ajB6Dh96uvoVPP6/5fEPCXl/+kaCOUNbwXPB+7b7J7vDKBlm5GbpcSlaCTxCUK1N/W6Sh
 h6sJpT0i3T2Z/IVGrB1Td6D/0nUFazMjJUTq8vkfqQgjHPGpJ93EWn5dSLRj99mGQBKhnSpXSghfu
 9geOWQ8tX+qxTMC3vIsAHMdgbcT6EeDsPwwIrIGzr3eqOMv6DagoLoQgoLQmH39Hcc2uFCxu9oErD
 j5JME/qjnWKv5MAgzGqf7k4asVaVUT/HH6OkcFyl14SF34UXbereVNZBjw/ev4iFJGqA20FoP2cPd
 1iEbVwAHDnO7JRy0bhl5UgeQX9TYucA9LWI2o+3ihZtX/8RPDKhb7IHm9MTIKaZltWPv4Pm6u0F18
 7QEeRnEhVtM7S0UXZPiMEMDyIH1xx9QYe53Closvo7CTDPn8YiN3TA5CGtOcFw=;
Message-Id: <9a0dd4b3e4e0b06ec35c5ac370f54a36ea1846ed.1738921999.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1738921999.git.qemu_oss@crudebyte.com>
References: <cover.1738921999.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 07 Feb 2025 10:53:19 +0100
Subject: [PULL v2 3/4] 9pfs: improve v9fs_open() tracing
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Stefan Hajnoczi <stefanha@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=9a0dd4b3e4e0b06ec35c5ac370f54a36ea1846ed@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Improve tracing of 9p 'Topen' request type by showing open() flags as
human-readable text.

E.g. trace output:

  v9fs_open tag 0 id 12 fid 2 mode 100352

would become:

  v9fs_open tag=0 id=12 fid=2 mode=100352(RDONLY|NONBLOCK|DIRECTORY|
  TMPFILE|NDELAY)

Therefor add a new utility function qemu_open_flags_tostr() that converts
numeric open() flags from host's native O_* flag constants to a string
presentation.

9p2000.L and 9p2000.u protocol variants use different numeric 'mode'
constants for 'Topen' requests. Instead of writing string conversion code
for both protocol variants, use the already existing conversion functions
that convert the mode flags from respective protocol constants to host's
native open() numeric flag constants and pass that result to the new
string conversion function qemu_open_flags_tostr().

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <E1tTgDR-000oRr-9g@kylie.crudebyte.com>
---
 hw/9pfs/9p-util-generic.c | 50 +++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h         |  6 +++++
 hw/9pfs/9p.c              |  9 ++++++-
 hw/9pfs/meson.build       |  1 +
 hw/9pfs/trace-events      |  2 +-
 5 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 hw/9pfs/9p-util-generic.c

diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
new file mode 100644
index 0000000000..4c1e9c887d
--- /dev/null
+++ b/hw/9pfs/9p-util-generic.c
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "9p-util.h"
+#include <glib/gstrfuncs.h>
+
+char *qemu_open_flags_tostr(int flags)
+{
+    int acc = flags & O_ACCMODE;
+    return g_strconcat(
+        (acc == O_WRONLY) ? "WRONLY" : (acc == O_RDONLY) ? "RDONLY" : "RDWR",
+        (flags & O_CREAT) ? "|CREAT" : "",
+        (flags & O_EXCL) ? "|EXCL" : "",
+        (flags & O_NOCTTY) ? "|NOCTTY" : "",
+        (flags & O_TRUNC) ? "|TRUNC" : "",
+        (flags & O_APPEND) ? "|APPEND" : "",
+        (flags & O_NONBLOCK) ? "|NONBLOCK" : "",
+        (flags & O_DSYNC) ? "|DSYNC" : "",
+        #ifdef O_DIRECT
+        (flags & O_DIRECT) ? "|DIRECT" : "",
+        #endif
+        (flags & O_LARGEFILE) ? "|LARGEFILE" : "",
+        (flags & O_DIRECTORY) ? "|DIRECTORY" : "",
+        (flags & O_NOFOLLOW) ? "|NOFOLLOW" : "",
+        #ifdef O_NOATIME
+        (flags & O_NOATIME) ? "|NOATIME" : "",
+        #endif
+        #ifdef O_CLOEXEC
+        (flags & O_CLOEXEC) ? "|CLOEXEC" : "",
+        #endif
+        #ifdef __O_SYNC
+        (flags & __O_SYNC) ? "|SYNC" : "",
+        #else
+        ((flags & O_SYNC) == O_SYNC) ? "|SYNC" : "",
+        #endif
+        #ifdef O_PATH
+        (flags & O_PATH) ? "|PATH" : "",
+        #endif
+        #ifdef __O_TMPFILE
+        (flags & __O_TMPFILE) ? "|TMPFILE" : "",
+        #elif defined(O_TMPFILE)
+        ((flags & O_TMPFILE) == O_TMPFILE) ? "|TMPFILE" : "",
+        #endif
+        /* O_NDELAY is usually just an alias of O_NONBLOCK */
+        #if defined(O_NDELAY) && O_NDELAY != O_NONBLOCK
+        (flags & O_NDELAY) ? "|NDELAY" : "",
+        #endif
+        NULL /* always last (required NULL termination) */
+    );
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 95ee4da9bd..7bc4ec8e85 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -267,4 +267,10 @@ int pthread_fchdir_np(int fd) __attribute__((weak_import));
 #endif
 int qemu_mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev);
 
+/*
+ * Returns a newly allocated string presentation of open() flags, intended
+ * for debugging (tracing) purposes only.
+ */
+char *qemu_open_flags_tostr(int flags);
+
 #endif
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 6f24c1abb3..7cad2bce62 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2008,6 +2008,7 @@ static void coroutine_fn v9fs_open(void *opaque)
     V9fsFidState *fidp;
     V9fsPDU *pdu = opaque;
     V9fsState *s = pdu->s;
+    g_autofree char *trace_oflags = NULL;
 
     if (s->proto_version == V9FS_PROTO_2000L) {
         err = pdu_unmarshal(pdu, offset, "dd", &fid, &mode);
@@ -2019,7 +2020,13 @@ static void coroutine_fn v9fs_open(void *opaque)
     if (err < 0) {
         goto out_nofid;
     }
-    trace_v9fs_open(pdu->tag, pdu->id, fid, mode);
+    if (trace_event_get_state_backends(TRACE_V9FS_OPEN)) {
+        trace_oflags = qemu_open_flags_tostr(
+            (s->proto_version == V9FS_PROTO_2000L) ?
+                dotl_to_open_flags(mode) : omode_to_uflags(mode)
+        );
+        trace_v9fs_open(pdu->tag, pdu->id, fid, mode, trace_oflags);
+    }
 
     fidp = get_fid(pdu, fid);
     if (fidp == NULL) {
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index eceffdb81e..d35d4f44ff 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -3,6 +3,7 @@ fs_ss.add(files(
   '9p-local.c',
   '9p-posix-acl.c',
   '9p-synth.c',
+  '9p-util-generic.c',
   '9p-xattr-user.c',
   '9p-xattr.c',
   '9p.c',
diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
index ed9f4e7209..0e0fc37261 100644
--- a/hw/9pfs/trace-events
+++ b/hw/9pfs/trace-events
@@ -13,7 +13,7 @@ v9fs_getattr(uint16_t tag, uint8_t id, int32_t fid, uint64_t request_mask) "tag
 v9fs_getattr_return(uint16_t tag, uint8_t id, uint64_t result_mask, uint32_t mode, uint32_t uid, uint32_t gid) "tag %d id %d getattr={result_mask %"PRId64" mode %u uid %u gid %u}"
 v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t nwnames, const char* wnames) "tag=%d id=%d fid=%d newfid=%d nwnames=%d wnames={%s}"
 v9fs_walk_return(uint16_t tag, uint8_t id, uint16_t nwnames, void* qids) "tag %d id %d nwnames %d qids %p"
-v9fs_open(uint16_t tag, uint8_t id, int32_t fid, int32_t mode) "tag %d id %d fid %d mode %d"
+v9fs_open(uint16_t tag, uint8_t id, int32_t fid, int32_t mode, const char* oflags) "tag=%d id=%d fid=%d mode=%d(%s)"
 v9fs_open_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int iounit) "tag %u id %u qid={type %u version %u path %"PRIu64"} iounit %d"
 v9fs_lcreate(uint16_t tag, uint8_t id, int32_t dfid, int32_t flags, int32_t mode, uint32_t gid) "tag %d id %d dfid %d flags %d mode %d gid %u"
 v9fs_lcreate_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int32_t iounit) "tag %u id %u qid={type %u version %u path %"PRIu64"} iounit %d"
-- 
2.30.2


