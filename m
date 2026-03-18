Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F64D103E176
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2qjA-0005Bn-74; Wed, 18 Mar 2026 09:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2qj1-0005Av-3p
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:14:17 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2qiz-0005JB-BK
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:14:14 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so7776395f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773839651; x=1774444451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g9m4vzrwXgC4IyCKvhO6uPEjZpgKFQVgn1JNvp/BPDY=;
 b=L7gPL0C4cRenvIuUsREhKRszQwp01zt/o6ZH39BEsOqBl73Eikj1PjXjBJV8oOdDSD
 6J7Hj4QyHOaB5jndLsXR/qeUgDunSnVZ1sy3ZmTycAJkf/x1pRM5C83fLJnEaFrOPEGw
 Q4zxIrKCM8t/Fkn2eNcGsBle/If3P6Df7OWarjldczKmxzvvGUeL5gHLPyAKKEdj7NeP
 tXopKzKHA1yNQ7Uhip73W/HfJ/r43CC1qkeY2aTeJOvSDGEX9Q7ePtqLak3OemiAesVb
 fx0SXi76v420jytH2x3f8W3e0ACA1kcSBVDIzFw6uCyNbbNHdYihLs672XYydHyb2Wzc
 JTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773839651; x=1774444451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g9m4vzrwXgC4IyCKvhO6uPEjZpgKFQVgn1JNvp/BPDY=;
 b=kBnzWJ4q5YJ2CN+mpUr1gRkn113/7qSubfM7cclVgcIgxof2rSoLuy9m/ClVUIy8m8
 QzJhl2i8Ntv9jQhvZ0OgbdUebzDarzB04IjFeU4AoDDHDThYo8QzRzux+uAxR6xzTiyw
 t2C9iZ/N1L/kXvEuMC2i2u4jeRoHYAjVUtzoNGcvpBAL2k7rTyiJEutyIvVHJfvxExU0
 23jAeLNBZlJ68Ey1A/7SdCg6zbXw7frYx8hcQYo6q+hbyx51sKBX7IeP7+kPHIoYm3+C
 ojHgEui1/9C78rWgu4zP575HcRsLYTm2pEd5orS02APlW6wrcEJ7dt2wldLi1c1fDuVX
 85VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPOsNhNShUJbtVTdlX2CD/YUMQdhCC7QIeDbWHrPV348PadGbTJn/BWPVt1QOhecXMOohOGXnAD9Zt@nongnu.org
X-Gm-Message-State: AOJu0YzPetvTIy6FtGQusAKkr/kUQH04N0hMUliq86TzrCVtKlc42+c7
 Y09nceAoCoVoDjhE756CWkNNT6syiphS8MFEcYNIYgrYzdBmHaxfdNB9rzL+CKBGZh4=
X-Gm-Gg: ATEYQzx0LYL+uJvGwedhSN2JeixGet3a6IBiU2AeknJ0PPzz+q9QdIuqjhfR6KCUDnK
 eBP/3eOJOrHylm5YY69Juw64AJtQb3RSRokGp03EjdIdJ0htzcQSiJfLVL82gWD56I8FIsTtOYF
 Ubzq8dN6vm38OCwQBqJZBJRU2kTpGB3s1FZ1HXoyGozMJvEExb+EGhCOS9wvNqbciKjg0wNrXPA
 0PHvjeqoE05wVZBvZPCKXacuV5v5ZqQprnBOh8XqVP6BIZuciMnLahPVDPWyqtrLynDr0ajfpok
 zu05IA8gzHPG7QM2+iqkZErrVEkmIdLgkUa7jBb5oDZsC3tC7rust/HhGzQUvHlfpKngt3LK1Rf
 z2TWp+lLZEzfeuv6v3ILI88b6ApTqqd7KLaiNBalszxsCg+UEKhp0IXBFZQCYT50PowQn435zYX
 znaOokzMTHOcyopb0Z3pcMHDr93B2zvbOuMN+jZGh5d260Qdyp1imzsDrz52ZywgPSvQ==
X-Received: by 2002:a05:6000:1a8d:b0:43b:4e13:2219 with SMTP id
 ffacd0b85a97d-43b527cbda6mr5667310f8f.48.1773839650715; 
 Wed, 18 Mar 2026 06:14:10 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5184b8b9sm8898089f8f.1.2026.03.18.06.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 06:14:09 -0700 (PDT)
Message-ID: <acf9c464-0fd8-41e3-8936-aa2aca346af7@linaro.org>
Date: Wed, 18 Mar 2026 14:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] target/hexagon: add build config for softmmu
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
 <20260311042019.1085030-8-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311042019.1085030-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/3/26 05:20, Brian Cain wrote:
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                                 |  1 +
>   configs/devices/hexagon-softmmu/default.mak |  7 +++++++
>   configs/targets/hexagon-softmmu.mak         |  6 ++++++
>   target/hexagon/cpu.h                        |  4 ----
>   target/Kconfig                              |  1 +
>   target/hexagon/Kconfig                      |  2 ++
>   target/hexagon/meson.build                  | 13 ++++++++++++-
>   7 files changed, 29 insertions(+), 5 deletions(-)
>   create mode 100644 configs/devices/hexagon-softmmu/default.mak
>   create mode 100644 configs/targets/hexagon-softmmu.mak
>   create mode 100644 target/hexagon/Kconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d324701ae05..d9d4cda4d0b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -253,6 +253,7 @@ F: linux-user/hexagon/
>   F: tests/tcg/hexagon/
>   F: disas/hexagon.c
>   F: configs/targets/hexagon-linux-user/default.mak
> +F: configs/devices/hexagon-softmmu/default.mak
>   F: docker/dockerfiles/debian-hexagon-cross.docker
>   F: gdb-xml/hexagon*.xml
>   F: docs/system/target-hexagon.rst
> diff --git a/configs/devices/hexagon-softmmu/default.mak b/configs/devices/hexagon-softmmu/default.mak
> new file mode 100644
> index 00000000000..08e709aea72
> --- /dev/null
> +++ b/configs/devices/hexagon-softmmu/default.mak
> @@ -0,0 +1,7 @@
> +# Default configuration for hexagon-softmmu
> +
> +# Uncomment the following lines to disable these optional devices:
> +
> +# Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_HEX_DSP=y
> +# CONFIG_L2VIC=y
> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
> new file mode 100644
> index 00000000000..42e1e5c4f83
> --- /dev/null
> +++ b/configs/targets/hexagon-softmmu.mak
> @@ -0,0 +1,6 @@
> +# Default configuration for hexagon-softmmu
> +
> +TARGET_ARCH=hexagon
> +TARGET_SUPPORTS_MTTCG=y
> +TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml
> +TARGET_LONG_BITS=32

Note, since we are trying to remove various legacy code, new system
targets must be introduced with:

TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y

Regards,

Phil.

