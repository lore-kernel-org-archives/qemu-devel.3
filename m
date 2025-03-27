Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C605C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 08:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txinE-0001Xf-2r; Thu, 27 Mar 2025 04:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txinC-0001XE-F3
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:40:50 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txinA-0002Uc-EE
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743064849; x=1774600849;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lqkt2LvomKRHqiUQR2OxoyfwRUXCJa1rfFWDnIH63OU=;
 b=iB34W2mjNr5d60W19wrXM48n8iLB8GuBIMPLXuqAJFSJ0CtRG6F/fin1
 9Or89Wx1hXOKJf6jSQl3ILB069K7BPFPOAqZwpnnZ/5g99DnhgPnViGZg
 nfSa5oxqaYpeF53NBNzYBFPvDkoE/LRL7YQvUBLIEzVuUVzOqtGKzTbMY
 7SF+xk9hD0o7QfsXSwFk+qWBuqacgblUXYOzmmy2JzOrSvu/azxtGvO1I
 8YSrjPCnt0Kh6zhyoH9QlHqlyg0NYYj7QbUdJRua/ko20Mk82K7zfbkeh
 DLMK73x8WCcYDvH/IMTcdOaAHzFLoihR12iuy9LPsubp3xPCNa8Vsnitt g==;
X-CSE-ConnectionGUID: m5hDP4+YTjSgomRMGjtP5w==
X-CSE-MsgGUID: 7dqHWLkiRuWVOyUWp3ETjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="66853223"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="66853223"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 01:40:48 -0700
X-CSE-ConnectionGUID: 1+5xJSk/Q8iJnaUNmWvObw==
X-CSE-MsgGUID: nflGe9V6TsOxu3NH5t+3Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125897460"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 01:40:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 01:40:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 01:40:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 01:40:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7KxvCgrpu8gReYRGRJkhMhzSfDale6XWxpeVjpOU3SEBDTOZXQsWaMY12Yt8wVd7IJxkiDq8Hy2/jm0S0HI8P3lYWKB0cC9OaLFoGqSljPFOIifGa/8xLHdWvtd/zJ/20EhjNz8Qm6eJ4plhFB1+sH4gk1Ck/nWwSjfhGTEX/t9avh6GeoQXzRwKXGbmAsB4Y5BM5Np3UsTpcWsDsFaz22Ih6mHdwq+dTOMNjnLVHq07BqwVmw+j7AqOxKANnqXSti+6Q2eyJJeWd/e+8HJ6EfuMlEf5dvPitryN2l0VBjlxPIA/qMosUKJWPJ2s6SyPxzz9CwdBG3eOZkKOzlsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqkt2LvomKRHqiUQR2OxoyfwRUXCJa1rfFWDnIH63OU=;
 b=nv6L6vkcn+U8tP0J9AxzQcV90H4ELjD+9srO5W+yTABrp6+MOuVS1qiiwFdkGwwgc8LS6azugtAMV2n94IrjwfBPoE7ilrppcvqcMGB2/p1flF8RLpXJ4QRdbW8EHXq3KkPJ9+tWByi0JWEKy1zYe83pU51MoSrvdTAS5CslIRAo8cDTzPi/SWV7OLVlwyUfvJmu4DVJhAc8UVw5ZMOZFaYKevE1rHEBEZPye5eB+0qHj64fb6+A6C2k5ATHC+jKQR2fhgCyTyisGu3UxTcEb/WVATUB3nwfaR6sELEiIpzks4itHdv+VDPY0d6lKrmFhXIihGW+1SFK4YsKDKSYCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7729.namprd11.prod.outlook.com (2603:10b6:930:70::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 08:40:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 08:40:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 08/37] vfio: Introduce a new header file for
 VFIOdisplay declarations
Thread-Topic: [PATCH for-10.1 v2 08/37] vfio: Introduce a new header file for
 VFIOdisplay declarations
