Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B539FD8779
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2e4G-00043L-DJ; Tue, 17 Mar 2026 19:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1w2e4C-000436-TE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:43:17 -0400
Received: from mail-northcentralusazon11013039.outbound.protection.outlook.com
 ([40.107.201.39] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1w2e4A-0004ql-Fm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:43:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVNFRssl509nrmnfzda7RT1irO7LotEkBzujQfxFy0unfBT2GJ4TIHjxJ/g4CcD1LfgGG6ZC8atWmttjGCAGK/GSSZKJawrsKOcvHiiF6/0JgiMSYUn4tQOEnsnhx3oeXKbiGg5BaJG+i2uZIZ51+r4ODwu64lC1PfUk0899+LIeaJjZwAaUysX+hikUzkonPL6MIOub007/DD4yQjiDDUBJTL8+Rw68vgqk0F69zdGE7vcNZUMBQXYFeNXix4cReQtnDrOmrgb3neu8aPgwDiDoCumE8f9E/fAIB9ovLsztcqERZ1T/lZlNFsDDPHkzyISWqhv6VifpoHb4Iu2EcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnlDmUuCA/9bbCb7X55OYKJ8BcpIi26I2E1Vz/kb1dk=;
 b=VsCSfsnN0SfYv+rUYSXOMS+e2ybLkQiwqFgiaYtprxdd5IsIvorCMFDmi0w+Nto5g6Y0EbB2c2x10LrzPlWnPpXeq5fX05uC0TSQHTOa6g95/SwHDNmelfzPW3L4dP4pMpQjyDFW+zi9SrJN29TB4DBxXKeWN3iU0qtiUN2fU6WjaSWRV1IaVRoldohKXiUxFblM+T+Qylj9eL6TgX942UC/57YJ6ltDrB2jwviTaQTCNgIukX54BoQoLNcXKjt1VNrbiPu+wGTKGvX5c0x8+Mt4w5T6tNSHBWzPjljrtE8PH+OZaq/VR+GiMV7H6sm7CYZ5ouaoy2fs9fZYGy2OwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnlDmUuCA/9bbCb7X55OYKJ8BcpIi26I2E1Vz/kb1dk=;
 b=bWZ4MCtX9Hc45QB3kQv8FTiTEspUYrzDq4d0MHXP5oBfKnK5AKaa3u97ty5boF4JMHoMd5/mNX3n4U5YL3sl73xYgfPd9xBOSwCCf08fZuYoBbUMjV+uySynofGNQe1rfVbJPt2I6j2r4objzNm3eOsnPx311qNLsI/kyqABINA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) by
 BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 23:38:08 +0000
Received: from DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::c748:abd5:8638:f377]) by DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::c748:abd5:8638:f377%5]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 23:38:06 +0000
Message-ID: <344682a7-723f-404c-a8ef-28548b9942b7@amd.com>
Date: Tue, 17 Mar 2026 18:38:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Set mr->ram before RAM Block allocation
To: Xiaoyao Li <xiaoyao.li@intel.com>, Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, chenyi.qiang@intel.com,
 Farrah Chen <farrah.chen@intel.com>, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>
