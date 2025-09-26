Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DE4CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1yD1-0006SX-Ff; Thu, 25 Sep 2025 22:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1yCx-0006Rs-F6
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:29:15 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1yCs-0006Q3-G8
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758853750; x=1790389750;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+sxMJ35psDDyinRgVK7C4F4fiAbeDx30O7xb5uc/gmI=;
 b=AbPmAG+ZLC4iOsoYsQTm8o4t30l3I3zjHVwhjtxeHH2DRQSGK3OzSpjm
 fd8MahlvWUbj9z6+w2yImqDfyiRUfCDdrftaGNvSu1MeIlF/dXtqcRQNz
 WAPS0q+AhN0+43jJfHp6MRfniAgwxbynCCzzztXyFmjeeh2RMCKxMFWLu
 3KN+WA01Vr8JVTC4rijCHfdlLUqVyYeRDlUjEl4UDcjxaniWnaxYawSNU
 ZbcYJSOsDE5erB8fVEsfJ7ciiotUKLnmo5tWyzZ7m/twX7qrwVBKm87om
 ojxwPXZ0SOKSh6gdoY6bQvZY2xoOvJ16DAm9gtJPTtBrjKDdwNgCe+XKT w==;
X-CSE-ConnectionGUID: U8TW0Cy9T7CZHjblzZhEdA==
X-CSE-MsgGUID: j4lyaH6RTq6vCLhJGkQ42w==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="78617494"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="78617494"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:29:01 -0700
X-CSE-ConnectionGUID: gVL2fs8CQlSQ6ihiBGivdg==
X-CSE-MsgGUID: m4NAdz1VQKa3kZqueyVqgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="177427065"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:29:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 19:28:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 19:28:59 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 19:28:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRCk6b/YY055pylV2KDtzZ1u7cQ+7kH7wkDf9vmKgcbhnZZDLPWbwuUnux1OgaNANH7WoMicm2O0WXe4RI65w8YV2NX2IXZzQ+KC1UmseYsjWc/albYbkBeF6d51uJe6Bc8x6lqDJMwiDBFdqsElRthm931aTZbrWlgYVIOvZKubpBTJqANB4tXdLqELtvlsiR/VSvCSGrd8Fdx6IQsk8/IITCkcrbuPz7LFnjgEXKVsCAA/63Z0Ber4b7k7l6LiuqPBfxKWgkFy+dU4QjycdwSZrVV82rN3i5cjF3p2Ycv1DhQlNTfr6UL1CbKrtgFEcy4j5rRe3JemN3o0Z6Ydow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sxMJ35psDDyinRgVK7C4F4fiAbeDx30O7xb5uc/gmI=;
 b=KSdCTrWKXbaS5Hpx3NJVYgKJZ5wW9fJEjWsMPd5ii4GJA5FGGWrHVuwleng+7sgkdqe7g14/1g8O48HG/QAqko1D9MP2MqTLFuVnSXs4fP8kqGDTvU8sBs56kc2Is4YZGbdsZ8DTn16g3jFYHxACo9Ym/trGCiTvoXqlC6bcVYih649xIE/WlqDdGnn+lYGb9lESiEbcEPa/pfmtgv+AHh+QvBMQnzyqAlwGiZZpy5lT3icezeLL9DjDsIePcd1DDOdXaRYX9CO8l0+iH8o7UbbniWw2CYuRxho/yrn3zz/q9+qd8EojY15t+sFcaK+MwUOBb7RTZ/od1tC0MAk77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 02:26:33 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Fri, 26 Sep 2025
 02:26:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: David Hildenbrand <david@redhat.com>, Steven Sistare
 <steven.sistare@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: RE: [PATCH] vfio/container: Remap only populated parts in a section
Thread-Topic: [PATCH] vfio/container: Remap only populated parts in a section
Thread-Index: AQHcDMr9Ap6MRYQc10GVaAw/xMLNqbR4FPYAgAWb3iCAAkuLAIAEca3QgAAU3ICAIG2M4A==
Date: Fri, 26 Sep 2025 02:26:33 +0000
Message-ID: <IA3PR11MB913667C899A63C898601FF5D921EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250814032414.301387-1-zhenzhong.duan@intel.com>
 <0286f864-9aaa-4a49-8975-cb1af3bb1270@oracle.com>
 <IA3PR11MB91363501F1A6ED40098AF8249207A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <0026017b-770e-467b-ab7d-98cac1c70463@oracle.com>
 <IA3PR11MB913635617BAC00289BC3DB1B9203A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac4a5808-e90e-434b-8cd5-4c25fc543501@redhat.com>
