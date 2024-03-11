Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8698BC54E60
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjh22-0006ka-1q; Mon, 11 Mar 2024 10:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjh20-0006Z6-9o
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:53:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjh1w-0005Zd-Hm
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:53:35 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BCZ4bQ027478; Mon, 11 Mar 2024 07:53:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=c6Cpx8R0POBNzeIKab1eHSbKG8lnEp/DcHTUP5cL7
 Ok=; b=LGC1YB+Y2FLz6y0WX91ivHfEBks9zPo/KhUTQnqggYtkjE/UHIbotZf+5
 dwun/2piCu5QC1EG77gEMxXSRW3sHmgUWlDZyCPQZ+JKX2y0yAfOW9hMXYhElhoQ
 orndaLeS2INcljeXjpmfC5MCOwagsUIUrp4Wh5kqlKj3v1MJtklFj0++IrvHwboN
 uVCCTwXd5rlDEb8iKHE8Kq3CKm6fqgRbMFm45AHdzguQqYee1IC1/j+UJVWODgh+
 v+bZFAFWrAN+8VXEUT3CDSRW894VoQ6UGZbNSmJYLVhKSByVSyeAiocWkTkN1fvG
 UlA/wtFmUdeXGcAmaqCvxJesS7WmA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr63kd41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 07:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp3sw6pgI/1WwtvYffJS8elS+1m4e3J7nGpxlHOn0u40Ib87ltE684bo7Cnmp0RiT97zBS2TTCTVI/CaS5T+MYzwMZRJ4br1NB+al5qXAHDXcQKMz5PI56fAb/BfruLQA8YjGMo6P3phEHZGZGDJiLcuKBn3auq8jnmd4sk8v2mTvo0aAr+89Swdz+FwbedWHQCvSyHH0RvHQG/xWYRjJaSxpfwmhnlb3JqDdDuRsQ9SAwmMrNVYFxZzGIJKP2g8ON2q860VvjX0xwTiu5Q7O3BzXYPcMLgIjXiOllbswp6doyBNdPOMm5zy76Bhhi7vKlwhyc0e/cezZSL/1H/HEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6Cpx8R0POBNzeIKab1eHSbKG8lnEp/DcHTUP5cL7Ok=;
 b=RBtbdbxoyKsnmxwbPk2rCtOODpyVDRiroxzrc7o28DBxj37JI52KvIZImkbv25LJtIT8yOHv/PSTTPknP+BjOX6FWreUC1pHfOyH6YSt4o8jzNXxBdj7M7jI3ixgfGAqGsymmKG5MU+RA7liVNLXKTa68DWCDZVRghDOfrCZwJq+fwl6SQQAx6hR66c5DYaIHmn7s63AG7phT9i9aXRKj12r4zLY81w06REFNLK1t6hJlI6hn8HrOSOz5edgpxVjI8SEvLyqA0B36BYepVCIY71RmpV+l6p7FIhJ3MmP2afHpz/ZdLsctv6+IgBzlkrxzlN/ljYixFph5vp6lrWueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6Cpx8R0POBNzeIKab1eHSbKG8lnEp/DcHTUP5cL7Ok=;
 b=NVxty/9g6jAMUCAgkaokLOEs626hjHEbhNfI0PgPlUkZWWSzyET+3317Zo5OHU9Qv45g2q24v9znaZDA6EJ3/utgohiAwTgGzBRWv0EAWwA8/RvP1GvBl2LBjbOTP09WxB/y+zoa+eo0F7yhY8I/VeSheLX+V0Cc+Y0exm20eX+uCrdJ02OMjXaM7+WXCE8GOx6HariBsW8+S8dbGvpStHtufu/MAf+RnFdFdd3afZad3m9VOn/POJaYrooF3f2zer1goZyx/AI7l588AbFMFpxd540vy605HZwZNw6zty5IP3KYOCXipDgHs0Eqvq+1WitA452gjQ5giEkE5KnwNg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH0PR02MB7930.namprd02.prod.outlook.com (2603:10b6:610:113::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 14:53:23 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 14:53:23 +0000
Message-ID: <9731d9fc-9d0d-4358-8286-e8ddb21f44f7@nutanix.com>
Date: Mon, 11 Mar 2024 20:23:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with migration/rdma
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel <qemu-devel@nongnu.org>,
 Jinpu Wang <jinpu.wang@ionos.com>,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
 <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com> <Zek2UFoAyVrC7yh6@x1n>
 <CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com>
 <CAOQbQt0+UbfZNPrticjLD4X+S2KR4r+yWPATnhEhTRuxbwvGiQ@mail.gmail.com>
 <CAHEcVy78iCXVGmwr-2snpFwOyCxv3wxYrYJonK6nZF9UfbX_bw@mail.gmail.com>
 <CAHEcVy7kun92b8drEdDZndcWBBT7uvjOpHfqvVbqP0MqvJO01w@mail.gmail.com>
 <a5d4b5fb-e3fa-44c9-b7fb-37c3d1ab2bb3@nutanix.com> <Ze8ZOnWad7_otUX-@x1n>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <Ze8ZOnWad7_otUX-@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH0PR02MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 824d18e8-d353-4f5f-9ab0-08dc41db0023
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ic7V5bTOMxs87LY9cMWiGmfcqEzMFIA8vX8p9ylNZBE51QebvPHbmNhQG9HgYbaMJbT5OHsWU1B3uyxWR/JFOpAHWlINtaT9/2tlERwFy3RWDeJvDUZP3gUvz1u+4fVLfkukzg36Uf3oVR5nF/h0zMpZZhNuhgJjKAbsx8vNUBuuKkMZsb8r3Vb5wvjVWYZqr+RcSEvwSmwK+QXdEET7zd/qLg9lPH/nekwZr81beVr1Kc+nDaCGcS7cB/TcDpULBTuvzMarBHGqQ9J8kVTR6Vf7YLjbfD9+6yPO3Nd6QcQeVgylBQ1JatR1zF2zdqjhEz7deHqrOKLLcECrrbbbqg7h+mozrGvYYZAhVZ0E2vHex/BWxjbYkIL+Y5nswOvVUzd2LhJI96Ddn/alBver0iqfCN5IZJSIIfqqfrUD829nIMcI0y5dbiW2mw/NxLSPYBB3UfmSMi5baPdFp68oJSmQ1C5ECIt3IDl1F38fzIRcRU/d2lv0puxdXxYi1mgtol7sUD61sG7euKQAvfP336ivtNMXKyHwErbB03jftr7I1RaZ+wkkjcFdWqnSz3qZSxWQq5JaORx/aCZAKAawLS8Wzfl/sWgChlp1OZmz5XoyKMSMuj13mt6wY1u8tSKKUcg8+yvf77TVoCncI72RodAsTkt67fqufNzmLdV/TD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkgyTlF0WFRla1Z0a0YzNUlReDVzMExTLzNMbHp5WVYzRXdzc0cvLzZWcFd4?=
 =?utf-8?B?TXhNQ3FPUWRBN1pYYVVmTkdxRlF5dllHaDhXdTZMTFFWeEMxMDcrUlVOM1Va?=
 =?utf-8?B?bDhDZDF6VUhaZE9tUC9MWnZFSGN6M1F4UnN6emMvRTlGQnlkNVNJVU5EYXY0?=
 =?utf-8?B?N0lpVVFweVp5K1Zya1pnMjFoMHl6TkpwL1lTZERHUlZuQ3ByenZSMm41U1RM?=
 =?utf-8?B?YlJjWVo5a1ozVDN1NFZnMnV0TUwzdDdOV3FTNGllalRBN3Nic3p5WlpWN0M0?=
 =?utf-8?B?K2x1aVhreUt3eXgzWVprUXJmNkhLWG9NNVNVWUEyNUJJRVd0bVliTVI2VjJF?=
 =?utf-8?B?YjVaTGZOZ2ROenBGZ0RVM3hRREphU3c2Y2N4eVp5K29wM1JsaVBBSnVWSXRp?=
 =?utf-8?B?VTc2MUswOVY3dzJ3NTVodTE5aFhJeWVOMVE1MVg0WlIxT2ZwRWxmSkJackpn?=
 =?utf-8?B?b09hTUJGcUVqM0hsNGEyM2ZiSGNkSlByTDlaa0VROWRYRUxvNzhBcXF2NWYv?=
 =?utf-8?B?a3BHYndJdXcxcDFvcGFVUDRyc0ZodW4zaXhlYjdkSDNBZTBQZ3BoQ0xKRmdE?=
 =?utf-8?B?T0d3dmhTM0liTkJBNThiclpNVWJMaXRnSnR0NVFrQ21jU25nZndMaWlJTTZ1?=
 =?utf-8?B?dVQveUNnaDBzdGFJR0tYTnAva2F4MWZWSU5Cayt4aGhUeDIzOGZjNE91VTZF?=
 =?utf-8?B?RmZobURwbWMxc2l4QkhEelRlRVNpMFlNRTVGWTdUOXpWUnhJbW9ZSnlWM3VB?=
 =?utf-8?B?WnR0N1VGMTFNZVlFWG05TnUvNUlST3NHdVBRZ3ZudWtoc2Q5bERicG1aS2Rw?=
 =?utf-8?B?MTR3S0grS1JySE1PMDVLdU41RkZkdWJZdXBSYW5DZWNHRk5CS3BETm9FSm56?=
 =?utf-8?B?UmZQNTZqdGtOWmdob0N6WDBacC9qWHVuaVRFanVxOFlEN0RNUGZMcFZjcW5R?=
 =?utf-8?B?bXBsdzAvTVR4Y2RaYlBlVmtWTEtLdXZsYTkrWUJ2VjlPVzFlOElNTklVLzNq?=
 =?utf-8?B?c29oaTBnZmtjYVV4RHVlMlJyRTUxc1B0ZGlDLzgyUFNIeHhOU2JHQkF6QXI1?=
 =?utf-8?B?cHE1NmNTenV1K1J0T3JFMzdrWFNXQXBXTXE2SmV0Zk9hWjBBSXlreTZMRm1u?=
 =?utf-8?B?U21xRlBzVHhhUGZMOHBONkdRSDNDWTliczhpY2lsY2FXUkpCcVdaQ0pFcUtY?=
 =?utf-8?B?ZnYzU29YRC9ZYlNBcEtuUzBpTlc0TzRLWHN5VCtlMjd6dmhMNDgwS2sxSVhz?=
 =?utf-8?B?RldxdDdmdUpVRHk2UjRMa0NvNUZ0L1ExcXhHRnRSOXM0dzk0dzJsajQzTTZp?=
 =?utf-8?B?WTZ6TXY2dGREdHRubXR6Q0hqaVZSbWU0K2RrM2p1V0xabnd6VVpxVVo2Wnhs?=
 =?utf-8?B?Rk9kU01qa2ZNaVc4YWhwa25pUUc2VjU1dWkvcGJyS0NNK0lZUHpBU1ExNFN0?=
 =?utf-8?B?ZWZyWGdLeTBnWjdzdkc4bFNOdS9tcGRHVWxiZGV4OU92Rys2RmFrczg0WE9N?=
 =?utf-8?B?NXdNOHZoRytzaG9sUmZTKytuQWpXK2FLQUlkK0ZzWDgxaWdKZ2h4aW1aUytY?=
 =?utf-8?B?UU9PSGY4L0xiUHliQkorSEFiQ2JpNUNyREN4Rk1rU1hROEZmZUg3QktCZ1NJ?=
 =?utf-8?B?OWZOZ05lMERwcFB0MnhYbk9wV0R4a3BJTHBWR0VwTXA2dncwQVVpc25NUnVP?=
 =?utf-8?B?bzh2VWRZNkg3eTBUTzhjblFWTVppeDdTbWI3TEZObi9HUHVrbmhRUE1iekt2?=
 =?utf-8?B?UzRsazBLK2JvcFNMQW1FNWtLd1FIcmNEU1BwUGh1OXNnS2NadW5jMXZXczhG?=
 =?utf-8?B?ci9Cem5GWi8velpibi9EVFBMcmtMN1pDVU51enp6M2ZGUFpubHVnZEkvYzRQ?=
 =?utf-8?B?RGZIT0RhZFZlMG4rcXFzNjhTSHArVlhZRTEyTkppN1RmYlMxQ0dLazBGZlZH?=
 =?utf-8?B?Yy8zbUZKSWlGMnpDTDI5UjFMMzZYcmFnS2J4ZHQxenJkdEZZaWpEZEZzeDRI?=
 =?utf-8?B?QjI0TFFyZm4rUkM1WUZCZlFWZWgzNXRXemRqYXBadlNySzlkMnZOVHlqZ3dl?=
 =?utf-8?B?OHNicEdBUjU1eFc2TUN4b2ZUc2dNVGNQaWJ3cXV1eStvRU1QSlJCWGFKaXB6?=
 =?utf-8?Q?emQM2whJDKtLXscXf+dnBPKpp?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824d18e8-d353-4f5f-9ab0-08dc41db0023
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:53:23.6976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw+MoXBPzGhY2W/h93eY1mC0bNi2PB2pOMGzZM6skOdke5yYstqOyeuQVccEwWG4voKhHo6avaBhqLrPCbPyYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7930
X-Proofpoint-GUID: UAJkLBLNs1fsIro_SzCa2gmQCzDHdoP2
X-Proofpoint-ORIG-GUID: UAJkLBLNs1fsIro_SzCa2gmQCzDHdoP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 11/03/24 8:16 pm, Peter Xu wrote:
> On Mon, Mar 11, 2024 at 08:00:06PM +0530, Het Gala wrote:
>> Let me send a proper patch to qemu devel mailing list and cc all the people
>> involved.
>>
>> I have reviewed and tested the change. Have tweaked the commit message
>> accordingly.
>> I hope that's okay with you Yu Zhang :)
> Het - don't worry, I've had it in my queue.  Thanks,
Okay. Thanks
>
> =====
>  From 694451b89b21b3b67c404cbcfa2b84e3afae0c5d Mon Sep 17 00:00:00 2001
> From: Yu Zhang <yu.zhang@ionos.com>
> Date: Wed, 6 Mar 2024 09:06:54 +0100
> Subject: [PATCH] migration/rdma: Fix a memory issue for migration
>
> In commit 3fa9642ff7 change was made to convert the RDMA backend to
> accept MigrateAddress struct. However, the assignment of "host" leads
> to data corruption on the target host and the failure of migration.
>
>      isock->host = rdma->host;

Regards,

Het Gala


