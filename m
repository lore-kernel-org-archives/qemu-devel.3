Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD902CEACCC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 21:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK1Kd-0001sH-Sh; Fri, 14 Nov 2025 16:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vK1KZ-0001pH-Fq; Fri, 14 Nov 2025 16:27:44 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vK1KX-0004Pl-Md; Fri, 14 Nov 2025 16:27:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtCwxQjLVYSHy4UQCcqs3B+dBmXg9adyvnKecHYQ4X7yYn+96QpsPiqzHE4nnuaxUi4QXJb8TbkuzeKqqRb1g3bS6imU5Nz4ngwHKhUNCoLhp3mMmeS6+Sadv5UTiOBE3ctqDJwvgvBVVyQQi5v2yNKwYA87wxh0hnykxILGx4m7l3ARNcVDJJtjFF9MUka1/W+K6w5oR+ZjIkNe7NWSEmKhkI9KOs+7drIm28UKxllQuY2FHXAGZpMUgRQC/iPfcweBFHE1CpblzyFAkzPjKiiUtkejGhUzdW4RZZwlM04WUwwIMmqwKZv1kJc3f8UPukm62P9vloo/St05sMQXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9KB6hQw1KgSN3mhAqlivEuNA2XVoy2Nt/f32KEuYVk=;
 b=fjsaclTuSSAHHBsR/4SNX2wVnnfU9RGbCObSkg3pOblBuO2oaNbBKBCnvNyW7UvxK72kUc1crmdAz39ivy1zUjtWPhIwM9aTt+RBh/jJvwgzBiHoPxktkaXqHk+41qDD1U3ZpMhzYzlEeWN9scNEDJK5g1jgSk2eaHxpexboMyol8JSUXv32x3l9GNzQpu5IQcJWjjUdDadabDWU/Sw6OtW+BJcmqHpyLuTYLhsqVOH1EQVth1LRLOg2C/Vp60HkGEvsJAosKIcjAba82mEMPTHGmfohKhmFIYYgCCkn8oqzjxVeeeG2c9/z35JnEN/AXpvROJ9Rb0780lLf/BsgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9KB6hQw1KgSN3mhAqlivEuNA2XVoy2Nt/f32KEuYVk=;
 b=i/wkeaucZciJJAJcIyrT0W/PvW0R8jiQO1DCmEjcFwF1xYIBhSxy/1YrVlzZmPDIUYekPd/S590au+sApe5/UmN8hfJolkdnsrou142LYEqpUam3uojQNMKfoFnWovSomqzRO0W6IUKtw/5Ye5qO5t6CGym6smiiDpaxfyQT5sKgXBfuA0P1CEHYJZxhDLEvCP0vRnvVax7554tJ7ibJ0P0w3+PcnCDleDmlqGBXekKw2twaFHkKVEJ10ZMJGLrg1uAGlpY7nYUXqkx9xEW+sJMfo9+oVX0Mxv53PfTH4HqLuGh7u5hffzmVrDblF6nQBamf2jJTJf6RJZTpuArr5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:462::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 21:27:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 21:27:36 +0000
