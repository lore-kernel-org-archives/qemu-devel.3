Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99977C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 10:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV68S-0002FZ-75; Fri, 27 Jun 2025 06:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uV68H-0002F5-OE; Fri, 27 Jun 2025 06:16:33 -0400
Received: from
 mail-germanywestcentralazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c20c::1] helo=FR6P281CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uV68F-0006gn-Cr; Fri, 27 Jun 2025 06:16:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbW8IEfKa6gGiZ8fO/HGKLjK2AW6P+asBCAgosCwT839fSCkCLTkoDOEL0Gh0zyTQQpTMcEtSwHnD+ML/ZIi3U4ysD6XqasS1Av9+AJYXYFwXzTG9+hdTq4PajBN6KOJiZUTxa7O6tWWL4/j9BbZx5Wr66VeTX7x0h02GiP0kyZIJ2FcGI09MleDZQnGhhIk1ozQzA7eDDqbxOG3dhBpaq/KGf5Ss1LmokEOlxN8kP8cBQLBqditroxeSm8n3AdICeyORfxrSzQqbgyZz6ddsZrSMI+3sIuDgYtmOdJEw1KuaKjaP2cbE8QIW+mFG3N7+k45fBOhhp381cjHkBI5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kegrzP/dYEQI36XabJhL+7W71HhMT7BFnT2XORM+Mw=;
 b=d/6Xd2WdyaI1+bBUtNJcPuGnWW5MW32FYAPfDWF8I7RBzx3MbnYxlhfQ/JV8XDUSCHbn5Ojn00MmrZ2wRaxnHtBEyHWG+04iFZncd4jXTpSA5Y8hrJD62W60gCo4MKccUYHdkxyXTOG8Lliybc6An1RhIcedQVCJ8Aqzw/lvv5awaqvBN4wKM7iBRHZgOcACvD7+d6raUUcQmgGOA5Lq+8l62mG1sbiU2GaRLpMAmcwkQa0xJUI3KP0XLEadR/au+Ahwop/5lupvpkT1Tw2nbNfq6cLttDdDnTZtju12z02H6AI0hI/VX2hj9VhcN/ewJJmmjJW2IK/F9qGdO9IZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::65f)
 by FR4P281MB4696.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 10:16:24 +0000
Received: from BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5c4:893c:2523:a442]) by BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5c4:893c:2523:a442%3]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 10:16:24 +0000
Message-ID: <8d21f5e6-9188-4abf-8f97-5da3b585a892@siewert.io>
Date: Fri, 27 Jun 2025 12:16:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Content-Language: en-GB
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <20250619085329.42125-1-tan@siewert.io>
 <c58bf387-a484-4cc3-a4b6-76cb955c6b0e@kaod.org>
 <SI2PR06MB5041A8B6109499DDAAF298E5FC7CA@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: Tan Siewert <tan@siewert.io>
