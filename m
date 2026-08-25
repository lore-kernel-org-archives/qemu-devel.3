Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1947C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywXn-0004QN-61; Tue, 25 Aug 2026 15:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXl-0004QC-2f
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXj-0003vt-IG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQ3k0bOKS5GQKJg6KQ1y4RmKrPluHHk47PS3dTfcuK0=;
 b=fjqF7DwGubnOQ1gTFpAeYIvZJx/nNcVpuV2QIizMcoK5CeghnedfUkaBQ+eFOovKBLc5uC
 oTZbJx+88oHXSg4XGSDseMRJwbHqx+nKIZvuKKPKvO0Fq1Tt/umfbF9nBG4uMq65QyxC/S
 BmGnVEhefXzpHg6yK+QBAeh8+4ABX00=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-5g3dn_McPTqZkE-Z8jFjGA-1; Tue,
 25 Aug 2026 15:10:39 -0400
X-MC-Unique: 5g3dn_McPTqZkE-Z8jFjGA-1
X-Mimecast-MFC-AGG-ID: 5g3dn_McPTqZkE-Z8jFjGA_1787685038
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94F5319792E1; Tue, 25 Aug 2026 19:10:38 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65F841955F0C; Tue, 25 Aug 2026 19:10:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:16 +0400
Subject: [PATCH v4 09/49] tests/functional: use query-version QMP command
 instead of HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-9-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=E12bnf1BnZYcd0xThQbrRXQW65sQtsWdYsKbNPUWaYA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHqPjZrfRrtmv5sVdsO1hzu4fWlOpC3f7pz
 DTHZ1UIHJSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5VzZD/40cymQYxQIgKgo88Z0RjyOcnqu5psZcYDlJPGhgVgGuNfgl6zYYTWgy1Ju58/igRmkb9z
 ijIVNy7RsCINtzdzlWkov6BiyUQFQ9U79yICrurjPj0J7heBNL/FpGck6atEysyuMUosCZEVO3D
 k5+8QYcpmmcIKJTb8OEm8yvj4sFQBScu2rSmeM4hAq1mL4l7j9DMLW87Oovbz2JbZM+E5A0fUXJ
 3s/8Vpdw+rqbigAnTNkcH9oFZCKigfyUGJLKOXXLTPHUKtuVaudjuscbidyXVqlOHu3mOXI1YfB
 lvyNtzvXPPIX/+1OLgF6P5KOJ7ezfXWU6OKophM3uZogJSpkwKeAFRIMKHGPyR3MBafwPjWjlR3
 B92lgEHTTdmsMls7EpSAjEmVgWQmsCeaDNsl1PGVQCOLNp+cZHNvlseSTtc0dz8RUUxeaxEn58t
 hMlZBSM4ZpEXl4ULSF4uSVK8uI02lrxTdjvBrPdRPk/epcy7ZK2akgY2GHj6ikpgKdqDBxdg8xt
 1XXRDROHWJ7t+/umnQaXPvMrtns3tsy8fLx9jxAtfOiSRO2Vy2JiQwHd+XMEyW43U8qp/B54zOq
 CAxZtPj2nMug8Xc0ZfEtqCr/lkYGmrPK/wBCC8vAMHCfBKM3KHvOz2lqitFjxMLmNOwf86N6Uf9
 0OwmC1OSl6kuOdg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


