Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461BFCA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKL-0003KM-2x; Thu, 08 Oct 2026 06:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElKE-0003Jq-2q
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:11 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElKB-00016n-Un
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvQkuz/l3x6wicLnssuzb5Tc7aIMOwpOPBrYVKoXTuLamFgQabB6tozRYFIBZetkFxaBLvIiIuwYzUIH/b1rFSUJoGFA1/ZhnWZP99goXSGbmCvfRAA5toHbBLXqKhPGyYqI9Dpk8W6CEEDK4SWw+e8axe0WqR63Zr1vOXLpVQ/PzsgGekq3TRGQdY3NWG6vF4murbSCJ1IOM5MkyxDwB6XOdsAEIuGKv3oKV3wdionqSSRKZvvD3P3KSX56cE3hbZHv5tFLvNG4IMxFWZvAhUhXQHGQpfEHOwmhsCI/EStyfP4mm1CemmIdDaGQQI3NCZhZs2V1clEQB4d3Jxgxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9uyq7mQIpionRYH4TGd39qHDkvCHjkKh3DniesFcmA=;
 b=DnGBskrCFZ0CMz3GqQsCUxaeY3vdAuJ6sjVobSF502Cl5fsD0qhrlTQ+Kbc4MKwjsGGX368LtJ+FfJ6gahE59rO+hIx7RkDFZkhe84oPm7L3p6Ee/9aRqBAIGGeuDypvacu9JFk9NF0hQ+tahrpvhM74/Lk+jjgKH0+xj2ABJmBR/FkQ9KPwgm7twAJYTjFvD1CXMKrKQh6fnLA3wyM6p58+F6FyMXa0JxWVpgvJRF83XvIbttc0sJoJwQ2KOO+2hySsqj35havyRVEbwNgPgr+XDHm8SM37x8HlyuhafSoms3SjEzRA5qJ+NQd6JXX0A0HDBkJcCt0vtJ32tBLf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9uyq7mQIpionRYH4TGd39qHDkvCHjkKh3DniesFcmA=;
 b=IBTg+r5zjT3ug8RRCAKO+Afrxf6OF7D2C1cqEiZKtTDOpUfA/jneHrMcj7wDhAFCrTRDfGoRGHxBGxlxiwhq9fMO3l3fD66uSQni7JSRewzbdd4gKmLvakdo0tZSbzoxaq5nG4a6/VpH5kUQkDWtnPGE2dbEkjSnKDkxTyBgV8pAAMxpFS93J2pk+H+5OMrDHVie2hn+tdWkXdzp2g1FZAPaGMvAFHCkBYMnfsQgmC61sqP/8cQ0ogcU2YWB0SZP2sQemluk6q4V0RRRZUV4G+u/Icq7woU0x8vTjxHW9kl6ZJHF5FDkrk3eUeLNXkCuJHN8sifGbkWY5hjAtjlNXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10270.eurprd08.prod.outlook.com
 (2603:10a6:20b:637::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Thu, 8 Oct
 2026 10:25:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:52 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:46 +0300
Subject: [PATCH v15 22/22] tests/functional: cover a cpr-transfer target
 going away with vhost-vsock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-22-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB10270:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f0a6df-fa3e-47b4-3c44-08df25268637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: ZkcpxHkiNEjoeEGZjdWDIJZLpT1nSXhJ2C9Z2yMQB24aqv58yVE6wvK+1DkowuqpJ/MSjEiY7jNemsFfNHqSJqOtmra0H9izo6jaAPgjWvxntaElWVF0ScCITMVzR4e3gL8sEDwU+eWGAc2wPX1PkYovYzOmfEURmExdtU+PWP/4/iRzZ/Ts27rHxEclBTm8hXXS0aUP9GytlPzY/Aa3MjJmK+9pangkuG1Drl4vFr/ipJ1Ao//xb5r/cBtFuHw1pOUMfzYiDq8V4WpWKXC7pK5fcK6AVCtezOwhteohxgTImKQYFKAJGcV4ZH6iTh33k58WGnhsgbsm8YUGbQF9dhgfthWW4bwEHM7A6dALksQte4qTx8kJj95S0hKsdI10Ffy73vX9Sv9OnYZXGO1b6UDOevS/js2KEPs7d95sRGgGBL6svijy5vzdoD2TcZtxiDfueuve/ALhLcRopDHSYBvN/cAP6ApIyND6oUK5KpNx8qt5gehFwqXMu2xxqsUD01JZkWEiSwKv/UUi+GNVSqItRe23TkXnLahRSQ1Nyml73B6Gg66qtdhrrc59BwdsNSGlz2P7MjLtoQ4HWaLwpv9sS+rusrMU5z5fgqdetJaZGUdQ0I8Iii9JPR+ELClV5OJL2XZuBCAG7N7dfkW5n4cvz+Y1caQs9n/K5L25yf1uU1itNXJkXv5h+ew2wB9UF/NhsPdDcYZPnG6aWE05e+1GFwyjVmgqDhBDrg3X5qM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2R0UEVJOFVhRlJkVDBTYURSUXQ4djNCNjdkR3VsbHA1YzZ1NEx3TEZCTGZk?=
 =?utf-8?B?SzNyQjllMXB1ZHpyTXFRb0dOZXBJU3YzSU5mb2NVNTdROU95UEhMamVhd1ls?=
 =?utf-8?B?VnJhVkc3T0dSb3lUdmd1bEZUdzluWW9qb0hYK0wydnYzMnJiRnZFbUNzbDcx?=
 =?utf-8?B?UW4yNjVHOXJtNC9XMFpuRW1pRkVhQnRjNDl5ZzVJQ3N5UjhYU3A2OE1iWjdJ?=
 =?utf-8?B?Wk1vRUJlRXh6RzFyVzNnK0NONmhJRXBKZWlCY3pGdHg4OUo5eGU0QkNaK1Vk?=
 =?utf-8?B?ejNCTUFhY05jUTV3UTl3WXMwUkxaWEtsWTV5MlRqZEdQRmx0VUVyNldIWDdK?=
 =?utf-8?B?R1JvUFpxY3pGVWhuc25HcnFybGRvcWR0OXF6enlYcmFMQ2N6QlV2VWQyOFh5?=
 =?utf-8?B?K1ZycWQySUw4dlpLUHlFVU00RjR3amFBUGVLeFNGSXdrbTY0aWpGcm1adVNn?=
 =?utf-8?B?YW9wb3N6SU9RNW9mVXM0d0hyc05pMzk5ellvTmM4NDdzZFBYUk9KZ2M3TFpL?=
 =?utf-8?B?Y0tZYjRFTm5LVDVsb21tdmxOWVpCRjBKdXNCTkFLb1hRdndlRTM3bzE0U1Va?=
 =?utf-8?B?Q2c0OUpwaEMzR2lxVExiaDlqenV0SUpXS2htYlpXcHlKYWFRc0xhcmxsMU84?=
 =?utf-8?B?N3JlaEhYMW5NcS9vdkwwSEZIaTJTK2NiVEd1R3lEVDRrWitYVG5oNFNPMTBr?=
 =?utf-8?B?bm51SFNpaGd3NlN5cHVJWTRxMWx4eU93RGJuVUdqeU5nRzV5SDVJUWVHajNL?=
 =?utf-8?B?Yk1URTRtSW8rOWMyWWMwNkpmV3BWV1lEYjNrajErSnBDNG0zaG05bEUvYmNr?=
 =?utf-8?B?R2hwelQveUZIb0hOY2JBV2hianlMK1E1UnBESldJRnQwRDl1TUt3czd3ZWc4?=
 =?utf-8?B?NHRILzVwVXM5S0NHZWRqRjFBNUp0eEhocUpFMHJSS2lGeWZjeGNYcGg4NlBy?=
 =?utf-8?B?dFJzay9qT0k2MThST05BaEllT0xNdTRVNHFxV2NuT3kvcTBRNXBKVUEwc1ly?=
 =?utf-8?B?Qld6SHJXcksrWFgzejFSeHdmcDRoVGdnV1Q1ZXFkTUhqVmRFZXJvdmV5WXRt?=
 =?utf-8?B?MEw4VWRvb2ZHUCtvTGVna2lVeUc3SVFSSTl3RTlPNGhoUUhOc1BkL3oxSmI0?=
 =?utf-8?B?Nmh6OTUwZzBOQmo4T2FLS0g0Q3FMY0ptWmV2dVdIU0tRcDdWR1ZDbUpFRlJr?=
 =?utf-8?B?RmhPaHB4THduTERwMUZlS2ZEaUlnY2UveFZxcURRSUs2QzBFZ3Q5N3Q0S0t2?=
 =?utf-8?B?cjkvS2RTV3lvaThZeWppKzJ6TEFyeXpzV1MwRS9ScmZ2TGhEeGsyZkczK1hp?=
 =?utf-8?B?RS9RNHJDdlY4RzlaWUxWcjlta0dzQVdRbVBlYlFOTWRTU2JNakNmMlcxV1Jt?=
 =?utf-8?B?RldzUXZISVN0aEFxampQT2s3b0RlcmF5TlNUNE1QQWZJRjRVekFXbTNscXdt?=
 =?utf-8?B?SVMxS1BxVDd1OTZyQW5IbTRTZ0dpMmxzQ3BUMGVmcHIxa2VPUFI0c0pqbHNM?=
 =?utf-8?B?Wmk2Y3kxTE5OKzhrSlBrNTgxZGJNZFZTZXc5L0FhdWJnRyttNHNBNURVUkp4?=
 =?utf-8?B?UDZsY01EZEh1WDlvdzgzQjNtbUFDTFo4L2xVaHJPekNXazROUm9CbFRJa2JP?=
 =?utf-8?B?bjNJZlVIL3h6Zm9DUXowOG5QekU1TS9td0g3cXRidWVHbnNWa3ZUOEo5WkQz?=
 =?utf-8?B?eXBKV0dNZ2VZbktCZWhzZFFKN1k3dmVaUEhlRDFoOGlHYyt3VmVISEYxMG9W?=
 =?utf-8?B?RkFHaWo2bkRpSVZmSnloKzhkc3RDMFRkdDFCNmhBLzRqQ2M1QlBrTExXL3Fo?=
 =?utf-8?B?aHIwRGxXYzhCbWFPWjI2MS9QejVvUVNaS2l3cDNNOEp4U3ZZeW8yMGt1clJE?=
 =?utf-8?B?dHNzV1NxTGYvWDNIMXAxcE01OWkrQ3ZtTXJMSW4xYlBzcGtodWJjTUE1Wmlt?=
 =?utf-8?B?UjFONVFabnI4K21aa1MwQ3JzOWp1Z1pHUHJsSUZsS016a1loaTlkVEZvQ3Bt?=
 =?utf-8?B?aTRCUVpMNDZPbEluRGhkdDBscEhWWWJZZTlYTitMNmFCSUdkTDZSQVM4VnRF?=
 =?utf-8?B?bjlsL1ZNNmgxUXZCa1dOclg1bXVyd1M5aWZ6M0Z3UWFwUUZuSU1HUk1oV0tX?=
 =?utf-8?B?SlFuNWVKemI3NHFvRDBGQW5OQS90V3BNQmdpR3dtdElQNTlvdm9JdDZFUjZx?=
 =?utf-8?B?YnQ5bFpRbHQ5N1ZSc2tWbkpXUU04dStWRTA5dmhoS3ltckszU0R2SytmTlRk?=
 =?utf-8?B?LytKTlgreTBUUUxiOUZIT2hDaVlORy9sTy9FczNkaHB2bm1hN2xGSk1oT2lW?=
 =?utf-8?B?OTFGK29pTlVDREpMVENCRzJrOTFucEM2Q2pFT0VqbFJmR2h4ZlhPeSs0TkVh?=
 =?utf-8?Q?Ora6H+9Q5Cl0AoYg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f0a6df-fa3e-47b4-3c44-08df25268637
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:50.1790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVuqOY45uxfzSP1B/9S/TodZqOdACzKjsbc0vG2TORoJxv03Xj93Eg8N+FvYDOpTRRmioVCu1hLVyU81qKni+H7X3xn4WvLH7d77q2e97Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

A cpr-transfer target takes the vsock device over in post_load().  Make
sure the source gets it back when the target goes away afterwards.
Three cases, in the first two the target is made to fail the load by
lacking a device the source has:

  - the target exits on the failure (default exit-on-error); the source
    is stopped beforehand, so it stays paused until we 'cont' it once
    the target is gone;

  - the target stays alive (exit-on-error=false) and the source resumes
    on its own (return-path capability);

  - the target loads the state while the source is stopped, stays
    paused and is quit normally; the source is resumed instead.

In all cases a host<->guest transfer must then work on the source.

The transfer helpers get a payload size parameter, since the plain
checks don't need the 512M of the stress cases, and the target start
code is moved into a helper shared with the existing cpr-transfer test.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 178 +++++++++++++++++++-----
 1 file changed, 140 insertions(+), 38 deletions(-)

diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
index 035307fc82f..3ac0a80c5ed 100755
--- a/tests/functional/x86_64/test_vhost_vsock_cpr.py
+++ b/tests/functional/x86_64/test_vhost_vsock_cpr.py
@@ -24,6 +24,7 @@
 VSOCK_PORT = 5000
 
 TRANSFER_SIZE = 512 * 1024 * 1024    # file size for host<->guest transfer
+CHECK_SIZE = 16 * 1024 * 1024        # enough to just check that vsock works
 CPR_INTERVAL = 0.2                   # interval between CPR ops
 
 VHOST_SET_OWNER = 0xAF01      # _IO(VHOST_VIRTIO, 0x01)
@@ -71,11 +72,6 @@ def setUp(self):
                                'qcow2', '-b', self.ASSET_DISKIMAGE.fetch(),
                                '-F', 'qcow2', self.disk])
 
