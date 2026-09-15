Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB78C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aH4-0001SO-Nk; Tue, 15 Sep 2026 17:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGf-0001M2-HJ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:43 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGb-00010Z-SG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypsA//Mge5YDQi30YyZ79qMcL5CrWXbO6qr2vMx/dfI9CEbXypUkFRzhP4pePbE74O48QHv+WvE3kvwF0U7LMfIHC7dVNvgsAqs42DBzJq/Ckie0QYQCydfME9Oi60tW2YnZXS0w0EpIS00In39s8UdHriE6irU5voDiAJrEvdxbsOe5z3UJaM0551JrXIQ8Otvj/l1EXtmpyHFInc5NCnvSm5BoWjOgUm0pHUEZQkfUTU4lFeuUAn971s6dIjVEf2pRkYWzSmHE56dVawVbDLLJjU/11vks1AUZRwFgG2EgVBcCwQsVsraA1wus37wGx6xSSm7sssshQb/RFnJaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+g04HnVIWFojsvgdqM+fv7s8E4/lL4jCb/1af6zF8s=;
 b=T6Ykg58KQskv1Cv9eCvGR5vcpe27RKnOadXcuSwbXhSdnlWGvzSZDyDv8h5Gl7x9N6Pz9krMa3uNFS8OIj5ADAXuAFHvJuHiaQaRoQ43dFoRUc8vr9THCkNRWDVvB/WagnRISIfvY5FuZuzkvKmCNVWZ5nzx9+dfOpuo/BxSlnqGZSnXyLLk9izjbgUzzuv171BnCVBzEL8jawQUYxgFVE6XB/d9n2auZj87e8cKf9BS+bdmYO9P84q/yEIRhN6kpLhvSF6GTBy4xGitQnMOwGOnpjF5A8i7sO2TYt8LXSr6qiHGKhyCYMcZQYC16Wqo1Rwr5xT+Q8LxoVySAQhyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+g04HnVIWFojsvgdqM+fv7s8E4/lL4jCb/1af6zF8s=;
 b=arXyCT7D8RmeSCnxZ5sYkCZltRgeJ+ghRi1vfDaMXbkeTrXgPRqs/fz0c9MgAZNJJUNguY9quQUSRdPRsfuIBvbxp059OPg3k6x37+ruDD/xcfiK4oK9iB1mSPW1jR8B2f5UwCdTWKwKmHU07gX36EVi8tm1ORM/RaL4clNI8yUoOLuFKwBTEl1irEgf0l74Y7aJ5zrvz5E1uojkd6rqnnbSvNYHheMMUsbtbKCOcEY3y8nLeXB6gApx/qaOPSsXneIow7NE9YzlUuPdNtwGnFInkWjIJy40G5hdPTbzuD7ZLBR1dZXJzYmv9fp63p/uF0myzBOdp/EWPhaLlVY6gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB11454.eurprd08.prod.outlook.com
 (2603:10a6:102:50b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 21:00:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:30 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v6 00/14] migration/cpr: support vhost-vsock devices
