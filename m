Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B3BCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jAK-0008Ho-Si; Fri, 17 Oct 2025 08:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v9j9R-0007bv-RI
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:01:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v9j7T-0001BH-18
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:01:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47114a40161so18085835e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760702373; x=1761307173; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4afp/6dI6zHZWkA9HSSK0D8+/OSOH9fXxwsEQGCRDlg=;
 b=d7DzhikN5JocZTRUlsoFtp8CZwfQweWQAYbGB9Bxh3faBbH5yXgck3x1JqRvQDDL5n
 vPrFSoxYoC99F+0tCCl7HJiMMJrpoEmlz3GqxkhIWu0YwEu3pkdEnRSdlT9n1YZ4elHm
 Dg6PWzM0hfwTsur0n+gB6rViC6hyZ9vFQ6n72v8/l+8IfaWplqfnhr+FYy6bAP9brZwK
 A+f8dUCMXFTZBksociQSfHA18HRd2n2VMesELOkK4W0HWjV15jPnx8H35ucFgKQVz0Fu
 4qBHQL+Qabh+cGh3d9g7+PGWVimpUko4+WhL9o/d1pAMzmUSDmALidurUoDnY9z/7oR3
 ck4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760702373; x=1761307173;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4afp/6dI6zHZWkA9HSSK0D8+/OSOH9fXxwsEQGCRDlg=;
 b=dhXiIEb7ZWHFxOF6IUvGW1wI4MgYmvLrim0c34OUAjAgrLvpW3kWGUda+ydlMLcADh
 GGktPV8IpO3Fvs1BScxAP2ioVJfqAvc3kByvzV8CBwquEJ1oUJSxMHxEu99uwWX3F3dO
 jtSjswM0D+0OKDDSM0dTTd26GjUEdP8GIXixFe3SegXBA44dV7clrH184gowE2v6pdbI
 L7GFhbImbzuCPzDhBXK7+9Hl8GitDX+kgllbZ+SuH/y1Zah+gFAz7GwhEmVUXfd95NX4
 5o5N3lb1dLyLRCjTv884HT/PQrviqunxVMRZanDcxCwtuNfFDWRQRwHqvNjH00F53+xn
 3Mqg==
X-Gm-Message-State: AOJu0YyKcEhIwEyImLDVtkCl2cSkU0qjYCrjLfS8mWmdttXOLpO1lI7C
 D3EwiBSZMV8PMp8VPnMMWkykn7qEMIbZO/hWdQPDHYx6qedrFtcrS7uzgsbTNA==
X-Gm-Gg: ASbGncvXHQeQR9JunpxRKq2+MBkQaXseBdvb5xb1yyD6DN1TTdRjkiaiGnLTZ4YTMTR
 4VEHWUv/grnIV7psdPGpuQbjraBEgpNPXRwejfBIfyHIhxX7/lsYVoWJFIDNFduTLvc6Bid2/u7
 Z/fHv2Y0HAdCzYUpvZ+eDxORywmJ+2AUmeFVT8i4HQqWbmU64wKZMggiQ2BCgIDnZJ1dJLgzKjt
 cIORV7h13yguko+vXTRfwiJE+t1BVdhUAYHbb/RWellEs92dgY3O1lL5CewQqmTxr1ddeqYuvnL
 uiVCmjenP12YZJ7fF8IaJVYUxmjPsLHAe/HGzpls/u4vdLL57tL40ayyI2ZspMtH5dR5UBeoIAX
 fa2SDFEVsJVCf3Ei5jkHulUPC8QgvHwYUTI+pm1N9iC42b7al272wBkX8xHYXlgum6jd8Kr+t+y
 PQeIgmCc5nHtVd1J/VYtW6AD51EO1Ql+f2lDZO3zzKAJhWHjlux86Hob5SL3AJKRsKmb6Dj0c6/
 lQt
X-Google-Smtp-Source: AGHT+IHB8QdrAb9W28MQQ3JLbb/Jk4cciv9uYOYgM2SqEMX7yLau0hAMO2UFRpbHXz8XbXvJFFht7g==
X-Received: by 2002:a05:600c:64cf:b0:471:12ed:f698 with SMTP id
 5b1f17b1804b1-4711786c793mr26462725e9.8.1760702372927; 
 Fri, 17 Oct 2025 04:59:32 -0700 (PDT)
Received: from GAL-PC.localdomain (bzq-79-177-159-123.red.bezeqint.net.
 [79.177.159.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42707b482b3sm3208493f8f.50.2025.10.17.04.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 04:59:32 -0700 (PDT)
From: Gal Horowitz <galush.horowitz@gmail.com>
Date: Fri, 17 Oct 2025 14:59:02 +0300
Subject: [PATCH v4 1/2] tap-win32: cleanup leaked handles on tap close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-fix-win32-multiple-taps-v4-1-483415799ed8@gmail.com>
References: <20251017-fix-win32-multiple-taps-v4-0-483415799ed8@gmail.com>
In-Reply-To: <20251017-fix-win32-multiple-taps-v4-0-483415799ed8@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Gal Horowitz <galush.horowitz@gmail.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=galush.horowitz@gmail.com; helo=mail-wm1-x32f.google.com
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

Currently, all handles owned by a win32 tap are leaked on cleanup.
This commit ensures that the handles are properly closed upon tap
cleanup. A check for the return value of CreateThread is also added.

Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
---
 net/tap-win32.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 38baf90e0b3f121f74eb32f1bff779c84ce03114..ae25e5a883343bf9f570d0f382b8c64712d95242 100644
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
2.34.1


