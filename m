Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896FFC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn3y-0001Nk-Fb; Mon, 22 Jul 2024 03:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3S-0008VV-Ka
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3Q-0006Sp-BM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOgOENq6Mj10vsiSf6ufiGKm8C5yzr2fOB/o6Phgc2Q=;
 b=MQeWjzcuc1f3vzMQtoK2v9HK7oFvB6Mh57va/93BX0J73kjmYHGxR3cOl3LGPVxVH69uk3
 a8eur82cKRUk7U9SILO+N3GcISrzRYmWUuFcjRkl7wvhBzR0N8B/sKDuZbW6bOzDLbdGiS
 dzmGJ91sL5VfJqU4TIRwOLEtWeAqeF8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-tPM6j02qNcKy0zWb5FY2Bw-1; Mon,
 22 Jul 2024 03:01:45 -0400
X-MC-Unique: tPM6j02qNcKy0zWb5FY2Bw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D18D1945103; Mon, 22 Jul 2024 07:01:39 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 082E91955BEE; Mon, 22 Jul 2024 07:01:36 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 05/25] qga: move linux disk/cpu stats command impls to
 commands-linux.c
Date: Mon, 22 Jul 2024 10:01:02 +0300
Message-ID: <20240722070122.27615-6-kkostiuk@redhat.com>
In-Reply-To: <20240722070122.27615-1-kkostiuk@redhat.com>
References: <20240722070122.27615-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The qmp_guest_{diskstats,cpustats} command impls in
commands-posix.c are surrounded by '#ifdef __linux__' so should
instead live in commands-linux.c

This also removes a "#ifdef CONFIG_LINUX" that was nested inside
a "#ifdef __linux__".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240712132459.3974109-6-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-linux.c | 195 ++++++++++++++++++++++++++++++++++++++++++
 qga/commands-posix.c | 199 -------------------------------------------
 2 files changed, 195 insertions(+), 199 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 084e6c9e85..c0e8bd4062 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -1594,3 +1594,198 @@ int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
 
     return processed;
 }
