Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888CFD16265
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0LLA-0004J9-83; Mon, 14 Oct 2024 09:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LKE-0003AR-9C
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LK9-00046b-Vy
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728913281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0qvAI4sJh/+NR47op4BEESLNhwLye3AuT0uj5rvnP3E=;
 b=JWHDPpXDViEJhZW+pTZ39q5luB5lcle0xAgg7d6f8GDi4JZVlY9yemAabKj3wRtF8oPgV9
 5Fu4mRW68mwoW2yQym5Gze9uHxqbtLJwKg/YM6w3XP2zRHkuTPam7L5GP65p9X4C4CR0S2
 w6oHfS9QDE7ENlL0aEqhe8bT8a7EZ1w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580--czsQN4-OAmnNCT3LQSnkA-1; Mon,
 14 Oct 2024 09:41:19 -0400
X-MC-Unique: -czsQN4-OAmnNCT3LQSnkA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7873A195608C; Mon, 14 Oct 2024 13:41:18 +0000 (UTC)
Received: from localhost (unknown [10.39.208.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C67030001A7; Mon, 14 Oct 2024 13:41:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Michal Privoznik <mprivozn@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 20/20] audio/pw: Report more accurate error when connecting to
 PipeWire fails
Date: Mon, 14 Oct 2024 17:39:35 +0400
Message-ID: <20241014133935.470709-21-marcandre.lureau@redhat.com>
In-Reply-To: <20241014133935.470709-1-marcandre.lureau@redhat.com>
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Michal Privoznik <mprivozn@redhat.com>

According to its man page [1], pw_context_connect() sets errno on
failure:

  Returns a Core on success or NULL with errno set on error.

It may be handy to see errno when figuring out why PipeWire
failed to connect. That leaves us with just one possible path to
reach 'fail_error' label which is then moved to that path and
also its error message is adjusted slightly.

1: https://docs.pipewire.org/group__pw__core.html#ga5994e3a54e4ec718094ca02a1234815b

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <3a78811ad5b0e87816b7616ab21d2eeef00b9c52.1726647033.git.mprivozn@redhat.com>
---
 audio/pwaudio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 3b14e04fbb..8e13b58286 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -769,13 +769,15 @@ qpw_audio_init(Audiodev *dev, Error **errp)
     pw->core = pw_context_connect(pw->context, NULL, 0);
     if (pw->core == NULL) {
         pw_thread_loop_unlock(pw->thread_loop);
-        goto fail_error;
+        error_setg_errno(errp, errno, "Failed to connect to PipeWire instance");
+        goto fail;
     }
 
     if (pw_core_add_listener(pw->core, &pw->core_listener,
                              &core_events, pw) < 0) {
         pw_thread_loop_unlock(pw->thread_loop);
-        goto fail_error;
+        error_setg(errp, "Failed to add PipeWire listener");
+        goto fail;
     }
     if (wait_resync(pw) < 0) {
         pw_thread_loop_unlock(pw->thread_loop);
@@ -785,8 +787,6 @@ qpw_audio_init(Audiodev *dev, Error **errp)
 
     return g_steal_pointer(&pw);
 
-fail_error:
-    error_setg(errp, "Failed to initialize PW context");
 fail:
     if (pw->thread_loop) {
         pw_thread_loop_stop(pw->thread_loop);
-- 
2.47.0


