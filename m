Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5BBC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 07:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkJRa-00050U-Cv; Wed, 13 Mar 2024 03:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rkJRX-00050D-QY
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:54:31 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rkJRU-0005dV-No
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710316469; x=1741852469;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Kbg+PyfIgOh9fvNY5Ghm9jexZnJhR2E1HntOhq5h2bo=;
 b=F1/90wc6Q7nVVdlvEPwpjhbjJCZhbixDaBD0WPMFJIAvSqozzsswKtoa
 rKZKOpuM0/rZOkyQpHQPrQZ1OTu29QJvdNsEUDyVpb/kYVBGs2LBBLkQw
 0+4mYJn3cFeonwqQKTt33yInvko+FJH98tTTAZ4cWyJlFDG7dG36W4bsr
 dacfu1rlnXy5VZcJIYYJuFtSI/9p+JWWjMArhJ6z5o5GKv8De0rwzShSF
 MXoflkFeH5WqFHQTvlU0oZF0oXObN/q5SZ4od1nuoZ94/dsSadaIyvjGY
 z9kat4/d5rPRao7Ajn9YDRm8ZjL26ZQK0DUO2DTxqY8nomXcrH90uUpfg g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4921172"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4921172"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2024 00:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16306523"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Mar 2024 00:54:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 00:54:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 00:54:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 00:54:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRyidkvY8CWmCgf9XF8i0CiI2169Bk3AMMenwQM712hpyvEaMyImsuR4ySFw8YBeTbfkRj2uBRul54bFTEA7CPuAOlMGsik5moJxcae6ONujHwzXmo2hJMOzc8fvYJXqXB1+E9GUtSuO8Jwgush2mtdpOSUNR2IkeTY+hQMdHHqX7ndPqnM6t03yMJ17fWepviCcNSiin9R/IeQ7Yxo3LOB2VHZoygb8LTNMsjt7PMceouArn9eUrmRslOFepwR/iR/4NQYG/AWC9zqbsZ6gl9zGdCmyKPVhl1E38MbxntR/9IQsUKZ8zO7UpYkIQwCQlyCaj55sT4j8hdB9yUqCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XT17iOR61iiAn4wXm9w7SZlZMocHUpXMb9mgIyz2lk=;
 b=d1goRsCCrVDvF5yB0SIWnAxaRyKpWrbjL90bMlzwsWayf/0TpkHkF7FRdUDfLEvNUcvuADo3Q/7X/W8TlawUKvUlYeTOezQdMIbTEu3YaAd52CkOsb7LRCKCreKgRcqBw4CMTBSikHPpTWaYeWIxge6aRWMtopXLQjqSOJYudkNNeoU24W4AEoyDhBJ/IADANt9hnNhE4Ktk3lQHcrlBV6GByk/rbRkD1DEYu526X8LABr1EePWNPSakgngss6U7rAlm/H7nT31PJIzatsBG+a7+AhQmvOprH6r009/xap6NYyGcUd4W75HTLBQahdjgEK/VFyrcDktcu/uB9pbueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB6420.namprd11.prod.outlook.com (2603:10b6:208:3a8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 07:54:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 07:54:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v1 3/6] intel_iommu: Add a framework to check and sync
 host IOMMU cap/ecap
Thread-Topic: [PATCH v1 3/6] intel_iommu: Add a framework to check and sync
 host IOMMU cap/ecap
Thread-Index: AQHaaisbo2H+re2kM06xKrJPfsjhv7E0ah0AgACay5CAAFDoAIAABZmg
Date: Wed, 13 Mar 2024 07:54:11 +0000
Message-ID: <SJ0PR11MB6744F2805D8EF6722C725DAC922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-4-zhenzhong.duan@intel.com>
 <20240312130058-mutt-send-email-mst@kernel.org>
 <SJ0PR11MB67446BFCEC0FFFBC018D70DA922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240313030303-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240313030303-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB6420:EE_
