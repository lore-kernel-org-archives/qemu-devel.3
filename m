Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F73C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wd1-0004Mk-Gg; Mon, 07 Sep 2026 06:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wcp-0004He-GB
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wck-0003U8-JT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788777049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDUE6tneSgV6eLV0qeAwfXxHb2vn2lZXhtGkB+PXW4s=;
 b=CztmnQtbggGwA29b+ZnLtidaZE/4p7PMRNV+g2s+LTy+JCg6tj2zI5E7Y86Oj/uwW50Nmr
 vz5FH73RGgQ608oBfe3FWC3vEbDI7p8Wep6YWBjjYv6oOb1xDdl36E55d9i9KZh5KBF5x3
 PiONWshUOGx/z6eUtIP/UjWXNM2/7VM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-IpGVfhZHMjiN0aPIA3J5Ng-1; Mon,
 07 Sep 2026 06:30:48 -0400
X-MC-Unique: IpGVfhZHMjiN0aPIA3J5Ng-1
X-Mimecast-MFC-AGG-ID: IpGVfhZHMjiN0aPIA3J5Ng_1788777046
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30B13182FA58; Mon,  7 Sep 2026 10:30:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD3A91800577; Mon,  7 Sep 2026 10:30:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:30:22 +0400
Subject: [PATCH v2 04/10] tests/functional: replace HMP with QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v2-4-6d952d972c21@redhat.com>
References: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
In-Reply-To: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2641;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ybEHp6F+6UCg68al4Q+VKzGS1f+RFM3TNtuFiSCoNe8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpJCrdHfUIe/6+1WP7VhMEElFVYRyZoESvhx1
 uTPvJFVVdiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6SQgAKCRDa6OEJdZac
 5Rw7D/4nmS1qVpkb+GM3VJz1gyJ7tgT+ItNFu8fyciHQOLUPIiLEXtGQMU49Lgt72ShXsMBNSml
 so+pZGHuep+pafrkgp0kzWf1519KYkM3c7FARJgWQHY2Q1pQ7P94l10ECdVXK2kmvSMbo1uYFk2
 LVqVQimc5biDW3GGY0WzT59xV5LcdlCCuQlXLlVcfr9afUM29bIkCX9aQbkZUd5mrFoD6Li5O7d
 0S+SrCPoaFIcli0jzSbZpeytATt5oBcx/AMRonaLM5YGWo1OJad5X/2DxTBtE71aZRo8e21X5Py
 Bd7JTxnaDaIxicDS940TLfTzHJR7SnTvBBTehRXZX9OnJmJQBykbLlzNf6xVtfJ9jVr75XtMXW7
 PrOQeUyQ1NlMWxAuCQ9GbFIjwzJBATlFhuQ3UbJ0R7u3fRubnzY9aQqMMOmKFFbFH/UFpBsaOOt
 PUb/yNb7rTn1eRM22ugrOPlEVrT3ldnN6IqkElTQFO04OOyqjM/XQaxxEs9GM2G8Cy7r8DuosGX
 1ECKGYy4LAfGhkRXO1iOqedW4OjiKarIpkuzrubfLtx1YlowqqtkhDOKbMyymRkUe1ZISHhQJ29
 xTxoUxK8yUmujRqiCFbjY/juOPDtOKYoS+qfQ8+Ytm8xxWy7sAAEBn8+hGZ/1uR/xEkMJ/waGQx
 0Ahk+P+45j54EvQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

Replace HMP with QMP equivalent.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/arm/test_integratorcp.py | 5 ++---
 tests/functional/m68k/test_nextcube.py    | 3 +--
 tests/functional/mips64el/test_malta.py   | 5 ++---
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tests/functional/arm/test_integratorcp.py b/tests/functional/arm/test_integratorcp.py
index f7551ff7cb88..576c0670bd72 100755
--- a/tests/functional/arm/test_integratorcp.py
+++ b/tests/functional/arm/test_integratorcp.py
@@ -73,9 +73,8 @@ def test_framebuffer_tux_logo(self):
         self.boot_integratorcp()
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         wait_for_console_pattern(self, framebuffer_ready)
-        self.vm.cmd('human-monitor-command', command_line='stop')
-        self.vm.cmd('human-monitor-command',
-                    command_line='screendump %s' % screendump_path)
+        self.vm.cmd('stop')
+        self.vm.cmd('screendump', filename=screendump_path)
 
         cpu_count = 1
         match_threshold = 0.92
diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index f38f294bad67..82e157882e0a 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -40,8 +40,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
                 break
             time.sleep(0.1)
 
-        self.vm.cmd('human-monitor-command',
-                    command_line=f"screendump {screenshot_path}")
+        self.vm.cmd('screendump', filename=screenshot_path)
 
     @skipIfMissingImports("PIL")
     def test_bootrom_framebuffer_size(self):
diff --git a/tests/functional/mips64el/test_malta.py b/tests/functional/mips64el/test_malta.py
index 80fe3424b234..ca001e6fb704 100755
--- a/tests/functional/mips64el/test_malta.py
+++ b/tests/functional/mips64el/test_malta.py
@@ -156,9 +156,8 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         self.vm.launch()
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         self.wait_for_console_pattern(framebuffer_ready)
-        self.vm.cmd('human-monitor-command', command_line='stop')
-        self.vm.cmd('human-monitor-command',
-                    command_line=f'screendump {screendump_path}')
+        self.vm.cmd('stop')
+        self.vm.cmd('screendump', filename=screendump_path)
 
         match_threshold = 0.95
         screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)

-- 
2.55.0.543.g5ebe2ebe4ea8


