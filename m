Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BE0C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzJU-0002nh-5V; Mon, 22 Jul 2024 16:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sVzJQ-0002bu-4T
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sVzJM-0002CV-JE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721678819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CI2AMo5a4uSAUKgAi5B76TMJAVsef4x2rl0XQVccIA=;
 b=W/UXkiecjxW1jC2w4i7OzMeI0kaGzaQxGE26oDOXts0P1zAqZnA35Gunr3qKmVZQlpYaJx
 bfZOz0jFCbXuMcWXtClF7GfuQL3yVVGIaxtPfJ8pqAkIqkymspInmkqqNSY9QUG8l237YD
 Gu4H+zincDJ+b90sk3ndgQ2LUcrwRfU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-B7XwHm27MxaO1jGZm6N6_Q-1; Mon,
 22 Jul 2024 16:06:58 -0400
X-MC-Unique: B7XwHm27MxaO1jGZm6N6_Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1805919540F2; Mon, 22 Jul 2024 20:06:57 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33DF81955F40; Mon, 22 Jul 2024 20:06:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 7/8] ui/vdagent: send caps on fe_open
Date: Tue, 23 Jul 2024 00:06:17 +0400
Message-ID: <20240722200619.135163-8-marcandre.lureau@redhat.com>
In-Reply-To: <20240722200619.135163-1-marcandre.lureau@redhat.com>
References: <20240722200619.135163-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The spice-vdagentd doesn't send capabilities again on host/client
disconnect (but when the session agent connects and sends a
GUEST_XORG_RESOLUTION message)

When the dbus client disconnects, vdagent_disconnect() is called to
reset the agent state. Capabilities must be negotiated again on
reconnection.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717171541.201525-5-marcandre.lureau@redhat.com>
---
 ui/vdagent.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 2a4b3574b1..724eff972f 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -185,7 +185,7 @@ static void vdagent_send_msg(VDAgentChardev *vd, VDAgentMessage *msg)
     vdagent_send_buf(vd);
 }
 
-static void vdagent_send_caps(VDAgentChardev *vd)
+static void vdagent_send_caps(VDAgentChardev *vd, bool request)
 {
     g_autofree VDAgentMessage *msg = g_malloc0(sizeof(VDAgentMessage) +
                                                sizeof(VDAgentAnnounceCapabilities) +
@@ -205,6 +205,7 @@ static void vdagent_send_caps(VDAgentChardev *vd)
 #endif
     }
 
+    caps->request = request;
     vdagent_send_msg(vd, msg);
 }
 
@@ -711,7 +712,7 @@ static void vdagent_chr_recv_caps(VDAgentChardev *vd, VDAgentMessage *msg)
 
     vd->caps = caps->caps[0];
     if (caps->request) {
-        vdagent_send_caps(vd);
+        vdagent_send_caps(vd, false);
     }
     if (have_mouse(vd) && vd->mouse_hs) {
         qemu_input_handler_activate(vd->mouse_hs);
@@ -885,6 +886,7 @@ static void vdagent_chr_set_fe_open(struct Chardev *chr, int fe_open)
         return;
     }
 
+    vdagent_send_caps(vd, true);
 }
 
 static void vdagent_chr_parse(QemuOpts *opts, ChardevBackend *backend,
-- 
2.45.2.827.g557ae147e6