x-ms-office365-filtering-correlation-id: ff920b6f-ad9a-4581-4414-08dc4332c511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u48sh7UXlNYZ7U/jkz7FFdNBmeyIAizlJMq3oOb1Z3AHgRvGRXEUKrtR1FtuRLeQ377hrgLiuAaNdxt8KVghEN9+SH+mRkUBKiB+DoDpZhELAMyCfnTI3mty3cQXhxA2MLr/Gv9iMJK4M3PigEselgTQhiINDXIO+3SzN5QdddpQiIYf43SVnhwEWJ5WMHs77kv9+40GD6EzabdpAuhSO2vdqrpNjcLHJrae++GmbCqKz0E6EAK5rsrGv0XkFh/E/nDSvdVi6lXa3+KmplW8xpRXzJiqhdZehXi9E5GcjE/mqLWlTMEhLgmVpyUFmV1VJmZhQOwZl9KmDwotoJwh560vpA/t1duG4QhQ2BMaSWqtby4x42fpoxUOCAFjWJ4IrYz2l68W64pGNiA7x83s/ksae8vLzHslCb4OyFyS4LMYbplF6JdTyRuAghXLVtcMbprKwKonj4TLHX1w+sdgY7VIe1k2gSw941YlHDoIvNWoWZR8clnnDKqeOMVbecXhahtaRoudxXgklA+41vMnfvHrr5od2LlsPRc027KIU5ud7skvP9WLmiuM9ca1a8VeRgAxRs+GUk16ZuNBvxcIb47abZPs69/OBdUKVUPEDNtb2jCTyyaTXIt/gxHXze/7cKnj7iprJdJvCqdcD2l6xQ7FutB3cZpgLIy45OmjZQ+v2Cfe2vLQHlMKTqb0O7a/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GN9bboLoV2XmwgUCB+CTYTlttN3tY++lNMFAQSpmbcnRoksMtt+51tkRWE1O?=
 =?us-ascii?Q?pk7TIveyTGxtQRbOBeEcsrqNsrQkPDpm6gl4byPc9LnBwxnwhrf+H2LgvIGG?=
 =?us-ascii?Q?oCBDhCUTE3ouUzex8nifyDKcW70wtVr/vrmJfinCy5NgKvJ4bvTKS4SIxyZk?=
 =?us-ascii?Q?/T20gVOYnobBW2+AYB49qkEnNHZR+POh9LeMu1WjGsJzjUTBOY80Cere2bNG?=
 =?us-ascii?Q?y0+Yv7x5B5nQ8k04ub6CudR4rWTvvuWZxtVCAB/VsHbdKu3O/FoXPZzmwo+J?=
 =?us-ascii?Q?QT70abCQfti+jDPzPfVanDYMMxKMoKuseeHG0dFHzrYmZkhY8yrzMuFyO8t/?=
 =?us-ascii?Q?nogz+/2k732tIYx+1BL0AAHTGLfRzBfIYLMKz6lZFOhQ9v+NXkQagKgB4Vjl?=
 =?us-ascii?Q?k392RRtxfijCNDgH+fPkppyER1H6MEMxCmpXe6jvmWVSrnzXcO1bXZ2C75Y3?=
 =?us-ascii?Q?tR8mWlo47CizfF/IHycgE88KCOWCrdaBnU8mMlxQlH//b8DD8jWpuGqzDs22?=
 =?us-ascii?Q?3hG10/fYfVTdaQdomqpkUgDSmq3OUYgsMSYNql2QQJkiP+hvr1ezZE9mCWC2?=
 =?us-ascii?Q?bH5SXEpoIizb6Xp8DH9kPiTiW/sB1QCXmOaDcgcG25OL6cwKaofgMPxctueF?=
 =?us-ascii?Q?7ev+lD4v1rndFvnOp+/IfwV6r+HiH2mN1wVLkYi8cXp/05uGsSf+Tu5atgQE?=
 =?us-ascii?Q?dox4jdnMPsY17KsqmlNbWxYeiPjnVQS90s3ObL2PpAVYZUrKyJCD1lXEzaID?=
 =?us-ascii?Q?6y1pdcV7X2HbaGw4rJfQnVO9k5VDAOCEaFc6IrSBnEaVSH2yALbgBpnseP7y?=
 =?us-ascii?Q?g3gqvM7bDcfcuZx1OLGlsKQUaJrsI5lyafQpB6d+Nz4PMOMEovYqN01SXWSL?=
 =?us-ascii?Q?CqhDqwKoNM7VLlRXhbR3ZFIh7cWaVKbHi97cOaT+EJSfVOColPDruisODOU7?=
 =?us-ascii?Q?hy+tSb+H6PyOHnXEyuaHjPw0arrGBcyimkFnLbicpJ1WqPYBJvt89oEOQ/1E?=
 =?us-ascii?Q?38+GAO/07PY8wb7akzB0o547ZUq/+QOaHLfhEuGvo7lzW6ZfQtNtxg1ADInQ?=
 =?us-ascii?Q?NgFv+GeaFfxgc8YFvIK4qAYx6PWh0/8uh3XiONQ17BI9Nq1R2WeTWqbfBYdd?=
 =?us-ascii?Q?RPwclNAnuYCbNPJy01/VxqbQU0py6L4BqM3dRNu5nw6nEk0uU3g2uMoIb6A3?=
 =?us-ascii?Q?GUbBq+paFu2+4now/8y4+XRxAuepNGnXvEHspErzmNsRF/5MzOddcpGO9Se3?=
 =?us-ascii?Q?2Y2QBfMoHiDeDKYTJ2RIJoOn7PeJAzL7WaEGNsGUWr2NTW5D9TKJbc+z6KPz?=
 =?us-ascii?Q?EF2aTh5WGHKwPE+j9McWE/eJzdmCqEPgR1/0ipVG+J2B2gilAPP75Uep4oBO?=
 =?us-ascii?Q?c/z+/QNGJmjUH91JijbMIbNok9K62gWpClva/lM0+ZTWKMF964AEIzLe44ql?=
 =?us-ascii?Q?AfJPPONOECewHuWWAgS6jimOkO8fFRRCXoVA3PMiP7IFRlXR4FM9DHO4sEjo?=
 =?us-ascii?Q?qZe1kh6yPy36/h4e+UNOW7yvcCMYOgwoktc1a/iz9Y1vRlsUVzB/s/RjBly/?=
 =?us-ascii?Q?Vgbl+p4Hc5gBEmT/l/K4vuniF2xPFGa8Yc+hBuLP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff920b6f-ad9a-4581-4414-08dc4332c511
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 07:54:11.2849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pixnNXbfPpFok2MD/98TPWwl3Coms4bSTquKH+X5ESI7gF2Rv2AoJn7ocyRTPiQdaRHO+B56aCKSboQaLCIR/KZOs2+jwzp4nwgZppOyolo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6420
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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



