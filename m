Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2CDE7717D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 22:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tK3Yh-00070w-6X; Sat, 07 Dec 2024 17:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1tK3Yf-00070l-LJ
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 17:45:53 -0500
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com
 ([40.107.237.80] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1tK3Yd-0002IB-BK
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 17:45:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuHcWr5DOR1U1f04KiaIKKDztv9wpBNU98+PQgwNI+r4uSjpUrwYyuUE6oxzrdSCLaGnU5r9+7UWfELh+GNp0ajZKO5weAOdR1pGOcyzTtnYm9PMtcGQcna178zrwBqzhEx/AWK0+qH0XnC/fHBbBnODh5noGqo+FDAtKxfWlA4tr/YQdesfGG4uOWOO0Max0DQhEXzVi7gJuF1N+WErUaS8y45W7LGUyR0TQl+XQT7R9fJ0yDlZqcYhj3v/qgb0U7EiPEzHGufP3OoOgl2j/IaWKajWMsMf6fmyUiCUuZ2ifppHoWmFxCqoVCpF2yIIAf1wbg+ExDTzmnCSq3AFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9C+MlzfqkwDQ1JqYYyN1eZ7k6vr5P2yI718QkMmgwU8=;
 b=rJSSG24zOXdVYuTS3QZxVKi1442GKrnLIeFORBrpLCMeVc8G2vDc8fIplJegn9SBmGOvQkaveKeEQizKkPztqxHQh4FxTILVZsmJPGMich0zXRTxtinTPIHhoS+3MnXw54f1PqhmKEpv6MAE6xFS46pP5xpJ3a4XrKYGqG9SFa1z2i3KcX/cpKPJHK9D+HSVNOWBfGbiUUGJNXT/H3pMGK6gjL+h8ySvlZteeatogi+z7YMVswI0evPxD+gMv2UYQFEGoW5oGB3hNB5+1ZuG0OdghiWrkU1eBPUI6l+lmmCzlCXFPcZl6d1LUUCiHuCk5VvXdLoxm1CXENmin14RIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9C+MlzfqkwDQ1JqYYyN1eZ7k6vr5P2yI718QkMmgwU8=;
 b=M8oghdbko+RklWjQ5IpQHjaGUCpbi+s84JP5vuDAZnFzv1qG7CNNG/Uvb8QO2YfKovPk8js3CIEmq8fwhfdT4s4whGYajIg/PZFG3ANWCKDPPfUl7RSC1GufM9yKJAzs3M2ZU9XKeq4K1jwkD+3C1Tpm+07J4Uz7jvwuJ9qcGnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Sat, 7 Dec
 2024 22:40:43 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%4]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 22:40:43 +0000
