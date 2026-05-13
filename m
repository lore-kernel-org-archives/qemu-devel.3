Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA5ACD4F35
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN70v-0004Oh-5D; Wed, 13 May 2026 06:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70P-00040H-0K; Wed, 13 May 2026 06:39:58 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70M-0002Q6-IF; Wed, 13 May 2026 06:39:56 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64DAcPdT044648
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2026 19:38:55 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=aLM6N6GfPMXT/Dyyq93/Kd26hw7nsVW+P5nkMjY0fK4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778668735; v=1;
 b=GS185QR6pjVyi5cnpta3/qDr2LJV/0n/2sYe2e2kzhm0yNtVh6g3Rx6r21ixu+Dh
 Hvhb05x4kMU+tHoHtbMerw6PJgGa3TpA8uMsTHDRlbxX8qzHn7J4lSBrj+xaoB9T
 IPLQLgd5TqdMshI+r3ESHtMDErtuR0xn2VXDIfXPyhmBUJQ6LKmzgoLx95bePbp5
 802PhcMFvZilR4UfvFxx5tcV+A49kaRXlDnyG6fLJL/WVkkf1vecuXg+L9I+PI5C
 znCZb42LooQaE9psoX3yjt4Jm0mOL2XL+lGNYjwEcGX8O1VI6mzOfahemiMvwqlS
 /vaR/zKLtgb4Oh94w4ykJw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 13 May 2026 19:38:21 +0900
Subject: [PATCH v2 05/29] ui/input: Prohibit sending KEY_RESERVED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-input-v2-5-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=958;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=9/7ez5xuk9jdnoso/psewP+978HfdB0j7SVfWdhgZ1o=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZLyGrNlBd9nenr9HWuHinj1mL45+bUErJyc1j4z3dt/
 /ftjgrsKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEgIF8NfseIjXqqPwice6vNX
 3+HyysO/IkH0kPHtzykMEZaTDBv1GRmufkjVe7ryiOs1/YMve7rbLH9ffHDe51Hpt5Ddp1awrA9
 mBQA=
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

xenfb and virtio-input no longer need key mapping because they operate
on Linux key codes, but removing the key mapping code loses the ability
to filter out KEY_RESERVED. Drop KEY_RESERVED at the common input event
entry point so the logic is shared by both devices and no downstream
input handler receives KEY_RESERVED accidentally.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/input.c b/ui/input.c
index 5d155e3af072..8ed225591de1 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -328,6 +328,10 @@ void qemu_input_event_send_impl(QemuConsole *src, QemuInputEvent *evt)
 
 void qemu_input_event_send(QemuConsole *src, QemuInputEvent *evt)
 {
+    if (evt->type == INPUT_EVENT_KIND_KEY && !evt->key.key) {
+        return;
+    }
+
     if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) {
         return;
     }

-- 
2.54.0


