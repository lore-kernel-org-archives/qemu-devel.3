Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D43DD116F5
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ21U-0002sq-CT; Mon, 01 Dec 2025 06:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21S-0002cT-9B
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21Q-0006dV-Ps
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3g8JxiwbPFLnYrOLWm3YCZxCI3y+1VP+hhdBbtdOIKM=;
 b=XlP+4/Rd5ooKSJuVAIKh7zSKP7DuvzZFmnYtw1v5OonJKmdzCPvv6MKftIhGXPw/iPLAB4
 qCGptEIVcCwI05gN7uAyyft8sou7Qd02mOcr3KZvUoIztcIptncefSGWMx9G9U3v37qatc
 W0a7M9Qs8hTZQxjXllP2zZdltWkm0bQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-rXlObdUbPI63wvzysurcWQ-1; Mon,
 01 Dec 2025 06:24:43 -0500
X-MC-Unique: rXlObdUbPI63wvzysurcWQ-1
X-Mimecast-MFC-AGG-ID: rXlObdUbPI63wvzysurcWQ_1764588282
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48DC2180034A; Mon,  1 Dec 2025 11:24:42 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3206180087D; Mon,  1 Dec 2025 11:24:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 13/24] audio: keep a strong reference on the backend
Date: Mon,  1 Dec 2025 15:22:54 +0400
Message-ID: <20251201112309.4163921-14-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since we are going to convert audio_driver-based backends, we need to
properly handle reference counting to allow for a different order of
class finalization (for example, pulse class before base driver class).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 925a878f6d..7d204d25bc 100644
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
@@ -287,7 +288,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioDriver *s,
      * is guaranteed to be != 0. See the audio_init_nb_voices_* functions.
      */
     hw = g_malloc0(glue(drv->voice_size_, TYPE));
-    hw->s = s;
+    hw->s = AUDIO_DRIVER(object_ref(s));
     hw->pcm_ops = drv->pcm_ops;
 
     QLIST_INIT (&hw->sw_head);
@@ -335,6 +336,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioDriver *s,
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
+    sw->s = AUDIO_DRIVER(object_ref(s));
 
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
2.51.1


