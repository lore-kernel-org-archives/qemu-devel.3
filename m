Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CE2C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVED-0002hD-6H; Mon, 10 Mar 2025 00:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVE8-0002eX-Mm
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:58:56 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVE6-0008AM-O1
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:58:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224341bbc1dso35372125ad.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582733; x=1742187533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGwlDw5fL6/8/4sqaw9ZjtskhrLsqkJfziSvtmiyf9E=;
 b=C/dmSnoo/WaJwqv1MvGKpaZcIRy/+iYe73PGBeuXHt7fEZVcPRu3VP1DjJinKaKuG1
 8jGgHm/K3T04G9Gx4n2heD+Ij+qc0LmPGb4jED36fyF2uUWa2yS8tZAVoTqrgYqHRQen
 /MZyXK8hVI7OvG/OqDEl4RRIh6NaD6xfPpn3Q9gjjdim5R27yrms1bSzC07AROFSaZc6
 CPEFDx7+aRUfmj+tu44eaXWD3aiQ2KIRvtlKA/qGMTDOoLV/TPu/vSqfhy/kAP6WcyFH
 PDzdQ3v7DGbRt9CUMZse3ki2pcIrqINMe38C2LptuEN3SUfN7PaaSaW0WilHAGnTFRbJ
 SuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582733; x=1742187533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGwlDw5fL6/8/4sqaw9ZjtskhrLsqkJfziSvtmiyf9E=;
 b=PTuqWMTkcdTweoKisxVmHgCrfN+QdDjZ7Ir79PDIFiqejEUizxuA+gCAMl1qx57hXo
 F3aJlde+HZ45FptWWoR2O0BKDjmm39W9JWsjIDmjV5BwsjYyzCRsVbWKMG1tQIZsaeQj
 deTlMZvQPhoTwIXvhaAmoARUDfxFz6vzPvYOoe9hFT9sZM5Khu/rzTnse2Rt2ln9kYdm
 Bs/Eabh7z9XfkhNadLqN9cC3Rpf1/n9YVtJxUO95hSTnXlHjeKDz1RtcGLFQin5yWxYg
 fZ3YnGuqnc0OYXyCoK31HowmHc5ZTItc9xoJ2ojbLTzsQj4DLW75Fu4+d1c4LJTmArWH
 BHMQ==
X-Gm-Message-State: AOJu0Yw63f/CqKC2cvTDDj4PNRLv+KNaABeUPtPQ/afQ09ph/b9CJsWQ
 y8IFYYl9C5KAzE1Vy2oYgt9rVKhhz75xEi2wxei4HmlNSVVRAYNk0yaz1JvKYLZQYXjRFbAy+te
 4bGk=
X-Gm-Gg: ASbGncuggsP/mf6wd/vhszRRtYK+KlsLKi7ajSppyBykmzH52gUh2PiqevgSQFPB7NY
 yUqRUYWfM5Hs65NCffNp4qauJtoR7cG0my6sQ7Ph1BOC/YiCnqne4xFTP9nQGCDrsdsszel/h7p
 mSeWF9AL5VjjQe6+ZyYz2Cmh9LfaJmGpbp0n34RdSLY+IVnBIltwvtZ6y3bDPxQK5kjPMqBGbdg
 NyMN4AXjeQyCzU/BNZfVfxoNZrL6SqTVJjrcB7rHEXhE2yVnFMsqwCXYVWuaj3p3c1BQa0VdPrn
 R53StkxZ/VjJ1aDInCBbOThsPemqrXfOc9rK+f/7SJ2k
X-Google-Smtp-Source: AGHT+IF9OJp4stFJ9k/lsvOwoQRvqqkA/ZzdxglsajfWtO3On0dbMxz5MT0xvVfYC1mLC7gyZMGdug==
X-Received: by 2002:a05:6a00:13a9:b0:736:3be3:3d77 with SMTP id
 d2e1a72fcca58-736aaac69ddmr15637676b3a.16.1741582733352; 
 Sun, 09 Mar 2025 21:58:53 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:58:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 03/16] include: move target_words_bigendian() from tswap to
 bswap
Date: Sun,  9 Mar 2025 21:58:29 -0700
Message-Id: <20250310045842.2650784-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

This is needed for next commits (especially when implementing st/ld
primitives which will use this function).
As well, remove reference to TARGET_BIG_ENDIAN, as we are about to
remove this dependency.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/tswap.h | 11 -----------
 include/qemu/bswap.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index ecd4faef015..cc662cd8b54 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -10,17 +10,6 @@
 
 #include "qemu/bswap.h"
 
-/**
- * target_words_bigendian:
- * Returns true if the (default) endianness of the target is big endian,
- * false otherwise. Note that in target-specific code, you can use
- * TARGET_BIG_ENDIAN directly instead. On the other hand, common
- * code should normally never need to know about the endianness of the
- * target, so please do *not* use this function unless you know very well
- * what you are doing!
- */
-bool target_words_bigendian(void);
-
 /*
  * If we're in target-specific code, we can hard-code the swapping
  * condition, otherwise we have to do (slower) run-time checks.
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index b915835bead..ebf6f9e5f5c 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -1,6 +1,8 @@
 #ifndef BSWAP_H
 #define BSWAP_H
 
+#include <stdbool.h>
+
 #undef  bswap16
 #define bswap16(_x) __builtin_bswap16(_x)
 #undef  bswap32
@@ -8,6 +10,16 @@
 #undef  bswap64
 #define bswap64(_x) __builtin_bswap64(_x)
 
+/**
+ * target_words_bigendian:
+ * Returns true if the (default) endianness of the target is big endian,
+ * false otherwise.
+ * Common code should normally never need to know about the endianness of the
+ * target, so please do *not* use this function unless you know very well
+ * what you are doing!
+ */
+bool target_words_bigendian(void);
+
 static inline uint32_t bswap24(uint32_t x)
 {
     return (((x & 0x000000ffU) << 16) |
-- 
2.39.5


