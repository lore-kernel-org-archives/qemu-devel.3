Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52A5C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUSI-00082S-ND; Mon, 26 Feb 2024 01:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reUSC-000823-Sg
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:27:09 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reUS9-0001rz-Jp
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708928826; x=1740464826;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OvBgDKD6NnpJa/6O+1OiH8uQC11ZAj4Rc6qCTq6fY8Q=;
 b=U0JdSZm+VgwywZD9tgsR9wvvox0bS4JqMLlQnfkUc5cTGq+mJDveO1dt
 nX/VsvQnv0QPYLoJnqBDU5HXk1QqzpDlGS4K8Vlr28DpZYryg1B8anbkz
 hhrU/fPkY01be26LqkhVv2r5KezKaflfrRf2GyyCPHD5HTzKziLAuKgF1
 1wtSp2oO6FbrA+CUELUA+d6ffV2YV//QwuCv7ye0I7jihZLJRpF0xJatq
 V+jzjowot8mHYSchJdIdTyzS1Czn4KB3xGvYf94WrLPLkpOhqMX2qEkJK
 NF24kuXHLQIrfivAFAOC+vYZYRL/d3wyz/mmBk/JZjLw5uwIC6AwIediE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="7012238"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7012238"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 22:26:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11203295"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2024 22:26:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 22:26:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 22:26:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 22:26:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1Zh2rQuQrQih0oKkPGDdb8TVjMb9kW+YF8lVw14oDpj9sUQf9VXm9YP6UwvZNG4gEsCkJkEbIv1F2mJtYvQIk6/tUIv21x2Kwy/QVvhFw7Yc7g/SEopLChV16039hTVBFN6atbFLe+PRbtPUP/DVHAf/GBVdmINapu1uVumMSSgx54trxsnx4uyKL6U27XHe4xy7Eike8wXnhk85RxDMHfA6h6hY94WaAGekemSj2SoYp/XCQ1Jce4enA12YPlktX422fIt+sGB6OZcc0ZEm6m/Q1MRyj3ycyi1jOegMNqzrfLrQFHwVjGzXI3oLpNedVKi00mgdM3GCGgXPiwmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvBgDKD6NnpJa/6O+1OiH8uQC11ZAj4Rc6qCTq6fY8Q=;
 b=mVSHUSYxAxR1HdrGl8w3xeIP3EVce4V+xQgFft26+2lsWyXOcbJw2xmW+hdM4IrkhZElThuDIjDj9NC0MEtf0OjDcA6bDnD+QywOQQICM5JLohnqRJmYe33B5yxKUsNmm//KU0Hv6e/qNgkIsaGNZV7ktE1Mu+EyURZU7+aUMYDJYAOpMRiUMWzlxszuE9kLF7J06kr/J+gWiDlPeBhVTg9+hF7el9F5jcUq1H3OsxzNJtSHxOG4NG2Z6iii0VcB6BGG61vV5MxwzigISdCj+iIkJoN36H9OExdPKyeDcGUmtXw20H4mxAKBlW26rO0aZ+sYHWUWwONbNlRe6WVnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 06:26:54 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 06:26:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv2 10/18] hw/pci: Introduce
 pci_device_set/unset_iommu_device()
Thread-Topic: [PATCH rfcv2 10/18] hw/pci: Introduce
 pci_device_set/unset_iommu_device()
Thread-Index: AQHaVOCq2FLNKBIXzE+3oQJQkkR4Y7ESC+qAgApCxwA=
Date: Mon, 26 Feb 2024 06:26:54 +0000
Message-ID: <SJ0PR11MB67449670196C3A3792CE552C925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-11-zhenzhong.duan@intel.com>
 <7b1de385-a79a-4a91-b0f6-ba6b32894b71@redhat.com>
