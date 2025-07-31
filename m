Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B716C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaNn-0005SQ-L3; Thu, 31 Jul 2025 17:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhZfR-0000yj-Nh; Thu, 31 Jul 2025 16:14:29 -0400
Received: from mail-mw2nam10on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2412::622]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhZfM-00031I-Fq; Thu, 31 Jul 2025 16:14:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whmLAZhrD0ruCRDbQh1LzDzBBqFqlvp/NcZcYGMEvVsYwLu4vR1pOpxDco0WG1I5qnIUokmaKYMmU52VNe6sdcNu3L09Bz2MaplsnEVOeWiXzGXx+93nXw3/pcXTPTmGViafYBW3V84ZLwmu6l5T3AP+eD7d0wrTOH0E+DJyqOrA/BqBR5PBwiGxnF9j85ZXPHwqic8enOZ9f6VpmN8tv1LCy65gky/70VyWWiU7VciA16w1b9UcUz5KyJU/WxPwmRvZAFUP2V0hS930yjMl09eWnataaRWTQwLjKmleKLTzoxwGmwh1EzUNLD+E1vMxtyyI4TUH4s4DAy1FCLoR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVVXUmZNzAAV885mv7GYJ91+Ck8FtoemUDYQI2BXdR0=;
 b=Gp332jA/MV/ZHXzdvcclvx2TUIx1tbGRahCQTurSn1mvD5h+WdLzCg7BBLXfqy6uS5S7GmHuUZN2LR+108dZFQcFfpwx+gD8e6RmBEYC3Ko3wMmlAApHwiSkf3U881XE07D3mdTUB+TclkJ2iyrdLkMX0bcRw6Ao80gOuqNeaJf88bXP02tYM733JirR6SOlJHRPKvlunc5yEpOivwVjjnqFs9bzGibPS2YgPBbqjwYhKP+ogkxpylEUphMVlwFnR2XnoGLvG1i4GWf3E3YOh/+ssddMmZQ9mYUc6u+j48Rod3S4qutQCvGKEMwPB3mxL42r5lFC5gwujVzU6OjogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVVXUmZNzAAV885mv7GYJ91+Ck8FtoemUDYQI2BXdR0=;
 b=pWM6z6FMsw6KVCNXXgwqiydaZtVSmotKL3rnco6WIieRFAigOGyH0Jqg6LYtyITmOaa2RkcAhx93eub9qc9CgFW9YsMmrgK7YdxI30db8/lRLyYWLRukokM06/yxA73tLCNmVEYHZU6zQiwBkeVniD0dEGUDnCPK1L1trSQoFic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 20:14:08 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 20:14:07 +0000
