Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3181075275
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38Qs-0001Gn-8j; Thu, 19 Mar 2026 04:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w38Qq-0001CH-3d
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:08:40 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w38Qn-0003I4-Gj
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773907717; x=1805443717;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X6guAiIU499gtCUO0ellpkOpRqmK7NmO2Nlc1rciXko=;
 b=kRb/QgcfjbtCNfJ9krBGKjGq5Cj8D15Mt9jM546Kd2Pp1DLGu0POJ4Ce
 hn7LDqD+ZxuDZd2U5FD0sM0bmu9OPHaFC7un0KSWebrBR7evzpLkwlX2D
 UZZ30bhbPhb5ioflGQB6yRxxpIj4yWVX/ugqd/0soUjyI9TgdfvAqqeZg
 2dSQ2B//8cwT+qtJIElqXT+GQt+vJDWGXw27NWNA0UwmntOeibF56gI4Q
 wCvTm0gHpO/ZX6B95HW+ZWFRIBNZiKNX6q2IIsovqL5y78cLeOD5cfkh0
 9qtJp+xCUN+F2aODvsWparD7w/69iC79exkiydylJ2wNTYt2JfzFW2DoR g==;
X-CSE-ConnectionGUID: mbpieleGRR6XkiOQfuKnow==
X-CSE-MsgGUID: TzArOb89QmCfeVYwOO8r1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86334571"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="86334571"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 01:08:31 -0700
X-CSE-ConnectionGUID: 5KcRWiFlTL6HUHW2Uxq7TQ==
X-CSE-MsgGUID: OKt97O7XSz2kyXhik5OrvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="223106180"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 01:08:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 01:08:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 01:08:29 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 01:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRyG4h04pifNL05pxSllFSYQE6b6j6V9fOSUUWK+qtbwm5S2yYjA1k8RhomC8A4zZYUSUxO8QMbOfto/G+QTAi1fUoyw6f4Q8eQ7VfXgIVHmsOvOvaApfSDdxJvV7D43QfbEoqzmB89Dwov1M2mSYpGHhi3n+FPIqlb2Tph8DTyMV0YwKAK737P4FHETkJsTvx2S4IST/oZewtHA3UaJ9vTx3XkazJvTNcKLLLSeIiAVIhgMQjFfRGJ3GKsvXPb1KZzujiTn3gvdLfQGgkattjI6fo311+GZii3m1UXlb5c6XQFeprCaZri11mV74KSpvxwh4ugpj/zOJV5EemA2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfP51BuxilA1Ee0mh10wHdUb7fqQKIH6XNLHWHuzet8=;
 b=h+DUYEwm1C5DIIcGoK1VDwPPkKbAoFI9ibiUOMk12ivXq9GaoN6EI0AO9UNwvpNZt45t5a84u/o/ZukFcMzs56hZy9LWaDKH5UOSOeGrlyDf0ADNNbKoEqTAil+exeZTpQJEo28L1OPIra+iGJSKNkGXzAfHIncCrQCLlUiK1vwQJZnjZdRU1StsMKqaRn/pjvTSuK6mnQRRRC+ihDLFNPhFtsL/gVb4TAP6BK+3lHZmuwNKtqgpvjFHxmE95xUi8915vEwY44iZGnqXrYQ//oAXErM82p/iXh7RWjqiSar4O71ByONhS6bU+ZK/aO2Ue6r+wlHHk9ycVUoAYTWxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Thu, 19 Mar
 2026 08:08:24 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Thu, 19 Mar 2026
 08:08:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v1 05/13] intel_iommu: Change pasid property from bool to
 uint8
Thread-Topic: [PATCH v1 05/13] intel_iommu: Change pasid property from bool to
 uint8
Thread-Index: AQHcrRuUxlL8aIvJA0+C6VUd82CcX7W0SPAAgAFIdLA=
Date: Thu, 19 Mar 2026 08:08:24 +0000
Message-ID: <IA3PR11MB91368FA4A99D25CD8F8D1544924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-6-zhenzhong.duan@intel.com>
 <4b0c92ff-54d9-4383-859f-169a5735de9d@intel.com>
