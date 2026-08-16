Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5789FC5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgIw-00008D-7n; Sun, 16 Aug 2026 15:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIS-0008Mc-9Z
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIQ-0007KH-7O
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6kUigrlIhW5lDQflJBIlNr7RimcAGbj2MbyqJLdEI4=;
 b=C7MsXkAczPNH1VJCuzhZL2Yr6CzEwu7qiqheIKrJ4I0NDfFudE/c/LjfKelVztLJAYlStu
 ntFO7QUN0EqAOh4Zu1Q0z/0+WVDwiCy7Ksk5f6tfLOphSeDEhHl1x6K9QTgQuHH7bHjpp6
 A0iRQEEGBH55c5TApF9Kf1m4IpFkYPE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-I6NqQiiZPFSZ3mcSr-vKhQ-1; Sun,
 16 Aug 2026 15:13:21 -0400
X-MC-Unique: I6NqQiiZPFSZ3mcSr-vKhQ-1
X-Mimecast-MFC-AGG-ID: I6NqQiiZPFSZ3mcSr-vKhQ_1786907600
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42FB0180034F; Sun, 16 Aug 2026 19:13:20 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E77FD18005BB; Sun, 16 Aug 2026 19:13:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:33 +0400
Subject: [PATCH v3 06/49] system: move gpa2hva() to system memory unit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-6-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4376;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UkN1HvNZWl3MPBsr0N0lhRKtt1UrsfqkUkLxVSggBA4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguwUrb9P1SPZlHh6ucauDTbvekfPt7jWriNA
 FbXtzbbi++JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsAAKCRDa6OEJdZac
 5bC/D/9mlkFvDEfO/4ztvtYRKmLr529qN75cJiDOJmvE9UTPRJOJpnQtfSXLw/fTAq/JACnCvb4
 chC6LVkDiIvaDb/epjEZE4wxc6WUm045XqD8dl/V+8oyd1+DicdvrIXZ+fmZGTTvaaMVmtsKX+C
 tfw2zfPwNeTwIDpQ1UIX2WI82yGshu4W5G211g5CULZkVsfFjuPzSC477x9Vo49uYHCRQP5XF6r
 dlA3ph8FwE1W6pYFXP03g8kNlwgvNqpy8tiby+k6Tv7gYpPAt1GvEmY+3HEwPIVhqKczT+1dU5A
 NmDrilSDkpRXXmt3iGrMYoWlMDskqfc5GFGKf7/QKpYqugwQyv6uULsEEgybCsljIIbq/PoJxIc
 uIIMGKhA5FMCjV9HnThd9Yx2ILlN6fhCsINQhYGuGlcDofZ6+dOY2vVAdjiCYe47hUwJc5pxU5R
 O7HhgrdWzCbr1jzXRIG8C4uDz7XH5ssy0NxbuTKVozqB7WhAfEHWDg497lcGCsSNbEyHYC3PkC9
 lcNQ/emr/9ChfeiyOy0zlSyjvnzNTn5QzbOxTJ2V2Z4dcfdIadeXUDka9uz9aDCU7Smc72RoGoQ
 A6sPTwMr/IvIS9R4tm7dybeVWxVFFFsVxVuZWDWvYf6AXLlsE1GEpqujC9wtEONJa1XzNydwfle
 xnH5fbdGgqkMrJg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

The function is now used by SEV code path. Move it to physmem.c rather
than hmp-cmds.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/monitor.h |  2 --
 include/system/memory.h   |  2 ++
 monitor/hmp-cmds.c        | 31 -------------------------------
 system/physmem.c          | 31 +++++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 54134f2aa4fc..9f048ba103b5 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -53,8 +53,6 @@ int monitor_get_cpu_index(Monitor *mon);
 int monitor_puts_locked(Monitor *mon, const char *str);
 void monitor_flush_locked(Monitor *mon);
 
-void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
-
 void monitor_read_command(MonitorHMP *hmp, int show_prompt);
 int monitor_read_password(MonitorHMP *hmp, ReadLineFunc *readline_func,
                           void *opaque);
diff --git a/include/system/memory.h b/include/system/memory.h
index 1dc761058f52..a7e03fc3e7c3 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2860,4 +2860,6 @@ bool ram_block_discard_is_required(void);
 void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
 void ram_block_del_cpr_blocker(RAMBlock *rb);
 
+void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
+
 #endif
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 4e8d996dbb5b..6b1114fdaf13 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -712,37 +712,6 @@ void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
     memory_dump(mon, count, format, size, addr, true);
 }
 
-void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
-{
-    Int128 gpa_region_size;
-    MemoryRegionSection mrs = memory_region_find(get_system_memory(),
-                                                 addr, size);
-
-    if (!mrs.mr) {
-        error_setg(errp,
-                   "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
-        return NULL;
-    }
-
-    if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
-        error_setg(errp,
-                   "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
-        memory_region_unref(mrs.mr);
-        return NULL;
-    }
-
-    gpa_region_size = int128_make64(size);
-    if (int128_lt(mrs.size, gpa_region_size)) {
-        error_setg(errp, "Size of memory region at 0x%" HWADDR_PRIx
-                   " exceeded.", addr);
-        memory_region_unref(mrs.mr);
-        return NULL;
-    }
-
-    *p_mr = mrs.mr;
-    return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
-}
-
 void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
 {
     hwaddr addr = qdict_get_int(qdict, "addr");
diff --git a/system/physmem.c b/system/physmem.c
index 362a00f76c03..a4a6a4710c64 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4534,3 +4534,34 @@ void ram_block_del_cpr_blocker(RAMBlock *rb)
 {
     migrate_del_blocker(&rb->cpr_blocker);
 }
+
+void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
+{
+    Int128 gpa_region_size;
+    MemoryRegionSection mrs = memory_region_find(get_system_memory(),
+                                                 addr, size);
+
+    if (!mrs.mr) {
+        error_setg(errp,
+                   "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
+        return NULL;
+    }
+
+    if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
+        error_setg(errp,
+                   "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
+        memory_region_unref(mrs.mr);
+        return NULL;
+    }
+
+    gpa_region_size = int128_make64(size);
+    if (int128_lt(mrs.size, gpa_region_size)) {
+        error_setg(errp, "Size of memory region at 0x%" HWADDR_PRIx
+                   " exceeded.", addr);
+        memory_region_unref(mrs.mr);
+        return NULL;
+    }
+
+    *p_mr = mrs.mr;
+    return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
+}

-- 
2.55.0.543.g5ebe2ebe4ea8


