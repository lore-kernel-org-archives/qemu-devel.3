Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAD9E7BD98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfX-0007qA-5k; Mon, 16 Feb 2026 06:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbR-0005es-Od
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbM-0007mP-D5
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CUR/Qh5VElhqx+dlU/QcjMGK/JC9E2Y0q1Y0TBtw86Y=;
 b=d4W4humeI9SuUSWybLncMVdk6qzyNQq3mKwhkg9l7ZFtZ8im+e5hFbcFBc3l+e3Qy4+ZSd
 Dq/gGE/QMXluV9glswqZwJ8fM560cEaxvQqJyY7Ck3qRWolsczGb0+EnfQH6QvN12sabQn
 dvjWJKcx6DPdMHMNOiRklvfJuyAA9JU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-uGj9T4LKMwi9cs5ywmLsHQ-1; Mon,
 16 Feb 2026 06:17:06 -0500
X-MC-Unique: uGj9T4LKMwi9cs5ywmLsHQ-1
X-Mimecast-MFC-AGG-ID: uGj9T4LKMwi9cs5ywmLsHQ_1771240624
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 449DF1956089; Mon, 16 Feb 2026 11:17:04 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B03AF1800465; Mon, 16 Feb 2026 11:17:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:20 +0100
Subject: [PATCH 31/85] audio: make list type declaration private
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-31-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2kDmF9W/174LJH9v2mKEvg3l3Ghu44HGzScFDsS19Gc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPSMqURui8yqz3+MKm/SEJaOPnYEIPspCu/
 fXnPJhg/4CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5Q95D/0VVVL5Nho7x/iz0ldbhnuWVTaVp8dakdsqCwoL9/Ni1R7AVnLIa5MpBElnP1Hh1SVzMaI
 +wDiaC/CLNvJthC2n3rwEeX0JJQ9k8hjdzcCUZTf50wt0hIY7WsxOw4RbckdjZKWHa1xVDHhABY
 jw4tUp7flSzuLFNGHsd3DT0e6dBJPH3OdFEV1wfKpUXX8Qi1AyA012bPg6aiztD8JI/D0r8B48o
 sZpsAfUPmvwSXTo+auJDOaVHuv++ThH4HYjt15OxXcNgyRCmBS6OahGkVRpMJWRd5RlQgVBKFgk
 L7HuS++fkEekJkZzMldZOm/x3d6giFimEew0mOl7wBKy8M+M6mbjbWkkdEZ8vnvtdoSVMQxQ621
 1xfpM4FKnDCenaEmfjU6Yw28SNiy/s6F2HrjxSIjPjWvvjF2OoJLYBXeKD2dJs0Gh6SQsjd24Dn
 fdl7Li940Hb4Wm02zep4Ay4bfsatqhgJbNDAA+eZmoqkvyJtjCuMyaUoPNZ6nEXkX0wz1TJNrmi
 u8lpMTuhsOMXSCzF+GQRPIK1OxnDWoxWS5r9HbtYhizVh2aJAXADdMARUzet93roo4tcST3XAbF
 zlTok08dxH7J1cyEVeoLp1fzRlmzaxIwy4IhX0Fn7cWeM9SOGozvvTuAslYKOwbZXV+qsDQCZJ6
 gvJ9QQvAHMEkcfg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

No need to share in a common header.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_int.h | 7 -------
 audio/audio.c     | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 446ba1d52c6..08d07b17557 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -306,13 +306,6 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
 #define ldebug(fmt, ...) (void)0
 #endif
 
-typedef struct AudiodevListEntry {
-    Audiodev *dev;
-    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
-} AudiodevListEntry;
-
-typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
-
 void audio_create_pdos(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
diff --git a/audio/audio.c b/audio/audio.c
index 16edc57e5f0..d8a54548274 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -68,6 +68,13 @@ const char *audio_prio_list[] = {
     NULL
 };
 
+typedef struct AudiodevListEntry {
+    Audiodev *dev;
+    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
+} AudiodevListEntry;
+
+typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
+
 static AudiodevListHead audiodevs =
     QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
 static AudiodevListHead default_audiodevs =

-- 
2.53.0


