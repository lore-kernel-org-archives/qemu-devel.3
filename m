Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C94ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuMS-0000AA-9U; Mon, 03 Nov 2025 08:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFuMN-00009r-52
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:12:35 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFuM9-0007cp-SB
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:12:34 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4298b865f84so1946597f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762175527; x=1762780327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LtfshfQhKFvEMkyiqCdcBdGH7uuhRla4fx3DacJvN2w=;
 b=HtUXZxO86CSTa4KgV5fYzvBXmCx/v5I0cyIkGYR2r6T6YBypPxkh3tM3Pe5wYJ6WCU
 AGCftIWxlonbs5uoQVPrIP1iG/pyBPHQYtVTruGYKCVJpF+Okp5UPAPIMHNI5Q8yjMpf
 Nk0DJm3AmS+tDhfLtm9EdI8yVCpFsv5u09Cb8cKfyllMf+ujCVoJV9urBaSo3RRnBg86
 qNgZRKorAx7rZgPiPf517aGbXmm6jiQyeOdLuN9vIQOXC/cwTRaasUy6NCl9W+gbmxUw
 4l1zjAkGtmhOS5Y3JialtNuDgwrhY/izWPDoJMmYXcQ2wXEpOvrbK/QISBhBn5R23EfV
 llxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762175527; x=1762780327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LtfshfQhKFvEMkyiqCdcBdGH7uuhRla4fx3DacJvN2w=;
 b=q1CX4Y0zzs49hKIXMfMj3u/lcftiyi1LH3R4jehZ5TqkkVZxpBHyWL8UvQgQkqiJUi
 kjOCN8j8xyesBa2aB0WJh54IJIUV3mDB09UtI23jfz2bBkPDhjnRwi4tHNjyrUl8UKp9
 BI/N6v6RCWZLk5Ilp5/ebQJl8Ww/MmKuP+OaWc43zgPhMSOLsOsAKDBVza1eUs9ASHlg
 u5I9ccGzMCEQPOsHc10xt104E+EfMHMiRFdakly9w0bk9LP2BG3VxtBX1o3PKTby2Ajo
 PGBG+fYCkV5Bm2DhP5LUvpupYuYpioVHG7tcywjnkOvhcm2qXCdVi3VE9A2q+jpHwEDq
 avXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE1UbdJYLc9bVzjFMcvDZM9DgAWmWOWjR6NewznfOdnEw4Nm89mMKumk3Lo0hFypsNjAv5K+pYrIaU@nongnu.org
X-Gm-Message-State: AOJu0Yyk7ek/6Z6LlfwWVWO7tNmEbvLX5WAcNSQuY1vLKdpugZY1Xf9b
 COCgnQtNKpOweqFBgj+cMAW+PUaOK24spdS+BUHWk9IckLGJ+T9ANZgD+t/xBfALmxYi/18g2/1
 BGm5I47ZHLF0i
X-Gm-Gg: ASbGncuMPFwW8Vu0X/FFxiO5CnBIbJiUwYWMRFa1H+cXQUzO5valHFbAIXoHXtmbjvC
 lqY/ijpVrP6oVQgLXsbl4+7jOTlz0UwiNeaYqUtX22vn5bV8NU3d+bWAgwghcnjb4yM51pibIKy
 4iZiJXL8rB1yx5vhSrTClvJKUzc1FcY0/OZpD8jDrgsXFxV3jg2zcWoxv0AY8I2uzAEW7JiMxOS
 ZKHWaaQ5eXRVvgO1UpbU2roNNxctyriNS4trZjkgg2/FowfyesKMTZpxW5JpNDj5a2trN8dKHw2
 c+U/eHQfEmKSoYMactfJs30QKe+b2IxeHCvNG91bFDrZESwoYEzKShRxqijXEy7T4qe5aOUPzfX
 b2clxAb67oCEhS0kM5ypRkrTitXkTZ/5e7Wd5hKhusICxa6ut8M1aIHx6FuRrmq6vx6lCy4kcdf
 2jUTmQzXx0GCIA4nnfawrfQQHwjPKuaSm2jjPnyd9qD1c2DyzWPTDv5XIDiWsRf1o=
