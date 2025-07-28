Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A10DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 21:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugVBH-0007tc-27; Mon, 28 Jul 2025 17:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugVAT-0007bX-BH; Mon, 28 Jul 2025 17:14:06 -0400
Received: from mail-dm3nam02on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2405::630]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugVAP-0002Zp-RO; Mon, 28 Jul 2025 17:13:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0XEBh19wdw8lwrSkgVpz0KRq1HuLaoGKCVrb0bHSCK3toKzgheO0lC2YnhwfKQRRUTmsJTMiJMIUM+0Zj84iN/B6/qrmeE0Pzb3+wr95H4flI2B9+LAwojmYK4+UBkmgBEzW4Hwt2KMDg0YJe9jQp18taEbJELkNFTcO+VEdjeOMrFd44oYwEBFqD2a3KI/Q7xS2VJkTtwWxINidPHZK50ca7BblVTpIj5wYxlJsSzhpFV31INdAyPwMHpjNALXC/CDhhyFTDA8JK8GsdrDQroOsOpwKryKRuoAjz2CjoCDNgqqQmOIOqBcVZS0rSMAC5BiyxcAm5eLpN9+X6cwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQnWGTLCAfGP5rt/nacK7ZgsZtu7aubBx15GemM6s7w=;
 b=Ne+yUwT/Pmv+R4CabzDYsb57g3bVruKDLdDrCU/q69By0VIFedKxVa4EU1jYZJZ8gPKQZbVmHcMpcq7m4z/yzG5m5SdLjvqrrqklpI8Usl9ZTtd/ZVJmc+YigSEQ4xSFb+Sgk6HIjTJh3u1XqGuuFbfqTwXrPz7sf7gPJ5eVG+gK9EEPeiRl2+jlqg2EzPNwEp6W+7RCuSl4Sz+R5QZSllGSUdLx26E/58P9UB8TwNUesEgPcekWF3wib8g8+9HTC98OQ7Bs5IQXmEa5LG7GpxGA4C1Thvw+KaMcWJcTr4d8UvseuIWTm5tQB3aHLv74mu6NvnJfDRmFmrC2ci8Saw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQnWGTLCAfGP5rt/nacK7ZgsZtu7aubBx15GemM6s7w=;
 b=IqJRHwL3sSjjpJ0cxPkVuATieeXPtaBQE50GIZlRV0WHO1gZHISADcDe35oY92F5wNVg6ZSZow49+x6yGMYwLVzUjowELHqLeAw7FTJCaMDcB6QuoKHuFXBXLg8jjzI0MhFLcqAPQbqGOUaFpz2I4MUhT/xGcPi+BQs3MiAPHAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 21:13:47 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 21:13:47 +0000
