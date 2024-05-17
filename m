Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE56C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 10:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7v14-0000n2-6P; Fri, 17 May 2024 06:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s7v11-0000mm-Gw
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:40:43 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s7v0y-0007oy-CU
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715942440; x=1747478440;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UZzPtW++G/Ei2JilN3lBT64Gk8vauVMsuRHYsflF4O8=;
 b=hDMuqZ4wtOVp9udQwFl7k76gKWmkgznTB6gErmvpDF+zrtrEVId1HDUR
 HSR6uKjzf90dHrvUaBGA4khxmajlichhd9Zwr/Ja6bXVw/L8CKebu18og
 2U4dDrFlRdNV/GDAGWi6iJzChX2cwnMey5k1ptp+5wKwYVDkOQO2nTIeP
 JeaRwm7JJLCPKUnvlhBLg7LVJ+A6tg5HZWQVTugJr83rX+iF5duELGITP
 GjfTFbCdudZrpQOXDHfz4630meNXMWNcZEskNlTcnMLKF/lhpoHt0bBUu
 G6f20JzO9z21Ll50eKmTH2qrobogr1b82EF3EM3GfvDQIOOx6fKxXE0kZ Q==;
X-CSE-ConnectionGUID: jFvZzy5+QK+7xJu5yI9dVA==
X-CSE-MsgGUID: YUIITt9aRfuablfZ+KlBdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11953711"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; d="scan'208";a="11953711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2024 03:40:36 -0700
X-CSE-ConnectionGUID: tufb5EGxTyK/Bw2xrK8DVQ==
X-CSE-MsgGUID: kBth60CTQoKfIvbf5UAZ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; d="scan'208";a="36264492"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 May 2024 03:40:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 03:40:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 03:40:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 03:40:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvIou7lYm2WLMjR+0ukoiy0VFf1eREWdFHC8H/6qViD6b8+BEtXnKH2hBbZlyKSM/H2Fm/OOoDdJSgc7H8F6PdiYcfUPzkoS/X/SLlgYGGXeKTVhbv/cM1aloxnieVuOr6q8ERSLEwo6M7b3JzaKigxtetECY84gWcJnmQNzgF0lEWg9FFUwnnLTI8QAa+l7SJmVUMeHdA1nK4twEarAmbODrpMXDqekXgYmbfeZANkLS7WNYxkCatCe3S2I3pE4Zx+ZkJHwJ/C43KtS6BJoXqM6TsDwyc1hHRDjZQmzFxvQ9SLY0oNlwUt7W3XgKid7zKO9d1PHh55LlGk19jKEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZzPtW++G/Ei2JilN3lBT64Gk8vauVMsuRHYsflF4O8=;
 b=Y5JGaHfVspNntPHp5VmmEUic3TDiUD1vUGkIQ+ms67XRmVMpX5ZfDF1KP8DtfXrCTX6WTILA6ElHODo3+HxRl1UpG6hkVrauTl8PxbcAxE4qr64IQWUhfDhsljY5Y4LVa1dzXEWy2dEbDcSvjly/gRIXdHVTxdsXiZaejW2FD6rflU1BfiNYKPSmlJP+emjOY3O/OIHgLixbMCMCWwvqt++pnQWq7BEq2N8pQeWSs6q9+kjSbK6PCYGqdfJUFIfzh97tbYJlGQRBoCAcwFUkuUHzEqR3gGmz6S3IcamA04ewXH/WKuBx/7C6sqwVe1fqqZ9IkEXlTM4eSFgtKtKxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB8044.namprd11.prod.outlook.com (2603:10b6:806:2ef::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 10:40:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e%4]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 10:40:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH ats_vtd v2 20/25] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v2 20/25] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Index: AQHappePxRKi9iA3U0GcjHFp00phFrGbPuhQ
Date: Fri, 17 May 2024 10:40:33 +0000
Message-ID: <SJ0PR11MB674421DBE60D5C9CF3584C6C92EE2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
 <20240515071057.33990-21-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-21-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB8044:EE_
