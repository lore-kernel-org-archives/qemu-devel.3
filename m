Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B918CD4F21
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 02:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNM7Z-00027J-Kt; Wed, 13 May 2026 22:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNM7Y-000272-JK
 for qemu-devel@nongnu.org; Wed, 13 May 2026 22:48:20 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wNM7W-00011v-OQ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 22:48:20 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1330d6bb78dso4246521c88.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 19:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778726897; x=1779331697; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XSV3AzkOwb+Z189JLJf6lajkcTKjS28CSTIEjEbu+uE=;
 b=ROB5SNqju1l3Da8ZqrybSJM5rvayvJte14AeHvkOX9HsNzHdEtiu3jU4ylSnqkSKyz
 0VTFwKgdISwI8PsvF+wtztdj5/B7xBw3mOBIo41w+LHpaR/qYEVBX/KFA/fE+XNPw/U0
 3423VWarpBBdMRd86l6uFp8vR4S80gg3Jt/E4R8v3BdxNanYiQWspjFm6wILPjhm2M/g
 wIgwzzKNdbhmL7gq1/eWWaBwDlQIrLulOCHGbbizDAa9r7bJYBl9KBdiWHLpZURHDp2g
 5pdMIs6qbq4cUcNAlMa0KNUZVtb13RPpjzb0SbJtjJC1eQmRK7VRuSH2g7QwNRclUZ1L
 wGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778726897; x=1779331697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSV3AzkOwb+Z189JLJf6lajkcTKjS28CSTIEjEbu+uE=;
 b=XvH4dUjOuQWgcFyZi9Ux72LUELCqJv96j+aaouy4dBdEnRnlOS/Mtm4pd52JAJrEPl
 n97/AVMpFNEPzH2RAXV6Y4NDsNeX2MUUZeceP2PmlveZAXHKRcuHF4bb2LxP+E/mdx5c
 kKNf24NCRJIussgaoLPdxQn6HZKfmJQqVMytj6Jo2BmcUMrdDnzf9WI6DToignPQMEKL
 U/p9QlL22VLP4qMVYfWKNtLJ5I0x3jCUAiUvGXh69L0YVsqj8rt8FSEYD7Ta3o5IKuLS
 oSQdL8rsaPy1P5Oh8OPoVeei1XTBnGKWgfaCkXU6UN+UsaDb3bGgs1VkO2J+DUpTRL5C
 mXcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dJyyKK667TaQIISjbGexlI823QrjmrloJm1yGBRZb2uo1FZswCbaFj4cZxBz6v75hslykakm1rKzb@nongnu.org
X-Gm-Message-State: AOJu0YxK/fS6XSYC31OwYw4g1Rcf9+XZ5LLeSVRfPGKPEbRs6l55GMiY
 Hwl80hJz+v4mfh7JEUWxI0C2cvOvXh9sdy1qios0wxOC4/p/gptTeK34
X-Gm-Gg: Acq92OES/xgSEVqomXygigCkOsskXCNhSKY0Ph40sCiigLpKUM756ofOKqvXjfdqrj9
 mRKHERBulZ0RsY2F++Tf/KrvztTbgq49LRHWcAt67FPIXZVeDOYfRwrV8KzkL9ehGx9YniA1HdK
 2/UJqzo4DqmvdC/7Kb28FBufWBHZKeeWdSwxtTi4MlFzwIW7a3YxB98wpT12TOFcf2eltSr8GlY
 BeIM6I5l/zsA5X6K3w3yMrsF53iWp1jRUvbbC3TDbbLJS5dwsYMM/BwcFc78VnbFFXR/lAN9F5f
 wtPRwBpIOa3HYir3Vn0Rx5dnRlgCv5uL0hgTF5ArOEmMFVQgH0NqM3/tnL4VALu0jSUL/sXfVWM
 Cr+lfvbfRlu8R4U/RWAIteWSHJZ6t1OLxGsh9Ka9nI4/Eaj86AuuBLzQAWDiaobiz7ojX98ar6J
 v20xJiKWQibX51GQnG78KduI8xrmVeddUgKpr5bqLBiGfbGBSRCIy791AIc/He3NzEC6Fc1ElBI
 gFGUKjsdEt+h5TdgkTtkK2qJkTqMVw=
