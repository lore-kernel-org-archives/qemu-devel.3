Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD13C3814E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 17:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPnCC-0003Qr-0m; Fri, 05 Jul 2024 13:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sPnCA-0003Qh-Bh
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 13:58:06 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sPnC4-0006dK-0p
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 13:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720202280; x=1751738280;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VawrYnEVbNChdsjAGVqMFuoCEX9tay/0ND0BiLff8ls=;
 b=JCQ47stDz6Z+AsZWG92vSCWyL1bze7u/tA80FIw6AfAm0ah0IRiS+Zsm
 f/nNg91epP/j4mQoLbqnFo1+EHgfjc/cewsxEz5H1MzAVar819ta9QE0d
 sFp9D+bl9Mle1LfZRM1lcB59TmZYcCG7yfR8OBJosxRa6EpzZGBu4O4F5
 V9QOA9kJmmlknxpOtq2GHP9kFCWPX10Ixh9QnMMeYsdBtZVH8zeMbkWmk
 +H+4aBzykmQ43I/lLv6l00C6s7Xx6C8WfVccNT82te6L1ikqeigksnLFc
 TbfHsyo6J17id5DU0oMfpQgiFhafwq9TYeSbJfN4zCHhIouRflsvP8dTv Q==;
X-CSE-ConnectionGUID: TtIcjRigQe+bDfjPqa/4Bw==
X-CSE-MsgGUID: zkgf81yGTKm3dmjc23SPJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="35036580"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; d="scan'208";a="35036580"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 10:57:54 -0700
X-CSE-ConnectionGUID: dlLTEX3XRRqaZQ3AnzXNWg==
X-CSE-MsgGUID: i7L+QByiRhawOawedR3cRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; d="scan'208";a="46925281"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Jul 2024 10:57:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 10:57:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 10:57:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 10:57:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2i68iRGuEYEC6uw+aCat8/wlXbhM85pXZCeJkZyJq4wnTRzpQytWCm7aPtUgBBFa6/xPSS+aE4oF7brNd5LjBJp/R2/Jn25k7Ih2HRiijDpxAy91xBhG8K/LrIvk072qeHnUIf7/pAfVkan3bgF92l2A2kiAazBDTmn9pd5xdGromX9X1BUD+9ymBROwyEyUkTd5tUCJZqutOhafoMy1ugIx8W9wDMgLdvp1q9XjgJHdhQkRKt/2zMiC9bLOzR3t2b+d5igKjmTikL7JUo2QGM8Xrcn893FjjP2EcuAiblN/gk/p7GcXjT4EfpyVJXLBydSgXTjkiQVzhlEFo+VJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlHrY+Y/RdKI+OPWigodb/G97HA9v2F1p5Nz73OeeOc=;
 b=H6ybYqGbYYq0oJbcmnj+hjNWWOjBbH8QpUPR4M+4arFIyLU6aPWSVDtuRle/rwz+1EATkHYV/oZRjvAdYSH7VSxbUq71RtoCtItrnSLf1IAbtcQqypz6Py/6+hghwWJ8TUuq8yiTJ8bT5BZtqQA9ggQIY4d2ViuD5qv3oixIvy3/gxmDTFQU5O+M8iKanzi1tX8zRp4l9u7bOxVbnX7Kht9N9z0nE2rTEPIoxJdQRnrnNlOkYYmtylT6uh03zrHnnZWzu35fIubi82o9mPXlue96uIv6FDQW/rtY76OzIU4nAMEOyvRtnyOoWkFHcxnDRFVnmfijkcjOwc32WW1jJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SJ0PR11MB6575.namprd11.prod.outlook.com (2603:10b6:a03:477::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 17:57:45 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 17:57:45 +0000
Message-ID: <f41a5b4c-92ca-4c8b-bdd5-d2f22b8482ca@intel.com>
Date: Fri, 5 Jul 2024 10:57:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ui/egl-helpers: Consolidate create-sync and
 create-fence
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>
References: <20240702205503.2774745-1-dongwon.kim@intel.com>
 <20240702205503.2774745-2-dongwon.kim@intel.com>
 <CAJ+F1C+ssSiGR3tOzK9Sj_8gn2k-rX3_w=WKG1-n35uVBSn9PA@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1C+ssSiGR3tOzK9Sj_8gn2k-rX3_w=WKG1-n35uVBSn9PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:a03:60::33) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|SJ0PR11MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 236a1693-d239-4a88-8307-08dc9d1bf91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVBkRGg1a3RkZXByU250cCtTdGJaQ3VvcWMxUElJcy82ZXRVbHhSTFQrNmx5?=
 =?utf-8?B?eWJBRVF5V3lmb2NMK0p4L0xrSlRsUm5PTGt5V3pDT1U5a2FNVGliSGFXekI5?=
 =?utf-8?B?MWN1TEhjYW15aG92eTNFVUt2b3Jxa2N0KzlaWVY5UDFWRjRRK0hCTWtzbzBv?=
 =?utf-8?B?aDZ3YjRUNmcwQnovWWI4R0RoZTNCQVFzZW4vU21LdlhhU2hqUzRQeWtEYVF0?=
 =?utf-8?B?YTVrZUpwZGVHTlhFUzh0RWZTVlUzYWk2ZVh0U1IzOVV2a3RCcG1pNHk3TSts?=
 =?utf-8?B?VW5UV21yczcwTlJ5SnNGeS9NazF5Vi9vdkZkekdPTCszMWt1aGdGVGNuZkM3?=
 =?utf-8?B?cmRKTmtVUGpkU2M2NE1BM0cxbnJQOXI3VEhrV3NiaTUxQ2RnMEZPcDhzYXZr?=
 =?utf-8?B?cWoxdTdmNTRQUnhrQ28vNUloZmg0dmJwcDdhalJBTEtoSXZXbUJNSHFPVlVk?=
 =?utf-8?B?MG9jY3I2VFNvVWczZno0UFBISE1KeVJvcm5WUDN3UURUZmRzc1N1STFTdDcy?=
 =?utf-8?B?bCsvMXVOalo5MUhJRVpFRHVJVUp3NTBMZWE0ZnZqdE52WSswYUZ0Z0M0bE92?=
 =?utf-8?B?UTgwQng5Rkd2TS8yWHgxS2plUm1xUm4yOEpudUpBbW9vZFluWHpBTHVtMVdV?=
 =?utf-8?B?SEZ0L1VHNGV5UFl3c0MzVjIxeUNQUTdpL25rbDF0SmpmNG9xVUJoQVAwTUJB?=
 =?utf-8?B?b2l2cytiZXVidmR2bFdlemo4dWxvK1ZrcGxFb3F6TFRyWmFXWmJlYk1QWDRv?=
 =?utf-8?B?aHZUNVVYb2ZYTnpQd0RLSkxnSVBKem5SbFdsb2V4RTlCcjJMeUFHd3ZCRkVF?=
 =?utf-8?B?WWtUVlAyMVJEdzJPcC84S25YVE5UWFRLMkF3MUt3S1BJSGc0Q3hKWHlBRnFq?=
 =?utf-8?B?US9pREhDMTdqUGJ5L3F2c21ZK0laSnB3UjZPOVl3ZGE3Nllzbnh1NkdJeHJv?=
 =?utf-8?B?ZkdpTzNBaEdIYVVYUWVXamp1RVBzNmFBMmtpM0Y3SThLQVMwdEtyelVoTzRh?=
 =?utf-8?B?UG1sNWZUSmFJd2F0bUpVaUVzc1MraWYvZmIxcjIyYjZmMU9OVlFJSzVZMUNy?=
 =?utf-8?B?MFhlSnZCRjlOd3BpcmoxZmkwc0RyQjlEZE9mT1orM3E5UGI5NWQ2ZENadUoz?=
 =?utf-8?B?clIwY1lDYlZKTFk4MlpRTEdGN0dNSlBmcUcxb1V1MGNIZElBb1crZ2JqaitV?=
 =?utf-8?B?cnVsVVNUTkpRWTRCV2NpWGpodDdFSnYyTHVRSzJjT2trb3pXWHhHZDZBaHpV?=
 =?utf-8?B?UEdKVEV4V0syRHNReVVKdHpxSkFkSWp3d1FWcStkbDhNUXE0YUhBU2xSZWpl?=
 =?utf-8?B?ejVzTnVIZG5BblR4dlJHTGt2NTN1Q2phdUh1Y0t2S2lzQ014YTdyRXpMbnhw?=
 =?utf-8?B?WERxSEQ3QlQ4UU1yZTYwaXdDZmxtQXAweDNPUm1ZaXlRZWRjK2RWTlN2cHp3?=
 =?utf-8?B?b3RUQmg5cCtNWHZ0V0k1TldwbTRBTXFyV0xDbmxBV0tWSDQ2b1hNNnpZRy9V?=
 =?utf-8?B?M1J4Ui9peTJWMHVSNFpwV24rSDkzMXZRZnFQU0VHUE1UdEIycmJ6dXhuL1Jn?=
 =?utf-8?B?QWk3dHdHYU92STVNM3RtVmVUeW9XbldINGE4b3lKZFVvbHN5S3BySzlhODhT?=
 =?utf-8?B?Rmt4RGtXSnYyTlFZR0V0NzUyWkFTMFdSeldnelFkK054VU93bVlydkgwTURv?=
 =?utf-8?B?VlBZVWMrblNOZW15QTdRT084UUJOQjY2eUdmSytVSmYwR0JkVEl1Ym5OYnhX?=
 =?utf-8?B?T1BwWXUzR1lxY0w2UVB3eDhEVVNVaEdlZkU0NHZxb1VmVWFkZjZ0bk9lRGc4?=
 =?utf-8?B?SUJ4S3lLKzE1dGs1NE5Jdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjdpOEpJWmdrcnRkTTByR0trMEkwSTF4amJnZVZaRVBNUmZmVTNUZWJvcHl1?=
 =?utf-8?B?cWRiL1IzaDFHa09ua2RiWHEzZTdSNzFkTjhiT2pnUXVOaEFXUFF3eFZXdHl2?=
 =?utf-8?B?NDU1S0NKNWtuYlBjSG5ZeGlqbW9HVmJMWlI2Y2tZT3IxQS9VTDBWU1doelNP?=
 =?utf-8?B?bTlnSHNhbXBoNDN4c2ZUYms0TTFFQWVMeGxhNnJhUENmS1NyKzZFd1RMSTMw?=
 =?utf-8?B?VUF2am5jMjJ1bmgzUTdpVncrZ2tyRTUzZmJ6a3BzdVRyTS9UQ2RYM1BSNGdx?=
 =?utf-8?B?S0JSTGhnOGhhUGYwaTdWS1dmR2o5aWhXOElIa2pPYXo3cGFEaDlYSDkwVTVh?=
 =?utf-8?B?YW8xZkFzd0d3U21ab1JiYno5RDhUdDN2eHNYeEhzNVlHalAwbFRvaWxDUkhT?=
 =?utf-8?B?VFhNL0dVNFpPUlBtTnhacXYyMnpCanRDTEJiTjNvb3FrSEtOTXIzMW1yVnpV?=
 =?utf-8?B?MzhwN2ovUXp3ekZMcGJkZEN5Qi80UDJ1REtlUFR4bXFKQlpFQW1xaXg2UkZo?=
 =?utf-8?B?aENOMDZxUUNaem5DTThTRC9JYW92VkhzTmlhNkYrM1Vhd2JSY3lnZnFsRzd4?=
 =?utf-8?B?SFRBY3EyazUrbmtaSkVYb0pNemZ3cktHUGtZSS9XbmN2RVFPNmxMNlErRHhU?=
 =?utf-8?B?ckNnZm92MWtKQnZEc1dlSVl1eCtHMnlhUVNaelUvb2RGZzhmWnFIRG9sQjM4?=
 =?utf-8?B?ZXNYU1RlSmJPUVl1UVprWU9Va3ErMXpNai90bkdEeUJlT1RyTzBoVWdiVjVW?=
 =?utf-8?B?dFIvaDlobGI0bjUzQ3RyQkJMN1lmY0NJWHpLdUJKdHNsN2hNUC9uUjVKNmxy?=
 =?utf-8?B?Ui9sbnFPdmo4VC9qbzRUQ0FDOEtobWR1cTVydk01ZWlYamFrNUJQdUNkdkxE?=
 =?utf-8?B?dlI3ZEZZWmc0d05mUmFqeHNkaGpzZzZaTC9qdTdudWwwNzdiL2x0Zmd6cVNT?=
 =?utf-8?B?c2Y2NTJOZDZoZjgvcWFTMW5rWUg2WTJrM1p2SjRoN2xxMWd4S3habm1yTzEx?=
 =?utf-8?B?U0ZpVmZDcFR0b3pFNU1oWVB6cDdaeUJldHRHaTY3WDArd3JvYk9pM1NKVjlR?=
 =?utf-8?B?cmlNaW9TZWxrVkhwdXMrVm4wNXZsZDQ5OGpHNWJPK3d5Y1dFMzcwTHJtUG5l?=
 =?utf-8?B?VXlHcGxmNDlkZnZ4cElvbTk3M1lzeDh1VWJ6S3dyc2JZUEJNSXNibXlkSHNJ?=
 =?utf-8?B?RTI5eVFYR0l4UjBLb2x1M2xFR3NvRkNQSFhMZXNwVm12dU1IR2k4N09lcmtB?=
 =?utf-8?B?ZlczN0FyRTZDdWVrd0YzMUtwRTU4QW0yc3BodnJscFRsZHJ4aTFuRTJYVXBl?=
 =?utf-8?B?dUUwNWZ5TFdKS0JsODFrMGRIQVc4cE1RazQ3bFc3ZFFlWlppZmo0dU1McU5X?=
 =?utf-8?B?c3dZcitZSHJtQVFsWkxXblpmbmhsNUh5aFN0QWdZWmFWOS9UZXJ1YSthbmZi?=
 =?utf-8?B?WmlBS2RmRWNMalJLNUtNNDJDN0xkdTZ0ZmJnOWs2andUK3kzME50SEZjb0dw?=
 =?utf-8?B?KzBaeVNYM2Qxd3V3aXlmdnRxM0FWUkd6MXVtNks0Y01oTkFETGdTOGo1T2Y1?=
 =?utf-8?B?TFNNaE8rQUZ6RVVoRVd4QklNZWsvNFQ3SDl4L1JLSmhUWWJvQWVFTDZxNHBz?=
 =?utf-8?B?VjM0Zkl6cU1mTzIwNDVMRlBOcWlFQXZHaEEvaWpQY2Q4QmdKUmlTK1lwZ1Vq?=
 =?utf-8?B?bVJOQWtVUnZ6SktoUzF2YWl3WDNaVFN6QW9xTVpQemlFQ3JxK2dBUElCS3lo?=
 =?utf-8?B?SXYwa2Y5VnRiZkd3RUxsU05XTmZ2Y0hvU0dqVThVZTZXdndOZ1dDQ1prdUtV?=
 =?utf-8?B?YW1YaE5Gc3NtNWxxQzZ6N2dFL2t3U1NrMTUvbWIzNm5KSmdVRFdxV3NDK1Jz?=
 =?utf-8?B?QmgzeVVjNVZMNDRWMWJmNlhjQkV2b25NQ0x0SWdEZFExWDhvRGZmUUgyeWUw?=
 =?utf-8?B?Wk1LRTZ5dTFWZnZycldWRVpHRzVpMzRLZnVuc09GSEZSc2NJQnVTcWgxbnVW?=
 =?utf-8?B?RnJjZzNNTEZiQnJzd0dWTitKZW94VmxLdHdURjZPRTZxd3ZDY3ZtUjIweS8y?=
 =?utf-8?B?NWVjc0QwekhibHJxYk9OL28zdlUzYis0UzdVaWYvbmFIYjFxQVFuM2d4aUsx?=
 =?utf-8?Q?MwylQA43WO55Bs9/dsghqOFJp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 236a1693-d239-4a88-8307-08dc9d1bf91a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 17:57:44.9711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jp3/461tPC7KR5S9E/jLQ9yW1GgXhMQsAR33LUVn1zm5AWz7uckN6YlonvQedGPzr7EVKJMtfLZXRbfQM3pozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6575
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Marc-André,

