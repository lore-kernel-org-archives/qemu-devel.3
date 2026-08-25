Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351D5C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRn-0003sd-4s; Tue, 25 Aug 2026 09:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRl-0003pj-R5; Tue, 25 Aug 2026 09:44:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRj-0002XE-PI; Tue, 25 Aug 2026 09:44:13 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB1ExO1484689; Tue, 25 Aug 2026 06:43:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9QOqqWKcwRF6bMqFPevAO3liNE6q7BwAYiQSDzfh5
 7U=; b=Vt2BUhGDeiorkD+zloGYltu9sx0lLJF+jwyOUSMQvOMJQBTTxSnhQicW5
 aescA7WTLlW61L1PGM4HivxrPltnZ6NHy0so385NHPuXbI2fuv6UCsvsgtZ8MgQL
 R9jsj/LwkhcyEMPhIlaT5WRi5Tiz6k96DqpYB5VnvyPZIviLnqs2+w8WFemkEbIV
 /e/rAr8dB4TInnVxh5A/O6qkoBPCUihgUPxqqwZDpkDT4mf+oWsB9GX/iCZntrW8
 wSwoXKyfSChoCoL0Rs2CCQVokDRwTOBFjPBBCvR71KfkQmCacbmx4TKRyNtgiCI7
 TMubQt0PJJfGphKXk+vgGsW5OyZ8Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020130.outbound.protection.outlook.com [52.101.56.130])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g783qxhxj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQzIrXo2k2UbsA0czDNqMqWFLySa1s/61+3VHAZaa5q/VYzK4NbP3Idu+8I3Fd+8X16HZi2b148e061d/lolwYlZhbx5mbnP2GejopzKHpDNIZgtQ1wP4bCCeIsdNFJRdKIAVGi3KU7iiEFrmD8ASHNpR2jEOFp5LfrkYoUYzhdfX4etIJTeTs88oiy+a/r9v9DobaLQWZ7sDlqUjwxCmBI0QBTR4tCiFjTVXGObNHrdu2BKzbvnJHxEUCCyy++UD3BHBk6ock9+zie44zBLyu8Khb3CNNyIRKlM09UeJhF+uJEe0sRPFuzR8Rsy+BRwh2NY0HaYJhndOSR+mOMGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QOqqWKcwRF6bMqFPevAO3liNE6q7BwAYiQSDzfh57U=;
 b=fwdJXpjtvdb+Nn8lEfdvxm+x9Gsuc8iILr0e3pojduCLOoZa836Lqy0waV9sgk7mwaltCl72iJq5J8bGhfNxd94l+tqEwGFgXXcqDwnrl9Z4q391KdWXXrSj2EznBQN4SdYfOTBZtyLWLHP5mqezNf4wqesF94ug5ElCgwA6fyNXrP/bpqpl3dL6PzM4xLWBQs+Swvv/874r2WxRUN0maeQhTbiYbKUKRw6EQHpBE1TOM0HhrkVdKodgmYxXNXZ20Hc1+IoPsVw3K6so4Nt8HVBUiV9eWh2sRU0kV2+dJMMZyVnsmCa9kLp2w4NOE2feuB3ugG7XDH8USkpQhBcvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QOqqWKcwRF6bMqFPevAO3liNE6q7BwAYiQSDzfh57U=;
 b=SysFH8lWPwZhsa5Kx231rOQF6uUAGk/wuZFEpYGnlvfXkE4pp85eszW0lwkqcpUb7jeB3HbxGYdjlnTZ8SAyE1iDXcLwoas4pZ9rBbv65BQOxeOuh+NdOkUmtB9D6QpOP69phjk0tBhwYrYgb7mSmBi7Xkr/sqWT62y8pysghxeVd7fifnk4xb28hV0iulCEUAEIpRoL3D52SE2PrmR1GklHCITQUNWCunGwisqh2k+Po2Wsa6gPXo+7SNxRo2pnPr/KmcSwANCY/3dITJq+jMZnh2VGF7Ix0IOuU4nseIUhzzq7vnEh+W+6kZ/3btKnRNN3LIB7AUh3couFVxVs8A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7681.namprd02.prod.outlook.com (2603:10b6:303:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:43:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:57 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 11/16] hw/acpi/ich9.c: convert object props in
 ICH9_LPC_DEVICE to class props
