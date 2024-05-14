Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D9AC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 07:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6mg8-0004JP-9T; Tue, 14 May 2024 03:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6mg0-0004J3-SO
 for qemu-devel@nongnu.org; Tue, 14 May 2024 03:34:22 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6mfx-0000Je-My
 for qemu-devel@nongnu.org; Tue, 14 May 2024 03:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715672058; x=1747208058;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=v6pb3X3N6lF4vFKCcTq+16LOL84c+Rrj22p6pjCwguM=;
 b=OCQelTR/ZfhIc+BaH8KjgSXVKjHDXXMhAAE4OxnzsAsjZyA0yFkGFKqB
 G/vQe9qHm4os52P78zYHTjSwc6hqIA5pSKm8Te7WUbGd+118CpcyMcPG1
 Y2ETXUv+XOQEQp41+0/VNlQqwjnVYMxFR5rgvgkHKhze/3PLLyJRYWrwD
 zAdkXElSMJI7VQ8iRRyLizJ+hQBlntxDYNtqTMlCPKmg0yC+Bb40ImxE/
 lcnZVktqx4tGf5pHg8FezFibG9I0h8LNL4BNpfpy4DOnFIvv+rQN0urat
 S6gkdUpbREZdPxGEd6/WoAx+n4Fc6ScMU/X5dDPyACJabIz0lvoEUml1q Q==;
X-CSE-ConnectionGUID: aMyvbd95TtuCsHZvWoRjcQ==
X-CSE-MsgGUID: 988xzB9aSFuAqthQ4ZFLow==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11494677"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11494677"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 00:34:15 -0700
X-CSE-ConnectionGUID: nVzUAgUoRZC8dJiSAcRemg==
X-CSE-MsgGUID: eCtTqMApTyuKwOnFJrtpYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="61426971"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 May 2024 00:34:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 00:34:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 00:34:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 00:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwGOIMbMwQqQULUVFrdesvBkaLCMbNoNpDpsXIsZvPsicDn/ecrB5ISM/HEVTPfsiOC3OqE+cHrGrJYxLwZ0KkTRee+ghSvymEL8F/3eaKgqqdgqfLrtbYxAUA7kjrLXw2yvAuqYlp7gx7AO1/Of2XRoT8JQjcVxGb8//qVQ5DgdHOFmTWoXYxWTzCkVVdzNz5BRroa/7uH5ka+k2an59wya/+5ECGdhVuAgHytcGATEwK5V/A0TnJu3U2rCeaV8D1DVxxwzmq0rSDNSTxbvfD0G6Naovx0QpZQ3jFYyKU13fbpD3PnhDY4GdNkNb0bFdEvgTBFFItabyBDT3olbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6pb3X3N6lF4vFKCcTq+16LOL84c+Rrj22p6pjCwguM=;
 b=bYUuxWYTUfT24nTrM7xI7yI3vJyu4WJNWfHwwGRnkq7v0+XE/5c65G+VBMCAbFSGf18M1OqVHLw/DFn+JiuRSP4G/8bFM4noB6UdIbI/iyALEEb8rhPtWavtMxDsmBH/cpUkgL5kN3nuGtSoNM6ypR/9VAVrPOSW8aIYn9UiMSwTLx/Ez3LYhR3+Iz4TUNggVk4gyB/mEbmaKCA1LX2l8r1Bb95aC+jOx92ip5Pczd1w4OD+Hxf+wcGVIECh/Dvi7MgYN6tg/oCfkUL7skFFOqR2sKezxuFc4jFFm3j+snN5SfHUDSt67/bLbb6FS956t+QeBxkFDCi0o547qdBolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 07:34:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 07:34:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH ats_vtd v1 03/24] intel_iommu: check if the input address
 is canonical
Thread-Topic: [PATCH ats_vtd v1 03/24] intel_iommu: check if the input address
 is canonical
Thread-Index: AQHanKWOQU2WFAm+Q0y7GUlKu/g4H7GWZVqQ
Date: Tue, 14 May 2024 07:34:10 +0000
Message-ID: <SJ0PR11MB67440FA8BFCC383E6606866B92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
 <20240502152810.187492-4-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-4-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6430:EE_
