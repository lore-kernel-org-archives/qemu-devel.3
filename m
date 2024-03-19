Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA2FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 03:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPwS-0000xf-UC; Mon, 18 Mar 2024 23:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmPwP-0000xH-Bg
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:15:05 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmPwN-0000Ym-Be
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710818104; x=1742354104;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xEZCmUTO7DJAQrewtoZMx/drhROpB9qvyAv2wpN5wRg=;
 b=R+VdjMd0jsfMXtdwNssCPngq6g4qqoa61s4bdhUD/j4zL1wyUc3wfvPf
 31+QcmkswGpJGVmJNkdJbPzAx0mBK6+yO9kpFKLgzKkSgIeYYLq775JkY
 qFmV9kxzdbYXnQVRnkzn5mcDtrxM+TKBF+WQLscmiQeKqw5MSFrmI1qtr
 6YzCXHW1e5k7IkSR7oR0UVOOSP4rVrUXn12Oyi7TSkQuuIhmw56SW5FBa
 yz3zwuLWpiZrorR/Uxz4h/Yl3zvpQsXtWepGVBY84zMdEo/e+MjKviKNL
 Q8wBVZ1DryzCkeseqyVDgJ9Rt+y/6whmc+TxCUbSU5mpxJdSEu4R5J5iR g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5498685"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5498685"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 20:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="18293691"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 20:15:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 20:15:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 20:14:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 20:14:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 20:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJSP5e4JNbugx154YGwXRICiekAG/eZ5njNXIf4goUD/qKthpmk3oT5bVq3z36cKm5nm+DSlMsWrVJCOYan1pPOqhN2NtbuXaY/z8Lz5FUQO6yc6kNCq5+elEMtqrU8aN9iYEq8PUmqfNuBACJHEWWhJ48GKlck4bxnx8pboo1ysj/ZVb8yfDSP6wInHXj+NiKR9IwSUCXWDWUWxHlWdjFfpWs/1Ukt7KYCMAVONMm7KCtzXJohK6h8G6qbx61t9a5oLdkwKmJ1jdcL++ZLoErXDmLCsiMjOheV9Vf+j4+q/u/r8A+gsbRRIyg1n5vAdUr7N9RL3NBFBCBR2lzheBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEZCmUTO7DJAQrewtoZMx/drhROpB9qvyAv2wpN5wRg=;
 b=RV6w50WKKYkZETrP6K2sMQ2gVmQng2laLOGIp/XVFfu5V3guVNvk8gkDqcvK/WW5YUqe9GK6maC6uMvCUzmHB+t7GuhgBti7vG0trp9lTMh0V1VQ3MRoMDZm5xR6rdZLnUqz1S1vwO9UfjH7GYKQzwfB3n9A7pqQayq4a8h6uierG3J1V7OzAPWL3yexNkA4CU0XdhMkl7swiGPIVgm20bHhpSFdJ8UQyJHBPFI9wGr7zYyvFNqiiQPDmHj/TZHSqgMnY2dwlDbXwX2PuWxq+WuyOOeRaTnxS6fLteVThLKoOIiIe/3hppmxLROKw5YTN/p/7npsSpQCWOZhy2iV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7281.namprd11.prod.outlook.com (2603:10b6:208:43b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Tue, 19 Mar
 2024 03:14:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 03:14:58 +0000
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
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 05/11] vfio: Introduce host_iommu_device_create callback
Thread-Topic: [PATCH v1 05/11] vfio: Introduce host_iommu_device_create
 callback
Thread-Index: AQHaafrWsToC+V6/rUqIu+gBPSMIMLE9oxWAgAAIs4CAANcO8A==
Date: Tue, 19 Mar 2024 03:14:57 +0000
Message-ID: <SJ0PR11MB6744C501B59F015ACD78D4D3922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-6-zhenzhong.duan@intel.com>
 <d386b8e4-b597-492c-b0ab-4b4246906f94@redhat.com>
 <6cb774f4-4e09-4560-95e5-917bd0668f15@redhat.com>
