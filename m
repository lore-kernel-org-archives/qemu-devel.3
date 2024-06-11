Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E40C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 18:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH6EK-0000tP-07; Tue, 11 Jun 2024 14:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sH6EH-0000sg-Ps
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 14:28:21 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sH6EE-0002lT-Qr
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 14:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718130499; x=1749666499;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KK2pD4CD504YSSSn2jR66xsntrtbekbMXvUrviIBoL0=;
 b=GmjI3xSLN9gOkaWaGotcG17WpbdmK2365hJ9hFwHjxDCqd6yDjeI2x8R
 FVLcPPPwTbUWTN342SykbR7wMXxm/lrZjwmiyaP6ey3izxGyNXJQPKFIj
 rag1xDUzgisRm4Pq3C8NVlYWlg4CWST3RbzoUmqTN+XTK1qCz6RXXlism
 eGaDEymOIo0V1R/eFxKrwFIw/5owNodE2flv/VaXoUbQ37Mltgzc1kRhl
 SgYCL4xDmaVbILfB2JqRmrSd3aACE9lT0jvLpwOXL9gEwIv4cUriVKNf2
 xoongVwl0b2SvkCNMjpVeqo/nY6NfhZTOi+cNSGfm8cU91NNHi3SV1eyx Q==;
X-CSE-ConnectionGUID: oI9UEfmDQCCNeGmVzkW9lg==
X-CSE-MsgGUID: a4ttfLWzRU2y/OaCqXLvmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15031208"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; d="scan'208";a="15031208"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 11:28:14 -0700
X-CSE-ConnectionGUID: N7UpTJ4qQkuPKG6oCeGh3g==
X-CSE-MsgGUID: rpmgQXgASA6IDdUTvQXsMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; d="scan'208";a="39452089"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jun 2024 11:28:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 11:28:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 11:28:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 11:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGM2/CkT/Z4/OdeZYgNs7Wy/SbpLmMJqXWHuCXMtOcoc1uBgClakAHYwTshbmur09A3S7ldIqA2Lek6+3gmu395Mj87BciIDjnwEpskg05+V3P4UoHEFC8zWZxiS5zsR7BaIV8CaDNCUuvjroGGQ+1FsjZtzxmL7HO+Gn0oUXF2pcQeJfd87qmRpEnecpV78wVISXsADKA7RhPdyyyVJ4cp3lg0z4yCMeTevzhBCs7Gz8D20dDoCIHIdlTh6IinOnXjY21LH0sQgVms+WBg74yju4MlIhhssl8N1Zz1Sykm6EdGChfUX6MU99w6zIFsbfw8ove2YUn17Mbugl78dBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXdRMeA7qop4oh+NroNHMQjrmPsf+Ygfh6rF3RiVEe8=;
 b=kvsuOIdcHSHJmbuOjYAOaklTJ3J2jzG+ergq5s3qJxwYhmv3mtxDBiyizTH31yPQEbUYxpGWMQ36xwqLs2fspFAjTeBTCZSwQ2JV6IzyBHD9xZHqovDabBTfRMDZjLGmVEPv8G/PWdZ4Yr6i8lUJ6Q4+MW10/6r7q2Zc7Bh1t9LOgYam+cIsUGiQ3HOcKzPIunwNdVXgyINH22IOMHFQ5p0NIeAQn7aEYUpArKaYYlL+8F0djVBEbXLM7x8CA2kgeWH3zzRUShyUuuBNcXGJny3/T9IlPIKNGdjSlVupwKCf4t5apP/dbsQTHlhGAUcm0eopoGW4w37jonmKqr04CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by PH7PR11MB6724.namprd11.prod.outlook.com (2603:10b6:510:1b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:28:09 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 18:28:06 +0000
Message-ID: <fa43009f-1292-49f5-bab0-618028c16045@intel.com>
Date: Tue, 11 Jun 2024 11:28:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>
References: <20240531185804.119557-1-dongwon.kim@intel.com>
 <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
 <a89b283a-24e3-4117-b465-ab8d79252625@intel.com>
 <CAJ+F1CJ-4cWV81_YTit5jTEoY6FPTeu7u177pZzb61FhXw_j0Q@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1CJ-4cWV81_YTit5jTEoY6FPTeu7u177pZzb61FhXw_j0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|PH7PR11MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f555d2f-14e6-4bc5-d1c7-08dc8a443cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qk9UMG5wU0RTaWpwbnRoSXNWay8xbms1SGJtWHI5WTZadlVZTHRLblk4K2tU?=
 =?utf-8?B?ZXU1bTVCSm1aeWFnV3gvbFJwSnNaTFJnTEh1ZExuc09xWkl5Q0diRU1ZajJK?=
 =?utf-8?B?N3NDVUtEbW9yWC9CNkJZdjRWN1ZBaE1JeUQ0eU9PM0Nya0N1Nm50a2VkQzdN?=
 =?utf-8?B?RGE5bmhERFZzRUgxMCtCMVRVSkRGOHlXY05HZ1BCZ1Q0SFlIdmtxcS9OQ1Q5?=
 =?utf-8?B?TE8ydWpoN0NncGc5cEFEeW55V25ySXdmb1RGN2luLzl5RVNYMEtOS0FOUWM2?=
 =?utf-8?B?clZDZlJBYlRwYTl0Q3VWM0VsdFV5eGlCOW5yTlU0V3hGMktWOUJpYXhYSEY5?=
 =?utf-8?B?Z1ZPSWNMRkxlaEt5b3Z5N21CSncvYkZkdE9JMzFPUmxZYTdyK3hETEh4aHFV?=
 =?utf-8?B?VjBvdURxczVXVjZtL1kvMGdzUlZ2Q2VHVEFXMTJEYmUyLzVDTVZlRklvQU9E?=
 =?utf-8?B?cWJlSHYwYm1CUjA2N1Faeld4TmxsN3kwRkVUNC8zbTFBWlZodll0dFpoRzcy?=
 =?utf-8?B?UFFKMDhuMWZEQUtzODlVK1N1a0pYNHBLUWV0RmlleUtQMUVpS2xjTEQ0VDZi?=
 =?utf-8?B?S25LUDdXNUFkaGYwV2t6RzM4Z1RnKzZJcVlCcjRhM3VEeVRTZ0xKdmF4N211?=
 =?utf-8?B?NHNIZjBPRmI2ZzhqRE8vRzZ0SlR5M3lqSjVyQnRBTWRlWGdsWFoxMnJmQk5t?=
 =?utf-8?B?K2Q3M1ZXNUN1Mm1NWEJ3MGVkRVo2c2RSZGpxZlJoSUU0VUdsQWIvb3ZnSUZ0?=
 =?utf-8?B?bVhvazhJU0JUT1JYWWVlSUU5ODhTMVlONU9KZ3JKY3hZQXhvcmZHZkVLMHdY?=
 =?utf-8?B?Y2xFQ2FYWVd0UWN4VTM0TjZiMk5FVFN5U0ZacE12TWN5YUN4endGQmNXNG4x?=
 =?utf-8?B?aGJPN0xZa0lpK2lKU1RRRUEzclpaQW5xdmJRVkIyWVAvRlpVbGFCUUlUNTcr?=
 =?utf-8?B?ZlpJeUE4bzdVeVg5a3BnL2NJZVpMcms1ZXR5bmRxRFZZemNBYUVqeUdiN3Q3?=
 =?utf-8?B?Y1B4dEEwNEJNaS8zUlJla1FQTkc1ay92b0N3R2FIM1lpeTRJZzdzM01PQlhI?=
 =?utf-8?B?Q3JRcDJhVG5XZDhQT2RiMVpBSDA2c1gyYWlvQUtCOGMyTW4zdGM4dzJRekQx?=
 =?utf-8?B?VkNmRDZDVkFndmJYaUFiVXFPMnpiYVRSdloyejBVMHJBdnVIWHd1bFBuZkkx?=
 =?utf-8?B?bDU0L3I3ZThGWFBkTTFrOGFiTE5kVE84YklEU1hPRXU1TUVlRGJnaWtaUGVz?=
 =?utf-8?B?UUxBZ0ozVnYrTFRsRzBFMVJGbzBSY0ZuTGl2MjEvblZSQ25mZzhoRE9FVWlX?=
 =?utf-8?B?RnhPbldZbkpYaEF3OEFzd1RPS2dWeWJYWnk5b1laTzdOWFlnbEQ5Rm5WTit0?=
 =?utf-8?B?TWZvWWQ2KzFJajR2aDFEZmh0UzZiVVZxT3hXQmtYZUpYSVNTYm1maGdxSzVq?=
 =?utf-8?B?VkErLzc4VHBTajZRcktNMUJRbFZlWU5GWW0rbVd0WGNzcWVOblV1MHhkaHRN?=
 =?utf-8?B?Q3pXcDJFV05ZZm1USjZ0eXQrajNKUUJZMDQvc3N3bEtINmpoeVV3emY0eUtE?=
 =?utf-8?B?UE91eTlkWjk3QkE4NGVaVmJvd3EydldvTjVMSnlkOWdqeVo2dnpxcTloUDl6?=
 =?utf-8?B?cTE0TTZ3Y1ZQZkE2eHRkdUpNc0IyYmtzekcyQzRXSGF5am1GUUhxVEFJb2dn?=
 =?utf-8?B?Z0hzZzgyekxNajljcEYrWEJRMWxSejE1WmszUWE5bDhDTDJ1eDZxMnZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230032)(376006)(366008)(1800799016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0FwRjAxZktEV1Z2Y0FFUCtGL3QwWm51Q3hWQkJlWUgzY2YySFlyZkNjNEJm?=
 =?utf-8?B?NC93TVFEMVFKRlJESndUdzdsWnFEc2pSMnFqOWhKMmxpeWljL2xRSlZGZ1pQ?=
 =?utf-8?B?YXlzaEFzTVVySUpMOTlBTUtwb2MwRXIyM0hxc3FIK0l3WEJRa2tIN2FxVzRu?=
 =?utf-8?B?dmFEblNhblQzUVk5NmhKTlkxT2kyKzJXNTFuODNyaHcrK1V3UEsrVzZEeEVi?=
 =?utf-8?B?K0hNcTJoVTREUXF2aWFYT2kzNTJ4dUVwQ0ZqZWhrTDg4dFJNVUlLVC9hVFYw?=
 =?utf-8?B?d05wcjBmTWhqK3hlTlc2QkJRaDIvSGxEWHQ5ZWtCd2lwcEJ2emQ5dlpQaUxP?=
 =?utf-8?B?U1A3ZDNPenVQZGNUMjR1d0VVMkMrcFNpdVk4Y3pEbFFvS0xPSVpqalNYSTdi?=
 =?utf-8?B?RUtzSTNzamlrZTJYVTFiNGxxN2ErZFlvZnEzKzhFTU40NklMc1dXWENvdTFX?=
 =?utf-8?B?TjFuU2Vrc2d0ZWdZWHQ1NmI5UlE3aStTaENCTW8rWU9SMFNjYlQ3ODN6ZUs3?=
 =?utf-8?B?eXhxdFo3dnhpNmkxa0FaejBaYlhxSWUyaUg3VXNDTHdiWkE2Y0lKRWxucFRl?=
 =?utf-8?B?WFBFQy9YM05CVmJDaUtsaE94RitqNklUMHNhR29pNzVvQ1FUajRTdEtZUENL?=
 =?utf-8?B?RTREN1R4eFRWa0tPTDRmNjdpaFBpUHhQckg3REh4d2I3b2ZzaWRyOUxPUG5O?=
 =?utf-8?B?eTVxQWp1OE1BMjE4UGRNaE5wb1JobDUzSTRyYWg4Zk1kbXord1ppS2hLb3d1?=
 =?utf-8?B?MzFUOUVPRGlOU2NLTHVDUGUyQ3I5ZU5DSXM2SzQxN2dkUmJzYU5TUnkzOUh4?=
 =?utf-8?B?K0ljMVpVd2ZXbSs1UkV3VlplV3RJMDUyRGdMRWxlakpLams2QmIxWHBwaXN0?=
 =?utf-8?B?WXJ5eXNmc3htbkpkM0lONXpiRzRKc1p4RkUyT3Y1VmNrV1ovUFRVcUxQaWRl?=
 =?utf-8?B?NnVBcmtkbmlOa1d1UUNRTDIrS1NBc05BNGRiVVZQOXNjWkFWZmdmZi9GZWJw?=
 =?utf-8?B?YXZzdXpIM0lyaFNMQWdhMVp5KzZ5eE8ralhCcnZqdGxQOXlZcjFMUWZTbmxa?=
 =?utf-8?B?RmtncVpRM200d3ZtdWUyYU96bXBFaU0vRjJGbDl6eUpZUHVvTTFzOWJ6TE5a?=
 =?utf-8?B?Qzd3U1pXckcvVWo1dE5YSGlVNjNlaHpUczAwZzRTTEo5ZDRTL2Z2Tk8yTDlQ?=
 =?utf-8?B?dk5MaWM0K2h1MjVOZXRRc2ZZREo4WGdRZnBxR1NQQzh2NXR5bXc3U1Qzdk54?=
 =?utf-8?B?d3R3eG5hS2tpRUJqM0xiWmxEYlUxREZMS2ZUVkgvQkd6UUVVdjFSdzZiUjhr?=
 =?utf-8?B?NlZUR3NuNnkvNWRDSzJEUG8xNk5HQmlPbHZ5bEtzNzdxWTdacTVpTlN4ZWtD?=
 =?utf-8?B?RmZsZzE4YzhvazFTVWdhaE03V2FyQ000VmNEMFJ2ZDUzRFdIeElpWTJ4ZHd3?=
 =?utf-8?B?KzB2allwWUoyM1dOTDlta3ZYa2JzbWVRN1hxemxzbXRLRkh1NnVienFndGNz?=
 =?utf-8?B?YVQ2NHBibEZwS3o3Ukk2dWpySnZzRDR1QjZJbHBRVVp2N05KWGlrdkJna3hT?=
 =?utf-8?B?bGYxd0ZDN1NxQitlWGk2dGt4WDdmVnJFTmNqdzVJTys0Yi9MUFRUNzMrM092?=
 =?utf-8?B?dWdremoyMnNkcEF2a3lPZnRXakhlRVpOWk5wTlNJemxiV0tUaHA3WUJWNkFH?=
 =?utf-8?B?czFjbDFLQVJRQWVkNkl2QzJNWUthNFgyWXBQZ1RRNjRJUDQxRnhyQ2NBODJX?=
 =?utf-8?B?UWFyQjBiM0YxZjhNNGJHRDdUZ3lEOU51UG5GanZMRXZDckZLVjdsaHZ1L0s4?=
 =?utf-8?B?RUFteGRZV0RsM0pHNkROL05ha3Y3b2tqU3hXdSt6SHFxeVprenhnQzNYUGNi?=
 =?utf-8?B?SHVmOTA5Q1ppa1ZOY3BmK2EzVFhScEVJR1Qzcjg5NDdMa3ZCdGZkZDIwcUhr?=
 =?utf-8?B?TmU3aHJDdzdjeTlaRU9mSmlsQ29jZXFZL3cyZk5LZFI2RVdhb2lCREFUREZr?=
 =?utf-8?B?WUwzZlRGN28waVE5MlFGU1dlRkxMN2lMT1hwdld2bWpZai9nZytaanBWMUVS?=
 =?utf-8?B?c2VHMXpHTTAyUWRvL3E2TS81M24yYlZkNlloVnd1eUZ3Z0VGZWliZnFPTWJO?=
 =?utf-8?Q?PlBShR3Rv740beSXsjvz1YOX3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f555d2f-14e6-4bc5-d1c7-08dc8a443cde
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:28:06.4727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlJWUisQy6WxSPr5ZWW3xQCuEj7YZKu2a10Q1OshSoq4TXtTynhs0S83xZvFJIYLIoB6q/n91R7WiVBX9bh7Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6724
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On 6/5/2024 12:26 AM, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jun 4, 2024 at 9:59 PM Kim, Dongwon <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     Hi Marc-André,
> 
>     On 6/4/2024 3:37 AM, Marc-André Lureau wrote:
>      > Hi
>      >
>      > On Fri, May 31, 2024 at 11:00 PM <dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>
>      > <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>> wrote:
>      >
>      >     From: Dongwon Kim <dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com> <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>>
>      >
>      >     This patch series is a replacement of
>      >
>     https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html
>     <https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html>
>      >   
>       <https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html <https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html>>
>      >
>      >     There is a need, expressed by several users, to assign
>     ownership of one
>      >     or more physical monitors/connectors to individual guests.
>     This creates
>      >     a clear notion of which guest's contents are being displayed
>     on any
>      >     given
>      >     monitor. Given that there is always a display
>     server/compositor running
>      >     on the host, monitor ownership can never truly be transferred
>     to guests.
>      >     However, the closest approximation is to request the host
>     compositor to
>      >     fullscreen the guest's windows on individual monitors. This
>     allows for
>      >     various configurations, such as displaying four different guests'
>      >     windows
>      >     on four different monitors, a single guest's windows (or virtual
>      >     consoles)
>      >     on four monitors, or any similar combination.
>      >
>      >     This patch series attempts to accomplish this by introducing
>     a new
>      >     parameter named "connector" to assign monitors to the GFX VCs
>     associated
>      >     with a guest. If the assigned monitor is not connected, the
>     guest's
>      >     window
>      >     will not be displayed, similar to how a host compositor
>     behaves when
>      >     connectors are not connected. Once the monitor is
>     hot-plugged, the
>      >     guest's
>      >     window(s) will be positioned on the assigned monitor.
>      >
>      >     Usage example:
>      >
>      >     -display gtk,gl=on,connectors=DP-1:eDP-1:HDMI-2...
>      >
>      >     In this example, the first graphics virtual console will be
>     placed
>      >     on the
>      >     DP-1 display, the second on eDP-1, and the third on HDMI-2.
>      >
>      >
>      > Unfortunately, this approach with GTK is doomed. gtk4 dropped the
>      > gtk_window_set_position() altogether.
> 
>     Do you mean we have a plan to lift GTK version in QEMU? Are we going to
>     lose all GTK3 specific features?
> 
> 
> No concrete plan, no. But eventually GTK3 will go away some day.

