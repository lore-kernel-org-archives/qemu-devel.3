Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE59C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE20-000275-RO; Mon, 27 Jul 2026 01:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woE1z-00026f-16; Mon, 27 Jul 2026 01:37:39 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woE1x-0003Mg-Bj; Mon, 27 Jul 2026 01:37:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVtWKtT4oYWTE55IvCqIOOJ2zEIa5dwqUJRz+gdAWosMZB+GM82ZGZCNJvoPxsBLThMEyBhZpC3Y3QkzUdiTuIy1FAUqEIyRvrBgDoFz0ZHHIawce0uVYAQ1Is8xtn1CChsT8Leko+OCAsMiPXfK0sQVTgi3owdxYx7SINOxFJG8Z54MkehG1eLvtABBKfelG9srVf0OGDqzFyJUbWQVvhC8Xj/78zmSndQuD/7D+5uhVx7r154dsthxOmuzMtSDWaMCgpNJTPuaUbIcfL7rDKjzoMnHatswFL45rZeQewb4k+hlkPfOjtu458pcDq9nZg1sZ/fceR/5Y5CEvTjRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4p0ZX2rvsAO1Ywif6vWYMW4rr3BNzP2f6GM/CRcoIc=;
 b=m5a8Mum9R2jI5zXYG7YGtd5b0K5NZ/KEPPVFEA55RUUo+7NTtGw7JvDU6zvotdn7ExGd2ZlgfDwUXtct211V8LuPfhhSZfSwBp9xfD8ZUrkhAp4aYdkYZetPRC2p+5pASoWgs/goU9PXb3FAQEoca9vAafCObgSJl3k+wrg3loGuSaKQ8+v1l8wSN0DZWFT1+qCRZ3QP+dIrIy3Dn0mrEYGuNkUs5e3o8dWVsB0kvP5B2kD3Pqy65m6htm38c6V0XFAxiA7JABpLkMNErLCg4xggvn8GJ/5NKhZAgBPZQci2GcYuqYX9deQ9cWu7t1TvJOdjV6BrhNW1vcuiMYqbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4p0ZX2rvsAO1Ywif6vWYMW4rr3BNzP2f6GM/CRcoIc=;
 b=HJLu99by/trgEjdZ+j5N7KJ98hBfcNWFkwd03Wmz7K0Qx+jobTzqSQNTVX/ra8MEqtdyOxqgrQ0z5K1fpm9KvJX8RVFEeYJlOW1kto5SnM4gf1vybaMsos9sy8lrNdRDkkWi4kkU5G0gXm/AKnMRRPlz02brg4sxoRvOv8J2KVM9jGV/WK0q/Tv5ec5wBFx95M97HV93IoUZND7j8XXKxKkDvzbiUOBtF+fYUdGBkPLchf9g2e1/wDn+L4yq1wyujZWlsvUGyZG9yAv9TT2ZCQD+q4bg7WWEul8WrTgx6Q3MlBsNIcTEFqVWwHiaG6CipWCeEDAI17TfxKMs6NvNGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SG2PR02MB6022.apcprd02.prod.outlook.com (2603:1096:4:1dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:37:31 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:37:31 +0000
Date: Mon, 27 Jul 2026 13:37:26 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 22/26] hw/riscv: pfsoc: Fix Icicle Kit hart count at five
Message-ID: <ambuj94hAZZur6F3@ChaodeMacBook-Pro.local>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-23-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723151853.2143177-23-bin.meng@processmission.com>
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SG2PR02MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d0ede1-df88-4737-ffc0-08deeba126e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|7416014|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 6anU9wJj1TW80Gt8ZWhPLGQenePH4ithcSkLjL7650tLYBTooK1V3lwGI/bgNDbKUY1t7eCV1KtdM9emNCg86uwcRngwL1Dyu4nZRxBSsPRlpoibBvWHA5EXfpbW52/BnvQZomytQd8z//dO3ocOnLp4PVWIqKMygxOjgprTjbjqIGb5i4pi8CkGXsaBLOhAKfaqRS14OtToJzppAkMQ9uv8TAXwzJhZeVo8M5uuEoxq9lR4Ltc59UR1K8YE6dZMrFnvat1ZR/nKd1mdb7VYkCu/bQDGUBFl0zLBvrTyBIpEE6tsLABYTX5SiN1AnyTvRmXfQ7Psy79kphVYfLZQvfJXpU96MrbubwAMSc9JluQ5cRevsgt1lySwywEVEboYYyS+bQe26Q/upO9S3fK0ahF0b2YCQ6+/P8bYvgs6ihWRvSk4Es3KpGvaOsbWCPUACfrSlyF+KtVePkPx5D18iF1WnfHEirOGjuOaB4g3PTnNXsZPwJBSIt1a8BF9ATKyc2pw42s9hNnJAH/+/mVApBbHw3Aa66hC0iFOmwl9M0aU3oQ+x0ilCPlfGwngjmhMjyqQTOhJQRxB9ci1h9221w1k1iStDqgvi2ICd104sQP5fSQbhEHuErq1e98LdDpzBGtOdTjxdR4JoRK5kIzXVUVJHfnhix6uA7PBfKUx/ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QXo8xykWMNkzYAZMKGFriSzZwr+OF7CGRonjkpGYRHFIAn+EvJkNFEZnEkGf?=
 =?us-ascii?Q?F8iIdxutak0la2fi046FLfhSM6vVCmm8To3lTodT8nkpBqCyXNf5ELOphIGR?=
 =?us-ascii?Q?m1NoDWdyVgbE1iV8GCGUy2kIzA6AFH/TqUBA6RGICFyFDEC0rVxgeSWlbA08?=
 =?us-ascii?Q?+SvVcVdIyw60JJEZWKGG1XtTztqmEaAwz0sYO3TsWR4WqsptJquGzLl8ZUJi?=
 =?us-ascii?Q?7GSI8bnCPiTI2QEhDVqpUfuLDN0hRcGBMmJ7pO/XSq+pbQpGoBq32kGBw8+u?=
 =?us-ascii?Q?WfDNOTgk3ABqTT1WcgQ7ljz094HrhHqJNv7vDtfTJJWfUibSh/gqlCMcIpcN?=
 =?us-ascii?Q?9+fotit0I2vH5oRzfZTVioXFRFTJNXW8hkEdjKckZBCSKCzo17+frNdCVKXV?=
 =?us-ascii?Q?oHW3azOj5JwZx/qTV/e+dQOJl+eOgMqY/I/fKQeoXNNQkRNxZAyOaTxZIPA5?=
 =?us-ascii?Q?eSS/WjZoSrvtjf7F3SIVeWewprjlVOOxFwLTn0vjxc/34okPj+cukgC9J/kw?=
 =?us-ascii?Q?2CZnYV9OVCrnzRT8obItBflZMEIC8RSPW+2JLRMTTHW1Ikj0rEBupONLNCnZ?=
 =?us-ascii?Q?5BsA6SZDdJf4oBl6/mEo09WHME8EX5NgH3Q/uVY1GrhLrAaR7YhPbDYM2hGC?=
 =?us-ascii?Q?oqauGs4++cF/luyEo22jMUe6Kf6C4DZLbqkYrDNywV/51k5v44O6KXmiTZXo?=
 =?us-ascii?Q?4qViDKO1KDr9FTFo+ZAQessXktmokD6apEpdRMnqWfzymyb5677uED0/NZM3?=
 =?us-ascii?Q?3KRtV4+nXLJDxfoIjVxpD6pSfrVxk3E2de7jvuMYtQKVuDIMUXRL+R2sxfFu?=
 =?us-ascii?Q?mKeeOenqLTAay4PHLswTcwjtKl2kpW101IWqDh+A3ReN1kkFjXmqvXsIjWCn?=
 =?us-ascii?Q?zKljoElK4RY8zKecVX0Q9icKZvrERvKw6DoMEGkHBQcP5BpCCJON/3SuG2ck?=
 =?us-ascii?Q?R6VHuzvpWeqLehCPK2O5nvG/x2HiQ5Gf3jBIXZ+LQ5QWH0I97AMAhtHywFdi?=
 =?us-ascii?Q?iRRbBYQ8P1wqAghasEVAdzNbxzr/Z3sgvMFNMGAyl6/iXPObV6SZqXdkkita?=
 =?us-ascii?Q?GZii9qitwuZlLqPPC5g6ygjp5EFpy5i/74ED2nd1K5zD37jgFAFh9cJAH3fJ?=
 =?us-ascii?Q?1kFot1u9MsUcSi7LjLnm610Xz4XXiupSn4G9PKQlArtydYLzf42ioBs+r/03?=
 =?us-ascii?Q?/WumqbHFlS3rIZYZOqITYlb+vsU5j92Xi/rUPp8fPqMX7l1lZAVuVH1uDjN8?=
 =?us-ascii?Q?moZ0KBfuh1bbTCf6scJujNyL8MyEYXnOk9vWJKCStFuUxdjeAk1Di5amyo/o?=
 =?us-ascii?Q?fnHtZFwJVnwnWV+H7dY6TyWnEnG+Z/EzbZIimnrX7xIG9JoXPoFcEnXqJWdb?=
 =?us-ascii?Q?usG6VC6NFg89cwTuAEdtsfcXSAx8VLqXqUqSyn168pUoDbqJvI5VErJcydz1?=
 =?us-ascii?Q?t3baJOHWdeWIpxpv0epjDQtOPO1SJtvE9t7kurH+NQk3Fl4JA26KmC6XHpuy?=
 =?us-ascii?Q?8XV6wVVqXjhy24gP5JKJDcypTHzhMN3G7YHBphr3kNDzlTDB7fiHDVS1ITGR?=
 =?us-ascii?Q?9FxKPCAIO33RdljTINhLZXHpXBwZu5pi8mDdcwV+PjyiG7ex3Ia3KhNH/duN?=
 =?us-ascii?Q?amYdmRgSIX5zszLGj5/fbJ5NJe9k1G3SU/IA99ygHCuaxEUVDV1vWp7W8n02?=
 =?us-ascii?Q?qOQxo8s6NykWY/GvjGLch1X1U1g9Vhxpgk1F+wh0r9ihSu40PK80nvtdi196?=
 =?us-ascii?Q?pjLZLCgOcIHy4RZRwShzJjTqwWWXLBY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d0ede1-df88-4737-ffc0-08deeba126e3
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:37:30.9489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbVQhpatG5f9uhU7NLzo8uDIZvYc/h30pqKyTvy754O71kvJYMcXMUfXucbCxBSJKKUgENCvE7axzhcqY5JJQA+IKgzQj0sd7urBKM3b+1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB6022
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 23, 2026 at 11:18:49PM +0800, Bin Meng wrote:
> The Icicle Kit always contains one E51 management hart and four U54
> application harts. The model currently accepts two to five harts and
> defaults to two, allowing configurations that cannot match the board.
> 
> Set the minimum and default CPU counts to the five-hart maximum.
> Update the documentation to state that other hart counts are rejected.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
> 
>  docs/system/riscv/microchip-icicle-kit.rst | 1 +
>  hw/riscv/microchip_pfsoc.c                 | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
> index 3db2b3c7e3..38352cc62b 100644
> --- a/docs/system/riscv/microchip-icicle-kit.rst
> +++ b/docs/system/riscv/microchip-icicle-kit.rst
> @@ -27,6 +27,7 @@ The ``microchip-icicle-kit`` machine supports the following devices:
>  * 1 SDHC storage controller
>  
>  The machine has a fixed 2 GiB of RAM. Other memory sizes are rejected.
> +The machine always exposes all five harts. Other CPU counts are rejected.
>  
>  Boot options
>  ------------
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index b604f7008b..1562423930 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -765,8 +765,8 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
>      mc->init = microchip_icicle_kit_machine_init;
>      mc->max_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT +
>                     MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
> -    mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
> -    mc->default_cpus = mc->min_cpus;
> +    mc->min_cpus = mc->max_cpus;
> +    mc->default_cpus = mc->max_cpus;
>      mc->default_ram_id = "microchip.icicle.kit.ram";
>      mc->auto_create_sdcard = true;
>  
> -- 
> 2.34.1
> 

