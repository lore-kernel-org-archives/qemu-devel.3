Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0A9D339AE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 18:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRafr-0000qt-S5; Fri, 05 Dec 2025 13:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vRafp-0000ms-W0
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:36:58 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1vRafo-0000rk-6X
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:36:57 -0500
DKIM-Signature: a=rsa-sha256; bh=2pyWT+ijaAI6DLpZ6FnZXSYLJabyOKZRjVSkjpPZHY8=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To; 
 q=dns/txt; s=20240113; t=1764959812; v=1;
 b=Zl7Ly3iWEuanvSEPLv3kDzS6Q/8NY2MW90iPsi+m67MrqxD8Plq0qPbE4zztZ1pz+bJOTyYo
 EfpoEzsCH5NWMvwMVNuTh2YDsL0J9wGTFaey4PMejb7EQu8Y+lgSKoQ6RhXJ9CFtCQLlJl7pu00
 vFNDV+21lQ9HyGZUoZVqwTr/UzkC22LUmK6LltYMhjZ8fyZJ5lNETu/wyMZBW2lV6X+AbLlYDsk
 ++vWWpWWJ1tYujfV1vuVctOZKLpbCG4y3oKV915/tXt2DXR0m7X0fvsZA+kvqTQ8ppUkHYAlexk
 0WfpJS1UDuBcpW/Ke/+WVkBsi0Zn8/MgXHCd3ya7mBSRA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 005FD241C5
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 18:36:52 +0000 (UTC)
From: ~katharine_chui <katharine_chui@git.sr.ht>
Date: Fri, 05 Dec 2025 16:11:19 +0100
Subject: [PATCH qemu v2 1/1] ui/sdl2: add multitouch support
Message-ID: <176495981181.29650.15848321452328771053-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <176495981181.29650.15848321452328771053-0@git.sr.ht>
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: ~katharine_chui <kwchuiaa@connect.ust.hk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Katharine Chui <katharine.chui@gmail.com>

Signed-off-by: Katharine Chui katharine.chui@gmail.com
---
 include/ui/sdl2.h |  9 +++++
 ui/sdl2.c         | 99 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index dbe6e3d9739..d965554e185 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -26,6 +26,9 @@
 # include "ui/egl-helpers.h"
 #endif
=20
+#include "input.h"
+#include "console.h"
+
 struct sdl2_console {
     DisplayGLCtx dgc;
     DisplayChangeListener dcl;
@@ -52,6 +55,12 @@ struct sdl2_console {
     bool y0_top;
     bool scanout_mode;
 #endif
+    struct {
+        bool pressing;
+        SDL_TouchID touch_id;
+        SDL_FingerID finger_id;
+    } fingers[INPUT_EVENT_SLOTS_MAX];
+    struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX];
 };
=20
 void sdl2_window_create(struct sdl2_console *scon);
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 032dc14bc39..1abbcadd7f0 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -651,6 +651,92 @@ static void handle_windowevent(SDL_Event *ev)
     }
 }
