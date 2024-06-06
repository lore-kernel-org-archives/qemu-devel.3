Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3ECC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF79n-0003D6-Jg; Thu, 06 Jun 2024 03:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sF79l-0003CR-Ou
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:03:30 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sF79i-0001pw-Ly
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717657407; x=1749193407;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bNrjPmfGN2ew6Hg28qTuiv41u7A8FMS4wB+lqRqUO9Y=;
 b=ltm3XcL1qg8W9RQC/NHlATTlJytU18qaX5VDhtt+lHf+oFnbiq5NveWY
 zQ8k2QI+Z8m5oWNjmYgCdNRYxsdyFnLvfHNhXIfEow3aUXtkvvmhpVoWH
 FIjbTfw+OI5gIMClS7Q7LcwVSBJIK2YYpKfLe9+MkAUBfpqV+nVIPV3/V
 zsxHv5QjhbqCnYrNbLtVc1y9y2f5O5TysvPsF3efcOtc73x9QFv+lR9g2
 PQVmmbvI5fovBn+sTyxJIPSK5YyYIEpOuZAyNmDPLYfpqCKcfdXYA8KFX
 Ezj1qsC8CpedplF/9nC9/tNmRDdTfm9LIiEjrT7OSYkyOy4s1LTTXWKuu A==;
X-CSE-ConnectionGUID: PKoftrpKQUu6ZbL/Bx/vmQ==
X-CSE-MsgGUID: wVuj+YXtS1C+ZutPoUtqGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24874349"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="24874349"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 00:03:24 -0700
X-CSE-ConnectionGUID: UoNmMMwhS0Kn40UrrOS9mQ==
X-CSE-MsgGUID: Y+Ug0nVDREWjqhwVK9wypQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="42333398"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Jun 2024 00:03:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 00:03:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 00:03:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 00:03:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/TCCPSFeplVrJ5GskoWk4X7gMqcB3d5Y+ZzvzVUrS8mnOAV0mKKpkMFCn4KQOfivBvgxGL8NVJin9QZe23sgtFPi7hEG7a+G2Z1Zqvyutr844TykhpCw1eizQIfwUFucQ53oEgcs2F8+RHNhbnulNEPmj8UCdiLdiGZCGUOjzdUWcUOXawx3/etvak5Elm7pZFR+n6RkpHH8snjptJ7hdB7T+iGW5dwuH1XBelTvGY1rrh35s3RAeifQDUUHXzLiMe9aWW5u5TBJaHQkoF+1DAN6IB+z6VjOEGpnjO3wsNSZVwsszwEMeysU4n4S0XVKFjU+gZHbvzUB+1brdQUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzRWneduN0/OxpXxLwwEXctqcIzqe4J6x3VRAAEkSq0=;
 b=ZQi6W0wlgqMQB0BTtrxdJJANw/Wfv6Hj6WGhEbSDhONyCf/fjC0qQois+6yqCGZPyKsr5ynl+AcGhqkMEJAHZ4K2XgDvO5QaI8hOeDJa5+ZqG16dc9wSRex/oXk92tJxYGxa7wK+MTX5/+MHR3Spr2YPzIABOPx2uPbOg/YlXo9Wic9GaXEaAzRkPbfG7B/a5cw06LXSKx9fqwrPBLLzEMhfOcL/8GILCOQOg3AnSMkFs4AMBUBdvauHbPShR6JCkR2sSv8YjSlkUl7EZdimfIbWVVmkLL8wJIWf7RWWUSScQVqoiGmW/30L3mJWlvaxOUktoVcB3bATlLKkUNarSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Thu, 6 Jun
 2024 07:03:20 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 07:03:20 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v7 1/7] docs/migration: add qpl compression feature
