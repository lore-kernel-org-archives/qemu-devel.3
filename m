Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A05C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQrQP-000587-HV; Mon, 08 Jul 2024 12:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sQrQN-00055k-76
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:41:11 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sQrQH-0006ps-IZ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720456865; x=1751992865;
 h=message-id:date:from:subject:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7R36zDOlxQxhwEdCJQ7WZJQZv0okjke2f9f2E+Pm9kE=;
 b=DyLN3QA3d3ebBRLC2lGBjR1sGLQI7FDqPdoFfy4t/JN5buGCYG1ccBu9
 TaOqbY3/NLlUyP0OkPGng+dsrZOtLla1PObyYLSLr0S8udmgRjcUGPjt/
 tOrvd5zlEbIiBoq1C46U3/ovjR9+oIrtYZlWFcrU7TJObroWDheg8XsXC
 j6W79d+IEtdWVxpQJ8/PI9I46MvWvTNgFjx+c8XSYm7j2Pzi/AlEu0GST
 grXADbFUZm/mXcNbh2FGfC2xofc16MqK6XLBo+ualyPpymhYRiyJAAhRO
 lErMg5cf6XpWgq+rsaIwewtL5PJimeBvAvr+2wr2d9O6e0WIWB8pA0zZ/ Q==;
X-CSE-ConnectionGUID: desBQfO4T6SjRmiz62XO4g==
X-CSE-MsgGUID: ppA9pUCjS6qBxa1GD1RXkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28276637"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; d="scan'208";a="28276637"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 09:41:01 -0700
X-CSE-ConnectionGUID: XLAMz4uGRf6eFAa0/SFX4g==
X-CSE-MsgGUID: Gsi+FuWiQTuwk/6TeGb0ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; d="scan'208";a="47481503"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jul 2024 09:41:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 09:41:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 09:41:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 09:41:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXvMsJ6dV644Czod+e1S/4Ucn5rXv5Y76qrgML/EKxCY9lt//eTzCxaedg52DIbq9nVuJSTfnucJx9xxt4PqNCrzMKvEzgstrKL6WzQT2QQEZdjLmimDPjIzMuJYhICOfCiwd1fD6HJOJxb/xGslcRfpsW3WBmN33TZT+WqrmdqGYjxippKl3vDr8ck6u/Rf6ci4VTEt3fEoS1byhhKF6hpA2Blx9HmZQEIvv7dYFDWISFo23ShD4+/+uRxKn169Q0Tbnv6L/9jPfIL49Br7I3fmCyOmB62jaPq+mZvjEUWj7qQehSM/UxZAngclz/fOfV4i4iwDLt/tXbsio2lDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAxjBzfnRJU0DE1JzXb2ZwmcLBcHSo7KWoJt670GRjA=;
 b=NxSJpL9sZafMGm1ff80Bl9F1Yv55fj2JklYFxIyhlnU6RLy/ESNE9uT9mN4IuhXMn5PP0WJ4Dy7XCrstElaV7RLuIlwd2Y8xMhNEP8Bap5sk5lRcFBRW/2TAxWEjx92Altzo1thGJd+QKY4zzeg4coyx5NY/8yHuchZc5aCYGB2g7biKyEiZ/GuVc1DXc4NuJ/lBLl9bfbjxj/89UkKrDj7lfIl60j3E/oOdYSrK5l29wipEIeadG6ZJaCChSxAEm17xmqEcNk9ulGmxi+IDJsTqTXeVd26/e7aHHKVvvP1j5IHq8abDrDMI2A7jVBstBwcq6iO/fC6mtsXVA/V3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:40:59 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:40:58 +0000
