Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43681D2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknow-0002Sr-4K; Tue, 27 Jan 2026 13:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknnI-0008AT-5v
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknnF-0003KX-BA
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kb0XUX8Hbw1CeUAvB+XxD3OCphYLf6Qpo+MzOpEtu6c=;
 b=YZslk9ZJgPsx/UI5qyENFFQQ2qXft1a805OgpVynmxe6rI1LtofDPvp89C/d7cEMBCffQ4
 K7oAcGO6GxxyREoOgOSK7J2duZJ37i3lub2j2+9DK+sc70CqbNwYQRmE2AWeJdPn9aMOMW
 I7U8b/SBi1aLqMgmBm1/fjwlTODCQEY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-uHd0GKlmPEe_vP8CexXLpA-1; Tue,
 27 Jan 2026 13:27:56 -0500
X-MC-Unique: uHd0GKlmPEe_vP8CexXLpA-1
X-Mimecast-MFC-AGG-ID: uHd0GKlmPEe_vP8CexXLpA_1769538475
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE9E11955F2C; Tue, 27 Jan 2026 18:27:55 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E79319560B4; Tue, 27 Jan 2026 18:27:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 26/43] audio/pw: replace custom logging with error_report
Date: Tue, 27 Jan 2026 22:24:53 +0400
Message-ID: <20260127182516.289834-27-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Replace the custom audio logging infrastructure (dolog macro) with
standard QEMU error reporting (error_report).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/pwaudio.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 39b2b8f0a0d..c30738c16ef 100644
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
2.52.0


