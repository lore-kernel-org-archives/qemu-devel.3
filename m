Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC12C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 02:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlIjk-00033r-0x; Thu, 20 Feb 2025 21:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tlIjc-00033O-89; Thu, 20 Feb 2025 21:25:49 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tlIjZ-00079D-NO; Thu, 20 Feb 2025 21:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740104745; x=1771640745;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pE9dqTn2730Cdk2XNUZ5TTN6alWEVEcXn3TWMZhqLTA=;
 b=ijIuWjovgJtB/Z+5K4fZZNhLnsGA2LhlncU77yYYxNjSSR9Hb0/waXST
 /oO/QhjDzRcSR3FIkJcjrucx7xpumTro4zAjKIfk9YJ7DRE4F2D0JRHma
 xw7R3Fgibg/aYsVYYXBb7Lyc62roR2l58HhhmeXH1oPDZMR8ZC+6VBwzd
 C+a+7aQXcoj5e4NDLIE4d8B7507b5e27M9aawozbgk5NogY+0lHDbZnsh
 XpkuM0D6qumn+6vhBaeXATSCiGz8fn43knCLKLUKR6jHUa2KghmPgu1Pg
 gA0phh1hZ7+tVCVz5a6+vGX4026JB6kGn6RJTR/ApcYs7HIfKQmuY0X9w g==;
X-CSE-ConnectionGUID: Jm9R9TiSR6e8du6M88Mbtg==
X-CSE-MsgGUID: XOSUtHi7Q26azxtG6ZVb9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44558119"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; d="scan'208";a="44558119"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 18:25:37 -0800
X-CSE-ConnectionGUID: gHuqseytQqyeKOdxAO6m9A==
X-CSE-MsgGUID: E+hr/1qORnWjN88STsPq+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116129463"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 18:25:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 18:25:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 18:25:37 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 18:25:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkgJQ2xDiM6gx642Aus33FMrZHXWtZJzLTwn8LTmm1T8EGX4R7lH7GUO/ptDBFvYA9IGDM+/Y9cGQLMIm6a5fb6SRBBk0zd8z/NZDvihi+v2ieadCiZO+zj0jSQ5Ub9aOXzJQ6pXflJbi+bJfZfFP1p4Vi6T3eb27oWnAJosw9xGHPFXCM6BLMbaRjLbZlsD+aYl0lzkvlyQTPMdZnXkwsYr9AOSRFhfly43636xR68WtnOA+uZrtbIZ2gtD1vy9OW16sv/m2dA1lFv22bAyhTwKeS/UAyXOPV37Vfa1lNs/auHPJAoacM+v/7vn0QfFhCXtHmfMJ12sgkjO2I3EPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmQbDNADFOudcoBkdkAdJ69oDZhMyf6abHXaFkM7kjU=;
 b=SBKuDVhYxK9kZjdX8+jVNC/5uqn6sKERX0VLYlQraoN9iONFbfDvxdGzTMXhzmWRXxc0kh+c1kBkyGZTozwQgVd+3rMhMdKmt7pPyiWPp6XimPBZScmX7rc8x8V0ZaCEXgU7QQ1/vgrnpqYnbU9j9cdmcAzG+2kp9IbstTpL9mBAX6UOpNrmHBPJqn8sxeN8B4ZuRQXX+6G+41WE8J8kfp9TIdtQi2JKNVnFSogEbibys7fT2CgyHi1MKAUgKuwFPoK+IGJGJakpHwqDMsEtzNFEm9oPGWY0LKDxCI2eClkSadLyYuAYgRHW0YN28nUnGj1duVKD/neXIUIGWMXGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CY5PR11MB6210.namprd11.prod.outlook.com (2603:10b6:930:26::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Fri, 21 Feb 2025 02:25:18 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 02:25:18 +0000
Message-ID: <75d90f78-151f-4169-84f5-cc3c13180518@intel.com>
Date: Fri, 21 Feb 2025 10:25:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] system/memory: Allow creating IOMMU mappings from RAM
 discard populate notifiers
