Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48CFFF60CF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7T9L-0005qt-Jw; Tue, 31 Mar 2026 03:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7T9K-0005qK-Bd
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:04:30 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7T9G-0001wV-Rz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774940667; x=1806476667;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XGskdCVd7KMex76UkPTuHS9JBit9AJzq1yNHw+QZYJs=;
 b=Go1PR7wDFRkYkytc/I0hKtRwLalpaQeecfh6uJXwkmMp04SSsLbsWfea
 t8TWK0kRdF1y11DVxY2C5sUWumMYVSCDTnwTPmfvoQmqorh5+0xRKDrNw
 yyiJgyRKq/oUhd0tnhBw4/9RrmiaS0DP8bFxZpguWLkqN/BJGFJIM58SV
 BwDs90DZdFTilGK2Qajuqb7AUk3vMJi9lhqx0EeXLWrEMw2tbSKru0jqP
 s4wcvrVvz7A7arUTYlHUzOQn/EuD8mpgAXuIxJKAkL4VqaY3pYEmQ3eWE
 LhDTMwBuDv+7+7GC9xOrAokx6w/WoGH+9uS3JPnIK91EsGoEBr/A0yebp A==;
X-CSE-ConnectionGUID: q0JIOsDuQQ6dIaV/Y8cpjw==
X-CSE-MsgGUID: ooIkpvN9SrG+ZYfJjdoKJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="79545216"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="79545216"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 00:04:23 -0700
X-CSE-ConnectionGUID: Au/90bEhSq2JQz21tZQSqw==
X-CSE-MsgGUID: AZCUseLcSLmOvWFw/rTHbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="219638708"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 00:04:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:04:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 00:04:21 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:04:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLCRD7CN7fIgY5vin1fF+wevf+KfHBNPhT6aTUvaol1m0w9CtV7qUU9ZqfvLVFlttWSUmLMFhy7/GJfc7yrKVnx3ehBodGnVlfUN4yAyrQwh+RxoooS5JLjtjfTYguQN0IuoTrNj2kqQhBpyQV5LznoaBk/rc9ImP4Bsf7x3U+Dbcub1IqxSKuNMVq4a6VTcODLTnLIkO7Uf6Nt/ALUVRy9th+M10HSvW6tDFdD5vnBI+Iqh6k9P0nzYxl3Z+NqUmi4bz/kj/jnEYC0FshQfAorbv3o8BsM/Og8Q/IeJUQj3b0kJLu/fKF7pHnidv8qh44e/I2S1/WDJhj3MTlBdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGskdCVd7KMex76UkPTuHS9JBit9AJzq1yNHw+QZYJs=;
 b=cZzrgTLGINrsEVyCqAYSZPgcXKTtsB6J0qa4FB+RCMJcZRMgjQ0/GhVj5f2I0MqTZiTzm9iSlIc3bdQli597/WYnYetIDsxsf29Ofveaxj66d+uCKu/rOx/MkvdQZBrVzrZENrp4kNm7fR23/rUvxwmfxIMF/UsYNaEYwqNcMassBDKYxmpZ1eRoH+5tGI/HP0DMKWSLr6PmiUjoM7D7lRRLzNW2giAPi24E/QUHQ+mBQWFJvO6ynOKaK0xArCARqLG0rG30biC0uZLjIv+pq9EKw5iDplBoSfBjoui3BGxnJ1cSUdD4BcmkmCVTIWShfhfbSa1OmqUgfAyrDHUhmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB5074.namprd11.prod.outlook.com (2603:10b6:303:97::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 07:04:13 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Tue, 31 Mar 2026
 07:04:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v2 09/14] intel_iommu_accel: Bypass PASID entry addition
 for just deleted entry
Thread-Topic: [PATCH v2 09/14] intel_iommu_accel: Bypass PASID entry addition
 for just deleted entry
Thread-Index: AQHcvQCrtodBsFlvCkmykun8jWxvM7XIOusAgAABsJA=
Date: Tue, 31 Mar 2026 07:04:13 +0000
Message-ID: <IA3PR11MB913675A71560D501547E90349253A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-10-zhenzhong.duan@intel.com>
 <6d905f2a79b7a4904659db14d05311784a790a7e.camel@eviden.com>
