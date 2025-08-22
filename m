Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68644CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTYw-0004LP-41; Fri, 22 Aug 2025 11:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTYs-0004Ia-P5; Fri, 22 Aug 2025 11:20:14 -0400
Received: from mail-dm6nam11on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2415::627]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTYf-0007UC-QY; Fri, 22 Aug 2025 11:20:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEz8DgwwO2sD0orrmiRn3/vS/QaYBw6i6PjBXwSn98xDXsh5Kbo0VrFuduWmT2UGkhvcfaQxnXbWQ5gHP+lg+DNRy1UVUQAGl08pLjtRpNltp989D8o5y1Ufj6j+dT0cKUOx7Q0iMFjfZZyd/w8tfO9nzoZfVstr8LpqSLqnMZfRBngcYk2WWVdvqn0lgoYAumkgw8rZJa1ZvhDWf43HDj+E2/mz+vtHBxdfAKAFc4kMoWQcnlszAwLSn4fRuU+CytkeyeRv9x/uigXdJxmcScB55zCJXSGofgvczpJWWERTTit8kFRZbOYt7EWxrNi/ry7vV+tws7kS9/JBX6zplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvRjBSP3/JdVVS2GiXKtxELLVgClxP+0dnNqWrvVDW0=;
 b=Zj80eeaODs+JqfNJOtH2FAVdSsdOXS0+6el3HoG5lpuKgSZWGpt+1Hhf4H0vAaG7/MqdizI7Al41yQnZoPm3J9oinRwPHWFFizbShtB+dVBbR15EH3DJEmoRzT0/kZJ0taMo4Od8COUCC4p/N5A6MOdH1+q3u7GMcLIw06AvKqqZ9v/87YWqQyrrjqiZ3XXvv7KBBk4/DjNZrBdkvuhjOUxGn7xfv6bcjYbkukP4sbdacyj8vZGYVHKWy6ev6hDm9oZGB8EJGq8T45FqD1nA2ft61mxFePhSOW4A5br8hdCM7EkIX1Be/WZybVKN6ZsAb/ZpCynpzA5oDsCoXjci/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvRjBSP3/JdVVS2GiXKtxELLVgClxP+0dnNqWrvVDW0=;
 b=yA2KX/xv0SWn3kZ5Vnw+unUPHMX4741Q6d6oDuzTmEbiu/mvH8cMaGNP0pofWAEKdXx7nT1sm5vKB37OatJm6CEcMqxx8zv73CiBAFjTQWNSHUo+UW/JRiCxdDxq8zZN6iZyQsHeF+3GcYy7qWP1/Bp1dltUpg4iS5BcAyuD6Bc=
Received: from SJ0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:a03:333::26)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 22 Aug
 2025 15:19:54 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::78) by SJ0PR03CA0111.outlook.office365.com
 (2603:10b6:a03:333::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:19:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:19:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:19:52 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Aug 2025 10:19:50 -0500
Date: Fri, 22 Aug 2025 17:19:48 +0200
From: Luc Michel <luc.michel@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 13/48] hw/arm/xlnx-versal: VersalMap: add support for
 OR'ed IRQs
