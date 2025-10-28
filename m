Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA03CCF9EC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 09:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgIX-000614-VF; Tue, 28 Oct 2025 05:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDgIV-00060h-EO
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:47:23 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDgIS-0005Zb-Ag
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761644841; x=1793180841;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+3dbXXdRw4wtho8PVRDyKN0Pxtl9M/l3nkoOvzTvWKY=;
 b=SZMTAfFMjn/PXVfsJetcp9U8uuoPHoyZc5gFunhFGvVDNPTGZEKbML5d
 X959rZthpBbVcBRpqLblNHR9jF3lNX2XUZJUeR03Gqqbe4iHz4G7ioQ7g
 s+SIhUx8ySjvSh0p59/T6BS7GJv6zB+TWspsbvKXOedzQvLWWkrsnJugs
 KKQaAowCDOW26u00b25KbDRSSaL5zR2WvULmeEeSleSV3+IpbDRfo+z+Y
 2RTdTuhVQVDUxUBEIn90xrs4aT06loXBT+5jbd1rkuj9l6vlSFDYtIi6c
 nRLldCWCvwQFfrwskVbIdQlm9yxW7H6MKuu456o00WYhoRu3Blz5HGKZE w==;
X-CSE-ConnectionGUID: TD7f1mt6Rb+rK+eA7zNpPA==
X-CSE-MsgGUID: ac+XPaW5QxO93Q8lI4UcRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63643734"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63643734"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 02:47:18 -0700
X-CSE-ConnectionGUID: vnoXZvYwTNqyIfAsHO+TKA==
X-CSE-MsgGUID: V5p59Nf4T7q7HWZ3z2KSoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="185388841"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 02:47:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 02:47:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 02:47:17 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 02:47:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSDHfNiKubrdc+13HOwh9aSi9OuddW5/fJax5qOScyu456eEShQ0VWjAdJpOXAoiZLsHkGplqiZqw3kjD66bYiG2uH+Lj+eODwfuIXy1rIokkzrmeK703jqYdjftgLXCvCbGFzW2Fx1duPnYWuiPj42mANhkfdPh9x+g2NyzYI9U8/w+P2bI0TjMoTEDLm6xL+oBuNknvH0wF9X+RBHJejnGrXCFtIZ406r7EXGkL+CxJhhIYrCNGrKvQ4t1D81SoxBNleQ5nqtV9Hg/6rUrKiHLTG+fH1mjpxoP4C4qUUmeJ7HH6pV8CM+t7FAkRrJOBkSVhbmEeWxb3qxRA1ChiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3dbXXdRw4wtho8PVRDyKN0Pxtl9M/l3nkoOvzTvWKY=;
 b=gkWlJUxd/q6JkC2PzrFJlnIriz6Gz7/asHkCUlbbfukezs50xrA23wvc+0zEezdXz7XTo9hdYHdjEMUFe66JO+TwKY6GBsF6tP+zXAalasjsGAPsk3sZFDW/yHaZkBTrCzZDz1fIRj/Ac5r7dlRHLkfejUNtMUyjsUQzFezBW+OPoj+Zr5T8NHUKBz+quBg9MzUxx/ytOo840y1sWWcaMB7X5uofjnBdZ95qK1mFdcd/MR63NB3SHGgTu4krzUpTjkyOGbXnxfDKYCpi4q82awPYTfKy/0UjOZ0munbqnLKonc4Tfolgy1CDl9OLae5M4e0pzOoqYmP7rpnV728q/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 09:47:09 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 09:47:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 20/23] vfio: Bypass readonly region for dirty tracking
Thread-Topic: [PATCH v7 20/23] vfio: Bypass readonly region for dirty tracking
Thread-Index: AQHcRMKimVkPfv3WFUCRrYMqW2yT17TRfh4AgAXXxVA=
Date: Tue, 28 Oct 2025 09:47:03 +0000
Message-ID: <IA3PR11MB91360484C88C428C29E7083C92FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-21-zhenzhong.duan@intel.com>
 <39faab3a-f65c-471e-a049-d60cc42725e0@redhat.com>
