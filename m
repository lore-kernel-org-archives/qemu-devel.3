Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F5FCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvy0B-0002dW-Ph; Tue, 09 Sep 2025 09:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202509091251056de098b57a000207bb-gl7lKv@rts-flowmailer.siemens.com>)
 id 1uvxyk-0000d7-LM
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:01:48 -0400
Received: from mta-64-228.siemens.flowmailer.net ([185.136.64.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202509091251056de098b57a000207bb-gl7lKv@rts-flowmailer.siemens.com>)
 id 1uvxyY-0003qD-2h
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:01:46 -0400
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 202509091251056de098b57a000207bb for <qemu-devel@nongnu.org>;
 Tue, 09 Sep 2025 14:51:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XpaUSmy2KFxJ62o1P2/KscwGD+F4kB8tiYPURuiobxA=;
 b=inlswZ0qNAX4s7VC8ud40XH0NocCihvqg513x2n40S+Svi2VRclI1HRoYEFrOdDb1LXgG4
 DZIld8+gBQPpNxa1Guf6smXyGU1j6r9axJdf6RzzAirDaPiF4nv1+8cplbkCjBnkmHuz9u9A
 D1RnTS1+4AnCFTfF/4i56ostD4P3XOOEPtJs/8Bx4eZpGNC7tPUlQ8kI050cUtrJST0i+6AO
 xuGNg0S71ZXtJAXV9OdKc/8XtFBl9U7CAgQpJEXP2D1igyeJV6G08ZApYRgBsOjdkA8efT8V
 bk3uddBkRzTZUY9KKaA7Ou7nhpUJXAZkjUQSn6yKiFa2GpPFQa4GvEnw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>
Subject: [PATCH v3 5/6] scripts: Add helper script to generate eMMC block
 device images
Date: Tue,  9 Sep 2025 14:50:55 +0200
Message-ID: <77a3652687a7ebc7451326cdc7d2c66722e6a223.1757422256.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757422256.git.jan.kiszka@siemens.com>
References: <cover.1757422256.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.228;
 envelope-from=fm-294854-202509091251056de098b57a000207bb-gl7lKv@rts-flowmailer.siemens.com;
 helo=mta-64-228.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jan Kiszka <jan.kiszka@siemens.com>

As an eMMC block device image may consist of more than just the user
data partition, provide a helper script that can compose the image from
boot partitions, an RPMB partition and the user data image. The script
also does the required size validation and/or rounding.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/mkemmc.sh | 199 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)
 create mode 100755 scripts/mkemmc.sh

diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
new file mode 100755
index 0000000000..0532517011
--- /dev/null
+++ b/scripts/mkemmc.sh
@@ -0,0 +1,199 @@
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
+# This work is licensed under the terms of the GNU GPL version 2.
+# See the COPYING file in the top-level directory.
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
+    echo "                          no SIZE is specified, the size of BOOT_IMG will be"
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
+        if ! size=$(stat -L -c %s "$image_file" 2>/dev/null); then
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
+truncate "$outimg" -s 0
+pos=0
+
+if [ "$bootsz" -gt 0 ]; then
+    echo "  Boot partition 1 and 2:   $((bootsz / 1024))K each"
+    blocks=$(( bootsz / (128 * 1024) ))
+    dd if="$bootimg1" of="$outimg" conv=sparse bs=128K count=$blocks \
+        status=none
+    dd if="$bootimg2" of="$outimg" conv=sparse bs=128K count=$blocks \
+        seek=$blocks status=none
+    pos=$((2 * bootsz))
+fi
+
+if [ "$rpmbsz" -gt 0 ]; then
+    echo "  RPMB partition:           $((rpmbsz / 1024))K"
+    blocks=$(( rpmbsz / (128 * 1024) ))
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
+dd if="$userimg" of="$outimg" conv=sparse bs=128K seek=$(( pos / (128 * 1024) )) \
+    count=$(( (usersz + 128 * 1024 - 1) / (128 * 1024) )) status=none
+pos=$((pos + usersz))
+truncate "$outimg" -s $pos
+
+echo ""
+echo "Instantiate by appending to the qemu command line:"
+echo "  -drive file=$outimg,if=none,format=raw,id=emmc-img"
+echo "  -device emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=emmc-img"
-- 
2.51.0


