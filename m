Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574EBE7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfn-0001I8-5Q; Mon, 16 Feb 2026 06:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdU-00006Q-Pf
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdT-0008VG-6A
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vhkcofagmtouh19qmptVO0BhTBa1KkRCfho8pOX3WJ4=;
 b=QyoBhVHePr77v46FvJSw7fL7YMwGSpTUUjmG7lBql1Zy/xznK9nBpji/Gv4JvwlwujCZ7B
 o2bSVKzr5c0ZwainE+Fq8bsplpPF7QW/DCU9V2xnQG6vFFY2IbaBwsA+aDfWIpj51Oc4jo
 ZZ11bvnboMClQNM4kncfhoJo200UiPI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-f5jl3WirOrOxa-w2KaN19w-1; Mon,
 16 Feb 2026 06:19:23 -0500
X-MC-Unique: f5jl3WirOrOxa-w2KaN19w-1
X-Mimecast-MFC-AGG-ID: f5jl3WirOrOxa-w2KaN19w_1771240761
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46E961955BF7; Mon, 16 Feb 2026 11:19:21 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A97E19560AD; Mon, 16 Feb 2026 11:19:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:08 +0100
Subject: [PATCH 79/85] tests/audio: add an invalid settings test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-79-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ep6XYOJTTnvtH9h/pjwifpDZkwuSLv1dTtbA4CUxjQ4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxSlVux5GX2MP4GqvIafm6hOtzHkoU0PgFqO
 z4IngKs0h6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UgAKCRDa6OEJdZac
 5bYKEACK0tFObpv+eWOkSGmhRF2Ge+H+Pf/Jcu5cjGTFfMcaFmQWKvG2wxfiaREgdPzfPy9MEKA
 S5i9JfdtK7KWQLBW5jsAGs7jf+rezMkVGxT+Q/Am84CQVW/470vIbfGlYknE4GK4SnbnQKTeKm8
 W5IfkIZIL277f1zcXyiKUb7TZfY0FbNAGPAnkDyPuzinGx7HxHknMWqhOCfURnXBbXPL0JY2yeI
 40ZJrVuPvYmUUNHLQgaTJjmDQpEq1JZ9ql7TnQgz0q45ywwDhetO6gJipBV4kkRPCBu4h0yDFW+
 VxXyYNwxLDw/hA9PNKVgw48NSPLKwYzvsDOYuorgC6163QfRPs/wElLV8P9YqQUOqDwtzXkw1jK
 B731yz2BexvM6VJbpoSTG7wzECGY+fcEoc9F9GzoKK9V9dQZoIz711JMRYUU2bo1hz7rKHDz+fe
 zjFc5hmlvwPC3JP2kK0BCRhKh1l0NUZfFbKZQBGsVwYXWlxokbyFAMVC2WThTNMSIMgRJIbFYPB
 gGxx+q9RxCMgZh3VhnqHSG79yjXtM/6Uk6pBldGYg9SoAnGeQWCqZIFtYAbo5+S+Y7HoDURsf9z
 mJdjrUTgMZ/ntwQiUMwgvgdZLMN2Yb0thsZ13Lw8MdkadrZLJZNZQDr3CxIoJ8sMSHk9eonDcwA
 yeuHpTFqWHd0WfA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As we are going to change the related code next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 tests/audio/test-audio.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
index b87a12eb55b..af8cf03d10e 100644
--- a/tests/audio/test-audio.c
+++ b/tests/audio/test-audio.c
@@ -534,6 +534,26 @@ static void test_audio_multiple_voices(void)
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
@@ -589,6 +609,7 @@ int main(int argc, char **argv)
 
     g_test_add_func("/audio/null-handling", test_audio_null_handling);
     g_test_add_func("/audio/multiple-voices", test_audio_multiple_voices);
+    g_test_add_func("/audio/invalid-settings", test_audio_invalid_settings);
 
     ret = g_test_run();
 

-- 
2.53.0


