Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EFCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seryl-0002Eq-Gt; Fri, 16 Aug 2024 04:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1seryj-00025O-JD; Fri, 16 Aug 2024 04:06:33 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1seryh-0001fZ-90; Fri, 16 Aug 2024 04:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723795591; x=1755331591;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HHO879QpI0uwDUWuToV/HzaOC/GeWtkGYxFTJLezhF8=;
 b=jodxAZSAl0XcoHXIOIF9l8+03OcTQXe0sqyLVPSDrZuGS4/KHU+aeqW/
 wMfx4MdnKmpg3WMpvZq2dJpMdDNbcRbip9Tz0YRPxzxQIRPI3/xsG09ck
 lQA12LynPXXkJwXADCNQPnrFn01tEAHsiESDOAs1o4UVwKKG4doO1TzQ+
 m5FmvcjWmXw+c3O7N4kda9ZdRPF34TMMpVa/zjJhK9T39AyKn0MBu/xwt
 Svbq3i+oVBjegCq1xkXiswQHY7XB1MFmfwcNSHzL3VO6ER93Yzbl4dPZN
 9BoEqBXffYhlX2EeRDXrgzXzmcjDowABxrEBrAo7Wpy7lnSBMD3uSqVwC w==;
X-CSE-ConnectionGUID: JwAfAc7RTJ+MQyv46nt5pg==
X-CSE-MsgGUID: ZrtiZL+wRcKSHyFmsZw5+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="44602952"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; d="scan'208";a="44602952"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2024 01:06:27 -0700
X-CSE-ConnectionGUID: k8KdjhY6TVyufF98KUiJRQ==
X-CSE-MsgGUID: bqO0nzQXRt+qujVi1+AVRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; d="scan'208";a="59766641"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Aug 2024 01:06:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 01:06:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 01:06:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 01:06:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 01:06:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTtni5jzakOck6h9jGLAoFfnk63KlBidzB2z9nDyDWfgpriPyR5tczVa7AJ/PgbtVOL42cLu4nHbifrGgI7z6uujwU0I05se/aThwgoZI2+ufnV+bua+gg/JO4Y6gOGkiqR1wvqGYvA7YLQKe4K2OUNp+Uw4rS19cCQxiH7lNegL7K1Xz24DUews55GDROsta4Hf+qYic+jeQtpotWw0BnY7/OtYR8vb4JUOC0Xkr/CRgwcljYVdbRpR0GQV/VBuEoaxZdzvum2yeeTNsU0gRsA6sPEV4p2dSWvrzz6XwwhYsI2VWYECie4wCWR+tEw96J4Qytf4T3qPOxOjXegeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/r9OrxDJwHQLke+2JkRGN6A8S45Vor5MGNmSZm6tFk=;
 b=UntJdYQgDg3pZ2C8iYJWKpEzXfFJvZtglmmShWb1HBT78cwZIiI7+9QMXn6ZaEdNmz7za5dobDZQVDaWEezceFUC1NaLsZcjN24v2/Me3Tg/8EdIGaJEUNS9Yk0yK+WtTRROBO/yO+eB/0bIe0mM/zOk5/GAlIxXb0vZLnT9eK2FJL9GwC8hUR5Fsfc8cQ6sMsPxU3oy2ScLSZcTtHWcwSjZ/MvoOyQ7emq3LRJTwwv7xqO++OwvCXgJC4foFFMxt3FiHNdr56jAsYkjQtoCsA2064yOjkffZNOS5Z/CXWLjKSiOr2JUCixae59PeOmqsBX1VVihaTvcURtTcrNx8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by CH3PR11MB7275.namprd11.prod.outlook.com (2603:10b6:610:14c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Fri, 16 Aug
 2024 08:06:23 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 08:06:23 +0000
Message-ID: <8f5f670b-313e-4172-a04b-ff8439bc4777@intel.com>
Date: Fri, 16 Aug 2024 16:06:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Add Rust build support, ARM PL011 device impl
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, John Snow
 <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Beraldo Leal
 <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, "Liu, Zhao1"
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, ARM TCG CPUs
 <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Pierrick
 Bouvier" <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 "Hart, Rowan" <rowan.hart@intel.com>, Mads Ynddal <mads@ynddal.dk>, "Markus
 Armbruster" <armbru@redhat.com>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
Content-Language: en-US
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|CH3PR11MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bbb6f5-e388-4ae9-de63-08dcbdca5173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2pOTUJaUzN4RGM0bjNiK0JQb1VVTHBwQ0NtUFJ0RG9naTVTS1RTdE5QQ2ky?=
 =?utf-8?B?dWNUNXp4MllaYitVNUFheDdQbTBZZkF4K0V4YkhGcWF6RFdsNW9GMk11dktM?=
 =?utf-8?B?VUpSNTN3MENNRzMySndFOVV2TTl3NTNDSUlYb09uM2dqSzF2YnhrbW9ZTFlt?=
 =?utf-8?B?MG90NnMzQWNNRTk1bk5id21zTlJJYUQ4RjR6L0FCWTBMK1FyM213OGhKTHlJ?=
 =?utf-8?B?VU1FUjBxLzFya2Z3VlVyOERZcHJMMXVBR3dQODY5QzFva1Y2eDdTemg5T2hU?=
 =?utf-8?B?RzY1bzJESURqOGtZRGhaUlp4bGpOZmJ5cExkdkpyeERaajEvalpnc2JzSjlp?=
 =?utf-8?B?cy8wUzBUWStjbHhGanJUVHFZd2xtaGVNcmVWV0FqbXIyeEVFR3B2M0RaTFlM?=
 =?utf-8?B?K2E4eUhKejQ2b1l6L1JSODBnZm5vUzlwekxJK3BJdndiRDFXN3EwOWRxbjhQ?=
 =?utf-8?B?ek5yYTFxcVNBNS9ydmZWbi9yS2lhdHhaRDZKNzZ4K3pKODdaK3QvMVViTEpE?=
 =?utf-8?B?RmdUQVZkMmxBNjRrWmVFeFZiTlJPQkpaVVloTE8vL2lRMXlYK3B2Qks4bEZv?=
 =?utf-8?B?a1dJOFJLcisvZDVaektHckR0QlZLcWMvUDQvY3Q2aWFFV0NZZ0t6MmdrODBZ?=
 =?utf-8?B?ci82bDdaNkloM1pGYWxWYUkxbWZrVzcxRWptVTNlWTRaSitUNXRUanUvWVdR?=
 =?utf-8?B?aDNrQlBrUk82cHMySjFGNm4vUGd0QW5qakhLSVUwTHpybXdHOU05TlV3WTFu?=
 =?utf-8?B?RU92QjViM0R0ck5VUGpVM09TOHp3K3lBNTlMbzNwSnQxUUErZW9JZjRyamxr?=
 =?utf-8?B?S1cxUkNiRDVmVnJPc0NvMkY0WlVKbDg5VEprT0ZEaXJrdG4zdzkxb1FMa0hW?=
 =?utf-8?B?RzZ3V01DZmNNUURSdURXNlJ0OVZYZmpLNEtoU044NHlCU3pKR2N1a2w4K1JR?=
 =?utf-8?B?SHRYZXJRcUNJUWdwZEUwUTg3NkN4ZytpQUtUMFZmb0hWSUg2OW5CWWdPS0t0?=
 =?utf-8?B?Vkh3cXFMWjMzTkl4d04yaHY2bGwrem84cG5uU3Uzc0lPazZCeU9pbGtaMjhB?=
 =?utf-8?B?RWhvMU9zRU5BQU9QREtBd1U5eFFDN1hVQ3Jla1h5QXBjMVBvVkpTK0dhWlBM?=
 =?utf-8?B?aFJIUzJNTlZ6NTFURC9BbmM0c3pQOEJhMUVwTWtrRWJFU0tWYXN2NGszMHAy?=
 =?utf-8?B?YVJVdFJYSXMzTyszWVVJTWpCa1dkbEZTelAwTkFPdUtWVzVJVGJiRUMwZUpx?=
 =?utf-8?B?eTIxT1hqUmRPV0wzSUtvMXZLby83V3BiTnBZbGEzeWZRb0U0ekpCVFlBQ0dI?=
 =?utf-8?B?TFA2U3RVekEvcFdSUUxaNGJJSE9qYmhleWdrWXVPZEJhdGFWYjFWYUtpVmdW?=
 =?utf-8?B?SGI2ektoMmVPcVBid2NUYWFSc3ZranE2aytyMHdxMmo4bGpsc2NMUzlVOXNW?=
 =?utf-8?B?Ty9DOENKb0RwQ0V2ZzZ1L0gzOVRzRnlVV1MwKzhLdWs2bk0xNEQvSkpIZDVz?=
 =?utf-8?B?azhOZTBqc3JvMGlhcDlhY0pNaDVETnhjWEkrOG1hNWwvUlVNd3VMTXM4bk1m?=
 =?utf-8?B?ZmtmLzYrZnptT0tGRmgreTN2UWJyeWVxQmhTZWcvVHRKM0tBeWt2MjVFQjN6?=
 =?utf-8?B?MFZ6N3JKaU5pRExaRCtJN2lvSFBSTE40SHRDRmg2eWdFS21ROHRyc0pzRC95?=
 =?utf-8?B?Z0YwejdRSEhWa3ZFVGNyYUZZLy9RVXZCc3JZeUw2QTJ3ZVNINVhORUV0ampB?=
 =?utf-8?B?azNrN3NORlhDeWdlNGxLUzkxS2UzcVpDNy9jRit4eU1EQy9PRU0zeUlmTEcy?=
 =?utf-8?Q?Ani3yOL5Xh0tNBOWFg3SQcKSxypNrpGR3tjPE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDhQS3ZQVDRHNXA0YTE0YkFFdlZhMjlvOFF6bm91UmNQZGdWTk1UQnBBVHZ3?=
 =?utf-8?B?MVBGKzl1dno1Wlp2Q3hSRXNFV1YwTWdwSi9WejBVd2UzQlRhSnRHaWpQa2VK?=
 =?utf-8?B?Z2tBSjlrdk4rY0hweURUcG54TnZ3RWt6OVJiUk1CdW0wb1NzU3pBR2lqckpk?=
 =?utf-8?B?YkZLR0dPQnl4OWJJK2NDTVh5ZnB2SmdEakZlRUtvTmg0VWNPMy84ZEg2anFp?=
 =?utf-8?B?U3pnWW1lNG9BZnJlcENZZ2x2Y3N1WnhTQ2tBK21UVkx4Y04rVW5MV2VTdGJq?=
 =?utf-8?B?a1Z2Y1Z2K0M0eWJJS1pYcnMvS2QxV3lkeDNjbGE5TnFrNFFqNU1UK0IwUFpJ?=
 =?utf-8?B?U0RLWGgyQ2htT1hDeUZPYVhrU1lyQTFkZzZFUWRQUGtVN0tlWCtqeFFtTkd3?=
 =?utf-8?B?RFBxVmh5Z0dkUUdJN1JMT0xucEpMRWZ3YzRiQzcrUFV5aFJaSUFOTDhBUUZy?=
 =?utf-8?B?akJiY3hmU1U4UlVYTkdiV2ozcGtFNUZpcmpmWnVpWTVVenl1NDBaa1FWakp2?=
 =?utf-8?B?SVRHNlZkR3QwS1pDYW5jcXFWaWNPYmNMNVBUT0ExSXc4QjMrUCtkQWVycVM3?=
 =?utf-8?B?Z1E4WWZqR0JYcjBCbkRCNjY1QjUvbzE5UWRkUWI3QWlLTFNCdlg1UitkQUhw?=
 =?utf-8?B?RGtqNXM3dWxIOWgyWFhMdktBUjhaVHNFc0JKaW9MMUJzRXp0MjFIWjdPUjRv?=
 =?utf-8?B?MkxDL0tDbVhVSHRjZGtsdEpYT2NLQW04UUkzVWxHM1BpUExRUnpuUWlnRnVR?=
 =?utf-8?B?azdlWFBha3R5V1cwTkJqVnhVbVhDOHlsdzRKa2hVOEdCeDUrUmZKeU1Qc21V?=
 =?utf-8?B?VDdQdEo5M2VMeVNwSmgwS0Q1dTZsZG15L0I5S254RmMxWE5aRGpMb2ZxTjVT?=
 =?utf-8?B?VWttM1l2eXd6Vzg2bitvM3BvUWZTM0QrVnZTLzBZZ1Q5eFVUUW9hM1N4UFYr?=
 =?utf-8?B?eGZiZWRiWU5sYWRjTWxVVno5Z1lUR3owd2hrdlU3amJZa0Q3bks4M1ZVTHRv?=
 =?utf-8?B?bmNHRnBnSnNOd1FOOWZ4T2xsa2hhakVFejJDL0pmOVNEMnVWOGVmbUl3WCtR?=
 =?utf-8?B?Q3oraXB4cU5SZVBPNllRSVJHNWtPb0pvMmcrMTh6TmYrRHhMMzFqaWluekpU?=
 =?utf-8?B?TnZmSVJRNjdHcDFQOHpTWkZWbWkzR1JkQTIrV2VZdUhhQXFVMFpueGNaRzha?=
 =?utf-8?B?MFlCb3Y5TkYxN0JmUmhiN2FUblFJbkEwenUxdld4aVQ4OGJDdlZnNkVpN3RE?=
 =?utf-8?B?c1F4TDBWaTc0T0NlQktydjAwM0FEakkvUDRYWmlrYkZkOTVTOWRYZDUxSTdi?=
 =?utf-8?B?VCtjMEFtN0lJM1hIalE5Q0lzc2E0QUJSYjgwbm15QlpaWVJoM3JLbC9oTjdw?=
 =?utf-8?B?OUVydExrZTcraG03V3JwQUpWYm80UkNlWmZHcCtHTWhDN1BQcVh6aU9kK01S?=
 =?utf-8?B?bHVUTC9oTGZFallXZXN2Y3RpNWNkbzQvZm9nc2RSRkw4Rng0MTJ4K3Y0cG1p?=
 =?utf-8?B?L1JiM2xCY29JUVlrbDVpVGd2eTI3VlRTQmhOc2MySVF5NEtVMDhHTUlHYUZO?=
 =?utf-8?B?Sm91eTNMMDZEKzF6N2hyVURySmd6SHJ2R25YREQ2dmZMdXBrYjdmUUpjc0pj?=
 =?utf-8?B?N1dXY3Q1RDhvaGNHVUI4dEthd2NDZERuWmlOVUJPL2RhZ0lQeWlGajlab05l?=
 =?utf-8?B?U21YWTdya3RqSmFFWCtOUDRnemVvOUhTM2NkWGtjTmRPTWN2Y1FvMGgzeWdP?=
 =?utf-8?B?cE9qU3FWckU3ZXpuRmpXWS9mc1N1bHJpN1hrcEwvS2lYN3pqOHZDQ0JQS2sx?=
 =?utf-8?B?SFBicXlQcjV3QzQzaXBjMDZBZEFMV1lqb0Z2YmFkemlPNG9EbjRTakFHc2N2?=
 =?utf-8?B?UHE2ZHNCeEhzbUkxMEpNZ0JoMFBkcEFyeGQyVk9EdVphVXNaaC8rSmRyZmo3?=
 =?utf-8?B?WEhCaEFnRnV6MGlHMG81aTZNSExQWE9wU05naEwyVld2Y1Fvc21MMG03OENN?=
 =?utf-8?B?SFZqTnpaZG5teXUxb1RjMjBUUk4yRVhNdW9wcEpmc01FSUR2NGt1bG5pM1lu?=
 =?utf-8?B?ekFncHJpdlBQbUJ1M0VpeFNxbjFUTjZrRStNSXROOTlNWmNRUmtCSHFzRCty?=
 =?utf-8?Q?NhQx+hUSdP26DuMMYhOZwi8pB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bbb6f5-e388-4ae9-de63-08dcbdca5173
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 08:06:23.0647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qra88Ka0N+SDDbD7Y9ZuS1Du9gur8rxHZOp1eQ4/BmaNgy02LURcQ412GqQ/ywpQdkouNz4idHO/YKdsKnMLSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7275
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On 8/15/2024 7:42 PM, Manos Pitsidianakis wrote:
> Outstanding issues
> ==================
> 
> Outstanding issues that are not blocking for merge are:
> 
> - Cross-compilation for aarch64 is not possible out-of-the-box because of this bug:
>    <https://github.com/rust-lang/rust/issues/125619> in llvm which when
>    fixed, must be ported to upstream rust's llvm fork. Since the problem
>    is an extraneous symbol we could strip it with objcopy -N|--strip-symbol
> - Adding more than one Rust device ends up with duplicate symbols from
>    rust std library because we are linking as whole archives because...
>    constructors are stripped by the linker otherwise :( It can be worked
>    around if a single Rust library is built with all the devices as
>    dependencies which is then linked to qemu. The fix is a small change
>    which I will add either in a next version or when a new Rust device is
>    added.
> 

Hi Manos,

I also noticed that when I tried adding a second device. Some other projects met 
similar issues [1], but no clean solution seems to be available yet. The options 
are:

1) Combining all crates into one staticlib which is linked to the final 
executable. That requires generating one .rs with extern crate decls of all 
enabled crates. In the context of QEMU, different targets may enable different 
set of crates (e.g., some crates have arch constraints), thus one .rs for each 
target will be needed in general.

2) Linking rlibs (or emitted objects) directly with other C objects using the C 
linker. That somehow works (with some tricks) but is not officially supported 
and may break in the future.

I'm working on (1), but would like to have your thoughts and preference on those 
options.

[1] https://github.com/rust-lang/rust/issues/73632

---
Best Regards
Junjie Mao

