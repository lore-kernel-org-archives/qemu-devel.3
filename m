Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F128FD729E7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 16:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH3qZ-0001T9-IC; Fri, 29 Nov 2024 11:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbates@raithlin.com>)
 id 1tH3qY-0001Sw-1r; Fri, 29 Nov 2024 11:27:58 -0500
Received: from mail-canadaeastazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c104::1] helo=YQZPR01CU011.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbates@raithlin.com>)
 id 1tH3qV-0000dZ-ID; Fri, 29 Nov 2024 11:27:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwFlw8EmnPkPvhMoz21dPOX3XOrORIbugq2Ps3PRG5jHOzs2WwSf9SILJ+IaejqTSyWFHGDfK5yrT5McKild2tu7sUiywlJN8Vmxwzljfrh3VDzd1CFP0wWBu0s8XxG57GL1Gg70SWhog9fQ3FXODM1FTJnnc/ziklX6k/MHc7/IXJZBBaq9bso+phtXTUzw14jYNvxsLEm/lI5ItTtnnqh8lGG/ZKleGt735FXBDC8vfA1RXwIQZpzMzZtm6VQFTqj4eF8a4HkSzfT6HKIxPvHY5PAt9PtKinExt7BvqVIz4PW+NNywCQ/3ZamibBWAuoWFMaUgcxErpqya/5xmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTz0jwusH9w8G86285zmJrFRtgrMhTkmAKCw636IPno=;
 b=Gb5bkzJQcaJkdAmO6tnO/ExZ3fV0vB02FmNFwap2m8uYI/r7ofZfWdri9FlUeBv9SZkhQMTudUsh4QxI4lT26Jd7RUxrobCC8vURLgxsw8WhZPi0W4y/ILJV/R0OwUVmq9NzIdBvI0KC7mAZ+xelZhAA1krXsmnAF7h0xg3DwT3eGOkzKetetzU/tPGv1x2Micdf+6M4O1X35JUXr0frSGp//I2OLJfrB7gGGsl+JbpAIFggvfkcNID7t6HA5/ZeEl1F/VoO9nbUuneLibbpGuNLaYDBPyNx+3h7FWN3UFF2nIt4iuqmGL7fpdyswdbPNeKljhTcskdaUGUm1+zagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raithlin.com; dmarc=pass action=none header.from=raithlin.com;
 dkim=pass header.d=raithlin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector2-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTz0jwusH9w8G86285zmJrFRtgrMhTkmAKCw636IPno=;
 b=Be+701k7ffJhiLKiYKfb/foRUfLlZbtT9K+yFX+aEfK7V9E2t5jfF1Fqin8+1eA2olo7Nq0HqgzwJ7N8qpl1U33vJSbUoMxwL/onw56bB93wLm69N6xAVeg6kle4ZrCW9EUSMDZOgA17Gx39ZOeIagqri7/d3GM+SLL9kItmWTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raithlin.com;
Received: from QB1PPF104D96E2A.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::213)
 by YQBPR0101MB9439.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:62::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 16:27:47 +0000
Received: from QB1PPF104D96E2A.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1d40:19d3:40df:478]) by QB1PPF104D96E2A.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1d40:19d3:40df:478%4]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 16:27:47 +0000
Date: Fri, 29 Nov 2024 09:27:39 -0700
From: Stephen Bates <sbates@raithlin.com>
To: qemu-devel@nongnu.org
Cc: j.granados@samsung.com, javier.gonz@samsung.com, qemu-block@nongnu.org,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it
Subject: [PATCH v2 1/1] hw/nvme: Add OCP SMART / Health Information Extended
 Log Page
