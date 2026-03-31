Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E327AFF60F7
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Vmk-0000Uk-JK; Tue, 31 Mar 2026 05:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vmi-0000UV-SA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vmh-00084R-ET
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774950798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvHT6BwsoBPWDujNFtkt+Bu13w+qxfZDiiZxPnQYDZM=;
 b=DIj7xP7LP3gmpatHObS4gi3o/EMETUgV45dVfHxt9B/9D1SiAQFQPZKfdU3yxNNcjBMmMd
 eMlUe+aQGVFZ2W+GpgHYbBTxoIeKWN2/Hvq7TOg9oy2fl42M3zFgBIHWWME71+H+6cWe7b
 62cdb7AudN90w2vG+np+tEtw/ggtDkw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-ZOGNzu5sOvyywyQXzHwr-A-1; Tue,
 31 Mar 2026 05:53:14 -0400
X-MC-Unique: ZOGNzu5sOvyywyQXzHwr-A-1
X-Mimecast-MFC-AGG-ID: ZOGNzu5sOvyywyQXzHwr-A_1774950794
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D058119560B4; Tue, 31 Mar 2026 09:53:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 866EA180075B; Tue, 31 Mar 2026 09:53:11 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 1/6] audio/mixeng: fix sw/hw mixup in audio_pcm_sw_init_
Date: Tue, 31 Mar 2026 13:52:57 +0400
Message-ID: <20260331095302.644608-2-marcandre.lureau@redhat.com>
In-Reply-To: <20260331095302.644608-1-marcandre.lureau@redhat.com>
References: <20260331095302.644608-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index fe769cde667..398a7273739 100644
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


