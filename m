Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E8DE64039
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 22:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEFa6-0004jV-FU; Thu, 21 Nov 2024 17:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbates@raithlin.com>)
 id 1tEFa4-0004il-T1; Thu, 21 Nov 2024 17:23:20 -0500
Received: from mail-canadacentralazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c103::] helo=YT3PR01CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbates@raithlin.com>)
 id 1tEFZz-0007zf-Lm; Thu, 21 Nov 2024 17:23:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUFUT0y3KS9F3bqSU7NXqM687BwjktoH2EN5KFsJkZrx85KoDcJyIIig2arr7kCZvOo4remQdEIZEOcYJXgeUc8e6rnrLGbj2ZorGeKgq7ZlfKWIJNHMnXsqADUP0UgYJzhNdxM1VHvoeJ8CBeNCbs61iW5SmMdD9TqYMWoKZ9Xa2cAyH31Sxw7n2/DqdHuc83rgcTkx0XXXN4/2OwaRWJoISqF0DKPpvpfRpVHkmbV+yRHnNlNngsbyAZ76xOXHEbgm0gUkI6BgBV86K8172EfuKTEI941Z6hEKRGtdJqi05YwXfnv8x/vFRhJR9/LwT/Jxi4pBIe6zlRhP1pjK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9KYR3Ypdd42XMPtm+mtEIAC/0etnwSLiHqWI2gDMIs=;
 b=S0RbkqyuXXRUdlsyJ25txs8hxTIC6BpdnqMFxykbJ7goaXeyyvOKskYpPkKU6IROve0qD2Fqz/Hapi5cFN1hLIbi1FATm5b8uUdlbfnz3ssdUOC4D5SbmS1tHTXRDS4xNfXEb3V0SGBiJQy9+wrPYita3vzP4LDC4LvBIBYL8MSd3X455GhaicqDuh7V+ACP4wz70l0O08l4EMom54MtyWtyo+U+BRZ+IFuA4RtNrzv7HEZSsIHn9Tk9PFsWNlN8m5PGUi5n0PuGPPOdsl1iZHALvHhMOau+4E6zpIbXRBEbraSWFmStyWKL1gJ811zQF1+P/qDQgIm3bCMd585hnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raithlin.com; dmarc=pass action=none header.from=raithlin.com;
 dkim=pass header.d=raithlin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector2-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9KYR3Ypdd42XMPtm+mtEIAC/0etnwSLiHqWI2gDMIs=;
 b=EugTCtLU0zd+ogjE5kcVP+mM40UeYQKHOycsKQecvlQnaq0fS9gm5HI1vATVtbTnajQpz3HW2wEB5ol2InaLTKBYgx0YBmpkJtwbZ4wJYh9RbTm6UlyBzPG+s5Va5ZPeYEEZVbnNRWHEE1xzQQelrsT42A5mIeaDim8uFgrO6ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raithlin.com;
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::68c)
 by YT1PR01MB8505.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Thu, 21 Nov
 2024 22:23:11 +0000
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ceca:6aca:140d:7ce4]) by TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ceca:6aca:140d:7ce4%6]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 22:23:11 +0000
Date: Thu, 21 Nov 2024 15:23:04 -0700
From: Stephen Bates <sbates@raithlin.com>
To: qemu-devel@nongnu.org
Cc: j.granados@samsung.com, javier.gonz@samsung.com, qemu-block@nongnu.org,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it
Subject: [PATCH v1 1/1] hw/nvme: Add OCP SMART / Health Information Extended
 Log Page
