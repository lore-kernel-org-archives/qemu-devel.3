Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B93CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 04:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v74SN-00049e-6A; Fri, 10 Oct 2025 00:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v74S8-00042D-6N
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 00:10:03 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v74S0-0004B6-Ml
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 00:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760069394; x=1791605394;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Sj47PuwpqJ/h5SloobEC1YLtXVBRHkCTnW69j0+dMII=;
 b=cWSUEAV1ijtfXh65RzNX2EakYGfXASGeoQMSEXlgj0qUikp1rqNVtZK1
 Ly9t2NV8Rc1/AHEoQ46cYzSt4Pg2HqFqbxkjyBlSSvKpWvx1d+47EWlno
 fhOlQ2Pbut25j0RY3ZNmYe52/5g4pTJXSS1MFIqfU1grAP2TbYzBFA9/3
 AqNmyXkXb+xCDo50vhlz1G3F70l8xOHwhbf0qD5HApGonrKCkdgxhp6Pj
 beIcC5uLXD3P3LPbuP6koxMfLRio1mOlPccS94tELyPNF8YJZ5j+dj7/f
 wDV1eXqwh3YNDPKSu87vab7VGQKiqXckQZlvg6xfTxF+v5TeallwiBuks A==;
X-CSE-ConnectionGUID: iM6oUnklTuiDv+uHMQDBuQ==
X-CSE-MsgGUID: K+9yokN6Q2acX2P9nEBQlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79730894"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208";a="79730894"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 21:09:43 -0700
X-CSE-ConnectionGUID: 0G+pNw2eQ0Gw+NWHelnS9w==
X-CSE-MsgGUID: yY/LJ0lcRd24MQKWFmwj1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208";a="181305658"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 21:09:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 21:09:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 21:09:42 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 21:09:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnGGpAyzZyAU8cZsyRQ8/DlsV7BcKWKvKRZeNdRfXlfD45wR9GQe5TpPa2ehDLcxVvdyGz8QBKcrxvyNgQ53f6pjsZ7dBjbF9W4LFIyy/tU99RvkQZPcj4CR/pHWlUapYtiMbfUZjwboLLkwbhQ+ztlQKUF0WMYy+GkNzLZS/V+liE7hSjs9PVcPdgoL8eb1scCLwfaKcTPj1FXkbvSGFH+mNLGVxCQAYzYFTzCbdC2CB/fYX+6vFMwj2hDvLmVyIySxH1FSKR3/nk9Gu69vE4ujkLZJiR/Qqvr45JWT7DlAChwCo+tfeM/RZbNOQTKmHGNIBR+HYKrTfuP5M14eTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj47PuwpqJ/h5SloobEC1YLtXVBRHkCTnW69j0+dMII=;
 b=v78nQkV1r49GwYT/RV1MNFXJQuq3ikA4DdLeIb4HqKqXJ6HdSOw6X1lT5NqOMuf4x3FlUxiZ5VQtK9FNmCSgPvfL6LAqMkQg9UTAKYU1AMYr8hjVVkJt6DqzMG2f4xaa083ghdUs5BB5cnkcNdowaIerv8UrQyvoNkpJ6eQ8p/6tpSrIeAWo+sAjWpbrX48PPamCoSfTZDLI6cBGawoyc4nmtpVCJ08YRkR1pxwLQw31WgdOBSune9Nm7U80cPxbqIswQlMewq8+rvBgKsajwVkRdrzRU9XMiNxwW9QCS9i53D01dToa+6tzut5bn4M0bphAdF1DvaKltksBC5inAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Fri, 10 Oct
 2025 04:09:34 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Fri, 10 Oct 2025
 04:09:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "avihaih@nvidia.com"
 <avihaih@nvidia.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, 
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Topic: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Index: AQHcIfvtcDcAUY1arESRh5H1VPguD7SaXCYAgAQ5VOCAANsXgIAaVi/wgAApxQCAAP7DUA==
Date: Fri, 10 Oct 2025 04:09:34 +0000
Message-ID: <IA3PR11MB91368A6D6FA2C1260E7188C292EFA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
 <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
 <IA3PR11MB9136B9DA08CC2A48E1678DED9212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
 <IA3PR11MB9136EAD2D625ED90DD89A13492EEA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <835d840f-ad65-4f09-8d5c-051e32641ace@redhat.com>
