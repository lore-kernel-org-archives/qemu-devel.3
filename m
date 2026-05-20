Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E1DCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPooM-0006uF-Tn; Wed, 20 May 2026 17:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPooL-0006u7-QI
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPooK-000490-9n
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ho9+bos+FxoxTK+kgywlHgnaViRN8O0JYKchFHfp2lE=;
 b=X9X5wQmpTLsXS5/eup1bZQULehXlX6zTOUjlCK0arcmSRgjS7AoccWEn1SQf1SMQVEofil
 76l8uzxdXt1pNv34PTmhaPs90INWok3dFfXlBUfg9GrqQNNYnRHmRcEj5u5XOHkFMt+4mD
 9ZJI5KYaSE+Wpndg1DVKxi1RNAasEzE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-npeDwFhzOtyNeGkKm6LFkQ-1; Wed,
 20 May 2026 17:50:36 -0400
X-MC-Unique: npeDwFhzOtyNeGkKm6LFkQ-1
X-Mimecast-MFC-AGG-ID: npeDwFhzOtyNeGkKm6LFkQ_1779313836
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F22FC1956053
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:50:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 907F61681; Wed, 20 May 2026 21:50:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:06 +0400
Subject: [PATCH 05/40] system: move gpa2hva() to system memory unit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-5-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4236;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xFi/sRUUClGuN6YVMPpbyquIv/44+h9uGV2sti/w3V0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyCtVSz0SER6KMLTZgpkQhIUq54+QMXIDU1W
 eNatMzRth+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5cMBEACXLPuzBs3YjezmdQxV0ZJDL4KeKrgTFGfdprRePeU6WmqAuPhYXpO94w3ZUpomtDU9mL7
 5v4RlBdIXJ27Vl+8DFoRPPYMzvd4JTF35DfrqzFq2DjxjCaF2w+d1U9IkJxYZXqnwiYjp+OeHK/
 V6p5HhEYGHuHe2P+Bna/ADcUlgvPlxWItUzVLMyaEbd6vRjCofHexxRN8Tu8HUAIvwHVYct4NiF
 SZsm7I1wm/N4aP1akyX88pxc6JIAmq9zRbH+ohsVlJuIkZti93yhEQREKvGkKLW8p7c9er/a/sy
 +YM13xl1B75/H3PP29btsyB2+xSTajT18n25XilK1HbEOMdz99ix4KjtevAZ2ruwXH3MbE9avOi
 +u3Bq/PlJ/G+DVq9U5Q8adpxQ03n0Hhf4DKWOwjVt2d9tczrJMpBu0WorIxoOO82lq3EKqIqQZg
 k0fg5Ffvt1oDI34rfElTfK8OvYGBwCdxuIUC8ArdslWUvNEhbKZGumHTIdI0I/s/7cJWYHEWifp
 PKlFs2kAIRoWxpABbZXGgUEu209wdef/Tpac01ssc8h8AxSnxzOojBh9CPDkHPnMFQJ4n7Qmktw
 cUu31tlutvaqBW5Ki7mKNaIIAqfwBHBt+b1k2b7LWisgqRKZQPVD5DglQU8nBgWpMPx9kU1ksBo
 HLO+DfP9Acx17Dw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/monitor.h |  2 --
 include/system/memory.h   |  2 ++
 monitor/hmp-cmds.c        | 31 -------------------------------
 system/physmem.c          | 31 +++++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 55649a86641..17182e626a7 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -42,8 +42,6 @@ int monitor_get_cpu_index(Monitor *mon);
 int monitor_puts_locked(Monitor *mon, const char *str);
 void monitor_flush_locked(Monitor *mon);
 
-void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
-
 void monitor_read_command(MonitorHMP *mon, int show_prompt);
 int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
                           void *opaque);
diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d9..e2724e38532 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -3063,4 +3063,6 @@ bool ram_block_discard_is_required(void);
 void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
 void ram_block_del_cpr_blocker(RAMBlock *rb);
 
+void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
+
 #endif
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 443b8c785dc..521ab8a641c 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -709,37 +709,6 @@ void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
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
index 7bcbf875736..90bf857c9df 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4477,3 +4477,34 @@ void ram_block_del_cpr_blocker(RAMBlock *rb)
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
2.54.0


