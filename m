Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D54C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 21:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukUEH-0000QM-Rm; Fri, 08 Aug 2025 17:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUEF-0000P6-46
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:02:19 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUED-0005XE-5h
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:02:18 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b78294a233so2107122f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754686935; x=1755291735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PEcUvJccWZ7a6pvXxqwMpv2c+4Vbe2O3qQZAPPUX6Mc=;
 b=Wck+r00WM9LMmw1zTSMj+Dy/S09BqMYAsZlJuTre7wC14ORLlSAsG/s9WvMTgsMXIT
 5Wrspu4a3EP71itcIRkRsOiQx/9eV+PwLEIlDCwHjYgU93oBJEv0E/3X9f8Lyj+mLNjl
 qJPlJQFuxlRq7LDrhseez5+H04l/NqV8/OKTu2FkHfIH0c7azapVlxGmeStrtWqZ2H5/
 A7yM33x3aUlkedGkm7dQelOQpPgxByxdk8YZGAxRBKGdUQ7+z6zRF7jAZWtBJLT/UXih
 ovkwTx4Tz/SYowfD9JgHP/wlP7phG/EGsUqogPbR89Z1zNagOwCMQKVs/439XUlYt8l2
 3ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754686935; x=1755291735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PEcUvJccWZ7a6pvXxqwMpv2c+4Vbe2O3qQZAPPUX6Mc=;
 b=RTydayW4xURgg5qXnheZ1w8iepHnjK6N6qswNkGJWaw+BC8H3cosl8i6tYStMUSt3B
 YQKNNGjD+5Nqdipky07hyrE7xV/1OVJ0jj8EvT8URGdPP9vcq9IXp1BBWFoBor5sMU1/
 98i2QctUhq6BxxpAMejeK7qwE0ARulFeiQM6G/sTRDNaxQ30TAcheXs/M0aIDQGJmrCS
 BhF5sn4fwGUAXHBx+USrcmVVqA76XH3MFwq+Gkj6Zzum4PX6cNyi1vXks/KpKZJx27nN
 5dIlv2l2HX4T+lUSP/lER9gaSiR6zk+MhKmDtmKyl7PYUsUfeO1sDdwt43fpS7mm2vkh
 8B1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW26K66T4NtSeVwAhOvApuDARL9OBtjOXVvzvzK6aHj/EJCjrd85dpQbEnfvzhUEpQzKKl/j+Mf0NTs@nongnu.org
X-Gm-Message-State: AOJu0Yy8ssu1xOgP/XCmF6Y46AjNPZBvGFHsKgsdf7MvkKvsuffnLaX5
 5EZvBv5QWz52Y+VxzgNo61TgO40Gp+zGPv0LnhYG8LOmPL1It3H+eMeT8aaCjy/JBBM=
X-Gm-Gg: ASbGnctCKwei/g4EYmpEY4XImMzvxo5DIobJ7zSS8sbManVTta6cllNN4JFqTsYfetm
 fuwTzYMxWrM3g16+/sAs1Zp92taCQhuqiCSJnx9A3CaobWAV1FfPoYF4t+VKceIlW6gLHf9HsOT
 /R6XMmXRJ3VXE+W0jA8aKhrC1kGItIG6HYXKOFA2pf0Z/h5YLrKEwvkOc2tlq9/Wt4pc9cMmiKa
 WJx6jFkY54Jy6Fv7g61nmjHLAViGzVn5h12cG3KwCT6XQHRTZvEZ0qMCvRHVHsYY5TDPj1sHhRu
 eiLBzqMpyQYX0PZDli0z26Z2LQ5hcXhTNAUPAHHLQ37cnTJnsKz90iKdieVUumqA+vLatrEa4+e
 YIHLWSJejMbfyLvxsyChiYhWPV2wlgUvcWttsyC/STXamDASqszbTDXq9MDIAgO1PcQ==
X-Google-Smtp-Source: AGHT+IFBLNQt//4DsqFu+0ozKB4+wf02DQ2xNv33ae42IBT8q/04vKLRrl1lXqhgdLDF6d4sfAoELg==
X-Received: by 2002:a05:6000:2c0c:b0:3b6:46d:fb70 with SMTP id
 ffacd0b85a97d-3b900b50bf5mr3715282f8f.25.1754686935003; 
 Fri, 08 Aug 2025 14:02:15 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458bd5a11d3sm143222145e9.0.2025.08.08.14.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 14:02:14 -0700 (PDT)
Message-ID: <42a2cb33-b929-4cfa-b62e-9ef82f938ed3@linaro.org>
Date: Fri, 8 Aug 2025 23:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/18] MAINTAINERS: Add myself as a maintainer for WHPX
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-19-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808065419.47415-19-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 8/8/25 08:54, Mohamed Mediouni wrote:
> And add arm64 files.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 070ba2e9cb..0a1f6e620a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -539,11 +539,14 @@ F: accel/stubs/hvf-stub.c
>   F: include/system/hvf.h
>   F: include/system/hvf_int.h
>   
> -WHPX CPUs
> +WHPX
>   M: Sunil Muthuswamy <sunilmut@microsoft.com>
> +M: Mohamed Mediouni <mohamed@unpredictable.fr>
>   S: Supported
>   F: accel/whpx/
>   F: target/i386/whpx/
> +F: target/arm/whpx_arm.h
> +F: target/arm/whpx/

(you might want to have a common section with both of you,
  a x86 one for Sunil and a ARM one for you -- adding there
  L: qemu-arm@nongnu.org)

>   F: accel/stubs/whpx-stub.c
>   F: include/system/whpx.h
>   F: include/system/whpx-accel-ops.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


