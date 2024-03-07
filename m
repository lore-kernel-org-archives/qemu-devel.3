Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A93C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 06:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri7DP-0006fU-Ut; Thu, 07 Mar 2024 01:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1ri7DN-0006fA-R5; Thu, 07 Mar 2024 01:26:49 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1ri7DK-0006rk-7M; Thu, 07 Mar 2024 01:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709792806; x=1741328806;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ir06Aj9KxXIxBTE574z690Yubs0yJ0kl2WjbsSvMKd4=;
 b=Qs9EpjuRZAvi2i/ikqhNHkAdUBqWXpisBS2uf7Y+884W5H7Aj7NJWrH/
 pIbfBLDqPstdezcLnV1KZGwZ690SdlGegFs8X08oWLexNQNK7mspza/rv
 Icht7mHz/teQ3ZvUerSEbWHAMp+vBjzh9grwm6uKKVKcQnut4DOz9mBbz
 VNDEweNUrX5+ZnGdV0Pli2gUZjiYi65pYaPB0uVaM1sRYZZZl8+PolHKv
 2drq0wvPuwtaJd1C7XLeuOlHnpBJQN8pn3cEFdvEPbaa/TrbHdIQb3OfO
 eA5apn9hx6uWW/m2a56sIAG5gsroHBqWrEhfEKAhijm5v79rxfZ5Bd8kR Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="21896264"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; d="scan'208";a="21896264"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 22:26:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; d="scan'208";a="14601536"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Mar 2024 22:26:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 22:26:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 22:26:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 22:26:39 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 22:26:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAloC1N6wj3Wo7EIU5+sP/ZYViL/XjgHt6hFxNEjMFTScT25xq3hNlTHw/RP4pv6uuryQmwgB4uppmJ8dseyE6v394X4v9++2G8026uDPeAWSUnE1YQIlVDVfdZ/pWd28uY+L32WREOyC8YRj9rk2pNkuBEHKyx7Q7vFWbO1qglktnGjymYOf6LgkWdx8x1hj/jaeIs+l8ZGq8zV6Cc9/AUfN6P1bvv+Qmv6EWYjyO18NB/V8H0xwxFZioNJ/VrOTiMP3tyXQikuY/61k7LUf4Qgt0N95fYr/ZEJdF/MJCh6ibxfCAGO+JS++vvhEDSlpGPejBJVuMRRc2bofekk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjVeYdraoH7OQFKf4UWidJWYkTVSfKYQ9c0v+MMNkP0=;
 b=K81X9ixEidIwBt6nFuPrt4foWBedtesmJBIkTPhFrd/qX7UKD9ERSjC0e2vRsBuo/u0NaZTjP23L4zuloDj0WEe44gWuS1PNLOmTVLhnxZq+cg4TEFCvyQkY+yMrH8LqKEXE2VE73vCp88xMVYP8wYP/eNAOYTDIT0yYu3khFOYwAZiC2A330oqnKpD74hla35nkTazwkpy8FwNH5wV9OPbBRf7rNDuNl1j/W+nqvds1aioC9JD6q2AloAq/daO6NndB2X7QCYk40aitFcAkUbHHIFUrgjSOneAeZ5S9WP+aCpiBB50KaJycYhD64F2OtvEzE98M5Q9spaQid//Ifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 06:26:29 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 06:26:29 +0000
Message-ID: <18efc373-b98b-4a9f-96c5-c6821793138f@intel.com>
Date: Thu, 7 Mar 2024 14:26:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] hw/riscv: Add server platform reference machine
To: Alistair Francis <alistair23@gmail.com>, Atish Kumar Patra
 <atishp@rivosinc.com>
