Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF83C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970N-0001Wm-MJ; Tue, 22 Sep 2026 16:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9706-0000mt-FF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9705-0000Dw-1t
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/8mCljoIIKMRnd7CZUzZNg47KUXUjpcxfTM9raGuq8=;
 b=alpMZ2RYl1inQdSVpC9exldkOspszBDotHhUiMgP29IQHNSzNIDztqiAWHDKmVD8Fx2e1q
 1lCF07Lf/KjzKS6lz+rYBW3avUXjkYGOSod54uaI3TXNGbR5t0ehVLFWdH5XdWuSSA73ND
 6ynnVMyrPGd8k8EHfwGKsexo1/6I+jA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-1SzI8z_dMCif6onyBwfZjg-1; Tue,
 22 Sep 2026 16:21:59 -0400
X-MC-Unique: 1SzI8z_dMCif6onyBwfZjg-1
X-Mimecast-MFC-AGG-ID: 1SzI8z_dMCif6onyBwfZjg_1790108518
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D9B41800DA1; Tue, 22 Sep 2026 20:21:58 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F469427; Tue, 22 Sep 2026 20:21:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:54 +0400
Subject: [PATCH 47/88] qemu-iotests/common: add _run_qmp_job helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-47-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZZjY+h/qr5B205OnmbNuj2LVY7kx9S/yDs2MAU+JAbs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKxEc1Pukb2kI2nBDED0ugR/mSdWJ6rwk1c5
 D/hoU2Ziz+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5ZAsEACRC6qLCWbLBtmr3cQsRUpLIE4eefDHGObAf5yZYU5LVLMbGhIBSG6Z/uTOBmFWxHtrK3P
 fZOEUpaPzxy0uNf6dATeQRuez/2QvJZBKV2/soOi+QbNSnt1C7iaW7FFu1mEUKl7in8XToeZpVG
 55NANRj2ogj0NQOGPrITTfDn48B02Lv2nISgP/VWPNt5FrnCa+ESWfPNCyJiRRUgHWVGd5tocKP
 tXVepuy4cbapEvu0A4vQUYn4xL7pUBtMuTa3og+JW/hyigblUcHwGoc3TqC0UaletJ/kxf3FWkU
 gleUExPk1fBUGZbVdIFeXikhDGMZFLMAyl5/MNweAcm/uYy0GmlipQgGtCL/mPYpm1ZydiReo2s
 R4yBlqEg3NEa1IrGZ1zjbtLiHM7xOkhyLj2Ei637z88KvCk1Rc2UH2oFNSzeXNuJtRTd/Eoyqnk
 p6A/82A/tSHGLcyOAuwmMIHuQHbPyW/ZojU6j/GC8niq3vnPpo/dSRLcg25/vHYMo919QukrvJa
 WoPP9q1XOd5hhisMaw2pW1+qISNX4zAHnVFxbmLVJMcUNiId5T+GoJlRdoVYG9UNloQo7RHqWJC
 QZUPlER2R+CjMIW9jH5w+6gf1CFIcLnIFe7thXwBY2qGsT31gIQ9wPrDdar9CQt3hvI9G8BY72p
 L4lUoSkGvYxdPpw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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
 tests/qemu-iotests/common.qemu | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index e5b6a6a87494..458ea9566818 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -287,6 +287,28 @@ _wait_event()
     done
 }
 
+# Run a QMP job command and wait for it to complete
+#
+# Sends the given QMP command, waits for the job to reach
+# "concluded" status, then dismisses it.
+#
+# $1: QEMU handle
+# $2: Job ID (must match the job-id in the command)
+# $3: QMP command string to send
+_run_qmp_job()
+{
+    local h=${1}
+    local job_id=${2}
+    local cmd=${3}
+
+    _send_qemu_cmd $h "$cmd" 'return'
+    _send_qemu_cmd $h '' '"concluded"'
+    _send_qemu_cmd $h \
+        "{ 'execute': 'job-dismiss',
+           'arguments': { 'id': '$job_id' } }" 'return'
+}
+
+
 # Launch a QEMU process.
 #
 # Input parameters:

-- 
2.56.0.rc0.29.g47ce80527c56


