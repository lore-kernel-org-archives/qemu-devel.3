Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D55FE7BD98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwdX-0000L0-Dj; Mon, 16 Feb 2026 06:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbe-0005ok-Kx
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbd-00084X-2a
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAPlRNPKdeWquLi18FJ2oBHPOgXeFeTuRgnXP8s7MNw=;
 b=DsgVnK8wzxB+3CQNSjKbHNHHb30z9FVOkgIm4t23dCQQLIHS/EPnYZGRpX6sBEKlJGLeYO
 l8/1pMfFMxl+fbfc1nvyUNR8bQcSyPdCOlD+1q5bwgBV3IcazYiqSIsv3sKCXSctgNtrAf
 SfbXYZsTn98eg1jxxhh3BBt0rOEUHiM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-cd9xv65uOfOsBhC4iBoU3g-1; Mon,
 16 Feb 2026 06:17:29 -0500
X-MC-Unique: cd9xv65uOfOsBhC4iBoU3g-1
X-Mimecast-MFC-AGG-ID: cd9xv65uOfOsBhC4iBoU3g_1771240647
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22C141800454; Mon, 16 Feb 2026 11:17:27 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D47530001A5; Mon, 16 Feb 2026 11:17:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:28 +0100
Subject: [PATCH 39/85] audio-be: add some state trace for debugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-39-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kMAYRkuXfPx/cZR8FpZgmCzTRG5cT4t64cUDglhy7GI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQixfbluWJqT7ahwdfeB1Q28ST2iQZa5i/8
 na0PnKQsTuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5eJWEACLsK+PAoy7lMvERRTwLTizbY1kaUHb0+0vZJtbIeLdK5tgiAwkedV20WdImXC5RDxZxKM
 7BYTcjQQZWMCWagBaERbfdS/K8sucAIQ+Es0g375snfHgpaJDujrP/u8WpidG6x0uhpA8lmByUU
 ZVVVc8U0AzbF8wcZQ1OizVge7F5MIGULxtp7R0X/7Dtg7VP9Q167MiHv3r3pGVBWVg11Uo/J7qb
 vY6ijHcBySCTC10ZO8CxG+piCXKhDHR6u1pbiZy971YeazNyrCpEjN/4VWZ7nhIK1jdt9CZ5vMs
 9Xiy3P956JKOBPCxBC5/9yIVyxF37V3rC4K2vEr7+/G0ogEnfms0IeRFL8AAFt4c0SOyAUrVEpT
 MWUVdiIPp5qRczRWWPizhiMTuE0C85YpxS5dOaj0okkoh1YVaLMJElPMmxurOFka4djJ0jylapT
 FBF4q2bRUoymSVvtfoNCKgSPOIHIOqXlyHSuFyhzdwH9BZvbd31s6NcI9kkrFHdyfiel6Mi9gGO
 zEREegwgG2D1TvcbVHC4umG31k/s1k4k2k16iKeWRvR96CfHKvJohogqe8SGuKIniP35Eovtyhe
 NtQIVoc/KpcmYapa1QiwFdHnSTkUTAUl6Lzpl8L7Q7dIZkt4jRrI02X1SRq7Z5Bf0+IjsDAm5O3
 8MVZO3MYwN5b3Cw==
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio-be.c   | 5 +++++
 audio/trace-events | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/audio/audio-be.c b/audio/audio-be.c
index 719dd8cac12..3203bb80e05 100644
--- a/audio/audio-be.c
+++ b/audio/audio-be.c
@@ -4,6 +4,7 @@
 #include "qemu/audio.h"
 #include "qemu/audio-capture.h"
 #include "qapi/error.h"
+#include "trace.h"
 
 bool audio_be_check(AudioBackend **be, Error **errp)
 {
@@ -134,6 +135,8 @@ void audio_be_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    trace_audio_be_set_active_out(sw, on);
+
     if (!sw) {
         return;
     }
@@ -145,6 +148,8 @@ void audio_be_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    trace_audio_be_set_active_in(sw, on);
+
     if (!sw) {
         return;
     }
diff --git a/audio/trace-events b/audio/trace-events
index 7e3f1593c81..f7f639d9605 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -26,6 +26,10 @@ pw_vol(const char *ret) "set volume: %s"
 pw_period(uint64_t quantum, uint32_t rate) "period =%" PRIu64 "/%u"
 pw_audio_init(void) "Initialize PipeWire context"
 
+# audio-be.c
+audio_be_set_active_in(void *sw, bool on) "sw=%p, on=%d"
+audio_be_set_active_out(void *sw, bool on) "sw=%p, on=%d"
+
 # audio.c
 audio_timer_start(int interval) "interval %d ms"
 audio_timer_stop(void) ""

-- 
2.53.0


