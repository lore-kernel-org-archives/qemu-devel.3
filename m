Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B03C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAnXQ-0006Yf-Vm; Sun, 27 Sep 2026 07:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnXI-0006YG-5W; Sun, 27 Sep 2026 07:59:16 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xAnXD-0007vY-3K; Sun, 27 Sep 2026 07:59:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgvky11BjFY2KvwuhKyqS956N87LgV1tsSgdVqa8m8IJEEMUpnweJrFdkDb/LMa+KDZxooRkgxNpLSn/y5h1bHgbjjtd+PQhitSPQFQ8gTaH2OzSVU401QL51KlhvMWHFDs62/fMMng2TOoHcjE85D3bclIUFdl0ByCCFI/Nt+0b+zFfrU95f3y23SVfJMBw4eOE87ccDtMcQFknKhBjkvsiCJCSy/ZFOex2Jk69PZpwBMUu22yFP5iQj7qCGez3zn0r425psPoGrC1jzFDfhyfCAEe6qIOYpxBIUDR+TosquGrz/grJrP4LiN61g3WHKWIBqGtftGklQAMiqyrrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCi7NqPB/2EvMw7QBBY8osRp/8Enl+UX112YdsZuQNI=;
 b=lGvZ/LUJAz3LvKTbYmCLirs/abbjpaM1+cSKRDQvBTBVFttViKDOBh8io+f9nAyUUPXxmqdGRqjo7OZamLhICH2pf7f9xUk8UeigriULzSB1FiSiSuU1lXQgL8dyzOx26ytaIHrDTA/1P5wn8+89hOizebWJwP8PZk0svYauk3Ur3H8CDB+k2TP8Bd+Akl3YRbUjOpflEoEDKf/PeZ3Uzlk5igx4i+nUKxKPwtDbcAna/D/u2ARw9qRKbBIscKWYUm3reu60XtMo8NT8zAMq9IPnSFVHMyv/scPghr8LjZ9zzZAa/XiM0F4Quie7QqPhksJyPLQuHRogy24TYsRLag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCi7NqPB/2EvMw7QBBY8osRp/8Enl+UX112YdsZuQNI=;
 b=j27+NH+61+VxJ68BAltKWyVe8kwH3JJ10DU73GjJ7wGzRMtfqlUxH72UdAl7dvgVQ67JYgrqIdv299vOlpOaz2I0JKXHGb1u41Jzw9UnspT6ipLfx98pYJTYalGa8/xNqpiv1IgmNMQTek18AyPrBkHNTMiPbfdy9sZbOVErfQB8lIQLShKbrHdjYL6HXeygvJ3zQJu+jqdSOW8DWHVfLJAWc6wuPJqhoIJm5A0VWGqJWeB29Va6iM9a/kB7v6IAeCMR/uTtCnzEc7UDfnNooTT/o9Ct6V51+RXOTlmMIM9F7vPas5G8BQRDqvVm3gm8smY4c59HgDsh1+YwTE7JIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com (2603:1096:d10:a3::10)
 by KL1PR02MB7331.apcprd02.prod.outlook.com (2603:1096:820:11b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:58:59 +0000
Received: from KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d]) by KUXPR02MB9336.apcprd02.prod.outlook.com
 ([fe80::1451:cb49:7950:b10d%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:58:59 +0000
Date: Sun, 27 Sep 2026 19:58:51 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 1/6] target/riscv: Add cfg property for SiFive int8
 matmul extensions
Message-ID: <arkE1CGqmhPcilJW@MacBook-Pro-4.local>
References: <20260927082534.3228237-1-max.chou@sifive.com>
 <20260927082534.3228237-2-max.chou@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927082534.3228237-2-max.chou@sifive.com>
X-ClientProxiedBy: PH7PR17CA0036.namprd17.prod.outlook.com
 (2603:10b6:510:323::20) To KUXPR02MB9336.apcprd02.prod.outlook.com
 (2603:1096:d10:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUXPR02MB9336:EE_|KL1PR02MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cc293d-df0a-46da-a7a8-08df1c8eb701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|3023799007|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: NBQNB76LEOwnnix73xhTMXTnv/SNK9NRe7zpT6+zGmtQRPo0tzkYvvmvGyMVea5blHU18/+CxtO8SQ4qzZvjXblPNIVsaGgEVK52gKqFF22AL6JVE8PqHvDI/0wCxNy8Wemxjn8X70+i751dZFwfuZFEnahps9X37v6/1M3tI9OgtgbW2/vuCtg6aflV7X4/juIBmWqITpAJecgi2x/bcw4QHLgcJoE+xwxNTtbjXiPqhvJFYud9QK3fcXHuRsQwBFur0yQRZ6fF6F+VQ1wfiVaNjKEXL1kstrlbgwOL/OAYMTa3ujKjlQvtqOuhGGA86zeEv5vc7fu9nKY6epE2k6ONqF8DDhultdobl3xfze741K9Vx1BirQ4RvWRCPXNz0l60XU1e8lTh3ncVv3lLxeqNef0cHsrVsqGD006Z0acWtmF3Rj6gZWbASsi18ut2oXkZoOO0N/BlVriMFbAXhVuXeWg3SE29IVxE7fYhZSbRGfHOjw0fH82o/WDmVJuaaul4DnoEIfxV7SCEIaYrw0viFT2btgUW+X6vLmeT2LesebuRV9juqCIjtdvqnezLXTbWy2IGR8+n62llThymhnJWsXP5It1ejU9NB1JOwmYF+oJfzu2idPLPv5bFF1SjKDD+l2tMsHnx7hDLiv2n8+9AwNFf7cnNaLh7G1cz6Yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUXPR02MB9336.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2l5STsTWGbz0XJZiufFasgsJ6CKFUnmpHjv/u806SGFhek7cmw1FDLMRT/DA?=
 =?us-ascii?Q?L+uB8WdR4Ti9J9u8adEIoCQMEphkMkit/C/fiSq2npILuCIYnJcwRYKM/CC4?=
 =?us-ascii?Q?FGiCqmGxEeCKdW15cKmuE5bXAVua6EKQU8tccHfyuyzNVAeoOWqc1+yaR+LJ?=
 =?us-ascii?Q?ksd/Bd8jReRweESBZWV83usbAd0JqdjEdC4ZfXtALOiUBM4I5+TkyN/QTjSL?=
 =?us-ascii?Q?vCZFeHmIkuS4/y/YMtFDHQUZTCg6hvgN4Zb+RGsUam0S/1LN3FJHjIrcNlRg?=
 =?us-ascii?Q?kAdz8Pjf8/8cjecahw4d7oBRcwgD9pa0Mj9aJxUwnQdPGy8f5XmKSHNQPiO8?=
 =?us-ascii?Q?+/Y7vH6r2d94/FJATHfWE29OnAaucjo9WXhzCKPjlCOh5SEAPLGKZ9OfhM4Z?=
 =?us-ascii?Q?bLi1Q1er9wvHjTjV2xXvIxWbLXmn+CxooOL6bx5XIf7KXprwl1R4G9qDYooa?=
 =?us-ascii?Q?nAqjdWJi6eehN0l/PNOBzBAUfW01pFGjykFgOAB+COlUVLPkiLmIlXb0aWmi?=
 =?us-ascii?Q?EJZS+djcVa+T46H+hNWOY6CZ7Upxl4QL+WxsJ0trYVs0GUG5deIysmPaNBQS?=
 =?us-ascii?Q?YtbnF8gC6Oqhh9stuS5FuXy6Qkd6Y3MLAo/fV+JfpLx5gf2U3YJMb4aAXQ9p?=
 =?us-ascii?Q?FqAyoxhI6GVXbW9469EC7JoGDtTdMwCXuBHihqwrvFQRCvmv8hDWGD/A5+oD?=
 =?us-ascii?Q?9ez+Yhw5kdWR1vFQr8mhDyHfhPUQdCgqI9MU8NrYz/iHfZ6LxFPfiTO8BPu4?=
 =?us-ascii?Q?OmuFfUx9EOQxG77wvAr/y11GPZFCNd4tSoeE4PkaqtY6yUMZiCyhWArhUx10?=
 =?us-ascii?Q?3CQZpMvSUXqNyT0488l6mT5QGEg1qs7Hq/TfbScpE6CnzbmYv1JIjW1hhQVK?=
 =?us-ascii?Q?SBdZFhS7CzM8CrbprggY40ipgggtNUs2HeCM79ihUmzfEVU3KTDbv8w5761V?=
 =?us-ascii?Q?HpPxlmSpXVAsQHb9Ho5isC6hP6ojGzdEBj3JBmf++B5UAWr8Q6o70dnfXtWC?=
 =?us-ascii?Q?6t/BzTP+vF0uTP5qRIKwn9WgA4H6bxxamMBRe/IuyHEgxltm4TGD2e7EPsNW?=
 =?us-ascii?Q?+qnWs8MHrgXGZ55nBxzNOAIlV8ZfL6fTfOMHvkjU8lBAss43Q0KzwTi8cyf+?=
 =?us-ascii?Q?iHVnGUGGoKM6GDowftNC2gQzsK9qg62Ykj3kEhq9tkjxOxhcva12bOw2H4tU?=
 =?us-ascii?Q?1l0bWY1IpXV6bRLbYxd2BfBSEOTYQnujWgXySxNsXbuQNIYHRA119Rat9ErT?=
 =?us-ascii?Q?rbh0jErlwluIFWDvz5+YOnJsX2rpsY1meqVDsl0f6z/js0MS635OzyrhD9+V?=
 =?us-ascii?Q?HtUtg5RtG+qV/+iAstsixXRW3KMdUQKs2KUsFpCxXbx3m0lMpVTNnitEwpl0?=
 =?us-ascii?Q?XVohHfhAxe12PKyQBEVtC7qLSp5O/jWibFp+OPVL+ZWpn5hlDTa4s3GAkhax?=
 =?us-ascii?Q?zwBJxLz7QaORzkPn2mA87Cd6se8TkVfP4kARjScLFJo6UP6hhYMDuqpCin+G?=
 =?us-ascii?Q?dsDcj6GjwTGrd9dz0S0am/oWvrhoJpxTBtuDZfTnuhNz6OpJfO2nWLDxqEZg?=
 =?us-ascii?Q?Q0pjVRT+6Q/nKUz6256N9cvf/ArF/NwsflpKkw8e5QsjVPWIu+TDiiF7cmwQ?=
 =?us-ascii?Q?M27Gf8LXLwSCYBToPnp3t1A77eLFGChcuGt+18vK6EI5fGoH3U7kz1hXkPio?=
 =?us-ascii?Q?oSZQsWug/pjN5kcg27qfYy3iVLb4knonGGz1m79LHGVS9qVM/s4joFEz/BNX?=
 =?us-ascii?Q?aFwfHoMK5oa4fF/m2VE7bZkd9DaNa1A=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cc293d-df0a-46da-a7a8-08df1c8eb701
X-MS-Exchange-CrossTenant-AuthSource: KUXPR02MB9336.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:58:59.3572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWVu1x/NqkAmNZ0rLx8vkQQGyCxRGLOoMgkQ+mTAtRRNBRoFF02SidgJERK8WKBCCYyHLIV1oGizYyQM+IO6yAGMdMH/RkOeVb0x/Amc8So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7331
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

On Sun, Sep 27, 2026 at 04:25:29PM +0800, Max Chou wrote:
> Add the CPU config properties for SiFive's custom int8 matrix
> multiply vector extensions:
> 
> - Xsfvqmaccdod: 2x8x2 int8 matrix-multiply-accumulate operations
> - Xsfvqmaccqoq: 4x8x4 int8 matrix-multiply-accumulate operations
> 
> All instructions of these extensions require the Zve32x extension
> to be present whenever either extension is enabled. Validate this
> in riscv_cpu_validate_vendor_ext() alongside the existing vector
> extension validation in riscv_cpu_validate_set_extensions().
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.c                |  2 ++
>  target/riscv/cpu_cfg_fields.h.inc |  2 ++
>  target/riscv/tcg/tcg-cpu.c        | 16 ++++++++++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index da4c1a090b9..55833896bef 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -299,6 +299,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
>      ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
>      ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
> +    ISA_EXT_DATA_ENTRY(xsfvqmaccdod, PRIV_VERSION_1_13_0, ext_xsfvqmaccdod),
> +    ISA_EXT_DATA_ENTRY(xsfvqmaccqoq, PRIV_VERSION_1_13_0, ext_xsfvqmaccqoq),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>      ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index f91c780299c..0f3bda1331c 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -159,6 +159,8 @@ BOOL_FIELD(ext_xmipscbop)
>  BOOL_FIELD(ext_xmipscmov)
>  BOOL_FIELD(ext_xmipslsp)
>  BOOL_FIELD(ext_xlrbr)
> +BOOL_FIELD(ext_xsfvqmaccdod)
> +BOOL_FIELD(ext_xsfvqmaccqoq)
>  
>  BOOL_FIELD(big_endian)
>  BOOL_FIELD(mmu)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b68160af830..4f132488b9e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -416,6 +416,16 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
>      }
>  }
>  
> +static void riscv_cpu_validate_vendor_ext(RISCVCPU *cpu, Error **errp)
> +{
> +    if ((cpu->cfg.ext_xsfvqmaccdod || cpu->cfg.ext_xsfvqmaccqoq) &&
> +        !cpu->cfg.ext_zve32x) {
> +        error_setg(errp, "Xsfvqmaccdod/Xsfvqmaccqoq extensions require "
> +                         "Zve32x extension");
> +        return;
> +    }
> +}
> +
>  static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
>  {
>      CPURISCVState *env = &cpu->env;
> @@ -793,6 +803,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    riscv_cpu_validate_vendor_ext(cpu, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
>          error_setg(errp, "svukte is not supported for RV32");
>          return;
> -- 
> 2.43.0
> 