Message-ID: <Zz-yyOolT5iWH7E7@snoc-pinewood>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::68c)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TO1PPFC79171DBA:EE_|YT1PR01MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cb612a-0654-4bbb-16ea-08dd0a7b156d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDVTeU5yLzcxQ3grUU1FaFdmaXQzei9Xd3huK2pMU1E0RTNZU0hURWc5QWNj?=
 =?utf-8?B?TEVYNjZ2b09oZzVvN2IvSjRLSGZmMG40aUJOUFQ4Y01zSkVLSDVQSnhqQ3ZQ?=
 =?utf-8?B?S3lZNlFCOHVBQWI1Um1xamNBMzVrck4vdlVyTlo3SW9oOWxJSmVOT1I2aEg2?=
 =?utf-8?B?WVBtekIwWWszZTc0cjZLVEhQdkNwdkhpTEZiV01Jdlp4VzJlZkJnS2lVY1ZD?=
 =?utf-8?B?WmtVSFdRdDFyV3YyK293bDYwdjhHMWliV3g1NHdoeFA1TTlKakFrR21NNEF3?=
 =?utf-8?B?dmdKT01CRk9yMko2VE1OWDMzWnBsRHdQT2ozN1l5dU5sWXRSbkxaK1o1K3Jw?=
 =?utf-8?B?TUlGeTYxcVJRNlZRTmdhTEJ3RC9lL3VXbWdUQ1VTTEk0TExreitGTXJqa3E2?=
 =?utf-8?B?VyszdVRQRFUvMmhGRzgyTUhGbWFGUk84bWlOV3BoVnBtRnBGRGlxZW1MbXBi?=
 =?utf-8?B?ZHNOdytqZlpGTXduRWRxZmtjSkVEOGZldEVXVmI0djc0T0JxSTFEWHJmSWNw?=
 =?utf-8?B?SXk4bXU3RHpNU0hwYjVEbTludE1MY1V3NjNCbzgyNjdqK0RPcnBReEJITmxk?=
 =?utf-8?B?YUVYempjSTZmeE16bldIdEN1Yk1ETUwyK2ZjaWR6NzhiQUVKUFlkQVFIeEpm?=
 =?utf-8?B?ak1xZ2pYTlpRd1hiQXNhY09mK1ZvOUdBTjVaSHFrUWg5ejZ1MlVRNE1Qd25T?=
 =?utf-8?B?a0lwOHJmNVY1TEwwT0JPZ3dOQ3BzQjg1a0dVT0I5cnNrdmZIOGF6OTJ4bTBv?=
 =?utf-8?B?L3p5WTcwMkF4OEMyV0hLMFM0djJRZjEzVGVNRDdXRklWUGxkczJSUjV4THlz?=
 =?utf-8?B?WGVOdGw0NGRZOERFRXlLcjI2RWcyQm9PTGI5NmlxMm5BazlMM0FialoxU0tu?=
 =?utf-8?B?Zm83ZXBaYzVpK1c3WHJWVVRGUHRwRU9jc05KekZ3dWJBVGRjaXEvd0FUQnpj?=
 =?utf-8?B?YUdzMUk1eFBtNFpyVk51MkZiekR5SjFuL3RvQVQzOEl2RWFGeW9YekIrUXQw?=
 =?utf-8?B?N0hQNy9YMjVEZm5zVDBrSVJaT1NvcHJOVloxOW9QZVlFUUZvOU5hSE5tUU5m?=
 =?utf-8?B?azhyRjJ0SWZObW0yQUNiOUFoSFZVZUozWTRsYjNGQlNmK0NNODdGSUZ2dkMr?=
 =?utf-8?B?V2ZlREdzUGNhcEVvL3lua0gwVUFYd05lOUJzdkVQdjdLakM0ZGxlamo4TWQ4?=
 =?utf-8?B?OS92L1o4bEV4WWZQTFZYUktvQ2wvdTRMcUVTWDRSeGxMQmhXN2VmWnBQZnB2?=
 =?utf-8?B?VGEyMVVZcDZxYm0vWWx0TkxVMDY4aFVyd2k3VGhhVnRzV0xvTHppRWRyblpo?=
 =?utf-8?B?bFJZRHZxSGdaSTVzSDBOTXh1alRNSXhlTXhiVU9uQ2NMM0pSREQ4aDlvemJS?=
 =?utf-8?B?dXg2TW8ydlh5VUZUUUtLMk1LS3dOblhkRFVnS0RQY2ZqRm5rdUR0REsyQ0lw?=
 =?utf-8?B?cjZmY2Q3SDUrRjNpa1dSTkdqZUs5NTJqVXlQcEVwRUJpWDRuSVNzTG9XMXhW?=
 =?utf-8?B?WWYvUWw2ZFpGblovbUZSNHZyRnNsZGlsQzg2RmhSUTZVWmI4a0pKdTRseUVF?=
 =?utf-8?B?UTVjT3JPeXlJLzMyUG1nRlIwdVdsMXRHV3NCVGhPZHpzVjUyYkFnOSt6Zkc3?=
 =?utf-8?B?N3YxOHpxNzNPOUtpSFVwVk43SnhQUGdDNlloT2Z2RGhjbVR1di92R2VTb0Ju?=
 =?utf-8?Q?bKXj7DddrtkHnVxoKeqV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFxMWdzejBXdnNPSXZFSTQzS3dVRUd2YnVWSlZ5SGNDUzBVUjB6ekJVT050?=
 =?utf-8?B?TnVxQnRMQlMrV0tFcFg4LytoSUx5Y2poaDdJWU1IeFBoOXNhdGlaOWlDOUNF?=
 =?utf-8?B?b3RmOUhIa2RpOTQxWWxNQlVqU2lRNnNPdVZnMjh1V2JzNHVLYlZIL096WXZ2?=
 =?utf-8?B?Y1FBVFozakZJZ2RlZnYrd1hpZkQwNllDbVVac1lIS1psMzBNY3JKQk01K2ZQ?=
 =?utf-8?B?YzdaUGkzQXVhbHlWMlVtMjNrMFpWYWZzT3NnNkF3Nm1SRm9oTEU0RWpkYWZY?=
 =?utf-8?B?L1k2SGdtY0xBQkdjUU5uZkhleVlkeXI1WFkwN3c5NFZIOWl6QUtLTEdnVENt?=
 =?utf-8?B?UHhWVlhKVmd1ZEZBQVdnRzNHZUQwbkhnNnhaRXMrTnRBMGdqc0JPaXBBb3Jn?=
 =?utf-8?B?S2xJYk0wUDl1V0lTekZKcmlUSDhjUW5LcCs4ZkE5aGFXZFlBRTZlU1paZXdW?=
 =?utf-8?B?TWNMMFlsQ3pnUXpOS3owWE9iRkpiMFNSc3dBeW5XUEZvNkxyT2ZJaEpEYnRC?=
 =?utf-8?B?N2l3UWN6WDNWbVFUd0d2RzEzcFdGaEFpRmVsMU5SWGFwNnlKcU1HbTl2ZlZr?=
 =?utf-8?B?eUNtTHBpSWJSZmo3SklTRjA5dmgybVFzZHI5TnJuQjN4bFJZc3lkaFJMOURi?=
 =?utf-8?B?RzUyaEQxSUpuWEk0UGVtUnJjVlZQdEw4amJndGZ0dkpDNmNPZGZCZktsN2dN?=
 =?utf-8?B?SWdualpjU1NMbGZ5NWgvOFZjM2swZGQ3VlVCLzk1NEp0ck9ZSXZldCs3ZldK?=
 =?utf-8?B?VW1PRTVMMnU4NC92YVhwODd5TVFvZ1BsNzlEakxScisycEttZjdwSmtRNFlV?=
 =?utf-8?B?QkUydTBtQStPc0NkaUNyamZPUUlkWUF3eEZhM1hHNm1QMlNlQ1oxWVlIZXlY?=
 =?utf-8?B?RXVyM21qK0VkaXFDaVlvbE9BbkxRb3ZvdktqTktrcUNvQzBob3hoRlpSK1lH?=
 =?utf-8?B?Ui93Q2xUc0FZSE8ySlQ1RU9QL0gzeFd0T1ZobmxDbk9IY3Bqek5IY1l2a3I1?=
 =?utf-8?B?L25tWENBMHVTN0R4Y0lkTEw1SmhwN0VLY1lOcmNGRU9MWk1ydm0wcGxvVndt?=
 =?utf-8?B?eGNHTEZOT1FJVldxTDlSL3RVOEtWMjYwUFIxZkxXaFBPWFhLNlVPTHZLMkZ0?=
 =?utf-8?B?UGVodEhvMko4M2YrRGJaSWJQcXhQWm9XMnRobnFnbEVjVUNtcWlHZG85Ykhy?=
 =?utf-8?B?TTB3c0FmZ080VVE3WUYxb2xkU0NCTG11SVMxZTdTSEFlMTZQUmRXYVFDUEEy?=
 =?utf-8?B?Q0wwQTFnOFdKYnJGc2RQOUJXN2FodGpMV2h6Z2xidm9ZLzB5ZlRFL0Q1eE85?=
 =?utf-8?B?S01QOUlPeWIrQmg1YXBnRk15akE2Mlh5STEwOVlENnc4bGszRDFWMHV5UXQ5?=
 =?utf-8?B?WndFQ01HbWdqc2NBTWlDeDJteTI3Umh1UXBBOXh3T1lpRTBLWmI0WXNNSC9i?=
 =?utf-8?B?Sk42RCtTSU5kbWVRYXFxZGhxdXJHTjFPSGlaTkd3VUk5U1VCaVAweUluYkgz?=
 =?utf-8?B?UFRTcjkwaG1TbEhocHZxSGgwdjUxQmxLYW10Ny8vWU9VaEl1VjlxbXMzVFFH?=
 =?utf-8?B?b2VKWTJGTHp3YUpqSktMRCtVc0hUaE40bjdIdzRlWE1jV1FjZlI1NG5JdDZ2?=
 =?utf-8?B?WDh4VFhndDFycE8wODhPQTBtWkg4UDhlNkU3bHVldXUybkVOZTBRMW5wL0lh?=
 =?utf-8?B?NjA4ejBOT3V4NFJYVE84K090cHpldk1PM3pDdFRHaGVFQURwSzdmdmhzNSsv?=
 =?utf-8?B?RlZaY2paNVJiVnhhZTJDaVptR3gxdGxmU3FJNUtHa0lvaXF1VjA0eWZIZGNp?=
 =?utf-8?B?SHVOblRTU2RnaDFMdVBFMnNrcFoxVXlVZUl2QmZLelN6NktKQlZjUUdzK0xT?=
 =?utf-8?B?b3ZGZEJYWXd5dFlHWjJ1aGVsWnJ1Yi8weEdWMno4T3htaURqQzI3U3NEaTJY?=
 =?utf-8?B?VXNiTzBaVXFTSFo4M0FRbmhZOW5BYnFCaUM4MTVwVVZvQlFlVm9NKy9rbGRJ?=
 =?utf-8?B?S3ErTXZ5UFpPVkxDZVlKcTUveWlhbzZ3TVVIelk4ZlFBa1AxN1ZsUkhOZWZz?=
 =?utf-8?B?dkgwMi8wZDl1NGlINHJ6NFg2K2FHSHczeWEzUzI4OTFIQVBzWkdHMytVczdM?=
 =?utf-8?B?YkdvS2xmQmo4YSs5QVM3U1o4c2JtaC90bjZtVENTcTZpN1gxOW5YLzlRY3E0?=
 =?utf-8?Q?MWwincvdq8TpB+yM2b2C+Gwm/qYlRykmE/t0eyYH6SJy?=
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cb612a-0654-4bbb-16ea-08dd0a7b156d
X-MS-Exchange-CrossTenant-AuthSource: TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 22:23:11.4330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maUSOHaUNxM38qvP9XtACqc+rAOMevFx3aupEA0kSa3A0o0bEMEjJMKqf0ndK4etNFOCBWRSFWOul1os/fe/eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8505
Received-SPF: pass client-ip=2a01:111:f403:c103::;
 envelope-from=sbates@raithlin.com;
 helo=YT3PR01CU008.outbound.protection.outlook.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The Open Compute Project [1] includes a Datacenter NVMe
