Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048A8C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uO-0005Ev-NU; Fri, 14 Mar 2025 09:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uK-0005DG-Ve
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:17:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uF-00018M-69
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:17:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so18745705e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958214; x=1742563014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IOqXwb1Gpfc1XLtrVTEu1MEyCUJmn6mHT6hEbN78jvs=;
 b=pmzhFSEAih5g/xczqCIpzxG1nKrhbN1uc3iFOEIzEtm8LZKF0fJViIdMFymYyfwZkj
 pEhB0OIJi2UVuLJf0SGMJFhXiNTl46JIzTGAUVIVTcb/ssDP8c8OZeLpnoUGK9A8RM4+
 z8Kmu1UCSMY7PNJm5BYfmqd5W7FF2V2wcE1NqGbSSoNYgOSWyakPsGEO5xRmm4LReVAg
 9vceQYVqk7rHSv+t9qjvw8kIAdaab18EJXZOxh5x/bHN/R2j32lHabEwWxtw1WW1BspE
 nePMbmY+6BJesXFFLgOzJ0KjqxbMgmj424A92QvX0Wi1t0/ObbluHuv9rnvUqt8UnkgL
 6CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958214; x=1742563014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOqXwb1Gpfc1XLtrVTEu1MEyCUJmn6mHT6hEbN78jvs=;
 b=ATU2zxe7Pht9/EoODUFdOQP6eKEB097ymc6SOC1e6wU6siBD4pL7HBIfODatcbTPvD
 S69+5K5dUDh/dd5W8lrGabF5tN9Nn4TqLdYe4niiN1MvqRJPs3aAgbb7WMbkoL7DovSi
 PtXDTd5S60efnCW9sDz4ap6tQ+K5u5cp+GgNUtZoUdVqB7gpV8EUkUEb33g/RE2G6bUJ
 TWU563JhS+JEEhzAFquPxp23u25QsH5zuSjUakBXBDW/66cxywUFvytDFVgcNoede1aV
 3+kMVqKJcGkis9SfNZbd6NGaiNeAWyoQ8e6XeOkuy+riL2yEHNXSBqqYn8i1tGIXJSiL
 ZBfg==
X-Gm-Message-State: AOJu0YxRNIlP6JL1RkUhVgntC2dXfiLT4YN7Uu8PxDdNwyt3Gi37Rnc7
 EBQhbIMapZ2MVymL8Oc3y1jwK69Z7oxhV5od9rFcksTRgkCAe+Nz7oulehf00Kq1uoyzzUMorgR
 i
X-Gm-Gg: ASbGncv3ztbfeFeH6JV5RztyEwUYMUvElnW7zvkzXeoCZw4/hjeX357sYyBl1MLU8En
 hjhDO9kzk91n7dK2x0FQQutcEDOXBRHg0NIMOy27V9Hkg6VodHCz8He7BngRsgbeG4dXAjK+0ts
 bLmbrde4T8owaT2xRHhRJE9d1jI6//LHYxxf98zKYhQw3orEn7/Is14I502Yw7L2np5DxM57KDV
 TdbiOE2WrErAgjPHpsgBlhbn+WHz7lOpEjJ/K+p5JRpFlMazrmmqcYHAlxV7oMN2x5aW/jQBkiE
 fs4NU77H3zo98XYXptOJdV0FKKVeD3PB7Z0JkxtQxOrSZ9ASUz4=
X-Google-Smtp-Source: AGHT+IHu5kHtE2GshdUhLH2hJccDSGLw/KJ/14Wo7Jvtt2ATF8YWTQmjsAxQRrdHN1UcXJ4LErDGlQ==
X-Received: by 2002:a05:600c:470e:b0:43c:f4df:4870 with SMTP id
 5b1f17b1804b1-43d1ecd0eb5mr27301665e9.25.1741958213600; 
 Fri, 14 Mar 2025 06:16:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/17] util/cacheflush: Make first DSB unconditional on aarch64
Date: Fri, 14 Mar 2025 13:16:34 +0000
Message-ID: <20250314131637.371866-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Joe Komlodi <komlodi@google.com>

On ARM hosts with CTR_EL0.DIC and CTR_EL0.IDC set, this would only cause
an ISB to be executed during cache maintenance, which could lead to QEMU
executing TBs containing garbage instructions.

This seems to be because the ISB finishes executing instructions and
flushes the pipeline, but the ISB doesn't guarantee that writes from the
executed instructions are committed. If a small enough TB is created, it's
possible that the writes setting up the TB aren't committed by the time the
TB is executed.

This function is intended to be a port of the gcc implementation
(https://github.com/gcc-mirror/gcc/blob/85b46d0795ac76bc192cb8f88b646a647acf98c1/libgcc/config/aarch64/sync-cache.c#L67)
which makes the first DSB unconditional, so we can fix the synchronization
issue by doing that as well.

Cc: qemu-stable@nongnu.org
Fixes: 664a79735e4deb1 ("util: Specialize flush_idcache_range for aarch64")
Signed-off-by: Joe Komlodi <komlodi@google.com>
Message-id: 20250310203622.1827940-2-komlodi@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/cacheflush.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/cacheflush.c b/util/cacheflush.c
index a08906155a9..1d12899a392 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -279,9 +279,11 @@ void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
         for (p = rw & -dcache_lsize; p < rw + len; p += dcache_lsize) {
             asm volatile("dc\tcvau, %0" : : "r" (p) : "memory");
         }
-        asm volatile("dsb\tish" : : : "memory");
     }
 
+    /* DSB unconditionally to ensure any outstanding writes are committed. */
+    asm volatile("dsb\tish" : : : "memory");
+
     /*
      * If CTR_EL0.DIC is enabled, Instruction cache cleaning to the Point
      * of Unification is not required for instruction to data coherence.
-- 
2.43.0


