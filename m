Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D0EC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 02:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkEjl-00062U-Le; Tue, 12 Mar 2024 22:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rkEjh-00061G-TJ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:52:58 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rkEje-0007SA-Co
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 22:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710298375; x=1741834375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ERqNx9sXhTLOO3DN+z1CjtxuR7uL/s4S2mtkl6qrYZU=;
 b=XtLaBlEy7477CHpCSUFkCh0HN+S7yAb0aWR3PpBicXKseYYz0vCHxEep
 wNSKqJzFPa/BE5z6J/G+pBQXBuQTej1H1tzh/c0vFvbB8R0oONz3JJCHn
 WEi8DpidVr/Abc4oUnk8I3vBAzCS67PFkaTaPlWUcZaiySbGeNremzSi7
 UZiERYUV795au8sheY4lDIPzNEWVYRo+BY2DA0HJsKXMfoAtU+2Zl2cso
 dTbbb6qPUCcf+MosmPxrvB+hMWXeIoqFkKXNxSgHnD06R9WoWQmRsyNvS
 2EroImbrY8GU/E0EirLwwPMKp3dUfl3jhUlvaq6uKzOzB/axtF+E5MXmX w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22496526"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="22496526"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 19:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11651410"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Mar 2024 19:52:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 19:52:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 19:52:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 19:52:47 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 19:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm3jxymjkUT9XLRDhsFrW0fq/ld+MQI30qUBzTLy9PKP25+wInu73jZINAeOnXaJWzgPLVbLIH3oPqn/Cnd75W0C5LOAGGDj/xVdTpmVhdujhgsilQmnYPfSccWuVcUUXu1dPyw5nPi1UcY3ptuxAYyFV/hGII9eOHydYYXqB4kRf5VcvMAxWzWNPGKeB4yqO6bYbO/ZD63namppBgCEWYQ/AoeqeDNHoUmGW7kp825OFw7i4jriIRdFVc+AzWlIuEEPszTfuhXucAiGAK6HJhcFp6WZcqOF+35cjTm7bsaWVbpes3plJrjI4na34daSr3RCTLqytawAaKAZivrVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWVXHzM1qu0cMoeuJk3abrHSlIg5dc8uVNaCEHdN3bE=;
 b=VAvh3ZfwZVt5j1cpn+DIT14b/xv6ypRbGwg3n0IXT7qYXHPKawvg2dZdBF4zAEGOBRO+uZR5KiXduuXyhin38ElEAA4Fj0Kq2f6QmhcY2GxlM8w4L/vgMwq50FyYnHxm2EDl3heUUqugXCt3L2iv+TukEmtxBS5ron5DcP03862TxMuUi62sOYXZZu0mtSm12DSloeDZv1iDvy/+szShCUNVI/whJFwZxUPi60wl4xM8DAhw+wom7ZiXQFv1KAPFEbQvHnLv461QPtLpsfI1fSiVtKHnGXo/EfrIl1aJSSiTcHYQCqcdHEPfvyO4z5iRRKGqZICA1ktLCGamkaDz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Wed, 13 Mar
 2024 02:52:40 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 02:52:39 +0000
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
Thread-Index: AQHaaisbo2H+re2kM06xKrJPfsjhv7E0ah0AgACay5A=
Date: Wed, 13 Mar 2024 02:52:39 +0000
Message-ID: <SJ0PR11MB67446BFCEC0FFFBC018D70DA922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-4-zhenzhong.duan@intel.com>
 <20240312130058-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240312130058-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7875:EE_
