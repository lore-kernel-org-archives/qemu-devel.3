Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBF606A33A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gAGU1cf9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM0B5-000750-Sg; Wed, 28 Oct 2026 05:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0Ac-0006sU-AZ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0AZ-0008R2-Oa
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793180526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sx+oQj4Xo2sYOUw/rp5gYWjgUJbUaulKuWXDuC4vCkE=;
 b=gAGU1cf9iU7+FY5Hk9OD6Zg+xcOs8S4Fuq0EE8IukvgllD0HD+UfMeDAXa00OIMc93EELF
 iBsmfchGaEff30XOGImXPUpImc0S2oRW2+TW4tpGQ5ASYolUnfF/b//lc7FKmYCkgUT6PW
 qudJ5NOi7f3guqJj3tzcuuVn1SAlnOY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-L_HU3iM2PF26TaZFLGkuow-1; Wed,
 28 Oct 2026 05:42:03 -0400
X-MC-Unique: L_HU3iM2PF26TaZFLGkuow-1
X-Mimecast-MFC-AGG-ID: L_HU3iM2PF26TaZFLGkuow_1793180522
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 920221800BD1; Wed, 28 Oct 2026 09:42:02 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F4D61956086; Wed, 28 Oct 2026 09:42:01 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/6] qga: implement 'guest-get-diskstats' for FreeBSD
Date: Wed, 28 Oct 2026 11:41:49 +0200
Message-ID: <20261028094152.14934-4-kkostiuk@redhat.com>
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

From: Roman Bogorodskiy <bogorodskiy@gmail.com>

Implement the 'guest-get-diskstats' for FreeBSD.
This implementation uses the devstat(3) library which is a part
of the FreeBSD base system.

The build system is updated to link qga with `-ldevstat`.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901192732.46190-1-bogorodskiy@gmail.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-bsd.c   | 121 ++++++++++++++++++++++++++++++++++++++++++-
 qga/meson.build      |   3 ++
 qga/qapi-schema.json |   6 +--
 3 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 0c6caec4a3..7c7616699b 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -14,6 +14,7 @@
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
+#include "block/block-common.h"
 #include "commands-common.h"
 #include <sys/ioctl.h>
 #include <sys/param.h>
@@ -31,12 +32,14 @@
 #ifdef __FreeBSD__
 #include <ufs/ffs/fs.h>
 #endif
-
 #ifdef __NetBSD__
 typedef struct statvfs bsd_fsinfo_t;
 #else
 typedef struct statfs bsd_fsinfo_t;
 #endif
+#ifdef CONFIG_FREEBSD
+#include <devstat.h>
+#endif
 
 bool build_fs_mount_list(FsMountList *mounts, Error **errp)
 {
@@ -236,3 +239,119 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
     free_fs_mount_list(&mounts);
     return ret;
 }
