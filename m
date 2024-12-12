Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1274DE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjtq-0003ez-0E; Thu, 12 Dec 2024 09:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjtn-0003eg-M5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:10:40 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjtk-0002fH-NZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:10:38 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385df53e559so539260f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734012635; x=1734617435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrZRzKLnqM0xHROTlyJJVw5HS0SnJ0v+L1SXG1iynS0=;
 b=HWEb2DjliFW7Bi6Z+4NhB3XktL43dR70ohq4xDUWhVJkCFGdmVdcV94Z49fztcZTME
 9tsWJ+eJjdgWC5DLJq3FLS2zoWyc5aIrV10fRLW3Bvgb78m1UBwiQk+QJs3q53dEw6ru
 dYumw555xcC9w9uNJtzyjVcfBmBE+RkJQITc6LtO2H+bC+E8qv5jtLZby3jAkBlm5OST
 d3yZkpCkxEf3xb1bh5vI3i4Ik+bJwlcRgqMIQwYggbuRtp7bvdyLI9tsCqQM9pwryBO9
 nUfTGZu7/3/Ch8AWBEoLFaHgTNUjx2nuVIUBPDRFI4hJ9TvPa6b1ukIYEaNAsfkGJoIG
 H5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012635; x=1734617435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrZRzKLnqM0xHROTlyJJVw5HS0SnJ0v+L1SXG1iynS0=;
 b=YLDZWJ5h0z6dgsNzYjsGlfhfag5EYWdTHzjH03ptYGtCxxP8aKyST0Qiv96PvCI5jz
 VanCT1DwCFTRz/Xwo3zkgFlEVJ6KwjH9k3squQuBdbQJ8Hc8hygTf9RQS8SVWy5W+3j5
 7jWtJmgEy47FY+zl37L3vdAC9lOJb/CNLOymntOAJz016oTjE+X25f/TygHLsP9iwMof
 Xza3aYwxlqq3dWCnpfUwNsU+5PEddM6u4E8E7XlsdzjNQc3eq3ZJyYqlsE+hu2J9dJlr
 Fnf2WDuCpTgyGnWjMuDi1RH6ABl/8xpY5EUYugQrQG/RnCX01L+Xw/Q8GzcZufrUGZSZ
 D2cQ==
X-Gm-Message-State: AOJu0Yw67v4RWo8GOQ5QryzbHREkX4tfTi/3dfbo5a7plDsV8Oeuqj9+
 iWhg0Av35P6sAGImnWW9EIzwiP389vrOSgY9hZN1Ls2cSNx7DJb9NfDVcO3PLi6195n+oymxN77
 Q
X-Gm-Gg: ASbGncsbHxrzYwRrVlk7mlis6Vq43+g1ih42arUg0HaDM2I+VypKBDnINN1aUtHD68q
 l37p960oNmM8thB99skvIY36kKMLI6tLH5NQB5nBexFaOlwevo7hPW/KBlFs6a0xZCyCazsc4xx
 G8KDFw3ykIfDZxdQHd+5VyfAebOqOgbIF/e75x5Nd2mlcjJ7W7Cx4+lxV6W0I3dA1Zx1+QBp5MP
 4AsfLb7py8rVmmcHrRoOd5Zq3v5m7JhnRPPFaPHbzqwGWQyOSi8lOiEtX88GiqnNuJsS4i/a0hW
 KyAj4C/fFom6AUztCtY9zzdKpT4ro3c=
X-Google-Smtp-Source: AGHT+IGz5geTDK2ixr6fcb/WMztYmqkhPpF8Utc7kGl0sT8oOC30XtjF+6/GsySgQrNY6LVKANSWXg==
X-Received: by 2002:a05:6000:1543:b0:386:1cd3:8a08 with SMTP id
 ffacd0b85a97d-38787685025mr3415528f8f.5.1734012633693; 
 Thu, 12 Dec 2024 06:10:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514c11sm4172749f8f.76.2024.12.12.06.10.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 06:10:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] qemu/atomic: Rename atomic128-ldst.h headers using .h.inc
 suffix
Date: Thu, 12 Dec 2024 15:10:17 +0100
Message-ID: <20241212141018.59428-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212141018.59428-1-philmd@linaro.org>
References: <20241212141018.59428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename 'atomic128-ldst.h' as 'atomic128-ldst.h.inc'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/atomic128.h                                        | 2 +-
 .../aarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc}     | 0
 .../generic/host/{atomic128-ldst.h => atomic128-ldst.h.inc}     | 0
 .../loongarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} | 0
 .../x86_64/host/{atomic128-ldst.h => atomic128-ldst.h.inc}      | 2 +-
 host/include/x86_64/host/load-extract-al16-al8.h.inc            | 2 +-
 6 files changed, 3 insertions(+), 3 deletions(-)
 rename host/include/aarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/generic/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/loongarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/x86_64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (96%)

diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index 03c27022f0c..448fb644799 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -59,6 +59,6 @@
  */
 
 #include "host/atomic128-cas.h.inc"
-#include "host/atomic128-ldst.h"
+#include "host/atomic128-ldst.h.inc"
 
 #endif /* QEMU_ATOMIC128_H */
diff --git a/host/include/aarch64/host/atomic128-ldst.h b/host/include/aarch64/host/atomic128-ldst.h.inc
similarity index 100%
rename from host/include/aarch64/host/atomic128-ldst.h
rename to host/include/aarch64/host/atomic128-ldst.h.inc
diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h.inc
similarity index 100%
rename from host/include/generic/host/atomic128-ldst.h
rename to host/include/generic/host/atomic128-ldst.h.inc
diff --git a/host/include/loongarch64/host/atomic128-ldst.h b/host/include/loongarch64/host/atomic128-ldst.h.inc
similarity index 100%
rename from host/include/loongarch64/host/atomic128-ldst.h
rename to host/include/loongarch64/host/atomic128-ldst.h.inc
diff --git a/host/include/x86_64/host/atomic128-ldst.h b/host/include/x86_64/host/atomic128-ldst.h.inc
similarity index 96%
rename from host/include/x86_64/host/atomic128-ldst.h
rename to host/include/x86_64/host/atomic128-ldst.h.inc
index 8d6f909d3c9..4c698e3246f 100644
--- a/host/include/x86_64/host/atomic128-ldst.h
+++ b/host/include/x86_64/host/atomic128-ldst.h.inc
@@ -69,7 +69,7 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
 }
 #else
 /* Provide QEMU_ERROR stubs. */
-#include "host/include/generic/host/atomic128-ldst.h"
+#include "host/include/generic/host/atomic128-ldst.h.inc"
 #endif
 
 #endif /* X86_64_ATOMIC128_LDST_H */
diff --git a/host/include/x86_64/host/load-extract-al16-al8.h.inc b/host/include/x86_64/host/load-extract-al16-al8.h.inc
index baa506b7b5b..b837c378684 100644
--- a/host/include/x86_64/host/load-extract-al16-al8.h.inc
+++ b/host/include/x86_64/host/load-extract-al16-al8.h.inc
@@ -9,7 +9,7 @@
 #define X86_64_LOAD_EXTRACT_AL16_AL8_H
 
 #ifdef CONFIG_INT128_TYPE
-#include "host/atomic128-ldst.h"
+#include "host/atomic128-ldst.h.inc"
 
 /**
  * load_atom_extract_al16_or_al8:
-- 
2.45.2