-        self.payload = self.scratch_file('payload')
-        with open(self.payload, 'wb') as f:
-            for _ in range(TRANSFER_SIZE >> 20):
-                f.write(os.urandom(1 << 20))
-
         self.sock_dir = self.socket_dir().name
         self.cpr_count = 0
 
@@ -121,12 +117,16 @@ def attempt():
                 return None
         return self.wait_for('QMP to come up', attempt)
 
-    def wait_migration(self, qmp):
-        def completed():
+    def wait_migration(self, qmp, expect='completed'):
+        def finished():
             status = qmp.cmd('query-migrate').get('status')
-            self.assertNotEqual(status, 'failed', 'migration failed')
-            return status == 'completed'
-        self.wait_for('migration completion', completed)
+            if status in ('completed', 'failed'):
+                if expect:
+                    self.assertEqual(status, expect,
+                                     'unexpected migration result')
+                return True
+            return False
+        self.wait_for('migration completion', finished)
 
     def wait_running(self, qmp_path):
         # Make sure we're dealing with the new QEMU after CPR
@@ -139,13 +139,37 @@ def wait_running(self, qmp_path):
             except QMP_GONE:
                 pass
 
-    def boot(self):
+    def boot(self, *extra_args):
         self.guest = self.vm
-        self.qmp_path = self.prepare_vm(self.guest, 'source')
+        self.qmp_path = self.prepare_vm(self.guest, 'source', *extra_args)
         self.guest.launch()
         self.wait_for_console_pattern('login:')
         exec_command_and_wait_for_pattern(self, 'root', 'root@localhost:~#')
 
