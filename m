Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07156C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RGq-0007yE-8k; Tue, 15 Sep 2026 07:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RGi-0007xG-AG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RGg-0001mR-Gh
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789471445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTlYybsMXAYvZF3UQHED8ZeGGlyjUpO5NQlKib95GMY=;
 b=E+A+0o0vX39DJ6OSFhwQd9i1vik8+y+Ocjj9GzgefmtTka8tmToHNVOV4bbxhzpJoHiSEd
 jEeslHSyjtUS2rUBdlORRFWQoA/ym4I9tw5fy+ls6Gtj8NxEboLjN8kNs4X6CDeEpSN5Pq
 q1gN4IixdGVLgkwjIWlY6fSn+ETfbP0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-SEbvNW5RO0eVp-Jr1ZuwmQ-1; Tue,
 15 Sep 2026 07:24:04 -0400
X-MC-Unique: SEbvNW5RO0eVp-Jr1ZuwmQ-1
X-Mimecast-MFC-AGG-ID: SEbvNW5RO0eVp-Jr1ZuwmQ_1789471443
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BD6B1800762; Tue, 15 Sep 2026 11:24:03 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.49.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F7C51956045; Tue, 15 Sep 2026 11:24:01 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/19] qga: implement 'guest-get-fsinfo' for FreeBSD
Date: Tue, 15 Sep 2026 14:23:19 +0300
Message-ID: <20260915112337.43307-2-kkostiuk@redhat.com>
In-Reply-To: <20260915112337.43307-1-kkostiuk@redhat.com>
References: <20260915112337.43307-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Roman Bogorodskiy <bogorodskiy@gmail.com>

Implement the qmp_guest_get_fsinfo() API for FreeBSD.
To implement it, reuse build_fs_mount_list() which is already
implemented for FreeBSD. Extend the FsMount type to include
a string "fromname" attribute to store the disk the FS is mounted from.

Disk mapping info is not covered by this implementation.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260714165759.7521-1-bogorodskiy@gmail.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-bsd.c    | 53 ++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-common.h |  1 +
 qga/commands-posix.c  |  3 +++
 qga/qapi-schema.json  | 12 +++++-----
 4 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 94ff6fee6a..1c51d099eb 100644
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
@@ -178,3 +180,52 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned char *buf,
     return true;
 }
 #endif /* HAVE_GETIFADDRS */
+
+#if defined(__FreeBSD__)
+static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount)
+{
+    GuestFilesystemInfo *fs = g_new0(GuestFilesystemInfo, 1);
+    struct statvfs buf;
+    unsigned long used, nonroot_total, fr_size;
+
+    fs->mountpoint = g_strdup(mount->dirname);
+    fs->type = g_strdup(mount->devtype);
+    fs->name = g_path_get_basename(mount->fromname);
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
+
+    QTAILQ_INIT(&mounts);
+    if (!build_fs_mount_list(&mounts, errp)) {
+        return NULL;
+    }
+
+    QTAILQ_FOREACH(mount, &mounts, next) {
+        g_debug("Building guest fsinfo for '%s'", mount->dirname);
+
+        QAPI_LIST_PREPEND(ret, build_guest_fsinfo(mount));
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
2.55.0


