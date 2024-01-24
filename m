Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510EDC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 09:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSZUY-0005os-Nf; Wed, 24 Jan 2024 04:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSZUW-0005ok-Kk
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:24:17 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSZUU-0002sD-9h
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706088254; x=1737624254;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=C0gA4rVRBVwWIFWN7K9ogQADmuYMpFfm92pzEdRvl6k=;
 b=grAUgRiglJgaC1T6rD+KGHuVIS01w0Ch0r37RA7t7hAhCihlERFEhxdd
 hE9gUjTbIKZyTYkfyxOx1rOjLAvrXMZ9iCfn95yW9h/Do6X1GVeVOG/Bt
 lcAUlu3yfHQn2iytkjkF1wKaiaZ2R2UFa5sZCgYfN1O0/S0mXbCyAndqq
 Ucy+de7kVdHc6j3RzliydUR1cBrt2Z92DusSlfnJLnZ7jcg4mHNt+wNDQ
 3k2IZ1pPv0oJPSzcIrumgDHpaiQY0alKC9W5OAfWyQlAw95kYWmIdj+Cu
 5CEE1aU2Cxye9AmnBdk2MQemOR/t3P07wl0ddV1RUvtxpLKBKL5RXI37R g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="392206646"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="392206646"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 01:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820394371"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="820394371"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Jan 2024 01:23:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 01:23:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 01:23:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 01:23:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmCW+MQ8DJ7QD70otKFtu8J4Htnz/dXKfTlw43DPEX4VCQFT8rmBjGdu1gZKSVeUCTkGQe+5mFYHpY5mqrgLxfgKoLlcKRmLkCN+bmGVk2GrP0GGdQnQZgVb+lYvlJjvVWaYJXojij87TqzeIseK/0gTCxLF+VlcmIRlzRNByWnN3FqXtCVanoy5nENWRVU1s8fbhmEggWBwt6XoGxd0NWhr7RDQny2Gth+Di0Xf3eHdDXblnWNflZhOk8vj9s3+bjbA7AwnwY7NwNfpubtXnoqHUZbpDuNG+86eBjy0zkiapzk1UMWHoENV2dRCgG99Rb/TIKA1jNTsLrgs81Wl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0gA4rVRBVwWIFWN7K9ogQADmuYMpFfm92pzEdRvl6k=;
 b=ENVkuzEnnkBko2fbsEldt0PXgTyXsb0Kcn8GuGgHbac6Hy2JlRBlAduPX2B+eM5L8BotTdapX0mnE+qErKOPbCABXDnnxhrP/ZTYHQ3+KCuyydMxMloXx2r6P8xGiS4EqGkKspLvSprktTmKQmUMKZmWJvI0mxuxdzY1xQWGZaSbdYbB7q6el+2B++ESN/8yrCT4WdvxLdC9/uyNm+FIR5UsQ0OYAE8kO7pHTcIv9nQOQVZRZ4rsopNXvG8Zoc94y1OYTF2mF09r05PYsySW6rXeevyWfKW4U3qEiQmBcx7IJXV3CFmsHDtmc5COEr/ohS+V1hNEmK6ICiFMqD3agQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:23:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 09:23:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Thread-Topic: [PATCH rfcv1 2/6] hw/pci: introduce
 pci_device_set/unset_iommu_device()
Thread-Index: AQHaR5vrPb8w/pVxfEGbuNI7QgnDG7DmGFKAgADgPYCAABb/AIAAFRcwgAAXNACAAYA+QA==
Date: Wed, 24 Jan 2024 09:23:45 +0000
Message-ID: <SJ0PR11MB6744526AE6359BC35DBFC0E2927B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-3-zhenzhong.duan@intel.com>
 <f2ca6b36-922c-42e4-98d6-59616099980a@redhat.com>
 <SJ0PR11MB6744075B12BE080F9BBEC37792742@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <1560b289-3389-4027-8c93-4e71b2c6cd77@redhat.com>
 <SJ0PR11MB6744254204FF8E9D3E1169C892742@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <39a50e45-73e8-4f17-871b-336dc2fdc35f@redhat.com>