On 7/3/2024 4:23 AM, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Jul 3, 2024 at 12:57 AM <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     From: Dongwon Kim <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>
> 
>     There is no reason to split those two operations so combining
>     two functions - egl_dmabuf_create_sync and egl_dmabuf_create_fence.
> 
>     v2: egl_dmabuf_create_fence -> egl_dmabuf_create_fence_fd
>          (Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>)
> 
>     Cc: Gerd Hoffmann <kraxel@redhat.com <mailto:kraxel@redhat.com>>
>     Cc: Marc-André Lureau <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>     Cc: Vivek Kasireddy <vivek.kasireddy@intel.com
>     <mailto:vivek.kasireddy@intel.com>>
>     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>
>     ---
>       include/ui/egl-helpers.h |  3 +--
>       ui/egl-helpers.c         | 27 +++++++++++----------------
>       ui/gtk-egl.c             | 15 +++------------
>       ui/gtk-gl-area.c         | 10 ++--------
>       4 files changed, 17 insertions(+), 38 deletions(-)
> 
>     diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
>     index 4b8c0d2281..221548e3c9 100644
>     --- a/include/ui/egl-helpers.h
>     +++ b/include/ui/egl-helpers.h
>     @@ -51,8 +51,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint
>     *stride, EGLint *fourcc,
> 
>       void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
>       void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
>     -void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf);
>     -void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
>     +int egl_dmabuf_create_fence_fd(QemuDmaBuf *dmabuf);
> 
>       #endif
> 
>     diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
>     index 99b2ebbe23..ddbf52bf5f 100644
>     --- a/ui/egl-helpers.c
>     +++ b/ui/egl-helpers.c
>     @@ -371,34 +371,29 @@ void egl_dmabuf_release_texture(QemuDmaBuf
>     *dmabuf)
>           qemu_dmabuf_set_texture(dmabuf, 0);
>       }
> 
>     -void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
>     +int egl_dmabuf_create_fence_fd(QemuDmaBuf *dmabuf)
>       {
>           EGLSyncKHR sync;
>     +    int fence_fd = -1;
> 
>           if (epoxy_has_egl_extension(qemu_egl_display,
>                                       "EGL_KHR_fence_sync") &&
>               epoxy_has_egl_extension(qemu_egl_display,
>     -                                "EGL_ANDROID_native_fence_sync")) {
>     +                                "EGL_ANDROID_native_fence_sync") &&
>     +        qemu_dmabuf_get_fence_fd(dmabuf) == -1) {
>               sync = eglCreateSyncKHR(qemu_egl_display,
>                                       EGL_SYNC_NATIVE_FENCE_ANDROID, NULL);
>               if (sync != EGL_NO_SYNC_KHR) {
>     -            qemu_dmabuf_set_sync(dmabuf, sync);
>     +            fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
>     +                                                  sync);
>     +            if (fence_fd >= 0) {
>     +                qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
>     +            }
>     +            eglDestroySyncKHR(qemu_egl_display, sync);
>               }
>           }
>     -}
>     -
>     -void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
>     -{
>     -    void *sync = qemu_dmabuf_get_sync(dmabuf);
>     -    int fence_fd;
> 
>     -    if (sync) {
>     -        fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
>     -                                              sync);
>     -        qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
>     -        eglDestroySyncKHR(qemu_egl_display, sync);
>     -        qemu_dmabuf_set_sync(dmabuf, NULL);
>     -    }
>     +    return fence_fd;
>       }
> 
>       #endif /* CONFIG_GBM */
>     diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>     index 9831c10e1b..8869cdee4f 100644
>     --- a/ui/gtk-egl.c
>     +++ b/ui/gtk-egl.c
>     @@ -68,7 +68,6 @@ void gd_egl_draw(VirtualConsole *vc)
>           GdkWindow *window;
>       #ifdef CONFIG_GBM
>           QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
>     -    int fence_fd;
>       #endif
>           int ww, wh, ws;
> 
>     @@ -99,13 +98,12 @@ void gd_egl_draw(VirtualConsole *vc)
>               glFlush();
>       #ifdef CONFIG_GBM
>               if (dmabuf) {
>     -            egl_dmabuf_create_fence(dmabuf);
>     -            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
>     +            int fence_fd = egl_dmabuf_create_fence_fd(dmabuf);
>                   if (fence_fd >= 0) {
>                       qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed,
>     NULL, vc);
>     -                return;
>     +            } else {
>     +                graphic_hw_gl_block(vc->gfx.dcl.con, false);
>                   }
> 
> 
> If gd_egl_draw()/gd_egl_refresh() is called multiple times before the 
> flushed callback, create_fence_fd() is going to return -1 and unblock 
> the hw. This is probably not desired. I think you need to comment on the 
> code to explain the interaction between dmabuf_get_draw_submitted, 
> gd_egl_flush(), fences and hw_block, I can't make sense of it.
> 
> thanks

