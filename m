Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAB7CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 05:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9dP7-0006Px-6u; Fri, 17 Oct 2025 01:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9dP5-0006Pn-0H
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:53:27 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9dOz-00053n-Ka
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760680402; x=1792216402;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ERqQHR5uiH9gk8Zz1nFWGLoGamjEYZDfiX+EoZAXOLo=;
 b=c8kdh4oe7KUlG6qEairHqZPRnnymTcRhGFixoThBew9c7CLEUzW4te1x
 h6i4CQYpngAt6h042tNuJxgBs7hIQDTOLiqS0hsB7k1oH18FsYeUJwjSf
 7Bk+gkLX4pgIjZUocgQthzFYNJEMo2qT/wrzIMugBEHBKVIE8ErmksuP+
 0BIKBdeSlC9r5VS2PTZtF0Y1g7tdrU1+kRwfV0pVODh8sjCy0kkwuc5aQ
 os2Pd+wgIh+doBF9nSj3+D+1qw5L3lWrOLolytrxwe0mrWgdl8pbkeXW0
 XvqD2UK2LjYX4jPj+y5Yio0w0DqH30GUqAzXZNB468pPnjCm39A4UmkLQ w==;
X-CSE-ConnectionGUID: VT5u8ue7QOyJASa283lP/w==
X-CSE-MsgGUID: RuIX2/oERR2jOIpnGwwJsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62923187"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="62923187"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 22:53:18 -0700
X-CSE-ConnectionGUID: ylAAoTDBT+21jY+WcypGIA==
X-CSE-MsgGUID: 9XkdsrcDQE2HIgfJRmylpQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 22:53:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 22:53:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 22:53:17 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 22:53:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEkJPod416g/jZtkeSqij+v2wNXn7CsQWM1uDaW/Z5nTR8VxilZAeyj6pyZSf//ByZce84Rm8KhKnB0Ku6IDbBZGFbfLoLtoVMvPJs9u0PMtGRpE3rUcoiAqdYKEyOV5vBcdeRTpnFI9WBPUudd0B9/++DdEXYpj4HVQlL6usij75xgz0cnzFkQuJCg5/CU6d7AFkQ6swodbguY2ba71VYgl6CrGbaSI6SYwjoEqB1JcOzjHwpam7xvkQ/tgYuMZt5ydo1uKTk9jJmqcRfFZsbKtfpWKDzHBXgGCt6PefWPNfMffPsnx5Qud6q15xg3ueJhDnUveh9/5fSbI4XiH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERqQHR5uiH9gk8Zz1nFWGLoGamjEYZDfiX+EoZAXOLo=;
 b=KFHXzUT1pxjUt6pVyoamSd+iT9xiNf1OuSLAUgkLC4lD9BxUtVr8/vf77FGITtNmkxO/zcf01Qax61WbJBJBOe9AR4SxdGkx+/4Vp1FHQA+y1rsKJjJJHAgYOnWV0Yc7FWIjAmTuqPXHJYIeOEWk/qy5XP12oHFhmCfq7xuhwQE3cJfdfy9TIUIF9h3o0XxMeqCaLz1mgozxZlFsU8sgh+ed9Gq1ei14hmW4kFEk7WbYwxUaTIDYaFu53z2pcbKIr0sxJ8VV+Uz4VR5NxhffKtMuqR0eN+ryVlXGSTGsI9O4Fbhz6kZnyGE3bqF7JOwmjaRTmgOCPgbNpbuAoqRjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 05:52:59 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 05:52:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>
Subject: RE: [PATCH v2 3/3] intel_iommu: Fix DMA failure when guest switches
 IOMMU domain
Thread-Topic: [PATCH v2 3/3] intel_iommu: Fix DMA failure when guest switches
 IOMMU domain
