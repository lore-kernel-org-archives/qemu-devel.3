Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B443CC3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oAt-00023I-JW; Mon, 07 Apr 2025 11:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nlb-00026l-Pd; Mon, 07 Apr 2025 10:48:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nlY-0001fI-Se; Mon, 07 Apr 2025 10:48:02 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so3590748b3a.1; 
 Mon, 07 Apr 2025 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037278; x=1744642078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeWm4gdwYX7Mpk2+jTOfSOTsV04a2XRASVxxD/NFs3U=;
 b=E7GuQnqrCdwldobpvMkDfYiE3uyx6UTnZ8LQ94ahtxm+q+w3GDZtXtPglzKGs9GqJt
 AItUsWC/4p2VbIOCveCcoCeZOg5X0IAQnbJhAeioDt9yOQBq/yGSMEXCaeaNICpf9bus
 FTmd7DZ17eWdxQiQt40Y/a7s5+YyHrXuhXvDVip/wrqWJ85iRU1du3JECgsbu2UJ5bdx
 gqJufL0NC/TbZhBC3cLVPHUxOtevM6zJUWGPCYmkHWz1VtBEc53wuS67k5Jm/fVJxGL8
 OIpRAmoPojDu60i0ZrXc5fYoMHu+BHzZHqnHe5PY1n6WtFVczKDBgLxesXJfCOuus+tN
 QSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037278; x=1744642078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeWm4gdwYX7Mpk2+jTOfSOTsV04a2XRASVxxD/NFs3U=;
 b=vpmmgE7qDngqrH8qaAKGea2vxxsGTWWy43lP+KzuaP3nnAEXdgtejMMXVpgLPZRymv
 Lm83nxBO/0r3mW6neiHRInypIlklw5xNtFeVTqpUNqrxj3XX9gQ8S4LIDc+3pEatGtdx
 JPDkFvDSHYfXgKkbQe5sh7fXvKTh57HyVo58l1jW0g7+KYMq7z21U6Xd9KkvNPRJFM/C
 zcBtEGlhI2DpQ5hcWTV4tlIP7+7xhazXKY6/rK8ZVuthF0/jxtEndCIreruzmHPLp0dR
 +TMMj3W69NFsQOypBGvj0Lt6NZrQ5s6eQ6h+hf9BxmeGq4pNvhHt0trwwxjR3G+bwjTv
 1lTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU625ZzH1QO6t+jxam0xhfwNKBGj9tKGML+IPBmnKCVhZvH1GH0RlsLBCv9NJLdU4aCtbxOPMnnIEIbog==@nongnu.org,
 AJvYcCXaYblZh8A8drnrBf0vdrbSsY/UMcVzKunWv0iuHvlFyEpCHaOMQBCHHqngoZNWmuyQL+2mOeBcPQ==@nongnu.org,
 AJvYcCXpWoQd5UYKBU2z4EhVReARiKiE7Qn/KW+sWj/i8SjciUcUP/jKoZ8AYSjVIvv0tPS468y9eR2t0o83lw==@nongnu.org
X-Gm-Message-State: AOJu0Yys99BiE4RlmH68PVND3M1TvMCUjp1MFp0TnmjEWHJdGfYfwQ3T
 BnpDfQQx+vjY4a9TJIkESl529ua2PURxel/qqbxTUxJGMg3KstQAQlwRCVae
X-Gm-Gg: ASbGncuhjhJDaY6st86z7/QhP35ppMBeFeRD+vSklQnGPGlqaerDkcfv2HSrHwkFBm4
 +AqTvXmt23WjGwqA7gWwXCraIMA05KP+VnIKWPCOFUFTfnfILZTnYo7X6vV93YlmIf3oWsyk9Wd
 uprsUqymqGSimemjggWtKHbVqwzPm9UsTC8lPX50nkKYk3hJxYBfRe5nVybivpfaybljlFQXwbL
 B4a3D8auavo6vlg2r/C4kCLcKlN/pF9/b96BpmYVzTiPsIX/xq4NAar/EoObzDXcHX3Hwbh4nlZ
 yQk8L/FkWqdjC5pKuuj0IEu7IQojCHSaacn26h87stjucguf5Yff0ZhpaAyMrCAACYC/N0fG
X-Google-Smtp-Source: AGHT+IFK5Snnwez+9Z1jA55NI18ZTP1BoHatw9I8udhAd9+QfwRAfkorXPb+OzP1TByBPcIzR0wn1A==
X-Received: by 2002:a05:6a21:788f:b0:1f5:619a:8f73 with SMTP id
 adf61e73a8af0-20104735fdemr18035606637.26.1744037278135; 
 Mon, 07 Apr 2025 07:47:58 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:8768:486:6a8e:e855])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ef3c2sm8856960b3a.59.2025.04.07.07.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:47:57 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 03/10] util/mmap-alloc: Add qemu_ram_mmap implementation for
 emscripten
Date: Mon,  7 Apr 2025 23:45:54 +0900
Message-Id: <8c2b176bd4c499233a88dcd18e62d8cf94e08f56.1744032780.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744032780.git.ktokunaga.mail@gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 11:14:07 -0400
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

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 util/mmap-alloc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index ed14f9c64d..91f33682e8 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -145,6 +145,7 @@ static bool map_noreserve_effective(int fd, uint32_t qemu_map_flags)
     return false;
 }
 
+#ifndef EMSCRIPTEN
 /*
  * Reserve a new memory region of the requested size to be used for mapping
  * from the given fd (if any).
@@ -176,6 +177,7 @@ static void *mmap_reserve(size_t size, int fd)
 
     return mmap(0, size, PROT_NONE, flags, fd, 0);
 }
+#endif
 
 /*
  * Activate memory in a reserved region from the given fd (if any), to make
@@ -244,6 +246,21 @@ static inline size_t mmap_guard_pagesize(int fd)
 #endif
 }
 
+#ifdef EMSCRIPTEN
+void *qemu_ram_mmap(int fd,
+                    size_t size,
+                    size_t align,
+                    uint32_t qemu_map_flags,
+                    off_t map_offset)
+{
+    /*
+     * emscripten doesn't support non-zero first argument for mmap so
+     * mmap a larger region without the hint and return an aligned pointer.
+     */
+    void *ptr = mmap_activate(0, size + align, fd, qemu_map_flags, map_offset);
+    return (void *)QEMU_ALIGN_UP((uintptr_t)ptr, align);
+}
+#else
 void *qemu_ram_mmap(int fd,
                     size_t size,
                     size_t align,
@@ -293,6 +310,7 @@ void *qemu_ram_mmap(int fd,
 
     return ptr;
 }
+#endif /* EMSCRIPTEN */
 
 void qemu_ram_munmap(int fd, void *ptr, size_t size)
 {
-- 
2.25.1


