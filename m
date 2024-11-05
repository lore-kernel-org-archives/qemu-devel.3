Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07180D1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DKB-0001sk-BQ; Tue, 05 Nov 2024 01:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8DJy-0001nm-2E
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:45:46 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8DJu-0002oX-Jy
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730789143; x=1762325143;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=td22ZU2Y0A+jmHQrk/ikVpajUHKGJ+qLNSM/f3ClUEI=;
 b=k0Gw5KPi4hoR2jLpIU4rarvPZ3sioGD81qSXVCm8nrN1qFJnPvc6oAuV
 1TmFn50UkzvcKBA2qE0l3CjvwW8SLI6QBQaDK/ZGEXa1AqzLnw2Jn0SoX
 uKr9WVMRf32B/qxTz2yl3ObRNPRSxRJ4YEc+HbtjiDq3NmFHRiqj6/gvr
 XupxGMULd2pjIilSP0rhWYo2FurYzb8WoG/jC+/FWuYgvqswoUpU2HYWu
 GbhkAoQa1QW1Z6oCwhYQmX7v0UVw1fjeP+H3h4VZbHyCEOPnZIGdQoz56
 P4kBQTBATK3DrsMesds6oUtj93zRMQpqlBnCJN1W9z89KcyzZxWlpWuU4 g==;
