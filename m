Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0024ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 07:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VE2-0001QN-RF; Tue, 30 Sep 2025 03:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VE1-0001Pj-DT
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VDu-00005X-2I
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759218992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Isu/INN+YNWgCJKU+nP4Q4M9LPuirsvX7/Ia8V7mpAs=;
 b=jKy2bihh+31hhEQDAmgkW3FlEkjjBWmXJnFuTIdPX78pMnpHbUtNTY22F5MAovbYcbAM/g
 OXYIdgmC39v8iq5i1U8CJmRLEZL6ID1orU4G4ns6/qbq2oSZyg4zfAdCVwekjTwtOjPWkn
 5ISrluahcqYjv4PeGj0wcQymdMTZM0s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Z-EUGq8WPNeaY_8I7bIfew-1; Tue,
 30 Sep 2025 03:56:28 -0400
X-MC-Unique: Z-EUGq8WPNeaY_8I7bIfew-1
X-Mimecast-MFC-AGG-ID: Z-EUGq8WPNeaY_8I7bIfew_1759218988
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C52E31800290; Tue, 30 Sep 2025 07:56:27 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F9A219560B4; Tue, 30 Sep 2025 07:56:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 richard.henderson@linaro.org, Nir Lichtman <nir@lichtman.org>
Subject: [PULL 4/5] ui/sdl2: fix reset scaling binding to be consistent with
 gtk
Date: Tue, 30 Sep 2025 11:55:58 +0400
Message-ID: <20250930075559.133650-5-marcandre.lureau@redhat.com>
In-Reply-To: <20250930075559.133650-1-marcandre.lureau@redhat.com>
References: <20250930075559.133650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nir Lichtman <nir@lichtman.org>

Problem: Currently the reset scaling hotkey is inconsistent between SDL
and GTK graphics modes.

Solution: Fix SDL to use MOD+0 instead of MOD+u which is in line with
GTK and generally more consistent with other apps.

This is also related to my previously sent patch fixing the docs.

Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250910114929.GA1783677@lichtman.org>
---
 ui/sdl2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index b00e421f7f..032dc14bc3 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -421,7 +421,7 @@ static void handle_keydown(SDL_Event *ev)
                 sdl_grab_end(scon);
             }
             break;
-        case SDL_SCANCODE_U:
+        case SDL_SCANCODE_0:
             sdl2_window_resize(scon);
             if (!scon->opengl) {
                 /* re-create scon->texture */
-- 
2.51.0


