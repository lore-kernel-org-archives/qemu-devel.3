Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39960A2624
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WCi6nSM1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM0Al-0006ya-Sq; Wed, 28 Oct 2026 05:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0Aa-0006qk-9X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0AX-0008Qr-QS
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793180523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zfquhvBWrOcEPjTAE/Y7Sndk6dq4R3rCiWhEHx47XM=;
 b=WCi6nSM1nb3/68n1gRsN1xtyfGcMYnKB36imki70jiq0c8mb6t0rtsrSIbx//ZwmQW0XAi
 X7zUIllqMaoWJTXoJqYkRtnJ3KFOXdcg+yPSqeAet2YaQaVId9HTsQQH/YD2rXb+K9qhjS
 0vLqx2TsrdUNVjN9GwHZymnREQoqhL0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-4pKYPs6cO_O1HV4jL3CiwA-1; Wed,
 28 Oct 2026 05:42:00 -0400
X-MC-Unique: 4pKYPs6cO_O1HV4jL3CiwA-1
X-Mimecast-MFC-AGG-ID: 4pKYPs6cO_O1HV4jL3CiwA_1793180519
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8A4B18011D2; Wed, 28 Oct 2026 09:41:58 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 900A41956086; Wed, 28 Oct 2026 09:41:57 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/6] qga: implement 'guest-get-fsinfo' for NetBSD and OpenBSD
Date: Wed, 28 Oct 2026 11:41:47 +0200
Message-ID: <20261028094152.14934-2-kkostiuk@redhat.com>
In-Reply-To: <20261028094152.14934-1-kkostiuk@redhat.com>
References: <20261028094152.14934-1-kkostiuk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Brad Smith <brad@comstyle.com>

qga: implement 'guest-get-fsinfo' for NetBSD and OpenBSD

Signed-off-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/aq2m9yuSGK0m2zRb@humpty.home.comstyle.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
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
index 05fe4ea484..d81b57de53 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -844,7 +844,7 @@
   'data': [ 'ide', 'fdc', 'scsi', 'virtio', 'xen', 'usb', 'uml', 'sata',
             'sd', 'unknown', 'ieee1394', 'ssa', 'fibre', 'raid', 'iscsi',
             'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @GuestPCIAddress:
@@ -862,7 +862,7 @@
 { 'struct': 'GuestPCIAddress',
   'data': {'domain': 'int', 'bus': 'int',
            'slot': 'int', 'function': 'int'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @GuestCCWAddress:
@@ -882,7 +882,7 @@
            'ssid': 'int',
            'subchno': 'int',
            'devno': 'int'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @GuestDiskAddress:
@@ -912,7 +912,7 @@
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str',
            '*ccw-address': 'GuestCCWAddress'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @GuestNVMeSmart:
@@ -1031,7 +1031,7 @@
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
            '*used-bytes': 'uint64', '*total-bytes': 'uint64',
            '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @guest-get-fsinfo:
@@ -1045,7 +1045,7 @@
 ##
 { 'command': 'guest-get-fsinfo',
   'returns': ['GuestFilesystemInfo'],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_BSD' ] } }
 
 ##
 # @guest-set-user-password:
-- 
2.54.0 (Apple Git-157)


