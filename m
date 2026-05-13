Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05012CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN70x-0004U2-4J; Wed, 13 May 2026 06:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70S-00040h-Qg; Wed, 13 May 2026 06:40:04 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70M-0002QS-Rp; Wed, 13 May 2026 06:39:57 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64DAcPdq044648
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2026 19:39:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=RyTCIvwVaozeLTAhpbHAq66Za8rIDYOF4QelkPaMxcQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778668740; v=1;
 b=Q3I4olhyAMBayNLNuhohUxb8Tu7GY037MXW5+AF9/LyzlI6gmqJDh7elh0044AIm
 wBGZ/sQgOMwRFygVqI4QUaF5UuLuf/MZ7X04QtgWA5s0/LYBWU7ovSAejJPW+iYp
 bcQO4BOuELVcPdK6nQdFnPje9vaFejxioqcdu4chpyOP8cTbVNQI2YmUpc9Ro+Yl
 dUtBZ6tdkoflKC01tVFJcH68ub8etNsPfSB6BYvlpqIXzftcXgOqBWG4JGSPwvgp
 b3LBQZEoVI1+1JJynAsAc9XqM65Gns1aWwl13m8LTdPHQeYiE0gsQaQt4p6y8jLI
 KM7P0VnmIJld1iqh2GJp+w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 13 May 2026 19:38:44 +0900
Subject: [PATCH v2 28/29] ui/console: Remove qemu_text_console_put_qcode()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-input-v2-28-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
References: <20260513-input-v2-0-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260513-input-v2-0-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
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
 bh=ThSU88la05KIjFwROp/cneKNiRlHnev55PgTZdXOqEg=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZLyJ7t1zs7Fu16Hb+R45t/mW9C7BrnTYFJduf3dqQbS
 z9+UuTQUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMBFnbYa/QgHSUqv3OU44zrqt
 ua1Hc+qd6TPeSZROY3s7U+PG4gWZ0xgZFs7rrsqr3sT4n7u1Q3b52SixwgdZ3fqJmv9Y2BMNPFa
 wAwA=
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
index 691040f5948d..a31c5a4995c6 100644
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
index fd1038a22c0b..e8c1a4c97906 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -328,12 +328,6 @@ static const int ctrl_linux_to_keysym[] = {
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


