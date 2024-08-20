Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB122C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 02:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgF1J-0007es-3N; Mon, 19 Aug 2024 22:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sgF1G-0007dj-Uo
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 22:54:50 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sgF1D-0005gQ-OJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 22:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724122488; x=1755658488;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KJx3v9OZLGZ9VcyeoKUks5FzXjfqTLsxhrs+Vxf6ZxQ=;
 b=DbxfLkGrQcNP5CAzm/14Yew0qMjTahwNzjCxIsuH5Vlu4GXuUtbbLmxB
 djN5MNXPrGhC2LqRBpha2UNX1ddu2d5agq+MzUCYdzvGS7xrVEHjWLPZE
 AislFan4vhkHFY59cqZEZ8KHuCOtAx7iN+sieO3j31ZrRe6/+QlVRNGEF
 5/VzQROr+FjX8Nq20Ur3r9WggoOPICbFF2uQgWX6dMEyToFlI+bx2qCGB
 Cw5R47VlwsYP6TrqpPoN6sLg96wmHDPlRgO/qXqUUejeSAJgl7lJ3L2Fu
 D4AEhDqfhIrAiwvfy8CDGncBRAXQUAW5QXijg+VUa+tpE3HsIo4sDM8Pw g==;
X-CSE-ConnectionGUID: KqKvdfczSZqzO88aLvXTIQ==
X-CSE-MsgGUID: TKUEZd+1S8iT9bv3v1bedw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="47793860"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; d="scan'208";a="47793860"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2024 19:54:45 -0700
X-CSE-ConnectionGUID: 0L9xf6bXQGa8owFrpgH2qg==
X-CSE-MsgGUID: wiFljErVSYW+8Nk4C6Wn7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; d="scan'208";a="98039878"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Aug 2024 19:54:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 19:54:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 19:54:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 19:54:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9s6CDhxHna+XnRhiQfOXHhCCgq0FRJi/J+tGklf/4slqq0kJUqSj1RZu5TOABjQvNHJO28/AbaI9zLuQJ9XUW3zUIqO7cMDOOX3mA5IQO+Da+L8li3hDqxzY4NcK6BGmJAzA+z+MlFPN6CqHsAFrf4aX9tM3mk1zyKMSOH0YMhViTG9+jPX7SuV9h+57lY6ry2MEVgGGefwaa2QUi72dulAwViOM/zRORAzpoEed3fzKGbhP4kvTe81gwEfGJ9Kgq+d/9MbDfeaWNJfe9+GUAiaSRq0qSABWkJbUNfffPl/HRWnCRhbLxo+f3aPadJDqUCll3UmqwrslFx6951hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJx3v9OZLGZ9VcyeoKUks5FzXjfqTLsxhrs+Vxf6ZxQ=;
 b=q3J/xGgvAKKltHUOxYYsB2lqfLX3MUb0VquDLNM1j59OR8q22+idegAtMRIL7wcFVmb7Vw9UXwW0BQkEjzCaCuah6JeWh2/azMOu7g5DSvmSPi9CFPsG1i85dXd4CZ6hPXjoLx7BReZAOBfXeJ2YreCIRmJw3aEJJvAjtEXOGEhjsFtew6Oa0Lz9UY2C9EKm2MLaDO9vGTttxFeiPv7xcIQIURpPNecwNcHIEJaSeHk6YZRtEtCRA/5ow1TbSXYGYtb7shqqOBg408tdWFLcICFdJi27KoCrycdXk1VgcmfHN8qdJaX7wRsmbA/7FfyVqsKO2aVyqiYslYXp14E/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 02:54:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 02:54:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 13/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Topic: [PATCH v2 13/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Index: AQHa5wEaw2m2jAjze0GI1QuvEcklKLIuaD+AgAAFMzCAARoeAIAAAu6A
Date: Tue, 20 Aug 2024 02:54:41 +0000
Message-ID: <SJ0PR11MB67442FEAC1020BA17484CD4A928D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-14-zhenzhong.duan@intel.com>
 <1a3d2c06-1c73-4b4d-a531-bd39007088d9@intel.com>
 <SJ0PR11MB6744CCAD824F111844C5A087928C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <22c3b127-a521-43de-a34b-ae4ba39af35b@intel.com>
In-Reply-To: <22c3b127-a521-43de-a34b-ae4ba39af35b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7622:EE_
x-ms-office365-filtering-correlation-id: 5ebc8405-5022-47a6-2360-08dcc0c37040
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YnN3cTRteXdoY1pyS0lyaS91dTh3VWdBa1NZUXZ0Z2RycEpMNGRZNVN1MFlh?=
 =?utf-8?B?RGE2UUhodmtSVm5Ubk1RR2twSFRoUGNsQnFVVE1jR3ZHU3pjWlBxV2VwV1VE?=
 =?utf-8?B?c2RUbmRpQitXa2dSdTQ4ZDNGT1phdE9rOXB3VmZKRjZXWENRUE1MQ08vL2t1?=
 =?utf-8?B?U3NDelIzbE12ODh0aEo3bnBXcndONHZoT3ZoeDV0YjJLeVFnR3BZdVc3YjlQ?=
 =?utf-8?B?cVBJdVNSeEhyUWpseDg2SngyRW12eWNmUzhJTXZ4SVNjSEFTTUtFY2w0Njk1?=
 =?utf-8?B?T3pjTHNmYU9ZZkNjTGpBMnA2QVNBY2Z1UWdiZWdxcEtISkxiVXBHUUFyL2hM?=
 =?utf-8?B?YWExUlRabFkvcmswN3F1dlRHVm05c3RiT0drdUtFcTlaNWU1VnpWc2FvMDgr?=
 =?utf-8?B?UXdHZ2pRUERNOWpPZEZJbFh1ZXkwN2Urb2I5MlBKUUxhWXZxQXdxMVNsOFpx?=
 =?utf-8?B?a25LZnhSL1Yxem1XY1l1VjY4ZTAvYlJJTEVmTlVsc1Q5OFBHYjdQdTlleUM0?=
 =?utf-8?B?dFpoU2U1ZUh6RVlWdE5BNS9DMVd4ajVlR0ovRVp2ZE1OMWFJTnFpZFBERXFU?=
 =?utf-8?B?M2RnaitLUUpJZ1dxRDVPbFVSVzMxZ05neDdFczFDMjZxTFA0cit2MnorOWZr?=
 =?utf-8?B?ZSsxbGNGbUUxVFhOb05oVzRreUc0MG40VmN0eUJCWUdrY0FZS1hLNTF4MVZh?=
 =?utf-8?B?dERxRmxzdmZNODdiUEJsM0dDQmc1a2pEQmNmcEVlTm50cDl0bVBTenM2bXZ5?=
 =?utf-8?B?T1psMDNxTWh3U2NRaWJwb082L05aRUg5enpzSk51dnphYS95MXorU05TV21Z?=
 =?utf-8?B?aDlJMGE4ZjI4cllsMWc1czU1VFQ4cEVFeXFEVStMVDlKMjZ4M09kK1Qyd01m?=
 =?utf-8?B?aTk5U1l1NUxpcTJhaUE0anZSL2ZnNVA5SDdyM052S0tjYTFIOHovTkFteEVY?=
 =?utf-8?B?b1FpUDU5ZlAvb2tuUFVxcmtDZm9NYWlMVGRJTllFRWx6VGhZSW44ZUhlTFlU?=
 =?utf-8?B?emM0emFFWWE0MXRubmxNTjFpTVEwdGFKVEQ5c1FqZ05iQnlsYmlVOFpYSE55?=
 =?utf-8?B?VkRiRTczd0ttWVZ2SnBaakRram1ETEphRDBPcXZuc0RhT1UveVRvRkF3WlRs?=
 =?utf-8?B?UjlacXZtNFllazN3N3VUUzJBOVFxVTUwZ3J0bFdObGIyWTQvcEFxWmxMVUhU?=
 =?utf-8?B?K0hFRE1RY1ZvdzFxM2N4VkM3SzdjdTR1emNSNWszQVJDdGJ5aWxja0hiUUpV?=
 =?utf-8?B?OFhWbDZhL3BEa2Y1bElVdkVOWklUVmh4YUJpZHVIRlo5c1RhakI1cXpHNDhU?=
 =?utf-8?B?WXZqY3N0L0pab0JXYmlXaXRKQ3ExWGN3dnJOb2dTU0pWNmY4V2tnRTYzWDVa?=
 =?utf-8?B?amlJSkZVVlhzRCsyL1JoM00yY2w1bXRnL1UzQTdOWFZLUk5CZTJvc3ZmWWh4?=
 =?utf-8?B?VThHZDdiNWhLZlovcnh1ZVRYMUY4MmtUR1FRMDF1OTBNSG50eEdvVDJMejRD?=
 =?utf-8?B?NzFvc290SDEzNGUvNXNtWUY3Z1o5dWUzOVdRNERVdGNacWZtT2E0UVNqa1Av?=
 =?utf-8?B?NEtyem1YeXprNjJHSjlMQmtHeWhacE0wQ3JCMmJ4dzA4cUtmdWpDZExTVjVh?=
 =?utf-8?B?VDVXNVRqcWQ3NDVLKzVUcU4zejNLbFVxNUZxTWN3YXRJTWR2eVRkSW9TRnNM?=
 =?utf-8?B?SEVlSzVLcVQrWUljMDBQVWw3RERXTG5BWlQ0VkhWbHpWMnFnZmFyNEdTM1Vr?=
 =?utf-8?B?Mk5FSFpqRkl2NkhNSVpJbFZsWFBIdkZoNHN1SDV0TllGNVAyc2s2L1JvTndi?=
 =?utf-8?B?WXp3aEQ3eFNaNzV6MEF4UDN6TXpBSDl5ME1Wa1VuUktwa2lnTnNNc013NEZ1?=
 =?utf-8?B?MXZKQXliYndrWkFiTTdHVGJrUjdvTGJoNStwT1JJV1JHRVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anBIRWVMR05OeVJTdEpLN2paMi9nUVVyZmZ0NVBhWkdldmtJRnNqb2h0K1hQ?=
 =?utf-8?B?SzVKUVJIcDhRZStDMTdiT2RvR1IrRERjY0gzQ1RNQU1KQmZLMk1TMmVlRStT?=
 =?utf-8?B?dFJxOFJJSGNES1E0UTVBcEljTGQwV3cxckZ3dWQyd2RHWTJ5TWtxODVKOE9M?=
 =?utf-8?B?VHJOR1AvcmpBUm5GSWJxd2VpTGxoSlJ5ck1EZHR5Wk9waFkrK3lPaHRFUHlI?=
 =?utf-8?B?bmd6SGRSMmVLWDJ4d0tlVjV4Y1dpQ1VXZm1nS1hpMGZZQmw0dHJkUDRNRVYv?=
 =?utf-8?B?RXZ5eitaR0RheDc5dlNCaHRSNldkZHlIUUg3ZVZ0SDkveTBkUTVnQVREWmRJ?=
 =?utf-8?B?REVWeWlsTlgrZmllWndUeStmWEtTYWYvcTEvQUV3VmlCWjZIR1JyYTNSN1N6?=
 =?utf-8?B?dy9WaTExSnRxdFU1WTd5OGRmR25zY0FOVWk3UmdidUNpcUdkOFhwUnNDZTUz?=
 =?utf-8?B?NlYvV011TEN3SFUzbjVGdjBBckZzak1DODJYNkoxT3d0dFJ1V1p1VWNmVHY0?=
 =?utf-8?B?UnFWaU5nZXRFN3h0UHQybk9YRWVRZ3UyakZTMkQ2NStkUnpXbGgyMkRLSFlF?=
 =?utf-8?B?TXEzdEw2ZGx1OWZHc1Y2Nnc0c3pqOWkrcWV0TVd2ZzlOOWJzQm9jY1NWT0c1?=
 =?utf-8?B?SFY2UWxvZmtOYnVzcUp0TTlmNGhxdjhqUGVBaDNUYUZwL21MaXo3ZWdUdEtS?=
 =?utf-8?B?SWRya2pCZ0FIc2k0dEpFZWF6ejVMRUV0NnBST2Y1SngwSVN6UE55WWRHaUdm?=
 =?utf-8?B?NjlyTWRmMzBCWUFvSlFYYUlxeEhTdzFsdysyVFRjRTBzUmxrYnVRd3M3blh3?=
 =?utf-8?B?V01GU1ZQdnk4S0lBV1Q5YTQ5eDB6R05MY3h0RWZyUUM1M3hxNm9KS2g4bTJS?=
 =?utf-8?B?bmVRMTM1cVVOZHdyZXQ1ck9FRjh2T04vZ2ZScWRHUUtzYkpzQVpGRWlna1NJ?=
 =?utf-8?B?dnZGcUc1VXJmcmdIbENya0RxUjVXWGZRQmhobUxUS0xCT0JheENvbm9IK24w?=
 =?utf-8?B?ZjdNdUpEVmwrRW5CeDdNU203ZkI4NjJSbEMwaG5EWnRXUDN3N2RvM2dSeHBq?=
 =?utf-8?B?ajUzZytwcy9Zbnp1N095YzA5L00xTyt6b3BscmgxYzBkSS9TYTRXMDVaRVAx?=
 =?utf-8?B?UGxvZDFTZDRmeVdCb1dkSmdVQjhHWmdtcGNuQ3pITEV1cnlZc3UydHpJdTZU?=
 =?utf-8?B?OFJmVjZPYUgzeGJCaDhhaFQ1NHZZSUdEVlFPRXVrVWZJb2l5ZG1saE5NKzl2?=
 =?utf-8?B?Z3pLSml2cC9yai9hR2dCV0FreEhVcG8yemNmTTN5S3ZLR3MzVU92MnNpNlFm?=
 =?utf-8?B?YnVnSmF1KzBKNG92OEU3Qm5pMTdVdGxFdEtSYmp2ZzVSQVI3ZGMzNDliaWpN?=
 =?utf-8?B?M1ZCc1dDZnIwUGRZTW8vWVZRNzV2YmsrVkFjRS82ZHRlU0lKTjZaemhEemxV?=
 =?utf-8?B?eVUvNk9oc3J0M3F1ZHJ1dGpTYTVuRGpGa2NFRGZnQmIxVDF0TjNaZHBwKzNQ?=
 =?utf-8?B?UUl5WHhFY1J3ZXNmU0haTlExNHZ6cDUzZkl6b2NmUTNnQjllRDZMVnNVL1Nn?=
 =?utf-8?B?eHc2Rnk4ZG56cEhBUEZmbDVSVzd6RU5JeHI2b0VJYVBTVkxBQ0Z5eG05MnJM?=
 =?utf-8?B?YnhsWVlqU0FWWEZPRlNPbWdKU2x6U3FFZk1waXNLM1pMNmtCRGJ6OHMyL1M3?=
 =?utf-8?B?by90dUhjQWIrV2gyWW9GOHFaSVRxT2VkUlZOaS9Qb2tUeFNJR3ZpZmVsK3hh?=
 =?utf-8?B?WXFFZHZNQjZWcW95L1FuQm01RUFCTXVINjdhS0FWVlY1SisxUXZVek9XakJq?=
 =?utf-8?B?UmRoemZlazBRd0JVVk5tWjlhWU1VWHZWdVFySXJlT1l1a0g5cmhFUmNTSk5U?=
 =?utf-8?B?UFVWbnI2bVJwNHBkVDVOcGhJY1JZNTIwbzBVc2VTUkRaNm9sM1k3Rmk4Zk1i?=
 =?utf-8?B?dklYb0xNWVZoYVM4ZjNPR0xUdjNTL3QrckwrK2oyTitlNVM3WGJVK09DbWhm?=
 =?utf-8?B?WFMxOWExTmlWcUtWdUR3cjVaMHlXTmNBcTBTZ3BaVnA2YnFoS1pmS2dZbVdY?=
 =?utf-8?B?T1JBeTZYNExTY0lpdzlVMlZwSDQ4Q1Z2NU5xNVF1cHA1UG5KZytET3ZzRUxi?=
 =?utf-8?Q?t0TpjGFH14QT9aHaXSbE7Yl9O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebc8405-5022-47a6-2360-08dcc0c37040
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 02:54:41.3988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3CcBs1L/FnCJvj63k4DhiFu6eoblhcBcU48VNBl52mczFmFnjafSvjt5ctzZtjqF5Dp/VcgxD1LXvzzOuvPLZhFFoMCsDBGavoQ1UQ7wxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTMvMTddIGludGVsX2lvbW11
OiBwaW90bGIgaW52YWxpZGF0aW9uIHNob3VsZA0KPm5vdGlmeSB1bm1hcA0KPg0KPk9uIDIwMjQv
OC8xOSAxNzo1NywgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEzLzE3XSBpbnRlbF9pb21tdTogcGlvdGxi
IGludmFsaWRhdGlvbiBzaG91bGQNCj4+PiBub3RpZnkgdW5tYXANCj4+Pg0KPj4+IE9uIDIwMjQv
OC81IDE0OjI3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gVGhpcyBpcyB1c2VkIGJ5IHNv
bWUgZW11bGF0ZWQgZGV2aWNlcyB3aGljaCBjYWNoZXMgYWRkcmVzcw0KPj4+PiB0cmFuc2xhdGlv
biByZXN1bHQuIFdoZW4gcGlvdGxiIGludmFsaWRhdGlvbiBpc3N1ZWQgaW4gZ3Vlc3QsDQo+Pj4+
IHRob3NlIGNhY2hlcyBzaG91bGQgYmUgcmVmcmVzaGVkLg0KPj4+DQo+Pj4gUGVyaGFwcyBJIGhh
dmUgYXNrZWQgaXQgaW4gdGhlIGJlZm9yZS4gOikgVG8gbWUsIHN1Y2ggZW11bGF0ZWQgZGV2aWNl
cw0KPj4+IHNob3VsZCBpbXBsZW1lbnQgYW4gQVRTLWNhcGFiaWxpdHkuIFlvdSBtYXkgbWVudGlv
biB0aGUgZGV2aWNlcyB0aGF0DQo+Pj4gZG9lcyBub3QgaW1wbGVtZW50IEFUUy1jYXBhYmlsaXR5
LCBidXQgY2FjaGVzIHRoZSB0cmFuc2xhdGlvbiByZXN1bHQsDQo+Pj4gYW5kIG5vdGUgdGhhdCBp
dCBpcyBiZXR0ZXIgdG8gaW1wbGVtZW50IEFUUyBjYXAgaWYgdGhlcmUgaXMgbmVlZCB0bw0KPj4+
IGNhY2hlIHRoZSB0cmFuc2xhdGlvbiByZXF1ZXN0Lg0KPj4NCj4+IE9LLCB3aWxsIGRvLiBXaWxs
IGJlIGxpa2U6DQo+Pg0KPj4gIkZvciBkZXZpY2UgdGhhdCBkb2VzIG5vdCBpbXBsZW1lbnQgQVRT
LWNhcGFiaWxpdHkgb3IgZGlzYWJsZSBpdA0KPj4gYnV0IHN0aWxsIGNhY2hlcyB0aGUgdHJhbnNs
YXRpb24gcmVzdWx0LCBpdCBpcyBiZXR0ZXIgdG8gaW1wbGVtZW50IEFUUyBjYXANCj4+IG9yIGVu
YWJsZSBpdCBpZiB0aGVyZSBpcyBuZWVkIHRvIGNhY2hlIHRoZSB0cmFuc2xhdGlvbiByZXF1ZXN0
LiINCj4NCj5zb3JyeSBmb3IgYSB0eXBvLiBzL3JlcXVlc3QvcmVzdWx0Lw0KDQpBcHBsaWVkLg0K
DQpUaGFua3MNClpoZW56aG9uZw0K

