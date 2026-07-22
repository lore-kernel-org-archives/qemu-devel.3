Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E74CC44532
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmUeX-0002kL-A6; Wed, 22 Jul 2026 06:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wmUeV-0002hr-Vv
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 06:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wmUeT-0001kl-RB
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 06:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784717892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ys/RxOdeYZj+JqS3E0bNSb8lxGtyzn4JdO0ML2/d+9w=;
 b=Dk78ABXbl6+/0nUvp2ewTyOJmw8Yzd4/UOyKulYuSeEDSTgc0/Ahsyyx0P1JiPZSrMxwpE
 d5yklKOL38eK154Qi3r/8cV7CewdnU5e+8CbfrLCIqam2iLMo845VNJ0iJiZrn6pn2oBPy
 OLnLI8S+H98Y+/PZ1J+39jW3sIQRHKE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-_5v9WVgVMsGNDPFWG1PX6g-1; Wed, 22 Jul 2026 06:58:10 -0400
X-MC-Unique: _5v9WVgVMsGNDPFWG1PX6g-1
X-Mimecast-MFC-AGG-ID: _5v9WVgVMsGNDPFWG1PX6g_1784717889
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-473e18559b2so6349935f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784717889; x=1785322689; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ys/RxOdeYZj+JqS3E0bNSb8lxGtyzn4JdO0ML2/d+9w=;
 b=EPtg9molfTFAb1SymbJ9ym+58Ul87/lgx1DUA4HRyd9WyFoaSYH/LouVtfWqrYM/jc
 nQDx8m3yCJiO8pju50e8QEMjPVB4GRkXQWhuNT1Y00bJ1hQ0rki0ai59KNRHb/Do65TH
 cg6nsHLvhah2Vf5V7H61hFKtlzkdeBonPMyNClnUe1jxfUkXCiegkKfLHYkqpGGufaza
 bEGPSSXB5M8vv/3hKrZ5ZBH1SEXssFKdpHi7uianIbqIBqs6HR0ulm4XDiuYf8DrTU6F
 yeszmg4Mwm4mx8aTP0f3pHeGw1fPiG0nxnFRHcHFmbuNLLaBqPATGnj1vEDLDRYz/Jdw
 1HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784717889; x=1785322689;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ys/RxOdeYZj+JqS3E0bNSb8lxGtyzn4JdO0ML2/d+9w=;
 b=oFxC7ubuWEAAiiV7p6s79vl8WVas7dN076wffiG7642A8apJOWHYTfjZRXoQzx1yk3
 c+oMQaXEL6hQZxu8413CXyL+fKmqskzdAfw8hglqwVw5D4g7CbZwD9EG8OgSbDwngHy0
 P+REh5gkW0m/5WT7kcD/BiwD1vHk/nNEs50fFrIJyasxrlmrqBwjgjsnnLFUY+jsq9h1
 0zWd/ADNUXEAAPxSOVUV2OfMvTYradU9vNYesLGdf3IKwe8+gf079l66x+0QEhk9Q/yw
 n+NBz3REs9ExW0S+Clz2VMA1r/25qlQmMeLm1NKksExncn0J/1BjztTOlYBkFJxvZ//z
 wStw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyTVz06vxm6u6oqw6Kn0UN6DsNkeb0pVE++3EDlxnbACR+Uwj1fN3K1a48QG8ao9BqWxNvWFqXdUvw@nongnu.org
X-Gm-Message-State: AOJu0YyLk4EECLdrGX1hfWCFVDEyl9/M2vdHEuMlLJKfFZ3kmwQfYR2C
 daWBKW3jP+XR/BeY66zfdJm2y93HYGUTbCHPEYWY0/v+dX49e2O/Bo2N31+yIbWwFXRlH4xsYn9
 3sUPx9HPsaU7j+8LvWb4vFHbPPgrm601kGju+FJo/RXzpWjH+R2J1S89d
X-Gm-Gg: AR+sD13roZrj98UA8yYRuaQ/6cZ79IrjR//fDUYJ2MeXEah4/DQbcrmk8eQJq8/ybQk
 2ntsOM0i/ZGuHTVkf2eN8qgEq6PoJTs3u0GFUFvI22gYXxUcM5VuvLtGQ4DLU8g71n24VjVizqo
 TaU2Uu/D7krHGks8vtA7lbttj1fsyWCtUnoiSPbIk9zaAmQV9EvlYawToopzPsciI13R8Nvh9nw
 FUydDllwEpf3fy9lT0fa165IaYnLdC2SaSV9kMOLbUjl/kN+HV8Ns5Gmpa20+lD1cvS3dY0kkI7
 fWJHlRf95ftLbG9h4B5VEoowXUlJlfmMwwisOO+L+0LJcQPWc58c26w3/QJkJFA9Mi6zkiMqfA=
 =
X-Received: by 2002:a05:6000:60e:b0:475:f0f0:9ec8 with SMTP id
 ffacd0b85a97d-47f6233b609mr25972226f8f.51.1784717889257; 
 Wed, 22 Jul 2026 03:58:09 -0700 (PDT)
X-Received: by 2002:a05:6000:60e:b0:475:f0f0:9ec8 with SMTP id
 ffacd0b85a97d-47f6233b609mr25972199f8f.51.1784717888854; 
 Wed, 22 Jul 2026 03:58:08 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm5208666f8f.3.2026.07.22.03.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 03:58:08 -0700 (PDT)
Message-ID: <0d365d35-1890-4d99-9840-055411754e35@redhat.com>
Date: Wed, 22 Jul 2026 12:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide: replace assert with proper error handling
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20260722104836.351387-1-f.ebner@proxmox.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260722104836.351387-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 22/07/2026 12.41, Fiona Ebner wrote:
> From: Artem Nasonov <anasonov@astralinux.ru>
> 
> In ide_dma_cb(), the call to prepare_buf() might return a negative
> result and cause an assertion failure. This was found during fuzzing
> and can be triggered with some qtest commands. Replace the assert with
> proper error handling in case the result is negative, but keep the
> assert for failing to respect the limit upon success. If that happens,
> it is an implementation error.
> 
> Found by Linux Verification Center (linuxtesting.org) with libFuzzer.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ed78352a59 ("ide: Fix incorrect handling of some PRDTs in ide_dma_cb()")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2777
> Signed-off-by: Artem Nasonov <anasonov@astralinux.ru>
> Link: https://lore.kernel.org/qemu-devel/20250116111600.2570490-1-anasonov@astralinux.ru
> [FE: improve commit message
>       keep assert for failing to respect the limit]
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v2:
> * Update the code comment accordingly.
> * Keep the assert() when the limit is not respected upon success.
> 
>   hw/ide/core.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index f78b00220b..4c1ee19d8e 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -921,8 +921,12 @@ static void ide_dma_cb(void *opaque, int ret)
>       s->io_buffer_index = 0;
>       s->io_buffer_size = n * 512;
>       prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
> -    /* prepare_buf() must succeed and respect the limit */
> -    assert(prep_size >= 0 && prep_size <= n * 512);
> +    if (prep_size < 0) {
> +        ide_dma_error(s);
> +        return;
> +    }
> +    /* If prepare_buf() succeeds, it must respect the limit. */
> +    assert(prep_size <= n * 512);
>   
>       /*
>        * Now prep_size stores the number of bytes in the sglist, and

Thanks for the update!

Reviewed-by: Thomas Huth <thuth@redhat.com>