In-Reply-To: <7b1de385-a79a-4a91-b0f6-ba6b32894b71@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV3PR11MB8602:EE_
x-ms-office365-filtering-correlation-id: 8424e67d-0cce-410e-9748-08dc3693ecdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dkxKjNTMMC5Do+yKNyts2/bSLXZdhYPZsTe/3h3f+2NzfzTuAd0DWDhgWiR6jbtbmmiPSDScRsJPHmAMK90ePZ808qNx+plbxnEI2Brggzv8cCap7F4Wgm8E+UJ1q5bhT1le6grTVtvlegbXryaRUDoekkei/xVJYvV03qrgUuVAZdo1tXG/Y7JKRTSEY0GEUMQvVfUx/Ycqd32TqSjoqlXhfBUxVDJgKpR7EzXt4iTa5HA445UKQ901+In9GwehBeqBLWJm7c6xMYzC/g3nQCebfkm4EulnxqtLQqSo6wPSxplJ+y2pjKi5pEL1MDesuNN2zNDh9NhPXEmpgpD3fdKA8XtE71/6pVYaWIp6G9vgmm3UD2U9BW9DkKwMG1J4zyJPueTgWvcipvZsda9QQvjLOv+twF9Qi4ITPezoeYnojjv88ukW/3+a0kB71l1Jnstfdt+P+BRbhcJibyATTx9IgXUozvLHzhH1MFofCOLhHEpBqqVgeqe/S9oD1T7dyOjWkmWp3ahc2+BDvsOSGl4UpL5meQnstcMxZ7qQfKTAI5xwn5cVz3HAUbb7HRjL2CFIxYSDyTJHBKo4UeVKulwuSui95gFtHlsasDpDToUsvIuRpqtG0ptT6W1NUzVXJJAxcrNKu1/w+tAiJu2qE6sk7Z7vafNE3lFZZBTk39MVLDLEq59A5f4wKWoDcoHvTkqk6BY1seAxxysexIpEK060JbqaQL1TisTf9xqnMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3F1aUQ1d21LeHN0RzE3akROZU1iME8yeUpscmZ5b01BeUJYbk9WKzFmQVJh?=
 =?utf-8?B?cU1TaUxjb3VxbUI2ZDBrL0xZeTNmNlhPendqKzdEQThxaXZ1UW1HaWtHT09v?=
 =?utf-8?B?OFhINjlEVnhWZ2Z4b2o2YzFNaEg5d29GU2IxOGpmRFFPZjh3d0l6NkxvdkFS?=
 =?utf-8?B?eGtZRmRBWEhMMFJnS3BnQmFxM0hRaFdBd09wS2RIK09NaFVIendHNzlvbjBq?=
 =?utf-8?B?UmlDeGpPc1ViaFQ3c0NZY1VjNjM0ZmU3aHYzRTVBeXpPODltSytPRUsyZmM2?=
 =?utf-8?B?dHhIaVJYeWFua2lYbXZOci9leEhZdmFNM0ZuY1VlNGNTb3UxdnBBdXNSa0tL?=
 =?utf-8?B?OUlJSkJiYVhUV0JsbmtMOTJDS2c1YVdVMzZBN0E0MUU4SGZXQVRGNzREenRC?=
 =?utf-8?B?TDZXaXJLakg0R2pNdDRJMmNvYnlRNC9UVC9DVGxnN1VLTjNtVmhzczltQkNn?=
 =?utf-8?B?K3UzdHI3UFhoQnQ4RlRRQWt6MUg1bFlpcFhDRkdFa2FlOUt6cXlzZE95bDVC?=
 =?utf-8?B?TzJyaDhzbWE0YkE0RkdBbnFobW1MOWZmSkdqUHgwVUhLWmhtdDlydmM0K2Rt?=
 =?utf-8?B?NUhoWlR3WTZBbWsyeXE1OEZQdDU3WGIwNXk2cUVJZmRsckE2UHl5ZUpFbklF?=
 =?utf-8?B?MUQ5aUhoR2tyclNlYmFvNHJXdjlhbWxNOW1ueFg1NC9ZQ2ZiQ29iRm56RzlU?=
 =?utf-8?B?a1AxMGt2dG1Ea01YcGY2WWo3akFEbVMydUtPWXdSUVdTQ3k4R0p6b3RQUy9E?=
 =?utf-8?B?Wmk4c3FmZjJ1VHlFcTB0d0dqMzhmV0dqMHZhZHVvZkRDNzMwQTFWSzJaMndk?=
 =?utf-8?B?ajlnUC9LRkpHSDBxOTBaU1dUaDNTN3R0SVdzN3R3a0FSNSs5c2FucVN5MVZl?=
 =?utf-8?B?bDZtVHdlTU9mL21kVXJML3Z1UGxLd0xDY010eEZtSnZoZGU1K0trU1R3T1p5?=
 =?utf-8?B?bUxrR1dHS0FLQnE1TEVxWW8xWGRLb0RxVVBCMloxU1llOVlnK2YyVHQvMnVp?=
 =?utf-8?B?MnlnMmVPVHNHZ3h5NlpabFRaZXF5UnBxcldvZnM0OVJRUVZZWWZUN1JQY0ZQ?=
 =?utf-8?B?OC9UYm53b0xPU0VqWm5PMXI1WUJCQWxRVDJlbWhmeUNSdy9WMFArSDhQSFU2?=
 =?utf-8?B?ZFJyZVhYSFVJSUxFTWVDbnpXSUVmVUlYUWlQSWxwR3c3RWJCWmlXU09uNWMw?=
 =?utf-8?B?ZGsxa2w4RWd4cHV6MmRLR25KcFVOc3oydGVGVWFTbW9HR0NNYWhGQkNZS0dY?=
 =?utf-8?B?UzFPZDVCQzFTTkJXWnVlYll3U3dVeU10bHpMNThNSDA3bnhUWmtrdjdkMkYw?=
 =?utf-8?B?cHo5bmNDVTNlWVhLQVY4VDJaWGlPUW9uTEZJUnR3emsxZmdLemFvampCM1px?=
 =?utf-8?B?RGRnRVBTSEMyTm8wcmpTR3UrcXFPNVU3eUtRdHBHek9JVUtXUUlmNzVqalVL?=
 =?utf-8?B?NkZBVmlPczFLMGhPd2RpRkdUbGlKZnd0VHBvbU1DTXErMkxFT1ZmbnpFZktu?=
 =?utf-8?B?UHBjS3hCeDB2eW1SQkFBVHZDQm95SGtqMUFuZXo2U2VxNGlZY0orbVM0bXJK?=
 =?utf-8?B?ajZvU0VxRkR5b2Fjb2JreXpBaUxBNTFpak80VS9KSGhSZ2dGc0VYQmtNc3VJ?=
 =?utf-8?B?c2FmZ3JDZmljTzBvSWJWYkRnRVFwdnVZbmRZaWlnODJVZDU4UzY4cTZxczhI?=
 =?utf-8?B?cVlJTXFReUJWZ2tvRUtvTmFhWUNiSUN2ODNRU2g0RU1KLzFEN0ZJeEhtVHE5?=
 =?utf-8?B?eDZ3Vm9TMjdiNHZTVDhJejllVEUyNHRlOW9sc3BwVjRVRS9jZjBtcFpibDRI?=
 =?utf-8?B?RHpmOE1NK0lnV3ZCc3RZbWFCdTBHaE1YSGtkVURZMWhMV2VPVEtrQkNGZ0t1?=
 =?utf-8?B?SFJvSUM1ZFowYUpiYXBTMDFYMkNpZW92RE1zdktkQ2xOTFdHMW9mUDlmeVhS?=
 =?utf-8?B?ZGZydDVUekl3U2kzYThjRFFIMElhWU9ZUHlITmVCRktGdDJFNHlrdTRUOGxl?=
 =?utf-8?B?YkF2WXNqU1E3Rk5UVFFJS1VpbmQ4anlUY2t3RHRHenhiL1NwWjZHVWFGdnNU?=
 =?utf-8?B?a3lya1ZJU0xwSDZWd2FlaDRTTktWY3pBWitpbXV1QTlIMlVsNzQvRFpDYytX?=
 =?utf-8?Q?ycDlpbOj3hTNnPKSc0W9Xv+Jf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8424e67d-0cce-410e-9748-08dc3693ecdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 06:26:54.1215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuK6mOoWhfVXtQBpTIdz+hl/LR3pd4DCq9f4o0NjRbOXFkHlqenkooFPYJnRRCH42Lwhgl2m4P9w4havAMvByj5MFGzoKTAJlLXw1hNj6Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YyIDEwLzE4XSBody9w
