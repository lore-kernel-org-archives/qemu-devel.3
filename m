Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20595CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 09:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNp80-0002pu-72; Tue, 25 Nov 2025 04:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vNp7t-0002ov-0K
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 04:14:21 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vNp7o-00039B-Dt
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 04:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764062056; x=1795598056;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=p1C7HdzvE/T5adGpzcX2d+DL/H77rQvu1dxOntQ8QgM=;
 b=IFJ3r9/LZJMHr8ep5X37b0nb07eROeKh5sQWc3FcZctKE66944LF982q
 cEeG+PG9fMfa/5qANT49+UTaRahrvqa4eZv2DCfpmIpchuWiFEJEwD6aw
 GINb7OWtj27JBWs43y9rKYnHn9Gt2ton2yjMkxiYlDr1yoq8sGHOgwfzM
 A2iOvv3HrIjRHeYQcd91gu88xvuFfXofu2Umb0mvukKQjG9dkg92AD8V9
 KZgmhRTZ7AdgxJ0NgO9e3s2RQU1duS4/vfndGEfgzrHjrh+w6FCJ+diHL
 ZDvOLGZOPH7aJajQ0LlX/les9i2g4f6EwQW1yOQpnx2emnDf2N/xUNxPY Q==;
X-CSE-ConnectionGUID: t+dzrBKNSbCRGGWS1bJtAQ==
X-CSE-MsgGUID: A6AcbzoeTveMpDzL3RkDbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76398854"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="76398854"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 01:14:11 -0800
X-CSE-ConnectionGUID: wq1qEWagRqezJSAQSEfdvw==
X-CSE-MsgGUID: laS2WCX9Q26Q1az0iiX0Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="197694388"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 01:14:11 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 01:14:10 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 01:14:10 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 01:14:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlBXss49jREJ14Sxa9zncFHpqyv7Uqa+TgOkb8xxFzAuD4BJjvUso1H5Ra35ctVzpv6B5gnU/uZ9D9chxbCY9yLFfE6ou0Tusnu/iZld/c1LS7tysuCeH7CyE/6tPsjjZ2+vs2J5KvH7rYCiXE5dA9EUWPzHrwI9OuNkzwNOIFg36FZkq0MxWNpY+ylgbmK5JgjSylyqJiFOlzxQVUiia8NdRPk/jDIZvz1r8Lcwvs1voCBe+/O0YNQURGFD3k5i8Xa8kFa17LbphRSofbznCRWKMSvZQ3EBsuVrPBtYqTrUwF/TaOtK6YpBS/pQFjpKnhzN8jx5a7+HolNcNFDQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpfjRq69i15W8e0rqHhWfzVoslak6wAkFUcT35FavPQ=;
 b=XrRAoJ6g2EROVImnR/vJwmOldrXP1WVyG/GBWSyaarxhTc4EKcPGAlcwnNZgnIUpTOG5ouiSmb0zgrT6vkujD4zyMtUDpPeVhlxdtyNG9hLwhWvdKfif50ZDEn5JrN3zJt8i5v2huX2v9gz3WU+gCchZCmKKulraoUjMc07CyUtojy+Et2q990y2RRujIzA9i52qiK9YmwMXJJ+m9NdMQ8gGLG9hSX7ya3s7hDaBOnnI6I0clLofpoE+fsyaQn+Vz2GNYlSBFkLoIBI+IqeEhKnpHU8nC0QK0TysNm/od+Fz9xqM/cgguRjuu1xFBUKqOkthYpfYvzEnJYMlgDUnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by IA0PR11MB8304.namprd11.prod.outlook.com (2603:10b6:208:48b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 09:14:08 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 09:14:08 +0000
Message-ID: <2548abcd-c4ed-4cd2-be82-43c1c22af77e@intel.com>
Date: Tue, 25 Nov 2025 17:20:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <rohith.s.r@intel.com>, 
 <mark.gross@intel.com>, <arjan.van.de.ven@intel.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
 <20251106042027.856594-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251106042027.856594-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0050.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::12) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|IA0PR11MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2ed61c-12e0-4a76-4235-08de2c02fcd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|42112799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmlsT0ZzcDVrK2dzbHc5YXBBdWdQdHppcXhvelVLRWd5QWE4ZzBPT3JkMzdQ?=
 =?utf-8?B?MUtmaEYwcDd4bldzYXVybUY2SXVaNUlQOTBaMFBUS2FYbm9TSEg5SnBLVUpm?=
 =?utf-8?B?WWFkdFZUbk02MUY4VTRJYkpnaUM1bEtFMVJUT3UzYXZsclR4ekltRDRaS2c0?=
 =?utf-8?B?V1RJYkp6TExob21NOW41dTRCSTNzWENuWlNXcytrNlBxTmgvRVJFbWtDTVMx?=
 =?utf-8?B?dkhZL2FzR0RObjcwQy9wZGpkZHFsSE5EbjhVNmNPd3FGZi9HbWhoaGlUcmlQ?=
 =?utf-8?B?bmtLb2loVWd2ekhJdmd5VWQxQ281L2F5dU5CK25zY3NmbkdJdS8vYjc5WVla?=
 =?utf-8?B?YXJNVXVZOEhPSEg4RTdiMU1wR2FYTjUwWE8xNHRRQVQvU2JkQUkxMStkeXJw?=
 =?utf-8?B?N1N6VnZlQjRFZFBxWDhyajZ4em5pV1YyYUo1dmVHWjVySlJieUJZR0VqSjhX?=
 =?utf-8?B?MkdRU2hkdnFEdGNlcnIrdWNJK0QxYzB2L3JOUS9EeUNyeEpzVU9nNEF5R2hq?=
 =?utf-8?B?TGx1Y0t1OFNKVGgzUDJ2aFg3SzZVVnpmblFDbEpDN3pkQS9kTFBkSFV5YkZy?=
 =?utf-8?B?OWtTeUc2ZGtLUjFwQ3czZ0hDd0lsd0tMM1FoLzFBbWRFZ2pHTmJFTVFvRTg5?=
 =?utf-8?B?aVJtc1diQjViZXduTjhaWGZYbk1oWmt6Q3F5VGRCU0FRb1QwV2pKUG1GR0NL?=
 =?utf-8?B?SXBmeERyUFpPaTh6UndqeUFBNnB5WEYzR2F4WlZMNkhMQW4xQ0RkRFdISWlK?=
 =?utf-8?B?dmNuWSs4Y01la1QyeG4yY2JwbXNOM1FyVkh3K3B6MnA0WEZ5THArQUxoajV3?=
 =?utf-8?B?ci82N2lrVlJlaTJNSWZSczYwR3pSQkVvbFVacWZ4QmNRWHM1SUkyNWRkOW1m?=
 =?utf-8?B?blY0M0o2VjNwTEhySGwwa0hNMnpocnhTajRNQnJmMjBXcW5naEhEdkI2S2hw?=
 =?utf-8?B?a2tHMzZ1cnU0MDU0UTNxd2JMbHZWMi9MVXVvZGdrVXRQSGxmMnlFZGZleTJl?=
 =?utf-8?B?Z2x1YUdBSWxBR0Y4VDhZMGhpUGFNTU80QnZYcHpUSmhPYVdSN3FGTXpZWWVa?=
 =?utf-8?B?SVJ0UVFhOXovOEN5SHNMdjBlYStzM0VVNm1VdDZBWEdqYzNpSmxheGtUU2x2?=
 =?utf-8?B?OVVnalZieVZhL3c0Mnl3MWxzVUk4T3pKbzNVUE5VMk9EeHI5TnVJaXZJOHVU?=
 =?utf-8?B?U3JGRGVCOG5ueGkwSElVMnFGUk9CNTdlN0Y5SU5QWUNjTTNONGs3SlZLUEd4?=
 =?utf-8?B?S09jenZFSVU3RmVha1NkR1F6eExuVzZsZ0NSQ0RyZzhoa2FwdlJYUXpTOG5x?=
 =?utf-8?B?MTNzQ0JMcUJ2aVJ1M0hXbVlGUExRUDZyckc2NEhGSitqRzA1VHBlWXlQdkd1?=
 =?utf-8?B?bVk3TUpVMENabGVKN0lodkt1bzhwTkhkczcxbkdCbkxqQ2xSUkI5cnhhNmNG?=
 =?utf-8?B?NDduTHoxVHBEQ0Y1UUp3QXp2MXAyNEdxelBPWUpja0NCc1h1eDdGWTNEZWZW?=
 =?utf-8?B?cmRtSndWRENtcjRxT0toQ1Nid3Q0Y0dhMmFqV01aS1F0RkJJMU9GZERuakpE?=
 =?utf-8?B?ZkFwb0JWQytSelAxWkZDNFRWaWhxelJ1b1dPeXdpWTVLdEU1UnY4UUVmeUlN?=
 =?utf-8?B?YkE5T3ZvMFFCNGFTNXQ5YWp6eGhneU1rMU5TTHJRaTRTMExEUXVZUm5RcmUz?=
 =?utf-8?B?cmI0LzRrdVd6N25iV2FWdlpqZ3JGM2cyRkRrTFBJYnRwdmNXM25GcHhwbVBX?=
 =?utf-8?B?RkcybDJMR2VrREtwbHE0V2xIMHBQZmNFQzlhWElzOW5SaEUrUSt1bmJlbW5K?=
 =?utf-8?B?RmpqMDZ2dnpldTZDM3NwbzJxVHFhMkg5VkNrNDhYQjVxTDk0ZTY4Q0F6SFNI?=
 =?utf-8?B?S09SMEF4WW1KczFUUHlKRW03angwVTdJK3BUYzdPQW9rMnhKOTN6dStvdW03?=
 =?utf-8?Q?/CQf5ySJYUT0Ft8vcnRonGixdRfOA8bW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(42112799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjhLOU8wL2RGZzgvcnRxY1Ntbm9IY2VGWk5qdGdna0w4b3JJalNrL1lBWUFO?=
 =?utf-8?B?NFdoZkpreEhKVE5jSjE4MVNobndTUGNGVk5QTWRRYkp2UURmZm5pK1lkcjc3?=
 =?utf-8?B?VnZ4MDB1N2l4QlIvQmdJS1dQNXlDVU1XS1YwY0RqNk1zMFZIMG5hU0tNZHhh?=
 =?utf-8?B?UGVSTythaklCWDFwR3hDUlVVNGJ4QjVHZk1DaElJZXk4SVZJSjZCQlpYK2t6?=
 =?utf-8?B?VG95UGRaMzN3VGFJM05kVTNhQUx0L2xGYm9lTHNGZzRLK2JOamJ2bUdCclBJ?=
 =?utf-8?B?NU5wbFJ5bE9BMlRFVHpRaDFGU1FHNVdWVytpWmozVStXeFUreks5djlSQ0tY?=
 =?utf-8?B?N2paT1JOeUUrWlpIU0NCc0x6WDB6RStRMnlVNUhNTTNuQ0JtSVVoUGU3T3Bs?=
 =?utf-8?B?anBMa2l0dnhWZVAxQ1dFdkpGSjE1WnJVQXJnQVhvcG01OXpjYmx5VS8rYVc5?=
 =?utf-8?B?eHlZdG1oRWJVZE5hekt5bkwxUGg3YU5aL0hvQnpOTkhBL0htbnhPZFJhV1VU?=
 =?utf-8?B?bEdlTnhWSFZRZW0xSzE3Yld1eTd6V2g0c0owcDBKbnVpb1VJekY5ZklkNTBx?=
 =?utf-8?B?TngrbDVlMko0dWo2UXR6WXdQTXdNbkpHelplYzNlYWhEZExRUHo2Q0Q5S1k1?=
 =?utf-8?B?WllUKzdVb1g3amRjS2JRM2pGc1NpMVVJeFNXUENJT0UwQnFVUk9takl2eThr?=
 =?utf-8?B?RzdiSmhkYUlQQWZkVEx5TWR4TDkvemhEMUpIdmFSdlRhaDRDOGd4d0djMDhq?=
 =?utf-8?B?aEJvRjY3d0lNOVJuS1BhU1FDdTVGakI1VGZRdERhaE51Z1o1TlJvQlc0amFu?=
 =?utf-8?B?eHo5c0d1Ykg0bktBYm5LT2lYREFOZCt2ODI0Nk8xamdKamFJdkRwaTFNN2dI?=
 =?utf-8?B?R2tjS1dCMlVYRks5OTZKZUhqRFczUGs0dVh4TERtUUlkRFhvUzRoRUEwMmFx?=
 =?utf-8?B?S1NYYkphTzlaa1Zwb3I3OS9EaU82dTZZZmR4WGxubi93ejF2OEF2ZE5Oc1Mz?=
 =?utf-8?B?RkZnQTNNTld4c1RhamlhY3AyUWZtSXVDekdjWDVlSE9iQkhVVG1NaXFON0Ns?=
 =?utf-8?B?dkt6RmpzOUR0OEhXd3NjSTcvUVIyMFpXWStlMUY2MmJWb0RWMllMTkg5Ymtt?=
 =?utf-8?B?OWNRNW5oaFFTamFwamM0WmthQWkrdDhzejBwZGtwcWRKZzV2b0U2Qi9HTkti?=
 =?utf-8?B?cGpkU3p3TzVnYTU0Z2dnOFZKd1Z1ZUt0NmZQdUlSOHBHNDNvRkpHZlFmSGxr?=
 =?utf-8?B?WHkzN2tqZWJmTGNsUVhEMy9kSkJTZlZBVktpV1ptOWRic2RQbzhoSVF4T0Jz?=
 =?utf-8?B?K01hcWRnVnpmRWR1bmhIa3JrUjdKb3RyNDBHRXdERThxS05lY1d4am5nZkho?=
 =?utf-8?B?WStrb3ZTazR2YllHaEI2aWtQZmFEWGQwMWtKQk5vaDNTUHpYbGNXc0w4NUpH?=
 =?utf-8?B?TVc2VVo2MEs2dThHaEtlMkJReFlSYnNZcjZhbjVxdkdZaUpDOThKUU93cSs1?=
 =?utf-8?B?cVhwSjhXWWRKT1pmQmJrVnQwNnhSeDEraHpMK1F0b2FZMFRxYVlDamFXcmhC?=
 =?utf-8?B?Yng4Ti9kYlJFaWhPZXpXbnZtdHYrQXlJbUtIRE1zMjBpUTZPd2RlK1AxVDNq?=
 =?utf-8?B?NXJlVFhidW5rekdGU1RDREhzQlN3aFArclZjUTlWb25MZFZFR0VUaVdTNTV3?=
 =?utf-8?B?ZnJGS01hRFN2NlVEbnBQaGNTRTJWV2dqbUFIT21kTUZYRzA4WmhlZXh1eVBO?=
 =?utf-8?B?NDY4L0tXa1ZoeXJhVEpRTVBZUkM1cGJFZHpXZzYwcDc3ZnZzK3dsVnNhS1RN?=
 =?utf-8?B?ek0vdjdWK3U2V01nNm9FU2N3c0FjZ2Z0NGV5R244YlJYeCsrd0tpWnJqSURN?=
 =?utf-8?B?MkdOaUVZOHJTbGNNa2xBamFYZG9PWFJWQ2lmWDZtSHRkRnlOTVptTW9VZ3Rh?=
 =?utf-8?B?Ym9NZS9IcG9yT1B6N3U4bWYyMVJTMUtIWng1eGY3bnZ0ZW1hcjhhNjVFeCsy?=
 =?utf-8?B?YU5ZRjJTV2ppTHNPQ3hmNk1aSGNlNWs5Z09JRy9ydUNQOVV3clRqbm1aTW9S?=
 =?utf-8?B?aDJhTlV5dGhOeldPUFRtbnduNXBhazJlVzNHTE8wckFqcFl0bFVwSnRmUFZJ?=
 =?utf-8?Q?tZtkXWPs7lgj/QLjiJorGJsXx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2ed61c-12e0-4a76-4235-08de2c02fcd6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:14:07.9045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NjtWl9E3HTy52JZTiJZqkEsyGM6z4V3Eq8NtksSZ8ayGDPSKp5C9PtQwm23Sk4UnJ2RiJUGkxDI+/fgulSNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8304
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

On 2025/11/6 12:20, Zhenzhong Duan wrote:
> With default config, kernel VFIO IOMMU type1 driver limits dirty bitmap to
> 256MB for unmap_bitmap ioctl so the maximum guest memory region is no more
> than 8TB size for the ioctl to succeed.
> 
> Be conservative here to limit total guest memory to max value supported
> by unmap_bitmap ioctl or else add a migration blocker. IOMMUFD backend
> doesn't have such limit, one can use it if there is a need to migrate such
> large VM.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   hw/vfio/migration.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 4c06e3db93..86e5b7ab55 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -16,6 +16,7 @@
>   #include <sys/ioctl.h>
>   
>   #include "system/runstate.h"
> +#include "hw/boards.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-migration.h"
>   #include "migration/misc.h"
> @@ -1152,6 +1153,32 @@ static bool vfio_viommu_preset(VFIODevice *vbasedev)
>       return vbasedev->bcontainer->space->as != &address_space_memory;
>   }
>   
> +static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
> +{
> +    VFIOContainer *bcontainer = vbasedev->bcontainer;
> +    uint64_t max_size, page_size;
> +
> +    if (!bcontainer->dirty_pages_supported) {
> +        return false;
> +    }
> +
> +    /*
> +     * VFIO IOMMU type1 driver has limitation of bitmap size on unmap_bitmap
> +     * ioctl(), calculate the limit and compare with guest memory size to
> +     * catch dirty tracking failure early.
> +     *
> +     * This limit is 8TB with default kernel and QEMU config, we are a bit
> +     * conservative here as VM memory layout may be nonconsecutive or VM
> +     * can run with vIOMMU enabled so the limitation could be relaxed. One
> +     * can also switch to use IOMMUFD backend if there is a need to migrate
> +     * large VM.
> +     */
> +    page_size = 1 << ctz64(bcontainer->dirty_pgsizes);
> +    max_size = bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE * page_size;
> +
> +    return current_machine->ram_size > max_size;
> +}
> +
>   /*
>    * Return true when either migration initialized or blocker registered.
>    * Currently only return false when adding blocker fails which will
> @@ -1193,6 +1220,13 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>               goto add_blocker;
>           }
>   
> +        if (vfio_dirty_tracking_exceed_limit(vbasedev)) {
> +            error_setg(&err, "%s: Migration is currently not supported with "
> +                       "large memory VM due to dirty tracking limitation in "
> +                       "backend", vbasedev->name);
> +            goto add_blocker;
> +        }
> +
>           warn_report("%s: VFIO device doesn't support device and "
>                       "IOMMU dirty tracking", vbasedev->name);
>       }

