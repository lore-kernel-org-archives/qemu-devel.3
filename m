Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34BAC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 03:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkELh-0005ox-Sp; Mon, 17 Feb 2025 22:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkELZ-0005oD-Em; Mon, 17 Feb 2025 22:32:35 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkELU-0004xb-Tg; Mon, 17 Feb 2025 22:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739849550; x=1771385550;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=bxjgJXymhORwGzav235q0/48pSW3k+HmUyuZuf/fuLI=;
 b=jIew5pviIjssFQ9hvzlZsrGdUNFOSNnrkhTDmerqAxiBhpTuioYGIDdh
 BmEFtu295RiPvGG9dhcYmr5JDti8Tx4XWXbpoBaGfwEHjk2h65mFAupiR
 H3z+/cVkxUT6Rz+MSj3jN1qvCab1ia3bEk9POWgsWrfsQc3hX0HAzZKLT
 3QB953w7RInPtWbsGmn6sVakl9rJXth2wPgK6Agak7FBf5YF1v0KGdKSR
 MAcXbkAMPDW1ZG2ao8s5QEU86LDtjHU/AfPBD73dRZ5lJW4WgUwhp7/Id
 Vt5qiQKNMF1OOqY8YEo8k7IHe9H/Dz+eQTvz+k1MLMp2/fBwS7flCZ908 w==;
