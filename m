Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A20EC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 03:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR0SN-0007MF-Pc; Sun, 15 Jun 2025 23:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uR0SM-0007Lo-2p
 for qemu-devel@nongnu.org; Sun, 15 Jun 2025 23:24:22 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uR0SI-0001Mx-UE
 for qemu-devel@nongnu.org; Sun, 15 Jun 2025 23:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750044259; x=1781580259;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aknHGwy70upuM5Oz34GVuVTbgXzmhDicVpAi2R65mng=;
 b=OG0ePHdqSyAdWRYd/Q/qIHwUvccSYD1kbXaJTigvwLjzMeqH5LDtF9gM
 Jo+fr5lCuHNSVrhhcdsRg0sGizzPbVTQrYt+Di9yA8fBVSWvUG9KDToA6
 Gu2K8iTpiqPkJt1ziLEsUvH4LfWhaJFImeVg7cy/BxXZ1hPN9Ad2UJ92i
 dwLwgfca2hqIVmkfm398BFKgY319jeNBA18UbTrZgqQmHnzl96qJH2zij
 rzZViJJjxuhptCGqMD4G9Vu3Szx1CYxY0w5wO5sTFP7GX3vQ2CbGDPcqM
 tkB6nESQ2ycAsx22mGv36fjh0nnXDP38ENix85gWnW7rUgjhJX2WArvI0 w==;
X-CSE-ConnectionGUID: 0aeJSzZsRhaYlzdxijZoqA==
X-CSE-MsgGUID: kcV7+hYpTOGa+f9hMcDm1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62831024"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="62831024"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2025 20:24:12 -0700
X-CSE-ConnectionGUID: LdxvtMohTgGwd93DBqFtQA==
X-CSE-MsgGUID: M4/V2wnjTry3gEs+fnnd7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="179358409"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2025 20:24:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 20:24:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 15 Jun 2025 20:24:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.74)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 20:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4Pseq8enOg9m6HP+nk5qtTbzhUliWod20W9X0IL/1P61G4d/PpgtiKpwUtsA3ydrDs25P0tmUD4/hYmnbiqByQ3qlT4J9OejwqnP4mNVjcYdnOPv1tRAds4zKmLJFS8hUqxmlcWFpSt3mHNt5xtqWkfB1q8/2C8M9YsPCmC2mxgA3WCpjOlj58scKwZ1oRONVCspahl72+pOWpXBmOJUf12RjxjnVg23elEBNXmkPrjsMXV2FlDnP+QzWJyBR3BULBuMKDyUQLW4AQIK5XfFHzgtBA9fB/Nh8RV4qCRUxoEz+L7ayE4g+uT9ZtAEaYPiNeHhDcHBzS8FIA3IJ+RgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aknHGwy70upuM5Oz34GVuVTbgXzmhDicVpAi2R65mng=;
 b=ewb+o/1y+xy8f8kUzu1DK0WEWScjHMXbhuQHTOcwzT9rHs3y+r8NIhIgY4X8jK20Km66IwI9nXXVZDKD0NQAQLgguXnhp04If6JBUi6BESxwD4XWQPVue4TCs1UdmTJLCjtWLLM0ipF/u9h8J5wM4UQZP3F/sBDQB4YeH48QiQVqlcbyv+5mMDjBd+fkB/PnRwO+4q/qVA/rd1AWjVCNW7Kr4/89E0FF88YlnmM4vXHsIUH4o+LvrRKV2JPoVyz6qUmbF8bKVca953EeFd1VP2+CGvchDkcRBZorBItE8Q/WpO6+eEekMuwbkyABUOyAUSqgY5z837LoXnPnFREJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 03:24:07 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 03:24:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJMfKt9Mfha3Ee+klVeu6JiiLPdsMoAgAIQvoCAAPjWAIADz6UAgACqsQCAAnMkMIAX9a0AgAWgn1A=
