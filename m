Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8E9C25B74
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 06:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4agU-00005V-BH; Wed, 08 May 2024 02:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4agM-0008Ux-RG
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:21:39 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4agJ-00052Y-U7
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715149296; x=1746685296;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZHP59JmktpraRDQ6TU2e7Evm0BUemE1xGdhBjNUCbWc=;
 b=eWDz6ths5C/PwkHvEx5kw6xqAcgEvdnB3NoZRfUjO+LY70KMY6FaReVF
 xAvVrRr56iPrO1ym/DZ4kZsyB1g+9hmCpMo0n4DWgp3ccCtyko8+81wHI
 wG8ooPUpY+N8+lf69uOxbH5Efx9m0BSI7nPWxasMhJRyyZk0VGxvX2SPq
 Dyw0ERQGmFFzUKIpbfPKbQaYdD/XldnkKDmFTwn+Q+DKA28mvx8J6yo/J
 XfVMXFKdxnHn0LizVpXOCzI9nOeYDX/MRPtkKB4HR+ciTmTn5rCdLKbNo
 cggK1/9jJLCVcLRuNkyV17RG3T8LtAqkDQ4UqXHMIa/ggan6i6VwQgM5h Q==;
X-CSE-ConnectionGUID: OunjS2gjTVGaGV4i8MK7jQ==
X-CSE-MsgGUID: mEhwmJISS86WBbZLSgfeTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="28462203"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="28462203"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 23:21:30 -0700
X-CSE-ConnectionGUID: tqkLUYmeREaF6XBNK/QtFg==
X-CSE-MsgGUID: oGg97Q+4Tu2RxQCjVtA05Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="33295917"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 May 2024 23:21:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 23:21:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 23:21:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 23:21:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 23:21:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCa2pAs17pFboQF/5A5Y8LlijvDQ9fFusD5wYjHqka02ngPIYRzi9mTmaaub2zn5GRYLrxetkFHY19syvvwUc1nQhj7c8kkae350Yv08dhSTtYdr0DSOYbasgrN5sd/IIVNjk1Ila2JyovNxnrZqb8oDZ1pUQ26gc8ER2fbzOaY65geQZy76iY/5uHic6nQIhcaCiQnASTc+Ez+Szj7G1zX7K/NUPbVxpwWQbqIEFx6hwPy4zCSB6tiewCpxFL8K4ecK3oFdCSTQhj/I6dGZQGaTTAw1PTzPwzeNUDQpitCSRerH4xexBbfW4Tket1jZB5pTeHAEAvnUZjWdpYRYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHP59JmktpraRDQ6TU2e7Evm0BUemE1xGdhBjNUCbWc=;
 b=Y7O2aE6nSZ89dffLA/MU0MhTrFmU33yO/HOYaTSbFQid/nwjtdTiMH99/zyV+FjGawzvqBNqxAoPYh7mXPLxGSlqfLAzXVebKSDW6ef2itTcUY9a8DYISbkr2el97aweYEnjxHI4QjFc57v+9Wdg0V7UV0MT7zBMT42eW6KtHQYaD4JTiYFKdYZtm3uu1kWzJgk0lmc7aaiBRGlRaNjx5SQnwWn0gg0TukdtgFaFBJDNQCZX2BgKrv7Rn0U4mkPMdlZUtI49IioHO9t3REjeYeE42meM8Xa2s0qIl7qS9K2znpUXzHY+v/EtREItnGR8QRkg6ReCCtOoEU/WRV+IVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7036.namprd11.prod.outlook.com (2603:10b6:930:50::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 06:21:23 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 06:21:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 04/19] vfio/iommufd: Introduce
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO device
Thread-Topic: [PATCH v4 04/19] vfio/iommufd: Introduce
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO device
Thread-Index: AQHaoGA2+olR+VKkzEKZnpFeYRW5KLGLsNuAgAEq58A=
Date: Wed, 8 May 2024 06:21:23 +0000
Message-ID: <SJ0PR11MB67442B4AA803377BD653733992E52@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
 <20240507092043.1172717-5-zhenzhong.duan@intel.com>
 <b4ba9a82-738d-481e-8d22-3fe6a1586fe9@redhat.com>
