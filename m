Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C58C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 08:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIOD4-0004QD-4b; Fri, 23 May 2025 04:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uIOD2-0004Px-ON
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:56:56 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uIOCz-0008L9-TL
 for qemu-devel@nongnu.org; Fri, 23 May 2025 04:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747990614; x=1779526614;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wPjAK7xCotXD9mHnH9OrQlaIXSFPMnsKyx9881tJPrk=;
 b=kEXV4LKLjFEc/PoQxZBk7nPLpocKpD33dLG8FL3CmqbqnxTgUjbwsfc6
 1k/VQ7k8fFKZ9c3o5G7Inm5+Jw1ljFULIbm2YeeaodOoXU5OfSqM52jwt
 MwAwrCBV6lS186NUtaxI+UzAC9rkbyzmqAUegzfHKNYIguP6t7/nJ0LEu
 KKJ8SOnC/1Uj6rwRveTFgRQjcJVXVbN8xRJMH1Tv1QXKTWh3+1Bk604QE
 6Q6dnAxabSurf96kfoqGekv9vB7wake6uXw5Ir0R9qNfP9ICt+CM+ghvw
 l4p3Ed8QhEtruSh/xdXt1C0wuD1DR/5J1FR1gxbnN7fleHqszoo9aAF1U Q==;
X-CSE-ConnectionGUID: knj6U3I6SBeCQf+mXj88Yg==
X-CSE-MsgGUID: yI46fEYFTHebR8ntoBlejw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50096605"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="50096605"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 01:56:46 -0700
X-CSE-ConnectionGUID: rPLftJhLScqQIH08HnwYNQ==
X-CSE-MsgGUID: PKfh6LV2QTOLYs7dPEUnqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="178196065"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2025 01:56:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 01:56:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 01:56:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.86)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 01:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0fIt3JK2lZFxJYL5qyi7ajG9gq/vl2n5wO1uEc6W+K6/CpPUQWgRJID+zrFUqScklzfqvyaYUf01HdWMaB3i9iHqaV95l/7Tvbx8DmscjMAGLIUMnWIJQEurJLFVzIRQo9yYVeqilcq+gwwQV2PlT+AXcicIrgEwt2cuKIHpeozQm3pxWPy3+HZFd50gcGjZxG6mu+SoD63Y4CpCBta2OVoqidxWpe7K5Bio6F4HkRE79NnKJZNz+69ZXs+GgbopcBi7E/pG1MPvnbUuHthXywlsbqwoqYl52reS6bknxFMFddsfaCTLcS5j3b5oAJLPWB6MqM+nirdREN6brNKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPjAK7xCotXD9mHnH9OrQlaIXSFPMnsKyx9881tJPrk=;
 b=HhSLQa9TSokvO5BBVYMsD3REykS3f6Q4Gandw0iZ5AyY0fdQAIVEQzfal5PBOPw6tLhODQWRs2sYpXq4SPwQ5spw7PzJet8ziTNYZl/7B56pi9L8MdyYmsqwwvhzIxPpNsqOSirOXH915TaBQH5fgAc/tzMu6QlH4W43eertzliUE8omcAT17V1YuB8zfqek/l7ZlhpWI2Oli6uy+fzIRUJT/iD97z97hTGUwInyCRhi6tdwh/SpQHs3n+jzWuF96UjciXtK9rzAPDqWbFeQZu/m3zgEifnBRqKUShE+Eif9XXOTvj0ZPlX0toI5n6b5E+m95EzaSvRQLaKHO/e/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 08:56:28 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 08:56:28 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Topic: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Index: AQHbw1yUpeYjtdu/DU2o3xTJaAJiQbPU9flwgAUvL4CAAdBwAIAAb8tQgAC02wCAAOjXUIABMliAgADDF3A=
Date: Fri, 23 May 2025 08:56:28 +0000
Message-ID: <SJ0PR11MB6744E8AE3F29A924FB0866E09298A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
 <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
 <SJ0PR11MB6744AF83E1B9956A76F529D3929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c0db92f1-5bc9-413e-b0c6-39f9eb40344e@oracle.com>
 <SJ0PR11MB6744673E8B958DB5E408D90B9299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9455e537-7426-4332-8d7b-4c6260086ea0@oracle.com>