CC: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>, <andrei.warkentin@intel.com>,
 <shaolin.xie@alibaba-inc.com>, <ved@rivosinc.com>,
 <sunilvl@ventanamicro.com>, <haibo1.xu@intel.com>, <evan.chai@intel.com>,
 <yin.wang@intel.com>, <tech-server-platform@lists.riscv.org>,
 <tech-server-soc@lists.riscv.org>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-2-fei2.wu@intel.com>
 <CAKmqyKMQyDjLkeo+aU58rE6_Vb84QeeZP3FUafw5GuWpk1JmZQ@mail.gmail.com>
 <8f5d6664-c075-4d31-bf33-ce24ceeb9b13@intel.com>
 <CAHBxVyHP1hgGWg6EByX6XzqmTm_Tr0uw7tk65KWcytNYsKdw8w@mail.gmail.com>
 <CAKmqyKM08RwR7RybMGaN6CpmbHJrLwx0DSjz_A1w6h0AkW12rQ@mail.gmail.com>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <CAKmqyKM08RwR7RybMGaN6CpmbHJrLwx0DSjz_A1w6h0AkW12rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|SJ0PR11MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: ef508e92-e74f-4528-ba84-08dc3e6f8644
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAvm1emKoiiAi18+MhFBIJht6IAskkwb1Tm5pKhIVQCOhPf0npMXe5LPXAHCx0RhPAl+wmAE9LCUHTY2/+iRKp9Un3DtFnjF+YBkUEhYhD6ozGQ7vYwIExgSFPS+LpaSWWRTzKlMDjmPlmIf6p9xKZXCwurSZnCztAs+Gs6rTdOUvbhd2z3T2WEpyNlnh+ZKxZaSjOfUXUigDDLfw3xu4ODE3fQslGPHP4NGIhYNUdyJc/v1puuyTvHn/LB338g2MDECgyege9YEMr4U5pkPcYCvJU8LJlSVYGqAeuranu3aNpw7qwH0goG1PAZqOiGN5SVhZVUv9PI4vEdP2DM7cawR5IcB/nHJvdlfblZmDe6wUucSVC2OjT4oEN7nOqyJLUAgPuEKQyS8KHPbT9X9+z1NptoF8iU9J8x1cP+46NXPqgy+mIdfUHDery1Rqn/eNkbBqmhHjCE693aTKrjVwqguQWqNZEeAQTy6deFWEhHbz6UTMBbMQQQhD7bjW3gTlhW4Y62XV32Fe9b6z9U8RE6IcsavKnim9kprp1xoUG/O5UPd+9VsVBfUFiKdnRr/oS81zP2pOXhNCQwE16fdz/Pm3iI0FDJsWaJ0+k2w9iA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0RJd0FXVnVNY2U0dEZ0S3FMY2RQeHlLekVYM05vajlnL3pQS3psSWVuWUtM?=
 =?utf-8?B?Q21tNlFzY1ZOUTMxbGZ6ZDByaGxNZWIvT2NOYmZydVJiZXlsdnBBK1ZlL2x5?=
 =?utf-8?B?RjcwZGZmYlhTb2NxRkVCSndIbm8xSXNWc2RMdW9qYURpS0lpckJCOVA1TytD?=
 =?utf-8?B?emZVeUd5aWYyWjhUczlxZzJXK2lDRS9la1FJNW9JNkJ6ZHVIQThvbkZiRXZK?=
 =?utf-8?B?OGRZckpqb2IvWkVUdkZuOWt1Q2hlNTZyOHVlVXhZdjFoZnhEV3p4MWduRzlq?=
 =?utf-8?B?cC82bE1VY3dGUWlnWk5tdjg1VFlNWUNCQ1NKV1VNcVp5STRPZkxWZHdnMS96?=
 =?utf-8?B?RXRDMFhoOXUyUUtoR2RsbWNweHN5V3djbFRoMGg1NTduL29xZENWVHdaMjQv?=
 =?utf-8?B?QnZyRzNmOGhLMndLUGQwQ294YnRNU0lWQjFWOE9jYWlCUENTYnhKYVA1amkx?=
 =?utf-8?B?TmVTWjJUcFMzK25MMVUrRUlTeEZ5OU5FazNjd1lzcldZa0dXaVNhVGdwYnBO?=
 =?utf-8?B?cU5VOVVRYkNpNzF6WWxlMW50bk16RERTTWZHOWdDdVppbGcxVXJjVmNSMEhn?=
 =?utf-8?B?QWhkTUlFcDZMRDFmN2hYVUlPV2xvZklIenVSb1N0YkxzeXlYQ3lYVnhjdlB3?=
 =?utf-8?B?V1VPV1FiQ3FQOGtDZk9zVmpteExoNk5qdCs5NWVqYlZiTldJdmtSVTQ5a0FW?=
 =?utf-8?B?MVoyOHU4c3E0eW5nK0lpbE56K29GSXcyV3NaanowWUJGVlFLeVptYlJ0VUxk?=
 =?utf-8?B?R0ROeEROMVhpb3lYYlpZUGdtTndYVCs4eGNVVTdQMnZvbCtIUC9NKzF6NC94?=
 =?utf-8?B?TEJLSlZJOHFwZzRLTWxGeHdvL0hqN1hBSzdSdFN1Zis2OFFuYWlTRUdtcHNp?=
 =?utf-8?B?QVM0a3d4Z3lXak9uZGNRakR6c1dXaWlkaDhhd0k2ZHUwNmdzRzdUV2l6aEZK?=
 =?utf-8?B?dlNJTXFrK0RESHJ5NEpJeFRyNHFKekZIcW9vMTZaR1ZnM2hWVVdtci9MODQ1?=
 =?utf-8?B?U0FNZGhNTHBmRHA2a290M1E0OHVsanhKMjM2NmxkM1BicVFuYWJNdTcvVlZK?=
 =?utf-8?B?TUh4ZWZXUWJEcHVLUER6MTBPTU01SUhoeEFrLzJ0WFhyUW5DL0x0TDYzNEdr?=
 =?utf-8?B?eE1hNWRGWE1XaXRRVFVuZG1weVg2c2xJK2oybUZPK3BGMCtrZHFiZVVWbXph?=
 =?utf-8?B?UVFoUWJiTklGUHZ5aG5kYmJ2T1NRT3paamE3Z3BDWDloWlRIM1l3UC9lRjhB?=
 =?utf-8?B?Skc4Zy9XUXIyUFo5MVF6Tjd1NWE3TUg1SUNodEVCVWZQeWhjTUNqMm9VK0FO?=
 =?utf-8?B?aEVXZnRUVENuUnB3NDhVZnBmNXVCZGJ5YnhMZ2hoWUhudzFoYVZHS0Z0VENv?=
 =?utf-8?B?VHZBVTBnOEROYlhsZm9rUFZPS0lhdGRTQVJIVVlMZnNiU1JSSUFNc0lHV3gv?=
 =?utf-8?B?WXVtanhRYnR3UllidHU1MzB6NlNKQ1dOa0kyT0x3d2cvd2Uwa3RUdkxKcFJa?=
 =?utf-8?B?OWRUanJWdVpyU3RZUVJIbmd0NFdCS05TZVZjamtjNmVCTy9WRVBmdktaa3NC?=
 =?utf-8?B?Zi9ycW1ZdkYvUzhidjFZUy91cDdwYk5odEpncXNLd0RibHpUS1NZVzhEYWlR?=
 =?utf-8?B?SkJIZE5kVGl1d1FPdkxIeW9DU05JQVVKbUgxS0FrcWZGTzNGSDZucE42U0d2?=
 =?utf-8?B?dGZQeXJ5VzZnUkpnVWhwWng1SEx3Ukh3TWRXMXdSaXk1VCtMREk5b0F3TzY1?=
 =?utf-8?B?VEYxTmJsTXhWV1EvbGlSSFUrcEpXM0tUWGdtc21EUHJaME8rWE1uay9pa0JE?=
 =?utf-8?B?eFkyYjh1d1FOUnJkVFlEV0FaNjJRZWRQMXFwRVdlellFTjRyVDJNdWhwcHJH?=
 =?utf-8?B?VG5oTVRNZUVuS09EeVoydjZqZlNMeDdVZ3Z6YzEwTHIxdXNIM3dOZGRrQXZt?=
 =?utf-8?B?QXkwbTlBSUliL0U5UzA4K2hEZzB5Wnh4VUlQTE9rQlNtSFhpM3lVYncyMkwr?=
 =?utf-8?B?SW94UXhoM0VPcWdhMWV4YVc4WDVxdW5DS1g5cGhxeVNTVkxzT1podTFFQS9u?=
 =?utf-8?B?eS9rSGl4V2hxRW1NL1IwbEM4VE1PeS9jTVhld2NNOVdoNi92Mlp2bUcyZE9Y?=
 =?utf-8?Q?MX0EiXBy5echkQR9tPnvfucmh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef508e92-e74f-4528-ba84-08dc3e6f8644
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 06:26:29.8316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7P62Foxs5kUzLDQrcpQ/SAoe3St7LYobWIIZDi2rpSheYZ5OCMEMVe0Xpt7VIY991GXXbQdhpNQ0moflTxHTWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

