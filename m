Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FEAE7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvzF-0001ta-Pf; Thu, 26 Dec 2024 17:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvzE-0001sd-9F
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:05:44 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvzC-0000lR-Ct
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:05:43 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2161eb95317so82823715ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735250741; x=1735855541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iXBJlqyzf68+pnJGnzHRzdO9Cspl0l85m0SAtw6NYRE=;
 b=iKkJuvHmsCCSFoYjASS2LZdEsWKteHJVe5ArQjO6QYJ6wECL3qRYNbZ8IQFs6dpOWO
 36n+bI9vpBM+q67sYgN0/kgX11DZALt2kdeSuRGZiHS18wF8j0Ot7pYuTq9ma4G4gkCi
 pbnDnQhc1Ga21bCr2u3xeVZHU4Gjnaqferwa4DMc/D5mvzHixprpJp7UqbP4Rose0Og5
 lW1UOKyUxW7+KSOjtDMA1q9WyY2ctwrOmG7zddQuC3/SnocZv53mbawmALi3Xb7/Q/9w
 aTx3WQMiC4JV06WKS97hCjBYKyHe9p5eKdwGe1P0WgGiequRev+SFZ/yNtAzdNanyGjb
 nA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735250741; x=1735855541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iXBJlqyzf68+pnJGnzHRzdO9Cspl0l85m0SAtw6NYRE=;
 b=pVOWTslCnIRznUh1J6HqUn9HzxGarNfjRql8j+j7gQwceNPWNLSzZmDHQMSy9rHk2y
 Msa5Dh27Ki+YHXpZOmJdeVDgmdHaITBAgKUiDcBYB0ewME0z/hbISYGoGqfKsivblX6f
 ObyZLi7JVsw2ChqSfwIm7zNBbo9PSlbQfa+QUMbkXFLeoNVcyoK2vhwkFQPt4mugZYf9
 xBYOOZSAt6RWeg/I/OaNqzDAj5v6GYrAENH6rR+Qox3qTCLKdEiuiJMWkLad5QUB55aW
 gOpx6//fMxWr/lFIMFABQyjl0rS9tJ5/IdVCMksLuV6v+62JmdMrO6lHAxh5xV4GzeYL
 y17A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2ijfXZVtm3dUv6cDDlS3mkfaQVDb9rIxlpFL+YqpHAb1nIK2m9N5s6uus/COMwZRrh9M1JpeYC1Bg@nongnu.org
X-Gm-Message-State: AOJu0YwJQOOhQFn49qQIXlUmdYvEB7MdEFfbJf+f8WKaVaBmaR/V2qjD
 pIwYa+TXboqUNnspWbbpPZeevchB/+oNzKYKmXklZz5S8pfJHt6Zege5cVVRRfY=
X-Gm-Gg: ASbGncuDQWtyaN4LR0U/ZXd2N4/3kZmj769mPDaL904gyoAJJ0Y+QX4n4sBAkag04pL
 dfz6zgHaoe1tY66wTkgmH9RKOR3AFR9vDl9EeNdkGtlPQC+XhpfvMb6+ygdg8TawlGpzVRQ6Iwo
 0cJ25/FwE+ZtTR8tqu0dKrERfCi3Ct1WZKVzL9bvblLee+asAMe2NM0wzAOtPFJnU9fsqSIY4Os
 klwaItz+VnRIUmWN872jdl+AIVyTsOzgBJgTLL7ymcji3O9GJnMSaKNN6MoumYgMsB8Q7vrAvXS
 58lkAGAQWES7N3JsPKUDLUAWmjhAspfRfSuvAFk=
X-Google-Smtp-Source: AGHT+IGl+2wks0UTrT7CNqPVJx8GP8PjcIq9hyfk4wGM0uTwyOe5HMwvXc/v7NAp9Ue+nZkOI+LeSw==
X-Received: by 2002:a17:903:2acb:b0:215:9470:7e82 with SMTP id
 d9443c01a7336-219e6e88179mr301065445ad.4.1735250740951; 
 Thu, 26 Dec 2024 14:05:40 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96e8b4sm124569925ad.68.2024.12.26.14.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:05:40 -0800 (PST)
Message-ID: <cbe06527-0c3c-497e-b6f3-c0312b770fec@linaro.org>
Date: Thu, 26 Dec 2024 14:05:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/23] target/loongarch: Fix load type for gen_ll
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-15-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-15-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> gen_ll should use tcg_gen_qemu_ld_tl to load t1, as t1 is
> in TCGv which means it should be a tl type value.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> index 8584441b543712af8a56aa234c90fd6370c8df01..138bcb3e9999b2c186057c658a019136311f1b82 100644
> --- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
> @@ -9,7 +9,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>       TCGv t0 = make_address_i(ctx, src1, a->imm);
>   
> -    tcg_gen_qemu_ld_i64(t1, t0, ctx->mem_idx, mop);
> +    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mop);
>       tcg_gen_st_tl(t0, tcg_env, offsetof(CPULoongArchState, lladdr));
>       tcg_gen_st_tl(t1, tcg_env, offsetof(CPULoongArchState, llval));
>       gen_set_gpr(a->rd, t1, EXT_NONE);
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

