Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE08CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcuR-0000q3-02; Fri, 02 Oct 2026 09:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuA-0000nN-GH
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:27 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcu8-0007Qg-CL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4AW8ElrbjpLjS5z+rCfXGj7bXad9PY066X1GR7V6+DWyI597uC6VLPYaYxO3ZtCI907NNDsoA3mqO5JAfzvlGHbeYmkXEyvMknb4xDX0KOr1PFJhT3lPuC+fdfjOqLSq3/7LND+fUfz/o/hCWjvMPrzdixKtv0sr4qn7C6Bjh0ShrKX+hjivnIsrnCUFIjXj5ClNNQpLL3QAHheUC3eah18hSUnW1Vh+GuOI9fz/gPEUvNGIomjbT7rWiiVfpFs8Plwihx6oMJ49K8PoWy44GCPjH5I4T5kAGEKOJQLArnIOImiZ0cwEDnRXHsXCPXO0y9jg+i6u6LFsSxT9fhuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEP5MPmDn///wtzlJnIV36BEUONZRsHiYB7A86CHfL4=;
 b=S+ZIPtY/NzACyW3YxVczje/Myh83ovKl05gDphn5Xh/PlKFG9z+4HqhdHdKgPwwdPVJwYX9cfWT8Eysha2CiKQ2WtnPUjsNgtWH2CdI12wXSZnF8UzMaQqkNXkSacA3+47VpbllFSdXE9cijN04REinyEKnb9S37HTCdopuC+pNQNv6IR7j1tWYo25BRXlVqHdkHV2ldiR/FV03+/2iakwqwASzgO1ZmklKroa6V6Y10WyiwVhGzbrp6NQFewmZHFSaJOLHjeB5RZIW9+7QGNmQW0uJv7jRHRp1Be5dni5b7RqUhc9cc2O0veeHEb/yt6mKUDmaqlz32Aen08rMhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEP5MPmDn///wtzlJnIV36BEUONZRsHiYB7A86CHfL4=;
 b=qj+6HZlJs9LF4RA+DBHFSIn7n1UNmPEvma3Lv4ksklDbNrGnM4s0rORY+YNjUc7mRYVkYFOd7JiaiUxCx0oaJv095Lzu5YEJNts1egyzbt9FARlDDrCQH4HRqSxXwerYpIgnNHxv0OfYkSTdoFpKH+5SRDZqqnquDX7LfQLKMYxpdRkmTbDlnEW3ZgEYu5gqLnXA1f4OgiEinshEsGNQEB5L9HBRb1HznAbdxVknHAvCEGcXE2qVnGjV0xefGJwRHmxZPkBSUJb6Q7DZ5SR+BbbvvTa8Iyro5mb04Dgf5rAkSveMpRZWQlwKZaGtTrZ0oxOb8ch0PmwZrWc8OAoEdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:20 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:19 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v11 00/19] migration/cpr: support vhost-vsock devices