On 3/7/2024 8:48 AM, Alistair Francis wrote:
> On Thu, Mar 7, 2024 at 5:13 AM Atish Kumar Patra <atishp@rivosinc.com> wrote:
>>
>> On Wed, Mar 6, 2024 at 4:56 AM Wu, Fei <fei2.wu@intel.com> wrote:
>>>
>>> On 3/6/2024 8:19 AM, Alistair Francis wrote:
>>>> On Mon, Mar 4, 2024 at 8:28 PM Fei Wu <fei2.wu@intel.com> wrote:
>>>>>
>>>>> The RISC-V Server Platform specification[1] defines a standardized set
>>>>> of hardware and software capabilities, that portable system software,
>>>>> such as OS and hypervisors can rely on being present in a RISC-V server
>>>>> platform.
>>>>>
>>>>> A corresponding Qemu RISC-V server platform reference (rvsp-ref for
>>>>> short) machine type is added to provide a environment for firmware/OS
>>>>> development and testing. The main features included in rvsp-ref are:
>>>>>
>>>>>  - Based on riscv virt machine type
>>>>>  - A new memory map as close as virt machine as possible
>>>>>  - A new virt CPU type rvsp-ref-cpu for server platform compliance
>>>>>  - AIA
>>>>>  - PCIe AHCI
>>>>>  - PCIe NIC
>>>>>  - No virtio device
>>>>>  - No fw_cfg device
>>>>>  - No ACPI table provided
>>>>>  - Only minimal device tree nodes
>>>>>
>>>>> [1] https://github.com/riscv-non-isa/riscv-server-platform
>>>>
>>>> + Atish
>>>>
>>>>>
>>>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>>>> ---
>>>>>  configs/devices/riscv64-softmmu/default.mak |    1 +
>>>>>  hw/riscv/Kconfig                            |   13 +
>>>>>  hw/riscv/meson.build                        |    1 +
>>>>>  hw/riscv/server_platform_ref.c              | 1244 +++++++++++++++++++
>>>>>  4 files changed, 1259 insertions(+)
>>>>>  create mode 100644 hw/riscv/server_platform_ref.c
>>>>>
>>>>> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
>>>>> index 3f68059448..a1d98e49ef 100644
>>>>> --- a/configs/devices/riscv64-softmmu/default.mak
>>>>> +++ b/configs/devices/riscv64-softmmu/default.mak
>>>>> @@ -10,5 +10,6 @@ CONFIG_SPIKE=y
>>>>>  CONFIG_SIFIVE_E=y
>>>>>  CONFIG_SIFIVE_U=y
>>>>>  CONFIG_RISCV_VIRT=y
>>>>> +CONFIG_SERVER_PLATFORM_REF=y
>>>>>  CONFIG_MICROCHIP_PFSOC=y
>>>>>  CONFIG_SHAKTI_C=y
>>>>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>>>>> index 5d644eb7b1..debac5a7f5 100644
>>>>> --- a/hw/riscv/Kconfig
>>>>> +++ b/hw/riscv/Kconfig
>>>>> @@ -48,6 +48,19 @@ config RISCV_VIRT
>>>>>      select ACPI
>>>>>      select ACPI_PCI
>>>>>
>>>>> +config SERVER_PLATFORM_REF
>>>>> +    bool
>>>>> +    select RISCV_NUMA
>>>>> +    select GOLDFISH_RTC
>>>>> +    select PCI
>>>>> +    select PCI_EXPRESS_GENERIC_BRIDGE
>>>>> +    select PFLASH_CFI01
>>>>> +    select SERIAL
>>>>> +    select RISCV_ACLINT
>>>>> +    select RISCV_APLIC
>>>>> +    select RISCV_IMSIC
>>>>> +    select SIFIVE_TEST
>>>>
>>>> Do we really need SiFive Test in the server platform?
>>>>
>>> It's used to reset the system, is there any better choice?
> 
> If we add this now we are stuck with it forever (or at least a long
> time). So it'd be nice to think about these and decide if these really
> are the best way to do things. We don't have to just copy the existing
> virt machine.
> 
We need a solution to poweroff/reboot, and sifive test is one of the
hardware implementations, so in general I think it's okay. But I agree
Sifive test looks a device for testing only.

