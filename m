Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE02C7115A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 10:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRTv9-0001Tt-3i; Tue, 17 Jun 2025 06:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRTv6-0001TW-Qy
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:52:00 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRTv3-0007WD-8Q
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750157517; x=1781693517;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RuBBZChyvHxK4bznW27KV2t7iIZOenOvK2x0Wl6GeKw=;
 b=CPHUkti1XiOPybeWOUOSOgqeOAf6hYbxPYUU1WdDOziSNhH7Aa7BKYH1
 9jeztCmeRo3Eiq+3l11Wr038qFM7dQG5I+LirMvyDsNE6hHcoMiqY0IRL
 THxGDaHsQpMdeQ7ZIdx+V3e3YF37v7m5swvW81Vf2m6rHzjZ0HQBgKvQr
 D9YiF7z7tBh8I62a3fViF3TG0IajD/5FmnoNH9nzcLPy+P64PxeCk3rIy
 2D057+S7F0Dq26GF4rCK4tPe7fUrEwB6GqEWnJR9CYvNYVshp41MSvtXZ
 IipNv29/TjZIy29Kz4H4YyfoGVrPIDACG9AMMrt0P+Xmy+fe69EuyRPGf A==;
X-CSE-ConnectionGUID: sYTEZjygQ12gk9/9wlNong==
X-CSE-MsgGUID: 8HWievQoS866Rs4sV0T7pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63683617"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="63683617"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 03:51:50 -0700
X-CSE-ConnectionGUID: b9IE90DMQHeqlh1pcjRGOQ==
X-CSE-MsgGUID: 8VmOuJy9TMueGKs0Ekgy3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="148656864"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 03:51:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 03:51:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 03:51:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 03:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMjJkbVbZZ5iOHBPEax/J9ow6RKCghFbtS1TldXMjqJLMP4zRvABgl6Uk6Zc0d2xgWxt/sC+0A894+0M1rQnKEXBmHPWD8rs/hCJcyCjUaqSgQaESS822sFt541fuogo2SJ5wtZcyzelHhL1Oc/7k4wLml+FDbGoJ6m/3tsg2Yt1teyTG80/FIrWW2e/knWjSpqQtcZew77dmK65Bce4kzkEvrAO+e3EnPKo3c8cghmyxjpXleUwbHTdvd1SHP4LL1qvWwDwKGJ5JdkjoQhu7HWaebLC6dVAQl2sGo91e3ZnFoMFWP5lq9q24dg/KxHuK8Zze7QLMhX0+/B90Uer3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR8N/pGSoFE0QREOZcs2NrdKDpno/jOIdmMaz7P4LSw=;
 b=VtryyAr/pxV9ol0/LQxBzejXtlzcPMZzdoE5+ZUosC1WnQX4rXRhQ+ps/A5KbCA55NmAZAftG/J1ddtWXWu8o5tt06K7ResQbsWVtMdhTApr+URPtSnSDF+IsYQDnYwj0Y2DwYdtPUJZU6svI5U2Okzz9GT3mIUW958Lsq7DZ8W8k5XjVmdskfiGo0cvbzXKkgE+IocipSXiFSDFcmyYo3lnBC+hu8JBlNvqphueSh+hQXAEod/EUAiVRM2aZUuQkyi8lIoaSpZt+Yr9um5CsdEs0lWyP8qHI7pFDvVLBE9m4f27vj/4dGtwYJuicrCoEOqWDDCTtopvjDNL02Aqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 10:51:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 10:51:42 +0000
