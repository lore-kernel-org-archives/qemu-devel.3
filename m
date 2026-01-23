Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A75D6CFBA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 03:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj7zr-0003vM-0h; Thu, 22 Jan 2026 22:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vj7zp-0003v5-Tc
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 22:38:06 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vj7zn-0002QO-Ao
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 22:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769139483; x=1800675483;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jhz4Mi3drtnv2cfDmcUK9g1mrL7UPbOzoiK3a6DAE9Y=;
 b=IUH+6EhjNUBclsz3VMjbwSKcB48SzbqC/ICHGu3fukrlyBWnfiMDFGx1
 saScROlovgt/aPIRlG8IyrkNOlHBm5mM3uUe/SmOTw22kWWM66wkF3tuZ
 zhvwEy6h+c7Zh1TqDZQlB3nfs8aFu2ZL3omTW6QxG/EAVlgtIAB43KK4p
 pPwxuCPVdlI8yD8pjxgldIa0XuLmevuwEtnBdB8l34OR7AshlE5qLYFgb
 020dVp9Dc9UhyyPYSEKK4A05yCGzYIy8cJDD5BfVLthm9tZ5DOg7YVH2t
 R4cdsIsYWYeRMEcMaHgv7CSskZWPd64sejFA/NggtKA6WGgXWp/01Q2Dg Q==;
X-CSE-ConnectionGUID: qlZAWXG1SsWBSwJ2cYkEuQ==
X-CSE-MsgGUID: HK2IWbNhTYmZ7uESiCH0Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74251879"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="74251879"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 19:37:59 -0800
X-CSE-ConnectionGUID: xorDIzTDRXqEv4bV2PvGeA==
X-CSE-MsgGUID: pCfd5ZVkS62dorSTY85cew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="206820625"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 19:37:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 19:37:57 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 19:37:57 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 19:37:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgpLAzlFCvwUQtawEDX1rO5h1fge5WMkKPfdQUK75cPdiUW/Jym9UOd0EX483c84aK4pJ+0wULHvPL4Hu05KlcMhC3HCGwaBrCujwaOBTT8v/e9FTDexNPEuPxbbRbvi9d1g5gDz7i6fF8Oquhoz1EH/EcW2GkHSZWbobeN5IgFUaG2HNoz9x3eE9eLObv9ZrYrY25qfGg+lPUQ9ta15Dfn+x8IbNqZoS12dW+O+ZWD5XWO1Pn9Vpbl7DJq9Ltkq6iyH6t/FWs0vhTtVxiYcrltnwkKVsEO7M7uGFaQCOxTDtQyFeRkITaR90q7nT9d3KocPRZ2ew3U1KNT2Ua6roQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhz4Mi3drtnv2cfDmcUK9g1mrL7UPbOzoiK3a6DAE9Y=;
 b=hr+8JuHel3OyzY37GJ6D7PqfCBxWu43jxSe342v9MXnw/W6gTjSJwRKXc1J9Vj5ynzVfcGznIQHzqxw8XT4xPORyMWC7nkzm/69j4pB24JeHeC6NR5hw7ZHN7L/Xwzxl8UNqdCrAJVaUZRUm/7ixo19dpzXqpYcFJYazR2mReB53NTBkBsfa0qf/wVhiTpCCC9FvNobFZmQ9ABlFHsxk6Nzthy60IB3geH8d5Jwjz11yytAFUm6crHDtDpXZP1k7BoiS2Ecb4bUjp05LfbRXbw2lxtcKyM6WsY9Qs0S0auVUuE/W9wnA5R5j7fAubhma0y5IiMwRk/xEN6U19IQ3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ5PPFC0624F2CA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::850) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 03:37:52 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 03:37:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>
Subject: RE: [PATCH] vfio/migration: Fix page size calculation
Thread-Topic: [PATCH] vfio/migration: Fix page size calculation
Thread-Index: AQHchq3c/YuhchgyOE6hxPeJ682D4rVeOHgAgADq1EA=
Date: Fri, 23 Jan 2026 03:37:51 +0000
Message-ID: <IA3PR11MB913691468156580EB53424129294A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260116060315.65723-1-zhenzhong.duan@intel.com>
 <CAFEAcA_LnfF-TqF2yKcPJOK4WHJnbt1RECk9svdRkRrvgRqqSQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_LnfF-TqF2yKcPJOK4WHJnbt1RECk9svdRkRrvgRqqSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ5PPFC0624F2CA:EE_