Date: Thu, 31 Jul 2025 22:14:01 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 36/48] hw/arm/xlnx-versal: tidy up
Message-ID: <aIvOiUHwX+eOjA4L@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-37-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-37-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0628.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::6) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: d0cd8b12-44ba-4d7a-ca40-08ddd06ecde3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1dwUVR6R2xkcy9QdW5xUHJFeEpnZ0J5MlAzakR5QjkwSDFnYlhQTFB1RFY3?=
 =?utf-8?B?OEdOYlJ6dWtjQmVGd0w3cnFrLzRRWmhLSmVjVjJ6eFdXekRVSDhGQzdTanli?=
 =?utf-8?B?VVdqL2ZNY2s4dW1ZMWdhQ3ZvajNDbng5UXQ0cWtaeC9tZmYzWENGL3hqWk44?=
 =?utf-8?B?NzhhWHlyb2R6cXNkT3NZTUJzbEJsM3FmVkRxYlF3MExsRlZEOHJXb0JPUnJS?=
 =?utf-8?B?L0RNc1FZckNFZnZsaTZDcWdkWFB3cjJyS2hDNFh4QmxJaERCZWFkTUVGVFRV?=
 =?utf-8?B?dDF2SjJnR1Y1ZU80eEFkbGZlRkdUdkZsQ0JQYVUwamg0MTQzK1FjN2lML2ds?=
 =?utf-8?B?VjdNbUl1WDlFd2VKekFlR2RNd0F6ZElBNW1ZVVZOYXpjaFBEUVZkK1UvSUkv?=
 =?utf-8?B?aFF2UDNYSXZSN3dEbktiNVpKNHdrV2o5ZWwrUXN0Uml6cXVucHJRSkN2aHVa?=
 =?utf-8?B?RklmSmFGRVo5aXFrUEt2M1dJelpVSXpzSitYZWNla0FyOUFoVGlTS29GVXVR?=
 =?utf-8?B?T0dHRGJ0SDVDbTNxMnl5d2paeTA5aHdlUzhnYUdxNUlNRzNoUFdwQ2ZoTmNy?=
 =?utf-8?B?SVBTbStlTFJST0pweUFHYWNLNkxmSTJuRWJxZHFRVTA3djBmeld0SGpBcFNx?=
 =?utf-8?B?d3RhUERncW5YWlMxSVdhNTVQbzFvZVlKc0QzalNoWXR2VmxOVkY2bXFSeGhi?=
 =?utf-8?B?U05vSEpuVWJ2S3BxQUtPaUF2Z2RKSU9vZko4a1RSVEQwMFdPVlJDV0wyZDkz?=
 =?utf-8?B?Z3ZwY3lWUHp5ZXRSV0U3WCtvYjVYOTRPelMyZEdudzlLSU9NSlh4b01DYzBG?=
 =?utf-8?B?QlBNRHRZcnZ5ZlQ2YnlVMDdhd0hQWDBZay9yWnQrcUlFWTBPRWszQm1VQWU2?=
 =?utf-8?B?UElsSkNXY3FNR0FSdXJ6Z0ZhM1g3QU0yK2pkTlBoQ1FRWlZtbzlTOEhjVjVk?=
 =?utf-8?B?SWxMNEZrN2NnNmxUTHgyT0JFRTFSbDhWN0UvbkM2YWVxb05wRHMzL25yMXVU?=
 =?utf-8?B?U093ZSsyT3cxN2RhTjFJa3pVL2hmNDEySXRwUnNZQm9CZ2RzZWxpU0RoTGZT?=
 =?utf-8?B?cTd2c0tUamNHdW5lRFptWHZaazNMQjdVMlpQU2g2d3pRZUtkVXpVVWNYRXYz?=
 =?utf-8?B?bmV5NWhQMThlS1ltY0MwRFR3V2RzbE1zQmJDRmp3MkhwOVIzS1o5K3pYRVhw?=
 =?utf-8?B?MThnTUlVaHBKY2xDMlBORU9sTkdtVWozM0tiTENsb0xqdHI1Uy9pSWpUeTVO?=
 =?utf-8?B?RHlkdmxmSVZESmppQjlsSERCd1FEVmE0bStodGdvMVNyc203N2J0Kzg1Qk9a?=
 =?utf-8?B?NU91blRKMTMvclNHUFl1SDFxK2hRblJHeDZOZld1VU95RkhsSHJycmhlYWhn?=
 =?utf-8?B?WmlhaVBndHo2OWVTc2UzQ0VKQm1MbUVmcVFDdkxmcjBxclVOZk9IQXZEMEM2?=
 =?utf-8?B?VUFQcmJsL0lYTWE2MU9OaGE3bnRLaS9qYnpTTkRDRXRDYkxUMXpWNEJlZVkw?=
 =?utf-8?B?MUg1Q2xxMXJyZk1CMWZqTDg4L1QrUXY5VUI3ZlFYVzA4WjJHelRSa0tmRURk?=
 =?utf-8?B?MldqckJGQldobkNlZkhEZDErYm1PZ0NSUUFSdkphMVJHaE1jUmFqOHpncVNh?=
 =?utf-8?B?bkdQbmFITjdZOGE5bllNZnJlb2trRC9rRXRua2o1UXFJS0lkNWIvTDJuN0s1?=
 =?utf-8?B?cXgrUXV2Q2dxa2NlWkFSczBtSHo5amtoNFNtRHRETzU3M1BTWjkrQmdOWVlD?=
 =?utf-8?B?RjZSKzY3RVRmR2VZM3lHQTRoeXQ4bXJmTk1qN1UwRDYzd1dhNE5kRzBKT0h1?=
 =?utf-8?B?WG5hci9MWDE4SWIvZ0t3d1NFV1hsQUJqdFFuYy9yd3Q2ZFJNWlpRSFRyVE01?=
 =?utf-8?B?OW5NNVArUVR4UU81dGZhN1cxMHRNYXM1VEN4MWJmbXRuaDNsOHQ1b0xsdWN1?=
 =?utf-8?Q?wrL2T8FwWh8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UytVeXFpK0orN2k0dU9qUm81VG9KT1U0UllCbmo2bFVtSzZrQTJXb3dEdG1a?=
 =?utf-8?B?VmtraTg0M0NQRFFpV0FQOWNrSWwrZ0hPWU9rSXNmaVllV2Z3dnFnY2ZwR0F6?=
 =?utf-8?B?SDNmVVRSVU1NclVsbitqRlNWTmFyNjNMUDJlZy9JTm40NjFYVjhRakJoVWxh?=
 =?utf-8?B?VkgveGhyZVBkSC9wMnBubFlkODlDVnBDTkdMZ1lYRFAxT2dDcU5TRWhDTENR?=
 =?utf-8?B?dkp1bUhobGRGTUlnZXhOL2p0Vjl2cXpTN0RmMDM0d3BFdnBocm1Za3draXdr?=
 =?utf-8?B?NFVNUHJZOXFoalpjUWtaV3U2Z3ZCK1NPeXFSU2Z2Y0JNdmJMakIwTzl0czlh?=
 =?utf-8?B?aFJrTEZZRzl6ZFZsczZ3TlJvdzk1K3VCb1M4Q2Y1TVhVaW1nOXh6V2ErL1g4?=
 =?utf-8?B?TklPRlJ3clNVSktoMWJNRm4rVTh6R3hhcWdLRS9td2ZicWlTdTl5T2dPcEJr?=
 =?utf-8?B?Z2trOVd4Q1IyclRwZHJMeWhFR0Q5Sllka0FBc0Fpb3dxNDZFT2ozbm9IajNH?=
 =?utf-8?B?OWwyUWxYdmwyQzlyOFdsK2lpcU5EdnoxK1JucW9Lakl6enBWZGdRQTZiWDNE?=
 =?utf-8?B?VUNDZVRkREptRXlFV3NsaFJPV0cvVFhkNVk0TzhGZHBmNHZqa0x3QmN1WWFJ?=
 =?utf-8?B?ZFppZnE1RFN4bVRQZzVheEtmd05ZaURWOGdxSTJ6dUxJWlR3TG9oaGJTNzZI?=
 =?utf-8?B?OVdJYktGS09rYlVvcnN4V0NwOWFKVFNKdFo1VmdjT3BrUFMwKzlZeEwyb0do?=
 =?utf-8?B?dTF0cE44MUFSWWFkOVNQUEhhNjN6Z3hiR3lkbHRaeFBwRklvdjMvaVNtck44?=
 =?utf-8?B?UTZmbTdLQXN6M29iWEh4clgvOFAxUUxmd0ZzWUFVNnZPb1h1bVQyS1RpQ2Jh?=
 =?utf-8?B?S3puNmhTUXhNUlpKWVdCWmgxMTExOU91cFVOWjVxL3l1bnFPalA5QW5EaGE4?=
 =?utf-8?B?dm5ROXc2YWZka1QvTElwbUlKQ1phTExHNFUxendGWXBCOEZFaWgxK0pPR1pl?=
 =?utf-8?B?aGJYbEdKeGJRTStFZlhkYU1iNGdyRWZoV0MrYktYYjdmZnlSdWxWRGNYR1BY?=
 =?utf-8?B?K3V5c1g1d012L0ZmVWkvdkV4Z3REYjZkYkk2Unk5a1hLUEU2eFpEMmdTSG91?=
 =?utf-8?B?UjhiZUJRTTBhTnRHaUp6bkdIcDV4dnF3UXNsbmZNUzFTWjRQbXY1YVU1VXI1?=
 =?utf-8?B?Q1VCdEpLYVQ5aUVYT1k5RDd2bGhsSENyN2x3YXpNbHJucUJyZWhlblFVZHp3?=
 =?utf-8?B?a250ME5IRzJkdU04cTRVTUNGUlBoSGN0bzV3dHpYYm9tVUxkTXJIUlhHNEdF?=
 =?utf-8?B?TFJSRHRIV0FzZ3h0U09SZ2h4NkF1R1J0RVZPa21rZDE3aEUzWFY4aVEwV0k5?=
 =?utf-8?B?eE8vQmQ5cnhLaW5jNUlTVTQrM1RPWE02aFFBWVR6bnE4SjhOaUxhS0d6NG9O?=
 =?utf-8?B?V0VoNW83b0dpazdYQ25OYm5HVWFBSmpneXpXY3dUOVErK2JvNGJTNlV1akFk?=
 =?utf-8?B?Qlg3UzBCbExOaHFlM2drdmxFK1lURm5rZ0Y4Sk1tVEtNcnNvYThyZGhWRjRw?=
 =?utf-8?B?S20rdjZkUzNqcjlTbkJBam4rUVNwZ0ZMcEpjbW9UZ0Z3dy9NMTA3b2RHRENH?=
 =?utf-8?B?L096bG1JMVpOOEtVZ1ByWlgwNE5jSUJEbjJYc2hHWFhrbGFsTDQ5WGRuamZK?=
 =?utf-8?B?ZTJxbnB4dlFuWmc0ZlkzL2hOTUdyVU1tVnAzQ0l1ZDFTSGhTRml6ZXYrUUUw?=
 =?utf-8?B?blJ6MFlObnNOeHhxWVVUVk84MWtOZjRzVkkzc0RicmtSQ1l5TDUzN1paSnZR?=
 =?utf-8?B?Z2FiSjE3QVNkQ1FmY1JMSzhhMnB1cGpMM3pZQkJNMFNwMWZTVzdIMlFwWjV4?=
 =?utf-8?B?WUk3R1RjakhKT3dYVUlPTlZJZ24yWnNDRVU2TWwyb1poUFZSa29ZRU1Rb01Z?=
 =?utf-8?B?MkUrQ0V4SC93d2w0dGpaRURSemNxRkorekFTMmE5Z3VhNmJRMjNuZWJGS1Vh?=
 =?utf-8?B?WE1vSTZiSnpkZTAwdkhTMVd6aS9VOFVFTWlPajVaRFlqWUc1aEhYc0JtSHVh?=
 =?utf-8?B?N08vcEJCb3JBekk3NzNrSTdDM0tKZU55RW1UOXVMQWNScFJGT0h5bld2b0x2?=
 =?utf-8?Q?Lgs97Sor247m36TsFUbjia6Zu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cd8b12-44ba-4d7a-ca40-08ddd06ecde3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 20:14:07.8429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xu34LPLqYMj4WEhzuTNpPrONHu67N9a8yVG+NJdjBs0SJ6DTr9iWPW4CVqarbFCX+pdKamziaW+tMSEPpHtJ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644
