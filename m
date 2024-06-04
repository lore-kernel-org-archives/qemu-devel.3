Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CC5C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 18:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEYS5-0000gH-DS; Tue, 04 Jun 2024 14:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sEYS3-0000fo-R6
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:00:04 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sEYS0-0002jU-2z
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717524000; x=1749060000;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YTSjOIFYRHeIY60lMY+xheUkTBGmqj4OTJYAUQb0Js8=;
 b=JC40QwW5PtSNE7vR7ccj5pm5Pf8waW2QSHAGvrIEdV3U0O5P/mv6NKdu
 YGcYlVcTMZFhrA4xZJ95VnR1Ah2Sb1kK7ns6da7RxgqIzld1RZkprmxKT
 NcHpxyLqcStdTLamGeE619RurD3AL8sQnjqTqt2n3vomE6JYk1SZng2iY
 dh9dbOPNo3tTO+uvy4Lx6uTW3XVkDy9SY/HrDHweAf+xESfjGi3P/QYoD
 A4Sxa4t1XQvMBVXQSI3mAvHx4fvLMejaesMcMswvVlmlXDAiDe2ENY8DE
 /ra/mMw+2HiTUnNJ3oD3ov8Aw++xiwJQKvs1BAIJCPDzahee6y0eIfoJj w==;
X-CSE-ConnectionGUID: rh229qOoRx+YC+IL/bTtGA==
X-CSE-MsgGUID: 2hFX3KnpRuSIHdBNXrdKpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31587308"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="31587308"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 10:59:56 -0700
X-CSE-ConnectionGUID: RH9q28aiRnWrSc9wtD0wPw==
X-CSE-MsgGUID: P4fej4RnSeW6tNirLXDeQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="41746619"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jun 2024 10:59:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 10:59:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 10:59:56 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 10:59:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/LfxrWzNE93EM89zZt6JJwcIZTwyjkjEcrgwFiEkgxJic+ZK/JyGE76PQckf2HKtIjLVGtRzWiy90gJyO20WYNsSpmQ5LqcHvAAAk4Lx95bOw5Bl8bPezcv/Aa/p/7kPF6gt4s3LazZye5WbcIVkIt1XtgQSnOkJc7oPYv8CAIhwqffa2+BTqvG1qpNFpNvcHXOz2jKRwJLIZpWCkCivyAluWSa0tfjePaH2/EdCMSHADfasKjXaRbojB28LCk6d3bNYtFAgWU/PDvX/Je4RaGttrDx7lgfCy4o8Fb/6nL/QwxVl4yEPoQHeqUnxdTwfc7GkpCNQEse6a3XBUUxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n/Ijds7sx/HRQUWB//oYfpDH33RRakeMO3nrPpTdJA=;
 b=RJS+wwS6I8sfKCwXgPH+LX6N6uBLWSIY2E47SKdtrvCUGbPlpXSjY5LV6+C+qT+Ba6FgWiKpPFIoYxo0G3b7h0LDxO7abtqBIAKJvU1aUWDmsPfcwGtYLGALLGs5TstrQF3YQuwzP1H5upSegndKBenVwlyAcouUI8x5f40lLnxE7kH7nsG1Hg+PR59hb+gu9Wz6NVR9dNZQxcA4SgQtrSNMwiu6roct+klEJoOUok/IvRQgrXeFpvj0IpoaJ9Gj2X5qvdiGmpx33QNa6WGz+BRREpYlWnUJ5MySNStBltBE6BajpjsR7+lVR53rCJ6sqgsmAU8oJGJByqVa1GnGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Tue, 4 Jun 2024 17:59:53 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7611.016; Tue, 4 Jun 2024
 17:59:53 +0000
