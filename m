Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537D1EFCE37
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqs8-0003oM-JC; Wed, 04 Mar 2026 13:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqs6-0003nu-2e
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:22:58 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqs2-0007DM-Cu
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772648574; x=1804184574;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zQiCwiHG/yQayvNkNqtzEP2Iq7FrIfHoNS5Da97rfV8=;
 b=Sk5o3RWC1na85esnEznvO9k4JmgmhZ80x5B9kjqOL+yjeM2RiVXYSVdw
 2RPxdoKTPT9A3uG+ctw2XS71ePEIG6VNHbZsIYyo9mOr94fMcJ98zdpb7
 VythSLscRUi43iMbY8K15j0kOGoPLniZKAxQuapn44vy800jZ+3rkklOI
 Xu5OlclZKDQfkGx4yjdADa7tNoAuaJPn4+UdpMi1lXHH5//E5YS/VgbgK
 +rq+xl8hhv8NFNC7lWe9R7+cD3UprtxibOEuXJRFOWLAfCz4eTVgMX96V
 qjKNjxAEcOvPlxHwQHbzs+YpxyiyAZOAwLb1AC/2Tr1DmhVyVhPsuPkyr A==;
X-CSE-ConnectionGUID: MUUULtm7SLyI2uqWDlbsxA==
X-CSE-MsgGUID: gZjLrSLESCOCLcw7TVl4uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="61292611"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="61292611"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:22:48 -0800
X-CSE-ConnectionGUID: FDU8tdclT3mPlzC/WyHZbg==
X-CSE-MsgGUID: kiakZbwuSwKVkHUBeNcRFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="218558355"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:22:48 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 10:22:47 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 10:22:47 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 10:22:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivN7qfoecGLIQBqQGRulo7lnu5CbDVmOA3nq1+e2sDcwqknHpIxDE0UG4IGJnOmgUqSXlT5O1lI+MaMCO4zzE+uGJHiXyGS2Q0xqdm3rjW6TdATj4+O6RrMY6mQPR4JskucFZqzxQXSPUAWwrPI3X+F5RAtVups5mZV5RWkIsLHwocDsrlCbd8zJaBIIFR94KKm5Ztkcv7rJAOGtFpbgg2bOvnrmemf8HkgaGZtqioCejB1GJD4ogJ4n4Z+utlrzYYP/DTIW0Zf0wQDp5Txzr4CCRZgYW00jTH2smBuK6c99xxCptEmCioCMfjLF6maRjrwd5JNkpOzXrv3Nf4kjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQiCwiHG/yQayvNkNqtzEP2Iq7FrIfHoNS5Da97rfV8=;
 b=T3Nfqvaf83cPTK8hFgo5QiH0TXx5mAVqBruSarbCWPDDTF8BuXwwgZW93EJJ+87y0teXOC8KaizktSM5H7ZnTVaLT+t77m1A+im/0efzuzdJK/IWQNvb0mczouuWSALTeoepFr17FWofmIvSRuR/Gq7Xl+q02Vd939H8bctxE76F45UCufhaVj8wYwxakhlwGSFcXP0P/S2VSDJf8AVJcFqJHojTwdgqF4+gU5CFopf/JEFx6VG8XfP2WPCVOFBaTvl0VRq0aXRaQcoxP3M/663xCeUlkte8E+W1fwtFeWU3ipepOWR72iafEoYZMmxklbIjMMMV+oLpnHzg40YL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5093.namprd11.prod.outlook.com (2603:10b6:510:3e::23)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 18:22:42 +0000
Received: from PH0PR11MB5093.namprd11.prod.outlook.com
 ([fe80::6b8a:a7c9:e153:e460]) by PH0PR11MB5093.namprd11.prod.outlook.com
 ([fe80::6b8a:a7c9:e153:e460%5]) with mapi id 15.20.9678.017; Wed, 4 Mar 2026
 18:22:42 +0000