Received-SPF: permerror client-ip=2a01:111:f403:2412::622;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:54:18AM +0200, Luc Michel wrote:
> Remove now unused macros in xlnx-versal.[ch]. Those macros have been
> replaced by the VersalMap structure that serves as a central description
> for the SoC. The ones still in use in the versal_unimp function are
> inlined.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h | 204 -----------------------------------
>  hw/arm/xlnx-versal.c         |  28 ++---
>  2 files changed, 7 insertions(+), 225 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 3be9f0a5550..bdfab2a5426 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -21,22 +21,10 @@
>  #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
>  OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
>  
> -#define XLNX_VERSAL_NR_ACPUS   2
> -#define XLNX_VERSAL_NR_RCPUS   2
> -#define XLNX_VERSAL_NR_UARTS   2
> -#define XLNX_VERSAL_NR_GEMS    2
> -#define XLNX_VERSAL_NR_ADMAS   8
> -#define XLNX_VERSAL_NR_SDS     2
> -#define XLNX_VERSAL_NR_XRAM    4
> -#define XLNX_VERSAL_NR_IRQS    192
> -#define XLNX_VERSAL_NR_CANFD   2
> -#define XLNX_VERSAL_CANFD_REF_CLK (24 * 1000 * 1000)
> -#define XLNX_VERSAL_NR_CFRAME  15
> -
>  struct Versal {
>      /*< private >*/
>      SysBusDevice parent_obj;
>  
>      /*< public >*/
> @@ -81,198 +69,6 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s);
>  
>  int versal_get_num_cpu(VersalVersion version);
>  int versal_get_num_can(VersalVersion version);
>  int versal_get_num_sdhci(VersalVersion version);
>  
> -/* Memory-map and IRQ definitions. Copied a subset from
> - * auto-generated files.  */
> -
> -#define VERSAL_CRL_IRQ             10
> -#define VERSAL_UART0_IRQ_0         18
> -#define VERSAL_UART1_IRQ_0         19
> -#define VERSAL_CANFD0_IRQ_0        20
> -#define VERSAL_CANFD1_IRQ_0        21
> -#define VERSAL_USB0_IRQ_0          22
> -#define VERSAL_GEM0_IRQ_0          56
> -#define VERSAL_GEM0_WAKE_IRQ_0     57
> -#define VERSAL_GEM1_IRQ_0          58
> -#define VERSAL_GEM1_WAKE_IRQ_0     59
> -#define VERSAL_ADMA_IRQ_0          60
> -#define VERSAL_XRAM_IRQ_0          79
> -#define VERSAL_CFU_IRQ_0           120
> -#define VERSAL_PMC_APB_IRQ         121
> -#define VERSAL_OSPI_IRQ            124
> -#define VERSAL_SD0_IRQ_0           126
> -#define VERSAL_EFUSE_IRQ           139
> -#define VERSAL_TRNG_IRQ            141
> -#define VERSAL_RTC_ALARM_IRQ       142
> -#define VERSAL_RTC_SECONDS_IRQ     143
> -
> -/* Architecturally reserved IRQs suitable for virtualization.  */
> -#define VERSAL_RSVD_IRQ_FIRST 111
> -#define VERSAL_RSVD_IRQ_LAST  118
> -
> -#define MM_TOP_RSVD                 0xa0000000U
> -#define MM_TOP_RSVD_SIZE            0x4000000
> -#define MM_GIC_APU_DIST_MAIN        0xf9000000U
> -#define MM_GIC_APU_DIST_MAIN_SIZE   0x10000
> -#define MM_GIC_APU_REDIST_0         0xf9080000U
> -#define MM_GIC_APU_REDIST_0_SIZE    0x80000
> -
> -#define MM_UART0                    0xff000000U
> -#define MM_UART0_SIZE               0x10000
> -#define MM_UART1                    0xff010000U
> -#define MM_UART1_SIZE               0x10000
> -
> -#define MM_CANFD0                   0xff060000U
> -#define MM_CANFD0_SIZE              0x10000
> -#define MM_CANFD1                   0xff070000U
> -#define MM_CANFD1_SIZE              0x10000
> -
> -#define MM_GEM0                     0xff0c0000U
> -#define MM_GEM0_SIZE                0x10000
> -#define MM_GEM1                     0xff0d0000U
> -#define MM_GEM1_SIZE                0x10000
> -
> -#define MM_ADMA_CH0                 0xffa80000U
> -#define MM_ADMA_CH0_SIZE            0x10000
> -
> -#define MM_OCM                      0xfffc0000U
> -#define MM_OCM_SIZE                 0x40000
> -
> -#define MM_XRAM                     0xfe800000
> -#define MM_XRAMC                    0xff8e0000
> -#define MM_XRAMC_SIZE               0x10000
> -
> -#define MM_USB2_CTRL_REGS           0xFF9D0000
> -#define MM_USB2_CTRL_REGS_SIZE      0x10000
> -
> -#define MM_USB_0                    0xFE200000
> -#define MM_USB_0_SIZE               0x10000
> -
> -#define MM_TOP_DDR                  0x0
> -#define MM_TOP_DDR_SIZE             0x80000000U
> -#define MM_TOP_DDR_2                0x800000000ULL
> -#define MM_TOP_DDR_2_SIZE           0x800000000ULL
> -#define MM_TOP_DDR_3                0xc000000000ULL
> -#define MM_TOP_DDR_3_SIZE           0x4000000000ULL
> -#define MM_TOP_DDR_4                0x10000000000ULL
> -#define MM_TOP_DDR_4_SIZE           0xb780000000ULL
> -
> -#define MM_PSM_START                0xffc80000U
> -#define MM_PSM_END                  0xffcf0000U
> -
> -#define MM_CRL                      0xff5e0000U
> -#define MM_CRL_SIZE                 0x300000
> -#define MM_IOU_SCNTR                0xff130000U
> -#define MM_IOU_SCNTR_SIZE           0x10000
> -#define MM_IOU_SCNTRS               0xff140000U
> -#define MM_IOU_SCNTRS_SIZE          0x10000
> -#define MM_FPD_CRF                  0xfd1a0000U
> -#define MM_FPD_CRF_SIZE             0x140000
> -#define MM_FPD_FPD_APU              0xfd5c0000
> -#define MM_FPD_FPD_APU_SIZE         0x100
> -
> -#define MM_PMC_PMC_IOU_SLCR         0xf1060000
> -#define MM_PMC_PMC_IOU_SLCR_SIZE    0x10000
> -
> -#define MM_PMC_OSPI                 0xf1010000
> -#define MM_PMC_OSPI_SIZE            0x10000
> -
> -#define MM_PMC_OSPI_DAC             0xc0000000
> -#define MM_PMC_OSPI_DAC_SIZE        0x20000000
> -
> -#define MM_PMC_OSPI_DMA_DST         0xf1011800
> -#define MM_PMC_OSPI_DMA_SRC         0xf1011000
> -
> -#define MM_PMC_SD0                  0xf1040000U
> -#define MM_PMC_SD0_SIZE             0x10000
> -#define MM_PMC_BBRAM_CTRL           0xf11f0000
> -#define MM_PMC_BBRAM_CTRL_SIZE      0x00050
> -#define MM_PMC_EFUSE_CTRL           0xf1240000
> -#define MM_PMC_EFUSE_CTRL_SIZE      0x00104
> -#define MM_PMC_EFUSE_CACHE          0xf1250000
> -#define MM_PMC_EFUSE_CACHE_SIZE     0x00C00
> -
> -#define MM_PMC_CFU_APB              0xf12b0000
> -#define MM_PMC_CFU_APB_SIZE         0x10000
> -#define MM_PMC_CFU_STREAM           0xf12c0000
> -#define MM_PMC_CFU_STREAM_SIZE      0x1000
> -#define MM_PMC_CFU_SFR              0xf12c1000
> -#define MM_PMC_CFU_SFR_SIZE         0x1000
> -#define MM_PMC_CFU_FDRO             0xf12c2000
> -#define MM_PMC_CFU_FDRO_SIZE        0x1000
> -#define MM_PMC_CFU_STREAM_2         0xf1f80000
> -#define MM_PMC_CFU_STREAM_2_SIZE    0x40000
> -
> -#define MM_PMC_CFRAME0_REG          0xf12d0000
> -#define MM_PMC_CFRAME0_REG_SIZE     0x1000
> -#define MM_PMC_CFRAME0_FDRI         0xf12d1000
> -#define MM_PMC_CFRAME0_FDRI_SIZE    0x1000
> -#define MM_PMC_CFRAME1_REG          0xf12d2000
> -#define MM_PMC_CFRAME1_REG_SIZE     0x1000
> -#define MM_PMC_CFRAME1_FDRI         0xf12d3000
> -#define MM_PMC_CFRAME1_FDRI_SIZE    0x1000
> -#define MM_PMC_CFRAME2_REG          0xf12d4000
> -#define MM_PMC_CFRAME2_REG_SIZE     0x1000
> -#define MM_PMC_CFRAME2_FDRI         0xf12d5000
> -#define MM_PMC_CFRAME2_FDRI_SIZE    0x1000
> -#define MM_PMC_CFRAME3_REG          0xf12d6000
> -#define MM_PMC_CFRAME3_REG_SIZE     0x1000
> -#define MM_PMC_CFRAME3_FDRI         0xf12d7000
> -#define MM_PMC_CFRAME3_FDRI_SIZE    0x1000
> -#define MM_PMC_CFRAME4_REG          0xf12d8000
> -#define MM_PMC_CFRAME4_REG_SIZE     0x1000
> -#define MM_PMC_CFRAME4_FDRI         0xf12d9000
> -#define MM_PMC_CFRAME4_FDRI_SIZE    0x1000
> -#define MM_PMC_CFRAME5_REG          0xf12da000
> -#define MM_PMC_CFRAME5_REG_SIZE     0x1000
> -#define MM_PMC_CFRAME5_FDRI         0xf12db000
> -#define MM_PMC_CFRAME5_FDRI_SIZE    0x1000
> -#define MM_PMC_CFRAME6_REG          0xf12dc000
> -#define MM_PMC_CFRAME6_REG_SIZE     0x1000
> -#define MM_PMC_CFRAME6_FDRI         0xf12dd000
> -#define MM_PMC_CFRAME6_FDRI_SIZE    0x1000
> -#define MM_PMC_CFRAME7_REG          0xf12de000
> -#define MM_PMC_CFRAME7_REG_SIZE     0x1000
> -#define MM_PMC_CFRAME7_FDRI         0xf12df000
> -#define MM_PMC_CFRAME7_FDRI_SIZE    0x1000
> -#define MM_PMC_CFRAME8_REG          0xf12e0000
> -#define MM_PMC_CFRAME8_REG_SIZE     0x1000
> -#define MM_PMC_CFRAME8_FDRI         0xf12e1000
> -#define MM_PMC_CFRAME8_FDRI_SIZE    0x1000
> -#define MM_PMC_CFRAME9_REG          0xf12e2000
> -#define MM_PMC_CFRAME9_REG_SIZE     0x1000
> -#define MM_PMC_CFRAME9_FDRI         0xf12e3000
> -#define MM_PMC_CFRAME9_FDRI_SIZE    0x1000
> -#define MM_PMC_CFRAME10_REG         0xf12e4000
> -#define MM_PMC_CFRAME10_REG_SIZE    0x1000
> -#define MM_PMC_CFRAME10_FDRI        0xf12e5000
> -#define MM_PMC_CFRAME10_FDRI_SIZE   0x1000
> -#define MM_PMC_CFRAME11_REG         0xf12e6000
> -#define MM_PMC_CFRAME11_REG_SIZE    0x1000
> -#define MM_PMC_CFRAME11_FDRI        0xf12e7000
> -#define MM_PMC_CFRAME11_FDRI_SIZE   0x1000
> -#define MM_PMC_CFRAME12_REG         0xf12e8000
> -#define MM_PMC_CFRAME12_REG_SIZE    0x1000
> -#define MM_PMC_CFRAME12_FDRI        0xf12e9000
> -#define MM_PMC_CFRAME12_FDRI_SIZE   0x1000
> -#define MM_PMC_CFRAME13_REG         0xf12ea000
> -#define MM_PMC_CFRAME13_REG_SIZE    0x1000
> -#define MM_PMC_CFRAME13_FDRI        0xf12eb000
> -#define MM_PMC_CFRAME13_FDRI_SIZE   0x1000
> -#define MM_PMC_CFRAME14_REG         0xf12ec000
> -#define MM_PMC_CFRAME14_REG_SIZE    0x1000
> -#define MM_PMC_CFRAME14_FDRI        0xf12ed000
> -#define MM_PMC_CFRAME14_FDRI_SIZE   0x1000
> -#define MM_PMC_CFRAME_BCAST_REG       0xf12ee000
> -#define MM_PMC_CFRAME_BCAST_REG_SIZE  0x1000
> -#define MM_PMC_CFRAME_BCAST_FDRI      0xf12ef000
> -#define MM_PMC_CFRAME_BCAST_FDRI_SIZE 0x1000
> -
> -#define MM_PMC_CRP                  0xf1260000U
> -#define MM_PMC_CRP_SIZE             0x10000
> -#define MM_PMC_RTC                  0xf12a0000
> -#define MM_PMC_RTC_SIZE             0x10000
> -#define MM_PMC_TRNG                 0xf1230000
> -#define MM_PMC_TRNG_SIZE            0x10000
>  #endif
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index c513d28c8d4..aef53876f26 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -16,11 +16,10 @@
>  #include "qobject/qlist.h"
>  #include "qemu/module.h"
>  #include "hw/sysbus.h"
>  #include "net/net.h"
>  #include "system/system.h"
> -#include "hw/arm/boot.h"
>  #include "hw/misc/unimp.h"
>  #include "hw/arm/xlnx-versal.h"
>  #include "qemu/log.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
> @@ -49,17 +48,10 @@
>  #include "hw/core/split-irq.h"
>  #include "target/arm/cpu.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/arm/bsa.h"
>  
> -#define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
> -#define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
> -#define GEM_REVISION        0x40070106
> -
> -#define VERSAL_NUM_PMC_APB_IRQS 18
> -#define NUM_OSPI_IRQ_LINES 3
> -
>  /*
>   * IRQ descriptor to catch the following cases:
>   *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
>   */
>  FIELD(VERSAL_IRQ, IRQ, 0, 16)
> @@ -1361,11 +1353,11 @@ static DeviceState *versal_create_ospi(Versal *s,
>  
>      memory_region_add_subregion(&s->mr_ps, map->dac,
>                                  linear_mr);
>  
>      /* OSPI irq */
> -    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", NUM_OSPI_IRQ_LINES,
> +    orgate = create_or_gate(s, OBJECT(dev), "irq-orgate", 3,
>                              map->irq);
>  
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(orgate, 0));
>      sysbus_connect_irq(SYS_BUS_DEVICE(dma_src), 0, qdev_get_gpio_in(orgate, 1));
>      sysbus_connect_irq(SYS_BUS_DEVICE(dma_dst), 0, qdev_get_gpio_in(orgate, 2));
> @@ -1622,22 +1614,16 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
>  static void versal_unimp(Versal *s)
>  {
>      DeviceState *slcr;
>      qemu_irq gpio_in;
>  
> -    versal_unimp_area(s, "psm", &s->mr_ps,
> -                        MM_PSM_START, MM_PSM_END - MM_PSM_START);
> -    versal_unimp_area(s, "crf", &s->mr_ps,
> -                        MM_FPD_CRF, MM_FPD_CRF_SIZE);
> -    versal_unimp_area(s, "apu", &s->mr_ps,
> -                        MM_FPD_FPD_APU, MM_FPD_FPD_APU_SIZE);
> -    versal_unimp_area(s, "crp", &s->mr_ps,
> -                        MM_PMC_CRP, MM_PMC_CRP_SIZE);
> -    versal_unimp_area(s, "iou-scntr", &s->mr_ps,
> -                        MM_IOU_SCNTR, MM_IOU_SCNTR_SIZE);
> -    versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps,
> -                        MM_IOU_SCNTRS, MM_IOU_SCNTRS_SIZE);
> +    versal_unimp_area(s, "psm", &s->mr_ps, 0xffc80000, 0x70000);
> +    versal_unimp_area(s, "crf", &s->mr_ps, 0xfd1a0000, 0x140000);
> +    versal_unimp_area(s, "apu", &s->mr_ps, 0xfd5c0000, 0x100);
> +    versal_unimp_area(s, "crp", &s->mr_ps, 0xf1260000, 0x10000);
> +    versal_unimp_area(s, "iou-scntr", &s->mr_ps, 0xff130000, 0x10000);
> +    versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps, 0xff140000, 0x10000);
>  
>      qdev_init_gpio_in_named(DEVICE(s), versal_unimp_sd_emmc_sel,
>                              "sd-emmc-sel-dummy", 2);
>      qdev_init_gpio_in_named(DEVICE(s), versal_unimp_qspi_ospi_mux_sel,
>                              "qspi-ospi-mux-sel-dummy", 1);
> -- 
> 2.50.0
> 