Yes, indeed it is not desired flow. Let me have some time to take a look 
at this case and get back with a better patch.

> 
>     -            graphic_hw_gl_block(vc->gfx.dcl.con, false);
>               }
>       #endif
>           } else {
>     @@ -364,12 +362,6 @@ void gd_egl_scanout_flush(DisplayChangeListener
>     *dcl,
>               egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb,
>     !vc->gfx.y0_top);
>           }
> 
>     -#ifdef CONFIG_GBM
>     -    if (vc->gfx.guest_fb.dmabuf) {
>     -        egl_dmabuf_create_sync(vc->gfx.guest_fb.dmabuf);
>     -    }
>     -#endif
>     -
>           eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
>       }
> 
>     @@ -387,7 +379,6 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>               gtk_widget_queue_draw_area(area, x, y, w, h);
>               return;
>           }
>     -
>           gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
>       }
> 
>     diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>     index b628b35451..a3c21c3c59 100644
>     --- a/ui/gtk-gl-area.c
>     +++ b/ui/gtk-gl-area.c
>     @@ -77,17 +77,10 @@ void gd_gl_area_draw(VirtualConsole *vc)
>               glBlitFramebuffer(0, y1, vc->gfx.w, y2,
>                                 0, 0, ww, wh,
>                                 GL_COLOR_BUFFER_BIT, GL_NEAREST);
>     -#ifdef CONFIG_GBM
>     -        if (dmabuf) {
>     -            egl_dmabuf_create_sync(dmabuf);
>     -        }
>     -#endif
>     -        glFlush();
>       #ifdef CONFIG_GBM
>               if (dmabuf) {
>                   int fence_fd;
>     -            egl_dmabuf_create_fence(dmabuf);
>     -            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
>     +            fence_fd = egl_dmabuf_create_fence_fd(dmabuf);
>                   if (fence_fd >= 0) {
>                       qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed,
>     NULL, vc);
>                       return;
>     @@ -95,6 +88,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
>                   graphic_hw_gl_block(vc->gfx.dcl.con, false);
>               }
>       #endif
>     +        glFlush();
>           } else {
>               if (!vc->gfx.ds) {
>                   return;
>     -- 
>     2.34.1
> 
> 
> 
> 
> -- 
> Marc-André Lureau