SSD Specification [2]. The most recent version of this specification
(as of November 2024) is 2.6.1. This specification layers on top of
the NVM Express specifications [3] to provide additional
functionality. A key part of of this is the 512 Byte OCP SMART / Health
Information Extended log page that is defined in Section 4.8.6 of the
specification.

We add a controller argument (ocp) that toggles on/off the SMART log
extended structure.  To accommodate different vendor specific specifications
like OCP, we add a multiplexing function (nvme_vendor_specific_log) which
will route to the different log functions based on arguments and log ids.
We only return the OCP extended SMART log when the command is 0xC0 and ocp
has been turned on in the nvme argumants.

Though we add the whole nvme SMART log extended structure, we only populate
the physical_media_units_{read,written}, log_page_version and
log_page_uuid.

This patch is based on work done by Joel but has been modified enough
that he requested a co-developed-by tag rather than a signed-off-by.

[1]: https://www.opencompute.org/
[2]: https://www.opencompute.org/documents/datacenter-nvme-ssd-specification-v2-6-1-pdf
[3]: https://nvmexpress.org/specifications/

Signed-off-by: Stephen Bates <sbates@raithlin.com>
Co-developed-by: Joel Granados <j.granados@samsung.com>
---
 docs/system/devices/nvme.rst |  7 +++++
 hw/nvme/ctrl.c               | 59 ++++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h               |  1 +
 include/block/nvme.h         | 36 ++++++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index d2b1ca9645..6509b35fcb 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -53,6 +53,13 @@ parameters.
   Vendor ID. Set this to ``on`` to revert to the unallocated Intel ID
   previously used.
 
