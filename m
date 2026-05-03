Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5354FFF886F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 07:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJQxi-0005ee-2N; Sun, 03 May 2026 03:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJQxf-0005eW-Su
 for qemu-devel@nongnu.org; Sun, 03 May 2026 03:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJQxe-0002BO-3I
 for qemu-devel@nongnu.org; Sun, 03 May 2026 03:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777792190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dWdls0qxO24t0lHRZtq5+1onptUNMWa3UAZJKRMBIhc=;
 b=KPHohrbp6cdKXTvXA2qB9AASihnt9QMdLQsRMMrbbGZXf1gqX6p7VeMwBAHJyYbrs1POK+
 FoAKnKHtqliwuqQdXl7VHz8ERSSTxWZe+pj14UK2L9OCZGjOD704D0Pjjud/v0flkA4f3e
 NveW90xgq6IkL66wv6UBiABgooKGVmU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-AkUG29rgNby310tzq_M3Nw-1; Sun,
 03 May 2026 03:09:48 -0400
X-MC-Unique: AkUG29rgNby310tzq_M3Nw-1
X-Mimecast-MFC-AGG-ID: AkUG29rgNby310tzq_M3Nw_1777792188
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB0E51800473
 for <qemu-devel@nongnu.org>; Sun,  3 May 2026 07:09:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEE9619560A6; Sun,  3 May 2026 07:09:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/input: do not assert() when tracing invalid input
Date: Sun,  3 May 2026 11:09:39 +0400
Message-ID: <20260503070939.2730826-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

It's possible to reach an assert() in the input tracing code by sending
some out of range input values via D-Bus for ex:

  #0  0x00007fec8652186c in __pthread_kill_implementation () at /lib64/libc.so.6
  #1  0x00007fec864c648e in raise () at /lib64/libc.so.6
  #2  0x00007fec864ad7b3 in abort () at /lib64/libc.so.6
  #3  0x00007fec864ae804 in __libc_message_impl.cold () at /lib64/libc.so.6
  #4  0x00007fec864be345 in __assert_fail () at /lib64/libc.so.6
  #5  0x00005597964c551e in qapi_enum_lookup[cold] ()
  #6  0x000055979650514a in qemu_input_event_send_impl ()
  #7  0x0000559796505a4d in qemu_input_queue_btn ()
  #8  0x00007fec85780c19 in dbus_mouse_press () at /usr/bin/../lib64/qemu/ui-dbus.so
  #9  0x00007fec857912fc in _g_dbus_codegen_marshal_BOOLEAN__OBJECT_UINT.part.0 () at /usr/bin/../lib64/qemu/ui-dbus.so
  #10 0x00007fec874cce7c in g_closure_invoke () at /lib64/libgobject-2.0.so.0
  #11 0x00007fec874eb849 in signal_emit_unlocked_R.isra.0 () at /lib64/libgobject-2.0.so.0
  #12 0x00007fec874ec66f in g_signal_emitv () at /lib64/libgobject-2.0.so.0
  #13 0x00007fec85797e0a in _qemu_dbus_display1_mouse_skeleton_handle_method_call () at /usr/bin/../lib64/qemu/ui-dbus.so

Other paths in input code accept out-of-range values
(qemu_input_key_value_to_number etc). Let it pass tracing.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/input.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/input.c b/ui/input.c
index 57e7817878a..966023d4f4d 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -207,22 +207,22 @@ static void qemu_input_event_trace(QemuConsole *src, InputEvent *evt)
         break;
     case INPUT_EVENT_KIND_BTN:
         btn = evt->u.btn.data;
-        name = InputButton_str(btn->button);
+        name = btn->button < INPUT_BUTTON__MAX ? InputButton_str(btn->button) : "invalid";
         trace_input_event_btn(idx, name, btn->down);
         break;
     case INPUT_EVENT_KIND_REL:
         move = evt->u.rel.data;
-        name = InputAxis_str(move->axis);
+        name = move->axis < INPUT_AXIS__MAX ? InputAxis_str(move->axis) : "invalid";
         trace_input_event_rel(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND_ABS:
         move = evt->u.abs.data;
-        name = InputAxis_str(move->axis);
+        name = move->axis < INPUT_AXIS__MAX ? InputAxis_str(move->axis) : "invalid";
         trace_input_event_abs(idx, name, move->value);
         break;
     case INPUT_EVENT_KIND_MTT:
         mtt = evt->u.mtt.data;
-        name = InputAxis_str(mtt->axis);
+        name = mtt->axis < INPUT_AXIS__MAX ? InputAxis_str(mtt->axis) : "invalid";
         trace_input_event_mtt(idx, name, mtt->value);
         break;
     case INPUT_EVENT_KIND__MAX:
-- 
2.54.0


