Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB4FCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuVv-0003oB-05; Tue, 12 May 2026 17:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuVX-00028M-Kg; Tue, 12 May 2026 17:19:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuVU-00084C-GR; Tue, 12 May 2026 17:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619497; bh=6bpVwPgBT8xb2Rf00Ig1uckenO4aE6GImxQGwKbTjS8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Qe4t+xXMfGDW5K+VO0jo9osI8kzamYmq6nbQkuHbXR5eXCnuisQ8jLa7VcBmXAMdK
 CxJZfZ0gkE3QKX5q/JNM1XaxW37XmMHjqQgRFfa4mBZDvBcQ2R6Jb4NMJXZYrZPKXJ
 JnVaB2n91W3+vgAnIwb6RokIaBraJczZmgfW5gb6zUGa/B8mwjHzRRhxdeu2aeBMaf
 URt4cGXljWK3J8hFPQxoFKtEpSDQBeXA8iQwS5ksYvb30U+I05DSBzhchyQfuaa2kG
 5YEdKd6IgAgVgLtLIT6xwU2dmbwTfp0w+gMga5EGP6pi0wN4Tw1TLeuc2sBMF1Edrj
 K0svCCPONdhnA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C0D151AA3D8;
 Tue, 12 May 2026 23:58:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CCA363ABD30;
 Tue, 12 May 2026 23:58:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 13/58] migration: vmstate_save_state_v: fix double
 error_setg
Date: Tue, 12 May 2026 23:57:34 +0300
Message-ID: <20260512205820.361821-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We may call error_setg twice on same errp if inner
vmstate_save_state_v() or vmstate_save_state() call fails. Next we will
crash on assertion in error_setv().

Fixes: 848a0503422d043 "migration: Update error description outside migration.c"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-2-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit d41ce10d0f5a3d6e497e4b75807a8e675033c597)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


