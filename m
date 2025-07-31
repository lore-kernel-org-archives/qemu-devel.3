Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FDCC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU26-00073X-Qb; Thu, 31 Jul 2025 10:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhTGL-0002jT-TG; Thu, 31 Jul 2025 09:24:02 -0400
Received: from mail-dm6nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2415::629]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhTGI-0008Lq-EZ; Thu, 31 Jul 2025 09:24:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4l5Mi6C4tF/7s4kfEpkATxLHP4RsQW7g7q2E6pTRanFcj7qexXePGOAVjfx5AM7pLzIJCCj3jx0agLLK0Imgx3Ity+IzUJ5ae97mI3lzxkY6z0ee3MS6twbt9GYxou9Sxw8GGvWTaxmgyHchGTeiVQBS/8MGAyNISCMAG7zgyvlgjoGAylmM5yHmm9q1R6rLqyaIeDKCnOhZduB9H8FlnEjs2Lk0hg8kAVvGkyIRvxa41gwVEdtZGVD8HWX7mjeo2Vublp5LZHXN28kigkfaGFot2td2b4ZmDGK6yBZVn6KuuSDaBZ12Y1SwjF9P/qr0zNkWJ5nBwRN0Zy7w2imnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRxrBTgVmQUbSDoEMvQMbDrfTq/v7Vgv0M/tcKms8o8=;
 b=a/IrAjg5OPsUVyaVpeETku42wjSs/JWqi3hRuMZSp9JT5d8yd8JhTI1n7tmBHX03fqp2wxdSBu7AlxouqgeYMcF2fGprsOXTzbPhpVZmzYLkljmaWRmaH0ZMvnV/vyh9OKqUhb66/kqujuWZvl3vhq0cT0RcwFtz81fFcq9LaIF9CyTGw3pBzMfYLWVMR0BhFY7X1RtE2+j5qFpd4qs6qT6O5w/OVSSbyD04hrOVdReltWXeqBsm2osjqrZ+hiLnGN7y6RmFv7NsCEHXWyjcCw4c86HXWaaFBM0u5Ohx0Pc2VI/iQ9+dhurOVj1ptKLmhGFg42BmzFuN87skUb0YyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRxrBTgVmQUbSDoEMvQMbDrfTq/v7Vgv0M/tcKms8o8=;
 b=MmfADJHryuxeKQcWFuNjR82B/5TuKE9ls9uJoUm+P4v+nclS9+bQr+Txq+NPB1MPvC4d2rqQedYocTtaY5TDwL9UYmoZ652DSgLtnBjj6uwx5M62qYv3ck9bciQ6VBaPIhI4IpA+AebOw8ZgHqhGr13G/2x4FdsiSHb9FUvJT2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 13:23:47 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 13:23:47 +0000
