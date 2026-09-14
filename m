Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83244C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62Ey-0004F3-9P; Mon, 14 Sep 2026 04:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62Ew-0004Eq-Qe
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:39 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62Et-0005PZ-RW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yibQ2CkcNCPKFBbVu4d4mX1drUp05FC3uSjdZpL7Ex5uMddcs2JGWiTVOJlwK/lTC6WrYds44whwOnvqQS/flUI0DZt7aMj4nd77ntI/9QrKCPGDipUmzaSnbwgJz0tVXDB3O9DxsIq+7aVC2VJaIcfRr45VE9O4e3K6sEEHsTeRbjS2GYI1Hl9AG0yYoXd1Oc7xm43k1o91fpZVBYcigQBQC6UlYdd20iLbghhFNwi/r0C9sVKZdw7ebt692YL4r7+VFANaaLKGHHktPcYhHujLyh0BQjnqSs3HXf1BYg33DrX9SpPjiRE2sFpoXWjcLJM1k6HFjOb7sfE2h8vC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJoGkUZokeYHS2N52MBvQ8K2P93d9X7r7Hg8E+IMJzQ=;
 b=ykOjXl8vI+ktEZ2DEWOcLIfElloakH+fojfgeD9EkK61Q+5mmtLQiwWUXf5gy/EgTpdbq4m3fS11ls3yx42S6BvU91tSwHVl4S4V1u8+EylSNh9BX8EX3xLpsM+GFE5QdzrXMiY9lK18ue5GAGAeC++tsPju0KWIedzC6z1b+C/sdW9Ji8TUGGZ+oi7InTnOBB9b6dCn0BipFY10nzmtw7NnbIKLMwbt8YdrwdjxelOgAYfCsEj2jc3tX6RIWd87Z4BC+xKN+c+5RblyCOSXaxzXi5ZAm0hHWzw1HlOCtk0wNvxRLHVNFT6lDuPdQ1cVTjL2jayAj5XXjgHk+3P15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJoGkUZokeYHS2N52MBvQ8K2P93d9X7r7Hg8E+IMJzQ=;
 b=LbTGa1jo7fzxLVXX6OkN0qREnGbTZ9x/n6ETc7pdh/A02Wt3HnMeW9IdL7A7BPUygrKciyCX6gp8aklZUQf92+GOt9BBXjFyfXOUwQAtvYTEPVGa2XjsqTT3kKtLhr+XHLVJJkHcHa39qBEP2SOU3gZWV2Nmoy5kz/fU/0UQ1EZquDWAGWKJAkAnkpxSjCvJluv+brdkdCqBYjt0tFx9rfwJ9jMz9Q97mtVklk6xQEeKgTCmPowvrVCO8StECCN9ZCbxbgA8iWr0Vs7VOT/gs9HzLCBX0623lbu2pt/qlJ3zeKhUl4XrrKPDhok1TcPP8E+D5Bo57c3l+9tFdriaoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:20 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:19 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v5 00/14] migration/cpr: support vhost-vsock devices
