Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E04EC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaow-0008B9-D2; Thu, 31 Jul 2025 17:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaOk-0006iB-L1; Thu, 31 Jul 2025 17:01:13 -0400
Received: from mail-co1nam11on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2416::61e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhaOi-0003MD-BS; Thu, 31 Jul 2025 17:01:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VceLuVN+AH60qWl9lqPDOEhGzpWG3RLIKgMOxD144UOgDHPYZmjZf7IclkwuY0Taf8USTfYGXYyvw+P89YewmGFypkXJsU32N+iimk68+NDXW8JqPRy1GhHYa/fE+KcSmP+91roFqpaq3/GaLrA6Ab2SneEW7RAudnAbX+ezffru59ACRgR7UQKeKnyCNkdynSMsDz6P15bvadwgrBVAOV/Pc3faFQuJ6w5/2z24FoQnOdtlifIL0Y1962Ddv3ZrqJD9997tlwEf3Y99/4hk4sxP5glJGLTMcCHf74Pol57LpU2GQKxVuko9rpoeqC6DfOF2pVVsxHkaE/FkNPuOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqllCcM7A+l9xjJumFGAkteVkDaB8Cjk5t4fakaqLV0=;
 b=wc8lj9I0ea3dcaBYiO3WuNcAqBTHRU9bdEH85DDyjFinqUf6Oth52jQWMsmn4Qd+uDKDKcMMjTpCEfc0hVA/XvThcPaD9G1XQAxMzaj//VExbVjstpjS+yb7iIsv77FDOFOahcGm22Jpi4+AFwaqAVTQQE5+rhOeAFExTTrdACx1AH91OU0UJe3OH3IGBldFJn3kEgYQDPBVVvQvmVhyHipIZevgaWVPPW7V/NPUS0Rq+XjsyDZoWzxEzMGDlBKKaFauR7xQkyIbXSI4NCqxhMCMcqBkDMPX1z6fXc+JIbuPT+YbeYoP55sVvuVrJjORZTnoUItrXBd5V7wzxQa9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqllCcM7A+l9xjJumFGAkteVkDaB8Cjk5t4fakaqLV0=;
 b=3ZHgsOH6Gh4veGiCo56k5tLQiCMGr8ipVML3BUCjkc4yKLlbqCVbntnxPYy2mnATGl0wvuhrYF/ZBaMIbzqxlJVfDySznKxJ4bqKIPvNMq1Tyvz3Dab4x13of3muw+3Z5gSlYv4VkWa6uqGSAse8St90jlWeKcIiu/9hbvdAFJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Thu, 31 Jul
 2025 21:01:01 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 21:01:01 +0000