Message-ID: <Z0nre-4GLin5yeGX@snoc-pinewood>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To QB1PPF104D96E2A.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c08::213)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PPF104D96E2A:EE_|YQBPR0101MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: c3829796-1b04-4adb-c267-08dd1092c2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1NJcVVzbnhXa1B5R0t2Q1hKUmRPaU0yL0VQTElIYjJyUDBiTnVNUEJra0RG?=
 =?utf-8?B?ZHlnNGVRZW05TUp2MnFWdVdPZEJWajFjNjVFRFNqd0tZYnVMVlB5RXE4RkRV?=
 =?utf-8?B?aFpNL2psejFycjhzQ1o1VHkrSHE0L3BVS25CNmtxYmJUNVNmWlVEMllPaFk1?=
 =?utf-8?B?bXEyaGVMMS92Njd4dVg0VXhSZ2VqWWhPVU1kcFFiSE1FdGp1bFQwcGg0ZExG?=
 =?utf-8?B?UWtnZVlTKzdEWm84bFNIVkMveG1TUHVxNXhSTEdIcXY3NFlNSW1nKzFaRUps?=
 =?utf-8?B?blVoWHBsR3cwKy9RNlhmbTljT3JKVnBzOGVSU3VZYVNwSEtMM2Znd0VjQWRy?=
 =?utf-8?B?cWtPN1BuV0RQY0MzT001VGRVWTIwdlR0Y2cyczNNWCtLRjBVUHExYkk2b1NP?=
 =?utf-8?B?QTNPL3FGNFhSY3RvbUswZUxOaVFxVEhpRmFmNFg4bVF5M2JvWUhKcm1mSmRa?=
 =?utf-8?B?UnY0dndXWUVZUDdiQWpMdC93TXVmbEt5SnlHNFNJTlI2TTNKYS9TS2ZEZnVL?=
 =?utf-8?B?S2hyMklrd1pTZDdYdU41MTJqN1pzR0ZGaFFtOEN4eDBlM1RVbS9Dd09hMjZJ?=
 =?utf-8?B?eHR0UnNldHBQQXJreHpSd1JmSUhSRWd4TWxHby8yalg3M1U4VE5maDg5ZWJ3?=
 =?utf-8?B?K2orNjJtRloxdmxuclJ4QkoxSFZJZno5eDFFZ0lzQ1J0U1UyK0pyR2lOZk8v?=
 =?utf-8?B?ejhSTmQxSTZKVEpQbmFCYzloUHRRbVpKelI1SnRXcjJPL0NPd1lnY0dDY3pj?=
 =?utf-8?B?VzZ1NmZaK0I1RDB0SmpzSWdSZlhxZVNzVVllUmFzK0tQU0NTOXFtNzZqd2dU?=
 =?utf-8?B?NTc5L3kxZCtoWlRuTTRDQnlPQitYeTM4UzFiTDFjQmR6cE52TEFNbFQ1bjMr?=
 =?utf-8?B?WCtPamZ6L1gzNVFnTFVNaWthR0lHTUdSakpvblFnSnRkbkhJSXU4OTNySm11?=
 =?utf-8?B?d1o3V3RpaG9vbzlkdGJyUVhWbGRzQVI2b3MzWG5ScHZaRkdNMEJjdWZLSXdi?=
 =?utf-8?B?OTlhR1c3Y0lMNTQxUzlYU0JIZDB0RVQ0RVZUVVFXNHh5WWpOdk1BeEVPYVQ0?=
 =?utf-8?B?UnVUdHNVR3hES1BNVW5OZW9GVjBKS2w2Y29peVpGamVRa0lHWk9kd3NlMGlV?=
 =?utf-8?B?WW1oa3hVZE5paWJRZ1plbHJmZVBpVUFpcXpHcXpHUW85cTRJVXpNSGtjQmJB?=
 =?utf-8?B?LzQ0VVMyZ2ttSDlSR1dLTDFEcEJpWUl3dGRNaEJlUFNieFR5VGhKSjFVZTRY?=
 =?utf-8?B?ZlZCRld0ZlY0dVhBSThacEFJWEMwNDFaUUlKaS9qVEhJeXYzS2JhOHdxNnRv?=
 =?utf-8?B?RTlXV1dzRzRpSlJQSGRlVnlqTDd1UjFUMjYrdDJteUZaRzY3SDNYMUFsODFY?=
 =?utf-8?B?YWs4b1JWdTUwUjFrajNBeGphaWFyZ3c0OENUZS81cjFrb0Vyd3l5VVBxY1Zo?=
 =?utf-8?B?cEIvV0habmhrd3hXSDFOcGtjck45VUNabUJyY1pUb1l5ZGFXVUhBbDdFaGpK?=
 =?utf-8?B?S1gvRndrSGFRNXV3WG9DOGJ6V0JmaUhveXlSdDdzY28xbHdxVlIyL1NQcFBk?=
 =?utf-8?B?ekxRdU5vY2lvY3RUdlRqaWhVK2U2b1F6aklIRmxLaDhGYjVtcnhYNXlFM1NH?=
 =?utf-8?B?MzNFOUE1OERDbGpmRTJ2dXdaTmV6QW10eTZyam9HWGVpMnFrclVsSkpKcFJN?=
 =?utf-8?B?MmhETFZMWlIzZFJLYnFPU1hGcWlQbVN4VDFIN3QzR0x1RFhFTXdmK3pYZlYy?=
 =?utf-8?Q?uUhwEOeoGwJKi5XQns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:QB1PPF104D96E2A.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2dXU1V6d1FTUzR0emYxTEMwTk5sMUVrRkNpVkhoSUYvZEpCNVNHWno5bS9B?=
 =?utf-8?B?cEFVU2xUUC9kWkcrVEprTzFsYUt5dmJoMVB5SmhDb1hrZ3BGejNneEpiNDlm?=
 =?utf-8?B?TFRSZWRVUGFvYmE4b3d1NkRiQk0zLytWallpT0VkdkdQeDRtNFlHaXVabkhH?=
 =?utf-8?B?QU15bk1lbHlJMUhPeUhNK3F2QkNTbWlvU05pS1Q2UGh1UWZuTXBOZDBKQjVp?=
 =?utf-8?B?VlFuRk9IZ25KNjhTNXppaFBMdUF0S0plMUNleVZFclRMSEIxd0xmZjB6WHh2?=
 =?utf-8?B?TXlEZlNwenpOb3FmaUd6bTI3UjNDMVR5Q1YyKzZWUEw3NytNSEFqQnZYa01w?=
 =?utf-8?B?OGZNNFBRMDd2ZXVYcnN0clMzNTVLYkxIMDVueWE1SEI5V1BwdjJBRnZzVkg1?=
 =?utf-8?B?bEdnV3k3R0NQZ2lOMGgzRUVsZ0RsR25oK21xb2p6bzhVdGJPN1lDazVNbUR5?=
 =?utf-8?B?UXlBZ1QzZUdsRGVlMS9uZC9TTDVmeFNQSHRYcit0dFdWUTJpa2h4RUpNWDhn?=
 =?utf-8?B?Qi9zdFJuajV2TkdHRy9iekg3NFVCRC9YYlVad1A3Qjc0VmNDem42TFNtbUxU?=
 =?utf-8?B?VXdjSk92WHhpSlFDR2VzbThXYWp4Y1pGaFlJZjFIbFQyMjNBYW9DdDdMRVRH?=
 =?utf-8?B?Qis0ZWx3eVFwNHV5YW1Bc1l4OUZSRFkvMFV1d3U0Sll0OWoxSTdvanZsV3BL?=
 =?utf-8?B?Y3dISkFGbnlPNlVjbk1ndnNyL05adEtCWVBLMGdSQ3lYcGNhN3JaUE5WTktr?=
 =?utf-8?B?Uit5Mm05QktrZTZTdTRyeGdvcjNoVkUzU2xXWUdmdUcvV3ArczBieXlPQm1U?=
 =?utf-8?B?bFVrYzdEdFJZU3VwaC9uYWNnYjY4TjNaVyt5dGFXSnVlYVVBa3pkTUxBbm5H?=
 =?utf-8?B?ZFpjc0RxZ1VaRitIVnNSRlZhOUVsVkZsZFB1SzNpVFdBdmFJaEdxNlhPOHcr?=
 =?utf-8?B?RHI4UVk2WTBiSytqR0NDL0JBR01IVnFMMVhqNTFxbTBISHBNTFZncDRWZnpm?=
 =?utf-8?B?NHI2TWVjUmkwdmlqMVRzVUxTbUxRNzhCWXpVWE5IRHRWWVBxZEkzaW5YS2t1?=
 =?utf-8?B?Z3Q4UWZ6bjlqR20vK2lmeWJaVDE3dkRLRkRoRTJCd0czZWVSUGNGMDNKMzk5?=
 =?utf-8?B?akt3Y252aTMvY0xXSHNYZEc1UmtLUW1sRnp3bG1yVWQ3K0tLblhYa3hoTG9v?=
 =?utf-8?B?aEtac3Nlak5WWVVuTVJiSFZNVndBR3Uzb0YxZVhGOG1LUExJc2F6ODI3QnBt?=
 =?utf-8?B?YVRPWUFnNC9UUmFRUk1PRlFTODdzUXY3akZuK0ZkeXlIUVJWNE1lWUtSRE1u?=
 =?utf-8?B?OUhWUXp2K2dRTVdtZFRFV3k5cFhJTFkxWXlFbFo3RFlWTHBpeFFCUlJzbC9H?=
 =?utf-8?B?SVQxbGJzVDlhRWJZSTFleFdROWo2VHBhNDk4YzNjeWtFb3EzbXZ0bnpqRzdU?=
 =?utf-8?B?QVdNd2d2ZGRXSS8wMkh6NE1tclRrSVNiUWdBWTMrWmN3SXFtc05CdkVQdzdV?=
 =?utf-8?B?ZUgvTGxqTkUxaUkwOEwvMzhUbjdJU0czNWFEMzJrclBWSS90WjNwK29zMmJw?=
 =?utf-8?B?L3hETmNqN25BN25YdU1kUlZZSXRoc0NmTVFRUitXS0JSbnNwdzhrSVpyMFRX?=
 =?utf-8?B?MzQwWTNObFpRMmZpOGxaTnJFWEJKekozL2FPQ0FTNTdac2R5Nm10emcyelFE?=
 =?utf-8?B?UDVKdlFQUG1OV3YrcFNocC8xcnRPSm1mWmV3TE54Z0paQU40eGNLQ3JaOXp0?=
 =?utf-8?B?NklBN3drZ3NISFZyRDY0UW9jSmZOUkVJWkxSOEJMdVpjNk9Sb3c1clhJRVIy?=
 =?utf-8?B?eitBZ2t5OWd1VUgxWlNMKzZSU2N2SlBEdW5aUFE5SnNzSFRVRUYvaDhmWXJl?=
 =?utf-8?B?SmtLeGYzZjRhRTFYeVZkc2pYZGdXYldyNmVMb1FQclhTcUhaTXNTdk1MYXpG?=
 =?utf-8?B?SjZuZ05adXZadzgxY2dhNjRCNWtNZHhGVEhady9JTC9YUkJiR054ZDdETXVW?=
 =?utf-8?B?NzJsZ1RoS25uTnlTdE9lVFFDYlBMMGtURzBKaWc1Q3Z5Tk5pR1VqZExoblNq?=
 =?utf-8?B?eVlzbEVCbmFmdVdaTzYyYmRKRi9jMGJWN2JFTyt3MzlGUFdsaXpDT1k4ZGll?=
 =?utf-8?B?c1d3b3Bhc05JL2s2TlBUTzlnVnNFNFh1NnE0Y2pjMW4yM0k5dE1xN0d5RTlq?=
 =?utf-8?Q?LY57eiXwO9vNTr64hRf2gXPE0B/PdnAsb7ADhy61RWWN?=
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3829796-1b04-4adb-c267-08dd1092c2af
X-MS-Exchange-CrossTenant-AuthSource: QB1PPF104D96E2A.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 16:27:47.5207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TFotd0IGF3samIt2OEegPc6/yJVK9Wh6uIdusXpxz16YldBqI3hDwIt1wNSYR2gml/Xjxp/hWLnoC1J8mnusg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9439
Received-SPF: pass client-ip=2a01:111:f403:c104::1;
 envelope-from=sbates@raithlin.com;
 helo=YQZPR01CU011.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
 include/block/nvme.h         | 41 +++++++++++++++++++++++++
 4 files changed, 108 insertions(+)

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
index fe822f63b3..da2d12fcfe 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4891,6 +4891,45 @@ static void nvme_set_blk_stats(NvmeNamespace *ns, struct nvme_stats *stats)
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
@@ -5120,6 +5159,23 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
     return nvme_c2h(n, ((uint8_t *)&log) + off, trans_len, req);
 }
 