x-ms-office365-filtering-correlation-id: ad0c16e5-3946-436b-b5cc-08dc4308a596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhTYQOflg4lG9IzISqqvHoZcIvUfZoQ3vT9IJGBw03VtIu2pKQOUWinbXQ4CnGKeXbS2r6ppdCIJAOhC8ZMhunPl6T4BSNHst8UewthvfTb3aoNPPLO9EVSfDLpzRB6nwTAEfP80G5Joj/UXJc61IkowV512JimRAKspPW6UqrbqkuVZoUEHSuA55sKyaTlaU8VWUvIGqgNDgqkpP7Yzyft7HjHG052wJFkhsnCdA6wIw9w7PEe/cOvs/nLIQfwzRoIjrCC4aOmxVd8dW3tmJrwLvI+aPF21k0/PhTZFKLr5xitIdtrmrJVutT5A5JwECAG5ZjhJDkJ+dIgoPu7qBJr/35ELWvAZ+GSmNNJ/h7dJwq7k+xp0UDwJQgbCiKCuF/pmyJRHPxL7lsNqiLl8TH2T10D4klM4Ve+IwNjJBsf4N94UZZ/5wvhdU0+79g8PPxNzZMJolib9lr9qjUhkwaGqTiaO9Tk40U1hltSbuIg5kGPbTpWJlKY2ECjmwUevB399gwRGdjSRzqrbpQHG1TFwGxoTStocxz/Mk06NfZUZxNKJ7ic48/32LfbvQzDFZfljnXvd223ebAQsm4FXRYYkUPf5jtKyJIL8zqKxVJOb3Qk1j/Z14Ge81EtNUsswOzC29qrvpaCuDTm5wPhKc9D3p/7/Sy7EJz+i2MMvwqKnFj03sJ/ndgwr+Xgs7JdksYZdqlAwUg/FTpSSNNkco6yEg64cm+f6xHf0H8J05SQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MaY0P/iqPxcFDh/yuGOUOt24HQ9xnztBdcbcvGi8PjELYp7udk5nPgsRBUWV?=
 =?us-ascii?Q?eYSVbvqcrGq81QkY5uW8YN3bjfrUS+reH3phK3cIpIUGb+iYzZlUqT+wSY5t?=
 =?us-ascii?Q?F7+04E2aFClqCXpkh5+EqHjENjbmb90BR/sMryCBBm3skGdoB5/ctPtNm1n0?=
 =?us-ascii?Q?IG+GsZnNOqdN92xZ90nt3jLGxdfQo1bZYxJaGdpDVSh5/A9EsUyrRU/jGjl0?=
 =?us-ascii?Q?9R/FngFlFU5yBLThjnKM5hJvYtitb70MhOcq3p5Ox8zSVNirdFW/P5obSnW6?=
 =?us-ascii?Q?qZnATksQwgHmt3Y5ePtEPYUWbuV7wr+cX3gTnOcu+lfWlirAT18pHR9iyXg9?=
 =?us-ascii?Q?ESvAq37IEXbeiKsIm5tRRr+NyRQDTIAS2VosCkuBojRB1q8PIxDWZds7gnFa?=
 =?us-ascii?Q?xyNzY3I6XFrYTnLfAyTlRWN36KPvg4wp3XvgAtBYuCfMLD6GAT5x8g0YuvY3?=
 =?us-ascii?Q?ZfIcteafGwmL1FOpt2N0+Rfscd36EaJGKacIUSl1NdHSGT1RQ9QcWiRF6hl9?=
 =?us-ascii?Q?MvJHhMBIGsxjzT3cjsV/6+t4+vaO8rFcDdCWoPt1RUjo3F3kUouhNjUbkN2Y?=
 =?us-ascii?Q?2pTv+QoUO3/nONgRCFlkcvv2lq80h9jOcPf7l2wo91n6YMYCbDk3H7Jwkd0W?=
 =?us-ascii?Q?5ZG4eeVQFwlFr5N9AhaokdmwkVOZQod6u0tuhouo9ILeFCQeZ29X8l/xtlz/?=
 =?us-ascii?Q?I0nlr6O7wVnYw42E3qjvlv/ka0gvsLElsQopcGTB7BTxOLtdYyd0L7QpJ7RP?=
 =?us-ascii?Q?DmBCd8/pFk4CEUlVdkLwCTZpEnXYTuQHdQAbGULw1rKKTZoIWdRXiTyGVMz3?=
 =?us-ascii?Q?KybXKWjxa60zj8PF0mouhHk8hm7bjRR+bDUILhwVuhR9jm6bmbWQ8Wdy/ziD?=
 =?us-ascii?Q?Cypi7CtKr48vK1qhr1czmjgVNttkayEstV9KmX2rnbcsbwANqo4O1S2bxT8K?=
 =?us-ascii?Q?dsa80eFAP314D1GAPVwMiTGFdRLVJfADSl3FcT4nrhdebHW2lHF5PZhsrCPl?=
 =?us-ascii?Q?pm39MA3ToyPTbiolnpMTE70Bm9hb69vT5DC/ELl6P7asbCpW37mx2paRq6Wh?=
 =?us-ascii?Q?rHYWOa+FB/9fSEW+YAGgPdEUv5qZ9zb+qaOUuCU6VmSaX4WFi7hQOg2JP8TS?=
 =?us-ascii?Q?cFQzQzmBzmZ9mpNB1kA/y+uzCwDxWatwqvjSI+b+o/sGoIqbuTB2PeVKDs27?=
 =?us-ascii?Q?h2CvPT5PE5Xzf0hsRiPGx9p3Iqc3+Ut2bTlSDnX9KhhDQ77iSrT4IK28dmWp?=
 =?us-ascii?Q?RRU5sH0fLOmahohkr5gWP4KpXMtv4nOVin0j1ThM2TCXvVdk7I9c4RpvWJwG?=
 =?us-ascii?Q?aantRRGX7cQRMdsIM9MQfNlIlsQrOB+ffd7BFlkjV61OqaBFd/2WpJh/i3bo?=
 =?us-ascii?Q?1zaSWosZc5KfjZevNq/6rpuEq282jVGjdOrR7hMHlx7s8L6HWacM4n3cnsJj?=
 =?us-ascii?Q?LReVJ3owax9MLNV2dZ4oubhth+jXOi3spquUrGFRjvMdSd+GbRvd/SWTmD5y?=
 =?us-ascii?Q?SmCDU3jeKWEJXQsY2eB2uL8lMR24a0Juwxzk10BDJDD33YNExX+LGRroD0v8?=
 =?us-ascii?Q?vJrDUKh11HDYmfd1ImzWjPmEQ3tNw48tfoEaEjVI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0c16e5-3946-436b-b5cc-08dc4308a596
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 02:52:39.6336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GM/hItX007bRTjiCUmfoCsZtxhOX/LKckpQnkrM9BWg69h59yWNqjAQAIUB3sqe106NbpkkHJSztqOgEDuLm6RwhlXOO1LWf09pAe1A7b4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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

