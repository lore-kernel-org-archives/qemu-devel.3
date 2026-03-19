Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777BA107527E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w39ME-0002ZP-Ic; Thu, 19 Mar 2026 05:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w39MC-0002ZC-Oo
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:07:56 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w39M9-0006nw-TU
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773911274; x=1805447274;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Tn113iaerpCJBdAzay4gBgqULZQ7HDG9PvFKy2fiHzY=;
 b=N3e1TC+/etYC9LLFEUnX4C4XHpZ/BffP9VwRLNPFMLE1WVob+DKtWJyd
 FGybQy7uZvJHGNsKybI2MvL+M+2xdkrol2iBT0KIcTYd/21TymLJnZthU
 L9bvrKLDOlASBM1ZHyKYdF1aH02s9JY6vzmFGOB7DvRmzz2t1L1V7Q1Vk
 AtU3IE6Ou8Gk3JsfBptc7nTdNV106FqYb1VGuPvhg/J7aFuIxLLzx1Ayq
 WJnbsnabrb3/kfhMQQ1NwTNorbFjmrGyAgsPkLXQYKG5FNF2G/3BqzPnS
 fcb/Genp5YuLV/6hExOdT6821QdLU8bzOdS7kodqxQ0bOunCkMEHn4I7w Q==;
X-CSE-ConnectionGUID: P9vsU8x4Q4GCXut0BHzKCQ==
X-CSE-MsgGUID: Z0P/XoFmTsqXn3Jhz92tsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="92360998"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="92360998"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 02:07:50 -0700
X-CSE-ConnectionGUID: UbeDDm9/Qo212CRl2dhoAA==
X-CSE-MsgGUID: 7HNpuvqlTCKDExUMgc9sGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="222003109"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 02:07:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:07:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 02:07:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:07:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an9iWTX4V3LSz8kcKWSyrSFj6CSSshLIBMdteyf0axq4eZ3BeceGdlYAEDamu4AeWfXg76jPfSoPWX/LD9nP83vQ+ynsKxDGKFyPblDL0k8tbie+JMSqxIOEeD3NgwLlQn8yGQ1SnaaGUMl0MN4A2ghUUvJPutZzHYSGIAMixnPi7v2qvQdI7JY+0Ivq0GA+Ij3/gy/8H0TkBdZ3xapn7+AN8WH22SnfJCyt5wlfeBKi8KNrDbGqksiq6m2mfrQIWUZw3AjyR8hluk7ifenQvSy6J8UuqSzeVVHgO3CeIfb4pHabBVFAkc74DGCyyT7p1vEe9qdQIpvbK7AjR375rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn113iaerpCJBdAzay4gBgqULZQ7HDG9PvFKy2fiHzY=;
 b=WF1fWUFrPOBkIIAZ2H7JurHRvT5eTmJVRAF71jLcRYpGQeUCF+AYqbqEC5C0bV/sNVdGK27KuSk5oCQ+OvoNiMkwiNS6fbfI5ADsngjMw/r50Q5C4XNrMDg5a0Ff/kz4f0sKqxcVuGtu2qlgAeUmUyoNhRFIB8cTmtcx0sXCUrkwigbDdPXrnOUqYHK/p3fcv4RbQ+rwfK0d+tGWmbLelSB/nS/drHm+erbC/gy0bYR75X2v5wzNb3yTKAp6yPc2kW5jMnIILFyPd7DGGN5ybPC8Ao5zWrBGRliTOQbUjZI7QVw+SpdujC9Tifx89gLQCkO76zuOwpQXdM03T2vsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:07:45 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Thu, 19 Mar 2026
 09:07:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Topic: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Index: AQHcrRueV4S7cttZ6U6X0YZKvVaD9bW1kyWAgAAOusA=
Date: Thu, 19 Mar 2026 09:07:45 +0000
Message-ID: <IA3PR11MB9136F0D294E9FBE576E0CF91924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-12-zhenzhong.duan@intel.com>
 <1b2b191e2f9f1315c883ed2de4fb9644a01c8713.camel@eviden.com>
