Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2B7CA600F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElJn-0003Dd-QH; Thu, 08 Oct 2026 06:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJk-0003Cw-W2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:41 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJj-0000sa-6J
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaqj4mt0QppM2p5y+MM0PPVUhJSK/dqi09D0fnyDAwuMhVi2ImHI0LLIwvfup/+Jax70L+iSrV5UPBgUg5q4H93kVuG/VQcr7vvVkZ7tSxWzc9v0U+yAH8KyEPWU+YrufyJiPqxaBodvoJ/fvO5EvuBKsQtgR2pqLFmMy0KexAv8gDfZTTtEunZBmlq1r8KNg5BqPS8J+U5xT7ieY8p1iBn5vvUH6CsAGmni3hcL+djV6fJ12HIg36xUrwhvp6vEMI/4AoI1GZnEWP0wNFqSxKBxCJMkxKdQ0wOxU2wXCYoqTTHAyTujhkLSzLPg8CSp+rdCzISHER8RaGEsPxwo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+K4eEstD5ia+fvFh2Nonr6oa7uouJaNzIX851kctj0=;
 b=rLiMZC4AAZ5sTsFHkdg/faRuhc9RWltbXbD+9OM/atUi/vRZbi3WkDS9dymHSjQykvL9fpC4k/wG6l2XfELX22fOg3IAliPXSY0ZpYh6SFw/H0MmZtEgWH3md0CY1wqmYZzLqNoWj44LOvzCMYJAQiViy5tAskdal8AEcnPnOY04cKw6NpXbnfr4UPAFDMScQYOHdMYPhcBcIGT5EHUCYs9qRfmcMp6YTIM01gvkwDb0SEXfgtttk4ZAmTbU5JoO6ZujDxR7fl3lABKHCUchqX0bFNqDPEcJ9zvNGQdIXLRQDlRK0hQcDN1X1iZUbK2VBKobj4T6UVtQti7q8lPMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+K4eEstD5ia+fvFh2Nonr6oa7uouJaNzIX851kctj0=;
 b=g2e0/6Fi+CVW2oGTbFFvVi7XRUzIgL1QqOCVluR6KRThUQuyBxZlKzzMGT5GuOqYTR3aPgtZXeVRKY1EONfujRJNt7E6LIEqJ5ulzHt/jXaWuGi5Rqny2Pjbi+q6tlJOBueuNYKWqAU7dgaAe6Tnje/N+5XilmREeHuCQkqLvoE+1JoWA2M2MEWrvasgNF6Qca6JSONWHhF++pMyryNZSmQo+SIRsPqTTqfciPtbDvrc5I1Svj4L1zUxolBT0dKjqTsCqdUpLv+P4Btna1cOlaZzAvY58nRwul7yY9GR83FqmUN4ifNCFkCkrAeguyPuBRInU+dy6buN1zzRQP/Qhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA6PR08MB10593.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:25:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:30 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v15 00/22] migration/cpr: support vhost-vsock devices
