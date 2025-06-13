Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17D7C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 11:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ2MD-0005AV-7D; Fri, 13 Jun 2025 07:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uQ2MB-0005AF-Hn; Fri, 13 Jun 2025 07:13:59 -0400
Received: from
 mail-germanywestcentralazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c20c::1] helo=FR6P281CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uQ2MA-0007nN-17; Fri, 13 Jun 2025 07:13:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeztKOKy1fjudfiOUnTFtJjSkEuY2fLEeNUMa+vzlBt2nOtyf4b3Q6Tzl9wkpsMaDWGm+ipE5ORRHzQMSyuOCXtFBx8l+EbKynysjUZqIpZiVMz6ko7SgWSCbz7cxQR/KvnAXgGSg30OT6D9o0Zo5MaOqhtKPRrqUpSIdCI5RdH3H115YFzw6Dw0PVYYnYVy+I0V1lcQlwn8woHOmEFtRQcz39ydVJmFkGtwzguDeudKdaawgaTC1IpUdhXMhoZv/15JW2Cilnv9D6xnBM29YP0q1t8XXI/13BpORU/Tq8vqZrVoqDZwWLdNCB2Lr7feIZsH1Mkzpl2FfqQ3+a8aqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN6+Ao1S2pHA2Dq4PdyZtJlWT7HPXQj63AQ2kYm+szY=;
 b=bwjBBj3UcG1BkQ7pj7xqLAePqgkL9iDVD/d+FDxnxY1qKi5KK5IjJuPzOiwIuTy/MB5Nr9tg9YG1pWw41yHmnRnOEiuXswUPhCsICyzDyFcJtn2fwBqnJW35z5FPHJpWhE+lYsJ0J0mKWU9MOX/ILVlvFTEFJIqoHHi6WlQxht6s9rkQwinK37u+LfJhQA2ertvJIEbmk6aw5pJVB0Ht83hw2DXsxsi7JQ5CpJIu1zCG50MCXRnUeuaXVQv67fD9YAT8Q0XJ0w1l7v/hz2PfWehj5eWRAd7uyMV32CtQKMRtGYNxYaRCtB6PAbEUp1kSlS+au2hc53DYJ1TmJcPTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FRYP281MB2940.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 11:13:51 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48%6]) with mapi id 15.20.8835.019; Fri, 13 Jun 2025
 11:13:50 +0000
Message-ID: <e9622a66-e9d6-46ba-aaed-57de592f5959@siewert.io>
Date: Fri, 13 Jun 2025 13:13:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Content-Language: en-GB
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <20250612144052.22478-1-tan@siewert.io>
 <SI2PR06MB5041DE20EB548C3137045975FC77A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <SI2PR06MB504192DDAD5ED2325B9AC0EFFC77A@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: Tan Siewert <tan@siewert.io>
