Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF3DCD343F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 10:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLfFa-0000IS-Bz; Sat, 09 May 2026 06:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfF2-0008KT-7g; Sat, 09 May 2026 06:49:05 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfEw-0001b9-3K; Sat, 09 May 2026 06:49:02 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 649AlY2S090834
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 9 May 2026 19:48:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=oD7Oz6DJPKhfTwDBn7qY6uv8mbGy6lFjBZ+noyIIS8w=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778323683; v=1;
 b=bD6DowZ9vH3+48hXLUl9WDyqrz0FsRMdPq2QhGz67RPH3rIEdx5e7wLb7eqPGabc
 pSs2HvvuuSC/F35DIFrXSZaz9EGXSLggKZWoX4Pk0A7XP3Yz6kx2gcDTBJZtc0VH
 YL211ORk3pfIU8j/GqqAZqJ6O9fgksq3BbMabrj3zeLwILWnV8E/ikg97XmxKq3U
 4jWYKIkwkMaeuspyfs2bCgCyz98XSgqdEK3ROXyOqaYst0C9LU/69UnxlsvEW4hI
 al1mJXeujZUxFP9mncX4htnUAiqCCfihy6qRIP1u9Dgd2q0A42FetuCX4g6dpQoI
 AOzpU1u6Q7x7YzyiGz5zgA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 09 May 2026 19:34:39 +0900
Subject: [PATCH RFC 27/28] ui/console: Remove qemu_text_console_put_qcode()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-input-v1-27-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
References: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=SdvuE7+61fSYB2dvpKio7pECbok4Voz8EgqzbYNskqY=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ+Z/gduea/xDD8+0iFSx6dMSvZKmm7bRp6U1wyyw3EjKL
 2KnKXdHKQuDGBeDrJgiS0rRbm6N6NpPhQnxLTBzWJlAhjBwcQrARDZEMDKcKF9W0p9y66n4/skx
 wXMnv6v/8ac21Ophgbs9q63f5i9BDP/rX0W0t4cHb5stee7dBaPp4syrJJTEL2423SuQ/rheyY8
 dAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It is no longer used.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/console.h | 1 -
 ui/console.c         | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index ea267a673a6a..a5e6f4b4d7d8 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -108,7 +108,6 @@ bool qemu_mouse_set(int index, Error **errp);
 #define QEMU_KEY_CTRL_PAGEDOWN   0xe407
 
 void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym);
-bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl);
 bool qemu_text_console_put_linux(QemuTextConsole *s, unsigned int lnx,
                                  bool ctrl);
 void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len);
diff --git a/ui/console.c b/ui/console.c
index 012fbeb007f2..74475d090f6a 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -330,12 +330,6 @@ static const int ctrl_linux_to_keysym[] = {
     [KEY_PAGEDOWN]   = QEMU_KEY_CTRL_PAGEDOWN,
 };
 
-bool qemu_text_console_put_qcode(QemuTextConsole *s, int qcode, bool ctrl)
-{
-    unsigned int lnx = qemu_input_map_qcode_to_linux[qcode];
-    return qemu_text_console_put_linux(s, lnx, ctrl);
-}
-
 bool qemu_text_console_put_linux(QemuTextConsole *s, unsigned int lnx,
                                  bool ctrl)
 {

-- 
2.54.0


