Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CBCC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 05:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulL79-0005jH-Ek; Mon, 11 Aug 2025 01:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ulL6u-0005iG-6m
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 01:30:16 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ulL6o-0005Fm-Ou
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 01:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754890211; x=1786426211;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FqQfEkZLEP5XfF0jm4/jsQRraQ0bhOzgylVDYfUeZxA=;
 b=VGfoUCxC3HapO2rBko2r3GCTeEuNp8B9I1vJtgGvR5KPIdtjOY9gMMcC
 +smR/jCurTm3n3DoYCIMgSb+8JTi3n871k8uIKmk0mN5eAZgI6O3OGmi6
 nn2ktrFBkYbKRSs9AgM7W83es4L28WC+hOSO4IuODggL/j2hpe9CbG2p9
 ragiTIPHH7FUyVaOaYA9TfEIKr04XG27h5uHu9ALcNPLh71Y3BeX3bkD4
 41gWMD1SLOew77TCYTi0AFNBt6CX5MfIACAgBnZxvVw4pCr1VSjgnSVtS
 L1lP7ngSjUhH7qNN2I+FNYhRSMo6eSy84EWh+t0PAi1ibrw3/Cm3+djb9 w==;
X-CSE-ConnectionGUID: 2KAESQfsQpWXpK/Z0Fq0nA==
X-CSE-MsgGUID: /qLwsrKtQDuy4+2RIKZHTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68214143"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="68214143"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2025 22:30:01 -0700
X-CSE-ConnectionGUID: HAAnsGUgRmyVdBkV29PwUw==
X-CSE-MsgGUID: 8MhxPWuiSdq66tfGBPI3Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="170035146"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2025 22:30:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 10 Aug 2025 22:29:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 10 Aug 2025 22:29:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.40)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 10 Aug 2025 22:29:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rT58HUhxiUw/3ofdhTIeuzYintyQuziQy7XgQ7qgon9iMiVAXt1guXqXdFXSq7sHOR1WzQuuGK9p4Uv7/T4jFbEssazJApFs/1vkJ4+iWrTNzr/o30DSicpgO3vCoF2JV/J9B8+HYUZHFj2fye464L/sdJkwjYYQfbTy1m8+j9CGrp//kOV3oWY/gVv3WixTJSSoIeDqZO9ojVzRNi6NDD/Vr0RVFmXFIJ9sfFNL4h+jToTeGuSK5Ifqfx8nshzHPl7K0XWsW3uPAMe7bo8ca9pmgSQtKV4mKhOQrQ/q1c5eKq5LJdMI9exLIomHlw+rwAm/f34FG5KsfGUnIcBi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqQfEkZLEP5XfF0jm4/jsQRraQ0bhOzgylVDYfUeZxA=;
 b=i1JfU1/DWwaahswrLpB6pv0eQ9MW9B3uwSEdvQIUeGVH6UGcQVmIdMViNyOFIeCDto/TSBgFz1oeY3ddjf0RqvGjvFblSjyGmSDYygFlrEmiSjwhFS2CwkToR6Z25f5C553Spl8Q4h682hq+peNjViTrstliDPcmpl6B2ob5h9VBM7x3C70osG4DFaOp2J2rwX01flKKSos6ZDM4M7KMQ/61DjTyA/uFVd88lwQ4wfkbTEtA2Y3o2UUq3JbKLjRK759dtSQH4e8S19PSyo6u1DTF4Oj9z8OW7jay2roO5Q1SJrUmlUz1vQjej7DPp7lCTgA4EMuvF356y8i4kq1Ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 05:29:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9009.017; Mon, 11 Aug 2025
 05:29:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] vfio: Allow live migration with VFIO devices which use
 iommu dirty tracking
Thread-Topic: [PATCH] vfio: Allow live migration with VFIO devices which use
 iommu dirty tracking
Thread-Index: AQHcCBpD5Vb30jVjO0KE3V3fbSwvRLRYcT4AgAATxNCAAC2LgIAEPgwQ
Date: Mon, 11 Aug 2025 05:29:57 +0000
Message-ID: <IA3PR11MB9136174AC097AC458E529CFE9228A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250808040914.19837-1-zhenzhong.duan@intel.com>
 <9202e1ea-7b83-4caa-85ab-7621413a50f2@oracle.com>
 <IA3PR11MB9136FA0497C10AD0234EEACB922FA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <6a6d33d9-c5d0-4b80-89aa-cad41a23e563@oracle.com>