In-Reply-To: <SI2PR06MB5041A8B6109499DDAAF298E5FC7CA@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::16) To BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b18::65f)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1PPF7DB70B163:EE_|FR4P281MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: ac658ef9-122e-4de0-d243-08ddb563ab97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0pqWmRRRUtSTWpCY2xIUk1qRENXSnhBeXc0Q2NoNVRQVGNpYlFVc2dObDR6?=
 =?utf-8?B?UkF2OHhqcUJFUHJIN0dtTktuZTMvSW1UOGxjVm1mUkFtT1drMnRpNC9CVEZ6?=
 =?utf-8?B?WHhjaEUzWlMvRFI0dHBNdGNSdlRzNysvUWl6TGRURjV2M1JNR1lUSWs1dHl5?=
 =?utf-8?B?Uk92R1NFM1RkeEV6V24vL2ZnVGMrazJJT3Q4QUxGS1dJMlEvbE1KVThzSTd6?=
 =?utf-8?B?RUNMaUZYa2ZDc1poWk9mS2o1V2dRY3pGS3hJay9aam5rbXZHK2NFMk1xOVhH?=
 =?utf-8?B?MjNEQWZOZ2puOVViK3BzVlZsMisyL0t3K2orQ0dLSmFLdnFuRWthV2ozRURD?=
 =?utf-8?B?MVlwRTVZQkRNVG9xNW9nRVRscUh5bFdMTVpJUTBUOUh2Z2xrMU9aSEJHbzQr?=
 =?utf-8?B?dVJHWkpFdTlad09kTWhtZGM3Vnp5MmtXZmhIM0JJcEd1TzczY0tEUnlnNXdo?=
 =?utf-8?B?QjY5bng0RE1kWGE0bUwyaHBXSmhhZkV2N1RFOFJxNzBRb0tScnJ0b2ZVZmpI?=
 =?utf-8?B?L29BaXhoWjc5YWIxUTNDWTQ1YlZUaEtvM2s1OTdOYmdHMjMzeGQ2UG5FWE0r?=
 =?utf-8?B?aVErdGhxbG5Zbm42QS9rbTAzYnVuN096ajRJUEw1cWwxZjNseXQ0M1lpaGd5?=
 =?utf-8?B?NlhiUGpVeU5lN0RXZUtiL3U4c0VFUEk4UUVhcWNIQU1sV3VmTkJZUXRITkVJ?=
 =?utf-8?B?MUtLV3ZUbHBrZGhScFN0TCtLL05yQkZpbUM5OHhPbXZGWmdJNFIzRW9oUTFH?=
 =?utf-8?B?c0s2VGRBbXRKWEduM0hlTGRRQWcwdXduNFhCdjVlS3NBK2ZucC9zVnl5NDg2?=
 =?utf-8?B?UFVpVjJmU0MrM21nVWhXWGp4cFRLTmZaamFXdkc1azVNZFNpTVhDMkhVTG9h?=
 =?utf-8?B?UGNWMEhWY05ZY0xuYlNNWTI0NEZJQ3liRUVvTGdJRFY4T0ZzNFp1aHZDVHpR?=
 =?utf-8?B?SjVab212VSsvMGp2ZVUvZVRhUWpFMHRUOUFVWVBhdGZUNC9aKzRCbmZ5M0cx?=
 =?utf-8?B?NnNGMlQzQi96OGFBYm55Q3cxb2xUZHJxODBXVVRoTk1ZU0RaUnExenlmOHE5?=
 =?utf-8?B?Sk9DYXNVd0ZPVS84dnh1M2VSa1ZwWm5TQ1p3aTJQZThJeC9XSnRUZ0VWWkJ6?=
 =?utf-8?B?WFpUMkY3UTZaNW4zRUF6TDVBUjJVUElMSi9IWi9GUzlFR3VYZHV4YXQ2SnJQ?=
 =?utf-8?B?ZWxDZ3ltb3kwUFNWaXBJd0JjQ0RianZndDgzZi9DNlBQQ1ZCUG5la1NxZis0?=
 =?utf-8?B?T1FVanR0VFAvSEp2alhOdzl0OFoxV0VKMmJiY1RXSm5LUkFjSjVJSmc0ckts?=
 =?utf-8?B?OUhoZ0t5Q1YyM05Ec3VWeHVxSkVab1VXcHZESTllV21reUljZGw5TStXNmtF?=
 =?utf-8?B?bDNBcU9vbnpoWE41NHN4UXIwYndwVFdUY2NkTW1UOTZicG9odFBMWnB6bFFC?=
 =?utf-8?B?K01LUWpubllzYXMxN1hBcjRIUGx0cTl2eXNaSVVLb1R4czNpUkxHcVcwdXBM?=
 =?utf-8?B?THgvamFaU2xRSjNMWmtxKzh2NnQ2aWIrWW5MYURjaGhveDVYa3FNWnZXdVcv?=
 =?utf-8?B?RkEwR0Z6TXp6SmRZNTdlamhHaThsTTFQbitCTjJEeDkzekV5S3pVNHhqVDdt?=
 =?utf-8?B?MEZFNVpBNzRRSFFmMWlzRFBNQlZUVFF2c2ZvZ3c1S3IyRUxSdDN0VDlYZzNx?=
 =?utf-8?B?NldvZWhXMU80bTc0dkZNZU9LYlBtYzFYOVZvQW0rMktTeWR5VDdYelNqRG5M?=
 =?utf-8?B?K1ROSDYrV3BiNDYvYlJYNVU2TzlFNWZLdXRuaVFuaWRCak5jVEk0RFVjUGt2?=
 =?utf-8?B?SVMxaUx5ZWJCem5yNlpBcURLdHIyQW9LeWRFRGtaTUZWK2lFSk5hcmJsNEg2?=
 =?utf-8?B?QnBUY0MxVlJycWcrNDRydC9CM1BwR05YMExTbmRYSG9rM0tIUExrUGlmL3Rr?=
 =?utf-8?Q?68x63eXQrvQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVRFSGlYKzkvaU9lbjhCM0Y2Q0pXaS9vTjltbEFJd1dFN2YxV1lMMXUyRFli?=
 =?utf-8?B?NEZGaVdwbStMZjF1VklJb01sa3BxbVJNSE16VVY1QXlDeUJORHRzNkFtNEla?=
 =?utf-8?B?Smd6Tkx0eDd4YWpCOFJubzZmVEgxWWlxOWNnZEFYSER4eDdEMExsd2pCd2pR?=
 =?utf-8?B?enE3UVRFYmhjR08wbVp3eWk4d2lHVExidFJVcmtiK3MvN3R0N1NnMTB0VDRu?=
 =?utf-8?B?TnU2Nm1lTk5VbGN0MjFtNkNxaDltNUpTWG9TaFdEQnlOeXV4d3BHMFVBWE5M?=
 =?utf-8?B?eElyNGNiajR2NzRld05oVVN6VUcwZTJteHFlcEJYYXpvazZ3OHNXcS93MnNk?=
 =?utf-8?B?Zll5NUhPSndLbWc5OWU1ZXVFSjZraDdHN2RGZExQQm9FQzA3NGc4ZC9FelVw?=
 =?utf-8?B?elVyanpTUDU4WGsyL1AvYUZQbm5paXVDMUZFYktDcGxvNTNodEpvYVJTZFVq?=
 =?utf-8?B?ZzV5S3U1UERjVkR2blRnaTkzMVVxNGdrUUFUMU1mMlo3Sy83b1FIbXUwVjJ0?=
 =?utf-8?B?dEE3cDJ4Zmc4S3dqK2pYT2lYNVpLU1NsUXpLN1FWdDM2Y3I5TWtZQkJVVHRG?=
 =?utf-8?B?SzdobXMyQVhUQUhsL0Uwd2EyMUdURlNLNmFJMDIrS2R2alFUTEFqdjJTMDBz?=
 =?utf-8?B?UkhTWGlKbVUzR0tDSGFtUlZTQk9hL1pndDk4M3NaZU1FZFBoajJlWjVXMTYr?=
 =?utf-8?B?MHFwMWlwSXkrbWRXYTM3clJLZHcyVFBWbDFUd2p3WG4zdjFkcUo2Nm9kS2VL?=
 =?utf-8?B?VkFnTldWMlJQQnBiMjlEVXdlTW5nbHlpdkQ4VXprWHA4Z3NIbUZXSm9kZ243?=
 =?utf-8?B?WXdrcW45cm9lK2VuRWF5YVNZOW5CUUE4V25OT2lkZXUraUtoUzErb1R2cCtz?=
 =?utf-8?B?aFA1TFZ0cjdad3B1ZTVnZXJtYVdOTmdadnBtQkYxQ3hDY3RweCtZendBWTlE?=
 =?utf-8?B?OUZObFhZOTM5S0I0aVlOOWFpU0huRHhXWVZPWi9xQ1k0aGlpU21aZGd4SHdi?=
 =?utf-8?B?VEtQTm1BSHN6MFo5dFlGL0lqZEUva280ai85VHZtUmdEMWxoRUpjWlBzcmdh?=
 =?utf-8?B?aXNmWVNud21TY1VjMkprcy9TN1lRbVZ6WTlsNzN6NCtJOGY3RzY4RW1IQVVQ?=
 =?utf-8?B?S2ZUdHE2M0FENWwzZDl5N2F4b1ZXeFMxcmZyZk9wUkhkd0pCQW42c09QRm9U?=
 =?utf-8?B?SjZRUDM1bUpyR1o2dG9uRlBIeHRydDBSN3luSWU0SzNuOTZuQ3ZkQ1k0Zkow?=
 =?utf-8?B?aHc0endQSHVDdkFncERWMG9ObERmSnJtUXQxZ3o5UTN3MGxHaVBtTGo1QlBF?=
 =?utf-8?B?eC9mUGNSWThrbzF4R2lnZkFZaGxpdTJSZTdMNXBGU25CcEJ2dy8zRXNwMlpw?=
 =?utf-8?B?TnY1eDE3aG54NDJtdy9Uby90eTFYZEt1MEUrcHNXL29CclVJbmp4d2Q2SkFC?=
 =?utf-8?B?R05lMm1DcW82VnpoZkxyMWRBVVkrdWxieGR2NS9sTVdwVmlkaGY2OWswNGRh?=
 =?utf-8?B?R0o0QU1xK25GOXZZSFpaZjdySmlyYmZlLzk3Q25PMXM1aCs3Q29LSU5wbkxx?=
 =?utf-8?B?UmRrYWt3SjVmTkFpQ3ZxaGZiblpWUkdTQlRJekJJZ1N3NkN6UU1zZTE5VVln?=
 =?utf-8?B?ck5EdDNKSXg3QkRTWSt4c2JnSUVnVWxNMDhNd0sxbmFpOGxidWFaYSt5cldX?=
 =?utf-8?B?NWRVQkFNb2tnS1RMVmxkTzVHUnVablA4WE9UNjgydEdNbVpscWI4N1RiczVa?=
 =?utf-8?B?eTZqcVhieUZrekkyYnd2bnlrbUZXL0xOYTg0OGgrQ3p1YUlNOUZkam9JR2pn?=
 =?utf-8?B?TFZjY3RiMGNUZHNaQ3RNemU2c1R6WUR3Q0lXMzhsaDN6RHVtcHptU0dGSEVm?=
 =?utf-8?B?RHVROHh3Y1FXWHUrL0M5RWd1eUZhTGJ0SmZXc3BoMHpUNjFXSHp3cTdwclor?=
 =?utf-8?B?YlNpejBNUjdROTV0bWxIdE5jSE52L1pscjdWa1VEK2dicWZEWUMrSkc3WjBv?=
 =?utf-8?B?RDlmYjFBOXVDYlNRZ29ORmdtTzJ6U2pNVjRHeEIraFN4Sk9aSFl0R2VhVFpO?=
 =?utf-8?B?b1NMdlBDVjh3MzdGL3RBZWJCSjIzVi91dHZOcGhiV01yUHl0eml3OG9PRUEy?=
 =?utf-8?Q?R6Ms=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: ac658ef9-122e-4de0-d243-08ddb563ab97
