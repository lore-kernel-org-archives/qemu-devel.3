Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F86CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoos-00088c-TS; Wed, 20 May 2026 17:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPooq-0007qQ-QQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoop-0004P6-4O
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLImqMhG7gzftcCBIWDsSz6iVC+6ygpsm3SMVeSSwrI=;
 b=RHaLemK51Wyhx8tIWDD3Oz7NqCmogPdXHTawTLp/sUmUJza9KOK+WDoNPA9GRPd3TKVa69
 CLdp11RTkJfbAIWRjLZ93U5FY43vCzOZnEdYvnqllehWjTRG2pZeif5qIbWGiyAPFGaqij
 FLvmpf5801a7TLeX6i8tI6K95vT5KPo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-A302GKqeNxSeDxQcGTmHeQ-1; Wed,
 20 May 2026 17:51:09 -0400
X-MC-Unique: A302GKqeNxSeDxQcGTmHeQ-1
X-Mimecast-MFC-AGG-ID: A302GKqeNxSeDxQcGTmHeQ_1779313868
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D8AA18005B4
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:51:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D09D31956053; Wed, 20 May 2026 21:51:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:11 +0400
Subject: [PATCH 10/40] tests/functional: use query-version QMP command
 instead of HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-10-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8WgIk7UsN9SsK95MJIVTQHpWzl0LTIcrl9qnXjaWd+c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyChmNDbEVSupBoJDAz1kmEsaDNR9F89PEZS
 bi/TgrBU+SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5ZNCD/9u/g3J4uZdGISt4OiODQOE6KeY/IQi3qXqEHrOMDao2pebb6NoS8YvmQ8xv4h6fLc5BQ4
 KF8dkYSkbHeczn92LHrO6r0izUXWziq2EsRr7DHnDT4iy8TVfkr0dD2jCaASGStByu5dSoTely6
 qL9nbAPHLNimui/7e1OJ/oT8rEEAPHm91MNUYCoV6viMUQKCDc9QPgnWCc0GPInv9yl2ltN3Abl
 KKMUyn7hJhZvWe458RBWWXn46TgK72O2BFkUCW9vfoULpGVDQuHKpD1co75NSHgGNnslt36N+ZL
 kIb6tgOtTrEeC2351TZ5v/WVBxexPw7pZkZsiKYxt1T43hUYm8iL5pDN8ztTTsuYsVBJWzEDBDV
 yrC3tDGNGaDqtp5++4bu5Z3VWD6F13Q1/zrXttgk7sJOa2sl4CNAuPXfseRxhX9jBXburIfza/M
 Hmzz4hUotBpbL0R9c4pRdBcHGwCSqPFBnz2+/Yb6TjbJZuoGEAokWrtLtm1uO0pGw9HDrJHj9MK
 vwzXjsZrD4ApCHMfYkWaBD5ukAF/yL6DLBKh7H9WqrcCb3xUxPIXf9A1XQyb4OqAanGOK3Dvjp/
 sZzvIzw+ba3GarANPX+UWBAVqIcUlXGt50yQkBGa+kcrsTmRmhD3ImR6UBpdpcIGGrCNyDmdALK
 kxjBxelrVslDFkw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace the human-monitor-command based version test with the native
QMP query-version command, which returns structured version data.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/generic/test_version.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/functional/generic/test_version.py b/tests/functional/generic/test_version.py
index 3ab3b67f7e3..7764424826e 100755
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
2.54.0


