Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F559FF60C7
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 04:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7R0g-0002ED-OZ; Tue, 31 Mar 2026 00:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7R0e-0002Ds-TL
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 00:47:24 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7R0b-0007yy-Di
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 00:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774932441; x=1806468441;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hxVPAL1hp5JQ6Q8srztoU+hVE9mg9+9NHflXc2Nhlak=;
 b=MmQmVjMYMVVu1uFAu0X2L5wiXtt1HrxuDI0Jxi6VAxiSLZ1EneWQ/10H
 ZOpwF+E6N/5tRicjE/Lqcige6n/xqDbWaXf8TJFTriUSpCF9EOtFnQDdW
 7u4at8rvAnDj50UoaOpHoKFjF/obPZjPVLuafGgXD/gUzJ9BG71UNDbNF
 jkdBkb/WbwPRqb/NM18GzeRKA7cPynaP2Mi2vCVVMBfmr04nRSzXI3squ
 l+O/C7RbtQuprRiLoSriwG40xa6+DnK3QGwTAhaEvDsBpLOnGsKeBT567
 JzpfMxEsrh0uiaaCrIR5uNqbSBNb7gx7HvQodI7RCnJ/JBdyTRic2Eneu w==;
X-CSE-ConnectionGUID: DQcZDcHMRIm7piCvf/SE0g==
X-CSE-MsgGUID: ajNRJdAmTUqA78oeYAnWhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93315770"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="93315770"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 21:47:16 -0700
X-CSE-ConnectionGUID: XBfif8oCToG35CxNOEvT/g==
X-CSE-MsgGUID: n8dAQpsRS6KdY2CjbNwO6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="231058920"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 21:47:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 21:47:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 21:47:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 21:47:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fro8mdrviZqrWHfNfYIqSfkbXgeWbXffthl8KJrjB0QfXaEWFljSxONtk5FqMX0pDP0jBpiJn16Qq8rOh4LTIwo8y2af89SoecmFwqgyv5+r1++yBIRqXU6W5xPP4rSlRwsRMNCR7sFVqbNn+ifd9rX8T6/qtNAE4KuZxl0DfFvHU07U6/WTrwqOjpUPgQbX+u6+P3Dv/VVNF3KMEDUc0oL5h4NUZj4UO/HirtIVgncx/IqcjoUHj+o+fyneCi2pUWsXYI/iGkemydh66a3SIOqGXD92GajtWwbsSU5Y8NiF4d9ijY/U39MpYi2KQRnAR3NHD2838nCbaippBy0V9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxVPAL1hp5JQ6Q8srztoU+hVE9mg9+9NHflXc2Nhlak=;
 b=VR6749McGAy57yCfLIj/o/yap6cDBiQdwr2man5y6RNtFzrsLXKA8rt9MmHm8IB1CqTUTPLI8J14IlydnVha4drtGBDUlkOHEuM66/i+eoeU1w4SP7Ar3Hmb5pihb+AAhUD9lnaOr0L3547lJV/jq7S+s5nWjNdNL51h8MrjWcLbZp1Mdk/CQ4nliAHUDiY4eP0ZYSeVbrLh9KuKvUSHJ5PtKpTtcQfkvpjtChfl0NLkdIwiYMTp7dhGHNZmDixIQb338mlj4dSQPa/p6OHGps/2FFbt0wmz3xdGTsj8VlWerI1M5ICdHgkwkExd8mdpmbfQxdWFvJ6SIw6YsPl2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH3PPF4324011F4.namprd11.prod.outlook.com (2603:10b6:518:1::d1a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Tue, 31 Mar
 2026 04:47:13 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Tue, 31 Mar 2026
 04:47:13 +0000
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
Subject: RE: [PATCH v2 13/14] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [PATCH v2 13/14] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcvQCxKbPjgyV7HkeBvKBZPm3mc7XBy4KAgABjKVCABLl3AIABMJlg
Date: Tue, 31 Mar 2026 04:47:13 +0000
Message-ID: <IA3PR11MB91361C77AF867ADE8386E92C9253A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-14-zhenzhong.duan@intel.com>
 <0ae09582-4e0d-4fcd-a7ad-5b6b0b470b93@intel.com>
 <IA3PR11MB913609282D514B085ABFA3279252A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <482dc339-9f80-46b2-8f14-6a5359897bb7@intel.com>
In-Reply-To: <482dc339-9f80-46b2-8f14-6a5359897bb7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH3PPF4324011F4:EE_
x-ms-office365-filtering-correlation-id: e6828917-ebec-451c-4fbf-08de8ee093b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: ckwNFZUuWtMrxVeqsqgzYPKjRFF71R3htfAUbNFI/qKjryZGELjcrMPRAgEXTFzgd0VYHZmD6AlknZuNdkKTpkKlxWOO20oLSfr9LPoibhePbxzjUHiydNYW+i6KCttWg2kaIJv6TbT6CAmI25XIiWMhbmSAEsYbSlp04zfVDM1odMrQVvPfszSD2RKhzkfs2vWrfUgNHJ2M5VaoRYk3WIeuCu/EWBQ7+wM7PNMsnz46IT6WFX8EJ4gQm6AiS3AWpaqtNSAhOm+WpotNvAnTt9O0WQtsaHixzd62GyuzUVJTqOR1Qa/kTyAHfeQpgllkNZmnM12odPVC4vgXKnxBv/4RC+wP1ucSk87FPzdVnmvYOZD5H7weFUEwuIKpKw8GYN2BnJxheh3Jgtm9kW5tbEw39/iMBHhMDxnbthhA5M6WTcgeTkfaUm0SWxZKui3+nbLO53QC5e9l/DVVaPRPM3Jxxee/WblAfVbw+avP27toFuset2ptTZhHyH7VNEsajrtR6vLrOq6cW8m0g/YUxqjtKT6dnn7knOcm3cMKKUFOUGiHtHTn2Pd9mgi2C1QxtOyKLwdN8efj+ipQUICFJRpAEnmQxo4MtARdDLoFZPXRKtW/cSPJhpvSSaEnY4QF74dgz7e99lshGdLUMq3bySbfN2T2SU8i+Av8bEayFf+tsNJNSyXOHc6M1KJUeDBD0IzkKu2DEMcOQk/A3t/P7RhFH6UbltyfUA4CP27LU0fIewQZIfzPLMkhvvIvguwXwcpAYCdExpcblswQXR3XVd7vNmaXudCrCDfti5qioEI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2pVYXJ1N2F4bEtNV0hGdTViMjVQSThNTlBDaEtTWXdOV1k2SHRkbk5TUVhk?=
 =?utf-8?B?aTl3eGpySHNWU1duMDRFdXM4V1lMbHpNb0Y5ZFh3SXNGNzYwVi9ZWjduVGd5?=
 =?utf-8?B?Zkg1K2xSZEpJamtqbXBCbE1ablNyalRZZGlrOXIxTlVSQjVnNDhaKzhXK2Vr?=
 =?utf-8?B?THlMOVY0N0d4UlBEUjRYLzBiZmdsNFU0aSs1c1dXS2oybzdrRFFxTWNiTFYy?=
 =?utf-8?B?cG1mWGdWY2F1UjBSWUwrY2JkVjlzcnRaTGQ1cHZPckdGeFFxSkJKN01JcUZG?=
 =?utf-8?B?ck4zRmc5OTc0MnNyNUY0ZnVjRy9neEJBa1lMWGFKWkhweTB4SlFrM0lDUER5?=
 =?utf-8?B?SnNQMVE4eUQrRnF1SFIyci9ab3FWVSt0VjlaaTRqQ3JiRnBVdzV4RzZwQkhr?=
 =?utf-8?B?Vll1N2J1OEprdC9wOUhRYWpVYWNlMTNSVWttb1dpMSsvMHNEN2I0Rm04aXZk?=
 =?utf-8?B?QlMyNU9lUU9SM0lhbWVsU0ZmMUFCSkVWOTNlNlZtdytIdkdpeS9KOUV5MCsz?=
 =?utf-8?B?cHFLNlNteURWSktuMFgxVkIzVFMxK2psbmpodlhwTk1OMjh6Q1RLUVVHYjl6?=
 =?utf-8?B?RHFicm85Qlp1WWNnYU9OUEl1Z20zUlBwT3FrUlJGbWIxaTNpa2ZxK29GbWIz?=
 =?utf-8?B?QitvcnUzZXdhQUlmYUFaTmY3bkF4UXR4TEdta1pYYW02c01MQkR5bi8wQzJp?=
 =?utf-8?B?S09GUTJoZU9LREFFL3pnRmhnVklCYWs0RnlXbmZCUnByTjR6My9wRmdQN0k1?=
 =?utf-8?B?U2hpb3dLNDdScmxxVW9CMmF4d2MrT1dHMFQxbm5aS0NrUFBEdUttSE1PSmdQ?=
 =?utf-8?B?eldFajBqZGpsVXpjc3VFdEdrenl0YktQWWp5cnh2MjVDUlNIREpKTEZCNWd1?=
 =?utf-8?B?K0xia0V1ays0UitNOGVmVTk0MXM5MjJ6WS9ZSjRoNUlhMkxCMDdYL2hnTFF1?=
 =?utf-8?B?MHRHRTRpbXVmZnFQV1FGM1lzVVcxQVRsalVZeFJ6bGJSa3RlNVRvYVdKYnVv?=
 =?utf-8?B?Q0diTStoR2twSnNIcWVvc0lhekdTZUNicjJrN0ZYNUJxVGI4SmVtY25NaGFh?=
 =?utf-8?B?cUg4SnFWK3NoMWdqQWN3VStNSXRhOEtmM3MxQnpYRmVaMFBQTTN3SEVybFZ4?=
 =?utf-8?B?ak10dkpKMTcvZ1pGT3d0azBUYXE1MFdNaUt4L1RWSjR5WFdXcjdLZW53Mkla?=
 =?utf-8?B?UDM3SG9tR3dSaWgrNkJubHk4czBiTGY1djRvaHFEbnVaYzBZYU5rSS9QR2xU?=
 =?utf-8?B?dy81VTZXUStaazlObDVuWUlOcnArME1uYTd2NGJoQUxWbzMxWjFucXVrc0Jj?=
 =?utf-8?B?TkRvU1hjRUhSRUJBYlcwL1luY3VFNEVVOXpaSmtXRmdZejlOTnI0Yk4wZW5j?=
 =?utf-8?B?YVAxdHNTUzc4QXpzVFpwclI5M0hnUmlScmVqM3Q4RGVVSUt0NFNybmN6dFBh?=
 =?utf-8?B?eDFuVTFZQTBxb0E3VWw5aWtUc0JkczVEY3ZtQW5ubWRwd0NEZXJjTWkrRVdl?=
 =?utf-8?B?aW8vSjRxcWxCUWRTQUZsRFJsdG5YUFdMRStNTmUwVHlNeTVIdHRhZE5Zems4?=
 =?utf-8?B?QjJSUlNiMVJOZVlOQ0grS0FGUkdiSW8zUnI5Z1UxS0N1aFFGblBuMzhhTWxm?=
 =?utf-8?B?c3dVZjNjQldDWGowUStUZC9BK3FhVXQrSDhMVm9ObWwyem1tUlN2YW5nU1Q0?=
 =?utf-8?B?MmxsdFhQMGRYd2FWTTVYR1lzWHQxVjQrZFY5SmFxR1JzckQxd1dzQWZkYnNR?=
 =?utf-8?B?cXZJVnVsS2dqRkRIZ3V5YWl5NEJETzN5MzFxaXBOTTMvU1hmSjczbjN3ZUty?=
 =?utf-8?B?M2VOeE5LUmg1ZlpuV0VmVnFpcjFNd3BDdjAyelV6VXcwYmk4eGlzd2NjWk5T?=
 =?utf-8?B?VmpHZ1pxTHl5WTgwRDgvMi9vcEYyR2JFNXN6b3dDTmVrS25hcEkvbVBTYkMw?=
 =?utf-8?B?L3FvbEdCaXljV0diVWgrK0JEQkJoQ2k5Tk1scWhLUUkwdW10MkRncjZDOXR0?=
 =?utf-8?B?aExXUkd4c3d6V2NvRTF2K2NocHUydWl1a0xGZmZkaG9SenRiRzNhMGorRXkx?=
 =?utf-8?B?VSs2S0pCYy81eXpQSXkrYzRKVmpzQW5tN2lnVjAvRGM3dlpxNGhjeTFJbytl?=
 =?utf-8?B?eUlJb3FKc0x2eFN2NVRPaStodmtmaUtEUmJQTEoveVVVd1JzeGNtZ0ROS2pS?=
 =?utf-8?B?bm1KZHdyUzlDMGNBeGM1d09YdDZlTEJTVzNxOVBwYk81R09hV0V2OHp5cFpu?=
 =?utf-8?B?RHYxUWIwWENOL1cyc1VkZXpPWGhmSnlCWnBmQW1zckl2cGFhYXBCQzQ5b1gr?=
 =?utf-8?B?RGRSbEVraUNOV1JSa2tMd1BEWDJKZzkxWDJOWXNlNU1PUjQwdkVyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jDaSAj7LfZ9QvupGO0TVF1X1WT6iJQgAMNb41KU4lVSmyKMCxrpsH+ruxq+JtJuoLegxO137yBvLkTcpTB2oNc9d+WTTTUpbGxXQEKbGeFVF80rN053IOmls0GQY5cHQfW5UmA4bbi5QP6l0FsI40lAMOC6VrCz6D/3D/bN2hcGpAS5uDdUVCU8Biwv7K0W3RC25ezVJSBAakwe9QZtBqJh11uHCrcvLLZHQpWIdJrYv4V+G/S0fIE+C6GoO8XIl9rMqKB3a7Y9/OQ5QzJUbvelaNnfSAkYIdzA1zEPFjUyeeLBOjqoK7AxP17/Rt3nMEE6m62HhWeNNuokDzfN1HA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6828917-ebec-451c-4fbf-08de8ee093b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 04:47:13.4795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyjVceH80rSnVzoSnt8S8gm2BPe4UdjmQw5EUMjcd595e7PV41X3FjRv39+XQ42bM0lfUcLR4hdP+45uxuzNOUW/vjgu9Mm4hHEsHYoMdrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4324011F4
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTMvMTRdIGludGVsX2lvbW11
X2FjY2VsOiBBZGQgcGFzaWQgYml0cyBzaXplIGNoZWNrDQo+DQo+T24gMy8zMC8yNiAxNzowNiwg
RHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDEzLzE0XSBpbnRlbF9pb21tdV9hY2NlbDogQWRkIHBhc2lkIGJp
dHMgc2l6ZSBjaGVjaw0KPj4+DQo+Pj4gT24gMy8yNi8yNiAxNzoxMSwgWmhlbnpob25nIER1YW4g
d3JvdGU6DQo+Pj4+IElmIHBhc2lkIGJpdHMgc2l6ZSBpcyBiaWdnZXIgdGhhbiBob3N0IHNpZGUs
IGhvc3QgY291bGQgZmFpbCB0byBlbXVsYXRlDQo+Pj4+IGFsbCBiaW5kaW5ncyBpbiBndWVzdC4g
QWRkIGEgY2hlY2sgdG8gZmFpbCBkZXZpY2UgcGx1ZyBlYXJseS4NCj4+Pj4NCj4+Pj4gUGFzaWQg
Yml0cyBzaXplIHNob3VsZCBhbHNvIGJlIG5vIG1vcmUgdGhhbiAyMCBiaXRzIGFjY29yZGluZyB0
byBQQ0kgc3BlYy4NCj4+Pg0KPj4+IHRoaXMgaGFzIGJlZW4gZW5mb3JjZWQgaW4gdGhlIHByaW9y
IHBhdGNoLiByaWdodD8gaGVuY2UganVzdCBkcm9wIGl0LiBPcg0KPj4+IHlvdSBtYXkgYmUgbWVy
Z2UgdGhlbSBpbnRvIG9uZSBwYXRjaC4NCj4+DQo+PiBZZXMsIHdpbGwgZGVsZXRlIGl0Lg0KPj4N
Cj4+Pg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oIHwgMSArDQo+Pj4+ICAgIGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgICB8
IDggKysrKysrKysNCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4+
Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+IGluZGV4IGYzY2I2Y2ZmMWMuLmQx
MTA2NGI1MjcgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KPj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4gQEAgLTE5
Niw2ICsxOTYsNyBAQA0KPj4+PiAgICAjZGVmaW5lIFZURF9FQ0FQX1NSUyAgICAgICAgICAgICAg
ICAoMVVMTCA8PCAzMSkNCj4+Pj4gICAgI2RlZmluZSBWVERfRUNBUF9OV0ZTICAgICAgICAgICAg
ICAgKDFVTEwgPDwgMzMpDQo+Pj4+ICAgICNkZWZpbmUgVlREX0VDQVBfU0VUX1BTUyh4LCB2KSAg
ICAgICgoeCktPmVjYXAgPSBkZXBvc2l0NjQoKHgpLT5lY2FwLCAzNSwgNSwNCj52KSkNCj4+Pj4g
KyNkZWZpbmUgVlREX0VDQVBfUFNTKGVjYXApICAgICAgICAgIGV4dHJhY3Q2NChlY2FwLCAzNSwg
NSkNCj4+Pg0KPj4+IHBlcmhhcHMgVlREX0VDQVBfR0VUX1BTUy4gSSdtIGFsc28gd29uZGVyaW5n
IGlmIHdlIHNob3VsZCBoYXZlIGEgc2V0DQo+Pj4gb2YgbWFjcm9zIHRvIGdldCBvdGhlciBjYXBz
IGFzIHdlbGwuIExpa2UgInMtPmVjYXAgJiBWVERfRUNBUF9TTVRTIg0KPj4+IG1heSBiZSBWVERf
RUFQX0dFVF9TTVRTKHMtPmVjYXAsIFZURF9FQ0FQX1NNVFMpIi4NCj4+DQo+PiBDdXJyZW50bHkg
VlREX0VDQVBfUFNTIGlzIGFuIGltcGxpY2l0IFZURF9FQ0FQX0dFVF9QU1MgbGlrZSBvdGhlcg0K
PmRlZmluaXRpb25zLg0KPj4NCj4+IEknbSBub3Qgc3VyZSBpZiB3ZSBzaG91bGQgZm9sbG93IGFy
bSdzIHN0eWxlIHRvIHVzZSBWVERfRUNBUF9HRVRfUFNTIG9yIHZ0ZCdzDQo+c3R5bGUgdG8gdXNl
IFZURF9FQ0FQX1BTUy4NCj4NCj5IbW1tLiBUaGUgZXhpc3RpbmcgbGlzdCBpcyBhbHJlYWR5IGEg
bWl4dHVyZS4uIFNvbWUgY292ZXJzIGJvdGggU0VUIGFuZA0KPkdFVCBkZXBlbmRpbmcgb24gaG93
IGNhbGxlciB1c2VzIGl0LCB3aGlsZSBzb21lIG9ubHkgY292ZXJzIFNFVCAobGlrZQ0KPlZURF9F
Q0FQX01ITVYgYW5kIFZURF9FQ0FQX0lSTykuIFRoZW4gYWRkaW5nIHRoZSBQU1MgbWFjcm9zIGhl
cmUgaXMNCj5maW5lLiBZb3UgbWF5IHVzZSBhIGV4cGxpY2l0IEdFVC9TRVQgZm9yIFBTUyBpZiB5
b3UgZG9uJ3QgaGF2ZSBhIGdvb2QNCj5pZGVhLiA6KQ0KDQpPSywgd2lsbCB1c2UgR0VUL1NFVCBw
YWlyIGZvciBQU1MuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj4vKiBFQ0FQX1JFRyAqLw0K
Pi8qIChvZmZzZXQgPj4gNCkgPDwgOCAqLw0KPiNkZWZpbmUgVlREX0VDQVBfSVJPICAgICAgICAg
ICAgICAgIChETUFSX0lPVExCX1JFR19PRkZTRVQgPDwgNCkNCj4jZGVmaW5lIFZURF9FQ0FQX1FJ
ICAgICAgICAgICAgICAgICAoMVVMTCA8PCAxKQ0KPiNkZWZpbmUgVlREX0VDQVBfRFQgICAgICAg
ICAgICAgICAgICgxVUxMIDw8IDIpDQo+LyogSW50ZXJydXB0IFJlbWFwcGluZyBzdXBwb3J0ICov
DQo+I2RlZmluZSBWVERfRUNBUF9JUiAgICAgICAgICAgICAgICAgKDFVTEwgPDwgMykNCj4jZGVm
aW5lIFZURF9FQ0FQX0VJTSAgICAgICAgICAgICAgICAoMVVMTCA8PCA0KQ0KPiNkZWZpbmUgVlRE
X0VDQVBfUFQgICAgICAgICAgICAgICAgICgxVUxMIDw8IDYpDQo+I2RlZmluZSBWVERfRUNBUF9T
QyAgICAgICAgICAgICAgICAgKDFVTEwgPDwgNykNCj4jZGVmaW5lIFZURF9FQ0FQX1BSUyAgICAg
ICAgICAgICAgICAoMVVMTCA8PCAyOSkNCj4jZGVmaW5lIFZURF9FQ0FQX01ITVYgICAgICAgICAg
ICAgICAoMTVVTEwgPDwgMjApDQo+I2RlZmluZSBWVERfRUNBUF9TUlMgICAgICAgICAgICAgICAg
KDFVTEwgPDwgMzEpDQo+I2RlZmluZSBWVERfRUNBUF9OV0ZTICAgICAgICAgICAgICAgKDFVTEwg
PDwgMzMpDQo+I2RlZmluZSBWVERfRUNBUF9QU1MgICAgICAgICAgICAgICAgKDdVTEwgPDwgMzUp
IC8qIGxpbWl0Og0KPk1lbVR4QXR0cnM6OnBpZCAqLw0KPiNkZWZpbmUgVlREX0VDQVBfUEFTSUQg
ICAgICAgICAgICAgICgxVUxMIDw8IDQwKQ0KPiNkZWZpbmUgVlREX0VDQVBfUERTICAgICAgICAg
ICAgICAgICgxVUxMIDw8IDQyKQ0KPiNkZWZpbmUgVlREX0VDQVBfU01UUyAgICAgICAgICAgICAg
ICgxVUxMIDw8IDQzKQ0KPiNkZWZpbmUgVlREX0VDQVBfU1NUUyAgICAgICAgICAgICAgICgxVUxM
IDw8IDQ2KQ0KPiNkZWZpbmUgVlREX0VDQVBfRlNUUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQ3
KQ0KPg0KPj4NCj4+Pg0KPj4+PiAgICAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEICAgICAgICAgICAg
ICAoMVVMTCA8PCA0MCkNCj4+Pj4gICAgI2RlZmluZSBWVERfRUNBUF9QRFMgICAgICAgICAgICAg
ICAgKDFVTEwgPDwgNDIpDQo+Pj4+ICAgICNkZWZpbmUgVlREX0VDQVBfU01UUyAgICAgICAgICAg
ICAgICgxVUxMIDw8IDQzKQ0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9h
Y2NlbC5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+Pj4+IGluZGV4IDJmZDI2Njkw
YjkuLmU3MzY5NWZmODMgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNj
ZWwuYw0KPj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+Pj4gQEAgLTQ0
LDYgKzQ0LDcgQEAgYm9vbCB2dGRfY2hlY2tfaGlvZF9hY2NlbChJbnRlbElPTU1VU3RhdGUgKnMs
DQo+Pj4gVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZCwNCj4+Pj4gICAgICAgIEhvc3RJT01N
VURldmljZSAqaGlvZCA9IHZ0ZF9oaW9kLT5oaW9kOw0KPj4+PiAgICAgICAgc3RydWN0IEhvc3RJ
T01NVURldmljZUNhcHMgKmNhcHMgPSAmaGlvZC0+Y2FwczsNCj4+Pj4gICAgICAgIHN0cnVjdCBp
b21tdV9od19pbmZvX3Z0ZCAqdnRkID0gJmNhcHMtPnZlbmRvcl9jYXBzLnZ0ZDsNCj4+Pj4gKyAg
ICB1aW50OF90IGhwYXNpZCA9IFZURF9FQ0FQX1BTUyh2dGQtPmVjYXBfcmVnKSArIDE7DQo+Pj4+
ICAgICAgICBQQ0lCdXMgKmJ1cyA9IHZ0ZF9oaW9kLT5idXM7DQo+Pj4+ICAgICAgICBQQ0lEZXZp
Y2UgKnBkZXYgPSBidXMtPmRldmljZXNbdnRkX2hpb2QtPmRldmZuXTsNCj4+Pj4NCj4+Pj4gQEAg
LTY0LDYgKzY1LDEzIEBAIGJvb2wgdnRkX2NoZWNrX2hpb2RfYWNjZWwoSW50ZWxJT01NVVN0YXRl
ICpzLA0KPj4+IFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsDQo+Pj4+ICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPj4+PiAgICAgICAgfQ0KPj4+Pg0KPj4+PiArICAgIC8qIE9ubHkgZG8g
dGhlIGNoZWNrIHdoZW4gaG9zdCBkZXZpY2Ugc3VwcG9ydCBQQVNJRHMgKi8NCj4+Pj4gKyAgICBp
ZiAoY2Fwcy0+bWF4X3Bhc2lkX2xvZzIgJiYgcy0+cGFzaWQgPiBocGFzaWQpIHsNCj4+Pj4gKyAg
ICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiUEFTSUQgYml0cyBzaXplICVkID4gaG9zdCBJT01NVSBQ
QVNJRCBiaXRzIHNpemUgJWQiLA0KPj4+PiArICAgICAgICAgICAgICAgICAgIHMtPnBhc2lkLCBo
cGFzaWQpOw0KPj4+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+Pj4+ICsgICAgfQ0KPj4+PiAr
DQo+Pj4+ICAgICAgICBpZiAocGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKHBkZXYsICZi
dXMsIE5VTEwsIE5VTEwpKSB7DQo+Pj4+ICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSG9z
dCBkZXZpY2UgZG93bnN0cmVhbSB0byBhIFBDSSBicmlkZ2UgaXMgIg0KPj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgInVuc3VwcG9ydGVkIHdoZW4geC1mbHRzPW9uIik7DQo+Pg0KDQo=

