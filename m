Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68895C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1fc-0002Fi-Aw; Thu, 20 Feb 2025 03:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1fZ-0002Ew-DX; Thu, 20 Feb 2025 03:12:29 -0500
Received: from mail-co1nam11on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2416::62e]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1tl1fW-0006cE-W6; Thu, 20 Feb 2025 03:12:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiuX7CopJt4Cs8SLE+GkGjV/D1iEmWQzSzebk3AukwbzEQpBHtveQH3aost4PT3bWdwqR0u4e2QMvHE+DGXQeCJR0gVi8V5cu2aSiTJwZjH1ZiE/H1L848ALU214xxy1kNULGKOEe3Vu4X96UVBnRtYVd0zfwJcyBsu6RuI5LCgQLWrjw/hiPvTEUsItua0KKNDva2ANscJnPfQK+A9F4Uz064hB2dWM5qjsaLvdvc2pxYuGa/o0pxdnxbS6m23Gc0A8JGFp6caaQzM2i9fiTFBzl7BZCNFUWj+QlyrJKKo1oN178JmCnqIn4Gw95BPv8sFc2jFpUospPu2H5sjv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdUzK0kNMy+CsRafYa1CK5vShPOjW/jgI6X5DCe1YTw=;
 b=qvMFSaYA+Flc2Cun/rz/8Zy7ezz4MORF8Um79H3Tul9rQYJjs3HQZiejSzvkCAhntdjDJxMoBmT3Pf8VFL6tafPC9sPmeA/XAL75syTEiB238jP5TSV9/h03ZKnRFjCQG4eF9WGRJFax/RK3/oU8euUY5+S4+Ivl84oBnjVbyC4Zj1R9nRKY/I4CxCdKY7jQEQr8fM6dgeIY0j3Thxe3kamEkfCiFX2CsT5l/wotDeiMvCzuuZY9zc5jy6PIxnr79qCubXqWJSEloYEbUIVaoS+oYqan7qPZbp9s6jzkTqRn6nIaRBoDHCAdQR/nsW9hmCtXGLisw3bELEFz+NhguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdUzK0kNMy+CsRafYa1CK5vShPOjW/jgI6X5DCe1YTw=;
 b=h5OeDHMZ22w9JUuJ5h+1Sl3mD0mKrGglqRZr+toS/7Ut9Qtu+RB0UdfoMFxtDG+GrolmbGgpoKuaStguG+JPL4VK7GDtWCt6gNAaRbGLI+uKK5+bvqwT23CGE/rHcEzSFhlLKjClZnRZyMOPf5FzmVd6ScCQ5bCUSm9s+mPegyc=
Received: from MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17) by
 MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Thu, 20 Feb 2025 08:12:19 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::11) by MN2PR01CA0048.outlook.office365.com
 (2603:10b6:208:23f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 08:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:12:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:12:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:12:11 -0600
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Feb 2025 02:12:09 -0600
Date: Thu, 20 Feb 2025 09:12:08 +0100
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 <qemu-devel@nongnu.org>, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Magnus Damm
 <magnus.damm@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth
 <huth@tuxfamily.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH 2/9] hw/char/pl011: Simplify a bit pl011_can_receive()
