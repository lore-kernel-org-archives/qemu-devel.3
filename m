Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EE1C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkHW-0007Yo-1e; Mon, 11 Mar 2024 14:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFM-0005f7-NQ; Mon, 11 Mar 2024 14:19:40 -0400
Received: from mail-am7eur03on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260e::701]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkF2-0006tp-Ni; Mon, 11 Mar 2024 14:19:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIfHKa7l+wd3E06IDy3wJUmc3YmEDqkV+wOAj46J87BMZVJoTraObZTU5M+UJW8Adh6TQAx+8ZVBOOGlheHZrmCtvMMYXCrBU56USdmpOMjDaNodJGTTrA+2BRsjFjfTnmDG1jGXQzlt5P2uGfepegyorZdkfUPRRvjc8OnRFOQK88O6cF0ozQNsSIqphjJZ2NM9E23CLSmulHYaW5s2OtPdGG1RqZOzppqg8C85uL2S1E6jr4KlTDV0ma6QIw7206gW/1ckEinN7Mv79LhW62OQnG+21NBsUobhGSCofnctNYKuKvqwDWGlJX3fDNSzv6zsg5YXEoxi4s/zilUhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylUSNpntRN+gDmFyGythjkA4Aww04xqGG3xhlvzvfEE=;
 b=H/mp7dV8E4xVisAwyLP2fpljEaXLqF0p1zXTtu+GiPmkcrEZKQDFkK8jmLcQuh0lmz7Fteh4ODRVKSA0gEMYiBxdGMuwd4/xghHaNBGIaVrTHE3E4mw8Vn9TbW90OIhaWWszYkkwNGXS7lJWQjS0WZz2AOvBO6z8p39dcBuwDYqyjWx6srJ1TEqxTnERz3bOkfVmbPPuIxpFj+Y7/cbABTXyiEseeCrukOzjSv3hsyRzalit0fRw8dgPSo/vBf8mW3jwUXeVZhQGgqN3pgTRaqAQxmzrAkEI1JjQhRn7s+6UZlpxTy+52bqB6+lf3mngfRRusQhlsG7DGEXqSR1jLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylUSNpntRN+gDmFyGythjkA4Aww04xqGG3xhlvzvfEE=;
 b=UKIEFjQSxs7NxS2YVC1juWYgnCS+316kEkO09jnVOCqNGQ6vAqivlMFiQzzwiz/uKj4RtGRKL9TVWOlCDZqSB1274IC5H/db0oYYUYDysyeOO5r4utQtDTQJYkS5/C2/at1Fu5l8d/1ERGdYqNkz4+NFv7fZk+aXx1MOfgxCzbbWLw7Z2LdfFDXo+TNHv43utM3kxJQYrLynXBnydDpzCxp3Mo5CoIzgYLFyiwtep+lwDIJneo7RDJFV7Xq98oMS/E0YysLyZP+5LNSa840bj38Aq3ULxlf8AA7XIY4ZNBcbWAngE4It1MmCtCreI6IixEf5vH+ZMvdM82lSkKkUlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by AS2PR08MB10206.eurprd08.prod.outlook.com (2603:10a6:20b:62f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:19:12 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:12 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 21/22] tests: Turned on 256, 299,
 304 and block-status-cache for parallels format
