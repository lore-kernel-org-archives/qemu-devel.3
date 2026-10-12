Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AECCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDLt-0007gK-TO; Mon, 12 Oct 2026 06:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDLn-0007fS-EA
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:33:47 -0400
Received: from mail-francesouthazon11021089.outbound.protection.outlook.com
 ([40.107.130.89] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDLe-00063L-Eg
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:33:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WY47vQstTzvWN7co3JWuk9D7xR//Sy9jycXiI/iJF+WDH7PHZbkvymBvoOH7d1bezbHzPsjMVO4pewrbewFolnu4QOrcvSBt4GIfWrqUH/I91We4+LxFDx7xFVaRNUkk8Lsj59g/o4vLmMANZcNrNO53zPIDDo3yHhdihjki4LuFw8VrVzoHn42ydxR+aHv78cNoqsyBCTYmQA8V+xR+COOuN+XYp92mA12EhbKuLxf1pdUtyIsxlVH0VGWOyxFWbcXwBDt0d0pE7igStamWnvu4PPa5N4IoYVNu/igt6hM7/ELNrydF8npnFfQOOv/aFi0rS4tUJ0WfzU/o8vMq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IJRzFL3722bHH9uYx0NCTLXgR0NBw6yoziOYUc3VPg=;
 b=K/aemHd3SEMl3vDNucrbmfqvaNrxjG/Pn3VfK1VlmU69zaaDvh+Dowgn3yqL5DHO11WhKjU3UT2xcOUmaT8FJUEXET3UqwpAK9M47L0JHWTUFVjEfLH8Vp2HDA+wKdZDGtNsac6SNCtjYjwpsp0Arguv5c11gg1ifYixyDERGK1fadBXwN589Bd3CMe4Bp2u9en42g0KuN2VfbVUlkVDGdbQujBHvreEcd6JvU3oGifgaDSYv8yDFLRf3wLRB5uGBZsv9HAFqC/57Flt20L4ougkaDDTRzzhIA0wQzhJ5fiLOO7rKZuzgZ75ozHw+DwIRhYUkh3yNADIeu/E3LyADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IJRzFL3722bHH9uYx0NCTLXgR0NBw6yoziOYUc3VPg=;
 b=HLuy4/aapokq8iU/UMkhBgTkJ6ISv9aI0D669skgkfVGU4GM8OEWp2GDq3QjArEP5m46TZGfrqkSeBFlMezTjtQC4xnbEoTHjk9VPYoHeS3NJdgUpvkz1oGWd0+Xe5S45rp2CxlLc1eVwoUG6CWEd90TkMva4RQyhcSXNA5w1c/HvANgN80G0ztUf5JSI6QghZ83D2qY22Y0n7Emm3rW+IZ8+q4nfPZGe0g3WCRUnFcTv3AaEDq6jCKJQJpeRh4kvFFs8ON58PxgqCrP7CMG9lSLzqg/AVF73jK44WtcJtmXnyIZDH4SREQAdoObyCTL7j8M8XGsLLXG+iP1f6AG2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5523.eurprd08.prod.outlook.com
 (2603:10a6:208:17f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 10:28:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:30 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v16 00/22] migration/cpr: support vhost-vsock devices
Date: Mon, 12 Oct 2026 13:28:08 +0300
Message-Id: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADi2zGoC/23SzU4DIRAH8Fdp9uyaGWCB6cn3MB6WL7sau83ul
 mibvrtQjSFmEi6Q4Qf8h2u3xmWKa7ffXbsl5mmd5mOZoH7Ydf4wHl9jP4Wy0AkQGghsfz71eZ3
 9e58P87r1eei9segkJfQ4dmXfaYlp+ryjzy8/8/Xs3qLfKlQrDtO6zcvX/dQ81LpfHxXjlwF9Q
 KOEHCwlZZ/ytGzn+XKZH/380dUzsm6VgVN0UVSQ6ETwekyBU0yrcG/Npig6JooJpPRy4BTbKII
 4xRYFhfMlM3BWjZxCjSKBU6gokYB00oKMAU5B+GMQADkGoTjWAymrZCTrWAdbR7AO1lfZNAIFK
 4xkE0bROmyjUNROAWohCby2bDooW0ezjiyOiKOxKaAzkb+Pah3DOqrmjDpEIi1C4nMeWof9Olj
 /sYRyFelkKln/d2632zeVKEdBkQMAAA==
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: dab37a19-170f-4205-1b2d-08df284b8f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|23010399003|366016|10067099003|18002099003|261009223027099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: gvQMQJO3d7Q9/i7XTS4iMF4MP5IHjlR62XHKcuZ9cMVLQmicitUxYxbfxjzhQMgz/IVGJ6WZW3fpOtyGhYYLGMJLBX2I4k/gM2kG4BbHNNSsjUXFv0FKhS6IYDPnVj3JIdwWO0fBNQ9ILlrppKv08LC7N0V377Y/5JsVRm3RTZT4uwBNPqqR0t2JtudY0VfKrkwEiBPr5EkALms7SX9N8ChZMCD6z+jyRqzcIxkCxq4Y3udXjeD9l+KWBQtA8NA64bHsqaXiGRoICvKXCOPzFWm1X8kHS2Wb+ZnCtZLvyd6LYDZhZHTeR3BR67DKFOoGW9KtJOaMTvAUm8gNGnfU3vpzzONdzlH2IPiWbVgj7nkGYtRXrq7LIv7xufJYVmatSQgg/6w9N9/H6Ozi/QVhKsg5jWG3FiV6DDZ93XOuZSn9/H+J5ihkeQ6giDtzgNW8qRhXZrw7YQR7lLNK9or4FkkUY+/PWPleBo82EaNQA/TJQWQwsBpqvBvTJXvYGPGYIz9tHbuud1w1eeKy5xoMTz2E617AQe3U+T2me/k1aaxZgKISbm8EcgFjU3NdZUTx6rQ9GyApWIoDx3LjErIU7lNh3uH4mXlgD8BTme319R+c0MSAx3U5kEkk+O7uAGzvqy4Hyrjbh9GSRRnEAJjdkB/v0gb/7Libm7xDUkgRhcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(261009223027099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXA0TUk2bjZrM01vZUVBYXkyVFZtaFJqU29FV3RaR2l2YmVxTWpmMkVNQUZa?=
 =?utf-8?B?OEQ3SzU5eGxFeGVQV3hpR05SZHZHY2JFWFR5QnQ5NGFXTnZHdktsZXlnbWVn?=
 =?utf-8?B?NXM0ZUh2TStZZGNMTm5lUlllVWdyVkpSTFZ2L051ekJnOWo3TURnNFVtNlFx?=
 =?utf-8?B?a2Y3RTJKNjdPNm93ZGdEdUF1N3hja3lWMmZEdFhZVlpmeVlTSUhOMmQ0Ni9z?=
 =?utf-8?B?Z3o3WHBkMkIrWWRpMHZVcENrcEwxT3d3Q2RBNkVDcTIwVmF3Ylh6TGtHRGFD?=
 =?utf-8?B?UWZGMkZqQjRJM2NaeThjTjVsQjZ6c3dLRjg2MWhDNFZTbU5CSjhXdDZCU0Rr?=
 =?utf-8?B?c0hKbFFhSWdRRGlPZGdUR3Z0YWM2dzVwaThiME42Q2JNWjkrTU5qTlFKV0lI?=
 =?utf-8?B?bmFZTzI2TGdyaTdtK0NCRHBMc21XSk9zM2g4NXYzVGxhbWR6ODV5aXZqYXJh?=
 =?utf-8?B?dHVKYWRIdUNlWkl5VThEOE1DNm5XbzFHajgva2Z3ZDRvNmFIUElaUHFBbVJP?=
 =?utf-8?B?MkF2amE3TTNQcno4bk45eVJQLzJZcmJTL2ZVTzFhNE9YbkdsOFMwODgyTVc4?=
 =?utf-8?B?Y3BWVjgyTlZ6bTJXWC9zZ1VOODZYWHpMRkdUQmFwb0cwUTBhNFdUQ29ldytW?=
 =?utf-8?B?L0hCb2lWNlgyaTVZQ0tXVy8xeVVTMDEyaGRRRkxaYnFacWwzRTUydTZBME9k?=
 =?utf-8?B?a0F4am5ZbUUxK3NOMEZTeThWWHVEN1lLcmc3Rm1yUjZpTjU5TFZCNktJL09X?=
 =?utf-8?B?YjJCTEVYdkQxRlhtMUkweTV5em5FK0FzWU9ZL3F3YXc1aExtUFc5WXpuYXU3?=
 =?utf-8?B?M0tpeWozOW5KSjBFdnoraG5OK2ZpMk1HUWtDZjZURVFDL1AwOTNSV0FiN3FZ?=
 =?utf-8?B?MTZBWEdVT2E0d3dQeElTektrUG5rNlFxS0RhbUc5OUp6YWloRWxPTXB0Q2Jt?=
 =?utf-8?B?bmZXeTc2ZjY2MUVmcUlNZGFuYjZxY1htclBWQktHTnlRTWkrc2x5a29yeEdG?=
 =?utf-8?B?dUpTU1lGT3dOZzM3YXVyM2RXbnl6L3g3WFozVGFsSmdiTUErY2FYWDhiT2py?=
 =?utf-8?B?VDM2UXJROG1EaGhtNjBlK1kwTm9hVlNReDF2eEdWTjQrNTZTU202R2pQK2pS?=
 =?utf-8?B?R080SFhIeUlTd1l1WkdxU2hodnFvNUU5alpFUTBYU3ZjSmpady9UcjBzVWNN?=
 =?utf-8?B?dmM1b0RMMXFxMW83cDNaR1RXQThkTitka2xWbUxnVGhhcmZsK1ZEbHk3aHAy?=
 =?utf-8?B?S1FCVzIrcGt2ZDAxVTJtKzM5Y2htRlk5ek9tV0d4czRZbUhNc3hlK0k2REFn?=
 =?utf-8?B?dXVlK3czRzNPRnZRVERZN1UvbHpCR1lnc0V5enh6M2NadEUzUDZ2OUN1MVlo?=
 =?utf-8?B?RHUwMUhuSjhIRlI5QWp2YTRlUXppYVdGZFE3QU80MWdUS3J4R0xTYkpmcEgv?=
 =?utf-8?B?ZW9PVTQ1ZjJFVkRwQlZnVXUwcHhLaEgwbU5za1BJc21HOEwvUCs1UFNJNExa?=
 =?utf-8?B?Wk91OUZ5VC8vYTc2Tit2cXVnMlcxZHYvenhWR0JtcGtNQnUyVXlSd09SaU9Q?=
 =?utf-8?B?NWZmUHdaWmJrc3dCajZUTGViSDE1empLOGlESW9oN1dlb1YydXM1T1U2aURG?=
 =?utf-8?B?SVJieTU1bW5pblVqbkdBZzc5bU5odkJ2cmVaTEZzWWNSZUdWWjlOS2pZUTJk?=
 =?utf-8?B?RmNUWVV0WVFWaHZSejhGUEJSMzJ5WHFaNTZ4RDZvL3NwaDA2UzFkdWkxdWJM?=
 =?utf-8?B?Ym1iQU41U2tEeFNqeDBIdU1GQ2pSdGV5dUU0b21ON0wyTmIrNDJsVldGTkZa?=
 =?utf-8?B?NVl3SXNUa1kvZVd2ZENUalNOUitnYkZldUFPYkk0RXY1SjY0QVl6QWJZYVI0?=
 =?utf-8?B?eHo3djJNMXN1aURuU25FQUxWUDYvYmFTZWVZak1LTDVhOHFLc1k5ZEN0KytJ?=
 =?utf-8?B?azNVQlc3c2ttLzdETi8vdVU5OVZBM3B1V0lWUDdzdkNFS3hGWU1yMUN4UUxM?=
 =?utf-8?B?NllrWjJWYWc5ZGsvYi81ZTQ3UjBUeTlxU1NvZDFuTWhGUDF1aVh3VSt5WTFB?=
 =?utf-8?B?UlBwVU5kUVdidXhQb1dteDRjWVhhSEFYYmtjTW95dDZIM05TQkNVTWt2RTB4?=
 =?utf-8?B?RXJIMFdPTXJHQWw3RWtubkhybUU5YjloMlRKa3lkUDdzS0Vaa0RDdDc3NzJI?=
 =?utf-8?B?TlFDeS9VNVA5U251NWlXK2p6RU4wUkJ6cFlEOEZHVlRwSktzTlJ3VEJWem5M?=
 =?utf-8?B?dnZudCtneTBnK21uclhIL2dUb0NiaU9DV2N0UkNPUDZ5ZkR1ajEyOTFqTDAv?=
 =?utf-8?B?a1A0R2VSbEljREV4RG5reGRkK3MxdW5neVA5dFNKOWNVSFY2dWRiYXFqTGZy?=
 =?utf-8?Q?FzTGmTrDT4LP4Jc8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab37a19-170f-4205-1b2d-08df284b8f5b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:30.4569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5qg5bX+RbKFTRYR6z2/ZL4h7HQP0zD6t/qvURGSQ9rQTdAE3z0clEGpYj/bAj7cb4ZAd2vzoBB2O1XxEBHQ2IOSHGns2a9297C8w0gB4Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5523
Received-SPF: pass client-ip=40.107.130.89;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

v15 -> v16:

  * Patch 15:
    - replace the errno filtering in vhost_dev_try_release_owner() with
      a new 'owner_handed_over' flag in struct vhost_dev.  Release the
      ownership only if it was handed over to us, and report any failure;

  * Patch 19:
    - set 'owner_handed_over' in .post_load() on the CPR target;
    - drop the redundant 'owner_reset' flag, use vhost_dev.owner instead;
    - drop Stefano's R-b because of that.

v15: https://lore.kernel.org/qemu-devel/20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com

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
 include/hw/virtio/vhost.h                       |  80 ++++++
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
 24 files changed, 1084 insertions(+), 81 deletions(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


