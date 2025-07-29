Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDFFC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugkUR-00018p-57; Tue, 29 Jul 2025 09:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugkUC-0007ef-8Q; Tue, 29 Jul 2025 09:35:22 -0400
Received: from mail-dm3nam02on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2405::630]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugkU7-00058b-Hj; Tue, 29 Jul 2025 09:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTmfBc4cOaXvQCyYJTpKNaMsSf7Ei2w5deec4lwaKT5PuMm9tgvfhjC+mLcrbzodxqoj832Gtp3Ah4zGJcTy9aW1YTC0YH3VrtESwu6ePCgSaKGMxVyr8RoI7yoZuYTrP5T5PZk7WiEmMGc2KG6RfFjy/xh/oko/s/AHk2OM2bak3vnQhbviusf/fDm9j1EaO8ekzIVOYeZI0VXl5YSltAj2lTM5zDzR4Et5Nk41O3QXkGv4biYg3OT2A8yhuPTl23p5e1ZutTyH3ivBcGI30AG/RmaXKGtwGit5HNCpIqNGymIyPVorC/iBtD2SirGFZB5Tltj1Y/TX7kxptOObzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1gZOul4LiVj2WYe1fuKT71hWpM4agITEbZ+1ewb9lA=;
 b=n+PhqcGcZsancEO23vlsFmNFWG70hz07YJYOO2x+DCS+lUAxIpeuhvykVCq0trDlzZhcAh81jknZkwcAUdBp9OJag/7r9DwQRe/82uVjC8nJwPF2j6gCWAAHeI0DsyT7wA3fI63Bdd+e0I3lKPwfCQarGxn6EuVDrUXgekOGkFJU2akrmXKUWFQ+7xhklbP2W50Z0waSqjv3FcIRFm7keSP+fFE0PFXnEI8J7q+x6DsYM7l+2TXIycp8KM2RNzizBNVUVoFBqCHGLiFFPFwV2nkCR0wk9EZbU+kfD205DEfCA0HbJdEC4p5DZn3aRbwVXtTlHtFqS8KAobCZ92DGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1gZOul4LiVj2WYe1fuKT71hWpM4agITEbZ+1ewb9lA=;
 b=fxDnYfDl9UeXe6tXLsV88L648PAWsHb04b/XcNPCnxdTh5KCcqtq8qZyNASLfomLotkX/ZptYrpjfXQGR2OcyQB9atKurqgsDu4EbJqhEaDlG5KRE12hHIFMDMJLkiNPNvNRtjF15OKzL/tPBJQ0Y63XUiRPmAVXZZ/raEkLvhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 13:35:05 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 13:35:05 +0000
