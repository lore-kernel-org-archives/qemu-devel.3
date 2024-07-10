Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EB5C3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 09:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRU1l-0001Jh-PO; Wed, 10 Jul 2024 05:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRU1j-0001HT-HI
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:54:19 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRU1g-00065M-Jc
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720605257; x=1752141257;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=stuCVufBWe8ZaQsO6JgSViqngX0tRhU6OOF75Mu7Zj8=;
 b=Odq5XZLUTkbzvJTtiiKiKzFr2dXKJCZCkAx3DrorV8UV1YkmhfNXI0QC
 J6GPyy8RwrPJog6iZOjVThg4vNxGRpX93yJeYWKDtj2nh/NqFPS8Wz2qf
 WIc7f8+EZfktKDwuzO29SsVp5U7cusf8+BVVIs/EY4SFYcBve0Ye3OKPa
 lMAfprrP/M1xoVvwxgh8EWRwsFZHKHproED6K0U75/4JkSsvQnbudfQKA
 kLjKL1tgaNBQ/QfDIO2WyjUpfQoEESDMZCHUrAnkOD7I6gvuX+rgc4wFt
 PPXDzc/KslD5wrXnudf9efClk1DcVc0HqiOaqvXuNEGNhxVUFkZOmIIoT A==;
X-CSE-ConnectionGUID: 1BB11qN1Q4aoeokDTKjStw==
X-CSE-MsgGUID: 5BrSBodXTAK1elYHoGZWTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="12471073"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="12471073"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2024 02:54:12 -0700
X-CSE-ConnectionGUID: M7a4TwH4SCKe0mCXTPYh+A==
X-CSE-MsgGUID: 4do61EXxRKalvunveulUSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="48062232"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jul 2024 02:54:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 02:54:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 02:54:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 02:54:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 02:54:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsNf2l+v1Zle8sEEJGKvuVmg6edLQ3wlGrSiTVinZUh/L7y/R5GC2MVAt/Gh7jtnPfwW7kTe+lBNbZMIQoINE0SAEhyp3tQPak/61A2I+pXFRuSYa9uzdgl0reh6jJyo9fee84hb2uijhscTA/9N7TLI/OdHbgvkLPVDIH8K3TueJTWi5SJH6DxKyTSRQeAic6xfbKyVCKjnKEYUi5FUqES9zlagjBbYd9zsQ4CdN7lB036iw9NdDJzSnQVu6Q1sSRrpon+Laicevq+tZYSceR4qO1XvUlyG6LM2H4khNk2aw/BQN0Gkd9TeXTUeMnLOyOixHvK6716NH7OSoH56EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stuCVufBWe8ZaQsO6JgSViqngX0tRhU6OOF75Mu7Zj8=;
 b=gE4lJQDCFeN65ALgg03B/D8+kpSMX/YdZ4J+LvErNf3HfUlp1MNUdhtTIbHcR2ERA5by07t+Rilr035NlPyANTIdFbqRnNNJNquKo1fmpXpjdR3jGk0Q8yURKo1FO2FQeG/Sto55q1t5Zh5WRN1kFFGLIqMwzVhxkb9VZ+z+xDy3XimvAwbu3iKnzYf/qCT74wUN/pSPEhLCpHEw0qwpf627I+Fbt8uaFf2VPz/lCt+ParA4W6+eNt5k8IGgNV7+4/Yuxmdp4/7WA5OremOeKaYCH2xqmoACQCdeAIsxeaPQryUhYiyg1RWc0ue/l8jPUK5Y34TPkJE/Kk7GfNX82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB5264.namprd11.prod.outlook.com (2603:10b6:5:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 09:54:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 09:54:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
 IOMMU_GET_HW_INFO failure
Thread-Topic: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
 IOMMU_GET_HW_INFO failure
Thread-Index: AQHa0UP9XaJW+V7HF0q1KSPPC08ne7HtvVgwgABbzwCAAC9PgIAAAXAAgAD7n2CAAG9aAIAABM/A
Date: Wed, 10 Jul 2024 09:54:06 +0000
Message-ID: <SJ0PR11MB674411EFA02886F23B1222C392A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-2-joao.m.martins@oracle.com>
 <SJ0PR11MB67440E96F272F5D349023AEB92DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <e822d50d-8147-4846-94bf-fd32cb1aff99@oracle.com>
 <59a63429-831b-4bcd-b805-9fb83b8bcdd0@oracle.com>
 <47f86137-a47a-4fa7-a899-39c8f3bf4cbf@oracle.com>
 <SJ0PR11MB6744E07A01918228E5F4068792A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <97858274-3e67-4908-8119-a1ef9b6a092f@oracle.com>
In-Reply-To: <97858274-3e67-4908-8119-a1ef9b6a092f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB5264:EE_
x-ms-office365-filtering-correlation-id: 28580ed4-1a62-43f0-45be-08dca0c63d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZmgvNnpWd1VBVXA5YWJQMk5vVEdtcE54VzA3cUFxZyt4Qy9HeEw2c0J1Y2dC?=
 =?utf-8?B?OWlTTktDMHN4K3ZVcFp1MGlYV0dCL2ZmS3o2S1BiejJ0MFRGZ05vYmVpaDJM?=
 =?utf-8?B?UzJRVERSV1c1NVNnVlpIWGhXYTkzYUlXbTZEVDZ0R0QyOFMzc0tsMjlqUUFv?=
 =?utf-8?B?b2VpUCttS3c3aVpwZGVhU3lld0NvVVZ3Z2Z4elkrODJsbVNPZVZQbmdvaE1O?=
 =?utf-8?B?ajlKMkMrS2RtZy9pa0U5K2pJNWw1ZHZjdnptZnZocmtWNWhPYkpNSWFwVFhH?=
 =?utf-8?B?Q2IyTWQwUVZaV1dhTDg3YWRDayt2OXZ1WjJTU205SllNNjNWeFlUMmZaMnhM?=
 =?utf-8?B?ZjlzRjJ3cmN2TEZ0cktrOWxHM05XUUhtRFNrRFI4dG9NaFc3azVxVFB6bXNF?=
 =?utf-8?B?TTltYlZCVEJsWTNsU3puU1hBc21BNDhYWG9RWi91VDJqdGk3d1VQckhLV3BS?=
 =?utf-8?B?UjRvem82UFA3RGVvUWtPNE9yWHhkYVltczVLd2loTHJGRTdvcFJuZmVZQ1c2?=
 =?utf-8?B?SmIwbmxSNzJDYklZYkFTQUx5QVd2TlFkcTk2SzBxRGp0eDNUTFZhZWhCN2FB?=
 =?utf-8?B?M0FKTXJNTWJQNTJpS0poN0Rzc0FGLzNqT0lWOGhnRXBkMXllNkVGL3BkWlFz?=
 =?utf-8?B?UGpGMWdXVkFkbk9WRTFBWnp1UkNjTTQ4SWJ5Tko1QmlQZlE4ckR1ZTJPbzNJ?=
 =?utf-8?B?QjROQWR4WU5Da2xFU2tkOVpCdlVMN1lXa2hjck5lS0FKSHZZTzVZek94dGtJ?=
 =?utf-8?B?dXpIYTk3WXJPTDJQRUZrSjBENzNaK1d6OHBCWm9MMkJDUEpwRGlQaGdWSExa?=
 =?utf-8?B?VUUwTlZ1YklWRXIwckhyUEpzWEtFNmlDUzdqKzQvZ2taZTNzZnZwY2Z0WUNa?=
 =?utf-8?B?U2I5REZ1cmJ3QjBDN0dkdUNiaThSMUxMKzdiZDVSbE5ROVNuUG85aEhNbXhO?=
 =?utf-8?B?Yzh6Q3hmZW40M0E0WG1kMTVHcTZ3amo0dXRlSGRiTTlNKzFoVHpqL1F3alpB?=
 =?utf-8?B?TmwrOVI4eWRKT2dsZC9hRVJ6NTVYejdtU1pkQ2dNRnlKcUNUYzIxK09WajdJ?=
 =?utf-8?B?OEtBVzZMS3crQnI4TjVRSjRkWHFIelRJSXpwU2NoYm5WR1F6UDBTVW5OY3hE?=
 =?utf-8?B?amdKaWhmTTVvUTQ3RitxSlFjZ2ZWakV4c0FHa2tack5IS2lmY0ZHc0NaZmoz?=
 =?utf-8?B?YjRLeDNxR1AyclJYR3ZJN3pia3I2aHBWaE51UGllQlBmenMycVN6Y29ZQ0pv?=
 =?utf-8?B?ZW85T3JHcjBjejJYNVBlZUdxbzBsZDhRREk5RG4ySVRDNUQ3MG5LeFRWc3Bt?=
 =?utf-8?B?bnBsV3JzaFJqWlJiUFRkQUEwUndYcld1WThESTNSbUNISWF3WGhKY2dsbGh6?=
 =?utf-8?B?K1lsZlVHSWxSbS9jcW4vblZFbHhwUUVzbTEzenI2RE5JcUsrWFE3Zmg0Tm1r?=
 =?utf-8?B?SjRxTjF5bUo4amlCMitFSml5c2MxU0s2VTc1djNSSzAzaFN6TjJVOXBvb0R1?=
 =?utf-8?B?MzZveU1VVThWWUVJcTU4T2xaMi9KbDNoSEVCellKOGN1aXpyNTZsNDhraWxI?=
 =?utf-8?B?V1F0ZHZhTTlhZUhCY2VZa214RXZqa0l5eDNEWCtQZnhmWVV0QXhHN01QU3lk?=
 =?utf-8?B?RnZyTUlHL0QzTmttTUMyVXpWOHVBbFNuRHZZc1Z6TnIrWHRtaVNyK0xuMjJ2?=
 =?utf-8?B?Zjg0S3VEVEg1eXZqRmQxVU1NS3IxLzdKZWFpZ0loMWFMUXZEd2pLYWlnSHpi?=
 =?utf-8?B?Nnp4UksvUitvRFRBY2x1Rmk2aDU4empFKzRtSVdLOUJld0J5anlScXZqRlBl?=
 =?utf-8?Q?nM+mp77nwJ/g+Hcyw7UEMhA0Vx2jcB0xP6BD0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzdJR3l1WGlma0QxbXFBa1dLVXJHeDFMRnR4amRTSUJQSDIvV1RMOXFRR2Vy?=
 =?utf-8?B?RzFDeERlZlFuZ0NFSW1MSUV4bEJjRld6Nmd3VG9Uc29EWGh2TitLdlJ0bHh1?=
 =?utf-8?B?OGhsNENKcmxPb0hoYjhZRG8zNEowZEdJZHl3MTRIbndBdENYRHI2TFUwVzdX?=
 =?utf-8?B?T1dpc0Z0K3ZjdXpSVWwvRDhSdGEya1NkdUF5Mnc3OUE0TmJFMktTbmlmR1NQ?=
 =?utf-8?B?MmxWdWNHU2k4cEkxSk92Q1BpMFRPYmJRUGRxK083ZWJBVVROd1d1RWI3NGtw?=
 =?utf-8?B?d2pBaTM2QU9nYWgxMVI2SVQ5OFZ4K1E1T2dNNGZOeEU3bEVhTjV3Y0g0YlZh?=
 =?utf-8?B?OTY3WEhpOWl1eVExMVRZZ213WFZFQzMzSDMrYXdrZldPNnZKNWxWTXgyNUZJ?=
 =?utf-8?B?ODFMT0xDRXY1cEJIZ25LTzVMSmJnT0FIalZxTEE5cUN4S3NQM2hOd244NnA0?=
 =?utf-8?B?cDZtRUZXMCtodkowYmZaNzNPczQ1eTBCZWtoN1ZNREJrOVJwbDIyaXNsNUsx?=
 =?utf-8?B?cGEvVm9ibThPQ3orZHl1aWNrU0d0bmp0R2p6N2VRa1M4bjVFN2ZWR1pQYU0x?=
 =?utf-8?B?QVhJdlViRUMySzZ0Wmt3Rld6TzVqOFRRQ2tlK3cxeDI5RHpLclZXMUZWV0VR?=
 =?utf-8?B?d081VUJMbmRuSk15TUJCcFZvNlMwRzMyWGV6M1dxNmZzL3BRdEhBaXdMcXUx?=
 =?utf-8?B?TFlvbG5pakFWZy9sSUVwRzcrRFFvWVRWWStVRkpKL0ZNK2VBL1pyaFZsQm5Q?=
 =?utf-8?B?cDZYSHdZVkorL2llNmZKVmI1Zm56bzlVbWNnZlllNDJZQ05PcEc4M0RDOWhK?=
 =?utf-8?B?RURMb3BZZXhncS9PTGJmdU9keG1wMC9yWXJINzVmemN5em9JSWVqVEwzMnZ0?=
 =?utf-8?B?TUIra2pnMkMzekcvL2ZHazNkYkFnUzRtNHRXMHVSUHVpb2EzVkJVWXRVenp2?=
 =?utf-8?B?WnRHNEh5WW42ZmNkZklUYkd5SjArellXWWg4SDFYUlVMUU1td2pZOHBJeXho?=
 =?utf-8?B?UXl1Uk4xM3VJZXg2RGlTa3l3TDd5dkNqa1g3OEhqc09xN2hZVmJxeEw3aGx4?=
 =?utf-8?B?TDhiVVNtRW5KbVd1dTZ5MlNVTGVYSlE0aW5RMm1BSHRIcWhnbDNxaloramdl?=
 =?utf-8?B?UXdMcHJFaTFFMTc4dFk4OUtkV3IrL2pXMEtFanJOb1BFeFVGN0h3RmI2a0dD?=
 =?utf-8?B?SEVMUmlDSnVmR2JXcUhqWFZYcDdCQmp6REFoN2MvNDJ2dzBMVUFTaTBBTjRG?=
 =?utf-8?B?aUpTWTFoaVhUcXIyY2c3OTFFUFhvaDRzcUhNYWI2QmY1T1RIYmJWa0hVa21m?=
 =?utf-8?B?L3E4QldtZ1Qyd1FYSy9hQ1g5ZG5FQ0c3WVo5dXJFY29BcHVzb0U5bXQ2dS90?=
 =?utf-8?B?ejluMUl6ME9GdVFwY1grYzhUTU92MTJmc3l0OXBOMUhva1dhQ1hUdDBXVStE?=
 =?utf-8?B?SlRpM1ZocVBsU09oSmxpVmtmNVdBQzZnM3Z0b2hrS1dKeTJGYzdVNk5NU0I5?=
 =?utf-8?B?SGtoUGp0OGlncG1ZNnFEbmU3dnk3NGZVcENpTUI0T3Zob3ZUTjFYajBzNmhr?=
 =?utf-8?B?dFl4ZzJXb2xnTkdxbng2T3R5dmdMdng0Q201Q2llWkZNd1BUTUI1K3M4LzlR?=
 =?utf-8?B?SFh0UGUraG5xOXhDVXZIYnozT0hzZnZxZVRxcURyVlRMRmJuVmY0cWZkZ1Fx?=
 =?utf-8?B?UGVZTkpkY3NIdE9XUVFnb3AveUE2amYzam9BUm1BQ0ltaUlpNGovQ212VmJB?=
 =?utf-8?B?VEtNZXdMT1cxNFEwUjRyRi96czc4cjA5aXJFTWRNQndYTE01QjFvQlZWNE5I?=
 =?utf-8?B?MWxmdURFa1pGdVBXaW15TUluSXV4OGN0YWRIL1lMdzVlRHdnWGJmajhVNWFI?=
 =?utf-8?B?M2FGVjJwYm1CT2FuSTFFRDBNbkJLenVOQkc0NmppQkxWZk5aazZjVnErcmZ2?=
 =?utf-8?B?TWcxQ1V4Z0pzaUdnZUtMaEF1VjRmdTBMRHozWnM4K3NjZW1vMzRlWlo2T1Fn?=
 =?utf-8?B?SFovWERIREdoRURrcDlycGJzcFNyOXZhNWZqTnRObDVjUFFkQVhIWHR3TGZr?=
 =?utf-8?B?d3IvSEYrUmlXTWtVNEV3Tmd6V1ZPYVBNTlErbGpiNHBla0pDL01XSjVXUzEx?=
 =?utf-8?Q?/aoTES13WT6/LyHEOpC2BTXGj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28580ed4-1a62-43f0-45be-08dca0c63d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 09:54:06.8016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4I8QqXEozjeUO2aGYC9hbj8Wq3sxYVxNbC26BRMraE5slfff95bVlpfwCN2vtykpQUoCiKGJLx+gkru7lCaCwTH6JyOe6o/nh/Y6ADHbEPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5264
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDAxLzEwXSB2
ZmlvL2lvbW11ZmQ6IERvbid0IGZhaWwgdG8gcmVhbGl6ZSBvbg0KPklPTU1VX0dFVF9IV19JTkZP
IGZhaWx1cmUNCj4NCj5PbiAxMC8wNy8yMDI0IDAzOjUzLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6
DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEpvYW8g
TWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BB
VENIIHYzIDAxLzEwXSB2ZmlvL2lvbW11ZmQ6IERvbid0IGZhaWwgdG8gcmVhbGl6ZSBvbg0KPj4+
IElPTU1VX0dFVF9IV19JTkZPIGZhaWx1cmUNCj4+Pg0KPj4+IE9uIDA5LzA3LzIwMjQgMTI6NDUs
IEpvYW8gTWFydGlucyB3cm90ZToNCj4+Pj4gT24gMDkvMDcvMjAyNCAwOTo1NiwgSm9hbyBNYXJ0
aW5zIHdyb3RlOg0KPj4+Pj4gT24gMDkvMDcvMjAyNCAwNDo0MywgRHVhbiwgWmhlbnpob25nIHdy
b3RlOg0KPj4+Pj4+IEhpIEpvYW8sDQo+Pj4+Pj4NCj4+Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+Pj4+Pj4gRnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFj
bGUuY29tPg0KPj4+Pj4+PiBTdWJqZWN0OiBbUEFUQ0ggdjMgMDEvMTBdIHZmaW8vaW9tbXVmZDog
RG9uJ3QgZmFpbCB0byByZWFsaXplIG9uDQo+Pj4+Pj4+IElPTU1VX0dFVF9IV19JTkZPIGZhaWx1
cmUNCj4+Pj4+Pj4NCj4+Pj4+Pj4gbWRldnMgYXJlbid0ICJwaHlzaWNhbCIgZGV2aWNlcyBhbmQg
d2hlbiBhc2tpbmcgZm9yIGJhY2tpbmcNCj5JT01NVQ0KPj4+IGluZm8sIGl0DQo+Pj4+Pj4+IGZh
aWxzIHRoZSBlbnRpcmUgcHJvdmlzaW9uaW5nIG9mIHRoZSBndWVzdC4gRml4IHRoYXQgYnkgZmls
bGluZyBjYXBzIGluZm8NCj4+Pj4+Pj4gd2hlbiBJT01NVV9HRVRfSFdfSU5GTyBzdWNjZWVkcyBw
bHVzIGRpc2NhcmRpbmcgdGhlIGVycm9yIHdlDQo+Pj4gd291bGQNCj4+Pj4+Pj4gZ2V0IGludG8N
Cj4+Pj4+Pj4gaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbygpLg0KPj4+Pj4+Pg0KPj4+
Pj4+PiBDYzogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4+
Pj4gRml4ZXM6IDkzMDU4OTUyMDEyOCAoInZmaW8vaW9tbXVmZDogSW1wbGVtZW50DQo+Pj4+Pj4+
IEhvc3RJT01NVURldmljZUNsYXNzOjpyZWFsaXplKCkgaGFuZGxlciIpDQo+Pj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEpvYW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+Pj4+
Pj4gLS0tDQo+Pj4+Pj4+IGh3L3ZmaW8vaW9tbXVmZC5jIHwgMTIgKysrKystLS0tLS0tDQo+Pj4+
Pj4+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+Pj4+
Pj4+DQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9t
bXVmZC5jDQo+Pj4+Pj4+IGluZGV4IGMyZjE1OGU2MDM4Ni4uYTRkMjNmNDg4YjAxIDEwMDY0NA0K
Pj4+Pj4+PiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4+Pj4+PiArKysgYi9ody92ZmlvL2lv
bW11ZmQuYw0KPj4+Pj4+PiBAQCAtNjMxLDE1ICs2MzEsMTMgQEAgc3RhdGljIGJvb2wNCj4+Pj4+
Pj4gaGlvZF9pb21tdWZkX3ZmaW9fcmVhbGl6ZShIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIHZvaWQN
Cj4qb3BhcXVlLA0KPj4+Pj4+Pg0KPj4+Pj4+PiAgICAgaGlvZC0+YWdlbnQgPSBvcGFxdWU7DQo+
Pj4+Pj4+DQo+Pj4+Pj4+IC0gICAgaWYgKCFpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZv
KHZkZXYtPmlvbW11ZmQsIHZkZXYtDQo+Pj4+IGRldmlkLA0KPj4+Pj4+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdHlwZSwgJmRhdGEsIHNpemVvZihkYXRhKSwg
ZXJycCkpIHsNCj4+Pj4+Pj4gLSAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+Pj4+PiArICAgIGlm
IChpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZvKHZkZXYtPmlvbW11ZmQsIHZkZXYtDQo+
Pj4+IGRldmlkLA0KPj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmdHlwZSwgJmRhdGEsIHNpemVvZihkYXRhKSwgTlVMTCkpIHsNCj4+Pj4+Pg0KPj4+Pj4+
IFRoaXMgd2lsbCBtYWtlIHVzIG1pc3MgdGhlIHJlYWwgZXJyb3IuIFdoYXQgYWJvdXQgYnlwYXNz
aW5nIGhvc3QNCj4+PiBJT01NVSBkZXZpY2UNCj4+Pj4+PiBjcmVhdGlvbiBmb3IgbWRldiBhcyBp
dCdzIG5vdCAicGh5c2ljYWwgZGV2aWNlIiwgcGFzc2luZyBjb3JyZXNwb25kaW5nDQo+Pj4gaG9z
dCBJT01NVQ0KPj4+Pj4+IGRldmljZSB0byB2SU9NTVUgbWFrZSBubyBzZW5zZS4NCj4+Pj4+DQo+
Pj4+PiBZZWFwIC0tIFRoaXMgd2FzIG15IHNlY29uZCBhbHRlcm5hdGl2ZS4NCj4+Pj4+DQo+Pj4+
PiBJIGNhbiBhZGQgYW4gaGVscGVyIGZvciB2ZmlvX2lzX21kZXYoKSkgYW5kIGp1c3QgY2FsbA0K
Pj4+Pj4gaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbygpIGlmICF2ZmlvX2lzX21kZXYo
KS4gIEkgYW0NCj5hc3N1bWluZw0KPj4+IHlvdSBtZWFudA0KPj4+Pj4gdG8gc2tpcCB0aGUgaW5p
dGlhbGl6YXRpb24gb2YgSG9zdElPTU1VRGV2aWNlQ2Fwczo6Y2FwcyBhcyBJIHRoaW5rIHRoYXQN
Cj4+Pj4+IGluaXRpYWxpemluZyBoaW9kIHN0aWxsIG1ha2VzIHNlbnNlIGFzIHdlIGFyZSBzdGls
bCB1c2luZyBhDQo+Pj4+PiBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkRfVkZJTyBzb21l
d2hhdD8NCj4+Pj4+DQo+Pj4+IFNvbWV0aGluZyBsaWtlIHRoaXMgaXMgd2hhdCBJJ3ZlIGRvbmUg
d2l0aCB0aGlzIHBhdGNoLCBzZWUgYmVsb3cuIEkgdGhpbmsgaXQNCj4+Pj4gbWF0Y2hlcyB3aGF0
IHlvdSBzdWdnZXN0ZWQ/IE5hdHVyYWxseSB0aGVyZSdzIGEgcHJlY2VkZW50IHBhdGNoIHRoYXQN
Cj4+PiBpbnRyb2R1Y2VzDQo+Pj4+IHZmaW9faXNfbWRldigpLg0KPj4+Pg0KPj4+DQo+Pj4gU29y
cnkgaWdub3JlIHRoZSBwcmV2aW91cyBzbmlwLCBpdCB3YXMgdGhlIHdyb25nIHZlcnNpb24sIHNl
ZSBiZWxvdw0KPmluc3RlYWQuDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9pb21tdWZk
LmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4+IGluZGV4IGMyZjE1OGU2MDM4Ni4uOTg3ZGQ5Nzc5
Zjk0IDEwMDY0NA0KPj4+IC0tLSBhL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4gKysrIGIvaHcvdmZp
by9pb21tdWZkLmMNCj4+PiBAQCAtNjMxLDYgKzYzMSwxMCBAQCBzdGF0aWMgYm9vbA0KPj4+IGhp
b2RfaW9tbXVmZF92ZmlvX3JlYWxpemUoSG9zdElPTU1VRGV2aWNlDQo+Pj4gKmhpb2QsIHZvaWQg
Km9wYXF1ZSwNCj4+Pg0KPj4+ICAgICBoaW9kLT5hZ2VudCA9IG9wYXF1ZTsNCj4+Pg0KPj4+ICsg
ICAgaWYgKHZmaW9faXNfbWRldih2ZGV2KSkgew0KPj4+ICsgICAgICAgIHJldHVybiB0cnVlOw0K
Pj4+ICsgICAgfQ0KPj4+ICsNCj4+DQo+PiBOb3QgbmVjZXNzYXJ5IHRvIGNyZWF0ZSBhIGR1bW15
IG9iamVjdC4NCj4+IFdoYXQgYWJvdXQgYnlwYXNzaW5nIG9iamVjdF9uZXcob3BzLT5oaW9kX3R5
cGVuYW1lKSBpbg0KPnZmaW9fYXR0YWNoX2RldmljZSgpPw0KPj4NCj5Ob3Qgc3VyZSBJIGFtIHBh
cnNpbmcgdGhpcy4gV2hhdCBkdW1teSBvYmplY3QgeW91IHJlZmVyIHRvIGhlcmUgaWYgaXQncyBu
b3QNCj52YmFzZWRldjo6aGlvZCB0aGF0IHJlbWFpbnMgdW51c2VkPyBBbHNvIGluIGEgc3VnZ2Vz
dGlvbiBieSBDZWRyaWMsIGFuZA0KPnByZS1zZWVkaW5nIHZiYXNlZGV2OjpoaW9kIGR1cmluZyBh
dHRhY2hfZGV2aWNlKClbMF0uIFNvIEkgd2lsbCBzb3J0IG9mIGRvIHRoYXQNCj5hbHJlYWR5LCBi
dXQgeW91ciBjb21tZW50cyBtZWFucyB3ZSBhcmUgYWxsb2NhdGluZyBhIGR1bW15IG9iamVjdA0K
PmFueXdheXMgdG9vPw0KDQpZZXMsIHdpdGggeW91ciBzbmlwIGNoYW5nZSwgaXQncyBhbGxvY2F0
ZWQgYnkgb2JqZWN0X25ldyhvcHMtPmhpb2RfdHlwZW5hbWUpIGJ1dCBub3QgcmVhbGl6ZWQgDQph
bmQgbmV2ZXIgdXNlZCBlbHNlIHdoZXJlLg0KDQo+DQo+T3IgYXJlIHlvdSBwZXJoYXBzIHN1Z2dl
c3Rpbmcgc29tZXRoaW5nIGxpa2U6DQo+DQo+QEAgLTE1NTIsMTcgKzE1NTIsMjAgQEAgYm9vbCB2
ZmlvX2F0dGFjaF9kZXZpY2UoY2hhciAqbmFtZSwNCj5WRklPRGV2aWNlICp2YmFzZWRldiwNCj4N
Cj4gICAgIGFzc2VydChvcHMpOw0KPg0KPiAgICAgaWYgKCFvcHMtPmF0dGFjaF9kZXZpY2UobmFt
ZSwgdmJhc2VkZXYsIGFzLCBlcnJwKSkgew0KPiAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAg
IH0NCj4NCj4gICAgIGlmICghdmZpb19tZGV2KHZiYXNlZGV2KSAmJg0KPgkgIUhPU1RfSU9NTVVf
REVWSUNFX0dFVF9DTEFTUyhoaW9kKS0+cmVhbGl6ZShoaW9kLCB2YmFzZWRldiwNCj5lcnJwKSkg
ew0KPg0KPj8NCg0KSSBtZWFuIGJ5cGFzcyBob3N0IElPTU1VIGRldmljZSB0aG9yb3VnaGx5IGZv
ciBtZGV2LCBsaWtlOg0KDQotLS0gYS9ody92ZmlvL2NvbW1vbi5jDQorKysgYi9ody92ZmlvL2Nv
bW1vbi5jDQpAQCAtMTU0OCw2ICsxNTQ4LDEwIEBAIGJvb2wgdmZpb19hdHRhY2hfZGV2aWNlKGNo
YXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
ICAgICB9DQoNCisgICAgaWYgKHZmaW9faXNfbWRldih2ZGV2KSkgew0KKyAgICAgICAgcmV0dXJu
IHRydWU7DQorICAgIH0NCisNCiAgICAgaGlvZCA9IEhPU1RfSU9NTVVfREVWSUNFKG9iamVjdF9u
ZXcob3BzLT5oaW9kX3R5cGVuYW1lKSk7DQogICAgIGlmICghSE9TVF9JT01NVV9ERVZJQ0VfR0VU
X0NMQVNTKGhpb2QpLT5yZWFsaXplKGhpb2QsIHZiYXNlZGV2LCBlcnJwKSkgew0KICAgICAgICAg
b2JqZWN0X3VucmVmKGhpb2QpOw0KDQoNCj4NCj4NCj5bMF0NCj5odHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsLzRlODVkYjA0LWZiYWEtNGE2Yi1iMTMzLQ0KPjU5MTcwYzQ3MWUyNEBv
cmFjbGUuY29tLw0KDQo=