+``ocp`` (default: ``off``)
+  The Open Compute Project defines the Datacenter NVMe SSD Specification that
+  sits on top of NVMe. It describes additional commands and NVMe behaviors
+  specific for the Datacenter. When this option is ``on`` OCP features such as
+  the SMART / Health information extended log become available in the
+  controller. We emulate version 5 of this log page.
+
 Additional Namespaces
 ---------------------
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 9f277b81d8..42a7bbf945 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4884,6 +4884,45 @@ static void nvme_set_blk_stats(NvmeNamespace *ns, struct nvme_stats *stats)
     stats->write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
 }
 
+static uint16_t nvme_ocp_extended_smart_info(NvmeCtrl *n, uint8_t rae,
+                                             uint32_t buf_len, uint64_t off,
+                                             NvmeRequest *req)
+{
+    NvmeNamespace *ns = NULL;
+    NvmeSmartLogExtended smart_l = { 0 };
+    struct nvme_stats stats = { 0 };
+    uint32_t trans_len;
+
+    if (off >= sizeof(smart_l)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* accumulate all stats from all namespaces */
+    for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        ns = nvme_ns(n, i);
+        if (ns) {
+            nvme_set_blk_stats(ns, &stats);
+        }
+    }
+
+    smart_l.physical_media_units_written[0] = cpu_to_le64(stats.units_written);
+    smart_l.physical_media_units_read[0] = cpu_to_le64(stats.units_read);
+    smart_l.log_page_version = 0x0005;
+
+    static const uint8_t guid[16] = {
+        0xC5, 0xAF, 0x10, 0x28, 0xEA, 0xBF, 0xF2, 0xA4,
+        0x9C, 0x4F, 0x6F, 0x7C, 0xC9, 0x14, 0xD5, 0xAF
+    };
+    memcpy(smart_l.log_page_guid, guid, sizeof(smart_l.log_page_guid));
+
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_SMART);
+    }
+
+    trans_len = MIN(sizeof(smart_l) - off, buf_len);
+    return nvme_c2h(n, (uint8_t *) &smart_l + off, trans_len, req);
+}
+
 static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                                 uint64_t off, NvmeRequest *req)
 {
@@ -5113,6 +5152,23 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
     return nvme_c2h(n, ((uint8_t *)&log) + off, trans_len, req);
 }
 
