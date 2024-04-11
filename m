Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB3FCD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 12:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rutZW-0003Hs-Na; Thu, 11 Apr 2024 08:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rutZU-0003Hk-BL
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:30:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rutZR-0002MH-0j
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:30:28 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43BCJ5Oq029460;
 Thu, 11 Apr 2024 05:30:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=P+S7mZh0t3Iy
 JTftKaxu/fNhimCziBw2ZSg/JoYp/W8=; b=LRpFTFQV6yaqI1ozY34dCdkLwN5z
 siOP1rs4TUeweX1b9SxshPvR7cvSwioF7FdNwB0RYEpnc6bOhPV+KE5M0JJ5Axpv
 bvDvu+GFnlSoNGC/h5H8v39hlFFSj5gAnfmGhxQYBO+2qDkNJ1300ck09y3DySK1
 LKwA4UmiFpRuNq5XvnUyKEtpFJzZMDxqNVBgBaX/N1reGiJXJQN9hrE5VJkYyUeB
 jzi42hFSrtMVKgOtNxFeV+K0Szv7iREPnnAOPzn+RYKE0NMXq9XBY+Cnl+URnjw+
 PNlavbch6W9ZYmfmAhPWAMTM94JJkCik9MZxQPV9Y2THzEym/f1oOJz0Qg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xct2k5p2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 05:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IImzwBHiqwABL989syyWVIho0/nM+XE3f6G4qEo4lZZOFhmnKB/FkplEWvB3trbaG4ciNJVCyiJ9pgVvf5Gp8zY6ySpthXpHG500V18PKLJ8xKCHjD9mZxL/2IXZ5bMUcSoayX+Nbl7U3NWHzgAVrcO40m5FNJWsidIyfNvLMzPyLuf5mSW+AsiJjZCtM4WbP0s8luQo67wP5dhR1Wqvd+b3serTPikAZiKdx2xHRpoNscrHSlkZYydy8/zpWnBFYkXb3OmIrL0wQiMiS79qoZBmTfpRS6DHtfeW3VzH1rsAhXY1VsjS3fLZOCNANLr3XsEZSxTn073TiZ1PPWiiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+S7mZh0t3IyJTftKaxu/fNhimCziBw2ZSg/JoYp/W8=;
 b=Ea0sPAnNxZvCgwEeqJQIiVxMPZ72/PH4FWn+ydlM57M6m3DKd4PL/UTuyLkFQVK0fvtlaU2TBgwiAF73sw88QNRossrd2xYzNsBrEdXAT78EheC08gY3FJGecx+hfYC4UeGbllrZ53pjmzef4gneL0kk9GlxWBowdJAG0MYfSqvkjmFyGTSpZNjydxxtLgAz12hV3kzQQcxyTTskZnQVF+x81z2CXnQ6vZOI5XF7QYWf0bwaPHlj496Uic0BwAk748bK6WRRqJ+T3YEebJqtUBAW/BXZ0WwBERWmvmJ5GJDtQb6jkQ2DxcCNdGR0FcW68I6hfFJKuy8wrEXDNHrsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+S7mZh0t3IyJTftKaxu/fNhimCziBw2ZSg/JoYp/W8=;
 b=qVVOOcCkQmfbDe30IP/tkvgHiNxq2zIgCHoHIzvxfOeaMQMkyoN3jtk0kCIm0zZztXTvplNqy+ebRe3YsehHLHcPuPWDuWIoUOM6/lcMFGH2kxrASB28b7cW9tGDTGpNbcVDwMdsX8Bg7gSMXB7cAtEypVcADvykryj0KAITCYTiYToLayhPfMd6xNSvfmYXVypLzgfpcVwz7ojNX1E8GXukPH6k9WsryrkHjizLWC4nX/8g59HCLGdX9RWUTpqDjJMuNF7K3fZUijEAUbhgESgknazP+jRQ1weY/tRI02l60dWXU06dUxn4btN1wEHS9hqoTSountsXxwDKR+lf6Q==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by PH7PR02MB9337.namprd02.prod.outlook.com (2603:10b6:510:273::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 12:30:17 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 12:30:17 +0000
Content-Type: multipart/alternative;
 boundary="------------4uK5ynU0wvRPBACCCT6wmTfH"
Message-ID: <951c9fde-39d3-4cf6-9c98-9942abf617d8@nutanix.com>
Date: Thu, 11 Apr 2024 18:00:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none() to
 use new QAPI syntax"
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, prerna.saxena@nutanix.com
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-2-het.gala@nutanix.com> <874jc9v066.fsf@suse.de>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <874jc9v066.fsf@suse.de>
X-ClientProxiedBy: MA1P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|PH7PR02MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: dd797c07-e60b-4857-77e7-08dc5a2324c9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C34yg2k6PdZY06fj+Czt9iNeQG6BaNFbwunN4PZdxONwA6eNrWb/SacSHP68u4A1Jow+kH9+uikK5BSljZ5u4wTa8ioq3x+CWZYmy+JGkxcsVyrVEjSNqzR86UmmUOgNU+MfIndYEKcAdAaSUImzKXISVtFXJMp8SjwnFR9PVh1qyV2+tcBgwDgq3TmZj++YcsNbHpXaY3bfXdZ8xWWOWBXczxbRPM/rmhdcYRZty4RM4NQdpO9rW5+4oWbueZMHEO+egs0Cnf0CIs9Sj7SX4lzGFfJvI3Bj5I5gcORmQYNS/q/cEL3qo/CJJKOYuasG1L/fxrhKKqwxNfF2q6DIPtTUw+T0r0KOUb0YGEunQKcjkJsW8/iES1t6l5yrPScAz5VrdMJbR4OiO0y+Uoey42TEzCBMMtataaI+x8NIO1Dpcxj3Jykt+cbqUxqqzpzkBbVmv4f7JgBUx2uh6eVU8GSjfjzP5G2Atgse71ivZ/3S5SfpyCcQ4vizXVWmvvz1UNl/OlJhZmUBzTfeRN8EX75aZZ75f+MLWwvdRkz4+fhmGnkCC9+3Bn5+8pxWU5ORRp8nIbq++20cNkjDkiHNccjuIdATpgAv9I6oiAmpV6c1knuw4V6YtZyDYFIiVYfCljwf4HbP90ilf/2cr8xDErnkRTNlgAMvo75ZJU9DVSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFnUXhORnlqS3RQS0owQWhSWGhWSzFRR29DYk4reFMyOGo2MlNoNWZYR05m?=
 =?utf-8?B?VmVIL2xhSGEzeHpnbldBNlk4SnkzMXNreWFPQ1RCOVV2ajZSME9ZNmtJUEF0?=
 =?utf-8?B?blRvdXBYR1A2TjFoMWh6WFlFVFdlSExMdmN1RWIyYjVuVEp5bE5hUytHVnlI?=
 =?utf-8?B?eTJkV2dPTUJDRE1adCtSVUhyVTVNM00rdWYyanFiK2tPbU1oWGpsSGRxMm5w?=
 =?utf-8?B?RklDZmQ0bVlYSTNqa2hVbE9hS0w2T3ZoNUwwVnE5RGg1ZGlSYnQ0Mm9OU1VE?=
 =?utf-8?B?c2tBVWtPMzhDbndUekhYb0s0Y3FLcW54NlpWMmFrNTk0cm1iRjFPTHM5OGU3?=
 =?utf-8?B?aVd6b1RGOHg3VVBaa054cXZna3hJa0c2T0ZLZWVkRlovRCtyYXJsczJkL1Mr?=
 =?utf-8?B?WUpNMi83c29pdDI0VHFtTyt5SHcyd2FwODUyRW5LT0ErUXhMak1jM0V3bzYw?=
 =?utf-8?B?b1Y2TXM5TCtCSngzemJQYnNQOUp5dkUvVjdnVFJtN3BHc0p6OTRRSlc5TUFm?=
 =?utf-8?B?YU40OFJ3UmpxdDJNLzdNU0dxODJXTFAyY0hOSlhVbzYwWHFZNXpzYUhmT1Nl?=
 =?utf-8?B?UW52a3BCc1c3WjdWcExnM1kvdEp2cXd1NUI4cGFmS1UvYm0ycjZGOTdkR3Jk?=
 =?utf-8?B?SUdTUWorRG5CYys2SFlKQXFPbWF2WU9ZaDhpdDNyeVJURFZMaUNkWGhpdkEv?=
 =?utf-8?B?eHg4dVk4MXhFV1BrYVZyUmVNYmNxVUFiMzM5SS9TVjJ4QjNZUE4xTEYwbTJD?=
 =?utf-8?B?TWFqWW82Slh2MXF1SjUreXFYaG4wRGRhaitkTUZzd1MrT1ArcTh5T3FFam1H?=
 =?utf-8?B?TGNzT01CRmpIdXlCQk5KdmdhY3ZDTVpaV0Y0MENvcnA5RXlUNmlwZ0htNnFs?=
 =?utf-8?B?Zkd2RjNhb0svQlRuSnU4SElCMXI4bHROZENZWWFGR1hTV2tlczJzNC9tbjFN?=
 =?utf-8?B?T0U4eit1Yk9iNU1Rc043dUgwY1dXODZ4RVV2T1RLNHhaaDJjUksySkUrM2JW?=
 =?utf-8?B?dUoya21PY3BUTnhzcjBwQlV5clNRQUVKOGlsODdPbElvSXRHeHJTaHFwWWkx?=
 =?utf-8?B?VUp4UzY0UkQyRXJoQldRZjJQeTV5REowcEloVmxSb01rQkVhRkMxdHNPbERM?=
 =?utf-8?B?cFdyaEU2VmJjU1VtQjdQRDgza3VUTHQ0UElSR3U2eE1PeXpDNGJvY2xwTGZ5?=
 =?utf-8?B?d2Q0NDFqUGZrNGJ0S290cFZOL0pXRnBYeWgwTlVDRGVOUzRIOE5JdVp0cHZM?=
 =?utf-8?B?T0VPRTllOTVPYTIwSUdCMTB0QWJWTkYyVXhlVmxNYUZJbUw2NVQrdUpkdWw0?=
 =?utf-8?B?T01FUXN3b3ZXMjFYc0Fhb3NvSXpkSjdxZXpadVZjMWxEMGNJbzBTd0dvVEtT?=
 =?utf-8?B?THpMNnNCYkhJKzg4ajMvWEwycW5oWktwNUdXZW1IZU5DTit0YS9mYWViWjhX?=
 =?utf-8?B?ZW9lYmZZRHpQblNDTzBKeVdkSjlYZStKeDErMXVKTGwzNXNUSzJVUEowQ3o5?=
 =?utf-8?B?R2VqYWp2aHFxWjlwUkNoeVZLN05jV2JNa2xWaGkxbllYeElCL0MyRXlMTXdO?=
 =?utf-8?B?VHRlMWY1WWtyaFl1U1RGUERpWTFHYVMyMnFiZ2cyQjFRV2MrZTF4a0JyVStD?=
 =?utf-8?B?ZWpjS2sxTDdUQTV0SzBMaHVnMzRrMFdGbnVzdkpqRWtrRTZMa1RCa3hOMjRG?=
 =?utf-8?B?eEE0ejBaV0c4T3NvTkFBeUdNR2ZnWG04a0hBSkNycHpBODMvM2xlUzVSN3J4?=
 =?utf-8?B?ZTRVekg0anVqRFNCUS95ZjVqTEF1OWduOEJ0dGY3OGUrYWdiRHBtcWhncjF6?=
 =?utf-8?B?YnhkT09waXdqWDJWWDZsN0wzcDh2YzMyV0NWd3NuMUFkVXZhY1EzUU9Mcm95?=
 =?utf-8?B?TnM5bmZsMnl3OWc0Ky9Sc2hxTkh2NityRjh3ZGJvZTFUN3luMTZRbUxudzNk?=
 =?utf-8?B?MzNGam1DNXBXUXhsTmRKVnZRRmFTT29MaC9OaHV6UGMrVHFyYzh5aFBpR09L?=
 =?utf-8?B?bDArY1ZRY1NQZVRSbVdZSGR2Z1l1bVdhakZBWEkycWJWcE1kWSszQSt6TVFO?=
 =?utf-8?B?QkVqU3pTNXlUT2lQbyt6YlR6WEV1di8vWUxzWCs0QTJJdnhtYlpNQ3RZbUpT?=
 =?utf-8?Q?x8pPMntHaPIKd4qE89vBF273d?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd797c07-e60b-4857-77e7-08dc5a2324c9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 12:30:17.0300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09TSgk4u1ryak2+GhDlOjZsQ6jKf9X2mRoGs2/kg1PXo2p2kcrq85hnluv/cti3Cc7viGqC2wksrtXHySbcRUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9337
X-Proofpoint-GUID: 2KXWod0EMAWbYSU8O898n9ZacgXoGJoh
X-Proofpoint-ORIG-GUID: 2KXWod0EMAWbYSU8O898n9ZacgXoGJoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

--------------4uK5ynU0wvRPBACCCT6wmTfH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/04/24 6:34 pm, Fabiano Rosas wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Het Gala<het.gala@nutanix.com>  writes:
>
>> This reverts commit 8e3766eefbb4036cbc280c1f1a0d28537929f7fb
>>
>> After addition of 'channels' as the starting argument of new QAPI
>> syntax inside postcopy test, even if the user entered the old QAPI
>> syntax, test used the new syntax.
>> It was a temporary patch added to have some presence of the new syntax
>> since the migration qtest framework lacked any logic for introducing
>> 'channels' argument.
> That wasn't clear to me when we merged that. Was that really the case?

Yes, I had little to no experience on how to introduce 'channels' as a new
argument in the migration QAPIs back then.
IIRC, while trying to merge the series (migration: Modify 'migrate' and
'migrate-incoming' QAPI commands for migration), I was adviced to just 
modify
one of the qtest with the new QAPI syntax rather than writing a new qtest
altogether. So, I just renamed the old syntax with the new one.

>> Now that the qtest framework has logic to introduce uri and channel
>> argument separately, we can remove this temporary change.
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
> Anyway, I can see the point of this.
Thanks for the support for building that framework.
Today we can independently call channel or uri easily for 'migrate' QAPI
> Reviewed-by: Fabiano Rosas <farosas@suse.de

Regards,
Het Gala

--------------4uK5ynU0wvRPBACCCT6wmTfH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/04/24 6:34 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:874jc9v066.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">!-------------------------------------------------------------------|
  CAUTION: External Email

|-------------------------------------------------------------------!

Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">This reverts commit 8e3766eefbb4036cbc280c1f1a0d28537929f7fb

After addition of 'channels' as the starting argument of new QAPI
syntax inside postcopy test, even if the user entered the old QAPI
syntax, test used the new syntax.
It was a temporary patch added to have some presence of the new syntax
since the migration qtest framework lacked any logic for introducing
'channels' argument.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
That wasn't clear to me when we merged that. Was that really the case?</pre>
    </blockquote>
    <p><font face="monospace">Yes, I had little to no experience on how
        to introduce 'channels' as a new<br>
        argument in the migration QAPIs back then.<br>
        IIRC, while trying to merge the series (migration: Modify
        'migrate' and<br>
        'migrate-incoming' QAPI commands for migration), I was adviced
        to just modify<br>
        one of the qtest with the new QAPI syntax rather than writing a
        new qtest<br>
        altogether. So, I just renamed the old syntax with the new one.<br>
      </font></p>
    <blockquote type="cite" cite="mid:874jc9v066.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Now that the qtest framework has logic to introduce uri and channel
argument separately, we can remove this temporary change.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Anyway, I can see the point of this.</pre>
    </blockquote>
    <font face="monospace">Thanks for the support for building that
      framework.<br>
      Today we can independently call channel or uri easily for
      'migrate' QAPI</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:874jc9v066.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">
Reviewed-by: Fabiano Rosas &lt;<a class="moz-txt-link-abbreviated" href="mailto:farosas@suse.de">farosas@suse.de</a></pre>
    </blockquote>
    <p><font face="monospace">Regards,<br>
        Het Gala<br>
      </font></p>
  </body>
</html>

--------------4uK5ynU0wvRPBACCCT6wmTfH--

