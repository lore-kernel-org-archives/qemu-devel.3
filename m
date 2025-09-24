Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5E2CAC5B5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 14:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1QpU-0003jj-9y; Wed, 24 Sep 2025 10:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v1QpR-0003iJ-Ab
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:50:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v1QpI-00085g-6d
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:50:45 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so2840466f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758725433; x=1759330233; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fKsW8MTn6Ud4eb6hMK8khOSmJ73MNvmZ+g7b8RpElHI=;
 b=V6xr/x8SfDC4+3dYOlOeyMMALUvYyW9aeLc4qtPKNZegY3o/i5yHwbxy/9JzJ1GGpk
 2YFm6zUCwa7MOO7jiebdG7JWrsbvb09l82eU9kDhCt/N/6CaCMtYm+tmpRExp+DSQlNi
 hXK+KSKqV/UhANrKfz0nlMos3w9sPFhORNqnGk4Siy/WlR7lUd9B8kGPdPBamGB1fZ5O
 VcdRrbus5PlcTRpWZ5TU1PEQqkPhLB8j71iel6tjbMebVN3guO1QsQTev4UxkSeqJpA0
 gLJf69dZAPdRHBI3iiTAZ/zyJluaZTt2czkwVp+RfTEl4qHfpRoU/QMrsvEr2e1fs7TU
 2VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758725433; x=1759330233;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKsW8MTn6Ud4eb6hMK8khOSmJ73MNvmZ+g7b8RpElHI=;
 b=oblBwGtaP7DbLjgP6QXnu8/waBeVNGUTEmxZCbhNI39zKhEJO3F0jZ8zbU1HYmLRuF
 ODHpz7WVHyDf7zCjBg4YsRLs10kL5vRboeFssClF+dCax6tUOn8Jlba5HQaD/JyDER0x
 36ijBO4MDOaixbL+/f/pJ76s7ttSGMRSWdVM9IpuC/HCE2SW2snhqzIf2KkkjN9TrVBw
 /ioFhsZYMP/Y06ikvli0BqL7cuZkMDukNiPQ6tDg3ChVbvKtYeHuDrmc28pfzCTiQbwu
 1XxnXtdwsiW50R2ykAzvThyQW0rQXuZEGo2dYnw4L4myu9xhk9N4O/oAH4JChqpxz9kY
 4CBA==
X-Gm-Message-State: AOJu0Yzw5QjZ70EZsCNnu589UpZrFnG/hFZ2ENMxpHma+TjYRj1M/Prz
 PqvwP7xoYLApPwqNnw9U7X41OutXUqJ0Wna6Ok78a1ayu2G/MN+6Bu6qJqH7oA==
X-Gm-Gg: ASbGnculq+pR4SY8BRLjeeTHyNigYqh7cSUsCmzoA2JQclvmljFHtJVO/028fbtoWaW
 dCLWyAPa5Sr7LjDY+sYqLuQJmxAaOrAHl61Vh7JWZjAHs7v7+MERrq+RdI0qSfgmrQrRx/62gOM
 B3sj5Yz3yeWN7YT/y/50ACe8RzdoXGTTOO37i51z7uMaxWygsftAKzMuaI64QNB2+X192b94sUY
 vwD9B9+iub3sn5GV2j7OdfhMSH67Ne5pIdxcZGbQg36SvJQEFz5WtdfYZTKkLMrh1oymb85mBKM
 mA+H3Hsc+bya9hjPeoIWE7e5oEFGY6R85KmZBPhYfPpiiO5aNzj7U1GeJDVBCiMe7yegLDUZaZ4
 ONA0GMTtNotkCsYe7d9gUUnhS21JDSsibqY4H26KgZg1j1VYxYF4klxrNGwqehWupZLOtkvq8bw
 nyjw==
X-Google-Smtp-Source: AGHT+IFAKvPOrscXGN5NQtuVlKiAe8k/A6X3KeuLHZBiwQcoHRIvwUfgJAUIydjAHU2NcbGyAp0p4g==
X-Received: by 2002:a05:6000:4010:b0:3fb:ddb3:f121 with SMTP id
 ffacd0b85a97d-40e4b1a079dmr238218f8f.45.1758725433345; 
 Wed, 24 Sep 2025 07:50:33 -0700 (PDT)
Received: from GAL-PC.localdomain (bzq-79-177-159-123.red.bezeqint.net.
 [79.177.159.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407cffsm28188158f8f.16.2025.09.24.07.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 07:50:32 -0700 (PDT)
From: Gal Horowitz <galush.horowitz@gmail.com>
Date: Wed, 24 Sep 2025 17:49:50 +0300
Subject: [PATCH v3 2/2] tap-win32: allocate separate tap state for each
 instance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-fix-win32-multiple-taps-v3-2-9335df866c14@gmail.com>
References: <20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com>
In-Reply-To: <20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Gal Horowitz <galush.horowitz@gmail.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=galush.horowitz@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
 net/tap-win32.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 1a79e35c2708eae32ccdbc873908aa1ccc7a03f0..1b83423191c5a6f248c771d5eb5582cc80e8abcb 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -115,8 +115,6 @@ typedef struct tap_win32_overlapped {
     tun_buffer_t* output_queue_back;
 } tap_win32_overlapped_t;
 
-static tap_win32_overlapped_t tap_overlapped;
-
 static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t* const overlapped)
 {
     tun_buffer_t* buffer = NULL;
@@ -403,8 +401,10 @@ static int tap_win32_set_status(HANDLE handle, int status)
                 &status, sizeof (status), &len, NULL);
 }
 
-static void tap_win32_overlapped_init(tap_win32_overlapped_t* const overlapped, const HANDLE handle)
+static tap_win32_overlapped_t *tap_win32_overlapped_new(const HANDLE handle)
 {
+    tap_win32_overlapped_t *overlapped = g_new0(tap_win32_overlapped_t, 1);
+
     overlapped->handle = handle;
 
     overlapped->read_event = CreateEvent(NULL, FALSE, FALSE, NULL);
@@ -455,6 +455,8 @@ static void tap_win32_overlapped_init(tap_win32_overlapped_t* const overlapped,
     overlapped->tap_semaphore = CreateSemaphore(NULL, 0, TUN_MAX_BUFFER_COUNT, NULL);
     if(!overlapped->tap_semaphore)
         fprintf(stderr, "error creating tap_semaphore.\n");
+
+    return overlapped;
 }
 
 static int tap_win32_write(tap_win32_overlapped_t *overlapped,
@@ -605,6 +607,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         unsigned long debug;
     } version;
     DWORD version_len;
+    tap_win32_overlapped_t *tap_overlapped = NULL;
 
     if (preferred_name != NULL) {
         snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name);
@@ -645,12 +648,12 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         return -1;
     }
 
-    tap_win32_overlapped_init(&tap_overlapped, handle);
+    tap_overlapped = tap_win32_overlapped_new(handle);
 
-    tap_overlapped.thread_handle = CreateThread(NULL, 0,
-        tap_win32_thread_entry, (LPVOID)&tap_overlapped, 0, NULL);
+    tap_overlapped->thread_handle = CreateThread(NULL, 0,
+        tap_win32_thread_entry, (LPVOID)tap_overlapped, 0, NULL);
 
-    *phandle = &tap_overlapped;
+    *phandle = tap_overlapped;
 
     return 0;
 }
@@ -670,6 +673,8 @@ static void tap_win32_close(tap_win32_overlapped_t *overlapped)
     CloseHandle(overlapped->read_event);
 
     CloseHandle(overlapped->handle);
+
+    g_free(overlapped);
 }
 
 /********************************************/

-- 
2.34.1


