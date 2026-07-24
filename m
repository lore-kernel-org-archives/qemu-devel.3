Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6624EC531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn5sN-0007aF-V0; Thu, 23 Jul 2026 22:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wn5sM-0007Zj-Fu
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 22:43:02 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wn5sG-0002cP-Ux
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 22:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784860977; x=1816396977;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=m3loZULwc7J2Na+PIC9Lc10liXRy1c54NWxVNNVJiYg=;
 b=X6n16Z/gIC+FpujkxfO/1E3o2/M/Pq4+/qBkjuTuvd0DJFITdnZ7CvnY
 5k8nAKoEST33+C//EnXmUWVtgBu/GgtidOdvNh3yrJmHV1b6TdaQ7reQy
 Bfxv3Bq7k/k+7+IlKu3N9+Cm/DTfCuGVOfRd2u3WCHXPU3s3DCyYywBPW
 0kEeBmYjlQMDAnX88M1Ydlxww8hSaFIR+mkrpR2mnBVch5EG+o2PquA/A
 MU3T0ycqhpZ6z9wObN8Q+NGauqDk2nsIUedBsrmIH4IuLQhF2ulKZKOrs
 yo07lsk6jnBmNcSQCF2kI1vigG5oFcLBWAyrGvTcFIp5sZ6KqES1Cpkz2 A==;
