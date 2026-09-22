Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F07C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yT-0005WZ-M0; Tue, 22 Sep 2026 16:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yH-0004ki-ET
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yD-00087q-1n
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbvdZhkW7P3RJl8KHoIPI4+OJx1tMoCy2xiHmREWJFc=;
 b=a4vJ8Ae6q9Ky+1z/z6Fi6Cu+t2EFXwaRQef+PrAysrjNtBbRhp3AtAUTy85YE/48tQXLp8
 DPxU1t46EHPDw9gv3qdHkts/pDkGdCFdoa6Z2VUAylHHiUGKHK0E2W4Q68WBguof6CXQJJ
 60UpcUgwi9VLeGjqWqx2o9j75QeYVls=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-Ct_cLCWSMceuomlaI7GxZw-1; Tue,
 22 Sep 2026 16:20:00 -0400
X-MC-Unique: Ct_cLCWSMceuomlaI7GxZw-1
X-Mimecast-MFC-AGG-ID: Ct_cLCWSMceuomlaI7GxZw_1790108399
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86AEC19539BF; Tue, 22 Sep 2026 20:19:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD2311800446; Tue, 22 Sep 2026 20:19:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:21 +0400
Subject: [PATCH 14/88] qemu-iotests/283: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-14-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4wfXrgoHBISHjBhPh5voZjfsyDCrj8SstNGTEm+Jqwo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKv5DIpZFeCsS+1ujc00F4lqUpbGlLWxYysV
 +f9/L6oh7eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5Zh1D/4qrpZNCoFFzvnc6gM2gIy8QDESdHjHtMgsNhOS24dkD6kd1CA7AKoPyIE5cM9j0mt9F/7
 MtWL2zlNqDv0bx//++Aj2psaaudaoLFdMr/VFF+qqLziQEV/UiW1EettztrDPpxMrCNsqmd5OyI
 G53+DxxqSUkELoo26U7TWdNe4yUloY/2b3TNLLa+c5fwrGJNexjOArSNCg9qob+0a4TDMJITRRd
 Q7PaUQ1ADnun98pyYXss9/BrjoqrLaM6IsX4lqLAD+7IL+d64OxMZKiaXb6KAz0Ypc4gh+b7ePy
 ZK10gbXEINIP6AKowsjUMvwNDaXenz+DeTSbECk7VN3PmSe1UawLbGmcxJx5h5Ikq2Ygf3E9ngT
 QD3umFsTQi52WpbAJG/J7H9zSjZ5K/fz6Vu3zueLISHueLKyjhSfmmeTdeGKbgInYkm7p52DoXh
 UwVv7AM8gcEaF1G/Rj5IUgb7uuOACORunCy9GwR4DZf6Z5MedXSnEFjmOIak/Y5CCLi8Abc31Pz
 Qib+GlDnvd0iUQe56KagNsJ0AMoWYOX0LrCRkwNOVVj3r61bag6WR2TrxhjAe5IqTTjE5VCDIxS
 aV0UcJH8E4RkfwCw//q9PNWNUa7aHMHvr10D1bmzXC5i2PpI1CAB60gyoxC6koUy/OYwIQ7gGQm
 18ujRI1qpbPilyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
 tests/qemu-iotests/283     | 4 +---
 tests/qemu-iotests/283.out | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
index 6d341d3e9745..d06edcdd7ae8 100755
--- a/tests/qemu-iotests/283
+++ b/tests/qemu-iotests/283
@@ -24,7 +24,6 @@ import iotests
 # The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
 iotests.script_initialize(
     supported_fmts=['qcow2'],
-    require_hmp=True,
 )
 
 size = 1024 * 1024
@@ -137,8 +136,7 @@ vm.event_wait('BLOCK_JOB_COMPLETED', 5.0)
 # The filter should be gone now.  Check that by trying to access it
 # with qemu-io (which will most likely crash qemu if it is still
 # there.).
-vm.qmp_log('human-monitor-command',
-           command_line='qemu-io backup-filter "write 0 1M"')
+vm.qmp_log('x-qemu-io', device='backup-filter', command='write 0 1M')
 
 # (Also, do an explicit check.)
 assert vm.node_info('backup-filter') is None
diff --git a/tests/qemu-iotests/283.out b/tests/qemu-iotests/283.out
index 5e4f456db55c..1c12c8fad7df 100644
--- a/tests/qemu-iotests/283.out
+++ b/tests/qemu-iotests/283.out
@@ -17,7 +17,7 @@
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup"}}
 {"return": {}}
-{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io backup-filter \"write 0 1M\""}}
-{"return": "Error: Cannot find device='' nor node-name='backup-filter'\r\n"}
+{"execute": "x-qemu-io", "arguments": {"command": "write 0 1M", "device": "backup-filter"}}
+{"error": {"class": "GenericError", "desc": "Cannot find device='' nor node-name='backup-filter'"}}
 {"execute": "job-dismiss", "arguments": {"id": "backup"}}
 {"return": {}}

-- 
2.56.0.rc0.29.g47ce80527c56