Date: Mon, 28 Jul 2025 23:13:40 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 10/48] hw/arm/xlnx-versal: usb: refactor creation
Message-ID: <aIfoBF5jSqNAiQFq@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-11-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-11-luc.michel@amd.com>
X-ClientProxiedBy: DB7PR05CA0041.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::18) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 393f6adc-36d9-42f1-33c5-08ddce1ba428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3VnN09KODBsWXRlT0JVWFRxZUpIaXpQZzlaVmRHK1VkUWNYa3JLY0poVGVG?=
 =?utf-8?B?cWFvaEsxQ1NTOFZITGFYZithQTFDY3c0Y1JsWWIrQXVxc1pJNFpUUXUrMDkr?=
 =?utf-8?B?NXRJNVhiblhLWHNVRE1EakRmRU0vQmdBNlMrZ3ZIUjlyYjM0OVVaZm5DYS9M?=
 =?utf-8?B?ek5EQ3duQ0FhUGRidmVucmQ5T3RrWlhQUzI5QkRvc3cyMGlybDRHTkoxblgz?=
 =?utf-8?B?d2J6cG9VRzdEY3cxK2E5ZHFRVTdjcmZMMCtjR3h6QVY2bkxuTDhjS2RvczJw?=
 =?utf-8?B?M0dibXdlL2FGb25LVDBjcEVhSzdiOW54UUlFRTBFdEVnWkprRWZPVy9kSHpk?=
 =?utf-8?B?bEhRcmxoTVh4Tzh5WnlkdUxQb1gzdXhEbWp2UW5qNXNvWHN1UlZKUTdYV0RL?=
 =?utf-8?B?SEpyQVptZ293UUpSQk1FVkRVTHJ5NG5PZXBqdU1QVzllOXMyWWR6S1A5WjF5?=
 =?utf-8?B?Q2dpMnJ5c3lFOU80ODRra2RoZmVCU3JWdWs0bSs1cWdNT1Y3Ujd3dStPN3NU?=
 =?utf-8?B?SzNCcWxRUEhDbXM5ZThVRE0yem1Yc2J1MVFsUCtmVjFrcW5HZ0FvNHZBS3hM?=
 =?utf-8?B?Z2NxL3FWbGVxSlRtZjlnQytnSWRXL3dkeSs1VUE2RzIyenllK2pmekFoTkN5?=
 =?utf-8?B?RHVoTnVOdUhKOE1pZnhiQ0g0ZTZyYnN6UWhySTVucGx6SHJtakZ5WnhyWVVV?=
 =?utf-8?B?bEdUYnhlblBwVlhWR09pdXF3ZkY1SzU3Tlhodml5bW9NQ01FZWI3U09KK01J?=
 =?utf-8?B?NWxsMlk2SHJwZGxhWWJ2Q1dUcGZvREhQWnlTRC8vOVB2MDhmWG5KSFhsY211?=
 =?utf-8?B?RG0zK0FneDJjODNaODBvU29IalNoYlYrZDJVcm16YTJaMEx2cjdJa0FRNVNu?=
 =?utf-8?B?OXUyYlRhSWZvUDQ0MU5FZlkxdU9SWFVzN2RmbXIwTW14bVJFM3JsakwzWU44?=
 =?utf-8?B?UlNlQ1JiUG9NaThoNjdNR3dkK1FQNVAycjFrbFRCd3BiSllWTFNYbEd0N2pP?=
 =?utf-8?B?YWU1c2p0c0I1OUhJb3kwa2RZaHBKbVE5K3UyNTVpMUdveGdHdmkvTHBvK3pR?=
 =?utf-8?B?MEZydndZZ2lXaXlDWUhUSDd1aXFNTmliYWJyNTYxTk5TdUNYaWpTNWh2Nkhu?=
 =?utf-8?B?dUwxRndXdjFkUXI0c2hWY2Z1TTc0WnRzR0dSZFZsd0I2LzJTeGRKb2J5VkMx?=
 =?utf-8?B?M08vTDNNUlpGQnhseEVXTmtlWjhIWXNJYTVIQ3Z0Slh6TWhoTW5kb3pCdGJW?=
 =?utf-8?B?NHZPNXJ0TURZazN6U05rQmR2TkdqNkJtSjR5SVZjb0hJelFjeEkrWHBtN1Rs?=
 =?utf-8?B?UmhaZHAvaVpuTUFsdWI3L1l6S0psaEVmazNEM3FoeDlkU28rTTRGbGVDSzJX?=
 =?utf-8?B?dVdFM01sOWJpcXRsZkVaTUlWaG9adDExWWRUNTgvQThiMVExYkR3S0Rtdmtr?=
 =?utf-8?B?aVZTaWdiZEloZk5zeTVra1dKSmZQN3YxVkc5TW12ZEhaNjNqcHU1V1U1K2Vq?=
 =?utf-8?B?SzFFVlRKNjQyV1dJem9oQmFNTVZYK2J1elFVN3Vmb1dFZTJRMG11Ni9xc0Rw?=
 =?utf-8?B?V0Z3NFkwaGo3WTdHdzBUQmV0YzZVVmlxRHNOY0tITVh0QXFkN3RBVnhRVEdv?=
 =?utf-8?B?MDl1L3pWcWNtTElkaWxJRnVhRkN3UXFKSmZ2cTZQWkRqNTBnNTF4azJFeHRP?=
 =?utf-8?B?WXkxSGNnd1NXOGw2dkN3a3pVN1lTZ3N2Ym9kY3h1T3JpSHNsSGNVWTBFNCsv?=
 =?utf-8?B?d1VxeHNSQ1cwZ00yK2ZKQ29vWVVmVzJoUWFManVWeGQwcUxKREVGYitvZUM0?=
 =?utf-8?B?ZmtFVHNkQXNuSnMybE5yQnRyUmhnWEQ0bGl3ZUp1TjlOT2hJbnBnQlk4cDZ5?=
 =?utf-8?B?eGY0b1hJWUk4eXZHVE0vbmM4MC9vdlhxWHFIZUl6SGUzOXZ5Y21JMTdnRHZJ?=
 =?utf-8?Q?k3nG5lw9tZI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjFiTGlSMnZaTWlGSUF3ekJmRFpmTlM0TTVGRmdXVnBpaFNDTjVtUTBrSVJ3?=
 =?utf-8?B?b3I5K1dFbnhId1N1L2RIRTRkUCsrZnB1VzJQSGtXWFFkTmRkcFpROE5SakxU?=
 =?utf-8?B?Q20vRXhBdURVbVNkZC9GaG5xM05WTFdlaitxTE5QY01pMGlzcDhOVnlPTFA1?=
 =?utf-8?B?aThQZVk3WEEzT1dQYVVmb1VDVmNLbzJMdmh1NDl4T1hSNGlBYUV6YjJBWkJJ?=
 =?utf-8?B?UVVmQU9tWnNHSzZseGRPNkJUZGZyODhnclpLcnJMVTZBVWdPT2VpQlNXZG4v?=
 =?utf-8?B?djNqUFYxejlKdFhkM3RBSlpmQmVmdGVOWEUvM0tjZVVLV1JVejBoZ2hSM1NW?=
 =?utf-8?B?aW03OXhSeHdlN2VITkU0bXJlaVE2RG5EM1B2QlpJS3JkeXRoQkxvL2toNExo?=
 =?utf-8?B?SVdMc0RKSDBoOTd5ek5OTGVsY3VrMUJGUzgxZGtKNDlMS01NOVBWZ0dOK200?=
 =?utf-8?B?ZVNFVWdScTBMV3RuWVM1SDNFZXBlazN2aVRweUorN1pEZkNJWnc4Y29HUWxs?=
 =?utf-8?B?N0Fvb0pUc21HUEtSUkdoUEpiZEd5Lzk5ZXZZU3RjUG5kSlNJQ3NSSktkbU5T?=
 =?utf-8?B?Y1N1UE1OejV4VVZWNHNiZUdwN3FBTHpiTitqU3BPbGo2UFVOcTViT01oUEky?=
 =?utf-8?B?MFhHS3RVRUJNK0NhUStkemRxdGp1dGVtamErVEJ2UVpmeVpjVWVWQTI5bHMy?=
 =?utf-8?B?MXM4Z1FDbWdMdVpmVW1HNlAvOExXTTBad1g3ZDc1dXM0YzNUQmVUQzJoMjV3?=
 =?utf-8?B?dmlYbnQvRE9VZE9GUVkyaUwyZ0JOeVkzcmRuZUpLblVMQmp5Tjh6RldjSUlD?=
 =?utf-8?B?UGRrTEtSenNUR3NiY25kNkNUditFcXBQekc1ZExqYlVhbnBHMGREQVRDVEZp?=
 =?utf-8?B?MmFJNVh4M0tPR0c0YXByM3RGUHc4SHVxQmM1ZDZzTUlMN1JzcEFEdGM0dEsw?=
 =?utf-8?B?MHpoZXhTRS9lM1ZBVHRLUVpzcXF5OVVYRTdBYkNSMnN0OUdzT01TRm1sWFV6?=
 =?utf-8?B?TlhDTHdQcnBrQzIwcW5xbFlIL211UGwzMmFkSGh3dGNSMjVlNnlBS21OaVhY?=
 =?utf-8?B?Q3ViQTF1dFZIV2tVcEd3dDMyWk5ZUmpnZnMwTDNYYXZWYWtsWHNrajFFc2xN?=
 =?utf-8?B?czBvU2FNU2NMcjVveFVaU1lzVWVnWkVDMmlLOU5NSkRQRHUraXNJSTB0TTF5?=
 =?utf-8?B?UVdFTk9sZkFkTlV2WTMyZjVHeDRLdVRQS05vTzl6QUdkZjJOQStRcFM0SE1k?=
 =?utf-8?B?OS9VbnpkYkdsVWRLQ3M4cUlpVkM0WWhVZEhKTzJNd2Z2UkdvT0Jibk80N1BD?=
 =?utf-8?B?KzIvMUZaRjJSN0w3RjUzRkNDZEdCWVNBNG9xa2tMU3BNV2RVN1JtRFIyM2Q2?=
 =?utf-8?B?YnE3MEltL2p4SC9hbFEzNi9yV1dtVjgvVWNyalBPNXM4NlZ0MUtLS1hVbmRl?=
 =?utf-8?B?V0pIMWlsTGl5YVJscm9HNU94cldJc3lvdVV5Q09MOTUxVzdoQmdJWDFLV2li?=
 =?utf-8?B?SEhQdVVLb3FnbXJ6VVZCc0lDUnQvbHVYMVFpR0doYW13Z2FPRlJlU25paW1C?=
 =?utf-8?B?UGUwcW5UazA0Yk5ldk4vMERWT0J4RmVLRjBUN25DRlgzTnJMNGZSOGRHdG5T?=
 =?utf-8?B?SCszbVJRdU1BMDBlekxJbmxOOWpJaUp3UE0rbzUzTXE1MExBWm44dFB3OTQ3?=
 =?utf-8?B?SHdXZlN3dldQSVZBckZIN0Z2WUg0WFo0OGd0Y2lydTBEWTZlMWNGVWdVQU9u?=
 =?utf-8?B?MUpzdkFMZU0zVy9ZR2dCZ3hBQjVYaW5mQ2xQK0RPb1NrMHJxUTNiV1JwK2py?=
 =?utf-8?B?N1ozM3NSK1N1RHJNL3JpWVdrM2pvdGtUM3ZJR3BjbWwvTEZPY2g3dVJjaHFO?=
 =?utf-8?B?S2lNZVNnUEI4SlIzNzJVemlDV1N1eWJRZkJZd2t0VU56UFFmT2ViOEZIK29P?=
 =?utf-8?B?Y21IdzJWRlpVUlZGVmptaVpxNENIVVMwejZEM3UzNVBSbC9zZ0diSS9EOVVm?=
 =?utf-8?B?c3pIZHY2MWFwTUxLNXlIR0lqU0NZdFJHaHU4ME5tZFlnYnU2VkE0NDVoMGFX?=
 =?utf-8?B?OXJRQnlEbG50N2NINlp2MlhxTVA2ZGhLMFE5aktlcS8yVlpldmcvc1V5bzFq?=
 =?utf-8?Q?ZG8obQL/ah9GMaHpO/n1ulB4K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393f6adc-36d9-42f1-33c5-08ddce1ba428
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 21:13:47.3138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sedbMj4YIJM2NXsh8Qexcvibdze5QzhWsOCk6QdgmpX0LVZLa2Yi6jt9jK3a7klsIWM8h8rpb164tHo17/oyNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

