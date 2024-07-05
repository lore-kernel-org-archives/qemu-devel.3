Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908C7C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPefI-0006H6-MT; Fri, 05 Jul 2024 04:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sPef7-00063o-Kl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:51:28 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sPef4-00074d-Sa
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720169482; x=1751705482;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PMkbDQ+vd/ibnoKeFaToNJqv0H6eC40TgP8sfONpgZs=;
 b=mqpOjzaK2aFVuEk8Lqbi4kmwsJf+dwt4fAqvyioNPPBqsewoVbG1py4A
 d0KdyjxKOIqI8qag6MLU0cbi9B40Ol9IiXI2jv0MdBLQiMHO70/WG+xAw
 SWvN2uvvovHlzHFyaLEdKTWyHlOtilXQhN/cRxb732lkYBcKTrkKgVKzq
 2sITzmx+W8eq9FYgCcSnWqUU+p0kP21pcAIDRRPffcOzA4f6gUklIcx3n
 WHmBovMzXEbybOdlVAmzD6eA7E10ggY82p5Y0gdDUbrGKGNJokeVaXrEn
 ZD51RJB8rXOPKrBxIyaW3Cq/YivTkNTiuVfKRA41htqQQmpJYhMh4vnO6 Q==;
X-CSE-ConnectionGUID: a9XBGsFQT0qpPIylpQejFg==
X-CSE-MsgGUID: qlwnYvfIQ62Zx9VbhBMOWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21325878"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="21325878"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 01:51:22 -0700
X-CSE-ConnectionGUID: phEpOvUES5CUnUmiDqAGaA==
X-CSE-MsgGUID: wFUGlUjtRFyWNVWvs4oflg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="51770439"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Jul 2024 01:51:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 01:51:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 01:51:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 01:51:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 01:51:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh9LLgdxkekcs3Jee1sZFBbv8AnODm/lPHaXV2554Q6H4g0wIGOgiLlQxjk4Wzrp2aMIyXieDeJePBtwl34dF3IiF7sktHBqfj1HDNgD6ZbKnHC3CSnYHSrS8EtfUcss1I0Iu4AXlyP0SOxct1Zei6HreO/KNBpzRWcZjjgIkDopVVRoAbSn3UEI4MiTop/mehP+2UspIn5ECSU6QTZDtoy8YnNxuvIup5rKizANAKm4vJrjYF0xu6/vRjYmrm8i8OsoAqLvHJW2dGR4iIuDsYaKnZX8Bz42xGT1Yjclw0nBlTS/VEmB111Mw0Q5gYHHamhswJrs7ayPm4r+aShrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMkbDQ+vd/ibnoKeFaToNJqv0H6eC40TgP8sfONpgZs=;
 b=Y9CaPqdsfGQ+Px/Fgk/HYnVvBYlsDTAlctb0NCQKqtuFA/QHTSArpzk37RjnjhIQnr1FAZ1f4nfTGhq/vdqRpPDrsmbywzTqqtI5SsjTFSiN/9ZckPQpUAeUV7+bY3FSOJQIDU67STBPZU5L8IpLjlRGCZWY0eR0WluZRmd9hQong6hb3FMkcjWhhmPprs79SwlBmaHCK3KJwOffGEFKW3ceLM0gyqtooHcooeS3eIlMa1/CljyOlSa4CeMfCCP+RRTTZykAU2xhLDT8V5U8X1S/pnKRxZz2+FlRXtYJzJWFsA0DBGM33a1YI6ZzBWnRyQ1DA6/10mxlvY66kO7mvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Fri, 5 Jul
 2024 08:51:18 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 08:51:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH  v3 3/3] intel_iommu: make types match
Thread-Topic: [PATCH  v3 3/3] intel_iommu: make types match
Thread-Index: AQHazpimYumHqjSOhEagUatp7yyYILHn03aw
Date: Fri, 5 Jul 2024 08:51:18 +0000
Message-ID: <SJ0PR11MB6744DDE438D094FEB4F8A29392DF2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
 <20240705050213.1492515-4-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240705050213.1492515-4-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4848:EE_
