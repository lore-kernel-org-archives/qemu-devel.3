Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC54CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 11:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v11Gp-0002Rv-T8; Tue, 23 Sep 2025 07:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minglei.liu@smartx.com>)
 id 1v11Gk-0002Qk-CV
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:33:14 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minglei.liu@smartx.com>)
 id 1v11GW-000793-S6
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:33:14 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-77f22902b46so2657417b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1758627172; x=1759231972;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3+5JLE2c+7D5Q+5qXD1dXhzjHwLON4/Atcl8U9Zp/E=;
 b=OYlg3FGNr6tHW0x+/kJF19aUF8LKfUjvj6Rj/KM2Vf93IBjE93vdyoPbCPPqu8Mk6D
 KS0aYK9NOJgwGqYhEIEAizIRfIV4cIQEbgSBwXPV2YQhRQBgimdfsGODtFXj2/u0AJKy
 X9UWfcRlfZD0AsYVJxBb08JMET2ECNj5euUEOY0XsFPvX17wkb89lWXidU8ukp1RTora
 QAuGsoxAalvIfIlzuxClcqUF1RYVyahYpWeT//FHQw+9hLAqb+IRu30V2LL906xws6wT
 2WIPrjtAMjjIWfe3WvDj2ZBkjM7mlq2VGBZZ7OvyVzr9mYRsax0HeBzG+ca+FfwHjp5B
 oJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758627172; x=1759231972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y3+5JLE2c+7D5Q+5qXD1dXhzjHwLON4/Atcl8U9Zp/E=;
 b=aKbiQCM7LiFzq/NRt81H9uYxMtBK6hhtKYVaxeNZ6vmki4KawyA79c6ts310ssC6LJ
 K7SMndMJvdmnT7namnPSCy2Nc9TE2hEMQBJ4dZlhXfJGJRWYQyocwrT0JZuykw3IV3tr
 du6ZjKajmkMrSIC8/Cklni3rPv3jczCD2w0qCKr4UZPX/ZXY6uWAlGZW/bpea5aJyssC
 nIP/kHHsNxeHfjc0tXszeddCRMX7xic7NZcHXDp6FLOdF8xoEdUjSiL5qa7FjA9M8hg5
 mLY5qNkpGkFzQx4i1vp4TXcWtGA6c3zu0yITLxSKZ81ZkRgA7MDP4g7qShijNcTHejTI
 oeCA==
X-Gm-Message-State: AOJu0YzDftAvRtQZAlL9Bujfpt9PDTkvUM/fxnK+WAyuZUmxDp8YW/55
 MGLzJEUu9CZ+l65VNJt6NkK8QtGQpIcw9jKiraPTt3ZAG6H4KDH9bCEL7Q+wCf6EbqRBbFEz7bE
 cSls0/k4st3rT
X-Gm-Gg: ASbGncsO+byyw+JkzaOPom6fPfwPY7B/kuHITDQrUTleAT0XwczL1HWL/ck989d+Am5
 4m3ieUDURjGAmi//Mt6ksKnUhfqjWrsEWC7jvg7LnRSn9xAcNKTVb/ZnfC+ZOvKqZsxfHzl89Tp
 sEp33b0zMPuCvhpa4AL8KT089P7M63guUn4RomT0ODdpTrkOWrxWkRIy1ynOUHT9N0xJYeFr1Ga
 kiSkzVGTLnoQmsUObKMVBr/AS4/rKgaQaPAcqQ3hCUusnQgaimUBkdxeX2xBvNT2wJBass+SwZy
 hPH24iIy066+tNoehW3h9X1B1T3kqUsVUA0EaM/Fnd0EiKs4fk71DHjzC869dlbTU+JdvAB0etw
 Ba3CKQcZcQjIFhWRFifaQbwER0ALERqtAd7Ay+upWmYk0aQ==
X-Google-Smtp-Source: AGHT+IFR6YtETOHXME5UTCVYA9BnYtybHSgaBrsje2Ac2b919DNqoLLF75/xSrKvZpGI8Ydel2NMKg==
X-Received: by 2002:a05:6a00:3904:b0:77f:472b:bc6f with SMTP id
 d2e1a72fcca58-77f538e59efmr3266110b3a.13.1758627172194; 
 Tue, 23 Sep 2025 04:32:52 -0700 (PDT)
Received: from localhost.localdomain ([125.69.0.79])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f315254edsm6454583b3a.84.2025.09.23.04.32.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Sep 2025 04:32:51 -0700 (PDT)
From: Minglei Liu <minglei.liu@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, "minglei.liu" <minglei.liu@smartx.com>
Subject: [PATCH] qga: Improve Windows filesystem space info retrieval logic
Date: Tue, 23 Sep 2025 19:32:43 +0800
Message-Id: <20250923113243.78244-1-minglei.liu@smartx.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=minglei.liu@smartx.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
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

From: "minglei.liu" <minglei.liu@smartx.com>

Previously, disk space reporting only worked for volumes with drive letters,
skipping those without (e.g. System Reserved).

This change always calls GetDiskFreeSpaceEx with fs->name, which is a
volume GUID path. Windows APIs accept both drive letters (e.g. "C:\")
and volume GUIDs (e.g. "\\?\Volume{GUID}\") as valid lpDirectoryName
parameters, so space reporting is now consistent across all volumes.

Reference:
https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file

Signed-off-by: minglei.liu <minglei.liu@smartx.com>
---
 qga/commands-win32.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 8227480810..acc2c11589 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1164,15 +1164,15 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
         fs->mountpoint = g_strdup("System Reserved");
     } else {
         fs->mountpoint = g_strndup(mnt_point, len);
-        if (GetDiskFreeSpaceEx(fs->mountpoint,
-                               (PULARGE_INTEGER) & i64FreeBytesToCaller,
-                               (PULARGE_INTEGER) & i64TotalBytes,
-                               (PULARGE_INTEGER) & i64FreeBytes)) {
-            fs->used_bytes = i64TotalBytes - i64FreeBytes;
-            fs->total_bytes = i64TotalBytes;
-            fs->has_total_bytes = true;
-            fs->has_used_bytes = true;
-        }
+    }
+    if (GetDiskFreeSpaceEx(fs->name,
+                            (PULARGE_INTEGER) & i64FreeBytesToCaller,
+                            (PULARGE_INTEGER) & i64TotalBytes,
+                            (PULARGE_INTEGER) & i64FreeBytes)) {
+        fs->used_bytes = i64TotalBytes - i64FreeBytes;
+        fs->total_bytes = i64TotalBytes;
+        fs->has_total_bytes = true;
+        fs->has_used_bytes = true;
     }
     wcstombs(fs_name, wfs_name, sizeof(wfs_name));
     fs->type = g_strdup(fs_name);
-- 
2.39.5 (Apple Git-154)


