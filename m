Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DD6CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOtd-00023D-96; Mon, 27 Oct 2025 11:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOtX-0001wW-Ml
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOtU-0003jj-TY
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761577942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXHP6OdQkB89vcCyTKcDf3Nxv8JeBOGNotvi4AlxWwE=;
 b=In5b6yyfAVV+Ft/8G1Jq5f2yfaFjHNtNYgSYloN4rfEwA+ovPJ05owxTll8sKqOew/Tfpc
 zLs1uIKhwzyx4DcFbs8pmIFfoxlF99WrG1nPHNq0AT43vVLuvrBPn2wzp4Fm6obBfmBKad
 F1mIY/0vJCc2y1aZQWhemMNT/EUfZMk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-Ncs5Km9fM8q6DtFBlj3cgw-1; Mon,
 27 Oct 2025 11:12:18 -0400
X-MC-Unique: Ncs5Km9fM8q6DtFBlj3cgw-1
X-Mimecast-MFC-AGG-ID: Ncs5Km9fM8q6DtFBlj3cgw_1761577934
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6E3619560B6; Mon, 27 Oct 2025 15:12:14 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54823180057C; Mon, 27 Oct 2025 15:12:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 12/35] audio/paaudio: remove needless return value
Date: Mon, 27 Oct 2025 19:10:19 +0400
Message-ID: <20251027151045.2863176-13-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/paaudio.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index f3193b08c3..93030f3fc8 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -747,14 +747,13 @@ static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
     pa_threaded_mainloop_unlock(c->mainloop);
 }
 
-static int qpa_validate_per_direction_opts(Audiodev *dev,
-                                           AudiodevPaPerDirectionOptions *pdo)
+static void qpa_validate_per_direction_opts(Audiodev *dev,
+                                            AudiodevPaPerDirectionOptions *pdo)
 {
     if (!pdo->has_latency) {
         pdo->has_latency = true;
         pdo->latency = 46440;
     }
-    return 1;
 }
 
 /* common */
@@ -844,12 +843,8 @@ static void *qpa_audio_init(Audiodev *dev, Error **errp)
         }
     }
 
-    if (!qpa_validate_per_direction_opts(dev, popts->in)) {
-        return NULL;
-    }
-    if (!qpa_validate_per_direction_opts(dev, popts->out)) {
-        return NULL;
-    }
+    qpa_validate_per_direction_opts(dev, popts->in);
+    qpa_validate_per_direction_opts(dev, popts->out);
 
     g = g_new0(paaudio, 1);
     server = popts->server;
-- 
2.51.0


