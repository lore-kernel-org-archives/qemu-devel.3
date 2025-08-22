Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9133CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQeu-0001ay-Rv; Fri, 22 Aug 2025 08:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQep-0001Yt-8y
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQel-0000em-0O
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:09 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M7qHtr676687; Fri, 22 Aug 2025 05:14:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DwF1VtlVSnRcAdnsRSy2kAhakyuvuz9Nu5UTEr4ZG
 OU=; b=NFtyFGg1larMVRN17sDAwTppRm0QvVzIAkPbZhVkQ9faKVd73VQDaxy3O
 x4jc2dN1dSjAkmr+7obxjqZNIwvEzYdcXKJjXe5aVeAzmY/OKxyVmVj0sv1lU1Yv
 pe5kBTWK23axKF8B/be89fVkxj1sA2CJSvFN5OjqEM91irplpmE8cQ/cCzhSV8OQ
 MpYJM/0ft145oYpWjbx4AGKF11S1Vld73eN9YEln30GQOQzlU4bOhYL58BZKWih5
 B94za4w/N/utcAPwR8bl5QNmBiPBKDQm86HnGMqFeLUNfwAdiYKnOBB5GSJUHt2x
 p6EEh9svqtI3rbtNIjqqrxfS2Nhsg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2124.outbound.protection.outlook.com [40.107.220.124])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye5qema-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8FsWQyaZo3il4PJ8+PG5wIfc5+feh3MMo4fJH3JDzdV/b+2DmxRl74ewOAArqMW9fECITIHAMWdkROeyvrkxtHh86kXggObt0id6zEdwZE2wUxtw2HG6G0qi2lL10m5IZpdtaiw/nUNgvqtOlhdvEleY/SXQaFcHp6iWFekJD7W5dHA+ZxrvJucyyr9j8P9RJdBZORpbhHZV0OHtxO8BNiOvtFk6As3nVAI8AHV0edJIXkmtPUX6eObTzkKAcLvKUEz0VTChwuFh0bBNtufxkz2n/wTKMbv5Dal3SPAGefn76JBBV/IOAACXTnXy0uoamEfJm9OuNuRvTT/Akojqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwF1VtlVSnRcAdnsRSy2kAhakyuvuz9Nu5UTEr4ZGOU=;
 b=KIQpIwjnWob4X2PVpPNah3ZdbVtKtRhTA8SpfvG4pKluEs4SLsjVsMGIYhxVOeSRXbtTUBr0hMi48dikHhCLcFTmDBYZPkon4NCRsEEAy+v4ZcsVARBN6r7OObpNxPY5qoNP1BDMNtqUAlq9/D7hgI+/fLbsWT3BKoLgr2XRLEoGGn0u/MYjGERQqIjfUsJCPIZZ5IvxWJ0nO7caYPae4rkddCGU+dtVStI4mqZjXe7jAlEb+0PozxJhoMVDGmTQv5SJIL7ySIl3PC981yIfbnHNJv/jN1o2wFUGI8lwL/n3KhV9N0ml9dbTI5IjtVEzDZn5/tsFcYOCYn49HMCUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwF1VtlVSnRcAdnsRSy2kAhakyuvuz9Nu5UTEr4ZGOU=;
 b=GKqEQEIEE5N+r+QkVRf9npm6/z5O1qZxvZVhtl5MHBFA+Bt5GwndCPk6UI/EL8aNV6IyrLXr3ZRcivJVO1ScLK3OMNhzcnX3tfmYcjXcBYtUiuPZFod2W6e1bVLc7iHH9bROtm4r+fN+wvmKvb8AQgkjswSXBhyfuns+0TE8uE/MFoA4r6HAl9tQhTOMuJIX9FC5Niq8pqnqevWRJTWFyMwcAj/i47s/U8GmfCRZR8SoMvUS5EC/qRWxQaWhmUHd6RFinhnBQN724NdyYiTomMgGfKR3Yux/W52lOSoKHpV0XspnnXhNJ3rmPMzSR+zH4Q2NYPXbIajsUMR366ZYOw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:00 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 04/19] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