+static uint16_t nvme_vendor_specific_log(NvmeCtrl *n, uint8_t rae,
+                                         uint32_t buf_len, uint64_t off,
+                                         NvmeRequest *req, uint8_t lid)
+{
+    switch (lid) {
+    case 0xc0:
+        if (n->params.ocp) {
+            return nvme_ocp_extended_smart_info(n, rae, buf_len, off, req);
+        }
+        break;
+        /* add a case for each additional vendor specific log id */
+    }
+
+    trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static size_t sizeof_fdp_conf_descr(size_t nruh, size_t vss)
 {
     size_t entry_siz = sizeof(NvmeFdpDescrHdr) + nruh * sizeof(NvmeRuhDescr)
@@ -5363,6 +5419,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
+    case NVME_LOG_VENDOR_START...NVME_LOG_VENDOR_END:
+        return nvme_vendor_specific_log(n, rae, len, off, req, lid);
     case NVME_LOG_CHANGED_NSLIST:
         return nvme_changed_nslist(n, rae, len, off, req);
     case NVME_LOG_CMD_EFFECTS:
@@ -8734,6 +8792,7 @@ static Property nvme_props[] = {
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+    DEFINE_PROP_BOOL("ocp", NvmeCtrl, params.ocp, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 781985754d..099f40f3e9 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -538,6 +538,7 @@ typedef struct NvmeParams {
     uint32_t  sriov_max_vq_per_vf;
     uint32_t  sriov_max_vi_per_vf;
     bool     msix_exclusive_bar;
+    bool     ocp;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 5298bc4a28..df8e45e396 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1015,6 +1015,40 @@ typedef struct QEMU_PACKED NvmeSmartLog {
     uint8_t     reserved2[320];
 } NvmeSmartLog;
 
+typedef struct QEMU_PACKED NvmeSmartLogExtended {
+    uint64_t    physical_media_units_written[2];
+    uint64_t    physical_media_units_read[2];
+    uint64_t    bad_user_blocks;
+    uint64_t    bad_system_nand_blocks;
+    uint64_t    xor_recovery_count;
+    uint64_t    uncorrectable_read_error_count;
+    uint64_t    soft_ecc_error_count;
+    uint64_t    end2end_correction_counts;
+    uint8_t     system_data_percent_used;
+    uint8_t     refresh_counts[7];
+    uint64_t    user_data_erase_counts;
+    uint16_t    thermal_throttling_stat_and_count;
+    uint16_t    dssd_spec_version[3];
+    uint64_t    pcie_correctable_error_count;
+    uint32_t    incomplete_shutdowns;
+    uint32_t    rsvd116;
+    uint8_t     percent_free_blocks;
+    uint8_t     rsvd121[7];
+    uint16_t    capacity_health;
+    uint8_t     nvme_errata_ver;
+    uint8_t     rsvd131[5];
+    uint64_t    unaligned_io;
+    uint64_t    security_ver_num;
+    uint64_t    total_nuse;
+    uint64_t    plp_start_count[2];
+    uint64_t    endurance_estimate[2];
+    uint64_t    pcie_retraining_count;
+    uint64_t    power_state_change_count;
+    uint8_t     rsvd208[286];
+    uint16_t    log_page_version;
+    uint64_t    log_page_guid[2];
+} NvmeSmartLogExtended;
+
 #define NVME_SMART_WARN_MAX     6
 enum NvmeSmartWarn {
     NVME_SMART_SPARE                  = 1 << 0,
@@ -1052,6 +1086,8 @@ enum NvmeLogIdentifier {
     NVME_LOG_FDP_RUH_USAGE              = 0x21,
     NVME_LOG_FDP_STATS                  = 0x22,
     NVME_LOG_FDP_EVENTS                 = 0x23,
+    NVME_LOG_VENDOR_START               = 0xc0,
+    NVME_LOG_VENDOR_END                 = 0xff,
 };
 
 typedef struct QEMU_PACKED NvmePSD {
-- 
2.43.0


