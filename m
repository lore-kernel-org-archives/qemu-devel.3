Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58355D7831F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Zh-0004L1-JR; Mon, 02 Dec 2024 08:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Li-0007yB-UQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lc-0005g6-DF
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:23 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DAgQp023933;
 Mon, 2 Dec 2024 13:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=IiV/SS9De5zI5JVcAHpFXS2iXMkHLB4glwh8SI5UR9o=; b=
 Pft8Cc/J3kvPM5AlkRGQBxc7HAXBBhsm/lf+JfrprmclX58bU7eak/ZoDXO5jfLD
 Yy5sIkxriEReK79gU9LA7Y2AYxb1olYIfAK5WE0AM0JaOmgl6QwKuwKfnvmWlDSj
 Ie+PgOerKgvoXT1hdv+d90UcqVAqkHUCizzW7rTNBjOMLRs6h9lC5AZaXo58cavg
 8ZoZsChLVJbOWNBOWowa8XSsjqww3KYxGxGgChernzLZBz2Rsl9+fgOrkQIQrZYK
 VNW4Wa8jhd6xlkQFGcxfjxEO7tKxzmoJCs4BXGk7ng3NO8U+06jWXM21Sfyw7fgT
 Aj3lGErt9D/Fn/UA/w21Tg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbk4ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2C0hvX032882; Mon, 2 Dec 2024 13:20:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCEZ032806;
 Mon, 2 Dec 2024 13:20:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-2; Mon, 02 Dec 2024 13:20:13 +0000
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
Subject: [PATCH V4 01/19] backends/hostmem-shm: factor out allocation of
 "anonymous shared memory with an fd"
Date: Mon,  2 Dec 2024 05:19:53 -0800
Message-Id: <1733145611-62315-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: 6wrt4RFUnpY-Ih81k-utkKCxJChNKThk
X-Proofpoint-ORIG-GUID: 6wrt4RFUnpY-Ih81k-utkKCxJChNKThk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Let's factor it out so we can reuse it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 backends/hostmem-shm.c | 45 ++++-----------------------------------
 include/qemu/osdep.h   |  2 ++
 meson.build            |  8 +++++--
 util/oslib-posix.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 util/oslib-win32.c     | 11 ++++++++++
 5 files changed, 81 insertions(+), 43 deletions(-)

diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 374edc3..837b9f1 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -25,11 +25,9 @@ struct HostMemoryBackendShm {
 static bool
 shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
-    g_autoptr(GString) shm_name = g_string_new(NULL);
     g_autofree char *backend_name = NULL;
     uint32_t ram_flags;
-    int fd, oflag;
-    mode_t mode;
+    int fd;
 
     if (!backend->size) {
         error_setg(errp, "can't create shm backend with size 0");
@@ -41,48 +39,13 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return false;
     }
 
-    /*
-     * Let's use `mode = 0` because we don't want other processes to open our
-     * memory unless we share the file descriptor with them.
-     */
-    mode = 0;
-    oflag = O_RDWR | O_CREAT | O_EXCL;
-    backend_name = host_memory_backend_get_name(backend);
-
-    /*
-     * Some operating systems allow creating anonymous POSIX shared memory
-     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
-     * defined by POSIX, so let's create a unique name.
-     *
-     * From Linux's shm_open(3) man-page:
-     *   For  portable  use,  a shared  memory  object should be identified
-     *   by a name of the form /somename;"
-     */
-    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%s", getpid(),
-                    backend_name);
-
-    fd = shm_open(shm_name->str, oflag, mode);
+    fd = qemu_shm_alloc(backend->size, errp);
     if (fd < 0) {
-        error_setg_errno(errp, errno,
-                         "failed to create POSIX shared memory");
-        return false;
-    }
-
-    /*
-     * We have the file descriptor, so we no longer need to expose the
-     * POSIX shared memory object. However it will remain allocated as long as
-     * there are file descriptors pointing to it.
-     */
-    shm_unlink(shm_name->str);
-
-    if (ftruncate(fd, backend->size) == -1) {
-        error_setg_errno(errp, errno,
-                         "failed to resize POSIX shared memory to %" PRIu64,
-                         backend->size);
-        close(fd);
         return false;
     }
 
