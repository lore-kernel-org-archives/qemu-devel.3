Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC944C61DDA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Pg-0006RP-M5; Fri, 28 Aug 2026 16:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pa-0005rn-7p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03PW-0008BT-D1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hDibQ/76bLAuXZOX4GEYOaUl81zkc5tt+tMjQi0FuE=;
 b=HlY7P70bDROwGe6CQE0Hqvr079A0u60IL0ziSQbniw6q3+9dYLyrIa06EIeL/fAJppPIkf
 yUkMtDUYnBi2Zj+2F5d1Az1rjuUlDO2qEZ259SJQy5DLIOz6Xog6Qu8L87tc8Hb+L5bY13
 5/BtI3G/WCoQqYyv6P4j2FMQKnjw4Tc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-5tuNl5uHMqiFyWuRDPWnlA-1; Fri,
 28 Aug 2026 16:42:41 -0400
X-MC-Unique: 5tuNl5uHMqiFyWuRDPWnlA-1
X-Mimecast-MFC-AGG-ID: 5tuNl5uHMqiFyWuRDPWnlA_1787949760
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC24618CC49E; Fri, 28 Aug 2026 20:42:39 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 980E51955F0A; Fri, 28 Aug 2026 20:42:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:50 +0400
Subject: [GIT PULL 11/50] python, tests: switch usernet queries from HMP to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-11-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3604;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ts1ydKczmkeF1pPgicN1uWQ5eabDW6urDzxS2MLEnJ0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUMzsfshXQR4lYG72cCJXRUMBrKeoZj96nX
 pOEXn937MCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5VjpEACpwliy1GUwAMqsAP6UgCD6b/mCPxFy1ahgXZWqdVtZjOw/o4yuYo23h2p8ds3SIxtJddF
 mUGN/qIkZnSxLuGQP8FNacv+CXD695Shl/xNoaYq+KsScGVKAk2ROIKhWMVZnP4+RebhXx+pQGg
 Svgmx5hpByOFNaUD/IGY+dI6nuX6oO1+c8i9zlKvzwDF50QxPGvwRBMzXczEy9d3VeyXC8EWwdy
 Ag19L9EI+eW/uVsYNziPlUXCEPsaH8kgZuzOB9z9FSIJTvAzX0yMLwu3PfyWOdvOAE+u+Ce9FL/
 ROspkE6P696+BRLuy3AiUCvEp7CH+tGnKVfpc5nFBRckawT84HHxCIO9wbne0bw1++23qX8YqJk
 M98zCdyP5d/pulUePFziTTOUMSKGMSeqoZy3D3fLrrMPSBI5lgusV8nxuABdUV1TnpblD+GqEW2
 Kq8nTqfJ1Ws80JO3gMZl3u9jMdoTtPgbShFD0TVDkrVwhv425MB+VcLe9y4jL9wGxwog34HZZdc
 cC5yUkisEcA61OLuYgAh+50EtJ4XkkrqwNJ6kU07vHKl10sdt1hCKTqd8OUEZr0t8uzNIs+HxQu
 GVSDfIsBIwkCmvOhL1Qvwl0hr/xFx1EpLS+xoKUHXWDbl7qbL7fgwV2fgXyVNyxhL2aYIhhecbx
 AMfttI+CUSYCzdg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Replace human-monitor-command "info usernet" calls with the structured
x-query-usernet QMP command in get_usernet_hostfwd_port() and the VM
test runner boot path.

Since x-query-usernet returns a list of UsernetInfo entries, callers
now iterate over the result and extract the port from each entry's
"info" field. Also switch get_info_usernet_hostfwd_port() from
split('\r\n') to splitlines(), since QMP strings use \n rather than
the HMP monitor's \r\n line endings.

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-11-9227de146347@redhat.com>
---
 python/qemu/utils/__init__.py       |  5 +++--
 tests/functional/qemu_test/utils.py |  8 ++++++--
 tests/vm/basevm.py                  | 13 ++++++++-----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/python/qemu/utils/__init__.py b/python/qemu/utils/__init__.py
index be5daa836340..e32911d4c6df 100644
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
index 826c267785bd..0992db49ab28 100644
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
index 9e879e966a36..198b04e8c375 100644
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
2.55.0.543.g5ebe2ebe4ea8