In-Reply-To: <9455e537-7426-4332-8d7b-4c6260086ea0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB8089:EE_
x-ms-office365-filtering-correlation-id: b07014a8-14be-4a0f-de77-08dd99d7b4a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WXFlSko4K3h2M0t2VkNqMHZaYlFJVFFqMkxoSzAxazcyZk1kOHY2ZmExVVY4?=
 =?utf-8?B?bi9iMk1IeW9lL29hZFR1TkRjcTNYN0puZXR6L3hzbHhPTHZKazBkbjBHTmpt?=
 =?utf-8?B?U2hVMGh2ZGIxQWdGanJ6enFqanNQN0ZidzZsSXNRUllKRVNBbXIxMElMVk9l?=
 =?utf-8?B?NFpPc2EwNXpCSDcweHFGT0JmT0VSZlRZYXBEWHBHdU9BemlwNlhmV0tsUTJx?=
 =?utf-8?B?dkp5OGRKS0NLeDQ1a09KWVJsMW4xakR6dzR3M2tLb0tTNTdnV1NaNjVYRVA4?=
 =?utf-8?B?dGxENXdLR21oR2F0V3pETmlJbkVCT0FHN0wxVlRQdVNSMGFicDdsZEpsTDha?=
 =?utf-8?B?OEtxOU1PcENZMEhoSWlnLzQzNWJjaXZYVDdYUVB3S281dkh5YURuYVNGVlFW?=
 =?utf-8?B?VGNvZjJLUU8zcm5iK0tqWmxtV0lQYXJVVjJSbEJiNUlWUVE4d25VbzVvbEY5?=
 =?utf-8?B?VHd2UTN0V0ZuUytlaCtzVnpYOFdkMW1LS3czQkVMMGt0Y0NTNmNFek1naUJW?=
 =?utf-8?B?cHpCUjR1OU5Icm1YblNuWFRwV3ZUT3pyUTJkZTgvYUl0NkxlQXF5aTdmaExK?=
 =?utf-8?B?d1BBZ3BITllYNnRhT1BYRmV2L3ZSWFZteTR5SnFSZ0tPOXprb1hXOFdONklD?=
 =?utf-8?B?dUdOSXQ1VDRKMi9YOVBGUFpabTJSYmJnODFZbklPSkh4UWRtcXlHSVJCcFhm?=
 =?utf-8?B?dlJ5SldhYzV2d1NDK0daK2NwWHlPbEYrdzJ5NDJWY1gzMStOMDhWSFFHdm5i?=
 =?utf-8?B?K3o2NzliUmlIWjRDeHdSVXNqclhGTWNuNXN2TE9uZ3lqc3p6SVZCRTBGdXN6?=
 =?utf-8?B?d1NWR0tGOTNOaFdXMENjMnNHRVJTYjF1aVpIWWJHWkhHZHNqZmNNZEVScVZn?=
 =?utf-8?B?MTl3K3J4ckJGczVIZHdlRDJ4U3pvNGljNXI0MDJvVHM5elUyc1lwU2Y3c2Rj?=
 =?utf-8?B?N0lHNGtLV1J5elBvMk1iWFY5eStRTGZOWFprOCtFRCtuWEp3UG1HamN3TUJI?=
 =?utf-8?B?T0tJREhOR0tieUx3dVE4YjVaVWg1dU84ODRiOXlnL3VoSXFrZXlzdUxOeVU2?=
 =?utf-8?B?WTRURXgwSFZKbmV6TmMzNDlFQWovcERjY2hFVVFZd29GbVNvaW84LzhCQm9l?=
 =?utf-8?B?ZUJYS2ZKN1JqRGUxVzQzbHdpc3c5Vmg2WlVYSGxmTDZ6eDRUME9qQTZCL3FQ?=
 =?utf-8?B?L3p1dmRRNnMzamRYM3hxZ0t4Ri8vWmZNMUUwRVlkMFFQMDdua0xyT003SnFm?=
 =?utf-8?B?Q3JxMEdIVThlR20rVGdlQVNqd0dZTUtHU3BwN3hHZ3kxSE8wVVpmUjVoMHBJ?=
 =?utf-8?B?UkhldE81NmdkWkFyYVhOMGVsQXFiU0ZKVmVXcjMzWU9TQjhzQmh5dlBqSzlT?=
 =?utf-8?B?NmczbmUwTUR2bVc3VEZpL014UEphcTJoa3dBT3JmMDFmUjRFMC8zTVAxS2tO?=
 =?utf-8?B?VFNQcWhHTi9GOEZMZGRtMHVZNm9TWjljWVNyd21peG1hNU1YbS9ieFU0OUov?=
 =?utf-8?B?ZUNVbHVMajRxMHV3N1lIQ1VDZm5qMTJDTk9mTFZyVU8ydit1Tmp4YWhTTWoy?=
 =?utf-8?B?ZFpLbFRxL1NLUlg3Q2tidmpCQzh2NnArY2U5RFN5MkRXcmU0WDUyNkVZOWY2?=
 =?utf-8?B?WnJ0N0M2U2lHTUFYbGU2a2pyRTRUU2tJemIyUlhLN3FlYnlZSCtNaTZkSS9E?=
 =?utf-8?B?MW9UZUpMdGEwQnYvSmVJNVc1TElodXdselRXNFZEV250Y0h3Ujk5NjdNbVI1?=
 =?utf-8?B?dXBFQnk1bXJ4dE9kL0F2SFUwQjI4WTNIWVREdzJyd011WTRvdTg3cHpMMWo3?=
 =?utf-8?B?eklKNXh3cHIvWHlOMk1PTVZGODNFQ2FhamJOZmovZzZjdzFpaVpDQlJhbExH?=
 =?utf-8?B?ZW9zemhyeTdJeFRsZDVmaWp3YkdnQng0WGhwd0pTK3h6R0hYRm5hZENWQUVD?=
 =?utf-8?B?bXFDU3FUMmsyOUJtYW9HRkNMRXh6cDZBK0ZUTXpnc2dEUmhub0NhMGRyYnRm?=
 =?utf-8?B?RmJZTE8zVWZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cllieFUvSS9ZNWV3V2JsT2JuVmI1VWxIREo5K2hyZE4rRFJpQ2k3b2s2NTUw?=
 =?utf-8?B?WmY1a1dwU3ZEblV3QVlWRmZadllxMm9HSDlKMWxIRmYwOGZvQjJBbjZ1SzUr?=
 =?utf-8?B?WWJCeXBwd21YU2c2WjNtVktqMDgxSzc1M0UzNHlTL1h5eC9yMWRzL015U2Rw?=
 =?utf-8?B?bHFJdVVxYS8rQmlOSldZTjY1Ri9nVSs0NU9ONS9pY1BYdW5rMmxKUG1IaU8x?=
 =?utf-8?B?WU95UGRTVEFjMEdHM1hHU2crOVY1aWlFcUM2bGFMYUtnYnZGS2xyMDdiWW9D?=
 =?utf-8?B?dTZ2eGhZNDhtMm9OUFM1YVliSGtGUm9xMTNTemRXcVI2NDFkNkpOWVZZMlZP?=
 =?utf-8?B?SitOT05MZGtxR0F4eVQ2eFF1cnAwekxTNzlDT1dKbXgxR3pQU1hYbEozN2hJ?=
 =?utf-8?B?RlVtR0t0cVYzMmdIUVgydU1DMkMyNmlhRmFqSXZuZU01ay91RjZheVFoaDdY?=
 =?utf-8?B?SDRIUE5YTVR3YWE3Z3pGL2RIRUhKZ0hURWhOZVJ4c1lMaVZXdHFSQy9qZEpy?=
 =?utf-8?B?NEN6MEtpWE11UlEvdE0zemxaU0h6VE8zNG91L0NpOHc5eXc4Rk9MZzREdVdU?=
 =?utf-8?B?UFRSRXZKNVRNa3d3WVdkWTFCSWtDWWJJTXM0U1F3M3gwdXgrZXdCakhobmU4?=
 =?utf-8?B?OXRtT0IweUc1SVdnZzI5dUwyTnp0d21aZUMvZXp1OWUvTlFGYXQ1OERMM2Ux?=
 =?utf-8?B?Tys4SE9MMi9tVEtzWXAxd25yWE5TU0VaYk53cXd6dno4V3VPWkVsNXVQRzJJ?=
 =?utf-8?B?VTBFTUQ4M2NGR2QyS2FkazNLM1BQOE5YRWR1RzIvcDVVbjhqZ3I5WllOUXhW?=
 =?utf-8?B?M0kyeEZVTHpLT1Njd0lKcVgxRzhDdStZVExtRXNrS2UrYjJrMkx6N2FVSE1X?=
 =?utf-8?B?cm9mcW9rSHA3Q3NkSkJCR21LbzRiWElMYXEwTTd6OTY1anUwS1FRSzlNUHVm?=
 =?utf-8?B?bnhaQkowK201WVBZeUorRE9VdlBlMG1JWStVdjhNZG1PWEFyemR1Lzl4MTV4?=
 =?utf-8?B?dW5JZTZJTElSWWtwanRZT0J5Rk1WQ0QyKyt6WS9nanRIbTFYa3hOSTIwVXVV?=
 =?utf-8?B?b3Q4N202QXNBcmgyNDlMN1VncjUzSHQzQUY3bkZ4NkdraVZZY2ZNZTA2S2c4?=
 =?utf-8?B?cFhkK1RnNm1Nb2pjM1pzSFV2MmVDSG1DVnhKNG9EM0RodEhsNXJXVGpUMVVY?=
 =?utf-8?B?TFkrSW8rTFA2dkdnZ3Zsa0dETjMzOHV4UGYzTGJUeUt4OWorNWIrWWFVZ1hF?=
 =?utf-8?B?SWZvWnF2Q1FRczhocWt4cnNGSjd4Q1Y4T0NyVDdaQ0c4VSs1ZzluTFl3cmg0?=
 =?utf-8?B?Y3htRnRXUFd3UGt3NGxxbGhKZ0RrVTNrdkk2ZExKcHpZblhlUkJpbVJkdnhr?=
 =?utf-8?B?dFdlM2diRE80M20xdFVqQVB3NEVXT0tMWkRiekdXL1EzbnJpQTZ1NklqcWgx?=
 =?utf-8?B?YXZLRDROWlBiZGgwdG1vTXBTeHpBZTVENDhtUEZySnhJdGVobzB4UFJreXlw?=
 =?utf-8?B?VlkyTzFwbjdUdXJ6V2haUEt0S1NGZklrempvSmVtV0I0dkJBUlZaUkxNOG5X?=
 =?utf-8?B?bk9oOVFFVUVKc1IvVVo3bXhKZzg1dFpvWGxKZjFMWTVWTXdHK2E5dTg3SnJC?=
 =?utf-8?B?WTFQdk0reHJtb0NBcjVlNjgwdnovU3pzMGtzR2MzeXhBcXpBOUVtVGRETytP?=
 =?utf-8?B?eFd4RGllVUdGYnQvdWpKd3JWcVltblJvNlM2SHptekpsU0pBVXRIb3ZNaVhn?=
 =?utf-8?B?S3IyYU5qbFNucEcxcXlzWStUZU5MeVc0dXFucmNCTUdOTGRzbkxTVVhnb1po?=
 =?utf-8?B?d1IrOVdjeDl5U1FOTHJYME1YdjNFVHVNUGR2TTZqSmpCZysxSFNhd3RLUnp3?=
 =?utf-8?B?VmtmeEZGaWFyMkc2ZVJtTEc0OCswQmR5SmlxTnJkUDd1bGNzcVNzMXVQVkNo?=
 =?utf-8?B?YlQxZE5DbDl4SmFucUF6dWk2K0Z4Uk4rU0dUd0xJY2VKK25GcTJSeUxGZlY2?=
 =?utf-8?B?VVVlaFdqVnl6b1ZqR1lNWmxBV2ZmYkZwV2hPeTFuelpRaHdLSUlKN2tJNzJC?=
 =?utf-8?B?R0VUUHRKeUlvaHF4QU5hRmJBQzc2VGE2QU9zWGxQNTQ1MC8yUFJaY1BLaHJp?=
 =?utf-8?Q?b2G+1mzgeiN6v6ehLhUyyuetm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07014a8-14be-4a0f-de77-08dd99d7b4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 08:56:28.3842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EV75SQQpS2hgrrF9dhD7fhGhrWmiu32gM8F8P1UFlJ1gtDwMOq9NZWPO0ZFgxPcHJwy5hpdL8SIDgG2G++pOUcoQ1M2H1FoRpmmwYpMeK9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMjkvNDJd
