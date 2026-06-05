Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D341CD8C81
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVqO-0006kG-Rr; Fri, 05 Jun 2026 10:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sandipan.Das@amd.com>)
 id 1wVVpy-0006hM-OG
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:47:56 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sandipan.Das@amd.com>)
 id 1wVVpw-0000nV-E9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:47:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBdO7zrNIM6J5zGuBGLCsX5dAC7/khgphiEceLV44t+Avl4chOmyHmSictxlFNC+B9PyYyBdQfNMNpi8xfjDBqwPBl1tk3UjGMRQFucyrQdzbX1+zvq+hH9YrXCdEDMyoHlKFHfnKkG4zs8BgvOtDxDxH7U8XgRyPWNA+SCKkKl51RFdklXx2bhmYRV5TMHs2alelMy5YaQJabaxUcOD7Zqx+8uqFXzzI8uZXrOxqaCvGItlklqFOd40oaSywZ9pYoLQCJBUxZ0lttUnSsnF6xKV3Oe6luqX7N5NKz+YnN+UTXDRw1L0G1kfCdzFeUxfc81f3cQ+gJ2nvpzgBbvEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Zh/hE3krLtQIqnhq158l+jFx++fVpceTKYC56DaCxQ=;
 b=YdNE8/iV5lQ1/D2BiXbbp/ZVXIFx5ffI5cfKW+Nnp0dL3VbDALc4MEY8GdtbSELX89HYbExf9juy1WjZVnzB4hCWDZw0CzHME+gOBN0QaIQyHELdASNs5GpgO0QwNeN1mj2jDsV/gP73W9XYba4Vsvuebnxm2eit0HTB9WpzytsHL3L0WC99YUfmm0vnmYaCt7+2sY2Ks42n90KlT78B1XnyWcRysutLS5jp//StN6hFoFN77KMo1J5jvhy9BIMZc66Qw3NI2epwfthWxtP5iEltswf2l9oBDnyiNhJwbZm+6352cLl1/rIO786LzD7GBY1uN+QX9v6ZiqvJzpfXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Zh/hE3krLtQIqnhq158l+jFx++fVpceTKYC56DaCxQ=;
 b=EiPAg13U/PlxL+JRXDPhxoOU5djTR9RzY/cZuuU2ooxPi5jJZRGzh004JPB1EYtYjSU8zNjb2Put/qy0Lkr/gpJEe91hfqzMqis2skvA/AVP2fD9Dmtp/LJZnXbHhC7ISUGrul/JpFcLexa+RUaDkJdvN5Jg3clqTdM7GHT7iD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 14:47:47 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:47:47 +0000
