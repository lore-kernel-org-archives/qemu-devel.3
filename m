Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844FCC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwf1I-0000MO-1k; Tue, 16 Apr 2024 05:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rwf17-0008D6-Le
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:22:17 -0400
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2409::600]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rwf14-0008WV-9y
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:22:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT5wiRlRyvEb2A8FWM7Vft0T+8hfatTXYjf2wPRmHq56PAr+H2zXAGV55X+0Nern5sx+G/NReBAaKxL5r/W9HyKYUiZCvXoyM1aA1I6Bm2v3M1zET8po5W9hF6SV62dcx4iGKKLXpFlX98cisdA7Pihrv34INcSRkNAFt3bucV3c3EWnDBWya5Q42ysS7yoQaNze6ODn26WNykQSlbmcXCYLDfzFRkZP+7N8KsOI1PiPaVsqAdemj8Azg1P801Z+Hvq+mBH90JF/7NX+pSs8xjB+x99cJrJ1kL7McrV+h+N/xwl0GG13Z9vePa2oeNIj6LPuJhnSwz4FjLzu7elJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nziMQxK0smHBvkGzi8/qz0Yb3SITAuIvfgvwq1jFcs=;
 b=Ygg/OvH7EnsuZhqF2XFip9zDoPmuyQfLmAvnS76KkZECl7Ii13nVMTpYlQ1Obrz9RVptwdsa9m006tAFwdCa9Uf+JYAOGvkA1TcXIsiokg1FVTRNcOOL/KrPm9WjCzi7hvoEzF/BJck1YodgMCH8+OOvFH56olT0t7xsbmKh7trAi8KP+vECakso0QzNfcblKJGSZnWYEserQw9y2u4d1dx3NlH6epsdeX5Uam7BipV3v8RUx9UrxCQMwOlqpSrIDa2XPME6/uBd3gF1KJ0tjIWDDcLOMarksloXfM3vB+Dqbg964sWwC20B7qzsvdc/Z+0IQD7tNesXzAcQUvRhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nziMQxK0smHBvkGzi8/qz0Yb3SITAuIvfgvwq1jFcs=;
 b=ahSnchf5l2GVk85myIK3ZranRz3eVstHG/ieFdb5DghRfGBkTZPEQP1TlYMuHt6qHWbG/fUK1HyP7U1gkhgg0Jaxk4rZdhyXpkoyVdj0ZeL5KvmQtaqCCK5CiIISchkMtF+Sap06M7MlomyPChE4vs2OcmONkJokhN5EP/M/7fY=
