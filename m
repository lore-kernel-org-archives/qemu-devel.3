Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CFCCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 11:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKwWi-0005Ii-HI; Thu, 07 May 2026 07:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wKwWg-0005Ho-B3; Thu, 07 May 2026 07:04:18 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wKwWe-00046I-54; Thu, 07 May 2026 07:04:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WD5UW6JxJgRgmyJTr8JbeEJSqwIlVV0+vTp64Aom35gu+teLOayjmbnv1awc/pYVOEHa7S4l1InRogajEi7l2rGYRpWBLmc60imTIEX3b2BQWB+xI+DmvJVvXeL1lIuN+x3kg3sNR7vZUaOFvqczYJjrMjLzWuY400h0kYE8Kc/eCSSIdIEL8ttZnSPYIxRZ6ePKdR+6zkWy9TVb31LNyoyQXxtD0FQQp1MwX+tzC+48smPNqz/jtLNEb0GPfrHJfEn2h4cgbIt0AgVldYI6DgfQnck0XOvBKvqMgbuhfOD1ievn5NyMMenEkGmr0wYirlQvqxXCaN3u8moAf9BEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2lUu9zAZLhndD5AiA2h6ZqwvfShOKT2Hh6uFRSBJz0=;
 b=idBE6mOsITckOyT1Srru6eYwxDGky0JXl1+ZyQsQ5gLX2iI+Wl994QDLxtG2mmt1SKaW6BC9ajrge7aWav3CuEImjV6Hjk8RW8ZxC9TgutaIE098KVe1kdGNcRVvHTYbrvYfRuzqX5vgJvzHnqWR2jwzKAwPF0XdU4lWtJUOd8z1KMN8mfD4/PNJn3Pxhfv9g2u2kO05s896xEPy1g+x0SvL2ZBmCeYH2gViuzK7+BA5D1SkUpDi5+2g7qDBxXYhCI4hTac3+2H7cLJgB+ZBjYmSCG4rITizx+ZYd87cAD0lwdJS52EKXqovyqfY/ifb/pwyZ+lJSuCXr8aUy+iVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2lUu9zAZLhndD5AiA2h6ZqwvfShOKT2Hh6uFRSBJz0=;
 b=AhKe9S0+PtNhNjs/+XnwjfVF3LgAYZ8hSWQoqrlE/hpKuEpVqGpt8Bn1phfsUwnU3RCv9/B24orTHPjyIQIN6Ab6QBYemcoP1V6Ht1x9jwD+t/uL5dRoS387EGwksMH/WltMfSm3MF9i2seYOnNr8/pR1hQz1fbJJ3JKzh2ojwTQf/ZjY22V/XV+BTPTRVQY1UldkW9wLWpWfk/lNbRjYh0lhbbV9U/bixgtcU3nMpbc0nfVgNJCSSY6JivgsU44fmP/DK4Mw07DbQPsQSrKYZ4SdfTygCJ7iURjoofzAX2oK98DU1p0gL3rgGAHAuMpjzkVM/mqeygKjhDaMdSwoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB11205.eurprd08.prod.outlook.com
 (2603:10a6:150:1ec::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 11:04:06 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 11:04:06 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, andrey.drobyshev@virtuozzo.com
Subject: [PATCH] iotests/nbd-tls-iothread: use UNIX sockets for nbd server
Date: Thu,  7 May 2026 14:03:52 +0300
Message-ID: <20260507110352.449937-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::22) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB11205:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f352ed1-887e-4616-cf55-08deac285b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|3023799003|56012099003|38350700014|18002099003|18056099003;
X-Microsoft-Antispam-Message-Info: msq/APoVFLH5FwgeLFoYUqm+tGL5mudHyuQWbt3iiW1K7Ptox0bOtURbiemi40LnINKSB7BR97xmpYKOD1H1HXH8JpkaiBTAS8Z2FiqUjCsMEpFHbGyidz38fm+J9SW2qLZ0sh0eP9qhrl2ZW3ajkzZi5otskhHZyLuzAbxVdPZwrN2TszvO8nqLIgcC5UQv3htcJhpwpPnNlV+XwS4XTSGeI+MgcI/Cyjj4XjIwr3yDxLCOcWRT34fIDox1PZa/F6bXmCS7WlbGZcgBxXfICfhmoF5OAFKSwoXiG+p+Psq/+rj3s4lLfTkuYhyKNcCCMEdw6hfkBD0lfO4q4b1g75cuoaAxDUP+oMsa8bQ+hhc9bX/T5v9Pg0LgS6gC7z0dE20jsHQWMKJm6MbEUlKoFOBFrGkJULFUU1rkMDaHCeqSVg8VxsCuNzitx31SuHg9+Kfn87UpPGtEE54jTsSzEzslEWOrRaIReS7wUEVyvv+Glq1yJHlilc+4anH/h1fffW+63gkET8zxQ76W3EY9gy+A/TEzsZSLuD4PyQF9Scma5tkQbjuNFhSthTxPFCYRc97dR6S5sYgvH6/SwCO1RsKbirH5h3NKDnSEI9jajL+m2BFOkaaQADij/wjHm6J2crMcqDkickrmDmV79ijITbpBmP3ONjd0QZMD+FZHLUz7Vjzm/qHnJERl2SBPfJpm+0KY1E84jsVmmN1w2lE3U3vYigW95IolAez3so1a/Qawq39JTHx8p87B5m175dqZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(3023799003)(56012099003)(38350700014)(18002099003)(18056099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZhIN5KNkso7ZrsgmqBxUQXm0t//OfRlzFwxt96CE3kRkNdpd77Urk1GCoDm?=
 =?us-ascii?Q?RrTOtSLVkP7Lr5jxPadcqBmA4bc2LQCgSjFzycgZtmCfXz+YbFcrwgdzllWi?=
 =?us-ascii?Q?MY+HdBKUax61jfg4gbu19JYqg5U5FwwFKGDkjJHHHIcT4M8kvujb1F7rjAt0?=
 =?us-ascii?Q?V7e2twcbp/tKkdCcl31mUDJbboAA8KcgGyjcs1BajqGIJfNo4sAv/YlJz0//?=
 =?us-ascii?Q?o7OOSPCGiXKHUswMBQKV83GBAf0YopgNAKfwOBFp+Sjoc6T0PbzzfGADqjLo?=
 =?us-ascii?Q?G1aatExEvbPPCQeqyznG8sYLmz3tPaam9OW6jh75GYLmh2fHXdIMYV3ifrI/?=
 =?us-ascii?Q?4BNVnSgHDh1WOxy4s15d6F/kG7kz0ioj9ccqQgJAnbpgaaXRMF60XZ6uvrBu?=
 =?us-ascii?Q?auutxXdceaJbnYGnlJed2Ep03xzdqyqdcD4fcqQsh7Kq31bDgKsKnlsGvoUL?=
 =?us-ascii?Q?VIYidtqtuKdCIGeE4FaDh0akSmd8CtI2sAH8xbs4XsrItRPsTu2X2BXpVI/k?=
 =?us-ascii?Q?wCegVh0XBILKqU4UOPZ5+0nJaN8AvzKF7DoMhWyOLsKAbIpvjFPnVopqC8Wk?=
 =?us-ascii?Q?Hw4YvZzMWY0PPvtwWPXFDtTOJ5NFgiXffLXf8e4iyRhFoYIXUM3ejAoebJOp?=
 =?us-ascii?Q?cxMcMGgPdVXka6M7YhTsU+fOx4Inv5KTKVf6KUTIpCbqzM1v7EscruYlG2Zp?=
 =?us-ascii?Q?VpnOd8Uy2gJTEdFEKI9oiZAe70bksQFCT9eXbz1H3tvFY9NoGxMygmlE/cWv?=
 =?us-ascii?Q?mSJ27/HricoUjXaxX906m8OpZFCwkncSCMeYm6lc45dE0lb2vmjpzU5I/Ghe?=
 =?us-ascii?Q?8f3eTr6DBVIEulJ4qZpRdtMgdrIpJUcQe2fFJ64/SevQvkQCVSD7VUf6QWK/?=
 =?us-ascii?Q?MO7SRTKeRYax6hRNRuMhK9+bc9Ogqh/gmKqvHQmCzFuEEJGzf7HU6CYwtZwe?=
 =?us-ascii?Q?TJwSTFc3viszuMZwIysULb1TuIOSeHibuuafmObazpq/LzhbPrvZMvNZhGea?=
 =?us-ascii?Q?YG+T3tGJRLTsL3JALXVmuzbCxWAc/kiYtfEf4AUCReKfGzzYUALPPc/TTvZr?=
 =?us-ascii?Q?qeWa/TiFPBMoITE7IjoC1dmElRJGC5raVr+6o6T29GYme1vxY6a+/KLDuecF?=
 =?us-ascii?Q?5iBxWSgIrmg9ZD/yyE6vBhQ1ZY5bFaM7pzJHhlES2CQF9Y4ZxYOJiGb7UQJq?=
 =?us-ascii?Q?wytIwlHcW7wmao0o1khj2has89CSY2WWdMrhGW8oLZ5Ic2+7gLM4b1+bNgQ3?=
 =?us-ascii?Q?smstmc3ybtCclIJakMVrYqo87fmnnX9nwlj2tvlCoN5F+zkKJ5jW8eJTvpQF?=
 =?us-ascii?Q?ESWD3bXGDUFogpjZHxX/wVuIB+xwAOgJ65fEj7gWoTRZiOTZTeTFYy+cxezK?=
 =?us-ascii?Q?T3qfbI5d6ntQyX0KESHKPaXNw+c14rB+eay7shaU05XY/AdC943tdP64/Y1o?=
 =?us-ascii?Q?YVQ0gs67yVW0hMj4A2aImxzh0HfRj9tYgpe6m8xUINXG0UGNlqSVnHhZpJ6i?=
 =?us-ascii?Q?dor/A3BFSJ59GU5Ag7CHd3pbrPEzzhU1fYvsEVsA+r3n3TRPm16KyKseEksV?=
 =?us-ascii?Q?+tM2kVQSOb/xHuzuTxMimWhKUzula+roKfh1osGY2LXrjVvTLCxaQfSbFWM0?=
 =?us-ascii?Q?jb20tChl72v+tQtXEwJeSXnKb2+j+f8rTWxzipZAHRyekvBrJEaXbIbqwZYs?=
 =?us-ascii?Q?+Q9VASFi61+ona0IcUnBFcEA3R6ex4u0QarJ94eXkJcVroVOSBsrVBCFWjVe?=
 =?us-ascii?Q?BFjg1ykL8oqgrdbjGiO7QbSW0OgRfbw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f352ed1-887e-4616-cf55-08deac285b37
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:04:06.4310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yY/3fl6ShKTMBOsOAf5FIP9r24Mc97TpGjoEYN7Fnfh6t7Hv5j3BoHbS5fvUQWRlDMCp9rjBUZeEx35/8+jsEvU/dPto1RvoLEPdYz11ESU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11205
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The test is picking an unused port to start NBD server, by running 'ss -ltn'.
This is racy, which is specified in the the comment, as we may hit a situation
where port gets used by some other process in between 'ss -ltn' and qemu-nbd
runs.

This is exactly the case which I've recently seen, which leads to the test
failing with:

  -{"return": {}}
  +{"error": {"class": "GenericError", "desc": "Failed to find an available
               port: Address already in use"}}

The original assumption was that QEMU doesn't permit running NBD+TLS over
a UNIX domain socket.  However starting from the commit e8ae8b1a75e
("block/nbd: don't restrict TLS usage to IP sockets") it's possible.  So
let's do just that, simplifying the test and eliminating the race.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/tests/nbd-tls-iothread     | 35 ++++---------------
 tests/qemu-iotests/tests/nbd-tls-iothread.out |  7 ++--
 2 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-tls-iothread b/tests/qemu-iotests/tests/nbd-tls-iothread
index a2fb07206e5..c386c77e377 100755
--- a/tests/qemu-iotests/tests/nbd-tls-iothread
+++ b/tests/qemu-iotests/tests/nbd-tls-iothread
@@ -47,38 +47,15 @@ cd ..
 _supported_fmt qcow2  # Hardcoded to qcow2 command line and QMP below
 _supported_proto file
 
-# pick_unused_port
-#
-# Picks and returns an "unused" port, setting the global variable
-# $port.
-#
-# This is inherently racy, but we need it because qemu does not currently
-# permit NBD+TLS over a Unix domain socket
-pick_unused_port ()
-{
-    if ! (ss --version) >/dev/null 2>&1; then
-        _notrun "ss utility required, skipped this test"
-    fi
-
-    # Start at a random port to make it less likely that two parallel
-    # tests will conflict.
-    port=$(( 50000 + (RANDOM%15000) ))
-    while ss -ltn | grep -sqE ":$port\b"; do
-        ((port++))
-        if [ $port -eq 65000 ]; then port=50000; fi
-    done
-    echo picked unused port
-}
-
 tls_x509_init
 
 size=1G
 DST_IMG="$TEST_DIR/dst.qcow2"
+nbd_sock="$SOCK_DIR/nbd-tls-iothread.sock"
 
 echo
-echo "== preparing TLS creds and spare port =="
+echo "== preparing TLS creds =="
 
-pick_unused_port
 tls_x509_create_root_ca "ca1"
 tls_x509_create_server "ca1" "server1"
 tls_x509_create_client "ca1" "client1"
@@ -136,8 +113,8 @@ echo === Dst VM: Enable NBD server for incoming storage migration ===
 echo
 
 _send_qemu_cmd $h2 '{"execute": "nbd-server-start", "arguments":
-    {"addr": {"type": "inet", "data": {"host": "127.0.0.1", "port": "'$port'"}},
-              "tls-creds": "tls0"}}' '{"return": {}}' | sed "s/\"$port\"/PORT/g"
+    {"addr": {"type": "unix", "data": {"path": "'$nbd_sock'"}},
+              "tls-creds": "tls0"}}' '{"return": {}}'
 _send_qemu_cmd $h2 '{"execute": "block-export-add", "arguments":
     {"node-name": "drive_image1", "type": "nbd", "writable": true,
       "id": "drive_image1"}}' '{"return": {}}'