x-ms-office365-filtering-correlation-id: d7e5eece-5387-4eb3-ad21-08dc73e83f3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dzg4RDhiOC9KWFJDcXNzZEJPempCS1ozVitjbVZxU2p2NnZSS3N1SGFXWWdT?=
 =?utf-8?B?U0ZJdVNEYWhQOXRpSEFtUTY1RUorV1l3R3puek1BTG44RzVxSGo5dWE3QWdT?=
 =?utf-8?B?Y2VLbUhReE1yYzRCQ09EcFRoMEJXY0NZQyt0N25KTTAvR2NxcE1xd0F3OVNx?=
 =?utf-8?B?MWVxdDlFQyswV3J4MXVKVWM2MmthcGg3aHlOYlY0aU5uMFlPZWhYQmk0NHZk?=
 =?utf-8?B?SEI5MWxwRFJPay9pUWJJZkZSam1VdDJuZmw3MGxlVHdkelpiWWVwWFZlMXpE?=
 =?utf-8?B?RC9Ud0lrSVRXMkdWK0U5V0lIbUtZOGk0ekZIQ0dKUkRTejB2bVdQWXVVKzh4?=
 =?utf-8?B?QXI1bzhvK0RQOWx3U281UGdBV0wrQU1qQXZjNXozMmh4QUVIc2VQV1NGRXcy?=
 =?utf-8?B?MGk0OWpnK1VNaWZFaHdWeng1b3NQSGpHYmcrclNsMmpzdGVJV2daQzRwajBX?=
 =?utf-8?B?cXc3bTE5RFY1YzZ5Rm8yMHhERUNZN3pyZUFqc0NzaEFJNkN1Ylp2SkhDVVNP?=
 =?utf-8?B?R2s0THlDeEFNSHoxTm4xamNGTEZndDBXaTZqdmdqbFg1Y1ZNZDU5ZmgrNE9J?=
 =?utf-8?B?UnZpWkZYaDkwc1FMZGtIYTFLRGRhM0w0alFRUHBtTUR0bXFyMi9nYjk4Rk53?=
 =?utf-8?B?d3plQUJ2STFVMElFRmdjREU0ZnozTmxWVEM1T1MxcENLKzc5cVFhR3FqUG1L?=
 =?utf-8?B?cEZUZmtqU2o0NldTVTExWXNXLzVrSlN6cVRxRFZSQnliT2x0MHFwSGZHdUM4?=
 =?utf-8?B?TVdodFp2K1FTL1FEaHJZN0E5R0FvRUZVQUhxcVUvZnpCVzU3dlF3YjlGbENy?=
 =?utf-8?B?S3ZMNzZTODB1eUUwZ2FhR3RlcUJmdWZLcHZWR3lvS09BaU1iUlVrRUtIbFNt?=
 =?utf-8?B?L2JXbHNUMVJCQk9YMFd3bVJtNTJ3S25xOVFDWWFnKytFZzJNZEFERUw3U292?=
 =?utf-8?B?bGZIYjRpaXRpTVJIQjNDSXZkM0prL3I3Q1lRVHBxRC9UWUJySTNNOHlEeTV5?=
 =?utf-8?B?NmFUZWVLOGxXb3U0djdtbCt3eGw5NVRtRFAvY3BKMFRaSE90Ymc4ZkhtZFFa?=
 =?utf-8?B?WkYyZWhCOUp4bTlhdzFuRDRGREpIWjFnOHpJM25Oa1VMYkNJa1krMm51RXRh?=
 =?utf-8?B?TDNMVHB6amliSUd5d3NVNWVIT0JiejZxKzFYYi9pa0xOMlJBRnY2cGIxajgz?=
 =?utf-8?B?MVRvVTM0RFpyYjRERWRyVnJicE52amNLT2lzUi8rMHd4MGhmUmtlNUV6bWU1?=
 =?utf-8?B?UStPTzlqeHRxak54U0VzSnlrRU1hN3JrV1JBL2tQQzVRRFVCbVBjaVJyRGww?=
 =?utf-8?B?TU5sYnA3eUVKUnlFOU1Dc2NHK0MvZ2JYSit2Uk1XemFLY0pWRUJLRit5T284?=
 =?utf-8?B?T3QySjd4SCtBZ0JHeXp0SkNnM3V4L0JEYXExdXVlNnl2SlRqQ3pTTUZNSndO?=
 =?utf-8?B?YWtmL2JXWjZWZUp2VXpuejJCNnk2N1JQaUpwQm5XV24xc3lWVG5OaHpCOFVG?=
 =?utf-8?B?Q295ekhXUVhHaE1tSVd5MnlxTlZFV09tNHZ5aEFpejBVMXh4d2lVS1dZNkda?=
 =?utf-8?B?UWw2NnM1MmFyaU1UVmpFMmtNWjNIaXJqRkdrMzl5OHlNZC83NDY4ODRUd0hP?=
 =?utf-8?B?Mkx0Mlh0ZUVNMUU4OFovSWRxbW5paGVzTGlaV2xUN251V1I0WktJMGpJQzhr?=
 =?utf-8?B?akp1eW9pUVRLVVJwZGt4MnNlekE0ekZCOVpNUlFFZmtkYXlwOFRzYTdjWlVK?=
 =?utf-8?B?dlVHRlVvSG1GMnV3dUsvQ0xGb0t2MXZ6allQdGR0d0JackdxQnBmYUdBd1Jt?=
 =?utf-8?B?aUpCWmZkaVB3Nm1zNDhmQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUNkWmlWSWZtRDlua25zQlVKZUY2dDVla1JLM3dtRWZJOEFMSzBUMS9wUFMx?=
 =?utf-8?B?elI4ckRhUzFDSUJXS2Y0NVM0QVo5eFhkWFNOZEJ5dFNOckR2Vm5qNUZoRDVP?=
 =?utf-8?B?WW1iaUlFQlVKRU11YmJiQUZ5SXlXYWZGQXBHcWw1QndxM2U0bGNnbEN1TkVZ?=
 =?utf-8?B?TFlCZHBiZElQSmRCOUJrR0xXS3FlbHRiY3piSThDQjFrNnJ1RW50WnFMUyth?=
 =?utf-8?B?emw4V2IzUmk5N2pnc2hQNForOGJ0STJGdm42VVJNaS96UWQ0MW9HQjY1WFRn?=
 =?utf-8?B?NkxiU3llVW01STIyUzg2WUFzWXBpTjFLL2Y1QnZaV1JaMldMOU5NK3BXWEh5?=
 =?utf-8?B?bzR5QTNUNEpMQUN0VGQ5WXhocWFGUWpRNkdEc0JEMW92NHJ6cms1RG91MTdW?=
 =?utf-8?B?RUxwblRjOG5hdVZPSG9jdjFuNWdRazkrWk9KUGhUS1JLWjZNUzFXS245TVNP?=
 =?utf-8?B?UXRNNWoyMC9Ld2FlYUdFYTdpZ2N4TFVGVXVLelZTdUR3Y01SeGNwN00yUmhE?=
 =?utf-8?B?TnJ0RTBxeVdVZDdGQzkwMmIwd2RYUGV2UWdVb1RDRmFoRHEyK0RvYk5pTHpO?=
 =?utf-8?B?SDI2Z1orOHhCK3lva2J4dGlabDQ5UGg2WjREMDlmWEZYaTR5aDBpaGpERWZo?=
 =?utf-8?B?YThSZHJ3UDlSenBXUVJRZVJzOVVjWTJNWGduMWlSSjk0VXdOY2ZraEpWL1hx?=
 =?utf-8?B?SDNYdWhubDFkdGJ0UjhvVWRQTlZVTWdGQ3p5YTRWa2twcU45ZGE5REtzSDEw?=
 =?utf-8?B?LzJZWVVrU3pWMUx6cDl0SnpRVlFQSHBaQlNPcHFqa1VCdzdldlpzVmpyWFRm?=
 =?utf-8?B?Qm1DUm5vYW5jVFJWbDJEUG80TWxyblpHUFl3SitaOEFIQW81b3J3OE5weEtQ?=
 =?utf-8?B?UXNReW9SOUZra09YTzFWRmgxU29scTBFSDVIWWw2VG9LUlVXZXhjaXpDNXpM?=
 =?utf-8?B?WSsvaEhXWUR5ZGdReG9rMlo1NHZPaGV5VFdMRHAybHA3V1BXQkg0NEIxVXpl?=
 =?utf-8?B?UmpZcUNYSmJ6SjJhWndiTmozeWpZeDVqN1lnMm1OQkFFQVVsWFVVSy9MbGJZ?=
 =?utf-8?B?Ly9RUXVOWTVlM1VlU0ZmRVV0eFI1WWNuaDRZM2tNeTNERi9PQTNoN2szcXBS?=
 =?utf-8?B?dkRVYVVMVTdTcFhxcEVTUTM1RmovQ1VlbXdvRXYwNExtOVRja29heUJaTyt3?=
 =?utf-8?B?YXA2U09Ud0hVeUpLUkozZjVMb09aTWlKbmpFSFlFSmZtOWZ3OFNHVDN6amwy?=
 =?utf-8?B?bllwZ1BTRG5CLzVEdGJBZ1dSTW5MK0h3anplVml6U3FwSlJWaENibDdqR0xG?=
 =?utf-8?B?TVFNSjZDd2hkVmltZFJCWmI4YmpsMGRnVUdzaVpCRTBTVEMvTDNBT2NldzNP?=
 =?utf-8?B?cUs1TWFtVnNMUVAxTVRYN0Jqcit3d0FDS1oyb0Z4RGthRDV0N2xGc0dWanM5?=
 =?utf-8?B?M052aTB6aG50SUFXYUlBa0hmbFQ1YUd2RmtPdWNhc1BnMzMyVWNCWEZZR2k1?=
 =?utf-8?B?SGhzOEZ1b1JhZG4wZmpWanR2NC9WaTZzeXFaNVlFMGxMYmJjeWJqTWx2UUMy?=
 =?utf-8?B?anpxOTQ3dUtUKzlod3lQSndnSElibnVod0lQRUFJNHhFaDY5Zmh5aXV3MmI3?=
 =?utf-8?B?MnhjN24xNGEzeUkxQ3R6OXZ2dVNUVnBzUXFibDE2Z2pyTFR6bkczMWNCVGJS?=
 =?utf-8?B?S2tCc1RPdERmeFgyOThMZlhudlFDOW5yNjc3QU4xc2YvRUZPY1psUk9ZTnRp?=
 =?utf-8?B?emxkYlNhL1dGSFRySW8wVTFGUFRYUlQyZDc0Z3Z2bkNvWHB5aTZQZFR1Zmg3?=
 =?utf-8?B?UTB6TFMrcWgwNUpTWnVkL1REOFVWOG9Lak5YRFdRTEFYaGg0K002dldZY3du?=
 =?utf-8?B?Z2p1bU1vcmRLMXcrdUYwOTBlY3VUazhRM2N4VTZoV2VFbU40aWQxSEp2SkIw?=
 =?utf-8?B?MW4vWmh2b2JUZUYwamtvcnozVWpJNVVvS2NXZ09vNVFnL2JMUFFDbEpaS24x?=
 =?utf-8?B?RDFUQjVjcnJmRHFwY0l1S2FTdFAwVW1wTkpxaFg4VWhGQS9ZdTEwcFhHbGJq?=
 =?utf-8?B?cDlvTDk5SWk4azkzb1IrMWprelRkcVdCYmc5YXZYbWkxRmFJMDJUaTRQd21k?=
 =?utf-8?Q?EPa+GXEBT9cF9LoqzbAamoyVZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e5eece-5387-4eb3-ad21-08dc73e83f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 07:34:10.9884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iY8gM8p9Dpz9fu4y1zdCYYJJKkBofaXVlLf4fvJrTdLoJOEQfkbulYVf26hRTN2IVDhXMx/hbjDkwM17dx0qewPiexLypb1E0rz7RlRsk20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj5TdWJq
