Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F404DC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEVh-0006JY-FJ; Fri, 11 Jul 2025 10:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaET6-0000tQ-Df
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:18 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaESm-0006Zr-3L
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:10:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3E6181F38C;
 Fri, 11 Jul 2025 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExL2dc8zYuNhaMMvBjDBzq3S3sLX8sfaz1Y6DiMkFWc=;
 b=sFpRtZARql7guZ6k4VgIvWaJ5AULttD9Y1soLGM91w9n88I6WInexpp15hFbo/Cm/8mcPo
 uGYxFh3i1IfrECBICv4QWJGa9FRjB/xiwu3srdMD/QXI6kEc8dqYC5lW+mUBHhwiDhoM2A
 cJjIKtR4JYW0T4uVZjKfTqCNeZD8YB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExL2dc8zYuNhaMMvBjDBzq3S3sLX8sfaz1Y6DiMkFWc=;
 b=FYuT+4cvF8CypQgco7KbxA0vcDCwD2CiepMvJRI9LTjiVLp1IIvfuu7mrWeMhI9T0lIp73
 nSZsc8adqvN7rqCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ejs8cmDi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ji1kMhJJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExL2dc8zYuNhaMMvBjDBzq3S3sLX8sfaz1Y6DiMkFWc=;
 b=Ejs8cmDipsYbq4sORTTTJRxd8snhBzVpcYXRbJD9Plye8Hu51O3UBVcFsBmx1J59aSKSye
 lsCOHCs736c8BFMv09q6Xc5h2hQCrtcWorb3FjhOPUqbbG38KjM6yC75js5vpa6EWrdxAk
 UBMMo5CWm7zwAZ4bH/JI3E7rx2gGwjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ExL2dc8zYuNhaMMvBjDBzq3S3sLX8sfaz1Y6DiMkFWc=;
 b=ji1kMhJJ6VO6U1mH/TUz4cgsgKxaYgNj0ZdGxZB1XGlz+8VmSrmuivk7CCJ7Klx42k08sp
 VGusom/zNN56cpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B0C813918;
 Fri, 11 Jul 2025 14:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aM2cMlsbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 01/26] migration/hmp: Reorg "info migrate" once more
Date: Fri, 11 Jul 2025 11:10:06 -0300
Message-Id: <20250711141031.423-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,fujitsu.com:email,treblig.org:email,suse.de:mid,suse.de:dkim,suse.de:email];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3E6181F38C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Dave suggested the HMP output for "info migrate" can not only leverage the
lines but also better grouping:

  https://lore.kernel.org/r/aC4_-nMc7FwsMf9p@gallifrey

I followed Dave's suggestion, and some more modifications on top:

  - Added all elements into the picture

  - Use size_to_str() and drop most of the units: benefit is more friendly
  to most human eyes, bad side effect is lose of details, but that should
  be corner case per my uses, and one can still leverage the QMP interface
  when necessary.

  - Sub-grouping for "Transfers" ("Channels" and "Page Types").

  - Better indentations

Sample output:

