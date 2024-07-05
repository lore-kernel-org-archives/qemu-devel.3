Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BAFC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 06:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPcFQ-0002SK-JH; Fri, 05 Jul 2024 02:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPcFO-0002Rc-H9
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 02:16:42 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPcFI-0001qh-3w
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 02:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720160196; x=1751696196;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=efcTdNXHO+r6mffxTVugxPgnFRKy5yl8yPrsOjcb/ns=;
 b=VpUQVvwDOFtAq05ucCL8bE6L7r9XfXiuWbDTDqTRhi5j1BXmz1K9oe2Z
 KvdSbjbUaB6AUl3PHSDbfDZo1kZn2hQyqMZWQJgNuIcw7xxHMQkHcTmb/
 A83mcmv0jzy5SKrM3ARUukzRgKmqNCUJ4fCwGotckLqLspEayuv/aMbTG
 UaSRnuYixMQzObeYPb3wq549KxgVRPKrDTO8aF9JmgAIqkUd9Mw76Edf7
 h8C5VcC6lD/KIS/KuOTIn+uiQ004vIEHovWml0KJWNNstoxpgxAUBpRd0
 0Q/zBbPIOBkXodlhEAanUhATmrQjOgmu5RobBfYRNksT04xqVH8FomD3C g==;
X-CSE-ConnectionGUID: yFPviwrjTvmoAwxhihPnMg==
X-CSE-MsgGUID: hbSolczhTWWgP+4oFCpJxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28045247"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="28045247"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 23:16:33 -0700
X-CSE-ConnectionGUID: bEfv3XkPR7GzqthI4brEqg==
X-CSE-MsgGUID: C55h6cUzQkuWPVQvziKQJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="77930617"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jul 2024 23:16:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 23:16:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 23:16:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 23:16:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 23:16:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq9bnLe4b0qPSTptVL1gz/3JGdjWigit4gG3bNxJCBhneGrBZbepWAgJItnuPlxNSM99A522EATlpTjGKXpp4F/B6CTBtGiOTEZZ5z/bZ6E3h80AuP6jE0N3R3s+R6Ee973SSBTLdLRw85eXcY+I3CkOAZXLH8G6/sSWdVGYpJgDqZ+2YX62t3FNt2VYsjb1X/XvVVmOrtUPuPALW0VUxpsWcZ4gfRvnaBDhgHkx1dHJQs9BQgUzURv1wLq6bBKK5UWpFOcFkEoPoD29kLAP0aNfm9OGHy0ouNy43kb2SO9UyHunF/54Hhi8nZp4jCREXjod7RNMhqeKvZwqFZTeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aEQNAJrSucXHRN/lE+0ip3kIjawMQOl2Piyf+UXyX4=;
 b=REtZ29beQ8Tzfk/FQUxZ4dz+vJwpyE+V/Y9WIwyxxwsAU/DJnAUu31lxyQnPbiN//kVYEbWIyPBqRJ4o0Xd6kk9WAANNn4DoMdJCpww2v55lnlZ28lp5ZaBtFRtAin9yU6UjBb7p2mc2JGcg1aW1ks0JUse2frVXhC6hYpNZXCBL0IGqOfmUUf8VZZ1h/COb8eUV+48gXl2mRFgFt8f5Dk3PJOSJwOSzQIgEro5GbW7LQ111H+Hi3Eow0eDWm1G5sq1+axF18HJePVuHM63oi6Y5cqiYYuATzaZyzXc8bSDkuOkeG10o2nCjtNuuo6i8V/ySldSQRXAY7SclP9Rqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7754.namprd11.prod.outlook.com (2603:10b6:208:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 06:16:28 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 06:16:28 +0000
