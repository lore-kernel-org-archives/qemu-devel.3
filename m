Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2BBC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 17:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAudv-0007Vh-BS; Fri, 02 May 2025 13:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1uAudq-0007SL-1T
 for qemu-devel@nongnu.org; Fri, 02 May 2025 13:57:44 -0400
Received: from mail-db8eur05on2116.outbound.protection.outlook.com
 ([40.107.20.116] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1uAudn-0000LI-9R
 for qemu-devel@nongnu.org; Fri, 02 May 2025 13:57:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuRIeTHca+DHt7jj16xDN62Zsxy/cIeBIdD/I9sr74k65Le1Zc0j71Ayaj9+3gERVtZaCr+czfjya0Kb94SKNkB6cQhiEAF8q1H/XjwP9e0k69TxDRmLK436sCkMqxHyyBAPH4CEC0ikTt0rBmqKnBw7ncU+V1lR0N80YMQ+s76x2cToBSx8aLX2JKQ2b4gMWd0oEWwVjsDSrFI2pWMtE79tFmEJ8xWbyE99XxJJBmNq8ES1QdfkGRHhMXwyoyYzyLWdSpqBy2IqcnudlP49PFMd5e2fnB5zvslRgXMGj+0AYDPKI4Ya41I8i0IMUU0oO6leArU38CpXBl9NlMpFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UUlMtdjBioVELoXOw1BBb31vkmpJ9FU66MTaUKE9yc=;
 b=ig0VLpoFiNr34dt4Q4836KCXWLuDJO+qL8TGVAyWN8n7b6IJ5c2heTl6Uj33DNLfKXQVz88Sk1NF48x/PCnYOAGS3METMT3djxp0UiBL7SWKqnucHqCveNMMvG8ufItTzyAgAjLDETCekaPCjiqXHhVsyKfKsZVM1LU057wbd02ZsC5L03xHUQXGGT/ogXYVuQD0on546OZ3k0PWcFV0Nukxj2uLgYCaKr/m86FeTLsdZSTM9btBgl1kOb8hFPeSrsKnXPgjM9+NLh+k1StxtMRJH+B2UaTgvsdOwENlGNYKLBbfo3MSOKhN65SaTSKd6Pl0x7KJRXJ+pI8jO7oLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UUlMtdjBioVELoXOw1BBb31vkmpJ9FU66MTaUKE9yc=;
 b=n4ZPFVyy/0bl2ksgtFnuKK/V6J4lt+l85BB88oRYIoNv2ebxqyM9T2hcbjhqfH29jQnK61tf9QB6iBMzi3VRaDerjmxRZDewTkF1PJsUFPRw67ZkLkYF04g34g/imRdAbuEodKaa1HGER4xZHBk81ezCOOjGEwcvi3aOh4n9I/wIQv/FjjUQyC/ocappO/WEYL/q5RvuHbJrqTwQWDvo4pZ3AMs47CnXjdkgC8W8Dj0Xy891uAyRY1W+rWknWHk0F+68c30fHwe1k5W/7zWD5oY2nKYDdHMM6xIZi1YLWMfUHXm/FTjIGLbxCnqU0tNfBjArd9RTESPO05YF0cISUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB6342.eurprd08.prod.outlook.com (2603:10a6:20b:31a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 17:52:33 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%7]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 17:52:33 +0000
Message-ID: <30875f3e-9535-4d9d-b671-a4f9cd0d4b82@virtuozzo.com>
Date: Fri, 2 May 2025 19:52:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] Block graph deadlock on job-dismiss
To: Kevin Wolf <kwolf@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
References: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
 <aBUCJ0JKiSmegNDT@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <aBUCJ0JKiSmegNDT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 603dfb74-b992-4ad7-bad8-08dd89a21d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0lrYW1Bazg5dmFvNmpuMDVyVGs2SHg4blAxbjB3RXlmaHZrRWhLdXk3TkpU?=
 =?utf-8?B?TVNXYnJ0MVpTL3ROZ3dzS2dOUHJkcTUvKzFWa3ZKenJCNGRxUi9yY2hrckNv?=
 =?utf-8?B?QndTTXo5N2hZK3cxbWJBeFI1TXBkL2RzRElNaUEwa2xsZWpZMXNicTZrNm1J?=
 =?utf-8?B?VnVrWDRXQXdVNkNMZFkxM0x4OWVtSUdQckp2b3hSeDAxa2F6L2NOZ1RyVFBE?=
 =?utf-8?B?dkpjYzcveko4Zkxtb0ZCV01SK2pWdTdzNHdMVFN5eUtrYkhFWDBOZWRiekJk?=
 =?utf-8?B?MTFwdVE5NUJCUTJ0ZkJRaUFPNkk3U2U4MzYwQitLR3dZYVJPalpxUmNUK091?=
 =?utf-8?B?L0VFNytITE5DV2tEa0tOYmV1RzZGb1lVMTdkYjV1WGMvSHd2Q0dGaGVrSnBO?=
 =?utf-8?B?b3I1YnlZM1VrM3ByWU1mc21UcUdqK3kramRZbk1Rb2Jqc0EyRmRKNFRqY0hu?=
 =?utf-8?B?d2hZUjRDTGJhaUNwN1owbGZYUUVJcmVkTW5hZ0NTVEkrZ0RGKy82czNIbHZy?=
 =?utf-8?B?VGpTWXZvNjMyalpJUkFESVRtVUNlcVlqTFVFRWk0S3dTQzZoVzRjeEErVUdE?=
 =?utf-8?B?N29wTk94K2NwWUJmcXBObDRHMmNjTklZWmZ5N24wR0syR1BKUWZvK1ZWcUhE?=
 =?utf-8?B?anR5NDBITVEyU0ZsSm9qdXhGWjZnVVluYUVwZk9vUjJTSzJXaERlTlFDT3J4?=
 =?utf-8?B?WUFoU2orK1JQYWxlVHBvbWNuRHhRSW8wa2NrUUFQaHBpMkdkYnAyVHJoekNH?=
 =?utf-8?B?YU1pUHJ4MUJiK2tEKzdWRklURlI5MHRTNkFvSldKcExicm5RaTh2RmgzaDZx?=
 =?utf-8?B?MDB6T2RObm8rditWRit4NFV6VlhJdUhncGVMU0diZjhvZ2Y4U1VMdGcrR2RM?=
 =?utf-8?B?ZmlKNXpSWldPUW84ME5pZnJDTWQwNis2V3ZnbHowUmx4OHhqdzliKzYrTzNU?=
 =?utf-8?B?VkppT1lSclBsU0JnaDUxY3krNVBRaVFYK3BwUnBFdm4vNEpnck1HWU5iMDlh?=
 =?utf-8?B?RUw0NFhGRTREaW1TM25qa2hXdzJBbWplNWpoSUhUOEswSHFDSCtSOHR6bUZG?=
 =?utf-8?B?MVRzeHA3RzZSeFJqQXZ3WDJqUHk2MDJCWER1WmxaZFFxZ0w3M1RlUTlUbGwv?=
 =?utf-8?B?NHV4U1ZaMFZnQVdKcHI0a3pJbUVWdXhoZ3JiQWhLSWVNU1V2Q0J2dVBWT24v?=
 =?utf-8?B?aDFZMDFBU09XQkUzQ21VY3k4YWZiYWxXK25HanEzcStPUXVYSXo1ZVZvdTYx?=
 =?utf-8?B?N3BhbFVzMHkvVUtUMGl0K2VSeWl1WmhRc013bDkrcEwrR3FzQWlibVFTNU93?=
 =?utf-8?B?SUMwd2laNFJKOFVrazZ3eGNRYlNUaFp5WldTQ1F5N2pKUGQzTWRVY0xLaGp4?=
 =?utf-8?B?ZTVBK0gxMEFyejVJcXB5dnA3Yk93bjNPQlFVRHYwQjBiUW5pTGMwbTZBVDkv?=
 =?utf-8?B?bkd2NTlLUzNFT3VFb0V6KzdWR1JDcjdpK21aY1JJd1Z4Vkp2OG5NK2pTb083?=
 =?utf-8?B?SDF1R0d6a0pXWWM2YkVJbkFJYTRIRTY0Mi9ERGNRVnVWYkdtV3N1d2FvN3dY?=
 =?utf-8?B?MmhRb1UzUVNoQ3RlNXBzakQ3YXYwa1ZiR2tFL2V1RWxhTjk0TlF2VVpUVGVi?=
 =?utf-8?B?R0RNNWk5SndZUSt2bWdWWGg5WGdZNGFlS2I2K0VJK1ZPR2w5aTNEYTR6OVdo?=
 =?utf-8?B?OGlvU0l1VmVuRGRaSXY3aHFDVmNKb1V5clozSW9FMmpWeW1leHdnbHREd0JI?=
 =?utf-8?B?QnVsNUZ5b2xZam0xUStlVzg4aExHRmxKczhSa3BXVnBvQUhNTkM2VWp4UE5m?=
 =?utf-8?B?VFJLb2E4bXVkbXp4dGlGQUZubVpPRjZZSXdoSzZwRThvTHppMlg2bUJvcFVy?=
 =?utf-8?B?MGJUOURHaURWQkNuckdwM1BzdTdoTGhsUjZuY0NqZHExWmhwaXl0a3JRME4v?=
 =?utf-8?Q?2/JUMsHwzGU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRjbWhTUEI1cUlaVExYbE00dzZRNmZ6dkRISU9Lbng2SlR1TEVFRk5CKzNO?=
 =?utf-8?B?T0UyS1FpZVpRejJjMHd0cjFTM0tKTW1JSVNDM3ZYbVhFU0dhV05TRmUxU1g1?=
 =?utf-8?B?REp5M3Aza240WnNLQ0pWb2pWd2VXQ3E5TXBwMFRSOXlidTVEL3IrNkN2a3l5?=
 =?utf-8?B?Q2V0K3owUzlLWHJWL2tqR0FBSE43SFRRcTRvb1Z2WVk5U0VWN2IxNWpOM0Ur?=
 =?utf-8?B?NFdCSHVvbTBxV0toOXVIRFUzL3VtL0JtLzRFc212d2h3ZmVIb2JBcFQ0ODky?=
 =?utf-8?B?aEk4TkhnVXZQNzF6U1NsL1JHVFhxMmEvY2pVUWZTR1hFUE1QNkxteUlSaWpG?=
 =?utf-8?B?cUpXV3V3Rk5nek1IWVlFWkFoY3Y3eFhiTGp3cDMvSlNWT3IzREQzbjVOcjli?=
 =?utf-8?B?aHVZMGU4a2lrblJrc25rU2pMOHZzYU9UTEc4clBxVFRYd3BNSUlnZThaN0to?=
 =?utf-8?B?ZmZ1RjR6TFNzZmhyZnRyWENzcisxaDAzYnFTWkUxdWpab3V2VlF5VDREL2RX?=
 =?utf-8?B?U0JpZUdYRWJHSnp5MUNTdktvKzhSZ2V6MUxHeDkwc2VUUkpKSkp4TWN4b3la?=
 =?utf-8?B?blk0YVZ2bjF6TkZ5S2txaExsOTdTT0Y3WmJoNzdEYzIrTXRONjgzTGl1Ti9Z?=
 =?utf-8?B?N2Q4djlXNHJTYWNpSkc0UWQ3ZjZ3Y2lpUmZzTzMwM2U4bzlOZDJMQVJrM29z?=
 =?utf-8?B?d2tjRTdQZi81WTBtV3dmRzFHWDRjQjZINy9USDlXSVRKeGhWK0hQVm9Ma1lH?=
 =?utf-8?B?SVZpd3E1YkRMaHErNno2SGwwRDc1R0N5T2cyZ2pGdThnZkhPaHpPT1hGSytV?=
 =?utf-8?B?WlVEUDBrWk4yMGRYQjk0dXpXT2xhTlRKUVphWllKTFIydkc0Y0drSkEzYTN1?=
 =?utf-8?B?VUVzV200bUlYVzh4MU5VVnpxeENXeWhMckc0YkVxUlcrRTIybHlnSWJnZ3Qw?=
 =?utf-8?B?ZFltZHRnUG8zK0lWS0pQVWo3OXhid0ZiTmhFeVVGWWU3WnpmK2ZzNjR2cXNG?=
 =?utf-8?B?VmhmNU14MlJQWXpYb25sUnR6N2duK1pEU2VzMlloc0M3OUlUR0RwT2cwa2NQ?=
 =?utf-8?B?dWNlZnVsb082KzFQaGVsMkprTUdrcTNXY25TYnBwZ1h1dDhqa0I0TGZCWHB6?=
 =?utf-8?B?RzArOFgrKzNlNHhKOC9GbTVpUEhOb0NaYlAxUnI3U2VzL3JSMmRDVlNWaGlK?=
 =?utf-8?B?TzRLaGlWYXc1NmhEQVhjQm5DVllNR2hrMHNmd3lvVENZcnpMTkVGUzJyd3VW?=
 =?utf-8?B?SHYxblZGMWI1ZTFZVU9VU0x2S2RaUUZ1RitEZDdNOG9qR1RBbmhnSmRqblVF?=
 =?utf-8?B?eGFLZWRXYlR5b3RyMGhwMm1JYU9kTnI2RmZpeWt3aERvQW5pWjhVcDV3a3Nm?=
 =?utf-8?B?VExpL0VPbWw0Y3V4UVU0alZNYUM4TDM4NjlsRU8zeUwxSEx6dEVCZHU3c2xG?=
 =?utf-8?B?M2xrNEpObytYc29oTjRSS1lYWjBYaUhwbCtBK3lIazlFNHZOaDh2N1gvYklj?=
 =?utf-8?B?UkpOdmUzS2FuM3YwQWsrTjZlUUhVS0o5R2xWbENjaDUzVkt6VVVJY0JrZ2Mw?=
 =?utf-8?B?TWtaZStxYjJ5Smtjdm51Qk53SDY1UUtWMTFxS0RtTld5bGYxUGhSZ0VKOEtX?=
 =?utf-8?B?T2o2UWhIU09zTzdsM0RpOENVSk94TjdDdFNnTC9mcDZ5VFVsdSs1M3R1TnYr?=
 =?utf-8?B?M0t3NzBUQmQ4c1ZVSk1mcW9oa0FwdldkVEFkbVowSFZaSXMyK3dCQ0xvU29a?=
 =?utf-8?B?RmcwZytpdkZ4blkwckJwQkNkd2l5RFVKbkZjMkVEbkNMVU5mVTRaSjVwRURi?=
 =?utf-8?B?ME9iVFJEdWkzY042ajducUpyMzFlaTZDQjZpYWRlR3NnM1MvOE5BMXB6V2kw?=
 =?utf-8?B?eTRXQlgvcWU2eldXNWRvWklCT2Fld3l2dHNIWmVVSXRjc0pzcWQ4T0hjN2gv?=
 =?utf-8?B?ZTVQR2FvMlZlRzBQOHlQRllpZzMzZE5rOEh4OEhWL3hqNXdnaUxzOW1qR1VC?=
 =?utf-8?B?REtkR3dsOTNCVC9kekZZVzFJazUzeXRldUFOSlJ4Y0JLa1d5RjJUQkNoS1dT?=
 =?utf-8?B?bXlHT2J1emM2YVBKdHhRcThwRWQ1TjE0Rk96MlZrQ3FmeTBaamhucmtlNEhn?=
 =?utf-8?Q?cNhyy2+yRwrjEPE4tGMtKZEzz?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603dfb74-b992-4ad7-bad8-08dd89a21d62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 17:52:32.9162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJLRsUseiYhGr/mfr06/Wdlqbs/5eiH8cVmm0udP2OggSfH5/PyKn4JFMSEEWSxShW6+b1H1qQ9fRQwxTv4iEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6342
