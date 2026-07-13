Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D000DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 19:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjM0I-0007tW-6h; Mon, 13 Jul 2026 15:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kernel@0in.de>) id 1wjM0E-0007tE-In
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 15:07:43 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <kernel@0in.de>) id 1wjM0B-0006H2-Aj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 15:07:42 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gzX4j3mfxz8sYP;
 Mon, 13 Jul 2026 21:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0in.de; s=MBO0001;
 t=1783969653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=K2D5KzhgtzOWVpAh40HG1UrFqlC5+h1KGVbBsTIt3mI=;
 b=dtsMy7pD0Fs5JJhIgC2BO2agjKNqnihocYAaKypyv8MUksGngqdYnSdsYHVMaxz6aps6BQ
 jyCxazUJWxSq0w7lgFk92k1M/tyVr/53fxYo8Cs9HaHa+c6TXgq/h6edi/ebQN4wKjMFrI
 zfBqrBbh/w9n9C98fIux6mnl4C05K7PlXP+8ydQJaZYaMi05kEv/hBrrTHd1iAWXEzeAX3
 Lw9GyA64hGc+g6qNSNXjKDDudBXiPhP+Wdq7qS1d1rlXJJMeoykSELPJrKFRcpgrv/QuwN
 WJcNZIeu8xPOnOGYA6VUK5rLSVGkEUxqbzYVmLySyv1QDDTOStYIFtYT2z24jg==
Date: Mon, 13 Jul 2026 21:07:30 +0200 (CEST)
From: Maximilian Senftleben <kernel@0in.de>
To: qemu-devel@nongnu.org
cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Marc-Andre Lureau <marcandre.lureau@redhat.com>, 
 Justinien Bouron <justinien.bouron@gmail.com>, 
 Maximilian Senftleben <kernel@0in.de>
Subject: [PATCH v5] input-linux: Add option to not grab a device upon guest
 startup
Message-ID: <05e99ebc-5108-b2f1-4b1f-14e8715d0bf4@0in.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=80.241.56.151; envelope-from=kernel@0in.de;
 helo=mout-p-101.mailbox.org
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Some workflows start a guest in the background and do not want evdev
devices to be grabbed immediately.  In that case, the current behavior
is annoying because the host loses control of the keyboard or mouse
before the user actually wants to interact with the guest.

Add a new boolean input-linux property, grab-on-startup.  When true,
the device is grabbed during initialization, which keeps the existing
behavior.  When false, the device remains ungrabbed until the toggle
key combination is entered.

Also make sure startup grabbing is skipped entirely when
grab-on-startup is false, even if keys are already pressed during
device initialization.  Without this, QEMU could still perform a delayed
grab once those keys are released.

This revives an earlier patch originally posted by Justinien Bouron and
incorporates the follow-up review feedback.

Link: 
https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/
Link: https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04004.html
Signed-off-by: Maximilian Senftleben <kernel@0in.de>
---
This revives Justinien Bouron's earlier input-linux grab-on-startup
patch:

     
https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/

Last known review state:
- Marc-Andre Lureau asked for a resend with an updated commit message:
     https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04003.html
- Markus Armbruster reviewed the QAPI schema and pointed out that the
     delayed-grab path still needed to be skipped when keys are already
     pressed at startup and grab-on-startup is false:
     https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04004.html
- Daniel P. Berrange asked for a clearer motivation for the feature:
     https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg01969.html

Changes since v4:
- Fixed patch indentation

 qapi/qom.json    | 14 +++++++++++++-
 ui/input-linux.c | 27 +++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087..e3eda5c1ec 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -558,13 +558,25 @@
 # @grab-toggle: the key or key combination that toggles device grab
 #     (default: ctrl-ctrl)
 #
+# @grab-on-startup: if true, grab the device immediately upon starting
+#     the guest.  Otherwise, don't grab the device until the
+#     combination is entered.  This does not influence other devices
+#     even if grab_all is true, i.e. in the unlikely scenario where
+#     device1 has grab_all=true + grab-on-startup=true and device2 has
+#     grab-on-startup=false, only device1 is grabbed on startup, then,
+#     once the grab combination is entered, grabbing is toggled off
+#     for both devices (because device1 enforces the grab_all
+#     property) until the combination is entered again at which point
+#     both devices will be grabbed.  (default: true)  (since 11.1).
+#
 # Since: 2.6
 ##
 { 'struct': 'InputLinuxProperties',
   'data': { 'evdev': 'str',
             '*grab_all': 'bool',
             '*repeat': 'bool',
-            '*grab-toggle': 'GrabToggleKeys' },
+            '*grab-toggle': 'GrabToggleKeys',
+            '*grab-on-startup': 'bool' },
   'if': 'CONFIG_LINUX' }
 
 ##
diff --git a/ui/input-linux.c b/ui/input-linux.c
index f4eee1ffd7..767374e99a 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -43,6 +43,7 @@ struct InputLinux {
     bool        grab_request;
     bool        grab_active;
     bool        grab_all;
+    bool        grab_on_startup;
     bool        keydown[KEY_CNT];
     int         keycount;
     int         wheel;
@@ -394,12 +395,17 @@ static void input_linux_complete(UserCreatable *uc, 
Error **errp)
     }
 
     qemu_set_fd_handler(il->fd, input_linux_event, NULL, il);
+    if (!il->grab_on_startup) {
+        goto skip_grab;
+    }
     if (il->keycount) {
         /* delay grab until all keys are released */
         il->grab_request = true;
     } else {
         input_linux_toggle_grab(il);
     }
+
+skip_grab:
     QTAILQ_INSERT_TAIL(&inputs, il, next);
     il->initialized = true;
     return;
@@ -487,6 +493,21 @@ static void input_linux_set_grab_toggle(Object *obj, 
int value,
     il->grab_toggle = value;
 }
 
+static bool input_linux_get_grab_on_startup(Object *obj, Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+
+    return il->grab_on_startup;
+}
+
+static void input_linux_set_grab_on_startup(Object *obj, bool value,
+                                            Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+
+    il->grab_on_startup = value;
+}
+
 static void input_linux_instance_init(Object *obj)
 {
 }
@@ -494,6 +515,7 @@ static void input_linux_instance_init(Object *obj)
 static void input_linux_class_init(ObjectClass *oc, const void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    ObjectProperty *grab_on_startup_prop;
 
     ucc->complete = input_linux_complete;
 
@@ -510,6 +532,11 @@ static void input_linux_class_init(ObjectClass *oc, 
const void *data)
                                    &GrabToggleKeys_lookup,
                                    input_linux_get_grab_toggle,
                                    input_linux_set_grab_toggle);
+    grab_on_startup_prop = object_class_property_add_bool(
+        oc, "grab-on-startup",
+        input_linux_get_grab_on_startup,
+        input_linux_set_grab_on_startup);
+    object_property_set_default_bool(grab_on_startup_prop, true);
 }
 
 static const TypeInfo input_linux_info = {
--
2.53.0