In-Reply-To: <4b0c92ff-54d9-4383-859f-169a5735de9d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW3PR11MB4587:EE_
x-ms-office365-filtering-correlation-id: c0aacf71-eae2-4aeb-0411-08de858eb1d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: x8cNIve4KtNAxId/RR899zgMeYps94nwSvRB//JqgKK7cW7m6L3ClbyLtBF79nKQqqdmNfSSfCBz8iGjzlgcgTJBJY2K1Tgh9Jtifc9zvYDITc4FSUVxy3xNlE4zlkj2jTi1nGPsTkMXUiY8KMqz0cbgyRj2KGpcOKOqOJ61UIFRTDQyP2AQnF05TQveQuqsRVyLh3rFRGP/mfJxWzGBdEvhhQNpDvJWTHB9+GuEhsLLEGnXEOSc5f0WmXo+NN7ER8RMuAjlbHuWR500GZoKVznLsGtQMSaxh0c98ZDzdtp3b65iyvRQX3wjrrZlLYtrRym3/iXsSk//FdYxpJcIWHoAOluGJIpRfK2/vnoI9uW8hA870wZV16+Sx54PP6gwkZIYgz1+3piw6zsAfy0m5rblynQT/DCKg4cJY+4Qc/g1JUU9qWm6GfWCYIdt+yg/zIHZuBr/mxWiVbSp1oSnmQIRTgP2SDGC2Ex8pY/GUxfSRwIEB51F1J46pcxmtvASosLyS66A4Z8ilbnGkVPvyln6HaxEMRsjMPEWO6+2GN3/Lx3s1amsL6OhFsY3a59FmsuxrP325GaaTIsKrcnu1CCF4rhygg460cNXYNntOv7XlXatFV3z/kpRGjimT2rFhNF2W4xyirO5BbQqVb8G/5pxiXnM/HIL0KLT5hx9G7XqlcUguMXGZnwC1WY5LBG5rQk9bLAyMo3ClgqLynjVGoTf0hNIq/BL4XBUxjgMrYGi/scJZLAIR5zwx1w7NiTCd2prqtBfL4ArK8T5iYaGCqW3Snq+/LGYbdtPAxxQuhI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qqZJqbB0QDF103GDA+Jg1ZtVNyZj/2UkNiZxKqwNceRgVVFdWMhV+evEXDUX?=
 =?us-ascii?Q?zIBwYdAYFkIoSLtJ2Dw/mhn0TjRYaiARUHwJXFklvCtEBTVjivcYyp9Vz/J+?=
 =?us-ascii?Q?jVkOY+uzSjqXb9mnYozJoMppy1+CMGKyX//SlVmYTwlhxu+7gduwmmjE6HKd?=
 =?us-ascii?Q?2rlxYiTarEgiRMt95StCjVHgHu48XZlSPDLOJClsJAqcL8HSAP8sJ0esg8qL?=
 =?us-ascii?Q?c0cbwsHwvWa0tf8UouOWS3Rih2ugVcq/Uc4FbHWibM7s/uydizRkYr3jSXd6?=
 =?us-ascii?Q?9kgGJN9t6Q3BiSMWJgqjC7r2npuWpDparM3b9RcrBgfl4Z4jwOo4+gwl/hWG?=
 =?us-ascii?Q?sOao454ZRdn/UnYT7SEGCEqdf1/QVjs9m3l+boxJFV+eIb+LXmMS8l2z8Qem?=
 =?us-ascii?Q?Xn80oCfwIGg016dQtNq2+a0Cgp0GqtwY2yciEt9TCiCD4I9+X2mZwVLstJWJ?=
 =?us-ascii?Q?IHlevUB7hLg+dG9q4WaapqoWTTPnn2eD3gXbykUhstqZg9GXp6dLhAW+KPzj?=
 =?us-ascii?Q?E95Ag0WYqAg3iZWFc/5BKRWC/IuTeQpUfjOAFQ5AJ/t23ya2PIF6HtrkjO+e?=
 =?us-ascii?Q?vCycLBN6ANX/SdXB7r2ArRhYxUDCc0SFVHBWYmPq7rPizaYFjUluKVn2KqBe?=
 =?us-ascii?Q?hU/XG1VyDzhrWU+A/YeB/I2/Xq2/W+R+TJah1pVRVsCSCCF+Lg82vHnd2f2V?=
 =?us-ascii?Q?NwfOO+RZuQGJKORIkdbDjt2xbxxewtJF0X8omY9DCDlwI0F1iEQCttgigikH?=
 =?us-ascii?Q?AJOiQaSckOANHiCe/cKiK+umhjyVsTe6uypy46zvRgH0GkoSyx2yapyX/MSg?=
 =?us-ascii?Q?grw3I71jcPiOb5kGnFTVwEEwDxB04SYSeRV3azBfa7iumHxyLC9qJKxf0coN?=
 =?us-ascii?Q?pKb6MGhK+tgSedaZGAozcbLYZ5EghniM/g/Qq8Dbg8RnaBv0Vj30z3NmtP9i?=
 =?us-ascii?Q?Hrpk+nd+y0le+MSf4eaJ9eaZ1AIYGO1mnwV14hfG7JAVPBM7arAoezi5qRfF?=
 =?us-ascii?Q?YHxogCa0mOIayxO6TL+lfqezUCgRJCOXtWJd7O0XutU4f6wigXNmS+zu+y07?=
 =?us-ascii?Q?W+Fj78nwVcXRP5WOyHtlvZXMQhmRIfa1wp8Gm/mm7FSNUA0kyfr/E/3azx+4?=
 =?us-ascii?Q?B8sZGdKe4YDFz08Oc4/imLoeH/i+IwnAA5iWqVsqyVPL/on19kOzkxDr9bYw?=
 =?us-ascii?Q?cOaFmMxfDSbZkgyWBy//mS0rbicqJ9zb/GHCsBofpdo3EkmQwoR8Fek61yKd?=
 =?us-ascii?Q?/X+BBIYFUuXn5wOT6gjDihi7fvc32k60QQcGmptDy2z5y0vtYOX5cPUY472n?=
 =?us-ascii?Q?QHCeFqgMEPoBpll0l+IcES7FXg5m2Vwsom3hYujJO1Y5f+Iy50H8ByJv7yNX?=
 =?us-ascii?Q?EhMrJYIP+o3o/dKxkxlNRExmiG+bjbrA8A11PuZlp277mq9t2LMdjfsyGlXU?=
 =?us-ascii?Q?LSCEIX3iAPj4q3RSv/S0myFKLVcJ4j181eOCepdLTNqff7NAuufMFHXFKgOK?=
 =?us-ascii?Q?kGgd/VTCDkuIw13rrsVbbR6Za6XzL1S2bzd4Yprxkw2ywxQZdOUHGj2Ncvm/?=
 =?us-ascii?Q?/TWMVoyKqtd5tnclU8avHy71v0mHuZG9i/KGF4SD/0GLQvfZeycPmA+rat7n?=
 =?us-ascii?Q?jcoYQ81pLCQyyCS6CtvJZG+5lsCazqyAHYyiIq84yrzrZsab9euWPlITGcdH?=
 =?us-ascii?Q?9Ww6W2SXyUzauBQy6w/PlPrRVqDgjM2dqQKcalBjqkFvOWI1PNgITucjJfsi?=
 =?us-ascii?Q?8DYPO4o8UQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FuHF4bKcqZXRthbRrGpjk/D0AdkvE6SIc1Qi1Ob7TgTfrsTxK0Psa2mnPOK/W8+12ZYgT0SdQ5cRmtyj4b25caEdqDtlCJbZQDy9s6iENLuGF5L33MKyfpNCuUzRM+nqHhuNodmEfKoKUqKe4/FQhnxAD5VqQu22/DLfGby3UC/st6MvqGNyKYSkuuw59hB/3sPCAIyDsryMm9sDn1W1o7oFPZ1WjSwl6xAr+koI8TOHvrOmEQIqFTzMBD6umP8TZaJVMhusQduD1HvtQpJN/H0syVCYyiJb/fDiLYGk8myqPFiFGfEeWETDxLoz5QZBVMB9+EyXyCDIgeE2ycl1FQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0aacf71-eae2-4aeb-0411-08de858eb1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:08:24.8381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zB9lYzFkIwEeY2sBnKRJp/CO+Ut8AAcLt9j501ldhpWz6tydfmb1MH1YgJAt7XrXp3ELLQJxQS0TDMdswePBuKFS7jufy4yUhSbgXSVqwwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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



