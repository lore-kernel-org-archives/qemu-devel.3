Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEF1C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6At6-00051o-5v; Mon, 14 Sep 2026 13:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6Asf-0004vE-2L
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:54:16 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6AsX-0000Iz-GC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:54:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1d16:0:640:f28c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id F2814C0AD9;
 Mon, 14 Sep 2026 20:53:58 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:a2b::1:d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rrX9s30iEKo0-32cOVHRM; Mon, 14 Sep 2026 20:53:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789408438;
 bh=d9AnM66mqO8oIMlMxdaUulQaT5duuxNJhwTGP7V00og=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=jgYyD0fsL+PSW1LNhnsft4d0+Qzg4VCaSr9kkErJrji2VXZjgOuhewUtPNTIRL7JQ
 SuNjMCyOzA/114oVYaxzzZcqM8blkzFmu8WgYkikd4O5WEsJ9v+W8wGgkur4XS1a8m
 6Uk3CP19pJeoy6lGxeCDp6HE83kuOjpT/XgP6Q5o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, peterx@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: [PATCH 4/5] net/tap: move vmstate initialization to new_tap()
Date: Mon, 14 Sep 2026 20:53:50 +0300
Message-ID: <20260914175351.393680-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914175351.393680-1-vsementsov@yandex-team.ru>
References: <20260914175351.393680-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Otherwise, incoming_fds case in net_init_tap() is not covered,
and the mechanism will not work for outgoing local migration,
if VM start life from incoming local migration.

Fixes: 98a0c2127070 "net/tap: disable read polling for stopped VM"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 8039b4e388c..9f829f49c1e 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -623,6 +623,9 @@ static TAPState *new_tap(NetClientState *peer,
 
     s->queue_index = queue_index;
 
+    s->enable_poll_on_resume = false;
+    s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);
+
     if (has_permit_local_migration) {
         s->permit_local_migration = permit_local_migration;
     }
@@ -968,9 +971,6 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
-    s->enable_poll_on_resume = false;
-    s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);
-
     if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
         sndbuf_required) {
         goto failed;
-- 
2.43.0