In-Reply-To: <6a6d33d9-c5d0-4b80-89aa-cad41a23e563@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ1PR11MB6129:EE_
x-ms-office365-filtering-correlation-id: 77133c96-e295-40ac-19ef-08ddd8981bdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MVV2TlF0Q2oyNmxmdmp0U0dIcTBqRndZMzU0Nk5hTDE2ZG5oSFJMQ1pITGtu?=
 =?utf-8?B?MVUwYlBpYzJUa2ZralcyazlmQU52dncxTUhFMDgxYXhHQnBGT3lGalhFaXRS?=
 =?utf-8?B?bEk2YjM1bHJLUks3eEljbXV2ZnphdTlnVkUxZVFtYXFqZHQ5UzJmSG5BdjVU?=
 =?utf-8?B?ZmZOMVRpc253ekpITkdJUXRBV21DS0Jlbnhsa3l1eWI0bU1EaHVUQVlHaElY?=
 =?utf-8?B?Q2tnMmVDRjQwRHVVUDlHVHdoRGNPWjhoYmhKMTBWRTJaVmovVDEvL3ZaZCtG?=
 =?utf-8?B?MnZWazFKU1phQmwzMW9ESXVwYmxBWDBJdlBiZUhiRGhTbFlpdFlyb1F3S1NE?=
 =?utf-8?B?UVpoS0VJYUM3aHdpSGNGbFpWc0c4SlA1OU5uRHZsUGJhTkdqaWQveUR6OERU?=
 =?utf-8?B?bXEwamJBMjltZkxtSEY3OUJYR1ZLbGdjbUtYL21nem8xWU1RWkVLbnlHOVBm?=
 =?utf-8?B?Ynd4TTk5dTJxRHJqWjFTKytqajJvV3RsQVJIN3ZFMkhLdjlzVWdTekJNVkxk?=
 =?utf-8?B?cThRRitGTFRkUDM1U2VzUDF3TXNOZzNWM2dRVi90RWVRaFZhZXFYZU9wV0NY?=
 =?utf-8?B?aXhMVjdrcjZ6VW9zVXJENU85dUpSSEx0S3ZoMWRyRGVGZjdSZElvOGduYkx4?=
 =?utf-8?B?TFhScEI1bDNZVjZYOE1uTjhLa2pTZ3FUM0w4dTlTYy9ocEFrVjRQS04rYlJl?=
 =?utf-8?B?Wjh4UjBNUU1yZUtCdnU3NlNlOGo3eW1wRkNDU21JS2tpNnh5YkNBOXMzbmN3?=
 =?utf-8?B?dmVSMmM1Zm9Dbi9nSnhWeUY3YlgrbEJiSjg0MGJNVitZQTc0bW9zMW45MWdI?=
 =?utf-8?B?b0I5a0g5S0FjR2c5b3RTeWhaUlBkUEoyc2I4c2RGWFNnS0Vvbkk1OURiQWl5?=
 =?utf-8?B?YmJIWEVDeUxZTGp1U2FoUW5YUVF1MSs1QnVtOU9kSk9QQStQSWE5MDE5RzhG?=
 =?utf-8?B?KzdBWEhrU0NBdDQ5em9td1A5dVdCa3J1dmVQRm8vS2o4Y2FlUjI1bW1FS2NX?=
 =?utf-8?B?T0V3Y09oeWVDbklYdTRYWC9uRnhYVUFLeG1nOTdOWlZNeXlEZUkxMGV6RXk3?=
 =?utf-8?B?bkljbzVvbzRsZy9ra2tIQ0xCSVpJWHQ2TkRGdDlpL2pYN3hWVDlUdXQvM2tI?=
 =?utf-8?B?RVg1WGtQd0RQeXdxdkYzTWp2SjgrZGhlWHBzaXlLSHd5L3VESFhyY0phZ3ZH?=
 =?utf-8?B?R05yV3d3Z0lWSkF4YW45U3ErOGRrNGhwY0loQXFBT2tNRnFRbGpscGlNQ2xq?=
 =?utf-8?B?NTE3NUZzaGoxdU9GUEtURXpmeUxYZU1vd2JudzNFRUhWdENxR0NWWFZZUVhS?=
 =?utf-8?B?U0tEREdhMGd0TGZlTlBkRERzSlBZWW1RZk8zZyt2bFpJS0VHME9ham0vczRx?=
 =?utf-8?B?ZFRReGpzMEthb0pPbXpXNmtDem5oYm84bHptNFl3Mkd3emNmTHJWZFphZU4z?=
 =?utf-8?B?Ym9WVGJiZFQ1cGxUbUVWQktxSDNwOG1SY0xycmdSMzJ5TVMzOTB6by9LWjAz?=
 =?utf-8?B?RE1BTmZDSjMzSXp0NGF5MjJ2cHFlRUlSdTNSTzdDbC9IYi8vUThTSjdhUnNl?=
 =?utf-8?B?clVQUmdmM3oxY1NXUkxidE5SVnpFdW5ZbTdYL0ZXR3dITHdJQXJZRzJnVklh?=
 =?utf-8?B?bjNpcTZ3UjdUU05acm0vRTJvZWdUSnlGelhPY3JGRWpycFZtM1VKUlhoRlNm?=
 =?utf-8?B?dXgwbzcybmtOL1pvMW1nbVZGb1g4R2FPSURONmdldnNudzZVSnBQakVvMU1P?=
 =?utf-8?B?N0kwUG5aVjc3cjFVL1dvYVdTNFpqS1krSWV1UHg2MStWdldocFpaUVNoemZm?=
 =?utf-8?B?V09CSUZOdzlraFZoNit0dW13UVFFekJQVjEweXdqVHI0ODBYdnNwbTR2V0RQ?=
 =?utf-8?B?RWEzcEhrMmlIaDZFZkQwR1VKa2NLYWFqdnd6eUdnUEdsOXltRlc4QVdtUTA3?=
 =?utf-8?B?SCs1OTJVc2ZmUmx0dGdVZDIxTjRpSUtieHlGRm9pSW13RGNCRGRBSzFyK2U3?=
 =?utf-8?Q?SvbDYo/ZAVPWiTXJ/gXaB+w0UJr+xI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmdqaGx4QWdad3lVUXVxNGRUdXpTT1dQVTBHMTdxSms1MG14cDRkL1dvNVBY?=
 =?utf-8?B?bVVLdE1ySEVpeGhxZ0xCOTlnWnh3Wkx2dmtraEZDaVZuWnB0eDRYUkFpRlhq?=
 =?utf-8?B?OEVXdFhOM0JISkhnS2p1M3V5NzFVMmxBRUdrUUhoVFF2OGd5Qko4dGNZd0g4?=
 =?utf-8?B?OHBSU2VuWVlVai9lTnlpdXlLYkU4dUhrM1VEOGh6d21lUTJ3bEdXelFlRzZV?=
 =?utf-8?B?ZkttTE9pMC8xUU5jR0J2QndMOU16aWl0RjlPVFVzMGJhRGtoRytCM0duUTB0?=
 =?utf-8?B?UU5pRGdWTUkxY1EzYTV3M3c1eUVJMWFuVHJPZ0lNSHB2eWlnVmJXL3owMVA2?=
 =?utf-8?B?aFZTSkhqelN1NW5BWEF3UFhXNXZId1dpa1dZSG9pcERYVUpVKytBd0FlUFd1?=
 =?utf-8?B?L1h3YkY4UjRvb0dVSVRDWWpFNXVqVDVTeTRJYS9rMHlySFYxaVZ1RmsvcWMz?=
 =?utf-8?B?S1NlZFV0ZkV2NXlKSy9zZ1Fua2N3bUlkTWVhRlZGaWgrSGFHUnk5VlBZRCtj?=
 =?utf-8?B?NWYrOUprc0hIN1JyejdubTYyU0lpSFNOWmhGNUdwRlNNWkNSdHQ0cUVqSHg3?=
 =?utf-8?B?WEtHT1ZhWHZSajJyOHpLMW5KVW5NU3IwWUtGZjR0Z0JxNWo4cDdoSUZPeVNp?=
 =?utf-8?B?dG41UElYcVFWMDcxRzU5ZHExSjlkd3MwQnQ5QzFIWjBqRmN3T1lBTGFZMy9a?=
 =?utf-8?B?VG1rQ2lXRk5oM21NWnJvL3NkNThyN1ZFb1NEWmE1alQ3UnVMZ3pkMmptQVZV?=
 =?utf-8?B?bmNXZXN1bnJ2ZGx5dVZvZHNMWlpmK2F1bEVhZnlJWGpjb1A0K2U1UHJ4Tnp1?=
 =?utf-8?B?UjlqRXorSXgzQkdId3haYzBwZ2lrdWZyK28wUzlmUExDRTBPVmVQUXl1U2hS?=
 =?utf-8?B?SUZlME1yRzJTZ21WamRrclcxbXlkUmM5SEpFa0x5OXQ4cjl5Z24zdXo5a2Vt?=
 =?utf-8?B?Ty9DS0l4S2g3c3hQdXgvWmNEUEkzN01UNHdZaCs2YzlGMXJ4akxGMjljRHhE?=
 =?utf-8?B?d3g2Ynh1ak5aWTN1U0xjUkxtS2lrNURPY3ZCWkNURktLMVpYVVdGL1lpSGsz?=
 =?utf-8?B?UEQ0TVFJMnlJcFFNK1FYTmVrQzB2SXRaTWpmL1NKdkN0bmNscFVWcmhVa0do?=
 =?utf-8?B?ZSs1Z3RWNWtKa1AyOTN2MThaUFc2MmVlUlRLdnVzd1pFVHZkSThReHpPbzd6?=
 =?utf-8?B?WnM5MGRtQVBGT2pOd3dpY1RWNFM5TTlZMk5iWmFFQXY3SmdVUkNncmZ2REhV?=
 =?utf-8?B?Yk9udEhVWCtwVG9wYlFNSTNmamFqZ2lJOWFITUE1WEpUTU1pZzlWNjJSZzV1?=
 =?utf-8?B?ME1GZmRsa1ErM0tEOXYxRzlLRFBaODc4OENzMWdrdEZORkdjeGR0QWJ0ckdD?=
 =?utf-8?B?aGhJby9SRDV6NTVKNVNrWGl4cmpid0dEZEd4UTlrZ2VBZE9GVldhNzdwWk5r?=
 =?utf-8?B?M21pcU4zZEYvcGMxbnR6UmR5aWVHdWN1NnNrYTZwVkJsdm54Nys3R0krQW9Q?=
 =?utf-8?B?dmgzYWEvbjhxNjdReW15Y2ZMRk4yUHRiS244dUhWVzY5MkkzN1Y4RUtJN2ly?=
 =?utf-8?B?dW1SdWUzajY0aEJaZnVCRXlHbjZFRDRaZjd6NVdIUjZJYTlVSTFGcmZUVjRP?=
 =?utf-8?B?aUpDeTBwSlQyVTRIQk95MDlCeGp4ajR0L2Yzc01XQlZjOS9aSnkxazhId2Zq?=
 =?utf-8?B?d2pwUnp5NzFGM0FON2huQU5TUlNrUkNzb0dtZllqazRvK3ZZUjgydk4wUjJC?=
 =?utf-8?B?cXJwUnBnaDRDcGV0QUpuNHRoZDBDalZacElFc0M2bCtydG8vNkpsU3BCbGVm?=
 =?utf-8?B?RVMrRDV4ZnBBWVZiQWsyclZNQkFVMjlzdkdvN3NkaWhNdnhSbTJsb1AweXY4?=
 =?utf-8?B?emt0eTdyV0toejRSMmtWUEYxc2FrK2piRHBWY3NRRWd1czJZajRUQnFGbitM?=
 =?utf-8?B?TERQbWNSYmRMY3l0WExPdkQyZDd2endwcU5vNVptQ25oQVMydGhPUUNoczB2?=
 =?utf-8?B?d0ZiZUNkaUlLTnVJdFdBengwU2lMVnZHSGV2SGg0U3NzRGVoRFN2SFhla1Y3?=
 =?utf-8?B?ME1CMTZmWEp3RFAwK05uQ1Rjb0FIVG9DSFd6eHhRTnFQWGNxLytpQzZLZ3I4?=
 =?utf-8?Q?3RWc7J9x//Eevv9sCwF5FNezg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77133c96-e295-40ac-19ef-08ddd8981bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 05:29:57.0357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjI9zEc20I3pEhAaD/cB2/VVdKRn1hetkbBupHY20Feu1tlad4sKV3KNoUcu/Dn3dhD19c5siB01gZnkHag11ZNVnD//i7dykVvdu8Dc2IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+PiBUaGUgZ2lzdCBvZiB0aGVzZSBmaXJzdCBmb3Vy