There are users who still rely on features provided by GTK3 and we also 
have customers who are moving from VMware, virtualbox that have 
requested for this feature. Their use-cases are current and active. If 
windows repositioning won't be supported someday, then we would need to 
make this feature obsolete but many users/customers would benefit from 
it until then.

> 
> fwiw, I wish QEMU wouldn't have N built-in UIs/Spice/VNC, but different 
> projects elsewhere using -display dbus. There is 
> https://gitlab.gnome.org/GNOME/libmks 
> <https://gitlab.gnome.org/GNOME/libmks> or 
> https://gitlab.com/marcandre.lureau/qemu-display 
> <https://gitlab.com/marcandre.lureau/qemu-display> gtk4 efforts.

As you know, there cannot be a one size fits all solution that would 
work for all the users, which is probably why there are many Qemu UIs.

> 
> 
>      >
>      > It's not even clear how the different monitors/outputs/connectors
>     are
>      > actually named, whether they are stable etc (not mentioning the
>      > portability).
>      >
>      > Window placement & geometry is a job for the compositor. Can you
>     discuss
>      > this issue with GTK devs & the compositor you are targeting?
> 
>     I guess you are talking about wayland compositor. We are mainly using
>     Xorg on the host and this feature works pretty good on it. I am
> 
> 
> Xorg may not be going away soon, but it's used less and less. As one of 
> the developers, I am no longer running/testing it for a long time. I 
> wish we would just drop its support tbh.

There are features offered by Xorg that are not offered by Wayland 
compositors and again, we have customers that rely on these features.
One of them is the ability to position the window via 
gtk_window_set_position(). There are strong arguments
made on either side when it comes to window positioning:
https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/247

Until there is a way to do this with Wayland compositors, we have to 
unfortunately rely on Gnome + Xorg.

> 
>     wondering if we limit the feature to Xorg case or adding some warning
>     messages with error return in case any of parts is not working?
>     (like the warning message I added
> 
>     +        model = gdk_monitor_get_model(monitor);
>     +        if (!model) {
>     +            g_warning("retrieving connector name using\n"
>     +                      "gdk_monitor_get_model isn't supported\n"
>     +                      "please do not use connectors param in\n"
>     +                      "current environment\n");
>     +            return -1;
>     +        }
>     )
> 
> 
> Is it really worth maintaining this upstream if we know it will only 
> work for a diminishing fraction of users?

As mentioned above, we are going to have maintain it for the 
customers/users who have use-cases that rely on this.

> 
> 
> 
> -- 
> Marc-André Lureau