>-----Original Message-----
>From: Liu, Yi L <yi.l.liu@intel.com>
>Subject: Re: [PATCH v1 05/13] intel_iommu: Change pasid property from bool=
 to
>uint8
>
>On 3/6/26 11:43, Zhenzhong Duan wrote:
>> 'x-pasid-mode' is a bool property, we need an extra 'pss' property to
>> represent PASID size supported. Because there is no any device in QEMU
>> supporting pasid capability yet, no guest could use the pasid feature
>> until now, 'x-pasid-mode' takes no effect.
>>
>> So instead of an extra 'pss' property we can use a single 'pasid'
>> property of uint8 type to represent if pasid is supported and the PASID
>> bits size. A value of N > 0 means pasid is supported and N - 1 is the
>> value in PSS field in ECAP register.
>>
>
>should we keep the "x-" prefix since this is new pasid support?

Copied Daniel's comments about "x-" prefix:

The purpose of using an 'x-' prefix for properties in QEMU is to declare
that they are subject to change with no warning, so we are free to change
them without any deprecation

I think uint8 type is large enough as pasid bits size in foreseeable future=
.
So we will not need to change or extend pasid property, so 'pasid' property=
 looks fine for me.

Thanks
Zhenzhong

>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/i386/intel_iommu_internal.h | 2 +-
>>   include/hw/i386/intel_iommu.h  | 2 +-
>>   hw/i386/intel_iommu.c          | 5 +++--
>>   3 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_intern=
al.h
>> index 11a53aa369..db4f186a3e 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -195,7 +195,7 @@
>>   #define VTD_ECAP_MHMV               (15ULL << 20)
>>   #define VTD_ECAP_SRS                (1ULL << 31)
>>   #define VTD_ECAP_NWFS               (1ULL << 33)
>> -#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::=
pid */
>> +#define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap =3D deposit64((x)->ecap,=
 35, 5, v))
