Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156FAC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkHJ-0007IZ-SO; Mon, 11 Mar 2024 14:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFM-0005f6-Lx; Mon, 11 Mar 2024 14:19:38 -0400
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFK-0006sy-4y; Mon, 11 Mar 2024 14:19:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vt1sXPgr8yDTaqwmOIeqN9PRE+J0tiubxFmQ7Ibbvnmx7FgxYqAlQQqeq7baMtJcLUnN2T+nXh4cDXTWUJ0WGlubRWCkKrmDSnkhsxthnEc6ZwZk6I6zMlXAeCDxJK/Fy+xs1wlAf688qLj1pOBKpz8AkJvpaaqARO3wzPbIGvz9cN6oRZqQJ3TtIcrsDrV3icyheL77xFAUsWarG39Lp0Y5hbpJCBLQfLQ4BjSJAC6KqNt1xDE2qmFgcsy74lcKnyKRW++N1jvFf6ivd+ynjP69yCJRXyTp4g5z10zJGw03NOhhPczLQCNOR52tX0jrCnDu6T1VVZ2UA8U4i4PyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iutxc8tg7YChZVrBnNEg2aHUVzHlrCXYIXjWGG/15z4=;
 b=Nr/YFFTzZwbGvveq1C1JhHVerEpx9xm7sDvmjQRH3fjh4zH9igcR+uRpkgvqAXhtB+gEk/pv4XIAJMdCxgR9DaTY+S5sTe6FVbSRcycYDgwQYkXkwyX29Tu2+DXuqRmjAq/8NWtdfDxrqhdLVKEnKf1+WG2xekB6LKN5TUpHvctAKR2A4Zp+UGsNM/g7X5+Q7+ao1vavVv6qaJoGrbQEwErTSY+W8QOW8uXKpw1p5VOO+V4OMj+wO4MQH7xn5DotES3tqod5rltb841FpRTZDOmpglBC/YRZoSoyCDBpVoYIe6bY7/+z5or+EIP6TUqJeSaS8uryGxguI7laP2C04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iutxc8tg7YChZVrBnNEg2aHUVzHlrCXYIXjWGG/15z4=;
 b=rVKor4v9eU+pnpnPb4Uxca2ympFISv/V/8CRwmnyTLPmvY5kvAB9kpesxpe8GuYBq8DADt7T6w41Be0vjtuouPhUeNCSuHJA39KzFEEinc99eMaWpX3YbKo0k3jn8O91YhZDxfWu/QXVxz9Xyw9dNp1E9tDXR2uoqozd035eAtxp8ThIflhDwYOcCn/mtdhZnz9bCY6yNbxq95cNlUJy0jji82rI+OO3ZmmWZmpT9SdHyEXiGJPHkAwsb642SaRsZSuVW/tmtJve6TuxIwp9lXE1/5vu/w/wHmOAuUvUlQhLVPXdg/E9wBcSLXL4/6pfaX7OrIU8taBIAuVuFjQGcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 18:19:11 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:11 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 20/22] tests: Add parallels images support to test 165
