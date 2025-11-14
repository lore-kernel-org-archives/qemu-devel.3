Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83593CEACCE
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK0dF-0003ZS-Lm; Fri, 14 Nov 2025 15:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vK0d3-0003UD-Ev; Fri, 14 Nov 2025 15:42:46 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vK0d0-00086G-L0; Fri, 14 Nov 2025 15:42:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DknwR1+KKfqnewo9Bj7LAO489lXLUlXY+4NidyMIhsqIhQFRs+TscQFPI3xwB8ccwZ2WQu4cTVuv5ElL9va7eskQ8oGKKppRxKJ0t6yyuLO8hlDMx0UFZNBkJQPF4Yd9/Wr0FREhJJb/Ep6+5urnCJCJ5Ts9qQZ5oUDdRzr6cXuekdM6fEhaQsHyxETSWZMd+Uy2XocQ78I2D0qUPP1Nsx3Hex3zvPquvmRX4/7Ci/BV5Arwx8pHw9Cq2gYzkmmOkq/6m9atwLaPC0wfqz82rY0KHYnWz/d9iRYzDjtWgAQkM4NqTPzwfrwUyP710nvTTDvt8kl5kZ9RFquTNyuYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYkcrwtSrZQ0PXy8K3KfYPFIXYrHaRlCK4czOYZ4ZHM=;
 b=lSMGXFgDivcKjx/gCCB1kVD+vAhRAgXRrmEke8NPN5AvYrSFR62qMUmk1ame+U+P+kICCvTuc7lBTS04B5lFX5ykKPfcAuOot0020D3CKm4kb/ncNGzZu0iMS6WfQZpwsYB89k6N7UMrzuGZzLyaTC7+HBjY/6JCsAwS/kdADYJ5lPtXtNhelLoN1rNV/K5Nc9gxyJXMD9vuTpknUV40UZUTaBMAz3oAj8svQqox9W/20yZ8WXbAz8zVPEdDIO4NlACT9MBOSsTd2CfPIsQSUBJQ6YoknEJPq3mSiu/xgN6A721UOOuufBW5n/a8qMzuwFT6jl2X0CmhJuSpXDyB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYkcrwtSrZQ0PXy8K3KfYPFIXYrHaRlCK4czOYZ4ZHM=;
 b=Zc0f8ukgCrco1LA188qBXtsGUSV84Qay9dpep6omTn519ZF4kYmIv3TNnwEbxCN7OgPz1++azKZ/gbfnnXU/PW8WdMYcE5x3yrl7KcmPthr82j6JCtklCSkOeXatc1Sh8DHtUx5bNxfr/ai5WeOomktSMR2v32xZNkppAyVgO3d0PmuylBZFzLCb3YX/1Tk1O/TFGAyE9S6EqH6DB7jbWWwfPq4+ifA1T+NUgFwBSR5RVyLP4gFCACQstX0qBZbKOepWoFPhKO+jxTqbfRrg6NCpiyWBt+3t6Fcoc/Y/Yz9ABvMx5oPe3YGpiJjfB9BMpgS+gLF8Imgg6ZP2nUrWGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 20:42:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 20:42:37 +0000
