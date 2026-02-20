Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD568C5B56A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXdq-00009Z-Jh; Fri, 20 Feb 2026 16:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdo-00008y-Cj
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:24 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdl-0002iH-RG
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:24 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 98101C0231;
 Sat, 21 Feb 2026 00:02:17 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-KBEbWTjF; Sat, 21 Feb 2026 00:02:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621337;
 bh=vUJrFcav5IvQGqyZxd/DgOr9wCQY5OjjYoXQSZFO8BQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=xG1RyOMMQHXH1bz7x9zNKHw8q2F67bC4WCXBd+xzuEQowd3w2kwD9KbJ3mUiaQWz0
 CHgp55I1IyA5oijp2jOgCfN4qHDvoxs162OHEWAd7n69TmII5kb7BlMd34xcrZQQGu
 pqjYsnyqO0I4OIKbtLe1MvAYSAelutAsu4A1HdNA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 01/16] migration: vmstate_save_state_v: fix double
 error_setg
Date: Sat, 21 Feb 2026 00:01:59 +0300
Message-ID: <20260220210214.800050-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220210214.800050-1-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

We may call error_setg twice on same errp if inner
vmstate_save_state_v() or vmstate_save_state() call fails. Next we will
crash on assertion in error_setv().

Fixes: 848a0503422d043 "migration: Update error description outside migration.c"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/vmstate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4d28364f7b..fccd030dfd 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -539,6 +539,9 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 } else {
                     ret = inner_field->info->put(f, curr_elem, size,
                                                  inner_field, vmdesc_loop);
+                    if (ret < 0) {
+                        error_setg(errp, "put failed");
+                    }
                 }
 
                 written_bytes = qemu_file_transferred(f) - old_offset;
@@ -551,8 +554,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 if (ret) {
-                    error_setg(errp, "Save of field %s/%s failed",
-                                vmsd->name, field->name);
+                    error_prepend(errp, "Save of field %s/%s failed: ",
+                                  vmsd->name, field->name);
                     if (vmsd->post_save) {
                         vmsd->post_save(opaque);
                     }
-- 
2.52.0