x-ms-office365-filtering-correlation-id: 3fa9ecae-f287-4808-62db-08dc765dc7ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bWRtMlAyQ215ZFhjd1c5VGVMZTQ3K2NzbVFYS1NDN25idWFBWEtNZWZnU2E1?=
 =?utf-8?B?aFZjTEF2c2FWUko4ZVhLMXJsemhiR093bDh6cGltQm5ZaWtoeXgyWkwxMTVY?=
 =?utf-8?B?SVpQb014Sk12dGZVVm5XSXJRdWoxN1BNQkxkeG1uYXpIeTZTcHhaTEcxVEgr?=
 =?utf-8?B?dm1YaFd5SnJXUlkyRmhybU9SNHJFZnAyNkpaV1o1clg4dEJPckhtbDhWRk11?=
 =?utf-8?B?aGZ2YSt0bHhjK3FhN2EvOW42Y2VJQkJVTFJpRGJJeVZUSE0yV1c4cmUwVDZH?=
 =?utf-8?B?R0p5UjZ2SDlianZoSGwzemY4cUNHYlNnU293U0hiam13RmVsSDl5eDBjbndv?=
 =?utf-8?B?S1R0QXhjODZZOG5LU21qdHdqVTdGVjhhc3hpU0hWWnp4WGhGRkExcEVvRFAr?=
 =?utf-8?B?QVhYWTR5djFvc0hYT3VSNS9KWGd1cm94bStuU29Zc3VvdTU1U0lkRVZlbnVu?=
 =?utf-8?B?YWpXaWIrenR4UTJkT3B1QjFHTWNTb3duUWVnOHhpMll3Z1laa3ZERzhSbzZ2?=
 =?utf-8?B?NGY4VFAxMDF6Yjl1Z1hSWGZTb2JRTTNxK21UMDVmRlN1Vm5MTEtVMmZCRVg1?=
 =?utf-8?B?Z3hhdHBybHljbko3cnlnS29yV2JncnAzM1hpU0FYOUxTTjdyVUNWOVNhL3dR?=
 =?utf-8?B?QXpIMzRwanZPMFdXbjRnQ2hHU3drWi85T3BsaEVuSml4c1dnK1dLaTZQKzN1?=
 =?utf-8?B?WjlXUUJEK01JUmFCRElFcndaclhRUHpJaHUwV1JJa0g3czlYdXkzbEZxeGxM?=
 =?utf-8?B?Z281TW8yQmtDNGo3YTY3NGV4UlQySHBxRkV6ZnY2VVRod3JydXNoWDRGdDBG?=
 =?utf-8?B?c3lFYThOY3BPbFJmRXZiV1U3Z3ZWSDNEbVhiVmprTldMbHFXTnhYbFFucUpJ?=
 =?utf-8?B?Ujg1NWFhdFVPVlZJNDZzemQ0MHhLV3AyWUV6RGxMREF3U3hoR3BqYi9Mc1NN?=
 =?utf-8?B?Znd0K0JpNHhlNXp2Ymg2ajhVRWN5MEI1TlRUb3ZRVlZRbHNyUXBDbFR3Mjd2?=
 =?utf-8?B?b2NYTmFFWTlwcHJMM20ySDBiZ1FNNEQ2M0E3SklqdFBjUXVXL0djckdOcElS?=
 =?utf-8?B?V0hCV2sxU0ZnNVpXK0pxZG9vZGhzUWx5WWVVK0dCN1pJV00yaldmYmtkcXF6?=
 =?utf-8?B?ZmYzZWpJTFo4TG40eVJXYnFKbk1yTE5oUXNRN01jbGl2Ti81VWEwU3NmWlBa?=
 =?utf-8?B?dEpZNHVQR2srdStxUG12RGNPSzJiV2JhbUJWcEUzaENmWGptc1hHN2I1cjF4?=
 =?utf-8?B?UU5waTIrUnhUS3ArVVliamx1R09LaW5oWUx4K1BiK0svaTFQQTdsYS9mNHQv?=
 =?utf-8?B?aDRnTEJUVEJ5RGptRXlPZ2xRQk4xNjIrSWVOalU4aWhLMFh2SzFsUm95SFZW?=
 =?utf-8?B?c3JzYzVTdXdnMk5QU01PTFhPRXVyb2YvSVRZQmdRQi95Nng3Vmh0WnRlLzBL?=
 =?utf-8?B?bXVxbXlmRkZObUFuRnM3STNtM1J2bmFxVTRJcklZbEhUTHR1NVd5TzFJQys5?=
 =?utf-8?B?UTFkdXVsWml5ZVZUWFQvSjdGaGhLMS9TZ0VmUFZ6VVd0SWY5S09XRFFxbEh5?=
 =?utf-8?B?RlBLYlZqaUM3ZnNVb2xRYmVIZG0vWXcyL0lvODhGeCtHc3poT1NoNUlkSXg5?=
 =?utf-8?B?ck1Bd1p1SWxtVTZiZi9wem5kZExVU2UrZEtFUENOM3VVZXEyUUhBYkY1aUJp?=
 =?utf-8?B?THRVTDBoc1VCMFZ4eCtab2VmcWQvZmYrOWU3OTdkWDdOa1NNLzhiTmhWUG9y?=
 =?utf-8?B?VStCTDQvQ0hEY0hoLzdDdi80TnlJdkFneGJnSGpuN1gvNy8wdjNsd1hYUTBQ?=
 =?utf-8?B?akxHQzJXYzF1R3ZHWkRHZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck9QQWVkdFJIampkUFhTZWVGdDYzL0tVZXJOVnRWNDEvdUlSR29PUlU2RGhV?=
 =?utf-8?B?NmVUcVdQL0FZR1VtU1prc1lUTFlsNHBRS3pVRXNkVHFCRENsU0dueE9IQzl3?=
 =?utf-8?B?VTI1dU82R05zNUd6NzZVcDVhQ2V1ck1nOFE4bDg2TjdZR0ZBa0I3aDZMcFkv?=
 =?utf-8?B?eDhRWWYvSkJOdzZOTHpXZUJQdXYrZkxOdGdUdFpUS2NHTmVOV0R4REpGcFc3?=
 =?utf-8?B?S2FZY3U1OFFEdE9DaUNxY29oa3hqUXBRcnVNUWdwYXUwTDBzOFp2amIrVzl0?=
 =?utf-8?B?RXRKa0NXRHVLaW9QTWhCM2JDSWhCUVBQTS9EQmcwT2pvUUZXbzZMZEt1UmQx?=
 =?utf-8?B?SFRBR2szZ241OXRRQVhBTHE2aGphWHJFanlXcDZ6allnakhLT0YremdFMzFK?=
 =?utf-8?B?M21za2pwRWp1dS9Vd3VWNmE2RllFYkhGencrK0ExeDBaNmM4c080T1pGTVJy?=
 =?utf-8?B?dzZlM2lyaGN5U3JmZnR0azZtbTlEUEtTVTBqR0E2M0tUZHFEb1duY0NSc0w3?=
 =?utf-8?B?OHNNWlBWUlNzVWdkaWM1SDhZNVJLL01hamlPZmQ0YXpVT2N3NHZvejd6RnFX?=
 =?utf-8?B?WUZ5ZVlhWnVURG5CdU5jdyt1bDZwRm41K25weFEwS1Fna3NjZ09LbnR5Wlc2?=
 =?utf-8?B?QzVBUEcwdGQxNE81MDVHNE1OdWZnb09vZDIxeWFUbUE2bEJ0WGhjV1hPc0U1?=
 =?utf-8?B?dER3eWdtN3A1b0ZUQ1JjK2trVVVpTStJeVlodURtcVMvZUorMldhV1puS3lw?=
 =?utf-8?B?a1EybTY2eCtSWlBwRXNPUXIvZWRwa2ZJTWhIYTFER2phT2xmQk1ucndPaG02?=
 =?utf-8?B?eVhQYVk5bWs4enl6dUtHMHB6K2phTEV6WlBEMTFZY05xM3J5MWVnVWlSdkhG?=
 =?utf-8?B?SHdUQklzMEtJRVM0b291aHdwYTA2NGpTV3BkL2VnQ2dBcm13aDFrcGRQT1E4?=
 =?utf-8?B?Q2xHRzFscGg3alpzTkNONVd2TDVqS1FFUE9vTkljSURDZ0xhVTc1eGFMZS8r?=
 =?utf-8?B?WXBHUHRJd3lUT2p3UjNpeXJYekFmcWpFakFCbVQwMW41ZVZWTVE3WnpQWjYx?=
 =?utf-8?B?OXgrZlhHdURiQTVKclNMQTc1RUc2c1AySFBKeW4vL09rKzVPOWMxMG0yUGZY?=
 =?utf-8?B?WmcrU1hrQTB2dWRmcHo2K3NHVStlSUU0MmVrWSs3SWt5NlRTNU93eXplKzRz?=
 =?utf-8?B?SEQ2VTMvZkNRQ1cwYUkzR2tWSktUWlp3RDJmbGtSemtzcXpDOElPdi9xVGhy?=
 =?utf-8?B?V0NQS3UxWXNPTm9KTkJxbGdMYnpGMnk5OVhnNXhJYndST2U2TWlsTWNFYkNo?=
 =?utf-8?B?RXJhVndwd0piTXVVT3hmdG1nTTRPRjl3NXQ1ZkpxQnNOdXpiWmZ2ektuQ1p3?=
 =?utf-8?B?MTN5Q01BcVA2MVE5Qmttcmh4T3RyZmxmRG8xc0xNMnRMUVkvaDE4VzB2SlZN?=
 =?utf-8?B?TFpXNjgyb2F2eW45czJnNTk2cXVWQjFFS24yU1dRaU5pWUU3TmpKSUtIN3hl?=
 =?utf-8?B?bXh4UU04S1ZWZE9hYkQ3UUgxOE1RcW9rcnptdjhZdi9zU0VLdnBqKzdiTVVl?=
 =?utf-8?B?L2wyWFZ1dW13cjJYdytYVHo3ZHpPcGF2UGhVbWtxZFZlM0g5b3h0TnZzUmRO?=
 =?utf-8?B?d0F2ZERtU08rSTV6SkJINXlNWVlnR25ERWdVN0FaMDkwMzRxcm11bXZma1pQ?=
 =?utf-8?B?N1VxT1Z2VFd4UDBCNXMrcjFpZk9OeG0zMmNFaFBidnZ0Q3V2M2YrT2VEL2Jv?=
 =?utf-8?B?bnJabytRb245OVVPcTljM0dNeHhUbW5EM1ZsdU5qd2RURVRSYVBySmdzZE5G?=
 =?utf-8?B?d3NmakVtYWhmcmJiOVVMdThjNWZqK3dvVFA2WEZOczcrWko3SGFOeGlvMXEr?=
 =?utf-8?B?L3lPckhDLzhxV093Qkp3NE4wVTBPb1h3Qi9PclRtVC94R2ZNVTRMcHQ2MkJk?=
 =?utf-8?B?ek00ZW00QW52eFJGaWlvbFBuZkVRSFNsT2tDQ3ZpaUFqODJ5d294QVhRN0pi?=
 =?utf-8?B?M3NEZW92REp4WFp3bW44L1dxcjRXNEFwOFBURERJcHBld0Y4RDF0aWllblY1?=
 =?utf-8?B?NStNZkk3M3hjZ1RETS9ySWpDWDFCNlo3ZGloYTZGWWwrOHNEVG8vckF0ME02?=
 =?utf-8?Q?EXLFN2e0IDQj2LCr/rdSlEEqS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa9ecae-f287-4808-62db-08dc765dc7ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 10:40:33.5638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WaDeZPHVUG0PZwx53OnvRzDlAEa0BpovDLW4gsEoxzB8c5LcGUqnl6jVGiw6icigvAQHBJMlD5Tupu1HOX/C8yOlD5tnYxIqINmk6zZ6Bs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8044
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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
IGF0c192dGQgdjIgMjAvMjVdIGludGVsX2lvbW11OiBmaWxsIHRoZSBQQVNJRCBmaWVsZCB3aGVu
DQo+Y3JlYXRpbmcgYW4gaW5zdGFuY2Ugb2YgSU9NTVVUTEJFbnRyeQ0KPg0KPlNpZ25lZC1vZmYt
Ynk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4u
Y29tPg0KPi0tLQ0KPiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA3ICsrKysrKysNCj4gMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVs
X2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj5pbmRleCA1M2YxN2Q2NmMwLi5jNGVi
ZDQ1NjllIDEwMDY0NA0KPi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPisrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPkBAIC0yMjk5LDYgKzIyOTksNyBAQCBvdXQ6DQo+ICAgICBlbnRy
eS0+dHJhbnNsYXRlZF9hZGRyID0gdnRkX2dldF9zbHB0ZV9hZGRyKHB0ZSwgcy0+YXdfYml0cykg
Jg0KPnBhZ2VfbWFzazsNCj4gICAgIGVudHJ5LT5hZGRyX21hc2sgPSB+cGFnZV9tYXNrOw0KPiAg
ICAgZW50cnktPnBlcm0gPSBhY2Nlc3NfZmxhZ3M7DQo+KyAgICBlbnRyeS0+cGFzaWQgPSBwYXNp
ZDsNCg0KRm9yIFBDSV9OT19QQVNJRCwgZG8gd2Ugd2FudCB0byBhc3NpZ24gUENJX05PX1BBU0lE
IG9yIHJpZDJwYXNpZD8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPiAgICAgcmV0dXJuIHRydWU7
DQo+DQo+IGVycm9yOg0KPkBAIC0yMzA3LDYgKzIzMDgsNyBAQCBlcnJvcjoNCj4gICAgIGVudHJ5
LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPiAgICAgZW50cnktPmFkZHJfbWFzayA9IDA7DQo+ICAg
ICBlbnRyeS0+cGVybSA9IElPTU1VX05PTkU7DQo+KyAgICBlbnRyeS0+cGFzaWQgPSBQQ0lfTk9f
UEFTSUQ7DQo+ICAgICByZXR1cm4gZmFsc2U7DQo+IH0NCj4NCj5AQCAtMzQ5Nyw2ICszNDk5LDcg
QEAgc3RhdGljIHZvaWQNCj52dGRfcGlvdGxiX3Bhc2lkX2ludmFsaWRhdGVfbm90aWZ5KEludGVs
SU9NTVVTdGF0ZSAqcywNCj4gICAgICAgICAgICAgICAgIGV2ZW50LmVudHJ5LnRhcmdldF9hcyA9
ICZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4gICAgICAgICAgICAgICAgIGV2ZW50LmVudHJ5Lmlv
dmEgPSBub3RpZmllci0+c3RhcnQ7DQo+ICAgICAgICAgICAgICAgICBldmVudC5lbnRyeS5wZXJt
ID0gSU9NTVVfTk9ORTsNCj4rICAgICAgICAgICAgICAgIGV2ZW50LmVudHJ5LnBhc2lkID0gcGFz
aWQ7DQo+ICAgICAgICAgICAgICAgICBldmVudC5lbnRyeS5hZGRyX21hc2sgPSBub3RpZmllci0+
ZW5kIC0gbm90aWZpZXItPnN0YXJ0Ow0KPiAgICAgICAgICAgICAgICAgZXZlbnQuZW50cnkudHJh
bnNsYXRlZF9hZGRyID0gMDsNCj4NCj5AQCAtMzY3OCw2ICszNjgxLDcgQEAgc3RhdGljIHZvaWQN
Cj52dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90
IGRvbWFpbl9pZCwNCj4gICAgICAgICAgICAgZXZlbnQuZW50cnkudGFyZ2V0X2FzID0gJmFkZHJl
c3Nfc3BhY2VfbWVtb3J5Ow0KPiAgICAgICAgICAgICBldmVudC5lbnRyeS5pb3ZhID0gYWRkcjsN
Cj4gICAgICAgICAgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQo+KyAgICAgICAg
ICAgIGV2ZW50LmVudHJ5LnBhc2lkID0gcGFzaWQ7DQo+ICAgICAgICAgICAgIGV2ZW50LmVudHJ5
LmFkZHJfbWFzayA9IHNpemUgLSAxOw0KPiAgICAgICAgICAgICBldmVudC5lbnRyeS50cmFuc2xh
dGVkX2FkZHIgPSAwOw0KPg0KPkBAIC00MzM1LDYgKzQzMzksNyBAQCBzdGF0aWMgdm9pZA0KPmRv
X2ludmFsaWRhdGVfZGV2aWNlX3RsYihWVERBZGRyZXNzU3BhY2UgKnZ0ZF9kZXZfYXMsDQo+ICAg
ICBldmVudC5lbnRyeS5pb3ZhID0gYWRkcjsNCj4gICAgIGV2ZW50LmVudHJ5LnBlcm0gPSBJT01N
VV9OT05FOw0KPiAgICAgZXZlbnQuZW50cnkudHJhbnNsYXRlZF9hZGRyID0gMDsNCj4rICAgIGV2
ZW50LmVudHJ5LnBhc2lkID0gdnRkX2Rldl9hcy0+cGFzaWQ7DQo+ICAgICBtZW1vcnlfcmVnaW9u
X25vdGlmeV9pb21tdSgmdnRkX2Rldl9hcy0+aW9tbXUsIDAsIGV2ZW50KTsNCj4gfQ0KPg0KPkBA
IC00OTExLDYgKzQ5MTYsNyBAQCBzdGF0aWMgSU9NTVVUTEJFbnRyeQ0KPnZ0ZF9pb21tdV90cmFu
c2xhdGUoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LCBod2FkZHIgYWRkciwNCj4gICAgIElPTU1V
VExCRW50cnkgaW90bGIgPSB7DQo+ICAgICAgICAgLyogV2UnbGwgZmlsbCBpbiB0aGUgcmVzdCBs
YXRlci4gKi8NCj4gICAgICAgICAudGFyZ2V0X2FzID0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LA0K
PisgICAgICAgIC5wYXNpZCA9IHZ0ZF9hcy0+cGFzaWQsDQo+ICAgICB9Ow0KPiAgICAgYm9vbCBz
dWNjZXNzOw0KPg0KPkBAIC00OTIzLDYgKzQ5MjksNyBAQCBzdGF0aWMgSU9NTVVUTEJFbnRyeQ0K
PnZ0ZF9pb21tdV90cmFuc2xhdGUoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LCBod2FkZHIgYWRk
ciwNCj4gICAgICAgICBpb3RsYi50cmFuc2xhdGVkX2FkZHIgPSBhZGRyICYgVlREX1BBR0VfTUFT
S180SzsNCj4gICAgICAgICBpb3RsYi5hZGRyX21hc2sgPSB+VlREX1BBR0VfTUFTS180SzsNCj4g
ICAgICAgICBpb3RsYi5wZXJtID0gSU9NTVVfUlc7DQo+KyAgICAgICAgaW90bGIucGFzaWQgPSBQ
Q0lfTk9fUEFTSUQ7DQo+ICAgICAgICAgc3VjY2VzcyA9IHRydWU7DQo+ICAgICB9DQo+DQo+LS0N
Cj4yLjQ0LjANCg==