x-ms-office365-filtering-correlation-id: bf70e057-03f8-40ec-e800-08dc9ccfa2ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?akVXYktEQU5yNnRaUXhZTWl6YVQ5VlF1V2Y1UFBjWE5vc0NVeW0wRWNqbUFI?=
 =?utf-8?B?cXVydE9jTmJla0NUU1ErS1NIQTE0YmFIa1dxTjlGTndwT3lBejlKUXBkcUZO?=
 =?utf-8?B?QnU3QXF2SmU4ZDZ0VFNrWkdNV2ZGbDJTcGVrV21tTG4ybVdoeEdIVnBYc214?=
 =?utf-8?B?TENPWDlWdld1YWo5N1RucWNYdCtaN3licUVrTm5uUFFLSDMxRVV0b3JJamZH?=
 =?utf-8?B?MHQ5VEQyQitBc0k5TzQ0RTZPT2hkdXBaRFJQdHVpckhEdWIrN09FbDJaV0Fw?=
 =?utf-8?B?QitrMmgyc09jVFdHcXRiR1JLK0xLWSs1cG9vY2RWUUNENHZ0L29pdGEwcE00?=
 =?utf-8?B?WDV3eDg4Mng5aU52bXpKMFByNFFUZVZ3SGQvUUVFRW00KzY0MnNMSEJ0Q0RZ?=
 =?utf-8?B?Y1lLTmVwNzErZTZMb0dXTk8rUldzM1NDNUJmb1pwRVFyTHdVSnFiK3hhVGZl?=
 =?utf-8?B?NEVOMFZWdkZpanpwZmNidGJ6Vkw4UzRnRlZDNDMrSnpqdjREeC9LQXhYYWdL?=
 =?utf-8?B?TlRzRnRKWlZXWUpxTEtFNXJWR1NDd1cwbGtVZXd6MmdhS3oxTzc5cTdQdmI0?=
 =?utf-8?B?emQ2blVQcUFOMEE1TmlqcXdKVjIycDZTSXJtRmxqMFY0MXRESk5QbjgzQ1Jj?=
 =?utf-8?B?TUQ1eFNYS2xFU0pJbHdZRDNUbDd3TEVZNjRaQThxWjdaUFczQnFHMm9nYm9X?=
 =?utf-8?B?cGJhTlVUdXFrNTVUMmNWUkhFbG8vSjBaTVFlSnZyTCtsU3Q5d3NSRk9mWGpo?=
 =?utf-8?B?ZExrTlZlOHZ6OHF2Zml6OWlpSVQwOWE4WXJZZ0xGbmZ2QmJjMzBqRGw0ckJi?=
 =?utf-8?B?NUhoZkQ3ZElXU3AvdHBDelFQaWdtbW5RQWwzQ0tIR3R5eXNIVysrR0RDUWFK?=
 =?utf-8?B?Q2hVOVI4Yk1ZK01MTlMvMFl6RHEvU1Z3NkNGbUY4UWc0ZXpTMFowU0dXRCtz?=
 =?utf-8?B?RjVlNVY4ZU5hOTdNT20rZ1c5Z0E1SVo0aG9LcEJpTnZ3S3lhOWNvRTJJK1cx?=
 =?utf-8?B?NkI0M1FjUm12RWE2V1lteDJTU0FwaUJGVDQyaXJPY1ZaZ3A5SVFuelFlcHIv?=
 =?utf-8?B?eHcrQktkQWY4MDljZ1FEQzNNcVl6cUprSWVySXJaZy9OUVZvcVRTbFJQZzlS?=
 =?utf-8?B?UngvZTVQNzk0dlpjek8xSTRiS3dNS3lqYUpDaEhyMXNsWnhxVFZYNVd4K090?=
 =?utf-8?B?SXFjZ3JFVzFKYkQ0UCtNdHJGK1cwU2U3WVAvNmNwdkl1OEFOeFczbE9Sdmcx?=
 =?utf-8?B?RG5XQVZUNHNUOVlCTEJVUUxPRDRqaHFYNVJwQWdDVTFOMWZJNnpqYkQ3MzhW?=
 =?utf-8?B?emxOTGhSS1dOaXdnQUhMb0thZTU0b0drUkRPR1k1a1VEVktwVjRST004OHov?=
 =?utf-8?B?cFY4eHMwZ1RETmhkbjhIdkxoVVVpVVl3Wkd4WXNDMm90STZibVp6bGxrWEZ6?=
 =?utf-8?B?WGN6L1VjZkdUTU1vZUF3U0g4clNsRENvMktQVUFIcUh5RFV2aE1rWmFYcnlL?=
 =?utf-8?B?UmZ0eEg4eXVaRDJGd3Y4SHF5R3F2bmI1QTcrUDNDeC9oNkUvU2JpdW81ZXI4?=
 =?utf-8?B?cHg4S2FNM29YNHZZaTNESkVPdWxMekMrUlZoTkZSMXRKZi9lYldiQTIyOWJG?=
 =?utf-8?B?WXh1Wlp6UjAxaTRleTdjWVlTUVc4QXFSaElsTzNtK2NuSUlQYWZLdFVXK2F2?=
 =?utf-8?B?RXRDVTBHSUFaMTdyMWhzRGsyTWNBQTAxU1QvZlJpZmxnL0ExSkdZSGNyM0pw?=
 =?utf-8?B?NnIzUlpIakllR0RhdXNhdDRWNHBaWHJwNlFNK0V6U080RVRtc0h6SUoxQ1hp?=
 =?utf-8?B?NkZLVG14cUZJTlY5c2lia1AzRGlEU3NIem1xY0RPTG5veVgxYllqSXBXZHkx?=
 =?utf-8?B?R1FwN0k3dzdBLzVMQktBaDBNUzkwdHlIWUV4K1U1dnJiR3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHp1eWhtZ0NvRmdWT2VjeTBpOE80amJwRkJKL0QwR0xwMSt0VFVJQk9jSzll?=
 =?utf-8?B?YkVZb085M3duT0lFK2M3cWpocGhsb1BwYWhRekFHcEZqSDh0NlkyUDNBbTJB?=
 =?utf-8?B?Njl3Z3VhbXkvWkpHb2xpTjNhc3FtNitEbmlYRDlDUFMxeHFXNGdjeFpPemh5?=
 =?utf-8?B?em9WbW8yZHgzaGdVcmlrSzVyS1pEY280cFJibFBnTndTRGFUQ0REQzZnRG8r?=
 =?utf-8?B?UWtFRUZtZ28vYlJoTVBJSUc3WGl6L3RWMmljNTVPNkJ6bWdUZXdBMy9hUkFz?=
 =?utf-8?B?NG1idHBFR0J3ZStlR3BUWk5FcExReFVZZE9KM2R0SmxITEJxZngzWFltQ25C?=
 =?utf-8?B?M0EyWEFQSVNndXV4bVhUNnNvckd6bDI4TDlUcmhKTE9lbkc0QXVnWUNRRHFr?=
 =?utf-8?B?UytDaUQ1YmlpazZ4Uzc5QjUyNnpsQTBsZ3psNkFxbjlnU0NTRUFuOHIyUGJi?=
 =?utf-8?B?NWRtYmJyYmJxUHdpNEE0N2pjMXJlbks2R3FRSXVBSVp3T0JZRERhSFR5MTFp?=
 =?utf-8?B?T0JiK3EzMElzazFvS01BcDA2NVlZdzdta0lna0JVNlVWTkl6V2YzN2xiWmE1?=
 =?utf-8?B?eEprRXBuamxxc0l6S3p4T1lyVDNsWEo5ZmVTcDZmc1l1cEV3aVdSbFBEODgz?=
 =?utf-8?B?OGI2bFpvelJSb2NFNzBRL0UzK29hK29Ca2dNaVBNRUVHSmMwM2VRSXl4ZzFU?=
 =?utf-8?B?WEZ6WXdlWjk3eVdHWTZPbXhJd1l3Snp1ZXNtVkNpSGMzUnl3YUo2NGJnc1Rv?=
 =?utf-8?B?VTF4KzNYSTFYUHRQLzE1cVVWVUJ4NkpPTnJzS0d2UWlQK01DYUJmNnA0cEhH?=
 =?utf-8?B?K2l6U2xGcjdGZG9UYXRsR1p2MXJCNjNETUk0VnU0OVM0OE5HcDh6aDUyVnVn?=
 =?utf-8?B?Z1Bod0VUTGNiRFJuTGhrbGxqZ0FXdWZkWjJwbmpVL3doN1JIb2gwZzBFZDZp?=
 =?utf-8?B?RmluN2ZJVjhUM1MrOGsyalJIeGxMZW1XTks3NzFRdHpJNkcxT0JGeXN3QURS?=
 =?utf-8?B?RWRHVlRCeTh5aThpekN4ZVp0NU1sWmwvVUFrZGNPdGE4NXE4b3dxZUtERG42?=
 =?utf-8?B?MTgwWkxKdEcycktOT1lxR0VvYTR3czBqeE5BTHg3N2RST0ZOR0hnZ3dlQmZ2?=
 =?utf-8?B?ZllXWHZ6ZnVpTWc3ZlNSRE02KzR4dVY4bGRUVFZuNjQ5SEFBejFnUVNzbXlz?=
 =?utf-8?B?MlhmOG96ZVBZTW04TmF4cnpzS05mK0R0THNFQU9ObUdORTlpMWMwejkvdkU0?=
 =?utf-8?B?UFc3WHhacWhiRUtUTENwc2dZUFZTbFFCZkJZSlFyMmV5UXdBOFZ0ekZZRjdW?=
 =?utf-8?B?aytJdUc5V0EvWnkvOU9jWW5Yd0w1cEdKS3ZHdFExN1c2aldWdHc0WEtaL2N2?=
 =?utf-8?B?KzhIODFOWTdTdVVpYlVZRjVWU09UWWFXT3Z3d3BiU1FzclAwUHRIWUVhZjJY?=
 =?utf-8?B?eUlMZVZXMzVSd1QveTQwbnVHMTk0bjRSSjVucGU1NUJFM1drbW5CTEVYSnRU?=
 =?utf-8?B?aVczMFp4UHFPUVh4S1VLY1NtOXp6NGRhYWhHNStuVGRKMXFzOWNsQ0lXTzhk?=
 =?utf-8?B?dVpCdWNaZDF4Z0p2NnA2TkZMNnBLUUw5NzBET09FSkdUNEg0b0w1NEN0VWNJ?=
 =?utf-8?B?RmR2UGluUHN1YzZrbjloVXlQcHRpMDRpV0dBQWNFUUtkR213andCcTVMc2FF?=
 =?utf-8?B?NzV2S1VZQ3Fka2lZMU1Ja0RCQmFZRVNMS3FXaU1wZ1RUVDhFZ0FxR2FoSG1j?=
 =?utf-8?B?U1hiZmdkZitUbGRlK3RQN0ZiS3NraEQ4cnp2OXlxQVdTZVVQM3hPVVZFbTQ0?=
 =?utf-8?B?YTN2Z3dsUG1XS09MQ3pUMkI5dW5FZ3dpQVVCTlBleXN1Yk9tL2IvYnphQnFT?=
 =?utf-8?B?blNTa1lZN2drSzBaTjRnb2NidjA1ZUptTTVjWmhqbSt5SnROak5OVExmR3hO?=
 =?utf-8?B?MHpQV3hIcVBPN1RQYzlBZHhqWG1hZEp4cDVKbmVMMzNrR0prZjJjQVRoSUFK?=
 =?utf-8?B?Sjh1ZFRaTEI3R2xHOC9HeDJsSmJvY3RVclpiMWpVeHhZeXpIcGQ2ZlUrbXZl?=
 =?utf-8?B?Q0J5MS96SnBKT0ZtMnhYVEcxclZHQ3JUMitwS3ltYXhKZU5sNkExS3RrUm92?=
 =?utf-8?Q?NwRjUMcdydzXQocl0K/RZlouZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf70e057-03f8-40ec-e800-08dc9ccfa2ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 08:51:18.6182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62emFXtJju5TIY7DUUcF6Ka439b7IDYGZqE/+0gNjmS1RWcC9vVaW3id7ok6xFelQgp7n/BwB2T8YuQuptuITpSLX1UeYeoKiyho5pSVcm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogW1BBVENI
