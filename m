Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD26ECAC5BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3bpS-0004p6-6n; Tue, 30 Sep 2025 10:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3bpQ-0004oh-QV
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3bpK-0004pa-A1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759244376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=COvh3/RdYN3KGRtb7nDzXlzK/XoTNPRrpmHpM5JkCDs=;
 b=FnXYCBscoAzd4N4849SarDGlQI+YNZcwwCHfiqaBTjPo8iai5ZQrkEIWwrttucbIqO4Cdk
 l7ZdFlBWotTIqHrC5WvMgztzs96mRgZ6TTTGcJSEeh7jYCvWMIDvKcecgdUMrotAOtIlH7
 1Rad+ooz8PCXeQW87PNJ+29UFFO8UfE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-JDX-PDTXMPSy28SzaQDOnQ-1; Tue, 30 Sep 2025 10:59:28 -0400
X-MC-Unique: JDX-PDTXMPSy28SzaQDOnQ-1
X-Mimecast-MFC-AGG-ID: JDX-PDTXMPSy28SzaQDOnQ_1759244367
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b07c2924d53so535224466b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 07:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759244366; x=1759849166;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=COvh3/RdYN3KGRtb7nDzXlzK/XoTNPRrpmHpM5JkCDs=;
 b=Ssf8eJKSCWJcQz/yI5f4CnztDqjD5RuEw8xB3zAR+EKVQLMqs1HYR3y6q437kKQlxT
 BDHe3b5UJ0mqcLdMtNL8OKKTEx3f/o64SRLi9W7GmwM1OtnfY2zpGJ7GTtepNJ9W2W5z
 8hUZybiF37i2HhIPCzBqoUM1su3G12dcEDuLHYRu1SMs6JJqp5au5h528K+hzyUhThwv
 xJrwLwCSy7cl6t873mpr6p0bUzeIMglXgC9eDbmTR8uNLL4wKK2HqNjBl9fT/Q2O9bfN
 Ye2ROu3J2HBq/K28Nt08vKMOIhi8MMrtudXDYEsq+fOLL+6l4ndbVuKUtBH3AruQ3RBQ
 1vPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLUxopF/Sj8ZnNMHX7M/FxovcEPq63rD0dt2zhCIqBbfZ7Ij9Mt0pLxv4eeONK3BagxLdRyuDCDKpi@nongnu.org
X-Gm-Message-State: AOJu0Yzg/gyo3Ut4Hpu307BTEHA+eiRvW9LOfd30QxxJNhZ0s0aIsIS5
 myUeY0UKeCO5g2qZhWPXb5+Tm3U7NvcHVF4iTUe+3Aq1qxAf0Lx0auq2Ua1fNNKlgsOErIHQRDs
 kTYjCvNgKIW42w7M6S4OaGirhKk2KCw8ZCtLCV6oYEGa/sBhEGxRUzq+Scwnzz1sr
X-Gm-Gg: ASbGncsCBTMeeg8cbm54ySqpbOPGFHMkS4whZqWTOaF7rhkObGx+QgHxHpqrar+3odj
 wIYVmhGILyuF2SEfCdC+/hgo1nXa6oGAOeC6sMCaCCKJ5eEZoiNJ7Kg1CiMgHKu8Q4wJKh6Oe9b
 i5Tzevu+Rd9DvZaPxcQ/eJmzWjWZI/GhXbh7rk/pXNvn7WwT9ydlaMv0m8XV0dPD4nIkqx5HGKm
 84i3wRLm1tMPIPGh/LIJWUt1V7DDNH5VYM9LUiMXUH2XptDrJwJei9vmXJRZNzs/eedD7TCVrGk
 Ia2Colas0pqpL+5j2jWXuvFChK3rIT6UofdEcB+xs23eotmOecOiHe6IJJxquXg1g0mlf/53qln
 +9QKqfMWL212SE13n0aDEaz41WCfS2aQFtlznPZ9U7F61/nFCuw0=
X-Received: by 2002:a17:907:980b:b0:b40:6e13:1a7f with SMTP id
 a640c23a62f3a-b406e131b70mr727494166b.27.1759244366638; 
 Tue, 30 Sep 2025 07:59:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqH8Crt4pdWyr7i0JDz7DfER45AYlRhv0SX7Znh3FS/u+oMO2t3sMY5/1brsJTaGh6men2yw==
X-Received: by 2002:a17:907:980b:b0:b40:6e13:1a7f with SMTP id
 a640c23a62f3a-b406e131b70mr727490266b.27.1759244366167; 
 Tue, 30 Sep 2025 07:59:26 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b40d70daf36sm296673166b.81.2025.09.30.07.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 07:59:25 -0700 (PDT)
