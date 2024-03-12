Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01695C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4hn-0005k5-23; Tue, 12 Mar 2024 12:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4hj-0005je-RQ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:10:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4hW-0006pr-Jh
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:10:14 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CBfcrI023960; Tue, 12 Mar 2024 09:09:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=BQsNxK282S3q
 m+QtAMH1vqxA8o0FhUTVIdMLhpdu5ls=; b=QmCLfHJTr9tMSXTG6bbV8ZpsP8bt
 Nw+EUxqOTm3VGJitzFh7nED9Xa3pPr6U1MiaT56FROqwXBiwzjfI5VmbZyvgiVV6
 k68VQO1YTRQSeT8AXDEnYB+I7Is8d3K319MXiklEY6dF40rQj3aMMw1KeBY3vBMb
 HOF8b27A4Vd7fhyBOgwVENNWDcQVsMxzWmIjlzBTiaC9MbHHh1JT1Z9ulqB6j7ik
 LtAE2WN9xdO9sRDLkAQ0R5+0e98rNW1gXAsC9vxPhL7/QIcuP7PSDDzAOZvW5rDS
 RPwYl9T3bcSzhe91JQJwC5MZ8kDxGmIvX1UnKQnlueB0uPPX+GjP6zTv2g==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygpa6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezMIKdo0YqmgIdSfdP1p79eOtyYKTWIwWxIdPsOiGkQQ/OET1n9Ced4+a367sjkqTPjL8mTSw6fRX+QORQEGsKWllkkNpyNToVJGFb1mBmhm4DyM53BVH9PFOyOfuaowV3PXe9ElCX7vzopgV9NOO6d5CjW4uzMgr8N3k0MKLGK1AYHm9P0hYXSEqLjhHM8Dq34qynV3EtFIEZ0G3kHlN/vAE7dOvpHp8LLg8G5bHt8mhs95zU+viMdW9JRjxIXMFpQ7ofKGoihGNXepCBx3bnPfzx/TZGX+qeTUJ98ALXeGKKbTg99Fc/ZaFP08yYnbfv8BxvO0lcH0nFD1pCkjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQsNxK282S3qm+QtAMH1vqxA8o0FhUTVIdMLhpdu5ls=;
 b=N9+e3GTRHjbWc5Lk4a0V1EhZrz45TRvDl6UZDx48lwQmmvuKLf/U8+6Ygmztz64YKl2y1xwXSzhKQNpmQHfs3E/Gr+VnmKKe07LTecuU+byakhGZ6RTMKtgxfaaKQ0K8WS+ghfuOIpiti9l/P16yLgD2waurjVCN58fzVE6urSg6JO6mEA673LlENRbVm8L6w8jYuR8mY8lLTr+EZVSkSZWPNISYokEqUEu2qzhWxCDvPC/cVKSYjcj/z0HKkHAYYP53b4qWc6HwXNwqt0utwaajVhAQasee04Whcy9nNg4rshMnzI5qq5DFC669A0rcT5F8fpSwaA49UYJYZosvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQsNxK282S3qm+QtAMH1vqxA8o0FhUTVIdMLhpdu5ls=;
 b=xzm36Yf4/7qD9IHSI2KwZnUJgVLEIeohRobkvEgutugNNd6VwCTY4wN9W+r6LcfGYs/zTD/dOD/GlxC55L/L4RvC52d8wM/3Qkogo9C7qFCpX9oidIs61BC8SKifQGkiRn2caqqUClVu5qQE48RUHQsaani4xlhE9Z3+NKeYxrgs8m+bma1jKUDMOWcA7KWS6ovzQPZc6IxlcYbaAWcpAQuxfazaF2iNm7ccypeLZMCY0U+vPGoJwTXmnuFOpZG9hbc1V+a+eUhiMPg5OAW0tqzvVy9fw/GeyoYXm8nlQ8bxokwkc9i4ivYi8OoOh3Wu4VGVn08d1FgZkTos/xF4eg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BL3PR02MB7892.namprd02.prod.outlook.com (2603:10b6:208:353::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:09:56 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:09:55 +0000
Content-Type: multipart/alternative;
 boundary="------------gYh1WZTLqilXiNh5acS1YUP2"
Message-ID: <e2a9e6fc-ceae-4091-95a3-e87309274795@nutanix.com>
Date: Tue, 12 Mar 2024 21:39:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] Add multifd_tcp_plain test using list of channels
 instead of uri
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de
References: <20240311215358.27476-1-het.gala@nutanix.com>
 <20240311215358.27476-8-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20240311215358.27476-8-het.gala@nutanix.com>