Date: Fri, 22 Aug 2025 13:11:50 +0100
Message-ID: <20250822121342.894223-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a753473-e44c-49e7-9e49-08dde1756081
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWpiN0Z5bXpYcytmVC9pejVZVzRYMndIb3krMnZYeTIyelFuQ0toKzlMYUVQ?=
 =?utf-8?B?alhRRXFXeTZjaDI0Q1JDUEFKVytvankxbmdrdDE3aCs2NTNKVEhxN2F4ZWZU?=
 =?utf-8?B?aVN3VW5ndmhjbkZBRlYzOVJOdEFFTWk2eDNPNzNFK3A1NmpkRG84cWEzRGFw?=
 =?utf-8?B?S3UwYnV0Z3BXb1pSeTdJRUwra1QxVE9TN3JNOEZMZzJQdjMvY0ZGenZLMEgv?=
 =?utf-8?B?a0hpOXRyMEJWNUljcU1HQzQzUmJWMUF3MmlxNmNYSlZjQTk4cXNBSWVRUVpi?=
 =?utf-8?B?bHE3TERWVkJmT2hXZDI5SGJaWi8ybE94aUkrckNWUnhNTXRDaDdBT3YvVXpv?=
 =?utf-8?B?dVVkdW9UMFRwK0VpMFozOC91Y3lNT3p6ZFAvTWNqR3JwZXg4NUVzNUVWVVB4?=
 =?utf-8?B?RXZqM0p5SkJhY0VvTlpGTzAvVWpUK3BYbzBWV2NhTGtBMkxxcjVZSXdTV1FN?=
 =?utf-8?B?aVU3RG93UWNzakJjMkp4VVZ6eVNrSVl3VEZ2OURLb2R3NXNvZ1BRMmhUTDBN?=
 =?utf-8?B?cml5THpwcncvc0dHZURKRXVSOHBlY0F5S08waXhKc3pDRnpOU0oyTkxRR0xY?=
 =?utf-8?B?YXFOV3JXVjMwdVI0WndseEp3ODd3QlN2b21RU0QrREIzZ0NMMEc5VEJkQWFD?=
 =?utf-8?B?T2NaYzlXNmpieDFiNUVwY3kxZlBCNDErQjU3QXN0UmNjbENHWXNUcEx2UzA1?=
 =?utf-8?B?NmpEUElLSmc5M1lsNUZ4RnBxU1laSWNPMkRTY3hkNXVoeFl3Q1Nja2VwL0Zr?=
 =?utf-8?B?K0pickNibkpDMTFDaGdweTZGSlEreDZ4NlplTnVnMjBZaFQ5KzhUd1pYcElJ?=
 =?utf-8?B?SnNBbFp5cGhxTkV6Wk1NMzhwZEh1d2xmdWRZVng2QStvb2t4eUw2K1BGRE5Q?=
 =?utf-8?B?NUtwOTNraU5RdkxNMFNmT2MyZ0pQYUdWd0EzdFBXTjVreXYwbXE4UmloRDA1?=
 =?utf-8?B?a0RZRzhiUnlGMkE3T3lPdVFyaDZFcGRIT3M4b1h0Y0NYblZPV2dlNlFJVENY?=
 =?utf-8?B?TlNQb1djRG9lVFBabThqK296eVJnSzU5ODZEQVFQa0lNS2xLalUzOVhjdHg3?=
 =?utf-8?B?YTRxSHNIWU1ocyt0ZlJDUkg0cDc3eFpIdHlEblZHN0tmUmwrenBrdU1LaDV3?=
 =?utf-8?B?MldnQUNHWjgrSS9oY2Izd2M0NjUyNzBEMUFYOG4zaEZkdTVjV1NkRVNpUFo5?=
 =?utf-8?B?by9hbXFFZy91aWMydGN3d29DU0hvNk9CQ0dFMkN2a1VrckJsbDlQamxybWxL?=
 =?utf-8?B?ZGRIaU9peUxLOHRpb2NrMncySTVKY3lSeHE1eHgweUZ3ZkxPaERLcnBTRkFM?=
 =?utf-8?B?a2NSSmd5dzB5UWhvbjRrRFRWZXRjQVV0NlNITHZ5azFwd1BlMkRVSGdHWFB4?=
 =?utf-8?B?amp3dEx1SGFJWnZqd2pEc0I0QkdYa0FiU0RZblJPaml2ME1GTUhXNjBobDZw?=
 =?utf-8?B?V2NvQXIwYWpvZSs0dTZLdFI5aFRCWlpWSXR3ZzhMNkFaR0thdmVmRTF4cG5n?=
 =?utf-8?B?RXhSaUJrV3JYYURRam1tbkZpQ1lRa3RxVDZETDI3Y3hSOFFZdWl3bVlKUXNh?=
 =?utf-8?B?Q2lzY015M2xvYnR0RW44Vm56WTY4STNHQUVCKzB4ZU1hd2hyV1RNRTB3Tjkx?=
 =?utf-8?B?d0xoSjU4S0o5RFdpRmVJdThxL1ZoYUFCeTJuQk1mU2ZXZ0ZWWmlSVXFlVkV1?=
 =?utf-8?B?M29YVkZ5NEpCQnMxU1ZQczU4QjdFbFluWkJPNWVDSUlwRGxwejNvaFlIS0pq?=
 =?utf-8?B?Q2hpNDh1Nm51N2crWko2aHJuVUY4enkzSGJHSlFENFFvWDdod0t5OUdWTFV3?=
 =?utf-8?B?NHNyVVRXZzIxalNzcDdXaHJvM2tzdVNUTDJxRG5aUExVdVE5bEk5LzJBR2tm?=
 =?utf-8?B?WmQ4S0pETjdxWjZ1eUpKSVZza1p3d21nYXlRalVEcm96K3FxemJNd0VaVGg5?=
 =?utf-8?Q?jGzxBMLqwYw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVxMnZ4WVRzdWViSVNPY2lTMHZ2enNOWW1iN0pmVUdjYXdDRU54RkVaWDhp?=
 =?utf-8?B?UkV4am9LQ1lwRzJQSzFhd2dtRkxtbXBrRnkwblF3bDR3Z0lEVEh2RXpvNHNH?=
 =?utf-8?B?aEQwVHdXZVo5VnpFTHYyWEh0dXkvaTRCNWVrZksyZGZRUE5mS091N0ptczZw?=
 =?utf-8?B?WTlWS1lPM214ajZVMyt5UWlESFl1UVAzUzFacnlpdUNndnF3c1pBa2VQdytI?=
 =?utf-8?B?K0EwTEJrSTFsakdHNy82cFVGU0dJa3JORWo3VkorRkZhTDRyNTljMnJGcHNP?=
 =?utf-8?B?ZjlwbkRycXBVaG41MEsrbHlGQjJnYjIxTGJYQ0xNRkk4SFhqWFBSZDVVNkFO?=
 =?utf-8?B?c052L1RNUVREbXJHZlFUdWw5NCt6c2h3UDgzcjErZDJNRE11OUszMEVWV1BX?=
 =?utf-8?B?dmxDdkdHWU1LNTF3WFFJeE5LZXhYcXlMQ3E3eWpFWW5NMTdtZ1pzN29XZnk4?=
 =?utf-8?B?VHVOVDdVR0FrOGwwN28rU3NzRC9DWTRwOEtnR1ZkT0ppTmthQk9ITjhQYkwz?=
 =?utf-8?B?bExaTS9NR0t0U2JjelRpM0cvMStUM2hzNFhZYzA3L0pmVk9ISkdxMXMrT21H?=
 =?utf-8?B?a3pMSHBWSGsxN25XVXkzb2dnT0FsSG9KWEJqMmNYaDc0YUxMaCs1RGJ2R0ti?=
 =?utf-8?B?MFJ0T1pwUGtKVG43aVc3dXBocFE2OWlmR1JYaEhrYUM4cm9Pa0RCNTkxVktP?=
 =?utf-8?B?YzdHRDRmOVc1a2cvZHJZMWZNdDA4QzFYSkNHODNqdW1XWllGajl0NU14bzI4?=
 =?utf-8?B?eHpadEx6dHQ0RWZlSHQ3aEFucGZodGRQUnBXcTVpd3oySkxhempIN1pjSzUy?=
 =?utf-8?B?WFlYT1AxeitHaC85c0UvWWk5d2U1NThDVWs2cjFoYzNqTi9ONWROYUR1TE00?=
 =?utf-8?B?bVRPZFh0d21NTmVQMFRCLy9lbTVZZE9SUEtxWGZibzdYbXd4YmlJdHphY3lO?=
 =?utf-8?B?NCtkM1g1S3JubnAwRGp2em9WQU1OZW8xQVlBZE9TUkRpOUJhUGhSeGZvV0Vq?=
 =?utf-8?B?cVJXMStkczJkejdWMm5YeXZMS29aNE9pcWJleG5MOUVWVGYrNk00YnA2TURV?=
 =?utf-8?B?eks5MjloNWl0WW5aQ01XUkZpMzdDSlFwTkdGVGZsSUxUL2lnZFF0VTAxRDFC?=
 =?utf-8?B?bHkvd0JuWm1tVFhqYUdMYVVaYnhRNHhkTzRJaDRNc2tuY0ltdnJkVFpYQ3M4?=
 =?utf-8?B?TzFFNllta1Q3eDdUWkp2V0xQdmMwdVNuZFBMY2lpN2xqL21EWW9pRDBvWmR6?=
 =?utf-8?B?OW13ZW1uVXFJeHVJNHFXanFaZ3NuQ3lTVTUzWldzSmowMFIzenVXOXl2YWg5?=
 =?utf-8?B?RHNEUWFwVk96THIwejlyOU1QTEcxLzhUQlhzRHhOSXVzTjVsMHJwYWtWQ3Q1?=
 =?utf-8?B?TmhrL3NWYWRFalhnRzUvQVVwcXhPeEQ2cCsxQWJBR3M2Um9UKytibEpPV0NL?=
 =?utf-8?B?UzcvQUFSZHEwUThpVTdLTytSWkVONXhQNnhEWWNneHlyN1pHYWwzNHY1K2I1?=
 =?utf-8?B?R1RlaldTK2tEWnBTMDFkcEw5eCtoY01tbTJGSU9MRXQvNGNKR1dnZWI3bXEz?=
 =?utf-8?B?WmVnRElOdnNubXJhdDlaSEtmeWYrRTdRVllWZnZha0dZV2Y5c2NpdkFVQkw5?=
 =?utf-8?B?NE5DYnduaDJTOGhhRlBTUDJFcHZuRWJaWXlNaEZ4OWZ0Y3gzc2dKeHEvdTc3?=
 =?utf-8?B?UDRBZWdyazl5bURCbkYyUDBVTUsvNTNrdndTRkU1eHI3eWZaTHdXRHZyQ3FQ?=
 =?utf-8?B?c2pHYk9XNm5kZlhhVzRIcFNwWTN1YTFsOUVnUEZ2QlE1TmVkQ0FlZlIzYi9H?=
 =?utf-8?B?T0c1N3R5eHh4UUZSeEtLeHkzaFlGYWgxdXRvZ2VudytweEh2cTVVbG9Hbjg5?=
 =?utf-8?B?aUhjRE5xTUtGSGJKTm5KTW8zZjlGMnpaTGpmYUNFZ2RJTXBqdjQrcUpUVXdS?=
 =?utf-8?B?SklWZTFCY05seGdRcVlKdXRERlhFTWpRSFJpQmhEcTZwMzF4MjBiYWVnejZp?=
 =?utf-8?B?MSs2TmhqbDhLNUl3QytPaEZxQTE4YmlLUktoeXRDb01QOXdJcDdUYmorRSt3?=
 =?utf-8?B?UHhKcW9KSXVVckRNNk9yRGo1eWxabEtVaUJpTEE0SlFhQVZlcm92eXpKWm4x?=
 =?utf-8?B?TEpMR014ZVFaVHhXc3JFbHlVaHJyVDZ1NnpDZkFnT0FuSW5lSGowT1AxMmNQ?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a753473-e44c-49e7-9e49-08dde1756081
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:00.5097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1o/Enbq/sUVNnTEzbbabFGDsA03msA4R1BEuudjajio7BenTO3B38II/Eebk3lzvU3LImzy1scyG9rC41iNWDVMV0fLZgsFlsgALUapKRGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX+lNZgeejek8h
 FQgPAbikyFbW787aRKjPUs4GbgXcubwiltLHC85+bkPSKjBPZBlsTcm44MJSOG/kyzFIhBRdl82
 PjToetg/KCwSBsAG1FcMtoKKc7Xw5jcWOtjSIbEsHbo+D5qHy66urUCuPxVjlm7bGjCdRYsPneD
 5LkqlDxX4wjVAEYDPYksVQ9NPl4Ps/oPDKXf+XfD+MIkN0aN6CrsoDgH239FcFL7OroOnJSOBM6
 d9oIvaUJcL23y6Lz5EVj96KJhyAsOU4j5cLy3PguoxvBHIK9fI0t9O6nUSeVLJxpe5TdbEP5AsF
 oKxEHgLOn47xBia4Ne6uI7h/9E9CEvTSyafSsdRAPPngBlTLT0NXDhHxGNfYNRrtedFdKsDMEi/
 TIsIEYy4stkYQ1B76GcRS3dqkVNQvA==
