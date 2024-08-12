Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AE8C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 08:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdQlL-0004ZK-9A; Mon, 12 Aug 2024 04:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sdQlJ-0004Xf-19; Mon, 12 Aug 2024 04:50:45 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sdQlB-00072T-SB; Mon, 12 Aug 2024 04:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723452638; x=1754988638;
 h=message-id:date:from:subject:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+kRm6DKYJo3L8YeUmffQ5BHAmS1B9iEvp/cb17fn1vg=;
 b=cmO/5vL0JVDYkeVOro2BtxjH7RzvI4BaXWDZyabj82O2MGGxjnD/QTZj
 Jylb/8ZINBEvbpXG9gwvzDiMi3y8z6F30+Bexrdi8taky27Hwo6XXPzS0
 6BQMzyHE5RMjuhWi7Woqz49bAI28Gch33/vGHQCFByq0SVpXtZ8WQHPTi
 YS3lRkOghdUVjMW7dn8g7jjsTNsrO+/0uw9+WsLJ1Ms+fXIy14nqd496A
 e7VCryuLlcRqCUDv94/hlJoAWP66DBO2ox4iFhXyMACBY5adhVSs8Z/ff
 qrZDy/mPZIRLUZtyEAJGVZ7gPREF/pQ7Irouwzu8M26qLl+5aEN8BjhLt g==;
X-CSE-ConnectionGUID: 5Jln5WQBQ2iam9IDBsR3Vw==
X-CSE-MsgGUID: zCPD7gsWTe68rnTSC9oRxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="44067692"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; d="scan'208";a="44067692"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2024 01:50:32 -0700
X-CSE-ConnectionGUID: pmqD8Cc3QDqUCNw6vtZwtQ==
X-CSE-MsgGUID: DtIOyou+QomiUWj4oOlX2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; d="scan'208";a="58754146"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Aug 2024 01:50:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 01:50:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 01:50:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 01:50:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkkb1qjRbVRGcLR5Qf+J+DzEia2lN4pCxWK7nOTH3sI/nkus9k0GZmYKURcKLdqAWXW+ikIFKXz8N+qsEct4JO3iFMAq3G4+adSfecBb8ro6FyCO3+yAo9i6y4p5hdu+tI4KKJYJ/qUUKmlvdvexET4mnPOq/+Kt9ar0WUI8kC/fxidw0y2k4QFXAcHktH4qLUG2p1V+C/zGnPb6YwY7+NIg+PkGhepfJvPj7hvnOzjnIj49XfrkgArxzNmHKP/9UT6O5j/sx4Lp/vTgmD+WPSOVJttZzo7cgYVOAnE7yKQ7wuSkVt7L8Mn3CTG5uo5z4wBEPlb4fkH2jA+srpQ43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJAL+YrXgyU2pz3+SjCEB+xbtxenfSwfGZqmexR7hB0=;
 b=GW2V7sOiQXQTD2KGTYNAfZGg1rbU7DDzCunE1SJ5GfiFYBsaag3FsZIBk/EDCwCTcXQOJmsOOwY9xJgIbzTZ2I8gLPihyWBlAZiIZd0WlB+ZfUksLgrfAPCbRk//RRA2GUKCLjz6184ADbO+E86bgroAX7qOKsuMEUl8+6Pd0q3DSHZu87mUNN9NQpOxzix6ZRCsrs37clJc/aTzVvoj8jR+ndxS1CRDkLIX9nMg6/CHrFrL8fr97C9BU1Jkmrz2e0pdjfjTvXdwLSCdhC17BPZVxnQ+lqBE6rsUH+TBfrGfonjlQCrhAwpn+FpPgSB3mJbGWDY9eGZ8xraJv45jTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by CH3PR11MB8774.namprd11.prod.outlook.com (2603:10b6:610:1cd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Mon, 12 Aug
 2024 08:50:28 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7828.030; Mon, 12 Aug 2024
 08:50:28 +0000
Message-ID: <3891718f-2f15-435d-a7de-cc40492374f0@intel.com>
Date: Mon, 12 Aug 2024 16:50:17 +0800
User-Agent: Mozilla Thunderbird
From: Junjie Mao <junjie.mao@intel.com>
Subject: Re: [RFC PATCH v6 5/5] rust: add PL011 device model
To: Paolo Bonzini <pbonzini@redhat.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 "Peter Maydell" <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 <rowan.hart@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 <qemu-arm@nongnu.org>
References: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
 <rust-pl011-rfc-v6-5.git.manos.pitsidianakis@linaro.org>
 <9a83a260-4f4c-477b-a6e1-c8d78d1f3039@redhat.com>
