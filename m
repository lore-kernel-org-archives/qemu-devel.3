Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ABECA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzHj-0006cL-Ho; Tue, 09 Sep 2025 10:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jerome.forissier@linaro.org>)
 id 1uvzHb-0006Wo-GX
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:25:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerome.forissier@linaro.org>)
 id 1uvzHY-0001hA-Ca
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:25:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45dde353b47so14959335e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757427911; x=1758032711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CdZJ8tAz847bxSBFtZgcVjg/2hhuPhM16jxDiofBmkI=;
 b=b71nhVnHagNzSjymlAdw24Ij2ik5VOBdinGhOe6ZPzB1naxwjRPQw1SlVAF+iwOAby
 ZsjfUPB+LVNw4/coTtXIlHlE8zYwox/TCpumXtHhgFIRWqGth6JiQaqYjEXPzaanNq4L
 orWafLi/u1dl5wHYd9ekQC600Z5foOqDUFsJyKuKy0AVBWxdFGHsZxXtCxzPkvXxSuis
 gxFHOO15bE8O6zXp/ZsL2ct1GBt+m2qc7H4VThcaNQuVQrPmCAbxuSVTAwwcVRqmJ+lQ
 rOOmVGDcVneEqdAaHXmhLFg2pUqyAkiwTBEcw8SR1Dn0Bl5/rjI1i0x0nmciGLAPErD2
 cvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757427911; x=1758032711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CdZJ8tAz847bxSBFtZgcVjg/2hhuPhM16jxDiofBmkI=;
 b=m1pGgruBIxTJaawVxrGgbPiabvf+rkdXbIllsBZFL6xj5CFzsjGnS0RaFKvANAElC+
 JfWfIFoXZd4aY4tvnJw01SEUCKnFd8nhdtjighmFG9bRg08mhspGK0sESYYhnDFcRJvP
 NQ5LksulGYTmdmCoxHCGaVF74WhQxPbGB32/N12Z6hQoYUeI8e16ILX1SpdQkV7L73Vi
 O7PQEuT7BvoGRigDPAt0s3caoc3993TgySb7EadifS8zjWoVFt/Z7Byyphd18Oqrc3Ad
 qrwizOzKZXUbV/oS4RrrjE/aWQD9ZhH4lRF7F89D7shFA5cbGRWL24ZtbdnEn9QO5Fud
 z6zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeXTlWcFgwXUesCMswjRjCa2IBOj85UyrFR31ZWxa8Kt0QEVSbO1SUq/WCqjStXTMCoZDxKtEss3uU@nongnu.org
X-Gm-Message-State: AOJu0Yy/r3PYBwUn4YvQo3a62ceXGq/sES9WFEFT5bClm29ISTcLuyGi
 jSKtIvfYOHFo0PXBFNZkCc3oZDdGLdYelESBMHtSrKTQ6Aw74PHUP0IVjYJBsOzfpEk=
X-Gm-Gg: ASbGncvT82JSBjT3PLA9bts8eVxFeJNEQcZlW/5y79NHUt8zXHK840+oN/SxJP/TR8r
 AXz3jV9jeERtiXcQdTeAZFxI4qlLLwTJ7Rl0JGDTt8Lne//jBXxyo8IWJSysWYTVtib8UKMmeIr
 LYNL44AYeL8Tds2f8U7Lhx/OHJVxkglRLHzBKi1bpvziX2aYtb3rMZf/6CNklDBG5EQAFaxVELA
 RBN/75eDV8rtPraCPjKhtKs+4g6XFgfabIxEPbt+URGrJWb90mpg/428nxu8deQ0c+WKmX4Sl8j
 kzs6ldepjqGzR0pLPSXOznQUt+zAC92CU3x65/I+cbznxsjATNkrsPTHwopubedlfxSaY8qBqQf
 djlnmTRPdUZEK/speRD/yGfteLyiRg2ovFQd6qLqM1FU=
X-Google-Smtp-Source: AGHT+IE1UDyeLQBqsihA4BIgmPgjC+G5sTLwEjvR+NJzkBmMUw7+IggXkHTrsRe+LZVugp7/48XDTA==
X-Received: by 2002:a05:600c:3589:b0:45b:8b34:3489 with SMTP id
 5b1f17b1804b1-45dedc411fcmr25922605e9.4.1757427910543; 
 Tue, 09 Sep 2025 07:25:10 -0700 (PDT)
Received: from [10.100.0.2] ([45.84.137.209]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e75223885csm2850201f8f.36.2025.09.09.07.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 07:25:10 -0700 (PDT)
Message-ID: <891712cb-0dee-482f-888c-2649ae2d4ca9@linaro.org>
Date: Tue, 9 Sep 2025 16:25:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] scripts: Add helper script to generate eMMC block
 device images
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <c8ee22c72a87c6bd8d9495995868cb22a633de41.1756019920.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <c8ee22c72a87c6bd8d9495995868cb22a633de41.1756019920.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jerome.forissier@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Jan,


