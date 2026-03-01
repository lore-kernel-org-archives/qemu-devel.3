Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B35FFD007E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoU7-00049k-Bt; Sun, 01 Mar 2026 16:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU6-00048x-JO
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:54 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU5-00043J-10
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401066; x=1773005866; i=lukasstraub2@web.de;
 bh=E8fQx4IKgnAm6YubDXuh85OWLGDWOvvXmk2YMWUkr38=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sMUvZHGgo1zk5oZ/HSMhmB0cm22UaEQg2fgTWezajx0VQfAHtl7LlgA8KDdWxRNh
 /ppmIM3d0+ZCfw2uR5Y1vmV07z76+UhTsyNbcMofKnC2wjJQxaLWkkUG9JvfZ07w7
 rzkZrZJw/GIC9EdTvP3HWzfoVBNSv09RQb6kPJVtRuq88wnrgiVKqSQfdkeCSPqKL
 35DPoTF30eUCpEO2ZHoSbOMlqkU32kOh1j6RkWCLQTuxkLezGa3YZadGnX4FQkdFs
 eJAx7m39oLNBZ+nrJEUiubuDUobIGaH9/gr8CAwLFwkIRcYdboFFYEn/SooWQlaDo
 hJSQGOeQmL4m+NQnFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1wI2fP39oj-00IvvB; Sun, 01
 Mar 2026 22:37:46 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:37 +0100
Subject: [PATCH v11 17/21] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-17-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=pUq20iNV0WnXQSUmrEA2fewmY1+dKjnmaS5gYKFAorU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGiMZoy2Ewal3EzewugR4/sGeps21s+DnY/+
 MZwbVq0qLyJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxogAKCRA1qwsonF2y
 WLrsEACIn5fvCXI4QB0cZ3eUKMnH9ozmBn+C4ixJ7R03ipAQsoSVnXhIF4DIMpdbJHTyuFdwhth
 6dwH9aQ1DR1GXS/olyveWtM0c+HJlKWbHy45MAJvaXkbL/w7rs0KiiEBB7oZOFxQc8ootahOjQd
 woT//Elie67/8doRSA97auxclRMd0O9oSuF+VCaKtjZCKbrn/oBxNy37Mn6n8G3B37bvnAUPLOZ
 lObeOQBgBr0B+Hu/NPVNyg0lVAO4cgQGTSf8c+59JbxPSW3v4yx7lQsP4MJP99z6+CUuC0egWlV
 ggczk94nbkEoJzCoSlTb35Qk/b5ouSOdjoKuksYayBgFAfNpv0BiEjNjendgOo1zSpYHFKR9MyE
 sGgI40RCZZ0h0nb2T0vBHlotdXqQUmE8EqOuTclOjJvOWneUym5HgS1XXVRvLSJrISNoHwu9+pN
 x4TS5OsnkFXzzd/KyT9kScHPz9T0vpncjgkEa5yAFB4AeRNjagia4oJIAlpfi6724EzRYqb4Zce
 Be4jJZ7vSir7iNb9r+IqeY/q/XPuXJKA606gB2n/6C7vA9gk7Z5m1YSQVq/Wc5j4xkY1a06n8TU
 WfyEmIvOZFWm/F4oCb2JKJYNADPpFCqhXVciGiPTQZ9PQl/XoArWiXwB2q3M56ZxN2wFDbm2Q1L
 d3gebU5Y3Hviu+A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:H76+yqxDdIFi3RbCis4ZnW8UhQ98FgT+jpYFNdYOXPoOqVdI/dN
 ZQjmUpb/KrBBmJkGpogQrD48BJLRWfx3knrRnx+/XihhwJtnSIV2oSwXG48A4wL5YoUPuok
 Y0Ycd35RUU0OwwZ7sz9bwQ8M7DfNLxYqM8S7t9zZ/WDl/aK1QHTLTkxYN+nYl2/YtM1IzGR
 3JMTIjwAbm3wlBlGbaI/A==
UI-OutboundReport: notjunk:1;M01:P0:Jqo+p2CU5fM=;kHUUwotQXbeOWaMYu4gJPXasjQe
 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
 RWqRdy07Hj6hMSq0hsuz6rmkrLwyI
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