Message-ID: <a89b283a-24e3-4117-b465-ab8d79252625@intel.com>
Date: Tue, 4 Jun 2024 10:59:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>
References: <20240531185804.119557-1-dongwon.kim@intel.com>
 <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: fc86e3ec-59cb-476d-4c6e-08dc84c022ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVdsU0xPT2k1TGtCYTJUTzhWYnEra2Zvdk9PNjBWNTk2T3hTZlhXUmJrZXVG?=
 =?utf-8?B?NUZJOHVGYzlOU0N4bm1qOUgzTDJlRHUvTGx0Sk1EcVd3a3FFWStNVU5TRnNt?=
 =?utf-8?B?TFFxMzZKSlFvaTBVSkJFc1Yrakg2K0tGVmV1MDVRWnR3SmxXSzdCZ1YxbXVR?=
 =?utf-8?B?VnFUZDJnUld0NzBuZXEwOUh6SUNwVTBPSXg5bE5DSHcvTXlRZE1iTm9yZWgv?=
 =?utf-8?B?V3o0QzBnYm11VUJ1OWhNR1paUVVZNEpqeFZzOWpPV09aL0YyL1lWOGhabFFz?=
 =?utf-8?B?WmZzRTRYNFoweUFZaFJYcGFsL1JSUjZTc2FiTVFWMVVvOFZNcUlJRDgzQzkx?=
 =?utf-8?B?Z3RVR3N6d29xUmtmQmxnNVBxUjhLckdFTW9OSk0rUkhFTUZhUWRDSEgrT09l?=
 =?utf-8?B?KzBnU1Q0aGN6eVN2V29TTmJZd0l4RzM2cElqT1E3aE82blY1Z0RET3VEVEVO?=
 =?utf-8?B?eFFNRUNQcnpURTlPb2M5WWQ1NFlDd3A1WVdvVldMVlFHMDgwN01BTlkwV3ZL?=
 =?utf-8?B?U1NuRmZIZHFENW5jRHA2Y0lvMU1SbEtNaDhvS1VPMjZKQTcwOE9xN2Z6aXFQ?=
 =?utf-8?B?bG85QTVsZ3JBbUJYM2QxejFJcmRhK3FHSmNtZjRVMjQ0UHRoOU5BTldOa3RZ?=
 =?utf-8?B?MzNjQzFNQlZWZzMyZG0zSTl2VmtVVXk3eWJ1c3Q5REVYOU9WSXowTi9qNGxT?=
 =?utf-8?B?RUhJSkRVSnJTZmhNWHNkQ1FiamRONUY5RWhueHZjeHVWd1NsY0Evc1FEeXdt?=
 =?utf-8?B?ZGVlU1pVak5lVlBQamhrb1dKeXE4ZElBOVJ5NFZxRFJiNkduM0o2cHBHcDht?=
 =?utf-8?B?OStjOElaakRpZ1NGOWdEdi9SYzdYelloeklqSC9sNS9ocDJEUkh1eDhaaWZi?=
 =?utf-8?B?cTBhSmlOSnZTUkh6d2piQkZuaHFiM3diQ0JjREJQbFZIWVJMWVFQMkM0amlm?=
 =?utf-8?B?aVdxTEM5MzdETTF2TjYwNnNXemsyejFvUVdtam5OS2NDVGtRUUMyUDVuUTRn?=
 =?utf-8?B?emY1WjFQcDRraG9ITEwzTUx4WTlha0NlZXd0ZlNlWSt1MDlZb251dVVGbm1Q?=
 =?utf-8?B?bkpMWHNFMk90MExDRXZlRW8yZGRBdDNxZ2thcHlnSEhKUEd6bXFsdjFvWUNl?=
 =?utf-8?B?dkhBREVWcnBvVWpzcFRSOFFTeFBMWlBxbWdlMDJRZnZQY3ZWSWplVmtKUnA2?=
 =?utf-8?B?SjlmY0lLWk9UOGVVa3JzV24wTm5tZ2d1SEltak12emlreFZ1TlR0TGwxMXkw?=
 =?utf-8?B?c3cyTXhpMnNVSlRWdEQzOXA3ME02NjN6aXY5MWsrVkZnNUhJRmMwTEllRENk?=
 =?utf-8?B?OUJDYkY1aWJOako5a0hqM1oyS3F6REJQbTVBOUlUb0NKeWRYSlo3bzROVHlw?=
 =?utf-8?B?ckhlem1HbHNtMGEzbVdiUHVYZFRzRW9kMjZKYkNaUkNNckZkUEdIRS82ZmVW?=
 =?utf-8?B?R0VaaDJDM3pBQ054clJRQXR3Z1hZaWJ0cHp1cWRHWS9hYXNHV1NSaVh4aU9n?=
 =?utf-8?B?SGwvZG1wcFJ3UEk4blJETzRLTEQ4TkFLNXc3ZlEzcW10a1dPNEJMcExZcnQx?=
 =?utf-8?B?Q0VmUmRMejZLYnZ5U3Eyam45SUR0RkpBc3BnWDZwMGdyeUY5aCtIUEdWOVVs?=
 =?utf-8?B?dGM4NGZ5ellMczFpL2Y3MlRuODJqRG5DTFZtc2x1VWNJMHJzTHNLNzVHamYv?=
 =?utf-8?B?M2tuaVlzemR0bHNSUmxzeENyYW1OVk9mOUdSbUpDclRvZWc3Y0NuRzBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJCVTlzckRTbE9jaEF2VUdFdWZPUm5DdmcxVHVzUEhycGtDMjEzUzRNTG4y?=
 =?utf-8?B?S1Z5UnNlWGgwRTkyU29lelEzQ0s2MEpIdlZiY005VlhBNjIwSUVHVzBJU2Nz?=
 =?utf-8?B?R0lqeW9nZlI4SUpVL1dNR3ErOE1ick9yNGtqME4yM3ZoVytnOEVINjFXbFlF?=
 =?utf-8?B?akJUTHVqS1ZOQTVDVmZZTTFJTDZJMm5TZ3J6dkwwR2FCQ3BtNHhWN3VGNDlE?=
 =?utf-8?B?RzQvdWpIUWMreDdkNm5GUEJlVDNhcStFa1hCYVZmN1FGajlnNHlPRmtXWkJO?=
 =?utf-8?B?ZVRJWCtidWlZdFpxWE1VQndFV2RYNHpaNklnUWNod3UzaEN6Y3NkNlFhbGg5?=
 =?utf-8?B?RHpTbHo0MnV3elhrMmNaVjI3cUVVaGtUWitoYWkwTnlFc1B2TEo2TE05WGNv?=
 =?utf-8?B?ODFER05HYXNpVllhamV1U0t1Z1VPY01PaWFpRVRlYXlkaEovZDU2bnBNRnYv?=
 =?utf-8?B?ZDd5RFd2ZnlDUmdGT20raFBRNjJGZXdqSDZaOEh6YzJJcXJMWXFSdDE1T0Vv?=
 =?utf-8?B?YUovMmhXYzdZbkZnZEpqV2N3Y0NicWJDWjl4cUx2ZG41bVpLNmpScWQxUERW?=
 =?utf-8?B?bW9kd2pZTk9NUkF6NStCUFducDBYYk5rUENDMC9yKy9TZWNQVWJVODdubXB0?=
 =?utf-8?B?UG9zR1R2dGlYUExwbmdWUHViRVVMVlJyQmhvMjkrT1VvMkFuM0twRklwd09L?=
 =?utf-8?B?eENqQVRTYXgrdHd6T2VBN1k0L0lFU2ViaHNRT3VrL2ozQlVDYzh0SVhUcFd1?=
 =?utf-8?B?eVlka21LUS9nYXYyRnRiNFliOExFRExTZ1dZOE1pT0xoR2FWaWZBUW1DcTNM?=
 =?utf-8?B?RFE0Mk1ZMWtTQ293U1JpS1JnUmVxd25RUUtJcWFCT3hDMnQ0aXh2VjRtYTJU?=
 =?utf-8?B?VHZvM1B5YVhuV0hFZVVlR0tNTUhWN3ZoOFU5bFI5Uko5aFlSQmxSQ0Fqa25i?=
 =?utf-8?B?NVNwS05aT01vRjV0NFVoY2ptQkN4TVVkSWU0ellJSEM4V3gvYWl3Q2Q4Vk9D?=
 =?utf-8?B?ZUtlWnNjVkFma3BQYjZvTzFBZmROQ3h4S2lzcW5VQ2FmN2dERDV0ME9VVDdG?=
 =?utf-8?B?dFU3anJpd1ZWWlVsMXJtMTkyWGVuUGhqY3U0UUh0VkNuZEtTNGdVc3NndHkv?=
 =?utf-8?B?WWsxSk9ZVnhhdjkwOC92cEovdXlaZy9kclYyZFlaUnZ1ZTJGVWVTbU9Wb01F?=
 =?utf-8?B?UGRHYWdXU3l4RkVKWGMxQ1hsS2Y4VnRoYXg1QUZIeDhJK01TSDAzd2FwWElC?=
 =?utf-8?B?QkxmbmQzc0wzTENReEZveHUvSlVBQjhZUVRtK0NiUS9wR1ZGSGNyd3pHTzFJ?=
 =?utf-8?B?alVGTCt3Tng3RmhpaVBxVHFlNVFTdUxzTms0OXN6YU5tWDBRZHhKK1VUY2NR?=
 =?utf-8?B?UlJHSnc2cFRodCthL1hwaWk0ZmRtUTN1SWRIWjZFL3RIREREVnRHVG82MzhW?=
 =?utf-8?B?MVFSWlA4d0M1TEVpeTFvcUYxcTd5bVJ5dE8rVmsxekJ0Z05SL3A3SzQ1OHpa?=
 =?utf-8?B?azZFSlFjTGV6SDE2aXdGajhGVUkzdE1sWXpTWk1VUllJU2R2c3luQ096bG1s?=
 =?utf-8?B?bFNrd3k3SWgrYzBjR0ZuYTJKNkp3ZVRObStWS213U0xsRy9RdERVMFdYWUNE?=
 =?utf-8?B?QW9aQXg1aHhFdUdSUDVWeEdXYWNRVHhpUm9JTCsxTjR3cWNmRWlUelZzZWw0?=
 =?utf-8?B?YU0waDRJOWxLOTdFV3NHK2ZLeEcwSmppbysrU3hQWUFrMkhyNHZWUVpLSnlp?=
 =?utf-8?B?bEVnb0sxM2FnUkVKbmVpZ3NuREUzT2ZtUlFTdHFxSXFtY0JEUyszY0tRRkpV?=
 =?utf-8?B?MVYvZzlDTEdia3VQZ1U2VEF2Qm93QXRyTzJiNEZwWXh4Z04rRjJ3NlU5NXg2?=
 =?utf-8?B?aXEyUFdjalBIMnZvNUltWndwUGdLbVNDZEV5S3lOaTJuVVJXMUtBTnBFeXdh?=
 =?utf-8?B?ekZkR2hLOWtpM0pnR3lWZHdOMUUwVG1DMk5OelVZd2hGTWt0MFF4eWkxVjk2?=
 =?utf-8?B?aWN6WUwvbmRMWVZCcWlGLzgyMjBzdENuVTlpdWZqdHN3Mm4zUHBXOWZ0djNo?=
 =?utf-8?B?Tk50Y2QzVE12YTl0bHgrQk1UejVNT2MzemZaMVQza3VWVU94Ly9WU1R2S0NY?=
 =?utf-8?Q?d8qFZrGm+6SIVvKoXIR35/fJe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc86e3ec-59cb-476d-4c6e-08dc84c022ac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:59:53.1730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHMRCvYLPIO34PDgr60qAgOgHSjYFaOYCuYUNBUaO3yskZ87n/KxDNAhmyujMoYD1EEQN9f/3tWXzzKJWXrtBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=dongwon.kim@intel.com;
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

