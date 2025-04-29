Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98A1C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 16:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nNG-0004bG-4d; Tue, 29 Apr 2025 11:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u9nND-0004ab-H3; Tue, 29 Apr 2025 11:59:55 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u9nNB-0003iS-HI; Tue, 29 Apr 2025 11:59:55 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-54c0fa6d455so7924368e87.1; 
 Tue, 29 Apr 2025 08:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745942391; x=1746547191; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSY4QOlO+/bbDaoMNloD5m49KP/BpXRRD5Fy+F/PSWs=;
 b=HiGB6aAsO2ZEB32KOhE+htVsM9E4r61DWhtMpYCTnQzr58QxFp9mo5ahlMvtrU8tLi
 z82anumZfRxyLzwBtuIbbdREuVYvaf+QPDXXC29bMzCv1SoEDS6cNHNKVDOxhDvQAvee
 IPllCeIaEQj8FI/GPVlFU3tU5fpWWgAjPyZRnNho4LdAV1SKCiLRnZ83bP60ojBKQiwh
 4FgV/PUj5H/Q00K/nYFxx50LY2dPBhGoNDB1U/eqvxv8FO+EhpagCx3KT78KsBDTPQVF
 qVcFkvt/JgKlfZdDAeJUxKIt8it8ndrFMMOAYdMOyUB/RNm5EgBBuk+Uq6W0pAT9k8kf
 I0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745942391; x=1746547191;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bSY4QOlO+/bbDaoMNloD5m49KP/BpXRRD5Fy+F/PSWs=;
 b=w9q77pTb3qH1zRvJ9s2tWbiYyFnsrKqUjuO0y1cPbEWK2ZV8xjXMDxYVWQQPLClORH
 2aPqk7sZTOYt/EWPrCwfcP3JR5EJasjOAEjRL0QlqvPeZnWu/OskuA7MdXAVcvxyHxRg
 hsI6E/HWo2/OBSuDJ5axlXhzW3/eXUWYqGKqTHkHB+fjDX9octRHFpZbKVioDPVnxbop
 805wfLYGJnzwqGTg9usPApE+JWaf1vN3vap/nD6o0ctatTMRZ+V4FPFQue7jmFw3Upz2
 8y3d8j+iaGh4TfmiYNQzvp7h+6AAi/sTounqjOL7smsIYKmCoBBm4lWWGJB0zaGqGxNO
 QKXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUSwCKdYFxCgV/sqD1jgY1FXWMjyhtJq1KHbPEGAOKi0qpfVG235KDZmFCPv4nuzzta6ieDWdJJnag@nongnu.org
X-Gm-Message-State: AOJu0YxNT4DItreosvhgMXgckpN3df6LFdxcF5q17p2y16ar+XkX72CI
 YxSHbubC3NqpY890oQNacsXvHhd2GZ5MqJxJ5tp8owpU46FVYhNZ
X-Gm-Gg: ASbGnct7wGNtWfi4MtqI60M5lPMR3kxWCEGN+G5gPa9KDymwI76MRg8YbPVecraWgmI
 SZHNlYYdMwaZ8z5RtRlrhlpT5V1kDWLHLT0fk7SzQ+6YTmM87qB810dcRScHgB7NC0Dw/LpBFD0
 IueqkVJcRfhRw6chIkead4VOj+VDMGfZdn6jBgdCjnoWW7J5n+VXqawAU/QT3vRoh5vtgPekMl8
 alXxg8eUumntHWFmayGhYfIV0SAyaRNUs8emr/FI6FCyZv6jYqnCZtdz8r4wTT6ZDmuc6tBjj6j
 hwVk3QTVR9gCZuzXUS9CXNrkEPWl1yM5s4qrKm8q1gD7Ghm0B28SDXkEFwVmMoZnjvFTD0srKqO
 5sd0dqLXNvFTF
X-Google-Smtp-Source: AGHT+IFP07WVtKoPKapNiX+C0U6lhvWxHwGwB8ud6kuf2XOjYwB+0M1EjC6UCygOOkNQxcNvN84vIw==
X-Received: by 2002:a2e:b8cd:0:b0:30b:ef98:4653 with SMTP id
 38308e7fff4ca-31d5c4f0842mr12223821fa.36.1745942390582; 
 Tue, 29 Apr 2025 08:59:50 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-317d0019d64sm25187271fa.63.2025.04.29.08.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 08:59:49 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:59:49 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 1/7] target/microblaze: Use 'obj' in DEVICE() casts in
 mb_cpu_initfn()
Message-ID: <aBD3dXFuQCDSgSBF@zapote>
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429132200.605611-2-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Apr 29, 2025 at 02:21:54PM +0100, Peter Maydell wrote:
> We're about to make a change that removes the only other use
> of the 'cpu' local variable in mb_cpu_initfn(); since the
> DEVICE() casts work fine with the Object*, use that instead,
> so that we can remove the local variable when we make the
> following change.
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/microblaze/cpu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 00a2730de4d..d92a43191bd 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -333,11 +333,11 @@ static void mb_cpu_initfn(Object *obj)
>  
>  #ifndef CONFIG_USER_ONLY
>      /* Inbound IRQ and FIR lines */
> -    qdev_init_gpio_in(DEVICE(cpu), microblaze_cpu_set_irq, 2);
> -    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_dp, "ns_axi_dp", 1);
> -    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_ip, "ns_axi_ip", 1);
> -    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_dc, "ns_axi_dc", 1);
> -    qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_ic, "ns_axi_ic", 1);
> +    qdev_init_gpio_in(DEVICE(obj), microblaze_cpu_set_irq, 2);
> +    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_dp, "ns_axi_dp", 1);
> +    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_ip, "ns_axi_ip", 1);
> +    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_dc, "ns_axi_dc", 1);
> +    qdev_init_gpio_in_named(DEVICE(obj), mb_cpu_ns_axi_ic, "ns_axi_ic", 1);
>  #endif
>  
>      /* Restricted 'endianness' property is equivalent of 'little-endian' */
> -- 
> 2.43.0
> 

