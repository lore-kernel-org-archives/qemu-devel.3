Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32EFC2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRP2-0004Tr-EV; Thu, 15 May 2025 01:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFROq-000499-Uw
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:44:58 -0400
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFROp-0008JP-4c
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:44:56 -0400
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
 by mailout07.t-online.de (Postfix) with SMTP id 5563313FD;
 Thu, 15 May 2025 07:44:42 +0200 (CEST)
Received: from linpower.localnet ([84.175.230.13]) by fwd73.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uFROZ-1EbUjB0; Thu, 15 May 2025 07:44:39 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 723B42006CE; Thu, 15 May 2025 07:44:29 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 5/7] hw/audio/asc: replace g_malloc0() with g_malloc()
Date: Thu, 15 May 2025 07:44:27 +0200
Message-ID: <20250515054429.7385-5-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
References: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1747287879-EBFFD49F-65FBA01C/0/0 CLEAN NORMAL
X-TOI-MSGID: 1303351f-99cf-48bc-92cf-9f865715ffbb
Received-SPF: pass client-ip=194.25.134.83;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout07.t-online.de
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

There is no need to allocate initialized memory with g_malloc0()
if it's directly followed by a memset() function call. g_malloc()
is sufficient.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 6721c0d9fb..edd42d6d91 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -664,7 +664,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
     s->mixbuf = g_malloc0(s->samples << s->shift);
 
-    s->silentbuf = g_malloc0(s->samples << s->shift);
+    s->silentbuf = g_malloc(s->samples << s->shift);
     memset(s->silentbuf, 0x80, s->samples << s->shift);
 
     /* Add easc registers if required */
-- 
2.43.0


