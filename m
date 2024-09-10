Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCE5EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzxX-0008Vf-KM; Tue, 10 Sep 2024 08:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzxV-0008UR-NC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:27:01 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzxS-0003gs-Uc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:27:01 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d60e23b33so266562366b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725971216; x=1726576016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uebG3UYhZWjA7+RVa/FeUtQC5xM5kZiuSF2P1ZpvjPY=;
 b=mFvkNpYaRPF739WstR3d81mPj/wvuKP6dcuyNAoUtQfxxuW526fxCFiNl8WR7rZU5m
 WKj/mV2ApcpZoYejnHz212aUzF4PoC5NQCBMEukI6RrpIH0caDPgYSJmpilNg31Sq/hV
 aeRyUBt5m7Smqk77NBjovjfrptIRntHrIr09DlCuAFrZO5DvUF/l883hxMpLsidzolha
 9iskUMchD22qjn9vWh853j8UzYEh5jJTcStIlTyo/0FAKLxbryMsEMNrEsKW73WPpRkZ
 NKwSIV4ygeXI/Br9Iqms6pUAJ1gMhxViIqTjL0av7L4MCxhp5tmERmLit6VBrxoEw7GW
 ktaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971216; x=1726576016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uebG3UYhZWjA7+RVa/FeUtQC5xM5kZiuSF2P1ZpvjPY=;
 b=gKIieE8FyGNjbXqYj1jF4rM2M/IswJl3ZiVuP8EBa0K3RcIHUTdg9zFe6nlzXqXggp
 Ap5k9dwaNFFbC2It7mwIuoqKN1CiURyrIIaHsbaFg0PYE/73KdF7a9n/E8nnNfuNWntY
 yofFuieXZ74EcYuMO6Ohq0LRbjcxfRRUjsXS+E2L7VUlwvq7gkkob2T3FI1lOLGTLUVL
 eYmWV3AM1z46lyiG9qiUqvklGYqbU3bnyh85Z/ViD5+dgPY4BbaNsmUlelKAUSbfoD6p
 c243uczP1Fwadi1QZA5vueigZg4Pbh5VhzKIY5UkdOMKL+WOpwqhUsfFipgo6iESAWmN
 9tjQ==
X-Gm-Message-State: AOJu0YxA8RcasRPxJRDaUIg6la/IDA+NlrHvTkcVikheIrAr+n2n/pyV
 2rKgx1s2/YBvk7uVhtx+t0LXQT42ifvx9T2+yQOPF1aDQskao56WhKoHv7Py12IvRdTaY+Qemij
 6
X-Google-Smtp-Source: AGHT+IHeRgF9aNYORg7LaHogjpt8z/whO8P1EKBDHfsh7ZQ/2GUi4JkKm/bUpWSrzRjpGpTIUC4XWw==
X-Received: by 2002:a17:906:7951:b0:a8d:4f8e:f64d with SMTP id
 a640c23a62f3a-a8ffae0b9a5mr53263666b.54.1725971216565; 
 Tue, 10 Sep 2024 05:26:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d40cebsm472637466b.200.2024.09.10.05.26.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Sep 2024 05:26:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/5] license: Update deprecated SPDX tag GPL-2.0 to
 GPL-2.0-only
Date: Tue, 10 Sep 2024 14:26:18 +0200
Message-ID: <20240910122618.33056-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910122618.33056-1-philmd@linaro.org>
References: <20240910122618.33056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

The 'GPL-2.0' license identifier has been deprecated since license
list version 3.0 [1] and replaced by the 'GPL-2.0-only' tag [2].

[1] https://spdx.org/licenses/GPL-2.0.html
[2] https://spdx.org/licenses/GPL-2.0-only.html