Message-ID: <bc7c8163-4c6d-4690-a0f1-4e00b35a5ec0@redhat.com>
Date: Tue, 30 Sep 2025 16:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/27] configure: set the bindgen cross target
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-8-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250924120426.2158655-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/24/25 14:04, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Implement a bash version of rust-bindgen rust_to_clang_target() to
> convert from rust target to clang target.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>   configure                            |  7 ++++
>   scripts/rust-to-clang-target-test.sh | 43 +++++++++++++++++++
>   scripts/rust-to-clang-target.sh      | 62 ++++++++++++++++++++++++++++
>   3 files changed, 112 insertions(+)
>   create mode 100755 scripts/rust-to-clang-target-test.sh
>   create mode 100644 scripts/rust-to-clang-target.sh
> 
> diff --git a/configure b/configure
> index 66613f3f4c..bf964947b8 100755
> --- a/configure
> +++ b/configure
> @@ -1878,6 +1878,13 @@ if test "$skip_meson" = no; then
>         eval "c=\$devices_${a}"
>         echo "${a}-softmmu = '$c'" >> $cross
>     done
> +  if test "$rust" != disabled; then
> +      if test "$cross_compile" = "yes"; then
> +          . "$source_path/scripts/rust-to-clang-target.sh"
> +          clang_target=$(rust_to_clang_target "$rust_target_triple")
> +          echo "bindgen_clang_arguments = [$(meson_quote --target="$clang_target")]" >> $cross
> +      fi
> +  fi
>   
>     echo "[built-in options]" >> $cross
>     echo "c_args = [$(meson_quote $CFLAGS $EXTRA_CFLAGS)]" >> $cross
> diff --git a/scripts/rust-to-clang-target-test.sh b/scripts/rust-to-clang-target-test.sh
> new file mode 100755
> index 0000000000..ff6f8fcdc5
> --- /dev/null
> +++ b/scripts/rust-to-clang-target-test.sh
> @@ -0,0 +1,43 @@
> +#!/usr/bin/env sh
> +#
> +# Copyright (C) 2025 Red Hat, Inc.
> +#
> +# Based on rust_to_clang_target() tests from rust-bindgen.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +scripts_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
> +. "$scripts_dir/rust-to-clang-target.sh"
> +
> +test_case() {
> +    input="$1"
> +    expected="$2"
> +    result=$(rust_to_clang_target "$input")
> +
> +    if [ "$result" = "$expected" ]; then
> +        echo " OK: '$input' -> '$result'"
> +    else
> +        echo " FAILED: '$input'"
> +        echo "  Expected: '$expected'"
> +        echo "  Got:      '$result'"
> +        exit 1
> +    fi
> +}
> +
> +echo "Running tests..."
> +
> +test_case "aarch64-apple-ios" "arm64-apple-ios"
> +test_case "riscv64gc-unknown-linux-gnu" "riscv64-unknown-linux-gnu"
> +test_case "riscv64imac-unknown-none-elf" "riscv64-unknown-none-elf"
> +test_case "riscv32imc-unknown-none-elf" "riscv32-unknown-none-elf"
> +test_case "riscv32imac-unknown-none-elf" "riscv32-unknown-none-elf"
> +test_case "riscv32imafc-unknown-none-elf" "riscv32-unknown-none-elf"
> +test_case "riscv32i-unknown-none-elf" "riscv32-unknown-none-elf"
> +test_case "riscv32imc-esp-espidf" "riscv32-esp-elf"
> +test_case "xtensa-esp32-espidf" "xtensa-esp32-elf"
> +test_case "aarch64-apple-ios-sim" "arm64-apple-ios-simulator"
> +test_case "aarch64-apple-tvos-sim" "arm64-apple-tvos-simulator"
> +test_case "aarch64-apple-watchos-sim" "arm64-apple-watchos-simulator"
> +
> +echo ""
> +echo "All tests passed!"
> diff --git a/scripts/rust-to-clang-target.sh b/scripts/rust-to-clang-target.sh
> new file mode 100644
> index 0000000000..5451807888
> --- /dev/null
> +++ b/scripts/rust-to-clang-target.sh
> @@ -0,0 +1,62 @@
> +#!/usr/bin/env sh
> +#
> +# Copyright (C) 2025 Red Hat, Inc.
> +#
> +# Based on rust_to_clang_target() from rust-bindgen.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +rust_to_clang_target() {
> +    rust_target="$1"
> +
> +    # Split the string by hyphens
> +    triple_parts=""
> +    old_IFS="$IFS"
> +    IFS='-'
> +    for part in $rust_target; do
> +        triple_parts="$triple_parts $part"
> +    done
> +    IFS="$old_IFS"
> +    set -- $triple_parts
> +
> +    # RISC-V
> +    case "$1" in
> +        riscv32*)
> +            set -- "riscv32" "${2}" "${3}" "${4}"
> +            ;;
> +        riscv64*)
> +            set -- "riscv64" "${2}" "${3}" "${4}"
> +            ;;
> +    esac
> +
> +    # Apple
> +    if [ "$2" = "apple" ]; then
> +        if [ "$1" = "aarch64" ]; then
> +            set -- "arm64" "${2}" "${3}" "${4}"
> +        fi
> +        if [ "$4" = "sim" ]; then
> +            set -- "${1}" "${2}" "${3}" "simulator"
> +        fi
> +    fi
> +
> +    # ESP-IDF
> +    if [ "$3" = "espidf" ]; then
> +        set -- "${1}" "${2}" "elf" "${4}"
> +    fi
> +
> +    # Reassemble the string
> +    new_triple=""
> +    first=1
> +    for part in "$@"; do
> +        if [ -n "$part" ]; then
> +            if [ "$first" -eq 1 ]; then
> +                new_triple="$part"
> +                first=0
> +            else
> +                new_triple="$new_triple-$part"
> +            fi
> +        fi
> +    done
> +
> +    echo "$new_triple"
> +}


