Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9C9CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDak-0003mU-Ue; Mon, 12 Oct 2026 06:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGDaj-0003mH-OS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:49:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGDah-0007r6-DQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:49:13 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8Kr772698669; Mon, 12 Oct 2026 03:49:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=2WuatbzrDRA+zw9dJ0d6/9J0dE5mRwP8MVtGHToXS
 HQ=; b=qd3y1n/onbKw4GZIomuzFGQSlwb1g0rV66FqJ234O5aO74ukr4sgCVkuK
 8DQIdX3FvS1YlQKFZzBXkKpeHM0aWb7Sfpvz91CwzGIY4frNs/5icGjrLGCrgMT+
 wbghUJmWAFsPNe6RsUM5zWnNUI7i+2ElQFRTM1EacAc68dxyZTyyWNk7ze1urQ1k
 mlC50sJBcF+XvIkXJ1zbFUc4GNrS87iy45ouFWI3v5VtOzFM0/s9gMjiuQDo1qht
 jz3RiAWeEnV6khVgOAkWR331OMrK1uQOYRow9z6IY8T0s6a/6Kva/bV6T7uoqn+w
 64/HozJm81QLzkwoHTeKO0rCM4iNA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022142.outbound.protection.outlook.com [52.101.48.142])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4h7kfdk2cs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2026 03:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENL0XGGXBzsoTABX0PAFyRZxSIHIaxZgia/KfPG1RdB4t7y/VS6zBKigOM1HEGr3Vglsb99kuVqTDPN9MX2s8QXSOpTt0LLJtB65I8W0GTX5iIPJwnXYByVsEflQNScsUNuOhgJe0JTBjW7m+JCwM2kql5a4b33I6uIA03bYCO/OHIJgq6WtUwL4NS3QTxK36sFeAZP9mKOEubXOZpjC4vU9HzCIOj9bt0pr7F34Nd8/ZulSoxRiTKaxb1+qzlY7XsHlzQb8GhBF8wKewK9I5fRUiuEPHwg0NuWpW9AyGWqSC9GYCiQdzJL1hvZLlIbdPcFutSmz7BVJJdhFcZOvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WuatbzrDRA+zw9dJ0d6/9J0dE5mRwP8MVtGHToXSHQ=;
 b=rzkpZ+ctxiTWP39WGrXZXF3u2rWLYvNwWFFoBADB5rjTJ3qFnm2p1txEKHs1Eovkm7DwZBhCeGdAv/GK+1z3wExR3TOzj1z+1KBrho5pDjXgz11HsKVcspm1Zp79V2PCjNzo/KxHGw3Ta+Uul5Ywg8TI8EkPeStGq/fIlMGSKur3ta5NDfie4kwC8PYg4utTUklh20Ir/qFTC0ipYud2K2aIvDsz3AzG5RuqHPL9WlNw8uxkP/seuCQz4N/RSj9qlL78giABEx95eWCwp5hpYGGgcHYnFk1Qbhe2+OdokZaBAJLsFgVJEJTWgh9rQ6uqxmm/aPRp9bUckvB3J16ung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WuatbzrDRA+zw9dJ0d6/9J0dE5mRwP8MVtGHToXSHQ=;
 b=gsaOo1kIWG3fQMIvfjWkW+ZUKqDgrgAPRlQs4wj+BuunCtPLq1ncB8brPeHbLJvWo4g3rvsQtuFlrbT8T+KSGOuMmTjuINoJ+c56lDw/DFsiJHwPgiFxovmkaPmA8cuQEeL0feb7YUsjPokIrKq/N4kYTk42Quj3hLD/KvdGT8Kmt+3/DoivoxnGAJsSK5W5pKvd1zv8lz7zGQq8X1qYKGIGATyNJtOfIZ7aeaL9J6/0u14ONvMDWfa5NwdKnC7EUUDNqmxyQO6uUnzZW9rsjYo09sg8a+1GkosWljA4zSYLWPX8z0TBAiPHJXM9qA07kyDvq8PejAhSUwbVXod1mA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8367.namprd02.prod.outlook.com (2603:10b6:806:1f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 10:48:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 10:48:59 +0000
Message-ID: <3e1d30bd-0c4e-47ed-9970-6713b8295071@nutanix.com>
Date: Mon, 12 Oct 2026 11:48:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] i8259: improve qdev PIC modelling (and misc fixes)
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Language: en-US
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e83544-84e7-4e32-eff0-08df284e6bca
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2tIHwo+cbOnMCuNu32GoVRYFukmquiGmlIpQS+Wwd5HLKL6NHvz2pWyCnyUxR/dvQgWZlvYcGcAsQBQrgUBrLjIEP/KOwkFtfc8IMQAvqYzglYP6fNq79lgdrc2w7/sUbbDEniYudIo8iki0vlGWEH68XvQkbhUL2JU9+MRMyFfWtyRBIBNlCCyL/tas5edi4dedO9gp7k3CZdYIklcsR259yK2VrguGKHPWuf4LJ75Dw/23N7t8iWHBvAjtMLxm9JkE2ZuPW/cbD9R6cFUj5kzRpgxzT5tY2L8H4CbxXm/0Z3otfVyWLZbYQKEpIKybe3BGveqrJptXtk5mjwJpF6jzUuFI5gUlh0cZji/G3V0gIjbdc+KTI1lB3/MiMnSZrgvmsTGRk74/QEiuamjJEFLwmqQhS8QYYFUufRqwOb2VCxKBbNJSi+isGisUmIbiyJ3VhTpzJNuBLIzjyvp62B0IKrTnG5kDyvZh9IGCeI9qSvyWuN0awCxV9TxyqvQbhVv75m8e0rVPseZWeRP1+ynvp8BY+3Z6XMbsY7LGd3SsIj92Xxh9Uc3sCJqj4HzIvEFNB/yFzE02NSmu/PkM10CEF+wIU/Lr/g0EtmZqwRmRTS7BscH2DPnGclFLh2TmyiWn77AdtyvtrqxEBmB3mP+VK5J4+kRcIn0o3oqZ+iw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjMvYWRtaEtFaEx6Qm95ZUI0MERJVDJMVG9CdmFwbE1LanZRSDIvWVZLMG9K?=
 =?utf-8?B?TWxtUG5OUHNLZjJhK3h0bkt3UW1wMk91MTMwbzE0REdudVdwQkxIWE0yWmV6?=
 =?utf-8?B?ZzFxYVNzR1Zva0hFd281SlRnZk9uUXdHNStyMi9FQW45aUwxNm5JNFkyZGMr?=
 =?utf-8?B?VEhFUWpJbllVTktGN1ZZdis5OWNtb3hSVjVKdHVRenhCbkNIVkRuNHZyMDM0?=
 =?utf-8?B?OUNWOGRMR3ZsNnNCZEduMDVIZTVodGIrQi9TbjEwcU44SDFWcDZoOVdaeEpl?=
 =?utf-8?B?dERIRW91MFo0cm1KOElaUWJsbjF5bTI4dThERm1vUW1DSG5uaG0zMkZZZE1Y?=
 =?utf-8?B?aXNzengxSVNIbzFuVTljS29DVUNyMFBzZ29rQWMzMmNUOFllejd1WFFpZzc1?=
 =?utf-8?B?MmJXakFWMkdCMW16WWVOelpVNkduSXZ0VmoyMFdRNkJLeXd3ejJqNzFrMVpZ?=
 =?utf-8?B?SC9acHpaM2I4Sld0OERJVFZXRVVxSWtya3lHcm1HUTdaM01TdnAxYVdtS2Yy?=
 =?utf-8?B?STFmUUV0YUJFUmozVFdhWXc0Q09IcnBWNTFOWUxMdUVMYUVZTHFmSmkrd3pS?=
 =?utf-8?B?MHB0WVBaYS9IMEFzeFhVUWJHNlRWbERub3c3NFBMUXlLMllJa2J1UlpVYVd1?=
 =?utf-8?B?UzlKelJMd2w0T053ZUd2bFVLbGEwN056LzNNbENMNE1BM0RWYXAwZUtRb3pp?=
 =?utf-8?B?ZnVBMmZZZG1MUFVhTitwSDNtTEFTbTF6eTd2aXdmeXNhTjAvanFRVHZHMVk4?=
 =?utf-8?B?cng0cUxQKzVhL2RINEUyMnlOeEY3ZlNHTnBkTDgzYnZzeHAvL0Z5Ymx3dGZ3?=
 =?utf-8?B?OU5RdUVKakpIQ3pTcXRHRTltUERIdXdkSHE4MXR6T1dmcWVlekEwN0xKVkRY?=
 =?utf-8?B?VUNNQ1plSFVBencxOFF0czBUdGxUUXF2ZWIwTjJtaEMwU3d1OVdxZUxnT25l?=
 =?utf-8?B?L29CMHhQZEdmV3Z6Vmc3UWQ3Zk8wZDIxdVJnVXE2MEFwQWVoQWlRbEZwOGFz?=
 =?utf-8?B?UWRhMEFrVG5aa3h5Q1JYaFlXWDdyRm5YMTZ2aHdoQ0FMb3dhVlpWekdUR1Iy?=
 =?utf-8?B?YUowRTk0RUFtKzhkNHVEZnVhMHVZT0l1ams0OXpmcE9QKzlpc043SzhKUFVN?=
 =?utf-8?B?M3N3aEQ2WGFjVXFMWnhJZjN6cDBZV1hIRjdOc2hsTEhuK28xSkovZkphZzFt?=
 =?utf-8?B?b2V4Rmo4Yjh4S2NFWm52NU5Wa0FxWmNUVGpPNElhKzBUYkJpbWovWG5DTjNR?=
 =?utf-8?B?bmE2elgwNHkvVCt3bk9WajJIQjRVVUkyMWV3M0o5Y0g3MkVYOW8vU3VYcDlT?=
 =?utf-8?B?dHVDZFE3Z3dwR3hKRTliVmdrTVNnTDk1dEJEajhkZjVQYUx4cHk3U2Zhc20w?=
 =?utf-8?B?UGw2TGJrV0ZDYVRWOFhYYXlySUtyb3dyM2NsMGdRNkdoSjNYRDNKZ3lXVmZV?=
 =?utf-8?B?ZFAzc3cxWHRTUTdLS2JId05LcUxqM1J0dysrNkdKeitkS3pQdUJPcTVteGdy?=
 =?utf-8?B?QzZOVTU3Rm04WEhwZ1NmYXlXUlVCQVhFZHNQK0FwanplYlJuUUlkaDdRaE16?=
 =?utf-8?B?d3NDdHZDT1dnZ2E4aGR3Z1BIUHhLRmJUUHU1dFFIMXZublZNc1dUdlNtNEt2?=
 =?utf-8?B?ZmtYNFlKRmRiRjNuTEFPdVk1WFBXRmZMMzFNTjRvaXBOTXhtSVlqQld0aTBW?=
 =?utf-8?B?V2tiSVJmdTFwSzhCN2xiWmRWelp2WEl1bUpsYTZBTEVMZ0U4Mmh4SmRyZW5m?=
 =?utf-8?B?MHUzKzJheE9NbEZDcHFMRFMzVDBHSGxLYjFIZGttOHgxbUhnbzhweE9XcW1n?=
 =?utf-8?B?UDRvZUcyTE5INHFZWlgrOFcyYlowbHM4SGZyTDh0am1IaEhseFJRZUs0NmhZ?=
 =?utf-8?B?dFVxbW1GMmpZcytYVVpyemlYT2hKNEdsL05kRE40aW5CMzBScC9nam91alFP?=
 =?utf-8?B?U0ZtcUh2S0JsUGgwZVJjQnYrM0ZDdjZQdXM5clNWZVF3Q3FjSkpPRmJKcDhH?=
 =?utf-8?B?WStHQVRURlMrQTFFSGJ2MUh4Vk03eTVZMjZ6WEtPTG5TTHVNRVpseEZ4K09n?=
 =?utf-8?B?RURXbVg4OEFGMkVxempwa3FkT1BOeDgyYnpZaTJPc0VxTDA1clJsS0lHWFRy?=
 =?utf-8?B?QTkxRzNuY2w4dXRVOWNRbkFtMWRhL0sxVFNTcjI4aVVLN2xGTmY3YjJDdWQ1?=
 =?utf-8?B?VW5UK3NQTjNYUnlpY3FqTm1sSVM3TUVveXpMZEVNK29hT0Y5MDBCeHhhaXNX?=
 =?utf-8?B?YzNTM1JUTmpCOHQwQmhqZnhzb3dlb0dnalVuQ01xQnpOZjhUS2p2ZWtCS0li?=
 =?utf-8?B?RG5rRVI0T0o2ZDY4elliQkN0cjRGUzZzbFJrd1JTT3dha1RkeU5PMElzQzdO?=
 =?utf-8?Q?MmvFGfb04kN5Dm9c=3D?=