In-Reply-To: <835d840f-ad65-4f09-8d5c-051e32641ace@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MN2PR11MB4695:EE_
x-ms-office365-filtering-correlation-id: e5b5f457-70bb-4f66-9037-08de07b2d237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M3dZejllU2hnNk5FV2I2TzFmZXdsOHhrdVRRT2dyMVJUbS83QmJBRkNZM2Zj?=
 =?utf-8?B?c1lHOGh2bnkyVnRBR3creXlpMklpd25sS3dhRDRpVWRZcTQ4SDUyZEhHZS9H?=
 =?utf-8?B?aUF2K09Dcy9EOTRQclJVWkdyWE1FZTRtNjlPY280dHVhSjVLWEZyRjArQzMx?=
 =?utf-8?B?c0F5WjJTMnhaeTRFL21RREErODl4My9JTHJ3Wk1sWDRsUXNNN0wyVW1pUm84?=
 =?utf-8?B?dG96UDY3NFlqUlZXTS9wa3Baa0VYSjVEUkNjUGdKSjVSd1QzQlk5dmpKWWxQ?=
 =?utf-8?B?NmErc3kxaU1RSCs5MHh6WmJvekllUENDQUpaNVVrYUVvRDl1Lzl2Tmd4N2xS?=
 =?utf-8?B?R1VyYm5IWmJ2RmJuUmFvd0xjanp1WkhjSlFrdEhRRFc2RCttbi9UZzVuREp2?=
 =?utf-8?B?T1ZsL3IvenVNVnJzTzhMUmM5QkNBNC9tYk9waldad1JaNUFDWmJ6L0tQZ3dL?=
 =?utf-8?B?WVJPUmZrbEQvaXZOeDUxVmpCenRFcFh0emI4L09uNjlkTXhvcVpXL2N4Z2FI?=
 =?utf-8?B?bXJvU3pOejdNZTVsVHFnZDhoSisxTUIwZlNraUhwWnY2cG9VaC9yZkVZK0NH?=
 =?utf-8?B?Sng2OHhSSjA2aEhVMU5FcWJnTjljV1hMMnN6ZnFvcUpIbnUxMTNEd3AxZzkv?=
 =?utf-8?B?WG1YSENDUVRxaGY0amE1K0RzNkxWZnRTVUFLTWt6TytqY0VmR3Q3Rlp3MWVX?=
 =?utf-8?B?ZmM3S0tqbyticm16OExHMmFmd1VST3FBUk5keCtNVnFjODlIMTYwdnA5R2RL?=
 =?utf-8?B?NlZKajJBTlFmTkNHbXRTVE5za1NLQ3laZGlFNzRvRWQwNWdKdDdlSDFsMlE3?=
 =?utf-8?B?UDN0V20wbWlhS3oyY0MwdXplN1d6V3FMemhONWswbjI1bVl5enJkV3RhODlz?=
 =?utf-8?B?aVdmK0tudGNjeFNzRGpTR3pRbW43Q3ZLbkt6c3FReENhQW13WFByZ0JOdG82?=
 =?utf-8?B?d2tiZmZhNGpEZndYUnVpRVd4RzZNSXM4UU1MWTNsMlJQNFZNSTROYWhWUW8y?=
 =?utf-8?B?NXFhQmpsS3dKdjVqYThwaGdKYkVvUE4rbmoyOHk3OEdPS0hDVzBoaWhKd2NQ?=
 =?utf-8?B?TjhYalN0MDFEK3p3YTB3aUsxR05zUFpoUHJKd0IvbURYZ1Jtd1pBS2VybGJq?=
 =?utf-8?B?bDJkVXBYa1dQcVlxZFI0b2pFMU9NZ042OW1FRmtUMjY3QVV5SkxoclNPNUYw?=
 =?utf-8?B?T2t6MmNvT2xuTVlpN0g4dTNVNHJGb0NUcDY1azFBM2dDNnZobmdwbnVUZFpp?=
 =?utf-8?B?YWNHY3EwQy9Icjd5Z2JMYXdhdWw0Nlk3aWxpNnhMbXpGOEFUSzRZRTloOXZX?=
 =?utf-8?B?TE9QdEVUa2JZU0xtSWZydkJyaFJaRHlNUCsrYkJiQkNyYmUvdENzUUVZL0wz?=
 =?utf-8?B?WkJWQ2U2ZFVhaUFDa2RmNGlrdy9vNk1HY0p5V0lEenZPWVNNNHVKdnZUZkZx?=
 =?utf-8?B?ekxOMUVyODd1bGZ6SUhvK0pWQTlyNXRDYmhobEcwclYzbm1JUDdIcWR3aFNW?=
 =?utf-8?B?cVEwTUxVSHd6Z0FaMmNRdy9CWTgwNmV1SXRhVmdORHFQcWhmWGxKc1gwNHVE?=
 =?utf-8?B?QVBqMGlLTHgwam5MT212TEF0Z3NVNHR4OTRtME54dy8yYXpqaHZUUnJuVHBC?=
 =?utf-8?B?NFJuams0WlRGOHErQVpQWm43aWhGVnFyUEpMb3d5V3RXZ0dTbU1kNUwxTTJn?=
 =?utf-8?B?dXRlYUNrbFpUWDV5ZjFsY1FCU0V4c3pERUhUOGZpd1VZTWYwakthVmVxSnJa?=
 =?utf-8?B?RGo0YmpzY0JvV296ejd5SEpiU1pXSWpuOVZxSHozOVRJbXQ3bndadnRvMlhw?=
 =?utf-8?B?anQ0MngwdUcydE9wdjhUUXp2WDU2c2RQazRDeU9MaGNqWm5Fd05LVVlsWlJx?=
 =?utf-8?B?UnU0OUFQLzMxU2ZoRWFPTkpvTWpzM2NWWU91YWU5M2lEZDB6YnI3M0hlVWds?=
 =?utf-8?B?QVl0R0hiaThnMEU5RWlpSkphNjB3QmtJLzBlNjdtVVFTbDdpQUxDY2Jpd2pp?=
 =?utf-8?B?ZWlCZnZxSHV0OVVBQlBEYjYySzNDeWNTNVo3QW1QN0tlSVBKeE94WWwwSjVS?=
 =?utf-8?Q?shEOrH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3diWjMvcVB0ZG1sWDdKVlg2ZVR0OUZOZWVIclVKTFh5M2RIOFBYcFRtc2NK?=
 =?utf-8?B?dTcvOVZ3SjdqMWtEdVhCa0tYQWJDeDFXWm84YWJWcTZjcWY1YTlOaGlQTmtO?=
 =?utf-8?B?T1ZJc2xaaWdTS0t3blhIdHJleWtsS0VFczltOUNweGxPaUxtTkhVYWZlUi81?=
 =?utf-8?B?b0FJcDFLSktqZDc1bHdmbjN6L3p2RW1CZk9JTWtSZHk5Tkw2dlRsUzVKWWI1?=
 =?utf-8?B?VG0rRjFoVHlnbTJaUzdlVGpqNDZZTzZWVnFCQlpEVWFTaEtuQnhacHlMN20z?=
 =?utf-8?B?bjN2eVloUURNempreEd4eTNqMzhONWZCWU1hM0lXTUUrTDlOY1NZamRodjJK?=
 =?utf-8?B?cDRlRXkzQzdvdjgzci83L0svM1ZjRENXdGc2L1U3cUN4VEVQdE51V0w5TzhL?=
 =?utf-8?B?b3JsdE9xVG9HZklwcXJtQVhNeWk4NkM4Z1N1Wlh3dVJUeGlDQU5WcGJmdmNS?=
 =?utf-8?B?K1JhazVqNk1jSFIrQ3dDWXhjVGxFdktRUTdOdTBOUXd1M2plRStRWWk1OWEw?=
 =?utf-8?B?SEswTVpBeFBObjJ5bUJBV05QRVM5R2szVDFkZXBqYkIvQk94TGFOZ21qcmVQ?=
 =?utf-8?B?NDJQRjZJaVVkNUlMdE1vQmFFczZ3K1J1Q2taS0JSTnVIQ1Y1VFNXb2NybTVs?=
 =?utf-8?B?dy9qWFkvN0xpdWh3RUNiejFsdXVRVDJIUFhrZjIwSy9PM1ZqQ1lYWVp0a3pY?=
 =?utf-8?B?R1htdnNzY1I0U21IMDFuYkpaTkpIM1BBTXdJYUhYY1BpMFZRV2V1QnVnd3Jt?=
 =?utf-8?B?bmppbjJ3M21pSWdDYXdUcllpOUdqTExZN0hqR05DOGphRXlSckdnYkUyVk1E?=
 =?utf-8?B?ckF6b3E4dVl5RmhtVldIekJicHRMR0JYUEo4R1pmSDM5Y3Rqb0xDMks1WWRH?=
 =?utf-8?B?cXFoZlNJdVVRZHV4cDdCODRudFk2eHJsaXFHb2dFTkJBb1luWTROWXR6dkd4?=
 =?utf-8?B?NEp1b01hWjZFT2tYc09DQmcwYjRaSFU1NEFOcVJJck1SdlB6TGlJdnpEUkxl?=
 =?utf-8?B?NU9IRHdRckJ3cFlsd0F2L1JwRUQwUGtBM0ZCRFZJc2trU0krdUlxS3U1QWt0?=
 =?utf-8?B?OVgvT2RaNDNCVlZXa25SUGgvWDlGSlg3Yjl5VnZxRURkN3EvUEpHQXAwbjlZ?=
 =?utf-8?B?bnhIYVZtK3RCMzA5SmtRQmt2aGlTanI1QjhuYUpRSDJIdVN2ZlVrbWtodFRU?=
 =?utf-8?B?RzAwMGpKWXp3dlJ3T0JYTjhydzRTekFwNkQwMEgzdkpPTHk1bFpNdFZQRFBN?=
 =?utf-8?B?Qlo2UzBYbXBVT0xtbmZxUGpJWUszQW9vSlhvYzVwN3F0REpxSnBiR1FqYXNX?=
 =?utf-8?B?MzA3U0YvMTBmMndzbkc4QjBmOXkzZFRxbjdWV3hPVVJoWm0ycVlYOGcvRXRG?=
 =?utf-8?B?T2sxR2gyd3JLclBvM0Z0UmNFbGtVd1B0NEVBSXpUWk9ScllBSE02QVMwREJM?=
 =?utf-8?B?NEYxOTVDVHVEVTF4d1VqY2JlTkNpUUFBcnVTRTAwTjBUR1pSM1N4WFZlSitj?=
 =?utf-8?B?Y2FTVWJySFhZcnlmakg2UGMvYnVjb2MrbFJqRGNUNmdIblgzRHRWS0Y2d3k3?=
 =?utf-8?B?cG9QVUJJS3F4Y1BHelk5MEhDVktBdDhLK2N4UzlZRSthdkx4RytxUk1kMkVz?=
 =?utf-8?B?MWVKTjdXOW1ncHQwVUczOHF3VTBrcnhWU1dKWTNsQzNoNm1jdWxPSE54Y0w0?=
 =?utf-8?B?VVUyUUY0b1lOeFlxeWY5V0ljb21EZ1orMHBaeFJOc3V1bzRDakx5aTREU2tH?=
 =?utf-8?B?YTB1dks0YXM3N05VQkFYME01SjNxdnpMQUJkdk93ek13YmE4VXVRT3BTcTBq?=
 =?utf-8?B?RTY3UlQ2REljaThHKytKS1hWSy8zK0RRR2NRbDg2MTRvN3RLOS9UcWhhNVU3?=
 =?utf-8?B?KzRRcS9jWWZaaWFqNjBLdmlvcjZTUkJPZUp2QU8yMExhZlc4cktETU9DR2ph?=
 =?utf-8?B?Rko2d1NxR2c3Z0tpWEt0SVNNYmg2b0t1NEJsNDBxMzlZekd1blNNZEtDcjRM?=
 =?utf-8?B?dEtQTXNGRk13RGpVbjZaWnlZU1RadFI4am8vMWtlRksxektVYmVrZGFsZVVJ?=
 =?utf-8?B?dFJhMlhMd1F5bWZ4TUx5VXdnVVh4NHphTmRabWJ6VE8wSm5mZm5EUUd0VTFt?=
 =?utf-8?Q?30+ucRTPnD3pfaVkpfoPUa8tS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b5f457-70bb-4f66-9037-08de07b2d237
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 04:09:34.5292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJnZ77Cgak9WqZrWfFgj6UghTRLzcCAMedug4u/sc/v2P1XmN0FusQ/DgZFH8WqcvdQkdCeQ6eI49ztht4x9aS6PE/5JTi5xyt4DvkO1+Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5SZWdhcmRpbmcgdGhlIHdob2xlIHNlcmllcywNCj4NCj4qIFsx
LzVdIHZmaW8vaW9tbXVmZDogQWRkIGZyYW1ld29yayBjb2RlIHRvIHN1cHBvcnQgZ2V0dGluZyBk
aXJ0eSBiaXRtYXANCj5iZWZvcmUgdW5tYXANCj4NCj4gICBOZWVkcyByZWZhY3RvcmluZy4gaW9t
bXVmZF9jZGV2X3VubWFwX29uZSgpIHNlZW1zIHN1cGVyZmx1b3VzDQo+bm93ID8NCg0KWWVzLg0K
DQo+DQo+KiBbMi81XSB2ZmlvL2lvbW11ZmQ6IFF1ZXJ5IGRpcnR5IGJpdG1hcCBiZWZvcmUgRE1B
IHVubWFwDQo+DQo+ICAgTG9va3MgT0suDQo+DQo+ICAgSW4gYW4gZXh0cmEgcGF0Y2gsIGNvdWxk
IHdlIHJlbmFtZSAndmZpb19kbWFfdW5tYXBfYml0bWFwKCknIHRvDQo+ICAgJ3ZmaW9fbGVnYWN5
X2RtYV91bm1hcF9nZXRfZGlydHlfYml0bWFwKCknID8gSGVscHMgKG1lKSByZW1lbWJlcg0KPiAg
IHdoYXQgaXQgZG9lcy4NCg0KU3VyZQ0KDQo+DQo+KiBbMy81XSB2ZmlvL2lvbW11ZmQ6IEFkZCBJ
T01NVV9IV1BUX0dFVF9ESVJUWV9CSVRNQVBfTk9fQ0xFQVINCj5mbGFnIHN1cHBvcnQNCj4NCj4g
ICBTb3JyeSwgSSBsb3N0IHRyYWNrIG9mIHRoZSBkaXNjdXNzaW9uIGJldHdlZW4geW91IGFuZCBK
b2FvIHJlZ2FyZGluZw0KPiAgIHRoZSBuZXcgJy0+ZGlydHlfdHJhY2tpbmdfZmxhZ3MnIGF0dHJp
YnV0ZS4NCj4NCj4gICBJJ2QgcHJlZmVyIGFkZGluZyBhICdiYWNrZW5kX2ZsYWcnIHBhcmFtZXRl
ciwgZXZlbiBpZiBpdOKAmXMgY3VycmVudGx5DQo+ICAgb25seSB1c2VkIGJ5IElPTU1VRkQuIFNp
bmNlIHdl4oCZcmUgbm90IGdvaW5nIHRvIHJlZGVmaW5lIGFsbCBwb3NzaWJsZQ0KPiAgIElPTU1V
IGJhY2tlbmQgZmxhZ3MsIHdlIGNhbiB0cmVhdCBpdCBhcyBhbiBvcGFxdWUgcGFyYW1ldGVyIGZv
cg0KPiAgIHRoZSB1cHBlciBjb250YWluZXIgbGF5ZXIgYW5kIGRvY3VtZW50IGl0IGFzIHN1Y2gu
DQo+DQo+ICAgSXMgdGhhdCBvayBmb3IgeW91ID8gQSBiaXQgbW9yZSBjaHVybiBmb3IgeW91IGJ1
dCBKb2FvIGRpZCBwcm92aWRlDQo+ICAgc29tZSBwYXJ0cy4NCg0KU3VyZSwgd2lsbCBjaGVycnkt
cGljayBKb2FvJ3MgY2hhbmdlLg0KDQo+DQo+KiBbNC81XSBpbnRlbF9pb21tdTogT3B0aW1pemUg
dW5tYXBfYml0bWFwIGR1cmluZyBtaWdyYXRpb24NCj4NCj4gICBBY2sgYnkgQ2zDqW1lbnQgbWF5
IGJlID8NCg0KWWVzDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj4qIFs1LzVdIHZmaW8vbWln
cmF0aW9uOiBBbGxvdyBsaXZlIG1pZ3JhdGlvbiB3aXRoIHZJT01NVSB3aXRob3V0IFZGcw0KPiAg
IHVzaW5nIGRldmljZSBkaXJ0eSB0cmFja2luZw0KPg0KPiAgIG9rLg0KPg0KPg0KPlRoYW5rcywN
Cj4NCj5DLg0KDQo=

