Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2862CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTS-0005Qf-5V; Thu, 15 Oct 2026 08:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTP-0005Ik-UX
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTN-0005Zx-UL
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nikO7j5K9fVfPT0fkp8mDt89DDyDpcJmpo1hVyQ/7SA=;
 b=ipzIklTUx+caIZsmqmuOsoWGGSMweJ/J+ph0gBKIVM46EtZ+igbAzNuZz4RbWEbnpAsoO5
 A12+wXka2LSO56fjPbgwtBBNpSq7NWuhqPJJFzeR5pacCZUy6wXcggcs6/hXPIAR/hzpyS
 28Rzw8TTsrJ0Zo9sjh1RKtVfQcoY434=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-g6p1yBEtP_-MbJE0li8HIQ-1; Thu,
 15 Oct 2026 12:22:10 +0000
X-MC-Unique: g6p1yBEtP_-MbJE0li8HIQ-1
X-Mimecast-MFC-AGG-ID: g6p1yBEtP_-MbJE0li8HIQ_1792066929
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E30411800765; Thu, 15 Oct 2026 12:22:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E6B17D5; Thu, 15 Oct 2026 12:22:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/21] tests/functional/aarch64/test_aspeed_ast2700a2: Add I2C
 test for IO expander 1
Date: Thu, 15 Oct 2026 14:21:37 +0200
Message-ID: <20261015122151.889017-8-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The IO expander test only checks the I2C bus of IO expander 0. The I2C
buses of IO expander 1 are not tested, so a wrong interrupt wiring for
IO expander 1 can not be detected.

Add a TMP105 device on the first I2C bus of IO expander 1 and check that
it can be read from firmware.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261005020428.3496039-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
index 01c7c4fdbe35..74ef93fc0d57 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
@@ -196,10 +196,13 @@ def test_aarch64_ast2700a2_evb_ioexp_v11_03(self):
         self.vm.set_machine('ast2700a2-evb,fmc-model=w25q512jv')
         self.vm.add_args('-device',
                          'tmp105,bus=ioexp0.0,address=0x4d,id=tmp-test-16')
+        self.vm.add_args('-device',
+                         'tmp105,bus=ioexp1.0,address=0x4d,id=tmp-test-32')
         self.start_ast2700_test('ast2700-dcscm-image', 8)
         self.verify_openbmc_boot_and_login('ast2700-dcscm', False)
         self.do_ast2700_i2c_test(8)
         self.do_ast2700_i2c_test(16)
+        self.do_ast2700_i2c_test(32)
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.56.0