In-Reply-To: <SI2PR06MB504192DDAD5ED2325B9AC0EFFC77A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::7) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FRYP281MB2940:EE_
X-MS-Office365-Filtering-Correlation-Id: 4716f3d0-fadc-421d-0c48-08ddaa6b5fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTM3R25RTUFLY3Q1M25VNkp5dStLUkZ4cDVuOVRqSVg5ekRnNmtHL041YUJs?=
 =?utf-8?B?eTRIaU11elNkTzUyeXpsTmhlZDBld0t1TkJaeEJsWURoR09IMndib3Nicncx?=
 =?utf-8?B?TkdDaE82RG5XU0hpMTB5SGc3TnI3azdHSHZMNEpweCs0aHJydFc1Ry9jd2Rv?=
 =?utf-8?B?eUlSWXVEK3hSTzJpdC8zbFN4ZlQydWNrR0s1c3B0K2c2bXUxYld1VVRNbmNT?=
 =?utf-8?B?Y3RDdzNwdjVMTktaZ3E2a0tSeEMrazA2ZU5VdnpkaytyTW5yRnVhZENPTkZz?=
 =?utf-8?B?T3dGWElwNDdxV0ZqZk96WjVDd1JsUE1lcW1mMnRqZUdSTXBSK01MUCtTU0lL?=
 =?utf-8?B?ejF5WVRwYXBURkgrUkN2dHhnNnYxMkVXclBKVy9YYk9aSkdEbnJjU1NHb2Mw?=
 =?utf-8?B?VTZCZmt5eXFlQ05mblRWV3YwZTVaU3VLU0svUU92R3dibGU1NEllRmxPbEQ3?=
 =?utf-8?B?aWZOVHZNMXd2N3ZUM0JUTEs4QWg4ajdETi9TRmtIK0xrdDJCVDFBdGtBeGJU?=
 =?utf-8?B?dmNPT2RWTDdpWHFKeklMRCt5TGpkZGxjRE9yQVZYMHUxNDBULzFXZlNJRmRB?=
 =?utf-8?B?RkJtVVBRYU5SZitUNmtxRnFieHRiRXpKanpyOWVjMURrQ3QyOWgzZnFlanBL?=
 =?utf-8?B?d3NkalNyK0RqSmZFVGxObG9LOEFDL3J5QjNqbGJUY0N2eUpOVTN2WWNrQk12?=
 =?utf-8?B?ZytiL3Y0WGpzSGlvTDRyVncrTGY3M3Rwdi9kVmVHYVd5WFpudnJQUjNDYUlN?=
 =?utf-8?B?S3A0aTZsQ0NPWXJla24rcE8wOXllVjBGdUdVVkRFazMrTmh2L1U0dllhUURT?=
 =?utf-8?B?elRzZVJyaUg2MmJFeTdwTE5EeTQ5ZHZUOExSYXB0MHZwTVZrVFFiR0ZscE50?=
 =?utf-8?B?LzRyQjErOVhvOEhEeDh5Sm4xdnR5N01DQVBLSVQ4ZDVaWlBzeHk3WEswS29B?=
 =?utf-8?B?TWxMQXVVWnlwelBMMmxTd1prMU1TeU5oSzlLVjZqNWFzbU1BdWhDdEMvWDhR?=
 =?utf-8?B?b3QzQ2dON1Z5MTRjdzZHUDJMSHhWc1ZjTFhaZ29PUlAzekFsWXZUSWtJeHM4?=
 =?utf-8?B?MkJxYU5yQ3F4UmpHNWtncTRSeStWVFhIQk93OFJ2bEREd3pWeGZnaVF3aGlI?=
 =?utf-8?B?R3dQaDZKbWhaVHp4MUlCU1U1ZDA0VW45MHk2SnVmeS82Z2JFS3oxd2lnL0F6?=
 =?utf-8?B?UWZ6alZIbXplMUFsL0Z4RXdua2paMGNVMUhIMXp5SzV0c1FZTEhhKzdnUStZ?=
 =?utf-8?B?UitEZXR0TmVEY25aV0Z2V2cyN1Ixd0VMRHg5TVVRczM5cGQ1d3lhWXJvZnZK?=
 =?utf-8?B?Z2lHc0lmNkphN3hTeElxb0d6NVkxQnpWK1dYMjdtbFQzdGNiOGxvSE9NZVor?=
 =?utf-8?B?bmdtVENaSEhyL2FvWCtnOWw3VkZUR2Mwd1IxTjRoelJiTTVZNi9HWCtrY09y?=
 =?utf-8?B?N0c3YkNxaEh2QjlkRFQ5Q0U3Vk9iOFU2TjJ4UHd1aG5hYm1DOWMyK1RiNFdJ?=
 =?utf-8?B?SmxFWVZDVlBNWFBxaXlDc0VVT1FMa0puMXBBL3ZYTDc3a0MxajNtM0tzTGYw?=
 =?utf-8?B?VDIzQmRXZldyQnFDSDFGOWs3eTNqRXFkWTVFd1FHN1hnRXBqWldYdE1tVFBQ?=
 =?utf-8?B?bitSSXJadUdKdHBITDhDSlFRM3lMSlRUanlDVDNHSGEwTG5lSEF5T29sZ3Ev?=
 =?utf-8?B?TWQzSFNoSUJXM09DOVFEOVAveDNraDdnanNQbkJtMEhLeVEwcWdja0QyRm5O?=
 =?utf-8?B?TXlrejU4WG56SE1lMm5INjBoeEkvYTBtYjBHaURjQk1leEJLUHd4U2ptV2No?=
 =?utf-8?B?Q0VHUTRFcmdLL1lwRzdGV3dDWmJIbnExcllMcVJMOVVZTjgxL25sUlBqSGs1?=
 =?utf-8?B?UnpySzA0OGlKRnBFZFdnREU5Y2MxLzdMK0EvbTZaaG9hT2pyQndJOGFYRWdn?=
 =?utf-8?Q?cI16Rb9o2fo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0xnOC9FUWxFVDdCalowZ1pEcVR2Ynl3MHBjVnozUDJUK05KR1RXMzE3dmZx?=
 =?utf-8?B?QlgyT0R3NTBqd2xNMGVwN3lHMDF3WEZoQTBFWWhxMk9VZUtoYUFab2ZwYnR3?=
 =?utf-8?B?ODVzZlc4L1JTMHE0TUtzVWVtSDNodHJhTDlvQTBybDZpMTlEeXBqOS9hMHcv?=
 =?utf-8?B?dHAycWNmS25JTnBxWnNJWHZtQ3dmYmZ4dmpJeVBQeTFnNkV6QTJOVUFmVEVH?=
 =?utf-8?B?VHVYZUVzRkNhQzlQWmxiblBJN3plNVFkcHNBb0N6VGtzN3pLdWEvOTJIQ3E1?=
 =?utf-8?B?am8vZnppNjJmaU9ZTTdyRkswVUIxRHE0RHJoRld5MlJZU1FGZGhzOG1QU2NG?=
 =?utf-8?B?MDhPQTlkeWp1aFNuT2FpUnMxek1hcVBBZ1JJR2gvaUs2and1Z2lCU25jWm82?=
 =?utf-8?B?eFl4SE5yQnVXd2x0TWdKN2hPQWJSTE1wVXFFYUxhRXBJMWFjVy9Zd3dUaWk3?=
 =?utf-8?B?aXdFb0FSQzhjQlRvWmp2akE4VkRJWVNzdmNOeTBnUGdxMFgxY2poZ2lDTExG?=
 =?utf-8?B?cHRaOXd1dWw1eTJBVEZKMU5zRi95bE8xeDI0Yi82MTAzVUcvd0p5VFl1REx4?=
 =?utf-8?B?dEpGMXQwNXNlZEtPTFlBdUIwaGFKdDJhVy9CVkRSTVZWRXdQTXZUQVpUOGxX?=
 =?utf-8?B?cGZoSG9SMkNOUVEzdjhmNGxUWnRTQzhNL0VzeXd1MklnaVN6WlVwYlYvYnRZ?=
 =?utf-8?B?WEVzYTBvU3dGeGNjVWZBUytqbjFFQnBadlZUY0g3Wmh5VHM3Y1IyQzlwNTdH?=
 =?utf-8?B?eWpWdm9GTlJLT2MwMkJZN3ovdGdEUEVMSzlaK1ZuazB0RFNPcVl2TlFJcFUv?=
 =?utf-8?B?SnZWaWdIL1ZUVUd2czRweTZoZmFSd1FCYU02TGJhSWhtNWdmUjBiUkVFa3pz?=
 =?utf-8?B?ditvalNYbWgyby9RQjVYT3YvRlhiV3pMQUFuUDRHZzZhcjZEdkIzZitteUZ2?=
 =?utf-8?B?SGdsM3owQmF0VjduSSsyVXVVYUNJbjZTc0Jub3FhM0R2NzFDYkFOUWJ0NUFq?=
 =?utf-8?B?RUpWVjhyd2U4WEJzc1owSkU0alZqWVRzYi9pR0JjYXZrRkg1WGxPb0s3RmxD?=
 =?utf-8?B?RDladHVPaFVlM3JYZ1pjOEdrb0JFM0ZzakFLbUN4VUFNeG1FZGRvZnk4M0gy?=
 =?utf-8?B?M2JkNXFUL0RvOVFqcVhZSHZaUGQ2SDJmS1lpQ25ia2dSRGVIeXpGdlZPVjNO?=
 =?utf-8?B?MkFkV3hXMVVLRGJvZVBoMU42RXQ4ZHpyRmZVaGJBUW9LZVlTa2cwUExjNlg2?=
 =?utf-8?B?YUJNam8vLy9DWFZYNWhvTFBZeDRxdC81aXlqbXZDL2k0QU5xanFvK2dqWnVT?=
 =?utf-8?B?R29uRnJpRDJRQmpqUElYOTJ1RDdKMlhQVGVJbGpqZjUzMkRoOEQ3YUdWZDln?=
 =?utf-8?B?SkpHSXgxNjJqUVNWa2kweE9xeEQwWEJVYVhOaG8xMHhHdVI3UzIyckFSb0dz?=
 =?utf-8?B?RDl5aStOYTZjM282ZG5HemZBRG5lUGRuakZBNVZuc1BKSFIva3V0aVFmbGVF?=
 =?utf-8?B?YWJZdDZCZEZ5TXdUMUZVdENCVTRJMEZPbDdlRWI1RzE0MmRIck9RRFhXempZ?=
 =?utf-8?B?TWd3SnRUZG9ZZ21lbkk4dW9ncDJPb2dzLy9vNUtQbVBwci93UittN05BelRm?=
 =?utf-8?B?eEMxSkcxMFdkeVFHc2I1YWVTZXFCMGdvWEZuTWNFQ3dPLzJSRG1FQXdYMWpx?=
 =?utf-8?B?QjhUblV1N1ZrQjlWL2tHcERmRnV1UFN0QzVSbjVEbTdYNmg4VVFnd0tRNFJT?=
 =?utf-8?B?NnFVbjh5L1NCVU10NjVrcVN3OEZ3TVI0TjM4c0pzNTZjaGdSOEpBU2pIdVRR?=
 =?utf-8?B?c0I3ODdBY3diWDZHS3M0dklTcmcyK1FIMkdpSlBrSDdaY2tFaWVkOTdLcVdY?=
 =?utf-8?B?MG1MT3JEMDNtODdFNWJRdytQSWFHZlZQWnZRMkV2SFJIUUNqZjBjc2pmZHds?=
 =?utf-8?B?aXpYZWllbENac0JTc2dwc3pBOGpNUVFqcG9MYUZYT204WDVwNmR6YXhKajJR?=
 =?utf-8?B?a0ZHaVRqZS9MRnNESjJBQS9aL1N5NFJBbGQyTWxtZzRVSmtJaStNS0EyK0ln?=
 =?utf-8?B?b2dsRXhjYUhIWDZEOEV0a0dsUzNFb1dIWjNLcVJXSmIrdHNrSGFWN0VaeTR3?=
 =?utf-8?Q?lzb0=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 4716f3d0-fadc-421d-0c48-08ddaa6b5fdc
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 11:13:50.7613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gklom8p8QJHSNI85EJFR9bEyiNGhXZXN40P7YmsB8F5maVbEKsVdxjyMaDluuVdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2940
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