In-Reply-To: <6cb774f4-4e09-4560-95e5-917bd0668f15@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7281:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eXOjeJkOjNDcL1RH5EMTGV3kRBz97ExMVGwRCKxVcxz9OH3VqSd5zDqI9PN6qtWofwZboyhd+lr5ErObXzAIFZjXaSuxZ+3vMBe4YhW0fnH8c6x3jGDRdFs8ELllVEDZYIpBkM8f6UCW2bnuKyaUw2Sx4w+0YQ3J+B35pgMmc2TEO+Z3mKOnGwUh22xi3xckDiCtEa2iNp9TCuNHfVY4IQz6R2Aa8CxwhxRydIZsK07SWJPWQ8lqG70B1Yhpa/VUqNDAeYdceH13QdVlM8ao+YIU2U+hmwcH8SNmgiXkUgoeYKZ32WaUwVlCtwHNoLItj0IolNVsukYSnoC1sdzVYiQmtFeTHnLVBOrYq7Yp7nlGOPfOgLKFAzw07PTeZAw/g3JQYu1Xh8wDWJi1MapG0GmHc4FrTphFSEb/UcFpztekmv+EFyWjVQWiuTxffozexKADST8EDtckpqdOjaBAiJ1A3NkVPkywAjePTY7Xc4rgkJUKK8mTdU+j6kLraY3+yb0i+Ex2B8zGpW+Egdd9/d58VDdJ6fs8upq3UatOyzmuRzHORh8jWVVkkDDd3eBg7JQsMunfJ0RjSy/pn3XaD+MCC5XETqOX75nlkMcmXbGhRxyoKOOalc/sww8jSFXGM/f8XSZdNlOUSXqSCIYlMmM7boaxQfSRCSQ70dzwKgk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmN4VHJZRjUxTFk0akZTWUNiamJpT200bE1aTHZCWVdSTXhwR3NBZTRiUWVI?=
 =?utf-8?B?MEp6VUYvSTJJMVVPWEtkQjRDQ2RidHdRclZDVUFYWE8wNUhSN0prUVNSaWhR?=
 =?utf-8?B?ZkFuRXlPeDFqZ3A0TVNJWTBzOWp0VVNYMFdQeE0yKzMvb3UvVzJ6eXNuODFm?=
 =?utf-8?B?Z0lRUm0vekRyT0hRZGZ2MFR4U08rdzc4Ly8wRjRNcHVtTU40aGgzd3A0a0xj?=
 =?utf-8?B?OUsvNTZGQ3Y2dTRWdkZicFFLdnF1VkxwcGpiYzBtWlVHSm9GdlBiaDNQY0Nz?=
 =?utf-8?B?SzZmc3VvNm11Z1dxM09leUJ0OEVUWVJQV1daaExnQ3VuQzdmWDc5bnp0WWJV?=
 =?utf-8?B?Sm5Cbk1jSi9tY01GSC8rRmlBU05va0RaSXc1bW85bFE2WlhLVUJyUGRERURa?=
 =?utf-8?B?UkFkTEJOK3Q2OGphSmZXTE1aM1h2R24rVG9Fbzk4U0J2V2V5NVhyOTBDZmNO?=
 =?utf-8?B?d1htZnA4SmY1bU1Tbng3WWtyVWlWU05wZHFRSjV6QXE0V3k1bkpESGpadVZU?=
 =?utf-8?B?blk1ajdPa1BNeTlSYm1QdEJoTnQxU3M3ZGZqeVBCcWJ4WjQ2Vm51L2NTS2tE?=
 =?utf-8?B?eTRCTlVCYnlyQ3BvMEFBcVY4dTNUVHNPbkZNSXZOZHBmNzQyajdOWHBEL04w?=
 =?utf-8?B?dlNZQkhEaVIzY00zbDl4WGt3NjJVamJsZGw5TlhCT0g4Z0JJTDZ6OHN0MVY1?=
 =?utf-8?B?ZUltcXpic2lpelhyM0dISjV4MWc3SWtYcm5tNTkvSDRxUThXenlhdDhNSFRE?=
 =?utf-8?B?Z21SR2VIQWl0bjVHd01hR0s1T054bE4yNktYRStYN2tuR1ZYNWJGZ1FjSHU5?=
 =?utf-8?B?Zm1RQmtReFRtKytQL2orV1A1RW1WaUI4YS9PQ01uWHVOdUlOSXlEOHNjSkFu?=
 =?utf-8?B?NmVlcEY0dEl4Nkh3QllGQ0tkL0xSODZ0UE1BV24zT2VCUjdiWVFNTS92b202?=
 =?utf-8?B?UUZaajVwaHJIZGJscFpVQ2dWR1BlRlhSUGFpWDRrK05pNTAyQU9kejNDaUdC?=
 =?utf-8?B?V3BOUGFlNnJBWU9yaWZVMTlETE1jYnRUUW4ybDNoRUV3QlFkNjFvc2VjdXBG?=
 =?utf-8?B?emdQQW9QbmlqanFTeE4rZ1duY2xjV1Ivbkh1WGRCVWtaaHpDamVZNldyVnZE?=
 =?utf-8?B?VXVhdkNQcnJ5c0k0OGhYclMwNkhzRVdIVTl3Ym1OYUxDV1RzUW5SSVJoNDMy?=
 =?utf-8?B?ZWVmTmEvdzZhYTRqbnprUGZ3YjlhYk9JR1VtdjRxTWQ0Nkl3VHp4ZE1GUEsy?=
 =?utf-8?B?RzNHZHYxL0dCQnJ2Nm5SU0RuaGR5UlhxZ0p4N1RQTzV0cHZJbGRTQmI1MFFJ?=
 =?utf-8?B?TEpyWmg5eC9Uc0xhQzlMRlpFWlJ0eVM2MzV5QjNmaVlYNkh5ZksySllQWGNa?=
 =?utf-8?B?dUt4MnhZcTJzZ1ZSR1NkOHZ6MUhjN1BFa1dxbDZvcXN1TndKU0NJT09Za1Jz?=
 =?utf-8?B?Q2krRzBBMW9CVmZKWlBnME42YmxxVWFCU3JnQi9uSTNFbmVTUmowYnBBU3hn?=
 =?utf-8?B?SDdLelhvWTdmNUlRbkRxQ0hGUjZYRDFpa2lFenIvWlBPVWh0VENjM1ZGNzlq?=
 =?utf-8?B?Q2hpVE5EaXNuOFBua05FaGhwd2k3YTZhbnZDTXVlZVlRZ21VRi9KM3BGTGhv?=
 =?utf-8?B?VVRyckMvV2JDaHMvYk96cktiSUhVT2h0RkN5WXNmT3ArMHJVMjR3ajVDaWxi?=
 =?utf-8?B?WERKRWhYTWdZZFJSRFJNSlVUeGc4YlNpYVZiUlR2L1Jjd1h6ME1oemFLTW91?=
 =?utf-8?B?YkU2WTU2eEJTUU8xNUZjMXBFc3JSdEYvMEpxa2xWVU1oREZZdmNWSld0bXlQ?=
 =?utf-8?B?RjZkLzFqZGFuQUVpVXMrYVlyemZNNGtNNEJPNDh5UGh2ak1VUWE0eVZ0Q3ZP?=
 =?utf-8?B?cGtiOHZXbi80c3NpL3Job2xDTmplMHQ3VkQ0MUxYT2NpRDNMZU1wTGZJS3FU?=
 =?utf-8?B?VlUrWGNpSTV0WFBycGdReU9vT1B5dy9FZ1hvem5ZMVhrOG9ITGZLNUEvMW5M?=
 =?utf-8?B?NGYrdllkSkJKbUJFdVJpcEwvUVVnZUNpV0ticUdCb3B2Kzk3OU9Pd0JTN2h1?=
 =?utf-8?B?ZldReHlFdFlFRmRQdjUxbE9QWEd5Um91eEFRc3Mxa3hRQ3YyR1U0eEhIb3hD?=
 =?utf-8?Q?4qZR6G+FakOdKDdD92JByBBj1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f5163c-6a84-421a-00fb-08dc47c2c1ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:14:57.9808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVcpjBO2rx2RzCBfaHCCxS52BPs6nxXG5oWB+MoRsiQXiNOXwxdJUez25duiDeizguzXP9a/eWFEnkiK05qYjaPj1O3r9+9rJlq15k9kMOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7281
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDA1LzExXSB2ZmlvOiBJ
bnRyb2R1Y2UgaG9zdF9pb21tdV9kZXZpY2VfY3JlYXRlDQo+Y2FsbGJhY2sNCj4NCj4NCj4NCj5P
biAzLzE4LzI0IDE0OjUyLCBFcmljIEF1Z2VyIHdyb3RlOg0KPj4gSGkgWkhlbnpob25nLA0KPj4N
Cj4+IE9uIDIvMjgvMjQgMDQ6NTgsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+IEludHJvZHVj
ZSBob3N0X2lvbW11X2RldmljZV9jcmVhdGUgY2FsbGJhY2sgYW5kIGEgd3JhcHBlciBmb3IgaXQu
DQo+Pj4NCj4+PiBUaGlzIGNhbGxiYWNrIGlzIHVzZWQgdG8gYWxsb2NhdGUgYSBob3N0IGlvbW11
IGRldmljZSBpbnN0YW5jZSBhbmQNCj4+PiBpbml0aWFsaXplIGl0IGJhc2VkIG9uIHR5cGUuDQo+
Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4+IC0tLQ0KPj4+ICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCAgICAg
ICAgIHwgMSArDQo+Pj4gIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggfCAx
ICsNCj4+PiAgaHcvdmZpby9jb21tb24uYyAgICAgICAgICAgICAgICAgICAgICB8IDggKysrKysr
KysNCj4+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8v
dmZpby0NCj5jb21tb24uaA0KPj4+IGluZGV4IGI2Njc2YzlmNzkuLjlmZWZlYTRiODkgMTAwNjQ0
DQo+Pj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+PiArKysgYi9pbmNs
dWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4+IEBAIC0yMDgsNiArMjA4LDcgQEAgc3RydWN0
IHZmaW9fZGV2aWNlX2luZm8gKnZmaW9fZ2V0X2RldmljZV9pbmZvKGludA0KPmZkKTsNCj4+PiAg
aW50IHZmaW9fYXR0YWNoX2RldmljZShjaGFyICpuYW1lLCBWRklPRGV2aWNlICp2YmFzZWRldiwN
Cj4+PiAgICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNzU3BhY2UgKmFzLCBFcnJvciAqKmVy
cnApOw0KPj4+ICB2b2lkIHZmaW9fZGV0YWNoX2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldik7
DQo+Pj4gK3ZvaWQgaG9zdF9pb21tdV9kZXZpY2VfY3JlYXRlKFZGSU9EZXZpY2UgKnZiYXNlZGV2
KTsNCj4+Pg0KPj4+ICBpbnQgdmZpb19rdm1fZGV2aWNlX2FkZF9mZChpbnQgZmQsIEVycm9yICoq
ZXJycCk7DQo+Pj4gIGludCB2ZmlvX2t2bV9kZXZpY2VfZGVsX2ZkKGludCBmZCwgRXJyb3IgKipl
cnJwKTsNCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJh
c2UuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbnRhaW5lci1iYXNlLmgNCj4+PiBpbmRl
eCBiMjgxM2IwYzExLi5kYzAwM2Y2ZWIyIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZp
by92ZmlvLWNvbnRhaW5lci1iYXNlLmgNCj4+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1j
b250YWluZXItYmFzZS5oDQo+Pj4gQEAgLTEyMCw2ICsxMjAsNyBAQCBzdHJ1Y3QgVkZJT0lPTU1V
Q2xhc3Mgew0KPj4+ICAgICAgaW50ICgqYXR0YWNoX2RldmljZSkoY29uc3QgY2hhciAqbmFtZSwg
VkZJT0RldmljZSAqdmJhc2VkZXYsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBBZGRy
ZXNzU3BhY2UgKmFzLCBFcnJvciAqKmVycnApOw0KPj4+ICAgICAgdm9pZCAoKmRldGFjaF9kZXZp
Y2UpKFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+PiArICAgIHZvaWQgKCpob3N0X2lvbW11X2Rl
dmljZV9jcmVhdGUpKFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+PiAgICAgIC8qIG1pZ3JhdGlv
biBmZWF0dXJlICovDQo+Pj4gICAgICBpbnQgKCpzZXRfZGlydHlfcGFnZV90cmFja2luZykoY29u
c3QgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIsDQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYm9vbCBzdGFydCk7DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8v
Y29tbW9uLmMgYi9ody92ZmlvL2NvbW1vbi5jDQo+Pj4gaW5kZXggMDU5YmZkYzA3YS4uNDFlOTAz
MWM1OSAxMDA2NDQNCj4+PiAtLS0gYS9ody92ZmlvL2NvbW1vbi5jDQo+Pj4gKysrIGIvaHcvdmZp
by9jb21tb24uYw0KPj4+IEBAIC0xNTIxLDMgKzE1MjEsMTEgQEAgdm9pZCB2ZmlvX2RldGFjaF9k
ZXZpY2UoVkZJT0RldmljZQ0KPip2YmFzZWRldikNCj4+PiAgICAgIH0NCj4+PiAgICAgIHZiYXNl
ZGV2LT5iY29udGFpbmVyLT5vcHMtPmRldGFjaF9kZXZpY2UodmJhc2VkZXYpOw0KPj4+ICB9DQo+
Pj4gKw0KPj4+ICt2b2lkIGhvc3RfaW9tbXVfZGV2aWNlX2NyZWF0ZShWRklPRGV2aWNlICp2YmFz
ZWRldikNCj4+PiArew0KPj4+ICsgICAgY29uc3QgVkZJT0lPTU1VQ2xhc3MgKm9wcyA9IHZiYXNl
ZGV2LT5iY29udGFpbmVyLT5vcHM7DQo+Pj4gKw0KPj4+ICsgICAgYXNzZXJ0KG9wcy0+aG9zdF9p
b21tdV9kZXZpY2VfY3JlYXRlKTsNCj4+IGF0IHRoaXMgc3RhZ2Ugb3BzIGFjdHVhbCBpbXBsZW1l
bnRhdGlvbiBkbyBub3QgZXhpc3QgeWV0IHNvIHRoaXMgd2lsbA0KPj4gYnJlYWsgdGhlIGJpc2Vj
dGlvbg0KPg0KPlNvcnJ5IGl0IGlzIE9LIGF0IHRoZSBmdW5jdGlvbiBvbmx5IGlzIGNhbGxlZCBp
bg0KPltQQVRDSCB2MSAwOC8xMV0gdmZpby9wY2k6IEFsbG9jYXRlIGFuZCBpbml0aWFsaXplIEhv
c3RJT01NVURldmljZSBhZnRlcg0KPmF0dGFjaG1lbnQNCj4NCj5Tb3JyeSBmb3IgdGhlIG5vaXNl
DQoNCkFoLCBzZW5kIHRvbyBxdWlja2x5LiBObyBwcm9ibGVtLg0KDQpUaGFua3MNClpoZW56aG9u
Zw0K