+    /* Let's do the same as memory-backend-ram,share=on would do. */
+    backend_name = host_memory_backend_get_name(backend);
     ram_flags = RAM_SHARED;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
 
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index fdff07f..e2a0e15 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -509,6 +509,8 @@ int qemu_daemon(int nochdir, int noclose);
 void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared,
                           bool noreserve);
 void qemu_anon_ram_free(void *ptr, size_t size);
+int qemu_shm_alloc(size_t size, Error **errp);
+bool qemu_shm_available(void);
 
 #ifdef _WIN32
 #define HAVE_CHARDEV_SERIAL 1
diff --git a/meson.build b/meson.build
index b09bfb1..4f58783 100644
--- a/meson.build
+++ b/meson.build
@@ -3706,9 +3706,13 @@ libqemuutil = static_library('qemuutil',
                              build_by_default: false,
                              sources: util_ss.sources() + stub_ss.sources() + genh,
                              dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc])
+qemuutil_deps = [event_loop_base]
+if host_os != 'windows'
+  qemuutil_deps += [rt]
+endif
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res,
-                              dependencies: [event_loop_base])
+                              dependencies: qemuutil_deps)
 
 if have_system or have_user
   decodetree = generator(find_program('scripts/decodetree.py'),
@@ -4361,7 +4365,7 @@ if have_tools
   subdir('contrib/elf2dmp')
 
   executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
-             dependencies: qemuutil,
+             dependencies: [qemuutil, rt],
              install: true)
 
   if have_vhost_user
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 11b35e4..f8c3724 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -931,3 +931,61 @@ void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
         qemu_close_all_open_fd_fallback(skip, nskip, open_max);
     }
 }
+
+bool qemu_shm_available(void)
+{
+    return true;
+}
+
+int qemu_shm_alloc(size_t size, Error **errp)
+{
+    g_autoptr(GString) shm_name = g_string_new(NULL);
+    int fd, oflag, cur_sequence;
+    static int sequence;
+    mode_t mode;
+
+    cur_sequence = qatomic_fetch_inc(&sequence);
+
+    /*
+     * Let's use `mode = 0` because we don't want other processes to open our
+     * memory unless we share the file descriptor with them.
+     */
+    mode = 0;
+    oflag = O_RDWR | O_CREAT | O_EXCL;
+
+    /*
+     * Some operating systems allow creating anonymous POSIX shared memory
+     * objects (e.g. FreeBSD provides the SHM_ANON constant), but this is not
+     * defined by POSIX, so let's create a unique name.
+     *
+     * From Linux's shm_open(3) man-page:
+     *   For  portable  use,  a shared  memory  object should be identified
+     *   by a name of the form /somename;"
+     */
+    g_string_printf(shm_name, "/qemu-" FMT_pid "-shm-%d", getpid(),
+                    cur_sequence);
+
+    fd = shm_open(shm_name->str, oflag, mode);
+    if (fd < 0) {
+        error_setg_errno(errp, errno,
+                         "failed to create POSIX shared memory");
+        return -1;
+    }
+
+    /*
+     * We have the file descriptor, so we no longer need to expose the
+     * POSIX shared memory object. However it will remain allocated as long as
+     * there are file descriptors pointing to it.
+     */
+    shm_unlink(shm_name->str);
+
+    if (ftruncate(fd, size) == -1) {
+        error_setg_errno(errp, errno,
+                         "failed to resize POSIX shared memory to %" PRIu64,
+                         size);
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b623830..aef5779 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -877,3 +877,14 @@ void qemu_win32_map_free(void *ptr, HANDLE h, Error **errp)
     }
     CloseHandle(h);
 }
+
+bool qemu_shm_available(void)
+{
+    return false;
+}
+
+int qemu_shm_alloc(size_t size, Error **errp)
+{
+    error_setg("Shared memory is not supported.");
+    return -1;
+}
-- 
1.8.3.1


