Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B7CC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHnw8-0005BN-Na; Thu, 13 Jun 2024 13:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sHnw6-000560-Af
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:08:30 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sHnw2-0003HM-41
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718298506; x=1749834506;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ifRAqtFBJgF0A4UAVB3pBITa6MU028Uoaih6zxD2XJ0=;
 b=PtEd6RuSQOtcSTnBsYqhJuHkADpCZOdVjY13lO3BcsMY1WSZPB7pSX1O
 /tCIKhOKEnIsvahJujWt0LHRytTVV2YcEuOnIPaxiDJRRjzjdamvggYAE
 OkmtCCZXM+qGWHY6wdzOUGPFddmtG/oTMWTmsBvNHfqObUmKYpMSJe7Nj
 JHBY6b+ZoaXCS3JLyXAMqKGQy5LP7YKGLUUKhA/OodNZY17ok6UjS9FmY
 OEMzUyGhrSZWSaZuahn585kEESzV55xS4JCD9i8ocylapO3OO2wsOB7+o
 PEjcFYW/xqTuTWWO9gOK6crDtC/Q+Rj6kloRGp6Nofsmv3q/F5fePbr6j w==;
X-CSE-ConnectionGUID: 4ekYFUtPTHGJr1cU8thB3w==
X-CSE-MsgGUID: XEWGMOCyTxG+yMGjJBuI1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="18969174"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; d="scan'208";a="18969174"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 10:08:21 -0700
X-CSE-ConnectionGUID: KvKdEXdnTDKXXuDptpljIA==
X-CSE-MsgGUID: 3T4GYNuESda923BbnHcvKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; d="scan'208";a="71425257"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 10:08:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 10:08:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 10:08:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 10:08:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdSUCnqv2r+heAevE7sR82xtOaIyHM8L3IRqmYlRCQjrFX74UcdqznmD/xTg/TcAiFZMH1k4Bfbx+9fv+3ZeQiSak3iwN6CMIAi79PF+fm9SPEsnsWY6IwZTvnRS4rEUytGlW/MkZPbpKt/4VWYxx8Z9JJXop3XO/Yu7AB1I7EsApTwgMGqXwyIwQbHlOQMAGRZhmcY/ch2TJ0590IZO6UpGs9OJFtHRSgm5HnG10Z+r678BKsjXao9y66c1YBhxH7rIMcKPObtw2oCEwsOHcTirBzW7yMuVq4p030AHEb68oGZvduzd8jCLXerp/TAT/w+g1HgIPXqeHc3I+BGQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uczl/0p6OQsSGHpASBuYFuzOuBkWimY0GeSOWhgRic8=;
 b=chshVHXy9rB3Fwsjv0EJzC7t8Z5EQV/czofy4zo4wfmAdevFaPmChg2tTfVdmAuIpmoKUK7K7PNJ0r5FFeYqy1yLlnuGDUzLQYlNWpCg2tGVAxhAhJUMWZ7mDBiZSmxRFVphlhlDKjDaNpTbi4GVbZdl+b1QpcWunKqzkdRr8/ZdjrDpgIPtZctMfiy1Wcz4XfHFBgYRqi4yIwD5QwEWT/cDbgSfGM4bQYyMjzh5VvYYC7yliKDXLict7asWXSs9KF2Ul26s+mkmqMPZ4FiqP0XSWEqQ5Iy4f1CsyhCKLCCgo+YyDt5QxinSgNPInHlu4T+tRGSGHSv9W8fz/o3Djw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by MN0PR11MB6232.namprd11.prod.outlook.com (2603:10b6:208:3c3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 17:08:16 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 17:08:16 +0000
Message-ID: <d5c18317-da45-4751-8392-56acf8e87ad9@intel.com>
Date: Thu, 13 Jun 2024 10:08:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>
References: <20240531185804.119557-1-dongwon.kim@intel.com>
 <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
 <a89b283a-24e3-4117-b465-ab8d79252625@intel.com>
 <CAJ+F1CJ-4cWV81_YTit5jTEoY6FPTeu7u177pZzb61FhXw_j0Q@mail.gmail.com>
 <fa43009f-1292-49f5-bab0-618028c16045@intel.com>
 <CAJ+F1CLAJTZLHKa9_zVo=-GLRw8JHnzJT=G4fdLLsaS1sK2HUg@mail.gmail.com>
 <0fe76150-c347-40df-8d69-18a5d132d8bc@intel.com>
 <CAJ+F1CKsboFZ-fWUXrf5BSMKCY6boRAoTMVRLaHgGja2Eppx8g@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1CKsboFZ-fWUXrf5BSMKCY6boRAoTMVRLaHgGja2Eppx8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|MN0PR11MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c134796-cc7e-4d57-6ab6-08dc8bcb6a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkRnOFJEUjlpZXFEbUNVVWxyNmswSGV2dDc3YzFJSisyZWhnbUFIUkQ2MzRs?=
 =?utf-8?B?MGk0SVVuaHhTUnpUTTd5RWp6S0MvN0VHMy9IRlNRaWJYMGltb2wxcXJ3dmpU?=
 =?utf-8?B?MTUzN0hLcDQyTHdmNFVUdlFJNkJFWFBUSmljMS9JQ0NLWFRDL3gzbHdDV0Jm?=
 =?utf-8?B?ZC85VXdVRnEyOU9Sd2RXeUU1MlpWd2pDZDd0eUtIYTBDbjBVQTYxSzNYUUls?=
 =?utf-8?B?QzlkbFhrdFpJNUkrSjZudnlyWjhMeTFka25pdjlWRUUyQ0syTjNRU0hCbE92?=
 =?utf-8?B?L3ZrTVVNVWs1QkZTL1gzdERkblRXRHY1UkdkRUNrcSs4b3FseEM4M2twV3dm?=
 =?utf-8?B?b1BLRVJaL081ZVk5TncvZlBoRzFVbERKeUtXNXRpS3g4a1UxQ3oyQ05hcnFG?=
 =?utf-8?B?Zy9YTmpoUWlzVUxCVERWYWVhbit5c0kvaURpTE84Q0d5NU5kNUhEa3B1VnNM?=
 =?utf-8?B?OWo4ZVNHQzNYS0oxYjAvRGJ0dFlsNi9wZCtNcnpJVXBvR2NzUURtMnZSNHRz?=
 =?utf-8?B?RE12WEwzaUtPZUo2RmpLWmdPUk15ZEVCY2JKbnpqMHlVamUxRzZ2dGJpNzE2?=
 =?utf-8?B?ekxtZWlRTFJwRE5TamYrLy93aTRZeHU3amFnVEpBaTJSUVhHRlVrYzhmazlU?=
 =?utf-8?B?LzhFb0dmN0RteDYwNlFOMXRoaXJ6SnlHcDVxZU54d1F0QzRaamZ3aVl1dUhJ?=
 =?utf-8?B?UC80MjBHcGpxbTNjYTViK2lpamFEdm5XSmFsZFhxSTQ4Wk1mWjZhaXRyUGRE?=
 =?utf-8?B?elpOaEhjRDlEb2duYlZPZDlCLy9HaTVyaTg5clVDaDRNUWtDdVgycW9CTXhq?=
 =?utf-8?B?MWF6aWdMZ0Mwc1QrQlc1ODlhM3RKZWxDSVg0L0VieS83MTJoOWpmTSs0QklU?=
 =?utf-8?B?R3RqWTVvSzFQR3UwMlQwSWtEYklmNEtETDZ1cUhLN1dzQk1JUEQ3L0RKd1Bz?=
 =?utf-8?B?b1RXb280ZzRYMWN5MWdYZ05UVmVMRVQ2YUd2OFp0c2MxTjJ6ZS9WZ3c2cGpq?=
 =?utf-8?B?dDJBRGZzTUpOSUhSZklMaU5xc2U3cXZFYnhLTzNJbko1RGtaTlpaeDMwblhy?=
 =?utf-8?B?TjJDTXU5a2pzaURLcXpFclQ0U1B5ZUVzY1ZMdy9MRWdSeXZlZXE4SzJoQk1C?=
 =?utf-8?B?SlVOL0lVRDMzanB1Zi83WmJqekQvRUJzbU5vOG9jT1ptcXhTRERrODNJY3Rl?=
 =?utf-8?B?NVRRQzhmbTlmeGhFajlmUktUT0ZsbUVqUGpTWmVkUTdRd3NnczBvVHZtcjhY?=
 =?utf-8?B?Mzd3bUtXUWh0NlNMMDlJWDdjTFhQc2dCVjc5SG9pTU1tWXd6eGkrY25oRWpJ?=
 =?utf-8?B?MGdvc2ZhUFlhTCtERVZSOWp0Y1RoMURMYWF5TThBNG9help2dVlrVTVIc3dO?=
 =?utf-8?B?MVZZc2lDQ2RMMUFIS2VILzBWU1hxQmMvTEd3SThsUVNlQVhyQ3llY3VhUy8v?=
 =?utf-8?B?cmljc0ZJUzE3VXBjdkdaeFFvUFA4ZmpaZkdldExnVHJQdnNCQVNESXE3WEpP?=
 =?utf-8?B?M1k4STF4Ny9rOHczWlR1RnNjeDRkdUZUcms1UVhlUm5UemU0YkR4Sjd3RmlV?=
 =?utf-8?B?blMzRTdrMThraTFuQXhYQWluRGxIa1ZMUEJ6YkZTNVpSaG9nNURLbE9ZcUhZ?=
 =?utf-8?B?elVYS3k0R2FFTUFaMUp0TDloSVA5TzlwK0t5RUg0UW5kbVB0R2tGNnlDajc3?=
 =?utf-8?B?cDFLZjd3ZUtwcC9PVkJYREtzaWpCVHpIYXNyZ25sMjRSZ1ljc1hjdlhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230035)(376009)(1800799019)(366011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3Z5U0FPbkNrbEx2M3dLR2g5TFBYbjBoc0Zqak0xeVg1Q3dXOGx6b0pTS0tn?=
 =?utf-8?B?Wk5vR2xpVGtBNjQ3bXFvZCtMZVpUQnpaaGZYLzZ1ajFEbGJIbUUwUTlxYmdJ?=
 =?utf-8?B?MFZ1dXc5L3VDNDJzcktSS01JOGdVNTliQTJrZW1ZMmRnRk9WNmRSUXBvSmFQ?=
 =?utf-8?B?dkxoakd6WllNMldZNDB4Rmhqdms0M0dMQU0veVd1b2U4VWs2TlJRU3M3VUhD?=
 =?utf-8?B?MlhrUFM3aEk1dEpObXRYR1A5OW9ncFhvTjNZNVBxM1lNaFpvNlRDdS9lb3VQ?=
 =?utf-8?B?UFlyYnVEUWloN3AxVkZjTVJUVm0ybFBTSTFpbFYvY2VxY09XMFZCNVR2cmVT?=
 =?utf-8?B?dEd4ZzZqTXJLc3liRDRjZmswSit5TEpNU3NURzJuVHMwb1VCRG9BMmJDVW9Z?=
 =?utf-8?B?dk1WekovNmwwTnJtallxb29iNVNydXNvTUFHYWFmdmN1eTZSUjYrUmxWTkFm?=
 =?utf-8?B?cVRIOG52UzVnWlFCNTk5SEdnYUkvM2tkMW1meExESk85eVUvQXZ0RUtFdFhw?=
 =?utf-8?B?TmhXYXFSeWlaSWtpMXZPT0pndE9Dd3NtVGxkdUFPcUQ1S1dKMjVkNm0xZG04?=
 =?utf-8?B?T0djTlpmMnFtSDVRRk9JQ3RKdU41MldjR1hvN3pybHdCZHhVQXJKM0hwMHdp?=
 =?utf-8?B?eHNRTWRoL3ZWZmJPSC8yaFl1eUJFc3ZjN3dncVM4M2FZUVZoR0V1RGxHSDY0?=
 =?utf-8?B?MnBiRDFZSVNFVWttVXQwZjhWZmZUclU5SWhSVnF2V2Z3UUFZczBraXZQZzUx?=
 =?utf-8?B?cDNUcHV1Mk85bUtBVmZNakJLRzRsQ0NhemJPUEtEOURRTlZiWEZKaHd0QTFK?=
 =?utf-8?B?ZEVQeHhjajFPUlQ1dTl3WkdxUC9IalBpYUtyYmxnNzU1Ym5YMDgrQ0ttbWtq?=
 =?utf-8?B?SEpqQWtJdEtYTnpTR2pIWTNHZFJSb1JlTVg0akxyT21SUnZibEtmWHJUUkMx?=
 =?utf-8?B?YUxIVzBaVEc3ZHpYQjlhWk8rQU1RRnd0UXp1dWExVDZpdTZacjluUkdTK3FK?=
 =?utf-8?B?cUhxSnJieHdNbzdqazExNjNnMll4ZHlockhEK1BFbDdOak13blVMQjB6Mmwr?=
 =?utf-8?B?bGxZTll2TCtTYXlScEEzRjNtcndEQWxhSEdhWVk3ZWxyaDFwSGRzMWozb3BO?=
 =?utf-8?B?MFpGMEp4RXFlSEJ4WHdqNjBjV2FpSHhkQTVZMmxXZEdJemN6QUZwbE1uUDBI?=
 =?utf-8?B?QTlZWncvc3lCVlFrOEJqNkVlVmhBMGRMTGlaTHJYQVZhS3c1ZTM5dy8wWUNi?=
 =?utf-8?B?RWU0cGtOWHVIbkQ3bnBHNVJIRmxQREZPNm4ySHhpOGIxYW1sYWVPL3N0OFJv?=
 =?utf-8?B?emVySUdVMFNySDBLaWF1WGJBYnR4MXpGd29KOFAxQ3NXQmRQZlcrYTltMVBM?=
 =?utf-8?B?SldJaHJ6NkN5QlkyN2g2S1ZCd2FsSjNvL2IybEVKYnJRTEw5V2lOL1JnanJN?=
 =?utf-8?B?MDQ0alJRdTZZbGFPUmVHbkRZbWMxTjcyMGhyekVSZmFRRGNWVnpmQWl6bjgv?=
 =?utf-8?B?anc5dHcxanAvblBMZnMwTm52WEFncWtvNEpTNXJCaGdJMVppNGo3N2p2OW1C?=
 =?utf-8?B?NXBnS241UFVjMDcyN2JESGxXdVowWThiTHZlekJyc1pzSU9HeVpLdEExQmM3?=
 =?utf-8?B?VVMwSXJZakpmbW90V1RVWlhpMS96ZmtiTGdUbTFZb0o0VlF3WFpGeWNTdks1?=
 =?utf-8?B?U29OeU9kNm5YWk9YdEdWOVpEeGZLQjQvL0FRZHhVbkZBdm9VN3pDZldFQjdY?=
 =?utf-8?B?U2ZZanFkbDFweVZkczNPWU1YV2Zod0VCTktJb1Y4TGtaUmhTVExXUzVTc1Fi?=
 =?utf-8?B?SXRZdzllRzNzYnhFYTh1YThYbHJKbWNWYVlweUVJRmxLMmI4L2ZwYXBVb1Zu?=
 =?utf-8?B?eVdSMXFkU0xBMDBHTmQ2UEUyTStsK216dU5vd2RHU2RyREtYQUo4R0VlSk0v?=
 =?utf-8?B?bWoyZ05NL1JVZEVLamdtbm80SVBuejVzZDZWWDkrWDY1VWJRdC83Y3BDVThp?=
 =?utf-8?B?ZEpJTzB0eG9sQUJBUGVFQUQ0eS9VNTZtakVtSC93MVE3cGI3cUtZN01RMHFI?=
 =?utf-8?B?Ny9rQVlGNzRPSWFDaHFtUldVMWR6RTdKNnVGV2JhNU9ESXVWNjUzdG41OG9J?=
 =?utf-8?Q?I+NmzsZ6XgwqEqCrWOjxuhvhZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c134796-cc7e-4d57-6ab6-08dc8bcb6a8f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:08:16.4146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDOl8yB/oxC+CDI7Aoe7OgVtFknixa53soi2wzUSebQlaIe1fh1advKP1kA3OszGI/OeSeH/mfu2YMz89yxtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6232
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

Hi Marc-André,

On 6/12/2024 11:56 PM, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jun 13, 2024 at 3:34 AM Kim, Dongwon <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     On 6/11/2024 11:42 PM, Marc-André Lureau wrote:
>      > Hi
>      >
>      > On Tue, Jun 11, 2024 at 10:28 PM Kim, Dongwon
>     <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
>      > <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>> wrote:
>      >
>      >     Hi Marc-André,
>      >
>      >     On 6/5/2024 12:26 AM, Marc-André Lureau wrote:
>      >      > Hi
>      >      >
>      >      > On Tue, Jun 4, 2024 at 9:59 PM Kim, Dongwon
>      >     <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
>     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>
>      >      > <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com> <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>>> wrote:
>      >
>      >      > Xorg may not be going away soon, but it's used less and
>     less. As
>      >     one of
>      >      > the developers, I am no longer running/testing it for a
>     long time. I
>      >      > wish we would just drop its support tbh.
>      >
>      >     There are features offered by Xorg that are not offered by
>     Wayland
>      >     compositors and again, we have customers that rely on these
>     features.
>      >     One of them is the ability to position the window via
>      >     gtk_window_set_position(). There are strong arguments
>      >     made on either side when it comes to window positioning:
>      >
>     https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/247 <https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/247> <https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/247 <https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/247>>
>      >
>      >     Until there is a way to do this with Wayland compositors, we
>     have to
>      >     unfortunately rely on Gnome + Xorg.
>      >
>      >
>      > It's a smaller and smaller number of users. The potential/future
>     users
>      > are greater if we focus on Wayland.
> 
>     Right, but until Gtk + Wayland offers the same feature parity and
>     customization as that of Gtk + Xorg, there will be distros/users that
>     will keep it alive.
>      >
>      > Fwiw, GNOME (and RHEL) is set to drop Xorg support
>      > (https://gitlab.gnome.org/GNOME/gnome-session/-/merge_requests/98
>     <https://gitlab.gnome.org/GNOME/gnome-session/-/merge_requests/98>
>      > <https://gitlab.gnome.org/GNOME/gnome-session/-/merge_requests/98
>     <https://gitlab.gnome.org/GNOME/gnome-session/-/merge_requests/98>>)
> 
>     Doesn't look like it is going to happen anytime soon given the massive
>     pushback.
> 
> 
> The plan is there, GNOME has made bold moves in the past. There is not 
> much left in the TODO. But yes, it takes a bit longer than expected.
> 
> 
>      >
>      > Btw, there is a similar monitor-mapping functionality implemented in
>      > virt-viewer/remote-viewer:
>      > https://www.mankier.com/1/virt-viewer#Configuration
>     <https://www.mankier.com/1/virt-viewer#Configuration>
>      > <https://www.mankier.com/1/virt-viewer#Configuration
>     <https://www.mankier.com/1/virt-viewer#Configuration>>. Is this
>     something
>      > that those users could use instead?
> 
>     It looks a bit similar and interesting but one difference is that our
>     feature uses monitor labels such as DP-1, HDMI-2 which is a bit more
>     intuitive. And, the other key difference is that our feature includes
> 
> 
> Intuitive, perhaps. Discoverable and portable?
> 
>     "hotplug" functionality where a Guest display/window is deeply tied to a
>     physical monitor to make it appear to the guest that it is dealing with
>     a real physical monitor.
> 
>     In other words, when the physical monitor is unplugged, the associated
>     guest display/window gets destroyed/hidden and gets recreated/shown
>     when
>     the monitor is hotplugged again.
> 
> 
> Interesting case that could be added to virt-viewer if it's necessary.
> 
> The subject is sufficiently complex that there is already additional 
> documentation/specification in:
> https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=heads <https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=heads>
> 
> Honestly, I don't support the idea of duplicating this effort in QEMU.

Marc-André,

My assumption is virt-viewer might not be able to completely replace 
GTK-UI path in terms of performance and smoothness of display update as 
(I think) frame copy between processes is implied, which is same as 
spice-remote viewer. What about display-bus that you have been working 
on? Would it be a good alternative w.r.t perf concern that I specified 
above?

> 
> -- 
> Marc-André Lureau


