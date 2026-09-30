Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44612CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJm-0000mO-56; Wed, 30 Sep 2026 06:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJk-0000lx-VX
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:40 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJi-00045T-NV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg6D9zuKOLxnPWV7goZ0TrPk0exmaD+0WR9l/6FCLUnfLLOZQ6G+Xlf3ZhfJJpM7+82s6sRmlOWKMCc9h8RIOsiO599OPD5U9nYZT/N3YxkD0FieTGhUGaLY3guzIR4mIp5JVA8o2ZwXAI0zWoowlienNFLhfGnCrokwHAfiuU8tRsN2udLga+sysojwBZg+1lDjnE0Q26DTwOowEdX2q4pJ6xN4kzm2g+gj8jREOHlZSc2HKZTjribk4uP3E+IGBUumPcx84PMy9QRi8FuElijuIgKwqxuI9mbjHZ7aaNxRCCVwyTApuvhNvnoiyi94789Nc1E1157XbdGXAs9+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=kdRzWaHZjHcJCblWAePe6BHQy0p2Ncz8Np7Y4ZRLvxsWSrvMQWc5ISKoG2Aa/KzUjdXsUJ6YkVYIzvJdK/+ULjY9j9DSI0LyXy7BaWun2IeaM76KnAjO+bqCFqSBYfpSaDYnj/3hL9yWB2Z15486GVVb9iaEM5vleIuF4377KPBn+lbxfSsmS+UEHB0p5OJjE1l4p4r/51iv4DIH2hQG2hQYWOhOlYgd/IKOUP36ZzB/HRL/IHy2beLZR0g0lvYAhQS8ItJPYappMMVbSR64NHVNyc9s2edfNIedJYO6JhqYyzCPcgKUgLPuvAZUnbnExi/MFiqYhmjlgQYk2Rl9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=v+sgi5wV12kMPTsN/gS1MY00poWwtLjTFGZBfZiUhGgiFGSaGlpziR9iISeHy+vE/40y0WWMLET+9/U55PfFFWCijB1yZWZeUmYoF9xoviYTT08SKGHp8bTjUA7NeySa/PoIiqGj/f5lIyYnQEU0UYVBttoXr7clSXMlj55rclbth3j8pMXlnLBsDC3zXCDxuyK30Oa6LoHUFjB+9QiYsrHx7WcL0ibP3dy8MmPaxTk3Z/8LuQYtPyP/NoDowezBD0mL1BPGaFXa7KWiCx2RKG5wbc5X/FCjRxS5z2FEddff1oCTp4ZCMzpV14erTGOb4s4tuuXO8rKRfocYkWA00w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:28 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:28 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:17 +0300
Subject: [PATCH v9 18/18] tests/functional: add vhost-vsock CPR test with a
 live guest
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-18-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 219b0489-7157-4f27-5377-08df1edb78c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|260925022911599003|260925021911599003|260925021311599003|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: fQ5FvoMRbzXYmVlXEoo9KNcrgMNNqJquwkQPeV1LNLJSFX9+4Iy4MaMKADN9UjUXSTZCaX8x+fFQmVvjKFYweP2OLTj+6fdVhhLgeDI9zXpGPrM1AO/LRGYbj4yN5FTqVbbYOBDMT2pf6JfnwdTA5antV5XciYKHdJ2K3T0GuLtIwHr+T6sJAezc7ft9/gzXKV3oE4QdOeGADp5wpO46RvYQtXOL/y/vbJtVs6k1u0ne3l4Mp9KG7PtL4sSPHKXJQzSbC1MVIR6BHzXJ0qqA8EzQ7PiZcy5z6fz6KY7XlCpOngUHlZxeirx8BzMej5EyoTDHiKxzYA8CSwsuT2oL2W/cxbVJDDTR/OFVQB2k4WI7GTq6ZfqAz3hy9JEAuqVWfHHUQqt+AFnAX9301vPm9Nfux/my8yRqaWbv5LL+HP3blO+171qyLYFohInPwgyvctLUlfPEhkjgiYXXds2/uvII8UFyc/r6sGCGaT7/qGJJA0HP5awbOKNJAQ+6ssCuXSD1cZshdv+CnxGS6nNtezVqVzGTJwvXChS3GAZJAQR0JErX9G6FoxlgCTLMKFswn2DycODwc6M1sirxFySwx0aOLMsyPltIObT+O3l1EOYpOnWqvUY4vA8VolRLDMYuEw4CG8646vchKtBDpHlCJECA6zclequNLtkNAnSjQjNOU7iRQDH6WeVv0UlWBmBovbiaZD9uOqP2PPd8ozxZISNi6W6QnXdaG4319l4CqE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(3023799007)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxKWi9YWTVqaVk4V3BjUlpWdUIyREtsQVg3TDRHcWd2Z0ErYTg0cndqQWZW?=
 =?utf-8?B?ZXJOajhaUHlsTjduM2poQWZDRmNhc09PMUI5Z3lYMlNndyt0Ni9vNVppMTh4?=
 =?utf-8?B?S0dleWZ5dGczUG1QcWdyS0U4QkIyRG5SbGNUWjVEVkdxN0pmNlB5eUFGT2xY?=
 =?utf-8?B?czQwSjZDWUM3MmxsbFVNVjFUNXlOQ0pGNndTa2JBdTQyblpmSFB5YXEyanN4?=
 =?utf-8?B?aUloL2dHamVrWlZXL1NTc1Z4bDFLeUZzQ0JtaDBzVHAvZTVXNXE4L2QxRXNr?=
 =?utf-8?B?d0YxWWNZaDIyRjIzVUZjRWI4aTIzVVZhNHhmOGQ0SG5LWWY4dXVxY2Joakcr?=
 =?utf-8?B?M1FnenVYQ1RYRlF5Z1VRZ2VzRTN2SVdZTDI4WnFzM1NqZVRIUGNPd2JTRHh1?=
 =?utf-8?B?NFFEUWdHSzJRVHBBVDNjUkxQVEplRHZvQXRyTDkzS3ByS3N6dHB6K3RtTG9k?=
 =?utf-8?B?YmFPbVVLWVA4NlJkZG45R3J2bWxPendjWUZralFacVM4SnFCckJpQUdMUFZX?=
 =?utf-8?B?RXBLUnFPbGZzMWVYQU8wd25kYkY5a04zM29XSEIwTEppQVJQVzVEcjF2WEIy?=
 =?utf-8?B?T09ucjhuOGUySGhlbWlkMU1zVllDUzBhNWFzMEJ4cWFPcTk5Y2h4dHhqL1pp?=
 =?utf-8?B?alpCdjZzN3p5bm1MNmU0ZDNUTjZZNndzYzh4VEpjcDlaM29jM3pNWGdsRExE?=
 =?utf-8?B?ZkYxUGlYQmErYlNncFpzSGtUQ3NOL280L25lMTRmdWpXWDFyeWFqdVNLbFdO?=
 =?utf-8?B?NWhHVGx4Tmx4SnBPczZlOURIOFBjVTJERkpFOGtwN2ZhK0RBVUdvZHE1VUhM?=
 =?utf-8?B?bFM5aDdzdFhlMjZoaXZVZU1VYUdKSGw4Y3VoWEVTWGxrdkJGd0JlaEppVDMx?=
 =?utf-8?B?NEQ5OEZPNUh4bnFpQllWdzJpazcwZ0R6MW4yTWFUWFR3a3dmVWNLNkkyZ045?=
 =?utf-8?B?MGpGcVlzNW9sbFlOck9kdmRUZy9qeWh5ejdNQlg2U2lnYmFHQ1NKczlIWEFK?=
 =?utf-8?B?c05WOWRDalRCdTZkbXdLbUdaS1BTaXlFVzIrMFEyUHVzdi9tcHpqRVljNlhI?=
 =?utf-8?B?YW9QS2EyOHVpS3BrYnAwelUzN2VOMFg4Z01BaGk1NHM4UXNKNFIxTkN4cVZG?=
 =?utf-8?B?T2VMaUJoZFlKL011YnlBVGJDWGRjOG5zN3RiOXd6SnJ3RElUaDJRbDAwVnlO?=
 =?utf-8?B?WkRSVmZURUo2eUlSSWNmTGh3U2swRDV3SmY3eEsrMmc0Z0NNa3VXa0t4T3NL?=
 =?utf-8?B?cVV3Ly9nQ3FPdFNUV1FTV0RIbzBnV3A1bFl6ckxCbjFpYzZLMHg0ajhtUFVp?=
 =?utf-8?B?YzFzUGVMVGpGdW5FSnkrL1pIMjJBajc4R0hmVEVKRnFSYzJjZ2gyamZkWHpz?=
 =?utf-8?B?T0RKUmQzQkpOcGtrdUFaOFFOdDU4T1JkKzNmT0IrYzhBS29DeXZPZ0JBK2tv?=
 =?utf-8?B?dDdjOG5oMjd3a0srYlBkN3hxNEcwOXl0UndDNjFFSDVCV0FBUm1Qb05aUWVL?=
 =?utf-8?B?RTVmNHkrNkJaUVRvRVJJQ0VGN3NIWnZodUEwS09rc2lINVZIN0UvVkNYU0ZE?=
 =?utf-8?B?bmRiUTB4bzRVMWJxR2Rzc2RPTEpIdkdBcGhzdUVLa3EvUEtIMVZLRUtLM3Bk?=
 =?utf-8?B?ZktlTXg5OUc5T21pbm9oU3BRSlRZL3A4U0JpTTRqWjBqRjQxVm9CSldwT1hr?=
 =?utf-8?B?MUdyS0J0MjRMUnJONVBIVEhnV1dxVFZLVXJzNGd5N3l4Wi85blJPL1hDVGdU?=
 =?utf-8?B?WVFnanRFVCtNZ2d5aWlGa3BQcXdsSHQxYlUyb1hRVGRPeHpnQXJ0TWJoWjhm?=
 =?utf-8?B?Q2ZCcmd5bzFkR3UwRlVmQlNQZGIrOHB3eTVmazZyWDdRL2h1WXB5dHU0WGxO?=
 =?utf-8?B?UDl3bUd2RG5JczEyRGZ2Q3BOUGtLd3RYa0k2eHIyYkdvSEdFTmJmd0JNd3M3?=
 =?utf-8?B?NVRDVDlweG1JYjBHa0huajJnSE4rdlhNT2V3Y2FYU1Irb1BmWXF6NnYxYm1o?=
 =?utf-8?B?WjhTZngzK1ZBYWRJamQzeXJCZzNlZU9wTEF1cUJ6WXRxRFR3UloyeTNaWVVx?=
 =?utf-8?B?aXNjL0NMZWlSQks0STBsZUpjOWZJMkpzY0VDWXN0REFKVHNPbzRWRTFXa3Mr?=
 =?utf-8?B?M2d5ZFFsRll2OXhHT3NuUEZnd3d1M0RUOGdsUkhvN1dxMkRxWVh2RytSVTRa?=
 =?utf-8?B?K2lTNW5oK0VXS05DZkp0UHZCSVBNSWJXTC9CN2FZcGZ0V3QyWTFxZ3F1Q1pr?=
 =?utf-8?B?dkM4OWVMSUVTWlJDdGlJNlEwcHdWOHErekJuZkNHeGZ2MHlnMTdhNU85UDdw?=
 =?utf-8?B?Y0paU3BMYTFOWmloR1gvQmxjeUxad01ZckJqYVVkNTdiamdMN0NUeFlMYUFh?=
 =?utf-8?Q?VLbHXbDMQ2fSJ0Vo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219b0489-7157-4f27-5377-08df1edb78c7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:28.4073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4DU2j/O9h8zF1LHpoNVj3WJukBo+MIPlQ8Ce7HmrspTNwPpmsmwkwm5UhnnUJC23PHDL73hzfoDsmvqNg5Q6yoRW0bdyqLrYpngmN3xe+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

