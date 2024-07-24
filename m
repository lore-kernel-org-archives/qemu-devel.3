Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B853C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 03:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWSE3-0004jZ-B4; Tue, 23 Jul 2024 22:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWSE1-0004cD-Dv
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 22:59:33 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWSDx-0001kk-RZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 22:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721789970; x=1753325970;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=D6FlxdE92kA9oIpEfj7eEQm/IzPYuq9hZjBfAAYaE7A=;
 b=FjD2iKrwm2D1g3XHew19Y8rK71VCqlcqYlUI4K6+shhpFlU0lNRQmTky
 fI6OGbLjnvBDlA2Bas5v5GkFqPDhY0JiNu2SDFkFN2GMtEUKGJFrftv+Z
 qSfzu9S75eiCUZm+iVJWrAQZLUWfvdOH9lEwrOpfwICmHL20rDDrept8D
 LM9oHlZ8EUSC9FxUeV0j/lZZ/5XwqISbPsxD0iteoT5uoydH0J6dcwVrB
 L8KfxNGBjCsaNNqXlbkhVEqpe5KJiSStmPITCRTBYnlCMVOzLG8tswtEq
 bVwVfa81sYOQeUr9s1u9Em5hbRyI2oDkTnLg+JGbqEW0j9JIqN6p7AdmX w==;
X-CSE-ConnectionGUID: EegC/dw+QSGRoeAKXR5Kyg==
X-CSE-MsgGUID: pdKylvW0SUurYwED/xdkrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19572393"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="19572393"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 19:59:27 -0700
X-CSE-ConnectionGUID: YuD0RFtNRtK5GqLOg2+qhA==
X-CSE-MsgGUID: xQ/0OSEBTmC7rttzd43xiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="83444053"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jul 2024 19:59:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 19:59:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 19:59:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 19:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/aqCdV4xezg4qO+64IZnzwTKy0MlkV3XfKUqfmf9AMBi+3ZWluQkSuYdYrOkK5bvCUNuS19JtObAub+Aq+77DNxal0SCdOLhi2XLUgPdEUPoP8gI9LbEc4YWhfTM4GpBhSAULQCyNfKt2tAD/FOuGbRanBvsP0vwHMh4cuwqFMT0omvPoRzkN7kCYU+XZv5hOHqsRe9LQrQEVQCLHppIjowLOI+0afT8z3wV0ggSrum03OfSAeP8+W4erWaXiiU+u0DnIzHybY/oa3jbfxFTsA7TWcCRsq32tUdGht9Qdq1wj4Zhd04KOMjGQ/+w5xxAAF+19b0F0uCrQnQMFy44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6FlxdE92kA9oIpEfj7eEQm/IzPYuq9hZjBfAAYaE7A=;
 b=PiF+KthumKFpNNr/jGe6uJ+1xFL5b1ucLHNJXD8XyoMKysMygJtJR8CWDKcXQkptky8mdfzG3R+vue/4sa5jPo7xXvm7IaYdxurdUwgNEAaff9vdWPxSq7Yp/eAQzUGVTslbVtfZgI7r4WBgG5Z4zopa9dGWB5NK56GwoFYVWSK8afATvm1Lx/WOyLkiz4yk/5Arq1nqZL9A18pnjbci973Fo5aq3kZwGtpi4KjuPRGLUdjqevattlUspOzp0+8Yl+TFw3mtWn1/3Vg7JoMZAQGSVgKnylcnVusvFu7JSbvtV3bFvBy1tHRxM7ROLfE4oW2hl9QeJU+GnIlf3XjdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 02:59:20 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 02:59:19 +0000
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
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v1 04/17] intel_iommu: Flush stage-2 cache in
 PADID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v1 04/17] intel_iommu: Flush stage-2 cache in
 PADID-selective PASID-based iotlb invalidation
Thread-Index: AQHa2OtDN6KlO7Waz0m+MLgs31oMZrIEgXyAgAC3N7A=
Date: Wed, 24 Jul 2024 02:59:19 +0000
Message-ID: <SJ0PR11MB6744432BBE635975409412CC92AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-5-zhenzhong.duan@intel.com>
 <8bc5a4b9-9b25-42dd-aeda-8140a81e1505@eviden.com>
