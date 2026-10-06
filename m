Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BBECA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMwQ-0005Yk-J3; Wed, 07 Oct 2026 04:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHlR-0006TH-Bm
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:30 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHlE-0004ok-R4
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:12 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6oot0rzZTTXd7ejetU1u+8LdMP7tHPwFWEbeWLa4aYLdM1iOZY1v09v07lwcyw6Pv+Aw1h5ocG+Ohiy02R8lAYNGNzlPABW3s0mGueHkEZ7Spe1lo1MVG/sTcktSpMe6lgXTHa9YEQBPyMQbc6Z/2/cTCbQ4M0WxYHAQgXtysQE6sGHzYilOrcvn+ffwU1nFZTh5SnYqj3dbSeEtK0HBAgCJ1sJBXws6OtHAoua27Hx1MrufBAeyA2AfYCv9k3bzIsEn6cZi9DoBBv3KDpMJFDXpcFFV6hh9WTUC1ZcscpKd01UDdJM42DUWs6dSJRTgquG5cr326YmtxjkPimwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=PmaExn/Me6y6eLV3AFXmpKwUhALPjSt9FaPU0+dLHlKfGV+zFmJ6ZtrpXMOx4Kn5cBKf7iayJMChGeknbubnDDAiaJNxZKRAgTe9jpo/t3HGrr7+XyfnmVuTs3mfahU8wHdG4mEfDq1wmSEh7aCMGeSjtym1L+uQg4TZKtEGJ42dAFwgu7v0P6gM9ZxqXg89UemwCRsGRYj8EDdgfcXe4diK/BqCyh3yG3JBxHK8nMqtoZOuafbiSt+U3WeGHcncu1lrNAMJdZMc2xmFTolTViZn9CEnxf23+5yAaeDGtHbuS05yFF59hwc8bLLQ+dZM8j01B6FsbIqoqrOpyLDAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drAKAesrt6zn3dVVGT8tS0Fff5fyaU2GIsx2Yzp7c0c=;
 b=0ZSVCwSByKBaaCxMzmHMpbSYO2L/k0AIY8uKWMuKBd7K+ESaRmRRbWgnhv1p4B4B45rF9a9t/99/E8H79Dmh9+2Sm3Yk8LicZLoNWxoeGfyzLr7ojQDHKEqJHez/VArOBjbkwuKHeYsE0vvAJdqFHrwHSOdN+Ro6yTCXtEbojzX10uG6mOC9b9bEX6lp51ZvwrcORyPC0kEohxQNTR1X3a1s6J+cjqV/OzDjFUjvdkM9WXnZ4WkvY7Iuf6Hzk6Mhzs1eI+K46yGRNt/V+Ym+nv+piqSo3HNWi/A6+mX6ffITIBDJ1Mj7FvoW2yv/cZWlI/ES/cn3CcWqFSdK/TW26A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:59:03 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:59:03 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:44 +0300