IGJhY2tlbmRzL2lvbW11ZmQ6IGNoYW5nZSBwcm9jZXNzIGlvY3RsDQo+DQo+T24gNS8yMS8yMDI1
IDExOjE5IFBNLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+PiBGcm9tOiBTdGV2ZW4gU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xl
LmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDI5LzQyXSBiYWNrZW5kcy9pb21tdWZk
OiBjaGFuZ2UgcHJvY2VzcyBpb2N0bA0KPj4+DQo+Pj4gT24gNS8yMC8yMDI1IDExOjExIFBNLCBE
dWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
Pj4+Pj4gRnJvbTogU3RldmVuIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+
Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDI5LzQyXSBiYWNrZW5kcy9pb21tdWZkOiBjaGFu
Z2UgcHJvY2VzcyBpb2N0bA0KPj4+Pj4NCj4+Pj4+IE9uIDUvMTkvMjAyNSAxMTo1MSBBTSwgU3Rl
dmVuIFNpc3RhcmUgd3JvdGU6DQo+Pj4+Pj4gT24gNS8xNi8yMDI1IDQ6NDIgQU0sIER1YW4sIFpo
ZW56aG9uZyB3cm90ZToNCj4+Pj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+
Pj4+PiBGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4+
Pj4+Pj4gU3ViamVjdDogW1BBVENIIFYzIDI5LzQyXSBiYWNrZW5kcy9pb21tdWZkOiBjaGFuZ2Ug
cHJvY2VzcyBpb2N0bA0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IERlZmluZSB0aGUgY2hhbmdlIHByb2Nl
c3MgaW9jdGwNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBTaXN0YXJl
IDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+PiBiYWNr
ZW5kcy9pb21tdWZkLmPCoMKgwqDCoMKgwqAgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPj4+
Pj4+Pj4gYmFja2VuZHMvdHJhY2UtZXZlbnRzwqDCoMKgIHzCoCAxICsNCj4+Pj4+Pj4+IGluY2x1
ZGUvc3lzdGVtL2lvbW11ZmQuaCB8wqAgMiArKw0KPj4+Pj4+Pj4gMyBmaWxlcyBjaGFuZ2VkLCAy
MyBpbnNlcnRpb25zKCspDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2JhY2tlbmRz
L2lvbW11ZmQuYyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4+Pj4+Pj4gaW5kZXggNWMxOTU4Zi4u
NmZlZDFjMSAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBhL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4+Pj4+
Pj4gKysrIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+Pj4+Pj4+PiBAQCAtNzMsNiArNzMsMjYgQEAg
c3RhdGljIHZvaWQNCj4+PiBpb21tdWZkX2JhY2tlbmRfY2xhc3NfaW5pdChPYmplY3RDbGFzcw0K
Pj4+Pj4gKm9jLA0KPj4+Pj4+Pj4gY29uc3Qgdm9pZCAqZGF0YSkNCj4+Pj4+Pj4+ICAgwqDCoMKg
wqAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X2FkZF9zdHIob2MsICJmZCIsIE5VTEwsDQo+Pj4gaW9t
bXVmZF9iYWNrZW5kX3NldF9mZCk7DQo+Pj4+Pj4+PiB9DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gK2Jv
b2wgaW9tbXVmZF9jaGFuZ2VfcHJvY2Vzc19jYXBhYmxlKElPTU1VRkRCYWNrZW5kICpiZSkNCj4+
Pj4+Pj4+ICt7DQo+Pj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBpb21tdV9pb2FzX2NoYW5nZV9wcm9j
ZXNzIGFyZ3MgPSB7LnNpemUgPSBzaXplb2YoYXJncyl9Ow0KPj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4g
K8KgwqDCoCByZXR1cm4gIWlvY3RsKGJlLT5mZCwgSU9NTVVfSU9BU19DSEFOR0VfUFJPQ0VTUywg
JmFyZ3MpOw0KPj4+Pj4+Pj4gK30NCj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+ICtib29sIGlvbW11ZmRf
Y2hhbmdlX3Byb2Nlc3MoSU9NTVVGREJhY2tlbmQgKmJlLCBFcnJvciAqKmVycnApDQo+Pj4+Pj4+
PiArew0KPj4+Pj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgaW9tbXVfaW9hc19jaGFuZ2VfcHJvY2VzcyBh
cmdzID0gey5zaXplID0gc2l6ZW9mKGFyZ3MpfTsNCj4+Pj4+Pj4+ICvCoMKgwqAgYm9vbCByZXQg
PSAhaW9jdGwoYmUtPmZkLCBJT01NVV9JT0FTX0NIQU5HRV9QUk9DRVNTLCAmYXJncyk7DQo+Pj4+
Pj4+DQo+Pj4+Pj4+IFRoaXMgaXMgc2FtZSBpb2N0bCBhcyBhYm92ZSBjaGVjaywgY291bGQgaXQg
YmUgY2FsbGVkIG1vcmUgdGhhbiBvbmNlIGZvcg0KPj4+IHNhbWUNCj4+Pj4+IHByb2Nlc3M/DQo+
Pj4+Pj4NCj4+Pj4+PiBZZXMsIGFuZCBpdCBpcyBhIG5vLW9wIGlmIHRoZSBwcm9jZXNzIGhhcyBu
b3QgY2hhbmdlZCBzaW5jZSB0aGUgbGFzdCB0aW1lDQo+RE1BDQo+Pj4+Pj4gd2FzIG1hcHBlZC4N
Cj4+Pj4+DQo+Pj4+PiBNb3JlIHF1ZXN0aW9ucz8NCj4+Pj4NCj4+Pj4gTG9va3MgYSBiaXQgcmVk
dW5kYW50IGZvciBtZSwgbWVhbndoaWxlIGlmDQo+aW9tbXVmZF9jaGFuZ2VfcHJvY2Vzc19jYXBh
YmxlKCkNCj4+PiBpcyBjYWxsZWQgb24gdGFyZ2V0IHFlbXUsIG1heSBpdCBkbyBib3RoIGNoZWNr
aW5nIGFuZCBjaGFuZ2U/DQo+Pj4+DQo+Pj4+IEkgd291bGQgc3VnZ2VzdCB0byBkZWZpbmUgb25s
eSBpb21tdWZkX2NoYW5nZV9wcm9jZXNzKCkgYW5kIGNvbW1lbnQgdGhhdA0KPj4+IGl0J3Mgbm8t
b3AgaWYgcHJvY2VzcyBub3QgY2hhbmdlZC4uLg0KPj4+DQo+Pj4gV2UgbmVlZCB0byBjaGVjayBp
ZiBJT01NVV9JT0FTX0NIQU5HRV9QUk9DRVNTIGlzIGFsbG93ZWQgYmVmb3JlDQo+Pj4gcGVyZm9y
bWluZw0KPj4+IGxpdmUgdXBkYXRlIHNvIHdlIGNhbiBhZGQgYSBibG9ja2VyIGFuZCBwcmV2ZW50
IGxpdmUgdXBkYXRlIGNsZWFubHk6DQo+Pj4NCj4+PiB2ZmlvX2lvbW11ZmRfY3ByX3JlZ2lzdGVy
X2NvbnRhaW5lcg0KPj4+ICAgICAgaWYgIXZmaW9fY3ByX3N1cHBvcnRlZCgpICAgICAgICAvLyBj
YWxscyBpb21tdWZkX2NoYW5nZV9wcm9jZXNzX2NhcGFibGUNCj4+PiAgICAgICAgICBtaWdyYXRl
X2FkZF9ibG9ja2VyX21vZGVzKCkNCj4+DQo+PiBUaGlzIHJlbWluZHMgbWUgb2Ygb3RoZXIgcXVl
c3Rpb25zLCBpcyB0aGlzIGlvY3RsKCkgc3VpdGFibGUgZm9yIGNoZWNraW5nIGlmIGNwci0NCj50
cmFuc2ZlciBzdXBwb3J0ZWQ/DQo+PiBJZiB0aGVyZSBpcyB2SU9NTVUsIHRoZXJlIGNhbiBiZSBu
byBtYXBwaW5nIGFuZCBwcm9jZXNzX2NhcGFibGUoKSBjaGVjayB3aWxsDQo+cGFzcywNCj4+IGJ1
dCBpZiBtZW1vcnkgaXMgbm90IGZpbGUgYmFja2VkLi4uDQo+PiBEb2VzIGNwci10cmFuc2ZlciBz
dXBwb3J0IHZJT01NVSBvciBub3Q/DQo+DQo+SSBkb24ndCBrbm93LCBJIGhhdmUgbm90IHRyaWVk
IHlvdXIgc2FtcGxlIGFyZ3MgeWV0LCBidXQgSSB3aWxsLg0KPldpdGggdklPTU1VLCB3aGF0IGVu
dGl0eS9pbnRlcmZhY2UgcGlucyBtZW1vcnkgZm9yIHRoZSB2ZmlvIGRldmljZT8NCg0KT2gsIEkg
ZG9uJ3QgbWVhbiB2aXJ0aW8taW9tbXUsIGl0IGNhbiBiZSBpbnRlbC1pb21tdSBvciB2aXJ0aW8t
aW9tbXUgZm9yIHRoaXMgaXNzdWUuDQpJIG1lYW4gd2hlbiBndWVzdCBhdHRhY2ggZGV2aWNlIHRv
IGEgRE1BIGRvbWFpbiwgdGhlcmUgY2FuIGJlIG5vIG1hcHBpbmcgaW4gdGhhdCBkb21haW4gaW5p
dGlhbGx5Lg0KDQo+DQo+PiBRRU1VIGtub3dzIGRldGFpbHMgb2YgYWxsIG1lbW9yeSBiYWNrZW5k
cywgd2h5IG5vdCBjaGVja2luZyBtZW1vcnkNCj5iYWNrZW5kcyBkaXJlY3RseSBpbnN0ZWFkIG9m
IGEgc3lzdGVtIGNhbGw/DQo+DQo+SU9NTVVfSU9BU19DSEFOR0VfUFJPQ0VTUyBpcyByZWxhdGl2
ZWx5IG5ldy4gVGhlIGlvY3RsIHZlcmlmaWVzIHRoYXQgdGhlDQo+a2VybmVsDQo+c3VwcG9ydHMg
aXQuICBBbmQgaWYgc3VwcG9ydGVkLCBpdCBhbHNvIHZlcmlmaWVzIHRoYXQgYWxsIGRtYSBtYXBw
aW5ncyBhcmUNCj5vZiB0aGUgZmlsZSB0eXBlLg0KDQpCdXQgdGhlIGRtYSBtYXBwaW5ncyBhcmUg
ZHluYW1pYyBpZiB0aGVyZSBpcyB2SU9NTVUsIHNvIGNoZWNraW5nIGRtYSBtYXBwaW5ncyBhcmUg
Y2hlY2tpbmcgbm90aGluZyBpZiB0aGVyZSBpcyBubyBtYXBwaW5nIGluIHRoZSBETUEgZG9tYWlu
Lg0KDQo+DQo+LSBTdGV2ZQ0KPg0KPj4+IEhvdyBhYm91dCBJIGp1c3QgYWRkIGEgY29tbWVudDoN
Cj4+Pg0KPj4+IGJvb2wgaW9tbXVmZF9jaGFuZ2VfcHJvY2Vzc19jYXBhYmxlKElPTU1VRkRCYWNr
ZW5kICpiZSkNCj4+PiB7DQo+Pj4gICAgICAvKg0KPj4+ICAgICAgICogQ2FsbCBJT01NVV9JT0FT
X0NIQU5HRV9QUk9DRVNTIHRvIHZlcmlmeSBpdCBpcyBhIHJlY29nbml6ZWQgaW9jdGwuDQo+Pj4g
ICAgICAgKiBUaGlzIGlzIGEgbm8tb3AgaWYgdGhlIHByb2Nlc3MgaGFzIG5vdCBjaGFuZ2VkIHNp
bmNlIERNQSB3YXMgbWFwcGVkLg0KPj4+ICAgICAgICovDQo+Pj4NCj4+PiAtIFN0ZXZlDQo+Pg0K
DQo=

