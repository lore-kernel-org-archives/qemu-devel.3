Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588DF10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXoZ-0006vq-Os; Wed, 08 Apr 2026 14:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAXoW-0006Tf-Aa
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:39:44 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAHJe-0001O6-3v
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775610163; x=1775869363;
 bh=oqHbA6YPts6FkiD94r3/U79zKL+UzzjeOKdjJ6EHpsM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=j2U564YmqJkRZEXIr15XVOqfrywgEM+hdjtYrUwmeHWZsmITWlLGDQfZ+Oc4ZBTbx
 cvvUt3r9mpTVXVOJelXtKA9ZYa6cYxpB36c/hdtDox6VJK+FiV2RvmH68l2yLbHco7
 n1FeWLx7/djwopAvYEVDtiS96Ccgc5CFoMXysL9XxBu89ejRF4u6xivAaXpnjSnLlO
 XzW7Cf6R52aJPwDJFbqGl63ikSR86mp3vokiBgVKH7Q0dUkOuh2H4GsN01wGrEWov3
 chzXcUIpF9hLy5FQXLmIIrmX3rMTGlegBWI+FNJSZLjGS0CwMdG/pAfz4mt8RAL8ei
 GHDkuB5ljazvQ==
Date: Wed, 08 Apr 2026 01:02:40 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>,
 Paolo Bonzini <pbonzini@redhat.com>, fam@euphon.net, qemu-block@nongnu.org
Subject: [PATCH 5/8] scsi: use g_clear_handle_id() for GSource cleanup
Message-ID: <20260408010026.4611-6-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 29fc9a79703cf6a646fa0fc4f814325b15ecf663
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169; envelope-from=matt@matthewpenney.net;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Replace g_source_remove() with g_clear_handle_id().
This simplifies the code and ensures consistent handling of GSource IDs.

No functional change intended.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
---
 scsi/qemu-pr-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 9dcd3ec711..ce579cc401 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -831,7 +831,7 @@ static void close_server_socket(void)
 {
     assert(server_ioc);
=20
-    g_source_remove(server_watch);
+    g_clear_handle_id(&server_watch, g_source_remove);
     server_watch =3D -1;
     object_unref(OBJECT(server_ioc));
     num_active_sockets--;
--=20
2.53.0



