Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C29D6B07A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 15:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTzc-0003PE-ON; Thu, 29 Jan 2026 10:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTzZ-0003Fa-8M
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:31:33 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTzX-0006fR-ON
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:31:33 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79456d5ebf9so11708987b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 07:31:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769700690; cv=none;
 d=google.com; s=arc-20240605;
 b=eIEAYeC0LUPl2lVnz8T9iBeZb8+/Fdyu7xSMpIbR96UfOHL6YAD1EpSzhhrtiAEZHR
 LPoGEVxtpKc4w+ypFrBP/7RkDha5RFUh1fHKmvKMRhMaRd4PomqWT3F3/hn8he/1tK0g
 zvIDTTQ2mEL0o/pSK2Yr8DS3zcL+8tCzYyopsIThdkNXWPEm76+QmECUIDwreB6AMF6C
 dJegv0c7aSH2Jvo8Cw0mXAfPfXNArMrsybOA1738VilvJfzAmRyvB97Q5IMHL+9wvWeX
 BME+F4aec5YrALSgK/d6OEsJmRVIBWz17TeRAIbNzyT+N9FuTIWjccJ7zH9/JC7bK1Qs
 inzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e75Fsiedu5+aeIo3TbRJepvWQBvQru25HrO6tbDPk6o=;
 fh=Y0v7H7/KoiIv4wajEUo/XxWAh9oE52uzHxT0mnCejkM=;
 b=S8r94rfI/IrJQo5btkwF3i66AhjBYHzOdslpKwYyzfFdzdkWMDFv0tYYQ70pBHw+wO
 hHt8uG5Geac1gsFRa4SIz/GICQ7WMgneGb87pJfMI2nFDWQZALySUe6kGHSQdWWHjKNd
 7Ej7NjO0d/Ci1/VkEqRNt6jf2N872N8Yqs5rxIkfwnqzJ47fQ3oHlo7iGAtBJzIaKyfc
 Zz3FEDGf7bzamlZ1ybYBvyyPgdbjmqD2DvPWQTRzefR/HQdzZp/OZnjxk11SjmKrYeYT
 KEhswxy/go88L5sGl5NsCfZgTNntArDWKLiGa1UC9Gi72r4iv7rjg5W75+m8cQalGhjm
 u23g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769700690; x=1770305490; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e75Fsiedu5+aeIo3TbRJepvWQBvQru25HrO6tbDPk6o=;
 b=gzMrI1uqlcOEt7hu+dl+eQoJ6mSOmKs3iETjCWMICLxtDrtEyn5JbFo97HEw4riZC2
 gByK8oHuUg0zeeZhR8tRIMK3+PwzJOJyRK6tABmdFCUDqnR6y1Sz8H+BeQKj4OgRCiOG
 8rGwKgzFcN9LOmG3ugDfM9TH90qRB4cZCUJXROnr3kZUm+0dHhMryan7EzrxxAyHNOzv
 hh0jPr/SkGkT6J8B7heFNm71fZ1e4nJ2pM+3BllK4WX70y9NCPX82U/IQkdUHV3hILVo
 peNtnGGdjlaEWVp6ffaU6XyrnP2XCczWm3IX3HKeWjXz+PBrF07p51XiVvmE73a3pI2l
 hVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700690; x=1770305490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e75Fsiedu5+aeIo3TbRJepvWQBvQru25HrO6tbDPk6o=;
 b=nV8ZpV+vbpEFTRW+cUt5bmTv69h12A54jU8TPU+El2vB2LusQOPqhqpJWvWinBCuhs
 UJz6o5nqQwQLazA36XVX8QAntppve2eBWxegxrIq4rDa4Aw6A/lrEAmEjPTsMUgP7c0V
 8ofdc8dsPceML27b8G/8ccR60EgM4J4evg/3J4ort/tbI7Ru9n8cF4wyUaNOvszK6NG7
 xjx1o9gTJsV+AxsFeXaBtl7dINmjCWUOOchIU3aTFUqnZkt7quB4k4uyE0mhr4lDJMdf
 wuWcvYce4aXmCz2IUPG0q2qRZ5Mk+Rovvw7kU4MeSy5PHz/M3SlgYPMT52GSm9kR2pTe
 +xlw==