X-Google-Smtp-Source: AGHT+IEWsgDkVvUvtLN1e0cKwdqo4yLDCUjRUWNlZxSaDcbe0i1fLqs4T6AYwNY9yhi/j+yV0elY6g==
X-Received: by 2002:a5d:64c5:0:b0:429:cda2:a01d with SMTP id
 ffacd0b85a97d-429cda2a2f2mr4805382f8f.26.1762175527039; 
 Mon, 03 Nov 2025 05:12:07 -0800 (PST)
Received: from [172.18.140.215] (ip-185-104-138-156.ptr.icomera.net.
 [185.104.138.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c140629dsm20392664f8f.46.2025.11.03.05.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 05:12:06 -0800 (PST)
Message-ID: <bfd49f9a-0a37-4e1d-b7e2-f0e59943915e@linaro.org>
Date: Mon, 3 Nov 2025 14:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] scripts: Add helper script to generate eMMC block
 device images
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Eric Blake <eblake@redhat.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <5c9c6495ad4afc9d11f856bafcb797fed8fccecc.1760702638.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5c9c6495ad4afc9d11f856bafcb797fed8fccecc.1760702638.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Jan,

On 17/10/25 14:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> As an eMMC block device image may consist of more than just the user
> data partition, provide a helper script that can compose the image from
> boot partitions, an RPMB partition and the user data image. The script
> also does the required size validation and/or rounding.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   scripts/mkemmc.sh | 218 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 218 insertions(+)
>   create mode 100755 scripts/mkemmc.sh
> 
> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
> new file mode 100755
> index 0000000000..1a2b7a6193
> --- /dev/null
> +++ b/scripts/mkemmc.sh
> @@ -0,0 +1,218 @@
> +#!/bin/sh -e
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Create eMMC block device image from boot, RPMB and user data images
> +#
> +# Copyright (c) Siemens, 2025
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# This work is licensed under the terms of the GNU GPL version 2.
> +# See the COPYING file in the top-level directory.
> +#
> +
> +usage() {
> +    echo "$0 [OPTIONS] USER_IMG[:SIZE] OUTPUT_IMG"
> +    echo ""
> +    echo "SIZE must be a power of 2 up to 2G and multiples of 512 byte from there on."
> +    echo "If no SIZE is specified, the size of USER_ING will be used (rounded up)."
> +    echo ""
> +    echo "Supported options:"
> +    echo "  -b BOOT1_IMG[:SIZE]   Add boot partitions. SIZE must be multiples of 128K. If"
> +    echo "                          no SIZE is specified, the size of BOOT1_IMG will be"
> +    echo "                          used (rounded up). BOOT1_IMG will be stored in boot"
> +    echo "                          partition 1, and a boot partition 2 of the same size"
> +    echo "                          will be created as empty (all zeros) unless -B is"
> +    echo "                          specified as well."
> +    echo "  -B BOOT2_IMG          Fill boot partition 2 with BOOT2_IMG. Must be combined"
> +    echo "                          with -b which is also defining the partition size."
> +    echo "  -r RPMB_IMG[:SIZE]    Add RPMB partition. SIZE must be multiples of 128K. If"
> +    echo "                          no SIZE is specified, the size of RPMB_IMG will be"
> +    echo "                          used (rounded up)."
> +    echo "  -h, --help            This help"
> +    echo ""
> +    echo "All SIZE parameters support the units K, M, G. If SIZE is smaller than the"
> +    echo "associated image, it will be truncated in the output image."
> +    exit "$1"
> +}
> +
> +process_size() {
> +    name=$1
> +    image_file=$2
> +    alignment=$3
> +    image_arg=$4
> +    if [ "${image_arg#*:}" = "$image_arg"  ]; then
> +        if ! size=$(stat -L -c %s "$image_file" 2>/dev/null); then
> +            echo "Missing $name image '$image_file'." >&2
> +            exit 1
> +        fi
> +        if [ "$alignment" = 128 ]; then
> +            size=$(( (size + 128 * 1024 - 1) & ~(128 * 1024 - 1) ))
> +        elif [ $size -gt $((2 * 1024 * 1024 * 1024)) ]; then
> +            size=$(( (size + 511) & ~511 ))
> +        elif [ $(( size & (size - 1) )) -gt 0 ]; then
> +            n=0
> +            while [ "$size" -gt 0 ]; do
> +                size=$((size >> 1))
> +                n=$((n + 1))
> +            done
> +            size=$((1 << n))
> +        fi
> +    else
> +        value="${image_arg#*:}"
> +        if [ "${value%K}" != "$value" ]; then
> +            size=${value%K}
> +            multiplier=1024
> +        elif [ "${value%M}" != "$value" ]; then
> +            size=${value%M}
> +            multiplier=$((1024 * 1024))
> +        elif [ "${value%G}" != "$value" ]; then
> +            size=${value%G}
> +            multiplier=$((1024 * 1024 * 1024))
> +        else
> +            size=$value
> +            multiplier=1
> +        fi
> +        if [ "$size" -eq "$size" ] 2>/dev/null; then

I don't get this check, should one be "$value"?

> +            size=$((size * multiplier))
> +        else
> +            echo "Invalid value '$value' specified for $image_file image size." >&2
> +            exit 1
> +        fi
> +        if [ "$alignment" = 128 ]; then
> +            if [ $(( size & (128 * 1024 - 1) )) -ne 0 ]; then
> +                echo "The $name image size must be multiples of 128K." >&2
> +                exit 1
> +            fi
> +        elif [ $size -gt $((2 * 1024 * 1024 * 1024)) ]; then
> +            if [ $(( size & 511)) -ne 0 ]; then
> +                echo "The $name image size must be multiples of 512 (if >2G)." >&2
> +                exit 1
> +            fi
> +        elif [ $(( size & (size - 1) )) -gt 0 ]; then
> +            echo "The $name image size must be power of 2 (up to 2G)." >&2
> +            exit 1
> +        fi
> +    fi
> +    echo $size
> +}
> +
> +check_truncation() {
> +    image_file=$1
> +    output_size=$2
> +    if [ "$image_file" = "/dev/zero" ]; then
> +        return
> +    fi
> +    if ! actual_size=$(stat -L -c %s "$image_file" 2>/dev/null); then
> +        echo "Missing image '$image_file'." >&2
> +        exit 1
> +    fi
> +    if [ "$actual_size" -gt "$output_size" ]; then
> +        echo "Warning: image '$image_file' will be truncated on output."
> +    fi
> +}
> +
> +userimg=
> +outimg=
> +bootimg1=
> +bootimg2=/dev/zero
> +bootsz=0
> +rpmbimg=
> +rpmbsz=0
> +
> +while [ $# -gt 0 ]; do
> +    case "$1" in
> +        -b)
> +            shift
> +            [ $# -ge 1 ] || usage 1
> +            bootimg1=${1%%:*}
> +            bootsz=$(process_size boot "$bootimg1" 128 "$1")
> +            shift
> +            ;;
> +        -B)
> +            shift
> +            [ $# -ge 1 ] || usage 1
> +            bootimg2=$1
> +            shift
> +            ;;
> +        -r)
> +            shift
> +            [ $# -ge 1 ] || usage 1
> +            rpmbimg=${1%%:*}
> +            rpmbsz=$(process_size RPMB "$rpmbimg" 128 "$1")
> +            shift
> +            ;;
> +        -h|--help)
> +            usage 0
> +            ;;
> +        *)
> +            if [ -z "$userimg" ]; then
> +                userimg=${1%%:*}
> +                usersz=$(process_size user "$userimg" U "$1")
> +            elif [ -z "$outimg" ]; then
> +                outimg=$1
> +            else
> +                usage 1
> +            fi
> +            shift
> +            ;;
> +    esac
> +done
> +
> +[ -n "$outimg" ] || usage 1
> +
> +if [ "$bootsz" -gt $((32640 * 1024)) ]; then

