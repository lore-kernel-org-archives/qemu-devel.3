Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65806C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 09:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJ5I-0007QE-CO; Tue, 20 May 2025 05:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHJ5G-0007Po-DL
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:16:26 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHJ5D-0001LN-AF
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747732583; x=1779268583;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nYEXPMBVl7/L7izbcIJkrd7FavnN9JKEE6sINUw0roI=;
 b=DBIJgnlAkzaXM2EzE9y4iPcbrYsXKk1dhk/L1lAJ8/x+iVnoBvDN1mK7
 mhcsB0JcrNhCfNqDuJCSeIcPh1fhC1CHqAwegemX7KSZdkqjNYnX8CbkC
 FzdZ/ega30e1h0znpowa5LwOC+F8tCd6+dYWRcxVqeuVmp2NZhSxAeLrX
 yPLZIL4KM0ong8PpdFn1lWH0ZnaO4jUYc2udRgtgNMCn/7Ro4uZHLfM7I
 d8YkFtVgCDaQFqt7JmggPJQSkh5sKhKDaBNzGp2OnKTsdugV5VzS9nCTP
 lnKZXP875pBz/by/J8DPG8y39dTzIr1/aeqvQd8SFclc08z98/foBFEqy w==;
X-CSE-ConnectionGUID: uZt0E8MGRW+TCQ8uXguVZQ==
X-CSE-MsgGUID: UQPF3D7gS+upkuQjWBIOsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49585135"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="49585135"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 02:16:21 -0700
X-CSE-ConnectionGUID: 8t7XY+TySVO524dUyjXVeA==
X-CSE-MsgGUID: exFb4SQCRXu9dxm/6Z1Ddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="139668011"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 02:16:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 02:16:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 02:16:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 02:16:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWd8pOgGz+PN0EsRnrCrfc23s0CvgklIrjyYU+q9q9kBZbb0Qv6oYLEDetitU20QVxCpVg5VbSzEWMwlRVrMuE1Hy4NhpZCZiV/U+D0MYwPqowDBgT4SQYJHpPYLrwPAq3Q/ao87M/DDjTiQ4/p5hJQFJ97ElnjSCvVcUnLpG475yiYdOIY2Az+5MT0glO96CqzNGSreL7+qzXZ2jsRneXgpPAvNeKUecqhrTZjAHB6Bt+aOOxsnADf9q3ivBjgIfqSvZkFle2GmY10k2JEhLQeHxQGKc+7CPnc/3w8p0tqpUgQo1FxSYdc7Evo/t9huE1jfF+QOkP2yPwJ50RZ5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PFuSoPmZ5Uck7D8dzr19MneiyDkI1DIBER9M0cQnk8=;
 b=NCaFuQDCniG5kMguYgkbWn21EpAGTYNLO5yR4fnnA1rOKM9LDTvbYUB6QLBxngg9Zc5jEx5T8Hc5f1MSwpQh8Wci1SXdoeOGcA1xXXjrFLT8XdkWw6Ml6XtMaAKSSlvuibSG1PrJo2AVEdTTd5AVaDKlKcRkAckYM94uuoagOHCO1VFdhgoMmRy3jxbpBXa2TR/ktc7S74CEdgb5Z1B6+SG4wFo9cJH/TBhImJbroMuRXZQrzyB0aCVSvyX2O6CBwVFezVhzmigxjsWVYP8VcjBJdtj5XuxLKLl3BqIpXjp2NWGzvMPw2V5OzG8i/0RR8wWICRtiA4fppYPDyUahpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB6720.namprd11.prod.outlook.com (2603:10b6:a03:479::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 20 May
 2025 09:16:15 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 09:16:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
Thread-Topic: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
Thread-Index: AQHbw1Ng1KGgC3Lc40iButBHzdW5oLPZU1HQgADSZACAARO7UA==
Date: Tue, 20 May 2025 09:16:15 +0000
Message-ID: <SJ0PR11MB6744681C4F80BCED61ECACED929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-40-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744EFD14811E4BAC0C05BE6929CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <050ec82e-3cf9-4058-8db5-04f5263c516d@oracle.com>
In-Reply-To: <050ec82e-3cf9-4058-8db5-04f5263c516d@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB6720:EE_
x-ms-office365-filtering-correlation-id: dec32922-0371-4f39-a489-08dd977ef901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TFJ2YvDIsHLLobr/2TzW2LIErTQhdRkmclce75061MFaQxAcKoimLlLppCv5?=
 =?us-ascii?Q?/7VJfVfH6RkZ7X6D/5MTBkXo7VJA9Zt1w9xcTWMcP3zDzqsuETtwHe9s+45C?=
 =?us-ascii?Q?AVo24EJgR/Nna1jHPub/bgPu8mu+OpuzSJeglAENX8VmZM7Q+oXsSPoEBLbU?=
 =?us-ascii?Q?Pj3me9dYDh6sOjgQaKfv5SMldtlq13YRUKR+VTpWAMWKjNibyg0bY28r7+x9?=
 =?us-ascii?Q?+l+/ecCTdCVTd41KB+xyQpDGP7POhBcHN5GxDnVX4/cbadrRpaoJAnLR+7CN?=
 =?us-ascii?Q?IDKGvVLMr3lUc2+WHq4cmNYo2Va87LHlh8nVZcB21swQ0vnupyLOYLT+4OWP?=
 =?us-ascii?Q?XRaXTOILI8ar68HWxaCTIMFjbiqte/r3CBM6+QcMUd5u29Wjd5GmGZAwI8NI?=
 =?us-ascii?Q?bpVzjdp83VDo2cRjvEjmyBnx+TH0RZUxXHfpwUWjBahpDIXglnC9dw8XGp2L?=
 =?us-ascii?Q?koupvPejd4m2kt++J8PkJhLUCoIvfw8hB85xngjJp5hVOp6aP40A+xasGF8h?=
 =?us-ascii?Q?fEWKKo6ZTyWt8WahBemYlbFBUNfV/2PBOLMRKImVjcfqYyLUcypLDuAhszXC?=
 =?us-ascii?Q?j1+z5OjaHQz0PqzxS41RvIT6be95HPuLAMce4akB1fi7X3XdTPtPxZdcKaxX?=
 =?us-ascii?Q?0YyC7mAQ+DKkaxQsj76xNfhnyx5+tUtUJFYcCsDL1sTAA5oRyixarT84ZbmG?=
 =?us-ascii?Q?IQGgPHlvKBNEVtxm1f8SxPJQ6kaf/0wSOutqTwQNitkrmE8DvTN79MNVwFMl?=
 =?us-ascii?Q?R1fV5hDOaCJGbG/1+ZPsOrokAiS4TLmwV1Fv7u0w4YLgYKvKw4OAbalZQoHb?=
 =?us-ascii?Q?7a3+SybSy//X7enGGJVgaW1HF+u3LiTRq4j9XU0I1M/rgPhjqUxYRtXJ5/1O?=
 =?us-ascii?Q?JbhgKkjfWsKx+rl9j+pLDySE1jWCw9CvmD/nvFXkRXQwuPR8Zpo/XljF+Dc2?=
 =?us-ascii?Q?O7FBF6z2fsgS/yOtEJ5Ac11cFC5GY1RglZae7wD8OCEryfWkP3Vrd6FWvIO0?=
 =?us-ascii?Q?g0V8EXBzOuwEbBTLeGgZlPEkXGrk/IRcD0VgnGPZVpLxHl96tPCkHFAWa6Os?=
 =?us-ascii?Q?Mv4uCTGiwCBDuZeAvdiwxUjutbKDWcM/R/eWp2xAEsJ0YtxYrdQGc2AtZo95?=
 =?us-ascii?Q?WUqp+ax5R3p8vdBmW5KIndo7NuboILVbIN0OB+vlabpq/yzPr4Oc1IDOdtlg?=
 =?us-ascii?Q?Ah6x8ceb78zYlmayLhRRjvw/hHogmvPoyE+Gsb9MUxyaUUPFNWI90JPThdUj?=
 =?us-ascii?Q?F6HrSBlC6hPVN0k1jTU2QfTvsz00TZX7qgmPGR8fboDRUWD9CrODRCBwV5po?=
 =?us-ascii?Q?EZpL16XEg9E93XjC02CejQeT60SqtfCxLsSq6R+vlnHBok2jbvxV+kS4xtED?=
 =?us-ascii?Q?NycQNfwlSr5WSVATHNU86ywKhQlDXJSnt/FdWD8+Xjbzhb/bbpBXTSb79QWz?=
 =?us-ascii?Q?OOROIpFFg34Czic82NQ0AgPMPck410OFLJ2kqn+XIR60nw3rlQ59JMXva36Z?=
 =?us-ascii?Q?Z69jnWPtnIrpLBc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IQdshX3vamNSn+BKGG/E6FqtuneY78ybLz+XTUrUZRyQdfr3rRBNKkLyDqcP?=
 =?us-ascii?Q?5HN0WhPXk1TJMV+5jaQSSQ84WSYhjv0urJXPBetB2yU3UsAFSU7PTCEXTp8I?=
 =?us-ascii?Q?tE+H4dBu20bIfLb8Od92YiO9MPKoW/GT+3GhHKkh7/1aykwuGEOk+rZmlCL6?=
 =?us-ascii?Q?87M0vjML3L2eghXlQZ2mHq/9LDZT8NlqlgX5tF89DH1LLC6m/KH0c/19vW7D?=
 =?us-ascii?Q?exby3ncmcCHinrMDJBwvLnYW3s9srLXEhNemCzj3XhIL3MhbnMtg9UQpO9Cp?=
 =?us-ascii?Q?h9knv0aiSKXXVbscRTq1FHQR5SBGTMBHzW8sydODZeoGRh67Dlr8cFKN7Bnr?=
 =?us-ascii?Q?ON1YUmDNjT/gzHT+JsRO9tRzRsKq5a4TrHyMNOqQgy/n7kzdndaNr9Cn5vzb?=
 =?us-ascii?Q?zMzdp0GAgSHTq1XdAIxGkZzdjdN8mTYm43PTKYtee3n7HjRMx2VFbVwh7Emg?=
 =?us-ascii?Q?nvTyyea1put1BS3MnTmsDOH62eVXhHAMjYY0+mAqVHhpCNo8qubBcnpKKTEY?=
 =?us-ascii?Q?E1Y+I7oDBPBD/fNkk/42W7d5BvS3Old2EI5rCjMeDLuZ12EhDLJNd2eUtV4m?=
 =?us-ascii?Q?9H+kWKM1iYRBlEmoeSV89yGjD31cYLAyNDAdSJ47U3b5f26JL42dBTBBcBjg?=
 =?us-ascii?Q?qhnf8Iwv4anck1XzmTjlYt+cpF+uk2oVJxaU0Icpx8BS5MV+a+K4nQeyInyq?=
 =?us-ascii?Q?wfz4C6sU9HVzfI6dcjZP/ol7x6eAIMx1aC6tV23lvhMFVB2MM+uafk0fKYqA?=
 =?us-ascii?Q?GqoRoNvSq4zZ6Vkdk/fQ5LJi6EIwDcJC088yLu4m5I8n8CMBgqLvmO6C8vR8?=
 =?us-ascii?Q?Y8hdMCWHeUwNMNZ41a4QQosDShP1XRxWgfEPjH7wDDI7bkDP/tN1MllxPkcf?=
 =?us-ascii?Q?W/HDFCV7rUfMwSOzNno9Ui7S8ET/yYVC7upjukq9Q+HAgz3AfBlPoeu7LsXf?=
 =?us-ascii?Q?j+Ejomkq2DhlTeYdEiX4IFRlDcPuTT5ayi4KWCKG2gGEetdAeUcswZcFFctI?=
 =?us-ascii?Q?JbvMtDjyLbYvl8uf5nq0C/KerjvFE+7cH8Dt+jJXYs7aXyO3pN1ZEIlapW/g?=
 =?us-ascii?Q?drnwYAAaj1tB9tfcVHEXFSTxS54eLv1DjVKkTFFaxN6uXMEtK4RUCZnanKU7?=
 =?us-ascii?Q?ePADKv1p0T2Seg89BesePzHPEcmB7SQmnXdnG0SDXBb550TTRma0zE9Qxyoz?=
 =?us-ascii?Q?p2WprLQIFMp9tHyG+i5gTHRFk62QVZoqkkw2Z+VehaxtseixP55gnY1FJLCd?=
 =?us-ascii?Q?hjWLcOvG3mmnLbiruVJ/x+9govAy8LedkjaGPPqWSNvZiNODkYp/gnVMCKV9?=
 =?us-ascii?Q?TmktXVyBvebIVCA459ZXP0YPh4I2VijaolHFMIA3900TeFl6U/6/EOZx81yN?=
 =?us-ascii?Q?iTZucWeHIrsSDrtlSUN8zoWilgu+bbHr3ZgJ8Td1Fpu/4j4dQwRN7FCUrFvo?=
 =?us-ascii?Q?+tvStwzTiHlWXSp4ppBYGwqurAEmjUVvluAhlfZw/70oO78ZFTmySWGL+OxU?=
 =?us-ascii?Q?FJIV7VuCBEBVy6hEjP5jN0dwulEk0YQs99P2BeTr1/UUHF7s0GbAnsTFb+Aa?=
 =?us-ascii?Q?aw6ARDmVQ0b06Lhac2d/7UpgCPNwUQ863vC1CX3W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec32922-0371-4f39-a489-08dd977ef901
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 09:16:15.5584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Aj1Jv1NIZkNnrP4U6apcdOexIXFjVm94YcMSqaPUvnMDiIpZS6HjqUUfGAS4A9lK47yEI/I0XDzNGPipt5bDcFY7SjMsG3rdv0FY0Uhi60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6720
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
>
>On 5/18/2025 11:25 PM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
>>>
>>> Save the hwpt_id in vmstate.  In realize, skip its allocation from
>>> iommufd_cdev_attach -> iommufd_cdev_attach_container ->
>>> iommufd_cdev_autodomains_get.
>>>
>>> Rebuild userland structures to hold hwpt_id by calling
>>> iommufd_cdev_rebuild_hwpt at post load time.  This depends on hw_caps,
>which
>>> was restored by the post_load call to vfio_device_hiod_create_and_reali=
ze.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> hw/vfio/cpr-iommufd.c      |  7 +++++++
>>> hw/vfio/iommufd.c          | 24 ++++++++++++++++++++++--
>>> hw/vfio/trace-events       |  1 +
>>> hw/vfio/vfio-iommufd.h     |  3 +++
>>> include/hw/vfio/vfio-cpr.h |  1 +
>>> 5 files changed, 34 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>>> index 24cdf10..6d3f4e0 100644
>>> --- a/hw/vfio/cpr-iommufd.c
>>> +++ b/hw/vfio/cpr-iommufd.c
>>> @@ -110,6 +110,12 @@ static int vfio_device_post_load(void *opaque, int
>>> version_id)
>>>          error_report_err(err);
>>>          return false;
>>>      }
>>> +    if (!vbasedev->mdev) {
>>> +        VFIOIOMMUFDContainer *container =3D container_of(vbasedev-
>>bcontainer,
>>> +                                                       VFIOIOMMUFDCont=
ainer,
>>> +                                                       bcontainer);
>>> +        iommufd_cdev_rebuild_hwpt(vbasedev, container);
>>> +    }
>>>      return true;
>>> }
>>>
>>> @@ -121,6 +127,7 @@ static const VMStateDescription vfio_device_vmstate
>=3D {
>>>      .needed =3D cpr_needed_for_reuse,
>>>      .fields =3D (VMStateField[]) {
>>>          VMSTATE_INT32(devid, VFIODevice),
>>> +        VMSTATE_UINT32(cpr.hwpt_id, VFIODevice),
>>>          VMSTATE_END_OF_LIST()
>>>      }
>>> };
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index d980684..ec79c83 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -318,6 +318,7 @@ static bool
>>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>> static void iommufd_cdev_use_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt
>>> *hwpt)
>>> {
>>>      vbasedev->hwpt =3D hwpt;
>>> +    vbasedev->cpr.hwpt_id =3D hwpt->hwpt_id;
>>>      vbasedev->iommu_dirty_tracking =3D iommufd_hwpt_dirty_tracking(hwp=
t);
>>>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>> }
>>> @@ -373,6 +374,23 @@ static bool iommufd_cdev_make_hwpt(VFIODevice
>>> *vbasedev,
>>>      return true;
>>> }
>>>
>>> +void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
>>> +                               VFIOIOMMUFDContainer *container)
>>> +{
>>> +    VFIOIOASHwpt *hwpt;
>>> +    int hwpt_id =3D vbasedev->cpr.hwpt_id;
>>> +
>>> +    trace_iommufd_cdev_rebuild_hwpt(container->be->fd, hwpt_id);
>>> +
>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>> +        if (hwpt->hwpt_id =3D=3D hwpt_id) {
>>> +            iommufd_cdev_use_hwpt(vbasedev, hwpt);
>>> +            return;
>>> +        }
>>> +    }
>>> +    iommufd_cdev_make_hwpt(vbasedev, container, hwpt_id, false, NULL);
>>> +}
>>> +
>>> static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>                                           VFIOIOMMUFDContainer *contain=
er,
>>>                                           Error **errp)
>>> @@ -567,7 +585,8 @@ static bool iommufd_cdev_attach(const char *name,
>>> VFIODevice *vbasedev,
>>>              vbasedev->iommufd !=3D container->be) {
>>>              continue;
>>>          }
>>> -        if (!iommufd_cdev_attach_container(vbasedev, container, &err))=
 {
>>> +        if (!vbasedev->cpr.reused &&
>>> +            !iommufd_cdev_attach_container(vbasedev, container, &err))=
 {
>>>              const char *msg =3D error_get_pretty(err);
>>>
>>>              trace_iommufd_cdev_fail_attach_existing_container(msg);
>>> @@ -605,7 +624,8 @@ skip_ioas_alloc:
>>>      bcontainer =3D &container->bcontainer;
>>>      vfio_address_space_insert(space, bcontainer);
>>>
>>> -    if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
>>> +    if (!vbasedev->cpr.reused &&
>>> +        !iommufd_cdev_attach_container(vbasedev, container, errp)) {
>>
>> All container attaching is bypassed in new qemu. I have a concern that n=
ew
>qemu doesn't generate same containers as old qemu if there are more than o=
ne
>container in old qemu.
>> Then there can be devices attached to wrong container or attaching fail =
in post
>load.
>
>Yes, this relates to our discussion in patch 35.  Please explain, how can =
a single
>iommufd backend have multiple containers?

Similar as legacy container, there can be multiple containers in one addres=
s space.
If existing mapping in one container conflicts with new device's reserved r=
egion,
Attaching to that container will fail and a new container need to be create=
d to accept new device's reserved region.

Maybe you need to do same thing just like you do for legacy container, e.g.=
, saving  ioas_id just like you saving container->fd, then checking existin=
g ioas_id and restore iommufd container based on that.

Zhenzhong

