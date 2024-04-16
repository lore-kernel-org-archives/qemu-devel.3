Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014D1C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwepc-0005up-HA; Tue, 16 Apr 2024 05:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rwepa-0005uR-Tm
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:10:22 -0400
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rwepY-0006AU-IR
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:10:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH+roRLoJF9rxgkmokFSVrY8CPVPZNk3WM0geKHEE/BgwTMR04wU3M3b2rVVU8pj0bvt9o3E7U5hderX7RreDfpFFt4I6bjwPfstkKR51KPaknq/k5BW2uzs84vMR80zI7axFeseWi0RBa7QPFXMxT21U+sJb/P8iXxHluxhid7uS98dCt9KBz7GOm5B46QWXaOBL+HXZIOYKUkTv5Ml6yBL0STlGjmwMeOFBVOA50bHg85B5vyS0MTDjOa2RXX1tzpqhD5XwfsDYN/AhKqHjI74+BJ4xAMvxmtVvAoO4p5VPMgHDPAh3s4VdgTXFBAnPpmaY5ppMeNORCfJbmHsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEELkzLqeIM7c9oKoCCO0sgwfTXU5hYKoRoxqexffPc=;
 b=Rq1dfSEFGzsCOOH6p1K0UfGTPBmvu+RmVIdH3YSrjJMyssqsztFGRscQq/+Da+w25m7GRKjyJRXiRaJJbTds9LtofGos0iA7mB0mjR65BMlq/3I+wOQ/eAaXefy46u76mTV6LW0rLAF62xRGO8WkxaxYu8398IHgKf1L3PPGdHFgSoMSVELGvZ2ri/J8pSFoY9ANZxskqEsYRXBwluCl1FYw1VD5HsogDy5IE3Xok1oVhCOFOgrSdOoX95r8HT0w+VOCLXBkXmK/cxXp9KOGfYaIHjXaOdgwd3GHIbzR3V3k6dh3RjX98Lf6UUYHAAJy/dgb3nnMSVlNVHoqZ+WNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEELkzLqeIM7c9oKoCCO0sgwfTXU5hYKoRoxqexffPc=;
 b=mZ3e5y5B1+UhHAoHEZSyCrsbXxaw7dqxhUUobOcrVANlMmqWpX1s3tTxAVTzppJNOPem/g33k87/X7kY33J/rXzJ6OiXPE5nlHO6ZCirAHskmp0Tz6yjAj7Xt/WITW/DtdTvKNZX0Gzt45L3wOHobNUzrkaOcTxZuRULHNuZ6LY=
Received: from BN9PR03CA0580.namprd03.prod.outlook.com (2603:10b6:408:10d::15)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 09:10:16 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::d1) by BN9PR03CA0580.outlook.office365.com
 (2603:10b6:408:10d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 09:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 09:10:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 04:10:14 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Apr 2024 04:10:14 -0500
Date: Tue, 16 Apr 2024 11:10:12 +0200
From: Luc Michel <luc.michel@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/6] scripts/coccinelle: New script to add ResetType to
 hold and exit phases
