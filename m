Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B269CC54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWEc-0001LI-2K; Wed, 13 Mar 2024 17:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWEZ-0001KD-CU
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWEX-0007je-Qg
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:33:59 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33e8f906f3dso208539f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365636; x=1710970436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTsiFHK/uF9NgxMDORids06OFuVswudli5ZoOdNSsFQ=;
 b=Y6oYHtn+bMl+ot6cerwX657JfbR3QfYL/Uu03YQXoZnipC+f7H+jUkl1LqqiwMVwsQ
 LCRXqFe7Vy+nFFOJ2jSz5fCSidqJy1qhv8vwWqXcjWOdhJJ4jei+esIVocmOVNxiSNeW
 rPz9r4G7Brl1WnGw79iYCQb3u4yYyGu4w6UGjrUTh1mMZ28Bq3H1+nBa6gpUMXMD8SuN
 it/IrafvP6ICtcMOOdMjRgZzopl0jEDfEK7A3wIF8Q0P88RXquSkyOLpD5R6e9s8/P8i
 IOa3j8FyKY3HAowVeg5AT+Gc59xTP1NlkZLEG9kXgV3CZHE/J52C6eiOeAJLRoG7lDkC
 7Cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365636; x=1710970436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTsiFHK/uF9NgxMDORids06OFuVswudli5ZoOdNSsFQ=;
 b=NjvgNxC4cEsfoZy4QXVA65Q6W2dNfS6/tLh9Q3GIxlk94ob98i496aOIzU6jg6PHTN
 YcLGFP3iGkk5/8dnNZVev5Yp4LJonKiRzTv1fXRF+izdqZylf6cgCgC4ntfKkAPaBr1V
 mcV0xST+NdMcHb+6iIhF6Vv9WD7RSsnhKjyrZW8rsNq+AZnaktpz769CSztUex7hu+1U
 v/Um7p7psGjkqsyCw3d/SUL7k8o7eFJXOTKzAtpad/bSqbYFLCQnHHgoQCtHO6ujoYlM
 EzK3aEbsCV70zRlefHY9/AqKjTD4IFa5HFWlNpDh2eybRywy6IH4BGEZHk8gwBNKd2Hl
 8wiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg1a3ipugsjBoZ2D+R+V7v1XflDRp7T3MNIbdwZd4Vg48sgmXMQmNdfFHf+v/bZ4YIDE/d4aGpLDrKzt/5c2DWtyiN3OI=
X-Gm-Message-State: AOJu0Yy2dHXOMb+/sUPcSMY8W6v5tbxTx80kFE10B3jRuIE2v+32GKsW
 aOWFg4Afyw8ySeciGbtfutTQipUL4Mlxz6Z+Oln+ekmhniwdR1j9h3NxiD8PPfU=
X-Google-Smtp-Source: AGHT+IHr+4irDYSUYuGmE9r0OP+ToaNRWO1OWvg9+2yh587hghskU8qIrwYdnBrm111iMFxdZ/OUCg==
X-Received: by 2002:a5d:58c7:0:b0:33d:b2dd:7585 with SMTP id
 o7-20020a5d58c7000000b0033db2dd7585mr2385663wrf.9.1710365636529; 
 Wed, 13 Mar 2024 14:33:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a5d6452000000b0033e48db23bdsm60088wrw.100.2024.03.13.14.33.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:33:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH-for-9.0? 02/12] travis-ci: Rename SOFTMMU -> SYSTEM
Date: Wed, 13 Mar 2024 22:33:29 +0100
Message-ID: <20240313213339.82071-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since we *might* have user emulation with softmmu,
rename MAIN_SOFTMMU_TARGETS as MAIN_SYSTEM_TARGETS
to express 'system emulation targets'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .travis.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 76859d48da..597d151b80 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -35,7 +35,7 @@ env:
     - TEST_BUILD_CMD=""
     - TEST_CMD="make check V=1"
     # This is broadly a list of "mainline" system targets which have support across the major distros
-    - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+    - MAIN_SYSTEM_TARGETS="aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
     - CCACHE_SLOPPINESS="include_file_ctime,include_file_mtime"
     - CCACHE_MAXSIZE=1G
     - G_MESSAGES_DEBUG=error
@@ -114,7 +114,7 @@ jobs:
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --enable-fdt=system
-                  --target-list=${MAIN_SOFTMMU_TARGETS} --cxx=/bin/false"
+                  --target-list=${MAIN_SYSTEM_TARGETS} --cxx=/bin/false"
         - UNRELIABLE=true
 
     - name: "[ppc64] GCC check-tcg"
@@ -185,7 +185,7 @@ jobs:
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --enable-fdt=system
-                  --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
+                  --target-list=${MAIN_SYSTEM_TARGETS},s390x-linux-user"
         - UNRELIABLE=true
       script:
         - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
@@ -226,7 +226,7 @@ jobs:
           - genisoimage
       env:
         - CONFIG="--disable-containers --enable-fdt=system --audio-drv-list=sdl
-                  --disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
+                  --disable-user --target-list-exclude=${MAIN_SYSTEM_TARGETS}"
 
     - name: "[s390x] GCC (user)"
       arch: s390x
-- 
2.41.0