+
+#define MAX_NAME_LEN 128
+static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)
+{
+    GuestDiskStatsInfoList *head = NULL, **tail = &head;
+    const char *diskstats = "/proc/diskstats";
+    FILE *fp;
+    size_t n;
+    char *line = NULL;
+
+    fp = fopen(diskstats, "r");
+    if (fp  == NULL) {
+        error_setg_errno(errp, errno, "open(\"%s\")", diskstats);
+        return NULL;
+    }
+
+    while (getline(&line, &n, fp) != -1) {
+        g_autofree GuestDiskStatsInfo *diskstatinfo = NULL;
+        g_autofree GuestDiskStats *diskstat = NULL;
+        char dev_name[MAX_NAME_LEN];
+        unsigned int ios_pgr, tot_ticks, rq_ticks, wr_ticks, dc_ticks, fl_ticks;
+        unsigned long rd_ios, rd_merges_or_rd_sec, rd_ticks_or_wr_sec, wr_ios;
+        unsigned long wr_merges, rd_sec_or_wr_ios, wr_sec;
+        unsigned long dc_ios, dc_merges, dc_sec, fl_ios;
+        unsigned int major, minor;
+        int i;
+
+        i = sscanf(line, "%u %u %s %lu %lu %lu"
+                   "%lu %lu %lu %lu %u %u %u %u"
+                   "%lu %lu %lu %u %lu %u",
+                   &major, &minor, dev_name,
+                   &rd_ios, &rd_merges_or_rd_sec, &rd_sec_or_wr_ios,
+                   &rd_ticks_or_wr_sec, &wr_ios, &wr_merges, &wr_sec,
+                   &wr_ticks, &ios_pgr, &tot_ticks, &rq_ticks,
+                   &dc_ios, &dc_merges, &dc_sec, &dc_ticks,
+                   &fl_ios, &fl_ticks);
+
+        if (i < 7) {
+            continue;
+        }
+
+        diskstatinfo = g_new0(GuestDiskStatsInfo, 1);
+        diskstatinfo->name = g_strdup(dev_name);
+        diskstatinfo->major = major;
+        diskstatinfo->minor = minor;
+
+        diskstat = g_new0(GuestDiskStats, 1);
+        if (i == 7) {
+            diskstat->has_read_ios = true;
+            diskstat->read_ios = rd_ios;
+            diskstat->has_read_sectors = true;
+            diskstat->read_sectors = rd_merges_or_rd_sec;
+            diskstat->has_write_ios = true;
+            diskstat->write_ios = rd_sec_or_wr_ios;
+            diskstat->has_write_sectors = true;
+            diskstat->write_sectors = rd_ticks_or_wr_sec;
+        }
+        if (i >= 14) {
+            diskstat->has_read_ios = true;
+            diskstat->read_ios = rd_ios;
+            diskstat->has_read_sectors = true;
+            diskstat->read_sectors = rd_sec_or_wr_ios;
+            diskstat->has_read_merges = true;
+            diskstat->read_merges = rd_merges_or_rd_sec;
+            diskstat->has_read_ticks = true;
+            diskstat->read_ticks = rd_ticks_or_wr_sec;
+            diskstat->has_write_ios = true;
+            diskstat->write_ios = wr_ios;
+            diskstat->has_write_sectors = true;
+            diskstat->write_sectors = wr_sec;
+            diskstat->has_write_merges = true;
+            diskstat->write_merges = wr_merges;
+            diskstat->has_write_ticks = true;
+            diskstat->write_ticks = wr_ticks;
+            diskstat->has_ios_pgr = true;
+            diskstat->ios_pgr = ios_pgr;
+            diskstat->has_total_ticks = true;
+            diskstat->total_ticks = tot_ticks;
+            diskstat->has_weight_ticks = true;
+            diskstat->weight_ticks = rq_ticks;
+        }
+        if (i >= 18) {
+            diskstat->has_discard_ios = true;
+            diskstat->discard_ios = dc_ios;
+            diskstat->has_discard_merges = true;
+            diskstat->discard_merges = dc_merges;
+            diskstat->has_discard_sectors = true;
+            diskstat->discard_sectors = dc_sec;
+            diskstat->has_discard_ticks = true;
+            diskstat->discard_ticks = dc_ticks;
+        }
+        if (i >= 20) {
+            diskstat->has_flush_ios = true;
+            diskstat->flush_ios = fl_ios;
+            diskstat->has_flush_ticks = true;
+            diskstat->flush_ticks = fl_ticks;
+        }
+
+        diskstatinfo->stats = g_steal_pointer(&diskstat);
+        QAPI_LIST_APPEND(tail, diskstatinfo);
+        diskstatinfo = NULL;
+    }
+    free(line);
+    fclose(fp);
+    return head;
+}
+
+GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
+{
+    return guest_get_diskstats(errp);
+}
+
+GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
+{
+    GuestCpuStatsList *head = NULL, **tail = &head;
+    const char *cpustats = "/proc/stat";
+    int clk_tck = sysconf(_SC_CLK_TCK);
+    FILE *fp;
+    size_t n;
+    char *line = NULL;
+
+    fp = fopen(cpustats, "r");
+    if (fp  == NULL) {
+        error_setg_errno(errp, errno, "open(\"%s\")", cpustats);
+        return NULL;
+    }
+
+    while (getline(&line, &n, fp) != -1) {
+        GuestCpuStats *cpustat = NULL;
+        GuestLinuxCpuStats *linuxcpustat;
+        int i;
+        unsigned long user, system, idle, iowait, irq, softirq, steal, guest;
+        unsigned long nice, guest_nice;
+        char name[64];
+
+        i = sscanf(line, "%s %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
+                   name, &user, &nice, &system, &idle, &iowait, &irq, &softirq,
+                   &steal, &guest, &guest_nice);
+
+        /* drop "cpu 1 2 3 ...", get "cpuX 1 2 3 ..." only */
+        if ((i == EOF) || strncmp(name, "cpu", 3) || (name[3] == '\0')) {
+            continue;
+        }
+
+        if (i < 5) {
+            slog("Parsing cpu stat from %s failed, see \"man proc\"", cpustats);
+            break;
+        }
+
+        cpustat = g_new0(GuestCpuStats, 1);
+        cpustat->type = GUEST_CPU_STATS_TYPE_LINUX;
+
+        linuxcpustat = &cpustat->u.q_linux;
+        linuxcpustat->cpu = atoi(&name[3]);
+        linuxcpustat->user = user * 1000 / clk_tck;
+        linuxcpustat->nice = nice * 1000 / clk_tck;
+        linuxcpustat->system = system * 1000 / clk_tck;
+        linuxcpustat->idle = idle * 1000 / clk_tck;
+
+        if (i > 5) {
+            linuxcpustat->has_iowait = true;
+            linuxcpustat->iowait = iowait * 1000 / clk_tck;
+        }
+
+        if (i > 6) {
+            linuxcpustat->has_irq = true;
+            linuxcpustat->irq = irq * 1000 / clk_tck;
+            linuxcpustat->has_softirq = true;
+            linuxcpustat->softirq = softirq * 1000 / clk_tck;
+        }
+
+        if (i > 8) {
+            linuxcpustat->has_steal = true;
+            linuxcpustat->steal = steal * 1000 / clk_tck;
+        }
+
+        if (i > 9) {
+            linuxcpustat->has_guest = true;
+            linuxcpustat->guest = guest * 1000 / clk_tck;
+        }
+
+        if (i > 10) {
+            linuxcpustat->has_guest = true;
+            linuxcpustat->guest = guest * 1000 / clk_tck;
+            linuxcpustat->has_guestnice = true;
+            linuxcpustat->guestnice = guest_nice * 1000 / clk_tck;
+        }
+
+        QAPI_LIST_APPEND(tail, cpustat);
+    }
+
+    free(line);
+    fclose(fp);
+    return head;
+}
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 98aafc45f3..5da60e65ab 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1195,205 +1195,6 @@ GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
     return info;
 }
 
