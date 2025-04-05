Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342ADC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 09:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0zi4-0005Ip-5Q; Sat, 05 Apr 2025 05:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zi0-0005Hu-KO
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:21:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zhu-0000QC-Fv
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:21:00 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-730517040a9so3274590b3a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743844851; x=1744449651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YTKa9zoypWUJEzvNm2iu/XZgjcgv33VkLl7KYVhtzAc=;
 b=INofOTTAkbAnKr/G4xMg9hvPKf1yWlzx5vkhFBlyixEtrmDkcZ3wrh/zY0e015okaO
 HwhO7TDOvtdSB/8Wckp9EZqTiKIC6qToG8+Yojin8DVNveNTdv64FeAF1nu0NW3bFRw/
 fjz3R6/noGbKUKzabRETa9SnPV9Y2PyhQUnb5hFzc+BCmpvQRyFNx1yGyznj3jpzIv1P
 tbpeShpK6HIO6yLxoRzx7qL0Xwb4ZkQwRaM+AAOUNODRSWOPnjyC3ZrGJUaD273BsDHJ
 mC2FZ4xqd3XPvxzi38mEHzCvkugepWabp2msf9zo8YtEYBBskYamexTDvyJ6aq7UOO7Q
 yqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743844851; x=1744449651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YTKa9zoypWUJEzvNm2iu/XZgjcgv33VkLl7KYVhtzAc=;
 b=mJ8AIffYrlRn79PKFU1PPsySWOFhV3EzxqQS2nss2O+0CG276jpYAOM8IYE9gi5Zo8
 YE52ynS/mQ+XEtk78vrT0pMxMWJfkL6kv9yBTlHxDKevQpxb9vyGQL9t+p1U+69xDaC9
 iaZICBpdbPNE19SSMK54EPTFv1XXCCT+mb4xE4pjc+yHiQ8Ff6HCXghJiieXzuhNwpAP
 vBiSXUrNMvAd1YXdDDDWoVbUyIKiKf0QOEVU9fDahi0Xl6Joo8IJ8xqO17W/lFWBffMe
 c6Zw9yS/hTxB616lt8hstPBtm/ZKR+pOW8tunIPwTAY8QkX0QW6XiHvjegcVBucGPyfX
 fFWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/2VACuFRoHvyeooeCMaLJWpDXtIsMvNa42L+qa0adSoNdnqZocOQr8kr723I9/uf4+8tAbiKwQZsS@nongnu.org
X-Gm-Message-State: AOJu0Yy05rGtQT7ZDV22YjWCJaHA9HTzyqlkxlknQzmNxOlWyjt32hqj
 pgZ1vg/RJ2VwpqA7UYIT40deyXolc+SZ7JJ5Cg8O/Y9t1hd1hRcE7pWzl/RB0yI=
X-Gm-Gg: ASbGncuyXw8lMt5BMeHNdg2hNWzZkQJ1gHv6DBUQVD1FmnIBPQKQi/zzrBCbdsj/qY/
 GmgFKaywSxXUnYHCTnBYchWOQzQEvD7kB26bWdmjLTvrtGLC2QqNIlm8gF1/qQ/Iky1jtvFtGSK
 tDBdDwwg+xYk2u4qs1CDX3SP2s3zSe9j5a4vXFVC4B+9cnffb4wRr5sSskZZJvrpo90FgaYMURB
 Hj+bAbhVw6Xn03QZy9rkud1xbtTUtDpL4KkweINUH01DLoLHxifFgu4ZZ3bDIeFiCfkDI3s0rqo
 wKQhtlovZDPWXRScuckTDmiSa0/WQnMcxOBLrpRXVQgNP8tZ9VdNaI5Ppqcd
X-Google-Smtp-Source: AGHT+IFQjvaHA32iMQ6spzKWLis6oUHjR2Sc97ZmPOhUPeCe1LhRTdBaIuQCaixfJow3e2t1GLHrTg==
X-Received: by 2002:a05:6a20:c995:b0:1f3:2e85:c052 with SMTP id
 adf61e73a8af0-2010472d6f6mr10401753637.35.1743844851451; 
 Sat, 05 Apr 2025 02:20:51 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee7a0sm4811878b3a.41.2025.04.05.02.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 02:20:50 -0700 (PDT)
Message-ID: <e397d528-6e4c-4758-832b-f87baccb3e4b@ventanamicro.com>
Date: Sat, 5 Apr 2025 06:20:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector indexed load/store instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-12-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250329144446.2619306-12-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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



On 3/29/25 11:44 AM, Max Chou wrote:
> Handle the overlap of source registers with different EEWs.
> 
> Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
> Co-authored-by: Max Chou <max.chou@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---


With your co-authored-by tag removed:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index d4d1ad055fa..3b36464176a 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -1044,7 +1044,8 @@ static bool ld_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
>   {
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> -           vext_check_ld_index(s, a->rd, a->rs2, a->nf, a->vm, eew);
> +           vext_check_ld_index(s, a->rd, a->rs2, a->nf, a->vm, eew) &&
> +           vext_check_input_eew(s, -1, 0, a->rs2, eew, a->vm);
>   }
>   
>   GEN_VEXT_TRANS(vlxei8_v,  MO_8,  rnfvm, ld_index_op, ld_index_check)
> @@ -1096,7 +1097,8 @@ static bool st_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
>   {
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> -           vext_check_st_index(s, a->rd, a->rs2, a->nf, eew);
> +           vext_check_st_index(s, a->rd, a->rs2, a->nf, eew) &&
> +           vext_check_input_eew(s, a->rd, s->sew, a->rs2, eew, a->vm);
>   }
>   
>   GEN_VEXT_TRANS(vsxei8_v,  MO_8,  rnfvm, st_index_op, st_index_check)


