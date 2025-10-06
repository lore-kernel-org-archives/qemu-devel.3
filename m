Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7790CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 21:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5sJB-0004TR-Ih; Mon, 06 Oct 2025 16:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5sJA-0004T5-9H
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 16:59:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5sJ8-0003bR-Ak
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 16:59:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2698384978dso39135445ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759784383; x=1760389183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4yWZIIpTNnoYJ6DprPyJLVzdMCTXi7rV3sQrL6JApg8=;
 b=lgQNOF05NLQiXkK+yNibJZBX6fmJIGWTuub5oUbQHgmIANtXZV7/yaey/Nv5k/JHHO
 8yTDDRrkbJhQeNZfdcKUOtxtGxshEiMnoONrF/fDLVXrjfFK9/xCx67bxd2PvCr4s+Mm
 eO2jikmgXKPwF4L/00DsuNJnm84Qs1x1eektOMgY+MloDhXoP/Zm/48/KgLQVRuSfd0s
 Ia75SJTGKKAG127Y/0mrTK3cxeVHwBo1cKnXeSatvtPSjja7Vuz5IucVpdnDE596xC3B
 PLYqABHo0iCPTCUVTCVSmT1bnc7LOvXLQp1gWRI+hQ1tR91Y7eakkAUn0kcVliLsLkam
 Klig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759784383; x=1760389183;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4yWZIIpTNnoYJ6DprPyJLVzdMCTXi7rV3sQrL6JApg8=;
 b=kA+Tr2DDXeX1Mk9uwwAWX/tld5CoxZvv8diqjRsx9w3NqS36xjBjAIdsC2Ap1eJ4zG
 3MNGErlS7AOkwtCZWcYPzu6By89keLRRFWC6ZQQ3dzXYsvEmeV6O4AO2/AjFrbt1Z2PR
 2vgCeTs1tPUC++K8gtpTH4vbyIeWtw0bYkDyFLUxK8zegQcvJ6Q8FmKTtmUpnrul2lik
 tO4PO7UNEQc9pn9YxKgLBtZfpx12oTn8CqlCH97ymdfx7CDq2P1hkC9NkIXcRCho0vP6
 bG+pCx416U9B5d2q7NlL4p5qfA5gQo/8c0M2nBEtXHwnv00OA9nF671STsQaz5D8lpjU
 nfCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrF075d9KExFLadOw05cq7REOlA3NRRJgUduXoIT3pxNPNNuAjzFbtOLSUn4GTyFGCZlivaUyYTagu@nongnu.org
X-Gm-Message-State: AOJu0Yzj9KMWRUBVQpEM7+xkq3uh3/8fMclRzisAfjDHB0ALQ6nE3tNH
 q4mfaFjyKQyNx84I7dN3uvE1hJpIlOPMcgsox+J2W6TFyMELSIrEEIEmby/o4b0tyZYdWe1jcpj
 P35ONA7E=
X-Gm-Gg: ASbGncvEgWO59XgjJoXCuZE+TaQIoGdvUjDzZAtq8XbgjPom7ffGaNvbNwjr0R+4pQk
 jXOQswb+JlCNY8ILtauA9MBX+D+AS2vKjNYEP33xVkPwZ+AMGW88PriR693+B056XMrEe66cm2F
 fFAsyswtv15oSqRQN7DGCos+s1ujaGTR72Nn1/h6lM2eDZBG0QYRhfFsxoEiLNhISSOUBo7kFXS
 sWQGWblSPJTcIukyT4iFA6zP6Te4XyNK1mU4RlEh7aXX3QhzTu1QDCbK2QGCQtU+Rhu+UGJOJ0r
 4tVO3DHwGxRsTMpQQ+dJMbV8Tx00QvtN5jPATdW7imkMLHhPx3DNZilyRAsw3px27IL/BJmcYj+
 FNYoN3ng9eIid2XMIH5BAaCxaX+/68zpjJDs+nrpor3u/mwe6nlGDX0iabMKuTJANvTXLYDxEyl
 g=
X-Google-Smtp-Source: AGHT+IE8rch7V/H9YP3RlMG2XNHkm7/5S6qSiC8mb4A5UKzyWujRGSaTMAVdUAvnwfrKIMW3tdKXYQ==
X-Received: by 2002:a17:902:db0f:b0:267:af07:6528 with SMTP id
 d9443c01a7336-28e9a61a842mr158964535ad.35.1759784382997; 
 Mon, 06 Oct 2025 13:59:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b87e7sm143237275ad.82.2025.10.06.13.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 13:59:42 -0700 (PDT)
Message-ID: <0ae68db2-190b-4551-965e-67f50541c53a@linaro.org>
Date: Mon, 6 Oct 2025 13:59:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 04/11] loongarch: add a direct interrupt controller
 device
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
References: <20250928092408.948035-1-gaosong@loongson.cn>
 <20250928092408.948035-5-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250928092408.948035-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/28/25 02:24, Song Gao wrote:
> Add Loongarch direct interrupt controller device base Definition.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Message-ID: <20250916122109.749813-5-gaosong@loongson.cn>
> ---
>   hw/intc/Kconfig                   |  3 ++
>   hw/intc/loongarch_dintc.c         | 68 +++++++++++++++++++++++++++++++
>   hw/intc/meson.build               |  1 +
>   hw/loongarch/Kconfig              |  1 +
>   include/hw/intc/loongarch_dintc.h | 35 ++++++++++++++++
>   5 files changed, 108 insertions(+)
>   create mode 100644 hw/intc/loongarch_dintc.c
>   create mode 100644 include/hw/intc/loongarch_dintc.h
...> +static const TypeInfo loongarch_dintc_info = {
> +    .name          = TYPE_LOONGARCH_DINTC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(LoongArchDINTCState),
> +    .instance_init = loongarch_dintc_init,
> +    .class_init    = loongarch_dintc_class_init,
> +};

Missing .class_size = sizeof(LoongArchDINTCClass).

This clobbers the malloc arena.  Irritatingly, it didn't fail when first merged, but now 
it's consistent on Alpine.  I'll apply the fix to master to get CI in the green.


r~

