Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ED3CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 10:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v25Ii-0006jU-Jv; Fri, 26 Sep 2025 06:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v25Ie-0006hG-Q8
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 06:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v25IY-0005R2-Cj
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 06:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758881005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e3cKwyyXs6Em9GhSAZZYOpiNpTx6bcTHXShozRoSoRk=;
 b=fglhGTAnUXPYDADZ0JVxGPOFRkmpS8I6jncLs6Ak5QMnKTFYKJZM+rKYDpsLpqBvxne/DE
 zN4UrgZ1D44uCvSq1z99ysu9sMyVBYY3+g+dRXEGa/uHDzegFIoZVTbxLfgfzoSurADTuo
 ek4p9SzhBWzkuxfEiGbVfSCm2kFdSjk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-cIwgfl0yNYCrb3TsUcjW-Q-1; Fri, 26 Sep 2025 06:03:24 -0400
X-MC-Unique: cIwgfl0yNYCrb3TsUcjW-Q-1
X-Mimecast-MFC-AGG-ID: cIwgfl0yNYCrb3TsUcjW-Q_1758881003
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3af78819so3283445e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 03:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758881003; x=1759485803;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e3cKwyyXs6Em9GhSAZZYOpiNpTx6bcTHXShozRoSoRk=;
 b=ESl90ayuoYi9oYLVQpHC84jYMDEP3M7YeRtQQEM5x9ykMsH68sLFK4Gzez2eZyh8O4
 C34zEP/FHWm0RohiggwdVYuqzE0+NJ0OC1U47seZ65y8a+WhyTns9t8pqK6pPhIFFGS5
 p7Nk4YZWFtjY/Hs1IU9tsaG9Ss13KxqjEiis5LjOOpX2Jvrbi5Ukbq3G2oPhqh4tm9jC
 Du46SLHpV4fSPplaXz4A5Dkv/OeJeogjwLv865WHD6MMHSS3LCXpGhCRlozmGuF5arkv
 xzbBeLH8UB51+sMnss7K6BPFFOrh5f1KXxcqKP7f+Mi2ZUJyzmpTqM2Uu0fr8zpRPJxU
 MlmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW19IB5GFbgOGFbZ12RSc5+MJ1U2yloBOOVajuxCBsMc/mxUjFQMQ30WPqO2vDeO0KXCOBOU7h92zwq@nongnu.org
X-Gm-Message-State: AOJu0YwXvJZXtJI6Lt3GoGfta1qqHfQXbUoPOhHiTqJUlkeUFfAOlNKM
 xGWuIWOKVQP8SmGiiTg3eByFeaSi0jV6nDZ7iKa4IncyfiyT4518/+uAhZkWU7S29WFQXddYAU9
 hQ1aezbspIidSfktc/EhkD1XI07lg+u5GJpYxky+aDoPtlL1KWjz+Jclf
X-Gm-Gg: ASbGncuP9xPzaevcOBttVscHCQODPc2TS7+wGfWCh9c6V+EzwTLguW7bc41F+hBD/pE
 LvS9gBokpaab0AX+HPnzxBZ7ZpnsYD/BpYQWVVdF+xA+Tv51BGZlgufdlycXAM1QPpD6z+WsGkq
 2KIjpB68tmeLwqGrPG00nKtZrT0CDk2JqdRwxBIgaJ0uyY4vMrCrg4qCqqsDq2fqmUocg4JePLx
 m+nQXMl9Y+yVplEcCL8PgQzaUcOdwY+qsReXlxad1/nYvOc69ozagDnQNOipqJMw6NknytSOA9h
 Q2TMoD5GPPZRfu9GV3bz4yE4x7jbbdYGrpJ27B2nH0AfjEl8S9UM3k7Pnhe8HEEFEiQflrZe2/H
 Cc++5lg==
X-Received: by 2002:a05:600c:64c4:b0:46e:36f2:2a62 with SMTP id
 5b1f17b1804b1-46e36f22d9fmr43265105e9.27.1758881002815; 
 Fri, 26 Sep 2025 03:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi1WrBRJ7UKos0b0CukCR3FQ9WjSnwWzhMMpTZyakspFOmWNBg6a+9oqaRvltw9D7kd/BFKA==
X-Received: by 2002:a05:600c:64c4:b0:46e:36f2:2a62 with SMTP id
 5b1f17b1804b1-46e36f22d9fmr43264805e9.27.1758881002408; 
 Fri, 26 Sep 2025 03:03:22 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab48b40sm109779765e9.19.2025.09.26.03.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 03:03:22 -0700 (PDT)
Message-ID: <a9118adc-f9ac-4df0-8e60-4407945a5908@redhat.com>
Date: Fri, 26 Sep 2025 12:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] tests/functional: Provide GDB to the functional
 tests
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-4-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250926051542.104432-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/09/2025 07.15, Gustavo Romero wrote:
> The probe of GDB is done in 'configure' and the full path is passed to
> meson.build via the -Dgdb=option.
> 
> Because a single functional test can cover different arches, such as
> aarch64, ppc64, and x86_64, only a GDB that supports all the arches in
> the target list is passed to Meson for use in the functional tests. To
> handle this check, a new shell function, is_target_arch_in_arch_list, is
> introduced in 'configure'.
> 
> Meson then can pass the location of GDB to the test via an environment
> variable: QEMU_TEST_GDB.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   configure                     | 21 +++++++++++++++++++++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  2 ++
>   tests/functional/meson.build  |  6 ++++++
>   4 files changed, 31 insertions(+)
> 
> diff --git a/configure b/configure
> index 0f7eb95586..20e05d233f 100755
> --- a/configure
> +++ b/configure
> @@ -1142,12 +1142,31 @@ fi
>   #########################################
>   # gdb test
>   
> +# Check if all target arches are in a provided list of arches.
> +is_target_arch_in_arch_list() {
> +    arch_list=$1
> +    for target in $target_list; do
> +        arch=${target%%-*}
> +        if test "${arch_list#*$arch}" = "$arch_list"; then
> +            # Target arch not in arch list
> +            return 1
> +        fi
> +    done
> +    return 0
> +}
> +
>   if test -n "$gdb_bin"; then
>       gdb_version_string=$($gdb_bin --version | head -n 1)
>       # Extract last field in the version string
>       gdb_version=${gdb_version_string##* }
>       if version_ge $gdb_version 9.1; then
>           gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
> +
> +	if is_target_arch_in_arch_list "$gdb_arches"; then

No TABs, please!

> +            gdb_multiarch="yes"
> +        else
> +            gdb_multiarch=""
> +	fi

This unfortunately does not work with the GDB from Fedora - it only supports 
"arch64_be arm riscv64 riscv32 ppc i386 s390x ppc64 aarch64 ppc64le x86_64", 
but if you configured a target like "alpha-softmmu", this breaks.
(BTW, does the gdb-multiarch from Debian/Ubuntu really also support exotic 
QEMU targets like tricore?)

I think it would be better to drop this hunk, and rather check in the spot 
where we use GDB if the required target is really there (i.e. in the 
functional test that uses it).

  Thomas


