Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BA7CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSo0-0003mm-Mb; Wed, 22 Oct 2025 02:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSnt-0003Rl-J1
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSnr-0008Gl-Dx
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXHP6OdQkB89vcCyTKcDf3Nxv8JeBOGNotvi4AlxWwE=;
 b=CbFcEH9ZHfG8n7/9ltMR35PIfJKtoA8JXBlGyE4QrGjRkRkKtwCwwoJGhBQh4BOQQ1G+L7
 RhZTQEycxJ8CTDRP8VCbCBPI0BYSKi3J6ALjFa3usFxyv27WJ5Z0RnTvjYqr2FkhmB+cPE
 ZF7DOIHtF2MMOqAKFqcNanTFS38uOc8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-EBOVEEruMG-RPoiLb1P8jQ-1; Wed,
 22 Oct 2025 02:58:31 -0400
X-MC-Unique: EBOVEEruMG-RPoiLb1P8jQ-1
X-Mimecast-MFC-AGG-ID: EBOVEEruMG-RPoiLb1P8jQ_1761116310
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FD18195608F; Wed, 22 Oct 2025 06:58:30 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38059300022B; Wed, 22 Oct 2025 06:58:28 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 19/42] audio/paaudio: remove needless return value
Date: Wed, 22 Oct 2025 10:56:14 +0400
Message-ID: <20251022065640.1172785-20-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
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


