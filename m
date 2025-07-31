Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CF2C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUJF-00058C-UF; Thu, 31 Jul 2025 10:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhTLS-0000Cf-F8; Thu, 31 Jul 2025 09:29:18 -0400
Received: from mail-bn7nam10on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2009::627]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhTLQ-000141-4K; Thu, 31 Jul 2025 09:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucEu+H+LwkxahFg3Sc09r2TIGlvG41ixDmmWK6zeWRgnDMGZDnKLc5ztMOD4cm/TkEJchteCRhsbef+9PjBxF/ylsUhnCeo11N0lJ0wwq30X72Hpe8g2h7Yh8QAB7bOguU7kClnO51F52GYh1/5XL9fRSQ3m3HT6c/sQ705efNhNrobaRwCt88nAebtz9Q6QOl4g+0Kyj1DZJRo6Wi6FehwPdrHuurjDmij0iRQ0uWkiv6qRaykri3ywMH0PkaM1FhLteMJShh7hQXqzmsb+dr1sgO7Fh1ZVJJbux4K3dkd2Pm8zROxPOz3z2ueND6GusHtoDBwKRLN5HGvWY/Gs+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bkjsl+YnGW/ksJaq7BPFd6ivl/2QazM+SRHHgnwur8=;
 b=me3PQDiKJlyAhqJ/uBvbHjK4vW2m0rPtsQX2qbCOhGNisSuzwNH+LZZ6GziMEH2Dp7wTvKI0IGjom4fw+jKTO4wqcwHHNPwUKcrW6ToQEUBBAg0Vx1J9imm9DA9/IwAzHjF2V7ALWK1j2Pog0uOW19C2iNwaMzdb9QszXQxSD8q0rSHZXYQ4frPPHgkk7JDigXhhWLyUQBxa9/Fpn98Sjkx9iEYE6HPpmEwDPZPEdqctuooCa1Y7VI2IL51chu1i74bBJjKXiTH05vlbtY40O2180M4lEKN2BeTn2PbNLnX0Doeh1GS/BRsRLTKATmCivzAh6OzX5yXuQBc36I/tJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bkjsl+YnGW/ksJaq7BPFd6ivl/2QazM+SRHHgnwur8=;
 b=Gfi7B49eWdIcFXGlU/oI89/tMpxKNhuisjip+Li5U91Y3wHKhzZUolzSW7Jhav2WJUfHKsdogZKAPFM+GEBi/4Hgvufz0GKo239enQAeCdafUGgRpfHMhja7KtkSAOosr1d/aBPMgjKlrrN3VIrbwAITUb91fX/aJAoJZpCYFkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 13:29:09 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 13:29:09 +0000
Date: Thu, 31 Jul 2025 15:29:02 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 35/48] hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ
 indices