On 8/24/25 09:18, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> As an eMMC block device image may consist of more than just the user
> data partition, provide a helper script that can compose the image from
> boot partitions, an RPMB partition and the user data image. The script
> also does the required size validation and/or rounding.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  scripts/mkemmc.sh | 185 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100755 scripts/mkemmc.sh
> 
> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
> new file mode 100755
> index 0000000000..5d40c2889b
> --- /dev/null
> +++ b/scripts/mkemmc.sh
> @@ -0,0 +1,185 @@
> +#!/bin/sh -e
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
> +    echo "SIZE must be a power of 2. If no SIZE is specified, the size of USER_ING will"
> +    echo "be used (rounded up)."
> +    echo ""
> +    echo "Supported options:"
> +    echo "  -b BOOT1_IMG[:SIZE]   Add boot partitions. SIZE must be multiples of 128K. If"
> +    echo "                          no SIZE is specified, the size of BOOT_IMG will be"

the size of BOOT1_IMG

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
> +    if [ "${4#*:}" = "$4"  ]; then
> +        if ! size=$(stat -L -c %s "$2" 2>/dev/null); then
> +            echo "Missing $1 image '$2'." >&2
> +            exit 1
> +        fi
> +        if [ "$3" = 128 ]; then
> +            size=$(( (size + 128 * 1024 - 1) & ~(128 * 1024 - 1) ))
> +        elif [ $(( size & (size - 1) )) -gt 0 ]; then
> +            n=0
> +            while [ "$size" -gt 0 ]; do
> +                size=$((size >> 1))
> +                n=$((n + 1))
> +            done
> +            size=$((1 << n))
> +        fi
> +    else
> +        value="${4#*:}"
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
> +            size=$((size * multiplier))
> +        else
> +            echo "Invalid value '$value' specified for $2 image size." >&2
> +            exit 1
> +        fi
> +        if [ "$3" = 128 ]; then
> +            if [ $(( size & (128 * 1024 - 1) )) -ne 0 ]; then
> +                echo "The $2 image size must be multiples of 128K." >&2
> +                exit 1
> +            fi
> +        elif [ $(( size & (size - 1) )) -gt 0 ]; then
> +            echo "The %2 image size must be power of 2." >&2
> +            exit 1
> +        fi
> +    fi
> +    echo $size
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
> +                usersz=$(process_size user "$userimg" 2 "$1")
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
> +    echo "Boot image size is larger than 32640K." >&2
> +    exit 1
> +fi

Should we warn if BOOT1_IMG and/or BOOT2_IMG are truncated as a result
of $bootsz being too small? I can see how providing a larger size can be
useful to be able to later extend the filesystem, but a smaller size is
more likely to indicate an error I suppose?

> +if [ "$rpmbsz" -gt $((16384 * 1024)) ]; then
> +    echo "RPMB image size is larger than 16384K." >&2
> +    exit 1
> +fi> +
> +echo "Creating eMMC image"
> +
> +truncate "$outimg" -s 0
> +pos=0
> +
> +if [ "$bootsz" -gt 0 ]; then
> +    echo "  Boot partition 1 and 2:   $((bootsz / 1024))K each"
> +    blocks=$(( bootsz / (128 * 1024) ))
> +    dd if="$bootimg1" of="$outimg" conv=sparse bs=128K count=$blocks \
> +        status=none
> +    dd if="$bootimg2" of="$outimg" conv=sparse bs=128K count=$blocks \
> +        seek=$blocks status=none
> +    pos=$((2 * bootsz))
> +fi
> +
> +if [ "$rpmbsz" -gt 0 ]; then
> +    echo "  RPMB partition:           $((rpmbsz / 1024))K"
> +    blocks=$(( rpmbsz / (128 * 1024) ))
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
> +dd if="$userimg" of="$outimg" conv=sparse bs=128K seek=$(( pos / (128 * 1024) )) \
> +    count=$(( (usersz + 128 * 1024 - 1) / (128 * 1024) )) status=none
> +pos=$((pos + usersz))
> +truncate "$outimg" -s $pos
> +
> +echo ""
> +echo "Instantiate via '-device emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=$outimg'"

That did not work for me. I had to provide a drive name, not the image path.
An also create PCIe and SDHCI devices. That is:

-device pcie-root-port,id=pcie-root,bus=pcie.0 \
-device sdhci-pci,bus=pcie-root \
-device emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=mmc0
-drive if=none,id=mmc0,file=$outimg,format=raw"

I applied the patches on top of QEMU 10.1.0 if that matters.

Regards,
-- 
Jerome