IHBhdGNoZXMgaXMgZXNzZW50aWFsbHkgdGhhdCB3ZSBuZWVkIHRvIHF1ZXJ5IHRoZQ0KPj4+IGRp
cnR5IGJpdG1hcCBiZWZvcmUgdW5tYXAsIGFuZCB3ZSBoYXZlIGFuIGV4dHJhIG9wdGltaXphdGlv
biB0aGF0IGxldCB1cw0KPj4+IHNpbXBseQ0KPj4+IHJlYWQgdGhlIERpcnR5IGJpdCAod2l0aG91
dCBjbGVhcmluZyBpdCkgYW5kIHNvIHRoZSBxdWVyeSBpcyBtdWNoIGZhc3RlciBhcw0KPnlvdQ0K
Pj4+IGRvbid0IGhhdmUgYSBUTEIgZmx1c2guDQo+Pg0KPj4gSSBzZWUgdGhlIGxlZ2FjeSBiYWNr
ZW5kIHVzZSBkbWFfdW5tYXBfYml0bWFwIHRvIGRvIHRoZSBzYW1lIHRoaW5nIGluDQo+b25lIGlv
Y3RsKCksDQo+PiB3aWxsIHlvdSBhZGQgdGhhdCBzdXBwb3J0IGluIGtlcm5lbD8NCj4+IElJVUMs
IGJldHdlZW4gcXVlcnkgYW5kIHVubWFwLCB0aGVyZSBpcyBhIHdpbmRvdyBpbiB3aGljaCB3ZSB3
aWxsIG1pc3MNCj5kaXJ0eSBwYWdlcw0KPj4gaWYgYSBidWdneSBndWVzdCBzdGlsbCByYWlzZXMg
RE1BLg0KPj4NCj4NCj5Oby4gTXkgZmlyc3QgdmVyc2lvbiBvZiB0aGUga2VybmVsIHBhdGNoZXMg
aGFkIHNvbWV0aGluZyBsaWtlIHRoaXMgKGJ1dCBub3QNCj5xdWl0ZSBkb25lIGZ1bGx5IGNvcnJl
Y3RseSksIGJ1dCB3ZSBkZWxpYmVyYXRlbHkgbm90IGhhbmRsZSBpdCBhbmQgd2UgYWNjZXB0ZWQN
Cj50aGF0IHJhY2UgLi4uIGFzIGl0IHdhcyBhIHRoZW9yZXRpY2FsIHVzZS1jYXNlIGFuZCBub3Qg
d29ydGggdGhlDQo+Y29zdC9jb21wbGV4aXR5DQo+aXQgd291bGQgYnJpbmcgaS5lLiB3ZSB3b3Vs
ZCBoYXZlIHRvIHdyaXRlIHByb3RlY3QgdGhlIElPUFRFLCBmbHVzaCwgdGhlbiByZWFkDQo+dGhl
IGRpcnR5IGJpdHMgYW5kIHRoZW4gdW5tYXAgKGZvciBzb21ldGhpbmcgd2UgYXJlIG5vdCBhd2Fy
ZSBpdCBleGlzdHMpLg0KPg0KPlNlZSBjb21taXQgNjA5ODQ4MTMyYzcxICgiaW9tbXVmZDogQWRk
IGEgZmxhZyB0byBza2lwIGNsZWFyaW5nIG9mIElPUFRFDQo+ZGlydHkiKQ0KPmZvciB0aGUgaGlz
dG9yeSBhbmQgaW5zaWRlIHRoZXJlJ3MgYSBsaW5rIHRvIHRoZSB0aHJlYWQgdG8gdGhlIGRpc2N1
c3Npb24uDQoNCkNsZWFyLCB0aGFua3MgZm9yIHRoZSBpbmZvLg0KDQo+DQo+VGhpcyBmbGFnIGlz
IG1lYW50IHRvIG1ha2UgaXQgZWFzaWVyIHRvIGdldCBkaXJ0eSBiaXRzIGdpdmVuIHRoZSBuZXh0
IG9wZXJhdGlvbg0KPmlzIHRoZSB1bm1hcCB3aGljaCB3aWxsIGRvIFRMQiBmbHVzaCAoYW5kIGFs
c28gZGVzdHJveSB0aGUgZGlydHkgYml0KS4NCg0KT0suDQoNCkJScywNClpoZW56aG9uZw0K

