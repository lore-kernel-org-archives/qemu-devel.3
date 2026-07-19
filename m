Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88627C4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlTzw-0005rn-8d; Sun, 19 Jul 2026 12:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1wlTzu-0005rR-8b
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:04:10 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1wlTzs-0001QC-8k
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:04:09 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69a50b818c8so15217252a12.2
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784477046; x=1785081846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uMuDYNVByPxE73id2p5UkFzbEx/56PMpMxuc24OpJUQ=;
 b=SlsZR4lHyqUZJOmYC9AMqevlcMR1RKlxIAYEuB0jSnUm4N6xegZvE4xeJQ8favz3Nv
 lLXS05Tr5WnmfENb9pJR8rFnl46NK2T6UgdphCfJUYoGb7NcCzUgqWHysaSXR4nBQT1Q
 JaSZWlGr9qhlJtRVye2IUvBUPCc1z8IdNJlo4SIG7RNjGLLbTmt6pbuJpo6Bgb+bNt1u
 vILumpKAVupeHVcm6yKwm4+VDjUyrD+3rEgYnnZ1K6IhTWpsc4YxOv8ZLAfdFgTUGfCL
 c67pE/NEmZV9Szsl02n5YPVLW0aTksTwes34D/X72dFzdxk8jWvqZHwt5nusxqFOaOne
 +ZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784477046; x=1785081846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uMuDYNVByPxE73id2p5UkFzbEx/56PMpMxuc24OpJUQ=;
 b=OnkzlKbkoCQ5t1djI5QhLCzBxFZsSnYnAZ0/OEEg/H7y1IulaXUleNDCFtUSfOYnx/
 2dzjZpQZMLvVRbiZwQipPlLVhK6KeaptKHVIKFk8ZvAGf6t8eY2kmI803+OupuDU1pCU
 CdmwMHKjjblCP3+5Rw1zNR7WhteuHzAZ6b6MdfDojt3rNDvKgk8JzxW2y0XKHOeK2l2w
 l9Zi+rY01ZzauwpoKjVHfUI86+gXvJ71uOVSidExInoNVx9T/lNtAR+5ZFXK0nW0b2/u
 JrhcnxRKArEIzu3a5iTWDPIqGlulTZ8c06FHlR28504/8JyjJn0s+junOLN9OngHomlp
 sYZw==
X-Gm-Message-State: AOJu0YwrvL6vO40OhIvvleMSvGvQ8NkQ+R+Iri1SFT9Bda824KzUwBTH
 oJOOdsVtEllxafGIeOWCsP7u0/7Ek2ocpRuPZ5ZQ+7GxJSa0Y0/6GdVlbC0OnAkLu7Y=
X-Gm-Gg: AfdE7cmmE+bIMp8h4vM6YRQesY6VpSsxpUGrIBtqS1qpcV0YVClYIczJAu4KhYDfG5w
 N4o9Bi/NzUUwwKmSb4p7q9TbitsewGDwU29ealfCg3sualAFd5FioGglTMm6guDEwGg+7OllRLG
 r+oZYy8FXh3v/3Mu5eI8jXwB37P2KdLvwlm/C+ihJBaJUNL36BAPujR3e1hiiiEZeXjKyawOW4H
 prm02diGhXn4UVzU2QdcKLuv+f8abjSyueQRxQ6HYzDhNa+glbggkwDmo9nHxRm7MsVKj1AcNZB
 3Zd3L9Ze0MvRdWCxc17r95ugFGS6TpVd4J6Ckie8zjOHi4rWODPfVjLLQVqDpqdv87y961drzBE
 0vs5p6ristQfRQsx5TqBlAMAaJLu2VKxVQrykydeEdosT0IbywUKCxHmRs+IZB19/4qgNlWNejU
 KQimioQAdaOxEqkgts6DUwmx3eJs/OXdEhZH+hJvZskU9fgG+Q5D8cFJ1JXIlcs64lYgpV7iZT7
 YA2eoJVAst1RUhU
X-Received: by 2002:a05:6402:5349:b0:698:3b7c:7e2e with SMTP id
 4fb4d7f45d1cf-69e6531e890mr3114281a12.38.1784477045898; 
 Sun, 19 Jul 2026 09:04:05 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-ee82-4536-a8f2-9e22.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:ee82:4536:a8f2:9e22])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6fefd6d8sm3517019a12.10.2026.07.19.09.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 09:04:05 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] qga: implement 'guest-get-diskstats' for FreeBSD
Date: Sun, 19 Jul 2026 18:03:29 +0200
Message-ID: <20260719160329.73695-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x531.google.com
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

Implement the 'guest-get-diskstats' for FreeBSD.
This implementation uses the devstat(3) library which is a part
of the FreeBSD base system.

The build system is updated to link qga with `-ldevstat`.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 qga/commands-bsd.c   | 127 +++++++++++++++++++++++++++++++++++++++++++
 qga/meson.build      |   3 +
 qga/qapi-schema.json |   6 +-
 3 files changed, 133 insertions(+), 3 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 94ff6fee6a..763db33c9f 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -27,6 +27,9 @@
 #include <net/ethernet.h>
 #endif
 #include <paths.h>
+#ifdef CONFIG_FREEBSD
+#include <devstat.h>
+#endif
 
 #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
 bool build_fs_mount_list(FsMountList *mounts, Error **errp)
@@ -178,3 +181,127 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned char *buf,
     return true;
 }
 #endif /* HAVE_GETIFADDRS */
+
+#ifdef CONFIG_FREEBSD
+static uint64_t bintime_to_msec(const struct bintime *bt)
+{
+    return (uint64_t)bt->sec * 1000ULL + (((bt->frac >> 32) * 1000ULL) >> 32);
+}
+
+static void guest_diskstats_append(GuestDiskStatsInfoList ***tailp,
+                                   const struct devstat *dev)
+{
+    GuestDiskStatsInfoList **tail = *tailp;
+    g_autofree GuestDiskStatsInfo *diskstatinfo = NULL;
+    g_autofree GuestDiskStats *diskstat = NULL;
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
+    if (dev->start_count >= dev->end_count) {
+        diskstat->ios_pgr = dev->start_count - dev->end_count;
+    }
+
+    diskstat->has_total_ticks = true;
+    diskstat->total_ticks = bintime_to_msec(&dev->busy_time);
+
+    diskstatinfo->stats = g_steal_pointer(&diskstat);
+    QAPI_LIST_APPEND(tail, diskstatinfo);
+    diskstatinfo = NULL;
+
+    *tailp = tail;
+}
+
+static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)
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
+        return NULL;
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
+        if (dev_select[i].selected == 0) {
+            continue;
+        }
+
+        guest_diskstats_append(&tail,
+                               &stats.dinfo->devices[dev_select[i].position]);
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
+GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
+{
+    return guest_get_diskstats(errp);
+}
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
index c57bc9a02f..0d1476dcc4 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1714,7 +1714,7 @@
            '*total-ticks': 'uint64',
            '*weight-ticks': 'uint64'
            },
-  'if': 'CONFIG_LINUX' }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
 
 ##
 # @GuestDiskStatsInfo:
@@ -1732,7 +1732,7 @@
            'major': 'uint64',
            'minor': 'uint64',
            'stats': 'GuestDiskStats' },
-  'if': 'CONFIG_LINUX' }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
 
 ##
 # @guest-get-diskstats:
@@ -1745,7 +1745,7 @@
 ##
 { 'command': 'guest-get-diskstats',
   'returns': ['GuestDiskStatsInfo'],
-  'if': 'CONFIG_LINUX'
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] }
 }
 
 ##
-- 
2.52.0


