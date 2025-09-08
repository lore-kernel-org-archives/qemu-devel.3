Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6D8CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 19:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvhAV-0006hZ-UA; Mon, 08 Sep 2025 15:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvhAT-0006fZ-Dh
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvhAB-00081t-DD
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757358264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/lFu6o8E1HCKXvUoJO2x7slIVPWYpyPrHnksOMI3CY=;
 b=HSiS36H37dOdgfy7wtEd8PBi6a+96SqbqFZHDDuP0QGo8K1EHMHKRSYbbRmFQ8uExvr18D
 vi1/WJkt7wY8POxltlC6wEFDzfZYdvtJrw+a5E0Rsy23aJNwLd+GqCje31nfRa6Nu3e5JV
 5620Ol+RuFx9DbVrlLlmrAyWr+Xc+t8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-lU-D3NSkMAyoPaSZMQ4M_A-1; Mon,
 08 Sep 2025 15:04:21 -0400
X-MC-Unique: lU-D3NSkMAyoPaSZMQ4M_A-1
X-Mimecast-MFC-AGG-ID: lU-D3NSkMAyoPaSZMQ4M_A_1757358260
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCCEA18004D8; Mon,  8 Sep 2025 19:04:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B2E21955F24; Mon,  8 Sep 2025 19:04:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v3 18/19] iotests/151: ensure subprocesses are cleaned up
Date: Mon,  8 Sep 2025 15:03:17 -0400
Message-ID: <20250908190318.3331728-19-jsnow@redhat.com>
In-Reply-To: <20250908190318.3331728-1-jsnow@redhat.com>
References: <20250908190318.3331728-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The iotest 151 creates a bunch of subprocesses, with their stdout
connected to a pipe but never reads any data from them and does
not gurantee the processes are killed on cleanup.

This triggers resource leak warnings from python when the
subprocess.Popen object is garbage collected.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/151 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index f2ff9c5dac2..06ee3585db9 100755
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
2.50.1


