Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A72CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 14:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3boF-0004Ww-Ux; Tue, 30 Sep 2025 10:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3bo9-0004W5-PY
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3bo2-0004WS-3P
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 10:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759244290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FZs0h6AYVzq9vcCTOk5dqb/669DE7XtOFxnqYTO6g4Y=;
 b=GQjDGv2CIxQbShKomw1hXLNeI5IGpA+4S0X3axe9gjfiip0WzxfA8V4samrnaeOXHC8i3N
 UbxUyrnIl4TCgSIuKi+yuZrjOs9cD8MYoNRAAWmm9kCBS9fEVa242ALE/CSGp9eyl7a/Dz
 KYvCVlbGa0pb14tQ2ZDb40+sc/e9rEQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-xIm0qQ79NI-dW7yWv4oYHA-1; Tue, 30 Sep 2025 10:58:08 -0400
X-MC-Unique: xIm0qQ79NI-dW7yWv4oYHA-1
X-Mimecast-MFC-AGG-ID: xIm0qQ79NI-dW7yWv4oYHA_1759244288
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3cb0f2b217so365446866b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 07:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759244287; x=1759849087;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FZs0h6AYVzq9vcCTOk5dqb/669DE7XtOFxnqYTO6g4Y=;
 b=juzXVrL5qgsprMjuddStAaVgH/sVD2/7d2YNk3QM1jYoSpsrOHtNeicJwnmt+zKf2s
 JJjMAzuxMXT8pdSHGn7tTLr6iXD3xUWQyQrQikShkXg8eftIFD15qhYqf0Y4yJSzyhZh
 sOoMBqhHnS2OOwo77f0oDAg13APlKvVAiq8tSfkpuedgbiYu75r/h3AKZmc2iGRDb8gx
 jLYoOm3LY461JLCgqkYdkikA9u45pMauvgHyhAKO50tBjBvdxPwDHt4YkTMwK6QIJjmd
 4kNlvf/CpB7QFG0UfKxIJr1/xRONsSFZF64Q/UvPPfB+MIuQU5VKMN74ZTB78GLYXCP9
 yG6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGFJI0CmA480fB4twxpttc14m7Zq+Cmjh02N+qwbcguN2g5/JpDPVHabfrxurR7PiBY4GSkrmKbkvd@nongnu.org
X-Gm-Message-State: AOJu0Yx+znY+K329eoVEK+pE/FlxeK9t5ehoHechYNG0H+nZYIe6SA0+
 y/upFS8+zHB1WgZmI6vwf7SHcLLLhz3a79lyGHcQZBdf4rlspODq3d1XHUbISszGZ7BaLRieX8z
 dSg2RzrBBadXMFcI6yPJbkI2r3Oa8sWaCWD6aGHqPCa99qyx3lArSAoXR
X-Gm-Gg: ASbGncvPOBlpYgEvn9dBm/bLLQN98eN/HRBwbpOZM6AV5rtCV+I4TD5+whQVXNIXWea
 Kdz3r6WNQrsM1nIzhiqT1StWI11395JJPVEuu3MIR6m/b5OVZ5dHBSrQdmpgO6OId2cvEeBK5vf
 izr7BSzHGgYXAkw01deVob0FCcM7d7gTgOzq6OUbtcW46wSnEqqnkOf7DXcysUWtcXra0ad0Rlx
 UALlXOm5EmMjZSZWrs9xKItIMYFFC4eIn30QxFDw4hoq0+c/i7ZkxZ9oAllkDqlLUR/77GVDulL
 IYiC6RJEHEvP2W83h/zh/zV2kaoQIespKRGD7QjxZgKXd5DcYns6Vz+1Es/ABrEyYUtehL8+L7a
 ea656O32kQSdv8UmuOJWEQKAmBvtp2Oy+CI3QRSOuSYoPMkU/zuA=
X-Received: by 2002:a17:907:702:b0:b04:7107:9758 with SMTP id
 a640c23a62f3a-b34baf43b3amr2210653866b.43.1759244287510; 
 Tue, 30 Sep 2025 07:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUGMIpnIK44bbWU7+aXndC+moPoC+0yLIifvUBARDStwQ2sbA17FTE0A5aMsenHTTiCZBueg==
X-Received: by 2002:a17:907:702:b0:b04:7107:9758 with SMTP id
 a640c23a62f3a-b34baf43b3amr2210650066b.43.1759244287083; 
 Tue, 30 Sep 2025 07:58:07 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b3bc5761d3dsm647453966b.19.2025.09.30.07.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 07:58:06 -0700 (PDT)
Message-ID: <48454dc0-7047-4208-9a60-d25dad5aff35@redhat.com>
Date: Tue, 30 Sep 2025 16:58:04 +0200
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
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> diff --git a/scripts/rust-to-clang-target.sh b/scripts/rust-to-clang-target.sh
> new file mode 100644
> index 0000000000..5451807888
> --- /dev/null
> +++ b/scripts/rust-to-clang-target.sh
> @@ -0,0 +1,62 @@
> +#!/usr/bin/env sh

No shebang is needed, since the file is sourced into the configure script.

Otherwise,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

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