Date: Mon, 11 Mar 2024 19:18:48 +0100
Message-Id: <20240311181850.73013-21-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|GVXPR08MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d0d6b7-56a1-41bc-3bca-08dc41f7c004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUVi+rxvMx4KqoMaUvenUXEErTJRwcSQ4TMnZ+ESVf2KAzC4ga6gzr8LNwoSvyBZal35XkO4tewm+pc55eLmLYj7j9P2jNdfQ3TNkiY5aoEI17ilcnQp55m5bQKJd9Wiex9c2LYX7I1QTdg1L4rIl2GLbrok8lVTozPAA8wUk7ITT8LNek+o6KBri4Ft+kebCVM1yOZ47GYzGibOlzmKVxjrwbmy5GD/v+zr8DUrDC+FU3p1Huuv2LlxPGtmj9yQ+sjvJJT/PpgYsnQMtRhKqCA4YBHKUlbdIFfQ/pvrqCkAmRcXPySKyV5MAGTuorhFLz59NgELHrMXykkWd7a7QYmrlcHvn77gnPbPi70iqn/zq2LE1iUbo8gM1FHIzVxjxirATY2hAeu+ENKWr8cocFTnyw9kz5/vlCxAyGmqtsnk7/ubI4FJLGnormuAFAbXZjQCSn3aiLmQzapcr4uNyjfDVAR78M1EZKsYg2s0Q92dtmsAyIqCAw70pFfcQ5kxzL8zSQ4wiSQ1f/mFXQltx9dC9SQKahErI+nl7QLNGI70ve9dC8hii0nhroZsX1f8atq6FADvBkDoYult+aM2dVOmtsNnpJ/R5+jW1H5VLe9aKRflgnLi90nozvKnSAV20ENVZ1tVACc1ScI+IAA8lyFHTsI/VHWmhjsQ/VI3qMr2bTUk7W45+OVRS6A9dUhvWJlGTW821HsPR5TwWh39cMocrltOcEmN3TYHjIUVdLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o7apADC6jAuHQpsF3/QaJhDlOly0aUylQXJwnHwpkDVqUCLdj+n5HXjwhyXv?=
 =?us-ascii?Q?WfZszn11szPwAOU9pQUeAR7L7EoJGGTQM35yuNa52MypEsAqVvi+JF12s9K2?=
 =?us-ascii?Q?+AiN92i/2wdeO99AT5yDUsbe7UlKorTGP4Bcobm533PsFZPo9hkh6Sf4njmb?=
 =?us-ascii?Q?Fafe5n9+rAyE8+jbK8wFnVSRZ4l4lIhyb/PLhuXt6qiU1cpkyG+EGbaPajm4?=
 =?us-ascii?Q?s0K+vV2W9aA3M7YWD71ndtkQ7+TgQWzLmXlXB1m/pcQrJDCfogOgXNZkxvqE?=
 =?us-ascii?Q?nDTssVNUq9SsGCKLQlRjS9klUNCwQFfuqupyfBD6xE/8zuuiuNEDmQjw8thR?=
 =?us-ascii?Q?xo9TrZ+hhDLgm6JBCshjC71igk7INV+a9teSIFk/KyllrK5xXqhXdMwTQBe6?=
 =?us-ascii?Q?FMruOHkYiIIVJU5YXGM2vGDZhmRm9HfhiRw6Lwn4byp6iobfaiHfTg48cRCG?=
 =?us-ascii?Q?DeZ3wj0Qo6VZM8xY7b2/adbm3BN9pt1yBMCugRKN0rilvVqOUhZ5JF6n9A7R?=
 =?us-ascii?Q?hL9ttlEGHS7J4OX/x7aQ6QbXW4cHKK6v22M6Q0lFoovjCazuDxf7PTE5An9d?=
 =?us-ascii?Q?ABNe+VHNfnzjLvDOa2AzlGAWoak7gZ5vfZtSkJzMkDrYB5+/bnN5d9dEEJH+?=
 =?us-ascii?Q?iuv+PJg7WTIwXGrXLS0yVkAIJaun1X0I7fcgu1zTFMNoKqCeoKY7lSz8Ihix?=
 =?us-ascii?Q?i9BqTr1aZlIFpnYylFlxu91H8TNDRbtyAZHUo38acUFoAP7sh10/I4cYEjnl?=
 =?us-ascii?Q?kd5cLs9roHJttPKD8wSlcIjX5BdDzdziEi1/ewAR83PRsDRgicYm72mtb9fl?=
 =?us-ascii?Q?KWTEqLrOmbNjaxhp0r4nuFXn67iQkN4QzdBRvHK5S9Qgb16wo20g1As8staD?=
 =?us-ascii?Q?GIYTCIcuRo8HLi2+aLcGkPqtBa51kTVrapLrt3VF0n6PB4RNyPkTlzwJN/iT?=
 =?us-ascii?Q?cC2syvR59b6sZccdsTeNlnRwAjSr9YNpNYQlSi+s+V8unQuD5AV2HCCjnWzR?=
 =?us-ascii?Q?8b7ZHeyiF29I074P1bz+d8c5X8MvWsGa8G2goxWCMzxkljag87WOmH5JAvE7?=
 =?us-ascii?Q?ANTqbhQWM3qQMP5V1LEw4hVae/h1EsfeDDewwc+E40dWQz3/8gtmZIKHPxTz?=
 =?us-ascii?Q?psEI1qaF8fJYWHa+1nwXW9wiozLbR61HW+JoEjF05aBlYTq/nMVGDRqsrafx?=
 =?us-ascii?Q?MLPrcPKwQblkWmKDrz5FCQKE/YsudQUDVQoSgcR7fRo2T6AZU0vuB5uA1QtZ?=
 =?us-ascii?Q?gS8u8nk55NWxkZnPbgxKHGzhmT0CgJx/MOBP/ciqs44guG4PQsC9APdsyyi3?=
 =?us-ascii?Q?v7eBOKA3C4IJ0a2BgOLc86Lpx8Fbxy0wNX9b1LYBjFB7zUxLSGxALP76zX9a?=
 =?us-ascii?Q?UOlM7rZIWlH/s1hmzlUTm5giAvbCvyjqrEZCsutGNI2MsQ8Fd0hZ9bWPXNo+?=
 =?us-ascii?Q?g5at5dQ8WJ+kGbP7E/AU1LrmK0PONGWL1CdVHYmQJtxwG4/LF6y6tF9vAQTh?=
 =?us-ascii?Q?PXEPjBeBM8zIg1ZrSWPbb/MABnjKMJHAAEVutsaChCmC0WotS1E1bPjtixI3?=
 =?us-ascii?Q?6rtLHjw/EtuSCtHAKQDKzOpXTkwz16M++wWo4vhR4YC/0crbkga5cev2HlGh?=
 =?us-ascii?Q?LtFeYDdSWtP4lOYAfWmdvZ8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d0d6b7-56a1-41bc-3bca-08dc41f7c004
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:11.5287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yo7dTOEONPjMSFxU3vD9qgIAf7uZHTZMqGJ0VJwnjeyINZ7BxlbUBoSCRMmPVW0c+gTBmwWo6ilj1NXQLNpNa0gWJfsdf9vH6ufwo+nK1XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10762
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

