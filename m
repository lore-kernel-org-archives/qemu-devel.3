Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3F7C55162
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqn4Z-0002o8-Qb; Mon, 03 Aug 2026 03:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wqn4X-0002ne-I1
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 03:26:53 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wqn4V-0005XS-UN
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 03:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785742012; x=1817278012;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=amrWlbRWP8sAkiC4QdpEDeiK9m3REgOmyFqh8Q/Eln0=;
 b=OHlBvNUV+laeg25ky7imJJMfpqKUcsWDa/apYQ10fGMrphPUh4Xiy948
 iOuc6vGaFO/2JkYbbhgKfo1E37aJY2o8HSswre5uz+XVhPFdYffATv9fG
 kjToU3qtX/YWA8XVL0OuINnmMbweu2qv+g5pOFEmcCXEUttgxbdifoOjc
 AXJVzghTaVTm8Re/1qOUTyx+3ZYb39pQsPd1gAkdg6pF/MtLOgyX4p7+I
 cTlGx61QH7pWNMhQ0iKiCCGIkobL+FZ1X1J/kJEGLxXmSSqgr1HIl4cHi
 N1G75h8/cjxlpEcwhceZa/afa4AXQtPUntARk1c2V1o769onVlVQCNgcS w==;
X-CSE-ConnectionGUID: t9gciViiS1arBWUjF0Hf3g==
X-CSE-MsgGUID: nJOSuLC4SOyDPY09p5nCgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86394532"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="86394532"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 00:26:47 -0700
X-CSE-ConnectionGUID: MU+ZitkRR/W8o2rgqe+RCQ==
X-CSE-MsgGUID: kcBlOH2YR8OuQOfmL8LGPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="284532709"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 00:26:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 00:26:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 00:26:47 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 00:26:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6fBMPJUiQ/fulTFp8SqBNwqy2lF2cTl05fUcRxewFjrymNyfZYxzXcR82PlclbQN0v/ZbkKofNr8Q0RrWF7VUzG8fz1nkih6lE3EKg7PEUGqEOBm8wn3vg9Wo4zkQeyAz7AJ/Oy/4BcTmpEI2kan9YDJIQYG4h9asJJqaG8Yxlms/tuSUTZAGAx3WKkp4AcY3u1oV+r3JppI5CvFDlvNwTKdxFNuP79XyndPNDan7pnn323XGaY02KQi3bXcG9gNSU1tX5soKQ4bUC7M3HEt0414d0tYfK/khQJ4XMzysyUOL9vEx96LWJIvrRdasfo3tF4Ss31rOACFTrh0xzf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx5H4V05RGjsZyybYsTyUsOMBYAG7Rzz3lQTMKjnb7U=;
 b=AUmPaHPuaDuiit8R7tmM0+utA8n9cDoEBGtZNnSTzxL04tP9u9eUoAaZtdh1hCBUTi0wc/mfzysb/NXrD+cUsUHoHJYeIBwh1z2dFGgtSsa2y4kAovJfpVLINg7AntmtGOf0gSZ2Fel/LBhESunWDU7aezXkpP7GviIWjwceVRmvGsyK/IOf57k157d9SK6pTQyXROzIR1lxvY0Gm1OXN649veeLIqnFOG4LjME3rQy2Bt11VFuByYgnRAMgkq+zvp1/Aiv+27n4GxENHMnTWQZIZe6WhsU68MmNqG0xOFnQ4AaMN2t1KGX4UdopillhZBuPgYzan5iKhG90CwbXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS6PR11MB044113.namprd11.prod.outlook.com (2603:10b6:8:4c4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 07:26:44 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 07:26:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Topic: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Index: AQHdIpiwj2+asGS6SESECAGeCbz3Y7aL6wfQ
Date: Mon, 3 Aug 2026 07:26:44 +0000
Message-ID: <IA3PR11MB9136485848B1212FBC2A440392D52@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS6PR11MB044113:EE_
x-ms-office365-filtering-correlation-id: 29bbc733-6bcc-4b66-6117-08def1309217
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|38070700021|6133799003|10067099003|56012099006;
x-microsoft-antispam-message-info: nzOWXkRXv6HAPXqWXyH02atGmFGFvPXuXdGWKalLjcD5Ta+HXWdaKZvv9HkJ3jjTvGJPpEe86BqxukGckv+8D5o+j0foe+35Qzc3vZMSvTD1Zrexm05i3O4l1QqY0z2ZWGkzKCXSKF/+/7JIchwV0JC4LUPWOOcA14OZNk6vJIC4JvF2A0VwLzwsM71BqVWFv8mafZOiBvqkWKxItp7MhmBfTtG/fp2L0y4iaN5btkwvxutCnphTyNjTMyWHOdBCKVUehAB6Ltp9Gl89SlZarrRZ0E5T85y56DBY3bWvWzuwN/VisXJstMmQp9dKvI+Ya5XbyU4o2+ptKcwHWXKYsJ8qbTf04ZJbRifItXFyQtVTkml9AZRxOf1ErkjLbKp/wOZX6QSXAC8xvJwGPgSE7FACBx7WNijVM2VkTnzX5TY/SZZTklWAiNumMthDQEk4kFqP1fONnDoMDqHJnAUx18+KB/f2f7x28K2Z1ysiu3mkZV31gpL25QKAxjQPRRq3yDJ7Juq/ejxDtTB52FzLFOo7AEQC9PlfJbH3ysBbSWUymNbkdDfsstHucMH7X1R92yCM8NTdVTLCGY4WPMazECAxvQhD3bIyjRdDe6+9lbvL6LTbR8mPfKtb7nuPTI+76Gq9qotHaS/G6E3zcJcmhc9CRW7G+PxvL9SOGhULz/wxDWbbf65xp92TMcbLP2TLEVCCvNAdUmaRyO0BqbOKTddsiM8d0kTf+X7UWH3mps8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(38070700021)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N2go9QOn6K9BH8fsRM/iX98/wQWaV53bpv0yGw1a5IO1x3V3CuUpA5m4e4?=
 =?iso-8859-1?Q?DkTROwqp2Ir/ybwgNSH61NmIPiMsqAWyAX87xmXi8/I2fkpFH9RWb3ebh0?=
 =?iso-8859-1?Q?fhfWWJX6GCelNTt9YhZUtn+goe9AWDAuS0lJT5fFMRvMsw2NAENzz54Gr7?=
 =?iso-8859-1?Q?Oq8yAl+SwiVxrE3cxpgrXq0h0eaXt52Pkw8P8kwNkScTc3sbIRrW/aUuMs?=
 =?iso-8859-1?Q?uCq/ZeDkH6jGu36i0Ufdgpzo9nnEyTdukrjWRQEHB2ubThxNeX0Qt+ILY+?=
 =?iso-8859-1?Q?6jXVV4J5muYXHg6zNnsgH+Wn9wDktExZ4xVjyb4zfJimci0YvTHwHDW7sJ?=
 =?iso-8859-1?Q?f9yE9IfD3a7i0gXH9MHZwMpsqnK2GS6OJcQXYMhE4NbPh5RlaLMTggITQa?=
 =?iso-8859-1?Q?usJUQXmidoFm+iljLF5qpHdudHabg+n1SUmRG21TKUcqF8Iuzfqk8bv/3a?=
 =?iso-8859-1?Q?41ljUwFAUUJsjevXtk4gqcxj+EKA4D/6Am5nyOosmX6PVU9wa1+gMKcW2w?=
 =?iso-8859-1?Q?l5XowVC3wAbRftgaTpxMQXbI8enCdY30kB67VP71p8Xj3Ou6Ws+32yzP65?=
 =?iso-8859-1?Q?ml7q6Fvih+D2+hwwTrf+e8uouNcpDBiXQyfX+31t1erWMiGiNUnUtihaza?=
 =?iso-8859-1?Q?ANsw/Q2UVE5+Q+TIWGydb0WMgyvd+G/wAXU0CUk/zKt8gdqc4tkBhsNOFq?=
 =?iso-8859-1?Q?gVoarspEcNmpENPpKE+8tWJNiiuYncRzl3NxZkclq6sqOCdmdbYbCjG/dU?=
 =?iso-8859-1?Q?bF38UMbj7UjFZIso50WiIXq5uXKDfVdhuDMxUFrTVLpiNmOO3cZhqs70Vm?=
 =?iso-8859-1?Q?SiHu1chaVC1rsxeFTdDLO/BU2MoStglhO1vhLCmC6dk7lmgMphaqJ2pDxU?=
 =?iso-8859-1?Q?oDL72o+J2jAbxzZJzAaiYifXzlPCecqFQ4hvfi6pccq4/llvd8JTgMNcEo?=
 =?iso-8859-1?Q?XKSNGeY10LQK2jgPrACse4a03ROXjCjJXwjCiyLm+S583GnTRdw0BKgNHH?=
 =?iso-8859-1?Q?Wq1BYQfSZztIowOBBBvjHjKYgToiWvt5Zy+/EvV10+X/KdOok2tm2IDXrP?=
 =?iso-8859-1?Q?ySpH4fACX5qFopIdRG9/LBK7YzErKYlPRH9eL+of4h2ocWI606yTxw2djx?=
 =?iso-8859-1?Q?Xf7ZnKrseniXy+Om65pw1gc3+b/1JyfbPEJY+RINabKQR6hl9QLFp8dGLN?=
 =?iso-8859-1?Q?zaVn/Dj/EskUeUplIq0Y5gWzupuUC4GqBLv59NaqrFTsTLbtsKZy9dv/d9?=
 =?iso-8859-1?Q?XdDSkRnZ8szCRCUv+BORvqBl/qSFHUJtpQHJdE3WtNLoxCUR5fNS5zZPGO?=
 =?iso-8859-1?Q?uwpeE9JH63BF43jtFJlcEC8DC9GiDBa+ip2DwWj2iY5TOBFKTKjet66mK0?=
 =?iso-8859-1?Q?+Df+NUgxLD1KqlM65ataes2t1aXCT/drXIimrBRg8FNIia9iHYxrRpTfTr?=
 =?iso-8859-1?Q?W4l7IDxGlLNleEKjzai9bHlCU8mzY1HiyY0f/RL8vUfRbsCckDMpiGJRQ1?=
 =?iso-8859-1?Q?Ak9kiRVYPzyV9bD4F+g9JH1eXBZ+OWs+fiQEbjbwhyU/wLDcGylIGK6prS?=
 =?iso-8859-1?Q?LgNw9zQXfsYXbVx8B73H6SaUVBdKovRS3QYskJYAnQYEu7Q7HitSOV05kk?=
 =?iso-8859-1?Q?6+gzvrDHYBsv1U6oGIGv9IGnKlaoplPu4xPiJTTwUvfIDYqZdULikeB+y7?=
 =?iso-8859-1?Q?lPeMEq1mSGoQuDAc7E6gwOVhDtV8iOuSgvQAO4Bm09tMe/3kruyDo6FCjZ?=
 =?iso-8859-1?Q?+CX7Q98sNSB9hNw6yl0ZLNil2TpGbcKkunbNRLxWHyNS0TC6cdEKlj1NJK?=
 =?iso-8859-1?Q?cWybfvFfqA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BoKjw+Lof5pN9XvhKdmtPAi1hD+Dd3y8GoEf0uMZ8Fpm8DU4IPOyW+mVa2CdsZP/zkGXRlkVCR8/kB4lrKtnl6OqewK8TOWEhSug2unpHGnDj8yJxT6mxugQ5HpVew8NlwIkeuwBp2u9SKa1qGm9ejbIqmHaRj4jaTVwzTZ5Xk5so65b+FDn8sOnDCP8bqHpkwx24oQNr0fBr4KnPIQpON2TfrJDtfIkQQGGWiDxUSTkS8oxLV15K/dLyGDIOq30tNZPF+ger9IqnGWOlCIz2f7lF8Y0yb9+1jcPY6iAbbrV1a4tJCVJEaCZCvAbYMcps7V8hHOVZgKxkT3tSo1lrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bbc733-6bcc-4b66-6117-08def1309217
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 07:26:44.4629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EY4KJxSkZbeAv7lNZwPRSrLiaG6A0vZEoWp8o3iosl81xrR8fSbjU6ZK4DaEfsSIFXACs1dQGL8cj27/Y26YteDdYBJasVzo6PLW/Trq20w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB044113
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
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
>Subject: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
>
>SVM in Linux requires SMPWC as of 780dfed68862. This is free in the
>current implementation as it is already in line with the expected
>behaviour.

Not an issue in this patch, what about 'C: Page-walk Coherency' ecap bit,
I think we can enable it too? Maybe in another patch?

>
>Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
>---
> hw/i386/intel_iommu.c          | 3 ++-
> hw/i386/intel_iommu_internal.h | 1 +
> 2 files changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index 8245452d89..9f21622a4f 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -5108,7 +5108,8 @@ static void vtd_init(IntelIOMMUState *s)
>     }
>
>     if (s->svm) {
>-        s->ecap |=3D VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
>+        s->ecap |=3D VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS |
>+                   VTD_ECAP_SMPWCS;

I think we need a check for passthrough device to expose SMPWCS, something =
like below pseudo code:

@@ -37,6 +37,12 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,
         return false;
     }

+    if (VTD_ECAP_GET_SMPWCS(s->ecap) && !VTD_ECAP_GET_SMPWCS(vtd->cap_reg)=
) {
+        error_setg(errp,
+                   " Scalable-Mode Page-walk Coherency is unsupported by h=
ost IOMMU");
+        return false;
+    }
+
     if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
         error_setg(errp,
                    "First stage 1GB large page is unsupported by host IOMM=
U");

>     }
>
>     vtd_reset_caches(s);
>diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal=
.h
>index 924e91cb8a..df7a0efa6e 100644
>--- a/hw/i386/intel_iommu_internal.h
>+++ b/hw/i386/intel_iommu_internal.h
>@@ -202,6 +202,7 @@
> #define VTD_ECAP_SMTS               (1ULL << 43)
> #define VTD_ECAP_SSTS               (1ULL << 46)
> #define VTD_ECAP_FSTS               (1ULL << 47)
>+#define VTD_ECAP_SMPWCS             (1ULL << 48)
>
> /* CAP_REG */
> /* (offset >> 4) << 24 */
>--
>2.54.0

