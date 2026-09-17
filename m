Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0D1C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7BIE-0001wV-53; Thu, 17 Sep 2026 08:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7BIC-0001wH-87
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:32:44 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7BIA-0000VD-4E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:32:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1JAXenoYFMhGddkDnqNjEUY1gQ2os8O8Y0McMhJ2sJkH/fQZ0VeNE4kDYpcbAQRPP+ZhE1Yq6P3LpspJRyOORDZBoVMyNsDYJm6t9M5FooawAsEnb7MG81KbF6cRQn9OWHbGfPHRV06Qy9uwB/znMjf3P2AVnexJLYm0K8RYZugwQRBdNki9icEowk3MzZflYO2EHoPvWixVzWUTGyPTII45tc0EsSP5AKTcQE9oaZ90vYSYWdFKDHLFdUjt9sTKHZA22qynN6S+4T8hZX9uj/nTEQJC0ZMNEnkuXN0BUZgokuXfOPHY8JXcQnoSgwEyJXOLmGWR84qyHCXEQtG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MycP9p5XGNghJ0H8rEQNB8c2SEtspbrmn0IX3PUWA7Y=;
 b=AlMjz8/XPnINbp3Zg+dyLvv2bFXLfRif3S+cGL53UXJhuoXNSheakA4b6VEUhDTmoKJhE5bXhPyGWm8So0dVAc8kT9xFVHSsdLHAVsqsairZjbNFsDqVyFgj7a62XyvT/Gah10LuP5/1+KCFsaxzMD9MnEBnbIJNY5Np3j6UikgUN9PqLUDWqWp/fF2w5+/LkeNYzM/Dh2GA4o/GEgopDaV0lfQZKxqYrkpVGwggHaMnvvoACJlWfwkTImtvIgjYRWIKr4H9FlsyE+PpDz4xTIzktSFmyi+bM9vaba9hQuX0LDP/Py5bhpjFoNseL/6wrDoQDLgCUl/7L6WdgJXaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MycP9p5XGNghJ0H8rEQNB8c2SEtspbrmn0IX3PUWA7Y=;
 b=HquAov/C26vrjrOHwVEV0NCXu/oN/jm3dPgkxVx0Ad45RmxLw1x3rfkJS6LVfEHD5GO+0dTD1kwO31foi0lGPpfRhaPZO3wUBJVaOF6A65LlQvSn5MfgoTGRDqzftw5hN7cEEG2UFgZ5770VbEb49z9xUD5J6NvZxuXT+Y3jJrF3gPulXG5x7YbWZk1oohnJOsqjU5g5lvk0bZ1MF4HVRp4xMxXpfOwg9zKq2fB+dfZ9jZXfwAu0x8HMmZK9oe1QaZp+xMRYwO5pV0NsAAMqgxKbah4hyllnjThBH7FHo64+WKPpRy4AObbg0dwqC6oNQ3VJVv5xcfG48Qdy+lA0AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB6599.eurprd08.prod.outlook.com
 (2603:10a6:20b:332::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 12:32:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 12:32:33 +0000
Message-ID: <ed87c09d-f750-4ea1-abad-2777792564a8@virtuozzo.com>
Date: Thu, 17 Sep 2026 15:32:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] migration/cpr: support vhost-vsock devices
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de,
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com,
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com,
 dongli.zhang@oracle.com, peterx@redhat.com
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
 <3e3ba3a6-1437-4b36-b1d6-8434c1005499@yandex-team.ru>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <3e3ba3a6-1437-4b36-b1d6-8434c1005499@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 644dedcc-c9eb-4008-18b7-08df14b7bf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zjZ7V+5ECPmsu6gWrdnw5/+1lgd0+BtCyr/YswG09m2iC7nDobScQ398AibBZMgu/agKQHgkEBVLQ6Jm1Wn8yyunk5rbjq+TIhh4uHzNqehTo3EypP3EZMZ8rUgzV+mNmuUIybYGOZQ65SEvqfEEc69RZx6vPjMnCf1bXKEwrifkdQwXbGvy84GbHL+ZWqGThigGGvdJ9bWY37h7v3Agb5tUxpG7nMjeoN+zFrJdw9UVC7WxxITRNRZrdQh76ogy5JIbQ1np3oZIaIfJjFXY/hHZhSUnOJIHgcdC2YBHlHYx8KLtyeJQOCfK6GaIcnukEx+gjIJW9JlE0vCo51ABrJDm49OmSDAhcigCCJhL49CCjGQaZVNU2oCYrYCa0uTHbhtOoeeXgt4LIUthYb7VQsDKf9g/621Um4rTNYAfxy5fVGElsO51UOatvtBbLGUR5j2Ur6WCQIdQRzpGq0ikpnYqzbKg6fMFGCoXz1sWp5Fp/vYgehccMhxyDLDFw7UpJnBrz4f4wHCI5bgUAtUbePqvVN4LKPo4PzALkICp8MXq0dL2RHMMoDsiwPHnMAcsf67AuE7PcfS4KS9Syi8EY5VzFFkxwhaFHBfQsJuaSUc1CewmrmxwHJXBnUJMIkMzEsD5gHK3jh5XlgkH+FHYrwzKjV3oWo3pOBpbB5egCZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENxclhNZlI3RjRjbkNLamI2c0FaMVBpYmZWVjN4a3Y2QllTalczbm1CU1BT?=
 =?utf-8?B?L3IyWHNBRjJyRllmcTBENDZBcFhRbWg5K0NER1lTalo1bFJDNnE2WmxuV2Jv?=
 =?utf-8?B?ZFBGV2pQZjU4MXZteEo0QXJQUUsvUXhhY2JSbUphcVVIalY5bmpIb0lyT280?=
 =?utf-8?B?OVBPNmRhOWFoS1BKVXFZZUdHdTZDVnhCUVFWd0duU3Q5MjJ3UHJJUnVnazhZ?=
 =?utf-8?B?amJiQW5qNi9lT1RNVmdIcW05VmpKbURkeGNlZWtncmQ1Q3JUUytiVzNhQVZO?=
 =?utf-8?B?N3hYeWpMN2dsVmtWNHBMc3lLdysya3hLZDhDSFpPV3UvakdjWUpQby9JdXE3?=
 =?utf-8?B?NkhDUU02Qmk5U2xlWmwyRGVaaEI4bUdxUkIyd01HNGRDRFFlNUJiNzN3VXdF?=
 =?utf-8?B?VW1hZlc0M2p6aHFKZXhiNTRCcE1CUTNSVG5nb0ZZOGNRWlhkZVJuYzFYaGhP?=
 =?utf-8?B?aE5NMFZXRTlKVVAySWRyakNBa2tqUDViZTI3RGxFZytsbUU0SEVxL1ZHUE5a?=
 =?utf-8?B?cnJyeVdKaER2UFY4V1RLTElESDhPM0d5UGxzbFlCVDFtdFZzekg5Z1k2bDZk?=
 =?utf-8?B?cGRMUEt2dTNLKzBPMXJwOHBqQ3h5R1J0cE5iOXEyRDdvT1RWVHpmRXY2T0xv?=
 =?utf-8?B?US9sZi9hbG1CN09TMmlwUnVLOFliUWlickYvN2Rtb29sZmZvTjNMRVZldzdL?=
 =?utf-8?B?clJ5bkFkOG5LSHJuK2NmSXI1ZUg1SThLelNkclAvblVhdVlBeVJZMWFHaXl1?=
 =?utf-8?B?OTkrSWZGRHE5V2ZhV3BNcFZOUlVQbmVyaHJ0THRqODgwOHZuYStXMEthSE8w?=
 =?utf-8?B?MWpudGJLeDA1aGlqWUNiekF1amNOYXhSa2J3V0x0RXArUzlrSGVXTWhDcitE?=
 =?utf-8?B?bjZ2ZitRY1dxc1RJeDRTRFd1aEhxZmZRQmhHU0NISEFza0YvcFJiaW9aTVd5?=
 =?utf-8?B?S2Raa1QrQThJaW9uOGFaNXowelF0aFRHbW5vZDE1VmNLdXJEam0yY0I3L0Rr?=
 =?utf-8?B?L1RkWHhNQUltQTQ0a3pTZXFmdEhDejEvMnJVV0tBSVo3aG9nUjNvS2hqZk0y?=
 =?utf-8?B?MWFudEl4SnF5Vml1cXBaUWgzNkhjZCt1MVBxSkFBbHNMU2RBbVYwejVUTENM?=
 =?utf-8?B?d1FZc2V0ZlljNGhHODU5L0FadjR1WVZBMEJxdWRsZmhPSkRBNFYrVU9EV0Z4?=
 =?utf-8?B?eGlwdnVXbTFuTW9udk5QeDkwZWVxMjdCb25tYTMwUS8xMmtWYThIaktxRDZP?=
 =?utf-8?B?SnFQYmVvZE5udlJZRXVzbkFrK2dmeHBwaXhGQlNrK0k1YUd5ZDNSSmFiK2pE?=
 =?utf-8?B?STNKKzVLK3FWcVlIcDI5MU1PUmptSytxSXh0akhCQXVhR3NwSTM0RVM2YWFE?=
 =?utf-8?B?MjFqd2JPakkxVnBEeVVhaG0wRnNXdHlaQUNHdkRUTXREc2h0aXFsL1pVVFNX?=
 =?utf-8?B?NFZQbXM2NllOUDN0QWxwRkl2cE1Tbi9ET1gyd0RDaUI1T2FKL1BialJXMlox?=
 =?utf-8?B?S3pmRmgvSFpvbmZaV0s2Q3RtNXg3SDhmT2d0ek1jWEQ2b0Y4MDVnQWNDZWVS?=
 =?utf-8?B?M3hwczhOdmRtanArOHY4VmhlcEExdzlCZnR3dXlCejMxMnRSeDA0SnptZkNV?=
 =?utf-8?B?RVBWUXZ6RFNqTFNqN2VvM3FURTlKa1ZINVFsRXk2QnN1ZWQ0SllDU0owcE9t?=
 =?utf-8?B?aXpxVDNhY2dpYWhTMFFlVzNRd0I3cjc1ckhFZFg5MVM3S2RNaEZLa2YvMWVj?=
 =?utf-8?B?NlJhN2xadEdwUWVjRm1ZZnpkZUpYQWJHRjA1MjRCNWl6dGgwVmNOK0N3SlJP?=
 =?utf-8?B?d2ttVHdCbW5hc0VIYVpBcXduQ0E2eXRCZVM4eElBZzNNTXhMaWhUYW1iYUhR?=
 =?utf-8?B?QVgrQ01ibDBUYTlFNm1GeWd4R013M29wRkZSV1cvK1NYNFMzU2R6QlI4aU1D?=
 =?utf-8?B?OWZWclpCUG1qVlhPNHptNlJzQmRWMW4zZjZKd2ViTnBUVy9hNkdoTS9vMmdZ?=
 =?utf-8?B?eFN5bDk3MG8zd2JNSHJtOW8zV1R6YjBWUmhwa0FORkFWNlNCQ2tkbDR6cWRY?=
 =?utf-8?B?YmZtSGtodTB1WWI5Smt3VnFrTnhLcDN6MDh3Q0pHQ21pMytueU5IenF4SlBM?=
 =?utf-8?B?bFQ3QnZ1QlpQUjVvYk96Y0QyWlBUUy9kN00xK3F2d2JCdEJaQnlCTG1yQmZW?=
 =?utf-8?B?S0lUK1BKZjdMNTZ2YnFDeGlhOTFSUG1vcW1IVXJYMUMwRnRBZllTOGc0aXRx?=
 =?utf-8?B?Q1IzaGZIUE5CMXl6YklGSlIvZmZOZUZXZmlVNE5pVlZSNDA2bmpucU9nM1Ax?=
 =?utf-8?B?cERaQ1B1czI0MzhqVUxCUEtqb2lxUk5OeUFNY3BIcUxJZXBPNWVhOG84M3BF?=
 =?utf-8?Q?TINjLmxAjJ7P9Ve4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644dedcc-c9eb-4008-18b7-08df14b7bf81
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 12:32:33.6766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnDH7oBmPeMPvyxaeJ7PoWoiENJluSVwOtEa5X/xM2x/oOVWMW7JeKHqg5eHJmP+pUi+0UoPKMNQcKWFXdJEoxBQmUlb5LbFzCok6Fa5iGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6599
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