Message-ID: <9add1df3-1a2d-41bb-ba6b-ef625e05d7e9@intel.com>
Date: Tue, 17 Jun 2025 18:57:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
 utilization
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-3-zhenzhong.duan@intel.com>
 <a36077a1-9eee-4c3b-9365-1b7a9dac3b41@intel.com>
 <IA3PR11MB913640374E35567AA052B6DD9275A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB913640374E35567AA052B6DD9275A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c48e58-acf6-422c-5320-08ddad8cf1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFhGMzJIcFBNUzhmVDhEdXRkS2tXZUloUklsdUdNTWd3cmZ1ejQ5YU1tcWU1?=
 =?utf-8?B?eW9xQ25VQm52ZHVINEFCQ2J3cVVWM0phbUMrS0dqd2NlZEJLd0hQa3B5V2pl?=
 =?utf-8?B?OEFvQU1kbG10dzdKVXhDNXc5aFRJWnFJMUxLRUZEbXFlblJSUkZiRFg0OXBU?=
 =?utf-8?B?bVA5OHpuZ1Ywcml6Q2NJQ2NLb0NaQm5OcmdPcnhmcTkySG5vNHUzTXVYMXlT?=
 =?utf-8?B?U1RBMkozSHk1VGd0VjJuR0lMSUhlMUVOWTRBejFwREZ2OEg3WElxT05idFRQ?=
 =?utf-8?B?QmhnYXhldmkybG1nOXFrLzZGVDkyMU9ic2p3UkUvMlAvaVBHdU5HQzhvcGFS?=
 =?utf-8?B?akY0UVBrY1diWG5Mc0pYSFI5ZTlqczcwdnpIVUJDeTRBQno4d25PanBBK1BM?=
 =?utf-8?B?L3puU1NNWmxHR3E4V0twZGdxbWw4eXEwTHFZNktsQUptTGh6SEV6bWVqRzZE?=
 =?utf-8?B?TmdJajliZzZBbSttR1lxRDMrbjVDK24xM0prRWtodjJoWlkxUlBUTEdmRHJs?=
 =?utf-8?B?Q3M0NllFUkdmeWkxdUR4UTgxdXNSRzN2cmd1QlV4b0tRbGlpbmRraEhzdzdH?=
 =?utf-8?B?ZFV4b0NiVFVxbTcyVEFTS0JLNnkwQzN6ektYTVZOUWU2bW9QM05UenpJeWt6?=
 =?utf-8?B?YkJFRk1LdmgzNGMzb1lGN0Eyd0xiSGRHb3NnQ2FRSGpNeW5nUE56ZmVoRkUx?=
 =?utf-8?B?MU9yWFkvMjFZRHYrd3EvdkQwMnNINGJlVEk1RHhENzJQVzE1aUVTZWorUHY3?=
 =?utf-8?B?Ukd2UTVGV3lWWXRlV0lQcXdqR2pxa0dGWHZyMVZYL3gzTitrWVIyY1N4UlV1?=
 =?utf-8?B?VTMwNDMvOG5xd3lhVlB6dktza1gyNEthSjZtY3hGOWF6UGZsVXFxYWN6NCsz?=
 =?utf-8?B?MU9oWnJEbXRRWE81dXg4cmhLbDNUdmdkVXh6dzU2YU5vSi9JVkRjQXJ2YnJN?=
 =?utf-8?B?eW1VVHR6alhKa2lOQ1dXZkF2eVBwU0Z4YXp4eFBaMDdKUmQvVHRRVExOWlpr?=
 =?utf-8?B?bHkvZFdFSnJtM1g2dnhWam1ockgxai9pQjJtdmNWd3p1MG8rUTdwdjZzaTlU?=
 =?utf-8?B?czNndTdPclVhcWxCQTQvT0lENjZSa1RSbTJ1VTBXaFhnNjBETmFhY3pOOEdE?=
 =?utf-8?B?aFV6Q1p2TEFFY0k0Nkh2cklRTzBPVzhsckdBeTZvN3hWVk04ZFZOSDRMWlVi?=
 =?utf-8?B?NThxdmN3N3lBTFFyY25GTTU5enJmUnp1MlVOYzlpWHdHc285WUNjZm5CckhH?=
 =?utf-8?B?NCtrUXNvQ3JFelp1TVkxT0ZaRWdIMDFxb1FyaldMajVFOVI1UUdkWTdBaGxn?=
 =?utf-8?B?SndzRkJPZGZ5K0JpbGlEbVcwbTVlS08wQnJSQ2w2V0wxWURIK0J0WWlPcjc5?=
 =?utf-8?B?WVdDcUxSU3RBNXZGOTk0ZVk0czV2NUp1MjdsSVhNWkwxMEhkblpWZ01hNTZr?=
 =?utf-8?B?S0loUGlCZCthdlNXb0RYdEZmQUpRRk1rWUVEYVVielNjNWI2ZDY4UENkZGVM?=
 =?utf-8?B?M1hMMmtwbWtDajQ0dHpGbE5kZTBSWWRUSFB3UnZSYWJjc0JBYWtOY1NLN3No?=
 =?utf-8?B?ZUZHT2dMVlZhcGsxOU10clJVMlNEN0EwMkplMHpEZlQybTVuQ25RRlU4OVgw?=
 =?utf-8?B?SEVBQkZEbjFBRDJYTEhHZ0JzY0N5ejRTeWtaN255ZE5ZM0hlMFgxaW0yOW9m?=
 =?utf-8?B?NmdPeDFueFBsSlhJRXREQm02Y1ZzYlRLTnliaTRuLzF0NHpxTUZiNFVhZFFo?=
 =?utf-8?B?d0hnUHRERENFN3IzYXVLYnZkVnh6K0FaQ0d2OHYzc2xTeTlDZXdnTVgwRmg2?=
 =?utf-8?B?WENyTUNKdnF3RTRUQ0krQzBPMzBYMFFXcHRRZnN3c0lKcGhwbmtqMU1PK0M4?=
 =?utf-8?B?SmN6K2hNRlVFUU1aRmVHMHBnNUdtWUxIODZJdXM5b3dlbnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxNZTAwYThoTVBCSlR6Mmx6Uk1heUZDMUpTM1c0bEtyakYremRGOFhCUlll?=
 =?utf-8?B?UVQ3anBsT25mWEx3UzdNZ2gydHR0ZUtzdklEcW9wejRJbHRPQ1R1dGpJRGRZ?=
 =?utf-8?B?cnFXdC9FeUxUMUhDY0dReTBocVR0c3dPVEdkTG9IbVNoWjBaNUdmRU1tcm5L?=
 =?utf-8?B?T2FzRWhsbFNaMUJVQllrUWxWNU0xSUIrditmQmZpUngxZENzUmVSZEdSQ1Ra?=
 =?utf-8?B?NWU1Ni9JWER5MGFjNTJDYWdLRlpSN3dwcFFiTnlSK0JYOGRTRVhSMHVhOURQ?=
 =?utf-8?B?ay82dHdwNVFGSXU5U0c0UC9ENzZoWjl3dzZwNEloNzhKaE9xQWdSZkwrdU16?=
 =?utf-8?B?TUQ3V2tGRFltVWgyUkRtUjN0NVphVUordWNHZEhtUXI4cVJMVTN1aGJyR2RK?=
 =?utf-8?B?ZnBZOG5oY0hUV2pLalNNQkpZYVpVcnpaMDJwcEU4M1krelRlSUFuWHR1djZG?=
 =?utf-8?B?bGl1ZENVYS9scGJUdDdjZWlQMUNlZFMzRnNzZG9vUWNBTTcrT0l0RnJLVWJi?=
 =?utf-8?B?OTEwUzNidENtQlVtTTFRQnQ3WXM1QURoMm00UjZRZGxBUGJTYnp4aGZ0NmhE?=
 =?utf-8?B?ckNGZXRUTTRBVFpVc3dvdTRkRURtL1hYQ1lsUWh3M3FqakVFY2txSVNrclli?=
 =?utf-8?B?L21sb045cnl3SzJsUnBOcWRKYnlrVU1zWDJWZGNHSUEwdVZVVytsOWpwVWt1?=
 =?utf-8?B?VGlxN2w0c0l0QlQxdjhpTS83WWxPakx2NTZybCtzZy9EUHhrS2xSMTZHcjMv?=
 =?utf-8?B?U2xBZTFxZ2QxNzZ6ZnJ3NjFFN1RvbVJpSzJBVWxwOGtVWGpHVVB3VkZJM2Nt?=
 =?utf-8?B?c2E0MFE0Ukw2bS9qN3FScVNTUXoxM2prRFZybzZRTTlWdUVQVlVlMVlWNWtL?=
 =?utf-8?B?ejdhQnpVemwvSXU3ek8xNkxDbHIxRTZkRkk1NTBTVzlwRys3RVp1eTZIWnRN?=
 =?utf-8?B?ZG5iemhpYmdVME9oTWlLRW96M2hpRkozVVcweWZWRit4RDdxT2haOUh6UEQy?=
 =?utf-8?B?UUduNXhXNzkvWE5jOVNjbzQ2R05TZHRJeXMyTmdId01BNGlLUDV0SGd0cFVi?=
 =?utf-8?B?VDlNNUtsTVcyTVl1cHJyZDArMGNWWlN1L21VaC9OVVExdEE4UW5jR2h3NjhC?=
 =?utf-8?B?T3dYRi8yckI2QnQ0U1BHT2F4eUZDUmZVdXJQZW1JTGh1Vi9SMnFvSXhWQkpK?=
 =?utf-8?B?aTVLaGZKV3cvNEVpUzR0S0VSVXIrT2RHQUh6N0ZidjN0RC9vWWZ0eXpBMDEr?=
 =?utf-8?B?VHFZeXB1elRtRW0rc3ZlQStIUTdSYjNVTHBtMWQvNFNWSUYzVGEwWGFma28z?=
 =?utf-8?B?ZjJJUG1BUmF2OERNNWpGVjZzTWQwOExuMHdzNEcxZkNBMzRUOVlTdjJZN1A4?=
 =?utf-8?B?K0k5MFlNM2cxaXlKTE5nY0VTTXdIQlo2ZFBhQ1NxYTNlU3ExRHM4ZEFmUDdn?=
 =?utf-8?B?VjNFSzV3VEE0azdrVmN0WkR6SS8rREYzMVVkZVNVRDhtTUxEVmhFU0d5UXZo?=
 =?utf-8?B?STZGcThjSGFqOWZYWHdsOG9WeGdGb0ZOOS9ZV0hGL3Q5bmVkQWZBbHJ0UUxZ?=
 =?utf-8?B?aGZxVDdjdGlGdnlWNWZkMHZ5a3N3YnY5S2I3Nm5vbGFuTlNzY0xBRDM5d1Zn?=
 =?utf-8?B?S254WnNPZDFJT0Z6Uno0WUJvZE9FTW5wcXBsL0FkYU40YXZqQmY2UTJ3U3Qv?=
 =?utf-8?B?MHE2L2JOS2d0ZU5UQ3NpclI4U1c2MllzdHRLUHZod0tGVVBVQkJIVlNkSWdR?=
 =?utf-8?B?SFdkNERZNHBiN1AyTWY2WG1xaWxOREgycWdjeGRzOVlmSWJ4WUtVMGVGNG96?=
 =?utf-8?B?RUNyaFlIY1pQWGlib2VyWnoxbFM0Y2hkeG84K0VPaDdJc01LZ3RXYVJZcjdv?=
 =?utf-8?B?NEkvUzU2UXBQVHhZMWUxZklmYkV4UXdOSHZHWU9JVTAzTk5INUxWYjFTNVlh?=
 =?utf-8?B?Y1l3WmpnOUhNcjE4dnFGcVdLRDJYZkNPZ0Q3UnUxM3hoS1YzN2lic1BvMGxw?=
 =?utf-8?B?eU51RkRUR3hqekc4eldzY0VSYmhla0NIb0pyek9LdEtkWm5DY0NKcUFIME96?=
 =?utf-8?B?NkJDaWZoWndCUi9WbkI3ckZoZmVjUUdmK0M3UmpjR2NrbUJvZU03MlFqMWxv?=
 =?utf-8?Q?Mq3xlF96z4eR5ciDIez0FUzXr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c48e58-acf6-422c-5320-08ddad8cf1d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 10:51:42.3534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uryrv7VcGi2hXBRsxUtwu1Xgw/AhHwUyzO99CbR4iVEVKxvJSlUeHfxRSS2am4IGnMGWcWApBZ3GoK3UYlRlXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

