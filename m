Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A152BCAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 14:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1QpO-0003ft-62; Wed, 24 Sep 2025 10:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v1QpM-0003fA-8G
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:50:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v1QpH-00085X-MQ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:50:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3eebc513678so4881397f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758725432; x=1759330232; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QendDT5zR1DkIs+Rqye28NA9H9pWQaC3eT+nBbwKIbw=;
 b=Qwl1qC8c7pdEKFap0NPix6MC9KueXKczdwTncydYfGOQ4cu5wpAPUtcuFL4NapNpiC
 1ji3AsAyKhEvU6RsIYlLGOxz46icu1RfLtoMCZy85Zd/qdXMVjZhaQewNUCDL/Xog2MG
 yRNoXhpZwScBEK0bPynzlkaH3+GpfurgMuzIcxMXOquRTf2qXrmQuUHM6fpscu/4byEH
 DDvyworRuIHxOkm/1cJ95Kg0YEBB0qqeRpJd84pUwdx/iYe+TLW7QCUGhzZ3Am0BDRAB
 ED/F+gBAzJ2MNqMpo0ACV6BBrBOZtBl5053W5D7iSrNJWPZKKpXPa3oP2HpQ17ovO+gI
 cEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758725432; x=1759330232;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QendDT5zR1DkIs+Rqye28NA9H9pWQaC3eT+nBbwKIbw=;
 b=oseDavr0Vp8jvFbR5e13ElRmwE6yR7uBQt/LDdFWKb9EGwGuw75tKe056a//Sadt0l
 /9rwkdDcUe96N/z5FaSPJIhOuw6ud1VRGhJ2b1JgTZCPjO9U3B9dgdQdRPGlhnlbGamO
 hLr67HboMRSO9PzafpF2YiXDD0M9sotC4EgIPjVu0AemVslWvUuHQcatnr8W/i75egr6
 tAeBfaD25rElXc6fA94akf4zhgSpjIEZHFIwLpYrWabiEer6G5h2eutvDsPSpjian/Xp
 3zlg/xIe+S5UPDlWRNQnMkGg9nQOe34somVrraqpT+gC1kaKaqBZQq6PU2RV6MzHuicT
 1ssw==
X-Gm-Message-State: AOJu0YzNeL23Avs2gIOERdagXHaAi53sgFwwFqgsmLs2/16JccM2FW9W
 C/GGcPeI8GMp8aeQ9nTiFwYOoN/pgoWkiu8PbYQU+npqz0e9kOPXU7Rp8QDbrg==
X-Gm-Gg: ASbGnctpM/G43r/F225+AdIkD5rGMDjCPqXowhPdTfD+INnrUQwRHEdbPyyWN3DrRcW
 EXAge/nJ+cpgxr9dCcC/V0443iYQUGZYbTDkjDBa88o5NATODQ4XCWAIuVAPzcWZwicpFlTOJLh
 E0LA1z0oU3wRY7HBa4y77q1toX23hmTy0Rv58wQQOlwws3qv2ox58hU7a5a578z2Zqr0JO+X9yC
 dbJjfevKi6g31LxRmigcpCa59C5fpSCT6Oqt00oSNtkWFaSxb9QWrdNHw3nSdkpDxfoBej0BpTF
 v+pbG5Qt+Wn11PZldNeT65DW//oKJTZJ38J4VBUdPYms5sN7LRUCl5eWFMLTlG3V/i3LAtXy56g
 4FZO7OJ1Pmgo94aBgQlYedM21b/T6szJb+4eCPbSvuFCSZ0xiEN5AsvoyaIyIm2ihdVmds0lFHP
 TGNw==
X-Google-Smtp-Source: AGHT+IHX2AZPZND+8Xei62CJC2Df3nVezotMg4rAz3xvVA+2Gz8KONRpNldO3IeKbc9cZ3hPbZ6mnA==
X-Received: by 2002:a05:6000:610:b0:3c7:36f3:c352 with SMTP id
 ffacd0b85a97d-40e4d9c9f42mr196712f8f.59.1758725432303; 
 Wed, 24 Sep 2025 07:50:32 -0700 (PDT)
Received: from GAL-PC.localdomain (bzq-79-177-159-123.red.bezeqint.net.
 [79.177.159.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407cffsm28188158f8f.16.2025.09.24.07.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 07:50:31 -0700 (PDT)
From: Gal Horowitz <galush.horowitz@gmail.com>
Date: Wed, 24 Sep 2025 17:49:49 +0300
Subject: [PATCH v3 1/2] tap-win32: cleanup leaked handles on tap close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-fix-win32-multiple-taps-v3-1-9335df866c14@gmail.com>
References: <20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com>
In-Reply-To: <20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Gal Horowitz <galush.horowitz@gmail.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=galush.horowitz@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
---
 net/tap-win32.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 38baf90e0b3f121f74eb32f1bff779c84ce03114..1a79e35c2708eae32ccdbc873908aa1ccc7a03f0 100644
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
@@ -604,7 +605,6 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         unsigned long debug;
     } version;
     DWORD version_len;
-    DWORD idThread;
 
     if (preferred_name != NULL) {
         snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name);
@@ -647,13 +647,31 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
 
     tap_win32_overlapped_init(&tap_overlapped, handle);
 
+    tap_overlapped.thread_handle = CreateThread(NULL, 0,
+        tap_win32_thread_entry, (LPVOID)&tap_overlapped, 0, NULL);
+
     *phandle = &tap_overlapped;
 
-    CreateThread(NULL, 0, tap_win32_thread_entry,
-                 (LPVOID)&tap_overlapped, 0, &idThread);
     return 0;
 }
 
+static void tap_win32_close(tap_win32_overlapped_t *overlapped)
+{
+    TerminateThread(overlapped->thread_handle, 0);
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
+}
+
 /********************************************/
 
  typedef struct TAPState {
@@ -667,9 +685,8 @@ static void tap_cleanup(NetClientState *nc)
 
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


