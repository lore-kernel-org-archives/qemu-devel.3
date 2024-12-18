Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB47BE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 12:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsml-0001YA-EP; Wed, 18 Dec 2024 07:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNsmD-0001V9-Ut
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:03:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNsmB-00068i-5K
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734523412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NJ8297c8r5xkp3T6CZN762sQo2LObmynWPnGlf1pTaU=;
 b=PxuSHsueVU937gETBkHYLa2kISg7awdGmo05coiQIMJzbC2tin9erNwooI5kmfN8d5Tnn1
 I8sJUS0cv7eOokEXwANQJRb0zvebISuxN+QQOxgTlWBZKJrpSXJx4vLgO3sUTXKxkjgPGy
 IH3D+sSoFd4RXyAKxokYAUknPKZqC6s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-0_D-LUO1Pb6gjtV1QNAGTg-1; Wed,
 18 Dec 2024 07:03:29 -0500
X-MC-Unique: 0_D-LUO1Pb6gjtV1QNAGTg-1
X-Mimecast-MFC-AGG-ID: 0_D-LUO1Pb6gjtV1QNAGTg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BA6D1956064; Wed, 18 Dec 2024 12:03:28 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8D3730044C1; Wed, 18 Dec 2024 12:03:26 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/3] qga: skip bind mounts in fs list
Date: Wed, 18 Dec 2024 14:03:19 +0200
Message-ID: <20241218120321.34998-2-kkostiuk@redhat.com>
In-Reply-To: <20241218120321.34998-1-kkostiuk@redhat.com>
References: <20241218120321.34998-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jean-Louis Dupond <jean-louis@dupond.be>

The filesystem list in build_fs_mount_list should skip bind mounts.
This because we end up in locking situations when doing fsFreeze. Like
mentioned in [1] and [2].

Next to that, the build_fs_mount_list call did a fallback via
build_fs_mount_list_from_mtab if mountinfo did not exist.
There it skipped bind mounts, but this is broken for newer OS.
This as mounts does not return the path of the bind mount but the
underlying dev/partition, so S_ISDIR will never return true in
dev_major_minor call.

This patch simply checks the existing devmajor:devminor tuple in the
mounts, and if it already exists, this means we have the same devices
mounted again, a bind mount. So skip this.

Same approach is used in open-vm-tools [3].

[1]: https://gitlab.com/qemu-project/qemu/-/issues/592
[2]: https://gitlab.com/qemu-project/qemu/-/issues/520
[3]: https://github.com/vmware/open-vm-tools/commit/d58847b497e212737007958c945af1df22a8ab58

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20241002100634.162499-2-jean-louis@dupond.be
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-linux.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index cf077eb03d..9e8a934b9a 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -58,6 +58,22 @@ static int dev_major_minor(const char *devpath,
     return -1;
 }
 
+/*
+ * Check if we already have the devmajor:devminor in the mounts
+ * If thats the case return true.
+ */
+static bool dev_exists(FsMountList *mounts, unsigned int devmajor, unsigned int devminor)
+{
+    FsMount *mount;
+
+    QTAILQ_FOREACH(mount, mounts, next) {
+        if (mount->devmajor == devmajor && mount->devminor == devminor) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static bool build_fs_mount_list_from_mtab(FsMountList *mounts, Error **errp)
 {
     struct mntent *ment;
@@ -88,6 +104,10 @@ static bool build_fs_mount_list_from_mtab(FsMountList *mounts, Error **errp)
             /* Skip bind mounts */
             continue;
         }
+        if (dev_exists(mounts, devmajor, devminor)) {
+            /* Skip already existing devices (bind mounts) */
+            continue;
+        }
 
         mount = g_new0(FsMount, 1);
         mount->dirname = g_strdup(ment->mnt_dir);
@@ -171,6 +191,11 @@ bool build_fs_mount_list(FsMountList *mounts, Error **errp)
             }
         }
 
+        if (dev_exists(mounts, devmajor, devminor)) {
+            /* Skip already existing devices (bind mounts) */
+            continue;
+        }
+
         mount = g_new0(FsMount, 1);
         mount->dirname = g_strdup(line + dir_s);
         mount->devtype = g_strdup(dash + type_s);
-- 
2.47.1


