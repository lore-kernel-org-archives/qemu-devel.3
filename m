Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D17C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PYf-0008Iz-DO; Mon, 29 Apr 2024 07:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYX-0008EX-N5; Mon, 29 Apr 2024 07:52:25 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYQ-0001nu-9l; Mon, 29 Apr 2024 07:52:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id F12D360BB5;
 Mon, 29 Apr 2024 14:52:11 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0qOEuD11MuQ0-D1OHE8dv; Mon, 29 Apr 2024 14:52:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714391531;
 bh=eEOyCVZ3JXSEur7Nadwzc+kvSjKm4xOx7LeBJKl+UEo=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HjcOJI6sacTnl6OTDlsVzkh2/XbZs2phgcGFcx6rWZncAdsL/jFnDiK/8FG4PLgoQ
 5Av06adQDmNUGa5QCXLxKL+6vTyelXuK5YYGRM6mB4h46qUZbbpC1JLLbkp796td38
 Patz1IOLC26+uHwxCHKNzgKEZBKD67ulNAw235p4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PULL 1/6] blockcommit: Reopen base image as RO after abort
Date: Mon, 29 Apr 2024 14:51:52 +0300
Message-Id: <20240429115157.2260885-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
References: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

If a blockcommit is aborted the base image remains in RW mode, that leads
to a fail of subsequent live migration.

How to reproduce:
  $ virsh snapshot-create-as vm snp1 --disk-only

  *** write something to the disk inside the guest ***

  $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
  $ lsof /vzt/vm.qcow2
  COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
  qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
  $ cat /proc/433203/fdinfo/45
  pos:    0
  flags:  02140002 <==== The last 2 means RW mode

If the base image is in RW mode at the end of blockcommit and was in RO
mode before blockcommit, reopen the base BDS in RO.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20240404091136.129811-1-alexander.ivanov@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/mirror.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 1bdce3b657..61f0a717b7 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -93,6 +93,7 @@ typedef struct MirrorBlockJob {
     int64_t active_write_bytes_in_flight;
     bool prepared;
     bool in_drain;
+    bool base_ro;
 } MirrorBlockJob;
 
 typedef struct MirrorBDSOpaque {
@@ -794,6 +795,10 @@ static int mirror_exit_common(Job *job)
     bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
     bdrv_graph_wrunlock();
 
+    if (abort && s->base_ro && !bdrv_is_read_only(target_bs)) {
+        bdrv_reopen_set_read_only(target_bs, true, NULL);
+    }
+
     bdrv_drained_end(target_bs);
     bdrv_unref(target_bs);
 
@@ -1717,6 +1722,7 @@ static BlockJob *mirror_start_job(
                              bool is_none_mode, BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
+                             bool base_ro,
                              Error **errp)
 {
     MirrorBlockJob *s;
@@ -1800,6 +1806,7 @@ static BlockJob *mirror_start_job(
     bdrv_unref(mirror_top_bs);
 
     s->mirror_top_bs = mirror_top_bs;
+    s->base_ro = base_ro;
 
     /* No resize for the target either; while the mirror is still running, a
      * consistent read isn't necessarily possible. We could possibly allow
@@ -2029,7 +2036,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                      speed, granularity, buf_size, backing_mode, zero_target,
                      on_source_error, on_target_error, unmap, NULL, NULL,
                      &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name, true, copy_mode, errp);
+                     filter_node_name, true, copy_mode, false, errp);
 }
 
 BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -2058,7 +2065,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
-                     errp);
+                     base_read_only, errp);
     if (!job) {
         goto error_restore_flags;
     }
-- 
2.34.1


