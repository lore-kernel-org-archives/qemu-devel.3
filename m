Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98F0C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96z5-0006po-Dw; Tue, 22 Sep 2026 16:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yj-0006Em-Ce
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yg-0008Q4-JT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CHEdj0GcnlcxwiOqQpGnbPXCAuaqrAXYLKJuueRJRsc=;
 b=Av0SGR/TaSJL1U+B40qHfTMTuZlYuCGRbXHPp4ehzpRAlqg3hUM3T6xHQVjOlK05bxjymB
 /ikur37oW6mMUdrpuyI5EQ8LorzJFhTD4NxnYCEgBIMNoaKjGLdHiHcATjbFWacZt8aXcW
 fXESqfjBgxp/X+AxJsiZ4hSY3rLkeTg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-4QAPbNwDNpWp-2KtOjXr-g-1; Tue,
 22 Sep 2026 16:20:32 -0400
X-MC-Unique: 4QAPbNwDNpWp-2KtOjXr-g-1
X-Mimecast-MFC-AGG-ID: 4QAPbNwDNpWp-2KtOjXr-g_1790108431
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA4EB180AA59; Tue, 22 Sep 2026 20:20:31 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD8BB1956087; Tue, 22 Sep 2026 20:20:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:30 +0400
Subject: [PATCH 23/88] qemu-iotests/304: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-23-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hmBewzLbF0f7RzCbRQBkfnH1HJvAU9WW8KV+10yYRBE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKvS1StbXDHOwGqP0AO7idlgEYVybvOO1cYw
 3WQxc0rHvmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5e9jD/wKarRDoNIIn7l2FmfldJ8dWy+K/NL48bNs7Uj9G22FB6bl3sfZUeq5seTLSAvlubs4qFu
 KWeVa8EZ/TJkqtDmZK2LdExbSk/UxrBexMJT0/gM08xYCLMir+0Ha9vplsoAGAIslVLZyt42N0v
 EqCAu6mXWGftE5XWnGrU0NKWvcWBuiP443kt3JiLdyjIefNyIZNmxv4WKehUW0YlKg40vU0eLja
 Wm+RzaD0KcnuoHguLawT+Sse5a7HswpLndoAZPQczszKzDtkqmatSJKA78s5WyM7316qQtN8PU9
 puHYiq2tqtp0C4kFP7ZnSgcP5Bi8GYZK+2NXe/uEzYkw2cl0FZqZnlAwxA3W91gHPmHTvK6sQJw
 3OBzipycBlnht7XkgJ5d2NUma9g/jXJWgd88bOlJ2cL07OSu3F8rIBeWvbF+wi82YJ+rSgDke3B
 hxus32XATSriUfGx+OU7FcmLatx/wwh+u680pJ2IaRSTlkafTU6E3nXq+jxKa6wXJwApsZy9W4K
 TNC84H4nEos4wRc1IsMNB3uhLG1Oa3fWFdpCribHbmBnJbZRJpFILVbahlesVA3BKj6BuQwnygQ
 aSKLZf44l8nSVOhPeJm/WGXZ6rbix46XouiTt53HlOaN9S3bCEWY0cSXf+E76koKlaIRxDRQbBU
 ipMXkXMGR0CmUTw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/304 | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
index 03c7c1cbe3c8..2447fca99dbf 100755
--- a/tests/qemu-iotests/304
+++ b/tests/qemu-iotests/304
@@ -24,8 +24,7 @@ import iotests
 from iotests import qemu_img_create, qemu_img_log, file_path
 
 iotests.script_initialize(supported_fmts=['qcow2', 'parallels'],
-                          supported_protocols=['file'],
-                          require_hmp=True)
+                          supported_protocols=['file'])
 
 test_img = file_path('test.qcow2')
 target_img = file_path('target.qcow2')
@@ -41,8 +40,8 @@ vm = iotests.VM().add_drive(test_img)
 vm.launch()
 
 # write to the entire image
-vm.hmp_qemu_io('drive0', 'write -P0x16 0 4096');
-vm.hmp_qemu_io('drive0', 'write -P0x17 4096 1');
+vm.qmp_qemu_io('drive0', 'write -P0x16 0 4096');
+vm.qmp_qemu_io('drive0', 'write -P0x17 4096 1');
 
 # do backup and wait for completion
 vm.qmp('drive-backup', **{

-- 
2.56.0.rc0.29.g47ce80527c56