Message-ID: <14809811-81ec-4504-a5fc-662d8116232b@intel.com>
Date: Mon, 8 Jul 2024 09:40:58 -0700
User-Agent: Mozilla Thunderbird
From: "Kim, Dongwon" <dongwon.kim@intel.com>
Subject: Re: [RFC PATCH 0/4] hw/display/virtio-gpu: Introducing asynchronous
 guest display render
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, <qemu-devel@nongnu.org>
References: <20240620231727.235841-1-dongwon.kim@intel.com>
 <CAJ+F1CKRau8FGHMv0aBb_ocitavCzivrzpB2YtfNa22N7uVsWw@mail.gmail.com>
 <71ea0f44-fea9-45ca-8ce0-064e8581c7cf@intel.com>
 <CAJ+F1C+QPJAf1KbZSySmQYd7CF07Gk2qU89nxajdy90QRs4v3A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJ+F1C+QPJAf1KbZSySmQYd7CF07Gk2qU89nxajdy90QRs4v3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::23) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|IA0PR11MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a52a8c-4992-4495-4431-08dc9f6cbedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUdaYVByQ21jOTE2ZkRBTmlML1NmaFVuWTNGVWdyb1RmMUxkZEFGaGxBUWZM?=
 =?utf-8?B?YXJoa3JiWUg1NGNDZXhLODhhVmcwR204VGFOWVpxWFZERW81VWh2N2JKL0g0?=
 =?utf-8?B?NndTSFUrYW1OZ3Y5R0JkblV2dzVxQnpHU3ZGVU9vUzBaaSt6L1hENHRZMG9j?=
 =?utf-8?B?b0d5VmNoRWR6TVQwYnV3Y3krWEh3RWN4aFlvUURkL0F1SlhlS0NnME5FYitH?=
 =?utf-8?B?UnYwYUczU2k5SmpvL2FPZUtXbjJPbGxEN21wZVR0ZTYyVENCOUtuQVNVVmxj?=
 =?utf-8?B?R0hMTklJL1NxRFpxWmF1V0xNQU9rWUJSSkg2bkxrY1dIMGNtUVo5bnoyNDlK?=
 =?utf-8?B?czBJYmxiMEhWWkJpRGRCaVlLL2ZGQlVhWFJoY3BFdWM3UUF2bmVsSDAzbFpM?=
 =?utf-8?B?ai9BTlNpNkVjZFlRdE9ZRjRldjE1bGMyckhQQng3NFBaL1EwT2t5cUJ6VnFj?=
 =?utf-8?B?cnpsUC9DVE15Mjh2NWtCQnY3RWMzT0syK1JOVUtidmIrN1dIME12c0NIUXBV?=
 =?utf-8?B?cWJVeG1TRlk5dlQyaHVuUEVHNkViRUFOekUrSHNyVE1aK1Qwb0pnRFFHTkRP?=
 =?utf-8?B?N2c1bUNyVVFzUFdIRmhrdktDdWRVZUpsdWFCc1BRSVJkREJWNXlQRmZLaGtZ?=
 =?utf-8?B?a2dTRGtNQk12RXcraGcrUDQ0N0ZGY0dZZ3JNQktERTQ5ai90SVFnRTJTTU1Z?=
 =?utf-8?B?TEZoVW5lVjU2dEtMN3hkTG9sQTN4QjVjUTJ3TENMR3ZyYyttSXY1RE0rU01p?=
 =?utf-8?B?VlN3c05UQlJZRjRrL1haQjN1SXhjMGxkMFI1N3ArczJLc2lITktkNVRINUpq?=
 =?utf-8?B?S0k1RTFVNTN6dnBTVVYrR3psWXpWZGhaU0pvcDAzQ3hiNkZOS1MvT3BFTlQ5?=
 =?utf-8?B?VmU2SEc2WitiWThDYUJMKzRWejYrYTMxZERZSlA0bDhHOEdJNWZXM2pHcUE4?=
 =?utf-8?B?ZWF0QjYwN3crOTFpWmgvU2FZbFlJR3JBbjErU04xNkZMUnhTaEFjL3EvZDdz?=
 =?utf-8?B?M2lwWFRWaUc0aDJ5bkdPT3QxOTVxbGV2OURpNTJ0NzdEZDZpTmxTRTk1eGQy?=
 =?utf-8?B?TnpSaHRtMUt5bzNkM0N4a3pHZFFSZjJIejJKZTZwVlRYL01BbmhPUlZleS9W?=
 =?utf-8?B?c2s4eWZwYVBJTXFrczdGY0dlVWNrNHZ4b2duMUVLVUkvODMzNkdYZnV2LzIx?=
 =?utf-8?B?eG9QeHBUTHFuKzcwa1FFaUt4VjlCRUlGMCtiM3hneHFISFNPaFJFc3BjeGlN?=
 =?utf-8?B?WHhTZ2Zqc1BpOTZvaU90U0hzc2llbVdTRWZwd3puQXU2STBRUEZzWVhBWEtP?=
 =?utf-8?B?MzNqT2Z5RklxbFpCaGZKYWJOOEV6RTlwQjVDcWNqNEJ4R29QMUtUS0pROHNy?=
 =?utf-8?B?ZlJPRkpJcERaejNKeG5zZFhIdkxCOEpIR2YxMk5ETGQ5cGxaZXp1WXA5VEtZ?=
 =?utf-8?B?SGUxQlhJUWJxOTM0a1FEYWxkOWZWQVBPVTVYNjVFdzFUblhocDlzc0dGczdI?=
 =?utf-8?B?ZWtJS3VSVTdXS29UNEhXcE9kRXYwYUFma1NuaUllQ1NUYk9aNm53ZjMrVFRn?=
 =?utf-8?B?bGJnUFBQekZKYnRPUnpYOFg4RWxqZ1dULzM5ZjJxS0dHbit4bW8xcmd2Z2VL?=
 =?utf-8?B?UWZYWVBhRWN1amNXSFl6V0tCSDRoT0M2TUlHNHhRenVOUGtFem9zeGtlbnhB?=
 =?utf-8?B?Sm5FaDgyVWQ1RGptbXdja2NLK29rZ0xYWGI1VFZIeTdqZy9LelFEQWZjajVz?=
 =?utf-8?B?cHE3L09ZYi9XNE1mZ25lMnVBSWlBVGJEWmtlWFN1Y0ZnYkhwVnBxbXBVYmFG?=
 =?utf-8?B?MlBVWEU0YWFqVFV2eEZzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGs4cmNkU3dIMmJJT3V6bER5UWliWVRab0RDNFVaa2lqSFRKRFJUSFJyM0lh?=
 =?utf-8?B?VVp0RkVwRkJ6bVkxODdDZ2ZMM3ByY2ZvcUxnY1Bkc28xNnY0OGJYZ2hiK1Bi?=
 =?utf-8?B?RTY2U2NjWlF5SDdvRDgxQ05YWUpEOGk0Q3RTcUhYalZZckpWZ1NBL2thUzhr?=
 =?utf-8?B?V3VJcVZxM01KMk9TYzNpbmI2VW1SdUQrMzc1N0pOa1p6VG5Sb2tHUlJqTGtR?=
 =?utf-8?B?bE1aVkc3cFFkNHFTaGVkSkNNWHVDcEtNVklPeUpNTnA1M29oNGl1MTNUQmx6?=
 =?utf-8?B?YmdqQW9IaFhDRm9wUWdIWHQxUHhzOVZPcjdNTEpabEMvR01UbnJMZm5WYXFG?=
 =?utf-8?B?UlUzdWhYV1krMnJqanBPbTg0RDREaWM0L1B6c3JtMkZMWkw1akRPOEpPVFlP?=
 =?utf-8?B?NnJWdzY1RXdHVmFSRFRDaVFaYnYzL3JyV2x4S1pic0F6MWR3eHJaUlRQMGVG?=
 =?utf-8?B?M0d2Q05ETGNoa1pETGZsSlFvUFJSM0tld1JxbUx1QjVsV0U0eUJoSzhSa3NU?=
 =?utf-8?B?YVlpcW1nUEx0SGdoRllPWnE5TnhuMy95SW1yaVF1TG9SeDV5VmRyelBnWTlI?=
 =?utf-8?B?SkJ6V2drU0dPY05rMnhVUE9ZYkEyNDdJNy9naWgzMVJoaEcyNkg3NFErTjV4?=
 =?utf-8?B?QkVLaUlBMmdiM2Z6aHdRYlEzVE1wbU9YLzlMVEFLRWMwVHFyc2g1WkJEa1Zj?=
 =?utf-8?B?UWFWeEpjOWR2SnFJSnoxbXVsLzNHOG12aURFVE1BV2dJeWpHSThZbWNDc3g5?=
 =?utf-8?B?QUNrMCt1WGR6ZGNUb0Y5NW1CbWNGQkE4UmhPNjdqNVRwdTNQbndYOW9oaEJ0?=
 =?utf-8?B?VWNoemFxcUJEdTlTWUlhM2NWUkpTNHN6K3IrUU9pQzcvTUhrUkVpTFBWRjdr?=
 =?utf-8?B?cTVTbk1DUDd1dkpjbkx2L2c1RTlSQlhDc2VCL1Byc2NhZ1VhRy9CM1RBVDAw?=
 =?utf-8?B?QkI0QkRsY01mMDBqQzQwVTFTMG5UTytaMHVuQ2NpUU5ObHlWblgvdC8xdUtk?=
 =?utf-8?B?MjMxOVpjVDBXdk0rOTkreGlkUXRiRERudzEwTlJ0NmNOcEtObi9wa05qcTJD?=
 =?utf-8?B?aTJUcTVaM2tBdjUyblorMXZrVWpjd0grZnVUcDk5bkc5QXBiMlptV0hKUkdp?=
 =?utf-8?B?UjM5RjIrMTk0cThPSUNWZWQvRkxTK3Q4MVVFWVc1Qzh1ZWJRSzRKbHBhSGZY?=
 =?utf-8?B?bFhIOUY1emp2bFV4SHVQK2I1UnB2U0NPeXJ4cC9Xek85Y2k0SkRuejIxVjc2?=
 =?utf-8?B?NHFjVGg3aTRjUU83aW9odHhvdXZZeHc0ZzlVaVpmMExNL0NKN1I3V09FaFRz?=
 =?utf-8?B?UmFBQWY3Ym81TmQxTnduaTZjdCsvOTRlcmFIVkVKMzBKYytHVklMTGF5dEND?=
 =?utf-8?B?Mk9nK3BWUXhZTEF0WHdxeGdDL1REZXNETmdkZTl4N3VhOG5UaFhadmErbHIx?=
 =?utf-8?B?RzRnaHNFUDRUTVNoZGVXN3A1YXE2cG1iY09XZzFDb3Zhdm1GUzNJZnVJTnNN?=
 =?utf-8?B?V1laNTFjY21rb1RUVGY4Wk1sVUVXY3FRV3F3V3NkUUlxbFZaVVBRYUlBbzN4?=
 =?utf-8?B?T3prQ0ZLRVhjMXBud0UwWGg4NmJELzI0RWIvMUpFK3lDaXZBbWVQLytCOEFX?=
 =?utf-8?B?SG9rVHhmUHBaQjlaTGI3Yml4aDJxQjgyTFhzcFpudXJtVzBndUNDSGpjdi8v?=
 =?utf-8?B?RVo4NVlMRHJpTWtWd1NNYkZmWjU5OFl4TUZqUVNWMGgwOEtoVVdxakIwaFhU?=
 =?utf-8?B?Y1FjU0hTaGwzMWUwVm1acWRDeSt0Mlh1aVdmN01yMVM0TlZldTh0dC9rWXBv?=
 =?utf-8?B?eFJ0b1M3dElFUzRYT05VTE5aT3M5US82K294RU1RbTdadnhlRWIyaFVKL3Np?=
 =?utf-8?B?VWhialBsV0dhbmR3N0twVmJUdTJqbUFBUWd3ZDVvQ25KQkFQSm4zS1VlQStC?=
 =?utf-8?B?dHlzSTdJeVRyaWJ6eTNwak84TUJsRzJJZUlwSUZOYWp5aDBKMmMzdlRBaUlP?=
 =?utf-8?B?a0FkWWg1L3QrVTE3SEwrbHowK3VHdWxJWXc5d1RiT09mT2NpQXcwZGFSd2Jl?=
 =?utf-8?B?UlRyZmJpb3U2TWtkVDAzMXRjQmd6azZJbGZ3dEl6Tm0yRWJkOUc4NFU0dGxq?=
 =?utf-8?Q?TiZY8eRBSAkZIEuYUGYuy1Py5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a52a8c-4992-4495-4431-08dc9f6cbedf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:40:58.8619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAk9Qt10KIQ7uF8qymqea553jOFDw+QC9o3E9d++VBi+EqGUCA8yjk3TbZ39Wzk5FvdcVTcGgF93dQ/nnhe8zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8379
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 7/2/2024 11:26 PM, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jul 2, 2024 at 10:11 PM Kim, Dongwon <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     Hi Marc-André,
> 
>     On 7/2/2024 3:29 AM, Marc-André Lureau wrote:
>      > Hi
>      >
>      > On Fri, Jun 21, 2024 at 3:20 AM <dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>
>      > <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>> wrote:
>      >
>      >     From: Dongwon Kim <dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com> <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>>
>      >
>      >     Introducing new virtio-gpu param, 'render_sync' when guest
>     scanout blob
>      >     is used (blob=true). The new param is used to specify when to
>     start
>      >     rendering a guest scanout frame.
>      >
>      >     By default (and so far) rendering of the guest frame is
>     started in
>      >     the draw event to make sure guest display update is
>     sychronized with
>      >     host's vsync. But this method inevitably brings some extra
>     wait because
>      >     most of time, the draw event is not happening right after the
>     guest
>      >     scanout frame is flushed.
>      >
>      >
>      >     This delay often makes the guest stuck at certain frame for
>     too long and
>      >     causes general performance degradation of graphic workloads
>     on the
>      >     guest's
>      >     side especially when the display update rate is high. This
>     unwanted perf
>      >     drop can be reduced if the guest scanout frame is rendered as
>     soon
>      >     as it is
>      >     flushed through 'VIRTIO_GPU_CMD_RESOURCE_FLUSH' msg. The gl
>     display
>      >     pipeline can be unblocked a lot earlier in this case so that
>     guest can
>      >     move to the next display frame right away.
>      >
>      >     However, this "asynchrounous" render mode may cause some waste of
>      >     resources
>      >     as the guest could produce more frames than what are actually
>     displayed
>      >     on the host display. This is similar as running rendering
>     apps with
>      >     no vblank
>      >     or vsync option. This is why this feature should stay as
>     optional.
>      >
>      >
>      > Indeed, I don't see much point in doing so, it's pure waste. If
>     you want
>      > to benchmark something perhaps. But then, why not simply run a
>     benchmark
>      > offscreen?
> 
>     Benchmark score is not the primary reason. The problem we want to avoid
>     is the laggy display update due to too many asynchronous plane updates
>     happening in the guest in certain situations like when moving SW mouse
>     cursor rigorously on the guest. This is because the fence (as well as
>     response for the resource-flush cmd) is signaled in the draw event.
> 
> 
> Presumably, you won't get more frames displayed (perhaps even less due 
> to extra load), so why is it laggy? Is it because the guest is doing too 
> much buffering? 

