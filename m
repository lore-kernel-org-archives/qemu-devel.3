Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A16CDB47C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 02:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZuv-00033h-M2; Wed, 24 Jun 2026 22:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wcZur-00032a-IQ; Wed, 24 Jun 2026 22:34:09 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wcZuo-00086Q-E2; Wed, 24 Jun 2026 22:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782354846; x=1813890846;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NPpkrOGNRPC0Cq41IbR6maELrOqvPKGMkqMX87FEV8w=;
 b=Q9Xs99bA9vRzrQW2EQoi+e/3Ve8acXjftxsaGqLurFXTlJJLrUkvxpHG
 bsZMpn9MXnYc2bwaYaVSlNDW1hx5UJfEXcIEkIkDJZ5M1hZ/aSxjYaEPP
 6iFYr90GYVs01Y9sc+7hK9bQLc7pAGSBAegxnWatyfBzHc1b8naSCdrCl
 JcJbiNoQF9leIS6jWoGIYu3J0Hxe9R1BI/t3gRKzal8Mc47Ra5tgxZOEY
 xar/7ewE8hmtCcG/gISIYGcKrNk/I3wYTq4zIK1pSzMPcuDw61yRk5guh
 qIDViHy4fVc/5u2RC022XwARJdNgkbSv4JJS6UfxxIvJA6pSCpbA2+4vb w==;
X-CSE-ConnectionGUID: ysSR2OJESQ2xxP85jLizYA==
X-CSE-MsgGUID: YrzdTm1XSuSF4XfgcmcYTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83002539"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; d="scan'208";a="83002539"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 19:34:01 -0700
X-CSE-ConnectionGUID: FrX3vuWTTQGq9cqUzRQmVg==
X-CSE-MsgGUID: YKF6Px7/QbGYwVCWci1kXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; d="scan'208";a="250001290"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 19:34:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 19:34:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 19:34:00 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 19:33:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPq3CMvkJwIhoeoXSG7IbKAX+G5EG8GB1bq+gaBOavprdOqG1dOtslMm3STOfFQS0CT4VcZ/ycVwJtMJenJKyhGywPC7cOqbvECl+ROu3I36mdty9CQ4c6QRP8LsRqyeFMo6xX7DMLU7QQ+d2oV2MqZI+GQF7QGZc+Xq7K7KOxs3QYMbyPs9UFIEfbm0m6lZmFaTGv+kSfRMRuSfFQF4MpOJA0K0WDjINALdlzs4IkGkPREf6qgd684f2uyOEBdi+4VYHOD84oVprY8RW1bzaLi+F/1SwJN1CG9jOF7+nVg6GPIstZNNAB4jYt8KusDMnhKpxCB3EUpC0gEaDmqA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn/2vpV1BB4cORgUt/YV1KEfqrHmdh2/NToVCmCABPU=;
 b=K7TidHAVlYjnXHYM6OEBAudy5jRXV0+VY56VqVZkqZo058rJSwuG0oYSyfQbdIiWo9+otyezs+SVXmukKCOpZBSOUOpR3U6oEreiP46QCEtr70pSFnGqf7CcUi6LkAJLA/+2Hk18Ds1wGuct9/L5j47PXLMaCzitjjIp1YTm7IfAQpQSPQRDsMCpNOx3DMd4rNitTfjtxuCd0R+nt74S47aNlOaKuNI6CZ9fCoAM3xXVWDTFU3TzTQ33s8SnNC0chQLsBZSRQHRldUfi8MsluNzPuGoCjOyHlkZkPlGRzA7QV7cF4g+WyDyOBbYm8uv+XCZYpCgCGjuFCflIIWLLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 02:33:51 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 02:33:51 +0000
Message-ID: <eade7c58-623c-4c26-90f5-02b2fb0c08bc@intel.com>
Date: Thu, 25 Jun 2026 10:41:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] intel_iommu: Correctly set pt bit in extended
 capability register
To: no92 <leo@managarm.org>, <clement.mathieu--drif@bull.com>
CC: <jasowang@redhat.com>, <mst@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>, <qemu-trivial@nongnu.org>, 
 <richard.henderson@linaro.org>