> There must be a more standard way to do this then MMIO mapped SiFive hardware?
> 
The mapped MMIO mechanism leveraged by Sifive test by itself is kinda
generic, the sbsa_ec for sbsa-ref is also an MMIO mapped device. These
two devices look very similar except different encodings of the
shutdown/reboot command.

Probably we can have a generic shutdown/reboot device in QEMU for both
sifive test and sbsa_ec, and likely more (not in this patch series). In
this way, sifive test device will be replaced by this more generic
device. Any suggestions?

>>>
>>> Probably I can remove the "sifive,test1 sifive,test0" from the
>>> compatible list in fdt, and only keep "syscon", I see opensbi has
>>> already removed that support in commit c2e602707.
>>>
>>>> Same with the goldfish RTC?
>>>>
>>> Although the spec doesn't make RTC mandatory, it should be a common
>>> practice having a RTC on server, so I add a RTC here no matter it's
>>> goldfish or not.
>>>
>>
>> The platform spec says
>> HPER_070 : A battery-backed RTC or analogous timekeeping mechanism
>> MUST be implemented.
>>
Thank Atish for pointing this out.

>> Can we consider goldfish RTC in this category ?
> 
> I think so, although I haven't read the spec yet :)
> 
Yes, I think goldfish RTC falls in this category.

> My point was more that if we are going to implement a new machine, we
> should aim to standardise on things that other
> machines/servers/platforms/architectures do. Some of the things in the
> virt machine are historical because that's what worked at the time.
> But with a clean slate design there might be better alternatives.
> Obviously while still sticking to the spec
> 
>>
>> But I want to discuss a larger point as the server platform/SoC spec
>> defines a bunch of optional requirement.
>> Does this platform intend to be a platform that is a superset of all
>> those options or allow optionality in
>> the platform as well ?
> 
> Generally I feel that QEMU has the luxury of just supporting
> everything. If there is an optional component created by the machine
> it generally is fine if the guest doesn't use it. While creating
> complex configuration options is a pain for users
> 
The primary goal of this reference machine is for compatibility, so the
mandatory ones should be integrated if possible. Regarding the optional
ones, I think it's okay to have if they bring the convenience, and I'm
open to it.

Thanks,
Fei.

