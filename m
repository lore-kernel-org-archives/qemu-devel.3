Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574F0CD37B8
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 10:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLfEc-00089w-Bf; Sat, 09 May 2026 06:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfEY-000866-1w; Sat, 09 May 2026 06:48:34 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLfEU-0001b0-TZ; Sat, 09 May 2026 06:48:33 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 649AlY2P090834
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 9 May 2026 19:48:02 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7AZuQUmohs7ZB6VnyND7lAhsDMjIqEN9r+C6jbcO76g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778323682; v=1;
 b=fEi43hBiqIKX07s/CCaA/yzcRRTf8HvX9Tu5xNoCPzzRVMioDQZl++yPQf2/DTCd
 8a+eDdlmXwcgEy6CNfIzy+boO+zCNmrBHySxv5S/dw2l15xx6pccghplv/zWEAFq
 IZHzApUgKguoHpJSMWIZ5KWuUABftTgFHAOP9DpCJzB3bVojUBBGTqADI6Ivr2KL
 Ah60ilg76wB8iPyxLXRi1n/8s853qu2Uzy0Y6EMdycmKnBxne3EoKstgZQ3w5VH4
 ufJCuJSOZ2eMvBGkzY/9pH8iD4EzLxTk/DDTR3ZlvF4Rftmbk1HRMpgdQNTGH3DU
 Mc2/f0pJFyYgfIaSv94YFA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 09 May 2026 19:34:36 +0900
Subject: [PATCH RFC 24/28] ui/spice: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-input-v1-24-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=L0N6BRIMKIkMescHTP9EJDsdj8Wd6180kuylCT6g9zw=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ+Z/gVut/ewpjrfFGFzNCz5cPvrwwZ7G02m3b1f+5Z9TG
 dN5/ENlRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwESClRgZfiW+M5xw+dby896y
 x7drPr6T/vqFhN5Dnmss5u4hp2buiWT4Z7B/keMikd2SuSqaxVaqz9OrdQ5cOR+3RC5E2sxcwZa
 LFwA=
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


