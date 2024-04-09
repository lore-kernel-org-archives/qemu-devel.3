Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7FBCD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 23:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruKZy-0006Pf-Rj; Tue, 09 Apr 2024 19:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1ruKZw-0006NT-9a
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 19:08:36 -0400
Received: from mail-dm6nam12on2135.outbound.protection.outlook.com
 ([40.107.243.135] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1ruKZu-0005gc-FX
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 19:08:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBkDVP8hHhqNeblorsT3WhLO+e4N4LBgPkLNBKmtfB5Pqharp9HW5cjt5Rpevpok98rs4FTWDMDoakE2Eqpr52svwL8HpFS434fWteb2VaFhxSdQ6WMUkoCfHDjTu5uXN/u/5pco+Og3Z4uJPCUdcZuMR9hBZ8qGYnt2sDBXsE8bCRD30bXQWZ+U0+AkOZa1xAAAlYGs7g4n1gkA7ArpLxtFZjbOWp3XlY3pYHsH3FdFRv1xGfZgNcuBBAR+aJpBQyRbzJy8xiUhGoyQJeB+8remSPHXxUoIWRwr/HD+pE489QBvQ/EOI9b3wHwKRlnBWBwzlg0lftQYr5ZiPJ7QYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU0ZbZzm9ZQeB4vGGsFK8BbnK0yYX1IsKeDifKqq8sQ=;
 b=A9AP3eHc+Mt+Fd/c3B8Jf1zFLOgKtSWQ1OhUwTNavYpcarERgilapTFmqmYF9viqmocALK2ebEr31dR2jCJ9SAynE3JlexgzYH0FptANuEP6Q9lxThPeE8Mtuj2TSoAuf1+MegLGDwqvJgHa7WEcPFk6ZWeInl6V1y3qiaR7lceaRWH9yCTAj6Ff9oOw9bCtJk9//vgGdusz0QTR17BWqnphD1oOxaU9h47sO7n4grlq01B1LRASSh023y+MvYaNm8G2yHrGgd7kOJkyWR4ES+Tn+F9RddeCKWM+js6s661/W76VkfJay6ow94pg04qdn494ym2G/6X/imwK6PtYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU0ZbZzm9ZQeB4vGGsFK8BbnK0yYX1IsKeDifKqq8sQ=;
 b=nSXtB4vYoRr8UU2IObe6olkfeZn2Jrkx6w4eTNKmgiPOjSefslWSEheGUPjdPyFKa/SPxtpRxLDiLth3QKpcV5//k0MP8SFdIXIbzKjTcmG8fjSKphRdcSllhNhfway+EM/0UWI9IrBP7WpCs4rc8WU8sbuVThbFd3cFZlFPK0w=
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB5547.namprd17.prod.outlook.com (2603:10b6:303:129::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 23:03:27 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7409.049; Tue, 9 Apr 2024
 23:03:27 +0000
Date: Tue, 9 Apr 2024 19:03:20 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 9/9] accel/tcg: Improve can_do_io management
Message-ID: <ZhXJOMSu7jTFpUL+@memverge.com>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240406223248.502699-10-richard.henderson@linaro.org>
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB5547:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7QNPeq28ala7biSTYOKUOHAGsZvaU9yfeuYwcco6sFSwfST/iz/0L7hLBGGDy2pi+X5RUpQ2TIT+nm27mjZT1ZVf/+86PWuKNZQcnJVQ9i/MTpwUK5iZ+2N7JUEDxGy1Cgz6RPr8RkrVvGC9/UP7VImgXNJxz+8ycMuyvMSDW8UeB56fmzE9G63vfVScjr/S1raSoXIicPwwf+9ItnWhYlhdl//KrjUIpE2wG+qpSVaXUgmGG/xtVNLSXfPJtpI+XZ3Q917+giEgVeV3s/7F2XHwiS9XmaoL5AXhZWAMbDJFeZO6PWih5BCHkSEarnb8+X5Vng8GQtS+a8qwU4GIMLy/kG6dh1zS3rQ5Oi3Pg8tvNL2UvY1GRqrH0Ak6HW+hEhaffLEWBs7ofBpiYGB4COyJUQru0xWPWfcg1OcGGldGBKyngFYn0Na4kHn73a6bTjZf/qBIaXLDXZlJg7j+9Nhfr3PTfBFSwdRGBY/nJOaL8YelMJcDSiChKTPFSmErbQtBjUZYnFtCl9rX2hDZ0xD/85QujWh+qkAlIpjDf8k6MG/RtsHV3iIfTFaI11pp8h9xJIJEKMgNvbho3vz+GLg5YSogRo9PbYfDApPb+jL7XzaJoz+wDUptt57u4uD1T1utkE7ikmO2alvl7/YCunFZnivc5WmhAbRcoOb6cY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB5512.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?beiKEkGNOxu5UuKW/IPvnChO8jX4bzTzQryVVRx9NEimP8vmrN3OBHcVUh?=
 =?iso-8859-1?Q?a1LTIgkNetAXjothvYhR+kbWY3KFtz5Wozh0NolX7j3OEUGF/3MV0vbVNS?=
 =?iso-8859-1?Q?mU9flyOTR6jbdH3TSbJkb24Ycmicef4HnlumSzxcp0oso3lxYszSOZlpB9?=
 =?iso-8859-1?Q?E47puRqSPHxNiNDGi462II8U7Sy6XqmEXYPeT035pE7IyzNO5Yc7pONfhQ?=
 =?iso-8859-1?Q?KSmlxMjTbVFuTeF/+D6DB/RWLmfsMniCXf49Wa/lyS65OdKVJ4XzU+S4kC?=
 =?iso-8859-1?Q?7HZS1X7gvyaeehcAYkSoWEEj9r/Yekl5viUZVEZ0Aoo99LxvlF4qOLcEK0?=
 =?iso-8859-1?Q?QlwTU+29dJSfjIgRaib5LcRwPTxR/C7OOBgt+wpxT97LoTWMdePJ6tPRzD?=
 =?iso-8859-1?Q?nuy8KLZwkIWOtfoQlfrzTfZ/Sp1ePaOoQJEAVCS+ZPKPHkyref41V84TEp?=
 =?iso-8859-1?Q?f10mmWt6pdFwCe0X0c71B8WUFvzowHcvFxiqYNVPadXahsRNmpMbgPBqrl?=
 =?iso-8859-1?Q?x0vzsgBXXP8iX3nsG1g0sPZ8fnBSOQ/zi7SyMNPLXgMdLD0Oo9IPVseGL7?=
 =?iso-8859-1?Q?uAKSs5Nv8JMjkubTHC7PXnevFoeja1nK0lwG/MArAlsgAMGR+AwWlaehbB?=
 =?iso-8859-1?Q?yf4buf7f8Y1+R12lZwFeRWmmENqGpb7Fm8RU6Wji5OA1mPv/TyxtOz12ED?=
 =?iso-8859-1?Q?dqPnI8mEodQQrTXMh2IGuClGCHKRv/6pQ7BnqIxLzoM10f8gvJpGJTBw0u?=
 =?iso-8859-1?Q?GOluXQ7b/rvbwcHNbjcj0so8Lp7pmlN9WSToKdGx9KfaNpN4J2GiDyY1tt?=
 =?iso-8859-1?Q?G68ZN2UKny01QsqUran1m423EETeZ81z+Z0+QDTDn8efy/LiCIUXcypikE?=
 =?iso-8859-1?Q?sWA1LnfQ8AyboRzx4wl5ARk7BBj4Gcj1wbcjgg5lO+GbI3N0jPnS9g7Mme?=
 =?iso-8859-1?Q?cm2EljozNUrLHDOCzvNOSV1dTI5AgqqkpomGwkZA7PIA5R1IzX6o0763aY?=
 =?iso-8859-1?Q?kCmr8ioXi+5FIH9Ddbj96VUPdkBBFZvexST8zaqiJZiYi2NQmLsrQnsJMd?=
 =?iso-8859-1?Q?ZHE1QbmBYzkxdaSt1Y3IJ2jSWy+YE4/0dz6U/qcfMwxfb7QKHpAOiw/v2y?=
 =?iso-8859-1?Q?5Ja7YTg0keEk77Pd4dZhvsX88oXEfJoCwD984byB1krLu/UgOww42pT/qM?=
 =?iso-8859-1?Q?kOPiSKp85f3gX2jNrcBHBJ5S9y0Oln6q5HpQEJUKNaE6tV+ONV2SO6V6nR?=
 =?iso-8859-1?Q?4RS1HEoxwt916pmwu/lJ4e7FBEAKVFowUwZWe0iMWl+G50Hc8AGZZxwQsD?=
 =?iso-8859-1?Q?H6P9RTiF8RhyRtYe1dWO5bO0eMzpUMN1gfKHNzK+XqQKrLsmxX6Un6wDMQ?=
 =?iso-8859-1?Q?KbMEpwpmnCi4KyaAvYjNGLapYhJR3K2VoJ5QG9qWfwcu0DCP0beE5dWt9e?=
 =?iso-8859-1?Q?lHnT/uJZLtPPIfKp+6bOkiVDeCi6d1vTA8sopGuEcWVG+HtXOuMuQgWcA9?=
 =?iso-8859-1?Q?Aw0uanTJyUDqUzDSTkFj8CQ3Hl1IWr+Wqgt3T1NcxWya71ygYT3vhmzeVa?=
 =?iso-8859-1?Q?OT1V/MkiEugEmiSsJwgYAP39cLnaeTmmWtXhNeV4zB8Tdm11xfuDK9rz52?=
 =?iso-8859-1?Q?PUtynISg+U0eZ7lkcPbJNJr8dLUsPAlODiO2koUTvJTkwybEt+BBA6RQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e32561-9669-4c86-0b96-08dc58e943f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:03:27.2013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiD7M0lZCcKlrZYMz8ZPxf82nTFRzjhcyQWZxOJXUMgXtXwhaflF3t2NiGGFq/9gNkMdtRnXiXMKpXhy3rozmtLasn1yET5WbVqisa8U2Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5547
Received-SPF: pass client-ip=40.107.243.135;
 envelope-from=gregory.price@memverge.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Apr 06, 2024 at 12:32:48PM -1000, Richard Henderson wrote:
> We already attempted to set and clear can_do_io before the first
> and last insns, but only used the initial value of max_insns and
> the call to translator_io_start to find those insns.
> 
> Now that we track insn_start in DisasContextBase, and now that
> we have emit_before_op, we can wait until we have finished
> translation to identify the true first and last insns and emit
> the sets of can_do_io at that time.
> 
> This fixes case of a translation block which crossed a page boundary,
> and for which the second page turned out to be mmio.

I love when I get to say this: I knew it! :D

https://lore.kernel.org/qemu-devel/ZbvVB4J+AHkLNuE2@memverge.com/

Great fix, much appreciate the effort!

Reviewed-by: Gregory Price <gregory.price@memverge.com>

> In this case we
> truncate the block, and the previous logic for can_do_io could leave
> a block with a single insn with can_do_io set to false, which would
> fail an assertion in cpu_io_recompile.
> 
> Reported-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/translator.h |  1 -
>  accel/tcg/translator.c    | 45 ++++++++++++++++++++-------------------
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index ceaeca8c91..2c4fb818e7 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -87,7 +87,6 @@ typedef struct DisasContextBase {
>      int num_insns;
>      int max_insns;
>      bool singlestep_enabled;
> -    int8_t saved_can_do_io;
>      bool plugin_enabled;
>      struct TCGOp *insn_start;
>      void *host_addr[2];
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index ae61c154c2..9de0bc34c8 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -18,20 +18,14 @@
>  
>  static void set_can_do_io(DisasContextBase *db, bool val)
>  {
> -    if (db->saved_can_do_io != val) {
> -        db->saved_can_do_io = val;
> -
> -        QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
> -        tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
> -                        offsetof(ArchCPU, parent_obj.neg.can_do_io) -
> -                        offsetof(ArchCPU, env));
> -    }
> +    QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
> +    tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
> +                    offsetof(ArchCPU, parent_obj.neg.can_do_io) -
> +                    offsetof(ArchCPU, env));
>  }
>  
>  bool translator_io_start(DisasContextBase *db)
>  {
> -    set_can_do_io(db, true);
> -
>      /*
>       * Ensure that this instruction will be the last in the TB.
>       * The target may override this to something more forceful.
> @@ -84,13 +78,6 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
>                           - offsetof(ArchCPU, env));
>      }
>  
> -    /*
> -     * cpu->neg.can_do_io is set automatically here at the beginning of
> -     * each translation block.  The cost is minimal, plus it would be
> -     * very easy to forget doing it in the translator.
> -     */
> -    set_can_do_io(db, db->max_insns == 1);
> -
>      return icount_start_insn;
>  }
>  
> @@ -129,6 +116,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>  {
>      uint32_t cflags = tb_cflags(tb);
>      TCGOp *icount_start_insn;
> +    TCGOp *first_insn_start = NULL;
>      bool plugin_enabled;
>  
>      /* Initialize DisasContext */
> @@ -139,7 +127,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>      db->num_insns = 0;
>      db->max_insns = *max_insns;
>      db->singlestep_enabled = cflags & CF_SINGLE_STEP;
> -    db->saved_can_do_io = -1;
>      db->insn_start = NULL;
>      db->host_addr[0] = host_pc;
>      db->host_addr[1] = NULL;
> @@ -159,6 +146,9 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>          *max_insns = ++db->num_insns;
>          ops->insn_start(db, cpu);
>          db->insn_start = tcg_last_op();
> +        if (first_insn_start == NULL) {
> +            first_insn_start = db->insn_start;
> +        }
>          tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
>  
>          if (plugin_enabled) {
> @@ -171,10 +161,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>           * done next -- either exiting this loop or locate the start of
>           * the next instruction.
>           */
> -        if (db->num_insns == db->max_insns) {
> -            /* Accept I/O on the last instruction.  */
> -            set_can_do_io(db, true);
> -        }
>          ops->translate_insn(db, cpu);
>  
>          /*
> @@ -207,6 +193,21 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>      ops->tb_stop(db, cpu);
>      gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
>  
> +    /*
> +     * Manage can_do_io for the translation block: set to false before
> +     * the first insn and set to true before the last insn.
> +     */
> +    if (db->num_insns == 1) {
> +        tcg_debug_assert(first_insn_start == db->insn_start);
> +    } else {
> +        tcg_debug_assert(first_insn_start != db->insn_start);
> +        tcg_ctx->emit_before_op = first_insn_start;
> +        set_can_do_io(db, false);
> +    }
> +    tcg_ctx->emit_before_op = db->insn_start;
> +    set_can_do_io(db, true);
> +    tcg_ctx->emit_before_op = NULL;
> +
>      if (plugin_enabled) {
>          plugin_gen_tb_end(cpu, db->num_insns);
>      }
> -- 
> 2.34.1
> 
> 