Yes, I believe so. Virtio-gpu driver can't issue another resource flush 
as the previous frame is still on hold by the host. But there are many 
plane-update requests due to frame buffer updates because of the 
movement of SW mouse cursor in between. BTW, we currently use dirtyFB 
update on the guest running Xorg. Maybe using pageflip would make things 
better but we haven't tried it yet.

Because the mouse event queue isn't being drained
> between scanouts?



> 
>      >
>      >
>      >     The param 'render_sync' is set to 'true' by default and this
>     is in line
>      >     with traditional way while setting it to 'false' is basically
>     enabling
>      >     this asynchronouse mode.
>      >
>      >
>      > As it stands now, the option should actually be on the display
>     backend
>      > (gtk/gtk-egl), it's not implemented for other backends.
> 
>     We can help to deploy this concept to other backends if needed.
> 
> 
> Why not make it a gtk display option instead?

That is possible but I made it virtio-gpu option as this is specific to 
virtio-gpu backend. We can consider moving it to gtk layer if it makes 
more sense.

> 
> 
>      >
>      > I am not convinced this is generally useful to be an extra option
>     though.
> 
>     I initially thought this should be the default because the virtio-gpu
>     guest should not be hold by the host for too long in any cases. And
>     this
>     new approach is comparable to the default mode with blob=false where
>     the
>     guest is released as soon as the resource flush is done. Only
>     difference
>     is the resource synchronization using the fence.
> 
> 
> virgl should be blocking rendering too
> 
> Could you detail your testing setup ?

