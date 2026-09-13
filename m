Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BF1C88E40
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5dxU-0004Zk-7E; Sun, 13 Sep 2026 02:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5dxR-0004ZO-K9
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:44:57 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5dxP-0004Ye-RT
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:44:57 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68D6inGx080155
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 13 Sep 2026 15:44:53 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=qNGTDsX4wLJLn+2wnYuCOsEBlmjpj9jY9LE5LW0AchU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789281893; v=1;
 b=gDvjR/k3/STCdCv/cmr4bGYPo8pZ1L3RMpJNnHimSlvpM5+4gRlJSHFTPiKzR2tw
 QnCEgHdykEZLc0+GoqZslezB7+WG36pep6CvF7+v5KqXe59RwkH/Wszq6+1APoYv
 NX1aCTuPPsZm+XgPD6fkL+94yzak6AtFPCQ27ILmbLO7m9YbJrLRIrFhhNiqVYMn
 hUzk4hRQTSRr/KnBe5cyxlP7NOSIZl6ZrMN0f23zkPB5cCmyEBinkTqGdIyBB+RW
 f6eH0AeGl1s1L5DHK55caYUDQTvIw1Hd+ZfOKFaEH0V4zemdX4yBZ/en+JGlXLFE
 h0TjRZvJl5gscZ4ecRHaBw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 13 Sep 2026 15:44:47 +0900
Subject: [PATCH] ui/gtk: Work around the gtk-menu-bar-accel leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-gtk-v1-1-3e4ac542e054@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0Mj3fSSbF2jxCTjJOPEJAsTs1QloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0A27aSH2cAAAA=
X-Change-ID: 20260912-gtk-2ab3b3ab846e
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=DCp79Z630IoGfTFnfXogP9BrHNAK3sZWQ2oGm4HMOxg=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9Yyt/hU/4tfgrZNOj/39rSls4Re7igudmVS0di152Svo
 HXzlDO+HaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABNJ0Gb4pyDiYfZjj7Zs/iLO
 7ke7pWfJ7nbZfPj5VPGG54Y3rp1e8ZHhv9cN592nYlNm/C3QKTp9u//Mz6cyX/16Ji87Vsg+PXH
 6aQ4A
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

The implementation of the gtk-menu-bar-accel property had a bug that
leaks memory when the set value is an empty string, which was fixed
with:
https://gitlab.gnome.org/GNOME/gtk/-/commit/44bf10c4a2a0463891884a105fa27cf36b73f119

To work around the issue for old GTK versions, replace the empty string
with NULL, which has the same meaning for the property.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/gtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index c615d35451b6..ae28f1fbb89b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2645,7 +2645,7 @@ static void gd_create_menus(GtkDisplayState *s, DisplayOptions *opts)
 
     /* Disable the default "F10" menu shortcut. */
     settings = gtk_widget_get_settings(s->window);
-    g_object_set(G_OBJECT(settings), "gtk-menu-bar-accel", "", NULL);
+    g_object_set(G_OBJECT(settings), "gtk-menu-bar-accel", NULL, NULL);
 }
 
 

---
base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
change-id: 20260912-gtk-2ab3b3ab846e

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


