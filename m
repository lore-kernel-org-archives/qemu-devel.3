Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192B7C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 20:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFIIk-0007EJ-Ux; Wed, 14 May 2025 16:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFIIZ-0006zv-PL
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFIIX-0003Zj-Bw
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747252908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LY8nsZ2LUoyJzLLBZvufrL2DW7lgPGych9NYpy3ZacY=;
 b=FO9CDufq+ZqljqWdLrPqU13IvKI0V1lcJKyJxwTSejCkLB1AXXVgjYJAFB03F8Eg0jEDxn
 NHoQ9L0l0Dh3EjYwKpLRgtymr10pWUpMpFlDzsoEWdMqcNqzSopiufOSLciuZfJ8gPStWi
 O+NKWGieF+2EngiqXH7uT0DIU5Sf70g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-0C2SFYd5MvWJcMJJ5-xFKA-1; Wed, 14 May 2025 16:01:47 -0400
X-MC-Unique: 0C2SFYd5MvWJcMJJ5-xFKA-1
X-Mimecast-MFC-AGG-ID: 0C2SFYd5MvWJcMJJ5-xFKA_1747252907
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6f617f20b2bso4576566d6.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 13:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747252906; x=1747857706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LY8nsZ2LUoyJzLLBZvufrL2DW7lgPGych9NYpy3ZacY=;
 b=ix7DyplGZgj52HmQoD7ZvRsRc0ibEgCyYAUqk+SsqekSe+xBfD+qBpe7YYHHjcvYPG
 JTYVQOtD8RkfOksZpuZF4y6ZoPKo11duFugf2grOMz8RQ7ocz8MktpYl7Zyz8Nv6vqQc
 pKAT2ItCUZEy8yFCSY44LHDhCy3us1CpgBy9drBDEvWVa18JzS4TJFb0J582+5DpZJOv
 cinfxFJqSi4qao7FfVvVoAZlgiSmvszC4cLMhpsIaMAVg9Mm7Q4QvLGCGsD4ccdExfqH
 1UIZN4z8kb7EzDW/f0Zs1/qZqWCj+piQ3CX+q0l/bMrZHjTZE2pmZV/4IqqpnrTuF93u
 pK+A==
X-Gm-Message-State: AOJu0Yy4aLW2TsOyVYROlje+S9vDFbeX0mDIsTzvrjAdyWbgIJP731gB
 +EeLxDTl9WcgMqKv6Lgvica6Xv8t4aSGBfLnY2+zCQuEOT9eFqy9Ty9B8W464kUVcR7piW5NFCo
 3yCfsrJOfG8u4aMGo6PzxSoAnEz6TR/O9d7guVW9OT7Q7rIp4HRbgojlfdn3dKfgylt8/ijLgmC
 tl4bQ47G1filbfgessDPUjiGva/ik6dmTkpw==
X-Gm-Gg: ASbGncvAEB2eC5XpRpdDIvIB9Y+h0U4xA4D/PYk9u11i4lfKwCRwjP3r3HCg5DsmZGC
 0Z3rqcDM8x6c5yE3+mYyxtuIX5sDAlcPoCkuirguunBn2d8vbpXJepgldTTbswLvtVDmNi8dkUn
 s/yBzZ9sycdbjBPrzcj9xcMhlNCz6ZhrTR/nTEmoQDiyMOqfWetDk0EzQAlw2yImtz9zdefdLLs
 1XHqOMXM9NKehKWz7jdfYLcVfTw4FXiGEFeB1HejTjRGKOFAVNAEPphN5ra4W/TRLdWTspFd4V+
X-Received: by 2002:a05:6214:212c:b0:6e4:4011:9dff with SMTP id
 6a1803df08f44-6f896dfa31dmr68222516d6.1.1747252905900; 
 Wed, 14 May 2025 13:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpoRtdIAzqy0qI4kKaCFiqIkhdNCWJCouGZQjbyLfBwm8Mem9IJ+8VyvhVEFGvH2jtXA1lXw==