> Alistair
> 
>>
>>>>> +
>>>>>  config SHAKTI_C
>>>>>      bool
>>>>>      select RISCV_ACLINT
>>>>> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
>>>>> index 2f7ee81be3..bb3aff91ea 100644
>>>>> --- a/hw/riscv/meson.build
>>>>> +++ b/hw/riscv/meson.build
>>>>> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>>>>>  riscv_ss.add(files('riscv_hart.c'))
>>>>>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>>>>>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>>>>> +riscv_ss.add(when: 'CONFIG_SERVER_PLATFORM_REF', if_true: files('server_platform_ref.c'))
>>>>>  riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>>>>>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>>>>>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>>>>> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
>>>>> new file mode 100644
>>>>> index 0000000000..ae90c4b27a
>>>>> --- /dev/null
>>>>> +++ b/hw/riscv/server_platform_ref.c
>>>>> @@ -0,0 +1,1244 @@
>>>>> +/*
>>>>> + * QEMU RISC-V Server Platfrom (RVSP) Reference Board
>>>>
>>>> Platform
>>>>
>>> OK.
>>>
>>>>> +static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>>>>> +                                          DeviceState *irqchip,
>>>>> +                                          RVSPMachineState *s)
>>>>> +{
>>>>> +    DeviceState *dev;
>>>>> +    PCIHostState *pci;
>>>>> +    PCIDevice *pdev_ahci;
>>>>> +    AHCIPCIState *ich9;
>>>>> +    DriveInfo *hd[NUM_SATA_PORTS];
>>>>> +    MemoryRegion *ecam_alias, *ecam_reg;
>>>>> +    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
>>>>> +    hwaddr ecam_base = rvsp_ref_memmap[RVSP_PCIE_ECAM].base;
>>>>> +    hwaddr ecam_size = rvsp_ref_memmap[RVSP_PCIE_ECAM].size;
>>>>> +    hwaddr mmio_base = rvsp_ref_memmap[RVSP_PCIE_MMIO].base;
>>>>> +    hwaddr mmio_size = rvsp_ref_memmap[RVSP_PCIE_MMIO].size;
>>>>> +    hwaddr high_mmio_base = rvsp_ref_memmap[RVSP_PCIE_MMIO_HIGH].base;
>>>>> +    hwaddr high_mmio_size = rvsp_ref_memmap[RVSP_PCIE_MMIO_HIGH].size;
>>>>> +    hwaddr pio_base = rvsp_ref_memmap[RVSP_PCIE_PIO].base;
>>>>> +    hwaddr pio_size = rvsp_ref_memmap[RVSP_PCIE_PIO].size;
>>>>> +    MachineClass *mc = MACHINE_GET_CLASS(s);
>>>>> +    qemu_irq irq;
>>>>> +    int i;
>>>>> +
>>>>> +    dev = qdev_new(TYPE_GPEX_HOST);
>>>>> +
>>>>> +    /* Set GPEX object properties for the rvsp ref machine */
>>>>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_BASE,
>>>>> +                            ecam_base, NULL);
>>>>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_SIZE,
>>>>> +                            ecam_size, NULL);
>>>>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
>>>>> +                             PCI_HOST_BELOW_4G_MMIO_BASE,
>>>>> +                             mmio_base, NULL);
>>>>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_BELOW_4G_MMIO_SIZE,
>>>>> +                            mmio_size, NULL);
>>>>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
>>>>> +                             PCI_HOST_ABOVE_4G_MMIO_BASE,
>>>>> +                             high_mmio_base, NULL);
>>>>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ABOVE_4G_MMIO_SIZE,
>>>>> +                            high_mmio_size, NULL);
>>>>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_BASE,
>>>>> +                            pio_base, NULL);
>>>>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SIZE,
>>>>> +                            pio_size, NULL);
>>>>> +
>>>>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>>>> +
>>>>> +    ecam_alias = g_new0(MemoryRegion, 1);
>>>>> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>>>>> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
>>>>> +                             ecam_reg, 0, ecam_size);
>>>>> +    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_alias);
>>>>> +
>>>>> +    mmio_alias = g_new0(MemoryRegion, 1);
>>>>> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
>>>>> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
>>>>> +                             mmio_reg, mmio_base, mmio_size);
>>>>> +    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias);
>>>>> +
>>>>> +    /* Map high MMIO space */
>>>>> +    high_mmio_alias = g_new0(MemoryRegion, 1);
>>>>> +    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio-high",
>>>>> +                             mmio_reg, high_mmio_base, high_mmio_size);
>>>>> +    memory_region_add_subregion(get_system_memory(), high_mmio_base,
>>>>> +                                high_mmio_alias);
>>>>> +
>>>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
>>>>> +
>>>>> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
>>>>> +        irq = qdev_get_gpio_in(irqchip, RVSP_PCIE_IRQ + i);
>>>>> +
>>>>> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
>>>>> +        gpex_set_irq_num(GPEX_HOST(dev), i, RVSP_PCIE_IRQ + i);
>>>>> +    }
>>>>> +
>>>>> +    pci = PCI_HOST_BRIDGE(dev);
>>>>> +    pci_init_nic_devices(pci->bus, mc->default_nic);
>>>>> +    /* IDE disk setup.  */
>>>>> +    pdev_ahci = pci_create_simple(pci->bus, -1, TYPE_ICH9_AHCI);
>>>>> +    ich9 = ICH9_AHCI(pdev_ahci);
>>>>> +    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
>>>>> +    ide_drive_get(hd, ich9->ahci.ports);
>>>>> +    ahci_ide_create_devs(&ich9->ahci, hd);
>>>>> +
>>>>> +    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(GPEX_HOST(dev))->bus;
>>>>> +    return dev;
>>>>> +}
>>>>
>>>> We should share as much of this code as possible with the virt machine.
>>>>
>>> This function references multiple rvsp specific variables, some
>>> refactorings are needed to group all the information of
>>> ecam/mmio/high_mmio/pio/irq and pass them to virt and rvsp respectively.
>>> I see arm virt/sbsa-ref are seperated clearly and no sharing between
>>> them. It has the benefit there is no side effect between them. Should we
>>> use the same policy?
>>>
>>> Thanks,
>>> Fei.
>>>
>>>> Alistair
>>>>
>>>>> +
>>>>> +static DeviceState *rvsp_ref_create_aia(int aia_guests,
>>>>> +                                        const MemMapEntry *memmap, int socket,
>>>>> +                                        int base_hartid, int hart_count)
>>>>> +{
>>>>> +    int i;
>>>>> +    hwaddr addr;
>>>>> +    uint32_t guest_bits;
>>>>> +    DeviceState *aplic_s = NULL;
>>>>> +    DeviceState *aplic_m = NULL;
>>>>> +    bool msimode = true;
>>>>> +
>>>>> +    /* Per-socket M-level IMSICs */
>>>>> +    addr = memmap[RVSP_IMSIC_M].base +
>>>>> +           socket * RVSP_IMSIC_GROUP_MAX_SIZE;
>>>>> +    for (i = 0; i < hart_count; i++) {
>>>>> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
>>>>> +                           base_hartid + i, true, 1,
>>>>> +                           RVSP_IRQCHIP_NUM_MSIS);
>>>>> +    }
>>>>> +
>>>>> +    /* Per-socket S-level IMSICs */
>>>>> +    guest_bits = imsic_num_bits(aia_guests + 1);
>>>>> +    addr = memmap[RVSP_IMSIC_S].base + socket * RVSP_IMSIC_GROUP_MAX_SIZE;
>>>>> +    for (i = 0; i < hart_count; i++) {
>>>>> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
>>>>> +                           base_hartid + i, false, 1 + aia_guests,
>>>>> +                           RVSP_IRQCHIP_NUM_MSIS);
>>>>> +    }
>>>>> +
>>>>> +    /* Per-socket M-level APLIC */
>>>>> +    aplic_m = riscv_aplic_create(memmap[RVSP_APLIC_M].base +
>>>>> +                                 socket * memmap[RVSP_APLIC_M].size,
>>>>> +                                 memmap[RVSP_APLIC_M].size,
>>>>> +                                 (msimode) ? 0 : base_hartid,
>>>>> +                                 (msimode) ? 0 : hart_count,
>>>>> +                                 RVSP_IRQCHIP_NUM_SOURCES,
>>>>> +                                 RVSP_IRQCHIP_NUM_PRIO_BITS,
>>>>> +                                 msimode, true, NULL);
>>>>> +
>>>>> +    /* Per-socket S-level APLIC */
>>>>> +    aplic_s = riscv_aplic_create(memmap[RVSP_APLIC_S].base +
>>>>> +                                 socket * memmap[RVSP_APLIC_S].size,
>>>>> +                                 memmap[RVSP_APLIC_S].size,
>>>>> +                                 (msimode) ? 0 : base_hartid,
>>>>> +                                 (msimode) ? 0 : hart_count,
>>>>> +                                 RVSP_IRQCHIP_NUM_SOURCES,
>>>>> +                                 RVSP_IRQCHIP_NUM_PRIO_BITS,
>>>>> +                                 msimode, false, aplic_m);
>>>>> +
>>>>> +    (void)aplic_s;
>>>>> +    return aplic_m;
>>>>> +}
>>>>> +
>>>>> +static void rvsp_ref_machine_done(Notifier *notifier, void *data)
>>>>> +{
>>>>> +    RVSPMachineState *s = container_of(notifier, RVSPMachineState,
>>>>> +                                       machine_done);
>>>>> +    const MemMapEntry *memmap = rvsp_ref_memmap;
>>>>> +    MachineState *machine = MACHINE(s);
>>>>> +    target_ulong start_addr = memmap[RVSP_DRAM].base;
>>>>> +    target_ulong firmware_end_addr, kernel_start_addr;
>>>>> +    const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
>>>>> +    uint64_t fdt_load_addr;
>>>>> +    uint64_t kernel_entry = 0;
>>>>> +    BlockBackend *pflash_blk0;
>>>>> +
>>>>> +    /* load/create device tree */
>>>>> +    if (machine->dtb) {
>>>>> +        machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
>>>>> +        if (!machine->fdt) {
>>>>> +            error_report("load_device_tree() failed");
>>>>> +            exit(1);
>>>>> +        }
>>>>> +    } else {
>>>>> +        create_fdt(s, memmap);
>>>>> +    }
>>>>> +
>>>>> +    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
>>>>> +                                                     start_addr, NULL);
>>>>> +
>>>>> +    pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
>>>>> +    if (pflash_blk0) {
>>>>> +        if (machine->firmware && !strcmp(machine->firmware, "none")) {
>>>>> +            /*
>>>>> +             * Pflash was supplied but bios is none and not KVM guest,
>>>>> +             * let's overwrite the address we jump to after reset to
>>>>> +             * the base of the flash.
>>>>> +             */
>>>>> +            start_addr = rvsp_ref_memmap[RVSP_FLASH].base;
>>>>> +        } else {
>>>>> +            /*
>>>>> +             * Pflash was supplied but either KVM guest or bios is not none.
>>>>> +             * In this case, base of the flash would contain S-mode payload.
>>>>> +             */
>>>>> +            riscv_setup_firmware_boot(machine);
>>>>> +            kernel_entry = rvsp_ref_memmap[RVSP_FLASH].base;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    if (machine->kernel_filename && !kernel_entry) {
>>>>> +        kernel_start_addr = riscv_calc_kernel_start_addr(&s->soc[0],
>>>>> +                                                         firmware_end_addr);
>>>>> +
>>>>> +        kernel_entry = riscv_load_kernel(machine, &s->soc[0],
>>>>> +                                         kernel_start_addr, true, NULL);
>>>>> +    }
>>>>> +
>>>>> +    fdt_load_addr = riscv_compute_fdt_addr(memmap[RVSP_DRAM].base,
>>>>> +                                           memmap[RVSP_DRAM].size,
>>>>> +                                           machine);
>>>>> +    riscv_load_fdt(fdt_load_addr, machine->fdt);
>>>>> +
>>>>> +    /* load the reset vector */
>>>>> +    riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
>>>>> +                              rvsp_ref_memmap[RVSP_MROM].base,
>>>>> +                              rvsp_ref_memmap[RVSP_MROM].size, kernel_entry,
>>>>> +                              fdt_load_addr);
>>>>> +
>>>>> +}
>>>>> +
>>>>> +static void rvsp_ref_machine_init(MachineState *machine)
>>>>> +{
>>>>> +    const MemMapEntry *memmap = rvsp_ref_memmap;
>>>>> +    RVSPMachineState *s = RVSP_REF_MACHINE(machine);
>>>>> +    MemoryRegion *system_memory = get_system_memory();
>>>>> +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>>>>> +    char *soc_name;
>>>>> +    DeviceState *mmio_irqchip, *pcie_irqchip;
>>>>> +    int i, base_hartid, hart_count;
>>>>> +    int socket_count = riscv_socket_count(machine);
>>>>> +
>>>>> +    /* Check socket count limit */
>>>>> +    if (RVSP_SOCKETS_MAX < socket_count) {
>>>>> +        error_report("number of sockets/nodes should be less than %d",
>>>>> +            RVSP_SOCKETS_MAX);
>>>>> +        exit(1);
>>>>> +    }
>>>>> +
>>>>> +    if (!tcg_enabled()) {
>>>>> +        error_report("'aclint' is only available with TCG acceleration");
>>>>> +        exit(1);
>>>>> +    }
>>>>> +
>>>>> +    /* Initialize sockets */
>>>>> +    mmio_irqchip = pcie_irqchip = NULL;
>>>>> +    for (i = 0; i < socket_count; i++) {
>>>>> +        if (!riscv_socket_check_hartids(machine, i)) {
>>>>> +            error_report("discontinuous hartids in socket%d", i);
>>>>> +            exit(1);
>>>>> +        }
>>>>> +
>>>>> +        base_hartid = riscv_socket_first_hartid(machine, i);
>>>>> +        if (base_hartid < 0) {
>>>>> +            error_report("can't find hartid base for socket%d", i);
>>>>> +            exit(1);
>>>>> +        }
>>>>> +
>>>>> +        hart_count = riscv_socket_hart_count(machine, i);
>>>>> +        if (hart_count < 0) {
>>>>> +            error_report("can't find hart count for socket%d", i);
>>>>> +            exit(1);
>>>>> +        }
>>>>> +
>>>>> +        soc_name = g_strdup_printf("soc%d", i);
>>>>> +        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
>>>>> +                                TYPE_RISCV_HART_ARRAY);
>>>>> +        g_free(soc_name);
>>>>> +        object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
>>>>> +                                machine->cpu_type, &error_abort);
>>>>> +        object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
>>>>> +                                base_hartid, &error_abort);
>>>>> +        object_property_set_int(OBJECT(&s->soc[i]), "num-harts",
>>>>> +                                hart_count, &error_abort);
>>>>> +        sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
>>>>> +
>>>>> +        /* Per-socket ACLINT MTIMER */
>>>>> +        riscv_aclint_mtimer_create(memmap[RVSP_ACLINT].base +
>>>>> +                i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>>>>> +            RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>>>>> +            base_hartid, hart_count,
>>>>> +            RISCV_ACLINT_DEFAULT_MTIMECMP,
>>>>> +            RISCV_ACLINT_DEFAULT_MTIME,
>>>>> +            RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
>>>>> +
>>>>> +        /* Per-socket interrupt controller */
>>>>> +        s->irqchip[i] = rvsp_ref_create_aia(s->aia_guests,
>>>>> +                                            memmap, i, base_hartid,
>>>>> +                                            hart_count);
>>>>> +
>>>>> +        /* Try to use different IRQCHIP instance based device type */
>>>>> +        if (i == 0) {
>>>>> +            mmio_irqchip = s->irqchip[i];
>>>>> +            pcie_irqchip = s->irqchip[i];
>>>>> +        }
>>>>> +        if (i == 1) {
>>>>> +            pcie_irqchip = s->irqchip[i];
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    s->memmap = rvsp_ref_memmap;
>>>>> +
>>>>> +    /* register system main memory (actual RAM) */
>>>>> +    memory_region_add_subregion(system_memory, memmap[RVSP_DRAM].base,
>>>>> +        machine->ram);
>>>>> +
>>>>> +    /* boot rom */
>>>>> +    memory_region_init_rom(mask_rom, NULL, "riscv_rvsp_ref_board.mrom",
>>>>> +                           memmap[RVSP_MROM].size, &error_fatal);
>>>>> +    memory_region_add_subregion(system_memory, memmap[RVSP_MROM].base,
>>>>> +                                mask_rom);
>>>>> +
>>>>> +    /* SiFive Test MMIO device */
>>>>> +    sifive_test_create(memmap[RVSP_TEST].base);
>>>>> +
>>>>> +    gpex_pcie_init(system_memory, pcie_irqchip, s);
>>>>> +
>>>>> +    serial_mm_init(system_memory, memmap[RVSP_UART0].base,
>>>>> +        0, qdev_get_gpio_in(mmio_irqchip, RVSP_UART0_IRQ), 399193,
>>>>> +        serial_hd(0), DEVICE_LITTLE_ENDIAN);
>>>>> +
>>>>> +    sysbus_create_simple("goldfish_rtc", memmap[RVSP_RTC].base,
>>>>> +        qdev_get_gpio_in(mmio_irqchip, RVSP_RTC_IRQ));
>>>>> +
>>>>> +    for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
>>>>> +        /* Map legacy -drive if=pflash to machine properties */
>>>>> +        pflash_cfi01_legacy_drive(s->flash[i],
>>>>> +                                  drive_get(IF_PFLASH, 0, i));
>>>>> +    }
>>>>> +    rvsp_flash_map(s, system_memory);
>>>>> +
>>>>> +    s->machine_done.notify = rvsp_ref_machine_done;
>>>>> +    qemu_add_machine_init_done_notifier(&s->machine_done);
>>>>> +}
>>>>> +
>>>>> +static void rvsp_ref_machine_instance_init(Object *obj)
>>>>> +{
>>>>> +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
>>>>> +
>>>>> +    rvsp_flash_create(s);
>>>>> +}
>>>>> +
>>>>> +static char *rvsp_ref_get_aia_guests(Object *obj, Error **errp)
>>>>> +{
>>>>> +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
>>>>> +    char val[32];
>>>>> +
>>>>> +    sprintf(val, "%d", s->aia_guests);
>>>>> +    return g_strdup(val);
>>>>> +}
>>>>> +
>>>>> +static void rvsp_ref_set_aia_guests(Object *obj, const char *val, Error **errp)
>>>>> +{
>>>>> +    RVSPMachineState *s = RVSP_REF_MACHINE(obj);
>>>>> +
>>>>> +    s->aia_guests = atoi(val);
>>>>> +    if (s->aia_guests < 0 || s->aia_guests > RVSP_IRQCHIP_MAX_GUESTS) {
>>>>> +        error_setg(errp, "Invalid number of AIA IMSIC guests");
>>>>> +        error_append_hint(errp, "Valid values be between 0 and %d.\n",
>>>>> +                          RVSP_IRQCHIP_MAX_GUESTS);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +static void rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
>>>>> +{
>>>>> +    char str[128];
>>>>> +    MachineClass *mc = MACHINE_CLASS(oc);
>>>>> +
>>>>> +    mc->desc = "RISC-V Server SoC Reference board";
>>>>> +    mc->init = rvsp_ref_machine_init;
>>>>> +    mc->max_cpus = RVSP_CPUS_MAX;
>>>>> +    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>>>>> +    mc->pci_allow_0_address = true;
>>>>> +    mc->default_nic = "e1000e";
>>>>> +    mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>>>>> +    mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
>>>>> +    mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
>>>>> +    mc->numa_mem_supported = true;
>>>>> +    /* platform instead of architectural choice */
>>>>> +    mc->cpu_cluster_has_numa_boundary = true;
>>>>> +    mc->default_ram_id = "riscv_rvsp_ref_board.ram";
>>>>> +
>>>>> +    object_class_property_add_str(oc, "aia-guests",
>>>>> +                                  rvsp_ref_get_aia_guests,
>>>>> +                                  rvsp_ref_set_aia_guests);
>>>>> +    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
>>>>> +                 "should be between 0 and %d.", RVSP_IRQCHIP_MAX_GUESTS);
>>>>> +    object_class_property_set_description(oc, "aia-guests", str);
>>>>> +}
>>>>> +
>>>>> +static const TypeInfo rvsp_ref_typeinfo = {
>>>>> +    .name       = TYPE_RVSP_REF_MACHINE,
>>>>> +    .parent     = TYPE_MACHINE,
>>>>> +    .class_init = rvsp_ref_machine_class_init,
>>>>> +    .instance_init = rvsp_ref_machine_instance_init,
>>>>> +    .instance_size = sizeof(RVSPMachineState),
>>>>> +};
>>>>> +
>>>>> +static void rvsp_ref_init_register_types(void)
>>>>> +{
>>>>> +    type_register_static(&rvsp_ref_typeinfo);
>>>>> +}
>>>>> +
>>>>> +type_init(rvsp_ref_init_register_types)
>>>>> --
>>>>> 2.34.1
>>>>>
>>>>>
>>>