Message-ID: <aItvnqIQNwo10jRt@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-36-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-36-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0527.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::11) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 132d52a2-c54b-43bd-fb28-08ddd0363a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3A1aGtZMmw2Unp5UWt2WWtUSDhXZ2hQMGdYc0liZ1p5WUlWTXdYRDhJdlVO?=
 =?utf-8?B?VVRCbWxaRTlYb3RNK1R3RGhxVGNRdm9GV3ZXajIwK2kwdUIrQU1veGVQS01a?=
 =?utf-8?B?aVEvdEtuQUkyOVF4WFVIeXpybFZOWVM3WGNLUTZRdzNGR3FUNG5kV1VYSjd3?=
 =?utf-8?B?citId3ZkVXh6anV0QlRLSENwNTFpcW9LWmpnb1FCU3Y3dnhlZmxzMGVFWThh?=
 =?utf-8?B?aEplRHFDSE04YVhSZUFCQk01R3QxU0duQ3U3cmM3bHhWeU5wKzRlZXV3L1BN?=
 =?utf-8?B?VGk3K3VYRklRZmFWdFpneE5pbklZTDlUemV3RGpiNHkyV3dKUnVqUkpieDJS?=
 =?utf-8?B?MHA3YkpTZHYrVFg5NllHQU5MYXZTRVRXOEtzVlFoNWg4bDlHN2tXSy9kTy9k?=
 =?utf-8?B?SXpvSGhhZUZuRSs2NHpUNEV1eVdWMjZtaTVpL3RwcmF1Y2JUekpBYXJBOXRp?=
 =?utf-8?B?TDh4Q05rYVAwMXI3OWswOFNLTjA0Q21VSjkvWWU3UUFSRS8xNEh3UGNkZUJX?=
 =?utf-8?B?TzQyMVdHZ0tWa0tFRnNZVXhuUFFlMTIzVGM2cFl0YzNNLzZDOFJaOUkrQWFJ?=
 =?utf-8?B?a2tEQzdEYVRITzQ0NmZDTXlFWUoyejZORkdKM3NJVlhXSXczbTRlWmlUd1RJ?=
 =?utf-8?B?d2srcnJlM1hsVmNoUHM0TklvMGhaWHVFbFFYMDJoQUhrSlV4UXB5NjQzVHEx?=
 =?utf-8?B?eUpTYzhGbmp3cjNvallnbGlBWDdERTJzT3ZZbDkrdWxud09CVzRLczRlbnRh?=
 =?utf-8?B?bk00WVhzck1lS1hqUEMxT3BsV0kzVGllL1NjV0tyekVkTjRqWTdSb05wUi9j?=
 =?utf-8?B?MzRqOXl5M2dHVEM0cGk4dzRlQS9JRG8yRFNIbE9QeExMWXRJNU1tdzJnUitW?=
 =?utf-8?B?VGZFRVVkUlU1dmc5T3lYV3doZ3BuYXE0NHhpT3cxUHVJbkhNS01LcWtteERS?=
 =?utf-8?B?a1VVV2MvOVJkQ0dmOStiMThiLzd1VkYrdEExajBNU0dYajBOZTdxNkxBeDht?=
 =?utf-8?B?MGt3MU51c2xJY2o4dE1QZGRyN0EzdHpSY0VGT3RadXlIQWJvTUJhNStJNjU0?=
 =?utf-8?B?SldVVlFrQXViT0NUZFpPNmFlc2xHc1UyK1NGWE9hNlFTb05DUHYyWGduUlZS?=
 =?utf-8?B?T25ZeWttL0NpWjc4UDdYM005VG5Nazl0SzZIbkEwTnhFRTduWFZFWDNmc2Q5?=
 =?utf-8?B?bnRQVXNoQ2Voby9vcVlMYmhpdWFWK05TMDhmVVU3aWpkQysxM2NZdjNia0Zi?=
 =?utf-8?B?RGExYXFhSDZmWmEvL1UvK3VsdHpEZnQvcHNwSWZVejA0NWNaUWtPN25VMDYx?=
 =?utf-8?B?TmJoNS9OeE1objIyMkFWOVNUR0l5R2dVcnMwQmVvbHBBcnorYmNPQURHTFdx?=
 =?utf-8?B?V2R2Q1R0NHBBNHZtT1hiK0l0eE1aYXp6cjdHWWxvOUg5Y3Y0aGlwU0tZdGVH?=
 =?utf-8?B?WXhMNVRobzduSXZOaE1OTG5jLzBaci9SbWRCV0NMMTR3YkY3Z3dSRGxUYnhN?=
 =?utf-8?B?aW56OVRxU1h2T3J1YlJEVkRRVFRxbmoxK2paTVBjRzloMDFLQVg4OXkrMC9x?=
 =?utf-8?B?VjhYUUF6Vm5UMWI5M0VwWnFVQ0RubHN4bUtXakxtZWZKQXhCeE5nVDczTWlv?=
 =?utf-8?B?SVlxWGEyYWlmb0l2VVVLOWlJeHVia2hOczJIZllKOURMcXJQN29CaHJxVnBL?=
 =?utf-8?B?QnZ2NkEyQU9KcHZydHFGRGhPN0h6MmhYU1BoOFpiM0JwTW8wTzRHSkFjSU1n?=
 =?utf-8?B?R21SU2orUk1iTzdOYkdVTUh2K0FqL2NXSnpNMEh4RUl6ODIvSEJTZzllbFlZ?=
 =?utf-8?B?OVRtemdGWUdXSW1YeTF5M2xwU0dzVmJ2d3VSN0NnYVBLWDlkLzN3ZnJHM3dx?=
 =?utf-8?B?OTlDdTA3cHFUSlNBKzFVTzRtZzR3NHFURlRGRFZ3c1R3Qmg5Q0txcEVUelZP?=
 =?utf-8?Q?R/3AVhJf834=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BHbDVieXVJYks0V0VSU1BsUXJ6NXljckV5cU1WOFg4Smp5TlpFb1ZiUFBs?=
 =?utf-8?B?OUoyTHd0Z2JHSVd0bTBnbUg5d0Zad1hHdGtSdC9pTDF6ZU5QcHc0azFyaGZ2?=
 =?utf-8?B?MFZaTjNuSm1LYWVtR29QTGlnWjhUcG5RWWNrd3hXN1pxVS9XY1FlVGdGZGRK?=
 =?utf-8?B?cDZFYzVDS0cvblhYbFErOWNCejZaQzcwR1cxY2haOXVHTW1vOGk3NWdHMWdP?=
 =?utf-8?B?Ym13ZTc4Q1dONUdOL0kxUVRvbHZOSTVmaVdsblRuV3JTTlQ4TXdsMVFKWGlP?=
 =?utf-8?B?dWx5bUdBaGJUUWpmVkR4THRTRkRtNlZFcUFlcEZwVVFLK1I1TWVlVEdDZHNp?=
 =?utf-8?B?Tld0MUVreEFPVGZqTTBIOFVKbks2NVpoNnNaNU1uMFNPYjdZb1V6bEZoTXVL?=
 =?utf-8?B?OEZzSjV6STc2cXhlZU0yem5uUXRDV0diUUJJUi9NRzljaGcxdlVUOHBERDVG?=
 =?utf-8?B?NzQwbjdPSzNsVER2WENuM0ZreXhGallRS1lGM0JOVFU1WjVrc0FEMi85QzlZ?=
 =?utf-8?B?SG83cTI1Wm9yV085K2lWcS9VbCs4bllEeXo4S3JiektMak85YnhYaHNSVkxU?=
 =?utf-8?B?QXZZdEhNWGttN1R3Z3FWMWc5TDR3TWVkSXNZQXE2aFU1L3haTGE5aXU3K1Fy?=
 =?utf-8?B?TzZtdW9ISng0N1FJL29QcHhPTVQvYml6NnRFNFFUejRjVmwyTUUyWEZwc3NY?=
 =?utf-8?B?dXRRNFJ5MXpHVnBCTDBwREI0cDFDbXJIRmU3UVVqRlpFWldDQkQ2ckVkbml2?=
 =?utf-8?B?bTFxa2psL1lVOGhsa2R0REZma3Faa21NVUJQQzYvUGY3THZlS2c3UGo4d1ZN?=
 =?utf-8?B?dzBoMk15czBBaXg1QU9FUWoza1FReXk3c3RzMzMvZnpTdWlmUENPZnJiWHkx?=
 =?utf-8?B?aUVmbVJZUm1jN291RGlrSHg5ZnNnOUJWL0pmZXlFNXJvKzQ5bFU5NW90RGZs?=
 =?utf-8?B?d0szaEZCVVVhTjBMdlhlUWFtZ3NJTEd6ZG1TNmVRVy9zQnpncnRMK1ovSWR1?=
 =?utf-8?B?a2hwdE16SFdjRnVLQ3NLSExRMVBWWVpYeEFZNERGNzFGZ0tIakQvWFIxV21P?=
 =?utf-8?B?TGtiK04vVWtXV0lQaU8yL0o1dkM4RSt0bzBaeE5BSFdIVnBlVTF6V3c0WTk4?=
 =?utf-8?B?UXJzQ3BWbmVOMDhNbTJ4d2VFbEE3RTNrWHNraHo4VXJWSjVoUUl0T2hHamRK?=
 =?utf-8?B?VytYRm16MnhYN3p5eWNXUTZUbjF4NlQ3MzY3WDllNkkxQ29qcG1yZGhPRlNC?=
 =?utf-8?B?dmpER1RIT29jSnlhZWtINVF5aG5RNlZrQ2FmVUR6ZElZRTlTUWthMlB1OTh3?=
 =?utf-8?B?dm1xQ1F4QjRXUVp4OEF4T1hycG5IaWZGVHNmS013TmM1QnFqRXZxdithRnp0?=
 =?utf-8?B?ZzVoUHRYTlVONWVhT1I1TGErMkVzbUZRRW9HOUZuR0psUlFrSnhoMTl4bEpz?=
 =?utf-8?B?alN4TW1vNFhZWW1LZWMwejN4L0hVd3lHYlEvaVE2cTlPazJHRUE3TXJMQ0dl?=
 =?utf-8?B?WXQyWUFVZW1kK2tsOEYxWTVyTWxBaEFNSzFZYlEyWXpObGswTVRwNHF1QWhG?=
 =?utf-8?B?bmpNNUxib1dROHdVTy94QWc0ZVpJbHZmTyt0SHFCT1Q2eWhmeUZrbUpxS0Z5?=
 =?utf-8?B?WWl0RFFrRmhSQW85NFMycGMzSlRITXhrMDJWMVNTR3RGdndaeUR4cnRwVWJR?=
 =?utf-8?B?ZG8wQWtnQnkrT1A2bEJPV0N2NVM2Vk1IZkQ0Q3p1UDdneUxzVWh2OHBQbGxM?=
 =?utf-8?B?dm9WNzl2QjdRbG5rdnlPU241YldPT1FmTFhCU1NHR25yR3VtS1ROcWpmREZh?=
 =?utf-8?B?S2FVcnAwRzROSmx5OTZmWENNUnV4MHZNTisyQ3VqRkJVZlFIM2Q3bENuQ2Zn?=
 =?utf-8?B?MFpTMVdEaE5TalV6czBjei9oZGc5MEtrYnkwc2NUc3R4TCsvRzF2V0JGN1FM?=
 =?utf-8?B?MllpVEZLZ1M2ZytsM1BBU3ZtMXVzdCtqREtsOEhzb09xZFRVMmIxUStPY1hz?=
 =?utf-8?B?d0VmL0RpSEloYytsSVp3Umd6UkVYcmpuVUEzUm1HbFFyVHhIRWh2TmdZL2R0?=
 =?utf-8?B?R1pWMmF3ejBoOXlzcUd4M3JBNk1GOTU2QlFacjRMTUFrM09acXdvUjZ4NDVj?=
 =?utf-8?Q?YR6ew4VB8VM9vd5DT99lgF+AH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132d52a2-c54b-43bd-fb28-08ddd0363a89
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 13:29:08.8700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAsJeyr8UUvNdSQyJU0Q8mCdxaVCUfbVGQNiV94U3bWR8nNqBuRns6yQZYWBcdRiR/OeCFYXcmCKlIc+CrNuLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
Received-SPF: permerror client-ip=2a01:111:f403:2009::627;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 11:54:17AM +0200, Luc Michel wrote:
> Use the bsa.h header for ARM timer and maintainance IRQ indices instead
> of redefining our owns.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  6 ------
>  hw/arm/xlnx-versal.c         | 28 +++++++++++++++++-----------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index ffa7801b30f..3be9f0a5550 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -84,16 +84,10 @@ int versal_get_num_can(VersalVersion version);
>  int versal_get_num_sdhci(VersalVersion version);
>  
>  /* Memory-map and IRQ definitions. Copied a subset from
>   * auto-generated files.  */
>  
> -#define VERSAL_GIC_MAINT_IRQ        9
> -#define VERSAL_TIMER_VIRT_IRQ       11
> -#define VERSAL_TIMER_S_EL1_IRQ      13
> -#define VERSAL_TIMER_NS_EL1_IRQ     14
> -#define VERSAL_TIMER_NS_EL2_IRQ     10
> -
>  #define VERSAL_CRL_IRQ             10
>  #define VERSAL_UART0_IRQ_0         18
>  #define VERSAL_UART1_IRQ_0         19
>  #define VERSAL_CANFD0_IRQ_0        20
>  #define VERSAL_CANFD1_IRQ_0        21
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 796b4911a02..c513d28c8d4 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -47,10 +47,11 @@
>  #include "hw/intc/arm_gicv3_its_common.h"
>  #include "hw/intc/arm_gic.h"
>  #include "hw/core/split-irq.h"
>  #include "target/arm/cpu.h"
>  #include "hw/cpu/cluster.h"
> +#include "hw/arm/bsa.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -674,11 +675,12 @@ static DeviceState *versal_create_gic(Versal *s,
>          }
>  
>          qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
>          qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
>          qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
> -                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
> +                               GIC_FDT_IRQ_TYPE_PPI,
> +                               INTID_TO_PPI(ARCH_GIC_MAINT_IRQ),
>                                 GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>          qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
>      }
>  
>      versal_create_gic_its(s, map, dev, mr, node);
> @@ -699,14 +701,14 @@ static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
>      /*
>       * Mapping from the output timer irq lines from the CPU to the
>       * GIC PPI inputs.
>       */
>      const int timer_irq[] = {
> -        [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
> -        [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
> -        [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
> -        [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
> +        [GTIMER_PHYS] = INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ),
> +        [GTIMER_VIRT] = INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ),
> +        [GTIMER_HYP]  = INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ),
> +        [GTIMER_SEC]  = INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ),
>      };
>  
>      has_gtimer = arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_GENERIC_TIMER);
>  
>      if (has_gtimer) {
> @@ -717,13 +719,13 @@ static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
>          }
>      }
>  
>      if (map->gic.version == 3) {
>          qemu_irq maint_irq;
> +        int maint_idx = ppibase + INTID_TO_PPI(ARCH_GIC_MAINT_IRQ);
>  
> -        maint_irq = qdev_get_gpio_in(gic,
> -                                     ppibase + VERSAL_GIC_MAINT_IRQ);
> +        maint_irq = qdev_get_gpio_in(gic, maint_idx);
>          qdev_connect_gpio_out_named(cpu, "gicv3-maintenance-interrupt",
>                                      0, maint_irq);
>      }
>  
>      sysbus_connect_irq(sbd, idx, qdev_get_gpio_in(cpu, ARM_CPU_IRQ));
> @@ -845,17 +847,21 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
>  
>      has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
>      if (map->dtb_expose && has_gtimer) {
>          qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
>          qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
> -                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ,
> +                               GIC_FDT_IRQ_TYPE_PPI,
> +                               INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ),
>                                 GIC_FDT_IRQ_FLAGS_LEVEL_HI,
> -                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ,
> +                               GIC_FDT_IRQ_TYPE_PPI,
> +                               INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ),
>                                 GIC_FDT_IRQ_FLAGS_LEVEL_HI,
> -                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ,
> +                               GIC_FDT_IRQ_TYPE_PPI,
> +                               INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ),
>                                 GIC_FDT_IRQ_FLAGS_LEVEL_HI,
> -                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ,
> +                               GIC_FDT_IRQ_TYPE_PPI,
> +                               INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ),
>                                 GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>          qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
>                           compatible, sizeof(compatible));
>      }
>  }
> -- 
> 2.50.0
> 

