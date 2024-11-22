Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F7AE6ADCB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcL5-00044K-GS; Fri, 22 Nov 2024 17:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tEcL3-00042p-Ld
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:41:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tEcL2-0002l3-1l
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732315275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NGatSzsaT2AupAyWR4RNZ5s1CiupKEfwhFbCjaeh2c4=;
 b=BVz0wQaw28UfBoIlv++dsWC7dCGlOfs366cNY5jYmveo6TuSb1aNr094hOBWrfo8xPNMMW
 OiCx5DQnTKIs5LptsiRjTtDac51r4r+5NEBP4m2JnyFzh++FIMVkiKVRTXY4lLapm4zsTT
 PLD2LbAhKRKeYAd5SkitN2FpKaebxWo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-7Yj3Bb5_MUCsB8_mt3CQqg-1; Fri,
 22 Nov 2024 17:41:11 -0500
X-MC-Unique: 7Yj3Bb5_MUCsB8_mt3CQqg-1
X-Mimecast-MFC-AGG-ID: 7Yj3Bb5_MUCsB8_mt3CQqg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78E5B195608A; Fri, 22 Nov 2024 22:41:10 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.157])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C627E1955F3E; Fri, 22 Nov 2024 22:41:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, vsementsov@yandex-team.ru,
 berrange@redhat.com, stefanha@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH] tests/avocado/hotplug_blk: Fix addr in device_add command
Date: Fri, 22 Nov 2024 23:40:42 +0100
Message-ID: <20241122224042.149258-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

pci_devfn properties accept both integer and string values, but
integer 1 and string '1' have different meanings: The integer value
means device 0, function 1 whereas the string value '1' is short for
'1.0' and means device 1, function 0.

This test wants the string version so that the device actually becomes
visible for the guest. device_add hides the problem because it goes
through QemuOpts, which turns all properties into strings - this is a
QEMU bug that we want to fix, but that cancelled out the bug in this
test.

Fix the test first so that device_add can be fixed afterwards.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/avocado/hotplug_blk.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/hotplug_blk.py b/tests/avocado/hotplug_blk.py
index d55ded1c1d..b36bca02ec 100644
--- a/tests/avocado/hotplug_blk.py
+++ b/tests/avocado/hotplug_blk.py
@@ -33,7 +33,7 @@ def plug(self) -> None:
             'drive': 'disk',
             'id': 'virtio-disk0',
             'bus': 'pci.1',
-            'addr': 1
+            'addr': '1',
         }
 
         self.assert_no_vda()
-- 
2.47.0