X-Received: by 2002:a05:7300:e7a4:b0:2d4:94cc:eebb with SMTP id
 5a478bee46e88-30117480740mr3743644eec.13.1778726896481; 
 Wed, 13 May 2026 19:48:16 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6c3sm1713001eec.19.2026.05.13.19.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 19:48:16 -0700 (PDT)
Date: Thu, 14 May 2026 10:48:07 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, christoph.muellner@vrull.eu, farosas@suse.de,
 lvivier@redhat.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 1/6] target/riscv: Add stubs for T-Head PMU CSRs
Message-ID: <agU2IzvCDigXHSM5@ZEVORN-PC.localdomain>
References: <20260514011528.1263665-1-visitorckw@gmail.com>
 <20260514011528.1263665-2-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514011528.1263665-2-visitorckw@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, May 14, 2026 at 01:15:23AM +0000, Kuan-Wei Chiu wrote:
> T-Head CPUs use custom CSRs for performance monitoring, specifically
> mcounterinten (0x7ca) and mcounterof (0x7cb). [1]
> 
> Since we don't implement these custom PMU registers yet, the system
> crashes with an illegal instruction trap when OpenSBI like this:
> 
> system_opcode_insn: Failed to access CSR 0x7ca from M-mode
> sbi_trap_error: hart0: trap1: illegal instruction handler failed (error -1)
> 
> Add simple read/write stubs for these two CSRs. By silently ignoring
> writes and returning 0 on reads, we prevent the fatal exceptions and
> allow to continue normally.
> 
> Link: https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource/XuanTie-OpenC906-UserManual.pdf [1]
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  target/riscv/th_csr.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> index 49eb7bbab5..b095364c31 100644
> --- a/target/riscv/th_csr.c
> +++ b/target/riscv/th_csr.c
> @@ -21,12 +21,19 @@
>  #include "cpu_vendorid.h"
>  
>  #define CSR_TH_SXSTATUS 0x5c0
> +#define CSR_TH_MCOUNTERINTEN 0x7ca
> +#define CSR_TH_MCOUNTEROF    0x7cb
>  
>  /* TH_SXSTATUS bits */
>  #define TH_SXSTATUS_UCME        BIT(16)
>  #define TH_SXSTATUS_MAEE        BIT(21)
>  #define TH_SXSTATUS_THEADISAEE  BIT(22)
>  
> +static RISCVException mmode(CPURISCVState *env, int csrno)
> +{
> +    return RISCV_EXCP_NONE;
> +}
We can add an RVM extension check, similar in form to smode():

static RISCVException mmode(CPURISCVState *env, int csrno)
{
    if (riscv_has_ext(env, RVM)) {
        return RISCV_EXCP_NONE;
    }

    return RISCV_EXCP_ILLEGAL_INST;
}

For your reference, I have added more T-Head CSR support in the
K230 patchset.

https://lore.kernel.org/qemu-devel/1c7319cd00a50bffeb41f9cc13339a8cd0c07350.1778516731.git.chao.liu.zevorn@gmail.com/

As for this patch, I think the other changes look mostly fine.

Thanks,
Chao
> +
>  static RISCVException smode(CPURISCVState *env, int csrno)
>  {
>      if (riscv_has_ext(env, RVS)) {
> @@ -49,11 +56,34 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>  
> +static RISCVException read_th_pmu(CPURISCVState *env, int csrno,
> +                                  target_ulong *val)
> +{
> +    *val = 0;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_th_pmu(CPURISCVState *env, int csrno,
> +                                   target_ulong val, uintptr_t retaddr)
> +{
> +    return RISCV_EXCP_NONE;
> +}
> +
>  const RISCVCSR th_csr_list[] = {
>      {
>          .csrno = CSR_TH_SXSTATUS,
>          .insertion_test = test_thead_mvendorid,
>          .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
>      },
> +    {
> +        .csrno = CSR_TH_MCOUNTERINTEN,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mcounterinten", mmode, read_th_pmu, write_th_pmu }
> +    },
> +    {
> +        .csrno = CSR_TH_MCOUNTEROF,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.mcounterof", mmode, read_th_pmu, write_th_pmu }
> +    },
>      { }
>  };
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 