X-MS-Exchange-CrossTenant-AuthSource: BE1PPF7DB70B163.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 10:16:24.4677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfAeFm2+WzvO6l1QsddSi4c3DIWd8L3j9YfmMkoLZzjqrvBvPMCzYefENI8c1s90
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4696
Received-SPF: pass client-ip=2a01:111:f403:c20c::1;
 envelope-from=tan@siewert.io;
 helo=FR6P281CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 20.06.25 03:23, Jamin Lin wrote:
> 
>> Subject: Re: [PATCH v4] hw/misc/aspeed_scu: Handle AST2600 protection key
>> registers correctly
>>
>> Jamin,
>>
>> On 6/19/25 10:53, Tan Siewert wrote:
>>> The AST2600 SCU has two protection key registers (0x00 and 0x10) that
>>> both need to be unlocked. (Un-)locking 0x00 modifies both protection
>>> key registers, while modifying 0x10 only modifies itself.
>>>
>>> This commit updates the SCU write logic to reject writes unless both
>>> protection key registers are unlocked, matching the behaviour of real
>>> hardware.
>>>
>>> Signed-off-by: Tan Siewert <tan@siewert.io>
>>
>> Could you please resend your R-b ?
>>
>> Thanks,
>>
>> C.
>>
>>
> 
> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> Thanks-Jamin