The qtests only cover the QEMU side of the vhost-vsock handoff.  Add a
functional test which runs an actual host<->guest vsock transfer across
a series of CPR migrations, for both cpr-transfer and cpr-exec:

  - the guest is booted on top of a qcow2 overlay shared by all the QEMU
    instances it goes through;

  - the host sends a 512M file of random data to the guest with socat,
    where it's stored on disk, then gets it back the same way; a CPR
    migration is performed every 0.2s while a transfer is in progress;

  - with cpr-transfer each migration starts a fresh target QEMU and
    retires the source; with cpr-exec the same process is re-exec'ed
    over and over;

  - the file received back must be identical to the one sent, and both
    socat instances in the guest must exit cleanly.

The test needs KVM, socat and /dev/vhost-vsock on the host, and a kernel
supporting VHOST_RESET_OWNER for vhost-vsock.  If any of those
requirements are missing the test is skipped.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
 2 files changed, 247 insertions(+)

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 0353b2af8e1..718bdc5195c 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -7,6 +7,7 @@ test_x86_64_timeouts = {
   'netdev_ethtool' : 180,
   'replay' : 480,
   'virtio_balloon': 120,
+  'vhost_vsock_cpr': 300,
 }
 
 tests_x86_64_system_quick = [
@@ -51,4 +52,5 @@ tests_x86_64_system_thorough = [
   'virtio_balloon',
   'virtio_gpu',
   'rebuild_vmfd',
+  'vhost_vsock_cpr',
 ]
diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
new file mode 100755
index 00000000000..035307fc82f
--- /dev/null
+++ b/tests/functional/x86_64/test_vhost_vsock_cpr.py
@@ -0,0 +1,245 @@
+#!/usr/bin/env python3
+#
+# Functional test for vhost-vsock over CPR (cpr-transfer and cpr-exec):
+# a host<->guest vsock transfer must survive repeated CPR migrations, in
+# either direction.
+#
+# Copyright (c) 2026 Virtuozzo International GmbH.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import fcntl
+import filecmp
+import os
+import subprocess
+import time
+
+from qemu.qmp import ConnectError, ExecInterruptedError
+from qemu.qmp.legacy import QEMUMonitorProtocol
+from qemu_test import (Asset, LinuxKernelTest, exec_command,
+                       exec_command_and_wait_for_pattern, get_qemu_img,
+                       skipIfMissingCommands)
+
+GUEST_CID = 4000000010    # we expect this CID to be free on the host
+VSOCK_PORT = 5000
+
+TRANSFER_SIZE = 512 * 1024 * 1024    # file size for host<->guest transfer
+CPR_INTERVAL = 0.2                   # interval between CPR ops
+
+VHOST_SET_OWNER = 0xAF01      # _IO(VHOST_VIRTIO, 0x01)
+VHOST_RESET_OWNER = 0xAF02    # _IO(VHOST_VIRTIO, 0x02)
+
+# What a QMP connection raises when its QEMU goes away underneath it
+QMP_GONE = (OSError, EOFError, ConnectError, ExecInterruptedError)
+
+
+@skipIfMissingCommands('socat')
+class VhostVsockCPR(LinuxKernelTest):
+    # This should have passwordless root login, vsock support + socat
+    ASSET_DISKIMAGE = Asset(
+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
+         'debian-12-nocloud-amd64-20231210-1590.qcow2'),
+        'b94e3f34db59988a815b33dffc24f5a58502540efece2cc1ed15e0ac8749bb2e')
+
+    def require_vhost_vsock_cpr(self):
+        try:
+            fd = os.open('/dev/vhost-vsock', os.O_RDWR)
+        except OSError:
+            self.skipTest('/dev/vhost-vsock is not available')
+        try:
+            for name, request in (('VHOST_SET_OWNER', VHOST_SET_OWNER),
+                                  ('VHOST_RESET_OWNER', VHOST_RESET_OWNER)):
+                try:
+                    fcntl.ioctl(fd, request)
+                except OSError:
+                    self.skipTest(f'{name} is not supported for vhost-vsock')
+        finally:
+            os.close(fd)
+
+    def setUp(self):
+        super().setUp()
+        self.require_accelerator('kvm')
+        self.require_device('vhost-vsock-pci')
+        self.require_vhost_vsock_cpr()
+        self.set_machine('q35')
+
+        # Use Debian cloud image as a backing.  During host<->guest
+        # transfer the guest will write data to its disk, so we start
+        # it with an overlay
+        self.disk = self.scratch_file('disk.qcow2')
+        subprocess.check_call([get_qemu_img(self), 'create', '-q', '-f',
+                               'qcow2', '-b', self.ASSET_DISKIMAGE.fetch(),
+                               '-F', 'qcow2', self.disk])
+
+        self.payload = self.scratch_file('payload')
+        with open(self.payload, 'wb') as f:
+            for _ in range(TRANSFER_SIZE >> 20):
+                f.write(os.urandom(1 << 20))
+
+        self.sock_dir = self.socket_dir().name
+        self.cpr_count = 0
+
+        self.guest = None
+        self.qmp_path = None
+
+    def prepare_vm(self, vm, name, *extra_args):
+        # We don't want QEMUMachine.launch() set up QMP for us.  In this
+        # case launch() waits for greeting - which won't be sent cause
+        # CPR target is reading CPR migration channel before QMP
+        qmp_path = os.path.join(self.sock_dir, f'{name}-qmp.sock')
+        vm.set_qmp_monitor(False)
+        vm.set_console()
+        vm.add_args('-accel', 'kvm', '-m', '1G',
+                    '-object', 'memory-backend-memfd,id=ram,share=on,size=1G',
+                    '-machine', 'memory-backend=ram,aux-ram-share=on',
+                    '-drive', f'file={self.disk},if=none,id=disk,format=qcow2',
+                    '-device', 'virtio-blk-pci,drive=disk',
+                    '-device', f'vhost-vsock-pci,guest-cid={GUEST_CID}',
+                    '-qmp', f'unix:{qmp_path},server=on,wait=off',
+                    *extra_args)
+        return qmp_path
+
+    def wait_for(self, what, cond, timeout=60):
+        """Poll cond() until it returns something true, and return that"""
+        deadline = time.monotonic() + timeout
+        while True:
+            value = cond()
+            if value:
+                return value
+            self.assertLess(time.monotonic(), deadline,
+                            f'timed out waiting for {what}')
+            time.sleep(0.2)
+
+    def qmp_connect(self, qmp_path):
+        """Connect to a QEMU which may still be starting up"""
+        def attempt():
+            try:
+                qmp = QEMUMonitorProtocol(qmp_path)
+                qmp.connect()
+                return qmp
+            except (OSError, ConnectError):
+                return None
+        return self.wait_for('QMP to come up', attempt)
+
+    def wait_migration(self, qmp):
+        def completed():
+            status = qmp.cmd('query-migrate').get('status')
+            self.assertNotEqual(status, 'failed', 'migration failed')
+            return status == 'completed'
+        self.wait_for('migration completion', completed)
+
+    def wait_running(self, qmp_path):
+        # Make sure we're dealing with the new QEMU after CPR
+        while True:
+            try:
+                with self.qmp_connect(qmp_path) as qmp:
+                    self.wait_for('the VM to resume', lambda: qmp.cmd(
+                        'query-status')['status'] == 'running')
+                return
+            except QMP_GONE:
+                pass
+
+    def boot(self):
+        self.guest = self.vm
+        self.qmp_path = self.prepare_vm(self.guest, 'source')
+        self.guest.launch()
+        self.wait_for_console_pattern('login:')
+        exec_command_and_wait_for_pattern(self, 'root', 'root@localhost:~#')
+
+    def transfer(self, guest_cmd, host_cmd, cpr):
+        """
+        Run a socat transfer between the guest and the host, and keep
+        performing CPR migrations as long as it's in progress
+        """
+        exec_command(self, f'{guest_cmd} &', vm=self.guest)
+        with subprocess.Popen(host_cmd) as socat:
+            while socat.poll() is None:
+                time.sleep(CPR_INTERVAL)
+                cpr()
+        self.assertEqual(socat.returncode, 0, 'host socat failed')
+        exec_command_and_wait_for_pattern(self, 'wait %1; echo RC_$?',
+                                          'RC_0', vm=self.guest)
+
+    def transfer_both_ways(self, cpr):
+        """
+        Send the payload to a file on the guest's disk, get it back into
+        another file on the host, then compare.
+        """
+        echo = self.scratch_file('echo')
+        connect = f'VSOCK-CONNECT:{GUEST_CID}:{VSOCK_PORT},retry=10'
+
+        self.transfer(f'socat -u VSOCK-LISTEN:{VSOCK_PORT} CREATE:/root/data',
+                      ['socat', '-u', f'FILE:{self.payload}', connect], cpr)
+        self.transfer(f'socat -u FILE:/root/data VSOCK-LISTEN:{VSOCK_PORT}',
+                      ['socat', '-u', connect, f'CREATE:{echo}'], cpr)
+
+        self.log.info('%d CPR migrations performed', self.cpr_count)
+        self.assertTrue(filecmp.cmp(self.payload, echo, shallow=False),
+                        'the data came back different')
+
+    def test_cpr_transfer(self):
+        """
+        Perform consecutive cpr-transfer migrations during vsock file
+        transfer, starting a new QEMU instance on each one, migrating into
+        it and shutting down the source
+        """
+        def cpr():
+            n = self.cpr_count
+            mig_sock = os.path.join(self.sock_dir, f'mig{n}.sock')
+            cpr_sock = os.path.join(self.sock_dir, f'cpr{n}.sock')
+            target = self.get_vm(name=f'target{n}')
+            target_qmp_path = self.prepare_vm(
+                target, f'target{n}',
+                '-incoming', f'unix:{mig_sock}',
+                '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
+                             f'addr.path={cpr_sock}')
+
+            # The target listens on the CPR channel: wait for it to be there
+            target.launch()
+            self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
+
+            with self.qmp_connect(self.qmp_path) as qmp:
+                qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+                qmp.cmd('migrate', channels=[
+                    {'channel-type': 'main',
+                     'addr': {'transport': 'socket', 'type': 'unix',
+                              'path': mig_sock}},
+                    {'channel-type': 'cpr',
+                     'addr': {'transport': 'socket', 'type': 'unix',
+                              'path': cpr_sock}}])
+                self.wait_migration(qmp)
+            self.wait_running(target_qmp_path)
+
+            self.guest.shutdown()
+            self.guest, self.qmp_path = target, target_qmp_path
+            self.cpr_count += 1
+
+        self.boot()
+        self.transfer_both_ways(cpr)
+
+    def test_cpr_exec(self):
+        """
+        Perform consecutive cpr-exec migration during vsock file transfer,
+        saving devices' state to a file
+        """
+        state = self.scratch_file('cpr.state')
+
+        def cpr():
+            try:
+                with self.qmp_connect(self.qmp_path) as qmp:
+                    qmp.cmd('migrate-set-parameters', **{
+                        'mode': 'cpr-exec', 'cpr-exec-command': exec_cmd})
+                    qmp.cmd('migrate', uri=f'file:{state}')
+                    self.wait_migration(qmp)
+            except QMP_GONE:
+                pass
+            self.wait_running(self.qmp_path)
+            self.cpr_count += 1
+
+        self.boot()
+        exec_cmd = [*self.guest._qemu_full_args, '-incoming', f'file:{state}']
+        self.transfer_both_ways(cpr)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()

-- 
2.47.1