Date: Mon, 11 Mar 2024 19:18:49 +0100
Message-Id: <20240311181850.73013-22-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
References: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|AS2PR08MB10206:EE_
X-MS-Office365-Filtering-Correlation-Id: d28c1c79-b4f8-4eab-957e-08dc41f7c077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQ3b3lohJnfo9LiyKnvybT3EA4TkrWW5HNX04v6/OQ9yzFutfVMstM04guiROsnf2eBOO+IDtRLTzFqxmuzgXFpalpVCrgPf2MhaW+kmyypoif01s7GiXx/3XOy1ttN/hY8JuK7S+/Oz0mp1LJmUcu+51s4PwQvIJgobhie03KeabCy5FwHt8k93KZOop0lmOf45KBk5AoAXhp1k3V/phAGU8kugEwWOP+ezI5MrOIyemiJzXE8c8QT1DTtbj0jhbfOQh0jM+JMGNNgVrXPy4++fTL85vWzxDw5IAuKWpYN/b35Z/9RwlAWmahAB+O+z6/3bzLfdrTW78toW3S8DJu/K8YIPsMEkIRH4zxrNEe1YZIiqJArvYrEkL+6hWFQV24WQBHK/kG2mFr9bdz0Sa01qhTachj5e6ZybWci4DILyltN2g9M+knDBnwByLNZFhfHHFmhmxIfjN/G9gSqTU7iohyg9m7wSFcPIhI2IYGG/9hJOZ2YH5zb07xyJ/+tKnb6TRN9zMCfQ6rzbOuQSMxat7lZn8oXnyaS7vZq2TjBvCg0Prf3UjDRabE+A1tn6F4vVDT0u2kGJK7M7d9AlTzMSvUmfz6XTyNaURzMu894QxVgoKppaSYxsHcLbABALAtO+5WuJzrMzIs8YSW28yu8L6OqsYRfw/xPKGg772ZojbC/VC1nGRGcE1hnXDZQ4rErALNgqler0qUDcBYHxFv2R52q6cUhLWC+sBAii/os=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l+PO8JH6vbvQoDXEawn99Db02jg1i/K/6j49b0BkuFvD5b0crBK1IK7ue0X+?=
 =?us-ascii?Q?41fRnFHXzo4dYW13EIGZ0MsydxzO5Mxm//xxi596w314BK15Z3OzTJPe+Ai6?=
 =?us-ascii?Q?lvUSLDz2DMy1FSj5AHif7LxZmRp5pOOo70NVRtRbO43cUSCRc0LWEwxSUVNc?=
 =?us-ascii?Q?AKRq7LbGY993GqxjtknC2Ly5I6GiJJWWTNq5PNuGzNb+qdIeSRdZZNcQ75Y+?=
 =?us-ascii?Q?fNGj7nIMO4pZ3RhLDsFpZlURX6WNfffZsBOaBaJf+g1RoLqWsHGh0a8Ta7WR?=
 =?us-ascii?Q?6lTEnKRRSB+hEfvpTET9dlUi1GfJgbKpNMD09HImIt4tx0Zh10pQtF3y7z+a?=
 =?us-ascii?Q?fZEmVWX2+/DLSiLoU2a28fW1ZmdOnCQbLsUGy/elT10QWL/bz8WuWCP+q6Es?=
 =?us-ascii?Q?dtAn9dq4SmnalnW7gMeRI8WOdJJU7e64Af2+bikee2+Pw100jOF9H405Dxe2?=
 =?us-ascii?Q?UcYBYzn7SrRvz7k6y+FdXJA7gp8YU1cUM0LHRgJaM7HsI3Fi1vR1XYduBsor?=
 =?us-ascii?Q?cwkLfo37AKbG3hjSG0tQ1Ns+hxUq3CWz5A4N4ZpJZaD1oyJp2yOvRG4KF2n+?=
 =?us-ascii?Q?T5fGY0T0MWySd3Fbu7CtEmZtwvIulSgMoc+1RJYgCpJddymnj8wpVCciKAg9?=
 =?us-ascii?Q?QkRpVCn+qukWB/1CvL8RCE+CEbVn9SLr/aU6XctgujeBGwu0gBaVvMFPou93?=
 =?us-ascii?Q?yP92m9QFUZ4rW99izjDgX6ilQcwmqyAdr4RKXmsS9wDNs1LsdWBoBBZ3G6m9?=
 =?us-ascii?Q?xz2I2Qf3FtCKtRZ3e/TfZndZUjoGUlbpdOdTmc4nHLFohjQYRYSmfS6s+sxZ?=
 =?us-ascii?Q?YLd8N6fXhrRI4YY0UU10Dc9VR8rm/5znpdCt8OtQnunW04SVlTZzlYlwRhA+?=
 =?us-ascii?Q?jslMFtunHoDnYd/QPGkNtHsg2XAIMJlcpAkeStRdWsNXYVE60v+DtI4xqMoN?=
 =?us-ascii?Q?6PiBpcgNZmuZ2mzOEqWKK1SZpTeRavKqfYXwQ2r/UY2Yymddq8BS/EoJ0bw8?=
 =?us-ascii?Q?bSnR4rPff4Bp39m54182iwypSHF6i2rIvd5JRZQyQtO8E/TszTrQW/9AQesT?=
 =?us-ascii?Q?Qw5hWjqCn32LvVeExFhgRMhhslxVPRT652WITlecUP3xUeEveQLbBvwNlr3L?=
 =?us-ascii?Q?C9f6Pnc+OHzMo/sOOx+NMhwvhHmJfuDLlm12/ZaTjgp00gLBmRP5BdWQ7WU8?=
 =?us-ascii?Q?dRwjNdBc27rDXiZUid99A93GYpYuHgvmeLzOcPtZSkHqTdF4jhvcbiwqqu2J?=
 =?us-ascii?Q?MNvOaueHZ72qh6VmFdkA4mELWnUakJx2zRYg+jblPJbB1+NYvI8jXRXN+8BR?=
 =?us-ascii?Q?acX1mLoK8V74MfextdWenxfPyAm+/LDMAlsgTr3NdboYukMODiXPfbTORp2c?=
 =?us-ascii?Q?ygTX3wbNwJUzSC+2Dl4bMZPmQJL/o2KAEkztsw6XZju7Zn0iHGqJQge8jdT2?=
 =?us-ascii?Q?VIXV78pzGyvpFBOSfUAyZvZTyBnPp18GIwFstxQdcSCPlXjsawpeZuMS4oT8?=
 =?us-ascii?Q?v/BEx0s+PZ1Re3TutT3CncxIiVyukfVJUKAjvYYD8sOI0AAE3ueNraU3gL6X?=
 =?us-ascii?Q?AeYQFOnWB/RmeBkDjJMkhMwCMAvbUziDEsU6Fr/3X09uy5GhxgK212TWh170?=
 =?us-ascii?Q?AXynEeXFZgGJQNT3Ff3Az+4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28c1c79-b4f8-4eab-957e-08dc41f7c077
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:12.2724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZUxjJIzkPuuWW9NNZ91fgN+eR5ausiHq+Mm1bHwgAt0Xmjs07e8p6SAYopDO+HwqWwSj1yvD5vSlWyivyfTD8MbZicsvWnx0Da9OMlrbTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10206
Received-SPF: pass client-ip=2a01:111:f403:260e::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These tests pass with parallels format. Add parallels to supporting
formats for these tests.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/256                      | 2 +-
 tests/qemu-iotests/299                      | 2 +-
 tests/qemu-iotests/304                      | 2 +-
 tests/qemu-iotests/tests/block-status-cache | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index f34af6cef7..1a4c9c6885 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -26,7 +26,7 @@ from iotests import log
 
 iotests.verify_virtio_scsi_pci_or_ccw()
 
-iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'])
 size = 64 * 1024 * 1024
 
 with iotests.FilePath('img0') as img0_path, \
diff --git a/tests/qemu-iotests/299 b/tests/qemu-iotests/299
index a7122941fd..d8c4399446 100755
--- a/tests/qemu-iotests/299
+++ b/tests/qemu-iotests/299
@@ -23,7 +23,7 @@ import iotests
 
 # The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
 )
 
 nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
index 198f282087..1ebf999930 100755
--- a/tests/qemu-iotests/304
+++ b/tests/qemu-iotests/304
@@ -23,7 +23,7 @@
 import iotests
 from iotests import qemu_img_create, qemu_img_log, file_path
 
-iotests.script_initialize(supported_fmts=['qcow2'],
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'],
                           supported_protocols=['file'])
 
 test_img = file_path('test.qcow2')
diff --git a/tests/qemu-iotests/tests/block-status-cache b/tests/qemu-iotests/tests/block-status-cache
index 5a7bc2c149..ade3d5b169 100755
--- a/tests/qemu-iotests/tests/block-status-cache
+++ b/tests/qemu-iotests/tests/block-status-cache
@@ -131,5 +131,5 @@ class TestBscWithNbd(iotests.QMPTestCase):
 if __name__ == '__main__':
     # The block-status cache only works on the protocol layer, so to test it,
     # we can only use the raw format
-    iotests.main(supported_fmts=['raw'],
+    iotests.main(supported_fmts=['raw', 'parallels'],
                  supported_protocols=['file'])
-- 
2.40.1


