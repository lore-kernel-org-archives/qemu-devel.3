Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D0AC55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrAYC-0003sf-Mp; Tue, 04 Aug 2026 04:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wrAY1-0003s7-3J
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 04:30:53 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wrAXx-00009j-EZ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 04:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785832249; x=1817368249;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PpDPCo2DA5P/+dEs5/7w/aa07kcBHLi2yMOr5ZFsFJ4=;
 b=Ra9JaS/itJ5DPlu6eMZiXo7+6iq4BKxgDRZO8K2qWYz7AnWrb0nH/2y3
 HEpSLY7jRXB3iBLdpct2RdsQ+sr4yuemPeJjXX55PU6B0Bcc0YO9DEgXK
 s7z1j+5QLm3+K+bhrWQ+sWYF7/WqRaYN/skx9SHubqEWsowPWL7sfSkqp
 jplxzLN7mFm5BQ1AYaUlbzqyyEUz7yI7WqBJAZ+72jUDzPckHOXeGRv9d
 N/lQ79k4te0AbGWRAbXl3LgyeqnpweF+6FhTvSgfq/JGBprdrZL8j3xiP
 wpG+Xma5mG2Y44z/PLxX01OYjWObvQeojB0z+2+R2zXQ7rY4JiCEF2Zx8 Q==;
X-CSE-ConnectionGUID: rbP5p+JTRTeyjS7M8/pnNg==
X-CSE-MsgGUID: sorLIUmdTTqKK7/kbwiq2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="85357107"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="85357107"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 01:30:43 -0700
X-CSE-ConnectionGUID: wSpQSWjXQVq+GwEeIRc27A==
X-CSE-MsgGUID: ELRKtbgZQE2WYvuzSVwyiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="265700877"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 01:30:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:30:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 01:30:42 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:30:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqpmB0dS+7DSh+p9WFjSxZxwsPKcI+VpwzKKuYmbyUiK2IlpfT0FBI2fcqFuD3LpVNH9e/TcQE9Zz2Vj8ZxlHy/MlXO+ELKxRMRK6DK7JBDQWjHN/Jh1Qs8PfJ694x66fiTbrKtxn0lHiaQjXaM7MJSx/QL8wBOiLsiqChMVC0lSBWfb5E381m5HX3/rReEYu7F7lujqJUVK4+cYeA1k6w845Me/EszwdW2MHVC2AB4ij8/HBhNlG0girttL6zkSLn6divjCb8V1u5xz6Fs2R8pC7VDBK83b+2LJ7JrJDjaLGBr1CNvakvyCaF18UN1Pq4klXs2HJb3D1NPJNJ0IRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++ZokV3ACMjam3A7xWNcq66PkWRRS3sBHTonA93lzaE=;
 b=Lv/Qw3lC5oXTFye/392lZTj29GRDsBBgvMNRAi6GXAaRO6NUFCS+XpqTX/PZqdJBY2tDy055Hfj0JT/CsOCyvRl1NzFfJDFZscnA8UJbPDUg3c/9099rFJ5yInEdukqnTEpmC6x1ODRiP0ZlgSTbbDs/txuax86hc1MhO3yFedo9fNUAoBXbirxMkEq6ZVl3BM/w2vN2DOccvMg8+ABX+by2igvZ1cnQa9GOZndwIHFJMe2wJa5ddth0KVAg5bU29bXf36wq43w/nCNF0HIqXcm/0YxmfoQJMDueCBWdk4Pknmd1t+hGGpVd1gorSe+ynjfkIfBde4IhtFwvmQMRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.15; Tue, 4 Aug 2026 08:30:35 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:30:34 +0000