@@ -148,9 +125,9 @@ echo
 
 _send_qemu_cmd $h1 '{"execute": "blockdev-add", "arguments":
     {"node-name": "mirror", "driver": "nbd",
-     "server": {"type": "inet", "host": "127.0.0.1", "port": "'$port'"},
+     "server": {"type": "unix", "path": "'$nbd_sock'"},
      "export": "drive_image1", "tls-creds": "tls0",
-     "tls-hostname": "127.0.0.1"}}' '{"return": {}}' | sed "s/\"$port\"/PORT/g"
+     "tls-hostname": "127.0.0.1"}}' '{"return": {}}'
 _send_qemu_cmd $h1 '{"execute": "blockdev-mirror", "arguments":
     {"sync": "full", "device": "drive_image1", "target": "mirror",
      "job-id": "drive_image1_53"}}' '{"return": {}}'
diff --git a/tests/qemu-iotests/tests/nbd-tls-iothread.out b/tests/qemu-iotests/tests/nbd-tls-iothread.out
index 1d83d4f903b..997789a77eb 100644
--- a/tests/qemu-iotests/tests/nbd-tls-iothread.out
+++ b/tests/qemu-iotests/tests/nbd-tls-iothread.out
@@ -1,7 +1,6 @@
 QA output created by nbd-tls-iothread
 
