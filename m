Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B9DE7BD94
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwbu-00064x-Pe; Mon, 16 Feb 2026 06:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwab-0005Cb-F4
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaZ-0007PL-TZ
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWwXEZKR8bIUCXjig+DEu3oAcncqyWxdQ+X9NJASFtc=;
 b=WkYCMoh4iqEXHWgdIeQcsFdKRGpRyuK6gtJsz50oXxuB8ofYmn3tUjKwC0uY1IzyMscsRA
 WEukbbqKy84wqU+aplATqmTpfG+d9rv60c2cOLVkoxTCdq882L9dcQWwL5/mKVAGA9E58Q
 jgr7Ie/T4ji+XRV9eNlYECJt8TnO/zE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-487e-6n4ORCq9ZDgnnCNzQ-1; Mon,
 16 Feb 2026 06:16:23 -0500
X-MC-Unique: 487e-6n4ORCq9ZDgnnCNzQ-1
X-Mimecast-MFC-AGG-ID: 487e-6n4ORCq9ZDgnnCNzQ_1771240581
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 260EA1955BC4; Mon, 16 Feb 2026 11:16:21 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3108230001A5; Mon, 16 Feb 2026 11:16:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:04 +0100
Subject: [PATCH 15/85] scripts/modinfo: make --devices optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-15-e676662e4514@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vHmD8YiBcGDbQ2SbYzxegTM9eh7UnvCnb+I1yQPLiVo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxO6L4Tlq/kBFHJX5uKWR5IIa9MbvTbXCTp8
 YJbfdF+jJiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5eAYD/9hk8Az3YibcxpxTj3m7wxkG/kaEZ+TOfc+bFVjBb3PFKgN1u4wUnyiFTr21YhEhuXsv9e
 WtFYquEpEqJQSrXXEuSa8OE8Xew8cW5n0ppukijq9z5Pi5b0tiwJFCiSExH5WPCjdzJxz2LVJd6
 N7HATa80A1Ci+6LQigbuEFKpp2G7sW/ExX71MbAqs2h5bbeBdF9mOPpXUYoRKq8b/0ftQBeTSSG
 40/kslYMgZsfGcygyvKhPZGL5PMpjd88Wwjr8eJ4BoPAnYoGQ0YpifJ1UPMtUS9alQRr8nPeGH9
 PzbcMx1NP4/oWDVnVzlKECHrl4uJnfkr8BLPrc0vVzW52lYxQCnKrEW0PUppVmuH2UH8+fo/65A
 /KqwnRAYhAEmV/uy9ir5rJwiSSEHwfVNDtQzuUcabiLyteZZOiRD08xjRQSjeLDtVuPlzfapfsl
 jF4HdG977t2TRvIupBsv/+NBCrynld5yVSpxbbJoGik2OesVe4dalCEzG0YTJf8qBWDzItQKEdC
 KU9kYgCPUMA98FwDH8n3howQk00ZnlBaez+TDGM2dQi23QCivUb8vDfwRHybllTWTyB2olaXSzT
 fdFDuD/UorxeYJKvNs5qR4IjZKXh3h/jYZwu2wdY+Ywz5whXot8PRkUT5kIFRzsdrOWsLpuMor8
 hC9MNyW+35CXRRg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This will allow to use modinfo-generate in cases where devices aren't
relevant (tests etc)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>w
---
 scripts/modinfo-generate.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index 777d419aa33..e7d35242414 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -84,7 +84,7 @@ def main() -> None:
     parser = argparse.ArgumentParser(
         description='Generate C code for QEMU module info'
     )
-    parser.add_argument('--devices', required=True,
+    parser.add_argument('--devices',
                         help='path to config-device.mak')
     parser.add_argument('modinfo', nargs='+',
                         help='modinfo files to process')
@@ -92,11 +92,12 @@ def main() -> None:
 
     # get all devices enabled in kconfig, from *-config-device.mak
     enabled = set()
-    with open(args.devices) as file:
-        for line in file.readlines():
-            config = line.split('=')
-            if config[1].rstrip() == 'y':
-                enabled.add(config[0][7:])  # remove CONFIG_
+    if args.devices:
+        with open(args.devices) as file:
+            for line in file.readlines():
+                config = line.split('=')
+                if config[1].rstrip() == 'y':
+                    enabled.add(config[0][7:])  # remove CONFIG_
 
     deps = set()
     modules = set()

-- 
2.53.0


