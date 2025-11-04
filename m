Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF8ACCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGL9t-0004VM-R3; Tue, 04 Nov 2025 12:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9S-0004NA-4E
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:49:12 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL9Q-0005lR-1A
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:49:01 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-640e9a53ff6so1978789a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762278537; x=1762883337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yILkf0T8P7LvQ7q+vTBoHw4z3M0o0Y7BvJLfczUoIPQ=;
 b=UWegAhQaCZb/abTL3JEeJDU19DE8LmrJoeHSEeSFdabK41hb9waHQ2YLxtI15oyW/8
 S9tMsVR8GZDQ+re+9PT5BgARexzRjjJudEToek+s6hKSbSUuaKhHCBXeUqVZL1C+dkTG
 dR0LoRwJSs6RSCVjbi6tsxTfSTUdRdKt1FvTzYCjH4XIbgAnmQT56NWDUGzOyr+aKj4g
 ZPbAs7fnOjGJL6+fYRR1NBMsClKTRt/aataOOVAZp0jquqtL/ZPb2ul73k+Mgdycsz0B
 tJeW9yL05Z7/3lihxGYuahu6JdFIDAhMxzD/V1uLmFMUWRGGaTo6m0kPgtj/G+hxzITF
 9niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762278537; x=1762883337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yILkf0T8P7LvQ7q+vTBoHw4z3M0o0Y7BvJLfczUoIPQ=;
 b=IKEfiU5UsCaGibeygxuRQOLACD5DjYAtbRZlAzju4UZCl0Wiu2hLT5Y0LNN3PNq/e/
 whOCpjdOuX9xLzET80F3AQBew7i1zuS04HtTWAwDAlK71/tb9PXna8D3eBKkGWcl4mYn
 lfPlaRxmKKw1jVPB8ppLEQ6mcz0dpqjaHsf15qktssigkrl790n8r7aIhwPqNUXYItnV
 rnCJ7pev4sTyn5gP0pPKs2jkHuYfWeB74078L3kaZ0fA2wcLXOprvvpkUHOVK9ELePhF
 3RK7m8LG4ABI9hHJ6YU7JJ/w651ij31y+ZvSKYd7Z4oQ/tQ50xGcyfwc0f32kpKMEg5X
 0AwQ==
X-Gm-Message-State: AOJu0YzwBEJI06NK3aSAauk4DjyiWx83fPTLjlo78YKlgS7iTLdIpPS+
 RhqDlDM/XVG3cJYBTJuj2tN0F6c59NwX33M0KXelP+Zt78hGDRhm7SKRKSnzJY+8zKCheDtt/On
 BtECufT+7mg==
X-Gm-Gg: ASbGncsr2LwytYL/eAAeDKgXOhIPweCElE6ZFIaj9S8WxW6zNIANZzKng69Qe4BTWaC
 VqDNJXbYsw6kdRzXYtWem9Otj81578EoP5MeOZZH/bBtiv71CehXvAVKqWfvtSCIJNU/9WKE9bt
 Kn3TgmO6GajOJPvDPp6Jl/4pxRuUbY8Hvju61ELXRtwc2xJZ8Q7ZvNZR3xf9YdGbOdig05NbGmh
 Evhu3m46ySVlG7S/EkcZNJpRNaTgs8MWYP3yRPy4jPO64VROqNJQRdciWN4GFhKzyTyXJGLZ670
 VgBnxbDcMOzA01Dx6Psl6+66lVs4Ok/MceEisoC68brD+WB1SGdEIeyHmxBCWz24LvE6x1C+pd5
 2Qpxytig28YYpfKroajA7fqvbGuHfhPDoGqAbrVojWPcze5AOkkIK2Yamrgu/WkPLzAPPQrqlgl
 SjnG6pG9kGZIhL3JAcs0jQGg==
X-Google-Smtp-Source: AGHT+IHuxkydOGlIXGjtwpqfsdvJvR+JXJ9f3GWwoXPGDASM3isHjZ4w1HIz3iGPaTOt45dEaioyyg==
X-Received: by 2002:a05:6402:13cb:b0:640:9ce9:a8e6 with SMTP id
 4fb4d7f45d1cf-641058a22c3mr79564a12.4.1762278536551; 
 Tue, 04 Nov 2025 09:48:56 -0800 (PST)
Received: from localhost.localdomain ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e67eb64dsm2578187a12.5.2025.11.04.09.48.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Nov 2025 09:48:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] scripts: Add helper script to generate eMMC block device
 images
