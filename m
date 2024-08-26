Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88445C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 07:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siUQ7-0003Eg-E4; Mon, 26 Aug 2024 03:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1siUQ5-0003Dm-Kr
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 03:45:45 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1siUQ3-0008NG-KL
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 03:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724658344; x=1756194344;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=W8ZR8e7hCfs08/Y4VCvLOsLOfVBS2z5E1E99jByOp3c=;
 b=U1afdrrUxKzWjPCtANnhQLxU4m2YuihGi6sOv0mETGRaPjq8Z2SHbA+h
 GGl3eOPY+87kH11xftI3NYwYq75OyWQVz3rYgggpR8jNAqUPjm2IDP/9k
 5EDfjYvli6Z0vh4IPbnCILn/9www3L+DmPibJfX36yBlezr+eVbMWW4I+
 Inb0knbm9MwHL/PlqZuS4EAvHT1HtiCZ45R56JUXTnpnBGpStWYpiwvfI
 hGXWD7IOTMdOIEJn3JyqRHcUSxEHjmxwnRR8wB17YXC37VR8aZS3gkfzb
 8pxFGsrSvqhOdzlLHljxkQibqdIk6SImpIBQIPPbhyrid1SBCUli4mMsp w==;
X-CSE-ConnectionGUID: meQ5A670Rs+zlxWokBaMWA==
X-CSE-MsgGUID: 0KRlrE2dTgm4RSpYqk5TsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23243208"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; d="scan'208";a="23243208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2024 00:45:40 -0700
X-CSE-ConnectionGUID: RU6E7V+kSnGLKhr6X+EQ2Q==
X-CSE-MsgGUID: mNGV5IKnS4yKSZxvHinA2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; d="scan'208";a="67359301"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Aug 2024 00:45:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 00:45:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 00:45:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 00:45:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 00:45:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGDZe26mnaLxvdPEhfttkmQUE/WRUyowhSAvf/rBShbUDn64zxPIH2+mzrrhcbpCJzlVc4wEm+EFRLbUx//1XmDMjQs+VIboUcqgWx1YWYU0rw4SuDXgMOvUoVgHPAuBdod7BCGt9Qao13LIWFmzT+/kiwUgKaxOe6mCvugDLzS8OmJFHuOygzcrQ9W07M4gOwrKP4OesZgw5Ivjc6cJn7H5D+PXeDNHbiZt2tDRD0H1lASX+l9gXIioP9nFUV/pLzX16CSKyckOQxRSxa7V+DN309ZDUNLAhefabORX39T7pN/PUopMKxpZA6j6IBVM6nehKkn03vNiaVDQkrT41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+RmBSyxkmCanEhCqSvRU6jZAPOcasROXSuPGK5wrEw=;
 b=jfTVe2942DmAKmGl00BJFsVbDsHNGfbkey2ZbQqbTcPOcemjmUEYu7Tj5KYcbKa1QpUpO34Sf3bN5hTdHp9VrY2JNU1rOGmLJ6Tigv9TV1GMaPmzH6OlZXGRGgct3WbqbbLtkgH0+3JLGTxKETAK8EIGZF+Xmsy6xsOqvL3AR+oeOafgGv7PJLYW46PQeZFUGvgyQpiU2vk6fJd9jHDXDtCbaq+fjg+aK9aO1lyAf8sU/ebATtNSdraOL4Pq7K/kAg85XtrKrC7OEYdPgC+18wbfudHunt8fnCKyvVliW5ZtU2Kdu7LrQG9Qx5cMPG9IDlEUVOWEVDZBkRuX7hbxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by DM4PR11MB8203.namprd11.prod.outlook.com (2603:10b6:8:187::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 07:45:36 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:45:36 +0000
Message-ID: <d0dde1fc-574f-4920-96d7-86549f6ad1ce@intel.com>
Date: Mon, 26 Aug 2024 15:45:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] rust: add crate to expose bindings and interfaces
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>, "Pierrick
 Bouvier" <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
 <20240823-rust-pl011-v8-6-b9f5746bdaf3@linaro.org>
 <841befb6-5ce1-44e5-890c-4e60fcbd4fa6@intel.com>
 <itc2k.22cnsecjnvt9@linaro.org>