To: David Hildenbrand <david@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, <philmd@linaro.org>, <peterx@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
References: <20250220161320.518450-2-jean-philippe@linaro.org>
 <20250220161320.518450-3-jean-philippe@linaro.org>
 <0d761daf-174d-487f-80fe-09b04902006f@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <0d761daf-174d-487f-80fe-09b04902006f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CY5PR11MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: de1f8dc9-884f-4b3e-bd55-08dd521efbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkJiSWU1YUhFZFVDaHJhOTBHNXJQVkgxNE5nMGozODEyR3AweEpJcWx1MXRu?=
 =?utf-8?B?ZkE5eVBuRlYvSkU5RGUxcVBCdWJhZjBYRU0xUVJ6NURlRUNDUEVQb0RVcFVJ?=
 =?utf-8?B?ZTI1ZnoyMjVtTFA4Q1llU1pUcC9QL1hrWEF0WGdXMzkvQzdubTVTcVl3LzB0?=
 =?utf-8?B?L3dUb0xQWUFwY3diaERkTElVaHhkcWpmY1BMdXNJY0xTU04zSFVpVTVSUFZT?=
 =?utf-8?B?N0t6dnY0NGhvQldSU3dzVytwbmxuVjFCRUFGNUk3aUlHR3BiVmFTZ3lLK3FM?=
 =?utf-8?B?aGpWdWt1TTBic1hReDdGSXF1OGhJaE9VZUlpNmlueHJQQnRxNkRGMVdmYmJ2?=
 =?utf-8?B?Ym5lenlpem04S0Z1cGphSW56bS8vb0EyaW55NHlRNitIbHVPNFRVVHNuTGs2?=
 =?utf-8?B?Y0JIVmliSkFENktTeU1zVjFwRDZ0QmRWemw1MHlJYXM1aDZpQ3EyOTQ3eWVV?=
 =?utf-8?B?SC9GY2pDVjJSS0VpcnhIRkdBT01tOUJMQUpGeGpiWE01MzRzS1lNQXV4SEVZ?=
 =?utf-8?B?WnhrKzJMS1NXdzU2THdyYUgyQU1XTmJ0WWcyZjhpOCtXQTFhSDlEZmtuSzF6?=
 =?utf-8?B?VVdlcHBNRG1WY29UMWU0WFFkMXNuRXl4QWNZTkxYbERIeERHand3TVN5anQv?=
 =?utf-8?B?M2Q4dlkzZENQS1llaDFvZDM4UDBHemErb1Y0Y29oemh2RTI1eEhUcjdDanVX?=
 =?utf-8?B?MXRoSWdZRTNQSVJSUStMa1pBeXB5VWQxMHA2cjgvNkRIU3RYTlNGWUZuRGw0?=
 =?utf-8?B?dkpXRGFvQ0wwSTdYaVZyMnFqemRYWTN6czNINzVtUjdWaHdiSUlxUHY4d0lO?=
 =?utf-8?B?dlRIa1VxdWtKajNhaldSbTIvRC9uN0VYRGFpaXAwOWxFbzQvZC9ud0pMZjZP?=
 =?utf-8?B?YW42OFFJcXNHZWEwa2pYMjZUT0IwSnFqY2lkdGx1YUlET2wyMU41M2VReDh5?=
 =?utf-8?B?bGJtZHdhUWpHQkltWkorZDByTisxaXFaVFovRnFpZEtqNEVRWUhoTnUxTFdP?=
 =?utf-8?B?OC9SQ1lRNEppejZDS09JOGN2QjF5V0dMb2tEeFYvNkFlKzAwTzNpK1lNSTFh?=
 =?utf-8?B?ME51QTBSYVI5b3N4cyttMkpON1MyWjdjQWxCU1dGcFg4SjQxaFlyd2dLcldn?=
 =?utf-8?B?KzM0eUJWTnJ6REFlZGdCTUpxNlJCdGpodTRwTm04cXFsQjdvMFpUQkRGZmNT?=
 =?utf-8?B?cWFnU1FlTEc3TzlVSTNQMzkxNStleWVlNndZUzM0YlNiY0w3TkdRNTNMUXlX?=
 =?utf-8?B?OTJZM2NpWEtMRXlqWGF1WVR5ZzZXYWVUc0NuNmlLZkdNd2RHMXlBd1I5eXJK?=
 =?utf-8?B?ejVBU1JIWEdWeVBROVRMRDZIaVhKb0pRMGx3NkRrQkxFWi9iNkhydFBpYmVr?=
 =?utf-8?B?YlNXREIzalU5MjhlOS9OdFMrelYrbG5oUGR4U3pvSVJUTEs1ZXA1bktjMm5s?=
 =?utf-8?B?OVU1QTBERlV5SkphWWNuaTluUzdyY2pMRkphT1Q2Mnc2OTBGSzBMS0MvR1U0?=
 =?utf-8?B?VEpWcVZ0RVVWa095QnNXbXA2eW5icjlVbEVIOTJtcldMekFreUhBL05IVUpS?=
 =?utf-8?B?d3E1VUxQNEFGelVienZ5VWRYQjgzb3dVRFJtenhhc2VGRE9jVklacVh5NHNu?=
 =?utf-8?B?bmVXV2N2bG1nZDhXWHNGM3E5M1FHcDJTcEsxYTFpN251VVk0Q1Zoa1ZiOXV3?=
 =?utf-8?B?ZkV6cFZVQ2ZOQVBmRG1PTk42SG8yTTZ3MkRUMnVndHdubGU0WkVPc2tja0Ew?=
 =?utf-8?B?d2ZJUHRzZzdlS3VWMFZaVmx2KzZNd2hFUSt1MnF1YjlqUHFGbnNlTXhTOFR6?=
 =?utf-8?B?dSszd0VNZVV6b2o0NmpST1dGRmhUNExab0x3WmdTSm9VbmllVW9kY1dXa2V1?=
 =?utf-8?Q?MqZ8ZDlXUuv0O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WldSc3JLOFd3bEtMbzNTYkNnNnVvNExUalQrOGozRzdLbFlSTisrejljVk9z?=
 =?utf-8?B?aVpnWHFuc0xna25CcUxQamxsQmJ5UkRHNEFsaE1BQWhuNUhTK2VFT3Z0RmQ2?=
 =?utf-8?B?MzdZdUovV2dCSjMycEgzUkVJTmVoeWQ1VHEvK2dFTHQvSVk1Lzd4QlF4UDU2?=
 =?utf-8?B?dUJaSDYrQ0wzMllWdmJEQTFGL0hCV240US9MTnM4UThqOEFKZXY5TXorTWlJ?=
 =?utf-8?B?cEJmWVd3OElVYXVPaU1CLzJTbUt1cnYzV3Q3eHVKelRkdGxrZjRvQTFpdlQz?=
 =?utf-8?B?MisvM2FzalFHalRWcTJoNTZMTXQ4YndubldnNHZGWTloVnhqYWpNUGpwVGZu?=
 =?utf-8?B?ZWNJMzUyU0YxU2dPWVhxTlNwVHlpZlYyeklqK25NOU5lMkZPN3lVWjAvTkpQ?=
 =?utf-8?B?a0d3M3VDK1A2VERUMGhKUHFxU3ZhNnhHRVozQ3crSlUyYTRMSGl0YnZGMTlx?=
 =?utf-8?B?dThpbVpDZ1p2ak0raDVsZWJkek13ZWtjMW1oQ1pKN2RiaVFUTmVVK0pxTEg0?=
 =?utf-8?B?QTBLRXZYdkF3T0dXdTd2YXQ2b2JJbm8zbFVoZ0Zxbzk2cXMzTHdDQWN1dUpI?=
 =?utf-8?B?OTlJQUo1OTJ6bWljMlN6MTFTRWwxdHd1Rm5VNS9zTU56aldCTWt2MDNzMmJW?=
 =?utf-8?B?S3IrY2VobDd2RVRTVm5CeTdTdUZCcFZ2VXhqQiswM0pmSkxGcXcycmQ0ZWhX?=
 =?utf-8?B?ZGdNK2VRVStIeVJaNDZWdFlseVIzS29haHN3eW9QUG1ZalhlUHdEQWlkVkR3?=
 =?utf-8?B?Y09PSXFWc2NqMmJkdmlpKzNpS3NFbG44bzNoeTgzenRmam11T3E2SGtpVS9F?=
 =?utf-8?B?Z2pWSWliNGpVU2R2MUE2OVJjK3MzSEJXZ21DcVhEZGE1UlRoNzFTaklxSUdu?=
 =?utf-8?B?Y1lnbHJZcngxVTByalhYQTRGL1ZHdzhMUjJ1ejl1WlllUEtaQjg0QUxmM0dL?=
 =?utf-8?B?TkY4UjRFUXZuaVFNK0IwM0hOWmxZZWdzNDlLWkZGQlpvak1rNnVEbEYwWHpR?=
 =?utf-8?B?WnN6S21oQWYya0ZBNlZycjViRVIwd2J0MURlNG1jek9JVUdZeVBGMjZJdGhD?=
 =?utf-8?B?YUNRWENLUzc4TFBCTFFrd0NTWXpBNXV4WHpCdVZ5NGJDU0ZZczdVSVhJQXJE?=
 =?utf-8?B?SkMwVWllbVNiVVFHTEhDRE91WlBNM3NyY2diQXN5cUZTNThlRlBBMmlVazZv?=
 =?utf-8?B?NjZrejM5SDNpUENxY3Btbk5tOHlzTFU2dmtDdVJKMWZsRG9UU2s1Uml0NllS?=
 =?utf-8?B?S3ZkYjFPRm1hNGlzTUdEWndBZnVGdURtNUd2UjN4clNvVURHV1o0WkMyVXJn?=
 =?utf-8?B?aGJneG4rU3JXNG9jTGFQdHRaSk8wV0I0SHVKWWZCSC9zY2xtdmwyTmwxM3Fi?=
 =?utf-8?B?L0k3VmV1ZzJqODdQWTBuTVpETHFFZnV2eFBySXFLU1dsS01oTTY3ZWxQVkNq?=
 =?utf-8?B?OU1EZlcydnpCZlhLTE4zalBKS1BlalZtZWdPRTZ0WExIS1QxOURMOEEvejk4?=
 =?utf-8?B?Y2tjb0tUUGFmYkEvMG9XL2p3Yk9kYmFsTzgySFMwdkpsbTRzekk0S3JoV0M2?=
 =?utf-8?B?aXRYUmdlUFdOZ1EwdHdXbzc0SzlRcEdqVEN5V3FTSXVqckpEU3lEaUZEaERO?=
 =?utf-8?B?OGdNUTNLcDBwTFVFS0RvVkUrdU95T24xTnh5b05ndDBmS0E0RnZkbGJwdlJw?=
 =?utf-8?B?MGNOR3pmaUFGSjhNUDdhNC9nKzM3N0hOdGpzY1RlMGRLeTU0TlFDeEJFSkQ2?=
 =?utf-8?B?U1Ywam9uZmxUQUk3MjJTQUs4NktIbjhzMGg1eDdLaDBWeHc1ZWNaSmQxb0RQ?=
 =?utf-8?B?QWNVMXR1bTJCaVhMcFc2UTlNZ2d6eHJSMGJ1c294dXY4dHRkUEplL0NHUkF0?=
 =?utf-8?B?QnFicDFubTJzQUc4c0t5cmhDbkQ2U1F3Y2dOckVzSDZIZENzSW8wYzhZVTAy?=
 =?utf-8?B?N3RFVXBTRTNMNGtob0RWdXF0ZjlIcm5laFJKb3Z6SFdiVlBtcnEzb24rdlJn?=
 =?utf-8?B?UFpWSFNWNkZ0UlFKT0hIcWlmMnlBMkVseU1ldnJQQkRxdjFnVzIyMTVPajFQ?=
 =?utf-8?B?Zm9RaFc1YTN3WGovT21JSm5NVDg5WG5JYWVQcGVKQjJiaEY0am1ZTWN6dW56?=
 =?utf-8?B?bGhGdVRlVXlQRldhczJJVzN1bnBqTnROL0tDOTBGRnpJRnFOVVZ6QTgwdmh2?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de1f8dc9-884f-4b3e-bd55-08dd521efbaf
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 02:25:18.4852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvAONi7Q6V46ndFR7Yy5u+3Uo1JFZDsPxR+zbDe7g+dKYS4PmUwLuOGXLiiyz/h520Ro8Y63xVeqtgMybZu8kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6210
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 2/21/2025 3:39 AM, David Hildenbrand wrote:
> On 20.02.25 17:13, Jean-Philippe Brucker wrote:
>> For Arm CCA we'd like the guest_memfd discard notifier to call the IOMMU
>> notifiers and create e.g. VFIO mappings. The default VFIO discard
>> notifier isn't sufficient for CCA because the DMA addresses need a
>> translation (even without vIOMMU).
>>
>> At the moment:
>> * guest_memfd_state_change() calls the populate() notifier
>> * the populate notifier() calls IOMMU notifiers
>> * the IOMMU notifier handler calls memory_get_xlat_addr() to get a VA
>> * it calls ram_discard_manager_is_populated() which fails.
>>
>> guest_memfd_state_change() only changes the section's state after
>> calling the populate() notifier. We can't easily invert the order of
>> operation because it uses the old state bitmap to know which pages need
>> the populate() notifier.
> 
> I assume we talk about this code: [1]
> 
> [1] https://lkml.kernel.org/r/20250217081833.21568-1-chenyi.qiang@intel.com
> 
> 
> +static int memory_attribute_state_change(MemoryAttributeManager *mgr,
> uint64_t offset,
> +                                         uint64_t size, bool
> shared_to_private)
> +{
> +    int block_size = memory_attribute_manager_get_block_size(mgr);
> +    int ret = 0;
> +
> +    if (!memory_attribute_is_valid_range(mgr, offset, size)) {
> +        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
> +                     __func__, offset, size);
> +        return -1;
> +    }
> +
> +    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
> offset, size)) ||
> +        (!shared_to_private && memory_attribute_is_range_populated(mgr,
> offset, size))) {
> +        return 0;
> +    }
> +
> +    if (shared_to_private) {
> +        memory_attribute_notify_discard(mgr, offset, size);
> +    } else {
> +        ret = memory_attribute_notify_populate(mgr, offset, size);
> +    }
> +
> +    if (!ret) {
> +        unsigned long first_bit = offset / block_size;
> +        unsigned long nbits = size / block_size;
> +
> +        g_assert((first_bit + nbits) <= mgr->bitmap_size);
> +
> +        if (shared_to_private) {
> +            bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
> +        } else {
> +            bitmap_set(mgr->shared_bitmap, first_bit, nbits);
> +        }
> +
> +        return 0;
> +    }
> +
> +    return ret;
> +}
> 
> Then, in memory_attribute_notify_populate(), we walk the bitmap again.
> 
> Why?
> 
> We just checked that it's all in the expected state, no?
> 
> 
> virtio-mem doesn't handle it that way, so I'm curious why we would have
> to do it here?