Mechanical patch running:

  $ sed -i -e s/GPL-2.0/GPL-2.0-only/ \
    $(git grep -l 'SPDX-License-Identifier: GPL-2.0[ $]' \
        | egrep -v '^linux-headers|^include/standard-headers')

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/bootinfo.h                    | 2 +-
 hw/net/igb_regs.h                     | 2 +-
 include/qemu/crc-ccitt.h              | 2 +-
 tests/tcg/loongarch64/system/regdef.h | 2 +-
 linux-user/alpha/syscall.tbl          | 2 +-
 linux-user/alpha/syscallhdr.sh        | 2 +-
 linux-user/arm/syscallhdr.sh          | 2 +-
 linux-user/hppa/syscall.tbl           | 2 +-
 linux-user/hppa/syscallhdr.sh         | 2 +-
 linux-user/i386/syscallhdr.sh         | 2 +-
 linux-user/m68k/syscall.tbl           | 2 +-
 linux-user/m68k/syscallhdr.sh         | 2 +-
 linux-user/microblaze/syscall.tbl     | 2 +-
 linux-user/microblaze/syscallhdr.sh   | 2 +-
 linux-user/mips/syscall_o32.tbl       | 2 +-
 linux-user/mips/syscallhdr.sh         | 2 +-
 linux-user/mips64/syscall_n32.tbl     | 2 +-
 linux-user/mips64/syscall_n64.tbl     | 2 +-
 linux-user/mips64/syscallhdr.sh       | 2 +-
 linux-user/ppc/syscall.tbl            | 2 +-
 linux-user/ppc/syscallhdr.sh          | 2 +-
 linux-user/s390x/syscall.tbl          | 2 +-
 linux-user/s390x/syscallhdr.sh        | 2 +-
 linux-user/sh4/syscall.tbl            | 2 +-
 linux-user/sh4/syscallhdr.sh          | 2 +-
 linux-user/sparc/syscall.tbl          | 2 +-
 linux-user/sparc/syscallhdr.sh        | 2 +-
 linux-user/x86_64/syscallhdr.sh       | 2 +-
 linux-user/xtensa/syscall.tbl         | 2 +-
 linux-user/xtensa/syscallhdr.sh       | 2 +-
 scripts/kernel-doc                    | 2 +-
 31 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
index 0e6e3eea87..70c1dc0e8c 100644
--- a/hw/m68k/bootinfo.h
+++ b/hw/m68k/bootinfo.h
@@ -1,5 +1,5 @@
 /*
- * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ * SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
  *
  * Bootinfo tags from linux bootinfo.h and bootinfo-mac.h:
  * This is an easily parsable and extendable structure containing all
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index e5a47eab64..4dc4c31da2 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * This is copied + edited from kernel header files in
  * drivers/net/ethernet/intel/igb
diff --git a/include/qemu/crc-ccitt.h b/include/qemu/crc-ccitt.h
index 8918dafe07..ce28e29720 100644
--- a/include/qemu/crc-ccitt.h
+++ b/include/qemu/crc-ccitt.h
@@ -8,7 +8,7 @@
  *
  * From Linux kernel v5.10 include/linux/crc-ccitt.h
  *
- * SPDX-License-Identifier: GPL-2.0
+ * SPDX-License-Identifier: GPL-2.0-only
  */
 
 #ifndef CRC_CCITT_H
diff --git a/tests/tcg/loongarch64/system/regdef.h b/tests/tcg/loongarch64/system/regdef.h
index faa09b2377..b586b4e86d 100644
--- a/tests/tcg/loongarch64/system/regdef.h
+++ b/tests/tcg/loongarch64/system/regdef.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
diff --git a/linux-user/alpha/syscall.tbl b/linux-user/alpha/syscall.tbl
index 3000a2e8ee..3fa3ea436d 100644
--- a/linux-user/alpha/syscall.tbl
+++ b/linux-user/alpha/syscall.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for alpha
 #
diff --git a/linux-user/alpha/syscallhdr.sh b/linux-user/alpha/syscallhdr.sh
index 55cafe6abf..6da0c957e2 100644
--- a/linux-user/alpha/syscallhdr.sh
+++ b/linux-user/alpha/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/arm/syscallhdr.sh b/linux-user/arm/syscallhdr.sh
index 4c952b2cfb..692fd6a76e 100644
--- a/linux-user/arm/syscallhdr.sh
+++ b/linux-user/arm/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/hppa/syscall.tbl b/linux-user/hppa/syscall.tbl
index aabc37f8ca..6361e97974 100644
--- a/linux-user/hppa/syscall.tbl
+++ b/linux-user/hppa/syscall.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for parisc
 #
diff --git a/linux-user/hppa/syscallhdr.sh b/linux-user/hppa/syscallhdr.sh
index ac91a95762..bf1c1d4f30 100644
--- a/linux-user/hppa/syscallhdr.sh
+++ b/linux-user/hppa/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/i386/syscallhdr.sh b/linux-user/i386/syscallhdr.sh
index b2eca96db7..938a793d2a 100644
--- a/linux-user/i386/syscallhdr.sh
+++ b/linux-user/i386/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/m68k/syscall.tbl b/linux-user/m68k/syscall.tbl
index 79c2d24c89..98d90a3e53 100644
--- a/linux-user/m68k/syscall.tbl
+++ b/linux-user/m68k/syscall.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for m68k
 #
diff --git a/linux-user/m68k/syscallhdr.sh b/linux-user/m68k/syscallhdr.sh
index eeb4d01d34..39b11dd05e 100644
--- a/linux-user/m68k/syscallhdr.sh
+++ b/linux-user/m68k/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/microblaze/syscall.tbl b/linux-user/microblaze/syscall.tbl
index b11395a20c..04bbd854b5 100644
--- a/linux-user/microblaze/syscall.tbl
+++ b/linux-user/microblaze/syscall.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for microblaze
 #
