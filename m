Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4084C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwep0-0005s1-Rb; Tue, 16 Apr 2024 05:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rweoy-0005rZ-V7
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:09:44 -0400
Received: from mail-bn8nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2408::601]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rweor-0005uL-04
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:09:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEn+LcR8PvmC0Y2cv4Xza6MFy03wJXhfFmwQEBspDGruSa7AecnFl/w8s5eCOOdij8bAjq0LVuUPi3WswXUFkW9Xd7jJCpPR/03e78smxR9QTmjqp64Exfou6hoxokFxMWsWwHsxiU6K4pu7JP+TLQ+1TcX/RtmEtGrbgkgaRVSQF8ytsEbYriQRqB2lISEl5vl/osr6RkA//02CPFHt+7Z9Ef6j8TqpcqtFIiSdkEHTfc7rzY+zb2xNhHoC0Smcrw68IXWJO5kQ/InyjQCLlwB3Ly9ASw3hRoLHzW8PQU3n2zTYPEiTfjODxq2IqR+owFSKo7olOCFKgCeqaPcsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLpST9PUcWfHD4cwNLpsjnZMGjCxGEY9fXxLoCn+SCk=;
 b=X0dDEnkdH9+cnZpFFJFo+Py2gZOMV3sJvetvJ8T2a+u9cT87K5sorojdMrHW8r4sQf0zrKZOMoUzKOxNFZAe1cn+dIwlPJfryMPyi9kFigEQKNSOaQDXPAzIM8Sgz1Xckrs3lr2EStrsipOoWBAMaSbyXpwkYi23bBvJyJ36k1aVikPCqcIOQXCnxhKr9FRmkAzMitN4R7yKW48WEQlgnZdFMot4hEKawPKJE6JqEehrjxDaDAQTLE4fm1bjrD3DYlkYSEv8BiTkTIDbIxQFDq4F7muaiHBo1fnwLVE3xAPw/yMWQ5UQDYLklbh5EuxiQZ4lf/xpl04Y4qAM9F/Prg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLpST9PUcWfHD4cwNLpsjnZMGjCxGEY9fXxLoCn+SCk=;
 b=NMjcxfszVD0emSXqCCdp153wxsLyB6ovAApCrw9NE638KLcPeIRTbQxECsXoHOTHbbre1M8tfxH4dgPFoTb8lGI78igv6pBilc7LlFUqIAklDkphq5nwSB2kqR4ugeotJxcxXbKakzD/JzCNssvjR5u2Uq8gsz56UNUtR5VkKvs=
Received: from CH2PR10CA0006.namprd10.prod.outlook.com (2603:10b6:610:4c::16)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 16 Apr
 2024 09:09:30 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::f9) by CH2PR10CA0006.outlook.office365.com
 (2603:10b6:610:4c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 16 Apr 2024 09:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 09:09:26 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 04:09:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 02:09:26 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Apr 2024 04:09:25 -0500
Date: Tue, 16 Apr 2024 11:09:23 +0200
From: Luc Michel <luc.michel@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/6] allwinner-i2c, adm1272: Use device_cold_reset() for
 software-triggered reset
Message-ID: <Zh5AQ1mQYOdNsyD5@XFR-LUMICHEL-L2.amd.com>
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240412160809.1260625-3-peter.maydell@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 50558a11-a959-40af-7a9f-08dc5df4ea98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iGIuvumxewzgD/GOFcdktrDX7oEzkPVWgqf6MkJV9RmKCU7DoY+Yp1oMg7NWoORa7xihiW7LsUfgf9ytdUUwPpOfIhXZROcoIByqMqBgb8y+VCMBKV9CdUCEIqvTfV51mjGWG5HuixGCKEjeNOp5Wh0lBxqp6KGo3ERK8uy9D+F3+QNQq2DjZ3tC/URafQgWSLJff81GpCRpPp9/h+fK+Jnoi+X/1nt+/6m7KV+wda1C8zjPTdVdumDMOlXHffGBzUcX7NIQBD3rYIJ8c51t+9fSISCS5EDj7bN/8LxegWX6lvcw6CGY1w89zrMFcTkOjn7AjP+V4zybb9Ip+CXApaRTL+JP2YS2FqgI0U77Tk3r640/YEd1Nx4h3hctB2VD9OSncqf9SQrfXKwv9ch+jhMQA9FAvpEVyfz0rF59oe2q4+yhsVLX2eOd+QDLspW/C7IoB1XS/O0WsfI+JhJoKh0hFlIjyGV4lz/Rdn6+FzJQbTzK661vx5DCa/Voq/Ekvak08on954N81FTehO64MTYNPKG6feW/njnQe5gqYszlmPp36SPKdASau7ksD0mBGOxb/ErySaH+0fTbvSfX4M6HoLKrXRhrCj5dRT+GzvVKCQD0VJvxjucaI0xXWTz93uvFJSz4L66jfAeVF5PfcXKjQjC+akK1a2XlMfU+FD4MDvLBWh0KBMx2erEDbR/2E6Y7r/qNigUw51V953qpVQx3w+UHGtlGDr3hBEob+SobswfyJN+yzULUOLa6a4H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 09:09:26.8407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50558a11-a959-40af-7a9f-08dc5df4ea98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
Received-SPF: permerror client-ip=2a01:111:f403:2408::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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
> Rather than directly calling the device's implementation of its 'hold'
> reset phase, call device_cold_reset(). This means we don't have to
> adjust this callsite when we add another argument to the function
> signature for the hold and exit reset methods.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  hw/i2c/allwinner-i2c.c | 3 +--
>  hw/sensor/adm1272.c    | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i2c/allwinner-i2c.c b/hw/i2c/allwinner-i2c.c
> index 8abcc39a5c2..96c20c86372 100644
> --- a/hw/i2c/allwinner-i2c.c
> +++ b/hw/i2c/allwinner-i2c.c
> @@ -385,8 +385,7 @@ static void allwinner_i2c_write(void *opaque, hwaddr offset,
>          break;
>      case TWI_SRST_REG:
>          if (((value & TWI_SRST_MASK) == 0) && (s->srst & TWI_SRST_MASK)) {
> -            /* Perform reset */
> -            allwinner_i2c_reset_hold(OBJECT(s));
> +            device_cold_reset(DEVICE(s));
>          }
>          s->srst = value & TWI_SRST_MASK;
>          break;
> diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
> index 1f7c8abb838..a19557ec9ea 100644
> --- a/hw/sensor/adm1272.c
> +++ b/hw/sensor/adm1272.c
> @@ -386,7 +386,7 @@ static int adm1272_write_data(PMBusDevice *pmdev, const uint8_t *buf,
>          break;
> 
>      case ADM1272_MFR_POWER_CYCLE:
> -        adm1272_exit_reset((Object *)s);
> +        device_cold_reset(DEVICE(s));
>          break;
> 
>      case ADM1272_HYSTERESIS_LOW:
> --
> 2.34.1
> 
> 

-- 

