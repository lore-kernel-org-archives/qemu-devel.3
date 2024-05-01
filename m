Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47056C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 12:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29GB-0002XW-TD; Wed, 01 May 2024 08:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s29G8-0002X6-I7
 for qemu-devel@nongnu.org; Wed, 01 May 2024 08:40:28 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s29G5-0001Wb-Ha
 for qemu-devel@nongnu.org; Wed, 01 May 2024 08:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714567225; x=1746103225;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MEXuJGUNJkUGb7LJebRd2OmC2ktzMKl6R0GRV/12qDY=;
 b=YsP0Uniys7FyThZUaZ9U1Fa5wpPDQo6At/0VpwoGvHRRCoyDDv4kAO+4
 ADFkik3Vk/a/1DxQH6rDI2KvlUEJE8Aa6UOpyCPddBuShL3+axRjqJa0W
 m15D7H7Gn7wwszRIPLqLYIk/yAWguR3pfR3zxo+vIUl5F69+QA3MPQfDY
 pQ8vVncxj79Sa8/1jCbfM9bcR6WVpDXx4Oq8FGG27FBM7Dj9WpjcwFAIb
 DFmalZoIyrNpvS8XzQVaqd72Z+vQOY1fO8vperqLx/ttsVCbyk9yv2lIu
 8yjULOvBUXVgIRK55mZ8zDJdVKrXApskMO64sSGxSL9EdK9XPZ9CU7+/X A==;