diff --git a/linux-user/microblaze/syscallhdr.sh b/linux-user/microblaze/syscallhdr.sh
index f55dce8a62..b42b669154 100644
--- a/linux-user/microblaze/syscallhdr.sh
+++ b/linux-user/microblaze/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/mips/syscall_o32.tbl b/linux-user/mips/syscall_o32.tbl
index d560c467a8..9c3fe03bdc 100644
--- a/linux-user/mips/syscall_o32.tbl
+++ b/linux-user/mips/syscall_o32.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for mips
 #
diff --git a/linux-user/mips/syscallhdr.sh b/linux-user/mips/syscallhdr.sh
index 761e3e47dd..cd7043ef5a 100644
--- a/linux-user/mips/syscallhdr.sh
+++ b/linux-user/mips/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/mips64/syscall_n32.tbl b/linux-user/mips64/syscall_n32.tbl
index 9220909526..dc228e6b25 100644
--- a/linux-user/mips64/syscall_n32.tbl
+++ b/linux-user/mips64/syscall_n32.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for mips
 #
diff --git a/linux-user/mips64/syscall_n64.tbl b/linux-user/mips64/syscall_n64.tbl
index 9cd1c34f31..ddd59079ce 100644
--- a/linux-user/mips64/syscall_n64.tbl
+++ b/linux-user/mips64/syscall_n64.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for mips
 #
diff --git a/linux-user/mips64/syscallhdr.sh b/linux-user/mips64/syscallhdr.sh
index ed5a45165a..a4339b2041 100644
--- a/linux-user/mips64/syscallhdr.sh
+++ b/linux-user/mips64/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/ppc/syscall.tbl b/linux-user/ppc/syscall.tbl
index 8f052ff405..51f4efb199 100644
--- a/linux-user/ppc/syscall.tbl
+++ b/linux-user/ppc/syscall.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for powerpc
 #
diff --git a/linux-user/ppc/syscallhdr.sh b/linux-user/ppc/syscallhdr.sh
index 6c44e0eaad..6e8b93d673 100644
--- a/linux-user/ppc/syscallhdr.sh
+++ b/linux-user/ppc/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/s390x/syscall.tbl b/linux-user/s390x/syscall.tbl
index 0690263df1..f713903bcc 100644
--- a/linux-user/s390x/syscall.tbl
+++ b/linux-user/s390x/syscall.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # System call table for s390
 #
diff --git a/linux-user/s390x/syscallhdr.sh b/linux-user/s390x/syscallhdr.sh
index 85a99c48de..ac22d422b0 100755
--- a/linux-user/s390x/syscallhdr.sh
+++ b/linux-user/s390x/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/sh4/syscall.tbl b/linux-user/sh4/syscall.tbl
index 0b91499ebd..d0f7cdb42c 100644
--- a/linux-user/sh4/syscall.tbl
+++ b/linux-user/sh4/syscall.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for sh
 #
diff --git a/linux-user/sh4/syscallhdr.sh b/linux-user/sh4/syscallhdr.sh
index 080790556a..cb3a5de711 100644
--- a/linux-user/sh4/syscallhdr.sh
+++ b/linux-user/sh4/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/sparc/syscall.tbl b/linux-user/sparc/syscall.tbl
index e34cc30ef2..5eb04edc9a 100644
--- a/linux-user/sparc/syscall.tbl
+++ b/linux-user/sparc/syscall.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for sparc
 #
diff --git a/linux-user/sparc/syscallhdr.sh b/linux-user/sparc/syscallhdr.sh
index 34a99dc832..938a02bb48 100644
--- a/linux-user/sparc/syscallhdr.sh
+++ b/linux-user/sparc/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/x86_64/syscallhdr.sh b/linux-user/x86_64/syscallhdr.sh
index 182be52a74..988256b6c6 100644
--- a/linux-user/x86_64/syscallhdr.sh
+++ b/linux-user/x86_64/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/linux-user/xtensa/syscall.tbl b/linux-user/xtensa/syscall.tbl
index fd2f30227d..2900f53c54 100644
--- a/linux-user/xtensa/syscall.tbl
+++ b/linux-user/xtensa/syscall.tbl
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+# SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note
 #
 # system call numbers and entry vectors for xtensa
 #
diff --git a/linux-user/xtensa/syscallhdr.sh b/linux-user/xtensa/syscallhdr.sh
index eef0644c94..dc787fbbfe 100644
--- a/linux-user/xtensa/syscallhdr.sh
+++ b/linux-user/xtensa/syscallhdr.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 in="$1"
 out="$2"
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 240923d509..fec83f53ed 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1,5 +1,5 @@
 #!/usr/bin/env perl
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-only
 
 use warnings;
 use strict;
-- 
2.45.2


