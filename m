Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07984C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwa8J-0004Q0-IO; Tue, 16 Apr 2024 00:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwa87-0004Oy-Nk
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:09:12 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwa84-0007X7-SX
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713240549; x=1744776549;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4Tj11eC3kFCMq7RMwdN8IWpB6e44F9OnG/eiIkCyg5s=;
 b=YE+l7CWSOG6/kfkfnqeopV3t3WX1QkjNST0IaSoWr0ZvS4F1VwXvO9YA
 lFif3uJI9FzRY0yHWdZIm8cafMZoA1yQTo9QUSOcrXfYrHoDDvmiWbM77
 Ql6O6ZU7YO6q84Y0DuqfxkhpfS1IwbSpaQL0QTGfxCOA6jt2vxkoduMu5
 nlP9KrLdJuBUDeB03vf8PZKcf6qCArN7//h8qDMp4BKI7yqTjfW6INsbx
 SoTltOZeo+5W+o0+HAB2UJVHDGe2kGXi+0F+zYzr6YJK5JV0PAiXsRd+J
 dMuL3DWBSkGC5hr6EBx3F9Tk98I1addusitF64b5oN9+Ro0bx09aeEmMM g==;
X-CSE-ConnectionGUID: fmXwu5RUTXWhkGOSJ9Mklg==
X-CSE-MsgGUID: Rl48Y7qxSTi8FFmNLUEV1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8784779"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8784779"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 21:09:05 -0700
X-CSE-ConnectionGUID: zzlw/RohQgymugVYHZC7ew==
X-CSE-MsgGUID: CuDB3i6LR6allbDQbZVXvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; d="scan'208";a="26906248"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 21:09:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 21:09:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 21:09:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:09:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUDtIEVIilcmqkDMEqdxBYz0s82mapAXgFJEadx3FbYIQjFY1q9T4sBwwNlMwbV1a+zzAeGiCLwPZfbIV173dhj5wUjRSVb2vLRyZBFxKZut8kS7hqEX5nEQDCfRmF6COobWHqrRw6pAYwKusbY0H8zVAzV1kWH3aKqJf1oo2wN6vZ6QF9Q1rtmlDzhsvauuOd930TMz/GONKjjT1lkUQZ5f1+irZ9DSm0/rNycwXJcgjhh17P3QFD55wdlXjupI+i7vEWezDxdvTOwv8zfOQy4eyXgh3bcqg3SHB9MTUWqq/I5kPAnlcIbzI3eFxf+AYd4GE8E2OpKUHJvQxRNuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Tj11eC3kFCMq7RMwdN8IWpB6e44F9OnG/eiIkCyg5s=;
 b=BESk6EIJtSG6+MqIIYmsKDWrBh2/X+ad4i9NaG3yKR+5LDFjvh1BH78HWL6h5QqYsAOsdtRKhTAlfibYQaUcSegOIW84oJvghL55Gnuwg1aHEmBJSB3KiDL4J3U97ZSmfJ6avmrCecpyijvM/L2ClqkvsG9p2A2XhjSbx8wSH/a9LsIPxBFeAYDabp5rZdEAdcEmEyd5r1LAyvuJS1XqkIY6fEoOrF63n7Jr9NMT71NxM6t9eLrD7+Vi1uP0TdiXAve52AvGxW5SUrgeA2YMH0liDMvt+/cjpsdr688LW084+X7s/9hpCdn34+yL+aoskdcStrfIWW1nNuGdIWFG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 04:09:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 04:09:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v2 03/10] backends/iommufd: Introduce abstract HIODIOMMUFD
 device
Thread-Topic: [PATCH v2 03/10] backends/iommufd: Introduce abstract
 HIODIOMMUFD device
Thread-Index: AQHaiYzv/ANc1Xxp8EunpOKN/GET+LFpWI4AgAD1SsA=
Date: Tue, 16 Apr 2024 04:09:02 +0000
Message-ID: <SJ0PR11MB67447379C545BAA3E4FE182C92082@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-4-zhenzhong.duan@intel.com>
 <b761d626-046a-4032-940a-17d659090c9f@redhat.com>