In-Reply-To: <1b2b191e2f9f1315c883ed2de4fb9644a01c8713.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6858:EE_
x-ms-office365-filtering-correlation-id: 66a94206-726c-4c4a-cc3b-08de8596fbea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Dw1d5SvJBn8HywfxjEH7bxc4z0GodxWj6sAKNkzX6QdjqMPQ1TdPa405Hc1xeyGroQuQs+H4OXY2d6yjRml5eRf6RVegRQj6mY5R/tC/DlRIZodEV1+5gRKhhsnAYC8pS5Ot4wkjogZ6aN3KY0FXoem+SmUD/9kkMCZrdIRbCWCn39yYmTv6iHek1DNIU7rt0w98VJl9WrMrl+D7SqC6i7ZZoPiw0d6dKNzw8+R76OfcNwlEY8dR4CcgIIfPWTg2Ih+nAj1F+QP2vhX7m732x0jTdYTEhD8XWqx0Wbzk4MfB1vUbvqzieaFCddlQUubh8cfsgozq9lOGjvazpt8RHsQ9HdYl9MYfCRfoEYoFLVlkdfcQFp/ESiNyuE5zutowxbOyK8e7Nmd1uq0O40Yy4QQTLoXMx/g/59wyDVuq4gJ6/L5LuxFElHel8UocVlsTqGDT+dbHHgBEVI5PV2PLQv0o41smAm6HjNCO6AIzhB66vOgIlhJvqv5VDmotgAqUvGUGfu606Lmg1c/Lv6Y/ZUrI3YngaN9S/L9xNnFEojc9Y2uavG8Xpdf8G7ti6Cc/tPAbKWpMXbPBVgoMG+4Pt+Iwg2Vg3LWglTXAcsHeWxpKEHML7ykDjHJgP4yMMcENcxz/v1uvyhfvebUn77w8Y6j+8iNfY29Ms31ncaFJKm4az6NU5Jy/pBoAbItenRvmNmijcjJ0fMJPiXmpOe2D0boZ/CPQTJ54dVYPDV9GAJAbyFuBqhyxpAK2m8Bn0+BmpVCwNGb+JPKzrFHl14emcKlVqo6WLE7e9jfE45Dp1xA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE54cXUwdXJ4UzZyVUp2emFHTUYwVUk4NXhiajRUQlEzcVdjamlKZG1acURT?=
 =?utf-8?B?UUVEdVYzTUZKWGIrRkc3UlRVQ3J3MWhZRlp0ZHR4d2dOcjIwbkszYWc0cjZs?=
 =?utf-8?B?WXZrcnhxWGYxRkQ1M0ZhNlpIcTJodE5GV3djWFNkcHhoZWtiTUpobmQvdjBR?=
 =?utf-8?B?S0lOSkFnUkt4SXhHYTZkbFJnTFJ6VitqcHp5YnBaeVRHbzdWNlJYWHVqaUlj?=
 =?utf-8?B?WlFpQXFyODQ2aFBtMlNOWjQyRmU3ellqR1BJU1Z1WE1XWXpTblJkYU9tUjc3?=
 =?utf-8?B?eEhPZFJOQUcvcUd3THZvN1RhVHlNNTV6UVQ1WDRaMTBJV0dSTUVUNUlkYUZU?=
 =?utf-8?B?YURQZU9SVENmdDhpRjdMQ3dQVWVFUFhvSTI5aktnUTVORmhMb0l6azdBRzkz?=
 =?utf-8?B?d0lLUndBYmtJM3pKWTFOd0ljcThibTBZVzZYancxV3dObDdidmRVOGtEVVRi?=
 =?utf-8?B?andzUWM4Q09RRFp5c0J0ai9GRmNyeUNzVWpxb2svNDFHZXBacCtyU016Q3FC?=
 =?utf-8?B?RHR2REFwSVhONmwvT25wTm0xcFJRRFo1M2JEanA2UjJjMlNHeU1OblMrTWlr?=
 =?utf-8?B?aStITE1SY2FUV0JsTUFDeEFCcEJUeHdvSUVUUEJHS1lYajRSdzY1RUMrUWtJ?=
 =?utf-8?B?UDZFc21lS0ZQVy9jSm92d3dPeXc4YThibTRUV01QYTZwOVVkWjFMblhSSkQ1?=
 =?utf-8?B?S1N3em9SV1FjL3g2MlBvRFdwZUZDMldLdnkvcGFFSlEvOCt2ZGRzVTA1M1Fk?=
 =?utf-8?B?RE1QZHBncVVBYTdyY0tsaDlJZDFOMjQ2SkFoODBCWGVHbDhVRnNCMkZZazZa?=
 =?utf-8?B?RjJ4eXYwWTVWQm1PY1dKT25YMVhCZGNRVGFwQlp0UFhyUno4a0hDTG1ZZkFZ?=
 =?utf-8?B?SnBXb01oTUhsTXhFWDFwNWczaDNaeFg4Q3FwR0ZvNXhhTkd1Y1dZeUxqY3h3?=
 =?utf-8?B?WHB0SnFJL2svUjlNa1AvZ0J0aklSQzBVKzlrdy9zd2t1NmE3UzVyRXQ4VDd0?=
 =?utf-8?B?aVdOQnlVNUowZWNvOWhRY2daTGNaR0U3bTRyaVpvc05PZFVnVEZ3SXhWVkZI?=
 =?utf-8?B?b1VTUG9EL1A1YWhMaGJWaVVqZC9PYTJVU291RW9VSitLWVA0SGc1QSs1VTk4?=
 =?utf-8?B?MVZuNG91cWR4YWxRc1VWUldZc0NPaU9yTHZCS0lvM2VkdGtleUVBblhKMEhy?=
 =?utf-8?B?SjhSSmtlWThrZmQvV3B0dUc5eUhKZHFTQVVZa1JWT0N6ODh1emdxMTNVeGYv?=
 =?utf-8?B?WjZ5VnFPN1I4TXRzMGRaTENvOUhibVRWV3dNT0NCUWxObjNqVEdYekMxcFFE?=
 =?utf-8?B?VFR2YzJJMVozZVhGdTBWMklEK214TUd4ZlhDalBvcVQwSlNhRTBHRmg1R2RW?=
 =?utf-8?B?SVROSW55YWs1SEZOZmJPL0FuUmtoaTJuQVFvQ0Jib3k4dzVkUUhvcFY1TStD?=
 =?utf-8?B?UzNkNmVVWDRWNU0zbVU0MEhtbkQxOURsaXA2b1Nod2lONUFMVG90ekpLYUVo?=
 =?utf-8?B?WlNWc3FnS0FUQ0dyMmkzc2pqWis3OEFjY0N4TmV3RStVZ1NBSXdIbVplS2ps?=
 =?utf-8?B?UlV1MHB0eVRJc3Z0Nlc4VWZRNUxJVW0wMGxET1BSQVNhRUswWkN0ajZRQ3dB?=
 =?utf-8?B?TEZweTVQeWY5ZmpPNHBxNC9qSW5DcVAya3JybHNrRHJjZHdFTkpxYVNFejBI?=
 =?utf-8?B?WG0yZUZWQ1REblVVVllTdzhkUTI3eTlaZEpIaTVTMlVLRkdocGhSTmxMamRo?=
 =?utf-8?B?elBpV3gzc1FMdm5zb3JQVnIwYnRyWkExQ0txRkhOZVhuN3NvblAxS0trSVN2?=
 =?utf-8?B?dWwvcXgranRsL0lOOHZRaXNkM1RYVWI2aENadnVTdFV2cklhMUM1OWdPS3BY?=
 =?utf-8?B?YTV0dHNkZkRrcm5FMjBIdGl3WGRWeG1sdTd5RzloaUkvV1Z5TGtZaFlOM0Fq?=
 =?utf-8?B?NVlRSFFTclE2d2Q5OHdIZE5PK29iMG0zM3dIY3RFamtnZjNDaXFLTmFraWpj?=
 =?utf-8?B?bnpzd0xOWkdjVWt1NyszWkFkZlg3MDdJRTFiaXJzZVJTZnY4RkNrNzhOWWV1?=
 =?utf-8?B?VG1MYUs1Qk9yVGlwQ3hGSXpYSFhmZkRaTDIrR21QOXhkZFVKd1lHTFZWMjNJ?=
 =?utf-8?B?TE51OWN6V0M2MFdjVFYwUjJWYVp6QSs1YVZuQmZzNWFKWGRqOE5JUzZOQU1q?=
 =?utf-8?B?WWlvU0crT0JYYWtHcHRzRHlrYTRidjhOaWNUR1VFclhqM2hpNHd4N3FuUTll?=
 =?utf-8?B?aGNkZnVYVENDeGpSZ2lSZkZnREZJZ2xjMUNUdWRhaTFoOHltT3Urcnk4RVp6?=
 =?utf-8?B?eERGMnlDR1VqNitvLzd2TENvMTRzaHMyN1huYWZoeG9xUmxEYUVNZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MlH57GobBuRZME3RB393b79MtgPVQPT1qEJPfvLYhlCOsJveXYMO8qvhMowK7ENExKOZM1fxLRDm1Ib44mvpOW9skyzmreFuk0EvkZH+65VQyO27H5zcOyOb+POgtfPYW9HrRvYjhoh897h/qPfuxoWmkEZDPCv4hul5tENfZsQ3sJFG/bwIIaR6g97HWuIricD92+NwITEuaJ3mxRCPPQuJzsPjQqiVlTdYAudKmFgMH1MFP4RHtoBiXsGwqwOT8NiKbnVNdJ7zR4L212yLkAD6OwOivkDbkmEyu8NTSE759XB4NhehjU0qrA6wHHioalKFBxle6oq4qF85A9ftFw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a94206-726c-4c4a-cc3b-08de8596fbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 09:07:45.0440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /dVACehWzY9oU3NkZG+RLw+3BJfgjJiE/8Yumnmgi9aU/IGd9rnkDemZstlFTN54KYZVKciVYYQ7V3C40/Sz+VTWFMmXK8cZn+mpt3C0PX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+DQo+U3ViamVj