+
+#ifdef CONFIG_FREEBSD
+static uint64_t bintime_to_msec(const struct bintime *bt)
+{
+    return (uint64_t)bt->sec * 1000ULL + (((bt->frac >> 32) * 1000ULL) >> 32);
+}
+
+static GuestDiskStatsInfo *
+guest_diskstats_info_new(const struct devstat *dev)
+{
+    GuestDiskStatsInfo *diskstatinfo;
+    GuestDiskStats *diskstat;
+
+    diskstatinfo = g_new0(GuestDiskStatsInfo, 1);
+    diskstatinfo->name = g_strdup_printf("%s%d", dev->device_name,
+                                         dev->unit_number);
+    /*
+     * devstat does not expose Linux-style major/minor numbers.  Report the
+     * devstat device number and unit number in these mandatory QAPI fields.
+     */
+    diskstatinfo->major = dev->device_number;
+    diskstatinfo->minor = dev->unit_number;
+
+    diskstat = g_new0(GuestDiskStats, 1);
+    diskstat->has_read_ios = true;
+    diskstat->read_ios = dev->operations[DEVSTAT_READ];
+    diskstat->has_read_sectors = true;
+    diskstat->read_sectors = dev->bytes[DEVSTAT_READ] / BDRV_SECTOR_SIZE;
+    diskstat->has_read_ticks = true;
+    diskstat->read_ticks = bintime_to_msec(&dev->duration[DEVSTAT_READ]);
+
+    diskstat->has_write_ios = true;
+    diskstat->write_ios = dev->operations[DEVSTAT_WRITE];
+    diskstat->has_write_sectors = true;
+    diskstat->write_sectors = dev->bytes[DEVSTAT_WRITE] / BDRV_SECTOR_SIZE;
+    diskstat->has_write_ticks = true;
+    diskstat->write_ticks = bintime_to_msec(&dev->duration[DEVSTAT_WRITE]);
+
+    diskstat->has_discard_ios = true;
+    diskstat->discard_ios = dev->operations[DEVSTAT_FREE];
+    diskstat->has_discard_sectors = true;
+    diskstat->discard_sectors = dev->bytes[DEVSTAT_FREE] / BDRV_SECTOR_SIZE;
+    diskstat->has_discard_ticks = true;
+    diskstat->discard_ticks = bintime_to_msec(&dev->duration[DEVSTAT_FREE]);
+
+    diskstat->has_ios_pgr = true;
+    diskstat->ios_pgr = dev->start_count - dev->end_count;
+
+    diskstat->has_total_ticks = true;
+    diskstat->total_ticks = bintime_to_msec(&dev->busy_time);
+
+    diskstatinfo->stats = diskstat;
+    return diskstatinfo;
+}
+
+GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
+{
+    GuestDiskStatsInfoList *head = NULL, **tail = &head;
+    struct devinfo dinfo = { 0 };
+    struct statinfo stats = { .dinfo = &dinfo };
+    struct device_selection *dev_select = NULL;
+    struct devstat_match matches[] = {
+        {
+            .match_fields = DEVSTAT_MATCH_TYPE,
+            .device_type = DEVSTAT_TYPE_DIRECT,
+            .num_match_categories = 1,
+        },
+    };
+    int num_selected = 0;
+    int num_selections = 0;
+    long select_generation = 0;
+    int i;
+
+    if (devstat_checkversion(NULL) == -1) {
+        error_setg(errp, "%s", devstat_errbuf);
+        return NULL;
+    }
+
+    if (devstat_getdevs(NULL, &stats) == -1) {
+        error_setg(errp, "%s", devstat_errbuf);
+        goto error;
+    }
+
+    if (devstat_selectdevs(&dev_select, &num_selected, &num_selections,
+                           &select_generation, stats.dinfo->generation,
+                           stats.dinfo->devices, stats.dinfo->numdevs,
+                           matches, ARRAY_SIZE(matches), NULL, 0,
+                           DS_SELECT_ONLY,
+                           stats.dinfo->numdevs, 0) == -1) {
+        error_setg(errp, "%s", devstat_errbuf);
+        goto error;
+    }
+
+    for (i = 0; i < num_selections; i++) {
+        const struct devstat *dev;
+
+        if (dev_select[i].selected == 0) {
+            continue;
+        }
+
+        dev = &stats.dinfo->devices[dev_select[i].position];
+        QAPI_LIST_APPEND(tail, guest_diskstats_info_new(dev));
+    }
+
+    free(stats.dinfo->mem_ptr);
+    free(dev_select);
+    return head;
+
+error:
+    qapi_free_GuestDiskStatsInfoList(head);
+    free(stats.dinfo->mem_ptr);
+    free(dev_select);
+    return NULL;
+}
+
+#endif /* CONFIG_FREEBSD */
diff --git a/qga/meson.build b/qga/meson.build
index cfa2157efb..a046ebe305 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -93,6 +93,9 @@ qga_ss = qga_ss.apply({})
 
 gen_tlb = []
 qga_libs = []
+if host_os == 'freebsd'
+  qga_libs += ['-ldevstat']
+endif
 if host_os == 'windows'
   qga_libs += ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '-lwininet', '-liphlpapi', '-lnetapi32',
                '-lsetupapi', '-lcfgmgr32', '-luserenv', '-lpdh' ]
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index d81b57de53..308ed9acf1 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1666,7 +1666,7 @@
            '*total-ticks': 'uint64',
            '*weight-ticks': 'uint64'
            },
-  'if': 'CONFIG_LINUX' }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
 
 ##
 # @GuestDiskStatsInfo:
@@ -1684,7 +1684,7 @@
            'major': 'uint64',
            'minor': 'uint64',
            'stats': 'GuestDiskStats' },
-  'if': 'CONFIG_LINUX' }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
 
 ##
 # @guest-get-diskstats:
@@ -1696,7 +1696,7 @@
 ##
 { 'command': 'guest-get-diskstats',
   'returns': ['GuestDiskStatsInfo'],
-  'if': 'CONFIG_LINUX'
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] }
 }
 
 ##
-- 
2.54.0 (Apple Git-157)


