Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67A1E7BD9D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfP-0006jY-F4; Mon, 16 Feb 2026 06:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcx-0007NK-KC
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcv-0008P2-5V
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2dXnZAb4GQ3OqunerrTarsSyOPnsFPU054yEOgQ/M0=;
 b=L9Gup3PM5j6v3YBZ3UYi8F54OY6MuOfbxRsCsJ9ACL8U0NqYJbPSyzW9eXwsrKOxvdVLu5
 uGlmdORel91I7HbKXx1iDvm004kHwjyuMjAR+qpIK6+Mo3QLdZlDEock4Km9ABramvCcHj
 8zyLQ64uoMAacyhlw4mc45aUCm9CNOM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-Mwrem7XYPm-sZi5F77Bv5g-1; Mon,
 16 Feb 2026 06:18:48 -0500
X-MC-Unique: Mwrem7XYPm-sZi5F77Bv5g-1
X-Mimecast-MFC-AGG-ID: Mwrem7XYPm-sZi5F77Bv5g_1771240726
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 575A81955D8D; Mon, 16 Feb 2026 11:18:46 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE32130001A5; Mon, 16 Feb 2026 11:18:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:56 +0100
Subject: [PATCH 67/85] audio/pw: replace custom logging with error_report
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-67-e676662e4514@redhat.com>
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
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Thomas Huth <thuth@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9XNiYrTBg8/TjuL3Pf/yXDW/8WV5yurqmx3CbFtxjhs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxRSfLO9lhGAIAH3YGIPwWElH4Mul7Hib5HK
 35X9PJePGqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UQAKCRDa6OEJdZac
 5UVtD/4hBQEGov6kG25Fo3wIZ4XoC+OUUtYUBYbExsdpwvRV9u6PriUD/wbSI6t7vtwZqh3YmsG
 ffVaMEHgjnq4xCRx3Ku5ohAAk7ng4PW9udOkEKoIBd4jFoHZvqTAGLuctUlrrsY/1AoOZHHFl4W
 xe8qhEZIMXLNoDYWA9cQ5LQnmTqsBmhTNgjr+3Iio43g/OyiJiyPxT64QFT0Dnw+O7Lo8m5cuwn
 k028BB6BAPqn06TbU0thagkhsN1BNrlD2gKpAXcVM0N2H1PJK5bUfFkkBpwxdl5dKiBHh6bu5PH
 mbvYSGIQQJ8LoUiGRyhet/kN80enWRypYLN6RiWW/+H5Zf+3hL2vjSccJh/CURs2sR/xfhEWKHw
 mq/WEJe8UKWT4Y0geGK4PKw4er7vqzWCKrSUrj+5bXCq0S6UYQobLXdRcI/izvP9QGop0EHtCsn
 TOEAdvFD7EjSEOq8oVCVFrjok4TIJh6DPFsMEav2WLicZk6TJXaH5Gbidmbj9F5lVStvHEThWqY
 uyPmgS8yzwBo87/sxKjIoA+vIMSt31OZ24sjeoNViXWJQjLKZNnUrlhlw4StayW9BhD2TujDGnc
 QM3RbTmANEUCzMqYBNOe6/0fan+x80MRf+V3BDaWgvbWEja41PmeMFkzK1PteYBjJZ1Ebtfm7oL
 dDYhn8YKVNLFGTA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace the custom audio logging infrastructure (dolog macro) with
standard QEMU error reporting (error_report).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 audio/pwaudio.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 7a009a94f3a..6a80e5a333e 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -20,14 +20,13 @@
 #include <spa/param/props.h>
 
 #include <pipewire/pipewire.h>
+
+#include "audio_int.h"
 #include "trace.h"
 
-#define AUDIO_CAP "pipewire"
 #define RINGBUFFER_SIZE    (1u << 22)
 #define RINGBUFFER_MASK    (RINGBUFFER_SIZE - 1)
 
-#include "audio_int.h"
-
 #define TYPE_AUDIO_PW "audio-pipewire"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioPw, AUDIO_PW)
 
@@ -358,7 +357,7 @@ audfmt_to_pw(AudioFormat fmt, bool big_endian)
         format = big_endian ? SPA_AUDIO_FORMAT_F32_BE : SPA_AUDIO_FORMAT_F32_LE;
         break;
     default:
-        dolog("Internal logic error: Bad audio format %d\n", fmt);
+        error_report("pipewire: internal logic error: bad audio format %d", fmt);
         format = SPA_AUDIO_FORMAT_U8;
         break;
     }
@@ -418,7 +417,7 @@ pw_to_audfmt(enum spa_audio_format fmt, int *endianness,
         return AUDIO_FORMAT_F32;
     default:
         *sample_size = 1;
-        dolog("Internal logic error: Bad spa_audio_format %d\n", fmt);
+        error_report("pipewire: internal logic error: bad spa_audio_format %d", fmt);
         return AUDIO_FORMAT_U8;
     }
 }
@@ -518,7 +517,7 @@ qpw_set_position(uint32_t channels, uint32_t position[SPA_AUDIO_MAX_CHANNELS])
         position[0] = SPA_AUDIO_CHANNEL_MONO;
         break;
     default:
-        dolog("Internal error: unsupported channel count %d\n", channels);
+        error_report("pipewire: unsupported channel count %d", channels);
     }
 }
 

-- 
2.53.0