Subject: [PATCH v13 21/22] tests/functional: add vhost-vsock CPR test with
 a live guest
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-21-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: a41fdd96-b675-4b9b-cf23-08df23b1fa82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|260925021311599003|260925022911599003|260925021911599003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2Qxfc8VZhb6KVnsBdbTf9xjGXNzHu5eq1cJStDigWzNKeEyZ3A3k2LAEoYssqyhZddpEXpZL6Lf9eb6+EpaLm0UQBkcmAITIGGm+PiVq73esHSfI0rih0Gn319KuRSyFdAZzXTqPS+U6Pok9Fl43XCLXSAvfUGBooov3f7j59GucTmMSDUbL/TXyjsjfhmzfcNqAsYAhXni50Q5iMqtxGe7ILK4R9+RHnz703PqE8donhtbwBvGUGChLZIe5aeiB73uxhu6Tlx1oXh3/gdxuCc6k+Or3OQNaH2QqJhwxzh0F+KYYrb9oUrfZKFmroj5cPA8XMa60hWDCQIAJbtj55fwx2diy/0fL6nVczo1SkdMMoTlN3g3VjFzEo4OQL0PFtQ1J6KFo4aBhWpO90JV/X/BygLvRfDiQQYf3niTWcHkULTCwsfg/p3/blP+1AuoiJApjjOd4nN+eihJBSCXkUK4y3UONi3hBS6MbIxp/CIY/2MsQJ3CT99JNVywr6ssrPwNzT/oqILW3k58WtKnN2u8mN5RM+Wkgln3VsOGEFNEHpSH2/aQqHh1viGgMJaERxrFh0z4Dcn5MBVvjIdJvp7gYSCKsZXqYpVIMv2/eeFnjvW5mobLKYNjC2NGrInaTMsPhELucSAGTe6jkkD6A9+L0ffrASf4iyfWJKWoPRlsc6916RzQ/4Acf5oRaz0l3DP+TYIJGy9wAM5thMUJ9+nzhT4gRbQpPJWMhTGGvB/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDFmM3prUWxVc0htU2pubHVsb0k1dStDUTJwUGRjZFdrcExjc0J3c3pFWE82?=
 =?utf-8?B?b3YrbmZTS1laTVZzalBEUnZmd0F2WU5FRTFYNVVsWWNTMHFZdEo0eDJxcmNz?=
 =?utf-8?B?NDFjQUVib3ZEQTZOTG56V0c2YzdTT2dSNFlGMHVlOFROUUlIaURRWVhrd0Zl?=
 =?utf-8?B?SWxjNnh2VHVUWjN3UFZtZmdrL3ZxY3BxYjh1eGlVV3BNb3dLUnNuQjRlWit2?=
 =?utf-8?B?aVJOcDhFZWJUTmhnN2tGVkFaOUNxNXRLZXl2aXRuNExLVVo3MzZjcXdyazhl?=
 =?utf-8?B?bzBnc2FmL0RhaEM4RmZjMGNNbUlYa2hIbXliUGhYdkNWZllMckZTcHpJT0kr?=
 =?utf-8?B?L3dIT25VT2I4VE85dW9BTGpQeGZjSWJVOURRTTh1S3ZJd2pMR2hXU3dwYkg1?=
 =?utf-8?B?d3E5aWlzVXVDeTdiRjFqWVdRSUM2bWRyWnJLZGprcy9uK0V1SWMyTklJNGg2?=
 =?utf-8?B?M2ZtTW5iK1dTOXZsVVdlVktvdHZ6bURrZ1M2Z3Z2Q1lIUU1DZTVHd2EvcGI0?=
 =?utf-8?B?bjhtS05ld3ovWUR1R1FsMGlNMkdQUWgzVGJjd3ZFUzlZMEJTV2VpM05STnMy?=
 =?utf-8?B?cFFLMTBvaXhVZjY4OHFiWngvVk9XQ3JYSFp2VnRnT0ZROHBIZFdkSUR4NVJT?=
 =?utf-8?B?YVF4LzdKOXE4OWY0eDMwbGZocWtvdHN0S1lJYXFpVjZpRWRFbzc3YjRHTks0?=
 =?utf-8?B?RmNreTVoTHRySnBSTWVrL3VQVWpDMnVYTUttY3BqMjZNUzRqalNSZVZZcUpa?=
 =?utf-8?B?aEJxeDIwMDcycTU5ZjBOM2MvQkVZWXVlSmdSL3J2UHBYOHBsTXl5SkNaeW0v?=
 =?utf-8?B?bmVadWZib3QxTHl3VWVjc1RPdVhjYlcxaEZzbnYzNnc4UjUwWUdaNytxczM0?=
 =?utf-8?B?ZVowQmxEaXZzSFY4SnRnSzM0emltbkFuM1N6OEgrc1l4aTBsdDJhNkgrVCtO?=
 =?utf-8?B?R0tyV3dCZzFVS2dKTDhKNGdlY3dIY1BYZ1BaVzVKVlZhQWwwY1JzdHhLbW9u?=
 =?utf-8?B?amlNQlY1WDBOdlYrRlRRZmpVVFMrRmNRQ0RQMGNod2VJdmNaVWVFcmlONUxG?=
 =?utf-8?B?bm9tdWlobTAxNzVlM0tBSDJtZ3lUV0VRSk9TLzZwdUd2c1hlV1FHTGFyc3N3?=
 =?utf-8?B?SFArOWNNZlJ3dWQyNmVBVnpUWnhOWjBKdDJONzdIM2ZyR3pKaDVLLzZndmoy?=
 =?utf-8?B?NHJnWFk1MGNhQmQxa0hLNWlRTGVIZ2psT3dMd0srVXdwUE5aZDZaS1IyRmRC?=
 =?utf-8?B?R3FMd0xQZ0NNZ1JKYmxBZUU5QXg3RlVKN015NUt6T1Q4V1llWjNnSEhSL3ZB?=
 =?utf-8?B?K2pybU5tZnc2WDJrNXZqaElHcDNJYy9ZUFdCYlB1aFhNQmdvRnpJR0RiS3F1?=
 =?utf-8?B?R2s2dk5HZkF5N2JtWXNyMHF3c3lzN1VVcC9xZndSOGhpVUxqVXNVM1B1UFVK?=
 =?utf-8?B?OFBKQ3NBWjh4S3l0cFpHSTFnS2xaMVc4UnB3RnV6bkk5QVFVaXMzWFJ2Y3BM?=
 =?utf-8?B?MnMzckpFZUVaNkJwWENQZ01RUzNnM0YwbW9ESExxS1RpRmVmZmgrUjdBaUhI?=
 =?utf-8?B?c1J4K3N1bVpuN29QaXB0VXpQWFNpQWg4d0RzUkRRcnd2ZWNCeVpMUitaRXhi?=
 =?utf-8?B?K3VDWDBqNDRHaWNvcmQxMjgvQmlYV2ZlK0Q1VDN2ZkpzdjJiVTlxMzE0RzRr?=
 =?utf-8?B?TEVsMVk0aG45QzhudHltTzQ2Y08vcFA5Yk1pM2k1aXZnN0NNTnVJZ1BYK1JR?=
 =?utf-8?B?SHBES1Z2ekFCMU03RTJ6S3BDcGwwMFY4eU1XajF4QTZ5SUs3U3NnOEtBMzY2?=
 =?utf-8?B?MWVLTUIyZTVlOHlCZnI3b3JJVjhpNTlyNGZIeE1zWEtCSlUrRmdlbGJYNGVU?=
 =?utf-8?B?WGVzY1F2ZGsycmtWVHlCYU1lcFM3c0tYUzR3V3VqZkVRcTVZcU52VjBWZXVC?=
 =?utf-8?B?SDB0ZzVNdWtaREx3c1VtbVJEVG1uNDcrbTRhZFZOOERyNUoweEdOZEIxM3FQ?=
 =?utf-8?B?YnltazU3elI4OWd6dmRCM1M2c1NJclc2bTlJM0VXb2R3VWY1bGh4VUdKYmli?=
 =?utf-8?B?UFdGQUNoQ3lUaC82MkgxM2ZYK2o3SStKNkJuSitXdUFuTGd5akplM0dNcTUv?=
 =?utf-8?B?a21lRnJBNm01MkIvY3Z1TDgxUUVDNjAxcUE0OFcxbmVRWVpLK21tbnZUMDBC?=
 =?utf-8?B?eENuRFQ3YjZTNi8vU3BocDd0bzhxTStLMTQ2cDdNUTFuZlJOcGpQS3JzcGRa?=
 =?utf-8?B?TXdxY25VZ1ZDU0RWM2VGdk94Q0lIUUdKdW5FZmdGUG5QaTJPeE1Fa0Ivclgr?=
 =?utf-8?B?YURiR2dnUmRCVG5yanRaejBvQi90aFRQRGlTMlVrMjVQSDViYzcvYyt0MHM3?=
 =?utf-8?Q?/U6goGDpQw0bS+dM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a41fdd96-b675-4b9b-cf23-08df23b1fa82
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:59:03.0129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aF7cZmbOKdGxco3QBtA5ntyRmPsm5OK6Bh7jRLVNao+upB8TD/sETSWoh+jh0L0wTH395HaxMnObFtEMfmcpfVO2eTLxZ0qQNgU59kJ3dNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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


