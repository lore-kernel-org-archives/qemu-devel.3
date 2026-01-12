Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE983CF45C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 18:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfMf9-0000y4-FU; Mon, 12 Jan 2026 13:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfMf7-0000vv-WC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:29:10 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfMf6-0002lT-HK
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:29:09 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8b22b1d3e7fso649021985a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768242547; x=1768847347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e+kWRj9BttIybabh8Db+axUQy/vlFNXf+FCs9bWH1Qg=;
 b=HZsr91nCTC71ORhpCC3lriGPjP7Jvcp6/Gt5B+GNIzc/4IVfugOsWnmOTCnMxyQUXc
 nlf2PEJjaByp+7hRjsKaiHnsIbnU7sRHY26mV+S4MLIpBl7wsYWFK+BWDb+tMpMbWk2a
 8I+4eF9RHGcau29r9469T4XTeofSuPr1DkU+Zj8MPQ+OmMViJUgvN5C5ifedJI4i005m
 RDNPy8h9urymOUOoViojd3nR3PVOYto69ttK4zqb1fqmM9ylgv0G+2yh2DbOSd6hjTbA
 vM8S5CyTHQOQouyMwvE7hb2auB1nYNnfBmer5hLzULYO1cXjG9a64zu6h79qirbbhYoi
 s3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768242547; x=1768847347;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+kWRj9BttIybabh8Db+axUQy/vlFNXf+FCs9bWH1Qg=;
 b=Y7cgdRfNaiz3S4QaGxvgpT549M8zGqtNiz1+dutWojwURunH65zGtKPD1p3YHL6zg9
 PLmzzFmVkGp0k/U6TrUBG5VxbCzPESw3gzx47HhtwOsSQPgaX9IxnL+iTM1K2Xaedf5c
 8i12O5s29DOYMMnFHQ5V1Qzwl1NapTogsL/4RWgJoSEm8uJ15veT84UdWUTcstVn3AUa
 ow9AUxgrYZjvyzK/+RD5W1o1WbhlxQ5/HeCmb50ylVaaaPVYeKJnsPaDqr3ntu0gmjVY
 rZ96EaO0SmidIZx0y1YKfG0I9qvsw8DpPqMGkUscUFhj+SeBK4c0RzPwF3FOqLx8JHI/
 aeFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOijPKijfO9uheoXxpWYZMI6sy6UQdVwSCwym9GiLtJ5JzCrOMVOWsudDDayvUT8gDgOl6x6LAyNJU@nongnu.org
X-Gm-Message-State: AOJu0YzEkL6lervYB1SiDJ1wyIA5rwejBcQekt2UQx4K+OIkHbTwXoFw
 L7HrjEWVsdYyQueUAXQLzwWIMNvIDHxIUlHc+KJczW7z+WOtlXN1K6a1zlBJWmtxwgJenA2X0wr
 lDc097Kpe6w==
X-Gm-Gg: AY/fxX7431Y4wAPH6RWk1HA61n5J2KSvF59t4l3IUZyC2nu+jeC+F6MERXngCDdNUn8
 OuGFDM7PIzbQgXkcDHqltN/1TGQUAiGI2F/s/pfxzixcyDA38UJadlQtdOqleVg8HD97XAONAor
 y335bxiGmYXgrmvLbZXoNeD3MzfaUNCZEhFRw7hzZyBRJ+T1fOC4c2pGQZzyHw8X0bkCzbdUhsl
 VeGNqRhtLvq79NlKU4M04zs+SaeqpRfQ0vG1vLHrf1IrHn+3PQc4JVCON+6LTU8gL4j9MlGjJuH
 KSDimtX0vn8J4IwUCM+7pNDWDC6dV6UVq1nPG4mh/MtjoCVmCRC1xA0raK/fxwECH0Fstt+6j7K
 wM8+OsmQOmkX2Qa+7FGI8fJ+ox86+SWTWksw70J9qUqmbWuSMAkxGOTarEzJ8xGxlw/c4Qh+haF
 MgehGsow23jTkAxvh+FJvKRHskHXDGCKNIK+wRymbP
X-Google-Smtp-Source: AGHT+IFEfKWJfmzGT6jSV2xXkYQf2HLKjcZXsk/BcE4YO61+froWxIiHUQZin/P5knNm5w8pUY7NGQ==
X-Received: by 2002:a05:620a:480c:b0:8bb:ac44:bd58 with SMTP id
 af79cd13be357-8c38937183cmr2434898885a.13.1768242547426; 
 Mon, 12 Jan 2026 10:29:07 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f53129fsm1551911485a.44.2026.01.12.10.29.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 10:29:06 -0800 (PST)
Message-ID: <1bcfb481-4aef-4a90-9778-8b3ec441af8f@ventanamicro.com>
Date: Mon, 12 Jan 2026 15:29:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/riscv: Introduce altfmt into DisasContext
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
 <20260108132631.9429-7-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260108132631.9429-7-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x735.google.com
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



On 1/8/2026 10:26 AM, Max Chou wrote:
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/translate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index f687c75fe4..911d3932f9 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -101,6 +101,7 @@ typedef struct DisasContext {
>       bool cfg_vta_all_1s;
>       bool vstart_eq_zero;
>       bool vl_eq_vlmax;
> +    bool altfmt;
>       CPUState *cs;
>       TCGv zero;
>       /* actual address width */
> @@ -1302,6 +1303,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       uint32_t tb_flags = ctx->base.tb->flags;
> +    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
>   
>       ctx->pc_save = ctx->base.pc_first;
>       ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
> @@ -1321,6 +1323,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
>       ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
>       ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
> +    ctx->altfmt = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
>       ctx->misa_mxl_max = mcc->def->misa_mxl_max;
>       ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
>       ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);


