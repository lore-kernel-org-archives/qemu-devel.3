Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F83FC5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXp-0000WN-SQ; Fri, 20 Feb 2026 14:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXe-0000TG-1w
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:59 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXc-0001RH-9N
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617112; x=1772221912; i=lukasstraub2@web.de;
 bh=5DRNtylFaST6/JPH9QU2U4TO4NvWnISJBshbkAaedFI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gWos05q+bpnXp+A5TT5sA5rCQzKS+FOh8dBmBbcuN00PkDhqrwrAWbcSs6gFIkm8
 FHqxigxWRNHmG16OB/xpXxk7/Hl05QK+miiYxHgjEIx1OJhB180CVVi03TRu6EsyR
 R0y7yMAG0pKwtfqPPPGmRtLqT9C00qSE+wiydFJfr9wVaWLlKfNMxccFfbHid8pxp
 B+OkMejK660CCgnGhNJSEPeMvCbJySQr+0X3j5WTyetu6wy/z8VrKxApuV9iVB6I6
 7lhqvKPYO7QTyhl+Z3t2jrApQbMW8XAD8XOP2rIeZaIOFUn3Njt44RI1RfObdk87o
 UQ7WOCoKV7GbHpiJHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhjm-1vUbew0QkQ-00kZPK; Fri, 20
 Feb 2026 20:51:52 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:39 +0100
Subject: [PATCH v10 17/19] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-17-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4393; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=TYU6TTLFHjrH9WpcMw6oVhFbPAVy0WPrt4oU9i8UKQI=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtP9ZS3VTlz93dl9D1Rp3dNx3fdDd10mkWg4
 +Cx9+RmPKeJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TwAKCRA1qwsonF2y
 WOQLD/9g2/dAidy6ZkOhsgdQV8heiX89kISAmQWl/+o+zS/lgXcHIN2Y0EOX8RrDm8im4bwiUNK
 BZBjhCI4jkBritoQC1sa27Rfs8NZtzkWKK/L5iKYypUb2RDYRI/Pe1+jyqpMb6wDhs0CnS8Ep9w
 hxC+D0qvqSd2Q+Smm5E6ogxelTUoIL2fkEjJgsV1mhNEhbMQ+WB2u06gKCo6RE+662rshHjgdLR
 HU566AunYfMVlRra151xFlF7+ySfghrcney5v0Pk6gkh3HL0jscHe+tPmkMkmer9S4Whou5EW2S
 JPRAL3SdACcmGpuEkAiYfHCPsI0lnTg/S3s8btWjPb/zz56XXKcovjA7ivccUtT3vmfI/q7a4zd
 nLJWKksW7uRf8H/e7otOqjbeWdF85GT+YMAL5MrABSyRFc6UNfiIw7d11I7aoIzuwtGjW7Twi9/
 mtS1LXL7w7PASl2fYjN0oZs6XfAExw0hzidYKV/Dti36eexxFLPUn1LdxoFKPB3iluJwKHaOye0
 Q2DX5GkuvUt64TmgdQM9zOLTeLmddublIt+8bFQsuAkXNOa6fxGZ+x+lTPvWTRs/aIaMUa8A7De
 FNgZwrgspvNIYauH8X9LyZvmWGTqYpRjjUS3JAYWlFo3kocwTrgw+2dQif78Gu2ShAJVUgAtogG
 nHim2CTPZLF0/eA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:2jF5b9hsYDCT+47pFqhGEEcz5/N+A+1OG2wVaKqxUIpzxJqbb+W
 HXZdy19wE3gRk+nHKsMD9xhw372P2dhsTSugpcUcb0ja4X5F1dMscLRMqiy/LlPPNev1bYS
 mv71AiBE0ehsYIccGbGh3ZLhUyW6W7mV4/0OeHXWu82IMTsTwHRSmLcKBI8gImCBonN+wxK
 iTihUcjsoRM4jb57Obh0w==
UI-OutboundReport: notjunk:1;M01:P0:z2rcSeXRXDM=;H+WdYR5jylJtJVkQL8P4JPmAQ5i
 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
 H7xbcD7pRF/2EnYY5tSByrxJkRqEl
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


