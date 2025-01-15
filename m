Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECED7C02187
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8dS-0007Ct-PG; Wed, 15 Jan 2025 14:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dR-0007BU-3E
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dO-0005au-CU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:00 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHtlsS001711;
 Wed, 15 Jan 2025 19:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=hZfWM2djMyX4/wMcZOq0sxSJvkZmicYKeBYaUIkJsfY=; b=
 MLURKYgRqGsIV6jCBFKgopyJ55VQuob8axIvXRX8SxE75gnDma9Zl5dp1bkHK0tE
 XqyN8Ry/7Jg83xCKerY3j4DjWopJurazNNyv6rc+9gIvhwsxd3rZfnsc47SGJAXU
 JT1SvoOPpcgX55q7IaksEvS9f7HJhKHRP1aF24JAtJH9VmYGuJ2bONKe32tuDiS1
 5WlBTVT/NIrbVQc+Glv2zQcS7TNf7hJnY/6rUCa+Iy18cMRqFR8duNLE6ZESRg2I
 X8b3BVgzLl99/F0he4tLul4rqL2+b/5r13VfR/CV5o33oviXDON/cLhxAv4VQBDM
 dkoc1VNjIAL/KszHa4CC1Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y8q2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:00:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FIchNL034845; Wed, 15 Jan 2025 19:00:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f39uqxk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:00:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50FJ0pdt016497;
 Wed, 15 Jan 2025 19:00:52 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 443f39uqwr-2; Wed, 15 Jan 2025 19:00:52 +0000
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
Subject: [PATCH V7 01/24] backends/hostmem-shm: factor out allocation of
 "anonymous shared memory with an fd"
Date: Wed, 15 Jan 2025 11:00:27 -0800
Message-Id: <1736967650-129648-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150138
X-Proofpoint-ORIG-GUID: 4XcV-ubCEJqN3dFrwSveZ17nfCgoNjkA
X-Proofpoint-GUID: 4XcV-ubCEJqN3dFrwSveZ17nfCgoNjkA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 backends/hostmem-shm.c | 45 ++++---------------------------------------
 include/qemu/osdep.h   |  1 +
 meson.build            |  8 ++++++--
 util/oslib-posix.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 util/oslib-win32.c     |  6 ++++++
 5 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 5551ba7..fabee41 100644
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
index b94fb5f..112ebdf 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -509,6 +509,7 @@ int qemu_daemon(int nochdir, int noclose);
 void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared,
                           bool noreserve);
 void qemu_anon_ram_free(void *ptr, size_t size);
+int qemu_shm_alloc(size_t size, Error **errp);
 
 #ifdef _WIN32
 #define HAVE_CHARDEV_SERIAL 1
diff --git a/meson.build b/meson.build
index b715ea7..2e709c9 100644
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
@@ -4362,7 +4366,7 @@ if have_tools
   subdir('contrib/elf2dmp')
 
   executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
-             dependencies: qemuutil,
+             dependencies: [qemuutil, rt],
              install: true)
 
   if have_vhost_user
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7a542cb..2bb34da 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -931,3 +931,55 @@ void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
         qemu_close_all_open_fd_fallback(skip, nskip, open_max);
     }
 }
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
+                         "failed to resize POSIX shared memory to %zu", size);
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b623830..b735163 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -877,3 +877,9 @@ void qemu_win32_map_free(void *ptr, HANDLE h, Error **errp)
     }
     CloseHandle(h);
 }
+
+int qemu_shm_alloc(size_t size, Error **errp)
+{
+    error_setg(errp, "Shared memory is not supported.");
+    return -1;
+}
-- 
1.8.3.1