Running on macOS:

scripts/mkemmc.sh: line 165: [: : integer expression expected
scripts/mkemmc.sh: line 169: [: : integer expression expected
scripts/mkemmc.sh: line 179: [: : integer expression expected
scripts/mkemmc.sh: line 191: [: : integer expression expected
scripts/mkemmc.sh: line 200: [: : integer expression expected
scripts/mkemmc.sh: line 202: [: : integer expression expected
scripts/mkemmc.sh: line 204: [: : integer expression expected

$ sh --version
GNU bash, version 3.2.57(1)-release (arm64-apple-darwin24)

When using dash:

scripts/mkemmc.sh: 165: [: Illegal number:
scripts/mkemmc.sh: 169: [: Illegal number:
scripts/mkemmc.sh: 179: [: Illegal number:
scripts/mkemmc.sh: 191: [: Illegal number:
scripts/mkemmc.sh: 200: [: Illegal number:
scripts/mkemmc.sh: 202: [: Illegal number:
scripts/mkemmc.sh: 204: [: Illegal number:

Should we replace s/[/[[/?

> +    echo "Boot image size is larger than 32640K." >&2
> +    exit 1
> +fi
> +if [ "$rpmbsz" -gt $((16384 * 1024)) ]; then
> +    echo "RPMB image size is larger than 16384K." >&2
> +    exit 1
> +fi
> +
> +echo "Creating eMMC image"
> +
> +truncate "$outimg" -s 0
I'd replace here by:
    truncate -s 0 "$outimg"

to avoid on macOS:

usage: truncate [-c] -s [+|-|%|/]size[K|k|M|m|G|g|T|t] file ...
        truncate [-c] -r rfile file ...

> +pos=0
> +
> +if [ "$bootsz" -gt 0 ]; then
> +    echo "  Boot partition 1 and 2:   $((bootsz / 1024))K each"
> +    blocks=$(( bootsz / (128 * 1024) ))
> +    check_truncation "$bootimg1" "$bootsz"
> +    dd if="$bootimg1" of="$outimg" conv=sparse bs=128K count=$blocks \
> +        status=none
> +    check_truncation "$bootimg2" "$bootsz"
> +    dd if="$bootimg2" of="$outimg" conv=sparse bs=128K count=$blocks \
> +        seek=$blocks status=none
> +    pos=$((2 * bootsz))
> +fi
> +
> +if [ "$rpmbsz" -gt 0 ]; then
> +    echo "  RPMB partition:           $((rpmbsz / 1024))K"
> +    blocks=$(( rpmbsz / (128 * 1024) ))
> +    check_truncation "$rpmbimg" "$rpmbsz"
> +    dd if="$rpmbimg" of="$outimg" conv=sparse bs=128K count=$blocks \
> +        seek=$(( pos / (128 * 1024) )) status=none
> +    pos=$((pos + rpmbsz))
> +fi
> +
> +if [ "$usersz" -lt 1024 ]; then
> +    echo "  User data:                $usersz bytes"
> +elif [ "$usersz" -lt $((1024 * 1024)) ]; then
> +    echo "  User data:                $(( (usersz + 1023) / 1024 ))K ($usersz)"
> +elif [ "$usersz" -lt $((1024 * 1024 * 1024)) ]; then
> +    echo "  User data:                $(( (usersz + 1048575) / 1048576))M ($usersz)"
> +else
> +    echo "  User data:                $(( (usersz + 1073741823) / 1073741824))G ($usersz)"
> +fi
> +check_truncation "$userimg" "$usersz"
> +dd if="$userimg" of="$outimg" conv=sparse bs=128K seek=$(( pos / (128 * 1024) )) \
> +    count=$(( (usersz + 128 * 1024 - 1) / (128 * 1024) )) status=none
> +pos=$((pos + usersz))
> +truncate "$outimg" -s $pos

truncate -s $pos "$outimg"

> +
> +echo ""
> +echo "Instantiate by appending to the qemu command line:"
> +echo "  -drive file=$outimg,if=none,format=raw,id=emmc-img"
> +echo "  -device emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=emmc-img"


