Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B112DC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96zD-0007Yz-HQ; Tue, 22 Sep 2026 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yb-00066j-CY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yZ-0008EK-Ti
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jrtfu21CdEP6ZyTblZAk+CNFLsrij9QbZvxsWaJdcB8=;
 b=DZpkOoIQJrA/1tigL2+g5Ahpxji6dZgjGUEyUIIoRBgimQB1QNgiamvmrpDeN0JVBQolII
 6dKlDDvJOfb3LKR/Kgzy98BWF0jncW/+/W72S050wJd0EhWXlspUs9CIrtoMsnEkhfAg8X
 GCAnn7OIqgReEfQeYFeloRKQYRemMW0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-QtylnnVEN2imHm8pKq6RUQ-1; Tue,
 22 Sep 2026 16:20:25 -0400
X-MC-Unique: QtylnnVEN2imHm8pKq6RUQ-1
X-Mimecast-MFC-AGG-ID: QtylnnVEN2imHm8pKq6RUQ_1790108424
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8403E1800752; Tue, 22 Sep 2026 20:20:24 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 867811800370; Tue, 22 Sep 2026 20:20:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:28 +0400
Subject: [PATCH 21/88] qemu-iotests/254: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-21-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=X4DKkNJpiHkKAdxVmkQ/lkxp6RZzLg27sd897LDL1D0=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKv3O8lUMpUa+cfPatWanfa+7D/1pmuoH2Di
 9qyjp33kkWJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5SIyD/dN9VAW67R05KYhdgYQ3nXn+O7YVFhHiP7ePB9y7pbwVIIRCXWG+8oUcrXQFV0YMT+qorA
 CSujIxe05kIi13JpM7OiS2rH+14l4WV7jdu81L8pUieRI9JcypJ52Rj5xnPQL6BlGVNPU5JXxo0
 7zWgSsKO2EeI7AbhrQFJhJrcp/YmVCDQKNGbZJBs8B9IjV5um89j4D/6HN6JzJgDC6RUD5Imcd/
 F5w0iGVpKnVkMGYJXoLHcAifNnurzZQZPHN+jI5N/BYmY6T+6zLM/2PLDgOq5YfA4StJr3tqssM
 XaFLA98/gzjnCHXqjPs03ZAVCFfPO6FkomjmKgxox71TOYJyLfYUFB9cVxACkymRIUdS3TXi97C
 RKsxgdwLGJZzyNJr5RQwyXdiytFhNAg9AnxYFbVPwgD507atV7jr031Y6YAncTuoU+sfURgTaS4
 UU5E+bWdkO/2G9r77IA0BgFjysa97ZLie/SJmALmYtcvz0zGc3L1YVvqdSjeipIoXnMiHoJo1sO
 zEVstj2vBGKhU7+a3FaKXPzxZYZYpvJzk1QTJbzHjmXqLH9bKq45dTr9pWVPUPUqQoszlnpqlym
 KfQ4mJFP9yIobh09x4kX40bY3SavmRzEDQBsfTS3gYTfESZ0snVzK3zbYKH2y188q9+22E3H7aT
 ahbmApEN/j0ci
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/254 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
index d3d18a1bbf1f..0f49548b6226 100755
--- a/tests/qemu-iotests/254
+++ b/tests/qemu-iotests/254
@@ -24,7 +24,7 @@ from iotests import qemu_img_create, file_path, log
 
 iotests.script_initialize(supported_fmts=['qcow2'],
                           unsupported_imgopts=['compat'],
-                          require_hmp=True)
+)
 
 disk, top = file_path('disk', 'top')
 size = 1024 * 1024
@@ -40,7 +40,7 @@ vm.qmp_log('block-dirty-bitmap-add', node='drive0', name='bitmap1',
 vm.qmp_log('block-dirty-bitmap-add', node='drive0', name='bitmap2',
            persistent=True)
 
-vm.hmp_qemu_io('drive0', 'write 0 512K')
+vm.qmp_qemu_io('drive0', 'write 0 512K')
 
 vm.qmp_log('transaction', indent=2, actions=[
     {'type': 'blockdev-snapshot-sync',

-- 
2.56.0.rc0.29.g47ce80527c56