Message-ID: <d9c56d6c-5560-487c-8cd4-3d2c54cfcb90@siemens.com>
Date: Fri, 14 Nov 2025 21:42:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: fix potential out-of-bounds read in
 rpmb_calc_hmac
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, zhaoguohan_salmon@163.com
Cc: bmeng.cn@gmail.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
References: <20251106072818.25075-1-zhaoguohan_salmon@163.com>
 <CAFEAcA8iWqAgZzH7u3jYTEb-fjjsBWAp3WJY24xAKN8CpdVw9Q@mail.gmail.com>
 <b4d9cac0-8f72-47c2-8357-021c6d6efbc4@linaro.org>
 <b083940f-8d50-4aab-a4ac-a88d1988fd07@siemens.com>
 <e6606f0d-f9b7-46f6-b0a8-36c80ee1ae2c@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e6606f0d-f9b7-46f6-b0a8-36c80ee1ae2c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc12a4a-9ad8-4308-3dfd-08de23be58fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUdIZElTWU0vaVZFQmlXNE11RDluZ3ZjWXdDVE5vblJSUWtlZnFPS2l6N25B?=
 =?utf-8?B?SGcrNUZDVjVHeStsbzN5TkgyckxCY0JnQXh6N1dncXQyMG5xVnpNSjBWYktZ?=
 =?utf-8?B?akVYT2J2VzJrOU15bkxCT3ZYaXdvVkNQd2xtTkpJY2w1c3dtVkRYQ3lzWDRr?=
 =?utf-8?B?Q0ZDcWEwTG5GV3VzVlNvcjhGOUpzNytUYUNVdnJnMVFtdjRXRG5BSTNlR1ZS?=
 =?utf-8?B?d2hoTEpkZk1yWENWREVHSFZkMiszRXExbDJKNG5PUEJUMkM2RnpKOExPaysr?=
 =?utf-8?B?alUwR3dXMndaaFpRTWNRVUVpMHY5bnpGeEVlU3NHSUJkQjZRUE9ScER2YmVY?=
 =?utf-8?B?bVJLSWU4ZGtyU0JzeGtSOVJKNVc0TEpXU01LZ2JwM2dRNDA2VTdUbDlXOTBl?=
 =?utf-8?B?MUVVSGZUT0FRVGNKcEU0UFRRS2VjVis2cDdEOEE1djBjMW5wdDlXcWo5eURz?=
 =?utf-8?B?KzV2OW41enBXTUpiU3dWV1VUbWZrenE4a2hhei9WZU9ubmpnSDBHcU12eVpi?=
 =?utf-8?B?TWd2Wm4xenVwUEYrdWtCc1lFanM5L0dSY3RoS3NPV2o0NXg0a0FCc2N0bDFi?=
 =?utf-8?B?cjJuYlI0S01DdldkYUhqSEg5L2tES3ZpTGZZa1VIL1c3RFVvQjg1RDNtNzlr?=
 =?utf-8?B?bG9VNndlSTZEZCtWQVZXdHRqSjBhYVhwT1ZtLy8vaVBCU0gvS2FQNWdWYnM4?=
 =?utf-8?B?dlFVd1ZUbS9rUStlak1qRUtTQUh4WHIvOEh2ZVpWVnlGT3pUbWQzUzdkQldI?=
 =?utf-8?B?M1NpR3NRMGFScDhmdWx6RkFUUVlSU0pYN255c0h5MCtjcUM0dWtsdUpEV2NL?=
 =?utf-8?B?Nm1BT2VYRGVycGJzMTBONFhIZWgrVXVUQTl4R2U0UWJ6dGRyeEhRZ3FRMmp1?=
 =?utf-8?B?OC8vS2tlS0ZRRi9oU1FMNytZaElEUVJpdk50WWpaUnZKRnQ2MitUcVlhODYz?=
 =?utf-8?B?dXdveWpSN3Z3K2RnYmhmVXJSdG9sbzkxVkR0SVdQekhiM2YybVdTd3ljNUd0?=
 =?utf-8?B?dDNCbnFBNWRjYk1vK3k0T1dONTcyM0lvdVd6K2pzOWVVMTEzQktWR2RkZlpu?=
 =?utf-8?B?Ym9udzJoenZvSi9QcHR1ZHV2dUFKMHRsWkJUME1hQ2wrYUJSeEYvekk3SDFu?=
 =?utf-8?B?TW9Ceno4Sy91S2lUMW41aDRadDJWMDhTOUExTjNhN1JIdXlnUGFTWi9zK2FX?=
 =?utf-8?B?S3A3c0Y2WUpHVXF6VUllVmJGRzRjMXA0N2FWcDRFN01MSVF4dnpDOEdYYW5P?=
 =?utf-8?B?M0lYQ1cyS1pJWFZWKy8wWXpWSjRoVFN1VStLcHM5dDNRU1I2aWpsSE5DbXBm?=
 =?utf-8?B?KzFwZXJUVk9mazVpVnZ5OXBGVDNXeHVsYTNvUmwxZ0t0WmtRNjZxZGJjWnlQ?=
 =?utf-8?B?U0tHK0tMaU5tNDhIaTc4V1F0WGxBUlhYMFAwRXF3YXZKZndFeWs4dnk0L3Fv?=
 =?utf-8?B?emZ6bGZ4aWtZdUM5UjFLSXhIT3MxbGZqMm4rMENlRHh2VHc5WEpiZ2N6ZXpp?=
 =?utf-8?B?ZC8xWjFtTlB5QUdrRWp5S09PTnNiR0J4ZFdKVFk5M2tWOHkzM1d3Qmh0VkZw?=
 =?utf-8?B?WjNKUk9pZ2oxTVIzUzU2dndDYndxeGdQZFpUQlZEcVVoM0wrR0pBZ2hFZkpQ?=
 =?utf-8?B?V3B0dC9kbHk5cFMrSTI4b3JmRW1GdmpXd014ZWZlNkdLcHhhcnUxaFMrbDVp?=
 =?utf-8?B?eGF2UGE4MndEcVhhc2EvOGdQWnhMMjlUbWhUdlJkRUpqQlUzSXZ6VnFWYjlZ?=
 =?utf-8?B?UTREdW8xMURZcnAvbGc4aTg3RG1Vanh2SDlxSUF0TG1aSm5FWFBJOGEvUlhK?=
 =?utf-8?B?MlNWYkdzUWttNktoSjgzNXFUNXFRMk9xZ3JBRGVRT2lnTFlMUFRXQ0tMUXpa?=
 =?utf-8?B?QStmMVl1N25iNzA2UUZ0NytlZUlyQ1dDNXRSLzBuR1ZMb1YyTUplS2YvbUtJ?=
 =?utf-8?Q?IWD803+0FY8YQNUnqk5fSBzYrjbrJIXq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak1ya25FNVFFNjBTWWdoWFlKb2I3bnFMa0gwYXFxQWR6Ykt4M3JGVFFySjdi?=
 =?utf-8?B?bDBVU3NSM1kzNXlsd1ZyQVZ0dU1SSWlEbUNRR25INVg5MkhFNE5FYnJJOERk?=
 =?utf-8?B?OU1sZFBvOWNwQ3UrMDRhemtwTzRpemRPakVTN01TOG9pQ21FNEpRNms4MUdq?=
 =?utf-8?B?bjdiWUVCekwra3BJM3dPeXRuTk1VQklkOEs4RzV4Qmpka3g0RUU0RlU2Z2N2?=
 =?utf-8?B?c25YdSt2T3dZT0VBODBZWUoyRzlteVpNTWxqQ1JlUXJvNWVpakNMa0lrb01B?=
 =?utf-8?B?dytrWTNPQitlcUNNUDBTeSsvaXBVaFZpWVNUaGJ5OFN1dWRuYlozano3eHNu?=
 =?utf-8?B?RTN5QzN5YjBSVUZFSWVqUlY0L1lYcU9OQXhnQUNkYlJMVWV5MFFVc2dqWXFK?=
 =?utf-8?B?OExIYjN2V2lON1Y0TnRKeStTZTdTQWw4Zk10R09UbzdXVXJ5R3pxbEUrVzda?=
 =?utf-8?B?YzM5Y01UUGRRWXk5aGVYZWdkbGlnQm9zRVR1Vi9TOVpUdThzM1UwcmRPNXVD?=
 =?utf-8?B?andDdU5ZK3gwOStjS0xwdUVXMGxsUDh0eVVSVjB4ZWRLYXNHMDM0K2MzTUxa?=
 =?utf-8?B?WGlrOGRjdVBqNldVb1hkUW9QYXRjUDgzOEFXWUxMYUJWeDM5UG9XME55UkhZ?=
 =?utf-8?B?V2lUdlNqbDU4d2hyRG5FYVVFb3FtSFcwZ3F6YkJwRmN5MjIzU003K0xQd3Ux?=
 =?utf-8?B?eXNLWmR4a01xR3ZlWG92YkY3dVpwMzZ4bGpiaElRNEZUL0J1UjNra2R2MU53?=
 =?utf-8?B?K1p6MnRoSDBCckx1clRwV3NtLzB3YzJnQjRSK0p6UFhFR2U2Qm9EaWJtbHNz?=
 =?utf-8?B?Z1BUaFBxb3FYUHhLK3NPSGk4SWxZTFBoTmEyZnA2WWpxT0hvdkNNaDBLdVJL?=
 =?utf-8?B?SGNEVU1WcFlIbU0xdzV3a0JpMS81RllhRzR6eHdqWHVGaW9ZbWFTbmZtYlVy?=
 =?utf-8?B?dWRWS2JjN1FWandXUWJ5djYzS3NDSTYyYUpNUUY2TjZXMjBFNXZiamxjUGFh?=
 =?utf-8?B?bUlqNVJwUDFoZkpBV0dvMTVPWDcxY0pEZlZHQnRsVmN6ejM3M0lSM2krRmtx?=
 =?utf-8?B?b0s4Skg5NGQwNkFZLzlPL0ZXd2FOWnIrMzhxWDJ6R29JM0FXdGN3TXpQMjN1?=
 =?utf-8?B?SW1ReElPR3g0enVrck1vbGkyeStGQ1pEWE9CeUJaRG1MRkM1MkhmSittQklO?=
 =?utf-8?B?MkIzQTNwaVVaYzhOclliN1RsY3hybHlwcEFjTzZDdmc4aloxT1I4dmdXSXBR?=
 =?utf-8?B?ODJLRmNGU1J0YkdZL25kSEgzOU95R0hWbUxDaXlYVThNMDhyMFgzUE5VMlpP?=
 =?utf-8?B?TjlrV3pIdnBXemx5S2x6Vkl5UWdzR3RHYTRyRTY3Tmx4NWY3Uk9SR25zWU9s?=
 =?utf-8?B?REFLWFExUGV4cnh4WFNTSDRVdDB1Yy92eW8wK2tDTjlXTDBhUW5MbExVbEZm?=
 =?utf-8?B?MnI3S0MzV204aFZxZjkxQzAyUG9CQVhqdHh0Yml6d055UGdrNE42WHZJRHgy?=
 =?utf-8?B?ZUxrRXBBU3poRW45QXNBNFBrdDhTbU9QNEdMd3NDQk4vb1JjMzhodFkwbHE1?=
 =?utf-8?B?OFlVbGZ2UlV0Rm1USURJK2tpbS9BcUJkK3RlbmN5TFhiNDRWLzNaZFNmd2dq?=
 =?utf-8?B?anhYNUcwQk0zRTdpUGpmTkhjeUg5MWlKZ0N5SkI2dXE3NDVHc3NPY3pPNUNT?=
 =?utf-8?B?SzVDNUEyZlNHWlJtZVQyczRNTjlkS1k2SW1QOG5oN1VXbldhYjVkeFZDSnhk?=
 =?utf-8?B?SUlHbHNlNlh6OUpsdkZEWjlJVHhxcXVMODlvNTJUUklCUGR6dUNCV1Zxa1Jo?=
 =?utf-8?B?eVNYalhJM041bE9WVlZTNUl6VFZNODNZdU1sQ2RxTzF4VW9rVzMvZW5ZVzdU?=
 =?utf-8?B?UVRXYzJOZEIveEMzbWRUd1pHVkhRTVl1a0ZTcnlVdmdsWWZkdHE4S3E1KzNN?=
 =?utf-8?B?dWZMMTJXQU92K2k4QlJyazBqUk5KM3ZJNjJ2YUZsbjhpZk9VcnE5NXBFNCt2?=
 =?utf-8?B?M1JYMUx5eXE2eFpuQkRQWmlnSHJkWEYzZ1o4bUlTZitKcjBCNE5yTFhTUExo?=
 =?utf-8?B?QTVTWUIzSGNyWXB2RWR5UG1LVDBNcEY0cUlXK1R6bzlGWXZKazNhQnd0bW15?=
 =?utf-8?B?QmhHRUd3RXFBN2VBYUw5RUVKREUvUjJ2VG5kTUR3WEpqSFlFR3REMndBYURJ?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc12a4a-9ad8-4308-3dfd-08de23be58fe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:42:37.7781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDNXL3+/oS+egXquSGVGw2VJ1AWzhZVHLXvTzcTsVtqCTMemUtbcqe8ePUDckxKYoxT4ytRx/I4MUQDrL4h2Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8102
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 14.11.25 21:34, Philippe Mathieu-Daudé wrote:
> On 14/11/25 21:27, Jan Kiszka wrote:
>> On 14.11.25 21:26, Philippe Mathieu-Daudé wrote:
>>> Hi Zhao, Peter,
>>>
>>> On 14/11/25 14:39, Peter Maydell wrote:
>>>> On Thu, 6 Nov 2025 at 07:29, <zhaoguohan_salmon@163.com> wrote:
>>>>>
>>>>> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>>>>
>>>>> Coverity reported a potential out-of-bounds read in rpmb_calc_hmac():
>>>>>
>>>>> CID 1642869: Out-of-bounds read (OVERRUN)
>>>>> Overrunning array of 256 bytes at byte offset 256 by dereferencing
>>>>> pointer &frame->data[256].
>>>>>
>>>>> The issue arises from using &frame->data[RPMB_DATA_LEN] as the source
>>>>> pointer for memcpy(). Although computing a one-past-the-end pointer is
>>>>> legal, dereferencing it (as memcpy() does) is undefined behavior in C.
>>>>>
>>>>> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>>>> ---
>>>>>    hw/sd/sd.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>> index 9c86c016cc9d..bc2e9863a534 100644
>>>>> --- a/hw/sd/sd.c
>>>>> +++ b/hw/sd/sd.c
>>>>> @@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const
>>>>> RPMBDataFrame *frame,
>>>>>
>>>>>            assert(RPMB_HASH_LEN <= sizeof(sd->data));
>>>>>
>>>>> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame-
>>>>>> data[RPMB_DATA_LEN],
>>>>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
>>>>> +               (const uint8_t *)frame + RPMB_DATA_LEN,
>>>>>                   RPMB_HASH_LEN - RPMB_DATA_LEN);
>>>>>            offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN +
>>>>> sd_part_offset(sd);
>>>>>            do {
>>>>
>>>> What is this code even trying to do ? We define a RPMBDataFrame
>>>> which is a packed struct, but now we're randomly memcpying
>>>> a lump of data out of the middle of it ??
>>>>
>>>> The start of the struct is
>>>>       uint8_t stuff_bytes[RPMB_STUFF_LEN];  // offset 0
>>>>       uint8_t key_mac[RPMB_KEY_MAC_LEN];    // offset 196
>>>>       uint8_t data[RPMB_DATA_LEN];          // offset 228
>>>>       uint8_t nonce[RPMB_NONCE_LEN];        // offset 484
>>>>
>>>> so frame + RPMB_DATA_LEN (256) starts 28 bytes into the data
>>>> array; and then we're copying 28 bytes of data?
>>>>
>>>> The existing code (frame->data[RPMB_DATA_LEN]) doesn't make
>>>> sense either, as that's a weird way to write frame->nonce,
>>>> and the RPMB_NONCE_LEN doesn't have the same length as what
>>>> we're copying either.
>>>
>>> Indeed.
>>>
>>>> Can somebody who understands this explain what this code
>>>> is intended to be doing ?
>>>
>>> We hash the frame data[] + nonce[], and work on the card block buffer
>>> ('buf'), filling it before hashing.
>>>
>>> This change should clarify:
>>>
>>> -- >8 --
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index 9c86c016cc9..e60311e49a6 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -125 +125,2 @@ typedef struct SDProto {
>>> -#define RPMB_HASH_LEN       284
>>> +
>>> +#define RPMB_HASH_LEN       (RPMB_DATA_LEN + RPMB_NONCE_LEN)
>>> @@ -1164,2 +1165 @@ static bool rpmb_calc_hmac(SDState *sd, const
>>> RPMBDataFrame *frame,
>>> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame-
>>>> data[RPMB_DATA_LEN],
>>> -               RPMB_HASH_LEN - RPMB_DATA_LEN);
>>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN, frame->nonce,
>>> RPMB_NONCE_LEN);
>>
>> Also broken.
> 
> Sorry, long day :)
> 

Yeah, me too :)

> We really should add a functional test covering RPMB (I'd have
> run it mechanically before posting my reply).
> 

I don't disagree. I have to re-run my full image test for that. A qemu
test just needs a bit time to work it out.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

