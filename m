Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECE0C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwemv-00082I-0z; Wed, 19 Aug 2026 07:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wwemt-00081p-Bn; Wed, 19 Aug 2026 07:48:55 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wwemr-0002rN-UD; Wed, 19 Aug 2026 07:48:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi4vT+K7e0BzkengtFGm5rizPRcEsRuhKjyoEXwfdRj1V9Kvpbep+SveCvgU9c3ucTnJCdvhmvfzuD2xV7zUaiSiWvhoF4PawEIDwHDa+k79fMv/9nYKsTmEZHb1qw/WfqpM5fRJelIk8pAit4Vaxf+QT82Gcc9Ytuwo7p5nquxS2kDyEPJPQUQBJbTPIR8o3pkXd39iBF73xUox43xovvNvuPVFEZ1x5BdbsBCLsseFyq/N6OQ8QEPQbqHeHMNWBT4eeKVjV7Mn94OIceAmOLPfeLHmm7OXtZ82RnqTZ6tXVF4cu1IZmeEVeFtDAQOCWZEc0UGnSQLpUyT4bL2Fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+5WzqrW6mJdOkkrFNkaIz+2PA5Pe2aZq4OTeqbT2wo=;
 b=c2pnnpM7zgltc1HPxARpHu+0cqtZ61i+Zb0rJCj8bC3SHad+4uz2pjN1Sv6AMlyu8NvsrsczUhCOM6L8pRkYim1ckGstcP/fkSk5l+9qt6mbi8UPI51dygEaTVMI8cLT9g8sIte1WlcrEFAGGuNk250poRungdLzc5cL/67zBiw5Cd97djwNEEZ6hTAjZUOsR8h4ecw9JCxu5aAd5BUJiF4CCNX8LX1E/UR5NFdKMNzEYL/gskyVY73slj+u0wgjaTfnJPOLIFA1fekzn2BUOLeKKylHEefXp5f5EvuVcPxhjHNfu/PGEid6+Op1aXKS7u239W2ElnwW7TMxoIyCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+5WzqrW6mJdOkkrFNkaIz+2PA5Pe2aZq4OTeqbT2wo=;
 b=u1z0ME27ZNeW/CWOd1UqzMS4aNr+iVCKyqCRELl2os4/lqn/uxZ4L8sH+SWcO3XiGH8a7j3vkVHxnOdejbl8k4LsGPZkJs3bvOet70y4XKYP0Sqx6Va3JL9HHzm1hSHXriMSTOl16ZFZ5ThUqGmAiPuLwxwcN+Slj8qF51SVstpkeiWVVwqlGffn6BmLa6k3D1SReLf5a3sI6qwLP8QYOyPqEK08FzTc/OFvWoDOzPDG0ABYfBWxCBHXKzcMGEzfmr1cSgmwF6hLocPar8eOQtyGKPlQ8D0KXMuK74HjpDhz3FfT5liIcMxakZjKwuarzcBC0afD3jCtetVurXCX6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by JH0PR02MB6820.apcprd02.prod.outlook.com (2603:1096:990:4a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 11:48:48 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 11:48:48 +0000
Date: Wed, 19 Aug 2026 19:48:44 +0800
To: frederic.petrot@univ-grenoble-alpes.fr
Cc: alistair.francis@wdc.com, daniel.barboza@oss.qualcomm.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] target/riscv: Allow UXL to be 3 in mstatus on rv128
Message-ID: <aoWYFWKNZpyJxxI8@ChaodeMacBook-Pro.local>
References: <20260819105655.33391-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260819105655.33391-3-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819105655.33391-3-frederic.petrot@univ-grenoble-alpes.fr>
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|JH0PR02MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 168216a6-a341-4dc9-6366-08defde7d4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mIpdmm1O/VFKCizlaYTIUc1x0YqnXR7E7JoNsf5lpidfMZUUd1DOa6k6mZBIAAgJmqhgt2naT4utZ2zk42RFFUEhJdgySCfOFD1K/e81ioHADZepREb2OdsAmp06Gk/Of7Q4jfMVhQ4qN/Ca3vdQG8i7D8uaQ/A3PM5FXQho70okUyxchPwWl3Y7KwVM37RP7DbHr5S3MzJ7CFW/fvE1ZmCZgsDssxGq1miIvq6iL7jgAvxAS0cWQk/DzxWqW8+L+uTjJejanBxC0ZxaMMsYLNPwbfnX8NO6cB39TvnFHiAnyoN46/aOGlTsz4s4ls10RP30Ax9pAvw98t7ef4yczX/pygnBOemU5esa0/NpTWUqF0kSSXkG8Iic57hDfIJs/krNSgA9vvaAOncZBK2HE/Ptl48VOb4eUAp1b+zIjoGiIKkVvXiq6YzsZzrhckcNaPPzGBg0nQe7KuFcgIflg+dKdutiFWCgftZ25LFbbIEsENVfzLi1pBZXwd/0AgsMbQkffnRiFqZO6gQ2+UZZsQKLX61BIQFvIc0nquo01ZSdmSnoAU9y0Mfu+rSyYVhaZzRMn+JaD9yotI3CtXcYPugliSpGzc/zMlYq9N7EuiU24TVhVe3pdxrey14TBNptTYc5isslM+5TrwdeBl8ZbAdNNDT7uQhf7dKGYKmdVmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wyxQE85uWfoeslZyAVLUTrtBdDj+r19oKPvSuA3gwq7ntvx3BIW3kBOqKy?=
 =?iso-8859-1?Q?UZZXKwAMyNkU9R5X689Q1Gz32+Fx1kL67uOf46lAOXxyLz4hUKroeBmQB2?=
 =?iso-8859-1?Q?yCU79uo10sTwedLWr8lkc1sqU8nVEZKtSMHPnokqhJxUEzGggXw5RiVo7X?=
 =?iso-8859-1?Q?eVXume/jBFkqJXHP8/x1SA8dydkXwc8r6TVHkLs9VXkXNovAhOeKNKCgLY?=
 =?iso-8859-1?Q?FCL9W6d/8bOt0+UKVqy4uuuq6OPxN42FT4KRsFiLepDeTfVKx6TvV98u4T?=
 =?iso-8859-1?Q?d7qcvd88/p/nW5Jw0LXt3oagid3mD0b1YAPqooeKkiFcBXHX4n5F+hNEdC?=
 =?iso-8859-1?Q?pj6Hdk6xOvIhAGxo4+qUAaJooPfAkMGhLwIg5+ZXBbH6RT412RocNK7MhF?=
 =?iso-8859-1?Q?CBtrVj+KW+CKRfAUhMK72gu5KsD8pCxXTR1RuNwIkdSzl7DTmfiI6xu8U9?=
 =?iso-8859-1?Q?cXaKV43C8xHfkXeC++Hup9gYJtvCi7zJguLHjyrhzPRbiuQEI/m5AzY1ev?=
 =?iso-8859-1?Q?ohMyI4Lk1UNa3A0VgJOVwhUddvfFOyedknp5N20dhVJAcaKrMB8Jp1YP3F?=
 =?iso-8859-1?Q?7rNpkfti4q81kPhhNbdIgT1Oqommb+4FTOwPMA+5KzK3D4Bnwf49j8R65R?=
 =?iso-8859-1?Q?nh39kOyEXHYuNCyHnkJKh/5xlRsXq4e5VtcNtNlJCUYRJiMTbVdr+nx2Ql?=
 =?iso-8859-1?Q?++++ABEu/AhnCClp0oDRlxjsFjAYU8tm/v7Nufkwq06WsJ9DrEJVAoqjJ6?=
 =?iso-8859-1?Q?liqUDirPqJl7DuGfpbjLSYiSzdPUIVU5dbSL/DY2R2pQ6gm1aXv4ebEooE?=
 =?iso-8859-1?Q?WuLeAQMGe3Ph3Z16zXvaqO8/0MBwBok/Ave/NTpWv4HryB+LEkuyiiDvu8?=
 =?iso-8859-1?Q?aUt8l/+khzl9Y7Imf3Mjuz/o5l8B6hX7ejNqWPeIg0AqJqB4oj6O0D9vfU?=
 =?iso-8859-1?Q?iHaXqgVaKNYV+eLJ7p8oYHZRAxF0fVvtvaC4ZP4VL/6oLXPOdrODLlLk4D?=
 =?iso-8859-1?Q?9UABxcT8N0cMDZOSnmeo2Xd3jFCAofj5D4ebPY3IZYfNxSA9LAdzjf4RJj?=
 =?iso-8859-1?Q?UJqjEQrw38DgKj+H1ciLPNCNh7xFGqqNRHI1lem1/muBCPULDYBRNan2vQ?=
 =?iso-8859-1?Q?/cc1HkowrK5Llb7dGeSYqqfFJP4h1Ik3NIQYcgQw34gzjsMCpGLyR66dkV?=
 =?iso-8859-1?Q?4z79Tb36nfLu2znPcHFTl7r9y9CbPxZaEhzedK0l3YqKvWPFN2i3cMAaya?=
 =?iso-8859-1?Q?mUAUpROrXB8tWJEnwn2glqTsyZ1YKAfwUt/EapySxeCFKyV1FatvjicOyU?=
 =?iso-8859-1?Q?uELcpOjslOPwx+erU1TMkQUoq5/tb5nOSLqM8FDsbn4NQSS/hZ31SQJD4+?=
 =?iso-8859-1?Q?3kjAOqPGS5m78N8UeKWX3i+ZAJXfiQ27MFHj6urzvRePXDNXucSNAIgKh0?=
 =?iso-8859-1?Q?Sg7xvjx1gyE8t75GxJarRtN8fNFYTyADFsQ2W2OpsEuLb2qWsbZyxxdvWc?=
 =?iso-8859-1?Q?5s2HviLQTEGXjAt4rMiv3ttyDx/9hVjTCE+U4wgC3jIJVyTUjQj+9m5UZK?=
 =?iso-8859-1?Q?bl9+nnL6XTUxHcBHyr4h1Ejs/pCzmRK9DxihML9Ws3w8hxOp3Z6WouH50G?=
 =?iso-8859-1?Q?K3yA/8HBPcyIYQXBPdMyyUyqpLZddBXSsttVVVTTh0ogBGqUFH1IZy9yyl?=
 =?iso-8859-1?Q?YPFv4+gIXdrbiEFmrD+UdM5Wmmq3G1dGP531NjB/0kpANzAN0jn07Yj7Xl?=
 =?iso-8859-1?Q?aiFiOeqdtbNX9/v04heRM6TBwwpzuIZ1Ov9lbE7xjGlcMzqTc5aOAiocbS?=
 =?iso-8859-1?Q?kEbrdNp0DQ1A9B8rG1OzVPxY0mCVivA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168216a6-a341-4dc9-6366-08defde7d4ff
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:48:48.8067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jluJMs71MWpn0xsPN3xdn9UjZ9sSjdOy9WI7HzDzjDbP/o1nmOMjnFGcIycWd6l3QYt5MI4fjADwEOCRZs/6xRxxDpzF3/6bRzvtlC3Dhrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6820
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

On Wed, Aug 19, 2026 at 12:56:55PM +0800, frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> Valid UXL field values for mstatus were restricted to fix a
> reported issue, but this inadvertently broke the experimental
> rv128 support where a value of 3 validly represents 128-bit
> execution.
> 
> Update the mstatus write logic to permit UXL=3 when running on
> an rv128 CPU.
> 
> Fixes: dcd028517749 ("target/riscv: Apply UXL WARL handling to vsstatus")
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/tcg/csr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 9cc6297328..4c8959a33d 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2014,8 +2014,8 @@ static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
>      RISCVMXL xl = riscv_cpu_mxl(env);
>      uint64_t uxl = get_field(val, field);
>  
> -    if (uxl == MXL_RV128) {
> -        uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
> +    if (xl != MXL_RV128 && uxl == MXL_RV128) {
> +        uxl = xl;
>          val = set_field(val, field, uxl);
>      }
>  
> -- 
> 2.43.0
> 