X-ClientProxiedBy: MA1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::34) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BL3PR02MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d28253e-00a7-4513-9431-08dc42aedb99
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fq0fVnk+pFjI2lQtW0oH9Hg2gEUE7IbR0YNtkJUAYVPnuEfew8bGmp8kSzUrlWt4IUhVigEtPSgGEFO7rgzkrWTkpvxc0ngaLEFjQMc9LMW019Plid6/z6JqXQgiOzEjFLCCW/PjU9HlltZSIhtAq/9jACfXCxzQ4utjTUaa72vl7b6TrmI8J2qdd65FoAmpS8wLLWY4cme6Tsh9aDGxgMy7TCRE7vbamOl8fdj3z5ZtPLA+oZurT94h5PZte27A9Jxj49gTvngaETNjkXEQqoHX1je5uthgKIdingW9QtqUPSvH45aKL+lw8npdIz8TT0o5CMcYyYmCVSYKll7t5eyMEq8O6hs9wlhaG+P2ioZ5luq43bsaW62aJzVIhBdux1SrR2DV9Lc7XTt/pNTDVukc8TBdAcpX/GhZo7nR+LWiSJJLUwZThzYTqHiAKXghJFxSsCSlxraVmvH5WcptZStjPRcSxfYI4D0BO8Lb3jmm099nZg5seeYDi/Q0FuH/2dgRnyVqdimpWQicHzJpFIhwZEHEZb6AklfaYLbUB7i5i2OmWST+W4/rBp6c3ZFhjDl0nEP4ywu2l/YEl7CLu0ilMYBApab+DBmrT4n038cJCrHOKNlxSHwLiDTC83734OGgLwI7g3Qs2Oj5Zmp/e8MfmNe7Zm0zAk0Mr7MoQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXA3SGgrNTVSK0cwNitxc1loSjJnRGxjQWk5YTJ1cUU2a0N6eG5yb0JhUGM2?=
 =?utf-8?B?Sk8wanVNVTI0UkpCcVU1VTljVGpEbHBMMDYwK0IvZ1ZpS203MFBUbk56eTZE?=
 =?utf-8?B?Vk9FVlprbm1NODlBVVdaaEM3WjNIOWdMaFRHNDVQTzF6bnd3QWdPS1Z6VnMx?=
 =?utf-8?B?TjhTeFdDUW1hQnZVekFCdU9SeUNXYlNxeThKallSNkNCWkZUZEk1WVZoSUFu?=
 =?utf-8?B?cThkeTJORlhkbUtrdkVROFUyeVMwQ1BOWDVsd3FkYStZTnVGcUpLTkd5SkI4?=
 =?utf-8?B?Qzl6ZEZ1Qm13Yjh3VE9JY0RoOEoyK1d0Wi94ZmVuTk1zTG5xWUV4OS9TMUQ2?=
 =?utf-8?B?WVQwVEdxSFhOVnFWTVRtTFRmOXJ0aVUzL0pKeHNDc1ZMdUxUTFRNQmNwZlNT?=
 =?utf-8?B?K3NaTFFxZGxHNHMvZGRnMlNjdndOeW5UcmE4bWNkcENmWDQrdndoK0FxbytF?=
 =?utf-8?B?b3EwakNXVm1YcHhzRjArVUpXMFRJcVRTSENuQ0hzekRvZk8vRFJQQ0lJZmxv?=
 =?utf-8?B?YkYvMVNueTFJY2xtRTlvdTdYdnBYY2NtRGVDMldFQmFOQVZxN2xmazJrY1Bq?=
 =?utf-8?B?TittUjVXaXd0MlNDMVgyRmpiUGxFMkFwVEgrZER6a041L3pJVis1K0h5SG9j?=
 =?utf-8?B?MUJlWFZDcmVNYmhJUDNUcnk2djllaHF2WlJ5VzhkVDBnZ1NCem1Ydm80NHRE?=
 =?utf-8?B?cTBYMWlERDNyNHJzZlhzWE9WQnJaOEVJRENHSGJucHZlNElsYzJxLzZmamxY?=
 =?utf-8?B?TVgxODc4T2ttalFTbGIwNVNXaDYyUm4wK0ZybnJTc0c2REcrZVo2bUs5YWV0?=
 =?utf-8?B?MElqTURXd3l5R1FlM2YvMDRaWVRlQVB3czEzZjB3RzBIa2c3NkcwVUFwMU9D?=
 =?utf-8?B?RXhabGhiU25wZkxrZFdESHR5VUhtYkZ4UU94bmh3clY2dHArOVZjVis5bFBQ?=
 =?utf-8?B?bTIrWkw2VXk1WDVhMmFvNFZMTGk0QS9kM29PdlFGUktvMmk1amhMeFBrNHNR?=
 =?utf-8?B?NkpGMnBkd0hZc1lQNnZ3eUZsdDhYQlNJL3VjZnRxMlVpVW1CSG9WSGFBNWx5?=
 =?utf-8?B?MEdYa3RINWlFckt3YVVFRllCSDNJQ0IzRG9acXhwOVZ1R2MzOW9jcWllZ0lN?=
 =?utf-8?B?RGtuQlpiRVdBKzhJUFJjekQ5QWY2dlNiT1k0N1hoTHdtZWpRNFJmNEwxQVB5?=
 =?utf-8?B?VmxhK3VvSll4YmNkaFk4ME9VMkw4enB1T0tOQlFkWU9UUHdscktkRE96VjE4?=
 =?utf-8?B?eGlRQ3ZzV3JaRjA0YW0vUDM5TWQzc2pkaGp0K3Q1bWc2YWRVcUZFcFZUYlh3?=
 =?utf-8?B?SVd1Y2h1ZUdpMUZtMG9KSDI3MkVpWFF5MWJORUQrUElKZVRWaVdRZWxNaExo?=
 =?utf-8?B?ME1qN0YrQUhTVlZQb1lUM0VPQ1B1MytnS2krNWpyMGV5YVpkcXBqWDlwNXBH?=
 =?utf-8?B?M0IwMFVQMWtRRjhsRlA1NFZpdU5BYzF2UTlqQ3FvRmlFWlZ0YlJVK25jMTcy?=
 =?utf-8?B?YnEwTTRGTUVQRHg4UTZnK042QlcrbUIwYllBcmpDY1oxMUkrd0VwVGQ0RGx2?=
 =?utf-8?B?TW05NzVrZGhwRGhQZzFxTXVpa1h1RzNBcEliMEF2MTBKcnB1QUVIRlFwT0l4?=
 =?utf-8?B?T01PbWFoL3hzZWI4RTN1czg3Q3NheWxzUUE2NkpRSUpVaVAxNUl5R1FwUW5K?=
 =?utf-8?B?SXBFQVk1YlZ5QmRHc280M0xaL3VLcjJSVmFycVhiUU9JT1JsVWZnelJKNWtW?=
 =?utf-8?B?OFJWZW81OU1pbVVFWnpNL25oVVlqVzIwVTBNSWJhdng3R3BPK3U3bU5sVHdt?=
 =?utf-8?B?L0UvS21xQ3hma1ZRNk1TbDBoZWF3WXlYSnpEVS9aN3loa3pUUmdWeEVuVlBu?=
 =?utf-8?B?QmhRZDJLZGJ5am9BWEVhUnVIbHNaUWc1d0svNTY0ZDdVdmY0eDdTd1hDb1hz?=
 =?utf-8?B?SlpTNmJOR1RLMS9xTXNUWGpLYlR3RG9HZTJpMEUwWUhlTmFuTVhkNVYrdGw1?=
 =?utf-8?B?bVlYQ1YyN0VIcWFCNldiS25xM2tVM0lHanhBVmRMcnY3WDBGeWtub285WW1V?=
 =?utf-8?B?L2k2SjY3NExlSm9ZUDJEd1d0Ty9VdzdyNTN4TDN4WTdkUFFDL2ZEODd5dERQ?=
 =?utf-8?B?ZlRmRmFrcmkwcUZ4bUZYWnliUTdTd3dkWnQ2anE3d3dKcEM0Ym9vMk85T0pC?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d28253e-00a7-4513-9431-08dc42aedb99
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:09:55.6929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABZWg8SRb7cTqTv8LDxS0hB4OKUYSbJaPGGVu9wJrSNYHwViIXdSKO479KpkJFcphK0aNSTflEjdYkJSuJQ3jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7892
X-Proofpoint-ORIG-GUID: KpVYYYlahhkARvArheNIZwvPTRVsximH
X-Proofpoint-GUID: KpVYYYlahhkARvArheNIZwvPTRVsximH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--------------gYh1WZTLqilXiNh5acS1YUP2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fabiano and Peter, do not give Reviewed-by tag for this patch.
There is a small mistake here, forgot to replace NULL with
args->connect_channels while calling migrate_qmp inside
test_precopy_common.