Message-ID: <5b461da1-09ef-4744-970d-9f8aadf7cd32@intel.com>
Date: Fri, 5 Jul 2024 14:20:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] PRI support for VT-d
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
 <311d4200-a5a4-418b-bc54-9f2c871235b0@intel.com>
 <a72b873d-9641-47f2-8306-7e9f304037fe@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <a72b873d-9641-47f2-8306-7e9f304037fe@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: a6af3482-ff7e-4093-beae-08dc9cba0146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXFkdFQvbWJSc0NMYWFlMS90OSt0NFBzM1YrYklFNXJoeXpqc2dWS0RQdVRo?=
 =?utf-8?B?K3IzMm5DS2Q4N0hxb1pBR0lRbGhIays4YmMyQ0JtdVZoTk44cnNteFhIRVN3?=
 =?utf-8?B?VVAxZ3A1VGQrYlJSZU9tWXNmRGR6YTE0VE03dmo5OU5NM3d0djNKT1hhN1BK?=
 =?utf-8?B?WjRMV2dmOWJFYWhyc292WlNYSXRzcXpBU1VneWdxbmttaHc1ZnlFakJHVFNV?=
 =?utf-8?B?RmxpaFIrUUF1VFdqQm9tbHQ2akN6eTlvZkJjOTdYZWtpaytKdjB2eWh0bm1R?=
 =?utf-8?B?ZDRjWEY2dnowU3VlWXpWRU9rMXViaVlFQ09rbkZDUWZhcDNtbUtKYVc3cVlX?=
 =?utf-8?B?VndZSEhPMmd1bE9xT3h1RGZ2d3lUdDRLZU9CN01qaFU2SFZtUWR0V1p6R1gw?=
 =?utf-8?B?dHlPanh1ZVEySlZhRk82b0hJeU1NTUtHTnFaVVNMdytHc2NadHFVRjV5VStZ?=
 =?utf-8?B?d2h3VFBMYlEvMmMraVh6KzBrSEJ3YVp4S244RTk5Sy91S2RNQkNrQU5RM0lM?=
 =?utf-8?B?OGdwK2Ewa3FINlJZMTJwYjcvbU5EN0dTMHpyWDF1YlFBZk1jRXFUTFU0S0hK?=
 =?utf-8?B?d1NVYTlWVHNvSjNjaTRWRU9CTmUrS1ZOSjJYV1kzSjlRYWJjVy9STGVZcGRD?=
 =?utf-8?B?MXFHc1VnYVFlVm1yOFllVmhlT0x0blZFNDJRbWtWNXp4Yjlwam1MUEEzc21z?=
 =?utf-8?B?NU1LTG5Pcko1WG8wUzJtd0hjOC9JY1J1SU1Rc010YWVlQjlDWWRJYiswZ24r?=
 =?utf-8?B?b0tLVTBwNE5jdVJoLzJmSUhZVGNEL1RIMFo4dEVwLzdPK0NITmVQaGdTQjNN?=
 =?utf-8?B?VFp6THE4c3p4U250NytzQW1DZ1MwZzNYWnBpYlZmaStuZ0hSUC9BRVU5YzZh?=
 =?utf-8?B?dVZtSkY1STdWeVR0cmFUMXpOUkNMYytpRjhnT2VRSXVUL1UwRkdKNjJtNjA0?=
 =?utf-8?B?czRPMmw5MUV2NTV5eFBiRlN0clNFOHAyWThFT3YrZVhqRGlVdS9PNDZoc1hj?=
 =?utf-8?B?VFErVEVGYjF1WVhuQnFjZGpCSFhJQ2o3U3ZEbEpKV3hBZ01qbkdCMi9QWkxP?=
 =?utf-8?B?QWhyNFQ0WTAxVU8rMDRPNGJnaGxQUUFVbFVDNUczazhQZWY0R0VCUFN1dnlZ?=
 =?utf-8?B?WEFMTjQ1d3UwNTQ5dS9Nc0hwTDdMd2V1VWIrUXAvWE95OU5EUzVJQmp6WDZX?=
 =?utf-8?B?Y0JsU3hRMlVwNjN6b0ZKaFFVQ1ZQQ01sUVhEZHR6SmE3cHFhNkZVdlczUnZF?=
 =?utf-8?B?Vk9MUm1Ya3B4T0ozdEdXT1NOWDBJeDR5eHhTTEdQa25hVW5nL080M2hJYWlQ?=
 =?utf-8?B?akNmMVl6QndqTkZSRi9zWE05cDF0OGxqY2FzemQ0MkVPWFFBak5GU1FsdWpu?=
 =?utf-8?B?M0tiRy9FUmlTLzIrcnQ4NDFVY1NZUlVRMWJ4Nk5KcUpqTFU2WHBoeHFXbEl1?=
 =?utf-8?B?dzJuUWtYMVlrd3MzZmxRdkhHZGhXaUxUTmhoaEhFbUNSZlVHaDhxTmIxNmtV?=
 =?utf-8?B?NjhVbmNuNERCcUxZdHpPb1pVMTBBVzZUcDRmdmdSdmxmMWx1RXN4WmFpQmlu?=
 =?utf-8?B?NE5RZExHbDVxMzdLT0FkM0FvUmIyM3FQczRMNzAzeFJMVkNMMkF4ZWlGdEhF?=
 =?utf-8?B?aDdjdml1YlFsRW9XTjZHUXY0S2tVZFRmMURQZExoRFYrTjNsaHpIVTdtVWdJ?=
 =?utf-8?B?OFpJSnY2QzArUDJzdkV0MWl3UlZDSGZLWmJwK1UxLzdDN0FpNDFab1cycnN2?=
 =?utf-8?Q?m5Uw7sIvNe7KTkG9Zg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm5XakhySDFnMkVwWW9DSWtHSjQ0WUhXbG9kVEM1MFNXSnZvNjc5Si8wUStL?=
 =?utf-8?B?MFVYa3l1am1vYUtldEZ5ekl1MGU2Q3FMTCtUQ1E5clIyT2MzOFhHejdyemVX?=
 =?utf-8?B?ckUyd3hPdlN1UjB5Ynh0RTNsUE8wcjR2ZlFzRzd5aWtoT2tpeWZ6cHdvTi9n?=
 =?utf-8?B?UnZuaU1QTk8yUmI3WmNQMVNWR0dkZjJzbUh4VHIveEVLYUVQUHQ0NXp0OFBi?=
 =?utf-8?B?UGlPdHBMcDRSTk5ZVUJwSWVMSVM5YytRY3luaDJqOFdFMCs5WGJrOEFzSHoy?=
 =?utf-8?B?N05waDRoSFBEOVpWc015VHIwOERtRGl0SklsWHhKYU9kNE5LZktkdFhLTWpu?=
 =?utf-8?B?b2UwYldXdG9WcnNLeWRFbjQydkZ5NUtQZnJDTEhEVTNIYmg4aVJMeGh0VW0z?=
 =?utf-8?B?OGNwZHM4ellTb1c0K1RJbWZMN3lSTmlJTG1ieFpMaUpaSFN4RUtWWU5FVUsw?=
 =?utf-8?B?Y3hEM293RUcwVXp2NWphZUcxaFAxZ0pFaXpCeXdnTm44MTJyNVJwT0gxdlBN?=
 =?utf-8?B?OXdMeUpNZDlFQktnRUpleFhPb3haOGQ2aFROazNrMVo4ZG55NUZYUXUwaVhx?=
 =?utf-8?B?UVp4OElQdFA5YVpEcUFXSTUwS0pCb0NTUG54TUthckx1UDRxYkM3Q0VNWms5?=
 =?utf-8?B?Q1d1TkgrTGU5cXRWWDJ1aDduN3FqSC9pVXVJenB0N3U0M3RrT2xmQytkMlhZ?=
 =?utf-8?B?dzZQbUlDc1lWR3BlbHQyK1ZxeUxCYml5elQ0ZFdGSi9KVzB1bHVja1B6ODdl?=
 =?utf-8?B?WEJDditGYm1vOEwyZ3NnUlFtMDFwMEhVbkFaVTFVOGRhVGxmNXhWODhMRWpF?=
 =?utf-8?B?WnhUZHVCMzNtNElLbGcxZWtvbTZ3L3IvajVXYzQrb2ZVKzh5REJDQmg4b3Yy?=
 =?utf-8?B?bGlGUUprWHNBSkhodlA1ZCtZQTNaN251alJYc1ZKR0wzWjl1WlY4Tm1yZkRG?=
 =?utf-8?B?SjdNbWtHTTY5YUtCVVc4S3B0TkVkN1p5QVJLd1NQM1ZucHhud2dyWHA2NFZC?=
 =?utf-8?B?RElQSWlQNGZMM0VJTXNqSkNkSnZtcWVKeThkRWFjVW5tRndTV3lCMmxLcElV?=
 =?utf-8?B?Y2VIY1BjSmQ0dTY3ZFEvaEx6VDYvRXE2R29DSDZ6QWJQaEx2bGN2a0ViYnpo?=
 =?utf-8?B?SlVtYnVqanB2TnhYTjJGQkJNQlhOb3RXK0IvK2tYTU9kNG1iQzBYUEZPRWs2?=
 =?utf-8?B?RVY5NS9YTTEycWxFbHlwWXRvTVJqQS9OcmlDOU4vemlzbnJqbk5YRzMrYTgz?=
 =?utf-8?B?TkFWN1JKYm02REVyUVdESzFvd015TWc4R1FaN0Jsb1Jkc1JlTEs4WUhCR3Zr?=
 =?utf-8?B?b0xEcE9rYjBUQUxrVmV1Y3VkSTRIYzI3RnFXc0xXNWpJeUhVaWRsSWJGTTZz?=
 =?utf-8?B?VFNVUkl4bEhWK21ySHZ1WHlROTVPY2R6QkV5T1lJazhQcDkwVWZDVkFBTUNi?=
 =?utf-8?B?cE5iNGw2QlNxaGE4SDAwN3ZOaURyUEY2dUYrRW9md1JjYW15amp6RWpvMjJu?=
 =?utf-8?B?Nzl1M0xiOGd5UEpGOElxWGhFVk96cHZoVjFucmd1cURYbU9oS2pGT1VWRG9n?=
 =?utf-8?B?UUVLR21jVlBCVGdycnBYcy9rREpsK05za3QyTXhXTGozMjcyRWR1WS9LSllw?=
 =?utf-8?B?WjB2ZCt2ZmpscTBKQmJaZEVpY2JMQ2dWNnhWVHBDbjVZRmdrOFVMZk9vWHBK?=
 =?utf-8?B?dnVNQ01YelpOTUk3ZURPelkybVFLZ0p1VG9tN1hGUDRFazZsUmN6MzIzbW1v?=
 =?utf-8?B?QWUyVGlvekR1T1JHMXNyNkFmT2RScGxMVHRIam1FT3dmU1U3RmpLa0NRUEIv?=
 =?utf-8?B?SEdNUW11ejZyOEFpNTFWOWJYV2k4UWI5OC9mMGsyN0lzNXJ1VTdXWm5qSDBq?=
 =?utf-8?B?bnFyNXBuOEtHL3ZiL0c2MjA1dUJ6bWJySFFqS05JMVJrbzN5eHcraEdLOEZ4?=
 =?utf-8?B?SDZaV1lZQ0NjV1AwTGVINXQvQmdTWU5Gc1BndzlDenNFL3MvTzg1ZFlLZkRq?=
 =?utf-8?B?VkRvUk90c05ybXNsTS9RVk9pMk1lMlBDeTZJNHBQVmNmUnFCUGhLazBHbjJF?=
 =?utf-8?B?a0Zob21YSHVuMTVZTEh2QTlIY2ZmL3JqSzJsZ0w4OHQxYWZMZStEd0ZTaHBQ?=
 =?utf-8?Q?YoR5i2p4YfCHLQyqogXHlWWb7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6af3482-ff7e-4093-beae-08dc9cba0146
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 06:16:27.9883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVpfwImd2hk0hDCp0TqlojSp/UAv1Ex3+7K2SEL2vWWepHRD2z7ifkHaznQ9VzswOLSGx4LrZUIcVRTaHCoj4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7754
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/7/5 13:13, CLEMENT MATHIEU--DRIF wrote:
> 
> On 05/07/2024 05:03, Yi Liu wrote:
>> Caution: External email. Do not open attachments or click links,
>> unless this email comes from a known sender and you know the content
>> is safe.
>>
>>
>> On 2024/5/30 20:24, CLEMENT MATHIEU--DRIF wrote:
>>> This series belongs to a list of series that add SVM support for VT-d.
>>>
>>> Here we focus on the implementation of PRI support in the IOMMU and
>>> on a PCI-level
>>> API for PRI to be used by virtual devices.
>>>
>>> This work is based on the VT-d specification version 4.1 (March 2023).
>>> Here is a link to a GitHub repository where you can find the
>>> following elements :
>>>       - Qemu with all the patches for SVM
>>>           - ATS
>>>           - PRI
>>>           - Device IOTLB invalidations
>>>           - Requests with already translated addresses
>>>       - A demo device
>>>       - A simple driver for the demo device
>>>       - A userspace program (for testing and demonstration purposes)
>>
>> I didn't see the drain PRQ related logics in this series. Please consider
>> adding it in next version. It's needed when repurposing a PASID.
> 
> Hi,
> 
> Are you talking about wait descriptors with SW = 0, IF = 0, FN = 1
> (section 7.10 of VT-d)?
> 
> I'll move that to the PRI series.

