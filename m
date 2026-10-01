Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14014CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC84-0005BK-0x; Thu, 01 Oct 2026 04:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7p-00056N-8G
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:48 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7n-0003P8-7b
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhyQO+C4qneMxGPXIWpdAJjS9VOgiSog+LljjgubAZiUdcSF5IVG3SytEiicvv9C0mGlkDJkeVwFK+5+Fd/Ofxno0IGHbOrtu8pNuXHxkY9P5S2iRzJJFtzakOz+0kX3dwq/7ZAOdGD/JPPOP14B3cHgUOw5GyV0RqLTRjWZM01g81EZBQjJ1wPMXV+ZRrrWnnv8qCp2kHlxesguhAPsBsX2WA+m+WB+N59sv+q2ZzQtyE9o8z7g5aE4MrCU6TIrrExy3c4yjqIclaxwlos4bq6olwHcTbFVZToFqc+6c8p/tlRjFDUMxoX9guZf6ieNE0D3GffWmaviw/+fRY1NtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j6tn3rcQe6zhsF8voZLwakFGjeiyg/G8EmqpnReLKI=;
 b=ACKnbY4crffoByyMN8YCAWb8N0B8PS5e9n9XpzcdrGy4R9HBl8BhV0m2Lpl/Jf4N1LOf9dqaGZaPT+Tshrj0QWKh4fZeNSmN2UON1Fkiqz0mQ3n99pNIS7KNAjLYEimwJ4WHwBj68zz9nlncB92FeARkqWbBMJ79xOecafSoLEzMTfKl5csJVtAHK4fFe2j+502fEt3Zq37aW+Z/wWY2mmhzZhchfx5aifkPulbVRM6FVbsIz+mocZFCKNGuf1BKOwlJ3miM3d/DGAfgaIES15C4N5OOBrXqYJYfHTg2xtpaRaI47hRSNlq3sgCErIJemXmp0Jc2GjAzEzhBxjIkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j6tn3rcQe6zhsF8voZLwakFGjeiyg/G8EmqpnReLKI=;
 b=zMkXObb0hBYM7srTuezL5QPXHM8sLD1cLMR74vZZMacS1Ksh9BlfLM0oiursMECOrlHnvHq6qOSA0JqzonwQdpFpoZ4bsTAJi9kLxZ9qxfq8iLAelnbJ3FQq6uIazF6P/oh6Kgv5dWlUCIeUPW0dOoiBLyQ9vw//k8N07Qy84GCzk7E3SG7RBeCxoHx/RkSKLs7DtjgIMz7vx6LpQRpiO8v3qW0Ty0z7/fLcU07/s+9lotgvGYnbIq81wuIab3BOaSc5+041VxqDE59fBzUoO5Vbwecv11u/z5KzNPwKlqwaPr5+/t+CoYaE5tflY5DlOO/9LvI3Lv942nB4y6rmRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 08:26:37 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:37 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v10 00/18] migration/cpr: support vhost-vsock devices