Date: Tue, 25 Aug 2026 14:41:32 +0100
Message-ID: <20260825134320.1039012-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0204.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 539b391b-144b-4fd0-e453-08df02aee913
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6/n9ojG2SpjrFBVxbNPfhWJvYuvMZ2XtBCK6W4O0TaoOLTVfWpE+hPw7UtvamjpClTE3x9Q18aPty9z6NsGjl/LK9sA3tteAy0L5gMFV1p28DsCANExk6bwhPfcMdh3moYf4iw2I4SXs7UNWl9PqcRdwsp0QwnyaCwblEsl3rPtWY6sbROTrKE8mA+RX639kVxtbvoTr2r6rmLAfH2yyYaLFH6GZtHwDhuekGlKf2UsfOo2tzogO2Fd1p9rZa4m4gc73kgKNcEA73jlHl9lUD5c5J5lUGb7xEWB2lUvv6KRXxuFKMSzrje8gANCAw4csliwS7S/le67BsT+ucC5WH9PhlD+cQZD45V4IRjaSK/q5rduSrfrTL+MM6AjefiKGkNxcz1PNaHFliHAGHpXP4E2h+q/Lw2h1YSXD7qJkdBW6eM6pLV9Zeg+Z8gMF5wsd4vw4V6GmtCY87HytNkIHGAGV4KZ16F/K+1CsQdf68XAcqR09MvDtaB2tnEfx8F3PeLd9GXJwgdOWGohvVYo+QNHM5E2hWYuGwX1Ng0OZMhFaKyOnjFvhp90EwXsLj02h+BNohH08D14IIHTJEsuYE5Dtn+Rp9+M1P/aiZfSu7vrPu2ehBU59Cgx1TtJwyfdfmY7iwlafl4t1ac1HpAQ2Al+vavlg05Ad4kwE9CO+PK6xfGVVxvLjOdvulUPqFvAngLJ/A8RO+a79nyxUGZLLkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVpEQ2tCaDVPdVhyQnBtVGRJem91cWZZNC96QXZMdU1FOHRQWEg0M1phY01r?=
 =?utf-8?B?UlZJZFh0bXA3bGh5OWVhS242MnJ0a2c0RHZyY09DbzQ2Y2liVHNRekZnWlpW?=
 =?utf-8?B?STZFUFVLbnd6UkhydGdmVlBodnJvM3F0dWw3N1NNSExzVmpCSWNwN0Z3Vjdt?=
 =?utf-8?B?dVB2NCtHczUzVjdwSUkyQjVMaXhJajBzUnFrY3crN2x5WXBSNTNhWFVCZUk2?=
 =?utf-8?B?VmIrdU0vNFZQeFJXQWYwNSsvaE9DMHZRZGdqbUxCb04rSjdQekM2VTU1V3VL?=
 =?utf-8?B?dW1tdFpqT1ZJUHZDbEFFRmQ3eDFLa0JaSWcrQzBBU1JsT2w1cTZ3Nnc0N01R?=
 =?utf-8?B?QkNOYWhod3QydHVsZ3hEQ0FPbW1MU0plSWpOd2pFL1g0MUdSVGhzL2ExN29H?=
 =?utf-8?B?SWk5MzgraVkvSU5KajhLYmlYa1I3aHRlRmRibEs0cEt1bldBU2lheUxKWGU0?=
 =?utf-8?B?cm11b09WSGlOUUQ4ZzMwazdTUWJmUEVrU3NzdG9NUTNEdjJSOG85ZThQamw1?=
 =?utf-8?B?aWFxMlRPdXN0WGdqa0o0cHhuWVI1NU94Y2pUTVJnckMxTDBLUEhqaFZ6WUNY?=
 =?utf-8?B?RVZMcXByUlJZWFV0R0l6cnhtQVNhZEhPYkI5UWdvMHEwd1pjY2pNVVlJM3FS?=
 =?utf-8?B?SGVvY244UzJ1Y2RkU1k2QXVSYnpoWHYyRmdjY0ZSeHBsRVE1TDM1NEI4Y3pC?=
 =?utf-8?B?TXFBV01ZNGE5Wmt2S0ZIZUZObjAzdnJNME5xUlEvYzdqZnhETHZGRDNzZ3No?=
 =?utf-8?B?RmYzZWliMTAwQ1gveE9LQkRoZXRrckJyMVNZYURLekE5ZkhVUkJnUDRwQ1pw?=
 =?utf-8?B?eFkvdy9FR0tRU2I4TlplZXZMNnlHRlprZ2IyN0xhVzV6akpRYUVXUzFkQVRK?=
 =?utf-8?B?aGZkWFRMdjNDTjJTZ3pXV3c5dFA4bjdUTnQwSnFaNTZsUHJhUFdHZnZpbVhX?=
 =?utf-8?B?eFpVS21IbFNxdVV4aWF1RVhSdGlkT05qRVhtd3NsM3dkZmZGejRpejF1UGZL?=
 =?utf-8?B?bGVvbWxMd0hTM2luSi9TamZjTzJXcVJVYVpMTXlhV3hZQUNod0orZDhFRFAy?=
 =?utf-8?B?RlJtaXE0QnZMckRjVjdITU1uQWlabjNaVVRVSXIvSHFoVU5hS25ZUFI2cEs0?=
 =?utf-8?B?SDdxUkZXTlR0NFpQZ1ByMUNkQjhzK1gwNWhPK3E3WG9Jem02a25WZmFRdC9m?=
 =?utf-8?B?cUR3a0lHWG9VKytLbkJyTVBUUHlqdXBjR0pCRGY5WDJSNU51blpnbHpZMU9R?=
 =?utf-8?B?dHB5amIvbXVCUlRIS3RSNE5jR3ZkTWV5YTRwTWcyb0I2WDNjblN3cCtmNndT?=
 =?utf-8?B?WkYwQ0NGL05iZmVEeDFYejV2eTNodW8vb0dKQ0Yvc1pZTlRvSEdjY1h0K2tG?=
 =?utf-8?B?MTZOa2VIK3hacEplVUVyK1k0RHF2VVRqS2JqMHJ6c3JHOWozNGZJanFlOE5C?=
 =?utf-8?B?bEJGTmlCd2E3d1JQZFZrcWMwOGdsNmwyZzAvZWlpTEpKdnZ3R0hON1BDMFpk?=
 =?utf-8?B?UGVJYUc5SVEyUGdZbnJQTGVNQ2tIZHZTakgrZ1dneDRrTVZ3UlFabUc0S3U1?=
 =?utf-8?B?OGMvbGNycGdINGU4Q3VOQ2p4cVdhV2tTU2pOM3J0RUtLTnJ4Y1dGKzIyZmFs?=
 =?utf-8?B?ZHJsSndKN1NkQmp2VjZuR29HRXlZenkwc2tZcmgzaTh2RkJqNmhCYVpnZUU5?=
 =?utf-8?B?OUh2V3Q0VFgyQWtha0xlNVNVL0kyS0gyNlZtMXBRU0lZUmZnQ3NJa2psc0M0?=
 =?utf-8?B?UUFzNVE1TmxKMHJicG0rSzR3TTAzc242MUN4Q0RRV0xoT0dFeGRpbFlJQ0lj?=
 =?utf-8?B?TWY1TWpzWFZzVnN3MVV5S1Qvc3psVU9BL2l3b1l5QTlmbm83cjQyNEs0bjZu?=
 =?utf-8?B?R1o2clhWRTVKRjhIMW9vcFNud1ZrcVNISDJhRGNKM3J1WlpaZHorUUIwVFF0?=
 =?utf-8?B?SVVlcSsvTGRZcnRLTzZVS3VEM3BibStXQ1pBZGE1QXk1NThWcFp2U1JEWnpx?=
 =?utf-8?B?OUpOc2hYc3NnYzNzSVAwaWJiRXRKeEdCNXIzMS93U3I5alRuYlVTUDdRTEQ2?=
 =?utf-8?B?MERtU3RGWVZzL2ZGZVZYQk52c2dmbkZ6Zk9wUU5nLzF4d21BNGVsRmp6OTJI?=
 =?utf-8?B?cU4ybTJqT0NSTWJONlFVVWhlMjFNcThVdVhYaDVBNEd0OElBTDlndWxqMHFP?=
 =?utf-8?B?UDJFN1Y4N0w2eTYrZC92NFQwanNIVGh6ODJ6NlArN1QrSGVVVzhYaVcxWUp1?=
 =?utf-8?B?UnpRUUZhY0tJTnE1MjYwcUtzNWtTbm54aDI4VU9STUFhQk5HcERqY2QveTZr?=
 =?utf-8?B?Y1RPaGxsMTM2YzJwTW9XK3pmRnlTdlQ4N1VLMkV4WWF1L3FSTUVUUWFablJi?=
 =?utf-8?Q?4htjw9Z0TduG73z0=3D?=
