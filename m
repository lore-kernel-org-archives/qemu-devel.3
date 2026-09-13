Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484B7C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5dvH-0003lj-Bl; Sun, 13 Sep 2026 02:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5dvD-0003lP-Q3
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:42:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5dvB-0004OC-94
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:42:39 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68D6gHE2079008
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 13 Sep 2026 15:42:28 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=IzqRnIXi0Xi6YDdIwnuiEzIBkd/WxKr6D2yNk442Uks=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789281748; v=1;
 b=gILFbxgpcPazrPSN+x/WgWIbQuPMXPHxzCfvCgit9pldfR3GSMd64Hjj6q8ZXEeW
 1LqEndhjHG728TeAkBd7bFIaMZgN0o9oIGOHkPUfnuugPmb5k3UiL/KNgQnBYmR2
 0a19TpPiImsEzFGcmaNxmQUFd+OLM/bht1tEIR/MQ2RU1qtn2QQpwaijYgWJX58r
 mlZjJqkPDvOKrWXwm0lb/SCBuFvrDGsFhr8x0SvPcH6obYgaPbFAPHg6K4ZXy9UP
 p0es/5CZABnlG14g8e5ZjJGj7kDKzsTkkaeE24H5jNi7g50KiwpxdIetMHGecBPz
 kDQ2SWPb/MhYIdtg7IyfJw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 13 Sep 2026 15:42:12 +0900
Subject: [PATCH] ui/gtk: Remove glFlush() after eglSwapBuffers()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-flush-v1-1-229efa3f1e53@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0Nj3bSc0uIMXQMLc0PT1BTLNJM0IyWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQD7L+esaQAAAA==
X-Change-ID: 20260913-flush-08715ed9f4f2
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=bdbETB4BlUNLRaJl3TisU6PM0CJrV7dhaQh2HXM47Ic=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9Yy16PKj7dbzYhu7uNcuGiFk+8mCw/9ykwh/+NVB5ZHm
 D+Mt1LsKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmIjLekaG/tgIwbYHzAu5JuwS
 Tjt2z9ni59eAixLLfj3ZW+nOMuuIIMP/qk7rN9oLdyQ1nBFfIbW+7PKf4G0O8ZlsFbbmZzXvn7j
 DDwA=
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

It is redundant since eglSwapBuffers() implicitly performs glFlush().

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/gtk-egl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index d595916476d9..0eec06826bdd 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -104,7 +104,6 @@ void gd_egl_draw(VirtualConsole *vc)
                         surface_width(vc->gfx.ds),
                         surface_height(vc->gfx.ds));
 
-        glFlush();
 #ifdef CONFIG_GBM
         if (dmabuf) {
             gd_gl_wait_sync(vc, sync);
@@ -122,8 +121,6 @@ void gd_egl_draw(VirtualConsole *vc)
         gd_update_scale(vc, ww, wh,
                         surface_width(vc->gfx.ds),
                         surface_height(vc->gfx.ds));
-
-        glFlush();
     }
 }
 

---
base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
change-id: 20260913-flush-08715ed9f4f2

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


