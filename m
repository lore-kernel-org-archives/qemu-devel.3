Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D559CE7BDA1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwbx-0006Cf-64; Mon, 16 Feb 2026 06:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwau-0005LK-D0
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwar-0007TU-Gx
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSrNsTt5OhqaSvFjhdYJ82+X+igQQqTBVU38kRxeX2E=;
 b=TaHhxT2yIXNtfwfuFbvyFxXSkCsDiDXj2l7PFMa6ULzGpWrS1Z4xITE09uoeUt8LPB6bIp
 nVrsXZtM9jcheXg4+z/hd07tLDQuwQuEZcjgl03e/4y0GZ4CQX1HJXIyecHY5k9QoBaH5z
 ztqlHdpJc9Kx0LzUaTKiDo/REVHCXJs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-qR0lGbmUOqGSUCG5Sssfsg-1; Mon,
 16 Feb 2026 06:16:38 -0500
X-MC-Unique: qR0lGbmUOqGSUCG5Sssfsg-1
X-Mimecast-MFC-AGG-ID: qR0lGbmUOqGSUCG5Sssfsg_1771240596
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C90F719560B5; Mon, 16 Feb 2026 11:16:36 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2ADE319560A2; Mon, 16 Feb 2026 11:16:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:10 +0100
Subject: [PATCH 21/85] audio: use DEFINE_TYPES
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-21-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gobKDZoHJjzI4b+tyY2wIHYANsreP/cSqFXEdfYSp4E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPZqvwAOE+WQ9+SJAqFDFfOT8hkiMO3JjaX
 4PujVC/lgSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5ebuEACgEihyglGztshdETaDeHaVuIg0qhtzOQ2Gb/d3zR5O7YVfWNpEYCRgVwujPVC9ydlPoZw
 4Xcy6a0xtD0X+g2TVOeem8+5LCzY0OEd5WDiG9TXP/9/yNP6DsUx4syQwtlLfrnX/l1h//41MNI
 fc/QSCUNJ0zUlDWcBlamU9HTKJ0BjxA9Y5Was+PUf7m3JcpNrah0X5ZM/Bp7MmX1NfeaAsnIxSV
 VDRbi5jv4QNQtTMpCMSBlIShk0BFfffzjtwuiDztRr+w838OumegW06wi6RHZNyYvLKPkhrN4Df
 4B+44Y2tF6e381bd3fj3Ux4fGlxjgpWX0XLgUF3uXz+axp0/zSO7sqpVmMWz3r+PwgWQStIrjUF
 t/u9yHtYVazCWBVkMLqw5svh/k4Z682qxevtjeIvPl0wQB2UHE6KfB2qLit6ulNZxdD9kAJNxK1
 hI0F0IURBIAk1Mdd6ywAs6sxbP/wygB9kUJfwoxAJNdAoLEO2/k9Ar7U0cBHz5ge8heKSxPj1sn
 9LMTpfK7MrlI5DvXbt9LYyAR172RpRbD6hWPjP6phcJnxKyyUryYyfEGoadtcyztIB1I0KDF5LX
 Ge8tvKri0Ut+eOH49sHszAk0bmc38H2DI7ZI/E3jTUJRvN6ehGSekvlWTDHAxa+757ZefS7UAZd
 XUuz8S27Y+wjOmQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

It's the "modern" way of registring the object TypeInfo.

Suggested-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 75a7f694319..c4e4adec106 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2366,30 +2366,25 @@ AudiodevList *qmp_query_audiodevs(Error **errp)
     return ret;
 }
 
-static const TypeInfo audio_be_info = {
-    .name = TYPE_AUDIO_BACKEND,
-    .parent = TYPE_OBJECT,
-    .instance_size = sizeof(AudioBackend),
-    .instance_init = audio_be_init,
-    .instance_finalize = audio_be_finalize,
-    .abstract = true,
-    .class_size = sizeof(AudioBackendClass),
-};
-
-static const TypeInfo audio_mixeng_backend_info = {
-    .name = TYPE_AUDIO_MIXENG_BACKEND,
-    .parent = TYPE_AUDIO_BACKEND,
-    .instance_size = sizeof(AudioMixengBackend),
-    .instance_init = audio_mixeng_backend_init,
-    .instance_finalize = audio_mixeng_backend_finalize,
-    .class_size = sizeof(AudioMixengBackendClass),
-    .class_init = audio_mixeng_backend_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_BACKEND,
+        .parent = TYPE_OBJECT,
+        .instance_size = sizeof(AudioBackend),
+        .instance_init = audio_be_init,
+        .instance_finalize = audio_be_finalize,
+        .abstract = true,
+        .class_size = sizeof(AudioBackendClass),
+    },
+    {
+        .name = TYPE_AUDIO_MIXENG_BACKEND,
+        .parent = TYPE_AUDIO_BACKEND,
+        .instance_size = sizeof(AudioMixengBackend),
+        .instance_init = audio_mixeng_backend_init,
+        .instance_finalize = audio_mixeng_backend_finalize,
+        .class_size = sizeof(AudioMixengBackendClass),
+        .class_init = audio_mixeng_backend_class_init,
+    }
 };
 
-static void register_types(void)
-{
-    type_register_static(&audio_be_info);
-    type_register_static(&audio_mixeng_backend_info);
-}
-
-type_init(register_types);
+DEFINE_TYPES(audio_types)

-- 
2.53.0


