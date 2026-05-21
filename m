Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B127CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3uu-0005s4-4z; Thu, 21 May 2026 09:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3un-00059T-R2
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wQ3ul-0002MJ-Ry
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NerBL8YhWwt1E/m5BbUsyQi59AL6gFH7Lahx7RmXUec=;
 b=UuwuXq7vr3XrCyBb7WVY8mWHM/Ft2DDzAi9NImCA++04qWo2LFVJXCszGUhkPF3nvZU83j
 td4OF7n9yFSmQAFwj78+TvMKz12q/WRDZwIPlJC9Oj7TSTnqIlfBJUBtx6vRZbh+C9UCkB
 /Dp6EY+DaDvWPrEJwrm4psyhkB8lGUg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-bowIpwYTMKyem2_kZnRJyg-1; Thu,
 21 May 2026 09:58:15 -0400
X-MC-Unique: bowIpwYTMKyem2_kZnRJyg-1
X-Mimecast-MFC-AGG-ID: bowIpwYTMKyem2_kZnRJyg_1779371894
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBCD218002D0; Thu, 21 May 2026 13:58:13 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D819D1800347; Thu, 21 May 2026 13:58:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 24/38] replay: Use Linux key codes
Date: Thu, 21 May 2026 17:55:35 +0400
Message-ID: <20260521135551.1752945-25-marcandre.lureau@redhat.com>
In-Reply-To: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
References: <20260521135551.1752945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-16-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 replay/replay-input.c | 20 +++-----------------
 replay/replay.c       |  2 +-
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/replay/replay-input.c b/replay/replay-input.c
index acf0993c728..c86e00af0ef 100644
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
index 2e5c6fa82ea..14437b32566 100644
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


