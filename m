Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99378C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj1Cz-0002I1-PY; Mon, 04 Aug 2025 15:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj1Cw-0002Cz-5M
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:50:54 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj1Cs-0001LO-Am
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:50:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-24014cd385bso43784905ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754337049; x=1754941849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZdUogDzVtiDqAMTsU2r/oPn3famxoU4NYETLiYa0yoc=;
 b=y/HxInOk5EmjcxTsIXymaGnpZ2hGAyPayUOE3Bl+dxbOHR6JMyd9b3mUoHkdAI2v6H
 5NDKVHjCjehoVwcLk03EyEPD5l1mTRXQCWNx8BRc3sUlBD5C3GPhHfdYlEpGxDA0YpD4
 EoK9Di/6MbiNVPGNgADKz1uw5QKdgEVdW2Q4RqYKCixbw1p2dEhThymGmueh/I8jPKT8
 awvia4X3StCjPHNwCxbv2k/TnHlFzLqAgymHNArrwym2qGotj/2lqRGPYTy+2OpwJLGc
 jePBoiyuXD5Uet6tSIBPu823tLwG0/uKMwgQR8ACNbMzwc8THYgCYbcYFUX3+CLL2b9w
 WHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754337049; x=1754941849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdUogDzVtiDqAMTsU2r/oPn3famxoU4NYETLiYa0yoc=;
 b=Yig8gQvNZcdnR18yFwKjTzHdVppATUNjU5/so0WGOh/eg2tIRr/+n4Uog+txihl7Ov
 JqxA0ozfAGMKk0FKCaeINmiztcL9Zv7aSNISZqd0UMMgpXsL3luAFmy+YWVH9qzWdUnD
 eI3lG+/Sv+21V25gIilt15PYU2i16GmDSDWu1bqVhO74EjtAvwYpXgx2x8lrPNx7cR2+
 x3m+m130YX+BmlrSDX3dbn6zDpd83kEa7u2WZXylTzY+0Fzvz/xuvVFU8d/RsMBQr9jB
 Mdu+AEpG3ny1m3HWv73u2AvMGR1suMTMSLGIDqOGoES+Gr8Z85nFfOkmIFO6lArhWDvS
 bAvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsJNrJtBiDuQzndt1GQ7Bkd3XBozeD50hXDOTuBF5oRkiNWuGY/yiuMMttjH1/qgVXJaNIXpDjpHmK@nongnu.org
X-Gm-Message-State: AOJu0YwPltoycBbkvf46KHCdGLsRmxHRibBjD4FQzbIS5shqb2bROKG6
 xuFyYUh3xMYqK5u6kToxJ0ns6obxSlYAnzMPpknDCYgq396swGgzYJL3rIKg22Aw/y8=
X-Gm-Gg: ASbGncuq/QCe1e2ppw0kfeY+KwCDPEiyEswBwoc1viUzdcW3OtntjXHSofve1tIQywJ
 TeX1hLAWsu86JHzvYDZb6sclyZwoE8T68ZWI/DmiQT+JuOdkeUgPI4TzoJH61lwejHDTIpwBTES
 LBWuG0tXGU/ezSXCk+7qfxX2jjE9tdhDYwMNhSxfJ/hwUUPHAt1alzHhpXlmuXb21x5voPK4qWw
 tNPSqt06liG+Kv+fn5iKI5G693q8JD6VtYpxhFYdjfVhL1MCChxMt+ZVHy/hHyvlMNBJd9o+ZHf
 PR9cREVjbKvtLtlmRRYYM1LpW04uuHFd4JPPHlzakEFDL5thyaFojm4NOJc/gRp9H44FOikxhz0
 NZLh3MlX8b537tpPJbAA30TwhUPB11bQUqI4=
X-Google-Smtp-Source: AGHT+IE0GFpGd35I11q+C0EzxV2vWdjneZr3HYOH9C7tte4zQccwPGLN+X862PpHc+nJFfrKCg8POg==
X-Received: by 2002:a17:902:ea0b:b0:240:4faa:75cd with SMTP id
 d9443c01a7336-24247058c5bmr179026515ad.48.1754337048832; 
 Mon, 04 Aug 2025 12:50:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef7562sm115542525ad.24.2025.08.04.12.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 12:50:48 -0700 (PDT)
Message-ID: <a8239e8e-37ad-415c-b13a-4b4ce8fa2a36@linaro.org>
Date: Mon, 4 Aug 2025 12:50:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/17] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-13-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-13-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> Windows Hypervisor Platform's vGIC doesn't support ITS.
> Deal with this by reporting to the user and not creating the ITS device.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 98a1c74c42..0039f6a12b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -741,6 +741,16 @@ static void create_its(VirtMachineState *vms)
>           return;
>       }
>   
> +    if (whpx_enabled() && vms->tcg_its) {
> +        /*
> +         * Signal to the user when ITS is neither supported by the host
> +         * nor emulated by the machine.
> +         */
> +        info_report("ITS not supported on WHPX.");
> +        info_report("To support MSIs, use its=off to enable GICv3 + GICv2m.");
> +        return;
> +    }
> +
>       dev = qdev_new(its_class_name());
>   
>       object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),

Is it equivalent to simply using its=off, or is there a difference?
The info_report seems to imply it's not the same.

