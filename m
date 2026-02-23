Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6825FEA4FC1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 14:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWPC-0006Ly-F2; Mon, 23 Feb 2026 08:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWLE-0006L3-Po
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:51:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWLD-0007fD-Az
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zz+Yiw3j6EwnZi+bj/J+8lAYZ4FYD5FVjkb0Yf+zwSY=;
 b=QUyRrVKYzs1OcE5goQoelHSxUtciNh4fnqDlknfy+y8wVW9nuX3ftz2T1Xu/H5zXlTbvWd
 Buy3L6Ac7R8jTTKJqgNVr4+DSL3Fjf+YPlfptzwFCgVgbl9rrfONebUKVPZdvjEcI0Ndvq
 F/zwYZ3FinVej0qzoZVnHAQgSb+Nbpw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-N1OdZH-DOr2M6S6iMjNwxQ-1; Mon,
 23 Feb 2026 08:51:12 -0500
X-MC-Unique: N1OdZH-DOr2M6S6iMjNwxQ-1
X-Mimecast-MFC-AGG-ID: N1OdZH-DOr2M6S6iMjNwxQ_1771854671
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C34DB1956075; Mon, 23 Feb 2026 13:51:11 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 193021955F22; Mon, 23 Feb 2026 13:51:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 79/85] tests/audio: add an invalid settings test
Date: Mon, 23 Feb 2026 14:47:20 +0100
Message-ID: <20260223134731.2377432-80-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

As we are going to change the related code next.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


