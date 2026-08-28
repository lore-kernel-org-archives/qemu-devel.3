Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38D8C61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvL4-0006zz-Hj; Fri, 28 Aug 2026 08:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKr-0006rN-8G
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKp-0002Vd-46
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dNDsi19uSMqZ/URD75nwYzMxR4epzRc43ly98B7fa4Y=;
 b=iyyYwh1HZy8Sai3SiiaKPNr0VTYREnIc/080crDwmWRapnkKjQv+n8xZdAqb635AmpUiug
 pt5u2rW0boFcqIq61Kt3Z89v8VBbBWSCAt7Au4sbpernWUiG+LJN/qkwAR6axCXhyz71qE
 N29r+nfER9/vbmi7ZQOXDnTMIJi5f9k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-Qniu8sgKOOWnEjk99f4RnQ-1; Fri,
 28 Aug 2026 08:05:22 -0400
X-MC-Unique: Qniu8sgKOOWnEjk99f4RnQ-1
X-Mimecast-MFC-AGG-ID: Qniu8sgKOOWnEjk99f4RnQ_1787918721
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77497195DE59; Fri, 28 Aug 2026 12:05:21 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A1763000223; Fri, 28 Aug 2026 12:05:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:08 +0400
Subject: [PATCH v5 11/50] python, tests: switch usernet queries from HMP to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-11-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3538;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Mz1VqGcs9ZOnNKVgcaYcYMuoqaYjOpuJqv21wLJIvfk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk4UnSS/ldlspB5/WCc0Cue51Ue2nH7X1uwE
 vB1tQ3U2xGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5TUGD/4jBKwiYZ5YiJQYkbkUCcECU0UnrsKIYzaIlfUX95sq/vfNS4ypGjkrVBEokYms+v1Nf7U
 7TV0Ax/9Uz5aWyDz2tLwMvtko16Bc3B1M9rEkgaBsBpB9ZmV2YsGTvSc3PW8MkEFFtzLoM68e8Z
 7UoEI5rk04CRZiWDwGxAcR4AAk/SXA9LMYrlo4+N/gGDYygm6AEOCYu0wr89+xMPHAdw96jOGOV
 P+iui87qtmRevXrTFiA8jLsMSKQEexAYYphQy7DaCpaXywc/H2iRwmtbNnQnzhGK358fX5avV24
 VgLhPxrLaoJHhRVLsR5SeulQIQ7T+wMB6WXYP8nxHhkJz835mjX//CoxCFOGYj9JBxhbrPAriMU
 1qvwK+D71ubr5d/+FHJXphvzeyxi5OIdAsrtebMibyvjPmkaGYxoH7azUSiNKS1L/ufuzflDJS/
 yXksPWNriX41dpvZOnaKWCFzXw3EfwRJCogKpzHJm5sBGgthDNscb8+JRIBptjV3/Rya2lUcBjj
 J8/0Y9YRwmwh1HgWmmDKcmvtywvHIk4avdSWmtiSFe39p7YOOL85X/DVS/ipOKAb8qGiCtit6nL
 PQ+RzsWLiw0T0cIWzmQtpqfzqnCm9SZYTYBTbAoIX/LH8Lb5Uww9j2LWjm0h6eNXaX5na1WeuN8
 BDqzBv7QnGkzn9Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
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


