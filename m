Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA8EC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfvf-0005zU-9v; Thu, 13 Jun 2024 04:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHfvc-0005wI-QY
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:35:28 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHfvY-0004tb-UL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718267725; x=1749803725;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AJyb8oI24Et05tX5XGsxxftshP1m2ildvSxjDySoSJg=;
 b=Pi+LIcsqZ8WUglR7D0+/hYBeGmBsrxbbBrPTlMi1i5aej9w3CqdoN+gU
 J+NbJpegbojRgamuz02lfn7wfwVlUD37K6EGazGmjUyXKsROOQ+lCvWGP
 jZqkal+6i7+m5fRFzOSaOwehEEuI+SA2B4fgSHI4hhWUpsWsl4FfEYF0B
 ElUIsW6ZzNuqaufoTRmKIgO6g4UeFzp4VTqnZ14KOGQgFdRZpkw5VYJWf
 fdnMtjnn1wH3WCutD6V9XMRhdoYKEIR3G8sSa6HOMli81pA3HGIu/JxYq
 jAJkTO7oXYguIdNF6xQpEvkMd4qLwk4UXGNFJmtx/FgXmDjgUdtNmqM7j g==;
X-CSE-ConnectionGUID: par/0wNdSvCxbX/cXDQhfw==
X-CSE-MsgGUID: FwW32UT0QOC45jYiWx57mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15199991"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="15199991"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 01:35:12 -0700
X-CSE-ConnectionGUID: vx2dveGKTLWCkHcD5nPQsA==
X-CSE-MsgGUID: GUvg4wncQYuW9nB2/mbsQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="40705249"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 01:35:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 01:35:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 01:35:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 01:35:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTxytMkFWpcq4v6bVXSi9x67Wt4u7Dse1IOUJlXyjQEZrX1G/F2ihl371Ae9HHNUD8TkUbSTydscvzkt1SMV4ZAKHChC22eQ2QM3GrFI0iptkqjkslb10Q/a18cR5iEfIHXkk3n/+EWK83NwuuCL0mHa2JqJSYJ5ciBcg60YNPDyZZvpPELQE5gjg5HuuwQW0JKS8j0EPl3+pxTTf7tnwqxz7JPYIZNWSaSeBSIljeVDaRng3xSfB/13p9tx5la2qz5bJeV/XuVxISEgHPdbyVNv+ZLkQVpzNbdUEpaZUZg7OoIRwSSLnI/PmP6USMSOf84ltb1VBGrZXr/ou5ssZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJyb8oI24Et05tX5XGsxxftshP1m2ildvSxjDySoSJg=;
 b=ROyC8h9GLDTNRyR0LWsZf38HibQq6lh0Sl3XntZFiJov2pvfMWbXMaz+bBjxAzkE/+Dmh3c7vNdmCEMZA4L33O64zgoE0Vw5si6p4dFN+ZGBHGmSUv08IaR0q/+fQfeJz4PM1z6DWZ+cOPgVegiJ3uv2n8QCYSZcP06D9o3BlyfIjhI2odNV7ZwjTynK99kcUTw7YLDqU4dKk2KzI3uNJq8jVaQ6Hr0NCwAlhrVn+JxqWbFBeL/5V0yNb6BwmlTnsiWjN5U5H/MJFkp/OgD9pF+unldKZ3uMrufkcF+A8PT/PtqDDqCBrMVaMCuoKEmDMNFC/nSFAvoO/YVnEoLIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB8041.namprd11.prod.outlook.com (2603:10b6:806:2ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 08:35:07 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 08:35:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Roth
 <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann
 <kraxel@redhat.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, "Qiang,
 Chenyi" <chenyi.qiang@intel.com>
Subject: RE: [PATCH v5 25/65] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
Thread-Topic: [PATCH v5 25/65] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
Thread-Index: AQHat/7UVxCPTcRwHkSCyrUM2HWwCLHD1SCAgAGR4mA=
Date: Thu, 13 Jun 2024 08:35:07 +0000
Message-ID: <SJ0PR11MB674430CD121A9F91D818A67092C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-26-xiaoyao.li@intel.com> <ZmGTXP36B76IRalJ@redhat.com>
 <90739246-f008-4cf2-bcf5-8a243e2b13d4@intel.com>
In-Reply-To: <90739246-f008-4cf2-bcf5-8a243e2b13d4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB8041:EE_
x-ms-office365-filtering-correlation-id: 82a7ed7a-3338-46af-dd0c-08dc8b83bade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230034|376008|1800799018|366010|7416008|38070700012; 
x-microsoft-antispam-message-info: =?utf-8?B?Zk02aXZlMkN3SS92SC9RN1QxZzYvVXM3UUZxMW9ORDlDQ0ZaQS9mUnpNcVNa?=
 =?utf-8?B?T3h6TnNoOWhUcU1KQ1V1K3N1eUtiVTFwWjN5cWxhRE9sMkc3YlBoWjA3RnN6?=
 =?utf-8?B?YTBDNi9OVlZpNHNXenFSRjlmUG1PMVErS0NaeDk5YndHN0tJTkVuZUhncnpj?=
 =?utf-8?B?Q1I1bDdFR3QxVzdHQjVSMVE4L243b044UTBUenZrRFd4Q2NKV1ZvZVl5V2o0?=
 =?utf-8?B?MzZwTU1oejZGYS84R1F5TE1CRlc4NlptMmt0N2tNV09MaFdnai9mM0JZS2tW?=
 =?utf-8?B?Y0FTbWd1WURrVDMrZ3FRcjA4YWMxMlBoMjdxUHRHbW9iWnBheTNSaVJHTTc0?=
 =?utf-8?B?dGsxZ3JheG1TamZ5SDBobVNWNDd5QS9ya0hMcUErMC8rSXRCbXhDNDRvZ0do?=
 =?utf-8?B?Rm5yQm5UaDU4Wlg0VXREMnIzMTRyZ0F0YzBiL3gwRGlIQjNrTjEvd3FMUTF3?=
 =?utf-8?B?eXh6YU14cDZMUVFmWFpWQVB3eWxZcE5FSWlBTmpScGMxQjQ0c0o1MCtaSjBl?=
 =?utf-8?B?dUgzeWt3cXpsN3RJWHFyUnplNWx1QmF6bklyS09QbGM0Tkl1ZFo1RnVkREFO?=
 =?utf-8?B?VVlSVTVYS0dYYmlDQ3hPRHJRaDR2RkcrR3VJSHN5Y2Z2RTVxRzBqZGl4WTZO?=
 =?utf-8?B?dUZYOVhDdHNGMUx3V2c0UVd6b2ZRek44aFhMZjc2SzAzLzIrT3VtTld4b3dx?=
 =?utf-8?B?S0o5K05FUEdWLzhocXBodFdUTE1KRlBCR3U0czFoem1XUmExWStTbEMvL01T?=
 =?utf-8?B?cU00d2lSL0h6MWswaHo1WGVWLzNSenJZYTI1UUk4WXk1bHJnMStQMHNoUmJn?=
 =?utf-8?B?Mjd3ZUVaNFpiTHc4OVB5Nnh4cEw2SU4zYmFsdGxNVTdZY05HTEZwQnl4MUt6?=
 =?utf-8?B?OXZwUDBsTHhIdTUxeUlMTGw1bVYyZGVRdGFGeEFlZjNNOXV4Y09KYTlTTUdO?=
 =?utf-8?B?ckJpU2Jhb2Q4M3B2S1VhdGtSV2FmbXY0d0NYL3VFSnk5MGozRG5CamxzenZu?=
 =?utf-8?B?cnNOcUhpa21OWVVXd3FNMk1EcWs5U1ZoL2IwV3drdmo3R0o0RnlwbzhTdW0y?=
 =?utf-8?B?blFlRGR5NWkvb3d0RkpzcjYwNkpMTEhpdytTTlhaaGxTK1Fob0NXVXFpMzBB?=
 =?utf-8?B?aFgvblJBLzk0MzRrYWpwNmJtTzJ2dFBDaEttbU5MY05vZDFzemExbUR3Y3Mv?=
 =?utf-8?B?U1VuRDQ5NjcrZWxtRFUyOXdhUXhkaDEzTzMzeTlraTJQSmdjOWxTbXkwU3dQ?=
 =?utf-8?B?YVYxYjVBMDdEYUJremcrbUxpOHNOelllZnhnanBybmNqK3VSdlB5VDNZcFNI?=
 =?utf-8?B?U2ZxQXlydktqUUJqM3BNTUFtRlVhdXVsb1d3ODdlM2drYkNrdU1jTFJRaGtq?=
 =?utf-8?B?NjhzQzJtb21QYUt6VGpVR0NnVW9ubmE0MFJscWR3VVNIeVBoSkMxY3JaemNx?=
 =?utf-8?B?aTQ2NHhPN2puZDJEMFp5cnZrd1VSTUVUaFR3MmU1K1ZTZmdBT1JPR2doaWJQ?=
 =?utf-8?B?bXBja1BRbnlBTGE4aHpQRDliRnduRlYyVG9Qd1RkUE5BRUV1TnRHbGJBaWxx?=
 =?utf-8?B?eGFubVdwYVVBWkllV1kvaVc4NW5sS28zNEhmWk85bGo5c080YmQ4ZEhxM0ht?=
 =?utf-8?B?cDlYT3hLWktSamlkSGs1dmlIcE1BU3VNOU9WRDVUTnYwdVBLcDJTd3RwN3ZU?=
 =?utf-8?B?eVB6NXE0ckpTWDlNRmlld2xzUXNvcGk2TlFUeWNqeWVLY2pHL0hhTk1ySits?=
 =?utf-8?Q?EachnrXw2vb4eE79OL5aqc6tLvN4pc5reNcmSuJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(7416008)(38070700012); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTVmTTdZZmtZRko3MFpZMTlsOURBcDRudHpkRDFoWVk5MVA1dkxEdjhFcHp4?=
 =?utf-8?B?eC9HRTJxR0lFRW9DRmlrMG1CVW55di9DSzFoRk14YnYxT0x3a2Z2RFRud2U5?=
 =?utf-8?B?cFNTNklieXV0aUZrUmROSEZoekt4SkY0SVU5RDlkblg2ZkdYMzJwUTMxWHZP?=
 =?utf-8?B?SzlUaFJNZVdybk5NWHJYR2JIOUE3a3IvQ092TnJpdkdmWFVKeEd4OHl6N1JX?=
 =?utf-8?B?ekRUNVFhZzBlSDBZN0J2eWRPdFRDTWY0ekhTMUxGSmQ0Qm5vM1dLZzdLSDh2?=
 =?utf-8?B?Mm54dzJqZ1hLR3Q0QjI4VTBVeHN4M3hrTWwvQmU0c2RFYlFIWXRpZmxsM0pC?=
 =?utf-8?B?bTdQZzl0cUFzU2Ywd3VpYVRvM0dGZnNxUitIR2RlYS9MblhKSjJBdjIrZmtn?=
 =?utf-8?B?aGZxMnkrdk5WdlJ4dXAxcEVvU2loQ3UyWFBnUVVuaHJwRnV5cTJPdjlhWFVi?=
 =?utf-8?B?QjJOa2d4aGM0TmJWV25mSXV4dmJFS1JBV0VqTHlMcjAycTJrUmJZUDcyM1Q1?=
 =?utf-8?B?SHNLeWZrd0thUjRzVXhEYnVnU2xwKy9ITFNtTmJhUkRZSVBjczI4Sk51WEds?=
 =?utf-8?B?RzAvdGt5VytZWEdrV3F3UkRibWg1dkJKTVJod0FhMkpkYlFrMzZHL0hlNVlD?=
 =?utf-8?B?TWJkb01QSXVQQTU4MVE1cUlkMFFZN2RxY1EwMkZJZVh0MlE1VVk0NXZ1Zmpz?=
 =?utf-8?B?a3JENUk5K0xtcURaUlcxQUdFU0paeUFYRkpoa1ZEL2xjRHdkUEQvTlZLNU1k?=
 =?utf-8?B?aUJ1azk4bGk0SEdYcStZdW5HWGhYbTlUZWVON3BRNWZrU3NDZWZKcTJwNW0x?=
 =?utf-8?B?UVVPQVR5OElDZVZzY0REVTR3L05rLzBCUC92MWQwTW9xV2xuSi83bzFuQUhP?=
 =?utf-8?B?dW4wNUFOdTkza1VoWjYveHgrRVF2K0Nmdzl6bDJKUW9MRWxUVVZUenl0bnRs?=
 =?utf-8?B?eFczM3JvSzZGclpKRlVTNHZKRmY3K3REQXRzdjNmdU1rV0RMMVczWmpJeFBa?=
 =?utf-8?B?YUtLbmNEb2xPeG1IV3dmY2xYODdxcHA3bll6NDF3Zndra1ZGUmRrR0RrejlM?=
 =?utf-8?B?aHNDQlRyQ3UyWjZ3dzdWc2I0eDV5bGRaelhjcXJwZm55MFJGN2RRM0VSek8v?=
 =?utf-8?B?NjFHTlVLb1Ztb3NONVlhVjZ1TXVJcXhiUFVBRlltb1NaQWxYa2NmTmI2Vjhi?=
 =?utf-8?B?ZXcrVWN4d3JyQ1ZqaisweDBramhtT3RZUjcwSktnWnRPQXg5WGhxOXpqVW13?=
 =?utf-8?B?eEN2Nm1XeEJVV0R0clZLZ0xQRmRrdjQ0L3NCekhLRVZ3M0VXZXJtSC8vY2tx?=
 =?utf-8?B?U0xnSVNaS1dOd0NPU1V6VGxMempERDBVYnpZRmY1dHZ1eFNoM0RUZTBxWUM3?=
 =?utf-8?B?ZTA4M2RnRHloQTcwNU1zTmp0OVFNcEluMEFEVUg2YVNaUCtGWE4vMTZPU1pK?=
 =?utf-8?B?dStiTEpKR1dXdTRiSFdwY2JQMStPNWNvT0RZOGROREVCaHdTby9PZUlXYUMy?=
 =?utf-8?B?MTU1ZTBlNEJCSTR1alBSVGNPc3VhQ08yT3owOEFYeXRxMWlKcy8wcGgyS1R0?=
 =?utf-8?B?cVArVVlUMFg0Ty9lVlppUXVsZFRrUHRxVndEeCtZRFRtZGd1VVlqZzVSdWhS?=
 =?utf-8?B?YlF5ZVFqYXhqRnZqVmplbjdLVDMwTUlYTklDcndhSkxUTS96MFZYWFlXMWlG?=
 =?utf-8?B?cGprTlJDaXpkRTQweWw5WDFNZEtQRjdNOHNhbVNjM3A4c3lGcFd6YWk3YWY5?=
 =?utf-8?B?WTFPT0xlWFZQZXYwYVFlUFRCOEZBNHZJcjVHUHBhZjFhaWhObmNSQUZHYUhC?=
 =?utf-8?B?OE1keUdOL1FhamxpREhkT2tDVXZjNktjMWRuQkR0WFhyOFhyNXROWGVoaTdJ?=
 =?utf-8?B?R1lrbHM0YzI1UG5Ba3VvcnNZdUtXYVZNTGFYM2xxVzJLbWVUVWFSQmJlcVB4?=
 =?utf-8?B?MXZZVEVOWVl3RzhaZVBUZGoraFZDOExWWmQxNktna3JvREEraW10VzVjUUoz?=
 =?utf-8?B?dWtkTTdqR29kVEZBckI1eldTTFh3eDMwT3RId1pOclVMMVhNL0ZhSDJFY3NZ?=
 =?utf-8?B?c0J6UWRkUzZjenBXckhaclphL2JFYnYrQVIxcEtKRTJyTlZKR0RRdHM2ZzVr?=
 =?utf-8?Q?hycTQJ1Rl3PHzVi/qMvCKah3Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a7ed7a-3338-46af-dd0c-08dc8b83bade
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 08:35:07.1649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycenUCXvNTI1MXleMUSJAiGvOMlBe+66wCL8vZtBwZy0Anyv6gPkHBCKgmNn5+DlcYOw+52gWwvY4Xtc/B3veIIzQWEGH7StxZD4w7uERXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8041
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpLCBYaWFveWFvIDx4aWFv
eWFvLmxpQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDI1LzY1XSBpMzg2L3Rk
eDogQWRkIHByb3BlcnR5IHNlcHQtdmUtZGlzYWJsZSBmb3INCj50ZHgtZ3Vlc3Qgb2JqZWN0DQo+
DQo+T24gNi82LzIwMjQgNjo0NSBQTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4+IENv
cHlpbmcgIFpoZW56aG9uZyBEdWFuIGFzIG15IHBvaW50IHJlbGF0ZXMgdG8gdGhlIHByb3Bvc2Vk
IGxpYnZpcnQNCj4+IFREWCBwYXRjaGVzLg0KPj4NCj4+IE9uIFRodSwgRmViIDI5LCAyMDI0IGF0
IDAxOjM2OjQ2QU0gLTA1MDAsIFhpYW95YW8gTGkgd3JvdGU6DQo+Pj4gQml0IDI4IG9mIFREIGF0
dHJpYnV0ZSwgbmFtZWQgU0VQVF9WRV9ESVNBQkxFLiBXaGVuIHNldCB0byAxLCBpdA0KPmRpc2Fi
bGVzDQo+Pj4gRVBUIHZpb2xhdGlvbiBjb252ZXJzaW9uIHRvICNWRSBvbiBndWVzdCBURCBhY2Nl
c3Mgb2YgUEVORElORyBwYWdlcy4NCj4+Pg0KPj4+IFNvbWUgZ3Vlc3QgT1MgKGUuZy4sIExpbnV4
IFREIGd1ZXN0KSBtYXkgcmVxdWlyZSB0aGlzIGJpdCBhcyAxLg0KPj4+IE90aGVyd2lzZSByZWZ1
c2UgdG8gYm9vdC4NCj4+Pg0KPj4+IEFkZCBzZXB0LXZlLWRpc2FibGUgcHJvcGVydHkgZm9yIHRk
eC1ndWVzdCBvYmplY3QsIGZvciB1c2VyIHRvIGNvbmZpZ3VyZQ0KPj4+IHRoaXMgYml0Lg0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogWGlhb3lhbyBMaSA8eGlhb3lhby5saUBpbnRlbC5jb20+DQo+
Pj4gQWNrZWQtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPj4+IEFja2Vk
LWJ5OiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4g
Q2hhbmdlcyBpbiB2NDoNCj4+PiAtIGNvbGxlY3QgQWNrZWQtYnkgZnJvbSBNYXJrdXMNCj4+Pg0K
Pj4+IENoYW5nZXMgaW4gdjM6DQo+Pj4gLSB1cGRhdGUgdGhlIGNvbW1lbnQgb2YgcHJvcGVydHkg
QHNlcHQtdmUtZGlzYWJsZSB0byBtYWtlIGl0IG1vcmUNCj4+PiAgICBkZXNjcmlwdGl2ZSBhbmQg
dXNlIG5ldyBmb3JtYXQuIChEYW5pZWwgYW5kIE1hcmt1cykNCj4+PiAtLS0NCj4+PiAgIHFhcGkv
cW9tLmpzb24gICAgICAgICB8ICA3ICsrKysrKy0NCj4+PiAgIHRhcmdldC9pMzg2L2t2bS90ZHgu
YyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAz
MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvcWFw
aS9xb20uanNvbiBiL3FhcGkvcW9tLmpzb24NCj4+PiBpbmRleCAyMjBjYzZjOThkNGIuLjg5ZWQ4
OWI5YjQ2ZSAxMDA2NDQNCj4+PiAtLS0gYS9xYXBpL3FvbS5qc29uDQo+Pj4gKysrIGIvcWFwaS9x
b20uanNvbg0KPj4+IEBAIC05MDAsMTAgKzkwMCwxNSBAQA0KPj4+ICAgIw0KPj4+ICAgIyBQcm9w
ZXJ0aWVzIGZvciB0ZHgtZ3Vlc3Qgb2JqZWN0cy4NCj4+PiAgICMNCj4+PiArIyBAc2VwdC12ZS1k
aXNhYmxlOiB0b2dnbGUgYml0IDI4IG9mIFREIGF0dHJpYnV0ZXMgdG8gY29udHJvbCBkaXNhYmxp
bmcNCj4+PiArIyAgICAgb2YgRVBUIHZpb2xhdGlvbiBjb252ZXJzaW9uIHRvICNWRSBvbiBndWVz
dCBURCBhY2Nlc3Mgb2YgUEVORElORw0KPj4+ICsjICAgICBwYWdlcy4gIFNvbWUgZ3Vlc3QgT1Mg
KGUuZy4sIExpbnV4IFREIGd1ZXN0KSBtYXkgcmVxdWlyZSB0aGlzIHRvDQo+Pj4gKyMgICAgIGJl
IHNldCwgb3RoZXJ3aXNlIHRoZXkgcmVmdXNlIHRvIGJvb3QuDQo+Pj4gKyMNCj4+PiAgICMgU2lu
Y2U6IDkuMA0KPj4+ICAgIyMNCj4+PiAgIHsgJ3N0cnVjdCc6ICdUZHhHdWVzdFByb3BlcnRpZXMn
LA0KPj4+IC0gICdkYXRhJzogeyB9fQ0KPj4+ICsgICdkYXRhJzogeyAnKnNlcHQtdmUtZGlzYWJs
ZSc6ICdib29sJyB9IH0NCj4+DQo+PiBTbyB0aGlzIGV4cG9zZXMgYSBzaW5nbGUgYm9vbGVhbiBw
cm9wZXJ0eSB0aGF0IGdldHMgbWFwcGVkIGludG8gb25lDQo+PiBzcGVjaWZpYyBiaXQgaW4gdGhl
IFREIGF0dHJpYnV0ZXM6DQo+Pg0KPj4+ICsNCj4+PiArc3RhdGljIHZvaWQgdGR4X2d1ZXN0X3Nl
dF9zZXB0X3ZlX2Rpc2FibGUoT2JqZWN0ICpvYmosIGJvb2wgdmFsdWUsIEVycm9yDQo+KiplcnJw
KQ0KPj4+ICt7DQo+Pj4gKyAgICBUZHhHdWVzdCAqdGR4ID0gVERYX0dVRVNUKG9iaik7DQo+Pj4g
Kw0KPj4+ICsgICAgaWYgKHZhbHVlKSB7DQo+Pj4gKyAgICAgICAgdGR4LT5hdHRyaWJ1dGVzIHw9
IFREWF9URF9BVFRSSUJVVEVTX1NFUFRfVkVfRElTQUJMRTsNCj4+PiArICAgIH0gZWxzZSB7DQo+
Pj4gKyAgICAgICAgdGR4LT5hdHRyaWJ1dGVzICY9IH5URFhfVERfQVRUUklCVVRFU19TRVBUX1ZF
X0RJU0FCTEU7DQo+Pj4gKyAgICB9DQo+Pj4gK30NCj4+DQo+PiBJZiBJIGxvb2sgYXQgdGhlIGRv
Y3VtZW50YXRpb24gZm9yIFREIGF0dHJpYnV0ZXMNCj4+DQo+PiAgICBodHRwczovL2Rvd25sb2Fk
LjAxLm9yZy9pbnRlbC1zZ3gvbGF0ZXN0L2RjYXAtDQo+bGF0ZXN0L2xpbnV4L2RvY3MvSW50ZWxf
VERYX0RDQVBfUXVvdGluZ19MaWJyYXJ5X0FQSS5wZGYNCj4+DQo+PiBTZWN0aW9uICJBLjMuNC4g
VEQgQXR0cmlidXRlcyINCj4+DQo+PiBJIHNlZSAiVEQgYXR0cmlidXRlcyIgaXMgYSA2NC1iaXQg
aW50LCB3aXRoIDUgYml0cyBjdXJyZW50bHkNCj4+IGRlZmluZWQgIkRFQlVHIiwgIlNFUFRfVkVf
RElTQUJMRSIsICJQS1MiLCAiUEwiLCAiUEVSRk1PTiIsDQo+PiBhbmQgdGhlIHJlc3QgY3VycmVu
dGx5IHJlc2VydmVkIGZvciBmdXR1cmUgdXNlLiBUaGlzIG1ha2VzIG1lDQo+PiB3b25kZXIgYWJv
dXQgb3VyIG1vZGVsbGluZyBhcHByb2FjaCBpbnRvIHRoZSBmdXR1cmUgPw0KPj4NCj4+IEZvciB0
aGUgQU1EIFNFViBlcXVpdmFsZW50IHdlJ3ZlIGp1c3QgZGlyZWN0bHkgZXhwb3NlZCB0aGUgd2hv
bGUNCj4+IGZpZWxkIGFzIGFuIGludDoNCj4+DQo+PiAgICAgICAncG9saWN5JyA6ICd1aW50MzIn
LA0KPj4NCj4+IEZvciB0aGUgcHJvcG9zZWQgU0VWLVNOUCBwYXRjaGVzLCB0aGUgc2FtZSBoYXMg
YmVlbiBkb25lIGFnYWluDQo+Pg0KPj4gaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMjQtDQo+MDYvbXNnMDA1MzYuaHRtbA0KPj4NCj4+ICAgICAgICcq
cG9saWN5JzogJ3VpbnQ2NCcsDQo+Pg0KPj4NCj4+IFRoZSBhZHZhbnRhZ2Ugb2YgZXhwb3Npbmcg
aW5kaXZpZHVhbCBib29sZWFucyBpcyB0aGF0IGl0IGlzDQo+PiBzZWxmLWRvY3VtZW50aW5nIGF0
IHRoZSBRQVBJIGxldmVsLCBidXQgdGhlIGRpc2FkdmFudGFnZSBpcw0KPj4gdGhhdCBldmVyeSB0
aW1lIHdlIHdhbnQgdG8gZXhwb3NlIGFiaWxpdHkgdG8gY29udHJvbCBhIG5ldw0KPj4gYml0IGlu
IHRoZSBwb2xpY3kgd2UgaGF2ZSB0byBtb2RpZnkgUUVNVSwgbGlidmlydCwgdGhlIG1nbXQNCj4+
IGFwcCBhYm92ZSBsaWJ2aXJ0LCBhbmQgd2hhdGV2ZXIgdG9vbHMgdGhlIGVuZCB1c2VyIGhhcyB0
bw0KPj4gdGFsayB0byB0aGUgbWdtdCBhcHAuDQo+Pg0KPj4gSWYgd2UgZXhwb3NlIGEgcG9saWN5
IGludCwgdGhlbiBuZXdseSBkZWZpbmVkIGJpdHMgb25seSByZXF1aXJlDQo+PiBhIGNoYW5nZSBp
biBRRU1VLCBhbmQgZXZlcnl0aGluZyBhYm92ZSBRRU1VIHdpbGwgYWxyZWFkeSBiZQ0KPj4gY2Fw
YWJsZSBvZiBzZXR0aW5nIGl0Lg0KPj4NCj4+IEluIGZhY3QgaWYgSSBsb29rIGF0IHRoZSBwcm9w
b3NlZCBsaWJ2aXJ0IHBhdGNoZXMsIHRoZXkgaGF2ZQ0KPj4gcHJvcG9zZWQganVzdCBleHBvc2lu
ZyBhIHBvbGljeSAiaW50IiBmaWVsZCBpbiB0aGUgWE1MLCB3aGljaA0KPj4gdGhlbiBoYXMgdG8g
YmUgdW5wYWNrZWQgdG8gc2V0IHRoZSBpbmRpdmlkdWFsIFFBUEkgYm9vbGVhbnMNCj4+DQo+Pg0K
Pmh0dHBzOi8vbGlzdHMubGlidmlydC5vcmcvYXJjaGl2ZXMvbGlzdC9kZXZlbEBsaXN0cy5saWJ2
aXJ0Lm9yZy9tZXNzYWdlL1dYV1gNCj5FRVNZVUE3N0RQN1lJQlA1NVQyT1BTVktWNVFXLw0KPj4N
Cj4+IE9uIGJhbGFuY2UsIEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIGlmIFFFTVUganVzdCBl
eHBvc2VkDQo+PiB0aGUgcmF3IFREIGF0dHJpYnV0ZXMgcG9saWN5IGFzIGFuIHVpbnQ2NCBhdCBR
QVBJLCBpbnN0ZWFkDQo+PiBvZiB0cnlpbmcgdG8gdW5wYWNrIGl0IHRvIGRpc2NyZXRlIGJvb2wg
ZmllbGRzLiBUaGlzIGdpdmVzDQo+PiBjb25zaXN0ZW5jeSB3aXRoIFNFViBhbmQgU0VWLVNOUCwg
YW5kIHdpdGggd2hhdCdzIHByb3Bvc2VkDQo+PiBhdCB0aGUgbGlidmlydCBsZXZlbCwgYW5kIG1p
bmltaXplcyBmdXR1cmUgY2hhbmdlcyB3aGVuDQo+PiBtb3JlIHBvbGljeSBiaXRzIGFyZSBkZWZp
bmVkLg0KPg0KPlRoZSByZWFzb25zIHdoeSBpbnRyb2R1Y2luZyBpbmRpdmlkdWFsIGJpdCBvZiBz
ZXB0LXZlLWRpc2FibGUgaW5zdGVhZCBvZg0KPmEgcmF3IFREIGF0dHJpYnV0ZSBhcyBhIHdob2xl
IGFyZSB0aGF0DQo+DQo+MS4gb3RoZXIgYml0cyBsaWtlIHBlcmZtb24sIFBLUywgS0wgYXJlIGFz
c29jaWF0ZWQgd2l0aCBjcHUgcHJvcGVydGllcywNCj5lLmcuLA0KPg0KPglwZXJmbW9uIC0+IHBt
dSwNCj4JcGtzIC0+IHBrcywNCj4Ja2wgLT4ga2V5bG9rY2VyIGZlYXR1cmUgdGhhdCBRRU1VIGN1
cnJlbnRseSBkb2Vzbid0IHN1cHBvcnQNCj4NCj5JZiBhbGxvd2luZyBjb25maWd1cmluZyBhdHRy
aWJ1dGUgZGlyZWN0bHksIHdlIG5lZWQgdG8gZGVhbCB3aXRoIHRoZQ0KPmluY29uc2lzdGVuY2Ug
YmV0d2VlbiBhdHRyaWJ1dGUgdnMgY3B1IHByb3BlcnR5Lg0KDQpXaGF0IGFib3V0IGRlZmluaW5n
IHRob3NlIGJpdHMgYXNzb2NpYXRlZCB3aXRoIGNwdSBwcm9wZXJ0aWVzIHJlc2VydmVkDQpCdXQg
b3RoZXIgYml0cyB3b3JrIGFzIERhbmllbCBzdWdnZXN0ZWQgd2F5Lg0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo+DQo+Mi4gcGVvcGxlIG5lZWQgdG8ga25vdyB0aGUgZXhhY3QgYml0IHBvc2l0aW9u
IG9mIGVhY2ggYXR0cmlidXRlLiBJIGRvbid0DQo+dGhpbmsgaXQgaXMgYSB1c2VyLWZyaWVuZGx5
IGludGVyZmFjZSB0byByZXF1aXJlIHVzZXIgdG8gYmUgYXdhcmUgb2YNCj5zdWNoIGRldGFpbHMu
DQo+DQo+Rm9yIGV4YW1wbGUsIGlmIHVzZXIgd2FudHMgdG8gY3JlYXRlIGEgRGVidWcgVEQsIHVz
ZXIganVzdCBuZWVkcyB0byBzZXQNCj4nZGVidWc9b24nIGZvciB0ZHgtZ3Vlc3Qgb2JqZWN0LiBJ
dCdzIG11Y2ggbW9yZSBmcmllbmRseSB0aGFuIHRoYXQgdXNlcg0KPm5lZWRzIHRvIHNldCB0aGUg
Yml0IDAgb2YgdGhlIGF0dHJpYnV0ZS4NCj4NCj4NCj4+PiArDQo+Pj4gICAvKiB0ZHggZ3Vlc3Qg
Ki8NCj4+PiAgIE9CSkVDVF9ERUZJTkVfVFlQRV9XSVRIX0lOVEVSRkFDRVMoVGR4R3Vlc3QsDQo+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRkeF9ndWVzdCwNCj4+PiBA
QCAtNTI5LDYgKzU0OSwxMCBAQCBzdGF0aWMgdm9pZCB0ZHhfZ3Vlc3RfaW5pdChPYmplY3QgKm9i
aikNCj4+PiAgICAgICBxZW11X211dGV4X2luaXQoJnRkeC0+bG9jayk7DQo+Pj4NCj4+PiAgICAg
ICB0ZHgtPmF0dHJpYnV0ZXMgPSAwOw0KPj4+ICsNCj4+PiArICAgIG9iamVjdF9wcm9wZXJ0eV9h
ZGRfYm9vbChvYmosICJzZXB0LXZlLWRpc2FibGUiLA0KPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHRkeF9ndWVzdF9nZXRfc2VwdF92ZV9kaXNhYmxlLA0KPj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHRkeF9ndWVzdF9zZXRfc2VwdF92ZV9kaXNhYmxlKTsNCj4+PiAg
IH0NCj4+Pg0KPj4+ICAgc3RhdGljIHZvaWQgdGR4X2d1ZXN0X2ZpbmFsaXplKE9iamVjdCAqb2Jq
KQ0KPj4+IC0tDQo+Pj4gMi4zNC4xDQo+Pj4NCj4+DQo+PiBXaXRoIHJlZ2FyZHMsDQo+PiBEYW5p
ZWwNCg0K

