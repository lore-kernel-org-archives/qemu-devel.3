Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EF2CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18v2-00040p-UF; Tue, 23 Sep 2025 15:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v18v0-00040Y-Px
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:43:18 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v18uy-0001Bp-Ln
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:43:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so3947904f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758656592; x=1759261392; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RdzgRYiVYa6JEHlFZL0HglW5m+jT/UUOfbyutIzT/rg=;
 b=mG0Lc3mJuM5agciPYDXTBAbTwAfRElWztH7hKMNS3eEcogK3zG3ooPxv399E3R39bC
 BikjBzze0rW/XBFsV/+2xx5WrdtpC3sKsvkZkET6V9c2qXHNHXIt3yOQEoLvazPtzPz5
 GrnTFUw1szGh0eed1UTFAgRZ8hZgiBiFRLuOmPGmtD9VHDakIC8Rn8gnUnmoVE7z/Nwd
 eV8i/xZpk9fSO5sACeiHpvFR8ArPBcp2f9DUVMm9RuSAcnzdzyHefpj/9oz0IkVWwiJp
 Cub9DtWouI7blacwt/4VGkmmniITgyt5ZJa7QdeJXQ9L98eDZLKvDqOR0ns81nuOAiOB
 4i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758656592; x=1759261392;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RdzgRYiVYa6JEHlFZL0HglW5m+jT/UUOfbyutIzT/rg=;
 b=Ko0ag3jTh6xgXEEOrG0wZX6GwQmcqVMbqsWDJxbi6EqO/KfBa84F1jx9+qI9Xmds04
 CpzMt31lF8oRaIxuln0vdbofFte9UKlOhy2Gjvb8kTjrBWi/lDzKqvp9u68ncB/drppF
 UQCcA262jDWz1iUi0KgM753+Mg8rwyjq/6edGiRum4ntUZxO0dZMPz4cD9t+/rb3TiXO
 9DQNAS3XKnrrAkqgw9wjGgzNqjvh1O9obXWz2tghpVvdb6De6YxogiekG4hAyj7gqTHq
 sdaWo9u8jETj4fb2GCcJQWkghaKNHCHydqn7v7xO1M5f8B1JiUK9wuzuCVXMLgWwdACY
 LiHA==
X-Gm-Message-State: AOJu0YyTayS9dEaCiQRwhtHzt0dFntLxDYv/sEn9cLnKoGwiUxmrFmt9
 ++BzrMFrY7faou1bWL5WuEC0XFEiKP0Vc1gDAF/JrWFpEXsr7sfu09ER
X-Gm-Gg: ASbGncsW+6tbA7hXkMoa0wP4elz0bIZUZd8jtZKyIuzliodqomIx7+nrP2OXpL5pct8
 Ca5ft5UHVlpNNjPmfnA4HX+Dld3ggftY76al1id1u7INOHgsUcsXxPcymllTpZBAGofURLjbPMi
 /HrQVrInsJTGcbqqGN3pmlvCGq//VmTUUDxcI25XvDv9Oepb5KiD2mVF+JLATUJZo94cWBU2l8H
 Pkuwx/b1/5vOzwJSDeJ2XoLDT15018ox8WcK/Z505JBCK4EwXA/wEkbPhmKMs+TYxB+w6ISgmD9
 AmRDFdkidooNGbVJfp381E58zzB83jTOlhSoCcZbOLOVkGGjHWfok4r4zvSHdv+32knjmsgdKaQ
 29vylbt8cW1XTQAHLabwfVYhwhYbWGfIQ3OXxBTOwRmPv9viYWpPU+wJfFoVKfXPHPQUIxZiE8d
 Ap65v+1H7WsBtU
X-Google-Smtp-Source: AGHT+IFvoN515skRg4SzKEDJwY8npQ+ATE0cEMym1EgR/LD4DxD3VczJM7jcxSckPnAQ83YbNZ9PYQ==
X-Received: by 2002:a05:6000:4287:b0:3e8:94d3:766b with SMTP id
 ffacd0b85a97d-405c49a2617mr3190770f8f.1.1758656592150; 
 Tue, 23 Sep 2025 12:43:12 -0700 (PDT)