Date: Thu, 08 Oct 2026 13:25:24 +0300
Message-Id: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJRvx2oC/23RzW7DIAwH8FepOC+TDQRwT3uPaYfwtWbTmipJ0
 daq7z7STRPSLHEBmZ/h76tY0jymRex3VzGnMi7jdKwb7B92IhyG42vqxlgPhARpgMB151NXlim
 8d+UwLWtX+i5Yh15RxoCDqPdOc8rj5x19fvnZL2f/lsK6QVvFYVzWaf66dy39Vvfro2b8uqCLa
 LVUvaOs3VMZ5/U8XS7TY5g+xNajmFbpOcVURUeFXsZghhw5xbYK99diq2JSppRBqaB6TnGNIol
 TXFVQ+lAzA+/0wCnUKAo4haqSCMhkI8la4BSEPwYBkGMQquMCkHZaJXKedbB1JOvg9iuXB6Dop
 FVswihbhx0Uym1SgEYqgmAcmw6q1jGso6oj02Bdjuht4t+jW8eyjt5yRhMTkZEx/8v5drt9A9z
 wVGFJAwAA
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA6PR08MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bb6f9e-9296-44ad-fbed-08df25267a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: NlYvjT7fY5E55VTbXahJGsCk7juRtIWbEy2Hl52JlTypvYMd12plkhS0aMTVlz7BPj/yUMKETWqzN+e6uXo0VOZByRU6dEbe9moPmXs5uKfiq1NjT0h1+UF/ixPt6ptgMlEUzxTW3SfIG2G9/5BIZYhDO5myLld6SMBh6H3vmkVaXU5vE8zAiE0U5FgiD5iWY776MJ+Hgt/G4wIipKvWaLIPxfMKukeV80CVSiwkJ5h6dSnZlyNmscvCzMpum44fVsf4k2gwsdWpDF76RACPv2h2uqxUPxF4ZPljEYLxjtwa4TZMAfjMRgiFeHIOnEDOP5P2MJGES3ithpw0Qt9NxzFqtqeuNXWmDI/hOn321Biu6edvZLFRErowZ15InxtSG2unCUx0LvC1uR+ecQbpeEn9hooCFvVXynrHj60SP1BZ5aAU16DQX/plfxr7u/Ifn2+T7JgxywgH5xIWUpaOdIBs9KwAIA9nZDY0OMP82bdzjkcETcKO0W7KXnSbdQ/EMloaqZfQNIBhSUsKQCWXjOnGdj1ixWrZqmA//d/s0g7OwuaLilB24gQBqtR/9jGdxZoucMdDMVayZPJLtjCHqtIbjEHJK1Su586GUdZ0K5r0NN3FCxqvEnw2cwkDQ8WbeSzDRRB30dIS7WdMSLVcZy4Lqnq91hg43XnppSzDEJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDhIbHBFQnJUd0ltWjZhSHJML3luT0JtVnB3VmsrVm5FOStSOU5UVkxYVWNn?=
 =?utf-8?B?ZHVBeUZWcy9oYXBtMlRKNjNReU1aaGVHaUFYS2U4aCsxODlNS0s3NmdRSXlk?=
 =?utf-8?B?eEpHc2dFQlVhbEluUnpGeVJ1Ym5OdWRLTis4UEdxU3plMmZ2Q3hydk42aFlD?=
 =?utf-8?B?UVpPM1ZwMldVTEp4RkZ2ZHFYbS85N1loL2xWa2Z5WUx1SVRwR0Raczh5VDhm?=
 =?utf-8?B?Z2lOUndyN1RaQ1REa01aeWN5V09WNmQvODBkMHdtcFBqY3Ruams3b3lGRmJq?=
 =?utf-8?B?YVBVQ2xRT0VzdGlzc0hUbTdlTE5kaFFZWDl5aXJNcVlBQ3V6aDZqT2JmOXBK?=
 =?utf-8?B?ZWVYOThSRm9vM0RIcDY2WkdDd1BiOEZXZnE1eWxQTE1JWWl3eFdsNmZKQlRO?=
 =?utf-8?B?WnRnUXlibXFlWkI4eDFzajV4ZlFzUUNMZVFOZVR6VGpuQTZ4bHVlaWFSS0N3?=
 =?utf-8?B?eGozRDFoRnd4SVI2NERoTzhTWXU0djNDWm9GZ2VZR1p6UnZ4SWFjM3Q5Y3I2?=
 =?utf-8?B?ZDhSSEp3UVAwUS9vT3JOUzZYZUg4aFVXNjBjVHRGbDFPRHRyUkRJb0FidTVu?=
 =?utf-8?B?cklPYkhGR1VTbThNZkQ2Q25KYURJNUxaOWFIKzNZZTlvSEZqWlViOGJwZ0VC?=
 =?utf-8?B?VHhValY1UUhVVmIzcnhjbVp1Nzd1aWFWdkRWV3U0U2MyS0QyTlc3SndqYW5h?=
 =?utf-8?B?MklNZVgrUlhVTFhTWmpMU3F6bHRXSFE1RzZBKzFRUWJFTDlBVjRzL09pRWoz?=
 =?utf-8?B?NXprRWliVnk0b2l1R0twY3FrWCs5d2czQ2xuK3BaNlJnSmd6L1F4UVUvWWRj?=
 =?utf-8?B?YjRBNU1xczhhN2trTFdMVllieDNKb3k0azIwd1VkQ3A3ZFlYQ0VRSW5Vd3ZC?=
 =?utf-8?B?MTg0WmwrSWsyRS9sMzQzMEpBK0lZVkt5cGxGcFJsSmhMWTlaa2s5VW9IS0Zl?=
 =?utf-8?B?TkJHOXArZUgvNFljKytEQW9GSXFGcnVFYkIzS29wMy9UZ2M2eTk3RXZBdDNi?=
 =?utf-8?B?ZGhkVklyTkc4Z0NLWmZyMTNhdGZxazNqZWRLZmUzRjVwOVNnYlplS2hQMGRZ?=
 =?utf-8?B?QUlkZEQySEpoTFN4K2h2cEIrNzA3TlViK3VOU0Rvc05tK0xWbXNWR0tPKzlI?=
 =?utf-8?B?dDVLQU83NDhnWjZwVlhjZExSbFlhRnRrUXFZL3hVaWZIK0J0cGhZZVRtUlAw?=
 =?utf-8?B?RGlrd0t2eU01WmZjZFNtSlVCNEwvK3dBeDZEYmVpblM3MENjbFozTUtwbThT?=
 =?utf-8?B?TENuNm1VenpJRVpNeUE3RUo5OFUvNklLL2QraE5kYVVtL0h2OWwxcWpDK3pY?=
 =?utf-8?B?Z01INE1Ma1pkSnVRSmZMZmU0cWlHMGJyLzJRTHBOWk84d2ZZQzN6STFtb1BD?=
 =?utf-8?B?c2lOallkYWZDRlhiTzBwSVdnOEdwTTk1VXMrekpJanVNVHZkdmlqTURibnV5?=
 =?utf-8?B?UHQrT1E4QlpraUVrZXNNcWMrc2NaYzVpNlVmRmRxekNReGE5bXNLUER4Wmlm?=
 =?utf-8?B?VitYREVXRnBJWmZ5VzlkanRGZEYwTDdlTjFTWFZFNFZhMTBvS0xmSGFOb3F6?=
 =?utf-8?B?YnhWNmxGd0JrcG5XL3QxNUh1bysySUQwNENDL0ZtKzVkbjV3akdrOWNhMXZC?=
 =?utf-8?B?L3VjR09QaFUwMUZReFlBMWdOUUtJTERrclRvL1MxTE5iNS9JaE8zbnY2L1Rw?=
 =?utf-8?B?MHZCbjRjd0I2dkhtTXpGc1V2TVJJbVlnTEtDWXpiRkUzZWRLZTVBVysvdWlK?=
 =?utf-8?B?eWZLaFRlcGNSZ3hDMktwelFEcmJ6dWFoUzlpUGVHRkMwSVkzKzVtOE9HbHJi?=
 =?utf-8?B?VlhWMlM0bHBRZkJqaHFNQk1acUdqRS84cmpoVExrYWlQQ3pDTEtHL2xkR05i?=
 =?utf-8?B?WklJR3RxK253VHRvT0dmdmdjR3dFWWo3RFJJSVlpTHRrNGRzLzVDU01aM3dJ?=
 =?utf-8?B?eWV6Rjk0cGw3TkxGZjZKQ1FNWGorZjBab3YwOWRtYVNoOGw5VFZBTVNiQXVm?=
 =?utf-8?B?OVN1YXcxYlNPTWNOL0VyeDdXVURudnFqTUVtaW5nZHdXSWlveTU2Q0QrdE9L?=
 =?utf-8?B?RFRUS1BFY0kvSVo2MjV4eWR4Q3VTMzFWdmVSREwyVi9rcnRBZUU2Z0NTODJF?=
 =?utf-8?B?OXhkaDR0QXpvV0tOdWY3TFZhM3ZHRTFDZ0trd0p2aCtJa0FybnhhL3lOVHZC?=
 =?utf-8?B?azhLRVZweUxsZVhJMkNCNkFhaVpDR01xbjQ4cXZWb0dJS3haRUdacE51bHhE?=
 =?utf-8?B?M0xOd3NkR3AwcTlLWlpaek5sM2cwRklZQVdFODNxaEVsK1pQVTJzeCtNdGgx?=
 =?utf-8?B?N05zd2VzcVFjL2xDTmlVMnRiREZXQ1hobmxLanVicWZGOHJUVlNyek5id2Fz?=
 =?utf-8?Q?kHTvyCo35sxPttfU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bb6f9e-9296-44ad-fbed-08df25267a34
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:30.0897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fGvNCJwdkt2o/UKeMaxYWj9uWXDJoOJCvmymJaxZoMTLvTPahtqA0wEhrEkFQEJj0jGC4wWBkjuW8FlpPBP237I3Fl/B8c1RMPOPxOAnPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10593
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