Thread-Index: AQHcPnDy/62FJfwnkUG+T8YoeyWaWLTEsQWAgAEk87A=
Date: Fri, 17 Oct 2025 05:52:58 +0000
Message-ID: <IA3PR11MB91364A9E75A9016B50D521D292F6A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251016074544.377637-1-zhenzhong.duan@intel.com>
 <20251016074544.377637-4-zhenzhong.duan@intel.com>
 <72a149b8-079a-4487-ac3b-850daa40f2dc@intel.com>
In-Reply-To: <72a149b8-079a-4487-ac3b-850daa40f2dc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB5070:EE_
x-ms-office365-filtering-correlation-id: 6abd41b6-3a5c-4c60-f1d5-08de0d416d2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dzhXS3BZWm9OVXJTbTVCVUpQTk11b2JGTGhDZTZZVmU2UXRMOXlpTHFYdDdJ?=
 =?utf-8?B?VjVrYTVPU0lzaXI3TVkxbkpEWTF2dVo3cHYrb2pBdG4vSWVNUzE2c0pzSWpp?=
 =?utf-8?B?anY3UzZZL0JwY3V5UkQ0ejlJUkFzV0dmR1F3RXFtWEp2b3FJbHllL3djd25R?=
 =?utf-8?B?cUQ4Yit4S2FmeFE1czVseWRFdjcyaUdCb3FYMXNkd2xuSzQ5WmYzYVFLdEMv?=
 =?utf-8?B?VCs4SnI2MGlkc2QyRFU1UmtuL1RuM0s4a29sWm1ZZkViTzhRaklGZ1BpYlB1?=
 =?utf-8?B?Q2xvUTNpQjR5KzFCM0hWSXQrYU1nQWVXQVV4QmxjQ0JrbTZYR2hXK1FLbGFT?=
 =?utf-8?B?NDBCcmpPeXpLTXV5bzA4bm9ac0doZFBuQWdFNlRscVdMdndCTkF6TmZsTjZo?=
 =?utf-8?B?RjFsdkw1TUtBaEJKUGxZcGg1U0RIZm9jZ0ozaG9mazNiQUtuaVhNaDVEaEV4?=
 =?utf-8?B?Z3BBWmJRUjBsMUo5blp5ZE9SbmxGZTRldmJUckZQY05LYVNjRmRxVXNRcm9i?=
 =?utf-8?B?SWZld2pRZmRyQ1FMY0Q2Um1YbEM1NnhZdTFvNlJFdVNNWWthY2cydmtzN1BW?=
 =?utf-8?B?YWZKNTBqUWN0UjBwRUFJZmxEZXRycTRpYnQzVzBMZERtcDNTeGkvTFlaNTVC?=
 =?utf-8?B?R1pYY1gzRlRRZGxCUGhUMW1XaFB3KzA5TXR3bEp1Z2d0aXR0OThLbUxnYUJp?=
 =?utf-8?B?aTI4eW5Qd2lHL1I3QVpEREdDdFd1Vi9oZUF1RjhqQy9EcVd1YXlCODd2eDAv?=
 =?utf-8?B?bVZyYU5RNEZIYmZkMFhyUGdQbVZpKzFMbW1pczBKSEtyQjMrSXJ2QlZnalpm?=
 =?utf-8?B?NlpRLzJjTS9MUjg5UGFjc21keVpJa0JTbHdjQi96cHhpYllpTy9yTHFiakJI?=
 =?utf-8?B?aE5YcG9ra0RmTDhwYWlUaGhBd0txdDFnb2FtRzVKODdScE5LaGc2NzR1ak5x?=
 =?utf-8?B?QTV3SjJ4eEVpNmpCT3lNN2FPQzZzWEJJWE9kS0JvUk5UeFB2SUw4bk1ldVR3?=
 =?utf-8?B?TmQ1cjhJWXNGbDY3SUg4NjJJOHRjT3hQU0gxQWhyNWNId2JLTjhNRUcwSS92?=
 =?utf-8?B?bG1mK3o5UGZuZncvNVV6Qk9HNkQvR0RKNy8xVlN0Q1RoenRCTWlWTkdvbjRU?=
 =?utf-8?B?WkdtbXlNaWRtVkEyU1ozUllvYWFFZ0dhekJHbnBNTGw3Qlh3Rm92aTBSaE9B?=
 =?utf-8?B?a2lXLzRvOGUvNkU3REVxSmFqakxCaDBaMXBhbXRrRWhwbUlHRnE0bENZdTN2?=
 =?utf-8?B?b0laOUZlNWJabENVeUVJV0FwTUlVRVNBZCszQy9tUGhhNWpmWm9vcEtzL2tQ?=
 =?utf-8?B?K05HZ252VFlNQXpaSzR0d2pFMGZqTllQd010a0tzNW1zeXc5R1BiTlh0eHNq?=
 =?utf-8?B?T2htWkRQUmtGWFcza2FGcE4yN3piRnBqWFh2ditCVGlCWXhCVEsrZFRNUHd6?=
 =?utf-8?B?TTJlR0ZUajdNNmh5UEYrQUxkZGpiN1Y1ZzNnSmZhL3E2Sndxejl1SzlFdHJF?=
 =?utf-8?B?dGwwakdPUGoxNG1kaTNwckpOMnpYK2g5cXQ4Y0R0d0NyWmdCR1BTdm1KdElL?=
 =?utf-8?B?WjJ5SHMxWWtoTGlkVGNzbUZXa3hLVzJZYTkwWlZOUFVaVFVVL2NTY0JtR3Br?=
 =?utf-8?B?V3VscU82QmVKVFlUV0w2VDRFV2VBM0J4a1lmQjlkRUV2VEVXUzhWUkQ2SXcx?=
 =?utf-8?B?ZmNGR2ZjTXpiZkQyRGk0cWN1LzVXQWswYlYzYjQ1WU1GSGtRUEw1RG41Snds?=
 =?utf-8?B?b2lCZFozczVaeFcrTTRMaWN3OU5WRXVpeGlrWUlGa0laMHovVUFJVmc3QUJ3?=
 =?utf-8?B?cjdraGVGZklEMm1oYlNTY1Z3Y3hoaXlnK0tQTjYzcjJSTGJydlJSdmVXSEV6?=
 =?utf-8?B?VW9PM0MxaERuVWpWMUtrUmNOWVJqeVNzZk9Ka0ZaN3lIaVIrOHI3Q21mYjNt?=
 =?utf-8?B?UEQ0ZGJJYTdyN3ZRUmtsaDZaWE02QVh1U0M3VWRpWE1HR1J6MzJEdjY1T0x5?=
 =?utf-8?B?NDJINStqZDdmcVdnR1AydVlxTVlKODBYQWVDQUlPaTJOTzkrUWhlNHFJeHFF?=
 =?utf-8?Q?XmHGHk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzBsNG9lY05HYXpKOWJjaEtUS0dXWm5HdmJ3RnczQVl2bmM4NFV4TnhibVVF?=
 =?utf-8?B?TjFyVDRhTU9ySFdaNm53Q1N5Sy94Vnl5bU5xSFZycU9pUDVVNmpndTRkbmsy?=
 =?utf-8?B?ejVxS0hnRlVWalNycjhMaWFzNmtFSndPaGIrT0V0SG1LQm1GZlg0RElOSTRX?=
 =?utf-8?B?OG51RHpLbnIvNndobm9EcWFGaGpDbXhYQStqT3Q3SkU1S0JlWlpLcFJmcjds?=
 =?utf-8?B?VGtZbGtHdW95VnBXUHY3VjhjSHl4d3o5ZmxNeDdFa2ora0xqeFlWMUhSQnB3?=
 =?utf-8?B?QVNLdzhDRmJLNUNYQUNaT1h2SWplSzVtUklicnEySzZoQ1ExWkVwNU54aXh1?=
 =?utf-8?B?Tmd5QVJWejEwYlVQQ290SzdOdFUrdkF0NU0xbkxUTUZURVViWjEzeTJNYTk0?=
 =?utf-8?B?ZW0yaWR3VU5PL1E1MTJSNkpiQ3ZaU0tpUVBDSEtuNEZ1Q3k4eC9XSFR3Njlk?=
 =?utf-8?B?dHlCTTU5N2M1dDdONEVyZUxiUTFPTmJDUkJ4Vk5wMmtWWTZBMElrVDdoZ29k?=
 =?utf-8?B?aFJEbWxiM3JnWFRTZkhxa1l3S2lYdTdBTUUrZjRNMVd2cFNGODlHT2N6SWx1?=
 =?utf-8?B?c1RCdGhHYmhvR1ZiajRmMmh2WFB4Q3ZLNGdsT3dKcm5pL201OVZ0VXpxa3RC?=
 =?utf-8?B?cjJYRGhjdkNhdlZtSm5IYkFMb0RlZFZURTQ4d01ya01zZFE5MmFreFlSN3M0?=
 =?utf-8?B?YjU0ejAvbkhHUjFzNVRJRkNzZEUrQWNGa2lTbXE0WjdZRS9WVGdtZnd0RGV0?=
 =?utf-8?B?MHp5UnUyeTY3THV5SnJ0ZXJ5WGRQSFNJczJ1KyszN1BJbUt2c2xDNUNQOEZo?=
 =?utf-8?B?MjZZdHNlR09obHlIY1RraVdYclZzOWNVRTZ1TitmUTY2ZFNkT3hFK0szL21L?=
 =?utf-8?B?c05tKzB1TWlsTThHejhOaVVGek9mQ0FPUjFPT2FPbHB3Ukp5YTBUR0JJNmJw?=
 =?utf-8?B?QkJ2ajZ4cVR3NnNNaTdUT3R2VFBpQ0U1R0tmMXNORWNoTmIwdFNWMzkzaWQ1?=
 =?utf-8?B?VGZvSllUMDVNQ2FZYW5hN0JDNjB0SUlXTlJDalhLL1FGNW9sQTJLWStmQU92?=
 =?utf-8?B?TXllS0ppWEJDL09Ob0xGNDBwdXEwb2RBYU5ZWTcxVEU5bmwrSU83a0laVXhh?=
 =?utf-8?B?cHBBUE81R0dEUlFJU3AzN0R4alZaenNsdzEvWUpIOExZTlBCZ3VMOXorTGQ0?=
 =?utf-8?B?SElqZGt3Vi81cUU1OVplNVNWKzNtL3FVYmFrVFpUcGUrM1hBaW9EQitZTkVx?=
 =?utf-8?B?Q05xTnJEY05JeFk1Yi93UWVHY3VnanpPTnhCUG40Q1lVM3pmUXBIVVJBamN4?=
 =?utf-8?B?WVFOZE4zUHE2RzFLL0lIOU5ONGlyL2hFU2UzYlkxdDE5ayszVmNzRWRQS1hE?=
 =?utf-8?B?TU9wVUhaMTlvRTg3RFhBbW9FWlJBWmtObEN2K3NGVDRneDF5TXlVY3E1a2Z1?=
 =?utf-8?B?LzkvTis4UkR1TXVmekpFR3l0eEQzVWlWQUFSZXFHN1JOM2hRb2ZXZlNlZS9w?=
 =?utf-8?B?TjdLZ1RTaFJLdW5pcGpydGFlc0FWamtyeThnbDBuUCtUdXhtcjVFYjMwUGMr?=
 =?utf-8?B?L0Nrd2NPM29LRDZoellCTlZWMTQ4dmh6M05kQmhETlRGTjZMeWFhSnZrcy8z?=
 =?utf-8?B?aEZmekZqNWd4bEVWUlgzeldpUE9lZHZRYjV5eU9TWElTRHI5ZVZodUJUZlBL?=
 =?utf-8?B?NkdtSXZWajBvbTY1dlo5dlVhY1RpRllveGFqbXlKRnNBZnlsSGJoUXZUc3FD?=
 =?utf-8?B?VzF2UXBobHFSMVJtMFlnRGpkQU9LRkd4NzBJQkltaW9oUm9vQXNwYWZnYWpO?=
 =?utf-8?B?WWgvemVyTzljcmNPMlVrWWxMdzU1UlV5TlJ0eld1OHdBOXVYL2NtYkVCRVgz?=
 =?utf-8?B?V0htQVJGU29GVGpoakh3S2REcTBJeWx6a1VQT2ExL0FuQzB1MDZvYll0WUxa?=
 =?utf-8?B?TUZjSDljSnYxclZHT3B0eEU4bDFPYWZpZEtlSjJ0Tk04d3UvRWVYVXNVbDFD?=
 =?utf-8?B?VWtBdDd6WFVaZnR4ODU1c0Z4SVl1NlhiZitLNmZyT20xQ0hPajB5WjRVUFQ3?=
 =?utf-8?B?WDFHNExTTXd5UjhWaWdIaWNQaCtrVy9TOFZ0M3BYODFoZnlCTE5uY0ZEUk5S?=
 =?utf-8?Q?ugoqIgLEoUkZWTnl5rkEjeWzR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abd41b6-3a5c-4c60-f1d5-08de0d416d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 05:52:58.8328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RJ7jfP+0fUitvCYFH6ape/WiNpsMDDaDyEHXy69Vq/V2Rgks9wlQRzs6Ijy589q3PIu+OuvFrM2aSJG5T4yoAiAj5EDrSLQTzWy3FegrHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy8zXSBpbnRlbF9pb21tdTog
