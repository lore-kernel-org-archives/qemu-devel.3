Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABF0CCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jAh-0008O3-Bz; Fri, 17 Oct 2025 08:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v9j9R-0007c0-Dj
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:01:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v9j7U-0001Bc-GS
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:01:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-471076f819bso14858865e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760702374; x=1761307174; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rt2clKOQFsgO4ZZVeIk/0wwdAAfT+CK0yGEf7GCPm3I=;
 b=MAH6DcVGGANcRtotRQcsOQNX4/bE/Vx0O+e7molugpMjJuSHva9SPwm/lpV6Zm+NmV
 TQIcCfrReQgbcT5XI4NXqSdomClsh/eEonbvSVcnLxWuTjyqfXa4/cMsnp337XRY/lZW
 QuLgqodIJgcoh6d3ZNsHnjGuoOAnx0Eej9exRaIbZkeOguKkJOo5IbaaXUP7YjrYUmMR
 qFTLGuDfTwMyWXeFmsBb5O3CozUoPJkb686e/0ZTUiPdtQ/alXp6whTxs4LzDWK7taJg
 xF1NXZ9hRQV0h/mvFQ8OdGH0zalLtj2IsXCf6PUzgLo3ITbLZ7tZC3Cq7Y2shbtBjh9r
 4muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760702374; x=1761307174;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rt2clKOQFsgO4ZZVeIk/0wwdAAfT+CK0yGEf7GCPm3I=;
 b=eq5Xq0w5aDqa1NoyRbDYS3/NzfNo0e7HO4T9n8MoPnLCDe2nCBynWxkJkXbgotLdEh
 HqytaB9kMkrmaaQev4BV7wsXye6xpe3r67H3AgvQtyQwQ+l96ZxU3dSSs5PpkR45LTud
 hz1i1w6jTNn+VbARk3JqpjE98FPzaHWYiEbRVFyg+gLjUZawQX6XwFzl15KSf9wjTkuk
 bIgnRogMqMX+310CQIzSYhj1ttuTC6Fl9Kxq5EZXbfba3qYGMcup4Gnxjb0RUBmsyPZS
 pz5q0gdv76Nz3CeKQ0SGg5JrzVMSo+xUh+OPw49TdUNwxmRQhwjHGpPY3omBhgRP6ZVl
 VeuQ==
X-Gm-Message-State: AOJu0YyqebuQImOzRPC7xG7I7MDCN3xT5wCLCFf3pp/l8S/Jb8VWpLvW
 KAY133UqqgpwIZUMNEne1v6T0YL428UjFolUPk+sJ6OYtywHgtOhBGs1
X-Gm-Gg: ASbGncv6KOEkJOD+XjLNL/jS5ruIa/FyJa0gu3OHBLfZLDpkgeDqY/LxlNBwU+YxvRt
 MdjYUg941HUvEXj1qsPXK+pgp0cuRRSoGwjDAG5inCVZ1KvhP0rqTOei/vf8JHCm8h8fEbe05S3
 coHGRADFsCb76IfHKh6y9aJ9wVTvMIY0WNGRQp5YovSuddXzoXvqVdwCK4Rf/COCiPN/u6ZWj8R
 3wYlT/9G3CgicqWzGIrYOkDj2CY9xJOCyNNSFHfxiAy06LDTV8PP+H6t7MMbJgEcZ31HZKApsPF
 /tIX0zPvR0mJU0MkCydOl9juPvD6ciMZORG/DP7YjTXeRRF3U2NZviiVYLLRmTF4gYArM4h8hwL
 xMnQb7YcItQjh5ZLYf9q7Ml2Wm0UxZ995FiJDAvKlLvdCeR7abcyqMnfLnfZx7SDCZHjDGZa5AW
 oVGqKU5BwKLuf4/NlR8EF42E32mT/jUVHpO58A5GIjhpQ1EW6GVijXE7GgltJm0hFamg==
X-Google-Smtp-Source: AGHT+IH6E8kzHJr6m9tqDcPW65zeEbFky2+6pG1Zjq26pZcMpV7s8/vmYlxkYR/YZWeb4S2MklHjZg==
X-Received: by 2002:a05:6000:2307:b0:3ed:a43d:e8c4 with SMTP id
 ffacd0b85a97d-42704d9d03cmr1885392f8f.6.1760702373938; 
 Fri, 17 Oct 2025 04:59:33 -0700 (PDT)
Received: from GAL-PC.localdomain (bzq-79-177-159-123.red.bezeqint.net.
 [79.177.159.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42707b482b3sm3208493f8f.50.2025.10.17.04.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 04:59:33 -0700 (PDT)
From: Gal Horowitz <galush.horowitz@gmail.com>
Date: Fri, 17 Oct 2025 14:59:03 +0300
Subject: [PATCH v4 2/2] tap-win32: allocate separate tap state for each
 instance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-fix-win32-multiple-taps-v4-2-483415799ed8@gmail.com>
References: <20251017-fix-win32-multiple-taps-v4-0-483415799ed8@gmail.com>
In-Reply-To: <20251017-fix-win32-multiple-taps-v4-0-483415799ed8@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Gal Horowitz <galush.horowitz@gmail.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=galush.horowitz@gmail.com; helo=mail-wm1-x32b.google.com
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

A static global is incorrectly used as the tap state for all win32 taps
created. Instead, we now allocate per win32 tap.

Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
---
 net/tap-win32.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index ae25e5a883343bf9f570d0f382b8c64712d95242..3d7227fcf47ff45bbdbf60cd5b86ab8f8913b941 100644
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
@@ -625,6 +627,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         unsigned long debug;
     } version;
     DWORD version_len;
+    tap_win32_overlapped_t *tap_overlapped = NULL;
 
     if (preferred_name != NULL) {
         snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name);
@@ -666,10 +669,10 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
         return -1;
     }
 
-    tap_win32_overlapped_init(&tap_overlapped, handle);
+    tap_overlapped = tap_win32_overlapped_new(handle);
 
-    tap_overlapped.thread_handle = CreateThread(NULL, 0,
-        tap_win32_thread_entry, (LPVOID)&tap_overlapped, 0, NULL);
+    tap_overlapped->thread_handle = CreateThread(NULL, 0,
+        tap_win32_thread_entry, (LPVOID)tap_overlapped, 0, NULL);
 
     if (tap_overlapped->thread_handle == NULL) {
         tap_win32_close(tap_overlapped);

-- 
2.34.1