Cédric,

Do you think this patch could be applied to aspeed-next?

Thanks,
Tan

> 
>>
>>> ---
>>> V4:
>>>     - Fix mis-understanding of or operator in lock check [Tan]
>>>     - Move SCU protection data variable outside of switch case [Cedric]
>>>     - Fix u32 -> uint32_t mistake (now bool as same result) [Cedric]
>>>
>>>    hw/misc/aspeed_scu.c | 16 ++++++++++++++--
>>>    1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c index
>>> 4930e00fed..39832cd861 100644
>>> --- a/hw/misc/aspeed_scu.c
>>> +++ b/hw/misc/aspeed_scu.c
>>> @@ -91,6 +91,7 @@
>>>    #define BMC_DEV_ID           TO_REG(0x1A4)
>>>
>>>    #define AST2600_PROT_KEY          TO_REG(0x00)
>>> +#define AST2600_PROT_KEY2         TO_REG(0x10)
>>>    #define AST2600_SILICON_REV       TO_REG(0x04)
>>>    #define AST2600_SILICON_REV2      TO_REG(0x14)
>>>    #define AST2600_SYS_RST_CTRL      TO_REG(0x40)
>>> @@ -722,6 +723,8 @@ static void aspeed_ast2600_scu_write(void *opaque,
>> hwaddr offset,
>>>        int reg = TO_REG(offset);
>>>        /* Truncate here so bitwise operations below behave as expected */
>>>        uint32_t data = data64;
>>> +    bool prot_data_state = data == ASPEED_SCU_PROT_KEY;
>>> +    bool unlocked = s->regs[AST2600_PROT_KEY] &&
>>> + s->regs[AST2600_PROT_KEY2];
>>>
>>>        if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
>>>            qemu_log_mask(LOG_GUEST_ERROR, @@ -730,15 +733,24
>> @@ static
>>> void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
>>>            return;
>>>        }
>>>
>>> -    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
>>> +    if ((reg != AST2600_PROT_KEY && reg != AST2600_PROT_KEY2) &&
>>> + !unlocked) {
>>>            qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n",
>>> __func__);
>>> +        return;
>>>        }
>>>
>>>        trace_aspeed_scu_write(offset, size, data);
>>>
>>>        switch (reg) {
>>>        case AST2600_PROT_KEY:
>>> -        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
>>> +        /*
>>> +         * Writing a value to SCU000 will modify both protection
>>> +         * registers to each protection register individually.
>>> +         */
>>> +        s->regs[AST2600_PROT_KEY] = prot_data_state;
>>> +        s->regs[AST2600_PROT_KEY2] = prot_data_state;
>>> +        return;
>>> +    case AST2600_PROT_KEY2:
>>> +        s->regs[AST2600_PROT_KEY2] = prot_data_state;
>>>            return;
>>>        case AST2600_HW_STRAP1:
>>>        case AST2600_HW_STRAP2:
> 