Received: from DM6PR01CA0016.prod.exchangelabs.com (2603:10b6:5:296::21) by
 IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 09:22:07 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::7) by DM6PR01CA0016.outlook.office365.com
 (2603:10b6:5:296::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 09:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 09:22:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 04:22:05 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Apr 2024 04:22:05 -0500
Date: Tue, 16 Apr 2024 11:21:58 +0200
From: Luc Michel <luc.michel@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 6/6] reset: Add RESET_TYPE_SNAPSHOT_LOAD
Message-ID: <Zh5DNi7zISVmka3D@XFR-LUMICHEL-L2.amd.com>
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-7-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240412160809.1260625-7-peter.maydell@linaro.org>
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: d9405d74-5551-4162-987a-08dc5df6b00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDFGc8KBC0AG4HsXW0BR5goML+cs4PLimdEIm6Pm4Qc8MtJB6dAGMXRwmvEmnOrbXGNbCgrqv+62ExKhQzlxvX6p0vvNwU4LMkrMVs7nyLplm83Gp5/A+fuj1rljonWHrhvnJI0bLFI8lRrEhqmDbc+TsmBiucnDT8C5p6duOwamSp1rfauz2Wjhxo0G4cvIwFUjQcxvsdm9OYNB/izxasw+EbzBW1S3xedqUfWqL8tZTicty7uFXuzCdAt3dX/7r0T47Ru2fMYuHBAwZ169dVTjK9rjwYXFwN3sjVU/sKjKbb7zls+2v7Wzr5ABa+5hjNf95+2ennStSsFvGCGW5sXSY9McnKFHnRtVRU/9pPvcM67OFBlZCYEXbSjbz3bvMUwwQ+0tH9ODF7WPBZfMUij7ibyu8glJdbZs3wfp/vxG1EDJfaN/iultx+MDRWd4ftEu3z99Wh3XciHvjsblbsbGKWAQXalwVgMUfBf75nPFxa6TIYd8IQsRv5qJWU6epVvYsYmJ+j9TgZutGxmCiLQUoACF3baq3cu0BCcHp8oHaBghfK1i5vVpZHP69d9+0IPckD2HS4Ca9ibIjc39RfRdI/HJ4lt8jbhXxjjsTU8o+rG5rYEssFiW9eo30aR9S7Hp9yXHmjBWRrzNTdvmM9gT6mzyNcbOtDf2MuO9nQPub9daIBk8mMkzp+GMXltZ3GWRTDGsW3O9YEct8WdljTB/06CqkJMx7M5zrC6K0zcIJkUQWjx+Mbaab7BEsd7w
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 09:22:07.5808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9405d74-5551-4162-987a-08dc5df6b00a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
Received-SPF: permerror client-ip=2a01:111:f403:2409::600;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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
> Some devices and machines need to handle the reset before a vmsave
> snapshot is loaded differently -- the main user is the handling of
> RNG seed information, which does not want to put a new RNG seed into
> a ROM blob when we are doing a snapshot load.
> 
> Currently this kind of reset handling is supported only for:
>  * TYPE_MACHINE reset methods, which take a ShutdownCause argument
>  * reset functions registered with qemu_register_reset_nosnapshotload
> 
> To allow a three-phase-reset device to also distinguish "snapshot
> load" reset from the normal kind, add a new ResetType
> RESET_TYPE_SNAPSHOT_LOAD. All our existing reset methods ignore
> the reset type, so we don't need to update any device code.
> 
> Add the enum type, and make qemu_devices_reset() use the
> right reset type for the ShutdownCause it is passed. This
> allows us to get rid of the device_reset_reason global we
> were using to implement qemu_register_reset_nosnapshotload().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  docs/devel/reset.rst    | 17 ++++++++++++++---
>  include/hw/resettable.h |  1 +
>  hw/core/reset.c         | 15 ++++-----------
>  hw/core/resettable.c    |  4 ----
>  4 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> index 49baa1ea271..9746a4e8a0b 100644
> --- a/docs/devel/reset.rst
> +++ b/docs/devel/reset.rst
> @@ -27,9 +27,7 @@ instantly reset an object, without keeping it in reset state, just call
>  ``resettable_reset()``. These functions take two parameters: a pointer to the
>  object to reset and a reset type.
> 
> -Several types of reset will be supported. For now only cold reset is defined;
> -others may be added later. The Resettable interface handles reset types with an
> -enum:
> +The Resettable interface handles reset types with an enum ``ResetType``:
> 
>  ``RESET_TYPE_COLD``
>    Cold reset is supported by every resettable object. In QEMU, it means we reset
> @@ -37,6 +35,19 @@ enum:
>    from what is a real hardware cold reset. It differs from other resets (like
>    warm or bus resets) which may keep certain parts untouched.
> 
> +``RESET_TYPE_SNAPSHOT_LOAD``
> +  This is called for a reset which is being done to put the system into a
> +  clean state prior to loading a snapshot. (This corresponds to a reset
> +  with ``SHUTDOWN_CAUSE_SNAPSHOT_LOAD``.) Almost all devices should treat
> +  this the same as ``RESET_TYPE_COLD``. The main exception is devices which
> +  have some non-deterministic state they want to reinitialize to a different
> +  value on each cold reset, such as RNG seed information, and which they
> +  must not reinitialize on a snapshot-load reset.
> +
> +Devices which implement reset methods must treat any unknown ``ResetType``
> +as equivalent to ``RESET_TYPE_COLD``; this will reduce the amount of
> +existing code we need to change if we add more types in future.
> +
>  Calling ``resettable_reset()`` is equivalent to calling
>  ``resettable_assert_reset()`` then ``resettable_release_reset()``. It is
>  possible to interleave multiple calls to these three functions. There may
> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
> index 3161e471c9b..7e249deb8b5 100644
> --- a/include/hw/resettable.h
> +++ b/include/hw/resettable.h
> @@ -35,6 +35,7 @@ typedef struct ResettableState ResettableState;
>   */
>  typedef enum ResetType {
>      RESET_TYPE_COLD,
> +    RESET_TYPE_SNAPSHOT_LOAD,
>  } ResetType;
> 
>  /*
> diff --git a/hw/core/reset.c b/hw/core/reset.c
> index f9fef45e050..58dfc8db3dc 100644
> --- a/hw/core/reset.c
> +++ b/hw/core/reset.c
> @@ -43,13 +43,6 @@ static ResettableContainer *get_root_reset_container(void)
>      return root_reset_container;
>  }
> 
> -/*
> - * Reason why the currently in-progress qemu_devices_reset() was called.
> - * If we made at least SHUTDOWN_CAUSE_SNAPSHOT_LOAD have a corresponding
> - * ResetType we could perhaps avoid the need for this global.
> - */
> -static ShutdownCause device_reset_reason;
> -
>  /*
>   * This is an Object which implements Resettable simply to call the
>   * callback function in the hold phase.
> @@ -77,8 +70,7 @@ static void legacy_reset_hold(Object *obj, ResetType type)
>  {
>      LegacyReset *lr = LEGACY_RESET(obj);
> 
> -    if (device_reset_reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD &&
> -        lr->skip_on_snapshot_load) {
> +    if (type == RESET_TYPE_SNAPSHOT_LOAD && lr->skip_on_snapshot_load) {
>          return;
>      }
>      lr->func(lr->opaque);
> @@ -180,8 +172,9 @@ void qemu_unregister_resettable(Object *obj)
> 
>  void qemu_devices_reset(ShutdownCause reason)
>  {
> -    device_reset_reason = reason;
> +    ResetType type = (reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD) ?
> +        RESET_TYPE_SNAPSHOT_LOAD : RESET_TYPE_COLD;
> 
>      /* Reset the simulation */
> -    resettable_reset(OBJECT(get_root_reset_container()), RESET_TYPE_COLD);
> +    resettable_reset(OBJECT(get_root_reset_container()), type);
>  }
> diff --git a/hw/core/resettable.c b/hw/core/resettable.c
> index bebf7f10b26..6dd3e3dc487 100644
> --- a/hw/core/resettable.c
> +++ b/hw/core/resettable.c
> @@ -48,8 +48,6 @@ void resettable_reset(Object *obj, ResetType type)
> 
>  void resettable_assert_reset(Object *obj, ResetType type)
>  {
> -    /* TODO: change this assert when adding support for other reset types */
> -    assert(type == RESET_TYPE_COLD);
>      trace_resettable_reset_assert_begin(obj, type);
>      assert(!enter_phase_in_progress);
> 
> @@ -64,8 +62,6 @@ void resettable_assert_reset(Object *obj, ResetType type)
> 
>  void resettable_release_reset(Object *obj, ResetType type)
>  {
> -    /* TODO: change this assert when adding support for other reset types */
> -    assert(type == RESET_TYPE_COLD);
>      trace_resettable_reset_release_begin(obj, type);
>      assert(!enter_phase_in_progress);
> 
> --
> 2.34.1
> 
> 

-- 