Date: Thu, 31 Jul 2025 15:23:36 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 33/48] hw/misc/xlnx-versal-crl: refactor device reset logic
Message-ID: <aItuWBWhBXePjLQv@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-34-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-34-luc.michel@amd.com>
X-ClientProxiedBy: DUZPR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::10) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 14305a0a-15a4-43fc-daf1-08ddd0357af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGdyWDdhQnQ2STBpYWRTbFdGeFdxZ2JPVm5PWFF4ME1nNjc2b1VxSTNhYUJS?=
 =?utf-8?B?bnQydno5N0VkQ3dMZ2JwNU1nVGVWeHUvcmZ5b1RtL29Pb2c0SUR1aG5udTdY?=
 =?utf-8?B?WnF2VGwxZzBsQlpITTZNUHA1VldIVUt3cHU5ejJ2Z0ZzQWFzVFR4QXlEQ28v?=
 =?utf-8?B?SWJiRmlmeklJR0c5OW5FWHBnWmRWVVdJVExjN0trbUZrV294WDZlVjBDNkwz?=
 =?utf-8?B?R0ZNRDdpNG1XV1FkTmJVNVNhOWoxT3V4NlVzcXg4bWZ4YkFMUXkzd2E4V3Vp?=
 =?utf-8?B?Y0ZZNGJuNlZRT3dOb3h2WVcvejZWK2lJMW51MC9waWVMblAwbllmQ05GTU1k?=
 =?utf-8?B?b1N6OWJ4U25uTmpnc0pDMHNtazN2d1FrNTI2TVlkS0JxVHZoSFZYVm9uUGpp?=
 =?utf-8?B?aGh2L2xTaDJIS0hpTkdJbFR6SUwxR3hnZ2NUQXRzc2RTN1MzNmQ5bHc4N0FD?=
 =?utf-8?B?V0FTSU8wL0Rqbnp3QXZ2UStoRE5Fc3czN2dmMG5ibUtVUU40ZVJSUW9nZjA3?=
 =?utf-8?B?SC95UWVKaForOGF2MGpnT3diYzVJL0QrTjI2K3N2bDB4dCtIY2lnRG1rVmNC?=
 =?utf-8?B?M09tUzRrUEdXR1ZZK0VaUjZCMFkxK1V4Zy9ZaG14Ykp0V2FWYy9tVGxFZEdw?=
 =?utf-8?B?MWoxeEhLbUhOQUJBeWh5NkozT0Ezcm95YU9GbERBMk15SVhGUUVxdjlMMFBI?=
 =?utf-8?B?eDhsMm9pZFNTUE1sNjQ5NHZvWVBUWWxUVWNSb1BiQ29hRjRKR2JkZ1B5NjR3?=
 =?utf-8?B?ZEYxa2hjNVhiMnJrcUZZMHA2Q2JlVHdFcmVjUVVBRW1ra1NsSW9DaU9WcXNT?=
 =?utf-8?B?OThVc0RPQWp1SnQ0LzNqLzJuRFdVU080aU8za0IvNjBNdUl3dEhCRFV2bzEx?=
 =?utf-8?B?ZGlGVlcxZmpZQUZQRWFaNDNmN2dvY3pCSGFmbWk0NVcyMldlM1B5TEc1Tmlo?=
 =?utf-8?B?c2VWOHBqaXFVU0VKMWRvdzNvVC9OSkRjQ21NbU9QdUx1WUdFYnFMN0lucFVq?=
 =?utf-8?B?cHFyMTdxcW51M2RHL1lQbVRpeW82U1Jack1JMjNyTmNhRVFId1l6UHlMYkFH?=
 =?utf-8?B?Z2NEZzdTRWNrc2hOV1FhSmUwU0pSdEFSZjBhTHF6SWxEbVVxZmxlMU1nOVB2?=
 =?utf-8?B?YStuRm16M0RjYndzMUZmTUtDWTBFc1B6UlkrYzZ2TFNLU3dpK0dKWTJXRGdQ?=
 =?utf-8?B?alN3Z3lMdVRVN0xUWHBKUkl1NFBKYkFRRmIvZm95N1hGbzRVeXpCMVg0YjFT?=
 =?utf-8?B?ZVhzZUFjbi9hOHBRakQvSzJjRmhITjVFWDJxNkJlV1ZjNE8vVzVZSTJpNmwy?=
 =?utf-8?B?WTRiaHIrenFwTmRDY0p3RkNrZWNhRCtpZHN3SGd3M1BabnAwSUFyVGRiaHNs?=
 =?utf-8?B?Qk43UnlUTmgrWVVaS0VYOVUwd0F4MjlQUDhrb2hqOC9vSEdyVGdmR0l3RW1S?=
 =?utf-8?B?UytuMlNxOUV2YXlXU3lhRmRtV1ZhdzVxZ1gweUhVN016enpicXhGaXZxQXRa?=
 =?utf-8?B?ZUtRZi9Ua1pvTHBqWDJHd3YyM1cwaHcxRUY5YUV1blVKeEVGT1dSR0oxUDd3?=
 =?utf-8?B?QWpqQ3R0eVdyQUNrQUhZM2FNNnFJdHVBSkNlTmRXdlBpYmxuTTh1TXdseEwv?=
 =?utf-8?B?V1dhZ0VrNW01Tm5rb2hwdGVCd1Z2cjJncE9tdlJVa3lIUTN5Rm9uQjVHYnJy?=
 =?utf-8?B?cnlzc3hmL29yR3ZKUlVrVFo1bzRudXNFeERwSk1Wb1RpaWhvdnUzZmNqa0ZM?=
 =?utf-8?B?QXNqb2ZHSE1XTXRFQmI1UE56UUNiWDhvbytiMlVsUytjM0J2bmFyTDBqekNy?=
 =?utf-8?B?UE1aOHVOOG1Cb0t2cGxnSFVOQTZwWEI0SHBab0c1cCs0VHBIQ1hmdmtzNCtz?=
 =?utf-8?B?ZHZuaWtqR2N0bUcwS0JvS1ljWnJWK3ZHQ0oyczQ1bk1SRnQwNVRBV1pDVWE5?=
 =?utf-8?Q?2GtNs/32VTI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUtuUjU4SjRXUnRxc00vRFFWTVEvbU1kUi9Kb3JiQnpJNDNUSlJGb1FmQksz?=
 =?utf-8?B?cUVXY0FKeC9tMlZqZjJUQ1BNeUdnMXgvellVcHRpdEV5UGN2QzBPaGhIMmZo?=
 =?utf-8?B?Q2gybUtJc0Rma21FT3dmdWhMcWRONk54Y3liVG1GaFBDVXEwWjJmZzBlWnF2?=
 =?utf-8?B?aTAzY3FUMXdoVWoxVWhNWFE4MkJnR3dva0F6VlVSQ2paUjJIZzVtSTlpeThN?=
 =?utf-8?B?c09pYkxGUnNIaWNXYzROL1IzMnluMkFOTUYvTmthQjhLaGRpWWl6YkNPaFp6?=
 =?utf-8?B?TDlYaklhMis2NklsajJzdnJnS0ZRMlVRSU1UelkwQ0lxTU1IK0x2Qy9Hd09y?=
 =?utf-8?B?Sk1PcEM4ekZJY2JzWkNGZWdyTDJvWmR6b1VWTS81dnE3RnVJK0tBclZCWmtW?=
 =?utf-8?B?YStDRHlZcEhuOUdkUElkUHgvTzl5ajJBdFFGRVRmdHpwRzhIUFBFUjU5ODBK?=
 =?utf-8?B?YUdkeEhoT3V6QmpFREhycnZrakZWVUV4b1MwbzNseTAzY1V6UkJMTWplQ3lQ?=
 =?utf-8?B?VzU1SnVhUVd4WnhLak80b29mMGhvTVpBRmtqT1JIYzI0UVZZMnV3czVhTWFw?=
 =?utf-8?B?d0VadkcvbUtvSzkyRWo4eG5sRkk1Y2h2bVkwajNLZGVVRTNiZlBNZjBGdjNR?=
 =?utf-8?B?SDFQZjBkbzFQZWxsa0ZGaVZOa25OU0dNd3BYWCtZY3o5RGRTWC9vRngwNWp5?=
 =?utf-8?B?SUFJdExkalJwaGtjVWprZVRJbUZaOXE4cXpCZ3RZSHZBRTY1VXZ4UzJIVVll?=
 =?utf-8?B?YUZ2OEcwejJoRzlaQ0tkVHBQWmkwN3V0bnBESlRGRHBlUjJmYXp1SitPZmFp?=
 =?utf-8?B?cUVSbkZiRmN0dzkzaXRKK1BEMG5UcitMazNBMmVDd3dQeDdDeDZFemg4alFz?=
 =?utf-8?B?WGY1MTZYbklkWDNsMWpNc2VwbEdscFo4bmEzQnliemREZDc2LzZleldwZWQ3?=
 =?utf-8?B?citSQkwycmt2b0hrQUxaZlN3VXJQZ3dYcldIRWJJaExCODlTVFJKRHBiNG5R?=
 =?utf-8?B?MUxXT2VYNW5WeFZIeHNxOEdWTDlyN1R5d2l5R0o4Z1ZrY2N4T3FrT0tsVlda?=
 =?utf-8?B?K0VQNmZrNmpad1FHRnduODQ5OTN2dkhVNlNndStmbEpEc2loYk9yTkVRSEpm?=
 =?utf-8?B?U0VKdCthM29MakFMMWQveHRZNStQZEgvKzJFdTR1QWdhUXFTUitITkpqNUsw?=
 =?utf-8?B?c25ISXRxWEM5U1JzOWhjSUs0QlFiYkN2b2pyRmFITUoydFQwZ2VPRFp3YzBy?=
 =?utf-8?B?a0xFMWVyYkJlKzZqam5vam0xQW8xUVFDS0UyNUNxZ0pvYitHK01mZEswZkZ6?=
 =?utf-8?B?K1lvNkxVU0xxbEVvQzJqYlkxTHVpbzRibkVRd0swZk1Sd1VkT01UeFdwb08y?=
 =?utf-8?B?dVU5REs1OE9JTXY1OCsvdGppQ0pMZnZnRFpuTlViYXEvQmhLaWpjSG9ld3JU?=
 =?utf-8?B?OGNRSUNuektlMW12bkNoenZQSHRWVVNaUWpQVXViTGxRVmZUVFVDNUFJWEN1?=
 =?utf-8?B?ZnlPb3REa1pLOXpBRGhveGJ5OGZPSXVuWDFQd1V6dVk4Y1A5aGprTVJyQWw0?=
 =?utf-8?B?YVNYY1M3UXdNUDVRcUh3Vnp5cWYwdUYvMXZzSER0WWhpWkxqQ1ZrekhvY3BM?=
 =?utf-8?B?ZzFWRjVnZnk0a3lyeXM0aTh3bXNBOWJwMUlzWkVCSWo3UmVYamNER29Odk9t?=
 =?utf-8?B?R1lOSHMrQzhnQloxcDc1aFhCRXB1bU5LV2tGRGkxUlczUDFRWWRvdjEvTkNp?=
 =?utf-8?B?dkhobU1ILzI3MXRhcjgxR0tTNXF4aDA5a1B3Q2VTSkd0NXlXd3lhcno4MXRY?=
 =?utf-8?B?aDRDR3FkMzB3d0QzMVBPaUhOOEFIdk53QU1HSDhjc1REbGFtYWtyOTJHeTAw?=
 =?utf-8?B?aWVOWnBYMFVKVG12UVVQY0o2cXNoNHdWWmpKd0Eybm1Qa3N6N2lRR1VZUEF4?=
 =?utf-8?B?Q2xxUWZpTDZ4WDY3MTZQVkkxeGV0ZmhIRHo4bzNYcjZLWml3bmo5NjlVaFdY?=
 =?utf-8?B?Wlc5bmh4QjcwbHlUUEdoeVlmaWNKdStxL2RpSERBVEp6cng1eWhHZzVtM2xn?=
 =?utf-8?B?NHg4a2NRR3JianJ5dkVMTFBBcS9venpWTU8rcVlWdzNUVitmWitiY05rZFpS?=
 =?utf-8?Q?CWsgFgP4bFntCVgng4Jy9yYZA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14305a0a-15a4-43fc-daf1-08ddd0357af3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 13:23:47.4161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flP8X3yMBAQO0Hmb6CCksI382l6CdXqF089+K5FMFBR/TMxDEEsgQwQ8L0KSuWIN0lNnX1+N6Fzs0CMBV+Qxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
