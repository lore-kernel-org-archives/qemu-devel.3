Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8C1E9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1j5-0000kk-Dz; Mon, 02 Mar 2026 06:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ih-00008v-9x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:52 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1ie-0006E4-O3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451941; x=1773056741; i=lukasstraub2@web.de;
 bh=E8fQx4IKgnAm6YubDXuh85OWLGDWOvvXmk2YMWUkr38=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Iu41AY1qIchLkKUHZr0p/MYYrv6pHNJUI3BHvfCDvTtcq4G6tBCDTpbngaQxxt6v
 iLGHzrha6hUTy1eFNCZeWmVsFRdT04UCuuk5KlmwE+pjZO48deJh3zkm2QbuTUYbr
 xS4zGjoOvEtIj/4CuYIKBE33j3ONzztzdROUrUc1ef9sglV5dfC4wxW2zoC22FRqq
 9CGXjYOJiDhbWXwgKDv7I8AIgn5Te8HFaphTcid7DajtlwGaCs1WoZE65f9LqAB86
 w+rRv83gRm5qA81z3EffXDki1sM8PY8TdjF1sa3x031X0oU1K2dCVFAt0V5jpO3FY
 TjrWEV8Z4HzKHtyASg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M76XN-1w2mcM1w59-0040Wv; Mon, 02
 Mar 2026 12:45:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 17/21] qemu-colo.rst: Simplify the block replication setup
Date: Mon,  2 Mar 2026 12:45:32 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-17-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=pUq20iNV0WnXQSUmrEA2fewmY1+dKjnmaS5gYKFAorU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6UgUVTyaWsV9E3eX0szbzm0Vmt4eu18rKQZ
 CenyhwAA82JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVulAAKCRA1qwsonF2y
 WIgpD/wPH191x3ozTOJzk+MZwvP4AyiVSfZ34bcOLjBITGwaHjWEc81ZVFPoLvK48DEiD8pdC2S
 ziam/gnbpfncn0SbGn7+Vb4iUsiOdq1YXCMhsCnmqD9Dt6QJYqOeVTdKG0Th+5mJC0t6BqkmZY8
 4j9uMvujcRpRz8F9NJ9gXNsbCA5bphxL0UGBc7qSnRZVx2/soaf6QaPNe7K0vrWj779nzV6Kvhq
 WG7Wdzagiu74ZX8MDRJPRWGvg4iH0DXVCX3GvO/3GYCVrRHV0P6xDqJ9ziwz51N+RUgZQcUfD9d
 gBLLakofBlxItYMQ4HMp7MZjhnOdB/B3DqpsSR8uCJNLUbn+57hbA8CXHkQ5eU0ZZ8n5GZsCEo0
 67g6yzxa4fSCb7LfpQBh1ey3s3Bl2rwuHqdyl3ilcjkFQ/alwK/rhcgwCIdK2Fgauq/1hCXAbm4
 QRmqIOYBK50QkKxculFroWaNR9T7DtBH/YlXzGcQ1dy/7GvLVhTX6HlM0eshXgdwezyaraTNFq1
 ym46H3hYoj7A/3Hmfcp8e3jcaIavoDNbAj/RO5o41n4LQikbLdZ7dpP1IBWxwaaNy6/m648CeoI
 K8YuHDRV9ddPiUt2wsG2JP/RYkrnQHyTE7osZAJKH1EV+p1wg9QVIBSxd9etdAWrS3bdzFyqAF7
 DSwG69nf994CQjw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ocvfgv7txDgukRWqwL6zj/MyaTWVOHVrf/ZbE0JVTUGWTUXi93/
 poD0fwZm5T+UMRgmwlJJyrHGa/nfkfm6RV4mHcMA9u8fnDqByfIOACCGutcFWQOi820s/YK
 VPBWpXKEotbc31hB3OMhsDFTgS8wxTq7PdJkv1JW0iTR2mZD3sXsDRtB8ybBbPy7sR+WEJP
 iHIMrkFqnRjsrA+PBZfWQ==
UI-OutboundReport: notjunk:1;M01:P0:NB4I+zkyytU=;Ai9coA6Xpf1ZFju3zhxpD12GGNq
 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
 81CkyH6dcuVPFQXl+xUTR92Lfi13b
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On the primary side we don't actually need the replication
block driver, since it only passes trough all IO.
So simplify the setup and also use 'blockdev-add' instead of
'human-monitor-command'.

This is how my clients use colo in production.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index 75abbd80298df79223cb8e70064a5dc83d70f4eb..f7d3b6439cf3401a58c4126342=
39d1a43999a10e 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -240,8 +240,8 @@ Note:
 **4.** On Primary VM's QEMU monitor, issue command::
=20
     {"execute":"qmp_capabilities"}
-    {"execute": "human-monitor-command", "arguments": {"command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0",=
 "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0",=
 "node": "nbd0" } }
     {"execute": "migrate-set-capabilities", "arguments": {"capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
     {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
=20
@@ -269,7 +269,7 @@ Primary Failover
 The Secondary died, resume on the Primary::
=20
     {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "child": "children.1"} }
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_del replication0" } }
+    {"execute": "blockdev-del", "arguments": {"node-name": "nbd0"} }
     {"execute": "object-del", "arguments":{ "id": "comp0" } }
     {"execute": "object-del", "arguments":{ "id": "iothread1" } }
     {"execute": "object-del", "arguments":{ "id": "m0" } }
@@ -309,8 +309,8 @@ Wait until disk is synced, then::
     {"execute": "stop"}
     {"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
=20
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "nbd0" } }
=20
     {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", =
"id": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
     {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out=
" } }
@@ -341,8 +341,8 @@ Wait until disk is synced, then::
     {"execute": "stop"}
     {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
=20
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.1", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "nbd0" } }
=20
     {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", =
"id": "m0", "insert": "before", "position": "id=3Drew0", "netdev": "hn0", =
"queue": "tx", "outdev": "mirror0" } }
     {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire0", "insert": "before", "position": "id=3Drew0", "netdev"=
: "hn0", "queue": "rx", "indev": "compare_out" } }

=2D-=20
2.39.5


