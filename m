Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD701C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwetC-0000gh-Md; Tue, 16 Apr 2024 05:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rwet9-0000gE-Px
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:14:03 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com
 ([40.107.94.59] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rwet7-0006dh-Sz
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:14:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgiZWbOyQESB/jtX7Ml7MErPxN99SfONUvUWCzcv7OSGJPPo2/BGuBa/BqH0w139SEAyberuclE0F+/Nb0Og3OL8SAmhwrznSVMR8a32oHs4Lxqtcahz/8dU47iaQ0SKwImbH/d/hRcZmke3X4/4empjJhANknFBfrkbkt3z7lKz/0dhfNhIi5h50TC4RSBXPBXHtK1XuWEhqho8AOQi2gfNF3XSkSApXh3v9HQoGnlD+y39/Hg92quCy8daxq+h74yr67rWgr+uRhm5H8pCYRoWelfTtDR++yC7jKf/dybaxNjmj8I2QK2NF3UMZaF9/KsIqMMl3Nsd/kCuf0P5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fukoz7ybWeI2GJfy/mfbXFbs/r8SS3uuv7XbeuzrHUo=;
 b=Y/IE+TIR8ZJ8rZKkA6X2kh2ZlBOH9TH8ZcAvFAg1g7tep7lpawftCsBVY6Y8bTrOLeO5kt6PfytVmcEhInTWt0sHiCYQxblJHsJyrCc/hOyGthrkFXsMdWAFmYT0r/kCgMw2Cup8+MXp0XFbw9lcG1R+cHt8rzQr1xHIfYAwLqu9WtWdToRtkWNDFEzawBrY3YGhdDayLBBZpUhC0BVPs2MpFAE9MvkFC2lfwcCHmr1sX97ZWeIXpdhDKlsmXXvkSBpmk6BT3J0P+MAdy4FDlu8TP5WUScFaL1I7XsIk12bmjOr4/E57rv5MXNfbMNly9oH5B60LRUMDPNkbdtTtlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fukoz7ybWeI2GJfy/mfbXFbs/r8SS3uuv7XbeuzrHUo=;
 b=Asq0cpejEe6/sBwU8X0DVELU+LFjBs2eYyRx5Vztmybj/OSTD93sCgUS08dBKtZda553LCKlA5qR2afpo7kXzgrm+b8heWajuYQ9SU+PndnMGpkxGQJu7KIkPi1nuD8OsBijeMSfgxLHO3cZkfZXicU2ZkesS90mMQT4b3SXkvw=
Received: from CH0PR03CA0431.namprd03.prod.outlook.com (2603:10b6:610:10e::22)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 09:08:56 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::62) by CH0PR03CA0431.outlook.office365.com
 (2603:10b6:610:10e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 09:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 09:08:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 04:08:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 04:08:56 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Apr 2024 04:08:55 -0500
Date: Tue, 16 Apr 2024 11:08:53 +0200
From: Luc Michel <luc.michel@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/6] hw/misc: Don't special case RESET_TYPE_COLD in
 npcm7xx_clk, gcr
Message-ID: <Zh5AJezjcFwa30Vz@XFR-LUMICHEL-L2.amd.com>
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240412160809.1260625-2-peter.maydell@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e105a5-dfbe-49fd-41ec-08dc5df4d8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruUNlsqw71UCONBnTUbv65t2rdKvINcNgABkO1J5+qEPwcVfpOOC8OgTOD0dBiYwqPyzkC2+0C4SO6ltd1w1z8eDJKbjpIL4FQXONtGMyM5E2KLxVBKbV8fbk0vigHJOr6lHpLd0dMuZ53ZhNP/3QzosgN+BaZ2dr4IN1jn7dSIrl5jjcnY6zWCXdPajAePR6LVHThRgGkwtoPaAMP7Lb5OH4y5RK1NCuhRGqdlOrylYVWr1NW44OgJ+nHU1+f+4uAln4Gf3TpNGVp7Y8B8EK50uMZpWrWN+aHmhMBQ661/gGlTU16NzdmzOtACsx2KZ/zEIDnsCYLENO/+m3memR9rjmiP3v7pkXaoH41SaZW3HUvHIckmVtXnMf4LQfeUsseBj+fk/mOKGOPGGZIhjmaw85bKKypUT7dFtfqAeTK7tVZDOeg/6uf1j5kXZjexWGqzRv9jCsX8h8gq0CjTwaBbnhVQO7TXyF8skCISyqEWDWMFx1JJYDS6prHcH1NZBJKU95XU2mK6psG9NnXyw5BvsdWP7MShEVClQaB7B7qMgHBDxhkKt0RhYWB4fQTco/G6CiadTe8cn3J40vE1sAPXVvbED6hHI1R52aDi5wtOpJXvExFROAjY12Fd3ZYxQmC/YNwKoJ2YT+qVj2PrrNgyVhA3hKyT8o4hwklbIW4E1wxkWjK8wBZs4GwkJCtUuVnbOFs87MIfYw9pmfW31P9qaw3J5tyS02bAuY6BWgMow0CR61PwwSriUAw3wVJ9y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 09:08:56.7582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e105a5-dfbe-49fd-41ec-08dc5df4d8aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
Received-SPF: permerror client-ip=40.107.94.59;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The npcm7xx_clk and npcm7xx_gcr device reset methods look at
> the ResetType argument and only handle RESET_TYPE_COLD,
> producing a warning if another reset type is passed. This
> is different from how every other three-phase-reset method
> we have works, and makes it difficult to add new reset types.
> 
> A better pattern is "assume that any reset type you don't know
> about should be handled like RESET_TYPE_COLD"; switch these
> devices to do that. Then adding a new reset type will only
> need to touch those devices where its behaviour really needs
> to be different from the standard cold reset.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  hw/misc/npcm7xx_clk.c | 13 +++----------
>  hw/misc/npcm7xx_gcr.c | 12 ++++--------
>  2 files changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
> index ac1622c38aa..2098c85ee01 100644
> --- a/hw/misc/npcm7xx_clk.c
> +++ b/hw/misc/npcm7xx_clk.c
> @@ -873,20 +873,13 @@ static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
> 
>      QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
> 
> -    switch (type) {
> -    case RESET_TYPE_COLD:
> -        memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
> -        s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -        npcm7xx_clk_update_all_clocks(s);
> -        return;
> -    }
> -
> +    memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
> +    s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    npcm7xx_clk_update_all_clocks(s);
>      /*
>       * A small number of registers need to be reset on a core domain reset,
>       * but no such reset type exists yet.
>       */
> -    qemu_log_mask(LOG_UNIMP, "%s: reset type %d not implemented.",
> -                  __func__, type);
>  }
> 
>  static void npcm7xx_clk_init_clock_hierarchy(NPCM7xxCLKState *s)
> diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
> index 9252f9d1488..c4c4e246d7e 100644
> --- a/hw/misc/npcm7xx_gcr.c
> +++ b/hw/misc/npcm7xx_gcr.c
> @@ -159,14 +159,10 @@ static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
> 
>      QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
> 
> -    switch (type) {
> -    case RESET_TYPE_COLD:
> -        memcpy(s->regs, cold_reset_values, sizeof(s->regs));
> -        s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
> -        s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
> -        s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
> -        break;
> -    }
> +    memcpy(s->regs, cold_reset_values, sizeof(s->regs));
> +    s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
> +    s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
> +    s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
>  }
> 
>  static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
> --
> 2.34.1
> 
> 

-- 

