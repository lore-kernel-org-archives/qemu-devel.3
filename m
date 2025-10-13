Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C95ECCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 06:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8C0p-0001tK-DQ; Mon, 13 Oct 2025 02:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8C0m-0001q5-DD
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:26:24 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8C0k-0006uh-BV
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760336783; x=1791872783;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zVzw5xE/MC+3S1wkupBSulXQaA3gTsZNXVku1B3xUe0=;
 b=eByitnatbAPU0Oa6NsDBVp2WnsCogPvh0ISuCQojoO9xBiefh1L57ecq
 uw3ge0JQ38/LHa0ZyOWTy9XBpZ1GS3N87Kmq5JugoGTF++5aQHlCKlUpp
 jTvm6guUnH2Sn8nKbEdS9rfJ9o1iIMc/nXpCRcaovMiLTOmJTU2Fe0BTU
 qQOlYmM05SLKMSEWp4N7Yjh5jYIyeULese4IXoc/2PS5UqPSEQWm5YrkK
 ukLtIE4flstTljKCLzBxE+srmLGxQSET3sIDOx7lGK4w7Nsry44w+R1mx
 CtQLNaJP+dCHKVtD6ZoWlDhmQ0tVvKwYRQph95xCY5K3RhqtO9CX6joTV A==;
X-CSE-ConnectionGUID: yOFd0/DRQO+MhBFdEstacQ==
X-CSE-MsgGUID: c8m9iweeR9aZbUP8NCZPDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73912934"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="73912934"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 23:26:20 -0700
X-CSE-ConnectionGUID: r4NdJlseTmWJy4/0sYFpPw==
X-CSE-MsgGUID: FkPd2R8dREy2f9t14oC6KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="181196626"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 23:26:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:26:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 23:26:17 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:26:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRN9jRNgRp4k+auHIhVlcaqHIkydRYD1wAYLRKaBF78jrzuuQhI209rMrDzIszn1fDH7D/DnnSa7f5pBkDHGd4N+k9g6g05Tv8gT+3Df3vZE7EhdoN+troYuCjQpy+DQnPN9uBOm+Hg3pXVCc2vdto6IaDV1bwsDJFj2zYSbE3qGhP0HHbRbgSiKEw6ul8+WmaKfBo/6ZCTWmg2Lo355PB8RCokOakcbLUIiH2JdmNlIooKCtvx9H0f52eUHRZIZVi68FPUuheZOzbsVoYJ5jZcBiANjKXhE/Uw5JJKYktdVmha6D7ar1zFuAW6hJRZKht37A41fhxuZkz36+t8Lxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVzw5xE/MC+3S1wkupBSulXQaA3gTsZNXVku1B3xUe0=;
 b=g6IqK7aYfXq3LiXJb95iIhvdjLYvXiyNIbhm29idssZ0zC+ncQDvaG2JfUaRLEv1GUAw2Y7PtqMn7JvXG7sCbS2+Bdkcv7yxLvLzGoLsejYxz7WARAgRC0OinpL9Gur0IDV9zHaRY3OM/QdQxoB+kclehp3yESkyjCtIPwrn0JVO+XKCJMkIE6oT89rO0C8tlqNAH3+a2NrV5tEjPRt+iFJqfRxeRLw7uLzj9wPK5c8XroXQjviFzcrF5H4Vw6gUfWEECDOzxCiK3EyNb5lPegnTWvmS47NeOtEkVsVL45L3jsWUvZVgGoKc74ZAW2kZSzrcG0LKrX8ttBl/BO7G5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:26:14 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:26:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 06/22] intel_iommu: Implement get_viommu_flags()
 callback
Thread-Topic: [PATCH v6 06/22] intel_iommu: Implement get_viommu_flags()
 callback
Thread-Index: AQHcKHp7yD9hALwP7UWRMC9ATRMGiLS+llmAgAEtI3A=
Date: Mon, 13 Oct 2025 06:26:14 +0000
Message-ID: <IA3PR11MB91368BAADF1F7122A15E31A592EAA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-7-zhenzhong.duan@intel.com>
 <a5b8f97c-87ad-4e85-b8b4-59360b6aba97@intel.com>