In-Reply-To: <8bc5a4b9-9b25-42dd-aeda-8140a81e1505@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7880:EE_
x-ms-office365-filtering-correlation-id: 0d18fee3-408a-466f-7792-08dcab8c9cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TlpvYW1oUjhEbVNscGhQZllNSms2dTVLdStMcVRCTG9SL1dnOXkwSVFZZi9o?=
 =?utf-8?B?RDdVRmhjd01nRjBKeUl4QVY3eWVKVmt5N2phK1V6czdpWUE2alZUQ2Jib3hP?=
 =?utf-8?B?bWJDUmY4dVhZSzY1czZCZUZHazJJSmMzYVFHZFRCdlBucnFsTjNMUVMyb1F4?=
 =?utf-8?B?VERBdDFwcWk3U3gwSElLSTl6SVByTFFrK01JWnBTbzd4U0Q4bTl5eXlxekN0?=
 =?utf-8?B?bXhBS1RxemVFVXhSNmthcEdXcGRHM21peFZKanI2dHVaWS8wZWFrOEt0OHFO?=
 =?utf-8?B?ay9RVkdoeHR4eGErc3FJTVdGL2hzQ2ZVSU9GWFpQS1N4cnIvaDI5TGdIZG9l?=
 =?utf-8?B?QTdWOVYxWWtDTVBlQ1hjMXJvb1Vqa3BYWVVqMTRhek1mdnMyelo3WVZIanll?=
 =?utf-8?B?Mk1KVUl5dytuRklNVmdzcGZsZ0lmeTcrSDlhTGRtb0VkdE1vREFhbjNkaytl?=
 =?utf-8?B?bTN1SDhzbTl5VWhZV0dMWkpzWEhsZlBUZkZEbkg1ZFhVZ0c3V2kzV3ZQcFUx?=
 =?utf-8?B?TnBZbXBDZWFId2d4K1VkZXE5MklQbno0SXE0dEVTaWtUY0YzdmxncFVXQnk0?=
 =?utf-8?B?ZkZEYmJPd0ZCRlVYQncwVGk4OFF2T2duR3BPYjRYVkR3ZG13Q0t0OVVLVk9v?=
 =?utf-8?B?Z2g0NklDV2daeEkxWGlIS2pyWTQvZ0pIZkIxR1kzUWQ5SmgyU0ZDSGxncU5i?=
 =?utf-8?B?d2pyTFc2RUxoaHVJaWZnaHJpV0FOeWtCRnVsRy93WFYvTm56VVJMaENrNXlN?=
 =?utf-8?B?cExjOXdjT0hodCtKYnV3Q1BnMlVBM09JTmdwdVJ0YkozYkFSS1d5cWlzVTNY?=
 =?utf-8?B?R2piT2Y0aFFKemphQnljSmhsVkVVSlVQYnFhZWNramkwNm9TL3JZTm1RMzhl?=
 =?utf-8?B?bzB5eGIzbEgxZk1hS3phNkZreUhrZWZmaTJOYWhWbjQxOEJ0NGMyTU03VGpJ?=
 =?utf-8?B?QVhLcWprNzBSQm0rTkROcmFJQlJROGU2V3BNVUhJakkwVHV5TFdQaXlZUEx4?=
 =?utf-8?B?NXR3WDB3ZWplNmhnR2FIRS9LWkswd0FiV0lzZk9wZjhLdGRZZWJFaHFPMWY1?=
 =?utf-8?B?em9ZbTJQbWRlOGI1TkFRWUxzZHpXNTNsZWp5OXZZMGhLWVdwUlI2UWhMRkJY?=
 =?utf-8?B?NEJIbzZEK3g1bW1VV1ozVzMyUVd1VXg5ZTNNNXViR2pHMVc5RE5DR21Yazla?=
 =?utf-8?B?UHNQZk9kTDN6cnJoUGppMVBEa1E2alh3d2pYcDlBZlVHSXFLaks3dXJYUEpj?=
 =?utf-8?B?YzRPeGJ1aXlITlJnZ3dnT3h6VGdMWDhGd0NsUWNrMkY5WVNMT1h0YW9wR0Vv?=
 =?utf-8?B?M2RCMDlQTEJ5bWJwY1hpZllTYnI4dWgvWFhleU5YR29XZ2pjSkVEbGRPUXM0?=
 =?utf-8?B?OW51MGFrZCtUQytYa1RoVFBvR0lzeW44aytzb0JZWE9xOGhDT0E0aTFrK3g3?=
 =?utf-8?B?Z0I5NjJpcGlaaGh1Y08zUGxRdk4xanFUZnhoUFdyemhib00xVWVROGFyNlFj?=
 =?utf-8?B?czVxOVNDYTdmbFB5d1VvYXBCQzlOMkR5SkpmVVhIaUFQSEpaRnE0a0pJMkJw?=
 =?utf-8?B?MzdCTVl6Q2xxc2x5azZuaUJBM1JBSHZzWFpoa0g1aHdmR1NzYUNjcjg4Mkx2?=
 =?utf-8?B?ZVB4VXlrdlpUdFhmVkZsQlZVeWRUWTRzbFZ1bFhCYjNFNHZjdUhlSzQzYkxJ?=
 =?utf-8?B?MWxuWkgvY1ppbXpYYkIxTXhrVCttb1VSYUVEbndLakl0dG42Uzd6SnJDSVBw?=
 =?utf-8?B?bThtRlVvVGdJWml3V0tmY2hlUEtHMFVieGpWV29qZXhVVFNCSkVhZ214RjdX?=
 =?utf-8?B?ajBkL2VYNUcwTnNrNjRvamVuV2hjVUZRaVFQeE8rWTljVklGNUJub2o5QVRz?=
 =?utf-8?B?Rjlmb0hsT05WTHdrdFV0RjdkMC90cUFSK1gzN05XNGE5anc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFRUVHFaMFJSYVRvU3JCZFJJTWFyQ09JVmVVclhoenM5QnFMOEpJaWpNNVBQ?=
 =?utf-8?B?L2ZodEFGTzNxZmdsQWYzdGpvMTZETGsrK3NXV243ZjRqK3JjMlJOUGZHMVFv?=
 =?utf-8?B?NEpjM1IvNENadVdnRUJLd3VGR3RUUHNMMitaYzFEbndwYk05WHlMRzdWT284?=
 =?utf-8?B?WG8yNTNDby9rU0YzM2x0U1pwVlErZUl6MHp1WmNLZHAxMHNFTXJtYkdTSUdu?=
 =?utf-8?B?R2lMRlZKYXBKOFkyQWMydnplRG1mcVc5Z20xY0hGVGhQUW05Yk9GQTlZcXNh?=
 =?utf-8?B?eGtsZTkvZjhtQjYxV3dCaHBQeXVCc3VhMy9rdWZ3RGIzWHV2dDBiUHpva3FO?=
 =?utf-8?B?RHVtR0UzZ3dRdTJtY3BIc2dvbW02b2YzYnBDanExcDIrTC83RTV1SVpDY2Y4?=
 =?utf-8?B?K1RSUWh5anU1UjBVa1JRNmg1L0JidTM4Mk5namcxdWZBbjZvVEMreU1zZGFp?=
 =?utf-8?B?bVRPbjhhVXN6d0FiMFA5RlpWejdiTEdveXNrckw3WmFXb0FrcGRDUnFNRlYw?=
 =?utf-8?B?dlpVZ1Nta0ZLTU5ERUZ5TGROeDJITEFNVjZKZ2pkRERaRHk5dGRSVnJOcUpD?=
 =?utf-8?B?dFJhTTFOQVltSGF2bXFhVWR4TDJiNEVyejRwcU5qcng5RUFoajFWZjVsa2Fn?=
 =?utf-8?B?SXNMdnlZMStaT0xMY1QySkxBMk55M2EzVnUwa1p2VDVkQmhpc1ZaUGFweWtE?=
 =?utf-8?B?c3NnZElJdUx2c1FLYzE1bnFUQVNGK1BOa1M1bXo1ZE8rTDFrcXgwTE5RREdT?=
 =?utf-8?B?T1p3WWlzTFlXVlArNEttOWtQT2Q3ZUp2elcrL05WWmlvZE0wSVZzSGVFWlN2?=
 =?utf-8?B?a0VBUGNKa21CQVNoZ3RxOWlnZlJxT1Nsc1dHc0hRSEQyRWJCbmVtUFRUbysx?=
 =?utf-8?B?Z0Q1Y3lJVEIrancyZ3dqWU8xQ0VKblJLeDNIKzM1cHJET1BQeDV5cTY3WEJi?=
 =?utf-8?B?dGFJRlBaVVZsTDNXcjl1RVZVcTIwWTFVcDh5a1FxRWNnNEp6TnJFc2M4elhZ?=
 =?utf-8?B?di9hM1BBVW1IaGhvNEdNQU9tTUhBVzZoQUFvT0FUdlVjSmVIOHZNb1EyMFJF?=
 =?utf-8?B?OTZ6SzVvWnliaE1hUFg3SVBKdE02U2xrLzA5Y2k3QVZWdnVnQjR2eUx2M0p6?=
 =?utf-8?B?QytpSmNubUJTVEdWOTZ6dDY5R1VsQUNlMk5zRFA3TG5HY1NweFkrWFJOa3Fz?=
 =?utf-8?B?cDBKQWRNOWFMWVZETVRmY3M1UWZiNnMwL0prMU9iZlBpVnpQc0EzSjk0VzFG?=
 =?utf-8?B?VFFsc3ZjRThTWUE1OW5tOTdLeWhNOStCL1VwaDBOeFdaVFFMVU55QWVwaHlq?=
 =?utf-8?B?akpLTGJXYjExRXRTVTNaY2poU1lTS20veE5EQ3F6S0J1bFNnNm5SUEZZcmcv?=
 =?utf-8?B?Lzc0dzFseUgyOHFtSHpBRTdQWXVpVUlLajFmN2V3a1EwMXJhbG16N1lIcm5v?=
 =?utf-8?B?Y2toRDB6R0Y1OEhpZjgzVFdkUWJnanl5SnQ4am9rTUkrdlJzM0hXQXVHaTZU?=
 =?utf-8?B?ajlPSzJEa1ZiVDlPNGNiYU9ibURYSTJLQVlqbGthbXUrdGhTblRCSkJ2bmVu?=
 =?utf-8?B?cGhWMzJnN2NaalU5cDA5OW5WbC9rS1N1dWdvUVN3cVMzR1V0VjRJZ2ZXWXNm?=
 =?utf-8?B?ektSTWh4dDRFblJraFBySG5OWE5vMEtqWHE0d2ZBdjBWYXNDWXpXVFAvNWJD?=
 =?utf-8?B?VEJmSEhML3NZWmdmbXpDQTdRcWNEL2tySTNqSmFZOEUwMHBhNkVzdVRZWWhG?=
 =?utf-8?B?NUM2bUZMN25yRk5WNzRPbHRhaENPYlNVZUo3cUpTcFB5Ry9qWXZVay8xMjlW?=
 =?utf-8?B?Z2ZYUGdUbC9QWDhTUkhkWk54bDBPRVBldUN2bmRWN2V4WG1IQVU3dytRNTZk?=
 =?utf-8?B?aFlXM2lQSjFNZEl5cEg2dGxSNzBCTDdGTlNSVnB6T0d3MTBONmpPdUdLa3Nz?=
 =?utf-8?B?VDFvM0NkNXNSNVpZSzlQaEloSnoveTVlZ3BvQVgvRWhSWmVMelQwVXVnL24w?=
 =?utf-8?B?Tm41MlRVVlphZ2U0TXNXRUJVYUhYbnlHR2lRNEhUZzI3Sks2YzVsRzlMdzMy?=
 =?utf-8?B?T3JQd1ZSMDV3UnhRbFlQSXNHZU1kRHFtWWNySHNCQ1NwdHE2VVZkSDh6R1Fl?=
 =?utf-8?Q?clCoMvX20U7laqNwZNDf8mCIk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d18fee3-408a-466f-7792-08dcab8c9cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 02:59:19.3886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: if0iXPuvnKuF8s3qV0wJkophQmamjQcwJkmO6BnA5Z1Z70lI1xttRNIij+TVIbydFrPYTRymYB3kmJHFgyeRCGi03JVmEcICMvnc6TSzuQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAwNC8xN10gaW50ZWxfaW9tbXU6IEZsdXNoIHN0YWdlLTIgY2FjaGUgaW4gUEFESUQt