On 2025/6/11 18:06, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
>> utilization
>>
>> On 2025/6/6 18:04, Zhenzhong Duan wrote:
>>> There are many call sites referencing context entry by calling
>>> vtd_dev_to_context_entry() which will traverse the DMAR table.
>>>
>>> In most cases we can use cached context entry in vtd_as->context_cache_entry
>>> except when its entry is stale. Currently only global and domain context
>>> invalidation stale it.
>>>
>>> So introduce a helper function vtd_as_to_context_entry() to fetch from cache
>>> before trying with vtd_dev_to_context_entry().
>>
>> The cached context entry is now protected by vtd_iommu_lock(). While not
>> all caller of vtd_dev_to_context_entry() are under this lock.
>>
>> Also, the cached context entry is created in the translate path. IMHO,
>> this path is not supposed to be triggered for passthrough devices.
>> While this may need double check and may change in the future. But let's
>> see if any locking issue with the current code.
> 
> Good finding, yes.
> Previously I thought translation path updates cc_entry->context_entry after cc_entry->context_cache_gen.
> In vtd_as_to_context_entry() cc_entry->context_cache_gen is checked first, so there was no real race.
> But I still missed a memory barrier like below:

yeah, testing context_cache_gen is necessary. But without lock, this
cannot guarantee the cc_entry is valid after the test.

> @@ -2277,6 +2286,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>                                     cc_entry->context_cache_gen,
>                                     s->context_cache_gen);
>           cc_entry->context_entry = ce;
> +        smp_wmb();
>           cc_entry->context_cache_gen = s->context_cache_gen;
>       }
>   
> Another option I can think of is adding lock to cache reading like below:

this is in-enough as well since the cc_entry->context_entry can be modified
after lock is released.

> @@ -1659,11 +1659,15 @@ static int vtd_as_to_context_entry(VTDAddressSpace *vtd_as, VTDContextEntry *ce)
>       uint8_t devfn = vtd_as->devfn;
>       VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
> 
> +    vtd_iommu_lock(s);
> +
>       /* Try to fetch context-entry from cache first */
>       if (cc_entry->context_cache_gen == s->context_cache_gen) {
>           *ce = cc_entry->context_entry;
> +        vtd_iommu_unlock(s);
>           return 0;
>       } else {
> +        vtd_iommu_unlock(s);
>           return vtd_dev_to_context_entry(s, bus_num, devfn, ce);
>       }
>   }
> 
> Which one do you prefer?

If it's just optimization, perhaps just drop it. :)

-- 
Regards,
Yi Liu

