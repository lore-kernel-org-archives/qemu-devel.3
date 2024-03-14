Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBDEC54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 04:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkcLO-0000Y8-AJ; Thu, 14 Mar 2024 00:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rkcLK-0000W3-Ri
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 00:05:23 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rkcLH-0003yL-VJ
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 00:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710389120; x=1741925120;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U+5xcGwksgbb3L43iXx8VRo0QHTVvZFCKpxXRtEhfw8=;
 b=RWsJ7DnLz5+fJG8juhtPx/HJtpOu56atODjx+C77AUBnasT5PyqCv0P4
 9uC7j4MF8LWD1bpF8MsHvKO1gBDKw8kipBu+wXesPUl6H+UK0GKDZfk2V
 Ethtz7xZ3l9PwvlFlJPCDCCEzeZoOewEUC370c1wV67aAHNdLRPj+QrnB
 yRDR7aPb+AIiGFsyOG7i1SjJqRLFfoisCd4v5IurteVrEUHZNWAmPYIiT
 9UGycbSgSoFhq48jrKqqqgVq4tvJSD1w+6HSN9OlQ6AGWCH/ivbnWFr5j
 SlQO4X6h48bg5/bTZsILgrFoAEggb0KawrWUGXsug4V40k8/6Ha9OL/Vy g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5044889"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="5044889"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2024 21:05:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; d="scan'208";a="12092091"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Mar 2024 21:05:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 21:05:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 21:05:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 21:05:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/9perT3yRAuY5mUhdprmsLPYVgLAIxZc8xZlaKXRoEzc0jiZBOF8rCtnxeN3CXykSkD49+5B2rOuixnUd8HsFW1e6Wfyv1nfTWzS1p1IqM7Gixm+x+oUqc5qoLW0nTCBJ8mI0P0Lppg91iSF7qj7GawU2nRIg0oH4FJ9e3DynwIybHjA/y9EzL3iYGpB0CYuPhQSEyk8/Qteb4Vo17aGY6iAl5OxMF/r0ZSjwyw5DzYWHDfBX5+IngC2eEUb+oI0YIVKZmJL/IzlZ4uEVOi7mJLh7c5uUwjQZlSxER3l3ys58H13wrvnh1RYDEsbbTig6TGes0EyO1h8cRqxTq+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAd8O7DaJkFPpo/oS/5YmRqAiTzjBPJIIj0lnDK1a1U=;
 b=FqN4M9bNCYuN56oSV75DXYG2n6pY0p96DE9Oq6kFxKsHp+PEHZGKTX56GimP+CPxTkPomtbvtZZ1KvrrrvEY3f3cdNKc6QDO302waLmfjtoMeRcppZQ5Qqd9MVGOYBimwk1sQusoAU5W6OwzuZ95LsWgZU8YyRZ45C6uT4Oitb0jE2snb8LYwzpAydGrgtnPC7HuYSK6ZCr5Ltd5s6koiVK50K9LJI0++PeaepGyIgfkb1G/DZP+a2kLfPr9BRNXTIDYht71QQCbMBymtyE4n+T6wemvhjMh5YL97MAuZtDv/rXTIosieUHXTvgFgiFSaQh6Lpx9QiIzODduiVljGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8705.namprd11.prod.outlook.com (2603:10b6:610:1cc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 04:05:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 04:05:10 +0000
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
Thread-Index: AQHaaisbo2H+re2kM06xKrJPfsjhv7E0ah0AgACay5CAAFDoAIAABZmggABAY4CAARH34A==
Date: Thu, 14 Mar 2024 04:05:10 +0000
Message-ID: <SJ0PR11MB6744C09DA5405DB89C8D7C0D92292@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-4-zhenzhong.duan@intel.com>
 <20240312130058-mutt-send-email-mst@kernel.org>
 <SJ0PR11MB67446BFCEC0FFFBC018D70DA922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240313030303-mutt-send-email-mst@kernel.org>
 <SJ0PR11MB6744F2805D8EF6722C725DAC922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240313071647-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240313071647-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8705:EE_
x-ms-office365-filtering-correlation-id: fe4e0260-3a7f-4765-28be-08dc43dbf118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lS++K+44ssF4Dcg+urcw+M2A4oVtBrTAx9pA1Vp/qzDAX1X4I+8KPYjC1bZ2xNyNiDMaFWOr3oEmrddI65uKEz0YQuc4E6L97+L7VN9WgE/WageJlameFh9ZqRMJm3K1WGSHOquX2K8FOiBw7zQ9eLhsGUPsv6ic7FTef2nFvpIWvM/Nmy0uNDHsd9JxTdwKmHjWvNQqfxAOUY0241qwHvsjyJYnbV39ccFS3HEYgklGNAtnaP0rQsi/XmMgI2tVneipmD7bm4LWhY2BcPMeDaeWROu1Y1aiNOygNWUc6okVMPO60dtc3NTy7AiyORkcahSSvP6Oqupra3qVZHXtwxLgig0vxtS70Rg70sH2lc/ZKsyE24+/BSlFwKGpHSnls1gCh5fdeFEk6RPZ0Wi2vz/jd2kh3aE6WljA9eIn28JBfNQBRnhI4nw/5CTJkYrME7SWc3+6Xen4XwtOckez+yPPhp9NA6f3vgQZ5GubOEzg05u4JrZTKHP/QLEHySeAJkPhuXfr2y9uTCpDrqiVraD7O0did/TW0lKpvf7peOYRw4/jx7QLxuKJhrX3c4TmC0YL+cw2pLJ+VWP4v+EFHQZ6Z8iC1AEMjrSb56fRCKNy44wKJD4nc6DNxUGtOcvgVgsNfFNtX1bxU/6lSobS2WL3sfIB+rEC9B9gpmWt+VlcKfPZKw/Rd8PcEwSwlAjsJoVVofuuMr9niviG1fJnDQbat5d3VWovFs5jpJBlhRE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YreHc6BYP10vSJvilW9RT3+dfVUomNz5uxmtHdf/6yCiIB7TA9Xhy10dCWtW?=
 =?us-ascii?Q?bcVSmb16BbiiGG7REx5NmzOVK/fo2lEulj1rABHBrnH43UcZa75VUl7/pLNM?=
 =?us-ascii?Q?4WZlB/t4qY9NB4se+Sf4Xt9qtGNGXrQqrrwo+sINvTGlaV/YGP8XEu3ucDio?=
 =?us-ascii?Q?phCppbVKBYTXUBrMG/Mmy2yY+xPUyAZnaMh4ohpEWN1tvovMq5z/bfgXCbFR?=
 =?us-ascii?Q?jNqb1VF8cn8MKMI0hcR+EBuG3izsoP3I0u2AuN7RaoUXLWBXOQ5WAYnzq81W?=
 =?us-ascii?Q?sZOvLM8GwDwKGF79yXFpm/dn93gGwZh2aFZ+vmGlYxCiccXL3AToN1Xtgje6?=
 =?us-ascii?Q?CWHT29BoY+F6jy9R8dzDUsqwLkrvFhEyRX4jFOTdsX2AKsYp0k4mhZOpMX3T?=
 =?us-ascii?Q?zWHOd+EuhF66WISt7j2qo6fQIVeAMsI4hGMYAYcvrK2vwM2ztggXxJ6DaXX8?=
 =?us-ascii?Q?l1gcQo2CXLVwBiwCN22Iwve1jckGMWGDTCjsigC9nC1+cDpBKYbzDfL6kU6A?=
 =?us-ascii?Q?9I1/JuHbWLaxeElrbaVtNxru5Ona1W1jvmdIlrS8Ay+1Y4tyTyEmB0/gTt0U?=
 =?us-ascii?Q?H4R60iEydtLY9GeRanr+4Q7tKhx4FneoWrbFgLvH7p2uSrrqn/X3ypJg/boe?=
 =?us-ascii?Q?VCeU1IuWpGXvqX8pbrSsPI+2Uuh6CQB/nxjfJgDvGGtGpwH1vN/On+zA4wcC?=
 =?us-ascii?Q?X0et+UFeKk0TByO5OCjApJcJYS2XfyCeIIAWAO/cbMilwBVcRwDb7Estqylc?=
 =?us-ascii?Q?D0l8K7FCb1ZnWTpKJluX/kHBJcPwGQfEjULoFN/hFRsOdaYDwjOv3HAGaf8o?=
 =?us-ascii?Q?Moh9EYOd7dDJRRVbWTBGPYGffSnyhvWncnCgPaUTEvDhyptV8Z+rWSB0qIxS?=
 =?us-ascii?Q?Csdh537O5653Muu/T7/XjihKOTkbqn3GLSw0Ck3Y/MNBksXTh6mjrNo7+Ngg?=
 =?us-ascii?Q?f8Y7fmBeULBGMNj5SadM8q4EEIPztynl6i223Sb5kPvy3NhDkgf8SgP/zDxo?=
 =?us-ascii?Q?iZ8e4AqxRfDMPUeRatjE5dTS/FGKxmns89ilOxjtbHeDDcS+rsTnrSAmU8UM?=
 =?us-ascii?Q?iUntD2psyrit2zK85PyiFjZak4EpcKJBwiEICgTNLBbKYZJCUYdTwHQi/V9t?=
 =?us-ascii?Q?1Lu/WRawwTrKbfbvjvPnfD9Qk9iYxZ1yaN+9a3qm1tCmHE6zN1QnoeC43S/o?=
 =?us-ascii?Q?6XFV06Pz4+I7KcfzWTyLUvyzBff+fte77qD4bDXAg2Gfg6KqbYfPHfnzbpfM?=
 =?us-ascii?Q?To+blHM5FX2+d30vh9aCK4dtbGIWQ8FTP7DYiibH2K6aZIZ+2QapC3x1F6jQ?=
 =?us-ascii?Q?cwJwR+wWBzm8lomyiqCT9/cbzSt4ZF44uQXpCs02H40LKdcTUe50JR0HnRLf?=
 =?us-ascii?Q?7tPfHvexrSY4JpShd6ADTBz9iT/F+08+D4J4DQd6uopVtZEP7LOR1dT8G2+0?=
 =?us-ascii?Q?B/cA0kXXRMqYPUE4Vtl2JmwqaDejefSqVHUoleyYT86GubxxCYFPeY8T2AKG?=
 =?us-ascii?Q?cDTplD9QDkNW30Q0Y97nQaY+vl4/L0dBhOlgwRIIDaAdAllMWzhFU3Db31U4?=
 =?us-ascii?Q?CsX/yHdgbtI39tVVC1LWw6j187KwGjc9oc9nxhsc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4e0260-3a7f-4765-28be-08dc43dbf118
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 04:05:10.1325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cw8F6hcjWRb+4ipiJoA8TdKyGT/C9uVa+V2O7IeaTMcmAEb6J2DevkfWksm0eksLakkxJhwIjEe/9oXdteUK/sKHPQAFW87g6qckUC6nLNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8705
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
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
>On Wed, Mar 13, 2024 at 07:54:11AM +0000, Duan, Zhenzhong wrote:
>>
>>
>> >-----Original Message-----
>> >From: Michael S. Tsirkin <mst@redhat.com>
>> >Subject: Re: [PATCH v1 3/6] intel_iommu: Add a framework to check and
>> >sync host IOMMU cap/ecap
>> >
>> >On Wed, Mar 13, 2024 at 02:52:39AM +0000, Duan, Zhenzhong wrote:
>> >> Hi Michael,
>> >>
>> >> >-----Original Message-----
>> >> >From: Michael S. Tsirkin <mst@redhat.com>
>> >> >Subject: Re: [PATCH v1 3/6] intel_iommu: Add a framework to check
>and
>> >> >sync host IOMMU cap/ecap
>> >> >
>> >> >On Wed, Feb 28, 2024 at 05:44:29PM +0800, Zhenzhong Duan wrote:
>> >> >> From: Yi Liu <yi.l.liu@intel.com>
>> >> >>
>> >> >> Add a framework to check and synchronize host IOMMU cap/ecap
>with
>> >> >> vIOMMU cap/ecap.
>> >> >>
>> >> >> The sequence will be:
>> >> >>
>> >> >> vtd_cap_init() initializes iommu->cap/ecap.
>> >> >> vtd_check_hdev() update iommu->cap/ecap based on host cap/ecap.
>> >> >> iommu->cap_frozen set when machine create done, iommu-
>>cap/ecap
>> >> >become readonly.
>> >> >>
>> >> >> Implementation details for different backends will be in following
>> >patches.
>> >> >>
>> >> >> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> >> >> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> >> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> >> >> ---
>> >> >>  include/hw/i386/intel_iommu.h |  1 +
>> >> >>  hw/i386/intel_iommu.c         | 50
>> >> >++++++++++++++++++++++++++++++++++-
>> >> >>  2 files changed, 50 insertions(+), 1 deletion(-)
>> >> >>
>> >> >> diff --git a/include/hw/i386/intel_iommu.h
>> >> >b/include/hw/i386/intel_iommu.h
>> >> >> index bbc7b96add..c71a133820 100644
>> >> >> --- a/include/hw/i386/intel_iommu.h
>> >> >> +++ b/include/hw/i386/intel_iommu.h
>> >> >> @@ -283,6 +283,7 @@ struct IntelIOMMUState {
>> >> >>
>> >> >>      uint64_t cap;                   /* The value of capability re=
g */
>> >> >>      uint64_t ecap;                  /* The value of extended capa=
bility reg
>*/
>> >> >> +    bool cap_frozen;                /* cap/ecap become read-only =
after
>> >frozen */
>> >> >>
>> >> >>      uint32_t context_cache_gen;     /* Should be in [1,MAX] */
>> >> >>      GHashTable *iotlb;              /* IOTLB */
>> >> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> >> >> index ffa1ad6429..a9f9dfd6a7 100644
>> >> >> --- a/hw/i386/intel_iommu.c
>> >> >> +++ b/hw/i386/intel_iommu.c
>> >> >> @@ -35,6 +35,8 @@
>> >> >>  #include "sysemu/kvm.h"
>> >> >>  #include "sysemu/dma.h"
>> >> >>  #include "sysemu/sysemu.h"
>> >> >> +#include "hw/vfio/vfio-common.h"
>> >> >> +#include "sysemu/iommufd.h"
>> >> >>  #include "hw/i386/apic_internal.h"
>> >> >>  #include "kvm/kvm_i386.h"
>> >> >>  #include "migration/vmstate.h"
>> >> >> @@ -3819,6 +3821,38 @@ VTDAddressSpace
>> >> >*vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>> >> >>      return vtd_dev_as;
>> >> >>  }
>> >> >>
>> >> >> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
>> >> >> +                                 IOMMULegacyDevice *ldev,
>> >> >> +                                 Error **errp)
>> >> >> +{
>> >> >> +    return 0;
>> >> >> +}
>> >> >> +
>> >> >> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>> >> >> +                                  IOMMUFDDevice *idev,
>> >> >> +                                  Error **errp)
>> >> >> +{
>> >> >> +    return 0;
>> >> >> +}
>> >> >> +
>> >> >> +static int vtd_check_hdev(IntelIOMMUState *s,
>> >VTDHostIOMMUDevice
>> >> >*vtd_hdev,
>> >> >> +                          Error **errp)
>> >> >> +{
>> >> >> +    HostIOMMUDevice *base_dev =3D vtd_hdev->dev;
>> >> >> +    IOMMUFDDevice *idev;
>> >> >> +
>> >> >> +    if (base_dev->type =3D=3D HID_LEGACY) {
>> >> >> +        IOMMULegacyDevice *ldev =3D container_of(base_dev,
>> >> >> +                                               IOMMULegacyDevice,=
 base);
>> >> >> +
>> >> >> +        return vtd_check_legacy_hdev(s, ldev, errp);
>> >> >> +    }
>> >> >> +
>> >> >> +    idev =3D container_of(base_dev, IOMMUFDDevice, base);
>> >> >> +
>> >> >> +    return vtd_check_iommufd_hdev(s, idev, errp);
>> >> >> +}
>> >> >> +
>> >> >>  static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque,
>int
>> >> >devfn,
>> >> >>                                      HostIOMMUDevice *base_dev, Er=
ror **errp)
>> >> >>  {
>> >> >> @@ -3829,6 +3863,7 @@ static int
>> >vtd_dev_set_iommu_device(PCIBus
>> >> >*bus, void *opaque, int devfn,
>> >> >>          .devfn =3D devfn,
>> >> >>      };
>> >> >>      struct vtd_as_key *new_key;
>> >> >> +    int ret;
>> >> >>
>> >> >>      assert(base_dev);
>> >> >>
>> >> >> @@ -3848,6 +3883,13 @@ static int
>> >vtd_dev_set_iommu_device(PCIBus
>> >> >*bus, void *opaque, int devfn,
>> >> >>      vtd_hdev->iommu_state =3D s;
>> >> >>      vtd_hdev->dev =3D base_dev;
>> >> >>
>> >> >> +    ret =3D vtd_check_hdev(s, vtd_hdev, errp);
>> >> >> +    if (ret) {
>> >> >> +        g_free(vtd_hdev);
>> >> >> +        vtd_iommu_unlock(s);
>> >> >> +        return ret;
>> >> >> +    }
>> >> >> +
>> >> >>      new_key =3D g_malloc(sizeof(*new_key));
>> >> >>      new_key->bus =3D bus;
>> >> >>      new_key->devfn =3D devfn;
>> >> >
>> >> >
>> >> >Okay. So when VFIO device is created, it will call
>> >vtd_dev_set_iommu_device
>> >> >and that in turn will update caps.
>> >> >
>> >> >
>> >> >
>> >> >
>> >> >> @@ -4083,7 +4125,9 @@ static void vtd_init(IntelIOMMUState *s)
>> >> >>      s->iq_dw =3D false;
>> >> >>      s->next_frcd_reg =3D 0;
>> >> >>
>> >> >> -    vtd_cap_init(s);
>> >> >> +    if (!s->cap_frozen) {
>> >> >> +        vtd_cap_init(s);
>> >> >> +    }
>> >> >>
>> >> >
>> >> >If it's fronzen it's because VFIO was added after machine done.
>> >> >And then what? I think caps are just wrong?
>> >>
>> >> Not quite get your question on caps being wrong. But try to explains:
>> >>
>> >> When a hot plugged vfio device's host iommu cap isn't compatible with
>> >> vIOMMU's, hotplug should fail. Currently there is no check for this a=
nd
>> >> allow hotplug to succeed, but then some issue will reveal later,
>> >> e.g., vIOMMU's MGAW > host IOMMU's MGAW, guest can setup iova
>> >> mapping beyond host supported iova range, then DMA will fail.
>> >>
>> >> In fact, before this series, cap is not impacted by VFIO, so it's sam=
e
>effect of
>> >> frozen after machine done.
>> >>
>> >> >
>> >> >
>> >> >I think the way to approach this is just by specifying this
>> >> >as an option on command line.
>> >>
>> >> Do you mean add a cap_frozen property to intel_iommu?
>> >> Vtd_init() is called in realize() and system reset(), so I utilize re=
alize() to
>init
>> >cap
>> >> and froze cap before system reset(). If cap_frozen is an option, when=
 it's
>> >set to
>> >> false, cap could be updated every system reset and it's not a fix val=
ue
>any
>> >more.
>> >> This may break migration.
>> >
>> >No, I mean either
>> >1. add some kind of vfio-iommu device that is not exposed to guest
>> >   but is not hot pluggable
>>
>> Not quite get, what will such vfio-iommu device be used for if not expos=
ed
>to guest.
>
>It will update the IOMMU.
>And do so without need for tricky callbacks.

Sorry to bother you again, just want to get clear understanding to your sug=
gestions.

1. Is vfio-iommu device type inherited from TYPE_VFIO_PCI_NOHOTPLUG?

2. How to avoid tricky set/unset_iommu_device callbacks with vfio-iommu dev=
ice,
    if we want to pass vfio-iommu device to vIOMMU to update caps?

3. Do you mean we can loop on vfio_device_list to get vfio-iommu device?
    We want to support vdpa device in future, also need to loop vdpa device=
 list;
    also need to bypass vfio device whose host bridge configured IOMMU bypa=
ssed.

4. It looks, with vfio-iommu device hotplug is not supported, or I misunder=
stand?

Thanks
Zhenzhong