In-Reply-To: <39faab3a-f65c-471e-a049-d60cc42725e0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB8197:EE_
x-ms-office365-filtering-correlation-id: d2ef833d-19d4-4dd8-617b-08de1606f329
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dkErdDFkRWx1NG1BUWwzNjVDak0wQUt1czdXc2VtK2dRbi9zMFFCcTRadGpZ?=
 =?utf-8?B?MnRSNjU1eFJlV0doSjRzSUpYZ0xHOVJHVzdEdWZDRXdwcGYvTXNsa2svZi9D?=
 =?utf-8?B?OVZsTW9pNEc5SVVjTFdBVTk5WEhsVm5aTzE2STBsNFUwczJMV2RiemRZR09E?=
 =?utf-8?B?WTNTeFYyR3VGbWxTcEptTjBVUURyRXo4WjZhWGx1dTJYa2twVDVybnRtL2Nw?=
 =?utf-8?B?anhKRS9Bb1FxYVI3cHdjM2ZDWTRLZW9jK1lZd2lqbFpPSG1MOWJiTmp4MWNR?=
 =?utf-8?B?K2prWXBoalpZV25zS0lkK2xaYjhGM3F1MWRnRFlQcjIxMkhsNU9OYVVTUVVq?=
 =?utf-8?B?UUZaVjREUFY4bndpN29XeEN0SWpvUUpSMUVNcjBmTmV3ckxRSnlZWDdWVDBI?=
 =?utf-8?B?aXZhYXQrM0N6QmUzMllJL3hKcG0zZWN6cndLNFhkL3hXZFRZYXcvamdUclAw?=
 =?utf-8?B?NXpiNWNLS2VkYnJzNlJQT0l3YmhvVEFiMXVadjJiNFB6MGdSRzBpVHNoNVpQ?=
 =?utf-8?B?MjNLWkM2c3M0dFRDMkNCOEJKOXgzUlVqczlJUjFBNFF5eXc1am1TRDlVMlJS?=
 =?utf-8?B?eVk4N2hNTHk0WmQwdkViQW0vY3MvRXNzMWF4RDUwMVFkQWlBVmcremV0bjV2?=
 =?utf-8?B?UDdzV2hJSzFILy9qd0lDUXZZNlpIcnpXQnd2RzRJeVE1amlITmtFUk44a2Ez?=
 =?utf-8?B?Mm8vektXK1FSOXVZMDdXVm9wSWxQaXhSendTYXBEWnBWd0hOemlDNGwyQ3Zm?=
 =?utf-8?B?K2dmVnJ3NVR2c0FNVWFVMjdWOFIwME91WTduTzBEVWRuZk4wOElYaGltRVFk?=
 =?utf-8?B?dVA0eCtQRHY1aFdQMEtjQStmUm45OEEvbjhrUWlvY3hDZ1R0WnJ4MFF0OXJv?=
 =?utf-8?B?d0plMUIwUk40OUtOcFJSUm5ZMlNhc3FOMFJtNTY3WElMeGxGVTcyWjB1U1lH?=
 =?utf-8?B?cmVYbmxwdE1PZWo4STZUOG82R2xHU3U5ZGlTb1BXSUNCNGcrN2ppYkpuUXR6?=
 =?utf-8?B?ajF5aWNFcnhxWXR0azdPZjNVYXBLenVSb3FYYy9GWGNPK3RkUGZieitNNVo4?=
 =?utf-8?B?SzJKY0d1WWdiZldtOU9UZzBtczdTM2lLZ2psS2NJMnJJUVM5OW83elhwR1VR?=
 =?utf-8?B?bFZwRFdHSTlHSnJHR2Q1aXFQSktWNmdTdU9PVm5QUFVZWVQxcngyQnUzUEZY?=
 =?utf-8?B?aThVbHo4QlhqbUowWXdFRnpzdmQvNkcrVkFhTHh1V0lkWnVrQkRPRm5qWFgr?=
 =?utf-8?B?eGNLLzYvTUl3dkJCZWJ6YkJ4NFRIYlBDR0hMQmYrT2pzTElrOVMxZm5IcFdU?=
 =?utf-8?B?VHUweHI1eitYVzR3YVU2ZGtDb01DU1A4bDdQWUNnWmF3TlRiNTcxMmkzUk1l?=
 =?utf-8?B?cithK3haQzVtV3habVZma3pmZTJKK2V1Q2thaDJSTUo3RU01RThnc01DWUY5?=
 =?utf-8?B?SDQwMk4yTWpVVE4zNG5IM0p0SDBWUUZ1UVBrMndERlMxRk1KRXh3amJNaFAw?=
 =?utf-8?B?OHpacEdLMWJ5TUluVmxQbUlBM1NGWlc3Q0oyaTM5MlpKQ1NoRjFyWHJFWEhl?=
 =?utf-8?B?amFJS2lVRUMwcGFlWlM3NE01dmxXc2o4cUZLa3RuckJudndlTEN6MEptOUhj?=
 =?utf-8?B?dDlLM0dZbUxBSEwzVzEzUUZDamVOUVNlWDdKelo2cUM4UVdadW4zVy80dHpS?=
 =?utf-8?B?YWs5Y2VNTDZGT1BlamMyRDdzRERSVjBibTg3U2FMTTJJK3VLcE9Ia09ZVVhY?=
 =?utf-8?B?c1BhVFhQT3VaUHFmK3AwSGdsR2w2ZWYxenozZis2RWZKV0ozWVVtdWJGVmRZ?=
 =?utf-8?B?OFZOa1oxYlljdDZMd3NHUHFjbTd2bnczbUQzTjg3Ti96TkdFLzZVbzJid05G?=
 =?utf-8?B?YXpSaExTZHk1SU9pQkQvT3dpK25wNWl5azBYOU5CNkc3VHROWEJQY3plSFZ1?=
 =?utf-8?B?ekN5ZXgyNXpCSFE5YllQYllmcFJyR05YZ0ZMU3Nwd0RWd0Y5RlpkYko5N3Y2?=
 =?utf-8?B?dlA5bU5ObHhDRXB2Y09rWmJBelFad3VxYnJlZVVycGI3MTUrb0pROFl4YkE1?=
 =?utf-8?Q?qsKiA7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2JwN0ViRmhCZFJsRmpDNHpZUnFZWkVyUVc0OXZmVG5Ea2ZtU2pnZjMybjNK?=
 =?utf-8?B?Ylo5emExZmthSm5JZGpyT0JUU2d5S1psSHEwRDMwakNLVUJ5UFVtYXIyME03?=
 =?utf-8?B?MC83V3J5a3ArbEh0Q2RHNmhUanFIS2VDTkpzNkRoOVJSS2JBd0dxTzdTYUcz?=
 =?utf-8?B?ckpCSWxsNVJHSUI5Si8xTmFDc25xM2RlbjZQZ0FLWnl5ZXNHSk1mRFMyNUpJ?=
 =?utf-8?B?dndUQmJxNnJFY00yMEttdjlQY3dnekQ5dUZZZk1zMXdlUzUyYzViaWtKeitu?=
 =?utf-8?B?eUZ6VlpKMlNXWUFTY2xZRWFoQTNocFZQUTMxRUZBQ2M2a3ordXZNNVROeFF1?=
 =?utf-8?B?K1ZmZnZ5Nmd0bkRQVkpiVUpCZHRZOHl3VDducEhBWWpyelR6QUY5Rm1jeUJH?=
 =?utf-8?B?TkVvMjJydTZKTTFNOVVKM1R1WWEzUmtKREFmWXo1OXh3cUVRUzllYVYwMEMr?=
 =?utf-8?B?VXR5dmJFbGttekNKSzBGNnVIaFRsYTRCMDZOekdZVFpJNTFNVW9XL2FFWXcw?=
 =?utf-8?B?Rk4yZDBSNDhSbHM4S3pudWFzOTlLMlkzSFl0RnE2Um0xY3NPMk5RM0ljNm42?=
 =?utf-8?B?ZDk3Wmc4ZGV1d3pUWmROQS9uYThSZEZnckdQVStRZEpVMGdyeHNyTVQ1cm5o?=
 =?utf-8?B?Slc1R2RkODNuRi9sblA2RXI4TEpxOUdyVUxpV3RGOUJuNnpRSmlpTFp0QmFz?=
 =?utf-8?B?UmtUWWFpWTQ0NkZOck01WUlQNjVRdHcxQUFaWnVsWTAyZ1VnUXE3eCtyRFBJ?=
 =?utf-8?B?OCt3cS9FQ0lmZ2xFcDZ5QVBlUVgxRVR1c3ZYSG1Ha1JrbXczRisybkN5dGF1?=
 =?utf-8?B?Wk5IbE5xRGZFUzdpRE1wY2VxWEF1dzAyNjljdUFFSUloemZPTDZKL1ZyL1BQ?=
 =?utf-8?B?NE44U3hoUzBvMVdxN2YraFNJWXpqdUNmR1AwblRuTnFid0NJeWhmU0krQlhu?=
 =?utf-8?B?bkwxUzNva2JtSVJJcmlIZ0tLMHNPV2wyS2xUU0tvbVB0eklOclBqYTBnWitJ?=
 =?utf-8?B?bnRadzQ0TkFuZE5qRjBhekJ3UklXVko4bk1uV2VsMWhRMjBGZ1l4eGdlVWVo?=
 =?utf-8?B?Y1dhd3EzQWY4bWtxR1JvWHRRRWxScVNtVWxtZWs5a3N5OFhwVFJYYTh6Y1JZ?=
 =?utf-8?B?TWlwZmhWS1VnaU5QMW9nNDU3R2Joc3d2SUlnZ1E0Ymd4aC9nRDFrUVBkdWdi?=
 =?utf-8?B?TktiTmJubEtiKzhGYW1IUWtkZm1yQXYzZlpyQjVRWGxadU1Ld2JNWnB4dVNH?=
 =?utf-8?B?cHlEMGltRmxSSWE1TjVQUE9qcjhpbEVVOHFyOUYrSjF6anF1TmJneldmSWlX?=
 =?utf-8?B?QS9oWnFyallaM0lDbEtQbkxKTXppeXJldnRMTWFNQTNqTVp4dFB5T1dDeGVs?=
 =?utf-8?B?ZUJhcVcxSzN6YjBFNHY1RlZsOUs3eCtCejNmZmIvY3lKN1Jqd29XSzRIaS8z?=
 =?utf-8?B?a3J1OU52WEpjMnFiYkxLT0lWTHdlb1ZHR0hsc0psRFMxNlhLN2lRbzBwTG42?=
 =?utf-8?B?bW5CV3VmWUJZZXhoSWtvTEJZbHlOVjhPUmhJRHpIWnUrNkN5MVNBQ0RMQWlJ?=
 =?utf-8?B?R3hYZzhPQ1ZMT2JPbk5qMW9pMGJFS2xQYkdnME0rTUErNWQ1cTBIUkJQeVZ1?=
 =?utf-8?B?N1FDTklTZHJQb0Mra1Y5c2dEUmQ3ZlZ0WXY4dW1sU3J5TUs4dnd2bzlSdkRM?=
 =?utf-8?B?d0s5MlRSVWRsZ2t6SFBacnd6YmhFWjB2RWVXUGovMUQ3V01LMm1TVEl5Q1pW?=
 =?utf-8?B?d29VWjVRS1VCcXB5YTdja0lGOW5RNHlpTU0ydWhZTkNtaFZsNW5jNXJBSytu?=
 =?utf-8?B?L1RneTl2c09XZlZHeDA1a1FoRE5Ua2FHZ1NzTDF6YzI1M3VoNm85d3Mra04z?=
 =?utf-8?B?eVE2dDlzcm9Uc0tROEdqK3kvV0llcnE2VUxoRFhEU2tVRTFqUWRtOXRJSWp2?=
 =?utf-8?B?KzB4dUdBemJRZVlxa2luMjFoT2V4TmtCZG43RDlsUU1hVEQwNkxxSHVNMGZD?=
 =?utf-8?B?WTBvSEU4M0xJTTZwTVhtaXVscjhReFN1aWl2cUs3a0U0OURLOVhXbFBEUFBW?=
 =?utf-8?B?dldURzA4MnVPdkFtTzREVHpLY25LOXJGc2N5ZENLZGcvU0dtQldlY25YN0Q3?=
 =?utf-8?Q?TLPnPts0lz8eH4JrT2Z2/0H6W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ef833d-19d4-4dd8-617b-08de1606f329
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 09:47:03.8310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTgEhUV+Yh033kLZfrX9SfzoB16QbRIjQmqaX3iNthxabXhznhEUb0KlvPHuI15OnUjKc20x6kzWOmFrEAHGkTC5nGP5Kjv9X34Zyv75rvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDIwLzIzXSB2ZmlvOiBC
eXBhc3MgcmVhZG9ubHkgcmVnaW9uIGZvciBkaXJ0eSB0cmFja2luZw0KPg0KPk9uIDEwLzI0LzI1
IDEwOjQzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFdoZW4gZG9pbmcgZGl0cnkgdHJhY2tp
bmcgb3IgY2FsY3VsYXRpbmcgZGlydHkgdHJhY2tpbmcgcmFuZ2UsIHJlYWRvbmx5DQo+PiByZWdp
b25zIGNhbiBiZSBieXBhc3NlZCwgYmVjYXVzZSBjb3JyZXNwb25kaW5nIERNQSBtYXBwaW5ncyBh
cmUNCj5yZWFkb25seQ0KPj4gYW5kIG5ldmVyIGJlY29tZSBkaXJ0eS4NCj4+DQo+PiBUaGlzIGNh
biBvcHRpbWl6ZSBkaXJ0eSB0cmFja2luZyBhIGJpdCBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvdmZpby9saXN0ZW5lci5jIHwgMTEgKysrKysrKysrLS0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9saXN0ZW5lci5jIGIvaHcvdmZpby9saXN0ZW5lci5j
DQo+PiBpbmRleCAwODYyYjJiODM0Li5jYmQ4NmM3OWFmIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZp
by9saXN0ZW5lci5jDQo+PiArKysgYi9ody92ZmlvL2xpc3RlbmVyLmMNCj4+IEBAIC04MjgsNyAr
ODI4LDggQEAgc3RhdGljIHZvaWQNCj52ZmlvX2RpcnR5X3RyYWNraW5nX3VwZGF0ZShNZW1vcnlM
aXN0ZW5lciAqbGlzdGVuZXIsDQo+PiAgICAgICAgICAgY29udGFpbmVyX29mKGxpc3RlbmVyLCBW
RklPRGlydHlSYW5nZXNMaXN0ZW5lciwgbGlzdGVuZXIpOw0KPj4gICAgICAgaHdhZGRyIGlvdmEs
IGVuZDsNCj4+DQo+PiAtICAgIGlmICghdmZpb19saXN0ZW5lcl92YWxpZF9zZWN0aW9uKHNlY3Rp
b24sIGZhbHNlLCAidHJhY2tpbmdfdXBkYXRlIikgfHwNCj4+ICsgICAgLyogQnlwYXNzIHJlYWRv
bmx5IHNlY3Rpb24gYXMgaXQgbmV2ZXIgYmVjb21lIGRpcnR5ICovDQo+PiArICAgIGlmICghdmZp
b19saXN0ZW5lcl92YWxpZF9zZWN0aW9uKHNlY3Rpb24sIHRydWUsICJ0cmFja2luZ191cGRhdGUi
KSB8fA0KPj4gICAgICAgICAgICF2ZmlvX2dldF9zZWN0aW9uX2lvdmFfcmFuZ2UoZGlydHktPmJj
b250YWluZXIsIHNlY3Rpb24sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmaW92YSwgJmVuZCwgTlVMTCkpIHsNCj4+ICAgICAgICAgICByZXR1cm47DQo+PiBAQCAt
MTA4Nyw2ICsxMDg4LDEyIEBAIHN0YXRpYyB2b2lkDQo+dmZpb19pb21tdV9tYXBfZGlydHlfbm90
aWZ5KElPTU1VTm90aWZpZXIgKm4sIElPTU1VVExCRW50cnkgKmlvdGxiKQ0KPj4gICAgICAgaWYg
KCFtcikgew0KPj4gICAgICAgICAgIGdvdG8gb3V0X3VubG9jazsNCj4+ICAgICAgIH0NCj4+ICsN
Cj4+ICsgICAgaWYgKCEoaW90bGItPnBlcm0gJiBJT01NVV9XTykgfHwgbXItPnJlYWRvbmx5KSB7
DQo+DQo+DQo+SW4gY2FzZSB5b3UgcmVzZW5kLCBwbGVhc2UgYWRkIGEgdHJhY2UgZXZlbnQuDQoN
Ck9LLCB3aWxsIGFkZDoNCg0KICB0cmFjZV92ZmlvX2lvbW11X21hcF9kaXJ0eV9ub3RpZnlfc2tp
cF9ybyhpb3ZhLCBpb3ZhICsgaW90bGItPmFkZHJfbWFzayk7DQoNClRoYW5rcw0KWmhlbnpob25n
DQoNCj4NCj5Bbnlob3csDQo+DQo+UmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdA
cmVkaGF0LmNvbT4NCj4NCj5UaGFua3MsDQo+DQo+Qy4NCj4NCj4NCj4+ICsgICAgICAgIHJjdV9y
ZWFkX3VubG9jaygpOw0KPj4gKyAgICAgICAgcmV0dXJuOw0KPj4gKyAgICB9DQo+PiArDQo+PiAg
ICAgICB0cmFuc2xhdGVkX2FkZHIgPSBtZW1vcnlfcmVnaW9uX2dldF9yYW1fYWRkcihtcikgKyB4
bGF0Ow0KPj4NCj4+ICAgICAgIHJldCA9IHZmaW9fY29udGFpbmVyX3F1ZXJ5X2RpcnR5X2JpdG1h
cChiY29udGFpbmVyLCBpb3ZhLA0KPmlvdGxiLT5hZGRyX21hc2sgKyAxLA0KPj4gQEAgLTEyMjIs
NyArMTIyOSw3IEBAIHN0YXRpYyB2b2lkDQo+dmZpb19saXN0ZW5lcl9sb2dfc3luYyhNZW1vcnlM
aXN0ZW5lciAqbGlzdGVuZXIsDQo+PiAgICAgICBpbnQgcmV0Ow0KPj4gICAgICAgRXJyb3IgKmxv
Y2FsX2VyciA9IE5VTEw7DQo+Pg0KPj4gLSAgICBpZiAodmZpb19saXN0ZW5lcl9za2lwcGVkX3Nl
Y3Rpb24oc2VjdGlvbiwgZmFsc2UpKSB7DQo+PiArICAgIGlmICh2ZmlvX2xpc3RlbmVyX3NraXBw
ZWRfc2VjdGlvbihzZWN0aW9uLCB0cnVlKSkgew0KPj4gICAgICAgICAgIHJldHVybjsNCj4+ICAg
ICAgIH0NCj4+DQoNCg==

