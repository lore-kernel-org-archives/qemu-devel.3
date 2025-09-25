Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9856CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iYC-00014v-SA; Thu, 25 Sep 2025 05:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iY2-0000xS-TH
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iXc-0001UV-C2
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0e0TFv/CGlxU/vse5VywmrVZx48lnld4r/92cQWi2Vk=;
 b=Kajh+qS8937lygk/AC2aDiOyKdOAq9kPD6baY48tshiRRxVbeBfMu0UlVrW45zxdkTazR+
 1P7qinKxmOkhvx1YGuFVc1aYkMQomeDYTtyoRjabGpbAOE8lfHmLXN521gO6I+6QaLGme+
 5h4XrD/m/u38b+nghme3seUCTkuxS9o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-agWRH4J8NPuSGuIukX37eg-1; Thu,
 25 Sep 2025 05:45:21 -0400
X-MC-Unique: agWRH4J8NPuSGuIukX37eg-1
X-Mimecast-MFC-AGG-ID: agWRH4J8NPuSGuIukX37eg_1758793519
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6723019560B0; Thu, 25 Sep 2025 09:45:19 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C70830002D0; Thu, 25 Sep 2025 09:45:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 05/23] audio: make jackaudio use qemu_thread_set_name
Date: Thu, 25 Sep 2025 10:44:23 +0100
Message-ID: <20250925094441.1651372-6-berrange@redhat.com>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
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