Date: Mon, 16 Jun 2025 03:24:06 +0000
Message-ID: <IA3PR11MB91365922FBD407DD25E382C39270A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
In-Reply-To: <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: yi.l.liu@intel.com,nicolinc@nvidia.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7875:EE_
x-ms-office365-filtering-correlation-id: 8902510b-2a27-4d83-cc77-08ddac85404c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SGk4by92L3gybWRIZUlmYklHeGdieTJZOElIN2dZcnduZlZkeEFwK0lMWEhz?=
 =?utf-8?B?ZTVmb0hjWnBBeWRkTGR3S3ExeDU0eDk5d0doeU1HWkhDRS84eWY1VGlaUDZ0?=
 =?utf-8?B?My9Za0RQcXk3dEs4QlJKTnRieVkzVjI2VVBYSGJPbjJFWWJ0R1A2MjZWQkU3?=
 =?utf-8?B?MW1uQUpDczBlZW9ydFFZMHc0MU5rSzBTUHl1VmlvM2JGblhOdzk0OVJKZHJM?=
 =?utf-8?B?enFnWjMwRlY0dWZkYUEyTWdIZWZwVUFaenIvTWFaNXcweG5PMnBKOFdPc0Y5?=
 =?utf-8?B?ZDltZ29zRjZSRjlHZndXWFQvRFlyMEYxbUdmYU5Xc3FUVUZHNXVQQmhQcXRX?=
 =?utf-8?B?Sjdhb3k0SitLSjAzalFQRG1Scm9OTmZwdkxFa3c0cHIySnRKYTdIdGRTMWJo?=
 =?utf-8?B?Z0h6MVJ0V3FNY1R6c2htYVNCTytmbElMWGRlU3lHS1cySlRTVEZFSjUycFdJ?=
 =?utf-8?B?OU1mVUl1S3VKQzdoRmZlVi9KZ0pOc0NRVkkycUErODdOSTZzaGJkWitjc2ov?=
 =?utf-8?B?TlVnZ2VlV0IwOGdCbHN1TW5vbnN3Y3NZb2R6UkRaeWhWVWVOVlVad0V0dGZh?=
 =?utf-8?B?NlNqOFVoTGRGMC94cnMwY1E3dUgzT3V1ZGh5dWI2R1lVQnltMWZzUHRwanMy?=
 =?utf-8?B?NFFEbkErd1dqby9yYTEraWo3d2l6WTJmeW5JTXNZclNqUml5Tlp4Y1lYWVZv?=
 =?utf-8?B?WkZqK1NCWGJhUkdPQ3RuU1BpOGxJajloOWRYQ0FxbDh1ZUZnaTd6eVRHcnVv?=
 =?utf-8?B?S3QwcU0rNlUyL01FeEFtSHpsMVNKMEE4S0x1V1JzM3VYV2pHMUdRVEN3T2px?=
 =?utf-8?B?aGd4RC9HYVRBNU9BZVlpRFdGcVJKN1B0Vkh3blBTSmJGdTJJYnNmT1FKU3FX?=
 =?utf-8?B?aU4rMk5RNkgzZHZpa3ZMWGF1dmNZUkMwMzVIQ1gzbVRvWTR5NWtkS3JyY1dL?=
 =?utf-8?B?MXJ6dExWR3JSMTMrcnNOUmZySzhSTmRTWWNBRmlTbHhUUU9tVGJ2R2kyZUdP?=
 =?utf-8?B?OEU0bjFFTVVGbkN2T3lBTGdFa2NqMjlPUm00Y29aaThpUGd3VE13UnN0UTFM?=
 =?utf-8?B?dDl3OXovR28zQSt1eTUrcnc1SkFSMGV5MDRjVzNza3BydVp4eWhzMlVTN2c2?=
 =?utf-8?B?ZUhhc0Zvdll2MVdwZm1wMDBlWWUvU3ZOd083UlgxOU5pcjU3ZU9ZYW1SUjc4?=
 =?utf-8?B?ZURFQmk5ZmRKSUNBWWdXWnpxdXZ3ODErRFlYTG1OeE5DZXN2MkszbTdxT1V2?=
 =?utf-8?B?ZFRMaWsrenRUa29kNjRWZHc3Q0Y4RU5qSUlCcGdpMUNBUGRWNHRmV1JoQWd6?=
 =?utf-8?B?Z05lUVlOYWJBQVBhUGZZL0RtVEd5bzQvU3JpTFJiQ3JMV09FQkJoRXpqN0NR?=
 =?utf-8?B?czlEWlhFMVNQNmhhSitsTmNzSmM5cEdJMG9kSUMvV25xcE1zVEdPcVRaZU9C?=
 =?utf-8?B?MWhKT3M1QTBPR0NEQzBQNi96R1JTWWJHVnlUVllTZ0lUeDQ5WHFJNFk4MWxT?=
 =?utf-8?B?ZDNFUnlPVWs4TTNPRzBxOHlHUkI1NXpYa0Qwbk16WnJ5RXM2UDFVeGNpVGRE?=
 =?utf-8?B?bmEyOVRLRTlzb1hEMUtTU0ZQV0FwTWdTTGVPd2FSTnk3dnlHdEFBQkJDOE9R?=
 =?utf-8?B?MEgrUEdEWkFhY29VNFFlWGpKTys2SmpDUm8vcWs5emxINU8vQXFEbnhrcE1B?=
 =?utf-8?B?Q25oNm0yY084ZDJOb05xaXBFb1g5aklWZnRRd2Z0d1dOYlg1cGNhcmh6Slgw?=
 =?utf-8?B?MzhZZzhKdUZYNnlpNUs5ZVJUL3JHWGpNcDhsdnBiSUk4bVhISmhQVCtmUDVr?=
 =?utf-8?B?dDdPeFZybzFvMEVabVJGUFIzZmxXS3h5QkVFRHdpRDd3ak9VVmlJRHg1NkVV?=
 =?utf-8?B?OGRDUm5OOTRBTzc4QUY1bjl0UThON2h4dmNFRUphVkF2T0hpUE5IOXN3MFNj?=
 =?utf-8?B?M0ZwTlN3bzN0RENGT1JodlJNUFRrZ29BejgzalRyY1Q0NkNiaGY0eXBkZnAz?=
 =?utf-8?Q?IL/jJHpsLxSe5wXdYlSfAv0cQyM2zY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mmpha0Q5S1VCRHg4ZVZ2M3V1WWNybk5zTTlRaVNrTHNUVkZRZmFaTnQ5NUx4?=
 =?utf-8?B?ZDJ4Rk9GSCtXL1gwMmZuK0JTNWIzNmtrVXhYcUN1T2Z2WHNLa05oL2paVm1q?=
 =?utf-8?B?REw1MlZSam9iM0dVS0ZGWDh1ZjI3VTk3NE9ncVpxQTgvVDNxMUFZeXU5N3VW?=
 =?utf-8?B?SGNIbzhabDA4WVhqUmpac05iait0TlZMQ0FYUFpHOXF4VHR6cElwY2RxWmpS?=
 =?utf-8?B?djhFeTFSNE1jRFdHWEJJeWVGMlBJKzJVbzVkVnNyenZsMk9rNVBzOGFHYzhE?=
 =?utf-8?B?QVI3cnYvTmY1Nm4yY0s4SndFcjZJZFdGcjFpTzd5WGJleGpWM3JSa2ZXY3cw?=
 =?utf-8?B?RHlGRWpKRTR0WFRSMWF5ZWxMMDlBOU02bTZMc0tnZHVGWkhUK2YyK29HS2Yz?=
 =?utf-8?B?UUZaSDdheVRlTGo5TVIxZzN2RkNtU1FPQzNXTytPb00yVDBtdnN0TXVzZ0Va?=
 =?utf-8?B?S0xVcnBJajFRTTZGWUdYZDBqUnFxc0UzVDVCdlJvZkhqSVZZWGFsUWRkS0M4?=
 =?utf-8?B?ZENpaUlPdU5zSmRVRTc4ZjVqWjdnNG5ENFdVNjlaU2pNQ3hQVFNFNG1WYWVm?=
 =?utf-8?B?L1hpWXpYeGtPUDRLM3hZMzF4NFJ4S2xmQ25Pb3hvYWtFalhta0RlUStxeUJZ?=
 =?utf-8?B?YXpBdDAwTjlBTkVJTFdET2phakxHL0oyOGlOT25JMGRiR2s1QjMxeWVnSGNT?=
 =?utf-8?B?bmtSN0NaQTUxSWFxczN2UEUzVHJzYXhLU3lKbzlDL1lmQ3Npd3Z2RERyNmds?=
 =?utf-8?B?bytlWTlwME5DMjkvcTVoa0dlL2wvME5lOURjYVJCYnFxMk1hOFRaK0Z6OFY0?=
 =?utf-8?B?YlY5S1FVWWtmekhad0xnTWFrdkJpWmpOZzlWcUQzcWlUSXdScU9Icy9zVTht?=
 =?utf-8?B?UjJPRTJLQnRYNk5ycTB5eGYrWnJDblNjZ3o4Z2NHMmhwM1NKZHVVUmRYbFdh?=
 =?utf-8?B?NnVXYkRCN3VxZll2Qm4wSm5oeTRIMDFvVUJ5UFpXaXNjUUljTlRxQzFGZkwx?=
 =?utf-8?B?MU5FVTRrMTg0WE1oaERETlUxSzI0aytlTDN3Z3ZyQkhvMXVPVUFlYlBZRkhH?=
 =?utf-8?B?aFVTU1lLUU85K2l6cUY4RXU5eW5DME1RSXVUdW9yZnlXdURYRWZvSlRrV1Yx?=
 =?utf-8?B?RU0zTEU3ckhsdnlpb21pOElSNVkrUEUxR0VWc2FPY3VjYTZudnZBLzA1RjN4?=
 =?utf-8?B?SEhreFQ2MVNhVExIWjR6MGZsTmhLaE1iZjZWOTdvclhXR2I3Vkd6Um12cklL?=
 =?utf-8?B?eWdLUHhwbzB1QzRSS0NKV1RWai9WT0dVWmJCdGFrbUdyVm04b2tTcWVEL0tS?=
 =?utf-8?B?OU9oQ0U3b1BZSE9WQkVyd2pZTnVlZGxneThGNm1ZNG55ZmZLTTZ1L2JBZ3VL?=
 =?utf-8?B?RWpGQ3JtTFlBVWNLYnFpNGNiNk1PQllmdUkvblBEUmtWSTR1Zkc5Vi95T1Rj?=
 =?utf-8?B?cUFEV3pnSlN0b0M0bFkxRytySW1FWll0YjRQeXVISnhWWURYbDlJaVQvM095?=
 =?utf-8?B?b3BLQ0VScXp5bnZVK3FNTHFMYmFKU2FjeXhNaUZXcUhIb1RSRXZ5L2wrWElz?=
 =?utf-8?B?WlJlbTQ4VHpzL25HREJ6NUd0TjJZN1pDMmQrdk5peFVtZFFZQ0xZUFZXZ2NM?=
 =?utf-8?B?cWJiM3ViMUFESUo3TVhuTStQbWQwemtXbzlURFpEbHZtem4vYW4rKy91allF?=
 =?utf-8?B?WEVhUis3SHpMd203SlZ3UFJ2cGxUejY5V0dkZTJSdHoyTmRSS21xMzc4ckJI?=
 =?utf-8?B?QXZPb0pTOW13VXlqbjV4b0VrelRKRW1lZ2hDVkpyditTNVQvRXhzYnN5U29C?=
 =?utf-8?B?WjhEbk5tNTNzcVFKTWRQTnZiMnp1WXpvOFlsOCtNTnZpcDBicE1zdjJucitC?=
 =?utf-8?B?QWpvRzBpRXZUdjJTUDZCeHBDWTRraC9lbWtHbXQ0VUJrMnZpQ2R5ZXA1V0Rp?=
 =?utf-8?B?TlE1T2NHZUtEWldhaVVZUWVEd2ozcXE5Mm5RL2pJb0FxS041OTh3dnJJSTkr?=
 =?utf-8?B?TWpFZ1h2SjhVVHZrZERPYXVKTzdnZWsrS2pNM0FyZmY3QWE0YnNQallpWTAx?=
 =?utf-8?B?NEtzd1RiZWtMa2VQMXFYMVQyRE9PWlhzcitGVG5YSGlhanR1NWJVZmFTZWxJ?=
 =?utf-8?Q?UwOmra3yaN+5lP3UsH8Glo4Lc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8902510b-2a27-4d83-cc77-08ddac85404c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 03:24:06.5322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnhpFCX0bGjCtC7iMi7m34n75ZtIokbb/0sLOUXN7nJ+ItFC97ZZaCjSIiQ08z7mNaabvIOCiRO6fCUs828ClNCl4UJeIpc9KLVd7vlt7D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggcmZjdjMgMTUvMjFdIGludGVsX2lv