Received: from GAL-PC.localdomain (bzq-79-177-159-123.red.bezeqint.net.
 [79.177.159.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee073f4f3csm24148350f8f.2.2025.09.23.12.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 12:43:11 -0700 (PDT)
From: Gal Horowitz <galush.horowitz@gmail.com>
Date: Tue, 23 Sep 2025 22:42:53 +0300
Subject: [PATCH v2] tap-win32: fix multiple tap support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-fix-win32-multiple-taps-v2-1-d497e5ac446f@gmail.com>
X-B4-Tracking: v=1; b=H4sIADz40mgC/4WNSw6DMAxEr4K8risc+lG74h4VC3AMWIIEJZS2Q
 ty9KRfo8o1m3qwQJahEuGcrBFk0qncJzCED7mvXCapNDCY35/xmcmz1jS91hcHxOcw6DYJzPUU
 USxdmaRtLV0jrKUiq7uZHlbjXOPvw2Y8W+qX/nQshYSNyIstsqLBlN9Y6HNmPUG3b9gWPbpGvv
 gAAAA==
X-Change-ID: 20250920-fix-win32-multiple-taps-ed16ccefbd17
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Gal Horowitz <galush.horowitz@gmail.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=galush.horowitz@gmail.com; helo=mail-wr1-x433.google.com
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

Currently when more than one tap is created on Windows, QEMU immediately
crashes with a null-deref since the code incorrectly uses a static global
for the tap state.

Instead, this patch allocates a structure for each tap at startup.

Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
---
Changes in v2:
- Add cleanup of the structure fields
- Terminate the thread before freeing the structure
- Link to v1: https://lore.kernel.org/qemu-devel/20250920-fix-win32-multiple-taps-v1-1-bee41dcc213d@gmail.com
---
 net/tap-win32.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 38baf90e0b3f121f74eb32f1bff779c84ce03114..1b83423191c5a6f248c771d5eb5582cc80e8abcb 100644
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
@@ -114,8 +115,6 @@ typedef struct tap_win32_overlapped {
     tun_buffer_t* output_queue_back;
 } tap_win32_overlapped_t;
 
-static tap_win32_overlapped_t tap_overlapped;
-
 static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t* const overlapped)
 {
     tun_buffer_t* buffer = NULL;
@@ -402,8 +401,10 @@ static int tap_win32_set_status(HANDLE handle, int status)
                 &status, sizeof (status), &len, NULL);
 }
 
-static void tap_win32_overlapped_init(tap_win32_overlapped_t* const overlapped, const HANDLE handle)
+static tap_win32_overlapped_t *tap_win32_overlapped_new(const HANDLE handle)
 {
+    tap_win32_overlapped_t *overlapped = g_new0(tap_win32_overlapped_t, 1);
+
     overlapped->handle = handle;
 
     overlapped->read_event = CreateEvent(NULL, FALSE, FALSE, NULL);
@@ -454,6 +455,8 @@ static void tap_win32_overlapped_init(tap_win32_overlapped_t* const overlapped,
     overlapped->tap_semaphore = CreateSemaphore(NULL, 0, TUN_MAX_BUFFER_COUNT, NULL);
     if(!overlapped->tap_semaphore)
         fprintf(stderr, "error creating tap_semaphore.\n");
+
+    return overlapped;
 }
 
 static int tap_win32_write(tap_win32_overlapped_t *overlapped,
@@ -604,7 +607,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         unsigned long debug;
     } version;
     DWORD version_len;
-    DWORD idThread;
+    tap_win32_overlapped_t *tap_overlapped = NULL;
 
     if (preferred_name != NULL) {
         snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name);
@@ -645,15 +648,35 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         return -1;
     }
 
-    tap_win32_overlapped_init(&tap_overlapped, handle);
+    tap_overlapped = tap_win32_overlapped_new(handle);
 
-    *phandle = &tap_overlapped;
+    tap_overlapped->thread_handle = CreateThread(NULL, 0,
+        tap_win32_thread_entry, (LPVOID)tap_overlapped, 0, NULL);
+
+    *phandle = tap_overlapped;
 
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
+
+    g_free(overlapped);
+}
+
 /********************************************/
 
  typedef struct TAPState {
@@ -667,9 +690,8 @@ static void tap_cleanup(NetClientState *nc)
 
     qemu_del_wait_object(s->handle->tap_semaphore, NULL, NULL);
 
-    /* FIXME: need to kill thread and close file handle:
-       tap_win32_close(s);
-    */
+    tap_win32_close(s->handle);
+    s->handle = NULL;
 }
 
 static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)

---
base-commit: ab8008b231e758e03c87c1c483c03afdd9c02e19
change-id: 20250920-fix-win32-multiple-taps-ed16ccefbd17

Best regards,
-- 
Gal Horowitz <galush.horowitz@gmail.com>