Date: Tue,  4 Nov 2025 18:48:20 +0100
Message-ID: <20251104174823.92412-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174823.92412-1-philmd@linaro.org>
References: <20251104174823.92412-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

From: Jan Kiszka <jan.kiszka@siemens.com>

As an eMMC block device image may consist of more than just the user
data partition, provide a helper script that can compose the image from
boot partitions, an RPMB partition and the user data image. The script
also does the required size validation and/or rounding.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <eecefa8e-44ae-45ff-85d0-3f9b786948e0@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/mkemmc.sh | 216 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)
 create mode 100755 scripts/mkemmc.sh

diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
new file mode 100755
index 00000000000..429388213c6
--- /dev/null
+++ b/scripts/mkemmc.sh
@@ -0,0 +1,216 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Create eMMC block device image from boot, RPMB and user data images
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+
+usage() {
+    echo "$0 [OPTIONS] USER_IMG[:SIZE] OUTPUT_IMG"
+    echo ""
+    echo "SIZE must be a power of 2 up to 2G and multiples of 512 byte from there on."
+    echo "If no SIZE is specified, the size of USER_ING will be used (rounded up)."
+    echo ""
+    echo "Supported options:"
+    echo "  -b BOOT1_IMG[:SIZE]   Add boot partitions. SIZE must be multiples of 128K. If"
+    echo "                          no SIZE is specified, the size of BOOT1_IMG will be"
+    echo "                          used (rounded up). BOOT1_IMG will be stored in boot"
+    echo "                          partition 1, and a boot partition 2 of the same size"
+    echo "                          will be created as empty (all zeros) unless -B is"
+    echo "                          specified as well."
+    echo "  -B BOOT2_IMG          Fill boot partition 2 with BOOT2_IMG. Must be combined"
+    echo "                          with -b which is also defining the partition size."
+    echo "  -r RPMB_IMG[:SIZE]    Add RPMB partition. SIZE must be multiples of 128K. If"
+    echo "                          no SIZE is specified, the size of RPMB_IMG will be"
+    echo "                          used (rounded up)."
+    echo "  -h, --help            This help"
+    echo ""
+    echo "All SIZE parameters support the units K, M, G. If SIZE is smaller than the"
+    echo "associated image, it will be truncated in the output image."
+    exit "$1"
+}
+
+process_size() {
+    name=$1
+    image_file=$2
+    alignment=$3
+    image_arg=$4
+    if [ "${image_arg#*:}" = "$image_arg"  ]; then
+        if ! size=$(wc -c < "$image_file" 2>/dev/null); then
+            echo "Missing $name image '$image_file'." >&2
+            exit 1
+        fi
+        if [ "$alignment" = 128 ]; then
+            size=$(( (size + 128 * 1024 - 1) & ~(128 * 1024 - 1) ))
+        elif [ $size -gt $((2 * 1024 * 1024 * 1024)) ]; then
+            size=$(( (size + 511) & ~511 ))
+        elif [ $(( size & (size - 1) )) -gt 0 ]; then
+            n=0
+            while [ "$size" -gt 0 ]; do
+                size=$((size >> 1))
+                n=$((n + 1))
+            done
+            size=$((1 << n))
+        fi
+    else
+        value="${image_arg#*:}"
+        if [ "${value%K}" != "$value" ]; then
+            size=${value%K}
+            multiplier=1024
+        elif [ "${value%M}" != "$value" ]; then
+            size=${value%M}
+            multiplier=$((1024 * 1024))
+        elif [ "${value%G}" != "$value" ]; then
+            size=${value%G}
+            multiplier=$((1024 * 1024 * 1024))
+        else
+            size=$value
+            multiplier=1
+        fi
+        # check if "$size" is a valid integer by doing a self-comparison
+        if [ "$size" -eq "$size" ] 2>/dev/null; then
+            size=$((size * multiplier))
+        else
+            echo "Invalid value '$value' specified for $image_file image size." >&2
+            exit 1
+        fi
+        if [ "$alignment" = 128 ]; then
+            if [ $(( size & (128 * 1024 - 1) )) -ne 0 ]; then
+                echo "The $name image size must be multiples of 128K." >&2
+                exit 1
+            fi
+        elif [ $size -gt $((2 * 1024 * 1024 * 1024)) ]; then
+            if [ $(( size & 511)) -ne 0 ]; then
+                echo "The $name image size must be multiples of 512 (if >2G)." >&2
+                exit 1
+            fi
+        elif [ $(( size & (size - 1) )) -gt 0 ]; then
+            echo "The $name image size must be power of 2 (up to 2G)." >&2
+            exit 1
+        fi
+    fi
+    echo $size
+}
+
+check_truncation() {
+    image_file=$1
+    output_size=$2
+    if [ "$image_file" = "/dev/zero" ]; then
+        return
+    fi
+    if ! actual_size=$(wc -c < "$image_file" 2>/dev/null); then
+        echo "Missing image '$image_file'." >&2
+        exit 1
+    fi
+    if [ "$actual_size" -gt "$output_size" ]; then
+        echo "Warning: image '$image_file' will be truncated on output."
+    fi
+}
+
+userimg=
+outimg=
+bootimg1=
+bootimg2=/dev/zero
+bootsz=0
+rpmbimg=
+rpmbsz=0
+
+while [ $# -gt 0 ]; do
+    case "$1" in
+        -b)
+            shift
+            [ $# -ge 1 ] || usage 1
+            bootimg1=${1%%:*}
+            bootsz=$(process_size boot "$bootimg1" 128 "$1")
+            shift
+            ;;
+        -B)
+            shift
+            [ $# -ge 1 ] || usage 1
+            bootimg2=$1
+            shift
+            ;;
+        -r)
+            shift
+            [ $# -ge 1 ] || usage 1
+            rpmbimg=${1%%:*}
+            rpmbsz=$(process_size RPMB "$rpmbimg" 128 "$1")
+            shift
+            ;;
+        -h|--help)
+            usage 0
+            ;;
+        *)
+            if [ -z "$userimg" ]; then
+                userimg=${1%%:*}
+                usersz=$(process_size user "$userimg" U "$1")
+            elif [ -z "$outimg" ]; then
+                outimg=$1
+            else
+                usage 1
+            fi
+            shift
+            ;;
+    esac
+done
+
+[ -n "$outimg" ] || usage 1
+
+if [ "$bootsz" -gt $((32640 * 1024)) ]; then
+    echo "Boot image size is larger than 32640K." >&2
+    exit 1
+fi
+if [ "$rpmbsz" -gt $((16384 * 1024)) ]; then
+    echo "RPMB image size is larger than 16384K." >&2
+    exit 1
+fi
+
+echo "Creating eMMC image"
+
+truncate -s 0 "$outimg"
+pos=0
+
+if [ "$bootsz" -gt 0 ]; then
+    echo "  Boot partition 1 and 2:   $((bootsz / 1024))K each"
+    blocks=$(( bootsz / (128 * 1024) ))
+    check_truncation "$bootimg1" "$bootsz"
+    dd if="$bootimg1" of="$outimg" conv=sparse bs=128K count=$blocks \
+        status=none
+    check_truncation "$bootimg2" "$bootsz"
+    dd if="$bootimg2" of="$outimg" conv=sparse bs=128K count=$blocks \
+        seek=$blocks status=none
+    pos=$((2 * bootsz))
+fi
+
+if [ "$rpmbsz" -gt 0 ]; then
+    echo "  RPMB partition:           $((rpmbsz / 1024))K"
+    blocks=$(( rpmbsz / (128 * 1024) ))
+    check_truncation "$rpmbimg" "$rpmbsz"
+    dd if="$rpmbimg" of="$outimg" conv=sparse bs=128K count=$blocks \
+        seek=$(( pos / (128 * 1024) )) status=none
+    pos=$((pos + rpmbsz))
+fi
+
+if [ "$usersz" -lt 1024 ]; then
+    echo "  User data:                $usersz bytes"
+elif [ "$usersz" -lt $((1024 * 1024)) ]; then
+    echo "  User data:                $(( (usersz + 1023) / 1024 ))K ($usersz)"
+elif [ "$usersz" -lt $((1024 * 1024 * 1024)) ]; then
+    echo "  User data:                $(( (usersz + 1048575) / 1048576))M ($usersz)"
+else
+    echo "  User data:                $(( (usersz + 1073741823) / 1073741824))G ($usersz)"
+fi
+check_truncation "$userimg" "$usersz"
+dd if="$userimg" of="$outimg" conv=sparse bs=128K seek=$(( pos / (128 * 1024) )) \
+    count=$(( (usersz + 128 * 1024 - 1) / (128 * 1024) )) status=none
+pos=$((pos + usersz))
+truncate -s $pos "$outimg"
+
+echo ""
+echo "Instantiate by appending to the qemu command line:"
+echo "  -drive file=$outimg,if=none,format=raw,id=emmc-img"
+echo "  -device emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=emmc-img"
-- 
2.51.0


