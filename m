Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0FAE7BD98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrweK-0003Mw-81; Mon, 16 Feb 2026 06:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbR-0005eu-PU
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbM-0007pX-Hc
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFl76fF+LZJe4gLSTLwCv0jScavNDWDyMsNrvmMBYlo=;
 b=WFTGT8B6PednQw/+2kKVekQ6GFVni349nYnoX69JrO/uB4X3N/2PyWzMMKkICTbOwBgiRx
 +/U4yQOufkVJ+OxOvrJ3bqSdlxKYRxafpX7F2DihzcjeWgyx9m1Sr+oWNzfMCLDNzSVw/3
 uQ+H/hRdzHLwJyj4XIlmpNbU3vtpojc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-xSmBGvwFON2yAcO6V4PJ5A-1; Mon,
 16 Feb 2026 06:17:08 -0500
X-MC-Unique: xSmBGvwFON2yAcO6V4PJ5A-1
X-Mimecast-MFC-AGG-ID: xSmBGvwFON2yAcO6V4PJ5A_1771240627
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E24CB1955DDF; Mon, 16 Feb 2026 11:17:06 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44C5E30001A5; Mon, 16 Feb 2026 11:17:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:21 +0100
Subject: [PATCH 32/85] audio: make create_pdos() private
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-32-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=18BzEdvVM6Wo1L4EnoV0PhPLC4dtiCH9jACEhFQvbdg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPV8PiDGBHjO+tvxDUJ106QEznKRJTxxFt5
 cEhFV1drwuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5Y2JD/9Tap+sJcU1pGCa9TcegcUnv4Q9P8rlu5iZ4L6xNHDK81NKAQfFc/KiKs+bCv48xwRmdNF
 3sWx41Ch1t0XS+7KPPKwvd3uBCJbU0XvgFSxvqdK3YURfa2HVR7Ov8NCZ02x3qLXQY8/CWEWNoE
 iz7l8OSrujuFznuJULt3LX3BC4U4o7ON/fQPkXNJubNI+n9HaGYF8z/pM/hXrBX2+sjqGhoFCw+
 sV2eek0jlBNI77QbSzFzfxVnSzc0ruShzX5KEZVqWk0noJMr2237XsNtXML7cAZwtjqAAekVXna
 QcV3L3pftPBgoWNo0br9snRQBN8kbW43pkznjcET8pnL6kNHVXwq6zUNkB6IaTjZd9s65CSo5ij
 GrMpRcbDCXGLZ/ci15TU6jaM2TOPwY81kxD93sgAihpEmyhyXc0G9b4gZ4WktpTvftfOUZV3SdC
 LU4+zkTrJUIZsi01icjzCvrtiMfzU9owvc8TSGtgwIoXw2hdrcB763VpyXjIVKC6yK6yVNUH94H
 c051BYdwK29/r0qiMEAFQOtRzXvBKQP9SvSZ1WszM0NUm6Qt1OW6Uv/UXbyuQGz393gA1gAOwzl
 3dnCZemZb9S0h8L8SfvfvknvwfqGSYlhM0rNIJlnXM+TDuu6LgHvMA7DwmFf79jEyE8u68rNCqw
 EFbvjSTZnXYS8EA==
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Clean up.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_int.h | 1 -
 audio/audio.c     | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 08d07b17557..e1f9fa333ba 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -306,7 +306,6 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
 #define ldebug(fmt, ...) (void)0
 #endif
 
-void audio_create_pdos(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
 
diff --git a/audio/audio.c b/audio/audio.c
index d8a54548274..1fa63ee0421 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1990,7 +1990,7 @@ void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol)
     }
 }
 
-void audio_create_pdos(Audiodev *dev)
+static void audio_create_pdos(Audiodev *dev)
 {
     switch (dev->driver) {
 #define CASE(DRIVER, driver, pdo_name)                              \

-- 
2.53.0


