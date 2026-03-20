Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214581098785
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3a8B-0001S9-TT; Fri, 20 Mar 2026 09:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w3a83-0001Qh-1V
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:43:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w3a7z-0006ny-IT
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:43:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486fe655187so10837275e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1774014182; x=1774618982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fDj2Qqh/4C/WoqrNk8wGvgiL8VR8WZfLHVtWmDlTjo=;
 b=M0r4N1C3RMhHvqZFj3CAK9PZ4D1q85exON5/FbMw58MrOWhBkP1qARaJ67MSLq9ofE
 s1fThDdrYtHdDOAsjcF87xk6SjDHynq8EneoKdA5uSe6li6wF3Mry5az2O5e/6pr7zNk
 Q/FH0qGQtf1Ab08aK8q/E4j/QqHtnQww3jUAJlFtVi7OPWUrWMBbjpCHSE1w2S58e2mk
 lDhll/5girxH8cySlO0/4HsRlS6JvhDt7JTPEEPWv+/VSUAsUTKF6QR+aruM1Bsul08O
 dZkBnNZx29pu2m+R+/46xLCN65l1Sip3Rkg172xJUAY7ge/9XhYdYdiRmlC7KWe/KLVO
 rLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774014182; x=1774618982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0fDj2Qqh/4C/WoqrNk8wGvgiL8VR8WZfLHVtWmDlTjo=;
 b=kOhtG0OJ199WWAeD/F3FC5w70ytnOqPp2CJjSKHheBLc8Vhxwo1tXttUIGBicZK1bd
 fIt5sThi/B6Hxit1wYln1E40iVGpTRo+//UZpHbTLp69DsPyqSa/9OO1yaS3sMDSJY2J
 zOW+04amad4E4sYLNHXv5e3wAQ709KPTsFjXDL7iTTk1K3VvCJypCs4wyQM09IRkEdKL
 5udw/2wCxXSK1YQZwfwdkX8Xt923xxfz0EZ+oFhehkyvDJ8zldsaWgc1VqkQZIRST1wO
 3lhz4nojr0Ym2XxZivcHITtiNgCxxSlicIpPb5Ctb7pAqyszsdAHYwTRJMpKcZVeIwgG
 9TsA==
X-Gm-Message-State: AOJu0YzAgTguBKtnN0/bltNs573+C+/pQ7HZHWmXUUNpppySIRe6IhqM
 iIfhgtfTDNkGbBQ0jd7ehZmcg8kMUf3JZe3smFr6ewLHBMmaX/ZBjiN+cHdcd/lg0D4=
X-Gm-Gg: ATEYQzwawZOikOnpDZvBWdYeN6khFUCNLtxXBxHGgQdf6bb9X4vekd7BIqY7/sG+O7c
 6u9sfUhnkJCv+G3G94LaLbBDWBrABTpJBQf8yP30LKkfZtKAqnK1T1MDbLUeQAPExSqytNJ7DTS
 SIsUcKHfot9OFA+mtJV/dP3Tq9jClzmn+AD1u/ePQpfIUNteaCKS6EU3HCPsE4DJQhAMXKW9ZH+
 Zz/U9qfut0rmJpZNgKKuP6mWEsBPpjRvZ8efguRAk81/Vgs6PAwTPqs39Ke/vdgA/SCJMWv9VdL
 +YTxYy2gkn8CM/IrN90rpUOKcVTX9RTE9bslDftT6dPB3NmZu3Bp6Fh3A4MF5MTPgDpVW93Gb+K
 hrIZchFBEiSCXk4tb9UR7U9/z5VJA+VKNbPwIYwuRQNX+hNm5kfS9Y+hhvh3op67tWtQecWJrRl
 3ll6fvPRaNzh+xwO6DvXpddnUSB2vY92cOi7aphbLqbYbQo/j1zQHdmJAuu/q4JUkLkZi2K+GzS
 wPwXcwhk0O/IbJlGreQ
