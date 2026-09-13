Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EE2C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hg5-0005f9-HA; Sun, 13 Sep 2026 06:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hg4-0005f1-6B
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hg2-0008DK-Ll
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ffn341LlTJcFicM5YT5PahGe5X1nuMJr/L7/6mA1AFA=;
 b=eZXEBDOneq/MCUOGHux8Carig9Jk9hejB+jLd7uSPyDQANSQNtqeuhzgIR6tPre10LfPSI
 cxhITklpHGAneB9HDw3gDziQIC5hyU9p2nlz7sW5k+PJUYLq9JahA0Uvdl9E9CDibXYRlA
 oHmzXG6y1HOzSRtzr9QiBHQgxgMcXX8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-H-GH0wFGML-u5N6RMFGRTw-1; Sun,
 13 Sep 2026 06:43:12 -0400
X-MC-Unique: H-GH0wFGML-u5N6RMFGRTw-1
X-Mimecast-MFC-AGG-ID: H-GH0wFGML-u5N6RMFGRTw_1789296191
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5EF718011F6
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:11 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB8031956087
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:25 +0400
Subject: [GIT PULL 07/14] hw/display/qxl: validate replayed commands in
 qxl_post_load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-7-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3425;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=s1f1LC/Q3DD/HRBujYP/N16KP0NEgC6UYpfjtotJyco=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4iKCVxTJSEQEhN26dmCk+5BH01dQu0lpb3L
 TqTmVMb/NaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IgAKCRDa6OEJdZac
 5ejZD/0cwbCKYlDLaU1wuJgjzeon2NATMNsf9Rr6JGrHXYoRAJdAxKXjN8GYT1NWUS/9XcQgCVQ
 PW5B8zh8dCJ78mgZ+FIt2w9p1ydh0Zu6D1h1yVGn8qBPWrlqr9c2JUFCPFnDlSeMLvc5PVXXqpi
 E69GZUPbTAFY2JDo+0yQYT//RM5JU0dYQeSypynvp/6PnNhn/XYU37LCMo6vgTEe1HcNkSAvq7F
 MDh3pemorXseaxrwO2tyztUKCAiCiRkdlj67baFhRD4c3nBLGv4OX1w0Ig+1dmtkkgHq+VVhcGK
 n9lNIculGUiLGbrfP4yU2HawnSyP5MQRMwrf9d9aFq3D/ssXtzAOPlYdNCJ01B/HCKEehjUsbi1
 11EDNLCRMzqGIw6XsQcO8PUmHZgqUvAjS4TEu3EmeAzZ5KmAd1gZrK19eMJ8vES9+dHi9rJndYa
 0UxglpCWS5zGBSVexhS9Jf46Xf+ZYApcMZjQdEkEuT8xo7W1YD32/op+6x50WCxvXFcSIYcVKq3
 M4OqKPrTce9/6aA+xZ3tE04xVLgXGiG0npx7ZYkaKbARH4UWfEKbTcXIsapk3OowBqRKnnHL1Sk
 8EUFVh0ugoH26aPe4NMcT0TsgAgfSMEErBYdMeZWGpvsK5Lq/IZ3yYdhtit4v7+i0grNrLlsNNr
 As48IBmbPJkw3qQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

On incoming migration qxl_post_load() replays the tracked cursor and
surface commands by handing their guest addresses straight to spice,
without revalidating them. Those addresses were checked when the guest
submitted them, but the guest may have freed or reused that memory
before migration, so qxl's tracked pointer can be stale. spice-server
then re-parses the command from that memory and, for a stale cursor,
reads a garbage shape pointer -- aborting the target in memslot_get_virt()
(again, spice-server function) and failing the migration.

Validate each replayed command with qxl_guest_phys2virt(report_bug=false)
before adding it to the replay list, and for a cursor also validate the
nested shape pointer. Commands that no longer resolve are skipped rather
than replayed. report_bug is false so a stale pointer is not mistaken for
a live guest error, which would needlessly disable a healthy guest's
display.

Message-ID: <20260825172051.435372-3-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/display/qxl.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index b6bc182fc2c3..fb77f217b1c6 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2390,6 +2390,37 @@ static void qxl_create_memslots(PCIQXLDevice *d)
     }
 }
 
+/*
+ * Validate a command tracked for loadvm replay before handing its guest
+ * address to spice-server.
+ */
+static bool qxl_loadvm_cmd_valid(PCIQXLDevice *d, QXLPHYSICAL data,
+                                 uint32_t type)
+{
+    switch (type) {
+    case QXL_CMD_SURFACE:
+        return qxl_guest_phys2virt(d, data,
+                                   sizeof(QXLSurfaceCmd), false) != NULL;
+
+    case QXL_CMD_CURSOR: {
+        QXLCursorCmd *cmd = qxl_guest_phys2virt(d, data, sizeof(QXLCursorCmd),
+                                                false);
+
+        if (!cmd) {
+            return false;
+        }
+        if (le32_to_cpu(cmd->type) == QXL_CURSOR_SET) {
+            return qxl_guest_phys2virt(d, le64_to_cpu(cmd->u.set.shape),
+                                       sizeof(QXLCursor), false) != NULL;
+        }
+        return true;
+    }
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static int qxl_post_load(void *opaque, int version)
 {
     PCIQXLDevice* d = opaque;
@@ -2428,12 +2459,17 @@ static int qxl_post_load(void *opaque, int version)
             if (d->guest_surfaces.cmds[in] == 0) {
                 continue;
             }
+            if (!qxl_loadvm_cmd_valid(d, d->guest_surfaces.cmds[in],
+                                      QXL_CMD_SURFACE)) {
+                continue;
+            }
             cmds[out].cmd.data = d->guest_surfaces.cmds[in];
             cmds[out].cmd.type = QXL_CMD_SURFACE;
             cmds[out].group_id = MEMSLOT_GROUP_GUEST;
             out++;
         }
-        if (d->guest_cursor) {
+        if (d->guest_cursor &&
+            qxl_loadvm_cmd_valid(d, d->guest_cursor, QXL_CMD_CURSOR)) {
             cmds[out].cmd.data = d->guest_cursor;
             cmds[out].cmd.type = QXL_CMD_CURSOR;
             cmds[out].group_id = MEMSLOT_GROUP_GUEST;

-- 
2.55.0.543.g5ebe2ebe4ea8


