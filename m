Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDBDCC6B19
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfeE-0007Tm-Dz; Tue, 13 Oct 2026 12:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfeC-0007T7-6m
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:46:40 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfe9-0008Sp-2A
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:46:38 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8ab37e44643so1146997b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791909995; cv=none;
 d=google.com; s=arc-20260327;
 b=gQMnO6SNC/WW3R7HFb3t8DJdkHmT3nACq//o9R96Ntjrxpu/iByHzuwv/yfuzs8Yf7
 91b6A+amMQegUetCQwjsHM9aS0y2jT8fV+dn3ogu+F7SxdvTj7riX0QVJzrKJfuM9eGW
 WFXZ+Iopr1ITtcNVHNRptlloWEuuE0BM33s0j/znc9UG8nodWI2XItip/JnkQkhXMj8k
 iN+32hVqSvW9sjvxk0w3jGuBAVkavFm5vyBfixjK0UR6W7cCWyFTc0m3fs2Su6iGIpbs
 4sAILTiweBrElVNY8WD3PKDvAlhilG0UpClhQKXVumcESS3X5nKO2dvGMZ/cK7jVialZ
 E6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0xh+kS0SvoInvRUIsUOjK7U33/ie4eIS07y4C4K0t3g=;
 fh=STFjNyXLj0lfgNvlZzFLUS1rWfs5JAUbmS2H0sDlju8=;
 b=o6A4hDwpHa0KwsMEZJZ67DCSao2qhdTQez7S9CaorWSKWCCvTHbikxUi2kDcW3FX/Y
 pjRj0Y5swcUpoDg5G7E53e6xArwjtsYBZgmrlDaqIrV1VLj0JTZdsYgW5xp+/em0F0BK
 FMgyANqCjwiznNRjP16fKFnjvYB6Y6KVMnqpAPrKhD4VlHp3lN4sHy6ZlT5nXXgIQS3X
 Edpq3HUlm5HLKf42LX7ifane9/xTKrLwXy90sjGeu1lQsEw7fDRsHWzbae83chm0fLEM
 zkkFXHs+oGnSfSSoJ2YBKktctEbk+qg8DDmL4x5vVQubsSWKYoqGZD7E+jZcuImJ/brZ
 egxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791909995; x=1792514795; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0xh+kS0SvoInvRUIsUOjK7U33/ie4eIS07y4C4K0t3g=;
 b=FJYpUcwp+FAyFjCY55DHqHEHTSgJYoR0XJSegfa34kxqNKN7QfqEmTHhsF5AwTMQA+
 LAxnQTu8tPOuwZt9KFM6Rv9mqE1JMkpvZMEQxxYaxgY7jgH+6rnMSmpMCTyBMVDOE4oq
 Sno73duEbNDiTOUM7O0RH1rQQhMilgzfoOZxqS3E3zovHoscHmUJSuO24OA4Qf0WMwGI
 ZWwAnWRpSUwbbQvuYIdy63EWtatBoYxG0v9ej7Ubm5zV89NDmiZL2Wav/xmX7pPPXjTh
 9yXBstpNDUt4IsnjJuqqPUWuUPmVboRt7W45b+eEYWQyaqVeXn95Rwpon4AOFvy+dc2X
 kL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791909995; x=1792514795;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0xh+kS0SvoInvRUIsUOjK7U33/ie4eIS07y4C4K0t3g=;
 b=ssrybZd/nUPJbzwR5c7wTSUE5Yug54nXHXAmQ5mD+KGNooYR5hsu8aFqIrQvfauj8t
 l8DHenH+KP8FbqNxXCST1e2eJ7426TjPqX+cFUzRPLahZGszBeqoscWWaFV+f5YaL2o0
 FCWg1W0Z96eNqXz6N4mzej51dleSt4dDudC+qNHLj/up9kEalUE6iHdlHYiDwYHauSVF
 Cvvof/LE8Et3Jdu6rnxBdTa2gI7A7fwnrMWfK93L+YT1esheApbgpJsVRN5H7px6tzEY
 iHLURL2IpWeYfPKrAcPqSzc4/lUl4U5MIw5dEKAJDc6j1VoUe+kGGM76S8n1YnOkImvR
 UZtw==