Message-ID: <aKiKlKGYlc0vMPwE@XFR-LUMICHEL-L2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-14-luc.michel@amd.com>
 <CAFEAcA-x_CYWPM2TeGSTLjCj==3JY_uyvfFmR=nLi4pRLw-P2Q@mail.gmail.com>
 <aKMrBdNhtqHVHRYw@XFR-LUMICHEL-L2.amd.com>
 <CAFEAcA8eop95ojfZw3YbDrWfrv1fZ5QYSmwx_oDThxMCiMMeDg@mail.gmail.com>
 <aKV21WpfZ8u054zc@XFR-LUMICHEL-L2.amd.com>
 <CAFEAcA-HoghnZLWZLX7zBD=-_mztTQoZLReQRgS5TRE91eRbxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-HoghnZLWZLX7zBD=-_mztTQoZLReQRgS5TRE91eRbxg@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8afaf3-9445-499c-7248-08dde18f57f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PP+CZg6jLCJ+1nfBWfjub7BceddoO1ZuwxL0TB6iBKYN9q1HVuqt7T5XDbVS?=
 =?us-ascii?Q?vY073y/42ZGs5e7fxItwT2q5CmcFoYpn/ABMq1fQ8sH6Ngpr3Lixn3j6Kuf+?=
 =?us-ascii?Q?1x7SFmTpKi3E6fCOIPWJyEm35JHzfNCw8Pgkkm37NS1wK7XDljIh7q2/kx0N?=
 =?us-ascii?Q?azm5TYWX2y4iXB7NvXJZ3rTey7gAIy4oLQDtia692oAiOZfG0FpEi558wd0L?=
 =?us-ascii?Q?CA/o+Z0lgUqciPmcuu1qWNIkekiLjsfr7onPHbAP/JhKwmj0El6MA0yqW6v6?=
 =?us-ascii?Q?fOkcpSoO0sjX3aAJrN6NMKwwk63Kr/l/isCpYIK6gb0Q9fXU0lHm/oScQJ5X?=
 =?us-ascii?Q?kGvA5ZXS3VFCfxLg3vkXm1UQgvFAcNuw1Hwsgh6sN+QAPLDgA+OAGlPRSjE/?=
 =?us-ascii?Q?k+dRGUhPU2mcauHySeR3Ogfaow9q/IqcbwBEIu3uY7ezEhzNRWUCrGse1pZD?=
 =?us-ascii?Q?ycPPGgY8WFNEuUvk3kS8Qg8MoiHk77In00KQA2+r+uxlcrzQ8cFp76nGXF5Q?=
 =?us-ascii?Q?vjxd7vCpV52moNPUOBVzwzFfRWVrHPx5fJXwZdqZonJaOI01gyNVi71Li7ix?=
 =?us-ascii?Q?ryCl+fivKNyb+dyHxC/jzhqYiyCW9GoZePWXD9fgtmV5drOlRSjWouW0z9q2?=
 =?us-ascii?Q?ZgZJySObwi0oS/2pd2faCfhmCRoRUw4yeRkuZP3AZLVz4wsEA3H9n4HvcpHv?=
 =?us-ascii?Q?CpTM+Dipqvqc2dS5hJL0k+pdCFbJNEOjt78s6LmM57+/U1KfiPklRQaFmjg5?=
 =?us-ascii?Q?18N6QD+GLjL0NKgry2ts0oZSeSECb4NL1ZqU68Y979Tf9jPwuPWFjS51XGyP?=
 =?us-ascii?Q?5xuVJrUzuKSDU4YeLwmb8QpNEGuBOFYczXVeM9TRg4yWJbuPQnU7fHOMuOsU?=
 =?us-ascii?Q?rGdFOtwJLJJHyZsFpCzoCgqIQ5d+2xFhAitAx2lu/N0WM+gWYOBMs3WQ8HHK?=
 =?us-ascii?Q?spOkIwjBUNX6ccgduyV9BifPIi1sOXrHLcZm7VzuVKl9KQ1DVzGW64o6d1RP?=
 =?us-ascii?Q?HusAjCD/jdNtMy8N5ryoB1TnGcER/wcpwgMlhtJ2ZaUpb/PWa9yqASX0IpWH?=
 =?us-ascii?Q?0/KDPr7tHjEFVqeMHiUMJq5l4B0GHzs8M0XPMExRPRlWP1p/ng8yc0TRM6nW?=
 =?us-ascii?Q?Z8U2CQ8KJcfWuwH1ITv3Kxq/FEn1JZZV7ox/JKtMA6NC4IWONtWgR7NxlhFL?=
 =?us-ascii?Q?X4h7qLB9W5HTeaqsOfLG6SnvbyDrl2wi6ZlXL/vETUIs6WXL88FiBuHMyFVl?=
 =?us-ascii?Q?w1IotAXd8pABihllV0kJaR0ys9aBySX6xtgLccHoPnMNmh0vRUx6sme8BIEo?=
 =?us-ascii?Q?4cLkDMJjW9gvIj3F0uVsY9a9OEzRZUbCH3Y5ylkQhcMR4ATRewqNOEgollrM?=
 =?us-ascii?Q?aTy3nBbsCUc8aKP81y+vciRNBe5YRXF5wvnhYLEUTPEFYNuLGnZX7RIvWirE?=
 =?us-ascii?Q?oWhEaWVMu7HPkcQJOj58BIHd35yglHq1w+JiLMaksKhnTzVEO+TSpIdg4yU3?=
 =?us-ascii?Q?1YWYqCQbl7juY120HFDPiw9WT6VARF4eC2lg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:19:52.8145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8afaf3-9445-499c-7248-08dde18f57f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183
Received-SPF: permerror client-ip=2a01:111:f403:2415::627;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

On 14:55 Thu 21 Aug     , Peter Maydell wrote:
> On Wed, 20 Aug 2025 at 08:19, Luc Michel <luc.michel@amd.com> wrote:
> > > It would be helpful if you could run "make check" under
> > > the clang leak sanitizer with your patches added, to see
> > > if it complains about anything. (Unfortunately it will
> > > definitely complain about at least some pre-existing
> > > leaks, I suspect.)
> > Yes I did that before sending my series and fixed all my leaks. As you
> > say there are some existing ones, mainly in the register API (IIRC it
> > does create an object that is not correctly parented).
> 
> Yeah, register_init_block() seems to be broken in two ways:
>  (1) it calls object_initialize() rather than
>      object_initialize_child(), so the objects won't
>      be automatically unreffed; but it doesn't manually
>      unref them in register_finalize_block() either
>  (2) the TYPE_REGISTER objects are a subclass of TYPE_DEVICE,
>      but the code never calls realize on them. This means that
>      if you fix point (1) then you trip the assert in
>      qdev_assert_realized_properly_cb() which checks that
>      every TYPE_DEVICE in the QOM tree was realized...
> 

I'm willing to address this in a follow-up series.

Luc