Date: Fri, 02 Oct 2026 16:02:09 +0300
Message-Id: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFGrv2oC/23QwW7DIAwA0F+pOI/JBkJwT/uPaYdAYGXTShUSt
 LXKv4900xRNSL7Ysp9l31j2U/SZHQ83NvkSc0znmiA+HJg7DedXz+NYC0yA0EBg+HLhJSf3zss
 p5ZmXjrveoJUU0OHA6txl8iF+3tHnl588L/bNu3mDto5TzHOavu5bS7f1/fqoGn4N4CP2SsjOU
 FDmqcRpXtL1mh5d+mDbjqL3StdSdFXUKNGK0ekhjC2l3yutW0tfFe0D+QBSOtm1FLNTBLUUUxU
 U1tWfgTVqaCm0UyS0FKqKJyAdtKC+h5aC8McgALYYhOoYB6SMkp6M/e+s6/oNIWTziikCAAA=
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: 7265c3e4-076a-42b6-a24f-08df2085643f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: CR6wD3pXMe8Q+KsK7IhVAkN9189amv07QQCWeAGGsUBC44gj4AHdq2jcAsFYQHSuVH0xUtLFfcfv6w/Tw9D1YJsTHKJkBtrUJGntVxmojNBxV26s6NO9cKch+XYd2N5ps5koP40pm+wbZqKA2gsh4hfNWtwWpOS+GoLRkI62uBfJJYz6fZ1flW1Bpq6C5rVHqOvukLqvRffho7Y+/9F4EaQZ02aDxIsQQtQczn27HE5AhNVBqPsr10w/w+awUzFqxMkxBrJ0xfkP4Va238NPiHTpFl7GeA0EBYRH3cI4FvneCExsc0dpOS2H392V4mhCe8vCM8stiwbLKdeol8gSHVt/OdLiWtxMp3Meq6NC4v+PL7iSTOR1OSpRyN47vO5CeRt5ZwIpEXw22psK0+bFthk/MbM/fDPijPpg4wpP5ugkT93KGqLYMNl71GZkmfn2VtWzp4EuQyzjd7Bd6tI3DAqfFStPhrS7KcybgjiCYqhRmKagP6kdsAT6EywxLFoTxJ1rOLKt49esZTYJ82yxiUMKH6ry4aKyev+NF53wkaH3cWq4YDIN1KRaknc9oeiy80AU8McfsfLN0cKKSiuni2BhpQn6AYdw6vLvfmwH5kWIGnB4+y/u5ivpakV09/xhCXf8bPf3bLZOYVJ1pFG7vl+ibUDEBn/4SJFcsRQ0P5qkI3AtVtoc9s5vmgV3J/BJodaaGvbPawGsTuqPN/Xswuin6k9c+YnZqTc6Bpkk8Zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDdtVXVLZDUrOWtzS2ZhTFZmZUxyY2tKMnNkbFN3OHlEeVJDeUF2NEZSNWs2?=
 =?utf-8?B?ODlmT3RST0c1cTMzMjZFRmFpS3NTVUVuV2dCWnZCeXVnOE9KVmlrVTNweDE2?=
 =?utf-8?B?dWdjNi9XRlR1WWw1Ulh5b3NjM1BvVURUdUpzcXdqeHArSk4zb0FiTWxvSVRE?=
 =?utf-8?B?VXRYYW9LaDAvM2tNVnEvNk5wK1huaG00QldSeWhpTnNYTWpxRVFIZFJMMkNr?=
 =?utf-8?B?ZVZJYnFaYjFFa2pJbXpkdVN3MldEM0VBNm1RUWRPYWk4WjRDbEtnbmpCUVF0?=
 =?utf-8?B?VGdDOXc4SWRHVnV3QmJVcFUrbndKcHRNUjA0QjJvZFJDdE00TmZETTZtMlhT?=
 =?utf-8?B?T1ZTRmNXMTc4MzRMYVBIS0k2N0JKelhVeWw4QzhxQnNEQTVFS2dmMlVpWkti?=
 =?utf-8?B?Q2N6c2FkeXlYVUlhOHlSZWcxL0NBWS85Mk1QbkU1YUpJc1ZlelBlOUtXR0VY?=
 =?utf-8?B?K0R4c05WSTFhK0tXaDF5WnlWeFNZbDZ2VGRRa052ejV4L3NMdi8zQUJVd2cz?=
 =?utf-8?B?RFpXTGs0YkxBTjQwYVF2eVVoVlVxblhoRHk2aENiZm9CS1lpRGYvT3U0VVZa?=
 =?utf-8?B?b1FtSGRaM3pvY1g5ZUdRTmIxZG81bW5hN0s3N3ZaRHN3cFdVUTZiUjRWV291?=
 =?utf-8?B?alE2bTBCWTVVQ3FpUkVsZTloV0U5VlBDeFdKZG41TXhhaXd3bGRwVFJCQWQr?=
 =?utf-8?B?aTBJQWovZmpjemFqc3VwVE9YZ05mbWp1WGU4dFVoTE1wdDY0YlpVcEE3enVy?=
 =?utf-8?B?VlAySVcwaE56SlhuSm1xdWZCL3dxaGhQdW56OFF2YkI0QU5reWo5bXBOYUty?=
 =?utf-8?B?MlpLTS9QSFhYcnVDWkwwUzV0U1NoQzMwOEpkc0d1RkhaNDJVRGpkM0g4OXB3?=
 =?utf-8?B?aGs2OGFhMy9wMzhjQ1Z6U2ZrRExONnE0NDlEUHU5UzFvdUM1T0t3ZGNPMFVH?=
 =?utf-8?B?WTZGd212VnB5ZFhxcFpuQVltSzFtRUNXbytSM0kyN1dLZjc4bjRDczY0ejZk?=
 =?utf-8?B?elhVTzZjRUxHYTZuTEVCM0grbUt2c3hZV1B4b3FSTWE1OC9mMmtLSzVOWm5T?=
 =?utf-8?B?R2dBSllBZWZrUDFiYno3em9iTnFldW1aU2pMNDh1QzBaZnJ1c2pOL3ExcUky?=
 =?utf-8?B?OUVpS1JRVUJIZEc2R1NJSk9xK1FHQUtIV25BZS9qVlV1T1dqcUlVMTU5UENj?=
 =?utf-8?B?Q2M0UWZBRkczRlJYc0N0YXJkK1NrMXpyWE1yN1p6dk8ydDZrU3hjQURZejFD?=
 =?utf-8?B?bng2R1dEQm1ENzhEbTM4U3pLOEE5SndTZDN6YmFqZGc3WmlyM0hzZ3lVV3B4?=
 =?utf-8?B?RTlBaHZrdHQ0SVoyTmlmaFVaT2VzZFNadVI0Vm9uOW8rL2RpaDJmNjVaR0Vh?=
 =?utf-8?B?ZDZpSDdmMWx6Qm16S1JKSFdwNUNnVEh0YmdXYkhTc0xLa1Zqa2J5em9FdDYz?=
 =?utf-8?B?QzBFV0FOc1R5RVhMcEg1RkxISmZNV0VzakFGYXE2QWRRTGNpYTkrRy85Q0c4?=
 =?utf-8?B?MXlFcXN4MDdLREV1amNndmFJdkhRQUYyeXBhQ2gxeGhLNk1KeHBRY3lxRUgz?=
 =?utf-8?B?cFRubjJ0K1dvNEhIMlBXNGttSU5wVVBoaFVMTTlzVDMrTXgrSzhDM3g3dWJw?=
 =?utf-8?B?MTNSSTRPMkorYVI4Q2szRE1UVHA4K0UwUlJFTTgrTG9iN0RYMi9Pc1RiaFQr?=
 =?utf-8?B?ZVJzRGFtY1VDWU0vN2hCanhFclBoREp4WUxZSTJyQlNkRThmRVh3OWlYYzY0?=
 =?utf-8?B?QXBYT0RCLzdLd3U4cmRVdU83aGdodUZRa0tQNk5McWVQMGtaSUJIMDJoL0FB?=
 =?utf-8?B?aEhIaDROZnVDak9LS05McU1yVFlGeFhBMkxmbCt2TXkxcENpQkNiSE1hTVhx?=
 =?utf-8?B?cVR2RWhSSm9LeGFHLzVmRXBpeTh6M3ZyZ1lxdzF4c0luYzF4MFNHR3R2NTFB?=
 =?utf-8?B?b1RMU2dBME41V2NVaUg1WnZpblBoTXppclV1bjM5Q3dpRTRHT0l1OUh3K2dx?=
 =?utf-8?B?dTU1ZThJNEoyQ1JJbXFrU21vOVJBaTVXQnhnTE5BWG1IUXVXM2VxN0YrTUk4?=
 =?utf-8?B?SzlBSkNDTzV1WW5FN2pJekxQRGY0SHpnK0NBWkY4Qkp1QnJXZjJzam9nMmla?=
 =?utf-8?B?SFh1Z2trVFJaSWZSNEJxUGtvVWlGbWpHMXUweVFFdHd5VUMrVFpvSVhZc3hH?=
 =?utf-8?B?RGczWmlXNVdwTVJUclNnZVlRMFdKbDdwOUh3QVRGSDNEZXhaZis1R0pJeVlT?=
 =?utf-8?B?VE9WMlVRcGw1V24zUC9wRU1SeG55WWgzeUhFcW1ZZDB2dHU2NG1tZkFwRVNu?=
 =?utf-8?B?dnhRZEc0VHlickw0YjVMRjUyVFdvS0hhVXhYMDJWdVFkc1BHQ2hsS2hSN3Jy?=
 =?utf-8?Q?qWkqNVJT+9Lx+luc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7265c3e4-076a-42b6-a24f-08df2085643f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:19.7095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gT3uAMxW6Gir5194vxW14oqjfXa1PHNvzuvagU339IPTfOQWLZUj0XkLxhRHx/1enK5d5EYn5oNIqgarrxgF+XkYprzNDV1R8yHttNu6xY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

