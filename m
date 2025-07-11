Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ED7C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 03:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua4Me-0008SJ-1Q; Thu, 10 Jul 2025 23:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ua4MY-0008Lz-1I
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 23:23:50 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ua4MW-0007pW-6F
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 23:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752204228; x=1783740228;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RmnBhgfIosLwnI9Tmy8LeBgZhlfszZ83ozLTgNr6SKw=;
 b=VvpWfz090Rr7kTd/YwxpIqhnEDYFf3zrWvtURCZ1+rrttjb8zLLZlBoc
 k3PYUGfhdsP4BVSGpL5EE9LBK0ARbRF2zur1uQbO7OSPeqTE/sj7lYRff
 T/7z3CIFOP2GG5Cg0cUkesvaFq5gV8I+YuwSnWqWgqRIkouCEZ65EEjyn
 ub1Ex8pFVzClgyxV+RDVtcGar6hk62gMYa7HBrU+1wqTCjBZS5EzxB+xk
 X5CW/pNSxejyobPbjyjHc7MXsJR+GE5wW/CTtsg/KbGQ4pJa82/BBChYP
 gOoJsiKhtGGlbA6KwDhzDEDHY7otj7xHDAQq+wPmleX/V6eiQD4JDRWMM g==;
X-CSE-ConnectionGUID: 0n/y0wX1QuOzyRuSRy7+VQ==
X-CSE-MsgGUID: 8wXCyZAdRUycR78L7k7fNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54472076"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="54472076"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 20:23:42 -0700
X-CSE-ConnectionGUID: u1RtgY10S4S8JV6ARPwGiA==
X-CSE-MsgGUID: ULVX9IXuTyOCkaIpyDSG0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="156750905"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 20:23:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 20:23:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 20:23:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 20:23:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5k/7ch9ntGEFaicwF9DaMn8S/NPpMMdoSQg/9vrKmGphrFaA/NgkbEjCbmIaBieo2P1VjupingWIO3chipU0ImHe6pQg02F8byv4EVmw/Qi6iHOoTs6EjGdzLqoFoRVeliBvnXBbVSzl6DhZt66iZbtq9bcRglzw+L5/EwBcw3LAQQbBdQufyyCEi6ZFB92lxgfDFJIKAinWEi+qTajeSsHllIohD8Obfl5XTy5H1OTx7g94p0DriwgvDJHsjsWZK6byX+VA9VDctQbZDFqA1HbrlS40dmcWRYCYaHW8ZN3z3d9R5WB6liYy/RO7DClhSPF/O6wyANtd70AoELTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmnBhgfIosLwnI9Tmy8LeBgZhlfszZ83ozLTgNr6SKw=;
 b=NpPsKnpB3/pQol4KKTNmJ+T81Go9hZaBIlKn06BuaCfSte3pYApKPx8DulTRbN0Yj4PhTDPR/DwFGv2FElq3q9izVX6cF0mHR1kmkPKf+rymsyMYo0Y3s3MUcUn7U77ncI6mYwLLcv0z6JGVvlg6NNlG9IzeyQFvwThEJTzIyrrKRzhKAphJZnf474wDK0qlcToY5r6s68L47jFhodNU8RWEx6mgPA5aTPOaLzcrGIEoFTQV5MPisLt1l5zUxdAD8l009p8zxptxzF4TH9q6rYd/owo9EzYgrx11qL9RrfQFO5nIENGOoJp6/c+qr3GNVul7pNOucgJ5eJxtlY6bGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 03:22:55 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Fri, 11 Jul 2025
 03:22:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
CC: Marcelo Tosatti <mtosatti@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?=
 <berrange@redhat.com>
