Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861E2E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 21:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKlCj-0001vC-Is; Mon, 09 Dec 2024 16:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKlCf-0001uo-NT
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:22:05 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKlCe-0007ih-9C
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:22:05 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so2055582f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 13:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733779322; x=1734384122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cR4DdMc/TwvrY+t0EgVMm3YLHZbFJEHU46vDw3/T3S4=;
 b=bJcA43XOxS/oTBJSM9aw4NVFCpGliWD/q1ZzptDiQfMVnhbQEsS4U85K+J90i5yyXN
 XcgVXR3I75yx6KNbgfYqrSaIoe4rGygegQwOVedbXQIGpTHxq3XmH/qDbvTd7kH43iVn
 nheLDoTiHWW2kuygVMZHtwczR3k7JJvi8m3w1Ogev6dsqWIcVIBHRz3BUCqdGF2SCSXJ
 wPmoVmsxAZ0S8NA+ESjaj3q9GJ72LErzM+XT5M4MS/WgVwTyC6Hg1PVC2wi42YghkLQy
 4kn4/+B81L8qetHnMB8pNGXpra8w6K+CaLC2jAbGirWx2yGc4BxZ4fPqD90lIc8ZtPpI
 Mnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733779322; x=1734384122;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cR4DdMc/TwvrY+t0EgVMm3YLHZbFJEHU46vDw3/T3S4=;
 b=ZGD1JJJL7rmsLGCzTUNPxpCPKQr/hCMM3Nbc0fbodmCbOOl8jKJYzbQSJEbTFhHFYQ
 AifVXdxC6M7ZL90ZxATW9JqlkQngZPLtsAXXXnKE67q68wXU0QD6xsfNgJ8lPOaf9QmE
 jisqeebirq/XVDNddgqaekSQ1hepx/9A80646U269aRjwXjCWg3Ia9uj3P7a8oX5D+l4
 JF9OdhY/tkNv6AkgnSRbH2rLky57gVvFztPHAR3KbR0GsrajESUmBkhexvRn21ODW68P
 1INyy4ojzSse/Ye6ISDS/J4cmITGMaM4DQ5vJWmmYvKTe1ZVCZH8iuylhvYl2TKbrllL
 SaIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5+DapBzOWZVhoStmLhMoxxQExvd7a4TYJkvz1PYnLjdT5oSviwyDOXHkmKSk1RgRiihgC5sAU8lI1@nongnu.org
X-Gm-Message-State: AOJu0Yz7SdM9PePXq3AzyomaICWdorpGcoSkaBfE0wpuhC8XSV0SW7hc
 UbBLgw21Mg6wNquNntZw6SgeRyD/+B6RIJcRMXVEJWTwXNGhDIm8AcEzkoYZ/gQ=
X-Gm-Gg: ASbGncvjioksqGGQ/bUpwb0jBIoLk/IA0oil8s8FrHL7859tECQ5Gc7KyOJqsAABzlw
 ekehMy7rt0Kzj8i/Sxf0AaHYcNNtCkp4Qdkp9etuIqshOZPa0POiz4gqsoNj7OU+CXZOanM3791
 LFRvxrMACcIQe8OVsMqiaRimLIBYBSzELbubnH03qwxgFVDhGXGESOalGk4T6XaJ7+v09oOTVSd
 QTyKYMTmknmWW6egf2GHDJ1WpXVM+zo+7fHgZt6Gdkgc2Hn5vLOw7Fg7e5m9ehRjfas7WzZYaG3
 vdekI7sWVr9YlYdTUVhxTcOPB1elbKTD
X-Google-Smtp-Source: AGHT+IFtsa0Nk3ruHe47Q9CPii0y32T1QxWzOO1gplocQc5m0cr29LKR8l5RxbGE+4v9uHMxOdPUfg==
X-Received: by 2002:a05:6000:2ad:b0:386:4034:f9a4 with SMTP id
 ffacd0b85a97d-386453fbbbdmr1289281f8f.43.1733779322084; 
 Mon, 09 Dec 2024 13:22:02 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386220b071dsm13951354f8f.101.2024.12.09.13.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 13:22:01 -0800 (PST)
Message-ID: <c401b320-b382-4887-82bc-0252dd9f8c98@linaro.org>
Date: Mon, 9 Dec 2024 22:22:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] i386/hvf: Don't send signal to thread when kicking
To: phil@philjordan.eu, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-4-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209203629.74436-4-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 9/12/24 21:36, phil@philjordan.eu wrote:
> From: Phil Dennis-Jordan <phil@philjordan.eu>
> 
> This seems to be entirely superfluous and is costly enough to show up in

So the pthread_kill(cpu->thread, SIG_IPI) is entirely superfluous?

> profiling. hv_vcpu_interrupt() has been demonstrated to very reliably
> cause VM exits - even if the target vCPU isn't even running, it will
> immediately exit on entry.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   target/i386/hvf/hvf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 3b6ee79fb2..936c31dbdd 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -214,7 +214,7 @@ static inline bool apic_bus_freq_is_known(CPUX86State *env)
>   
>   void hvf_kick_vcpu_thread(CPUState *cpu)
>   {
> -    cpus_kick_thread(cpu);
> +    cpu->thread_kicked = true;
>       hv_vcpu_interrupt(&cpu->accel->fd, 1);
>   }
>   