ZWN0OiBbUEFUQ0ggYXRzX3Z0ZCB2MSAwMy8yNF0gaW50ZWxfaW9tbXU6IGNoZWNrIGlmIHRoZSBp
bnB1dCBhZGRyZXNzDQo+aXMgY2Fub25pY2FsDQo+DQo+Rmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24g
bXVzdCBmYWlsIGlmIHRoZSBhZGRyZXNzIHRvIHRyYW5zbGF0ZSBpcw0KPm5vdCBjYW5vbmljYWwu
DQo+DQo+U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRo
aWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+LS0tDQo+IGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAg
ICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCj4gaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oIHwgIDIgKysNCj4gMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+
DQo+ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPmluZGV4IDgwY2RmMzc4NzAuLjI0MGVjYjhmNzIgMTAwNjQ0DQo+LS0tIGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQo+KysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+QEAgLTE5MTIs
NiArMTkxMiw3IEBAIHN0YXRpYyBjb25zdCBib29sIHZ0ZF9xdWFsaWZpZWRfZmF1bHRzW10gPSB7
DQo+ICAgICBbVlREX0ZSX1BBU0lEX0VOVFJZX1BdID0gdHJ1ZSwNCj4gICAgIFtWVERfRlJfUEFT
SURfVEFCTEVfRU5UUllfSU5WXSA9IHRydWUsDQo+ICAgICBbVlREX0ZSX1NNX0lOVEVSUlVQVF9B
RERSXSA9IHRydWUsDQo+KyAgICBbVlREX0ZSX0ZTX05PTl9DQU5PTklDQUxdID0gdHJ1ZSwNCj4g
ICAgIFtWVERfRlJfTUFYXSA9IGZhbHNlLA0KPiB9Ow0KPg0KPkBAIC0yMDIzLDYgKzIwMjQsMjEg
QEAgc3RhdGljIGlubGluZSB1aW50NjRfdA0KPnZ0ZF9nZXRfZmxwdGVfYWRkcih1aW50NjRfdCBm
bHB0ZSwgdWludDhfdCBhdykNCj4gICAgIHJldHVybiBmbHB0ZSAmIFZURF9GTF9QVF9CQVNFX0FE
RFJfTUFTSyhhdyk7DQo+IH0NCj4NCj4rLyogUmV0dXJuIHRydWUgaWYgSU9WQSBpcyBjYW5vbmlj
YWwsIG90aGVyd2lzZSBmYWxzZS4gKi8NCj4rc3RhdGljIGJvb2wgdnRkX2lvdmFfZmxfY2hlY2tf
Y2Fub25pY2FsKEludGVsSU9NTVVTdGF0ZSAqcywNCj4rICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQ2NF90IGlvdmEsIFZURENvbnRleHRFbnRyeSAqY2UsDQo+KyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50OF90IGF3LCB1aW50MzJf
dCBwYXNpZCkNCj4rew0KPisgICAgdWludDY0X3QgaW92YV9saW1pdCA9IHZ0ZF9pb3ZhX2xpbWl0
KHMsIGNlLCBhdywgcGFzaWQpOw0KDQpBY2NvcmRpbmcgdG8gc3BlYzoNCg0KIklucHV0LWFkZHJl
c3MgaW4gdGhlIHJlcXVlc3Qgc3ViamVjdGVkIHRvIGZpcnN0LXN0YWdlIHRyYW5zbGF0aW9uIGlz
IG5vdA0KY2Fub25pY2FsIChpLmUuLCBhZGRyZXNzIGJpdHMgNjM6TiBhcmUgbm90IHNhbWUgdmFs
dWUgYXMgYWRkcmVzcyBiaXRzIFtOLQ0KMV0sIHdoZXJlIE4gaXMgNDggYml0cyB3aXRoIDQtbGV2
ZWwgcGFnaW5nIGFuZCA1NyBiaXRzIHdpdGggNS1sZXZlbCBwYWdpbmcpLiINCg0KU28gaXQgbG9v
a3Mgbm90IGNvcnJlY3QgdG8gdXNlIGF3IGZpbGVkIGluIHBhc2lkIGVudHJ5IHRvIGNhbGN1bGF0
ZSBpb3ZhX2xpbWl0Lg0KQXcgY2FuIGJlIGEgdmFsdWUgY29uZmlndXJlZCBieSBndWVzdCBhbmQg
aXQncyB1c2VkIGZvciBzdGFnZS0yIHRhYmxlLiBTZWUgc3BlYzoNCg0KIiBUaGlzIGZpZWxkIGlz
IHRyZWF0ZWQgYXMgUmVzZXJ2ZWQoMCkgZm9yIGltcGxlbWVudGF0aW9ucyBub3Qgc3VwcG9ydGlu
ZyBTZWNvbmQtc3RhZ2UNClRyYW5zbGF0aW9uIChTU1RTPTAgaW4gdGhlIEV4dGVuZGVkIENhcGFi
aWxpdHkgUmVnaXN0ZXIpLg0KVGhpcyBmaWVsZCBpbmRpY2F0ZXMgdGhlIGFkanVzdGVkIGd1ZXN0
LWFkZHJlc3Mtd2lkdGggKEFHQVcpIHRvIGJlIHVzZWQgYnkgaGFyZHdhcmUNCmZvciBzZWNvbmQt
c3RhZ2UgdHJhbnNsYXRpb24gdGhyb3VnaCBwYWdpbmcgc3RydWN0dXJlcyByZWZlcmVuY2VkIHRo
cm91Z2ggdGhlDQpTU1BUUFRSIGZpZWxkLg0K4oCiIFRoZSBmb2xsb3dpbmcgZW5jb2RpbmdzIGFy
ZSBkZWZpbmVkIGZvciB0aGlzIGZpZWxkOg0K4oCiIDAwMWI6IDM5LWJpdCBBR0FXICgzLWxldmVs
IHBhZ2UgdGFibGUpDQrigKIgMDEwYjogNDgtYml0IEFHQVcgKDQtbGV2ZWwgcGFnZSB0YWJsZSkN
CuKAoiAwMTFiOiA1Ny1iaXQgQUdBVyAoNS1sZXZlbCBwYWdlIHRhYmxlKQ0K4oCiIDAwMGIsMTAw
Yi0xMTFiOiBSZXNlcnZlZA0KV2hlbiBub3QgdHJlYXRlZCBhcyBSZXNlcnZlZCgwKSwgaGFyZHdh
cmUgaWdub3JlcyB0aGlzIGZpZWxkIGZvciBmaXJzdC1zdGFnZS1vbmx5DQooUEdUVD0wMDFiKSBh
bmQgcGFzcy10aHJvdWdoIChQR1RUPTEwMGIpIHRyYW5zbGF0aW9ucy4iDQoNClRoYW5rcw0KWmhl
bnpob25nDQoNCg0KPisgICAgdWludDY0X3QgdXBwZXJfYml0c19tYXNrID0gfihpb3ZhX2xpbWl0
IC0gMSk7DQo+KyAgICB1aW50NjRfdCB1cHBlcl9iaXRzID0gaW92YSAmIHVwcGVyX2JpdHNfbWFz
azsNCj4rICAgIGJvb2wgbXNiID0gKChpb3ZhICYgKGlvdmFfbGltaXQgPj4gMSkpICE9IDApOw0K
PisgICAgcmV0dXJuICEoDQo+KyAgICAgICAgICAgICAoIW1zYiAmJiAodXBwZXJfYml0cyAhPSAw
KSkgfHwNCj4rICAgICAgICAgICAgIChtc2IgJiYgKHVwcGVyX2JpdHMgIT0gdXBwZXJfYml0c19t
YXNrKSkNCj4rICAgICAgICAgICAgKTsNCj4rfQ0KPisNCj4gLyoNCj4gICogR2l2ZW4gdGhlIEBp
b3ZhLCBnZXQgcmVsZXZhbnQgQGZscHRlcC4gQGZscHRlX2xldmVsIHdpbGwgYmUgdGhlIGxhc3Qg
bGV2ZWwNCj4gICogb2YgdGhlIHRyYW5zbGF0aW9uLCBjYW4gYmUgdXNlZCBmb3IgZGVjaWRpbmcg
dGhlIHNpemUgb2YgbGFyZ2UgcGFnZS4NCj5AQCAtMjAzOCw2ICsyMDU0LDEyIEBAIHN0YXRpYyBp
bnQgdnRkX2lvdmFfdG9fZmxwdGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPlZURENvbnRleHRFbnRy
eSAqY2UsDQo+ICAgICB1aW50MzJfdCBvZmZzZXQ7DQo+ICAgICB1aW50NjRfdCBmbHB0ZTsNCj4N
Cj4rICAgIGlmICghdnRkX2lvdmFfZmxfY2hlY2tfY2Fub25pY2FsKHMsIGlvdmEsIGNlLCBhd19i
aXRzLCBwYXNpZCkpIHsNCj4rICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGRldGVjdGVk
IG5vbiBjYW5vbmljYWwgSU9WQSAoaW92YT0weCUiDQo+UFJJeDY0ICIsIg0KPisgICAgICAgICAg
ICAgICAgICAgICAgICAgICJwYXNpZD0weCUiIFBSSXgzMiAiKSIsIF9fZnVuY19fLCBpb3ZhLCBw
YXNpZCk7DQo+KyAgICAgICAgcmV0dXJuIC1WVERfRlJfRlNfTk9OX0NBTk9OSUNBTDsNCj4rICAg
IH0NCj4rDQo+ICAgICB3aGlsZSAodHJ1ZSkgew0KPiAgICAgICAgIG9mZnNldCA9IHZ0ZF9pb3Zh
X2ZsX2xldmVsX29mZnNldChpb3ZhLCBsZXZlbCk7DQo+ICAgICAgICAgZmxwdGUgPSB2dGRfZ2V0
X2ZscHRlKGFkZHIsIG9mZnNldCk7DQo+ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KPmIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+aW5kZXggOTAx
NjkxYWZiOS4uZTk0NDgyOTFhNCAxMDA2NDQNCj4tLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmgNCj4rKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj5AQCAtMzI0
LDYgKzMyNCw4IEBAIHR5cGVkZWYgZW51bSBWVERGYXVsdFJlYXNvbiB7DQo+ICAgICBWVERfRlJf
UEFTSURfRU5UUllfUCA9IDB4NTksIC8qIFRoZSBQcmVzZW50KFApIGZpZWxkIG9mIHBhc2lkdC1l
bnRyeSBpcw0KPjAgKi8NCj4gICAgIFZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlYgPSAweDVi
LCAgLypJbnZhbGlkIFBBU0lEIHRhYmxlIGVudHJ5ICovDQo+DQo+KyAgICBWVERfRlJfRlNfTk9O
X0NBTk9OSUNBTCA9IDB4ODAsIC8qIFNORy4xIDogQWRkcmVzcyBmb3IgRlMgbm90DQo+Y2Fub25p
Y2FsLiovDQo+Kw0KPiAgICAgLyogT3V0cHV0IGFkZHJlc3MgaW4gdGhlIGludGVycnVwdCBhZGRy
ZXNzIHJhbmdlIGZvciBzY2FsYWJsZSBtb2RlICovDQo+ICAgICBWVERfRlJfU01fSU5URVJSVVBU
X0FERFIgPSAweDg3LA0KPiAgICAgVlREX0ZSX01BWCwgICAgICAgICAgICAgICAgIC8qIEd1YXJk
ICovDQo+LS0NCj4yLjQ0LjANCg==