Thread-Index: AQHbniQEBKcuDyXBsUmMZnG5y9PflbOGqGow
Date: Thu, 27 Mar 2025 08:40:03 +0000
Message-ID: <SJ0PR11MB674443695F0FA6D62A8E2A8A92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-9-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-9-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7729:EE_
x-ms-office365-filtering-correlation-id: 6a539356-e3a8-4f02-3c25-08dd6d0af7f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?g6IDiUNVOBQnERJB7ItisMfHv6FRMoyYf1VXFc+IByN32oJqex1I48t/o9?=
 =?iso-8859-1?Q?w6BOIrm/Xnaja9jt5H4THXZt5YWyuEpkX/cIIkIOmfjrj5SgEwM6WgcYkO?=
 =?iso-8859-1?Q?+/IC2hy66xJtSYC+EbvCrjOiKI7d8eKeAaRBvVyXBW2/OlhQ/ciOrjtI/0?=
 =?iso-8859-1?Q?7I8XPtjH4PU9PexfQfgzQSy7pS7+4DxL+hPa1qD9t+nj7gyLr4YBtz97KU?=
 =?iso-8859-1?Q?m6yPaQ6qpRzPcaG8srsT0+sCpq2pFxW/K+2c/Dq61JPh+IQ8LYM73j2iSB?=
 =?iso-8859-1?Q?STMD0QIG9NCPgmH16s6BDkBVQu/M5UWeh/MKeP08ArJNxlhIMBFYy0nFwe?=
 =?iso-8859-1?Q?jMvX3rdcJG08K89v9DNCVidUn5FLJc/RftC1bHkH4kiaTKyzZLUCiK7JaT?=
 =?iso-8859-1?Q?LeWDoqyvE+6bHZz1r+R9UGD/o5KxMPFrmyd8DrwU/mZs3eEx4fX0f7BXTS?=
 =?iso-8859-1?Q?dcAtxl1BYZSFBCVOGAD+bHgnpG5EeLW09ZaVFXdZRYob5KRGMinYBCs8g4?=
 =?iso-8859-1?Q?LKinGPPLVi6Jd8yzLfKEECPY3LiBlHZ8/f0UUXpwfU3O+b12OXl95QufZp?=
 =?iso-8859-1?Q?qHJnEdTciMPYUZn3xmsO4UQ6Ra1j9IJlzSgunFt82n+urpG5EYsbEJJ5QG?=
 =?iso-8859-1?Q?6zYa3+B5tLaj3l12/zO7fJ+dGXOUtHIFbHEyanN2uIiOdyGaTdIgifxoGV?=
 =?iso-8859-1?Q?f3mLXIZyir7IGB5g6TBaHDzSCVeq6KqpUwOIsUCudN/NDYDq8PGvk1Nooi?=
 =?iso-8859-1?Q?UC4CYhD5l1TE42PRZqD1DzwQPITHMw7R2rjM54QGIxLbnARpBQZCsNqDtY?=
 =?iso-8859-1?Q?s+0blxqcxnL194/SewdQRaVkIthEUvScCMaxr97ejRjBiqG5bitCZEBGUq?=
 =?iso-8859-1?Q?b9GWSpyXkOqiyPD0MmJhKjIVY3ofujcWHjWnlUsrDiimEMQ5E/HusUKF3B?=
 =?iso-8859-1?Q?kIIXHH8TfCDYa4IxF7uyibqg3vhZKow7l2TVXXPAiFWUeo+I9p/B05Ui6R?=
 =?iso-8859-1?Q?lXGmghuhB2TZ7j8q4a/qsWZHeWLttY4lddQhpnedv2QQX6KF6H0mB+J35v?=
 =?iso-8859-1?Q?aOchk4PHRIFcuBseieUdoGKRadsfgIKTB+iqjxOz1sNynPS9J0NUigwb+U?=
 =?iso-8859-1?Q?k6rdFW2p5JDZ7YrtjQY3tuk1V34SVUF/8TaI/kwnxV+p6bVbigN5stNQT2?=
 =?iso-8859-1?Q?9Yv1V7/OD8yjowqWPewikg/ot17Kj+Cx2qOiTAGgvNthCppeFpiw4Ch6z9?=
 =?iso-8859-1?Q?lUBY02irfM5KfrgEvK1PhFW/Uq6roP8zZzuwhC8knXXsxROQdaXHvMToBH?=
 =?iso-8859-1?Q?kDcgzw4U82ClITd0bstlyl3s+dnVHbQeqhH+nDXciUd4Uhuic+jYrWhXKk?=
 =?iso-8859-1?Q?1S9JlY9QLdotKMkAPvRWFipNhC4JG0Ar003yvlsDkSjcVoX2YrSUBITzlN?=
 =?iso-8859-1?Q?lCkYwGoj1HZ+uxdILTu1Apg/QbkOyEJhEInUD/ktB3U6ATzCiLVHABuNiU?=
 =?iso-8859-1?Q?fXq7Fm4BNvW5hPkri0+NSy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?++W7/ShFLWv9Ya/4etXZbpkhYEY+WjZPuy5wrYTaFgJrGOk6OVo+SWtwzz?=
 =?iso-8859-1?Q?gSZlwfyHM1f03HYfzRFIe/5rotE0Vf+Ju05W4LXHEfUzqldLKhFJdCWSmn?=
 =?iso-8859-1?Q?1K/zDnWOu0MMCD/bbvNqkYtmlDiuSZxopEO1HpsyBttDDNXXqP6fA2knpM?=
 =?iso-8859-1?Q?70dVd7QIEbXM6FMrm9QCuN9OQFeXIVWmwTd1ztg7hYAHZkZ/uLSRR9qCBw?=
 =?iso-8859-1?Q?oR1WKmoab4/0qVX/QJfGSYjPGMFnSOWAuEl3ZnQHS5h08U7cnSpmmpx+eF?=
 =?iso-8859-1?Q?KgD5d15vP7e5oQME+ly8ilJwboLRHwILD2/82rnla+LvEmiIqQKpMSRFJZ?=
 =?iso-8859-1?Q?RFmyfGxjEqU26kKTPc8zcXXKOlERSW4D2d2xgdpsrE6fi1i+gAhl/zj2AN?=
 =?iso-8859-1?Q?qSjj1QrSfEb7y2z1E5av8876RXL9i5drBqd5LPlLt+2/fuFWT3O4psfZu4?=
 =?iso-8859-1?Q?4EQ9sAQaq4HpVV0vDYZxR7HSIjWyNAKYa+6DGzhl6VJZz/dMrTh7qeMDhs?=
 =?iso-8859-1?Q?vJg4jroF/gD1JIV2BHDqds1NnVfHGu3ZCJOFZw5zzqriC6gLwgKbuyVUtN?=
 =?iso-8859-1?Q?MUZyeZH5av//ucrQ5oax6RzUgHnyyZ7KOEMiYdSNA7/juhHqk+YPZWn+Yh?=
 =?iso-8859-1?Q?7ujeqgXN6cRCxkhOZtGg3Tx0HQT5Hl++4VIR1FbN2XL/RACmz+yHbHtmkd?=
 =?iso-8859-1?Q?UbEYnoKlCsxgVpIZEJLhJkHxynjwLFvhPo+h9OOKv97ORmLiA5WcSHiKmO?=
 =?iso-8859-1?Q?g5p9pxPLnJLa1U8oSuEdVWMXtxPTLuYBIbp/EJiLzXMnNLY+Tkx23tM2OI?=
 =?iso-8859-1?Q?Asjul/VnggGqPSCCloEdHCsxT776KGZHpTNKWRR4Oq+7tyKTmUq7E1+dyq?=
 =?iso-8859-1?Q?sHkFq9MxbXK8qoA4MOn4YgKiuV09PO3Qj9toqM0SBb75sSiIDuTXyB6ru2?=
 =?iso-8859-1?Q?jDtDVVBiDjBCngPElqEhLECQ2tlVW9NUCuKdcAr6JjhVD6uvS49/jgnmxq?=
 =?iso-8859-1?Q?JFun5z+91mxtcf3KkL17Nqh2V4MuXgIY4Ou5pYcEVMBMrgQ/m5Qqf31Lm/?=
 =?iso-8859-1?Q?gyuihEWuiRbOX6Wf15LFSsFw/0ZCH/Jw4WhuSwpoKxoonFkvLQAoByqElP?=
 =?iso-8859-1?Q?zEnPbiN0ByIXYfx5JY0E3GXLDXxAUJ54cD7vCyme9l/61QrY2KWqj3NNdI?=
 =?iso-8859-1?Q?jSRFYqwyl1kGbuKmGuAsQOVJObwzCPo8Qckt4s9trtOsH/JEjsWJHLViI0?=
 =?iso-8859-1?Q?q3/9xHso8bqLu9xjL77x8Of5A1khimjqktrfMkB8823PEQ7hNpb2zVaPDu?=
 =?iso-8859-1?Q?RH4J+dMm96r9KHBnLZ/nfMUREmrni9qBnMY8gKkXj2Oo05262tGFmkFmMq?=
 =?iso-8859-1?Q?Sgh/4lUckpMDYWMiwf5nffvG4O+83JAc23bmZ0c48pM+yW+m3rLDqepJ54?=
 =?iso-8859-1?Q?JFiOR7wU9OLYvc8sXtBPIglS42E6K5f4ERINaBVraiIL5PUo0qx0eviBw7?=
 =?iso-8859-1?Q?u89095QtlmxaK2G9geOd+WiLf0/19vwaW7WTBFTrdnxGn2R9ksci/prTGS?=
 =?iso-8859-1?Q?xkYeoOd9AHlN5VSqEj3M4/aBI2V9eRd7wU+BP/w4DwI/2r+x8A/gzYd8Xk?=
 =?iso-8859-1?Q?x6K3Hls4OQHd+KWXCrEWNTA5lTYWRJGZDY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a539356-e3a8-4f02-3c25-08dd6d0af7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 08:40:03.2827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+JuCaVY4GOCP0dcZiVaayc6VYNBtKRqfo1Ek8RuSuKH6lxqoYEmyUYnxSfNfZXKvX+7wcz++Hcy+md6tERn3F8Cgi9jz+Daq4HsxCG8Chc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7729
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: [PATCH for-10.1 v2 08/37] vfio: Introduce a new header file for
>VFIOdisplay declarations
>
>Gather all VFIOdisplay related declarations into "vfio-display.h" to
>reduce exposure of VFIO internals in "hw/vfio/vfio-common.h".
>
>Reviewed-by: John Levon <john.levon@nutanix.com>
>Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-8-
>clg@redhat.com
>Signed-off-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

