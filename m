Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6FBCDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrWG-0004lV-TK; Thu, 25 Jun 2026 17:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWE-0004Re-26
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWB-0003rG-6w
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yL+I36xW04SZCDuWgJ8/65gYMn8EW7W4lUAZmnKKp8I=;
 b=ff1fTtJqAEbyEdYp8TUXSR29pn0bMQS2g3ZruGZoVqxMkGM1Obj4WKMIZumhULRBxFjqS2
 Pfe5T+KMuIoZgzWP5U9hU4j1bz+OnMk3fJeQPYMr0qBwhJ5Pk3wz/jgICjNmih1n4J2L8R
 gAMkJARrC8W0OnAM4AYHThraztnBqgU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-1GdDI-3pOyOLnCddXxmHnA-1; Thu,
 25 Jun 2026 17:21:44 -0400
X-MC-Unique: 1GdDI-3pOyOLnCddXxmHnA-1
X-Mimecast-MFC-AGG-ID: 1GdDI-3pOyOLnCddXxmHnA_1782422504
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04FE61955EA4; Thu, 25 Jun 2026 21:21:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD0603000B52; Thu, 25 Jun 2026 21:21:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:25 +0400
Subject: [PATCH v2 24/39] RFC: qtest/ide-test: convert to use qtest qemu-io
 command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-24-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yC8UAV22PJD6GzaLylZtpEyM7zqkarcz0LMdqtxpHvc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdvCbxMr5CZM3fmn27TLtJ3fgEw/ZOZkmLr
 JlHScNgsaOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5SNnD/9EDX7ZmwsqHVn+4BhBHLlkUkck2pxJvlrv8J1Ii8GnIzX3a+WlsLrrOTo9SulVn+W55yA
 Wa3PDtV7kQVILf6XIO2PbTwCROreqKgTCOpXkPYG8pfpGq5EsVxJ3c1pkZHVLoZRYc9hbhFidsM
 PTR/KMJ/UpDl3RayNhbJlHDg5NUZSztkddPiBk0S25pBQeTZFV8xkTX370TOtc8M6AGy/SMz1aU
 i96WYQYmfgo+Z5FlPaH5Ig4ZLk3WoT79ZaLyDk5DkRKYouZ7wVzJqn2OqTSh7VUhJX2tzQKEtxn
 mUX2gTnWwt8rZzJdl+hVqbsTP2J9S7xcN1HGY7Jxg6a/i9GTZu5jADk8WpJNvxpBgbxkroLAIe1
 F1kAfFougoFFwN0V5SY8U9Y549EFZiow7iEKPB/RsH9MCXwPV1InFLMSRK81ZMBNHM8OhApBz0R
 JpWCgL5h7k/KmJ/X/iWWjm7FEw3EzSLzLXsoaDybR7yWHukjE9EoeUtyqf4u9FW5D6TsQ4QEdNq
 waMQmQNlWbrIeAS3RLGb+KgJ1XkCQ+rWuz4SUVL5eKSC5zYL4FYbUrbBJJ9oi+F6QmlocwzAFM2
 eJdKYMlwc5l/Qs+Ywu4uIB5XD0PBXnpR6WK/+26J9EAtPC7hRUQsZQ49AlwEiCRxAnlu15d2VCX
 yG7LHIu5iR94u7w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Depend on the previous commit to be accepted.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/ide-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 721e78170bc..3a00c5ff8eb 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -832,7 +832,7 @@ static void test_flush(void)
     make_dirty(qts, 0);
 
     /* Delay the completion of the flush request until we explicitly do it */
-    g_free(qtest_hmp(qts, "qemu-io ide0-hd0 \"break flush_to_os A\""));
+    qtest_qemu_io(qts, "ide0-hd0", "break flush_to_os A");
 
     /* FLUSH CACHE command on device 0*/
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -844,7 +844,7 @@ static void test_flush(void)
     assert_bit_clear(data, DF | ERR | DRQ);
 
     /* Complete the command */
-    g_free(qtest_hmp(qts, "qemu-io ide0-hd0 \"resume A\""));
+    qtest_qemu_io(qts, "ide0-hd0", "resume A");
 
     /* Check registers */
     data = qpci_io_readb(dev, ide_bar, reg_device);

-- 
2.54.0


