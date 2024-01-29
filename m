Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE66C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUO9B-0006JU-4j; Mon, 29 Jan 2024 04:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rUO96-0006Iu-GO; Mon, 29 Jan 2024 04:41:40 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rUO94-0001oj-5Q; Mon, 29 Jan 2024 04:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706521298; x=1738057298;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+zwuFRWt1/DkAgfocUXg1kJKmqV2nHgkGCQ6HZ1ontc=;
 b=d2cYKIqz54/k4yfLo5oAwyStEW4SLsPYQjkI3eE0JdgOJHPO6Uh5wXMV
 bzQvhPSXX4dTVgMLrc+QGrnTSO3PkVpbzh1vUSBLnxH+PGkKejRZaAOVr
 e4xBXyMGux4L+U64R00EP9r47ZpacvUJy4UM1UNPyWjKiOa12LpM2xpBh
 VWWjeqhvyHh/iZuozI/vg27k4IMyN5zcvPd84Y4zOkbsH5OHi5Z02CxnH
 AqcTlyPdBhYNknfaD+CKgHtptENkm6n/yAfatAUJwIBs75O5SWe6/fdo3
 qZHgETK1Y7/RvJUgBH5g9YOmrxgKIEC75X8fQYxKU/UByJcz+HJv9InYU Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10289036"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; d="scan'208";a="10289036"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2024 01:41:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3325365"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Jan 2024 01:41:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 01:41:33 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 01:41:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 01:41:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 01:41:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1lA+1xr3RreHWjBB9r6md61Z2X3BakDxm8UoWPQqJ88ntUb/O9xOvniUmFbvz/AOKic9uSWM4FY2/SZgz1CrpRGFB0RCPL4N/z2qcZFA3xuSz5blvkoXbR8xBdU/3Y+rRinhhrllUR4DZB00KKRSTgVY9nox1AytBMt5CjHzw2hmconMxnwd/gTy6rqdPJ4q8sDx/1/PloMjVsUyCvv9mAZzPkSi/ygNn5GIPE50z4BVbV6auqzEn/JiQf0RcGceIcJpzvPyZirnEX4mB2yWGZfS3dmi/FWMzFGg7ZRX0BZiuX73FAFVbktwyrHl16OBnkE93AOkmkgBtx6O3N+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zwuFRWt1/DkAgfocUXg1kJKmqV2nHgkGCQ6HZ1ontc=;
 b=mevpxmM4BrRT26+CAyMtMn+gS0CxTBZa8be+I4vLSNZ5eIMQkI7OG6Jn0aDqXOYjkEb5gsWqp5EcPIxHzVO7nYMlAn+V/sYL/rwdxCgrQ8wYJYGOPnFG4UPCr6q1E8iUl7cEvFlHL3fBd1ahaFJuBSFkmbKCTBj5R3zH+UQutkL0MexBDKtiLVb07L1X8kDYUYmY9KeASHWa4zf9zpX3hy4QOPeImpPZ0Tw4jbFm7e5orfmQiyeg0HpefW7azhqjExb2EB5sJkZcplj7qDFO794R96KVvuh/E6EwelR0wv3nYW5iPsjawb9NtcTPy7Cu6z+Hv8o0+8YnQCVZjXKmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6902.namprd11.prod.outlook.com (2603:10b6:510:229::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Mon, 29 Jan
 2024 09:41:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 09:41:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 0/2] Two minor fixes on virtio-iommu and smmu
Thread-Topic: [PATCH v2 0/2] Two minor fixes on virtio-iommu and smmu
Thread-Index: AQHaT2GjWnjNt1LBz0mgjKh0m7F4HbDwi9+AgAADuPA=
Date: Mon, 29 Jan 2024 09:41:24 +0000
Message-ID: <SJ0PR11MB6744470D4D435456FFE70375927E2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240125073706.339369-1-zhenzhong.duan@intel.com>
 <ee99d75b-705e-4ba3-adac-f4798b0a0d6c@redhat.com>