From: "Chen, Zide" <zide.chen@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Liu, Zhao1" <zhao1.liu@intel.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
CC: Dongli Zhang <dongli.zhang@oracle.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>
Subject: RE: [PATCH V2 01/11] target/i386: Disable unsupported BTS for guest
Thread-Topic: [PATCH V2 01/11] target/i386: Disable unsupported BTS for guest
Thread-Index: AQHckKxQ6kY8l2Il80mWLpZ0C9s0ULV9GhcAgCHL18A=
Date: Wed, 4 Mar 2026 18:22:42 +0000
Message-ID: <PH0PR11MB5093EE8AEA27898F40924BB3F37CA@PH0PR11MB5093.namprd11.prod.outlook.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
 <20260128231003.268981-2-zide.chen@intel.com>
 <7803017e-aefa-421a-92a1-3b5820beba53@intel.com>
In-Reply-To: <7803017e-aefa-421a-92a1-3b5820beba53@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5093:EE_|PH7PR11MB6931:EE_
x-ms-office365-filtering-correlation-id: d35914dd-7d64-418d-f9f0-08de7a1b066b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: qvx5JuGjyeKWUk9L+yMCF8PyC/4P+Z972B2girAV6FuimHTqUyeT52mxhNHjH+PmQBHAQSE96mHbW/RpuvwChTYJgJymjaQPwTuc0zelgGGqxOD++alov8I1mPS09lVh0Whwa9RgTtEY8c0BugVtkS9irSoji1cK+WlIXWDsVZx0rOeb6/1EbHgwWtSqZQCCAXjYomT1lElWiBSZ1POKs4TfIA3yqolqEZoci3w8Qd8pCEPRHxV+c9zcnhli2X80I5MfceKxIocmHjtOTB5uTpb4PExNqG6vjUD2EhbLMqO4Hf7LmNebPG2uS8YD2JZ7OVGIPp2ycP98rtTDMrzpnZlhgkiq8MM2K3wKqTwqxgPb93W+WWldPbzWkAOEdxaqOzdEwpYa1XcaRQJCYYubpGThrkZI4lwEC4GWWutMBj1XUzgIKTYrPHHURY4++tjUrGdOlBw7QbBIP6Q7r1tBosB6mYli6DletE9nDWjKSiZF0VsFoJKfoXeKzdakkv138jjKZ/eb9z7LLHeqESmOgHDV9ikhRYz/Ihh1voie4n+ItoMqnCs94FGrkB43bQI2aK6btsqxBAP4IDtjf6g1xQy15FQtj8GsT5LdaD7RlPrBVDK0UlwGGlo/8cl+tSdMhV7nDFtml5py3yYTIK/46Of+N2941ANr/Z+B7LSnu5WPF6tYrBBWoMalHMMqRMARrJLdgl23mzdhB0IMmxAXzI2ZFXfCi1aL/+YqfP7ay8OZI2ma/qONM5aVyTmbd1GsSCGdK6AQYV+J/lXtFRsu/GFnp9wuQHOWgzwEzYDsmABwsJPI1KtMoks6fGb95kxc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5093.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGp1eWZBQ2VNMngwUCt5eS9WUlprQ0thaitCdEo5cXBoZVM4aTZrb1l1UFJp?=
 =?utf-8?B?OFZPbmkwR3I5TElJWmRxRVJrRHVKbzAwT0k2OWt4U0trb3h5Z0FWR0VkbXBR?=
 =?utf-8?B?WHJMb0JKQ1ZVQjQwdDFpd3BCQ1NNSEF2bEMxRDdCRDNuVGE3YnU2Q3dDQkZF?=
 =?utf-8?B?WHFBKzVFM0t4THNNRE9JOCtEaVphM1o3K0x5Y0Q4TC9jVExteXFhemtPTkNL?=
 =?utf-8?B?T1J0MGYzM3dDWTg3V1Zqcm5DYURnV0lCQ2RHTUk0QUx2TnpiMG5zTWlSL1lY?=
 =?utf-8?B?UjZjOG5oK2ZVUG5iZlRsQVRGR2JCcjl3SUZDU3FQK2g4WHFCUUVTWHI3cnht?=
 =?utf-8?B?VEw0Z2ozOEtjcHlIa0wrblp3NE16M1B6akhjQlF4WTBWeUpmM3BkU05DcFFv?=
 =?utf-8?B?RlkvWWNWSGZ5eXFQVUdkYTRDWUM3L0VlRmxnazlUbFJpQjV1L1FTRUxDV3lL?=
 =?utf-8?B?dUpVVTF3US9pY3Q5RlQvdWk4TlQ1TituS0IyaEptR0xldUsyamlSak42WFlj?=
 =?utf-8?B?amZJNytldGdEdjdwRTdYZ0RsY2xpdGIxTWduRWh6Z01nYThqMUJJdVRxTE5v?=
 =?utf-8?B?eWhnVWxEQWk3Y3hkZ1J4QmRlOUhpOEp4YkZsc3FPS3BGNk0yNTgrMy96V01M?=
 =?utf-8?B?NkdKSU9jenh4TFhUVGhXdnZCSnB2TE52Y1ZPQUpUK2g1YzhTUU42ZWpoYXRx?=
 =?utf-8?B?UFFaMTdReGxyOGVXU3pQQzU0blp6TzlqYkRuREkvNkdPbzFFbEZiUnEvOHpp?=
 =?utf-8?B?cGdUbjRpWTBsQ3lYR003dVdrSSthOTQxbVZpMTdyMG9VbUYxckNodlZEMEM4?=
 =?utf-8?B?TExWamV0MERXUVlNNjlwcFlNSjVrS05lUi8xUTE4MXlwM1N3ZngveVBmLzNQ?=
 =?utf-8?B?Z28wNWIxa2d2bUcyWHpjc1o0ait2bTVBYWVRY0ZNS3h0VUVxQ1pKQ2pRRU1y?=
 =?utf-8?B?UGkydWZzcHF0VlhybDh4L29tM0JLeFAyampuNVluOGRaVEtBZk5ZTzdOd29l?=
 =?utf-8?B?WE5GeW9YTlN6ems0OUhOWkdHMjVwSWVuSUZEQWZSTVlNdm5uMFJCdHZLK3Uz?=
 =?utf-8?B?Mm12VnJ1QU5WZUczTzNvclR1SVl1VWNNNTBoOWFUNGpFWW1UdE1Zd3ZHVlZj?=
 =?utf-8?B?VjlNRFIzanFNN2Y2ak93Rm9VQlIrZ24wZGNaVWVoTXNHdENVeGpScFltUUlh?=
 =?utf-8?B?MzZTamczc0h3a1MyVWwxZnlpOTQ3a0V4ZE1wY2lSWi8wVVJJSm1RT29rU0h3?=
 =?utf-8?B?UFl2R3RnV2YveXU1eDlBR3M3UnRlVU0wWGhtcjZOZmswMU55NVNzekI0YVBt?=
 =?utf-8?B?YkxZd3dTSzZ4Y3dwSFRkd2hUM0pXYy9pMmY0YkJKbmNVTkNPaE1iK1hTNkNl?=
 =?utf-8?B?dzgvT0RSdWp0ZGI0bFd5RDdHWTBhWTJNZFhMVUxmR0FCT1IrcWlNck5xcThI?=
 =?utf-8?B?Z1B5dWtKdXF2RWxjKzFEb0NsVWhkUWZNbFM3MHZvampEMDNWZDJ5RHp0dmJl?=
 =?utf-8?B?NzhZQnh5VWtGaGVZaGZMWXVXZTZ3SnYzNTBsQ3pBMEU2ak1wM2N1dFJFNmlx?=
 =?utf-8?B?RUFTaWl2KzhKT3ZLUW5mRWFkcXhsWWF2aWd2Wld0ak1SMlYwS2x1Z3FiTVA3?=
 =?utf-8?B?YjhONlM2N2JvV2lMOGt5NW9jT1RqdFlhM3ZPZUQ4SVBsVk9zWkJldzRxWXdq?=
 =?utf-8?B?WGRMOEhuU29wNHhwYlVDdEhmcUt5a2phZ3ZKektvcEswSHZ0VXR6NTBMUG5T?=
 =?utf-8?B?MkFHWnh3cEphTEpKbzdVSGFvK01ieXFQcXFrckZPS3VoY1RqaDRIb1J6dkZL?=
 =?utf-8?B?WHlRNGpyL0VORUR0NFZScnRrTGxNNmo0bWNFQ2VVR3lwUU9KU1YxUGw5dnpO?=
 =?utf-8?B?VmdJMmcxL0dWV3ZTdjdJOTdyZEJpWFJFcFJMbkVNRWxlTnZQSkJlampwdkVq?=
 =?utf-8?B?OFJ1U1dodDdaU1FDckViVVUyV2ViMEc1N3NLd0gwcG1vUE80dmo4SkxpT05o?=
 =?utf-8?B?UWs2b1YrUzlzWWZHT1UrKzZpV0c3Tmh3eTRHQSs2amY5TjI0dnlGMVJXSTZ0?=
 =?utf-8?B?ek5rZjJNcDFENmxPUTJ0bFM3WW9hVytrdVJIZklRNFBNZzl1ejFScXExb3Ry?=
 =?utf-8?B?TjR0STk1eFFqaWdIdlM3VVVIZmNwWGVRV0tIZ3JnQk5nVkpaOEtRVTJ2bHI5?=
 =?utf-8?B?cHdhV0VQMVV1a0pUcFhsZFc2OWhFNlVaektKSnNSKzRkeXVEQVZJdzlVV3l0?=
 =?utf-8?B?VWxsenVwM1ZIUTgwcTR4L2NRWlRTZGoyc3JvaEVDMXRxcXl2b1AwaUZiRC84?=
 =?utf-8?B?bnpYbXNjd0FmVDRqRjBxbEoxR1NHZDh4Vy9HRTRPSzc1NWJGNTZGQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Pz7Ga/des9cMKNTul/fIhc48Gwg30Q28a4w3KGQ4xxaFEct4ncDMubO0q4IpYOTGN5M8y3zXBACRU3tenfaGlWSlvEkp6L7BYgY/up8xslAOlDIZ6bwsqPGGyewTQQzLQMmbPm2PLUpkC99VI+4la+vsI8MeE/PIl+jNN33nrtlOacdV6XASw/GYktvr0yD5az9kXLCvzY9anomoDvU7eXzDME3XL9HeM9XOVJKNOg46serjWFfVxOdNMpbIh4DI0vlJLrJaccVuHWPEWtAWbX2FRvBRT85DDqM8waztTqClUCDj9hkQvjMUrWF58zXK36FvehD4iU2NuRqNimPeuw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35914dd-7d64-418d-f9f0-08de7a1b066b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 18:22:42.3391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46/0K4DShzOp3DG520nS3MJT/EF9OK4pLP2icpDPFkKdSXHsb78/WHTnGS0pTjg6oJZeaUUJPjUhsuaYZMZX2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGksIFhpYW95YW8gPHhp
