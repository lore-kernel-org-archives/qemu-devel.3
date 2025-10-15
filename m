Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E23CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91SU-0005SS-28; Wed, 15 Oct 2025 09:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91SH-0005LC-AE
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:16 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91S5-00034T-Mc
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:12 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B70C488ACA;
 Wed, 15 Oct 2025 16:21:51 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bLQ5oq0N5Os0-YUx9oEma; Wed, 15 Oct 2025 16:21:51 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760534511;
 bh=UicDA5etzsJjSp7/6GitAPJDaIZ/euilBHmOaCwUrWA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0l9HQFpRW9HahnlIIlnh07lEoEoW9dHjaHm0Phi4S9Z62djBdNt75gGZ7pjjDnzql
 pz2b4qLLLw91PVqh1mO3L2Nn4G9l6JE52e620ZiVxXxY1qZx0vB7qh+SynfsApVTJm
 +DgSlJvtuTaz2k0jb9UHylFNozsJ8AUuuuCXLi8k=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v8 13/19] net/tap: finalize net_tap_set_fd() logic
Date: Wed, 15 Oct 2025 16:21:29 +0300
Message-ID: <20251015132136.1083972-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Let net_tap_set_fd() do only fd-related setup.

Actually, for further backend-transfer migration for virtio-net/tap
we'll want to skip net_tap_set_fd() (as incoming fds are already
prepared by source QEMU). So move tap_read_poll() to net_tap_setup().

Don't care about using_vnet_hdr and vhost_net, the state is
zero-initialized.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index d08ef070e9..7e85444ace 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -480,7 +480,6 @@ static bool net_tap_set_fd(TAPState *s, int fd, int vnet_hdr, Error **errp)
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
-    s->using_vnet_hdr = false;
     s->has_ufo = tap_probe_has_ufo(s->fd);
     s->has_uso = tap_probe_has_uso(s->fd);
     s->has_tunnel = tap_probe_has_tunnel(s->fd);
@@ -493,8 +492,6 @@ static bool net_tap_set_fd(TAPState *s, int fd, int vnet_hdr, Error **errp)
     if (vnet_hdr) {
         tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
     }
-    tap_read_poll(s, true);
-    s->vhost_net = NULL;
 
     if (s->sndbuf) {
         Error **e = s->sndbuf_required ? errp : NULL;
@@ -795,6 +792,8 @@ static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp)
         return false;
     }
 
+    tap_read_poll(s, true);
+
     if (s->vhostfd != -1) {
         VhostNetOptions options;
 
-- 
2.48.1


