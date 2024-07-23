Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD267C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 04:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7In-0000Lv-Ld; Tue, 23 Jul 2024 00:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW7Im-0000LR-CF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 00:39:04 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW7Ik-0004Q5-0V
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 00:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721709542; x=1753245542;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0dWv9RLiWI5GD8kSUFS1lAA/eLjGMz6h5owGbqofuLI=;
 b=ek9v3eKobHLETymv7N6X/iGosBzx0HeinhOwtTpVGC6ktgTdNWXi6wV+
 eZrVl20PXqP0fYFNncS+0ukjWNHiVAVDToCjUkpevIBPtFADEV4mNV4J0
 lOut0HY8l4J7B5NOkLGLuIfbqOnQZwGVJnL963LWr5kngOhzKsR7f1ho9
 NXwgZPmZmLEhRJf+n0Y3bk1Tan67ElsAKy4UCtRjG06jtYn2z6i7xG52/
 xLO6ldNCOp8C/s/3Ch1JbXNBLNspOPLY+GaL6t4Z0RO3cTaCfi7UW1Gnz
 DNCTsSjstll4yPuWjdORYvVGeul/yKbNmZJ17dswxBAcdO2g6osYv2Jcs w==;
X-CSE-ConnectionGUID: fuZcYmSAQ1GMYTM7R/Ef/w==
X-CSE-MsgGUID: PsQHFXeyR2uKrTk7rShZAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19186623"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="19186623"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 21:38:59 -0700
X-CSE-ConnectionGUID: XJqTMADARkyRyBgCjBgv0g==
X-CSE-MsgGUID: KgYdxTBwSeGlxqEYgrcjLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="52714498"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jul 2024 21:38:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 21:38:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 21:38:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 21:38:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 21:38:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUERtPy0sgstyV0qci3HQajMs2cQsVrGYypODa/8JH46b/sQzNsOBukev2ip8M1Xajmev173mpHV7VI2WtE/hq4MS4FHYNKlpccyialIppJvU0+DnRWNn7XA2hzN8w7avg1rn6aTSVMu30wXxtgZGmEJx+93S/jG94q8Z4v56AxlAQpBtr63uIivoyI9NKhw/Enz5E1M6ZzWtHYpdBEN/DOKqwrJszuiJDnCnkTIUmCLx33wOSF1ReWxOzMFhgiiK1OI/Ryv6VQcMbPcDycXdR4cbyGO7nIUsgTWwJ5Foj3KxfQwC3oKYUzeO0nA5jM8oV8gqNrwMBYuSiCjdcb+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcL2WKmf/vJxvMv9SnQclolIip5lPKG7B3XKhf/B4XE=;
 b=kOFodfDhZXsKuY7tOKX+oM9MnmCkX/juPUoIVQ7sAK2c1UwSVyHPsB1VccW0bXzELwD2ZjW53x2TOlE2xa8JFfGSLx4RnJTK7QmzdJlu1yRi1oDWBMeRTXKWR87mzp2I/vm+ARh5t6P1fFfHkHEcR74sVmSl2/baxFmIlM5cqpX2BCpxYqasZV+tVKFQ0N52+sPgX06ncDFUN8Wrpsv+ahDI04cU/IE/pp1vaJxJZzw5GEtZiPwmrjSw99KeI/y9TSjA5I1xscberCcUrKUVOXKRpULV8v+WuK5V2M9pteUVLbcAzSOmgB/JTaSWcjlPMcGfnrTt/uHfL8CLbeZeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 04:38:55 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 04:38:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v6 1/9] vfio/iommufd: Introduce auto domain creation