X-Proofpoint-GUID: Zwy01-pncgumBGA1sWtXQ-n8VPWkbZ7B
X-Proofpoint-ORIG-GUID: Zwy01-pncgumBGA1sWtXQ-n8VPWkbZ7B
X-Authority-Analysis: v=2.4 cv=bt4VxEai c=1 sm=1 tr=0 ts=68a85f0a cx=c_pps
 a=vjxJhJQncZFfyFE+Ha1XfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=EScErfUSVzH1iicdKiYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

This is to prepare for splitting the isapc machine into its own separate file.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 261 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 260 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 071bf7412e..5b97ad2cea 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -435,6 +435,87 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    const char *pci_type = NULL;
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    Object *phb = NULL;
+    ISABus *isa_bus;
+    Object *piix4_pm = NULL;
+    qemu_irq smi_irq;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *pci_memory = NULL;
+    MemoryRegion *rom_memory = system_memory;
+    ram_addr_t lowmem;
+    uint64_t hole64_size = 0;
+
+    /*
+     * Calculate ram split, for memory below and above 4G.  It's a bit
+     * complicated for backward compatibility reasons ...
+     *
+     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
+     *    default value for max_ram_below_4g now.
+     *
+     *  - Then, to gigabyte align the memory, we move the split to 3G
+     *    (lowmem = 0xc0000000).  But only in case we have to split in
+     *    the first place, i.e. ram_size is larger than (traditional)
+     *    lowmem.  And for new machine types (gigabyte_align = true)
+     *    only, for live migration compatibility reasons.
+     *
+     *  - Next the max-ram-below-4g option was added, which allowed to
+     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
+     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
+     *    but prints a warning.
+     *
+     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
+     *    so legacy non-PAE guests can get as much memory as possible in
+     *    the 32bit address space below 4G.
+     *
+     *  - Note that Xen has its own ram setup code in xen_ram_init(),
+     *    called via xen_hvm_init_pc().
+     *
+     * Examples:
+     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
+     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
+     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
+     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+        if (!pcms->max_ram_below_4g) {
+            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        }
+        lowmem = pcms->max_ram_below_4g;
+        if (machine->ram_size >= pcms->max_ram_below_4g) {
+            if (pcmc->gigabyte_align) {
+                if (lowmem > 0xc0000000) {
+                    lowmem = 0xc0000000;
+                }
+                if (lowmem & (1 * GiB - 1)) {
+                    warn_report("Large machine and max_ram_below_4g "
+                                "(%" PRIu64 ") not a multiple of 1G; "
+                                "possible bad performance.",
+                                pcms->max_ram_below_4g);
+                }
+            }
+        }
+
+        if (machine->ram_size >= lowmem) {
+            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
+            x86ms->below_4g_mem_size = lowmem;
+        } else {
+            x86ms->above_4g_mem_size = 0;
+            x86ms->below_4g_mem_size = machine->ram_size;
+        }
+    }
+
+    pc_machine_init_sgx_epc(pcms);
+
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
      * for the isapc machine, which will provide a much more modern 32-bit
@@ -448,7 +529,185 @@ static void pc_init_isa(MachineState *machine)
         warn_report("-cpu max is invalid for isapc machine, using pentium3");
     }
 
-    pc_init1(machine, NULL);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    if (pcmc->pci_enabled) {
+        pci_memory = g_new(MemoryRegion, 1);
+        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+        rom_memory = pci_memory;
+
+        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+        object_property_add_child(OBJECT(machine), "i440fx", phb);
+        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                 OBJECT(ram_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                 OBJECT(pci_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                 OBJECT(system_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                 OBJECT(system_io), &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                 x86ms->below_4g_mem_size, &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                 x86ms->above_4g_mem_size, &error_fatal);
+        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                                &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+        pci_bus_map_irqs(pcms->pcibus,
+                         xen_enabled() ? xen_pci_slot_get_pirq
+                                       : pc_pci_slot_get_pirq);
+
+        hole64_size = object_property_get_uint(phb,
+                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                               &error_abort);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        pc_system_flash_cleanup_unused(pcms);
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+
+    if (pcmc->pci_enabled) {
+        PCIDevice *pci_dev;
+        DeviceState *dev;
+        size_t i;
+
+        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+        object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                 machine_usb(machine), &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                 x86_machine_is_acpi_enabled(x86ms),
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                 &error_abort);
+        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                 x86_machine_is_smm_enabled(x86ms),
+                                 &error_abort);
+        dev = DEVICE(pci_dev);
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+        }
+        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
+
+        if (xen_enabled()) {
+            pci_device_set_intx_routing_notifier(
+                        pci_dev, piix_intx_routing_notifier_xen);
+
+            /*
+             * Xen supports additional interrupt routes from the PCI devices to
+             * the IOAPIC: the four pins of each PCI device on the bus are also
+             * connected to the IOAPIC directly.
+             * These additional routes can be discovered through ACPI.
+             */
+            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                         XEN_IOAPIC_NUM_PIRQS);
+        }
+
+        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                              "rtc"));
+        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+        pci_ide_create_devs(PCI_DEVICE(dev));
+        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
+    } else {
+        isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                              &error_abort);
+        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+
+        i8257_dma_init(OBJECT(machine), isa_bus, 0);
+        pcms->hpet_enabled = false;
+    }
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (phb) {
+        ioapic_init_gsi(gsi_state, phb);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+
+#ifdef CONFIG_IDE_ISA
+    if (!pcmc->pci_enabled) {
+        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+        int i;
+
+        ide_drive_get(hd, ARRAY_SIZE(hd));
+        for (i = 0; i < MAX_IDE_BUS; i++) {
+            ISADevice *dev;
+            char busname[] = "ide.0";
+            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                               ide_irq[i],
+                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+            /*
+             * The ide bus name is ide.0 for the first bus and ide.1 for the
+             * second one.
+             */
+            busname[4] = '0' + i;
+            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+        }
+    }
+#endif
+
+    if (piix4_pm) {
+        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
+
+        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
+        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
+        /* TODO: Populate SPD eeprom data.  */
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
+
+        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 TYPE_HOTPLUG_HANDLER,
+                                 (Object **)&x86ms->acpi_dev,
+                                 object_property_allow_set_link,
+                                 OBJ_PROP_LINK_STRONG);
+        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 piix4_pm, &error_abort);
+    }
+
+    if (machine->nvdimms_state->is_enabled) {
+        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
+                               x86ms->fw_cfg, OBJECT(pcms));
+    }
 }
 #endif
 
-- 
2.43.0


