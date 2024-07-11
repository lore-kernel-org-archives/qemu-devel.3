Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD71FC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuAa-0004Xg-42; Thu, 11 Jul 2024 09:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sRuAY-0004Qd-CC
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:49:10 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sRuAU-0001yz-Tj
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720705747; x=1752241747;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BvWaUDPCot5PgWGEbuw3NnQzfZS5Bmk45EMRLftxutQ=;
 b=d9t0k1osV3TUvmB9bFsMICRNglZytVSpDgQ36qURHe9CAwod8PqdzTJV
 zbo2TAbUoZGp2wcsdXjc/vBRsY/G9gkjcaxgjxI5fmdj3vMFhv5KsE5DK
 fiIk5FIqve0rquA+LCTLCbFwvpUjKQf5HS49DUe2yorA9AT7FpweHqJoe
 FtnWpNiMVUD3VIXo4/Ou+7HFKuXxPnEp7uf23BS9qmaA8wH1a96S38VWp
 ZGnHdbF/g1zNdQJGlJZqBDknHFy3/GQdfbi/ErRiMxhQiAj8X41YTaCWz
 wgEioISVNPip5DCssdF5lvhFAz/Coph9MtT3ejoPW8wPlE/bBAvVfHPEO w==;
X-CSE-ConnectionGUID: 4RVTgcZRR1eFXq7mrHIVVg==
X-CSE-MsgGUID: UMXNQf5nTh+iGEuXSPWTzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18228398"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; d="scan'208";a="18228398"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2024 06:49:04 -0700
X-CSE-ConnectionGUID: ZmNEEK0OS1yveDhL7BEJRw==
X-CSE-MsgGUID: SUfO3TS0R8CD+z9mtVRhPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; d="scan'208";a="49205474"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jul 2024 06:49:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 06:49:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 06:49:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 06:49:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 06:49:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDgY8mTJVrJY4MYBfJmNl8IRCmYTCIx/T76o5bjL5aZj5DLt+Qf68NVR4SOyjFlQeauMfiG31HKa4DBLlC996vMWvFUMXV5R8yF3+9ShOcB/enBITjVEAJCkiRe/DxPgD7G6brD0v0TYWtCHZGSHLLRsJbfq9JQXy8baw5aZ9sJBwFhYTpUE+zbkQ+RFa3Tx/1snTY1jCRobRYUbnqpZJV+gz2HJKulqB6F2lvb/hi4YDcKaOcy3cFxnwIbalCzdrE6F6kuz7vBfw2+5vIFbrrAzUtVcffsYicKRKgJLAoWenmN0azvaZknOOWu4Q0aQ7JOvFm3bBY4PJfqm/ZJCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvWaUDPCot5PgWGEbuw3NnQzfZS5Bmk45EMRLftxutQ=;
 b=rPCnFVrgvt80Y4GCeCBWBvd78aafpyaGt8b3eleP/I9HLyKLdclYiY7TQXaQVzmNT6m1n5jN/qPk8x9vX6Lo8D6RKVpcowsoE0Y436Fdje2pVcVEzJ86xFJ2JmxehqNxWntaX1cmyoOqLJGHir5aIM7JT/CBWmX3dBnL8iNricrx9evHrNS6teodnnmW0FZyTRILkDtxzGtufP5UumqatrKGA6oPKFUFwU6sMxbKjT1lKceLmJYw674YgVA+n/IxvDFoXCSIIGX4ErTpCy1SJrbRuPFem1IHxfVojLTvjtNzc4BiJqERBfv1+Ot8+crV/F4Rric+J0hrvcisVUBvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 PH0PR11MB7523.namprd11.prod.outlook.com (2603:10b6:510:280::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 13:48:59 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 13:48:59 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Wang, Lei4" <lei4.wang@intel.com>
Subject: RE: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid is
 set to false
Thread-Topic: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid
 is set to false
Thread-Index: AQHazVg5C0RiDxJPOUeRPpagSbRqXrHxdZ6AgAACIHCAAAhAgIAADtxA
Date: Thu, 11 Jul 2024 13:48:59 +0000
Message-ID: <DS0PR11MB637398C97A8B3AA1886CBD38DCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <Zo_GZfR1sQH06TCp@redhat.com>
 <DS0PR11MB6373A148EDE4EB3125B6C42DDCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Zo_PGVjbRHMfe-Gf@redhat.com>
In-Reply-To: <Zo_PGVjbRHMfe-Gf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|PH0PR11MB7523:EE_
x-ms-office365-filtering-correlation-id: 6d612815-cf76-477e-8073-08dca1b03782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VzEvQ0dLOVBrSDllaXNnd0UvK2dsTW1YK3Nma1FkekZ0TFZiSnNuRVhlZXZt?=
 =?utf-8?B?UHVPYitnQm1CeFJyMnNzVmJzaG9sQ1d5TnJRSHVLeHAzNVIwbGlSM0l2dWpW?=
 =?utf-8?B?c2R5SVpmckFUQm5wb1ZWU3lUWGlvaldrcklCMy9kaTVkVDFBcmh6Y2xyRUVH?=
 =?utf-8?B?N0IzR3FNcGJXaHNPOUd0VklSTEZGTlJ0bVlKTmhlbW1DUExIZlczOUVzRlRt?=
 =?utf-8?B?ZW1xNGNtM0JpaThqQjJFbVRlSVc4bnVNT0Y2TTB5Rzk2VzltZkNWc1BpN1Ux?=
 =?utf-8?B?SDdJc0JNSnZ5L3ZDeDg3a3ppc24zb2YrRTNlczdzU3hZNVpXeU14bGh0SFVH?=
 =?utf-8?B?b0lBem9sOVNwT3NlTkpDRTd4dnlyNmR1WVhxTnR6UU0ydnJaSHB5NksyZmpj?=
 =?utf-8?B?MXdFb003YmUzdUo5WUlJa0t5VnpNQlZ2b1hPUmUxWlNWamJ0eTZxajhVTzZY?=
 =?utf-8?B?a0N6Nm0xYkVBYldGL29TRjM4NGg3Ly9RUlgxaE9pVm44ZmNvSENxTnkxUnpQ?=
 =?utf-8?B?YURTMnU2MG5jWDlzSnlISkdlNml1Y2pMWm50a04zSGpxZUVDeEIzTE55bW9y?=
 =?utf-8?B?Q2Q5eDl6THppUGNJOTRpOUpsL1JHMTduVmtHQmd5VHFaL1JiM2NxYnpmUVhj?=
 =?utf-8?B?U1ZSNHJKcUxLcUQ0cm5TSXUyNDZCNEV4WVhFVk1jeHJNMmJVbDhLNHpvUjUw?=
 =?utf-8?B?TDVjRDFqd2xoWTNtMndBRlZVTElNSGhhMjl2c3BzWWl2K0RDbVdzWktYZnFp?=
 =?utf-8?B?WGNjMUgzeXU1TGllbWswS3FlMm94L3lSRXVpZVRiY1YxcEt2L1hLRm5rVGdi?=
 =?utf-8?B?VFhMTXQ4VE45NVR0dWY2ckIwVSt6RFhTRlF4c01yTUtPTVhHMUlZRGJONVlM?=
 =?utf-8?B?SVFRK0pqY3g4MUF5QmJPUmxiTFlXczI2VTQvZ0dwNFRTWkVCNlZXTHdrQkVO?=
 =?utf-8?B?MnNnTEU0UC9JWXVQWVBvK3lvR01SUEliU3FvdUR0UGpkM0lCZEtjenRQUVBV?=
 =?utf-8?B?MEtzMmZWRWVmVklDZ0t0c3owb0xrZ0QyanFKYUQ1cy93N2NOWG5EZjRMRHhY?=
 =?utf-8?B?K243K0Q4eUVPZTNhV0d0VGlMRWg5eW1qZUZsL0RCSWxaODZhQzgzZnN4UWNh?=
 =?utf-8?B?OGgxWmJaU08yYUh6dmRGQmpkalV1OEw2YlY2Tlp4WE5HaW9pWGR2ZGVrVWVD?=
 =?utf-8?B?VHEzZ0pUdU5keUxzWitwY05MUUtyUDR3VERVVlpMVnVnNkhCLzhWTnRTU1pN?=
 =?utf-8?B?S0hDQ2lRRDlzK1NVdlRYWnNTYmh5aGE1NnFacXdtdVBSVmh5Tk5PTUN4bEhL?=
 =?utf-8?B?Skc5SnlkQTN5Q2tveXM2KzJKcVYxNllRTVBiWmc2akFHSkFnM1hsOVI0V2FB?=
 =?utf-8?B?QWNtWGIvVHEzRjdSWGMzMitwN1FxdUh0cE5wVi9oSlJlMjRKMyszR2MwRkY2?=
 =?utf-8?B?T3BBOTVvZk1oOStuM0R4R0txbHhNSm1ZQTNZQ0pyZnk4OVhjbHVRSW5BckVr?=
 =?utf-8?B?U05TcDVrczM2dGxZVjJPZTVMZFNQaXY3M3pXaVZtWGJLZ1BndTR6UEpZdmVX?=
 =?utf-8?B?Z2JveUpaQzhqVEN1KzVRR2VHTEhPRnRVTEFDOXA2V3p4NnlSLzdCb0RFd3hP?=
 =?utf-8?B?bWx1VzE5cjhQcytDUTBpZVFUcFZpYzhKM0tHY3pVWWJwVXl5SWdOUEY1R0c1?=
 =?utf-8?B?aHByNU1hM0t0UU1FaFpUM25STmlMeWdtclMwcmZSTTZCUTVFU1IrblZWWkpq?=
 =?utf-8?B?b2RRMHN0L25VWjV1Slh2eEF5R2t2SnBhMytJcDVkNGJ3WHFUS2pYN2RwS2ta?=
 =?utf-8?B?TDdaZjV1UlAzdWtIY3BocXRtZXNLVFFYWnNVVXhyRzA1QS9tdnJkQWt6Z3VW?=
 =?utf-8?B?bGtzYnllcHV4MXNsSDgwcjR0TmNjNW55YlBlOXUrSWpEeXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEhPc0J2Y2d4VXBrYnJVYU5RNUdZVXJ4YWZwR3VLOHdaSnFheDNkWklIcTlw?=
 =?utf-8?B?cUdFcitTenVNYXVocVFyYnhta1Z2SlZ3bmo0eHliaWJxcFdDWnViOUJlbVE0?=
 =?utf-8?B?RDc4RDJHeUZQL3BrcHNzV3RDdTg4eGNIKzlqUklYVzhJM202bTFnbnVxUzFh?=
 =?utf-8?B?enpwZ0hOWkhsc3hJVEtzcjZCdnc5bndveDU4TTJVV0VXVHNEV0JUUTRNZnRa?=
 =?utf-8?B?UitqU0FMdTNud0pNVXJ3YjZ6U2RQUFNtc1dJN055L05CSE8rWFZOa25Ea05C?=
 =?utf-8?B?S28yaFFGRzIxTURXc0JVeENOZjY1MjY2dDBVeTZUMWl1Q1M1MW9vb3VpV1Mv?=
 =?utf-8?B?bFBLVlI3SThhWHVWN1FWbExOWDNrUk1mN0RVTUZXTFB4MjdLTUtncFVvVWVN?=
 =?utf-8?B?K2ZRZExHN1p4dlUwNC94RUVLVzhic2Ntb3RzeUphVlRxSUpMVG5xbmJFQURq?=
 =?utf-8?B?VDdoTW9nTENuVDNqbC9wMXFXNnRZQnRTbzJjTFdHTmw5MjVZZitVWnlrWjc3?=
 =?utf-8?B?WElzQjNzSGswc3l5bXFldEFJTE9UOHlnbGREKzRiTlM1TjZqcFdySmpteUx6?=
 =?utf-8?B?M0tESkpVSVVSWHJzSTh6MlpXbWFkcDFKbTFqbXFlWlQrWnhxNXIybWY4MGlQ?=
 =?utf-8?B?cmxwVlQ2UVowcEMwT2puZE50NEw5THZBdnlMNk9UWS8zMFhoVVBqUW41c3Zy?=
 =?utf-8?B?NlUrN2RlVWJvZzJCOWZVUis2SjBKdFd0d0c5VlBmeTdwSWorand1TGVRZW01?=
 =?utf-8?B?N25TRHZIOGcvci9mek1UNTlrQTc5c1lKclpTRzhvVEhHTEYydTExSUx0ZHFh?=
 =?utf-8?B?d1FQR1lpRWJkRlVqUWRZQTlEand6MjFvY2o1aEs3b2REdlZoa2VETmFnN0sr?=
 =?utf-8?B?YmR5V0tweVR0UEI4bFhEbEY5c0NUaWk0bFYvSEQwUklEbnZqRE45ZU9NZER4?=
 =?utf-8?B?TGRQZUZRR09PbGR1R213eWpXTTl0bXpqS0hhaE1UMWhFTmZVazB5Rm16bkNM?=
 =?utf-8?B?UzZzV3FBMGhmMmVjZ2VQRzYxNFJCUWQrdkJtQmlxblhLMlNrU0JsNU83VjQ2?=
 =?utf-8?B?Y29zTVVFaWROQUMzM09hcjFlT0Q5VjJDNXorMmgyOHJmWVhrT0QvWGFMVFox?=
 =?utf-8?B?eXhJbEtSYTBDdzIxaCtSc1R2Y2g4emVHVHc4U1pOKzhIWkdsaHRFWk1oZlhH?=
 =?utf-8?B?TTY1bVJndDFzSWhRL1RvMDdUYkI2c21MeXNFNTg0elhtNHZYTjJXY29IdllB?=
 =?utf-8?B?cFplcThpVm0rSlpKdGE0TThvRmdwSjBLNGh4OHFveWZjNGhXRVVBaVlNUWhw?=
 =?utf-8?B?VmE4dkVKZHFEWlkzQmJWWGdzejk3ZE9STzhvbFBSRHUvbEsrTGxLRjJJb2VH?=
 =?utf-8?B?Ymh1RkRxSmplRVFuOGRpSEJsSTQrZi9RT21jWGRzWjJPeVMyclozYXdqZ0xC?=
 =?utf-8?B?ZXlubDg2MmpFSFB5ZkxPNWhxODRsd3FSTVp2V05LMnNFblZ0dmJicGt3V0RO?=
 =?utf-8?B?cFFzWk9TdVRaZnlyb1I4b2lyYUVXRWw5Uk1WRTVQK2c5N3RmTXF4d1JPY0hk?=
 =?utf-8?B?cXFkRS8vU2Uvck1JS1JPWVZodm12Sk9VSy9GK0tqN1FyWW1SZ1RZY0F6NWFX?=
 =?utf-8?B?TUhzUjVXS2pPem5FblJnUWUvamIrQmxIS3lEK0lqanZxekdML0Y1cmVMR2xR?=
 =?utf-8?B?MmhlWEwyV0wyL1JYeHBEVmJDK2ZOK21BY2JnUVdDa1J5aVhYWXl0UWM1c2dH?=
 =?utf-8?B?d0dsQ3RmeVZMUjF2VlQxZjdkYW1CbXp2VnEyZzNxTzVCTXBjdmVDU0hOV25X?=
 =?utf-8?B?ZTZWL1ByNzNUQ1E2OEpiQkhpUjA0TXNLcUVzNDQ2K21RZUhTZU44MS9JcXlo?=
 =?utf-8?B?QWNBRjNjdXhUTkg1STBXbVM0dmkzaDhsSjFtNy9ZaHNWbWFoYnkwb3BuYThM?=
 =?utf-8?B?eHpQYVdDaG5DWDZiMkorU2o4QWlkZG43Q0lrOGpiRktqL0ppOC9jVktSVGNn?=
 =?utf-8?B?d05CQVBxcUNWT2UzN2dvU2N6TWg5ZHlTNHBFeHRLSkRVUktXMWMySW5mNmZS?=
 =?utf-8?B?NUMrbGhhS3RBd2lnMGc3d1p2bHk5aDZxbzdFRkdjSzdCQjgxNXFHdDZGZEFo?=
 =?utf-8?Q?BDDalN2lRtcYMHdTYBTYhehHo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d612815-cf76-477e-8073-08dca1b03782
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 13:48:59.6772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7BGAPzFHg0/O+RUYX4RR04xgVcZUgyEtsupuV053f0RKdx/r0C6Bm5+fGMkQA91+rzFC+aUjRUDK2RTtPKbCyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7523
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

T24gVGh1cnNkYXksIEp1bHkgMTEsIDIwMjQgODoyNSBQTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3
cm90ZToNCj4gT24gVGh1LCBKdWwgMTEsIDIwMjQgYXQgMTI6MTA6MzRQTSArMDAwMCwgV2FuZywg
V2VpIFcgd3JvdGU6DQo+ID4gT24gVGh1cnNkYXksIEp1bHkgMTEsIDIwMjQgNzo0OCBQTSwgRGFu
aWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gPiA+IE9uIFdlZCwgSnVsIDAzLCAyMDI0IGF0IDEw
OjQ5OjEyUE0gKzA4MDAsIFdlaSBXYW5nIHdyb3RlOg0KPiA+ID4gPiBXaGVuIGVuZm9yY2VfY3B1
aWQgaXMgc2V0IHRvIGZhbHNlLCB0aGUgZ3Vlc3QgaXMgbGF1bmNoZWQgd2l0aCBhDQo+ID4gPiA+
IGZpbHRlcmVkIHNldCBvZiBmZWF0dXJlcywgbWVhbmluZyB0aGF0IHVuc3VwcG9ydGVkIGZlYXR1
cmVzIGJ5IHRoZQ0KPiA+ID4gPiBob3N0IGFyZSByZW1vdmVkIGZyb20gdGhlIGd1ZXN0J3MgdkNQ
VSBtb2RlbC4gVGhpcyBjb3VsZCBjYXVzZQ0KPiA+ID4gPiBpc3N1ZXMgZm9yDQo+ID4gPiBsaXZl
IG1pZ3JhdGlvbi4NCj4gPiA+ID4gRm9yIGV4YW1wbGUsIGEgZ3Vlc3Qgb24gdGhlIHNvdXJjZSBp
cyBydW5uaW5nIHdpdGggZmVhdHVyZXMgQSBhbmQgQi4NCj4gPiA+ID4gSWYgdGhlIGRlc3RpbmF0
aW9uIGhvc3QgZG9lcyBub3Qgc3VwcG9ydCBmZWF0dXJlIEIsIHRoZSBzdHViIGd1ZXN0DQo+ID4g
PiA+IGNhbiBzdGlsbCBiZSBsYXVuY2hlZCBvbiB0aGUgZGVzdGluYXRpb24gd2l0aCBmZWF0dXJl
IEEgb25seSBpZg0KPiBlbmZvcmNlX2NwdWlkPWZhbHNlLg0KPiA+ID4gPiBMaXZlIG1pZ3JhdGlv
biBjYW4gc3RhcnQgaW4gdGhpcyBjYXNlLCB0aG91Z2ggaXQgbWF5IGZhaWwgbGF0ZXINCj4gPiA+
ID4gd2hlbiB0aGUgc3RhdGVzIG9mIGZlYXR1cmUgQiBhcmUgcHV0IHRvIHRoZSBkZXN0aW5hdGlv
biBzaWRlLiBUaGlzDQo+ID4gPiA+IGZhaWx1cmUgb2NjdXJzIGluIHRoZSBsYXRlIHN0YWdlIChp
LmUuLCBzdG9wJmNvcHkgcGhhc2UpIG9mIHRoZQ0KPiA+ID4gPiBtaWdyYXRpb24gZmxvdywgd2hl
cmUgdGhlIHNvdXJjZSBndWVzdCBoYXMgYWxyZWFkeSBiZWVuIHBhdXNlZC4NCj4gPiA+ID4gVGVz
dHMgc2hvdyB0aGF0IGluIHN1Y2ggY2FzZXMgdGhlIHNvdXJjZSBndWVzdCBkb2VzIG5vdCByZWNv
dmVyLA0KPiA+ID4gPiBhbmQgdGhlIGRlc3RpbmF0aW9uIGlzIHVuYWJsZSB0byByZXN1bWUgdG8g
cnVuLg0KPiA+ID4gPg0KPiA+ID4gPiBNYWtlICJlbmZvcmVfY3B1aWQ9dHJ1ZSIgYSBoYXJkIHJl
cXVpcmVtZW50IGZvciBhIGd1ZXN0IHRvIGJlDQo+ID4gPiA+IG1pZ3JhdGFibGUsIGFuZCBjaGFu
Z2UgdGhlIGRlZmF1bHQgdmFsdWUgb2YgImVuZm9yY2VfY3B1aWQiIHRvDQo+ID4gPiA+IHRydWUs
IG1ha2luZyB0aGUgZ3Vlc3QgdkNQVXMgbWlncmF0YWJsZSBieSBkZWZhdWx0LiBJZiB0aGUNCj4g
PiA+ID4gZGVzdGluYXRpb24gc3R1YiBndWVzdCBoYXMgaW5jb25zaXN0ZW50IENQVUlEcyAoaS5l
LiwgZGVzdGluYXRpb24NCj4gPiA+ID4gaG9zdCBjYW5ub3Qgc3VwcG9ydCB0aGUgZmVhdHVyZXMg
ZGVmaW5lZCBieSB0aGUgZ3Vlc3QncyB2Q1BVDQo+ID4gPiA+IG1vZGVsKSwgaXQgZmFpbHMgdG8g
Ym9vdCAod2l0aCBlbmZvcmVfY3B1aWQ9dHJ1ZSBieSBkZWZhdWx0KSwNCj4gPiA+ID4gdGhlcmVi
eSBwcmV2ZW50aW5nIG1pZ3JhdGlvbiBmcm9tIG9jY3VyaW5nLiBJZiBlbmZvcmVfY3B1aWQ9ZmFs
c2UNCj4gPiA+ID4gaXMgZXhwbGljaXRseSBhZGRlZCBmb3IgdGhlIGd1ZXN0LCB0aGUgZ3Vlc3Qg
aXMgZGVlbWVkIGFzDQo+ID4gPiA+IG5vbi1taWdyYXRhYmxlICh2aWEgdGhlIG1pZ3JhdGlvbiBi
bG9ja2VyKSwgc28gdGhlIGFib3ZlIGlzc3VlIHdvbid0DQo+IG9jY3VyIGFzIHRoZSBndWVzdCB3
b24ndCBiZSBtaWdyYXRlZC4NCj4gPiA+DQo+ID4gPiBCbG9ja2luZyBtaWdyYXRpb24gd2hlbiBl
bmZvcmNlPWZhbHNlIGlzIG1ha2luZyBhbiBhc3N1bXB0aW9uIHRoYXQNCj4gPiA+IHVzZXJzIG9m
IHRoYXQgc2V0dGluZyBhcmUgaW5oZXJhbnRseSBicm9rZW4uIFRoaXMgaXMgTk9UIHRoZSBjYXNl
IGlmDQo+ID4gPiB0aGUgdXNlci9hcHAgaGFzIGFscmVhZHkgdmFsaWRhdGVkIGNvbXBhdGliaWxp
dHkgaW4gc29tZSBtYW5uZXINCj4gPiA+IG91dHNpZGUgUUVNVS4gQmxvY2tpbmcgbWlncmF0aW9u
IGluIHRoaXMgY2FzZSB3aWxsIGJyZWFrIHZhbGlkIHdvcmtpbmcgdXNlDQo+IGNhc2VzLg0KPiA+
DQo+ID4gSXQncyBqdXN0IGFuIGVuZm9yY2VtZW50IHRvIGVuc3VyZSBhIHNhZmUgbWlncmF0aW9u
LiBXaXRob3V0IHRoaXMNCj4gPiAoaS5lLiwgdGhlIGN1cnJlbnQgUUVNVSBjb2RlKSBpcyBtYWtp
bmcgYW4gYXNzdW1wdGlvbiB0aGF0IHVzZXJzDQo+ID4gYWx3YXlzIGhhdmUgdmFsaWRhdGVkIGNv
bXBhdGliaWxpdHkgaW4gYSBnb29kIG1hbm5lciBvdXRzaWRlIFFFTVUsIHdoaWNoDQo+IGlzIHJp
c2t5IHRvIHNvbWUgZGVncmVlPw0KPiANCj4gUUVNVSBjb25maWd1cmF0aW9ucyBtdXN0IG5ldmVy
IGJlIGFzc3VtZWQgdG8gYmUgbWlncmF0YWJsZSBieSBkZWZhdWx0Lg0KPiBUaGVyZSBpcyBhIGh1
Z2Ugc2V0IG9mIHRoaW5ncyB0aGF0IGEgdXNlciBtdXN0IGRvIHdpdGggUUVNVSBjb25maWd1cmF0
aW9uIHRvDQo+IGd1YXJhbnRlZSBtaWdyYXRhYmlsaXR5IGJleW9uZCBDUFUgZmVhdHVyZXMuIEFs
bCBhc3BlY3RzIG9mIGd1ZXN0IEhXIGRldmljZQ0KPiB0b3BvbG9neSBtdXN0IGJlIHNldCBleHBs
aWNpdGx5Lg0KDQpXaGF0IGlmIHRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIGFyZSByZXF1aXJl
ZCB0byB1c2UgZXhhY3RseSB0aGUgc2FtZSBRRU1VDQpjb21tYW5kcz8gRG9lcyB0aGlzIG1lZXQg
dGhlIGZlYXR1cmUgYW5kIHRvcG9sb2d5IHJlcXVpcmVtZW50cyBhcyB5b3UNCm1lbnRpb25lZCBh
Ym92ZT8NCg0KPiANCj4gPiBEbyB5b3Ugc2VlIGhvdyB0aGlzIHdvdWxkIGJyZWFrIHZhbGlkIHdv
cmtpbmcgdXNlIGNhc2VzIChhbnkgZXhhbXBsZXMpPw0KPiA+IFRoaXMgaXMgYWN0dWFsbHkgd2hh
dCB3ZSBhcmUgbG9va2luZyBmb3IuIFBsZWFzZSBiZSBhd2FyZSB0aGF0DQo+ID4gImVuZm9yY2Ui
IGlzIGNoYW5nZWQgdG8gYmUgdHJ1ZSBieSBkZWZhdWx0IHRvIG1ha2UgdGhlIGd1ZXN0IHRvIGJl
DQo+ID4gbWlncmF0YWJsZSBieSBkZWZhdWx0IHVuZGVyIHRoZSBlbmZvcmNlbWVudC4NCj4gDQo+
IFNldHRpbmcgImVuZm9yY2UiIHdpbGwgYnJlYWsgZXhpc3RpbmcgdXNlIG9mIFFFTVUuIEl0IGlz
IHZhbGlkIHRvIGxhdW5jaCBRRU1VDQo+IHdpdGggYSBDUFUgbW9kZWwgdGhhdCBpcyBub3QgZnVs
bHkgc3VwcG9ydGVkIGJ5IHRoZSBob3N0LCBhbGxvd2luZyBRRU1VIHRvDQo+IGRpc2FibGUgdW5z
dXBwb3J0ZWQgZmVhdHVyZXMgYXV0b21hdGljYWxseS4NCj4NCg0KWWVhaCwgSSBrbm93IHRoYXQn
cyB2YWxpZCB0byBmaWx0ZXIgdW5zdXBwb3J0ZWQgZmVhdHVyZXMuIFRoZSBvbmx5IGRpZmZlcmVu
Y2UgaXMNCnRoYXQgdXNpbmcgdGhlIG5ldyBRRU1VIChpLmUuLCB3aXRoIHRoaXMgcGF0Y2gpIHdp
bGwgcmVxdWlyZSB1c2VycyB0byBleHBsaWNpdGx5IHNldA0KImVuZm9yY2U9b2ZmIiwgaXQncyBu
b3QgdGhlIGRlZmF1bHQgYmVoYXZpb3IgYW55IG1vcmUuDQpTdGlsbCBjb3VsZG7igJl0IHVuZGVy
c3RhbmQgdGhlIGltcGFjdCAob2YgdGhlIGRlZmF1bHQgdmFsdWUgY2hhbmdlKSBvbiB0aGUgZXhp
c3RpbmcNCnVzZSBvZiBRRU1VLCB0aG91Z2guDQoNCiANCj4gPiA+IElNSE8gdGhpcyBwYXRjaCBk
b2Vzbid0IG5lZWQgdG8gZXhpc3QuIElmIHVzZXJzIG9mIFFFTVUgd2FudCBzdHJvbmcNCj4gPiA+
IHByb3RlY3Rpb24gdGhleSBjYW4gYWxyZWFkeSBvcHQtaW4gdG8gdGhhdCB3aXRoIGVuZm9yY2U9
dHJ1ZS4NCj4gPg0KPiA+IEFGQUlLLCBtYW55IHVzZXJzIGFyZSBub3QgYXdhcmUgb2YgdGhpcywg
YW5kIGFsc28gd2UgY291bGRuJ3QgYXNzdW1lDQo+ID4gZXZlcnlib2R5IGtub3dzIGl0LiBUaGF0
J3Mgd2h5IHdlIHdhbnQgdG8gYWRkIHRoZSBlbmZvcmNlbWVudC4NCj4gDQo+IFVzZXJzIHdobyBk
aXJlY3RseSBsYXVuY2ggUUVNVSBhcmUgZXhwZWN0ZWQgdG8ga25vdyBhYm91dCBRRU1VIGNvbmZp
Zw0KPiBkZXRhaWxzIGZvciBtaWdyYXRpb24uIElmIHRoZXkgZG9uJ3QsIHRoZW4gdGhleSBvdWdo
dCB0byBiZSB1c2luZyBhIGhpZ2hlciBsZXZlbA0KPiB0b29sIGxpa2UgbGlidmlydCwgd2hpY2gg
ZW5zdXJlcyB0aGUgY29uZmlndXJhdGlvbiBpcyBtaWdyYXRpb24gY29tcGF0aWJsZS4NCg0KQ291
bGQgeW91IGV4cGxhaW4gaG93IGxpYnZpcnQgcHJvdmlkZXMgYSBtb3JlIHJlbGlhYmxlIGFzc3Vy
YW5jZSBvZiBtaWdyYXRpb24NCmNvbXBhdGliaWxpdHkgaW4gaXRzIGNvbmZpZ3VyYXRpb24gY29t
cGFyZWQgdG8gdXNpbmcgcmF3IFFFTVUgY29tbWFuZHM/DQpQZXIgbXkgdW5kZXJzdGFuZGluZywg
bGlidmlydCBjb25maWdzIG1vc3RseSBtYXAgdG8gdGhlIFFFTVUgY29tbWFuZHMuDQoNCg==

