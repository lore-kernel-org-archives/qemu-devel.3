Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BAACD5BB4
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 07:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQK8o-0006MT-Jo; Fri, 22 May 2026 03:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQK8m-0006MF-SX
 for qemu-devel@nongnu.org; Fri, 22 May 2026 03:17:52 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQK8i-0003gF-R6
 for qemu-devel@nongnu.org; Fri, 22 May 2026 03:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779434269; x=1810970269;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YgSVqCF+BsHl8GpDENLj5yX3ehn9j3ds85qdYOao8ss=;
 b=E4bQkkVqLHpQ0Ehg9NMj8+tT6C0iJ/3GkWVtqMePmrCDa3mY1aKsWR95
 faB2yjVe4lFA9N1+3yM+TOe8u0p10sUxZkq93lFpnjrJzqLSMdW9HXVDZ
 h5LlfNLVQyFsC95ftq/3W5d3fpviFESNZBtr/Lld7S5cyPJa7BWTqpuxs
 oUji14xGXCAXLRticGNG1O3xZ4HYJMpd9sUH/3x7UGn1NgHLos/e+tBNf
 9hathfOUitZn4VeeVEZWQN90Vc4ggim+IIxIBaphLmqvdGk2wklB5sG9L
 ApJhJ9XESjhxHByryx9okf+cefd8IKZeecCCjGf0btSMJZ6i0D9DgMsnG g==;