Thread-Topic: [PATCH v7 1/7] docs/migration: add qpl compression feature
Thread-Index: AQHatoIDAx2GRPUss0ajnSETvl+VsbG5mM0AgAC3wbA=
Date: Thu, 6 Jun 2024 07:03:19 +0000
Message-ID: <PH7PR11MB594124A4797B0F36F9AC1CBFA3FA2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240603154106.764378-1-yuan1.liu@intel.com>
 <20240603154106.764378-2-yuan1.liu@intel.com> <87y17jnosv.fsf@suse.de>
In-Reply-To: <87y17jnosv.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DS0PR11MB6496:EE_
x-ms-office365-filtering-correlation-id: bec2819e-661d-4966-7b4f-08dc85f6bf6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?mDWCDBTqt95D0zeRdktPvguwcHgUnKI5I0I5rbGhC8nDin6Ow2X/SLw2yDIc?=
 =?us-ascii?Q?nuSJZqyWwBjIekmxdNooUwqlqLPdQ89FqEhmFM0BPauaZoOxYPqMKnX0jSZ+?=
 =?us-ascii?Q?GTUT6BXOVwaU3hJRbt07i21DnEzvsQXOU0m2ZB/3fVPm71nptYAw9SyyPatD?=
 =?us-ascii?Q?E7XqEdHLe8YgK2nlBN7Zj8FalnVm8Ep0tyiQh/GZinsfHreToH2C1IS5ZN7V?=
 =?us-ascii?Q?ELLw2Xm4EjpNiMZS8FAcUiJ06jHjTBYHjb8MYgeoP3GFZ3IeZqaNWB46jBRP?=
 =?us-ascii?Q?AhmVHzNY9XW2AWyXU8OyxPhi1gcihryCU4xWbYLsUJKW3MgxBG1DxAMCEvAk?=
 =?us-ascii?Q?TjnOH4bM6LxszWOYAOenkDuuq3qQP9YfQYsZMRqsSAt9t1Nfq9RdSNKoW4uZ?=
 =?us-ascii?Q?4yHMJ4Qd074g9e6HgP+TV/T44sDKLK4kledYbI/JqwvLrPURkGDQ6hBDJoBG?=
 =?us-ascii?Q?vlHV8ofcmzUtc3dtkdoXU36QPtCJ5mp440pCpmMokgVt46kJ3aBWhdH/pblq?=
 =?us-ascii?Q?GqvwyG95zMGkGlgEycIg7pTGa5lSBiXErJ5PECIOzBOq5lnYbHo1WBicFmHM?=
 =?us-ascii?Q?8AmCtmQ1N0ibTrVPxow+LoRVYQw8gcoPI1zb4brzcL+nrXcCDkiRufHpfBEF?=
 =?us-ascii?Q?jwnD+a29Fr1GZ8CFr0ARKFL068HD+9JHObRSi9dG3W8RBSWhUSCX0wsApZaQ?=
 =?us-ascii?Q?aO1VBQJFZBvoT8tqJ6NWyJPyrzpXEB/mS4PH8qG+bMevw04Ge+kdwJ/PuxlM?=
 =?us-ascii?Q?UxeYPJjUY670dLI5aWfa0PE9XLopaE0Btlj1iwnqETu4pegCOxDJWtxHu06N?=
 =?us-ascii?Q?48G4ulcX1MgBmQzau+jXUkHDmFqH7XIM864nZ/LsD7dQaZLViqDUkcIaVVrQ?=
 =?us-ascii?Q?1JhSiFgR/z+4kFsgibFBYlbnFsIe31KBbv8jLLYlJItOX0BqbrYtAL3BrTbr?=
 =?us-ascii?Q?zSa4Zbss67VmVQYwpNafdiEaUDoLpgnEukeWAk9K3Jv6DWHv20/74x1I7L20?=
 =?us-ascii?Q?iODFvZDZuM6s8YmwL+GFryU7cbgYGKC90SMOwNEjSRlQexGr198I694Enoiv?=
 =?us-ascii?Q?LY6zACwpDYiQjYLidIXhcvNEa/+F132VknhrVgRp/mzSuwjnjvNRMA4vPQmR?=
 =?us-ascii?Q?UqqeubZtB3Yi6tcwRB1yTapZoD/uNJDB4BnFevZ3J3VdmcYkl/1VeTsITDMw?=
 =?us-ascii?Q?79XFxuWkSMggJgzVbgIaaJloCSr9RoYyaEdiAssiONBQYclBKK1xeu1EIRNU?=
 =?us-ascii?Q?76ANy2HPYvOqnleMi5EEveQAz6T1GpoJn4Zpdfjw4G3qn6KfU5GlDNir9w9p?=
 =?us-ascii?Q?CZdNihsqZLTmaqJCgjC9Tno/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JT6kH4HRCEB+ttwlshsZxvPFPaqcgUuqch/GJx/D/nq6iOzMS6NzzCbHRDmw?=
 =?us-ascii?Q?WUSgt86JAqp+pa8L+3eteFNud2OOt25Ub4W1pWaH273Ajc1+sW1AnvzGJyk8?=
 =?us-ascii?Q?PDKeJfhkf0Mr8bnCxTIYyUoY9yZpEDs2Ae6xh1fVKznXqkb0Pt/unMLuPDgT?=
 =?us-ascii?Q?Z4UbYDxXsMCxzg3raTx1tHONfGH6Lhu0Wm4hK9FBTOu4ZYLukHNbFy4bgPcn?=
 =?us-ascii?Q?NWjRB/D+fa9DYp50ejQ0VPq3zd0JGyXAATbXqJ4v+hVatIGsKeExUT4DGmnk?=
 =?us-ascii?Q?B8O7PBJw6jZBJ5rrHP+mSFIABHTqkhRnL2XtaRrc79taqAoZpydVQ8f3yq6k?=
 =?us-ascii?Q?QFaFCm+A7rmzog0gVd8gksmJhNDUbqOtvPNcYBcU5eOGKKEDYlw5ojurBiQO?=
 =?us-ascii?Q?xnPyUjKDHEqEjV5LVKeiBYXd6QDNLEwtAZYoyZICesj0XVGkc6+oR1Yudp97?=
 =?us-ascii?Q?Kn8Iie4UzYjIiA/5RcIYe/IC53UlysDktWsaMK/FsXB7xu0byhvVa4WlWi1O?=
 =?us-ascii?Q?m+P9DzAzUB00ySGAuei1r4HtXmoxrz7Qnj2f3hp5NeAEiXg9xX8VtTorox5t?=
 =?us-ascii?Q?iWKxXSKeIZR0r7DTHtALk0cH/Q9NcG4jZWGXlQmcMYAzNLaiJahOW19wfW8I?=
 =?us-ascii?Q?8lA4R7teXbJ8CGswXHVUL4mKLsWogyYnC/8R3wnPoOeZCCD1lc+mFj/tRoa9?=
 =?us-ascii?Q?Nd7HWbs2zTtxT5agc+jRtVYCIyKrNmNIitcr/za9bAlw+LtbBs6n71MdBj2s?=
 =?us-ascii?Q?insBNyvRRDZufEg/Aa0pQtITENw6kfjyzhFVmhNuLAQnAmeuuFd/bCx2AJ1a?=
 =?us-ascii?Q?aN0Jxe43WY0/ZnnkvmtfWfsm5EUE5E5egIZQHp6RvzJFGQYb3oK588uyOQKr?=
 =?us-ascii?Q?hV+MkUB29d1uOeWmxAsfpShV1Wl43Q6dcvThXebBHaff6x6o4U8UdUSUmCs4?=
 =?us-ascii?Q?aKoz/xdmMrRx3i90g/iezxMq+3MCSU/dRAZCXFoWKfQHndk4WLk+z1Ju3OeU?=
 =?us-ascii?Q?QgmnEGr1r/c+TMOXI90KIN3GJl9e7fXSHrNyS9jghsrQWu39/mS9Od0rzQFI?=
 =?us-ascii?Q?raaouWcrwH6TTP5Aj5o99evCSfS1vIuyHH1xFbd5eo1zz1/VW5+sWyeDkdA3?=
 =?us-ascii?Q?h/17QTuu5rn40wRiDHih1BU/IB2dImefEzDuAHcdB4VQzHr9ZD/gZTeoty3Y?=
 =?us-ascii?Q?0X6wJrKd4o5mSQXrUZsr0pJb8kMzsUQeDwT0ZFJH66M1SPfiSUczfqnB75pP?=
 =?us-ascii?Q?N45E/kcmNg6EpjkhJiNi5bpTV7yvOOKPcNrDeyRsPszvFf62r1qYLaOnWVtm?=
 =?us-ascii?Q?uZ7JoSiUheYDj894/I8jTmjbPiWjo9OCOcM/Clfg6XYT8CmU5PeSe7CvZQVG?=
 =?us-ascii?Q?f0F6QSSd+mzmPjhmv+2eoCLeepYQDTQ02Acd+N4p8+1sC6a5FTzFJrP+XB8q?=
 =?us-ascii?Q?RPgU2YC1ki2zJMoY2/gXOYwqjY9F1Bc4EzimLQhzhWVeLfvxlA0+eK+fDHO/?=
 =?us-ascii?Q?sEXg0LCB5zbzKXHf2TcaT2yzFJlFhHSuLTN9QEbEs8rIMefFrCcO9u+0yL6i?=
 =?us-ascii?Q?8tbKb+e4wMj24JRkIT114dU6rHMjCUpQvnB5Oy4B?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec2819e-661d-4966-7b4f-08dc85f6bf6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 07:03:19.9443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lS00ZTIE+XZYP+as0a38tY0TkeXZKmMCvk+XJgHO+wu2+Toko9XXjPYPM1JwcOljQk1ozzcO+YVi4ugOztRvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> -----Original Message-----
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Thursday, June 6, 2024 4:00 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com;
> pbonzini@redhat.com; marcandre.lureau@redhat.com; berrange@redhat.com;
> thuth@redhat.com; philmd@linaro.org
> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>; shameerali.kolothum.thodi@huawei.com
> Subject: Re: [PATCH v7 1/7] docs/migration: add qpl compression feature
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > add Intel Query Processing Library (QPL) compression method
> > introduction
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
>=20
> Just some nits if you need to respin. Otherwise I can touch up in the
> migration tree.
>=20
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thank you very much, there is nothing I need to change for this patch,=20
if this set of patches needs the next version, I will fix the nits
according to your suggestions.

