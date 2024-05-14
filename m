Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEB0C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 08:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6nPP-0001gN-4v; Tue, 14 May 2024 04:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6nP3-0001bL-4E
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:20:53 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6nOs-0000v8-3S
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715674842; x=1747210842;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YtrudngJ9ah5SaDJ2AJxyR4NuYcKSVrn3mEt3HyKUTQ=;
 b=ceDX87epk5KKDGLKrTWlu8M8mRdzKXfoTd3arUoRSVi4S5T5LnJHtJl+
 vzdhivRPuGoeXga0SilktO2ZmcaS+lVBVhwPHj6TFfoxfX22R9X/p+rkF
 eB8MhF3TlyvRgOB0LEeaSb8xtiTq+MA1i5l82LZgMRhe3zRBLuRGOWFBR
 k+n9y4NyqHaFBDDVHU6s8jSV5+hp8tbQmLH7tGgqaC9thgDLCvbEo8lP2
 XIpI13zK1AcmKLTshemcsQbHmtQuoujNnySJoyBuiiKe5QW6CmVYEvfpj
 1P2GdDciY5arYAaZh91GPi4LcySKMw47SbbeTDmniRvKSwiXqwTeKXYrW g==;
X-CSE-ConnectionGUID: a3QEq5r7SMG7+Q4SRYDyTQ==
X-CSE-MsgGUID: riskXMKiR1mba4ozVjr9bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11513247"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11513247"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 01:20:38 -0700
X-CSE-ConnectionGUID: GnxWlOPaSsq4C7hrd45CgQ==
X-CSE-MsgGUID: xZfPsWCCTVywyLqU8CeeKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="61788937"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 May 2024 01:20:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:20:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:20:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 01:20:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 01:20:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcuW/mKC6iD5sYssEZVQ0V0CvPaI+LcwhP1bU4Qe4ag174MVYTk35SEBZ0YoijYNdYY+UsNpR77f5GW1FOGIsVYD/SrtPakU1kpdmAl0IggE25H8dxLxtwbGB3bQRUq5PFrW94h+7qSATg9KYweZ5jQEvDVqq55Y29YAtvMgyf9QiUiFkfQ4KmYs9WdMhhXXcqf6GA2VKRMYuR8W7eSBLRAws87z1vtLFxhiERyI3xxn0+W8J7v64sgX/OB6/ZcS1jzC+DDwVzyQWueAh/3OYw8Fhob8AdeSjdSiRbPVW9z/+dsPzG9wWCqNW7MsxZi/JIP//aRExU4J71iaqA3osQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtrudngJ9ah5SaDJ2AJxyR4NuYcKSVrn3mEt3HyKUTQ=;
 b=FtkRSCeluPUdXFtAi+SD9IUevwQpfqEJKw6apWUY0Lu3NjRrQqfejuGFCoyNCCJNlX5DwYadpdn5Bqu9bY8ghFKx/Gyx3hRSJ0NNsoflHwDnkZfZM873awUaWTuJAietmOSUutO9UbzG22GcWs+MHeQzZju7CQlHWzKgMPIrFX/c5fK2EpTJ5SmqWQAaLJ0gOlUgSkx3tWSH38vC0oM1o4ran5nT4xn5WCJ1TYAgbSXQ/Mt2jTcHcl3Ncmc8k5P6LTeDnzgBsGi+6M2cujQ34IjJxXLl1Oae4igcaIP2d49W9FSY9sOHJfcwWy6QHbJGaxnxiVjweVtJuDBejfyEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:20:34 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:20:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH ats_vtd v1 07/24] memory: add permissions in
 IOMMUAccessFlags
Thread-Topic: [PATCH ats_vtd v1 07/24] memory: add permissions in
 IOMMUAccessFlags
Thread-Index: AQHanKWKfeVETgNmjUqQ/TzCNPUG5bGWdZ9w
Date: Tue, 14 May 2024 08:20:34 +0000
Message-ID: <SJ0PR11MB6744D2B3E8304AB60F6E5A4B92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
 <20240502152810.187492-8-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-8-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ2PR11MB7520:EE_
