Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50C5F513E9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyLSe-0003Eo-F0; Thu, 05 Mar 2026 22:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vyLSc-0003EY-1r
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:02:42 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vyLSa-0000SX-G7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:02:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOOvu5KK4rT79/ZyAjCVUh8tnXzW9xR0pVj6/Pt4RXInsoGX3r8dEPgd043bu7Tgsj7xVA5rkQckMYU4wZV6FQhju7RYv0CdF9OFKW+Yj2vF1LqT0aSjBbZXV4XJevpMd7yQDs6AXnNVfFqppQqCUOzBYjAa3Tr/DaEywb7eKk5bmdqFa/TJmZL9f9hIdQhPYw3IreFvbd6VJ7qMa3QE4R0uJXonV/VjZBMde6UbXWdX6E06f/AU7ct/AKzoBwI6d3h/MxF3DalOLV0+0vhF70ib/H5ruguXjvd6+D3E3Qy9WVFiytBQzSpdnx0j8OUhK1oO0lCXBpiOEAi9vD2KIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V12xKeUocB04UUiXOBgNCaKo3rqQfq1Xn6uaywjWB6U=;
 b=qeJ+L6oCw1lgu724F/w9vi7POGHEEfR1+J61tXFShNYeTRIEc76TN2uo+7zuOGzhhnpuW/sQ6egmw9hMzu7gpZtzyW0uINmxpz8x5eGiuE0MWt6+SUsFU0LJyaFW2Ubc2PCDn0Y1+Iv2HOXhIMzEntO4fIVRBxo9jqslk00b3tjKXOHclEZ9rFCe/BE7aBW3iDbYnDtgLVnKXOapTm6E6b9dR67zGbiRSu39mU80B+Awalnjv+CRqXtsxiJFd8yrmHxSY9egYXMc7NnKeOXSn6JggRLMgwIh+HApv1ROk4zyz7hWp4eu+OR7MB7JAgwpKtGNXrcjhRK3vd7jsw/T0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V12xKeUocB04UUiXOBgNCaKo3rqQfq1Xn6uaywjWB6U=;
 b=b3UxTg5ucn/nYZHVRIQolX69Ijygvusm0/NrGVq01K6RT+enq3E0VRvv76nQXwf/58PIbG/7cc0gMeFDvA626rZ7J7tD/RflQD3KIQb9c48mLtwXa2uaYTcFkXiyuxabR1fNssmgN0Gob0EUjQu5ZXRC2xeIWtzLXOpnp43JFl03dk/ynuwcweOilfZiFlW7NwSDTihFJ6UjQM77bSTVlmaNHxwMjg8ExqrRYzcetzODZRIlFSql6YvHlWg1u27FTKfOiPAlL68wXBrqFsFD6wYkwSvipteYfy9mvCXeiCtsssxmQCLeDh71uDf+Rlhqjl54EULg3ubveAxQIv++Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by PH0PR18MB3829.namprd18.prod.outlook.com (2603:10b6:510:20::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 03:02:36 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 03:02:36 +0000
Message-ID: <8bf90b8c-7a8e-4b21-ab77-f3c8a8506ebc@axiado.com>
Date: Fri, 6 Mar 2026 11:02:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] Add new model for Cadence GPIO controller
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260305103400.1574217-1-kchiu@axiado.com>
 <CAFEAcA9hcr7sDHvv-o_YRkaBJLTt99Uh=DgLtTHw_=jA6A4j5w@mail.gmail.com>
 <460c0ea9-005c-4970-9cee-bffb7e9c0c11@axiado.com>
 <CAFEAcA_w6DDdBRnpYDNDPUOO5Quf_7J6ty8XNVCe=8N7KAy5Sg@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA_w6DDdBRnpYDNDPUOO5Quf_7J6ty8XNVCe=8N7KAy5Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::20) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|PH0PR18MB3829:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4a0ab0-9032-4be1-79d5-08de7b2cd1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: wAOPpJXjUjUQmnXI1b1lxTId3UcJQ7REr6wOIpgu13lzikYn9PWsvv9TZeCcGp0vlrez1eE+oQ8Pu0g8FU+XPXKC7I9UZBgTJoeVnoVXPu6DYKhHme25vlF2ktK7XD91i8gXij6H8BS65XPnEcpEr4U3rasbzoxS6d9vg7c8LzEfouxSpd/HOiHdxnl9EGAGaMg8pGke5MienxRZt6K6zGGmQdXm5kpTvBegI6aTW8ZxE8A0ahMPqkdI3Kq94BFnwyyq5GJHlmAmc1lXIZ54wclmX8ZjEb156YMM1nbIjnM3f3GQhGsVBdtaqL3o3roieehJMEDFebauDVHama9wruOgyZY7LasHXmJs5/5Axy2Cw3hw1cN73OVjKlci9FZ/XdmyVJ6lK8ueX8QXU59MJr2SSE3QQepyp0yIp1N2Xh+leCB/HbQia5tt4jQ2bkJPDC/0ATpc6NH/w+a4Y12qBACLAZoAdSUO+FWeqzitnarsoG7rbRFpox0cmqjEYN6783xxUJaBJ4HAvwBZPxKC2g6QIvVAoYo1UGcysDUO16PmGU9lGx+LlAfi7Ag+neKoZzVTF+LcrphWKYi8sH3kDMj4/hMbJREZFMF6FnDPSb7mrqKX9TVluzx14S182FCwBHwWDOUoDG7YaEzVfY8VeXzXd7EoA3uWdS8oW4egkmzENHtyr5X8ueXg6sQoLDE+OaIzG7JQe7suahavFtRjzRG9MAgvA6S74zSxQc+4CaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2Q5K2p2SW02YnYwbVFGVXJtYisxalJPWWZmSWFSOEFpdHhmRlZ6czJJczlS?=
 =?utf-8?B?SERwVTFzUy92UWNic3V1OUxOZld6ekhWcjFjQkg1aEhLdDBnSWZYVVdFd1Az?=
 =?utf-8?B?cERNM3YwL1Z6emVpaTd5Y0hjQXBVbURoQ1hQMDR2Vks0YUl5TExaeU5HK1ZH?=
 =?utf-8?B?RUVsanQvV252NE5wYkQvOVZVVGNlSkhlVUxhNzJBR2d0WVBod3lzYTB3UTY1?=
 =?utf-8?B?UmF0Y0ZHbnd6dklIanpGNnRPT3FYc1V6dHBmNFdkSUpEb1gzN2h0TXVVVndM?=
 =?utf-8?B?U0szOVlCOWg1VEt3WnlyL2N0RDhEeHI5R1BFOXNWV3BBcGdhUmRDa2duVUVQ?=
 =?utf-8?B?SC9GcGp4d0lJamZ1blF0cGtlbW1RSTF2UCtBQnp3ZklmLzRrVDloeDBMZ0Yr?=
 =?utf-8?B?bWM1ZlRWN09lazVwOE9EdW1jYzVZWFBNbFNpNDczQzQrakUrRFlQSHFRaDR5?=
 =?utf-8?B?bGQ3WnI1bHVaZFlpWlM3UmZjU3ByRWdmR282UkRYd0JjR2N0dmxoRGxRNjlJ?=
 =?utf-8?B?dUdZUjZWK284ajBDZjlxN3FGb3E5VEFHTVZ5cDJNYnlIOE9sWCtIVzU2T09u?=
 =?utf-8?B?TzRJMmg4eXNMWVc3VHZsQ25WOWNqcmtENVdMa1lUbWFxWE9PRzhXYVkzbHRl?=
 =?utf-8?B?N1hERnhtUGd3a1JINCtIWDg4Y2plb2NVTUV5OHJLS1RnV0xzb1h1QUVGbUlx?=
 =?utf-8?B?bHo0dWdIanJ0ZWt3MWc5WU1reW1NaGdUN3BCLzZISXYxZ0xidTJSK3piVzJX?=
 =?utf-8?B?d1JXYmtHelo1Q0krZWRRenEwR3JmcEg0eUZuUmgyb0RxN3Vqdllja00wWDFp?=
 =?utf-8?B?WjlwOTB4MC9DWTZIQ0EvZlA0VHBzZWF6S1FJZ1AzZXJ3L0JWbUx0Q3RnWjBu?=
 =?utf-8?B?KzdhbHpmTTMxUC9pRkxxUHA0Uy9xSFVIL0NKYkRzbHVVdnQ3aHY4a1F2WW5W?=
 =?utf-8?B?cnRHZ3Yya0ZOUm82UjQzUGI5VzZra01yL3hYMmpEQXkyMXdudEhOMTJqbEFJ?=
 =?utf-8?B?QW0vYnFuUXQ4NURVckZaYkFMeEtMbkVrajE3WjEwZGRVRzdvMlAvZGdSWHIw?=
 =?utf-8?B?N2VKQ0phSGZ0Rjg4TDlPQkpRU0k0ZFY0eHd3c0VWU0hvQ3p6TnA3a0F6Ky9y?=
 =?utf-8?B?ZGdKck9vN1JIMmlRMjNLVDB6QW1LV21sVnRHd2lqUTZlbjgxK2taSGtIY2Ns?=
 =?utf-8?B?TW9FYlJpWjE2V2R6OGpIdVhwVDcxYjFsNnBLTU9SZWtXSGYvZ1p5ZTJoNmZq?=
 =?utf-8?B?eDhQd05Ca2h2SXBjRW8xOUZMandFeUhkYkdabmF3WGhBS21zQzFqTnFvQVRq?=
 =?utf-8?B?SlpPUmFTMWVmcU82ZWtzMXBGOXJrSFRMWWtXNUhLRWc0YjBxc0tLSWhGWklI?=
 =?utf-8?B?dlc3a1JtcmtoWi9RMkNid3ZCaXNKeG9Pc0tnZkFmLytmYUFFLzBuL0diVDNi?=
 =?utf-8?B?dVp3Si83cWpqclNHVUZPekNtcWkwb2hZQzNrMC9ocURWck5TUGpEcnRJaEtH?=
 =?utf-8?B?QzZLSGE1NldSSFIvN2tDWHQ1VmUzVlVCV1hiVDJTL05TYkptUjEyYm1OQm93?=
 =?utf-8?B?MjBTVW9RVU9YNGVPRkJuRzhTSnZycVRsZC9GOUhDSmJwemQ4MVh4ZVpra1FV?=
 =?utf-8?B?cFVIQlJlQlBVb1Z2VEU4R05JNTNDeVF6RHRxTGZuQ2ZlUXRFaG1DN0dFa052?=
 =?utf-8?B?WmxMaGpEemQ5WDM1SlhZTFg5M0pZRUZOQ3FxZUp0aXFSd282VGFZTWJVTUZ6?=
 =?utf-8?B?MHpZKzBsKzcrZ1BnY0RtV0U4UVhUcVJTNmR4dDYyRVI5ajFrcXJ6a3plZVA3?=
 =?utf-8?B?MXpXWjlPSGFwN1FzRFJtWDBlOSsyU2xTVnFreFpSUkUyZjN3akpoVDVCVERx?=
 =?utf-8?B?M09oTU5XYmRSUHhmTSs3b1c0NFAzWERXVmFCQ1N0MUdEcW5UV0wzQXNUUE01?=
 =?utf-8?B?c3MreXZMYm1HNGxDMVlORHVQWGlSa0FwMzliamZ5Ry8zQkVBMkVScXRSU1Fk?=
 =?utf-8?B?cFJmS3RkQ01xcW1DSWV6bXBMMXIxM0tMRkt4NFRnVUxPR0l0eUtWc09CS3d0?=
 =?utf-8?B?OVU1VFVIS2F4eXFnTkZrbmJ4dXEyZDdyM3BWS3ord3hXQ1NFZ2V4dmkvLzBF?=
 =?utf-8?B?cnE5ZThaRDJ5d1VFMDhRRjVrRDJPNi9Ld1hNQnloSGtKeXlmblg3Zmhsdkpj?=
 =?utf-8?B?aGlZUG1ZekREZDNXRTZMWjNvclgzOUlCK3hsWWE5R0dqNUxKcGVWNzRlaTlo?=
 =?utf-8?B?SXF1TDkva01lWFVFM3FUWThlOVdpVEZNdlNNRWI2TzlVbzJCcDBZOTlFTHYv?=
 =?utf-8?B?cUJXVEkwdndnZ0pnd2dxaDVUZE9LL2MwcmFCZk5pSlJ6Vy8wS1BMQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4a0ab0-9032-4be1-79d5-08de7b2cd1b8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:02:36.3332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAi9AKI6gvrp/RaRizL9XMIQITGNKfrp4VFMC8ZSl9MqFHEyxzyWS+7H1Twvg5npE2R77sOWHqL0dnKxXNbxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3829
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=kchiu@axiado.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Understood.


I did not find any existing device trees in current upstream kernel 
using Cadence GPIO except for our EVK
So I would submit another patch to QEMU for our EVK machine then update 
this patch

B.R.
Howard Chiu
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Thu, 5 Mar 2026 at 11:22, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> Hi
>>
>> Understood.
>> I verified this device model with our Axiado EVK machine which is still
>> under development
>> Does that mean I have to submit patch to add our EVK machine into QEMU
>> first then add this device to it?
> Yes, that's generally the way we would prefer. Or if this
> device is used in some existing board we already model
> (and we just haven't implemented it there) then that would
> be the other option.
>
> thanks
> -- PMM

