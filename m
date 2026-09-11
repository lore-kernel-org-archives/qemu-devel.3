Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96C0C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tiy-0006ND-PL; Fri, 11 Sep 2026 01:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4tit-0006Mq-7m; Fri, 11 Sep 2026 01:22:52 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4til-0007cH-3H; Fri, 11 Sep 2026 01:22:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXmgupDIkxrxMJ8PYmwg+5DVTytAdqYyibYj+vqhIwZ0ZVuAo/lMD2YOG0JuBBEeWs7Q09ntiZvNwCiDaMYtAiE0nacxKqzuvUpwu0c3Z2xwqO0VC5ROkQao4ODePi1/JN1pC23FTZ7lWBcl3IPy3ts5amtjyO0dkkfxmvsDOoP/qD9SMmz37gPfxKJZoZkRjVuGuiOkpVoiVoBhIvIGluyAmrqAVTnC3u93iUnsclwKpnG3ME60eqWEJp+tZhleMO/nOQSXqS22VWd+aEhOgz3pQsRXmVmX7dvn0YdAi3QNAcI8OFvSbzbmvzoEWyhXnIL4tvLYa5TZzUyt8+GoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKl9UD/jJMUPmWMg6ph36r7ATMbRiMXMHuyX75rC4EI=;
 b=LyB5U7npoZCrd3SdazcuahAcIl7Z8pE0KiJFsOQsSkJ1nTDqekT1fQLTuHx24MeWMKnVZl3Xe8p27Kp7R13xFFhXF6wrF0jEjYGiwbZPQ6MZx05Bas8SFQ7xSy5t3GRt89vMsURmdNgeAYJdAWne3CdtNY2i0ewDESSzTSxDwxw7Fl3pGOpoJCcISiXk+UISrxtsCq7OEChOj2B70Ce81lbkdY87zgTcc0el+3yOOY+MdsXn7GESnbzP5BsHKq5KHhkhqrHLtTgScbzuJ/hp/vkAelB+1gbDwMJweDYw4N88OqOr2Q0P5pqMQraw1/Op452ESebs+wjwvyl8NAps5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKl9UD/jJMUPmWMg6ph36r7ATMbRiMXMHuyX75rC4EI=;
 b=v9bhrxXbujY96ofTnc+9Ft4nyLQ+0mQPDo98g/npn8jBxWgNhMWXwoGqfkAk8X3u85r4Up9ySxydm1Ih4wtHvrP2Wjztrpsf4leUQkFcDNwH0yplvjpd733txvtapbSTaIFAO1i2r3GORHc4EKlpccsU9cozMMVG0xp424R2NpZfO7A02o8qPwMMhh9WLvQ/cOK6PtHj0Y6/K01soCjLpvb+Mtq2g2/MOoO+/0a1GvUrft/Ophfu4XrTYOp7yZ6rbKYuOhET7TYPF2keRWEuibRXZbTIME4cr+pHP1eHcCus5l8XE0iLLWCUgyhz1xRo1fM3n3nnIQlr3paBB13cIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY1PPF25A2BC0BA.apcprd02.prod.outlook.com (2603:1096:408::94e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:22:36 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 05:22:35 +0000
Date: Fri, 11 Sep 2026 13:22:29 +0800
From: Chao Liu <chao.liu@processmission.com>
To: wangyang <wangyang25@otcaix.iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 2/5] target/riscv: mask RV32 XTheadBb th.srri shift
 amount
Message-ID: <aqOKQ0WfB0vTTFMG@MacBook-Pro-4.local>
References: <20260908124755-v3-0-wangyang25@otcaix.iscas.ac.cn>
 <20260908124755-v3-2-wangyang25@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908124755-v3-2-wangyang25@otcaix.iscas.ac.cn>