On Wed, Jul 16, 2025 at 11:53:52AM +0200, Luc Michel wrote:
> Refactor the USB controller creation using the VersalMap structure.
> 
> Note that the connection to the CRL is removed for now and will be
> re-added by next commits.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  5 ---
>  hw/arm/xlnx-versal-virt.c    | 56 +--------------------------
>  hw/arm/xlnx-versal.c         | 74 +++++++++++++++++++++++++++++-------
>  3 files changed, 62 insertions(+), 73 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 71c3314b8b4..5d4b30f0ff9 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -17,11 +17,10 @@
>  #include "hw/cpu/cluster.h"
>  #include "hw/or-irq.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
> -#include "hw/usb/xlnx-usb-subsystem.h"
>  #include "hw/nvram/xlnx-bbram.h"
>  #include "hw/nvram/xlnx-versal-efuse.h"
>  #include "hw/ssi/xlnx-versal-ospi.h"
>  #include "hw/dma/xlnx_csu_dma.h"
>  #include "hw/misc/xlnx-versal-crl.h"
> @@ -72,14 +71,10 @@ struct Versal {
>      } noc;
>  
>      struct {
>          MemoryRegion mr_ocm;
>  
> -        struct {
> -            VersalUsb2 usb;
> -        } iou;
> -
>          /* Real-time Processing Unit.  */
>          struct {
>              MemoryRegion mr;
>              MemoryRegion mr_ps_alias;
>  
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 1922a90019c..36341b825eb 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -12,10 +12,11 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "system/device_tree.h"
> +#include "system/address-spaces.h"
>  #include "hw/block/flash.h"
>  #include "hw/boards.h"
>  #include "hw/sysbus.h"
>  #include "hw/arm/fdt.h"
>  #include "hw/qdev-properties.h"
> @@ -38,12 +39,10 @@ struct VersalVirt {
>      int fdt_size;
>      struct {
>          uint32_t gic;
>          uint32_t clk_125Mhz;
>          uint32_t clk_25Mhz;
> -        uint32_t usb;
> -        uint32_t dwc;
>      } phandle;
>      struct arm_boot_info binfo;
>  
>      CanBusState **canbus;
>  
> @@ -66,12 +65,10 @@ static void fdt_create(VersalVirt *s)
>      /* Allocate all phandles.  */
>      s->phandle.gic = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
>  
> -    s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
> -    s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
>      /* Create /chosen node for load_dtb.  */
>      qemu_fdt_add_subnode(s->fdt, "/chosen");
>      qemu_fdt_add_subnode(s->fdt, "/aliases");
>  
>      /* Header */
> @@ -152,60 +149,10 @@ static void fdt_add_timer_nodes(VersalVirt *s)
>              GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ, irqflags);
>      qemu_fdt_setprop(s->fdt, "/timer", "compatible",
>                       compat, sizeof(compat));
>  }
>  
> -static void fdt_add_usb_xhci_nodes(VersalVirt *s)
> -{
> -    const char clocknames[] = "bus_clk\0ref_clk";
> -    const char irq_name[] = "dwc_usb3";
> -    const char compatVersalDWC3[] = "xlnx,versal-dwc3";
> -    const char compatDWC3[] = "snps,dwc3";
> -    char *name = g_strdup_printf("/usb@%" PRIx32, MM_USB2_CTRL_REGS);
> -
> -    qemu_fdt_add_subnode(s->fdt, name);
> -    qemu_fdt_setprop(s->fdt, name, "compatible",
> -                         compatVersalDWC3, sizeof(compatVersalDWC3));
> -    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                 2, MM_USB2_CTRL_REGS,
> -                                 2, MM_USB2_CTRL_REGS_SIZE);
> -    qemu_fdt_setprop(s->fdt, name, "clock-names",
> -                         clocknames, sizeof(clocknames));
> -    qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> -                               s->phandle.clk_25Mhz, s->phandle.clk_125Mhz);
> -    qemu_fdt_setprop(s->fdt, name, "ranges", NULL, 0);
> -    qemu_fdt_setprop_cell(s->fdt, name, "#address-cells", 2);
> -    qemu_fdt_setprop_cell(s->fdt, name, "#size-cells", 2);
> -    qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.usb);
> -    g_free(name);
> -
> -    name = g_strdup_printf("/usb@%" PRIx32 "/dwc3@%" PRIx32,
> -                           MM_USB2_CTRL_REGS, MM_USB_0);
> -    qemu_fdt_add_subnode(s->fdt, name);
> -    qemu_fdt_setprop(s->fdt, name, "compatible",
> -                     compatDWC3, sizeof(compatDWC3));
> -    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                 2, MM_USB_0, 2, MM_USB_0_SIZE);
> -    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> -                     irq_name, sizeof(irq_name));
> -    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_USB0_IRQ_0,
> -                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -    qemu_fdt_setprop_cell(s->fdt, name,
> -                          "snps,quirk-frame-length-adjustment", 0x20);
> -    qemu_fdt_setprop_cells(s->fdt, name, "#stream-id-cells", 1);
> -    qemu_fdt_setprop_string(s->fdt, name, "dr_mode", "host");
> -    qemu_fdt_setprop_string(s->fdt, name, "phy-names", "usb3-phy");
> -    qemu_fdt_setprop(s->fdt, name, "snps,dis_u2_susphy_quirk", NULL, 0);
> -    qemu_fdt_setprop(s->fdt, name, "snps,dis_u3_susphy_quirk", NULL, 0);
> -    qemu_fdt_setprop(s->fdt, name, "snps,refclk_fladj", NULL, 0);
> -    qemu_fdt_setprop(s->fdt, name, "snps,mask_phy_reset", NULL, 0);
> -    qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
> -    qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
> -    g_free(name);
> -}
> -
>  static void fdt_add_rtc_node(VersalVirt *s)
>  {
>      const char compat[] = "xlnx,zynqmp-rtc";
>      const char interrupt_names[] = "alarm\0sec";
>      char *name = g_strdup_printf("/rtc@%x", MM_PMC_RTC);
> @@ -529,11 +476,10 @@ static void versal_virt_init(MachineState *machine)
>  
>      fdt_create(s);
>      versal_set_fdt(&s->soc, s->fdt);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
> -    fdt_add_usb_xhci_nodes(s);
>      fdt_add_rtc_node(s);
>      fdt_add_bbram_node(s);
>      fdt_add_efuse_ctrl_node(s);
>      fdt_add_efuse_cache_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 6c5eb6d3fd5..4e4df0851e8 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -30,10 +30,11 @@
>  #include "hw/net/xlnx-versal-canfd.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/misc/xlnx-versal-xramc.h"
> +#include "hw/usb/xlnx-usb-subsystem.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -78,10 +79,17 @@ typedef struct VersalMap {
>          uint64_t ctrl;
>          uint64_t ctrl_stride;
>          int irq;
>          size_t num;
>      } xram;
> +
> +    struct VersalUsbMap {
> +        uint64_t xhci;
> +        uint64_t ctrl;
> +        int irq;
> +    } usb[2];
> +    size_t num_usb;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -106,10 +114,13 @@ static const VersalMap VERSAL_MAP = {
>          .num = 4,
>          .mem = 0xfe800000, .mem_stride = 1 * MiB,
>          .ctrl = 0xff8e0000, .ctrl_stride = 0x10000,
>          .irq = 79,
>      },
> +
> +    .usb[0] = { .xhci = 0xfe200000, .ctrl = 0xff9d0000, .irq = 22 },
> +    .num_usb = 1,
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -420,33 +431,71 @@ static void versal_create_canfd(Versal *s, const VersalSimplePeriphMap *map,
>      qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
>                             GIC_FDT_IRQ_TYPE_SPI, map->irq,
>                             GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>  }
>  
> -static void versal_create_usbs(Versal *s, qemu_irq *pic)
> +static void versal_create_usb(Versal *s,
> +                              const struct VersalUsbMap *map)
>  {
>      DeviceState *dev;
>      MemoryRegion *mr;
> +    g_autofree char *node, *subnode;
> +    const char clocknames[] = "bus_clk\0ref_clk";
> +    const char irq_name[] = "dwc_usb3";
> +    const char compat_versal_dwc3[] = "xlnx,versal-dwc3";
> +    const char compat_dwc3[] = "snps,dwc3";
>  
> -    object_initialize_child(OBJECT(s), "usb2", &s->lpd.iou.usb,
> -                            TYPE_XILINX_VERSAL_USB2);
> -    dev = DEVICE(&s->lpd.iou.usb);
> +    dev = qdev_new(TYPE_XILINX_VERSAL_USB2);
> +    object_property_add_child(OBJECT(s), "usb[*]", OBJECT(dev));
>  
>      object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
>                               &error_abort);
>      qdev_prop_set_uint32(dev, "intrs", 1);
>      qdev_prop_set_uint32(dev, "slots", 2);
>  
> -    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>  
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> -    memory_region_add_subregion(&s->mr_ps, MM_USB_0, mr);
> +    memory_region_add_subregion(&s->mr_ps, map->xhci, mr);
>  
> -    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[VERSAL_USB0_IRQ_0]);
> +    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
>  
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> -    memory_region_add_subregion(&s->mr_ps, MM_USB2_CTRL_REGS, mr);
> +    memory_region_add_subregion(&s->mr_ps, map->ctrl, mr);
> +
> +    node = versal_fdt_add_simple_subnode(s, "/usb", map->ctrl, 0x10000,
> +                                         compat_versal_dwc3,
> +                                         sizeof(compat_versal_dwc3));
> +    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
> +                         clocknames, sizeof(clocknames));
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
> +                               s->phandle.clk_25mhz, s->phandle.clk_125mhz);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "ranges", NULL, 0);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node, "#address-cells", 2);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node, "#size-cells", 2);
> +
> +    subnode = g_strdup_printf("/%s/dwc3", node);
> +    g_free(node);
> +
> +    node = versal_fdt_add_simple_subnode(s, subnode, map->xhci, 0x10000,
> +                                         compat_dwc3,
> +                                         sizeof(compat_dwc3));
> +    qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-names",
> +                     irq_name, sizeof(irq_name));
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
> +                               GIC_FDT_IRQ_TYPE_SPI, map->irq,
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node,
> +                          "snps,quirk-frame-length-adjustment", 0x20);
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "#stream-id-cells", 1);
> +    qemu_fdt_setprop_string(s->cfg.fdt, node, "dr_mode", "host");
> +    qemu_fdt_setprop_string(s->cfg.fdt, node, "phy-names", "usb3-phy");
> +    qemu_fdt_setprop(s->cfg.fdt, node, "snps,dis_u2_susphy_quirk", NULL, 0);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "snps,dis_u3_susphy_quirk", NULL, 0);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "snps,refclk_fladj", NULL, 0);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "snps,mask_phy_reset", NULL, 0);
> +    qemu_fdt_setprop_string(s->cfg.fdt, node, "maximum-speed", "high-speed");
>  }
>  
>  static void versal_create_gem(Versal *s,
>                                const struct VersalGemMap *map)
>  {
> @@ -1009,14 +1058,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
>          object_property_set_link(OBJECT(&s->lpd.crl),
>                                   name, OBJECT(&s->lpd.rpu.cpu[i]),
>                                   &error_abort);
>      }
>  
> -    object_property_set_link(OBJECT(&s->lpd.crl),
> -                             "usb", OBJECT(&s->lpd.iou.usb),
> -                             &error_abort);
> -
>      sysbus_realize(sbd, &error_fatal);
>      memory_region_add_subregion(&s->mr_ps, MM_CRL,
>                                  sysbus_mmio_get_region(sbd, 0));
>      sysbus_connect_irq(sbd, 0, pic[VERSAL_CRL_IRQ]);
>  }
> @@ -1198,11 +1243,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
>          versal_create_zdma(s, &map->zdma[i]);
>      }
>  
>      versal_create_xrams(s, &map->xram);
>  
> -    versal_create_usbs(s, pic);
> +    for (i = 0; i < map->num_usb; i++) {
> +        versal_create_usb(s, &map->usb[i]);
> +    }
> +
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
>      versal_create_trng(s, pic);
>      versal_create_bbram(s, pic);
>      versal_create_efuse(s, pic);
> -- 
> 2.50.0
> 