Use a different bitmap name for parallels images because their has own ID
format, and can't contain an arbitrary string.

Replace image reopen by shutdown/launch VM because parallels images doesn't
support reopen.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/165 | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index b24907a62f..f732db257c 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -38,6 +38,10 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, disk, str(disk_size))
+        if iotests.imgfmt == 'parallels':
+            self.bitmap_name = '00000000-0000-0000-0000-000000000000'
+        else:
+            self.bitmap_name = 'bitmap0'
 
     def tearDown(self):
         os.remove(disk)
@@ -50,12 +54,12 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def getSha256(self):
         result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
-                             node='drive0', name='bitmap0')
+                             node='drive0', name=self.bitmap_name)
         return result['return']['sha256']
 
     def checkBitmap(self, sha256):
         result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
-                             node='drive0', name='bitmap0')
+                             node='drive0', name=self.bitmap_name)
         self.assert_qmp(result, 'return/sha256', sha256);
 
     def writeRegions(self, regions):
@@ -65,7 +69,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def qmpAddBitmap(self):
         self.vm.qmp('block-dirty-bitmap-add', node='drive0',
-                    name='bitmap0', persistent=True)
+                    name=self.bitmap_name, persistent=True)
 
     def test_persistent(self):
         self.vm = self.mkVm()
@@ -117,7 +121,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         assert sha256_1 != sha256_2 # Otherwise, it's not very interesting.
 
         self.vm.cmd('block-dirty-bitmap-clear', node='drive0',
-                    name='bitmap0')
+                    name=self.bitmap_name)
 
         # Start with regions1
 
@@ -135,16 +139,22 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         self.writeRegions(regions2)
         assert sha256_1 == self.getSha256()
 
-        # Reopen to RW
-        self.vm.cmd('blockdev-reopen', options=[{
-            'node-name': 'node0',
-            'driver': iotests.imgfmt,
-            'file': {
-                'driver': 'file',
-                'filename': disk
-            },
-            'read-only': False
-        }])
+        if iotests.imgfmt == 'parallels':
+            # parallels doesn't support reopen
+            self.vm.shutdown()
+            self.vm = self.mkVm()
+            self.vm.launch()
+        else:
+            # Reopen to RW
+            self.vm.cmd('blockdev-reopen', options=[{
+                'node-name': 'node0',
+                'driver': iotests.imgfmt,
+                'file': {
+                    'driver': 'file',
+                    'filename': disk
+                },
+                'read-only': False
+            }])
 
         # Check that bitmap is reopened to RW and we can write to it.
         self.writeRegions(regions2)
@@ -154,6 +164,6 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'],
+    iotests.main(supported_fmts=['qcow2', 'parallels'],
                  supported_protocols=['file'],
                  unsupported_imgopts=['compat'])
-- 
2.40.1