v10 -> v11:

  * Patch 15:
    - track the ownership with a new 'owner' flag in struct vhost_dev and
      release it in vhost_dev_cleanup() only if it's set, so that a device
      whose SET_OWNER failed doesn't release the ownership of another one
      sharing the FD.

  * Patch 16 (NEW):
    - release the ownership on exit as well, so that the source can take
      the device back if the target dies on a load error after post_load().

v10: https://lore.kernel.org/qemu-devel/20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
Andrey Drobyshev (19):
      migration/cpr: forbid saving duplicate CprFds into hash table
      tests/unit: add test for duplicate keys in CPR FD table
      migration: forbid snapshots in CPR migration modes
      migration: forbid snapshots under Xen
      tests/qtest/migration: add test for snapshot rejection in CPR modes
      vhost-vsock: block CPR migration modes
      vhost: add vhost_reset_owner op
      vhost-vsock: don't reset connections during CPR
      vhost-vsock: fix FD leak in realize()
      vhost-vsock: preserve vhost FD during CPR
      vhost: factor out vhost_dev_init_backend()
      vhost: make vhost_dev_cleanup() safe on a partially initialized device
      vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
      vhost: add vhost_dev_is_initialized() helper
      vhost: release ownership in vhost_dev_cleanup()
      vhost: release ownership on exit
      vhost-vsock: hand off device ownership across CPR
      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
      tests/functional: add vhost-vsock CPR test with a live guest

 backends/hostmem-memfd.c                        |   5 +-
 backends/hostmem-shm.c                          |   5 +-
 backends/iommufd.c                              |   4 +-
 hw/vfio/container-legacy.c                      |   7 +-
 hw/vfio/cpr-legacy.c                            |  29 ++-
 hw/vfio/cpr.c                                   |   6 +-
 hw/vfio/pci.c                                   |   5 +-
 hw/virtio/vhost-kernel.c                        |   6 +
 hw/virtio/vhost-vsock.c                         | 193 +++++++++++++++++--
 hw/virtio/vhost.c                               |  98 ++++++++--
 include/hw/vfio/vfio-cpr.h                      |   7 +-
 include/hw/virtio/vhost-backend.h               |   2 +
 include/hw/virtio/vhost-vsock.h                 |   1 +
 include/hw/virtio/vhost.h                       |  69 +++++++
 include/migration/cpr.h                         |   2 +-
 migration/cpr.c                                 |  64 ++++---
 migration/options.c                             |  13 ++
 system/physmem.c                                |   5 +-
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
 tests/qtest/migration/cpr-tests.c               | 133 ++++++++++++-
 tests/unit/meson.build                          |   1 +
 tests/unit/test-cpr.c                           |  98 ++++++++++
 23 files changed, 919 insertions(+), 81 deletions(-)
---
base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


