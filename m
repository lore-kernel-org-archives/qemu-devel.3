Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673D3C25B7D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 03:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQrP-0008On-VR; Sun, 26 May 2024 23:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBQrM-0008OL-LX
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:17:16 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBQrK-0004oB-LQ
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716779834; x=1748315834;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8RBdkO2zTb1qbbZ0RhujYo5EUHIwW+AGe8bDTgO5rJI=;
 b=W19EI29gjhaqPf5BSMqc+5bwLm+Eif83ju+1jNQPIcV10XYswNAh1ssF
 YMbTdeRiW+t9lOpuknK7sL6D6MKDM+AT7cNrAgXmYjclr1se9v6+u4U+o
 dPFjYDY7bsCpJY4l+Ka6Ek7566A93wjQLly09ZNwPeBNc/siH6CEDs85N
 r1ZAHuEIjQou9IxAKRUebXxACtyvQ1HYlEzj+ZotdiBnVw5pBIaxz8X0O
 BWX+EsBbVErhmVe58BqN6O+Yt5tYIRayXT4pClgv6Fy3v4Vws1nAyNtJx
 k0jVd40CmfdreH7mDND7AM+vMsAEW+uUb9NdF5U8q24DCQQZ/zx6pkvuM g==;
X-CSE-ConnectionGUID: FJTFRZYUQjmSmzE7j+xuaw==
X-CSE-MsgGUID: pTAsZD8JTA2lTV4IObx0ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="38462901"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="38462901"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2024 20:17:11 -0700
X-CSE-ConnectionGUID: Lzw5ebdTSx+6ihwT18FuyA==
X-CSE-MsgGUID: 1Gz5p9p3R8+wXr6D5fA1Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="35113130"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 May 2024 20:17:11 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 20:17:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 20:17:10 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 20:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFewkf/2vZDRUwLxvJL/XaTpJpjYUSBvCDK1fBg6xbPEBZP6F1D9gDoEOVeQQOQ5JkNGp9z6sK+QOiJJW4WlstYum8XodDLdpP33vS5NN5iqELwx2d//+JAp4DycW9yazOkn4JjZ0hfu2ZrFjSlSiRHquOUoAomFqlyc3t0xulIpa/e5OKtEw9BR6BvlxtkxKtD23Aph7zSHxbsZDgmXWVHLWyHFv3RwEqYuILkF8xNq2OK1kVesx9I18PbbL9IM1q4KdSW/89WojaDL0bIJlhkAP0RKyZ1MEl7LZnoiEZcodoWwQlPwEKKU02N0vKuhLNJTmyB+8Fnnxczon8tcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RBdkO2zTb1qbbZ0RhujYo5EUHIwW+AGe8bDTgO5rJI=;
 b=eXfIkEUOFgVjjQn4bJCsVx2WJIY3X1USuolLZ3hRCJ8RytbNijw/08t77AuAPrJSpNEpQmQDhZy1o7Y77b/2Cw2r4d8TFvImlF4XQPeaMOtXp2jIUO23DQZS5eX/ggSqwM900j8SZ7lUi+2x3N8FFQlHOAsUMjU5hUW5ctqsQrq1PoOT8AzJLB6cDilXWL0P4VV6qjmRsGhcOVl2yzOTfCn986DLDDeNAZrKWGelWDnNbFvAFNY0lqit5NNqwav7xaVgtP0dXPuO7e4B9sSlN6x2gziHifLkflO3L1eAl64rWmkm1osyanVxmb4ngq48xnCtztOK8n8EFrIYIWo5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 03:17:07 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 03:17:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv2 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
