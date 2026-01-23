Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84C3D72348
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjC0o-0000mk-FZ; Fri, 23 Jan 2026 02:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBz3-00073S-7x
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBz1-0002QS-6Z
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o55U45Qy1eR49Cq+xJu+xKVp9Z7lHu8cz29O/9w6cpI=;
 b=ZfnfjiVPe+4UV2lJ45xUhr2hIyNtHFidrTGzZFeHO+iXuf3chA/kFlq5lhSNh6qCG+5OxN
 VbqEYWW9yzpWNkfk7UTY6ycJL4VpUm7RxQ1TpWeDr9GOwrYJOdvRBSOjGwYid6NbsgV3Ym
 WnoEvak9VabzIilCKmaw3uK0emZBM64=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-sBp48W_-O3aFtCMU7emB6g-1; Fri,
 23 Jan 2026 02:53:28 -0500
X-MC-Unique: sBp48W_-O3aFtCMU7emB6g-1
X-Mimecast-MFC-AGG-ID: sBp48W_-O3aFtCMU7emB6g_1769154807
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 530A21956089; Fri, 23 Jan 2026 07:53:27 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6CDC30002D1; Fri, 23 Jan 2026 07:53:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 35/37] audio-be: add some state trace for debugging
Date: Fri, 23 Jan 2026 11:49:38 +0400
Message-ID: <20260123074945.2563196-36-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio-be.c   | 5 +++++
 audio/trace-events | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/audio/audio-be.c b/audio/audio-be.c
index b3fa8d9c549..23083a75c3a 100644
--- a/audio/audio-be.c
+++ b/audio/audio-be.c
@@ -4,6 +4,7 @@
 #include "qemu/audio.h"
 #include "qemu/audio-capture.h"
 #include "qapi/error.h"
+#include "trace-audio.h"
 
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
2.52.0