References: <0e37033a142f1831c1007825bf497c8c56e80b57.camel@bull.com>
 <20260624103933.1793586-3-leo@managarm.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260624103933.1793586-3-leo@managarm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::15) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA0PR11MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb634e6-35c0-4da7-aba9-08ded2623135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CyOzSPFtty8/8Os/BYGe2Rhe366+4w+4780m40CwWm0WrmLn4Lq5206ZyGxrIWOjBM9NKHYjoUEXbbMchHgGD5BFlk7Eev13rFCpluosKhjTe3Gik98BOWp+0DrHKQlckhNje/GEVx3ppZsDvrwkrOhdPpf4ZCfSuz1Fv/kPHUujErXsxD0w7oMG9g7u1Lg6zD7LzCZOjzdWfJC8xYt1GNeHEiypLOzUNvXNQHdlszs06uxgKsMepM32lwrN0iVgTyyeeUlle5U5kRSxAmaVjG287abGFSbQNprTGAcaMk2Uf/K5AbHdCVxG8PvYRuQWMubcs+AUo71lCk0bHKG+DxcK/JLOsDRLG0mq++B3E58b0anALCvHYTyHXoUBkWXs+z09D0nnedQbCGOdp2QpJd7LribaVFTgk0hzlQN3thTdjGu4AVUo27aH2eqw0p75fEXtyKDXsBxcVMACFHOpMgA0yBcbHgLp2Q5jd9cGWolobl1mZnjDkGTCBBmKIbKL4qWySwttDRnPWHpTkoKaEQNdDBvUKvUAhzHn80T9gjTf15Gv2yS3+diUP6lyDYzV17JcLZ4eIR++1wxkMJo7hqWi6OlfdbZ0tkghnNjONMkfqU/bazouGwULFz1APMH6bF24rZitdC2dvvz+U3DBX0FUf4PrhNGudlhmVa88EPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anYwVk5TMVZGYkRndjRZdDYyaEVwRkx6SURiblVaQnR2aW54QThkYlRiMDha?=
 =?utf-8?B?YkoyTTNrQmZyblE5Wm9Qd2tjTWJHNzdXb3hUdnNTS1phQVpYSGhEekZuS011?=
 =?utf-8?B?ek1UbDVDQjJHMDY2c0M3QkxsbHF4TDJwdEZRelNwN2dCYUxzekU2WHhHd28w?=
 =?utf-8?B?OFFueDQ4djNiMGRBUTBNeVBLd21vdUdqY01hV3dGek5RVVJwdm5PcWtHN1Zv?=
 =?utf-8?B?MkhkSWhyT1lnQUp4cnpYVFYrTkp2NjBjQ1Zpb3JTQ3NGYitSYm56YWI5dnlH?=
 =?utf-8?B?cFE5OHpQWDRIZ0ZidWZwcWI1MTBYQkt3WWJ6SGN4bnd6UDgyb1pmdWVRRk1T?=
 =?utf-8?B?LzV4TjNKTXZiMEV3eHc0ZzZ3a2gyRDVVSi9nYmIwWGdTQ0FsWitGL1hSY0Vi?=
 =?utf-8?B?TjRBZEhBemQxL1VrZHlUelArNUk5aVhlYnF3RmRjNkhNdHcxSlRsYnNnYTlW?=
 =?utf-8?B?K3h6VG1JYnBkV3VlK3pBZTlUTUd6WEgrVDdKODRVbG9YWFI0dlZ5Ym9YS1FQ?=
 =?utf-8?B?TGpsckhPNlpQTG5SdEdaNm05aHpEWjl3a0tsTHFqRXVSK2hVbC9wbERBejdz?=
 =?utf-8?B?anZObUEzSkZuYUo0Tko2bzlQU01DRGU4QjEvdjREOHdvN2JaOFcrTlVKM01S?=
 =?utf-8?B?cVJxZW5mOWY2MXNPM3ZLQjl2c1NCQ1k4YTg2WXY5VHRUSTZRUU14VFp6a1ky?=
 =?utf-8?B?eER3TWZkRGYrUCsrVVExZ0lyTHpDa3NFYVNKNEw4WjZXQ3FZanFFT0NLQmxB?=
 =?utf-8?B?MkJBdEpwU1owQmt5R0J6M0JvTFZrVnllVFo2Q0ZjdVRBb0wwZGVuTkhZRm9N?=
 =?utf-8?B?Z2R3RTlqNXphV1huZVA4cGZSS2ZVZWl4ZURJNGs4N2FQMDNXK3k3WDdOV0lr?=
 =?utf-8?B?cEx2QTdmRGhhVDRNNW8vTm1tNHdhWWcvcGxKdjlWNUVubmUvZnZvSjdoY1Bi?=
 =?utf-8?B?cEVSNzVSenFlOU5ZTkNoZXlkRTNGYUxJVzVyVEZjc1BFMFgwTzFrZ1kvd3Rv?=
 =?utf-8?B?SG9Fd01KTmtEN2NSaG14Tk55MXdDaDhtMyt6eDZCbFAyM0ZpY0RXMVFHdnhS?=
 =?utf-8?B?cEwxb1dxQlU4UDF1N0dsQWo1R3o2VnJwd2lwUXR3aDl5M0dXT2JhVEJDbDcw?=
 =?utf-8?B?b2hTazhMbjVuS3EzMTVwRlMrY0NpK2xDSTRaS09na0ZDMFJma1B0L1FKVjNo?=
 =?utf-8?B?V3lLSko5S05XbEtsUTY2VFVEZjE2Mi9vYjdlZ0ZEaUtOYXBkaXdPTEZxVlhJ?=
 =?utf-8?B?MTBlY25NemVnY25jSGlSOTJFZGhVMjlLUFpNZ01jVWxXcDQ5ejJJME5ZMmJm?=
 =?utf-8?B?UHpOQjFqVEp3TmxpZWVxTzdqUGVudFFQWExkV3FSQ3p6LzNrU2NSQ2dxV2xG?=
 =?utf-8?B?amZuR2FDM0JWNFpKOTBVUXlPam1INEtRYVRmcmZzdlFCeWVOc1MwS0F5V0oy?=
 =?utf-8?B?eko5YzNOUzAxWHlUcFJNVlRmRTZLSG80S05MY1pwU2pQbU1kSjZoUEZXVmN5?=
 =?utf-8?B?OEx2RFB4N0ZNdkFHeStTZVdHRFB2K3Btc3ljZFgvK1NIL01LUDNNb0tTWStY?=
 =?utf-8?B?TVZGVjhMUXk1bW5WRzhXaEorMVdGOVk2bGRkNjZPUDhSY1I0NnAxT0hzcVJZ?=
 =?utf-8?B?cGVXTG41N0NaRFFxQjk2Z3NaaFdpM1VIY20rQjlrbzF4VEVtZHh3QnVFdFNp?=
 =?utf-8?B?NExWMzRXeEltSXpqYWI3bXpBLzFJNW1ZRGMyYU1CTkk4NDIwQ0NwN2FzdnFQ?=
 =?utf-8?B?Zzg0M2swMzYyTTh1L1o4VW1GcEFaSXlBa1k5dUFVRTMyaEU3MHQ3R3ZGeFBs?=
 =?utf-8?B?YWhsRFplL3p0TWc5NTVzTWtyd0xLZkxraDNYZ0pZOW1wS3YzMlRHVGJzeCsz?=
 =?utf-8?B?cWJmSFB3dUJtT1RkOWNtVTFCUDZUSmdXb0dyeld5bjZYdGVCN0pYWitINzE4?=
 =?utf-8?B?NEtKaEErQmJDb3VkdElVQ1ZRaC9pU3U1c0NEalhNeXFZeE9va2NsQzg3NjVC?=
 =?utf-8?B?K3hVOWpSSFNBQ1FSM0NidGU3dUI4ZlA4NFBKMmdkakJ3QmZENzBMTytVVTB5?=
 =?utf-8?B?MTd2Uzh2OFVoZHhSMWFPNmhDZWV5M0I5ZFdCcHVIcHkwZS9oTVROQUpBeTI5?=
 =?utf-8?B?L1gzWUR1dzJLMXFqY2xiZE1DS0ZNUXljVTBmUXFMS2JoWXdaREMwTGR0eTNu?=
 =?utf-8?B?bmg5QjJHQzV6eUdFVDUrcWNJb0ZieGx1aXBjZXNZeUdxVFpVOGIrK25QaFJN?=
 =?utf-8?B?WWIwc3BnSFZaMHQvYmFkak5tTERVZ1VMUkxuUjdtWEQzOHBqVVM2OVowZkpI?=
 =?utf-8?B?UlBPditSREJQSU1zcUl2SjVnT09TM2ZYRU5yd2hxV2JRc21uT3BxQT09?=
