Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B432C5DF70
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgIg-0008Q7-TY; Sun, 16 Aug 2026 15:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIb-0008PW-Fl
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIZ-0007N0-Au
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQ3k0bOKS5GQKJg6KQ1y4RmKrPluHHk47PS3dTfcuK0=;
 b=Ju48hxyiuKFy4fBbX1Z47gTp3Tk39Bk/sVQq37fotc75VcyQRgnqPXNe+rGDQwvcbyUz6G
 eypDjToG6UPFUF/Aqlj0u3bpo1AwzpChQ8syfbTAeLgsBYJyscxtcmUQawwEV0fy6S/u4I
 PvUbvWoBQiSf8oy89WMZalkPWWFYbGc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-XA3-cFr2OjaXlfYezbIFUw-1; Sun,
 16 Aug 2026 15:13:31 -0400
X-MC-Unique: XA3-cFr2OjaXlfYezbIFUw-1
X-Mimecast-MFC-AGG-ID: XA3-cFr2OjaXlfYezbIFUw_1786907610
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9901C1800471; Sun, 16 Aug 2026 19:13:30 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3891195608A; Sun, 16 Aug 2026 19:13:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:36 +0400
Subject: [PATCH v3 09/49] tests/functional: use query-version QMP command
 instead of HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-9-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=E12bnf1BnZYcd0xThQbrRXQW65sQtsWdYsKbNPUWaYA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguwSy2zHKpRBjLGI1wyFExGyKY4WbVVpXVEy
 MyLFbkcU3WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsAAKCRDa6OEJdZac
 5UanD/99stKWn8ev0/PxOkHsHV+5zDOyIpWg9nz5HI7IWZPJTXBy4xzD9kyJWCjAZVPy5EQDI88
 ejiUGKFD/1JxR2qEPGaotKy/5a4ROMlk4bazCN+qHdZSJLSvonuT6uhVL75tMrmgUrpnE6KFNzT
 qhAeHANRo2QHvnJ/aNj1U/JJBoWxYvUwuPW5dcX/j0IuCF8eYbJnMVaSQU+VKBCbU6htLE/XNZy
 xYRNtpGcC9/BwdL6wzJW2moHUa1OeXJcUqPssXZC+HNRfVMtS4V0MbrMVL5rKd/x7zP18Mi/u4Y
 EouEQvx3iF8qmE6Guo3qtTbsW0P9gfupXamfV4ZSnH3mQwPgre7nczTuY18/fDwzVM6DyHPuXM0
 OQ3a8KeB+C0QwkbZ4fIiEuH4szVvoGlShgh1GKVBGfsqwUy9MPRJx3m6j5b49p9RIsIw/z14OFr
 W4jvyGjvn/KdB2T0MXNmJsmlSQp8/T+NdduffMdh2+OH3N+z8Up2LJpAsUNmTyEHV96Tjf6+FWP
 FMyrsZZC82txnSWbcbVpdRXjt4C0LtJCLOElOt3nbdz+eJwGKzyWf7C3SFJWxRO9msKnQVjxhl1
 9cD9BYGGSAJmGXahWFHfoVuSk7MsSlggA6HNJvgWZdBSfRb1SrAHCJrVnDX2Z3nlsDVTeC05fgR
 aQx8rvSq6dPmc2w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
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

Replace the human-monitor-command based version test with the native
QMP query-version command, which returns structured version data.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/generic/test_version.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/functional/generic/test_version.py b/tests/functional/generic/test_version.py
index 3ab3b67f7e39..7764424826e0 100755
--- a/tests/functional/generic/test_version.py
+++ b/tests/functional/generic/test_version.py
@@ -16,13 +16,15 @@
 
 class Version(QemuSystemTest):
 
-    def test_qmp_human_info_version(self):
+    def test_qmp_query_version(self):
         self.set_machine('none')
         self.vm.add_args('-nodefaults')
         self.vm.launch()
-        res = self.vm.cmd('human-monitor-command',
-                          command_line='info version')
-        self.assertRegex(res, r'^(\d+\.\d+\.\d)')
+        res = self.vm.cmd('query-version')
+        version = res['qemu']
+        self.assertIsInstance(version['major'], int)
+        self.assertIsInstance(version['minor'], int)
+        self.assertIsInstance(version['micro'], int)
 
 if __name__ == '__main__':
     QemuSystemTest.main()

-- 
2.55.0.543.g5ebe2ebe4ea8