X-Exchange-RoutingPolicyChecked: N5G9W8BMiOwe3mf39wpeaw/21/byPl+Fm6z0VkeoBEXP22kgaJUxr9Ttw9Cm8o0n+kFYoVOs2jlWxlXfXS3Wf5XBQnqP2fBzLZl4bo2XdT62u097DM5Vmc6j+XVOhEDTjRYf0J/ommHWJI2NxrhnjfTuaywtGEoNXcrLLcE0zdkBOc7uv8fbV3PLs/k6VgEjqhqjVjks251+Pwz1ghA7jL42bpWT3/lYyyMA0kTGu/cQcmuGSCOcGDbxZSDiqV9zrj7K4OnFn+/sHuT80nFlhU8+3GuCB4PKpIuKx718TniyTvv1w9BqHX7JVNr0Sqksv3oWLgJno8LOs06uBtB0gA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539b391b-144b-4fd0-e453-08df02aee913
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:56.9699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdlSHbt8yoHdq9LZ+dYregt552jIIMmEa38b4sfjQ0U5ln3c8a0hbtS9+O5v0CdSnW0KjbU+sGmyu9g41USpnfKzgkD8htl9TjlPayXpeEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7681
X-Proofpoint-GUID: qTV2DtTx7Vlh47F5V_FJ3YOv3ImZhTyV
X-Authority-Analysis: v=2.4 cv=KdfidwYD c=1 sm=1 tr=0 ts=6a8d9c1f cx=c_pps
 a=ggVxh3PvYhYh/Lb5mCqIcw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=GxT0t2d6BVzUPgZ-n0MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXyiUOs19lJLHK
 CqVNppfwX9LoikGNLw83fMp/iOwepbwwZZ+K+XX7hypvHDs8MrJv+954jh2psL/CeO/ZvgL4nm4
 CIRJaN51ZInpUJWTOMV5YmVt6nnPvfk=