On 9/17/26 9:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> On 15.09.26 23:59, Andrey Drobyshev wrote:
>> v5 -> v6:
>>
>>    * Patch 9:
>>      - use the device path (qdev_get_dev_path(), i.e. the device's
>>        address on the bus) + "vhost-vsock" suffix as the CPR key instead
>>        of the device ID;
>>      - drop the device ID requirement altogether;
>>      - introduce 'cpr_incoming' local here rather than in patch 14.
>>
>>    * Patch 14:
>>      - lift the CPR blocker entirely instead of keeping it for ID-less
>>        devices;
>>      - skip RESET_OWNER in .pre_save() if the ownership was already
>>        released by a previous failed CPR attempt;
>>      - reword commit message.
>>
>> v5: https://lore.kernel.org/qemu-devel/20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> Andrey Drobyshev (14):
>>        migration/cpr: forbid saving duplicate CprFds into hash table
>>        tests/unit: add test for duplicate keys in CPR FD table
>>        migration: forbid snapshots in CPR migration modes
>>        tests/qtest/migration: add test for snapshot rejection in CPR modes
>>        vhost-vsock: block CPR migration modes
>>        vhost: add vhost_reset_owner op
>>        vhost-vsock: don't reset connections during CPR
>>        vhost-vsock: fix FD leak in realize()
>>        vhost-vsock: preserve vhost FD during CPR
>>        vhost: factor out vhost_dev_init_backend()
>>        vhost: make vhost_dev_cleanup() safe on a partially initialized device
>>        vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>        vhost: add vhost_dev_is_initialized() helper
>>        vhost-vsock: hand off device ownership across CPR
>>
>>   backends/hostmem-memfd.c          |   5 +-
>>   backends/hostmem-shm.c            |   5 +-
>>   backends/iommufd.c                |   4 +-
>>   hw/vfio/container-legacy.c        |  17 ++--
>>   hw/vfio/cpr-legacy.c              |  10 +-
>>   hw/vfio/cpr.c                     |   6 +-
>>   hw/vfio/pci.c                     |   5 +-
>>   hw/virtio/vhost-kernel.c          |   6 ++
>>   hw/virtio/vhost-vsock.c           | 193 +++++++++++++++++++++++++++++++++++---
>>   hw/virtio/vhost.c                 |  57 ++++++++---
>>   include/hw/vfio/vfio-cpr.h        |   6 +-
>>   include/hw/virtio/vhost-backend.h |   2 +
>>   include/hw/virtio/vhost-vsock.h   |   1 +
>>   include/hw/virtio/vhost.h         |  61 ++++++++++++
>>   include/migration/cpr.h           |   2 +-
>>   migration/cpr.c                   |  55 +++++++----
>>   migration/options.c               |   7 ++
>>   system/physmem.c                  |   5 +-
>>   tests/qtest/migration/cpr-tests.c |  36 ++++++-
>>   tests/unit/meson.build            |   1 +
>>   tests/unit/test-cpr.c             |  98 +++++++++++++++++++
>>   21 files changed, 512 insertions(+), 70 deletions(-)
>> ---
>> base-commit: 5f664cd37aec17e8145aa117d8da68f507edc8f1
>> change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a
>>
>> Best regards,
>> --
>> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> Hi! Don't you add a test for new functionality?
Hi Vladimir,

You're right, there's no dedicated tests yet.  Basically there're 2
levels of testing:

1) Launch QEMU without a guest, with the device in question, and perform
a CPR.  Here we just test that QEMU survives the CPR op, i.e. that FD
and device handling is fine from the QEMU side.

2) Actual test would be launching QEMU with a real guest, launch
host<->guest data transfer and perform CPR during that.  That's what
I've been testing when preparing this series.

As for the guest, AFAICT there're some functional tests which launch
Fedora.  So this part should be doable.  However one requirement for
both tests to work is the host kernel having RESET_OWNER support -
that's added by our recent kernel series, which isn't yet merged to
kernel master as of now.  So whichever Linux distro you run on your host
now - it doesn't have this support and is not going to work.

I'm not sure it makes sense adding a test which nobody else'd be able to
run unless they build their own kernel.  What do you think?

Andrey