x-ms-office365-filtering-correlation-id: 8211c393-c9f6-44b4-0ac2-08de5a30c98c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RXJIRjNUNzEwcjU5Mnc1SlNZc3c5UHdTM2hpVk1zYmJpNENxdnc3VVBwODVR?=
 =?utf-8?B?WDYyelZrOGlITEo1MTh4N1dOTG5QWDdmZ3ZMSFRsK3Vra201NGMwYm4wZ0ph?=
 =?utf-8?B?Y3h3UlVSK2ZnUjlEVFg4aDF1TE9kMEJ3dVBOcEN0M0pNVFpLNW5EWm5haXpC?=
 =?utf-8?B?NitzUm16T2NGRG9WdElQRXhpT2JBWWgzMFNGdDdXRUdmQVA5bThRMFNwYnVs?=
 =?utf-8?B?SzhLSEtCSXBqei8ycnFyVE5mYTd2UHEyN1hpZHk2K2FubFEzb2NMWC9rU3p1?=
 =?utf-8?B?eGFNSzVVVnVicGprTExPK2FZd3ROQk1YeFY0a01yNmF6YUJsaG9HWllKR0Fr?=
 =?utf-8?B?c1lVYmpiMnlPRjQ2UjdVN1dJcXg5eFBob2ZpN2xvdG1NeVVNanBmOXErUzJG?=
 =?utf-8?B?Z1E2c0Q0dHVxWThpQkdIUTVodU96NXBCRWlVbnlwQ2pVT1k0U2ZWWjJveFNu?=
 =?utf-8?B?aGpyWXlDT29nblFsaERDblBaWWk5eXZtMk5xTG5vejVyaFkrbW1lMitMUGhJ?=
 =?utf-8?B?MkduaHpINW56eFZCNzYzczIrU1lhSXNHa04vNExJYUgwV3o2SW9FNEVGS3lV?=
 =?utf-8?B?RWp6MW9SbUFsbVNBUWhUWndoTGNIT04ySFp4UXEvMjQxSnkycDR0eVdXTFhX?=
 =?utf-8?B?M2pBREpwTC93V2VvZVJiR21JM3AxWkZ6K3VQTG5rWEtsb3ZVR1R6SUhoSm40?=
 =?utf-8?B?ZFlZbWVvVGp1V2d0UUpIeklpWS95aWVrVW9UOGk5WlB0Y2c1Y21ZdWhWam5v?=
 =?utf-8?B?VUcwM2c5UXg1L1h4dkpoZTZPVGdBV0ttRDdBOFpzT0piVndRNnJEMzZuYnlL?=
 =?utf-8?B?M3NTYjkzVmIyekxqRy9DSUwwc2U2eE5mRkc5L213QlUvRUtOOEdtUjhFVS9u?=
 =?utf-8?B?Z0crdXZGRENPTVFhRWFzWGlNamwvbExuMkNHZTlZd3BRYWxoVG1WU3FCRkI5?=
 =?utf-8?B?QjVMcW9WWDMwMkhpczM1RnBTZnNZR0cxRURhY3d2WWR0djQzV1hQU1ZRWC9T?=
 =?utf-8?B?b3cvdW5JaGVvVzhTNHRiR0lSVFpxeWNqN2gwYUc2Ujgwd0ZQWHE1L0hIYlI4?=
 =?utf-8?B?LzhSaFVNSlRXWndEQUpVNFBaREhkbW1VK3J0cGx1Z05mRXAyQ2RIRmFvckV6?=
 =?utf-8?B?K2VPeHdBMTFJZjhPY2krTHNHUDROMUlxZ0dGYVBmNDArd2JndWNOcWR5M0M2?=
 =?utf-8?B?dDQ4QnhKSElhUWNSSUVrMEFwSXluTzR5dFhCbEhXV0VMWTgybVd3bUcwMmZN?=
 =?utf-8?B?UVR3NEZaZXJ6WUF0M0Rjb3A1WHhZc3ZQeGdiZW1tY0tyeG9JVkRkTVZQR1FS?=
 =?utf-8?B?NlJJQisxaEp5L0ZTK091YkhNeFZKUGk2SWRUczFVYlN4MkphSko3d2lJZDBQ?=
 =?utf-8?B?OFRTanIvaWNDbFFITVA4NG1DRDFLWEI1c05JUDdaK2VLVmdpNE5TNG4yRnVs?=
 =?utf-8?B?NzlxK0EycGwzWHFmYmkwSndKRDZYZ3JTM2gxa1lwQkNoa2tYeEFObHpGTEpW?=
 =?utf-8?B?bWl4NlFMWFhPMGVsVC9QeEhtT3hucnN2ZzQvdDBBdko3Ti9NeUJSako1MVVZ?=
 =?utf-8?B?L3Q2V2h2a1VJRVUrMjRSL2RkdHZNbk1VMlNCcEI1bGV4aXBvcU1iNkRWTnpT?=
 =?utf-8?B?dTNFRFkxbTgvZEM5VDV6eTBGNUZhcy9ReWtPdE1lajRhWEZkSk5UYWtRSHZ4?=
 =?utf-8?B?RHVqd2w2ZUFuV3VaaVJiNHhUa1NkVWVaSkNxcWxWaUhUdzVhTFlDMUN2VnpK?=
 =?utf-8?B?Q2tGTGovVUdhVExvbTFkeXVwdmhTUS8rOFcxYmRFdU8xT3p6SjZCRDNsUHEw?=
 =?utf-8?B?MWNIY1UxeTJZK0FqV1VuT1J4NDRoQ2FLNFd6QkxOT1NJS0V1VUVPUTdlMmk5?=
 =?utf-8?B?Y29BUG9paEVSSnZsdFlaQmR2VlNlanphbGRmSXhyQVBZWmNLR3JTeXZxSjdX?=
 =?utf-8?B?NWEvTXdXQy9NYnR3NVlrK25oWWtpdjJ4QWJOVDEybFEwNWlJaXZkTkJ1RDcy?=
 =?utf-8?B?MkpYZk9GN2F1dUFpVGlkS3c3eXd5WWxMcG9lL01zYjBxSU0yRXFCQzNkalRa?=
 =?utf-8?B?dXdzTmtsSWN0SzVINjQ1NkdBYUVKelduNWFndjcvMVBzMEl5eEVuN01aRkdC?=
 =?utf-8?B?UnJNRkMzRFM4ZVZwVzVTc2dPQ0h0dC9GbEZzbTdKL0wzS0lYTTM5M2U4eVpC?=
 =?utf-8?Q?THHav47Q3yLhu5XfEvgXmuM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE1EK1FTcHY3L1hSL0c1NlNLNnZHbS9KRnhYbkM5MEs5VHFRcGduNVRXWkFH?=
 =?utf-8?B?M21uRHdvaVB1UGZWMU9UMENKRlk2VGczRHJHZks4MjU1eG5TZFI1RzhsTkgy?=
 =?utf-8?B?NW5Fdk9PZS9KYTQxZER3Qk1seDFsemg0RXc0SDVPdmd6cEtpeEVRNUQ2SGpu?=
 =?utf-8?B?emJwLzlXQlUrNy9VZ1dCWDJ1M2xYdExzUzFkV2xuZUg1Y0dnT2tHcjdpZzcy?=
 =?utf-8?B?dUptRnZYbjZmeHJSSUF4VGNNM1Jaakl6VURxTDZMdU5WU3I3eTFCaUdUR21Q?=
 =?utf-8?B?S3BEQlJ0L0Q1RzB5VzZjU3ErZnZubGJZdEU0OS82eFNsdEpTVnh5bHoxdU9S?=
 =?utf-8?B?ZlVOMFpsaDBUSEhRcUxFYjBGWStsRndMWHhHaURMNTQwQlZVd1cxOGxEY3dz?=
 =?utf-8?B?TG1lUnFObjRINjF5ZTMrSjgwVjJOcHhJbzc0bW9pOWxsMG9NaWRMeXRhRlJz?=
 =?utf-8?B?M0JlNjdXV2Z5Z3FDUlZYL1ZoaXNsdHNxcExxYkhra1RsMzhVanVrUFhPOU5O?=
 =?utf-8?B?anJmVGtzY0VBUmgwamRYUjQ2RWdzNi9GY3BVeVBrdm9mRHF2bVltTkF3YkxW?=
 =?utf-8?B?ODBGN0thSXR2UDZZUEVud2tVYmpiTVh0YjEwN1lVb2pkd2FHcnRXZzloSjRZ?=
 =?utf-8?B?RDg2Y0ZCbkhJbVJ1RW51bm1SV09GY3JSM1FGcnRKdGlyOGxZZzVjQWx3U3d4?=
 =?utf-8?B?ZkRQZlZzZWRuOU1ydmpSUEpISzBUdzJUNE1qeDVLWk1VM0plSkE1c2lUN2tl?=
 =?utf-8?B?b1A0RWZ1NnNOS3Vua2h5NFIxOWFUdExwTmJrRUtzdFJxSk81ZkxvTVFOcGQz?=
 =?utf-8?B?SXRIM0daWlZqOTAvYUhXRlRxeTM3MWV5QXF0bzk3TmxTMzNORVVLQUFnSnR2?=
 =?utf-8?B?Qk9XUVFDS3V0UlVObTFHeXY5eDBINUo2K3phaU96djFUNmg3d0tJeEtjVjhP?=
 =?utf-8?B?d3AyV0ZCSzBCY3BrTHNXVjdWaGxiV3lRUzFSV3cwSTdBRGc2YktxSUROQ244?=
 =?utf-8?B?MFZnM3MxakoxVEVXdWg3YXNPZUJmYjRIT09oZk9PTCtRM3JURzJVbml1eDZo?=
 =?utf-8?B?SVhFTUlMT0xld2FCSHJQUENxcStzcmdJMnU4OTJWVnk1eHVtbkNnaEhIa1dw?=
 =?utf-8?B?VlpKaUVkQzRiVDVHb3R4V1I4L1Z6Qm4zSE1LcmoxcUpQNm5ja1MwNlF5K1Q1?=
 =?utf-8?B?OUhKOEkvdFdSQVVPblVFU0VEa3YyWDdNSXJnNUpvUi9DalpTSld5akNXR05R?=
 =?utf-8?B?YzQ2TmJ5UmwwRkR3L0ZpcjJUTk5tSlVxM28wb3hlQ0U0NjBsSmZEdTVwY1BK?=
 =?utf-8?B?V3lEZGl4TVFmSkt6L0JmdHhmeURPeGlhdkVUZ3FEMDVHT0hVeEc1c2luT0kv?=
 =?utf-8?B?TzlvS1ArYUtHMVZDRm9rWHFsU3o5ZVA2OHd3M1h6UE42R0kyNzZMQlY4cmtU?=
 =?utf-8?B?Z1VHVnRXQXJHRFpQcTgvalJuQjYwbndDQkJvMWdkaXRsV2prZkdLQzhubkk4?=
 =?utf-8?B?TUp6ZDhtRDVIbjlPem9VUHl6TFlaSjRpNnIzbE1EcHYzR29zQm1jUGd2YjZ4?=
 =?utf-8?B?UmU1L0lpZmp6WXVib0lvdmtQOXdZaUxxcE84MHRjamlzTmZoQjFZRWJXdWdF?=
 =?utf-8?B?b29JMEJYWjVFOFBnREhpSE04Uk5oS2VRWnNwWGM1cTVGYk9FKzFobEpLVU9k?=
 =?utf-8?B?ajR6WXN0ckFZaE5vZG5wUnZzOVRtRjc3aDRMMkxtWHRtV21OSHNnY0RoVkwz?=
 =?utf-8?B?cmp1MTJESzNKakVPUURvTG5Wcy9GZ083eHpmWm5CQk9oRkRNa3AzQk9UYy8v?=
 =?utf-8?B?UTlGdzdiM1ZWdVVNMjA2ZC9yT3BsOVM1MVg5VG9sRExpMVgzeGxsYXE5L0VV?=
 =?utf-8?B?RUJvbUQzNm0wSVRyT0VHd05IU3B5WFRaOGVDUm5ybDVEb3lJOWNkY0ZjN2dP?=
 =?utf-8?B?RXdLS0ZzQ0VGRW81OTNhUHJrdkE1dUdGZEd5S2V2QUhmN1JiMVdmazdSTFNn?=
 =?utf-8?B?c1VFNEV4c0tFaURUWEZLSkkrZ2t1QWh5WmhIK3M4TXhxQWk3dHJ5ZG04M0VN?=
 =?utf-8?B?MFpCM2xiMmwxbXlMS1NmcTgrYUNJSGR0aXlkVkoyNlBYK0R1Q1lHQTBwajhs?=
 =?utf-8?B?d0VMa2FNek1lWGJ2RC9UUStSYUhIZEZNZ0MxK1RvbW55VCtHclNZR0lPY3Bs?=
 =?utf-8?B?ZmpEVlFWcDhhbTAwRWNCUktwaEorcHBFVnBVSm9WdGs0VjVOM2x2cnpsUmpu?=
 =?utf-8?B?emhYNjQyZGJyN3Q3c0V4OXl2aUZRS0tGZTk1ZDArNE9WT01yRWduWjNBcUlH?=
 =?utf-8?B?ZjIxTFIxZmdVSGs3RXp2VHN3R3lPZXJzSE9adGFUVUE3b3JvRmhWQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8211c393-c9f6-44b4-0ac2-08de5a30c98c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 03:37:51.9046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uNeskZFFKuP2qraXgytvcDbrzQRojYia+pWYVL1DpYKiB6gchy6PocHYIigVFYGQgdB9BtTyphXPfbzVS/E6F1/4vCLIoA62xEcq+Loy2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC0624F2CA
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBldGVyIE1heWRlbGwgPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSB2ZmlvL21pZ3Jh
dGlvbjogRml4IHBhZ2Ugc2l6ZSBjYWxjdWxhdGlvbg0KPg0KPk9uIEZyaSwgMTYgSmFuIDIwMjYg
YXQgMDY6MDMsIFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+d3Jv
dGU6DQo+Pg0KPj4gQ292ZXJpdHkgZGV0ZWN0ZWQgYW4gaXNzdWUgb2YgbGVmdCBzaGlmdGluZyBp
bnQgYnkgbW9yZSB0aGFuIDMxIGJpdHMgbGVhZGluZw0KPj4gdG8gdW5kZWZpbmVkIGJlaGF2aW9y
Lg0KPj4NCj4+IEluIHByYWN0aWNlIGJjb250YWluZXItPmRpcnR5X3Bnc2l6ZXMgYWx3YXlzIGhh
dmUgc29tZSBjb21tb24gcGFnZSBzaXplcw0KPj4gd2hlbiBkaXJ0eSB0cmFja2luZyBpcyBzdXBw
b3J0ZWQuDQo+Pg0KPj4gUmVzb2x2ZXM6IENvdmVyaXR5IENJRCAxNjQ0MTg2DQo+PiBSZXNvbHZl
czogQ292ZXJpdHkgQ0lEIDE2NDQxODcNCj4+IFJlc29sdmVzOiBDb3Zlcml0eSBDSUQgMTY0NDE4
OA0KPj4gRml4ZXM6IDQ2Yzc2MzMxMTQxOSAoInZmaW8vbWlncmF0aW9uOiBBZGQgbWlncmF0aW9u
IGJsb2NrZXIgaWYgVk0gbWVtb3J5DQo+aXMgdG9vIGxhcmdlIHRvIGNhdXNlIHVubWFwX2JpdG1h
cCBmYWlsdXJlIikuDQo+PiBTdWdnZXN0ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVk
aGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBody92ZmlvL21pZ3JhdGlvbi5jIHwgMiArLQ0KPj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9ody92ZmlvL21pZ3JhdGlvbi5jIGIvaHcvdmZpby9taWdyYXRpb24uYw0KPj4g
aW5kZXggZjg1N2RjMjVlZC4uYjQ2OTUwMzBjNyAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vbWln
cmF0aW9uLmMNCj4+ICsrKyBiL2h3L3ZmaW8vbWlncmF0aW9uLmMNCj4+IEBAIC0xMTczLDcgKzEx
NzMsNyBAQCBzdGF0aWMgYm9vbA0KPnZmaW9fZGlydHlfdHJhY2tpbmdfZXhjZWVkX2xpbWl0KFZG
SU9EZXZpY2UgKnZiYXNlZGV2KQ0KPj4gICAgICAgKiBjYW4gYWxzbyBzd2l0Y2ggdG8gdXNlIElP
TU1VRkQgYmFja2VuZCBpZiB0aGVyZSBpcyBhIG5lZWQgdG8NCj5taWdyYXRlDQo+PiAgICAgICAq
IGxhcmdlIFZNLg0KPj4gICAgICAgKi8NCj4+IC0gICAgcGFnZV9zaXplID0gMSA8PCBjdHo2NChi
Y29udGFpbmVyLT5kaXJ0eV9wZ3NpemVzKTsNCj4+ICsgICAgcGFnZV9zaXplID0gMVVMTCA8PCBj
dHo2NChiY29udGFpbmVyLT5kaXJ0eV9wZ3NpemVzKTsNCj4+ICAgICAgbWF4X3NpemUgPSBiY29u
dGFpbmVyLT5tYXhfZGlydHlfYml0bWFwX3NpemUgKiBCSVRTX1BFUl9CWVRFICoNCj5wYWdlX3Np
emU7DQo+DQo+VGhpcyBkb2Vzbid0IHN0cmljdGx5IHNwZWFraW5nIHJlc29sdmUgQ0lEIDE2NDQx
ODYsIGJlY2F1c2UNCj53aGF0IENvdmVyaXR5IHNlZXMgaXMgdGhhdCBjdHo2NCgpIHJldHVybnMg
NjQgd2hlbiBkaXJ0eV9wZ3NpemVzDQo+aXMgemVyby4gVGhhdCBpcyBzdGlsbCBVQiBldmVuIHdp
dGggdGhlIFVMTCBzdWZmaXguDQoNCkhtbSwgbWF5YmUsIEkgZGlkbid0IGZpbmQgZWFzeSB3YXkg
dG8gdmVyaWZ5IGl0IHdpdGggQ292ZXJpdHkgdGVzdC4NCkluIGZhY3QsIHRoaXMgY29kZSBpcyBn
dWFyZGVkIGJ5IGJlbG93IGNoZWNrOg0KDQogICAgaWYgKCFiY29udGFpbmVyLT5kaXJ0eV9wYWdl
c19zdXBwb3J0ZWQpIHsNCiAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgIH0NCg0KSWYgdGhlIGNo
ZWNrIHBhc3MsIHdlIGFyZSBzdXJlIGRpcnR5X3Bnc2l6ZXMgaGFzIGhvc3QgcGFnZSBzaXplIGJp
dCBzZXQgYXQgbGVhc3Q6DQoNCiAgICBpZiAoY2FwX21pZy0+cGdzaXplX2JpdG1hcCAmIHFlbXVf
cmVhbF9ob3N0X3BhZ2Vfc2l6ZSgpKSB7DQogICAgICAgIGJjb250YWluZXItPmRpcnR5X3BhZ2Vz
X3N1cHBvcnRlZCA9IHRydWU7DQogICAgICAgIGJjb250YWluZXItPm1heF9kaXJ0eV9iaXRtYXBf
c2l6ZSA9IGNhcF9taWctPm1heF9kaXJ0eV9iaXRtYXBfc2l6ZTsNCiAgICAgICAgYmNvbnRhaW5l
ci0+ZGlydHlfcGdzaXplcyA9IGNhcF9taWctPnBnc2l6ZV9iaXRtYXA7DQogICAgfQ0KDQo+DQo+
QnV0IGlmIHdlIGFyZSBlbmZvcmNpbmcgc29tZXdoZXJlIHRoYXQgZGlydHlfcGdzaXplcyBpcw0K
Pm5ldmVyIHplcm8sIHRoZW4gdGhpcyBpcyBmaW5lIGFuZCB3ZSBjYW4gbWFyayB0aGF0IENvdmVy
aXR5DQo+aXNzdWUgYXMgYSBmYWxzZS1wb3NpdGl2ZS4NCg0KTWF5IEkgYXNrIGhvdyB0byBtYXJr
IGl0Pw0KTWF5YmUgQ292ZXJpdHkgdGVzdCBpcyBzbWFydCBlbm91Z2ggdG8gbm90IHJlcG9ydCBp
biB0aGlzIGNhc2Xwn5iKDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

