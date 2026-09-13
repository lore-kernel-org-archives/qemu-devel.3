Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46631C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hg9-0005fi-OM; Sun, 13 Sep 2026 06:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hg8-0005fX-8s
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hg6-0008GZ-QP
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7J7qfBqXlqHx3WOzneFvz6UOQQbOJ3xwxFjUEp/l0c=;
 b=RXUFNqYqbHCBIA2UPMaMGGsxeJrJconD0Jyvch7zKsitpScZDh9AjBuQdTmResPg1TrdKU
 oXo+uUF+tNLGMV31JJxTXwxbCpadoEd8IJO9kC5SMH0Yb+PPb8Yh2HyqFw8uKutID/t9q+
 nPYX6za8lks4AwdXTA/qo9DytWaB3+Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-v8ZE5lZpMDOedtXqo0Kpfw-1; Sun,
 13 Sep 2026 06:43:16 -0400
X-MC-Unique: v8ZE5lZpMDOedtXqo0Kpfw-1
X-Mimecast-MFC-AGG-ID: v8ZE5lZpMDOedtXqo0Kpfw_1789296195
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AB351802163
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:15 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8020F1956087
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:26 +0400
Subject: [GIT PULL 08/14] hw/display/qxl: trace skipped stale loadvm commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-8-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HbbMPGUZlXjzI38UEv8FHA4H8pYuzPQ5mOVIV6ZMolA=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4i0i/Fig/pzfRyFwfZoI2QXnX8WYtjnBj1j
 7n4O/+vJ5iJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IgAKCRDa6OEJdZac
 5ZAHD/de1n60uEz9z7Keo7a4Fflvzj7ZHWKUa7V0C1xDMrcCquK13Twclal4e+ZluQJuz7t2L/B
 lkdo0TRP4D4zzSICPIg8h/N17PV/JKXsnE2GtDIGC8bHtcFdpTIxQHzTeJ8IO+u+dMQrHJTBuD6
 znV4stU9qXbJFhQjSVybkJgKJ8FR54TqQ9p6ztfk9pi3l7879H5FJyU1hDjoCe1S0O7xsfDKlfK
 X7PNfqHDH2QvGMZxfoItVUHICxBswVkdH5zfYQGBYDJ74RKpEU51FY8MepCGE3LBK01Sj7w8Ype
 XrBJK2Pv1sQ2jjZPtZb0ADqerRmK9xYFYDX3aqvKCNGWBEnKebjKu5a05FbhLox5/QRqO4Qaev+
 DXoRV9V1uyP/GKvdO4te6zEw/DmrCJfafYLYqq5dgnS4TEmHnwtd450gI+cUFoSr48Q1UsYNVBN
 kYYqFfiwi0bLBmPsAU5cDgezYAy6/FpbmnecGvszrVXUJ217lcm75zc28BlkUMqIbUupkPVxBd1
 0AG5bCpEBhUztlE8NhgIDcLtUwHe9ltwj11SMyr6Z7v7hoFFHtvjA0rQq8ezWTZZjoXX4Cvcmdm
 wIY73SJjoWi2UtYJdd0IgfeXGZMQJeAL6CniBsHKqbyQuUeM8/8ElEyWCPOe45+xscpxS3lDgN1
 kAR9tIIviarDx
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Emit a trace event when qxl_post_load() drops a cursor or surface
command whose guest address no longer resolves, so a migration that
lands on a stale tracked pointer is visible instead of silent.

Message-ID: <20260825172051.435372-4-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/display/qxl.c        | 17 +++++++++++------
 hw/display/trace-events |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index fb77f217b1c6..d5f9771f5af2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2461,6 +2461,8 @@ static int qxl_post_load(void *opaque, int version)
             }
             if (!qxl_loadvm_cmd_valid(d, d->guest_surfaces.cmds[in],
                                       QXL_CMD_SURFACE)) {
+                trace_qxl_post_load_stale_cmd(d->id, "surface",
+                                              d->guest_surfaces.cmds[in]);
                 continue;
             }
             cmds[out].cmd.data = d->guest_surfaces.cmds[in];
@@ -2468,12 +2470,15 @@ static int qxl_post_load(void *opaque, int version)
             cmds[out].group_id = MEMSLOT_GROUP_GUEST;
             out++;
         }
-        if (d->guest_cursor &&
-            qxl_loadvm_cmd_valid(d, d->guest_cursor, QXL_CMD_CURSOR)) {
-            cmds[out].cmd.data = d->guest_cursor;
-            cmds[out].cmd.type = QXL_CMD_CURSOR;
-            cmds[out].group_id = MEMSLOT_GROUP_GUEST;
-            out++;
+        if (d->guest_cursor) {
+            if (qxl_loadvm_cmd_valid(d, d->guest_cursor, QXL_CMD_CURSOR)) {
+                cmds[out].cmd.data = d->guest_cursor;
+                cmds[out].cmd.type = QXL_CMD_CURSOR;
+                cmds[out].group_id = MEMSLOT_GROUP_GUEST;
+                out++;
+            } else {
+                trace_qxl_post_load_stale_cmd(d->id, "cursor", d->guest_cursor);
+            }
         }
         qxl_spice_loadvm_commands(d, cmds, out);
         g_free(cmds);
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 4bfc457fbac1..c5e7e42af23b 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -82,6 +82,7 @@ qxl_io_unexpected_vga_mode(int qid, uint64_t addr, uint64_t val, const char *des
 qxl_io_write(int qid, const char *mode, uint64_t addr, const char *aname, uint64_t val, unsigned size, int async) "%d %s addr=%"PRIu64 " (%s) val=%"PRIu64" size=%u async=%d"
 qxl_memslot_add_guest(int qid, uint32_t slot_id, uint64_t guest_start, uint64_t guest_end) "%d %u: guest phys 0x%"PRIx64 " - 0x%" PRIx64
 qxl_post_load(int qid, const char *mode) "%d %s"
+qxl_post_load_stale_cmd(int qid, const char *kind, uint64_t data) "%d skip stale %s cmd 0x%"PRIx64
 qxl_pre_load(int qid) "%d"
 qxl_pre_save(int qid) "%d"
 qxl_reset_surfaces(int qid) "%d"

-- 
2.55.0.543.g5ebe2ebe4ea8