Date: Thu, 31 Jul 2025 23:00:55 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 44/48] hw/arm/xlnx-versal-virt: tidy up
Message-ID: <aIvZh0GHV9PxSIhp@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-45-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-45-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0378.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::23) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0bbebf-c995-449d-2c01-08ddd0755b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3B1STc0L2NTUENCdlE5MUcwYkhENVR0Sjg3K1lZODA0eVAzQXdlLzlJSURB?=
 =?utf-8?B?cTQvTDhEb01DVWZ2QVgxUEVoS0NkczBGRVMzelFqTkVVZ0tqemR1a1puWEw3?=
 =?utf-8?B?UmhoWThPVUhobEV4dUcrNW1LWG15SnV2VUkrTGl4R05lSkdybEVaZE9FVFJs?=
 =?utf-8?B?TjU4WjE2bVl1eDFkRkh3S1Rkbk41R1ZuTTYyVmRQMkdsTTJuZHhwLzRMejdr?=
 =?utf-8?B?ZUdMMGc1SWYwTWdwV3JyVm1GazVwT0M5dWEwbmRMbjRKQ3JMSml6S09tY293?=
 =?utf-8?B?OTBrSm9GM1VoM01ZVUU5V1o5ZEJCdmdpTWhER2JEbVZNSnhCSC9QUWVyckR2?=
 =?utf-8?B?TkRHVHlmZGh4c0crdWF6SlFqM24rMjJLRFhRMWNGcUY2Ung0cXFTU2Z5a2xt?=
 =?utf-8?B?TVlRM05PVXpmOUlwd1dheVkyV044aGxNVno5UGZrSmZMZ1Bkekcwb2x6OEVW?=
 =?utf-8?B?dkNGZnN3TjRUOUliRm55QlA2THRBQXFvYmxWeFVZUVlkK0xDUEd5dVRBcUpU?=
 =?utf-8?B?WnY4K3RzUjQyU2dQNGthZEhVcGgybUVVQmUySmFoTCtLcVc4bWhRK3poMzZp?=
 =?utf-8?B?Q3R1TjdTWGZVZmp5MmVwQWZyaHM1bHN3ZGFBWkJKYTNuTnp3RFd4VERiR2JD?=
 =?utf-8?B?WGpEbkI0L25kMlJPbU5JeVVCMG1aZXp2d1dUeE5PSUd4dzZXa2d2aFZrVmth?=
 =?utf-8?B?aE5YdXBDS0JURUpGTlhCd0YzYzIreGZjSmZmQVlqdTc5RHhSVGNxUlVxM3dI?=
 =?utf-8?B?b1d0a2IwWm53cjRKVEpuN2toNkRPUDFIei9EaW91T1dJOHpKdXRzRC91SHhD?=
 =?utf-8?B?dENONVptNGQ4aC9JN3RYd3FvTjVzSjRoR0tVNkJVNzVUakNhTFdPZDArMitB?=
 =?utf-8?B?MkhxU2xFemtlL29VdWhGamU3T0V5cGR6MWFuSlVMbDZzY2lHazUxcGQ5NW5J?=
 =?utf-8?B?YUJWVFJMMlI3MmhoOWRqWkM4Umh6aEIvQktUbHp0N0tndzNkWjFNS1pxWUtr?=
 =?utf-8?B?NlV5eTZhQVlRN1hUeHpJWnZIaVU0Vm01L29BeVQzeUxXRG1Lb2pEc0pOOXVm?=
 =?utf-8?B?dDhqWHEzbGhTVzh0R3A2QURndVJ5cm1uMnBncFVFa1pmUnNoV3ljMVZyRysr?=
 =?utf-8?B?QldnYk14SGRZKzdnbHppRnU2RjAzMnhHTGhPWHVEVzduRXZvMkVQazlwTXVt?=
 =?utf-8?B?V3pqNkZtWE9Za3VRYm8xQkRzdmNJVlhoTWJGRmFlWXlFNzhvMi9lRVhLUFJ6?=
 =?utf-8?B?Y0J2aEQwZ2V2OUk5Uk9KeXViMkVGL096WFRRQ01Vb1doT2xPZGhhOG1aaGFG?=
 =?utf-8?B?WllRREFUa2QwWXBzZ01IOG9Oa3VwUHBOVERxeXBhQ3pEa0h2UUtRUEcrTkVs?=
 =?utf-8?B?eWdsUE5WeS9ZSlRSZGV6TlRUcHpqc3ZsUElvcjdycmVPVUNrWHZ3ckZ2bnpT?=
 =?utf-8?B?dmZNK2VxaXg4NExHQWxMclhrdEpWdjA0aXRHTnkzd2Mzc0FiM3BIZGtHNmxj?=
 =?utf-8?B?UzBZL1U1OS80bHg5UXd2UU5oaVRPSWdpaTgvMWkvSUpIUUZDdnJJV1ExWVR5?=
 =?utf-8?B?WjNmWHdhUHE3Wlg2UCt4VEhOUjFucGVyQStaT1h4T3hVRjJhN2ZmV1ZoL0VQ?=
 =?utf-8?B?QVNtTDNoQW5YWWRpd2tjeHdOelFTS2pCY3drZFkwV1pPbG1aS2NFR3ppMjQ4?=
 =?utf-8?B?ekRaUXlWVmNGdlpjdDIwRlhldkNRaFpSWldrYUFhaThmZGJUa3lHTFExUFow?=
 =?utf-8?B?UDJSUTJYZTNnS0dZY0lyR1B1TGE1QkZxSE9RUjRVZHdETmk2aVZrb0Rya0tx?=
 =?utf-8?B?NmVwemUrQ1NMRWhSL2tNQXZVUHVURkVQV01xZDNqNUx3bkI2bG9yd00xdzRu?=
 =?utf-8?B?UTVwaEZFcCtMOU9zOWEzUE50N1JjeHdCRkNQZmFLbzhPTGR4bkhPUTNSbkJK?=
 =?utf-8?Q?ho8SG3/J+t8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ArQUY5WTZjUDdBdmM4R3h4Rys5V0N3dVJYY2lNL1dNcGVseWd4cW9mYWU5?=
 =?utf-8?B?VmJ3dzFhUy9Ha2R2bEJnU0JqQkdLNW5FaTJhdWZsNzd2MDBZaVBoZ1ZrNTJI?=
 =?utf-8?B?Nk9JeEs0MDE5SEZSRElMWm03UFJzSk5aaFdmY3NIOSttMm9zeUIrajlpZjZD?=
 =?utf-8?B?QjR6ODR2Z0lKNVBobU9KWS9jKzBKaytYTFU2TkhjMm1ZSVlyTUhFK051cHg1?=
 =?utf-8?B?SUduZ09ESGFvREJoVVJlTVNGUVJHbnFpbXJDRUVoeWwvOHhwV2JsL2V0UEhD?=
 =?utf-8?B?QWtGVjZuZFdseGxnNkg5MzVtWCtYZ2tNS2dkMENSQ0ZEbUlKVlNYejVZMlZt?=
 =?utf-8?B?Nm95ZitkeFFhK0drazBFQURCY1JhWEpJb2V2cnVBL1NLSFc4R1R2NCtLZ2Np?=
 =?utf-8?B?RW5PdW9Fc29uQ3JueGxib3pqWWlYby82cUVuRWVLejBKaW5hTStsSkg1b1lW?=
 =?utf-8?B?U0Q4UWlvQlgycDFGdVFzaHBQcGRKZVpwVi9FM2FJczV2RW9wNnYxZFlmTmtp?=
 =?utf-8?B?d21ud0Y3cHh0NXZEbFY1ZzBXN3FaUzVmY3RjNmVrcXJScGpqS052TmduV0J5?=
 =?utf-8?B?SUk5R0RycG9EaHVTN0Jub0NHckxQeUU2K0NaOERMYmVKKzVqK1pWekFTQnR2?=
 =?utf-8?B?OGxOMlI3MEhraWF5dE9qOTZyZ3l0bnZtL25oRHdPRmRhcUh3WHdXRUdyRHZ0?=
 =?utf-8?B?K1BDN1ZhSHFwWEF5T3A2UWpWL3h3MkNaTm5kdVQ0MVU5WjFsL01yMTlTSHRH?=
 =?utf-8?B?MUl4cUZkd0pVdmNJeGU4VVpZSlIxK0FEenc3ZElMV0F6cFUvQUR2QjViNVoz?=
 =?utf-8?B?aVpaTThqV1NHUVpHUTJzUTNvR0dDbTl6NWpxdXhBbHk5QkpDcEljSDU0TkhG?=
 =?utf-8?B?MGlKeEg4ay9LMGFSdENDbjlnWnJGZm5wN0JkSmthNjkyU2RiK2JYRHBTOW1u?=
 =?utf-8?B?aVdFQisyVFBzWWUrYWtQdWE4ZlkydFdZWCtRZFZUWi85RTBGQis0T202V2V5?=
 =?utf-8?B?blQ4MTJPRGRlbitFblZDYWR5dnk4VHJzdXdFVHpmTC9GTlV4RXBhbGZkZ0Qx?=
 =?utf-8?B?Qm1hK29kOVJvdnR2aWpET2xob3luNlJiQy9ZL0l1aWZwTGNVdTR5VTVOQ3g4?=
 =?utf-8?B?TGlHMXhpeWJ3cENkd2VSTkpoUmpLeVZQU3RLQWE1bG5vQlR3Rzk2QlFnb2p4?=
 =?utf-8?B?N1d0SHR1Z0tKWmJzTTBQNmhoeFVTRU9PeEY2Mmc0M0l4S1VPV2VQSjB2VW1L?=
 =?utf-8?B?bldFZGFmM0hNc21QbUsxRTBIK1BtTWFXeW5rMFJVTWJxajNUc0lPZURtWGpX?=
 =?utf-8?B?WTc1Nnk2SlpoeFlibXVZUDV4b2FMVVFXcitLWGFqNG9ja0I5b0diSEE1a083?=
 =?utf-8?B?TGNuYmVNODh5eE5mS3BjOGV5MktWclBaTkwvSW5HdDgvUDRYSzZvRzJCaWFq?=
 =?utf-8?B?dDdja1RQd09jUUh1a0JtdnZpcUFaMDNrVUJLd2NBZlE4dTRtOCs2R3BtWlRV?=
 =?utf-8?B?Ry9EMlAzTTByNlVHYkF4THRIUWkzbHU0ZnpWWE5UOEVJTE5vdWY0T0drTnNY?=
 =?utf-8?B?VTBrS0dNQUdBb093R0ZEdk1rM3NZZjBNR1hFbFVWdWZuNEp6SnZhbDgyNm1s?=
 =?utf-8?B?dUNyWndrb0lpQnhPU0toL0RFRnl5S3UveXVud0RKYlZzL1pRSmF6ZnI0c1lH?=
 =?utf-8?B?Z3Vwb3Z5cGczSEs0NXdhWWplTHJQZXppc2VJam1VaGZhamQ1VytyRjlsSEJE?=
 =?utf-8?B?QVplMVdHNU9OdVF6YnRLVVVGanpldHdyc05WZERBeFpXSk8xQ2FmS2xuc3V1?=
 =?utf-8?B?VENRSnVycFVibVc5Nmg1eE5RV2o0U3ZIZXMzcjhkbVMvdzBhL01wczJEbXRQ?=
 =?utf-8?B?eklMdDgvSjMvU1FTd2tveGcyeHFDcHJwTDFPSFRpekhlaE9HdDlmZkZ0RmE3?=
 =?utf-8?B?TzNOR012emZuYy9WNlJ0S2FEbEJOWWorcXJTdWFPVVdpd2JZVDB4YkxkUzdo?=
 =?utf-8?B?YWVOTk05RGdxN3VrdkNDOE9HOFFmTTBBOEZra0REWStHajNPVGFpSUY5cFJQ?=
 =?utf-8?B?ZDROczIraksxclpqUG9uZ0FBc1ZmOTBXQ0szckxnSjZRQ2ZNallIYjVoUGFp?=
 =?utf-8?Q?RQb9RyBNVpTvc4h1LQsWS9gCS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0bbebf-c995-449d-2c01-08ddd0755b13
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 21:01:01.6072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VmR/50llir60dUiPmnrM2J42SO0sf1dUJ9RN1frGmsk8bTwnCTUublW94ldzWVDU/RlgLvkW9UcUEmtOr8DyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
Received-SPF: permerror client-ip=2a01:111:f403:2416::61e;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:54:26AM +0200, Luc Michel wrote:
> Remove now unused clock nodes. They have been replaced by the ones
> created in the SoC. Remove the unused cfg.secure VersalVirt field.
> Remove unecessary include directives.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/arm/xlnx-versal-virt.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 9b20aef8b07..154ed7332c3 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -17,14 +17,12 @@
>  #include "system/address-spaces.h"
>  #include "hw/block/flash.h"
>  #include "hw/boards.h"
>  #include "hw/sysbus.h"
>  #include "hw/arm/fdt.h"
> -#include "hw/qdev-properties.h"
>  #include "hw/arm/xlnx-versal.h"
>  #include "hw/arm/boot.h"
> -#include "target/arm/multiprocessing.h"
>  #include "qom/object.h"
>  #include "target/arm/cpu.h"
>  
>  #define TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE \
>      MACHINE_TYPE_NAME("amd-versal-virt-base")
> @@ -39,20 +37,15 @@ struct VersalVirt {
>  
>      Versal soc;
>  
>      void *fdt;
>      int fdt_size;
> -    struct {
> -        uint32_t clk_125Mhz;
> -        uint32_t clk_25Mhz;
> -    } phandle;
>      struct arm_boot_info binfo;
>  
>      CanBusState **canbus;
>  
>      struct {
> -        bool secure;
>          char *ospi_model;
>      } cfg;
>  };
>  
>  struct VersalVirtClass {
> @@ -70,35 +63,20 @@ static void fdt_create(VersalVirt *s)
>      if (!s->fdt) {
>          error_report("create_device_tree() failed");
>          exit(1);
>      }
>  
> -    /* Allocate all phandles.  */
> -    s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
> -    s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
> -
>      /* Create /chosen node for load_dtb.  */
>      qemu_fdt_add_subnode(s->fdt, "/chosen");
>      qemu_fdt_add_subnode(s->fdt, "/aliases");
>  
>      /* Header */
>      qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
>      qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
>                       sizeof(versal_compat));
>  }
>  
> -static void fdt_add_clk_node(VersalVirt *s, const char *name,
> -                             unsigned int freq_hz, uint32_t phandle)
> -{
> -    qemu_fdt_add_subnode(s->fdt, name);
> -    qemu_fdt_setprop_cell(s->fdt, name, "phandle", phandle);
> -    qemu_fdt_setprop_cell(s->fdt, name, "clock-frequency", freq_hz);
> -    qemu_fdt_setprop_cell(s->fdt, name, "#clock-cells", 0x0);
> -    qemu_fdt_setprop_string(s->fdt, name, "compatible", "fixed-clock");
> -    qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
> -}
> -
>  static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>  {
>      Error *err = NULL;
>      char **node_path;
>      int n = 0;
> @@ -263,12 +241,10 @@ static void versal_virt_init(MachineState *machine)
>                                   &error_abort);
>      }
>  
>      fdt_create(s);
>      versal_set_fdt(&s->soc, s->fdt);
> -    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
> -    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
>  
>      sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>      create_virtio_regions(s);
>  
>      /*
> -- 
> 2.50.0
> 