X-Exchange-RoutingPolicyChecked: ooLx7tr0QSbj3yQ0acrH7GPAbTY8qJEHRhBgbeHV7yiXcwheic4C8ed8Y2286xpxP1RmNANIrHj0LK75khA6hFKQ17PYEZQ9tKInANQ2xYuKv8SQQ8D5DJJ/C2BQj6Q1h3YtRRV3/uG12SPIL9jk8xVKFN8ULTCFJqskcgx72oj6tCMUK59X0j+MPJ43vTt3XYX99HHRXgd8lqc9Jnh4JVj4fuUdkvLjjCdMhSaG2wzdP96looUusP7vYknRCqHo7/PxlxcLcK8uUtwmexYi3Qaph00197XxJnxk4YzHpXAF2hjlHp5yJN+PjPsHzMaMOmxCYm3EqWwBsdua8AvJhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb634e6-35c0-4da7-aba9-08ded2623135
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 02:33:51.0606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m29A6iM5WhWQ62pWlOgcPoISGw47CbTmDBDTg9YyHthBCkc0aJoZCi2kwPOq6kxSnl7tPSsY58vECSdkmc/leA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Just a few nits for your future work on the mailing list.

On 6/24/26 18:39, no92 wrote:
> With the changes in c7b2e22bd957, the `pt` bit was set in the (wrong)
> capability register, instead of the (correct) extended capability
> register.
> 
> Fixes: c7b2e22bd957 ("hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field")
> Signed-off-by: no92 <leo@managarm.org>