+    def start_target(self, name, main_incoming=None):
+        """
+        Start a cpr-transfer target listening on the CPR channel.  Return
+        the VM, its QMP socket path and the channels for 'migrate'.
+        """
+        mig_sock = os.path.join(self.sock_dir, f'{name}-mig.sock')
+        cpr_sock = os.path.join(self.sock_dir, f'{name}-cpr.sock')
+        channels = [
+            {'channel-type': 'main',
+             'addr': {'transport': 'socket', 'type': 'unix',
+                      'path': mig_sock}},
+            {'channel-type': 'cpr',
+             'addr': {'transport': 'socket', 'type': 'unix',
+                      'path': cpr_sock}}]
+
+        target = self.get_vm(name=name)
+        qmp_path = self.prepare_vm(
+            target, name, '-incoming', main_incoming or f'unix:{mig_sock}',
+            '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
+                         f'addr.path={cpr_sock}')
+        target.launch()
+        self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
+        return target, qmp_path, channels
+
     def transfer(self, guest_cmd, host_cmd, cpr):
         """
         Run a socat transfer between the guest and the host, and keep
@@ -160,21 +184,26 @@ def transfer(self, guest_cmd, host_cmd, cpr):
         exec_command_and_wait_for_pattern(self, 'wait %1; echo RC_$?',
                                           'RC_0', vm=self.guest)
 
-    def transfer_both_ways(self, cpr):
+    def transfer_both_ways(self, cpr, size=TRANSFER_SIZE):
         """