In-Reply-To: <ac4a5808-e90e-434b-8cd5-4c25fc543501@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB8199:EE_
x-ms-office365-filtering-correlation-id: 3b1d6726-721f-4e8d-2113-08ddfca41c45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YW9RU0dqaDZMZEVjSndUVUhvNFZUT3dtQVNYc3JaVXlUNEhtaitzVWRLS3Rr?=
 =?utf-8?B?QW9ZUVVCSTZORWdOdmd1aEZiMTBRNG5LUjgzanBQbHN4QWxjYjVaM04xcU5C?=
 =?utf-8?B?RGZrb1M4NE0yYURyTWh6NzlDQ3lobkd4S2k2MUtTQ2p0SE93QTVvY0VqNVBB?=
 =?utf-8?B?WUNYZ3phaU9FMElLZDFmZjk0SlFZd05SaExQNHJWZ3ArYkpGeWtWKzlPb0JC?=
 =?utf-8?B?Wk03cTJSUkt1cjV1VGZQNmx3djU1TjB4bGZrNlliZmg4V1pDUXVMTVE2anZL?=
 =?utf-8?B?YjliSU5Bd2gxWTBiRElxWmxOZ0puenNxMFRwVFJ5eVVhY2ZJMWNhU09mS1A3?=
 =?utf-8?B?aWJJbldlY0ZQUXIyZ3N6WXo3V1loZG50VXZqUzl0VG1aaVFtOERQcW8vZDVa?=
 =?utf-8?B?VTFRMVdSa0JvZ21DREhHc3RPRklEbldZQzYvV0JDVDBWaFJLM3NQYm5mckIz?=
 =?utf-8?B?SzFGa2xTSHNEUlFjaFQ3WHpPc1M5Smw3YmtEZWxNRnVGekorRTF2SlBYellR?=
 =?utf-8?B?OG5vR0psZFNjRkdlUkl2Y0JFVmpVclFaRzNpNUxRN3U5VmErQllMc1djRkNv?=
 =?utf-8?B?WlhGdnZCWjJRWUhCVyt6RlRVN3FYVmM3bktwaUl0U1hremdXZFdIeUlKZ0pQ?=
 =?utf-8?B?b3MvOGxvWVFzYUZzZWhMUUdNSHIrMmFzMVJBcDRoeHpvc3IweUFJaUM1UE9P?=
 =?utf-8?B?RG9jOWpDZUFxNWsrZzN2Z1cxYXVGVEdUcHVQL2pHVGlockZlTCtQVERmQURk?=
 =?utf-8?B?NHMxWUgyNFpQK01ObUViU2cvdExWZmh2blY0S1RPWkpsK29HdWFSWXA1WWNt?=
 =?utf-8?B?Nm9QV0cvUm5rWEIvM2ZqSE52OVFjYnJpSU5EYWNWOTgrZEMrdVNwV3hndnhE?=
 =?utf-8?B?UnFydVB4U1A1YUY0Qkt6UlkvRnNZc1FNUVFRdGhrbXdxWUFPeDhCUHV1ZHZN?=
 =?utf-8?B?Uk42T1N5d3ZtcEx3UDNqVFE5OXhxellYR0NzZ0V4bDB3cEkrOEZyU2ZjZ3Q2?=
 =?utf-8?B?WExWTUtEM3VFVWlEQlV0SG5XQmFiSDFnOEJ2aVRycTNCQytjOHRPblRIMDFv?=
 =?utf-8?B?V1FUVDFZUGdBRU5vZmFUNm1pSXlqODVISitiUmErcDFhUXp3UWE3WDBwUlYv?=
 =?utf-8?B?aHFNMUhWYnNLZ3R3NjU4ZEFpcjcvR3pBclNPSXFiQmM4UWRMS1Y1UTliTHhR?=
 =?utf-8?B?dmlVRkYvdUJxdncrMjQzNVVsKzkrQm12eEF0dnFtK0ltY3hicy9EUzg0d1lU?=
 =?utf-8?B?ZjNqaVk5RWRNVmgrRk83SFcyWGdZS2I2TVVEaFVsWXlWS0RITXJGaXIySlRM?=
 =?utf-8?B?TWVrekc0dWsxT0dBTHpIdEp3WiswYzU0TDNuOVZZT0g1VG1QZmxnVUJFTkk0?=
 =?utf-8?B?NnZSZmxqMEFqTkVLaThPbGZ4T0wzWHE5SXlTYzhHbThER2dudFVYSzBOclhR?=
 =?utf-8?B?NkFvZ0w4TEJ5dHJnNmtYem5pcnROUFpSRFBxT2xwSVhqSU80WlBSN0pjZzlT?=
 =?utf-8?B?MmxHMCs3REZvcEJ6WFVDK2d2blBDdTBQR3pYNG1yTmhKdkwvU2IrcFNZUnJv?=
 =?utf-8?B?dUJLR1N5Qno0MW5uek95WTZNK09CWk1QWlRjSmtOL3FSck5TNlBxV1dEZ2RQ?=
 =?utf-8?B?SVAyM0ZWSlBlL0Jjc3BMV1RhcWFtVWRCQ1U3RnI1T0Zra2QyTVc1Rys0WFJJ?=
 =?utf-8?B?c3Z6Z1Q5b29WRWxrd3V1TGRlUDV6bTI1elZyaGJVOG9TY0FMelFBUDZocytD?=
 =?utf-8?B?NDhJY2JydUJwSEJ6SjNHY0ZudExTZkVqcnB5VHBkNW5vUGc4MDUwV2VmOGFu?=
 =?utf-8?B?N2lsVnd0cVdaTkR2NUVOem43NVFHT3p1bXBVQWRhaUF5UDZUejVwUkErWTZ6?=
 =?utf-8?B?dndNdEp3aTUzWjJRbUkvSmg2NERWclFlNzdwRVc0L0FlUGw4SllTYlVDTzNO?=
 =?utf-8?B?dEJwSTkrNWlBd0NsK2oreVZUMVFZU2FTdG1TbUlFMEdVTGc0TVdieUxZNlpq?=
 =?utf-8?B?Rlo2TC9lMUlzTFY3ZkhwWFBXMDAraFhkK0N1NURTbWJRaExISGJGRmh0SGI4?=
 =?utf-8?Q?wXAdQP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1FjMkkrN1BDYy9KWGxEdzhlUVRNTWFnQXY5OU5CQ2ZsMjlSQStFcm5qcnps?=
 =?utf-8?B?Y3BkUnl3Nlp2dmtTRDUyN0xLYUhOK3BTd0lOSU95c0VsOWZNQnp3RjNoRjNv?=
 =?utf-8?B?UjhWNFFhaktGNU83VzNMUkZUSVBsZzdzTEdvQU5iMktJc1lGMVJYMVdna3Vk?=
 =?utf-8?B?VVFIeDBub0dZT3hjaEkrdDRCYkYvU0FkTFhaUEZtY3NZaUFNM2RIZzMzdDVM?=
 =?utf-8?B?azByaW8waGNhdW16Q2NyaFlBZm15REEzZGFiVE4vVkViN0xTb3lXWnVDcXQ4?=
 =?utf-8?B?cHA2VkkxcmJKOURYY3hxckNWTnozdkJ2YlpBd2pBRTU0SVo3TnU2SUJQSllw?=
 =?utf-8?B?NkxyeEF5bHZlekg5emQzcmJraUZOd3hCV3U5NUR2Nlc3RjRoVmtYdy9UK3Jz?=
 =?utf-8?B?enBOanMzNmFRRk4vWmk4WWx0bEtuYWorcFRLenJ1Qk9SWXBRWGx6ZUU4N0ZQ?=
 =?utf-8?B?Z2Zsa2dsSTM0WlVLRG0zcENodWE1UnBLMis4d0VVdzFKMFp3eFkvYVFrT1hD?=
 =?utf-8?B?ckFUV2ZuRElnMjZTVi9NV3dKMmhscER4N2pXSFVPMS96aUdwNDU4Q21vSjNi?=
 =?utf-8?B?TjNZb1hTRXd2aXI0dEFuVTJrdXFHMjlLL2NISVZJbjQ5d3ZFNVM3a29rSkxu?=
 =?utf-8?B?RU9lbWF5MS9UaW5NVm9ONDluUmYvaWJhazZpcXBKUmx5V1RlVXVDd2ovbTNI?=
 =?utf-8?B?MXMyNFZ2WG11Q0RLaGxQTG9SRUJaZXo5K2pXbitFZFFVWEEzS3Rma1N1N2tF?=
 =?utf-8?B?M1YvMGlpNDY0WlRhZ3ZIQ0tGTFZpTzBGdjMxODZ6cHNZVERNSVhMZjFVS0tj?=
 =?utf-8?B?QWNFdjdCUFhPS2tLWUFFeUhBUkpGQjVRWVg2d3QvME5mQnRoTEsrQ3FMTzJC?=
 =?utf-8?B?clkzWldwRlhKNTFhTU9TTEU3U0Y2T1N5WmUvVXFTNllhV2YzeVI5a3BhV2Jv?=
 =?utf-8?B?L081R3ZIckxFZFZVNDdUUzVHWnlwNzZVNWdONGlSaVFVcko5ZG9ONkY4L3VF?=
 =?utf-8?B?VHRuNCtVT0dwUUJZZXRQeTFnNlhWRk1CdHl6MmNWTnFMMHovbElQV3BiNlpW?=
 =?utf-8?B?MGtRV0tyYXp2dTBCNlROMDJ5SHdKU2cwMVZjZGVndjlqT252QTZoT2h5SWl5?=
 =?utf-8?B?N1A5K1B3aHVCTHFKbCtGNmZ5RXovM1AwelJidEo5bmlRK2MwQmZ4ejRFallH?=
 =?utf-8?B?Y2FFY0I4eTQ4U2VCQnBWZFZCc0I5aUNheDYwQXBrRDlqVjA4SUQydng5SU5r?=
 =?utf-8?B?TUdEVnl0bHpLdDhKRGNhY214RkpCNEVNbUk0ZkdGQ3EwVkxPcHREbGc3NFMy?=
 =?utf-8?B?Z1MvYVUyeGowUUo0SENEcE42K2MyaDJQTXhEdHM5eWJnQjJ1a21mZjJENjRO?=
 =?utf-8?B?Z09rQ0xobzRxRGQ0ZFE3enZVTnR4ajBiSEtwYmdXUmZzZC9DM3VnOWNIQVpv?=
 =?utf-8?B?cDl1amt6aVBxM2c0cGhjYWI0QTVuUTNaZkp4Nm9jUWJONjZ6UGQ2U0xSV2ly?=
 =?utf-8?B?SitNN1J0SXN5N1NUeGN0d1BCTkxWMzFBWHVEdFFMY2I0dCs3SVdORGliMld5?=
 =?utf-8?B?V0hYYzI5YVNMdTVSTVlpVy8zclBObjJ3SnlnY0l2NENkb0tFMmljUzFsQ2gx?=
 =?utf-8?B?ejRBbUJKVVVPajFCZUFUNTVEQ0RHWTRyN291T1ZRb0VvL0FETlRacEVFeE5y?=
 =?utf-8?B?djRFR2tMNnVKSlA1UzZWdlhOOG9hUlU5eTlwdklRSnV6bFQyV0FXUWU3VUZT?=
 =?utf-8?B?UTg2bEhHeml3MWVueTBZQWcyMCtFeG5SWWZmbWNYdHFLQU1DSExRS2VicENU?=
 =?utf-8?B?NmR0YUpHNUtxbi9WV2RKUnBoVXljUGpVR0lKZHVXOGx6VGpleE1nY0dldWZt?=
 =?utf-8?B?SVhGUEhYSzZWM3piTEtvRlNPU3FHRHJ1T3Juck4wRXdMSmJwRWR0NTVyTUt2?=
 =?utf-8?B?K1hXK1JXaUlhQ2p5ZUU2YU81Y1FIR2Vsa0ZVWmVIaHBSUjk1NFc5TytxaWp1?=
 =?utf-8?B?QUk3OEF6dFRsT3VJRXhyeEVONVNnY1dZbG1KeXVPMjlyakNmK05GanNkekZY?=
 =?utf-8?B?eFJlTDBxaU5TMGNqWTMzaVV0MmpoVWF5UzgvWFBJZi9LdjBlcFgxcXUrckZo?=
 =?utf-8?Q?+4vv5tjfXt+afmmrewnLcJGC2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1d6726-721f-4e8d-2113-08ddfca41c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 02:26:33.5251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsqtHNabpIIOm+OcH3PAfkfiZSAUFDuQjQSThFB9ozl9GEBY0COvF8Fh30kdUvLMiVF4l9yDfG1VRbVKoBKFrRx7/7SolCNuI4igCwEeM/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZmaW8vY29udGFpbmVy