Message-ID: <Zh5AdHLsBgXE1aW6@XFR-LUMICHEL-L2.amd.com>
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240412160809.1260625-4-peter.maydell@linaro.org>
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 299694ba-354b-4e0b-cf2b-08dc5df50789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axW3FFe4y3X+0kHxupQ+eG415scckIORE5/Jbw8HjqqOYiap7ajXF7cY7sqyG0LH5Cj/xmp2GX5w+merF2tCNpe3Ss3c5tdZ4y0xV4t2EaU8mmKjoajyaEFwUUbYvi4Kgj9acu7gp196kbL2cUeNMZ7Zxqcc4jH/xzGGx5kS4DHz2gB7OZng9/pMVBi362BT4+gCLEz07GQJTuZNuYqBn56P0h55GfOa4BAfTsfsXylU8P8YPE9un/VD24cLg2UVEfAtW5mJeY8ubxo7t7ZkrC8kipPeiK5YeM6/fLyAwE0rjRvoB04nC5vsqMLkW3ouF2fN7e9op/hQ3V9EZhOXAjbXekeh+OwWZ8VvJtnxSpn2380+wlO3Io9KtLHmVjz0XWMRsscCf62fy9x843wz++n1fNV3r00k+sVQIPQfGqlcQJh7VNYV62bohvTf3PvJX8VpPHB/pe4+gf2s2qQ+qNNLW+et/ilQ4rLJPLNhm7L99BBTiMkGycuIJ2EwcQDcTXEv/kQf6/nxdp7e2e/u16HDXSn13hcKxyVDsCrRuvxou99I7NPg9zvYvbcKzNMw3+fqAnlvryhm4PVyPayPKa8dY7hbHX8q7cP+BLXVlvKsdbRlVS4rISBmVwxQEdIJ790000aY4x6r1yqyZcA6ODBZ0Y9QUAVb//9Y2Hb/dVWYMXHdmHjHWL54bWZtPQwg0boMexquvfSFJMMk/kCNcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 09:10:15.3985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 299694ba-354b-4e0b-cf2b-08dc5df50789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
Received-SPF: permerror client-ip=2a01:111:f403:2412::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

On 17:08 Fri 12 Apr     , Peter Maydell wrote:
> We pass a ResetType argument to the Resettable class enter phase
> method, but we don't pass it to hold and exit, even though the
> callsites have it readily available.  This means that if a device
> cared about the ResetType it would need to record it in the enter
> phase method to use later on.  We should pass the type to all three
> of the phase methods to avoid having to do that.
> 
> This coccinelle script adds the ResetType argument to the hold and
> exit phases of the Resettable interface.
> 
> The first part of the script (rules holdfn_assigned, holdfn_defined,
> exitfn_assigned, exitfn_defined) update implementations of the
> interface within device models, both to change the signature of their
> method implementations and to pass on the reset type when they invoke
> reset on some other device.
> 
> The second part of the script is various special cases:
>  * method callsites in resettable_phase_hold(), resettable_phase_exit()
>    and device_phases_reset()
>  * updating the typedefs for the methods
>  * isl_pmbus_vr.c has some code where one device's reset method directly
>    calls the implementation of a different device's method
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