Content-Language: en-US
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <itc2k.22cnsecjnvt9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|DM4PR11MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 5849c77c-2639-43a7-b947-08dcc5a312dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2lFS1gwWUVnUnhKM3FEK3RrTi83QTBtZTZxNHRFTUNSS2J5Yi80MkdTVFhv?=
 =?utf-8?B?cndvS3lvVEZOMDg0bjhMTVB0cTdZczd1TnlTTE42OEZ4NXJZVDdNbEF3N3pv?=
 =?utf-8?B?VGJGMW9FRXdKU0hlRkxHT0d4NFh5bkhoekpuRCtIQUgxVEJvNWhnVVBJeWdx?=
 =?utf-8?B?dVJUaGk5TGp5VVI3RkIrUU1jczBMZkFHdHk4eVFBUXhZNXM1SDI4ZVFuZTZa?=
 =?utf-8?B?R3V2VU1uYVBpclpEb0dSQzcvdDl6Y1J3YmExZ3lpSU9FclVGU2Q1amEzNlYv?=
 =?utf-8?B?bHZob2taS0NiZzNkeTdrajFuYkJycEVYTU5QaC9lcEpYWURlaThFODF2bU1O?=
 =?utf-8?B?WTdLSHVGZ3oxMWp0OUJ1MTlGSmJZVzJpZzdCdCtVbVRNd09QYUNzU2xxT0Mr?=
 =?utf-8?B?dEp2c2lGQ2dNM3pUd1VqWWtPcGFGYVRtVGNLeVFCbllJL0llSnQxdXZsU0Z5?=
 =?utf-8?B?RkRvRTkrb21hbGhQcUFRNndzdFlJWkVpYWtrUENRNUlZRWdveFlPN2lDczNG?=
 =?utf-8?B?Y05HQTdseUc5ZldaVWZlaEM5RDZ0bXE0K1REdHYyVjVVU3B1TkROY2hxVENo?=
 =?utf-8?B?aWZ1dmtYRUoxQ3BuWCtwOVdlY1ZVdnl2VEhPdDIrNXJQV3h5S2RTdVplNTdD?=
 =?utf-8?B?aDFhUFFwdzhzaUNEQWZSM3JPUHFMNUhBMmlmc0FNeGlkWkd1VWJpRlBpYW8z?=
 =?utf-8?B?RzhodEQvd3VjdkhEcDk5V0dWdjA3N2tqQ0ZGWldiZVI2UVpmS0NrTzc0eEhz?=
 =?utf-8?B?V0psUjJpZkRzWFFiODZ6RDZNK0N5K1hLNjMyQUsyQ2Y1TmN5NndqMG0vWmxy?=
 =?utf-8?B?d0ZFZlMveExCa2haazZPUzE1dEdTWXpWNHUwSFFwVlFwZHdnUWRndXhmaW0w?=
 =?utf-8?B?ODBPNDhQZDB0RytsaTdhVlZjTXJ5aXZrdlVIazhiU3dxYTYrR25aVzJ1dEQx?=
 =?utf-8?B?K0RPQzdYcXpzRWdsaCtxZTBpZEpKU1pJeHVuK3IwWnF3S3BjWmRCMDd4bFBW?=
 =?utf-8?B?MzR6SXJSY2RSMnB3bnFhYXdJYjZHVGEyaENpTmx0bXJ3RkQrQkdQTGM3S0lI?=
 =?utf-8?B?QWE4Qm5IZTdVOTBCS1c4OWR2b01zbEpUMFZCVkVxaTRkNWs4eUhUdHVNd1lw?=
 =?utf-8?B?cWhGY0YwS2EyNjNpcU1XQ3FqYUpsNFNXUTMvMEpwdXFRZ3pBWTc2MEZXTVpL?=
 =?utf-8?B?SDA3bVlmUzFzQWFFN0V0Zm4wemF1a2Y4ZENTU081ZGl1eGp5WlFnWmtrZnFa?=
 =?utf-8?B?M2owZlZvYzVPYXpmNDJpNU01UnVyNldJR3VPNldlTFFBQ29vTzIvc2pNNHRV?=
 =?utf-8?B?Slc1My9lOHRZZkkwVDVYdFJyQkJYY0pqdFlVSXhKc3cyY2hndWdkUnJpekZG?=
 =?utf-8?B?dURkTjJwbTQ0cnBpa1U4Y2RKU0h0V0crMUdGcHNORG5FQ2lqV2lSTXY4VGJR?=
 =?utf-8?B?bFRzK0hyKzVvWkpocVdKL3hVbHlUVFB2MTIrQ0FGc3FEZXo1QXgweVhPbVBX?=
 =?utf-8?B?YSthMnJaZGNEL2dtdEowZVZDZnFyazVBL1ZUT3JuNkNXTXoybGJwVHVLTThP?=
 =?utf-8?B?SE5JOU5qTmk0bjJ3NUVCandrV081RXg2T0ZtamptV1prUlJQS2VCQTZIZnJM?=
 =?utf-8?B?QmhXcTZXNzFVREJBOElDeWJHRjlGNm12Y3dkWmlWckJOaGtOckZkNDBXdk02?=
 =?utf-8?B?N0hUY3o0VEZ5a3BLc3BJWnl3dTdnYmJSenQvVEZOWEU5ZVZYTXh2U1hUSkht?=
 =?utf-8?Q?n3VFACDMiR60yayvBg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjJRWk9HOWpHZm40WDk0T1g0bmVmTThQMFcvOEdjMUpiNzY4OEJVeFpRMVZy?=
 =?utf-8?B?czJXVE1zZ2NQNzJkOU9CWGxCSC9pczkwTno4allvUC9KVjE3NVJRTFJRaUxv?=
 =?utf-8?B?cWRjenhaS1ZSUDhpNzI3ZGVCZVB6TVJnUmkvb1VUVmxBY3pGRXNJcitjdzU2?=
 =?utf-8?B?S0x6emtqQW5CR1BGeGIreVV2TlJsYjN2cGhTZzBwcTJMdDEyOUlLMGhBT3Vr?=
 =?utf-8?B?L1RWMFBMZnJWNUFRZEdZU3ZpcGN6dGordEhIVlozd0Y3Vit6a2dCbFBXdm1P?=
 =?utf-8?B?N2FSVTd2Zk1RWkZjRWwvRzgxR2xXUmxXdmpMOGkxaEZBdTZLOXkva1Rsbmtz?=
 =?utf-8?B?RDE2ZDE5QWMzVkIzWDlmWGJSSkM3WlRGVnJJMm9iVXFOMlI5Nno4SklSa2Rn?=
 =?utf-8?B?ZFhUUWMxUkZHUmtYQnVoU3F5dzZnQ0VPbWRPdmhnMEZ2bGs1QWovbWw0TVh6?=
 =?utf-8?B?a0N0K09aM1YzYVhELzdMdWVmeXd0TkdJWVBFYTJYeklyMnlQOFZYWE5YTkRE?=
 =?utf-8?B?UHFvNCtFaFdrdWZBWmlmS3htUkZxNUE4Rm5QVXIwNCtnaTNFZyszWTVuZmxz?=
 =?utf-8?B?NnVkZWpSdkI0V0dpYmJKR2FyZFg0NDNqU2JzT3VwcDVLMHNIa0N4OHhvYXpF?=
 =?utf-8?B?ZUR2RGVXUkNkNER2aXBKQU52bFFwWjlqWW1ZYVhyTmk3dkZYSExyeHVzZ3Na?=
 =?utf-8?B?LzkvdnZ0bGlRMDZmaXNGbUJPN3dyWWV1MHE0TlVmOVNUNlJZWTIxU24xenBt?=
 =?utf-8?B?RndrZWh5ZC9nYWlHY2M3L2dOOHZiK3czU0hvdHlhd2c3N0trVjVoMWJXcFp4?=
 =?utf-8?B?L280SXVQcUs5VkR3SW1FTHRPbDVDdlMxZjlpR2JsQnBkN2VCemlMaDhSZlA1?=
 =?utf-8?B?QWtNQTBpeUtaa3BoTlNTUmxBNnh5bk9rZUdOOFhWU1RtcDRINmpCeE43K3hX?=
 =?utf-8?B?a3JJZk1raWlSdkphREZYWWQwbkNYNWZ1YkJpNit3VUFZOU12NmJPVW1URnc3?=
 =?utf-8?B?SDNteEswUUhBN09SWUN0WHk5UHQyTG9OTEVmNE80cG1SK0N4SU4yRkRKaGNn?=
 =?utf-8?B?VndIby9xRkp5czlQd2F4RDFmNTMyYmwyRyt0TzUxZXFFRG90RFNXYU1Gd1pF?=
 =?utf-8?B?MTBrQkVndHZ6VmUybDlWb0V3WXFOTHk3NWRoWFNHU3JHVlh3TEVHLzNvMHRq?=
 =?utf-8?B?bkNHUjlNQ3Y5b01uVWdLSHBQY3hUczB0dXNWVTJGLzJsTjE1K1RQKzJoK2g1?=
 =?utf-8?B?dUlXSldjb28xaTIyQnlTV0k2M2swWmh0a0U0OWxnV1FCdmlBREFiM1hEUU5S?=
 =?utf-8?B?SVRxOEtxMHl1WElkTWRrWUxaaitpa2FwSnV0ZXJzczdCbEhRdGNydFg3NzFC?=
 =?utf-8?B?WVZ5eUE4b0RpOWcwQTFMajRITFlHL05hOGpBVXNaMnd0NXpYZHhHYXRHZ0pN?=
 =?utf-8?B?eGpxbFVLbWIva3NPSFFZL0pOWlRlS01Yazg4bndWS29OMXF0YlVuVmJVOUtH?=
 =?utf-8?B?Y0c3blE5a2w0OUd2Nmppa29kM1RndVJhVHhrT29WRVlFUWxRSHR5SjlnaDVS?=
 =?utf-8?B?Y1JveTRqdUxKNE8zSzRXNEp0ZytsaWdSTjFKaTBhZzVGVGRITDhUYjZ6Q0xl?=
 =?utf-8?B?dGRrSUdLcGxnajFCZXZnVzJuV04rbHB5ckVtSXdZMDN2d0FYRERWWURqQTl3?=
 =?utf-8?B?UWQyRmw0VUpMRjNNTVppTEt1YjZyMmoyV2JRd0FiUUVuTFltbzFncThJdThE?=
 =?utf-8?B?aG5VdFVxMzVKbmFSSnRwMzZWV2xRUjJrazZNc25KTlozOWdpQjQ2cjFBNHA2?=
 =?utf-8?B?V2pQSlFlaCs5MVo0MGpOTFdpVkk5c0p1Q3RYbkF3ZUliUjJra25aVGQxK0Fr?=
 =?utf-8?B?Y09JdVRwempWdkpuT0NvN0tWcUZEbUQxVERNRzFUOFdPV0xVU0s3TVlPQ29k?=
 =?utf-8?B?dVZ1aDJDeWVnRWI4bldJclhybEZtRGNvV3IrbjRuS0JCRTBaZEVGU3pDejE0?=
 =?utf-8?B?WTBIMURrOXRNQytTRWptWC82MlNEejFCdXRKY29sb1hwNWhDQ0ZxNXpxTjB0?=
 =?utf-8?B?TEhOYkduTnZyZk9wU3U3ME1QMnFqemh5UUtLREdncUtISVVtVzJ2UVF6MWRF?=
 =?utf-8?B?Z09HajhrUkxyUnAyTUhycDg3WStaVmtlWm9jSTZVNVQrMGNxSVpoV0JZQlVG?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5849c77c-2639-43a7-b947-08dcc5a312dc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 07:45:36.7459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jx8PV7O6fM3tuGAZRCvNGRe20200uaOyQ0QvJNi5v098oNp0wXV7xaJ3kB6a36PkIkVzl3RdtgriYT0/3B1GYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8203
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/26/2024 2:41 PM, Manos Pitsidianakis wrote:
> On Mon, 26 Aug 2024 08:31, Junjie Mao <junjie.mao@intel.com> wrote:
>>> +unsafe impl GlobalAlloc for QemuAllocator {
>>> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>>> +        if layout.align() == 0 {
>>> +            g_malloc0(layout.size().try_into().unwrap()).cast::<u8>()
>>> +        } else {
>>> +            g_aligned_alloc0(
>>
>> One more thing: g_aligned_alloc0() was introduced in glib 2.72 [1] but the 
>> current glib version check in meson is >= 2.66.0.
>>
>> Glib 2.72 still supports Win 7+, so no increase to _WIN32_WINNT is needed for 
>> this version bumping.
>>
>> [1] https://docs.gtk.org/glib/func.aligned_alloc0.html
>> [2] 
>> https://gitlab.gnome.org/GNOME/glib/-/blob/2.72.0/meson.build?ref_type=tags#L509
> 
> Hm. Was there no way to have aligned allocations before 2.72? We can emit a cfg 
> from meson if glib is <2.72 and handle it differently.

I attempted to look for alternatives in older glibs, but unfortunately didn't 
find any.

---
Best Regards
Junjie Mao

> 
> Manos