dDogUmU6IFtQQVRDSCB2MSAxMS8xM10gaW50ZWxfaW9tbXVfYWNjZWw6IGRyb3AgX2xvY2sgc3Vm
Zml4IGluDQo+dnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9sb2NrZWQoKQ0KPg0KPnZ0ZF9waW90
bGJfcGFnZV9pbnZhbGlkYXRlIGNhbiBiZSBjYWxsZWQgZnJvbQ0KPnZ0ZF9wcmlfcGVyZm9ybV9p
bXBsaWNpdF9pbnZhbGlkYXRpb24gd2l0aG91dCBhbnkgbG9jay4gVGh1cyB3ZSBjYW4gY2FsbA0K
PnZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfYWNjZWwgdW5sb2NrZWQuIElzIHRoZXJlIGEgcmlz
ayBpbiBjYXNlIG9mIGNvbmN1cnJlbnQgaG90DQo+cGx1Z2dpbmcgb2YgYW5vdGhlciBkZXZpY2U/
DQoNCkdvb2QgY2F0Y2gsIGhvdHBsdWcgaXMgcHJvdGVjdGVkIGJ5IEJRTCwgYnV0IGlmIGFuIGlv
dGhyZWFkIGNvdWxkIHNlbmQgUFJJIHJlcXVlc3QsDQp3ZSBzdWZmZXIgZnJvbSB0aGUgcmFjZS4N
Cg0KSSB0aGluayB3ZSBjYW4gYnlwYXNzIHZ0ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlk
YXRpb24oKSBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlDQp3aGljaCBkb2Vzbid0IGNhY2hlIGlvdGxi
IGVudHJ5IGluIFFFTVUgYnV0IGluIGhvc3QsIGxpa2U6DQoNCkBAIC01NDAxLDcgKzU0MDEsOCBA
QCBzdGF0aWMgaW50IHZ0ZF9wcmlfcmVxdWVzdF9wYWdlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFx
dWUsIGludCBkZXZmbiwNCiAgICAgICAgIHJldHVybiAtRU5PU1BDOw0KICAgICB9DQoNCi0gICAg
aWYgKHZ0ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24odnRkX2FzLCBhZGRyKSkg
ew0KKyAgICBpZiAoIXZ0ZF9maW5kX2hpb2RfaW9tbXVmZCh2dGRfYXMpICYmDQorICAgICAgICB2
dGRfcHJpX3BlcmZvcm1faW1wbGljaXRfaW52YWxpZGF0aW9uKHZ0ZF9hcywgYWRkcikpIHsNCiAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KICAgICB9DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg0K
Pg0KPmNtZA0KPg0KPk9uIFRodSwgMjAyNi0wMy0wNSBhdCAyMjo0NCAtMDUwMCwgWmhlbnpob25n
IER1YW4gd3JvdGU6DQo+PiBJbiBvcmRlciB0byBzdXBwb3J0IFBBU0lELCB3ZSBoYXZlIHN3aXRj
aGVkIGZyb20gbG9vcGluZyB2dGRfYXMgdG8gdnRkX2hpb2QsDQo+PiB2dGRfaGlvZCByZXByZXNl
bnRzIGhvc3QgcGFzc3Rocm91Z2ggZGV2aWNlIGFuZCBuZXZlciBkZWZlcmVuY2VkIHdpdGhvdXQg
QlFMLg0KPj4gU28gd2UgZG9uJ3QgbmVlZCBleHRyYSBpb21tdSBsb2NrIHRvIHByb3RlY3QgaXQu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4NCj48W3poZW56aG9uZy5kdWFu
QGludGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSk+DQo+PiAtLS0NCj4+
IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oIHwgMTQgKysrKysrKy0tLS0tLS0NCj4+IMKg
aHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgIHzCoCA3ICsrKystLS0NCj4+IMKgaHcv
aTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIHzCoCA2ICsrKy0tLQ0KPj4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2Vs
LmgNCj4+IGluZGV4IDFhZTQ2ZDkyNTAuLjNmMWIxMDAyYjggMTAwNjQ0DQo+PiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNj
ZWwuaA0KPj4gQEAgLTI0LDkgKzI0LDkgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREQUNDRUxQQVNJRENh
Y2hlRW50cnkgew0KPj4gwqBib29sIHZ0ZF9jaGVja19oaW9kX2FjY2VsKEludGVsSU9NTVVTdGF0
ZSAqcywgVlRESG9zdElPTU1VRGV2aWNlDQo+KnZ0ZF9oaW9kLA0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFcnJvciAqKmVycnApOw0KPj4g
wqBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9maW5kX2hpb2RfaW9tbXVmZChWVERBZGRyZXNzU3Bh
Y2UgKmFzKTsNCj4+IC12b2lkIHZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9ja2VkKEludGVs
SU9NTVVTdGF0ZSAqcywgdWludDE2X3QNCj5kb21haW5faWQsDQo+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdWludDMyX3QgcGFzaWQsIGh3YWRkciBhZGRyLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVp
bnQ2NF90IG5wYWdlcywgYm9vbCBpaCk7DQo+PiArdm9pZCB2dGRfZmx1c2hfaG9zdF9waW90bGJf
YWxsX2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2X3QgZG9tYWluX2lkLA0KPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB1aW50MzJfdCBwYXNpZCwgaHdhZGRyIGFkZHIsDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHVpbnQ2NF90IG5wYWdlcywgYm9vbCBpaCk7DQo+PiDCoHZvaWQgdnRkX3Bhc2lkX2Nh
Y2hlX3N5bmNfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzLCBWVERQQVNJRENhY2hlSW5mbw0KPipw
Y19pbmZvKTsNCj4+IMKgdm9pZCB2dGRfcGFzaWRfY2FjaGVfcmVzZXRfYWNjZWwoSW50ZWxJT01N
VVN0YXRlICpzKTsNCj4+IMKgdm9pZCB2dGRfaW9tbXVfb3BzX3VwZGF0ZV9hY2NlbChQQ0lJT01N
VU9wcyAqb3BzKTsNCj4+IEBAIC01MSwxMCArNTEsMTAgQEAgc3RhdGljIGlubGluZSBib29sDQo+
dnRkX3Byb3BhZ2F0ZV9ndWVzdF9wYXNpZChWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywNCj4+IMKg
wqDCoMKgIHJldHVybiB0cnVlOw0KPj4gwqB9DQo+Pg0KPj4gLXN0YXRpYyBpbmxpbmUgdm9pZCB2
dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2xvY2tlZChJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQxNl90IGRv
bWFpbl9pZCwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdWludDMyX3QgcGFzaWQsIGh3YWRkciBhZGRyLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBucGFnZXMsIGJvb2wgaWgpDQo+PiAr
c3RhdGljIGlubGluZSB2b2lkIHZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfYWNjZWwoSW50ZWxJ
T01NVVN0YXRlICpzLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdWludDE2X3QgZG9tYWluX2lkLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgcGFzaWQsIGh3YWRkciBhZGRyLA0KPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3QgbnBhZ2VzLCBi
b29sIGloKQ0KPj4gwqB7DQo+PiDCoH0NCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCBlZGQyYjhmMGNjLi4z
ZWE1YjkyYjM0IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysg
Yi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0zMDExLDExICszMDExLDExIEBAIHN0YXRp
YyB2b2lkDQo+dnRkX3Bpb3RsYl9wYXNpZF9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcywN
Cj4+IMKgwqDCoMKgIGluZm8uZG9tYWluX2lkID0gZG9tYWluX2lkOw0KPj4gwqDCoMKgwqAgaW5m
by5wYXNpZCA9IHBhc2lkOw0KPj4NCj4+ICvCoMKgwqAgdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2Fs
bF9hY2NlbChzLCBkb21haW5faWQsIHBhc2lkLCAwLCAodWludDY0X3QpLTEsDQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZhbHNlKTsNCj4+IMKgwqDCoMKgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gwqDC
oMKgwqAgZ19oYXNoX3RhYmxlX2ZvcmVhY2hfcmVtb3ZlKHMtPmlvdGxiLCB2dGRfaGFzaF9yZW1v
dmVfYnlfcGFzaWQsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZpbmZvKTsNCj4+IC3CoMKgwqAgdnRkX2ZsdXNoX2hv
c3RfcGlvdGxiX2FsbF9sb2NrZWQocywgZG9tYWluX2lkLCBwYXNpZCwgMCwgKHVpbnQ2NF90KS0x
LA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmYWxzZSk7DQo+PiDCoMKgwqDCoCB2dGRfaW9tbXVfdW5s
b2NrKHMpOw0KPj4NCj4+IMKgwqDCoMKgIFFMSVNUX0ZPUkVBQ0godnRkX2FzLCAmcy0+dnRkX2Fz
X3dpdGhfbm90aWZpZXJzLCBuZXh0KSB7DQo+PiBAQCAtMzA0NSwxMCArMzA0NSwxMSBAQCBzdGF0
aWMgdm9pZA0KPnZ0ZF9waW90bGJfcGFnZV9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcywg
dWludDE2X3QgZG9tYWluX2lkLA0KPj4gwqDCoMKgwqAgaW5mby5hZGRyID0gYWRkcjsNCj4+IMKg
wqDCoMKgIGluZm8ubWFzayA9IH4oKDEgPDwgYW0pIC0gMSk7DQo+Pg0KPj4gK8KgwqDCoCB2dGRf
Zmx1c2hfaG9zdF9waW90bGJfYWxsX2FjY2VsKHMsIGRvbWFpbl9pZCwgcGFzaWQsIGFkZHIsIDEg
PDwgYW0sIGloKTsNCj4+ICsNCj4+IMKgwqDCoMKgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gwqDC
oMKgwqAgZ19oYXNoX3RhYmxlX2ZvcmVhY2hfcmVtb3ZlKHMtPmlvdGxiLA0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2
dGRfaGFzaF9yZW1vdmVfYnlfcGFnZV9waW90bGIsICZpbmZvKTsNCj4+IC3CoMKgwqAgdnRkX2Zs
dXNoX2hvc3RfcGlvdGxiX2FsbF9sb2NrZWQocywgZG9tYWluX2lkLCBwYXNpZCwgYWRkciwgMSA8
PCBhbSwgaWgpOw0KPj4gwqDCoMKgwqAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+DQo+PiDCoMKg
wqDCoCB2dGRfaW90bGJfcGFnZV9pbnZhbGlkYXRlX25vdGlmeShzLCBkb21haW5faWQsIGFkZHIs
IGFtLCBwYXNpZCk7DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5j
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiBpbmRleCBkN2MxZmY2Yjc0Li5hY2Ix
YjFlMjM4IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiAr
KysgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+IEBAIC0yMzEsOSArMjMxLDkgQEAg
c3RhdGljIHZvaWQNCj52dGRfZmx1c2hfaG9zdF9waW90bGIoVlREQUNDRUxQQVNJRENhY2hlRW50
cnkgKnZ0ZF9wY2UsDQo+PiDCoMKgwqDCoCB9DQo+PiDCoH0NCj4+DQo+PiAtdm9pZCB2dGRfZmx1
c2hfaG9zdF9waW90bGJfYWxsX2xvY2tlZChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90DQo+
ZG9tYWluX2lkLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHBhc2lkLCBod2FkZHIg
YWRkciwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBucGFnZXMsIGJvb2wgaWgpDQo+
PiArdm9pZCB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2FjY2VsKEludGVsSU9NTVVTdGF0ZSAq
cywgdWludDE2X3QgZG9tYWluX2lkLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBwYXNp
ZCwgaHdhZGRyIGFkZHIsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IG5wYWdlcywgYm9v
bCBpaCkNCj4+IMKgew0KPj4gwqDCoMKgwqAgc3RydWN0IGlvbW11X2h3cHRfdnRkX3MxX2ludmFs
aWRhdGUgY2FjaGVfaW5mbyA9IHsgMCB9Ow0KPj4gwqDCoMKgwqAgVlREUElPVExCSW52SW5mbyBw
aW90bGJfaW5mbzsNCg==

