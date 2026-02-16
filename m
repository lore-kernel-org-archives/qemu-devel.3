Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF8EE7BD95
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrweE-0002hq-8Z; Mon, 16 Feb 2026 06:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbu-0006B2-Dz
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbo-00085t-9s
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtzBFPtZnBgBep7PFOTmKmy8bJLlcZgL5VlJnM7+pJ0=;
 b=fewvYkhqYEDmCI7gNbUUPvfaoMZlrQYlhcKXTlyFdaxUAUrzibHraL821YbzcLSp8Y+8bF
 cvaweGlFnzw+4QpwMl5xpIivZkj8cpGv1qYYs2z1eFokmhF2ClfpKwbzjChynYE7wOYwrp
 /cHgeyoI0Y3HcEE3WBW48eLNA+L+IRk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-OyzgE7IpMM2b6tCvuj9R3Q-1; Mon,
 16 Feb 2026 06:17:35 -0500
X-MC-Unique: OyzgE7IpMM2b6tCvuj9R3Q-1
X-Mimecast-MFC-AGG-ID: OyzgE7IpMM2b6tCvuj9R3Q_1771240653
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21D4A19560AA; Mon, 16 Feb 2026 11:17:33 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7902030001A5; Mon, 16 Feb 2026 11:17:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:30 +0100
Subject: [PATCH 41/85] audio: make audio_driver init() & fini() optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-41-e676662e4514@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XQa2aioA9AFhg3/Oy50D65dq2g48xqh2ie7D90kz/0Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQcgsxG/QPT1xwp6eTSva+fkwZaMPVgDQ5s
 tdKRSBWNNuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5RrbEAC6nuwwg50L+LZw27hDN+5qNR4U4jwGL9q6Dg0pxY1loNf3ojd3vqw8UrE51gQPdQpEX12
 WfA2XEoSjxZ4qvwU8Q6CcvMXM03QGeRuDkYZpRy9ynry6jx1e+5+0/dMIzzd/IybXsRQnrADoDX
 9IbM243vhrMwoUUmlL9Er/+VM2764zELP3e2fsym3lXGOwGKyYt1ddmv6Jm0i8CKqVxlTwbRtRN
 XHF1MQATkyWwnhHFXMH5o22Y/y0sLCqFxyyd8YGYykG6j53OvvIB/tBF9XGo9rVZiDDFMnrKywB
 xYf8TBdBU7xEJeccI/nMyNgDrcWHK1XaZF/6aWPUY4cXYVz2z4n8vtpXxwE3aKPlk2i68EfaxNY
 pD4u3r0XF5f6kYpdCHAVUl1GDoFpU7oOFmM16ViX05+wx2udhBdD0uqEK/iLraVQy+iuVBcrU/2
 6SVVPRbdDmX9EOGuRqIdGP2eNyLjzHI4X57LHB8DNb++KjAI8hA8CN1mPl5htrWFnsv1q28iAGD
 B57bJXSc8kvN+JcDRH3Xgb+Srkn987dEYWP4jooaqLQ5t0S5DLUOIhIHNxatH0I4fpvkkQ5XlKz
 EH23S0CKio0QEk0+6+PzJAXwycG8iNqut9ReKKDcJfFnCsJ4HA8zFBejrP0oD/J9fpl34Q+YmIG
 GuvJIamUvPR7qPA==
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

The next patches are going to remove usage of the driver callbacks in
favor of QOM realize/finalize.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio-mixeng-be.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index f906c84bf7c..45873646b3c 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1521,9 +1521,11 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
     audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
 
     be->dev = dev;
-    be->drv_opaque = drv->init(be->dev, errp);
-    if (!be->drv_opaque) {
-        return false;
+    if (drv->init != NULL) {
+        be->drv_opaque = drv->init(be->dev, errp);
+        if (!be->drv_opaque) {
+            return false;
+        }
     }
 
     if (!drv->pcm_ops->get_buffer_in) {
@@ -1664,7 +1666,9 @@ static void audio_mixeng_backend_finalize(Object *obj)
     }
 
     if (s->drv) {
-        s->drv->fini (s->drv_opaque);
+        if (s->drv->fini) {
+            s->drv->fini (s->drv_opaque);
+        }
         s->drv = NULL;
     }
 

-- 
2.53.0


