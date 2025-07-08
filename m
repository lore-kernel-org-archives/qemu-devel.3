Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A411DC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAA-00025A-Ve; Tue, 08 Jul 2025 16:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uZDg6-0006HL-Fn
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:08:38 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uZDfu-0004cg-1x
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:08:25 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5688dnjC029255;
 Tue, 8 Jul 2025 08:49:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=zfWO9r8hfWNj5
 d8XOMayzM3hpqbgjBU/wAnbAEh+/Pk=; b=J4qe/0/zIc32f/soLzQZdvERMm0i2
 jyIBdqA5wX5AB+5QQakFyUjTbCdsvk8NuKd3sqeSMuG7M1h3iyYilXN4MuEz/Qnw
 /lFszR8rMkJQRSj424spSI2G9twEna+jTFnh+Slu5dn+3q/uRYQdaWRRCUhf3NeF
 sSCvqJUnH6XUJFFD7KeY2vZ99KhYhOetqJKo9llL4n1ZfbEoaa08vv9hZ0EtMZIQ
 jHf6dge6XkslFdu6OQtZPuocIldCOiHm5nflF0QFB2kGcUqaIVA3f1W2ascGzOU2
 CzaBU1dexoW+6VSOhfqk5T7MEZmdC4tsVd0Tc7mcvs40ipOWlxw9Yx0LA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2136.outbound.protection.outlook.com [40.107.212.136])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q25hg7jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Jul 2025 08:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIUQUkWlp7pio8YmPBDQjW5SBnOLrk93qBliLKc4ob07l1YV2x8X9NKj1+9VrUsJsduH0/R01M+3GxYb0bPy8DqwaULiKjCjmBjsW2L4987meZy/2DTEuAt5yrehPOg1I74W57o3xOUVAgcJdedmFDYVRKxcNAdujuOqLCiXOERItGnZMcYU/Dp1/0sNhgPGuX/er+xg0wtpNZ5OPhaKVPE7X5BroNYYkaYxlAI8A7OFkIqZSaYwKHx4khzFcG4Kw7zrUUYLRTx3DN8Ug1brxs6nI3Cb/CcAPnCFJkm5C+bbVMMAaFQ9SPkCiGqjBnI+klrR8z+0jZnstrBKT9xvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfWO9r8hfWNj5d8XOMayzM3hpqbgjBU/wAnbAEh+/Pk=;
 b=XpKUNI5Zi5L44FuvTn05cuICTZaRRDM3H1vS5RVixxenbNf4ttGPY+Mok6ZP2xMHKHN3KSCOcrwO2F6BHtDBQ/MueCbQL86+m7wn9WcJsHnJNZ6g6tvAxfi2oWVWvsuLT7XcubbeziX9jXIypRcXhrmyXyt2HRJm9nWTt9lHZSbdfD1vyrcIChfwC3+S7NmWT5RXxOPce6JX37BDIH7rtTv8rOF70l0BMxGnB5BAbU+JbyGH01ioWhyhGV17oqUF5ksZJkh5Fwmsm5XokUCPEPMccnTJM75Vq540/Zt4+uGcAmof23XKkE+bhIC228furvatKwunGqfEKnrYaJOtMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfWO9r8hfWNj5d8XOMayzM3hpqbgjBU/wAnbAEh+/Pk=;
 b=t11amR1Zy84kdXbUHJS2hcav4IVZNmPv3HL/M/QcJgzwYZN6p0Cdy1l3TEEl6qBNPqltmfYZaCZ70gpTfgxxKtzXRFMuyaybSygkhrthQnLWdyhxMWEqf6da5x1CMSvsEVvz64B7SlkooPWzaAXs0RoFZWP0lFf/S363Xa/cFxTL43jrnNeH0bcsM3GXgjzHoIb8ifNnOgR62in3DabPMhS025QafnOiEDV6lVKTgAanQQ24JmUsTDYh/Bc2nAH0ialR8pJ0scaDsyMQNZWFOJpH/zDO2zmgj0z1alQI5iwUbD4e8iQ7Xwi3jpTqXhSJlyV1p3aI4g9KzW2DmL7Niw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY5PR02MB7011.namprd02.prod.outlook.com (2603:10b6:a03:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 15:49:56 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 15:49:56 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] hw/vfio-user: fix use of uninitialized variable