X-Proofpoint-ORIG-GUID: qTV2DtTx7Vlh47F5V_FJ3YOv3ImZhTyV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX8jxw6M+gxIuc
 i1ObhLtLfyTsdQNNZ3qIxNgyvZafDiPfBEEhZNO1Y+pKfu7WbiVljTLIdYe2hdBzjQy2rHcLBcV
 AFeCCaZI+MKt+FrnzYgqVXGsZpuPkanDCyoN1UKNnkzF7FJHD0ezMe1TsH2PTArUQsNb6V85Pn/
 LvdRZBKH3Z2EdRfgCLTLHbMeROuOhLbjAKwdrMeW9wfIecSYWdQhO62Clh43XJIqDKY6R2AYBit
 pf/0hy9qE8nvDSVgDKK7Dzogv/dHfXjB+8V0G6CsLZRVi3gIHsdjou6TFvvHDwRXEbv7vMOM41k
 M/rpTFA348P4VIvAPPwHhw4/TiwiW1s3qiqUbDNkyMJeS7y1MuxgiQDSrQljfud8w6ab+PmEK4C
 GmGgsWfXyCgxtK9Po/rbT5AlKUXHmI7/fleUDlIJnWerNxWLt38mM4tlmWXC9iIbm5IxKKh7m08
 m07CH7wFgnykL8tdOFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