Many Thanks for your review, Jamin!

On 13.06.25 05:01, Jamin Lin wrote:
>> According to the datasheet description: it seems your changes do not match
>> the actual hardware behavior.
>> Protection Key
>> This register is designed to protect SCU registers from unpredictable updates,
>> especially when ARM CPU is out of control.
>> The password of the protection key is 0x1688A8A8.
>> Unlock SCU registers: Write 0x1688A8A8 to this register Lock SCU registers:
>> Write others value to this register Only firmware can lock the SCU registers,
>> other softwares (ex. system
>> BIOS/driver) can not do this to prevent disturbing the operation of firmware.
>> When this register is unlocked, the read back value of this register is
>> 0x00000001.
>> When this register is locked, the read back value of this register is 0x00000000.
>> Writing to SCU000 can be seen on both SCU000 and SCU010.
>> Writing to SCU010 is only on SCU010 itself. SCU000 does not change.
>>

Interesting. I tried something similar but apparently did not enough 
research on my AST2600-A3 card (or messed smth else up during research).

You're right, (un-)locking SCU000 will (un-)lock SCU010 too, but not 
vice versa.

>> Could you please verify the QEMU behavior?

Right now, locking either SCU000 or SCU010 will be reflected on both 
registers, and unlocking must be always done separately.

I guess it's time for a v3 then.

Cheers,
Tan

