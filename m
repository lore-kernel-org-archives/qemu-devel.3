Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD81C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 06:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq5EH-00077D-K4; Mon, 16 Sep 2024 02:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sq5EE-000745-Cs; Mon, 16 Sep 2024 02:28:54 -0400
Received: from mail-am7eur03on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260e::701]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sq5EC-0005dJ-9t; Mon, 16 Sep 2024 02:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RATiNHxa+16lRkiGSzeM2blnuiWYO+OA75e9YXCAtP3//ETEehew8MGrmkg/x/msQ9uGRyd9CFRuBQNL47x9nFMj4tBt6A1tPhIZ7tgHYGt8HyWWTOFyxMGF1SBoYlfw1Kx7+6aPkeAnZYGZS9fEwvZvL5PHO2ukPIRgJnjyHslsGDrUHaXFlZ+7zNtudh7gY5UO5N8+W7egFzzhlVRzpDlZ1nBQQt+bRy+0kFvjyT0RPvqvYU0cBYraoXzXLORXfervNZk3amY1Xax1jj5v0bwYI7XE9P7U8JIot1gRZPcmOAnyAAS4RsvQCJYBotEgVkamHOQLxHd9C5sVBYg54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dks62wTOY+HQOg1pK5FkE1WlIfSBcHTFxKY6C2sTaCU=;
 b=Z0AlizGfcNiWWv35Ib3XQSX9dVWd+5iwdHFfVImIP6RvUaL9I/7vJxGcGueFuTIOlPd17RDOypfDONiIV1XOLFlPGOvColN+y7Z7uM8D/Fkcyv81y6GixzGDQMSRJbmNOuorxTa3TMnNdJf3v21wa8KEzTDRzaILIUnLsadF2crkfIUQa5Rbwh1a0bbknwEimxOZDCgAj1AhBKl9RiC6l6wOH9/QJ1Y0yD4QBtF/1/TM0HAXxNGeg97FFArU/sPTQzDT5qR5otoJodJ8Z/5HEugx3n3is3JlZBhRGbGntCmCR2awxuT/WYFDwOZwxBxVuR1DnyTdarTReN6aMy0XfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dks62wTOY+HQOg1pK5FkE1WlIfSBcHTFxKY6C2sTaCU=;
 b=vIvdA9KCdNScUrPcdKS4KTx7RAQjHePmH2Le+vvx7s4FHL7yvQbzJXr/LKCVKd1CD1kldLuZ36Am4+6PPJHJuDpyukBwygoREkCXtBYqcAiISDIeD4i/VGK/B4JNONWEO1k0Y6FUQGE1pgurafXNt5TgWfmPIkxGyKJUgbSghXQ4hJIO8Zwed4nVd347CW3Q96Mrz9Zxgn6ykv/qulhPoOGi9DLcHzOjpXBiYWKbbXe8dZFJ9WTwArLGUf0fh1EfaclCaobPELFA9u4kdIH3C+/SEgaH5aQKXJ7cOe5vCdjJULhDowWqLpKj06qvWcerrLPUEaJe0mlkYLrDUQGysQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VE1PR08MB5679.eurprd08.prod.outlook.com
 (2603:10a6:800:1a8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Mon, 16 Sep
 2024 06:28:35 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%4]) with mapi id 15.20.7982.011; Mon, 16 Sep 2024
 06:28:35 +0000
