Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED52BC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 08:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdRn-0001iu-2O; Wed, 07 Feb 2024 03:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rXdRj-0001i2-Mv
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:38:19 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rXdRh-00013e-CL
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707295097; x=1738831097;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ogVwINedpIxUGAewzgfCvJfEMlOu+AI3grzOHYcSN+k=;
 b=ayQC7/H9+L5MZMOUtjwKnpdeAzptvna78kzHgMTLaDRAgrg+fbFGVJX5
 8HVsR49aZJq4ztT60Mkzc+xBftNzCKZd4mxKwwmDUp7b4CZ0IRdjLrcK2
 LOeqlfhQScVjST4tMqbzR9R6blcPaYNI0avm3+1xTFAJGY5VEZNZn7OHr
 XeBix3MGzCPhJ4HZngSIU2GG1oNZwQnDseLV7Z9GAuDfIL7dudBoqvQ2M
 PP4WwoSvmUAcY6JmhZQ7gKArdzc4OPUReK7wP2HbQyWQWqzx7zAE9/8gG
 VO9ssldlzSptL10nPrk8Mnox9aLZvQN5YkQ1fK4Wxb+NJEdwYxSFXwYkt w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23418651"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; d="scan'208";a="23418651"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2024 00:38:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; d="scan'208";a="32346251"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2024 00:38:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 00:38:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 00:38:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 00:38:05 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 00:38:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heQqw8TLNp16yIgkoW+8BLXkIASk5/+r2257k/GdXIYApghcvNCJAc/opvoXLGgv3vGQtqrEEyUIBMBdtvJWdLUdcSMhScr7Y9iNfRSUryWWgYSI0f0K9yAxH3o2wdPWfQ2HQNv/D4mquSTJrxfb887J5LoG1DIJvR88wD+aTzJKUcvJygmm+B/iAt5Jf6uM9R17fzEoAbA6edZxbRxPvUxtfLpjEzDHNO0L9AaOSaOzr/6oUclTCH5hgUytIL/hSSqehZ6Br7m8O9CSzud7QS3mk7ZbLX+IVJFFtN4EOsTPa3QF6+x27GhKRUQoE8TOP1um5fLscocmotaRsnLwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogVwINedpIxUGAewzgfCvJfEMlOu+AI3grzOHYcSN+k=;
 b=eE0+2+0Xx2NsPC5IftHRahuBAwZLac3p/XquYpzwcrpSvj/k5/s5+edn71Bg2fUzUTLv6tH4aLx6HO5bjDwyWaMZYfqEt29Gh5IkaAwyqtU2/pOOfyjFNWpdSRs0FwRhfuKnYBDrp/tFt1IsoLk9PfTq2MTG2P7EhjNULN2R69O20qNd0YpMB2G4r8uiW//NrpnckR1bAhQ3ldUJ2aQC6fntyxJeh9XHAk2vhUvNkWtqSHLzH7AdeUDdUwsRHTGmlXiB34qt4MPadwJweYdxjSpPYs4j5zCO3/hxXZ4i6RJ8NjYk9/ZlRJyoW0P0ysd5KM/KeoncV0H4nJqN439CAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA3PR11MB7977.namprd11.prod.outlook.com (2603:10b6:806:2f3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 08:38:03 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c%3]) with mapi id 15.20.7249.032; Wed, 7 Feb 2024
 08:38:03 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, Bryan Zhang <bryan.zhang@bytedance.com>,
 "Hao Xiang" <hao.xiang@bytedance.com>
CC: Fabiano Rosas <farosas@suse.de>, QEMU Devel Mailing List
 <qemu-devel@nongnu.org>