X-CSE-ConnectionGUID: lCBYeQcbSzaPC4Gsu/RiNQ==
X-CSE-MsgGUID: LuoVfOwORYSoCppWLQI10g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44183519"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="44183519"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 19:32:20 -0800
X-CSE-ConnectionGUID: PLFRM3Z7QtWQASj95ubsTg==
X-CSE-MsgGUID: SwwSrwIZRBamlvL6S+i1yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="114254297"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 19:32:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 19:32:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 19:32:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 19:32:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pciS08ECahawJPl47HIihAXQjc33erYFIJaLmr4iGvsm/qKop5sd6I0h6oDT4r5UHVg0lhli5IVC+LcUT3+GoGmsPsvnKRpjizQQkHF+nJHSlucTfMbQxpizKpLookkQtitql2pAlDsas/p2tXFdPAUQT/KTWLq/GnboAMDbTpd5mA7fPzL2GTWkeSmDsKOItaiPkwaw0srIllt+Pg/Qa4Dhkpm0Oq1yD9IO5uSZzA6Al2asn44UGIs3xeWy2EYzJnsM5+aIA5HCeX8ApPqVMDJ1SGLo+CYeMMM+TjdYRmvZGYXkwxTuDGLuP4ySMzemwhmbQJZ+pijBe1bQ/zyZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxjgJXymhORwGzav235q0/48pSW3k+HmUyuZuf/fuLI=;
 b=Gd55mYDJTJ5CPaZIfuXSo4xGnrr8rVYOjkcb+gqVLZG59AZINPeXu7zdnBjw1gucicnrEsA5WJTlqgZ7SombQtG0R7lIJHg/CEmQhOXeB9o9BU4OvEO5/HJ8nsc8aTkwQA3VgFRcC7dFBAQl8pgPpSZ9COXoxoKzz/ZtXl2Aw2DPstCUwLoHdmSLwYLPquuzrKU837wsN5o5zAFW165yK2k1yyYul0zkqyjwZCmbjhg48wtrjhDehGVXv7C2fpbt0oBV7swFWQnS9IKNDftt6oXWYYcn3RNyXMVMVpx+8PflljOnco0ELsfzA8pItiu1EpJ5m7LOSPnwX7FTkuEzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB6719.namprd11.prod.outlook.com (2603:10b6:a03:478::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 18 Feb
 2025 03:32:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8445.013; Tue, 18 Feb 2025
 03:32:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>
Subject: RE: [PATCH v2 0/5] Fix vIOMMU reset order
Thread-Topic: [PATCH v2 0/5] Fix vIOMMU reset order
Thread-Index: AQHbgUExha0nNkE4SUK+0YaF4oY95LNMZ+OQ
Date: Tue, 18 Feb 2025 03:32:08 +0000
Message-ID: <SJ0PR11MB67449A41C11701DC5719A63292FA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250217133746.6801-1-eric.auger@redhat.com>
In-Reply-To: <20250217133746.6801-1-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB6719:EE_
x-ms-office365-filtering-correlation-id: d5d95081-cf0b-45b1-18e5-08dd4fccd2dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?SHpiNjIyMGFSRE5CclpFeXpkR25oOWJBU0phVVY2UGQ2MWVDTjNBNk82K2VE?=
 =?utf-8?B?N1JteFFWY0lVaW5oOGNpbm5ZeVdCZGg0UGxJRmIvVVRtb1MxNnFyaldHRm95?=
 =?utf-8?B?VGtzekc4bjB5QUc4Tk5BcTFvcUhTTTJ5UmRtUVRVc2ora25MZzhyZjVMVk9j?=
 =?utf-8?B?cFJQaU1vSnRSZ3JTaFk0eENVWlY5YWZkZGMvMGp2SDI2aWtWN29zUFMwcVlE?=
 =?utf-8?B?QjJWRmNrTEpkMnF6VUlYdzVaKzNNVzBHaCs2UU5tYThVTVIyMnBiTUUzT01T?=
 =?utf-8?B?SGtrNm5hY2dDN2dqaHZLdXk2bCtNQjI1cmNoSDdSNHZ1WUUzMXVlQlZQVC8v?=
 =?utf-8?B?aTJBK3hWVWRrOW9qVGJOL3hMQUhRNjdVYzlBcTJYMFhSSUxLS1gvNmk5ajVa?=
 =?utf-8?B?eXVqSzdwNmlvdkJPcjEwQ1dRY1VJQlV2MVoxN1B0NWdWdytnbG5vNThuWE5w?=
 =?utf-8?B?dGZURHJoV1JCa3RYZitHWlFzWkxsSlo4azM0TTYrTmJPeE5XVXoxSlZjdjRO?=
 =?utf-8?B?MUMrRXV0SWFDMzJvNENGRVRWOG1lTGV0aElHK3o3WDdYYmhKWkQyNm0rQmh6?=
 =?utf-8?B?N3lJVC9qWXpHckY3OTdvOEZzRTZqeEtQTFlPTHZ3aG5Ud3AzaHJ2RGlsVngw?=
 =?utf-8?B?cHpST3FyUVNaQzQybTd2VjFIOVN0NGkyU0s5SlBxa09ibFhmZVFnQnl2QytC?=
 =?utf-8?B?L2Y1dUtGQ3dhNXJQRlovdnFSR1JTc0dlN3pHWURiR1ZsWVd2Z1NxMzFFT2pn?=
 =?utf-8?B?WmozL1BaVHI1T3RWYmJObFVCTTJWd1FTY1NUTCtSbXlBa3VWeGkvQTI0UjAv?=
 =?utf-8?B?T01rZWJnZUtuMWd4WWd0andWREIxOFQwdnhCT0JNeElxMitJRHI4WFJiUHZH?=
 =?utf-8?B?d3VKSXBUNUlFdVJLQktiazN6eGtYV1g4UnBWaGkrOFhSdUpSeVNzODYwSXp4?=
 =?utf-8?B?YXlucTc5WitjQ1YxZjIzeWR4Z0ZLQWxINjdQNWV1ekJaV3dvSFptMkFjOVJE?=
 =?utf-8?B?TnpzZCtLbWl4cWR4TENacUczNGc5K0N6dVJmS2RVVG9jSWY5RjhpaHlHa0Fa?=
 =?utf-8?B?cWNTVUQ0VWV3WXAwMis0K2g1dFZkVGZCTUFjc0F5SDB1bG1GRGJTcWpnaHBG?=
 =?utf-8?B?eUYvbmg2OUlJejZ4NXloTVBkYTFDTWlYTWswMDFUSDgzMWtjTlBodWhRa3Zl?=
 =?utf-8?B?aEoyUmF0Y3RZUTMyVVBKWklpSXBnQ0ZDWDBFT0ZFWU8xdnBMNmwyYVVHdTNw?=
 =?utf-8?B?VlF0YXBOT0dDVFljTjF6TWEvQktsbDFzSUxvaUhPdHVlN0VvKy83NEl0T1RI?=
 =?utf-8?B?TWNlZmZUc2pQQnRzVG1peUVubDFWVjBPZ3d1TzQ3SHdDQytBRW1pdkRyajE5?=
 =?utf-8?B?V05XTm5pSUt0RXJQWXNmZzdGdE1BUktDbXIrS0NabldaeU5vakJTOHIxTUNa?=
 =?utf-8?B?cnJQdU1zRTJNZnR6NGFENmRZUmtSR3BMc0g2enV0UHlubGViMWVYQ2VGNUZ1?=
 =?utf-8?B?STNjS2JMbVlmVkthcXA4QnYyc0x4aWwrZWdvUEROSzBFMW01WHV2QkpmOFNp?=
 =?utf-8?B?cFJ5TXh0YUNGaHhhQ3pESzZWOVRRa0thQzByMmZFNmNTU3d4SGlLZXZ4VWpX?=
 =?utf-8?B?UDk5VUkyU2lQbVN5KzBkN2FDcFRrY3M2b2NQTVVlQkxTOEx0V3pjcDNvRm9N?=
 =?utf-8?B?Z1FWcU5lT0hCKzkweStvOVFGZ01jQlUyWTNrbk5nTG03L3ArNHlabGRLTFd2?=
 =?utf-8?B?KzJrQng0Rmk3OVJQeVl2ZzJpdWx6c05vQXZNNG83R2xaOTN4UjdycnBWNlhq?=
 =?utf-8?B?bWo2cTRKcjJyS3lsVHd4OVpGemhBMzBabERFeTBOWDJJU1IyNk4vVlB4Y3lE?=
 =?utf-8?B?Ym85VXlnSFZ1K0FJREVXQ25ZajNoVzRFblU5amIvenJQKy93eVVrT2VsVEoy?=
 =?utf-8?B?cEpYK054MEJ3d0kzZ1JQTGRxckVLOUlaTnZpTzFrR0dGYWlSNm5ObEt3ekRM?=
 =?utf-8?B?NFRKQkxmRExBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekVSKy9LcUJaWWZqWGFnb1dIeTdFUklyZGwzaEtLRFB6Rll1d3lUOTNkNFJ3?=
 =?utf-8?B?NjFHQndsTGp3azJEVnVBcERXc0pBRUdtazF4UFZ0K1pEdFBTQndCZnI5YnEy?=
 =?utf-8?B?OGxzRnh2RGNQWXFyZzFUcTBzVUtDN1NqNjdLOWxXc2F4M3NBbUpWbFJlMVZL?=
 =?utf-8?B?aGFVT3MxaExVUWVlSEdIbHlCTjN3ZTJIakNVNW9adFBmZ1AyaFhld1dkaWoz?=
 =?utf-8?B?MzQvZUw2U2t4eXdRbnp6VG8vMEYvZE1CeGxMRVlXSXVGUGY1M2pKdVlJUUp0?=
 =?utf-8?B?cDBCRkVnVzZoTG5jNkNpWjJQNjUzYjZ1c0g2WlhLdzNtVHM0NVZtdTEvbmZ4?=
 =?utf-8?B?YlluTjNJOE0xWTMxVTJ5QzRkdlhZZW82cXFBby9ucElVdU1Ka21aMXowd2d0?=
 =?utf-8?B?ZmNacFc2eTFDUHQwUVk0emdsdTl3VXlUYTVqdFM4RC9DMk1zSFlTZnNDSVRx?=
 =?utf-8?B?TTJXNkNGSHBYb2N5bmpkTklXZG9uL040L1hGQ3BiYUU1M2EwOTBVNTQyeGpv?=
 =?utf-8?B?UTJ1L3hWTzBwWHZBWm16TW5XWmhjb21QK0s3R3BBK0tKYmRuKzZvU3pBeGlr?=
 =?utf-8?B?T2NmTkM4WERxRmdvT2NQWkhtWXpaNGZjMlViclllUG5oOHRHUW03eTVlTGZX?=
 =?utf-8?B?QVcxZE1VQmZOVU9EbEI1czZUMy8yS0k0UmFuVnAzT2xEdmZseUp5UjhPVjZm?=
 =?utf-8?B?NjBwV0ltNU5zNjFMQTltUUk0aVExSUhuVWUwblFRSkdSRjUwQU90a0R5VEwy?=
 =?utf-8?B?ekR1M0JQL0R3OGtnZitFZmNSRGIzS0RJQVR2d242b3RyREYxM2hEVy84dXdQ?=
 =?utf-8?B?R0V0TUUzSlhFZzdnTkt4cWdObGdoQVlKaEVZdENaU0Z5SldzeGJMMnJxU29G?=
 =?utf-8?B?QmFHYnRmdkRHLy9SbzdXNUV6VG5YSkx2UWdlbHlPMkVHTG5HVmRzY3lVMHFQ?=
 =?utf-8?B?ZjdtQ0xFRVVRdmI5VWdYNWttY3RYczFNWnpoNzNFSis2bXBpcWp5bWJGSTcv?=
 =?utf-8?B?VTY4WlFTL2ZzZzZxVUxYRTdxYXpjSjdpNFZKeDZtaVlicGVscW9CYm5saE5l?=
 =?utf-8?B?VTMvbm9WRzBDRVlWeUM2UjlxcytJNldCTitoTXBiWnVGMjRhd0M5T3lBdllK?=
 =?utf-8?B?VU5RcTFrZStITjBlNHppUHlmQzhXdXQyQUJ1MW9WcnAzZkxmYi9pTWRudlBK?=
 =?utf-8?B?a0dMQ3dmeDJCYVVzNTl3a1RyY2xzWUcyTC96MmZGdnFpOGU2dVhtWkV3eXFF?=
 =?utf-8?B?Q29Cbm5BNnV5RGlNRnd2K3YrWVNKSWNwNkQxbXFnaVdvRFNjZ09ycUpnTkIw?=
 =?utf-8?B?eDBtMzlnbWdPS3V0S2QxaDNJQkt0ZkdUU0FGMERBV1JuaERKaEo2eG1VYm1R?=
 =?utf-8?B?VmJ4TUlleFQvK3I2SHZmMSs4NVhFVEdwMkpUQmZZUFhpSWJ4L2dCNDVOd1Fa?=
 =?utf-8?B?RC85cjAzUE4ydHZzTHoyZmVvWTZaNUVTWG1Jc0NPeXppdkRVdGU0SUtENWdX?=
 =?utf-8?B?MWZLUmVkZlI3VllwaGpzSWlUbzlWdVFPeGxXQU9VYy93c2JtOWc1dGFkUGJm?=
 =?utf-8?B?M1RVMFFRYWpwZmxKcGxRekRCREg5MmI0YlpUT21VdU96cDg5VlJTUTJxMHRS?=
 =?utf-8?B?WW03OWVYSkVlbGwwUG92bEpISWJhRFpuaER4WjI3MUh0cFArZVJHN2dzbFl6?=
 =?utf-8?B?aVJidnp2bXBLQWV1OERrZGRoNWZnc2JLZ2ZFL0xSYjlMMXlWY0xLN2NkNEJP?=
 =?utf-8?B?S0pHUXhRczdZL2d6QmpQTVRtb1FHMTNlUy9mQ3F3TmVYQ0dENTQwbWx6SDdw?=
 =?utf-8?B?aWFDS09GNXVXeWNTYkZjT2RVQjV3dnEzV2VwZTJuTDhwS2hHQ3d3TEdxSDBi?=
 =?utf-8?B?NC9xQ21mWFk4Z3k3Rld4Y08yb05Pb3FGTGJHQXdjOTlWTFpsb1pQeHRDdGxB?=
 =?utf-8?B?QURWYURUT2gzcE9tSDF4NFRrTm9OVkFueWxDNGJjRjcxbmNMMjN4cGd0MDc2?=
 =?utf-8?B?OXhyQlYxVmJWSFZwMFNkUVE2SVBvZzlucTB6ZWRJdTAyN21VU1dqY3IzWVpw?=
 =?utf-8?B?WEZIeFNDZzQySHd1QWlkYjVWNTlnRUQvZWwyWHBSYjlJclBOZU1ERWpsSVox?=
 =?utf-8?Q?ZxBUbDeSbVumvIN9+w5laUshu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d95081-cf0b-45b1-18e5-08dd4fccd2dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 03:32:08.5564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6K/EWJ0ix0puCdkVGL9rdE9U6NYejogjvQTwpCQUAwMCgcn1stHuTDq8i3oZvUi0pk6y7aXPLaOtFuIjjUHv7xsOuJpu46JQiqND3FUsMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6719
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFtQQVRDSCB2MiAwLzVdIEZpeCB2
SU9NTVUgcmVzZXQgb3JkZXINCj4NCj5XaXRoIGN1cnJlbnQgcmVzZXQgc2NoZW1lLCBETUEgY2Fw
YWJsZSBkZXZpY2VzIGFyZSByZXNldCBiZWZvcmUNCnMvYmVmb3JlL2FmdGVyDQoNCj50aGUgdklP
TU1VIHdoaWNoIHRyYW5zbGF0ZSB0aGVtLiBUaGlzIGhvbGRzIGZvciB0aGUgZGlmZmVyZW50DQo+
SU9NTVVzIGFuZCB2YXJpb3VzIERNQSBjYXBhYmxlIGRldmljZXMgc3VjaCBhcyB2aXJ0aW8gZGV2
aWNlcw0KPmFuZCBWRklPIG9uZXMuIFdpdGggdmlydGlvIGRldmljZXMgc3B1cmlvdXMgdHJhY2Vz
IGNhbiBiZQ0KPm9ic2VydmVkIGF0IHFlbXUgbGV2ZWwgc3VjaCBhcyAidmlydGlvOiB6ZXJvIHNp
emVkIGJ1ZmZlcnMgYXJlDQo+bm90IGFsbG93ZWQiIHdoaWxlIGZvciBWRklPIGRldmljZXMsIHRy
YW5zbGF0aW9uIGZhdWx0cyBjYW4gYmUNCj5vYnNlcnZlZCBhdCBob3N0IGxldmVsLg0KPg0KPlZp
cnRpbyBkZXZpY2VzIHVzZSAzIHBoYXNlIHJlc2V0IGFuZCB2aXJ0aW8tcGNpIGRldmljZXMgYXJl
IHJlc2V0DQo+aW4gdGhlICdob2xkJyBwaGFzZS4gVkZJTyBkZXZpY2UgcmVzZXQgYXJlIHJlZ2lz
dGVyZWQgdXNpbmcNCj5xZW11X3JlZ2lzdGVyX3Jlc2V0KCkgYW5kIGFzIGEgY29uc2VxdWVuY2Ug
dGhleSBhcmUgYWxzbyByZXNldA0KPm9uICdob2xkJyBwaGFzZS4NCj4NCj5Ob3RlIHRoYXQgdGhl
IHRyZWUgb2YgUU9NIGRldmljZXMgcmVzZXRzIGRlcHRoLWZpcnN0IGJ1dCBpdCBkb2VzDQo+c28g
d2hpbGUgZW5mb3JjaW5nIHRoZSAzIHBoYXNlcy4gRmlyc3QgdGhlIHRyZWUgaXMgdHJhdmVyc2Vk
IGRvaW5nDQo+dGhlICdlbnRlcicgcGhhc2UsIHRoZW4gdGhlICdob2xkJyBwaGFzZSBhbmQgZXZl
bnR1YWxseSB0aGUgJ2V4aXQnDQo+cGhhc2UuDQo+DQo+SG93ZXZlciB0aGUgUU9NIGhpZXJhcmNo
eSBpcyBub3QgYnVpbHQgc28gdGhhdCB2SU9NTVVzIGdldCByZXNldA0KPmJlZm9yZSB0aGUgRE1B
IGNhcGFibGUgZGV2aWNlcyAoSU9NTVVzIGFyZSB1c2luZyBlaXRoZXIgbGVnYWN5IHJlc2V0DQpz
L2JlZm9yZS9hZnRlcg0KDQo+c2NoZW1lIG9yIGhvbGQgcGhhc2UpLiBDaGFuZ2luZyB0aGUgUU9N
IGhpZXJhcmNoeSBkb2VzIG5vdCBzb3VuZA0KPnRyaXZpYWwgd2hpbGUgZm9yY2luZyB0aGUgdklP
TU1VcyB0byBiZSByZXNldCBvbiAnZXhpdCcgcGhhc2UNCj5zb3VuZHMgcmVhc29uYWJsZSBhbmQg
bXVjaCBzaW1wbGVyLiBPYnZpb3VzbHkgdGhpcyByZWxpZXMgb24gdGhlDQo+YXNzdW1wdGlvbiB0
aGF0IGFsbCBETUEgY2FwYWJsZSBkZXZpY2VzIHF1aWVzY2UgdGhlaXIgRE1BIGJlZm9yZQ0KPihp
ZS4gZHVyaW5nICdlbnRlcicgb3IgaG9sZCcgcGhhc2UpLg0KPg0KPlRoaXMgd2FzIHRlc3RlZCB3
aXRoIHFtcCBzeXN0ZW1fcmVzZXQgYW5kIHZpcnNoIHJlc2V0Lg0KDQpGb3IgdGhlIHdob2xlIHNl
cmllcywNCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

