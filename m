Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB97DC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvNF-0004oM-9g; Fri, 28 Aug 2026 08:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvMv-0004LC-TD
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvMn-0003I5-Hq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+vfO+Pykglrugk5y0aV4L3Oo/Rp8qqQbzbN02deUOE=;
 b=eZcaaFlU6wfjxGR4sf2mbNXeZ0LDrP7FdHqsbULeH90fP0/qDUUKxLJfbvTK0S+N3A6dbA
 tIgbyYKHJY9WUW1EMKgIIphnkVjZaB50ULsQjjsK46PzauTgq0x0nHWt9FNKrqG44IJt9R
 +ya4ARjDKo4ImAmhZsgOAjjKVTslo7A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-QKHuxLSdOQq6zeoZ9Rkjxw-1; Fri,
 28 Aug 2026 08:07:24 -0400
X-MC-Unique: QKHuxLSdOQq6zeoZ9Rkjxw-1
X-Mimecast-MFC-AGG-ID: QKHuxLSdOQq6zeoZ9Rkjxw_1787918842
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D97C518C0FC9; Fri, 28 Aug 2026 12:07:21 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE1371955F05; Fri, 28 Aug 2026 12:07:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:29 +0400
Subject: [PATCH v5 32/50] monitor: make hmp_handle_error() take MonitorHMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-32-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Hyman Huang <infra.ai.cloud@bitdeer.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=45121;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oBk6f4fNLAvSkDI471Y9XyR1zhk8r3684wYMXyNhlZQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk5SjAlZCX+BC48I9re2r+QQ2kzaMNV8lAh6
 pGy2xFmNU6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OQAKCRDa6OEJdZac
 5ZaQD/9hjCRAn1P6TYuAuLNAXX1cLjU9yWl0hSL3KmpMXSnSckNcWicBMuJEIYfs5C0USZU18A4
 OD8G5DiUBbttTaDczyYaeYrX++bMYIA4QumhSYLhuL1NZCsQX+g6thTXbEmXIwFpBOsN8k17DlF
 L6hNfXh48T6oj8CGstr/IrMOxecJeRyTLjQx+Fd4/5K8yJFg5EAae1WtQ26fyBekLSyfEhzifIk
 kC9mvFFuB9/eRer93ly7uNXXwSp8H6rKYXvV8A+tnR1K2YY3wvDZfLUJnobDH8U4I96FXwux4t0
 yWY2ZqE0OlnIHZfzV48J5RgCvu6iNLcm7je6cweNyKBFkDQ0is695rFGsrxghVBJZ0rBvr93l4q
 QEl6YzIq0qC+oV5gDvx92rDiTrJDCjPwbbVUu1Aml2aHgAiKdbUNLiu6KCor8y+Z4sTY6aRDum4
 aFPicx0CaJf3rPVpDPkNk/l9/RgJuQGHsD8VB7oYC509uFwuBp6iVUWWtpfErAAlVz8zkynRCM0
 nrlJclg6NS0rNVwiTUKgKnhLUcdCiaAzHw1d11PLYbwTxSeClV0QPasT5MJ4cGyaLm8Y7POzGRK
 fEbbVRuPbPQ/Kqk/PDiwONLfO4xXhU8wYTgrs5obbuGq/9w+0CfP8lzNpsaBdNX1eS75DkyAYZl
 1ORWPDUowbVePsg==
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Mostly mechanical, with a few adjustments around it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/monitor/block-hmp-cmds.c  | 73 +++++++++++++++--------------------------
 chardev/char-hmp-cmds.c         | 17 ++++------
 dump/dump-hmp-cmds.c            |  5 ++-
 hw/core/machine-hmp-cmds.c      | 26 +++++++--------
 hw/i386/kvm/xen_evtchn.c        |  4 +--
 hw/misc/mos6522.c               |  2 +-
 hw/net/rocker/rocker-hmp-cmds.c |  8 ++---
 hw/pci/pci-hmp-cmds.c           |  2 +-
 hw/uefi/ovmf-log.c              |  2 +-
 hw/virtio/virtio-hmp-cmds.c     | 10 +++---
 include/monitor/hmp.h           |  2 +-
 migration/dirtyrate.c           |  2 +-
 migration/migration-hmp-cmds.c  | 41 +++++++++--------------
 monitor/hmp-cmds.c              | 23 +++++--------
 monitor/hmp.c                   | 12 +++----
 net/net-hmp-cmds.c              | 11 +++----
 qom/qom-hmp-cmds.c              | 13 +++-----
 system/dirtylimit-hmp-cmds.c    |  7 ++--
 system/qdev-monitor.c           |  6 ++--
 system/runstate-hmp-cmds.c      |  3 +-
 target/i386/monitor.c           |  3 +-
 ui/ui-hmp-cmds.c                | 19 ++++-------
 22 files changed, 114 insertions(+), 177 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 3914b5189d56..a2666e2f1b9b 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -57,7 +57,7 @@
 #include "block/block_int.h"
 #include "block/block-hmp-cmds.h"
 