X-Received: by 2002:a05:600c:c111:b0:485:3a03:cee1 with SMTP id
 5b1f17b1804b1-486ff02119bmr33158625e9.33.1774014181728; 
 Fri, 20 Mar 2026 06:43:01 -0700 (PDT)
Received: from jw-ThinkPad-T14-Gen-3.home (236.139.189.80.dyn.plus.net.
 [80.189.139.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe85ed6asm18328885e9.1.2026.03.20.06.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:43:01 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 Emmanuel Blot <eblot@rivosinc.com>,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v5 1/3] util: export CRC32[C] lookup tables
Date: Fri, 20 Mar 2026 13:42:52 +0000
Message-ID: <20260320134254.217123-2-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260320134254.217123-1-james.wainwright@lowrisc.org>
References: <20260320134254.217123-1-james.wainwright@lowrisc.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Emmanuel Blot <eblot@rivosinc.com>

These are needed for the xlrbr CRC32 instructions which pre-XOR the data
into the CRC state before the instruction is executed, making the zlib
crc32 and QEMU crc32c implementations inappropriate.

https://github.com/riscv/riscv-bitmanip/releases/download/v0.93/bitmanip-0.93.pdf

Signed-off-by: James Wainwright <james.wainwright@lowrisc.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/qemu/crc32.h  | 14 ++++++++
 include/qemu/crc32c.h |  1 +
 util/crc32.c          | 81 +++++++++++++++++++++++++++++++++++++++++++
 util/crc32c.c         |  4 +--
 util/meson.build      |  1 +
 5 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 include/qemu/crc32.h
 create mode 100644 util/crc32.c

diff --git a/include/qemu/crc32.h b/include/qemu/crc32.h
new file mode 100644
index 0000000000..9824a8cb5d
--- /dev/null
+++ b/include/qemu/crc32.h
@@ -0,0 +1,14 @@
+/*
+ * CRC32 Checksum
+ *
+ * Copyright (c) 2026 QEMU contributors
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_CRC32_H
+#define QEMU_CRC32_H
+
+extern const uint32_t crc32_table[256];
+
+#endif
diff --git a/include/qemu/crc32c.h b/include/qemu/crc32c.h
index 88b4d2b3b3..3d5ba189ef 100644
--- a/include/qemu/crc32c.h
+++ b/include/qemu/crc32c.h
@@ -28,6 +28,7 @@
 #ifndef QEMU_CRC32C_H
 #define QEMU_CRC32C_H
 
+extern const uint32_t crc32c_table[256];
 
 uint32_t crc32c(uint32_t crc, const uint8_t *data, unsigned int length);
 uint32_t iov_crc32c(uint32_t crc, const struct iovec *iov, size_t iov_cnt);
diff --git a/util/crc32.c b/util/crc32.c
new file mode 100644
index 0000000000..a0f91ff09c
--- /dev/null
+++ b/util/crc32.c
@@ -0,0 +1,81 @@
+/*
+ * Constants for computing CRC32 checksums
+ *
+ * Copyright (c) 2026 QEMU contributors
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/crc32.h"
+
+/*
+ * CRC-32 table (reversed; polynomial 0xEDB88320).
+ */
+
+const uint32_t crc32_table[256] = {
+    0x00000000u, 0x77073096u, 0xee0e612cu, 0x990951bau,
+    0x076dc419u, 0x706af48fu, 0xe963a535u, 0x9e6495a3u,
+    0x0edb8832u, 0x79dcb8a4u, 0xe0d5e91eu, 0x97d2d988u,
+    0x09b64c2bu, 0x7eb17cbdu, 0xe7b82d07u, 0x90bf1d91u,
+    0x1db71064u, 0x6ab020f2u, 0xf3b97148u, 0x84be41deu,
+    0x1adad47du, 0x6ddde4ebu, 0xf4d4b551u, 0x83d385c7u,
+    0x136c9856u, 0x646ba8c0u, 0xfd62f97au, 0x8a65c9ecu,
+    0x14015c4fu, 0x63066cd9u, 0xfa0f3d63u, 0x8d080df5u,
+    0x3b6e20c8u, 0x4c69105eu, 0xd56041e4u, 0xa2677172u,
+    0x3c03e4d1u, 0x4b04d447u, 0xd20d85fdu, 0xa50ab56bu,
+    0x35b5a8fau, 0x42b2986cu, 0xdbbbc9d6u, 0xacbcf940u,
+    0x32d86ce3u, 0x45df5c75u, 0xdcd60dcfu, 0xabd13d59u,
+    0x26d930acu, 0x51de003au, 0xc8d75180u, 0xbfd06116u,
+    0x21b4f4b5u, 0x56b3c423u, 0xcfba9599u, 0xb8bda50fu,
+    0x2802b89eu, 0x5f058808u, 0xc60cd9b2u, 0xb10be924u,
+    0x2f6f7c87u, 0x58684c11u, 0xc1611dabu, 0xb6662d3du,
+    0x76dc4190u, 0x01db7106u, 0x98d220bcu, 0xefd5102au,
+    0x71b18589u, 0x06b6b51fu, 0x9fbfe4a5u, 0xe8b8d433u,
+    0x7807c9a2u, 0x0f00f934u, 0x9609a88eu, 0xe10e9818u,
+    0x7f6a0dbbu, 0x086d3d2du, 0x91646c97u, 0xe6635c01u,
+    0x6b6b51f4u, 0x1c6c6162u, 0x856530d8u, 0xf262004eu,
+    0x6c0695edu, 0x1b01a57bu, 0x8208f4c1u, 0xf50fc457u,
+    0x65b0d9c6u, 0x12b7e950u, 0x8bbeb8eau, 0xfcb9887cu,
+    0x62dd1ddfu, 0x15da2d49u, 0x8cd37cf3u, 0xfbd44c65u,
+    0x4db26158u, 0x3ab551ceu, 0xa3bc0074u, 0xd4bb30e2u,
+    0x4adfa541u, 0x3dd895d7u, 0xa4d1c46du, 0xd3d6f4fbu,
+    0x4369e96au, 0x346ed9fcu, 0xad678846u, 0xda60b8d0u,
+    0x44042d73u, 0x33031de5u, 0xaa0a4c5fu, 0xdd0d7cc9u,
+    0x5005713cu, 0x270241aau, 0xbe0b1010u, 0xc90c2086u,
+    0x5768b525u, 0x206f85b3u, 0xb966d409u, 0xce61e49fu,
+    0x5edef90eu, 0x29d9c998u, 0xb0d09822u, 0xc7d7a8b4u,
+    0x59b33d17u, 0x2eb40d81u, 0xb7bd5c3bu, 0xc0ba6cadu,
+    0xedb88320u, 0x9abfb3b6u, 0x03b6e20cu, 0x74b1d29au,
+    0xead54739u, 0x9dd277afu, 0x04db2615u, 0x73dc1683u,
+    0xe3630b12u, 0x94643b84u, 0x0d6d6a3eu, 0x7a6a5aa8u,
+    0xe40ecf0bu, 0x9309ff9du, 0x0a00ae27u, 0x7d079eb1u,
+    0xf00f9344u, 0x8708a3d2u, 0x1e01f268u, 0x6906c2feu,
+    0xf762575du, 0x806567cbu, 0x196c3671u, 0x6e6b06e7u,
+    0xfed41b76u, 0x89d32be0u, 0x10da7a5au, 0x67dd4accu,
+    0xf9b9df6fu, 0x8ebeeff9u, 0x17b7be43u, 0x60b08ed5u,
+    0xd6d6a3e8u, 0xa1d1937eu, 0x38d8c2c4u, 0x4fdff252u,
+    0xd1bb67f1u, 0xa6bc5767u, 0x3fb506ddu, 0x48b2364bu,
+    0xd80d2bdau, 0xaf0a1b4cu, 0x36034af6u, 0x41047a60u,
+    0xdf60efc3u, 0xa867df55u, 0x316e8eefu, 0x4669be79u,
+    0xcb61b38cu, 0xbc66831au, 0x256fd2a0u, 0x5268e236u,
+    0xcc0c7795u, 0xbb0b4703u, 0x220216b9u, 0x5505262fu,
+    0xc5ba3bbeu, 0xb2bd0b28u, 0x2bb45a92u, 0x5cb36a04u,
+    0xc2d7ffa7u, 0xb5d0cf31u, 0x2cd99e8bu, 0x5bdeae1du,
+    0x9b64c2b0u, 0xec63f226u, 0x756aa39cu, 0x026d930au,
+    0x9c0906a9u, 0xeb0e363fu, 0x72076785u, 0x05005713u,
+    0x95bf4a82u, 0xe2b87a14u, 0x7bb12baeu, 0x0cb61b38u,
+    0x92d28e9bu, 0xe5d5be0du, 0x7cdcefb7u, 0x0bdbdf21u,
+    0x86d3d2d4u, 0xf1d4e242u, 0x68ddb3f8u, 0x1fda836eu,
+    0x81be16cdu, 0xf6b9265bu, 0x6fb077e1u, 0x18b74777u,
+    0x88085ae6u, 0xff0f6a70u, 0x66063bcau, 0x11010b5cu,
+    0x8f659effu, 0xf862ae69u, 0x616bffd3u, 0x166ccf45u,
+    0xa00ae278u, 0xd70dd2eeu, 0x4e048354u, 0x3903b3c2u,
+    0xa7672661u, 0xd06016f7u, 0x4969474du, 0x3e6e77dbu,
+    0xaed16a4au, 0xd9d65adcu, 0x40df0b66u, 0x37d83bf0u,
+    0xa9bcae53u, 0xdebb9ec5u, 0x47b2cf7fu, 0x30b5ffe9u,
+    0xbdbdf21cu, 0xcabac28au, 0x53b39330u, 0x24b4a3a6u,
+    0xbad03605u, 0xcdd70693u, 0x54de5729u, 0x23d967bfu,
+    0xb3667a2eu, 0xc4614ab8u, 0x5d681b02u, 0x2a6f2b94u,
+    0xb40bbe37u, 0xc30c8ea1u, 0x5a05df1bu, 0x2d02ef8du
+};
diff --git a/util/crc32c.c b/util/crc32c.c
index ea7f345de8..f40597f80d 100644
--- a/util/crc32c.c
+++ b/util/crc32c.c
@@ -1,7 +1,7 @@
 /*
  *  Castagnoli CRC32C Checksum Algorithm
  *
- *  Polynomial: 0x11EDC6F41
+ *  Polynomial: 0x1EDC6F41
  *
  *  Castagnoli93: Guy Castagnoli and Stefan Braeuer and Martin Herrman
  *               "Optimization of Cyclic Redundancy-Check Codes with 24
@@ -37,7 +37,7 @@
  * reflect output bytes = true
  */
 
-static const uint32_t crc32c_table[256] = {
+const uint32_t crc32c_table[256] = {
     0x00000000L, 0xF26B8303L, 0xE13B70F7L, 0x1350F3F4L,
     0xC79A971FL, 0x35F1141CL, 0x26A1E7E8L, 0xD4CA64EBL,
     0x8AD958CFL, 0x78B2DBCCL, 0x6BE22838L, 0x9989AB3BL,
diff --git a/util/meson.build b/util/meson.build
index e7a2a2a64c..d5789b1316 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -44,6 +44,7 @@ util_ss.add(files('id.c'))
 util_ss.add(files('qemu-config.c', 'notify.c'))
 util_ss.add(files('qemu-option.c', 'qemu-progress.c'))
 util_ss.add(files('keyval.c'))
+util_ss.add(files('crc32.c'))
 util_ss.add(files('crc32c.c'))
 util_ss.add(files('uuid.c'))
 util_ss.add(files('getauxval.c'))
-- 
2.48.1