=20
+static void handle_touch(SDL_Event *ev){
+    SDL_TouchFingerEvent *finger_ev =3D (SDL_TouchFingerEvent *)ev;
+    struct sdl2_console *scon =3D get_scon_from_window(finger_ev->windowID);
+    Error *err =3D NULL;
+    int num_slot =3D -1;
+    int type =3D -1;
+    int width, height;
+    double x, y;
+    int i;
+
+    if (!scon) {
+        return;
+    }
+
+    switch (finger_ev->type) {
+    case SDL_FINGERDOWN:
+        for (i =3D 0; i < INPUT_EVENT_SLOTS_MAX; i++){
+            if (scon->fingers[i].pressing &&
+                scon->fingers[i].touch_id =3D=3D finger_ev->touchId &&
+                scon->fingers[i].finger_id =3D=3D finger_ev->fingerId){
+                // it is possible for sdl2 to send this twice, in that case =
treat it as an update
+                num_slot =3D i;
+                type =3D INPUT_MULTI_TOUCH_TYPE_UPDATE;
+                break;
+            }
+        }
+        if (num_slot !=3D -1){
+            break;
+        }
+        for (i =3D 0; i < INPUT_EVENT_SLOTS_MAX; i++){
+            if (!scon->fingers[i].pressing){
+                scon->fingers[i].pressing =3D true;
+                scon->fingers[i].touch_id =3D finger_ev->touchId;
+                scon->fingers[i].finger_id =3D finger_ev->fingerId;
+                num_slot =3D i;
+                type =3D INPUT_MULTI_TOUCH_TYPE_BEGIN;
+                break;
+            }
+        }
+        break;
+    case SDL_FINGERMOTION:
+        for (i =3D 0; i < INPUT_EVENT_SLOTS_MAX; i++){
+            if (scon->fingers[i].pressing &&
+                scon->fingers[i].touch_id =3D=3D finger_ev->touchId &&
+                scon->fingers[i].finger_id =3D=3D finger_ev->fingerId){
+                num_slot =3D i;
+                type =3D INPUT_MULTI_TOUCH_TYPE_UPDATE;
+                break;
+            }
+        }
+        break;
+    case SDL_FINGERUP:
+        for (i =3D 0; i < INPUT_EVENT_SLOTS_MAX; i++){
+            if (scon->fingers[i].pressing &&
+                scon->fingers[i].touch_id =3D=3D finger_ev->touchId &&
+                scon->fingers[i].finger_id =3D=3D finger_ev->fingerId){
+                scon->fingers[i].pressing =3D false;
+                num_slot =3D i;
+                type =3D INPUT_MULTI_TOUCH_TYPE_END;
+                break;
+            }
+        }
+        break;
+    }
+
+    if (num_slot =3D=3D -1){
+        error_setg(&err, "Cannot handle more than %d fingers",
+                   INPUT_EVENT_SLOTS_MAX);
+        warn_report_err(err);
+        return;
+    }
+
+    width =3D surface_width(scon->surface);
+    height =3D surface_height(scon->surface);
+    x =3D finger_ev->x * width;
+    y =3D finger_ev->y * height;
+
+    console_handle_touch_event(scon->dcl.con, scon->touch_slots,
+                               num_slot, width, height, x, y,
+                               type, &err);
+
+    if (err) {
+        warn_report_err(err);
+    }
+}
+
 void sdl2_poll_events(struct sdl2_console *scon)
 {
     SDL_Event ev1, *ev =3D &ev1;
@@ -701,6 +787,12 @@ void sdl2_poll_events(struct sdl2_console *scon)
         case SDL_WINDOWEVENT:
             handle_windowevent(ev);
             break;
+        case SDL_FINGERMOTION:
+        case SDL_FINGERDOWN:
+        case SDL_FINGERUP:
+            idle =3D 0;
+            handle_touch(ev);
+            break;
         default:
             break;
         }
@@ -838,7 +930,7 @@ static void sdl2_display_early_init(DisplayOptions *o)
 static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 {
     uint8_t data =3D 0;
-    int i;
+    int i, j;
     SDL_SysWMinfo info;
     SDL_Surface *icon =3D NULL;
     char *dir;
@@ -862,6 +954,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOp=
tions *o)
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
     SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
+    SDL_SetHint(SDL_HINT_TOUCH_MOUSE_EVENTS, "0");
     SDL_EnableScreenSaver();
     memset(&info, 0, sizeof(info));
     SDL_VERSION(&info.version);
@@ -920,6 +1013,10 @@ static void sdl2_display_init(DisplayState *ds, Display=
Options *o)
 #endif
         }
 #endif
+
+        for (j =3D 0; j < INPUT_EVENT_SLOTS_MAX; j++) {
+            sdl2_console[i].touch_slots[j].tracking_id =3D -1;
+        }
     }
=20
 #ifdef CONFIG_SDL_IMAGE
--=20
2.49.1

