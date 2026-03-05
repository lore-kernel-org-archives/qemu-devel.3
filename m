Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4942CF47CDB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGKM-0000rb-5e; Thu, 05 Mar 2026 16:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1vyGKK-0000rQ-8E
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:33:48 -0500
Received: from mail-0701.mail-europe.com ([51.83.17.38]
 helo=mail-07.mail-europe.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1vyGKH-0004kV-13
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1772746420; x=1773005620;
 bh=h9d7WdkQLs54uvGRseBuRvb+sN7dCNSdLEmyOh6W2P8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=iHMb3bgEpna3DSV9iM5YTC6E+EkdSmD155yUFES9j6lZ5QUTRYuPS0WoY9krnVESM
 05VuSx045z0+++FJVc0qMuZjliUREEsIZKdbonGAuN63eTINT9MdegzQEJ2gu6vr80
 l5YZAAYyYnkiiOJ71/xLn02u7XCaHp7ZCOqI43uurE9Vn9Uq8AOEN0heQkjd4NmHgD
 sPz0MqsggvCrZXQBn1rL/Jumv7l9tYGPfqphxrWSJP+VaEdMffjTmuVpGDRPv/Fd+J
 tLX2HJiMOAr30m+7ezT4YQ+hDcdtz2tpJzpZIk+8OWTcCHLn0SnBtuQIJSAOvFug77
 KJAX9VqxNTHzg==
Date: Thu, 05 Mar 2026 21:33:32 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 lvivier@redhat.com, amit@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] hw/char: clear dangling GLib event source tag
Message-ID: <20260305213308.96441-1-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: ea41d04d2230d4ab7451e8eb074643f68635e9ac
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=51.83.17.38;
 envelope-from=matt@matthewpenney.net; helo=mail-07.mail-europe.com
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Clear dangling GLib event source tag when virtio-console is
unrealized. This prevents a stale tag from being used, and
maintains consistency with the rest of virtio-console.

v2:
Use g_clear_handle_id() per advice from Marc-Andr=C3=A9 Lureau

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/virtio-console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 25db0f019b..efe7cd6772 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -257,7 +257,7 @@ static void virtconsole_unrealize(DeviceState *dev)
     VirtConsole *vcon =3D VIRTIO_CONSOLE(dev);
=20
     if (vcon->watch) {
-        g_source_remove(vcon->watch);
+        g_clear_handle_id(&vcon->watch, g_source_remove);
     }
 }
=20
--=20
2.53.0