x-ms-office365-filtering-correlation-id: 8ea0e770-4202-4da4-50f0-08dc73eeba3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OTZDR1FUdE5YWHJRYW44cFVCaHR2TGNhQUNyZFU1YWlPWTlEQk1aMHl6dk9y?=
 =?utf-8?B?V2NoRm1YRGJKUTdLZUw1MWNjMVlVTVdpZG45SlYvM3ZmUVZib094QkloNXhu?=
 =?utf-8?B?UFpUd2NkdjV0dE1TdERVbGlxY3ZxRlRJcGFtQk5RQmlPMHdQSDhhQzlsdjFV?=
 =?utf-8?B?VjFvMi9zWk96OGMxbUI1UG5MMXVYeDFINFFTd293ZmFrVVJjc3l1cUd4UnlE?=
 =?utf-8?B?anRkaUd5eVZVQnI0Q2JiWDNDUFpSNHN5R1lQQjdKM0ljN25Sa2lwcmsyRTNq?=
 =?utf-8?B?ZTRZVHlPOFVpVjRSa1BJSUhMOEwwZ1E4N1pQRE5QTWxRZjhSdEQxMmt0Z3RW?=
 =?utf-8?B?dFVRWVhYaFB2dTA2UC9hTjdrbjVhSDFDcWVwcXRNdjVDR2ZISDhZN1VBT1pP?=
 =?utf-8?B?bHdaS0xUT2U3M0plbWZwcU5wY1o0MWlRbGVydnRpZ1dYRkVUYnVQdGcrMkU2?=
 =?utf-8?B?WVB3cDBpWmQ0UlVOSkdVVGVKTDcydjlITHU3c2x5MEJpaDZPUUtkV2k0bXNS?=
 =?utf-8?B?VVhHQURFK1FwTlhReGlpZFRGRHNDNWRZbkhHMzlMVlQ4Y2RwZitUcGFORjhY?=
 =?utf-8?B?U2lPM2ZSTzUrNDEzK3dLb3k3UGRHMkxIWXFBdEJpa3FqNDNXVkFRTkFucHhV?=
 =?utf-8?B?dlQ4eU9pZjVNaFVzUnpXK2VEMDdHVmw2ZlJuVldjNmJOMTE2eDFzSlZRWXRh?=
 =?utf-8?B?L2RiQkV1NVJONEk5TXViMGFiNHN0R3VJMm5uRldZSnJPQjhjYkhCbGRDazdV?=
 =?utf-8?B?N1lYWS9vcEhheDdJVFNTTWEyZzJSd3l2bXR1S3NvSGVLZ3VsWjdna2NjK1g3?=
 =?utf-8?B?QmdtZ3dQN2tIWlJ6eUJVbFpGaVd5NVpoZDBQQnNSb05PL2w5ZFN5ZWtTWnA0?=
 =?utf-8?B?YkhXUE11WWdMMmlhd3pmS3JkNXIrQlFGK0IvTXNzNG9mR2p0Z0xiTFltRk54?=
 =?utf-8?B?cGI4YTRKSTZuWnVqSXMxMGRmRE1JMVRkbjhqY1lMa0sxbklWUXJSeW1FYUtr?=
 =?utf-8?B?cG5LYzhKcG1wSWxOTk0rdUVXaUVqcHBoWGhUeC9nRDFya0ZiSkdJMWRQWXdZ?=
 =?utf-8?B?bmFwcGJNZDEzdVBFWFZHRE5tNEwvWjJuc0RjOVhRUmdWZ2xxbnNjK0NpOUxP?=
 =?utf-8?B?S1FObDh6MnZKdTFzbUw5WmZyTTZxK2VpWjE2OWdBWFhvcC9FYnVXa0lXK2hr?=
 =?utf-8?B?ZmZ3MFpzNEMzZFM4TmliWm91Z0ppdzhTSllKMFE3ZWRzbHpKTW9CUVhpNWUy?=
 =?utf-8?B?eWRudDRnNXZMN1c4K1RWQ3hnWUZTVFg2VWdxT2dXaXZBWFJBMjRhOEVLb1o1?=
 =?utf-8?B?R0lYeHZuc0dOSGZPWFRWZWZtcDl5L3FkQzJ6M1V3Ujk2UTF6ZnBYdzg5ZnQ3?=
 =?utf-8?B?MDhLRUJKN3JubklXeGlpQVJsK3J5SUVUWlE5NytpdGd6OGlSR1d3cXRiOVN4?=
 =?utf-8?B?L0dTUFNWRlNXaitRMnUzQ1k3M2JrUG5nK05mQnhJb3lyWjhpU0VEWTRQTEdY?=
 =?utf-8?B?OXRBTVdpUnZFM09wN2FvamZYNThYMUVoY1dZVjJiV0duYW81dWZyOVNkSEJC?=
 =?utf-8?B?bDBneHFhcmJzemJmU0psTnp3RFMxRWdSUkJNRHJBOUwwMjM3TGpiMS83TVBv?=
 =?utf-8?B?TmVrUHFlemwybXZsdmIzUXhYeWoxVkxRWVJYM1hGd0FCSDM3KzBYdDlvTWhB?=
 =?utf-8?B?b1F4L2RrZjBEOHJjQUM1b2RWWmlmdmd0MDhVbEROQTV2ZTFBMkxKR0FmWk96?=
 =?utf-8?B?YkZtNFFMMmdDTHNuZXJTZDJPZUdUR0Y5L3kySnozbldWNmpUak8zeUpXQ1ZZ?=
 =?utf-8?B?QmQ1SXhha2xScjJqMEtXdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlJBSFhhLzI1SW1TWjlneS9VWTc4d1B1YWNSTVJQaDR6YWN6dVJoVGRGTjdw?=
 =?utf-8?B?aGFsaG9nSFZ1SXJZb3lXOS9RdzZzc0hCWkJGUjNDTC9aRXRZL2ZUQ0VCWHd3?=
 =?utf-8?B?OVBzQ1R1S1orVDdlMitiQUV6UmM4YW95WXJydXBhYXJZc3Naa2JQc0dzWlBj?=
 =?utf-8?B?cDJLMHlHWW9lY0Zld05US25LOUcvRFRlN0t3eU1rdy95ZWZ4c2d0b1d0OFA3?=
 =?utf-8?B?ZkxQa0hUSDNrczJsTiszcUkzKzByOTNoQmJIM0dvTVhQOFRFYkhFdC9kNUxt?=
 =?utf-8?B?ek5CREFxZnJwSmJJMWNQdGdmbHVxWEpzSzJjUnV3MTJWZEFVS3ZCKzVKUFdK?=
 =?utf-8?B?bnBRaDJQWm1Bai81U0tJL29uS3VVNDZ1aVhYR1k1cTB1QjgvZTZSNlVvRGFK?=
 =?utf-8?B?ZkIzWEpqVExwa2g3eFZVZ0NsbzA5cXVKTVA5dE4yZHVqRmN6OU12RHhzV01I?=
 =?utf-8?B?dG5TaTlXSEpkN1JhcGQvVUhoNWNwdlRTZ2JJRmIrMTRaenBOcVZHb2tscTUw?=
 =?utf-8?B?WTFBWU4ydjY4QkR0Y2FBa3lRK29oZm1zSlEwSnE3OHFqZ1lFU09TZGVpSm1u?=
 =?utf-8?B?SFpONUVMRjJNckFuNDJkeGxnclRBanJreml6TmpFWUpnMHIvRGJlaTIrbVlU?=
 =?utf-8?B?K2J0ZFNLQitnZ2E0eXJHbnpOWjhlcVEyZFlSdHZXRzlaaTJPWVhFREx4aWlW?=
 =?utf-8?B?N0pGdDR5WGRPUkhOWTBFODQ1UVlvVEtFV2FrTDhZOWhRaDBHQXI3MWhpOW1r?=
 =?utf-8?B?MjBSRnZSTEdvQ05tZXMwRXdJSUVJRXIyYnRDZWxiQzI1eGhzMkN4eit5UTRj?=
 =?utf-8?B?Qy95WjVYK2RDSDNtK3lhcnhxRGo1YkZXR1FSSklpUG9CdkhOUmZ3NkVoc2oz?=
 =?utf-8?B?U3ZkQUY2Zm0zQnQxOE9KZUJlcE1WQnd6OUc5cUFqZ0svMEh4blRGWEpKWnFL?=
 =?utf-8?B?eHh4MGoyR1pnaUMvQ3FNUjBtN2huV2JhUTJWWWl6aWgrc2tJV2g5N2Mwemdh?=
 =?utf-8?B?Yi84dUpxY3BqVUFRT0V2YVQ0L2c2eTQzZlpueWd6MGpES1UrczFhUDhhUDZT?=
 =?utf-8?B?Vm1PMm5TT2VzVXdYWnBxTktKUHU4MUFpV0xkSmI2V25BNzZ3UmdrWkswa2l6?=
 =?utf-8?B?L0ZUWXQyelVWSFY1Vy9HQTRZcWJGOHJwUEY2MFJ6S1V3TlhxMVViK0VHYUhD?=
 =?utf-8?B?RWdjWjkzWGRIOVFSMTBYQmJsU1NUVXF2Qm9nMTZaTlFpUEw5WTBTRWROQ3dY?=
 =?utf-8?B?WU5WUEh5SVhZUFJhSjBZVlk2Wk90cVErZ25TM3I4SXRpMzhoWHJhZ0JnKzZS?=
 =?utf-8?B?dHdDYjF5TXdmb3VnZ0Yrb0s2SEw0RkxlT0N5MXpUYVp2dkFvamhwa0YyRkM4?=
 =?utf-8?B?VFVIdENPZXdNV01xVFVVYTByS3lwT0hlLzdvcHFaakYxVnpuUFIxWjVJampn?=
 =?utf-8?B?SnFKSzBEVGxYbUhPZ3hLcTdrMUpBK01FdTRnR0NkYkxkQ3FPQUNZWkowQnBw?=
 =?utf-8?B?Ymh6Z0MyLzBHaytIRldWNnJxZVRZTHI5Ujg5SkdpcVVRalVROEQ2bHB2Wnlq?=
 =?utf-8?B?WEFkTjZEUnBkRWd2bTh0dXJqajlqc1Q2MFNaQUcwdW1YZ25xSU5xQXdoK0JX?=
 =?utf-8?B?K001ZVB2TWo3WGhkWGRMZkV1TGZpejRNQWZkZ3pZZ3hYVDRKZFNmZEJLUy92?=
 =?utf-8?B?cktVUWx2VlRxRHkwZlJBTGwzL1NOT1V0Rm4rSm9VYm15UmxSMnpIZk1nNDli?=
 =?utf-8?B?SjZwd0FRNzNhTXBZRnhQUGVraS9vSW5YQnpTcXJmdlNvWjl5SExnam84Z05I?=
 =?utf-8?B?QmZCRXBTelNCK0p1ZnRlaW9VTVJvNU5ucjN4a3V1U09VRTc2MjJ1RkVNNzJL?=
 =?utf-8?B?MWE0cjNJYTlMMUczMFdNSUNxMmhXZG93eS91a1dKZHg4ak9aYkkxNjArVGlC?=
 =?utf-8?B?S0RFenQ4dW5uMU1XQXF6WDFmVHFaeUMwK3ZaUmNtSmRzaUNvelhMeE1iUnlD?=
 =?utf-8?B?Z3YxT1BOQUQzbTFEaEtxTEhMZ0FxN2dndHhWN2dKb3JZV0xLek5oOWlTUGNO?=
 =?utf-8?B?Z2Yrbnd6cVFyWTRDZXhwRFNQYWtGS2JnTVJxOFlJdkd0MzVObzBWSHFVZGJk?=
 =?utf-8?Q?je4VgdzHQPEvnF6W9q82wgCu+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea0e770-4202-4da4-50f0-08dc73eeba3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:20:34.3247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkJrNzWpzMVgMPtkGGDbvl8EpiT3puZhgZLJC+0M5wJgRw+BCv2+wfQDeyEojaDf2UkR/a5h8LiXw8Q6pK2pJx4iX7MpYVes6rQuS7/WJH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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
