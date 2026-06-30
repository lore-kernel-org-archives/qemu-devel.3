Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB8BC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaB8-0002go-JU; Tue, 30 Jun 2026 11:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaB7-0002ga-9f
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaB5-000095-St
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nyb+QiJafndVMzw69KLmfCh9TRyCjbVtvIVgo3SIUg0=;
 b=N9/ta8/gvfYj/VhQr6P1xsHpRgu4Tpj3JOhwZq9eO+H3QNrc4pAYKA1OAfI712vhGSh0N3
 /mMkXnPDuP3AsFnJII+pkXUJGAtodCTMMOyDGC3Wdw55nxwNgOhlBYKOWyvL+YKXLttEGm
 nifZiMlKdYlrj8OSrv89JaPNLpuEO6w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-NLRcfKm-P5ezzvWHIHQaYA-1; Tue,
 30 Jun 2026 11:15:08 -0400
X-MC-Unique: NLRcfKm-P5ezzvWHIHQaYA-1
X-Mimecast-MFC-AGG-ID: NLRcfKm-P5ezzvWHIHQaYA_1782832507
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADE071802664
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:15:07 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C336A1956068; Tue, 30 Jun 2026 15:15:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 19:13:18 +0400
Subject: [GIT PULL 3/8] system/cpus: refuse memsave/pmemsave while guest
 RAM is being migrated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-dump-v1-3-7df3087dffc9@redhat.com>
References: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
In-Reply-To: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dMyitmawkA0irUeHeZPgJ9NlFJzjYFkln3tC9a0Qg4g=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBqQ91nmHDr8Ctk2gnGy11or5hUTbuYrJVZDKuRG
 iwxdZRoQHaJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakPdZwAKCRDa6OEJdZac
 5dhVD/YoLGPNyUzSWXr9dPVfqc3htlAA4VWMR/zMp5W9ZxNixQXdp5WmgapnJca6xr9BtL6FCOL
 /1Ou4QjBp/+DlSe/coqMCGxAFi0O1dk04nrlQkYq3vRKV8QjpdT8rgLUUGOjhNmeGSoB0O3X8id
 19ULotSpMZqAWjmEb1JSfF42NlcLvX3bT0/lsPRiYY4xA7mbWG7doxDipFrPSArGQK+QR+WlihW
 MvwQG8o3/LHjBhA2jH3pqbhRhsM4Qx3CuDrx91SHbVNUIGywQAYJQdu1gTyUEgyWNhzI7gtx39t
 mEAyFkmR1bMc98tfVnnr56I9U7tOllqa3fDsQIFLNqod1EmzkdV44FezxpKOI2MEF3cJmNmqybv
 4t4T5eU+Y5ivno/gPQ0AtcaPson2yVXjDRqAZPyOmX0UAzuB8IWhuXG3nQ+TyuFCXBT7cO8CT6a
 7rDldGbtQ+zx7z2uF+tWACa02+gEUVlXvV1r9v47tFUCJdZClLLFSmW3y+UpgTlhXELU0yLiEc/
 v2U5aA+EgHIBu7A4QoJ8gScthp7CSWnL1qVM/s7yZ++2s7ZU9Sv0NQbtyOwBbJ6OQ3302nXu0le
 Ubi+c9EpWJcMkb+hx4a8Y3NYnKmVFoOS/ILjDns8zGRkH9kUMZOc6afsyG0dSVVgHKdsQuydGKC
 OTOEP3+iV1lyd
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: "Denis V. Lunev" <den@openvz.org>

memsave and pmemsave read guest memory and write it to a file, with no
guard at all. They run on the main thread with the BQL held, so on a
postcopy destination touching a not-yet-received page deadlocks: the
thread blocks on the userfault while the postcopy incoming path waits for
the BQL to install that page. During precopy the read returns incomplete
state instead.

Refuse both while guest RAM is still being received, using the same
migration_guest_ram_loading() check as dump-guest-memory.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260619101834.228432-4-den@openvz.org>
---
 system/cpus.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/system/cpus.c b/system/cpus.c
index 49f6daec3cd..b31c825b464 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -43,6 +43,7 @@
 #include "system/physmem.h"
 #include "system/replay.h"
 #include "system/runstate.h"
+#include "migration/misc.h"
 #include "system/cpu-timers.h"
 #include "system/whpx.h"
 #include "hw/core/boards.h"
@@ -843,6 +844,11 @@ void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
     uint8_t buf[1024];
     uint64_t orig_addr = addr, orig_size = size;
 
+    if (migration_guest_ram_loading()) {
+        error_setg(errp, "Guest memory access not allowed during migration");
+        return;
+    }
+
     if (!has_cpu) {
         cpu_index = 0;
     }
@@ -889,6 +895,11 @@ void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
     uint64_t l;
     uint8_t buf[1024];
 
+    if (migration_guest_ram_loading()) {
+        error_setg(errp, "Guest memory access not allowed during migration");
+        return;
+    }
+
     f = fopen(filename, "wb");
     if (!f) {
         error_setg_file_open(errp, errno, filename);

-- 
2.54.0