Subject: RE: [PATCH] i386/tdx: Use .has_gpa field to check if the gpa is valid
Thread-Topic: [PATCH] i386/tdx: Use .has_gpa field to check if the gpa is valid
Thread-Index: AQHb8aYvV7X3YZungUK12BADGelJb7QsQooA
Date: Fri, 11 Jul 2025 03:22:54 +0000
Message-ID: <IA3PR11MB91361C1544A1E97F2DD123A5924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250710141512.170302-1-xiaoyao.li@intel.com>
In-Reply-To: <20250710141512.170302-1-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW4PR11MB5824:EE_
x-ms-office365-filtering-correlation-id: 24c6521b-3b3a-418d-6cfa-08ddc02a39e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TKRkCpspOffKPezhoX3UTNv+AbNTEpNoIeroWzzUlxXlCiyLnnl8KViyix?=
 =?iso-8859-1?Q?oGQzEJKx5U95RCN0z8aLv+yRSK/BfrDe13MWuS5vNjJC4vCQ8OxNHx3MTp?=
 =?iso-8859-1?Q?EbsqqNJpW+R3oNB8u4LsIITWCzMHU9o54S3CA3OgA8DH3qJQoBGO+N18nS?=
 =?iso-8859-1?Q?Mljpk3qRjEw+6L3VpBMI1Dnw8Xo6oSIQDgFdvLUR02pc18G9oO9X44o3Al?=
 =?iso-8859-1?Q?+EAKQEkIbdfi8h1j9ECLrX9lvqXw9I2mjRlBIhGlkW1V8F+2lWoJ5N0NME?=
 =?iso-8859-1?Q?iXZmVpSa18Rotb6fw5cDgCaCkVgO9acYulo7t+Z4rEfek9V4g3Q6jQXbQq?=
 =?iso-8859-1?Q?yfOLj67ccnFKUqq07XR2v4WovKzcVIvrRG2P3r2/kYeBL6BP24hGhrBHxb?=
 =?iso-8859-1?Q?7gmAX7l2YSCKhsnOCkEqSFyzeab5cA31XRq6Z2FJ3iHU1DsQR2cr1Rh4y1?=
 =?iso-8859-1?Q?jVlIv0IQx8rwj2SnZBPm4u3bS0KAaCcDwlJS0hYiFQxqjDxmDZiEA811PS?=
 =?iso-8859-1?Q?Vfkd5Al40HnCOZOl3qGqYZVuZ2re89qm2zHQZgz3e1OTuQKvr2u/ov2MQE?=
 =?iso-8859-1?Q?ckNvnBveGJGEyQJD4pI+7exqNsw/WCHMivQsy5+7Pk0zu/NNODgntpnht4?=
 =?iso-8859-1?Q?U79L3h0Ejn4DkIuCIWL1z4YzBCr1JHDrqVtlGZgvHUSPepxN0VZkbZFXw1?=
 =?iso-8859-1?Q?8NIjmMQCY1BR95/ZBQuPhX3ETTbSf3/V92WXxKn5/23XYr7P5HhKLHrQ7j?=
 =?iso-8859-1?Q?othHXYNjyr0NOGXvJMqYtHcRPsmFV9zgHrrQFxDQvDt9o9U6Z9hYUwFCBq?=
 =?iso-8859-1?Q?eS2Eqg1zmf0veScVGB5VmoLFd4xW7Aleh5kqoYbmx2keS5ydrLbczRbqKj?=
 =?iso-8859-1?Q?ivwxo6bCB+/NGJpRscvSjnn+hN0E/n6vmY3jN15VOfMd8A6tPWKmqncxM9?=
 =?iso-8859-1?Q?InU/f7HiL4DrxPEgCRyKnnwtWEF+e3JGHfPGv/X5ATroKAuHjxAY8lqeZE?=
 =?iso-8859-1?Q?rU/kv51AWqyn7J2/cNJmOn7C1laxvBWrO7EfHRkTfE3cY5IO579uYSQbI/?=
 =?iso-8859-1?Q?87EIsQtZf1eI85jK+eeO0geahNVv3mU9sFZ0i9arMepyp5uxWYZGy/O000?=
 =?iso-8859-1?Q?/1HhrZZ9NlcYA6C+yf1cFKIPIAncv1WWCB9LI8LTkGV5AyJxke6gqZdXFP?=
 =?iso-8859-1?Q?yfiRMEnweRAvnrGp4OSvE/cbZOxgkiACd8Vv84bTwjoZkQd13ETgH5p/Tb?=
 =?iso-8859-1?Q?c6LjNokYd3mUKkocgxUgPsVXijswi33nOccLvzllW5Mh72Kpzla/LZOo4R?=
 =?iso-8859-1?Q?/hZbTN4UXheupu1K0sEXNYhgoPDoS/9c6BmKD8ePsG6BI5sa2Guzog7Tlh?=
 =?iso-8859-1?Q?e/XRzS8QOayFubao0r/Chw2YbJG7YYwRcvtl+LwOjhJdqXFLZOCqYLqje2?=
 =?iso-8859-1?Q?U7DB4smvsxVpUQzQz+5l+3w0dgU0Tvy2nnLESNHlCkF/yx4wwLsHjsHVC2?=
 =?iso-8859-1?Q?A0PQMaYI4cq08Lzsn1SJmwayIGbvX5Psn1PO9mZy6yYLoEYkTNQd5su5uM?=
 =?iso-8859-1?Q?xcLDTnM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9NVlZ0GxfGLCB1etj7ojUklJGLWUiNiLqHTFPKtoW5zV0guPDnUptAXkl9?=
 =?iso-8859-1?Q?kzafnDlbji4gTDdNOx7pcGjErsOH7WiIu1lWO7AHdNRs8gyYeRnWE49OR4?=
 =?iso-8859-1?Q?hRP0sTLJhu0qOni/cxBocWKmJBoexOPyY1VSoHm3Keq82W7MMqsWHX5tsA?=
 =?iso-8859-1?Q?n12SdxInOmAAYb5JV75ZKCMc7EJpJPctjcKSD3HkNNkL7uKG7SdHZ+HpN4?=
 =?iso-8859-1?Q?nhI5eLUw+jfe6g5Dl2MElqYbssQJtIxJhW5b+rI78A7x2p17T2OYos1YxA?=
 =?iso-8859-1?Q?Ygox0miljahP7BSnUqj/+TnlZVRDpZ1K7fRbxd8nwIqT60575Mo542ef8/?=
 =?iso-8859-1?Q?ZYru01nCT7xCU2PQWD4ChvtkpUz9KjOLIV13TLWHo92LpeJmmcxWkQcrFS?=
 =?iso-8859-1?Q?OKlKbAjbFFfKOUQk2TIcNKxH7Go1K73+u9eqdPIlOgAWYXE7f/xdzWMTiL?=
 =?iso-8859-1?Q?QGOF1nEVxOaYMN+AQ9HlGzB6eythb3hUt8m7/g+/nZCZraijPGASxEgdJ6?=
 =?iso-8859-1?Q?vknvvV5fBgsIQTolkP7bXU62E5WNemJn+imy/Rm3saatDdYEZpCtnpnoR7?=
 =?iso-8859-1?Q?l9RRqYuNO8cFBn2X6UcrY+ZK5C4WmNP1m2Z00yOCqNY6WIYTsaJ2/MLeFB?=
 =?iso-8859-1?Q?1vob7pQZ2GqQkPTjyikqz6Mo5WVrxmpHq5xPV/YEjucYmlUzV4GGW9a6eJ?=
 =?iso-8859-1?Q?7KB6RWhUka9tBpFP9p/RUXSQnM6PGGM8KUzbFrUP8NH3fR+uSJdQQxM07i?=
 =?iso-8859-1?Q?CsYAu3aN9dki+zxYiS/4k/yLR5yGE1+WbOKhINl2f0wRPz1M+Du8hRByoE?=
 =?iso-8859-1?Q?HeCpIAaXDwGV1I/3TceSMND5CkDgvkclAt3cLOyKGmJUuFmT5Jm/WyVeh0?=
 =?iso-8859-1?Q?f8hzyPlWjWea8brlo5bsVnlreqtbx54w1wvJWpF6U8tbOX3MjjzR0cDskL?=
 =?iso-8859-1?Q?3k1w88kGrR8XXEIpytJgQUrTP0+TuQHBBdzc3te4KdQEFXwSZmORkeAHN6?=
 =?iso-8859-1?Q?99PANIsaSnOHxQUqPJU3BRoLLCBpVM2m5utddma3MMgVp66QE66WXY1KPu?=
 =?iso-8859-1?Q?BEUpxFPHS+td34JGKNF+Wpr8n9JSfFRzJYtcrlSRxSwIR6B+KooJUsq/iM?=
 =?iso-8859-1?Q?8EyMxIt1zufsPqUufEaT64BpPmeyUWH+c0fzO/mjg0i/KKL+5XQaAkdjmm?=
 =?iso-8859-1?Q?6M4Ujrm3P547KwXT6LEZz5XBq2yWnghKv1tPOg3D2osjBS5A6XoRoma3V8?=
 =?iso-8859-1?Q?LjYQfoIfypji60sqa/lE4Zcehd1IHLdCQNz2wo5IPsEroVuzDmlwmfSxTX?=
 =?iso-8859-1?Q?n84zMXlqIchDsTuEvZyUZhf7Li62w/lGkj5Y5BMeU/4LNM1vxV0TOAgOuQ?=
 =?iso-8859-1?Q?Jl0TQSqTWEqpFbOMiC6h2MLHHT046f2XUF5uHYPmIIpnMvjWvdZNeVAGq2?=
 =?iso-8859-1?Q?HQucRvm/Yy4YNbrWekrVlULBZMJ8bDMU33tCEERgGjwtwOX9XVbwGrbHvj?=
 =?iso-8859-1?Q?Vxu0EelHubsweNqFzKAk/r1qcTxIfh5PbHrSYc/czJiK6efWpjOkggM8xb?=
 =?iso-8859-1?Q?Dg2HBcx3pcOjm2oF2+TkHwN7V6pQo1NyuCMYRC2wrk3ObFXgFEWyuoAUuO?=
 =?iso-8859-1?Q?mMnL3S0uJrBUOjdWRfJFuMD2G8NVQTuplG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c6521b-3b3a-418d-6cfa-08ddc02a39e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 03:22:54.8319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6PTEd1MaJBgaJBwxMVADP2UvqVgP57zY3PkpINYUuh4QHPT/FhaBaJaGojmGhrvdUxtONd9xLemllwkw/6+LIKeYYE5RhjDT45bBMPT67M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5824
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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
>From: Li, Xiaoyao <xiaoyao.li@intel.com>
>Subject: [PATCH] i386/tdx: Use .has_gpa field to check if the gpa is valid
>
>There is actually the .has_gpa field when translating the QAPI data
>type GuestPanicInformationTdx to C structure.
>
>Stop using the magic number -1 as the indicator for no valid gpa.
>Instead just use .has_gpa field.
>
>Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Good catch.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

