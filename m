Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4C9D111A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 02:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOohR-0002Y4-UF; Thu, 27 Nov 2025 21:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vOohP-0002Xl-2q
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 21:59:07 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vOohM-00065r-1u
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 21:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764298744; x=1795834744;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IIh2XQuc4YQy+g04XLkrwjvBQQGmkTN+AVXmgv9dkvk=;
 b=g7VKlR9xmh0PtvY9ynA5EsBxk+IVxPzGAe1KPjL7PTGxhPe+aAZOVHgG
 NUVlQLUgOH+tm7o1MLQpUgNfJJ+y9Px9JYySesVPckVKWiHOmhIU393jh
 sabNtbRr1Xk723TXLvNAVtguuXJIv/Agjsgu0cIHCimHcJKfRqfcFvSTI
 fghTI0TupaHqObRxrrM9L2j1q1qlln0wpMABjPUavAmTyJZELqG6UUg/Y
 4NwN1xExF6tUJvDFpjrsC7fw661EYVyD/4zcyLZqhKwUXtDgnoWd8jBva
 sARRjj9cbRyL5va+M8hz3zhL2rfbU8kap5fwhuvp6/nogvM4OwZO7y7Yf A==;
X-CSE-ConnectionGUID: YFhAhFQfSjGYsr6L0dXvPA==
X-CSE-MsgGUID: ALfHIvO5RHu1U+p1hMQcZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66499909"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; d="scan'208";a="66499909"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 18:59:00 -0800
X-CSE-ConnectionGUID: v0URX6M9TnGbjrcocXCDCg==
X-CSE-MsgGUID: 9YA1ziUTSzu2ihAUE3TXHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; d="scan'208";a="193454751"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 18:59:00 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 18:58:59 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 18:58:59 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 18:58:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quxXSPoHQ+R/pcWPNiiSauEyx2RY2BMNw7UTlz1gMHGYS5ZJnageB7e8mBBOh2FWqumgiLwD5RSebchSH2mrh+x3CNfSc0u1qtjoq84/oFz8GxwENhZMeQrs9/JjkfPmqIBpEpsDdEXACGmQLxjH1+QgtFRnP3dgIffM6KbPvq0pBTEFGaQXy/4JOB8jpuJTiiL3dZesYNsPRZQiyKLXNpeQlpXqTtMzbcmLIIA6OxcIf88J4Ma6D6Q7cfJgIA7Hxv6+XgBJFJESOmI4F7C+MhvS2ZbPoMVNWrkU+UXSHc1G3mUTRb5RxAep6MHS+Vh/6xtzaPny2n3Wlbs/BAOF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIh2XQuc4YQy+g04XLkrwjvBQQGmkTN+AVXmgv9dkvk=;
 b=wigjTVaOS5uX0oSaS0uwwcJcTnZUMT8k29FbXGNBDJrG0qnMy9v/U3rc5p+nFtxXBvp3FE6D+Sjn2HBlTL1wbV+7qOZIROcUOBoehXrH8FiNzF5+AwXfT579XdStbAEmuMl7Pd6KWLbupIfWQyRdjzKHUCNA2Fm3QiLYEPFR+axc+vm+gtL5bNGfmjckDltaAW+VyIHz5yJIw3al/nmOi9i5lKKeJzaj3yEuvI5dzyeTXsaMH3jeBbJbklC7Zzg9VW4DXXtXKZgnXVrY1pzkiY2aB0bUpb0CZRsTeosYLBSU2yU7r5PVcicgrPC0NTbl6iF3q+NHczGjtyLEYpSFNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by DS0PR11MB6520.namprd11.prod.outlook.com
 (2603:10b6:8:d0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 02:58:57 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::687c:dd58:c4ca:ecfd]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::687c:dd58:c4ca:ecfd%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:58:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, Rohith S R <rohith.s.r@intel.com>, "Gross,
 Mark" <mark.gross@intel.com>, "Van De Ven, Arjan"
 <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v5 7/9] vfio/listener: Construct iotlb entry when unmap
 memory address space
Thread-Topic: [PATCH v5 7/9] vfio/listener: Construct iotlb entry when unmap
 memory address space