In-Reply-To: <b4ba9a82-738d-481e-8d22-3fe6a1586fe9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7036:EE_
x-ms-office365-filtering-correlation-id: d6f56c8b-e5e3-4edd-ae3b-08dc6f27153f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|7416005|1800799015|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?bFMxK1ViNUhsbGlqWHpCMWNXOHBZalpmeTVIU3JkTjZWSjNSYW9LelJ3SnlN?=
 =?utf-8?B?WHFxOUEvdjJYQk5CaFVIK1UvMlEwcEFyM1M4bjZBSm9XVHM3d2pKc2RuMmhw?=
 =?utf-8?B?N3pwb0oxeDYwVmMxRmhzOXA2MzZ5UU84UFNJTndRS2xrTWdjTzRzb2lsRkJL?=
 =?utf-8?B?MlF3NDVrSE5xcDF1Y2pSVlBSSTcvZXFUL1ptT2VEY3ZYUlkrQi9PTUhORmpt?=
 =?utf-8?B?clluR1JFQWovN29IWldFcFBGT2xVZXZBYnRwN1Q5MkVwWkxtcEt6bUZ4dGRS?=
 =?utf-8?B?MzR0bW5uL3JiNHdmZDRsaEhEVGNiQldHdHVDYk1EbTVQQ1NJdElCL2NmVGtD?=
 =?utf-8?B?WFdiVkxvL2U4RmdkYlVaL05pTGtSaHRkR2x5ZTZVRU1oMmZmUS9XaDBYdmVF?=
 =?utf-8?B?eG5CYTd2QlZrYUlubnZUdDUwbnVMTVZCbE8yLytMNExOcFlxRUh1bXFFM05G?=
 =?utf-8?B?aFdpc3hKMWNCR2hXTk5ob1ppckZmb1lvWUtaUTZKQ01IR0NZRXhGMkhpcEpj?=
 =?utf-8?B?VUdySUkrT0UzaE1ob2FYZmtkbzlKS0hGbzdjVDlUMDVIVXdlVHZEK2tsck11?=
 =?utf-8?B?R0hPc3JtbXdtZTlWTjhTZkFOTkQvN3Zwb1NTa05xbUR3KzNMcXFpK3lHcG5s?=
 =?utf-8?B?WHFjTVY0TGlSV2xpNGhoajVXM0psZUF6aWxBcUViaENDaUtDdmpiNkNMOGtY?=
 =?utf-8?B?aFFsMzBsaDI0L3hacnNqWjNBTEZIS1NuRDdvMXcvZTZmOS9FUExuUHRIYzBL?=
 =?utf-8?B?TWhOZUV0WnpKMjJhMEJlNmdlVkkvYUZMVGZPM1haRnhjdlN4WTZwZ0lURnBx?=
 =?utf-8?B?a2dCYnNLRUZ5SkVObGsxQ2VpbnYvY2I1enl0SmVuUGR1N1NKaHVFQjRScjZw?=
 =?utf-8?B?ZlMxN2x0c1lSWnFSSDZBdnpGMzNwS2NTc29sbktyQXk2T2FTZUdQWVlYVnVh?=
 =?utf-8?B?WjNqSmt0NHYrem9jQnRSa3JHY09jenMxVGp0aUREa3VhNnJtU3FFR2hzVmRE?=
 =?utf-8?B?ZWNEVXcwMFRwYmQxRDI3TVFGaXU3MFJPdWNiQ3ZEZlQ2ZmtBUjJZVCtLcml5?=
 =?utf-8?B?clFoZmxpYVNqK1o1RllhdDEwUzlIRFFoSGYyUHlzYVIyRTZ4OHAzOHU3OXNt?=
 =?utf-8?B?WlBVemI1OEQ1K1dEQzVrSHRvMHRyeEUrZVhibml6OWU4REN4eWp4VUZUaFJU?=
 =?utf-8?B?d0FRNlBDS3hKNTJQeVE0aWhMdzI1ZVlWTCs1cVJpTGRxd01SeURBTGhzS0VN?=
 =?utf-8?B?bDQ1a2hPcUFvUEl0aXpoTWdoaUQxRXJ2WHFadWNBNmd5MFlpT3NIUktCdU8y?=
 =?utf-8?B?WEQzNXpDTkw1OWFmaldvajNtMXB5UDNKNDF4OU9vTWM4YmxrQ0trOVJ0WXE2?=
 =?utf-8?B?dFJtdTVxVWNpNDBocmUvd1p3bXBFdFRpTWNMbERpeXRuRnkwTFpSRCtuT0U2?=
 =?utf-8?B?ZkRvNzdmdnFZNFhBSlRCdXVGQlFtaXBIOXQ1SlRhY2ttN3l5dTMwOG1JNjBZ?=
 =?utf-8?B?N0xHWWQ4Ni9RZkhqQWNKcFliN0JaYzJsVFArM1UzVnV1T3lQbGFUaW01UDQx?=
 =?utf-8?B?aEs3N1pUeUxjN0dNUTl1bnp1VU50YldZVTJIZ0k1L1VlN2RwQkVJK01kMFJY?=
 =?utf-8?B?OXMzeTd6ZStjU1Z1Ti9pWjZhL1EvdFo3aktNc1FWQVRsVm95SEIrbnJmWWta?=
 =?utf-8?B?ZGRmN1VEKzR5Sld1SG1xVy9DMUxqYjJ3ZzlCbFJrUEFNVEZYa0lqUlhDQzFl?=
 =?utf-8?B?WEdvRytYUmRPVFhWM0U2elYwbDBFaWNqNCtvMGxJZWd4YjdwZEp0ZlZlVVhn?=
 =?utf-8?B?WDBUcEo1S2RpUDJCZTZuQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTR5RE42Y3N4QUhQekZEUmRmZ2dqcGhkelFmdG5ZVXU3Z1hscG9tbjNYa1NQ?=
 =?utf-8?B?aDRkVS82QnV6N2l5QmNIbnR2NEZwbDRkRENidElZRlMrZ1U2ZTJWQTNhWkhT?=
 =?utf-8?B?bDBVOEMrNlNxeGlkZGQ2TDBzSFBsdEQvVWJEME8zYzRmaTBmUGExd3lPV05D?=
 =?utf-8?B?bXZNbEVjVFU2cWNOWkFiVC9vcjBDS0psVzJMcWJKQmx6MGpPWVNCWTRsbUEv?=
 =?utf-8?B?dElKamhnb1ZUdStRclRLZjViT1FBdERVVGw5WmtHdndWNnNiYTk2b3RCWTRw?=
 =?utf-8?B?a2lNWUY2NDd0VGNzTlp0aWZURFJNak5OT01hWGdxNC9UeVk4UXgxcDhlbTIv?=
 =?utf-8?B?ZTJFZDViVjFVd01ZQUppc2VNSXJXMDJGb2t0bVk5SDdKN1VPZGxnVzYrWGFF?=
 =?utf-8?B?YlJaR0ZWa2YzMkJQOXE1ZWpVYnBlNTR3dTdLQ1FMSDJrZ1RlYXg0SWM2cXUx?=
 =?utf-8?B?eVVBTHZKU3dDSCtpVGw5b05CdU1JUWw5TDl0WENxbFE4aytPT3dyVjlicjlI?=
 =?utf-8?B?QVVKbnZQd0JjbjFoT0NtRjQ4bm93WjFiNlJKeWdRYTJqRG1ZaDN4Y2xkZGJO?=
 =?utf-8?B?OHBzWHZqeVFBL29VVWY3UUYxcGhscVczWCtZSzVYd2tQMW9Zckg2SEFySU43?=
 =?utf-8?B?TnRhQ293YmZmWE1CZVJBSldYTm1GVXM1NjhmYUFRRmkwQTE1elByMTRNRnFz?=
 =?utf-8?B?UThGdjlXYXBidUFDc3laZS9QeCtneWhQWWNvRGdDOGE4N0JneHI5SWVjUStj?=
 =?utf-8?B?TGRDMklLa3Q2MUxVcGl5NVgvNU9hK2VQMGF3QllXU1NrNXdBcVIyaFJpZDh6?=
 =?utf-8?B?bWhOSXhmeVU1WjlWb0xZZ0NxT2ZOL05XUitTem5xVFBvdlNQejhmVVhlVFlN?=
 =?utf-8?B?SG4wamtIemsrclZIU0ZvZVM5VVBXeUFGcEF1UFE5WU9xWWxtNEZWR2I4dHhj?=
 =?utf-8?B?L1oyTjJGSVcyZXNOUkFLOExteVc1dHcva0VFc1M3S01PU0xVV1NTVE1VZjFx?=
 =?utf-8?B?WkswT1BVT3I5TTZsTERDVEgwenhPU1A2eW5CSGdldVRuejFoQUpQVjB2MHls?=
 =?utf-8?B?SEtwVXRkL1ptNytMeFpDNkJTUkxabkppNDZPNzRZWkZjVkNnZCs0M201MDVY?=
 =?utf-8?B?MXF2L1BqcHVpZHdnWUpXNnNCdzZuaVFZV2htZ1c5L1FXdlNHV1NjcGZuRXRC?=
 =?utf-8?B?WGV1WjJZMWpTbG1WRmdsYWFYRGFiVjJKYmVWM0kwL1NYZ2N1ZFZiMDBQQTBm?=
 =?utf-8?B?VlVnbWYwRHBoby9wVmtPZUJDWmdxOS9URSthY2lJekdKRysyYkxScDc0WEVl?=
 =?utf-8?B?UWJPS212aDFadFdRbkRUZFUwL3g2ZWJUMWdTZ2RZZFFuTjlDZUthQXhXTEhr?=
 =?utf-8?B?cklEWkF5UGdzZ0JySG9RMy9CV2FFTWN1MnlESE0zWVhjVk9PNCs4WWhBaHlh?=
 =?utf-8?B?cldlcDczSk1kM080VGY5bDN2T3drRU1oYlgzeVl3eDViZEhiNEtXaWpXQnBm?=
 =?utf-8?B?N3RnM2VpNkRFQjdVQ08rSVg2c2hMc2o3U0U4M0FOYkhpWmNEU3pVdTFMTEUr?=
 =?utf-8?B?VDg3eUE0MVdNZEFkc0hwQ3lEL1pvclRadG9qNnIrYVNyUG1La2I1TVNiblFS?=
 =?utf-8?B?UWtxeGQ1NVYrRXpTTTZiVXAvY2pibG15aGY4Ty82ZEkyNmU1Ri9zcXYvOXJa?=
 =?utf-8?B?WHlYUTE0VkJkL3BEMTJjVnJNc1VjOUd6MjdzbEpVVjRVeUYzZzlJRDBBZUJp?=
 =?utf-8?B?bS9UTWJwNis2OXFWM1dVTWNCMTQwRG40MnJyNmJ2N25ZeC82N09vODFhNVZv?=
 =?utf-8?B?d092ZHNZSXN4RndmRDFrQ2ZtOEIzKy9sT290RUV2S3dUb3NVNHJyZkI1TS9m?=
 =?utf-8?B?UVVTaGhheUFZdzE4eGRiN2JRaEo4Z09UNTkwcHNOb0MrQ3l6UCttUTM4UjAr?=
 =?utf-8?B?OWR5SjdzMTFIbW9TU0xJR1F1R05qY2FXUDFwQXVJa0ZJVGRneGNoczgxakU4?=
 =?utf-8?B?WFJSenRDTG5pdmU5VFdNTVdCNGNSRmdGRnYwK3loMytvQjhpRmJsVXVCcUZB?=
 =?utf-8?B?RWdWd3VUOE5xQm1vVzVaUHJIaTh1VXRHZ2ZsQjk2V0RhUWlCYnVBWThZYUd4?=
 =?utf-8?Q?WEI5OPrLCzQAUem7DzFmbgmFh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f56c8b-e5e3-4edd-ae3b-08dc6f27153f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 06:21:23.0196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXpzidx4fD/zJ6hqJVrNTwyghyLrhaa1bXpEEI0GLo8LP1FCKe5/s1axzGKIeP5Mj6EJHWdB8Rt910WXI94U7PNt3UTRBzrwL3e9oQKYie8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7036
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDA0LzE5XSB2ZmlvL2lv
bW11ZmQ6IEludHJvZHVjZQ0KPlRZUEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRF9WRklPIGRl
dmljZQ0KPg0KPk9uIDUvNy8yNCAxMToyMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBUWVBF
X0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkRfVkZJTyByZXByZXNlbnRzIGEgaG9zdCBJT01NVQ0K
PmRldmljZSB1bmRlcg0KPj4gVkZJTyBpb21tdWZkIGJhY2tlbmQuIEl0IHdpbGwgYmUgY3JlYXRl
ZCBkdXJpbmcgVkZJTyBkZXZpY2UgYXR0YWNoaW5nDQo+PiBhbmQgcGFzc2VkIHRvIHZJT01NVS4N
Cj4+DQo+PiBJdCB3aWxsIGhhdmUgaXRzIG93biAucmVhbGl6ZSgpIGltcGxlbWVudGF0aW9uLg0K
Pj4NCj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCB8IDMgKysrDQo+
PiAgIGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAgICAgIHwgNSArKysrLQ0KPj4gICAyIGZpbGVz
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCBiL2luY2x1ZGUvaHcvdmZpby92Zmlv
LQ0KPmNvbW1vbi5oDQo+PiBpbmRleCAwNWExOTljZTY1Li5hZmZiNzNmMjA5IDEwMDY0NA0KPj4g
LS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcv
dmZpby92ZmlvLWNvbW1vbi5oDQo+PiBAQCAtMzIsNiArMzIsNyBAQA0KPj4gICAjaW5jbHVkZSAi
c3lzZW11L3N5c2VtdS5oIg0KPj4gICAjaW5jbHVkZSAiaHcvdmZpby92ZmlvLWNvbnRhaW5lci1i
YXNlLmgiDQo+PiAgICNpbmNsdWRlICJzeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCINCj4+ICsj
aW5jbHVkZSAic3lzZW11L2lvbW11ZmQuaCINCj4NCj5JIGRvbid0IHRoaW5rIHlvdSBuZWVkIHRo
aXMgaW5jbHVkZS4NCg0KWWVzLCBtYXliZSBub3Qgbm93LiBUWVBFX0hPU1RfSU9NTVVfREVWSUNF
X0lPTU1VRkQgaXMgbmVlZGVkOg0KDQojZGVmaW5lIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9N
TVVGRF9WRklPIFwNCiAgICAgICAgICAgIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCAi
LXZmaW8iDQoNCml0IGNhbiBiZSByZXBsYWNlZCB3aXRoOg0KDQojZGVmaW5lIFRZUEVfSE9TVF9J
T01NVV9ERVZJQ0VfSU9NTVVGRF9WRklPIFwNCiAgICAgICAgICAgIFRZUEVfSE9TVF9JT01NVV9E
RVZJQ0UgIi1pb21tdWZkLXZmaW8iDQoNCg0KQnV0IHRoZSBtYWluIHVzYWdlIGlzIGluIG5lc3Rp
bmcgc2VyaWVzLg0KQmVsb3cgc3RydWN0dXJlIHJlZmVyZW5jZXMgSG9zdElPTU1VRGV2aWNlSU9N
TVVGRCB3aGljaCBpcyBpbiBzeXNlbXUvaW9tbXVmZC5oDQoNCnN0cnVjdCBIb3N0SU9NTVVEZXZp
Y2VJT01NVUZEVkZJTyB7DQogICAgSG9zdElPTU1VRGV2aWNlSU9NTVVGRCBwYXJlbnRfb2JqOw0K
DQogICAgVkZJT0RldmljZSAqdmRldjsNCn07DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

