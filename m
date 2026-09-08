Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752C0C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3oTr-0004vz-Py; Tue, 08 Sep 2026 01:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x3oTq-0004vq-Bk
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 01:34:50 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x3oTn-0005Ly-Nx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 01:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788845688; x=1820381688;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eAc6tt3O2WrjCvmb0TfCHBMagQeFP4mJ8S8UH+J4SaQ=;
 b=cwbnkC73/Ec0lonfmy+X4FeWBFzE1TXoJZ+WPsQ7KDHbAt6PugLV/3Dh
 laBMJb6nAkhH6Nx2wnO6DqBzZK020Q7Ja0OgLh98i6ee+CDJO9yvn77hM
 UFqn1E2bcvlljuo2N9NcABXfh4CfrN/92r1u8yidJNtZr0H71DOQYEX7o
 QR4MTZNOIuwit0BVOD1mQ0grw62QA5TjixGVSzVhxuohvfTMUbyNRkbYa
 FsqTygJJDEl24dSjoM7wV3dcTRwR/KhqD64YZtBVDjgGH+Lmftdo/Q6hD
 7hxDgMhLiNKRPIcAvCfWoNR2szDdOK2yz480+np5NwuKBTa9yZXZbbKHT g==;
X-CSE-ConnectionGUID: FU1oK/3SR8q4tUfhOQHOvw==
X-CSE-MsgGUID: 1jf+SsdURTSCSBCeSVqROA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="76797734"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="76797734"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 22:34:44 -0700
X-CSE-ConnectionGUID: yJxMyHAhS4OrCaTNjbzeXA==
X-CSE-MsgGUID: 40+w0zsiS7Sphd4xc6pAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="274400470"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 22:34:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 22:34:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 22:34:43 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.23)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 22:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msD6RmaKK5CC5t/K4fMuS7cAZY65+5MsICH8/mrTgyRbuL+3dh324ruaZJLwgVjTaz3AdSLgE83+MSJ6iYwrykbZua8l3QzJT59xEuWDAMgWvBahg+0wH82UTNH1pWE0fkXEjgiEcbTdUxalSnC9bBgbcXaLcemx+wPUA7F3vbjV/yBn0dC/0dTa+wmI55rO+q2N2CZ0P5LIo7kFpR2OPUWTRY4rHK4MsnjN09Bas8mbywbYK8A4wdTFN97zFrsjmhZRq4tBSW9bJwwvRXePH+UQxSQT841/MYkdWlYWzDi+945E7thUt8vc/NTIn4uGQQNLl0zBFLoQ6No33OjU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAc6tt3O2WrjCvmb0TfCHBMagQeFP4mJ8S8UH+J4SaQ=;
 b=EhafsRCQajB8eBuneXT8hgt0+/LMzo8pLNbDx+sSF7owBPrtYGUe3Ib7bP2z6stET7ONJtHhZ/lhaQDPTaavzk732gyQH2PWcBaseEA7nM8jdQd0zJKMyb8cet4uSiEC8/a1cy+OOssFcIaLy9HP1mOfNyPbPffhfvMDHUYFHciaiQp5iXMyERGSjPDiBBR7kp//vvpjw5GpRhiZFb/eKaTljKLyRkqM+4e8mxBNDw/FS8gtv2OU1WTYoUoW0f+Npn8uf9pzU/mfdPxjNsTZy7MvxEP+3l5gRn6wLFe1hRonoCQQnpjAaoobobsr1YdskETp1xOsmcmn0KHQlcsmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by SJ0PR11MB5069.namprd11.prod.outlook.com
 (2603:10b6:a03:2ad::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 05:34:41 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::aaad:f003:86ec:c119]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::aaad:f003:86ec:c119%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 05:34:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v5 4/6] intel_iommu_accel: Add PRQ injection for
 passthrough device
Thread-Topic: [PATCH v5 4/6] intel_iommu_accel: Add PRQ injection for
 passthrough device
