Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67914CCF9EB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 06:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEivp-0006J5-Iu; Fri, 31 Oct 2025 02:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEivU-0005kf-QL
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEivQ-0003oo-Us
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761893270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbzMEnS1rVIl4yt776Y/gOQ9bV5mI+TdAcamExeDZoY=;
 b=Qw/L3HLlL7uv+5FpQ4YSCbHURnOCjdY4Mb4gBrYFTKb3BiJnswC/UBG6/IMLlJETBio2Bk
 BIpQ5xk9LCS/I4lKx2y+R/NCAA7yirGeUTvmwYnMxgXU/o5KEzYUajx/wbXunNp9Yf1ecR
 KRdA/QEh2DWD5JW6U7PYVk3OkdrXCxY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-VPgzFkfzNdW2TtCgSC9tRQ-1; Fri,
 31 Oct 2025 02:47:46 -0400
X-MC-Unique: VPgzFkfzNdW2TtCgSC9tRQ-1
X-Mimecast-MFC-AGG-ID: VPgzFkfzNdW2TtCgSC9tRQ_1761893265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 803DE1955E75; Fri, 31 Oct 2025 06:47:45 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 610B01800594; Fri, 31 Oct 2025 06:47:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 10/36] audio: register backends in /audiodevs container
Date: Fri, 31 Oct 2025 10:46:03 +0400
Message-ID: <20251031064631.134651-11-marcandre.lureau@redhat.com>
In-Reply-To: <20251031064631.134651-1-marcandre.lureau@redhat.com>
References: <20251031064631.134651-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

QOM tree now has /audiodevs objects.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/audio.c | 8 ++++++++
 qom/object.c  | 1 +
 2 files changed, 9 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index e1696403ae..c291fd3e65 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1676,6 +1676,11 @@ static void audio_state_finalize(Object *obj)
     }
 }
 
+static Object *get_audiodevs_root(void)
+{
+    return object_get_container("audiodevs");
+}
+
 void audio_cleanup(void)
 {
     default_audio_state = NULL;
@@ -1742,6 +1747,9 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
     struct audio_driver *driver;
 
     s = AUDIO_STATE(object_new(TYPE_AUDIO_STATE));
+    if (!object_property_try_add_child(get_audiodevs_root(), dev->id, OBJECT(s), errp)) {
+        goto out;
+    }
 
     if (!atexit_registered) {
         atexit(audio_cleanup);
diff --git a/qom/object.c b/qom/object.c
index 1856bb36c7..4f32c1aba7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1730,6 +1730,7 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
 }
 
 static const char *const root_containers[] = {
+    "audiodevs",
     "chardevs",
     "objects",
     "backend"
-- 
2.51.1