IHYzIDMvM10gaW50ZWxfaW9tbXU6IG1ha2UgdHlwZXMgbWF0Y2gNCj4NCj5Gcm9tOiBDbMOpbWVu
dCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4NCj5U
aGUgJ2xldmVsJyBmaWVsZCBpbiB2dGRfaW90bGJfa2V5IGlzIGFuIHVuc2lnbmVkIGludGVnZXIu
DQo+V2UgZG9uJ3QgbmVlZCB0byBzdG9yZSBsZXZlbCBhcyBhbiBpbnQgaW4gdnRkX2xvb2t1cF9p
b3RsYi4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50
Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4tLS0NCj4gaHcvaTM4Ni9pbnRlbF9pb21tdS5j
IHwgMiArLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4NCj5kaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+aW5kZXggMzdjMjFhMGFlYy4uYmUwY2IzOWI1YyAxMDA2NDQNCj4tLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4rKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj5AQCAtMzU4
LDcgKzM1OCw3IEBAIHN0YXRpYyBWVERJT1RMQkVudHJ5DQo+KnZ0ZF9sb29rdXBfaW90bGIoSW50
ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBzb3VyY2VfaWQsDQo+IHsNCj4gICAgIHN0cnVjdCB2
dGRfaW90bGJfa2V5IGtleTsNCj4gICAgIFZURElPVExCRW50cnkgKmVudHJ5Ow0KPi0gICAgaW50
IGxldmVsOw0KPisgICAgdW5zaWduZWQgbGV2ZWw7DQoNCldpbGwgaXQgYnJpbmcgYW55IGlzc3Vl
IGlmIGludCBpcyB1c2VkPw0KDQo+DQo+ICAgICBmb3IgKGxldmVsID0gVlREX1NMX1BUX0xFVkVM
OyBsZXZlbCA8IFZURF9TTF9QTUw0X0xFVkVMOyBsZXZlbCsrKSB7DQo+ICAgICAgICAga2V5Lmdm
biA9IHZ0ZF9nZXRfaW90bGJfZ2ZuKGFkZHIsIGxldmVsKTsNCj4tLQ0KPjIuNDUuMg0K

