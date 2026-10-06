Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7621CA600B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMzC-0007Of-GQ; Wed, 07 Oct 2026 04:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHiS-00066r-LQ; Tue, 06 Oct 2026 22:49:15 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHiH-0004Be-OF; Tue, 06 Oct 2026 22:49:05 -0400
Received: from SE2PPF27A9EBFF5.apcprd02.prod.outlook.com
 (2603:1096:108:1::80c) by OSNPR02MB9899.apcprd02.prod.outlook.com
 (2603:1096:604:47e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 16:17:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtQblebpgnxSYgBXgvn1PnkK2dBkvvERvIc4SK5pttt68wlSxbUsUuUAXOT3GBXJqSu29PzLoCTfSG9JOvjhuz0UMbJdITotc5xGxrieVWLWYakS8iLhROWMWSQWyVXlzqeKcQLR/7UjqOp5iZdIcdjvQ9zHGX5tNwkUG35cQ+5g5RH6d+l49F3ie2dOaLrynkxcpnm8n9kXUYDxefiUddaOlf/icHA1lLEGVRUx58Pe31SnRIIrz/ttfOhok8eYOv7Fp5rmm8GkJlb6xfok9EQU8JI82es0RvZ/pyppstWHy8WXKVZ6b4yhIhhrCd5hWK7JeHD3kdcD4rOFnaZUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQIf0BDr+vzZiCYTRmn/f/kqhZiX4bckrBeoyjQ5nUI=;
 b=SQMIuImtH++vmqywesBLsiPwcMq0laboEmLUUc9Ty1XI6JJ29jor2ox2PjOP813dbQzMd/xhJHpJvxKOzuYBtK7Hsgs+GZ6fIdOus03XiORQHvyXEvqw9A2N/CJcESu8FVcQAa2yzln7K0xloUxfX+MpIMEf4JWStXF33x3JrT3EJesqJWJE+jHo1Lk6RXQ2ejeBmFnkIKpzIVhUZd2yt5liXrKn3Z43UuHKTeMa/nHDTRj+nekl/eXIwbfALjKpdgp+MzhHkRrqX5+0cHLzpctMvRxSusKfLf1uD1Z0I9uj9RymNgT0wbPvgQNbNaRnIGrA8jdrWYDW0WvO7AMdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQIf0BDr+vzZiCYTRmn/f/kqhZiX4bckrBeoyjQ5nUI=;
 b=h52Dfb5E2nFZENYtS6zSUbiozyiSJNORXMUsncAKqre85PULKjqw9ZFv6Q+2mG8mzdUH6QIAQb4t8pY5JkBV95hlyV0FcliI9RXaL9JKcsRG9TLhu6cP2ch50ojjFkQVS51gSWWQhbbPHh9gvXuwHps+QBE/6/BQVdQkJzNGOWqJUDkBi4XUempMCRR0Xjptr8Wfye5Q1tPx8fNhGr1j/4c1RN6l7WMqXiG6/ono2TRgXpCcnLaUyyVtVgrdGmgk42j7rRS/IGaPLatsErIICup9nWFf6rBxxr+sFx+VU/6PyPN08qzAtCSuVSCJ37qxV/Q9OjQOXr1YCdIxUI0OzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SE2PPF27A9EBFF5.apcprd02.prod.outlook.com (2603:1096:108:1::80c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:04 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:04 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 00/17] target/ppc: Correct Freescale Book E CPU models
Date: Tue,  6 Oct 2026 17:48:55 +0800
Message-ID: <20261006094921.110871-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SE2PPF27A9EBFF5:EE_|OSNPR02MB9899:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0c58f9-307d-49d2-4e74-08df238f3269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|56012099006|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 6DZPG+GnmpQdsU0seMeCLH8DmShWMz09qrywXCa5OxC1c7UgahXTz4QexKneT1+t/VCtAMRizIeoAIj6VRw2gOEsnJ+hI5bzRNDY4D2wFMtbJisQ+V8xOPflO/SQfJZQQO7CZ7ObhzDZJimMzr1GDXgntGLAAMUboueR2wRzbpVSGYwk1jkKhGaKyIKt5apRB0y5tJic6c7VOsR23ifKwRWg4d6VFtoMgTIvz2SBUHgq5WNSzb1zDETaLjwgpBemK9xVh+UhbvqfOjHff/ZFF2g1Mne1or8TNcjXfkjAaLrxMeOa51FyTbl33g7Wcgi8qncVldhoECc2YZR8s/lRjpr6ibC/nUM6NUzxLm132FhxGHoqRKSPUpg4fuBDbhuh9EMBdEMc0EVSgO21/ivoLuk5Q2MlrvWSnr7UXUS3bIhB0VTk2C00uB8Nd6yBuIe+v834xr2akvZxL2lVG6Wwwlys9a0ThVmQExWpa0GVnXG/SxXAfJzY3xHgVeaX1jRC1NlKqx+zrIY4gAXr6Pp9ecBXBkOl8ldkc4n5dtbolNf5I2QLWOkA/betD9FHNUZ83dGmtx3t6npbKHncqDukIMhQdzYigUDmhTtwKTHFmKNXWsqGfDkNNWD7ZfV00dJNEovuMpZm80ekR4SqHXvevXbfyBREs4QQwKTCuLrvK/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTUramJNMnNJdFRiMllSN0t5aVJOUGl3TXJQYUNDS3VUTS96V3J4MFRzZ0dT?=
 =?utf-8?B?djA3MmtzWkhmcWV6RFVBWk11bEFMSW1Xamp5bGRrYTBPZEl2RVpuZUZjQklr?=
 =?utf-8?B?ZmJDMmJiZzI3WWJuVzVjZmNXNDZyQUhyQnU3d2R4WkhOVUFPNWFYRTU1c0x3?=
 =?utf-8?B?bE9CWmlqV3A5ZHo4elUvRHcyVStIMDgxckVReXIxSFMrVkR2dTRQR3FEVGtl?=
 =?utf-8?B?YldYc3BVUGh4eUFWSHhSaUhoVEhJd25IS08xbGY1QW11cGJ1bzgraC94U0xQ?=
 =?utf-8?B?bUFRMkxReFZXWGp6Z2lwcTQ4SXlQeGFnWVdzYi9rZnBGdHZWblBHT3VZU1BJ?=
 =?utf-8?B?enBLc3dTVFVEck1TS3haVjlubzhBcGdkOFpicVJnVHUvMmVidDZ5QzdZclMw?=
 =?utf-8?B?d3Rra1B2QWV4czJEN0lHL0NhMVA1a0JlZklVY0tnaDJJK0hOU3dhTE5ZV2NV?=
 =?utf-8?B?dHI4eE04Yk5yMTF0Yi9BMmVmN2RGQnZFZlJIVDJ1STZ5SDJMWjlEdVB0b0c1?=
 =?utf-8?B?aW9pV2RvU2tCWjR2OFZ6VzFiYnFlY05mcXRBeW5rS0s3MWx3YTBPaHdTZVNq?=
 =?utf-8?B?T3hhekMyeU1JczJvNmRLMGhCMEkzNGpwQVgzdEhyRHFHZXU0NGVJWGlndzBF?=
 =?utf-8?B?a2hjUUhWT3A3RndZTk5aRnVOYnNoWVdRaS9KOGZaV3NXcitRbkJlVnN3WTFv?=
 =?utf-8?B?QmlwUkxObU9XSUpQM1cyRTdFcW5lcU1RR0Q0cW9JZm42RVJ2clBFMDhRMlFw?=
 =?utf-8?B?QXpDd2NvcU5JU2VvcnRnS1hzOXFiY0U4T2FQb3I0WUprL05kYkNUNUt0N0pl?=
 =?utf-8?B?blB2Q3J6YkJ0U1VvMEIvTGFkMlUzWjh0bW8ydndnWm5aemxBOEh5RmpOM2dW?=
 =?utf-8?B?N09HdXUySEord1EzcCtLeDI3Y2IxQTFabDFjcHNCcm83b2lvV2E2MUY0aWh0?=
 =?utf-8?B?cTYvaUc4UnVKMmNlNjJpa3R4UnhYWFN3a0hRNGRUbXRKb09HVHhKS21LeEhZ?=
 =?utf-8?B?cTB5MVZ4MERRUGU3eVhNdklSMzFGSVpTaGluMkpBN05ZeVdyak9NUTBVcFEv?=
 =?utf-8?B?UDl3L0ZLbG0yZTlsZnFsMDVMZTF6azhIdVlFOGpaUDdRdzFZL0grUzhxVDdI?=
 =?utf-8?B?S0xEcGhxS2kwWEhWajQ5MTdZU0N3bG5ybC91T1hsMFFNZExwb01leXd1bFk3?=
 =?utf-8?B?TENGc3dYc28zZnJRZkNOUkNGSmk1NWFqWDJpWUxvdnN4cTFaMnBkUlloODY4?=
 =?utf-8?B?QklvV1A2Rk92eVA3U3FraUhwSmREeDJaSGE0TlIxVFdJWTFUbFVmOXRPbXdN?=
 =?utf-8?B?ejNIVmVuYUV4TDVBbHFhdDhOYnRwYXcvYTlIMFRBTHN2SU1qcDlzQzd1RUcv?=
 =?utf-8?B?QTJseEJqYStyd2JBTHNuWUNwaHE1WWVXNm1aZEUvV2pKZXk1eEd2THdGL0lC?=
 =?utf-8?B?WFVUdHJ1bWNiZmN0RG1YbUw3SFVqZUNTOWxJYmplZnJtQ1Q3K1RuV1BaN3Uw?=
 =?utf-8?B?M0lMWlpvUjN2Z2xTZUx6SzJwd3dEMDZMY0RYSnM3Rmw4cDMvZzhQUWdlOGo3?=
 =?utf-8?B?V0cxRmtoUzFsd24wR1E4K2p0M2x1UG5jL25EQWFKOXp5Nm5WcWZWYnNYY09P?=
 =?utf-8?B?K2FENE1YNCs2bnNOZlBxUE1FRFRBM2tMejFPOXp2TVhaS0xTdTlOWnowOFU2?=
 =?utf-8?B?MWwxbGFMZktEOUtXcFVGUDZkQmVnMXpNT2o2dDVwcTIvc09Od3NIS3BIN01N?=
 =?utf-8?B?Rm1KMmt2ZUVURlVFdHNDajVad3ZhMkp0TUJta0d5NXJBS0ZaTlIvN3MzVkdq?=
 =?utf-8?B?ZVR5SkFHdEo5RmNhY0h6a2hVeUxXWlNtR09NOWtnWXFlUWxQc09sazArS0No?=
 =?utf-8?B?eU0xaENoV2MwZ2doOUlXalErK1Z1dUF1dG1uNklBZVF0WmpzNEpyMnNRVUJu?=
 =?utf-8?B?emRBYXB1bWhFby9Sa0FObVNMRWFJYzNTTzdJckFQQWpjMnd0dThVTU9YaXJ6?=
 =?utf-8?B?WjB5K0ZVMHB3Z25wNlc1bXRESyt2MitRVWluTDFtZjUvL1EvTVZsVTd4OHRV?=
 =?utf-8?B?bEptNlRESlNEeDVLZm5OZmkvbkdZaXhKN1hJRnJPbGtCNmdBZUdTSkh2aUYv?=
 =?utf-8?B?d0tZUjVzK2ZrcXMxMFhLYkZoc0lmYXZENURqbzFZTUdYRWdQNEU4YU1nT3RN?=
 =?utf-8?B?UFo0bW9HTy9TVmZlQU9WY3BvMXJtaVNUWTRyckppWTJEbG9oN2M2bExwVU8v?=
 =?utf-8?B?Q0FlUmZjV3dQWXJjQmg2QnJYUVFRT3pHQjB0OTNDYStYc21yT252bkJJMmg5?=
 =?utf-8?B?NnAyU2pxSmgyckdwRWwwT3Zrc2RqTmRTSDNxTkVlZ1N3RXlYMk5TUzJDSm0z?=
 =?utf-8?Q?OYK+Y4vsfAczJeJU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0c58f9-307d-49d2-4e74-08df238f3269
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:04.5100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8U2WCIMJsmhD0UwZIX3+8uHE+1bbDo6oRC1Nhrf664Dj7HvuGnWaooRh19SXdHnWVTuJAnwYujqiz+lOu6Zb2VGoBHuAtZij98YF+/mOz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF27A9EBFF5
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

This series corrects SPR access, cache configuration and instruction
availability in the Freescale Book E CPU models. It also adds system
TCG tests for e500mc, e5500 and e6500.

The patches are grouped as follows:

- patch #1-#4, bug fixes to PIR write access, the MAS5 SPR number and
  cache block/line sizes (qemu-stable cc'ed)
- patch #5-#6, complete e500mc/e5500 L1 cache configuration and
  remove redundant e6500 cache geometry bits
- patch #7-#11, register the missing cache, MMU-assist and sevearl
  control SPRs
- patch #12-#14, split the PowerISA 2.05 instructions to several sub-flags
  controlled groups, due to differences seen on the e500 series cores
- patch #15-#17: Add TCG tests for illegal-instruction exceptions, byte
  comparison and parity results, and FPSCR field-mask handling


Bin Meng (17):
  target/ppc: Correct PIR write access on e500 cores
  target/ppc: Correct the MAS5 SPR number
  target/ppc: Correct the e500mc and e5500 cache block size fields
  target/ppc: Correct cache line size for e6500
  target/ppc: Complete e500mc and e5500 L1 cache configuration
  target/ppc: Drop redundant e6500 L1 cache geometry bits
  target/ppc: Register L1CSR2 on e500mc/e5500/e6500 cores
  target/ppc: Register L2CFG0 and L2CSR1 on e500mc and e5500
  target/ppc: Register MAS5 and MAS8 on e500mc/e5500/e6500
  target/ppc: Register PWRMGTCR0 on e6500
  target/ppc: Register IVOR42 on e6500
  target/ppc: Split the ISA 2.05 instruction feature group
  target/ppc: Enable byte comparison and parity on e5500 and e6500
  target/ppc: Ignore FPSCR W/L fields on e500mc, e5500 and e6500
  tests/tcg/ppc: Add Book E illegal instruction tests
  tests/tcg/ppc: Test byte comparison and parity on e5500/e6500
  tests/tcg/ppc: Test FPSCR W/L handling on e500mc/e5500/e6500

 target/ppc/cpu.h                           | 31 ++++++--
 target/ppc/cpu_init.h                      |  5 +-
 target/ppc/cpu_init.c                      | 72 +++++++++++++----
 target/ppc/translate.c                     | 10 ++-
 target/ppc/translate/fixedpoint-impl.c.inc |  6 +-
 target/ppc/translate/fp-impl.c.inc         | 14 +++-
 target/ppc/translate/fp-ops.c.inc          |  9 ++-
 meson_options.txt                          |  4 +
 scripts/meson-buildoptions.sh              |  2 +
 tests/tcg/meson.build                      |  1 +
 tests/tcg/ppc/meson.build                  |  5 ++
 tests/tcg/ppc/system/README                | 22 ++++++
 tests/tcg/ppc/system/boot.S                | 92 ++++++++++++++++++++++
 tests/tcg/ppc/system/byte-parity.S         | 33 ++++++++
 tests/tcg/ppc/system/fpscr.S               | 75 ++++++++++++++++++
 tests/tcg/ppc/system/isa.out               |  1 +
 tests/tcg/ppc/system/kernel.ld             | 18 +++++
 tests/tcg/ppc/system/macros.inc            | 56 +++++++++++++
 tests/tcg/ppc/system/meson.build           | 39 +++++++++
 tests/tcg/ppc/system/unsupported.S         | 31 ++++++++
 tests/tcg/ppc64/meson.build                |  2 +
 tests/tcg/ppc64/system/meson.build         | 33 ++++++++
 22 files changed, 525 insertions(+), 36 deletions(-)
 create mode 100644 tests/tcg/ppc/meson.build
 create mode 100644 tests/tcg/ppc/system/README
 create mode 100644 tests/tcg/ppc/system/boot.S
 create mode 100644 tests/tcg/ppc/system/byte-parity.S
 create mode 100644 tests/tcg/ppc/system/fpscr.S
 create mode 100644 tests/tcg/ppc/system/isa.out
 create mode 100644 tests/tcg/ppc/system/kernel.ld
 create mode 100644 tests/tcg/ppc/system/macros.inc
 create mode 100644 tests/tcg/ppc/system/meson.build
 create mode 100644 tests/tcg/ppc/system/unsupported.S
 create mode 100644 tests/tcg/ppc64/system/meson.build

---
base-commit: 2a0ac9c8ac2d303ca515dc819043409aef18cab5
branch: ppc-fsl-booke

-- 
2.53.0


