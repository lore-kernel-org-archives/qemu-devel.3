Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDB7E77171
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJP97-0002A9-Nd; Thu, 05 Dec 2024 22:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJP96-00029s-Af
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:36:48 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJP94-00023j-Ng
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:36:48 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-29737adb604so991053fac.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733456205; x=1734061005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Q4CjYM5W5+N42/CsSN7ICu6WDiRWRRGlurvgyo9R4M=;
 b=v3r2HXC4rPNIWkIwtN/VosUBGTAceNvEDw7Uw87G4VgMYdIpvTTwAh/2uxWjdhtMYa
 Zq9WntVKSvD2KZ+/P1nFGuybb9sADxXD6Otsuhk+vkA7K7j23LdeWdPtVdoSw8WYGTsG
 NYs9xZfxTNymzMTSvTu2Py42pCsBAlqEemnBVYo+o+R/NJrhJNsusE0bsTwcI+FSC/Wc
 djUP3wUlO/rqDLoZCsWRJ7/8T5n0GjdmGYbNFCBTjM4nePTgL8MtCGWWvASAe9NCp3ze
 649GQVstj3pWRbSCwaYJqhWmHmbheI7vS255A8RP7z2eY2wI9UFTqlkdcExBUcKzlF8D
 OS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733456205; x=1734061005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Q4CjYM5W5+N42/CsSN7ICu6WDiRWRRGlurvgyo9R4M=;
 b=cWVUTw8VVNcNPB1fjgGiAYyHL2Z6NSH2S7xIfzBsSrQjYoHdOr/WJDqrtVNCZ70fQk
 qthcTzGG7PWxFNsRJd83FFEm1PDA3o6peNprjbdJgCaWE1WEAymoUfnVGg6fQd1osjrw
 J09bcLSeJqo+Y8a/vF9lbPT7JYZ8/Um9J+zsXngsIgxiE3y3bNBH0WeLojnZJVcchFgx
 xv64R1zqG8PiiI5+7vIwHkofMC2QpKapOAxwMUfv/ToLmV/iWYT1OKTYzpuPUZSCUsNx
 5k+IZbyb1XuoiPjK7/B2qtHRLP2UG9uEJR/IkQq7kCuKDD6wdMoO4UyjFlbGIiU+HXFg
 gWZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX16BNrlRiVbU1h/ASQ8DJzg88YfIiNSiMi+p/qBjVecUL4CPFdearit2CrBC/MjwQ9FdlExLozn48g@nongnu.org
X-Gm-Message-State: AOJu0Yx6WDMUxcXvGYdsqu4ZVDhJqUtWq+ycnyejxXrmOK0OLFRgTdk1
 JcujjUwUX8tXAce+tsAM9thnuBioL/eBlB079dbFAAWreVX6pY1u7mBo6q2s7DQ=
X-Gm-Gg: ASbGncvrAMz3raECvlnjZmuq33PLzXcLJzEiy9RW7/J8MvYTeNLG/+CgRVroLkksXTf
 EC/2ridMebYlcK1mRUG/73k14utLyPuSsgAehU5WV797QgBmtaXuJ/VA1dDfVhdGtnQEtUkJzlc
 /OeMOMHAqhLC9Tgxi/8Mn+DOf45MvLx8k7J92cjbI4tuir0qq827LZletpb31fgGdH1tC68hKdj
 HrUw1AAdnjJHJWJhoIwP6OUsDC0s+9EfQcXs4dKNN1UPta0yhyPOvZ5fDj6jmqvzyDnvyXIbH+v
 uNkQ7M08mJ6z0SG+2dd6qYBnWSko
X-Google-Smtp-Source: AGHT+IHY89GssUaXG9VuLmWOOYrOt+zfWaaqRgOAl3nMGzZ4WMdi7xm4CdBdww5B0IYCJAolvgVYbA==
X-Received: by 2002:a05:6871:a68d:b0:29e:7a09:d92a with SMTP id
 586e51a60fabf-29f731dd988mr1613787fac.5.1733456205144; 
 Thu, 05 Dec 2024 19:36:45 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f80418861sm14013fac.50.2024.12.05.19.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 19:36:44 -0800 (PST)
Message-ID: <79a76786-9ba7-4c04-8c11-52c92376e6df@linaro.org>
Date: Thu, 5 Dec 2024 21:36:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] disas/riscv: Guard dec->cfg dereference for host
 disassemble
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20241206032411.52528-1-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241206032411.52528-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/5/24 21:24, LIU Zhiwei wrote:
> For riscv host, it will set dec->cfg to zero. Thus we shuld guard
> the dec->cfg deference for riscv host disassemble.
> 
> And in general, we should only use dec->cfg for target in three cases:
> 
> 1) For not incompatible encodings, such as zcmp/zcmt/zfinx.
> 2) For maybe-ops encodings, they are better to be disassembled to
>     the "real" extensions, such as zicfiss. The guard of dec->zimop
>     and dec->zcmop is for comment and avoid check for every extension
>     that encoded in maybe-ops area.
> 3) For custom encodings, we have to use dec->cfg to disassemble
>     custom encodings using the same encoding area.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>

...

> @@ -5112,28 +5112,28 @@ static GString *format_inst(size_t tab, rv_decode *dec)
>               g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
>               break;
>           case '3':
> -            if (dec->cfg->ext_zfinx) {
> +            if (dec->cfg && dec->cfg->ext_zfinx) {
>                   g_string_append(buf, rv_ireg_name_sym[dec->rd]);
>               } else {
>                   g_string_append(buf, rv_freg_name_sym[dec->rd]);
>               }
>               break;
>           case '4':
> -            if (dec->cfg->ext_zfinx) {
> +            if (dec->cfg && dec->cfg->ext_zfinx) {
>                   g_string_append(buf, rv_ireg_name_sym[dec->rs1]);
>               } else {
>                   g_string_append(buf, rv_freg_name_sym[dec->rs1]);
>               }
>               break;
>           case '5':
> -            if (dec->cfg->ext_zfinx) {
> +            if (dec->cfg && dec->cfg->ext_zfinx) {
>                   g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
>               } else {
>                   g_string_append(buf, rv_freg_name_sym[dec->rs2]);
>               }
>               break;
>           case '6':
> -            if (dec->cfg->ext_zfinx) {
> +            if (dec->cfg && dec->cfg->ext_zfinx) {
>                   g_string_append(buf, rv_ireg_name_sym[dec->rs3]);
>               } else {
>                   g_string_append(buf, rv_freg_name_sym[dec->rs3]);

These are the only tests of cfg that are required.
None of the other standard isa extensions overlap.

> @@ -5439,7 +5439,8 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
>           const rv_opcode_data *opcode_data = decoders[i].opcode_data;
>           void (*decode_func)(rv_decode *, rv_isa) = decoders[i].decode_func;
>   
> -        if (guard_func(cfg)) {
> +        /* always_true_p don't dereference cfg */
> +        if (((i == 0) || cfg) && guard_func(cfg)) {

This should be i == 0 || (cfg && guard_func(cfg)).


r~