Date: Tue, 29 Jul 2025 15:34:59 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 12/48] hw/arm/xlnx-versal: ospi: refactor creation
Message-ID: <aIjOA/NLwyTP/oVf@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-13-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-13-luc.michel@amd.com>
X-ClientProxiedBy: AS9PR06CA0682.eurprd06.prod.outlook.com
 (2603:10a6:20b:49c::27) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|LV9PR12MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 133714a0-717e-4470-3576-08ddcea4ba5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm5BUmNiUkx5VFJmdGtsNEhhV0VkUzZLSzB5WWtVYTRhdVBqVXNEajd5alpm?=
 =?utf-8?B?Mk92NnhMYjRDUlhiS0RZdzVydzJQS1VLQW4vckxKREhhQXR6SFZWb2pySng0?=
 =?utf-8?B?Q2kvVCtEUnhUSFJNbjNveE9HQ1NwaEgyWDRuODArakZNdGxMd2FEeHAyeDVj?=
 =?utf-8?B?M3Z6TXNrVHVTQldyYlZCQXkyNkgxWUFMei9uWjNUaFR4TlpnNyszdHFLZGpl?=
 =?utf-8?B?eXIxR2F2dURMQ3lnUy8zYTNmTUgzdTlIRE1JaUh1WjVicW9xQWVIMEdPNEFC?=
 =?utf-8?B?clAyQWpCZXozNEhWK1Awc2tsNit4ajNHZ0NUeUpvRmFobUhRMi9iUjFML2VF?=
 =?utf-8?B?dVZzcFRxQld2MTVZSDMzdEpHbUg3a3VlNEhBa1AvSXJvWlVnU29SdnZYd3ox?=
 =?utf-8?B?K215aW84dkZjSzN5eFhnRnFIMnA1RENZbE44WGFKa0VIVm1WVnJvV2dHNU1w?=
 =?utf-8?B?UklpMURnRDdTMDZrSy9DNXlvbmxBZFdsWlRvRk5naTJYeElCaW9SbHhMMXZY?=
 =?utf-8?B?VXBSRzdiMENkYUVjYzZJL2huaXk1dFoxQi9YYTFPQS9TUk5ZTCszWGpUNnlH?=
 =?utf-8?B?U1pTT2liMVowZWVnU09hdXRpUFhhQllERy9mMTM3Ni9WMHpWcUpCUzdkMUg0?=
 =?utf-8?B?UC8yU3FuNCtUKzRyTktXRlFORUc2WFVVREVyZGNQeG5qZklKeGRXQ1VLNnYv?=
 =?utf-8?B?bWZJakZUU2dWZVJZZW5jUElwY3JjUC9EOFl0a0VkUmZXTTJ5K0V4YzJNdCtk?=
 =?utf-8?B?WFVxcG9CRnREWjM2RER0SFU1Wi9zTFlmZDJlQyswb0RpZU13RGNaejlidGo1?=
 =?utf-8?B?TXg4dytDSXYrd05IMzhwQjVIM1Z6Q1FVNnh2a04xZTRpbXQ1cjFCem5WZVZS?=
 =?utf-8?B?ZzZIY1JtSVA4OWZhbnh4T1M3TmdRTG56U29uTXRvTFlOSjJmaHpOeG13bGdZ?=
 =?utf-8?B?TzVyblFyZzl2dWxaMnlJcFJNcFE4c1U1UTRyZEVyU21Qdm04TmprMzY2TGh4?=
 =?utf-8?B?b0l2VTBBbE1CVGE4VGNCZjMzWHhaODdNZkFReGIrVjVtaWt6TEJTWkVlamZK?=
 =?utf-8?B?a00zUmVYUElxNCtxNGR5VHVYSW8zQko2RFJLbHFMbWp3eTNoakFWRzBITUtX?=
 =?utf-8?B?VVA5VDE3Vi9RLzJ0dFQwMDBHeHBsNmxteE5mYnJ0dTRKSnVqNTBuZ01XU2ll?=
 =?utf-8?B?SzZFdzVZdHEwdkJSWW5naGV2b1pVTFZCNExtTERIK3ZWRHpZQk90STA0Vzho?=
 =?utf-8?B?cGFNeTk4bDFXM25jMUFCUzFaQ0pvZW53cENPRkVQeEJkSVpsV3BSR2s1TjZI?=
 =?utf-8?B?d2FXMThCMkhJWlVBUUZsQUEzVGlZN3RuRzRXeFFUR1FYZlZIOVpSSVRwNFpn?=
 =?utf-8?B?S0hYK2FySHVDbDB0VllZaVgvZGJndGZqcGxQRU54NjZ4SWN4VG5Ea3V6QW5l?=
 =?utf-8?B?eTNFMDJCcGJQYWRYQmc1dUpRY0RldW1WcDR2SjNrME1MNk1sODQ2dFVaKzMw?=
 =?utf-8?B?SkMxVjBxTDZSaGJrdUk5UmlpK05Xc01MQ0E4MXRPNHljQ2pmbzdwbVJKWGVx?=
 =?utf-8?B?V3F1THAxQXhxYXBIdGk3M2t5NDByendpQXpBMWZqWUZycWNtYUswMnFwOW05?=
 =?utf-8?B?N2ltQ2NXeDZQWlJWNjNyN2piVUxOR0IzNm41SkJOY3Z3QUwyNEwrb3AyYlI0?=
 =?utf-8?B?cXJlazRsKzVqcTMzOVk3NDNkVkR1N0w3UkY3STlzd1ErbUxEaEhqVFF6MDJZ?=
 =?utf-8?B?QTA0TytpTjhIamJGQktxcVFuRi9QbU9mZGZFR2lzNG1tT2VNN1BZVVNjNGR3?=
 =?utf-8?B?R1NyeUJpUm5DVGwvQ254ZHJoWDhIUlFLb2FkTGlxaFhveCtCVUZwckVUUUE4?=
 =?utf-8?B?MjdtVHhTNDZqVkZPNzQ4TlQxUm4xSWVMT3Bta3JoTWsrUnk2RmhmTnFZbjRx?=
 =?utf-8?Q?NcezNAr0upA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alpqTEs0N3FIREdOaXpRYlcvd1B0VE9idUpFY3k1UnJkclJCdkhHMksxK1Nt?=
 =?utf-8?B?Z3UzZ1ZmZkhDRzlBZDFBOWg3ajYzR1dIczZIU0xjZEdyWVBSYmFpMXdmc0p6?=
 =?utf-8?B?MEJIWDNXZExtUFNoMHhtNFNPTVVlMitORXU0QXFoUnNZV21ra3I3K3d1aktW?=
 =?utf-8?B?cmdYSWxSWldoaUcrbDFUbk9BdEl2RTFQZFJ6cGRTQ1B5MzZXSTcxNnlUWHRC?=
 =?utf-8?B?VTF0UjNGVmhmaHVHUWg2ZVgyUDBpVnIvbTQvZE5KR2FNNkVaRmtiNU5YTFhE?=
 =?utf-8?B?eDRpR1ZoeXR2NkhEcjBOUm1wL2gzSGszUER4WEl1eUdiM0xEVjZZemh6UDcx?=
 =?utf-8?B?Q3RRRHpOMWJBQVhKL3k3aFA3ODhHR3hFcEVaRWFFQVZCM1hPZGRRL1hNL0hE?=
 =?utf-8?B?cFQyMEt4b3l3V1VsMnVRQW0wTlhFTG95K0FodmFKOHBzcG1UZjViQ0E2UEVa?=
 =?utf-8?B?RjU5SDNUOTNPL2lVd2NjRFdkNEtkckVBNEhmNTZjMGlNY3daamQ0V3duUHVI?=
 =?utf-8?B?OERsMFNPa2ZLaU8xSzZmUlo3K1NLbHVSa2IzK2pFUi9nZXY0TVduTjQ2Zysx?=
 =?utf-8?B?ZDZmNG5TTEZIWUNEQTFDV0YwL1l4ZkpIM2IwYnc3MVQ5U0ZYY2ZzNjVCRk9v?=
 =?utf-8?B?QzBWV3JkSG9zM2tOOW5ieXhRb2xVRS9ZY1hxYUN5R0JmTUQ2MWtrTU9HYXZi?=
 =?utf-8?B?Rk1VWkJmMUZHbE5iN0Y0azRMWVVZL2cyWlNXcUI3Zks0WTNTM2ZKN0pNWnBV?=
 =?utf-8?B?NkQ3a3o0QWlZbGVzTjNOWWd2TE5CbkpxcTdqT2ZubnFmMEUxUnBCaUVTWkc1?=
 =?utf-8?B?dGNxdW01NlFaZlpLd2dzWUJFaVlYT0diYUpFRlBrL29uMGt4TUhBU1NVZnVC?=
 =?utf-8?B?VXNsUTFEZ1hsVjV4WEFCWTQ0cU16bkR1eENvSFg1b2ZzamVONm9CNlBHeDNT?=
 =?utf-8?B?WnlXOFBsQlgwNkZveC9NcjM5dFl5eGxuajI0Q21hZko2Y1VKY0dFUCtHYThJ?=
 =?utf-8?B?d25hbG8yR3BiMzBDTXBuQlkxZW4yazNtWllBVzIyZkNhcWxKdEoxRzRRS0Fl?=
 =?utf-8?B?c09IZ0kxY3JZRGh4RFoyK1Bud3VrNmQ2RzVlNEdWNGhnSzdhK1dCRCtqOW82?=
 =?utf-8?B?SHoyMWVwUWgveVlvZ2dyVFk3S0FLNVZTb2xnc2JDbHhabXhoU2tVSTVQNmhy?=
 =?utf-8?B?Yy9LSlRLYUFlLzRnVHNhNmRNelVZeHVWdml0Sm0zTXg0aHlBVk4vUExVdjdh?=
 =?utf-8?B?WldtUUwyd0oxdGkxdm5aRTJDUGhValA3S1FlM293T3M3T0N1V05jRkQrMkxE?=
 =?utf-8?B?OVFPSGhXdG4yVktxdU1URGs0SWRCVFlGTFZYTFVUcnJBejdPOU9vYzRsRkJP?=
 =?utf-8?B?VSt6VWphbEtvcGcvUFFCM1NST3ROQmoxbGgzL3phQXBUZkpWTTQ3NGV3WHBG?=
 =?utf-8?B?RXhXR3N4UStKQkJ6NkljRkpsa2w3MFEvTDFydWk2U1FWQms0S0tGZUtyaFcw?=
 =?utf-8?B?b3VYM1Mwa3BGODFhamtSUTZvNWVtYXQ0UTR5ZE1TcFJSN0hSK2RiS2I4ZDQ0?=
 =?utf-8?B?UmJKVUxBR2FrY1FQM21mRkJTalp5NnZJcTgvY09NUXdPSURJbndDY3k2RDFh?=
 =?utf-8?B?WVNXUkprQzgrczg3SDNGRFlhYmRKbUNSeTRTQW9zZEVjZ3VoODNlR3dPSGgv?=
 =?utf-8?B?OGRGcVY3WXMwY1N2aUJIcUszc1NKdzM5cFRhRlNucEdhaStrRFVKYW9pUkgw?=
 =?utf-8?B?ekxoZHloWTRJczlpZmhaa1doRFYrU24xdjlKMm1zMm5INjVQNWVqUUhYaExn?=
 =?utf-8?B?SnU3MHpQcCtwamxyYnp3OENNQS84WW9sOUZ5Ujl4S0VxQm1UY3k5eDFqMmty?=
 =?utf-8?B?TXFNVFdjZlAvMkw5bHlYVUdqTWVhZHlCamIvQmhBMmJaLy9tQmxNenVBMFc5?=
 =?utf-8?B?ZEFXN1U4S1J1aVVzNFRsaEZPOTB0N3RGb0RQZmtNQVNoNmhTRXBKazJvSkgr?=
 =?utf-8?B?czcwcmNhREJJWTRBSG5EYTVYTisrTkVqbkRoYitNdy9YNkNIb1ZjOGgvdnNE?=
 =?utf-8?B?L0owNXVpY29vdVpVREx0K0c0Zi9BeVVyOUllUDVrY01SQlEzSnczajI0RTBu?=
 =?utf-8?Q?HccGH7F1x9kmPUXYElcjOFaD5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133714a0-717e-4470-3576-08ddcea4ba5f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:35:05.6870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeQ3UBzY+G1BY73N9N67/HqUqe9grgzqYjg6Tmlaoicr6Fhk7DOufGR5NJ66pZE7BEkp8SnfBmkNRGq9ZTGxIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759