Hi Marc-André,

On 6/4/2024 3:37 AM, Marc-André Lureau wrote:
> Hi
> 
> On Fri, May 31, 2024 at 11:00 PM <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     From: Dongwon Kim <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>
> 
>     This patch series is a replacement of
>     https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html
>     <https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html>
> 
>     There is a need, expressed by several users, to assign ownership of one
>     or more physical monitors/connectors to individual guests. This creates
>     a clear notion of which guest's contents are being displayed on any
>     given
>     monitor. Given that there is always a display server/compositor running
>     on the host, monitor ownership can never truly be transferred to guests.
>     However, the closest approximation is to request the host compositor to
>     fullscreen the guest's windows on individual monitors. This allows for
>     various configurations, such as displaying four different guests'
>     windows
>     on four different monitors, a single guest's windows (or virtual
>     consoles)
>     on four monitors, or any similar combination.
> 
>     This patch series attempts to accomplish this by introducing a new
>     parameter named "connector" to assign monitors to the GFX VCs associated
>     with a guest. If the assigned monitor is not connected, the guest's
>     window
>     will not be displayed, similar to how a host compositor behaves when
>     connectors are not connected. Once the monitor is hot-plugged, the
>     guest's
>     window(s) will be positioned on the assigned monitor.
> 
>     Usage example:
> 
>     -display gtk,gl=on,connectors=DP-1:eDP-1:HDMI-2...
> 
>     In this example, the first graphics virtual console will be placed
>     on the
>     DP-1 display, the second on eDP-1, and the third on HDMI-2.
> 
> 
> Unfortunately, this approach with GTK is doomed. gtk4 dropped the 
> gtk_window_set_position() altogether.

Do you mean we have a plan to lift GTK version in QEMU? Are we going to 
lose all GTK3 specific features?

> 
> It's not even clear how the different monitors/outputs/connectors are 
> actually named, whether they are stable etc (not mentioning the 
> portability).
> 
> Window placement & geometry is a job for the compositor. Can you discuss 
> this issue with GTK devs & the compositor you are targeting?

I guess you are talking about wayland compositor. We are mainly using 
Xorg on the host and this feature works pretty good on it. I am 
wondering if we limit the feature to Xorg case or adding some warning 
messages with error return in case any of parts is not working?
(like the warning message I added

+        model = gdk_monitor_get_model(monitor);
+        if (!model) {
+            g_warning("retrieving connector name using\n"
+                      "gdk_monitor_get_model isn't supported\n"
+                      "please do not use connectors param in\n"
+                      "current environment\n");
+            return -1;
+        }
)

> 
> -- 
> Marc-André Lureau