-#define MAX_NAME_LEN 128
-static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)
-{
-#ifdef CONFIG_LINUX
-    GuestDiskStatsInfoList *head = NULL, **tail = &head;
-    const char *diskstats = "/proc/diskstats";
-    FILE *fp;
-    size_t n;
-    char *line = NULL;
-
-    fp = fopen(diskstats, "r");
-    if (fp  == NULL) {
-        error_setg_errno(errp, errno, "open(\"%s\")", diskstats);
-        return NULL;
-    }
-
-    while (getline(&line, &n, fp) != -1) {
-        g_autofree GuestDiskStatsInfo *diskstatinfo = NULL;
-        g_autofree GuestDiskStats *diskstat = NULL;
-        char dev_name[MAX_NAME_LEN];
-        unsigned int ios_pgr, tot_ticks, rq_ticks, wr_ticks, dc_ticks, fl_ticks;
-        unsigned long rd_ios, rd_merges_or_rd_sec, rd_ticks_or_wr_sec, wr_ios;
-        unsigned long wr_merges, rd_sec_or_wr_ios, wr_sec;
-        unsigned long dc_ios, dc_merges, dc_sec, fl_ios;
-        unsigned int major, minor;
-        int i;
-
-        i = sscanf(line, "%u %u %s %lu %lu %lu"
-                   "%lu %lu %lu %lu %u %u %u %u"
-                   "%lu %lu %lu %u %lu %u",
-                   &major, &minor, dev_name,
-                   &rd_ios, &rd_merges_or_rd_sec, &rd_sec_or_wr_ios,
-                   &rd_ticks_or_wr_sec, &wr_ios, &wr_merges, &wr_sec,
-                   &wr_ticks, &ios_pgr, &tot_ticks, &rq_ticks,
-                   &dc_ios, &dc_merges, &dc_sec, &dc_ticks,
-                   &fl_ios, &fl_ticks);
-
-        if (i < 7) {
-            continue;
-        }
-
-        diskstatinfo = g_new0(GuestDiskStatsInfo, 1);
-        diskstatinfo->name = g_strdup(dev_name);
-        diskstatinfo->major = major;
-        diskstatinfo->minor = minor;
-
-        diskstat = g_new0(GuestDiskStats, 1);
-        if (i == 7) {
-            diskstat->has_read_ios = true;
-            diskstat->read_ios = rd_ios;
-            diskstat->has_read_sectors = true;
-            diskstat->read_sectors = rd_merges_or_rd_sec;
-            diskstat->has_write_ios = true;
-            diskstat->write_ios = rd_sec_or_wr_ios;
-            diskstat->has_write_sectors = true;
-            diskstat->write_sectors = rd_ticks_or_wr_sec;
-        }
-        if (i >= 14) {
-            diskstat->has_read_ios = true;
-            diskstat->read_ios = rd_ios;
-            diskstat->has_read_sectors = true;
-            diskstat->read_sectors = rd_sec_or_wr_ios;
-            diskstat->has_read_merges = true;
-            diskstat->read_merges = rd_merges_or_rd_sec;
-            diskstat->has_read_ticks = true;
-            diskstat->read_ticks = rd_ticks_or_wr_sec;
-            diskstat->has_write_ios = true;
-            diskstat->write_ios = wr_ios;
-            diskstat->has_write_sectors = true;
-            diskstat->write_sectors = wr_sec;
-            diskstat->has_write_merges = true;
-            diskstat->write_merges = wr_merges;
-            diskstat->has_write_ticks = true;
-            diskstat->write_ticks = wr_ticks;
-            diskstat->has_ios_pgr = true;
-            diskstat->ios_pgr = ios_pgr;
-            diskstat->has_total_ticks = true;
-            diskstat->total_ticks = tot_ticks;
-            diskstat->has_weight_ticks = true;
-            diskstat->weight_ticks = rq_ticks;
-        }
-        if (i >= 18) {
-            diskstat->has_discard_ios = true;
-            diskstat->discard_ios = dc_ios;
-            diskstat->has_discard_merges = true;
-            diskstat->discard_merges = dc_merges;
-            diskstat->has_discard_sectors = true;
-            diskstat->discard_sectors = dc_sec;
-            diskstat->has_discard_ticks = true;
-            diskstat->discard_ticks = dc_ticks;
-        }
-        if (i >= 20) {
-            diskstat->has_flush_ios = true;
-            diskstat->flush_ios = fl_ios;
-            diskstat->has_flush_ticks = true;
-            diskstat->flush_ticks = fl_ticks;
-        }
-
-        diskstatinfo->stats = g_steal_pointer(&diskstat);
-        QAPI_LIST_APPEND(tail, diskstatinfo);
-        diskstatinfo = NULL;
-    }
-    free(line);
-    fclose(fp);
-    return head;
-#else
-    g_debug("disk stats reporting available only for Linux");
-    return NULL;
-#endif
-}
-
-GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
-{
-    return guest_get_diskstats(errp);
-}
-
-GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
-{
-    GuestCpuStatsList *head = NULL, **tail = &head;
-    const char *cpustats = "/proc/stat";
-    int clk_tck = sysconf(_SC_CLK_TCK);
-    FILE *fp;
-    size_t n;
-    char *line = NULL;
-
-    fp = fopen(cpustats, "r");
-    if (fp  == NULL) {
-        error_setg_errno(errp, errno, "open(\"%s\")", cpustats);
-        return NULL;
-    }
-
-    while (getline(&line, &n, fp) != -1) {
-        GuestCpuStats *cpustat = NULL;
-        GuestLinuxCpuStats *linuxcpustat;
-        int i;
-        unsigned long user, system, idle, iowait, irq, softirq, steal, guest;
-        unsigned long nice, guest_nice;
-        char name[64];
-
-        i = sscanf(line, "%s %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
-                   name, &user, &nice, &system, &idle, &iowait, &irq, &softirq,
-                   &steal, &guest, &guest_nice);
-
-        /* drop "cpu 1 2 3 ...", get "cpuX 1 2 3 ..." only */
-        if ((i == EOF) || strncmp(name, "cpu", 3) || (name[3] == '\0')) {
-            continue;
-        }
-
-        if (i < 5) {
-            slog("Parsing cpu stat from %s failed, see \"man proc\"", cpustats);
-            break;
-        }
-
-        cpustat = g_new0(GuestCpuStats, 1);
-        cpustat->type = GUEST_CPU_STATS_TYPE_LINUX;
-
-        linuxcpustat = &cpustat->u.q_linux;
-        linuxcpustat->cpu = atoi(&name[3]);
-        linuxcpustat->user = user * 1000 / clk_tck;
-        linuxcpustat->nice = nice * 1000 / clk_tck;
-        linuxcpustat->system = system * 1000 / clk_tck;
-        linuxcpustat->idle = idle * 1000 / clk_tck;
-
-        if (i > 5) {
-            linuxcpustat->has_iowait = true;
-            linuxcpustat->iowait = iowait * 1000 / clk_tck;
-        }
-
-        if (i > 6) {
-            linuxcpustat->has_irq = true;
-            linuxcpustat->irq = irq * 1000 / clk_tck;
-            linuxcpustat->has_softirq = true;
-            linuxcpustat->softirq = softirq * 1000 / clk_tck;
-        }
-
-        if (i > 8) {
-            linuxcpustat->has_steal = true;
-            linuxcpustat->steal = steal * 1000 / clk_tck;
-        }
-
-        if (i > 9) {
-            linuxcpustat->has_guest = true;
-            linuxcpustat->guest = guest * 1000 / clk_tck;
-        }
-
-        if (i > 10) {
-            linuxcpustat->has_guest = true;
-            linuxcpustat->guest = guest * 1000 / clk_tck;
-            linuxcpustat->has_guestnice = true;
-            linuxcpustat->guestnice = guest_nice * 1000 / clk_tck;
-        }
-
-        QAPI_LIST_APPEND(tail, cpustat);
-    }
-
-    free(line);
-    fclose(fp);
-    return head;
-}
 
 #else /* defined(__linux__) */
 
-- 
2.45.2