ACPI_PM_PROP_TCO_ENABLED, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE and x-keep-pci-slot-hpc
properties can be converted to use object_class_property_add_bool_ptr(). Remove
the now unused ich9_pm_add_properties() function.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/acpi/ich9.h |   3 +-
 hw/acpi/ich9.c         | 102 ++++++++++++++---------------------------
 hw/isa/lpc_ich9.c      |   3 +-
 3 files changed, 36 insertions(+), 72 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 3fb993bb9e..6d14544751 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -83,8 +83,7 @@ extern const VMStateDescription vmstate_ich9_pm;
 
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
-void ich9_pm_add_class_properties(ObjectClass *oc);
+void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 774b34195f..d6df8db21f 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -349,46 +349,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-    return s->pm.enable_tco;
-}
-
-static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-    s->pm.enable_tco = value;
-}
-
-static bool ich9_pm_get_acpi_pci_hotplug(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.acpi_pci_hotplug.use_acpi_hotplug_bridge;
-}
-
-static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.acpi_pci_hotplug.use_acpi_hotplug_bridge = value;
-}
-
-static bool ich9_pm_get_keep_pci_slot_hpc(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.keep_pci_slot_hpc;
-}
-
-static void ich9_pm_set_keep_pci_slot_hpc(Object *obj, bool value, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.keep_pci_slot_hpc = value;
-}
-
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 {
     pm->acpi_memory_hotplug.is_enabled = true;
@@ -400,35 +360,10 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
     pm->enable_tco = true;
 }
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
-{
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
-                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ);
-    object_property_add_link(obj, "bus", TYPE_PCI_BUS,
-                             (Object **)&pm->acpi_pci_hotplug.root,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
-                        ich9_pm_get_gpe0_blk,
-                        NULL, NULL, NULL);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
-                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
-                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
-                             ich9_pm_get_enable_tco,
-                             ich9_pm_set_enable_tco);
-    object_property_add_bool(obj, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
-                             ich9_pm_get_acpi_pci_hotplug,
-                             ich9_pm_set_acpi_pci_hotplug);
-    object_property_add_bool(obj, "x-keep-pci-slot-hpc",
-                             ich9_pm_get_keep_pci_slot_hpc,
-                             ich9_pm_set_keep_pci_slot_hpc);
-}
+#define PM_REG_FIELD(n) \
+    (pm_offset + offsetof(ICH9LPCPMRegs, n))
 
-void ich9_pm_add_class_properties(ObjectClass *oc)
+void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
 
@@ -436,8 +371,39 @@ void ich9_pm_add_class_properties(ObjectClass *oc)
                                                 ACPI_PM_PROP_GPE0_BLK_LEN,
                                                 &gpe0_len,
                                                 OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_PM_IO_BASE,
+                                         PM_REG_FIELD(pm_io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_link(oc, "bus",
+                                   TYPE_PCI_BUS,
+                                   PM_REG_FIELD(acpi_pci_hotplug.root),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
+                              ich9_pm_get_gpe0_blk,
+                              NULL, NULL, NULL);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S3_DISABLED,
+                                        PM_REG_FIELD(disable_s3),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_DISABLED,
+                                        PM_REG_FIELD(disable_s4),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_VAL,
+                                        PM_REG_FIELD(s4_val),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_TCO_ENABLED,
+                                       PM_REG_FIELD(enable_tco),
+                                       OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
+                       PM_REG_FIELD(acpi_pci_hotplug.use_acpi_hotplug_bridge),
+                       OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool_ptr(oc, "x-keep-pci-slot-hpc",
+                                       PM_REG_FIELD(keep_pci_slot_hpc),
+                                       OBJ_PROP_FLAG_READWRITE);
 }
 
+#undef PM_REG_FIELD
+
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index d3f1358887..b55b5136a3 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -689,7 +689,6 @@ static void ich9_lpc_initfn(Object *obj)
                              IOAPIC_NUM_PINS);
 
     ich9_pm_reset_properties(&lpc->pm);
-    ich9_pm_add_properties(obj, &lpc->pm);
 }
 
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
@@ -920,7 +919,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
                                                &acpi_disable_cmd,
                                                OBJ_PROP_FLAG_READ);
 
-    ich9_pm_add_class_properties(klass);
+    ich9_pm_add_class_properties(klass, offsetof(ICH9LPCState, pm));
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