X-CSE-ConnectionGUID: tGbOqTrlRsisNusIc43qBA==
X-CSE-MsgGUID: 7G5es9jlQmCFqsvTVLiqpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30633385"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="30633385"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:45:39 -0800
X-CSE-ConnectionGUID: MUlA8LIgSRa8z9xbl5yOBA==
X-CSE-MsgGUID: xYK6L3VVTJuXT/jak8Bgog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83838100"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 22:45:40 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 22:45:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 22:45:38 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 22:45:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVSSKY4hNO6NUzyaIB6ajvZxE7b1W/0gFKqcsy5KVjGTuhv48cbOPfEq96sAL9QmzyN1bm7sgEk0XAs5674Xds1UkKDEfOclQWBqat3febB8l8YgP/dXeVfVzefvocMLV+q/H+I+tk+1zp2eW2Qkl3ty5Kqww0wGtOQwWiJKjm+xIHWDARZ3lMK4YUEiKD/5DGGLZtkgrW4oyFIbOJzZn/bSlUySGZcFLlTBedMx8jhBwGwy2Eipnxb5dD8E2PwM/8fk77bAlTJAnHl1OJBygqtLXZj8zgG5Rpn5mfBNOfSM+5xd0CRDzuoh9GW7dWhdB4ONAAhfNG469TSCkFPRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=373qmaoFBZzWWmP6tSNvlMzBUJibGqUwTM0smyuj9c0=;
 b=ifRTD/xFpwQXoNeIxM9GyEEtN/xFUgJsxGUwcEkyYBFyVYOJO/C9cZhldq4PkFhGB3J7fcnW0LQiMq+axspfiID14eE1j6FhRcX5RcCHbjUcLrnBcf5/ffqsERLF6C5xj7NjbcBtmgcox6lQwMWIqJs/j6ujAVfX+waIOs28US9HWcxaVAoSZxbHDHGj2r1IoGbutVSRT3VU3cC5eZrnOQL/YAS0RTAegR7YEg9ZbMuaAPc847Gl4X91+/1/t5WIYBldt1+J9ByYCBxNuAfvOS+n0iFd1LfubzeKMdylHkSQMJWcsQeTMBgBZCXKAB3p0lOyLaG+J1oIXHTozKy6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB8595.namprd11.prod.outlook.com (2603:10b6:806:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 06:45:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 06:45:36 +0000
Message-ID: <e425e750-bc4f-44c8-8d99-621f98dea7de@intel.com>
Date: Tue, 5 Nov 2024 14:50:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-3-zhenzhong.duan@intel.com>
 <0e8716db-9a3a-4007-823b-6b0ef5ad455b@intel.com>
 <SJ0PR11MB6744D1EA9FCE89F58E83F7B692522@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744D1EA9FCE89F58E83F7B692522@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 152ddea8-6eee-47f4-0b88-08dcfd657431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTNDU2E3SG44MkVEVTBRRjlSZTg5aFZiMFgzVmYxeWs0NmNZRDJGMUM2Y0NJ?=
 =?utf-8?B?c09Wb2lJMzBUQWxDRlVvaXo2WEZRVDFMazBIMnJ3cEMvTjhGZkFLd0lUMXZY?=
 =?utf-8?B?bytQZzE3NVF3d2JWUHBobWdUYmhHQkR0ZE5ONk02WTA2dG14dGJTeWJxQU41?=
 =?utf-8?B?bDh0WTM0R0FvcGNQZzRMbDh4M2prMjA1QlhiMCtvbXByL0twNEVGZ1UrTTZo?=
 =?utf-8?B?Ynl4L2laemdMSWdnZ2E1RkRYV04wN3J1UVFNMDR2bUNtdVRnd3cxYUpLMHIz?=
 =?utf-8?B?dnJPdXlEZGM3YXU4SUlMSERiOTdzSnpXb0VyRTdDbk9QZmtJU2tMNjR2bmxO?=
 =?utf-8?B?YlFuNFVvZ3c3VkFsdk9aRW5GZTEzOElTdG53andLd21wc3hpakU4Qkg0T2Jh?=
 =?utf-8?B?QkJYa3h2YUs3anQxVlBmRTFlVXFydCtSZFMxRUE4aXNJdUlhOHlTNkxnaGZJ?=
 =?utf-8?B?QjBPUlJ5RFNxcDhiZXdVa0NadWVVRjJad2V0VUZYS3BWajFGUWpDK05YQUVQ?=
 =?utf-8?B?QzdIcFRCMmFmTEprNTMzbUplMnZVd3FEajcrZnM1MHZTdzlwMXg3VkRnVWE0?=
 =?utf-8?B?akF2am01WlVLTldObzY2cCtkaEJYL2ZKaXdxTStwL1FEQmZIU0gvbmhOdU1D?=
 =?utf-8?B?Q2k1dFpYeGpiWGcrU3lwWGxHTzhBcjgrenRrbCtFWUkySzNVejZwQk1JNmxv?=
 =?utf-8?B?bzhwWFVOb0hJWVdBK1ZqaER3Vk1PTlNud0RraXNjYlI0WHhxNVdmODBRdDVG?=
 =?utf-8?B?d1BHVVF5QjgwY2RQWHN4M3RieW4vdW5uUVVoYjV0czQyd1RmZ1gyNnBHT3Bj?=
 =?utf-8?B?czRzVUxnWXV4bG5KcGlMV2t3ZW1nT1Y0Tkp0SW8wRUZJcCtrdVc2RmthbHlY?=
 =?utf-8?B?ZnovVkt6endrc250b2w1NFhIRXpWWjVuclFXVUFiNVRDV3FDcU8xbVZWbklW?=
 =?utf-8?B?OXdid0xGOE4xYlpDeHd3UDZydHNoTFlnUEFnbTJVSktlYjhXQ2gyYnpNZ2xm?=
 =?utf-8?B?Wmg3RTI2anhBaDhUcjRrVXQwMTJkcFAxRGVmT0JROEltbEcwUWQvdjRTNDhH?=
 =?utf-8?B?SjdiYm40L3VhQnQ0N2ZlRCtMRVp5VHh1ZGQxMWYxN2VpRC93Tm4yRDgrUUJI?=
 =?utf-8?B?TEppay9FaWFuTm1kb0w0Qlp1SStsOHIrbnhEdC9sUjZ1Q1UxM0pHVVNpdUxG?=
 =?utf-8?B?bWx2K1lPMWt3VS9pZ1llYlV3eWhabEtXZ3ZpdDErcDJZWG9ldW03Ri9oTlpP?=
 =?utf-8?B?emtEVDhtUk5ESStyRjJRS1owanJqMThGRjhsYWJSM2xTU3FWaVlvV29MNGFy?=
 =?utf-8?B?VzAvQjZxRTFPVUk3QWR0S0F3TCs4VUx4T2xzRnA2em14R2xzaFVXcmlQSm0r?=
 =?utf-8?B?SndOTjRPbXBRRmsydnZCUVdHdFQ0ZWpHazJ6dmViY1E2VVpJa0kzYUQ4Mjdm?=
 =?utf-8?B?dnRmRGxMd0NRRWtXeTVoWFBlTFA5eGVacEpqK1RRUUtlU0gvYTA4bHZaT3Q5?=
 =?utf-8?B?RWQ2ZmVQNXkybVMwMTVkSGxTNnhCZ3Uwd1RNbTdJRm1jZHRwcys0ODEzT1BY?=
 =?utf-8?B?K1piOW5GVWxPTysvQjFta1NUUFNCcHI1OTZBaXE5ckdtMi92R1ZBWlRMRWJQ?=
 =?utf-8?B?S0VQTmFhYjA4YnpRUGhqN0dBeEFwRmJmR1hPZVZmT2tCMVQzS3Y1bnF0cnVx?=
 =?utf-8?B?a3BRVnJMSlQzZ01sam5BakNFV3F5eFlKQzcvUnhsMXcyVHA0TUc5MFBqZStQ?=
 =?utf-8?Q?wwLZElJjdchOagrM+/CHWgrNVOixddz/4dBpn66?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3diTXpEQ2grNGN0NU93K2wvV25yclhuNVdNbVJMQk5mK2JBZ2YzbHh6cVF0?=
 =?utf-8?B?Mm9ud3R2N0drZnlJQ2ZKQWpmbXJuZWFwdmo2TENpZXlCRnRsSDBNbEVCRjBy?=
 =?utf-8?B?NldGQjBNaDJyMGsrdHpYUm9NZC9PbWVzNU1VVys0NDB3Zy83bi93QTdsdTJD?=
 =?utf-8?B?K2k0TGh1Z0FaaU92K0VNbnVlWjRkQTVYUURpeDlGYUlTSEl0T0lXOVRUL1lh?=
 =?utf-8?B?aTFjSnhHSHplSnNvYnFQcGVMdTAycUJjMVdjVG9oa1RscnpJMi9TQ0pJWmRt?=
 =?utf-8?B?bFE2enhUZ3d1c2xsSWJHN0EyNGRyTE15Qk9heUZBV0E0aC9vTHA1dzQwVG5p?=
 =?utf-8?B?ZmJvZXhMSzRmVUloT1VrWVR5a295cFQ5VDVoT3ZFcFArWktHcDgwS1ltVjVn?=
 =?utf-8?B?ZG8yaVpsQmFTVXRDUjk4RFgxMERRaFNCbFg0elhpdnZuZ3ErM0gvNGdYc2pM?=
 =?utf-8?B?TEkyTTNFQ1Y3L0VXb1RKcG01R3YwZ09CY1dibjFrcGthNWE2a0M2QkZsTUNK?=
 =?utf-8?B?eWE2b29xaEhZLytna0xvQkVkTldNRUZodHZ5MGlqa1djTWVhYkZoQ1BwQUhR?=
 =?utf-8?B?SWU2bURRVjUzOFpYeTl5THJJZ05MbFlGUXZIdm9CRE5lYjNPRDEvdThjUDdw?=
 =?utf-8?B?aS9EaDY1emRrZk0xY2ZBTGpMTlIxMDJ1OGlsUzF2aDlrS2JZNGxUSXJkNitE?=
 =?utf-8?B?V2d2OG8zWmNwWVpoM0RSNWg1SStZQlkwUTRNV0xFN20zc3VSVlQxa2gwMklh?=
 =?utf-8?B?cGVtT0NpOHNiQ1YvOHBQVU1WQ3N1NTNtUjFZMlpsV1J4S0tLUERPOG8zZW52?=
 =?utf-8?B?dFNianlYcFRxVmNDZGlENzB4eTFNeG1PSStETEthSHpNeHBKLys1Wk9JOXQv?=
 =?utf-8?B?cDAvUUJaNlh2cDV0enB6VHpWRU12VC8va3FidGlLd2ZTQXRpTCtxdGdEbnd0?=
 =?utf-8?B?aVhJWEFuK0IxTjh4TVI0NEpEbFdvcWJ5aUl6a1RHL3p3cm9DOGU3T2REc2Vp?=
 =?utf-8?B?cDZ4RjdQNS92NnJuRWdPZW1IeHFxMW5hTUJtTm5zdWVLRG1aSGdGeWZ3NUd0?=
 =?utf-8?B?TmJXdHoxa01KSWw4bFYrL1M5YjJ6anBhVTBSdFpPdGlRY2ZhOXhkd1BnOTdl?=
 =?utf-8?B?ZERRVVQ2M0x1QkllUCtjVXp5Y1VtNFlNb3FNVGl3UklvaVhBN3ZmeTJQU2dN?=
 =?utf-8?B?L2JOZFl4Z3NwbElOV3JkMFNTTHpaalRsZnVtNUpxWU9kblBLdEdyMTZ0eldk?=
 =?utf-8?B?dTgzRHRpMkEzUFpKUlh0dVdHazZpZmV4WnBqd3F3VXVwVWhhZFVmTnp4cUJn?=
 =?utf-8?B?V0R4d1RYbkFGMlJNQ1pwNi8rTU5NL1NyY0YyaGJHUGR2Ny95UEdyNThoNjhL?=
 =?utf-8?B?Uml6TEl5V2I4dHNVNnFLcjJ6Y2J4MHo5YlVvRVQwUEtlSHBoTFlZcnN2VWRn?=
 =?utf-8?B?bEhEZGRqOStqTnQwNkdwL3lJVlRCZEQ3dVJVSENVY2RiMDREdkExQ3pYeElX?=
 =?utf-8?B?eUNzcWFka2htRHNoZVpHOCtpN3BsSndLdEhsS2JRRHZ5TmdCT0Zhd0VveGVY?=
 =?utf-8?B?dis5T3kxTnAvWEY4UElPbnlES3BnVnR1czV0RWNOalZwVE5ienpoVW1Oa0h6?=
 =?utf-8?B?Z2JjL1BCbExUQm15TmQwSTYxTmN4T2JJaWI1MVc3eWJWMFBGcDU2RFI2ZnMw?=
 =?utf-8?B?b21xSkdJQk9NcExmcERZdloxandYNmxFRDhMSlJWVmZZSnN4TWo4Q0ZXSnU4?=
 =?utf-8?B?UlV4RlVWU29rOWdkejUvSDRqcHhERGxTVG5XNDF3RHRlR3l5Nm5uVGo4Vlo2?=
 =?utf-8?B?UExIR2pMdHVhWFdKU2JoNWtMR3VSZlNTMWhlUFJ5ZHRiZ1FnV3kxNUNFZ0g2?=
 =?utf-8?B?Z3pzNXBGWHkxS01kdGplbm0rNDYxMStGVXQvNStDWlhTeFZuWUFWZHo2Y29j?=
 =?utf-8?B?Q3crYlIzdkVlbjZ5Ykxrd3FzV3JCUFJVNmxOdnhZaXZTalRqNnlpRjJkVjRJ?=
 =?utf-8?B?ak1QSGRiSkNiNnpiKzFVMFpBMW1EUnNCRVliZ2pFS2EySjVnV1p5K1hhTkda?=
 =?utf-8?B?Snduc1U5QmZFSUFkWmxsTlcreHY0NnZ0d2Q2T3hZVXhiUkZ4czFaZEd1S2Rv?=
 =?utf-8?Q?rmLbRnTJYYg1PTnQF/S3dqXKQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 152ddea8-6eee-47f4-0b88-08dcfd657431
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:45:36.5779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mi73dxJ/+RHwDHI4fU7/YYpuxfvrvOsoxOZkAWREPffaZWqr2irxIB5XHgjw+ogIIPlAj0h7GDX+IDUnIJNiBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8595
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 2024/11/5 14:12, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, November 5, 2024 1:05 PM
>> Subject: Re: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
>> invalidation queue
>>
>> On 2024/11/4 20:55, Zhenzhong Duan wrote:
>>> According to VTD spec, a 256-bit descriptor will result in an invalid
>>> descriptor error if submitted in an IQ that is setup to provide hardware
>>> with 128-bit descriptors (IQA_REG.DW=0). Meanwhile, there are old inv desc
>>> types (e.g. iotlb_inv_desc) that can be either 128bits or 256bits. If a
>>> 128-bit version of this descriptor is submitted into an IQ that is setup
>>> to provide hardware with 256-bit descriptors will also result in an invalid
>>> descriptor error.
>>>
>>> The 2nd will be captured by the tail register update. So we only need to
>>> focus on the 1st.
>>>
>>> Because the reserved bit check between different types of invalidation desc
>>> are common, so introduce a common function vtd_inv_desc_reserved_check()
>>> to do all the checks and pass the differences as parameters.
>>>
>>> With this change, need to replace error_report_once() call with error_report()
>>> to catch different call sites. This isn't an issue as error_report_once()
>>> here is mainly used to help debug guest error, but it only dumps once in
>>> qemu life cycle and doesn't help much, we need error_report() instead.
>>>
>>> Fixes: c0c1d351849b ("intel_iommu: add 256 bits qi_desc support")
>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h |  1 +
>>>    hw/i386/intel_iommu.c          | 80 ++++++++++++++++++++++++----------
>>>    2 files changed, 59 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index 2f9bc0147d..75ccd501b0 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -356,6 +356,7 @@ union VTDInvDesc {
>>>    typedef union VTDInvDesc VTDInvDesc;
>>>
>>>    /* Masks for struct VTDInvDesc */
>>> +#define VTD_INV_DESC_ALL_ONE            -1ULL
>>>    #define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
>>>                                             ((val) & 0xfULL))
>>>    #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalidate Desc */
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 1ecfe47963..2fc3866433 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -2532,15 +2532,51 @@ static bool vtd_get_inv_desc(IntelIOMMUState *s,
>>>        return true;
>>>    }
>>>
>>> +static bool vtd_inv_desc_reserved_check(IntelIOMMUState *s,
>>> +                                        VTDInvDesc *inv_desc,
>>> +                                        uint64_t mask[4], bool dw,
>>> +                                        const char *func_name,
>>> +                                        const char *desc_type)
>>> +{
>>> +    if (s->iq_dw) {
>>> +        if (inv_desc->val[0] & mask[0] || inv_desc->val[1] & mask[1] ||
>>> +            inv_desc->val[2] & mask[2] || inv_desc->val[3] & mask[3]) {
>>> +            error_report("%s: invalid %s desc val[3]: 0x%"PRIx64
>>> +                         " val[2]: 0x%"PRIx64" val[1]=0x%"PRIx64
>>> +                         " val[0]=0x%"PRIx64" (reserved nonzero)",
>>> +                         func_name, desc_type, inv_desc->val[3],
>>> +                         inv_desc->val[2], inv_desc->val[1],
>>> +                         inv_desc->val[0]);
>>> +            return false;
>>> +        }
>>> +    } else {
>>> +        if (dw) {
>>> +            error_report("%s: 256-bit %s desc in 128-bit invalidation queue",
>>> +                         func_name, desc_type);
>>> +            return false;
>>> +        }
>>> +
>>
>> If a respin is made, I'd prefer to move this check out of this helper since
>> it's not about reserved bit check. Another reason is you cannot find a good
>> naming for the @dw parameter. It's confusing as s->iq_dw is checked as
>> well. So put this check out of this helper may be better.
> 
> I see, @dw hints inv desc size, s->iq_dw hints the inv queue element size.
> Moving that check out will produce duplicate code for VTD_INV_DESC_PC,
> VTD_INV_DESC_PIOTLB and VTD_INV_DESC_DEV_PIOTLB handlers.
> Maybe s/ vtd_inv_desc_reserved_check/ vtd_inv_desc_sanity_check?

in that case, renaming @dw to something different would be better. At
the first glance, I was wondering if anything wrong here since dw is
checked twice.. Perhaps 'p_inv_type' as all the 256bits types are for
pasid related. Add a description for this helper would be nice as well.
This can document what each parameter means.

-- 
Regards,
Yi Liu