References: <20260312063420.973637-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260312063420.973637-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:610:33::17) To DS7PR12MB6263.namprd12.prod.outlook.com
 (2603:10b6:8:95::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6263:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 699b8794-fdcf-420a-d4bc-08de847e3d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: Jo5a2mp4b60gJCs1TM6/9h0owHv4Weldp8lyhNliVorEbpEmx5XVAS2gN50O1Pev2t3tbbIxy79MA73ukje0DsDnXd6DvWHSTws6fnNyakdRFh4VopKw7/S7QHPXiObbpd/oFZvxNpO/ZeXjA1dYFpqQ1mI5thRiH64BsxgrwazAiSwa+RpzG5E6K+udHiLkGMBx+NHEqGqA0qiztT0LUsJoj3zgxCrg4sjqvRX7DYzB1a6RWcHaWX50ZYwyx2Xbra1GHvKYIOZ6e06C1DsL75DmtJvBr82f/USvv8tHEvG7DDhtOfKeQ34QjhmfPK0CD7DmkgIBvWypY+YTfUcdf6Fc+x9uPj3RJRKffDoAYSbTv81v8efweyPaqHhD+PtTjSqUDlo3A1kZ0PaJ46eY5vDMqLPu+J9AruIEvwykZ25bfiRUwjJmjkkaODpivMYHFNHdPskLkFstjePwYGUFFiTadZXelj5UNxhm13S4Cy5SSFyjMNRSmh5Sm2Vla7bq+T3G7t4lRdhwlg1iMHq2grgeVm7LcPxJuEMavz9msSzbmdOOw8KESQgQTev+eb23f4gSGlM4e7d2/1R1fGKWC5sSw3oVKKoMiqqOWqe0kLXStNy5RlghSkRXFNXos5zHoEozor+aeRoXTV9fnizVF+OnAEub4sOMwmoQNU2Tf8TE6kzV06A2A2t5rSiupNGcEYBzP+AweMXwsKey+92HA4RxVOor0ZfI4Et55W80RzXZnHUnIoyYt+mLExjRu5lD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6263.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEgwSTZEeGxXaUdzVHFtdVZxSEtyRG5SQ1BkVGptSWtZK3N1NmF0Vk80dytH?=
 =?utf-8?B?T09FeDg1OStWSlpWWWtoN3FjdFdHZWJzVU5QakFJM1JMRWhpZEFhdEZSeGR2?=
 =?utf-8?B?RStqWm12c3JlT0RTOERqa0U2Z0Y0eXBSMFhXeUZzd3BNYWNuVjRwYkhUcDlT?=
 =?utf-8?B?dUg3Wi9NcGZvdXdGSmRidmN5aDlFZnhYTExJMGx2eWdlRzRkRjdJRXRKQlZk?=
 =?utf-8?B?T1plelhsTjJqRHhHN3ZDYW14VHppODcybDRnV2plWWRITVdmdnN2T253bzRS?=
 =?utf-8?B?RXZJd1oxcGFwdlJ2T1BETlNCNnNyZVdmeHQwNW1RbTRIZXpHV2N1ZmozSjR2?=
 =?utf-8?B?K1UxSVFRcnoxa255RkVBTUo5bkdhb3NSOUovelNmZDFBd3ViQWVEdjQxeGtV?=
 =?utf-8?B?K3NNVnFnS0szNlZINUdUajQ4eFpZRDVnSjVrNHlFcDJlM3dUTmtUbHVHSFpF?=
 =?utf-8?B?bUU1QWUyTThpU1o3Mm93Vnd4NzVCNkxYaDFncnZ1K1ZocVNqZ3FIdDBYN0No?=
 =?utf-8?B?MllZUDc3UmlkZXlhUGgxbDVuUkFWaUN1Sk9IallwSU1IWGRVc3B5OEJvUGNY?=
 =?utf-8?B?VWw1YXRmSEFDUzFKU0hrbCsyV0o1QzNyZENoalR6YThKbjE2K25YcVVwZzZN?=
 =?utf-8?B?djFQc1RVdmIvZHROY25Cb1B0bkdPb3hybmZYL2dQWCtqdnZCczRtR0hRQVpU?=
 =?utf-8?B?QVhXaUtJNGFKVDBwQVRoZHhrelA3VkhORmVib1dUYndSOS9xMHdxL25KNnQ4?=
 =?utf-8?B?dm9FNjJoREk1UE0rbmlWaU9PaUE1MEhOU05SekpYRzJjTzh5VkRpMmtVcWIz?=
 =?utf-8?B?aHl5NGJKSHJGb1RHNVJWV2Uyc21kS1o1MGRyL2o5RVAyUHRmSElsRHhJb3hI?=
 =?utf-8?B?QVpDVWxjblpraGFJdGZqZHJDRG12TE5xeXRCcUpEUmZBaGhzeDdaNkFHWlJ2?=
 =?utf-8?B?R3g4Tk9ORDdER2k2SDl6QzBlQjhXRnVVa3ZQTHhRSVBoY0VISGxUY1FRbG9k?=
 =?utf-8?B?ZnAzZ253bkdDMUdjTmlQQmlVRW9UelI1Mmsza2U3a0NtbHhwNGRYZnFKdUFI?=
 =?utf-8?B?dThQNFVSRFZxVGlMbGZrSmJjNlpBMm50U1NGMm9qc0h6ekYrSTk0b00vb2FM?=
 =?utf-8?B?WE9HVWNBLzZjRk9weksxV01yM1BvN1BpZHUrckRHU2tWeE5KUUFqbXBJNXRn?=
 =?utf-8?B?bm1yc2drNVpTS3p2RjNlYkM2TisxSVlHL2dBWnpNRUVXQ1gyVG9Dc2lKTzd3?=
 =?utf-8?B?bDdCWGRqeUlaaW11Y0xRWjF1bmlVaFUxMEVXektnUnNwUWlNRmZCQzI2R3dp?=
 =?utf-8?B?MElLczJIcWVKMVNPQkFCVUlRVHFEWWp3WUZIS0tZZmZ6YTdkYTBqeXhZRU82?=
 =?utf-8?B?M2dMY2JrYnpCMm9WN1VERnRVbkR6dmwvQjQ2aWR3L21YZ3lvd2dIZy9ESEVo?=
 =?utf-8?B?WG9td3htZ3UxU29wUTVTMlRRQXFqMU4zVzhjeHJaWmtvVWQ0UHFNdGdOZnRs?=
 =?utf-8?B?bGxuMUdnM1pyVmhyVEJDRTFodTM0MFBSZWFvR3FsMHBTM2MzRXBaNVQ4VHNu?=
 =?utf-8?B?b0V6UWFEd3J5eHdqY2syUFFNQjNmTk5qYi8yZ0hSSE42em11K1hxQ3V2VlZ1?=
 =?utf-8?B?K3YrWVhnZ2ZaTCt5U1NnaDViWkp3V1B6UmhsTTd5WWRsMXdBZE1Ud1Y4ajgy?=
 =?utf-8?B?VHQ3VkVvVDNXY0t5U2VoZ2laRmdzZWMyNVJHRm5rM0RpaFowaWlEcFYzNXBN?=
 =?utf-8?B?cHcyeXBFKzBHYWlhYmxCRmFDckhuVzdRcjFlc3B1QXJFaWVMUEt3Y2Q5MThu?=
 =?utf-8?B?VnJSa1paRWVMRWJ3OWZMU21FR0IyNmdldmJFS01TdGVydEQrRm1xQ1dCZlMy?=
 =?utf-8?B?d1BGejcwR1JoRjd0K3ZxSW03bm1ZeVd1YTdId2Yybzhib1BMOGl1dkNmcmp0?=
 =?utf-8?B?YzcyZTBnSUlxeDRrVzFJalJZWWIwa21Fek9FbDZEVDNkWkZiUTJwdko1T3pl?=
 =?utf-8?B?YUxvMG9tejM3dFZwU1FXN2NLb3YzZWR0TlUxd1ZrdGdtdU1GWFJYS0Z2RzhX?=
 =?utf-8?B?YkxPKzVoUTVjR0JOZTlPNXNrL0hYNE9kM0lybVFjd1VKNEl2TnJnY0huQlBq?=
 =?utf-8?B?T2RMV1BsMXM1OEVtOHcwZ0w5SkpkclRUQnA2RUorR3V5UFdrOWphck40Y2Fm?=
 =?utf-8?B?WGZVakd3anpmbHozU3V1OVpUNjZqekdKSXJsOHBrTnIzOUFBdG9UVnVCT25j?=
 =?utf-8?B?OWF0ZVQzNXM1cnUxSXhsVFBVYVBtb2ZCRXF4S3NhaXZWblM3WFVHa1FFUFFm?=
 =?utf-8?B?bXJkamVGQ3NFL3B0WXBPeTB1UTEwNktDeE54R3BVSGJMa090amVPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699b8794-fdcf-420a-d4bc-08de847e3d48
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:38:06.5070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXt5TFkcUvpCS44uqysam6Szt9uGtPN4ghHpYy1vtVF6Eif/3SITMtoFQZSMokOfTQMS9VrbJJzv31C4vCafAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
Received-SPF: permerror client-ip=40.107.201.39;
 envelope-from=kim.phillips@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/12/26 1:34 AM, Xiaoyao Li wrote:
> Commit 2fb627ef2f48 ("memory: Factor out common ram region initialization")
> introduced a helper function memory_region_set_ram_block(), which causes
> mr->ram to be set to true after the RAM Block allocation by
> qemu_ram_alloc_*().
> 
> It leads to the assertion
> 
>    g_assert(memory_region_is_ram(mr));
> 
> in memory_region_set_ram_discard_manager() being triggered when creating
> RAM Block with the RAM_GUEST_MEMFD flag.
> 
> Fix this by restoring the original behavior of setting mr->ram before
> RAM Block allocation.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3330
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Fixes: 2fb627ef2f48 ("memory: Factor out common ram region initialization")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim


