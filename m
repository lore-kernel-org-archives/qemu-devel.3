Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF4AC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkisr-0002EH-MP; Fri, 17 Jul 2026 09:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wkiso-0002C9-E4; Fri, 17 Jul 2026 09:45:44 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wkisl-000134-Mf; Fri, 17 Jul 2026 09:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzNVSxZd+PCErnvtXLsEUrxpVIg4C2UY2SVDocDnfgQZJVBAOtHc2PAmlIxgZfimxJs2x1adV3rWZ5s7sbSdAYlkcy6/C4IPP0W8HXekPX6oOZ00uWpM1vNtqLWbqHTG5tYU4tow7228YdsJmLesmT9rlo7l2rMpwzjhH+xP58TqlOk7TLsB4TMWwNbiUlCmuWt9s3u9l540auPSMZTvGBaRrpF4Hohfjqld6N8l4iDqb4FJUNRC4/7NtY/3yLa9VP7+Mg+JiV/c3zjv7KfNW2OPs667HMRuvBJLPwOuqjNM9M+IAWaPCTufaNOh3rSvO3MetxGhKZW976QVc42SvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSyiuOF7+41FQv72rNTWJhog8mea1yXTbpV8igishbw=;
 b=eKznl8V1pESqGmEIQ/+7eCtgnatcS0iPrh6KNxy/Sv+q8dafnNfCxo6GKqUm12d7/UbyyqjhoiBGXsNOOwkvJ2j/SNRDMEgY4aaGf1MyG113OrspXQW69byLGE/HBoFUv3nluEn1nlJvB3TpFd2AncPo6d5KMf6M2uFMzCIB5GbxrR2tlcC9rOItkgM2HlBbxHpf3EFrCH6W/cgIoUtDWcnxsbYsAHNx3oib9km8oCZOiweAnPzFQaC4UhNT8y4yn7Qtr2xJu0BGpA27fgYuYHledFnlXNEEyoYjjZuRSvOF6DvLLDgRiFiXVRE3vSzYwGvDCUrfhXaxfObCcKIq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSyiuOF7+41FQv72rNTWJhog8mea1yXTbpV8igishbw=;
 b=ZRjD1BUaWvE4yd/Q+XXKjXJ0FZevczHInHfOFAKtBxiOzIbM/aTKbVw6Qc6fwYxldrVYvxmvVytSjGCt986gbRvpo9tD7SgkJ/eFKwK2EvUHZkGwszc1YsSJu7u9/5yAfu/jGvzwsgzTDW9Ycoe/+jwemBbX75tQQBWG8z5RKptwjb+/vjDYsWL89VQT2ct4WeyOypeVXcEvg5qYHvhHqFS4gwUFOnQa0q9MWSXAXXWTPqx1ECLfP8l1D3c32VpsYxJ7026RGDJnFZOfmZuBd+62jrFnATKz9XVhXSReiUWbW35I4dqbEEmUCU371GEAy9ou++HSqaM2ONZd22e7cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SE3PR02MB8925.apcprd02.prod.outlook.com (2603:1096:101:2f0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:45:35 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:45:34 +0000
Date: Fri, 17 Jul 2026 21:45:29 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 2/3] hw/riscv/k230: wire up the IOMUX device
Message-ID: <alox45BlNTiMoGMA@ChaodeMacBook-Pro.local>
References: <cover.1784022244.git.flamboyant.h.01@gmail.com>
 <43e4eb64d1c29419d5803e42ad692324bde2b6c7.1784022244.git.flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e4eb64d1c29419d5803e42ad692324bde2b6c7.1784022244.git.flamboyant.h.01@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SE3PR02MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e799847-e2cc-4604-3462-08dee409ad72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|1800799024|366016|7416014|376014|23010399003|56012099006|4143699003|6133799003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: QhMstzZqO8AckBl0+Dnqz14mNTcv+0XZPnZPEGKZ5Eg1MZPLr5t++Z4eB6t6CSQrf/ESN46WyG0oVNbHqPPzpftXcePfkMNU1e+2EcRtynbbX4YNOS17kc5cedgd6N2hvKx5UxM4OSk8LXZNbEihzzlMz1xQMlJxx8qnrydElETni//mMp4MecxsUzYfRB1Jd/UMjSR1wYnMWJc9xXpm1JFHM6zRMnQjUFS2tAQ1g9D7NNdETQfAhiZs+6SQIFS3QyrAFJEuI7HMnARtCsdu2/ZiHyU10FfcFOKBfpNT3hl2BLmUdTiGu+N/HawdcdaMoOf32H22QEzIvhG1DsvOsQuBHas9DzyxSw9zeBEpSIETpy3YSWdp3J/e+6OyZfFIyIJKm1vyygA9faXvXQ13/Sia73nnwc8LBla/wwmgVi4ggIK8Y9ZIUoYIUjr5grHddtwhTBdpP6JK2+f9VyCvQjeTbjmfgmWAS9tNRWK7UsBkgj2fdsXKETZyIxLVA1t2qw5M/6DuDOYRxMx3YB2jJSmQHIKzckAXMSWYKXOvtyMvXop5kpIDgCTBdEdiBpUYyvIQOMqkhWf5+oPaOV7s4NyBptfWWYSXrbxiIu3PNju39Rf7bg38mwUlKAH5ArhKGTViJCb9ML1N+PFLIwdEmt/iGDmi8VFAE3SizNNJU1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sEhU2fskeHqoPApoCEgY1RnOgpqm1iHyoqrBnJNXllZth532Ewu4+/EOvARM?=
 =?us-ascii?Q?BysQTshm/CmLaH84gOzYkMtjqQtJHxV2nSopGQ74GfjaH/XLIpXcwNuLygeD?=
 =?us-ascii?Q?5+RNn7YZg2TwF2ICh52FGCRzwD6TqGXgR/F14e63LffpDFNrPUHkOLKn4WXn?=
 =?us-ascii?Q?HZXfMD5uDA98zUQuxhLykNDQqpHjeAHJgF1LzlVpi+BW/oj593Wa99NvdrGP?=
 =?us-ascii?Q?VvcuPTjQGyRs1rRi9u0rqTpphf0YGD2pUu2Bz2tFuurlr0Hhg4dA44bv501X?=
 =?us-ascii?Q?LTqlSsLvh9lbL065jJ6PrT8Rq+ooC+7Bk+8J7zegSiZ06bK5ujSeqHoh32hc?=
 =?us-ascii?Q?YBhNvwLpoYQq3IaYNbI8/gV8YgApok4a6xWmEIfD3rvU50cux305dFeIyCdR?=
 =?us-ascii?Q?0g2zA2q32mKUzIQPvYa/HWHR8zdXOOhAfab5ba/T6RQ8UF6Vs6R86yObvsYc?=
 =?us-ascii?Q?37M0d95EV/deTzm07cxsMl294X2ZfSPumNE4J9rJABzI3HQ342Se4opBt/U/?=
 =?us-ascii?Q?dNRGz68mfdiMYN4jcs3cl6K9+ij8KuyNoOfghZZhBkD6MO+1/wQ9VYE2vhEH?=
 =?us-ascii?Q?Klh/BYYfBqPHYJAfH64Y9CPYfeWf0i0FQLbXdcmSpufJWUNkNfKz3dH6xEfO?=
 =?us-ascii?Q?RAKHL8zqmf+84jQbsvDxnvaxeMMFiXE6ZAiduosP39Dk4hOckLakEOy9TZom?=
 =?us-ascii?Q?Oi4DyjO/FJFbsISukQcZ+taHpyqImS6FNZg36YRwfAOyLit1tpVsHt07TsMa?=
 =?us-ascii?Q?XW1qFfnBpYQBbpXvyH6U0Tu92GJPYSSSHX5A7UWH9GdwAPq6hrnWtQVn76V1?=
 =?us-ascii?Q?zAe+e/uSHIECelgvZimVLCszsf63J9Nz624J158RVGnG7E4UqWAayy6rMuXa?=
 =?us-ascii?Q?Qxgys65D2kwarhLtNXKTyrRWZErdtd61QEIA1djNKa8f/yPu+8WzD6zv+6kt?=
 =?us-ascii?Q?NaSWOzXrpbNZVa9rZEkYgWmVk3mioBkYabOL2CrWGzXtDOIzdHkafi1bl/vk?=
 =?us-ascii?Q?2giYVZDCGhJKVO/4GfJKik8EXkV77ZT0IHcOUMJ4zYJtufkbBo0L/DUZIYzt?=
 =?us-ascii?Q?owYpYaaS9EuiEusPxHo7hntW7dJ41bgtqKP/zsYPzTAKMZEBT78qvFW8wX/k?=
 =?us-ascii?Q?6x3nd0v8X5kjFUhq9ObnkWH5N1G2yxfKJfQM88bAqzh1M/VYgQddxUJ5X/k6?=
 =?us-ascii?Q?OZItTFafZC4hxpr/PVZ6fZK7lh2dbyLlCsXPG+nAlfe+f2l+qdptvIFlO/FW?=
 =?us-ascii?Q?b6K0ijRUk0LqjV5vo3XUzzXlvX/x7PiulXuF/bwJIr6PsvKz7zf3CIZXZ+si?=
 =?us-ascii?Q?TNVDa/WdnZY21HW7962A8HB0DE1kE6qPSzsooKAqgsyeXsi395lmCVEdbwqJ?=
 =?us-ascii?Q?OD9N0GH6W7uDI7AljHE74Dmff/uzRjE8peYeDUr2f0/dckkJ8LZsNP/0rhMT?=
 =?us-ascii?Q?6nACsZgy8SORKoyP28u4/NW/aUY3w8ialCB2g6ovLGqNGBD6VEnsD+eWhi0e?=
 =?us-ascii?Q?GLqekXPWaB/HNd9jDsvqwS6CwLlwIshvep3PIJuY6poSKogrtXO0q0MUknHT?=
 =?us-ascii?Q?iVv3qoecVbF7K8HARmubFhf8IVOh3o2OaVszdsct7iQhbPstHzlfxOoGCV3i?=
 =?us-ascii?Q?Swav/FH8bP4u11zarqSzp2AilqGBITUgP0Q5M3e+q0oQ7kCpEaploprX39X3?=
 =?us-ascii?Q?Li7q9sWyyYT9V+9EtPrqTn5QNYA4KTo06kRRp+UVt+XfZRI8Ko2WF0lBqTQ1?=
 =?us-ascii?Q?acd/y9MnxV7m+lfEBzkpaxQKCmKl9fU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e799847-e2cc-4604-3462-08dee409ad72
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:45:34.9333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8IdOoJMyPFAE3nvxh6dYJ36h82THVGTUwPlPCakHw4Yo2DTj/5wUS2XyL0QBcPLZxcDoc8i274BuWu4dGDQ2Zl9hcg4KwNJUD8dXnxUYjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR02MB8925
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 14, 2026 at 06:22:01PM +0800, Kangjie Huang wrote:
> Instantiate the K230 IOMUX device and map its MMIO region at
> 0x91105000, replacing the unimplemented device covering the same SoC
> address window.
> 
> Select the model from the K230 machine configuration and document the
> newly modeled device.
> 
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  docs/system/riscv/k230.rst |  1 +
>  hw/riscv/Kconfig           |  1 +
>  hw/riscv/k230.c            | 11 ++++++++---
>  include/hw/riscv/k230.h    |  2 ++
>  4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> index cea8202e55..b160c401fd 100644
> --- a/docs/system/riscv/k230.rst
> +++ b/docs/system/riscv/k230.rst
> @@ -20,6 +20,7 @@ The ``k230`` machine supports the following devices:
>  * Platform-Level Interrupt Controller (PLIC)
>  * 2 K230 Watchdog Timer
>  * 5 UART
> +* K230 IOMUX register block
>  
>  Boot options
>  ------------
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index de37c08cae..4c9fc3e7ad 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -162,3 +162,4 @@ config K230
>      select SERIAL_MM
>      select UNIMP
>      select K230_WDT
> +    select K230_IOMUX
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 656f28190c..430c1646b5 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -110,6 +110,7 @@ static void k230_soc_init(Object *obj)
>      object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
>      object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>      object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> +    object_initialize_child(obj, "k230-iomux", &s->iomux, TYPE_K230_IOMUX);
>  
>      qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>      qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> @@ -198,6 +199,11 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>          }
>      }
>  
> +    /* IOMUX */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->iomux), errp)) {
> +        return;
> +    }
> +
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
>                         qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
> @@ -206,6 +212,8 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
>                         qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
>  
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->iomux), 0, memmap[K230_DEV_IOMUX].base);
> +
>      /* unimplemented devices */
>      create_unimplemented_device("kpu.l2-cache",
>                                  memmap[K230_DEV_KPU_L2_CACHE].base,
> @@ -280,9 +288,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>      create_unimplemented_device("ipcm", memmap[K230_DEV_MAILBOX].base,
>                                  memmap[K230_DEV_MAILBOX].size);
>  
> -    create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
> -                                memmap[K230_DEV_IOMUX].size);
> -
>      create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
>                                  memmap[K230_DEV_TIMER].size);
>  
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..223e76b420 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,6 +18,7 @@
>  #include "hw/core/boards.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/watchdog/k230_wdt.h"
> +#include "hw/misc/k230_iomux.h"
>  
>  #define C908_CPU_HARTID   (0)
>  
> @@ -33,6 +34,7 @@ typedef struct K230SoCState {
>      RISCVHartArrayState c908_cpu; /* Small core */
>  
>      K230WdtState wdt[2];
> +    K230IomuxState iomux;
>      MemoryRegion sram;
>      MemoryRegion bootrom;
>  
> -- 
> 2.43.0
> 