Subject: RE: Regarding to the recent Intel IAA/DSA/QAT support on migration
Thread-Topic: Regarding to the recent Intel IAA/DSA/QAT support on migration
Thread-Index: AQHaWZzHFo3cuYXm0kil+nKT19RRrrD+hvoAgAABP3A=
Date: Wed, 7 Feb 2024 08:38:03 +0000
Message-ID: <PH7PR11MB5941E6CB97EA7BA10AAE3C1EA3452@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <ZcM6TIWkyCRsk6wn@x1n> <ZcM68L8PaoD6qtLp@x1n>
In-Reply-To: <ZcM68L8PaoD6qtLp@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA3PR11MB7977:EE_
x-ms-office365-filtering-correlation-id: 25bc4d8d-430c-4a3c-b03d-08dc27b819a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nSD+oQExZ3+5AvyFXy3KDX3JbGQm7jbg4rXcRI+c4a/CwsWuCKCHNYwqpg7REg0+C6jAmMaM2jI4TutZQd1fWeoewnG4uHd4lpBkp4YaOmpORU3KeWkx74YwxRl9SfGgHwCXYTYQyj65NhruME2A/HHnrSH3+vHiIPwfOR8Dx2k6m9VNPdtOSOl2krF+MQ7dYzaJ6wSMSl/rARtVmDnFp5z/+4YYA72XUq1kvG8IsffPmd5bmnJTyUcn4vxrT4ncQo9aXg2HrQJsehd9fpUJNcU516wTZZKf3IXLFtsHUsrzEJ9V5tQSRf/771fod0XV0dDV6WexUzzHO+Y+UtLnpOAu9kLoJFUW/3bCuPq73P91P5sxH5UrP3bs8OXzxPg8kilrbxAB6rxib8mtAp3IaNFYwFwUbjuzU399Tj+mQg3OWphDps6wW77TlNMJBBkq0B1XMmVKEch3Yl5g8rH1/onsnCjY0dgr3MYFFON9oFy3zUDH5SaNfNHKy+aS/To8ES42fKSF6+wNzSiSmKYY/cxgd7qTIfSvkjXvSYvqOi5vL+6TQ5uiUnyJDjdYzakpwfObss/phPzDlxmLvqdr0gDVQSLQeClvusPkwti4YqglueyNxi3OSO2Mb4s5ARcdg+KEY5jzKJ0aOVQao3DoCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(86362001)(64756008)(76116006)(966005)(53546011)(66946007)(66556008)(110136005)(7696005)(6506007)(9686003)(66446008)(54906003)(33656002)(478600001)(71200400001)(66476007)(4326008)(38070700009)(316002)(8936002)(8676002)(82960400001)(38100700002)(122000001)(26005)(83380400001)(5660300002)(52536014)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFhCWXFjOVpYUFdBT3NKbFlJMEV1MTZMRjI4NjJ3b1JFaHNjS0IvdlVmVmlp?=
 =?utf-8?B?dkltMDZuc09wdjlvL1VxZGF3SUJDVU9WaTYwai92ZHJtekFIVHVOSExtZTJG?=
 =?utf-8?B?M0F0VVB3cFFUdk82aGVMT2lsOGpiWHJJOUhXcC93NmdwL1JQeHg3cDNxS1VQ?=
 =?utf-8?B?N1NCZ2Y0VC9ybi9scysvSVFYMW9adTRQNFdHQVBJczh4VGMwb0UvTUhrd1BI?=
 =?utf-8?B?dnN3aVZtOFVkeVk0ZUlpOE83M2tlTWRDK2ZEa1luN0daY05VSGJod3V4Vkgw?=
 =?utf-8?B?dnhybWVxcmF4WCtwODRBQjBNaTk5UGdMODlEdW9HSVc1VjBhTUNqbmxQbFhP?=
 =?utf-8?B?d3l2MkpWS0xsUkx1emhkMXZ4UGtMS1dUT1B4L0tKWWljZWZNa1Y4bWJWNENk?=
 =?utf-8?B?TXpJckw0M09wOW1IUFlaUHBFTkczTDdxRWtndjFyNEZxNTdzWVBjMCtLWXV5?=
 =?utf-8?B?MjFLVXgwdTVSbWNTTFNjRHFGdElHZmwxWFZpL1FhWW5pNkUzbGxrRGlVMFRW?=
 =?utf-8?B?TkJZZXJUWHVkQkdKb1VEMit4aXgvVXU4aW1PS28vUnV3Z1I4di9VNitVcEMw?=
 =?utf-8?B?QmN0WThRRkxDcEszRVAxQ2Q0enVMSmtnYXkxYzdSUzBsai9RU1M0RWsybEZJ?=
 =?utf-8?B?ZW8zaEtPUmZxOS9WbE1aMHpXOTUxd1dHSXFwK0w5SnhFbHZROHJ4VDZqUWF4?=
 =?utf-8?B?Q1NyZWJGdERKbS9XQ2dlbGJwbHgreXpkSTFaMXpiSjVYbTJQMnNjUWZVcXFW?=
 =?utf-8?B?UHdtSUQ2ZDlkTERGYTlJY2ZXVEN5WHZCK2xYc2RXWWdxSnVySXkyS0xYbllX?=
 =?utf-8?B?US9YOVdydlQyeW85WDlMNUNSTlFTM2YyQWdINStBcVlpbUEwVm1VWTAveDF4?=
 =?utf-8?B?SWQ0N29qMkpheUlqdGpRSEVISjJwb1lZZzdpTmxHMXc4VGZNbXJHaW5GRStT?=
 =?utf-8?B?Z1VsOHhlaTQxRmQxRHIzOEFkVEh4WGpzV3Y2cDMveFNDcnJ0VVFxOWVMZ1NR?=
 =?utf-8?B?eUEzd0hnVUhpWHZFYzV0SG44QVlWNDJyYXdJdnhyVzYxcU9kaFRSdEI2QlBM?=
 =?utf-8?B?V2pOc0h1NUxqeC8wWWpDeDRnWnBZWGVudGN5d0daaTM1eEV3ZkRiSHNoQy9a?=
 =?utf-8?B?aWlrVkppTkMxb2xMRzdEZkRNdWxCOTJtbjZrR0ZaaWZXOUNLVmVQbDR6dFRP?=
 =?utf-8?B?WHREMCtFTDNDdVZlbmpaZjhSMUJMWEYyUW4wU2FMSEsxR1JIaVJLalUxSmFn?=
 =?utf-8?B?Mlhod0MzaEJtelYzaGVRcWJtOG92RlpYL2lCZ1BKdjd6VWhXVVBGVjNnMUly?=
 =?utf-8?B?bDgySHhWajZFSW9iRnZrL21FZThFUGVRSE51akhHWXVQTDJGYnVXZWJ3UUMz?=
 =?utf-8?B?NjNRN25NczRISkYyZEZnaDBENWp3YWhCdlZwUUFQNGlQZ1FIS1pwSFZDa1Fw?=
 =?utf-8?B?TnU3RTdaamh0WDF2QkgrU1VtSERRdFZYaDdFYUtoTWh4VTgzMi9RMXZ1aW10?=
 =?utf-8?B?RExKbDlzbVhJelB2QU1HdnVUd0NjdnlhQjFEU1hYemhuelhTRDgxNHJzY3Zr?=
 =?utf-8?B?bTYyVDNlMFdCVzNhVWMyNXM2VWJwbnFEdUl5aGVjYTQ4SndFd2I3Kzc0QThz?=
 =?utf-8?B?Smh6Zmt6TkIwdjZENCtlS2hHcEllNHlIOExRVFNySXFTS2FJWTYyT1B1bTc3?=
 =?utf-8?B?SmpGOEVxa0tZUjZhR001N3lsZ1dBUnJYbGRHNXNocGZBdEpNL3VJUzZmcWpC?=
 =?utf-8?B?cjFQSjhiZzMvU0JTd2JBNDdrU3ViUXl0eGRDQXVNdnpiQnA4TDVEcmwzNEhX?=
 =?utf-8?B?MTREQk1laFJnMXo0UVI5dEpVQmROYnJPaEZVbXB4NnlPSlVNbEppdjh1Q0t5?=
 =?utf-8?B?R1pkRGlPM0lsTFk4VWlVTWNCZmZjazNDRWlWZzloRnBHRC9FTUpTcy9lLzdS?=
 =?utf-8?B?THpWbzc1TXZEWjhyK3llRWw1NUl2Rm1JZVRYQy9zK0grUWRoU2JzSTJ6Mkhw?=
 =?utf-8?B?a3cyUkl0SzlraU1SalErbWJhdWU2RUVhZkFVdVZnMW9EQ21OdG9aSEtYRGR0?=
 =?utf-8?B?aVppZGdmSEt0S3JncWdDQzBOeXNUbXZmR2thQmcySzdReEJQUkhPVEYyNFRH?=
 =?utf-8?Q?jIJ6Idzkrpb38nfJFSkytHN0b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bc4d8d-430c-4a3c-b03d-08dc27b819a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 08:38:03.7539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WIh7NMowUILVFAfGsVU5CgjVr9IMJDP1TEM15oHvc90DIqWOrHHXctf2bHNF2IFdHTqFVVKBmVqsjP6saQYFog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7977
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

VGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciByZW1pbmRlciBhbmQgdGhlIHJhcGlkIHVwZGF0
ZXMgdG8gdGhlDQptdWx0aWZkIGZ1bmN0aW9uLiBJIHdpbGwgaW5jb3Jwb3JhdGUgeW91ciBzdWdn
ZXN0aW9ucyBpbnRvIHRoZSBuZXh0DQp2ZXJzaW9uIChJQUEgQWNjZWxlcmF0ZWQgTGl2ZSBNaWdy
YXRpb24gc29sdXRpb24pLiANCg0KUmVnYXJkaW5nIHRoZSBRQVQgYW5kIERTQSBvcHRpbWl6YXRp
b24sIG15IGNvbGxlYWd1ZXMgYW5kIEkgaGF2ZSANCmFscmVhZHkgc3RhcnRlZCByZXZpZXdpbmcg
YW5kIHRlc3RpbmcgdGhlbSwgYW5kIGl0IHNlZW1zIGxpa2UgYSANCnByb21pc2luZyBvcHRpbWl6
YXRpb24gZGlyZWN0aW9uLiBJIGFtIG1vcmUgdGhhbiB3aWxsaW5nIHRvIGNvbnRyaWJ1dGUgDQpm
dXJ0aGVyIGVmZm9ydHMgdG8gdGhlIGxvbmctdGVybSBtYWludGVuYW5jZSBvZiBJbnRlbCBhY2Nl
bGVyYXRvcnMgaW4gDQpsaXZlIG1pZ3JhdGlvbi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgRmVicnVhcnkgNywgMjAyNCA0OjEwIFBNDQo+IFRvOiBCcnlhbiBaaGFuZyA8YnJ5YW4u
emhhbmdAYnl0ZWRhbmNlLmNvbT47IEhhbyBYaWFuZw0KPiA8aGFvLnhpYW5nQGJ5dGVkYW5jZS5j
b20+OyBMaXUsIFl1YW4xIDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiBDYzogRmFiaWFubyBSb3Nh
cyA8ZmFyb3Nhc0BzdXNlLmRlPjsgUUVNVSBEZXZlbCBNYWlsaW5nIExpc3QgPHFlbXUtDQo+IGRl
dmVsQG5vbmdudS5vcmc+DQo+IFN1YmplY3Q6IFJlZ2FyZGluZyB0byB0aGUgcmVjZW50IEludGVs
IElBQS9EU0EvUUFUIHN1cHBvcnQgb24gbWlncmF0aW9uDQo+IA0KPiBDb3B5IHFlbXUtZGV2ZWwu
DQo+IA0KPiBPbiBXZWQsIEZlYiAwNywgMjAyNCBhdCAwNDowNzo0MFBNICswODAwLCBQZXRlciBY
dSB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+IEknbSBzZW5kaW5nIHRoaXMgZW1haWwganVzdCB0
byBsZWF2ZSBhIGdlbmVyaWMgY29tbWVudCB0byB0aGUgcmVjZW50DQo+ID4gbWlncmF0aW9uIGVm
Zm9ydHMgdG8gZW5hYmxlIHRoZXNlIG5ldyBJbnRlbCB0ZWNobm9sb2dpZXMuDQo+ID4NCj4gPiBU
aGUgcmVsZXZhbnQgcGF0Y2hzZXRzIChsYXRlc3QgdmVyc2lvbiBzbyBmYXIpIHdlJ3JlIGRpc2N1
c3NpbmcgYXJlOg0KPiA+DQo+ID4gICBbUEFUQ0ggdjMgMC80XSBMaXZlIE1pZ3JhdGlvbiBBY2Nl
bGVyYXRpb24gd2l0aCBJQUEgQ29tcHJlc3Npb24NCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyNDAxMDMxMTI4NTEuOTA4MDgyLTEteXVhbjEubGl1QGludGVsLmNvbQ0KPiA+
DQo+ID4gICBbUEFUQ0ggdjMgMDAvMjBdIFVzZSBJbnRlbCBEU0EgYWNjZWxlcmF0b3IgdG8gb2Zm
bG9hZCB6ZXJvIHBhZ2UNCj4gY2hlY2tpbmcgaW4gbXVsdGlmZCBsaXZlIG1pZ3JhdGlvbi4NCj4g
Pg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAxMDQwMDQ0NTIuMzI0MDY4LTEt
aGFvLnhpYW5nQGJ5dGVkYW5jZS4NCj4gPiBjb20NCj4gPg0KPiA+ICAgW1BBVENIIDAvNV0gKioq
IEltcGxlbWVudCB1c2luZyBJbnRlbCBRQVQgdG8gb2ZmbG9hZCBaTElCDQo+ID4NCj4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMxMjMxMjA1ODA0LjIzNjY1MDktMS1icnlhbi56aGFu
Z0BieXRlZGFuDQo+ID4gY2UuY29tDQo+ID4NCj4gPiBJIHdhbnQgdG8gY29tbWVudCBpbiBhIGdl
bmVyaWMgd2F5IHNpbmNlIHRoaXMgc2hvdWxkIGFwcGx5IHRvIGFsbA0KPiA+IHRoZXNlDQo+ID4g
c2VyaWVzOg0KPiA+DQo+ID4gICAtIEEgaGVhZHMtdXAgdGhhdCBtdWx0aWZkIGNvZGUgaXMgcmFw
aWRseSBjaGFuZ2luZyByZWNlbnRseSwgSQ0KPiBhcG9sb2dpemUNCj4gPiAgICAgdGhhdCB5b3Un
bGwgbmVlZCBhIHJlYmFzZS4gIEl0J3MganVzdCB0aGF0IGl0J3MgcHJvYmFibHkgbXVjaCBiZXR0
ZXINCj4gdG8NCj4gPiAgICAgZG8gdGhpcyBiZWZvcmUgYW55dGhpbmcgbGFuZHMgdGhlcmUuDQo+
ID4NCj4gPiAgICAgSUlVQyB0aGUgZ29vZCB0aGluZyBpcyB3ZSBmb3VuZCB0aGF0IHNlbmRfcHJl
cGFyZSgpIGRvZXNuJ3QgbmVlZCB0bw0KPiBiZQ0KPiA+ICAgICBjaGFuZ2VkIHRoYXQgbXVjaCwg
aG93ZXZlciB0aGVyZSdzIHN0aWxsIHNvbWUgY2hhbmdlOyBwbGVhc2UgcmVmZXINCj4gdG8NCj4g
PiAgICAgdGhlIG5ldyBjb2RlIChJJ2xsIHByZXBhcmUgYSBwdWxsIHRvbW9ycm93IHRvIGluY2x1
ZGUgbW9zdCBvZiB0aGUNCj4gPiAgICAgY2hhbmdlcywgYW5kIHdlIHNob3VsZCBoYXZlIGEgbWFq
b3IgdGhyZWFkIHJhY2UgZml4ZWQgdG9vIHdpdGgNCj4gRmFiaWFubw0KPiA+ICAgICAmIEF2aWhh
aSdzIGhlbHApLiBJIGhvcGUgdGhpcyB3aWxsIGFsc28gcHJvdmlkZSBzb21lIGtpbmQgb2YNCj4g
aXNvbGF0aW9uDQo+ID4gICAgIHRvIGUuZy4gb3RoZXIgd29ya3MgdGhhdCBtYXkgdG91Y2ggb3Ro
ZXIgYXJlYXMuICBFLmcuLCBJIGhvcGUgZml4ZWQtDQo+IHJhbQ0KPiA+ICAgICB3b24ndCBuZWVk
IHRvIGNvbmZsaWN0IG11Y2ggd2l0aCBhbnkgb2YgdGhlIGFib3ZlIHNlcmllcyBub3cuDQo+ID4N
Cj4gPiAgIC0gV2hlbiBwb3N0aW5nIHRoZSBuZXcgcGF0Y2hzZXQgKGlmIHRoZXJlIGlzIGEgcGxh
bi4uKSwgcGxlYXNlIG1ha2UNCj4gc3VyZQ0KPiA+ICAgICB3ZSBoYXZlOg0KPiA+DQo+ID4gICAg
IC0gUHJvcGVyIHVuaXQgdGVzdHMgZm9yIHRoZSBuZXcgY29kZSAocHJvYmFibHkgbW9zdGx5IHNv
ZnR3YXJlDQo+ID4gICAgICAgZmFsbGJhY2tzIHRvIGJlIHRlc3RlZCBvbiB0aGUgbmV3IGxpYnJh
cmllcyBiZWluZyBpbnRyb2R1Y2VkOyBqdXN0DQo+IHRvDQo+ID4gICAgICAgbWFrZSBzdXJlIHRo
ZSBuZXcgbGlicmFyeSBjb2RlIHBhdGhzIGNhbiBnZXQgc29tZSB0b3J0dXJlIHBsZWFzZSkuDQo+
ID4NCj4gPiAgICAgLSBQcm9wZXIgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIG5ldyBjb2RlLiAgUGxl
YXNlIGZlZWwgZnJlZSB0byBzdGFydA0KPiA+ICAgICAgIGNyZWF0aW5nIHlvdXIgb3duIC5yc3Qg
ZmlsZSB1bmRlciBkb2NzL2RldmVsL21pZ3JhdGlvbi8sIHdlIGNhbg0KPiB0cnkNCj4gPiAgICAg
ICB0byBtZXJnZSB0aGVtIGxhdGVyLiAgSXQgc2hvdWxkIGhlbHAgYXZvaWQgY29uZmxpY3Rpb25z
LiAgUGxlYXNlDQo+IGFsc28NCj4gPiAgICAgICBsaW5rIHRoZSBuZXcgZmlsZSBpbnRvIGluZGV4
LnJzdCB0aGVyZS4NCj4gPg0KPiA+ICAgICAgIElNSE8gdGhlIGRvY3VtZW50IGNhbiBjb250YWlu
IG1hbnkgdGhpbmdzLCB0aGUgaW1wb3J0YW50IG9uZXMNCj4gY291bGQNCj4gPiAgICAgICBzdGFy
dCBmcm9tOiB3aG8gc2hvdWxkIGVuYWJsZSBzdWNoIGZlYXR1cmU7IHdoYXQgb25lIGNhbiBnZXQg
ZnJvbQ0KPiA+ICAgICAgIGhhdmluZyBpdCBlbmFibGVkOyB3aGF0IGlzIHRoZSBIVyByZXF1aXJl
bWVudCB0byBlbmFibGUgaXQ7IGhvdw0KPiA+ICAgICAgIHNob3VsZCBvbmUgdHVuZSB0aGUgbmV3
IHBhcmFtZXRlcnMsIGFuZCBzbyBvbi4uLiBzb21lIGxpbmtzIHRvIHRoZQ0KPiA+ICAgICAgIHRl
Y2hub2xvZ3kgYmVoaW5kcyBpdCB3b3VsZCBiZSBuaWNlIHRvbyB0byBiZSByZWZlcmVuY2VkLg0K
PiA+DQo+ID4gICAgIC0gVHJ5IHRvIGFkZCBuZXcgY29kZSAoZXNwZWNpYWxseSBIVy9saWJyYXJ5
IGJhc2VkKSBpbnRvIG5ldyBmaWxlLg0KPiA+ICAgICAgIEkgc2VlIHRoYXQgUVBMICYgUUFUIGFs
cmVhZHkgcHJvcG9zZWQgaXRzIG93biBmaWxlcyAobXVsdGlmZC0NCj4gcHFsLmMsDQo+ID4gICAg
ICAgbXVsdGlmZC1xYXR6aXAuYykgd2hpY2ggaXMgZ3JlYXQuDQo+ID4NCj4gPiAgICAgICBYaWFu
ZywgcGxlYXNlIGFsc28gY29uc2lkZXIgZG9pbmcgc28gZm9yIHRoZSBEU0EgYmFzZWQgemVybyBw
YWdlDQo+ID4gICAgICAgZGV0ZWN0aW9uLiAgSXQgY2FuIGJlIGNhbGxlZCBtdWx0aWZkLXplcm8t
cGFnZS5jLCBmb3IgZXhhbXBsZSwgYW5kDQo+ID4gICAgICAgeW91IGNhbiBjcmVhdGUgaXQgd2hl
biB3b3JraW5nIG9uIHRoZQ0KPiA+ICAgICAgIG9mZmxvYWQtemVyby1wYWdlLWRldGVjdC10by1t
dWx0aWZkIHBhdGNoc2V0IGFscmVhZHkuDQo+ID4NCj4gPiAgICAgLSBQbGVhc2UgcHJvdmlkZSBz
b21lb25lIHdobyBjYW4gcG90ZW50aWFsbHkgbWFpbnRhaW4gdGhpcyBjb2RlIGlmDQo+IGV2ZXIN
Cj4gPiAgICAgICBwb3NzaWJsZS4gIFB1c2hpbmcgdGhlc2UgY29kZSB1cHN0cmVhbSBpcyBncmVh
dCwgYnV0IG1haW50YWluaW5nDQo+IHdpbGwNCj4gPiAgICAgICBhbHNvIHRha2UgZWZmb3J0LiAg
SXQgbWlnaHQgYmUgaW1wcmFjdGljYWwgdGhpcyBrZWVwcyBncm93aW5nIGZvcg0KPiA+ICAgICAg
IG1pZ3JhdGlvbiBtYWludGFpbmVycyAoY3VycmVudGx5IEZhYmlhbm8gYW5kIG15c2VsZiksIHNv
IHdlIG1heQ0KPiBsaWtlDQo+ID4gICAgICAgdG8gaGF2ZSBwZW9wbGUgY292ZXJpbmcgdGhlc2Ug
YXJlYXMsIGVzcGVjaWFsbHkgd2hlbiB0aGUgbmV3IGNvZGVzDQo+ID4gICAgICAgYXJlIG5vdCBk
aXJlY3RseSByZWxldmFudCB0byBtaWdyYXRpb24gZnJhbWV3b3JrLg0KPiA+DQo+ID4gICAgICAg
SSdkIHN1Z2dlc3QgZm9yIGVhY2ggb2YgdGhlIHByb2plY3Qgd2UgY2FuIGFkZCBhbiBlbnRyeSBp
bg0KPiA+ICAgICAgIE1BSU5UQUlORVJTIGJlbG93ICJNaWdyYXRpb24iIHNlY3Rpb24sIGFkZGlu
ZyByZWxldmFudCBmaWxlcyAoYW5kDQo+ID4gICAgICAgdGhlc2UgZmlsZXMgc2hvdWxkIGV4aXN0
IGluIGJvdGggdGhlIG5ldyBzZWN0aW9uIGFuZCAiTWlncmF0aW9uIikuDQo+IEkNCj4gPiAgICAg
ICBhbSBub3Qgc3VyZSB3aGV0aGVyIEJ5dGVkYW5jZSB3b3VsZCBiZSBhYmxlIHRvIGNvdmVyIHRo
aXMsIG9yIHdlDQo+ID4gICAgICAgc2hvdWxkIHRyeSB0byBmaW5kIHNvbWVvbmUgZnJvbSBJbnRl
bD8gIElmIHlvdSdyZSB3aWxsaW5nIHRvIGFkZA0KPiA+ICAgICAgIHlvdXJzZWxmIHRvIG1haW50
YWluIHN1Y2ggY29kZXMsIHBsZWFzZSBhdHRhY2ggdGhlIG1haW50YWluZXJzDQo+IGZpbGUNCj4g
PiAgICAgICBjaGFuZ2UgdG9nZXRoZXIgd2l0aCB0aGUgc2VyaWVzLiAgSXQgd2lsbCBiZSB2ZXJ5
IG11Y2gNCj4gYXBwcmVjaWF0ZWQuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4NCj4gPiAtLQ0KPiA+
IFBldGVyIFh1DQo+IA0KPiAtLQ0KPiBQZXRlciBYdQ0KDQo=