yes. But not only that patch. When guest software submitting the
descriptors per CH7.10 of VT-d spec, QEMU need to emulate the
PRQ drain behavior.

>>
>>> https://github.com/BullSequana/Qemu-in-guest-SVM-demo
>>>
>>>
>>> Clément Mathieu--Drif (8):
>>>     pcie: add a helper to declare the PRI capability for a pcie device
>>>     pcie: helper functions to check to check if PRI is enabled
>>>     pcie: add a way to get the outstanding page request allocation (pri)
>>>       from the config space.
>>>     pci: declare structures and IOMMU operation for PRI
>>>     pci: add a PCI-level API for PRI
>>>     intel_iommu: declare PRI constants and structures
>>>     intel_iommu: declare registers for PRI
>>>     intel_iommu: add PRI operations support
>>>
>>>    hw/i386/intel_iommu.c          | 302 +++++++++++++++++++++++++++++++++
>>>    hw/i386/intel_iommu_internal.h |  54 +++++-
>>>    hw/pci/pci.c                   |  37 ++++
>>>    hw/pci/pcie.c                  |  42 +++++
>>>    include/exec/memory.h          |  65 +++++++
>>>    include/hw/pci/pci.h           |  45 +++++
>>>    include/hw/pci/pci_bus.h       |   1 +
>>>    include/hw/pci/pcie.h          |   7 +-
>>>    include/hw/pci/pcie_regs.h     |   4 +
>>>    system/memory.c                |  49 ++++++
>>>    10 files changed, 604 insertions(+), 2 deletions(-)
>>>
>>
>> --
>> Regards,
>> Yi Liu

-- 
Regards,
Yi Liu

