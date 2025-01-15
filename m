Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAA9C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 10:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY0OX-0003Gm-0q; Wed, 15 Jan 2025 05:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tY0OV-0003Gd-FV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:13:03 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tY0OS-0001n6-Dr
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:13:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361c705434so46292275e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 02:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736935978; x=1737540778; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8sDySd/gvOruBbEdgVqNbSumbllq5nWRNb3c9rDvTPE=;
 b=L1bbYRc+H29N8Kt5BcAI+zj/S7z6gCbvxeLiH92X6+/jq808vnt0YDJISfvQ6pjYOW
 Nga7aw6H1QVxa2Gln4p5XWP3v+/nWJ7ECc99ccm8o8hQyWvhvJTtfjOoQb/JBNUwco4G
 QgFKmBenMNorX+3bk/Pca2JpeLj5cnuWZ7oJRcwo1EjVgKZHPtxUPbHF116nP5F08MSv
 9bR3fw5O9eN9+CJRWHa00rJ3dS5pTgd+f56plfKOsTWKmR3KGNJiSMzcLORgL1/uPM/e
 ci+2q8qdAUksyupLvId3hNnQWxAdMj/3DbVtXFDvx8V9M540O9kSsh7JTB5nxAQpgNK1
 y7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736935978; x=1737540778;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sDySd/gvOruBbEdgVqNbSumbllq5nWRNb3c9rDvTPE=;
 b=PhoO9jJJHcwaj3/0yOKq/wgqH0vPUJJRu+RPZQk4m/GGyTEsJ2h9W9OgX1uVkNEJCX
 Sa/8PNvvUGbnp+/GlQdUG43Nxi1IPCuY1Ixe3E41w/D3RALim6XhrGzGoE/BZ0VqKteR
 H/ApQKtBP0BR8DwaMqrKy7FC9Dpbc86CpIID6Xul7pLWCHfN3UfUZiaPB6ntMQa953iG
 +UdSFOZ9oEFs+cly5AO1973wb5D7oNlX1HzgX9IG707iJG6DZTt7C4zRag7Pwm8Ayy6k
 wGKnHnCX6T2pV2T5ImpgJ/gH1cG8L51xT+9bzxUzFD5mQLyE9oqpf8d2l1LhVruAKAZK
 b07Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWub7UpaKcIFEIRV3epi7Of+aOLMa8yYoX6PbuB/5kSQjrbCRLeweiIevh7t97VEK7/P+1JBnJiU4A5@nongnu.org
X-Gm-Message-State: AOJu0YxwYwtz09Fm51j3ONkidIK8RgYp3XD0F4DxzNG958K+PTqHaLcD
 0uYHf8ysL92noWIa8NeuAkWwBJs9QI8AgnBn/1zQezW+Mw1/YT1rq/WMY40FjtI=
X-Gm-Gg: ASbGncsdofGgGkLEUZ3FaGS6q+XLiwBQCnvLjyX5jqb46tFF1/twx6D2wv/HcyYyi8z
 g/h13H2iXIDs5gykFE/O/3DPTxUJ6gwZgJ4at0l7ktCuT9n5CaecYRvHNQr6+apu66H0Lk6J5Mb
 fflIr/Iw6rXKZEiSLYWKkI3ev67e4QtEtUdr2Dx+LyIOjcCBjidP1PCWpOOo56YO6iu3ik440KL
 ZL4JNr+D8vxMb9JgM1WvOAubmBFCUI1C1DOVLkiBhYx4vvmVFzQhEQuKbyhraxwafJOnlKNPFwK
 O4+RuZ0O2XapzNfBK+29dU3aO39o5LkoAY7Q8G0SDw==
X-Google-Smtp-Source: AGHT+IECmlfyGK1rIkNl6ZnzdufJ+RKdsDsl25C7Uraqweig/uVx2a8mMF9XQFn8R3ueUkiGqWwwMg==
X-Received: by 2002:a05:6000:709:b0:386:4277:6cf1 with SMTP id
 ffacd0b85a97d-38a8733a278mr28629688f8f.39.1736935978535; 
 Wed, 15 Jan 2025 02:12:58 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38f0eesm17472636f8f.61.2025.01.15.02.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 02:12:58 -0800 (PST)
Date: Wed, 15 Jan 2025 11:12:57 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Huang Borong <huangborong@bosc.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/intc/riscv_aplic: Remove redundant "hart_idx"
 masking
Message-ID: <20250115-487f87619f8bb1d8ef71d0d9@orel>
References: <20250115035105.19600-1-huangborong@bosc.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115035105.19600-1-huangborong@bosc.ac.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x333.google.com
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

On Wed, Jan 15, 2025 at 11:51:05AM +0800, Huang Borong wrote:
> Remove the redundant masking of "hart_idx", as the same operation is
> performed later during address calculation.
> 
> This change impacts the "hart_idx" value in the final qemu_log_mask()
> call. The original "hart_idx" parameter should be used for logging to
> ensure accuracy, rather than the masked value.
> 
> Signed-off-by: Huang Borong <huangborong@bosc.ac.cn>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---

Please add a changelog here when sending new versions. In this case,
it could just be

  v2: Improved commit message and added text about qemu_log_mask
      to the commit message

Also CC reviewers of previous versions even if they weren't CC'ed
on the version they reviewed.

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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