Message-ID: <4f7e1952-ecbd-4484-b128-9d02de3a7935@siemens.com>
Date: Fri, 14 Nov 2025 22:27:35 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] hw/sd/sdcard: Avoid confusing address calculation in
 rpmb_calc_hmac
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: d095c7cc-4930-46c8-efd2-08de23c4a14a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmtPM3cvRklzWnRXN0NMNXNKWUUwSVJtS3hvRXRXamN3T3hlL2Npa3NDRGpU?=
 =?utf-8?B?RTBBa2NEdVh2anN4U0ZQOWJoRWw3a3k0dzhnaTVmNmJNSUdLVmhiVk0wVXFv?=
 =?utf-8?B?UHRndTBaY2VyNXo0cHNIbFBBZCttVVc1dHRBc1k4YTFmbG5ZcU8zQm12eEg2?=
 =?utf-8?B?aXBWeFl1TUZzUE5RT0xOcTI0aFFpOVpyR1JpR0ZkOHg0ZVJwaEIvQzEzTko3?=
 =?utf-8?B?T3dMZWc2S1hOdUpSblhaUkRjZi9uVEJkQkFZbHJlWTJjYkJuTDIvZFFYQSsr?=
 =?utf-8?B?M2wvdmRrNnY1WEdrTEl0UC90OTZXby9LUlZ2Z0NIUFAwN29WeWd1OEQ0QllN?=
 =?utf-8?B?Q2dqanFxNkhZTEZWcUh3K0Z2eE82SERrbVFHTEh6RG9NL0dzSGdOWGtYOHd3?=
 =?utf-8?B?eWY4ckhyMUsySkExN0dYUmZUZWU2UjhBbjdIdHU4WnRNdDBTSkNLYTFlUko5?=
 =?utf-8?B?Q3NzMTRQL3BGTll2MmhBMlg1WnFZQmZrTEh3WXQrb3Zvd2t3UE54TENhYWFh?=
 =?utf-8?B?Wmt2RlJhQlJBRXhLRUNsTnFqaS9RelBRMHBTWll6NHFic2NZbTBmQmlwU1JB?=
 =?utf-8?B?blBtemlxdStKRDVVRkZpNDgvLzQvTDMxNUFDaStuZ1Q4V2tKQzkzb21aS3RR?=
 =?utf-8?B?S2dYYVFmVmVldDhZaHI0djVOYzhCejZCWjZ1RE9CNk43WnR5ZkRRMDVjdHlw?=
 =?utf-8?B?R1ZHc2Y3UXRmaFhzVXF4U1Q2RjBnWEdtOVV4ZmNBOVpKQUhiUm0xbEEvR3Zy?=
 =?utf-8?B?K3I0RjRJZ3RicElkQ3BoM1N6U0ZpblFtdTg1cEt0NmMvUTlONTFVcHZNRmhD?=
 =?utf-8?B?ZlNtbXo4YXY1ckkzUk1KWHEzNEJtbHVLRGM4LzhOWlQ1ZmJZNnk3d0p4OWRY?=
 =?utf-8?B?ZnM5VkljSnlnNlJVdE9LeHcyT05FQzFvYXI3S3J3Q200bmJnbmVBL1NhaEVt?=
 =?utf-8?B?cVRJZ0plS3dmMVpBZzFsTDMrREE0N056MXFGdVlmZ01BT3NrQ09ZTldYUCs0?=
 =?utf-8?B?T1gvalJ1TW1xaFNTYXVDVjk3a0hSbzYyMXpoQ1NxMHZMZ0sxNzA3ZjhBUUhk?=
 =?utf-8?B?c21Eb3Vtei9TTmE5MEpqdFdJVEtML2JMOWxrOENwbVpaTzk2VkhKdWgrU1A1?=
 =?utf-8?B?b3AyNUMxSW83Yzl6MzdWMVRmUFZsUkNtMmJkY1VVVnRQMVBKb0lhRks5WkUx?=
 =?utf-8?B?cm9CNTA1VlZkdlVuTCtTTVJ2bVJsaTZqM1BZOVpHbEhkbDJVL1FzSEJVSGdI?=
 =?utf-8?B?Qm9yTHphcmJxWlpFUXcvbG9HRTZRK29waFo2WkhYdUFlNENpSG9WMC9ST2E5?=
 =?utf-8?B?dE1YcCtTMW56Qk1ldkw5UnkvVUhPNUtDQWVYQ0hhd3Y3djQ4bFptblRENlFN?=
 =?utf-8?B?NkJIQncxWm1jTnlINU1BaVJNL1QxNzFPZGtRQi9Ra3RNMzh1WldTZm9jWVJ1?=
 =?utf-8?B?ajR5LzcxSmJyeC9KT1l6Wi9meGNLQjEvVHRjdXVJa1plS3ByaVQyR1NHOUE0?=
 =?utf-8?B?RVpEN0xqZ25JMldCZUl1SDJIZ0c5Rkc3WVlndUI5ekgvZXNEQW1WTURoZkxn?=
 =?utf-8?B?SVQ3THA4N1lBODBzVllwQlJvTkxpTEEvRXM0aTZ2ZFJBaUwxaFRVZ3cyWnFZ?=
 =?utf-8?B?bDArNkxJbXJkUU9aK0gwanZuckhHbXdvb0hEOU0xRTNCRGxUdzZJQnRwWExH?=
 =?utf-8?B?MDNXc1J6UTJmN2VPRFJsVlNrWWlpZFN4ZUZUN29tSmU3ZXZ6RmxRWWtFaTd2?=
 =?utf-8?B?VGNnbHRSU1FRM1FUTjRyZXAzYTZxUjZRL3lzWkx5Qy94b2tMNnZVU1JJR0t6?=
 =?utf-8?B?VGQ5SmJheGUyTlB3emVlMlFJNmJjZ1ZCVnIwTWtZRFRFSkpWVlFmOHhLbm5T?=
 =?utf-8?B?OEloTytQODhRdVp1QWNwMUhOZEV4Z042aEVTa2xSbk42TlppbEVCRGtoS2V3?=
 =?utf-8?Q?P3+Dt8M/TsvZGabnGV9mxH4DPhUdDxql?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZQOTJxbkVGMENINHBXd1BMNU1od21NcDRiWGljQmZDMEFjOE5ydEpUUVpK?=
 =?utf-8?B?dHkvZFR2TWNUeHNRZDlNT0xKWnAza2lTeDVuREhNQnQyNHhTNDJBaUZIOFl1?=
 =?utf-8?B?UTRLWkxmZTNaYzRWYy9CL3N6eUxFbW4vSUQzUWNCcm42QUZmVFIwWWpnb1dL?=
 =?utf-8?B?MEIvSHdlV2tIb0plUEhvNmdkY1p6Rk8vekxjWFc1ejN4ZGwzOExMckFlWXJD?=
 =?utf-8?B?cTF1QTNiQWU3cXlLRHJodHdoM2tvTkw2eWZvN0NrTE1jNno1RUFwQUJXV0hw?=
 =?utf-8?B?K2Iya0FVaHhVeVdZMHZLeEdsVzFmdGM0cUUzMlNpbmthdE5VVWIxYnpxdlYw?=
 =?utf-8?B?UXN5WHpZYzBwREs2VU9VbVV0UGg5azdRUCs0OWh6Y2oyM1YxbFpRdEJVb0Ez?=
 =?utf-8?B?OGM5RzhDZjh1YmEzNWxnUkQ3dDVlQmFPVFMzSC92K3d0WjNseU1heUFWaS82?=
 =?utf-8?B?cmYreGMrZTdPbENyVGtNWjVaRnN3aDlBWEVjbjRJRlVNN2x3ZDAzQ3ArMG8v?=
 =?utf-8?B?N1ZMUy9WZG1zeHZUWkNlUGpuODl2Mm8zcjg0ZXdTeHV1eVZyZ1VjY25pSDZn?=
 =?utf-8?B?M2lES25VR3JONVlMK0ZXSm1IeXFQZEpDRHRqTUIzazJIRy9ObG9KMDRNTHZj?=
 =?utf-8?B?QkNIYWJrOHowb2w1OVFFaldyQ1VaSjRwTmliRmRQSHNseitlNXZDemplcmhp?=
 =?utf-8?B?OThxai81aXFjcEZkV09rUkhYdHpQb1ZTMU5JbTN0TU1hZXFBVEIyT1hNcStO?=
 =?utf-8?B?OHZoaFgrWGlzeHRkN0VuRlUrMWRFaU53cURzSCtQMDQzaDVydDNsUnBJT0xu?=
 =?utf-8?B?QVl0SzZmUG8rSGhyYnZTRVIxOGtjNnJKYVd3cHRkcHpNWFdUbHU0OWZYdU5q?=
 =?utf-8?B?c1UrSHN5cjRpYkwxT3hoV3VoTzZLL0dmTkFEeFA5Nlh4M3E3UHFWZVVZUzcw?=
 =?utf-8?B?aTlNMVpERUtpc01ZbEI5VjErN1hBKzZPNm5SajN5ZmZuTGFWWElsK2JXRlY1?=
 =?utf-8?B?LzFGRDY3SmM2QVpROVlsU0pxajNQcHNpUXlWcnRWOFZERU1EbkFpVllGdkFV?=
 =?utf-8?B?SXg5dXRrdzk3dUd3UjJiUnhSdmdUeDJNYStrclBMbHFnUVNqZ1VSVG9HcGp1?=
 =?utf-8?B?dGZHSUpJaWVSYkFaZEVOR2U5RGM5aEgzU01CeDdyTUVIc1lpclV4dkNsVWVo?=
 =?utf-8?B?NFQzZlc2V1BpQWFQNFlybHVpU1JUTFc4a29YRVpUclROTzJVZW5ndmszUk5o?=
 =?utf-8?B?ZE9NeE1QRTZUOU5SbjY2NVJyV2duaWFKQUxiQlBSKzRObjFQRjBpY2U1Wk5X?=
 =?utf-8?B?a1BaaTNOeVdiRlF4OENtc3kvKzNBVloyUnpuYUFvL05yVW01Qm5rZTJzdjVO?=
 =?utf-8?B?dlpzbnc3TDlHLzdiMGhjSXdNUHcrUFNSN1E4SmZJWklJWVpxWUNwVHZpNks5?=
 =?utf-8?B?dG5RV2w1bGZPVHZmeGFMT0RYMDNsWHFFMS9ieDdPSXFuZ0l6Mmp1S2c4Zmt1?=
 =?utf-8?B?Q0RkOGU5V3VLZWd3WkZ3RUtsVEtpOTA3MTV3blF0S29VL3dsSjduZFJwL0x2?=
 =?utf-8?B?bVVyNFZYV0RrSjZoQ3IxdjAzYWg5a0ZhdTQvbnVQS0NkbTIyNSs0MllkclQ0?=
 =?utf-8?B?eWl2b2VDb1dDdnF0bzNMNm44R3NSV3BNNHAzUkp2UnZtdDZidUdsbVpob1hq?=
 =?utf-8?B?amJ2eVdxa3RXbE9uS3NpNmRPRUVqdFpVYUhBejYvTElZeU9GZUh4TzFjZ2JZ?=
 =?utf-8?B?Qko5MTF2VzBUS1B3Vi9XaEtaZjgrZHdZVytzMXJsd3NDM042bFcralhmVGZ1?=
 =?utf-8?B?Q2ZHMStXeUplQ3preXhWcXBkTGtwUUU5Um5DQSt4cFU4QnRXcUpyY0lnQzkz?=
 =?utf-8?B?bVR2WUllNE1HL2tURERBbmUzenpBS011Z21ScGpOSTVmRkxWTE9IRkpqZ2dV?=
 =?utf-8?B?ZTRnWTJ5TUsvNFFKZ000ek9kNURjTUV6L3gzMFg0M2hIRUtISStPa25mVzhw?=
 =?utf-8?B?WGpJVGJqWVBveno1K09VMmh1N2FzZms2VUpMNkQ2cDF1RThXSEd5bFR3d0F2?=
 =?utf-8?B?V2NqdFA4ZkVqb2ZDZ3pobGRIU1BTY2R3TmhtNVR4ZGdPb0dpbHpZU09yODZB?=
 =?utf-8?Q?NwIsRSXf/GxYzpe+IRy4+shuT?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d095c7cc-4930-46c8-efd2-08de23c4a14a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:27:36.1784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kG2uMe8NJJSStRLt8t7lE2epEY9qNYdKtjufqm0J+V6Z/yU3tafptL6nBEUWm+gqXJforaGu5G5wTbbs5QjVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7338
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=jan.kiszka@siemens.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

From: Jan Kiszka <jan.kiszka@siemens.com>

From the source frame, we initially need to copy out all fields after
data, thus starting from nonce on. Avoid expressing this indirectly by
pointing to the end of the data field - which also raised the attention
of Coverity (out-of-bound read /wrt data).

Reported-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Tested, not causing any regression. Please check again if Coverity is 
happy as well. Thanks!

 hw/sd/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9c86c016cc..7fdb9195e0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
 
         assert(RPMB_HASH_LEN <= sizeof(sd->data));
 
-        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame->data[RPMB_DATA_LEN],
+        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
+               (uint8_t *)frame + offsetof(RPMBDataFrame, nonce),
                RPMB_HASH_LEN - RPMB_DATA_LEN);
         offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN + sd_part_offset(sd);
         do {
-- 
2.51.0