DQo+c2VsZWN0aXZlIFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbg0KPg0KPg0KPg0KPk9u
IDE4LzA3LzIwMjQgMTA6MTYsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0
ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxl
c3MgdGhpcw0KPmVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+Pg0KPj4NCj4+IFBlciBzcGVjIDYuNS4yLjQsIFBBRElELXNl
bGVjdGl2ZSBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24gd2lsbA0KPj4gZmx1c2ggc3Rh
Z2UtMiBpb3RsYiBlbnRyaWVzIHdpdGggbWF0Y2hpbmcgZG9tYWluIGlkIGFuZCBwYXNpZC4NCj4+
DQo+PiBXaXRoIHNjYWxhYmxlIG1vZGVybiBtb2RlIGludHJvZHVjZWQsIGd1ZXN0IGNvdWxkIHNl
bmQgUEFTSUQtc2VsZWN0aXZlDQo+PiBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24gdG8g
Zmx1c2ggYm90aCBzdGFnZS0xIGFuZCBzdGFnZS0yIGVudHJpZXMuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0K
Pj4gICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAxMCArKysrKw0KPj4gICBody9p
Mzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA3OA0KPisrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBpbmRleCA0ZTAzMzFjYWJhLi5mNzFmYzkxMjM0
IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiArKysg
Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IEBAIC00NDAsNiArNDQwLDE2IEBA
IHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZEZXNjOw0KPj4gICAgICAgICAgICgweDNm
ZmZmODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00gfA0KPlZURF9T
TF9UTSkpIDogXA0KPj4gICAgICAgICAgICgweDNmZmZmODAwVUxMIHwgfihWVERfSEFXX01BU0so
YXcpIHwgVlREX1NMX0lHTl9DT00pKQ0KPj4NCj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9U
TEJfQUxMX0lOX1BBU0lEICAoMlVMTCA8PCA0KQ0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJ
T1RMQl9QU0lfSU5fUEFTSUQgICgzVUxMIDw8IDQpDQo+PiArDQo+PiArI2RlZmluZSBWVERfSU5W
X0RFU0NfUElPVExCX1JTVkRfVkFMMCAgICAgMHhmZmYwMDAwMDAwMDBmZmMwVUxMDQo+PiArI2Rl
ZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRfVkFMMSAgICAgMHhmODBVTEwNCj4+ICsNCj4+
ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUEFTSUQodmFsKSAgICAoKCh2YWwpID4+IDMy
KSAmIDB4ZmZmZmZVTEwpDQo+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0RJRCh2YWwp
ICAgICAgKCgodmFsKSA+PiAxNikgJiBcDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgVlREX0RPTUFJTl9JRF9NQVNLKQ0KPj4gKw0KPj4gICAvKiBJbmZv
cm1hdGlvbiBhYm91dCBwYWdlLXNlbGVjdGl2ZSBJT1RMQiBpbnZhbGlkYXRlICovDQo+PiAgIHN0
cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIHsNCj4+ICAgICAgIHVpbnQxNl90IGRvbWFpbl9pZDsN
Cj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+IGluZGV4IDQwY2JkNGEwZjQuLjA3NWEyN2FkYWMgMTAwNjQ0DQo+PiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4g
QEAgLTI2NTksNiArMjY1OSw4MCBAQCBzdGF0aWMgYm9vbA0KPnZ0ZF9wcm9jZXNzX2lvdGxiX2Rl
c2MoSW50ZWxJT01NVVN0YXRlICpzLCBWVERJbnZEZXNjICppbnZfZGVzYykNCj4+ICAgICAgIHJl
dHVybiB0cnVlOw0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyBnYm9vbGVhbiB2dGRfaGFzaF9yZW1v
dmVfYnlfcGFzaWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdwb2ludGVyIHVzZXJfZGF0YSkNCj4+ICt7
DQo+PiArICAgIFZURElPVExCRW50cnkgKmVudHJ5ID0gKFZURElPVExCRW50cnkgKil2YWx1ZTsN
Cj4+ICsgICAgVlRESU9UTEJQYWdlSW52SW5mbyAqaW5mbyA9IChWVERJT1RMQlBhZ2VJbnZJbmZv
ICopdXNlcl9kYXRhOw0KPj4gKw0KPj4gKyAgICByZXR1cm4gKChlbnRyeS0+ZG9tYWluX2lkID09
IGluZm8tPmRvbWFpbl9pZCkgJiYNCj4+ICsgICAgICAgICAgICAoZW50cnktPnBhc2lkID09IGlu
Zm8tPnBhc2lkKSk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIHZ0ZF9waW90bGJfcGFz
aWRfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IGRvbWFpbl9pZCwgdWludDMyX3QgcGFzaWQp
DQo+PiArew0KPj4gKyAgICBWVERJT1RMQlBhZ2VJbnZJbmZvIGluZm87DQo+PiArICAgIFZUREFk
ZHJlc3NTcGFjZSAqdnRkX2FzOw0KPj4gKyAgICBWVERDb250ZXh0RW50cnkgY2U7DQo+PiArDQo+
PiArICAgIGluZm8uZG9tYWluX2lkID0gZG9tYWluX2lkOw0KPj4gKyAgICBpbmZvLnBhc2lkID0g
cGFzaWQ7DQo+PiArDQo+PiArICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gKyAgICBnX2hhc2hf
dGFibGVfZm9yZWFjaF9yZW1vdmUocy0+aW90bGIsIHZ0ZF9oYXNoX3JlbW92ZV9ieV9wYXNpZCwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZpbmZvKTsNCj4+ICsgICAgdnRk
X2lvbW11X3VubG9jayhzKTsNCj4+ICsNCj4+ICsgICAgUUxJU1RfRk9SRUFDSCh2dGRfYXMsICZz
LT52dGRfYXNfd2l0aF9ub3RpZmllcnMsIG5leHQpIHsNCj4+ICsgICAgICAgIGlmICghdnRkX2Rl
dl90b19jb250ZXh0X2VudHJ5KHMsIHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKSwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9hcy0+ZGV2Zm4sICZjZSkgJiYN
Cj4+ICsgICAgICAgICAgICBkb21haW5faWQgPT0gdnRkX2dldF9kb21haW5faWQocywgJmNlLCB2
dGRfYXMtPnBhc2lkKSkgew0KPj4gKyAgICAgICAgICAgIHVpbnQzMl90IHJpZDJwYXNpZCA9IFZU
RF9DRV9HRVRfUklEMlBBU0lEKCZjZSk7DQo+PiArDQo+PiArICAgICAgICAgICAgaWYgKCh2dGRf
YXMtPnBhc2lkICE9IFBDSV9OT19QQVNJRCB8fCBwYXNpZCAhPSByaWQycGFzaWQpICYmDQo+PiAr
ICAgICAgICAgICAgICAgIHZ0ZF9hcy0+cGFzaWQgIT0gcGFzaWQpIHsNCj4+ICsgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+PiArICAgICAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgICAg
IGlmICghcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiArICAgICAgICAgICAgICAgIHZ0ZF9hZGRy
ZXNzX3NwYWNlX3N5bmModnRkX2FzKTsNCj4+ICsgICAgICAgICAgICB9DQo+PiArICAgICAgICB9
DQo+PiArICAgIH0NCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfcGlv
dGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFZUREludkRlc2MgKmludl9kZXNjKQ0KPj4gK3sNCj4+ICsgICAgdWludDE2
X3QgZG9tYWluX2lkOw0KPj4gKyAgICB1aW50MzJfdCBwYXNpZDsNCj4+ICsNCj4+ICsgICAgaWYg
KChpbnZfZGVzYy0+dmFsWzBdICYgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDApIHx8DQo+
PiArICAgICAgICAoaW52X2Rlc2MtPnZhbFsxXSAmIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9W
QUwxKSkgew0KPj4gKyAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIm5vbi16ZXJvLWZpZWxkLWlu
LXBpb3RsYl9pbnZfZGVzYyBoaTogMHglIg0KPlBSSXg2NA0KPj4gKyAgICAgICAgICAgICAgICAg
ICIgbG86IDB4JSIgUFJJeDY0LCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVzYy0+dmFsWzBdKTsN
Cj5UaGlzIGVycm9yIGlzIG5vdCBmb3JtYXR0ZWQgYXMgdGhlIG90aGVyIHNpbWlsYXIgbWVzc2Fn
ZXMgd2UgcHJpbnQgd2hlbg0KPnJlc2VydmVkIGJpdHMgYXJlIG5vbi16ZXJvLg0KPkhlcmUgaXMg
d2hhdCB3ZSd2ZSBkb25lIGluIHZ0ZF9wcm9jZXNzX2lvdGxiX2Rlc2M6DQoNClN1cmUsIHdpbGwg
Y2hhbmdlIGFzIGJlbG93LA0KDQo+DQo+IMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydF9vbmNl
KCIlczogaW52YWxpZCBpb3RsYiBpbnYgZGVzYzogaGk9MHglIlBSSXg2NA0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiLCBsbz0weCUiUFJJeDY0
IiAocmVzZXJ2ZWQgYml0cyB1bnplcm8pIiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIGludl9kZXNjLT5oaSwgaW52X2Rlc2Mt
PmxvKTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAg
ICBkb21haW5faWQgPSBWVERfSU5WX0RFU0NfUElPVExCX0RJRChpbnZfZGVzYy0+dmFsWzBdKTsN
Cj4+ICsgICAgcGFzaWQgPSBWVERfSU5WX0RFU0NfUElPVExCX1BBU0lEKGludl9kZXNjLT52YWxb
MF0pOw0KPj4gKyAgICBzd2l0Y2ggKGludl9kZXNjLT52YWxbMF0gJiBWVERfSU5WX0RFU0NfSU9U
TEJfRykgew0KPk5vdCBjcml0aWNhbCBidXQgd2h5IGRvbid0IHdlIGhhdmUgVlREX0lOVl9ERVND
X1BJT1RMQl9HPw0KDQpXaWxsIGFkZC4NCg0KPj4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QSU9U
TEJfQUxMX0lOX1BBU0lEOg0KPj4gKyAgICAgICAgdnRkX3Bpb3RsYl9wYXNpZF9pbnZhbGlkYXRl
KHMsIGRvbWFpbl9pZCwgcGFzaWQpOw0KPj4gKyAgICAgICAgYnJlYWs7DQo+PiArDQo+PiArICAg
IGNhc2UgVlREX0lOVl9ERVNDX1BJT1RMQl9QU0lfSU5fUEFTSUQ6DQo+PiArICAgICAgICBicmVh
azsNCj4+ICsNCj4+ICsgICAgZGVmYXVsdDoNCj4+ICsgICAgICAgIGVycm9yX3JlcG9ydF9vbmNl
KCJJbnZhbGlkIGdyYW51bGFyaXR5IGluIFAtSU9UTEIgZGVzYyBoaTogMHglIg0KPlBSSXg2NA0K
Pj4gKyAgICAgICAgICAgICAgICAgICIgbG86IDB4JSIgUFJJeDY0LCBpbnZfZGVzYy0+dmFsWzFd
LCBpbnZfZGVzYy0+dmFsWzBdKTsNCj5TYW1lIGNvbW1lbnQsIEkgdGhpbmsgd2Ugc2hvdWxkIG1h
a2UgdGhlIG1lc3NhZ2VzIGNvbnNpc3RlbnQgYWNyb3NzDQo+ZGVzY3JpcHRvciBoYW5kbGVycy4N
Cg0KV2hhdCBhYm91dCBiZWxvdzoNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggMzI5MDc2
MTU5NS4uZTc2ZmQ5ZDM3NyAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQpAQCAtNDc5LDkgKzQ3
OSwxMCBAQCB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVzYzsNCiAjZGVmaW5lIFZU
RF9JTlZfREVTQ19QSU9UTEJfQUxMX0lOX1BBU0lEICAoMlVMTCA8PCA0KQ0KICNkZWZpbmUgVlRE
X0lOVl9ERVNDX1BJT1RMQl9QU0lfSU5fUEFTSUQgICgzVUxMIDw8IDQpDQoNCisvKiBNYXNrcyBm
b3IgSU9UTEIgSW52YWxpZGF0ZSBEZXNjcmlwdG9yICovDQorI2RlZmluZSBWVERfSU5WX0RFU0Nf
SU9UTEJfRyAgICAgICAgICAgICAgKDNVTEwgPDwgNCkNCiAjZGVmaW5lIFZURF9JTlZfREVTQ19Q
SU9UTEJfUlNWRF9WQUwwICAgICAweGZmZjAwMDAwMDAwMGZmYzBVTEwNCiAjZGVmaW5lIFZURF9J
TlZfREVTQ19QSU9UTEJfUlNWRF9WQUwxICAgICAweGY4MFVMTA0KLQ0KICNkZWZpbmUgVlREX0lO
Vl9ERVNDX1BJT1RMQl9QQVNJRCh2YWwpICAgICgoKHZhbCkgPj4gMzIpICYgMHhmZmZmZlVMTCkN
CiAjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfRElEKHZhbCkgICAgICAoKCh2YWwpID4+IDE2
KSAmIFwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERf
RE9NQUlOX0lEX01BU0spDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCAwNzMzMTgwNTAxLi45ZGQ0MWI4MzViIDEwMDY0NA0K
LS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
CkBAIC0zNzA4LDggKzM3MDgsOSBAQCBzdGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19waW90bGJfZGVz
YyhJbnRlbElPTU1VU3RhdGUgKnMsDQoNCiAgICAgaWYgKChpbnZfZGVzYy0+dmFsWzBdICYgVlRE
X0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDApIHx8DQogICAgICAgICAoaW52X2Rlc2MtPnZhbFsx
XSAmIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9WQUwxKSkgew0KLSAgICAgICAgZXJyb3JfcmVw
b3J0X29uY2UoIm5vbi16ZXJvLWZpZWxkLWluLXBpb3RsYl9pbnZfZGVzYyBoaTogMHglIiBQUkl4
NjQNCi0gICAgICAgICAgICAgICAgICAiIGxvOiAweCUiIFBSSXg2NCwgaW52X2Rlc2MtPnZhbFsx
XSwgaW52X2Rlc2MtPnZhbFswXSk7DQorICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGlu
dmFsaWQgcGlvdGxiIGludiBkZXNjIGhpPTB4JSJQUkl4NjQNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICIgbG89MHglIlBSSXg2NCIgKHJlc2VydmVkIGJpdHMgdW56ZXJvKSIsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgaW52X2Rlc2MtPnZhbFsxXSwgaW52X2Rlc2Mt
PnZhbFswXSk7DQogICAgICAgICByZXR1cm4gZmFsc2U7DQogICAgIH0NCg0KQEAgLTM3MjgsOCAr
MzcyOSwxMCBAQCBzdGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19waW90bGJfZGVzYyhJbnRlbElPTU1V
U3RhdGUgKnMsDQogICAgICAgICBicmVhazsNCg0KICAgICBkZWZhdWx0Og0KLSAgICAgICAgZXJy
b3JfcmVwb3J0X29uY2UoIkludmFsaWQgZ3JhbnVsYXJpdHkgaW4gUC1JT1RMQiBkZXNjIGhpOiAw
eCUiIFBSSXg2NA0KLSAgICAgICAgICAgICAgICAgICIgbG86IDB4JSIgUFJJeDY0LCBpbnZfZGVz
Yy0+dmFsWzFdLCBpbnZfZGVzYy0+dmFsWzBdKTsNCisgICAgICAgIGVycm9yX3JlcG9ydF9vbmNl
KCIlczogaW52YWxpZCBwaW90bGIgaW52IGRlc2M6IGhpPTB4JSJQUkl4NjQNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICIsIGxvPTB4JSJQUkl4NjQiICh0eXBlIG1pc21hdGNoOiAweCVsbHgp
IiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpbnZfZGVzYy0+dmFsWzFd
LCBpbnZfZGVzYy0+dmFsWzBdLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgaW52X2Rlc2Mt
PnZhbFswXSAmIFZURF9JTlZfREVTQ19JT1RMQl9HKTsNCiAgICAgICAgIHJldHVybiBmYWxzZTsN
CiAgICAgfQ0KICAgICByZXR1cm4gdHJ1ZTsNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

