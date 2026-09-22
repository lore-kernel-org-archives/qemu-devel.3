Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070A0C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9707-0000ho-I9; Tue, 22 Sep 2026 16:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zL-0008C8-FT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zJ-000055-Mg
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxEfmRMQ5coRD+2iN7K2dmIzHXM/mLZ3d6+9S/sqJ10=;
 b=WpmAyncLAcHDZ9gUEOrMfBfURw5uAG+anQr0RQ0t3OceS/SAccGC6uPeupxBUdkWsexCXA
 6JydKPj6NAAgIz3THu+lN1Ql+nzsHzzVqditTwuY0gMReLrGFu+FilierCQrPzEI5KJo/v
 LqEHut0qa/i7sFp4WTWDtPl/4KCQ1pE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-orJqN7DNNZ-L2OQd5x9NIg-1; Tue,
 22 Sep 2026 16:21:11 -0400
X-MC-Unique: orJqN7DNNZ-L2OQd5x9NIg-1
X-Mimecast-MFC-AGG-ID: orJqN7DNNZ-L2OQd5x9NIg_1790108470
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BACCB18007FD; Tue, 22 Sep 2026 20:21:10 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA0621956087; Tue, 22 Sep 2026 20:21:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:41 +0400
Subject: [PATCH 34/88] qemu-iotests/255: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-34-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8Z84kd9IBI3YkYaDGI67gcP+iGiek63bo9ma3Xr+cJU=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqy4rCh1lrnLYBkwm2gD/ETzYbOZhzpCR7bNEE1b3Ui3WCCr
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqsuKwAAoJENro4Ql1lpzlXUEQAI9M
 K+ChiUw1iWimtZVhHMC9Kf7UVz/y7kMfmHlq4b+E3BdQu/G/r0FtwASJWjNPM36/RJbsU8nDjsM
 iBhzVfsq5w6JuPd4zusPc6MLteX2twSlms40yDByAA9pb3XmtyLWNnCng6OrR8lvlPoIZ9Ehx7U
 MzCDoa4M+4WqVFSynFIqy+CxkpkTawDDwW6j1UfGA0hyHp8xJ6lq2XF5rrndV3A/mW2M0MiOr51
 U9N+rrLLM8hmzTWhKTRSekKA72BBmvwWkWqokwmDzk9yzBlwAX4d3Xxq2pGotDcMOjoKvICIIO1
 sE4q8GU39gEJzYhEGZHFf79QwXJcFFUOLXQeDEBDpyw642OpjS+tI1/ySQWiotJBt+5jiVWJ7wf
 IiJxAT8ezDtdRheHcHHBkn8jSg1R0tvXvdLiKscSC0Jfo5iwCaZjknGRXfgPUdLlSidXOzxrzE1
 iUFtRxSGZwV/hQclCmnMUVQhKymVNY0/0AdQ76i06GniUxRK4TYD6LRcpNhMIbJ+WVKqPOnFoWq
 XdJvV/6pxgnzC21UPYr9ZES6gP0mADNrhlBXPaJKaaOoT8SUykQoGO3u0HAYkkR7rIXtf+5AnU9
 pSYWKWiv8aHiu4AKnKlMRSqE8R6oafqcelAO1+tLGHuxuRbpGCB4NSFxdblu55wExwcv9j65eop
 2pYJc
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/255 | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 8f88522f1e91..83c2246db3b2 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -24,8 +24,7 @@
 import iotests
 from iotests import imgfmt
 
-iotests.script_initialize(supported_fmts=['qcow2'],
-                          require_hmp=True)
+iotests.script_initialize(supported_fmts=['qcow2'])
 
 iotests.log('Finishing a commit job with background reads')
 iotests.log('============================================')
@@ -62,8 +61,8 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     iotests.log("")
 
     def start_requests():
-        vm.hmp_qemu_io('overlay', 'aio_read 0 4k')
-        vm.hmp_qemu_io('overlay', 'aio_read 0 4k')
+        vm.qmp_qemu_io('overlay', 'aio_read 0 4k')
+        vm.qmp_qemu_io('overlay', 'aio_read 0 4k')
 
     start_requests()
 

-- 
2.56.0.rc0.29.g47ce80527c56


