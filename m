Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD7ECA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 06:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvVOL-0004L8-B9; Mon, 08 Sep 2025 02:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uvVOD-0004Gm-73
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 02:30:09 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uvVNU-0006Ng-Nm
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 02:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757312965; x=1788848965;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Mi798TroauoN/cGBrml3/96m33aab277fcqjVspqTT8=;
 b=fN80/nk3E7Uo+yaZG0jgsbzWOiUCdv2dbLn5YnyqcUzbbAtEap1TpIzr
 GFhsshgishZn4mjoMIH0sfvI+ycoDl+jS8gWAU09G1H8s370eeSezzovY
 bKdbEGPR2nuaRwle7u7tFKVM6IAhYGKkiQm2ECXN1FhGI5UOHabu05q9o
 FNSGX8IJ81pz4/ypshKJ6ouE1Vbj+JavIYT4QzK+4T3smT+l4nV40EUX/
 3fo+mmoc68UH+mInZcnw31/le+FZkV3RBcvNI1sIZGIo5u0VqAiCUD240
 zc2XizWbsvLDZSSKOJjvBvq9whTvF2mBIqkp2oFU1MXXoIxS4WCON3oel w==;
X-CSE-ConnectionGUID: f/JVzCnSRN6XhFC8YMNg8g==
X-CSE-MsgGUID: hkVDNf+vSN2WBxtRK+9bNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="59420158"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; d="scan'208";a="59420158"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2025 23:18:53 -0700
X-CSE-ConnectionGUID: nwdMRvHEQa2NlZLK5MJyXg==
X-CSE-MsgGUID: gk9QLeYATKSf9hwn7lEVng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; d="scan'208";a="203492334"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2025 23:18:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Sep 2025 23:18:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 7 Sep 2025 23:18:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.51)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Sep 2025 23:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNBwuzQkJ0GMHlk4CTq3eOuRGiNrQjZkmTrc8sVFrWDPuFvHTapy5p7cxvt3WKP5lZGqEsh50kPu2ktifWEu+5OuH2T+SperkwDoWt5zVOT1Xk71SD3O20dkS/u7a2iJjnWYMWC6WOk/ypG7gRs9Kf0fqGVRmvAAA7iffDXWJweQADkaI5dBMYSRuLTaarR5DwD2D0ufBxxmUZM9ii+Mucm8mLZLKr60L9H5/+kTKjMBYi9BvIpJ3y2avf0hfc6m0/lVfvWbQ8uofpxh6QYfw/GFVWmdfDJRkwmL0Ud9+zcXOL9rB/HbMA+slktXi9uXC1fn0jvkSI2cmo3FsXIG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPRLJj8T2oRnWGj7+y6L8qB2gGkGF1oqVTF1j226m1Q=;
 b=v/flCdYVPpBPXTW3YNIwpmnab+Hscud5b/eEdJOez29YxF83NCP+hmf0m0Kcoo5+/oBXK9tJx2Nlv11bBGvYFz1B4YVfrhGe6iqjBG2As5JGiLw24qUO0YJYuaiH6KAuxa8qwRAP0aVJLJIrnWaNTT3J3lPlegR+3YscZ/fGd4FBJi4AYAMurnJqZSyIRRqJtJDQht9LuoptZR5oHmQR3hjkroUdEDxPN2h7QM/JxkvRXKarWmBnU2R+yTE99j4O2Mc8fmec1+WjGsP8Q0hROgIJYGjCXsPZaQAtrt72D0w6NGjXxIjW9brq4z2nQiKRlwlANJY/A6Ro3YChNLGpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB6041.namprd11.prod.outlook.com (2603:10b6:8:60::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:18:46 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9073.026; Mon, 8 Sep 2025
 06:18:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: David Hildenbrand <david@redhat.com>, Steven Sistare
 <steven.sistare@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: RE: [PATCH] vfio/container: Remap only populated parts in a section
Thread-Topic: [PATCH] vfio/container: Remap only populated parts in a section
Thread-Index: AQHcDMr9Ap6MRYQc10GVaAw/xMLNqbR4FPYAgAWb3iCAAkuLAIAEca3QgAAU3ICABHDecA==
Date: Mon, 8 Sep 2025 06:18:46 +0000
Message-ID: <IA3PR11MB9136917E48A13AE53AD1FF07920CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250814032414.301387-1-zhenzhong.duan@intel.com>
 <0286f864-9aaa-4a49-8975-cb1af3bb1270@oracle.com>
 <IA3PR11MB91363501F1A6ED40098AF8249207A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <0026017b-770e-467b-ab7d-98cac1c70463@oracle.com>
 <IA3PR11MB913635617BAC00289BC3DB1B9203A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac4a5808-e90e-434b-8cd5-4c25fc543501@redhat.com>
In-Reply-To: <ac4a5808-e90e-434b-8cd5-4c25fc543501@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB6041:EE_
x-ms-office365-filtering-correlation-id: ea0cf2f6-08b1-4342-b7e8-08ddee9f9152
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZuEXcKuNkllrOZ+WQQXmtBlf4TzitDQNR0s0uiRYB3dSC6IIZ/EOHYK6H2N0?=
 =?us-ascii?Q?Ng8Ad6cES1tFXCpTZmNaxuoFhhg2lmcmPmIRHg+Yr6mObYP7JwImNLPdTMbc?=
 =?us-ascii?Q?rvknF13n/UkTZPUENtYExS44c/7UgVs/DE6Bz3v6l0MjEuw5zvUFhXahSCmB?=
 =?us-ascii?Q?i7L2KPpPQNRe87wUueiStWdSoTynVl7BS4AkSmy417Jk6z66lf5POa+kSrPI?=
 =?us-ascii?Q?GVWB8GNlqZr0qEdZHvEzR60ZhvQhmPMo54zvD5Z5hhIUnEw8KXAsMiwN1mWN?=
 =?us-ascii?Q?kI+2gZnDL8oLEAin85FYlzBX+JQy6v7gDLjr7NB52HR60/tViKxdO2C8RSmW?=
 =?us-ascii?Q?h4aeQmhvb6WtYkvoSvHVAsBLMVPmXFv+d1PDzUnF8nFRm03I1PMRil95kpYQ?=
 =?us-ascii?Q?aVODSB5xeEsU/O6ZnLrwJiTeI4PsbFHr+3hctd4rGBZ55FsMkn1SWtqC6N0w?=
 =?us-ascii?Q?YVtphuEWGaZm4NU/P6LeqZwMVbJahmiTrsLUdrHnlcdeonQVU/F13NdEY5dK?=
 =?us-ascii?Q?p3RlpgRxj+/kDHtcQaIFeUCIO3EIl7bBbd1IMlkLgOoBNm28Aue9UP7+Xjpe?=
 =?us-ascii?Q?fNOJ1v+jAAuEx/C/0j+Pd0QIE3+F7U4y3TZwque8C+sb8tO3M//wDPUc3xJf?=
 =?us-ascii?Q?C/Zo7ZExNoJwvFYV0Lp10Fs9ymB0hI7qfGXjPtREZsNaH1GdZI4aohqBZ80X?=
 =?us-ascii?Q?8Qa6RWlRFVi9zQ4nzsiM4OhxzqaTR2uNPkXmOi/YGHKb9WCYnVPDKFYbwYxQ?=
 =?us-ascii?Q?ZYFM4Uy6lkrfEOUK+ANVSCtvSIeo9ZSbSaGrmndqQoPzwFxJjILGJsBLoL8+?=
 =?us-ascii?Q?QU0J06aJjdTuQdilXmCyu+kNxFf4eV5WxYeFsxmXOtJf/HZyTlsOAYORJgNZ?=
 =?us-ascii?Q?dM549qlpaX4CD58e5T2gB3tx/KU105KvmZ4ls7Xzo1OCsHRmMTWFaE9puH8Z?=
 =?us-ascii?Q?JvHu1tOgkYQ3Z/bsXLawPOJNjyqepwIYAKtKd37fwBjscLv9UwlkfL2uXzGT?=
 =?us-ascii?Q?afU+Jn+4T300psEozkr2gAQYezaRctbzgtbz8QOj0Rolw3etxKJjZKiN6iiU?=
 =?us-ascii?Q?HvGyJiR60dmDO4tH+i9s5Pk8u+aafs7vJznaFTc58d6hpi+qu0Pq69HaVoPn?=
 =?us-ascii?Q?emoamyozMNNDThujq3mFaLgzSzvIglUwVXWZ2MwygW7G4+BT4YztH7DyYSgc?=
 =?us-ascii?Q?T8rHCSwI3cyXZEaTvaSSNzKjAIyBRW4HtSx7KdxkjgNJYOpH4Hw8eBsnbyxS?=
 =?us-ascii?Q?GB8zenPmBdQNaiG3VCV7I8Kigsu0n4VgxONCQVkRDrcqXPMU3PyhqF58Zh2d?=
 =?us-ascii?Q?ud5ljC5Iw3QtKXwpORa4nM0c3kGcNA0jmofWkJ7NSLom2KQl9sEV05tsXm4l?=
 =?us-ascii?Q?u2/SneuGPg/nfFR4LIlJTxkSFBZvvNSjIyxuUz5mokZMnGgyWq5U8stp7a37?=
 =?us-ascii?Q?sfR3gP19q5o8fpGsXl08UFJVVgT5xrOZkKaVVxIkEP69BtaJVA7TKQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ib2zXj1514MTLEEQaM1qe8kUl0JzKTPInp6M0EJRXpvRFky06UVv6PHfuf5L?=
 =?us-ascii?Q?WA7PCwnZUBoUJVzQ/h64e709UHzjODiU50pHaZjt8dmcPZ3T8SJ702OR+Ash?=
 =?us-ascii?Q?4qpkJCriMHyFdVXqOh7adweXCKvVN9uhs6Ec2TKfVPQgjN03+B/kns1Exd+8?=
 =?us-ascii?Q?GJnaz1qHwag9lAtkU1xPRKe1vzhb6JRFFuZwDqheV1UpCYoDYXF5+cY9IFra?=
 =?us-ascii?Q?Kg3AF9zQrcRAAlfqDsOWTOC8NqjU/V9mkV9lZm7Jdbym/lqcQ/nNxuWnQ8vA?=
 =?us-ascii?Q?Ee10aZe8yJKh1i/f8S3o27XV5PyKeShBL6x0Lf6EM1r/I9SHqC21kgIfKufu?=
 =?us-ascii?Q?F+1DeA2dZd4QeZlW9AO5PReotZRSx4aO0Y+eamM41vQsF502KJ/pGqT+CKwO?=
 =?us-ascii?Q?8AaJ57xVeHfNaAHttWRGHmI9usZL1Ww5V/5R1p6TlzDkfiWKEKzzgf6WEZgg?=
 =?us-ascii?Q?/BL7DCS6XEKN7rTtdSoaQ3EMN/gtdZyCiVyFRyV6/5afDFYgAdF5MAUGKbUV?=
 =?us-ascii?Q?6vGgtIZiEEwUCjk3s6pBhuUjacPPcsDE4Rxof21qL8v/zjmLaB0Nq0LlhUle?=
 =?us-ascii?Q?+/S541D3l+74w/9qMWmqF1XFQN6asHW46tpd4ckcWmdz1Y6kGuLryNTkQd1N?=
 =?us-ascii?Q?s9YUPHUzO9MisbtF1WK3czpFZzeoTRAA45p2+sf5SEPZ8pEvM3PB1ZjIEfma?=
 =?us-ascii?Q?t9hpel+6IINd1i3ctWEr4b3lvdxqQdKC062eTbDe7EtVn9NXpXAJvxkV4JZw?=
 =?us-ascii?Q?xRSUxozji9j4Rzhs8UHcCD+SJ7G+SCEQFFVamW2hzUMq5L+zqqAFzquNQSfQ?=
 =?us-ascii?Q?RRdTD2UtXA777lEOu0f0p6f1sv+Xn7LSTeFmnijM3uIqy56tzL+pf2/FyEHo?=
 =?us-ascii?Q?GTKtBEPf/5Yksu6EVgEXCtu/DSYSP+j3SA1LsRgtCIQm34W7xXQbhEreya7E?=
 =?us-ascii?Q?+nbblLWqYafTT6DQAn0PvgQ39p3Noh7hBZ23w6CFXRz5FVoeyA308E1kqhOG?=
 =?us-ascii?Q?ig28qrTcTUeaXyE4U636IEWy3SKq6imA2THk0D0QiNWY1cnKO994cyauY7Xf?=
 =?us-ascii?Q?IPp8x3KM5W1WXpPLPV6lwplM2krUWpG41EE39yLKmp4bd0h7eEVh91dikJjT?=
 =?us-ascii?Q?7gyn5hV9q1UyF7BsDT/wjgj6JFi8ZFl65RADtj0mwJW2tSdT3/ZSWuHqydRI?=
 =?us-ascii?Q?qEYvJIkSxQqglVMFSOWa3GfHB8arvX5hHwQN7qQZuGaV5agJApwnW4mv76IW?=
 =?us-ascii?Q?/WYZGGQlM1s6zL+heQOUQWkeUvZVVeWqqFqxmPqlLbi2/UKmlabZkTZReG0H?=
 =?us-ascii?Q?SDac3jWg26Vrrrnex6H/3g3OHtfODCD9B/wY6KIP15Plu3szS6DC4yLi2kLg?=
 =?us-ascii?Q?4c1Rs3x7vagbHTRc7J2tj2/9PWjhoPp/r6q+k+u7WKiONKRzbdP2YBlLYB7k?=
 =?us-ascii?Q?uJXPR1+tGA+dwgXLZ3NyZSIG8FMDEkrZQW9T1bOGCbS9YoPc0xADIb4UM+nE?=
 =?us-ascii?Q?Q34qj+AuWX2HjAX9JQox2DAnTHVluN222MgI1sFiewRcXrSd0BOt6vCePq27?=
 =?us-ascii?Q?06y3BX2F6yd7k2r5BI4XgY0vCcD4Q8dBoUGz8/6l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0cf2f6-08b1-4342-b7e8-08ddee9f9152
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 06:18:46.1427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8Q2mJYn7OgdbxmE2nRL7nmBgT2U0nXzeCLcQQ9HVN16biT80k8CzvCc1FPMEJbv2RLJHk0fQ8WYQaxTpXlZlzP4dV+WVMTKMda0YFVfedA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6041
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>From: David Hildenbrand <david@redhat.com>
>Subject: Re: [PATCH] vfio/container: Remap only populated parts in a secti=
on
>
>On 05.09.25 11:04, Duan, Zhenzhong wrote:
>> + David Hildenbrand
>>
>>> -----Original Message-----
>>> From: Steven Sistare <steven.sistare@oracle.com>
>>> Subject: Re: [PATCH] vfio/container: Remap only populated parts in a
>section
>>>
>>> On 8/31/2025 10:13 PM, Duan, Zhenzhong wrote:
>>>>> -----Original Message-----
>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>> Subject: Re: [PATCH] vfio/container: Remap only populated parts in a
>>> section
>>>>>
>>>>> On 8/13/2025 11:24 PM, Zhenzhong Duan wrote:
>>>>>> If there are multiple containers and unmap-all fails for some contai=
ner,
>>> we
>>>>>> need to remap vaddr for the other containers for which unmap-all
>>>>> succeeded.
>>>>>> When ram discard is enabled, we should only remap populated parts in
>a
>>>>>> section instead of the whole section.
>>>>>>
>>>>>> Export vfio_ram_discard_notify_populate() and use it to do populatio=
n.
>>>>>>
>>>>>> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr
>>>>> failure")
>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>> ---
>>>>>> btw: I didn't find easy to test this corner case, only code inspecti=
ng
>>>>>
>>>>> Thanks Zhenzhong, this looks correct.
>>>>>
>>>>> However, I never liked patch
>>>>>     eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr
>>> failure")
>>>>>
>>>>> I think it adds too much complexity for a rare case.  In fact, if we
>>>>> examine all the possible error return codes, I believe they all would
>>>>> be caused by other qemu application bugs, or kernel bugs:
>>>>>
>>>>> vfio_dma_do_unmap()
>>>>>     returns -EBUSY if an mdev exists.  qemu blocks live update
>blocker
>>>>>       when mdev is present.  If this occurs, the blocker has a bug.
>>>>>     returns -EINVAL if the vaddr was already invalidated.  qemu
>already
>>>>>       invalidated it, or never remapped the vaddr after a previous li=
ve
>>>>>       update.  Both are qemu bugs.
>>>>>
>>>>> iopt_unmap_all
>>>>>     iopt_unmap_iova_range
>>>>>       -EBUSY - qemu is concurrently performing other dma map or
>unmap
>>>>>                operations.  a bug.
>>>>>
>>>>>       -EDEADLOCK - Something is not responding to unmap requests.
>>>>>
>>>>> Therefore, I think we should just revert eba1f657cbb1, and assert tha=
t
>>>>> the qemu vfio_dma_unmap_vaddr_all() call succeeds.
>>>>>
>>>>> Thoughts?
>>>>
>>>> I agree it's a rare case and your suggestion will make code simple, bu=
t I
>feel
>>> it's aggressive to kill QEMU instance if live update fails, try to rest=
ore and
>>> keep current instance running is important in cloud env and looks more
>>> moderate.
>>>
>>> OK.
>>>
>>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> (but you should also seek an RB from someone who is more familiar with
>ram
>>> discard and
>>> its callbacks).
>>
>> Hi David, look forward to your comments, suggestions. Thanks
>
>Hi!
>
>I mean, the
>
>	return vrdl->listener.notify_populate(&vrdl->listener, section) =3D=3D 0;
>
>is completely wrong.
>
>ram_discard_manager_replay_populated() should be the right thing to do.
>
>Was this patch tested somehow (e.g., with virtio-mem), so we're sure it's
>now behaving as expected?

Thanks David for quick reply.

To be honest, I didn't find an easy way to test this error path without hac=
king qemu,
e.g., faking an unmap_all failure on one container but succeed on others. I=
'll try it
with virtio-mem and get back.

>
>
>I would add an empty line in vfio_cpr_rdm_remap().

Will do.

BRs,
Zhenzhong

>
>
>Apart from that, LGTM
>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>
>--
>Cheers
>
>David / dhildenb


