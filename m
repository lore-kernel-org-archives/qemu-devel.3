Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF04C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96z1-0006YZ-NX; Tue, 22 Sep 2026 16:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yN-00056v-8f
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yL-0008Bc-Nn
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6lITpW/VHo8AukNHzioPNeCXb4rf1doh1fBnsC+4lc=;
 b=be8vNjIaDNhHLGdVIeqioZJijET680liEWDXFGcwTSHel1tDJwtwlnbpdzErNp4l7Ypsrf
 Zo7Ez3hsp1wFtHTIGrbypl/+rOxmX5qShWq2BM9ultopb354W5D3C96QUw1rJcaMRTVpcj
 JNAxxwiVbTBtzDGZsVBQVFvPg0Oe59k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-pRd9r7RJMaaPDxggcqhCeg-1; Tue,
 22 Sep 2026 16:20:11 -0400
X-MC-Unique: pRd9r7RJMaaPDxggcqhCeg-1
X-Mimecast-MFC-AGG-ID: pRd9r7RJMaaPDxggcqhCeg_1790108410
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8991C1955F3F; Tue, 22 Sep 2026 20:20:10 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 886C53000223; Tue, 22 Sep 2026 20:20:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:24 +0400
Subject: [PATCH 17/88] qemu-iotests/mirror-ready-cancel-error: migrate away
 from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-17-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/FNCHaMS3AwzGhRQbZhKalN246kWRV4d/MKPqH6x+Yw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKvM4qAwwv1fArpxdvqRdmHFjQRhGTSgURWG
 JI6O8IAq2eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5bElD/47r7IP36IHG5yAFWYyjqDDhtHyo/jmQe0Tiot3Aku91+3rfDzirKQTOYOfkz4ON79cjWe
 g5xrjZtJCabm9Fqp0CVVCpoxW8GONRxBldYroWJUebTtIIO5z/6g1W+yXVRt4CVK9Kgjcoravim
 QGl2hnHGFPQkIrahcxa6/5XgfjBFI8/QTIZdtvDYZ4b5WI8tXuzFN2zucB0cTiyt702Uu0N3FYk
 oL+PPkEKcHhEcTBOBOy162Aa4rxSwSs4qqJjI2q5/L417soexfqpXqOAq4LojSCCf0FHBO19S6o
 GuMU+jwexrIaPfra21kYrUXaJffqC3j/Vf10Fhuby86z8LA90HIXJtPc/vqPGO/0xx1cNShTxP+
 ad68M+hQcYJR7EkEBU6vDdb6rxc8QqtdiEUfhf0J46Nenrs/lSxCOoBfFRyWXiJml9Udyy0I0RZ
 DZIoENS8oAaxZj7G/MSU+Ct/RTaMdfclcZ8n4y00w8Zu3FxtYFmfaKKdD+riiXfm2utpJqeHQWd
 0sCVlTFeFZKWKDrRWKRyHCCg8dAm6wnrbeYVkNJHzxRlvR2FUZ6UvsvoDtNwuWZ5LEXB3zZIL0g
 vf727sSbLe3vjAdqmIoks4WfCkYSowSLLdYAcF9P6aDQOCacHT9ylUzpzqyyEm3TE6p3W+WnFGF
 HZA5c2tAaKkA5vQ==
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/mirror-ready-cancel-error | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/tests/mirror-ready-cancel-error b/tests/qemu-iotests/tests/mirror-ready-cancel-error
index ffa045af2191..06ca8871327b 100755
--- a/tests/qemu-iotests/tests/mirror-ready-cancel-error
+++ b/tests/qemu-iotests/tests/mirror-ready-cancel-error
@@ -96,9 +96,7 @@ class TestMirrorReadyCancelError(iotests.QMPTestCase):
 
         # Write something so will not leave the job immediately, but
         # flush first (which will fail, thanks to blkdebug)
-        res = self.vm.qmp('human-monitor-command',
-                          command_line='qemu-io mirror-top "write -P 2 0 64k"')
-        self.assert_qmp(res, 'return', '')
+        self.vm.qmp_qemu_io('mirror-top', 'write -P 2 0 64k')
 
         # Drain status change events
         while self.vm.event_wait('JOB_STATUS_CHANGE', timeout=0.0) is not None:
@@ -139,5 +137,4 @@ if __name__ == '__main__':
     # LUKS would require special key-secret handling in add_blockdevs()
     iotests.main(supported_fmts=['generic'],
                  unsupported_fmts=['luks'],
-                 supported_protocols=['file'],
-                 require_hmp=True)
+                 supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56


