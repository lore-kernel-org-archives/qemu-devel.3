Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3920C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76Cr-0002SI-0z; Tue, 22 Apr 2025 01:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76CM-00027G-5J; Tue, 22 Apr 2025 01:29:34 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76CJ-0007tw-M6; Tue, 22 Apr 2025 01:29:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-226185948ffso52631865ad.0; 
 Mon, 21 Apr 2025 22:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299768; x=1745904568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcMrqg+AK4CG6FhWc+/PAoET2DJRr80sNz7sCzalahY=;
 b=JWdkG5HoSkZVu0HI6hsSwEfSulS/xJVFeaXmBo0yerDtpuKDJwgf2CMHZbPMZyG1dP
 8+dz0dmSW2knSCv14bPDsDpbh3kRyXUHYTNxlZZIAao5lWaqjzdb5pQb23TkoTXAWBqP
 kE2q4P4dPyoMkNHN9s9km9IgeiHn3kruceXXLeAX1UMj7Hvr8USdNA6GoRCvhoUJA2WV
 5E8cXPrduDtXwoeCjoOUYvqw7o46kRG3BMsBxZMdoQ4j+3sC31kGrommitki+lGyvG0D
 rijOtxaFzMdwR4DyDU1ngVQRj8q+G5hBlyakgljJDU03GswSiDvWeqRZ9nseU1Y6LdO+
 Ldkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299768; x=1745904568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OcMrqg+AK4CG6FhWc+/PAoET2DJRr80sNz7sCzalahY=;
 b=WINKk/bLTf+aQQ/MO+G5mXD9kYLgfzXj70Z8ZHFOs98kD9+UkHDhlpGrx3uzzvKR6v
 fUVDzCr11/MXgJYYEVaBUkvrYHJ1Y+kAT8Tvr3VSntuQWRfP2Dc1rKeBnsJKhThL+Eoq
 ObQqmRBPTeMmcpQQoDDSVgd4v6Ptq+1reFtKO7tpT1XHX6+zpaXWQrStyoEC9xOhglD+
 ex0VxdNMw0mWxpQyVi/1opA8GqItqXjVzvHk4RqIjG6OHKP56cdEd0L+phAO+uq2AIsq
 26CCNGdfoIdHXBJWCCczQjzZmBwm/w0ddFxRBva9UmSTGxZfjeLk2qipthsDKxHEkOB3
 i+VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpK83syjOFQlgQcuRfk3P6vRwOTTvV/vBnFnhLnMbvMTmANzM6bc1+ftglF0BIN5q8qCAfR1PpojRssw==@nongnu.org,
 AJvYcCVs2qsE8AO/d6noQgPjNx/leDtNPZz4BTZdElK7KfyTAtUz2M+5nLCnawHd7d4ZLCN6JM7SheGbehw=@nongnu.org,
 AJvYcCW+Fh3Zurl6jgsqWPJAZzVlso/VP+Uqta1v2y9iKxYcG2E4x/rJ2XlwQhyIPeMRozj6zBRJ/w3ru5Cvog==@nongnu.org,
 AJvYcCXtqPvUDus8jsryyXvGHm82l4WKBbe3uOjeiD05ZCNf8mNEhmYmeVzuhAdi6WPreOnyPF8JrbsHvg==@nongnu.org
X-Gm-Message-State: AOJu0Ywv37OjIzLBDe12a7RzgDUSgtlwZMVa22aL/pOVTd1CNh72A0dD
 Io7f/lAKmyDt7TeCWm7r+2l8z6wBvt7tlNjexlI/aqbQdspSHnM5un06IIlQ
X-Gm-Gg: ASbGncuiVlHaoXtHaBGw/oZkpu2FkbpJy2JqSyZ3RVnUDrK1Hx1KsiPQ1sAGNAQGYPa
 WCxayFzB4XknHnvNqUDM2lqoJdRKLHG0n35DA4Ap4Kbw4OjeZysKY5i2+NX9Mchmbgp6yASmHYd
 o4JIfnUvG3Dwia0owhoWNm9ADipJ0rZEY9ZljGEUwIL97PKjXEPhy4GTIfoc0aSDo8YFLXeG9/3
 6k7asBSwdp8igTwSKJ4x8Cr0vbeO5Q+hr9TA7B+nOVK0PCK9elLtB0hBCAcwTiTCdry7zLWOozL
 1/dxCv2bQONgYKj1dCVDqg6M3638cT9vXhea55iUB1uoxKWbLQJv5e5BIZ0=
X-Google-Smtp-Source: AGHT+IGRZvEetiyqa+fm/MRvQqrwC4kyd4L2y1DWQfWnFLGfwS9xzLmNLqSqcW3bp/SNxhoA9tvehg==
X-Received: by 2002:a17:903:298c:b0:224:1d1c:8837 with SMTP id
 d9443c01a7336-22c535830d6mr189707265ad.19.1745299768184; 
 Mon, 21 Apr 2025 22:29:28 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:29:27 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 11/20] util/cacheflush.c: Update cache flushing mechanism
 for Emscripten
Date: Tue, 22 Apr 2025 14:27:15 +0900
Message-Id: <73301cc216217d5c3e0d7acdd32482e36f4f045c.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Although __builtin___clear_cache is used to flush the instruction cache for
a specified memory region[1], this operation doesn't apply to wasm, as its
memory isn't executable. Moreover, Emscripten does not support this builtin
and fails to compile it with the following error.

> fatal error: error in backend: llvm.clear_cache is not supported on wasm

To resolve this, this commit removes the call to __builtin___clear_cache for
Emscripten build.

[1] https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005f_005f_005fclear_005fcache

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 include/qemu/cacheflush.h | 7 +++++++
 util/cacheflush.c         | 4 ++++
 2 files changed, 11 insertions(+)

V2:
- Added an explanation for the change to both the code comment and the
  commit message.

diff --git a/include/qemu/cacheflush.h b/include/qemu/cacheflush.h
index ae20bcda73..76eb55d818 100644
--- a/include/qemu/cacheflush.h
+++ b/include/qemu/cacheflush.h
@@ -26,6 +26,13 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
     /* icache is coherent and does not require flushing. */
 }
 
+#elif defined(EMSCRIPTEN)
+
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
+{
+    /* Wasm doesn't have executable region of memory. */
+}
+
 #else
 
 void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len);
diff --git a/util/cacheflush.c b/util/cacheflush.c
index 1d12899a39..17c58918de 100644
--- a/util/cacheflush.c
+++ b/util/cacheflush.c
@@ -229,6 +229,10 @@ static void __attribute__((constructor)) init_cache_info(void)
 
 /* Caches are coherent and do not require flushing; symbol inline. */
 
+#elif defined(EMSCRIPTEN)
+
+/* Wasm doesn't have executable region of memory. */
+
 #elif defined(__aarch64__) && !defined(CONFIG_WIN32)
 /*
  * For Windows, we use generic implementation of flush_idcache_range, that
-- 
2.25.1