IGF0c192dGQgdjEgMDcvMjRdIG1lbW9yeTogYWRkIHBlcm1pc3Npb25zIGluDQo+SU9NTVVBY2Nl
c3NGbGFncw0KPg0KPlRoaXMgd2lsbCBiZSBuZWNlc3NhcnkgZm9yIGRldmljZXMgaW1wbGVtZW50
aW5nIEFUUy4NCj5XZSBhbHNvIGRlZmluZSBhIG5ldyBtYWNybyBJT01NVV9BQ0NFU1NfRkxBR19G
VUxMIGluIGFkZGl0aW9uIHRvDQo+SU9NTVVfQUNDRVNTX0ZMQUcgdG8gc3VwcG9ydCBtb3JlIGFj
Y2VzcyBmbGFncy4NCj5JT01NVV9BQ0NFU1NfRkxBRyBpcyBrZXB0IGZvciBjb252ZW5pZW5jZSBh
bmQgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCj4NCj5IZXJlIGFyZSB0aGUgZmxhZ3MgYWRkZWQg
KGRlZmluZWQgYnkgdGhlIFBDSWUgNSBzcGVjaWZpY2F0aW9uKSA6DQo+ICAgIC0gRXhlY3V0ZSBS
ZXF1ZXN0ZWQNCj4gICAgLSBQcml2aWxlZ2VkIE1vZGUgUmVxdWVzdGVkDQo+ICAgIC0gR2xvYmFs
DQo+ICAgIC0gVW50cmFuc2xhdGVkIE9ubHkNCj4NCj5JT01NVV9BQ0NFU1NfRkxBRyBzZXRzIHRo
ZSBhZGRpdGlvbmFsIGZsYWdzIHRvIDANCj4NCj5TaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRo
aWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4tLS0NCj4gaW5j
bHVkZS9leGVjL21lbW9yeS5oIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
DQo+IDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0K
PmRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvbWVtb3J5LmggYi9pbmNsdWRlL2V4ZWMvbWVtb3J5
LmgNCj5pbmRleCA4NjI2YTM1NWIzLi4zMDQ1MDRkZTAyIDEwMDY0NA0KPi0tLSBhL2luY2x1ZGUv
ZXhlYy9tZW1vcnkuaA0KPisrKyBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KPkBAIC0xMTAsMjIg
KzExMCw0MSBAQCBzdHJ1Y3QgTWVtb3J5UmVnaW9uU2VjdGlvbiB7DQo+DQo+IHR5cGVkZWYgc3Ry
dWN0IElPTU1VVExCRW50cnkgSU9NTVVUTEJFbnRyeTsNCj4NCj4tLyogU2VlIGFkZHJlc3Nfc3Bh
Y2VfdHJhbnNsYXRlOiBiaXQgMCBpcyByZWFkLCBiaXQgMSBpcyB3cml0ZS4gICovDQo+Ky8qDQo+
KyAqIFNlZSBhZGRyZXNzX3NwYWNlX3RyYW5zbGF0ZToNCj4rICogICAgICAtIGJpdCAwIDogcmVh
ZA0KPisgKiAgICAgIC0gYml0IDEgOiB3cml0ZQ0KPisgKiAgICAgIC0gYml0IDIgOiBleGVjDQo+
KyAqICAgICAgLSBiaXQgMyA6IHByaXYNCj4rICogICAgICAtIGJpdCA0IDogZ2xvYmFsDQo+KyAq
ICAgICAgLSBiaXQgNSA6IHVudHJhbnNsYXRlZCBvbmx5DQo+KyAqLw0KPiB0eXBlZGVmIGVudW0g
ew0KPiAgICAgSU9NTVVfTk9ORSA9IDAsDQo+ICAgICBJT01NVV9STyAgID0gMSwNCj4gICAgIElP
TU1VX1dPICAgPSAyLA0KPiAgICAgSU9NTVVfUlcgICA9IDMsDQo+KyAgICBJT01NVV9FWEVDID0g
NCwNCj4rICAgIElPTU1VX1BSSVYgPSA4LA0KPisgICAgSU9NTVVfR0xPQkFMID0gMTYsDQo+KyAg
ICBJT01NVV9VTlRSQU5TTEFURURfT05MWSA9IDMyLA0KPiB9IElPTU1VQWNjZXNzRmxhZ3M7DQo+
DQo+LSNkZWZpbmUgSU9NTVVfQUNDRVNTX0ZMQUcociwgdykgKCgocikgPyBJT01NVV9STyA6IDAp
IHwgKCh3KSA/DQo+SU9NTVVfV08gOiAwKSkNCj4rI2RlZmluZSBJT01NVV9BQ0NFU1NfRkxBRyhy
LCB3KSAgICAgKCgocikgPyBJT01NVV9STyA6IDApIHwgXA0KPisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAoKHcpID8gSU9NTVVfV08gOiAwKSkNCj4rI2RlZmluZSBJT01NVV9B
Q0NFU1NfRkxBR19GVUxMKHIsIHcsIHgsIHAsIGcsIHVvKSBcDQo+KyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIChJT01NVV9BQ0NFU1NfRkxBRyhyLCB3KSB8IFwNCj4rICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCh4KSA/IElPTU1VX0VYRUMgOiAwKSB8IFwN
Cj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKChwKSA/IElPTU1VX1BSSVYg
OiAwKSB8IFwNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKChnKSA/IElP
TU1VX0dMT0JBTCA6IDApIHwgXA0KPisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoKHVvKSA/IElPTU1VX1VOVFJBTlNMQVRFRF9PTkxZIDogMCkpDQo+DQo+IHN0cnVjdCBJT01N
VVRMQkVudHJ5IHsNCj4tICAgIEFkZHJlc3NTcGFjZSAgICAqdGFyZ2V0X2FzOw0KPi0gICAgaHdh
ZGRyICAgICAgICAgICBpb3ZhOw0KPi0gICAgaHdhZGRyICAgICAgICAgICB0cmFuc2xhdGVkX2Fk
ZHI7DQo+LSAgICBod2FkZHIgICAgICAgICAgIGFkZHJfbWFzazsgIC8qIDB4ZmZmID0gNGsgdHJh
bnNsYXRpb24gKi8NCj4tICAgIElPTU1VQWNjZXNzRmxhZ3MgcGVybTsNCj4rICAgIEFkZHJlc3NT
cGFjZSAgICAgICAgICAgICp0YXJnZXRfYXM7DQo+KyAgICBod2FkZHIgICAgICAgICAgICAgICAg
ICBpb3ZhOw0KPisgICAgaHdhZGRyICAgICAgICAgICAgICAgICAgdHJhbnNsYXRlZF9hZGRyOw0K
PisgICAgaHdhZGRyICAgICAgICAgICAgICAgICAgYWRkcl9tYXNrOyAgLyogMHhmZmYgPSA0ayB0
cmFuc2xhdGlvbiAqLw0KPisgICAgSU9NTVVBY2Nlc3NGbGFncyAgICAgICAgcGVybTsNCj4gfTsN
Cg0KQW55IHJlYXNvbiBmb3IgdGhpcyBjaGFuZ2U/DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