Thread-Topic: [PATCH rfcv2 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
Thread-Index: AQHarBEDuBuzKYLho0Gx1ZQOY5AqCrGmbGsAgAPs46A=
Date: Mon, 27 May 2024 03:17:07 +0000
Message-ID: <SJ0PR11MB6744E7238878707F3ECE885492F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
 <20240522062313.453317-10-zhenzhong.duan@intel.com>
 <086629c8-9d19-41d7-9f1a-d62a9ecb071e@eviden.com>
In-Reply-To: <086629c8-9d19-41d7-9f1a-d62a9ecb071e@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6754:EE_
x-ms-office365-filtering-correlation-id: 8bb7129f-11b5-4cc9-ed4b-08dc7dfb7d76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?QWpaaGxMcE15RzRNY1BuTGtDVmx5TndUbnNOaXdjSDFrRk1EUEhSRGFXejJM?=
 =?utf-8?B?QjE2NFhTaWZKa1E3U2c2cm05MWxObmtoUVplY3JjMFJrTjVrNDc4ZXlaNXpt?=
 =?utf-8?B?TXRaRlJWK2Zoc3dsTURVUUFjK0VTNk9OQnFHQWhDRXdLdGprV29NK01xVFFs?=
 =?utf-8?B?bTd1OUlSU1VyMVFBRThIK2U2aTloQkk0b2lrNFZSUk1HVllRcUlFZVhsdVVO?=
 =?utf-8?B?RzFhTHh4M0M3VjJadEhkZ2YrMGhyQU13b0hqRndOTTFqVUlUZ2NMQm5XeWFD?=
 =?utf-8?B?Wkw0YkR4dVZ2WFh4ckliaUx6QkFtVmo0YjROazY0MVNzNzRsZkp6ek85dlQy?=
 =?utf-8?B?dUttNW0vdXhXRW9LSzRhRWpONmdyQTd5dGQ3NDVjNWNETGJybFBFd0hTVmMx?=
 =?utf-8?B?TlNUTHN5MFRSVzNqU1hmV2JndEVCekRteTA5VHpPeEVXWVpCRytnM0xGQ3ZH?=
 =?utf-8?B?QVdBck1PcllMK1FaeTFKMWl3Q0h3RUZQSGk0aGErTnFvbjZmOXlXN3UvMzZO?=
 =?utf-8?B?L2duWWplWVRwOXNaQWpBdjZ4RU5aTHU3bU1seWM4NXprNG95NjVtTjVMT09B?=
 =?utf-8?B?dXJ4MmJFK0U0dEozcXdnNmM5NURodktoYVI0N3Z0SmU1NC9IUHhwdHBVbGQr?=
 =?utf-8?B?SE5GSlZLbm1lMkVrQkNmTW53Y2FRdSthY1Jxb2l1VFZ2SW5qMjVIS2hIblN5?=
 =?utf-8?B?aHFHQjBuSTIvMEJGbWhXcWI2bzh2bCtIbWNDZzhIMzk4NjNBb1d1YWFyckJT?=
 =?utf-8?B?VVhXekpTYlVQMjludkFVMDB2S2FOcGc0SEpoS1J1eGpUZDUyOTZka2lIOTVn?=
 =?utf-8?B?bExEQUxMS2Y1NjJOeDlyRVdGSXllZ1RwalJkZkVMbEJQdGtRVFhqTjRWQVBE?=
 =?utf-8?B?S3NZUUt6ZkR6WERKb21NN2hBME1nTHdnVXhpa2hydk15UGsxckRORkdqT0NN?=
 =?utf-8?B?bVV5Wi9wMVAwTnp6WkZGYXFQNkpRRHJBTWdHY1hlbFZEMkE4ZUllSkpmTmVS?=
 =?utf-8?B?LzVJRkVKZE9NTGNDaU1UZm1aS1R3RmU5WEd2aUZuUHRiOW9NWXFWdWFBVmhX?=
 =?utf-8?B?TEdSS3h2L1QxbFcwc2xCQTNyWjYvWkVkcE84R1NsL3RaR0JudGRWTHJXeXFU?=
 =?utf-8?B?TEtIalNlbTlRNmIyRG9tUm9EbVBWVnJ3VjdRcmFGN29UQUI4QnJ5NVhXS0ZU?=
 =?utf-8?B?R0FoTXpYZWVUc0NCTlpUeUxYbUkxcGpxZkVDV1R4RW1hOHBXNmJTMmE1dzZ1?=
 =?utf-8?B?MDArV3V3bW5HWml5cGYzb1J5cG1HSkdjWTk2R3JxOUFSQm5peGNiemgzUEQ0?=
 =?utf-8?B?VmQ2MG5QLzBiT2Z0K3lOQ2NkRnR2UWIwaGdtZHRldFpRT3FRU0VMSS9ZMnlS?=
 =?utf-8?B?UTE2a2UvNUZMQTc5NUpLRzBrS2NJQ0thaEhzd0libk9pMGxwa2NtZFBHci9P?=
 =?utf-8?B?RmVSbmN0NzJVdHV1dzQ1WUpVd253T1NzUmNKWjRyZ0Y0UkFoY2ZsaTI0Unp5?=
 =?utf-8?B?WTRyZGoybnlVUTZmeTNlNGgvS3hyNDI1MjU5ZUpraDg0NG9oOGpDSEZaNFB5?=
 =?utf-8?B?QWZQeGsreTRpald5SVN5VkRKc29vTTdpSFJXTjZvSENaNUR1dWtCOTFzeUFk?=
 =?utf-8?B?UlZvZW5wcWxkd0kxZWxhWXlGN0NaT0h4L0hPRWIyTU8zQnMwQ0dNWTBNTi9n?=
 =?utf-8?B?OXIzUVRkd1hFRnJTOGdnN1EreDN3bnpOSEwwOEF1ejkzMjBpelp5eDJVODJi?=
 =?utf-8?B?UWlxa1VyTXFCYkRKRkJXRHg5NWkwT0swVG1lNVhScS9BRUJrTFllQWpIWC95?=
 =?utf-8?B?N0Nad0EwYlBRZnQxckxqZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU5zK2dlamRTTjVGM0dEZ3ZGUlIwWG5qQXE1VTRJZFNBYzBjcU84Mld1SC83?=
 =?utf-8?B?ZzJiYUx4Q1IxWDlBb3MyV0UrcUZYcTdveGFJNjZsN3BqS0Q2UWt5WFd1SDdi?=
 =?utf-8?B?blJkbnBMYzZ4a2ZIWm1RbS83NzMvd09HNlZ6N2lLUngxQ201eWd0SXZQR2o5?=
 =?utf-8?B?VWZpWU9MRk1qMHRYSExMODNFR3VJbmNJMzRqUGtXUHZlMnMrY2UyUlczMWRt?=
 =?utf-8?B?eGVibnJJeVV2bjZ6UmgrOU96ZVV3TnBBdU1aS251U3dGS3NmMWFUZmxJUkVn?=
 =?utf-8?B?VEFSMGJHUkU4aFFFTllnRmRwSzR1RHlxS2taVjYxSmhhRjgwRk5hYVQ5UlFr?=
 =?utf-8?B?N1NiK0JHdXlmTEluQXNzQjhndUZnWkJqQmIvUzZxNXJ3UDViaXRrS0s3dEVm?=
 =?utf-8?B?L0xXbDcxdnpnTzd5K0hjMnRscUlnUHkxTnBpdmtDTDQ4THdqZmNYVWU0YVJ0?=
 =?utf-8?B?NFhrWi9ZR3lGaWNpK2IxRXI4WnV3N24yajZMc01qbmdSQ0xacTAvakl5VW9k?=
 =?utf-8?B?ZUNXYjhSZHREWHpMbk5xRGpSdkZTWTRhS0hrVXlqSHpNTGRzUU8rSDdJcW5N?=
 =?utf-8?B?YmZpTUg4b3RxZVZaM0E2NTZ0ZTJRdDhYMjZKSHlUWCtXNEt4YVNtckNLeTEr?=
 =?utf-8?B?MnNQdWs1TFJCNUtPWWdXOXpJU0NFYVVrNUtZcUFPVXhMbUl5dVEzaW14QzNF?=
 =?utf-8?B?SklwdzRpMnFqcHFMaEFPYXg1MW9ZbGZzUGFQUUZjc0NEVTYzckdzeG42WUpx?=
 =?utf-8?B?ZlZGeWxlMGU5QnQ4Vms3R1M4ZjgrZWtLdVVFV0ZkUjJrVFB1Y3pGdlE0eFdZ?=
 =?utf-8?B?aHVJSUcyS1Q5NkVKVm1SNEg0QXpUWitxdjQ4a3NQVVJQdytLN3ZZUllacnMr?=
 =?utf-8?B?bncwMllYMG9KS1BseE41Q1RCdDRnZkMwSXpsWStrbWUzbTlCNTVkdmRZUU9S?=
 =?utf-8?B?eFZKS3N0KzlJZ3g1cjA0VUpzVVBjYkZzSE9Zc3d0YzZJSEJIa090Y2pKbEJ3?=
 =?utf-8?B?NG1GK2J5ZmkrdzFyYjlJU0dMb0g1TWRNUXpjb2xuc3FQMHQ0RXpSRkpQU3Ir?=
 =?utf-8?B?ZzNBajZTbUVraG4rUndLeS83d1UrVlBTVHA2ZjdIYzYwcnJ3MmIzU1FKSmk4?=
 =?utf-8?B?NURjQ2VGK2pRZVB2am9nc3p3T1liQjZhWVRPMnIwclpnQkt1RnVjUkRqNS9y?=
 =?utf-8?B?c1FkWUc0aEhpYndwTzh6cUtDaHhlOUhsbE1jMElzVG1udVphbllSbnVpUk90?=
 =?utf-8?B?SFZCVXJ3TEdJYjhjMGVlc09ERkRUM3E4VkxIRWdlK2xUcTFQbUJQNnByUzQw?=
 =?utf-8?B?emYxb2Q1VC95MmQ4Z2prMFliNTIzSDNzampiRlROeElxMEN5L0lMUnFqRjBP?=
 =?utf-8?B?WDRvS0o5TDdMQVNvMlZnUVFLMDh2MkdpTUthM2FkSEt6OEtIV2JlOWdPV2dm?=
 =?utf-8?B?MlNDSmNtTENyR2U3d1RZQ05BL3lhOUdjc0tTdzhsN3h5ankza3M4eUprdW5t?=
 =?utf-8?B?cE8rR29RQzdRSXVtcTJRTHVFT0dTWXcwQ1I0alFGR0pMKys3NEx1TFVKY3R0?=
 =?utf-8?B?MXRGUTdDbGdIaWFhVEdmZ0lZRU5QU2NTS2dRb2ZxRGMxMGoxRkE5TzhJOWRi?=
 =?utf-8?B?YVo3K2g3MEJ5eEFwVDZTNlBlM2ZEM2QveDV3QWs0d1podk1HVyt0QjkrYmZV?=
 =?utf-8?B?UFpmNHJKaXU1UnAyUmNTQ1VsTEl2ZzlzWGFoWDdTM2svaG4yWlRHUDdZTUN3?=
 =?utf-8?B?blhiVGwvZDBIYk1iMHMraDl0ZjFpUDlYMFFrdUF0M2dxSTArNFRMS3Zic0sv?=
 =?utf-8?B?N1BhaTU4NnVkNHdvRnFubjl0UWVHM2d0RitYaUNpWEc0a1MwNmY0L2dXYTRY?=
 =?utf-8?B?T3hzbk1mMjhRQnJHRks2alBycDVPVDlHOVR6c20reWxTazk1bmUzSUwybE9F?=
 =?utf-8?B?S2x6K0VyYjArYkNoQXBnWWJBMmtYRXJCRUVjMGRFdlZ1c0g5RU9UNVlIUlVL?=
 =?utf-8?B?VVVHTVRNeEpmeXJCbEZ5TGhwVHFQN0RBbG1JMXFDcWtseDEwUVQxVHhHT3JC?=
 =?utf-8?B?TStzMzZBa2ZKbkswRVpZVTV2ZnFsUE1wUW00VFhIZW9EWWNickNOWVZmVTR1?=
 =?utf-8?Q?S3E1LC08i/6ehtp4bBLKjbOu7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb7129f-11b5-4cc9-ed4b-08dc7dfb7d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 03:17:07.4791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0hZAK5a94GeAWJvZvzW0b2akSM+8sM77XtXXTuH6BE4mnNMgq8iYer20x7f8ub1AP94S9LWqxsntUBKJU4jYXD+n38aDtPmdrxLTr+dzRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCByZmN2MiAwOS8xN10gaW50ZWxfaW9tbXU6IEZsdXNoIHN0YWdlLTEgY2FjaGUgaW4gaW90
bGINCj5pbnZhbGlkYXRpb24NCj4NCj5IaSBaaGVuemhvbmcNCj4NCj5PbiAyMi8wNS8yMDI0IDA4
OjIzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBE
byBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMNCj5lbWFp
bCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KPj4NCj4+DQo+PiBBY2NvcmRpbmcgdG8gc3BlYywgUGFnZS1TZWxlY3RpdmUtd2l0aGlu
LURvbWFpbiBJbnZhbGlkYXRpb24gKDExYik6DQo+Pg0KPj4gMS4gSU9UTEIgZW50cmllcyBjYWNo
aW5nIHNlY29uZC1zdGFnZSBtYXBwaW5ncyAoUEdUVD0wMTBiKSBvciBwYXNzLQ0KPnRocm91Z2gN
Cj4+IChQR1RUPTEwMGIpIG1hcHBpbmdzIGFzc29jaWF0ZWQgd2l0aCB0aGUgc3BlY2lmaWVkIGRv
bWFpbi1pZCBhbmQgdGhlDQo+PiBpbnB1dC1hZGRyZXNzIHJhbmdlIGFyZSBpbnZhbGlkYXRlZC4N
Cj4+IDIuIElPVExCIGVudHJpZXMgY2FjaGluZyBmaXJzdC1zdGFnZSAoUEdUVD0wMDFiKSBvciBu
ZXN0ZWQgKFBHVFQ9MDExYikNCj4+IG1hcHBpbmcgYXNzb2NpYXRlZCB3aXRoIHNwZWNpZmllZCBk
b21haW4taWQgYXJlIGludmFsaWRhdGVkLg0KPj4NCj4+IFNvIHBlciBzcGVjIGRlZmluaXRpb24g
dGhlIFBhZ2UtU2VsZWN0aXZlLXdpdGhpbi1Eb21haW4gSW52YWxpZGF0aW9uDQo+PiBuZWVkcyB0
byBmbHVzaCBmaXJzdCBzdGFnZSBhbmQgbmVzdGVkIGNhY2hlZCBJT1RMQiBlbnRpZXMgYXMgd2Vs
bC4NCj4+DQo+PiBXZSBkb24ndCBzdXBwb3J0IG5lc3RlZCB5ZXQgYW5kIHBhc3MtdGhyb3VnaCBt
YXBwaW5nIGlzIG5ldmVyIGNhY2hlZCwNCj4+IHNvIHdoYXQgaW4gaW90bGIgY2FjaGUgYXJlIG9u
bHkgZmlyc3Qtc3RhZ2UgYW5kIHNlY29uZC1zdGFnZSBtYXBwaW5ncy4NCj4+DQo+PiBBZGQgYSB0
YWcgcGd0dCBpbiBWVERJT1RMQkVudHJ5IHRvIG1hcmsgUEdUVCB0eXBlIG9mIHRoZSBtYXBwaW5n
IGFuZA0KPj4gaW52YWxpZGF0ZSBlbnRyaWVzIGJhc2VkIG9uIFBHVFQgdHlwZS4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgIDEgKw0KPj4gICBo
dy9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICB8IDIwICsrKysrKysrKysrKysrKysrLS0tDQo+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj5iL2luY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBpbmRleCAwMTFmMzc0ODgzLi5iMGQ1YjVhNWJl
IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+ICsrKyBi
L2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBAQCAtMTU2LDYgKzE1Niw3IEBAIHN0
cnVjdCBWVERJT1RMQkVudHJ5IHsNCj4+ICAgICAgIHVpbnQ2NF90IHB0ZTsNCj4+ICAgICAgIHVp
bnQ2NF90IG1hc2s7DQo+PiAgICAgICB1aW50OF90IGFjY2Vzc19mbGFnczsNCj4+ICsgICAgdWlu
dDhfdCBwZ3R0Ow0KPj4gICB9Ow0KPj4NCj4+ICAgLyogVlQtZCBTb3VyY2UtSUQgUXVhbGlmaWVy
IHR5cGVzICovDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCAwODAxMTEyZTJlLi4wMDc4YmFkOWQ0IDEwMDY0NA0K
Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+IEBAIC0yODcsOSArMjg3LDIxIEBAIHN0YXRpYyBnYm9vbGVhbg0KPnZ0ZF9oYXNo
X3JlbW92ZV9ieV9wYWdlKGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+PiAgICAgICBW
VERJT1RMQlBhZ2VJbnZJbmZvICppbmZvID0gKFZURElPVExCUGFnZUludkluZm8gKil1c2VyX2Rh
dGE7DQo+PiAgICAgICB1aW50NjRfdCBnZm4gPSAoaW5mby0+YWRkciA+PiBWVERfUEFHRV9TSElG
VF80SykgJiBpbmZvLT5tYXNrOw0KPj4gICAgICAgdWludDY0X3QgZ2ZuX3RsYiA9IChpbmZvLT5h
ZGRyICYgZW50cnktPm1hc2spID4+IFZURF9QQUdFX1NISUZUXzRLOw0KPj4gLSAgICByZXR1cm4g
KGVudHJ5LT5kb21haW5faWQgPT0gaW5mby0+ZG9tYWluX2lkKSAmJg0KPj4gLSAgICAgICAgICAg
ICgoKGVudHJ5LT5nZm4gJiBpbmZvLT5tYXNrKSA9PSBnZm4pIHx8DQo+PiAtICAgICAgICAgICAg
IChlbnRyeS0+Z2ZuID09IGdmbl90bGIpKTsNCj4+ICsNCj4+ICsgICAgaWYgKGVudHJ5LT5kb21h
aW5faWQgIT0gaW5mby0+ZG9tYWluX2lkKSB7DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+
PiArICAgIH0NCj4+ICsNCj4+ICsgICAgLyoNCj4+ICsgICAgICogQWNjb3JkaW5nIHRvIHNwZWMs
IElPVExCIGVudHJpZXMgY2FjaGluZyBmaXJzdC1zdGFnZSAoUEdUVD0wMDFiKSBvcg0KPj4gKyAg
ICAgKiBuZXN0ZWQgKFBHVFQ9MDExYikgbWFwcGluZyBhc3NvY2lhdGVkIHdpdGggc3BlY2lmaWVk
IGRvbWFpbi1pZA0KPmFyZQ0KPj4gKyAgICAgKiBpbnZhbGlkYXRlZC4gTmVzdGVkIGlzbid0IHN1
cHBvcnRlZCB5ZXQsIHNvIG9ubHkgbmVlZCB0byBjaGVjayAwMDFiLg0KPj4gKyAgICAgKi8NCj4+
ICsgICAgaWYgKGVudHJ5LT5wZ3R0ID09IFZURF9TTV9QQVNJRF9FTlRSWV9GTFQpIHsNCj4+ICsg
ICAgICAgIHJldHVybiB0cnVlOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldHVybiAoZW50
cnktPmdmbiAmIGluZm8tPm1hc2spID09IGdmbiB8fCBlbnRyeS0+Z2ZuID09IGdmbl90bGI7DQo+
PiAgIH0NCj4+DQo+PiAgIC8qIFJlc2V0IGFsbCB0aGUgZ2VuIG9mIFZUREFkZHJlc3NTcGFjZSB0
byB6ZXJvIGFuZCBzZXQgdGhlIGdlbiBvZg0KPj4gQEAgLTM4Miw2ICszOTQsOCBAQCBzdGF0aWMg
dm9pZCB2dGRfdXBkYXRlX2lvdGxiKEludGVsSU9NTVVTdGF0ZSAqcywNCj51aW50MTZfdCBzb3Vy
Y2VfaWQsDQo+PiAgICAgICBlbnRyeS0+YWNjZXNzX2ZsYWdzID0gYWNjZXNzX2ZsYWdzOw0KPj4g
ICAgICAgZW50cnktPm1hc2sgPSB2dGRfc2xwdF9sZXZlbF9wYWdlX21hc2sobGV2ZWwpOw0KPj4g
ICAgICAgZW50cnktPnBhc2lkID0gcGFzaWQ7DQo+PiArICAgIGVudHJ5LT5wZ3R0ID0gcy0+c2Nh
bGFibGVfbW9kZXJuID8gVlREX1NNX1BBU0lEX0VOVFJZX0ZMVA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA6IFZURF9TTV9QQVNJRF9FTlRSWV9TTFQ7DQo+V2hhdCBh
Ym91dCBwYXNzaW5nIHBndHQgYXMgYSBwYXJhbWV0ZXIgc28gdGhhdCB0aGUgdHJhbnNsYXRpb24g
dHlwZQ0KPmRldGVjdGlvbiBpcyBkb25lIG9ubHkgb25jZSAoaW4gdnRkX2RvX2lvbW11X3RyYW5z
bGF0ZSk/DQoNCkdvb2QgaWRlYSwgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPj4N
Cj4+ICAgICAgIGtleS0+Z2ZuID0gZ2ZuOw0KPj4gICAgICAga2V5LT5zaWQgPSBzb3VyY2VfaWQ7
DQo+PiAtLQ0KPj4gMi4zNC4xDQo+Pg0KPiNjbWQNCg==

