Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A4CEA4FC1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWMo-0000W5-E3; Mon, 23 Feb 2026 08:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWKj-00065J-RC
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWKi-0007YH-DT
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlvSqwSi5p6HvV5NUZQ1P6/nC//iuZk8I7I3m6Rju4Y=;
 b=e6R3uu5FzzcXx4FPQ/v91HEbXi41JLf5MjHEyAr5j0g75y63CTo4mzL55zA6m68nVn63EM
 6FG2nsg7MNFJO7iuRUY9/mnLrRaS0MVf36AW13qurdzl/p9N6eAdII4pWDiUB3flEIjvu2
 bGxk9JYSe7/gE0E7vIPp1pMU/HWuGcE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-Gfhr-RFbOPqTPV167CCcSg-1; Mon,
 23 Feb 2026 08:50:40 -0500
X-MC-Unique: Gfhr-RFbOPqTPV167CCcSg-1
X-Mimecast-MFC-AGG-ID: Gfhr-RFbOPqTPV167CCcSg_1771854639
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6689D18002E6; Mon, 23 Feb 2026 13:50:39 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 706C319560A3; Mon, 23 Feb 2026 13:50:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 67/85] audio/pw: replace custom logging with error_report
Date: Mon, 23 Feb 2026 14:47:08 +0100
Message-ID: <20260223134731.2377432-68-marcandre.lureau@redhat.com>
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

Replace the custom audio logging infrastructure (dolog macro) with
standard QEMU error reporting (error_report).

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