Y2k6IEludHJvZHVjZQ0KPnBjaV9kZXZpY2Vfc2V0L3Vuc2V0X2lvbW11X2RldmljZSgpDQo+DQo+
SGkgWmhlbnpob25nLA0KPg0KPk9uIDIvMS8yNCAwODoyOCwgWmhlbnpob25nIER1YW4gd3JvdGU6
DQo+PiBGcm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+DQo+PiBUaGlzIGFkZHMg
cGNpX2RldmljZV9zZXQvdW5zZXRfaW9tbXVfZGV2aWNlKCkgdG8gc2V0L3Vuc2V0DQo+PiBIb3N0
SU9NTVVEZXZpY2UgZm9yIGEgZ2l2ZW4gUENJZSBkZXZpY2UuIENhbGxlciBvZiBzZXQNCj4+IHNo
b3VsZCBmYWlsIGlmIHNldCBvcGVyYXRpb24gZmFpbHMuDQo+Pg0KPj4gRXh0cmFjdCBvdXQgcGNp
X2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKCkgdG8gZmFjaWxpdGF0ZQ0KPj4gaW1wbGVtZW50
YXRpb24gb2YgcGNpX2RldmljZV9zZXQvdW5zZXRfaW9tbXVfZGV2aWNlKCkuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE5p
Y29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56
aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBpbmNsdWRl
L2h3L3BjaS9wY2kuaCB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gIGh3L3Bj
aS9wY2kuYyAgICAgICAgIHwgNjINCj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kvcGNpLmggYi9pbmNs
dWRlL2h3L3BjaS9wY2kuaA0KPj4gaW5kZXggZmE2MzEzYWFiYy4uNWI0NzFmZDM4MCAxMDA2NDQN
Cj4+IC0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L3BjaS9w
Y2kuaA0KPj4gQEAgLTMsNiArMyw3IEBADQo+Pg0KPj4gICNpbmNsdWRlICJleGVjL21lbW9yeS5o
Ig0KPj4gICNpbmNsdWRlICJzeXNlbXUvZG1hLmgiDQo+PiArI2luY2x1ZGUgInN5c2VtdS9ob3N0
X2lvbW11X2RldmljZS5oIg0KPj4NCj4+ICAvKiBQQ0kgaW5jbHVkZXMgbGVnYWN5IElTQSBhY2Nl
c3MuICAqLw0KPj4gICNpbmNsdWRlICJody9pc2EvaXNhLmgiDQo+PiBAQCAtMzg0LDEwICszODUs
NDUgQEAgdHlwZWRlZiBzdHJ1Y3QgUENJSU9NTVVPcHMgew0KPj4gICAgICAgKg0KPj4gICAgICAg
KiBAZGV2Zm46IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyDQo+PiAgICAgICAqLw0KPj4gLSAg
IEFkZHJlc3NTcGFjZSAqICgqZ2V0X2FkZHJlc3Nfc3BhY2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpv
cGFxdWUsIGludA0KPmRldmZuKTsNCj4+ICsgICAgQWRkcmVzc1NwYWNlICogKCpnZXRfYWRkcmVz
c19zcGFjZSkoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50DQo+ZGV2Zm4pOw0KPj4gKyAg
ICAvKioNCj4+ICsgICAgICogQHNldF9pb21tdV9kZXZpY2U6IHNldCBpb21tdWZkIGRldmljZSBm
b3IgYSBQQ0kgZGV2aWNlIHRvDQo+dklPTU1VDQo+YXR0YWNoIGEgSG9zdElPTU1VRGV2aWNlIHRv
IGEgdklPTU1VDQoNCldpbGwgZG8uDQoNCj4+ICsgICAgICoNCj4+ICsgICAgICogT3B0aW9uYWwg
Y2FsbGJhY2ssIGlmIG5vdCBpbXBsZW1lbnRlZCBpbiB2SU9NTVUsIHRoZW4gdklPTU1VDQo+Y2Fu
J3QNCj4+ICsgICAgICogdXRpbGl6ZSBpb21tdWZkIHNwZWNpZmljIGZlYXR1cmVzLg0KPmxvb2tz
IHRvbyBpb21tdWZkIHNwZWNpZmljLiBUaGVuIHZJT01NVSBjYW4ndCByZXRyaWV2ZSBob3N0IGlu
Zm9ybWF0aW9uDQo+ZnJvbSB0aGUgYXNzb2NpYXRlZCBIb3N0SU9NTVVEZXZpY2UNCg0KV2lsbCBk
by4NCg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBSZXR1cm4gdHJ1ZSBpZiBpb21tdWZkIGRldmlj
ZSBpcyBhY2NlcHRlZCwgb3IgZWxzZSByZXR1cm4gZmFsc2Ugd2l0aA0KPnMvYWNjZXB0ZWQvYXR0
YWNoZWQNCg0KV2lsbCBkby4NCg0KPj4gKyAgICAgKiBlcnJwIHNldC4NCj4+ICsgICAgICoNCj4+
ICsgICAgICogQGJ1czogdGhlICNQQ0lCdXMgb2YgdGhlIFBDSSBkZXZpY2UuDQo+PiArICAgICAq
DQo+PiArICAgICAqIEBvcGFxdWU6IHRoZSBkYXRhIHBhc3NlZCB0byBwY2lfc2V0dXBfaW9tbXUo
KS4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51
bWJlciBvZiB0aGUgUENJIGRldmljZS4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQGRldjogdGhl
IGRhdGEgc3RydWN0dXJlIHJlcHJlc2VudGluZyBob3N0IGFzc2lnbmVkIGRldmljZS4NCj4+ICsg
ICAgICoNCj4+ICsgICAgICovDQo+PiArICAgIGludCAoKnNldF9pb21tdV9kZXZpY2UpKFBDSUJ1
cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbiwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgSG9zdElPTU1VRGV2aWNlICpkZXYsIEVycm9yICoqZXJycCk7DQo+PiArICAgIC8q
Kg0KPj4gKyAgICAgKiBAdW5zZXRfaW9tbXVfZGV2aWNlOiB1bnNldCBpb21tdWZkIGRldmljZSBm
b3IgYSBQQ0kgZGV2aWNlIGZyb20NCj52SU9NTVUNCj5zYW1lIHN1Z2dlc3Rpb24gaGVyZQ0KDQpX
aWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