Received-SPF: permerror client-ip=2a01:111:f403:2415::629;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Hi Luc,

On Wed, Jul 16, 2025 at 11:54:15AM +0200, Luc Michel wrote:
> Refactor the device reset logic to have a common register write callback
> for all the devices. This uses a decode function to map the register
> address to the actual peripheral to reset. This refactoring changes the
> CPU property name from cpu_r5[*] to rpu[*] to ease with the connections
> in the Versal SoC. It also fixes a bug where the gem device pointer
> was mapped to the usb link property.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>  include/hw/misc/xlnx-versal-crl.h |   8 +-
>  hw/misc/xlnx-versal-crl.c         | 163 ++++++++++++++++--------------
>  2 files changed, 92 insertions(+), 79 deletions(-)
> 
> diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
> index 2b39d203a67..7e50a95ad3c 100644
> --- a/include/hw/misc/xlnx-versal-crl.h
> +++ b/include/hw/misc/xlnx-versal-crl.h
> @@ -218,33 +218,33 @@ REG32(PSM_RST_MODE, 0x370)
>      FIELD(PSM_RST_MODE, WAKEUP, 2, 1)
>      FIELD(PSM_RST_MODE, RST_MODE, 0, 2)
>  
>  #define CRL_R_MAX (R_PSM_RST_MODE + 1)
>  
> -#define RPU_MAX_CPU 2
> -
>  struct XlnxVersalCRLBase {
>      SysBusDevice parent_obj;
>  
>      RegisterInfoArray *reg_array;
>      uint32_t *regs;
>  };
>  
>  struct XlnxVersalCRLBaseClass {
>      SysBusDeviceClass parent_class;
> +
> +    DeviceState ** (*decode_periph_rst)(XlnxVersalCRLBase *s, hwaddr, size_t *);
>  };
>  
>  struct XlnxVersalCRL {
>      XlnxVersalCRLBase parent_obj;
>      qemu_irq irq;
>  
>      struct {
> -        ARMCPU *cpu_r5[RPU_MAX_CPU];
> +        DeviceState *rpu[2];
>          DeviceState *adma[8];
>          DeviceState *uart[2];
>          DeviceState *gem[2];
> -        DeviceState *usb;
> +        DeviceState *usb[1];
>      } cfg;
>  
>      uint32_t regs[CRL_R_MAX];
>      RegisterInfo regs_info[CRL_R_MAX];
>  };
> diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
> index be89e0da40d..115327cfcf4 100644
> --- a/hw/misc/xlnx-versal-crl.c
> +++ b/hw/misc/xlnx-versal-crl.c
> @@ -53,94 +53,103 @@ static uint64_t crl_disable_prew(RegisterInfo *reg, uint64_t val64)
>      s->regs[R_IR_MASK] |= val;
>      crl_update_irq(s);
>      return 0;
>  }
>  
> -static void crl_reset_dev(XlnxVersalCRL *s, DeviceState *dev,
> -                          bool rst_old, bool rst_new)
> +static DeviceState **versal_decode_periph_rst(XlnxVersalCRLBase *s,
> +                                             hwaddr addr, size_t *count)