I was concerned about the case where the guest issues a request that
only partial of the range is in the desired state.
I think the main problem is the policy for the guest conversion request.
My current handling is:

1. When a conversion request is made for a range already in the desired
  state, the helper simply returns success.
2. For requests involving a range partially in the desired state, only
  the necessary segments are converted, ensuring the entire range
  complies with the request efficiently.
3. In scenarios where a conversion request is declined by other systems,
  such as a failure from VFIO during notify_populate(), the helper will
  roll back the request, maintaining consistency.

And the policy of virtio-mem is to refuse the state change if not all
blocks are in the opposite state.

Actually, this part is still a uncertain to me.

BTW, per the status/bitmap track, the virtio-mem also changes the bitmap
after the plug/unplug notifier. This is the same, correct?

> 
> 
>>
>> For now add a flag to the IOMMU notifier to tell memory_get_xlat_addr()
>> that we're aware of the RAM discard manager state.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> ---
>>
>> Definitely not the prettiest hack, any idea how to do this cleanly?
>> ---
>>   include/exec/memory.h | 5 +++++
>>   system/memory.c       | 3 ++-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 9f73b59867..6fcd98fe58 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -116,6 +116,11 @@ typedef enum {
>>       IOMMU_RO   = 1,
>>       IOMMU_WO   = 2,
>>       IOMMU_RW   = 3,
>> +    /*
>> +     * Allow mapping a discarded page, because we're in the process of
>> +     * populating it.
>> +     */
>> +    IOMMU_POPULATING = 4,
>>   } IOMMUAccessFlags;
>>     #define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ?
>> IOMMU_WO : 0))
>> diff --git a/system/memory.c b/system/memory.c
>> index 4c829793a0..8e884f9c15 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -2221,7 +2221,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb,
>> void **vaddr,
>>            * Disallow that. vmstate priorities make sure any
>> RamDiscardManager
>>            * were already restored before IOMMUs are restored.
>>            */
>> -        if (!ram_discard_manager_is_populated(rdm, &tmp)) {
>> +        if (!(iotlb->perm & IOMMU_POPULATING) &&
>> +            !ram_discard_manager_is_populated(rdm, &tmp)) {
>>               error_setg(errp, "iommu map to discarded memory (e.g.,
>> unplugged"
>>                            " via virtio-mem): %" HWADDR_PRIx "",
>>                            iotlb->translated_addr);
> 
> 


