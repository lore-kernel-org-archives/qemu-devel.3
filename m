Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A995CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAp9E-0008Cg-37; Mon, 20 Oct 2025 08:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp9A-0008CK-2S
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:37:57 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp95-0000gm-VC
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760963872; x=1792499872;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WUu9NgVbire/v85yt7LjHx6hTReOaIFRTXB5t2IIWDU=;
 b=iiBQuwxE5RNgvnfF4hF/4/HNDU236mZOPBDinnru5sFptDU5mpSwb8zC
 ek45hf5Cli2AJRGX7lZqkXMAP78FTjseRhb5jaUoG5y2F++H9Y6puly/L
 BcaZ7TdaO85ugX3UsXeK8OagBLdvmmDeYDJe9QFZLH5dHEuGaA7csxFbq
 FFiSKTKSY7mQVsEI98z4rQhcU/ESjAs6Pn1eozl1dOOpBYGci6sHy0PNL
 Gq2Q/Sd3e+LWdRCPYV192fhH4iJHWqjHQWGYa6hEflOQmPvsPepoO04X4
 CT8fijfoGpLEr+wal+Har53ym3kSN5Ys0IQ0BaLb4VkS9/h64XqE3VuEM w==;
X-CSE-ConnectionGUID: PgNHSEnaRbGpfOZhzDVyOg==
X-CSE-MsgGUID: uynFhHbARjO6CJZSZboG0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63118198"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="63118198"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:37:49 -0700
X-CSE-ConnectionGUID: Its6i0jjQLmSgZcg+eVA1Q==
X-CSE-MsgGUID: PdAMUX5BReW/3LrUoAQohA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183265043"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:37:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:37:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:37:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:37:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz3XrARiHJwb8PDcsvFOzioCaEWouHsfb/2ZaDemu9142shlCpozcGxLGpeHh9VjPkVmIrgG80JCFBXqcC9WQFLftXosIgkeACNXF0dCm1ydx4k202AhxXqGXcHfOWt7IYiZdfqLCTV3rHvCUbKcTwoIgDzZfwIrKeVA+FMhmLhzbBWH31Xbtif/r91MAW16UgA5rAuP0lzXQjAWHRG+LZJu5rAc0xt4M9jFrCdk5rvTgL/PRyLmovhwMhanUxM7lTwuxMvATovL7m5/I5OLOyFknJl3pBzefa/jdRDIcHPM0USvXzFBVNIqPuh7NTa0386fBrj/EuYB+j9ET6cidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLeAP4NdsXtJ8XvWXWm8vEZ3UM9Fc1Pv2t7QWaVSlwQ=;
 b=sc9h4ptGsmJIIczFJgTQ6dfYZsbwaTNSo/CZOIJ4YB3vFOO314jeTIyj3V7iEcIzBJb3S+4dzcDZWrVe4U6ruuYzIHnFaIbvIr9y4ndRxzxC1kx2OmM30VxxLAEJNtpWeq2PvssLdrFqbnerlNY6G+pY+F8AC3wV4GzxHBQplmNqFlMArtt+OMjxTWrQZgRncapH7AxgRZ1ftmNsD3uzgYbywkQMqhPNjCGxrSRRkc50SL4j9ON885WB5j/aTd7ABWbv2+DS70rfVH4tSBELdZOb7jU4qXbTXSWg1lceo0vqFs7Wov26rW1tmV3qIOVIdl7P4tirGmF3L12Et1digw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by IA4PR11MB9059.namprd11.prod.outlook.com (2603:10b6:208:560::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:37:46 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:37:46 +0000
Message-ID: <49ac485e-4704-40a9-a574-9bcfdc1f33fd@intel.com>
Date: Mon, 20 Oct 2025 20:44:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <mark.gross@intel.com>, 
 <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251017082234.517827-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::36) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|IA4PR11MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a1d73a-9013-4992-32e9-08de0fd57868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzJ2SXZndUVXRHBLTGkvNWNIT0Jldzlid2RPamlxKzUyeVFWNHhQYzJ5TTkz?=
 =?utf-8?B?QThOcEdSNHEyVExIdzBNL3pFWi9ka2U4S21rTUhRa3plM3Myd1JkM3pLb2Jr?=
 =?utf-8?B?NUhRUnV3RkN5YWNhSjhjMDlLR2ExR2VCMTZpb1RBTURocGwxUkNudng1cDl6?=
 =?utf-8?B?bVRVZWcrblBVa1hjOVkrenVBTHBDWDhxc3dMUG14RGJiaVFtd0pRT0JiT1pq?=
 =?utf-8?B?RDl1YWFKN2hvN3kra1Y3eHdVcll2K3lBOWo3bHBPSUJQVTkwM1ZUdHI1Mmtn?=
 =?utf-8?B?Q1BwSGlGOWVvUUVuRlJTWmZ5QWRUOXFTakEzZS9KM3kwQ3lCSDhrbjBFQVkx?=
 =?utf-8?B?emVGajIrbEo2dTh6YUxvU1JhS0JLaW5ob3AvRnNlZjJZdTE1NmxKYkVPUU9l?=
 =?utf-8?B?alBDVWNkWWRReDNReGphL016d0FoeEpvVGtnVzFuVlRDRmsrQzdkNVAvWXB6?=
 =?utf-8?B?RjlCZTBSby9zeWtxanJ1eFl6dC9FMUFvR09xeUVCYTFwRktPOUdhcmtabkdK?=
 =?utf-8?B?Rm1iYWwxUC9BNEdhcWRySXdlR3BnM1c2L0Z3OVBBaUt4dGtiSjlXQkZnd29a?=
 =?utf-8?B?WHlUT3NRR2ZNUUs5QUhlcUFiaU14R2FnT09DQ0JtaUJJZ2ZxM3JhSER5TmJD?=
 =?utf-8?B?Q0owbTg3QnJldHhTbWpDcGpCYXlnUGErVWtWYWdGb3dTenE3NGZpbWJudVVO?=
 =?utf-8?B?bVFybVdwNVUvYjlHMFhaUUhPazhhd1V2VCtXZzNYV2FTRTJNSlBnTTM5L2d0?=
 =?utf-8?B?UTBMZVAwRHV0NmlmVWFuekZUaU5mcjN4Mks2ZGlPTGJTR1pka1dVa2lRK05M?=
 =?utf-8?B?NTNaT0t2T1lYVXBPYUltbVp4NXZFUHcyQk55b2RIL1FPTGNNM2tjR2Nja1Rl?=
 =?utf-8?B?eldsR1Y3NVN3WmdJN3U1MmhVeHZueTlCZ2lvOERRWHBkckk5bW4zU2lvNGVU?=
 =?utf-8?B?MGMwNFNOcDhURGJ0TC83WU10d2VZL1RHaUM4ZU5FdktHNEJqcnl4Y1BSME5w?=
 =?utf-8?B?b3pEeXJxb2FpVUhXeHczcC92ZklFek9TTktyS2FKS1FvbWhiZVdRQnp4clU1?=
 =?utf-8?B?dnFJd2M3aTNLRXFnd0J3b3pyWko1NXFhOFlzcnY4UXoyUkFXTE1GZnBTTGsr?=
 =?utf-8?B?c1pyM3htSExTcFk4Tm1vcHJsMnFQdkZ0TFdON1EvekdoeThWWWhzMS9kNnFx?=
 =?utf-8?B?V1RYN1UwSmJ5Z3Zrb3k0WHBjSDRlNkVqZkpVejd6azU2MFBWSzQveVloeG5E?=
 =?utf-8?B?bk9MdC9mT0IzRGxMWTh1TDRXOFI1aGY4aG13MkxVaHZ5c0o4Mkt2UGp3Q1Bz?=
 =?utf-8?B?K2h4YXdYZFhWYkd4YlNvT05UQkFML0JUR0NjT3d4S09DdFFaMGhsTTBWaDFl?=
 =?utf-8?B?YTZJbTdiMlQ4TUVPQVVwdFRJT2xodlhNZkJscW9EandvKy84ejdFZjRtWHBw?=
 =?utf-8?B?Y1I5dXArWmFJeXh5U24ybC9iUFdhTUFMT3BXQUowK25PNnVsMXd0bTc0aHpj?=
 =?utf-8?B?V1Zsc3BPeFF0MmFQRkVTUklkUnN2Nk8vcXJRdXE4djBvUlE3Q3NwbXFiS1Y0?=
 =?utf-8?B?amtBTUNmSndyNTJ4SkFqZG9hbzc1Q2FvRXJETFFhNjlEUXVheHhqMzZNQmY5?=
 =?utf-8?B?aWZnZ0VYL21xTW91SVFIVGs4dXFZbE5TQW5pUnc3TFY2Q3VGaENTUnlDdHI0?=
 =?utf-8?B?aENNTmVwYlZ1T3hWRkhHWWE3VHpUMVBJUjZaT2xEekxnRHNJSENuWW0zRWxx?=
 =?utf-8?B?eFVTNFR1R3FCU0JwY2pNL3M0ajFNWHliT1hkdlJTYWk3RklSeU9icE1KV2pF?=
 =?utf-8?B?Yk5SbDZGS0l1QmwyZDBlZUIwOHAyaFVCZE11VW9ncUUwSlN0am8rNTZQN2t3?=
 =?utf-8?B?ZXFHN04zNVVjUk9rYVZCNjRpbWFqZVY1T2hXdlU5aGVkb0I1WURlRzRJeDVC?=
 =?utf-8?Q?YyUxtg3f07h6wKzwEeDRaHlnA0dUcKZK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGUrMVRkUUxYZnhKbWt1d1pzVDZFR3lRSGw5UmdIZW9LYlBZdnNoK0QwOUpm?=
 =?utf-8?B?T2lVWW5kZlFkeHRMQ2hFcS82TU9pTmQySktrNGRFOTNXVFJPUVZabDF4RzVI?=
 =?utf-8?B?SFVVRWltRm95cGN0NlpRdkdPOUtHVzkvdW5rc052Q1krS2lIMUovM2xVMkVW?=
 =?utf-8?B?eWZxbks0THNmRSs2SXBOTFRNOEVPVkd3TGRBWTdYVUE2RWx0dnBHK2ZpcHhu?=
 =?utf-8?B?SFRobW1jSFNSbS9sQm1yQWhzS0x2SW1hK3RxYTlKSkJXTUNtbDBNYm1Jd2ZS?=
 =?utf-8?B?UVM4cCtJbERzekNVd1BtOE9YcEdna1BvL1NpbFlJa1NncWJ2SjZET2Q5M2xI?=
 =?utf-8?B?TkJjWWNxSWZzdlhSSUxnZkdrR1lUbkxHTkkxSEd3UkZmbGxIZlBwYWRPblFl?=
 =?utf-8?B?ZmNyQU81QnUwaHd0OXZ0b21JSFR0N0ZqL3RkMGU5aGdIRUcwd1o1MnQwc0Y4?=
 =?utf-8?B?RWNhem9RMEpFSk45S0dka3hnRnZaQVhXNjhVVFhZazQxR1N1a1ZqbXBFdkZ3?=
 =?utf-8?B?K1JTVkYxM1ByNGFBOEV6c3JGWGg4NkRHamkwTlQyRjRlZlZBaGJVMjdUM1dp?=
 =?utf-8?B?NEdxSWxIbHE4b1BqN2xXOG1TUko3aVFDQURxV05ENml4M2NnUTVMNjJCVnZ1?=
 =?utf-8?B?TWFsZERjMkV1aWgwZ01USEREQmRJQlorcVNtYUE5VlhPQ0QxUGdJbmhuY2NO?=
 =?utf-8?B?T3RhcTFrbzM3OFlITDBIdlY0K1YxaFErY3JnRHMycDdLcldIckw0VG10cjY2?=
 =?utf-8?B?SVA4TDdSMENJQlFub1VsZ2RpMDNkLzlxYzgrb1Y3dkFwc09Vd1hQSlkvc0JO?=
 =?utf-8?B?dTFlUGtkM29aaTI4THZTOWNyMzQvUW9aL3VBZTVwOGlLek0yN29jdXVJV2hQ?=
 =?utf-8?B?dlNSS0FTeG01M3ZYeXBMR3ZZVi9iTUxjRGRvY2hSTHFVSXQrbVhZdCtNQ05P?=
 =?utf-8?B?Y1JVT2tZWjJVckcwSlZsYXdDL3FESmJUUUtPdWVlVkFjOVpQUm5MTDZTd2tx?=
 =?utf-8?B?QjMzaTRrclIvZjhHRkhGc0ZmempRZzZHZ1Y3b054bDc3SUIyemV1QlRuYjBz?=
 =?utf-8?B?NTBVTS9CVEs1WW1EZGJwSGtIV2FuTHR2QkdtNEsyWmxoWVVMZ3FWZ3R6UHIx?=
 =?utf-8?B?MENLanVmZnhtbVZ3SUx4NklKZkdTbENWaW42cjdnd2ZKUWY2bjhjZHNEQjJU?=
 =?utf-8?B?T1VRcjU5YVBZR3JmYWpkVU5ERnB6elpmMWd4ekg2aE5JMFdTc1dZRVlvYXYy?=
 =?utf-8?B?OXMyUU8wWDFMWTdGbW5HcTViMi85L1Q0d05ZWnFqOWFBZjVzYS9MNDdmNTQ0?=
 =?utf-8?B?K0x5clRFellrbzMvZDV6OGlyNXdnR3hwS05kZkF6aWJmamxiTTYyRHZaR0Rr?=
 =?utf-8?B?UkQzQUd1YjFpN0JTdndJbWV2TVdWUHNZQ2s5VytnVkE1R3RYcDRWUFpHNHdG?=
 =?utf-8?B?TTBmcjdFZXRsUHpYZGpFUTUrbG5SekprQVZGRDdyVGRDSVo3N1dGWmY1ODgx?=
 =?utf-8?B?VzVpa0RyZUdvdU91VmFBdVp5TXp2VzRMeExycHR1L0ZUekVTZGxLU2d4SG0z?=
 =?utf-8?B?SGtSY0pwN3V3UEpJTGtzTEhvTW1XWmQwZE84R0NVbG9DemxzTzhPU1J2bXdL?=
 =?utf-8?B?cWMwVW5LWE4xb1NzOUQ3R3BzdXB0WnNpU051eWxGMXlHb0xGWThMK2J1ZGt2?=
 =?utf-8?B?RTc1bXJCZm44a3ZKTGphS1VhS3liU2ZWVWNDUzBTaTVBd09rNHNlNUZnUGMw?=
 =?utf-8?B?bmtmeTlMbDZnQnZoTGxPS1pGYlVhZFZQWXdDUEZXUVIzTlVBT0RMQi9LNXpo?=
 =?utf-8?B?bTFSS0dQeFdrdk9aT2xhYTNzcDRreG9DWFAxM1Fwdm1kSFVpbFRNV0dGTG9R?=
 =?utf-8?B?ZnVvQ0swemFlYjZqQzdpc0JOSHAvbFllZmt2ZFZWY1p0OGt5VCtreU40Wkl4?=
 =?utf-8?B?bFc0bHBycUtXQ3pRT2hGZzBobk41MU90cGNTTDhxL2FVakRpUUtoT0lLOUIz?=
 =?utf-8?B?N0ppb0tTbDAwcDhYNlBWYUVrMXJ2V0IyeTd6K2wycDFDcGpJZTFSZDRyclNH?=
 =?utf-8?B?WTgrVGVnWXVMcm82TFJUTDVycXJodEQ2bjNBTEMzS0lOQ3RjWmVUNTRHTFo5?=
 =?utf-8?Q?Eg/RShUTA+Ogm/PHCSCs9i4mr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a1d73a-9013-4992-32e9-08de0fd57868
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:37:45.9956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0L54dshGyS8PoAtW1U3RSV1PvzUfa8qx7NBI+XutBwCCc48zJS9PO648QHDo+fuxomLu9b7gGboGOSaAo+lKZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9059
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2025/10/17 16:22, Zhenzhong Duan wrote:
> With default config, kernel VFIO type1 driver limits dirty bitmap to 256MB
> for unmap_bitmap ioctl so the maximum guest memory region is no more than
> 8TB size for the ioctl to succeed.
> 
> Be conservative here to limit total guest memory to 8TB or else add a
> migration blocker. IOMMUFD backend doesn't have such limit, one can use
> IOMMUFD backed device if there is a need to migration such large VM.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/migration.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 4c06e3db93..1106ca7857 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -16,6 +16,7 @@
>   #include <sys/ioctl.h>
>   
>   #include "system/runstate.h"
> +#include "hw/boards.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-migration.h"
>   #include "migration/misc.h"
> @@ -1152,6 +1153,35 @@ static bool vfio_viommu_preset(VFIODevice *vbasedev)
>       return vbasedev->bcontainer->space->as != &address_space_memory;
>   }
>   
> +static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
> +{
> +    VFIOContainer *bcontainer = vbasedev->bcontainer;
> +    uint64_t max_size, page_size;
> +
> +    if (!object_dynamic_cast(OBJECT(bcontainer), TYPE_VFIO_IOMMU_LEGACY)) {
> +        return false;
> +    }
> +
> +    if (!bcontainer->dirty_pages_supported) {
> +        return true;
> +    }
> +    /*
> +     * VFIO type1 driver has a limitation of bitmap size on unmap_bitmap
> +     * ioctl(), calculate the limit and compare with guest memory size to
> +     * catch dirty tracking failure early.
> +     *
> +     * This limit is 8TB with default kernel and QEMU config, we are a bit
> +     * conservative here as VM memory layout may be nonconsecutive or VM
> +     * can run with vIOMMU enabled so the limitation could be relaxed. One
> +     * can also switch to use IOMMUFD backend if there is a need to migrate
> +     * large VM.
> +     */
> +    page_size = 1 << ctz64(bcontainer->dirty_pgsizes);

Should use qemu_real_host_page_size() here?

> +    max_size = bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE * page_size;
> +
> +    return current_machine->ram_size > max_size;
> +}
> +
>   /*
>    * Return true when either migration initialized or blocker registered.
>    * Currently only return false when adding blocker fails which will
> @@ -1208,6 +1238,13 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           goto add_blocker;
>       }
>   
> +    if (vfio_dirty_tracking_exceed_limit(vbasedev)) {
> +        error_setg(&err, "%s: Migration is currently not supported with "
> +                   "large memory VM due to dirty tracking limitation in "
> +                   "VFIO type1 driver", vbasedev->name);
> +        goto add_blocker;
> +    }
> +
>       trace_vfio_migration_realize(vbasedev->name);
>       return true;
>   

