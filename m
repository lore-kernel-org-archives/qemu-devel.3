Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEB8CEBF78
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4cr-0005rx-9m; Fri, 27 Sep 2024 02:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su4cl-0005VA-8F
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 02:38:45 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su4cf-0006Vy-4q
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 02:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727419117; x=1758955117;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x1sDcrdhFly3bRBEC3FW8S8I+na7ov2JBdElc/1nDvw=;
 b=aqSO70bqThAzWqHHe+9OKNVY8dFHsR5CGBfg5tri55NJz5GUtwgShiJg
 woNkjCowsY9KVD+pzQz5ZYVY0dlas9CksAec51tUbisYtMJCoqfy2vbnO
 +FneZrGHHEksAKVsLELMueNGYwWVH/uirtwCfoia8LGiUscEcC7be98j6
 ozdJeuXJ0HsfNFc8H2gmfiBikPm4nh88ZZsK7Jki6HT0AtAtZyuFn3q0Z
 /PIKD1JeIV0jtlR6jebYwKI/0Rd/6M8i9FlhvKzIqAKCmoiE03C8AnOXz
 92QueSfXA+ltSu6OSokEHg09VOP1qJ5DwDApmr00OQhTV4KD55XW2/wXs g==;
X-CSE-ConnectionGUID: wIwtx8bPTbih7nzf4TQ9yA==
X-CSE-MsgGUID: ZxpXvR8QQy65aYE4FQfXiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26688374"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="26688374"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2024 23:38:35 -0700
X-CSE-ConnectionGUID: +iOqroXkRU+7TWnGK/h5NQ==
X-CSE-MsgGUID: oJ9nQbY/RlGhNzvlaf/UpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="72328563"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Sep 2024 23:38:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:38:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:38:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 23:38:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 23:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEu+UyfIgKnkHKWW18di8i2YGodsHM5OqJ2I1J07zcPMqGgpwRpzJ3t5pKCJ6q7inOOKSkBkuv4R+JdwZTnZlomIu7QzrKGEPGnSlrXf7Ff6PJaVUWvEayMhO1DvVoZckWiMtYNm1QbxTOj8Sj3rPHqhs/KwxvvpX1vtWJqlUtJ13wRpn8eaQ/mA7Xr/u38XXzliGu77hc9kgwnCagDFpPfhtvfICCCBkpThHn6yQtEcJBOMp4yu6nDlqxJa4LA32cHF6Nvv0fkgQQ6hv06ndJhTwlNsWHCvCkg1nUNSv0s8Wq0SoG9IoEG1yCBTACkXLrrKloJSV9MOAjfG4hpGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1sDcrdhFly3bRBEC3FW8S8I+na7ov2JBdElc/1nDvw=;
 b=cBKM9zJCNZwc1ZdIMEzCJMmdWD03DktLt8WE7R3suDhN20+mRh1W5dYb9ZmrO8fcWoY/KPcOc3MjArop2lCKcDMQzOt1wzfJmpYiWv/m+s04lmObJYO8h+Yhqv4v39KZ1+n/l7bi7D6uD9Qx3ToA4C0LB3y8IoWpk3QvECfqCnEqsMgXXtw4tyE4xr8kPOwRZVXaSoUrDxImfc13d9/6M3NHcwDm1ifLVl0vv9HnFCAjacluaaLlOehDjCEuak/3fsyX1oXqZKvJ6buyHN/168eTZniJeUwVewUivHLmVu3WtiNhbYD3qUBqZRylHzY7zALKaaLN7tBpBlsYc7nBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV8PR11MB8745.namprd11.prod.outlook.com (2603:10b6:408:204::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 06:38:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 06:38:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Thread-Topic: [PATCH v3 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Thread-Index: AQHbBAsqxPQHOFBLTk+4BQsQvOSnXLJrHZMAgAAZ0aA=
Date: Fri, 27 Sep 2024 06:38:32 +0000
Message-ID: <SJ0PR11MB674403EF8B8923B1C9D5E7FE926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-9-zhenzhong.duan@intel.com>
 <CACGkMEsQHL=+s65UH0mM6ukv5UyLs0ZFiMHB-G58_T1qvsOvvg@mail.gmail.com>
In-Reply-To: <CACGkMEsQHL=+s65UH0mM6ukv5UyLs0ZFiMHB-G58_T1qvsOvvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV8PR11MB8745:EE_
x-ms-office365-filtering-correlation-id: ecf2c879-ffcd-44d0-83dc-08dcdebf016f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bTdIZy9PODZRYXNpMVhWV1BZazdwU3FTS2ZydHpqSFVpQk5qN0x4Q0thekFi?=
 =?utf-8?B?azZvTlBJbWVxeGE3bkdtelF1SG9SL1Jha2N6MXpGZXFSM0V2ZStiaWRJYlpG?=
 =?utf-8?B?Lzk1UzZjVmROK0wwbGpIVnUzT2FLRnVuUUlCS1BmUmtSZjJMQlduZW9wSG5h?=
 =?utf-8?B?UzBHOG5yWDdyYzdWTjQ3blMxazVON0wvUURUVnFUc3Brd3kwY2RZZUxRRlRu?=
 =?utf-8?B?UTJ6bE9jRG91ZDJnWisxMndtSjNWS3BieVRrZzQyT1pFT0hqYWhuOUlCUkI5?=
 =?utf-8?B?TWt6dzd2SkFNdDlHK0t2VU9yUjkzaEdOLzdNcmVHbnZZbXd4dlNTWm9FeUpj?=
 =?utf-8?B?UUxHaXBENGtlT0MrcUlKK3ZBNjRNTk9JaVpTY3NTTzF0RWQxdEN2cGNncDl6?=
 =?utf-8?B?bFJCc2RGT0VDd1ZLZnJOMmt6RVIxN2lXRmU2Yms0MFAvY1d6UlQ4VjJVcHJv?=
 =?utf-8?B?SVV1ODhCN0NYamsvL2FkZGpDcXFaNjMyN0NUdnYwUlNCTEErN0x0SkxUQXEy?=
 =?utf-8?B?S1B0Z0xtU1cvUlhlbXIxSFRCbWQzd1hPeGN4UW00L3JpUE1uS3dpcms4aTJs?=
 =?utf-8?B?ZFBTMzJqZDQzcTZCRDB1LzkvclBhY0RoNGRkdmxUSlJ5MDB1SXhTR1hZb3Fv?=
 =?utf-8?B?TWVGNjV5b2dScFRKaUNNRGt3WmN4eSs2US9JSlNEcHVWM3RadDViR3NKdDZh?=
 =?utf-8?B?OXhFaHRDdXBGQTBSNVRpUGU1VWxDaEM1VXczUnZWcU9BWjB6RjlOK1FOenNa?=
 =?utf-8?B?aTFLTE5RVWVYdVhPM3llSnRMakNxeDBIYUI3TkxLbDA4ZlF4MDB5MXZLck1Y?=
 =?utf-8?B?UmUwU0NYU0Z0aTIyWFN5Q1FvbUNTTDhqWXpTRnZMT29GZjFrVmQ4NXdiNFFY?=
 =?utf-8?B?WVBZVVFoWXNPdklnaVBXR05Ob1dpdkFqa2JsWXJtOWlCT1lTdmlsNmFvbDl0?=
 =?utf-8?B?R1MxeUZ0bG5mT1lIakZxZzBNRGl5azMxaE0wL01lVzR3ODJFQVBtQXc0WWY0?=
 =?utf-8?B?T1B5a2NlVzFoWEtVekg4WnFZRzliT1RZY3NSSy9XUm5JYS9ja1Ryc1FBUGNW?=
 =?utf-8?B?UVk2S3ZOcUwrSnVGaFNuZWxDUUxtNXF3clZ0THQ3enZ1bXN3a3YzWi9TU2lq?=
 =?utf-8?B?VTRxOWhZR2c5STdiWmp4Ym56UVliVlZJemU3TG1yNXJYWnBuempFdDRKeE1t?=
 =?utf-8?B?eG9iOGVaWFZZQUgwUzhKYU93ZDJ5ZHhUSExXQjhSTFMxdEl0OXowVUFBWVM4?=
 =?utf-8?B?b2Y2S0VXbHlHM2hxYnFBM1lFLzVsVWUwYU50bkNUbDVvaGJSUE04ZkJLSFlH?=
 =?utf-8?B?MEI2bnZXU2xXV2ZIZjExR250RnJTdU9qeWdpODhLVmxxRTlobTA1WFN6TG53?=
 =?utf-8?B?MElBZlkvTlNYc3VFTnpaQnhTQm9ZYm01dnFhL3F4MEloaVFqSWk2M1AydlFv?=
 =?utf-8?B?cmVMZXkyTGR0dlRjMXFvbDhmQjcvM01acE9kNHBhUlRyQnYyVkpiUmhxMHpa?=
 =?utf-8?B?S1ZoZ3pSK1RLbWVEbDIrL2JVM2ZOVTR2Tm93MXppd2VUaHV6bnZ5d2tZSXM3?=
 =?utf-8?B?S2NGMUNGMDJPWHMzRGhIVTFMNU8ySnlncDdXa2Yrc05DVkZWWTJNK1RZOXh6?=
 =?utf-8?B?a1dYRGtEZHdhQ08vUEc2elAzNTkxbURjZDFIb0lkTHlWSkxtYk90ZTFPWmFX?=
 =?utf-8?B?YnQ2WE5STmlYeUZ0NUx0aVBWN1NiT2c0M1BieDZEMHF3OWphSzdXYWx0cVQ5?=
 =?utf-8?B?bnp2WFpwcGp2MHVHV25wRTd1UWpmN2FScDcwcnVtR0FEc2JDT2hGWnAzVXBw?=
 =?utf-8?B?UkF1eXhLZWMzZlJPcFBvdkZmL2I0Znp5Sno1YlQ5UzRERkpxYm1SNjUyNDFy?=
 =?utf-8?B?alJKOW9ralhlRHdzT0k4UjBtNmlSOVorcXNDUUZmeDFsOVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjNqR2pXbHZyVXpxRXBrNVFGQjhxbm1iMXA1MjlMcnFYeFNZZUxLZnZYK3V3?=
 =?utf-8?B?YTNPcmdwWjR4RjM1RithYmR5Y3Z1VzJEOEdHdFNPZ1h4M3hGVmRENll5OTdX?=
 =?utf-8?B?MThGS0JqT0VOU2o1ajdJL1orQ2w3Y3FKdE5QTEc2aENoS3J4enVDbVZQbEI0?=
 =?utf-8?B?MHpyejJzQTMxaDVUOUdsc1pXOXpLQXJWL1d4VFlTdTYzTXhRd1UvYllSZSsy?=
 =?utf-8?B?YmlqNEFKWWs5WEFlYURVc0Z2bCtZcHFyakY0MFpoYW5xejRiR044bDJUbTVZ?=
 =?utf-8?B?bWZTR0R1N2ZpYjg0cVJ0M2lCd0M3UWRyaXp0Zk1qTmtGNzdLRFBxbHFUbjVU?=
 =?utf-8?B?NXBsVEk0V2J1K2tiV1l6K2FCV2U5U1BHd3RqcUFmSGo0czRZdk9EbjNGUith?=
 =?utf-8?B?OXMxTXlwbzd5NzNyaHY3MXFnM1NqazRBRXEzRDBGVi9Hbmo1d2NOYzczd3JK?=
 =?utf-8?B?OGdldEx3YnAwQm1qK0QvQ2Q1YThJV2FocE1DQ1NBN2pJaDBPWEhEYjkzM2lh?=
 =?utf-8?B?bEdkWlo0b2RPbXNLMU1vMTVtK0dmcXpZdFg3MStNaStQQWp3N3RHRXNvSkpk?=
 =?utf-8?B?U0M5eGRURzNDcE5FTXE4VUZUY3M2b3VrQlluRUJ0aWIyV2s1R3pzbGZOdXRm?=
 =?utf-8?B?RWZEUHQ5TVViS01DN05EeXgvZFUyWTFod0xEeCtLZlliMU4ybzVQZGIrYXhV?=
 =?utf-8?B?cTFXOG9VZzE1Ymp1bFhadzl2Yk1vTXoxeDlKbG1xcjNRdVBTNDdBaHBPSWEw?=
 =?utf-8?B?a2dGa0FTSTBGcHl6cFptQWZqdkFLNUhKMHlCVUJLTXJkNVdjcE5kTHNoRTNz?=
 =?utf-8?B?SjROYnBneTlXaWxvcVRVb1MwRm80N1QzVkJLUlRvaVh5WDZRUW53T2p2MC9y?=
 =?utf-8?B?dFNOWmFqVXFQWnM4RDRPbDQ4N255RXJKWHhvUU8yT0tWWWxvbUpKZ3cvc2J2?=
 =?utf-8?B?TXlEZGV5Y0o1b3FQWit0V1BHcGhJWkxzajJhaHJUMmJ5TDhJanZHOFJHd1Zr?=
 =?utf-8?B?V05peCtmQ2h1NjAvbU52VHhoekJRTjJIMXRPaG5OYjgrYUszVnNtaWREbXM1?=
 =?utf-8?B?REpPbi9zcE54clkxVE5NWkorRlRoeitQcnRkZVpxQ1pGWlJXd2wzQTZNVy9P?=
 =?utf-8?B?WkJLY3JlSGpNMVdMSEplTXBDTGtiRjJCS3AraW1rbHBBajBWRi80RWJvZlNQ?=
 =?utf-8?B?bW5XeE91TnRjc1VRMjdBL1ptTkVwV2VCam42emdFczZkdytxYkh0YmpkdFkw?=
 =?utf-8?B?VDhMTzRzU3NHOTJtRElNRTlIOWVwc2FvRFI4dVR6VEJ4SHZWSkRGNXg4amNi?=
 =?utf-8?B?cVdGeU1kVFBYRmI2UnhoZ2k4MmR5UzBIdGlxZHpUSjhwTWJQOEhRdWVOcTVN?=
 =?utf-8?B?VWo3dVpzQTJwbVRiZUxkTDhsWFdlQnZzT3ZUbUFrRFVHOG14REU0Q1hweWJ1?=
 =?utf-8?B?Tm92d2FSL2MrM2tNNEZRTS8zWENjaWVyTk9zeHlxcHNIMG9UY2libVljcENY?=
 =?utf-8?B?UURIZy9MazdVcE5SN1pVOGYxMFUyUXdycEdEUWxlR3IzYjlvczVDSmw0YW1P?=
 =?utf-8?B?cTM5QVZZNm5VRGtMQkdnQjY2SGRvdjRjcEVQK1I2VEtabWVHVCtWQ2grYU5D?=
 =?utf-8?B?bUljVWg2RCtKS2xPLzQxVm8ramw0QlVJTWxuL29MNUR0TThUZU1wK0k0QTU4?=
 =?utf-8?B?Slc2bVpoK0dUL01XeDJJWTFLNVk5dXB0WGVPeEZOWTNTNU9ZR3ppbGFGZmhm?=
 =?utf-8?B?RjBjcG5ZaWJwZWZsbGxpQTNEQjEyTGN3NVVyLy9ORitWeTdRaUhNRytvRUdw?=
 =?utf-8?B?L0tPVmUrbG1CZTBDYjB6bGVmYkVQS3E2UnUwdzFuNy90SFhJUXZWTGFSay9F?=
 =?utf-8?B?S3dJNjg5NGsvd0FqUDFzdXkyc2Mzd3NwWFRnNEFhYm5id3A1SXpQdGxVMUMr?=
 =?utf-8?B?ZWpzeXdvWW15UjREYXRrSWNBYTdPYWROdTJndkFjdXl1SlBuUEozYjBOZU5D?=
 =?utf-8?B?MkxDM3B1NEYrWDlzbXlaN01MUzdhT2lwa0JReENoRkU5NG5JZThMejBFTWVm?=
 =?utf-8?B?QmNQYlNYMkhaMmo0a01WZzNKM1RLQ0M1WFRtU0tkUUdFTHNxMDNJV3JYQWdC?=
 =?utf-8?Q?9k/rS7bH6h7Mv4UtN0FHAGTcD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf2c879-ffcd-44d0-83dc-08dcdebf016f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 06:38:32.3403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6f61n1pGzIdS+LnHhDq/ytlgbGwZs3u/Tx9SG3dR/9PGAEqPHsDaq5Q13/xCMPte7JQp1CNULiqpf7DgeoNdIMVCTYH/EMVaYdWCq3oerY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8745
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAwOC8xN10gaW50ZWxfaW9t
bXU6IFNldCBhY2Nlc3NlZCBhbmQgZGlydHkgYml0cw0KPmR1cmluZyBmaXJzdCBzdGFnZSB0cmFu
c2xhdGlvbg0KPg0KPk9uIFdlZCwgU2VwIDExLCAyMDI0IGF0IDE6MjbigK9QTSBaaGVuemhvbmcg
RHVhbg0KPjx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IEZyb206IENs
w6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0
aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaCB8ICAzICsrKw0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAg
ICB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDI3
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCj4+IGluZGV4IDY2ODU4M2FlY2EuLjc3ODZlZjc2MjQgMTAwNjQ0DQo+PiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KPj4gQEAgLTMyNCw2ICszMjQsNyBAQCB0eXBlZGVmIGVudW0gVlRERmF1bHRS
ZWFzb24gew0KPj4NCj4+ICAgICAgLyogT3V0cHV0IGFkZHJlc3MgaW4gdGhlIGludGVycnVwdCBh
ZGRyZXNzIHJhbmdlIGZvciBzY2FsYWJsZSBtb2RlICovDQo+PiAgICAgIFZURF9GUl9TTV9JTlRF
UlJVUFRfQUREUiA9IDB4ODcsDQo+PiArICAgIFZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRCA9
IDB4OTEsIC8qIFNGUy4xMCAqLw0KPj4gICAgICBWVERfRlJfTUFYLCAgICAgICAgICAgICAgICAg
LyogR3VhcmQgKi8NCj4+ICB9IFZUREZhdWx0UmVhc29uOw0KPj4NCj4+IEBAIC01NDksNiArNTUw
LDggQEAgdHlwZWRlZiBzdHJ1Y3QgVlREUm9vdEVudHJ5IFZURFJvb3RFbnRyeTsNCj4+ICAvKiBN
YXNrcyBmb3IgRmlyc3QgTGV2ZWwgUGFnaW5nIEVudHJ5ICovDQo+PiAgI2RlZmluZSBWVERfRkxf
UCAgICAgICAgICAgICAgICAgICAgMVVMTA0KPj4gICNkZWZpbmUgVlREX0ZMX1JXX01BU0sgICAg
ICAgICAgICAgICgxVUxMIDw8IDEpDQo+PiArI2RlZmluZSBWVERfRkxfQSAgICAgICAgICAgICAg
ICAgICAgMHgyMA0KPj4gKyNkZWZpbmUgVlREX0ZMX0QgICAgICAgICAgICAgICAgICAgIDB4NDAN
Cj4NCj5OaXQ6IGxldCdzIHVzZSBfTUFTSyBzdWZmaXggdG8gYWxsIG9yIG5vdC4NCg0KV2lsbCB1
c2U6DQoNCiNkZWZpbmUgVlREX0ZMX1AgICAgICAgICAgICAgICAgICAgIDFVTEwNCiNkZWZpbmUg
VlREX0ZMX1JXX01BU0sgICAgICAgICAgICAgICgxVUxMIDw8IDEpDQojZGVmaW5lIFZURF9GTF9B
X01BU0sgICAgICAgICAgICAgICAoMVVMTCA8PCA1KQ0KI2RlZmluZSBWVERfRkxfRF9NQVNLICAg
ICAgICAgICAgICAgKDFVTEwgPDwgNikNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

