Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A39BC982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pxi-000072-Tq; Wed, 16 Sep 2026 09:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6pxY-0008RN-Id
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:46:05 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6pxO-0006wP-Tb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:45:53 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GCbKNg2648760; Wed, 16 Sep 2026 06:45:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1aqlJ5BWxLsGv7WB0RmGDm2OIu4ksjgwLLlXPvBSi
 v8=; b=tFRRIjiLReKL7lTQ0Ice1Di/1+se8LfV3eTopwF+wLZsW1gpNiLRh6VwI
 ifkvhyCHa74re7BF7bxL1m0K8rLUhKZjeXivv7x5QrLOuwgTIHjEEwaWmQgGtloy
 jYQoVoRATuYsJT9eNwoZ50XJCAXM+9ZzMtQU4YP98I+iHqDQ1AcMPGKZsjo8VC9h
 6PEthNLQRD20n6BlSxU19EtySgILne01ZcoOcxlrc+uBox/95dGQqpBMVtrvk1Z6
 6RtFfIJX65G9Pd8+oS6SWUhUhGqIyQrrTJYZNag0yewKAM+ZCACzeGO8Wak0t9ON
 BZJnQCWlGkORT8qHyQ0y5pXNX/wEw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021090.outbound.protection.outlook.com
 [40.93.194.90])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqa0kaqk2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 06:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoeQlOzYHvSeP9Szt6AG2cYFDVxDOX4p0HRdP0vwLy0pxxEp2FK2+jgmmHHcGXcxXwZ0HEfRmgch4arajE4SjcfOhtlpTPBnqP9N840ZghVJArWlL7J5rCSd/4XuHJGKFF5MQHJ31sU9oY8sh6+NYiO0ZpeushFAbb4W8mkbSJkWDQMo018y2/XyHoYlXPZEvi0dlWP7zWwJJBez16iHPpRSFAX1XVepenG0+HTEO2zybjDe2sO8kKur3H30fWgr1LH371emi/fWoxAvfVvckopG2Ves0EDIPO4nSvmzJ1/95Zadus8bk9+Tjxi6XluIMJ7FF5ZhUBnBpv1baXLKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aqlJ5BWxLsGv7WB0RmGDm2OIu4ksjgwLLlXPvBSiv8=;
 b=RM+k2i6Kxd2TMLO7917H5J8fLvu0iUW/zgO01jryyqeyM+9JckOyTEcKvhovaGuB3CQIVTNPRPVTIF1fJTsSEcHft6XAwwz0rvIvaSeDhLg9F9jyyILvCzaIHo0MN2f+7pwRG1lxpmye8KCRovWKWak9kUyMKO7ngEKLT3/EBloNsumD4U7kaliEnFUUD2oJVN9crXLYkAMyqALVPuxf8mbX1l7WmJTnXUWhdxXlhpcS1YODeKqyFo6CotULXrj0GxG+hNLASnjmqFPgCgehNG2PVtBL4KaW9cDV7MaOQCyH0yR1xcUW037og+HbVT9Kpo8ZF/VaC5SD9mSGlEakMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aqlJ5BWxLsGv7WB0RmGDm2OIu4ksjgwLLlXPvBSiv8=;
 b=vUXKMeadKU1VGoAyRMsBBOLR1lCyD+3QVishkygBIa/7Ed2SaJYl5ApTJso2Pi879FS0ARWBcOlP9KGG8BWYc7oiAKThJuW5Q4GGjUbjUDIb0jpK4JcWr6UNoHNb7EyLOIxuDrZxfEefTA0O5hEvpXeIXHqoo6z1vB+5wqlBznODiBn7nAzbKcwLSmAtmFh4FujUcz9mcff7aaj2/gbcFP2oUMfleXRajlEm4S8EdzOppGRNT4pR2NkEbBO/K7QFE7AYq/jE1Po3junrchTj84m15udpG6fGcXWtb5a9BPtxJGOwI/MW0aoLzDHZFBAz5XSQLMMmNhnthCV2kxBjaQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SN4PR0201MB8790.namprd02.prod.outlook.com (2603:10b6:806:201::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 13:45:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 13:45:43 +0000
Message-ID: <64588f90-a94e-4ae6-b326-58536c714b8a@nutanix.com>
Date: Wed, 16 Sep 2026 14:45:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/ioapic: deprecate version property
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, pbonzini@redhat.com, zhao1.liu@intel.com,
 khushit.shah@nutanix.com, qemu-devel@nongnu.org
References: <20260821145104.364283-1-mark.caveayland@nutanix.com>
Content-Language: en-US
In-Reply-To: <20260821145104.364283-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SN4PR0201MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b18324-c79b-4a6f-0788-08df13f8cdb8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|4133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: p+iFBn7JODU3F3455SrX2FKdPF/myjtn7CE/1lwheIreEzQynlr6V6PL1psHbSiPjy5t2GsvnQ1lrXaWETNsea5FTskeMJ2P9BBmP5f9ashgucHVz0AGm3mUU2QGkOZiJX09iLzhFz39u4FtEtCxp6qJt5hKYxEWe2SLb418EpwjaaHG82G9t+bn5KTQnOPD9nz6x1zg6O803rYxJi+F5k31+VmmuuSEXjQ53SBEMpV2CtMQVKoeDOqXxEmzzNi4dOrP6ndxubv8nKeIt7b8o1ig/vCVikgcSI8YJpwBVBV9xiXdFZ+1UpXuTnLYsXXhvXNXSLuiiRzT0cTt9S8GedhcHaBaaQlcfWi6mmxHy22m7VZwqkhrB1SWDln5MiRpxlpYayINGmT46Z+DwvqAhjaCSDnCHCh/vOS2qTp40eWHLVRwVSlgesG17GyRmWo1kDpyww5pofABA6qK9PkBb3Gztxk754X/fB0YYwKlTC4Ilf+fJm1EMbwC08/drq5jUaqhuf7FVj2khaXh9zTAqShPmGwRs4NN60copR9S+DzGjDd/eqRKbzhSzFJ79ZZ/IGhwKW2qNUDAXdl3hmBIf+fAlD/d2o3OMdw1s91yZbqZfIksI2RnRCfeX4MT303L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(4133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlU1Q1FKV3YwY0V0NFFCK1BNbzBSUHJhdEhJS0JLbjRIYTM0S2tmeXJlYUFm?=
 =?utf-8?B?QjY5SGd5Rm9oZGhRMWlYWlNOTVdlUjFNOWcvMWFKd3RnTjAybElXVGpPTHhK?=
 =?utf-8?B?cHFJU3FnaUdyeWJRamYzS2dTZnR4MklMS1A1QW10eDRaQVZVYWRiUDF0UlpL?=
 =?utf-8?B?a2dnd2RzcjBXb3N6eGo0WFFaTHBSajlEbk11U25yeWtLMy9haGhsR3hVZnM5?=
 =?utf-8?B?L2JlYjluang3T2ttRXNBVEpzaTZlVWRFRXc1UFdLRFdnR09uR1JsQkE0R3U0?=
 =?utf-8?B?eExyaGNzSHVqZHB4ZktTYkZxWmI0UEZ6ZjJ3dldsNkU1ell3cndtdGNvRWhY?=
 =?utf-8?B?blVXQm03N1FxelVxbHRER3ZJTEFwc0VxYVpVV2g2ZkZyU2JYMktMMkxLcFpO?=
 =?utf-8?B?WTRuamtSTU5UWWk0TXhHL01tYTZJbFYwbFZiY2cxRjIyaUZUYTdyTExyaytX?=
 =?utf-8?B?d2MvN2tCVjJpM085eVZ1aHF5b0R4QWNtU3B0cFg4N1FJbHlZNWJVWXpzVGsv?=
 =?utf-8?B?V0V2NEpUcGRZTTNxN2F0eGI5WnRTRCtZK0FuV2llczJYODQxUnBOSDU1b1I2?=
 =?utf-8?B?T1JCeTZLMHFFZ3JTNGYyMTlURHRzaXpvWGFWZmdFRFl6UjNycTNOQjlRR2R2?=
 =?utf-8?B?RWpDbFpTa0F3RElmZUxPQmc4a0tCR2lmZ04wZXB5bEFha1JWdDhjVURMcldE?=
 =?utf-8?B?aGcxc0p2RktGY1RVMnlGejVXT01kM2lZL1B3MklwY09ZSldMRVFIVG9tUkhB?=
 =?utf-8?B?bHR2UWFUek1TaExwTWRMVFoyNjJBUlZ5c09qUVhNZTdTd0UvZkdla3l6TFRW?=
 =?utf-8?B?bVNSODY4Zm1oazhNeUg2MUdjMm9Pa0pSeDBKQTljU3pCR1ZGcHgyNXBsUXd3?=
 =?utf-8?B?MjJieUdlTmVSOFVZdTBiV2k4Z3hCcytKYnl6UTdWcTAreGtpQk1ldDVMdG1Y?=
 =?utf-8?B?QTZseThJblgvandmWHYwdUEvUGFRRlhBdHcvUkw3M0RSeHpURGlTV2lsMDBS?=
 =?utf-8?B?TGZraVBERmVZMEIvVDdzOElBY0EyUUNiVXlqRUlIK3FDN0RkbytWSnNGSUk1?=
 =?utf-8?B?SWg1TVM0OHFiSTNKTGdMYmh1a2QwYjFnM0VJNGVSSTFCcitvKzkxQzVyVzVa?=
 =?utf-8?B?WThuUGVEYXdpZkFBYlRIc1FzeHB0Y2RaTjh3cDErOWJaWGV0cVM2UmMxZ2d1?=
 =?utf-8?B?M2VzY2dPM1ZhM1N2aE5BWThoMkkvVExlUDhKYndPVlhjYmd1R2lweDUzWE05?=
 =?utf-8?B?L1J0ME5QbDdsYVBWU0RWRFdoNHFDSjJ5TUY5MEh5Vk5VVUJ0WUtxTWlpVThm?=
 =?utf-8?B?SS9BMUlhUEF4V1ZOeU80SXVSM3pxRjNQdnJaeGNUKzZrUWlXcUx3VGErOEEr?=
 =?utf-8?B?VDVTT08zdFZnNkY4ZjZhZ3l0eHpqOU5PMGlhdEE2V3hTYXFjemQxZHFtcnZw?=
 =?utf-8?B?OE12MjVudkUzYng0WVVsLzB1S3doR0hBRlFVR0lPRzRSbklvbWM1MXJLczU1?=
 =?utf-8?B?WGp4MC9mV3dOdS9pR1lKc1B4bm41SUIyY21nTzRmVmp2UmVsREdoaHMvQmJn?=
 =?utf-8?B?SDZuZld0R2cwY2VTUE5RNEM1RDRXM3RBTXg2clJsUkVBQU1xQW9aNzF3QVVx?=
 =?utf-8?B?cy9XQXpqZ0h5ekk5QXdWbkZOdUdOWnVmUXVpeHF4alhhUi9pVG4yeE9ISk1o?=
 =?utf-8?B?ekcybGFyaklrUytpMWpWSXhST0dwS1pKQVZkM0ZjVkZvbklkV2lNTjRiaWky?=
 =?utf-8?B?SzhkdDhQdW1FZzVpbzBnN29nQ0tZRUF0QUhNMEZlUWFiT0krQm5SS3R1UzZi?=
 =?utf-8?B?cU5iSVVSYmpXVHlBQkVZSjVJM0ZDRWFkVWY2MC9GZU0xNy9zOTBpcDJLSy9N?=
 =?utf-8?B?NHZsN0tuL256MEVQYlpFaHZnWXU5dmNjQXBCa2RqSndsRlh0VkswcW1HcDEy?=
 =?utf-8?B?KzlITGpjVUFxMk5pRVJ4QlF5SzVNWHMvWTBrOCtkUURvSWZPc1kxdGNOcjVT?=
 =?utf-8?B?Zkg3Rm9WblVIbTJsTTY5MWtJbDRGRGIxWnlNL0ZoWkQ0MGxHQTZRN0RaZDhz?=
 =?utf-8?B?WUI2dndYQ1JuaTdBN050dVZycFZHbDBJbkdVb3o0RkNhTGx0Z3B6YmJ1R0lB?=
 =?utf-8?B?WDJ6QTFZZklSYVdCaXZQRHhaWExGcWJPMW5obVJaUEdRZU82RTVRS3RKdm5E?=
 =?utf-8?B?QUpuelR2bjF1OUlhWDBwTVBIaFBPdWlKQnFjK3RDWHJCM3l0UjRXYkxWYjlW?=
 =?utf-8?B?MnlvYW9UdlhqNCthWElVaXhDS0ROTnNwVGd5TVVwNWR4NjhMWVd5eVMrRExR?=
 =?utf-8?B?QmFOMG5vL3RGRzM2RlNub1padlNPQU9nZXI3QStVWlQvYlRFcDJadkx4VFVq?=
 =?utf-8?Q?gvGsSjX89mS4+iDo=3D?=
X-Exchange-RoutingPolicyChecked: DuUpI/0nJdnjAm2gt8dSuBBr8omyWTOuOioqVg4aeq8cb86HAWfOzXol7vHpWcS1GYH/+bHhp1udmotTb8MjmYRnRyV6LtOCkmCd35wnfdi8oEqDXHTisDUidN2hrEL3G4jsBp9n2+z22SWI9s1WWgiTjRtlkeoeEKB5OfzbvpZfLaSbQlytgX4zyVV/YJfcWW67G+v6yMTiGh7hpYtWz5U1unxjScFsrw2Z/sfNm/RNfqzaYZ2gW2IiAmy5ab6wAkqLHONQWw9YijeSv20/bvN/e+tXhpcvKpl21D1MLl19XdEViKqiNl/QIREVPqBZ5xdDTKFPxTkDrh0G7hDgOg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b18324-c79b-4a6f-0788-08df13f8cdb8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 13:45:43.5615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsHa7lAN/5zPS9WM+MwgZYX7ZFh5P0Ncr7DQf8dYiMC1+k2xWPG+8Y5bVWito64WlcyX8Y/54//Epzr7YjFO+cmrKRRU19rwBocWsTHlNqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8790
X-Proofpoint-GUID: n52b_LN91Y6f5MYJUudf6iN7Vx_iDNL8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE4NCBTYWx0ZWRfX7ynxGyaOAF7R
 mrADUjrwTHCUaRL+vMsxlsjCz6DMr2yQslyrZpO96FO1ZzwRHDommQz4JZSglf/fzB9fiHhenjV
 dPtgwrdqbtGtTA/NH3ptgcbA1X/bcLs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE4NCBTYWx0ZWRfX6aiJlvZb3US6
 rdFcGz5HEzNJ467Am1xkVQjY9QNhIlIUkd26fTKKTrmhDToQaY11I++JAr7zY6ilL8QCKQzZHI0
 zXSKpLXODPLtBvFrv4eT2ZEnJ3jpNzH26XCA63oiMG8QxnkA2bXupnUQfEpArNnHud7BPmX+OC1
 pus/pmnIWF1bjtEihgkAEPROOBkUEGv0h+Z1+g5eHpt4vg4IGOI/bxfEG3f1UA4/8/QbgUGUuvu
 2jgBQVcItAMKw84tKaWqePK0dYtUgpEOdVw07b+ujMagtNvwPeC5RZ6YsenheOI5r9fXULIBdAO
 g+szx+Noze8EdkaO2xt2/PLAGv0KQMbL9eIn0Dokmo9oZJd8rkkvZV7or88wOkz1vyh6MuKLc92
 QLgYX51TmfymGgrkPu5sPa69FdlBbxSP1DoNg9epw+9vmZ/LYiSEsgSfkApKVDT4HhGComcdNKS
 6ya1BRLVkrOYyIO0cEw==
X-Authority-Analysis: v=2.4 cv=P46vFSAu c=1 sm=1 tr=0 ts=6aaa9d8a cx=c_pps
 a=1SMuVRNdJx3IktO2ty4UNg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=mDV3o1hIAAAA:8 a=GaQpPoNlAAAA:8 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8
 a=puSrLdfIvoSAAjfrCw0A:9 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-ORIG-GUID: n52b_LN91Y6f5MYJUudf6iN7Vx_iDNL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/08/2026 15:49, Mark Cave-Ayland wrote:

> The version property used to specify the IOAPIC version was originally set to
> 0x11 when it was first introduced, but has been set to 0x20 since v2.8. Since
> all machines before to v4.2 have now been removed, this parameter is no longer
> required so mark it as deprecated pending future removal.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   docs/about/deprecated.rst | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> Following on from the discussion at https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2025-2D05_msg03027.html&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VQIG-iu-1g3JyKdn64SEj6Y6dVqbYfE1Qg5Y_tIeWrwR2OCa24MKUVV00MIY_5Pz&s=zH9Je8Y209R_2E3w533VXDqbRP-uhhuILVcvmoCkXdM&e=
> it was suggested that the ioapic version property should be deprecated. A patch to deprecate the
> property was proposed at https://urldefense.proofpoint.com/v2/url?u=https-3A__patchew.org_QEMU_20260210032348.987549-2D1-2Dzhao1.liu-40intel.com_20260210032348.987549-2D18-2Dzhao1.liu-40intel.com_&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VQIG-iu-1g3JyKdn64SEj6Y6dVqbYfE1Qg5Y_tIeWrwR2OCa24MKUVV00MIY_5Pz&s=yWQKfxQqB_u6jU-CM9IYW1HqfEV6C3rUvz1pWzavjTc&e=
> but was never merged.
> 
> In the context of Khushit's patch at https://urldefense.proofpoint.com/v2/url?u=https-3A__patchew.org_QEMU_20260804091827.3203086-2D1-2Dkhushit.shah-40nutanix.com_&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VQIG-iu-1g3JyKdn64SEj6Y6dVqbYfE1Qg5Y_tIeWrwR2OCa24MKUVV00MIY_5Pz&s=rM6OQKsZNIdWJwPgdGzV6Y5ngrZQIxJecIlXXX8Wr9k&e=
> it makes sense to formally deprecate the ioapic version property.
> 
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0c656a968f..bfe7240040 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -305,6 +305,16 @@ the addition of volatile memory support, it is now necessary to distinguish
>   between persistent and volatile memory backends.  As such, memdev is deprecated
>   in favor of persistent-memdev.
>   
> +``ioapic.version=xxxx`` (since 11.2)
> +''''''''''''''''''''''''''''''''''''
> +
> +The ``ioapic`` device ``version`` property configures the IOAPIC version for x86
> +machines and is typically set from the command line using
> +``-global`` as it is an in-built device. It was originally set to 0x11 but since
> +version 2.8 all x86 machines have defaulted to using 0x20. As all machines prior
> +to v4.2 have now been removed, this property is no longer required. Deprecate the
> +``ioapic`` device ``version`` property so that it can be removed in a future QEMU
> +release.
>   
>   RISC-V CPU properties which start with capital 'Z' (since 8.2)
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ping?


ATB,

Mark.