Date: Tue,  8 Jul 2025 16:49:48 +0100
Message-ID: <20250708154948.483480-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY5PR02MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 72320ea5-071b-40a4-c3c9-08ddbe371667
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0VhM2lHUzJ1YUtNMzFNT2Iwdjh4YlFOaUhEZ21pZnNNZkVWMCtoblNqVmN2?=
 =?utf-8?B?dnRseGh6RkVhT2Y0MllTWjFHU3FGeFNUa3RtLzhkL0RYLzZ6Ym9heVdiVVFU?=
 =?utf-8?B?blhrR3hVdERiQ0Q4THhSYWNRbW1BYmhCWk5lakM3UFYzQTdBRGlFa0pEMlRk?=
 =?utf-8?B?SDIrU1NuSGJkT2twMlZ2RjVHUks1bDBwRjkyU0t6WG5aK2lDcXRuRzRVaVp5?=
 =?utf-8?B?UXVzdzh6NFA2a0cyck5IU0lSWVE2cVZaV3Y4Uld6NERSajRZOHBIaFI3U0xN?=
 =?utf-8?B?bjRoK09Dall2b1JybjVZZEZzaSt5OUhsL2Q0bkdiZUxUM0dsdW9Va2NMenMw?=
 =?utf-8?B?dkpGTFRzZFRqNS9YemdMdTU0TWxqQTBkbks4dVV0TlY3U0ZZeWkwdUEvL3cy?=
 =?utf-8?B?eXdzbHZOeXcrSnhvUVNUTEQyamJhSzM1bXAzVGxIYXNBYnE2NENJQ3J1K2Qr?=
 =?utf-8?B?NDBQQmlrZXpGZDZCTHN6SzBWUDdMQ056OWdreG5CbXZpRjl4MkZqOFROU1RX?=
 =?utf-8?B?MFhDbC9mZDRwUFhUZ3pONGV5cDlhRVJ5djk1eExVNGtFeVhibFJJZnlpUzhT?=
 =?utf-8?B?UUQvK3piYUFNUitIZkNRemhlK1JZMjJXanA0czZCRitiSFV6RExXU3BPNUhC?=
 =?utf-8?B?OVA1LzVvMWRWT0RKMkdvU0pkK2laOW1GNUYyTFZJMUhKeXJoWWVUdUFUd2t0?=
 =?utf-8?B?U2tWbzZJQ2JibmRkbU9BNU1RejUwMzNGYzU1Y1FDZktrRE5uemcxQVY5UzNH?=
 =?utf-8?B?dXQyaWllRTVsZzdxR21XemNnTUdxaW51SkQ2YW5WRXF1WjlsZkV5SFpBRXNH?=
 =?utf-8?B?ZjlDWlNDTDJKUWZtZ0JmWmhnSFlBVGQrL2tnNTRNdHVTYXM2SlhRMkJwREY0?=
 =?utf-8?B?VmFVVENFZy83c3dIeS9iZEZXczhkcTltUWdUZy91NHZPU04xenVweTFFZVVi?=
 =?utf-8?B?V2hqOGdyL2QvVGxEUlVhZ3lTeFkxdThzVGJEcElRalhuVjlvR1FscGJ4RlhE?=
 =?utf-8?B?UzU1R3JPNlBpcGhJbmVDRi9VSlNiUHA3MGRHRGZXdnpzM1JEaFh3TFBFTnRs?=
 =?utf-8?B?eWJoTkVZazVTQ0NLcnNiUW5XK0MvUlpPZE1iWWZjdkpCbE4rbm1VY3NucVln?=
 =?utf-8?B?akdXVHdIdTlYbWppVUY5OUZKbjBXSitPZHNBeUFtYUpWRzNmT003RWY2ejNO?=
 =?utf-8?B?bHV0ckNGSVFqSTJhV0svTVhuWE53ZDFlbXJOY1kwdjVremVrUVRNMVdOU0xZ?=
 =?utf-8?B?K0ZzeldCMUtOazNBeE9pMGRCTnZTSkw3MEdWWlZzRmI4cFU0SHRvZW9OclRY?=
 =?utf-8?B?Wmt3THNoa280UGJkN1JmdXhDcXphSWpObU9LNHZMVEVSeFJsU0dMV1U3bmYv?=
 =?utf-8?B?eDEra3BaRSsvK3dTSjNTR2habmlXZzRlSXJrT1EyOTB1ZVBCWnBuVnNabjRa?=
 =?utf-8?B?VlUvdEJHRXJYV2VOeTlkQkFiNUlqdHZCRlFmeXBxOFBxbzdGWmNtUjVLelRT?=
 =?utf-8?B?MHdTM0d3dGswL2lwOHRKeEt6R3FvdDlSK3RIZnVuMVFHQ1VlYWJoUk9mOVFC?=
 =?utf-8?B?ekFMRTRNU2k1MmxVWkVYNzVNMnplVVd6SEQ5V0tzekdVMElmUEVKaEFzblY2?=
 =?utf-8?B?bFpZU2gxMjJ3aEZPTVlCb3lZTXl4S24zN2ZaRzFYTmtTaWZ0NDNXV3NJdy9F?=
 =?utf-8?B?R2d6ZmVUQ0dxM2VQOGIrY1pzL2ZkU3hhVk1CZVMyRk55YjBUSExBcEpuVzRw?=
 =?utf-8?B?UCtJTUxvVjVBbkJJd2U0RFQrNUpWMUdPQ3dNTmJYN3ZJZi9TZU5JNVkxaEpW?=
 =?utf-8?B?cGEySGxacWFZNlNqT0VMRDZCQk8zRFI2aisraGxMS05BRzJyRGJ0VjRSbGZG?=
 =?utf-8?B?c3lFY3h6bVFiN3VFZHF6YUJ1Tm5Yb25yUlpMdUtDanpSdkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzZIQkh2cmF5L2p5dDZCWUpUR1RmRWpESlNMcGdVbE9ueVk2QVVIeFZNTWR4?=
 =?utf-8?B?TDlFOW4wT2FPOGIvazByVkVUalpWUkl4Q0FrTndTQ1ZtaEg3R2xYWWZxVHlh?=
 =?utf-8?B?cjF6WWsxUHp4OHZBV1VlYlkxZWxBRVdNK3ZGOE1PVFFSWm9HR1ovSmd3UFgr?=
 =?utf-8?B?TnppUmE5akxJNDhaVGhsbk9MQWNXQ3ZhNFhHMThTYWY3V1Jqc2Y0SVMvVnJF?=
 =?utf-8?B?RTZrckNaQXNTaUgvdU9jZXZ3c2xVN2pMVXhwTmJVRmFjUFFPZ0o4MVR5SXMw?=
 =?utf-8?B?SHdmMGxKSmF1WjVhdjBsV2h1Yy9QY3lqQ1ZrTkR5UGtLKzE2Sm82TUtTckFD?=
 =?utf-8?B?RTFMYVRGcFZ2SDlxQ3Y1VTMydjlmNU9VNmpOay9OalV0M01IR0tOVURkK0Nr?=
 =?utf-8?B?TFcrTDJjOWx6RmY5UENIYzVFOWQwZEpYRUREZmRiV1dhcUkvZm5Ta3N5Ym9Q?=
 =?utf-8?B?T3JlS05BNy9qbUdGM3ljTHVlT1c5UUNvb0FEVElnREtXKzJlZXFvTVgvM1dM?=
 =?utf-8?B?eXNoQzJsUDBDaGtDS21IK1NZeE9hMlgxRkM0NXV6TjBRYm5TTFhUZXRwVm9D?=
 =?utf-8?B?cGY5Tm01VmtyMWxiaTBKZXdYYklyZTNHR0pGZ1kyQUZBUVp2NWJCRm5OcnBm?=
 =?utf-8?B?OHo0clppS3gxanZucGwrQW5qa2JObnE3OEhmZjQyUktMNTVnMzFGbFF5OFQw?=
 =?utf-8?B?N1laS2JLTWN2QWwrRW9JSVZlRnFzVm0yWmdiNUVrTmU2c2dkVkd4MndGR0pi?=
 =?utf-8?B?QmlUdmlnc29xdlU0NXFnbHVNRXJobGdDdHFYS1hDTU8wVGYxbUg1bmgwUG0y?=
 =?utf-8?B?bXExVExYRFVuUU1EVnJtZnNBMkdsWWlrTHo2Sm5WVlBsc1NqUnF1SENmQmNG?=
 =?utf-8?B?aVBJclZGb1FPT0x1M0crS0hZeEV5OGc4SmZSTkZuTG0zb0xZZ200U0kvZlJ4?=
 =?utf-8?B?WXd6SWZPT1RrN0QydEIxajAvM0ExWTFnbXdjU1Njblk1cWIydk8xR1ExUlQ3?=
 =?utf-8?B?dWZUeThuYng4ZjJ3N0hHOG1malRuakZKQ1R6VjZCT2oyS2VxNUNxN2xpeTZa?=
 =?utf-8?B?VlZ4R01TcEZMTkVFaXZiUWNRYVBJTXJPeW0xcEtyVTM0blRKYXpRTEp4N29C?=
 =?utf-8?B?S01oeHNxWUJmYnY1UUw5UHdHdlhpaWw2TFdCdFRwZzByS05uNGtpMi9ISUtF?=
 =?utf-8?B?TFZjd0RVYWpjRDVxQVJkVHROVUszZ3dZS2tZblFhdWJwNXNUQVZ6cFNscDJS?=
 =?utf-8?B?QXdKdUZORXBac2dHeEp6by9hbDlORmZPczlQbU1DUk9jVzd3QWZHM2Yxa0hp?=
 =?utf-8?B?UVRBV2NGTDNPaXYxZjdsTk1lN3J6Wk94akEwbkszQnBTOTJuZml6RU9ZeXRp?=
 =?utf-8?B?V3Q5eWxudjFmeGExUU0zWENadHBXYWxCemFkV1YxeFh3YVRlcVQyZmdiZW1T?=
 =?utf-8?B?NTVML0pKTzlLd25wbWsyQ1haUDBsbEkwVkNIaXpYZ3VlTE41eWNOVkFqaHNK?=
 =?utf-8?B?MklnbHMyNEovcGlySkE4L2RWWFRsa1ZoY3k1TGMrV1VQTGIzZ3lVZHhTaGp2?=
 =?utf-8?B?RkJzMkdScGhDNHZFdlRxVGo3cFZPSGdlVW9oRG1yREM1ajVtT1ptL1IzeHdM?=
 =?utf-8?B?cXhNSjVvTVJJNjVaUTh3Sm5nT1lOYlpnbG8vUWNGSTd3ZVhad1Z6djlRRFFw?=
 =?utf-8?B?My9nVS9MVnJsM1c0bWJoNlBSZUp5eitUTElEQjZDaUsrMkNvZjRRMHFMb3hn?=
 =?utf-8?B?azVPZms4Vmp0OUZ2YzFhdlN4aERkaXpWN1pZMUVHZlgzNEVFd2xJRHBIVHB1?=
 =?utf-8?B?TUJvS3dwSm0xSWhiQk9FbHZjNlY3Mm5aWmtWdVJRUmc5SE9KM1F2UTc2dzhV?=
 =?utf-8?B?OS9aKys0VnhEbGZTZWVYM2dZTUorSzYydjZUTmpKVkd5d3dFODBqbi94a2Nh?=
 =?utf-8?B?TEU4cTdhZ01YTmk0aTNTNGFFc1RZV3BYcUVPSkJ5RDNmWUwzZEVxV0VuSGY0?=
 =?utf-8?B?Qk9JdGRvMVl3Y3JLc3ZVd3RabmtrYnhNSEE3cktmUDYvMERTckhSdEZpRnV1?=
 =?utf-8?B?YnQ4aHZYNmJydVFudjBtV1MvQzMwdURhajk0Y094TTBRcGljVTlybVh1emx4?=
 =?utf-8?Q?5iOfgCXAAnJj4yn181YHSesFa?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72320ea5-071b-40a4-c3c9-08ddbe371667
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:49:56.6284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYmJzxkT8N7vLCAUoVZmA38OrU+PIP8x2WKnwMTpdwpObLh7qRAyUwBtlnLCNvApSSmFEZGLnC6sXKzP+VhLuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7011
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEzMyBTYWx0ZWRfX9+kEEJdWXe0v
 AMj5qwqWDYCyPar+VMrKxrpQu+tDL2SfJ384TtO4exLOD5u5ixmx5qRs9S5XhI8a08AM2J/XVkr
 1N4zlsdAg9uqpjqEZf7pKNis+Yd7GExg1nl5enuMqJtfodaBl/5OB+erYTj00qgCHgTCu0sbF/D
 Q06JalZmNQxpytohYc8j8mGOTCbHLPof09XKFyoPAIbr6gdKEYysAStMOnkzW4O4dhE2YPM12j5
 IT4Qp2pM/cL6DXMzHfWzmjYJ2X8J6elz+2jf5gkiu0bZLgBM5C6XunP637dcacoEq8z0o5Phtgd
 qkTivQqb7gevKSxTlzMJiVbmDUqySEaGTxX7RnS6/XQZUBDpZiypMBhJP2GzAE6UsmcuxkC33Xn
 jf3aZ/A5kjM6/sizQi6F8FAFJnXkXD6svDv2/xvUhFgl3TkUnW4YoDoUAvMwgdByAgWfvyTQ
