Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8396BCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQdR-00084L-8v; Mon, 11 May 2026 09:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMQdO-00083y-Su
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:25:23 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMQdN-0006Dd-60
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:25:22 -0400
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8ee7ffd738dso586883585a.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778505920; x=1779110720; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rLcMmTIQtmYNcLEEOgpSf0x8i/oK3iudbgjRdyeuYHQ=;
 b=am4t+2QlC9RTB7TDBakKJYOoI5fupX3c1JaRpWKGXj/D502MFg+AewKmlK0Nl00Y8s
 CNXOrR6OihrQ633p9ySgxRBONnkCpdTw+MbYI/+22YiJK2Bsj93j7GIiGDDy/FLGEyhH
 kvmW07dYKmNtSyvOPPcJnC2omEW0j8tsq6r2wOqjJqrssl3JuaBesriQJcx8RN37s6Ke
 j3euPH8xGa2VJGU90+0lD267SPdJi/MIMoqnPeb0uQeLJNNCoqJp0VDLG5DDPxyO7Rp+
 gYUHxZXirwozxwvFwcd3eOihT/TsXTpWF8CPcuUTnPLhdHCjx4oTn4ll9VG4Eo8c0xhP
 qEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505920; x=1779110720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLcMmTIQtmYNcLEEOgpSf0x8i/oK3iudbgjRdyeuYHQ=;
 b=dxotLCgRxIOad11+01KBIKmz4Pw2YKAK8FcZIgupIIQfTvIg4u9IXCWduM9REY35bj
 X4p85p7ukRVov+iAo5B2QkRg3aawItjrGu8yj7zbRqlylFDB01AuXK3xi/w2I7nPJIYC
 kt5Gcr4n+ztEBDiFdKnOql/QaMVPeRrtjmhV4HtMAawRUJN3585kWHZebw9aC3xUoOz1
 lwTdN003k57nMc1mHeyrtqqcL4aW2VMh5js1sjox4v0yigwhQchcr00lnETtrQ8sZOnn
 8RxQOkSKPE/adqPPN2EGYk/xmNSyoNIgbQq3Dd+g4XFfhjJXyaYsL9DHChYXzpY2kRq/
 s54Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+H+q12JD291YzcUomJg3VDsvMaxIfr+olabTVNupLrBs10aOnYNq3c5MctywON/Osf78A9dDoWS3y/@nongnu.org
X-Gm-Message-State: AOJu0Yy4D1o+VLVadCWAyxk8TwtcbVviGLASX2elCRTPknGjNgQsdccm
 UkJW7Je+R2O0+rUfa7aYjNM1C+o9Nst2oWGtvqjnNHuzYY03MZU6NOpQ
X-Gm-Gg: Acq92OGfDBSBO21E+qJspMv1s60fg5etuHQMWItowrKJnMRrdSFkeNIlmSSGI6c8EmL
 i7G1YlYpzNQcJUiSeJXaLfW3+OLfFb0Ie9zuQKN7BmGraDPc0XB0tC6elgzvyeZt4zO8ESrc1A5
 VlZMh//4ZFmX1I/Y4w2pBe5bGWuKF63DGZW9T0nlLZDZHQpxNxeeL4OnIB1fwxUoBJpacOHC08q
 4Ptao+8DjeBKiKzaKUFaJQCDZD/+yJMDASoleA6I4m2Dz7fXyusSqBIZ8E5isk9qZS/K3Z5wfCh
 iFNntoZ8RFu01NOaNb834wuSGOIvDcvvC/PgF9hmrP2gV9xvEvSJA1ZT4OnOIl7smRWWDI5iRDi
 s6AHtK8HmVDWgmAtYoBVzpkozZUJfYyMgorHNgAQBNjtlQt6BH6PwXDqa9irXiTcHswG+V2JpnN
 YBxMY6vX55QeVlIr/2kj88HJoP60o5s6KmDm52fB8xTZxNM6zVFcTJ2C8WYeZm0Uo+52exAUFi
X-Received: by 2002:a05:620a:c47:b0:8ee:91d6:cd2c with SMTP id
 af79cd13be357-90653250928mr2365342385a.42.1778505919720; 
 Mon, 11 May 2026 06:25:19 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b87bd789sm1138152185a.27.2026.05.11.06.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:25:19 -0700 (PDT)
Date: Mon, 11 May 2026 21:25:03 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] target/riscv: Allow mseccfg access based on ext_zicfilp
Message-ID: <agHYo_kQbaO-Euog@ZEVORN-PC.localdomain>
References: <20260511072705.3015986-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511072705.3015986-1-vulab@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x743.google.com
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

On Mon, May 11, 2026 at 03:27:05PM +0800, Zishun Yi wrote:
> The Zicfilp extension adds the MLPE field to the mseccfg CSR. According
> to the RISC-V Privileged Specification, mseccfg exists if any extension
> that adds a field to it is implemented.
> 
> Currently, the `have_mseccfg()` predicate function checks for Smepmp,
> Zkr, and Smmpm, but misses Zicfilp. As a result, if a CPU is configured
> with `zicfilp=true` but without the other extensions, accessing the
> mseccfg CSR will incorrectly raise an illegal instruction exception.
> 
> This patch adds the missing check for `ext_zicfilp` to ensure the CSR
> is properly accessible when the Zicfilp extension is enabled.
> 
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
> 
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2561/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
> v2: Removed mistakenly added #include "cpu_bits.h".
> v3: add a missing space after the Link tag clon
> 
>  target/riscv/csr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da366cf56271..e1cd4a299cb0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -783,6 +783,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>      if (riscv_cpu_cfg(env)->ext_smmpm) {
>          return RISCV_EXCP_NONE;
>      }
> +    if (riscv_cpu_cfg(env)->ext_zicfilp) {
> +        return RISCV_EXCP_NONE;
> +    }
>  
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
> -- 
> 2.51.2
> 