X-Exchange-RoutingPolicyChecked: A/5uju1BgF2apdBkF/odNodm9/OsEjiCixqDzjDtPmH5irqur3BhYUZNOfklgKz3+9onJLeXJqKkhZ/wvd3aUfafpYNlcp1fFjmdGMZlqdsyoCXvn7Ga2hBQzZRP+lu47cSqewm/gAwflN5Nfl08ME7N0ako6pOOi9Gx5dRD8oZq94xwSxR0vgUlbID+/Fo6xb567yb0c5iOTURcG3sucD0nqelUTLztjhjNnWs06Z7PUKKXDQQDaimcemxeNnO30AhahGAl6m0HqaQBdxbPDdoM9FADpwCllcFsG7czWXI92JR08vs/iY8tkiEbUvoyIlWJff4uf42Sxua8ugAIjQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e83544-84e7-4e32-eff0-08df284e6bca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:48:59.2968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fiRkg9ilesidDQGnHPGfYALbiu9obVY+P4qCUek+NTIVy6RmgVz7z7/gRSVo1UXdW2DLCNXrNdfdiGD/Z8jChFpFYzS0+ZWMeqe1WWOHa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8367
X-Authority-Analysis: v=2.4 cv=P7+vFSAu c=1 sm=1 tr=0 ts=6accbb1d cx=c_pps
 a=FtnwO7voBM5XWKbPwlLLuQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KQXPNtfR79rSjg9_41cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YxEQLDjbDyeKnl-yzkjBbcPjtzpLtw7Y
