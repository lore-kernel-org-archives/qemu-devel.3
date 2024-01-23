Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F5FC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 23:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSQPT-0007II-QK; Tue, 23 Jan 2024 18:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1rSQPQ-0007Fp-MK
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:42:24 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1rSQPO-0004DQ-KT
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706053342; x=1737589342;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=CETdNG1LGRSHEenhd5vNeQmOTG/zJSozRZyq4pZLnxg=;
 b=M4p6y7oKzp6/Lz6i+B2J27sExDeh3XLidVmGRfR1PrKPiJFCYX9WG7WZ
 Pulln3pF8IZd3FleT7YTrKReKgvEl/4DUbGQG6q+IDIzatjqYO2qkQCsc
 PuPt1r0tMDgjpl8Y4i7xEpdwf4/itYTlx3ntU28ff9By8LDxNaT1BpEFV
 lTL+YlImLsc4wm6Dmir2L8hi4/Thiy3ODamrjUePs+4gsiItSi4qsqwiQ
 F+u0ep77UNBKvcDS+9KmoReDc6KWKIrvN2LcCa4GPohfuc5D4xR4t5nGH
 77UuhzilaXaTKuQQosFgZwuCfXOXAHTi3hkI/ciBWIOpt4jQ2J5YdB/c3 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1574197"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1574197"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 15:42:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; d="scan'208";a="34583645"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2024 15:42:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 15:42:16 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 15:42:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 15:42:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 15:42:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUbivmiShYXwnKjp2oBlacJkdEXVfYlo9E88h/jj0/uemMuV0iRncm4bylNy6ba1HHPgxlg6QwgsZXdRSNpTAwBkPYHOrTvg4jfYxOr2zu55wqeXhQo49p1sA+RJVrRdj3Z43dOTBrdbhMb1jwlmbCX1bh/YGp3vR6qm3ExPKcqhFaJUQ6+KJcV7AwW5s+mvdVQTfceUlzN1d+1sStq808YUtZXGT4ExpgFkonm0VDGeaVdovqq2Kmf0dK5USP5jDH4pjm4xFTdZrdGmDWq/B8EnwNpmSpVI24ShnFG5N5vD4LDKM7n/624XkSmanPOjdK/xcaF5PPJ1FR1qtnr7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cWXMxQfCBmrOIi3pEjmrIx5WKAyZjt3tt6UWdc+Pos=;
 b=d4p0XEwF6HoGnn7oPneWSGdEd6poFXQFTjT3VgkA8FciUqNXacu8y6e2NUOMPW1wZeMzeocmGqbdq2fY525TZ1WkFEs7Fh1ueOfXyENsC+6nv13C8EK3cW0gQklvGN+TOX2V2r8TADPpLmSinxbXhYPBfzfL7rHX6474mJ1qWj7aNIN8WQgMwsoy0RXtkPCvMpdjqpBQMbWBjGC0T07JW3dM3ULDJKftdXTLinejuIvBdycaN3ATX594HzdigbswJ/b+gFXtTsk5SC+7pjKGXCnH0nKhHN+fOj73iASoy8YAJ2RQb7nBFHsVVBdE2BR/FPR1kSvYNlJoT7nBdov0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO6PR11MB5570.namprd11.prod.outlook.com (2603:10b6:303:138::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 23:42:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 23:42:13 +0000
Date: Tue, 23 Jan 2024 15:42:09 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>
CC: Ira Weiny <ira.weiny@intel.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Kevin Wolf" <kwolf@redhat.com>
Subject: Re: [PATCH] bswap.h: Fix const_le64() macro
Message-ID: <65b04ed1a21de_202aa2294a6@iweiny-mobl.notmuch>
References: <20240122173735.472951-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122173735.472951-1-peter.maydell@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO6PR11MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 758638e4-6009-40a6-6d7e-08dc1c6cecc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwSj+M1soYHTOo3UPBq75oZJnZ+cCFU2zkfkSIc7o/NsjLZ4sLH0yCrJvWooi2xhEkWTSBkvWwor2a928znGsoMKdT0xIywLBY6dy7trOgTEmmjng9rKAoO7vzlgulcPHjarzjl1HsDQ/c+3IzMe+JlG6V0xCWW1QnEEoL+t0itNC6sUpgPgDKCk7bCWb+5ApQN1csTn+AHsUDp1m6vKO2Z5xU5eUP7FEACBvv3uCXgfdJnsmDaxQyEfBALjU9u2TZKmAIlnRyLQtTpcAvmqlgMb+EgzsjOto0JO+ioFLi8q6IVtBghBd61Dm5FYYSLipe3wEZTn9jQ8qjp2Cvua4HQcxXA8qsfLQj+1dCXVT8H329bVitpRXICCYG5VsRVQDyXt8hRJ/6TXAzW1ieWFnnlAapmoMwnHTlYWGNIk4XX21UgV0jHEdJfb0vuFBFWqkHkmX2/ww8oyZD0oxV5IQQwKlOLJhwV1zbaMIzmjJGvBJQ50vdZNvXeEnZhI6zSy0S2QaDxZ3C9Q7G2LnFR++w5qGVN5frryrrPD2f2hpdJ3u+b6Y4t9pa0Hf6gtpZj2Q/6QDN4Y8Bx1LIQMV/rUZb14qo4Sf0vUYz6QocuCDobqsazOl61ak6kZ+JksScL7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6733.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(1800799012)(451199024)(2906002)(5660300002)(44832011)(316002)(66476007)(66556008)(54906003)(66946007)(8676002)(4326008)(8936002)(6486002)(6666004)(478600001)(86362001)(38100700002)(82960400001)(6512007)(9686003)(26005)(83380400001)(41300700001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUtxYU1uZ2VRUFFvYXNLQ0l1aWptWFVNNkFMOFhtWE9sNytjWENwWHBpdEhW?=
 =?utf-8?B?L0E0S2JLY3JIUzBHQzQwU0xyVUJYZzdpZUtUbC82bFczVHFXWk5ySjBjQS9N?=
 =?utf-8?B?VWFQRXpBWk1TdjRjcGFyOVFOYUJFZjd3dUlyZDIyazBNVFh2ZG91K3BjeUJj?=
 =?utf-8?B?TTRraVlUZ2djRHRSMGdnRm1DcVJZN1hwYkRnVFdDYjZXUUxiaFg5T2JLTk9D?=
 =?utf-8?B?RzlGd1BDWmYrbVoxTnBiVTU0VEpkUGk4L0RtUTNjYjQvcEZTa2xXcENkYkZq?=
 =?utf-8?B?eUV0WnBQSXo2bVVIYllYRHFON0E1WHdkVXQxT0xVemN4VlBnY0w3SWJ5cjZ4?=
 =?utf-8?B?ak5DcnpDRjh6UkxhMkhOM1hSSHhqL2YvZ2g2M1M4R3BtZVNhMkFaRlFjUGMw?=
 =?utf-8?B?V3BrRnYwVWpHNDhiUVl2ZWVoR3I0VytBZU9ZMFZtT2lFSHI1M09QeklpMHlB?=
 =?utf-8?B?ZS95b1Y1OTAyRGRudUxMOXhWbUtHSnVINTVBbm5RckV1eHc4WjV3T2ovM1hw?=
 =?utf-8?B?cGJqZ1ZYZlNsY2pkTGZ4UWdGcSs5WGZRZXdGNzBlOUxNMTBtaDlJU3YyanRY?=
 =?utf-8?B?cGpyUHBnNmc4Q0luVDVEMGMxeU1kc1IvekFPTmlTdVRtZDI2dnVsUXJuTlNt?=
 =?utf-8?B?RlZmc3RtRXkzalp0aFVsQzR0WHRzVElRU01BTmRyMHNrLzVmdjhPc2U2VXp5?=
 =?utf-8?B?WGZ3bjhPQzZjaC8zVkswVkQ5RlVOSTlTRjd1dDAyeVYrVXJlbk5YRzEvT3JR?=
 =?utf-8?B?WkErOUVoVitsakNOOVNBNFFDTXRCcVdvNWhrTndIcmU5TXpQampmYm9vMWZr?=
 =?utf-8?B?Q2RBZXJjY1VEUXpBTzgzc1RGWVQveUVKYlRDS0pTWFl4d0pRa1hWSHZnaGpB?=
 =?utf-8?B?U0Fyc25MeTFYZEdsNzMyRHFMU2ZWWXJJRzYzUkFZQnl6TDFMZmJYV2NZbjQ0?=
 =?utf-8?B?cXlqNmxZUHdob0xvN3NXb251dzVON3JpdEg5SVE2L2w1S1FFWGg5TE5EMWNu?=
 =?utf-8?B?RHhadUY5dTNYLzBBR1l5KzNHN2piSkRxYlQ0MU1xU1VJNk0yb1YvRkhVWFRH?=
 =?utf-8?B?L0VZS3RWeU03ejFHU0ViQWNkdnd5d2NzMDd2NEpjT1NqdkZ0eTNPcURDcTdz?=
 =?utf-8?B?MlllSDRmVnRtNk9NajZGaEg1OHVYaWdHTmlJc3k3U1Q4c0F5bmJqbmM5Q0Vm?=
 =?utf-8?B?MzEwVWNtUzNNZXBVandHMno3M1BaYjEzOVk3TWJNZzRSWm5nMjN5OGU0Mm1L?=
 =?utf-8?B?bVorZlZyVlVkb2hmd1VTQy9VZVVoOFB5UzBqOXdwMDQ4eFRWUDBSNmtCUjU2?=
 =?utf-8?B?aDJOOFZudTBiMTB6OGZ2Mm9hdDlmSml3Vk9iOVZ6WlNwY3JrWDM5Uk52RmZV?=
 =?utf-8?B?TVpnd2ZIV2V1ZlRnQ0UzZnFuVW1JaE16MmFLVDd2dzFEU3ZUekRUQUZCSStm?=
 =?utf-8?B?QjlxaTN4dnhsc0k5ekRwVDBVNlhKTGl3TnNlQVNjSkdnMXNxYis5NlNIeUNS?=
 =?utf-8?B?QTE1MkJpcWhqSmV0anVVOVRFb3hrRkdLZVdOMi9BM2pRUE1USHp4ejgzRDhE?=
 =?utf-8?B?dytCTW16cUdPT0RzMzVXYU9aQzRFcTFQRlpHanFLWmxXekRvdlpvTkRjSnBZ?=
 =?utf-8?B?Tm9VdEhmR2Y4SEU2cE9xemF0UFg4V2RQN0pUeGdvMFM0T05MVk5uVG94SHph?=
 =?utf-8?B?RldlY0xSbzJyZzNLUzk2Y2d5VnVjRHdjeCtBbEZsN0QyVWxldUpoTldLQm9r?=
 =?utf-8?B?OUVMOTdJWW9lU3ZvRXBvQTJ5WFl5dTEyVm1KMmxLSEFTTFVYTFovaHBMM3BL?=
 =?utf-8?B?UWdwNWRFZnZSZ3p1VmNxVjB0TkVtN2tOWHEySEpRWWQwUWZMa3g4QzdWWC9W?=
 =?utf-8?B?S2p4dkprcm5rMXMvL1ZaT0Q5M3UvQTRwbmFRTWcvblIvdXhWK1hYZ1pJVGND?=
 =?utf-8?B?Y3NDQTB0OEdCTXJTTmlRdVpSWElJWmkzYkRyQ2VxTDNWUTk3aEFhZHVwU3Zk?=
 =?utf-8?B?MUJWOVZTYmhwczZvR3h3MEErSUtXWkNVRUJnZ29JWEthODc5QUhZdko5c2l1?=
 =?utf-8?B?ZzN2RWZER21VMmtIQ3EydndrZCsxRVdNcC95aVZqdzNreThKdUNEMEVOMkxj?=
 =?utf-8?Q?CbyrQX92bDjXcjnXmbxKasaRa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 758638e4-6009-40a6-6d7e-08dc1c6cecc4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 23:42:13.6129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EywmHFIlK96CeoavxvwzBJq6Jf1arsWVJZR5Q5iTvxzRDBZrUw4VpBm5OmziSWEcbriFGDlIkX7zctjHDi0AJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5570
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Maydell wrote:
> The const_le64() macro introduced in commit 845d80a8c7b187 turns out
> to have a bug which means that on big-endian systems the compiler
> complains if the argument isn't already a 64-bit type. This hasn't
> caused a problem yet, because there are no in-tree uses, but it
> means it's not possible for anybody to add one without it failing CI.
> 
> This example is from an attempted use of it with the argument '0',
> from the s390 CI runner's gcc:
> 
> ../block/blklogwrites.c: In function ‘blk_log_writes_co_do_log’:
> ../include/qemu/bswap.h:148:36: error: left shift count >= width of
> type [-Werror=shift-count-overflow]
> 148 | ((((_x) & 0x00000000000000ffU) << 56) | \
> | ^~
> ../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
> 409 | .nr_entries = const_le64(0),
> | ^~~~~~~~~~
> ../include/qemu/bswap.h:149:36: error: left shift count >= width of
> type [-Werror=shift-count-overflow]
> 149 | (((_x) & 0x000000000000ff00U) << 40) | \
> | ^~
> ../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
> 409 | .nr_entries = const_le64(0),
> | ^~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Fix this by making all the constants in the macro have the ULL
> suffix.  This will cause them all to be 64-bit integers, which means
> the result of the logical & will also be an unsigned 64-bit type,
> even if the input to the macro is a smaller type, and so the shifts
> will be in range.
> 
> Fixes: 845d80a8c7b187 ("qemu/bswap: Add const_le64()")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