X-CSE-ConnectionGUID: eBm+wir6SYudADG0PwuUHA==
X-CSE-MsgGUID: o5bRnebnQHm0/HlkiM+evg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85397293"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="85397293"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 19:42:48 -0700
X-CSE-ConnectionGUID: zhF/4S6NTH+OGUNWSn0fDA==
X-CSE-MsgGUID: +ijKUYOsT2S6+EBnbgT1gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="259258628"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 19:42:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 19:42:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 19:42:47 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 19:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGopXWbTWRttVh1KWrZlqEcyuvRl5Bz/xZTTryoykmzVlNuyCyCyGFF68c2uPPLk/LGGAI0dYZixcf3HBp/xZ1lbvEMBEspxbo+S9XCxlL6D4yVIPfVyV+D/UNwFXlBKIKQj8Xdxej33qR78rS+OYBr1NeiGBvAYzVS22zJTDGPNlk6t7lNtQFagqTDHKZ/IZ35jaOzl/mSi4M2g1RlLAKcB9hLvKxsmjdh4M/FM5r0N7ZYHVYYeIV/vkT7DJhbd72Zn3NEvYWZHtrnpXDXMCFtaEZeH6k/an5IthTd2/8rLrl4SCNuhJZkhmQGZsTPxbipmrNp4IyhlafGopYgqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C66lb7630WkNM+cErE4HiceY/b79WWJcsWBC+Iinwew=;
 b=xUkBk3EYMu+OTLgFzqcDR+qvVbhF5f1e9jvVhc+a8fs090Aw5RcPrO2bMa/UYOTIX+UkvXEFkWRkqPmp0tgh3cw0tzvULgfJdtKpSEW7o2rY/dp7mnnObpryI8DsWmeB4ci8l/aKaLV8C2Jw541xThwFndJIA3KUBgbgwAFZfsLhqGVL2oXUxjh2CstOLFM7GF22Umk7FYpv0YIgUxyVgh+NIGF2uwxcEK/EF03m6OjXZN43H0tclIrJh0yKnY3dg1b4ROAEQFZP08XcpZk7/9xzx+WM3rl4KVzlfmteUqHGicrYzVu15+gHE4jcQMFfb6oZfqENsbfHXDl/toQg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by LV8PR11MB8724.namprd11.prod.outlook.com (2603:10b6:408:1fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:42:43 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:42:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: RE: [PATCH] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Thread-Topic: [PATCH] intel_iommu: Check address mask before using it in
 pasid-based iotlb invalidation
Thread-Index: AQHdFF2gaOr43gDnOkeknlmRP+LdPLZ8Az9A
Date: Fri, 24 Jul 2026 02:42:43 +0000
Message-ID: <IA3PR11MB91364F2BE9108A8B28D34D6092CF2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260715132652.1488991-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20260715132652.1488991-1-clement.mathieu--drif@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|LV8PR11MB8724:EE_
x-ms-office365-filtering-correlation-id: 98435bb0-3501-44f2-9789-08dee92d3ce8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: 6z6OSuLVHmZpW/4PIBByrNCnQumVuN+eZ30eBARBFGTO5SMkGqSNkdcWmED8p+ChhHreMb6HVV4Y7UCDQNtBEX0vVmRhlQtBwGTFLNR/gOoCuXKdARWnBZqiJcUR5jZ0gHSTbBbW9zwj75JyCkDQe8RTl+W5bONyCqLA1Chemagq3VM+744T6RtXNePT0qRPH/V3U/czCDVBtinbs11LSwEj3EfSE7kP+rDzgh1mVWf1D0g0ppC2yeqpulyC0Ib/Wbphzlz4RbD9Fajk3p0+wge+AQ7Wag+HrdyISMv3pBsrydSkJicBSJRANrGzY/piVnPw4evCHZH1zvCaBEZm8HHuVToz4rPXux9jeKffYa2cvHfhwsRuehqAHdA83VOsjdY0W/Fo/4DYJSxvJ2E3cn4D+ZQUiSs0naP6dG92hXye/+tYQ2c9AKNQZyCvHfW7mnG9jDSFZRjdTKz1RBYxVS6xclpe29MDJXikgBUMBarFtXsw8uIvZZJNzN/+Z9XLna3aFzbEG++LGNfrcIMOilQIADpulV2C1OGTDasR9U2EFLDxuU4Z9+ItB2mE5hl1WqUEJHb+gHuo3k5h91/9no3XH661OdMDNlAcLeyhiMTRx67JepviMa2z5VIQ4Cgnf320tMExw5OslQJHMtE1ZViMPQy6JghT3Glh6gWFwVaFMeyo4XXbUO639Ms7V1slGyR4T5rbqKsVctZZm+Lmi2j33PYKnFfBhL4a4QJ+N3I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CdZCFnu3svF7e+n8tSajlCOGlybJU5eedPa5cwCMX9XQCo/EYEuIO1kFNK?=
 =?iso-8859-1?Q?Ic7ca5obtsONHhXnk5h6KwNAQycpbAYQvq3ZDftoeB4d1MITyM184q9utz?=
 =?iso-8859-1?Q?hbjfjI3ioZI5290/5hT6CBQ9iaBZ+bdS9CQD0/XpJ8Seqgr9XjQa0edNRD?=
 =?iso-8859-1?Q?ORKEn/6o3/Dq0olfI+xu13icOH9/tN5h1KG4dlO7r43bvgVhZ/N74AjCIy?=
 =?iso-8859-1?Q?fDFbstZu3DYbVw5gMoz+xkquKRoA0tWOdk9HHjlbuCwwRUTSTBWWSofOxV?=
 =?iso-8859-1?Q?319AWaTcgacLuWrYuK4nEeCR0WlV+rpDMzGB0kJUpUG4r8tVLOqUvqU55w?=
 =?iso-8859-1?Q?PGKaBxEx+XU5fPgMzs1U9CJhxcUkuIUoSQkX6Snyuos+hAH1/x++UI45pA?=
 =?iso-8859-1?Q?uk5J7ivtiJk6mT9wxF50Tl3femVlikHAVlFHEMhME+XbN5FpQuObHDJNko?=
 =?iso-8859-1?Q?U6u3hk4Ty21fUi27NWo8u3YdOwTnthZnH6oT9IK/Ot/q1qXqYhaij8jCyO?=
 =?iso-8859-1?Q?8J0oUa8tewdxkZZhst/W5Rz4c58NNMI57/EYctK/fR3YDMCAvGNuJz//hh?=
 =?iso-8859-1?Q?gzGWL/t9mHedQhUtjtlog4xfxrGwtcwWnqLyPJCAbNnsz3a1twx4BpUdua?=
 =?iso-8859-1?Q?Vyd/CoXOSbND9o8jZp8UpBWWEgQ/GvzeDDvmZ2826nGgn1GTBLUBNUxeNk?=
 =?iso-8859-1?Q?j6QTkVl4vYpHevXuNITOxnvrwUAONt7JmQSdCBOq7ky9mdQUiP2O+bzYgk?=
 =?iso-8859-1?Q?v+fgkeNq/dOEeSpYBL5bzklVPxQmdyd3VGHTKOe0+n55R98IW8+J1jg5Fy?=
 =?iso-8859-1?Q?VTe2qFvT02kwR34Z3hqb8UuUeIw9gOp8kXNImHPrh0dfXwk3c+Q+HRsgEG?=
 =?iso-8859-1?Q?zhejszvfOzkBPRDibErqQQekUkN85JCkqKz4eNdDJxLCg4+7s/RiSh8UNw?=
 =?iso-8859-1?Q?C2qzaTQ91p6ybLJh6lsHBPiDj0hiqeSjErJPZMes1L8KjTM4KDhEJLS7VV?=
 =?iso-8859-1?Q?qt02QcWLJirc6wanoPI1pvEHVEfsvEpY431oqxZzuoR1bhcZNifnZbaRqB?=
 =?iso-8859-1?Q?b8nY9JeRNaJcjbR+4XVrnsx08PvC6EoS9dz3JD91K98Zlt2UpnkHKwzviq?=
 =?iso-8859-1?Q?B6o3lkmg5a1u8PNIX7DrwA+OicGwDfCXEZwQ9+MSf9voR89qnIWoUXW8r6?=
 =?iso-8859-1?Q?PcBz56Tdy8LQEjYNk2/h7zt9T4Rfb10ixTtlrWKITFINHiigoSvSZFUrFE?=
 =?iso-8859-1?Q?ipva9ftXCNXDcKiIrUokTE+su3HLHIH3rqf1n2M9FnXQ7Sw5FU+LT8hmWu?=
 =?iso-8859-1?Q?MjGG87OjgMJKmHNsfSOLC9aBHRvrCzCkwRchwnp2xuSbjCqP4SaGFmf/Xx?=
 =?iso-8859-1?Q?ZLxFeQhqGKQFyPrRsr6G8UXfFJHoCaXYme8AGiLim2UOBVlRABhVhAt8E4?=
 =?iso-8859-1?Q?mKnu+B7Q7kuvolDukpenUmWkbpJDxargFOJNe+ln03858/wmOccBuDtmc/?=
 =?iso-8859-1?Q?RDL9U8Er+dJs14YqSulUmOaGZ4cTVeO8SLTTvLHp7oeb5D9OL3GgRFfsMh?=
 =?iso-8859-1?Q?zc72ge/YeDH/XEDo14nz5uwzsy+45boRqRZn9P7/uQQso3a1eFjEyigcsL?=
 =?iso-8859-1?Q?9pCYV/gKP0cPjkLuYlYjjD49zcjDkf08YrwsvmPxZ2v4b4rfVwhBhYpoU5?=
 =?iso-8859-1?Q?nAAjFXaQ2QijFvEU/gAhALVkLZO/KsFm/6dpMex8au0py5G7MAuvBAAVEg?=
 =?iso-8859-1?Q?QK/LVDm+N5+VA6VnjYK51qkg4j+0f+OV+/2WKp5dXPzVlSGG2XiReAAwpb?=
 =?iso-8859-1?Q?le2B6ltWZA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GkvoWJZDgGZvICuFoHNhdy2b9jVoTgQ0CdzNpISk/szMgxcrRb1fEJDafjNOWzUlEbqhMSgh6pKyPJMAm/wqx5yxPhDob3V+CU93BLiQVEQMm1cgEqklANhxEvy8Zz8QsT/QWpUrICyi6O0z5DEiqVFxo2AIBjwwybSQpG6fDyCCKggChg3cHIdC7p+/VthY73F6oXzCPZw856Dp3scWz8j9XfWGfDm4Qfgwl14DVZrfXFTXqLU54TPjAbTYtILjB+Z6t6yxVXpI/rD6s4qUkSMWLQAErYHc2wbmFFYd/FPktiXleuGD+Y6oXyIxZ4PGLXY6GWSAosNq3yA7osXrNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98435bb0-3501-44f2-9789-08dee92d3ce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 02:42:43.7041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGXi624wA71jqBv/mFCRA/SRzsPUDOw73S8u8vjil/hlGsMWZW4pwp4+LU6mSGBqOep3wTnlVlAyT5v4R+tYrOakD9DEth2Org5uqUDpg9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8724
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
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

Hi Clement,

>-----Original Message-----
>From: Cl=E9ment MATHIEU--DRIF <clement.mathieu--drif@bull.com>
>Subject: [PATCH] intel_iommu: Check address mask before using it in pasid-=
based
>iotlb invalidation
>
>Prevent a buggy driver to execute malformed invalidation operations.
>
>Add the same assert as in vtd_iotlb_page_invalidate.
>
>Link: https://gitlab.com/qemu-project/qemu/-/work_items/3619
>Fixes: 6ebe6cf2a066 ("intel_iommu: Process PASID-based iotlb invalidation"=
)
>Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>---
> hw/i386/intel_iommu.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index bf4f0f2f6b..c591d1db3f 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -3021,6 +3021,8 @@ static void
>vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
> {
>     VTDIOTLBPageInvInfo info;
>
>+    assert(am <=3D VTD_MAMV);
>+
>     info.domain_id =3D domain_id;
>     info.pasid =3D pasid;
>     info.addr =3D addr;
>@@ -3060,6 +3062,13 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState
>*s,
>
>     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
>         am =3D VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
>+        if (am > VTD_MAMV) {
>+            error_report_once("%s: invalid piotlb inv desc: hi=3D0x%"PRIx=
64
>+                              ", lo=3D0x%"PRIx64" (am=3D%u > VTD_MAMV=3D%=
u)",
>+                              __func__, inv_desc->val[1], inv_desc->val[0=
],
>+                              am, (unsigned)VTD_MAMV);
>+            return false;
>+        }
>         addr =3D (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
>         vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
>                                    VTD_INV_DESC_PIOTLB_IH(inv_desc));
>--
>2.54.0

