Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA4606A33E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=mW7hMPSd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQRtV-00055g-2P; Mon, 09 Nov 2026 11:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xQRtQ-00054v-Kw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:06:48 -0500
Received: from 1.mo508.mail-out.ovh.net ([5.135.90.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xQRtN-0005QC-Oz
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:06:48 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.0.226])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jNZQz1xpwz7tDb;
 Mon,  9 Nov 2026 16:06:35 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 17:06:34 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <armbru@redhat.com>, Guillaume
 Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH 2/2] iotests: Make nbd-stale-connection test deterministic
Date: Mon, 9 Nov 2026 17:06:09 +0100
Message-ID: <20261109160609.1434289-3-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109160609.1434289-1-guillaume.vincke@ovhcloud.com>
References: <20261109160609.1434289-1-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 17260890000062235064
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFP/HMCIPMJK4Fn1LSeHOUwlD4FYOZfx9NtiC+yIw3TvKlgPFr0oV+sXnY6O6ogoIlp4T+QFuidJ15usu5lPJF/QFIQ2x1Xep+q3BDawkTePFEG7vZsSmYbOmb8hWp5RP7ABlosQvRHG2Dw07zXMJfbwR1581InlYbpRHFHumVuMrd3PdUpdLVCnsm0JAMPHObY++5cGOT4U5i7jXlvy5lpaqlQnRMn1wj5k2pXibit82JSx8yOA41kQMKfeYrSjGxJQVp4SlAheU/ZrF3KyfTtqzAp8wcrU9GZRYWIJWbSx0MQEfGmuDRbw4HUodIkWwV25IEsQ9Ud172fJ9ILI1UCNfILjCQWsxfE/6xZ2+LpPzmlnVVUvB2xIfvwoZBCDpntUCA7cBRBSx7lFuYFwvH+LaNyFvwLeK9JYDm5pa/HvZwrhFNWL3nnuL5W+gLc3iGWRoWV8uLR9F2KER6FgXr1K+5rsjaLaFreskLPq43GKP0A/UzlxGK98twPHBxdi0bBXApKTavMsorhSRyZI8/GrbgDXKu7VbQcCeNBcYTdimy3a2syyn2OUwcy14NDpkGWC8V0kJGDa3PGcTagTEmvuuUpTRVO71QY0ITflduGUi4NBtKXRNOxeTRQ4haLbSdKOpN6BGqQ9s2CAtblK9xJmLaSNMAntmuN294TQT3FRw
DKIM-Signature: a=rsa-sha256; bh=e2Qy73SEZVWTtCgn2HWdQg5ILHswMSTZxXJsa0J+J0o=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1794240395; v=1; 
 b=mW7hMPSdjnAVaC4LGGN6kLh/0IszdGJqNU9eddJSnEH85XjLcbbCQe4Je6On7W9gGMLfNAxD
 KrH+tK6bSoTjGRTe41UOn3Mtf/pP6HBqiPFQG3RaR2UmbRJoVAZktvip/1LdZ75KwAGh6JvNtI1
 gjI8OIeLFcIEKrVlhdc7jZvk=
Received-SPF: pass client-ip=5.135.90.176;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo508.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: guillaume.vincke@ovhcloud.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At the moment, the test sleeps to wait for the connector to park a new
channel, which can fail on slow or loaded hosts.

Poll the x-debug-query-nbd-client command to verify the current state
instead of relying on timing.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 tests/qemu-iotests/tests/nbd-stale-connection | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-stale-connection b/tests/qemu-iotests/tests/nbd-stale-connection
index e361bccfa9..265e18adcf 100755
--- a/tests/qemu-iotests/tests/nbd-stale-connection
+++ b/tests/qemu-iotests/tests/nbd-stale-connection
@@ -12,14 +12,21 @@ import iotests
 from iotests import qemu_nbd_popen, qemu_img_create, file_path, log
 
 
-# estimated duration required by the connect thread to reach a running server
-MAX_NBD_CONNECT_DURATION = 1
-
 iotests.script_initialize(supported_fmts=['qcow2'])
 nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
 disk = file_path('disk')
 qemu_img_create('-f', iotests.imgfmt, disk, '1M')
 
+
+def wait_for_parked_connection(virtm, node_name):
+    with iotests.Timeout(30, "connect-thread did not reach 'parked' state"):
+        while True:
+            client = virtm.qmp('x-debug-query-nbd-client', node_name=node_name)
+            if client['return'].get('connector', {}).get('state') == 'parked':
+                return
+            time.sleep(0.1)
+
+
 with iotests.VM() as vm:
 
     vm.launch()
@@ -44,7 +51,7 @@ with iotests.VM() as vm:
         # in CONNECTING, the operation starts the connect thread
         log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
         # wait for the connect thread to get a new channel and stop
-        time.sleep(MAX_NBD_CONNECT_DURATION)
+        wait_for_parked_connection(vm, 'nbd0')
 
     iotests.log('=== NBD server down. The parked channel is closed ===')
 
@@ -56,5 +63,5 @@ with iotests.VM() as vm:
         # Wait for it to succeed
         iotests.log('=== Wait for the connect thread to park the new channel. '
                     'Subsequent operations are successful ===')
-        time.sleep(MAX_NBD_CONNECT_DURATION)
+        wait_for_parked_connection(vm, 'nbd0')
         log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
-- 
2.43.0