X-Gm-Message-State: AFq9FYIME5Fxgv81jvdNWBuYZob6V/QvMtZKiyNuqvWUYpuCyV3LKYi0
 nmpZ/OPCY75Ke+9hzEWVaNo+ETc8nUBR2JimSZFmRrbFZkLiiuapjqyBo3h1/uVdCHCnw9y4R+g
 1r730+aolD/XnTIwq73tz748F9+BRZwIe5TUnES3vpA==
X-Gm-Gg: AYBFou1wcR5STTSB/ysB5Ge2KCMYa9tKw7VbrBfsGDgY7peZnHgvbFdZZqLUy5XbNg6
 +mfIj1XJoM41hiDIFuP4F8Qz2V81l7wEldFX6rox3vqOqm48mQFrFqWVvLLSdw+516IH8TKs2ni
 uSCUepsBZc/1yervQOE1eKW2bs8iMlrdx/LHxw+lhm9unok3lYKXH2SU/MMzzo4aimI77RJbQxY
 nX/B037dpErVNNDoH4A6PMPZHHU1cRKVl38TV/Wl7/ZaT2Jkg+4rFylu136ieduI4pprb0/DgQ5
 sT1GMKm8QDvd5o+Y7HDQrVy4ZpW+ebQlRxyjUkfgTBeeTORA4wrgVPQJ6qece1PuhpGLfn1X9Od
 0W7sxS7TbuPbMVOvNhkWh0v/l37fEVCJsUr+pvOQ=
X-Received: by 2002:a05:690c:d89:b0:8a7:6a41:12db with SMTP id
 00721157ae682-8b07ebfe3d5mr47459737b3.7.1791909995139; Tue, 13 Oct 2026
 09:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-6-aefe5e76a0e3@linux.microsoft.com>
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-6-aefe5e76a0e3@linux.microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:46:21 +0100
X-Gm-Features: AclHuK_BRDixwbQI8ndxNsGPiTVooqSj1t6ytqm9loLL2ErZqwTEVEMFEDMTFcE
Message-ID: <CAFEAcA_a-y6g=mjXECBUEqqcMWSy1wbNY813=4SgdqKVKh8npA@mail.gmail.com>
Subject: Re: [PATCH v6 06/14] target/arm: convert host CPU feature ifdef
 ladder to runtime checks
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 1 Oct 2026 at 11:52, Aastha Rawat
<aastharawat@linux.microsoft.com> wrote:
>
> Replace the compile-time #if/#elif preprocessor ladder in
> aarch64_host_initfn() with runtime calls and add mshv_enabled() to it.
> This ensures the correct accelerator is selected at runtime when
> multiple accelerators are compiled in.
>
> Add CONFIG_MSHV to the aarch64_cpus[] guard so that mshv accelerator can
> register the "host" CPU type.

Don't do two things in one commit, please.

> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>  target/arm/cpu64.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index dcd0d698b3..a9e346049d 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -811,17 +811,21 @@ void aarch64_host_initfn(Object *obj)
>      }
>  #endif
>
> +    if (mshv_enabled()) {
> +        mshv_arm_set_cpu_features_from_host(cpu);
> +    } else if (kvm_enabled()) {
>  #if defined(CONFIG_KVM)
> -    kvm_arm_set_cpreg_mig_tolerances(cpu);
> -    kvm_arm_set_cpu_features_from_host(cpu);
> -    aarch64_add_sve_properties(obj);
> -#elif defined(CONFIG_HVF)
> -    hvf_arm_set_cpu_features_from_host(cpu);
> -#elif defined(CONFIG_WHPX)
> -    whpx_arm_set_cpu_features_from_host(cpu);
> -#else
> -    g_assert_not_reached();
> +        kvm_arm_set_cpreg_mig_tolerances(cpu);
>  #endif
> +        kvm_arm_set_cpu_features_from_host(cpu);
> +        aarch64_add_sve_properties(obj);
> +    } else if (hvf_enabled()) {
> +        hvf_arm_set_cpu_features_from_host(cpu);
> +    } else if (whpx_enabled()) {
> +        whpx_arm_set_cpu_features_from_host(cpu);
> +    } else {
> +        g_assert_not_reached();
> +    }

The reason for the ifdefs is that if CONFIG_HVF etc aren't
set then the functions hvf_arm_set_cpu_features_from_host()
don't exist...

thanks
-- PMM