Date: Sat, 7 Dec 2024 23:40:37 +0100
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Vikram Garhwal <vikram.garhwal@bytedance.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: Re: [PATCH] MAINTAINERS: Add correct email address for Vikram Garhwal
Message-ID: <Z1TO5a5QbMyrqhRt@xse-figlesia-l2.amd.com>
References: <20241204184205.12952-1-vikram.garhwal@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204184205.12952-1-vikram.garhwal@bytedance.com>
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: a36fd916-f736-4399-c376-08dd17102f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnEzaDZOUFEzWlArbHJmY3FCcitmSXFmbzhjMUwvZGcyeGpIV3FrYWZ5dlFU?=
 =?utf-8?B?NmNReThEQ3hSRTFiM0M4QXNDV0NsTTFGcERPU21jQXlmTVVkejN5VzF3cG92?=
 =?utf-8?B?bW9RdmZqKzlaL0hOTlNhMnVJUmNtTnB1Uk43UXpCZ3MwRjEvalJ2N0tBSlRm?=
 =?utf-8?B?TjVJVzZ5eCtaKzdhUE9SSTMwVGJqSVFTS3RzWXpCTDU5WEZvNUpUUk55dytr?=
 =?utf-8?B?SEVyZDNZVjdVVTdBZXBibElpdmszOUFYL05DdWhLYkErWUg5T3pKWTBMRmJk?=
 =?utf-8?B?S2Z2cHdiaUYzL0RrT0RpWHQyYnpIbGIvc2FHa1pjQ09SVE5ZeEpvZEkycUhN?=
 =?utf-8?B?YkhIQWRERWFIblh1bEpKYTlFQXh3dlRQTUc5bEMzSStPWkI5dVNNS3FmaHo5?=
 =?utf-8?B?Nmx1Q3FGWVY2NGd2aUVIZ3NHWWlxRk1PaVlKa2sycVg3UUx6Sk5rTDA3VG1v?=
 =?utf-8?B?ekIvWHpqMGk5dXpwRzRHbmRrQzJMS1RCY0pReDg1cGowQ0RJdkxxWEhUVFQv?=
 =?utf-8?B?TlY1V2N0SmRnOGJaUGU5dHhJQVhUZG51bllqTitOSFZxUTZSRXd1K3pVc1pu?=
 =?utf-8?B?SVpJOGZLRmYzeGJhdm1ySU9hOCtxOWovS2ZvR1ppYjhNRGZVMTJsejJOdi9l?=
 =?utf-8?B?b0k3TEY3L1FxMDIrbkVBNmRJOHNnTGZFekJWZElsR1RMNTBJVDZEYjN2YlNN?=
 =?utf-8?B?LzZ5UnRIZlV5SEJsQlFFakJGK3FhemRud3ZhTzNUQ1hhSm96TUZWK0xtRjN2?=
 =?utf-8?B?R3VkMGhqMHU3T2xDdkFUQUNvMFc5MlAwOXY4Q0x4eHd6clBYSk1qaDNNQXB5?=
 =?utf-8?B?UHNyT0FlZ2x4dTR0Y2FnaEIvTXZDbVBUcmxVTHhWOFhHNU03TytvaHN6SHp4?=
 =?utf-8?B?aTJlNHhqSWRzQjZuR0J2V0ZtTGQ5WnZGY3h0Q1RNUjNIU01YclJnQmhrc1Bn?=
 =?utf-8?B?MGgrRkFnMVZkNHQzZEtvVGw3NW90cG5GQ243MmtKaTBtWG1jRUJMYmpKV0lx?=
 =?utf-8?B?VElvUVEzdURiWXo0QU9PSFpNYzVFWXg2Mi9XaFNSUTUzdnRNclkxMExzU0I3?=
 =?utf-8?B?TUhTbzlyakxVTjlGVjVmbVhWUFBCUFp5Wm5udzEwc2pQL1JJRU9NTFRHY3dU?=
 =?utf-8?B?UU0veUZQY1U2dHd0SXVYK1drOW9xVTlrTmJ3YVV4cXBqdWRTNDM5bjZKbCtx?=
 =?utf-8?B?YS92SlBHY0xGQWs5dTZEU1lSY1RqNXJWbUxCaGRmYlowQ2VCZ2lGUGpXbkRJ?=
 =?utf-8?B?S05JbUdsaDBNZGx0QkZwNHVoNjJKQzNYUUp1UDVMaktoL3JYc3N4TjZHOElJ?=
 =?utf-8?B?MTROb1FhWlNVZ1hQRmE1RzdpQzludFlyVkJLMjBlaUNQS0hGNDNKT09HUFFq?=
 =?utf-8?B?R2psY0p4OTMyWVpMazFLVzM3WTFEM3NXdi9Kd0NOSDRrdy9Pcjg4M0s5S2NN?=
 =?utf-8?B?aFh0S2xDY1ZhL2tFemJXcFl5ajBlSW43RGxWSU56OWRwUXYvSU4xUGZrY3lv?=
 =?utf-8?B?dHo5SGNNOWVpeDErK3ZSRndycTkreTA3SnVTQ2dIb3p0dzR0S1JQY1ErWjZU?=
 =?utf-8?B?NFpHQ3ZCdm9sTitIc2tkN3krUjVMSk1zUE5LMTdwajRwN0lRT1gvbmxKa1cv?=
 =?utf-8?B?cjVhZXR3UmtkdUdzWlgyUTExa29HT2IrbkpDOVFWK2t2UFZtZ0JCVEhyUnBM?=
 =?utf-8?B?RWRLWWw4NndJS0ovZVJWcENsVmF3OXZuSzUwSU85elVucDVOT050Qk9HSVhi?=
 =?utf-8?Q?Blnp21oZuxf2i7KL/Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjF2UGtRVmhxaUVLSEd5QktxbzZiZFZodmUxcGtPRDZjQXBRU09KVTlRUlJh?=
 =?utf-8?B?dXluMjk5NXZCSFR2R28vamltc1VrMDV3ays2OXZTNVdXc2UvWENMZnpubnFI?=
 =?utf-8?B?SnB3Ry8xQnVBYkRQTkdJNTd1K1ozRi84eVJmVkdlQzdZR0Jpc25LKzJYbU8w?=
 =?utf-8?B?RnJWUUZ0blNSM2lyMEVYRHJLU09BeHVJVHFtY3BTNW02QklsVWhyM2o2cHo5?=
 =?utf-8?B?RE5neVNFZ2hCQWJhaTZMOXZ6RFFFSEQzMzJEUmNkUW41UVkzMUlCU2t1RXB3?=
 =?utf-8?B?d29ncGlHMjhDZW9TOExvMmMyaXpzbXYxamh0bFhVNFNhc1p0NlU0ZFhtWUky?=
 =?utf-8?B?R3NLMFhXR21DckpTU1hwR1laYjEvSldESTZnZWxuMitDU1ZmcUFUdmthbWRL?=
 =?utf-8?B?TXJEZ2ZoaWtRcjFnaTdGZXkzVFo2c2g2dmRmaElGRzFURE9JRi9XNXdJNDBU?=
 =?utf-8?B?ZUlZVDR3TTJqN01VelE0TXA0UHZrTDBDaFhtQ2ZvRW9iWGk3OUM3R1daQWFy?=
 =?utf-8?B?MGZsUkRRdkpDNkl6bW1CVGdzb2VUN1N6TGNwa29UdFZVQ2pjUDJKRE9wbkt6?=
 =?utf-8?B?MXhBSFJEOHdlbGIzZ0dRT2N6Z1c3aEhBbkI3TW5vNHJjeFkrZ2xkR0lGWlFR?=
 =?utf-8?B?VVYyUElQNUpPc05nS2hMcFNGT2ZkL21GRlJER0VxSVYwZEZMMHZmNk1uUno5?=
 =?utf-8?B?c2ZpRWZSbzNRZ2R6azVMaStJekl1QmlMd2RLMXVpOERmb1FVRHA2SkdGTjZa?=
 =?utf-8?B?aVBGNDQ3TWV4cTRLaUppVC8yaFgxaGl0U2xKdnBtMmhMazZWSEFMdXR0L2k1?=
 =?utf-8?B?VDFaaHA4Z1dYSGpoNzg0ZkZjQVZWUHNhbzVESS9TYmhWbkxRa01qbXNFTU9y?=
 =?utf-8?B?b3pGbkxFVSs5KytVbUlySlF5NDRWNWNqWmQxV1ZNa0VuMUhsQUNRQ1JXYU1L?=
 =?utf-8?B?T1I0aW5XeTdIaytuM2p4cEJ6UXlEaHgzVmNmUHRVU2RET1UwWTBjRnFNUTdu?=
 =?utf-8?B?anhtSDdGNlMyd0pDZndWS3BYdFhLNXRka3VSNFI1eXpoQ3M4eHRCc002ak9D?=
 =?utf-8?B?V0x3U1hsVEVmZURMM0kzV2ZkeFpUckRaU1A3T0dJUStuUk5MU1M1N3VOanpj?=
 =?utf-8?B?dSsrRVlKUEc5dWhLVUJISGxRSVM0YVY3c2tKUGhFMWtZbDBnUmpReTN5NS9B?=
 =?utf-8?B?MnVSUC9sblYweWZlY1RROW5reTRyUkJYZzBJM2FONkl5a1ZRQnl5MlAyc3lI?=
 =?utf-8?B?SUREL05qRXgwalRpZE5rVTFZNEpnYkVrMW9pQzc2a1JkS0dVMDJKVEtQZzFT?=
 =?utf-8?B?K1pQaVdnOGova1Vqb1ZGTTRCTk5Belo2NE1uQnBGRXVadWkzaUhUSGNVbVJG?=
 =?utf-8?B?V1JPa0N5ODFSb2QwaE1TTDFVRXNEWU81YmZlYU9tUDIyMTlsd1I0bFgzNm1V?=
 =?utf-8?B?d1lzYlBPTS9GOUxpajZYQlhZa0k5QWdJcXJmc1pRTWUvd1JGc0tRWHkwejM1?=
 =?utf-8?B?MXAxQ3k1Wkl5Qnh1ZnI4ZlhTT3lSc1BPbks1OGE4aVduZnR1REVaTk9idjBw?=
 =?utf-8?B?b3hvejAzN3dFUmJnMm1ZRHhLdksydE03enFGcHhrcCtTaStDd052TTNPcHk3?=
 =?utf-8?B?YWZJK0Z5Q0J1dXdHZ0s5akNMSUQyV0kvWHpxcTRVZnBpSlBWOXB4TmgxMmZl?=
 =?utf-8?B?NndFTnJGdjQwd0ludEZhWlg2aWc3cGcyYkRQRE8ySS9BMkh1R0tDSVZNVXpj?=
 =?utf-8?B?cEZ0SzBiRWxWc29WK01MbHJkYmRBbmZjSUk1Zk5hRFlQZjJhQjBLd3dxODFG?=
 =?utf-8?B?bDBRaG5DbjZUVmdUVEcweENrRDJ2MWtreW4xMHd0OEdpZWZLakU2Y1A4c3Zu?=
 =?utf-8?B?M0V5Q0pZSEtUdk5HNDgrdWJPUU9vY3EvNlAxQTRRVDhaYXJlWXJvNDN0SG5P?=
 =?utf-8?B?Zzd0eVRtcWlreit4RTNaRHVsYXAyZmQvZWhTTDZwWGxGN0R4NXphejdMallS?=
 =?utf-8?B?MDRGaHRNeGJOdjJyS2JNMVU0djBVWENrYUU4djlMU1hsSFAwU2V5QnRvMGVV?=
 =?utf-8?B?bnJTSjhtWW15cGN4dUdIU1dSOXVyeTRPK1FQekY0S1JpNUJOd203Um9ZQ0kz?=
 =?utf-8?Q?hxAAkaxvl1wiEV972UFAAeW4W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36fd916-f736-4399-c376-08dd17102f1e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 22:40:43.5083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fjDVlw5OOvbgJiCv9yusrrYxb+igMWh7g5j95f+/67IC2Cng3LKdH0Np4CGo04pppaTcXfoExXixDL71fv4JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
Received-SPF: permerror client-ip=40.107.237.80;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Dec 04, 2024 at 10:42:05AM -0800, Vikram Garhwal wrote:
> Previously, maintainer role was paused due to inactive email id. Commit id:
> c009d715721861984c4987bcc78b7ee183e86d75.
> 
> Signed-off-by: Vikram Garhwal <vikram.garhwal@bytedance.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aaf0505a21..b4723eecde 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1914,6 +1914,7 @@ F: tests/qtest/fuzz-sb16-test.c
>  
>  Xilinx CAN
>  M: Francisco Iglesias <francisco.iglesias@amd.com>
> +M: Vikram Garhwal <vikram.garhwal@bytedance.com>
>  S: Maintained
>  F: hw/net/can/xlnx-*
>  F: include/hw/net/xlnx-*
> @@ -2673,6 +2674,7 @@ F: include/hw/rx/
>  CAN bus subsystem and hardware
>  M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>  M: Francisco Iglesias <francisco.iglesias@amd.com>
> +M: Vikram Garhwal <vikram.garhwal@bytedance.com>
>  S: Maintained
>  W: https://canbus.pages.fel.cvut.cz/
>  F: net/can/*
> -- 
> 2.39.3 (Apple Git-145)
> 