>>   #define VTD_ECAP_PASID              (1ULL << 40)
>>   #define VTD_ECAP_PDS                (1ULL << 42)
>>   #define VTD_ECAP_SMTS               (1ULL << 43)
>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu=
.h
>> index 54c2b6b77a..bb957b93e0 100644
>> --- a/include/hw/i386/intel_iommu.h
>> +++ b/include/hw/i386/intel_iommu.h
>> @@ -315,7 +315,7 @@ struct IntelIOMMUState {
>>       OnOffAuto intr_eim;             /* Toggle for EIM cabability */
>>       uint8_t aw_bits;                /* Host/IOVA address width (in bit=
s) */
>>       bool dma_drain;                 /* Whether DMA r/w draining enable=
d */
>> -    bool pasid;                     /* Whether to support PASID */
>> +    uint8_t pasid;                  /* PASID supported in bits, 0 if no=
t */
>>       bool fs1gp;                     /* First Stage 1-GByte Page Suppor=
t */
>>
>>       /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index d24ba989bf..e5b9689fae 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -4203,7 +4203,7 @@ static const Property vtd_properties[] =3D {
>>       DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode=
,
>FALSE),
>>       DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
>>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control,
>false),
>> -    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>> +    DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid, 0),
>>       DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
>>       DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
>>       DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
>> @@ -5046,7 +5046,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
>>       }
>>
>>       if (s->pasid) {
>> -        s->ecap |=3D VTD_ECAP_PASID | VTD_ECAP_PSS;
>> +        VTD_ECAP_SET_PSS(s, s->pasid - 1);
>> +        s->ecap |=3D VTD_ECAP_PASID;
>>       }
>>   }
>>