X-Received: by 2002:a05:6214:212c:b0:6e4:4011:9dff with SMTP id
 6a1803df08f44-6f896dfa31dmr68221956d6.1.1747252905222; 
 Wed, 14 May 2025 13:01:45 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a524a6sm84979066d6.104.2025.05.14.13.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 13:01:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: [PATCH v2 2/2] migration/hmp: Add "info migrate -a", reorg the dump
Date: Wed, 14 May 2025 16:01:37 -0400
Message-ID: <20250514200137.581935-3-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514200137.581935-1-peterx@redhat.com>
References: <20250514200137.581935-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A new parameter "-a" is added to "info migrate" to dump all info, while
when not specified it only dumps the important ones.  When at it, reorg
everything to make it easier to read for human.

The general rule is:

  - Put important things at the top
  - Reuse a single line when things are very relevant, hence reducing lines
    needed to show the results
  - Remove almost useless ones (e.g. "normal_bytes", while we also have
    both "page size" and "normal" pages)
  - Regroup things, so that related fields will show together
  - etc.

Before this change, it looks like (one example of a completed case):

  globals:
  store-global-state: on
  only-migratable: off
  send-configuration: on
  send-section-footer: on
  send-switchover-start: on
  clear-bitmap-shift: 18
  Migration status: completed
  total time: 122952 ms
  downtime: 76 ms
  setup: 15 ms
  transferred ram: 130825923 kbytes
  throughput: 8717.68 mbps
  remaining ram: 0 kbytes
  total ram: 16777992 kbytes
  duplicate: 997263 pages
  normal: 32622225 pages
  normal bytes: 130488900 kbytes
  dirty sync count: 10
  page size: 4 kbytes
  multifd bytes: 117134260 kbytes
  pages-per-second: 169431
  postcopy request count: 5835
  precopy ram: 15 kbytes
  postcopy ram: 13691151 kbytes

After this change, sample output (default, no "-a" specified):

  Status: postcopy-active
  Time (ms): total=40504, setup=14, down=145
  RAM info:
    Bandwidth (mbps): 6102.65
    Sizes (KB): psize=4, total=16777992
      transferred=37673019, remain=2136404,
      precopy=3, multifd=26108780, postcopy=11563855
    Pages: normal=9394288, zero=600672, rate_per_sec=185875
    Others: dirty_syncs=3, dirty_pages_rate=278378, postcopy_req=4078

