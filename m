Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2C4CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 04:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbsV8-0000ND-LZ; Tue, 23 Jun 2026 00:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wbsV5-0000MZ-71
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:12:39 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wbsV1-00035G-LI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:12:38 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304f590dd91so5950847eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782187953; x=1782792753; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4NjdNBUTIvjtIezzXGeBro2xzPc46tO22iBJLou3zWg=;
 b=VJbVDnRojwukQnGZhkW784syrtId8w/Fs0wtTxD4Vd9XMuxQcgZzzOLoQqa4nd1e4z
 wTFIWzXKtl9tm6NECEPzHIA5zl77x8Wx1kapGu94bXKp8kNpwWdBgBAF1CA+AJ4U8NM3
 ivODLklmfG2sbUEybwSCnsEug+NAqwkBgDQyo/43gQCQqCao116SSLGf76eGTTpbrWuS
 0nfstv+vz1E+wfvG8yFW/qsIlY+T09iDOQ+K1Fv4S4GOgTSlrG4QXnWz5TmQaOqlpqdR
 WuAqwgj7jJ7nnSwlyFTKXUskGGmByhwJ91RNlLrH/UYjV7GrqAx9prbux2XRAq1EPLa7
 qQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782187953; x=1782792753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NjdNBUTIvjtIezzXGeBro2xzPc46tO22iBJLou3zWg=;
 b=TKwL76BJbXnpMWoDBqBrCF2KHfkxDOP/lM5KT7qYKfTIAvmOHPol0LMNMMHwkKO8rL
 jCQvk4tS3qRVuBThSUCu48kTwhZn24blSFh/z9H7or/5S1Z/+nBS7VElRAev9dOF3LZJ
 +ByU5MaFgDmmeA16OL7wMlBK0XUFB/YdE0RSbhpvNzEGcNcA85cPyxYdSC+vV2WbpLIa
 wL4DF0x5+Ae/U8pPQfvG4J7NmpinCvTGl0iKyycduiWqljEtynp60ECgUm8vLDcLWXBL
 H9b/3X+obN9MwtDCwEo2vn80wr7p/NFiJ9lY4vZKEfrVxATl33GLGub0pGZ8ZnJhnC0L
 6u3Q==
X-Gm-Message-State: AOJu0YzFhnlubrrLYym4vVf1Pc6NUxiq1Lh1bRP3AGWxzkz7RlKcWuGv
 WznSjDBannYgoAdAxOYzJAqaejrvxKh3G+4idSVi058ijO5UpAxA1O8r
X-Gm-Gg: AfdE7ck66aW0/Uo1tYrAmxDXJo12YmwE9p/1g5tHXRbw78PDZbg7/FKltIt48y7Ohxj
 YS17QtvIw4GihiK2/gAxcN1hgX5EZ7CilsTQUu40xTyEDYZKnZc177QsldMVER3JQxYQ9QpjV6y
 yTwW8HgBJ6dzbMRRYtzIH95sZwBRNqsz97jydu0S2732IjVpJljLFKq0yRWNFlwqfG8eMc6fCb4
 Z7l/dmFpoHsY8Ks6UKc4n+qZd0znx99qXQJQQyAX+U6K9RijEC22Z1RCwPspDYyxdWfLeHz2pNN
 ZOjiedy4dPtV6jmu3V6TiVZHa7bU3Lf+JLnJ64R6tYK7srRElD6X8GZFRG35qwwHghctuhk8vXI
 FLb2ALIUga2Wx6AHc+NjH8/RtezjbCXOAchVnyNBHdrVWzP1sJ5Mc8OmDsh6qOcMpRF4QPBLu7o
 k1XwWiynz3MvjWAtD40tW1r3rNjlyJuTIDubmfLKIEtwDBqVQn
X-Received: by 2002:a05:7300:80c4:b0:304:5db8:da95 with SMTP id
 5a478bee46e88-30c07030a17mr12626014eec.23.1782187953285; 
 Mon, 22 Jun 2026 21:12:33 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c5c1056f8sm1032061eec.15.2026.06.22.21.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 21:12:32 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:12:29 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 1/5] hw/riscv/sifive_u.c: remove unneeded
 qemu_fdt_get_phandle() call
Message-ID: <ajoHj6wMO235R6xv@ChaodeMacBook-Pro.local>
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
 <20260616235939.1358663-2-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616235939.1358663-2-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 16, 2026 at 08:59:35PM +0800, Daniel Henrique Barboza wrote:
> create_fdt() has the following code sequence:
> 
>     plic_phandle = phandle++;
>     (...)
>     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
>     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
> 
> What this is doing is assigning a value to plic_phandle, then use that
> as phandle of "nodename", and then fetching the phandle of "nodename"
> again in the same variable that already had the right phandle val.
> 
> Here's how it looks like in gdb:
> 
> Thread 1 "qemu-system-ris" hit Breakpoint 1, create_fdt
>      (s=0xaaaaac162a30, memmap=0xaaaaab8f70c8 <sifive_u_memmap>,
>       is_32_bit=false) at ../hw/riscv/sifive_u.c:199
> 199         plic_phandle = phandle++;
> (gdb) n
> 200         cells =  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
> (gdb) p plic_phandle
> $3 = 12
> (gdb) c
> Continuing.
> 
> Thread 1 "qemu-system-ris" hit Breakpoint 2, create_fdt
>     (s=0xaaaaac162a30, memmap=0xaaaaab8f70c8 <sifive_u_memmap>,
>      is_32_bit=false) at ../hw/riscv/sifive_u.c:232
> 232         plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
> (gdb) n
> 233         g_free(cells);
> (gdb) p plic_phandle
> $4 = 12
> (gdb)
> 
> Remove the extra qemu_fdt_get_phandle() call.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  hw/riscv/sifive_u.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0c6e4204cb..fda9a09f06 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -229,7 +229,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev",
>                            SIFIVE_U_PLIC_NUM_SOURCES - 1);
>      qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
> -    plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
>      g_free(cells);
>      g_free(nodename);
>  
> -- 
> 2.43.0
> 

