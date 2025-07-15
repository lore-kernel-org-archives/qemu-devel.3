Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A882C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhGH-00057R-93; Tue, 15 Jul 2025 11:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubgi9-0004OE-Hq
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubgi1-0006fZ-35
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752589958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hf6xFpkyK4Q5hX3V/J0+LOqBe1cYkBrkakptg/l3pjQ=;
 b=UvHSTkGRfgofu0QnoHVJcM3XqOc/+epn8WZ5pdHFDP+63+gjrBzjal8iRZMcAqgpp5jqbn
 JIMEKM+PDjHtueh5ToKqFUY3v+S3DRtOR6306rdVm0QijBMGsBFzunljwqjJ+dX2vCmGJ4
 IL5W+SxWc5nKj3g87pletoAQio4vazM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-GyROHH3PMv-ZXmXVAAdUCw-1; Tue,
 15 Jul 2025 10:32:33 -0400
X-MC-Unique: GyROHH3PMv-ZXmXVAAdUCw-1
X-Mimecast-MFC-AGG-ID: GyROHH3PMv-ZXmXVAAdUCw_1752589952
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ABD61800368; Tue, 15 Jul 2025 14:32:32 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E306F180045B; Tue, 15 Jul 2025 14:32:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 13/14] iotests/151: ensure subprocesses are cleaned up
Date: Tue, 15 Jul 2025 15:30:22 +0100
Message-ID: <20250715143023.1851000-14-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-1-berrange@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The iotest 151 creates a bunch of subprocesses, with their stdout
connected to a pipe but never reads any data from them and does
not gurantee the processes are killed on cleanup.

This triggers resource leak warnings from python when the
subprocess.Popen object is garbage collected.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/151 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index f2ff9c5dac..06ee3585db 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -263,6 +263,11 @@ class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
                         break
                     except subprocess.TimeoutExpired:
                         self.vm.qtest(f'clock_step {1 * 1000 * 1000 * 1000}')
+                try:
+                    p.kill()
+                    p.stdout.close()
+                except:
+                    pass
         except IndexError:
             pass
 
-- 
2.49.0