In-Reply-To: <a5b8f97c-87ad-4e85-b8b4-59360b6aba97@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7455:EE_
x-ms-office365-filtering-correlation-id: e01ae968-173c-4f6c-e3dd-08de0a216903
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?SUFreWxUZmVLZU1CTGpqVmFxM3lXaCt2cUlWaWtmbEdOcjNQZk9MTDhxODR5?=
 =?utf-8?B?czkyU01WUG1MMHJ2UG9sTzdXR2M5eEZET2hMUE84cXdCYzJOMjd0T3JYbXFo?=
 =?utf-8?B?emI2WndMT2c0TTIwTHB4cXZiZXRTL3ovTVJ5TU9vdDRwdmRiaHgxeTJPTFZt?=
 =?utf-8?B?SWgrRkRPOG1UUjgwTlhFTVlrMTEydVhORHR4SzZ0d3Z4L1ZuQVFibmV5emg5?=
 =?utf-8?B?NlpKRzlsU05IMEZyZkdxR09YV1d6YTUwK3RQTER1aEhuTDgyUC9FWWVVNUh6?=
 =?utf-8?B?VjRWTlU3VjBaQ1lSTHRYRFdPU2c3R3FPLzZ2UFdYV0NEVjBNZnBDa05TZ0JQ?=
 =?utf-8?B?SW9YK3N0elhQMytNZFR2M2ZWNDBvRGxLbGFrcGt5bHZIWTA5eTJGMFlhdTlW?=
 =?utf-8?B?N2RyeWZUdnRWTFZGNjBpejJkNWh1YlJ6aDVIbUhtL29Mbk1DemFlMmR3aFMw?=
 =?utf-8?B?NFVoQUNYdGg5WTF3TzhuR1JPVmVCYldERnBxTkgwZ2luTGJXeGk0a21hbXp3?=
 =?utf-8?B?eVVSN0lkdjFQOGlCSU1aK05VRnoxZDBUYllmMVBmUnk4UXZJa1F4SjlEdTUr?=
 =?utf-8?B?K2FGenVldGYvNmliQUkwam5pMkwwcGx4OVJpVlRYSGM5WklYczF1cmhBVlo2?=
 =?utf-8?B?LzhVZlFuNkdxYXVqd3oySFpFWXQ4S1ZvSG42ZGdlWmhoMEptalZIaEZXSjZS?=
 =?utf-8?B?bGhnK3VhTW1vY3FJY1NPZERoY1J1UHVJdnJQNTVGaElFZ2w0T0VVcllPRCt1?=
 =?utf-8?B?TGFrbGtFUjVSSUJuRTlUTDlvSkZyeTdPU1N3N2Q2ay9lSThPKzNEcDdHNmFr?=
 =?utf-8?B?QTB0K2IwMTZrZDJFcXA1cXMvWlhRalo2TVd5czJBTUllSFdtV0dYTDUvWVJo?=
 =?utf-8?B?eE9yakM2OVQ5dVhLT3E1RnhaNS94OUNRZjh1TmxMNzJNVXE0TG0xYzMxM0Jh?=
 =?utf-8?B?dDhmTDhMUWZsTmhQamsxcXI0T0dndWpqMUN2ZjJUemNJRmFaTy84cVd5WVpR?=
 =?utf-8?B?QlJ5bmF0QWFpVmlndkNtNXgyU1NuTlJnaGRFRTdreklBVnMrb3dDcVNwQ3Q3?=
 =?utf-8?B?Vy9HVEtIV1VOWmV2NmFQbjBxUHhGTWhLYVBSMjZNUFdKQkI3ZVhXV2xheHFv?=
 =?utf-8?B?K0U1YXVQWGwyZUdXczVTUFJzZFd0TnIrQkNhcS96QmVKdzRhb1RFN0JmNDg2?=
 =?utf-8?B?dnpFbVVQMlZxajMzb1pWRlFoNXpkK3AvNC9hUXBNbmdPWERHcTFsWXQxd2dz?=
 =?utf-8?B?Yk5ORzRyODk0VUdVQU1mQVh6eWlhNWxRMzlkTGdlNGMwUUVYbzBjaWxrU3Ix?=
 =?utf-8?B?OW5odnVTeitINU1tZ3RrRzlrbTBJaWdmWVhzTDVVcFhUTzJKakk3MGFqQ2g3?=
 =?utf-8?B?Qk96aXNiNERpS2lYN2FBQm1hK1I3WHdNRDRpM21FS3IvTG9qblkrWWNPTjdR?=
 =?utf-8?B?Z3BMN1Q3WUZ0NnFGWXJXVXBtcUEySGZpU29YY0VSVml1VURFa2hhWjQxZTZ5?=
 =?utf-8?B?V2VyUVBMV2l5OVR0M2doVnFMdGUxN0Jjak9EblJmVmIvaFhSTnJHbnc1U0NY?=
 =?utf-8?B?OWNkUGlITHVmbjJtNzJUT0JYUDZneW1wM0ZRb1kyUGJsbTJ3QW1wVm1hTmdn?=
 =?utf-8?B?K2pIclhYcmZ3blc0Z2tlWWc0WGVVVnJJdFhnRTIveGVoR3NxR28yN1oxcTIw?=
 =?utf-8?B?N0xqVWZUeFVuZ3JpbThTSUEyeitub045TWJwMXc5cExoUGh4RzlnUnBxOTRN?=
 =?utf-8?B?MysrVEp4R2tEMEl3OVJ5cjlNSHl0bUhjcXNrejNhc1M5VitCZk5rcXIxOEpk?=
 =?utf-8?B?dmlJL3RwNm45UWJuSTE3Wnp6ZU5XMDgvcjdYSDhrM1NINnRDbCtocEQ2bm53?=
 =?utf-8?B?cTUwOGllZGJBMXJlUnZXakJmK0dkYjQxVmxxemVEWFhZK00vZ0c5Z3dYUGtt?=
 =?utf-8?B?ZHV1dUd1RzZuaWFpeWRTb3lZeHBUaEVuR25ZWTFLOGo0dG1yeWRUNjJRdXBk?=
 =?utf-8?B?V3VmSEVkZDN6dUowSDUzeHNQMEptU1BmTys4eGdjcURRb2VwTkxxUWx2LzlY?=
 =?utf-8?Q?4aVgiH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SCt2aXRxSUVPbkg5aHBKWHBJakN4ZDQyR1pYN2Y1Wk9jbHlhQklOWThiYVp3?=
 =?utf-8?B?Uk1zRlllNXVuZUg5SE1PTFhDR0k1RUNwQmlWc2NidHY4cmlwU1FPTHdkR2F4?=
 =?utf-8?B?NEtsbHoxdHQrc3FQZmVicWV5enVYLzFKRHZnTGRsdFJzRHNyRXJVQ0NTbTJn?=
 =?utf-8?B?LzFBNFVCYklNK2MwMEQxaVIrMUd2YlVwQXBiQWhrSi9CSXV3c1QycGs5UHg1?=
 =?utf-8?B?ekMwSUY4WklnTXlKVlNwRE13REVxZnhUL2ZidGpBaWNQTVBSa3VXMDdzbmVq?=
 =?utf-8?B?dkRibHBDTk1ITzFqUXRkaFNNZmlDcGFXamxkZ3pSeit1STR3REpQd3RjWW5N?=
 =?utf-8?B?V290N2RGbGhNbm54QXEycUNUbWZwSHVjRmNLRVVqNzRaZnRSN0Rzclg1bXpI?=
 =?utf-8?B?dmZUYTEwZkpQTEtBdGx1bm02TjA4TTdkZjA2NnhwQ0lHQUozd2tBV0oyb21V?=
 =?utf-8?B?RWt0dThJWW8vVGNoZk0xNDUyTXJTUVRqSTFhRjB5TUhIS2k2WHhLT2RmRnpl?=
 =?utf-8?B?Wjd3bG9ocmRuZ2w0eVR6MzdWc3hVNW9oYW1DRnhYRG9OUk9TVXZKSUFpOXdX?=
 =?utf-8?B?cHA5ZmcwZTB5eXlZMEFQNjdYcDBFVUNOT21Lak1DeHUzQllWb09BNVdNcnZr?=
 =?utf-8?B?YmZsODhUUHFkSVlhTHJlOHZWZ1RKRVM0WFFFbG1UZHM1aFR5aTNLblNlYWp1?=
 =?utf-8?B?N3dPWGUvNXlQWnladmkzQnZxUVdaWTNIck5pKys0MXhTV1FNMHBOMzVpV24v?=
 =?utf-8?B?WFdWUU10V1NBLzg4eWpDY25Sd0d5T3pBN3RjdHhhLyt1NnhLWkpOa0tZK0hH?=
 =?utf-8?B?bUdTSklGV2ZxTURmTHNSWGhkbjFuR0Y3VitMOUlzNE9malRlRFpYTkdBZUt3?=
 =?utf-8?B?dzRQeDhLVHRFNHhCeXdZZlc2dE5uNXQ1bmlWaWdBVzMzZFB3aWgyT1gvY2pP?=
 =?utf-8?B?ZldZZWo4bkV3U05XRHByU3pBSExrdWFFbmY0ZldLUllOQ1dneUlveXluVzVP?=
 =?utf-8?B?OXdUOTRoTkoxQURjL2NaMDQvUWtHaGM1K1ZSbFFrQ1FlMW9HMmZlWjZ0RWdC?=
 =?utf-8?B?TnhNUlE3aWxMSTVUL1AyT0FqZ2diZ0tCWEo4bFgvOEt5MUZScXUxTlRHSDZ6?=
 =?utf-8?B?S3B0REpuam5hSytWUHdWOERiN3NBWjh6SStpamlDYlc3cG9pdnVxL0FzejNq?=
 =?utf-8?B?NmR4MW9vclcyZDhlQUdoUWRsVzIrUkdqQmE2R25zU1A1SUN4cmVnZHJDQlhV?=
 =?utf-8?B?ZjV4MWlhZWZoS1kwRThqNFA4eU5paDgxRElqeFcrbFgwZEdDUlRHYXBCRUt0?=
 =?utf-8?B?eHRtQVdYSXh0YVI3Z09MVVpSSVpJaWpEMTlPUmZla3IyUVdoZG8yM0xtblV6?=
 =?utf-8?B?RFhaYUlmNEVPRkFXS2U0WmxJQzJjK2xxRmQxRFFIRmhZdmIvek5NMEJJZVRR?=
 =?utf-8?B?ZXQxT1lneldZdmJEcFB4TENNMTVobGpzOWdjK3lnODVnWFJlbVh5NXI5WUxm?=
 =?utf-8?B?Y0xGTERvUW5iL0JjRGYzNFR1WHp2elUrc09lOFk5ekp1UWlSMlllKzBHQlZZ?=
 =?utf-8?B?a3FHTnhXdUxSc0FiMSs5RGhiUGp1UTdxMW5MemNCT2llM1pPWnNEc2pwdXZr?=
 =?utf-8?B?WEp5Mm5ZMFRJdkxmdW5keTVPQk5hVXJYbjFtdFJwZHlBQlU4eW43SWJqb3N5?=
 =?utf-8?B?bE5YWkY5a1dpRC96MGlJQzBsZ1FCazc1Z29LTWRqRytqR0wvRnJWZGJaZlE0?=
 =?utf-8?B?WUNBWWpYalhUcW1XSHN0T3ZJZm0vVlhpUzJUQldyaTQveHd5b2E0L3VTc0tJ?=
 =?utf-8?B?dzNoV2xCVCtEaktTbnhCQSs3bEFVZi9ncjZLUkh3S3JiM0ZRQ0xaNlhjeGdo?=
 =?utf-8?B?cDU1ZGQ5Nkp4UWpQVVdROHgxcDFUNmIyTXFCYWFMaHlISEhuamRaUVV4YXhW?=
 =?utf-8?B?WXFoM3g5ZTI2dndPL0R5RE9PZzZVL1lPa2lWbUhIdjZMcG11aGxQaDlJOFIx?=
 =?utf-8?B?TU9Ba1ZraVpqYWNMcUtwWWJnQnh1WnFqWEJZL2JRUHY0RnJFTkIzbEkwM0Q3?=
 =?utf-8?B?cEdNZ0N2NUtaU2tpOG1HTkhxKzA3dis1Z051MWliWk9aVXk2bDRIeElNSGFI?=
 =?utf-8?Q?d17WZFVOja8cga4b2ZBsXi4HG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01ae968-173c-4f6c-e3dd-08de0a216903
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 06:26:14.4998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cDz+3OlEBwq6aU0xKp9DVbo9X3ZTKnP0TuZ9/Fvjla8lNy/y/oO0dNREyjmzBGyoodGFMFNQqKGrkU10s/lDgOM/eBiPBy6xMwsCXMC/pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDYvMjJdIGludGVsX2lvbW11
OiBJbXBsZW1lbnQgZ2V0X3Zpb21tdV9mbGFncygpDQo+Y2FsbGJhY2sNCj4NCj5PbiAyMDI1Lzkv
MTggMTY6NTcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSW1wbGVtZW50IGdldF92aW9tbXVf
ZmxhZ3MoKSBjYWxsYmFjayBhbmQgZXhwb3NlIGEgcmVxdWVzdCBmb3IgbmVzdGluZw0KPj4gcGFy
ZW50IEhXUFQgZm9yIG5vdy4NCj4+DQo+PiBWRklPIHVzZXMgaXQgdG8gY3JlYXRlIG5lc3Rpbmcg
cGFyZW50IEhXUFQgd2hpY2ggaXMgZnVydGhlciB1c2VkIHRvIGNyZWF0ZQ0KPj4gbmVzdGVkIEhX
UFQgaW4gdklPTU1VLiBBbGwgdGhlc2Ugd2lsbCBiZSBpbXBsZW1lbnRlZCBpbiBmb2xsb3dpbmcN
Cj5wYXRjaGVzLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNv
bT4NCj4+IFJldmlld2VkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+
PiAtLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMTIgKysrKysrKysrKysrDQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggYTQ3
NDgyYmE5ZC4uODNjNDA5NzVjYyAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtMjQsNiArMjQsNyBAQA0K
Pj4gICAjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCINCj4+ICAgI2luY2x1ZGUgInFhcGkvZXJy
b3IuaCINCj4+ICAgI2luY2x1ZGUgImh3L3N5c2J1cy5oIg0KPj4gKyNpbmNsdWRlICJody9pb21t
dS5oIg0KPj4gICAjaW5jbHVkZSAiaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCINCj4+ICAgI2luY2x1
ZGUgImh3L3BjaS9wY2kuaCINCj4+ICAgI2luY2x1ZGUgImh3L3BjaS9wY2lfYnVzLmgiDQo+PiBA
QCAtNDQxMiw2ICs0NDEzLDE2IEBAIHN0YXRpYyB2b2lkDQo+dnRkX2Rldl91bnNldF9pb21tdV9k
ZXZpY2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuKQ0KPj4gICAgICAgdnRk
X2lvbW11X3VubG9jayhzKTsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgdWludDY0X3QgdnRkX2dl
dF92aW9tbXVfZmxhZ3Modm9pZCAqb3BhcXVlKQ0KPj4gK3sNCj4+ICsgICAgSW50ZWxJT01NVVN0
YXRlICpzID0gb3BhcXVlOw0KPj4gKyAgICB1aW50NjRfdCBjYXBzOw0KPg0KPnMvY2Fwcy9mbGFn
cw0KDQpkb25lDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