Message-ID: <e325d4cc-1b63-4991-ae78-621c4a8ab36f@virtuozzo.com>
Date: Mon, 16 Sep 2024 09:29:28 +0300
User-Agent: Mozilla Thunderbird
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH v3 12/12] qcow2: add discard-subclusters option
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com, den@virtuozzo.com
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
 <20240913163942.423050-13-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <20240913163942.423050-13-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0154.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::38) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VE1PR08MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b02540-166c-46e1-fad1-08dcd618cabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dThQZFFiRHllNHBSMzE4VGlsTmRQTzdCR2xhT05hNngrYXJVWkQrSUlCczBU?=
 =?utf-8?B?R1djV2NyeEQ1QWRqMkhLejJ1OHNuN3FzYTZQVGVlOVVza21sRXY4U05UNVdB?=
 =?utf-8?B?bGpTaEVEWHI5a0ZzR21STVg5N1UwQ2FSRGd0TXp0OEsySS90RzN2VzFKdUlO?=
 =?utf-8?B?dTFUeERVWThEQkJtQXFBMGdWanVOYzl3Y1NzZ0Z2UGpHRFNtaUhKUVo2ZHlC?=
 =?utf-8?B?ZE1ORU11UVBMSFdvQ0RHdXI0RnRXQW5vTDBaQVdDVXRuTnZvb0xIUldac2FK?=
 =?utf-8?B?RHBndWZWL2VqcHFwSGVwQTJlajdkYVFBYzIxNEQ0Uk4vT2tnQVBKdjVIeEI2?=
 =?utf-8?B?dlVSNHV2bEZhdWVGY09Cdk9kMWJnMWJDV0Zta0RvaUJEcXVlSzFZUHBLNFlM?=
 =?utf-8?B?WmxUbEhRWXhqcXVTM1lHcW9FeWUxWWRjQjNBNC9nbVVyakhHblFNQkdhZUYy?=
 =?utf-8?B?RlJEZXNzblNYdEVweXpLTTAxVGxhQWpRcGptamFTdEZNMzRKZDN1ZUV0UGUz?=
 =?utf-8?B?VDUxRldSc2hiKzM3Zzd5YndvQ2x4cmFGSXhhL0duTnJyOXg1TlorVUQvekJN?=
 =?utf-8?B?dTZPK0orZGdxOHp3TWpjSEozZVJrQWJVZTZQR3VyTnNjc0ZwV1htWUZ1K1ha?=
 =?utf-8?B?WGtpQW4vSG5hWmtyVy9kelNFL1lJOE1CUEFabVNCMkVOMndrSXZOTHB4VjBE?=
 =?utf-8?B?M2N3UG1HMEdSREZ3ayt1VTlncWpoWUR3TEdtWXVJa3UwOUUyd0xhSkVOa2Y0?=
 =?utf-8?B?ZTVMVit2b1dEeE4rRmhlQzRGamN0bWdqdjdxcEcvRHB2UmlqMmZFWjFiV2Rn?=
 =?utf-8?B?WE10TTJzWXRMV0wrSzB5OU1USzdlSjlFL2hiSXEzamh1UGNaQ1pQNElYSVp0?=
 =?utf-8?B?MDNDanREZFJTNnY4ZWU3YjltTjVwSThRZ0pSNmUyRm5QSjRIbkRtcWNMVUly?=
 =?utf-8?B?Um90Uk9jM08xTjBWcVI3REdoWGNjOEVBb0NvSVhDdm56ais1QlJ0MzJpS29K?=
 =?utf-8?B?cVM1NDdNZlZWRjE2VnRoTkJyaExteVR3N2VwaWhzeWQyTnlaUWs3ZW1KT3gv?=
 =?utf-8?B?RTlyNWhIRHYwWTVKU01CWmNFRmcxVGJqZzE0bWltMzVOQnRlRXpreURqZ3VF?=
 =?utf-8?B?ZTRDRElnaTFLeHFLNkZpNTlLRHNJZllybUg5aDBNdEEvQ2gzcWwzL2xmQXVy?=
 =?utf-8?B?ZUkyeFRFd29JUkJzVHVLNGRkbXFtZVY4SzJtZitUaTZjYTg5aW5wYlZ3S2Z4?=
 =?utf-8?B?UGdMeTltQkJGd0RMcnRzNTZGTGtRL014ZUplZzQrWitiSE1oQmg5eTJSRHky?=
 =?utf-8?B?THVzY2J6UGtkalpLQ05WQ2FSZGlaRmdQTUlHSXAwNUtnWk1jeFJMRzlhMXNK?=
 =?utf-8?B?aGNXbVJIK0xzNTVoeUNQUzhOaFBmYTE0WTk2dW1Pa3Q4Tk1jdWNSbUtnOFVC?=
 =?utf-8?B?UnZZNFBnUjM5d1NsUURFcnlUWW9JZEt6M1AyVm41c3hSRnBiWDhoQUhTVFVU?=
 =?utf-8?B?WGZ1ZjBQZmpaQkY5bkI2RE1CeWZiVG5SQzBKWGtzK1doUkdhRm5JVE5FYjNv?=
 =?utf-8?B?THJoVjkwNnZWdGZtK2EzSmp6bml6V3hMTVdwWUxwWmtMV2hJZ1JsbVZmZU5N?=
 =?utf-8?B?ZjJVK3dEamhiT1dORll2VkN2dmsvcUxMRnJkSVRKcFU3cWV5L0Z2ay84VGwv?=
 =?utf-8?B?RVA1UmhBV1B5dllaMUhBZ1FJdHZwZ3pyOXdhQlN2b1JaUzBLbHRTUzZwTk44?=
 =?utf-8?B?TWZNMEoyK3hLQXYyZ3R2OFZCL1dudFplWXZ1MWZwa2pTanMzc2ZRUnYxWE5C?=
 =?utf-8?B?Rkljb3dMQUpIeTdvTFNBdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y20xOHZ2Mk93Q0E5NEpZYmc1MWNRSm0wOUk3ajZrTzFlMkRyS1RwcEl5OXJH?=
 =?utf-8?B?WVhLTUpGbFdzTGpZNDQrYS90ekM1K2d0bEZxbXAwd1pGR0RmQ0lNZ0ZBU1ZS?=
 =?utf-8?B?SDlkWTQwK0s5QklyM1l0ZGlBaHI3TjhQZzcyT1B3eU1SUzhtcG1yQUlzMDRo?=
 =?utf-8?B?aFdrS0F6aTh4aGRxUFV3ZUswaldMWEVaRXl5aG4yMG9hWU03YVFCTm5ZSmsz?=
 =?utf-8?B?eld0cnVFMnRXaFdxK3lQZmJsLzZkQjl4aGlpTlBQM2xJTC9jSCtLTXkwcDdy?=
 =?utf-8?B?UHZnMVRKbVJkY1NNYWxRVjRTMjNTbStKMXBPajhjU2lScS9WUUhMUVBUNUU1?=
 =?utf-8?B?Sm9IcDNTbFF4dzczV0lIL3VDSHdwTlFuVmt0T1pRWGw4YThoYWxVS2Z3L3Y5?=
 =?utf-8?B?NzJiQ042Y21KSmRQT0dMdStxUnk2eW8zUzNLcE16QW9PNjFMUC9NM215aVBX?=
 =?utf-8?B?Zm1PcHZSUWFLNjh3eU5UYUlucnoxaysyeUwxd3kzWlBlazNWZkVXdHdrK3N6?=
 =?utf-8?B?SVRST3hPNDh5N0IwRHJ5SGlWd3p3YXNLcE1KYjNxZXZRbnVQcWdmWWJPUEpo?=
 =?utf-8?B?S0FiMUZ5MlNNMzMrRXR5dzVoNFZoZjNESWMvNWJKWFR0WFhKN2JFLzZxVTE4?=
 =?utf-8?B?SXh3MWdEbExjdnFIWnFraGkxb0RrOGRqT3p2U256MXVnV3FMV2oyVHZrdU1q?=
 =?utf-8?B?TURNTHpEd09pWktkQmh4RHVyT2QzQ3JNU2hGY1pBSkRvKzNlaTZ4VS81K1JZ?=
 =?utf-8?B?c29pcVN2Y3ZaT1VsRUVjajVMQXlvTjJXZHNrSGVtQkZIcWtRcnFRRmx3cjdM?=
 =?utf-8?B?Zno0RkVGbm42U0ZmTDd6dDhKYUp0cHB5NUljU3ZRd3NKMURMMHNBamZLZ2Z1?=
 =?utf-8?B?UFpyWEV0QzdpalloN2NaT0RTNC9QdXNRb01xN2Nzb2xVZlR1TVhqczRRWWlE?=
 =?utf-8?B?ejlsRkNvRlNjd0VYVTFUWlBsOTlWKzVBUHpiOVY2NEttd1B3bzJoV2NjTWNO?=
 =?utf-8?B?RC9iVzhaMHFyWXBvRndEWDM0bTZMdHNtWVl6RHVjUFJnaTFPT2VJTXdDN2FG?=
 =?utf-8?B?RTZXOTVHdlltUGsvTEcwemo1ai96ZmtkV2dwMUduNEFwMStmYU5jazhuZThJ?=
 =?utf-8?B?Z2d4Y2FpRXZzS1NLeFlBVEhtK3diSWJHbGQ5encrcWlVMFRRSG9PQldra0Jj?=
 =?utf-8?B?K0ZWb0RyNWVnQ0JVZGt5dndHd0pmT0pTYlAxMldNRkhKcVpiOUxCVFRhQUNr?=
 =?utf-8?B?akJPdUJ2elFJUnpKSXhSQ0QyNUdueUhka3FmWU9ob3RQMGdWWU9jMVFCNzRs?=
 =?utf-8?B?ZXU2dFptL1dYckdER3NXQ2xSc1JFVXRqa1dZMGhRckhMUzJ5V2dLOU5UNUhP?=
 =?utf-8?B?Nkgxb2VWOGtoeTZIUTJDc09Yczk1blovaG5TZVdESWdxQkwxYWQyUkF2dEJv?=
 =?utf-8?B?dTc3dHNTaEkvUGw0b3VnTzVLcm9ZcFNTaWFxVGFENE0vYXNiRExhN1dPb0Rk?=
 =?utf-8?B?M21zV1RWY0lwZUs4YnZkTHg1RXFwZC9oSWI4OFIrVEwvZkpZQkVMNExxbk9y?=
 =?utf-8?B?ZENyL2lZeTl2TUZheE9VODkvMkNLWW9NQzU3Z01YRmZHZ01PS3YrODZXZ3lW?=
 =?utf-8?B?eEd1bHh1NVdWdkI5bEZJWmxVUkZxdWFOaUJZTTkvTWhwRjVGRDFBa3N2K25Z?=
 =?utf-8?B?U3NyNVlaekZEd1FEemFMMUZXeXZoanlYSW5JUWJ2NFpPcEcxczJOdkJoa0Q5?=
 =?utf-8?B?d0ZGYmU0VlF4WWptSW5JM3pBYnhXSStaUTNieHR1VTVDQmpVbHU5VXNKdkNM?=
 =?utf-8?B?cWVoK1VQcG9IdWF1dUE5eUFKcGtCZ1hYU3VTYlNpZTVMTTNveFFRQWJxMGVQ?=
 =?utf-8?B?Nm1qOHJaZ25aT0ZwSGFQZE56TUhNaGw5RE92OVdZVDJidVFTZTR2bUN6ZWto?=
 =?utf-8?B?aVkzT2tKMkpEM2lvQkhjb0plMUdaTjIvK1lBUTFLcmE3NEdkbDUwa0FzazRl?=
 =?utf-8?B?VGlNRmdoUzBBL05rbGlzaXcveWp3VEZnQWRNUDlMTHFiQ1MxYWYxcHBpci9U?=
 =?utf-8?B?cXREYVZrL0p6dEJHYmV0N2ZlQlBnYWZOQS9SQTdpekd3YTZmZXQ5YWRGM1hP?=
 =?utf-8?B?azJ1d0tGVW9FRGRMRTY5Ry9Dd0dlWE1LSTlmdW4wckFhK3MrcVN4NzdxVzkx?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b02540-166c-46e1-fad1-08dcd618cabe
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 06:28:35.0392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1FejAdRMWcMadigK2Eb4m2PyAwGV2MPpqiUP9CQpBep31iS1HB2R8faEpD1HcxGlz9NSKpcYdb/nOkyrsg6d9IZyJEvQmvqDuNIrFkZvhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5679
Received-SPF: pass client-ip=2a01:111:f403:260e::701;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 9/13/24 7:39 PM, Andrey Drobyshev wrote:
> Introduce Qcow2 runtime boolean option "discard-subclusters".  This
> option influences discard alignment value (either cluster_size or
> subcluster_size) and essentially makes subcluster-based discard optional.
> We disable it by default.
> 
> Also tweak iotests/271 to enable this option and really test subcluster
> based discards.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  block/qcow2.c          | 21 ++++++++++++++++++++-
>  block/qcow2.h          |  2 ++
>  tests/qemu-iotests/271 | 10 ++++++----
>  3 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index c2086d0bd1..7c38a5be41 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -685,6 +685,7 @@ static const char *const mutable_opts[] = {
>      QCOW2_OPT_DISCARD_SNAPSHOT,
>      QCOW2_OPT_DISCARD_OTHER,
>      QCOW2_OPT_DISCARD_NO_UNREF,
> +    QCOW2_OPT_DISCARD_SUBCLUSTERS,
>      QCOW2_OPT_OVERLAP,
>      QCOW2_OPT_OVERLAP_TEMPLATE,
>      QCOW2_OPT_OVERLAP_MAIN_HEADER,
> @@ -734,6 +735,11 @@ static QemuOptsList qcow2_runtime_opts = {
>              .type = QEMU_OPT_BOOL,
>              .help = "Do not unreference discarded clusters",
>          },
> +        {
> +            .name = QCOW2_OPT_DISCARD_SUBCLUSTERS,
> +            .type = QEMU_OPT_BOOL,
> +            .help = "Allow subcluster aligned discard requests",
> +        },
>          {
>              .name = QCOW2_OPT_OVERLAP,
>              .type = QEMU_OPT_STRING,
> @@ -978,6 +984,7 @@ typedef struct Qcow2ReopenState {
>      int overlap_check;
>      bool discard_passthrough[QCOW2_DISCARD_MAX];
>      bool discard_no_unref;
> +    bool discard_subclusters;
>      uint64_t cache_clean_interval;
>      QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime options */
>  } Qcow2ReopenState;
> @@ -1157,6 +1164,16 @@ qcow2_update_options_prepare(BlockDriverState *bs, Qcow2ReopenState *r,
>          goto fail;
>      }
>  
> +    r->discard_subclusters =
> +        qemu_opt_get_bool(opts, QCOW2_OPT_DISCARD_SUBCLUSTERS, false);
> +    if (r->discard_subclusters && !has_subclusters(s)) {
> +        error_setg(errp,
> +                   "Image doesn't have extended L2 entries, but option "
> +                   "'discard-subclusters' is enabled");
> +        ret = -EINVAL;
> +        goto fail;

I realized that failing here might not be the best course of action,
since non-presence of extended L2 entries in an image is an external
condition which we can't control.  I guess we can just do warn_report()
instead.

> +    }
> +
>      switch (s->crypt_method_header) {
>      case QCOW_CRYPT_NONE:
>          if (encryptfmt) {
> @@ -1238,6 +1255,7 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
>      }
>  
>      s->discard_no_unref = r->discard_no_unref;
> +    s->discard_subclusters = r->discard_subclusters;
>  
>      if (s->cache_clean_interval != r->cache_clean_interval) {
>          cache_clean_timer_del(bs);
> @@ -1981,7 +1999,8 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
>          bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
>      }
>      bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
> -    bs->bl.pdiscard_alignment = s->subcluster_size;
> +    bs->bl.pdiscard_alignment = s->discard_subclusters ?
> +                                s->subcluster_size : s->cluster_size;
>  }
>  
>  static int GRAPH_UNLOCKED
> diff --git a/block/qcow2.h b/block/qcow2.h
> index a65c185b51..4e91bdde3f 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -134,6 +134,7 @@
>  #define QCOW2_OPT_DISCARD_SNAPSHOT "pass-discard-snapshot"
>  #define QCOW2_OPT_DISCARD_OTHER "pass-discard-other"
>  #define QCOW2_OPT_DISCARD_NO_UNREF "discard-no-unref"
> +#define QCOW2_OPT_DISCARD_SUBCLUSTERS "discard-subclusters"
>  #define QCOW2_OPT_OVERLAP "overlap-check"
>  #define QCOW2_OPT_OVERLAP_TEMPLATE "overlap-check.template"
>  #define QCOW2_OPT_OVERLAP_MAIN_HEADER "overlap-check.main-header"
> @@ -387,6 +388,7 @@ typedef struct BDRVQcow2State {
>      bool discard_passthrough[QCOW2_DISCARD_MAX];
>  
>      bool discard_no_unref;
> +    bool discard_subclusters;
>  
>      int overlap_check; /* bitmask of Qcow2MetadataOverlap values */
>      bool signaled_corruption;
> diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
> index 8b80682cff..d7cf3c459b 100755
> --- a/tests/qemu-iotests/271
> +++ b/tests/qemu-iotests/271
> @@ -100,13 +100,14 @@ _filter_trace_fallocate()
>  #      discard  -> discard
>  _run_test()
>  {
> -    unset c sc off len cmd opt
> +    unset c sc off len cmd trace opt
>      for var in "$@"; do eval "$var"; done
>      case "${cmd:-write}" in
>          zero)
>              cmd="write -q -z";;
>          unmap)
> -            opt="--trace enable=file_do_fallocate"
> +            trace="--trace enable=file_do_fallocate"
> +            opt="-c reopen -o discard-subclusters=on"
>              cmd="write -q -z -u";;
>          compress)
>              pat=$((${pat:-0} + 1))
> @@ -115,7 +116,8 @@ _run_test()
>              pat=$((${pat:-0} + 1))
>              cmd="write -q -P ${pat}";;
>          discard)
> -            opt="--trace enable=file_do_fallocate"
> +            trace="--trace enable=file_do_fallocate"
> +            opt="-c reopen -o discard-subclusters=on"
>              cmd="discard -q";;
>          *)
>              echo "Unknown option $cmd"
> @@ -129,7 +131,7 @@ _run_test()
>      cmd="$cmd ${offset} ${len}"
>      raw_cmd=$(echo $cmd | sed s/-c//) # Raw images don't support -c
>      echo $cmd | sed 's/-P [0-9][0-9]\?/-P PATTERN/'
> -    $QEMU_IO $opt -c "$cmd" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_trace_fallocate
> +    $QEMU_IO $trace ${opt:+ "$opt"} -c "$cmd" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_trace_fallocate
>      $QEMU_IO -c "$raw_cmd" -f raw "$TEST_IMG.raw" | _filter_qemu_io
>      _verify_img
>      _verify_l2_bitmap "$c"