OiBSZW1hcCBvbmx5IHBvcHVsYXRlZCBwYXJ0cyBpbiBhIHNlY3Rpb24NCj4NCj5PbiAwNS4wOS4y
NSAxMTowNCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gKyBEYXZpZCBIaWxkZW5icmFuZA0K
Pj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IFN0ZXZlbiBTaXN0
YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IHZmaW8vY29udGFpbmVyOiBSZW1hcCBvbmx5IHBvcHVsYXRlZCBwYXJ0cyBpbiBhDQo+c2VjdGlv
bg0KPj4+DQo+Pj4gT24gOC8zMS8yMDI1IDEwOjEzIFBNLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6
DQo+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4gRnJvbTogU3RldmVuIFNp
c3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BB
VENIXSB2ZmlvL2NvbnRhaW5lcjogUmVtYXAgb25seSBwb3B1bGF0ZWQgcGFydHMgaW4gYQ0KPj4+
IHNlY3Rpb24NCj4+Pj4+DQo+Pj4+PiBPbiA4LzEzLzIwMjUgMTE6MjQgUE0sIFpoZW56aG9uZyBE
dWFuIHdyb3RlOg0KPj4+Pj4+IElmIHRoZXJlIGFyZSBtdWx0aXBsZSBjb250YWluZXJzIGFuZCB1
bm1hcC1hbGwgZmFpbHMgZm9yIHNvbWUgY29udGFpbmVyLA0KPj4+IHdlDQo+Pj4+Pj4gbmVlZCB0
byByZW1hcCB2YWRkciBmb3IgdGhlIG90aGVyIGNvbnRhaW5lcnMgZm9yIHdoaWNoIHVubWFwLWFs
bA0KPj4+Pj4gc3VjY2VlZGVkLg0KPj4+Pj4+IFdoZW4gcmFtIGRpc2NhcmQgaXMgZW5hYmxlZCwg
d2Ugc2hvdWxkIG9ubHkgcmVtYXAgcG9wdWxhdGVkIHBhcnRzIGluDQo+YQ0KPj4+Pj4+IHNlY3Rp
b24gaW5zdGVhZCBvZiB0aGUgd2hvbGUgc2VjdGlvbi4NCj4+Pj4+Pg0KPj4+Pj4+IEV4cG9ydCB2
ZmlvX3JhbV9kaXNjYXJkX25vdGlmeV9wb3B1bGF0ZSgpIGFuZCB1c2UgaXQgdG8gZG8gcG9wdWxh
dGlvbi4NCj4+Pj4+Pg0KPj4+Pj4+IEZpeGVzOiBlYmExZjY1N2NiYjEgKCJ2ZmlvL2NvbnRhaW5l
cjogcmVjb3ZlciBmcm9tIHVubWFwLWFsbC12YWRkcg0KPj4+Pj4gZmFpbHVyZSIpDQo+Pj4+Pj4g
U2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4N
Cj4+Pj4+PiAtLS0NCj4+Pj4+PiBidHc6IEkgZGlkbid0IGZpbmQgZWFzeSB0byB0ZXN0IHRoaXMg
Y29ybmVyIGNhc2UsIG9ubHkgY29kZSBpbnNwZWN0aW5nDQo+Pj4+Pg0KPj4+Pj4gVGhhbmtzIFpo
ZW56aG9uZywgdGhpcyBsb29rcyBjb3JyZWN0Lg0KPj4+Pj4NCj4+Pj4+IEhvd2V2ZXIsIEkgbmV2
ZXIgbGlrZWQgcGF0Y2gNCj4+Pj4+ICAgICBlYmExZjY1N2NiYjEgKCJ2ZmlvL2NvbnRhaW5lcjog
cmVjb3ZlciBmcm9tIHVubWFwLWFsbC12YWRkcg0KPj4+IGZhaWx1cmUiKQ0KPj4+Pj4NCj4+Pj4+
IEkgdGhpbmsgaXQgYWRkcyB0b28gbXVjaCBjb21wbGV4aXR5IGZvciBhIHJhcmUgY2FzZS4gIElu
IGZhY3QsIGlmIHdlDQo+Pj4+PiBleGFtaW5lIGFsbCB0aGUgcG9zc2libGUgZXJyb3IgcmV0dXJu
IGNvZGVzLCBJIGJlbGlldmUgdGhleSBhbGwgd291bGQNCj4+Pj4+IGJlIGNhdXNlZCBieSBvdGhl
ciBxZW11IGFwcGxpY2F0aW9uIGJ1Z3MsIG9yIGtlcm5lbCBidWdzOg0KPj4+Pj4NCj4+Pj4+IHZm
aW9fZG1hX2RvX3VubWFwKCkNCj4+Pj4+ICAgICByZXR1cm5zIC1FQlVTWSBpZiBhbiBtZGV2IGV4
aXN0cy4gIHFlbXUgYmxvY2tzIGxpdmUgdXBkYXRlDQo+YmxvY2tlcg0KPj4+Pj4gICAgICAgd2hl
biBtZGV2IGlzIHByZXNlbnQuICBJZiB0aGlzIG9jY3VycywgdGhlIGJsb2NrZXIgaGFzIGEgYnVn
Lg0KPj4+Pj4gICAgIHJldHVybnMgLUVJTlZBTCBpZiB0aGUgdmFkZHIgd2FzIGFscmVhZHkgaW52
YWxpZGF0ZWQuICBxZW11DQo+YWxyZWFkeQ0KPj4+Pj4gICAgICAgaW52YWxpZGF0ZWQgaXQsIG9y
IG5ldmVyIHJlbWFwcGVkIHRoZSB2YWRkciBhZnRlciBhIHByZXZpb3VzIGxpdmUNCj4+Pj4+ICAg
ICAgIHVwZGF0ZS4gIEJvdGggYXJlIHFlbXUgYnVncy4NCj4+Pj4+DQo+Pj4+PiBpb3B0X3VubWFw
X2FsbA0KPj4+Pj4gICAgIGlvcHRfdW5tYXBfaW92YV9yYW5nZQ0KPj4+Pj4gICAgICAgLUVCVVNZ
IC0gcWVtdSBpcyBjb25jdXJyZW50bHkgcGVyZm9ybWluZyBvdGhlciBkbWEgbWFwIG9yDQo+dW5t
YXANCj4+Pj4+ICAgICAgICAgICAgICAgIG9wZXJhdGlvbnMuICBhIGJ1Zy4NCj4+Pj4+DQo+Pj4+
PiAgICAgICAtRURFQURMT0NLIC0gU29tZXRoaW5nIGlzIG5vdCByZXNwb25kaW5nIHRvIHVubWFw
IHJlcXVlc3RzLg0KPj4+Pj4NCj4+Pj4+IFRoZXJlZm9yZSwgSSB0aGluayB3ZSBzaG91bGQganVz
dCByZXZlcnQgZWJhMWY2NTdjYmIxLCBhbmQgYXNzZXJ0IHRoYXQNCj4+Pj4+IHRoZSBxZW11IHZm
aW9fZG1hX3VubWFwX3ZhZGRyX2FsbCgpIGNhbGwgc3VjY2VlZHMuDQo+Pj4+Pg0KPj4+Pj4gVGhv
dWdodHM/DQo+Pj4+DQo+Pj4+IEkgYWdyZWUgaXQncyBhIHJhcmUgY2FzZSBhbmQgeW91ciBzdWdn
ZXN0aW9uIHdpbGwgbWFrZSBjb2RlIHNpbXBsZSwgYnV0IEkNCj5mZWVsDQo+Pj4gaXQncyBhZ2dy
ZXNzaXZlIHRvIGtpbGwgUUVNVSBpbnN0YW5jZSBpZiBsaXZlIHVwZGF0ZSBmYWlscywgdHJ5IHRv
IHJlc3RvcmUgYW5kDQo+Pj4ga2VlcCBjdXJyZW50IGluc3RhbmNlIHJ1bm5pbmcgaXMgaW1wb3J0
YW50IGluIGNsb3VkIGVudiBhbmQgbG9va3MgbW9yZQ0KPj4+IG1vZGVyYXRlLg0KPj4+DQo+Pj4g
T0suDQo+Pj4NCj4+PiBSZXZpZXdlZC1ieTogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVA
b3JhY2xlLmNvbT4NCj4+Pg0KPj4+IChidXQgeW91IHNob3VsZCBhbHNvIHNlZWsgYW4gUkIgZnJv
bSBzb21lb25lIHdobyBpcyBtb3JlIGZhbWlsaWFyIHdpdGgNCj5yYW0NCj4+PiBkaXNjYXJkIGFu
ZA0KPj4+IGl0cyBjYWxsYmFja3MpLg0KPj4NCj4+IEhpIERhdmlkLCBsb29rIGZvcndhcmQgdG8g
eW91ciBjb21tZW50cywgc3VnZ2VzdGlvbnMuIFRoYW5rcw0KPg0KPkhpIQ0KPg0KPkkgbWVhbiwg
dGhlDQo+DQo+CXJldHVybiB2cmRsLT5saXN0ZW5lci5ub3RpZnlfcG9wdWxhdGUoJnZyZGwtPmxp
c3RlbmVyLCBzZWN0aW9uKSA9PSAwOw0KPg0KPmlzIGNvbXBsZXRlbHkgd3JvbmcuDQo+DQo+cmFt
X2Rpc2NhcmRfbWFuYWdlcl9yZXBsYXlfcG9wdWxhdGVkKCkgc2hvdWxkIGJlIHRoZSByaWdodCB0
aGluZyB0byBkby4NCj4NCj5XYXMgdGhpcyBwYXRjaCB0ZXN0ZWQgc29tZWhvdyAoZS5nLiwgd2l0
aCB2aXJ0aW8tbWVtKSwgc28gd2UncmUgc3VyZSBpdCdzDQo+bm93IGJlaGF2aW5nIGFzIGV4cGVj
dGVkPw0KDQpJIG1hZGUgYSB0cmljayB0byB0cmlnZ2VyIHRoZSBlcnJvciBwYXRoIGFuZCBjb25m
aXJtZWQgaXQgd29ya3MgYXMgZXhwZWN0ZWQuDQpFLmcuLCBmb3JjZSBlYWNoIGRldmljZSBhdHRh
Y2hpbmcgdG8gc2VwYXJhdGUgY29udGFpbmVyLCBmaXJzdCBkZXZpY2UgdW5tYXBfYWxsDQpwYXNz
IGFuZCBzZWNvbmQgZmFpbC4NCg0KVGhlcmUgYXJlIG90aGVyIGZpeGVzIG5lZWRlZCBieSBDUFIt
dHJhbnNmZXIsIGJ1dCB0aGV5IGFyZSB1bnJlbGF0ZWQgdG8gdGhpcw0Kc2NlbmFyaW8sIHNlZSBo
dHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvY29tbWl0cy9yZG1fdjEvIGZvciB0aGUN
CnRyaWNrIGFuZCBhbGwgcGF0Y2hlcy4NCg0KPg0KPg0KPkkgd291bGQgYWRkIGFuIGVtcHR5IGxp
bmUgaW4gdmZpb19jcHJfcmRtX3JlbWFwKCkuDQo+DQo+DQo+QXBhcnQgZnJvbSB0aGF0LCBMR1RN
DQo+DQo+UmV2aWV3ZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0K
DQpJIG1hZGUgYSBtaW5vciBhZGp1c3RtZW50IHRvIGNhbGwgcmRsLT5ub3RpZnlfcG9wdWxhdGUo
KSBpbnN0ZWFkIG9mIHZmaW9fcmFtX2Rpc2NhcmRfbm90aWZ5X3BvcHVsYXRlKCkgdG8gYXZvaWQg
ZXhwb3J0aW5nIGl0LCB0aGlzIGxvb2tzIGNsZWFuZXIuDQoNClRoaXMgaXMgc2FtZSBlZmZlY3Qg
c28gZGFyZSB0byBrZWVwIHlvdXIgUi1iLCBsZXQgbWUga25vdyBpZiBub3QuDQoNClRoYW5rcw0K
Wmhlbnpob25nDQo=

