Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87260D2FED7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknlY-0004uJ-7D; Tue, 27 Jan 2026 13:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknl8-0004dP-MD
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:25:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknl6-00035U-OU
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jke7ivabbc+2yet1zoG3ZgVnhEvUNQkOHIhPsJWfMPU=;
 b=WD5mKWzn7AaBam7XMl2mGPz+Si2abyn6FEn+pkNXrepAZ4PrfE29ikxOYq+ngQ0sDsBqeZ
 SBNq9VjE8UH71kXSQvSGCp6W2fbIZFVGJjNT3wZElUHF54BFyI/6coXNmXyIw9wQ9pgb/r
 la0T8rMIXYDej85tFZBaZfHAM9WgOHs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-WkPFKr2FNy6qgDveHKHefg-1; Tue,
 27 Jan 2026 13:25:46 -0500
X-MC-Unique: WkPFKr2FNy6qgDveHKHefg-1
X-Mimecast-MFC-AGG-ID: WkPFKr2FNy6qgDveHKHefg_1769538345
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A439119775E8; Tue, 27 Jan 2026 18:25:45 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97E4830001A2; Tue, 27 Jan 2026 18:25:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 04/43] audio/noaudio: convert to QOM lifecycle methods
Date: Tue, 27 Jan 2026 22:24:31 +0400
Message-ID: <20260127182516.289834-5-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
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

Remove the legacy driver init/fini callbacks from the null audio backend.

Both no_audio_init() and no_audio_fini() were no-ops that performed
no real initialization or cleanup work.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/noaudio.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/audio/noaudio.c b/audio/noaudio.c
index fe649523e88..fd032ee6e09 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -119,16 +119,6 @@ static void no_enable_in(HWVoiceIn *hw, bool enable)
     }
 }
 
-static void *no_audio_init(Audiodev *dev, Error **errp)
-{
-    return &no_audio_init;
-}
-
-static void no_audio_fini (void *opaque)
-{
-    (void) opaque;
-}
-
 static struct audio_pcm_ops no_pcm_ops = {
     .init_out = no_init_out,
     .fini_out = no_fini_out,
@@ -146,8 +136,6 @@ static struct audio_pcm_ops no_pcm_ops = {
 
 static struct audio_driver no_audio_driver = {
     .name           = "none",
-    .init           = no_audio_init,
-    .fini           = no_audio_fini,
     .pcm_ops        = &no_pcm_ops,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
-- 
2.52.0