One space is missing above but otherwise:

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

>  {
> -    device_cold_reset(dev);
> -}
> +    size_t idx;
> +    XlnxVersalCRL *xvc = XLNX_VERSAL_CRL(s);
>  
> -static void crl_reset_cpu(XlnxVersalCRL *s, ARMCPU *armcpu,
> -                          bool rst_old, bool rst_new)
> -{
> -    if (rst_new) {
> -        arm_set_cpu_off(arm_cpu_mp_affinity(armcpu));
> -    } else {
> -        arm_set_cpu_on_and_reset(arm_cpu_mp_affinity(armcpu));
> -    }
> -}
> +    *count = 1;
>  
> -#define REGFIELD_RESET(type, s, reg, f, new_val, dev) {     \
> -    bool old_f = ARRAY_FIELD_EX32((s)->regs, reg, f);       \
> -    bool new_f = FIELD_EX32(new_val, reg, f);               \
> -                                                            \
> -    /* Detect edges.  */                                    \
> -    if (dev && old_f != new_f) {                            \
> -        crl_reset_ ## type(s, dev, old_f, new_f);           \
> -    }                                                       \
> -}
> +    switch (addr) {
> +    case A_RST_CPU_R5:
> +        return xvc->cfg.rpu;
>  
> -static uint64_t crl_rst_r5_prew(RegisterInfo *reg, uint64_t val64)
> -{
> -    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
> +    case A_RST_ADMA:
> +        /* A single register fans out to all DMA reset inputs */
> +        *count = ARRAY_SIZE(xvc->cfg.adma);
> +        return xvc->cfg.adma;
>  
> -    REGFIELD_RESET(cpu, s, RST_CPU_R5, RESET_CPU0, val64, s->cfg.cpu_r5[0]);
> -    REGFIELD_RESET(cpu, s, RST_CPU_R5, RESET_CPU1, val64, s->cfg.cpu_r5[1]);
> -    return val64;
> -}
> +    case A_RST_UART0 ... A_RST_UART1:
> +        idx = (addr - A_RST_UART0) / sizeof(uint32_t);
> +        return xvc->cfg.uart + idx;
>  
> -static uint64_t crl_rst_adma_prew(RegisterInfo *reg, uint64_t val64)
> -{
> -    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
> -    int i;
> +    case A_RST_GEM0 ... A_RST_GEM1:
> +        idx = (addr - A_RST_GEM0) / sizeof(uint32_t);
> +        return xvc->cfg.gem + idx;
> +
> +    case A_RST_USB0:
> +        return xvc->cfg.usb;
>  
> -    /* A single register fans out to all ADMA reset inputs.  */
> -    for (i = 0; i < ARRAY_SIZE(s->cfg.adma); i++) {
> -        REGFIELD_RESET(dev, s, RST_ADMA, RESET, val64, s->cfg.adma[i]);
> +    default:
> +        /* invalid or unimplemented */
> +        return NULL;
>      }
> -    return val64;
>  }
>  
> -static uint64_t crl_rst_uart0_prew(RegisterInfo *reg, uint64_t val64)
> +static uint64_t crl_rst_cpu_prew(RegisterInfo *reg, uint64_t val64)
>  {
> -    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
> +    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(reg->opaque);
> +    XlnxVersalCRLBaseClass *xvcbc = XLNX_VERSAL_CRL_BASE_GET_CLASS(s);
> +    DeviceState **dev;
> +    size_t i, count;
>  
> -    REGFIELD_RESET(dev, s, RST_UART0, RESET, val64, s->cfg.uart[0]);
> -    return val64;
> -}
> +    dev = xvcbc->decode_periph_rst(s, reg->access->addr, &count);
>  
> -static uint64_t crl_rst_uart1_prew(RegisterInfo *reg, uint64_t val64)
> -{
> -    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
> +    for (i = 0; i < 2; i++) {
> +        bool prev, new;
> +        uint64_t aff;
>  
> -    REGFIELD_RESET(dev, s, RST_UART1, RESET, val64, s->cfg.uart[1]);
> -    return val64;
> -}
> +        prev = extract32(s->regs[reg->access->addr / 4], i, 1);
> +        new = extract32(val64, i, 1);
>  
> -static uint64_t crl_rst_gem0_prew(RegisterInfo *reg, uint64_t val64)
> -{
> -    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
> +        if (prev == new) {
> +            continue;
> +        }
>  
> -    REGFIELD_RESET(dev, s, RST_GEM0, RESET, val64, s->cfg.gem[0]);
> -    return val64;
> -}
> +        aff = arm_cpu_mp_affinity(ARM_CPU(dev[i]));
>  
> -static uint64_t crl_rst_gem1_prew(RegisterInfo *reg, uint64_t val64)
> -{
> -    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
> +        if (new) {
> +            arm_set_cpu_off(aff);
> +        } else {
> +            arm_set_cpu_on_and_reset(aff);
> +        }
> +    }
>  
> -    REGFIELD_RESET(dev, s, RST_GEM1, RESET, val64, s->cfg.gem[1]);
>      return val64;
>  }
>  
> -static uint64_t crl_rst_usb_prew(RegisterInfo *reg, uint64_t val64)
> +static uint64_t crl_rst_dev_prew(RegisterInfo *reg, uint64_t val64)
>  {
> -    XlnxVersalCRL *s = XLNX_VERSAL_CRL(reg->opaque);
> +    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(reg->opaque);
> +    XlnxVersalCRLBaseClass *xvcbc = XLNX_VERSAL_CRL_BASE_GET_CLASS(s);
> +    DeviceState **dev;
> +    bool prev, new;
> +    size_t i, count;
> +
> +    dev = xvcbc->decode_periph_rst(s, reg->access->addr, &count);
> +
> +    if (dev == NULL) {
> +        return val64;
> +    }
> +
> +    prev = s->regs[reg->access->addr / 4] & 0x1;
> +    new = val64 & 0x1;
> +
> +    if (prev == new) {
> +        return val64;
> +    }
> +
> +    for (i = 0; i < count; i++) {
> +        if (dev[i]) {
> +            device_cold_reset(dev[i]);
> +        }
> +    }
>  
> -    REGFIELD_RESET(dev, s, RST_USB0, RESET, val64, s->cfg.usb);
>      return val64;
>  }
>  
>  static const RegisterAccessInfo crl_regs_info[] = {
>      {   .name = "ERR_CTRL",  .addr = A_ERR_CTRL,
> @@ -242,31 +251,31 @@ static const RegisterAccessInfo crl_regs_info[] = {
>          .reset = 0x3c00,
>          .rsvd = 0xfdfc00f8,
>      },{ .name = "RST_CPU_R5",  .addr = A_RST_CPU_R5,
>          .reset = 0x17,
>          .rsvd = 0x8,
> -        .pre_write = crl_rst_r5_prew,
> +        .pre_write = crl_rst_cpu_prew,
>      },{ .name = "RST_ADMA",  .addr = A_RST_ADMA,
>          .reset = 0x1,
> -        .pre_write = crl_rst_adma_prew,
> +        .pre_write = crl_rst_dev_prew,
>      },{ .name = "RST_GEM0",  .addr = A_RST_GEM0,
>          .reset = 0x1,
> -        .pre_write = crl_rst_gem0_prew,
> +        .pre_write = crl_rst_dev_prew,
>      },{ .name = "RST_GEM1",  .addr = A_RST_GEM1,
>          .reset = 0x1,
> -        .pre_write = crl_rst_gem1_prew,
> +        .pre_write = crl_rst_dev_prew,
>      },{ .name = "RST_SPARE",  .addr = A_RST_SPARE,
>          .reset = 0x1,
>      },{ .name = "RST_USB0",  .addr = A_RST_USB0,
>          .reset = 0x1,
> -        .pre_write = crl_rst_usb_prew,
> +        .pre_write = crl_rst_dev_prew,
>      },{ .name = "RST_UART0",  .addr = A_RST_UART0,
>          .reset = 0x1,
> -        .pre_write = crl_rst_uart0_prew,
> +        .pre_write = crl_rst_dev_prew,
>      },{ .name = "RST_UART1",  .addr = A_RST_UART1,
>          .reset = 0x1,
> -        .pre_write = crl_rst_uart1_prew,
> +        .pre_write = crl_rst_dev_prew,
>      },{ .name = "RST_SPI0",  .addr = A_RST_SPI0,
>          .reset = 0x1,
>      },{ .name = "RST_SPI1",  .addr = A_RST_SPI1,
>          .reset = 0x1,
>      },{ .name = "RST_CAN0",  .addr = A_RST_CAN0,
> @@ -341,13 +350,13 @@ static void versal_crl_init(Object *obj)
>                                CRL_R_MAX * 4);
>      xvcb->regs = s->regs;
>      sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>  
> -    for (i = 0; i < ARRAY_SIZE(s->cfg.cpu_r5); ++i) {
> -        object_property_add_link(obj, "cpu_r5[*]", TYPE_ARM_CPU,
> -                                 (Object **)&s->cfg.cpu_r5[i],
> +    for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
> +        object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
> +                                 (Object **)&s->cfg.rpu[i],
>                                   qdev_prop_allow_set_link_before_realize,
>                                   OBJ_PROP_LINK_STRONG);
>      }
>  
>      for (i = 0; i < ARRAY_SIZE(s->cfg.adma); ++i) {
> @@ -369,14 +378,16 @@ static void versal_crl_init(Object *obj)
>                                   (Object **)&s->cfg.gem[i],
>                                   qdev_prop_allow_set_link_before_realize,
>                                   OBJ_PROP_LINK_STRONG);
>      }
>  
> -    object_property_add_link(obj, "usb", TYPE_DEVICE,
> -                             (Object **)&s->cfg.gem[i],
> -                             qdev_prop_allow_set_link_before_realize,
> -                             OBJ_PROP_LINK_STRONG);
> +    for (i = 0; i < ARRAY_SIZE(s->cfg.usb); ++i) {
> +        object_property_add_link(obj, "usb[*]", TYPE_DEVICE,
> +                                 (Object **)&s->cfg.usb[i],
> +                                 qdev_prop_allow_set_link_before_realize,
> +                                 OBJ_PROP_LINK_STRONG);
> +    }
>  }
>  
>  static void crl_finalize(Object *obj)
>  {
>      XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
> @@ -394,15 +405,17 @@ static const VMStateDescription vmstate_versal_crl = {
>  };
>  
>  static void versal_crl_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    XlnxVersalCRLBaseClass *xvcc = XLNX_VERSAL_CRL_BASE_CLASS(klass);
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
>      dc->vmsd = &vmstate_versal_crl;
>      rc->phases.enter = versal_crl_reset_enter;
>      rc->phases.hold = versal_crl_reset_hold;
> +    xvcc->decode_periph_rst = versal_decode_periph_rst;
>  }
>  
>  static const TypeInfo crl_base_info = {
>      .name          = TYPE_XLNX_VERSAL_CRL_BASE,
>      .parent        = TYPE_SYS_BUS_DEVICE,
> -- 
> 2.50.0
> 

