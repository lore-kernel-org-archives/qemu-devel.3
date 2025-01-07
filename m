Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5E4E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xj-0001Kc-JS; Tue, 07 Jan 2025 03:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Ws-0000Ez-M5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:35 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wq-0002vB-90
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:34 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2163b0c09afso219682265ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236890; x=1736841690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWOubo1yw/jMK9n7npaDQ/kdBR0LHc4+hHuxEbmZxkw=;
 b=AdkFjQNF5akTK7KcLglWf/XvjpMisrTwoQ8nrHBVXLu3LgOm5MLzcXlTpdNQhHt7HT
 8Wp78z39i3JCYEiGB5KpXZxnIaPdracIOhZm9bgSfmPGG8dBltjPr4ja54KdlXfwqV9B
 4KcZa6qZgl6Wv8CB03W0bJr1Lj5L1/sxJcmKhK22tYLs36vliYNDO8xHZ4e9QbckQdBL
 1QLCdvOb70ganj+7oDznp1doAvyp+exx4rtyPJuUb4aboby5XVquXqf35c00zFJKiKgz
 cd+OUQ9fNDPGDO2ZSPNPYBzfR6p+u8ioHGZSV1zOprOSee22NvC9hD9XHRZ3kQWZQnlp
 tL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236890; x=1736841690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWOubo1yw/jMK9n7npaDQ/kdBR0LHc4+hHuxEbmZxkw=;
 b=s8Dy3YLux9+7Lf5xYARkeorm51aVbnXNstySCNan7LK6K157MSze5uWSbDyUwYwfZV
 adAkCPapwiHtXIrLcABokqAia1dto4KTENd/H7NX8wAGfFLxdsu6NCx54LDv2g6fM7GT
 PYJ3Dcto7oDeUU6YIkjD1oNdzclWAvsLxPkm1wBK/8+4WcMKieEfQ3CaD6+OmBTxXzW1
 GMSobtBd+dS0Jh0fdZaZvBXqbmwS7dX1cwxA/tI0rbH3zzMwNLVNKCizGH9zHeFfOUFd
 lbPdGL46MbupaIIsOdJl94c9OVo3D6/uO/3Z/Na6vVSGG/33AWdfkRWxxdGK00IiDzSy
 jY7A==
X-Gm-Message-State: AOJu0YyzznMIedRA8z0GUcdbZwVsGgWptn5Njzm6+pyWbPfR2CcGbUYx
 1A/z7k81JI5MA/dSVpIYZH9p18Q1HgM/IpRpVZ8Fz+/1YGtBAd0NqgeZxKuYIdci32ZRzREmCFz
 L
X-Gm-Gg: ASbGncveeMr7LQOI/0tj+M13dK51CSgf4r1PpjobEujEYd8ByJosGRPIiBR4fCst3ym
 vynl+gNXhz8j/pvfWnh7TTpFcv+cWOT3EhWwKiyuDro9YGP6gtD9yensI4Zgur5DFZL1M1n2o0C
 t9LtqC7QN+Yz7/6AGz6o2P3J1qfTmhgu1iwbY8H/FUeAXcLY4XICDPPzKI/IbpwcawMWVk8vbyo
 ufa/vgOlvtGaZU7D6c0aNS6FRJ2QNTXet2YaFXJV//iI1DdOqfl55md8HpFTJ7JPL5NDDPxO9eo
 aN2PrlgoFYqdwpiOkQ==
X-Google-Smtp-Source: AGHT+IFyw6hwJgzAg+tHkniYDj9Ya9AVIYMRbethPZxdXPZnpzfHsD+FWcJOSJUj+MV6MawbOL+AEw==
X-Received: by 2002:a17:903:22c3:b0:216:2abc:194f with SMTP id
 d9443c01a7336-219e6f108famr1004288915ad.40.1736236890081; 
 Tue, 07 Jan 2025 00:01:30 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 15/81] tcg: Rename tcg-target.opc.h to tcg-target-opc.h.inc
Date: Tue,  7 Jan 2025 00:00:06 -0800
Message-ID: <20250107080112.1175095-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

In addition, add empty files for mips, sparc64 and tci.
Make the include unconditional within tcg-opc.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h                                      | 4 +---
 tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc}     | 0
 tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc}         | 0
 tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc}        | 0
 tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} | 0
 tcg/mips/tcg-target-opc.h.inc                              | 1 +
 tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc}         | 0
 tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc}       | 0
 tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc}       | 0
 tcg/sparc64/tcg-target-opc.h.inc                           | 1 +
 tcg/tci/tcg-target-opc.h.inc                               | 1 +
 11 files changed, 4 insertions(+), 3 deletions(-)
 rename tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 create mode 100644 tcg/mips/tcg-target-opc.h.inc
 rename tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 create mode 100644 tcg/sparc64/tcg-target-opc.h.inc
 create mode 100644 tcg/tci/tcg-target-opc.h.inc

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 546eb49c11..93622f3f6b 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -301,9 +301,7 @@ DEF(cmpsel_vec, 1, 4, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_cmpsel_vec))
 
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
-#if TCG_TARGET_MAYBE_vec
-#include "tcg-target.opc.h"
-#endif
+#include "tcg-target-opc.h.inc"
 
 #ifdef TCG_TARGET_INTERPRETER
 /* These opcodes are only for use between the tci generator and interpreter. */
diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/aarch64/tcg-target.opc.h
rename to tcg/aarch64/tcg-target-opc.h.inc
diff --git a/tcg/arm/tcg-target.opc.h b/tcg/arm/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/arm/tcg-target.opc.h
rename to tcg/arm/tcg-target-opc.h.inc
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/i386/tcg-target.opc.h
rename to tcg/i386/tcg-target-opc.h.inc
diff --git a/tcg/loongarch64/tcg-target.opc.h b/tcg/loongarch64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/loongarch64/tcg-target.opc.h
rename to tcg/loongarch64/tcg-target-opc.h.inc
diff --git a/tcg/mips/tcg-target-opc.h.inc b/tcg/mips/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..84e777bfe5
--- /dev/null
+++ b/tcg/mips/tcg-target-opc.h.inc
@@ -0,0 +1 @@
+/* No target specific opcodes. */
diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/ppc/tcg-target.opc.h
rename to tcg/ppc/tcg-target-opc.h.inc
diff --git a/tcg/riscv/tcg-target.opc.h b/tcg/riscv/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/riscv/tcg-target.opc.h
rename to tcg/riscv/tcg-target-opc.h.inc
diff --git a/tcg/s390x/tcg-target.opc.h b/tcg/s390x/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/s390x/tcg-target.opc.h
rename to tcg/s390x/tcg-target-opc.h.inc
diff --git a/tcg/sparc64/tcg-target-opc.h.inc b/tcg/sparc64/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..84e777bfe5
--- /dev/null
+++ b/tcg/sparc64/tcg-target-opc.h.inc
@@ -0,0 +1 @@
+/* No target specific opcodes. */
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..84e777bfe5
--- /dev/null
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -0,0 +1 @@
+/* No target specific opcodes. */
-- 
2.43.0