Thread-Index: AQHdOS53NlqD69DYME6t3kTCSVsq0ba7RXuAgAGZNACAB1NggA==
Date: Tue, 8 Sep 2026 05:34:40 +0000
Message-ID: <DS4PPF93A1BBECDA8B6ADB46A8FF6C26B0C92B12@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20260831095200.1279366-1-zhenzhong.duan@intel.com>
 <20260831095200.1279366-5-zhenzhong.duan@intel.com>
 <26c49670-0918-45e1-b07e-199362081714@intel.com>
 <7dada8d178b116879513323cc9c853d4058a3160.camel@bull.com>
In-Reply-To: <7dada8d178b116879513323cc9c853d4058a3160.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|SJ0PR11MB5069:EE_
x-ms-office365-filtering-correlation-id: fd3cdb47-a154-4e22-b621-08df0d6ae150
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|38070700021|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: TqFCNkFqfA1Ex3wSzqWgSeFXUfZ5X4mLSbicvLiG/dmNxm+hwCTfLcJERvJ/DGl6ZLmpBIa7+XUBy5uEulSw/0npHw3nDL578YERMo1O6wp7upf7vgR2f2cXF/0OsKYwGZa8BSc+B1Q4MQ04jQhGp0iSMZoa2v86Nm/rYYALp/neFMYnnlMHdAnYx4PGWvDFx0+4AS9f+UibAtmF8mjRQH3IT4Ts8a7DBEgExS0IWvyiiCU0sA9/3GGCqeXt+JJlwsq38xqkdcoFszCtD2Y7XxDHTZzMd61ZYcGFilNK/arec4Mpv6SWDk+thgS1o9d62PgiPuOtDviTmVsUjsTFBjJMsevNmCEfInRbV2BjZrCoNArloL3I4Kx4uYux2INDwAe82pDdMHA46cKvHlwAWXwCE3d11oHbtd/XU4MeNn4ppyB8aXyYUXvFrwXY2+CGDc7rUmcMi5z+bizzUAEn1Kl5E7txehdVvFrPRr51r2J1N7y45e/FABpV1t1QyKuSGRUCIHZGlmLhFGBM3jVvJI+PJ4uHW+3i8qjmkNL6GSRqTLwzI+H10fERiMN4DayAyERJkyNnNblTMWzdMhQ/0ShyZ2ATQg65bRzlI86zvHA0x3JVvLYYhuzRq+nuMh/faakNROugikcLjxa1qaNTRgs354FL5jOM7QyrtAoBc/m3TAk400X+grynRTVscsvIxnTD4SId+ZrZpnXyvkClO2MPNqAjmfN2iwuBtjJAvE8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(38070700021)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFV3akhGVnNpRDAxWHQzbHRZcDRhVmVUbGxoQmxuNExxcGhtRmRTNFVRQ1Bq?=
 =?utf-8?B?N0xFbVYxbVNRT3Z4b0lWWGpGMGppMXdwL0Q3NDd1aDk3K2NFRjFDMzB6eUY2?=
 =?utf-8?B?cjNiOXF2VytZcXlxMVgyL1Zac3cxYld6NnRONmMybUdEVEFaWXB3c3B5ZjJ5?=
 =?utf-8?B?blZ6Y0NVQ2FIdGNXRHk4R2EwZCs0QmlrTzc3Z0xxUTMrL0xndm14dCtsZ3Zv?=
 =?utf-8?B?YjNaZXRHNENsOEJBdDZONkFsNGpycUNsenpHT2dSR3c3aVJpbGdneHZJaTdo?=
 =?utf-8?B?dzBuWDBwMWJFKzdTUEgrVmpUcXdRRUM0TlZWUjR4ckowNUxUelIrWHNpZ3J0?=
 =?utf-8?B?VWcyTG4xRkJ4S3lNOUQ4cXJXdW16UCtIMjJ2L3NlMjQ1ZHg2SnRmUXdBb0Iy?=
 =?utf-8?B?WGNwUjd1NUF2ay9URUFGT0dBaC9jbU5Sbk02TURBcFFSWFNFalZROVoySXNn?=
 =?utf-8?B?M295ZkYvOHh2aXNUVlV4NmkxUWtaMXN1YjNLc01OK3liN3NIcERwSmhmS21Q?=
 =?utf-8?B?akl3SmlJeE56VkdieFE1RW1JTEkxRkJHRnRlSG9MMkczazBXR1A4OEhUUEJw?=
 =?utf-8?B?R2Zwd2RwRVluR3ZIc1ZKRStLejZCZFhBZnFFRG4zeUprL29meitZeUVKQXQw?=
 =?utf-8?B?MWVjczh0ZVBRbjJiTHpvY0hCbmkzUW9uNXhwWnNxQnBrZVRuMmxNSHlIeVFR?=
 =?utf-8?B?VC9USUZoWGxzZldlMG9aaTQ5d0R5ZnlhM1F0WE1LUDllNEhneFBEZWE0R25D?=
 =?utf-8?B?VVVmSjNReWt1bjMvS3NiUTFVTFdpc3NiK1REQlkydDFrWG1QYTRKS2FjbWcr?=
 =?utf-8?B?NG1hQVV3ZDBPcEVLS1pLck9ERGZiNHZLczF6aE15KytsNUthOHZ4bnZvK3JT?=
 =?utf-8?B?SUZwVjB6cit2UnBVaVhhUmxpR0lpcjJvZE5LQ2ZrMnM1Y1lrclF0ZE8reGUz?=
 =?utf-8?B?Y3RNRW1MWGpnWUhpQzNGS09XMnM5eWI4Uy81NDdzei9HbTdxRjhrRnhpSCtU?=
 =?utf-8?B?ZzZkVTJ0cUlLMGpDTnMxanFxY044cC8vZXQ0ZnN4R29NYm5ETnZ1L1ZvVW9D?=
 =?utf-8?B?eWJESVR4dUpTZndBWFZ0QjZkT3R6OWtBcFhoMzlkWWxSUVdIc1JOV1I1a1FJ?=
 =?utf-8?B?bTNtUkU1SnB0eGtHZ3huMVJVY1NOMzY1S29qdTZrS0ExZmRrNHlEOGlzcHd6?=
 =?utf-8?B?cGR4enBsV3ZWN2J5cnBxRWdkcm5vMi9uYWt1OHk5S2I2Wm5sNkZETXYzZDls?=
 =?utf-8?B?bXpEYndKRXFOaUNkNUNzM05UZHN3SUd2akNHTERCWWNaUi9PQy9lVXBUUjRs?=
 =?utf-8?B?ZlM2OVJ2TUVIUzM3Unl1TFltNlFOUWNMb3ZVQ2xiS1pYMTZtWVBqWDhsSWpt?=
 =?utf-8?B?c29PbUtzMVRZYlo5c2JCWElVdE5BT0tIcWFzOXF4SlR2eTBTNDBIQXN2dVFp?=
 =?utf-8?B?UFRMQ2hTbW5tQXVnSmxHY2QyNFhYbCtkaEJ2Lzl4SmdZWnF1YWROSFFtZjU1?=
 =?utf-8?B?cE1zV2h2WFZXWG5LMThnNngrL1cwU0s0TWNkV0RVc0JZaHZZU2ROYkwrYXQ0?=
 =?utf-8?B?MkxRQjZ0dXFSWUhzemJUWEtTZFl5eXp5c0RqZHZkbGJXMjIwU0FIeXE0Qk4v?=
 =?utf-8?B?N216YjQ2S3hhTHdZVGhDL2NVTVJkdmdveHF2QXh5TE9UVWxJb0htTEMwTlQ2?=
 =?utf-8?B?QXB1cU5jU2k3VnVIYS81OFJMbjZTSFNxL3FIL2lMK1hUTytBcWZjTWVPME1Z?=
 =?utf-8?B?TmtvOExSbGlvMmlDQnRMb3A5S0RFc21GTkVpaXNOZ1AwSUNGZDRHTEpXZXg1?=
 =?utf-8?B?ZDRJTUdPek1mSzRKU2VZSEkwWFMwanh3Mmt1R3oxYzkzUkFOOE5HYlpRb3Rz?=
 =?utf-8?B?SDlLcVhqK0VNY1BmNnhHWStqcGZCRDZaZm9XVTNyZGtVVDVSTzFuTFRzNlJX?=
 =?utf-8?B?b0l3RmE5cnpXQkZ2WXhMWHplamRyaG9PTE4yRHUxVjdUc0RISE9EQTFVZG9v?=
 =?utf-8?B?TmpZWGZWMFc4ZW9ZZFRpQ1hPS2Foems3am5HZlprdnhTM210MVFianA3M3M3?=
 =?utf-8?B?REdSZHBHdjUrUlpyQ2VZVHVaTGZMa2hjWVZ3TzM2MWhMNkxBU2NMTnBTdUFP?=
 =?utf-8?B?ZllaMkJlVWQxazh0cU5LcGQ0d0VJaThVMVNxbktUbk41VlcyWFNwTUhDZ0NQ?=
 =?utf-8?B?K3hET0h6OXVqaEF1eWZOOTZJRytxY0Q0SDl6d01IM0Q5dlIzQzExRi95OVFh?=
 =?utf-8?B?SHFZL2xjbmVBOFhxVmZUN0cyNko2YlJVd0QrK3lwK0Zrd0xUaTlCR0FWbWIz?=
 =?utf-8?B?WWNKaVliYXBMbUs3VVBMSExPb3RZdnljWm9md1ptVlprN1ozMXB6Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HZXlXVE3N+gAGjc+A9Kz/+sRiqwS7F9JYf1m6edFl4dofCNskA/eYagkQxpfv3/CNbgZo4oIhogtZOlvQGrhcpixWrJ9SN100NFDYCV3IyyIAaK3pqOswUZNFrTjSdPmxUAc5sgPXfQ8g3ETG7UaJgtObBD+ogstxji3Q3h4QCixNk0aCUyBAjwPQtnW3MatDrbnEkRPDcwpaLFHWy9WUaAw0MDpnJ8426gWfdDoT+cqgYbLEKx5OV7U5fBGEVRMlMw2iewjU/JBm4O7xvX5azmx3UeDZ4Y79bOLkdZkfflOgF+d39ZanF9pMbZroyDEl7IwZy52Px5D7eNie/zdug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3cdb47-a154-4e22-b621-08df0d6ae150
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 05:34:40.7727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IQY4Dj/cIv6SVt8Yi/kZqqBtiwWspYoyXqdQWts6X7g/ruLsffELjHWtK35FolTOTifUS0taDzp6HeWo6JlZhxPfJ75BD8FPWcFuC0CTgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5069
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsw6ltZW50IE1BVEhJRVUt
LURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHY1IDQvNl0gaW50ZWxfaW9tbXVfYWNjZWw6IEFkZCBQUlEgaW5qZWN0aW9uIGZvciBwYXNz
dGhyb3VnaA0KPmRldmljZQ0KPg0KPg0KPk9uIFdlZCwgMjAyNi0wOS0wMiBhdCAyMTowNiArMDgw
MCwgWWkgTGl1IHdyb3RlOg0KPj4gT24gOC8zMS8yNiAxNzo1MSwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+Pg0KPj4gPiBXaGVuIHRoZSBndWVzdCBlbmFibGVzIHRoZSBQUlEgaW4gdklPTU1VLCBh
bGxvY2F0ZSBhIEZBVUxUUSBvYmplY3Qgc28gdGhhdA0KPj4gPiBob3N0LXNpZGUgcmVjb3ZlcmFi
bGUgZmF1bHQgZXZlbnRzIGNhbiBiZSByZWNlaXZlZCBhbmQgcHJvcGFnYXRlZCBiYWNrIHRvDQo+
PiA+IHRoZSBndWVzdC4NCj4+DQo+Pg0KPj4gSSB0aG91Z2h0IEZBVUxUUSBvYmplY3QgaXMgYWxs
b2NhdGVkIGF0IHRoZSB0aW1lIHdoZW4gUFJFIGJpdCBpcyBzZXQuIDopDQo+PiBIb3cgYWJvdXQg
YmVsb3c/DQo+Pg0KPj4gV2hlbiBQUlEgaXMgZW5hYmxlZCBpbiBndWVzdCwgdklPTU1VIHNpZGUg
YWxsb2NhdGVzIEZBVUxUUSBvYmplY3QgZm9yDQo+PiBlYWNoIHMxX2h3cHQsIHNvIHRoYXQgaG9z
dC1zaWRlIHJlY292ZXJhYmxlIGZhdWx0IGV2ZW50cyBjYW4gYmUgcmVjZWl2ZWQNCj4+IGFuZCBw
cm9wYWdhdGVkIHRvIGd1ZXN0Lg0KPj4NCj4+DQo+PiA+IEluc3RhbGwgYW4gZXZlbnQgaGFuZGxl
ciBvbiB0aGUgRkFVTFRRIGZkIHRvIHJlYWQgYW5kIHByb3BhZ2F0ZSBob3N0DQo+PiA+IGdlbmVy
YXRlZCByZWNvdmVyYWJsZSBmYXVsdCBldmVudHMgdG8gdGhlIGd1ZXN0Lg0KPj4gPg0KPj4gPiBU
aGUgaGFuZGxlciBydW5zIGluIFFFTVUncyBtYWluIGxvb3AsIHVzaW5nIGEgbm9uLWJsb2NraW5n
IGZkIHJlZ2lzdGVyZWQNCj4+ID4gdmlhIHFlbXVfc2V0X2ZkX2hhbmRsZXIoKS4NCj4+ID4NCj4+
ID4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4NCj48W3poZW56aG9uZy5kdWFuQGludGVs
LmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSk+DQo+PiA+IFRlc3RlZC1ieTog
WHVkb25nIEhhbw0KPjxbeHVkb25nLmhhb0BpbnRlbC5jb21dKG1haWx0bzp4dWRvbmcuaGFvQGlu
dGVsLmNvbSk+DQo+PiA+IC0tLQ0KPj4gPiDCoCBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmjC
oMKgwqAgfMKgwqAgMiArDQo+PiA+IMKgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8
wqDCoCAzICsNCj4+ID4gwqAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDkgKy0NCj4+ID4gwqAgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jwqDCoMKgIHwg
MTYwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+LQ0KPj4gPiDCoCBody9pMzg2
L3RyYWNlLWV2ZW50c8KgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4gPiDCoCA1IGZp
bGVzIGNoYW5nZWQsIDE2NCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4+ID4NCj4+
ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaCBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfYWNjZWwuaA0KPj4gPiBpbmRleCA0NmMxYTI5NDA5Li5lMDMxOTc0OWE1IDEwMDY0
NA0KPj4gPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+ID4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oDQo+PiA+IEBAIC0xOCw2ICsxOCw4IEBAIHR5cGVkZWYg
c3RydWN0IFZUREFjY2VsUEFTSURDYWNoZUVudHJ5IHsNCj4+ID4gwqDCoMKgwqDCoCBWVERQQVNJ
REVudHJ5IHBhc2lkX2VudHJ5Ow0KPj4gPiDCoMKgwqDCoMKgIHVpbnQzMl90IHBhc2lkOw0KPj4g
PiDCoMKgwqDCoMKgIHVpbnQzMl90IGZzX2h3cHRfaWQ7DQo+PiA+ICvCoMKgwqAgdWludDMyX3Qg
ZmF1bHRfaWQ7DQo+PiA+ICvCoMKgwqAgaW50IGZhdWx0X2ZkOw0KPj4gPiDCoMKgwqDCoMKgIFFM
SVNUX0VOVFJZKFZUREFjY2VsUEFTSURDYWNoZUVudHJ5KSBuZXh0Ow0KPj4gPiDCoCB9IFZUREFj
Y2VsUEFTSURDYWNoZUVudHJ5Ow0KPj4gPg0KPj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+
ID4gaW5kZXggOTI0ZTkxY2I4YS4uNWViYzIwNGU5YSAxMDA2NDQNCj4+ID4gLS0tIGEvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KPj4gPiBAQCAtNzg2LDQgKzc4Niw3IEBAIGludCB2dGRfZGV2X3RvX2NvbnRl
eHRfZW50cnkoSW50ZWxJT01NVVN0YXRlICpzLA0KPnVpbnQ4X3QgYnVzX251bSwNCj4+ID4gwqAg
VlREQWRkcmVzc1NwYWNlICp2dGRfZ2V0X2FzX2J5X3NpZChJbnRlbElPTU1VU3RhdGUgKnMsIHVp
bnQxNl90IHNpZCk7DQo+PiA+IMKgIGludCB2dGRfZGV2X2dldF9wZV9mcm9tX3Bhc2lkKEludGVs
SU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsIHVpbnQ4X3QNCj5kZXZmbiwNCj4+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dWludDMyX3QgcGFzaWQsIFZURFBBU0lERW50cnkgKnBlKTsNCj4+ID4gK2ludCB2dGRfcHJpX3Jl
cXVlc3RfcGFnZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4sIHVpbnQzMl90
DQo+cGFzaWQsDQo+PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwgaHdhZGRyIGFkZHIsIGJvb2wg
bHBpZywNCj4+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB1aW50MTZfdCBwcmdpLCBib29sIGlzX3JlYWQsIGJvb2wgaXNfd3JpdGUpOw0KPj4gPiDC
oCAjZW5kaWYNCj4+ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4gPiBpbmRleCA4MmMzYzNiMmMzLi5kY2YyMzkyNGVmIDEwMDY0
NA0KPj4gPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ID4gKysrIGIvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jDQo+PiA+IEBAIC01MzY5LDExICs1MzY5LDEwIEBAIHN0YXRpYyBpbnQNCj52
dGRfcHJpX3BlcmZvcm1faW1wbGljaXRfaW52YWxpZGF0aW9uKFZUREFkZHJlc3NTcGFjZSAqdnRk
X2FzLA0KPj4gPiDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+PiA+IMKgIH0NCj4+ID4NCj4+ID4g
LS8qIFBhZ2UgUmVxdWVzdCBEZXNjcmlwdG9yIDogNy40LjEuMSAqLw0KPj4gPiAtc3RhdGljIGlu
dCB2dGRfcHJpX3JlcXVlc3RfcGFnZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2
Zm4sDQo+PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBwYXNpZCwgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVj
X3JlcSwNCj4+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciBhZGRyLCBib29sIGxwaWcsIHVpbnQxNl90IHByZ2ks
DQo+PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBib29sIGlzX3JlYWQsIGJvb2wgaXNfd3JpdGUpDQo+PiA+ICsvKiBBY2Nl
cHQgdGhlIFBDSSBQQVNJRCBhcyBpbnB1dC4gUGFnZSBSZXF1ZXN0IERlc2NyaXB0b3IgOiA3LjQu
MS4xICovDQo+Pg0KPj4NCj4+IGNhbiB0aGlzICJBY2NlcHQgdGhlIFBDSSBQQVNJRCIgYmUgbW9y
ZSBhY2N1cmF0ZT8gQmVjYXVzZSBpdCBpcyBmYWNpbmcNCj4+IHRoZSBlbXVsYXRlZCBkZXZpY2Ug
bW9kZWxzLCBzbyB0aGlzIHNob3VsZCBiZSBQQ0kgUEFTSUQgaW5zdGVhZCBvZiB0aGUNCj4+IHBh
c2lkcyB1c2VkIHdpdGhpbiB2SU9NTVUuDQo+Pg0KPj4NCj4+ID4gK2ludCB2dGRfcHJpX3JlcXVl
c3RfcGFnZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4sIHVpbnQzMl90DQo+
cGFzaWQsDQo+PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwgaHdhZGRyIGFkZHIsIGJvb2wgbHBp
ZywNCj4+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1aW50MTZfdCBwcmdpLCBib29sIGlzX3JlYWQsIGJvb2wgaXNfd3JpdGUpDQo+PiA+IMKgIHsN
Cj4+ID4gwqDCoMKgwqDCoCBJbnRlbElPTU1VU3RhdGUgKnMgPSBvcGFxdWU7DQo+PiA+IMKgwqDC
oMKgwqAgVlREQWRkcmVzc1NwYWNlICp2dGRfYXM7DQo+PiA+IGRpZmYgLS1naXQgYS9ody9pMzg2
L2ludGVsX2lvbW11X2FjY2VsLmMgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+ID4g
aW5kZXggZDJmNDFmMThmMS4uMzgwODExMmY3OSAxMDA2NDQNCj4+ID4gLS0tIGEvaHcvaTM4Ni9p
bnRlbF9pb21tdV9hY2NlbC5jDQo+PiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwu
Yw0KPj4gPiBAQCAtOSw2ICs5LDcgQEANCj4+ID4gwqDCoCAqLw0KPj4gPg0KPj4gPiDCoCAjaW5j
bHVkZSAicWVtdS9vc2RlcC5oIg0KPj4gPiArI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0Lmgi
DQo+PiA+IMKgICNpbmNsdWRlICJzeXN0ZW0vaW9tbXVmZC5oIg0KPj4gPiDCoCAjaW5jbHVkZSAi
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaCINCj4+ID4gwqAgI2luY2x1ZGUgImludGVsX2lvbW11X2Fj
Y2VsLmgiDQo+PiA+IEBAIC03NywxNCArNzgsMTUwIEBAIFZUREhvc3RJT01NVURldmljZQ0KPip2
dGRfZmluZF9oaW9kX2lvbW11ZmQoVlREQWRkcmVzc1NwYWNlICphcykNCj4+ID4gwqDCoMKgwqDC
oCByZXR1cm4gTlVMTDsNCj4+ID4gwqAgfQ0KPj4gPg0KPj4gPiAtc3RhdGljIGJvb2wgdnRkX2Ny
ZWF0ZV9mc19od3B0KFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsDQo+PiA+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVlRE
UEFTSURFbnRyeSAqcGUsIHVpbnQzMl90ICpmc19od3B0X2lkLA0KPj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVycm9yICoq
ZXJycCkNCj4+ID4gK3N0YXRpYyB2b2lkIHZ0ZF9wcnFfcmVwb3J0X2ZhdWx0KFZUREFjY2VsUEFT
SURDYWNoZUVudHJ5ICp2dGRfcGNlLA0KPj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW9tbXVfaHdwdF9w
Z2ZhdWx0ICpmYXVsdCwgdW5zaWduZWQgY250KQ0KPj4NCj4+DQo+PiB2dGRfcHJxX3JlcG9ydF9m
YXVsdCBpcyBhIGJpdCBjb25mdXNpbmcuIHNlZW1zIGxpa2UgcmVwb3J0aW5nIGEgZmF1bHQgb2YN
Cj4+IFBSUS4gaG93IGFib3V0IG5hbWluZyB2dGRfcmVjb3ZlcmFibGVfZmF1bHRfcmVwb3J0PyBv
ciBhbnkgb3RoZXIgbmFtZT8NCj4+DQo+DQo+V2UgbmFtZWQgaXQgInByb3BhZ2F0ZSIgb24gdGhl
IHJlc3BvbnNlIHBhdGggKFs1LzZdKS4NCj5NYXliZSB1c2UgdGhlIHNhbWUgcGF0dGVybj8NCg0K
T0ssIEkgY2FuIGNvbWJpbmUgeW91ciBzdWdnZXN0aW9uIHdpdGggWWkncywgc28gdXNlIHZ0ZF9w
cm9wYWdhdGVfcmVjb3ZlcmFibGVfZmF1bHQoKSBpbnN0ZWFkLg0KDQpUaGFua3MNClpoZW56aG9u
Zw0K