Rml4IERNQSBmYWlsdXJlIHdoZW4gZ3Vlc3QNCj5zd2l0Y2hlcyBJT01NVSBkb21haW4NCj4NCj5P
biAyMDI1LzEwLzE2IDE1OjQ1LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEtlcm5lbCBhbGxv
d3MgdXNlciB0byBzd2l0Y2ggSU9NTVUgZG9tYWluLCBlLmcuLCBzd2l0Y2ggYmV0d2VlbiBETUEN
Cj4+IGFuZCBpZGVudGl0eSBkb21haW4uIFdoZW4gdGhpcyBoYXBwZW4gaW4gSU9NTVUgc2NhbGFi
bGUgbW9kZSwgYSBwYXNpZA0KPj4gY2FjaGUgaW52YWxpZGF0aW9uIHJlcXVlc3QgaXMgc2VudCwg
dGhpcyByZXF1ZXN0IGlzIGlnbm9yZWQgYnkgdklPTU1VDQo+PiB3aGljaCBsZWFkcyB0byBkZXZp
Y2UgYmluZGluZyB0byB3cm9uZyBhZGRyZXNzIHNwYWNlLCB0aGVuIERNQSBmYWlscy4NCj4+DQo+
PiBUaGlzIGlzc3VlIGV4aXN0cyBpbiBzY2FsYWJsZSBtb2RlIHdpdGggYm90aCBmaXJzdCBzdGFn
ZSBhbmQgc2Vjb25kDQo+PiBzdGFnZSB0cmFuc2xhdGlvbnMsIGJvdGggZW11bGF0ZWQgYW5kIHBh
c3N0aHJvdWdoIGRldmljZXMuDQo+Pg0KPj4gVGFrZSBuZXR3b3JrIGRldmljZSBmb3IgZXhhbXBs
ZSwgYmVsb3cgc2VxdWVuY2UgdHJpZ2dlciBpc3N1ZToNCj4+DQo+PiAxLiBzdGFydCBhIGd1ZXN0
IHdpdGggaW9tbXU9cHQNCj4+IDIuIGVjaG8gMDAwMDowMTowMC4wID4gL3N5cy9idXMvcGNpL2Ry
aXZlcnMvdmlydGlvLXBjaS91bmJpbmQNCj4+IDMuIGVjaG8gRE1BID4gL3N5cy9rZXJuZWwvaW9t
bXVfZ3JvdXBzLzYvdHlwZQ0KPj4gNC4gZWNobyAwMDAwOjAxOjAwLjAgPiAvc3lzL2J1cy9wY2kv
ZHJpdmVycy92aXJ0aW8tcGNpL2JpbmQNCj4+IDUuIFBpbmcgdGVzdA0KPj4NCj4+IEZpeCBpdCBi
eSBzd2l0Y2hpbmcgYWRkcmVzcyBzcGFjZSBpbiBpbnZhbGlkYXRpb24gaGFuZGxlci4NCj4+DQo+
PiBGaXhlczogNGE0ZjIxOWU4YTEwICgiaW50ZWxfaW9tbXU6IGFkZCBzY2FsYWJsZS1tb2RlIG9w
dGlvbiB0byBtYWtlDQo+c2NhbGFibGUgbW9kZSB3b3JrIikNCj4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcv
aTM4Ni9pbnRlbF9pb21tdS5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVs
X2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDA3YmMwYTc0OWMuLmFj
YTUxY2JkOGUgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTMwOTUsMTUgKzMwOTUsMjggQEAgc3RhdGlj
IHZvaWQNCj52dGRfcGFzaWRfY2FjaGVfc3luY19sb2NrZWQoZ3BvaW50ZXIga2V5LCBncG9pbnRl
ciB2YWx1ZSwNCj4+ICAgICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzID0gdmFsdWU7DQo+PiAg
ICAgICBWVERQQVNJRENhY2hlRW50cnkgKnBjX2VudHJ5ID0gJnZ0ZF9hcy0+cGFzaWRfY2FjaGVf
ZW50cnk7DQo+PiAgICAgICBWVERQQVNJREVudHJ5IHBlOw0KPj4gKyAgICBJT01NVU5vdGlmaWVy
ICpuOw0KPj4gICAgICAgdWludDE2X3QgZGlkOw0KPj4NCj4+ICAgICAgIGlmICh2dGRfZGV2X2dl
dF9wZV9mcm9tX3Bhc2lkKHZ0ZF9hcywgJnBlKSkgew0KPj4gKyAgICAgICAgaWYgKCFwY19lbnRy
eS0+dmFsaWQpIHsNCj4+ICsgICAgICAgICAgICByZXR1cm47DQo+PiArICAgICAgICB9DQo+PiAg
ICAgICAgICAgLyoNCj4+ICAgICAgICAgICAgKiBObyB2YWxpZCBwYXNpZCBlbnRyeSBpbiBndWVz
dCBtZW1vcnkuIGUuZy4gcGFzaWQgZW50cnkgd2FzDQo+bW9kaWZpZWQNCj4+ICAgICAgICAgICAg
KiB0byBiZSBlaXRoZXIgYWxsLXplcm8gb3Igbm9uLXByZXNlbnQuIEVpdGhlciBjYXNlIG1lYW5z
DQo+ZXhpc3RpbmcNCj4+ICAgICAgICAgICAgKiBwYXNpZCBjYWNoZSBzaG91bGQgYmUgaW52YWxp
ZGF0ZWQuDQo+PiAgICAgICAgICAgICovDQo+PiAgICAgICAgICAgcGNfZW50cnktPnZhbGlkID0g
ZmFsc2U7DQo+PiArDQo+PiArICAgICAgICAvKg0KPj4gKyAgICAgICAgICogV2hlbiBhIHBhc2lk
IGVudHJ5IGlzbid0IHZhbGlkIGFueSBtb3JlLCB3ZSBzaG91bGQgdW5tYXAgYWxsDQo+PiArICAg
ICAgICAgKiBtYXBwaW5ncyBpbiBzaGFkb3cgcGFnZXMgaW5zdGFudGx5IHRvIGVuc3VyZSBETUEg
c2VjdXJpdHkuDQo+PiArICAgICAgICAgKi8NCj4+ICsgICAgICAgIElPTU1VX05PVElGSUVSX0ZP
UkVBQ0gobiwgJnZ0ZF9hcy0+aW9tbXUpIHsNCj4+ICsgICAgICAgICAgICB2dGRfYWRkcmVzc19z
cGFjZV91bm1hcCh2dGRfYXMsIG4pOw0KPj4gKyAgICAgICAgfQ0KPg0KPndpbGwgdGhlIGJlbG93
IHN3aXRjaCBhcyBhbHNvIHVubWFwIERNQXM/IFNheSBndWVzdCBzd2l0Y2hlcyB2ZmlvIGRldmlj
ZQ0KPmZyb20gaWRlbnRpdHkgZG9tYWluIHRvIGJsb2NraW5nIGRvbWFpbi4gR3Vlc3Qgd2lsbCB0
ZWFyIGRvd24gcGFzaWQNCj5lbnRyeSBhbmQgZmx1c2ggcGFzaWQgY2FjaGUuIFRoZSBiZWxvdyBz
d2l0Y2ggd2lsbCBjb252ZXJ0IGFzIE1SIGZyb20NCj5ub2RtYXIgTVIgdG8gaW9tbXUgTVIuIEl0
IHNob3VsZCB0cmlnZ2VyIHRoZSB2ZmlvX2xpc3RlbmVyIHRvIHVubWFwIERNQQ0KPmFzIHdlbGwu
IGNvdWxkIHlvdSBjb25maXJtIGl0PyA6KQ0KDQpZZXMsIHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFw
KCkgaXMgbm9uZSBvcCBpbiB0aGlzIGNhc2UuIEJ1dCB3ZSBuZWVkIGl0IGZvciBvdGhlciBzY2Vu
YXJpb3MsDQplLmcuLCBzd2l0Y2ggZnJvbSBETUEgZG9tYWluLT5ibG9jayBkb21haW4uDQoNCj4N
Cj4+ICsgICAgICAgIHZ0ZF9zd2l0Y2hfYWRkcmVzc19zcGFjZSh2dGRfYXMpOw0KPj4gICAgICAg
ICAgIHJldHVybjsNCj4+ICAgICAgIH0NCj4+DQo+PiBAQCAtMzEzMSw2ICszMTQ0LDkgQEAgc3Rh
dGljIHZvaWQNCj52dGRfcGFzaWRfY2FjaGVfc3luY19sb2NrZWQoZ3BvaW50ZXIga2V5LCBncG9p
bnRlciB2YWx1ZSwNCj4+DQo+PiAgICAgICBwY19lbnRyeS0+cGFzaWRfZW50cnkgPSBwZTsNCj4+
ICAgICAgIHBjX2VudHJ5LT52YWxpZCA9IHRydWU7DQo+PiArDQo+PiArICAgIHZ0ZF9zd2l0Y2hf
YWRkcmVzc19zcGFjZSh2dGRfYXMpOw0KPj4gKyAgICB2dGRfYWRkcmVzc19zcGFjZV9zeW5jKHZ0
ZF9hcyk7DQo+DQo+SW4gdGhlIGNhc2Ugb2YgZ3Vlc3QgbW9kaWZpZXMgZmllbGRzIG90aGVyIHRo
YW4gUEdUVC9GUy9TUyBwYWdlIHRhYmxlDQo+cG9pbnRlciBvZiB0aGUgcGFzaWQgZW50cnksIHdl
IHNoYWxsIG5vdCBzeW5jIGFzIGZvciB2ZmlvIGRldmljZS4gWW91DQo+bWF5IGNvbXBhcmUgdGhl
IGNhY2hlZCBwYXNpZCBlbnRyeSB3aXRoIHRoZSBvbmUgaW4gZ3Vlc3QgbWVtb3J5IHRvDQo+ZGV0
ZWN0IGl0Lg0KDQpPSywgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