(I'm not a coccinelle expert but LGTM)

> ---
> The structure here is a bit of an experiment: usually I would make
> the coccinelle script cover the main mechanical change and do the
> special cases by hand-editing. But I thought it might be clearer to
> have the entire next commit be made by coccinelle, so reviewers don't
> have to go hunting through a 99% automated commit for the 1% hand
> written part. Let me know whether you like this or not...
> ---
>  scripts/coccinelle/reset-type.cocci | 133 ++++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 scripts/coccinelle/reset-type.cocci
> 
> diff --git a/scripts/coccinelle/reset-type.cocci b/scripts/coccinelle/reset-type.cocci
> new file mode 100644
> index 00000000000..14abdd7bd0c
> --- /dev/null
> +++ b/scripts/coccinelle/reset-type.cocci
> @@ -0,0 +1,133 @@
> +// Convert device code using three-phase reset to add a ResetType
> +// argument to implementations of ResettableHoldPhase and
> +// ResettableEnterPhase methods.
> +//
> +// Copyright Linaro Ltd 2024
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// for dir in include hw target; do \
> +// spatch --macro-file scripts/cocci-macro-file.h \
> +//        --sp-file scripts/coccinelle/reset-type.cocci \
> +//        --keep-comments --smpl-spacing --in-place --include-headers \
> +//        --dir $dir; done
> +//
> +// This coccinelle script aims to produce a complete change that needs
> +// no human interaction, so as well as the generic "update device
> +// implementations of the hold and exit phase methods" it includes
> +// the special-case transformations needed for the core code and for
> +// one device model that does something a bit nonstandard. Those
> +// special cases are at the end of the file.
> +
> +// Look for where we use a function as a ResettableHoldPhase method,
> +// either by directly assigning it to phases.hold or by calling
> +// resettable_class_set_parent_phases, and remember the function name.
> +@ holdfn_assigned @
> +identifier enterfn, holdfn, exitfn;
> +identifier rc;
> +expression e;
> +@@
> +ResettableClass *rc;
> +...
> +(
> + rc->phases.hold = holdfn;
> +|
> + resettable_class_set_parent_phases(rc, enterfn, holdfn, exitfn, e);
> +)
> +
> +// Look for the definition of the function we found in holdfn_assigned,
> +// and add the new argument. If the function calls a hold function
> +// itself (probably chaining to the parent class reset) then add the
> +// new argument there too.
> +@ holdfn_defined @
> +identifier holdfn_assigned.holdfn;
> +typedef Object;
> +identifier obj;
> +expression parent;
> +@@
> +-holdfn(Object *obj)
> ++holdfn(Object *obj, ResetType type)
> +{
> +    <...
> +-    parent.hold(obj)
> ++    parent.hold(obj, type)
> +    ...>
> +}
> +
> +// Similarly for ResettableExitPhase.
> +@ exitfn_assigned @
> +identifier enterfn, holdfn, exitfn;
> +identifier rc;
> +expression e;
> +@@
> +ResettableClass *rc;
> +...
> +(
> + rc->phases.exit = exitfn;
> +|
> + resettable_class_set_parent_phases(rc, enterfn, holdfn, exitfn, e);
> +)
> +@ exitfn_defined @
> +identifier exitfn_assigned.exitfn;
> +typedef Object;
> +identifier obj;
> +expression parent;
> +@@
> +-exitfn(Object *obj)
> ++exitfn(Object *obj, ResetType type)
> +{
> +    <...
> +-    parent.exit(obj)
> ++    parent.exit(obj, type)
> +    ...>
> +}
> +
> +// SPECIAL CASES ONLY BELOW HERE
> +// We use a python scripted constraint on the position of the match
> +// to ensure that they only match in a particular function. See
> +// https://public-inbox.org/git/alpine.DEB.2.21.1808240652370.2344@hadrien/
> +// which recommends this as the way to do "match only in this function".
> +
> +// Special case: isl_pmbus_vr.c has some reset methods calling others directly
> +@ isl_pmbus_vr @
> +identifier obj;
> +@@
> +- isl_pmbus_vr_exit_reset(obj);
> ++ isl_pmbus_vr_exit_reset(obj, type);
> +
> +// Special case: device_phases_reset() needs to pass RESET_TYPE_COLD
> +@ device_phases_reset_hold @
> +expression obj;
> +identifier rc;
> +identifier phase;
> +position p : script:python() { p[0].current_element == "device_phases_reset" };
> +@@
> +- rc->phases.phase(obj)@p
> ++ rc->phases.phase(obj, RESET_TYPE_COLD)
> +
> +// Special case: in resettable_phase_hold() and resettable_phase_exit()
> +// we need to pass through the ResetType argument to the method being called
> +@ resettable_phase_hold @
> +expression obj;
> +identifier rc;
> +position p : script:python() { p[0].current_element == "resettable_phase_hold" };
> +@@
> +- rc->phases.hold(obj)@p
> ++ rc->phases.hold(obj, type)
> +@ resettable_phase_exit @
> +expression obj;
> +identifier rc;
> +position p : script:python() { p[0].current_element == "resettable_phase_exit" };
> +@@
> +- rc->phases.exit(obj)@p
> ++ rc->phases.exit(obj, type)
> +// Special case: the typedefs for the methods need to declare the new argument
> +@ phase_typedef_hold @
> +identifier obj;
> +@@
> +- typedef void (*ResettableHoldPhase)(Object *obj);
> ++ typedef void (*ResettableHoldPhase)(Object *obj, ResetType type);
> +@ phase_typedef_exit @
> +identifier obj;
> +@@
> +- typedef void (*ResettableExitPhase)(Object *obj);
> ++ typedef void (*ResettableExitPhase)(Object *obj, ResetType type);
> --
> 2.34.1
> 
> 

-- 