>-----Original Message-----
>From: Michael S. Tsirkin <mst@redhat.com>
>Subject: Re: [PATCH v1 3/6] intel_iommu: Add a framework to check and
>sync host IOMMU cap/ecap
>
>On Wed, Mar 13, 2024 at 02:52:39AM +0000, Duan, Zhenzhong wrote:
>> Hi Michael,
>>
>> >-----Original Message-----
>> >From: Michael S. Tsirkin <mst@redhat.com>
>> >Subject: Re: [PATCH v1 3/6] intel_iommu: Add a framework to check and
>> >sync host IOMMU cap/ecap
>> >
>> >On Wed, Feb 28, 2024 at 05:44:29PM +0800, Zhenzhong Duan wrote:
>> >> From: Yi Liu <yi.l.liu@intel.com>
>> >>
>> >> Add a framework to check and synchronize host IOMMU cap/ecap with
>> >> vIOMMU cap/ecap.
>> >>
>> >> The sequence will be:
>> >>
>> >> vtd_cap_init() initializes iommu->cap/ecap.
>> >> vtd_check_hdev() update iommu->cap/ecap based on host cap/ecap.
>> >> iommu->cap_frozen set when machine create done, iommu->cap/ecap
>> >become readonly.
>> >>
>> >> Implementation details for different backends will be in following
>patches.
>> >>
>> >> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> >> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> >> ---
>> >>  include/hw/i386/intel_iommu.h |  1 +
>> >>  hw/i386/intel_iommu.c         | 50
>> >++++++++++++++++++++++++++++++++++-
>> >>  2 files changed, 50 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/include/hw/i386/intel_iommu.h
>> >b/include/hw/i386/intel_iommu.h
>> >> index bbc7b96add..c71a133820 100644
>> >> --- a/include/hw/i386/intel_iommu.h
>> >> +++ b/include/hw/i386/intel_iommu.h
>> >> @@ -283,6 +283,7 @@ struct IntelIOMMUState {
>> >>
>> >>      uint64_t cap;                   /* The value of capability reg *=
/
>> >>      uint64_t ecap;                  /* The value of extended capabil=
ity reg */
>> >> +    bool cap_frozen;                /* cap/ecap become read-only aft=
er
>frozen */
>> >>
>> >>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>> >>      GHashTable *iotlb;              /* IOTLB */
>> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> >> index ffa1ad6429..a9f9dfd6a7 100644
>> >> --- a/hw/i386/intel_iommu.c
>> >> +++ b/hw/i386/intel_iommu.c
>> >> @@ -35,6 +35,8 @@
>> >>  #include "sysemu/kvm.h"
>> >>  #include "sysemu/dma.h"
>> >>  #include "sysemu/sysemu.h"
>> >> +#include "hw/vfio/vfio-common.h"
>> >> +#include "sysemu/iommufd.h"
>> >>  #include "hw/i386/apic_internal.h"
>> >>  #include "kvm/kvm_i386.h"
>> >>  #include "migration/vmstate.h"
>> >> @@ -3819,6 +3821,38 @@ VTDAddressSpace
>> >*vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>> >>      return vtd_dev_as;
>> >>  }
>> >>
>> >> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
>> >> +                                 IOMMULegacyDevice *ldev,
>> >> +                                 Error **errp)
>> >> +{
>> >> +    return 0;
>> >> +}
>> >> +
>> >> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>> >> +                                  IOMMUFDDevice *idev,
>> >> +                                  Error **errp)
>> >> +{
>> >> +    return 0;
>> >> +}
>> >> +
>> >> +static int vtd_check_hdev(IntelIOMMUState *s,
>VTDHostIOMMUDevice
>> >*vtd_hdev,
>> >> +                          Error **errp)
>> >> +{
>> >> +    HostIOMMUDevice *base_dev =3D vtd_hdev->dev;
>> >> +    IOMMUFDDevice *idev;
>> >> +
>> >> +    if (base_dev->type =3D=3D HID_LEGACY) {
>> >> +        IOMMULegacyDevice *ldev =3D container_of(base_dev,
>> >> +                                               IOMMULegacyDevice, ba=
se);
>> >> +
>> >> +        return vtd_check_legacy_hdev(s, ldev, errp);
>> >> +    }
>> >> +
>> >> +    idev =3D container_of(base_dev, IOMMUFDDevice, base);
>> >> +
>> >> +    return vtd_check_iommufd_hdev(s, idev, errp);
>> >> +}
>> >> +
>> >>  static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int
>> >devfn,
>> >>                                      HostIOMMUDevice *base_dev, Error=
 **errp)
