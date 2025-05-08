Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C46FC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCuvg-0007Tb-DO; Thu, 08 May 2025 02:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCuve-0007TO-FS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:40:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCuvc-0002F6-DU
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:40:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so742552b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746686419; x=1747291219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/OsBFC3nZCS/UxXhP/fCnCeyqUT9iKnjwcPfGuZbrak=;
 b=ww4EZKCqqgEEe7dkS3GMkiLwtk1Ad9R3rWbMXzuiYfbGzs3z5p6noafxBKAh0kn5CQ
 RxFSBj8GnI/Y87cLOR6L+DXICBgmA4HnstDHSZfc/+9dS/rq9kZKeQagFoD6Nhcwiw3y
 sDthhEi2HHYwsgURbn2515X8by61gDuCc2b43XKEmFTsEDvderLP4v4XYJnUrniZAdMo
 /Me0APmZnqGGmBbxTzOm6nsK2R1s//SQbxcJFFnS/W1VigIwcB3WeEcAo6oAndveCv8u
 z2fkHaKUEqDq5XxS/Q/6+SemFHI5KxEOmR6fanuCUF13ZqrxW36Pv60Ir7/qzIRk9wQ+
 RI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746686419; x=1747291219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/OsBFC3nZCS/UxXhP/fCnCeyqUT9iKnjwcPfGuZbrak=;
 b=b+Ojmy0g/kupluMYVMJTR36BVDfZ0L+x/lg1kb733EMsPTeD3+sC86W425hEBo9ZKk
 hRp/wFE6ViYshzpnNva/4nw11r93+m/ykqrTN0gKbdrdYOnREHjRgWLps9aVGL79L87a
 4yrTY2txaZibRMLwV/APLnQMWtc5cE56mVboJAAmlkhjo502u9RJxrj4AgLx4QMMnQPN
 ttzhxsVpvv++MX+V9uMuwlsYjOn5LnIoqG77oJyQcdv/SjcSHwes6VvI0eEBczF9g46X
 M4O0hlIrb7LBdW41EpPGfTv1iuQy8tJ9QybuHv7ABq4tMoEZdFS2TspQtNa9WXGvwsO5
 8e+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvD80RoSucanHjpaJDXinYOeCt+n+97w9V945okYjlRqHE5WTwBat9iHUXfWH323G4Tn7c8SlSYFET@nongnu.org
X-Gm-Message-State: AOJu0Yw+zKuy0DIqyVvYHfqxIF21oevSrRWM+ZET7WQmQTfhLNCEpJvU
 hSM312IbGleRqbqQX4AuuarloxtoB/uRwjZjyT3tu+YKlokfi3QIzVOyB0cTab0=
X-Gm-Gg: ASbGncuoXe9u2ypuSnuFxBlX9LBVF0ObThReMU+D6sJgz0uYxYNiHizawNDKKNMbvb3
 We24PKyqbb1bp4poBmoGDQPl5b2AvhXgaailiYm2GrYK+vjHnBwflVeSzpAJVMqQXwFI70FtmIG
 pYT/ZR05hbE98FWimaWVjS1j/5ZFL9unW20/l+CqFs5T8eQeBKHJBzPflex249aj30qaMjs4KSz
 eSIxUL87iyB8tDIiMkRXCpM832VUu3OvLtpGKRU6crSpxGVdontUgrpXGh5UXj7PsZYu4PuFJ3o
 I7th1ibR6DHVNNuJSYNOJgyI4ZAp9klr+P6lD3pi1jAJgzLCUq6e2S4XewzYZPoF1ObJHP5l3sY
 hnuREgBfwp7Y3i2J0srk=
X-Google-Smtp-Source: AGHT+IGLXtoBurY6nWEPIRIdZhJPBq21/XNNZVR06b31zNPqEX05JoYjiwYnxEw0EVrjOdFtiNwe1w==
X-Received: by 2002:a05:6a21:6d83:b0:1f5:86c6:5747 with SMTP id
 adf61e73a8af0-2159b05448fmr3443562637.32.1746686418761; 
 Wed, 07 May 2025 23:40:18 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dbbb15sm12859841b3a.58.2025.05.07.23.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 23:40:18 -0700 (PDT)
Message-ID: <34d4719e-e8e9-4f2d-ad57-bb4043cb540f@linaro.org>
Date: Thu, 8 May 2025 08:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] qemu/target-info: implement missing helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, berrange@redhat.com,
 thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-9-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507231442.879619-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/5/25 01:14, Pierrick Bouvier wrote:
> Add runtime helpers for target and config queries.
> 
> Note: This will be reimplemented later [1] using proper information in
> TargetInfo. Meanwhile, just add a simple implementation.
> 
> [1] https://patchew.org/QEMU/20250424222112.36194-1-philmd@linaro.org/20250424222112.36194-19-philmd@linaro.org/
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build                |   2 +-
>   include/qemu/target-info.h |  14 +++++
>   target-info.c              | 117 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 132 insertions(+), 1 deletion(-)


> +bool target_mips(void)

I know this is the same lowercase name, but maybe we could consider
directly using target_mips32() instead of keeping the technical debt
of having TARGET_MIPS defined for both 32 and 64-bit targets.
Thankfully we cleared that with recent targets (i.e. LoongArch or
RISC-V -- AVR is a bit different, since 8-bit AVR and AVR32 are
distinct architectures).

For x86 we often use 'x86' as any of (i386, x86_64, amd64), maybe
we can introduce target_x86() too.

> +{
> +#ifdef TARGET_MIPS
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +bool target_mips64(void)
> +{
> +#ifdef TARGET_MIPS64
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +bool target_loongarch64(void)
> +{
> +#ifdef TARGET_LOONGARCH64
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +bool target_riscv32(void)
> +{
> +#ifdef TARGET_RISCV32
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +bool target_riscv64(void)
> +{
> +#ifdef TARGET_RISCV64
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +bool target_ppc(void)

Ditto, target_ppc32()?

> +{
> +#ifdef TARGET_PPC
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +bool target_ppc64(void)
> +{
> +#ifdef TARGET_ppc64
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +bool target_has_kvm(void)
> +{
> +#ifdef CONFIG_KVM
> +    return true;
> +#else
> +    return false;
> +#endif
> +}