Date: Tue, 15 Sep 2026 23:59:36 +0300
Message-Id: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALixqWoC/22Nyw6CMBREf4V07TUtz8LK/zAsoBSpRi7pLY1C+
 HcLujSZzUlmzqyMtDWaWBWtzGpvyOAYID9FTA3NeNNgusAs5nHOSy5hnsATqgf4AcmBz0AVUrR
 J2QslGhZ2k9W9eR3Oa/1lmtu7Vm4X7Y3BkEP7Pk59tvd+fpH+8Ydw6ESRxkkmyz6VF2+sm3FZ8
 Kzwyept2z7AYGEbyAAAAA==
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
To: qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de, 
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com, 
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com, 
 dongli.zhang@oracle.com, peterx@redhat.com, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB11454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b75ee79-10cc-4a17-7d81-08df136c5ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|23010399003|56012099006|10067099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: LF5i2QNtvTCQqeyzpJR22Wz1BQolGPjbP7gzraZ4y30uQ08J0dzP02tS0oLuLBYhKmoe6ODIwkIWYVeg0icx8KEh7/xomqvdRmC44j5XhUaF82bsX/dtc0r+ROhrKQlTkePuNHeTOKcvlBfZ5bwB6QQH1g+iFrpshpnVIvQHFALkVdniSVHTtOqn+DBflcWmEBmFmb/YqMTWV2A9y73NnQEUG7BHf8ACc8ufPdsMKGP/iI/2KuCvoiVV0w1OIDXw0oCHYDVIH/fDXJ8uli2LqaEyyPpOTUBzKitX19bYtAsnwMTzgxGkECaqr79mqMkHounjmKcaWBZGqwJakugt/vcmJua3NTnppky6bLOPQc6ohtw+bDrEtZoYxWdq2fgEhn82qK/Xv/L6sRCQZgXsil6zjQOMqIz2/b7Qt3liyZiD9Bj2ETyztpkT55AIjcdkEakJLgVAlmDcc4EV6zd7WjMfM958Oelmt2R3awI01sB5pTJJCb6nwjjtVsziEf8O0src40MGWXBMARdXbgXSqGVwRwGsfCB7lqks64f7T2c5EridEdHTNLUMJgZ/YyI6zdlk3FjwVsYBFse8SMabYqOBDfzy5kRFY9BiBXSfAXDhSJxQTugTlZ0lFDBdMhis9oDej9jcnYfx9gtmvqq1INWc7hgPclz7FXHUVJgsNyitHLtIUzFh2Dy4K0nwMRiduSNj882hLuts+tTAEO8w5vBcGNg11QtyZ2axSDdyoaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnJTVGJWb3NOUWJ6citOLzlOYWZWMXZUdHNvUWJQT1lOWU5hZ0JWY0YxK3NR?=
 =?utf-8?B?L1d6TWk1dmRWVG9nSGwxZ29iamZHc0hhL1BBZXpIc1puRHJpR0FZREozZHRo?=
 =?utf-8?B?VFBMV25zb2dmMytqSjBXSDFJU3Nra1A1Sm1OTWpLdndxZUozeGxuR3Q3aG1O?=
 =?utf-8?B?cFJqNlo4bHN2V1l4bHhEWmZTYUNDVHFXZS9Sdi9CWTVxdXZzNTdMZnJORHFP?=
 =?utf-8?B?cUgzQmFta2N0ZTNuWGREbnM1ZVBROHB0cEgwcXZTZjF3OGdVbU5qc1hzNkhR?=
 =?utf-8?B?ZWlBM3R2TGRpSlErQ0FxbWVYNkVjeStXVlY0SVBQaVZmaXYvQUhTNm84RkR5?=
 =?utf-8?B?clVzWVhsMGtudHBxYlhaQjVEdUZSbDNEL3Z1cU9xN3BDczlCQ0VlWHI0QmIr?=
 =?utf-8?B?SnBuVkhWVmoycTgwMTh6ektDR3NCakNUUUlVUUJOcndseHNLZHRLcEUyV0NO?=
 =?utf-8?B?UENoRUR4eGxoMWJsOTVHa1pta0tmWGpWdFNIWmhkd2dpRWk3cXJaUDh2elJa?=
 =?utf-8?B?UzRKdFF4ektGaHYxV1R6THpya3RITXA1eEtDV0tmOWw4Q1pJNkhrUTBjenpX?=
 =?utf-8?B?WG5DcG9GSUJuZlFOdXJudVZteENZT1NLbFRraTlieXFzK1Z3Rm56UHlYdHd3?=
 =?utf-8?B?MDdlNHgrbUpiaVNiY21uMUJpMnJBblQzUXNWd0IyOTNqZmlwaVphNjh0RFp0?=
 =?utf-8?B?WVlxSmF4TCtQMzFybHFjZUorNzRxaWU0Y3BUWDdBZjQvQWxwQ2hjeDFIaDEz?=
 =?utf-8?B?RG1yYXc4OXdoOWJ6NGpob3VLcXBBRE9jKzhXaEtCSHJxM0RzQ2dhejhTT0lx?=
 =?utf-8?B?UWN5K3g2dnFwZmt3WkR5TEdjWXh0T0p6RHA4a3gyb2MrNWdqRGE0VksydjJi?=
 =?utf-8?B?SEU1eWdGNzRqRXl4c0pFV1VkRnprc3gzd01uMGdKOVlWWWo1Rlp5S3NEVWdE?=
 =?utf-8?B?SkZlVk45dDc5N0tZcnJPS1l5VnZndnNZM1ZVV1ROMDl0aThGenJZc0YvcS9l?=
 =?utf-8?B?aTZMd0hQaW41UElpNXplelQrQ3JrdjBsaGFQd241MDc5SVkrSG94U1Z2Wm01?=
 =?utf-8?B?eGJMUmZoakZFV1BkdmYwNkNMaGdpM0VSaGdDeUk2RnhlaFBZcldvYnZ2RHIw?=
 =?utf-8?B?ZjN1S09KcjdmZVJycG5PMkRHWmVVbHdFRy9hK0kyNWYySm5lbmhSYkhFMnhl?=
 =?utf-8?B?Y1Fya3orcmtTemhIcXZDOEV6enRtV0IyL2R5Y1JHRlBQZVgvY0JCaXJtbk54?=
 =?utf-8?B?ZVN2MHBWWFJKTUF0WGZFWVM2RCtrckpxZDFwR3ZsOEVSV3ZFcGNESnBwTkRY?=
 =?utf-8?B?dXdxY1NtNXp3TUJZVlI4WTlab0wwSGtuUGtWZmw3cXRUajhVOXB4eVo3aldL?=
 =?utf-8?B?bFRjQ2dZVTRXVGVBdjZacXlHc2hCVDZrTCszZi9QaDFXVXBpUDIwYmw1MkJE?=
 =?utf-8?B?MTFETVhadlgySCtHZkd1YXlxUUdxcDZVYmxGZFVjQjlOclIrdit1Zi9ZN1J3?=
 =?utf-8?B?aDNRb0RJWjdpMlp0WmtRYkw0aHhhLzdZVzNMQ05INmxwdVFGN3J4VnVlVDRZ?=
 =?utf-8?B?RkFFTXV6Nk9RdGdyakYrSXhxQmtLK2FpUTdCb2R2bmxvM0FTdElyU1hmdnM3?=
 =?utf-8?B?dHlTdlNPWVdsSHZHRDVXSjlMbFN1SDZKQjFQMS9sTWdZYWhxUjk0LzFDbWJY?=
 =?utf-8?B?V1hGV3c3OHJudjNwT0dqdWtwVTRHVjJ6ZHZzSXpLRTJ6UEw3NUZ1MVBBaS9H?=
 =?utf-8?B?Qm82c1RFN21oSlRXRmVNWW1qaVNOTHZLWUJmN2YzdTlHbDJWNGMvRnV2ZjZN?=
 =?utf-8?B?WS9ycVYzbGt4WVk5UmlVZlNNeVI0OG92ajNoOHRBaTVpUkRxZllySUppVDMr?=
 =?utf-8?B?Q0hoU1Qyc2dKem5KRVhNMzdnYmNpeVdrbFVaZHJ3KzROc2tINklSbTAxbWZz?=
 =?utf-8?B?U2NnNUhHRE85UUp6ZGVjRmxQM3NLYTl0YWsrekVpSGgrT1YvOXFyakdzMmdP?=
 =?utf-8?B?Z0JJRjFxZW9uSVlGRUlDa1pIR2kzRngvWE1wWUZ3MGdXdkJxTm8za0x5WUxz?=
 =?utf-8?B?L1RWeVNUM2pQZmkyUWsra2hJNVZWUCtJYlRTRGVXYU9hQUM5VXZyVnR2RDl4?=
 =?utf-8?B?SVRLc3dZenBxSGRBNHRtVTJqcC9BWjlDeTRPUksxSmVVa3pOUU5VUjQ4bmVP?=
 =?utf-8?B?bnFLRGNucW9qbGs5b0VtTEY4aGlOYjRHUUoySXZ0MUgySEk5RTdFeEI2N2hT?=
 =?utf-8?B?WWdvbm1uZFl4dHVRZ0t2emxaUlRtZ0NIaFFyZS9uSEFZT3RDUFFSK2hVamNR?=
 =?utf-8?B?TktvbVZoTGxWSFdOTHRKalBoa2dLL1NIUE4yZHdCelg5TmEreDkvZ1g1Smgw?=
 =?utf-8?Q?dbyxXLo9oRp1Bplg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b75ee79-10cc-4a17-7d81-08df136c5ff9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:29.8970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxauXPGFjUB2V34100+KmYvBjsRXWkzo85LQenfOqlnEJ7oRP09PNiX/VQRtd/wlcKGMDC5gaTA/t/nYl6IXgy6u4z9Mbe68SZgioP1OJHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11454
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

