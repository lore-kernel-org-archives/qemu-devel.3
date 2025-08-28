Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE36C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 09:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urYbG-0002aP-F6; Thu, 28 Aug 2025 05:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urYb7-0002Ye-Bp
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:07:09 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urYb5-0003de-3Y
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756372027; x=1787908027;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=a0eVj46OjVwxb83cWClSFoABRFxrV9aa2s5tFPSMUNM=;
 b=ZMbJ5ogR4liW9rxFwoqj9wm0FxqXFoEq783YphpI6pXO14R/KK2afsCD
 B1uee49gozBX51lsDZpuUN7j1KZb3XTPlxSxaF9ymv7UBmiQRPXgm95Cg
 iae94uY1YkFyJY+K0mRWNoXajdwEXv5MKZNFO8XGvL8/Y2Qo0Mopq9XwQ
 D2sCzJiR+hNU6ImpSA2xP0pSW1r6W7XwG85MqZoaJfDc2upoDo4zxFRrh
 h2mZWFL4nQSVgQmQVI2yK6oLGslXj+yJHHo6vbNNqbI+mtAfJYcKsxd6o
 anru0h2d5dhrwh9m14bvSQtcgZYEYYofcD4/W9wWUfmXrBJDdGVwuGOoW Q==;
X-CSE-ConnectionGUID: SZMAnCosStyqt5XS6tBJ4w==
X-CSE-MsgGUID: v5Eb8erzRZO6IOwxWNeLzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81228506"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="81228506"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 02:07:01 -0700
X-CSE-ConnectionGUID: m0VPK2NmS3q5P10ok/NJ3Q==
X-CSE-MsgGUID: HCnLE6CTQ+KszkKMEFZBtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="169358857"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 02:07:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 02:07:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 02:07:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.55)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 02:06:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJL7cC6Z2WAETEoJZe8L6Rd31ywlDYZBYuSaCSLKcZPuTR67qsoqAvwCOUZIdQfjsKqfzPrZkG0EQlRTF4C/fS/VvAoAVEEKv2GSHRAvsbA6ycrEooOd7cdFdERjGqBeCtaoXCb8ScCTfJ39s+Y9SDsNqkI5JHfNJZqPyOucHVa/UvkGYimAUEuaqcVWMBcVcVZyFT/Ll5ftvug+P9nqFPJ5BLgzJ6uQuxZPLztLcQCS74o5znoXDuQ3WsHwnkmeL6WTbgcfjMSEAESd5mQNwIEYH4R+zHzWd1OfltJWWR/WvpxN0SQqTdaIUkCQVC6LcxTxOZKZNsxw46FS4L2opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0eVj46OjVwxb83cWClSFoABRFxrV9aa2s5tFPSMUNM=;
 b=Nl8KYat4S2RDYBV860kBtbUBw86jwCqMthfRPF6SU5Eog/OsaMqSLwj7mJqWep9zzsp0fjObYUvmMERGHEZ16FvjSX2hbWQCfYlHHyGJ+bbU20oK2Ru0R21AjBzAgPwj/Cw2mY/5KsfbjivG3aziXUwwzFQ+cbBv52w8jJ8JW8geQ64apOVdRHYAVvCC5qmbh7txyfVjff6ULlKQhf03s9aByoFYNWd0pLLZRv4+9I1xGk1tXTXgw0i0lKlzY4Dd6t5edbqiLP1AbF6WvCYV81rpBAw5RRLz8t6uvwEHadcdDYq/Vto5qKiTVeTFWh3P21JO6ePniN3jH+f2HJfqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 28 Aug
 2025 09:06:53 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 09:06:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Eric
 Auger <eric.auger@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHcEy/SWdP0XuMIEEmlrKJvbaEB37R2YPIAgAACfoCAABL+AIAAAI8AgAAxxICAARvqgIAACdtg
Date: Thu, 28 Aug 2025 09:06:52 +0000
Message-ID: <IA3PR11MB913632FB83D138289BB718C2923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
 <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
 <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
 <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
 <153e1475-6678-415c-86bf-b7251cb59f3f@redhat.com>
 <aK8kqQOV28V36wtM@Asurada-Nvidia>
 <ecd95fc6-ce8f-484e-b685-d78a382f1705@intel.com>
