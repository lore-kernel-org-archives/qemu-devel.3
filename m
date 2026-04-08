Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C0110F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXxM-0006dz-U5; Wed, 08 Apr 2026 14:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAXx2-0003kp-KA
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:48:33 -0400
Received: from mail-4323.protonmail.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAHJC-0001Lr-Ua
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775610136; x=1775869336;
 bh=bzcWTfebsBxOlL1d+WlHaxDFxLorzIaQvjRqCYonbc4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=iMhKBiNuSo0R8sEye39B6f0n8U1qZ6N0mWExcS9Np/wgQGJU/1jbO+/OnriDyoQuv
 2tWdM9EXBuoKzKpWoOSL9We3a4+PJVH+MMzfaRVFqdItQhUl6Q+v3dM3t/Cc4caPg9
 99f7GfvUPqE7w7cINreXMChNC43C9YRAH2FRCHnS0c88y1HN6P11bSf4cxrpejl+k4
 NtrIztgVHxJqXpCphAtR5ONsyS4lSg2zgCMkgCNPUKhraRTBFyoewHl5OhQiQ//Pqx
 icr2cw7U3gZAMb9Ww4ZvRiMvLyUpYEql43nXKdLyEbiNbUActo8PlAsa8Cc1mt8TVG
 A48yncZXqI1rg==
Date: Wed, 08 Apr 2026 01:02:13 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, richard.henderson@linaro.org
Subject: [PATCH 2/8] hw/usb: use g_clear_handle_id() for GSource cleanup
Message-ID: <20260408010026.4611-3-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: b87fa7b8eaed33bfdd489f4525506883408af91c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.23; envelope-from=matt@matthewpenney.net;
 helo=mail-4323.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use g_clear_handle_id() instead of g_source_remove() with manual ID
checking and zeroing.

This simplifies the code and ensures consistent handling of GSource IDs,
since g_clear_handle_id() checks for a non-zero ID before calling the
cleanup function and zeros it afterwards.

No functional change intended.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
---
 hw/usb/redirect.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index fda5bbca67..bde821e214 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1226,10 +1226,7 @@ static void usbredir_chardev_close_bh(void *opaque)
         usbredirparser_destroy(dev->parser);
         dev->parser =3D NULL;
     }
-    if (dev->watch) {
-        g_source_remove(dev->watch);
-        dev->watch =3D 0;
-    }
+    g_clear_handle_id(&dev->watch, g_source_remove);
 }
=20
 static void usbredir_create_parser(USBRedirDevice *dev)
@@ -1494,9 +1491,7 @@ static void usbredir_unrealize(USBDevice *udev)
     if (dev->parser) {
         usbredirparser_destroy(dev->parser);
     }
-    if (dev->watch) {
-        g_source_remove(dev->watch);
-    }
+    g_clear_handle_id(&dev->watch, g_source_remove);
=20
     free(dev->filter_rules);
     qemu_del_vm_change_state_handler(dev->vmstate);
--=20
2.53.0