v14 -> v15:

  * Patches 15, 17, 18:
    - add vhost_dev_try_release_owner() helper for RESET_OWNER, ignore
      -ENOSYS and -ENOTTY (Akihiko).

v14: https://lore.kernel.org/qemu-devel/20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
Andrey Drobyshev (22):
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
      migration: add MIG_EVENT_INCOMING_FAILED
      vhost: release ownership when the incoming migration fails
      vhost: release ownership on exit
      vhost-vsock: hand off device ownership across CPR
      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
      tests/functional: add vhost-vsock CPR test with a live guest
      tests/functional: cover a cpr-transfer target going away with vhost-vsock

 backends/hostmem-memfd.c                        |   5 +-
 backends/hostmem-shm.c                          |   5 +-
 backends/iommufd.c                              |   4 +-
 hw/vfio/container-legacy.c                      |   7 +-
 hw/vfio/cpr-legacy.c                            |  29 +-
 hw/vfio/cpr.c                                   |   6 +-
 hw/vfio/pci.c                                   |   5 +-
 hw/virtio/vhost-kernel.c                        |   6 +
 hw/virtio/vhost-vsock.c                         | 193 ++++++++++++-
 hw/virtio/vhost.c                               | 136 +++++++++-
 include/hw/vfio/vfio-cpr.h                      |   7 +-
 include/hw/virtio/vhost-backend.h               |   2 +
 include/hw/virtio/vhost-vsock.h                 |   1 +
 include/hw/virtio/vhost.h                       |  74 +++++
 include/migration/cpr.h                         |   2 +-
 include/migration/misc.h                        |   5 +
 migration/cpr.c                                 |  64 +++--
 migration/migration.c                           |  10 +
 migration/options.c                             |  13 +
 system/physmem.c                                |   5 +-
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 347 ++++++++++++++++++++++++
 tests/qtest/migration/cpr-tests.c               | 133 ++++++++-
 tests/unit/meson.build                          |   1 +
 tests/unit/test-cpr.c                           |  98 +++++++
 25 files changed, 1079 insertions(+), 81 deletions(-)
---
base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