Received-SPF: pass client-ip=40.107.20.116; envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/2/25 19:34, Kevin Wolf wrote:
> Am 24.04.2025 um 19:32 hat Andrey Drobyshev geschrieben:
>> Hi all,
>>
>> There's a bug in block layer which leads to block graph deadlock.
>> Notably, it takes place when blockdev IO is processed within a separate
>> iothread.
>>
>> This was initially caught by our tests, and I was able to reduce it to a
>> relatively simple reproducer.  Such deadlocks are probably supposed to
>> be covered in iotests/graph-changes-while-io, but this deadlock isn't.
>>
>> Basically what the reproducer does is launches QEMU with a drive having
>> 'iothread' option set, creates a chain of 2 snapshots, launches
>> block-commit job for a snapshot and then dismisses the job, starting
>> from the lower snapshot.  If the guest is issuing IO at the same time,
>> there's a race in acquiring block graph lock and a potential deadlock.
>>
>> Here's how it can be reproduced:
>>
>> 1. Run QEMU:
>>> SRCDIR=/path/to/srcdir
>>>                                                                                  
>>> $SRCDIR/build/qemu-system-x86_64 -enable-kvm \
>>>    -machine q35 -cpu Nehalem \
>>>    -name guest=alma8-vm,debug-threads=on \
>>>    -m 2g -smp 2 \
>>>    -nographic -nodefaults \
>>>    -qmp unix:/var/run/alma8-qmp.sock,server=on,wait=off \
>>>    -serial unix:/var/run/alma8-serial.sock,server=on,wait=off \
>>>    -object iothread,id=iothread0 \
>>>    -blockdev node-name=disk,driver=qcow2,file.driver=file,file.filename=/path/to/img/alma8.qcow2 \
>>>    -device virtio-blk-pci,drive=disk,iothread=iothread0
>> 2. Launch IO (random reads) from within the guest:
>>> nc -U /var/run/alma8-serial.sock
>>> ...
>>> [root@alma8-vm ~]# fio --name=randread --ioengine=libaio --direct=1 --bs=4k --size=1G --numjobs=1 --time_based=1 --runtime=300 --group_reporting --rw=randread --iodepth=1 --filename=/testfile
>> 3. Run snapshots creation & removal of lower snapshot operation in a
>> loop (script attached):
>>> while /bin/true ; do ./remove_lower_snap.sh ; done
>> And then it occasionally hangs.
>>
>> Note: I've tried bisecting this, and looks like deadlock occurs starting
>> from the following commit:
>>
>> (BAD)  5bdbaebcce virtio: Re-enable notifications after drain
>> (GOOD) c42c3833e0 virtio-scsi: Attach event vq notifier with no_poll
>>
>> On the latest v10.0.0 it does hang as well.
>>
>>
>> Here's backtrace of the main thread:
>>
>>> #0  0x00007fc547d427ce in __ppoll (fds=0x557eb79657b0, nfds=1, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:43
>>> #1  0x0000557eb47d955c in qemu_poll_ns (fds=0x557eb79657b0, nfds=1, timeout=-1) at ../util/qemu-timer.c:329
>>> #2  0x0000557eb47b2204 in fdmon_poll_wait (ctx=0x557eb76c5f20, ready_list=0x7ffd94b4edd8, timeout=-1) at ../util/fdmon-poll.c:79
>>> #3  0x0000557eb47b1c45 in aio_poll (ctx=0x557eb76c5f20, blocking=true) at ../util/aio-posix.c:730
>>> #4  0x0000557eb4621edd in bdrv_do_drained_begin (bs=0x557eb795e950, parent=0x0, poll=true) at ../block/io.c:378
>>> #5  0x0000557eb4621f7b in bdrv_drained_begin (bs=0x557eb795e950) at ../block/io.c:391
>>> #6  0x0000557eb45ec125 in bdrv_change_aio_context (bs=0x557eb795e950, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../block.c:7682
>>> #7  0x0000557eb45ebf2b in bdrv_child_change_aio_context (c=0x557eb7964250, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../block.c:7608
>>> #8  0x0000557eb45ec0c4 in bdrv_change_aio_context (bs=0x557eb79575e0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../block.c:7668
>>> #9  0x0000557eb45ebf2b in bdrv_child_change_aio_context (c=0x557eb7e59110, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../block.c:7608
>>> #10 0x0000557eb45ec0c4 in bdrv_change_aio_context (bs=0x557eb7e51960, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../block.c:7668
>>> #11 0x0000557eb45ebf2b in bdrv_child_change_aio_context (c=0x557eb814ed80, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../block.c:7608
>>> #12 0x0000557eb45ee8e4 in child_job_change_aio_ctx (c=0x557eb7c9d3f0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../blockjob.c:157
>>> #13 0x0000557eb45ebe2d in bdrv_parent_change_aio_context (c=0x557eb7c9d3f0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../block.c:7592
>>> #14 0x0000557eb45ec06b in bdrv_change_aio_context (bs=0x557eb7d74310, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../block.c:7661
>>> #15 0x0000557eb45dcd7e in bdrv_child_cb_change_aio_ctx
>>>      (child=0x557eb8565af0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0) at ../block.c:1234
>>> #16 0x0000557eb45ebe2d in bdrv_parent_change_aio_context (c=0x557eb8565af0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../block.c:7592
>>> #17 0x0000557eb45ec06b in bdrv_change_aio_context (bs=0x557eb79575e0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>>>      at ../block.c:7661
>>> #18 0x0000557eb45ec1f3 in bdrv_try_change_aio_context (bs=0x557eb79575e0, ctx=0x557eb76c5f20, ignore_child=0x0, errp=0x0) at ../block.c:7715
>>> #19 0x0000557eb45e1b15 in bdrv_root_unref_child (child=0x557eb7966f30) at ../block.c:3317
>>> #20 0x0000557eb45eeaa8 in block_job_remove_all_bdrv (job=0x557eb7952800) at ../blockjob.c:209
>>> #21 0x0000557eb45ee641 in block_job_free (job=0x557eb7952800) at ../blockjob.c:82
>>> #22 0x0000557eb45f17af in job_unref_locked (job=0x557eb7952800) at ../job.c:474
>>> #23 0x0000557eb45f257d in job_do_dismiss_locked (job=0x557eb7952800) at ../job.c:771
>>> #24 0x0000557eb45f25fe in job_dismiss_locked (jobptr=0x7ffd94b4f400, errp=0x7ffd94b4f488) at ../job.c:783
>>> --Type <RET> for more, q to quit, c to continue without paging--
>>> #25 0x0000557eb45d8e84 in qmp_job_dismiss (id=0x557eb7aa42b0 "commit-snap1", errp=0x7ffd94b4f488) at ../job-qmp.c:138
>>> #26 0x0000557eb472f6a3 in qmp_marshal_job_dismiss (args=0x7fc52c00a3b0, ret=0x7fc53c880da8, errp=0x7fc53c880da0) at qapi/qapi-commands-job.c:221
>>> #27 0x0000557eb47a35f3 in do_qmp_dispatch_bh (opaque=0x7fc53c880e40) at ../qapi/qmp-dispatch.c:128
>>> #28 0x0000557eb47d1cd2 in aio_bh_call (bh=0x557eb79568f0) at ../util/async.c:172
>>> #29 0x0000557eb47d1df5 in aio_bh_poll (ctx=0x557eb76c0200) at ../util/async.c:219
>>> #30 0x0000557eb47b12f3 in aio_dispatch (ctx=0x557eb76c0200) at ../util/aio-posix.c:436
>>> #31 0x0000557eb47d2266 in aio_ctx_dispatch (source=0x557eb76c0200, callback=0x0, user_data=0x0) at ../util/async.c:361
>>> #32 0x00007fc549232f4f in g_main_dispatch (context=0x557eb76c6430) at ../glib/gmain.c:3364
>>> #33 g_main_context_dispatch (context=0x557eb76c6430) at ../glib/gmain.c:4079
>>> #34 0x0000557eb47d3ab1 in glib_pollfds_poll () at ../util/main-loop.c:287
>>> #35 0x0000557eb47d3b38 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:310
>>> #36 0x0000557eb47d3c58 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:589
>>> #37 0x0000557eb4218b01 in qemu_main_loop () at ../system/runstate.c:835
>>> #38 0x0000557eb46df166 in qemu_default_main (opaque=0x0) at ../system/main.c:50
>>> #39 0x0000557eb46df215 in main (argc=24, argv=0x7ffd94b4f8d8) at ../system/main.c:80
>>
>> And here's coroutine trying to acquire read lock:
>>
>>> (gdb) qemu coroutine reader_queue->entries.sqh_first
>>> #0  0x0000557eb47d7068 in qemu_coroutine_switch (from_=0x557eb7aa48b0, to_=0x7fc537fff508, action=COROUTINE_YIELD) at ../util/coroutine-ucontext.c:321
>>> #1  0x0000557eb47d4d4a in qemu_coroutine_yield () at ../util/qemu-coroutine.c:339
>>> #2  0x0000557eb47d56c8 in qemu_co_queue_wait_impl (queue=0x557eb59954c0 <reader_queue>, lock=0x7fc53c57de50, flags=0) at ../util/qemu-coroutine-lock.c:60
>>> #3  0x0000557eb461fea7 in bdrv_graph_co_rdlock () at ../block/graph-lock.c:231
>>> #4  0x0000557eb460c81a in graph_lockable_auto_lock (x=0x7fc53c57dee3) at /home/root/src/qemu/master/include/block/graph-lock.h:213
>>> #5  0x0000557eb460fa41 in blk_co_do_preadv_part
>>>      (blk=0x557eb84c0810, offset=6890553344, bytes=4096, qiov=0x7fc530006988, qiov_offset=0, flags=BDRV_REQ_REGISTERED_BUF) at ../block/block-backend.c:1339
>>> #6  0x0000557eb46104d7 in blk_aio_read_entry (opaque=0x7fc530003240) at ../block/block-backend.c:1619
>>> #7  0x0000557eb47d6c40 in coroutine_trampoline (i0=-1213577040, i1=21886) at ../util/coroutine-ucontext.c:175
>>> #8  0x00007fc547c2a360 in __start_context () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:91
>>> #9  0x00007ffd94b4ea40 in  ()
>>> #10 0x0000000000000000 in  ()
>>
>> So it looks like main thread is processing job-dismiss request and is
>> holding write lock taken in block_job_remove_all_bdrv() (frame #20
>> above).  At the same time iothread spawns a coroutine which performs IO
>> request.  Before the coroutine is spawned, blk_aio_prwv() increases
>> 'in_flight' counter for Blk.  Then blk_co_do_preadv_part() (frame #5) is
>> trying to acquire the read lock.  But main thread isn't releasing the
>> lock as blk_root_drained_poll() returns true since blk->in_flight > 0.
>> Here's the deadlock.
>>
>> Any comments and suggestions on the subject are welcomed.  Thanks!
> I think this is what the blk_wait_while_drained() call was supposed to
> address in blk_co_do_preadv_part(). However, with the use of multiple
> I/O threads, this is racy.
>
> Do you think that in your case we hit the small race window between the
> checks in blk_wait_while_drained() and GRAPH_RDLOCK_GUARD()? Or is there
> another reason why blk_wait_while_drained() didn't do its job?
>
> Kevin
>
At my opinion there is very big race window. Main thread has
eaten graph write lock. After that another coroutine is stalled
within GRAPH_RDLOCK_GUARD() as there is no drain at the moment and only 
after that main thread has started drain. That is why Fiona's idea is 
looking working. Though this would mean that normally we should always 
do that at the moment when we acquire write lock. May be even inside 
this function. Den

