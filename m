Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B969ECD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN701-0003qz-H9; Wed, 13 May 2026 06:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN6zy-0003oE-8G; Wed, 13 May 2026 06:39:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN6zv-0002Ly-JG; Wed, 13 May 2026 06:39:29 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64DAcPdn044648
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2026 19:39:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7AZuQUmohs7ZB6VnyND7lAhsDMjIqEN9r+C6jbcO76g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778668740; v=1;
 b=JupKtK3uerSTBzxhTpnnAmPB98w4B8V3rLqm03VWEr72aN6TqFSJqpK0TjiP3mEr
 wVGrXt+tHdgn7r5GiknyE1XOjhQBzWFz38iTrzEW6FYR7J6jr2R3TyQ7YfWSlgOx
 dNMvxewOtDvgY5p7sr9pN5wIss9zv668zQSNZXiWU6c0uD6gL00kVH06EpCNSsoQ
 5/EloJZ2YV4HRb0p+U2b7TgH4EEamGjN5l8ZPLLqjHwZlskUQFu1UF/17luH012L
 blUWdWHBHYYloAOcMOPqxtyUIzFOU+bYLlqyUGBJURWQwxN3yOaIaYPRVjyTx3XW
 Bpqiw3fjvjFlBKwTQREshg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 13 May 2026 19:38:41 +0900
Subject: [PATCH v2 25/29] ui/spice: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-input-v2-25-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=L0N6BRIMKIkMescHTP9EJDsdj8Wd6180kuylCT6g9zw=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZLyM43s1xd5pR8WrRGJWfqCjPt00xmGdP9r3Om/vwWt
 n2O5NEDHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABMxe8Twv9zg1rYvc1fwnnas
 vaB+ZL7iJ9ZJ2Y9ueWYuYI5zvmD62ISRYemjboW1N56f59QN3rvOX/nyOXemxyaeiQorvjiXnzT
 M4QAA
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
 ui/spice-input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index a5c5d78474e7..f0bb915fd77b 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -20,6 +20,7 @@
 #include <spice.h>
 #include <spice/enums.h>
 
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/qemu-spice.h"
 #include "ui/console.h"
 #include "keymaps.h"
@@ -61,7 +62,7 @@ static void kbd_push_key(SpiceKbdInstance *sin, uint8_t scancode)
     if (scancode == pauseseq[kbd->pauseseq]) {
         kbd->pauseseq++;
         if (kbd->pauseseq == G_N_ELEMENTS(pauseseq)) {
-            qemu_input_event_send_key_qcode(NULL, Q_KEY_CODE_PAUSE, true);
+            qemu_input_event_send_key_linux(NULL, KEY_PAUSE, true);
             kbd->pauseseq = 0;
         }
         return;

-- 
2.54.0


