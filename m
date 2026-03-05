Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76126EFCE56
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 01:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxxLL-0001o4-Pz; Wed, 04 Mar 2026 20:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1vxwcM-0002VS-CJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:31:06 -0500
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1vxwcH-0005Vx-K3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1772670651; x=1772929851;
 bh=ywYcIcPss2N8w2GXjxNhliHMvBa3al2SIUJgOqAAPq8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=IaS0P9m4ZcPPNTjZz81NY7A9jbeRVlABLsuXOpfn1cNpm2RE698UgqI5om0eJiehh
 R/snMcC69ojF05zmJ1S6AMbXK+7LP6gi5wFkSPy+1dNxHnh4D7YIB6LRIyIyTC2J5H
 YAdMlAQL+Bip0eDKBLDYGvH0D3L/MF1xxLs/yhycxaccuvqREibxmCRloQ2b7/grb/
 6pootKytdDao/kRCZEs56dlx5EEzIOW9dCwq/w+LXpxtLQyFUT+wjZST3OJlzQZ1dS
 G3CEtT3ugdLA24ixHuL58ls+sKUWzY3UiVd7alGCvxvB/jPnAdO3PgRH+0HF2zO8D5
 d7C0W14pf37XQ==
Date: Thu, 05 Mar 2026 00:30:47 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, lvivier@redhat.com, amit@kernel.org,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] hw/char: clear dangling GLib event source tag
Message-ID: <20260305003012.108262-1-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: ffb066b95f7715ac6d2f623f49d9ce86f8ee36fa
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249;
 envelope-from=matt@matthewpenney.net; helo=mail-08.mail-europe.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Mar 2026 20:17:32 -0500
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

Clear dangling GLib event source tag when virtio-console is
unrealized. This prevents a stale tag from being used, and
maintains consistency with the rest of virtio-console.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
---
 hw/char/virtio-console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 25db0f019b..11bf51e3ea 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -258,6 +258,7 @@ static void virtconsole_unrealize(DeviceState *dev)
=20
     if (vcon->watch) {
         g_source_remove(vcon->watch);
+        vcon->watch =3D 0;
     }
 }
=20
--=20
2.53.0



