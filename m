Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7518AC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 22:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj3DE-0006Zz-N3; Mon, 04 Aug 2025 17:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj3DC-0006Yh-4K
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:59:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj3D9-0000AL-SZ
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:59:17 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76bd041c431so3984675b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754344754; x=1754949554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bYfAdJ+j/SHhVvwWUHB4SY4SXH07M4/TVRGpkCak+Ts=;
 b=EraSZlI1wJhWP26IRBt/R9XQ+F4dVRHYrscghlkN6BfigjCkhiyyx1CoTMVnTRN47b
 T8IYttWpemo9PlunDr0LZKOEc2NzPb/eVr323xVxNqZnc8sSDAu9/19QQAmx6hp/ca5z
 uYjuvjJJPCABjlOhCuF8Rj+mxvYsLvAOXZw9lZyQcXXbGV4f7wGgXgC6seoN3LKFg3U+
 B1ByX6jjac9/ba2uYOrRFLTD6V2OHygGY6p/8W1g+EIlgoc6/vLapAe+sGuNSpLniN2i
 vDAUBhkERGxO5B31o6DTCC08ym+kY1XULOmz2GqWnfGPBo8CFtLzVPnhpw4ZsjupDdKO
 kCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344754; x=1754949554;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bYfAdJ+j/SHhVvwWUHB4SY4SXH07M4/TVRGpkCak+Ts=;
 b=JuR6C9ivcbWvKv8HqOKTJBV/n9wbwYvCw+e/LLPPLbY0EhmlI+E9HFk+M/qO73uw3N
 bf5SbeCIQLwb1Wgn4/BxOisfGwYNe+x1ltlfmEXdtftydF6BEzu3H+YcDjyWPBnsVJNu
 RP1LQ8DtQHGkaXTkjqOrH6lseD7meNd6IzxitJdmS86IL8fWYOlN9WW6+oVh/xVKGzZx
 x9TfZzcNnmTAvwMxyn2cSiwGLtNkbNVpSSLVlqj0qDsG61x7j95/exxcpjJSk0Yc+iYP
 82KZhj7lqbxDkMjyRMQ6w+tvZ0ybCUDCf82/GqkhnZicVG6c1EMXGgiOwihTvyv1ZcGk
 BCXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOqMZrpZ5KuGRLZeBPMYgyhyUOMWXRT9Do/80TnuYlu3Ag3l8AX/2OyV2oZPkhbLzC+p8ZeJgoifK2@nongnu.org
X-Gm-Message-State: AOJu0YwhlwiO/NjZRaP2PBi7zayfyIDG/NEs5Vpr/m0F1hjVI/nlcVaC
 POI70cdHj3A3vDMnONale3cF0h3guVkKtG3gwWQdcZ8GP3gA6cV+0PoNoPGcXZ/driU=
X-Gm-Gg: ASbGnctesBS44p3pjnM3iDQ0cmyIoO8AQlWGMbsQ/SJVYpnOS75ot5G6WhQ+jaWXUz0
 ZIOwCMjuLmbM9I8OYBWfmJDVmksx7QNLGNrV8ZI12NOpystg61zMWhJapwWhNgrYi+FhnSmUMUV
 /1UEUwkm0hdF3Z2Gy8/4coNfcRG9ZTOH2bPzv///K2RKNRqkrYvA2TLmKsZhM4ncaW1TVQwxL6O
 BP/exmLwgrWl77YtMyzoUtqneRln8TVk541++WDzjRL9sqANnpoOC0ZFZTxnw4Kq8c8g9aLd0R/
 vSDPBNFudBVXGW2jeSbdP9VgAd1SDQU+IGAbgQUJcH5NnRPaCgXBzCMYvPoSYy53o8K8xQ7N5xV
 ZibM9AfQJpqsxf+85PEMq2uCpjcAX2VR4w8c=
X-Google-Smtp-Source: AGHT+IGDbrFfvXI8S+VlPXHcm5KuntcJaCz6GD5If+mJTsF/y0UwYJcWdFzkJjili7Ajg2EEv7oN0Q==
X-Received: by 2002:a05:6a20:7d9c:b0:232:36e3:9a4e with SMTP id
 adf61e73a8af0-23df917c223mr17015713637.40.1754344753595; 
 Mon, 04 Aug 2025 14:59:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfd18c9sm11290352b3a.91.2025.08.04.14.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 14:59:13 -0700 (PDT)
Message-ID: <de952126-10d3-4562-b3c5-779483eeaed1@linaro.org>
Date: Mon, 4 Aug 2025 14:59:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] whpx: add arm64 support
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
 <20250804142326.72947-10-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-10-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c    |   1 +
>   meson.build                 |  21 +-
>   target/arm/meson.build      |   1 +
>   target/arm/whpx/meson.build |   3 +
>   target/arm/whpx/whpx-all.c  | 845 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 864 insertions(+), 7 deletions(-)
>   create mode 100644 target/arm/whpx/meson.build
>   create mode 100644 target/arm/whpx/whpx-all.c
>
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> new file mode 100644
> index 0000000000..2e32debf6f
> --- /dev/null
> +++ b/target/arm/whpx/whpx-all.c

...

> +    { WHvArm64RegisterDbgbvr15El1, WHPX_SYSREG(0, 15, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr15El1, WHPX_SYSREG(0, 15, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr15El1, WHPX_SYSREG(0, 15, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr15El1, WHPX_SYSREG(0, 15, 2, 0, 7) },
> +#ifdef SYNC_NO_RAW_REGS
> +    /*
> +     * The registers below are manually synced on init because they are
> +     * marked as NO_RAW. We still list them to make number space sync easier.
> +     */
> +    { WHvArm64RegisterMidrEl1, WHPX_SYSREG(0, 0, 3, 0, 0) },
> +    { WHvArm64RegisterMpidrEl1, WHPX_SYSREG(0, 0, 3, 0, 5) },
> +    { WHvArm64RegisterIdPfr0El1, WHPX_SYSREG(0, 4, 3, 0, 0) },
> +#endif
> +    { WHvArm64RegisterIdAa64Pfr1El1, WHPX_SYSREG(0, 4, 3, 0, 1), true },
> +    { WHvArm64RegisterIdAa64Dfr0El1, WHPX_SYSREG(0, 5, 3, 0, 0), true },
> +    { WHvArm64RegisterIdAa64Dfr1El1, WHPX_SYSREG(0, 5, 3, 0, 1), true },
> +    { WHvArm64RegisterIdAa64Isar0El1, WHPX_SYSREG(0, 6, 3, 0, 0), true },
> +    { WHvArm64RegisterIdAa64Isar1El1, WHPX_SYSREG(0, 6, 3, 0, 1), true },
> +#ifdef SYNC_NO_MMFR0
> +    /* We keep the hardware MMFR0 around. HW limits are there anyway */
> +    { WHvArm64RegisterIdAa64Mmfr0El1, WHPX_SYSREG(0, 7, 3, 0, 0) },
> +#endif

...

I understand this comes from existing hvf implementation, but I can't 
find where SYNC_NO_.* defines are supposed to come from (including on 
hvf side). Any idea?

