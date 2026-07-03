Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70783C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgp1-0003To-SA; Fri, 03 Jul 2026 12:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1wfgp0-0003Sk-87
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:32:58 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1wfgox-0005E2-MZ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:32:57 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c029505b389so263638066b.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783096373; x=1783701173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/7FC3+hcII7PbFGAgumtBIZjbzmSfLIy5pHfi3j33YY=;
 b=FQU3Gj/1bjxTGyAVSjhE4u9ImZpzNaGyIFQriTY/1i4cr3yo0UypvrO5JwTI556mhS
 g5KoEDtinSjvxwsCfJKzx+H3YtxMWuPA707L72JOR8y4PmOU9vpKwv6AuyH+P8A3Dlec
 Rh1L5Mt7wS6gVKY4hSfHYS1JiJhD+mjbV11sb2gJm21rkhbIrKnsdZA5RuYzHBUYs6Wm
 QRl9C9RLTe4CLYVP+xmLp2frpIa6hEKb/jSr5Pq8Wh4dEzevnEGv8nSmQsSyakJsPuqG
 fdatHKFfoRQnwawV4PMdgh5eOqdGiX++7ZEPBUKI+Jou0KUPmbB3c7haUqCT8QOi7Jvh
 bM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096373; x=1783701173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7FC3+hcII7PbFGAgumtBIZjbzmSfLIy5pHfi3j33YY=;
 b=V0Jc8Kp4ZUEdBrPFkKdp3gMK6J9WcQAf7h0nC0SjYsnBNUDKVHmQzZ1BRFAzOYC/V0
 7loyzpXR5ylN35pVYbgXZNxamTiY3xEwPnEeXqXAuTpiyjM2e++wZkq6bdVkUY2bO2GV
 ARIGIQixZeF+I9BpXUQ7NUcNJ+Ym03briWlVWHYlo2ISolF5xhN/ykeZxNGL6nZjvPND
 jMH82EKCtgtqzgMqvkY4bveeA3yVflRPu0nd7Pi7yPPXmNeREEgID1pDqa0k/t3aAcS9
 Wm8xw6iMQSbGgojiJ2Q4oUtfeHcMXpLuTjznyDSeV+UF86MTq8Rk9dlCdW/f3yJFkX8s
 ti3w==
X-Gm-Message-State: AOJu0Yx58QIZgdSwbFQq7TwuULNcQXQc6SeuBDxggtiyloDK0rNHUK3V
 2+WvEYudLEwp8BGbpWC1rmQiTFsPCBMhhluJt7YfV1edsOHBICmGJNiysiRmKogpkIc=
X-Gm-Gg: AfdE7clxHoJKjTvz3yu3FzaVHq6LJr8FTIjHVX7x1Bd373CACPsBR1tCl5byMEHIGqj
 Ex37+gc1RV8Ng8P89uWB37Gg7hO9Y3+ONWa6d/eOtBlweJtS5ouhK0V//JjenhSRFlzZfklf0kI
 LYFr3lpAPkkfso5BuXoZKAJXBQN4R2NVKzhlGu3uF3at/vICL3GBfOzQT96fwyunTAb+fajC22p
 TWST0FUavQtLU8CSOi78pYrjMgJsmhMj37IqvqkHvM87f12L4eZEeWXBFe0m3R9tr/p8nYnURqz
 lYjLooec4oKo4EYdtPhYte2+nur+73dwCf8/65xb2fiDOqDzOmlEQ6e788StVdktvIj4GXnl69B
 jJvw90HUaRz/+/qjufVpP66Pfw3NpeV9U0NNZ6MqU4n4ZbW1CPmIEwE3dsBbfjZ3gLkgC30HssY
 YsZ6lR4ebt5Gp7OmDA4r6dCWrWFHJcfLDpRzh63X2xWgCIPFt6rQIaJ11qILtXGcvja3egzkAG5
 TNnJuxRJilq48EmyN9tK0k55Ws=
X-Received: by 2002:a17:907:e105:b0:c12:34c3:a452 with SMTP id
 a640c23a62f3a-c12c9b573d2mr154402466b.0.1783096372656; 
 Fri, 03 Jul 2026 09:32:52 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-ee82-4536-a8f2-9e22.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:ee82:4536:a8f2:9e22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62f38f3sm309931466b.57.2026.07.03.09.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 09:32:52 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2] qga: implement 'guest-get-fsinfo' for FreeBSD
Date: Fri,  3 Jul 2026 18:31:07 +0200
Message-ID: <20260703163107.46469-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Implement the qmp_guest_get_fsinfo() API for FreeBSD.
To implement it, reuse build_fs_mount_list() which is already
implemented for FreeBSD. Extend the FsMount type to include
a string "fromname" attribute to store the disk the FS is mounted from.

Disk mapping info is not covered by this implementation.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
Changes since v1:

 - Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo


 qga/commands-bsd.c    | 62 ++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-common.h |  1 +
 qga/commands-posix.c  |  3 +++
 qga/qapi-schema.json  | 12 ++++-----
 4 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 94ff6fee6a..7f65f2b8db 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -20,6 +20,7 @@
 #include <sys/ucred.h>
 #include <sys/mount.h>
 #include <net/if_dl.h>