-        Send the payload to a file on the guest's disk, get it back into
-        another file on the host, then compare.
+        Send a random payload to a file on the guest's disk, get it back
+        into another file on the host, then compare.
         """
+        payload = self.scratch_file('payload')
+        with open(payload, 'wb') as f:
+            for _ in range(size >> 20):
+                f.write(os.urandom(1 << 20))
+
         echo = self.scratch_file('echo')
         connect = f'VSOCK-CONNECT:{GUEST_CID}:{VSOCK_PORT},retry=10'
 
         self.transfer(f'socat -u VSOCK-LISTEN:{VSOCK_PORT} CREATE:/root/data',
-                      ['socat', '-u', f'FILE:{self.payload}', connect], cpr)
+                      ['socat', '-u', f'FILE:{payload}', connect], cpr)
         self.transfer(f'socat -u FILE:/root/data VSOCK-LISTEN:{VSOCK_PORT}',
                       ['socat', '-u', connect, f'CREATE:{echo}'], cpr)
 
         self.log.info('%d CPR migrations performed', self.cpr_count)
-        self.assertTrue(filecmp.cmp(self.payload, echo, shallow=False),
+        self.assertTrue(filecmp.cmp(payload, echo, shallow=False),
                         'the data came back different')
 
     def test_cpr_transfer(self):
@@ -184,29 +213,11 @@ def test_cpr_transfer(self):
         it and shutting down the source
         """
         def cpr():
