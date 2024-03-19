Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06014C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 03:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPnQ-0003VX-55; Mon, 18 Mar 2024 23:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmPnO-0003VB-Gx
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:05:46 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmPnL-0006hW-Kt
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710817544; x=1742353544;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QtE15+LC6LZ2m0V2J3PLo1ZEiUZyCvxAzFR+qhXdHfY=;
 b=H5uTRTYU1rG7vph5YO0WJW+4VaF7uyaRkhdJZtMlsHaAiCVojP+TX3CT
 wfvDG73eNIE/Lb8eNA4aPq+cDdDe/tAU2GwxiH99Xw3ha/fj1/WxMCJZb
 rj0QdQdosrrIVHdzJks0OfT7TasYseEeBfcfKjcvvlVeaAGj3DsdSo42Q
 XnkmnZstWdusJx3AYrXDHQlyfl6pk/LbRsKV1nxo2qRMb+tt51wkiiHtM
 lFfmD75U5Bvay4Mwubo39kD0w/y90+whTkHunMsrSOwK4+bS3BAdhaT3Y
 4Hr6NfxilZh0NEGkT+/a1PQmnYQH5vZEK40Y0PICmoAOCS+SBMjm0iEgK w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="6270365"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="6270365"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 20:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="13715001"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 20:05:28 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 20:05:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 20:05:28 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 20:05:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQnYgzni0JwuZS6Mb5K7D6MXWXmRjBn/lTg9eSmWTj9Z/VG+sStA0+e7zzA8F5iXvnDcIVQq2fbTIqPiaCp3ngFfS55xfwSjCbwcXl2lQL5dSi3UAVKwBO69649FSABr0LC3o6ZwByV45LLHIObD8QTqIIotMttDiAf5joFyjlcKi4vzB3isBtP5/ED4K83eEGjQzLE7uDWbC0sLy0I6+yrrkVpjvO3IDyT1XQ1Fn1igEJ5oZ89HVWI3+fDazx1a0GYyXVZHJaUhysZIXLFTecNGZ5AdcsZD7ZTNfBgjOPjabS4pml457NlSHd4G+p6cm58MEGQk8v+ZzvmZxlBKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtE15+LC6LZ2m0V2J3PLo1ZEiUZyCvxAzFR+qhXdHfY=;
 b=Ouek6jbniwII4oKdVPCTpdL2zoctBDHl503lwBgPnFB7teTsLsZR7TMNR0Xfyp4evib/Z1y4IVhyRD6bgstNReurlYW34gxMxqv5cukJMFxu53XPsojzo78gvHLd94m9V9dS96KWqBOyqGJdfaQ0Sj0O8HIUA74VVyliR2E34g9MhnICi2BjOe9mVrRjYX2yOSoGICEuERWYoTWmCKRwnoR+obpH2761CWJQGwdaeC54OoXkEQsrOj5nGOrsy7XE/8eU7sAZb7+bxTttCskMZIN/LvQ2BJddSQKlLkVr4UXzO9C8uSmkmaA/WB+jm3LggFqLJ37mqz3M4XJoQInH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB7834.namprd11.prod.outlook.com (2603:10b6:8:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 03:05:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 03:05:25 +0000
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
Subject: RE: [PATCH v1 04/11] vfio: Add HostIOMMUDevice handle into VFIODevice
Thread-Topic: [PATCH v1 04/11] vfio: Add HostIOMMUDevice handle into VFIODevice
Thread-Index: AQHaafrSHSiFoGlI20yP1RDCFrCFG7E9okIAgADeDsA=
Date: Tue, 19 Mar 2024 03:05:25 +0000
Message-ID: <SJ0PR11MB6744894727978D20122C8E91922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-5-zhenzhong.duan@intel.com>
 <44415979-ca17-4f85-9092-aff2f50745b1@redhat.com>
In-Reply-To: <44415979-ca17-4f85-9092-aff2f50745b1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB7834:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xq4Rms1LGZXdzvqUQBpfS+AORuWFuHpE2ytzZ98NQSy8P5a/N9O5EhUETalLK9ZWUBahiw/nBWETJmoYs3oZj366zqFrwaE77LURHoaiwsSkQDsSEIgaRsl6HLOa36LpaqihKbferSMOsI0hcTtCGf0m+WTAaU93IfTkCT2hc1dhJV50i8JnPdvxCyrTEFDxhPCxNfPZSP6d0bl/ICAsr/50wZvSDnftS/jB008tgmKEp10/Xy/8R3SUgbQYCWX4EGDzVl3UmjucFj3fxCBy8SmgJSm/C/XvU2TEEtGYAYZf95FuEdJEloODuEII4C4s/oKAuhuFMyURzTnfiW77MVjd+wm2LzaKUPQ+ReLKYxiqboyAyQLIaqmpXwdbC3xh2Tf2fkgWAUCNwpKt4JfLcosoZE7QoZb1UBmfTntoqTyOlIfjJADhKYcP8KtjbPURz0j72anrjL3gWIbqyaT8nB7ZN2KAx1dNxhDIIgkAUveL5Bqy7cz4G151G1wrFTLq5ir1YQNXvmyLBMaXRxezX7QPM0dl4s7SA+RlHwAznxqyLqZ1pkGIBSdU+0vSO5hM7jOCqFHLPp//xdvT+uQ3ZA8xR5ExTQF0yrnIMsWyxkorzEiB/5wxfbsTuk2ELfrHWdEcAGcYiwlRUHRczF8AExU3SdBhxaOg46TWUJB91ZI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1lnTVlxaVlXMlFQRDRERGVBdEhqUjg5RG1WOU42ckdKaXJBL2ptMzVDK1Ir?=
 =?utf-8?B?ZE1wdVVGeU0zcTR2c1FHYnZJUmFKY3ZJOFRtZmRlYTVaS0xTRmdiR1ptOTNK?=
 =?utf-8?B?Zi9ENzlvcWt2eXc2dU4rem5uRVkydmZ0cHRHWjhzcWxwb213ZkRieW9VZGw1?=
 =?utf-8?B?c2M4M3JIV2xwVFkzT1pyQlQvOW1XSEhyM2daWDNaOWV5enVtR1RuOGRTMmFN?=
 =?utf-8?B?SzRJR0J5cE1QNW55SysxaGpXeVorMGtFek5Za1NqNFlCdERma0Jucnd4bld0?=
 =?utf-8?B?aFlrSldsdHBOQkJTcXVhWkNrK2NITERwOWJvRGNLM0t6cVVHSjV4UTd4ZlR0?=
 =?utf-8?B?MFE5aHlSTVgvUEd3eGcxVUJDZUpLWkdqb3BET0FXaDl4MXdURSt5eUpJUXRS?=
 =?utf-8?B?dy9ZOXlZMmtSYXRISVJNWHZ3NDAxWDdyRXNSM2JBT1E5RHZya09HMnlkTitx?=
 =?utf-8?B?c1JWNkRFaTMxNTJLeXNvS2hhZ0tmZGpyeGxDcGZ1SlgzY01qdmYzQnY0N0Jr?=
 =?utf-8?B?OHZlTFdVcGNhRjhhTWpVc09nUnAwZlJRalR0ZEdFTUVUOTV5MHgrY2lhRkxD?=
 =?utf-8?B?Zm1YWmVSVnd6cjRnVHFBN3dFWTlhSGdUQ1FCZlBCSE9YTUxkMnVtaFk2dU9J?=
 =?utf-8?B?OWhnVDFQVFZ3VW5TRDIwU29XWU4xd050MVJKaE5uYzhXRnVQQm5IR1ZUdmZD?=
 =?utf-8?B?NUp3SFRqdS9BUHI0djJPTk5jaUtoZ25CSDRHTEV4UWFiYVVwR3NaNWRXejBa?=
 =?utf-8?B?clJYcGMwRnJaUXJpazRHSTZNYUZNYmtaNGJibFkwdktuc1UzSFZHQnBtdG1P?=
 =?utf-8?B?YTZ1M3UyQm9vRjFLOVlQS0lyQWZTaWp6MmtVS3A4NGFyNWlHZlBmRkpxTWtp?=
 =?utf-8?B?OXU4dTJFZHpvV1JSZ1cwb3BtRHBIWkcwUkQyNVJWYzV4WDB2NmhQdExWVHFn?=
 =?utf-8?B?cUxtU01GMm9CdXl1UWh6Q00vQ2JNdHhjZmx3WFo2ZWlUeWxuODFHQk05MEg2?=
 =?utf-8?B?Ukpsd3NtZUVzZm5rdmdZdXJ3YklBY1JuT3JHZXlZSGtZNDlObjZ0Z3N6Y3du?=
 =?utf-8?B?eFZsMzFZL1BQOGt3aTk0Q0cva3FNeTlZdTlaTXR4SkxqSExNeVM5aXZJRWRM?=
 =?utf-8?B?VlR2QmR3ZjQ0TVFkWG1pMGplUUFibm9ZTjZzSHZZUnZHa01QUFh5UHRWdzQz?=
 =?utf-8?B?aEFDVEEwQnNSeW0xelRaVjVTZGJRTHpoVGRSajJHdjFid1VlSU9rU0FsWWdG?=
 =?utf-8?B?cVBsU0NlVE9sL3FuQ1VITHVUaHoxbVdHcGs0R05PMW5HZlhodDBzMk9idm5O?=
 =?utf-8?B?OHpGK3JCcVFTZVlOUW9IKzRYTXR0alhLd2Q0dVNBQ09wMmgvb2JBZENVdVRM?=
 =?utf-8?B?RG93ZkpVQjJUalh4RzZ3STZoMXZGYzk3cHk0dmlNbW9EV2N4WkRLblllblJa?=
 =?utf-8?B?clFKaEl5d1QyN2FpOUtXa2xMMDRTRTNLTkpycUhFdWY2N0d0M0E3MGc4REZw?=
 =?utf-8?B?ei93clNyTW10TVdoOEdxOUFtSWRmVkVUMTN3b2xjQ2o4eUozU2hPQ0RiZTlX?=
 =?utf-8?B?b00vbVFKeXlaRDNZYTE4dkpHNlFiaUg5ay9vbXR0QnpibkJZS2IzaGZ0dk1p?=
 =?utf-8?B?bFRPdnZiWGVCaHY4MkpSc0h2NzlZRzJDVlFlRDlacTV0cDhvbjBIbm5mUCtM?=
 =?utf-8?B?Szd3eHQvaXVEVHpHKzJrQkNSTFJaTEY4UElpaUdGVmhjTnI1WWFkMHYzSEJx?=
 =?utf-8?B?cWFFWGhUV1VxSWlyREw0TS8rYjdOM1orU2E4K0c1bE1GL2J1S2VUZ2NyZ3BP?=
 =?utf-8?B?MWM3ZjRXNDFLV1RYdzRVaE9GQ0J5WEdYODMvWjc3R29QRnlRVjFBVStheGlt?=
 =?utf-8?B?ZGRlZTJ3T3FNR3dqNzY3bDZuaW5WRnhKUE13ZnptdEJhdXMxa2sySHRZVWFT?=
 =?utf-8?B?WlJMcnAwRXY4WC83aUxtejBLNURQclA4Z3B0RzFnYjVTamtaTjlZZkl2NENN?=
 =?utf-8?B?WmlhcWZiZHlMdHlaaWt2M3pwTUwzWGovOHh4MUFXeUFCdmo0UTRiYlY1WFpR?=
 =?utf-8?B?c2d4ZGtUYVZaa0hROEFSUHhwME92Nk5acWJOSFFKSmNCVUEzR3czWXczQWRj?=
 =?utf-8?Q?JJbTODEXTAzgWCj95oefqegLz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc26a0a-a80c-4228-0e20-08dc47c16c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:05:25.3532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfjviKz0S+TDswVZkePa6oXrsmnFx62v6dx5TrszNcUURO2pdpyq7KOBDmFxdj79XFHxP712GfK3yxklvatCbEFF3xmzfhu5zCMEqPg678I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7834
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDA0LzExXSB2ZmlvOiBB
ZGQgSG9zdElPTU1VRGV2aWNlIGhhbmRsZSBpbnRvDQo+VkZJT0RldmljZQ0KPg0KPg0KPg0KPk9u
IDIvMjgvMjQgMDQ6NTgsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gVGhpcyBoYW5kbGUgcG9p
bnRzIHRvIGVpdGhlciBJT01NVUxlZ2FjeURldmljZSBvciBJT01NVUZERGV2aWNlDQo+dmFyaWFu
dCwNCj4+IG5laXRoZXIgYm90aC4NCj5JIHdvdWxkIHJld29yZCBpbnRvOg0KPnN0b3JlIGFuIGhh
bmRsZSB0byB0aGUgSG9zdElPTU1VRGV2aWNlIHRoZSBWRklPRGV2aWNlIGlzIGFzc29jaWF0ZWQg
d2l0aA0KPi4gSXRzIGFjdHVhbCBuYXR1cmUgZGVwZW5kcyBvbiB0aGUgYmFja2VuZCBpbiB1c2Ug
KFZGSU8gb3IgSU9NTVVGRCkuDQoNCk1vcmUgY2xlYXIsIHRoYW5rcyBFcmljLCB3aWxsIHVzZSBp
dC4NCg0KWmhlbnpob25nDQoNCj4NCj5UaGFua3MNCj4NCj5FcmljDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0K
Pj4gIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIHwgMSArDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92
ZmlvLWNvbW1vbi5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+Y29tbW9uLmgNCj4+IGluZGV4
IDhiZmI5Y2JlOTQuLmI2Njc2YzlmNzkgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8v
dmZpby1jb21tb24uaA0KPj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+
IEBAIC0xMzAsNiArMTMwLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0RldmljZSB7DQo+PiAgICAg
IE9uT2ZmQXV0byBwcmVfY29weV9kaXJ0eV9wYWdlX3RyYWNraW5nOw0KPj4gICAgICBib29sIGRp
cnR5X3BhZ2VzX3N1cHBvcnRlZDsNCj4+ICAgICAgYm9vbCBkaXJ0eV90cmFja2luZzsNCj4+ICsg
ICAgSG9zdElPTU1VRGV2aWNlICpiYXNlX2hkZXY7DQo+PiAgICAgIGludCBkZXZpZDsNCj4+ICAg
ICAgSU9NTVVGREJhY2tlbmQgKmlvbW11ZmQ7DQo+PiAgfSBWRklPRGV2aWNlOw0KDQo=