Message-ID: <Z7bj2Dv8uyldHXuB@XFR-LUMICHEL-L2.amd.com>
References: <20250219210841.94797-1-philmd@linaro.org>
 <20250219210841.94797-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219210841.94797-3-philmd@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 404d0592-b9e5-4a58-c64f-08dd51864bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3ZmMStkd2VBMWI3aEowN3hHeS9PMlIvVVV3QmpCTmxUWmtEZFJGeHJMb0xn?=
 =?utf-8?B?eTNpT3VyNzlMU1pZbGdwa0VwTWhYbHd3aC85NUlDNVE1QlU4MzVWcTg1MHdS?=
 =?utf-8?B?dExpWEtoMGs2d2JpK2F5TDdLbmUvZXZkamRkTVFhWjV2L2hlNnRPc3Q4emt0?=
 =?utf-8?B?Nzc2S1gvSXYvQVlQMjRZQlRxaWZ4ZEg2b0NmcGFObGpSTGxxK01ZMVZPUGx4?=
 =?utf-8?B?TzVwSkc3RXk5N25GZWVRc3JVN3lhSHR4MVV3WGtZYWVMZmFXNW1uSm1pOVZE?=
 =?utf-8?B?SVBLa2pFd0FnbCtVMGFORDAyYzlsMUpJMkMvNFkzWXh4OUNMRkNBUGJ2VHZI?=
 =?utf-8?B?UFBWZnZQWkxUVGpwcHJubXg3dE9YTGgvWmhHWWVYQS9IMkNXQUNlVWFLV05Q?=
 =?utf-8?B?dTRLcmdhODJtR0wyRXJXcStRTUwycEJTZjMyaDNZbytMOEtwUUJkcWxtdEYx?=
 =?utf-8?B?RnNGbDN4Rm5veXorOWdJNThVWXVKOWs1V2ZBQyt4VEd1UkZMSXJ5d3hodXJR?=
 =?utf-8?B?ZDRKYVVqNyt5dE8vTm9IU0VjTjVSNlJIa0N4OWFsd3laVkdwN0syUS9wT2pP?=
 =?utf-8?B?a3l2SnNETmQrY2lJaE83d3VoLzhSa0UrQkdxdmNIU1pHcTlWUnRMcEJrclpy?=
 =?utf-8?B?OVk5eVdDMkhhemtPQXBkVkJ2K2xjNHRXZ25sNFlROWwyNitJbURMUHliWE83?=
 =?utf-8?B?alA1RU9XOHZlVTBmNm13dFJkMUxxeFFpZjU2RUs4QndOQ25Id3R6M0FheXFO?=
 =?utf-8?B?T2Q5aGc5R2d5V3JDWEFSM3dZUEwwZ0JtNWhJZkE4ZUhRSDhTNXF1WkJ1c2ZQ?=
 =?utf-8?B?aWVoY2tqWHdlSVoyZjM2RC96b29ROWcxYkhhNTlEZS9PZlBYNUpScjMveDdH?=
 =?utf-8?B?RVM0TW9BaGhHTEZGY0NZRzIxSkc2WnZJSUNvYUI5MVFWSkpna1hmS3FvU1JN?=
 =?utf-8?B?bmQ1N0FEWjVMc1V3MHVicitkOHlCTlQvK09aem5xS1lTMEhzR0xKRzJPS2Vh?=
 =?utf-8?B?OC9TeWw5OFhyRTYzYWtaT1NXY1pxcExmc1BzbkpJQmZrSFVOSHBlQVFta1ZI?=
 =?utf-8?B?M0tWNTQ2ZlF1YkY4VzhocnZHak55d291RFpLTGFIMGFBaTA3Z2ZjaktjbVAv?=
 =?utf-8?B?NHJUdmJLR1c1RGlpUENic3M0NWV0QlhmS2dCTFhZUnBBcTdpWmtuYmdIUkNp?=
 =?utf-8?B?alJseG5wdnZRU1lpb0ZMbUpzdSt3dUZEOWhQckY1SkNMMW5GVlA4Q2Y5aEZ0?=
 =?utf-8?B?TjFINmZ6Uk9IMG5LZ0xOZXpMbDZVZmJVM0JxYUlHSHBCNkdnNnd4aWY4R0I1?=
 =?utf-8?B?Zng1WHNYeGhqcy82T1FlVWlKbnd3TlRzY1RSMUlGSVBVMHpsQm5Rb0ZnYTlC?=
 =?utf-8?B?OU1KU1hVZTJ0R1VKdjVLRGRZVGk4eGJWeFFFS0NuQ1RVa0dOQ1B5aGlaeDFn?=
 =?utf-8?B?TG4raWxSaHI4elFjdlNCeTNaeHBvKy9rV29nZG5lWjFOR1Q1eVoyZVgrMHNN?=
 =?utf-8?B?L2FzRzVMeTl6TzdmTG1naEs3UEg5S0pnV2Q3NWF0WHlFaXQxdjcrNWJiamZL?=
 =?utf-8?B?aDRNcjZiUFk0UHlqZldqK3MwL3lCSk92V01OdDdvSjJyTGZzSytPVHQwSmFI?=
 =?utf-8?B?Z002Ry9Wbzh6SGVqbys5VUlyK0lRQ2s1NHBtVkliWG9sd08wM1lVTGtJMUhQ?=
 =?utf-8?B?cGcwaWJBWGk3S3Fkak9sTVpyZmk3b1ZDTjJ6TmJ6K2J6RkNiRGpJTmNNVlRE?=
 =?utf-8?B?ZGxROExveTRiWUlBcDdWS0tVUGpnVFd2VFgyUFRHUE1uM3JOdm9JTm1CdG41?=
 =?utf-8?B?QjRRaENrM0x2NWpIMGxieDBvaHZRcWc1dFkwOFhOZWVzeEZBcXdXRlAxcWk0?=
 =?utf-8?B?ZTV0dG5iZ24vM1gwdXdjUFp1RHpMVTlyR29SUVZZMUVVYldDWjNQKzFKRDZq?=
 =?utf-8?B?R2o3aEtWUmJKajZpUlNCN2tNcTRDSVhFdlJxcVgrSkNONXJFWnhIbHBEeUdi?=
 =?utf-8?Q?ETdBbnJIw0NMTiVPYHrapo35UrW+wo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:12:19.7351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 404d0592-b9e5-4a58-c64f-08dd51864bed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
Received-SPF: permerror client-ip=2a01:111:f403:2416::62e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

On 22:08 Wed 19 Feb     , Philippe Mathieu-Daudé wrote:
> Introduce 'fifo_depth' and 'fifo_available' local variables
> to better express the 'r' variable use.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  hw/char/pl011.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 60cea1d9a16..bcd516d682d 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -486,7 +486,9 @@ static void pl011_write(void *opaque, hwaddr offset,
>  static int pl011_can_receive(void *opaque)
>  {
>      PL011State *s = (PL011State *)opaque;
> -    int r;
> +    unsigned fifo_depth = pl011_get_fifo_depth(s);
> +    unsigned fifo_available = fifo_depth - s->read_count;
> +    int r = fifo_available ? 1 : 0;
> 
>      if (!(s->cr & CR_UARTEN)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled UART\n");
> @@ -494,7 +496,6 @@ static int pl011_can_receive(void *opaque)
>      if (!(s->cr & CR_RXE)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "PL011 reading data on disabled TX UART\n");
>      }
> -    r = s->read_count < pl011_get_fifo_depth(s);
>      trace_pl011_can_receive(s->lcr, s->read_count, r);
>      return r;
>  }
> --
> 2.47.1
> 

-- 