+#include <sys/statvfs.h>
 #if defined(__NetBSD__) || defined(__OpenBSD__)
 #include <net/if_arp.h>
 #include <netinet/if_ether.h>
@@ -28,7 +29,7 @@
 #endif
 #include <paths.h>
 
-#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
+#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM) || defined(__FreeBSD__)
 bool build_fs_mount_list(FsMountList *mounts, Error **errp)
 {
     FsMount *mount;
@@ -55,6 +56,7 @@ bool build_fs_mount_list(FsMountList *mounts, Error **errp)
 
         mount->dirname = g_strdup(mntp->f_mntonname);
         mount->devtype = g_strdup(mntp->f_fstypename);
+        mount->fromname = g_strdup(mntp->f_mntfromname);
         mount->devmajor = major(mount->dev);
         mount->devminor = minor(mount->dev);
         mount->fsid = mntp->f_fsid;
@@ -178,3 +180,61 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned char *buf,
     return true;
 }
 #endif /* HAVE_GETIFADDRS */
+
+#if defined(__FreeBSD__)
+static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
+                                               Error **errp)
+{
+    GuestFilesystemInfo *fs = g_new0(GuestFilesystemInfo, 1);
+    struct statvfs buf;
+    unsigned long used, nonroot_total, fr_size;
+
+    fs->mountpoint = g_strdup(mount->dirname);
+    fs->type = g_strdup(mount->devtype);
+    fs->name = g_strdup(g_path_get_basename(mount->fromname));
+
+    if (statvfs(fs->mountpoint, &buf) == 0) {
+        fr_size = buf.f_frsize;
+        used = buf.f_blocks - buf.f_bfree;
+        nonroot_total = used + buf.f_bavail;
+        fs->used_bytes = used * fr_size;
+        fs->total_bytes = nonroot_total * fr_size;
+        fs->total_bytes_privileged = buf.f_blocks * fr_size;
+
+        fs->has_total_bytes = true;
+        fs->has_total_bytes_privileged = true;
+        fs->has_used_bytes = true;
+    }
+
+    return fs;
+}
+
+GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
+{
+    FsMountList mounts;
+    struct FsMount *mount;
+    GuestFilesystemInfoList *ret = NULL;
+    Error *local_err = NULL;
+
+    QTAILQ_INIT(&mounts);
+    if (!build_fs_mount_list(&mounts, &local_err)) {
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    QTAILQ_FOREACH(mount, &mounts, next) {
+        g_debug("Building guest fsinfo for '%s'", mount->dirname);
+
+        QAPI_LIST_PREPEND(ret, build_guest_fsinfo(mount, &local_err));
+        if (local_err) {
+            error_propagate(errp, local_err);
+            qapi_free_GuestFilesystemInfoList(ret);
+            ret = NULL;
+            break;
+        }
+    }
+
+    free_fs_mount_list(&mounts);
+    return ret;
+}
+#endif /* __FreeBSD__ */
diff --git a/qga/commands-common.h b/qga/commands-common.h
index 263e7c0525..a07d0885f5 100644
--- a/qga/commands-common.h
+++ b/qga/commands-common.h
@@ -29,6 +29,7 @@ typedef struct FsMount {
 #if defined(__FreeBSD__)
     dev_t dev;
     fsid_t fsid;
+    char *fromname;
 #endif
     QTAILQ_ENTRY(FsMount) next;
 } FsMount;
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 837be51c40..837e285b6d 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -731,6 +731,9 @@ void free_fs_mount_list(FsMountList *mounts)
          QTAILQ_REMOVE(mounts, mount, next);
          g_free(mount->dirname);
          g_free(mount->devtype);
+#if defined(__FreeBSD__)
+         g_free(mount->fromname);
+#endif
          g_free(mount);
      }
 }
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c57bc9a02f..8cd0ba048b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -874,7 +874,7 @@
   'data': [ 'ide', 'fdc', 'scsi', 'virtio', 'xen', 'usb', 'uml', 'sata',
             'sd', 'unknown', 'ieee1394', 'ssa', 'fibre', 'raid', 'iscsi',
             'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestPCIAddress:
@@ -892,7 +892,7 @@
 { 'struct': 'GuestPCIAddress',
   'data': {'domain': 'int', 'bus': 'int',
            'slot': 'int', 'function': 'int'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestCCWAddress:
@@ -912,7 +912,7 @@
            'ssid': 'int',
            'subchno': 'int',
            'devno': 'int'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestDiskAddress:
@@ -942,7 +942,7 @@
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str',
            '*ccw-address': 'GuestCCWAddress'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestNVMeSmart:
@@ -1063,7 +1063,7 @@
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
            '*used-bytes': 'uint64', '*total-bytes': 'uint64',
            '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @guest-get-fsinfo:
@@ -1077,7 +1077,7 @@
 ##
 { 'command': 'guest-get-fsinfo',
   'returns': ['GuestFilesystemInfo'],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @guest-set-user-password:
-- 
2.52.0