X-Gm-Message-State: AOJu0Yx9XQzuswqiNh1Y8HHF6wagS9PyrbIaWAvk1nQSfp3DMWSthaHF
 kxlnvnWOPu5Z9j2LaZInlOP+0fTBweTY3ZwQHr3JFSagpHyPk4pc3Mi7PeF1k2sLrbEjPsz+7R3
 CGzzpikPVIy/AMqGvsaMGXa9M4akB+UFISka2nJhU3A==
X-Gm-Gg: AZuq6aLzxEG+K48h7j15WQz3DAS2H7FZdoeZB9noIpsdFHNiCWxcSNBt233iRRiTuzc
 9jXXFIfkOuYz07t24/c2xTDk6YzJHmPcRyiUboc9sh+i+Uk/M1ZPcQ2nPKGEXfhpMgZQc+vOJDi
 LtozvXoLgTecnKhFk/kHEFmZBMpkBQPZDfe6xDm1KUEQ6B1xOGrKRtTCx5MKiavsAF47w32vIU4
 YbmsROz+OUbUBn6nicUcosSPu8sOT3+fuWoJcTSN+aC1kZr11kRIha1xj9gc/oxRmkOiw==
X-Received: by 2002:a05:690c:dd4:b0:788:1b67:d741 with SMTP id
 00721157ae682-7949de8253emr83267b3.3.1769700690290; Thu, 29 Jan 2026 07:31:30
 -0800 (PST)
MIME-Version: 1.0
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-21-mohamed@unpredictable.fr>
In-Reply-To: <20260127182805.73212-21-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 15:31:18 +0000
X-Gm-Features: AZwV_Qg1WATCwSufdmPxyH5WetHRcpWhB31D8z4FidksJvzSyQsOxMu86osm3x4
Message-ID: <CAFEAcA9TwmftmcnxbWMoeAfuV6LD9pPv1hVXiAOr56UKUD+z+A@mail.gmail.com>
Subject: Re: [PATCH v18 20/22] target/arm: whpx: instantiate GIC early
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 27 Jan 2026 at 18:29, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> While figuring out a better spot for it, put it in whpx_accel_init.
>
> Needs to be done before WHvSetupPartition.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  target/arm/whpx/whpx-all.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index c88c67a9e2..55773555b7 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -939,6 +939,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>
>      memset(&prop, 0, sizeof(prop));
>
> +    WHV_ARM64_IC_PARAMETERS ic_params = {
> +        .EmulationMode = WHvArm64IcEmulationModeGicV3,
> +        .GicV3Parameters = {
> +            .GicdBaseAddress = 0x08000000,
> +            .GitsTranslaterBaseAddress = 0x08080000,
> +            .GicLpiIntIdBits = 0,
> +            .GicPpiPerformanceMonitorsInterrupt = VIRTUAL_PMU_IRQ,
> +            .GicPpiOverflowInterruptFromCntv = ARCH_TIMER_VIRT_IRQ
> +        }
> +    };
> +    prop.Arm64IcParameters = ic_params;
> +
> +    hr = whp_dispatch.WHvSetPartitionProperty(
> +            whpx->partition,
> +            WHvPartitionPropertyCodeArm64IcParameters,
> +            &prop,
> +            sizeof(prop));
> +    if (FAILED(hr)) {
> +        error_report("WHPX: Failed to enable GICv3 interrupt controller, hr=%08lx", hr);
> +        ret = -EINVAL;
> +        goto error;
> +    }

So what happens if the user asked for a GICv2 ?

Can we have a comment to explain the ordering requirement
mentioned in the commit message that is forcing this to be
here rather than in the GIC code ?

> +
>      hr = whp_dispatch.WHvSetupPartition(whpx->partition);
>      if (FAILED(hr)) {
>          error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
> --
> 2.50.1 (Apple Git-155)

-- PMM