Message-ID: <a42547a0-f4c9-47bb-b151-315069b8d855@amd.com>
Date: Fri, 5 Jun 2026 20:17:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] target/i386: Don't save/restore
 PERF_GLOBAL_OVF_CTRL MSRs
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang
 <dongli.zhang@oracle.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20260604025546.19378-1-zide.chen@intel.com>
 <20260604025546.19378-2-zide.chen@intel.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260604025546.19378-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 06454d6f-8a4e-488f-1f5c-08dec31168a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1MSwJm0J8OfrXy76o2xvFLn5h0CH7yeVlxhFvgHGYtaXS8dYy1A22oSKfeI6BTtOi1E8TCCfDQAy2fMiWON6D0ZULlBNtnobkcNtm2Qb4cyjealaZ/BD+/jW5WfF84Ar7ZQiI1esrjHDYX/Fm7xTFaX5kfFcRtZ5ElqL14UA/SuGp/hCjND/VibybyNNsMb1XtIcB4t5Kd+7KRntzrEAB7tG1h7i+vl0z/7wWQqcXwfYMbEsTFKeq2zaR1jySI57PUCUW+WD2bEq3DPb3oK4xvx3nz2actWHTuilp1+F8ZdNajB0TQuPIkB//jOvp/AP7zpxy58sZ9wuLCicCg5GKlyNStlKAccL/pyFdp6s+Zp3pp3QuF5qo2AwMCLH9loeNMOsOU7kuvxlocCB+g0ADYaTOVsGxGCyLEslPSM+9G3D2u7ZZR5H7U0NoiYypMkSAQrIyNJjEjYT3s/fYMv7LHMq/CVx03a/7IQjqx2Ba1vD7PHuCOHMu0vlkugjU4L3tOlcVonKKTnD/RkyTqdknSZvYGKsDyFPx663/ZTh/riDpSb8IFhXSqv1LjCbpYMPSE6xoChLbaBLOiWeZhjgpcZXLUO3yfznAg/Ogu1QCbrqP3skca31IHessWPqrxSry0J3s72sLkgUEnncoCPpVyGb40nt5vtCyERnMzptBciIug4vT/EX5kaasZA+bhC9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5712.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TThQa2xRc0podDVFZVJmdThDOGw5NUV3ajlvNkRjNjN0UHE2OG5JSExoR1cx?=
 =?utf-8?B?eWJDYlVDNXlIOWEzR1dRL1dmU3V4NnRmMlEvclpOYXBFbkZnSXBuaC95RnJO?=
 =?utf-8?B?bjAyb3VicjZSeHNUNG82eDA2ZS94ZkhxVEFkcWxXeUNWY0EzUE1vSEFuZGVj?=
 =?utf-8?B?SU56WWF6RWhBMUEvTWlMenZBVWtNazI4dk94MVdWSXVZRWIrSlErTjdBb2V4?=
 =?utf-8?B?Vkp0REwreFpjRGFPUW5PNk8wKytoUVRIa2NOb25IZ1BPb0diNjR0QlZMTmtY?=
 =?utf-8?B?S3l4NTgxajBoYUhWZkJ4cURMOE1wVGpDdFpTeFdXaW4rTmZDTEE3NjJFeFRM?=
 =?utf-8?B?VnpTZXd3VzIzc3NFK3pvYkZIVUJHQk83OGNZRzVja28zaHVqMEZrL2QvamVX?=
 =?utf-8?B?aktYQ0p5bEZOWnZsZnVjaE9oa2V1VngycHBFNXEyVEM4cHJDSXNOdWlBakxo?=
 =?utf-8?B?TjVFekpxeWFHdkZydFYwK2hDQTh3YjJPMjZxY2ZUMlNiTG10Mmd4UlNKMUl0?=
 =?utf-8?B?OEpJZTFOaEVzMVN6SmMzRDZzYmQ2NEJIQ0JFMkdnSUZYeHB6NUxyOFBld3k2?=
 =?utf-8?B?bVlWdlpDZEMzZHd2d2VTd1hvaWNHTnkwaTMwL2NQbGg0YlF6S3VvOFNKbG5J?=
 =?utf-8?B?QjVhcVJkenVJVjQxd2JMMFlaNmdQZDZsYlpZbFYrZ0pETDYzZlZoNitTT0NY?=
 =?utf-8?B?TUxFdHhuWWxHRC9uQVFLdFJuNzBPRHFMRG9wTU1LNUk4WlVScGRtK25WS2dN?=
 =?utf-8?B?NnIrUnJwMmpuS3JOd0RHRkZaakhDR21xYVRhckhNSEprQ1dXQVFZN0R0SGhr?=
 =?utf-8?B?S3Y5RnE2bG1KZHAydHA4NEozMzNHRjdsY3JoSXgwWEN6YnZZU05VNytCc0Jz?=
 =?utf-8?B?aWpzNFNFVG1iYXc4RnkxRFY1YVZGM0JodmJoZTlUSVh1ZGUzK1QxWE91cVVC?=
 =?utf-8?B?cWNWQWc3TTkvS0hoQU1za09KMzJ4NEZvQmxPT0Q3VEIzZlg1RGVqNytUckhP?=
 =?utf-8?B?d3o3bFJZUk95UWpzT1Rrd0FKODlZMkdqTlFMaFlHbUlZaDlXN1p3Y1h3VnY0?=
 =?utf-8?B?M0ZWS1Z1VDV1UUw4dDJXNTYzYXo1Sytac0hHZ3lSZFBMMWJ6Lzh1bGwwSzdB?=
 =?utf-8?B?RXJQaEhxNDExaU01MkZSd2hZRGE0T2R0WnNZbFY1dW1GUWxDQkNWZlZaQmc2?=
 =?utf-8?B?S2ZpS0hPTXluQUJNQlJ1aElCeEU4dEpkaDV1ejNUSnMzVjdSS1BJeHhUTCty?=
 =?utf-8?B?Q2QvZGhPVkZhS0ZBSHBCT1dkREZRenZvZTBqUGN0MGtmcnc1bGRxcURjSksx?=
 =?utf-8?B?L0VhS1BzNVdxcWZidlAvZlZwcjI2b2lNdmhYazJUamY5TmIrY1ZiT0J2NFhj?=
 =?utf-8?B?QitTNU03TmF1R2lmZmxMWCtpbW1OQi9lT1dEaFZESDk0S3lCd2JnWjZvOVpH?=
 =?utf-8?B?TVUrRDVGOUR1dU85ZWNrbWdOam15ZTJnQ1IyNndLbGtjYWFjY0NSQ2VSNllL?=
 =?utf-8?B?bW52S3lPYzRFQ2xlVkQyN1MvWURWQkhMOUppc3graGU4K2hOdDA3aW4wTWtI?=
 =?utf-8?B?UGFhbCtEQWEzcGI1R3JwRHZ0ZjBOZ1BqWC9ZQ1FIcWYwR2Q4cDZhdldzdzFO?=
 =?utf-8?B?VVNRS21aR3JmZWhLVUF0MzkzU0h1SmEvcktrb3cxMWZSVmJaV3hEZW1sYzJl?=
 =?utf-8?B?VTAxZi9sSHBqd2xBaldZS0FhaGNIc2pCUG5jTVY3UzcvcmdvSTdRclJXSFZF?=
 =?utf-8?B?VklrZDJQdUh2cTA2NlZlc0hiTkVtN2Zjb3E2SjF0SEs4U0JDVTZYV095RlZ1?=
 =?utf-8?B?SHhpR1NVVThuSTY3bE1jVEx3d2pIYVpuNjFJLzBZdFpTWC9HbmZIeDg2NytG?=
 =?utf-8?B?ekRZeFZDS2J4d29iK2dhY3lsZ0lmZjE2dnhSaDdkRWtPSW1iaUNGWi9NNzN6?=
 =?utf-8?B?YTlYU1B2QUZ0T0IvME91dWJmd3pHaHlCWjdFdldLbDRlT3g4VUZCSlo5TVlG?=
 =?utf-8?B?TVNucUJEd3VNcktRKzYvZzMzNW5rb25jeFRiVDV0OThCVnR4ZGEyT01ONkp4?=
 =?utf-8?B?bEtVeStJL0ZRZ0ZieDk1Q04rSHJCY2hEUngyOEZZKzZYMm5rWkx5QWVSL0Ew?=
 =?utf-8?B?VVgwdjVjL3lYbjVyNHlCVGdoVDFUVWJnMDM4UHlXb2pVSjR0emNjcDZOcm1E?=
 =?utf-8?B?eTlmZUhFNWpmV2gxbjBWNCtDUjg0dWk1MnVOQThkRjlkRlYxUzlJVXhxU2N6?=
 =?utf-8?B?U1FiOFNSU2lWVU5iUDFpT3VsR2toc2t6ckk1dG9CbWtSMVVBVVd3NjRycm1N?=
 =?utf-8?B?K21mMFZvc09zdnZoZ0VxRXNreGxXTFNQY2lnMTk2RFIxRFNxWjNLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06454d6f-8a4e-488f-1f5c-08dec31168a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:47:47.2141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFqO+c9zteG9bxuag6lhGMCY0zd7DBcF51yjlMQ7u01RnEjSo7EjLqcQPyG8PUL8W3kPNwMYog4BNcVj0EYYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Sandipan.Das@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04-06-2026 08:25, Zide Chen wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> MSR_CORE_PERF_GLOBAL_OVF_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR
> are write-only MSRs and reads always return zero.
> 
> Saving and restoring these MSRs is therefore unnecessary.  Replace
> VMSTATE_UINT64 with VMSTATE_UNUSED in the VMStateDescription to ignore
> env.msr_global_ovf_ctrl during migration.  This avoids the need to bump
> version_id and does not introduce any migration incompatibility.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: Sandipan Das <sandipan.das@amd.com>
> Fixes: e587632c228e ("target/i386/kvm: support perfmon-v2 for reset")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
Reviewed-by: Sandipan Das <sandipan.das@amd.com>


