Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0497BCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 21:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSO1-0000JY-MW; Tue, 19 May 2026 17:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPSNz-0000Ix-Rb
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:53:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPSNy-00057z-68
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:53:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso3460966f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779227636; x=1779832436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SKMGJdAgJ0bvdwlnebjPxaHHuhrTT5uaf1Zj+7rgSqM=;
 b=sCab97gXDVo5Zx40Nur9GFxSUgu2wkdlrrgidXNkvP5b7iHwgoXdkJIvNDn+oyDtS9
 zsmO8Jb5js6363typsmNAdScJZQ7kmiRpe9d9sYaipqaCu+YUS8cArE0Fs45aeFKPn/c
 k5fWN5u7HHydPMghQ4ChIp2PNz4Bbr5d5CY11RVb6FIoFwbn0aXt0tw56sTEPORM7tMf
 n48tE9lhGDxcFJc0By9u4AIc+no5iISJLe3u5VfPz+srA4Lv3RwfRxcRxueDoJYDa5ob
 umBojkCskNuj1ugz9l3Zy/LwnJ2nlMomUBwtzuReDeD7FNlK6gRSBuZ7aJURa9qcLsGR
 vS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779227636; x=1779832436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SKMGJdAgJ0bvdwlnebjPxaHHuhrTT5uaf1Zj+7rgSqM=;
 b=n/xMef98WZhJuXtVTmugZFIU6UX3IMNH0/BehsZdqm5wSW2r8R0sucUkQHlK6akR/K
 szHcAGSYgEwYftP02yUWXSQ+UfNCk9gynFZ+dzpwhOWZKx8lN71j3Szha+RucjyCpYyE
 xm/en5BIZRj0YzotkOz5z2GUryMP7xB6pDNrV7ph51ZtPOfV9uyP+Y5j0OnqOdXSNAtv
 izzMOdboBPmh5OEy66GIcRWyEWmUXv9S0gwZrDkOIrobNVNcwTp5YmfsadCyzCQwG+Tv
 ZCWMR70tS+ouUvxE8JwbJj7QVHh1OKhOKPdZq6liOu4HDGvAhohqyU5cxIslhRu/udkT
 iYhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+stvTLd9W+vZJ7SWaEcbz2m+CVtMuTdrfkuie/ZfWz61BqQbkijmekywbU2Wg4+2vBpXUYB+zkScug@nongnu.org
X-Gm-Message-State: AOJu0YysaadkP1P4GCplEDJCtg7WrTFBf9nOUr1Tvc0Vs0hOdJGlfNGB
 2sZslS9wun7VCRQXgrVgoo+wlvDd8iEJ2Z/39iTGueDluKYYP1zvLHm2cuSAGRgDvV0=
X-Gm-Gg: Acq92OFfA/4tNtikqlHOOY3oFrtPQOqpkaW1A+qutmWUoJCtNWg/GmUZrCVst/ayoqN
 bmAKoRXuJgnqtbl4c6KE/4+F7zSV8urhtOfniAm1zHIjQMnCcgo/96QqjoWwSG1ncJfNgVN7jcp
 jKqTWVgRJ3JQgM8rlnmXP3gz1plcNtVlOTJD9ei41ISwQj1MgAwg5MXEhuEPVXCy4yeI7pz9CA+
 T69ZSFU+mAzae/XqSUhmTIGTLvTXQTl+PJsTadz4whkwJ/dUAYUZS87HJVpCBKOZUjg7Lyu67q0
 0003ktfqj1T84S/FD/X99/l87pK7xdzxsUPfrqt0r5av2wSnv4hnTp0p7CVroFvMhbZmpw3OwmE
 0zud2BVvNi+1e/RUmUNIYEr4m9mwo6m08847qLf/HeSAP2kLbKJ0zr6WlWxCprtoZjTVZkR8zUA
 5QBmyQjpRgWfZIADWO9EB3LWEYTWc31rv++hSBIcTQmre5RdO5CmSoKFWP5KRf+/QrMw==
X-Received: by 2002:a5d:6401:0:b0:45e:73a1:90b5 with SMTP id
 ffacd0b85a97d-45e73a190c0mr15441665f8f.1.1779227636224; 
 Tue, 19 May 2026 14:53:56 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9adc2209sm45392250f8f.0.2026.05.19.14.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 14:53:55 -0700 (PDT)
Message-ID: <ead30676-71ac-4c50-8414-601019ced7a1@linaro.org>
Date: Tue, 19 May 2026 23:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv1 4/7] hw/misc: Add MU (Messaging Unit) IP to i.MX8MP
 device model
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, shentey@gmail.com
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <20260519175635.3245229-5-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519175635.3245229-5-gaurav.sharma_7@nxp.com>
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

On 19/5/26 19:56, Gaurav Sharma wrote:
> Add emulation of the Messaging Unit and wire it into the
> i.MX8MP SoC model. The MU provides inter-processor
> communication between the Cortex-A53 and Cortex-M7 cores on the
> i.MX8MP SoC. It is used by the Linux remoteproc framework as a
> mailbox for lifecycle management and message passing with the
> Cortex-M7 in an AMP configuration.
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   docs/system/arm/imx8m.rst   |   1 +
>   hw/arm/Kconfig              |   1 +
>   hw/arm/fsl-imx8mp.c         |  39 +++++
>   hw/misc/Kconfig             |   3 +
>   hw/misc/imx8mp_mu.c         | 308 ++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build         |   1 +
>   include/hw/arm/fsl-imx8mp.h |  10 ++
>   include/hw/misc/imx8mp_mu.h |  53 +++++++
>   8 files changed, 416 insertions(+)
>   create mode 100644 hw/misc/imx8mp_mu.c
>   create mode 100644 include/hw/misc/imx8mp_mu.h


> +static void imx8mp_mu_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    device_class_set_legacy_reset(dc, imx8mp_mu_reset);

No device_class_set_legacy_reset() please.

(We should really gate it in ./checkpatch.pl).

> +    dc->vmsd = &imx8mp_mu_vmstate;
> +    dc->desc  = "i.MX 8M Plus Messaging Unit";
> +}