Message-ID: <bd68b771-91a6-483d-8f5f-45b84cefd26c@intel.com>
Date: Tue, 4 Aug 2026 16:39:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
 <IA3PR11MB9136485848B1212FBC2A440392D52@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136485848B1212FBC2A440392D52@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: a530ed42-cdbc-45b2-7dc2-08def202a763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|42112799006|1800799024|376014|10067099003|18002099003|6133799003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 3Y0b48AZwVwBFaw/w/9bwps7YmSiLBdR3c28zyoNa3pkT/qBaDivO7lS+1ux4uQg3Eco88sbYMZbqhSIXVSNlvLJdwcmV+uqMk+ebzqHvXamIbXzHVeewrZRza10feHfodtmslrXSUV1dkCBrIJ7pJL+fk/VEsaIZLPwykUGtzr3DwDj9sdTy+icBDkzG0d13APXhfSqvXvzdR8nSc3gsocTj8/VGsBPJLYylRfSCUWCWMhj9b8w50x3qDh8inzDzGT7XVa7g6V51JVhCpxVi0hea7u10DaldR191lz3Y+WxlMQe7rTZ+bSZmUacqCR2zK2tTIDY8BwEfkjdSeh6IxvFUb5Fa2SifK3R6RXYEAObCrwT7w8X7ejb+i2CSmHRPFyvFvi3M8ET6hAbZaF/+hy/+3q10DEsXzprCt38jbD5xt5qzOBFPB8XNMMKryDoimTnDuIRUDQHSqm/ShlGl5LOnYe3UlIpCcA0Wc3VCzNkHvVxPFCO1P58MCIFOV4NT9Vse/N89h26csh7qJH1jhq6so6rWFqZgCNWyRWk6EoACXhS5VpoyuvoicNKWbmh7neRdaRvwrvM247EgiqMLPsfhoCLtgiOBZnfAzypv3WQ6b9Ed5R0gTpcdLzPGhVMWrLGKO1mt26NPW6UB2K62bDaLKkipI0BuagMiI+EzWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(42112799006)(1800799024)(376014)(10067099003)(18002099003)(6133799003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um9uaU9zNm5wMUx2Wnc3eWdNSWg2dWVTaUo2U0N2eXFncTZPQWJNMmkzWk1l?=
 =?utf-8?B?QXJJNTlqb2ViVFIzcWUxN3VTNjE1ZkNyZ3VpdG1yZndqT21iK2NTOUdQNFdt?=
 =?utf-8?B?aFhzbFBSQXJEeVNDUnlkbWNjcUsrc3hKTUZKQWRucURSOWJNOGppUnFZWThz?=
 =?utf-8?B?RTdpYTdHWWU5L1E4ZVBzVFZqdzljOWNHcFpKdWk2QlBGdGhOd3krRysrb1ll?=
 =?utf-8?B?UFVKV1NaUGhvWU5BeUNwUlNJZDZMdWJaeTdWbmNzUXM5Ymdsa0c4TUtBeWZR?=
 =?utf-8?B?RlNDV1pIaFlXT3g1N0FaYzZJME41eGhWcW52cy9sQW5qU1QvTDBRTWtVZ0lD?=
 =?utf-8?B?NDFhOC9IYjBXYkR3bUUvaEUvZE5YRGdBVjEyMkMzYnBybTE5T1AxYktCTHBM?=
 =?utf-8?B?Mmo5aHFLQWtxcWRyaTdhckhPLzF4eHdicFZWMWdQU0plS0dwNUkwT0taZ0oy?=
 =?utf-8?B?ZFpvb2RjT2lnWis1VDVLQjl2YVhNMDhXdEhyZnc3MG5pbmRydk5vb3lSMnhn?=
 =?utf-8?B?RUFLSjRaOUs2VWhkSGI0K0ZjOGhralhqNUlHWXpwazNwYjVET202NFczNGFW?=
 =?utf-8?B?cER6ZlJXRXFvNFNGN2RIM1dhOFZic2Q1eVRONFBzbXpDM0gwdWJWaDdHL21M?=
 =?utf-8?B?QVMxd0pjemMwUE5mbXRIVVBGckNrVVE5ZzVESTJkTi92K1VDVzFJNGtZdW1T?=
 =?utf-8?B?WkVqZFJtdytHNU9VVUZGOXkwckJDS3p4bUd3NEhQOTM3Vk5tOWZHbm0vbFIz?=
 =?utf-8?B?emFGU1EweUp3TGQ5YjgybXl3SVdpeXFwNFFiVTIvbmtDblNTMkoyejM1YVBC?=
 =?utf-8?B?bjN0VGlrSHNhMFRSdStPbEhEcjAyVHZrTC9KZzVvMFlBelNRQjZ5V0VpdFhn?=
 =?utf-8?B?MkhnT1ZXUkNQeTlvdm5DZE9oQzdySnlQTS9JNC8xUEpJWUJvc1NDeERPMUtS?=
 =?utf-8?B?M1EzSVd2OHpqWDd4OTh5TU9CMlFrZ1ExakVyMGdrMGd6ekw5RUZTb3c2Wk1y?=
 =?utf-8?B?bktHSjVkWGluVTY2WUdGa0dFaDJWUEZPbndqaHk2RjNEcnJGTllxakJUTHVQ?=
 =?utf-8?B?KzN4Qm1wWWphR2ZaaFJCNmZvRjJLWW5IWmh0Q3JKbTFzWnJQaWxNaTRtZnRG?=
 =?utf-8?B?QW13QTV4dW9ZaFlTdStLeDhQNTQwaW5FNFNCSHlNdnRXNjlrMlYrdFFHUTdm?=
 =?utf-8?B?MTVRK3dBdExzeW1ld3duc2tiSkhWSVNQSlBUcDlzZzhlYnlLZE1LN1JsTERv?=
 =?utf-8?B?QmY3SlRqdjl3bE1aZUl0dy8rVVJ2WXg0ZlB3TG16RTM2bUc4YmNnVGNENXZ6?=
 =?utf-8?B?U1pQYVhIWUx4YjJmZFllckd6V3piQU9pUTZlUFFYNG9od1d2cTk4TXNPaFU1?=
 =?utf-8?B?ZzFla0JLT1dZeERSbUZSQkpBeFI2UkhpTXNRb2FBUDNBUzNnYW1yUnIvZ21U?=
 =?utf-8?B?dVVhNWtCemNqMkpQRkxIb09kNUlOaEJJTXFLVVNKdTJvdi9xMnJZWU1lNzlR?=
 =?utf-8?B?ZGhTTXdiUWw4clg1a29tbnJNL0ordVJoQUpPSU8vVExGc0dwQzlaWm8xcHNF?=
 =?utf-8?B?dnVMMzhuMDZ1MG9SbnlxaVNYMTRBQWJXYXp5ZVB4QnhKSXRYRzhqSE4rUU1l?=
 =?utf-8?B?SFl2V2U5NXZLNVg4Um9EZVdlalVEbERPM1BqcS9OZGd5SkRXdlVDM1dVK1E1?=
 =?utf-8?B?OGZZRjV2Q2VydmxhVmYrQlJjdEIwS2duQU1oSjRHMnVFcHlXOS9uVE1aTWw2?=
 =?utf-8?B?K2dLdmMrdm9JeEo2TTJvdHNJMzdjMnlpOGFkQ3lUeTZsMFhocUJLbXA3bmRz?=
 =?utf-8?B?dEYwbWF6bDN1WWlrQXZ0ek5ZelYzSC9NOVRjaDViZzhod0ExM01PbFgwbVNv?=
 =?utf-8?B?d0twZjllaUVLWkhZa0lTUjBNc1NUSUdQcGZYbUVUelRCSlZxN0t3NzJNckl2?=
 =?utf-8?B?WXE1bXVUNkY4UW9LSXJOWXJhSW0wdXJTY3lSUDZUeGFMVit0WU00cmtRSHVU?=
 =?utf-8?B?ZzZyOFQvRkw1U0ZnM25xKzV3WFg5UHBNcTJhNjRRRjVLTDBEeXFOM2trVFVC?=
 =?utf-8?B?SU84VnRqeDBoanBGa0hZYUNDaVNmZmZhaVFIeXBKSkVNODJyY2F0dHZxZ1Ew?=
 =?utf-8?B?ZjRVdWYxTzZIL2JhcW9KM2MvVzN3eHZnRGJwWTVkY01wUXZQUnFkN3dCOS82?=
 =?utf-8?B?VXVUZUtONjRGOTFMalozWGw0TjF6SFltK1Jxb1ljTmVhRjN1U1IzMDczWXc5?=
 =?utf-8?B?UHIyV00zQU5HN2JBNEhjWWtjL0hGR2txTEZjb291VnRpa3pRUXUycGg2Wm9E?=
 =?utf-8?B?YjFGaitYOEU0RFYwWEdXM1Ixam40Z0k1ZlVYMHllVm5uNzRCZkYydz09?=
X-Exchange-RoutingPolicyChecked: HWHEjr8IHa9vS4z1bc5+Cwy5dLKh4DLt9xoGKiKsnlc5uYvFx8AnmGJZaBxufE+7e34AqVVp6x02A4WzgIf7nc/STaXcol2r7+QFEmrKP7A1W5xjGKymCyjwGP0RppPGen4/9ZDlhrApY+Am28n43mvzJ7cMpvHB90W9xIaDOaP1UZjddCAla/Y/juxw0O7JBq6DzvEvZha3sUxS7BHqFSitLKuTUeY3TOmu4X9/fvZ4byGTEh/L19A0INcq4n19uOmeZGVXkqndYMrSVgSttd0VNRGLjz8g1lGP+zlvi2jDx4tcmFbR0o+w+6JlIP+flxiOVwp7W64gsB+KooYCnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a530ed42-cdbc-45b2-7dc2-08def202a763
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 08:30:34.8503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqH8clblDl/0BzdvRioq6rOzxzJQrmPoNAUCA3qRWQ5ISk96RG/jqxO5FTiFK/oRuxCBccHeeDsLo4hhjhk7og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
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

On 8/3/26 15:26, Duan, Zhenzhong wrote:
> Hi Clement,
> 
>> -----Original Message-----
>> From: Clément MATHIEU--DRIF <clement.mathieu--drif@bull.com>
>> Subject: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
>>
>> SVM in Linux requires SMPWC as of 780dfed68862. This is free in the
>> current implementation as it is already in line with the expected
>> behaviour.
> 
> Not an issue in this patch, what about 'C: Page-walk Coherency' ecap bit,
> I think we can enable it too? Maybe in another patch?
> 
>>
>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
>> ---
>> hw/i386/intel_iommu.c          | 3 ++-
>> hw/i386/intel_iommu_internal.h | 1 +
>> 2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 8245452d89..9f21622a4f 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -5108,7 +5108,8 @@ static void vtd_init(IntelIOMMUState *s)
>>      }
>>
>>      if (s->svm) {
>> -        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
>> +        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS |
>> +                   VTD_ECAP_SMPWCS;
> 
> I think we need a check for passthrough device to expose SMPWCS, something like below pseudo code:

thumb up. yes.  It's strange guest reports SMPWCS while host does not.

> @@ -37,6 +37,12 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>           return false;
>       }
> 
> +    if (VTD_ECAP_GET_SMPWCS(s->ecap) && !VTD_ECAP_GET_SMPWCS(vtd->cap_reg)) {
> +        error_setg(errp,
> +                   " Scalable-Mode Page-walk Coherency is unsupported by host IOMMU");
> +        return false;
> +    }
> +
>       if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
>           error_setg(errp,
>                      "First stage 1GB large page is unsupported by host IOMMU");
> 
>>      }
>>
>>      vtd_reset_caches(s);
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>> index 924e91cb8a..df7a0efa6e 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -202,6 +202,7 @@
>> #define VTD_ECAP_SMTS               (1ULL << 43)
>> #define VTD_ECAP_SSTS               (1ULL << 46)
>> #define VTD_ECAP_FSTS               (1ULL << 47)
>> +#define VTD_ECAP_SMPWCS             (1ULL << 48)
>>
>> /* CAP_REG */
>> /* (offset >> 4) << 24 */
>> --
>> 2.54.0


