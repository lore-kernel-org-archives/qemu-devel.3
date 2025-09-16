Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E4ACAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 07:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQDK-0003iz-Qh; Tue, 16 Sep 2025 03:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyQDJ-0003iG-7D; Tue, 16 Sep 2025 03:34:57 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uyQDG-00075A-0m; Tue, 16 Sep 2025 03:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDWVRY8GXWnJXE+dSRbDR6XTQ1I4C8zBTotz7vOAascX3tQ/mcuD1kq0d8zzzpCA33GX410ZRmYoP4a7PZtpbgV30tMXA73LeXmqhQZC6h8Ub40Z6mD9Lux4WFxTnX5gle88L2H9J5B1VZBU4Q1y3UFZKAEx5QFAZ1aCE2ASrVJi9WzjFfe/EDicpNolXZY86kYgl7R5Wn+qX+SGCSthxLV3MvFXZy1Rry0Vn4UA3Ie92D354ruyncFzYV+GZCBd41AyHzTAL8HV7M/wSuKiy7fA5yWytMF/0i4lcD6n2Fplj7jYq34ORH10dq9/YDn+2gWVVD/A5ycI6fUQ6N2+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTB81e9jpsqLlvScjGRYe88XzSPkdhbWq0lAY/EkTeg=;
 b=sAvEIUn5KQd8jzuydZqIVYUXLMx372SGGRBFTJeno5Go/kB7ZPsC1zZGvpiq21PLm4fgw9SHLF/Cb/U+AN9NajsXOkHsQlsNEIt638XSlvhjsot76jvBMqWKU986LmH3CuD8fM+AcSiY1ytojRSrd5OKCZBCotxn1SAlo3VD/K5rgZLqEvRIsIgF4PMgp6xhnYneDVAfXk41e+KbCbKeXX0L32RudJBSV/scdk/v38H8EtgqDiDszoHNgU02rzmutNedqfZ51+1//h6m2enlnUqZ0mKtX9PSGT6/xg4dshcNmjcV3QlIbmIyY2eLQ6HKPJljFOOHsFlAiZpd+e4+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTB81e9jpsqLlvScjGRYe88XzSPkdhbWq0lAY/EkTeg=;
 b=dGMC1OWIUdoxgFLLvmRl5OAs+dB1/Il+JwjbhDzKBHn+yTH2iNoLSGTO8WOS+2OGs8MoGH1N/Kd4mORwnKrN7tNxLwOoN0oBWo1XlB65KRWMJAL2YTRl0QMAt0ii0ec/22sVFxNFfa61VDXl+qeNM0Rjrog29nivnZbdauZgu/g=