Date: Thu, 01 Oct 2026 11:25:00 +0300
Message-Id: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0YvmoC/23QS07EMAwA0KuMsiYo/8SsuAdi0fxoQExGSRvBj
 Hp30oFFhSJ5Y8t+ln1DNZQUKno63VAJLdWUzz2h5OGE3Dyd3wJOvhcQI0wRIAavF9xqdh+4zbk
 uuEnstKGWQ6SOTqjPXUqI6euOvrz+5nW178EtO7R3zKkuuXzftza59/35VAz8HgR7qgXj0kAU5
 rmlsqz5es2PLn+ifUdTR0WOFNUV4Tm1zDs1RT9S9FEZ3dp0V1SIECLh3HE5UsxBYTBSTFcos67
 /jFgjppECB4WTkQJdCUBARcVAa/Jf2bbtB/8e8hXhAQAA
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2d4262-3dae-4676-3aca-08df1f95b5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: XN7T/2XOG6LdKDEJAulRESXHW8U9aVVBawBVQMuhrgaGTz/SecvVWAFg4t0Y4/5sa926NhclhHvcwy0LFnYz2gSA0DqsNstXHs9SpwDsxQV5/1sKQrekfwsL7FQbjA/UEepJu1nZQcuPn9GJ6qjVSj5RkNwkkUtrrgmT39Mn85o3jF33zTdqWCICMpis6FrHsvOgptcYKo7nQ/OdRmdap+ZL/4ercqwqRJF+wF0JA0K1ONZ1daEamRWV/Qf42uAuKPR0sPCjc9f5tlzZMib6DipD8oCFTZhRsAHy4Oi6TlD3nvULTfxKZcV80H4XIHr2nQzYGjwg6IhCTozoIkcb8/cbzUHcDMX58P0Inovd555XYZpdqXtNmoHzC5/ABkRN6GwZgeAW1WK/FRvDCvDfX/A4LKhnCGbBOzEf2Dks2o7feZlLu+qeOjaeWyOgCOmDELRltRBmny6CFNwSgAlxGv1Yja9pJYY0nny7jTVmS8loZEGfBku9hVwGSekM2tnviDDRrovBMg5nGCV8F6ZeP8oLIbE08Eam92Ltbd4/Zyq0R1+9LeMMdQ8Mdz3dZMPT27a+C60KLBqK7g+YQ/wNJQVCT+mS6+J1rQLhlcshL6EpYOt7/FAMfKUTGnbxBopApdzhm/o1FaTOCbcRt/y7/95fAIrV7rmiR5KV7255NNCx3BMlYCrmObBZCdGp9qaYSfhBaEkM7u4ukkg4BUOoq9T3fopeqeZ0ZrHIiyTaIZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdyU3lHemdzMlp1dXU3MlErUXNpd2phQ0lBK2d2anhwWFAwVjU3RmEzQXRD?=
 =?utf-8?B?SmtRbktmYTg4aVU3Y2pDZEJFN2RaZ3E4UURIUDF2Q2tGMDA5bnNBbitVc2VF?=
 =?utf-8?B?SERIVWVPanMxVWNYV0NBSHErOHJ1UGdYUjJRbzY4eWZNVEpkc0h6RXhuRVNQ?=
 =?utf-8?B?dzNsMC9VaVpiL3V6OTlKZVJiODFPL3JCZ1FBUEZiUTNDRkNNOGFKRmJlbjZB?=
 =?utf-8?B?UXZ5TWZsVkhnTUF0dy9DWkVWZDg5YVZNNWFEZXR5VGRleUpocVlJeFpwOTNi?=
 =?utf-8?B?MFZJTXFKOVp1NFhvTzVnM29tVDBPN2cvU29lTm4rT1dLYlpoUzI5aFNrVlAz?=
 =?utf-8?B?MkY3Z1J2Nk1qaTJHbEhGT1lENnZQdHBZZXdoTEh3Nmd2OHVBZ3hwbmY4SjVC?=
 =?utf-8?B?RWJ2RWJNaWVOM3EvbnRrcWhFVzZkM0RyVXNrWXk3OTRJbytzS0RWcDlZVk1R?=
 =?utf-8?B?VkJsRmE3ZGkrM3Z6cW5lNDVzcm90RG15RFdNUk91Z2ZuY2xrV3EzZ205azhi?=
 =?utf-8?B?TDRJbldlT2FpdUkyRmtKWkVpLzZ5UHZJSGJiY3gwTzMwRmh2NlhwMXZmWDFq?=
 =?utf-8?B?ZTk5KzJXd3JVMmpCQUtNekhheWtTU1Z6cHlJQ3lxOGJSRXlOdFJJa2V3bXlM?=
 =?utf-8?B?UWEwZmE3SFh4OTJxblJHQm5GMU5NT2gyZlBXQ1Z2aXV4VEJERWcrVlNKME4r?=
 =?utf-8?B?UERCSEkwc0ZsTFI5MTdEY3YveXg4QU80ajF4a3RGTlBIcCtGMnFHUEk1VDlZ?=
 =?utf-8?B?MklzWDVqQnNtRHVSdEcxVUIyTUdEOEhxalNzTzFPcWhnelMybEQ1dzhaVmpq?=
 =?utf-8?B?R01jU2IzcE9iSmRPVzJGeWl5NUsyN0djemF2RURVR1M1QkMyNHgvcFA0ZVQz?=
 =?utf-8?B?b210elQ1bThMUnVYSjVjUW5MQ3k0RWpubGZWVG9Ya2wxVTZMR28wem90dXF2?=
 =?utf-8?B?V29iYlZaR09EWUZlVU8zUkpUQUVodlZzSWdHeGQ0WXdlOW5rbjF1bER6dXVy?=
 =?utf-8?B?SUxhZkhaWmlyVUhuaE5HbmxmYXRQaHd3dzlVM09RV1dCdTdsd1I3UTJ1TUUy?=
 =?utf-8?B?NHdoLzI2cVdCbThrejBjbXhtK3g2UzR1aXJlQzk4TVFlQVExODZrdzgzK3J4?=
 =?utf-8?B?bnliSUEvMXhXKzZtRExWY0oyVmJ4MTluMDIyUy9KeDg0dmRsdERRN0JpcWZ0?=
 =?utf-8?B?Y1lENkxTNjY0Qld3TEpNeEF0ZHlWdk9nMWsyZkdCZVdIK0dVSGt0QUhHbzJu?=
 =?utf-8?B?QXVZZnArWm1jbGRQZGFUMUtFcVVka0JSZG5CdHZMZE01dlA4a0xtSlNZdXFV?=
 =?utf-8?B?ditlOE5yQy8rdGlFT2R0T2pjb1dqRkxJck1mY21UOUd0NTZXRGJOSXhaMklu?=
 =?utf-8?B?MkhZMVBibVVBSUtuOXVtMElnOEFZdUNmSCtJMHRGbjdOemRNdzZBeFFlVzF5?=
 =?utf-8?B?MGJENis4UTNGTVpHcEd0eGx2MXFCb3RsS2RZd3pDT1JyWUlPYTVGYThkR2RW?=
 =?utf-8?B?M0dmbzRyeGpwMysvdHJ0U0xLdzl3Zm1GWEluVGRnSUZXOUd4SHRpNExSRWNQ?=
 =?utf-8?B?dVFJN1ZzTTVvMHM2MVhrOTBEM2xvMlRLTnYzcHBNSVdBa29QeUZPQU54MHpV?=
 =?utf-8?B?TVZ2Q0ZEQnJicGcvS09RWVdib0RnQTZHUVBDMVEwZC9lR0taVnQ0aUI4Z3Zj?=
 =?utf-8?B?c3ZWME8reFRUS2ppOGxicFBMQTNOOURqR2hGUGNnR3hGYVpuekhiUXVVUGNM?=
 =?utf-8?B?cVZTOHdIdkRCRjRqVGxOVXgyUzZLUyt3dkxlYVVwaDd4L056U1Y4bHRvU1Vj?=
 =?utf-8?B?OHI4enBwbHI5NmtrUU1jZHJ2Z2pIQTQwcDJWRkc5OTN6aTZvOXNKdG5wak50?=
 =?utf-8?B?ZCtScWdJQ2VZeU5Xd3ljaFpSd2lrVVdNK1RYcWt6R04zZ05oL0tvVXEyQkNV?=
 =?utf-8?B?TExtQ25mdnhHUVhlSWhLMmhydmwrYnp3Ung4RkNBYjI2Ykc5Y1FSZy93R1lV?=
 =?utf-8?B?Qm9GTW83a3hkcksrZEhpVG5RaDZtckt3ZHUrZW5BZkdIdThYYjFsZ0FXdEJ2?=
 =?utf-8?B?UlZEa1dJMk82MXRJYWJYRmxBWVRaNW43WkRRU3JJWlQ5RkdPdGI2ekNLM1Zq?=
 =?utf-8?B?MHdGTGwwSC93RVFtZVVPd0wxTGZXc3dDczNBK0hRTzRDZWVyV3MyWnZhdnp0?=
 =?utf-8?B?dWhOSzl3Z3NmK01iRkk1TzdIbUZKTzU5d3NWY09qajFKaVhLNHkzMjNNTDVv?=
 =?utf-8?B?YXZVTTJ5TjVuN1FpVGFubHNEWXJERE5QRk5qcDBuY1lSSVVKY3BhMG1FeGJv?=
 =?utf-8?B?SVJWN1FpYU40M2hIYTdOM3BacUVvNWFuZW12NDNQZnVNUGZEUzdVclo3andY?=
 =?utf-8?Q?qsAoORl4VEv6oI3U=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2d4262-3dae-4676-3aca-08df1f95b5fb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:37.5363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7T3LHbb90qONnUmDM4cTpj/FJcz9kxXfk2QsIG5dN0gsuQzAlQ6Lw9vdk2C7nP2RmIA26Mg0BfntLChvXXS6sCqvVi/bNX7CLLwCeh2Twjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

v9 -> v10:

  * Patch 15:
    - release the ownership in vhost_dev_cleanup() instead of on failure
      path in vhost_dev_init().  That way callers failing after a
      successful vhost_dev_init() are covered as well.

v9: https://lore.kernel.org/qemu-devel/20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
Andrey Drobyshev (18):
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
 hw/virtio/vhost.c                               |  64 +++++--
 include/hw/vfio/vfio-cpr.h                      |   7 +-
 include/hw/virtio/vhost-backend.h               |   2 +
 include/hw/virtio/vhost-vsock.h                 |   1 +
 include/hw/virtio/vhost.h                       |  61 ++++++
 include/migration/cpr.h                         |   2 +-
 migration/cpr.c                                 |  64 ++++---
 migration/options.c                             |  13 ++
 system/physmem.c                                |   5 +-
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
 tests/qtest/migration/cpr-tests.c               | 133 ++++++++++++-
 tests/unit/meson.build                          |   1 +
 tests/unit/test-cpr.c                           |  98 ++++++++++
 23 files changed, 877 insertions(+), 81 deletions(-)
---
base-commit: 9c88811b81a935a172c5c873b2ada2d9b38a5f74
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