-            n = self.cpr_count
-            mig_sock = os.path.join(self.sock_dir, f'mig{n}.sock')
-            cpr_sock = os.path.join(self.sock_dir, f'cpr{n}.sock')
-            target = self.get_vm(name=f'target{n}')
-            target_qmp_path = self.prepare_vm(
-                target, f'target{n}',
-                '-incoming', f'unix:{mig_sock}',
-                '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
-                             f'addr.path={cpr_sock}')
-
-            # The target listens on the CPR channel: wait for it to be there
-            target.launch()
-            self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
-
+            target, target_qmp_path, channels = self.start_target(
+                f'target{self.cpr_count}')
             with self.qmp_connect(self.qmp_path) as qmp:
                 qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
-                qmp.cmd('migrate', channels=[
-                    {'channel-type': 'main',
-                     'addr': {'transport': 'socket', 'type': 'unix',
-                              'path': mig_sock}},
-                    {'channel-type': 'cpr',
-                     'addr': {'transport': 'socket', 'type': 'unix',
-                              'path': cpr_sock}}])
+                qmp.cmd('migrate', channels=channels)
                 self.wait_migration(qmp)
             self.wait_running(target_qmp_path)
 
@@ -217,6 +228,97 @@ def cpr():
         self.boot()
         self.transfer_both_ways(cpr)
 
+    def test_cpr_transfer_dead_target(self):
+        """
+        A cpr-transfer target which exits on a load error after having
+        taken the vsock device over must release it on exit, so that the
+        source can be resumed afterwards.  The target lacks a device the
+        source has.  The source is stopped beforehand, so it stays paused
+        on failure until we 'cont' it.
+        """
+        self.boot('-device', 'virtio-rng-pci')
+        target, _, channels = self.start_target('target')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('stop')
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate', channels=channels)
+            self.wait_migration(qmp, expect=None)
+            self.wait_for('the target to exit',
+                          lambda: not target.is_running())
+            self.assertEqual(target.exitcode(), 1,
+                             'the target did not exit on the load error')
+            qmp.cmd('cont')
+
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+
+    def test_cpr_transfer_target_quit(self):
+        """
+        A cpr-transfer target which has loaded the state but hasn't been
+        started yet may quit normally, and the source resume instead.
+        The target doesn't unrealize its devices on quit, so it must
+        release the vsock device on exit.
+        """
+        self.boot()
+        target, target_qmp_path, channels = self.start_target(
+            'target', main_incoming='defer')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('stop')
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate', channels=channels)
+
+            target_qmp = self.qmp_connect(target_qmp_path)
+            target_qmp.cmd('migrate-incoming', channels=channels[:1])
+            self.wait_migration(qmp)
+            self.wait_migration(target_qmp)
+            self.assertEqual(target_qmp.cmd('query-status')['status'],
+                             'paused')
+            try:
+                target_qmp.cmd('quit')
+                target_qmp.close()
+            except QMP_GONE:
+                pass
+
+            self.wait_for('the target to quit',
+                          lambda: not target.is_running())
+            self.assertEqual(target.exitcode(), 0, 'the target did not quit')
+            qmp.cmd('cont')
+
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+
+    def test_cpr_transfer_failed_target(self):
+        """
+        A cpr-transfer target which fails to load the state after having
+        taken the vsock device over must give it back to the source.
+        The target lacks a device the source has, stays alive on failure
+        (exit-on-error=false), and the source resumes on its own
+        (return-path).  Then vsock must still work on the source.
+        """
+        self.boot('-device', 'virtio-rng-pci')
+        target, target_qmp_path, channels = self.start_target(
+            'target', main_incoming='defer')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate-set-capabilities', capabilities=[
+                {'capability': 'return-path', 'state': True}])
+            qmp.cmd('migrate', channels=channels)
+
+            # The target opens its monitor once it has read the CPR state
+            with self.qmp_connect(target_qmp_path) as target_qmp:
+                target_qmp.cmd('migrate-incoming', channels=channels[:1],
+                               **{'exit-on-error': False})
+                self.wait_migration(qmp, expect='failed')
+                self.wait_migration(target_qmp, expect='failed')
+
+        # The source resumes by itself, and vsock must work on it
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+        target.shutdown()
+
     def test_cpr_exec(self):
         """
         Perform consecutive cpr-exec migration during vsock file transfer,

-- 
2.47.1