v5 -> v6:

  * Patch 9:
    - use the device path (qdev_get_dev_path(), i.e. the device's
      address on the bus) + "vhost-vsock" suffix as the CPR key instead
      of the device ID;
    - drop the device ID requirement altogether;
    - introduce 'cpr_incoming' local here rather than in patch 14.

  * Patch 14:
    - lift the CPR blocker entirely instead of keeping it for ID-less
      devices;
    - skip RESET_OWNER in .pre_save() if the ownership was already
      released by a previous failed CPR attempt;
    - reword commit message.

v5: https://lore.kernel.org/qemu-devel/20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com

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
 hw/vfio/container-legacy.c        |  17 ++--
 hw/vfio/cpr-legacy.c              |  10 +-
 hw/vfio/cpr.c                     |   6 +-
 hw/vfio/pci.c                     |   5 +-
 hw/virtio/vhost-kernel.c          |   6 ++
 hw/virtio/vhost-vsock.c           | 193 +++++++++++++++++++++++++++++++++++---
 hw/virtio/vhost.c                 |  57 ++++++++---
 include/hw/vfio/vfio-cpr.h        |   6 +-
 include/hw/virtio/vhost-backend.h |   2 +
 include/hw/virtio/vhost-vsock.h   |   1 +
 include/hw/virtio/vhost.h         |  61 ++++++++++++
 include/migration/cpr.h           |   2 +-
 migration/cpr.c                   |  55 +++++++----
 migration/options.c               |   7 ++
 system/physmem.c                  |   5 +-
 tests/qtest/migration/cpr-tests.c |  36 ++++++-
 tests/unit/meson.build            |   1 +
 tests/unit/test-cpr.c             |  98 +++++++++++++++++++
 21 files changed, 512 insertions(+), 70 deletions(-)
---
base-commit: 5f664cd37aec17e8145aa117d8da68f507edc8f1
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