Content-Language: en-US
In-Reply-To: <9a83a260-4f4c-477b-a6e1-c8d78d1f3039@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|CH3PR11MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa658a4-52c5-416f-1a75-08dcbaabd0cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emdUeGxhNFA5SmhoUkNGKzZJMy9CNWpxOTNjVzFNeUhWQ2toZjFDNERWQ0FY?=
 =?utf-8?B?MFArT2NYcGROWGltWDliRXJiVkNaWGRLem9hMVk5ZGxPQW5jVnZ0SWt5MEI4?=
 =?utf-8?B?V1VycC8zRFdrWVBSaDlOVVBBVDdoQkhoWFVxdWczQ1RuK013Q2tzY3lzQW5n?=
 =?utf-8?B?cy9xM0U5ZWxrTmtIY0JyMXhMV1VsZUZvUklIMnl3YXFyUFlYNUt2VUZUaVN0?=
 =?utf-8?B?NUwyMytRdlQ4Y2V4SFBRYy9rZ1BPaGFmdWFDWGM3KzdOa213YnpjRUZ1Ynda?=
 =?utf-8?B?ZkRySjJBdHJ6akNYdXlyVFdqbDVwVkR1aHlrdzg1V0V5Sk45K3hyQ25HWFUx?=
 =?utf-8?B?WnFTa3pzRHY3em41VHVKYlRwMEt5S2lKTGxnUmg1MGZNZXVEeEpTRG5ZNHhS?=
 =?utf-8?B?SytOc1dHNjJ3R0Y2M1NlZnZkdkJ6c1hkSFRZb3pZSmVwVUp3V3hlNDZjcFlP?=
 =?utf-8?B?cjBVUTZDT0k1NmROVGhSMzdCNUpxam0vYS80Kys2QkdEdzVuRVZMYTAyT1FD?=
 =?utf-8?B?VHFteEZCNnR0bC9KNEtyMDFxMWtMSXFoUVEzSE5yZnE0VXdKbmMxTDdTUTZo?=
 =?utf-8?B?M05SenhiaTQrblB5VkJPNjFCdjRqRVUxU1RYUkRCdmlaZGd2VnZZMHVXNXlJ?=
 =?utf-8?B?UzdZbi9EQjFVWEY0WkgwYWo1dEJnRWtGdlVRcFZnSGdVb2RaTFJoZW1GczdP?=
 =?utf-8?B?UjNuVWpFMmk4bURoNHEyb1BwTGRyUEhLQ3hQRmRzZkxKSFJIZUZZRUtHZURH?=
 =?utf-8?B?Sys4RDJIWDcwdkxBb01LNVluM1RMa0p0K3ZJeEU0QXArK2hwbk05RDJjSUlC?=
 =?utf-8?B?a2dEd1NNYXc5SWtIbDlXMW9sdW9YYS9JZXVYSHFLUFN6YzRsaTVpMlZ3RDJz?=
 =?utf-8?B?TzREZVBHMHBYU0s4blNxYXlzYzRSdjMvWEgvYktrbjJRLzVaOHZPWFFtMXE5?=
 =?utf-8?B?RDBxdXNwZkF3YXl3ZUNyc1dFQ25vRXZ0Zm13K0gwS3lnTGQvemxIZDk3a1Jh?=
 =?utf-8?B?Vlhoa3FGNnFiSi9UQ1I3MmtETG9YNWcwNXFNS1V4eFREMVJZTXdMRVA3NUlk?=
 =?utf-8?B?VEZ0WEJNTDZ1R2NweWUrd0kxbUFBblc2bXdybDhMNVc0bFZ0L1ZZWUdGdTJm?=
 =?utf-8?B?eGxNZnd0ZEU2UFd0TU9OeEFwVG5yMkhCOVppbzUvZGU3TmdPUHlBQnB4cmY2?=
 =?utf-8?B?dmtKNGZiRS9NZVlXTTgya0gwOW80ODk4elhzVkc2SlJYcE90bkZsb1l3UXEz?=
 =?utf-8?B?alBCZmsrSkZCOXpRQklVT3B6QWt5QVoxZkswSFpaYXUvUzhNUXZsK2hySzhl?=
 =?utf-8?B?K2hhd0hpU1pzNyt6b1BNaHE1bER3NldKWUsyTWRiZWt1dnoyZGNBS2IrbDFT?=
 =?utf-8?B?VkFVN29HMEJwcXRLRXpOSDFDWlZaSDFYaTJMWDAwTnBKcEZORjdnd0Z0bUtY?=
 =?utf-8?B?N3E1VE1hMnoxNXFjeUJvaE40dkExdW9PQnFoNUJ0RWU3RnR1ZGtIcHQzK3JX?=
 =?utf-8?B?Q25nVFBOUWZKZElVZUYxMVlnREV3MzJwOWZJN1NlTHZ6MmdSOW1iMVpGR0N2?=
 =?utf-8?B?ZW1LdmljSGdVWlNlQVo4VkJ3MGFOZWVYWUlCd1F5R010Mlk1dkdqZlU3c1F4?=
 =?utf-8?B?QU1UMkl5SkY5Um0wcTY3ZGdmTjErR0dkT1FxK3VTTzhpcEdvY2hQSDVnZHgw?=
 =?utf-8?B?dXpWRzVaL2J1dDFuY29Pd0ViMHJIWkFTNGVhNHBOcWk4em4wL1o3Y0tDYUly?=
 =?utf-8?Q?d3jfa2ZYf/TsmKgPiA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhNNm1WenVHWmQ3OSt4UmxEYnc5REgzOEkydEpMLzFFdTdDS1dtOE5PT2p0?=
 =?utf-8?B?dHZIZTFIaWpvajU1cDNZRE1CMEhqNC9oWGNhMlhnT1pMUDBuWHE1MEIwS0dZ?=
 =?utf-8?B?YWgveTZVNFhnRUJYZ3FFRFdMMFQzUTZ3R3Y0aElrd3MyOXptdXJvUm1iK21t?=
 =?utf-8?B?RHgvekVpeTVlZHFZQkt3aFpyN01pZWlYVVRlV0dubnN5RHJoaXFrdUJtNXVP?=
 =?utf-8?B?LzU0YmM0UURUclVKZVhOOGNlaE9jdlFFbFpjUmwvK1VsYXh2ek1HVGJ0bzE0?=
 =?utf-8?B?S0hDNlhPdnYwYlorakV6eFgrUmlQUlpOb1hFNEhpOEhONkxUdldLZTk5ZWdx?=
 =?utf-8?B?UFFsdDhxdFNDV3RTUUJPL2Zva1ZBODhNM1pGWXlFa0FCYnplWVVkam5oSnE3?=
 =?utf-8?B?N3VYbDJmRWFQSjRhelBGN1IyQjdodG83ME01VWZ6VThnQi9nYWlXVVA3OHEx?=
 =?utf-8?B?MkV5ZzF4c1EyeEN1Z2dPOENBTXY2TFNyYWRwK1F5b1loYnk2SHRydHprSElD?=
 =?utf-8?B?VjFVOFF0czlNSkFLUlRJemRYbzJldkpkdEs5V3NMZ3gxTElRUS9BL00venZU?=
 =?utf-8?B?TVBWWkJvV2lKbC9nWE5ML3g5dGg5d0RHTlB6KzJoR29TUCtaeVo3SGNIVUF2?=
 =?utf-8?B?WXRxL0FSclFndmZqMnk1QTMxMW1CK2xEZEttQyt6U01vOFFnbkdCRDdVaXhp?=
 =?utf-8?B?Qi9VaVN3bktYVHRZQnJJeWNtbUZySDMxK3pBRTd3Wm1DUG5EYXVhM2E0L2Rn?=
 =?utf-8?B?dHpRRXQvVkxLUXIyTU1NS0lVZWF4N0JJZU1uWTEzck5iOGhvcVBBOVZwT0Vx?=
 =?utf-8?B?a3hKVlowTG03eVlTdVl3eENLbE1TZCtQT3JMTzNJbHNwcVg4SFA3ZVdmSWp3?=
 =?utf-8?B?L0VBa0x2UW9BTWVUZFYrUFBOZElvSEVkdGV1L1R5d0hZRGp0ZTJaVXh1a0pJ?=
 =?utf-8?B?cmhsNERXNC9IY2cyeG1tdVNRVkFKRzltMzJ1QmxHbG4xOTljZnNTK1dZZ21P?=
 =?utf-8?B?clpOa0RJdjFHbC9xL2w1amlyeVlSd2RoTEpUUFNNcFY0SUcwV0NVQUdkS3FS?=
 =?utf-8?B?SHhkNTZncFhVR2xWSFBrd2phdDNPdDQ5N0I4ak5Hbzkxa255dnVmUFcrZkhr?=
 =?utf-8?B?ZmtwZm1QMzEzTGVHZ2pLSzhjcy83WHpMZGpWbEZZYXR1VDJYZys1REk1bUth?=
 =?utf-8?B?eVZIMG43UTk2VGFVSWUvajhwSExXY2Iwd2JoeDdYTlVMaUJNUUlXbkNPZjln?=
 =?utf-8?B?OEdNUEhrczduRHlTbzdwdHBWam1wRlBqOFgyNTZBU2hOQTB1WnJDYWNmUmhE?=
 =?utf-8?B?cG9jbE5yRjZwNHVXdXgrTHVIQTNRY2FpUVdaNmd5VVJQSU5oRERlWG5nMVZk?=
 =?utf-8?B?NFNvQXkxK09BdHppclI3V3oyS1JYQ1cxU2dDMkNYOURjRENIVGdmQ1Fid3Fs?=
 =?utf-8?B?VTB1ellGK25yTGxwcDFsb0hqZzBXcnE0cFVQTDlSQStXaDhaVjAwa2VlY0pR?=
 =?utf-8?B?eEZoWWNRYmxwZEhhaXcxa3hNZ1FpbjlRVzNRQ0ZvYzViRldBRE5IdWQwSTNG?=
 =?utf-8?B?eFE4V3JUWm1TcVlsV0MrUjh5UGZ3VGxTZzY3amoxV2NQdjZoSHpPOTBFaWZk?=
 =?utf-8?B?UEQ2RjBYcExMTzRVUnFCbFBCM0o3Z0VlTGJxREc1U3o2TFUrYlFUQjR0bU1O?=
 =?utf-8?B?NU1yaGJQZjA2THJ2UEo3SUdGcjlNZEVtSThLckkxOXFSczVvc3I5TWdza3FT?=
 =?utf-8?B?NkVrT2RTdUFhWjRqbnJEeVNQaHE3eVJ1VTRHS09SK0RZeUxFOWlKU201R1Bu?=
 =?utf-8?B?NXBmWU9NOUp6MWVmdmhTazRnc09Ma0kwWE9NaHI2NmNEbXJYNXBSSkc2aTNn?=
 =?utf-8?B?Y2l2d1ArOVdlNjU3cytZS0s4R0U1cHI1OElOT3diMDhlT2dMZS90Tkx0L05t?=
 =?utf-8?B?NGpsMTREUEtEV3NzSG5jZ0F4dkQ5eThyTVk0d0VBK2pnNlY4SW9iREJYYS9I?=
 =?utf-8?B?czErNHVYVTFYblppeVdmR1ovdVV2eVRoNmJjZlZqZFMxV0x5MmhEdjJST09I?=
 =?utf-8?B?TUhiWjkrb2RkNXY3Rm0vc1JVZzVWdUJ1VzZVTHpneXdaMGhsdkIwQ01rZzJk?=
 =?utf-8?Q?v0LnajqPOVy+8rPuN+eJeOKcu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa658a4-52c5-416f-1a75-08dcbaabd0cb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 08:50:28.5926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2T0hUmiU2HxprAkb7ESfVNU9gHqspQ59tXcvRffHtm1Vk+a23B20XPG6PU8wRNeI4Ub5Gxdcw257aAiaVpCMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8774
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