Thread-Topic: [PATCH v6 1/9] vfio/iommufd: Introduce auto domain creation
Thread-Index: AQHa3HwVZmzApuemrEW6P+4wfA87MrIDuwUg
Date: Tue, 23 Jul 2024 04:38:54 +0000
Message-ID: <SJ0PR11MB674493DEB1E8FB2442A4E64992A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-2-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-2-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8210:EE_
x-ms-office365-filtering-correlation-id: c8d94cfc-bc99-4e9f-061f-08dcaad15bff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?j5VPvRFbM0q2TKmuZzWNHYDAkf3qHd98tRuUT413y7dRcijUeNgmu1p/Rh+f?=
 =?us-ascii?Q?44gEZgwcWGJYVwaVKZFAGtpP/UrSC8Qwey0AyD8woCqPRcXBhHO0QUenDn0m?=
 =?us-ascii?Q?yQs+BRKvbv/PmkRv2lD77x45HwfQgDifHy3ZB4v1W8FdynZQhkLHdcfan+00?=
 =?us-ascii?Q?0yT5H4M4QlRB+egdhey39y8swxSgwfCmViPoRMQUd45mFEnOCBIBhWQEdz+1?=
 =?us-ascii?Q?yrQVHruZ5Ds+hzIr16vAawdgH6D9bsQFTabeEmwZjOp9tTN1rYlROx5/FJ49?=
 =?us-ascii?Q?TYUAAQlgxj5ODN79DRSsls/8nk00st9IhN/7YDa16dhwd7PQHPh7bINisvz4?=
 =?us-ascii?Q?ngQ9Qnh2tNl04KqqFPBs2l36xE0vQmRI4BSNX/P7JamiUKjXJPK23Fvmo2wz?=
 =?us-ascii?Q?VNwFWSr0aPkh0TOB99xh3qB8TRPE0XxIg7B9dELt/FOonm5sOFQuNbOAw5gy?=
 =?us-ascii?Q?0OX9rgshCSamfgCOiaUPO76UbrQWEUquY3a6VZFn7ou1EI/uDW/XYbHC6p85?=
 =?us-ascii?Q?Y7k1wuPMYt6O6+V/cLCRG6mFLoaGAK6ZCwpZAnwzP9PBr6IHBUdxb/BdrMG9?=
 =?us-ascii?Q?XVWwoCyUP2wTex+RA2cMEP49xeVMpYd8qNVMf1SbDWSJbATGSJtBSBbby9PY?=
 =?us-ascii?Q?7d8NBRUcXOBUXYo6mCYuHv3kHuG2nPI0MEIojYEoW2Fa4WU2IOQdQOBu0Nv9?=
 =?us-ascii?Q?G/zq8LPlOVtiyA0jI+LTZfePzSTCh+EP1YK4AbihcNW9vSAeeRmGFRb9hI7R?=
 =?us-ascii?Q?58x1/7hJMgAdahrOwmwsPBFVogIdQrDIroQX4VXJmm/FFIIxvm+YyLjcfYxQ?=
 =?us-ascii?Q?bkVWW29SPDbIIQ2yo5fVQfaWHyRvVlKyLmYPBiEnHroo1XYWow1V9DxuKZSF?=
 =?us-ascii?Q?2C7E66hLHvNk6bMuN1i5KaUe3Mu80qeYy/Ocu97tc07tel9USSt9Hn2SXSSS?=
 =?us-ascii?Q?d7saN47NMh3L9VpEgMaFATdV8PJ1ZMr7KhdOuWGHAlLtk/qV8i//w0xr1yhi?=
 =?us-ascii?Q?w1vvKUYUITDUP3p6mAOJ8BjUmkmM7liPaRj92DyvRGwaw9OLmbPcHSZFUn/L?=
 =?us-ascii?Q?IyoqBuTzv6dPsp2K7Z+CZb4MGW+SenajMlhVmc2GZF11lI58QHYMoelhB151?=
 =?us-ascii?Q?taK7yl8L2xL/43sTuS4rgmJ88T/cb6yjt32RE9B94DhPVCGys49zYzgwICHU?=
 =?us-ascii?Q?X/CG4OXlPN2OU3LJ2MN+9yzQ+8WiQq+rl1ZjGNJ1MilThjXpMqRqaOf7p28I?=
 =?us-ascii?Q?7XaSLUiYbElD5tW455oQg1Om54GaLz9B48eFYBHkrWxcz2SkGv/76rFYtu+k?=
 =?us-ascii?Q?ck0sQlIAjwaYHg3IGR20DE5Nz4PNQS01O7INCry2sq1oiTymRuVXY3m1dKvC?=
 =?us-ascii?Q?0Vw0JsUKC+MJTsQwpmkk6lma/vEKl+oo8ofZGzaPZMcFN7Wbow=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FZE9Cui8Nf74ODsVSeHBoVP4UrwsObBw9hSxz9+RA/GSpEYrME+042JL8L9E?=
 =?us-ascii?Q?TaNque/Xe5lfepv97exUSLX7jf1BA7BFj0mcFLE8RQjWsFombxn6MKc+x+Yv?=
 =?us-ascii?Q?A6QK3ukvrRzCI7CNlsX8CQftBKTUqiISLbkdokq/wHnNysj3FMRlJJzRmX7M?=
 =?us-ascii?Q?npZCbPWHbOTTqE0FRA2L38E2BliB/qct9Y+nQaQqZino7c7yKW3A4xOZUoNu?=
 =?us-ascii?Q?LRuwHScouqFyhtt3tXR7ODozRIAUrt2Jx84+lfISOrqnTz00wmN7aFNohaNG?=
 =?us-ascii?Q?Bq+gssU9zvVCn4CrV74YH54vAiu8173CKzDNfEJT7mIXKS/dEaupOpxNQSVb?=
 =?us-ascii?Q?YzD2nsAFYMDdbS+1CbPRwEuWy2mOtgjJ7apT+kThhgODO6GdbMdsd69m2EhX?=
 =?us-ascii?Q?muqiC5HdV3RylDSAnadVQHtkcapH8iGy5CKBAe8qkSsCeBWudFTiVqOzlj2a?=
 =?us-ascii?Q?EO0lOTW8beOeVi0oTQEHISj0XEbYsMwvo/a0X7uGPs8VPh1FsKL4FnM35Ulp?=
 =?us-ascii?Q?45HiisfzwASx9KkE8dMkqIT+M0bWuj/hXm4ogv2Nxs6M3iNamsreHjYb4vF1?=
 =?us-ascii?Q?oWcEv08J0iXdtyIomT4PdE4isTFCMiZwwN/TjjV1ZDlWqOpvZsz4Sl9iUUYn?=
 =?us-ascii?Q?fNq6hgDPphfiDB20diXah4g4HdQGExfIKcbau/rdE4glur997ZOY2qAY0SRd?=
 =?us-ascii?Q?hqRNlo0t0uQ3SLHf1w8XsGZw7fzriqOy1r2o3u7E8FhnL6/i0EnVXXRKbvMl?=
 =?us-ascii?Q?qsdfsV/SSxms9K+2dE9L/ohgdY+EGpROyrZjDK1hQ3MAUVOs7PrPMbbdPQsi?=
 =?us-ascii?Q?rADhfehLMd+hGcycVMRXKhxAq90MZVyz6S53sSt0EQ23iaLaWOfoyTbKYcDR?=
 =?us-ascii?Q?EN+rqp1iED2q7w9oVAFLPwRuznVpJFLkp8AgPrOcNP4MotZPL5JlDMvdz0Qb?=
 =?us-ascii?Q?V2rSmubU44jQ/miYvJUIeuROa8kl9f5pZqSZdld9TV7a2YVcR3viQmJbLd8H?=
 =?us-ascii?Q?+kXlcrlJXiSrMN6NzFRz6UXKq+0tHc+6ruT9cwEDDSe/QyDcUuL+bUsmLCNV?=
 =?us-ascii?Q?Bo1JMlOupYiuE0/QXr6aXk6d+C7LniFWvPowWgATqdHkwbISXS5/GTsSv2z+?=
 =?us-ascii?Q?MUTFZuudVfoW+ojfAHdePFWUHnMx2sZUcd5f3tFNo3ujbhBJ6i6eYQMFuRdJ?=
 =?us-ascii?Q?3cHihak01pKWnvRlxwJzxXbesmBmOUGBUP99Ji/NPaSJUTDYQp3ZZuIYQUCD?=
 =?us-ascii?Q?hAjdBd+TvbLA7ZFmcxxsJEtvwgePhTi5nh1MZt3y2J7BKDfFHcSZCyhCRKYt?=
 =?us-ascii?Q?+0HSGy7EoayS3ZXVsAfpRy5qNVav0Sh3Yqu4WjwX+8yKPZMPLQHNVSCjYMCB?=
 =?us-ascii?Q?VkJmj9C1pZPma+TqJ1X6CS4Q4p/mSgAC+UR524gUDiyyTCaytqOrDnRqVouy?=
 =?us-ascii?Q?d6eRJT8OiEejblP6T1OBLXqNtBZF0AUdnJHyEG7bq2MYy8G/W8re+TQIc4IR?=
 =?us-ascii?Q?h+nb8RwxALKvArRSzZwjzfTaKT3tWy7k84odvuT/wt26XK8cQmMjKLky7EzS?=
 =?us-ascii?Q?U39GDODjkRTi8b/1JtUOK+LbDXeB70ABj0z8pvHH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d94cfc-bc99-4e9f-061f-08dcaad15bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 04:38:54.7727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSbHHlX5g1+sBvhTOdhw+Jh+aURN3Y1oROBiNLcy+YviHnpf0BNhLD2ZGE5O0GvsDS+zZFt4BVfQMRYvmqE7HGHSCKtuTqGw334XM5FXG0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
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



