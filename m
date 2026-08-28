Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C50C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 02:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzmjw-0001ji-AJ; Thu, 27 Aug 2026 22:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wzmju-0001jN-5d; Thu, 27 Aug 2026 22:54:46 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wzmjq-0007aq-Qk; Thu, 27 Aug 2026 22:54:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6g4kRkRNlFg6IywnNADRdYp284nMZEyAOud2sUkFQFvbRbYqbt5N59b2aZpxWOqucB+uyTSEul/HWEeg/SD4xp5vHIq+ZeMaGWiqfrTEze8bCDqAKxtpsYHIVHRsvAbzDJ6d4wQFUlVohH8EGk3Bnd2sIPpRNSrMwni1aUPe7WtTKGCacOG4Yg2OT+T+85xmCOuiHa2oqwAAWfMTYpvbBu2UhMtsao+xIcp4Qxf5NMnYZZj8ksnjDc18+uEnPshopAmClHli5cL78e8jotNaF9oaxJK6Q7v3QOusm7zTDYT+kkZmmj9SQGZ/Wm2OUwES/GwUHzqYd+6f97TgeraUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUJp0LpR4/6+HULctwLQNMzppZNYYBA85R8t7cHKquI=;
 b=dL1pP/II4xP5y0qNjqWX0imwc+0ZyndehJkKMzJW8aI+2oT+ZPmyhVbGEXKB4nMH/KjFh39OTA+8m51gjk8aqm1lYLJYP0CS5+M3Oda5J/z3P5A3JXbGU7EuIkKoPjQEfjXuQe8hJFMBoTk86KX+2H4QY4nUeitxv1H8GYhVLFNsymAYP7xlwAXCdcbJ23//8so1HQeAc/rJhnM9sn4Va+WADHZg4mT+sIG4BIYGs4I78H5Fc95+6n91i5M8mX5x9KwVWUEzt9xKVz1Dz0O1mNQfM2eo8Yz5c6Boohjx3Nt2d9TGfG6YpPFQ42kOijwaAk35uurGEDm2mbMxhnQmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUJp0LpR4/6+HULctwLQNMzppZNYYBA85R8t7cHKquI=;
 b=cIyoGj/LWWo9hTbC91hiAk4EmVIZnBPaN6G/nw/oTIMGdViubIAiJVEbjW/OHWb1Dbl4wNbVR3Z9QCb73l3mANbll6cjqwk6mPweY26m5+RZTdKwLWqQedoqoxXOR+g4GiQrV1vK9wR7OQymsqhAN8Kv8EpLNVJ8XCI27+FXVweGnPKVLfREEN1ukoQ79UPQeSyDSHhMwILpphXSmAJ/eRKPJlhBVLtzbyXch4nr5+EZdsd6G3E1c29NpNUBHM3HbN/cvxkjZzctGgLjsQyP2c42eAjgcpvyMlAKclS1uZK/YKhN04QRjlWAkkA1XHUPdwYnfBl8u3l6pp07cx9Tzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB7685.apcprd02.prod.outlook.com (2603:1096:101:1f7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 02:54:33 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 02:54:33 +0000
Date: Fri, 28 Aug 2026 10:54:27 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: Re: [PATCH v4 01/14] hw/riscv/fdt-common: prepend helpers with
 "riscv_"
Message-ID: <apD4XOyu7cvwZie7@ChaodeMacBook-Pro.local>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
 <20260827222608.329788-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827222608.329788-2-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: ab490b0b-e758-4cde-dbaa-08df04afb018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Lf36hK9IVz5bsXN5RPGj0yvGSE18wD2Tk8q06fdoRbUMOKDJDncnm2Gat1PpCYSK52QtMoI6C1hLzNylcGyLK7qdEnzg7Q2avvKu5ba7+KwPeD4Q+YszYkV53GIwdjzz8zz92LxXGxX2FjjTUGIui1CpC5dq5c/+hVz8cPX7He8yapT+ZA7JPjdOZ+kLLNq/dUUbQ/COeZjKDBBE+5LsZq3nmgdgBcD8N3ACq4Matum6tONFJoZ1NhZ8bGUAy1uPfcV6QNHCb/Lu7H+yAlwlHU8+G23QC4jyP2BtDMPoYBHvYznRV+paWqpntGLmAtP+xAH1RhgPVDU7TYsUkLuPE78nMvGkVSoWvxqv4Px7LDb53s/yeL0+Q6wzvs0+gLbodu6EUkl+J+9hgA5pIKfp6VNVFcLJfIA9j0tdwRtt5tFw1j8uo9f4dIulqPabjL+J62k/2wUFz2w/8sKs3pBKwa1oBAWroN11Hquv5RlgVYOr4uXo28frCH3Ujxl27cwpmNU9C8TihBhVDoeWU2VK0Yo+au8NPnhoW9Mg3cohwbv+k8w0B3e3Z+vPqv1/pJvffSUxRX3ZkldpkOhAfdZq+MvY1pRWlYz2YRgircFdEPGEfzWUA2b4xfg2I6gzIXDs3/BUoHcaR23R7ZGbFE3026vt6+Nba8eAS0Qf4pBH1ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?515Jfnlifx+IcRlpUyXzKcatftJo60FCoKoJKn1KzNZHs0hgxAnH7MhBiv?=
 =?iso-8859-1?Q?HDkab2OroKURj9lkDhOZWGugTt4Fgy1uuLWiQmsmdXJSo9pdeu0wvXKGS2?=
 =?iso-8859-1?Q?SzykQepdMn9KD6VT1peZPPy9IepCKWdf2MD1UGIemBjaa1bZYdhZl2ACMI?=
 =?iso-8859-1?Q?JFl8cbsjEUaL5Z3GXn2lOdqOQaqAGBDsGpsf9W3mPGle82vvWyj/BtXMly?=
 =?iso-8859-1?Q?dU5b1yfJ6jVI10y4xA5fnazYPw6om8tlh1ASso5W08gp2t4sAfKUzUYBFe?=
 =?iso-8859-1?Q?qe3Qhsp7LJOz4X0ZflUzZ7Jqj5J5oH82MqAHCeaafsm7t3UuYgFbat7Jrm?=
 =?iso-8859-1?Q?R7OeB7l16LTfCvCVvgJCoRKU/bqbQtVYuHXlH1mNJk+Cw7v8KIbBBKBubb?=
 =?iso-8859-1?Q?MLdf4ZNYIl4n70qpQK4eS/VEEkwRAQTZ+aQuK7vcTm4GzTcbtX0tchQIBS?=
 =?iso-8859-1?Q?Owv+d9Ww9TFfQ2/7rF0vEgpF99wl9qIu5YIGLWQMN4eFAvNEab1Pk8yLM/?=
 =?iso-8859-1?Q?8j9PkSAvMJUfh5sk3N/cW2HwPoz5yb63mq1tUJ+4qA3aCWtiLSQ7ena0+v?=
 =?iso-8859-1?Q?ClZHNXzi1/VhQMYDoip04ExqnSCIMNeHJqdc6Civ0YvUcUbSjjBTRBZzPb?=
 =?iso-8859-1?Q?TneesbmfsYYd1eAybNtTKsKpLq7gWJgHhR7ySNjbFtU5Of0to/Y4tr4lhv?=
 =?iso-8859-1?Q?bhQ6SpZjrviKzHOwq6o3h6CYDTuuxoU8HoQub4mILh5qTyfHZM0uWfxn5r?=
 =?iso-8859-1?Q?eGj2Sa+VKcTN85dtne227mheQxlWs/LW0lMVgbhay1qkQSqFLvuci6VGAE?=
 =?iso-8859-1?Q?13iw6VKIyRvBpL2u9zoiVSllP2bSVkwpjj6TWZ6zSvE15ZaAILFttUTIjq?=
 =?iso-8859-1?Q?EhwOitlYUyHt3aHINjO7+8B0159LVV1IRi6fl/SbWxr/26MD1ajMStqiQi?=
 =?iso-8859-1?Q?GSiX81JabnbxIDNn/oexef+ShQqX1Sh74IROYtR0JGC9VEcyFhBK+tlfPD?=
 =?iso-8859-1?Q?ht5n8wT0GV3MhBBvNc2Y5ym3jEzvDUviUyeANO9uh2mEKiHfACtNLmZA8s?=
 =?iso-8859-1?Q?/MudBIFf1l4Wpf2SqSP/MgisQhL19gX+qaHZA1OWUY0MIDDc4CzkuSx/HQ?=
 =?iso-8859-1?Q?CAT4NiXfAGG7zk2zMWNGQlhQU8fZuqo7LO1/h9HsJW1ZK/6XyoEimfsLbl?=
 =?iso-8859-1?Q?v6nhf4VOrX9ie/B6vkb83I5+aq0nIqsW48bY23BEUa9p7yuDg7ZqX+HfBy?=
 =?iso-8859-1?Q?bqmWxiHL0co6gL4EPq6tzOgfjpldAII+/FIwwP8k1ypbD3yeyIHUTDY57i?=
 =?iso-8859-1?Q?eamzPx/R1mlwgpa6Tt7Xu4kv5rGbJnq7/keF/yVUsfRvg4qh9INVETngLe?=
 =?iso-8859-1?Q?zCL6sc571i44aXhufCudqeyWuBxvqb+Kvwtr2KsXpYHf2iiWkNhUzDs/jH?=
 =?iso-8859-1?Q?11aAiqyDDETiTY0nwtB0K3GHq8HNNH2KpICPi7CrEsu7zSvwpiQXfuXGD2?=
 =?iso-8859-1?Q?17l3+72GyIrYtvDpnDOuMRyeKTjIG6cL3LWhbRmti+6wcW3MWkohGtjCpn?=
 =?iso-8859-1?Q?JVKgkJqW2OXlL8qiQmWfTNHwDi3zbcEy18CxWFJskEwM+9Hj8R8TYLvKS9?=
 =?iso-8859-1?Q?OSIdP1huxugKzXShHaO+ZmRn7jIGbvGIiLalnGHxl00arnOZf2A806Qy+E?=
 =?iso-8859-1?Q?OncQkId78bwvnyUombXVAKI0mc6P+zTLz/oY6Rcl/V2EqYVIUd4i8Sq+mY?=
 =?iso-8859-1?Q?NpHPrQYyMOevlUMx8S+0qXKq2OiF6lK/hoOTuvHJNIX1WV0/JchssjGuFi?=
 =?iso-8859-1?Q?ekJ6cB+3VP+8caSWb8CRbigyLKshttw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab490b0b-e758-4cde-dbaa-08df04afb018
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 02:54:33.2296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySyKfv507eE4DniONXiRVhn4ANjN4gDIFS96SYChIuQyXwhPdto2w9kTUy6/GKQvyPwXfSqVNQq/Sf/pCCDL2H/vcASNAe+KMK+JNJp2s2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7685
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Chao Liu <chao.liu@processmission.com>
From:  Chao Liu via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 27, 2026 at 07:25:54PM +0800, Daniel Henrique Barboza wrote:
> Given that the helpers are public API we should prefix them with
> "riscv_" to avoid conflicts when linking with different targets in the
> future, i.e. we should not use generic names like
> "create_fdt_socket_memory".
> 
> Despite the amount of lines this is a mechanical change and no real
> FDT changes are intended.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/fdt-common.c         | 45 ++++++++++++++++----------------
>  hw/riscv/sifive_u.c           | 34 +++++++++++++------------
>  hw/riscv/spike.c              | 30 ++++++++++++----------
>  hw/riscv/tt_atlantis.c        | 22 ++++++++--------
>  hw/riscv/virt.c               | 42 +++++++++++++++---------------
>  include/hw/riscv/fdt-common.h | 48 ++++++++++++++++++-----------------
>  6 files changed, 117 insertions(+), 104 deletions(-)
> 
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index aa143a618b..3a8da03cfb 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -14,8 +14,8 @@
>  #include "hw/riscv/fdt-common.h"
>  #include "target/riscv/cpu_bits.h"
>  
> -void *create_board_device_tree(const char *model, const char *compatible,
> -                               int *fdt_size)
> +void *riscv_create_board_device_tree(const char *model, const char *compatible,
> +                                     int *fdt_size)
>  {
>      void *fdt = create_device_tree(fdt_size);
>  
> @@ -38,8 +38,8 @@ void *create_board_device_tree(const char *model, const char *compatible,
>      return fdt;
>  }
>  
> -void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> -                              int socket_id, bool numa_enabled)
> +void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> +                                    int socket_id, bool numa_enabled)
>  {
>      g_autofree char *mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
>  
> @@ -52,9 +52,9 @@ void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
>      }
>  }
>  
> -void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
> -                             int socket_id, uint32_t *intc_phandles,
> -                             int num_harts, bool numa_enabled)
> +void riscv_create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
> +                                   int socket_id, uint32_t *intc_phandles,
> +                                   int num_harts, bool numa_enabled)
>  {
>      g_autofree uint32_t *clint_cells = g_new0(uint32_t, num_harts * 4);
>      g_autofree char *clint_name = NULL;
> @@ -84,7 +84,8 @@ void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
>      }
>  }
>  
> -void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency)
> +void riscv_fdt_create_cpu_socket_subnode(void *fdt,
> +                                         uint64_t timebase_frequency)
>  {
>      qemu_fdt_add_subnode(fdt, "/cpus");
>      qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
> @@ -169,11 +170,11 @@ create_fdt_socket_cpu_internal(void *fdt, char *clust_name, RISCVCPU *cpu_ptr,
>      qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
>  }
>  
> -void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
> -                            int socket_id, int num_harts_socket,
> -                            int socket_hartid_base, uint32_t *phandle,
> -                            uint32_t *intc_phandles, bool numa_enabled,
> -                            bool is_32_bit)
> +void riscv_create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
> +                                  int socket_id, int num_harts_socket,
> +                                  int socket_hartid_base, uint32_t *phandle,
> +                                  uint32_t *intc_phandles, bool numa_enabled,
> +                                  bool is_32_bit)
>  {
>      g_autofree char *clust_name = NULL;
>  
> @@ -191,21 +192,21 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
>  }
>  
>  void
> -create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
> -                             int cpu_id, int socket_id,
> -                             int socket_hartid_base, uint32_t *phandle,
> -                             uint32_t *intc_phandles)
> +riscv_create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
> +                                   int cpu_id, int socket_id,
> +                                   int socket_hartid_base, uint32_t *phandle,
> +                                   uint32_t *intc_phandles)
>  {
>      create_fdt_socket_cpu_internal(fdt, clust_name, NULL, cpu_id,
>                                     socket_id, socket_hartid_base,
>                                     phandle, intc_phandles, false, false);
>  }
>  
> -void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
> -                     uint32_t plic_phandle, uint32_t int_cells,
> -                     uint32_t addr_cells, uint32_t *plic_cells,
> -                     uint32_t cells_size, uint32_t ndev_sources,
> -                     bool numa_enabled, int socket_id)
> +void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
> +                           uint32_t plic_phandle, uint32_t int_cells,
> +                           uint32_t addr_cells, uint32_t *plic_cells,
> +                           uint32_t cells_size, uint32_t ndev_sources,
> +                           bool numa_enabled, int socket_id)
>  {
>      g_autofree char *nodename = NULL;
>      static const char * const plic_compat[2] = {
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 57a57c96e1..852c48c056 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -108,8 +108,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>      g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
>      g_autofree char *clust_name = NULL;
>  
> -    fdt = ms->fdt = create_board_device_tree("SiFive HiFive Unleashed A00",
> -        "sifive,hifive-unleashed-a00", &s->fdt_size);
> +    fdt = ms->fdt = riscv_create_board_device_tree(
> +        "SiFive HiFive Unleashed A00",
> +        "sifive,hifive-unleashed-a00",
> +        &s->fdt_size);
>  
>      hfclk_phandle = phandle++;
>      nodename = g_strdup_printf("/hfclk");
> @@ -133,10 +135,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
>      g_free(nodename);
>  
> -    create_fdt_socket_memory(fdt, memmap[SIFIVE_U_DEV_DRAM].base,
> -                             ms->ram_size, 0, false);
> +    riscv_create_fdt_socket_memory(fdt, memmap[SIFIVE_U_DEV_DRAM].base,
> +                                   ms->ram_size, 0, false);
>  
> -    fdt_create_cpu_socket_subnode(fdt, CLINT_TIMEBASE_FREQ);
> +    riscv_fdt_create_cpu_socket_subnode(fdt, CLINT_TIMEBASE_FREQ);
>  
>      clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", 0);
>      qemu_fdt_add_subnode(fdt, clust_name);
> @@ -157,15 +159,15 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>              riscv_isa_write_fdt(&s->soc.e_cpus.harts[0], fdt, nodename);
>          }
>  
> -        create_fdt_socket_cpu_sifive(fdt, clust_name, cpu, 0, 0,
> -                                     &phandle, intc_phandles);
> +        riscv_create_fdt_socket_cpu_sifive(fdt, clust_name, cpu, 0, 0,
> +                                           &phandle, intc_phandles);
>  
>          g_free(nodename);
>      }
>  
> -    create_fdt_socket_clint(fdt, memmap[SIFIVE_U_DEV_CLINT].base,
> -                            memmap[SIFIVE_U_DEV_CLINT].size, 0,
> -                            intc_phandles, ms->smp.cpus, false);
> +    riscv_create_fdt_socket_clint(fdt, memmap[SIFIVE_U_DEV_CLINT].base,
> +                                  memmap[SIFIVE_U_DEV_CLINT].size, 0,
> +                                  intc_phandles, ms->smp.cpus, false);
>  
>      nodename = g_strdup_printf("/soc/otp@%lx",
>          (long)memmap[SIFIVE_U_DEV_OTP].base);
> @@ -209,12 +211,12 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>          }
>      }
>  
> -    create_fdt_plic(fdt, memmap[SIFIVE_U_DEV_PLIC].base,
> -                    memmap[SIFIVE_U_DEV_PLIC].size,
> -                    plic_phandle, SIFIVE_U_PLIC_INT_CELLS,
> -                    SIFIVE_U_PLIC_ADDR_CELLS, cells,
> -                    cells_length * sizeof(uint32_t),
> -                    SIFIVE_U_PLIC_NUM_SOURCES - 1, false, 0);
> +    riscv_create_fdt_plic(fdt, memmap[SIFIVE_U_DEV_PLIC].base,
> +                          memmap[SIFIVE_U_DEV_PLIC].size,
> +                          plic_phandle, SIFIVE_U_PLIC_INT_CELLS,
> +                          SIFIVE_U_PLIC_ADDR_CELLS, cells,
> +                          cells_length * sizeof(uint32_t),
> +                          SIFIVE_U_PLIC_NUM_SOURCES - 1, false, 0);
>      g_free(cells);
>  
>      gpio_phandle = phandle++;
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 630b65f569..8d7e93807c 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -61,8 +61,10 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
>      uint32_t phandle = 1;
>      bool numa_enabled = riscv_numa_enabled(ms);
>  
> -    fdt = ms->fdt = create_board_device_tree("ucbbar,spike-bare,qemu",
> -        "ucbbar,spike-bare-dev", &fdt_size);
> +    fdt = ms->fdt = riscv_create_board_device_tree(
> +        "ucbbar,spike-bare,qemu",
> +        "ucbbar,spike-bare-dev",
> +        &fdt_size);
>  
>      qemu_fdt_add_subnode(fdt, "/htif");
>      qemu_fdt_setprop_string(fdt, "/htif", "compatible", "ucb,htif0");
> @@ -71,7 +73,8 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
>              0x0, memmap[SPIKE_HTIF].base, 0x0, memmap[SPIKE_HTIF].size);
>      }
>  
> -    fdt_create_cpu_socket_subnode(fdt, RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
> +    riscv_fdt_create_cpu_socket_subnode(fdt,
> +                                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
>  
>      for (socket = (riscv_socket_count(ms) - 1); socket >= 0; socket--) {
>          g_autofree uint32_t *intc_phandles = g_new0(uint32_t,
> @@ -80,20 +83,21 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
>                           riscv_socket_mem_offset(ms, socket);
>          uint64_t memsize =  riscv_socket_mem_size(ms, socket);
>  
> -        create_fdt_socket_cpus(fdt, (&s->soc[socket])->harts, socket,
> -                               s->soc[socket].num_harts,
> -                               s->soc[socket].hartid_base,
> -                               &phandle, intc_phandles, numa_enabled,
> -                               is_32_bit);
> +        riscv_create_fdt_socket_cpus(fdt, (&s->soc[socket])->harts, socket,
> +                                     s->soc[socket].num_harts,
> +                                     s->soc[socket].hartid_base,
> +                                     &phandle, intc_phandles, numa_enabled,
> +                                     is_32_bit);
>  
> -        create_fdt_socket_memory(fdt, memaddr, memsize, socket,
> -                                 riscv_numa_enabled(ms));
> +        riscv_create_fdt_socket_memory(fdt, memaddr, memsize, socket,
> +                                       riscv_numa_enabled(ms));
>  
>          clint_addr = memmap[SPIKE_CLINT].base +
>              (memmap[SPIKE_CLINT].size * socket);
> -        create_fdt_socket_clint(fdt, clint_addr, memmap[SPIKE_CLINT].size,
> -                                socket, intc_phandles,
> -                                s->soc[socket].num_harts, numa_enabled);
> +        riscv_create_fdt_socket_clint(fdt, clint_addr,
> +                                      memmap[SPIKE_CLINT].size, socket,
> +                                      intc_phandles, s->soc[socket].num_harts,
> +                                      numa_enabled);
>      }
>  
>      riscv_socket_fdt_write_distance_matrix(ms);
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index babce2b680..812051a11f 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -91,16 +91,17 @@ static void create_fdt_memory(TTAtlantisState *s)
>          size_hi = MACHINE(s)->ram_size - size_lo;
>      }
>  
> -    create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base, size_lo,
> -                             0, false);
> +    riscv_create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base,
> +                                   size_lo, 0, false);
>      if (size_hi) {
>          /*
>           * The first part of the HI address is aliased at the LO address
>           * so do not include that as usable memory. Is there any way
>           * (or good reason) to describe that aliasing 2GB with DT?
>           */
> -        create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_HI].base + size_lo,
> -                                 size_hi, 0, false);
> +        riscv_create_fdt_socket_memory(fdt,
> +                                       s->memmap[TT_ATL_DDR_HI].base + size_lo,
> +                                       size_hi, 0, false);
>      }
>  }
>  
> @@ -225,11 +226,11 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
>      void *fdt = MACHINE(s)->fdt;
>      g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
>  
> -    fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
> +    riscv_fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
>  
> -    create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
> -                           s->soc.hartid_base, &fdt_phandle, intc_phandles,
> -                           false, false);
> +    riscv_create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
> +                                 s->soc.hartid_base, &fdt_phandle,
> +                                 intc_phandles, false, false);
>  
>      create_fdt_memory(s);
>  
> @@ -367,8 +368,9 @@ static void create_fdt(TTAtlantisState *s)
>  {
>      MachineState *ms = MACHINE(s);
>  
> -    ms->fdt = create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
> -                                       "tenstorrent,atlantis", &s->fdt_size);
> +    ms->fdt = riscv_create_board_device_tree(
> +        "Tenstorrent Atlantis RISC-V Machine",
> +        "tenstorrent,atlantis", &s->fdt_size);
>  
>      qemu_fdt_add_subnode(ms->fdt, "/chosen");
>  
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 329ccdb5a7..b796220fc2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -360,12 +360,12 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>  
>      plic_phandles[socket] = (*phandle)++;
>  
> -    create_fdt_plic(ms->fdt, plic_addr, s->memmap[VIRT_PLIC].size,
> -                    plic_phandles[socket], FDT_PLIC_INT_CELLS,
> -                    FDT_PLIC_ADDR_CELLS, plic_cells,
> -                    cells_length * sizeof(uint32_t),
> -                    VIRT_IRQCHIP_NUM_SOURCES - 1,
> -                    numa_enabled, socket);
> +    riscv_create_fdt_plic(ms->fdt, plic_addr, s->memmap[VIRT_PLIC].size,
> +                          plic_phandles[socket], FDT_PLIC_INT_CELLS,
> +                          FDT_PLIC_ADDR_CELLS, plic_cells,
> +                          cells_length * sizeof(uint32_t),
> +                          VIRT_IRQCHIP_NUM_SOURCES - 1,
> +                          numa_enabled, socket);
>  
>      if (!socket) {
>          platform_bus_add_all_fdt_nodes(ms->fdt, plic_name,
> @@ -601,7 +601,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
>      bool numa_enabled = riscv_numa_enabled(ms);
>      bool is_32_bit = riscv_is_32bit(&s->soc[0]);
>  
> -    fdt_create_cpu_socket_subnode(ms->fdt,
> +    riscv_fdt_create_cpu_socket_subnode(ms->fdt,
>          kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
>                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
>  
> @@ -615,14 +615,14 @@ static void create_fdt_sockets(RISCVVirtState *s,
>  
>          phandle_pos -= s->soc[socket].num_harts;
>  
> -        create_fdt_socket_cpus(ms->fdt, (&s->soc[socket])->harts, socket,
> -                               s->soc[socket].num_harts,
> -                               s->soc[socket].hartid_base,
> -                               phandle, &intc_phandles[phandle_pos],
> -                               numa_enabled, is_32_bit);
> +        riscv_create_fdt_socket_cpus(ms->fdt, (&s->soc[socket])->harts, socket,
> +                                     s->soc[socket].num_harts,
> +                                     s->soc[socket].hartid_base,
> +                                     phandle, &intc_phandles[phandle_pos],
> +                                     numa_enabled, is_32_bit);
>  
> -        create_fdt_socket_memory(ms->fdt, memaddr, memsize,
> -                                 socket, riscv_numa_enabled(ms));
> +        riscv_create_fdt_socket_memory(ms->fdt, memaddr, memsize,
> +                                       socket, riscv_numa_enabled(ms));
>  
>          if (virt_aclint_allowed() && s->have_aclint) {
>              create_fdt_socket_aclint(s, socket,
> @@ -631,10 +631,11 @@ static void create_fdt_sockets(RISCVVirtState *s,
>              hwaddr clintaddr = s->memmap[VIRT_CLINT].base +
>                                 s->memmap[VIRT_CLINT].size * socket;
>  
> -            create_fdt_socket_clint(ms->fdt, clintaddr,
> -                                    s->memmap[VIRT_CLINT].size,
> -                                    socket, &intc_phandles[phandle_pos],
> -                                    s->soc[socket].num_harts, numa_enabled);
> +            riscv_create_fdt_socket_clint(ms->fdt, clintaddr,
> +                                          s->memmap[VIRT_CLINT].size,
> +                                          socket, &intc_phandles[phandle_pos],
> +                                          s->soc[socket].num_harts,
> +                                          numa_enabled);
>          }
>      }
>  
> @@ -1021,8 +1022,9 @@ static void create_fdt(RISCVVirtState *s)
>      uint8_t rng_seed[32];
>      g_autofree char *name = NULL;
>  
> -    ms->fdt = create_board_device_tree("riscv-virtio,qemu", "riscv-virtio",
> -                                       &s->fdt_size);
> +    ms->fdt = riscv_create_board_device_tree("riscv-virtio,qemu",
> +                                             "riscv-virtio",
> +                                             &s->fdt_size);
>  
>      /*
>       * The "/soc/pci@..." node is needed for PCIE hotplugs
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
> index 1729a6abc6..371971d79d 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -11,29 +11,31 @@
>  
>  #include "target/riscv/cpu.h"
>  
> -void *create_board_device_tree(const char *model, const char *compatible,
> -                               int *fdt_size);
> -void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> -                              int socket_id, bool numa_enabled);
> -void create_fdt_clint(void *fdt, hwaddr addr, uint64_t size,
> -                      uint32_t *intc_phandles, int num_harts);
> -void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
> -                             int socket_id, uint32_t *intc_phandles,
> -                             int num_harts, bool numa_enabled);
> -void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency);
> -void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
> -                            int socket_id, int num_harts_socket,
> -                            int socket_hartid_base, uint32_t *phandle,
> -                            uint32_t *intc_phandles, bool numa_enabled,
> -                            bool is_32_bit);
> -void create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
> -                                  int cpu_id, int socket_id,
> +void *riscv_create_board_device_tree(const char *model, const char *compatible,
> +                                     int *fdt_size);
> +void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> +                                    int socket_id, bool numa_enabled);
> +void riscv_create_fdt_clint(void *fdt, hwaddr addr, uint64_t size,
> +                            uint32_t *intc_phandles, int num_harts);
> +void riscv_create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
> +                                   int socket_id, uint32_t *intc_phandles,
> +                                   int num_harts, bool numa_enabled);
> +void riscv_fdt_create_cpu_socket_subnode(void *fdt,
> +                                         uint64_t timebase_frequency);
> +void riscv_create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
> +                                  int socket_id, int num_harts_socket,
>                                    int socket_hartid_base, uint32_t *phandle,
> -                                  uint32_t *intc_phandles);
> -void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
> -                     uint32_t plic_phandle, uint32_t int_cells,
> -                     uint32_t addr_cells, uint32_t *plic_cells,
> -                     uint32_t cells_size, uint32_t ndev_sources,
> -                     bool numa_enabled, int socket);
> +                                  uint32_t *intc_phandles, bool numa_enabled,
> +                                  bool is_32_bit);
> +void riscv_create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
> +                                        int cpu_id, int socket_id,
> +                                        int socket_hartid_base,
> +                                        uint32_t *phandle,
> +                                        uint32_t *intc_phandles);
> +void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
> +                           uint32_t plic_phandle, uint32_t int_cells,
> +                           uint32_t addr_cells, uint32_t *plic_cells,
> +                           uint32_t cells_size, uint32_t ndev_sources,
> +                           bool numa_enabled, int socket);
>  void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
>  #endif
> -- 
> 2.43.0
> 

