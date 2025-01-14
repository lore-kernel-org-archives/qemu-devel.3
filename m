Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3E4C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 15:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXj4R-0002DR-3C; Tue, 14 Jan 2025 10:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXj4O-0002Ci-L2
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 10:43:08 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXj4N-0006K7-7J
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 10:43:08 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so986157066b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 07:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736869385; x=1737474185; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1M62GXlOOLlhO4bQzjwOx/1sIkLfUwBvTAi4JLglHGk=;
 b=HCtexWhjDb1fbnSCqrbQO1qSjjE1jz8vjPGs2A99Dez8i0JJ+cNbN6WvMTKmU5Sm2p
 Kp1cq19sSIknBQCJT0e19qL/M3cq7LoO9wL4wDRN8dZO6zPX7UAIREw15F2KK5Lno4R8
 heACyxzIC1Bzg7Y6jwCXtr//94719+i5DqBCElFESEePG1VxRPPd7H3hnvpsxJlcnH/L
 g7WaqdbY+TJJ6P6qxmyLHE8qWyJpd50SxNc1pNhum2BkyM7IE9gibRtsgMOmXvYJdQCU
 Q0m52i4aXc9sAcbl36d53nJNlzm5pvyFPx0ZQmq/fh1a9NANDvS+YfIRngRmTKIAHEi8
 Dnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736869385; x=1737474185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1M62GXlOOLlhO4bQzjwOx/1sIkLfUwBvTAi4JLglHGk=;
 b=HqAC6JdED4qFPgT8HnU80GDwsUW2J7pu/dlz/f9YPxPOMKW7JHgvg6uCZbBHQQIxbh
 BMMPAXbSC7ZyGRaeLxZXGwp4eiWEfjj1dRcN5p5jqXdnVlnEWmZP7rl5lp9BN27LoGHG
 Ar+wOVMeCXEO5mcQo4UL77sfrIfpE9SG74Mf/4+Gl9mlj4tg9DJXiKAnQpwHOWmnwbYX
 dRL1ZedOs+nTbogNxPj4maLZb6k6lmGJDUq3BgcyAgIpYjSOabfyGPOikIXvVL44bsPr
 CzVQlMqVk4lJDaHSUSpS+DrXh9mGZFoKsGF6atLMRnRKyTfa8+XMD0XXTPFPWXewUnPL
 G+mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwnLNYN0FMETVailUM93Q2ZX54CG1LFMOGlk0bfA8Gx+QsEt78CCGyULnqH2qGZRcYsfFc4VfuOWEF@nongnu.org
X-Gm-Message-State: AOJu0YwxBv8CUXN4j0g2/3n6immblcHMqZ2Ktf9sCO0sk8DqEEf9kjlr
 5n28Op4geEswTTQY7nv7Fx50cs/XKv5epqb1JngJhc4rCrmWyzO2buFjX1if7xQ=
X-Gm-Gg: ASbGncuZoPgGh1oJPFtqWwN2qEJfOFj46b/EmEWzFkeeL26m6FpYt0Bo3y/MV4fS1Lk
 mqDccvJodm23omJRPoy2UGbnua5CgavvvOwpGXAvPm/Dd1s1ahjNaDs8RFpn2GE2oVbStn3jLIJ
 N58+pkfxh155a1ZVTvYfokFxU72yL9pFrsBGM2NyCLSMHpXT2p84s/3KjEQAT2O5USBZ6B7pBi6
 rqHMPgS/SqdCA/E5mxBuNPzIdY9Y5HOGaHv+GQRsw0Lhh32OeRbOzCoah6b7fXdgrAyPxD2TL0h
 2pDO4RzFSDz/q9RzvIzm8YdLlN6Ny2Jor3PPbTqkPw==
X-Google-Smtp-Source: AGHT+IFalfVlPBeg+lrGkMd4IGImwkNW4HBNLY/qPNCKqOIU6iutnqRrBmTVcd9r+SIb3vjyiqK6MA==
X-Received: by 2002:a17:907:7d94:b0:aab:8a9d:6d81 with SMTP id
 a640c23a62f3a-ab2abc6e270mr2086703766b.44.1736869385118; 
 Tue, 14 Jan 2025 07:43:05 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9564873sm642919766b.111.2025.01.14.07.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 07:43:04 -0800 (PST)
Date: Tue, 14 Jan 2025 16:43:03 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Huang Borong <huangborong@bosc.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v1] hw/intc/riscv_aplic: Remove redundant masking of
 hart_idx in riscv_aplic_msi_send()
Message-ID: <20250114-7c4508bf00bdc4455c3bcf49@orel>
References: <20250114025320.52696-1-huangborong@bosc.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114025320.52696-1-huangborong@bosc.ac.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x630.google.com
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


Drop "in riscv_aplic_msi_send()" from the patch summary to make it more
concise.

On Tue, Jan 14, 2025 at 10:53:19AM +0800, Huang Borong wrote:
> The line "hart_idx &= APLIC_xMSICFGADDR_PPN_LHX_MASK(lhxw);" was removed

This just states what we can easily read from the patch.

> because the same operation is performed later in the address calculation.

This is useful information that should stay in the commit message.

> This change improves code clarity and avoids unnecessary operations.

You don't need to justify removing redundant lines of code, you just need
to justify that they're actually redundant.

Daniel's point about the log message is important and should be pointed
out in the commit message.

Thanks,
drew

> 
> Signed-off-by: Huang Borong <huangborong@bosc.ac.cn>
> ---
>  hw/intc/riscv_aplic.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 4866649115..0974c6a5db 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -421,7 +421,6 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
>              APLIC_xMSICFGADDRH_HHXW_MASK;
>  
>      group_idx = hart_idx >> lhxw;
> -    hart_idx &= APLIC_xMSICFGADDR_PPN_LHX_MASK(lhxw);
>  
>      addr = msicfgaddr;
>      addr |= ((uint64_t)(msicfgaddrH & APLIC_xMSICFGADDRH_BAPPN_MASK)) << 32;
> -- 
> 2.34.1
> 
> 