-static void hmp_drive_add_node(Monitor *mon, const char *optstr)
+static void hmp_drive_add_node(MonitorHMP *hmp, const char *optstr)
 {
     QemuOpts *opts;
     QDict *qdict;
@@ -84,7 +84,7 @@ static void hmp_drive_add_node(Monitor *mon, const char *optstr)
     bdrv_set_monitor_owned(bs);
 out:
     qemu_opts_del(opts);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_drive_add(MonitorHMP *hmp, const QDict *qdict)
@@ -98,7 +98,7 @@ void hmp_drive_add(MonitorHMP *hmp, const QDict *qdict)
     bool node = qdict_get_try_bool(qdict, "node", false);
 
     if (node) {
-        hmp_drive_add_node(mon, optstr);
+        hmp_drive_add_node(hmp, optstr);
         return;
     }
 
@@ -133,12 +133,11 @@ err:
         monitor_remove_blk(blk);
         blk_unref(blk);
     }
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_drive_del(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *id = qdict_get_str(qdict, "id");
     BlockBackend *blk;
     BlockDriverState *bs;
@@ -193,12 +192,11 @@ void hmp_drive_del(MonitorHMP *hmp, const QDict *qdict)
 
 unlock:
     bdrv_graph_rdunlock_main_loop();
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_commit(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     BlockBackend *blk;
     int ret;
@@ -232,12 +230,11 @@ void hmp_commit(MonitorHMP *hmp, const QDict *qdict)
     }
 
 end:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_drive_mirror(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *filename = qdict_get_str(qdict, "target");
     const char *format = qdict_get_try_str(qdict, "format");
     bool reuse = qdict_get_try_bool(qdict, "reuse", false);
@@ -259,12 +256,11 @@ void hmp_drive_mirror(MonitorHMP *hmp, const QDict *qdict)
     }
     qmp_drive_mirror(&mirror, &err);
 end:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_drive_backup(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *filename = qdict_get_str(qdict, "target");
     const char *format = qdict_get_try_str(qdict, "format");
@@ -290,69 +286,63 @@ void hmp_drive_backup(MonitorHMP *hmp, const QDict *qdict)
 
     qmp_drive_backup(&backup, &err);
 end:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_block_job_set_speed(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
     int64_t value = qdict_get_int(qdict, "speed");
 
     qmp_block_job_set_speed(device, value, &error);
 
-    hmp_handle_error(mon, error);
+    hmp_handle_error(hmp, error);
 }
 
 void hmp_block_job_cancel(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
     bool force = qdict_get_try_bool(qdict, "force", false);
 
     qmp_block_job_cancel(device, true, force, &error);
 
-    hmp_handle_error(mon, error);
+    hmp_handle_error(hmp, error);
 }
 
 void hmp_block_job_pause(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
 
     qmp_block_job_pause(device, &error);
 
-    hmp_handle_error(mon, error);
+    hmp_handle_error(hmp, error);
 }
 
 void hmp_block_job_resume(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
 
     qmp_block_job_resume(device, &error);
 
-    hmp_handle_error(mon, error);
+    hmp_handle_error(hmp, error);
 }
 
 void hmp_block_job_complete(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
 
     qmp_block_job_complete(device, &error);
 
-    hmp_handle_error(mon, error);
+    hmp_handle_error(hmp, error);
 }
 
 void hmp_snapshot_blkdev(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *filename = qdict_get_str(qdict, "snapshot-file");
     const char *format = qdict_get_try_str(qdict, "format");
@@ -363,35 +353,32 @@ void hmp_snapshot_blkdev(MonitorHMP *hmp, const QDict *qdict)
     mode = reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUTE_PATHS;
     qmp_blockdev_snapshot_sync(device, NULL, filename, NULL, format,
                                true, mode, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_snapshot_blkdev_internal(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *name = qdict_get_str(qdict, "name");
     Error *err = NULL;
 
     qmp_blockdev_snapshot_internal_sync(device, name, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_snapshot_delete_blkdev_internal(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *name = qdict_get_str(qdict, "name");
     const char *id = qdict_get_try_str(qdict, "id");
     Error *err = NULL;
 
     qmp_blockdev_snapshot_delete_internal_sync(device, id, name, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_nbd_server_start(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *uri = qdict_get_str(qdict, "uri");
     bool writable = qdict_get_try_bool(qdict, "writable", false);
     bool all = qdict_get_try_bool(qdict, "all", false);
@@ -449,12 +436,11 @@ void hmp_nbd_server_start(MonitorHMP *hmp, const QDict *qdict)
     qapi_free_BlockInfoList(block_list);
 
 exit:
-    hmp_handle_error(mon, local_err);
+    hmp_handle_error(hmp, local_err);
 }
 
 void hmp_nbd_server_add(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *name = qdict_get_try_str(qdict, "name");
     bool writable = qdict_get_try_bool(qdict, "writable", false);
@@ -468,44 +454,40 @@ void hmp_nbd_server_add(MonitorHMP *hmp, const QDict *qdict)
     };
 
     qmp_nbd_server_add(&export, &local_err);
-    hmp_handle_error(mon, local_err);
+    hmp_handle_error(hmp, local_err);
 }
 
 void hmp_nbd_server_remove(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *name = qdict_get_str(qdict, "name");
     bool force = qdict_get_try_bool(qdict, "force", false);
     Error *err = NULL;
 
     /* Rely on BLOCK_EXPORT_REMOVE_MODE_SAFE being the default */
     qmp_nbd_server_remove(name, force, BLOCK_EXPORT_REMOVE_MODE_HARD, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_nbd_server_stop(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_nbd_server_stop(&err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void coroutine_fn hmp_block_resize(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     int64_t size = qdict_get_int(qdict, "size");
     Error *err = NULL;
 
     qmp_block_resize(device, NULL, size, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_block_stream(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
     const char *base = qdict_get_try_str(qdict, "base");
@@ -516,12 +498,11 @@ void hmp_block_stream(MonitorHMP *hmp, const QDict *qdict)
                      true, BLOCKDEV_ON_ERROR_REPORT, NULL,
                      false, false, false, false, &error);
 
-    hmp_handle_error(mon, error);
+    hmp_handle_error(hmp, error);
 }
 
 void hmp_block_set_io_throttle(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     char *device = (char *) qdict_get_str(qdict, "device");
     BlockIOThrottle throttle = {
@@ -545,23 +526,21 @@ void hmp_block_set_io_throttle(MonitorHMP *hmp, const QDict *qdict)
     }
 
     qmp_block_set_io_throttle(&throttle, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_eject(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     bool force = qdict_get_try_bool(qdict, "force", false);
     const char *device = qdict_get_str(qdict, "device");
     Error *err = NULL;
 
     qmp_eject(device, NULL, true, force, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_qemu_io(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     bool qdev = qdict_get_try_bool(qdict, "qdev", false);
     const char *device = qdict_get_str(qdict, "device");
     const char *command = qdict_get_str(qdict, "command");
@@ -570,7 +549,7 @@ void hmp_qemu_io(MonitorHMP *hmp, const QDict *qdict)
     qmp_x_qemu_io(qdev ? NULL : device,
                   qdev ? device : NULL,
                   command, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 static void print_block_info(Monitor *mon, BlockInfo *info,
@@ -851,7 +830,7 @@ void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
 
     bs = bdrv_all_find_vmstate_bs(NULL, false, NULL, &err);
     if (!bs) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
diff --git a/chardev/char-hmp-cmds.c b/chardev/char-hmp-cmds.c
index d4a5a3a255a5..71017fd2d19e 100644
--- a/chardev/char-hmp-cmds.c
+++ b/chardev/char-hmp-cmds.c
@@ -40,14 +40,13 @@ void hmp_info_chardev(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_ringbuf_write(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *chardev = qdict_get_str(qdict, "device");
     const char *data = qdict_get_str(qdict, "data");
     Error *err = NULL;
 
     qmp_ringbuf_write(chardev, data, false, 0, &err);
 
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_ringbuf_read(MonitorHMP *hmp, const QDict *qdict)
@@ -60,7 +59,7 @@ void hmp_ringbuf_read(MonitorHMP *hmp, const QDict *qdict)
     int i;
 
     data = qmp_ringbuf_read(chardev, size, false, 0, &err);
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
 
@@ -82,7 +81,6 @@ void hmp_ringbuf_read(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_chardev_add(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *args = qdict_get_str(qdict, "args");
     Error *err = NULL;
     QemuOpts *opts;
@@ -94,12 +92,11 @@ void hmp_chardev_add(MonitorHMP *hmp, const QDict *qdict)
         qemu_chr_new_from_opts(opts, NULL, &err);
         qemu_opts_del(opts);
     }
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_chardev_change(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *args = qdict_get_str(qdict, "args");
     const char *id;
     Error *err = NULL;
@@ -129,25 +126,23 @@ end:
     qapi_free_ChardevReturn(ret);
     qapi_free_ChardevBackend(backend);
     qemu_opts_del(opts);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_chardev_remove(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *local_err = NULL;
 
     qmp_chardev_remove(qdict_get_str(qdict, "id"), &local_err);
-    hmp_handle_error(mon, local_err);
+    hmp_handle_error(hmp, local_err);
 }
 
 void hmp_chardev_send_break(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *local_err = NULL;
 
     qmp_chardev_send_break(qdict_get_str(qdict, "id"), &local_err);
-    hmp_handle_error(mon, local_err);
+    hmp_handle_error(hmp, local_err);
 }
 
 void chardev_add_completion(ReadLineState *rs, int nb_args, const char *str)
diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
index ba78ad026f1e..104ab5d2a53a 100644
--- a/dump/dump-hmp-cmds.c
+++ b/dump/dump-hmp-cmds.c
@@ -14,7 +14,6 @@
 
 void hmp_dump_guest_memory(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     bool win_dmp = qdict_get_try_bool(qdict, "windmp", false);
     bool paging = qdict_get_try_bool(qdict, "paging", false);
@@ -34,7 +33,7 @@ void hmp_dump_guest_memory(MonitorHMP *hmp, const QDict *qdict)
 
     if (zlib + lzo + snappy + win_dmp > 1) {
         error_setg(&err, "only one of '-z|-l|-s|-w' can be set");
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
@@ -80,7 +79,7 @@ void hmp_dump_guest_memory(MonitorHMP *hmp, const QDict *qdict)
 
     qmp_dump_guest_memory(paging, prot, true, detach, has_begin, begin,
                           has_length, length, true, dump_format, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
     g_free(prot);
 }
 
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 48fa27f12705..4e2f0c212b0d 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -57,7 +57,7 @@ void hmp_hotpluggable_cpus(MonitorHMP *hmp, const QDict *qdict)
     HotpluggableCPUList *saved = l;
     CpuInstanceProperties *c;
 
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
 
@@ -147,7 +147,7 @@ void hmp_info_memdev(MonitorHMP *hmp, const QDict *qdict)
     monitor_printf(mon, "\n");
 
     qapi_free_MemdevList(memdev_list);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_info_kvm(MonitorHMP *hmp, const QDict *qdict)
@@ -202,7 +202,7 @@ void hmp_info_balloon(MonitorHMP *hmp, const QDict *qdict)
     Error *err = NULL;
 
     info = qmp_query_balloon(&err);
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
 
@@ -236,47 +236,43 @@ void hmp_memsave(MonitorHMP *hmp, const QDict *qdict)
     }
 
     qmp_memsave(addr, size, filename, true, cpu_index, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_pmemsave(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     uint32_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
 
     qmp_pmemsave(addr, size, filename, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_system_wakeup(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_system_wakeup(&err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_nmi(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_inject_nmi(&err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_balloon(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     int64_t value = qdict_get_int(qdict, "value");
     Error *err = NULL;
 
     qmp_balloon(value, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_info_memory_devices(MonitorHMP *hmp, const QDict *qdict)
@@ -380,7 +376,7 @@ void hmp_info_memory_devices(MonitorHMP *hmp, const QDict *qdict)
     }
 
     qapi_free_MemoryDeviceInfoList(info_list);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_info_vm_generation_id(MonitorHMP *hmp, const QDict *qdict)
@@ -391,7 +387,7 @@ void hmp_info_vm_generation_id(MonitorHMP *hmp, const QDict *qdict)
     if (info) {
         monitor_printf(mon, "%s\n", info->guid);
     }
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
     qapi_free_GuidInfo(info);
 }
 
@@ -411,5 +407,5 @@ void hmp_info_memory_size_summary(MonitorHMP *hmp, const QDict *qdict)
 
         qapi_free_MemoryInfo(info);
     }
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 845838c372d5..00dff6ee8760 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -2352,7 +2352,7 @@ void hmp_xen_event_list(MonitorHMP *hmp, const QDict *qdict)
 
     info_list = qmp_xen_event_list(&err);
     if (err) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
@@ -2388,7 +2388,7 @@ void hmp_xen_event_inject(MonitorHMP *hmp, const QDict *qdict)
 
     qmp_xen_event_inject(port, &err);
     if (err) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
     } else {
         monitor_printf(mon, "Delivered port %d\n", port);
     }
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 15a6a1a75745..1c20c7582c34 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -592,7 +592,7 @@ void hmp_info_via(MonitorHMP *hmp, const QDict *qdict)
     Error *err = NULL;
     g_autoptr(HumanReadableText) info = qmp_x_query_via(&err);
 
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
     monitor_puts(mon, info->human_readable_text);
diff --git a/hw/net/rocker/rocker-hmp-cmds.c b/hw/net/rocker/rocker-hmp-cmds.c
index 856aaef5e210..6405ce26dd65 100644
--- a/hw/net/rocker/rocker-hmp-cmds.c
+++ b/hw/net/rocker/rocker-hmp-cmds.c
@@ -28,7 +28,7 @@ void hmp_rocker(MonitorHMP *hmp, const QDict *qdict)
     Error *err = NULL;
 
     rocker = qmp_query_rocker(name, &err);
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
 
@@ -47,7 +47,7 @@ void hmp_rocker_ports(MonitorHMP *hmp, const QDict *qdict)
     Error *err = NULL;
 
     list = qmp_query_rocker_ports(name, &err);
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
 
@@ -76,7 +76,7 @@ void hmp_rocker_of_dpa_flows(MonitorHMP *hmp, const QDict *qdict)
     Error *err = NULL;
 
     list = qmp_query_rocker_of_dpa_flows(name, tbl_id != -1, tbl_id, &err);
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
 
@@ -226,7 +226,7 @@ void hmp_rocker_of_dpa_groups(MonitorHMP *hmp, const QDict *qdict)
     Error *err = NULL;
 
     list = qmp_query_rocker_of_dpa_groups(name, type != 9, type, &err);
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
 
diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index be24aecc8ac8..51d95d76620e 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -247,5 +247,5 @@ void hmp_pcie_aer_inject_error(MonitorHMP *hmp, const QDict *qdict)
                    PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 
 out:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index c97622b2aad6..0d59a74ad60e 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -269,7 +269,7 @@ void hmp_info_firmware_log(MonitorHMP *hmp, const QDict *qdict)
     maxsize = qdict_get_try_int(qdict, "max-size", -1);
     log = qmp_query_firmware_log(maxsize != -1, (uint64_t)maxsize, &err);
     if (err)  {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 49f3367785ba..fb36c8b9274c 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -88,7 +88,7 @@ void hmp_virtio_query(MonitorHMP *hmp, const QDict *qdict)
     VirtioInfoList *node;
 
     if (err != NULL) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
@@ -114,7 +114,7 @@ void hmp_virtio_status(MonitorHMP *hmp, const QDict *qdict)
     VirtioStatus *s = qmp_x_query_virtio_status(path, &err);
 
     if (err != NULL) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
@@ -195,7 +195,7 @@ void hmp_vhost_queue_status(MonitorHMP *hmp, const QDict *qdict)
         qmp_x_query_virtio_vhost_queue_status(path, queue, &err);
 
     if (err != NULL) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
@@ -228,7 +228,7 @@ void hmp_virtio_queue_status(MonitorHMP *hmp, const QDict *qdict)
     VirtQueueStatus *s = qmp_x_query_virtio_queue_status(path, queue, &err);
 
     if (err != NULL) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
@@ -278,7 +278,7 @@ void hmp_virtio_queue_element(MonitorHMP *hmp, const QDict *qdict)
     e = qmp_x_query_virtio_queue_element(path, queue, index != -1,
                                          index, &err);
     if (err != NULL) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 7a270ad3f25c..827a56144824 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -54,7 +54,7 @@ void monitor_register_hmp_info_hrt(const char *name,
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
 
-bool hmp_handle_error(Monitor *mon, Error *err);
+bool hmp_handle_error(MonitorHMP *hmp, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
 strList *hmp_split_at_comma(const char *str);
 
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 567abab321cc..3c0931796ce2 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -926,7 +926,7 @@ void hmp_calc_dirty_rate(MonitorHMP *hmp, const QDict *qdict)
                         true, mode,
                         &err);
     if (err) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 8d2e8735277e..a164a59080c5 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -478,7 +478,6 @@ void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_loadvm(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     RunState saved_state = runstate_get();
 
     const char *name = qdict_get_str(qdict, "name");
@@ -490,27 +489,25 @@ void hmp_loadvm(MonitorHMP *hmp, const QDict *qdict)
         load_snapshot_resume(saved_state);
     }
 
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_savevm(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     save_snapshot(qdict_get_try_str(qdict, "name"),
                   true, NULL, false, NULL, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_delvm(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *name = qdict_get_str(qdict, "name");
 
     delete_snapshot(name, false, NULL, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_migrate_cancel(MonitorHMP *hmp, const QDict *qdict)
@@ -520,7 +517,6 @@ void hmp_migrate_cancel(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_migrate_continue(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *state = qdict_get_str(qdict, "state");
     int val = qapi_enum_parse(&MigrationStatus_lookup, state, -1, &err);
@@ -529,12 +525,11 @@ void hmp_migrate_continue(MonitorHMP *hmp, const QDict *qdict)
         qmp_migrate_continue(val, &err);
     }
 
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_migrate_incoming(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
     MigrationChannelList *caps = NULL;
@@ -549,34 +544,31 @@ void hmp_migrate_incoming(MonitorHMP *hmp, const QDict *qdict)
     qapi_free_MigrationChannelList(caps);
 
 end:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_migrate_recover(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
 
     qmp_migrate_recover(uri, &err);
 
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_migrate_pause(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_migrate_pause(&err);
 
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 
 void hmp_migrate_set_capability(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *cap = qdict_get_str(qdict, "capability");
     bool state = qdict_get_bool(qdict, "state");
     Error *err = NULL;
@@ -597,12 +589,11 @@ void hmp_migrate_set_capability(MonitorHMP *hmp, const QDict *qdict)
     qapi_free_MigrationCapabilityStatusList(caps);
 
 end:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_migrate_set_parameter(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *param = qdict_get_str(qdict, "parameter");
     const char *valuestr = qdict_get_str(qdict, "value");
     Visitor *v = string_input_visitor_new(valuestr);
@@ -799,25 +790,23 @@ void hmp_migrate_set_parameter(MonitorHMP *hmp, const QDict *qdict)
  cleanup:
     qapi_free_MigrationParameters(p);
     visit_free(v);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_migrate_start_postcopy(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     qmp_migrate_start_postcopy(&err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 #ifdef CONFIG_REPLICATION
 void hmp_x_colo_lost_heartbeat(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_x_colo_lost_heartbeat(&err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 #endif
 
@@ -860,7 +849,7 @@ void hmp_migrate(MonitorHMP *hmp, const QDict *qdict)
     g_autoptr(MigrationChannel) channel_cpr = NULL;
 
     if (!migrate_uri_parse(uri, &channel, &err)) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
@@ -868,12 +857,12 @@ void hmp_migrate(MonitorHMP *hmp, const QDict *qdict)
     if (uri_cpr) {
         if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
             error_setg(&err, "-c can only be used in cpr-transfer mode");
-            hmp_handle_error(mon, err);
+            hmp_handle_error(hmp, err);
             return;
         }
 
         if (!migrate_uri_parse(uri_cpr, &channel_cpr, &err)) {
-            hmp_handle_error(mon, err);
+            hmp_handle_error(hmp, err);
             return;
         }
 
@@ -882,7 +871,7 @@ void hmp_migrate(MonitorHMP *hmp, const QDict *qdict)
     }
 
     qmp_migrate(NULL, true, caps, true, resume, &err);
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 31ce54e28449..e2a967516e0a 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -75,7 +75,7 @@ static void __attribute__((__constructor__)) sortcmdlist(void)
           compare_mon_cmd);
 }
 
-bool hmp_handle_error(Monitor *mon, Error *err)
+bool hmp_handle_error(MonitorHMP *hmp, Error *err)
 {
     if (err) {
         error_reportf_err(err, "Error: ");
@@ -165,17 +165,16 @@ void hmp_sync_profile(MonitorHMP *hmp, const QDict *qdict)
 
         error_setg(&err, "invalid parameter '%s',"
                    " expecting 'on', 'off', or 'reset'", op);
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
     }
 }
 
 void hmp_exit_preconfig(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_x_exit_preconfig(&err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_cpu(MonitorHMP *hmp, const QDict *qdict)
@@ -193,11 +192,10 @@ void hmp_cpu(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_cont(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_cont(&err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_change(MonitorHMP *hmp, const QDict *qdict)
@@ -219,29 +217,27 @@ void hmp_change(MonitorHMP *hmp, const QDict *qdict)
         hmp_change_medium(mon, device, target, arg, read_only, force, &err);
     }
 
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 #ifdef CONFIG_POSIX
 void hmp_getfd(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *fdname = qdict_get_str(qdict, "fdname");
     Error *err = NULL;
 
     qmp_getfd(fdname, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 #endif
 
 void hmp_closefd(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *fdname = qdict_get_str(qdict, "fdname");
     Error *err = NULL;
 
     qmp_closefd(fdname, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_info_iothreads(MonitorHMP *hmp, const QDict *qdict)
@@ -502,17 +498,16 @@ void hmp_info_mtree(MonitorHMP *hmp, const QDict *qdict)
 #if defined(CONFIG_FDT)
 void hmp_dumpdtb(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *filename = qdict_get_str(qdict, "filename");
     Error *local_err = NULL;
 
     qmp_dumpdtb(filename, &local_err);
 
-    if (hmp_handle_error(mon, local_err)) {
+    if (hmp_handle_error(hmp, local_err)) {
         return;
     }
 
-    monitor_printf(mon, "DTB dumped to '%s'\n", filename);
+    monitor_printf(MONITOR(hmp), "DTB dumped to '%s'\n", filename);
 }
 #endif
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 6e6334b64685..57c4127641ac 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1215,28 +1215,28 @@ fail:
     return NULL;
 }
 
-static void hmp_info_human_readable_text(Monitor *mon,
+static void hmp_info_human_readable_text(MonitorHMP *hmp,
                                          HumanReadableText *(*handler)(Error **))
 {
     Error *err = NULL;
     g_autoptr(HumanReadableText) info = handler(&err);
 
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
 
-    monitor_puts(mon, info->human_readable_text);
+    monitor_puts(MONITOR(hmp), info->human_readable_text);
 }
 
-static void handle_hmp_command_exec(MonitorHMP *mon,
+static void handle_hmp_command_exec(MonitorHMP *hmp,
                                     const HMPCommand *cmd,
                                     QDict *qdict)
 {
     if (cmd->cmd_info_hrt) {
-        hmp_info_human_readable_text(MONITOR(mon),
+        hmp_info_human_readable_text(hmp,
                                      cmd->cmd_info_hrt);
     } else {
-        cmd->cmd(mon, qdict);
+        cmd->cmd(hmp, qdict);
     }
 }
 
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index 702103b6a920..5b1c678f5d89 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -53,7 +53,7 @@ void hmp_info_network(MonitorHMP *hmp, const QDict *qdict)
     NetHubInfoList *h;
     NetworkClientInfoList *entry;
 
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
 
@@ -86,13 +86,12 @@ void hmp_info_network(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_set_link(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *name = qdict_get_str(qdict, "name");
     bool up = qdict_get_bool(qdict, "up");
     Error *err = NULL;
 
     qmp_set_link(name, up, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 
@@ -113,7 +112,6 @@ void hmp_announce_self(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_netdev_add(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     QemuOpts *opts;
     const char *type = qdict_get_try_str(qdict, "type");
@@ -133,17 +131,16 @@ void hmp_netdev_add(MonitorHMP *hmp, const QDict *qdict)
     }
 
 out:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_netdev_del(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *id = qdict_get_str(qdict, "id");
     Error *err = NULL;
 
     qmp_netdev_del(id, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 16847d1ce261..2e2eb33371e2 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -42,12 +42,11 @@ void hmp_qom_list(MonitorHMP *hmp, const QDict *qdict)
         }
         qapi_free_ObjectPropertyInfoList(start);
     }
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_qom_set(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const bool json = qdict_get_try_bool(qdict, "json", false);
     const char *path = qdict_get_str(qdict, "path");
     const char *property = qdict_get_str(qdict, "property");
@@ -71,7 +70,7 @@ void hmp_qom_set(MonitorHMP *hmp, const QDict *qdict)
         }
     }
 
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_qom_get(MonitorHMP *hmp, const QDict *qdict)
@@ -89,7 +88,7 @@ void hmp_qom_get(MonitorHMP *hmp, const QDict *qdict)
     }
 
     qobject_unref(obj);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 typedef struct QOMCompositionState {
@@ -160,22 +159,20 @@ void hmp_info_qom_tree(MonitorHMP *hmp, const QDict *dict)
 
 void hmp_object_add(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *options = qdict_get_str(qdict, "object");
     Error *err = NULL;
 
     user_creatable_add_from_str(options, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_object_del(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *id = qdict_get_str(qdict, "id");
     Error *err = NULL;
 
     user_creatable_del(id, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void object_add_completion(ReadLineState *rs, int nb_args, const char *str)
diff --git a/system/dirtylimit-hmp-cmds.c b/system/dirtylimit-hmp-cmds.c
index 4c100783778f..75194add7931 100644
--- a/system/dirtylimit-hmp-cmds.c
+++ b/system/dirtylimit-hmp-cmds.c
@@ -23,7 +23,7 @@ void hmp_cancel_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
 
     qmp_cancel_vcpu_dirty_limit(!!(cpu_index != -1), cpu_index, &err);
     if (err) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
@@ -33,7 +33,6 @@ void hmp_cancel_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_set_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     int64_t dirty_rate = qdict_get_int(qdict, "dirty_rate");
     int64_t cpu_index = qdict_get_try_int(qdict, "cpu_index", -1);
     Error *err = NULL;
@@ -46,7 +45,7 @@ void hmp_set_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
     qmp_set_vcpu_dirty_limit(!!(cpu_index != -1), cpu_index, dirty_rate, &err);
 
 out:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_info_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
@@ -63,7 +62,7 @@ void hmp_info_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
 
     head = qmp_query_vcpu_dirty_limit(&err);
     if (err) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index e27b9724867a..5c2de2f53cc9 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -1004,7 +1004,6 @@ void qmp_device_sync_config(const char *id, Error **errp)
 
 void hmp_device_add(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     QemuOpts *opts;
     DeviceState *dev;
@@ -1034,17 +1033,16 @@ void hmp_device_add(MonitorHMP *hmp, const QDict *qdict)
     }
     object_unref(dev);
 out:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_device_del(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *id = qdict_get_str(qdict, "id");
     Error *err = NULL;
 
     qmp_device_del(id, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void device_add_completion(ReadLineState *rs, int nb_args, const char *str)
diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
index 834b95835339..051ee45ee74c 100644
--- a/system/runstate-hmp-cmds.c
+++ b/system/runstate-hmp-cmds.c
@@ -70,7 +70,6 @@ void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_watchdog_action(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     WatchdogAction action;
     char *qapi_value;
@@ -79,7 +78,7 @@ void hmp_watchdog_action(MonitorHMP *hmp, const QDict *qdict)
     action = qapi_enum_parse(&WatchdogAction_lookup, qapi_value, -1, &err);
     g_free(qapi_value);
     if (err) {
-        hmp_handle_error(mon, err);
+        hmp_handle_error(hmp, err);
         return;
     }
     qmp_watchdog_set_action(action, &error_abort);
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index f1d2a327ddad..f68dd38ac225 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -573,7 +573,6 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_mce(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     X86CPU *cpu;
     CPUState *cs;
     int cpu_index = qdict_get_int(qdict, "cpu_index");
@@ -596,5 +595,5 @@ void hmp_mce(MonitorHMP *hmp, const QDict *qdict)
     } else {
         error_setg(&err, "Invalid CPU %d", cpu_index);
     }
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 5f3522943c56..186209fd0234 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -73,11 +73,10 @@ void hmp_mouse_button(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_mouse_set(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qemu_mouse_set(qdict_get_int(qdict, "index"), &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_info_mice(MonitorHMP *hmp, const QDict *qdict)
@@ -158,7 +157,7 @@ void hmp_info_vnc(MonitorHMP *hmp, const QDict *qdict)
 
     info2l = qmp_query_vnc_servers(&err);
     info2l_head = info2l;
-    if (hmp_handle_error(mon, err)) {
+    if (hmp_handle_error(hmp, err)) {
         return;
     }
     if (!info2l) {
@@ -266,7 +265,6 @@ out:
 
 void hmp_set_password(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *protocol  = qdict_get_str(qdict, "protocol");
     const char *password  = qdict_get_str(qdict, "password");
     const char *display = qdict_get_try_str(qdict, "display");
@@ -297,12 +295,11 @@ void hmp_set_password(MonitorHMP *hmp, const QDict *qdict)
     qmp_set_password(&opts, &err);
 
 out:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 void hmp_expire_password(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *protocol  = qdict_get_str(qdict, "protocol");
     const char *whenstr = qdict_get_str(qdict, "time");
     const char *display = qdict_get_try_str(qdict, "display");
@@ -325,7 +322,7 @@ void hmp_expire_password(MonitorHMP *hmp, const QDict *qdict)
     qmp_expire_password(&opts, &err);
 
 out:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 
 #ifdef CONFIG_VNC
@@ -427,7 +424,7 @@ void hmp_sendkey(MonitorHMP *hmp, const QDict *qdict)
     }
 
     qmp_send_key(head, has_hold_time, hold_time, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 
 out:
     qapi_free_KeyValue(v);
@@ -465,7 +462,6 @@ void sendkey_completion(ReadLineState *rs, int nb_args, const char *str)
 void coroutine_fn
 hmp_screendump(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     const char *filename = qdict_get_str(qdict, "filename");
     const char *id = qdict_get_try_str(qdict, "device");
     int64_t head = qdict_get_try_int(qdict, "head", 0);
@@ -482,13 +478,12 @@ hmp_screendump(MonitorHMP *hmp, const QDict *qdict)
     qmp_screendump(filename, id, id != NULL, head,
                    input_format != NULL, format, &err);
 end:
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }
 #endif
 
 void hmp_client_migrate_info(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *protocol = qdict_get_str(qdict, "protocol");
     const char *hostname = qdict_get_str(qdict, "hostname");
@@ -501,5 +496,5 @@ void hmp_client_migrate_info(MonitorHMP *hmp, const QDict *qdict)
     qmp_client_migrate_info(protocol, hostname,
                             has_port, port, has_tls_port, tls_port,
                             cert_subject, &err);
-    hmp_handle_error(mon, err);
+    hmp_handle_error(hmp, err);
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


