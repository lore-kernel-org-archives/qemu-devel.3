Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE62DE7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrweE-0002iT-TF; Mon, 16 Feb 2026 06:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbR-0005ep-Nk
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbL-0007jM-J3
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqjVCvkYq0CnOFlMb4lk6iKs2Q8rG2tOtpRbxTNBD88=;
 b=URwOuUP23y3wuQTVphFC+p0HTL4Rj5pvBkQcZYb9TBcOsmBV80PlPMz5OA4hZsUTrNIbv7
 w8KWNeZHqCtzKI0T/QT6X0e036RmnTu9NWK3VYXR3tY4X86uO94M7d1vsTrE2gkUNQ77Vu
 DnMJkl+aVJ7k1tWE/JbsXJnAymqsyqA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-m-MpTFXUMRe-ryKWk1KUUg-1; Mon,
 16 Feb 2026 06:17:03 -0500
X-MC-Unique: m-MpTFXUMRe-ryKWk1KUUg-1
X-Mimecast-MFC-AGG-ID: m-MpTFXUMRe-ryKWk1KUUg_1771240621
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC38A1955D80; Mon, 16 Feb 2026 11:17:01 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E8AC30001B9; Mon, 16 Feb 2026 11:17:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:19 +0100
Subject: [PATCH 30/85] audio: keep a strong reference on the backend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-30-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2152;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=j2F0g3ta9yfDCkXiVp5Fmy/cGNEHqdhYISO5JqmAXcg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPIK7Ptx6NOV4c/yjxXVCio1QtyWaBS06Mx
 6Fnq6zEKoaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5fcNEACKgcbXrWgakQ8Z15q72T7ophiX9Uu7+hd2m/Xe96tMLXScVS/lDaVNIe9SKlvh8XMPArb
 2ugRGKYmA/Sq+IWgTcR1k+NOZiRluMTWTDtt2bTAqB+fB+1qP4mgb0agGWEJvR8MMh/KpY12Ja3
 I0Wx+EJr1GKPZiJmZgkljA2/VQ7x3PMp5TNiiXmc/UAnuSxN1GFLafY82pLfF9Bcic2rr/s4kMN
 cjuaVlfSYCY0JH8DGZkc1+nqyfDOe0UOi0QQmQlC/p42JiblOYWYEMKCuPBaTMpJhJqvRkMVsfA
 D0FJAnNvoGT21iNZ2KUjg3+/LtUIC7RTjUdxNsGURXvGynBZpZRpvMp3lW0Zi2FxE1uLLDyTSf5
 8WDXUQKuunIWyfOewQoB3qbvaAis+I0sOPODzh80zHY8xrS+9hus+Oo3gaMrQiOETVOGVasT9Nk
 D4UaqO7o7o7zQ1paL+LXTQPPhmHymdIIVpSCmpys2LjcU4bFVkeM/rXehKHw2sl6d7/GVKpQZf4
 iZ5IM51clSsBwYP6100G4Rm7d0p7U85QOCE2jWrcCE3bXbsHhT44bYnTOEOHzVzAPN/OhbMoiBB
 yP1SelUi7ra37Ox2AEg6VKO5hKJXN8H/s0qRX4VxLxyU0jl5x5cRjt/nO0gWupXNm2SLBev4EUL
 Gt0LWtDg6B3gIgw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Since we are going to convert audio_driver-based backends, we need to
properly handle reference counting to allow for a different order of
class finalization (for example, pulse class before base driver class).

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


