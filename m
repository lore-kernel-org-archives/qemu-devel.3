Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A0410BA432
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 07:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w61ai-0005Sh-Do; Fri, 27 Mar 2026 03:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w61ag-0005SI-HQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 03:26:46 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w61ae-0004zn-GW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 03:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596404; x=1806132404;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uTXnolJu5zDPVcousgjQ4TrvpTDsIxmO1NYA/32iAFE=;
 b=FHUD+yOtelKNe9EOd2B+ZNTSALQwidpbsyIqyEVP4YKJc7PpE0BaTcUi
 YVGvnw8/KJLRUDUT1QblbE+8LYDR3oS/0Vso35C4df4b3PwAi10bXCDoq
 jI/aU/WBMA9w++MiF7zMXRDd36meIipMuudcOUPfnd6ThjcPtmOfBO+L5
 yIqQh578709eTkD0z48FenSAy1P+v3RMADYmcRqMCxMX1UUFNt5AUqMJ3
 b2xcxEe0Jcuqyj0oJMoKjZykCXEiaHdlxdqSYAPj0Lkpy9E8vWmhx/y4V
 04Z9PJprMs9BMZynvlh+do/JN4Fw0U2l8qHUwtmaayqkKyiyAxF2zpKpH g==;
X-CSE-ConnectionGUID: NIin55mcSg+4sIkWDYI2QA==
X-CSE-MsgGUID: MoNwKSjaSCiokYX/Qtuhrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74848988"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="74848988"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:26:41 -0700
X-CSE-ConnectionGUID: fpysVPURSQ6Nrioa++pnig==
X-CSE-MsgGUID: +0cK4t9VQEW63i9MKfGUng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="222364327"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:26:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 00:26:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 00:26:40 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 00:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn6aDK9naMQhKj1cYbtwEIIyiqw3a/AQKTgWPOXOH9pq5C1dY0QONIIcIN470CyhplWrwTfOp4PYeI1W1umuH7fQIayFgG36keaxufr81uBh8XwecXt8eHz2WnB1TxYqF/nD7DmzSqZpBbuWybz8KYApwGC/xlGV7bDe+9SRGEpN8dB2+fKWkt2fcVs0V/IZ07r9r0z7W+HIQIU773QOyevNcpck/cI8El7sU34FVZdcpnMGS7A2tNUBr+EDjqcM7cLVwcfs/wLii0R7JYPOLyzul+p9q+MOcuAqzNtxHOovohTRCDrCINAIFtxN3DHWd9Wobz2wXPhhu0GjoHL62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTXnolJu5zDPVcousgjQ4TrvpTDsIxmO1NYA/32iAFE=;
 b=J2kPq893diCS2OG6jhKYaMOP3ER1Bra8J/g/HuBOIl/v71sZT3DF/D5l5ifXJ6tHYvpf3BMtx5eGrWrcHAUiZ3IHJRPXvRwjGxzuyNckCtP1VBHLAufjzPfFR/MvPtXxYb+skyjJoqRDoLd6eyaTqDhXLDxRcGfbQcSi8oFm5c+3Oex2DyT56pPbxEBGPwWfNszqe8Z81MkYAAhPw5HqgeuYWiXxgH5l0LWwok5lHkVcKkUnJ6byS7JQKgc7bm+xFI0EfJNY39TskdCvX0OeySmFqle0nmVdsVXIQWKLFQm+SNpCvxFV16fbOQsfm9rZwbZgltqQN9nLN/m3WxsJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB5091.namprd11.prod.outlook.com (2603:10b6:303:6c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 07:26:36 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 27 Mar 2026
 07:26:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHcvQCbcM1XVclbJU+X+K8SR/ZCtrXByrIAgAAwyxA=
Date: Fri, 27 Mar 2026 07:26:35 +0000
Message-ID: <IA3PR11MB91360912E98E04E39E3C50389257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-4-zhenzhong.duan@intel.com>
 <5cd0604b-15ff-492d-a4b5-7959476c06f7@intel.com>
In-Reply-To: <5cd0604b-15ff-492d-a4b5-7959476c06f7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB5091:EE_
x-ms-office365-filtering-correlation-id: 0f342412-593b-4c63-e991-08de8bd22dc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: MjKk2JbNCSmj0fM6o3fIT3qf+ommk4lyh2db590hLK/nnIywyKhIN0imk43Y4WTSkR2WYT0wdyog6kuWLO0skAsoFkC3KLHPa6h7ApSHzvuj0OvVGCDyrTueBTbsmBM7+3N5z5WiBPczyXNYBYDljdEzaUQaUUOMKQDzcVTUkU/Soz1p25CGGO2ujpeGgfFAer9psVlQvKVsp6hTzxmX0o/GGr+Nz7CGSZc0bkChE1RoG8JF886WepyBh2ywqurJqwgc5UXzcD8f1o/+MiTGsWzG1/H2m4IWucsaTNnaO4aAp+LVFuljZVxH919jYRGAjMCW+ZgFaKzzHyz9C/MOK48ZcIr0Fm0a8KaJM6VHtu1qKLqp33vrRMKfsLI0kFaPP7rHSnDkk0qiJuaBBaHp7HchS6UxxTADSU0sbJVeKdX+wemk6NKSDRzdBsvKpcGyjvKb5MGLzu+IlPLTYT9/G1dDZpryPgc0QywKl37a/hjAncm3B10dz3tB5G84lYrqMbKz4NDyXY566S0TSJkhG8XB2Obq2RfyYPFM9ICo+N/AInN4/JYiQupcqI48kivguiy3rzPUC1GxFqHiQj1ukS/4acX7BDpXJ1BcdJ4esP3Ym3MWheUvMKjVPemWDetS7mTKPQIHZcERVmNk1Ox1lFOQ3vI5ws78XLOOjV7zh95hId7IX7xdlkQwosCVF7jKZJ7ktyJ7KTu1rNe28s+fbtCF/88ZU51V6aB3l+hZTf6gj1ZG/Xmtdq9Q+478u3x6WaPoZOmQSskJnvmIyW8jYshwagVyXTMnKZutyc7YT2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUxZVnBCSm9vN01vNk1KRW5qYlRZeWJlZmlqM1puMG1aaUZvTmRrNUhSdEZD?=
 =?utf-8?B?YUI1bDZHQXZ1TnEzQ1JqZHZNbXJZWWhKb3dnVWEzb2pZREkydW9OT0lDWTFE?=
 =?utf-8?B?NVZrRlBTK2EydkRUdkRXUktCRzJLRnNnWjBiSGYyZWJtZWZMZVFvU3ROYmZY?=
 =?utf-8?B?TFhUZFRXK09qRStwbGVSY1J4WnRrSXFPd21JMWg4Y01BUVRFOHplK293clI3?=
 =?utf-8?B?TmVGN1IvbHFCcENzWVVad2tUM1VvOS80cWVvNU43N3Z6RXR4NEJPVmdsTWIy?=
 =?utf-8?B?cThpcStrNXVpQTZzQ3lDVHpmS2RqMlB1cDJuOFRqVHV6NHVLWVFNOWI3ZWNq?=
 =?utf-8?B?VjdxaTJTVUE4RWpPTjRVaVZGWlNyck80anpMUnhHQUdEYWduSjNEWVpEd3c5?=
 =?utf-8?B?aWxGbkR1Tnh1eWoyMDYvWHk3bFZrYUJLT0pwdG9ocSttVDFIUzA4VTZGWGh4?=
 =?utf-8?B?Yy83U1N4V2FQNi8rZTl3U1hwMktBbUJLSytkbmxpUFpGeEdEUzUzOG0rK2JC?=
 =?utf-8?B?MVh6ZVZPRWlqSENFVXFkSjFyZ2FETG55WW9TR0NNZmdYMVpZYkxYa0VvVitw?=
 =?utf-8?B?c0JIcjFqUVc0Wjl1dFVsY2oyZVI5ak9GQVdrenB0NVdUZGo3TGRKa29neUh1?=
 =?utf-8?B?TlBUWnJxM3NncEltS0F3aE5PNWkvQU1FSi96R3JWbUs3ekd1RXU2Y2xJNzMr?=
 =?utf-8?B?bThReUZaWkN1bFI3b1dpNzl6MFVXMEVHNlBHdGNYUGJBWmVOaGpnTTdUSnhU?=
 =?utf-8?B?M0dHNkZHWjUxMVFDbmQ5Um1VbWlOb2VwYmo0eUtRRDBXVjZmam9reFpnK3Yz?=
 =?utf-8?B?MWNyaFJiR2lUYVVLLzg5MVB3UmNlb0V1bGxpRmNZQWtiREFqSnJ2NFpMTnI0?=
 =?utf-8?B?TkRmMlFnYWx3d2ZlVzE0elB3VTFnUmtWYm1pdGVhZTlVNWYxNU4yWGxFamQv?=
 =?utf-8?B?ZzdEWXoyQTFQLzZWSEUycWpCYzhGWUxkbmU1TXZrblFtNmdEa21Dc2huMmIz?=
 =?utf-8?B?TkFhZGtBVUU3UFJDWmlxUU9jb3BJaUkwUWV0RGVIbWRLZTdBUURxZ25sZjh2?=
 =?utf-8?B?S1RSSWUzVWJ3d0JuQmpodnNSSUhXeHEwNURaekh4OG9tSTZ3SmN5dFBCUExy?=
 =?utf-8?B?bXVGcTYvMHRoTDlXV1dMakhVUVhGcHVUTWdSa2FlSS81endGN1pRbUNuS2xJ?=
 =?utf-8?B?TUpoSGYwb1FBRHRlcGlXNGhTc1JWRmFDOUowNkdoVDh2VWM5ZGlQSVRXMzVY?=
 =?utf-8?B?OTFjZjZNdEZSR054YzhiVmhMYVY4YmdIRWdmN29WanYxdXpEaWhtZTBLNG9W?=
 =?utf-8?B?UWt2Rlcwc3NmOFpONUVLREpFRy94SkxqOFkrSUN4RW1mejNaVUtYQ2hKbHBC?=
 =?utf-8?B?WlUzSHpJNWpZaDFMRENTeFVRc0M4REpwMUs2M3pXblBadU1EQnorcENlMkVD?=
 =?utf-8?B?ci9LZFlaSUxicmdpVUFHenhSUWhCOE9IeDloWjNMczd3eUo4dE1ma0tOQ1V3?=
 =?utf-8?B?UkdWOFRCSkpsSk5FckpxV0pSSUhZWmF5ZUh4VEdDK0ZudDdRSFA2UXU1QzBP?=
 =?utf-8?B?bXFsb0hwL1VnRVBSeDFvTFJSU3NQR3cwUkhzSnJaREtkOGhFalVpTEY4Uzhs?=
 =?utf-8?B?RTBnWE5KVzVMTXI5bmVoemZnYzJDSGhyWGdzZGNzUnIyQ29nd2RpL1I1eTNo?=
 =?utf-8?B?bFRaczVubXhRKzQ5TVlydlZNeU45V2FGNzBwVDI4Z2ZCamV6Q3ozMFd5S0F3?=
 =?utf-8?B?Q2RnZFl0c2JWcFNxQmhqQkRBRnU4elhVbDV4YVYyRlh4RnhMNHUrYmZzVU12?=
 =?utf-8?B?bUg5VW13UDZ2V2ZnK2hZZWd6SjRBR2d5bnZsY3UyWkpiOFN0RGQxTy9yY2VN?=
 =?utf-8?B?MktHcnBuVks5QWFjSm11bHJDLzhCS3JwZWZvZG1kMDAxeWVGMGJsZzl0V1V0?=
 =?utf-8?B?Nmlab3VHRGRhVkZLZGs5M3RZR1plNG9pZ0lvcytxc0NnRE10cmZaRTRGdnRm?=
 =?utf-8?B?UXNEUG5tMmxFcWRabnN6TUdQZkl6WG01MkJUdlF5a3lsdjZVYldSQnR1b1h3?=
 =?utf-8?B?cWtmeERseVovYUJxcFVFMzZSY0lKZ3JQNmtLTnprWVhUTjN3cXkwWmduK2JD?=
 =?utf-8?B?TGlyUTgxVE5zVFZWTjU4by9tK3V4SHY3ZzZZa0ZFeGdveW1BVjEveTd3Z25P?=
 =?utf-8?B?SFdLKzNjVjFJVEJxRXV1M0ZibFhWcUtaeWhXZi9GVUhEYnFGVGRmMW0zRXY5?=
 =?utf-8?B?UXNxMHFMYnM4cnlKekF4ZGU3bVhqNmRuRFd0UHo5Sm94dU9wSHpDUkR3N05L?=
 =?utf-8?B?dStRMCsvM2svSVhEQlZFMWgrSzQ2WWxNbURhQjVIOXFxcXJ5dG4wQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tVFUC5/6/rREewL6uuArbfgZJGNm0NS7JaQGDpRaGlqNp/6fIxZMRv3Dp5ltFPb8TatX6Ey/U3kZ7kPuvIkpNTl/lNcoVqhOrCG98sXMwCvi6GXvZ8nHjw9a1SJ21Jv1MWKecqbJTQyorTUg252s4jwqEgQHD18BbfGmGq4j5YtSSHgqL2I9PtthTqXA4NmqK5NTBWs2YKo2ZUROkqb6D/Qcd/qmJW+5Zz9QqYFEkU4/0tiFaaFe6L26J23qEk+CF+6xBXpuwq8sVmDrXiMoQUw/URFE9+tncFiQ48BGAbM/nJeoIraRVgZ7bEWH8A/Lk03VFKkIUxZ4DlcVdDNk3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f342412-593b-4c63-e991-08de8bd22dc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 07:26:35.9281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LQ6zG7zF7Ik/3Cl9xMsITcLkb63QHEBDdnL3X3CxYFi+Yql8M+P5Du2DxLpsI48LSaAu/r3IMQB4wuJjJ5HROibKaQtnzotTAir+ugZU2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5091
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDMvMTRdIHZmaW8vaW9tbXVm
ZDogQ3JlYXRlIG5lc3RpbmcgcGFyZW50IGh3cHQgd2l0aA0KPklPTU1VX0hXUFRfQUxMT0NfUEFT
SUQgZmxhZw0KPg0KPk9uIDMvMjYvMjYgMTc6MTEsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4g
V2hlbiBib3RoIGRldmljZSBhbmQgdklPTU1VIGhhdmUgUEFTSUQgZW5hYmxlZCwgdGhlbiBndWVz
dCBtYXkgc2V0dXANCj4+IHBhc2lkIGF0dGFjaGVkIHRyYW5zbGF0aW9uLg0KPj4NCj4+IFdlIG5l
ZWQgdG8gY3JlYXRlIHRoZSBuZXN0aW5nIHBhcmVudCBod3B0IHdpdGggSU9NTVVfSFdQVF9BTExP
Q19QQVNJRA0KPj4gZmxhZyBiZWNhdXNlIGFjY29yZGluZyB0byB1QVBJLCBhbnkgZG9tYWluIGF0
dGFjaGVkIHRvIHRoZSBub24tUEFTSUQNCj4+IHBhcnQgb2YgdGhlIGRldmljZSBtdXN0IGFsc28g
YmUgZmxhZ2dlZCwgb3RoZXJ3aXNlIGF0dGFjaGluZyBhIFBBU0lEDQo+PiB3aWxsIGJsb2NrZWQu
DQo+DQo+ZWNobyB0aGUgY29tbWVudCBvbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+DQo+aHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9hMzNjNzg1YS1hYjk0LTRkYzItODVlYi0NCj4x
MGI3ZDI4OGY2NjFAaW50ZWwuY29tLw0KDQpTb3JyeSwgc2VlbXMgSSBtaXNzZWQgaXQuIFdpbGwg
dXNlIGJlbG93IHRvIHJlcGxhY2UgYWJvdmUgcGFyYWdyYXBoLg0KDQoiVkZJTyBuZWVkcyB0byBi
ZSBhd2FyZSBvZiBwb3RlbnRpYWwgcGFzaWQNCnVzYWdlIGFuZCBzaG91bGQgYXR0YWNoIHRoZSBu
b24tcGFzaWQgcGFydCBvZiBwYXNpZC1jYXBhYmxlIGRldmljZSB0bw0KaHdwdCBmbGFnZ2VkIHdp
dGggSU9NTVVfSFdQVF9BTExPQ19QQVNJRC4iDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

