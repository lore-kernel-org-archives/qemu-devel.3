Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004BFFCD0DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mUn-0004ac-DB; Wed, 18 Mar 2026 04:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2mUl-0004aI-Up
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2mUk-0001lM-9R
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773823391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+u+72PzefeocEnO0i26IhhCU5l0zrYcEEZxNJKvQsy4=;
 b=Dyr+8cN8vpaPohN62iOayvhUY7rsF8t86xrmxnnrckClCSMnl8mh3WutnfNER64ypKf5tq
 gAu5HiUrsIn9fJH384wsUm0Vz5MoGTW9cP26wljPCle49aY/Lw0+VMKUTz9s6q2bEfF/lZ
 DiwB4X+zmyDQNFcia6x/mshVrH6AjF8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-8mW3GrZdPV-l4H_CYg1RFw-1; Wed,
 18 Mar 2026 04:43:10 -0400
X-MC-Unique: 8mW3GrZdPV-l4H_CYg1RFw-1
X-Mimecast-MFC-AGG-ID: 8mW3GrZdPV-l4H_CYg1RFw_1773823389
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A48818005B6; Wed, 18 Mar 2026 08:43:09 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD9AB19539A0; Wed, 18 Mar 2026 08:43:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: dmitry.osipenko@collabora.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] audio/mixeng: fix sw/hw mixup in audio_pcm_sw_init_
Date: Wed, 18 Mar 2026 12:43:01 +0400
Message-ID: <20260318084301.653383-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Commit 42061a14358 ("audio/mixeng: replace redundant pcm_info fields
with AudioFormat") accidentally changed the conv/clip function selection
in audio_pcm_sw_init_ to use hw->info.af (the hardware voice format)
instead of sw->info.af (the software voice format). This causes audio
distortion when the software and hardware voices use different formats,
as the wrong conversion functions are applied to the audio data.

Fix by using sw->info.af, restoring the original behavior.

Fixes: 42061a14358c ("audio/mixeng: replace redundant pcm_info fields with AudioFormat")
Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 228369cf9a1..f0b2458996a 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -172,7 +172,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
     sw->empty = true;
 #endif
 
-    if (audio_format_is_float(hw->info.af)) {
+    if (audio_format_is_float(sw->info.af)) {
 #ifdef DAC
         sw->conv = mixeng_conv_float[sw->info.nchannels == 2]
             [sw->info.swap_endianness];
@@ -187,9 +187,9 @@ static int glue (audio_pcm_sw_init_, TYPE) (
         sw->clip = mixeng_clip
 #endif
             [sw->info.nchannels == 2]
-            [audio_format_is_signed(hw->info.af)]
+            [audio_format_is_signed(sw->info.af)]
             [sw->info.swap_endianness]
-            [audio_format_to_index(hw->info.af)];
+            [audio_format_to_index(sw->info.af)];
     }
 
     sw->name = g_strdup (name);
-- 
2.53.0


