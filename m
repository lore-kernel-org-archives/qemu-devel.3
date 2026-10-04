Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AEBCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQm-0003jy-Q2; Sun, 04 Oct 2026 06:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQc-00039O-93
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQa-0003Rx-Un
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Hn6A4dX2r+x/+fnVi1k0DQU8zAGzmY5iMpyHuge8iQ=;
 b=UJM231/qlkLfiMD4rnqWkapWgO92nCYrcGhjaB4z1pixwz1Et0TmHpvWsVwgrj/LP3oaf7
 yyHegeXyiOsA6jypZxLz/vh0WnjbkfzAZ7p9XRsAMz6WRJCs6nHUdkoAguukiIAY5A1Jlt
 +A41moZoQbPyB7dWbeaTqhfy7WKEHQo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-h1QDIRcyNsujBRyf5OeF0g-1; Sun,
 04 Oct 2026 06:26:40 -0400
X-MC-Unique: h1QDIRcyNsujBRyf5OeF0g-1
X-Mimecast-MFC-AGG-ID: h1QDIRcyNsujBRyf5OeF0g_1791109599
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B669E1843AC3; Sun,  4 Oct 2026 10:26:39 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B64B01956089; Sun,  4 Oct 2026 10:26:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:05 +0400
Subject: [PATCH 51/63] hw/input/adb-kbd: validate WRITEREG request buffer
 length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-51-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OYo7okvFLYY7siOsc3L8FrAsFCrxX+Pzgq5TmlNFDGE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwiklrnO+1XebUFlEpO3jk5OHPTylvLqhv2DQK
 s8JzUGrXjqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5VAPD/wOQcATCsef540HtaX0M+GUEsHLb84sezgWwF17+Rt3O/pbJOqqRjUxEHk4tzPQCOV9lHt
 LJJb05VVtTr5v36A5PIGBZvuZNqaOlJvhP6jv5AitMUMNnD/gwlCn+RlZoG9wYLoiwQbehGpFcs
 v8wb8zmuUGo0+Ye/e5PpZDDn2OWG67+Yg9bNB9RbCYPnbRwQ8uLpwks813jU5bespSZZ+omEMDD
 8x3uYA0aAll4TAHMhU9NAWwqkqlalbcqDdVg15IkRoIOL6YfTNWNrqRX+M3rj6qRW65IZGm9WXb
 nNrYHGlRRYRSOMQAUZQB0Mdyit0QYVwh2z5wnFx3+L0SJULGSRnsmRUpz7TJgK0ewVcr8FrRlbn
 aYJm6JPRPQ/2E2pI4KFwjiCmdoCBvJhTafquQaQhCefzv1D2ed99yUtvLzFZTJU2mVDcW41fWXX
 Dd4drI0NIoWRDBJtwt6qPMBbtVmlu8uhee3DV2/OetBQQbSI9I04tQzuvNx1EE5TszltSthWObi
 zxZwLNFchXWRwm9fJhz6QYuNctpDl9GwLS4ldRAoFqbIYOlvhwURAzcsg5k4n7m2FhHirOg2geQ
 mBMfEd3xOyKyq/lsVtPKtGATLIMv5JY7CoQ3LSkdtkvFMU9rY+tQ6z2YbCw5RCTmBowNw5pSfDN
 Ab4TDNHV23yw+Iw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The ADB_WRITEREG handler accesses buf[1] and buf[2] without
checking that enough data was provided, allowing out-of-bounds
reads from a short request buffer.

Add length checks before each access: require at least 2 bytes
before reading buf[1], and exactly 3 bytes for register 3 commands
that read buf[2].

Fixes: 77cb0f5aafc8 ("Split adb.c into adb.c, adb-mouse.c and adb-kbd.c")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/adb-kbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index ece51d5df72b..9d80a3849b77 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -241,12 +241,18 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
     olen = 0;
     switch (cmd) {
     case ADB_WRITEREG:
+        if (len < 2) {
+            return 0;
+        }
         trace_adb_device_kbd_writereg(reg, buf[1]);
         switch (reg) {
         case 2:
             /* LED status */
             break;
         case 3:
+            if (len != 3) {
+                return 0;
+            }
             switch (buf[2]) {
             case ADB_CMD_SELF_TEST:
                 break;

-- 
2.56.0.rc0.29.g47ce80527c56


