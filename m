Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431E9C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywYo-0006ZX-F0; Tue, 25 Aug 2026 15:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYe-0005x0-PS
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYc-0004DL-Nz
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PoiWTQyc+6CT3+XQBefK1rDjJHIoQVwAvU80roRsDk=;
 b=JVKq9lmLJXhfLq9Qc++N9W5LEgzmrDrWlaCTQ8M4gdeYsya3kqjo0EZzFXRwme3tfPThlr
 6MN94yOZKndeBhfJW9wzVUrNSMctv+hufzGJBtXbqxcCPO6e86Uy8aTPVPs5mhC4W4ietC
 iE8u1sgibf4fC1n2FQtlVskSFmqxYn8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-_LcSR8OLO2iDTV6ZDWpg9Q-1; Tue,
 25 Aug 2026 15:11:34 -0400
X-MC-Unique: _LcSR8OLO2iDTV6ZDWpg9Q-1
X-Mimecast-MFC-AGG-ID: _LcSR8OLO2iDTV6ZDWpg9Q_1787685093
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E995818512F0; Tue, 25 Aug 2026 19:11:32 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2768818005B4; Tue, 25 Aug 2026 19:11:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:31 +0400
Subject: [PATCH v4 24/49] tests/qemu-iotests: add qmp_qemu_io()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-24-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2ie2jIETQhyqbbYcjhhut4gVUdDiVPF4PD6eQdFtxIU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHU2p75Cc9aY+/y/1UVEVOI47Berx7H0ikK
 7Lfq0e1AnOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5d45D/0YeeSXxH3UWOaBLplLO2lqxDLrdGdT9vnDvwq9pYtJtcOKWH+jUPTCIk3etZhCBh+yUJV
 qfCezHRBnhtvmfJEd+BJrWVoULQ5wgdwpM3cz9DP7m6OeqEH4LuVRvBglMxSJV8ItuHQ3PiPYkx
 eja1hBcKyXAAZQKx00N1FrMAm8jPlvS7T29ZA9+OlTO0A4GpjuAycS3QCgHUP72g6AZQ8mJjmH9
 gHoNCCCNsYBCp/wAl9osOr2mm4F6T2hSzr/415tvXF+KVV2+TGSshjdb6gq8pOsNIf8PXuuclmc
 6aR/S8Zon6aj4jwUfHwa39gez7z6R92Os+G6NCpjFLadRv9vG9Wa4sM9YIk76MtpRgSvbp7VdJR
 iGmR+Mo/5sYOfZ8ZWerivW9MjHkyl3uMDwYmzq4Lli0jD3fh8QodzIELON3Jg1x4BNhk44W1z0C
 I+wu1xm+T2B+YqRejvrIuwhb3BLb73UVuhdnJ9mv8iwQ20OyTYgOLT4+qmskv5hxgIHgYLSFKhY
 ZG4Wu/WoIiXmW3GyhDMaEk1gAIjOBVdO0DbXy4Mxe4H1yqDTpldJjnN7ljF3fXjZ5lmZwt17aE7
 E8iYk056TEDSB6KquU9aV1sP33XcL1VTeFRZq/13lJ4m02dyRzwBj5X8bNDUsPNSyniCxBS1TP+
 peVk5Z4fIv24a+Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add qmp_qemu_io() method as a QMP counterpart to hmp_qemu_io(),
using the x-qemu-io QMP command instead of human-monitor-command.
The x-qemu-io command takes separate 'device' (or 'qdev') and
'command' arguments, and returns the error string.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/iotests.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 072be80e0792..c24f1e3767c4 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -953,6 +953,20 @@ def hmp_qemu_io(self, drive: str, cmd: str,
         d = '-d ' if qdev else ''
         return self.hmp(f'qemu-io {d}{drive} "{cmd}"', use_log=use_log)
 
+    def qmp_qemu_io(self, drive: str, cmd: str,
+                    use_log: bool = False, qdev: bool = False) -> str:
+        """Write to a given drive using the x-qemu-io QMP command"""
+        kwargs: Dict[str, Any] = {'command': cmd}
+        if qdev:
+            kwargs['qdev'] = drive
+        else:
+            kwargs['device'] = drive
+        if use_log:
+            res = self.qmp_log('x-qemu-io', **kwargs)
+        else:
+            res = self.qmp('x-qemu-io', **kwargs)
+        return res.get('error', {}).get('desc', '')
+
     def flatten_qmp_object(self, obj, output=None, basestr=''):
         if output is None:
             output = {}

-- 
2.55.0.543.g5ebe2ebe4ea8


