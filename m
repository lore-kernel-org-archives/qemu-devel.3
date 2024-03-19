Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DBBC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSmj-0000z7-HD; Tue, 19 Mar 2024 02:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmSmV-0000vT-CW
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:17:05 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmSmS-0003dk-SU
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710829021; x=1742365021;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+5ZpDQ8PvTSXTgsS6ipsMW0+0CtX1rjGc3f4/+UNr1s=;
 b=Og4lulnpocsddzauiRL5cyMZ+k6dz/r1NKyLpTik251i0neuk/GOEFnw
 fhOsPLDknBhUjM7uGaJXD4q0jwaaeELo/v9fQdYUhdeFufpw0oO/rOeAo
 LkkrwbJe7IJXwtdcrg5PMxxPDwaFO1pRdXF2snsw6CRXLgIIal3luIYLA
 2S96fImTdZNWgwZn2IOMKNIJ9FBOpdKUG71fvabqR2DnD4eQUBw45Je5D
 xT90A5tT6r5jN4xnVydoxQcMrcY7ZV/lrgjQsI/UDqvZL0u1KDhwic2as
 r1PZ8zGM2PIqG5/QqlelI3fABEYQhsl/rBC/FHrXYBO0054nEKFm8gYfU A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5525697"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5525697"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 23:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; d="scan'208";a="18425644"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 23:16:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:16:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 23:16:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 23:16:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auwL14FKMDjHMfvfV8rG2Yf8Vuvt+qLkA5KMZba/Vbo8Mea4Q0L4KHKLy2AWKjBgQrlO6/yWoIUsFiTbCYT0eMyEfItc/yCIbiJjjq7C6vn7XZ1Jn5+h5lNqVxS1LD5nnZQaqgsdVfpt3dKItAQZbECYZpf9DBVrsPRBqFguh/95PJMExku/Ie4LfnRLqxWBLWDPMK8kVYQ601Ogv3jGn3DdGjgCWxGU+I/3NOK6Q2p+UK4gfKCoyfjlI5SAELDGt7ftM1NSR0CMEtxMWGKH858xIaam+e0iJy6kyyQoMpQABDmLCSBz8m59ClR4XxzpIOQ21PFpqxy5yj202xiMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5ZpDQ8PvTSXTgsS6ipsMW0+0CtX1rjGc3f4/+UNr1s=;
 b=CQ5/78iLy26izWixpB4AoliwMSzRdkZDPdMoZYP4aZsfRXHpE5x3v5xWhT0YveFYvlMTGoA5Kh8aCP0dO5/1DxOmcuhCPd7F0+dVab5sss5JwV+B3i0Y6OFVzqBdxXdtXwVUop5Wela05JLXM3IveJwy7RsneancaaozHTMXnvz1Bav8cc714bAURfb3BI7OHDaXpwNl6praECxN22yxHScDLP58AQ4f+/bZFSOkwAzQFTmiN2JULAGcpY3HFibS2raQlwT6/UACQHUCjX6BHSkvgbWzl0PjvVZMsw0NHo2+h7QgEt3xA7fnBMuo1k9QwW1KaYu+HGYM7GgkodCuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB7304.namprd11.prod.outlook.com (2603:10b6:8:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Tue, 19 Mar
 2024 06:16:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 06:16:32 +0000
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
Subject: RE: [PATCH v1 09/11] hw/pci: Introduce
 pci_device_set/unset_iommu_device()
Thread-Topic: [PATCH v1 09/11] hw/pci: Introduce
 pci_device_set/unset_iommu_device()
Thread-Index: AQHaafrffyVIW20JqUKVpBznbzhisbE9svGAgADbUYA=
Date: Tue, 19 Mar 2024 06:16:32 +0000
Message-ID: <SJ0PR11MB6744FF5108788299DAA007E9922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-10-zhenzhong.duan@intel.com>
 <12e21f3f-c425-4f8a-9dd9-d81f95afb4fd@redhat.com>
In-Reply-To: <12e21f3f-c425-4f8a-9dd9-d81f95afb4fd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB7304:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jdx6XVHQTj/NunBmlHTuP/6kFGnhI/2TlQuCGM/ZBQaAOlnnfrQzISKrZoQZCJBr8k8dyIS9PBOD0qn/LLBe1eiW/6ZCP9IeIYqnHrzDoFIwiRpwYagPk67YIk7f79AH10AQx2UUhNm5hyAfWXYa/Uw1xtnpvQOYk096xspW7K00/pl5rFGAAeJJGjHvAYC+nneiFa+8hJgjBgArJZXm3GxK1IkcC3p631ChrvRNyJHD/qxulmDitbwDUW+EPiUWQ9xq36XAqLUu2uH78F7L25E+2rncRdrmTPBwU6is5wd9os2WNIcAwbGURPtPIUSRYPlv6mu3Dmsg8Ur2D3G2/VmJyajCL7ecPQ4tk4h//iCN6QVuiYuoVLeTlGB15qinmna6dUnS8lEQQCCqOPV6ASB4X92UQcnsvZHZsLfxOpKAnuGh3KdFXx40Eg7UOQNpNWhnW8ZKMFWXVB+JGfKgasDIJBvecU0PydF4Q5niA/DVA/Id0R6LamOVLDB4J4ubTUTdt/4sz/bFSa1uSzQFXi5JO6EKnwBZ/jMwvD5EWIf3CbmYd3Z6RAXjIE1DLVolh+Q8SrJ9TII4C4BcT09cYlmD4BGn06H+pvVzuka/B270v0FhdGOvtxnlDabmZTbYP/fOsjh6sGMZIjDi2IJpjCJnxV4zPGbvhxEJB4GlB4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnM1RlhzRHZTcUxGcW9hS1g4WXprQTRXL0dPYlhwREZVc0k5NlErdWhacURN?=
 =?utf-8?B?NFJRaFZ3VTYxMzBVRVBMY3lUYmJ6cmRxWkl0YkkzK2NiWmpkbkxrcjd5REda?=
 =?utf-8?B?TjRHc3l5dzBuUTVkbkwrU1hXQ3JlTHo4aVJQTFFoT05wWGpBT2lUOUVlZnhS?=
 =?utf-8?B?SDNZcENPNWdXRTNrMmpNS0hEc2t6MTh5dXhBVkVIUGFmSU44L2VJRERRSVRz?=
 =?utf-8?B?R3ljWExjTkFyLzh4ZWRpZktMOCtFZTFVL2M0ZklKc1NnWEN6M041Ykw4WStE?=
 =?utf-8?B?Y3VTeVg4elQ0TGswWVhQbW5BclF4b0g1dGkxS2ZIRmo3azZIMytoZUJHc2xP?=
 =?utf-8?B?N3pxcXBBRmozOW96aWlFZTVUQVZqNTJ5WllCdU1HU2ptUWVmSENaNDJYblhH?=
 =?utf-8?B?UnAzWS81cHcrN2NXVU5iOHU5ZFI5YUo4UGZ5Q3JPQUJkaEVmWnhwam1xM0tB?=
 =?utf-8?B?QXhkYjgveTFRR0hmM3FJSnlyMlNYZStxREZqWndaYy85OTUzNW14Wll0VVBa?=
 =?utf-8?B?YlZJTzNKNEZxelRybTc3WEU4UE9OaFR6eVlxS1pQSFpxOXlnTFpCQ2pGRmNw?=
 =?utf-8?B?TGlPVDEvUzRhV3RGLzU1OTdEWFlQRmxzZ1YwNjIzcHpVNDBlcDgxdU8wdXZF?=
 =?utf-8?B?bnY4VnF2MDNod29DVzZUMWs2SEJEQkF4eisrVVBhQy9kNEVtTnh0YlZlOGNS?=
 =?utf-8?B?VVZ3bGZhMi9IY2FWRmFLUkhIazdlSjRaRnlCRVpnRHNQRk1BdDYwYStnbEF1?=
 =?utf-8?B?T29ya1poT1laSGw1bjNEcW1iZ01laXlVZnBCcGMwTnlxWkw4WCtLUzZNV2ZY?=
 =?utf-8?B?MHNGUkF2ZWcwVE5vSnFWZ2F5dmhRaHplU1NvT3J2ME5nRGhCVHc1M1hRaVZ0?=
 =?utf-8?B?cmY5aVJKazBNbkFhM1NkRjlkdW92dXFkam1TakhkMVNHNnRROVFZNDJiNlNu?=
 =?utf-8?B?SzZVaUwxVGlLSVVhdSt4UDl3SWQyRis2VDVSUFd3VDZMY3lZQkI1UE5JMjJ4?=
 =?utf-8?B?ZmpsNnZqYTdmSnVZelEyN3hHYTErVE1HRi91Y0x1TDllZEtnZ2NWQ3EybTgy?=
 =?utf-8?B?SHNwc1VPdjc5V0prNGVDdmpqYytSbHdub2pROWxIRGp1SkdKRkRISmVjcDl3?=
 =?utf-8?B?RUhvYXVwWXVPbnpUMFd6cVVoMDFxZmN4WXBjSWhydUVlWFBKSU41cTR5ZGtw?=
 =?utf-8?B?T3liZUNFVXZlRytwUHVOZDAzNUI3bUFwemR5R2FaeVdtOGV3Sm5iOE9tT25J?=
 =?utf-8?B?dDdERXhEc1h6TG9qUUJpdUE1bVZaZzZ3RktKVkhFN1dULzYzUWkwMGtLZUF0?=
 =?utf-8?B?SXV3a2ZMSFBLbUUxV0pDSG40czdqblYvMkNHWHRPWmZGdElxRVRzMnZadDZy?=
 =?utf-8?B?WHpxUzJIVUtwZEsrSzdKQ2NBWktIaXVRTUpBbGNKd1M3dkp4aVM0OWFYOUUw?=
 =?utf-8?B?VmxKMWxZRkQzYVBNaUNHaENSeWFxRnVyRVgrblU5M04yKzhUS0NSVmhHbWRL?=
 =?utf-8?B?S3FwSE83S3IvR094alJXNzl3OEhUYzlYeDB1SmtlekoyU3hIYmwzQWh3ak9q?=
 =?utf-8?B?YlkzWGcvWXFra3FMRU53VjhhOXlCbmRHYUxZMEpBK1pBVDdBNkh0SGU1ckhH?=
 =?utf-8?B?ckxMOWZwN1NSdFVscVZCSkNBbDA4MnBITGdsaitpRDV0NXBsSG5hNmkrYVBw?=
 =?utf-8?B?VHFHVjBQTnk2dDlyaXg5ZGdSaGlITGl0Z2wzQmFFbFFxU2JJMG1jbW1HNERO?=
 =?utf-8?B?WGJtZ3hKQnMwd0pyaWZQVjBUM1Uwc0dHV2F4MElzRTdyM0NkTHFjTkVtZVd4?=
 =?utf-8?B?cnEzVXVnbTh1Nzk1Vm5TSndoWHhlOHR1VEhVTjN5UGdKYW1MNHFaeVNNNWNU?=
 =?utf-8?B?WWs4T3BzWUlnT05HWTQxNDVmWm9BcXkva3o1YkY2c3QzK2l1L0dLRGhzcGQ5?=
 =?utf-8?B?K1A5L2NSU3JqazN5eTNlYm80WGxwQWV0Y0Z0Rk5MYkZVN01KTnIwc1M5dkVi?=
 =?utf-8?B?MnYzVDJxQVdZMDZyN0ZLZzFPSHJPVnBYR1pkUEpUQnNKOU95c3FXeTVjSEsz?=
 =?utf-8?B?alVHT1p1UlVQdk9FTDVpUkhydVVTMHZTTVQrTkNReHJibHhqelJOdzk4NUpF?=
 =?utf-8?Q?VjbeI/26qzNoDsrVR4f11edHZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9f6a85-f78c-4699-845a-08dc47dc1f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:16:32.6028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3U2bAjr0a/e79T605Qh1nhvSmnWSsfLFt18XzaJ0sL1EOs5wH7mAYmreFW8T5/5WWG19LJDqP+gkfzqaExyE1SSZhVoaIBUmiRdcBldAMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7304
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDA5LzExXSBody9wY2k6
IEludHJvZHVjZQ0KPnBjaV9kZXZpY2Vfc2V0L3Vuc2V0X2lvbW11X2RldmljZSgpDQo+DQo+SGkg
Wmhlbnpob25nLA0KPg0KPk9uIDIvMjgvMjQgMDQ6NTgsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0K
Pj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pg0KPj4gVGhpcyBhZGRzIHBj
aV9kZXZpY2Vfc2V0L3Vuc2V0X2lvbW11X2RldmljZSgpIHRvIHNldC91bnNldA0KPj4gSG9zdElP
TU1VRGV2aWNlIGZvciBhIGdpdmVuIFBDSWUgZGV2aWNlLiBDYWxsZXIgb2Ygc2V0DQo+PiBzaG91
bGQgZmFpbCBpZiBzZXQgb3BlcmF0aW9uIGZhaWxzLg0KPj4NCj4+IEV4dHJhY3Qgb3V0IHBjaV9k
ZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbigpIHRvIGZhY2lsaXRhdGUNCj4+IGltcGxlbWVudGF0
aW9uIG9mIHBjaV9kZXZpY2Vfc2V0L3Vuc2V0X2lvbW11X2RldmljZSgpLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
WWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOaWNv
bGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhv
bmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9o
dy9wY2kvcGNpLmggfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+ICBody9wY2kv
cGNpLmMgICAgICAgICB8IDYyDQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVk
ZS9ody9wY2kvcGNpLmgNCj4+IGluZGV4IGZhNjMxM2FhYmMuLjhmZTZmNzQ2ZDcgMTAwNjQ0DQo+
PiAtLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9wY2kvcGNp
LmgNCj4+IEBAIC0zLDYgKzMsNyBAQA0KPj4NCj4+ICAjaW5jbHVkZSAiZXhlYy9tZW1vcnkuaCIN
Cj4+ICAjaW5jbHVkZSAic3lzZW11L2RtYS5oIg0KPj4gKyNpbmNsdWRlICJzeXNlbXUvaG9zdF9p
b21tdV9kZXZpY2UuaCINCj4+DQo+PiAgLyogUENJIGluY2x1ZGVzIGxlZ2FjeSBJU0EgYWNjZXNz
LiAgKi8NCj4+ICAjaW5jbHVkZSAiaHcvaXNhL2lzYS5oIg0KPj4gQEAgLTM4NCwxMCArMzg1LDQ1
IEBAIHR5cGVkZWYgc3RydWN0IFBDSUlPTU1VT3BzIHsNCj4+ICAgICAgICoNCj4+ICAgICAgICog
QGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51bWJlcg0KPj4gICAgICAgKi8NCj4+IC0gICBB
ZGRyZXNzU3BhY2UgKiAoKmdldF9hZGRyZXNzX3NwYWNlKShQQ0lCdXMgKmJ1cywgdm9pZCAqb3Bh
cXVlLCBpbnQNCj5kZXZmbik7DQo+PiArICAgIEFkZHJlc3NTcGFjZSAqICgqZ2V0X2FkZHJlc3Nf
c3BhY2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludA0KPmRldmZuKTsNCj4+ICsgICAg
LyoqDQo+PiArICAgICAqIEBzZXRfaW9tbXVfZGV2aWNlOiBhdHRhY2ggYSBIb3N0SU9NTVVEZXZp
Y2UgdG8gYSB2SU9NTVUNCj4+ICsgICAgICoNCj4+ICsgICAgICogT3B0aW9uYWwgY2FsbGJhY2ss
IGlmIG5vdCBpbXBsZW1lbnRlZCBpbiB2SU9NTVUsIHRoZW4gdklPTU1VDQo+Y2FuJ3QNCj4+ICsg
ICAgICogcmV0cmlldmUgaG9zdCBpbmZvcm1hdGlvbiBmcm9tIHRoZSBhc3NvY2lhdGVkIEhvc3RJ
T01NVURldmljZS4NCj4+ICsgICAgICoNCj4+ICsgICAgICogUmV0dXJuIHRydWUgaWYgSG9zdElP
TU1VRGV2aWNlIGlzIGF0dGFjaGVkLCBvciBlbHNlIHJldHVybiBmYWxzZQ0KPj4gKyAgICAgKiB3
aXRoIGVycnAgc2V0Lg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAYnVzOiB0aGUgI1BDSUJ1cyBv
ZiB0aGUgUENJIGRldmljZS4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQG9wYXF1ZTogdGhlIGRh
dGEgcGFzc2VkIHRvIHBjaV9zZXR1cF9pb21tdSgpLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBA
ZGV2Zm46IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyIG9mIHRoZSBQQ0kgZGV2aWNlLg0KPj4g
KyAgICAgKg0KPj4gKyAgICAgKiBAZGV2OiB0aGUgZGF0YSBzdHJ1Y3R1cmUgcmVwcmVzZW50aW5n
IGhvc3QgSU9NTVUgZGV2aWNlLg0KPkBlcnJwIGlzIG1pc3NpbmcNCg0KV2lsbCBhZGQuDQoNCj4+
ICsgICAgICoNCj4+ICsgICAgICovDQo+PiArICAgIGludCAoKnNldF9pb21tdV9kZXZpY2UpKFBD
SUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbiwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgSG9zdElPTU1VRGV2aWNlICpkZXYsIEVycm9yICoqZXJycCk7DQo+PiArICAg
IC8qKg0KPj4gKyAgICAgKiBAdW5zZXRfaW9tbXVfZGV2aWNlOiBkZXRhY2ggYSBIb3N0SU9NTVVE
ZXZpY2UgZnJvbSBhDQo+dklPTU1VDQo+PiArICAgICAqDQo+PiArICAgICAqIE9wdGlvbmFsIGNh
bGxiYWNrLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAYnVzOiB0aGUgI1BDSUJ1cyBvZiB0aGUg
UENJIGRldmljZS4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQG9wYXF1ZTogdGhlIGRhdGEgcGFz
c2VkIHRvIHBjaV9zZXR1cF9pb21tdSgpLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAZGV2Zm46
IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyIG9mIHRoZSBQQ0kgZGV2aWNlLg0KPj4gKyAgICAg
Ki8NCj4+ICsgICAgdm9pZCAoKnVuc2V0X2lvbW11X2RldmljZSkoUENJQnVzICpidXMsIHZvaWQg
Km9wYXF1ZSwgaW50IGRldmZuKTsNCj4+ICB9IFBDSUlPTU1VT3BzOw0KPj4NCj4+ICBBZGRyZXNz
U3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldik7DQo+
PiAraW50IHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldiwgSG9zdElP
TU1VRGV2aWNlDQo+KmJhc2VfZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRXJyb3IgKiplcnJwKTsNCj4+ICt2b2lkIHBjaV9kZXZpY2VfdW5zZXRfaW9tbXVfZGV2aWNl
KFBDSURldmljZSAqZGV2KTsNCj4+DQo+PiAgLyoqDQo+PiAgICogcGNpX3NldHVwX2lvbW11OiBJ
bml0aWFsaXplIHNwZWNpZmljIElPTU1VIGhhbmRsZXJzIGZvciBhIFBDSUJ1cw0KPj4gZGlmZiAt
LWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KPj4gaW5kZXggNzYwODBhZjU4MC4u
ODA3ODMwNzk2MyAxMDA2NDQNCj4+IC0tLSBhL2h3L3BjaS9wY2kuYw0KPj4gKysrIGIvaHcvcGNp
L3BjaS5jDQo+PiBAQCAtMjY3MiwxMSArMjY3MiwxNCBAQCBzdGF0aWMgdm9pZA0KPnBjaV9kZXZp
Y2VfY2xhc3NfYmFzZV9pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCj4+ICAg
ICAgfQ0KPj4gIH0NCj4+DQo+SSB3b3VsZCB3cml0ZSBzb21lIGNvbW1lbnRzIGRlc2NyaWJpbmcg
dGhlIG91dHB1dCBwYXJhbXMgYW5kIGFsc28NCj5leHBsaWNpdGx5IHNheWluZyBzb21lIGFyZSBv
cHRpb25hbA0KDQpTdXJlLg0KDQo+PiAtQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lvbW11X2Fk
ZHJlc3Nfc3BhY2UoUENJRGV2aWNlICpkZXYpDQo+PiArc3RhdGljIHZvaWQgcGNpX2RldmljZV9n
ZXRfaW9tbXVfYnVzX2RldmZuKFBDSURldmljZSAqZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lCdXMgKiphbGlhc2VkX2J1cywNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJQnVzICoqcGlvbW11X2J1
cywNCj4NCj5waW9tbXVfYnVzIGlzIG5vdCBhbiBvcHRpb25hbCBwYXJhbWV0ZXIuIEkgd291bGQg
cHV0IGl0IGJlZm9yZSBhbGlhc2VkX2J1cy4NCg0KR29vZCBzdWdnZXN0aW9uLCB3aWxsIGRvLg0K
DQo+DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCAq
YWxpYXNlZF9kZXZmbikNCj4+ICB7DQo+PiAgICAgIFBDSUJ1cyAqYnVzID0gcGNpX2dldF9idXMo
ZGV2KTsNCj4+ICAgICAgUENJQnVzICppb21tdV9idXMgPSBidXM7DQo+PiAtICAgIHVpbnQ4X3Qg
ZGV2Zm4gPSBkZXYtPmRldmZuOw0KPj4gKyAgICBpbnQgZGV2Zm4gPSBkZXYtPmRldmZuOw0KPj4N
Cj4+ICAgICAgd2hpbGUgKGlvbW11X2J1cyAmJiAhaW9tbXVfYnVzLT5pb21tdV9vcHMgJiYgaW9t
bXVfYnVzLQ0KPj5wYXJlbnRfZGV2KSB7DQo+PiAgICAgICAgICBQQ0lCdXMgKnBhcmVudF9idXMg
PSBwY2lfZ2V0X2J1cyhpb21tdV9idXMtPnBhcmVudF9kZXYpOw0KPj4gQEAgLTI3MTcsMTMgKzI3
MjAsNjYgQEAgQWRkcmVzc1NwYWNlDQo+KnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShQ
Q0lEZXZpY2UgKmRldikNCj4+DQo+PiAgICAgICAgICBpb21tdV9idXMgPSBwYXJlbnRfYnVzOw0K
Pj4gICAgICB9DQo+PiAtICAgIGlmICghcGNpX2J1c19ieXBhc3NfaW9tbXUoYnVzKSAmJiBpb21t
dV9idXMtPmlvbW11X29wcykgew0KPj4gKw0KPj4gKyAgICBhc3NlcnQoMCA8PSBkZXZmbiAmJiBk
ZXZmbiA8IFBDSV9ERVZGTl9NQVgpOw0KPj4gKyAgICBhc3NlcnQoaW9tbXVfYnVzKTsNCj4+ICsN
Cj4+ICsgICAgaWYgKHBjaV9idXNfYnlwYXNzX2lvbW11KGJ1cykgfHwgIWlvbW11X2J1cy0+aW9t
bXVfb3BzKSB7DQo+PiArICAgICAgICBpb21tdV9idXMgPSBOVUxMOw0KPj4gKyAgICB9DQo+PiAr
DQo+PiArICAgICpwaW9tbXVfYnVzID0gaW9tbXVfYnVzOw0KPj4gKw0KPj4gKyAgICBpZiAoYWxp
YXNlZF9idXMpIHsNCj4+ICsgICAgICAgICphbGlhc2VkX2J1cyA9IGJ1czsNCj4+ICsgICAgfQ0K
Pj4gKw0KPj4gKyAgICBpZiAoYWxpYXNlZF9kZXZmbikgew0KPj4gKyAgICAgICAgKmFsaWFzZWRf
ZGV2Zm4gPSBkZXZmbjsNCj4+ICsgICAgfQ0KPj4gK30NCj4+ICsNCj4+ICtBZGRyZXNzU3BhY2Ug
KnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCj4+ICt7DQo+
PiArICAgIFBDSUJ1cyAqYnVzOw0KPj4gKyAgICBQQ0lCdXMgKmlvbW11X2J1czsNCj4+ICsgICAg
aW50IGRldmZuOw0KPj4gKw0KPj4gKyAgICBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4o
ZGV2LCAmYnVzLCAmaW9tbXVfYnVzLCAmZGV2Zm4pOw0KPj4gKyAgICBpZiAoaW9tbXVfYnVzKSB7
DQo+PiAgICAgICAgICByZXR1cm4gaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9hZGRyZXNzX3Nw
YWNlKGJ1cywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb21tdV9idXMt
PmlvbW11X29wYXF1ZSwgZGV2Zm4pOw0KPj4gICAgICB9DQo+PiAgICAgIHJldHVybiAmYWRkcmVz
c19zcGFjZV9tZW1vcnk7DQo+PiAgfQ0KPj4NCj4+ICtpbnQgcGNpX2RldmljZV9zZXRfaW9tbXVf
ZGV2aWNlKFBDSURldmljZSAqZGV2LCBIb3N0SU9NTVVEZXZpY2UNCj4qYmFzZV9kZXYsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiArew0KPj4g
KyAgICBQQ0lCdXMgKmlvbW11X2J1czsNCj4+ICsNCj4+ICsgICAgcGNpX2RldmljZV9nZXRfaW9t
bXVfYnVzX2RldmZuKGRldiwgTlVMTCwgJmlvbW11X2J1cywgTlVMTCk7DQo+SSB3b3VsZCBhZGQg
YSBjb21tZW50IGV4cGxhaW5pbmcgd2h5IHlvdSBkb24ndCBjYXJlIGFib3V0IGFsaWFzZWQgYnVz
DQo+YW5kIGRldmZuDQoNClN1cmUuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4+ICsgICAgaWYg
KGlvbW11X2J1cyAmJiBpb21tdV9idXMtPmlvbW11X29wcy0+c2V0X2lvbW11X2RldmljZSkgew0K
Pj4gKyAgICAgICAgcmV0dXJuIGlvbW11X2J1cy0+aW9tbXVfb3BzLQ0KPj5zZXRfaW9tbXVfZGV2
aWNlKHBjaV9nZXRfYnVzKGRldiksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW9tbXVfYnVzLT5pb21tdV9vcGFxdWUsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2LT5k
ZXZmbiwgYmFzZV9kZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZXJycCk7DQo+PiArICAgIH0NCj4+ICsgICAgcmV0dXJuIDA7DQo+
PiArfQ0KPj4gKw0KPj4gK3ZvaWQgcGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2UoUENJRGV2
aWNlICpkZXYpDQo+PiArew0KPj4gKyAgICBQQ0lCdXMgKmlvbW11X2J1czsNCj4+ICsNCj4+ICsg
ICAgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKGRldiwgTlVMTCwgJmlvbW11X2J1cywg
TlVMTCk7DQo+PiArICAgIGlmIChpb21tdV9idXMgJiYgaW9tbXVfYnVzLT5pb21tdV9vcHMtPnVu
c2V0X2lvbW11X2RldmljZSkgew0KPj4gKyAgICAgICAgcmV0dXJuIGlvbW11X2J1cy0+aW9tbXVf
b3BzLQ0KPj51bnNldF9pb21tdV9kZXZpY2UocGNpX2dldF9idXMoZGV2KSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvbW11X2J1
cy0+aW9tbXVfb3BhcXVlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZGV2LT5kZXZmbik7DQo+PiArICAgIH0NCj4+ICt9DQo+PiAr
DQo+PiAgdm9pZCBwY2lfc2V0dXBfaW9tbXUoUENJQnVzICpidXMsIGNvbnN0IFBDSUlPTU1VT3Bz
ICpvcHMsIHZvaWQNCj4qb3BhcXVlKQ0KPj4gIHsNCj4+ICAgICAgLyoNCj5UaGFua3MNCj4NCj5F
cmljDQoNCg==

