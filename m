Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D780CC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3Pf-00087Q-Pl; Wed, 29 Jan 2025 03:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1td3Pd-00087A-Ub
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:27:05 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1td3Pc-00056D-EE
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:27:05 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso68626995e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 00:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738139220; x=1738744020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AHZiF47NWWjd2AYAWKEbCROUr9QzBMOCZsoHUD8kiic=;
 b=iDYVDkLJ83OeZDxHDeVPjn8Ob6bmUSHDHDQDl+EKI+cjn9OBrsMbBi/Lw5iqjLcdpW
 a/SN3vjDu/Pd4Zxg3D/F8mJEy0v9rKG3CjrSfQLcnwOw1yXBwv7iI2BXY5i4cXM05aUw
 sNbxnKkvVo2XQz7B0lZLQH97h3DhgPU+xxXghins5b/KqQXLDrKzS2JJzVaOIJ26b9/v
 7QHjtHIloS81dwSPpApwGoj/dl/6QRg23PI7uLiwyl1WwpHj9B4786pRPzCOXTKO3VPG
 b6RoqAJOfWIqaObCqyjP28+zEv5MHPyrxGI48qcOog8AuanJPFw2oK87+QmZO0Xf246p
 dIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738139220; x=1738744020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AHZiF47NWWjd2AYAWKEbCROUr9QzBMOCZsoHUD8kiic=;
 b=tgtCoRVAPes6j09ntfIIlP7plYu4jFrWyQKsK1oJ5HY6ChPNG8TyGLwIvqT/jFf2jz
 JL/KBblIbDkCNi5vjCBLL4divWEkbW68f3ee9meAqNAsxuZSHvQ8oGi7pJZYGp1RVGNj
 4T0GRCY2mqBLdykK3yGxFbV2LyKrWTphXUydYoG9+qZYxyMV7XuTiyRDB9qjDBkOC49T
 ggQ8E2jZTsy8X+zh5bYcuvXGG1gVDnAAZBuofP1SZxurIhRq3vlZg928qhdy2dO6MoW6
 kFq8bsxUPyqY9lowA7NrV5G9qAW4jU+nGLybxkgdoeM6eG9YGSeZlgeAxMqtRU5DSok8
 IiJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMdPhcoui4AfpP++AOwPHcIm9ORC24s0u794C9yCxHkvgANRDJGIcon6BoJp0YtB/ltEEShVTvH1hG@nongnu.org
X-Gm-Message-State: AOJu0YzvoQHkdew9pGoM5Rmfpx3I2XD2isvr3EAGSlUfIxz63x/hlraO
 Win5nc4QQIwm0iz49gDaB8LI1ggOUI6RrQ0TvMxJ8w8l9ntQdWU4Q05ltr7hOCg=
X-Gm-Gg: ASbGncunm3TVw9oiwu3IQ5N3AnU5NEhg73UdaHljtKtjiXhjvdYjDOFKTvYfl4ZRSi/
 4+ZN15lTAFHphID5YSHDRjXNwSw7NwlkObz6RQekd6+nyFGojNMJfJV2aJLF6SjrvZzyWnajTIi
 P1dpTbE4uDUYz4j7m/FBjyPiev/7WSioHVHB25TtQTcpaLN0o0OkIpLMWDpDYAfTZGhF3wKtV6S
 MEuT0FbuKf0ZNBYE6jtvIP4EE5jO3V0zkQqyWkfbcf7nqkMLT+Afe384CYA4DaZCqDKZyAbfUZy
 KlypORVkiIvqUSYnQR0tTye+gA8wSC3jVxih7gtXAI2VGyfYpfD5TU9hg58=
X-Google-Smtp-Source: AGHT+IEqSd/3rz5Y5ORNplSWaBL8eAnVT8r6p3lyhI5cOv8lRtUUgyZW149RH7IvKocqdgMyJ9Rjsw==
X-Received: by 2002:a05:6000:400e:b0:38a:3732:444d with SMTP id
 ffacd0b85a97d-38c5195c27dmr1733276f8f.23.1738139219814; 
 Wed, 29 Jan 2025 00:26:59 -0800 (PST)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2e3a6sm14299365e9.20.2025.01.29.00.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 00:26:59 -0800 (PST)
Message-ID: <22ef753c-60d8-4e21-8317-e64b6d81ff5e@linaro.org>
Date: Wed, 29 Jan 2025 09:26:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: include full Rust backtraces in test runs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-rust@nongnu.org
References: <20250129082045.1319203-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129082045.1319203-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29/1/25 09:20, Paolo Bonzini wrote:

Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   .gitlab-ci.d/buildtest-template.yml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> index 39da7698b09..4cc19239319 100644
> --- a/.gitlab-ci.d/buildtest-template.yml
> +++ b/.gitlab-ci.d/buildtest-template.yml
> @@ -63,6 +63,7 @@
>     stage: test
>     image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
>     script:
> +    - export RUST_BACKTRACE=1
>       - source scripts/ci/gitlab-ci-section
>       - section_start buildenv "Setting up to run tests"
>       - scripts/git-submodule.sh update roms/SLOF