In-Reply-To: <6d905f2a79b7a4904659db14d05311784a790a7e.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB5074:EE_
x-ms-office365-filtering-correlation-id: 0422a0b8-8fc7-4597-3c54-08de8ef3b731
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 6VSS5o1A9wMu/b11Jcpr8re2/69MFPtN19P6+y+eErk3JPPn54KMiZYauUJSgla5igX7DAv+MylcumZubFbayoOXMxDPUm5ciJUMApoWNG+Sb6+K+c4lPRFdX06/xohCXKM/JbjiXlNiH/HeCw9QER1KaZq3RUJgP1ndtaBDjUdWLMnXBszNghbUDXIgcFaCC6//rKtkm4VUpI8R10mvhyTLGwpzzkNiEzFGTYB33YFU84Rtf84/9HdzM/yAxKn11eQvsaLZpbNTJ0DWsUJLmqSdpLEJEfELFV29OMVm2TJvtiJKvoKhPqGOsufobJkLHU34c67D0piTO7VQK8p7Z88p9l4V/sZy5uUqKwsHyMg7AGYrhezzdMtO8plKrftO0xmwpQ9p7wzEQskgu3TUn/KmgqN9bmaYJB0i4OYHKd9uwrzKCYQ13iMiDb3RmbdqoVYjfck1M4G8a8vCJ7pZh8yX5NX7rpdtR3SkaG/y4vwD7jS7xtVUjdcDErxLCSz6iF9WrTU9u44aGhUeTx/ib4RqjXp3sYD0ffwABoBrXQ+txRTMJGOwEQoMTr35bypd9r4h8t3FyKS68pqWPbe/nAKfVOCtJvz56c/Mhy9FYC3fJWbtLwyADRwdrKIIW6pTUdw47MG9JyVmYl1ZyU2NziJMTy39IpyTNf6KQSS7m/nls2cMr8/fV5qJYHBt8ZXSLc3+T7vFonnLIDriyK48HmDkdMNvlOInuV/6V9SFQE4JY2GVgh6YqO1oo2jHefFbzve9r6giv6GYURZHt94GHpsVdqggOhAs8xmiiVk3Fpk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlJhT2srcDIzZE1nVW8zSkthNFVkMnFDMy9rT3k5aWRXTjVlZWs3SlBzUmox?=
 =?utf-8?B?K1lUczFtWHljcnZaemtKdG5KcEtYMTgyN3ZTM2JJQmhUbFhqai91djkzby9W?=
 =?utf-8?B?TkxwSVZzZEhLZzdHNEVsZCtQR2hnL0I3VW5hVWpVSTdPdDNVUXc3VHJBbHJZ?=
 =?utf-8?B?TW1PdFhYMk9weHduTEt5bUVBUUY4UGdnUUJUUGVGK1plcEwrSVlFaXgzNUdU?=
 =?utf-8?B?ejJVVmh4UDdwQnA4UE1md1VGYkNGajUvNEwxSXZiZXlzNW9YY2xVZGttcWw1?=
 =?utf-8?B?Z3dtUjVYVWp2dnowb2JYODlOWElMSjEyWW1rNkxWeGlZelhKUXFjQzZ6Q0ZS?=
 =?utf-8?B?ekxkWDUrRXk1eXJCU3J4WlBFbXpZR3VYbFAxNkduMU82S0NlT1VRSHBjVGVV?=
 =?utf-8?B?d2NMaGFGMGhOa3lFTWNESm9iQmpjME9NdVFXb1N3cHAyUzc3R1lJTUkzNkNH?=
 =?utf-8?B?RDNBVk9hUDlOd2dRQkpYdDBIUHREaGJWWkVYMzdKUjRueWhySGUzc2ovUG11?=
 =?utf-8?B?OUowc014VFdGTE1hUGduUjhWWVVEYUNsZTdFN0pNNWhXMCt6WkhuTmd4VXJs?=
 =?utf-8?B?SElFak9wZTJ0TitsMXJuWW9aaVdHYU5vM3Vjd3BhdkZTaG80TE84emR4STg0?=
 =?utf-8?B?ZldBWURJUXBHaTI1U2xrUFZqeXhybE9WQ2JZQ2dJVjl1ekJaWDlRQll6cmsw?=
 =?utf-8?B?Y3JjUC8wRWU4WFdncGYxd3JZczExUDNkZ3R6VFVuc3pNRU14bDdleXhXTTFp?=
 =?utf-8?B?ZjFnejdvbXZicm1JNUlQMENuaUFDMWNkTUZjbE5RdGZyNjFyUGRyMi9ONlFy?=
 =?utf-8?B?cUh5V0w1Qkk1djRjb3dwUzE4ekVmc0dkK2taM0ZIdDByNDZpOWdySU9Qb1pm?=
 =?utf-8?B?Vy9sTmdhNVJxbjdWdFdTa3NJKzFRVGRrbnV3Q0pzQXlCTlJzSmY4U3kyVkZ4?=
 =?utf-8?B?a3BhcXVtUC9yaGFaOW51NDlKdm95bGtXUnZsbkpNendGZ1FqTW1Jb1I1UldV?=
 =?utf-8?B?MERCL0tiTnRhY0VLWitUazcrajJNeVAwYi8zOCtOMU1nOEttQ0h2VjFtVjcv?=
 =?utf-8?B?eXhpR1MydGFUdHlGRmorbWFXUnVaVWtiL05LMFV0OGNKOHJzMEhFSUNsQURk?=
 =?utf-8?B?Qjc3ejNYbXgvd3MrL0pBdlVxelErclp6K0U4eVR3SjRoV0tUMFdnQTFDOGFT?=
 =?utf-8?B?ZmZqb1Fkbml3SGMxeStsd243VjlGSy9YdXgxSkE0UkVXN1A5ald5bE9lVkxU?=
 =?utf-8?B?RC9KNHBwY3hWZG5peFpxN1ZWUndxWUt1NGZGeXFLU1dDZnRlZUc1dVdTMjBl?=
 =?utf-8?B?aUhScGVQeU9uVWNSaGMzeHI1YlI3L3g3WnY1a0ZCbDdSNFN0LzhuRW44L1Zi?=
 =?utf-8?B?b0dVdy9VeWJ5aUFHZWR5QXRTU09WNzdUQjVpd1lHYkpKZU4wZVpyZlVRcTVv?=
 =?utf-8?B?eC9LL2VGSktGL0RTdmlwVTNGeGxrdEVObmd0MU5VM3ZHckNETDR6cEdxWTRv?=
 =?utf-8?B?VllzZ0xWMTdBcEFURUd2MFJGa2t6d0Z4MFZCMnV3dU01NTFlS1padDBneUY1?=
 =?utf-8?B?TmpNRHdhb3gwWTYrRWZRazlpSlJPU25IUzhuSU1VVXZndEErdWlmZXlOTU95?=
 =?utf-8?B?Z2s1MndtUXdKdi80Q0xhSzRUYTFFYjZBcUxmaVM4R2hKeTFNZzFhc0g3anQx?=
 =?utf-8?B?OUtiNEdPd1kxUHZ6YnpyZjZUWHpUNkJuQS9iYWN6ci9OejJMQ0JZNzVycWdG?=
 =?utf-8?B?TGl3eGQwTWVVV29rOElvaFU1M0plNWpQTWoxaHQyYUJOdWZkbU95a2xvRllq?=
 =?utf-8?B?ekp1TDJ6eWtJU2UrV2E4TkVTcnMrT0NnZDFUL3FHaWJsWHJhV2k1dWp0VGhN?=
 =?utf-8?B?VXRMSlZTVkRoOWpVZG56dmswMkU2ajlsS3JSQy9rbTg0ZUJFZWJ3MmsySm4w?=
 =?utf-8?B?dGxod2czOHMwS09IUGxVMUQycnQ4dTQ4UzBHbTVrSTRXaTVOR2M4MVBpSEdL?=
 =?utf-8?B?QVBtalhFRlJrR2RyemZDREhPODhZZ2JldEpFUnZiRHh2eHpSMVNld2xtNVR4?=
 =?utf-8?B?ZTJYU2U0amhUTWcya20ya2xpcVpUR3hJN3hKZDdBbjlnazFMd3JQWHhvcHFW?=
 =?utf-8?B?SUJycVpYWExBSUgrUUU3eUlSdGJkQlFaZ1VVYXpHeldjUEZqVG5wZW1oSjZV?=
 =?utf-8?B?SVJHclNXditoUzNKSjVHdEgxQnFSSHIvTXpmMUx5dEl4MXdPZS9tZDNMdnhu?=
 =?utf-8?B?bXd3aFpheTIzeFo0ZWw1ZEkzNk85UHZBNzZKNVNYZmF1RU4wdkxYNjJhSlJG?=
 =?utf-8?B?QWR5VzMzQnVpcktwNFZGUHhzNHF0b1BzRFpIU0dMaVFzOFd6cElYQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jifr7hPxPQtmM5/iIkgOPKauUn96X7kpm/kRtjkom9KX5dPeFntgFnAY1Ovq3jPZ1ZJbZ7ZXBex3pbR8I3a2944HpVTh33j3bYtJvFL5N5KZxdYOlBJbcHo7PN2kjxR5YH5xz2mb2uvQLaMTvJjCI5hoanAFUsGZTSBKQyShFF8gJ4zViA1gNLlglAtzrLWQVV/+mCn7Ly3Zr1JnnwD0SS/CMfV7x9k/j+LSt2C4on1suBLEZbSEECDgCgNMrjcDM69pItD/tQ5PBFsRtRosPrfaXZK5TBCjDX/v7EWx8/WIMW1escj2x4FCqgZhyGvTrH26xMkBQ4RnJqKxiUwTxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0422a0b8-8fc7-4597-3c54-08de8ef3b731
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:04:13.4462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PnHD47hHVEdX3XOrXaWFdYPkTGEd3jGqojq57ctgCVuPNIT9gsJDwqUo19b/1aeIEn3MzjjMODElFOsYb9fSfbTJb+Dnq7d9GDzp+XuXbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5074
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIgMDkvMTRdIGludGVsX2lvbW11X2FjY2VsOiBCeXBhc3MgUEFTSUQgZW50cnkgYWRkaXRp
b24gZm9yDQo+anVzdCBkZWxldGVkIGVudHJ5DQo+DQo+DQo+T24gVGh1LCAyMDI2LTAzLTI2IGF0
IDA1OjExIC0wNDAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEZvciBWVERfSU5WX0RFU0Nf
UEFTSURDX0dfUEFTSURfU0kgdHlwZWQgcGNfaW52X2RzYyBpbnZhbGlkYXRpb24sIGlmIGFuDQo+
PiBwYXNpZCBlbnRyeSBpcyBqdXN0IHJlbW92ZWQsIGl0IGNhbiBuZXZlciBiZSBhIG5ldyBlbnRy
eSB0byBhZGQuIFNvDQo+PiBjYWxsaW5nIHZ0ZF9yZXBsYXlfcGFzaWRfYmluZF9mb3JfZGV2KCkg
aXMgdW5uZWNlc3NhcnkuDQo+Pg0KPj4gSW50cm9kdWNlIGEgbmV3IGZpZWxkIGFjY2VsX3BjZV9k
ZWxldGVkIGluIFZURFBBU0lEQ2FjaGVJbmZvIHRvIG1hcmsNCj4+IHRoaXMgY2FzZSBhbmQgdG8g
ZG8gdGhlIGJ5cGFzc2luZy4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IFlpIExpdSA8W3lpLmwubGl1
QGludGVsLmNvbV0obWFpbHRvOnlpLmwubGl1QGludGVsLmNvbSk+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbg0KPjxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXShtYWlsdG86emhl
bnpob25nLmR1YW5AaW50ZWwuY29tKT4NCj4+IC0tLQ0KPj4gwqBody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmggfMKgIDEgKw0KPj4gwqBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmPCoMKg
wqAgfCAxMSArKysrKysrKysrLQ0KPj4gwqAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBpbmRleCBk
NWYyMTJkZWQ5Li5mM2NiNmNmZjFjIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+
IEBAIC02MzEsNiArNjMxLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREUEFTSURDYWNoZUluZm8gew0K
Pj4gwqDCoMKgwqAgdWludDhfdCB0eXBlOw0KPj4gwqDCoMKgwqAgdWludDE2X3QgZGlkOw0KPj4g
wqDCoMKgwqAgdWludDMyX3QgcGFzaWQ7DQo+PiArwqDCoMKgIGJvb2wgYWNjZWxfcGNlX2RlbGV0
ZWQ7DQo+PiDCoH0gVlREUEFTSURDYWNoZUluZm87DQo+Pg0KPj4gwqB0eXBlZGVmIHN0cnVjdCBW
VERQSU9UTEJJbnZJbmZvIHsNCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2Fj
Y2VsLmMgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+IGluZGV4IGMxMjg1Y2UzMzEu
LjFlMjdjMGZlYjggMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMN
Cj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gQEAgLTMxMSw2ICszMTEs
MTAgQEAgc3RhdGljIHZvaWQNCj52dGRfcGFzaWRfY2FjaGVfaW52YWxpZGF0ZV9vbmUoVlREQWNj
ZWxQQVNJRENhY2hlRW50cnkgKnZ0ZF9wY2UsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4+
IMKgwqDCoMKgwqDCoMKgwqAgUUxJU1RfUkVNT1ZFKHZ0ZF9wY2UsIG5leHQpOw0KPj4gwqDCoMKg
wqDCoMKgwqDCoCBnX2ZyZWUodnRkX3BjZSk7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KHBjX2luZm8tPnR5cGUgPT0gVlREX0lOVl9ERVNDX1BBU0lEQ19HX1BBU0lEX1NJKSB7DQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY19pbmZvLT5hY2NlbF9wY2VfZGVsZXRlZCA9IHRydWU7
DQo+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPj4gwqDCoMKgwqAgfQ0KPj4gwqB9DQo+Pg0KPj4gQEAg
LTQ5OCw3ICs1MDIsMTIgQEAgdm9pZCB2dGRfcGFzaWRfY2FjaGVfc3luY19hY2NlbChJbnRlbElP
TU1VU3RhdGUNCj4qcywgVlREUEFTSURDYWNoZUluZm8gKnBjX2luZm8pDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgKiByZW1vdmVkLg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+PiDCoMKgwqDC
oMKgwqDCoMKgIHZ0ZF9wYXNpZF9jYWNoZV9pbnZhbGlkYXRlKHZ0ZF9oaW9kLCBwY19pbmZvKTsN
Cj4+IC3CoMKgwqDCoMKgwqDCoCB2dGRfcmVwbGF5X3Bhc2lkX2JpbmRfZm9yX2Rldih2dGRfaGlv
ZCwgc3RhcnQsIGVuZCwgcGNfaW5mbyk7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHBj
X2luZm8tPmFjY2VsX3BjZV9kZWxldGVkKSB7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
Y19pbmZvLT5hY2NlbF9wY2VfZGVsZXRlZCA9IGZhbHNlOw0KPg0KPkFyZSB3ZSBkb2luZyB0aGlz
IHRvIG1ha2Ugc3VyZSB0aGF0IG5vYm9keSBjYW4gc2VlIHRoZSBzaWRlIGVmZmVjdCBmcm9tIG91
dHNpZGUNCj50aGUgZnVuY3Rpb24/DQoNCkluIGVhY2ggaXRlcmF0aW9uIG9mIHRoZSB3aGlsZSBs
b29wLCB3ZSB3YW50IHRvIGVuc3VyZSBwY19pbmZvLT5hY2NlbF9wY2VfZGVsZXRlZCBpcyBpbml0
aWFsbHkgZmFsc2UsIHRoZW4gdnRkX2FjY2VsX3Bhc2lkX2NhY2hlX2ludmFsaWRhdGUoKSB3aWxs
IG1ha2UgZGVjaXNpb24gdG8gc2V0IGl0IG9yIG5vdC4gVGhlbiB3ZSBjaGVjayBpdCB0byBkZXRl
cm1pbmUgaWYgd2UgbmVlZCB0byBjYWxsIHZ0ZF9hY2NlbF9yZXBsYXlfcGFzaWRfYmluZF9mb3Jf
ZGV2KCkuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj4+ICvCoMKgwqDCoMKgwqDCoCB9IGVs
c2Ugew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdnRkX3JlcGxheV9wYXNpZF9iaW5kX2Zv
cl9kZXYodnRkX2hpb2QsIHN0YXJ0LCBlbmQsIHBjX2luZm8pOw0KPj4gK8KgwqDCoMKgwqDCoMKg
IH0NCj4+IMKgwqDCoMKgIH0NCj4+IMKgfQ0KPj4NCg==