> > ---
> >  docs/devel/migration/features.rst        |   1 +
> >  docs/devel/migration/qpl-compression.rst | 262 +++++++++++++++++++++++
> >  2 files changed, 263 insertions(+)
> >  create mode 100644 docs/devel/migration/qpl-compression.rst
> >
> > diff --git a/docs/devel/migration/features.rst
> b/docs/devel/migration/features.rst
> > index d5ca7b86d5..bc98b65075 100644
> > --- a/docs/devel/migration/features.rst
> > +++ b/docs/devel/migration/features.rst
> > @@ -12,3 +12,4 @@ Migration has plenty of features to support different
> use cases.
> >     virtio
> >     mapped-ram
> >     CPR
> > +   qpl-compression
> > diff --git a/docs/devel/migration/qpl-compression.rst
> b/docs/devel/migration/qpl-compression.rst
> > new file mode 100644
> > index 0000000000..13fb7a67b1
> > --- /dev/null
> > +++ b/docs/devel/migration/qpl-compression.rst
> > @@ -0,0 +1,262 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +QPL Compression
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +The Intel Query Processing Library (Intel ``QPL``) is an open-source
> library to
> > +provide compression and decompression features and it is based on
> deflate
> > +compression algorithm (RFC 1951).
> > +
> > +The ``QPL`` compression relies on Intel In-Memory Analytics
> Accelerator(``IAA``)
> > +and Shared Virtual Memory(``SVM``) technology, they are new features
> supported
> > +from Intel 4th Gen Intel Xeon Scalable processors, codenamed Sapphire
> Rapids
> > +processor(``SPR``).
> > +
> > +For more ``QPL`` introduction, please refer to `QPL Introduction
> >
> +<https://intel.github.io/qpl/documentation/introduction_docs/introductio=
n
> .html>`_
> > +
> > +QPL Compression Framework
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +::
> > +
> > +  +----------------+       +------------------+
> > +  | MultiFD Thread |       |accel-config tool |
> > +  +-------+--------+       +--------+---------+
> > +          |                         |
> > +          |                         |
> > +          |compress/decompress      |
> > +  +-------+--------+                | Setup IAA
> > +  |  QPL library   |                | Resources
> > +  +-------+---+----+                |
> > +          |   |                     |
> > +          |   +-------------+-------+
> > +          |   Open IAA      |
> > +          |   Devices +-----+-----+
> > +          |           |idxd driver|
> > +          |           +-----+-----+
> > +          |                 |
> > +          |                 |
> > +          |           +-----+-----+
> > +          +-----------+IAA Devices|
> > +      Submit jobs     +-----------+
> > +      via enqcmd
> > +
> > +
> > +QPL Build And Installation
> > +--------------------------
> > +
> > +.. code-block:: shell
> > +
> > +  $git clone --recursive https://github.com/intel/qpl.git qpl
> > +  $mkdir qpl/build
> > +  $cd qpl/build
> > +  $cmake -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D/usr -
> DQPL_LIBRARY_TYPE=3DSHARED ..
> > +  $sudo cmake --build . --target install
> > +
> > +For more details about ``QPL`` installation, please refer to `QPL
> Installation
> >
> +<https://intel.github.io/qpl/documentation/get_started_docs/installation=
.
> html>`_
> > +
> > +IAA Device Management
> > +---------------------
> > +
> > +The number of ``IAA`` devices will vary depending on the Xeon product
> model.
> > +On a ``SPR`` server, there can be a maximum of 8 ``IAA`` devices, with
> up to
> > +4 devices per socket.
> > +
> > +By default, all ``IAA`` devices are disabled and need to be configured
> and
> > +enabled by users manually.
> > +
> > +Check the number of devices through the following command
> > +
> > +.. code-block:: shell
> > +
> > +  #lspci -d 8086:0cfe
> > +  6a:02.0 System peripheral: Intel Corporation Device 0cfe
> > +  6f:02.0 System peripheral: Intel Corporation Device 0cfe
> > +  74:02.0 System peripheral: Intel Corporation Device 0cfe
> > +  79:02.0 System peripheral: Intel Corporation Device 0cfe
> > +  e7:02.0 System peripheral: Intel Corporation Device 0cfe
> > +  ec:02.0 System peripheral: Intel Corporation Device 0cfe
> > +  f1:02.0 System peripheral: Intel Corporation Device 0cfe
> > +  f6:02.0 System peripheral: Intel Corporation Device 0cfe
> > +
> > +IAA Device Configuration And Enabling
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +The ``accel-config`` tool is used to enable ``IAA`` devices and
> configure
> > +``IAA`` hardware resources(work queues and engines). One ``IAA`` devic=
e
> > +has 8 work queues and 8 processing engines, multiple engines can be
> assigned
> > +to a work queue via ``group`` attribute.
> > +
> > +For ``accel-config`` installation, please refer to `accel-config
> installation
> > +<https://github.com/intel/idxd-config>`_
> > +
> > +One example of configuring and enabling an ``IAA`` device.
> > +
> > +.. code-block:: shell
> > +
> > +  #accel-config config-engine iax1/engine1.0 -g 0
> > +  #accel-config config-engine iax1/engine1.1 -g 0
> > +  #accel-config config-engine iax1/engine1.2 -g 0
> > +  #accel-config config-engine iax1/engine1.3 -g 0
> > +  #accel-config config-engine iax1/engine1.4 -g 0
> > +  #accel-config config-engine iax1/engine1.5 -g 0
> > +  #accel-config config-engine iax1/engine1.6 -g 0
> > +  #accel-config config-engine iax1/engine1.7 -g 0
> > +  #accel-config config-wq iax1/wq1.0 -g 0 -s 128 -p 10 -b 1 -t 128 -m
> shared -y user -n app1 -d user
> > +  #accel-config enable-device iax1
> > +  #accel-config enable-wq iax1/wq1.0
> > +
> > +.. note::
> > +   IAX is an early name for IAA
> > +
> > +- The ``IAA`` device index is 1, use ``ls -lh
> /sys/bus/dsa/devices/iax*``
> > +  command to query the ``IAA`` device index.
> > +
> > +- 8 engines and 1 work queue are configured in group 0, so all
> compression jobs
> > +  submitted to this work queue can be processed by all engines at the
> same time.
> > +
> > +- Set work queue attributes including the work mode, work queue size
> and so on.
> > +
> > +- Enable the ``IAA1`` device and work queue 1.0
> > +
> > +.. note::
> > +
> > +  Set work queue mode to shared mode, since ``QPL`` library only
> supports
> > +  shared mode
> > +
> > +For more detailed configuration, please refer to `IAA Configuration
> Samples
> > +<https://github.com/intel/idxd-
> config/tree/stable/Documentation/accfg>`_
> > +
> > +IAA Unit Test
> > +^^^^^^^^^^^^^
> > +
> > +- Enabling ``IAA`` devices for Xeon platform, please refer to `IAA Use=
r
> Guide
> > +  <https://www.intel.com/content/www/us/en/content-
> details/780887/intel-in-memory-analytics-accelerator-intel-iaa.html>`_
> > +
> > +- ``IAA`` device driver is Intel Data Accelerator Driver (idxd), it is
> > +  recommended that the minimum version of Linux kernel is 5.18.
> > +
> > +- Add ``"intel_iommu=3Don,sm_on"`` parameter to kernel command line
> > +  for ``SVM`` feature enabling.
> > +
> > +Here is an easy way to verify ``IAA`` device driver and ``SVM`` with
> `iaa_test
> > +<https://github.com/intel/idxd-config/tree/stable/test>`_
> > +
> > +.. code-block:: shell
> > +
> > +  #./test/iaa_test
> > +   [ info] alloc wq 0 shared size 128 addr 0x7f26cebe5000 batch sz
> 0xfffffffe xfer sz 0x80000000
> > +   [ info] test noop: tflags 0x1 num_desc 1
> > +   [ info] preparing descriptor for noop
> > +   [ info] Submitted all noop jobs
> > +   [ info] verifying task result for 0x16f7e20
> > +   [ info] test with op 0 passed
> > +
> > +
> > +IAA Resources Allocation For Migration
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +There is no ``IAA`` resource configuration parameters for migration an=
d
> > +``accel-config`` tool configuration cannot directly specify the ``IAA`=
`
> > +resources used for migration.
> > +
> > +The multifd migration with ``QPL`` compression method  will use all
> work
> > +queues that are enabled and shared mode.
> > +
> > +.. note::
> > +
> > +  Accessing IAA resources requires ``sudo`` command or ``root``
> privileges
> > +  by default. Administrators can modify the IAA device node ownership
> > +  so that Qemu can use IAA with specified user permissions.
>=20
> QEMU
>=20
> > +
> > +  For example
> > +
> > +  #chown -R Qemu /dev/iax
>=20
> qemu
>=20
> > +
> > +
> > +Shared Virtual Memory(SVM) Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +An ability for an accelerator I/O device to operate in the same virtua=
l
> > +memory space of applications on host processors. It also implies the
> > +ability to operate from pageable memory, avoiding functional
> requirements
> > +to pin memory for DMA operations.
> > +
> > +When using ``SVM`` technology, users do not need to reserve memory for
> the
> > +``IAA`` device and perform pin memory operation. The ``IAA`` device ca=
n
> > +directly access data using the virtual address of the process.
> > +
> > +For more ``SVM`` technology, please refer to
> > +`Shared Virtual Addressing (SVA) with ENQCMD
> > +<https://docs.kernel.org/next/x86/sva.html>`_
> > +
> > +
> > +How To Use QPL Compression In Migration
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +1 - Installation of ``QPL`` library and ``accel-config`` library if
> using IAA
> > +
> > +2 - Configure and enable ``IAA`` devices and work queues via ``accel-
> config``
> > +
> > +3 - Build ``Qemu`` with ``--enable-qpl`` parameter
>=20
> QEMU
>=20
> > +
> > +  E.g. configure --target-list=3Dx86_64-softmmu --enable-kvm ``--enabl=
e-
> qpl``
> > +
> > +4 - Enable ``QPL`` compression during migration
> > +
> > +  Set ``migrate_set_parameter multifd-compression qpl`` when migrating=
,
> the
> > +  ``QPL`` compression does not support configuring the compression
> level, it
> > +  only supports one compression level.
> > +
> > +The Difference Between QPL And ZLIB
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Although both ``QPL`` and ``ZLIB`` are based on the deflate compressio=
n
> > +algorithm, and ``QPL`` can support the header and tail of ``ZLIB``,
> ``QPL``
> > +is still not fully compatible with the ``ZLIB`` compression in the
> migration.
> > +
> > +``QPL`` only supports 4K history buffer, and ``ZLIB`` is 32K by
> default. The
> > +``ZLIB`` compressed data that ``QPL`` may not decompress correctly and
> > +vice versa.
>=20
> s/The ZLIB compressed/ZLIB compresses/
>=20
> > +
> > +``QPL`` does not support the ``Z_SYNC_FLUSH`` operation in ``ZLIB``
> streaming
> > +compression, current ``ZLIB`` implementation uses ``Z_SYNC_FLUSH``, so
> each
> > +``multifd`` thread has a ``ZLIB`` streaming context, and all page
> compression
> > +and decompression are based on this stream. ``QPL`` cannot decompress
> such data
> > +and vice versa.
> > +
> > +The introduction for ``Z_SYNC_FLUSH``, please refer to `Zlib Manual
> > +<https://www.zlib.net/manual.html>`_
> > +
> > +The Best Practices
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +When user enables the IAA device for ``QPL`` compression, it is
> recommended
> > +to add ``-mem-prealloc`` parameter to the destination boot parameters.
> This
> > +parameter can avoid the occurrence of I/O page fault and reduce the
> overhead
> > +of IAA compression and decompression.
> > +
> > +The example of booting with ``-mem-prealloc`` parameter
> > +
> > +.. code-block:: shell
> > +
> > +   $qemu-system-x86_64 --enable-kvm -cpu host --mem-prealloc ...
> > +
> > +
> > +An example about I/O page fault measurement of destination without
> > +``-mem-prealloc``, the ``svm_prq`` indicates the number of I/O page
> fault
> > +occurrences and processing time.
> > +
> > +.. code-block:: shell
> > +
> > +  #echo 1 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
> > +  #echo 2 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
> > +  #echo 3 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
> > +  #echo 4 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
> > +  #cat /sys/kernel/debug/iommu/intel/dmar_perf_latency
> > +  IOMMU: dmar18 Register Base Address: c87fc000
> > +                  <0.1us   0.1us-1us    1us-10us  10us-100us   100us-
> 1ms    1ms-10ms      >=3D10ms     min(us)     max(us) average(us)
> > +   inv_iotlb           0         286         123           0
> 0           0           0           0           1           0
> > +  inv_devtlb           0         276         133           0
> 0           0           0           0           2           0
> > +     inv_iec           0           0           0           0
> 0           0           0           0           0           0
> > +     svm_prq           0           0       25206         364
> 395           0           0           1         556           9
> > +

