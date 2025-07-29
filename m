Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3759C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 22:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugsR1-0005E8-Ni; Tue, 29 Jul 2025 18:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqVU-0001gJ-TP; Tue, 29 Jul 2025 16:01:14 -0400
Received: from mail-co1nam11on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2416::61e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqVM-0007zw-LV; Tue, 29 Jul 2025 16:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQGmiKJQxQOf+80MY+uWuIjZymvtys8+4Ch4AN3Ihtma9nlQYBhdDUG+vRwvXT/TaA97H/ImclDjdKp0oKN6CjySE8HfvaSRvyyM3T/Od0//XoGsXlAmNz6cyQAU15fOOau2RqEQ3hc9Gw3rWQcp+9yINZk/1F3ZvgKFfRaT+ILn/t/DpxGsbQIMwY1NDNCpTeCp1MSfXX/Hr+DEK6ZJCBLyFCspQaJzzdU4sddziN7oRTkRBCmXFirdJAJy/1aoO7UHQNX7Y1hy/GIDnAe1IS3tk6xfcbTBcCAvaAkic7Yzc2ZHx2b+QA9yZ3fqtzsu2F7qcH5m2hSJZEfbg32YLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VczcVELWEWbBsF+Noqr8FJqTY8BC0KXmhM5GZOHDBLQ=;
 b=e/7YzBrIJEe6bHae7DWVb771/ho2QCVAQ0QMuJyOwwgFzMLPAbGhGArFYkA4yk3mmYTqCvBO58S6cbywyyveST3/4wBaTPlFlTDEJ4vPklkFXQB3Ad2DrZMOeMY7ieuY+NScpiB4erUs+nWyfZ2SJXyPjcmeOO/QGQd7fviGqVHjhRR7ywnU/iRME53WyEHxj6L9Ccfydvtt1i0rumLSGy4KyUqcoNHawupCplzDEp6hqJPehpUJUpp7NkM7/uhr1Gq8tbgqhNUcq78jFZigXqCqQRzK+EP+6qMZXVAVNY7MEGWV+nsMRSjPv8cXJwauVhZOC2BUO0f4sFpgvEevWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VczcVELWEWbBsF+Noqr8FJqTY8BC0KXmhM5GZOHDBLQ=;
 b=ZtzGlqh4wIc37MhUiPdebxec4HwW7JxOK+0cjur3oPekaRlTWggRfZ8O/l00ooo+eL2EORyRCTZsD1NfPtHSw8EV83/lbiJQvmprg8CLz6Qs4L51Db9CC+TSJHjMKWp40z99/xGRuWoFKhmtbb00fZ3JJ91mM9AW+6uDFW02a8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 20:00:46 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 20:00:46 +0000