It's generally preferred to use your full name (First Last) here unless 
you have a specific reason not to — but it's entirely up to you. 🙂

> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
> The only changes to v1 are in the commit message phrasing, as well as
> adding the Reviewed-by lines. Apologies for the confusion, I'm not that
> well-versed in the mailing list workflow.

Since this is a single patch, placing the change log between the --- and 
the diffstat is the right spot — good instinct! That said, it helps to 
be a bit more structured. Here's a suggested format for reference:

"
---
Change log:

v3:
- Tweak the prefix of the patch subject (Clement)

v2: 
https://lore.kernel.org/qemu-devel/20260623082223.1431499-1-leo@managarm.org/
- Use 12bits commit id in the fix tag (Yi)
- Adding r-bs

v1: 
https://lore.kernel.org/qemu-devel/20260622162138.1045170-1-leo@managarm.org/
---
"

The per-version links are especially useful when the patch subject
changes or the patch gets split during review, as they help reviewers,
maintainers, and anyone following along to trace the full history.

Last but not least, thanks for tracking down and fixing this bug!

> 
>   hw/i386/intel_iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 744cdfd2e6..d1af7a3135 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4988,7 +4988,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
>   {
>       X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> 
> -    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
> +    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
>                VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |
>                VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
>       if (x86_iommu->dma_translation) {
> @@ -4999,7 +4999,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
>                       s->cap |= VTD_CAP_SAGAW_48bit;
>               }
>       }
> -    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
> +    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO | VTD_ECAP_PT;
> 
>       if (x86_iommu_ir_supported(x86_iommu)) {
>           s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
> --
> 2.54.0
> 


