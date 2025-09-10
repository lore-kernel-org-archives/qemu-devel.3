Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA54DCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 18:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPBI-0007vW-Ec; Wed, 10 Sep 2025 14:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBH-0007v6-Io
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBF-0004hb-TB
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8U4JGpe8oY8jn8vL5TXbHGmcWR602uNhf/50IZVuU5g=;
 b=CW85m0q/YYdVTc0MbpZCvhjXYlTXq2EX6qc2JWx7cisO41x0SQHv5evHXjOeUYVouVs9ru
 MNWVnNNtzXZORO/Nk+shDT4sq7uTX5G2DlaqAk4VF+X8fzw/F2X8dKNH+ed+6eRE9FWyfK
 eQhucVukiwbjjs2hYDYqSfbGtXYcYIA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-pMmHt2xrNfCqzWzFaLYr2Q-1; Wed,
 10 Sep 2025 14:04:25 -0400
X-MC-Unique: pMmHt2xrNfCqzWzFaLYr2Q-1
X-Mimecast-MFC-AGG-ID: pMmHt2xrNfCqzWzFaLYr2Q_1757527464
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78B84195608B; Wed, 10 Sep 2025 18:04:24 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D78981800447; Wed, 10 Sep 2025 18:04:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 05/20] audio: make jackaudio use qemu_thread_set_name
Date: Wed, 10 Sep 2025 19:03:42 +0100
Message-ID: <20250910180357.320297-6-berrange@redhat.com>
In-Reply-To: <20250910180357.320297-1-berrange@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This has greater portability than directly call pthread_setname_np,
which is only 1 out of 3 possible functions for pthreads that can
set the name.

The new API requires a trampoline function, since it can only set
the name of the current thread.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 audio/jackaudio.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 974a3caad3..69dce3f302 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -629,18 +629,36 @@ static void qjack_enable_in(HWVoiceIn *hw, bool enable)
     ji->c.enabled = enable;
 }
 
-#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
+#if !defined(WIN32)
+struct QJackThreadData {
+    void *(*function)(void *);
+    void *arg;
+};
+
+static void *qjack_thread_trampoline(void *targ)
+{
+    struct QJackThreadData *data = targ;
+    void *(*function)(void *) = data->function;
+    void *arg = data->arg;
+
+    g_free(data);
+    qemu_thread_set_name("jack-client");
+
+    return function(arg);
+}
+
 static int qjack_thread_creator(jack_native_thread_t *thread,
     const pthread_attr_t *attr, void *(*function)(void *), void *arg)
 {
-    int ret = pthread_create(thread, attr, function, arg);
+    struct QJackThreadData *data = g_new0(struct QJackThreadData, 1);
+    data->function = function;
+    data->arg = arg;
+    int ret = pthread_create(thread, attr, qjack_thread_trampoline, data);
     if (ret != 0) {
+        g_free(data);
         return ret;
     }
 
-    /* set the name of the thread */
-    pthread_setname_np(*thread, "jack-client");
-
     return ret;
 }
 #endif
@@ -696,7 +714,7 @@ static void register_audio_jack(void)
 {
     qemu_mutex_init(&qjack_shutdown_lock);
     audio_driver_register(&jack_driver);
-#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
+#if !defined(WIN32)
     jack_set_thread_creator(qjack_thread_creator);
 #endif
     jack_set_error_function(qjack_error);
-- 
2.50.1


