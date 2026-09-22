Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D0C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9715-00033r-3n; Tue, 22 Sep 2026 16:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zt-0000gB-QW
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zs-0000Bh-HV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mHSvPtN3hZH9rGpeo544uzNKq13EcVXgfFduNXgYqY=;
 b=fkE/gik5hIkHq+XcFQgvAP2TPVM1B0tQ/XQxrXCyVnYhgtDDNub7oeoOcWQblDYubhLqiZ
 4UCiP4FeBje0UKZ4rztcf0zU1srhf8+CV/U7mSK+AkKu/TZj1n2Zk7lUrEo/GD5/5kJTV9
 eJqYKbNgD8ppceRbVo7uSA/hTiKUti8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-EbnIl61dMIO35ZcJpHcN9A-1; Tue,
 22 Sep 2026 16:21:44 -0400
X-MC-Unique: EbnIl61dMIO35ZcJpHcN9A-1
X-Mimecast-MFC-AGG-ID: EbnIl61dMIO35ZcJpHcN9A_1790108503
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF15E1956076; Tue, 22 Sep 2026 20:21:43 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFD621956095; Tue, 22 Sep 2026 20:21:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:50 +0400
Subject: [PATCH 43/88] qemu-iotests/migrate-bitmaps-postcopy: migrate away
 from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-43-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=93v1+Cu93S6tBlovISKkf7Y5VFd6MBEP62R51quWea0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKx94grBDo8DpvCTeLRzWIUs7g/GCrupjspq
 wBbng+XPtqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5R6uD/9sjdjucQNjtoLIr/Jgk0SJcb3UMxUbuEgr13EUCSt6CfAZ0AYK61AgXDKVjsbqT5/Uvdy
 e6+Vj3qIJ3ZGeNTecRbZenJGKDZdsBVuXZ2lHLf+cEC9etVfetV2AxAuC/ET+afma8o/nNYW1QZ
 3qlOUYhW5P42aNYXhPwU5FpGbF7fmoGQ5A1qtMNsir6+2zoCUpjX4vA+OxuRad+2AU2nFbgAqsg
 XJq9i0W10vMl+H/AIZ/IRukwmJJ9cRL/2bFQ47zkeVqRdlrmmpNyekXEUU5GCzVLUHpqn+taoxc
 CaB3dAZFoAZbcEcOQ5rJR84I+3ny/bLbZLFzMokksYIcRuMPnVUCcT5TIWugmGsOi18e9/MxInW
 y2MOfNvLlVJUG3kZJQRqlUP2CbMFx2FJRZXgJSUxMUhfKnTBzdrh/T4j/bZm+ofnqSJXSlsLeCw
 z9Y1d5dU8vp9W+r8Y6f0BfCaHFUlrwb03Fu0+fkGpdw8MVrOqYnZybYbIQQNnlKbLjjF3AWNolB
 kLa/3AvvKXAZTaXYNt54JcP5ZvAYJoDFNrq4cWWEgJdoQaENAuJpGFY9W4Hr6Ax55cAU0eDD9ci
 K8n/6bbgFCVKJxWVg9kLJlLMpeyP+96NKA6vusMkCYAULYMxpGq1ASlo4WODCQLSojtrxUvtPOd
 mp0/3evflXEvnCQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index b2b37ada4b27..6a424835d9f1 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -52,7 +52,7 @@ discards2 = (
 
 def apply_discards(vm, discards):
     for d in discards:
-        vm.hmp_qemu_io('drive0', 'discard {} {}'.format(*d))
+        vm.qmp_qemu_io('drive0', 'discard {} {}'.format(*d))
 
 
 def event_seconds(event):
@@ -279,5 +279,4 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
-                 unsupported_imgopts=['compat'],
-                 require_hmp=True)
+                 unsupported_imgopts=['compat'])

-- 
2.56.0.rc0.29.g47ce80527c56