X-Proofpoint-GUID: YxEQLDjbDyeKnl-yzkjBbcPjtzpLtw7Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MiBTYWx0ZWRfX2J/sI/lSgBdO
 2nKWjyJoZqiJSMpmgbvo83SQR7gnbtgBy28yxZFsMUXkH2xQQPn6I54u8Mdt+3HspA78Dz5E3WD
 3Iv+2QOCQwFwTk+NuxKh0I0yZTPVac7Zmr3UxhM94DLtzP2g5OoP6sQXJqntw+y9844y+SRe7yp
 Brm4livqnb1nD+zdazQEULxhRqcGlXgc5T1bu/1vzk+OvZ+26ek/ShtnEMbCVgYCKT9NiTb8jKX
 zqE1ROFdIC2CPCEXvlMvtHXMCyDEKYzpf/DJRQitySnxZRUj3ls6Saatx00b7CVtZaFJdCD2HMO
 Wuveu5aExUZZ0alZYilVDlDolNx1CLpJp/LpwDjSyJ2J8sYysWkSmbKOKxdY8RYA1L3RTmkj18M
 m6F+hd9bxnCpFWmVvbb2xPqWkJdy8AwnFFnJMndlkvJD0YlO9xd2Y8i7qan3uZtqd18eJrWjaWI
 bKBjvevUVXu3hq+cbDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MiBTYWx0ZWRfX47NBYlfIANnI
 zLrsITh1XElj42uJWuCgzqSd3yz7SNEYxom61Y70KvsRZ3AhhU81d51R7t0OZHGGwIPTtHJ4Zn3
 gAlJhZQOVb2gZ567oHikfxalHA06qw8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On 16/09/2026 11:43, Mark Cave-Ayland wrote:

