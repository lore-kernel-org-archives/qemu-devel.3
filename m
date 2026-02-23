Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C709EA4FC1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWJz-0003Jn-2s; Mon, 23 Feb 2026 08:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWJ2-0001Dq-JK
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:49:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWJ1-000775-8K
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TqhGjBY+mC3y4OSdljPQ85F3Z7Hx6fbG+VByjEnt370=;
 b=TmNOtAdetsFOBp17v8PitxF0r6vAX9ckI9YvA2ujE/MSuhZ7mLJf1FOOrP/RPak+aWlctT
 WOpZcDksxpVNXApjhxwMED7vPkEZRmL7wvxVKlTKHYdRiXODtubJ+sT/toKGogHgSEdTSH
 QikJvgH/JnjXB11/z9xohgBxT71X1YQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-1xFkVo6XNyGhITzt5xtmuQ-1; Mon,
 23 Feb 2026 08:48:57 -0500
X-MC-Unique: 1xFkVo6XNyGhITzt5xtmuQ-1
X-Mimecast-MFC-AGG-ID: 1xFkVo6XNyGhITzt5xtmuQ_1771854536
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84A91195608D; Mon, 23 Feb 2026 13:48:56 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A0A719560A2; Mon, 23 Feb 2026 13:48:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 30/85] audio: keep a strong reference on the backend
Date: Mon, 23 Feb 2026 14:46:31 +0100
Message-ID: <20260223134731.2377432-31-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since we are going to convert audio_driver-based backends, we need to
properly handle reference counting to allow for a different order of
class finalization (for example, pulse class before base driver class).

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index a1f78d8748b..512abbfe22f 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -231,6 +231,7 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
         glue(hw->pcm_ops->fini_, TYPE) (hw);
         glue(s->nb_hw_voices_, TYPE) += 1;
         glue(audio_pcm_hw_free_resources_ , TYPE) (hw);
+        object_unref(hw->s);
         g_free(hw);
         *hwp = NULL;
     }
@@ -287,7 +288,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
      * is guaranteed to be != 0. See the audio_init_nb_voices_* functions.
      */
     hw = g_malloc0(glue(drv->voice_size_, TYPE));
-    hw->s = s;
+    hw->s = AUDIO_MIXENG_BACKEND(object_ref(s));
     hw->pcm_ops = drv->pcm_ops;
 
     QLIST_INIT (&hw->sw_head);
@@ -335,6 +336,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
  err1:
     glue (hw->pcm_ops->fini_, TYPE) (hw);
  err0:
+    object_unref(hw->s);
     g_free (hw);
     return NULL;
 }
@@ -441,7 +443,7 @@ static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
     }
 
     sw = g_new0(SW, 1);
-    sw->s = s;
+    sw->s = AUDIO_MIXENG_BACKEND(object_ref(s));
 
     hw = glue(audio_pcm_hw_add_, TYPE)(s, &hw_as);
     if (!hw) {
@@ -461,6 +463,7 @@ err2:
     glue (audio_pcm_hw_del_sw_, TYPE) (sw);
     glue (audio_pcm_hw_gc_, TYPE) (&hw);
 err1:
+    object_unref(sw->s);
     g_free(sw);
     return NULL;
 }
@@ -470,6 +473,8 @@ static void glue (audio_close_, TYPE) (SW *sw)
     glue (audio_pcm_sw_fini_, TYPE) (sw);
     glue (audio_pcm_hw_del_sw_, TYPE) (sw);
     glue (audio_pcm_hw_gc_, TYPE) (&sw->hw);
+
+    object_unref(sw->s);
     g_free (sw);
 }
 
-- 
2.53.0


