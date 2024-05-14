Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42080C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 08:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6nnv-0007SK-VP; Tue, 14 May 2024 04:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6nnf-0007Qq-E0
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:46:24 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6nnc-0005iU-3P
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715676376; x=1747212376;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=y6NnheIwb/lCnxy7d2Z9LtkNiUfu3ZZNeyhvljP5s10=;
 b=UNK2mqYFS9f2DKUMh5V8fkOJGvofVjmRdswysl862VP9PPcS0w52tDyY
 8O15vXbdYOyywA8r1orkWKb8ZSw609mGdafVwYdSd71G+U3XOfmRzDCc5
 zZXMqNcYWMADPjoAc7YyTpk+rgi+a5KAa9HSRFci3II9QFMTTRen7ndpC
 KLH8xfjwFmKDBtXw8aT6kfbFFxAe8famxpjQE0eRsn6MXM3OnCEcDldcO
 a0IxJzS2KHLVd1Pd9w3t4oixhYrc04KZcqeAehAkBO9DUY8EcHaPw2Flr
 9aw2KAx6zo0SvxKYMuOLA93jG1hMB8RJiqIj+e5o3Q2eKLvB+uJVz4D3F Q==;
X-CSE-ConnectionGUID: VJAiBDL0SMOqAqlH4uZR0w==
X-CSE-MsgGUID: 0tiCcPwlTmqGjfojI6jHDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11478250"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11478250"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 01:45:57 -0700
X-CSE-ConnectionGUID: bWvtBTbTQjySX5meNr6UyQ==
X-CSE-MsgGUID: +PVuTmrcSOK5jdnNTjcSjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="35376166"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 May 2024 01:45:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:45:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 01:45:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 01:45:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3fANGqDjD/XHiS0M9Q1J2mWg3SAtMlISY1l8hjUIvr9TSqcvN1ppGGtKBc/7dx2iIZVJS2G2osdzn/Tl4cMVBAeuLY8QthDe4CboA5djwM/za6m1LUA386z56f7TRy7NhfVzvfkSkJOVcPfOjF4pkEF3fZozY0upiRx2O+R4bQ9SiaSm69APVlRHg1j4PPdf6NH3N9gCBA9jBoKEMxjENN3Ih7i8TLHU/yF/Fgo8KW7K+DuSW79xZMnIVluVTGH8sCpplA+vkFHYf7oRyWc6J8wJsQjvNnue1qQZiXTa+cW4FBdIKSZa/AxOevVK0bOQL3IUG5f744M5IHESMKDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6NnheIwb/lCnxy7d2Z9LtkNiUfu3ZZNeyhvljP5s10=;
 b=VZMPLzstDUemm/tOuFsNDtQ96O+FaHCGyzMcobQo//p9cXlJJoI8HoL3WVIjXSaWs398HDL7h6hmCi+8LCjB4owhLUW3uooUG8hmc95MUe8WgBWp52nUKQrTcXDJjL01W2iuiEwm17c6ccgvRRQMYvg8wgE//Xlvg7MtxFT7Q9+NKHGyAepCkN1VThML4FidpL7M43RNPMDTLNmyI2zcoX3vzp+DRVcnssXhAY4qtZl2jHOPqGCzrf+l8ckX39REixMu066MrUbgYeoXOfiJtK5hg5SgG9jx4B0gSXn03ZY3ugY2LeaTxMdPyKogCJXKprmCjFX6yMupEAF074mjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6305.namprd11.prod.outlook.com (2603:10b6:930:23::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:45:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:45:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH ats_vtd v1 09/24] pcie: helper functions to check if PASID
 and ATS are enabled
Thread-Topic: [PATCH ats_vtd v1 09/24] pcie: helper functions to check if
 PASID and ATS are enabled
Thread-Index: AQHanKWLAihSr+nJGUeruRnwzhpUkrGWfMyA
Date: Tue, 14 May 2024 08:45:52 +0000
Message-ID: <SJ0PR11MB6744571C476EF524BEDBB83C92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
 <20240502152810.187492-10-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-10-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6305:EE_