In-Reply-To: <ecd95fc6-ce8f-484e-b685-d78a382f1705@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB5772:EE_
x-ms-office365-filtering-correlation-id: 3d204775-49b0-4ce0-8424-08dde6123ab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?d1c1cVU5YnJkY3ZNaTdxSStDNUk2Q0ZWZjZrMHJWQ09SNnFPUTJDc0xUUEZC?=
 =?utf-8?B?TEw5ank1cnU0eGRMcjBheVZCaDhBSGF1T0srb3dzeVl6WkRadkk2UGFjOHpi?=
 =?utf-8?B?VzlDUU5lVlFLam1LbU1ieWlaanRnNFcwdGM0ZFQ2Rng0MGwxV1pjSjNDYmhC?=
 =?utf-8?B?K1FKR21Tb1FYZDdGcDc2VlFIay9BWHlLSnRKK0lZQUVWeC81YjRPcVh4TCtQ?=
 =?utf-8?B?Tm9xck5EeUN3RHA2bEQzang5MmlqYVFiMGxnY281RnpSR2swU0RVY2dlbXFL?=
 =?utf-8?B?TEN0SUl3Z3R4WXBRZ0lKTnc3K3NFN0JVSlUzbUlCMUJSLzBnaUZlbG1ydnRT?=
 =?utf-8?B?VXJYSGFnUXJFY1ZYUmR5dWRRdGJwMW12RnhObGlXMWcvU2todFkyVjg1L3dq?=
 =?utf-8?B?QmMvWFpJNWc0SU1aRStkV3E5cW5LS0VNT0l1T0VzYmVrR1FHd1ViYzJjRVdz?=
 =?utf-8?B?Q2YraThrUHlQa2xac24yeG91d2lvSzFBSlE1dElueEhxamlxWnpUUWRNZkFi?=
 =?utf-8?B?Q2RBWEVsTXdPTktCYWQ2NTZEdmdFL1gzSEdhbHFHQmJ6MFdFYzJQSlRtOUZh?=
 =?utf-8?B?YVQ5VmNxQ0lBWTFzSTV4YVVhNXVWNzNEYnVrMHJ1Y2N5azdMNFFtSkZiQnhH?=
 =?utf-8?B?dmxhanpzL0FyVVd6UnFkMTIrNEVQYzQ0ZEgzWEtEdHR5T2lRT25PRnpNblhI?=
 =?utf-8?B?emxUUXVDQWtUdHBsdmhxK1ZyMVpNaHVaSVJVcUlPTWxMTm50MWliRWJLYlBT?=
 =?utf-8?B?WVFYRUtRV2lXOC9waTM5aTNvc3BuamJOQUF1a0lTVDQxdStFOWhMNDBTY3Qy?=
 =?utf-8?B?Q2ZLdUc4cENnVjVOU0ExcENkbC9FRnducm9oOTQ2emtjeEdPY2MycGFTNVJC?=
 =?utf-8?B?bUFWV1dIN0lBY3NhTVc4aUpiQWJwS0ZxYWtJb0UyRVZubEZhb1N5RGRKU21E?=
 =?utf-8?B?ZE54VzVvWXZQNnFBU0tQak1QUk9sc0hpUzZCRnhNYWEyRjZiaFNPaUc4blFi?=
 =?utf-8?B?UWlQbmR3WkRsRWw5NU1BSXJ4TXVJbUFWV0FHdFFNRFF5dFJqa3NINkxtMHpB?=
 =?utf-8?B?MUtDVnc3VlpVUnYwYnArUkxWWWUwRzN2UG1STURnZ1FGTG85U0pFejU4MUkr?=
 =?utf-8?B?WjdPYU5CSmx0WTA2dXJBVVR3UzVnVDRzSjZXNzlPN1dJZkhWYUJuLzAyZGEy?=
 =?utf-8?B?SlV4VG51UXJFWG91S2M0TWhXODYrdllUVjRiQXNkSG04aFAzY05haGdHTWdv?=
 =?utf-8?B?VDdLeVE1ZUpRVFpNN25TbVBHSk9Ud1lXRWhhUjJoMm9sempuVHZ5bDR5VVpv?=
 =?utf-8?B?WDVURmhxRHc0NUVUMHlnUEt4eUVyeDlneFVUd2pTcHZ0WDNRb1NOQUc3ck4y?=
 =?utf-8?B?YkRuWDRwRk9tU09qYlVqYWVBQVVGazBXVUVhZ2FkQ0JTVy9DQjdtNENJK1Jz?=
 =?utf-8?B?UVg3WGRzdEJCNDByK0JXbm1ab01ZbTFCclhBZWVsMTJsaFl5a20xWFNPbDVT?=
 =?utf-8?B?VHcyaUp6SS9KT3FLQjBBVjdYNjcxQWI0SStaWGxvRUZnMmhjVHJ3eCs4aE1t?=
 =?utf-8?B?bERLR2xHbjJzVnBENzVDUHB1azFPQk5XYjlMV0hUeXRadmxHOVhtbGhlS2hs?=
 =?utf-8?B?dEJLODFJK0hmRHZuRGVRUk9nWkVETnVCdS9mWUdpR256MTlCN3ZKUi9FUWs3?=
 =?utf-8?B?cWN1aUZsdHdBdEdxOUkrV3pDeWNUMVdxOWR5TS9qbGJwcmwyZmNSK3k4MkJ0?=
 =?utf-8?B?VUEyWHBnUy9STUdzTE1tcC9jek0wNmNWQXBoR1ZmaUpXQUROZGZ5bWdKMitt?=
 =?utf-8?B?eXRyanU2K3Btbi8xMklhMStlVUhVUWtvZElrM1lhRW1mbmpxWmlEeVByWThU?=
 =?utf-8?B?eUlCY25MUGw0NWExYllEVHhLYUZpUitOTkpwMHhJZ3NHNC8xUEJVS1JFSjlT?=
 =?utf-8?B?ellDMDdjOGcyRUNETWdPTS93VDl6a3BKejNZcEhudlN0bm1Hb3MrR2ZGMzJi?=
 =?utf-8?Q?pQKwVoE9swjKjpY4q7MoQbGfZD0jm0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmU0RzEwNllaV2dFV1BDZkM2WlNjQ3VNWXpzK1VjYzMwNVUvSEQ4Zzd1Tkxl?=
 =?utf-8?B?VmVtZzhCZWxDY1R2L2Z6MnFIbjJ0WHY0ZTNycXoxYWZaMG5rMTN3MW5Menht?=
 =?utf-8?B?eDBRZ2U0SlRGMjZ4bUR2RjRKdFFIZXVZSjhGTWZJQWpXSW9wSThOeVRHL2VG?=
 =?utf-8?B?OVFqak5hYjZENWxkdDBqUmpqYjZlZU96WW9WR29VOXQ4V3daelFjcGx3TFlN?=
 =?utf-8?B?WEtSdUduNTR6SVozWmJtV1JqRlJlaFlLa1E3aE5HblBGREsvb2h3eVY0UDZM?=
 =?utf-8?B?RytJNGlTYVNpbWxLaHFZaDFUQXI5ZWVpVHhxTkpFYzgvTUFHTldGYnB0cXhL?=
 =?utf-8?B?cVF6SnVFa1Z6MHhvaFRJZ2NTZnBGampDZFhuM0NZOTZPaHJXNmwxc09WRGhm?=
 =?utf-8?B?cHZGZnBWdDhzakhJbW8yNlplSC9nNjdzejdqaENNZ1BuNmFIZTlNZURpbzQ1?=
 =?utf-8?B?VmZxcEdEWE14eVhQaUh4M0lRRjEyNjcvWnpEOHpUOVBhaVN0RzdiVFdJWmJ5?=
 =?utf-8?B?eXVxR2tveUtxNEp6VDZrQ2hNbTZjODJnVVhMa3BuSW5MaVZreUE0Q0tsQytK?=
 =?utf-8?B?d0J0bUZvY1JNTk1hQUE4eko3YUZ4YU4welNPTW5XOU5xS3dFcXNhVjZsb1VW?=
 =?utf-8?B?UHVvaFF6VGRYY3E3TGlucWtjWjRDS3R0YnVmY1MxMWQrOUk3TWhKRkVIa1pm?=
 =?utf-8?B?Q1hyelFaeXBQTTQvdGF4a2FFOVZXMGpkN1VRSThZcE1RcHp4OWw5b1prNW1E?=
 =?utf-8?B?S29wZDloVW5UUlpSbmRzMDlyNEhULzlSSHRCeFpxTy9pTUxoTU5DUTdjK0F6?=
 =?utf-8?B?N0g3NFhwbUVJVzZic2JWalpsZlZKQXliSmZSU2F3TEp4TS9VaXh4dWZLNTZU?=
 =?utf-8?B?Y1FoZnJZQXVSR0RqTzVGVktzaTFNQUpvTnN3bEtGOG1SZG1XbUUranVkdmJC?=
 =?utf-8?B?dHh3QkxTYmtxbTdOQUg0Ni9tVW1kQWJZQ2xmTk5qQ21kNXduUm04ZnE5TjRY?=
 =?utf-8?B?RFFvb01ZdFpTYXlHSzFrQTlOOVhRd04yTk5rRFZYSkRQZEovYTZiSWdBYWFS?=
 =?utf-8?B?NWdSNjhaUUUwUWVkREZLMTlLa1pSVFg2ZlNFaU5zTVFXVEQrMGRJVHZoUDIr?=
 =?utf-8?B?YzZLa2I5cGlNdCt0NGNJc3NNWG9UUHBtbzlmckNRWDZJaHlUQjFpU0tJdjdC?=
 =?utf-8?B?endOaWEwVFZOTFYxUWttaW5vMFdCT2VYbHozdzFMMmNOalV1eCtGR3puaTBD?=
 =?utf-8?B?WUFmT3AxUGNyaTRxUXA0SkFuejdkSE5FbXNPUzB3NDh3UXppcjc5aENIbDE5?=
 =?utf-8?B?NWV1L2hMdVAwU0FMNWVPU3JUbDRoN0RMN3AzdFI2eUJPY1IvYnVYbVFyWjJT?=
 =?utf-8?B?MHphNWFYdFhwUGlpUExCazIydEpzdjlLNVBOc0NVTXZxNkxreWJablltN01v?=
 =?utf-8?B?Qkg4T3lxelRFcFVXUldJTGV5eklJSS83dmVsNUZKOFdhQUU1Y05GQmFaUGY0?=
 =?utf-8?B?S3h2L0tzb0tJaklNQWx0RHNja1NtMmNUdUZESnJSMk9pak1YNFppVGhjSVc2?=
 =?utf-8?B?cG9ER2VmTGR3YUVKSG8yRnBEcGZsWmRvVlY4NEpQMDJ3Y092WkxkMVJYajZJ?=
 =?utf-8?B?ekxTZ3JTWitpQ3lwOURUQUhnME5VQ1dTWnY5MmdFdE1VMlB4U054U2RoQnRZ?=
 =?utf-8?B?dUhFeUlOMk1yVWhmNjU1bklqaGVmeVl3b2pMSnhuOWY3Nk9HUXpvc1hSMk9E?=
 =?utf-8?B?TFNJQ3F0Wkk2cWZuRFV6aVdBSGFMVnoyRzhWLzNreXRFVmo5ZjBxa1R5eXhm?=
 =?utf-8?B?a052ek90QmFGRXQzYUV6T3B6cXBqRThXSldpTEEwY09lVUltZ1owS3Avb3VS?=
 =?utf-8?B?Nm8xUFJwV3NhMmlQQlBUam9oZHphR2hnNElBRUpWWFI3cUVreU9UUkRiektC?=
 =?utf-8?B?K3h3c0dRSDAyL0JkeU81K3Bla2NnMGlWYjdXWnQvQkU3bjdPTXlIMjAzNmRJ?=
 =?utf-8?B?YnZsSDRCRSs1NEZyYWloUW45K0lDMWxBOFlmSHBqQkZ3alJCdUVjZjI3NGhV?=
 =?utf-8?B?WFdFNHk2ZnFWak9qV1hlS3l2RS9sSFk3SDJ0QXRRZGRRWUJ0Nmx1NWdqcks4?=
 =?utf-8?Q?lB8803lsWk1ZUdvp4qqQ1feq4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d204775-49b0-4ce0-8424-08dde6123ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 09:06:52.4775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVned+f1nTJ8F7cdG33AKcO6aNeLf6XgeUvmbXfJ2oSXlmUkqilq90NqRvRdadI4Tcb0wh9Bd7XLe9e2MdTepEynQ7J9jbYwdyCazBDMau8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDIvMjFdIGh3L3BjaTogSW50