Date: Mon, 14 Sep 2026 11:37:31 +0300
Message-Id: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEuyp2oC/yXMTQqEMAxA4atI1gZaB3+vIrPQTNQ4YKXRIoh3t
 +Msv8V7Jyh7YYUmOcFzEBW3RORpAjR1y8gon2jITFaY2lS4rxjU0RfD5HTDkCOVle1f9WDJdhC
 71fMgx/Ns33/r3s9M228E13UDYeoYBHUAAAA=
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org, farosas@suse.de, 
 peterx@redhat.com, clg@redhat.com, andrey.drobyshev@virtuozzo.com, 
 sgarzare@redhat.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0028.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: e773270d-7966-463a-17a2-08df123bcf11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: XT9Xunt8pV9qjK0biPFhIupLkXdGE4lZNgQIJAFv2uoB7wtP0TTRGt4xiF/FufNT1FXz2uYmoECfGh0nrd9+o4y0CTcDnk3swfqnhweEMNrB1peOKhUuGiw8PfkvqMG9y9xouFryIpE/HjZ5B1ggkXwbKblpGRnfn1yhEn3E+VSSVHuF/Xy6wHO3fzip2W7IDYaTW+BxZZN5OKFikF82xQBO0/iM8Lqzpag61Fi7gk1sswHJvtoxvK1vqfGgkER8Y/NOSkqQ2kLxZaXoOn1RSVGS4fLgHyxnx7IKaYc46RrhwsE3FmxrKvVWALaYjdgi9w+T3m8S+d+XHjTAQ1g/LGvzQ0t90i9UoFnFOtp+9cC0Q/On4pxB7TtF+YV9Uw3MTb2bZbwoWOa3u4paBViNx/r0Mq4NTg1dZSFT7MMHrZLsH5oPE+ssXnyvX2FIYIOMtP/HKTKhLIiATV6wNXsTVTIKkGOeEwMrW6lUkyaVlyuBxYbnZ1iyD13NDhPPb0/vz9iBoqej5j2XuZiA27wy598JDQhoztK36HVWUz5uywNxY/adl6YfHXWu99Tfw63Eq6LE+a1O7ysQSbHuCXZDkvi9MIC79D36bzUnhbOgHc+ur4tGRBLmnoUbiTcxuyRBoJAAQCWAFkEZxCmsrpQQWgzfswwe2YKHdth5WO+YdKtOkzpN6p/YhQUzw3BZUtBFH3RY0t4s6h4uMKS6Dhwxjnil6AbAYnNvwn0XbfqsFSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBjVmJwMUtxcW1SSTlPR29oaEJ2VTcwR3RGdURlM0dCbzBhaGdGNkNJdkxY?=
 =?utf-8?B?c0ZzSGsrM0V0bWtyeG4vZlFPS1pHY3VNcVZIQ2FoelByQTRKNnF3a0dzczlZ?=
 =?utf-8?B?VWZYQ1NvK1Z1ZUVTS01kWmEzWThjQmtUTmhlZU5rNm1CQlNXZ2NXRkkwd1h3?=
 =?utf-8?B?MG96c0xueUcyZmttS093Mlh6SVhhZHBaZjY3QkdPZjNDall4Nk8rc1dvNkl1?=
 =?utf-8?B?RjNIdm04OUhPN2R6aUpNUlNpVVFUdXpiTDRlSDlycTUvdWRsUXVYcEtUcS9q?=
 =?utf-8?B?NHJxZ0FqSlNrZkN5S3kyOXZ3QVk1NlZtSDJOcy8vcXBVcFZadW4zSnBxSDJm?=
 =?utf-8?B?RGN1c2ErYXVhM01WNWRPYTU0NHUyY0JXM0toeDUzSy9iZUxWRktsQU10OTVq?=
 =?utf-8?B?RXdEVjFqVmhpOHZBNzI4Q0tsQ0Z0ZjcxcURzSnRtMGZ2M1BOOHB3bkdzc1Bs?=
 =?utf-8?B?MEhPR0UvY3lkRklWTmx2OVJIWFlWWHNJbTBFNmg2QkZEaDBLMnQ0OHVXbXVK?=
 =?utf-8?B?TUFwOW1rL3J5SUU1SkdMRVFmcDg1U2NabWpDWUdXYThZV0VZKy94azR6aHBq?=
 =?utf-8?B?NnlISXlGb2FZZ0RvVjV6REdFYVlUUU44NDVJcFg2bWhteVNYVXlmbHlham84?=
 =?utf-8?B?aE1pMGpLd01yYzFuNEY2SWxLSzQ0NXprRzQ4RGtHcjhCcEg1cUxGZGpCR3BY?=
 =?utf-8?B?Z0xndk1qbXBwVUtMR21mQ3QrRXIrbVMvM2VwOUpBZE1QZXN0SWJrSHpZYkVE?=
 =?utf-8?B?VU9zc280RGUvazlla0VzUXNyQ2hDY3RRZ2hzWXFScmZ6S09yelRENkgvZjJX?=
 =?utf-8?B?T2N1UmtRL3pVWFB4Wm1PQ0ZSbHZKd1ZrMy92YVplWjQ5Nk5UTjdrSUF4NVFR?=
 =?utf-8?B?Y0FYMUZtWVV4ZkNyQXlkSGIxVnZzeFR1R1EzRDNrUG43cUt5OE9uR09jMEs3?=
 =?utf-8?B?N0RNRUlRbEVmWi8wYXpHZGdDQjJsdEZLUTQxNUlJbWU5eTZuam9oQmFJRm1U?=
 =?utf-8?B?a0wxUEFHZVBsVlAvNS9zL0RLMWQyR3dYLzVrSGx4NHkwcjgzSWtVWGVBQ1pk?=
 =?utf-8?B?d0R1RVJLVnkwWkdQSXJ4NlVIc1o0WHZyU1dsb09sMWlVN3d6cTBXRThJMVNW?=
 =?utf-8?B?cm4zajZBNTJnQjlFMDRRRnpZRW1iTnRmR3V4SmoxM1RNaFZjd0c1Z2t0NWM2?=
 =?utf-8?B?b1A5VTh4alZhbUE1RTVhbnFtYVV2bTg3WFp4d2J5emRSWGNTazVUMFY2VkJl?=
 =?utf-8?B?UjdnOFozckdKSG5qTndiM0llNTNDSk9DOEV2WGxwZVpJVVRCUTB4OEdxQXha?=
 =?utf-8?B?QVlxWDZSckVXUS8yd2ZwNlpYVmpZUDE0MEVIZlhIOG11Q3JXdFR3clVNNVBr?=
 =?utf-8?B?MytrWjhxRjhUVjhJSWdsV3BqK1FMbFV2cFpJYmNsa3RWU3d1WTFrSzlSbGdD?=
 =?utf-8?B?ck1XaktJVlJmM2pQL25GOFJSM2ZBc0pBN2VYMmtsTi9kY0kvTFlmMmNWSFVu?=
 =?utf-8?B?Mm5qSHVVd1ZkTkJsR2lEZEE3VTFMY21VTi9tU0VhKzdvamVlbWgrbFY5Z1c1?=
 =?utf-8?B?dlJWVHNWSitqd1FIRDJ2VzNrQlNOM2Y1WlFTeTFUd04zN0FZeEFNZFFVUDJV?=
 =?utf-8?B?OFhYK3B0aWNCTE1HTVpjMWRBYi82NXhWckt4SHZyYzBVWW9pa2FoUGJCOE9C?=
 =?utf-8?B?L2Y0TkdUSTRBa0lFS2s4cERzOEd4V0tKcUFzL0hXL0FwRkpLMTRSVnF1bDE0?=
 =?utf-8?B?Rjc0WlhocUF4RDlXWkFVZlFBSkdTZVptUGdIcGJTSE5WOTRZSVdKRkNsWkda?=
 =?utf-8?B?dE1nSEtQSmtlNTdUSlI0VkNXcEtWZmVZeFFMcm1IaDJrZUtYNW4xMkkvQ2hB?=
 =?utf-8?B?Zy9KdU0rek5aeEVqc1RrQVVFWUJxR3RtZDdYMHpoRVhhcC9ycndZWFY3NStH?=
 =?utf-8?B?aGo2WDZwM0lncG9kYTJ2b29BdUwvdFZMRU8zSGNrZU9waGI1MnhYRjlMSWF3?=
 =?utf-8?B?bDVxOFdNWWIwdEFReGtoTHFId2M3UGxQNVFPSFlJOU9sTVNMcmVMZWw4bE85?=
 =?utf-8?B?YitVdHRESWRHNzRJdXlaeGNRRm9qb01LVi9BZ05HNExSUHArUnAweGlGb3B0?=
 =?utf-8?B?MHFjNVkxdUVRcjVReS9qVzJobEIwdkRZYjcyYVZnekZUV0ticCt2NlZEWWQ1?=
 =?utf-8?B?QXFJcmdSVFFkZTZ6bFdHYk9BQUZHdzZOR0g3OXdEZ1JReUNGbVBYeDR0K1Vm?=
 =?utf-8?B?eHZYbnZrOGdVYjFYQzVjQjZEWmFDQ3haN0dSWkk1eUtvS3FJdDlCWHAvL0ZE?=
 =?utf-8?B?cGxjUmtZVEFQSHIyNG5nWUt0cE1FQzBFU0VUQlBoQXJjd3R6czFQeUhQbEQ1?=
 =?utf-8?Q?EjpeHWEtbk4BaplE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e773270d-7966-463a-17a2-08df123bcf11
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:19.7808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Bv+y0geXl7BTSfmdfa8cCk2Uv5DHSNDjJT9E5BLklnBMq8vpcy6MR5v4K24ZjRDZv/amOzxHeEWhKJ1rPN4Jbf6HQDq5vGNWenD91z3YVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
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

