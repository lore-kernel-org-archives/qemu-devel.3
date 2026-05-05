Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D5CFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMN-0004bn-F3; Tue, 05 May 2026 16:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMH-0004Vf-GP
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMME-0002eD-Hk
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbz2uMzwfgzI8Mc9mnmGPnBL6d4IDbn2j6z1RXzuo7Q=;
 b=M8523RIucVayfY8L8LFWfC2czNOutqfli0WMYArKFhWS920r4andMW4IsPI7+C3Y/i7irt
 iCE0zMT4Tutk1P+8M/m/sQSFLRbSDc+u9K2WFy4WvvzItV8qAeid76fJ3UnuBZ0tIAmuJ2
 ixoMG5uiTcjC7AWYUDbcsF/r8VVxGU0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-s3Z_xlT8PTSyp2x2DUzzGA-1; Tue, 05 May 2026 16:27:04 -0400
X-MC-Unique: s3Z_xlT8PTSyp2x2DUzzGA-1
X-Mimecast-MFC-AGG-ID: s3Z_xlT8PTSyp2x2DUzzGA_1778012824
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b597b14a22so10670296d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012823; x=1778617623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbz2uMzwfgzI8Mc9mnmGPnBL6d4IDbn2j6z1RXzuo7Q=;
 b=iJED753ZbH01oaZcY8ecUreEJSfoUQi8LoOF5a3Zsru0LF3eQ+NpLhC++AUnnki+tl
 aGAqoEnt/izBRxicE4tYYS8q569s/KmhRsug96MLOqbPNLG7+hhxSFbHqpziECEt9CBX
 bxSn3EEaYeGZKTo2LaLsipptFkvxIj2RnaK6C8QPRMFODnEZJBp8UkntGq1PmaI9AAd+
 5MVTbB9gQ7qqM6WIP3WVMTHdzat0Jdq1ttsEIMxuaY2XAnsWmTKUr4IM8xsZB4QgMHL3
 08GqvLhPf1aTM1Cm6yU80x7dyo5CjbHVZkCAZmYI00XTW18CDm35nYei/aiWjoZQz6kf
 CtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012823; x=1778617623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rbz2uMzwfgzI8Mc9mnmGPnBL6d4IDbn2j6z1RXzuo7Q=;
 b=Uc8x9tXvx5iV+gIsjPJ87xEdYNPeM5WjmejWkdsPpRkvQaNOgkKGSKVhhCezvcCq9k
 lwm6JAfTntzYFa15s9dbu/sEkwDuGy2YLA/J87zdE5WHZfeL5CLcxlNKQoZ9O9DCwF4t
 tssBF+CU1tYbRwD7TZlf0ZJy6/DHDv6ENH3pRtK1mFZDA2ELIBwNxetUREyRMJpGe802
 Mm3jOzv5N3PTHGEqW2UP7twF5QpyCmly3vfLIMQWAtW9IWI/tiDsbRoaVUYMCMid34zI
 rSVNt0G/KutLWehW0tliuUPOaIByC1IA2QWd/F2HWEAF4KAZ0aMmL09gyzHnnlF1bu6d
 8hPA==
X-Gm-Message-State: AOJu0YycsoaP8QPpSaidHLoGC10inlrxFAMfzQO0P8I42NoJtA6KLLnD
 uND8BcydWB35NxIWoN5534xvjjTAPFdJWuub7Av5/+NfsnMwQIxJKsIwMZuuMZvuLUpHU/1J5Bg
 EMYJQ2gZfBPnUsdYh/FT3RwnTSqCouQkuZWCgsHa8UGrj1sEtW1Di0xgzHL9QGBHDi5dwzOBINv
 tb1s5MRRfFqDlJ76D4xV9/fXHxo9p3rSRz0T8fSg==
X-Gm-Gg: AeBDieuzCOiTs1MxctP/FDZdNIhYb025xDVO/cDnqCYaQjpU48rtbYbRaUEtcz9Ltzi
 YEyP9gWny8bBKgHEo4i7Zf0t1lEa0RuG/Rc/9Qto0BnRA8rnjFjUz2FtPrLoFYeUNvxXvMe6M8Q
 smWrjp/PTE/9eeir76uKkMtjPi9NfBpuOG8thl9Bf83Jz40yUuV2shfgiWknFHHhMxZE8u4xPOk
 gYjQIrUId4mTXcIP+ou7ORv7iE2HEsKDaGA2M4PTcp4rLU+NFYj65vr/R09crDoh2iZG0Hxywmk
 Be7dHgm5CCrXBSO8431h9KyXnVOxgVcxPtV9ZuJW2lvpdOzPueXQjlxELT/ta0m/nzHjlJrtVnd
 7tc2R1A0zJ8pI/4h6jmMPA/3PsbUM7e4m5ZCw/46M3QNCnSm7Bf+sCAE=
X-Received: by 2002:a05:6214:5e08:b0:8b0:33a2:2520 with SMTP id
 6a1803df08f44-8bc2ebdad5dmr7282466d6.10.1778012823313; 
 Tue, 05 May 2026 13:27:03 -0700 (PDT)