(qemu) info migrate
Status:                 postcopy-active
Time (ms):              total=47317, setup=5, down=8
RAM info:
  Throughput (Mbps):    1342.83
  Sizes:                pagesize=4 KiB, total=4.02 GiB
  Transfers:            transferred=1.41 GiB, remain=2.46 GiB
    Channels:           precopy=15.2 MiB, multifd=0 B, postcopy=1.39 GiB
    Page Types:         normal=367713, zero=41195
  Page Rates (pps):     transfer=40900, dirty=4
  Others:               dirty_syncs=2, postcopy_req=57503

Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Link: https://lore.kernel.org/r/20250613140801.474264-2-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 59 ++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index e8a563c7d8..367ff6037f 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -69,7 +69,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     }
 
     if (info->has_status) {
-        monitor_printf(mon, "Status: %s",
+        monitor_printf(mon, "Status: \t\t%s",
                        MigrationStatus_str(info->status));
         if (info->status == MIGRATION_STATUS_FAILED && info->error_desc) {
             monitor_printf(mon, " (%s)\n", info->error_desc);
@@ -78,7 +78,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         }
 
         if (info->total_time) {
-            monitor_printf(mon, "Time (ms): total=%" PRIu64,
+            monitor_printf(mon, "Time (ms): \t\ttotal=%" PRIu64,
                            info->total_time);
             if (info->has_setup_time) {
                 monitor_printf(mon, ", setup=%" PRIu64,
@@ -110,48 +110,51 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     }
 
     if (info->ram) {
+        g_autofree char *str_psize = size_to_str(info->ram->page_size);
+        g_autofree char *str_total = size_to_str(info->ram->total);
+        g_autofree char *str_transferred = size_to_str(info->ram->transferred);
+        g_autofree char *str_remaining = size_to_str(info->ram->remaining);
+        g_autofree char *str_precopy = size_to_str(info->ram->precopy_bytes);
+        g_autofree char *str_multifd = size_to_str(info->ram->multifd_bytes);
+        g_autofree char *str_postcopy = size_to_str(info->ram->postcopy_bytes);
+
         monitor_printf(mon, "RAM info:\n");
-        monitor_printf(mon, "  Throughput (Mbps): %0.2f\n",
+        monitor_printf(mon, "  Throughput (Mbps): \t%0.2f\n",
                        info->ram->mbps);
-        monitor_printf(mon, "  Sizes (KiB): pagesize=%" PRIu64
-                       ", total=%" PRIu64 ",\n",
-                       info->ram->page_size >> 10,
-                       info->ram->total >> 10);
-        monitor_printf(mon, "    transferred=%" PRIu64
-                       ", remain=%" PRIu64 ",\n",
-                       info->ram->transferred >> 10,
-                       info->ram->remaining >> 10);
-        monitor_printf(mon, "    precopy=%" PRIu64
-                       ", multifd=%" PRIu64
-                       ", postcopy=%" PRIu64,
-                       info->ram->precopy_bytes >> 10,
-                       info->ram->multifd_bytes >> 10,
-                       info->ram->postcopy_bytes >> 10);
+        monitor_printf(mon, "  Sizes: \t\tpagesize=%s, total=%s\n",
+                       str_psize, str_total);
+        monitor_printf(mon, "  Transfers: \t\ttransferred=%s, remain=%s\n",
+                       str_transferred, str_remaining);
+        monitor_printf(mon, "    Channels: \t\tprecopy=%s, "
+                       "multifd=%s, postcopy=%s",
+                       str_precopy, str_multifd, str_postcopy);
 
         if (info->vfio) {
-            monitor_printf(mon, ", vfio=%" PRIu64,
-                           info->vfio->transferred >> 10);
+            g_autofree char *str_vfio = size_to_str(info->vfio->transferred);
+
+            monitor_printf(mon, ", vfio=%s", str_vfio);
         }
         monitor_printf(mon, "\n");
 
-        monitor_printf(mon, "  Pages: normal=%" PRIu64 ", zero=%" PRIu64
-                       ", rate_per_sec=%" PRIu64 "\n",
-                       info->ram->normal,
-                       info->ram->duplicate,
+        monitor_printf(mon, "    Page Types: \tnormal=%" PRIu64
+                       ", zero=%" PRIu64 "\n",
+                       info->ram->normal, info->ram->duplicate);
+        monitor_printf(mon, "  Page Rates (pps): \ttransfer=%" PRIu64,
                        info->ram->pages_per_second);
-        monitor_printf(mon, "  Others: dirty_syncs=%" PRIu64,
-                       info->ram->dirty_sync_count);
-
         if (info->ram->dirty_pages_rate) {
-            monitor_printf(mon, ", dirty_pages_rate=%" PRIu64,
+            monitor_printf(mon, ", dirty=%" PRIu64,
                            info->ram->dirty_pages_rate);
         }
+        monitor_printf(mon, "\n");
+
+        monitor_printf(mon, "  Others: \t\tdirty_syncs=%" PRIu64,
+                       info->ram->dirty_sync_count);
         if (info->ram->postcopy_requests) {
             monitor_printf(mon, ", postcopy_req=%" PRIu64,
                            info->ram->postcopy_requests);
         }
         if (info->ram->downtime_bytes) {
-            monitor_printf(mon, ", downtime_ram=%" PRIu64,
+            monitor_printf(mon, ", downtime_bytes=%" PRIu64,
                            info->ram->downtime_bytes);
         }
         if (info->ram->dirty_sync_missed_zero_copy) {
-- 
2.35.3


