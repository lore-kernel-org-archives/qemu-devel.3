Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA48E7E35D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8av4-00005R-2w; Fri, 03 Apr 2026 05:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w8av1-0008WI-Aw
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:34:23 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w8auz-00011H-ED
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:34:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1162FC015D;
 Fri, 03 Apr 2026 12:34:14 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:d4c::1:2b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id CYZqeY0LOuQ0-7Xt7BEZM; Fri, 03 Apr 2026 12:34:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1775208853;
 bh=MNFYlq9kyki7CZl3zzwt4Cq7WuPKpPHoIexmCx95eis=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=kDqWZDiOWBH6w8vABLf+Ar0LLWbMReoW2q1ulKFJygZXCalwPERWU1JPayppUfALB
 upNJ7mh3QpH8ww2COrOIGrnw6FBc00lAAT6CTtG2ZCJ+R8OPufFXnhJPLDT6PRJl1F
 tV1Mi96gpsWDKhU9xiI8KChSlodI69voSx350LWo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael.norwitz@nutanix.com,
 swapnil.ingle@nutanix.com, peter.turschm@nutanix.com, cui@nutanix.com,
 marcandre.lureau@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH] vhost-user: fix wrong index for postcopy_client_bases
Date: Fri,  3 Apr 2026 12:34:11 +0300
Message-ID: <20260403093411.1431802-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

u->postcopy_client_bases[i] corresponds to dev->mem->regions[i], not
to u->shadow_regions[i]. So we should use j-index, following indexation
of dev->mem->regions.

Fixes: f1aeb14b0809e313c7424 "Transmit vhost-user memory regions individually"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Hi all!

Honestly, I don't follow the logic of vhost-user postcopy, but I can't
believe, that the same array should be used in different indexing
semantics.

 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a8907cca74e..91de08a5128 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -602,7 +602,7 @@ static void scrub_shadow_regions(struct vhost_dev *dev,
                     if (fd > 0) {
                         u->region_rb_offset[j] = offset;
                         u->region_rb[j] = mr->ram_block;
-                        shadow_pcb[j] = u->postcopy_client_bases[i];
+                        shadow_pcb[j] = u->postcopy_client_bases[j];
                     } else {
                         u->region_rb_offset[j] = 0;
                         u->region_rb[j] = NULL;
-- 
2.52.0


