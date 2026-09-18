Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F08C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7fjf-0006xl-BR; Fri, 18 Sep 2026 17:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1x7fjc-0006xK-Gx
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 17:03:04 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1x7fjW-000296-5P
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 17:03:01 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4hmlSm3Dcgz8PbR;
 Fri, 18 Sep 2026 17:02:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=BShrA4pzR3oXbQSU5TrSUAV7Gpc8OTMZBKlE1MjipzI=; b=bMhf
 u2QvWll7gjXcTy9H3TM+NgkLUB0yhdV4r7AMYZTvyAEQTvU9K4n/Blf3LOLw4xit
 kQNEmyh+lI6ux12JeQc7Jp02tq3umivuP88JQVZf5CobCrn11q7uVyEqUN5RbneH
 mogh/eGswC6VYpaRcLKWniAQINg/4vdccmOqaOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=olrJNQmTXop0jqpJO1+dwARbGnmyU7v4AxpnyzDOmfZkbQlB7TE3T
 p8nE93RImifMB7W+FwGcMup6kHDV4VcAGxMI5kh85VK0lFowpWYIde2jOmANTxnU
 jDeT5aVAmLnl2v/icDVNeJXA+eOlFtwTFlKOMmTi9AS74rZB4jBj3k=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:855b:b772:3733:23e1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4hmlSm236kz8PbQ;
 Fri, 18 Sep 2026 17:02:48 -0400 (EDT)
Date: Fri, 18 Sep 2026 17:02:47 -0400
From: Brad Smith <brad@comstyle.com>
To: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] qga: implement 'guest-get-fsinfo' for NetBSD and OpenBSD
Message-ID: <aq2m9yuSGK0m2zRb@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

qga: implement 'guest-get-fsinfo' for NetBSD and OpenBSD

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 qga/commands-bsd.c    | 19 +++++++++++++------
 qga/commands-common.h | 12 +++++++-----
 qga/commands-posix.c  |  4 ++--
 qga/qapi-schema.json  | 12 ++++++------
 4 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 1c51d099eb..0c6caec4a3 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -28,12 +28,20 @@
 #include <net/ethernet.h>
 #endif
 #include <paths.h>
+#ifdef __FreeBSD__
+#include <ufs/ffs/fs.h>
+#endif
+
+#ifdef __NetBSD__
+typedef struct statvfs bsd_fsinfo_t;
+#else
+typedef struct statfs bsd_fsinfo_t;
+#endif
 
-#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM) || defined(__FreeBSD__)
 bool build_fs_mount_list(FsMountList *mounts, Error **errp)
 {
     FsMount *mount;
-    struct statfs *mntbuf, *mntp;
+    bsd_fsinfo_t *mntbuf, *mntp;
     struct stat statbuf;
     int i, count, ret;
 
@@ -57,16 +65,17 @@ bool build_fs_mount_list(FsMountList *mounts, Error **errp)
         mount->dirname = g_strdup(mntp->f_mntonname);
         mount->devtype = g_strdup(mntp->f_fstypename);
         mount->fromname = g_strdup(mntp->f_mntfromname);
+        mount->dev = statbuf.st_dev;
         mount->devmajor = major(mount->dev);
         mount->devminor = minor(mount->dev);
+#ifdef CONFIG_FSFREEZE
         mount->fsid = mntp->f_fsid;
-        mount->dev = statbuf.st_dev;
+#endif
 
         QTAILQ_INSERT_TAIL(mounts, mount, next);
     }
     return true;
 }
-#endif /* CONFIG_FSFREEZE || CONFIG_FSTRIM */
 
 #if defined(CONFIG_FSFREEZE)
 static int ufssuspend_fd = -1;
@@ -181,7 +190,6 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned char *buf,
 }
 #endif /* HAVE_GETIFADDRS */
 
-#if defined(__FreeBSD__)
 static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount)
 {
     GuestFilesystemInfo *fs = g_new0(GuestFilesystemInfo, 1);
@@ -228,4 +236,3 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
     free_fs_mount_list(&mounts);
     return ret;
 }
-#endif /* __FreeBSD__ */
diff --git a/qga/commands-common.h b/qga/commands-common.h
index a07d0885f5..0d3c69b480 100644
--- a/qga/commands-common.h
+++ b/qga/commands-common.h
@@ -18,17 +18,19 @@
 #endif /* __linux__ */
 
 #ifdef __FreeBSD__
-#include <ufs/ffs/fs.h>
+#include <sys/mount.h>
 #endif /* __FreeBSD__ */
 
-#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
+#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM) || defined(CONFIG_BSD)
 typedef struct FsMount {
     char *dirname;
     char *devtype;
     unsigned int devmajor, devminor;
-#if defined(__FreeBSD__)
-    dev_t dev;
+#ifdef __FreeBSD__
     fsid_t fsid;
+#endif
+#ifdef CONFIG_BSD
+    dev_t dev;
     char *fromname;
 #endif
     QTAILQ_ENTRY(FsMount) next;
@@ -38,7 +40,7 @@ typedef QTAILQ_HEAD(FsMountList, FsMount) FsMountList;
 
 bool build_fs_mount_list(FsMountList *mounts, Error **errp);
 void free_fs_mount_list(FsMountList *mounts);
-#endif /* CONFIG_FSFREEZE || CONFIG_FSTRIM */
+#endif /* CONFIG_FSFREEZE || CONFIG_FSTRIM || CONFIG_BSD */
 
 #if defined(CONFIG_FSFREEZE)
 int64_t qmp_guest_fsfreeze_do_freeze_list(bool has_mountpoints,
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 837e285b6d..dcc683f6c9 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -718,7 +718,7 @@ void qmp_guest_file_flush(int64_t handle, Error **errp)
     }
 }
 
-#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
+#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM) || defined(CONFIG_BSD)
 void free_fs_mount_list(FsMountList *mounts)
 {
      FsMount *mount, *temp;
@@ -731,7 +731,7 @@ void free_fs_mount_list(FsMountList *mounts)
          QTAILQ_REMOVE(mounts, mount, next);
          g_free(mount->dirname);
          g_free(mount->devtype);
-#if defined(__FreeBSD__)
+#ifdef CONFIG_BSD
          g_free(mount->fromname);
 #endif
          g_free(mount);
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 8cd0ba048b..fb640ea1bc 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -874,7 +874,7 @@
   'data': [ 'ide', 'fdc', 'scsi', 'virtio', 'xen', 'usb', 'uml', 'sata',
             'sd', 'unknown', 'ieee1394', 'ssa', 'fibre', 'raid', 'iscsi',
             'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @GuestPCIAddress:
@@ -892,7 +892,7 @@
 { 'struct': 'GuestPCIAddress',
   'data': {'domain': 'int', 'bus': 'int',
            'slot': 'int', 'function': 'int'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @GuestCCWAddress:
@@ -912,7 +912,7 @@
            'ssid': 'int',
            'subchno': 'int',
            'devno': 'int'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @GuestDiskAddress:
@@ -942,7 +942,7 @@
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str',
            '*ccw-address': 'GuestCCWAddress'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @GuestNVMeSmart:
@@ -1063,7 +1063,7 @@
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
            '*used-bytes': 'uint64', '*total-bytes': 'uint64',
            '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @guest-get-fsinfo:
@@ -1077,7 +1077,7 @@
 ##
 { 'command': 'guest-get-fsinfo',
   'returns': ['GuestFilesystemInfo'],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @guest-set-user-password:
-- 
2.55.0


