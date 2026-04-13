Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D9EF34C63
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKZy-0004K5-Pd; Mon, 13 Apr 2026 12:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKZx-0004Jn-7z
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:56:05 -0400
Received: from qs-2004g-snip4-11.eps.apple.com ([57.103.84.73]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKZv-0006NU-F4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:56:05 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 A16941800547; Mon, 13 Apr 2026 16:55:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776099362; x=1778691362;
 bh=9f07FQNjyD0hoJ0U5EAu159dHGKdBEB3GRYAO9xnLMs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=duFfb/2rmCto425LJTPfTltwSWFddTZTI68/Otkk7QZOH+iAqtVtArQ7ASYE4CgmHvK2WJZZUbTfE4S8pwg1ThhbcpEhp/mpb3lYW+de8U8b6lvdNbH4I6bQP/CbRgwUktQp3eRLcYcclzhwqfscc4vvFFxVdK0sA5yog0Sq2Sp9XdbVaap0a4hsXRpS49DM+2qWQSCH/y9yAPpUFgS49wSdm1hjyfI1usWcYb8wBt6KPCFgKEnfVX8LMkLql839+xgjv1TZ2d+45QID6EePBkCcUXMyF7i+L37xXoWzoSkUSNAPcKD8ppb+lm8SzU5HH6Gh/aFTlflQBCNTuIbV7Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 2C2EE18003D4; Mon, 13 Apr 2026 16:43:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gal Horowitz <galush.horowitz@gmail.com>
Subject: [PATCH 2/3] tap-win32: cleanup leaked handles on tap close
Date: Mon, 13 Apr 2026 18:43:37 +0200
Message-ID: <20260413164338.42894-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413164338.42894-1-mohamed@unpredictable.fr>
References: <20260413164338.42894-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Q6zfIo2a c=1 sm=1 tr=0 ts=69dd2020
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=vyeFzZFV0_OpdQW4t0UA:9
X-Proofpoint-ORIG-GUID: LkWj2pst9LbFVv6vSycUSyjcoe1-0Min
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NiBTYWx0ZWRfX2AztmPWOGd+G
 PL8KGu6p5ICjsdjWyBCe8cN1rnYjoSZ2tWwAOLaYOEP1DTJNg1qtOpJyUz6ZVjsBc8CnMX2yYlL
 oQbZ0IlnTkcJ4umIdZxWdlKgogD/4a4CoRBG7/rgvW/3LNEkdsIkLY3nb49ehbA0Sq2b8tWc8m/
 L9a5W1Od4KPfQL6yOvigQ1ZcV+CpUzoHMSfqfBT+HLu8DvUXcDSSirECbXY89FiIwwrrYjQxDiG
 PEUAau9hrV6nlolxjywKeqEhgXxAB6BZwVnUgLAtEhJxLgS+aajChl5vr3dcoY3/1kIMDlppLYq
 CHm2yV+iHf3Zsv+7VsXXkaGkdK85qxoqhyB9jIzsDDbFH+9bkqNqx+zY+sk1og=
X-Proofpoint-GUID: LkWj2pst9LbFVv6vSycUSyjcoe1-0Min
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130166
Received-SPF: pass client-ip=57.103.84.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Gal Horowitz <galush.horowitz@gmail.com>

Currently, all handles owned by a win32 tap are leaked on cleanup.
This commit ensures that the handles are properly closed upon tap
cleanup. A check for the return value of CreateThread is also added.

Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
---
 net/tap-win32.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 38baf90e0b..ae25e5a883 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -104,6 +104,7 @@ typedef struct tap_win32_overlapped {
     HANDLE output_queue_semaphore;
     HANDLE free_list_semaphore;
     HANDLE tap_semaphore;
+    HANDLE thread_handle;
     CRITICAL_SECTION output_queue_cs;
     CRITICAL_SECTION free_list_cs;
     OVERLAPPED read_overlapped;
@@ -589,6 +590,26 @@ static void tap_win32_free_buffer(tap_win32_overlapped_t *overlapped,
     put_buffer_on_free_list(overlapped, buffer);
 }
 
+static void tap_win32_close(tap_win32_overlapped_t *overlapped)
+{
+    TerminateThread(overlapped->thread_handle, 0);
+    CloseHandle(overlapped->thread_handle);
+
+    CloseHandle(overlapped->tap_semaphore);
+    CloseHandle(overlapped->free_list_semaphore);
+    CloseHandle(overlapped->output_queue_semaphore);
+
+    DeleteCriticalSection(&overlapped->free_list_cs);
+    DeleteCriticalSection(&overlapped->output_queue_cs);
+
+    CloseHandle(overlapped->write_event);
+    CloseHandle(overlapped->read_event);
+
+    CloseHandle(overlapped->handle);
+
+    g_free(overlapped);
+}
+
 static int tap_win32_open(tap_win32_overlapped_t **phandle,
                           const char *preferred_name)
 {
@@ -604,7 +625,6 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         unsigned long debug;
     } version;
     DWORD version_len;
-    DWORD idThread;
 
     if (preferred_name != NULL) {
         snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name);
@@ -642,15 +662,22 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
     }
 
     if (!tap_win32_set_status(handle, TRUE)) {
+        CloseHandle(handle);
         return -1;
     }
 
     tap_win32_overlapped_init(&tap_overlapped, handle);
 
-    *phandle = &tap_overlapped;
+    tap_overlapped.thread_handle = CreateThread(NULL, 0,
+        tap_win32_thread_entry, (LPVOID)&tap_overlapped, 0, NULL);
+
+    if (tap_overlapped->thread_handle == NULL) {
+        tap_win32_close(tap_overlapped);
+        return -1;
+    }
+
+    *phandle = tap_overlapped;
 
-    CreateThread(NULL, 0, tap_win32_thread_entry,
-                 (LPVOID)&tap_overlapped, 0, &idThread);
     return 0;
 }
 
@@ -667,9 +694,8 @@ static void tap_cleanup(NetClientState *nc)
 
     qemu_del_wait_object(s->handle->tap_semaphore, NULL, NULL);
 
-    /* FIXME: need to kill thread and close file handle:
-       tap_win32_close(s);
-    */
+    tap_win32_close(s->handle);
+    s->handle = NULL;
 }
 
 static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
-- 
2.50.1 (Apple Git-155)


