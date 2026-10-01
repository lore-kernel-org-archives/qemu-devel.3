Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD8CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCISz-0000yZ-2P; Thu, 01 Oct 2026 11:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISr-0000wO-AX
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISp-0000wM-Df
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790867570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0i6smfKv0q/tf+MIdUzBldzbG/E/DdqFQkiGj4iPrg=;
 b=AhedplQY/5zLpxSnvkXfHViGB+/NuxUhDbIVJWj5Fkg7xiDjRAXfYP5Soi7Ppk7hkt6E0C
 rlD5G2z2uMWPwi4sr86oyVuTtgjY4OBKnLS4Oe7uVzRJnQvJuSD1eYuXe9TDwAZ7KSatVP
 pGu+Ac5k41swB/0reWmoYoyOojJ6268=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-t0mof2CGM1OHnLAmwUs9IA-1; Thu,
 01 Oct 2026 11:12:49 -0400
X-MC-Unique: t0mof2CGM1OHnLAmwUs9IA-1
X-Mimecast-MFC-AGG-ID: t0mof2CGM1OHnLAmwUs9IA_1790867568
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 975501954232
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 15:12:48 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A626D1956042; Thu,  1 Oct 2026 15:12:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 14/20] audio: remove mistaken use of trace_event_get_state()
Date: Thu,  1 Oct 2026 16:12:22 +0100
Message-ID: <20261001151228.3373747-15-berrange@redhat.com>
In-Reply-To: <20261001151228.3373747-1-berrange@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Conditional checks must call trace_event_get_state_dynamic()
which checks the state of all backends, while trace_event_get_state()
only validates state for backends using QEMU's internal state
tracking.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 audio/audio-mixeng-be.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index f7d73d85608..60a4007817c 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1179,7 +1179,7 @@ void audio_run(AudioMixengBackend *s, const char *msg)
     audio_run_in(s);
     audio_run_capture(s);
 
-    if (trace_event_get_state(TRACE_AUDIO_RUN_POLL)) {
+    if (trace_event_get_state_backends(TRACE_AUDIO_RUN_POLL)) {
         /* Convert seconds to microseconds for trace event */
         int64_t elapsed_us = g_timer_elapsed(s->run_timer, NULL) * MICROSECONDS_PER_SECOND;
         trace_audio_run_poll(msg, elapsed_us);
-- 
2.55.0