YW95YW8ubGlAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxMCwgMjAyNiAx
MDoxNSBQTQ0KPiBUbzogQ2hlbiwgWmlkZSA8emlkZS5jaGVuQGludGVsLmNvbT47IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZzsNCj4ga3ZtQHZnZXIua2VybmVsLm9yZzsgUGFvbG8gQm9uemluaSA8cGJv
bnppbmlAcmVkaGF0LmNvbT47IExpdSwgWmhhbzENCj4gPHpoYW8xLmxpdUBpbnRlbC5jb20+OyBQ
ZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+OyBGYWJpYW5vIFJvc2FzDQo+IDxmYXJvc2FzQHN1
c2UuZGU+DQo+IENjOiBEb25nbGkgWmhhbmcgPGRvbmdsaS56aGFuZ0BvcmFjbGUuY29tPjsgRGFw
ZW5nIE1pDQo+IDxkYXBlbmcxLm1pQGxpbnV4LmludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBWMiAwMS8xMV0gdGFyZ2V0L2kzODY6IERpc2FibGUgdW5zdXBwb3J0ZWQgQlRTIGZvciBn
dWVzdA0KPiANCj4gT24gMS8yOS8yMDI2IDc6MDkgQU0sIFppZGUgQ2hlbiB3cm90ZToNCj4gPiBC
VFMgKEJyYW5jaCBUcmFjZSBTdG9yZSksIGVudW1lcmF0ZWQgYnkNCj4gPiBJQTMyX01JU0NfRU5B
QkxFLkJUU19VTkFWQUlMQUJMRSAoYml0IDExKSwgaXMgZGVwcmVjYXRlZCBhbmQgaGFzIGJlZW4N
Cj4gc3VwZXJzZWRlZCBieSBMQlIgYW5kIEludGVsIFBULg0KPiA+DQo+ID4gS1ZNIHlpZWxkcyBj
b250cm9sIG9mIHRoZSBhYm92ZSBtZW50aW9uZWQgYml0IHRvIHVzZXJzcGFjZSBzaW5jZSBLVk0N
Cj4gPiBjb21taXQgOWZjMjIyOTY3YTM5ICgiS1ZNOiB4ODY6IEdpdmUgaG9zdCB1c2Vyc3BhY2Ug
ZnVsbCBjb250cm9sIG9mDQo+ID4gTVNSX0lBMzJfTUlTQ19FTkFCTEVTIikuDQo+ID4NCj4gPiBI
b3dldmVyLCBRRU1VIGRvZXMgbm90IHNldCB0aGlzIGJpdCwgd2hpY2ggYWxsb3dzIGd1ZXN0cyB0
byB3cml0ZSB0aGUNCj4gPiBCVFMgYW5kIEJUSU5UIGJpdHMgaW4gSUEzMl9ERUJVR0NUTC4gIFNp
bmNlIEtWTSBkb2Vzbid0IHN1cHBvcnQgQlRTLA0KPiA+IHRoaXMgbWF5IGxlYWQgdG8gdW5leHBl
Y3RlZCBNU1IgYWNjZXNzIGVycm9ycy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFppZGUgQ2hl
biA8emlkZS5jaGVuQGludGVsLmNvbT4NCj4gDQo+IFNpbmNlIHRoZSBwYXRjaCBpcyBoYW5kbGlu
ZyBCVFMsDQo+IA0KPiBSZXZpZXdlZC1ieTogWGlhb3lhbyBMaSA8eGlhb3lhby5saUBpbnRlbC5j
b20+DQo+IA0KPiANCj4gQmVzaWRlcywgSSdtIGN1cmlvdXMgYWJvdXQgdGhlIChsZWdhY3kpIFBF
QlMgZW5hYmxlLg0KPiANCj4gQmVmb3JlIEtWTSBjb21taXQgOWZjMjIyOTY3YTM5LCBCVFNfVU5B
VkFJTCBhbmQgUEVCU19VTkFWQUlMIGluDQo+IE1JU0NfRU5BQkxFUyBhcmUgbWFpbnRhaW5lZCBi
eSBLVk0gYW5kIHVzZXJzcGFjZSBjYW5ub3QgY2hhbmdlIHRoZW0uDQo+IEtWTSBrZWVwcyBNSVND
X0VOQUJMRVMuUEVCU19VTkFWQUlMIHNldCB3aGVuDQo+IA0KPiAgICAhKHZjcHUtPmFyY2gucGVy
Zl9jYXBhYmlsaXRpZXMgJiBQRVJGX0NBUF9QRUJTX0ZPUk1BVCkNCj4gDQo+IEFmdGVyIEtWTSBj
b21taXQgOWZjMjIyOTY3YTM5LCBpdCdzIHVzZXJzcGFjZSdzIHJlc3BvbnNpYmlsaXR5IHRvIHNl
dCBjb3JyZWN0DQo+IHZhbHVlIGZvciBNU1JfSUEzMl9NSVNDX0VBTkJMRVMuIFNvLCBpZiBQRUJT
IGlzIG5vdCBleHBvc2VkIHRvIGd1ZXN0LA0KPiBRRU1VIHNob3VsZCBzZXQgTUlTQ19FTkFCTEVf
UEVCU19VTkFWQUlMLiBCdXQgSSBkb24ndCBzZWUgc3VjaCBsb2dpYyBpbg0KPiBRRU1VLiAoTWF5
YmUgdGhlIGxhdGVyIHBhdGNoIGluIHRoaXMgc2VyaWVzIHdpbGwgaGFuZGxlIGl0LCBsZXQgbWUg
a2VlcA0KPiByZWFkaW5nLikNCg0KWWVzLCBNSVNDX0VOQUJMRV9QRUJTX1VOQVZBSUwgaXMgc2V0
IGluIGxhdGVyIHBhdGNoIGluIHRoaXMgc2VyaWVzLg0KSSBoYXZlIHBvc3RlZCBWMyBvZiB0aGlz
IHNlcmllczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDMwNDE4MDcx
My4zNjA0NzEtMS16aWRlLmNoZW5AaW50ZWwuY29tL1QvI3QNCg0KPiA+IC0tLQ0KPiA+IFYyOg0K
PiA+IC0gQWRkcmVzcyBEYXBlbmcncyBjb21tZW50cy4NCj4gPiAtIFJlbW92ZSBtZW50aW9uIG9m
IFZNU3RhdGUgdmVyc2lvbl9pZCBmcm9tIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gPg0KPiA+ICAg
dGFyZ2V0L2kzODYvY3B1LmggfCA1ICsrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kz
ODYvY3B1LmggYi90YXJnZXQvaTM4Ni9jcHUuaCBpbmRleA0KPiA+IDJiYmM5NzdkOTA4OC4uZjAy
ODEyYmZkMTlmIDEwMDY0NA0KPiA+IC0tLSBhL3RhcmdldC9pMzg2L2NwdS5oDQo+ID4gKysrIGIv
dGFyZ2V0L2kzODYvY3B1LmgNCj4gPiBAQCAtNDc0LDggKzQ3NCwxMSBAQCB0eXBlZGVmIGVudW0g
WDg2U2VnIHsNCj4gPg0KPiA+ICAgI2RlZmluZSBNU1JfSUEzMl9NSVNDX0VOQUJMRSAgICAgICAg
ICAgIDB4MWEwDQo+ID4gICAvKiBJbmRpY2F0ZXMgZ29vZCByZXAvbW92cyBtaWNyb2NvZGUgb24g
c29tZSBwcm9jZXNzb3JzOiAqLw0KPiA+IC0jZGVmaW5lIE1TUl9JQTMyX01JU0NfRU5BQkxFX0RF
RkFVTFQgICAgMQ0KPiA+ICsjZGVmaW5lIE1TUl9JQTMyX01JU0NfRU5BQkxFX0ZBU1RTVFJJTkcg
ICAgKDFVTEwgPDwgMCkNCj4gPiArI2RlZmluZSBNU1JfSUEzMl9NSVNDX0VOQUJMRV9CVFNfVU5B
VkFJTCAgICgxVUxMIDw8IDExKQ0KPiA+ICAgI2RlZmluZSBNU1JfSUEzMl9NSVNDX0VOQUJMRV9N
V0FJVCAgICAgICgxVUxMIDw8IDE4KQ0KPiA+ICsjZGVmaW5lIE1TUl9JQTMyX01JU0NfRU5BQkxF
X0RFRkFVTFQNCj4gKE1TUl9JQTMyX01JU0NfRU5BQkxFX0ZBU1RTVFJJTkcgICAgIHxcDQo+IA0K
PiBOaXQsIHdlIHVzdWFsbHkgYWRkIGEgc3BhY2UgYmVmb3JlICJcIg0KDQpUaGFua3MuDQogDQo+
ID4gKw0KPiA+ICsgTVNSX0lBMzJfTUlTQ19FTkFCTEVfQlRTX1VOQVZBSUwpDQo+ID4NCj4gPiAg
ICNkZWZpbmUgTVNSX01UUlJwaHlzQmFzZShyZWcpICAgICAgICAgICAoMHgyMDAgKyAyICogKHJl
ZykpDQo+ID4gICAjZGVmaW5lIE1TUl9NVFJScGh5c01hc2socmVnKSAgICAgICAgICAgKDB4MjAw
ICsgMiAqIChyZWcpICsgMSkNCg0K

