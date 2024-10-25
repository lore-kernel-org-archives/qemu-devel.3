Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B7BD149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 18:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4PPP-00038m-US; Fri, 25 Oct 2024 14:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4PPN-00038V-69
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:51:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4PPI-0000TN-VW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:51:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e67d12d04so1757325b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729882290; x=1730487090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=niTAzSYvjIXiaYdZc8wIVbqCHQVeJdxusNu8GvZOJSU=;
 b=t58ZAKn88nOdlu2MjDCHvt1DfuhUtv9fERh4k2tsw6a3lr3gt23clKNq44LAdKFzs+
 zqaOStAyBQLIf9GIWNa5sdpFsX3zMZVg5/v/OtEBAHvCB8mGC8a9768Zbplw/i6AzeQd
 7bYf7PT4yfwMKCPzDDHQZ8b/g7THjx+KBZzZZ7lg0NSiWju+jJF9JsOG3+LpKN7ikGqG
 k2igdk87qZzA4pezoiNHJsJ8OYHU5kTT6qy4tuZlaqewpDunqXFBscbfo6SSrxQqZBqG
 /3SiGOc9DzFGYEVHw9Cw4vY+sACfkmuWMi4ICt+DPPxE2KdKuytf6C4SyhyXBUMWsvB4
 BlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729882290; x=1730487090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=niTAzSYvjIXiaYdZc8wIVbqCHQVeJdxusNu8GvZOJSU=;
 b=Plf9ULQkBuOisL4wekNQ6OX7zakFeBOvY+77xGDHgOOqIzPSvEWgd3HsPM7sV2WwB8
 Amap5ez4YioeHLLtGdtucb0rY9nTTAk+Y7mOdhVV9HuHQHiiZvBK+tox5//XdzpchObI
 Kxg59i1Zxh93ei4A1vJWf+R/RXCAkvOlTJdIMUqjv1XBsAf9D0RxflAto9bHKRnKDa7Y
 tRv9WqWa7vYWnylSYYcBCfRiuKpmE5dhRWIjSmlDbb/+SokSkQr492nayY5+VYneo51X
 aDHPYQEtm23FFUGdKLUgZNYeYYguHXKTXpFvAk3VHc6jxMYvbERkOIDsEHa1m/ydclei
 WufQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjBeeyRkSd9Rr5BqPYNYBQiiWqqOgcqOJGiEGKcU64Oo2MVldHibCRWDL4rk/8ObgHXEyqfesUiuse@nongnu.org
X-Gm-Message-State: AOJu0YxzdXJeM0OCY0JIkwCqH41oyJRzNnFam2Xe4iHAviPhrDAuJqhG
 Onyu+K/dnISNDs0sxgi5EGGJJHr7zUw9fqVRJxf3AArYMe0S4usq4SfmhDOYcds=
X-Google-Smtp-Source: AGHT+IHiqHmtTUer3atTgjh8ZuJpPL+Biw07tqwwN2mwb1qOWdGGsi7hpYbjGPb8jSGIKDdB2EluGQ==
X-Received: by 2002:a05:6a00:1890:b0:71e:6a57:7290 with SMTP id
 d2e1a72fcca58-72062bdeaabmr807318b3a.0.1729882289850; 
 Fri, 25 Oct 2024 11:51:29 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057920364sm1390471b3a.5.2024.10.25.11.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 11:51:29 -0700 (PDT)
Message-ID: <580f10bc-4d37-4ece-b9d8-496ba66b7966@linaro.org>
Date: Fri, 25 Oct 2024 11:51:28 -0700
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Hi Paolo,

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

Should we install the same version as the minimal one we expect (0.60, 
in debian 12)?

All the rest of series is focused on having fixed minimal version, and 
this patch seems to escape this rule.
Note: we can still install it using cargo, but just having a fixed 
version would be better.