Sample output when "-a" specified:

  Status: active
  Time (ms): total=3040, setup=4, exp_down=300
  RAM info:
    Throughput (mbps): 10.51
    Sizes (KB): psize=4, total=4211528
      transferred=3979, remain=4206452,
      precopy=3978, multifd=0, postcopy=0
    Pages: normal=992, zero=277, rate_per_sec=320
    Others: dirty_syncs=1
  Globals:
    store-global-state: on
    only-migratable: off
    send-configuration: on
    send-section-footer: on
    send-switchover-start: on
    clear-bitmap-shift: 18
  XBZRLE: size=67108864, transferred=0, pages=0, miss=188451
    miss_rate=0.00, encode_rate=0.00, overflow=0
  CPU Throttle (%): 0
  Dirty-limit Throttle (us): 0
  Dirty-limit Ring Full (us): 0
  Postcopy Blocktime (ms): 0
  Postcopy vCPU Blocktime: ...

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 186 +++++++++++++++++----------------
 hmp-commands-info.hx           |   6 +-
 2 files changed, 99 insertions(+), 93 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 49c26daed3..13e93d3c54 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -37,29 +37,28 @@ static void migration_global_dump(Monitor *mon)
 {
     MigrationState *ms = migrate_get_current();
 
-    monitor_printf(mon, "globals:\n");
-    monitor_printf(mon, "store-global-state: %s\n",
+    monitor_printf(mon, "Globals:\n");
+    monitor_printf(mon, "  store-global-state: %s\n",
                    ms->store_global_state ? "on" : "off");
-    monitor_printf(mon, "only-migratable: %s\n",
+    monitor_printf(mon, "  only-migratable: %s\n",
                    only_migratable ? "on" : "off");
-    monitor_printf(mon, "send-configuration: %s\n",
+    monitor_printf(mon, "  send-configuration: %s\n",
                    ms->send_configuration ? "on" : "off");
-    monitor_printf(mon, "send-section-footer: %s\n",
+    monitor_printf(mon, "  send-section-footer: %s\n",
                    ms->send_section_footer ? "on" : "off");
-    monitor_printf(mon, "send-switchover-start: %s\n",
+    monitor_printf(mon, "  send-switchover-start: %s\n",
                    ms->send_switchover_start ? "on" : "off");
-    monitor_printf(mon, "clear-bitmap-shift: %u\n",
+    monitor_printf(mon, "  clear-bitmap-shift: %u\n",
                    ms->clear_bitmap_shift);
 }
 
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 {
+    bool show_all = qdict_get_try_bool(qdict, "all", false);
     MigrationInfo *info;
 
     info = qmp_query_migrate(NULL);
 
-    migration_global_dump(mon);
-
     if (info->blocked_reasons) {
         strList *reasons = info->blocked_reasons;
         monitor_printf(mon, "Outgoing migration blocked:\n");
@@ -70,7 +69,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     }
 
     if (info->has_status) {
-        monitor_printf(mon, "Migration status: %s",
+        monitor_printf(mon, "Status: %s",
                        MigrationStatus_str(info->status));
         if (info->status == MIGRATION_STATUS_FAILED && info->error_desc) {
             monitor_printf(mon, " (%s)\n", info->error_desc);
@@ -78,107 +77,130 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "\n");
         }
 
-        monitor_printf(mon, "total time: %" PRIu64 " ms\n",
-                       info->total_time);
-        if (info->has_expected_downtime) {
-            monitor_printf(mon, "expected downtime: %" PRIu64 " ms\n",
-                           info->expected_downtime);
-        }
-        if (info->has_downtime) {
-            monitor_printf(mon, "downtime: %" PRIu64 " ms\n",
-                           info->downtime);
+        if (info->total_time) {
+            monitor_printf(mon, "Time (ms): total=%" PRIu64,
+                           info->total_time);
+            if (info->has_setup_time) {
+                monitor_printf(mon, ", setup=%" PRIu64,
+                               info->setup_time);
+            }
+            if (info->has_expected_downtime) {
+                monitor_printf(mon, ", exp_down=%" PRIu64,
+                               info->expected_downtime);
+            }
+            if (info->has_downtime) {
+                monitor_printf(mon, ", down=%" PRIu64,
+                               info->downtime);
+            }
+            monitor_printf(mon, "\n");
         }
-        if (info->has_setup_time) {
-            monitor_printf(mon, "setup: %" PRIu64 " ms\n",
-                           info->setup_time);
+    }
+
+    if (info->has_socket_address) {
+        SocketAddressList *addr;
+
+        monitor_printf(mon, "Sockets: [\n");
+
+        for (addr = info->socket_address; addr; addr = addr->next) {
+            char *s = socket_uri(addr->value);
+            monitor_printf(mon, "\t%s\n", s);
+            g_free(s);
         }
+        monitor_printf(mon, "]\n");
     }
 
     if (info->ram) {
-        monitor_printf(mon, "transferred ram: %" PRIu64 " kbytes\n",
-                       info->ram->transferred >> 10);
-        monitor_printf(mon, "throughput: %0.2f mbps\n",
+        monitor_printf(mon, "RAM info:\n");
+        monitor_printf(mon, "  Throughput (mbps): %0.2f\n",
                        info->ram->mbps);
-        monitor_printf(mon, "remaining ram: %" PRIu64 " kbytes\n",
-                       info->ram->remaining >> 10);
-        monitor_printf(mon, "total ram: %" PRIu64 " kbytes\n",
+        monitor_printf(mon, "  Sizes (KB): psize=%" PRIu64
+                       ", total=%" PRIu64 "\n",
+                       info->ram->page_size >> 10,
                        info->ram->total >> 10);
-        monitor_printf(mon, "duplicate: %" PRIu64 " pages\n",
-                       info->ram->duplicate);
-        monitor_printf(mon, "normal: %" PRIu64 " pages\n",
-                       info->ram->normal);
-        monitor_printf(mon, "normal bytes: %" PRIu64 " kbytes\n",
-                       info->ram->normal_bytes >> 10);
-        monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
-                       info->ram->dirty_sync_count);
-        monitor_printf(mon, "page size: %" PRIu64 " kbytes\n",
-                       info->ram->page_size >> 10);
-        monitor_printf(mon, "multifd bytes: %" PRIu64 " kbytes\n",
-                       info->ram->multifd_bytes >> 10);
-        monitor_printf(mon, "pages-per-second: %" PRIu64 "\n",
+        monitor_printf(mon, "    transferred=%" PRIu64
+                       ", remain=%" PRIu64 ",\n",
+                       info->ram->transferred >> 10,
+                       info->ram->remaining >> 10);
+        monitor_printf(mon, "    precopy=%" PRIu64
+                       ", multifd=%" PRIu64
+                       ", postcopy=%" PRIu64,
+                       info->ram->precopy_bytes >> 10,
+                       info->ram->multifd_bytes >> 10,
+                       info->ram->postcopy_bytes >> 10);
+
+        if (info->vfio) {
+            monitor_printf(mon, ", vfio=%" PRIu64,
+                           info->vfio->transferred >> 10);
+        }
+        monitor_printf(mon, "\n");
+
+        monitor_printf(mon, "  Pages: normal=%" PRIu64 ", zero=%" PRIu64
+                       ", rate_per_sec=%" PRIu64 "\n",
+                       info->ram->normal,
+                       info->ram->duplicate,
                        info->ram->pages_per_second);
+        monitor_printf(mon, "  Others: dirty_syncs=%" PRIu64,
+                       info->ram->dirty_sync_count);
 
         if (info->ram->dirty_pages_rate) {
-            monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
+            monitor_printf(mon, ", dirty_pages_rate=%" PRIu64,
                            info->ram->dirty_pages_rate);
         }
         if (info->ram->postcopy_requests) {
-            monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
+            monitor_printf(mon, ", postcopy_req=%" PRIu64,
                            info->ram->postcopy_requests);
         }
-        if (info->ram->precopy_bytes) {
-            monitor_printf(mon, "precopy ram: %" PRIu64 " kbytes\n",
-                           info->ram->precopy_bytes >> 10);
-        }
         if (info->ram->downtime_bytes) {
-            monitor_printf(mon, "downtime ram: %" PRIu64 " kbytes\n",
-                           info->ram->downtime_bytes >> 10);
-        }
-        if (info->ram->postcopy_bytes) {
-            monitor_printf(mon, "postcopy ram: %" PRIu64 " kbytes\n",
-                           info->ram->postcopy_bytes >> 10);
+            monitor_printf(mon, ", downtime_ram=%" PRIu64,
+                           info->ram->downtime_bytes);
         }
         if (info->ram->dirty_sync_missed_zero_copy) {
-            monitor_printf(mon,
-                           "Zero-copy-send fallbacks happened: %" PRIu64 " times\n",
+            monitor_printf(mon, ", zerocopy_fallbacks=%" PRIu64,
                            info->ram->dirty_sync_missed_zero_copy);
         }
+        monitor_printf(mon, "\n");
+    }
+
+    if (!show_all) {
+        goto out;
     }
 
+    migration_global_dump(mon);
+
     if (info->xbzrle_cache) {
-        monitor_printf(mon, "cache size: %" PRIu64 " bytes\n",
-                       info->xbzrle_cache->cache_size);
-        monitor_printf(mon, "xbzrle transferred: %" PRIu64 " kbytes\n",
-                       info->xbzrle_cache->bytes >> 10);
-        monitor_printf(mon, "xbzrle pages: %" PRIu64 " pages\n",
-                       info->xbzrle_cache->pages);
-        monitor_printf(mon, "xbzrle cache miss: %" PRIu64 " pages\n",
-                       info->xbzrle_cache->cache_miss);
-        monitor_printf(mon, "xbzrle cache miss rate: %0.2f\n",
-                       info->xbzrle_cache->cache_miss_rate);
-        monitor_printf(mon, "xbzrle encoding rate: %0.2f\n",
-                       info->xbzrle_cache->encoding_rate);
-        monitor_printf(mon, "xbzrle overflow: %" PRIu64 "\n",
+        monitor_printf(mon, "XBZRLE: size=%" PRIu64
+                       ", transferred=%" PRIu64
+                       ", pages=%" PRIu64
+                       ", miss=%" PRIu64 "\n"
+                       "  miss_rate=%0.2f"
+                       ", encode_rate=%0.2f"
+                       ", overflow=%" PRIu64 "\n",
+                       info->xbzrle_cache->cache_size,
+                       info->xbzrle_cache->bytes,
+                       info->xbzrle_cache->pages,
+                       info->xbzrle_cache->cache_miss,
+                       info->xbzrle_cache->cache_miss_rate,
+                       info->xbzrle_cache->encoding_rate,
                        info->xbzrle_cache->overflow);
     }
 
     if (info->has_cpu_throttle_percentage) {
-        monitor_printf(mon, "cpu throttle percentage: %" PRIu64 "\n",
+        monitor_printf(mon, "CPU Throttle (%%): %" PRIu64 "\n",
                        info->cpu_throttle_percentage);
     }
 
     if (info->has_dirty_limit_throttle_time_per_round) {
-        monitor_printf(mon, "dirty-limit throttle time: %" PRIu64 " us\n",
+        monitor_printf(mon, "Dirty-limit Throttle (us): %" PRIu64 "\n",
                        info->dirty_limit_throttle_time_per_round);
     }
 
     if (info->has_dirty_limit_ring_full_time) {
-        monitor_printf(mon, "dirty-limit ring full time: %" PRIu64 " us\n",
+        monitor_printf(mon, "Dirty-limit Ring Full (us): %" PRIu64 "\n",
                        info->dirty_limit_ring_full_time);
     }
 
     if (info->has_postcopy_blocktime) {
-        monitor_printf(mon, "postcopy blocktime: %u\n",
+        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
                        info->postcopy_blocktime);
     }
 
@@ -189,28 +211,12 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime,
                               &error_abort);
         visit_complete(v, &str);
-        monitor_printf(mon, "postcopy vcpu blocktime: %s\n", str);
+        monitor_printf(mon, "Postcopy vCPU Blocktime: %s\n", str);
         g_free(str);
         visit_free(v);
     }
-    if (info->has_socket_address) {
-        SocketAddressList *addr;
-
-        monitor_printf(mon, "socket address: [\n");
-
-        for (addr = info->socket_address; addr; addr = addr->next) {
-            char *s = socket_uri(addr->value);
-            monitor_printf(mon, "\t%s\n", s);
-            g_free(s);
-        }
-        monitor_printf(mon, "]\n");
-    }
-
-    if (info->vfio) {
-        monitor_printf(mon, "vfio device transferred: %" PRIu64 " kbytes\n",
-                       info->vfio->transferred >> 10);
-    }
 
+out:
     qapi_free_MigrationInfo(info);
 }
 
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c59cd6637b..639a450ee5 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -475,9 +475,9 @@ ERST
 
     {
         .name       = "migrate",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show migration status",
+        .args_type  = "all:-a",
+        .params     = "[-a]",
+        .help       = "show migration status (-a: all, dump all status)",
         .cmd        = hmp_info_migrate,
     },
 
-- 
2.49.0