-== preparing TLS creds and spare port ==
-picked unused port
+== preparing TLS creds ==
 Generating a self signed certificate...
 Generating a signed certificate...
 Generating a signed certificate...
@@ -23,7 +22,7 @@ Formatting 'TEST_DIR/dst.IMGFMT', fmt=IMGFMT size=1073741824
 === Dst VM: Enable NBD server for incoming storage migration ===
 
 {"execute": "nbd-server-start", "arguments":
-    {"addr": {"type": "inet", "data": {"host": "127.0.0.1", "port": PORT}},
+    {"addr": {"type": "unix", "data": {"path": "SOCK_DIR/nbd-tls-iothread.sock"}},
               "tls-creds": "tls0"}}
 {"return": {}}
 {"execute": "block-export-add", "arguments":
@@ -35,7 +34,7 @@ Formatting 'TEST_DIR/dst.IMGFMT', fmt=IMGFMT size=1073741824
 
 {"execute": "blockdev-add", "arguments":
     {"node-name": "mirror", "driver": "nbd",
-     "server": {"type": "inet", "host": "127.0.0.1", "port": PORT},
+     "server": {"type": "unix", "path": "SOCK_DIR/nbd-tls-iothread.sock"},
      "export": "drive_image1", "tls-creds": "tls0",
      "tls-hostname": "127.0.0.1"}}
 {"return": {}}
-- 
2.47.1


