Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E20C10F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 02:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5G69-0000Jx-Kd; Thu, 09 May 2024 22:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s5G66-0000JC-PN; Thu, 09 May 2024 22:34:58 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s5G61-00084j-Ve; Thu, 09 May 2024 22:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715308494; x=1746844494;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OAi5Q85EK6Q25Nhs7TD1cAvZckAkOooEjOwOT8W7vpk=;
 b=fCooohRw0UtptUS/QT5N2ZycJJrZipqE4LPxYJTDNyivTHDghd28x+v/
 ZIsWjSX5wYo9tC92awfy3OMcdzQ2cEJV+B0/V/6ICpvDCawrdqBf2Picp
 jO1GSMEHYuq9+ru6qRO7rPkbPwJl/VIm5pqCtRdSMF/aeujgBC95o+OeJ
 hdS+6398kD7QNR9ftvWHilaly6Z6JvVTAP3wZASd6dpOezvT8l6ip9Tv/
 eFaSRUxAtjeO6JBOJ6tnJAio1z68QfqDESbisjsddPdj9Eu0Ey9SdzTaS
 iB6TdF3XSg83cbxxQ0bESdcWL/L8NbaPwHxtS+1hbMOKjStll84yO5TBz A==;
X-CSE-ConnectionGUID: OS/yOoMQRwilUvFuSkDriQ==
X-CSE-MsgGUID: 6pINjzV0S86tecoEq/m38g==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15103907"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; d="scan'208";a="15103907"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2024 19:34:49 -0700
X-CSE-ConnectionGUID: 7WvUYqD8SiqjwhJvrGOzJA==
X-CSE-MsgGUID: H/nJwxnwRqeyhF2Fwpiqng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; d="scan'208";a="33995219"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 May 2024 19:34:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 19:34:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 19:34:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 19:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4NfHZRYNaWlHRf/V+MKEtKUyhN1D2z5jrUz2pMOcyWDyZmV7nUYh4I7ZW2R4nRIMYBOLv8Ygj+nnVEPYVsqIfzM2YNmZ5xHEeVljoLEni0X2LcT7rS4Ns4MXq080zKiE5nY+yl7BFgCjKSo048mOh8VCNcUrm49CGXoU9oJ61bWRGOPOlsMmeJSFLxBsYvQcgFLDSQnXTUcGMUJ5Q2bez+7ygPzkv/ZEV2JcqsLZMIM+rF5A2Okqidr2AJIv/NY8H6/PU66Muxe3FkCFtKj5X2q83FbHSkxrZH5bfxSWEtG60Xc0JoZ8z/X4bUAK8OsTGbngThpF5Q8spLrzRFyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAi5Q85EK6Q25Nhs7TD1cAvZckAkOooEjOwOT8W7vpk=;
 b=Kj5AXosxdrNGxmBb5cBFmWomvAtXZOJ3Vv7nnmna09PDi2YvOsVpDy3Cy8HdwWksEDGftdU3ygNKSQ1TYpWtOWrq8GtXOwwMGOKqe1GLeffVULEUpd+YFh35MG9vGQzGLj3fgyKte7LNMI1TW/KhzJvm+xTXW8dJa9PdMYoBuWFJkqPp3Vev1zm6XEptKdbeb3+2BrR+BBApBAN7gThd4qqotMS2ZCHxv4ycmVq+o3Gi0n+EVKwEdJc5rrk8zH0kRQtSxWUNQsVsOZZwuT7s8wMQa1Y8OAqLL3lBxFZfcZ81xVpCGl5mjbTF+6G7OZhHbcz8+FfVAuy0P2A7Nhpp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB7710.namprd11.prod.outlook.com (2603:10b6:510:298::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 02:34:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.045; Fri, 10 May 2024
 02:34:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, "clg@kaod.org" <clg@kaod.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>
CC: "danielhb413@gmail.com" <danielhb413@gmail.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
Thread-Topic: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
Thread-Index: AQHaokUr+P6wkZNtYkaxMX+zeZsqBrGPuj0Q
Date: Fri, 10 May 2024 02:34:46 +0000
Message-ID: <SJ0PR11MB674430CAE103677D42E0A8E192E72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
In-Reply-To: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB7710:EE_
x-ms-office365-filtering-correlation-id: a5ad85bc-cefc-48be-c09e-08dc7099c1b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SEZnaDJTN1o1Q3MvMGVUZE5FQVRUQmk3Z0RGSjM2aGV1UENGOW5XWS9jcmky?=
 =?utf-8?B?dkdhOVYxNWptbjRpSUxFRlpXMkttTnNjcTNwbUhwUGIzQ1ZqcWFUV05Dd1Iy?=
 =?utf-8?B?Y1d4aFM3R1AyY2Q1MW5vbUZoTTlxM0lQdXZub1dSTkJ6bVRwSTB1Z0E4K0lI?=
 =?utf-8?B?ci8zcDNIQjMrWWxlSHYwKzljZVN0WE1SK0ZKbTdJQVhiZE92cFpPaWVId2Zt?=
 =?utf-8?B?UjFtUGd0dUxsKzNQVUx0UDkzZCtrWk9IdVNXVTZzdGpzVEU3akg4V3JPOHlq?=
 =?utf-8?B?Ly9HdUQzcmZWQXNYVkhOeUhPbDB5OThJcUdwZ0c0Nkl3NVBDRU0rblEzUzBr?=
 =?utf-8?B?UzBtMXVNL3ArRXlrdG1hWThrcXlmbDNlY2ZuVXNyR1V3R1RUeFNEMzUzc0RJ?=
 =?utf-8?B?ZHlERDFJT2VsZGpidG9UVTZDQk1XT2dBNnBpSjVsc2tFcUNaYnY3UlRvOWxp?=
 =?utf-8?B?N2VTTUZiOXRmNU55K0NqR2ZxekV6bDQ2U1ZKL2RGWitWZTNMVUVYVnRkc0RW?=
 =?utf-8?B?TXFrNnh6NjdzUmhZMERod3FoSzVoOWprbFBGS2tRZmxBN25UMGlDQlpqV3Ay?=
 =?utf-8?B?YnhhZEltOXFlVXZpRVozcXhsRUdwa0ZpaGNTRDVYdFVlZFhQY05LQ05FN3lS?=
 =?utf-8?B?aDkvT1JhaGpJQjl0eGpSVlZ5SjNOcjZNYU9VZkw1T0syVTkyWURwZVYwUVpR?=
 =?utf-8?B?djNEb1Y2MUc3VHV4VkdLbkVDQTBxOFJCZXRCM3pWWnExanhQRkhuZjh5ajB6?=
 =?utf-8?B?ZlJyelJjbnQxSTR1Vzh2TlFSRjJWcUxGQUcrRzZKRnhyNSs5SEI2RE81QXVw?=
 =?utf-8?B?eXV1QllJOFF5RHdHeENtcjJldG1qUVlGeVVoVEZCc296cXNWWEpySCtJWnlk?=
 =?utf-8?B?eTc4ZkxjUExBc0tpSGIybUw3YTU4Z0JJNnFuM00rdGIvWWxtOWZhdXNBZ1c5?=
 =?utf-8?B?Q1pyU2xGcHpUREZ0MVVkMk1sbTMwVG5TZk1JT3FXSzhtRlF5TkNVS0RFY1Zy?=
 =?utf-8?B?TCtpOWhlTS9BalZwcDYrUzdoTXFzMGVZZkMyeTc0TTBBRmNydXhOejhQNGV3?=
 =?utf-8?B?K05PZ1ZlWVlzVm1wOUlRUDYwYitKZXBaMjhmT0EvQzhTZERjdDhUUU9aNjlT?=
 =?utf-8?B?WitneDdpMkRYOTNWYjM2UlN6NDVsZlREN3JUYktlREwwQXh1aEtEUUFZaHpU?=
 =?utf-8?B?eGZpbFR0Y1B6WUVtUTE5aGgycEpCT2ZkUUphYVZ6V0N0NWpjTFBQZGZMb1Na?=
 =?utf-8?B?WDJTV25WSjR4SnB0VGF5YU1jUVIxeVdlZjEraFc2MnY0RmlpVDNKZWRSQ2I2?=
 =?utf-8?B?d1AxQ3VTdWdxc3VKSFArUHVNdlpEbVRiUHVjWjBKTzhEVUlCbXFyTnljU1Vj?=
 =?utf-8?B?T1lGM3VXNGx4SUNORHhrL3JYMUtjUkhTZVJaaUxZR0dNM3RnZ2tJR3dEanZR?=
 =?utf-8?B?WTdGV1ZZVU0wYithMWhHRmhZTnhISUxWYUVpMEU1YlJZR3A0TmpVTDM3S1dy?=
 =?utf-8?B?SVZGN2s0STF1Mlk5RTkzNC90M0RBbFhVMEIzM0RNeDI2Vk93bGs0VEVGc3pO?=
 =?utf-8?B?UzJFeEYxb1pFVUNaNThQMFM0UG40Zk5qUWRDRjcrS1VwWHZld0hubnQ4OWNS?=
 =?utf-8?B?TzcvTDA2UERkYnA3Y2pZM1ErSTFuTmxKMHZBZDl5c1IxQWdxV0RmT1dlRzha?=
 =?utf-8?B?Vm54d1BpUGYwL3BkT1ptVmxPOUZTU3cwdFZjc1RGSDMveUdFVWx0SWcvWjQ0?=
 =?utf-8?B?M21OeW85WHZISUNCYXQ0akh3U0NISEJLeFhMNlJpNGRYUFErbGVRNHh2cDVB?=
 =?utf-8?B?ODFDcUk4M3VVTlZ4YjZmZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEwvU0V1cDhuN3hpUWdNTWFzSVV6ZDF4alI2aDlHWXN2eXJqUWJIU1hUeDlL?=
 =?utf-8?B?NFZFOEwrVi9GZ2hDSzBBRkI0REgrUTY2WmFGY3F0Vnp1cmFyVytEUkJuRjlR?=
 =?utf-8?B?M3NCT3RtOHhnSnpxaVdhTDE3T1VlcVlIeEJYTmRKSERJdExHRmtRRExYWWRr?=
 =?utf-8?B?YU9aczBwdlBXZFlBWkl3SEh2eXFPTkZ6YTZjM0xtS1JUU216TnIzTXpxbGNX?=
 =?utf-8?B?YUdzM1AxUnNxdjVEYUZFN0JjaXZ1S2hlcTBsWThRM1o3cElDbWREbE1ZT2VL?=
 =?utf-8?B?RTc1c1JDeHJSNGYxak9DRkxDM0tLZGhjWFFnb1l2M3o0TS84cWcrOWlFSDVy?=
 =?utf-8?B?MlZ4L0syV0NnZldhTzIzNG01a2JvVnl4QmpTUkwrV2M4S2ZRenB3KzVILzQy?=
 =?utf-8?B?RWF6TGl3Z0V6L09ReFlkUUdTV0VKQUlnK0VRSW9JWEE5bjNCOTNWMWxBc28z?=
 =?utf-8?B?NzdxVHU1L1J1ZFdvVTZNZXNjWVIvZmI5cXF1WFFoMWFVdVp6eFhCYlA4L3Fr?=
 =?utf-8?B?WlZyaEtybEpHNHozUWpweVRnZTlPaGtiUzNyRU5uazBqeDJMUWdPV1EzaXpi?=
 =?utf-8?B?Vi96MzVXcEFVTHFIUmx0OUZxYXMxQy9WamtheThRWVNXNGg0Z2lKenkxOWFo?=
 =?utf-8?B?RWRKZjZKdUlEVm5QVGgyQ1d3YzFJMTQxOVd6Wkx5RDRVL1ZKbFRBT0dtOTZT?=
 =?utf-8?B?ZXZHcmo5N01WK2RlTGNUUXloNzBiNGlHTE8rSFp1OVZ1R1FmV3pBeC91aEhB?=
 =?utf-8?B?d1BCQ2tIcG1lL0F2R1I3M2tmYmdXMmprMzdrZ1F5Tk5XN3dDNEtSTUZsWHJt?=
 =?utf-8?B?TEhkSDFleGEvRTZiY2RFQWtYODZyU3hWbXhwUlRmN1hGY3grZW5FWTRxSXdv?=
 =?utf-8?B?dStEQ1RxdlkzL1czRXR0dFk4b1JaVUZvR1JRck5iNWRCWHNaMkRyQ3graUto?=
 =?utf-8?B?SXp3cHdJbzlESkJtZitURjAxWGJINFF6dGJjSkFydFY0TGtyVmEvaW9JY2x5?=
 =?utf-8?B?N1lpWXZsYTZBcHJaaUxQalp4bnFKcytIanR3SHNlaWVMeU5uZDRHS2hRTHVt?=
 =?utf-8?B?WW5pRkxTNWNsdTNLejg4ejFkUlpiSE9VeHNHbUZibUVNNG9Fa2ZVUXF1RExS?=
 =?utf-8?B?bzdUWlQ4TnRCVTlIeHMybkgyT3FSTllidXBaNUQwK3JzOHlyekFmOFVnNmNq?=
 =?utf-8?B?ZUJxZURTamg4S0lOVjBXVlNiS3NyWnZKZnR6bEJHc0w5c1YreDJYOGFLbWFz?=
 =?utf-8?B?ODJQU3hJZmJqRHEzd01FclhqMXlCSWlndWxmalNITlpyRlFFRU94M3BTcDdE?=
 =?utf-8?B?SWpMMVAyY1VMa0tueVdFSzYyREMwWkMxeVVtaGdLb292ajR3K3lrdlBSMUxV?=
 =?utf-8?B?QzJtcGJwQzl2d0phMTFWL0J3VmNjckZ2UFVHWVgyMld0TWVMRHJFMmk1eHR6?=
 =?utf-8?B?RHpjSmZEeWtQdDdncWZkeUoxVmR3eU5rcnduNk03RW5RUUN4SmV5UkNtQmND?=
 =?utf-8?B?anp5MkptbmllQU1vQ0RqUFNyd2RaV2tCYXV3NENrZWEyem1tTDU5QTBPVU1u?=
 =?utf-8?B?RnAreEdYa0RucjhYS0ZiOVJ1K1VLdmVuNHZ6VXNscFFPQ1hJYjEvQUVXVHo2?=
 =?utf-8?B?TklCZUx6WGtpNnlYRzE1RmlwVktqbVpBc3BiYmVVZjc2S3Y1S3NZTVdoeFli?=
 =?utf-8?B?VkZvZEp6Qm52ZExiM2Vxc1BENC9ua05xZ1NmU2NWc0kyaGFqS2JPcFlDNU1o?=
 =?utf-8?B?eUxGZHMyNExjOUUrMzQzaU52YklvakVVd09LckNkQlRpSENNYW9nNngwRmp0?=
 =?utf-8?B?VDBsMmVIcjlQWGdRd2NseTArQXpSTGVxQXVqTkNSWEVMSkxLYjUxSGh1VGtx?=
 =?utf-8?B?bGFORGl4YlB5Z09GbWhvSVBZa0Zqa3ZST2hpYVZQYXFYR0JWY3pvM3VVSTAy?=
 =?utf-8?B?bWY0Q3VSMFlhbnc1SjdNSTNPRGI4YlFmR3ZuMnhyNEZmc1BNc0ZYT2d4SVdy?=
 =?utf-8?B?VjlPb0FYTEV2Wjl5cXF6WEE4dVR3a3V0RTdJdzBKWElzTWxNOVMyNGNDajZh?=
 =?utf-8?B?aThseW9NV29GendPNDRUejV6dzZLK0ZqZDYyblVqZkxLRTNteWdSK3JJVkg3?=
 =?utf-8?Q?SDwtNHi0JQi7LtNENM+A13SwG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ad85bc-cefc-48be-c09e-08dc7099c1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 02:34:46.1362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1oXFo8T6LcJSLgji8zYTwojjD+ZpaRlED/1HcdLgf+pmKfGu/oOthw6mzrOVKbliIvJkZUGR30EEkFhEZIGd4b6z126WWpnR7wjwDY9/j4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7710
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNoaXZhcHJhc2FkIEcgQmhh
dCA8c2JoYXRAbGludXguaWJtLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0hdIHZmaW86IGNvbnRhaW5l
cjogRml4IG1pc3NpbmcgYWxsb2NhdGlvbiBvZg0KPlZGSU9TcGFwckNvbnRhaW5lcg0KPg0KPlRo
ZSBjb21taXQgNmFkMzU5ZWMyOSAiKHZmaW8vc3BhcHI6IE1vdmUgcHJlcmVnX2xpc3RlbmVyIGlu
dG8NCj5zcGFwciBjb250YWluZXIpIiBiZWdhbiB0byB1c2UgdGhlIG5ld2x5IGludHJvZHVjZWQg
VkZJT1NwYXByQ29udGFpbmVyDQo+c3RydWN0dXJlLg0KPg0KPkFmdGVyIHNldmVyYWwgcmVmYWN0
b3JzLCB0b2RheSB0aGUgY29udGFpbmVyX29mKGNvbnRhaW5lciwNCj5WRklPU3BhcHJDb250YWlu
ZXIsIEFCQykgaXMgdXNlZCB3aGVuIFZGSU9TcGFwckNvbnRhaW5lciBpcyBhY3R1YWxseQ0KPm5v
dCBhbGxvY2F0ZWQuIE9uIFBQQzY0IHN5c3RlbXMsIHRoaXMgZGVyZWZlcmVuY2UgaXMgbGVhZGlu
ZyB0byBjb3JydXB0aW9uDQo+c2hvd2luZyB1cCBhcyBnbGliYyBtYWxsb2MgYXNzZXJ0aW9uIGR1
cmluZyBndWVzdCBzdGFydCB3aGVuIHVzaW5nIHZmaW8uDQo+DQo+UGF0Y2ggYWRkcyB0aGUgbWlz
c2luZyBhbGxvY2F0aW9uIHdoaWxlIGFsc28gbWFraW5nIHRoZSBzdHJ1Y3R1cmUgbW92ZW1lbnQN
Cj50byB2ZmlvIGNvbW1vbiBoZWFkZXIgZmlsZS4NCj4NCj5GaXhlczogNmFkMzU5ZWMyOSAiKHZm
aW8vc3BhcHI6IE1vdmUgcHJlcmVnX2xpc3RlbmVyIGludG8gc3BhcHIgY29udGFpbmVyKSINCj5T
aWduZWQtb2ZmLWJ5OiBTaGl2YXByYXNhZCBHIEJoYXQgPHNiaGF0QGxpbnV4LmlibS5jb20+DQoN
ClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8Wmhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
DQpBbiBhbHRlcm5hdGl2ZSB3YXkgaXMgdG8gaW50cm9kdWNlIGEgVkZJT0lPTU1VQ2xhc3M6OmNy
ZWF0ZSBvcg0KVkZJT0lPTU1VQ2xhc3M6OmdldF9jb250YWluZXJfc2l6ZS4NCkJ1dCB0aGF0IG5l
ZWRzIHNvbWUgcmVmYWN0b3IgdG8gdmZpb19jb25uZWN0X2NvbnRhaW5lcigpLg0KDQpUaGFua3MN
ClpoZW56aG9uZw0KDQo+LS0tDQo+IGh3L3ZmaW8vY29udGFpbmVyLmMgICAgICAgICAgIHwgICAg
NiArKysrLS0NCj4gaHcvdmZpby9zcGFwci5jICAgICAgICAgICAgICAgfCAgICA2IC0tLS0tLQ0K
PiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCB8ICAgIDYgKysrKysrDQo+IDMgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0
IGEvaHcvdmZpby9jb250YWluZXIuYyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj5pbmRleCA3N2Jk
ZWMyNzZlLi5lY2FmNTc4NmQ5IDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4r
KysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+QEAgLTUzOSw2ICs1MzksNyBAQCBzdGF0aWMgaW50
IHZmaW9fY29ubmVjdF9jb250YWluZXIoVkZJT0dyb3VwICpncm91cCwNCj5BZGRyZXNzU3BhY2Ug
KmFzLA0KPiB7DQo+ICAgICBWRklPQ29udGFpbmVyICpjb250YWluZXI7DQo+ICAgICBWRklPQ29u
dGFpbmVyQmFzZSAqYmNvbnRhaW5lcjsNCj4rICAgIFZGSU9TcGFwckNvbnRhaW5lciAqc2NvbnRh
aW5lcjsNCj4gICAgIGludCByZXQsIGZkOw0KPiAgICAgVkZJT0FkZHJlc3NTcGFjZSAqc3BhY2U7
DQo+DQo+QEAgLTYxMSw3ICs2MTIsOCBAQCBzdGF0aWMgaW50IHZmaW9fY29ubmVjdF9jb250YWlu
ZXIoVkZJT0dyb3VwICpncm91cCwNCj5BZGRyZXNzU3BhY2UgKmFzLA0KPiAgICAgICAgIGdvdG8g
Y2xvc2VfZmRfZXhpdDsNCj4gICAgIH0NCj4NCj4tICAgIGNvbnRhaW5lciA9IGdfbWFsbG9jMChz
aXplb2YoKmNvbnRhaW5lcikpOw0KPisgICAgc2NvbnRhaW5lciA9IGdfbWFsbG9jMChzaXplb2Yo
KnNjb250YWluZXIpKTsNCj4rICAgIGNvbnRhaW5lciA9ICZzY29udGFpbmVyLT5jb250YWluZXI7
DQo+ICAgICBjb250YWluZXItPmZkID0gZmQ7DQo+ICAgICBiY29udGFpbmVyID0gJmNvbnRhaW5l
ci0+YmNvbnRhaW5lcjsNCj4NCj5AQCAtNjc1LDcgKzY3Nyw3IEBAIHVucmVnaXN0ZXJfY29udGFp
bmVyX2V4aXQ6DQo+ICAgICB2ZmlvX2Nwcl91bnJlZ2lzdGVyX2NvbnRhaW5lcihiY29udGFpbmVy
KTsNCj4NCj4gZnJlZV9jb250YWluZXJfZXhpdDoNCj4tICAgIGdfZnJlZShjb250YWluZXIpOw0K
PisgICAgZ19mcmVlKHNjb250YWluZXIpOw0KPg0KPiBjbG9zZV9mZF9leGl0Og0KPiAgICAgY2xv
c2UoZmQpOw0KPmRpZmYgLS1naXQgYS9ody92ZmlvL3NwYXByLmMgYi9ody92ZmlvL3NwYXByLmMN
Cj5pbmRleCAwZDk0OWJiNzI4Li43OGQyMThiN2U3IDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vc3Bh
cHIuYw0KPisrKyBiL2h3L3ZmaW8vc3BhcHIuYw0KPkBAIC0yNCwxMiArMjQsNiBAQA0KPiAjaW5j
bHVkZSAicWFwaS9lcnJvci5oIg0KPiAjaW5jbHVkZSAidHJhY2UuaCINCj4NCj4tdHlwZWRlZiBz
dHJ1Y3QgVkZJT1NwYXByQ29udGFpbmVyIHsNCj4tICAgIFZGSU9Db250YWluZXIgY29udGFpbmVy
Ow0KPi0gICAgTWVtb3J5TGlzdGVuZXIgcHJlcmVnX2xpc3RlbmVyOw0KPi0gICAgUUxJU1RfSEVB
RCgsIFZGSU9Ib3N0RE1BV2luZG93KSBob3N0d2luX2xpc3Q7DQo+LX0gVkZJT1NwYXByQ29udGFp
bmVyOw0KPi0NCj4gc3RhdGljIGJvb2wgdmZpb19wcmVyZWdfbGlzdGVuZXJfc2tpcHBlZF9zZWN0
aW9uKE1lbW9yeVJlZ2lvblNlY3Rpb24NCj4qc2VjdGlvbikNCj4gew0KPiAgICAgaWYgKG1lbW9y
eV9yZWdpb25faXNfaW9tbXUoc2VjdGlvbi0+bXIpKSB7DQo+ZGlmZiAtLWdpdCBhL2luY2x1ZGUv
aHcvdmZpby92ZmlvLWNvbW1vbi5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+Y29tbW9uLmgN
Cj5pbmRleCBiOWRhNmMwOGVmLi4wMTBmYTY4YWM2IDEwMDY0NA0KPi0tLSBhL2luY2x1ZGUvaHcv
dmZpby92ZmlvLWNvbW1vbi5oDQo+KysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgN
Cj5AQCAtODIsNiArODIsMTIgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0NvbnRhaW5lciB7DQo+ICAg
ICBRTElTVF9IRUFEKCwgVkZJT0dyb3VwKSBncm91cF9saXN0Ow0KPiB9IFZGSU9Db250YWluZXI7
DQo+DQo+K3R5cGVkZWYgc3RydWN0IFZGSU9TcGFwckNvbnRhaW5lciB7DQo+KyAgICBWRklPQ29u
dGFpbmVyIGNvbnRhaW5lcjsNCj4rICAgIE1lbW9yeUxpc3RlbmVyIHByZXJlZ19saXN0ZW5lcjsN
Cj4rICAgIFFMSVNUX0hFQUQoLCBWRklPSG9zdERNQVdpbmRvdykgaG9zdHdpbl9saXN0Ow0KPit9
IFZGSU9TcGFwckNvbnRhaW5lcjsNCj4rDQo+IHR5cGVkZWYgc3RydWN0IFZGSU9Ib3N0RE1BV2lu
ZG93IHsNCj4gICAgIGh3YWRkciBtaW5faW92YTsNCj4gICAgIGh3YWRkciBtYXhfaW92YTsNCj4N
Cg0K