Hi Michael,

>-----Original Message-----
>From: Michael S. Tsirkin <mst@redhat.com>
>Subject: Re: [PATCH v1 3/6] intel_iommu: Add a framework to check and
>sync host IOMMU cap/ecap
>
>On Wed, Feb 28, 2024 at 05:44:29PM +0800, Zhenzhong Duan wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>>
>> Add a framework to check and synchronize host IOMMU cap/ecap with
>> vIOMMU cap/ecap.
>>
>> The sequence will be:
>>
>> vtd_cap_init() initializes iommu->cap/ecap.
>> vtd_check_hdev() update iommu->cap/ecap based on host cap/ecap.
>> iommu->cap_frozen set when machine create done, iommu->cap/ecap
>become readonly.
>>
>> Implementation details for different backends will be in following patch=
es.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/hw/i386/intel_iommu.h |  1 +
>>  hw/i386/intel_iommu.c         | 50
>++++++++++++++++++++++++++++++++++-
>>  2 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/i386/intel_iommu.h
>b/include/hw/i386/intel_iommu.h
>> index bbc7b96add..c71a133820 100644
>> --- a/include/hw/i386/intel_iommu.h
>> +++ b/include/hw/i386/intel_iommu.h
>> @@ -283,6 +283,7 @@ struct IntelIOMMUState {
>>
>>      uint64_t cap;                   /* The value of capability reg */
>>      uint64_t ecap;                  /* The value of extended capability=
 reg */
>> +    bool cap_frozen;                /* cap/ecap become read-only after =
frozen */
>>
>>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>>      GHashTable *iotlb;              /* IOTLB */
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index ffa1ad6429..a9f9dfd6a7 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -35,6 +35,8 @@
>>  #include "sysemu/kvm.h"
>>  #include "sysemu/dma.h"
>>  #include "sysemu/sysemu.h"
>> +#include "hw/vfio/vfio-common.h"
>> +#include "sysemu/iommufd.h"
>>  #include "hw/i386/apic_internal.h"
>>  #include "kvm/kvm_i386.h"
>>  #include "migration/vmstate.h"
>> @@ -3819,6 +3821,38 @@ VTDAddressSpace
>*vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>      return vtd_dev_as;
>>  }
>>
>> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
>> +                                 IOMMULegacyDevice *ldev,
>> +                                 Error **errp)
>> +{
>> +    return 0;
>> +}
>> +
>> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>> +                                  IOMMUFDDevice *idev,
>> +                                  Error **errp)
>> +{
>> +    return 0;
>> +}
>> +
>> +static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice
>*vtd_hdev,
>> +                          Error **errp)
>> +{
>> +    HostIOMMUDevice *base_dev =3D vtd_hdev->dev;
>> +    IOMMUFDDevice *idev;
>> +
>> +    if (base_dev->type =3D=3D HID_LEGACY) {
>> +        IOMMULegacyDevice *ldev =3D container_of(base_dev,
>> +                                               IOMMULegacyDevice, base)=
;
>> +
>> +        return vtd_check_legacy_hdev(s, ldev, errp);
>> +    }
>> +
>> +    idev =3D container_of(base_dev, IOMMUFDDevice, base);
>> +
>> +    return vtd_check_iommufd_hdev(s, idev, errp);
>> +}
>> +
>>  static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int
>devfn,
>>                                      HostIOMMUDevice *base_dev, Error **=
errp)
>>  {
>> @@ -3829,6 +3863,7 @@ static int vtd_dev_set_iommu_device(PCIBus
>*bus, void *opaque, int devfn,
>>          .devfn =3D devfn,
>>      };
>>      struct vtd_as_key *new_key;
>> +    int ret;
>>
>>      assert(base_dev);
>>
>> @@ -3848,6 +3883,13 @@ static int vtd_dev_set_iommu_device(PCIBus
>*bus, void *opaque, int devfn,
>>      vtd_hdev->iommu_state =3D s;
>>      vtd_hdev->dev =3D base_dev;
>>
>> +    ret =3D vtd_check_hdev(s, vtd_hdev, errp);
>> +    if (ret) {
>> +        g_free(vtd_hdev);
>> +        vtd_iommu_unlock(s);
>> +        return ret;
>> +    }
>> +
>>      new_key =3D g_malloc(sizeof(*new_key));
>>      new_key->bus =3D bus;
>>      new_key->devfn =3D devfn;
>
>
>Okay. So when VFIO device is created, it will call vtd_dev_set_iommu_devic=
e
>and that in turn will update caps.
>
>
>
>
>> @@ -4083,7 +4125,9 @@ static void vtd_init(IntelIOMMUState *s)
>>      s->iq_dw =3D false;
>>      s->next_frcd_reg =3D 0;
>>
>> -    vtd_cap_init(s);
>> +    if (!s->cap_frozen) {
>> +        vtd_cap_init(s);
>> +    }
>>
>
>If it's fronzen it's because VFIO was added after machine done.
>And then what? I think caps are just wrong?

Not quite get your question on caps being wrong. But try to explains:

When a hot plugged vfio device's host iommu cap isn't compatible with
vIOMMU's, hotplug should fail. Currently there is no check for this and
allow hotplug to succeed, but then some issue will reveal later,
e.g., vIOMMU's MGAW > host IOMMU's MGAW, guest can setup iova
mapping beyond host supported iova range, then DMA will fail.

In fact, before this series, cap is not impacted by VFIO, so it's same effe=
ct of
frozen after machine done.

>
>
>I think the way to approach this is just by specifying this
>as an option on command line.

Do you mean add a cap_frozen property to intel_iommu?
Vtd_init() is called in realize() and system reset(), so I utilize realize(=
) to init cap
and froze cap before system reset(). If cap_frozen is an option, when it's =
set to
false, cap could be updated every system reset and it's not a fix value any=
 more.
This may break migration.

>
>So if one wants VFIO one has to sync caps with host.
>No?

Yes, check for compatibility. But it's not preventing the usage of VFIO
with vIOMMU, it finds the incompatible issue earlier and fail hotplug inste=
ad of
surprising guest driver failure.

Thanks
Zhenzhong

>
>
>
>>      /*
>>       * Rsvd field masks for spte
>> @@ -4254,6 +4298,10 @@ static int
>vtd_machine_done_notify_one(Object *child, void *unused)
>>
>>  static void vtd_machine_done_hook(Notifier *notifier, void *unused)
>>  {
>> +    IntelIOMMUState *iommu =3D
>INTEL_IOMMU_DEVICE(x86_iommu_get_default());
>> +
>> +    iommu->cap_frozen =3D true;
>> +
>>      object_child_foreach_recursive(object_get_root(),
>>                                     vtd_machine_done_notify_one, NULL);
>>  }
>> --
>> 2.34.1