v4 -> v5:

  * Patches 1-4 (NEW): fix bugs discussed in v4 thread
    - migration/cpr: forbid saving duplicate CprFds into hash table
    - migration: forbid snapshots in CPR migration modes
    - add tests for both

  * Patch 2 -> 6 ("vhost: add vhost_reset_owner op"): add separate
    vhost_reset_owner_op typedef;

  * Patch 4 -> 8 ("vhost-vsock: fix FD leak in realize()"): add Fixes tags;

  * Patch 5 -> 9 ("vhost-vsock: preserve vhost FD during CPR"):
    - add "vhost-vsock/" prefix to CPR key;
    - fail .realize() if cpr_save_fd() fails;

  * Patch 7 -> 11 ("vhost: make vhost_dev_cleanup() safe on a partially
    initialized device"): reword commit message;

  * Patch 8 -> 12 ("vhost: add vhost_dev_set_owner() /
    vhost_dev_reset_owner() helpers"): split in-comment docs;

  * Patch 10 -> 14 ("vhost-vsock: hand off device ownership across CPR"):
    - drop FAILED notifier;
    - re-acquire ownership in vhost_vsock_set_status() start path;
    - gate RESET_OWNER in .pre_save() on migration_is_running();
    - add cpr_delete_fd() on every error path;
    - print strerror() instead of raw errno in error messages;
    - reword commit message.

v4: https://lore.kernel.org/qemu-devel/20260820113955.509478-1-andrey.drobyshev@virtuozzo.com

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
Andrey Drobyshev (14):
      migration/cpr: forbid saving duplicate CprFds into hash table
      tests/unit: add test for duplicate keys in CPR FD table
      migration: forbid snapshots in CPR migration modes
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
      vhost-vsock: hand off device ownership across CPR

 backends/hostmem-memfd.c          |   5 +-
 backends/hostmem-shm.c            |   5 +-
 backends/iommufd.c                |   4 +-
 hw/vfio/container-legacy.c        |  17 +--
 hw/vfio/cpr-legacy.c              |  10 +-
 hw/vfio/cpr.c                     |   6 +-
 hw/vfio/pci.c                     |   5 +-
 hw/virtio/vhost-kernel.c          |   6 ++
 hw/virtio/vhost-vsock.c           | 218 +++++++++++++++++++++++++++++++++++---
 hw/virtio/vhost.c                 |  57 +++++++---
 include/hw/vfio/vfio-cpr.h        |   6 +-
 include/hw/virtio/vhost-backend.h |   2 +
 include/hw/virtio/vhost-vsock.h   |   2 +
 include/hw/virtio/vhost.h         |  61 +++++++++++
 include/migration/cpr.h           |   2 +-
 migration/cpr.c                   |  55 ++++++----
 migration/options.c               |   7 ++
 system/physmem.c                  |   5 +-
 tests/qtest/migration/cpr-tests.c |  36 ++++++-
 tests/unit/meson.build            |   1 +
 tests/unit/test-cpr.c             |  98 +++++++++++++++++
 21 files changed, 536 insertions(+), 72 deletions(-)
---
base-commit: 35500e5c41aec76cde59befe750600dac7a9e37a
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


