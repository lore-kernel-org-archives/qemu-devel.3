Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168D1C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1sR-00019X-Hb; Thu, 20 Feb 2025 03:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tl1sP-000191-BE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:25:45 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tl1sM-0000Sk-T6
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740039943; x=1771575943;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2LwhF6Rj2W9j2ju8tpq5ou+6YiKGsp8UJ3C8i1Jswh0=;
 b=Ad1OfVOqRtP45/1i6QhK4z7kovgtlu36mSMq/HmqG5CEM/bhYrfafKId
 gwwC20mEahVHpBCx4/SmAmTp8XKlh7GtBAVofdmPJBEQH8f7mmr02PTb6
 LTHjC+giN/WGM89wutmiHNY2fhJzYgoWiNOvNaLo4vp95KTFTNIao1ZXw
 xGnAg2GF5YLxAgQeZP8Rmm+CGRm/gcet++Qu8YU1gXdjfyd+SA86scSFU
 z14ieGx8W6mEIRiM++NTD+HB/h2PGnIvKkyrJMR9A3HzdTADN3TH5jPnc
 qrK+wTw+xb7lGKdXf+op7gJay38X2vm2fJi1xzRKdG3JZ9dqI0QG05Zqd w==;
X-CSE-ConnectionGUID: lIyPIsqlTMCNoF9OwtflgA==
X-CSE-MsgGUID: MA5QIrNFRaq7DhFy2LJL2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="28402465"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="28402465"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 00:25:35 -0800
X-CSE-ConnectionGUID: UHjulf0hSQ2XgNsQAT7IXg==
X-CSE-MsgGUID: qGdEmfoJSKu8VqJOW23VoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="120196449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Feb 2025 00:25:33 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 00:25:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 00:25:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 00:25:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcWXN5pkifp+yI6qAPemYPYuDRE1o2ycoahSCCcEilWhRIgtd8qZ67Iy0dP+HdKME+Zz2lqIJOwbcIZwDrdZUo6X3eI5uL7ZnDuyowxjuOCM+XacLiFpWm2Pe0ZqXNnGd+NSWqXIDxnIYLBaGtqnHdQtmGjLdJDWLkjDwomvskRoJ9NKdpc669Kl4OfxukerL9q4tpgQhzZzlz4pV+Gkt9ggSNZRMjijoJLmuvUgNOvRmsfqO/hpuPLVmaKeFS9025Jx3lTO/avHm5U2q2R4VMcILcbxm6Su84xVjjuCUoI9aB8riANMFBbAq9Fee2IiaOzWDoYFVJQbCY5eNC3Zlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whTS0IrcYP8apnB79wa84P4oLbcnW5EgGJrUz5LQ0YM=;
 b=fLanwh1yJD4M+3Bk1f48iW0ZRUl0X0kHSs1Fkl2zcEYYVW5alauNVQkekcC8TuxpxN7+LGvJnlfwOl4KLvYkGg7BbLUGo5VZ7D61p/s5uYXgvF9P5x9DgL4Z1EAq6HWuXNF0ODav5TB2j0zR+0EQft5RF0q7WE2ZK+1kljJXji/5MLpacZ5z1c5iGZjUbmMtFWIs2touhd2cMyqTM4E9HHC5dx5wtYUmdm6ZNmibJW+vTi3GPcxFlIc1i4RFjYr23hIFR6jy4yFygXPpzzdklONPB5ZABHfYjIDskON7O5GdFxN4IoI3y9c0Kfn0PwkC3OPBcHODeg3EIh8rUEDpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8686.namprd11.prod.outlook.com (2603:10b6:8:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:25:29 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 08:25:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "clg@redhat.com" <clg@redhat.com>
Subject: RE: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Thread-Topic: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Thread-Index: AQHbgvuwzAAYetEsY0mcGqcnVFi6xLNO+qEAgACZYFCAABAhgIAAH0Aw
Date: Thu, 20 Feb 2025 08:25:29 +0000
Message-ID: <SJ0PR11MB6744F88F2371D1419ABAAAB092C42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219175941.135390-1-eric.auger@redhat.com>
 <20250219115844.062c5513.alex.williamson@redhat.com>
 <SJ0PR11MB674418674B2374371F2AA24692C42@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20250219220525.08d39475.alex.williamson@redhat.com>
In-Reply-To: <20250219220525.08d39475.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8686:EE_
x-ms-office365-filtering-correlation-id: 3a45c511-7381-47fd-571e-08dd51882286
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gU7Xym7cVwQO90lkxaxfHQ+Nm5mQdOVpJgmuaWmxnW/PJ4LGdPzM2AHqBgFL?=
 =?us-ascii?Q?eFG2UKUaMUc85x9vFQ+teah1VhKRLcYtRGWFjl95rr6t4SuTiIaamQ6zQUV1?=
 =?us-ascii?Q?cT1bfxcEH+XxQD3fwUj6fWtYVG1whgveCsana9jNHNN6VgmDPUck3oYHqAjs?=
 =?us-ascii?Q?2vPEzpp3D5+BaHC35OQ9mmEajKlFqkVsGf1Vs2gIS1aE3C2U0RuVOXUOmm/2?=
 =?us-ascii?Q?fWBCpC4GHzJZDlDsQN5SUJbD/7xTEl3URfSaVMq9Qv9PUIiOfipz+p5XOJoS?=
 =?us-ascii?Q?IQMKOuwUD200cMEhdcUh3fHry8ceLGanOfbFhjhgCcdFDKc8itU98S7DORgY?=
 =?us-ascii?Q?tJ74KJ3Dtyt1pvZjTRq/yCEBVvRUO0z4tWs+s4Jk6gjGs0RTslJu/TzRLMEp?=
 =?us-ascii?Q?IegV0ZXtxUZzLyUL1PzaOW4licdVZ41mqd60+HfBCDWDDR43oisTnJUjiS8Y?=
 =?us-ascii?Q?B9e3SNLUz8Yrh18nhnnzpP0n82HIPaI8eR0RiQvOaqQUrOaHzwpNYS18mRHU?=
 =?us-ascii?Q?FNXUdOYC9nSy7PzWsyLghyFeNuxZPu/gZL2Givm6Qe2YA9umCDyBXkzSAtlv?=
 =?us-ascii?Q?TS4gYzCuMe4rXYoCURuZIruZEmpzTEeOmF7lyk/YrZuJVOXeyNYFORrGAYU+?=
 =?us-ascii?Q?clTkNBTknfP4hwtBhNnb1QQ8NoK8eamp9cnnoVUCxzqjZbyUDcToaN8VCnUA?=
 =?us-ascii?Q?GUngyVNp6ms/1fogpliDuBzFGmEpSiqgONS66hESefSN2+WYtY0zN0Evq2q2?=
 =?us-ascii?Q?6r+61lUBnWrq6Is5dnpQ1e+5keNTyvh1pbUngFkqKxm4TjiSErqNv8EhowJ9?=
 =?us-ascii?Q?Kp1BhJuBPGeSJ3HO1cQg/CPYzJuMljOIwPO7JEstsfo+lKdjdq52BnHcC0mF?=
 =?us-ascii?Q?OiuB19LAbgmLLOgHc0nz7qT+aOiu8CfBYtDHXrQQgyEiOKUnsVwoX2QgdSi8?=
 =?us-ascii?Q?moeda8nIg6h480aOidcimV2F1WDoWrX+7RFtNzcHUSV+ds72wOImmE5K4O8D?=
 =?us-ascii?Q?txkVR+CQasUHzkYUqOmPzw7TrIReQZdSWt+E7yL1da8DH6LVkxJyMApTHxIE?=
 =?us-ascii?Q?RF55vavOd+/p+iX5mg2fwsYYT1pQxh/x+B0ZfMWpsD8f+rosNjbRM26kltxq?=
 =?us-ascii?Q?PoLKodp1EFqO3sxpOCLUyQYKoNtULN6HWtc6QO1Ol77xAQBCCrIIB6deUgdf?=
 =?us-ascii?Q?cFJgz1UvdkqTm7SJRTtuN1hzVEnzJv27OU3Wb7NO3boPUmSnqUFnsBTzCPOZ?=
 =?us-ascii?Q?skWdLQmP1Xa67tUCw5oy2wV1+RvPdthI71vzenGnHrXAhJhDdMUsnWp89mMs?=
 =?us-ascii?Q?357IfEvoeBZS2CrEH3rCyjj0kGIVCGcVlc0D0e85vkb2KwG0IkuGELM2waRd?=
 =?us-ascii?Q?DSs5QsVyVGs8uMYbV5ZGKLQ1Uo6kQrTUI9R7ins2uMrsED5cf4xEKfilBs2N?=
 =?us-ascii?Q?tSaGOaPJb786iECySNKNdDYr1NtPVuWC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7En+tZ2FN2KAAiQjBZyD+WXzZim5rnkQ26XP6PX4+mMSbLYDvvu0LcnKOxLU?=
 =?us-ascii?Q?hsAGDXtA4VkK4Vtx3nzmReWw5hMTMigSU0kqhUElMgLT9q0FXpiaUhSS4PMH?=
 =?us-ascii?Q?8/fvDw24+0NRU/w8t0kIWscjpwh3AgVKj3QOY4F+nQqRbZbe8IbYOOXaQZSF?=
 =?us-ascii?Q?kiqk6+gfTDbIf8ocujvFWzM10KAjThKLmbca/t5+VfLox0nyBnr0v51c61ab?=
 =?us-ascii?Q?6GlRlbD0/VAAPZzsehgX8/AdoxmfEFfYKpTl+neE/ipEUgmQPOMDZRNiNFhy?=
 =?us-ascii?Q?tniJBnv1Vc/GJ0EzOOHgPnAa/milEE7f+pQoQ2c8DOgQQlBzllnFuFJz/JEF?=
 =?us-ascii?Q?SR1kqLV1hWx3mSNtNvZ1hw033Wy+Guba6aXI/LVnFRjgcdYuvwyBxCPvaBN2?=
 =?us-ascii?Q?HW9KsZbzqnaxAR32aenx667fe7vVvzajG9mMd+rea9hRZidLB44UNLxLuw7o?=
 =?us-ascii?Q?TA4r+3xqM8e3CwZ6Gdh3/s6SGpMQiezOv6h916OvTo3rusgtcphbeEqBnqcP?=
 =?us-ascii?Q?C27f8Ok9+gkai8H1s+NLQfh9kPFS08Cc2o4dH/dtXNoc9XFhH1QgU7LfRh/0?=
 =?us-ascii?Q?PX5ta6Mp/YjmVqr3wJTYUk3s7THae5YCsnTSxOX8uMsv1rpfJL16gMaw6Vpx?=
 =?us-ascii?Q?GMiI1nwqMz3zw3YdoOdNY9Wf0ysQIKz+DhJgBWcNRqZhOcqfqYucmikiuqh0?=
 =?us-ascii?Q?OEQv7w7YW5D5pCBJ8SEgw2Pmw6gKLNtZM/tPIifpKX8WLTYNoBvTiwIKc7bH?=
 =?us-ascii?Q?nkZTrJ+ageZNXADZgHN8ycP+Lb0EdYyemx+AEp+V5p0EPcukvbTlVcPcdzVK?=
 =?us-ascii?Q?bJfOylsBa9dfO48YVZJa9w379WV4cvPD39zAO4Q3AOTdFYHBTqd44B2JdTud?=
 =?us-ascii?Q?FqNGZEhv2gYpyL/EcOpoGSfR/5UuFrTBstHpwv16xrO5WiErLr6s7FijlbVy?=
 =?us-ascii?Q?BejJ+aptTTD/u6MFPEjYpEXyKM6Qg4mx72/PdZ7qXI/DnVbH3x2usUIL22sP?=
 =?us-ascii?Q?kwMLCzBP99Etzmu4PsoBUHjzQex6nGxy4XNvuVYlg3XRLLtAQnjVLr6dQT0R?=
 =?us-ascii?Q?kLBGqhh1ERgPcgWPxL2lTiRQhilRr4XuaSXaJqVT+iGKjJ86iZOVHFmIZLQU?=
 =?us-ascii?Q?hujtrjYfYwa8l01S1StJ8zdtqvBFO98SD/bxRgBHb5fMXfwC54ayuN+wyjpM?=
 =?us-ascii?Q?jM10Nq7Nr9hpWZ2RYxoNGfnPcp49l+Hn1+z9PuE147wkCrvkZ1r65QCHcghl?=
 =?us-ascii?Q?TmtIbyMyHMBH6tWkoJqiZMYGi8kP2F4Fghnoos0qSVP8FikYWBQoiEspn7tW?=
 =?us-ascii?Q?CCtDCbc1b9yeoyy+VD2u/5/ycaWiICdZn34z4+ESCSnF40pgtWFIaBA04DHx?=
 =?us-ascii?Q?7ZW6/VqH6p/tEPNhJOM4fTsgSe4Q+x/96iDkALBgl8JhxqPaxH806orLJ/wm?=
 =?us-ascii?Q?w5W+fm0u0rE1f1OKptp27EEtu++I/b1X3YEl7RUxzRq9tF6pejbku7LTkmtQ?=
 =?us-ascii?Q?a5gXYF2ro7+UQuCp68KOQOb247iaKZH2HO2RgidLvzLC2l7krH3zcbJCWjh8?=
 =?us-ascii?Q?dedzmOdPbLiGp3pzXiqPCilLZxe+6z3LBD+ew+J9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a45c511-7381-47fd-571e-08dd51882286
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:25:29.2784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CvN9wjqCFTDmtPI0BkIURZapiy0Wqdq2dGebMmd0yDfV8gUoUTF5l7Ekf+yezJ10pDv4+DnWFzU4bfvnQIXb67MjEbHTW+8WXA2lL/8at/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8686
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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
>From: Alex Williamson <alex.williamson@redhat.com>
>Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
>d3hot state
>
>On Thu, 20 Feb 2025 04:24:13 +0000
>"Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:
>
>> >-----Original Message-----
>> >From: Alex Williamson <alex.williamson@redhat.com>
>> >Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped =
in
>> >d3hot state
>> >
>> >On Wed, 19 Feb 2025 18:58:58 +0100
>> >Eric Auger <eric.auger@redhat.com> wrote:
>> >
>> >> Since kernel commit:
>> >> 2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
>> >> in D3hot power state")
>> >> any attempt to do an mmap access to a BAR when the device is in d3hot
>> >> state will generate a fault.
>> >>
>> >> On system_powerdown, if the VFIO device is translated by an IOMMU,
>> >> the device is moved to D3hot state and then the vIOMMU gets disabled
>> >> by the guest. As a result of this later operation, the address space =
is
>> >> swapped from translated to untranslated. When re-enabling the aliased
>> >> regions, the RAM regions are dma-mapped again and this causes DMA_MAP
>> >> faults when attempting the operation on BARs.
>> >>
>> >> To avoid doing the remap on those BARs, we compute whether the
>> >> device is in D3hot state and if so, skip the DMA MAP.
>> >
>> >Thinking on this some more, QEMU PCI code already manages the device
>> >BARs appearing in the address space based on the memory enable bit in
>> >the command register.  Should we do the same for PM state?
>> >
>> >IOW, the device going into low power state should remove the BARs from
>> >the AddressSpace and waking the device should re-add them.  The BAR DMA
>> >mapping should then always be consistent, whereas here nothing would
>> >remap the BARs when the device is woken.
>>
>> If BARs should be disabled before D3hot transition, isn't it guest's res=
ponsibility
>to do that itself?
>> Just like what have been done for FLR which calls pci_dev_save_and_disab=
le().
>
>Nothing requires the guest to clear memory and IO from the command
>register before entering a low power state, nor are we going to get
>very far arguing that it's the guest's fault for triggering an error in
>the hypervisor.  The PCI spec indicates that memory and IO BARs are only
>accessible when the device is in the D0 power state.  On bare metal
>accessing the BAR for a device in a low power state would generate an
>unsupported request.

Understood, yes it makes sense to remove BARs from AddressSpace when D3hot.

> Therefore why should QEMU map BARs of devices in
>low power states into the address space?
Should not.

Thanks
Zhenzhong


