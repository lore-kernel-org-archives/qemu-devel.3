Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD88EC2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRPW-0005hU-SD; Thu, 15 May 2025 01:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFRPQ-0005CI-AD
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:45:32 -0400
Received: from mailout11.t-online.de ([194.25.134.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFRPO-00006Q-IQ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:45:31 -0400
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
 by mailout11.t-online.de (Postfix) with SMTP id 78147EA1;
 Thu, 15 May 2025 07:44:35 +0200 (CEST)
Received: from linpower.localnet ([84.175.230.13]) by fwd87.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uFROS-2ukuDh0; Thu, 15 May 2025 07:44:32 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 68B1220063D; Thu, 15 May 2025 07:44:29 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 2/7] audio: fix SIGSEGV in AUD_get_buffer_size_out()
Date: Thu, 15 May 2025 07:44:24 +0200
Message-ID: <20250515054429.7385-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
References: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1747287872-88FF7520-79457593/0/0 CLEAN NORMAL
X-TOI-MSGID: 4607cb52-6af9-4dad-a815-701b9a1a0469
Received-SPF: pass client-ip=194.25.134.85;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout11.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As far as the emulated audio devices are concerned the pointer
returned by AUD_open_out() is an opaque handle. This includes
the NULL pointer. In this case, AUD_get_buffer_size_out() should
return a sensible buffer size instead of triggering a segmentation
fault. All other public AUD_*_out() and audio_*_out() functions
handle this case.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 audio/audio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index 41ee11aaad..70ef22b1a4 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -905,6 +905,10 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
 
 int AUD_get_buffer_size_out(SWVoiceOut *sw)
 {
+    if (!sw) {
+        return 0;
+    }
+
     return sw->hw->samples * sw->hw->info.bytes_per_frame;
 }
 
-- 
2.43.0