X-CSE-ConnectionGUID: FynVPpviRB67JqcNk25TKw==
X-CSE-MsgGUID: 4rFL+ccKS+qRceL8T6GOrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91051402"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="91051402"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 00:17:43 -0700
X-CSE-ConnectionGUID: sTPlp2r8SdiWMZTROpzeJg==
X-CSE-MsgGUID: S1qcNvSPQRi4RClcfkr4jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="238237265"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 00:17:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 00:17:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 00:17:42 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 00:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRD1LPSMsl2IGFbmk3yeuQe67piH0RfNvfH4tYfcmiosM9HPesCr7y8aWZ3X45J+zscGulTI2NP/SNeYsnRBhRneCaskqDREGuTa+o2j1x+/F921VonsjF8z+95/vr87KgcgBg0S3vvQnUgdYNjHDzI7evj+BZf7LeeTgSpa6HHQ9OPi874JKviTaiwKl9M2g/uPqfT53FlT72vwo3OMB5J4jClzH2OWhBOswBwrM+XdidFYxqHB0xg9YNQ/eLw6zn2UCk+2+UHa2KCyBOGIWot6kruSadJPKCKXAFDlCcl6EB7lSB7vkp/BJrT1x4OVfksv2rzxctTGwi23DBIsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgSVqCF+BsHl8GpDENLj5yX3ehn9j3ds85qdYOao8ss=;
 b=QaheqWDPImo8629n19R3LkE7eN6GBuSwRpw+UTOzjwSEyhAm3WM8KYGYcwowPaW59PjMMZX7V4WodERMyzV88Angr6ZxctOFsWzMaZBDwldrFcDIwUmL9l4+WOe4NVOEnQO7eJBSztDOqDuPe8aodEIVbd3qrAV1/b3DgkEH0nmhCE6WFXaH6O4dsCsI5Orxas6j54EjroECERktsc/1o7xFmLdQ9IbycIOp/I+WK0+MeeDsGzfhbiRulAaoWcAWzrwBrWOnTuzkseKT3A4Zo+jHhLewm3xAnEbMNL948JozV8KNJ1FJ5cB9J+66NILCYFeJ5vKCBQFH0FJb5qe1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB8293.namprd11.prod.outlook.com (2603:10b6:a03:44f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 07:17:33 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9913.009; Fri, 22 May 2026
 07:17:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: RE: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
Thread-Topic: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
Thread-Index: AQHc32mcVP/GY7HLckeIzCovUgMZdLYNac+AgAeWiTCAAa3PAIAAAqxggALlkwCAACBW4A==
Date: Fri, 22 May 2026 07:17:32 +0000
Message-ID: <IA3PR11MB91366F6E763BDF93EE03D732920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-9-zhenzhong.duan@intel.com>
 <eb419b7c-8fe9-421c-b0b9-d2dd5993e6d1@intel.com>
 <IA3PR11MB9136FA1C2BD60E9A028FC71692002@IA3PR11MB9136.namprd11.prod.outlook.com>
 <053b39b1-c522-491d-a36f-aa105485f916@intel.com>
 <IA3PR11MB91365BAAAC96F5E996416BC592012@IA3PR11MB9136.namprd11.prod.outlook.com>
 <c7f4ef02-a25f-4dc1-895a-4c3686ab6b4d@intel.com>
In-Reply-To: <c7f4ef02-a25f-4dc1-895a-4c3686ab6b4d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB8293:EE_
x-ms-office365-filtering-correlation-id: b1935150-e727-41c0-70b9-08deb7d23117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|18002099003|38070700021|56012099003|4143699003|22082099003|6133799003|11063799006;
x-microsoft-antispam-message-info: vRmtljlOVpvfTznvnBPS45oL/gaJgE3JA2T8zyTjHMupCznDm5JHxSxs6IcgjCHHT+oe+zdjAepNTgfDEDFd0IthuZS2vd2M240BhC79KbQ992GrBysEzD9ELYOJhhaHFxsDmBeEiV9gvzGVVpbkBY9FZvjBHkd6mMXwTApmXKjel8omUNiwp16nRP5OuorqZpuRWRDqq6NCCT1hFi46kMQ68wh9p4ZdxQxs6ZD6giMeQEF3i30lV9sFmHUQ/SmCMz6k+xWcMlRgCI6yyAOpFvTb/W4pyT4dg7qtaG5XuP1R4NrxLuOyEMdgKAWWjAHZwoqmbRUaANTyGLu8z3lvYtu0db4uPEyn6DzukxeYN3wycNs0A2kfy9RA0BuF3vUJMsRMhPq3JWq4pjPvxxAAKPe40rMkOjOhqGvmvckZPZ1y9iS8+tGzp1Gfvt9XKWzc7u1WXVHw7F3PfJEoztdyTc4/zhC1zC+FLur3LyLntTErp/xCRAXlORuuq/ev5H4tERTm62Ah71SsiuDZKhex+rI7WAioAQHI6uSOJNoYBX9vR7HysvwaJjwoV9eaLia8hU5gIqPR1JWmG1Dtz4WLTIInONxSGmFHBgOk9pY7NJxDr1sWRTnM6tKq7JGebGqmRGzj4f0f5B8dtY/W6hlK9lP5X5ukmyBkbUxewXtzrSmuYElJo+pIXGymEBOjehy3Bh2Q5lVsZ4XutL2/VQSqeozLNjLNk2Kay52l2hzCiYTp4RPnjsoNVd+IIbqlxFde
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(38070700021)(56012099003)(4143699003)(22082099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MERnTnUwQWxJZ0h5NGZNNU0yakhLMG9iMW53Z0ZUTE5jSHZHdkIyN3doY01Z?=
 =?utf-8?B?RkpiVCtHVGQ0M1RWbGpsTWhST0tnL2JzRjREQ0pHcTRidkdyOXFLcWJUNENv?=
 =?utf-8?B?eCtObGw3VE80Tnl6Ry9UYTNZd0d2eDBMQXNybEkxeklCdGdqNmxJRkZxWTMy?=
 =?utf-8?B?dU01TGxHU2ZVUS9LMjlUWWltdHhCODhGK0VLakFkcFY3N2ZBVlFJRGkrd2Fu?=
 =?utf-8?B?RVlDWERwcytnVnBOVTNiaXZpOTUxOXhEc3NTeEV1S0s4VElZSnRtWENCMFor?=
 =?utf-8?B?MkdaUWl4Mi84N09zMkhtSS9udC9TeHhOZWdiZGZMenc2NENsMGxkWmhSTzRW?=
 =?utf-8?B?UytVRmdoWkw3N0wwenZOVXdZcDQzcmNpNWNEWCtFeTk3ZFE0Z0F6M2tuUWYw?=
 =?utf-8?B?ak5MZTJLNlNWZ3JkK0l2VHIxMXJTQ1JQY3VDbHFyMUJDVUJPWVlEeFRTdE5n?=
 =?utf-8?B?VUlqRmtQOHAydm5FdzNiQW1kUGFRUnBwZXVCbWgxUkVqYU1STVZEYzZKK3JC?=
 =?utf-8?B?TldjaXhLUUxob2t4SE9qbFNvSXpxNUlIanJMWTA3Um9LOTR4T1lSdEVZdVJP?=
 =?utf-8?B?QUhIaHJmMTVML0Z2TXZRRFdUMW9rM04rWHpEc0lwK3ArdUZRNmJsTHh6ekNm?=
 =?utf-8?B?TjhTWkVCYjlmcDRjdm1XYXF1NUNteit0YXFuTFI2LzF4aXRsVkE3dlQ2S1Bu?=
 =?utf-8?B?cTRCVTY5TlVDMUFtTWxoNy9XWW9XN0NEeTUvNnVTeDErSUdPS1N5M3N4TVNE?=
 =?utf-8?B?NCtMazZMVEgvZEhEejJqVVFFVThPTlpCd3lqdWpkdmwwZUtYNU1DSzduMnNG?=
 =?utf-8?B?YlQwaDBpTU9iNU9WVG41VTQ0V2FVWlpoamRWTG9aMUdna1JLaktxV1JxV2VG?=
 =?utf-8?B?UHZzSnhnQTlzZ2FVV2pQaWdPbjdkclJhTXA1ZkFuNE9NODl5SmZCRmFxc1Vo?=
 =?utf-8?B?S1RLcTFpaHZrekgwRUNvZEtBbTJvb2FteDdaMTdzSFpZRE53ekprYVpUaHpq?=
 =?utf-8?B?djFpNzBKNjVOSkxSRk83c2YxVFU1QU1QV3dEcU90WGZvTCtUcGFhYm1IV3Uy?=
 =?utf-8?B?czhwUDVMMjVOQzJpSjVyWGVUVGx5alFZSGQyc3BMUGx2M1VrTmZRY3QrN2Zs?=
 =?utf-8?B?NTF0SWMvbnpNT3ArYlpuV1VROENiVGszVDJnWHFyZWh1QmdpelltMkFVNThN?=
 =?utf-8?B?NjkzQlh4aksxNGs3SU5rT0s5bkRJaEtTYW11bHVyUHhCT3RadTNzMlZ1QmJ1?=
 =?utf-8?B?VGFwR0FPaVdtT0hrRnpxQkR0VFJ0MEZzeFhBTmZ3c1BBUkZJa0MrR3ZDZkp3?=
 =?utf-8?B?ak14TE04MmhGamdaR2VBN0dmY25jekVxZXNXdzdlcGQ0UitWMExCa2NaWk8x?=
 =?utf-8?B?ZHJZMVRFQmQ2UUpsS0ZTNmJob2hDVExpUTB0S3ZSMmprRDUvcTdYSzFsMnNX?=
 =?utf-8?B?UU9HTkNSa1hnWkVzeWhGbUExc0dITnl6aHhqQ1gweTVzUVRXUHQyREpxMitk?=
 =?utf-8?B?dnhKNUJodEZyd200a0ZBWWcwS2FOMmRXVUg0SEY0QWJFN3BBcHJUOVZNK0VY?=
 =?utf-8?B?ZHZJaUZnYllFN1d3emVOTWR6MHphU25sQkpKSVlXa1NjZDgrVTQ3Qml6OUV1?=
 =?utf-8?B?Q1hhTXd5QVhjMGx2WG45VzZ0NXFPNmpuUEVLQnNyalVEbnQySEVncnovZFNP?=
 =?utf-8?B?RXFyUGdvWklhYm5hbENSMWxsSGR1UUQ3aVdtbDgvNW00dWJhTWVjTDBIaWRp?=
 =?utf-8?B?V3hWNWRFR2Frc3IxRFg3Tm1hUnB3Zm4xTDdMU29DYmwweitKUnQ1MGJ6eHhj?=
 =?utf-8?B?bForQTYzSTZ1UE5TYzJITzh4cVV4RXN6bVF1TFJXM1pMVXVoSWJHOUdscmpr?=
 =?utf-8?B?cjc5cTdkMUdUUzhjMElMRCtTcWZCTStpSDc1dCs4ejE2YjRWck5WMHo3eHo0?=
 =?utf-8?B?N3ZVQlRNN0J3djdzS2JiVkhKbHowN0VjQWJmVHBIaE9wS1ltV3pQUXV0Ymd0?=
 =?utf-8?B?TjRaeHlScFdYdWlGeWg0bzZ1L0plNlVRbGM4dkFPa3RaZDd1QkNJZnZJSmtk?=
 =?utf-8?B?SitrbFRpbHBKR05QRVcveTc3bk9LanJyTVMyUURabUppZkZ4L2VkYnNiSVVv?=
 =?utf-8?B?WHd3S1crcFllK21QcEdEVzdKaUpFUkdWWUszM3lpSVRSMkpBOW9wcENsRWlt?=
 =?utf-8?B?VEhIUk5RK09WT3EyOWlzekZldmZFNE1SMUhuN0FWNGRUOTRpRzB6Y0o0MEc1?=
 =?utf-8?B?VSt6T0RTTUJCTUVMWWlCeURDR1VkZllKWFM1Mi9lTTVFZVZhb0h5UjZTVXNW?=
 =?utf-8?B?M1NYbVFUUGFXcVJEUG9iZHRsQWFoNzVKSmppa0ZCT3hIU0YwVjdMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iQ0lolVoZjJwQna9qzakm9gsFa3jGnpVf5DCB8KSz0c2Dzupgjk+TBe6JsHS6ioSA1GfFCR2Ia6+5FRD0tsGqPYWXDUaoD/Xn/S5+mesSxnGCEFqZjwvcbm8OJIngFqASDgUKPhbaQeDfnu/ex3H8P2nRl9VynD7/v9zMHHXk9OHYF6CvAgZ9MFo6nVJsFlY6+N6V6zTVsCUpA24f8FeHqYtFrK5L3ZDF0D3utcdS8MCH3P9B9xMufQsYs7PC6Mik25CkK0JWdEaY7lOR3437oi+arcRq1HAVQ9xidHVxEl5CZOI0gajy/c13NQHajfS5zJ0xjjUWjKlcfmxdWEueA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1935150-e727-41c0-70b9-08deb7d23117
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 07:17:32.7418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7x4RtNxwGHbYkzU4dCxAPcY638WfbrP8qBAKtRu7Di0qUs1/YVpE/XLPo9GDsPlQiFaIm0g3V5z7ut4LSzHVmVXT6Df+iCWIDTV0U8yPSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8293
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDgvMTVdIGludGVsX2lvbW11
OiBSZWZhY3RvciBQQVNJRCBwcm9jZXNzaW5nIHRvIHVzZQ0KPklPTU1VX05PX1BBU0lEIGludGVy
bmFsbHkNCj4NCj5PbiA1LzIwLzI2IDE5OjAwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+
Pj4gQEAgLTIxMjEsMTAgKzIxMTIsNiBAQCBzdGF0aWMgYm9vbA0KPj4+Pj4gdnRkX2RvX2lvbW11
X3RyYW5zbGF0ZShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQo+Pj4+Pj4N
Cj4+Pj4+PiAgICAgICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4+Pj4+DQo+Pj4+Pj4gLSAgICBp
ZiAocGFzaWQgPT0gUENJX05PX1BBU0lEICYmIHMtPnJvb3Rfc2NhbGFibGUpIHsNCj4+Pj4+PiAt
ICAgICAgICBwYXNpZCA9IElPTU1VX05PX1BBU0lEOw0KPj4+Pj4+IC0gICAgfQ0KPj4+Pj4+IC0N
Cj4+Pj4+PiAgICAgICAgIC8qIFRyeSB0byBmZXRjaCBwdGUgZnJvbSBJT1RMQiAqLw0KPj4+Pj4+
ICAgICAgICAgaW90bGJfZW50cnkgPSB2dGRfbG9va3VwX2lvdGxiKHMsIHNvdXJjZV9pZCwgcGFz
aWQsIGFkZHIpOw0KPj4+Pj4+ICAgICAgICAgaWYgKGlvdGxiX2VudHJ5KSB7DQo+Pj4+Pj4gQEAg
LTIyMzUsNyArMjIyMiw3IEBAIHN0YXRpYyBib29sDQo+Pj4+PiB2dGRfZG9faW9tbXVfdHJhbnNs
YXRlKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBQQ0lCdXMgKmJ1cywNCj4+Pj4+PiAgICAgICAg
IGlmIChyZXRfZnIpIHsNCj4+Pj4+PiAgICAgICAgICAgICBpZiAoIXZ0ZF9pc19yZWNvdmVyYWJs
ZV9mYXVsdCgtcmV0X2ZyLCBpb21tdV9pZHgpKSB7DQo+Pj4+Pj4gICAgICAgICAgICAgICAgIHZ0
ZF9yZXBvcnRfZmF1bHQocywgLXJldF9mciwgaXNfZnBkX3NldCwgc291cmNlX2lkLA0KPj4+Pj4+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRkciwgaXNfd3JpdGUsIHBhc2lkICE9IFBD
SV9OT19QQVNJRCwgcGFzaWQpOw0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YWRkciwgaXNfd3JpdGUsIHMtPnJvb3Rfc2NhbGFibGUsIHBhc2lkKTsNCj4+Pj4+DQo+Pj4+PiBh
IHR5cG8gaGVyZT8gcy0+cm9vdF9zY2FsYWJsZSBzaG91bGQgYmUgInBhc2lkICE9IElPTU1VX05P
X1BBU0lEIj8NCj4+Pj4NCj4+Pj4gVGhpcyBpcyBpbnRlbnRpb25hbC4NCj4+Pj4gcGFzaWQgPSB2
dGRfYXMtPnBhc2lkID0gaW9tbXVfcGFzaWQsIHNvIGl0IG5ldmVyIGVxdWFscyBQQ0lfTk9fUEFT
SUQgbm93Lg0KPj4+DQo+Pj4gbm90IHF1aXRlIGdldC4gSXQgY2FuIHN0aWxsIHBvc3NpYmx5IGJl
IElPTU1VX05PX1BBU0lELCByaWdodD8gSWYgbm90LA0KPj4+IHRoaXMgbG9va3MgdG8gaGF2ZSBp
bnRyb2R1Y2VkIGZ1bmN0aW9uYWwgY2hhbmdlLCB3aGljaCBzaG91bGQgbm90IGJlDQo+Pj4gZXhw
ZWN0ZWQgYnkgdGhpcyBwYXRjaC4NCj4+DQo+PiBCZWZvcmUgdGhpcyBwYXRjaCwgSWYgcGFzaWQg
PT0gUENJX05PX1BBU0lEICYmIHMtPnJvb3Rfc2NhbGFibGUgaXMgdHJ1ZSwgdGhlbiB3ZQ0KPnBh
c3MgaXNfcGFzaWQ9dHJ1ZSB0byB2dGRfcmVwb3J0X2ZhdWx0KCkuDQo+PiBJZiB3ZSBjaGFuZ2Ug
dG8gdXNlICJwYXNpZCAhPSBJT01NVV9OT19QQVNJRCIgaW4gdGhpcyBwYXRjaCwgdGhlbiB3ZSBw
YXNzDQo+aXNfcGFzaWQ9ZmFsc2UgdG8gdnRkX3JlcG9ydF9mYXVsdCgpIGZvciB0aGUgc2FtZSBz
Y2VuYXJpbyBiZWNhdXNlIHBhc2lkIGlzDQo+SU9NTVVfTk9fUEFTSUQgbm93Lg0KPj4NCj4+IEJ1
dCB1c2luZyBzLT5yb290X3NjYWxhYmxlIGNvdWxkIGtlZXAgZnVuY3Rpb25zIHVuY2hhbmdlZCwg
cmlnaHQ/DQo+DQo+Z290IHlvdXIgcG9pbnQuIEJ1dCB0aGlzIGhlbHBlciBzaG91bGQgY292ZXIg
Ym90aCB0cmFuc2xhdGlvbiB3LyBhbmQgdy9vDQo+cGFzaWQsIGl0IHNob3VsZCBub3QgcmVwbHkg
b24gdGhlIHMtPnJvb3Rfc2NhbGFibGUsIGJ1dCByZWx5IG9uIGlmIHBhc2lkDQo+aXMgaW5jbHVk
ZWQuIFNvIHRoZSBsb2dpYyBkb2VzIG5vdCBsb29rIGNvcnJlY3QuDQo+DQo+Y2hlY2tlZCB0aGUg
b3JpZ2luYWwgY29tbWl0LiBJdCBzZWVtcyByZWNvcmRpbmcgdGhlIHJpZF9wYXNpZCBpbiB0aGUN
Cj5mYXVsdCByZXBvcnRpbmcgd3JvbmdseS4gQW5kIHRoYXQncyB3aHkgeW91IGdvdCB0aGUgY3Vy
cmVudCBsb2dpYyBoZXJlLg0KPk1heSBuZWVkIGEgZml4LiBCZWxvdyBpcyB0aGUgb3JpZ2luYWwg
Y29tbWl0LCBhbmQgdGhlIHNwZWMgZGVmaW5pdGlvbi4NCj4NCj4tIGNvbW1pdDogMWIyYjEyMzc2
YzhhNTEzYTBjN2I1ZTNiOGVhNzAyMDM4ZDNkN2RiNQ0KPg0KPi0gU3BlYyBzYXlzIHBhc2lkIGlz
IG9ubHkgdmFsaWQgd2hlbiB0aGUgZmF1bHQgcmVxdWVzdCBpcyByZXF1ZXN0IHdpdGgNCj4gICAg
UEFTSUQuDQo+DQo+ICAgIg0KPiAgIFdoZW4gU2V0LCBpbmRpY2F0ZXMgdGhlIGZhdWx0ZWQgcmVx
dWVzdCBoYXMgYSBQQVNJRCBUTFAgUHJlZml4LiBUaGUNCj4gICB2YWx1ZSBvZiB0aGUgUEFTSUQg
ZmllbGQgaXMgcmVwb3J0ZWQgaW4gdGhlIFBBU0lEIFZhbHVlIChQVikgZmllbGQuDQo+ICAgIg0K
DQpJIHNlZSwgeW91IGFyZSByaWdodCwgd2lsbCB1c2UgInBhc2lkICE9IElPTU1VX05PX1BBU0lE
IiBpbiB0aGlzIHBhdGNoLA0KbGV0IG1lIGtub3cgaWYgeW91IHdhbnQgYSBzZXBhcmF0ZSBmaXgg
cGF0Y2ggaW5zdGVhZC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

