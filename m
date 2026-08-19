Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6724C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwemi-00081W-CY; Wed, 19 Aug 2026 07:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wwemg-00080l-Ng; Wed, 19 Aug 2026 07:48:42 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wweme-0002ni-Ng; Wed, 19 Aug 2026 07:48:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfGyJV4t+s64/be+9FUQU8ZD97T6lVx9Rhzf/tUDFXNGjp008Sdf7gia24osYojZ5Pb3F+/wMVx6hD3i3/AF5tqZRqfKaoW+h2ir0+gTOHuWuKFwHdpSv86uEV9UwKoI04To7p1FPAPLpkkWA3jikYcRxrVadPiAjcX3hYOAWc09hfSBv7F1muDnxnwuwj8vJwzM0bodNPKQ7m0lHJzyZbnyrxMymbXyCfIMeYsnl1MhwD51UEoC6sJAovJ/bdJI04HZyinCyZWE9qkYs75hfZv01+SmE+qzaC9vYkC2Ssfa4pdJ4cXVkbMdzbHS8LHo5I5LU++7ASK3fnYORbt4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AxvBzb4Yd45n4loFV33k8QHPg57js9cGOVw3jGOL8g=;
 b=v9Frvs2tv+0dcCKPJ8d841uwsOjZlpi/vXbsH9hyM5swERNAcjG0LSz3Fvjt5ECdEkM6vEOm+K2gn3xBuhEe5exR3zn7Wej4OlWtyVs6WXMtDSeuGe4vXApB+B/x0c9AtDH0+CMrxzZlcpyXsI7uRXjCz0+3unoIcTkXZm0HMUYcDjQ8mVKczsYn+EzlAeSZ/c7nuTDmGP1cmFdlXJoCegb3sd6SOfMWWQ67UKmnv2RTnGbiUq00AlnR7ntgChwqFn6uF5TyBe8O5E3ZeyseNBwdQ8xslUAMvYLx730J7UgCw89OieFXU9VkEjeQCikKMYzm8u18vsRM8vG31Dpc7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AxvBzb4Yd45n4loFV33k8QHPg57js9cGOVw3jGOL8g=;
 b=nCn0omUecQMipRLzFRNv8z5IFBSOtHMuxeMCa5Xf95ZIm7lK9MEquPJrYUaMxd473ZhG+ddN63OdALIXGpVSTxovKhrgZpIw6XG26z/Ly7Jrklu34WFcio23uY26pS561EAHBexosEqtafk1So8D6hFHsfJjW8CXWzwmPQW2/xGYScR6kh1uzn0/agpieQtj/YpgxHmvWRv6yWKBcD+O7lEyyStINVVOrTRzNnPV76iS8WLdEwkK5VhY34ZBdtucxdRR8Pwkus/p9cmumxGC15gm8wLFNtiSZgAJnMeuQ/sj6uoQxXWOYwPk8Ko3SdNiy+k6TTGZJkOh6AYJhyY0Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by JH0PR02MB6820.apcprd02.prod.outlook.com (2603:1096:990:4a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:48:31 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 11:48:30 +0000
Date: Wed, 19 Aug 2026 19:48:25 +0800
To: frederic.petrot@univ-grenoble-alpes.fr
Cc: alistair.francis@wdc.com, daniel.barboza@oss.qualcomm.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] target/riscv: Fix sstatus update in rv128
Message-ID: <aoWYAIx74S25ZEmG@ChaodeMacBook-Pro.local>
References: <20260819105655.33391-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260819105655.33391-2-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819105655.33391-2-frederic.petrot@univ-grenoble-alpes.fr>
X-ClientProxiedBy: BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::17) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|JH0PR02MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e33198d-72da-43ce-00de-08defde7ca23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IkUcnGvFH4UzmOenzvRuxDGVFY53Cd1sCH1LzWM99mOcXvOpwY8RzXWGzRSxx3zx+uQXY8vkvF7M2mnTf7BR6jjRbG51GMUIBeTpuIwMuNdYOorEcYbvmvNxfdrLI0n21qjjRtHpv6bj3igrusEIkawuF/zeqL1Q7Jx65xyzPeBCtUJhapyUUw4y1H7+s5ov71Zcp6CGvVyYACIeXwJeAr+D/BrzgfDGGW2gHAwajhFH05/cHOz+3Gh98DgFr3pj4nL/HcSGB/+C6/uPdmI/thvwU4AmUM7j84Uyy0nfOzFyV113aDGTMEKdLPBQ4xGz9O5G9Uv55dA9PeYQ+OcOXoMryloqGQzi7EMLSgngxIPE6BxLCYhumQv5K7jNfqTIZyfKJRt9UO/G6lhvq1Qgv7bVBHcN5ip7PYAvcWRBZqNTrSah2913hfBd/n16iq5nGhvZ++bqprZwr5QVgcLs3fhsG3MhFiGDPIzS+0PrNkWPEt6cbYTD9+P6nN7O+mlKzVOSnxTL4ZU0Fny/r0fgwJ0GwZN5O1D8WteKBjafqtcfoWzjq17D+m7NFEB38rqxI+zbkkDDw9OiwCxAsNsly1FaR9lnSOk+TxwTDlMBwv19uVCzZeZCho7GFCOHD0v3QEWnR+QV1zWgpFAg0TygJqOkalAJDW/47e/DMfTb6xM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Q+r1bGjdyAbJxMKtRaqcNLp9ZzT0kbL3DgSvE+SUcxNFGeaiSHn8MxDjG1?=
 =?iso-8859-1?Q?lhUas8N1I/702UfwsAxB0NvwM47MHVbwDFR6hfEVWliHnZ2LP1HTE38sHe?=
 =?iso-8859-1?Q?e3RVQ9evQHHI4Sk5w66fLV9WJhAYZn3BSa5bFga2uBpe4ZaiMpwNoEOqST?=
 =?iso-8859-1?Q?xAVfrQJvhFES2fm2o5XD4OuPYkoijRJivlph+V2DopHC6UpBV6kp6TT3h3?=
 =?iso-8859-1?Q?PFbTkiJ5GFzcxO9C0OKsCiW12c8u4poXB3MvnsDBxe68KWDSROA3SUbzr7?=
 =?iso-8859-1?Q?wZ3QRoOCPrcMMSRd9ZetCrJ4ZYCHjc7prmwO6HMGpnjMfRcEE3yKoXnv4G?=
 =?iso-8859-1?Q?4epJk/FPI7GA1udnOgBZAnVLj4aBLGunxmtEy1k8e6eqMVUyulVfISb5T3?=
 =?iso-8859-1?Q?iAoLWyT+FudFCRHtLivJfiFaTGdj14/9W4gBCDFCQglb3T0cia5SkbWQvO?=
 =?iso-8859-1?Q?HrK6obztK7KCNlliryvxdmoZ9g4Mrzt9/tTrmVgiifqyFN8DyGLmxxhmQL?=
 =?iso-8859-1?Q?cndUp3+fYaWviafgBHFFIp9Slv27hOUjK2qtET1+DmQcqrfSiZ8xdOZ/pd?=
 =?iso-8859-1?Q?w7Ot1Ef94gKJVKPP5k7fO+wBf8wWcYc4LoYtG64RsbANk6dW+swmNPH8wX?=
 =?iso-8859-1?Q?0tJthKJ3t3abEFJWqa2VZ/li1ov/vqvyS7P3QpXR90BvBKG2/VibU7Wmmn?=
 =?iso-8859-1?Q?DUlISZlkQk4IculeliYlJdCniFJ9tt+3y0l6yhVk5HCQA+Y/xWMMlTdY0k?=
 =?iso-8859-1?Q?OWgo7w2WALJYHX+PTUjd5f2sxssXdK5w/NBMiXuQgsCbgsiFrX0B7YYO12?=
 =?iso-8859-1?Q?iYSCPzb11W4+vFtK1xpWtDcRkWOzymV+oPNXiWF6TiAsFleGB0fKRKQrRZ?=
 =?iso-8859-1?Q?9oKcYnQjFJgzSZ/3MkJS7kFpykNs7sAhnd9LZbgP6y7AqVz7c5/9NcfBk2?=
 =?iso-8859-1?Q?cbFXuZ3KaiQqzjhcRToHnpkEA4SuePqhxiAyn1yWLDZPxx0G9611XpAD4F?=
 =?iso-8859-1?Q?jBIo3qSCbXmbCoARXx8CfcLUXhcE3tyH4j5UI/j+aiuLB+d13RllmwO35W?=
 =?iso-8859-1?Q?yfiRxFboYXyYGVSLKoHFNdQG+LNdN3B0M8YxxbgndRDOZarRHUuZCQhzIW?=
 =?iso-8859-1?Q?w6g/FMgAf2xrRil/akdV3DpvO/cvSfwKrra7mBguwZptxhY/iz+8mtqvVa?=
 =?iso-8859-1?Q?KdZuV9qtB8DSPtcrvOZ2R0E/irn5m8BjksmB227uPXbfaVk9zyGbbB1B8I?=
 =?iso-8859-1?Q?KckbC7JqXdRmYeeTEGRANzcA3xw1RXYE2tp2kjyPAaO04t384c3tqhhZLq?=
 =?iso-8859-1?Q?FZzk7ulwJccEUw2AUtZHwDL4Zl1RrbpkVADa5cPm5/ee81FYQhqoRtRpNc?=
 =?iso-8859-1?Q?JA/NY3zynY/JU/ULsfqsLc3OoUuda1GoFyd/ctP3eA7auWfAEeIJ4uoh8r?=
 =?iso-8859-1?Q?CPpmbofrEvhKiE95LuKQVyRFykLSs7IVxUTXeBYHeOoMbQs/vlHxMzKff3?=
 =?iso-8859-1?Q?7UV2eyrpreCVxK2vFFMn4VYZGcMAdL9yEIwJYzDHCw6NQAxLGZBBQFN21D?=
 =?iso-8859-1?Q?9GapGBqa4WrHczN1IeHac7FC3HgT0meiqPYv4TcgMSv5b+2GVVEZmXSpUW?=
 =?iso-8859-1?Q?go+tTgyWCLaDJXPHqi4WF0+4b1uwKU7r72VAufi2qJqJ9hdCBSliWxE9r/?=
 =?iso-8859-1?Q?jxbGdzQ3ZF+jVeBq8y+v+U7Xat55qeiieTgs8Ot+12f8icvtpeIp3lq3wc?=
 =?iso-8859-1?Q?HjWQIDrGAzFlriQAbg/MlF3mNtjKU6ZzJymGm6Ce8xujfC23eS0TEJqwmR?=
 =?iso-8859-1?Q?S3NxQdyvYOj/a1GHwI5f8gsP1j4R5Eo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e33198d-72da-43ce-00de-08defde7ca23
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:48:30.6166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mTA0BdZCGHzp5SaRol9kDD5VLeHohqK+USNNSjiNON63YVTr7165czq2F/ePrSidWkvD0EjRSIoD26WQa6cvcAlMiqNFqrKIdS/V4KkcWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6820
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 19, 2026 at 12:56:54PM +0800, frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> The sstatus register assignment was performed before the write
> mask was fully constructed, leading to an incomplete update of
> sstatus fields on the experimental rv128 target.
> 
> Move the sstatus write after the mask completion so the full
> write mask is applied correctly.
> 
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/tcg/csr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index ffd751caa5..9cc6297328 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -3998,7 +3998,7 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
>                                          Int128 *val)
>  {
>      uint64_t mask = sstatus_v1_10_mask;
> -    uint64_t sstatus = env->mstatus & mask;
> +    uint64_t sstatus;
>      if (env->xl != MXL_RV32 || env->debugger) {
>          mask |= SSTATUS64_UXL;
>      }
> @@ -4009,7 +4009,7 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
>      if (env_archcpu(env)->cfg.ext_zicfilp) {
>          mask |= SSTATUS_SPELP;
>      }
> -
> +    sstatus = env->mstatus & mask;
>      *val = int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
>      return RISCV_EXCP_NONE;
>  }
> -- 
> 2.43.0
> 