Date: Tue, 29 Jul 2025 22:00:39 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 19/48] hw/arm/xlnx-versal: crl: refactor creation
Message-ID: <aIkoZ2zhA+kiY1bj@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-20-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-20-luc.michel@amd.com>
X-ClientProxiedBy: DU7P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::10) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH3PR12MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: 773c97bd-d91b-42b7-315c-08ddceda9b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjNwRFF3K2xiNmpValB4aGw1NUxKQXdpSlpNU3FPK09wakpCak1sU09qeHRN?=
 =?utf-8?B?NXd4VEVxWjhwVk1paVp5Z216ZG9oeEZ6S1JrbjZXWHNHc01McE9qblFkTk9T?=
 =?utf-8?B?RVdCZlAvN01MODRGanRHSkpMbDJ6WmdodkxNK0NwT3RiVzg2Y1M2VW0rN3Fi?=
 =?utf-8?B?UEFieldzT2tFQmQ0YWRld0Y4ck5KdENUeGxZb0FQY1M2cVFHV3ZyTXMyYTYr?=
 =?utf-8?B?SEtjbXk1c1Nvc3QrQkpQRG1SWkFqY3JNRk5iZ1pYejUwdWZ5VUZiKzBaeCtD?=
 =?utf-8?B?aVp0cTNVK0gzaS9uYUpDUzZHZmtTcTRSMVJ4U28zaGk3NHpPaXIyNUJvS3Vj?=
 =?utf-8?B?amdkb3Y0UitiMUlDa3BkeFcvQ3YrQkYxaXFKRDZ4VENmY2VhS21aZTRkK0pI?=
 =?utf-8?B?YWRaZTZNTk5ONDNhWGI4T25RNDFMcUNXbi9EQ2JLcWNvMldzcFZyT3JaMEZh?=
 =?utf-8?B?VlhBRVFyR3BFMHB0V1BjcDlVVFRHNE8xVzZkZWh4dlRPVzRXaUowNkIxa09x?=
 =?utf-8?B?aDJBMmVJQWQzZ1dMZ1FuajdCK1NaanlnM0h4blFsTWF0bXZiQlZxR0ZFVjFz?=
 =?utf-8?B?L0VJUE1Dc3hYNnRXb1JCclQ0U1lhQVdQcnRnZW9xSzlUekhJNFkxb0xZRnRP?=
 =?utf-8?B?Q2NUYUxKOHpqNzJnRkxZRCtZaThQUklOVFo4TTcxbDFUZWFINCtZYU40Yjkr?=
 =?utf-8?B?YVozV0dqaUFlTUtnRndSaEpaQ0RLWG16MFhiWFl5MTIvdWJVVHlJdXA2V2JZ?=
 =?utf-8?B?WE5pQ2NZZTRqYkJhc1BKUEJCdjNOcE5zMldoTDNFUjJya2tmNEN0UjM5aVBR?=
 =?utf-8?B?RU5jZzd6dS9ZaDBVeEk3VlJGcGVNQkpQWjFOazZCZW9YWExJM0RXZ3k1YnZh?=
 =?utf-8?B?cGtVMmFNS1U1WTVDQWV5NHlqTjZLd2RuVElOZ2l0bHNZdlhBbGpBQ0FFVlpq?=
 =?utf-8?B?RWk1VjJqajh0byttOGpMS3luQzJvcDl6N1R3R1pjZjgyRGQwanJnZFlHSXdw?=
 =?utf-8?B?TVNlakYxSHZMSXZvQ2RwcmhPRWdYSTA4cHVHN3FIY1Z1ZThrYzdCOHorcVNV?=
 =?utf-8?B?Y1AwVFlvVXBPQit3VzBOZWdLOXlwckxMdEdoVThKa21JdDRLWjZiRkRDTzBZ?=
 =?utf-8?B?d2hqa1lzaWdaTTlvZlRZMUdKYVNmMmxMM3ZicmhCcXdhdC9MNTB5NysxQ2pT?=
 =?utf-8?B?SkM4V3o1SHZ5TzBmRmFSTHViWnl1NHBBbFYxU1JRakhYaHp2c2RMT1M1L0dX?=
 =?utf-8?B?YUc1ZVRuY2l0a2haZ0QrSzAzaHZkenl2KzZSNkZTdEYwckIzK24yU3QwTGh0?=
 =?utf-8?B?eTJGQWVEQ2xlbzNYWU8zM1dMVlJsOWZwMnNOY1d1OTNkLzFKdGdGd0NzQzJM?=
 =?utf-8?B?bVpETXNlUHdKQ2RDbk8rOW0vL1A0M3VvK0FWOG9EQmNjeVR3MVBPaEhzZ29D?=
 =?utf-8?B?WVU5S3UvaWtKaGYraklBaVlhNnNROWlRa0J3aWxwTFFpMXJFRTJra3h1Z1l6?=
 =?utf-8?B?TE1jT2E0bEpiNy81RlBmR0hOUGMwS09NaEdvUE9jZ0c4RzZnOTlaZW5yMmNp?=
 =?utf-8?B?bjBUTXZJa2ZoUVkvSEdWbTRidmxJSkVROWswUVp0ZUs3cVkwblBIcFZ3M1Na?=
 =?utf-8?B?azBtK3pPY0o3ZHFBZ1VQUFY3Zkc0cGVxbWpFdGJ0L3ZsTWFNTUMvbjhWTC9q?=
 =?utf-8?B?TGUyRVZNS0tQSkJHbk1oNTZ0WVBqTFlIYjdKaFpKU01hV2VzWTl0S0RUZ282?=
 =?utf-8?B?TFU2NXpIcTBiQ3ZNcjN5Y2hQbERScGVRb1dxRXp0TzFOQldlZVM5RXRXTDht?=
 =?utf-8?B?UTZQdjNLT01OYUNVSUhuNUFtczNsR1dvcjR3VzUwaE5pcXBDZFZGU1JpMUlh?=
 =?utf-8?B?MUJSNzltSzhRVFRzY2NrTHhMVFlNbnNWMFFzQ01DdHl5cjAxZUhJQUF6SURo?=
 =?utf-8?Q?jHvCBLr19k8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGZnTTRWS24vMXF6d1E1aVdTMERyNUlDSFdySGRBR3grM3laY09kaCtvRmx5?=
 =?utf-8?B?cU5DNGZyR0NxcjlVdjlURGM2cWIzK1BiUFFhbjd0cEZKcVhZRkVBYTEvazc2?=
 =?utf-8?B?LzFkd0JBMGNsbTlZMDNEZUwyZndITDlteE5tZ3R6a00xN3VaaloxQ0JRL0I1?=
 =?utf-8?B?OVpwNHNnWGdzNzQ2VWk5ZE1hVWtyVit1azB1bFMvY0pYNVBQNXNFTkFGdHBq?=
 =?utf-8?B?MXlCZ20waXo3T2tOSTlGUlpPVy9UUFVxR0lNdGludzNVRVAvWWdtZVNyUklr?=
 =?utf-8?B?UmFhczVwM3lRMWNiU1Q5QnFyNkNhNVptcHViNlZSTUd0NFBCYnppK2dHSmkw?=
 =?utf-8?B?L3YrSzV5RnU4c2dsNUpjMGxJODlVWjQ3RGlIZW55dnQwMy8wYnB6YkdSRVpK?=
 =?utf-8?B?ZzZyN2wyMERmY1FyRE0zUlE5a3BIM2R2V1JTdzFCUitLeTJxMWxVUHp4SnZL?=
 =?utf-8?B?bE1IKzVkZXhCUGdKdGNKNE9kSWhUOHViV0lXSkZCbWpwZENJdVVnWlp1KzRv?=
 =?utf-8?B?QW9CL2dtTFhKUFZzcldjMkE3bE9UankwenczZk5wa3MvZTV2cVF4eDRoWmE3?=
 =?utf-8?B?bENrSkgyWnduSE5pNmp5OEEvRElKQWRmM3ZySU84NXdrL3hIR3JqemVhVzdD?=
 =?utf-8?B?WjNUcmU0ZElaWkV1bld5bEVlRitjTzViMnV2MnFwVzU5THAyMXB1QjdvZEJm?=
 =?utf-8?B?R3FRVHd5WERnUDJWZlpCSmtpRk5sN292aUlZb3dSNTdTQ3lOSEw2dUFUaVVy?=
 =?utf-8?B?MnBxdDhlSDlxa3dPaHdjeUhPYWlrNUQ0NFBJQ0ZacTFMblJ2MTZlczhRd2du?=
 =?utf-8?B?YVY2cWlVSUlmU0UyeDFzMDdHWDlKdXpYYTFyclpTZUdFK1g1K3BsRmtMWXdZ?=
 =?utf-8?B?dXAxcVVraVZocCtCN1VhZzl1cHVDUlFIMVl6dVNaZ0VQRFdZOTRkVFdXU0Vn?=
 =?utf-8?B?QXUzTGpVbXNWVDJTTGZ0R1ZEdlZCNVFrZzZyTEF2YVBpMlJsOStmK2tkeGRv?=
 =?utf-8?B?VUEyTEZVbmYzWTBVUEN6VnpobXhFUHBlb0QvbWlKQXgwWHJjUENjak16MTFh?=
 =?utf-8?B?RHZubnFiVklqVUk0dU1ERllFNE1vZlVPeVZYcWRKcGc4RzdmMEJDeE1zZDkr?=
 =?utf-8?B?bVdtVHZVR2lBQks2Q29XcFlnRUZaMVhPVzZicjFiSEdYSjBLRFZpc0w1YVIv?=
 =?utf-8?B?TWVKbk9CZXlOUk9OeTVOS2JHUHN5bmNTZGZJc1dBL1JPbmh3cDNXcUFkaCtV?=
 =?utf-8?B?OE94QXNZS0pzejhTZGZoZS9pTFJMMGlCMm1ZbzZLM1l2U05mQzBDVXJZVjVI?=
 =?utf-8?B?aVFNcFR3cVYyRUxyTVY0ZHRreUFNVHVub1I5WFNnTjVUOElkUHJhSFRrU0Fa?=
 =?utf-8?B?Q2gzN0dZQVJZZllJb0NueVpnTGs4ZlhrbkJRTjlVaVQ0VmlkMWplcWpmZVFa?=
 =?utf-8?B?akhKcEdFa0ozMHp5cGI1TjJiMDFVdGNFbnZ3TmFBVUJ5RElSeS8zY2dvdzQ3?=
 =?utf-8?B?V0NySFVubHFiMUlRNlF4ejBUUXI3Z0NsV3VFdFFOT29DT1JKV0dtOXlQWUxM?=
 =?utf-8?B?a1QrS2JseDVYRWZlOXZzMUxiUjZJelIrREVkMHN3RzREZk1RQ0dTb1huV1lY?=
 =?utf-8?B?Nk5WQjloc1plN3Z2MnVtbk1qYm9BSU16aGtSQkllNTAxYmE1cXdhV09KS2lk?=
 =?utf-8?B?VXE4THIxZ2R0QWRpSm1CL09TRGdnS1B4Y1pSUGRpSmJoNjBlSGNNelVJOC83?=
 =?utf-8?B?aHlSL0ZkclJDVzZWTEh0L04zVXRNakl5MEpUbGVmbUptRFpka0dMdGRZTTZv?=
 =?utf-8?B?Smc3UDl0TjBsNlA2M1dESENsN3Y3VXdLQkxXN3N4K1liRUJ2ZjJJMXRoZGNi?=
 =?utf-8?B?RGtJT1llc1BtSGIydVVlKzZqS2FxV1kxaHVuSVpyQlhKWWtBamQzckdOV2ZS?=
 =?utf-8?B?MXNWUWhWN2UrQmRjY25UYnBtOGxBK1JMbEZrWnVUY1pzWFJZTnJIUWdtWGpz?=
 =?utf-8?B?aGt6Qnd5blVhL3E4VnQ4K0Fqb1lUbjJyREtWZ1psSWh0eHZXUXZScE40ZGU5?=
 =?utf-8?B?RHQwWFdFUDVUM0ZCblBWVTVNVWFtM2hHUWxodDJwU2NwdC9EVDRRMW5qUVhp?=
 =?utf-8?Q?FUlFDqaygC0iOkPxDsPKDRjBo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773c97bd-d91b-42b7-315c-08ddceda9b6d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 20:00:46.4262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/RSyMr0rosEs7Dj4ahwmGdjDz+6Yev+OzhZaY7lt1wTSDFUZrBZxD4jS8aQSu7V/wY2G5T7Yuvsg23wFd7KIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146
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