X-Received: by 2002:a05:6214:5e08:b0:8b0:33a2:2520 with SMTP id
 6a1803df08f44-8bc2ebdad5dmr7281756d6.10.1778012822615; 
 Tue, 05 May 2026 13:27:02 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:27:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Aseef Imran <aimran@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 16/23] migration/qapi: Introduce system-wide "remaining" reports
Date: Tue,  5 May 2026 16:26:33 -0400
Message-ID: <20260505202640.1011006-17-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, mgmt can only query for remaining RAM using QMP command
"query-migrate" and monitor the "ram" section.  There's no way to report
system-wide remaining data including VFIO devices.  It was not a problem
before, because for a very long time RAM was the only part that matters.

After VFIO migrations landed upstream, it may not be enough. There can be
GPU devices that contain GBs of device states.  Mgmt may want to know how
much remaining for special devices like VFIO, because all of them will be
accounted as VM data to migrate and will contribute to downtime in the
switchover phase.

Add a new "remaining" field in query-migrate results on the top level,
reflecting system-wide remaining data, which will include everything like
VFIO devices.

This information will be useful for mgmt to implement generic way of stall
detection that covers all system resources.  For example, when system-wide
remaining data (especially, if sampled right after each migration
iteration) does not decrease anymore for a relatively long period of time,
then it may imply there is a challenge of converging, mgmt can react based
on how this value changes over time.

Before this patch, "expected_downtime" almost played this role. For
example, by monitoring "expected_downtime" at the beginning of each
iteration can in most cases also reflect the progress of migration
system-wide.

Said that, "expected_downtime" was always calculated based on a bandwidth
value that can fluctuate if avail-switchover-bandwidth is not used. This
new "remaining" field will remove that part of uncertainty for mgmt no
matter if avail-switchover-bandwidth is used by the mgmt.

With the new field, HMP "info migrate" now reports this:

(qemu) info migrate
Status:                 active
Time (ms):              total=12080, setup=14, exp_down=300
Remaining:              1.36 GiB        <--- this is the new line
RAM info:
  Throughput (Mbps):    840.50
  Sizes:                pagesize=4 KiB, total=4.02 GiB
  Transfers:            transferred=1.18 GiB, remain=1.36 GiB
    Channels:           precopy=1.18 GiB, multifd=0 B, postcopy=0 B
    Page Types:         normal=307923, zero=388148
  Page Rates (pps):     transfer=25660
  Others:               dirty_syncs=1

When VFIO is not involved, the value reported in the new field should be
approximately the same as reported in the "remaining" field of the RAM
section.  It is only approximately because the system-wide remaining data
is a cached value, which gets frequently updated by migration core.  OTOH,
the RAM's remaining data is accurate.

When VFIO is involved, the new value reported should normally be larger,
because it will include the size of VFIO remaining data too.

Cc: Aseef Imran <aimran@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Acked-by: Markus Armbruster <armbru@redhat.com> # QAPI schema
Link: https://lore.kernel.org/r/20260421202110.306051-15-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 4 ++++
 migration/migration-hmp-cmds.c | 5 +++++
 migration/migration.c          | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index ed475e4261..9a4817ec73 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -300,6 +300,9 @@
 #     average memory load of the virtual CPU indirectly.  Note that
 #     zero means guest doesn't dirty memory.  (Since 8.1)
 #
+# @remaining: amount of bytes remaining to be migrated system-wide,
+#     includes both RAM and all devices (like VFIO).  (Since 11.1)
+#
 # Features:
 #
 # @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
@@ -310,6 +313,7 @@
 ##
 { 'struct': 'MigrationInfo',
   'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
+           '*remaining': 'size',
            '*vfio': 'VfioStats',
            '*xbzrle-cache': 'XBZRLECacheStats',
            '*total-time': 'int',
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 4f6c1dbf89..2703448c52 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -178,6 +178,11 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         }
     }
 
+    if (info->has_remaining) {
+        g_autofree char *remaining = size_to_str(info->remaining);
+        monitor_printf(mon, "Remaining: \t\t%s\n", remaining);
+    }
+
     if (info->has_socket_address) {
         SocketAddressList *addr;
 
diff --git a/migration/migration.c b/migration/migration.c
index ab09dcbcf4..ecc69dc4d2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1076,6 +1076,12 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
     }
 }
 
+static void populate_global_info(MigrationInfo *info, MigrationState *s)
+{
+    info->has_remaining = true;
+    info->remaining = qatomic_read(&mig_stats.dirty_bytes_total);
+}
+
 static void populate_ram_info(MigrationInfo *info, MigrationState *s)
 {
     size_t page_size = qemu_target_page_size();
@@ -1177,6 +1183,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         /* TODO add some postcopy stats */
         populate_time_info(info, s);
         populate_ram_info(info, s);
+        populate_global_info(info, s);
         migration_populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_COLO:
-- 
2.53.0


