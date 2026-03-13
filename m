Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584C2107BCD9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 20:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w18xv-0006r2-4Q; Fri, 13 Mar 2026 16:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.ferst@eldorado.org.br>)
 id 1w18mD-0003Tn-VI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 16:06:30 -0400
Received: from [200.168.210.66] (helo=outlook.eldorado.org.br)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <matheus.ferst@eldorado.org.br>) id 1w18mB-000405-Rd
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 16:06:29 -0400
Received: from p9ibm ([10.10.71.235]) by outlook.eldorado.org.br with
 Microsoft SMTPSVC(10.0.20348.1); Fri, 13 Mar 2026 16:49:13 -0300
Received: from eldorado.org.br (unknown [10.10.70.45])
 by p9ibm (Postfix) with ESMTP id D6FB48007CD;
 Fri, 13 Mar 2026 16:49:12 -0300 (-03)
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	sw@weilnetz.de,
	matheus.ferst@eldorado.org.br
Subject: [RFC PATCH] net/tap-win32.c: fix segmentation faults when multiple
 -netdev tap are used
Date: Fri, 13 Mar 2026 16:48:49 -0300
Message-ID: <20260313194849.859579-1-matheus.ferst@eldorado.org.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Mar 2026 19:49:13.0295 (UTC)
 FILETIME=[77B605F0:01DCB322]
X-Host-Lookup-Failed: Reverse DNS lookup failed for 200.168.210.66 (failed)
Received-SPF: pass client-ip=200.168.210.66;
 envelope-from=matheus.ferst@eldorado.org.br; helo=outlook.eldorado.org.br
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:18:29 -0400
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
Reply-to:  Matheus Ferst <matheus.ferst@eldorado.org.br>
From:  Matheus Ferst via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The static declaration of tap_overlapped does not work when multiple
"-netdev tap" are used, tap_win32_overlapped_init will be called with
the same struct but a different handler, and the already running thread
with tap_win32_thread_entry will have the semaphores and free lists
changed under its feet.

Make tap_win32_overlapped_t a member of TAPState to be allocated with
qemu_new_net_client, and move out the tap_win32_overlapped_init and
CreateThread calls from tap_win32_open to tap_win32_init.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3314
Signed-off-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
---
I'm no longer seeing the segfaults with this patch, but I only have
connectivity when using the e1000 or virtio-net-pci devices. With
virtio-net-device (as shown in the issue with aarch64) I cannot ping
anything when two interfaces are used. I'm not sure if it's a problem
with this patch or a different problem, since it works with the other
devices.
---
 net/tap-win32.c | 47 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 38baf90e0b..af20c62868 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -114,8 +114,6 @@ typedef struct tap_win32_overlapped {
     tun_buffer_t* output_queue_back;
 } tap_win32_overlapped_t;
 
-static tap_win32_overlapped_t tap_overlapped;
-
 static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t* const overlapped)
 {
     tun_buffer_t* buffer = NULL;
@@ -589,8 +587,7 @@ static void tap_win32_free_buffer(tap_win32_overlapped_t *overlapped,
     put_buffer_on_free_list(overlapped, buffer);
 }
 
-static int tap_win32_open(tap_win32_overlapped_t **phandle,
-                          const char *preferred_name)
+static HANDLE tap_win32_open(const char *preferred_name)
 {
     g_autofree char *device_path = NULL;
     char device_guid[0x100];
@@ -604,7 +601,6 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         unsigned long debug;
     } version;
     DWORD version_len;
-    DWORD idThread;
 
     if (preferred_name != NULL) {
         snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name);
@@ -612,7 +608,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
 
     rc = get_device_guid(device_guid, sizeof(device_guid), name_buffer, sizeof(name_buffer));
     if (rc)
-        return -1;
+        return INVALID_HANDLE_VALUE;
 
     device_path = g_strdup_printf("%s%s%s",
               USERMODEDEVICEDIR,
@@ -629,7 +625,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         0 );
 
     if (handle == INVALID_HANDLE_VALUE) {
-        return -1;
+        return INVALID_HANDLE_VALUE;
     }
 
     bret = DeviceIoControl(handle, TAP_IOCTL_GET_VERSION,
@@ -638,34 +634,28 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
 
     if (bret == FALSE) {
         CloseHandle(handle);
-        return -1;
+        return INVALID_HANDLE_VALUE;
     }
 
     if (!tap_win32_set_status(handle, TRUE)) {
-        return -1;
+        return INVALID_HANDLE_VALUE;
     }
 
-    tap_win32_overlapped_init(&tap_overlapped, handle);
-
-    *phandle = &tap_overlapped;
-
-    CreateThread(NULL, 0, tap_win32_thread_entry,
-                 (LPVOID)&tap_overlapped, 0, &idThread);
-    return 0;
+    return handle;
 }
 
 /********************************************/
 
  typedef struct TAPState {
      NetClientState nc;
-     tap_win32_overlapped_t *handle;
+     tap_win32_overlapped_t tap_overlapped;
  } TAPState;
 
 static void tap_cleanup(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
-    qemu_del_wait_object(s->handle->tap_semaphore, NULL, NULL);
+    qemu_del_wait_object(s->tap_overlapped.tap_semaphore, NULL, NULL);
 
     /* FIXME: need to kill thread and close file handle:
        tap_win32_close(s);
@@ -676,7 +666,7 @@ static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
-    return tap_win32_write(s->handle, buf, size);
+    return tap_win32_write(&s->tap_overlapped, buf, size);
 }
 
 static void tap_win32_send(void *opaque)
@@ -688,7 +678,7 @@ static void tap_win32_send(void *opaque)
     uint8_t min_pkt[ETH_ZLEN];
     size_t min_pktsz = sizeof(min_pkt);
 
-    size = tap_win32_read(s->handle, &buf, max_size);
+    size = tap_win32_read(&s->tap_overlapped, &buf, max_size);
     if (size > 0) {
         orig_buf = buf;
 
@@ -700,7 +690,7 @@ static void tap_win32_send(void *opaque)
         }
 
         qemu_send_packet(&s->nc, buf, size);
-        tap_win32_free_buffer(s->handle, orig_buf);
+        tap_win32_free_buffer(&s->tap_overlapped, orig_buf);
     }
 }
 
@@ -716,9 +706,11 @@ static int tap_win32_init(NetClientState *peer, const char *model,
 {
     NetClientState *nc;
     TAPState *s;
-    tap_win32_overlapped_t *handle;
+    HANDLE handle;
+    DWORD idThread;
 
-    if (tap_win32_open(&handle, ifname) < 0) {
+    handle = tap_win32_open(ifname);
+    if (handle == INVALID_HANDLE_VALUE) {
         printf("tap: Could not open '%s'\n", ifname);
         return -1;
     }
@@ -727,11 +719,14 @@ static int tap_win32_init(NetClientState *peer, const char *model,
 
     s = DO_UPCAST(TAPState, nc, nc);
 
+    tap_win32_overlapped_init(&s->tap_overlapped, handle);
+
+    CreateThread(NULL, 0, tap_win32_thread_entry,
+                 (LPVOID)&s->tap_overlapped, 0, &idThread);
+
     qemu_set_info_str(&s->nc, "tap: ifname=%s", ifname);
 
-    s->handle = handle;
-
-    qemu_add_wait_object(s->handle->tap_semaphore, tap_win32_send, s);
+    qemu_add_wait_object(s->tap_overlapped.tap_semaphore, tap_win32_send, s);
 
     return 0;
 }
-- 
2.43.0