Thread-Index: AQHcTtTPa4rii8pJDkCpIA0xaO+Q3bUDSA8AgAEfrmCAAjyAAIAA3SYw
Date: Fri, 28 Nov 2025 02:58:57 +0000
Message-ID: <DS4PPF93A1BBECDF20A3895E794EE25479E92DCA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
 <20251106042027.856594-8-zhenzhong.duan@intel.com>
 <6db6365a-225d-4fbb-ac20-d10c424d364b@intel.com>
 <IA3PR11MB9136CF89E7C99375F85E211892DEA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <d18b8cac-cf09-40d0-bb50-b36eda0b4900@intel.com>
In-Reply-To: <d18b8cac-cf09-40d0-bb50-b36eda0b4900@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|DS0PR11MB6520:EE_
x-ms-office365-filtering-correlation-id: 988bdfcc-583c-45c8-e0e3-08de2e2a12e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NkwwUWYvc21TRFN3MVRXOXYxVHA3VWRkdVZVNXZwT09VcWtHVWdRUW1zbDhI?=
 =?utf-8?B?eGVPdWRDSUkzSUpXTnkxNUIwUSt6ZEJSbElsM0wxRFFjVXBGenNycjkySGV1?=
 =?utf-8?B?Z2NGVWhsODI2T0lLd3dvSUh6Uld6TGJySk5BR1hjRHF4UjlHZEE3clViM09Y?=
 =?utf-8?B?RmpEdHhjQjJDaGJpbnhlN0JtdnBjRlVQbnVUd3VKck1qbkZIUE5yVW9jVjZj?=
 =?utf-8?B?cDZuRG92d0ZrWlc1cVptMFBoS0tCYlF1TFNYOEVPbmZLOWphM0dORWtoWU4w?=
 =?utf-8?B?VUNSYy9Nai85c3N4Q3lBWHkya2FPZUw3WXg1WUhiWWJjY0hiSXFiMHlhaHBJ?=
 =?utf-8?B?eWhrODRiTDI4bWh2T1NJVzF1c2tQV20vSmFwOWNlM1RWRm1KZVA3RXdjb3Vi?=
 =?utf-8?B?b1hRRGdWYjRWVy91VHB5SFhUNGVvNzdoVTRFK1V4NTZOU2MxSFAxdnRZMWhq?=
 =?utf-8?B?QmhjR0Q2MW5lL3Jsd2F0YWg0NlhxeFdjOXhMeks2U0hoaEJ5SjdJallZSFhj?=
 =?utf-8?B?OVN1b1hQeVlrQklCNmJobzNkUnVmelo4N1hDUXJPQWk1U1psVDlEL1VpK2Uw?=
 =?utf-8?B?NHFxcXVtMWgxQzFkYmpJVVhvcE9LS2MzcE1tUFJKdTVvVU1CRnJFUHlqSEYx?=
 =?utf-8?B?c0dwWVhLRGZYMVpKeS83NXJEVkV5bHpnRk5sb08rYmdabDhYQWZENC9EQWhk?=
 =?utf-8?B?VnhCdncrUWpNWnBSby80UnZiek8yZnpRaWM1NU5wL3B2Y0o3dXg1bVhtdmd5?=
 =?utf-8?B?dE1VQkVyTng4RlNPNWxpN1B3YytRdFpRVXpoZXdvYkNmbmlzbml6ME9vSk5S?=
 =?utf-8?B?bVVZU29MOE1FMmFJblJHaG5tRXFaSy9jL2FGY0J2RjJ1RU9xOXhJVWl4MjQz?=
 =?utf-8?B?cXlZblN6Ui9hUDF5eVZLczFXaDFLWUJyUnVMT0ZxYVlYT2ZpbVNXSlVZS09m?=
 =?utf-8?B?NThEcXNjNVY5b050UUNTUU16K2FoWXhwSDZ5WTFZZW5qdUhwdjlxdW9VMXgz?=
 =?utf-8?B?MDNERHJUNWIwdVhwUFRFb2czd3J5dW5QRnV5N0RiUDcrWEFvOHNvWnpseUc1?=
 =?utf-8?B?TGtjazhGMXptZDNsZ0xnK0Y3SXdLUUdHYmwzWkw2d1BkeDI0cE5PRlQvZExL?=
 =?utf-8?B?T1hBM1VNZkxaVjVWakhKWjlxaEd2UzQrVDJJelR1WGFycnlBcDRQdjdpVlh3?=
 =?utf-8?B?Mm4vc3ZROEpFNXlxRG8xd3AzY2NJM0dLQnlQdnhrWVliaHZ4TkVXV1A0MHpk?=
 =?utf-8?B?dzRLSG9qOVRPbXg2bkZJd2phS2J1MTBnZGkyNENqQW9YNVV1eTJWRmlBd2di?=
 =?utf-8?B?S1dQSk5VdW1uRmtQY0VidVd3RGI4U2piMGhkUm5rcUJsWXlEY1JaSHVZSWlz?=
 =?utf-8?B?VEd2bWtKTzNtd21vMGlWZFRHY2JJT1FINDJlUGFzbkhxSXpOaUxURFVnaE15?=
 =?utf-8?B?Tm5xbjVTWjdFTHJMVm9Hd3gzbVBrcHdOUUJiVGsvT0o2aXZVN2pPWU4yeHVC?=
 =?utf-8?B?dEJLY240Q0VzZURFa1ZyRlA3Tm9mM3RkbC92M0VreDZ4WXpQaGhrWG1nTXNz?=
 =?utf-8?B?enNLWU4zMlVVOUZKYW04YnNNcW1QZ05vV3FxcHd4R3ZFeXkzb0UxQUpGa3Uz?=
 =?utf-8?B?SjRNNVplVGh1ZHliR0x6Yy9rVEh2R0IvaTZjTFpydmJtaDVyakk2T1BpMGNQ?=
 =?utf-8?B?SVp3bUpvTTg3aDA5S3pyZGNKVW1uK3cxdjczWDV1MnduSmk4TEJRVDdnU3BC?=
 =?utf-8?B?S25JMllPN1VSN3hiWWJnak9vTE5kbTk2V3VBdVVMMmxsclNHM0RCR0RmWlM1?=
 =?utf-8?B?cEpaOWNEK3lFWnZLRmJKRldJV2pOcTJaZXdCdU9lSmpVeWdSMlRNOEFSaTFY?=
 =?utf-8?B?VXJGbWQ5RXY4QXBjQkp1bFJVb0Y0cWVudzNIQWVaQ043aEFMQ0FmZHBCMlZJ?=
 =?utf-8?B?OXhaajd1VkVIWXcva3VUQlZnUFJHZmpWc251c3hjdkNrTldpdFVsK1JENkFy?=
 =?utf-8?B?eXZKYk9lQXZGalBkd1ZQNEszOU8wMWt1R3JRbDdybmlpSnp2VTBoVU5ZejhM?=
 =?utf-8?Q?ZHrRhN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm1lMHJPbmdpb1dBTFhJejRtdzNrcHo4eXphY0p4ZlBYMDRneFUvNlJSS1hv?=
 =?utf-8?B?bkthTFFwOWlwaTNrYmJ4Q0llMFEya05XQzgxQUJlUGh6aFFSamZpbDFiVFdP?=
 =?utf-8?B?WGV3WnR1WmNNeWtLM2J0VWVLMXp6eUVhRUg0WEttOVA4MnJBVEoyNmdNcFBX?=
 =?utf-8?B?di94eEhGQnVMbEZzSkNTblU5aDlnRXkrL2ZqWm5xU0F3elVHQmFmMkhiV09m?=
 =?utf-8?B?aVRqd21vbU9VTjVHMXJBSWIycDdRci9LME1BSXJIM1RPT0ZwNG5UTTh1cGNS?=
 =?utf-8?B?YXora3lLTW1SZkNGS1BjRjNHR0czaXRFMEpoUUpWNTV5MC9oMWtUMjJ0Z0Iz?=
 =?utf-8?B?MmJmZGpHYktXbTNhNUZ5ekpZeXA3RTdpcjBmc0dwK1JRa2pFVUNJdlVpaFp3?=
 =?utf-8?B?SGV4UW9MVGljNFJkT2UrWEIxdWZENVZrYmRia2R5dDYzaDhiYlRDRWd1RWRT?=
 =?utf-8?B?cXMySFg4TGNQY2ZWdzQ3Q0ZGTDdCdDJPY2ZORitJRmxERW94bFk3aTN5Y3cz?=
 =?utf-8?B?MS9DMVQ5ZEQ2bFNGWjdnNkhPS1lVeHNmQ1I1SEhKbGFLNVZpZGFXczkxNWdD?=
 =?utf-8?B?STJ5QXRIODVVeURGQ1FmMEt1dWhzeUJtYWgyR1RocHRhTXZYVzBzOE9VRXRB?=
 =?utf-8?B?dE0wZGptcys3YXNqbnI5SzBtb2VjbkUzUXVXTGhNbzYvS2lpWXAxbjdDRGFT?=
 =?utf-8?B?SjZib2cwb0JrUkt3bG0wbFVVOEVueDNYMEZ5Z1ZWY05pNzBRUHdrVWNKOGQx?=
 =?utf-8?B?TjIyUEFsUSttckpMcDZrOTk4OWFIanluWEUwYlJjWWtEekpmcHlqNHZ3SW02?=
 =?utf-8?B?MmI3aXcrbnJwWjdYaEhwNmdCcW5WSEJOZWRaenRrZmpyNmRCN1V1SVFkd2pu?=
 =?utf-8?B?Y1YrQ21qcEhkdnZOSVlaMlFZejJZQUNWbEJ1YmUwdi9OZ25GRk0yVjNkVTE2?=
 =?utf-8?B?Y05LdEE5ZU1CV1lXYzRwZmpPanJ1VUlLR2J5WDhiaWd2TnBJdFdxVE1xSUFK?=
 =?utf-8?B?Zy9GbUpGNlJiMFZwN1JHbTlCWS9sakd4REhMM0lvN1hFUm92YzYyMmhHSGZz?=
 =?utf-8?B?ODFWWDNQT0ZLbFRZUWlxekRROG1peldiNmNzdGJoQ1JEeW1TZG5WWDNBWG1r?=
 =?utf-8?B?c2dkNDBnNHp6cjhKbnNCc2tzUlZGaG51a3NNODRUbWptTWhxa1NRdUFtSG1K?=
 =?utf-8?B?UWtTcXU2ZnRqS01HUlk5YjFJbWFNS2NFYjQ2WHlJVkszTkUzeTlPbUZjeG1X?=
 =?utf-8?B?cDNIUkF4LzdtRXpHVWIyR3VES3hlOHU4M0hKdVlFMDBURFkwWVpCdVhzS3pl?=
 =?utf-8?B?SFQrZXF5TTlrYlIzUzZjbFpTaXp6OG5mWXpiMStxTWd1N1FUYzBTTUR5bkpa?=
 =?utf-8?B?eFZ2cWRiQjAyWXQwdE9Ock1FaXFMWkVvQW9DYk4vL2FXNVNVczZRWVRZdUdC?=
 =?utf-8?B?S05oV0NFYkNlanR6eG13eFM1Q3cyMWpmSjFQbzJVTkc5VHBzYTkwMjRRVHJh?=
 =?utf-8?B?cEZtOVBGNHkrclFVTFlyVGFwV2l3Zk0yZlJheXVXejBTUDJPRWVDV0UrMkk4?=
 =?utf-8?B?aG41SjhCdVFoeWhyZXRXT3UyOHlDZGZyQ1NHTi91U2U4TWpHQlpWNmtPVUNi?=
 =?utf-8?B?aGFlNkx0UEZ5Z0o5amhtaUNuSXc0WUtlbVlzUm1UaVgyL2oyZGFXYk1neGIv?=
 =?utf-8?B?WElZcWZzbGlLZ0ZOamQ2aUg3YjhtTmVEaGs1TVNlY3VpSWtsRGUvR1RrYTBV?=
 =?utf-8?B?WXZMQXZRbXNNZmptRUhMT3c3Vzd3UzRPYVdyVVdialpBUXI4TGROOTg5TnZO?=
 =?utf-8?B?RHh3MmZaWHlBNFZjRnVoeGtycEc4MVJFY05aQUtySzFuNzVkQWtobGVEVjZi?=
 =?utf-8?B?UWtCRzFacmtVY3U2Z3BkdTNwaGVUMXVYTDBDaTIzYjNJN0RDZWV4dUhQZW1K?=
 =?utf-8?B?c2lSME5MRkp3YzFUaFlrcDloQ0d3NWkreTdzVXAvLzh2Ny9DOUxSamthaFcz?=
 =?utf-8?B?aXppT2NTUzRRNTBSNUpzUjVqUWpwSTYwa2hia1ZsemlONVNZbjFaMFZjZDRz?=
 =?utf-8?B?bUJmQUttcFJqOVBtYThLb0UvNURZOVhMK0lSeHR2TVRtZkpRZlRNUXJ0YnRx?=
 =?utf-8?Q?ErI14Kq/GiDpXqtx6+/QuNjaX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988bdfcc-583c-45c8-e0e3-08de2e2a12e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 02:58:57.3492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvP2X7fbU8nZCGlPk2Psnerqfh3i4xO/lkIsieipmfyp74G5bRQiq7IARnZV5PX7l2chQlTXtY55DAUDfkMIYmzCjd0ZjASP71A4Y3kGWFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6520
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNy85XSB2ZmlvL2xpc3RlbmVy
OiBDb25zdHJ1Y3QgaW90bGIgZW50cnkgd2hlbiB1bm1hcA0KPm1lbW9yeSBhZGRyZXNzIHNwYWNl
DQo+DQo+T24gMjAyNS8xMS8yNiAxMzo0NSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+
DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlp
LmwubGl1QGludGVsLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDcvOV0gdmZpby9s
aXN0ZW5lcjogQ29uc3RydWN0IGlvdGxiIGVudHJ5IHdoZW4NCj51bm1hcA0KPj4+IG1lbW9yeSBh
ZGRyZXNzIHNwYWNlDQo+Pj4NCj4+PiBPbiAyMDI1LzExLzYgMTI6MjAsIFpoZW56aG9uZyBEdWFu
IHdyb3RlOg0KPj4+PiBJZiBhIFZGSU8gZGV2aWNlIGluIGd1ZXN0IHN3aXRjaGVzIGZyb20gcGFz
c3Rocm91Z2goUFQpIGRvbWFpbiB0byBibG9jaw0KPj4+PiBkb21haW4sIHRoZSB3aG9sZSBtZW1v
cnkgYWRkcmVzcyBzcGFjZSBpcyB1bm1hcHBlZCwgYnV0IHdlIHBhc3NlZCBhDQo+Pj4gTlVMTA0K
Pj4+PiBpb3RsYiBlbnRyeSB0byB1bm1hcF9iaXRtYXAsIHRoZW4gYml0bWFwIHF1ZXJ5IGRpZG4n
dCBoYXBwZW4gYW5kIHdlDQo+bG9zdA0KPj4+PiBkaXJ0eSBwYWdlcy4NCj4+Pg0KPj4+IHRoaXMg
aXMgYSBnb29kIGNhdGNoLiA6KSBIYXZlIHlvdSBvYnNlcnZlZCBwcm9ibGVtIGluIHRlc3Rpbmcg
b3IganVzdA0KPj4+IGlkZW50aWZpZWQgaXQgd2l0aCBwYXRjaCBpdGVyYXRpb24/DQo+Pg0KPj4g
UGF0Y2ggaXRlcmF0aW9uLg0KPj4NCj4+Pg0KPj4+PiBCeSBjb25zdHJ1Y3RpbmcgYW4gaW90bGIg
ZW50cnkgd2l0aCBpb3ZhID0gZ3BhIGZvciB1bm1hcF9iaXRtYXAsIGl0IGNhbg0KPj4+PiBzZXQg
ZGlydHkgYml0cyBjb3JyZWN0bHkuDQo+Pj4+DQo+Pj4+IEZvciBJT01NVSBhZGRyZXNzIHNwYWNl
LCB3ZSBzdGlsbCBzZW5kIE5VTEwgaW90bGIgYmVjYXVzZSBWRklPIGRvbid0DQo+Pj4+IGtub3cg
dGhlIGFjdHVhbCBtYXBwaW5ncyBpbiBndWVzdC4gSXQncyB2SU9NTVUncyByZXNwb25zaWJpbGl0
eSB0byBzZW5kDQo+Pj4+IGFjdHVhbCB1bm1hcHBpbmcgbm90aWZpY2F0aW9ucywgZS5nLiwNCj4+
PiB2dGRfYWRkcmVzc19zcGFjZV91bm1hcF9pbl9taWdyYXRpb24oKQ0KPj4+Pg0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+
PiBUZXN0ZWQtYnk6IEdpb3Zhbm5pbyBDYWJpZGR1IDxnaW92YW5uaS5jYWJpZGR1QGludGVsLmNv
bT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGh3L3ZmaW8vbGlzdGVuZXIuYyB8IDE1ICsrKysrKysrKysr
KysrLQ0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9saXN0ZW5lci5jIGIvaHcvdmZp
by9saXN0ZW5lci5jDQo+Pj4+IGluZGV4IDIxMDkxMDExNTguLjNiNDhmNjc5NmMgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2h3L3ZmaW8vbGlzdGVuZXIuYw0KPj4+PiArKysgYi9ody92ZmlvL2xpc3RlbmVy
LmMNCj4+Pj4gQEAgLTcxMywxNCArNzEzLDI3IEBAIHN0YXRpYyB2b2lkDQo+Pj4gdmZpb19saXN0
ZW5lcl9yZWdpb25fZGVsKE1lbW9yeUxpc3RlbmVyICpsaXN0ZW5lciwNCj4+Pj4NCj4+Pj4gICAg
ICAgIGlmICh0cnlfdW5tYXApIHsNCj4+Pj4gICAgICAgICAgICBib29sIHVubWFwX2FsbCA9IGZh
bHNlOw0KPj4+PiArICAgICAgICBJT01NVVRMQkVudHJ5IGVudHJ5ID0ge30sICppb3RsYiA9IE5V
TEw7DQo+Pj4+DQo+Pj4+ICAgICAgICAgICAgaWYgKGludDEyOF9lcShsbHNpemUsIGludDEyOF8y
XzY0KCkpKSB7DQo+Pj4+ICAgICAgICAgICAgICAgIGFzc2VydCghaW92YSk7DQo+Pj4+ICAgICAg
ICAgICAgICAgIHVubWFwX2FsbCA9IHRydWU7DQo+Pj4+ICAgICAgICAgICAgICAgIGxsc2l6ZSA9
IGludDEyOF96ZXJvKCk7DQo+Pj4+ICAgICAgICAgICAgfQ0KPj4+PiArDQo+Pj4+ICsgICAgICAg
IC8qDQo+Pj4+ICsgICAgICAgICAqIEZha2UgYW4gSU9UTEIgZW50cnkgZm9yIGlkZW50aXR5IG1h
cHBpbmcgd2hpY2ggaXMgbmVlZGVkDQo+YnkNCj4+PiBkaXJ0eQ0KPj4+PiArICAgICAgICAgKiB0
cmFja2luZy4gSW4gZmFjdCwgaW4gdW5tYXBfYml0bWFwLCBvbmx5IHRyYW5zbGF0ZWRfYWRkcg0K
PmZpZWxkDQo+Pj4gaXMNCj4+Pj4gKyAgICAgICAgICogdXNlZCB0byBzZXQgZGlydHkgYml0bWFw
Lg0KPj4+DQo+Pj4gSnVzdCBzYXkgc3luYyBkaXJ0eSBpcyBuZWVkZWQgcGVyIHVubWFwLiBTbyB5
b3UgbWF5IGFkZCBhIGNoZWNrDQo+Pj4gaW5fbWlncmF0aW9uIGFzIHdlbGwuIElmIG5vdCBpbiBt
aWdyYXRpb24sIGl0IGlzIG5vIG5lZWRlZCB0byBkbyBpdC4NCj4+DQo+PiBEaXJ0eSB0cmFja2lu
ZyBpcyBub3Qgb25seSBmb3IgbWlncmF0aW9uLCBidXQgYWxzbyBkaXRyeSByYXRlL2xpbWl0LiBT
byBhDQo+bm9uLW51bGwgaW90bGINCj4+IGlzIGFsd2F5cyBwYXNzZWQgZm9yIHJhbSBNUi4gVGhh
dCBpb3RsYiBwb2ludGVyIGlzIHVzZWQgb25seSB3aGVuDQo+PiB2ZmlvX2NvbnRhaW5lcl9kaXJ0
eV90cmFja2luZ19pc19zdGFydGVkKCkgcmV0dXJuIHRydWUuDQo+Pg0KPj4gSSBjYW4gYWRkIGEg
Y2hlY2sgb24gZ2xvYmFsX2RpcnR5X3RyYWNraW5nIGlmIHlvdSBwcmVmZXIgdG8gYWRkIGEgY2hl
Y2suDQo+DQo+eWVhaCwgdGhpcyB3b3VsZCBiZSBoZWxwZnVsLg0KPg0KPj4NCj4+Pg0KPj4+PiAr
ICAgICAgICAgKi8NCj4+Pj4gKyAgICAgICAgaWYgKCFtZW1vcnlfcmVnaW9uX2lzX2lvbW11KHNl
Y3Rpb24tPm1yKSkgew0KPj4+PiArICAgICAgICAgICAgZW50cnkuaW92YSA9IGlvdmE7DQo+Pj4+
ICsgICAgICAgICAgICBlbnRyeS50cmFuc2xhdGVkX2FkZHIgPSBpb3ZhOw0KPj4+PiArICAgICAg
ICAgICAgaW90bGIgPSAmZW50cnk7DQo+Pj4+ICsgICAgICAgIH0NCj4+Pj4gKw0KPj4+DQo+Pj4g
V2hpbGUsIEknbSBzdGlsbCB3b25kZXJpbmcgaG93IHRvIGRlYWwgd2l0aCBpb21tdSBNUiBjYXNl
LiBMZXQncyBzZWUgYQ0KPj4+IHNjZW5hcmlvIGZpcnN0LiBXaGVuIHN3aXRjaGluZyBmcm9tIERN
QSBkb21haW4gdG8gUFQsIFFFTVUgd2lsbCBzd2l0Y2gNCj4+PiB0byBQVC4gVGhpcyBzaGFsbCB0
cmlnZ2VyIHRoZSB2ZmlvX2xpc3RlbmVyX3JlZ2lvbl9kZWwoKSBhbmQgdW5yZWdpc3Rlcg0KPj4+
IHRoZSBpb21tdSBub3RpZmllci4gVGhpcyBtZWFucyB2SU9NTVUgc2lkZSBuZWVkcyB0byBkbyB1
bm1hcCBwcmlvciB0bw0KPj4+IHN3aXRjaGluZyBBUy4gSWYgbm90LCB0aGUgaW9tbXUgbm90aWZp
ZXIgaXMgZ29uZSB3aGVuIHZJT01NVSB3YW50cyB0bw0KPj4+IHVubWFwIHdpdGggYW4gSU9UTEJF
dmVudC4gRm9yIHZpcnR1YWwgaW50ZWxfaW9tbXUsIGl0IGlzIGNhbGxpbmcNCj4+PiB2dGRfYWRk
cmVzc19zcGFjZV91bm1hcF9pbl9taWdyYXRpb24oKSBwcmlvciB0byBjYWxsaW5nDQo+Pj4gdnRk
X3N3aXRjaF9hZGRyZXNzX3NwYWNlKCkuIFNvIEkgdGhpbmsgeW91IG5lZWQgdG8gdHdlYWsgdGhl
IGludGVsX2lvbW11DQo+Pj4gYSBiaXQgdG8gc3VpdCB0aGUgb3JkZXIgcmVxdWlyZW1lbnQuIDop
DQo+Pg0KPj4gVlREIGRvZXNuJ3Qgc3VwcG9ydCBzd2l0Y2hpbmcgZnJvbSBETUEgZG9tYWluIHRv
IFBUIGF0b21pY2FsbHksIHNvDQo+c3dpdGNoZXMNCj4+IHRvIGJsb2NrIGRvbWFpbiBpbiBiZXR3
ZWVuLCBzZWUgaW50ZWxfaW9tbXVfYXR0YWNoX2RldmljZSgpIGluIGtlcm5lbC4NCj4+DQo+PiBT
byB3aXRoIHRoaXMgc2VxdWVuY2UgaXMgRE1BLT5ibG9jay0+UFQgZG9tYWluLCB3ZSBoYXZlIGd1
YXJhbnRlZWQgdGhlDQo+b3JkZXINCj4+IHlvdSBzaGFyZWQ/IFNlZSB2dGRfcGFzaWRfY2FjaGVf
c3luY19sb2NrZWQoKS4NCj4NCj5JIHNlZS4gU28gZ3Vlc3QgaGVscHMgaXQuIFRoaXMgbWlnaHQg
YmUgYSBiaXQgd2VhayBzaW5jZSB3ZSByZWx5IG9uDQo+Z3Vlc3QgYmVoYXZpb3IuIEkgdGhpbmsg
eW91IG1heSBhZGQgYSBUT0RPIG9yIGFkZCBjb21tZW50IHRvIG5vdGUgaXQuDQoNCk1ha2Ugc2Vu
c2UsIHdpbGwgYWRkLg0KDQo+DQo+QlRXLiBJIHRoaW5rIHRoZSBzdWJqZWN0IGNhbiBiZSByZWZp
bmVkIHNpbmNlIHRoZSByZWFsIHB1cnBvc2UgaXMgdG8NCj5tYWtlIHRyYWNraW5nIGRpcnR5IHBh
Z2VzIGluIHRoZSB1bm1hcCBoYXBwZW4gaW4gcmVnaW9uX2RlbC4NCj4NCj52ZmlvL2xpc3RlbmVy
OiBBZGQgbWlzc2luZyBkaXJ0eSB0cmFja2luZyBpbiByZWdpb25fZGVsDQoNCldpbGwgZG8uDQoN
Cj4NCj53aXRoIHRoaXMgYW5kIHRoZSBwcmlvciBjaGVjaywgdGhpcyBwYXRjaCBsb29rcyBnb29k
IHRvIG1lLg0KPg0KPlJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4N
Cj4+Pg0KPj4+IEJUVy4gc2hvdWxkIHRoZSBpb21tdSBNUnMgZXZlbiBnbyB0byB0aGlzIHRyeV91
bm1hcCBicmFuY2g/IEkgdGhpbmsgZm9yDQo+Pj4gc3VjaCBNUnMsIGl0IHJlbGllcyBvbiB0aGUg
dklPTU1VIHRvIHVubWFwIGV4cGxpY2l0bHkgKGhlbmNlIHRyaWdnZXIgdGhlDQo+Pj4gdmZpb19p
b21tdV9tYXBfbm90aWZ5KCkpLg0KPj4NCj4+IFllcywgaXQncyB1bm5lY2Vzc2FyeSwgYnV0IGl0
J3MgaGFyZCBmb3IgVkZJTyB0byBkaXN0aW5ndWlzaCBpZiB0cnlfdW5tYXAgaXMgZHVlDQo+dG8N
Cj4+IGRvbWFpbiBzd2l0Y2ggb3IgYSByZWFsIHVubWFwLiBJIHRoaW5rIGl0J3MgaGFybWxlc3Mg
YmVjYXVzZSB0aGUgc2Vjb25kDQo+dHJ5X3VubWFwDQo+PiB1bm1hcHMgbm90aGluZy4NCj4NCj5o
bW1tLiBjYW4gYSB1bm1hcCBwYXRoIGdvIHRvIHJlZ2lvbl9kZWwoKT8gTm90IHF1aXRlIGdldCB0
aGUgc2Vjb25kDQo+dHJ5X3VubWFwLCBkbyB5b3UgbWVhbiB3aGVuIHZJT01NVSB1bm1hcHMgZXZl
cnl0aGluZyB2aWENCj52ZmlvX2lvbW11X21hcF9ub3RpZnkoKSBhbmQgdGhlbiBzd2l0Y2ggQVMg
d2hpY2ggdHJpZ2dlcnMgdGhlIHJlZ2lvbl9kZWwNCj5hbmQgdGhpcyB0cnlfdW5tYXAgYnJhbmNo
Pw0KDQpZZXMsIHZmaW9faW9tbXVfbWFwX25vdGlmeSgpIGlzIGZpcnN0IHRyeV91bm1hcCwgdW5t
YXAgaW4gcmVnaW9uX2RlbCBpcyB0aGUgc2Vjb25kIHRyeV91bm1hcC4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==

