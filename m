Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9B7CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs9U-0004Jy-QY; Wed, 17 Jun 2026 11:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs9M-00042R-Sz
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs9L-0004wP-2U
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+K33Y09MhY96AJIA/ciC42C5TxeEKDGCI0h56mz8DM=;
 b=GFlR+qnkKPCP91xRue9wyo7Fdi4Jb2fYdJ7FgXxBL8X5aWccqvQEFj32n4AU37T3pGhjEL
 YMxRyRJx7k6yTPoHO0q4izEXLYOzDWBeDXUdNCiapco21vVoB12gGPUXGF/PV4pXy8a/1S
 Tc1Xhqts7joz4WBgNdBjsr99rdr6Cq0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-qQejYA8jOTqUoUuA7pM0Lg-1; Wed,
 17 Jun 2026 11:25:52 -0400
X-MC-Unique: qQejYA8jOTqUoUuA7pM0Lg-1
X-Mimecast-MFC-AGG-ID: qQejYA8jOTqUoUuA7pM0Lg_1781709951
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFB5D1800767
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:25:51 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A24211955BC2; Wed, 17 Jun 2026 15:25:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:24 +0400
Subject: [GIT PULL 27/27] ui/sdl2: Set GL ES profile before creating
 initial GL context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-27-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MoazAlEnPV86Gv3PpB+0mbUDIrEjP1dqIC5KrfykpeM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpAOygCyBQfFyM4xJ7JNHJKK1EW3+rPB5Mm
 AkufeAOyyiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5biVEACr9w9wUFNgaNS21FyVEeaUpgbdO+3GKR8+GIM8jlWMh0VuTiLKFoMZrsU9ic9FSv9zFLI
 gVHpAB8VnZaHh08SEUKtoz0mUObrIdykBe/iACDCSrOEl89HNxjnW4/zLpvyQRxMgcU17T25RT4
 GrufW7u7/60MFcOa+kLW8o/WGE/2sSB8oc32nUiUHNLoY5zeh1AOuRi6Uc6pA3S1xSKBzKxvF6A
 fpaSU4ccABPLIAltJs4QJt6BSFd/d+o3OzsrjOvIcmdWGKf2/iqJuTNCMSsqLzApBCfCVVnouFA
 pGO34SpcJkK07nRXlCJ3u6BObNsQAkzzpmW3XM+DekjoDqzajKZiqoWDtHQsYaOQTEsxtxjKbP1
 aXmEfUhZBZGZcOVm7meLQk7cs5IFOJaxAoeMf9OsPBBwghlZn9yzr25fqFC9VMDZChRCTeSZcvM
 ZmO5e78muig27hG7zfjQxiH28BBpIBKeI/iF4d1Izy6U8jAKMrFuYbzTUcvs+venVuyDCDykd+a
 /x6786uT+eRs5z7nClW8ErRUkEOrA8hdSuTgMag1MvaJTi1z8JW42SjPmiKnDtQgbwYTKbnu0b2
 iZBnHtVDFflEQTEaT7ud4Iqtq1tRPgmB89fpzaq+cA3wwD0Oz5dgfkbyZIqUI2j2HDKURpTM0Ne
 wJ5gchrNckfPvng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ryan Zhang <mailto>

When the user selects GLES via '-display sdl,gl=es', we need to set
SDL_GL_CONTEXT_PROFILE_MASK to SDL_GL_CONTEXT_PROFILE_ES before
calling SDL_GL_CreateContext(). This ensures SDL_GL_LoadLibrary()
loads the correct GLES driver instead of the desktop OpenGL driver.

Fix the below issue: qemu-system-aarch64: /usr/src/debug/libepoxy
/1.5.10/src/dispatch_common.c:872: epoxy_get_proc_address: Assertion
`0 && "Couldn't find current GLX or EGL context.\n"' failed.

sdl2_gl_create_context() already sets the profile mask correctly for
ES mode, but the initial context created in sdl2_window_create() is
missing the same treatment.

Fixes:da3f7a3ab9ea0091955b58f8909dfcee01f4043e ("ui/sdl: try to instantiate the matching opengl renderer")

Signed-off-by: ryan.zhang@nxp.com
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <DU2PR04MB9018BB3650BA218438C01F2A83042@DU2PR04MB9018.eurprd04.prod.outlook.com>
---
 ui/sdl2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index ce14bd1f4e1..c75f750e00e 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -113,6 +113,8 @@ void sdl2_window_create(struct sdl2_console *scon)
 
         if (scon->opts->gl == DISPLAY_GL_MODE_ES) {
             driver = "opengles2";
+            SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                                SDL_GL_CONTEXT_PROFILE_ES);
         }
 
         SDL_SetHint(SDL_HINT_RENDER_DRIVER, driver);

-- 
2.54.0


