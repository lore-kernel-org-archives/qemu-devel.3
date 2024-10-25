Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B61D149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 20:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Qc5-0001BS-4N; Fri, 25 Oct 2024 16:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4Qc3-0001Am-Jk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:08:47 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4Qc1-00011w-WC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:08:47 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2a999b287so1931965a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729886924; x=1730491724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tIr5tyC/tEi/tu0Auz/rckjJ59RWPuoXvmPPpIdmFAk=;
 b=oakEYKNs7TRNPx68i5FFeZYaH9+AqQ98iDObLs0u+VUgoJaYcZD/SFEn3if7kdJraa
 JzB+9txDgepRblWuVTBAESXilyyCFVUVsQylKnPn5QHRjXqQziW3UCrDafMtw8JYIqXr
 MXko7veFNvazo9Ps9p3uS7IFv7AJE+fcrCy2sqojiChnunm8nStqWrEbeL/UvX2dbA54
 mW6rNi6UTYr0iyndjlEdECrghlUKisVpZsyDXpgx+bM17P5D1Eq8xh1E5OnDP5ozmgpm
 E71sIpyK0viGvdpYx9npavL7Zk4Z7njzT6fHSTCwVufnvPOEAY2nCG1m0bTrhqjHLdal
 UUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729886924; x=1730491724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tIr5tyC/tEi/tu0Auz/rckjJ59RWPuoXvmPPpIdmFAk=;
 b=xNpEJrmhPCF5f1swYTYQCLObUf1mEquQ4QYCXY0X5tJKeGyx3Ep9/wVwS5CoZF/RN2
 mNvwTCnbmF0/lAix6RCKQw4xWD5RU8YpZgRE4n/5BUd6aRyIZZ/wtTewwRJ/zxbiGwPE
 TDZZxyHDCfHzPTGHW2DbAJjp8i5EIZ/Hy4cxtqRCmGpGwHZmwYjCGdNyN1VWA9ihw3BE
 n9dSenNz4geIXXpfzGL4D/xqXyOez38Ztg+RqoTmg/1R47O8xabJmDBLPmMD5Vl+CgoZ
 OsVrwl4SgzncMZbomv7DLsrM0Qyf5xAjd2Hn2XWdVI+/jbLsb5T6gDmJMxHvPR9f9dL4
 Hf2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK1X/cu9vtAGEk6a4eDOJcTp9WzH47PFJX3oetO3KULYgABfYE9K7tK/UnlTHrdw84l7NBfFbETyks@nongnu.org
X-Gm-Message-State: AOJu0YyH1jsYnTRi3znet6NdWwcOOsjzXnVesHhgHq1m3+0mEAR3Ri1S
 IG0Gy15MSeL0YPom9o8sHLfUfH/CmJwZRnkfJfb1RpxsUlA7GV8E6xfAwAPWNAU=
X-Google-Smtp-Source: AGHT+IEu0ZnkxU+RnbYShLjikrQ48DgisbOuoYcgCw0lemGg3HBQURzr+4sCkk6nEc/R9yrs/IXSbA==
X-Received: by 2002:a17:90a:e20d:b0:2e2:ddfa:24d5 with SMTP id
 98e67ed59e1d1-2e8f105e9bbmr622470a91.15.1729886924457; 
 Fri, 25 Oct 2024 13:08:44 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e8e3555c28sm1929713a91.6.2024.10.25.13.08.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 13:08:44 -0700 (PDT)
Message-ID: <f94e005f-ffb9-486c-9151-7e98b0211429@linaro.org>
Date: Fri, 25 Oct 2024 13:08:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/23] dockerfiles: install bindgen from cargo on Ubuntu
 22.04
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-23-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241025160209.194307-23-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 10/25/24 09:02, Paolo Bonzini wrote:
> Because Ubuntu 22.04 has a very old version of bindgen, that
> does not have the important option --allowlist-file, it will
> not be able to use --enable-rust out of the box.  Instead,
> install the latest version of bindgen-cli via "cargo install"
> in the container, following QEMU's own documentation.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/docker/dockerfiles/ubuntu2204.docker |  5 +++++
>   tests/lcitool/mappings.yml                 |  4 ++++
>   tests/lcitool/refresh                      | 11 ++++++++++-
>   3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
> index ce3aa39d4f3..245ac879622 100644
> --- a/tests/docker/dockerfiles/ubuntu2204.docker
> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
> @@ -149,6 +149,11 @@ ENV LANG "en_US.UTF-8"
>   ENV MAKE "/usr/bin/make"
>   ENV NINJA "/usr/bin/ninja"
>   ENV PYTHON "/usr/bin/python3"
> +ENV CARGO_HOME=/usr/local/cargo
> +ENV PATH=$CARGO_HOME/bin:$PATH
> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +  apt install -y --no-install-recommends cargo
> +RUN cargo install bindgen-cli
>   # As a final step configure the user (if env is defined)
>   ARG USER
>   ARG UID
> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> index 9c5ac87c1c2..c90b23a00f1 100644
> --- a/tests/lcitool/mappings.yml
> +++ b/tests/lcitool/mappings.yml
> @@ -1,4 +1,8 @@
>   mappings:
> +  # Too old on Ubuntu 22.04; we install it from cargo instead
> +  bindgen:
> +    Ubuntu2204:
> +
>     flake8:
>       OpenSUSELeap15:
>   
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 0f16f4d525c..a46cbbdca41 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -137,6 +137,14 @@ fedora_rustup_nightly_extras = [
>       'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
>   ]
>   
> +ubuntu2204_bindgen_extras = [
> +    "ENV CARGO_HOME=/usr/local/cargo\n",
> +    'ENV PATH=$CARGO_HOME/bin:$PATH\n',
> +    "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
> +    "  apt install -y --no-install-recommends cargo\n",
> +    'RUN cargo install bindgen-cli\n',
> +]
> +
>   def cross_build(prefix, targets):
>       conf = "ENV QEMU_CONFIGURE_OPTS --cross-prefix=%s\n" % (prefix)
>       targets = "ENV DEF_TARGET_LIST %s\n" % (targets)
> @@ -157,7 +165,8 @@ try:
>                           trailer="".join(debian12_extras))
>       generate_dockerfile("fedora", "fedora-40")
>       generate_dockerfile("opensuse-leap", "opensuse-leap-15")
> -    generate_dockerfile("ubuntu2204", "ubuntu-2204")
> +    generate_dockerfile("ubuntu2204", "ubuntu-2204",
> +                        trailer="".join(ubuntu2204_bindgen_extras))
>   
>       #
>       # Non-fatal Rust-enabled build

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

