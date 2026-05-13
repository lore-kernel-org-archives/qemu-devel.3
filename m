Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48287CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN70x-0004UX-7Z; Wed, 13 May 2026 06:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70T-00040p-4H; Wed, 13 May 2026 06:40:04 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wN70P-0002Rn-M4; Wed, 13 May 2026 06:40:00 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64DAcPde044648
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2026 19:38:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=uJTvyFxVV0KiKR88wATfRrbdCU5rpbZH8pTJ+9EpZgo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1778668738; v=1;
 b=Ru3LnwGvn/r8yrMIKMxL6ADcxPWqvAlwUbCpJoevR8PFan+VSOHkIk7LwHrd7NiR
 ODvK/JGvCk8MerUdDmcq7k9fmbAIroGw5dhUpDiat1pA5qkeChXjiP7GxXtK3g13
 knds8Y7gOzXFxCXKJybF2QXo21FyOXDXhUGrFc5vMYbW7nPPXFY4MRtBuKcDS9iw
 YwyA+Ha1FXyGssPyJQJY3d2kh6HgXkm/F1jblnvye7kaukKFgzVuu2x5KaAVJAnY
 91EGu7BnHykVPT+jRMQXj/ivD2+FTPKGCa5sfgdOB0dImt5GZAYrc/g3roegLAv+
 BKpHRZNvE4yptXpP9LIlRg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 13 May 2026 19:38:32 +0900
Subject: [PATCH v2 16/29] replay: Use Linux key codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-input-v2-16-b3cc0470308a@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=VN8yQ5lgMxcp3qE4EJjzPaXZLmpoeQItNok0BraEMYc=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQxZLyGbdrVFxaYlhyXelZZ/9Slj7p4olc1PZuby1BdIP5
 MWOtTV3lLIwiHExyIopsqQU7ebWiK79VJgQ3wIzh5UJZAgDF6cATCRrGsP/4IBFnutvXHHK909a
 8fT3pq+nBG72BPRcr30T7qnx6Fq5N8M//WUcBXbrlrwobfh/jmvujMDJIiuOfHljuPjo7VcVFVY
 MjAA=
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
 replay/replay-input.c | 20 +++-----------------
 replay/replay.c       |  2 +-
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/replay/replay-input.c b/replay/replay-input.c
index acf0993c7285..c86e00af0efd 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -23,8 +23,7 @@ void replay_save_input_event(QemuInputEvent *evt)
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        replay_put_dword(KEY_VALUE_KIND_QCODE);
-        replay_put_dword(qemu_input_linux_to_qcode(evt->key.key));
+        replay_put_dword(evt->key.key);
         replay_put_byte(evt->key.down);
         break;
     case INPUT_EVENT_KIND_BTN:
@@ -55,25 +54,12 @@ void replay_save_input_event(QemuInputEvent *evt)
 QemuInputEvent *replay_read_input_event(void)
 {
     QemuInputEvent *evt = g_new(QemuInputEvent, 1);
-    int qcode;
 
     evt->type = replay_get_dword();
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
-        switch (replay_get_dword()) {
-        case KEY_VALUE_KIND_NUMBER:
-            qcode = qemu_input_key_number_to_qcode(replay_get_qword());
-            evt->key.down = replay_get_byte();
-            break;
-        case KEY_VALUE_KIND_QCODE:
-            qcode = (QKeyCode)replay_get_dword();
-            evt->key.down = replay_get_byte();
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        evt->key.key = qcode < qemu_input_map_qcode_to_linux_len ?
-                       qemu_input_map_qcode_to_linux[qcode] : 0;
+        evt->key.key = replay_get_dword();
+        evt->key.down = replay_get_byte();
         break;
     case INPUT_EVENT_KIND_BTN:
         evt->btn.button = (InputButton)replay_get_dword();
diff --git a/replay/replay.c b/replay/replay.c
index 2e5c6fa82eaa..14437b32566b 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -22,7 +22,7 @@
 
 /* Current version of the replay mechanism.
    Increase it when file format changes. */
-#define REPLAY_VERSION              0xe0200d
+#define REPLAY_VERSION              0xe0200e
 /* Size of replay log header */
 #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
 

-- 
2.54.0


