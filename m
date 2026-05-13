Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA6CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN707-0003xK-Uf; Wed, 13 May 2026 06:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN6zz-0003po-Nu; Wed, 13 May 2026 06:39:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN6zw-0002MB-1I; Wed, 13 May 2026 06:39:31 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64DAcPdk044648
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2026 19:38:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zvZRcDF6rPXqdkFSL8eojNejDsFaH8xzSLM1gva1gm8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778668739; v=1;
 b=hb+v35JJbdMAkhMg0FEjn7TBDb8oY8TiAg2E0cb+p6DoEeJaCjxJjOPp0v2Nv1N/
 HZKaBlgOuk6RiryEw2xvb/0EDnpV5bMOiDyFtKLuOxH6M/XpuhbZTtlrVgMkTO3S
 wAVXheoMpOarPFAbFJLTjO63nI/jmdEyhbyLC4h7pNk/n0Q2NXnUKo2JIUCITayY
 8tReKuLgmRJ6VRp1VR82Rb9I+QTDoeKVUfaY1yauA6Dzz6TETSZ1ARcx4Se1xNUk
 q9aQ2FJeuwTM+YzckWTg8yrXwvEWQNOCqZRXK52UICUTVKeNYqXTsupFmeiZp3Tx
 iQSNQy2irRU2co5AgP2pyQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 13 May 2026 19:38:38 +0900
Subject: [PATCH v2 22/29] ui/input-linux: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-input-v2-22-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=947;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=kRJ/7J804Tn8eBdIewmzxF/6sh/dIs4sMW2m0FcJ+rk=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZLyPaCjCY/wSciT+KjCr16LH0+bAnZGT3zmP5+3SOnl
 /wQNTzbUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMJGztQz/K81qFwtUpcwMONKx
 Vri85EdC6uOfikvjoy/8mbd3Surdwwz/697vuFtzc5dH1IoNBU6sXbs8Ivx2bpbsrxXccOXklsn
 PmQE=
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

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/input-linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index 74bc8511428a..f4eee1ffd7ec 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -166,8 +166,7 @@ static void input_linux_handle_keyboard(InputLinux *il,
 
         /* send event to guest when grab is active */
         if (il->grab_active && !input_linux_should_skip(il, event)) {
-            int qcode = qemu_input_linux_to_qcode(event->code);
-            qemu_input_event_send_key_qcode(NULL, qcode, event->value);
+            qemu_input_event_send_key_linux(NULL, event->code, event->value);
         }
 
         /* hotkey -> record switch request ... */

-- 
2.54.0