In-Reply-To: <ee99d75b-705e-4ba3-adac-f4798b0a0d6c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6902:EE_
x-ms-office365-filtering-correlation-id: 8e39fd9b-0133-48c0-abff-08dc20ae758d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTLz6WkTjHPux+5NWswjlBtcvCHm3l1+hl9IKdYOA+DOoGUuU5kvXchkyHOSBULBznH7PlHl9T/7fYVWWJFgqY++0SZRQeA4A77H/rOumGqvqXjFDmDqq95FQPyLe6Q+/jpU1fliWbK6yh/IJIn9FN1NySW2fI391uQprYS4Fb/eiPULd+DW/3p1T89u+hyDjX8qsb9089NAR+W7bZ/5UpfG66pKqyphtNhNt+yZg2kFIQaHPSxZ2toHesTNVOI9giNjzfW6RW+kVz1v/oaIc5q/7ys2ZIcL7JM7M9vtwvqv1RcD+rad/+ICZxyIus1ctYGQjLBUboSQQmCrKHHA0tUpEjLqF2cSEl2mkFl5uDKprOVn4bGyuudaA+V3x7o7zSupGuMjWp+LnXZiTe/+wV84Lu1LKO9RC0sfCZxhfAM9MR/IXfX6b6DqIbw3sLbu7FVimgEOPurDoNf+jbZ6xFR+n6YVD9Ii6lYLCflez3lkbUqI5rR/Sqvl7p6dLM04LiBJcBOH4HtgOrVJA/Q4+KGsJ+i1UHiVJfQK3R24TmYxPlsYV+QCSoi0XbeO18P9i09fUBToZRlR+VAg2oU3eHW98HlXvt3QRG6x/IldbOPMZ3ALdQyFcdSvNHDZs/lx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(82960400001)(38100700002)(122000001)(55016003)(66556008)(66446008)(7696005)(76116006)(6506007)(110136005)(66946007)(54906003)(316002)(64756008)(86362001)(66476007)(8676002)(8936002)(66574015)(5660300002)(33656002)(9686003)(52536014)(478600001)(107886003)(2906002)(4744005)(4326008)(71200400001)(26005)(83380400001)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RThVZVZWRFU0V2FGN1o4T05FY0VYZE1nK0ducWxHM251cnY5U3Nhck93MHVl?=
 =?utf-8?B?ejk0MXdzNlBLdzZNcG1ZT2hodXNTcitYQS9PTUwzSW82NEgzaGpBNXpFb2tj?=
 =?utf-8?B?L3VxcnFQZ3FVM1J5UDEyeUlidUNkUGMwVmtPUG5GUGNRSXVHaExHWHFTeFVi?=
 =?utf-8?B?UkRPU3ZOZGVKUTZHZ3VTaWo4M2tIVVNLQjdtU1QyRkdZTERPci9GbVRKei9o?=
 =?utf-8?B?V3NVQ3FkTnpoSzRXZEZJRmF2U0tnaFUyYTA3Y2M1cnYwNWlmMytnbjgxdmV1?=
 =?utf-8?B?dWdTUHlGY1UrdnJ6ZHQ0K2xQMUc5ZjVWbUtKYkJkWnk3U0liVmpZYktZa2ln?=
 =?utf-8?B?MFkwVE1BcjExcDkwTjlRUnMvSVlSakhUWHg3K05yVFlQdk9uR0NDNjJRR0dV?=
 =?utf-8?B?WWZKQzQreXB1U1hqeGR3MTh2bjRVbE1NMldkaU5SOHhrOWhSMCttMFpRanl0?=
 =?utf-8?B?aWNSVGRkajE3dXl1UWVibng2a283L2k1NUhGOTJnWUxqaVJ3VStNb3BROE9P?=
 =?utf-8?B?Rlc3NzVuQkJ0MHZaOXh4U0MxUXNxdkNvYVNjRUVmck4zaFYxL1RHMUJPR0gz?=
 =?utf-8?B?aU9iUTJlOUhESmMwNjJvWlVSM3p6T0ZqYUpmaUJMZWZVOVdiZytOMzhPbXU1?=
 =?utf-8?B?Z3FVV2txSGlDSmN5bmNhMGhGYWhibGN0Z01ORGVHQXJ1UXAxNWhVdWM2VGlx?=
 =?utf-8?B?bVBYVVA2UkpROWdGb3dKaTBmd1g4WG45Nk1aeklmK1JnMytaM3NQOS9vaGZO?=
 =?utf-8?B?TUxKQVlqeVphLzNhQUdqN3BKTW1CYnJzaHlaZ0p5c1dNL3FkdS9hSWYwcGF3?=
 =?utf-8?B?aTB4WFhudlJHZ1BYVGNyd3NmRlI5R3FTdWtmT0Q0RjJIalFuZDNlblhUVDNi?=
 =?utf-8?B?Sm4zQ1dTT1BndUwxYzI5Zk5kWTk1OUJsZ3BNZ2NXR29OeGpyWDBWUkUxb085?=
 =?utf-8?B?RExLYTJBNHdMenJpSTRaYk9rR0dkK1pySnB1U283YTE4ai8xSVFXZGFKd2lo?=
 =?utf-8?B?ZHc3VjFibHlPbm1JK0QzMW1qWmMwc2QyN1BXQ2s0elhIWlR5QjhoZVA5MGhu?=
 =?utf-8?B?L0o2L1BjL2U1cDFnTmFOb0xCWVZTbSt5bmhKak5IVUFHUmpuV0FxbkFnU0Fq?=
 =?utf-8?B?dGZTbjVDdHNhRzdpdzVMd2RBMzJvWWMyMDRpVXgyZmdmYjk3V2FZMlhKQVQ2?=
 =?utf-8?B?K3B6TmU4ekxKdHB2b1VSSFJKUTlNS1lwZHY4YnBqVlAxVEFEZms3bWZEUDJh?=
 =?utf-8?B?NjJ1aEJkeFF3UXpIMGw5WTB6S1hPVmNiR0FSTHkzeHJQY0tNdTczcDgwK0Nj?=
 =?utf-8?B?QkhtZ3lmanVVamd3bmwray9SWG5IK3RsdXM3SXBPUDg1ZllxTDdtMXh6OU5C?=
 =?utf-8?B?RmRPMEJhZVllUkZIOFkxcDJzeGlTamVHTHdDZE03dEV6YjFoTkpMUFZvNWd4?=
 =?utf-8?B?SDNISEhHYlRpZzdCS2lXeDU4TmJ6UDNJZnRmTmovK2ZmaEZhdTdvc2dKcTZL?=
 =?utf-8?B?VjhWV1dvQmlmVGxNUUFKK0tpc2F0L09Ia2FVc1RxYTRpUTh2RlVmSE82QWRP?=
 =?utf-8?B?bU1FRUwwOUYrcTJxbktWMlFHT0JZUE1WN2ZzZnVtZ3JadXRrdWcvTGlWQmYx?=
 =?utf-8?B?WHlHbU9DNjBneitNZHdkVndUTzNtTGNUNVFJdlhPY0dQUXdqQTIrM1pqVHdX?=
 =?utf-8?B?TXZDRXZ4VUEvbUN2dXVwa0Q5VXZpRGFMc2hwTDhaUnAydDBBRWxNMFJ0YTlK?=
 =?utf-8?B?UlRNdmFjZzRJMDVTRHQ5QmFsT3gvM25oM25ZWVYzeFZWZm9zZjcvWUpyUUZ5?=
 =?utf-8?B?cW5OZGx3azMvUUV0dHlPNGptU0tXaWhqMnpyWnM3dENnRlBCTGZjODlNa0Za?=
 =?utf-8?B?NlVhalRBSzk2WjArTlJrQjVvajU0eXA3ZERVL0xlZEgvNnZ4TUxGU3l0WWdo?=
 =?utf-8?B?b01rNE5DSUF2MzNRWFNKL0lyZDlEM3hZMmVPTnJLRzFRN0xXM0FDYWRHeEV5?=
 =?utf-8?B?aTJ2ajd1bUdLam9NZHhqZzhpbHArYmRnRFdMaDcvOG9UMEszSkFFQ0tCeWl4?=
 =?utf-8?B?clMvWTFkZnVDRS9ucDNkT25Rem1KazZuVjUydlkwWDdxRnY1UE1IMzFsRDdK?=
 =?utf-8?Q?+DzQDc5igZxFPJWYHuNv7Wb+k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e39fd9b-0133-48c0-abff-08dc20ae758d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 09:41:24.7813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDsXRiCx5f4fAJ9ZD747V7WvnRmZvWRIa8ZO/9cDXYqqWKcfXlUs0LlupOsoZNf3NUgYQ7J09C44r3iRhdQgpcPjxSfoLWHyTWX+GsDTXTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6902
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvMl0gVHdvIG1pbm9y
IGZpeGVzIG9uIHZpcnRpby1pb21tdSBhbmQgc21tdQ0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5P
biAxLzI1LzI0IDA4OjM3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IFBB
VENIMSBmaXhlcyBhIHBvdGVudGlhbCBpc3N1ZSB3aXRoIHZmaW8gZGV2aWNlcyB3aGVuIHJlYm9v
dCB0byBhDQo+PiBkaWZmZXJlbnQgT1Mgd2hpY2ggc2V0IGJ1cyBudW1iZXIgZGlmZmVyZW50bHkg
ZnJvbSBwcmV2aW91cyBPUy4NCj4+IEkgZGlkbid0IHJlcHJvZHVjZSB0aGUgaXNzdWUgaW4gcmVh
bGl0eSwgYnV0IGl0J3Mgc3RpbGwgcG9zc2libGUNCj4+IGluIHRoZW9yeS4gVlREIGRvZXNuJ3Qg
aGF2ZSBzYW1lIGlzc3VlIGFzIGl0IHVzZSBzb21lIHZlcmlmeSBsb2dpYw0KPj4gdG8gZW5zdXJl
IHJpZ2h0IGlvbW11IE1SIGlzIHBpY2tlZC4NCj4+DQo+PiBQQVRDSDIgZG9lcyBzYW1lIHRoaW5n
IGZvciBzbW11Lg0KPj4NCj4+IHYyOg0KPj4gLSBSZW1vdmUgcmVkdW5kYW50IG1lbXNldCBpbiBy
ZWFsaXplIChDw6lkcmljKQ0KPj4gLSBBZGQgYSBwYXRjaCBmb3Igc21tdSAoRXJpYykNCj4+IC0g
RHJvcCB0aGUgcGF0Y2ggdG8gc3VwcG9ydCBQQ0kgZGV2aWNlIGFsaWFzIGZvciBub3csIGFzIGl0
J3MgdHJpY2t5IGluDQo+PiAgIHVzaW5nIHR3byBkaWZmZXJlbnQgSU9NTVUgTVJzIGFuZCBFcmlj
IGFscmVhZHkgc2VudCBhIHNtYXJ0ZXIgZml4Lg0KPg0KPkZvciB0aGUgc2VyaWVzOg0KPg0KPlJl
dmlld2VkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+VGVzdGVkLWJ5
OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQoNClRoYW5rcyBFcmljLg0KDQpC
UnMuDQpaaGVuemhvbmcNCg==