This was not caught earlier because, in the case where channels
and uri both are absent, migrate_qmp still makes live migration
succeed.

Sending out a new patchset series - v6. Can directly review v6
patchset series.

On 12/03/24 3:23 am, Het Gala wrote:
> Add a positive test to check multifd live migration but this time
> using list of channels (restricted to 1) as the starting point
> instead of simple uri string.
>
> Signed-off-by: Het Gala<het.gala@nutanix.com>
> Suggested-by: Fabiano Rosas<farosas@suse.de>
> ---
>   tests/qtest/migration-test.c | 30 +++++++++++++++++++++++++++---
>   1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index bf27766eb0..392d5d0b62 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -655,6 +655,13 @@ typedef struct {
>        */
>       const char *connect_uri;
>   
> +    /*
> +     * Optional: JSON-formatted list of src QEMU URIs. If a port is
> +     * defined as '0' in any QDict key a value of '0' will be
> +     * automatically converted to the correct destination port.
> +     */
> +    const char *connect_channels;
> +
>       /* Optional: callback to run at start to set migration parameters */
>       TestMigrateStartHook start_hook;
>       /* Optional: callback to run at finish to cleanup */
> @@ -2740,7 +2747,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
>   }
>   #endif /* CONFIG_ZSTD */
>   
> -static void test_multifd_tcp_none(void)
> +static void test_multifd_tcp_uri_none(void)
>   {
>       MigrateCommon args = {
>           .listen_uri = "defer", @@ -2755,6 +2762,21 @@ static void test_multifd_tcp_none(void) 
> test_precopy_common(&args); } +static void 
> test_multifd_tcp_channels_none(void) +{ + MigrateCommon args = { + 
> .listen_uri = "defer",
> +        .start_hook = test_migrate_precopy_tcp_multifd_start,
> +        .live = true,
> +        .connect_channels = "[ { 'channel-type': 'main',"
> +                            "    'addr': { 'transport': 'socket',"
> +                            "              'type': 'inet',"
> +                            "              'host': '127.0.0.1',"
> +                            "              'port': '0' } } ]",
> +    };
> +    test_precopy_common(&args);
> +}
> +
>   static void test_multifd_tcp_zlib(void)
>   {
>       MigrateCommon args = {
> @@ -3664,8 +3686,10 @@ int main(int argc, char **argv)
>                                  test_migrate_dirty_limit);
>           }
>       }
> -    migration_test_add("/migration/multifd/tcp/plain/none",
> -                       test_multifd_tcp_none);
> +    migration_test_add("/migration/multifd/tcp/uri/plain/none",
> +                       test_multifd_tcp_uri_none);
> +    migration_test_add("/migration/multifd/tcp/channels/plain/none",
> +                       test_multifd_tcp_channels_none);
>       migration_test_add("/migration/multifd/tcp/plain/cancel",
>                          test_multifd_tcp_cancel);
>       migration_test_add("/migration/multifd/tcp/plain/zlib",

Regards,
Het Gala

--------------gYh1WZTLqilXiNh5acS1YUP2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font face="monospace">Hi Fabiano and Peter, do not give
        Reviewed-by tag for this patch.<br>
        There is a small mistake here, forgot to replace NULL with<br>
        args-&gt;connect_channels while calling migrate_qmp inside<br>
        test_precopy_common.<br>
      </font></p>
    <p><font face="monospace">This was not caught earlier because, in
        the case where channels<br>
        and uri both are absent, migrate_qmp still makes live migration<br>
        succeed.</font></p>
    <p><font face="monospace">Sending out a new patchset series - v6.
        Can directly review v6<br>
        patchset series.<br>
      </font></p>
    <div class="moz-cite-prefix">On 12/03/24 3:23 am, Het Gala wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240311215358.27476-8-het.gala@nutanix.com">
      <pre class="moz-quote-pre" wrap="">Add a positive test to check multifd live migration but this time
using list of channels (restricted to 1) as the starting point
instead of simple uri string.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
---
 tests/qtest/migration-test.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index bf27766eb0..392d5d0b62 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -655,6 +655,13 @@ typedef struct {
      */
     const char *connect_uri;
 
+    /*
+     * Optional: JSON-formatted list of src QEMU URIs. If a port is
+     * defined as '0' in any QDict key a value of '0' will be
+     * automatically converted to the correct destination port.
+     */
+    const char *connect_channels;
+
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
@@ -2740,7 +2747,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
-static void test_multifd_tcp_none(void)
+static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
         .listen_uri = &quot;defer<a class="moz-txt-link-rfc2396E" href="mailto:,@@-2755,6+2762,21@@staticvoidtest_multifd_tcp_none(void)test_precopy_common(&amp;args);}+staticvoidtest_multifd_tcp_channels_none(void)+{+MigrateCommonargs={+.listen_uri=">&quot;,
@@ -2755,6 +2762,21 @@ static void test_multifd_tcp_none(void)
     test_precopy_common(&amp;args);
 }
 
+static void test_multifd_tcp_channels_none(void)
+{
+    MigrateCommon args = {
+        .listen_uri = &quot;</a>defer&quot;,
+        .start_hook = test_migrate_precopy_tcp_multifd_start,
+        .live = true,
+        .connect_channels = &quot;[ { 'channel-type': 'main',&quot;
+                            &quot;    'addr': { 'transport': 'socket',&quot;
+                            &quot;              'type': 'inet',&quot;
+                            &quot;              'host': '127.0.0.1',&quot;
+                            &quot;              'port': '0' } } ]&quot;,
+    };
+    test_precopy_common(&amp;args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -3664,8 +3686,10 @@ int main(int argc, char **argv)
                                test_migrate_dirty_limit);
         }
     }
-    migration_test_add(&quot;/migration/multifd/tcp/plain/none&quot;,
-                       test_multifd_tcp_none);
+    migration_test_add(&quot;/migration/multifd/tcp/uri/plain/none&quot;,
+                       test_multifd_tcp_uri_none);
+    migration_test_add(&quot;/migration/multifd/tcp/channels/plain/none&quot;,
+                       test_multifd_tcp_channels_none);
     migration_test_add(&quot;/migration/multifd/tcp/plain/cancel&quot;,
                        test_multifd_tcp_cancel);
     migration_test_add(&quot;/migration/multifd/tcp/plain/zlib&quot;,</pre>
    </blockquote>
    <p><font face="monospace">Regards,<br>
        Het Gala</font><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------gYh1WZTLqilXiNh5acS1YUP2--