Received: from BL0PR0102CA0003.prod.exchangelabs.com (2603:10b6:207:18::16) by
 CH1PR12MB9669.namprd12.prod.outlook.com (2603:10b6:610:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 07:34:44 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::b5) by BL0PR0102CA0003.outlook.office365.com
 (2603:10b6:207:18::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 07:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 07:34:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 00:34:43 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 00:34:43 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 00:34:41 -0700
Date: Tue, 16 Sep 2025 09:34:41 +0200
From: Luc Michel <luc.michel@amd.com>
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v5 03/47] hw/arm/xlnx-versal: uart: refactor creation
Message-ID: <aMkTEaI648omE175@XFR-LUMICHEL-L2.amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <20250912100059.103997-4-luc.michel@amd.com>
 <aMRW8kORytDzLfRx@zapote>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aMRW8kORytDzLfRx@zapote>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH1PR12MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec6ecc9-0cbb-4cce-1ec5-08ddf4f3813e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?joy8eBN+j3HgpawrwjgVGshqvxSeeN+U1wQuCA98jld0VTZqLzxeEX54OIl3?=
 =?us-ascii?Q?QuZN94JhLtN+Dr35vuQiKFDDmt1ZvITJ12HAMbGbb2kSkyN2QVyqLt0jg7wq?=
 =?us-ascii?Q?ZKKoJdUWEUXU2jJ0vjORKFlmXYpIxVjD91N3/g8W24r1PG1ZhB8f/92yQXnY?=
 =?us-ascii?Q?RY6g7B0AuUQ5CH1g2hMDkCpSwlbYncuSDWvXkp82/Ukib2luQfDWYzz7o+KQ?=
 =?us-ascii?Q?qKkH46Kem5MlxexJCDxLUjjrKqAm+Rvim/Zk3lXjNE383Xs7snQeX8T3m3tm?=
 =?us-ascii?Q?cqopF4HZvANNU7+UPFUjAHCS9f45jAQTpmxc1xs/dWpzLdq/Tk0N101BT1V1?=
 =?us-ascii?Q?SGKGNpi33brw68UEfUmafriK0YqvMsHxstYF7jBqqoWUkBzgGMN16nTYaLoM?=
 =?us-ascii?Q?T94Yhg7rJ9xzB30dMNZr0R5mLpSowxnE7+aiE44A9sAnWgiMX+RhjMqGOKe/?=
 =?us-ascii?Q?UGbXKoUkDuRYcFMq4bRRQDLNhgeYVZXAaVBsjR2sCU/w9uc5Ooj6E73xggfu?=
 =?us-ascii?Q?j9Vuofw3nYFE1Kni+Syxq1WPfWTDIxGtqz+G6zkTe1Xavk9B77IWd1ODyDnU?=
 =?us-ascii?Q?Zb5gGRnMxj95LntWCNjTEYR8PPUMNm6+IlKWmVgeqBJMDZ2JAJKiwPfFAbsd?=
 =?us-ascii?Q?T5nZhWmrrV4DHjjzp1P39lfyodmxmNbWwPpdzSnPvGOqg2Ptigj8PvPpv9Fd?=
 =?us-ascii?Q?OpwYNa4XOJGwQa1uuQ2FSLXy8Gur4y1xzN9Ma3+qSfrHIFygBhnqKTzQFxbA?=
 =?us-ascii?Q?UHtqTiVoUIAMHTIz3zQdZgwPv9mdoJTuHoNCS1Arf6RKMx5ydeLLumP2rMAa?=
 =?us-ascii?Q?L9VjOshzeVpIrooj07bKOMXA7O0OuJ+cyZyQJmhQ3/2dZzESTfGmbs+2dJ5z?=
 =?us-ascii?Q?0nN9sleUhRawP2/hpnPVjy8UiG1lVkEeTXvR7xIIu4sVu9X1aWg89WWr02el?=
 =?us-ascii?Q?Six3YUqIAGb1xz+xqEyACTbdlZb/xQKtls6U06DoZpaKiql3Ty4TrIIl/fo9?=
 =?us-ascii?Q?rE7aTZVvspZQRSqBa+69+3VbJEFxWY8KSHavdef1qeQYF49PKYEGEwVW0gKL?=
 =?us-ascii?Q?CNMPQxyj1PCMH9haeee4sRAPs160EIxT95yG0oYUfGFgvP5YgYWqHUd3+U//?=
 =?us-ascii?Q?98yNvFFGELzy3dPMErm2Z0pWzMCCFFGJgyIfSxilVlPFeERwvsCNYuSJC9TP?=
 =?us-ascii?Q?eytuoOGyjBY9r8VzphCFF3DhbduANjAyxqfb+Al2YiUdJAnMH0Uzl3ACP1In?=
 =?us-ascii?Q?/jxpwQW02NgKkZ8UoxM250xQqaV0PZhlhr9RafukmhCXx6v9LKzvIE/oR2Hr?=
 =?us-ascii?Q?7hZTVz4Di+CDJK5iZZShTbzBATg28eTb5gNLoBIU22+shAQ9NeOHO1hK6dP8?=
 =?us-ascii?Q?bWmZFYSJ1h7rQUIFHGT/BisxK7nXGq7sVQXkMn5+oouCAB1c3CyCT8brN7SN?=
 =?us-ascii?Q?6o8U0xZeX+2PpUnOBK+8rfSJjEX0A8zY/HYmkyD+eLdsl/Q6VkMx2hAer0di?=
 =?us-ascii?Q?pCOp8jUyuT9yryVTPawkT1csSlRxbQ1tzJHi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:34:43.8617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec6ecc9-0cbb-4cce-1ec5-08ddf4f3813e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9669
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

Hi Edgar,

On 19:22 Fri 12 Sep     , Edgar E. Iglesias wrote:
> > +    if (chardev_idx == 0) {
> > +        qemu_fdt_setprop_string(s->cfg.fdt, "/chosen", "stdout-path", node);
> >      }
> 
> Hi Luc,
> 
> It looks like we're creating objects and then uncoditionally adding fdt
> nodes to the device-tree. How does this work if the user passes a custom
> dtb?

Same as my previous answer: the created dtb is used by the ARM
bootloader only if the user does not provide one.

Thanks

-- 
Luc

