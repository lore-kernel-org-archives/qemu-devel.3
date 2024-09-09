Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACEBECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 01:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snTg8-0002GG-Dm; Sun, 08 Sep 2024 21:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1snTg6-0002DI-Cg; Sun, 08 Sep 2024 21:58:54 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1snTg4-0008Sf-KP; Sun, 08 Sep 2024 21:58:54 -0400
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-710d77380cdso1063255a34.0; 
 Sun, 08 Sep 2024 18:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725847130; x=1726451930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1fDpIFkXrtKBjuZpn8QBVCrC62AVy27Y8kRr1xGQCH4=;
 b=HTjcy3cM14fLqtnvP69irS5Aa1wcgI4bmJ3soaujb0CJmY1wud8KU3/7FQ3mN7hkmr
 uaGkrbshiR33x8sgYSNLQqJq0xYh4ZVBbEm3kjz1BgcymvPI191Wcbn5KbkcgGSW8tsw
 YSKOkBgCt00T8l1djLFwQqW8t3SZV01IXyGmCez3Lha0BFcU9q524Ac2964w5QC+a5kb
 Sb0TnhJvYwkULTmB9FdLhJHY1l/4nb9Euu+tD6deFf04DnrIURQ/YUj7a4OHX4LSSa/U
 cEn+CufJnMzcU/B0huvUCDjTBFEwb1BgofwXNATpNyjDsO2wGOkh4TkmLciCbZ9QlnVI
 uGeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4jdABVX78fjIaq0n2y9fPZ9HOt73ZmLlDm20aK4XdD1txy7R+8q1jrMXgyjD2SYBddP3b1Ki723+D@nongnu.org
X-Gm-Message-State: AOJu0YwEM7/BxYkYhZsXmA+4mMi8Qafa0koi7MNRCIW9DWJx/NT7qQCE
 3nqkQHqjHSVVQJVabUAlAsALbIrc1BL3pBdtnyJa2yDD646WJ3RUaehJwg==
X-Google-Smtp-Source: AGHT+IHqzJH2W3gyizk7IbOmxuAoJhCbbcY85qa2otUQ5Sakj04ZdC/8yN1IyvHfjF33CeRVRbmmxw==
X-Received: by 2002:a05:6358:3426:b0:1b5:ec84:f034 with SMTP id
 e5c5f4694b2df-1b8386f5465mr1250506155d.24.1725847130009; 
 Sun, 08 Sep 2024 18:58:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c00:895d:3920:b9d8:bb69:a606])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e5982e57sm2546110b3a.156.2024.09.08.18.58.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Sep 2024 18:58:49 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH] block: support locking on change medium
Date: Sun,  8 Sep 2024 18:58:47 -0700
Message-ID: <20240909015847.40377-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.47; envelope-from=osy86dev@gmail.com;
 helo=mail-ot1-f47.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

New optional argument for 'blockdev-change-medium' QAPI command to allow
the caller to specify if they wish to enable file locking.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 qapi/block.json                | 23 ++++++++++++++++++++++-
 block/monitor/block-hmp-cmds.c |  2 +-
 block/qapi-sysemu.c            | 22 ++++++++++++++++++++++
 ui/cocoa.m                     |  1 +
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index e66666f5c6..35e8e2e191 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -309,6 +309,23 @@
 { 'enum': 'BlockdevChangeReadOnlyMode',
   'data': ['retain', 'read-only', 'read-write'] }
 
+##
+# @BlockdevChangeFileLockingMode:
+#
+# Specifies the new locking mode of a file image passed to the
+# @blockdev-change-medium command.
+#
+# @auto: Use locking if API is available
+#
+# @off: Disable file image locking
+#
+# @on: Enable file image locking
+#
+# Since: 9.2
+##
+{ 'enum': 'BlockdevChangeFileLockingMode',
+  'data': ['auto', 'off', 'on'] }
+
 ##
 # @blockdev-change-medium:
 #
@@ -330,6 +347,9 @@
 # @read-only-mode: change the read-only mode of the device; defaults
 #     to 'retain'
 #
+# @file-locking-mode: change the locking mode of the file image; defaults
+#     to 'auto' (since: 9.2)
+#
 # @force: if false (the default), an eject request through
 #     blockdev-open-tray will be sent to the guest if it has locked
 #     the tray (and the tray will not be opened immediately); if true,
@@ -378,7 +398,8 @@
             'filename': 'str',
             '*format': 'str',
             '*force': 'bool',
-            '*read-only-mode': 'BlockdevChangeReadOnlyMode' } }
+            '*read-only-mode': 'BlockdevChangeReadOnlyMode',
+            '*file-locking-mode': 'BlockdevChangeFileLockingMode' } }
 
 ##
 # @DEVICE_TRAY_MOVED:
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index bdf2eb50b6..ff64020a80 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -1007,5 +1007,5 @@ void hmp_change_medium(Monitor *mon, const char *device, const char *target,
     }
 
     qmp_blockdev_change_medium(device, NULL, target, arg, true, force,
-                               !!read_only, read_only_mode, errp);
+                               !!read_only, read_only_mode, false, 0, errp);
 }
diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
index e4282631d2..8064bdfb3a 100644
--- a/block/qapi-sysemu.c
+++ b/block/qapi-sysemu.c
@@ -311,6 +311,8 @@ void qmp_blockdev_change_medium(const char *device,
                                 bool has_force, bool force,
                                 bool has_read_only,
                                 BlockdevChangeReadOnlyMode read_only,
+                                bool has_file_locking_mode,
+                                BlockdevChangeFileLockingMode file_locking_mode,
                                 Error **errp)
 {
     BlockBackend *blk;
@@ -362,6 +364,26 @@ void qmp_blockdev_change_medium(const char *device,
         qdict_put_str(options, "driver", format);
     }
 
+    if (!has_file_locking_mode) {
+        file_locking_mode = BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO;
+    }
+
+    switch (file_locking_mode) {
+    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO:
+        break;
+
+    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_OFF:
+        qdict_put_str(options, "file.locking", "off");
+        break;
+
+    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_ON:
+        qdict_put_str(options, "file.locking", "on");
+        break;
+
+    default:
+        abort();
+    }
+
     medium_bs = bdrv_open(filename, NULL, options, bdrv_flags, errp);
 
     if (!medium_bs) {
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4c2dd33532..6e73c6e13e 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1611,6 +1611,7 @@ - (void)changeDeviceMedia:(id)sender
                                        "raw",
                                        true, false,
                                        false, 0,
+                                       false, 0,
                                        &err);
         });
         handleAnyDeviceErrors(err);
-- 
2.41.0


