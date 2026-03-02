Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA771E9B354
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hk-0004xw-Ca; Mon, 02 Mar 2026 05:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HX-0004tX-6c
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:45 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-00062r-Fv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446416; x=1773051216; i=lukasstraub2@web.de;
 bh=E8fQx4IKgnAm6YubDXuh85OWLGDWOvvXmk2YMWUkr38=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Xy5DkCwRfJCYJgIDXI0DaUOYeTZ6PQO6WAbiUB0afYANbpBSm6wH/p72bKM5XCPv
 kQ9l1rgSPv1m9z5PaHT0OgPdtDq4DJMNj2gm06fowQMRlue0ZvuzHDiAFyUCNBcxS
 P09ByESLxgmGJi4TGHo76oKaIuYAibixyVwvoFGPUwOHqclGIQSUspid1rM/sHOZU
 DwrMEs+3YD+8KPEmmdOGm3fjph6SLOcjILsvFV5IVJTh3lmek4GRkipVkUSiaELJy
 MQASo59LMkccJiLkavuop785zuosxx7ZQtfz6MPZnxrc5f/xCZ1pxwyagzvo3Y+dT
 k1O9At5S6cI3Qd6twA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWz8l-1wC3EP0fSD-00SrEm for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 17/21] qemu-colo.rst: Simplify the block replication setup
Date: Mon,  2 Mar 2026 11:13:28 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-17-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=pUq20iNV0WnXQSUmrEA2fewmY1+dKjnmaS5gYKFAorU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAGiJvYR3Gq0N8vWgvOFvHkZ5+Kw5r/T3Zl9
 EgDUGII2OiJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBgAKCRA1qwsonF2y
 WBhDEACM2XmHa41UzCkKS55PEo+OhmoOojcGEe6z07VsgcWdUzr0JQ9BAXnr6LXDYbw72Aq45h+
 OtpvU+lyJGIiEFkByUEj0beQrQLEZaUExNxMcpg7eUK62fMYXBEySN0mD+s4MqfHlPGeCrKmuwO
 Z0rSESgNo1d2zBYHdD9A9BgUF3Vzx4fIXkE2KHdMbx/GPiiulsp6zjJaKZN3yIC5iI05GnqauxU
 pQCsywBpkU98Gz+CtGk5oXtjIUwzcKekJDQTMLWm1zyCJ32qdYiWq9jtnbYoqz/lqsvLMJafY0Y
 hYkoZFc5g711PqIhTZyWxObJ7Gr6ENqojcfNWTwZnj0QUT5B2celIr3yKxlJS/IaRA4xwNicBC2
 CrH09NS9G31L4WarYoUDyLWD4zYlda0PHt1BLCVRFUrnZ42OQeHC/KqB1v2Xi3Gzp5JHNi9X7Ik
 Q9wCbKB9JpVcSprwAporop4pe54KGYMLOwLyXCXSNiKPHPxzLyoY1lZmJlLdfHQZrOIJilu6fU/
 WhOiS81c4PgZQsHlKJm9Re7O1C73Au//T8STOyjC6nOB+Xj1inhNRVE/5p7gU7ZvnbIsw68xXPC
 TATmu0Xv3NSBka5MTP1/EaYyAyRowDqZHpXo+ngZqSnZuvEG1FVGOYeYRqAiHiUsbPqxRMaH7P9
 tDC8GFqcJnT7NtA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2en2t2MEobwSZNc6u10qOcEl/WVqhPlSWILJJr/2cobzu3Y0xvq
 jZeL4MamWnI7GdZi9YJnHkg0GFlLzUJR8Ho0i7HsKLtAgtJ20f5TlwNDxSUhDoxMtj6ruBf
 FRJDIwzhbKNQ7/eckSmEoQ3SVQ5IHYqaDscxSTDBjX2BJYPn+/QsVaCtVarjgW3a8rDKvML
 MK5wj6vj8S+CIh7NqW5JQ==
UI-OutboundReport: notjunk:1;M01:P0:DNaefOUZQGs=;DncOfn5oaAaEAH5ykswaguMQ9Kq
 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
 XTg9rsCR8I4KlrbLxOQjcxP29shvJwZE8yb6uT
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