> This series attempts to improve the modelling of legacy x86 PICs within
> QEMU. The initial aim was to have a qdev device with one output gpio, and
> 16 input gpios representing the legacy IRQ lines, however as I went about
> trying to model this, I found a number of other inconsistencies/bugs: in
> particular there seemed to be some fuzziness around the functionality that
> belongs to an individual i8259 chip, and a cascaded i8259 configuration.
> 
> For the purposes of this patch an i8259 device is considered to be a single
> i8259 chip whilst a PIC device is considered to be either a cascaded i8259
> configuration (emulated/KVM) or standalone device (Xen) representing the set
> of 16 legacy IRQs and a single output IRQ.
> 
> Due to the updated device names, there is currently one visible change in
> the HMP monitor output for "info irq" where the isa-i8259 device now appears
> as isa-i8259-pic and the kvm-i8259 device appears as kvm-i8259-pic (see
> patch 19).
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> 
> Mark Cave-Ayland (22):
>    i8259_internal.h: rename PIC_COMMON to I8259_COMMON
>    i8259_internal.h: rename TYPE_I8259_COMMON to i8259-common
>    i8259_internal.h: rename PICCommonState to I8259CommonState
>    i8259_internal.h: rename PICCommonClass to I8259CommonClass
>    i8259.c: move parent_realize from PICClass to I8259CommonClass
>    kvm/i8259.c: move parent_realize from KVMPICClass to I8259CommonClass
>    i8259_common.c: use i8259/i8259_common prefix for functions
>    i8259.c: use i8259 prefix for functions
>    kvm/i8259.c: use kvm_i8259 prefix for functions
>    i8259_common.c: convert to use DEFINE_TYPES() macro
>    i8259.c: convert to use DEFINE_TYPES() macro
>    kvm/i8259.c: convert to use DEFINE_TYPES() macro
>    i8259.c: introduce TYPE_I8259_PIC device
>    i8259.c: properly cascade secondary i8259 from primary i8259
>    kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
>    xen-hvm.c: rename xen_interrupt_controller_init() to xen_i8259_init()
>    xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
>    i8259_common.c: remove unused i8259_init_chip() function
>    i8259: move InterruptStatsProviderClass get_statistics() from i8259 to
>      PIC
>    i8259.c: switch isa_pic from I8259CommonState to I8259PICState
>    i8259_common.c: remove static irq_count and irq_level variables
>    i8259_common.c: add missing 0x prefixes to "info pic" output
> 
>   include/hw/intc/i8259.h         |  12 +-
>   include/hw/isa/i8259_internal.h |  21 ++-
>   include/hw/xen/xen.h            |   2 +-
>   hw/i386/kvm/i8259.c             | 167 +++++++++++++----
>   hw/i386/pc.c                    |   2 +-
>   hw/i386/xen/xen-hvm.c           |  40 +++-
>   hw/intc/i8259.c                 | 322 +++++++++++++++++++++-----------
>   hw/intc/i8259_common.c          | 171 ++++++++---------
>   stubs/xen-hw-stub.c             |   2 +-
>   9 files changed, 477 insertions(+), 262 deletions(-)

Ping?


ATB,

Mark.