On 8/8/2024 4:31 PM, Paolo Bonzini wrote:
> On 8/4/24 23:04, Manos Pitsidianakis wrote:

[snip]

> Also in bilge's meson.build:
> 
>> +arbitrary_int_dep = 
>> subproject('arbitrary-int').get_variable('arbitrary_int_dep')
>> +bilge_impl_dep = subproject('bilge-impl').get_variable('bilge_impl_dep')
>> +
>> +lib = static_library(
>> +  'bilge',
>> +  'src/lib.rs',
>> +  override_options : ['rust_std=2021', 'build.rust_std=2021'],
>> +  rust_abi : 'rust',
>> +  native : true,
>> +  dependencies: [
> 
> native should not be true here (but it should be true for the dependencies of 
> bilge-impl: either, itertools, proc-macro-error, proc-macro-error-attr, 
> proc-macro2, quote, syn, unicode-ident).
> 
> I've placed my updates at a branch "rust-for-manos" of 
> https://gitlab.com/bonzini/qemu/.  I left the fixes unsquashed for your review, 
> but feel free to merge them and post the result as part of v7.

I tested that branch by a cross-build to aarch64 on an x86_64 machine (with 
"./configure --cross-prefix=aarch64-linux-gnu- 
--rust-target-triple=aarch64-unknown-linux-gnu"). To configure successfully, I 
need to add "native: true" to every "dependency()" that refers to those 
dependencies. Also their "override_dependency" needs a "native: true" as well. 
Here are my detailed changes:

========
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build 
b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
index ef1af5683a..a5f04bfeca 100644
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
@@ -11,7 +11,7 @@ subproject('syn-2-rs', required: true)
  subproject('proc-macro2-1-rs', required: true)

  itertools_dep = dependency('itertools-0.11-rs-native', native: true)
-proc_macro_error_attr_dep = dependency('proc-macro-error-attr-1-rs')
+proc_macro_error_attr_dep = dependency('proc-macro-error-attr-1-rs-native', 
native: true)
  proc_macro_error_dep = dependency('proc-macro-error-1-rs-native', native: true)
  quote_dep = dependency('quote-1-rs-native', native: true)
  syn_dep = dependency('syn-2-rs-native', native: true)
diff --git a/subprojects/packagefiles/either-1-rs/meson.build 
b/subprojects/packagefiles/either-1-rs/meson.build
index 0101ffe446..8a92596cd0 100644
--- a/subprojects/packagefiles/either-1-rs/meson.build
+++ b/subprojects/packagefiles/either-1-rs/meson.build
@@ -21,4 +21,4 @@ either_dep = declare_dependency(
    link_with: _either_rs,
  )

-meson.override_dependency('either-1-rs-native', either_dep)
+meson.override_dependency('either-1-rs-native', either_dep, native: true)
diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build 
b/subprojects/packagefiles/itertools-0.11-rs/meson.build
index 903913eb1d..6c2d1387e0 100644
--- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
+++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
@@ -5,7 +5,7 @@ project('itertools-0.11-rs', 'rust',

  subproject('either-1-rs', required: true)

-either_dep = dependency('either-1-rs-native')
+either_dep = dependency('either-1-rs-native', native: true)

  _itertools_rs = static_library(
    'itertools',
@@ -27,4 +27,4 @@ itertools_dep = declare_dependency(
    link_with: _itertools_rs,
  )

-meson.override_dependency('itertools-0.11-rs-native', itertools_dep)
+meson.override_dependency('itertools-0.11-rs-native', itertools_dep, native: true)
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build 
b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
index f65e319ec7..673675930f 100644
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
@@ -8,10 +8,10 @@ subproject('quote-1-rs', required: true)
  subproject('syn-2-rs', required: true)
  subproject('proc-macro2-1-rs', required: true)

-proc_macro_error_attr_dep = dependency('proc-macro-error-attr-1-rs')
-proc_macro2_dep = dependency('proc-macro2-1-rs-native')
-quote_dep = dependency('quote-1-rs-native')
-syn_dep = dependency('syn-2-rs-native')
+proc_macro_error_attr_dep = dependency('proc-macro-error-attr-1-rs-native', 
native: true)
+proc_macro2_dep = dependency('proc-macro2-1-rs-native', native: true)
+quote_dep = dependency('quote-1-rs-native', native: true)
+syn_dep = dependency('syn-2-rs-native', native: true)

  _proc_macro_error_rs = static_library(
    'proc_macro_error',
@@ -37,4 +37,4 @@ proc_macro_error_dep = declare_dependency(
    link_with: _proc_macro_error_rs,
  )

-meson.override_dependency('proc-macro-error-1-rs-native', proc_macro_error_dep)
+meson.override_dependency('proc-macro-error-1-rs-native', proc_macro_error_dep, 
native: true)
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build 
b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
index 5c4e99f248..b6f25811eb 100644
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
@@ -6,8 +6,8 @@ project('proc-macro-error-attr-1-rs', 'rust',
  subproject('proc-macro2-1-rs', required: true)
  subproject('quote-1-rs', required: true)

-proc_macro2_dep = dependency('proc-macro2-1-rs-native')
-quote_dep = dependency('quote-1-rs-native')
+proc_macro2_dep = dependency('proc-macro2-1-rs-native', native: true)
+quote_dep = dependency('quote-1-rs-native', native: true)

  rust = import('rust')
  _proc_macro_error_attr_rs = rust.proc_macro(
@@ -29,4 +29,4 @@ proc_macro_error_attr_dep = declare_dependency(
    link_with: _proc_macro_error_attr_rs,
  )

-meson.override_dependency('proc-macro-error-attr-1-rs', proc_macro_error_attr_dep)
+meson.override_dependency('proc-macro-error-attr-1-rs-native', 
proc_macro_error_attr_dep, native: true)
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build 
b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index 06279a8a6c..a5f4c11f82 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -30,4 +30,4 @@ proc_macro2_dep = declare_dependency(
    link_with: _proc_macro2_rs,
  )

-meson.override_dependency('proc-macro2-1-rs-native', proc_macro2_dep)
+meson.override_dependency('proc-macro2-1-rs-native', proc_macro2_dep, native: true)
diff --git a/subprojects/packagefiles/quote-1-rs/meson.build 
b/subprojects/packagefiles/quote-1-rs/meson.build
index 4663295ccc..41feed9683 100644
--- a/subprojects/packagefiles/quote-1-rs/meson.build
+++ b/subprojects/packagefiles/quote-1-rs/meson.build
@@ -5,7 +5,7 @@ project('quote-1-rs', 'rust',

  subproject('proc-macro2-1-rs', required: true)

-proc_macro2_dep = dependency('proc-macro2-1-rs-native')
+proc_macro2_dep = dependency('proc-macro2-1-rs-native', native: true)

  _quote_rs = static_library(
    'quote',
@@ -26,4 +26,4 @@ quote_dep = declare_dependency(
    link_with: _quote_rs,
  )

-meson.override_dependency('quote-1-rs-native', quote_dep)
+meson.override_dependency('quote-1-rs-native', quote_dep, native: true)
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build 
b/subprojects/packagefiles/syn-2-rs/meson.build
index 21d817a33e..61cfc469c1 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -7,8 +7,8 @@ subproject('proc-macro2-1-rs', required: true)
  subproject('quote-1-rs', required: true)
  subproject('unicode-ident-1-rs', required: true)

-proc_macro2_dep = dependency('proc-macro2-1-rs-native')
-quote_dep = dependency('quote-1-rs-native')
+proc_macro2_dep = dependency('proc-macro2-1-rs-native', native: true)
+quote_dep = dependency('quote-1-rs-native', native: true)
  unicode_ident_dep = dependency('unicode-ident-1-rs-native', native: true)

  _syn_rs = static_library(
@@ -37,4 +37,4 @@ syn_dep = declare_dependency(
    link_with: _syn_rs,
  )

-meson.override_dependency('syn-2-rs-native', syn_dep)
+meson.override_dependency('syn-2-rs-native', syn_dep, native: true)
diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build 
b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
index 80d088282c..c398f59211 100644
--- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
+++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
@@ -19,4 +19,4 @@ unicode_ident_dep = declare_dependency(
    link_with: _unicode_ident_rs,
  )

-meson.override_dependency('unicode-ident-1-rs-native', unicode_ident_dep)
+meson.override_dependency('unicode-ident-1-rs-native', unicode_ident_dep, 
native: true)
========

Besides, I think we don't need the "-native" suffix in the dependency names 
since we already have that "native: true" argument. I also tested configuration 
and build after execute "find . -name 'meson.build' | xargs -n 1 sed -i 
's/-native//g'" under subprojects/packagefiles, and it worked as well.

With the changes above, I'm able to cross-build except for one known linking 
issue [1].

[1] https://github.com/llvm/llvm-project/pull/93890

Thanks
Junjie Mao

> 
> Paolo
> 
> 
> 