X-ClientProxiedBy: PH8P220CA0034.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::17) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY1PPF25A2BC0BA:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a12f69-9b52-4391-5c1e-08df0fc4b05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|3023799007|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qMf/7vwALPpww3XPgDaZXpnMyuKMw9r0RihLPKk+SQCMinRV8Y/2fdQH8aXvQa35TEn2t/Mle2IwFdv2nJDNrAXicIQMqmHqjQE617VmygcWe/u10QDvCdbU7kPdH9L7udkHepiGcrlfwFX5Hjm8y/fRBkpwP+QNQcVg2cqVnI//x5uSKqW7jFHS93dZeGr6wCo2iEPMQYNxukWK446E9qvGXD1dV9MCcUhOQeAfwQQ8S4uY+G5Rwl3ra6LwhdHSqyHSY0TrRTfnCVGlVdE2MBhbJ5LJBXWBU3v1v9p8UtC20kwmgriDt7rGr0sp43qWq+QvEiIxMGuK2dorRhF57NtoAAX5t6isvXz+aaL/Hef9RIJ7x2Voc6IGikCTe6784BnFtCGDcfAhXDxop/aK7G9sEqXuv4fA6ymWyRYqOPS8t2jW7KpTHeb08kmZ2Yw3cakT4x9GGn4N/Iv+hL8Qph2f8eenJhsFElwjyGc+JrqEQvIW8yw/BATQEhn6vac8Ds4e5pmbaqzq/pYAlojDyYRqiC4MVjQCMpzQv4IrtR+Se+wtB3/W16uh2OIU2wgeJ80IF6ubr0yUKB3p7K/dmYpqwY2lp3Z3A0Kd+Roj0BYrTTU3R0gdhnxm4c5VFwyqXXEM3e7gYyvnNbd72++LyMiys6RCLpJNxccXH/2PoPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk1aVjVaaTk3TmFYeTBFV2ZlbEdrVEo4b3lJbTV3ajZRMVV5NVBtbWFRVC8v?=
 =?utf-8?B?S1NPYjROamJENFZGcEFybGZneHRWVkVHL2x0Zm82TlRlZWxJaVRVS3ZzaG5y?=
 =?utf-8?B?UGtmOGIzUWpGcG9SeTQxK2ZCdWdGaTdacmEyRE4yVzhLNnBvZjlkYThLQVFy?=
 =?utf-8?B?RW9oSEtueFJZWGpDVWVtNVpzRDFyOHFWOHRWeXdFZ2tZVTBkYjNCY0toY24z?=
 =?utf-8?B?azZaeHUwOW85QlNVK2h5RGtxMEZJMGw2TjhxbjBLUFdrUTJFNVA1WjU2bVNv?=
 =?utf-8?B?ajlsT2R5WWEyMGZ1SVJVVE1OaUlGZHIrTlhHSkNwTVRKYTB2TVVaRUlqdFJH?=
 =?utf-8?B?ZW90S09QUHNMcWpzS05PTFViOXZQN0J0TjZ6VERFNHdjZi9hVnZxRnVHM3JH?=
 =?utf-8?B?czVzdDZIb1daSzF4K0FNU0EwVmRFbUVkZGFkQ1djNjQ2VGE2UmN3VDE1NWhU?=
 =?utf-8?B?RVBpbEE2VG5OYVBKNUFVNktxRTl6dGoxeDA4N3J2bmxncTdpYlVoakI0d1VQ?=
 =?utf-8?B?Wi8wM3VjcnB3N2drRWdET3lRVUdmYTQwNExFMWw0alJWTkxnZlgyZDJnM3FB?=
 =?utf-8?B?QjVPak0yWVpxWFM4a0JpR2tqWlhPWEozL3JBak42bHJ0L0lBbWcvbWxXQkNR?=
 =?utf-8?B?VCtiQWtHOXhqdU9FVG11U2NRWDBFL1V4b2lLWmk1SzRtRHFxZ3V5eFNUeWdn?=
 =?utf-8?B?U0FoYVdCOXp0YnVLNklHT2R6MjlSU3JDaXBFeHlBQm5GZ3YxeDE1bkNqTys5?=
 =?utf-8?B?ZENmMVo4aFhuWU5Na3ljd05CdU9kL3owenVBYk5QMzFHNXlUQm9xRlIrLysz?=
 =?utf-8?B?RGlCZTg1QkRkeVpVYmg2L0hYSzhHYnV2cFJ0aWttd2tIYzdqcXJhb3FVY2FQ?=
 =?utf-8?B?b3JuS1Q0N2FoYzRVSmwreUh1YklscllQOVNFN3dEYThhVTd4S05Vd1VzTkVQ?=
 =?utf-8?B?UWE2QUpmTlVqYlJGUXhNb3hNOHZhVUtoc3ltSitBMFVVcHU0eFJKZWdkdVRn?=
 =?utf-8?B?TXF6QjdCQ0FoUEo5WXhIOVRjUWZZY2pNaGpWcTlSOXRjOTQ4RG1HemtOMzlY?=
 =?utf-8?B?bUc2L2EyVlY4T2JOYkl3dzhNT25rS0VubDlXeEZtOE9NVHIvSmkvT3VOd2t2?=
 =?utf-8?B?WmZITEdmdytlbVJBSjA0QW5GMzc0Q0JVdnFWOW9jZUpxMm9EcXR4WVhkUVBh?=
 =?utf-8?B?UFptSzEyUURIUnBWR29CYzZzQTJ3NTNuQ2liMlZXS1RuMms2VmlMQmZsd2Vt?=
 =?utf-8?B?WmpzQ1QwK3JNNkxTM0U0TnVIckRSR2IyalpxVFkzc2JtWWNkcjhZOTcvUDAx?=
 =?utf-8?B?SnE0TExGUENmaktuRVRWRzhVNkh3UTZCMXVodklXNDNkYnVKS3Q4V2JUeklh?=
 =?utf-8?B?NSt1dEdocDZNSjVncTRCQitCSUEzZ1U4aFRkUWJ5bEFMT1l2WWVwazlTY29j?=
 =?utf-8?B?KzNxMTI0UzVPcHVJKzRXWSs4cFpRdzVodm1vM1dyb3o1TytDeUszV0JEMkpr?=
 =?utf-8?B?ZUpmQTVJWXZWYTg4WHd2aVJOeGFjdXIzQnRxKy9CYmZYMmFmUGZDRzRlRVpo?=
 =?utf-8?B?azQwZk93V1N1WUMrT3Z2QVlZV2pObVM0OWU4a2JnMGRvOWNHN2tkZmhWaENN?=
 =?utf-8?B?WUNTNjI2SkV4eUVuUHg1L0ZlSlVVN1BMUTcxY2lwcC90V1dLN2haK214Z2xa?=
 =?utf-8?B?ci9lZHBGR0R1MDZMYnhkY1NPdTFqT0taZkZvUVV0Q0tEQ1ZHQ3c1dmQ0YmQ4?=
 =?utf-8?B?bjlxMElQRytkSVBvTGUzYVBXSXhtRTM3UHhXeWVWVkNJN3hCNjBreG1uL0Z3?=
 =?utf-8?B?VWVPZEFPaVBHUm52M25lTVBpWjA3V3ArSXFsZ0NBcXZjTDI3RGZWVUNyV1ZL?=
 =?utf-8?B?enE4ZzJOVU51ZFdETHFIR01ISHVIL2ZVc0xSd3YxSUJJc0xWWVdBY2tRa3NZ?=
 =?utf-8?B?K1ZkTU0vUWgwaVJZS3JVeU9lcjc4Q3A0WUNPeW9HcWYyZVdLVEZ5ZGsyN01y?=
 =?utf-8?B?TjczK0p2ZnBPdndscldGRHo2cXlRR3FQUms1WnhleE1hY3IwdHd4NUt3MnNV?=
 =?utf-8?B?cW5mR0VQNVdBejF2aldhMDgvSmFhb2liZnpJWGNNaVgyTWgwaElXR1RkS3Az?=
 =?utf-8?B?V3g4dk51bkZkN2pzZjgrSkZTMmprVjZ4N0psNmFHVDc4d0JYOUlpUkF3cElt?=
 =?utf-8?B?QVBqVjlNMmptUnVQS2FUMVdnRFRlY3dSUlduK21aWXVSTnRSU3RjSjVkaUUw?=
 =?utf-8?B?MDl2aGczQ1AxbVNacTFEaE5Fc1lSM21uYlFkVGszR0JkK1pLeWErcURScmFk?=
 =?utf-8?B?WTUzTTJDVnNoSW9WQ1BEaUNoSmxVTVFIVUw0OTI4WkJDZG5DcWtVN0JSQnRy?=
 =?utf-8?Q?ViKgaZZWUFOXRKio=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a12f69-9b52-4391-5c1e-08df0fc4b05d
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:22:35.7447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6wdae7jkn/U91Ny+Iet6sTgtl1rmKIiFcJs5QlxZUCy8/qOlVKc51dmRdHO004ZQZZbOCzIuSsSRsTuBT97r3LyrwIk6X+P+AOSo+C86M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF25A2BC0BA
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 08, 2026 at 12:47:55PM +0800, wangyang wrote:
> The XTheadBb th.srri instruction uses the low log2(XLEN) bits of
> imm6. The generic shift helper rejects values greater than or equal to
> XLEN, which incorrectly rejects imm6 values 32 through 63 on RV32.
> Normalize the operand before calling the helper.
> 
> Tested: RV32 imm6 0, 31, 32, and 63 witnesses with XTheadBb
> enabled and disabled.
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4413
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
> ---
>  target/riscv/tcg/insn_trans/trans_xthead.c.inc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> index 681f70e5bc..34226b1be5 100644
> --- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
> @@ -141,6 +141,7 @@ GEN_TRANS_TH_ADDSL(3)
>  static bool trans_th_srri(DisasContext *ctx, arg_th_srri * a)
>  {
>      REQUIRE_XTHEADBB(ctx);
> +    a->shamt &= get_olen(ctx) - 1;
Looks right, but usually we handle this in decodetree. We don't
normally modify the decoded arguments directly, so could you move
the normalization into decodetree instead—e.g. a dedicated RV32
pattern/trans like zext_h_32/pack?

just like:

{
  th_srri_rv32  000100 -..... ..... 001 ..... 0001011 @sh5
  th_srri       000100 ...... ..... 001 ..... 0001011 @sh6
}

Thanks,
Chao
>      return gen_shift_imm_fn_per_ol(ctx, a, EXT_NONE,
>                                     tcg_gen_rotri_tl, gen_roriw, NULL);
>  }
> -- 
> 2.55.0.windows.2
> 

