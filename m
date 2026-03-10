Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E4BFD2D79
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwqO-0006Tb-NN; Tue, 10 Mar 2026 09:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzwqN-0006TP-Ks
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:09:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzwqL-0001kn-Sn
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:09:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439ce3605ecso3875110f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773148188; x=1773752988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uy9gRJWLZOgLRLfnHyfUrf0dXkImlMoYYf220wRdO7M=;
 b=ke6T4dcjAsDr9NzTg0KdTOeulNcCtq9A67xMCw6kDd4Dc0vXJmIx6hSvFlk012vOXq
 AaMi+q6fQy4cSlCgqv+KlMlXAQcAzsjntg/wsXRsJARb4lBUEbjoog0phMih9TL7TZS2
 H7cwkQp19CaGjH6zAYN8Big3Q3cQkfSl1V2OLaNLSWf6sUf5Yv+BDceRcGE7buqSbKXE
 JUez6iYBWitfkdvLCHooSZ1Q4cPX0SNuA6x34HET5777T1lAkMRxx6pigbc89rripvyo
 viouE4D+CTLymXJVvICow7fXhT3VfRja4dAbr9zf8q9cLQL62AiAqSEWASHE8M4Ucwqk
 iBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773148188; x=1773752988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uy9gRJWLZOgLRLfnHyfUrf0dXkImlMoYYf220wRdO7M=;
 b=ejul2zFlNtbfv7NKMzDescjcGtYR2ka3cPMABN7Un2PkWSX2LAdlS1RNVZsEIIQza8
 P/KVsvp3mkVYC1TDvq2L2C7VPKwF2v1R/kBvM8hf+c80qojt7+IYePIvGyjJT5TGKqyg
 gkiSsyWJdSj8Tey0iCNaFM8m5ppUvm1BJpfPwXy90deGrEEopgV1MklAzPBITHK1FcwA
 K2Z1PRl4caO4YhV6jjN2acinwQmbnIv7M7PWF2b7mqcjWmUjUuX9KGIj4YTSf2jf6ezZ
 FXFag6sqB2DNa31f3rmMGWUv6CbRGJh0TWtxdwA2isLsSe9aGzsizzPgmpYzxD1YpSod
 jbdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlypije0k3zrcv7iz52ua+BwYZv4V2luDVs4tt7HtlIDyUvMweK4VMARhO1Ob2MUe6bCftpWcKiwGf@nongnu.org
X-Gm-Message-State: AOJu0YySNnJevtMwuGfOZNcz9mrKR8t0weffGKAmJN8TlvIQrzM1WpgZ
 yj6EGc4FsmwDmQDV6WwN0K/DOr0exvbyCMeR0x7dsfEZiWyouWHx9fZhdAOzg0z9iGQ=
X-Gm-Gg: ATEYQzx65iyd29CMPRyIgcg2LPJKBg7GkDpDR0jCMkFIWIS1Za3QCDsJ1YGAYYjEDuY
 YjHFtBIJbRwD0kwSCONnIENTmvhHFQHWqWBByGs0Ro/T8cvnxRlfbbkT/ATSXNIoVyI0yRquHPP
 +dcZmUi/aiT3l5AYLCj2wwFfE9rm2B3UjexM5/JYO9rJ60Xd7qrPzAbw+HtMflx3o/cc88E2QaK
 ME537vdU/r/G3avq/Jkz0cvpR3JBSvNjbiwWE+HxQefhXKnJbq04iPM0Mz0JpNpbjY4zmJC9FHM
 JV/ItEJYe1T5NoZENQMFv3wS3wHvEhLprhCGLXC9qr0DY4JrdNK0fm2zYSRw7WeEesmrENNj2nN
 4rWUQUW1WYccrPapvROkhPUNV0pzfstyY7waCrn5QXIreQtH/z/p0A2E23BdH7a5T91mvqEhr3y
 D0jUG0OtfbuMyAmvh+0MiJJXAWYil78fegCeNGhGX0eV4BZTCLrlGyJdltAsQtiQYMag==
X-Received: by 2002:a05:6000:26d1:b0:439:b486:ba6b with SMTP id
 ffacd0b85a97d-439da89401fmr26953631f8f.39.1773148188080; 
 Tue, 10 Mar 2026 06:09:48 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3d98asm40051960f8f.30.2026.03.10.06.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 06:09:47 -0700 (PDT)
Message-ID: <daec1668-d4a2-4aca-829d-250779b6efe1@linaro.org>
Date: Tue, 10 Mar 2026 14:09:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/32] accel: mark kvm, xen & hvf as secure; tcg &
 qtest as insecure
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-18-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250926140144.1998694-18-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 26/9/25 16:01, Daniel P. Berrangé wrote:
> TCG is too complex to be considered to provide a security boundary
> for malicious guest workloads. QTest is only used for functional
> testing and thus is not relevant to mark secure.
> 
> KVM, HVF and Xen, meanwhile are all servicing virtualization use
> cases which must provide security.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   accel/accel-common.c      | 1 +
>   accel/accel-system.c      | 1 +
>   accel/accel-target.c      | 1 +
>   accel/hvf/hvf-accel-ops.c | 1 +
>   accel/hvf/hvf-all.c       | 1 +
>   accel/kvm/kvm-accel-ops.c | 1 +
>   accel/kvm/kvm-all.c       | 1 +
>   accel/qtest/qtest.c       | 2 ++
>   accel/tcg/tcg-accel-ops.c | 1 +
>   accel/tcg/tcg-all.c       | 1 +
>   accel/xen/xen-all.c       | 2 ++
>   11 files changed, 13 insertions(+)


> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index 8b794c2d41..e807103379 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -397,6 +397,7 @@ static const TypeInfo hvf_accel_ops_type = {
>       .parent = TYPE_ACCEL_OPS,
>       .class_init = hvf_accel_ops_class_init,
>       .abstract = true,
> +    .secure = true,

IMHO an accelerator must be at least "supported" (in the MAINTAINERS
definition, "Someone is actually paid to look after this") to declare
it secure.

So far HVF is not, and the current developers interacting with it
don't seem to have time to cary such burden / responsibility.

My 2 cents.

>   };
>   
>   static void hvf_accel_ops_register_types(void)
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 0a4b498e83..1d49a59053 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -304,6 +304,7 @@ static const TypeInfo hvf_accel_type = {
>       .parent = TYPE_ACCEL,
>       .instance_size = sizeof(HVFState),
>       .class_init = hvf_accel_class_init,
> +    .secure = true,
>   };

