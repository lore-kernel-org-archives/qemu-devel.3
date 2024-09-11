Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543F9EE0211
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soHBp-0003Li-8t; Wed, 11 Sep 2024 02:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1soHBn-0003ER-Eo; Wed, 11 Sep 2024 02:50:55 -0400
Received: from mail-co1nam11on20720.outbound.protection.outlook.com
 ([2a01:111:f403:2416::720]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1soHBk-000527-Qy; Wed, 11 Sep 2024 02:50:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EigwWN9u4FmWH9EIoX45dbgomoJ3eCur11KoWvN1DJV1jpAzG/j/zqgN830cmvTIcE9uKBBBWPvnKiBo1UBuFn70IAQCRJTNAbHGdtsy7wowB0P+R7MVfIXBSo2uuDG6m7Q5O7ksIjAY03UAvXOXroSdUzBJ3oVOuaIYwJNE+FOPnkzx/k7WwbSHlO4XAsKUCixsgPAPmfhuSYkK4DiF2r4Nn3SHquj5+DBwe0g/80FZbcqdWwNG0CRknq1yDGruX6UTXNSVcBRpwcyQnhPvIx/0aWzcwI4yFwYh3SR+zNzHoyydyHgaSBY7aNv9rT1uREedLKP+2CJaksE1zXu6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQjlN5lxUX+70cc2mwbxKr4rNlBLD41YnwPTuOM8PMc=;
 b=wMSIqJVutd7hadoW1loIIlwspwFIte8iJx34T80U9bAv1DMKOrd8fDXHK/eNg+35j49TA061MfvuF9ifZ3GG5NU4/1G1PdN8QPCsyCMGCWcs0tWnhMF7BBDo4WBtsxhcusg0i5h/O8drKnx3GSsa9GqPHyvQb+Aewbpp537DfXP5uCkZquWA6uveArWWEVeZ04eoFhDP3eAci1FocpSl5gsgbrKxEBbyur5PAqGXvP1waYmib5QmTl5FBarEp5DAXQJ+SwZr5+UnJE8i0A5/O7oatNkHnh2hZMW3nI81ufz0AEDkSVL9gXWPKrxYnsomHwSYPK0QTdgwV3CMCd2B2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQjlN5lxUX+70cc2mwbxKr4rNlBLD41YnwPTuOM8PMc=;
 b=gVizQJJYmyJhyg+DqSV421C9kfI9bzTGyDLVEPvnWnf6xphIpC7JlC3sOUvmH76T/OyM3asyG0wPfFu+zZrk9MdJwnpfgGqM4MSB8yzHhrUNw9TuGJSlXwFPBNPjqwYjQ4j5GeFgPQhKR9cc5+COiwERgJnySMR1SuprTsE6ncI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SN7PR01MB8116.prod.exchangelabs.com (2603:10b6:806:357::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Wed, 11 Sep 2024 06:50:46 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:50:46 +0000
Message-ID: <db36a703-1330-44dc-a80f-57903fbb305f@os.amperecomputing.com>
Date: Wed, 11 Sep 2024 12:20:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/kvm: add support for MTE
To: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, darren@os.amperecomputing.com
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
 <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
 <0b5764d4-fd63-4779-a22a-8e10ebafbcc7@os.amperecomputing.com>
 <CAFEAcA9oP5HNYK=HFazBU8M9eaGN8sFhAvLFQvcy36Xf+Tm+7A@mail.gmail.com>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <CAFEAcA9oP5HNYK=HFazBU8M9eaGN8sFhAvLFQvcy36Xf+Tm+7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::7) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SN7PR01MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb4a30d-3db1-45e2-cce2-08dcd22e0ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmRUVnhrdG11T3owWXNJaGM0UzJwM1dzRFFTcGpzRGZBOHRMUzlvT1g0Q2Rh?=
 =?utf-8?B?N045Z0dlTGFuUnR1ZWtKYjVZU0l1TTc0ZHRtcDViNGEwMVZRNGRIN1U5N2Jp?=
 =?utf-8?B?VTN3N28yNTV0QnVkUFF6YS9BbWVnQlhZVWdGTTdGc21GejFNTHhyRHphclRS?=
 =?utf-8?B?REJmOWJkTjV3SC9tdUh2eEx6eFFhTzZCNzUreHlGOWxFMFJVa0FWd0Q5cmVl?=
 =?utf-8?B?NVVXczJrK25NQkNuTXpROENtK0JCQlhRWjV3NnA1ei80ckJlWjlCTGNjL3pG?=
 =?utf-8?B?T2k4YkJqdnRUU011VHU0ZHlVU1BGN09INnlVM0VZSUF5OE5Dc20xTy9DSG5G?=
 =?utf-8?B?c1c5c2NpZlFZSFZBV3NuUzgwRldoTGw5TStZM3Z4Y2I1MmdxQUpLWVlBMGM1?=
 =?utf-8?B?ZFczcXBML0pSeUpDdGI4QVNvVHhRV2RvVkY0dUNyRFBOZlE0bUJGMzF3eGlE?=
 =?utf-8?B?bncySERvVHhBcEZqdU1GRDRPa01sMEZMSmZjVUFTYnRDb3NGejZ5KzhRUkVo?=
 =?utf-8?B?UXZFVkpRejk4eVRXVmRsQW84NnNtNi90ODM2clVZRTZZbXlDVFZqMFZDNkN6?=
 =?utf-8?B?SGZOKy8rOWIxR3U4T3c1OHBQUkZncnZMbmZ1NEZCMjRZa1kxMUJSdlcramxI?=
 =?utf-8?B?bCtUUERzWDkzcGNINFV4OFlhU2swb3hIQTNIQk1rUTl2eWYrNmIrNUtxYUky?=
 =?utf-8?B?bDJGaVJFdWNIL1VNMitYMnVNNE9wRkluWkRhWXhucmRQVkpYZ1lNL1MyZGQ0?=
 =?utf-8?B?QUxIUjBBTEJ3MWtjMEFDYnIyVytMTGFYc1JldC9KVXltMHRDWXM4d3NXMGRm?=
 =?utf-8?B?Ni9jK096RjBwU1hSWVZ5eEZ1Vy8yY3pvV3FkNmZiUWxCbmRSRHJaUmxvbnhv?=
 =?utf-8?B?cjVqYmFBUWVPT2MwSi84L0NuY0gwR0o4SDlsYkhNQ1lRWnhTSTFLQ2tmTktO?=
 =?utf-8?B?bnFRZDdqTEZXRGpqa3VTeCt1cC95RWpnbmVTTkxidjJYODdVV0NYMXdyczNT?=
 =?utf-8?B?WlBwSE9hUDZkalczeGFITmNZN1J1c0JRUVVJcDZ3T2VSMklZR1gzVjNHaXJO?=
 =?utf-8?B?QWY4QjdoMVdtY29OdEp4RFhxMVE2eWZHWmFmTEFXVVJXNVl6dHdCbS9jRHZM?=
 =?utf-8?B?TFJBMHFjc0ZzOTY2blJOdzVCRGgwT0VZZ1lGc3M4OVBGYWxNSVdtZ1RGa1hD?=
 =?utf-8?B?M0lTVTd1NEIzR2Rjb1g5b1ovdHZWK0dDUmtVaFJHNEtLOWloRDUvbXRWUXNI?=
 =?utf-8?B?Tm96cyt3T1lKYU43TnV6aTArajFVYnV2YzhCN2VUVFB3Z0wvYTBES1d1aERi?=
 =?utf-8?B?S2RKLzFRT1VGaFFWTEw4Zms4NHVHeDhmT1FFT3dzWlJxTHBPWG1Ld0I5cG9y?=
 =?utf-8?B?UzRxNVJPdzNzT01iNzdQd1pYV21sTkFhVG85SlNaYlhhNFc4UDFiWXlteG5V?=
 =?utf-8?B?NGc4bTVkWWFtSG1nYlVjTCtJakpxajVlTUV3OGJKQnRVYjRWemltbEdTeDhx?=
 =?utf-8?B?MzBJRmRYbDluR01iTmdYSElkYVdkbngxZkVuQi9DTXRqU0IvSHFtL2FKbWk2?=
 =?utf-8?B?SVcyM1JydktXVDBUQ1NBNm8zQ1g5UlphWWFDbENmZjNBaThMOXBQaDE2Z3I5?=
 =?utf-8?B?QjNpMWZXd1FLVEVUa3RUbnkzSDc3bGFSSWRSVE1wZlVDTS9SdjAveGwwazIx?=
 =?utf-8?B?bU42Tlkya0tRaS9LYlVzdHVWMy9ydHVaTDNUTzdJajFhaWhDbFF3L2ZjUVZk?=
 =?utf-8?Q?yFUbIP4X5q+D4KZ5Bo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzJlL2N2NndoUU93STFpK1FmaTJEVGJFeE50VjI0QURrUFZ3NXU3Vng0Y0dE?=
 =?utf-8?B?VWpiTEw5ZW5yVUdsZlE5aUM3VUdwVGFJemRKKzdFV01GdXM0dVdUUTMxK0dF?=
 =?utf-8?B?cW5vc0V0Z3ZEbGkrWnNvQ21qejdPQVU1MDNlTGhVczBkYjNPTmRuU0NqQUZ6?=
 =?utf-8?B?ekpCNUNMUHBhcS9iRmEraE1Cc1JkREkrQXBsc0dlMlc4QjlmVWNFUWN0REJ6?=
 =?utf-8?B?aElwVGhFajNVelo3bHFZUS9laUJlTXNNZCticEJRYVFIU0lmbnZ0V09LZ2pV?=
 =?utf-8?B?Q01NSzRmNXdSYXBsc2xpV002YlpCYlViTkVFbm5JZXFFSnExanpOaWs5YzBz?=
 =?utf-8?B?YUlDK08rdUZPTzhGM2JIVDhaSnFpdngvSE5lc1gvZmE3K2FSdWwvV0s5ZE5m?=
 =?utf-8?B?KzF2M0F6ZEp3ZEFCRGUxSGVCQVVhWlBjOTYzQjdERGdzM2FTVEllbFppWVBN?=
 =?utf-8?B?OUkzZ2NjTmZOZFhrTE91dXhvYkpTL2huMFJwdWpHUWNKNzJTMFJYejRRVnlQ?=
 =?utf-8?B?d21qRTc1R2IrN3pwd1g5TmN3Z2xFaUxVYm41ck1naXM5czJycFNReklDQjBs?=
 =?utf-8?B?U0haN3NyTjdCZmhlWC9FWk02WkNuNFc1SGVKNHJNUVRHLzBHSXN6ZVBrUzBy?=
 =?utf-8?B?SG9yR2dmNWtHVldPOTNPMGhVK3NTcE1xWE1RWHpLVVBtTmduUW9NdnhaUEhL?=
 =?utf-8?B?aXBRQ0t4VmtFS2srNDIvbkV3NSsyS3RWV1M2TWFUM2lpcGkyN0NmWTd6L0NO?=
 =?utf-8?B?YnREcnZDa1h2cm01UWgzQkJ3aVpjM0tzamRkeDdqS05OSlFuU3poL0FhbU42?=
 =?utf-8?B?RkxUeVcrU295VUhWc2UvLzVqWUduTnhQcGduZ0FQdXdxU3l6UXBRTnByb0lQ?=
 =?utf-8?B?ZStuNmdaNE82SlFiOWtrRFNEWHAxY1kzbTBzSmZhSWtuSVFpL1lmdjZodmpk?=
 =?utf-8?B?bUlJeld4N05oaGtKUG5FMU1aQ2tkUmVHMkJWUVpkekNnU0gxZ0lvM2hzYk1F?=
 =?utf-8?B?Y2dHV05LM1JNdHBUQnlDWWcxRmF6U05KUU4vc3VmUlhzRmxWTmxHRXBoM2hI?=
 =?utf-8?B?RDJOWENtQlBrdEUwMkFmRUYrZ1p1M2JYU2VYb1lZSzF6N3lXU243UnBmV2dC?=
 =?utf-8?B?NjcrbndPWEdlWE5KaEQyN3pNVGRWSTQwR080T1VJYVkwN3BCRmFqQnY3aUEz?=
 =?utf-8?B?OTlwMmRWN3lUU1B4ckdmL3ZOakZmTFN2eE54UmV1RS8zV0luTi9jajU1RkQ2?=
 =?utf-8?B?SjV0eFVmOGdaU2U0bWl1YWs3QTlONDR2VElJRUw2K1FNN1oxcFpKREpZYUNQ?=
 =?utf-8?B?SlFsbUxKYytNTTJpcXMxanFvY2w5aFR0OXh2OXUxalFxK01XZ1BOY3ZsR2tL?=
 =?utf-8?B?clNjSUxxdlR2eFBJUHgwNFpDNzZPK3FJQVEweUlUdTYvNmxxbkpBV2tLSmQw?=
 =?utf-8?B?Mlpkd0hpUjVzUHdMTER3U0FKREhoRVgvSjVPdnlQOFhQNWpqd21IU2NLT2l4?=
 =?utf-8?B?dW5zQ3BxYms4UG9mNjN1UFdHOVRPOGkvMGVrUjRjZGViZXhHNEx0R1RwZ04x?=
 =?utf-8?B?NlRaaGJQYnJLY2t5Y2UzaUNtRkZ0RUY1M1JKRVkrd1NwVTBoU0FVd3A5MVNs?=
 =?utf-8?B?WDVyWk5IMmFPbmZQR3ZiTUhnMkVhNkl4SFpJNXAwMmhtZmR4eHM5dGVUN3hO?=
 =?utf-8?B?K1ZFRGpUdCtzb2NPSEUwRWdjTlBhcHlHR3czbnIvb2JWb0xJbkZKQlNaSG11?=
 =?utf-8?B?YXM5T0FXamFxek1FSHV4WEJpdG1IYXBrQzlnMmNZaUFwajIyOFdEU01nOFk2?=
 =?utf-8?B?NEczSlRBL1hGSUFZVmlYSzJmTmRmbVdRMmRRd1NSVEdiT1BsZ2Zsc082eXM3?=
 =?utf-8?B?MVJmdW5jR1RGbERuNXI2MThQM0tzWmU3bUErUElVK0dMY3o5VG01OE9kclRa?=
 =?utf-8?B?YmdUQ2xZdlFIVndCcE5yU3R1NXptc1hrMUltQm1lSGgwZUh3WVBtTHZyWmE5?=
 =?utf-8?B?eHhKNFhWeW10MG1iS0xiOWx6K1hNbG9Sb0xodEhTZnhlM3pqWjR6cVFMZTAx?=
 =?utf-8?B?UVgvZWpOanhwZVAvaUdKNHo5WlVPT1JQbkJtQVljVFdOejFWYWNDRmlLTTFj?=
 =?utf-8?B?ZVV4SVpKMWJRb0h4QUxuY0Q5S1FBbEtKelFCd3YzSElsc2g1SXpMVktPb1lV?=
 =?utf-8?Q?LcjexE7vHEpSfWDDSUswBtI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb4a30d-3db1-45e2-cce2-08dcd22e0ff1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 06:50:46.0709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KB7mTZI26F73XoPCPdW3wxm+yJK0NOmj9tcNSl9Oeig3wIAVgSBgO2OiyrbAytuVkoxNwMW0g2G71W7M3dHKFPHhrBXyNJajsMQvvvyEwXTEpx1hD0vLt7fQfwI8y3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8116
Received-SPF: pass client-ip=2a01:111:f403:2416::720;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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



On 10-09-2024 05:53 pm, Peter Maydell wrote:
> On Tue, 10 Sept 2024 at 12:57, Ganapatrao Kulkarni
> <gankulkarni@os.amperecomputing.com> wrote:
>> On 16-07-2024 09:15 pm, Peter Maydell wrote:
>>> Since Cornelia first wrote the patch this is based on, we've
>>> landed gdbstub support for MTE (so gdb can find out which
>>> addresses in the memory map have tags and read and write
>>> those tags). So I think the KVM MTE support now also needs to
>>> handle that. (See aarch64_cpu_register_gdb_commands() in
>>> target/arm/gdbstub64.c.)
>>
>> I looked at this code and it looks like, complete code is under
>> ifdef CONFIG_USER_ONLY and for kvm(target aarch64-softmmu) this is not
>> getting enabled. Are you asking to remove these ifdef and make
>> mte-gdbstub commands available for the KVM mode as well?
> 
> The system mode support for mte gdbstub is just about
> to land. The current patchset is this one:
> https://patchew.org/QEMU/20240906143316.657436-1-gustavo.romero@linaro.org/
> 

Thanks.
I applied these patches to qemu and compiled gdb as said in the 
cover-letter. Below is the log of the run, help me to interpret the logs.

[root@sut01sys-r214 mte-qemu]# make -C build -j 32 
run-tcg-tests-aarch64-softmmu
make: Entering directory '/home/ganapat/upstream/mte-qemu/build'
   BUILD   aarch64-softmmu guest-tests
   RUN     aarch64-softmmu guest-tests
   TEST    mte on aarch64
   TEST    hello on aarch64
   TEST    interrupt on aarch64
   TEST    memory on aarch64
   TEST    memory-sve on aarch64
   TEST    hello-with-libbb.so on aarch64
   TEST    interrupt-with-libbb.so on aarch64
   TEST    memory-with-libbb.so on aarch64
   TEST    hello-with-libempty.so on aarch64
   TEST    interrupt-with-libempty.so on aarch64
   TEST    memory-with-libempty.so on aarch64
   TEST    interrupt-with-libinline.so on aarch64
   TEST    hello-with-libinline.so on aarch64
   TEST    memory-with-libinline.so on aarch64
   TEST    hello-with-libinsn.so on aarch64
   TEST    memory-with-libinsn.so on aarch64
   TEST    interrupt-with-libinsn.so on aarch64
   TEST    hello-with-libmem.so on aarch64
   TEST    interrupt-with-libmem.so on aarch64
   TEST    hello-with-libsyscall.so on aarch64
   TEST    memory-with-libmem.so on aarch64
   TEST    interrupt-with-libsyscall.so on aarch64
   TEST    softmmu gdbstub support on aarch64
   TEST    memory-with-libsyscall.so on aarch64
   TEST    softmmu gdbstub support on aarch64
   TEST    softmmu gdbstub untimely packets on aarch64
   TEST    softmmu gdbstub support on aarch64
   TEST    gdbstub MTE support on aarch64
   TEST    memory-record on aarch64
qemu-system-aarch64: -gdb 
unix:path=/tmp/tmp80lbp057qemu-gdbstub/gdbstub.socket,server=on: info: 
QEMU waiting for connection on: 
disconnected:unix:/tmp/tmp80lbp057qemu-gdbstub/gdbstub.socket,server=on
qemu-system-aarch64: -gdb 
unix:path=/tmp/tmp8h7kx8kyqemu-gdbstub/gdbstub.socket,server=on: info: 
QEMU waiting for connection on: 
disconnected:unix:/tmp/tmp8h7kx8kyqemu-gdbstub/gdbstub.socket,server=on
qemu-system-aarch64: -gdb 
unix:path=/tmp/tmpo0448vk6qemu-gdbstub/gdbstub.socket,server=on: info: 
QEMU waiting for connection on: 
disconnected:unix:/tmp/tmpo0448vk6qemu-gdbstub/gdbstub.socket,server=on
qemu-system-aarch64: -gdb 
unix:path=/tmp/tmplvwd79e3qemu-gdbstub/gdbstub.socket,server=on: info: 
QEMU waiting for connection on: 
disconnected:unix:/tmp/tmplvwd79e3qemu-gdbstub/gdbstub.socket,server=on
qemu-system-aarch64: -gdb 
unix:path=/tmp/tmpv1t2ffjfqemu-gdbstub/gdbstub.socket,server=on: info: 
QEMU waiting for connection on: 
disconnected:unix:/tmp/tmpv1t2ffjfqemu-gdbstub/gdbstub.socket,server=on
   TEST    memory-replay on aarch64
qemu-system-aarch64: QEMU: Terminated via GDBstub
qemu-system-aarch64: QEMU: Terminated via GDBstub
   GREP    file untimely-packet.gdb.err
qemu-system-aarch64: QEMU: Terminated via GDBstub
qemu-system-aarch64: QEMU: Terminated via GDBstub
make: Leaving directory '/home/ganapat/upstream/mte-qemu/build'
[root@sut01sys-r214 mte-qemu]#

Last few lines of untimely-packet.gdb.err below:

  [remote] Packet received: 
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 
[24 bytes omitted]
   [remote] Sending packet: $qfThreadInfo#bb
   [remote] Received Ack
   [remote] Packet received: mp01.01
   [remote] Sending packet: $qsThreadInfo#c8
   [remote] Received Ack
   [remote] Packet received: l
   [remote] Sending packet: $p56#db
   [remote] Received Ack
   [remote] Packet received: 000000000000ffff
   [remote] packet_ok: Packet p (fetch-register) is supported
   [remote] Sending packet: $p57#dc
   [remote] Received Ack
   [remote] Packet received: 000000000000ffff
   [remote] Sending packet: $m400027b0,4#8c
   [remote] Received Ack
   [remote] Packet received: 80c2ff10
   [remote] Sending packet: $m400027ac,4#be
   [remote] Received Ack
   [remote] Packet received: 1f2003d5
   [remote] Sending packet: $m400027b0,4#8c
   [remote] Received Ack
   [remote] Packet received: 80c2ff10
   [remote] Sending packet: $qSymbol::#5b
   [remote] Received Ack
   [remote] Packet received:
   [remote] packet_ok: Packet qSymbol (symbol-lookup) is NOT supported
[remote] start_remote_1: exit
[remote] Sending packet: $D;1#b0
[remote] Received Ack
[remote] Packet received: OK


-- 
Thanks,
Ganapat/GK