X-Proofpoint-ORIG-GUID: 5fWyvHvP36qpUI71tWM-zJeHdCShUTia
X-Authority-Analysis: v=2.4 cv=N/ApF39B c=1 sm=1 tr=0 ts=686d3e27 cx=c_pps
 a=HmK0iRIFJ2uE5LC4fHCo/Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=ElJsUu_2Y0o_wqdk4xsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5fWyvHvP36qpUI71tWM-zJeHdCShUTia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Coverity reported:

CID 1611805:         Uninitialized variables

in vfio_user_dma_map(). This can occur in the happy path when
->async_ops was not set; as this doesn't typically happen, it wasn't
caught during testing.

Align both map and unmap implementations to initialize ret the same way
to resolve this.

Reported-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/container.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index d318e6a339..d589dd90f5 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -64,8 +64,6 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                               0, &local_err)) {
             error_report_err(local_err);
             ret = -EFAULT;
-        } else {
-            ret = 0;
         }
     } else {
         if (!vfio_user_send_wait(container->proxy, &msgp->hdr, NULL,
@@ -92,7 +90,7 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                                 bcontainer);
     int fd = memory_region_get_fd(mrp);
     Error *local_err = NULL;
-    int ret;
+    int ret = 0;
 
     VFIOUserFDs *fds = NULL;
     VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
@@ -135,8 +133,6 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                               0, &local_err)) {
             error_report_err(local_err);
             ret = -EFAULT;
-        } else {
-            ret = 0;
         }
     } else {
         VFIOUserFDs local_fds = { 1, 0, &fd };
-- 
2.43.0


