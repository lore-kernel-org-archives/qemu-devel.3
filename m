Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD063CDE010
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrVH-0000IP-LG; Thu, 25 Jun 2026 17:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVC-00006T-54
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVA-0003gg-AO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iaRYlIVDmmEr7mjUP2HQlVLCLl/YXVWkvOhqZcPCbFw=;
 b=RDHdiomkqIDLIGfICA/PCPg+UBy2OhVNHWiZb8VKdxJACrV3yBusJL7t12XeMVjHbXEyOz
 ApH5ddG85Biy67IdWPN3asQTFd1wjtZ2WyuMGXpAJpNryiuDfqUXlBWGuYA09wKScbb4QB
 Uk2dgb2ks1esTK2uGdnggDFJL4BWcIM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-qJ-RuNiqO1CyCK2uZZhzbA-1; Thu,
 25 Jun 2026 17:20:44 -0400
X-MC-Unique: qJ-RuNiqO1CyCK2uZZhzbA-1
X-Mimecast-MFC-AGG-ID: qJ-RuNiqO1CyCK2uZZhzbA_1782422443
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68E681955F73; Thu, 25 Jun 2026 21:20:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33BC23000B52; Thu, 25 Jun 2026 21:20:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:14 +0400
Subject: [PATCH v2 13/39] python, tests: switch usernet queries from HMP to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-qemu-no-hmp-v2-13-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3407;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LoAZSMRv5Ty+H9JbaYaYBeWts8NBrOu4fzEPlV1z6CY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtcdKUFVnp8pcpJWIU+2uQf86R1F+LCPArZe
 Fn5vMQFT2CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5dw8D/9pRB/wBwscvwvSgP6k2GjkiIIlZVYds0b4gN15bQdKdINMQbsX5w72Jc5tlkyJwjU6pBE
 5AHE24lLA6hD3iVyBYMpRye2P76p8P0r7LAeOhXNtxeSqhr9fpeG4VH36uOXA/YpJy29e4nim/Q
 O460vy+371cd67dW7lPfDOxt0Ij9orda8H19GlcPcoJeyyRhBgJMW8eEphYYWZn1fFclwmnAsfD
 pvayrZ3P12q9rN3wTC15A3x6/vkUVjrTpabjxtBEA7Sur9m+6RZwC54ZVyDcfs1ahcbOBRmmKD7
 QAdNh+n+OLQPtMY3X1tqy/OT4uWOfO7/9HMScU+c73HvhKxQsYKiev+f2EsVwcQwSUP+Ph5To0w
 7+XpaOhnMQ/lwyKsphzLhfvGcX+c/mUe6LYInJWSIU0ZlsccVPPfIQIj1rbT1OD8TeeA/+KZAHT
 7GtQVS6POXHrbRMY+Dp6lg19Z5uKhX1pyPhraMn41RtFQsSN3o/9q79rwbTZJ3ASPK4NvBan3s3
 xEwhGBjhLxl25AmSBqUzcoIRWfbdR1wvNK/pBz7g2nwawOjqoRcGtRwy6kS6kRVmrqMs8TZvXKR
 9oVl4Dgv0Qxb1/uNaLNmEp/ZCFlfBkeTgEIZe3gPNjDqSZKyYuVxvnL35ekxRq49yDu25eD1uEE
 EwOP1U677nrFnSw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace human-monitor-command "info usernet" calls with the structured
x-query-usernet QMP command in get_usernet_hostfwd_port() and the VM
test runner boot path.

Since x-query-usernet returns a list of UsernetInfo entries, callers
now iterate over the result and extract the port from each entry's
"info" field. Also switch get_info_usernet_hostfwd_port() from
split('\r\n') to splitlines(), since QMP strings use \n rather than
the HMP monitor's \r\n line endings.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 python/qemu/utils/__init__.py       |  5 +++--
 tests/functional/qemu_test/utils.py |  8 ++++++--
 tests/vm/basevm.py                  | 13 ++++++++-----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/python/qemu/utils/__init__.py b/python/qemu/utils/__init__.py
index be5daa83634..e32911d4c6d 100644
--- a/python/qemu/utils/__init__.py
+++ b/python/qemu/utils/__init__.py
@@ -46,10 +46,11 @@ def get_info_usernet_hostfwd_port(info_usernet_output: str) -> Optional[int]:
     """
     Returns the port given to the hostfwd parameter via info usernet
 
-    :param info_usernet_output: output generated by hmp command "info usernet"
+    :param info_usernet_output: output generated by "info usernet" or
+        the "info" field from x-query-usernet
     :return: the port number allocated by the hostfwd option
     """
-    for line in info_usernet_output.split('\r\n'):
+    for line in info_usernet_output.splitlines():
         regex = r'TCP.HOST_FORWARD.*127\.0\.0\.1\s+(\d+)\s+10\.'
         match = re.search(regex, line)
         if match is not None:
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 826c267785b..0992db49ab2 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -14,8 +14,12 @@
 
 
 def get_usernet_hostfwd_port(vm):
-    res = vm.cmd('human-monitor-command', command_line='info usernet')
-    return get_info_usernet_hostfwd_port(res)
+    res = vm.cmd('x-query-usernet')
+    for entry in res:
+        port = get_info_usernet_hostfwd_port(entry['info'])
+        if port is not None:
+            return port
+    return None
 
 def pow2ceil(x):
     """
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 9e879e966a3..198b04e8c37 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -312,12 +312,15 @@ def boot(self, img, extra_args=[]):
         self._guest = guest
         # Init console so we can start consuming the chars.
         self.console_init()
-        usernet_info = guest.cmd("human-monitor-command",
-                                 command_line="info usernet")
-        self.ssh_port = get_info_usernet_hostfwd_port(usernet_info)
+        res = guest.cmd("x-query-usernet")
+        for entry in res:
+            port = get_info_usernet_hostfwd_port(entry['info'])
+            if port is not None:
+                self.ssh_port = port
+                break
         if not self.ssh_port:
-            raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
-                            usernet_info)
+            raise Exception("Cannot find ssh port from"
+                            " 'x-query-usernet': %s" % res)
 
     def console_init(self, timeout = None):
         if timeout == None:

-- 
2.54.0