In-Reply-To: <b761d626-046a-4032-940a-17d659090c9f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5078:EE_
x-ms-office365-filtering-correlation-id: 485d35a6-828e-4e3b-d2ef-08dc5dcaf387
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DchBh0M1FYu9x2XRZhJJ0JSOCq8SjDqI+jn+ymalP2ZkN2EJmjYPGcNB4zp9AZPsIeDVVokuMa6Cj2Jd8KTAxOwZv6n+ZD4kauVoBq0ideutrnN8myWfPhIdPoXFBu7V9Io2r2yXk4ghwY0I2cFLxLLid5F+cC/TgQdNMnMagdU0Kl0ZZWdU8kxkAR7M+oZ7fl3HtKokBDDKwDZi4rRg2W96N3Xq6OwVY/DDcXGguheETXUveOZCoajQrcQZku/hi2NQdnKWDf+3Nl82BUjYfnADQ5afRpemtmxp4E3ugYxpoICDMRHLG4PrSTfDBytLRN/p/tsIf6QE0iBaGu5+8XSW5m8BxQ0WHyS0isewjxCud75ZrV9H1C/gTrEACIZ8t0VOHVgpaRs6IQtrTpLcIfP4Bwge0i56Ros0SS+LvV/QITL4iaz/ACLkEWDJX5tJhL4RoXs7D+0DGn1S+tvIN8ef+tVlKth2NenF1+oCaWRsynNlzL5y7t0hmDqgP7JWk1gIoeaPWhUf/8D00Ez9OhUfW3sDwJvZSjn3EYb6Z5it9HCbkUu7Ps6WFykyUx4shJ5Byn/ZMOiAFB8OyANVgQMhVRIsUF9IxtW5gzyAl/BmuYfwnBoSrsUhhuXTu7/dO9fON5ayf9hbdmz+kxyCB90Svq7QW+LoCxdKtzOLGym5Ofd+Bpyac0rllQ4Hxe31
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFZXSkl0TG9xdmRnbUdtdnRhV0tVbkc1YWNXNHMvcDlEQytjaG1qZklQWFJn?=
 =?utf-8?B?WlRNRHA3YWk4dUw4eHNKZm56RlhRYVNGMThicTUwVFVjOFE4Znk0QlpUYzJX?=
 =?utf-8?B?UFFhVzZrK2hVWWprQTV0dmpiQk5FZnJRUzV0NjRST000MmlaeG9OTUNVUkRk?=
 =?utf-8?B?LzlmQThybWpuMDkzTDVDOWNUejRNMjA4ck9FRmRlN2hnRFhhZlNKZGpiZGVq?=
 =?utf-8?B?MVFnK0pyRjB5MzBTTzAxUURVY1ZXZUN3Qzk2ZzlNbU0vTEZQR2RwNGg5cytu?=
 =?utf-8?B?MTA1QjFwZGliNWVlcDROa3lRbm1iVy82ZlRxVjRFdXl4WHlhVXIrSnVibDlz?=
 =?utf-8?B?MjdRN2o0U2NpT2VSWEhhcUR0alN0RDRzM2phNDMzclJXb2dPbWlIY3NWdytQ?=
 =?utf-8?B?TVBzQlVIMUJ4OENseXp1WlQxMitCeHJjbnprT2xveS9jaEJDblhOalpUWEhp?=
 =?utf-8?B?OThtMGQ1MDZaQWxWK0dFQXVHakw3M0lGQzZ2c0Z5M3pXcnBsMzV5Q1prZStj?=
 =?utf-8?B?bEdheUI2YjlBRjBKeXowVDlZZnNEbjJlcHZlUzBKQjlQbmJVRmtmaktRSm00?=
 =?utf-8?B?Ni9heHJ1S1UzUXNXOExSMHF4bmhrakt6Y0FZdXZUT2JsVjRPWEQ5czhMNG1x?=
 =?utf-8?B?aVdOT3BRbkN5UEtEOTQwaU9FOGhNK0JzcHdJQUlDcWp3SEo0UC8wS3h4clk3?=
 =?utf-8?B?MGVERFgyK3NMS2xOazBwNHZ5YTJpM05VdVpHQlN5RDlTQjBNYkJTdHoxMGtG?=
 =?utf-8?B?Ym9Pei9BelEyMTcrMjZQL0NLSGJyUEloWXFKNFRIY2MvdEVSRS9ud2dPRk1u?=
 =?utf-8?B?WW1NTHJsejk2bkRBM2FyVEUyZkRDbUdFRTRhNFF3NnFNdkp4ODVNM3BJamk1?=
 =?utf-8?B?SUFrVk53L1JZaVNWT3dFalZZQ1Z3WHMrZS8zN0V3bWxmUUpwTURtY1BGY3BR?=
 =?utf-8?B?bTUxNjRtclk5c0tUUGpmRDZEcCtLUDh6S0J0Y25wWjdaVWlIbFQ1VEJIS2hJ?=
 =?utf-8?B?bkg5TmlMOGw3TGd5M3Q5a0Mra21tNFRsOGZldkEwb20ycGE3YmJMem5HckpM?=
 =?utf-8?B?bVZ2eXp1aGtvYzJ2c0RNOElncDVWMlNFK0EyQ2VPbVVLVS82b0dNU084WTlh?=
 =?utf-8?B?cjc2M0JqdzcrcG9WY0Y0RCtuNlRQUHp3Und1TGxUSklKVXB5N3ZVdVVtb3Jp?=
 =?utf-8?B?S3V3WVZhSFp6VFFJVHlOak45UncySzAzblZXS1V2bDNONlVpYXZCOGJzc2R6?=
 =?utf-8?B?RXlQRGRvT3BTT3NHdlU4UEtsMENjUzJKQ25tVGIwZy9CWTQ5elFUTWNzTHRj?=
 =?utf-8?B?bkdtano0N3RrUEI4WmhIUWdzLzU0UFpaSGF6TW1XeHJ4YnBObS9wV1ZwOTdQ?=
 =?utf-8?B?ZkNPYkVCQlF0d0d1L2NrazVGR1k2Ym5zd21SQXl3UXVZSDdHeDdFTUdhRXpF?=
 =?utf-8?B?cldOQnV0aEFZUUY5OE9XWUxia3ZYczNEUEh4NzRVRlNyaHBicSt3M0FIUFVu?=
 =?utf-8?B?ZEdGbXBUbklucXZIc2RnaDB5WFRxNnMvdXNVWXE5a1l0Qy9ud1AvdjllZzdr?=
 =?utf-8?B?K1gxYTRYR21Jd0FaWFMxUmorSGZFbHRsUzdjMEdmOXBqWjhLclB1MmN5bGpT?=
 =?utf-8?B?cG1LdzJ5ekZxSnhTdUxHU3V1SzF5Y0tSSlFxc3RudDBJbWNZcTRMNE5idXdR?=
 =?utf-8?B?UXRlRUdteE9KbzQ5UmN5MHU3UGVhRlFOTTlaMitFNGExeCtzdVZoMFIxa1FJ?=
 =?utf-8?B?dk1FclRFYUlGb2txVlRmRmVlT3NwejZsL25aVDlySFJjRnNyMzRnN0RzTVA0?=
 =?utf-8?B?TFJ6dWdpczQ3Ui9vUlRic1BkME1MQ3hWcVZUNlZobkRkVzh1Rng1Umh5a3J2?=
 =?utf-8?B?ZTRLYjhYNGFXQkUwemlYcFBtWXpkQ2dxZ2s3V3dOWno3bEtXbTRsM2pMa3Zj?=
 =?utf-8?B?V1dJaGZZRU84bVZRUTNuODdiMUtzZll6MkRiUU5kbVlwMTgrdnlHUXVDaGNv?=
 =?utf-8?B?MXZFQitHTGRCdWhxMWU0SVNvV0NwaE83TG9RaEt1eHBKNmUzc0cvdVpPWWov?=
 =?utf-8?B?OWpHMDd2Q2pRYTcxaEdiM0VoTEhPLzdraTBKYlZqNkxBcE1KUFZCeVlaYm1z?=
 =?utf-8?Q?F658UtAjJVPkvJuv2j4o93HLk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485d35a6-828e-4e3b-d2ef-08dc5dcaf387
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 04:09:02.9874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Y1BlUwRA7dkY9TEgIC843u4ZlejthzqyHOD1A83ex1R4VQbTDhIoN2t6Z+3/KPws1kBZOSN4icwTl7tmMVN8cI/p24MHHU6OfRw3guj/Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5078
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAzLzEwXSBiYWNrZW5k
cy9pb21tdWZkOiBJbnRyb2R1Y2UgYWJzdHJhY3QNCj5ISU9ESU9NTVVGRCBkZXZpY2UNCj4NCj5P
biA0LzgvMjQgMTA6MTIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSElPRElPTU1VRkQgcmVw
cmVzZW50cyBhIGhvc3QgSU9NTVUgZGV2aWNlIHVuZGVyIGlvbW11ZmQgYmFja2VuZC4NCj4+DQo+
PiBDdXJyZW50bHkgaXQgaW5jbHVkZXMgb25seSBwdWJsaWMgaW9tbXVmZCBoYW5kbGUgYW5kIGRl
dmljZSBpZC4NCj4+IHdoaWNoIGNvdWxkIGJlIHVzZWQgdG8gZ2V0IGh3IElPTU1VIGluZm9ybWF0
aW9uLg0KPj4NCj4+IFdoZW4gbmVzdGVkIHRyYW5zbGF0aW9uIGlzIHN1cHBvcnRlZCBpbiBmdXR1
cmUsIHZJT01NVSBpcyBnb2luZw0KPj4gdG8gaGF2ZSBpb21tdWZkIHJlbGF0ZWQgb3BlcmF0aW9u
cyBsaWtlIGF0dGFjaGluZy9kZXRhY2hpbmcgaHdwdCwNCj4+IFNvIElPTU1VRkREZXZpY2UgaW50
ZXJmYWNlIHdpbGwgYmUgZnVydGhlciBleHRlbmRlZCBhdCB0aGF0IHRpbWUuDQo+Pg0KPj4gVkZJ
TyBhbmQgVkRQQSBkZXZpY2UgaGF2ZSBkaWZmZXJlbnQgd2F5IG9mIGF0dGFjaGluZy9kZXRhY2hp
bmcgaHdwdC4NCj4+IFNvIEhJT0RJT01NVUZEIGlzIHN0aWxsIGFuIGFic3RyYWN0IGNsYXNzIHdo
aWNoIHdpbGwgYmUgaW5oZXJpdGVkIGJ5DQo+PiBWRklPIGFuZCBWRFBBIGRldmljZS4NCj4+DQo+
PiBJbnRyb2R1Y2UgYSBoZWxwZXIgaGlvZF9pb21tdWZkX2luaXQoKSB0byBpbml0aWFsaXplIEhJ
T0RJT01NVUZEDQo+PiBkZXZpY2UuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+PiBPcmlnaW5hbGx5LWJ5OiBZaSBMaXUgPHlpLmwubGl1
QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50
ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL3N5c2VtdS9pb21tdWZkLmggfCAyMiAr
KysrKysrKysrKysrKysrKysrDQo+PiAgIGJhY2tlbmRzL2lvbW11ZmQuYyAgICAgICB8IDQ3ICsr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA1MyBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oIGIvaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oDQo+
PiBpbmRleCA5YWYyN2ViZDZjLi43MWM1M2NiYjQ1IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9z
eXNlbXUvaW9tbXVmZC5oDQo+PiArKysgYi9pbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4+IEBA
IC00LDYgKzQsNyBAQA0KPj4gICAjaW5jbHVkZSAicW9tL29iamVjdC5oIg0KPj4gICAjaW5jbHVk
ZSAiZXhlYy9od2FkZHIuaCINCj4+ICAgI2luY2x1ZGUgImV4ZWMvY3B1LWNvbW1vbi5oIg0KPj4g
KyNpbmNsdWRlICJzeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCINCj4+DQo+PiAgICNkZWZpbmUg
VFlQRV9JT01NVUZEX0JBQ0tFTkQgImlvbW11ZmQiDQo+PiAgIE9CSkVDVF9ERUNMQVJFX1RZUEUo
SU9NTVVGREJhY2tlbmQsIElPTU1VRkRCYWNrZW5kQ2xhc3MsDQo+SU9NTVVGRF9CQUNLRU5EKQ0K
Pj4gQEAgLTMzLDQgKzM0LDI1IEBAIGludA0KPmlvbW11ZmRfYmFja2VuZF9tYXBfZG1hKElPTU1V
RkRCYWNrZW5kICpiZSwgdWludDMyX3QgaW9hc19pZCwNCj5od2FkZHIgaW92YSwNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJhbV9hZGRyX3Qgc2l6ZSwgdm9pZCAqdmFkZHIsIGJv
b2wgcmVhZG9ubHkpOw0KPj4gICBpbnQgaW9tbXVmZF9iYWNrZW5kX3VubWFwX2RtYShJT01NVUZE
QmFja2VuZCAqYmUsIHVpbnQzMl90DQo+aW9hc19pZCwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaHdhZGRyIGlvdmEsIHJhbV9hZGRyX3Qgc2l6ZSk7DQo+PiArDQo+PiArI2Rl
ZmluZSBUWVBFX0hJT0RfSU9NTVVGRCBUWVBFX0hPU1RfSU9NTVVfREVWSUNFICItaW9tbXVmZCIN
Cj4NCj5QbGVhc2Uga2VlcCBUWVBFX0hPU1RfSU9NTVVfREVWSUNFDQoNClN1cmUuDQoNCj4NCj4+
ICtPQkpFQ1RfREVDTEFSRV9UWVBFKEhJT0RJT01NVUZELCBISU9ESU9NTVVGRENsYXNzLA0KPkhJ
T0RfSU9NTVVGRCkNCj4+ICsNCj4+ICtzdHJ1Y3QgSElPRElPTU1VRkQgew0KPj4gKyAgICAvKjwg
cHJpdmF0ZSA+Ki8NCj4+ICsgICAgSG9zdElPTU1VRGV2aWNlIHBhcmVudDsNCj4+ICsgICAgdm9p
ZCAqb3BhcXVlOw0KPj4gKw0KPj4gKyAgICAvKjwgcHVibGljID4qLw0KPj4gKyAgICBJT01NVUZE
QmFja2VuZCAqaW9tbXVmZDsNCj4+ICsgICAgdWludDMyX3QgZGV2aWQ7DQo+PiArfTsNCj4+ICsN
Cj4+ICtzdHJ1Y3QgSElPRElPTU1VRkRDbGFzcyB7DQo+PiArICAgIC8qPCBwcml2YXRlID4qLw0K
Pj4gKyAgICBIb3N0SU9NTVVEZXZpY2VDbGFzcyBwYXJlbnRfY2xhc3M7DQo+PiArfTsNCj4NCj5U
aGlzIG5ldyBjbGFzcyBkb2Vzbid0IHNlZW0gdXNlZnVsLiBEbyB5b3UgaGF2ZSBwbGFucyBmb3Ig
aGFuZGxlcnMgPw0KDQpZZXMsIEluIG5lc3Rpbmcgc2VyaWVzIGh0dHBzOi8vZ2l0aHViLmNvbS95
aWxpdTE3NjUvcWVtdS9jb21taXRzL3poZW56aG9uZy9pb21tdWZkX25lc3RpbmdfcmZjdjIvDQpU
aGlzIGNvbW1pdCBodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvY29tbWl0LzU4MWZj
OTAwYWEyOTY5ODhlYWE0OGFiZWU2ZDY4ZDM2NzBmYWY4YzkNCmltcGxlbWVudCBbYXR8ZGVddGFj
aF9od3B0IGhhbmRsZXJzLg0KDQpTbyBJIGFkZCBhbiBleHRyYSBsYXllciBvZiBhYnN0cmFjdCBI
SU9ESU9NTVVGRENsYXNzLg0KDQo+DQo+PiArDQo+PiArdm9pZCBoaW9kX2lvbW11ZmRfaW5pdChI
SU9ESU9NTVVGRCAqaWRldiwgSU9NTVVGREJhY2tlbmQNCj4qaW9tbXVmZCwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQzMl90IGRldmlkKTsNCj4+ICAgI2VuZGlmDQo+PiBkaWZmIC0t
Z2l0IGEvYmFja2VuZHMvaW9tbXVmZC5jIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+PiBpbmRleCA2
MmE3OWZhNmIwLi5lZjhiM2E4MDhiIDEwMDY0NA0KPj4gLS0tIGEvYmFja2VuZHMvaW9tbXVmZC5j
DQo+PiArKysgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+IEBAIC0yMTIsMjMgKzIxMiwzOCBAQCBp
bnQNCj5pb21tdWZkX2JhY2tlbmRfdW5tYXBfZG1hKElPTU1VRkRCYWNrZW5kICpiZSwgdWludDMy
X3QgaW9hc19pZCwNCj4+ICAgICAgIHJldHVybiByZXQ7DQo+PiAgIH0NCj4+DQo+PiAtc3RhdGlj
IGNvbnN0IFR5cGVJbmZvIGlvbW11ZmRfYmFja2VuZF9pbmZvID0gew0KPj4gLSAgICAubmFtZSA9
IFRZUEVfSU9NTVVGRF9CQUNLRU5ELA0KPj4gLSAgICAucGFyZW50ID0gVFlQRV9PQkpFQ1QsDQo+
PiAtICAgIC5pbnN0YW5jZV9zaXplID0gc2l6ZW9mKElPTU1VRkRCYWNrZW5kKSwNCj4+IC0gICAg
Lmluc3RhbmNlX2luaXQgPSBpb21tdWZkX2JhY2tlbmRfaW5pdCwNCj4+IC0gICAgLmluc3RhbmNl
X2ZpbmFsaXplID0gaW9tbXVmZF9iYWNrZW5kX2ZpbmFsaXplLA0KPj4gLSAgICAuY2xhc3Nfc2l6
ZSA9IHNpemVvZihJT01NVUZEQmFja2VuZENsYXNzKSwNCj4+IC0gICAgLmNsYXNzX2luaXQgPSBp
b21tdWZkX2JhY2tlbmRfY2xhc3NfaW5pdCwNCj4+IC0gICAgLmludGVyZmFjZXMgPSAoSW50ZXJm
YWNlSW5mb1tdKSB7DQo+PiAtICAgICAgICB7IFRZUEVfVVNFUl9DUkVBVEFCTEUgfSwNCj4+IC0g
ICAgICAgIHsgfQ0KPj4gLSAgICB9DQo+PiAtfTsNCj4+ICt2b2lkIGhpb2RfaW9tbXVmZF9pbml0
KEhJT0RJT01NVUZEICppZGV2LCBJT01NVUZEQmFja2VuZA0KPippb21tdWZkLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgZGV2aWQpDQo+PiArew0KPj4gKyAgICBpZGV2LT5p
b21tdWZkID0gaW9tbXVmZDsNCj4+ICsgICAgaWRldi0+ZGV2aWQgPSBkZXZpZDsNCj4+ICt9DQo+
DQo+VGhpcyByb3V0aW5lIGRvZXNuJ3Qgc2VlbSB1c2VmdWwuIEkgd29uZGVyIGlmIHdlIHNob3Vs
ZG4ndCBpbnRyb2R1Y2UNCj5wcm9wZXJ0aWVzLiBJJ20gbm90IHN1cmUgdGhpcyBpcyB1c2VmdWwg
ZWl0aGVyLg0KDQpUaGlzIHJvdXRpbmUgaXMgY2FsbGVkIGluIHBhdGNoOCB0byBpbml0aWFsaXpl
IGlvbW11LCBkZXZpZCBhbmQgaW9hcyhpbiBmdXR1cmUgbmVzdGluZyBzZXJpZXMpLg0KSSBkaWRu
J3QgY2hvb3NlIHByb3BlcnRpZXMgYXMgSElPRElPTU1VRkQgaXMgbm90IHVzZXIgY3JlYXRhYmxl
LCBwcm9wZXJ0eSBpcyBhIGJpdCBoZWF2eQ0KaGVyZS4gQnV0IEknbSBmaW5lIHRvIHVzZSBpdCBp
ZiB5b3UgcHJlZmVyLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+DQo+PiAtc3RhdGljIHZv
aWQgcmVnaXN0ZXJfdHlwZXModm9pZCkNCj4+ICtzdGF0aWMgdm9pZCBoaW9kX2lvbW11ZmRfY2xh
c3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+PiAgIHsNCj4+IC0gICAgdHlw
ZV9yZWdpc3Rlcl9zdGF0aWMoJmlvbW11ZmRfYmFja2VuZF9pbmZvKTsNCj4+ICAgfQ0KPj4NCj4+
IC10eXBlX2luaXQocmVnaXN0ZXJfdHlwZXMpOw0KPj4gK3N0YXRpYyBjb25zdCBUeXBlSW5mbyB0
eXBlc1tdID0gew0KPj4gKyAgICB7DQo+PiArICAgICAgICAubmFtZSA9IFRZUEVfSU9NTVVGRF9C
QUNLRU5ELA0KPj4gKyAgICAgICAgLnBhcmVudCA9IFRZUEVfT0JKRUNULA0KPj4gKyAgICAgICAg
Lmluc3RhbmNlX3NpemUgPSBzaXplb2YoSU9NTVVGREJhY2tlbmQpLA0KPj4gKyAgICAgICAgLmlu
c3RhbmNlX2luaXQgPSBpb21tdWZkX2JhY2tlbmRfaW5pdCwNCj4+ICsgICAgICAgIC5pbnN0YW5j
ZV9maW5hbGl6ZSA9IGlvbW11ZmRfYmFja2VuZF9maW5hbGl6ZSwNCj4+ICsgICAgICAgIC5jbGFz
c19zaXplID0gc2l6ZW9mKElPTU1VRkRCYWNrZW5kQ2xhc3MpLA0KPj4gKyAgICAgICAgLmNsYXNz
X2luaXQgPSBpb21tdWZkX2JhY2tlbmRfY2xhc3NfaW5pdCwNCj4+ICsgICAgICAgIC5pbnRlcmZh
Y2VzID0gKEludGVyZmFjZUluZm9bXSkgew0KPj4gKyAgICAgICAgICAgIHsgVFlQRV9VU0VSX0NS
RUFUQUJMRSB9LA0KPj4gKyAgICAgICAgICAgIHsgfQ0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICB9
LCB7DQo+PiArICAgICAgICAubmFtZSA9IFRZUEVfSElPRF9JT01NVUZELA0KPj4gKyAgICAgICAg
LnBhcmVudCA9IFRZUEVfSE9TVF9JT01NVV9ERVZJQ0UsDQo+PiArICAgICAgICAuaW5zdGFuY2Vf
c2l6ZSA9IHNpemVvZihISU9ESU9NTVVGRCksDQo+PiArICAgICAgICAuY2xhc3Nfc2l6ZSA9IHNp
emVvZihISU9ESU9NTVVGRENsYXNzKSwNCj4+ICsgICAgICAgIC5jbGFzc19pbml0ID0gaGlvZF9p
b21tdWZkX2NsYXNzX2luaXQsDQo+PiArICAgICAgICAuYWJzdHJhY3QgPSB0cnVlLA0KPj4gKyAg
ICB9DQo+PiArfTsNCj4+ICsNCj4+ICtERUZJTkVfVFlQRVModHlwZXMpDQoNCg==