x-ms-office365-filtering-correlation-id: f509e384-c8b6-4815-f106-08dc73f24351
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OVlSWUI1bGUzUmxiQWJPd2crdE9sdWZBVDRGOGo0UUhDbzVjdGVNWkpqRmhu?=
 =?utf-8?B?aE1vYzk5SkRkSDNxOHpWQXhaWDJwU295QW5ycHk3RnQ4U2F1TzVBNWFXODh6?=
 =?utf-8?B?clVyNTNiOWtaSjRIZGZnaWtuaUFzOGRhbDk3WnNvUE0wVUt6M1REaEJQZU8x?=
 =?utf-8?B?T3J5eFJGeTJNTjYxUFhoekh5OHRxV1NMN1lBZnY4VjBCazRpQklORHpKaURu?=
 =?utf-8?B?cngxNCs3U2ZKcnQ5V0lmMDZrc3FYM1dPdWVuMThXTFpCOHZpUzhydEp2UHBR?=
 =?utf-8?B?andjZ3hPalU1VllZWmluTlZIRlVpaFFJSURSM0xlVUFSbXMwcFBHWnpicXcx?=
 =?utf-8?B?dFNId2Q2d2lQbnFnTElIRlF2NFZkMngzRnpocDNaeHpHRE9sTnZEY1Z4dlVa?=
 =?utf-8?B?alNpZWg3ZmZWQWlybGdNd0VGUjRBT29rY1dDUElZejg0em5xUDNCWUR1Ujht?=
 =?utf-8?B?TVFhSVBPcCtLYWpzdkhIOFp5YXYweWtwQ2liOGw0Ujd4ZlJxaVMyYStPTFFl?=
 =?utf-8?B?R0REblVzZEh0eit4R3p3T04zQS9xYjlSL3hRTS9DNnJZditaWWNtQk45eGIz?=
 =?utf-8?B?WGVEY1pITFZCNUNlak1IVng0eGZmZzRhcnZvY0d3aU12VXZXWUNBUEM2MTJB?=
 =?utf-8?B?RlRUYWJSSVJTWk82MmVEZ1ljbEJ1N29nQUFMMDB0OC9KV3U3aC9KTnNWUDd0?=
 =?utf-8?B?Y09TTWNkYmkwMUxMTVhnUFFQNnl4ekhRUWpKM0dJb1BDWmJGc3pmZ1ZESUFQ?=
 =?utf-8?B?V29ueVduK2Q0TkFhLzYzdmQ0NVk3T0I1bWhxcDArZ1hxVDlEcXlmNXZNeUJs?=
 =?utf-8?B?MndPVmp4amovOTFWLzAybUYwMXM5aW5qTGtUa21PT0FablNNTlBZdjBZODhX?=
 =?utf-8?B?MmVJMzVsQktyQitzTkE5ZmJOaVM1TzV6QXZ3ZnZ3aVFHUjlMWUFlOW4vWHJh?=
 =?utf-8?B?UGNDci9tcTNFNWxiZVAvQ01qMWVoQmtwMDhXU0N0OHhxWEl3TVBzWnU1ZW1G?=
 =?utf-8?B?eGRwS0RkYU9wRERaQS9paGFMbHpZa0s2cTFpVjN2MHJONm1nZUp3VU45KzEw?=
 =?utf-8?B?Z3AzY2FMcVlWTFdnRHB1RjZPREN2eUJzdUJDUVgrNDVvVDBRN1NxMTEvWml1?=
 =?utf-8?B?R1UySG5nUW1sOW9hZWdnUytxcXVNT0E1VUdwSklMVTFKRU5KWXBpZ2RrRlBD?=
 =?utf-8?B?MUh3NDlYekJyU2xTTmJWRnplb09KdGNGdWxkaVdnbWJ5ek5va0traklrUlpk?=
 =?utf-8?B?RTFUSWFsdThUY0lMNGk4MGY4NUMwcXgrMGdNV3AydmdOcVN1UVdGRnlsN0Vq?=
 =?utf-8?B?cXNteUV2ZU5wVXMyaXZFMWdQcW9uSFV6NFcyT2psZThGM2lJZnZIYml0L25H?=
 =?utf-8?B?NmZHNVZYNmNWSWVld1Z4dWJTMTV0dktlekFjNk9QNVozTXhkS3lMdU0wV3hD?=
 =?utf-8?B?U1JlblRKY3FkZVJUUU5EUWtGREZsTStBL3Qwc25BM2ZFTzlGanJsSDBjL3NB?=
 =?utf-8?B?Tk41RXFFQm5QVHZjRXh5YU4rd0p4dUJPY2RSejUySzFoLzRvTmZtcTdyYXZq?=
 =?utf-8?B?b1BVNDZSdUJvN0laMitxdlJqYWdCTGV4YittYkwrWHFVdFRNNVM5bVJBMzNu?=
 =?utf-8?B?bUZFTk9OUXkvYSt6ejJna3ZYNi9zZTJCSU8zSlY0cUV4TDBxWjV6bHpPZC9K?=
 =?utf-8?B?djlYVjNlMDAwZUZXL2psWGd1Q2ZWcXRiOHI5YlZXcVFRUGV2QWRCVS82UFBm?=
 =?utf-8?B?ZTVWTXVsbUkwT0huRDV4czFUVlNiQlVPQXFzN0doR1kyQ1NTTGUxNDN0YWRD?=
 =?utf-8?B?dEIydVFtN2MzcUZvRkcyUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEZKb1pVU1c0d0p4anRTbXVHSU1qWXRFMitUYjVxKys2Ri8rUHBic1U2WUJI?=
 =?utf-8?B?ZTRLNVdYWDRCZGRFbVhOUnhUL2xyWjFBT3lxbVJCUVBCUmhUMUtpMU00dkdP?=
 =?utf-8?B?SFlZc0Q3OTFwUFNLU2ZQWE9GSE5QeTZWdG50aUhwODhPcm5Sb3VhODBVNkkw?=
 =?utf-8?B?NFA1ZWY2ckJHdkorL1NTemVlWEN4S0g5NjhqajRHamgrM2t2WmczakVBSS9Q?=
 =?utf-8?B?V3lwRFVkN2wrcnJYL3lMd3lzZEZ6a1IvUHNZSVlJUjBNc0VoeVhQbmovbVlM?=
 =?utf-8?B?Q2JQSEdWY1NmYUo1cC8rSktERjMyMWNtaVdLaTZEa0d6TnFDZHViSnl3ZGJV?=
 =?utf-8?B?SEViU0oydGZpakJoTnJSNlNpTnU0Q0JRWHhtL1ozYktpQUEwWU1ETE11SVZ0?=
 =?utf-8?B?VjZQcVZkWEZqSElUeVBpL3RncVVPYys5QytObVcvd1dOc1J6ZkRsdHh1d1Jn?=
 =?utf-8?B?N0NFdkV1RkNTb1Zmem9aWkVvallsTFVLcHFKeHZhV3JQbTY1ZitncmsweVpB?=
 =?utf-8?B?V3kxRXZ0ZGZYVmNnU1FGQ2F6L01KalhBOW9tWGhSR0VZNDBmL2FOaVA1K0k5?=
 =?utf-8?B?Q1VscnpUY3BiWEtPVG0zSW5INjFtbDZNNVVHTkd0UnJrQi9KbkNRSUVHQm9E?=
 =?utf-8?B?QlBkTGtvbkwwbVFHQnlxcGFBVUlVeDVlVWtJWVE2TFNERXNNSnZtL3d4dE9U?=
 =?utf-8?B?eEgyNzNhRWhFWUttMERPdmZZN1BuUldpVGd5ZFRFaTlWK3hJZDhzczMrY09l?=
 =?utf-8?B?SWdHbHJlSGVrRWpaYnM1MVV0YzBYVjdtWW41NHVGdlpRN1BzOStKeFdkWjJi?=
 =?utf-8?B?YWVvSFhUNHRBaTBwZm40cjZvVTM4Qk1oeVMxK05RcGw3YTloUER6NVI1UGtp?=
 =?utf-8?B?SlU5WWZ3WlBhZXhaQ3VpUDNPNzhRZWhtTzB1Sk0xQ28wTThxbE1iMW5seEN5?=
 =?utf-8?B?em12ZS80MHN4VHZYWHJlY3Fld0Eya3FUdDhWdXB1UGNwckFyZ3duTkdvMG5X?=
 =?utf-8?B?VE45OGNTSmhmZnRUTE5KYlI4T2ZBdDQrNUZzU0xJMTRNK3h2cjRkeXFTa1F0?=
 =?utf-8?B?MEtzUUU3cnRGT1FrU2U5VGxQYVVrc29PeFZPUW9xcUhVMnJ6UkhZTFhIOXJj?=
 =?utf-8?B?d1N4d0N3cVdLbndIMHJWdy9ZMTdNUHMxeTdjT1E1Y1lwVytseStNL2lUWVFk?=
 =?utf-8?B?clIyNmUyNG5RWDJqSWM1dG83ZzFRZ1UrTTlMcEVEdXA4ajlsQURab014T21p?=
 =?utf-8?B?ZS9BWjdUOWkvWnVNNzIxMVlrQlNKVXJ1bGs5RkNWcHBxd0w1YzFQekFGSVJE?=
 =?utf-8?B?UnYvVjFSS004QUNFbFhiT1VzT0h5bmgzRktockh5cGNQTk9tMG9CaTZ6K05P?=
 =?utf-8?B?NWxNa05Lb0ZVSEkyRHRYZEM2WFU0amRzS3JkU3dVcEV5dnJUNnFsUkJUMzda?=
 =?utf-8?B?M214a3dHN0FsMDhpV25VSE5LejF1N3FnMnRXcGdWTkZMSmFCMlErQVI0eUpv?=
 =?utf-8?B?WVVPOCt5UFNadU52WWFORW5NSkhlOGFZVU1wWDc2WVhXaVhwdDRDTm1OdlJ6?=
 =?utf-8?B?OUlTOCtGckNQWWlsUjVZa0QxNk5SN0JhdEVUeHcvR2FpcDRiQmZuOElkOWVx?=
 =?utf-8?B?c24rdGFvVWNXbHMvMnRzR01WZVJYUTNadDdXdlJvL0hZeVgwTnBGKy91a0Jy?=
 =?utf-8?B?L1Z2dm40Y1NEWU1laWU1SDdGSGZIRG04VWd5b1N0bDZrYkhFaHh5aG9zdHdO?=
 =?utf-8?B?VC9VL1h3ZTI4RExJSjVxS3JRRmpmcll4MWREUkxyL3N4eElXWDJIUUE3MXly?=
 =?utf-8?B?cU40SXQ3cno0WmVuKzBua1Z2S2pZbnZQeWd3WnpqaWxaa1F3Y0FRbkxEaWRs?=
 =?utf-8?B?bUVwVUJJT1FQRTBSZHZrbXhYT21KbzQzVW1OSjVPUklqb044Wlg0Q2dyVFNY?=
 =?utf-8?B?ZzVRc1BubThJYlM2eTlId3NrNEFqWEFhNFBQS0VRTTdNWnFCSVkrd2FNeVpp?=
 =?utf-8?B?T3k1UVF6dVRiRjRJS2pKRENEQU4xK0xVZmRTemtkaXh4aUxQWWhwZk8rNk5k?=
 =?utf-8?B?MWZPZ3cxcll1UnZleGJ0MEg5azIvemExZkEvOUxubFJXTlBTT1c0aFA3Rlp1?=
 =?utf-8?Q?9VaZvIpuflyguHcIvIl3ZraJo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f509e384-c8b6-4815-f106-08dc73f24351
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:45:52.8161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLGYnX1ty57ncsv2Cc2w4W8b3z19gJvEfbpG3VZils/sDXfGprlNL5U0s90c5oF47D7W7FTIwCKxFgRNjD9P/HXObPclckpr2B/vsaRAT/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6305
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogW1BBVENI
IGF0c192dGQgdjEgMDkvMjRdIHBjaWU6IGhlbHBlciBmdW5jdGlvbnMgdG8gY2hlY2sgaWYgUEFT
SUQNCj5hbmQgQVRTIGFyZSBlbmFibGVkDQo+DQo+YXRzX2VuYWJsZWQgYW5kIHBhc2lkX2VuYWJs
ZWQgY2hlY2sgd2hldGhlciB0aGUgY2FwYWJpbGl0aWVzIGFyZQ0KPnByZXNlbnQgb3Igbm90LiBJ
ZiBzbywgd2UgcmVhZCB0aGUgY29uZmlndXJhdGlvbiBzcGFjZSB0byBnZXQNCj50aGUgc3RhdHVz
IG9mIHRoZSBmZWF0dXJlIChlbmFibGVkIG9yIG5vdCkuDQoNCnMvcHJlc2VudC9lbmFibGVkLw0K
DQo+DQo+U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRo
aWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+LS0tDQo+IGh3L3BjaS9wY2llLmMgICAgICAgICB8IDE4
ICsrKysrKysrKysrKysrKysrKw0KPiBpbmNsdWRlL2h3L3BjaS9wY2llLmggfCAgMyArKysNCj4g
MiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+DQo+ZGlmZiAtLWdpdCBhL2h3L3Bj
aS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQo+aW5kZXggYzhlOWQ0YzBmNy4uMmE2MzhhOWMzZiAx
MDA2NDQNCj4tLS0gYS9ody9wY2kvcGNpZS5jDQo+KysrIGIvaHcvcGNpL3BjaWUuYw0KPkBAIC0x
MjAxLDMgKzEyMDEsMjEgQEAgdm9pZCBwY2llX3Bhc2lkX2luaXQoUENJRGV2aWNlICpkZXYsIHVp
bnQxNl90DQo+b2Zmc2V0LCB1aW50OF90IHBhc2lkX3dpZHRoLA0KPg0KPiAgICAgZGV2LT5leHAu
cGFzaWRfY2FwID0gb2Zmc2V0Ow0KPiB9DQo+Kw0KPitib29sIHBjaWVfcGFzaWRfZW5hYmxlZChj
b25zdCBQQ0lEZXZpY2UgKmRldikNCj4rew0KPisgICAgaWYgKCFwY2lfaXNfZXhwcmVzcyhkZXYp
IHx8ICFkZXYtPmV4cC5wYXNpZF9jYXApIHsNCj4rICAgICAgICByZXR1cm4gZmFsc2U7DQo+KyAg
ICB9DQo+KyAgICByZXR1cm4gKHBjaV9nZXRfd29yZChkZXYtPmNvbmZpZyArIGRldi0+ZXhwLnBh
c2lkX2NhcCArDQo+UENJX1BBU0lEX0NUUkwpICYNCj4rICAgICAgICAgICAgICAgIFBDSV9QQVNJ
RF9DVFJMX0VOQUJMRSkgIT0gMDsNCj4rfQ0KPisNCj4rYm9vbCBwY2llX2F0c19lbmFibGVkKGNv
bnN0IFBDSURldmljZSAqZGV2KQ0KPit7DQo+KyAgICBpZiAoIXBjaV9pc19leHByZXNzKGRldikg
fHwgIWRldi0+ZXhwLmF0c19jYXApIHsNCj4rICAgICAgICByZXR1cm4gZmFsc2U7DQo+KyAgICB9
DQo+KyAgICByZXR1cm4gKHBjaV9nZXRfd29yZChkZXYtPmNvbmZpZyArIGRldi0+ZXhwLmF0c19j
YXAgKyBQQ0lfQVRTX0NUUkwpICYNCj4rICAgICAgICAgICAgICAgIFBDSV9BVFNfQ1RSTF9FTkFC
TEUpICE9IDA7DQo+K30NCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kvcGNpZS5oIGIvaW5j
bHVkZS9ody9wY2kvcGNpZS5oDQo+aW5kZXggYzU5NjI3ZDU1Ni4uOGMyMjJmMDlkYSAxMDA2NDQN
Cj4tLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCj4rKysgYi9pbmNsdWRlL2h3L3BjaS9wY2ll
LmgNCj5AQCAtMTUxLDQgKzE1MSw3IEBAIHZvaWQNCj5wY2llX2NhcF9zbG90X3VucGx1Z19yZXF1
ZXN0X2NiKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwNCj4NCj4gdm9pZCBwY2llX3Bhc2lk
X2luaXQoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9mZnNldCwgdWludDhfdCBwYXNpZF93aWR0
aCwNCj4gICAgICAgICAgICAgICAgICAgICAgYm9vbCBleGVjX3Blcm0sIGJvb2wgcHJpdl9tb2Qp
Ow0KPisNCj4rYm9vbCBwY2llX3Bhc2lkX2VuYWJsZWQoY29uc3QgUENJRGV2aWNlICpkZXYpOw0K
Pitib29sIHBjaWVfYXRzX2VuYWJsZWQoY29uc3QgUENJRGV2aWNlICpkZXYpOw0KPiAjZW5kaWYg
LyogUUVNVV9QQ0lFX0ggKi8NCj4tLQ0KPjIuNDQuMA0K