>-----Original Message-----
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v6 1/9] vfio/iommufd: Introduce auto domain creation
>
>There's generally two modes of operation for IOMMUFD:
>
>1) The simple user API which intends to perform relatively simple things
>with IOMMUs e.g. DPDK. The process generally creates an IOAS and attaches
>to VFIO and mainly performs IOAS_MAP and UNMAP.
>
>2) The native IOMMUFD API where you have fine grained control of the
>IOMMU domain and model it accordingly. This is where most new feature
>are being steered to.
>
>For dirty tracking 2) is required, as it needs to ensure that
>the stage-2/parent IOMMU domain will only attach devices
>that support dirty tracking (so far it is all homogeneous in x86, likely
>not the case for smmuv3). Such invariant on dirty tracking provides a
>useful guarantee to VMMs that will refuse incompatible device
>attachments for IOMMU domains.
>
>Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>responsible for creating an IOMMU domain. This is contrast to the
>'simple API' where the IOMMU domain is created by IOMMUFD
>automatically
>when it attaches to VFIO (usually referred as autodomains) but it has
>the needed handling for mdevs.
>
>To support dirty tracking with the advanced IOMMUFD API, it needs
>similar logic, where IOMMU domains are created and devices attached to
>compatible domains. Essentially mimicking kernel
>iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU
>domain
>it falls back to IOAS attach.
>
>The auto domain logic allows different IOMMU domains to be created when
>DMA dirty tracking is not desired (and VF can provide it), and others wher=
e
>it is. Here it is not used in this way given how VFIODevice migration
>state is initialized after the device attachment. But such mixed mode of
>IOMMU dirty tracking + device dirty tracking is an improvement that can
>be added on. Keep the 'all of nothing' of type1 approach that we have
>been using so far between container vs device dirty tracking.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> include/hw/vfio/vfio-common.h |  9 ++++
> include/sysemu/iommufd.h      |  5 +++
> backends/iommufd.c            | 30 +++++++++++++
> hw/vfio/iommufd.c             | 84
>+++++++++++++++++++++++++++++++++++
> backends/trace-events         |  1 +
> 5 files changed, 129 insertions(+)
>
>diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>common.h
>index 98acae8c1c97..1a96678f8c38 100644
>--- a/include/hw/vfio/vfio-common.h
>+++ b/include/hw/vfio/vfio-common.h
>@@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>
> typedef struct IOMMUFDBackend IOMMUFDBackend;
>
>+typedef struct VFIOIOASHwpt {
>+    uint32_t hwpt_id;
>+    QLIST_HEAD(, VFIODevice) device_list;
>+    QLIST_ENTRY(VFIOIOASHwpt) next;
>+} VFIOIOASHwpt;
>+
> typedef struct VFIOIOMMUFDContainer {
>     VFIOContainerBase bcontainer;
>     IOMMUFDBackend *be;
>     uint32_t ioas_id;
>+    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
> } VFIOIOMMUFDContainer;
>
> OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>VFIO_IOMMU_IOMMUFD);
>@@ -135,6 +142,8 @@ typedef struct VFIODevice {
>     HostIOMMUDevice *hiod;
>     int devid;
>     IOMMUFDBackend *iommufd;
>+    VFIOIOASHwpt *hwpt;
>+    QLIST_ENTRY(VFIODevice) hwpt_next;
> } VFIODevice;
>
> struct VFIODeviceOps {
>diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>index 57d502a1c79a..e917e7591d05 100644
>--- a/include/sysemu/iommufd.h
>+++ b/include/sysemu/iommufd.h
>@@ -50,6 +50,11 @@ int
>iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>                                      uint64_t *caps, Error **errp);
>+bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>dev_id,
>+                                uint32_t pt_id, uint32_t flags,
>+                                uint32_t data_type, uint32_t data_len,
>+                                void *data_ptr, uint32_t *out_hwpt,
>+                                Error **errp);
>
> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>TYPE_HOST_IOMMU_DEVICE "-iommufd"
> #endif
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 48dfd3962474..60a3d14bfab4 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -207,6 +207,36 @@ int
>iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>     return ret;
> }
>
>+bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>dev_id,
>+                                uint32_t pt_id, uint32_t flags,
>+                                uint32_t data_type, uint32_t data_len,
>+                                void *data_ptr, uint32_t *out_hwpt,
>+                                Error **errp)
>+{
>+    int ret, fd =3D be->fd;
>+    struct iommu_hwpt_alloc alloc_hwpt =3D {
>+        .size =3D sizeof(struct iommu_hwpt_alloc),
>+        .flags =3D flags,
>+        .dev_id =3D dev_id,
>+        .pt_id =3D pt_id,
>+        .data_type =3D data_type,
>+        .data_len =3D data_len,
>+        .data_uptr =3D (uintptr_t)data_ptr,
>+    };
>+
>+    ret =3D ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>+    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>+                                     data_len, (uintptr_t)data_ptr,
>+                                     alloc_hwpt.out_hwpt_id, ret);
>+    if (ret) {
>+        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>+        return false;
>+    }
>+
>+    *out_hwpt =3D alloc_hwpt.out_hwpt_id;
>+    return true;
>+}
>+
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>                                      uint64_t *caps, Error **errp)
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 7390621ee927..172553b1f7f8 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -212,10 +212,88 @@ static bool
>iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>     return true;
> }
>
>+static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>+                                         VFIOIOMMUFDContainer *container,
>+                                         Error **errp)
>+{
>+    IOMMUFDBackend *iommufd =3D vbasedev->iommufd;
>+    uint32_t flags =3D 0;
>+    VFIOIOASHwpt *hwpt;
>+    uint32_t hwpt_id;
>+    int ret;
>+
>+    /* Try to find a domain */
>+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>+        ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>errp);
>+        if (ret) {
>+            /* -EINVAL means the domain is incompatible with the device. =
*/
>+            if (ret =3D=3D -EINVAL) {
>+                /*
>+                 * It is an expected failure and it just means we will tr=
y
>+                 * another domain, or create one if no existing compatibl=
e
>+                 * domain is found. Hence why the error is discarded belo=
w.
>+                 */
>+                error_free(*errp);

Better to have ERRP_GUARD(), other than that,

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>+                *errp =3D NULL;
>+                continue;
>+            }
>+
>+            return false;
>+        } else {
>+            vbasedev->hwpt =3D hwpt;
>+            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>+            return true;
>+        }
>+    }
>+
>+    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>+                                    container->ioas_id, flags,
>+                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>+                                    &hwpt_id, errp)) {
>+        return false;
>+    }
>+
>+    hwpt =3D g_malloc0(sizeof(*hwpt));
>+    hwpt->hwpt_id =3D hwpt_id;
>+    QLIST_INIT(&hwpt->device_list);
>+
>+    ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>+    if (ret) {
>+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>+        g_free(hwpt);
>+        return false;
>+    }
>+
>+    vbasedev->hwpt =3D hwpt;
>+    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>+    return true;
>+}
>+
>+static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>+                                         VFIOIOMMUFDContainer *container)
>+{
>+    VFIOIOASHwpt *hwpt =3D vbasedev->hwpt;
>+
>+    QLIST_REMOVE(vbasedev, hwpt_next);
>+    vbasedev->hwpt =3D NULL;
>+
>+    if (QLIST_EMPTY(&hwpt->device_list)) {
>+        QLIST_REMOVE(hwpt, next);
>+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>+        g_free(hwpt);
>+    }
>+}
>+
> static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                           VFIOIOMMUFDContainer *container=
,
>                                           Error **errp)
> {
>+    /* mdevs aren't physical devices and will fail with auto domains */
>+    if (!vbasedev->mdev) {
>+        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
>+    }
>+
>     return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id,
>errp);
> }
>
>@@ -227,6 +305,11 @@ static void
>iommufd_cdev_detach_container(VFIODevice *vbasedev,
>     if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>         error_report_err(err);
>     }
>+
>+    if (vbasedev->hwpt) {
>+        iommufd_cdev_autodomains_put(vbasedev, container);
>+    }
>+
> }
>
> static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer
>*container)
>@@ -354,6 +437,7 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>     container =3D
>VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>     container->be =3D vbasedev->iommufd;
>     container->ioas_id =3D ioas_id;
>+    QLIST_INIT(&container->hwpt_list);
>
>     bcontainer =3D &container->bcontainer;
>     vfio_address_space_insert(space, bcontainer);
>diff --git a/backends/trace-events b/backends/trace-events
>index 211e6f374adc..4d8ac02fe7d6 100644
>--- a/backends/trace-events
>+++ b/backends/trace-events
>@@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t
>ioas, uint64_t iova, uint64_t size
> iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas,
>uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping:
>iommufd=3D%d ioas=3D%d iova=3D0x%"PRIx64" size=3D0x%"PRIx64" (%d)"
> iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>uint64_t size, int ret) " iommufd=3D%d ioas=3D%d iova=3D0x%"PRIx64"
>size=3D0x%"PRIx64" (%d)"
> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=3D%d
>ioas=3D%d"
>+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t
>pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr=
,
>uint32_t out_hwpt_id, int ret) " iommufd=3D%d dev_id=3D%u pt_id=3D%u
>flags=3D0x%x hwpt_type=3D%u len=3D%u data_ptr=3D0x%"PRIx64" out_hwpt=3D%u
>(%d)"
> iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=3D%d
>id=3D%d (%d)"
>--
>2.17.2


