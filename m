Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7344FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmm-0000lq-S9; Sat, 30 Aug 2025 11:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fR-0005wY-Ec
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:33:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fP-0004lo-Nz
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:33:57 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-772301f8a4cso1243681b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506834; x=1757111634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaHhTTN035qJQGqD9PdDzeeKvrzQJZLWIQNdo5Ia4sA=;
 b=gBUMcRQGPv1B30v+Z1yVnruEjzfVXAWMd46y2l/QjLN6ErmUiB++yOC2XfBHyIhfcf
 rHE4RpllK2hKVuyvEZak8o8Nbs3/pbBhXYhypV1zASIWO3NswBJ60TgaVwlhSJIKNjsM
 JyOetQX/RhkP5uKVqFBmePXSYmJYCOr91TL2ddfY4DecKheMSp1chIeXuGtOcW1tuWIX
 t4zOVpTwxFIJyGhcY18CP8EtDk8HnmPjbIdxp3hsd7cujle0ofYJ3TJzke4bUW9MZfWS
 39OugKfSDkdLUbtyxby8M08htyiv8d5UFuEdwK1MiKJdkjiGFtwWLEMzPllUEad7EZnI
 GttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506834; x=1757111634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaHhTTN035qJQGqD9PdDzeeKvrzQJZLWIQNdo5Ia4sA=;
 b=la9g2YU3JGU3zUPdKh+uxapgl72U/1EM80SD0o2A6TxkVDN2C306xFnAsE/D4OY7gd
 Y0zSpsYirIqx23st/TqXc1CHR8SPvjkzkQvjkCBvZTBdy+AzPFDsKFR6wOb2L3IxRZ4s
 ZTXe8h0E7PUFb5A9dC2g1xD4r4/fRiqx7zb/ie11eV2RxaLcig6zaNpmFrFilwtPdwQs
 npUgTq735CcuOARmKlAUPh/KT3xD1Cug6NMP/GU3xwmpOAv0c0buOuO7hHMvzDzO9zzn
 by6bMwnrZwqrYJBoPNz8/BvzAHRW62sKeA2dVeaJCrmh86Uj9jxEDbA5K2dtrxmeBNvI
 Sv0w==
X-Gm-Message-State: AOJu0YzrJMyRJArBw4Rl0lUIggamP38S6TJHRl+ZiIbTc1wa3183ZO+U
 xl+rwsLS06XiW9vXMCy8QVjkowdX3sT7awlumrCccXdMeLH8LWSzUTjg8RbQoKfsRFbL+37M/Uy
 GPswk1To=
X-Gm-Gg: ASbGnctZzvElyR2Ipu9XZba8k7Y0XrC6JbjJJkJyoDarXHxoq/+sMeCd41BlR1nCkeS
 HDp3UL5DY21aFBvb2rmnL9WnrVYwk5eaFT2ZVU2Dp6k9fJcYWG+ykcqbU+z9Q3+hXIYnTWqYhUQ
 qsg5FmPBIk8q3xI92JaaMWD9SuSt4dB7L7AXVNZ2Qw0YByWYk84sWPEp6Xx85bma4rCenISmFUl
 nsX3IjCqv6Tuto8TVWvVwGzCPSqBWbYi73g2Lf7X2IXOBh/s5iyRgpOFMvlqSxakf3jAxLH7PX3
 3MZ3kxbONFxka9CDDuk9pkrKcHM3O1il2E1HuGF5tYLvm3JziCR36wLNGg3cWeYiie85B4ORfqk
 fY+KfbzukirSXuw/H3zQ7nl8XmpLPohN5OfuWIMb4MMoIYR32vjKFN93LLiJ1
X-Google-Smtp-Source: AGHT+IGmseJGsTd0zgn/XlqafGxQhicGY1B7D+KmUsouVID7LDnS4KSLPcdeCXcFeFkpbCkJoJPXlA==
X-Received: by 2002:a05:6a00:2e08:b0:76b:f8ee:4eaa with SMTP id
 d2e1a72fcca58-7723e24ff0cmr277132b3a.9.1756506834292; 
 Fri, 29 Aug 2025 15:33:54 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:33:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 82/91] linux-user: Move elf parameters to xtensa/target_elf.h
Date: Sat, 30 Aug 2025 08:24:18 +1000
Message-ID: <20250829222427.289668-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/xtensa/target_elf.h | 3 +++
 linux-user/elfload.c           | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index 850a7206a5..0689e79be5 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -10,6 +10,9 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_XTENSA
+
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6732011332..804a819471 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_XTENSA
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_XTENSA
-
-#endif /* TARGET_XTENSA */
-
 #ifdef TARGET_HEXAGON
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