In-Reply-To: <39a50e45-73e8-4f17-871b-336dc2fdc35f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5238:EE_
x-ms-office365-filtering-correlation-id: 2adfc392-fedd-46c2-70fa-08dc1cbe2a1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5/vaZoQZnY1Mrw1rZKeJPEinlvBIl42y0LenkFHKp0cycdt+FpOPeNBSumxb40XriGCpVA8yikvL3foKKOcbCd29KDo3yOnAWPArOFNVGl7n7O9RTOHHhcvBIAaVgafn37OPVzmodibbRFZpPLQDkFB9pAMlluF4RaNKH5QYw5xCb5H06+WP5Q9wfEBwDfZfEFwaam7oZCIsvG/fEjJs+pm7nD97fyO9fvGtXojfChjEjshp0xAR/SMIc7YuSictkwezbwl4wh8o+K3qU2P42Z7M0ybIb1GMX9bp0aAN6Nzq5ECZwG8x6PsXd91Wtn9uhKJAy1YjYckGrsVtIGuXHey7F6idfUBO+zLb+verzOYX7fi/c6pBsVCh4vjy/xvgcUY4ooTO+vh2jx/5LPqdrwxnlARj26ACYgyE0dBqAYtC53cYdXAGlxctCfobrYoXbkXoqy8mwUUAa60emMuOMxVGzf0J7ihz5xzXhwQGUAWNXOndTYumA/iBlwaYd7Cfnt58ntvGzLt24q4JoE14tscQzd9U47Tw8mWjeRwC7bbZNDLj/wcXXUYoV0Dzw0eXnupl1WyrKyXHTZd9i1FVN1lrEXa3dddaeeKUgz/Kug=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(9686003)(26005)(66574015)(122000001)(38100700002)(52536014)(4326008)(8676002)(8936002)(5660300002)(7416002)(2906002)(478600001)(6506007)(7696005)(53546011)(71200400001)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(110136005)(38070700009)(82960400001)(33656002)(86362001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUNuMHJ3N3Awc0RzQlUrZUllOFVFejlwUHh3ZGlBcFlRWmJZdU9GdmdRU3Fy?=
 =?utf-8?B?K1M0TWF0WFBUcCtNbnhsMU1QODFiR2s3aGdBWHY1L3RSdkhjT2MreUxRWjVB?=
 =?utf-8?B?WmRXUHQxOWUzTzBZZVFnT1EvUEFLMnUxRWpnVHErRWVqYkxGQTFkUFJJVEpv?=
 =?utf-8?B?Z0hNdFlzdXp6NTJHV3BORFlBSmJtYkpPUzNvdE1LQ051dXE2aXpzdE9ZZVBE?=
 =?utf-8?B?NlBwOTFOYVdCWW9lQUVjK284V1gxTllHS2M0eXh4VTFSK1FGbG9zU0FOQzFQ?=
 =?utf-8?B?a0VSSVVpU1FSbmNyMG5ncVptYldBZXdmbkFNTnNKMzZ1SUVxVHZDd0hBQTlk?=
 =?utf-8?B?VzhxdFRLTE9va3k4cWdPczJLTkFwbWFyQkwzQVE0VG9DY0ltRVZyM0dYVXQ0?=
 =?utf-8?B?aExRY292ZXFIczJLM1dScUVDZ0E5cXl0ZDdvKzJucmlwZ2J0ZTFTeis2QWFv?=
 =?utf-8?B?bTJkTkVySWN1T2hsZVpaUHAvL0xmSThuZzhGU0UzMHI5bytvVTlVdDBWNFdK?=
 =?utf-8?B?U3dodGdsRkhTSEtBbHVGYis3OXZncURIUzNqNDIvdXhwZVVDY3RuOFJRTG55?=
 =?utf-8?B?cFlaSGgyZXNnSTUrQ1duUStTNEpNNHVrOTk1V0o4a1JZY1VETFhyT1Jlck9H?=
 =?utf-8?B?VEpEZVYraW0vRHNjbGNXZFRwbnpsQm8rUURxNlkxZEJHbEJQNExoTmV1Zlhh?=
 =?utf-8?B?eS9KWHh0VDc0QkRqYmVTSEhQOTV6eTJhOUsydjQyVjRPUmRIL1krcmVTelYw?=
 =?utf-8?B?b3MyMXJjaHZhRU8vdlVadFozWFBzV2t2cXdtWjRLZnNUV3EySEdTanFsbmFq?=
 =?utf-8?B?ZzJHMTNvNy9tVjUzdTlQMW1COVIybDd0OFU1eXpCd3M2VnVSSHZGZDdQM0hs?=
 =?utf-8?B?R2c4VUJlUXI2MWxFY3hPbWczTkZQWDhGaGNyeDlSbmQ5M3VzQXFFTlFMV0dp?=
 =?utf-8?B?eDkxcHFJbmZ5a1NjaGRGbVM5QW4vZElzQzJLUmE5QWhvUTlwS1ZYV3lVT3ht?=
 =?utf-8?B?b2YxRzNMSDE5RjJ6L1NKb0gzSVNnNzBUclkxV2dZZjZwanhjZldQbVc0SGVG?=
 =?utf-8?B?L1BBSFdNWnZtLzdGNkZmMnNoRkVSNU51SlRCdHNBeEo5WGVRZlVWWjFnVGU4?=
 =?utf-8?B?VTZJOTNuR0VwNzFQbVJwYjU4Nld5V3VEVWE1QVlpelFMR3c3K3cydmtGLzNv?=
 =?utf-8?B?Y2w0bWlFVitYaWJSN1RmUnFKVGYvRUVQd2FtTGZhR0xqRFcvbzFYODA2Rk54?=
 =?utf-8?B?Q2NVSXBzSy9JVzU2NEZna3ZYM1Nxa1NLRXRPNzZFbVhXT1FscFNYVW1tQ3dQ?=
 =?utf-8?B?NTV6MHVoV09pOUxtRTZ6K2RCSmR2Q3k3eHpaOHBLNzUyZFlSSWhyWUMwUlQy?=
 =?utf-8?B?dm1DakhmdWVKbUd0dFNxYWVZVlZMNmNkZW96WEFuSUdYVitjaTBnWHBzeGlK?=
 =?utf-8?B?ampvZ2lnNVFydGFHMENrRVYrQlBzMmhGblA0ZGxKZ1RLdW1GeEtTSEY4UFhL?=
 =?utf-8?B?S2xLMFlKZU40SUFxSXdQbVVIaFJnbGg3Zmh2cEgxY3RzTGJzbTYraWlUdDZ6?=
 =?utf-8?B?MTlyMk8xQ1VJOGRKWGx0MjluQ2k2ZDBkcTNiUkppVXh1R2dSbjBYeFdmdVpY?=
 =?utf-8?B?ZVVlYituUDJEUWJ0WmFJTjg3ZU04R3NzS1dwSFdkQWJVSWtsMVU5Y28yVDhU?=
 =?utf-8?B?WkFyQURZL1pWYmZhNVJVWVZXUU1ZdHU3UTZVOUcrMHU4U29KY3Vyd09KTXhR?=
 =?utf-8?B?dWJoOVQzWFhRVmNYaXVTQjd3M2JJYnowNDQvejR1SlhUUXFQRFpxclFVMUNI?=
 =?utf-8?B?dUtVMW83S08wZlVMZ2JsMHlpZWJoUnJmRmJlTks3cDdicElVNk9DYlBnRkpU?=
 =?utf-8?B?UWlmS25EOFZQK0ZWMmliU1dmQ3BTb0pRNXhwUnJlMjBPM0pjZWZETFVTUWY1?=
 =?utf-8?B?Vk5XVjNXVzFQZHI2aVZBZXNZcys0OGlvTXVlNmRCZmZlRmsxZlpsNThOS2JP?=
 =?utf-8?B?QVNvNEhDOVZ0N0dpWjVZdVJhSzBvRFZqN3NPaUtLK3piTGJVTVEreFNLR1dl?=
 =?utf-8?B?eldXL20wL2FFckRkeXVXRXBEMFB2dXRJQTFHWVdkaVZ1Sjg4NXdpdGVEUEFs?=
 =?utf-8?Q?+DQj7CGKspHkGnZgRteuXjSmc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adfc392-fedd-46c2-70fa-08dc1cbe2a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 09:23:45.5791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ed4ay+vtbBl1wL/E1Qrh3YVch0K8KlizEjFz1kTxGcaICis11P9aptJfdyW8Aqc97H81zXGRKVO2XntPd2JeMQrBRSCMJhv7QaE6Xo+anW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDIvNl0gaHcvcGNp
OiBpbnRyb2R1Y2UNCj5wY2lfZGV2aWNlX3NldC91bnNldF9pb21tdV9kZXZpY2UoKQ0KPg0KPg0K
Pg0KPk9uIDEvMjMvMjQgMTA6MjUsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xn
QHJlZGhhdC5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCByZmN2MSAyLzZdIGh3L3BjaTog
aW50cm9kdWNlDQo+Pj4gcGNpX2RldmljZV9zZXQvdW5zZXRfaW9tbXVfZGV2aWNlKCkNCj4+Pg0K
Pj4+IE9uIDEvMjMvMjQgMDc6MzcsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+Pj4NCj4+Pj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDIvNl0g
aHcvcGNpOiBpbnRyb2R1Y2UNCj4+Pj4+IHBjaV9kZXZpY2Vfc2V0L3Vuc2V0X2lvbW11X2Rldmlj
ZSgpDQo+Pj4+Pg0KPj4+Pj4gT24gMS8xNS8yNCAxMToxMywgWmhlbnpob25nIER1YW4gd3JvdGU6
DQo+Pj4+Pj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+Pj4NCj4+Pj4+
PiBUaGlzIGFkZHMgcGNpX2RldmljZV9zZXQvdW5zZXRfaW9tbXVfZGV2aWNlKCkgdG8gc2V0L3Vu
c2V0DQo+Pj4+Pj4gSU9NTVVGRERldmljZSBmb3IgYSBnaXZlbiBQQ0llIGRldmljZS4gQ2FsbGVy
IG9mIHNldA0KPj4+Pj4+IHNob3VsZCBmYWlsIGlmIHNldCBvcGVyYXRpb24gZmFpbHMuDQo+Pj4+
Pj4NCj4+Pj4+PiBFeHRyYWN0IG91dCBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oKSB0
byBmYWNpbGl0YXRlDQo+Pj4+Pj4gaW1wbGVtZW50YXRpb24gb2YgcGNpX2RldmljZV9zZXQvdW5z
ZXRfaW9tbXVfZGV2aWNlKCkuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUg
PHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnku
c3VuQGxpbnV4LmludGVsLmNvbT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4g
PG5pY29saW5jQG52aWRpYS5jb20+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgICBpbmNs
dWRlL2h3L3BjaS9wY2kuaCB8IDM5DQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCj4+Pj4+PiAgICBody9wY2kvcGNpLmMgICAgICAgICB8IDQ5DQo+Pj4+PiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4+Pj4+ICAgIDIgZmlsZXMg
Y2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pj4+Pg0KPj4+Pj4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2kuaCBiL2luY2x1ZGUvaHcvcGNpL3BjaS5o
DQo+Pj4+Pj4gaW5kZXggZmE2MzEzYWFiYy4uYTgxMGMwZWM3NCAxMDA2NDQNCj4+Pj4+PiAtLS0g
YS9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KPj4+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvcGNpL3BjaS5o
DQo+Pj4+Pj4gQEAgLTcsNiArNyw4IEBADQo+Pj4+Pj4gICAgLyogUENJIGluY2x1ZGVzIGxlZ2Fj
eSBJU0EgYWNjZXNzLiAgKi8NCj4+Pj4+PiAgICAjaW5jbHVkZSAiaHcvaXNhL2lzYS5oIg0KPj4+
Pj4+DQo+Pj4+Pj4gKyNpbmNsdWRlICJzeXNlbXUvaW9tbXVmZF9kZXZpY2UuaCINCj4+Pj4+PiAr
DQo+Pj4+Pj4gICAgZXh0ZXJuIGJvb2wgcGNpX2F2YWlsYWJsZTsNCj4+Pj4+Pg0KPj4+Pj4+ICAg
IC8qIFBDSSBidXMgKi8NCj4+Pj4+PiBAQCAtMzg0LDEwICszODYsNDUgQEAgdHlwZWRlZiBzdHJ1
Y3QgUENJSU9NTVVPcHMgew0KPj4+Pj4+ICAgICAgICAgKg0KPj4+Pj4+ICAgICAgICAgKiBAZGV2
Zm46IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyDQo+Pj4+Pj4gICAgICAgICAqLw0KPj4+Pj4+
IC0gICBBZGRyZXNzU3BhY2UgKiAoKmdldF9hZGRyZXNzX3NwYWNlKShQQ0lCdXMgKmJ1cywgdm9p
ZCAqb3BhcXVlLA0KPmludA0KPj4+Pj4gZGV2Zm4pOw0KPj4+Pj4+ICsgICAgQWRkcmVzc1NwYWNl
ICogKCpnZXRfYWRkcmVzc19zcGFjZSkoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwNCj4+PiBp
bnQNCj4+Pj4+IGRldmZuKTsNCj4+Pj4+PiArICAgIC8qKg0KPj4+Pj4+ICsgICAgICogQHNldF9p
b21tdV9kZXZpY2U6IHNldCBpb21tdWZkIGRldmljZSBmb3IgYSBQQ0kgZGV2aWNlIHRvDQo+Pj4+
PiB2SU9NTVUNCj4+Pj4+PiArICAgICAqDQo+Pj4+Pj4gKyAgICAgKiBPcHRpb25hbCBjYWxsYmFj
aywgaWYgbm90IGltcGxlbWVudGVkIGluIHZJT01NVSwgdGhlbg0KPnZJT01NVQ0KPj4+Pj4gY2Fu
J3QNCj4+Pj4+PiArICAgICAqIHV0aWxpemUgaW9tbXVmZCBzcGVjaWZpYyBmZWF0dXJlcy4NCj4+
Pj4+PiArICAgICAqDQo+Pj4+Pj4gKyAgICAgKiBSZXR1cm4gdHJ1ZSBpZiBpb21tdWZkIGRldmlj
ZSBpcyBhY2NlcHRlZCwgb3IgZWxzZSByZXR1cm4gZmFsc2UNCj53aXRoDQo+Pj4+Pj4gKyAgICAg
KiBlcnJwIHNldC4NCj4+Pj4+PiArICAgICAqDQo+Pj4+Pj4gKyAgICAgKiBAYnVzOiB0aGUgI1BD
SUJ1cyBvZiB0aGUgUENJIGRldmljZS4NCj4+Pj4+PiArICAgICAqDQo+Pj4+Pj4gKyAgICAgKiBA
b3BhcXVlOiB0aGUgZGF0YSBwYXNzZWQgdG8gcGNpX3NldHVwX2lvbW11KCkuDQo+Pj4+Pj4gKyAg
ICAgKg0KPj4+Pj4+ICsgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51bWJlciBv
ZiB0aGUgUENJIGRldmljZS4NCj4+Pj4+PiArICAgICAqDQo+Pj4+Pj4gKyAgICAgKiBAaWRldjog
dGhlIGRhdGEgc3RydWN0dXJlIHJlcHJlc2VudGluZyBpb21tdWZkIGRldmljZS4NCj4+Pj4+PiAr
ICAgICAqDQo+Pj4+Pj4gKyAgICAgKi8NCj4+Pj4+PiArICAgIGludCAoKnNldF9pb21tdV9kZXZp
Y2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludDMyX3QNCj5kZXZmbiwNCj4+Pj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VRkREZXZpY2UgKmlkZXYsIEVycm9yICoq
ZXJycCk7DQo+Pj4+Pj4gKyAgICAvKioNCj4+Pj4+PiArICAgICAqIEB1bnNldF9pb21tdV9kZXZp
Y2U6IHVuc2V0IGlvbW11ZmQgZGV2aWNlIGZvciBhIFBDSSBkZXZpY2UNCj4+PiBmcm9tDQo+Pj4+
PiB2SU9NTVUNCj4+Pj4+PiArICAgICAqDQo+Pj4+Pj4gKyAgICAgKiBPcHRpb25hbCBjYWxsYmFj
ay4NCj4+Pj4+PiArICAgICAqDQo+Pj4+Pj4gKyAgICAgKiBAYnVzOiB0aGUgI1BDSUJ1cyBvZiB0
aGUgUENJIGRldmljZS4NCj4+Pj4+PiArICAgICAqDQo+Pj4+Pj4gKyAgICAgKiBAb3BhcXVlOiB0
aGUgZGF0YSBwYXNzZWQgdG8gcGNpX3NldHVwX2lvbW11KCkuDQo+Pj4+Pj4gKyAgICAgKg0KPj4+
Pj4+ICsgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51bWJlciBvZiB0aGUgUENJ
IGRldmljZS4NCj4+Pj4+PiArICAgICAqLw0KPj4+Pj4+ICsgICAgdm9pZCAoKnVuc2V0X2lvbW11
X2RldmljZSkoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50MzJfdA0KPj4+Pj4gZGV2Zm4p
Ow0KPj4+Pj4+ICAgIH0gUENJSU9NTVVPcHM7DQo+Pj4+Pj4NCj4+Pj4+PiAgICBBZGRyZXNzU3Bh
Y2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldik7DQo+Pj4+
Pj4gK2ludCBwY2lfZGV2aWNlX3NldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYsIElPTU1V
RkREZXZpY2UNCj4+Pj4+ICppZGV2LA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEVycm9yICoqZXJycCk7DQo+Pj4+Pj4gK3ZvaWQgcGNpX2RldmljZV91bnNldF9pb21t
dV9kZXZpY2UoUENJRGV2aWNlICpkZXYpOw0KPj4+Pj4+DQo+Pj4+Pj4gICAgLyoqDQo+Pj4+Pj4g
ICAgICogcGNpX3NldHVwX2lvbW11OiBJbml0aWFsaXplIHNwZWNpZmljIElPTU1VIGhhbmRsZXJz
IGZvciBhDQo+UENJQnVzDQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3Bj
aS9wY2kuYw0KPj4+Pj4+IGluZGV4IDc2MDgwYWY1ODAuLjM4NDg2NjJmOTUgMTAwNjQ0DQo+Pj4+
Pj4gLS0tIGEvaHcvcGNpL3BjaS5jDQo+Pj4+Pj4gKysrIGIvaHcvcGNpL3BjaS5jDQo+Pj4+Pj4g
QEAgLTI2NzIsNyArMjY3MiwxMCBAQCBzdGF0aWMgdm9pZA0KPj4+Pj4gcGNpX2RldmljZV9jbGFz
c19iYXNlX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPj4+Pj4+ICAgICAg
ICB9DQo+Pj4+Pj4gICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gLUFkZHJlc3NTcGFjZSAqcGNpX2Rldmlj
ZV9pb21tdV9hZGRyZXNzX3NwYWNlKFBDSURldmljZSAqZGV2KQ0KPj4+Pj4+ICtzdGF0aWMgdm9p
ZCBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oUENJRGV2aWNlICpkZXYsDQo+Pj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lCdXMgKiphbGlh
c2VkX3BidXMsDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBQQ0lCdXMgKipwaW9tbXVfYnVzLA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAqYWxpYXNlZF9wZGV2Zm4pDQo+Pj4+Pj4gICAg
ew0KPj4+Pj4+ICAgICAgICBQQ0lCdXMgKmJ1cyA9IHBjaV9nZXRfYnVzKGRldik7DQo+Pj4+Pj4g
ICAgICAgIFBDSUJ1cyAqaW9tbXVfYnVzID0gYnVzOw0KPj4+Pj4+IEBAIC0yNzE3LDYgKzI3MjAs
MTggQEAgQWRkcmVzc1NwYWNlDQo+Pj4+PiAqcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNl
KFBDSURldmljZSAqZGV2KQ0KPj4+Pj4+ICAgICAgICAgICAgaW9tbXVfYnVzID0gcGFyZW50X2J1
czsNCj4+Pj4+PiAgICAgICAgfQ0KPj4+Pj4+ICsgICAgKmFsaWFzZWRfcGJ1cyA9IGJ1czsNCj4+
Pj4+PiArICAgICpwaW9tbXVfYnVzID0gaW9tbXVfYnVzOw0KPj4+Pj4+ICsgICAgKmFsaWFzZWRf
cGRldmZuID0gZGV2Zm47DQo+Pj4+Pj4gK30NCj4+Pj4+PiArDQo+Pj4+Pj4gK0FkZHJlc3NTcGFj
ZSAqcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKFBDSURldmljZSAqZGV2KQ0KPj4+Pj4+
ICt7DQo+Pj4+Pj4gKyAgICBQQ0lCdXMgKmJ1czsNCj4+Pj4+PiArICAgIFBDSUJ1cyAqaW9tbXVf
YnVzOw0KPj4+Pj4+ICsgICAgdWludDhfdCBkZXZmbjsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICBw
Y2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmYnVzLCAmaW9tbXVfYnVzLA0KPj4+
ICZkZXZmbik7DQo+Pj4+Pj4gICAgICAgIGlmICghcGNpX2J1c19ieXBhc3NfaW9tbXUoYnVzKSAm
JiBpb21tdV9idXMtPmlvbW11X29wcykgew0KPj4+Pj4+ICAgICAgICAgICAgcmV0dXJuIGlvbW11
X2J1cy0+aW9tbXVfb3BzLT5nZXRfYWRkcmVzc19zcGFjZShidXMsDQo+Pj4+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9tbXVfYnVzLT5pb21tdV9vcGFxdWUsIGRldmZu
KTsNCj4+Pj4+PiBAQCAtMjcyNCw2ICsyNzM5LDM4IEBAIEFkZHJlc3NTcGFjZQ0KPj4+Pj4gKnBj
aV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCj4+Pj4+PiAgICAg
ICAgcmV0dXJuICZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4+Pj4+PiAgICB9DQo+Pj4+Pj4NCj4+
Pj4+PiAraW50IHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldiwgSU9N
TVVGRERldmljZQ0KPj4+Pj4gKmlkZXYsDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4gKyAgICBQQ0lCdXMgKmJ1
czsNCj4+Pj4+PiArICAgIFBDSUJ1cyAqaW9tbXVfYnVzOw0KPj4+Pj4+ICsgICAgdWludDhfdCBk
ZXZmbjsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2
Zm4oZGV2LCAmYnVzLCAmaW9tbXVfYnVzLA0KPj4+ICZkZXZmbik7DQo+Pj4+Pj4gKyAgICBpZiAo
IXBjaV9idXNfYnlwYXNzX2lvbW11KGJ1cykgJiYgaW9tbXVfYnVzICYmDQo+Pj4+PiBXaHkgZG8g
d2UgdGVzdCBpb21tdV9idXMgaW4gcGNpX2RldmljZV91bi9zZXRfaW9tbXVfZGV2aWNlDQo+Pj4g
cm91dGluZXMNCj4+Pj4+IGFuZA0KPj4+Pj4gbm90IGluIHBjaV9kZXZpY2VfaW9tbXVfYWRkcmVz
c19zcGFjZSgpID8NCj4+Pj4gaW9tbXVfYnVzIGNoZWNrIGluIHBjaV9kZXZpY2VfaW9tbXVfYWRk
cmVzc19zcGFjZSgpIGlzIGRyb3BwZWQgaW4NCj4+Pj4gYmVsb3cgY29tbWl0LCBJIGRpZG4ndCBm
aW5kIHJlbGF0ZWQgZGlzY3Vzc2lvbiBpbiBtYWlsIGhpc3RvcnksIG1heWJlDQo+Pj4+IGJ5IGFj
Y2lkZW50PyBJIGNhbiBhZGQgaXQgYmFjayBpZiBpdCdzIG5vdCBpbnRlbnRpb25hbC4NCj4+PiBD
YW4gaW9tbXVfYnVzIGJlIE5VTEwgb3Igc2hvdWxkIHdlIGFkZCBhbiBhc3NlcnQgPw0KPj4gSSBk
aWcgaW50byB0aGUgaGlzdG9yeSBjaGFuZ2VzIG9mIHBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19z
cGFjZSgpIGFuZA0KPj4gYmVsb3cgY29tbWl0IGFkZGVkIGlvbW11X2J1cyBjaGVjay4NCj4+DQo+
PiA1YWYyYWUyMzA1MTQgIHBjaTogRml4IHBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZSgp
IGJ1cw0KPnByb3BhZ2F0aW9uDQo+Pg0KPj4gSW4gdGhlb3J5LCAhaW9tbXVfYnVzLT5wYXJlbnRf
ZGV2IHRha2UgcHJlY2VkZW5jeSBvdmVyICFpb21tdV9idXMsDQo+PiBTbyB3ZSBuZXZlciBzZWUg
aW9tbXVfYnVzIE5VTEwsIGFzc2VydCBtYXkgYmUgYmV0dGVyLg0KPg0KPkkgdGhpbmsgd2UgaGFk
IHN1Y2ggYSBkaXNjdXNzaW9uIGluDQo+aHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9xZW11
LWRldmVsQG5vbmdudS5vcmcvbXNnOTk0NzY2Lmh0bWwNCj5CdXQgbWF5YmUgdGhpcyB3YXMgcmVs
YXRlZCB0byBhIGRpZmZlcmVudCBjYWxsIHBsYWNlLiBJIHJlbWVtYmVyIEkNCj5jaGFsbGVuZ2Vk
IHRoZSBjaGVjayBhdCBzb21lIHBvaW50DQoNCkl0IHNlZW1zIHRoaXMgcXVlc3Rpb24gaXMgbm90
IGRpc2N1c3NlZCBmdXJ0aGVyIGluIHRoYXQgdGhyZWFkLg0KUGVyIG15IGNvZGUgaW5zcGVjdGlv
biwgUENJIHJvb3QgYnVzJ3MgcGFyZW50X2RldiBzaG91bGQgYmUgTlVMTCwgc28gd2UgZ2V0DQpl
aXRoZXIgcm9vdCBidXMgb3Igc3ViIGJ1cywgbmVpdGhlciBhIE5VTEwuDQpBbHNvIHRlc3RlZCB3
aXRoIFBYQiBicmlkZ2Ugd2hpY2ggaXMgc3VzcGljaW91cyBzY2VuYXJpb3MsIHNhbWUuDQoNClRo
YW5rcw0KWmhlbnpob25nDQo=

