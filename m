Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D96DC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqhd-0002Sw-LY; Mon, 04 Aug 2025 04:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqhQ-0002Lt-Ar
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:37:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqhO-00018T-Fu
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:37:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45896cf24ebso30316815e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296657; x=1754901457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p7KuKOTxeMkRtqtEJ90DbuUgdfDAM7VBU8xvXwSJI2E=;
 b=X2oaBdY5q7ngoPgxZhTW+Oy9kBp92RF+NdGvRzSpxk14nKZQ6X5gSFkGEBiByPlKoi
 c9m6w+MiYC3QIaLCYbvr6PTxv8+DBMYx21Imamnm3pCX6J3vcs+4vjOqrxaYYLtJk8jm
 wfBJMc9mh9+DYiZPNGufoWHh0FDpGQZ/ldnwO6pv6pWkNaYaQpax/vpqORAIy7omXQBW
 MkTzPBsDEXyONycIVWx492329v8qBVsHrHjR7ajFg3Tu6Yw6MXOFLhYUMDBcYLqObrAW
 IZyxbI6H6CnxKQn2v8sH6gssYo+UkGKfsGZdVXCrC37AD3v2HWTBYoXukI3dcqBA7RoE
 Ee3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296657; x=1754901457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7KuKOTxeMkRtqtEJ90DbuUgdfDAM7VBU8xvXwSJI2E=;
 b=HPwpfFqNj9/SLrXEavE5n6r5AGCuSDxY6QM1kuuTxr2qnBFzuo8vEGBlzC2GEVCgEs
 IIaWyqVawZLLO9jGy7DJsWd+j1HGi+DPR2wuV7tSS5JDcKfQCUEnWIVR008xGgyXwDS2
 dK8GTlzS8zptgIW23WLtkeqx88uKT4QCPQEfsSO7ZZXCz5w1OKmnDCixLvwlTBTY5g8C
 jlgbSkwj2E7uBGfpqsS3a5zOHayecH+7CiJJy6stNZjUWNQ6QAByoN8EO1sKkk0Cfpwe
 ksy5ofaN+VYaxt0vplCCXPmjy3Xag36noMb7X6GME0ZQQlNyeXOeNRiWVSZEnIVQZLpj
 4myA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcDGuG1reXQEJCzkMP+XuhLdTtWFK74qAp6dmmd+jO2NAr7nHFWMRPgQeTkmQcjmMzXKpYmdSHJd9g@nongnu.org
X-Gm-Message-State: AOJu0Yw3MloQ1uCcDu+IH4RyH6clLeddeLDSFdhhA3wUQ5fD3cZudtl2
 y8ZVjtONtlWksEnkJn2XRWxsjRps3QA/1NF30AtQhO7X7um73MzX8fh8BngOIe0CpoQ=
X-Gm-Gg: ASbGncuj9pG0Og++O/BzUvyKwZaGLloOnozOX7kl7n/zIAhA/WWuTwU404Rz1gxnMxJ
 PtYNbUCjT3sJju+n1qgH7KixsABGvivPMlFux+fIG58kpMLSww9RajLNzILl7lO6ZU4UO97GCC1
 nFnL3wHaK/dJ3QDVpwPsDQQOnJ+Yygm4UfqgjnFmVxhTvl4PhxU6T71SaM8d29Ek0ur1iuh7nVx
 wDxIfM2rm2iSrwp1QLZ8LaAb9/n63+TxT0gLKanJ40WiZQxepyvO0Vy2xLau1yZ9r3Hsv/J51gE
 ZGsC0QMRwok1HCqjEE0ld4S2n+bmfWUU25Z81dhP3X/CDeDeR5Vx8LPBTL7h5t1Hd4yTiWtaYRZ
 WavWMc+5kiHwo2GD6zXzr9FyWsh3ZLGJPxtOJcndObOrhAPAf+L0y736NmKAVtqnfTRUPQTE=
X-Google-Smtp-Source: AGHT+IEpOc4GbgerwOJ7/YLCFmInpKzGoy7c8E13oepRc8CwUXJK47+grO/CuzhXJAkVX+JtcYZzgA==
X-Received: by 2002:a05:600c:3113:b0:456:1560:7c63 with SMTP id
 5b1f17b1804b1-458b69f2387mr65300665e9.3.1754296656862; 
 Mon, 04 Aug 2025 01:37:36 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee57c18sm158408315e9.28.2025.08.04.01.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:37:36 -0700 (PDT)
Message-ID: <f801e57b-e042-4572-bf4b-ba4788a674d0@linaro.org>
Date: Mon, 4 Aug 2025 10:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] tests/functional: Move riscv32/riscv64 tests into
 target-specific folders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-18-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-18-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The opensbi test is used for both, riscv32 and riscv64. Copy the main
> test to the riscv64 folder and add a simple wrapper to the riscv32
> folder to be able to run it for that target, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  3 ++-
>   tests/functional/meson.build                  | 24 ++-----------------
>   tests/functional/riscv32/meson.build          | 10 ++++++++
>   .../test_migration.py}                        |  0
>   tests/functional/riscv32/test_opensbi.py      | 10 ++++++++
>   .../test_tuxrun.py}                           |  0
>   tests/functional/riscv64/meson.build          | 14 +++++++++++
>   .../test_migration.py}                        |  0
>   .../test_opensbi.py}                          |  0
>   .../test_tuxrun.py}                           |  0
>   10 files changed, 38 insertions(+), 23 deletions(-)
>   create mode 100644 tests/functional/riscv32/meson.build
>   rename tests/functional/{test_riscv32_migration.py => riscv32/test_migration.py} (100%)
>   create mode 100755 tests/functional/riscv32/test_opensbi.py
>   rename tests/functional/{test_riscv32_tuxrun.py => riscv32/test_tuxrun.py} (100%)
>   create mode 100644 tests/functional/riscv64/meson.build
>   rename tests/functional/{test_riscv64_migration.py => riscv64/test_migration.py} (100%)
>   rename tests/functional/{test_riscv_opensbi.py => riscv64/test_opensbi.py} (100%)
>   rename tests/functional/{test_riscv64_tuxrun.py => riscv64/test_tuxrun.py} (100%)


> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index cc0e0bc6e0c..2d8f67fd94f 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -26,10 +26,8 @@ subdir('mips64el')
>   subdir('or1k')
>   subdir('ppc')
>   subdir('ppc64')
> -
> -test_riscv64_timeouts = {
> -  'riscv64_tuxrun' : 120,
> -}
> +subdir('riscv32')
> +subdir('riscv64')

Here again I'd merge in a single 'riscv/' directory. Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


