Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE903D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknrJ-0000t5-Rp; Tue, 27 Jan 2026 13:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknoi-00027f-5f
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknob-0003hN-U5
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltuilmzt4PZngVQxLolrP0mSSfGQKTLY8px/kEQ1sRQ=;
 b=RHceb/qnB8EFWoGefAGXHa5NQplT0GMAnTtzdPJh8urMzHoUpdrBOMcAIsUJlfLzF55ENl
 ElNK0Cif+a/amQZBGP7bIQ6XaPJWrwTK0CDbcXUWB1wiqeQJVEoVznni0vp9hLAOtp5V4C
 lVGpxjJq6ZMhcGM3ZKeEe7E5Tns6lD0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-bJxM5jCgMCSMvHnPpJ_OLQ-1; Tue,
 27 Jan 2026 13:29:19 -0500
X-MC-Unique: bJxM5jCgMCSMvHnPpJ_OLQ-1
X-Mimecast-MFC-AGG-ID: bJxM5jCgMCSMvHnPpJ_OLQ_1769538559
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCC4B1891055; Tue, 27 Jan 2026 18:29:10 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D46F195419A; Tue, 27 Jan 2026 18:29:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 38/43] tests/audio: add an invalid settings test
Date: Tue, 27 Jan 2026 22:25:05 +0400
Message-ID: <20260127182516.289834-39-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

As we are going to change the related code next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/audio/test-audio.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
index 98e77cf542b..4590e2f7259 100644
--- a/tests/audio/test-audio.c
+++ b/tests/audio/test-audio.c
@@ -519,6 +519,26 @@ static void test_audio_multiple_voices(void)
     audio_be_close_out(be, out1);
 }
 
+static const struct audsettings invalid_test_settings = {
+    .nchannels = 0,
+    .freq = SAMPLE_RATE,
+    .fmt = AUDIO_FORMAT_S16,
+    .big_endian = false,
+};
+
+static void test_audio_invalid_settings(void)
+{
+    AudioBackend *be = get_test_audio_backend();
+    void *voice;
+
+    voice = audio_be_open_out(be, NULL, "invalid", NULL,
+                              dummy_audio_callback, &invalid_test_settings);
+    g_assert_null(voice);
+    voice = audio_be_open_in(be, NULL, "invalid", NULL,
+                             dummy_audio_callback, &invalid_test_settings);
+    g_assert_null(voice);
+}
+
 int main(int argc, char **argv)
 {
     GOptionContext *context;
@@ -573,6 +593,7 @@ int main(int argc, char **argv)
 
     g_test_add_func("/audio/null-handling", test_audio_null_handling);
     g_test_add_func("/audio/multiple-voices", test_audio_multiple_voices);
+    g_test_add_func("/audio/invalid-settings", test_audio_invalid_settings);
 
     ret = g_test_run();
 
-- 
2.52.0


