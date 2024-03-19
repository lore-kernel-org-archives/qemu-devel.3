Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A59C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 05:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSHc-0003lR-JP; Tue, 19 Mar 2024 01:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmSHU-0003ju-4M
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 01:45:03 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmSHQ-0006JQ-Ji
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 01:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710827097; x=1742363097;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4RqCy+9CgC4HSE+19Ae4wed36fE1UIdTs7eDTokFy7Y=;
 b=iXFK6i9r0yB7k26YDTo+fwuSQziGdmrUvLpYWCRgmozMLWyIpcQfV9/l
 Qk9JmeWzu85uRR0T3lnm712aqq53MWOqVVW0SsXUxXoV30WcGCJU61bYN
 30Up+9YGAEFLDDm3ydgzTkryLGHRG3/2SoLfyOcl/YK9tJRMHIbJ/yUYh
 oza1AswmmWfKn6mhv4Vmp5I3ZLvOwR+c456jMnJ+ylwga8Zw9oMnC3+2x
 iJ4n0O9MiPU3hyTgBSjiMv4vFbS4FvuR0UlBIfa2dpHgWj5Th8fmexBlO
 VnRVPVk35IqMUR/Y998PGaanqD3gnNvdaYP7De06BceU+ruBhLU2zpZ98 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5796694"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5796694"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 22:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="18277577"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 22:44:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 22:44:52 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 22:44:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 22:44:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 22:44:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzJnwHxl8sa85Jf0LHY7j+q1sbVf5wfQvQBbAsf+/B9vaNs57410FJ7O/7wtYbFMQ2489deel3yjvoR86RsAJwhtiYK9j98O6hmv1dQOtsA9g4ZwhzRoxPqFtLNH1ScGwneOPNfZxa2I56Oqrm0LlHXKiEhCac5wfDHQ6JY1egPG47zjNAaUcOk5jBCW1ho+Sjv8mxOGZ2XIVhCLeBLJ2lAZfGWDDMEs+2rThPTvz4y+VFHTNxXanBBDXYt3i3lbf5o+9R/yJNcX9ySrUAjaSI9Svx1XPir+DCwttPCbZHFoy4dP4c2MdM+qXVEMCQyyNX98WYmEfrqifhUGROdYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RqCy+9CgC4HSE+19Ae4wed36fE1UIdTs7eDTokFy7Y=;
 b=Nt/VDaWIehf38EIv0rJfSqpxX4XT94QXFNU7mMPmShIuLeZ07hl8nRhL0AVWoKauzh/Y3c0ZpzhHIz/4/oos++4m2fBFIq7XqLP5mTyCkW98657KjGmXBgU2KFnR9mT9fuCKQmCOJMR9b6fAPx8giCOB6zB80NdQTrD0TxjZgsRDSMq+nJLXCj1AgquFNvlNnBw+rmw4PW5ColKX1tzVm/Mu4y9TuzWP152Yw4vmYd1D3xocTX8uzFfV2wKI/JylGQIWbeuD4itINjVku9296kCZ2Iwac/JSM5lVPlt1Tl1A90V0ECZUFuFt05ehmuUVhqMrgk4IZvlgQcbiuoKN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB8174.namprd11.prod.outlook.com (2603:10b6:208:450::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 05:44:49 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 05:44:49 +0000
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
Thread-Index: AQHaafrWsToC+V6/rUqIu+gBPSMIMLE9risAgADXRYA=
Date: Tue, 19 Mar 2024 05:44:48 +0000
Message-ID: <SJ0PR11MB67448B4FB9B8E10A2F0DCEB6922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-6-zhenzhong.duan@intel.com>
 <49c49a2e-859e-45bb-b281-0ed9c72ecf9c@redhat.com>
In-Reply-To: <49c49a2e-859e-45bb-b281-0ed9c72ecf9c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB8174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJt8N61J76kVTJ97cKbc9O5M0bqpbKnTuDn7FkYgSfzXWj/ZmL+5JV+hRcpt4ob/R4zhfx9oTrwQTtgE8m+bg0wo1U55b39G78GkwUyimVrxmSxi/tk082SjzSCRDK8lH1iLHHySLgCbd2hyjBORCGNbhKpCV8PhWjib2Z0sv9i4INIpxRn90keLXF1rKaE0Tu+w3Hsu6PE6IpXa2BKBS09AabeRCZrHhNE9wQ1Rud8k8PeRs51xssRemxdz8ZegzTTMU8EA1iiEOO1N8bi7+Q4H8hlRQx3srhqu3wxZ3NRSz+HARRIgJw9SSL/I2NkCXBKhJQAA3Jr6efYBR6CDHd2w+oe3MrdYBAgbAb0y2+h4CxIG8xsxl3rCXlTyALV2Z3yCzJSQyn7RtKjVS2WBTXEeckjvcZG9jReTA5lTg8Xuvpmw3bpdi54CEi0co8cNPyOxThGqamfygGUyWreGkMftXTZOJ78ks+aEqQzSTmgeZ/FIgOtbct93HruXYBkhJfXm31a5NaEHebPPYS3SXgO2DGHkKqQ8+GCWMAFIjOYDI7YZ7Jr1jSS2nbCXueAqMV3Iwl9j0BtgPS/mpg/uCeC9QgLCrAyr3NNRRhi4iDLFmzr+06IJj4lE1BBvZCtH8bpyv7czVpvfGkp/SriLK8rGecf9MHRHRd7YLO5b7hY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm8xMmZmVTFxczcwTXN3b21ndnhPdWNCVitBTTZwUDZLaDFUKzRteGxiZSt4?=
 =?utf-8?B?ZWxnTSszczNDR1ZSZUUyUWhraWlqZ1dKb0xnNy82UW9sN1BHNGJCOFpYOUxU?=
 =?utf-8?B?Vnp4amlKSG9oSWQzQ2htUFVSSjRDVk9kWG1XdSs0RFFlZW9QU1hnSUZFeVR6?=
 =?utf-8?B?NjZHWjBYTVJZUTVrVWVhOTZ1K0lIY3grWElIbHA0Zm5PeDNrQWFYSko0c0No?=
 =?utf-8?B?TEtOc0xTRWU1c3M3K3ZCbU03L05oaDNuOWRGT0p1SzAxOTVZT1VuMlpreDBq?=
 =?utf-8?B?S2FxOHZ3cTR6SUhYeGlCZGE5RVA5a0RiVkorRGtYUDk5WFBFUUFsSWNLZDV4?=
 =?utf-8?B?dmRmSFhFZGpkYVg5TUNNSTdOM29yMVBTRlBqQm1RcmJFVFF4Z2Fvb3dwR254?=
 =?utf-8?B?OUVjY1liNnBsc2JOZWNkajlEMHk4dmdXN1RKb1J4RmtwQWlBNElnTEhDbEVm?=
 =?utf-8?B?b3hjaTdSTm5SUXBJUkZDVC90NE1Yc2FZVWVxZlB5Q3FRN0ZKTHRDVlVzR2Fm?=
 =?utf-8?B?bWFIRmJaTklvSWw1VmZ4czRSQmhkL25xMHBYYmt1SVJpQ1JHUmZzZkVrQnpi?=
 =?utf-8?B?clpHR3VRMkh0MU1udzU3UmFXT0trTFJJbU5sdTdhakZVbThsOUVZRkpadnZJ?=
 =?utf-8?B?Qzl4akFyRWg3S0VNNy9nc2RSWDQ3NzJYdzVzUW1oZG4xaWhQYktPSzd2cSto?=
 =?utf-8?B?UjNIYnZEVFlUNm0zZktaQ0RmYTdXTm95WU9vZWkyYUJzeldqeW9JY2pEcnI2?=
 =?utf-8?B?REg4MGprZm1tbjQra3MrV2dpNWpsS2xoT0FXdnU2eXdiLzNDTGVmQUJsZ3R5?=
 =?utf-8?B?Vnd3dnp5dGk4WEk5SW9FVjdNelBOYlg3dE52bzdybWovOUQxNk9aSGVUTUVH?=
 =?utf-8?B?MFd0R2htNGhnR243eEpnaXNJdjJ2Yys0N1BDell6NEFsbWQyVE80cnc3V0FN?=
 =?utf-8?B?NmNIdXFOOWQ3VFV4OWw2aEJHZ2cvZjM5UzZqTC9iZFlNTk8zcUZCeStFdU1H?=
 =?utf-8?B?dkF1bG5TUzlxQWR3N2c4QVFPSC9KTGczTmY1MDdsMXhnRzBReVdnTzFLL3Mr?=
 =?utf-8?B?TDJrdHd2cUIrS3laNlRBRlU3aW5tUDZCQS9jazdjYlJmSjZGTWhmRmp0MHNs?=
 =?utf-8?B?dzczTnVaSjhvcHVNVStCY3ZWMU52SWZNLzgyQTM0d3diS3VVUHRUeGVFcElp?=
 =?utf-8?B?TXdpVnI0WGM2R2NzUTgvak9OczN1Sk1KOTZIMytUekh5ZEVQR1FDYU82NGV5?=
 =?utf-8?B?b214TlFtRERpVkNKUmdBdi96QUQrNU83OTNjMnM4dzJiWXhGd0xHUFYvZHNF?=
 =?utf-8?B?RXAza05qdmNmQzhYanlCN2NwcmNCV25GMjRNTjhKTGRSY0gyU2c2eW5EL2FK?=
 =?utf-8?B?MmQvVnFsU3FpNmt3UVF6Z3VnWXRXUEFGamV3NkQzZ0ZXb0FpQ2I3Nm4weVN1?=
 =?utf-8?B?UHJWUklPUTRWOHZLOGFjSEN2SVVCUzhZTGgyZzZuQ3I5REo2YjJ3cHVYdlJi?=
 =?utf-8?B?U0x0RGk4bkFkeEkvbHFJYWlZQ3UwZ1Z6R0I3RnB2V2NRcGt3ajJ0UnJGcFlO?=
 =?utf-8?B?TnhmRGZkWFMreE40VExSeWRmVXNYbjl5MFdaaCtPVVR3bkUzOHBMOCtyMjNN?=
 =?utf-8?B?TzhWK2lFYlFDK2tneGlueTBpMFFCUUZmdHJLVk9RcUdsWHFwZ0NmVWpqSlhh?=
 =?utf-8?B?TExET05WMWdPd2U2bytZRjFiOWg3c01GUlNxdUc1MFU3WUFUWERTeU42eS9s?=
 =?utf-8?B?UG1KaHYzUktKRlAydy84bk5ud3dZaDZ0ZVpLZmEyclIrK2tCMjVwZXAxeWlO?=
 =?utf-8?B?dWI5bjd3SUxoZWNFMjFLTmpQVHkvNVJ5Q0Z0a3Y3MGlBOHNpdEZWSjd5UDJF?=
 =?utf-8?B?SVJkR0kvOHQrMnN5azRUNmxUUEZBY2labWtMZ1k1QTlDaGo2L0tQUjgydGU0?=
 =?utf-8?B?VzQvWmpiZVZKcHQzZjlpS016QlB5MHFpNjZSeDczWGs0dWllTURpc3Bmb0dV?=
 =?utf-8?B?Tloxak9Yc3F5VFJJWWx4U1pLdmhYaHlKN2twSGtFRkFURUczZW9ZU3ByNVlQ?=
 =?utf-8?B?ZlhXMzFKRGN4WTcvcys5UXNHK3BvT0laSUNoNk5OdDFkWGJiU29nWXZRSmJM?=
 =?utf-8?Q?zzO5fYyRGWZS+zAjY/d96Al8a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877dc548-edab-4ec9-442a-08dc47d7b0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 05:44:48.9647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIY3PS7+T2Zn2Ib+vQYniOxYsLh5bTCaU4/MO4ju26t58Ea5Vovp+q4p3klB0GRgd3FF8vleJZFBVs0t3DINFVIErRoeEF9+ozYBXHp5PJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8174
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
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
biAyLzI4LzI0IDA0OjU4LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEludHJvZHVjZSBob3N0
X2lvbW11X2RldmljZV9jcmVhdGUgY2FsbGJhY2sgYW5kIGEgd3JhcHBlciBmb3IgaXQuDQo+Pg0K
Pj4gVGhpcyBjYWxsYmFjayBpcyB1c2VkIHRvIGFsbG9jYXRlIGEgaG9zdCBpb21tdSBkZXZpY2Ug
aW5zdGFuY2UgYW5kDQo+PiBpbml0aWFsaXplIGl0IGJhc2VkIG9uIHR5cGUuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+
IC0tLQ0KPj4gIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oICAgICAgICAgfCAxICsNCj4+
ICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIHwgMSArDQo+PiAgaHcvdmZp
by9jb21tb24uYyAgICAgICAgICAgICAgICAgICAgICB8IDggKysrKysrKysNCj4+ICAzIGZpbGVz
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9o
dy92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj5jb21tb24uaA0K
Pj4gaW5kZXggYjY2NzZjOWY3OS4uOWZlZmVhNGI4OSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUv
aHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21t
b24uaA0KPj4gQEAgLTIwOCw2ICsyMDgsNyBAQCBzdHJ1Y3QgdmZpb19kZXZpY2VfaW5mbyAqdmZp
b19nZXRfZGV2aWNlX2luZm8oaW50DQo+ZmQpOw0KPj4gIGludCB2ZmlvX2F0dGFjaF9kZXZpY2Uo
Y2hhciAqbmFtZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICBBZGRyZXNzU3BhY2UgKmFzLCBFcnJvciAqKmVycnApOw0KPj4gIHZvaWQgdmZpb19kZXRh
Y2hfZGV2aWNlKFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+ICt2b2lkIGhvc3RfaW9tbXVfZGV2
aWNlX2NyZWF0ZShWRklPRGV2aWNlICp2YmFzZWRldik7DQo+Pg0KPj4gIGludCB2ZmlvX2t2bV9k
ZXZpY2VfYWRkX2ZkKGludCBmZCwgRXJyb3IgKiplcnJwKTsNCj4+ICBpbnQgdmZpb19rdm1fZGV2
aWNlX2RlbF9mZChpbnQgZmQsIEVycm9yICoqZXJycCk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0K
PmNvbnRhaW5lci1iYXNlLmgNCj4+IGluZGV4IGIyODEzYjBjMTEuLmRjMDAzZjZlYjIgMTAwNjQ0
DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+PiArKysg
Yi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+PiBAQCAtMTIwLDYgKzEy
MCw3IEBAIHN0cnVjdCBWRklPSU9NTVVDbGFzcyB7DQo+PiAgICAgIGludCAoKmF0dGFjaF9kZXZp
Y2UpKGNvbnN0IGNoYXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICBBZGRyZXNzU3BhY2UgKmFzLCBFcnJvciAqKmVycnApOw0KPj4gICAg
ICB2b2lkICgqZGV0YWNoX2RldmljZSkoVkZJT0RldmljZSAqdmJhc2VkZXYpOw0KPj4gKyAgICB2
b2lkICgqaG9zdF9pb21tdV9kZXZpY2VfY3JlYXRlKShWRklPRGV2aWNlICp2YmFzZWRldik7DQo+
TWF5YmUgcmV0dXJuIGFuIGludCBpbnN0ZWFkLiBJdCBpcyBjb21tb24gdGhlIGFsbG9jYXRpb24g
Y2FuIGZhaWwgYW5kDQo+dGhlIGRlYWxsb2NhdGlvbiBjYW5ub3QuIFdoaWxlIGF0IGl0IEkgd291
bGQgYWxzbyBwYXNzIGFuIGVycnAgaW4gY2FzZQ0KPml0IGZhaWxzDQoNCkN1cnJlbnRseSBob3N0
X2lvbW11X2RldmljZV9jcmVhdGUgaW1wbGVtZW50YXRpb24gb25seSBjYWxscyBnX21hbGxvYzAs
DQpzbyBuZXZlciBmYWlscywgc28gSSByZXR1cm5lZCB2b2lkLg0KDQpJJ20gZmluZSB0byByZXR1
cm4gYW4gaW50LCB3aWxsIGJlIGxpa2UgYmVsb3csIHRha2UgaW9tbXVmZCBmb3IgZXhhbXBsZToN
Cg0KLS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQpAQCAt
NjUxLDcgKzY1MSw3IEBAIHN0YXRpYyBJT01NVUZERGV2aWNlT3BzIHZmaW9faW9tbXVmZF9kZXZp
Y2Vfb3BzID0gew0KICAgICAuZGV0YWNoX2h3cHQgPSB2ZmlvX2lvbW11ZmRfZGV2aWNlX2RldGFj
aF9od3B0LA0KIH07DQoNCi1zdGF0aWMgdm9pZCB2ZmlvX2NkZXZfaG9zdF9pb21tdV9kZXZpY2Vf
Y3JlYXRlKFZGSU9EZXZpY2UgKnZiYXNlZGV2KQ0KK3N0YXRpYyBpbnQgdmZpb19jZGV2X2hvc3Rf
aW9tbXVfZGV2aWNlX2NyZWF0ZShWRklPRGV2aWNlICp2YmFzZWRldiwgRXJyb3IgKiplcnJwKQ0K
IHsNCiAgICAgSU9NTVVGRERldmljZSAqaWRldiA9IGdfbWFsbG9jMChzaXplb2YoSU9NTVVGRERl
dmljZSkpOw0KICAgICBWRklPSU9NTVVGRENvbnRhaW5lciAqY29udGFpbmVyID0gY29udGFpbmVy
X29mKHZiYXNlZGV2LT5iY29udGFpbmVyLA0KQEAgLTY2MSw2ICs2NjEsOCBAQCBzdGF0aWMgdm9p
ZCB2ZmlvX2NkZXZfaG9zdF9pb21tdV9kZXZpY2VfY3JlYXRlKFZGSU9EZXZpY2UgKnZiYXNlZGV2
KQ0KDQogICAgIGlvbW11ZmRfZGV2aWNlX2luaXQoaWRldiwgdmJhc2VkZXYtPmlvbW11ZmQsIHZi
YXNlZGV2LT5kZXZpZCwNCiAgICAgICAgICAgICAgICAgICAgICAgICBjb250YWluZXItPmlvYXNf
aWQsIHZiYXNlZGV2LCAmdmZpb19pb21tdWZkX2RldmljZV9vcHMpOw0KKw0KKyAgICByZXR1cm4g
MDsNCiB9DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj5FcmljDQo+PiAgICAgIC8qIG1pZ3Jh
dGlvbiBmZWF0dXJlICovDQo+PiAgICAgIGludCAoKnNldF9kaXJ0eV9wYWdlX3RyYWNraW5nKShj
b25zdCBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGJvb2wgc3RhcnQpOw0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8v
Y29tbW9uLmMgYi9ody92ZmlvL2NvbW1vbi5jDQo+PiBpbmRleCAwNTliZmRjMDdhLi40MWU5MDMx
YzU5IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9jb21tb24uYw0KPj4gKysrIGIvaHcvdmZpby9j
b21tb24uYw0KPj4gQEAgLTE1MjEsMyArMTUyMSwxMSBAQCB2b2lkIHZmaW9fZGV0YWNoX2Rldmlj
ZShWRklPRGV2aWNlDQo+KnZiYXNlZGV2KQ0KPj4gICAgICB9DQo+PiAgICAgIHZiYXNlZGV2LT5i
Y29udGFpbmVyLT5vcHMtPmRldGFjaF9kZXZpY2UodmJhc2VkZXYpOw0KPj4gIH0NCj4+ICsNCj4+
ICt2b2lkIGhvc3RfaW9tbXVfZGV2aWNlX2NyZWF0ZShWRklPRGV2aWNlICp2YmFzZWRldikNCj4+
ICt7DQo+PiArICAgIGNvbnN0IFZGSU9JT01NVUNsYXNzICpvcHMgPSB2YmFzZWRldi0+YmNvbnRh
aW5lci0+b3BzOw0KPj4gKw0KPj4gKyAgICBhc3NlcnQob3BzLT5ob3N0X2lvbW11X2RldmljZV9j
cmVhdGUpOw0KPj4gKyAgICBvcHMtPmhvc3RfaW9tbXVfZGV2aWNlX2NyZWF0ZSh2YmFzZWRldik7
DQo+PiArfQ0KDQo=