Received-SPF: permerror client-ip=2a01:111:f403:2405::630;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 11:53:54AM +0200, Luc Michel wrote:
> Refactor the OSPI controller creation using the VersalMap structure.
> 
> Note that the connection to the PMC IOU SLCR is removed for now and will
> be re-added by next commits.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  12 +--
>  hw/arm/xlnx-versal-virt.c    |  41 ++++------
>  hw/arm/xlnx-versal.c         | 142 ++++++++++++++++++++---------------
>  3 files changed, 98 insertions(+), 97 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 79ca9b13321..b7ef255d6fd 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -18,12 +18,10 @@
>  #include "hw/or-irq.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/nvram/xlnx-bbram.h"
> -#include "hw/ssi/xlnx-versal-ospi.h"
> -#include "hw/dma/xlnx_csu_dma.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
>  #include "hw/misc/xlnx-versal-trng.h"
>  #include "net/can_emu.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
> @@ -86,18 +84,10 @@ struct Versal {
>  
>      /* The Platform Management Controller subsystem.  */
>      struct {
>          struct {
>              XlnxVersalPmcIouSlcr slcr;
> -
> -            struct {
> -                XlnxVersalOspi ospi;
> -                XlnxCSUDMA dma_src;
> -                XlnxCSUDMA dma_dst;
> -                MemoryRegion linear_mr;
> -                OrIRQState irq_orgate;
> -            } ospi;
>          } iou;
>  
>          XlnxZynqMPRTC rtc;
>          XlnxVersalTRng trng;
>          XlnxBBRam bbram;
> @@ -134,10 +124,12 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
>      s->cfg.fdt = fdt;
>  }
>  
>  void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
>  void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
> +void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
> +                              BlockBackend *blk);
>  
>  int versal_get_num_can(VersalVersion version);
>  int versal_get_num_sdhci(VersalVersion version);
>  
>  /* Memory-map and IRQ definitions. Copied a subset from
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index d3c84d1955a..43f3c3d0be9 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -46,12 +46,12 @@ struct VersalVirt {
>  
>      CanBusState **canbus;
>  
>      struct {
>          bool secure;
> +        char *ospi_model;
>      } cfg;
> -    char *ospi_model;
>  };
>  
>  static void fdt_create(VersalVirt *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(s);
> @@ -379,19 +379,19 @@ static void sd_plug_card(VersalVirt *s, int idx, DriveInfo *di)
>  
>  static char *versal_get_ospi_model(Object *obj, Error **errp)
>  {
>      VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
>  
> -    return g_strdup(s->ospi_model);
> +    return g_strdup(s->cfg.ospi_model);
>  }
>  
>  static void versal_set_ospi_model(Object *obj, const char *value, Error **errp)
>  {
>      VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
>  
> -    g_free(s->ospi_model);
> -    s->ospi_model = g_strdup(value);
> +    g_free(s->cfg.ospi_model);
> +    s->cfg.ospi_model = g_strdup(value);
>  }
>  
>  
>  static void versal_virt_init(MachineState *machine)
>  {
> @@ -480,42 +480,31 @@ static void versal_virt_init(MachineState *machine)
>          s->binfo.dtb_limit = 0x1000000;
>      }
>      arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
>  
>      for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
> -        BusState *spi_bus;
> -        DeviceState *flash_dev;
>          ObjectClass *flash_klass;
> -        qemu_irq cs_line;
>          DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
> +        BlockBackend *blk;
> +        const char *mdl;
>  
> -        spi_bus = qdev_get_child_bus(DEVICE(&s->soc.pmc.iou.ospi), "spi0");
> -
> -        if (s->ospi_model) {
> -            flash_klass = object_class_by_name(s->ospi_model);
> +        if (s->cfg.ospi_model) {
> +            flash_klass = object_class_by_name(s->cfg.ospi_model);
>              if (!flash_klass ||
>                  object_class_is_abstract(flash_klass) ||
>                  !object_class_dynamic_cast(flash_klass, TYPE_M25P80)) {
>                  error_report("'%s' is either abstract or"
> -                       " not a subtype of m25p80", s->ospi_model);
> +                       " not a subtype of m25p80", s->cfg.ospi_model);
>                  exit(1);
>              }
> +            mdl = s->cfg.ospi_model;
> +        } else {
> +            mdl = "mt35xu01g";
>          }
>  
> -        flash_dev = qdev_new(s->ospi_model ? s->ospi_model : "mt35xu01g");
> -
> -        if (dinfo) {
> -            qdev_prop_set_drive_err(flash_dev, "drive",
> -                                    blk_by_legacy_dinfo(dinfo), &error_fatal);
> -        }
> -        qdev_prop_set_uint8(flash_dev, "cs", i);
> -        qdev_realize_and_unref(flash_dev, spi_bus, &error_fatal);
> -
> -        cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
> -
> -        sysbus_connect_irq(SYS_BUS_DEVICE(&s->soc.pmc.iou.ospi),
> -                           i + 1, cs_line);
> +        blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> +        versal_ospi_create_flash(&s->soc, i, mdl, blk);
>      }
>  }
>  
>  static void versal_virt_machine_instance_init(Object *obj)
>  {
> @@ -540,11 +529,11 @@ static void versal_virt_machine_instance_init(Object *obj)
>  
>  static void versal_virt_machine_finalize(Object *obj)
>  {
>      VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
>  
> -    g_free(s->ospi_model);
> +    g_free(s->cfg.ospi_model);
>      g_free(s->canbus);
>  }
>  
>  static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
>  {
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index ed202b0fcda..58176fa11e5 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -32,10 +32,11 @@
>  #include "hw/net/cadence_gem.h"
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/misc/xlnx-versal-xramc.h"
>  #include "hw/usb/xlnx-usb-subsystem.h"
>  #include "hw/nvram/xlnx-versal-efuse.h"
> +#include "hw/ssi/xlnx-versal-ospi.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -93,10 +94,19 @@ typedef struct VersalMap {
>      struct VersalEfuseMap {
>          uint64_t ctrl;
>          uint64_t cache;
>          int irq;
>      } efuse;
> +
> +    struct VersalOspiMap {
> +        uint64_t ctrl;
> +        uint64_t dac;
> +        uint64_t dac_sz;
> +        uint64_t dma_src;
> +        uint64_t dma_dst;
> +        int irq;
> +    } ospi;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -126,10 +136,17 @@ static const VersalMap VERSAL_MAP = {
>  
>      .usb[0] = { .xhci = 0xfe200000, .ctrl = 0xff9d0000, .irq = 22 },
>      .num_usb = 1,
>  
>      .efuse = { .ctrl = 0xf1240000, .cache = 0xf1250000, .irq = 139 },
> +
> +    .ospi = {
> +        .ctrl = 0xf1010000,
> +        .dac = 0xc0000000, .dac_sz = 0x20000000,
> +        .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
> +        .irq = 124,
> +    },
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -807,99 +824,78 @@ static void versal_create_pmc_iou_slcr(Versal *s, qemu_irq *pic)
>  
>      sysbus_connect_irq(sbd, 0,
>                         qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 2));
>  }
>  
> -static void versal_create_ospi(Versal *s, qemu_irq *pic)
> +static DeviceState *versal_create_ospi(Versal *s,
> +                                       const struct VersalOspiMap *map)
>  {
>      SysBusDevice *sbd;
>      MemoryRegion *mr_dac;
> -    qemu_irq ospi_mux_sel;
> -    DeviceState *orgate;
> +    DeviceState *dev, *dma_dst, *dma_src, *orgate;
> +    MemoryRegion *linear_mr = g_new(MemoryRegion, 1);
>  
> -    memory_region_init(&s->pmc.iou.ospi.linear_mr, OBJECT(s),
> -                       "versal-ospi-linear-mr" , MM_PMC_OSPI_DAC_SIZE);
> +    dev = qdev_new(TYPE_XILINX_VERSAL_OSPI);
> +    object_property_add_child(OBJECT(s), "ospi", OBJECT(dev));
>  
> -    object_initialize_child(OBJECT(s), "versal-ospi", &s->pmc.iou.ospi.ospi,
> -                            TYPE_XILINX_VERSAL_OSPI);
> +    memory_region_init(linear_mr, OBJECT(dev), "linear-mr", map->dac_sz);
>  
> -    mr_dac = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pmc.iou.ospi.ospi), 1);
> -    memory_region_add_subregion(&s->pmc.iou.ospi.linear_mr, 0x0, mr_dac);
> +    mr_dac = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_add_subregion(linear_mr, 0x0, mr_dac);
>  
>      /* Create the OSPI destination DMA */
> -    object_initialize_child(OBJECT(s), "versal-ospi-dma-dst",
> -                            &s->pmc.iou.ospi.dma_dst,
> -                            TYPE_XLNX_CSU_DMA);
> +    dma_dst = qdev_new(TYPE_XLNX_CSU_DMA);
> +    object_property_add_child(OBJECT(dev), "dma-dst-dev", OBJECT(dma_dst));
> +    object_property_set_link(OBJECT(dma_dst), "dma",
> +                             OBJECT(get_system_memory()), &error_abort);
>  
> -    object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_dst),
> -                            "dma", OBJECT(get_system_memory()),
> -                             &error_abort);
> +    sbd = SYS_BUS_DEVICE(dma_dst);
> +    sysbus_realize_and_unref(sbd, &error_fatal);
>  
> -    sbd = SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_dst);
> -    sysbus_realize(sbd, &error_fatal);
> -
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI_DMA_DST,
> +    memory_region_add_subregion(&s->mr_ps, map->dma_dst,
>                                  sysbus_mmio_get_region(sbd, 0));
>  
>      /* Create the OSPI source DMA */
> -    object_initialize_child(OBJECT(s), "versal-ospi-dma-src",
> -                            &s->pmc.iou.ospi.dma_src,
> -                            TYPE_XLNX_CSU_DMA);
> +    dma_src = qdev_new(TYPE_XLNX_CSU_DMA);
> +    object_property_add_child(OBJECT(dev), "dma-src-dev", OBJECT(dma_src));
>  
> -    object_property_set_bool(OBJECT(&s->pmc.iou.ospi.dma_src), "is-dst",
> -                             false, &error_abort);
> +    object_property_set_bool(OBJECT(dma_src), "is-dst", false, &error_abort);
>  
> -    object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_src),
> -                            "dma", OBJECT(mr_dac), &error_abort);
> -
> -    object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_src),
> -                            "stream-connected-dma",
> -                             OBJECT(&s->pmc.iou.ospi.dma_dst),
> +    object_property_set_link(OBJECT(dma_src), "dma", OBJECT(mr_dac),
>                               &error_abort);
>  
> -    sbd = SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_src);
> -    sysbus_realize(sbd, &error_fatal);
> +    object_property_set_link(OBJECT(dma_src), "stream-connected-dma",
> +                             OBJECT(dma_dst), &error_abort);
>  
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI_DMA_SRC,
> +    sbd = SYS_BUS_DEVICE(dma_src);
> +    sysbus_realize_and_unref(sbd, &error_fatal);
> +
> +    memory_region_add_subregion(&s->mr_ps, map->dma_src,
>                                  sysbus_mmio_get_region(sbd, 0));
>  
>      /* Realize the OSPI */
> -    object_property_set_link(OBJECT(&s->pmc.iou.ospi.ospi), "dma-src",
> -                             OBJECT(&s->pmc.iou.ospi.dma_src), &error_abort);
> +    object_property_set_link(OBJECT(dev), "dma-src",
> +                             OBJECT(dma_src), &error_abort);
>  
> -    sbd = SYS_BUS_DEVICE(&s->pmc.iou.ospi.ospi);
> -    sysbus_realize(sbd, &error_fatal);
> +    sbd = SYS_BUS_DEVICE(dev);
> +    sysbus_realize_and_unref(sbd, &error_fatal);
>  
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI,
> +    memory_region_add_subregion(&s->mr_ps, map->ctrl,
>                                  sysbus_mmio_get_region(sbd, 0));
>  
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_OSPI_DAC,
> -                                &s->pmc.iou.ospi.linear_mr);
> -
> -    /* ospi_mux_sel */
> -    ospi_mux_sel = qdev_get_gpio_in_named(DEVICE(&s->pmc.iou.ospi.ospi),
> -                                          "ospi-mux-sel", 0);
> -    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "ospi-mux-sel", 0,
> -                                ospi_mux_sel);
> +    memory_region_add_subregion(&s->mr_ps, map->dac,
> +                                linear_mr);
>  
>      /* OSPI irq */
> -    object_initialize_child(OBJECT(s), "ospi-irq-orgate",
> -                            &s->pmc.iou.ospi.irq_orgate, TYPE_OR_IRQ);
> -    object_property_set_int(OBJECT(&s->pmc.iou.ospi.irq_orgate),
> -                            "num-lines", NUM_OSPI_IRQ_LINES, &error_fatal);
> +    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", NUM_OSPI_IRQ_LINES,
> +                            map->irq);
>  
> -    orgate = DEVICE(&s->pmc.iou.ospi.irq_orgate);
> -    qdev_realize(orgate, NULL, &error_fatal);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(orgate, 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dma_src), 0, qdev_get_gpio_in(orgate, 1));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dma_dst), 0, qdev_get_gpio_in(orgate, 2));
>  
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmc.iou.ospi.ospi), 0,
> -                       qdev_get_gpio_in(orgate, 0));
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_src), 0,
> -                       qdev_get_gpio_in(orgate, 1));
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmc.iou.ospi.dma_dst), 0,
> -                       qdev_get_gpio_in(orgate, 2));
> -
> -    qdev_connect_gpio_out(orgate, 0, pic[VERSAL_OSPI_IRQ]);
> +    return dev;
>  }
>  
>  static void versal_create_cfu(Versal *s, qemu_irq *pic)
>  {
>      SysBusDevice *sbd;
> @@ -1256,17 +1252,17 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      for (i = 0; i < map->num_usb; i++) {
>          versal_create_usb(s, &map->usb[i]);
>      }
>  
>      versal_create_efuse(s, &map->efuse);
> +    versal_create_ospi(s, &map->ospi);
>  
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
>      versal_create_trng(s, pic);
>      versal_create_bbram(s, pic);
>      versal_create_pmc_iou_slcr(s, pic);
> -    versal_create_ospi(s, pic);
>      versal_create_crl(s, pic);
>      versal_create_cfu(s, pic);
>      versal_map_ddr(s);
>      versal_unimp(s);
>  
> @@ -1308,10 +1304,34 @@ void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
>      }
>  
>      qdev_prop_set_drive(efuse, "drive", blk);
>  }
>  
> +void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
> +                              BlockBackend *blk)
> +{
> +    BusState *spi_bus;
> +    DeviceState *flash, *ospi;
> +    qemu_irq cs_line;
> +
> +    ospi = DEVICE(versal_get_child(s, "ospi"));
> +    spi_bus = qdev_get_child_bus(ospi, "spi0");
> +
> +    flash = qdev_new(flash_mdl);
> +
> +    if (blk) {
> +        qdev_prop_set_drive_err(flash, "drive", blk, &error_fatal);
> +    }
> +    qdev_prop_set_uint8(flash, "cs", flash_idx);
> +    qdev_realize_and_unref(flash, spi_bus, &error_fatal);
> +
> +    cs_line = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(ospi),
> +                       flash_idx + 1, cs_line);
> +}
> +
>  int versal_get_num_can(VersalVersion version)
>  {
>      const VersalMap *map = VERSION_TO_MAP[version];
>  
>      return map->num_canfd;
> -- 
> 2.50.0
> 

