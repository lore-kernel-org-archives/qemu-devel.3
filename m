Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895B5C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKsG-0005PH-3f; Wed, 12 Feb 2025 17:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKsD-0005OE-D0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:06:25 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKsB-0005SA-Iw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:06:25 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f62cc4088so2537065ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397982; x=1740002782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DERoppQqTIjOit5tmDK3Rfvv0jRIEQPA5BBJGAT1YAY=;
 b=uDag+2pTSaK/AsTUYeNM21Ckx2KAD55ovu9Xy+DWaEFT5TAZcZT0XWVnj0kARYdcE5
 6FjiR78pfIni91Ibr6ipVwKy/AkYSSeJEx4dNcJmh741gbtXJMoNeRNFyjOHlvfQb8wN
 hrTIc1d1kJgv1SUmQYK/W8xAM5qLOAKTP9ncEkLlzGnGKvttEc+eZlmKXdKQEzeFGOw5
 ERTr30GnYTgNpU7dJfwKp1bBSkRm7JoKj7maJGBW0Yw3xKHXzqx2NzZnFFVwr4mDsPtH
 VMRv1B10fH4FbzoPuRIDyPZauIqne09S0AFvVAwgxIZ4S0WF9yKhGvzc3EdMB/0evlCG
 4HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397982; x=1740002782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DERoppQqTIjOit5tmDK3Rfvv0jRIEQPA5BBJGAT1YAY=;
 b=wl+Go8pxO/tGFvTTQErrLs+ml09sRottyccIE8jy/MCx65mpfCZBxVqYfYXmQevzTK
 60nnvD4lIbSWHPmmCftamTTxYxDKGd4yaJSKAG8r4wv4dUsr/YzTUrp9L3KzzzirckFv
 vnXPbnI+4VwSlzGwn5Ns1E4VRRwFK799wvx3bHuUOKZkXKjdOqyCQOEnmMZElS9xrqyp
 3Z2OI/kk06MB/1+4cNwjRi2oF7MZ+ruTESnk6dLnq7JAtltyBNDiDPwGN/XDHPAFLz7a
 PS4Q1rNJNxb4ua/VuR2A2m3j01LKksNDvcLNMmEz+m7CMkZpzl96bskfy04BYngF5/45
 M49g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCQikgsOsimJUi3PiAdl2dfc1LShTk8zFuLDFP5Yx7v93SfnoHBVkzTXD1VNKMbTP8cZJccVrKhYiN@nongnu.org
X-Gm-Message-State: AOJu0YyArBgNQue4EKjI8nETx2mR7pIhrYIpj2pf0swY/Xmdubs5RZxn
 u9hnyGPc8/A6EGvcImvA/FgMpo+ia5vagFWC1zaEWdnd9nqySFygGfckFjfr5CE=
X-Gm-Gg: ASbGnct7KhdHCbxapxtuu61SNof6fwVSgKF936VWSvMoDB6rxFEK5kYMyUZJi3a+IQv
 pqaWfYTX808MgQZukHL1fKaL1logu6FpkQUKV64lpec3fPOclQpEJk745MzMuxtnTHcVGp3zJcx
 SCKJx8PCBzWGEk4EDSuSNgNf//YjGfP+1QyIICsskjRvjpoKpzUBRjAbboCJCHqVscYEcl06i3p
 rj2tXzMmVh9/DWoa0wCOw5SbPyWb6XqvJ+RwT1ubZavlRZedOm6oFQju29yH8hXJssaW7O8aNiG
 lPACEB6j86/tWBc/co1y5l/QIFSFdhk5utipw87J0ubCUt/5QtWPFHY=
X-Google-Smtp-Source: AGHT+IFS0L4cHtFtEcaXoe3+4xTGWGV8P0eBfzhgIQ+7dmw3FDshKVlELvYHkTb398b/BL4A+J4qrg==
X-Received: by 2002:a05:6a00:3d03:b0:730:74f8:25b6 with SMTP id
 d2e1a72fcca58-7323c1128e4mr953159b3a.6.1739397982049; 
 Wed, 12 Feb 2025 14:06:22 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73085c8360asm6959458b3a.132.2025.02.12.14.06.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 14:06:21 -0800 (PST)
Message-ID: <30874eaf-c286-4a44-abd6-8fc2d3c8c5bb@linaro.org>
Date: Wed, 12 Feb 2025 14:06:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/19] hw/virtio/virtio-pci: Always allocate QOM type
 base_name
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250212213249.45574-1-philmd@linaro.org>
 <20250212213249.45574-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212213249.45574-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/12/25 13:32, Philippe Mathieu-Daudé wrote:
> Introduce 'single_generic_device' boolean for clarity.
> Allocate base_name on entry. Replace the g_free() call
> by g_autofree qualifier. Use g_strconcat() instead of
> g_strdup_printf().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/virtio-pci.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index a72f878e949..15383570c91 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2469,7 +2469,12 @@ static void virtio_pci_non_transitional_instance_init(Object *obj)
>   
>   void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
>   {
> -    char *base_name = NULL;
> +    /* No base type -> register a single generic device type */
> +    bool single_generic_device = !t->base_name;

If you're going to introduce this name, you should use it beyond just the next line.
Most of the rest of the function could use this instead of repeated checks against 
t->base_name.


r~

> +    /* use intermediate %s-base-type to add generic device props */
> +    g_autofree char *base_name = single_generic_device
> +                                 ? g_strconcat(t->generic_name, "-base-type", NULL)
> +                                 : NULL;
>       TypeInfo base_type_info = {
>           .name          = t->base_name,
>           .parent        = t->parent ? t->parent : TYPE_VIRTIO_PCI,
> @@ -2492,9 +2497,6 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
>       };
>   
>       if (!base_type_info.name) {
> -        /* No base type -> register a single generic device type */
> -        /* use intermediate %s-base-type to add generic device props */
> -        base_name = g_strdup_printf("%s-base-type", t->generic_name);
>           base_type_info.name = base_name;
>           base_type_info.class_init = virtio_pci_generic_class_init;
>   
> @@ -2544,7 +2546,6 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
>           };
>           type_register_static(&transitional_type_info);
>       }
> -    g_free(base_name);
>   }
>   
>   unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues)