>> >>  {
>> >> @@ -3829,6 +3863,7 @@ static int
>vtd_dev_set_iommu_device(PCIBus
>> >*bus, void *opaque, int devfn,
>> >>          .devfn =3D devfn,
>> >>      };
>> >>      struct vtd_as_key *new_key;
>> >> +    int ret;
>> >>
>> >>      assert(base_dev);
>> >>
>> >> @@ -3848,6 +3883,13 @@ static int
>vtd_dev_set_iommu_device(PCIBus
>> >*bus, void *opaque, int devfn,
>> >>      vtd_hdev->iommu_state =3D s;
>> >>      vtd_hdev->dev =3D base_dev;
>> >>
>> >> +    ret =3D vtd_check_hdev(s, vtd_hdev, errp);
>> >> +    if (ret) {
>> >> +        g_free(vtd_hdev);
>> >> +        vtd_iommu_unlock(s);
>> >> +        return ret;
>> >> +    }
>> >> +
>> >>      new_key =3D g_malloc(sizeof(*new_key));
>> >>      new_key->bus =3D bus;
>> >>      new_key->devfn =3D devfn;
>> >
>> >
>> >Okay. So when VFIO device is created, it will call
>vtd_dev_set_iommu_device
>> >and that in turn will update caps.
>> >
>> >
>> >
>> >
>> >> @@ -4083,7 +4125,9 @@ static void vtd_init(IntelIOMMUState *s)
>> >>      s->iq_dw =3D false;
>> >>      s->next_frcd_reg =3D 0;
>> >>
>> >> -    vtd_cap_init(s);
>> >> +    if (!s->cap_frozen) {
>> >> +        vtd_cap_init(s);
>> >> +    }
>> >>
>> >
>> >If it's fronzen it's because VFIO was added after machine done.
>> >And then what? I think caps are just wrong?
>>
>> Not quite get your question on caps being wrong. But try to explains:
>>
>> When a hot plugged vfio device's host iommu cap isn't compatible with
>> vIOMMU's, hotplug should fail. Currently there is no check for this and
>> allow hotplug to succeed, but then some issue will reveal later,
>> e.g., vIOMMU's MGAW > host IOMMU's MGAW, guest can setup iova
>> mapping beyond host supported iova range, then DMA will fail.
>>
>> In fact, before this series, cap is not impacted by VFIO, so it's same e=
ffect of
>> frozen after machine done.
>>
>> >
>> >
>> >I think the way to approach this is just by specifying this
>> >as an option on command line.
>>
>> Do you mean add a cap_frozen property to intel_iommu?
>> Vtd_init() is called in realize() and system reset(), so I utilize reali=
ze() to init
>cap
>> and froze cap before system reset(). If cap_frozen is an option, when it=
's
>set to
>> false, cap could be updated every system reset and it's not a fix value =
any
>more.
>> This may break migration.
>
>No, I mean either
>1. add some kind of vfio-iommu device that is not exposed to guest
>   but is not hot pluggable

Not quite get, what will such vfio-iommu device be used for if not exposed =
to guest.
If we just want to avoid vfio device hotplug, we can use
TYPE_VFIO_PCI_NOHOTPLUG device. But even if we use coldplugged
vfio device, we will face same compatibility issue of vIOMMU caps vs. host =
caps.

>
>or
>
>2. add a property to specify ecap, rely on management to set it correctly

Yes. This deep customization could works, but I think it's difficult to tea=
ch user
about how to set each bit in cap/ecaps.

>
>
>> >
>> >So if one wants VFIO one has to sync caps with host.
>> >No?
>>
>> Yes, check for compatibility. But it's not preventing the usage of VFIO
>> with vIOMMU, it finds the incompatible issue earlier and fail hotplug
>instead of
>> surprising guest driver failure.
>>
>> Thanks
>> Zhenzhong
>
>
>I don't see where the check for compatibility and hotplug failure are.
>Did I miss it?

There is some check code in patch4, see https://lists.gnu.org/archive/html/=
qemu-devel/2024-02/msg06419.html

And more widely used in nesting series's patch6, see https://lists.gnu.org/=
archive/html/qemu-devel/2024-01/msg02746.html
I have not sent a new version of nesting series yet, but the code related t=
o caps check/sync will be
similar.

Thanks
Zhenzhong