We use ubuntu linux as a guest OS but it's modified for our GFX SRIOV
setup. I am not sure if this is the details you are looking for but here 
is it: we virtualize our GPU using SRIOV. So individual linux guest have 
their dedicated portion of GPU device that is detected and worked as 
"render-only" device. And since it is render-only, we pair it with 
virtio-gpu device/driver that provides display function. Scanouts on the 
guest are allocated by virtio-gpu then imported by Mesa driver then used 
as a main framebuffer. On every plane update done by compositor will get
virtio-gpu driver to issue resource-flush (followed by set scanout) to 
host. Host (QEMU) gets this scanout data as blob (scatter-gather list) 
then creates its own dmabuf using udmabuf driver. At every resource 
flush, we block the render pipeline as well as the guest until the 
rendering if finished for scanout synchronization as you know.

We do not use virgl (instead, the normal HW driver for SRIOV-Virtual 
device is used).

> 
> thanks
> 
> 
>      >
>      >     Dongwon Kim (4):
>      >        hw/display/virtio-gpu: Introducing render_sync param
>      >        ui/egl-helpers: Consolidates create-sync and create-fence
>      >        ui/gtk-egl: Start rendering of guest blob scanout if
>     render_sync is
>      >          off
>      >        ui/gtk-gl-draw: Start rendering of guest blob scanout if
>     render_sync
>      >          is off
>      >
>      >       include/hw/virtio/virtio-gpu.h  |  3 ++
>      >       include/ui/dmabuf.h             |  4 +-
>      >       include/ui/egl-helpers.h        |  3 +-
>      >       hw/display/vhost-user-gpu.c     |  3 +-
>      >       hw/display/virtio-gpu-udmabuf.c |  3 +-
>      >       hw/display/virtio-gpu.c         |  2 +
>      >       hw/vfio/display.c               |  3 +-
>      >       ui/dbus-listener.c              |  2 +-
>      >       ui/dmabuf.c                     | 11 +++-
>      >       ui/egl-helpers.c                | 27 ++++------
>      >       ui/gtk-egl.c                    | 93
>     ++++++++++++++++++---------------
>      >       ui/gtk-gl-area.c                | 90
>     +++++++++++++++++++------------
>      >       12 files changed, 146 insertions(+), 98 deletions(-)
>      >
>      >     --
>      >     2.34.1
>      >
>      >
>      >
>      >
>      > --
>      > Marc-André Lureau
> 
> 
> 
> -- 
> Marc-André Lureau