+static uint16_t nvme_vendor_specific_log(NvmeCtrl *n, uint8_t rae,
+                                         uint32_t buf_len, uint64_t off,
+                                         NvmeRequest *req, uint8_t lid)
+{
+    switch (lid) {
+    case NVME_OCP_EXTENDED_SMART_INFO:
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
@@ -5370,6 +5426,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
+    case NVME_LOG_VENDOR_START...NVME_LOG_VENDOR_END:
+        return nvme_vendor_specific_log(n, rae, len, off, req, lid);
     case NVME_LOG_CHANGED_NSLIST:
         return nvme_changed_nslist(n, rae, len, off, req);
     case NVME_LOG_CMD_EFFECTS:
@@ -8737,6 +8795,7 @@ static Property nvme_props[] = {
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
index 5298bc4a28..cce6605e1d 100644
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
@@ -1052,6 +1086,12 @@ enum NvmeLogIdentifier {
     NVME_LOG_FDP_RUH_USAGE              = 0x21,
     NVME_LOG_FDP_STATS                  = 0x22,
     NVME_LOG_FDP_EVENTS                 = 0x23,
+    NVME_LOG_VENDOR_START               = 0xc0,
+    NVME_LOG_VENDOR_END                 = 0xff,
+};
+
+enum NvmeOcpLogIdentifier {
+    NVME_OCP_EXTENDED_SMART_INFO = 0xc0,
 };
 
 typedef struct QEMU_PACKED NvmePSD {
@@ -1863,6 +1903,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLogExtended) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrlZoned) != 4096);
-- 
2.43.0