X-CSE-ConnectionGUID: vT6hhzpjSdedPtk7mHg/Kw==
X-CSE-MsgGUID: mskmL7F9StmChtv35vhd9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10121690"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; d="scan'208";a="10121690"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2024 05:40:22 -0700
X-CSE-ConnectionGUID: uWoGWsu6Q725Eg6ioqDVwg==
X-CSE-MsgGUID: GKEwKPxRRQuupRwbKEkUaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; d="scan'208";a="26730684"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 May 2024 05:40:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 05:40:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 05:40:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 05:40:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TexJHqVi7RV0DavL0BWKIvWKrq1IBDaAMiRGxSDePugz+J7q5GJitpWTf/IIrkP8hFcAMdBA2r1vy2qzB4q1434A7POhBcV99T0OC7BV22/ErApRoulHSS2WilbdxPeXfIvMGkvmusLKIEwGP/wEunxOmRF2xfA/RGqsmP3kFUO05S/YUau8Yo9nEdsf/jlohA3pB8LApyD2fiUloP0le6EOOKcjUaAkLP3ZJAc9ldF+THuIm5fmk/QPd0SscQ6PNzm/gy9UOBZXTI2yQHRbN4aZ+ikxXIjkUhI/ZctiIeqin+ssJ1WfPu/rInlrVwXePyLOfgma1lXVBEDM3tmuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEXuJGUNJkUGb7LJebRd2OmC2ktzMKl6R0GRV/12qDY=;
 b=OXYyBeV62WJAUomDwISb3dDNi3/7Ew5HhNcNlwcPhZIW8HoQO/vo9v+IYJC1mSsM4ZvC4fyZtaPb/c+pz2gvxWlCz87ch4i/5MhUad5gDvD2kvUTXcwH6Qfk/3DDhDxY5rSkb4DYlw6NMJmxoA2sGtJjx1ra4XrhICzB5VpIkcYckNSRkNDPsHizTu0cIjAsZszYcAQzSTqarGxo8zNmncm4Hfviim/nY/+EzCCDRbsTjoFwC5lqxqKCZG86zSH2Ebj66s+FVfRZyh6As4ABm2XYuZP9Wp5CXhpHbSoY4NfOg/LE4xr4e4hKEDOtsip2w160nxAebCzPMCaJvrG3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6606.namprd11.prod.outlook.com (2603:10b6:510:1b1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 12:40:14 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:40:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "CLEMENT
 MATHIEU--DRIF" <clement.mathieu--drif@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Joao Martins
 <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Topic: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Index: AQHamwiDe5j67ytP7Eizl35edXhELbGBjs6Q
Date: Wed, 1 May 2024 12:40:14 +0000
Message-ID: <SJ0PR11MB6744D9C5BCFBA146FE09270492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <9e15abd9-f824-4f11-9532-b0dcb7b521dd@redhat.com>
In-Reply-To: <9e15abd9-f824-4f11-9532-b0dcb7b521dd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6606:EE_
x-ms-office365-filtering-correlation-id: 0303cc0f-7b8e-43f7-9106-08dc69dbd95e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bHFic1FxajkwUUZ0U0cyNDFIbSswaW1MZmZZUU93cUQ4T28zZHpOdWp0eERK?=
 =?utf-8?B?WVR6aWJKWkcxT3ZOY0ZvVmxiWmgrbG1qaW91dFFmeUlHWFRIRmxUdmMrZENL?=
 =?utf-8?B?SWdhbmZYMCs3MktiN2tyYjdTSXBrMnZXTVRBeUlqajk2aVM2WEhBY1BYV0xP?=
 =?utf-8?B?NzJ0RGRuYndrNTYxWVFNU2laM3QxcE4xT0VNSEZjK2tWL1NFdkJVWWNIU1lr?=
 =?utf-8?B?L1lXSmU1eHpPWlM2OEFFaFlCa2IxU3JZYmdWWkFNbGJhSnpSdy9SRVZYcTdW?=
 =?utf-8?B?RlNBTjgxYTZ0TGhNTThCSEE2Zk03ZUFsdURsVnpYKzczVFdYQ01tUjJHUGox?=
 =?utf-8?B?bXhaamZ0WGdkRzY1NCt1ODFRTzZIK1hKZHNGVGd0UjRxWjRuQVdPS1BPRkk0?=
 =?utf-8?B?cWhDaEl1MmRMNXBrU2g1d3I3WjV5VWI2eVR5RHBaVSs4WWNYZFdyS1I3bEVD?=
 =?utf-8?B?S0FtTW9vSjRpVGJabFFHM3dkamFTOFhxbWIxL2ZRZWZDTzU3UU1YZ2xMamlj?=
 =?utf-8?B?ZVZzeUNidEE1WWprbDdOSU1FbmdxelcwQWNpM0owVXBrWVVBTHdQU0FFSkxE?=
 =?utf-8?B?RG1Xck8zQk5ndWsyYmliREY3NlhYd1hMcmE0YlhucmhVZ3lpMmdsQkp4S2lN?=
 =?utf-8?B?TkxEOUxTOGh0cVBDTTZxY1ZIZTlWNzFpa2ErZnFzUUhLQWd6a2h1ajZHQnFo?=
 =?utf-8?B?enRlSHlLcFFlZnJOcVlnTTk2Y01NTzJXdHNYMXd0bmZzaFY0Y09NQm95OC9H?=
 =?utf-8?B?TGI3NktLMWVaZ2tadzZPRDYvQW9kMUVQRC9YbGQxQ1Y2VDVtcHFLd1M3RCtm?=
 =?utf-8?B?cWNTemYvLzFUQVgxUHZDSmdWSGY2TEVuU0hpM0d0Tnl1cEJ4Rnl0THJ5cHM4?=
 =?utf-8?B?WEttSXlEdXVIbExpNTZ2S2VSSSswOTVLMUJxNEc3eldma0VRNkc4a3BFUDNT?=
 =?utf-8?B?M3ZRdnhiVEhwUi91VmNVc2h4Q2tocXIxOVFMRDhKL3Izd2RZaXVKMDVVTU5W?=
 =?utf-8?B?L3ZpcEdtZ2hOQkZFYkpnem02cFVMdm5LcjdvY002dXJsTUQ1WTZZTk9XL2M4?=
 =?utf-8?B?NnNhUHUxSXZablVvTGhraUpTNVlTTkg2RXJnc2JQbUk0R2JVQ3JWTEJLRy9K?=
 =?utf-8?B?TGpEQk9Hem1yQ2VnRm1IODFlYzZMYkQ1Lyt5OXhadllsb3dvZG1aSE01Mk16?=
 =?utf-8?B?d2ZkRnMvenJVWU5PMHgxZHNUYmdCVWdLb0RnV0JHd2YyMjZ2WWZTcThTN3Rv?=
 =?utf-8?B?QmpYc1NLQjdYRjY0SytrZTd5SXVEb2VsbHNKQlpYZEpmM1RKekxwK2dZbFNa?=
 =?utf-8?B?YmlobGp6VWlrV0JiRUlUM0xZNU44ZzlwY2dHUEQvczNZSFNkMGtHb0VxNFdh?=
 =?utf-8?B?VWpNM1o0eTJnYjh4WEE5UXpUc2ZnckhCQzJsODl0UE5SOTUzdzJJUFFyTlAz?=
 =?utf-8?B?M0tMUkRST2R6UG9KcHhtNGl1d1FTZ0svdEJwMkJnWGcvRDE5Sk9QUUtQa3I2?=
 =?utf-8?B?TGpQWUEyWXU2dVF5c2NjN3VFRVlzK1hGUW9obm51MkNHaHg3WFZEd2orZi9l?=
 =?utf-8?B?WEJBV0kzNWtVNURRTm1CQUZMbkdFbnJjazl1Tk1ycFdFZ3RBSmdRVnVqcnVE?=
 =?utf-8?B?SWU3bEF6OCsyRGtxeG14Y0VrdC9IVFFYekRYZEFONktROHJwUkFOTEhNQVdK?=
 =?utf-8?B?aFlBNVhncUdwYU1iTm5aeXE5RDd0Q3RvaU1qK0treks0dXY2Q0lsUjRQSGc0?=
 =?utf-8?Q?Bi7sE4Wi8g8mCtzoPs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2xqMzl0eHI2cTJPZERMaVJCcTUrVTQremlVVDdHNkRVZkxqcVR4YkhVbnNi?=
 =?utf-8?B?NU9icW5GM3NOa0ExODBHTGRLV3dRbVp4cXBPUG9SdjA0ZVVzMWRnZG0wVlNK?=
 =?utf-8?B?SjVlZHM0NWFyVnhnVDNrZXZPSVlWMGwwTnVUUVhQbVRXN0MzSnVkU3JzNE5Q?=
 =?utf-8?B?eXFrWHhxQThlZUN5dHl4WTBXQTBmQjJkTkFwUzJ0eHFqb2w3K01uRm1LM3ps?=
 =?utf-8?B?VXBJRVJRMzhQdVh2cG5icHF6U3pxYXBTK0dwZXhvMHh1empSQ1MvZG5YNmZZ?=
 =?utf-8?B?TmR0M2VWVTBCVC82VTBxZXVMY0RoVXlwT2JkUEg5b25KSTZPb1JsV2pGYk0v?=
 =?utf-8?B?NTRmSVJ5YXE4OC8vaCtjc0Q0YnMrdTNDVU9WM3FxWk0vdE1GRkw0YlZTNzZS?=
 =?utf-8?B?cnEwODVzOU1jakFWNlpmdDFjN3dReVk2YXpRcVVjMElzL2hKeWJIdGpnaHJq?=
 =?utf-8?B?OTZkTXp5elJNcjlFZU1KUkxmWjV5UjQ0TjJZd1Zsb0taL2NrVHJUMWhtSnZi?=
 =?utf-8?B?T04wVjVYMUVBOW5JSGRmSXFRc0VxQjc3TUlLU1F5YU83Z3l2WkJRREdWNkVK?=
 =?utf-8?B?cW5QS1hlZ2JpcmtISWJoNEhxQjh2Q0puaXk0SzRDbXhWQ2J3ZXFmejdpaUVB?=
 =?utf-8?B?WFA0SU1qb1N1TFNHT0czU3hLaEVDL01tbGMwS3JCdmFxZjBiMWg4M3dUZ3pi?=
 =?utf-8?B?YnIwb21ESWNLUUREc0NjMGIzcTJRTlNReElYN2psVjB0N0x5VVUyeEVCeVJh?=
 =?utf-8?B?cnpIZ0xySmoxR3Y1a3NJMXdTMFpYZVdiMVZlUEU4TDhlZWxmMEt2NkVmYnlO?=
 =?utf-8?B?SnZaM29qUXBJUzNUZWlrR0VIMysxMERDa1luZW9KMENBcEtiek9Ia1dNSENE?=
 =?utf-8?B?TVk4SmdkL01vR2lIdWdVZDdvS3A5bFFFeDl1Q2k3T0VBOVhPbDRBWUNSNHR5?=
 =?utf-8?B?WGg1bzl6MkpEaEZuTU5vbDI5b3Q3UTJxNnQwZUJ5dEs0R212M2JZVlA3dHc0?=
 =?utf-8?B?c2V1MURsY04vU3daQTc4RDAvU3BMS1Rqb0QzakRxOW91N3haRkhvRExKTnF3?=
 =?utf-8?B?KzE0TjRzVXpWc0ZScWl3bERyYW94bWpHYklRU3p4aEM3QXloaGVHNEN2UEtQ?=
 =?utf-8?B?T0l6MU9jRUJKYkdadU5CZzJudXU0dVFrbXZlMENiTmV6VlVMb3YrL3p3L3p0?=
 =?utf-8?B?dWkzQXQwNmtoVnVVNmtNaElFWlZuZElTbmlCREhCcVFlRWMzYUFnSXROQnl0?=
 =?utf-8?B?RzIwK2JBditEOWI1T3B1aUorZjhUUmtLUnRYTVo3SGI2QWI0M01WVTk0c0lq?=
 =?utf-8?B?cm9xakVJMVNSZkxzRmdFOEV1cVNQMkhKYjUrRUdVdkdmZ0ovaSsxTjd5UC9P?=
 =?utf-8?B?SCtNcm9ISFplYVBXQSszS3FPdjhuQmY3QW9WNiszeEhMTWRUcnMxcXNMS0N0?=
 =?utf-8?B?SzI0MzJnK0pFVmJvMFd2Nm9Mc3lwWXlJZDloVVhLMlFSN0NmWTM1bHZBb0s1?=
 =?utf-8?B?Y2pXazdoZUV4OUM5c2VKMXRQQTBwQ1dEZjRZK00vQnd3bnR6T3FCZGtZVlZ5?=
 =?utf-8?B?NnlPVGtvdDE2RzdvckI0bk5YZlgwL2MwaEoycnVlWjdQajFQR2J5QzJWRllj?=
 =?utf-8?B?R3NEOTZ0OTJPaWd3YTJTYnU2U0xTZmkvcitUc21tL251WHpHRTJqcWZ5RTNC?=
 =?utf-8?B?eVQwWmdjWlR2NzlOZlYxb0dqVUVjMVNSQ3U2VXdlSXl2VWZHNEUybTRYcUxv?=
 =?utf-8?B?VEJvLzRXOXl0azlqZFlYTmV5b2NRM09oc2RVbGxORGJtRDlHZHM2Mk9sOHAx?=
 =?utf-8?B?a1luK3ZBQi9jL2Y4UjdhczIzT3kwRCt4QUNpMFpHVnlvOGlieG1tRmRZYW5u?=
 =?utf-8?B?L0FJNHJzWWNhek42aS91Q0pVVEE5eWJhektJV3JKRWo5SkdXMVdnUHN3MTZC?=
 =?utf-8?B?bE9va0FJU1JPUEw2ajkyMVA0bDhqTk1YSDRGYmVPSEFVcytOLzdObTNuMkhG?=
 =?utf-8?B?dkpoY09iZmJGd2M4M2ZBeDFvT2VKdDdxeHovUm5WZ2xxeFpxeWszT1pZejNI?=
 =?utf-8?B?bUcxWEhNdnY0eWFXbHpUZUcxWWFuZzZmTGFHbEZOM2hBZnFmMjJUNVlITEY1?=
 =?utf-8?Q?qwJaYnHZ1gg3tyU7u08gZMC5p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0303cc0f-7b8e-43f7-9106-08dc69dbd95e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 12:40:14.4762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8qt6pP5EwXYZPCvPr6P4YDBcXF3sYH36ltwD9FJyDXxvh/KzB34aaJkjDk4NMYCPWEXopHm34MfDbUWJ/W7CAH1in6qopMErrRhp+szys4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6606
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

QWgsIHRoaXMgaXMgYSBkdXBsaWNhdGUgZWZmb3J0IG9uIHN0YWdlLTEgdHJhbnNsYXRpb24uDQoN
CkhpIENsZW1lbnQsDQoNCldlIGhhZCBldmVyIHNlbnQgYSByZmN2MSBzZXJpZXMgImludGVsX2lv
bW11OiBFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiINCmZvciBib3RoIGVtdWxhdGVkIGFuZCBw
YXNzdGhyb3VnaCBkZXZpY2UsIGxpbms6DQpodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9o
dG1sL3FlbXUtZGV2ZWwvMjAyNC0wMS9tc2cwMjc0MC5odG1sDQp3aGljaCBub3cgZXZvbHZlcyB0
byByZmN2MiwgbGluazoNCmh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXRz
L3poZW56aG9uZy9pb21tdWZkX25lc3RpbmdfcmZjdjIvDQoNCkl0IGhhZCBhZGRyZXNzZWQgcmVj
ZW50IGNvbW11bml0eSBjb21tZW50cywgYWxzbyB0aGUgY29tbWVudHMgaW4gb2xkIGhpc3Rvcnkg
c2VyaWVzOiANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9rdm0vY292ZXIv
MjAyMTAzMDIyMDM4MjcuNDM3NjQ1LTEteWkubC5saXVAaW50ZWwuY29tLw0KDQpXb3VsZCB5b3Ug
bWluZCByZWJhc2luZyB5b3VyIHJlbWFpbmluZyBwYXJ0LCBpLmUuLCBBVFMsIFBSSSBlbXVsYXRp
b24sIGV0YyBvbiB0byBvdXIgcmZjdjI/DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4tLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0
LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIGludGVsX2lvbW11IDAvN10gRkxUUyBmb3IgVlQt
ZA0KPg0KPkhlbGxvLA0KPg0KPkFkZGluZyBhIGZldyBwZW9wbGUgaW4gQ2M6IHdobyBhcmUgZmFt
aWxpYXIgd2l0aCB0aGUgSW50ZWwgSU9NTVUuDQo+DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQo+DQo+
DQo+DQo+T24gNC8yMi8yNCAxNzo1MiwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4g
VGhpcyBzZXJpZXMgaXMgdGhlIGZpcnN0IG9mIGEgbGlzdCB0aGF0IGFkZCBzdXBwb3J0IGZvciBT
Vk0gaW4gdGhlIEludGVsIElPTU1VLg0KPj4NCj4+IEhlcmUsIHdlIGltcGxlbWVudCBzdXBwb3J0
IGZvciBmaXJzdC1zdGFnZSB0cmFuc2xhdGlvbiBpbiBWVC1kLg0KPj4gVGhlIFBBU0lELWJhc2Vk
IElPVExCIGludmFsaWRhdGlvbiBpcyBhbHNvIGFkZGVkIGluIHRoaXMgc2VyaWVzIGFzIGl0IGlz
IGENCj4+IHJlcXVpcmVtZW50IG9mIEZMVFMuDQo+Pg0KPj4gVGhlIGxhc3QgcGF0Y2ggaW50cm9k
dWNlcyB0aGUgJ2ZsdHMnIG9wdGlvbiB0byBlbmFibGUgdGhlIGZlYXR1cmUgZnJvbQ0KPj4gdGhl
IGNvbW1hbmQgbGluZS4NCj4+IE9uY2UgZW5hYmxlZCwgc2V2ZXJhbCBkcml2ZXJzIG9mIHRoZSBM
aW51eCBrZXJuZWwgdXNlIHRoaXMgZmVhdHVyZS4NCj4+DQo+PiBUaGlzIHdvcmsgaXMgYmFzZWQg
b24gdGhlIFZULWQgc3BlY2lmaWNhdGlvbiB2ZXJzaW9uIDQuMSAoTWFyY2ggMjAyMykNCj4+DQo+
PiBIZXJlIGlzIGEgbGluayB0byBhIEdpdEh1YiByZXBvc2l0b3J5IHdoZXJlIHlvdSBjYW4gZmlu
ZCB0aGUgZm9sbG93aW5nDQo+ZWxlbWVudHMgOg0KPj4gICAgICAtIFFlbXUgd2l0aCBhbGwgdGhl
IHBhdGNoZXMgZm9yIFNWTQ0KPj4gICAgICAgICAgLSBBVFMNCj4+ICAgICAgICAgIC0gUFJJDQo+
PiAgICAgICAgICAtIFBBU0lEIGJhc2VkIElPVExCIGludmFsaWRhdGlvbg0KPj4gICAgICAgICAg
LSBEZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9ucw0KPj4gICAgICAgICAgLSBGaXJzdC1zdGFnZSB0
cmFuc2xhdGlvbnMNCj4+ICAgICAgICAgIC0gUmVxdWVzdHMgd2l0aCBhbHJlYWR5IHRyYW5zbGF0
ZWQgYWRkcmVzc2VzDQo+PiAgICAgIC0gQSBkZW1vIGRldmljZQ0KPj4gICAgICAtIEEgc2ltcGxl
IGRyaXZlciBmb3IgdGhlIGRlbW8gZGV2aWNlDQo+PiAgICAgIC0gQSB1c2Vyc3BhY2UgcHJvZ3Jh
bSAoZm9yIHRlc3RpbmcgYW5kIGRlbW9uc3RyYXRpb24gcHVycG9zZXMpDQo+Pg0KPj4gaHR0cHM6
Ly9naXRodWIuY29tL0J1bGxTZXF1YW5hL1FlbXUtaW4tZ3Vlc3QtU1ZNLWRlbW8NCj4+DQo+PiBD
bMOpbWVudCBNYXRoaWV1LS1EcmlmICg3KToNCj4+ICAgIGludGVsX2lvbW11OiBmaXggRlJDRCBj
b25zdHJ1Y3Rpb24gbWFjcm8uDQo+PiAgICBpbnRlbF9pb21tdTogcmVuYW1lIHNscHRlIHRvIHB0
ZSBiZWZvcmUgYWRkaW5nIEZMVFMNCj4+ICAgIGludGVsX2lvbW11OiBtYWtlIHR5cGVzIG1hdGNo
DQo+PiAgICBpbnRlbF9pb21tdTogYWRkIHN1cHBvcnQgZm9yIGZpcnN0LXN0YWdlIHRyYW5zbGF0
aW9uDQo+PiAgICBpbnRlbF9pb21tdTogZXh0cmFjdCBkZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9u
IGxvZ2ljDQo+PiAgICBpbnRlbF9pb21tdTogYWRkIFBBU0lELWJhc2VkIElPVExCIGludmFsaWRh
dGlvbg0KPj4gICAgaW50ZWxfaW9tbXU6IGFkZCBhIENMSSBvcHRpb24gdG8gZW5hYmxlIEZMVFMN
Cj4+DQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDY1NSArKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLQ0KPi0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oIHwgMTE0ICsrKystLQ0KPj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAg
fCAgIDMgKy0NCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA2MDkgaW5zZXJ0aW9ucygrKSwgMTYzIGRl
bGV0aW9ucygtKQ0KPj4NCg0K