bW11OiBCaW5kL3VuYmluZCBndWVzdCBwYWdlIHRhYmxlIHRvDQo+aG9zdA0KPg0KPk9uIDIwMjUv
NS8yOCAxNToxMiwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRp
YS5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCByZmN2MyAxNS8yMV0gaW50ZWxfaW9tbXU6
IEJpbmQvdW5iaW5kIGd1ZXN0IHBhZ2UgdGFibGUNCj50bw0KPj4+IGhvc3QNCj4+Pg0KPj4+IE9L
LiBMZXQgbWUgY2xhcmlmeSB0aGlzIGF0IHRoZSB0b3AgYXMgSSBzZWUgdGhlIGdhcCBoZXJlIG5v
dzoNCj4+Pg0KPj4+IEZpcnN0LCB0aGUgdlNNTVUgbW9kZWwgaXMgYmFzZWQgb24gWmhlbnpob25n
J3Mgb2xkZXIgc2VyaWVzIHRoYXQNCj4+PiBrZWVwcyBhbiBpb2FzX2lkIGluIHRoZSBIb3N0SU9N
TVVEZXZpY2VJT01NVUZEIHN0cnVjdHVyZSwgd2hpY2gNCj4+PiBub3cgaXQgb25seSBrZWVwcyBh
biBod3B0X2lkIGluIHRoaXMgUkZDdjMgc2VyaWVzLiBUaGlzIGlvYXNfaWQNCj4+PiBpcyBhbGxv
Y2F0ZWQgd2hlbiBhIHBhc3N0aHJvdWdoIGNkZXYgYXR0YWNoZXMgdG8gYSBWRklPIGNvbnRhaW5l
ci4NCj4+Pg0KPj4+IFNlY29uZCwgdGhlIHZTTU1VIG1vZGVsIHJldXNlcyB0aGUgZGVmYXVsdCBJ
T0FTIHZpYSB0aGF0IGlvYXNfaWQuDQo+Pj4gU2luY2UgdGhlIFZGSU8gY29udGFpbmVyIGRvZXNu
J3QgYWxsb2NhdGUgYSBuZXN0aW5nIHBhcmVudCBTMiBIV1BUDQo+Pj4gKG1heWJlIGl0IGNvdWxk
PyksIHNvIHRoZSB2U01NVSBhbGxvY2F0ZXMgYW5vdGhlciBTMiBIV1BUIGluIHRoZQ0KPj4+IHZJ
T01NVSBjb2RlLg0KPj4+DQo+Pj4gVGhpcmQsIHRoZSB2U01NVSBtb2RlbCwgZm9yIGludmFsaWRh
dGlvbiBlZmZpY2llbmN5IGFuZCBIVyBRdWV1ZQ0KPj4+IHN1cHBvcnQsIGlzb2xhdGVzIGFsbCBl
bXVsYXRlZCBkZXZpY2VzIG91dCBvZiB0aGUgbmVzdGluZy1lbmFibGVkDQo+Pj4gdlNNTVUgaW5z
dGFuY2UsIHN1Z2dlc3RlZCBieSBKYXNvbi4gU28sIG9ubHkgcGFzc3Rocm91Z2ggZGV2aWNlcw0K
Pj4+IHdvdWxkIHVzZSB0aGUgbmVzdGluZy1lbmFibGVkIHZTTU1VIGluc3RhbmNlLCBtZWFuaW5n
IHRoZXJlIGlzIG5vDQo+Pj4gbmVlZCBvZiBJT01NVV9OT1RJRklFUl9JT1RMQl9FVkVOVFM6DQo+
Pg0KPj4gSSBzZWUsIHRoZW4geW91IG5lZWQgdG8gY2hlY2sgaWYgdGhlcmUgaXMgZW11bGF0ZWQg
ZGV2aWNlIHVuZGVyIG5lc3RpbmctZW5hYmxlZA0KPnZTTU1VIGFuZCBmYWlsIGlmIHRoZXJlIGlz
Lg0KPj4NCj4+PiAtIE1BUCBpcyBub3QgbmVlZGVkIGFzIHRoZXJlIGlzIG5vIHNoYWRvdyBwYWdl
IHRhYmxlLiBRRU1VIG9ubHkNCj4+PiAgICB0cmFwcyB0aGUgcGFnZSB0YWJsZSBwb2ludGVyIGFu
ZCBmb3J3YXJkcyBpdCB0byBob3N0IGtlcm5lbC4NCj4+PiAtIFVOTUFQIGlzIG5vdCBuZWVkZWQg
YXMgUUVNVSBvbmx5IHRyYXBzIGludmFsaWRhdGlvbiByZXF1ZXN0cw0KPj4+ICAgIGFuZCBmb3J3
YXJkcyB0aGVtIHRvIGhvc3Qga2VybmVsLg0KPj4+DQo+Pj4gKGxldCdzIGZvcmdldCBhYm91dCB0
aGUgImFkZHJlc3Mgc3BhY2Ugc3dpdGNoIiBmb3IgTVNJIGZvciBub3cuKQ0KPj4+DQo+Pj4gU28s
IGluIHRoZSB2U01NVSBtb2RlbCwgdGhlcmUgaXMgYWN0dWFsbHkgbm8gbmVlZCBmb3IgdGhlIGlv
bW11DQo+Pj4gQVMuIEFuZCB0aGVyZSBpcyBvbmx5IG9uZSBJT0FTIGluIHRoZSBWTSBpbnN0YW5j
ZSBhbGxvY2F0ZWQgYnkgdGhlDQo+Pj4gVkZJTyBjb250YWluZXIuIEFuZCB0aGlzIElPQVMgbWFu
YWdlcyB0aGUgR1BBLT5QQSBtYXBwaW5ncy4gU28sDQo+Pj4gZ2V0X2FkZHJlc3Nfc3BhY2UoKSBy
ZXR1cm5zIHRoZSBzeXN0ZW0gQVMgZm9yIHBhc3N0aHJvdWdoIGRldmljZXMuDQo+Pj4NCj4+PiBP
biB0aGUgb3RoZXIgaGFuZCwgdGhlIFZULWQgbW9kZWwgaXMgYSBiaXQgZGlmZmVyZW50LiBJdCdz
IGEgZ2lhbnQNCj4+PiB2SU9NTVUgZm9yIGFsbCBkZXZpY2VzIChlaXRoZXIgcGFzc3Rocm91Z2gg
b3IgZW11YWx0ZWQpLiBGb3IgYWxsDQo+Pj4gZW11bGF0ZWQgZGV2aWNlcywgaXQgbmVlZHMgSU9N
TVVfTk9USUZJRVJfSU9UTEJfRVZFTlRTLCBpLmUuIHRoZQ0KPj4+IGlvbW11IGFkZHJlc3Mgc3Bh
Y2UgcmV0dXJuZWQgdmlhIGdldF9hZGRyZXNzX3NwYWNlKCkuDQo+Pj4NCj4+PiBUaGF0IGJlaW5n
IHNhaWQsIElPTU1VX05PVElGSUVSX0lPVExCX0VWRU5UUyBzaG91bGQgbm90IGJlIG5lZWRlZA0K
Pj4+IGZvciBwYXNzdGhyb3VnaCBkZXZpY2VzLCByaWdodD8NCj4+DQo+PiBObywgZXZlbiBpZiB4
LWZsdHM9b24gaXMgY29uZmlndXJlZCBpbiBRRU1VIGNtZGxpbmUsIHRoYXQgb25seSBtZWFuIHZp
cnR1YWwgdnRkDQo+PiBzdXBwb3J0cyBzdGFnZS0xIHRyYW5zbGF0aW9uLCBndWVzdCBzdGlsbCBj
YW4gY2hvb3NlIHRvIHJ1biBpbiBsZWdhY3kNCj5tb2RlKHN0YWdlMiksDQo+PiBlLmcuLCB3aXRo
IGtlcm5lbCBjbWRsaW5lIGludGVsX2lvbW11PW9uLHNtX29mZg0KPj4NCj4+IFNvIGJlZm9yZSBn
dWVzdCBydW4sIHdlIGRvbid0IGtub3cgd2hpY2gga2luZCBvZiBwYWdlIHRhYmxlIGVpdGhlciBz
dGFnZTEgb3INCj5zdGFnZTINCj4+IGZvciB0aGlzIFZGSU8gZGV2aWNlIGJ5IGd1ZXN0LiBTbyB3
ZSBoYXZlIHRvIHVzZSBpb21tdSBBUyB0byBjYXRjaCBzdGFnZTIncw0KPk1BUCBldmVudA0KPj4g
aWYgZ3Vlc3QgY2hvb3NlIHN0YWdlMi4NCj4NCj5AWmhlem56aG9uZywgaWYgZ3Vlc3QgZGVjaWRl
cyB0byB1c2UgbGVnYWN5IG1vZGUgdGhlbiB2SU9NTVUgc2hvdWxkIHN3aXRjaA0KPnRoZSBNUnMg
b2YgdGhlIGRldmljZSdzIEFTLCBoZW5jZSB0aGUgSU9BUyBjcmVhdGVkIGJ5IFZGSU8gY29udGFp
bmVyIHdvdWxkDQo+YmUgc3dpdGNoZWQgdG8gdXNpbmcgdGhlIElPTU1VX05PVElGSUVSX0lPVExC
X0VWRU5UUyBzaW5jZSB0aGUgTVIgaXMNCj5zd2l0Y2hlZCB0byBJT01NVSBNUi4gU28gaXQgc2hv
dWxkIGJlIGFibGUgdG8gc3VwcG9ydCBzaGFkb3dpbmcgdGhlIGd1ZXN0DQo+SU8gcGFnZSB0YWJs
ZS4gSGVuY2UsIHRoaXMgc2hvdWxkIG5vdCBiZSBhIHByb2JsZW0uDQo+DQo+QE5pY29saW4sIEkg
dGhpbmsgeW91ciBtYWpvciBwb2ludCBpcyBtYWtpbmcgdGhlIFZGSU8gY29udGFpbmVyIElPQVMg
YXMgYQ0KPkdQQSBJT0FTIChhbHdheXMgcmV0dXJuIHN5c3RlbSBBUyBpbiBnZXRfYWRkcmVzc19z
cGFjZSBvcCkgYW5kIHJldXNpbmcgaXQNCj53aGVuIHNldHRpbmcgbmVzdGVkIHRyYW5zbGF0aW9u
LiBJcyBpdD8gSSB0aGluayBpdCBzaG91bGQgd29yayBpZjoNCj4xKSB3ZSBjYW4gbGV0IHRoZSB2
ZmlvIG1lbW9yeSBsaXN0ZW5lciBmaWx0ZXIgb3V0IHRoZSBSTyBwYWdlcyBwZXIgdklPTU1VJ3MN
Cj4gICAgcmVxdWVzdC4gQnV0IEkgZG9uJ3Qgd2FudCB0aGUgZ2V0X2FkZHJlc3Nfc3BhY2Ugb3Ag
YWx3YXlzIHJldHVybiBzeXN0ZW0NCj4gICAgQVMgYXMgdGhlIHJlYXNvbiBtZW50aW9uZWQgYnkg
Wmhlbnpob25nIGFib3ZlLg0KPjIpIHdlIGNhbiBkaXNhbGxvdyBlbXVsYXRlZC9wYXNzdGhydSBk
ZXZpY2VzIGJlaGluZCB0aGUgc2FtZSBwY2llLXBjaQ0KPiAgICBicmlkZ2VbMV0uIEZvciBlbXVs
YXRlZCBkZXZpY2VzLCBBUyBzaG91bGQgc3dpdGNoIHRvIGlvbW11IE1SLCB3aGlsZSBmb3INCj4g
ICAgcGFzc3RocnUgZGV2aWNlcywgaXQgbmVlZHMgdGhlIEFTIHN0aWNrIHdpdGggdGhlIHN5c3Rl
bSBNUiBoZW5jZSBiZSBhYmxlDQo+ICAgIHRvIGtlZXAgdGhlIFZGSU8gY29udGFpbmVyIElPQVMg
YXMgYSBHUEEgSU9BUy4gVG8gc3VwcG9ydCB0aGlzLCBsZXQgQVMNCj4gICAgc3dpdGNoIHRvIGlv
bW11IE1SIGFuZCBoYXZlIGEgc2VwYXJhdGUgR1BBIElPQVMgaXMgbmVlZGVkLiBUaGlzIHNlcGFy
YXRlDQo+ICAgIEdQQSBJT0FTIGNhbiBiZSBzaGFyZWQgYnkgYWxsIHRoZSBwYXNzdGhydSBkZXZp
Y2VzLg0KPg0KPlsxXQ0KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9TSjBQUjExTUI2NzQ0
RTJCQTAwQkJFNjc3QjJCNDlCRTk5MjY1QUBTSjANCj5QUjExTUI2NzQ0Lm5hbXByZDExLnByb2Qu
b3V0bG9vay5jb20vI3QNCj4NCj5TbyBiYXNpY2FsbHksIHdlIGFyZSBvayB3aXRoIHlvdXIgaWRl
YS4gQnV0IHdlIHNob3VsZCBkZWNpZGUgaWYgaXQgaXMNCj5uZWNlc3NhcnkgdG8gc3VwcG9ydCB0
aGUgdG9wb2xvZ3kgaW4gMikuIEkgdGhpbmsgdGhpcyBpcyBhIGdlbmVyYWwNCj5xdWVzdGlvbi4g
VEJILiBJIGRvbid0IGhhdmUgbXVjaCBpbmZvcm1hdGlvbiB0byBqdWRnZSBpZiBpdCBpcyB2YWx1
YWJsZS4NCj5QZXJoYXBzLCBsZXQncyBoZWFyIGZyb20gbW9yZSBwZW9wbGUuDQoNCkhpIEBMaXUs
IFlpIEwgQE5pY29saW4gQ2hlbiwgZm9yIGVtdWxhdGVkL3Bhc3N0aHJ1IGRldmljZXMgYmVoaW5k
IHRoZSBzYW1lIHBjaWUtcGNpIGJyaWRnZSwgSSB0aGluayBvZiBhbiBpZGVhLCBhZGRpbmcgYSBu
ZXcgUENJIGNhbGxiYWNrOg0KDQpBZGRyZXNzU3BhY2UgKiAoKmdldF9hZGRyZXNzX3NwYWNlX2V4
dGVuZCkoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuLCBib29sIGFjY2VsX2Rl
dik7DQoNCndoaWNoIHBhc3MgaW4gcmVhbCBidXMvZGV2Zm4gYW5kIGEgbmV3IHBhcmFtIGFjY2Vs
X2RldiB3aGljaCBpcyB0cnVlIGZvciB2ZmlvIGRldmljZS4NClZ0ZCBpbXBsZW1lbnRzIHRoaXMg
Y2FsbGJhY2sgYW5kIHJldHVybiBzZXBhcmF0ZSBBUyBmb3IgdmZpbyBkZXZpY2UgaWYgaXQncyB1
bmRlciBhbiBwY2llLXBjaSBicmlkZ2UgYW5kIGZsdHM9b247DQpvdGhlcndpc2UgaXQgZmFsbGJh
Y2sgdG8gY2FsbCAuZ2V0X2FkZHJlc3Nfc3BhY2UoKS4gVGhpcyB3YXkgZW11bGF0ZWQgZGV2aWNl
cyBhbmQgcGFzc3RocnUgZGV2aWNlcyBiZWhpbmQgdGhlIHNhbWUgcGNpZS1wY2kgYnJpZGdlIGNh
biBoYXZlIGRpZmZlcmVudCBBUy4NCg0KSWYgYWJvdmUgaWRlYSBpcyBhY2NlcHRhYmxlLCB0aGVu
IG9ubHkgb2JzdGFjbGUgaXMgRVJSQVRBXzc3MjQxNSwgbWF5YmUgd2UgY2FuIGxldCBWRklPIGNo
ZWNrIHRoaXMgZXJyYXRhIGFuZCBieXBhc3MgUk8gbWFwcGluZyBmcm9tIGJlZ2lubmluZz8NCk9y
IHdlIGp1c3QgYmxvY2sgdGhpcyBWRklPIGRldmljZSBydW5uaW5nIHdpdGggZmx0cz1vbiBpZiBF
UlJBVEFfNzcyNDE1IGFuZCBzdWdnZXN0aW5nIHJ1bm5pbmcgd2l0aCBmbHRzPW9mZj8NCg0KVGhh
bmtzDQpaaGVuemhvbmcNCg0KDQo=