On Wed, Jul 16, 2025 at 11:54:01AM +0200, Luc Michel wrote:
> Refactor the CRL device creation using the VersalMap structure. The
> connections to the RPU CPUs are temporarily removed and will be
> reintroduced with next refactoring commits.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  3 ---
>  hw/arm/xlnx-versal.c         | 36 +++++++++++++++++++-----------------
>  2 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 5a685aea6d4..d3ce13e69de 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -15,11 +15,10 @@
>  
>  #include "hw/sysbus.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "qom/object.h"
> -#include "hw/misc/xlnx-versal-crl.h"
>  #include "net/can_emu.h"
>  #include "target/arm/cpu.h"
>  #include "hw/arm/xlnx-versal-version.h"
>  
>  #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
> @@ -69,12 +68,10 @@ struct Versal {
>              MemoryRegion mr_ps_alias;
>  
>              CPUClusterState cluster;
>              ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
>          } rpu;
> -
> -        XlnxVersalCRL crl;
>      } lpd;
>  
>      struct {
>          uint32_t clk_25mhz;
>          uint32_t clk_125mhz;
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 2128dbbad92..ff55ec62301 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -40,10 +40,11 @@
>  #include "hw/misc/xlnx-versal-trng.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "hw/or-irq.h"
> +#include "hw/misc/xlnx-versal-crl.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -149,10 +150,12 @@ typedef struct VersalMap {
>          size_t num_cframe;
>          struct VersalCfuCframeCfg {
>              uint32_t blktype_frames[7];
>          } cframe_cfg[15];
>      } cfu;
> +
> +    VersalSimplePeriphMap crl;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -213,10 +216,12 @@ static const VersalMap VERSAL_MAP = {
>              { { 38498, 3841, 15361, 13, 7, 3, 1 } },
>              { { 38498, 3841, 15361, 13, 7, 3, 1 } },
>              { { 38498, 3841, 15361, 13, 7, 3, 1 } },
>          },
>      },
> +
> +    .crl = { 0xff5e0000, 10 },
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -1106,31 +1111,28 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
>      sysbus_realize_and_unref(sbd, &error_fatal);
>      memory_region_add_subregion(&s->mr_ps, map->cfu_sfr,
>                                  sysbus_mmio_get_region(sbd, 0));
>  }
>  
> -static void versal_create_crl(Versal *s, qemu_irq *pic)
> +static inline void versal_create_crl(Versal *s)
>  {
> -    SysBusDevice *sbd;
> -    int i;
> +    const VersalMap *map;
> +    const char *crl_class;
> +    DeviceState *dev;
>  
> -    object_initialize_child(OBJECT(s), "crl", &s->lpd.crl,
> -                            TYPE_XLNX_VERSAL_CRL);
> -    sbd = SYS_BUS_DEVICE(&s->lpd.crl);
> +    map = versal_get_map(s);
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.rpu.cpu); i++) {
> -        g_autofree gchar *name = g_strdup_printf("cpu_r5[%d]", i);
> +    crl_class = TYPE_XLNX_VERSAL_CRL;
> +    dev = qdev_new(crl_class);
> +    object_property_add_child(OBJECT(s), "crl", OBJECT(dev));
>  
> -        object_property_set_link(OBJECT(&s->lpd.crl),
> -                                 name, OBJECT(&s->lpd.rpu.cpu[i]),
> -                                 &error_abort);
> -    }
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
>  
> -    sysbus_realize(sbd, &error_fatal);
> -    memory_region_add_subregion(&s->mr_ps, MM_CRL,
> -                                sysbus_mmio_get_region(sbd, 0));
> -    sysbus_connect_irq(sbd, 0, pic[VERSAL_CRL_IRQ]);
> +    memory_region_add_subregion(&s->mr_ps, map->crl.addr,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
> +
> +    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
>  }
>  
>  /* This takes the board allocated linear DDR memory and creates aliases
>   * for each split DDR range/aperture on the Versal address map.
>   */
> @@ -1327,12 +1329,12 @@ static void versal_realize(DeviceState *dev, Error **errp)
>  
>      versal_create_bbram(s, &map->bbram);
>      versal_create_trng(s, &map->trng);
>      versal_create_rtc(s, &map->rtc);
>      versal_create_cfu(s, &map->cfu);
> +    versal_create_crl(s);
>  
> -    versal_create_crl(s, pic);
>      versal_map_ddr(s);
>      versal_unimp(s);
>  
>      /* Create the On Chip Memory (OCM).  */
>      memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
> -- 
> 2.50.0
> 