cm9kdWNlDQo+cGNpX2RldmljZV9nZXRfdmlvbW11X2NhcCgpDQo+DQo+T24gMjAyNS84LzI3IDIz
OjMwLCBOaWNvbGluIENoZW4gd3JvdGU6DQo+PiBPbiBXZWQsIEF1ZyAyNywgMjAyNSBhdCAwMjoz
Mjo0MlBNICswMjAwLCBFcmljIEF1Z2VyIHdyb3RlOg0KPj4+IE9uIDgvMjcvMjUgMjozMCBQTSwg
WWkgTGl1IHdyb3RlOg0KPj4+PiBPbiAyMDI1LzgvMjcgMTk6MjIsIEVyaWMgQXVnZXIgd3JvdGU6
DQo+Pj4+Pj4gVEJILiBJJ20gaGVzaXRhdGluZyB0byBuYW1lIGl0IGFzIGdldF92aW9tbXVfY2Fw
LiBUaGUgc2NvcGUgaXMgYSBsaXR0bGUNCj4+Pj4+PiBsYXJnZXIgdGhhbiB3aGF0IHdlIHdhbnQg
c28gZmFyLiBTbyBJJ20gd29uZGVyaW5nIGlmIGl0IGNhbiBiZSBkb25lDQo+Pj4+Pj4gaW4gYQ0K
Pj4+Pj4+IG1vcmUgc3RyYWlnaHRmb3J3YXJkIHdheS4gZS5nLiBqdXN0IGEgYm9vbCBvcCBuYW1l
ZA0KPj4+Pj4+IGlvbW11X25lc3RlZF93YW50ZWQoKS4gSnVzdCBhbiBleGFtcGxlLCBtYXliZSBi
ZXR0ZXIgbmFtaW5nLiBXZQ0KPmNhbg0KPj4+Pj4+IGV4dGVuZCB0aGUgb3AgdG8gYmUgcmV0dXJu
aW5nIGEgdTY0IHZhbHVlIGluIHRoZSBmdXR1cmUgd2hlbiB3ZSBzZWUNCj4+Pj4+PiBhbm90aGVy
IHJlcXVlc3Qgb24gVkZJTyBmcm9tIHZJT01NVS4NCj4+Pj4+IHBlcnNvbm5hbGx5IEkgYW0gZmlu
ZSB3aXRoIHRoZSBiaXRtYXNrIHdoaWNoIGxvb2tzIG1vcmUgZnV0dXJlIHByb29mLg0KPj4+Pg0K
Pj4+PiBub3QgcXVpdGUgc3VyZSBpZiB0aGVyZSBpcyBhbm90aGVyIGluZm8gdGhhdCBuZWVkcyB0
byBiZSBjaGVja2VkIGluDQo+Pj4+IHRoaXMgIlZGSU8gYXNrcyB2SU9NTVUiIG1hbm5lci4gSGF2
ZSB5b3Ugc2VlbiBvbmUgYmVzaWRlIHRoaXMNCj4+Pj4gbmVzdGVkIGh3cHQgcmVxdWlyZW1lbnQg
YnkgdklPTU1VPw0KPj4+DQo+Pj4gSSBkb24ndCByZW1lbWJlciBhbnkgYXQgdGhpcyBwb2ludC4g
QnV0IEkgZ3Vlc3Mgd2l0aCBBUk0gQ0NBIGRldmljZQ0KPj4+IHBhc3N0aHJvdWdoIHdlIG1pZ2h0
IGhhdmUgb3RoZXIgbmVlZHMNCj4+DQo+PiBZZWEuIEEgUmVhbG0gdlNNTVUgaW5zdGFuY2Ugd29u
J3QgYWxsb2NhdGUgSU9BUy9IV1BULiBTbyBpdCB3aWxsDQo+PiBhc2sgdGhlIGNvcmUgdG8gYnlw
YXNzIHRob3NlIGFsbG9jYXRpb25zLCB2aWEgdGhlIHNhbWUgb3AuDQo+Pg0KPj4gSSBkb24ndCBr
bm93OiBkb2VzICJnZXRfdmlvbW11X2ZsYWdzIiBzb3VuZCBtb3JlIGZpdHRpbmcgdG8gaGF2ZQ0K
Pj4gYSBjbGVhciBtZWFuaW5nIG9mICJ3YW50Ij8NCj4+DQo+PiAgICBWSU9NTVVfRkxBR19XQU5U
X05FU1RJTkdfUEFSRU5UDQo+PiAgICBWSU9NTVVfRkxBR19XQU5UX05PX0lPQVMNCj4+DQo+PiBB
dCBsZWFzdCwgdGhlIDJuZCBvbmUgYmVpbmcgYSAiY2FwIiB3b3VsZG4ndCBzb3VuZCBuaWNlIHRv
IG1lLi4NCj4NCj50aGlzIGxvb2tzIGdvb2QgdG8gbWUuDQoNCk9LLCB3aWxsIGRvIHMvZ2V0X3Zp
b21tdV9jYXAvZ2V0X3Zpb21tdV9mbGFncyBhbmQgcy9WSU9NTVVfQ0FQX0hXX05FU1RFRC8gVklP
TU1VX0ZMQUdfV0FOVF9ORVNUSU5HX1BBUkVOVCBpZiBubyBtb3JlIHN1Z2dlc3Rpb25zLg0KDQpU
aGFua3MNClpoZW56aG9uZw0K

