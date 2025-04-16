Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DEDC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4y1v-0007qy-0N; Wed, 16 Apr 2025 04:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xxB-0002PP-HC; Wed, 16 Apr 2025 04:17:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xx8-0005xa-Dd; Wed, 16 Apr 2025 04:17:04 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso484556b3a.0; 
 Wed, 16 Apr 2025 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791419; x=1745396219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeWm4gdwYX7Mpk2+jTOfSOTsV04a2XRASVxxD/NFs3U=;
 b=Cny3sFPRfUHZZ2xZylXra+7azmFn0lCk7bAJCEFJ3FG2vv7vE5hqQC6vR+27L+KIMw
 YvSmDWMLt/ijcOWyynb9qxqX6scVlMFDK5pJRTXVMF3h0KsvO2dprP/t3R/Y6oexdW/n
 H6AJBWwD92GAXET7tUxu/AllcXIZ2Z1lqC7WNmdccKM1LrnfzWTS53gU+GwALQYnI/w4
 DYoejAkDXWElON7fqPwtBk6we8xpFOnSaiRoTtyGL8D76N1Xcm9VB4oAZU9oLTynP63F
 Io0EAZ84xTsBtZsU/HmacK0Sklm2uPfeSh5k4A58DONNgZcGSnMorXawDa4q/eHnAyiW
 aCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791419; x=1745396219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeWm4gdwYX7Mpk2+jTOfSOTsV04a2XRASVxxD/NFs3U=;
 b=mo+34i5AaG/uzqEOG6dObFgEFBDkDeMY81VHt8P+/gvDXHohszAaZXbLthzX5seAdx
 zJVyWf2BFFLxjVq5xw1EGKJLwpbHffZjWlaJhYjENCi9jSf7hq4BXN2oXdZko3P3mYts
 kO1PSF2EJ3nG48SX/pnJobhlnfSyYHVKGDYNrUWDN4IqHsAWWeT/aTCFdSfDQ+pAMpRV
 BD9+BveC/PN9Tx1z2tkBbcRLXh8gm2b3bGoCMVGnjc/hdUdowKA9yCpInNxa4BXufaSr
 la1n6HpiiQTbD902Vmg+6OScq4KRZCLd6Xqcb47qBuN48gS21Ul/irRahtABMThG5axo
 5ecw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMCAzBuViEulcCnQCy3VOQdLeu4jrP3cxDoV6YGMOWf2aFmGluiwX0VdkH/8HtizDymgi2nFDapA==@nongnu.org,
 AJvYcCVwhzqYp/HNgQPYKpkeY7z8BfoTLZel8Rf6JTdpUIySgbkIM/3owx25wBs60m5WTmgis4z0xO7YYuw=@nongnu.org,
 AJvYcCXZx8Db2XxhDnzjJvTEpeDWruMtR+EuJ8ciI1plRM6HBK5nP4OZIIqcbSsfnHZndlGgEK08voPRNQ2d0g==@nongnu.org,
 AJvYcCXrniY/wYrU/lJxx5fWwnBt0oY5dUt/ZzF/g4HQEc7XfFpQmOzDz7yO/Bchmiv+UQ7Tgtvom4403MRodQ==@nongnu.org
X-Gm-Message-State: AOJu0Yyyi0xBoMgMWvsyzp6UW/MOalaUGWv2/EyANt3OjhsC0yOkUsNQ
 2yJwQT3OmHu8LfH8Dqg9alZPnnzTPOwaIuNCKN3NsqI0wyK63xtCMWZFpeva
X-Gm-Gg: ASbGncslPhoiaFx5UYA4HNqsyNj0t1a0glzpwL27ggWB+gFhk1Q5bfMCX+teKZTxIN9
 jJjVI+aKrMo7uqvsCcNY+Ag76CTctaxl5Wvk+mI6BjLnQBQEwNDNr4FdncJyo1J6eUVtkVryVzR
 UNdepyuERa/IuWlEKbSKSrv0aYFkJn9ZKDteW53toCtRRR11qANhahk13eO8fYML6X3Fg6xdPZq
 WoI5KYPfl8xal4sj6I080Nkp8cIJR/N9BG9VjpYOGBaouhUo2x7ieE3hqTt8CtqutGUSOsVzvCM
 DWwYS40GNebnpYCHELq33cQc/Fl0QUrQbUXzJG380XWpJ0ashI9eKP+gJw==
X-Google-Smtp-Source: AGHT+IEd5+lBFTcqmb1ye1d++AMi9QLiZpHeWhQhSUvm6Ej8uB7TB8VIvQgflEsDVgsqaenyzYpXOQ==
X-Received: by 2002:a05:6a00:391b:b0:734:26c6:26d3 with SMTP id
 d2e1a72fcca58-73c26d39553mr1508336b3a.5.1744791419205; 
 Wed, 16 Apr 2025 01:16:59 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:16:58 -0700 (PDT)
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
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 15/19] util/mmap-alloc: Add qemu_ram_mmap implementation for
 emscripten
Date: Wed, 16 Apr 2025 17:14:20 +0900
Message-Id: <7ef485c860a0c26d2ddcf6a96430f5443deb5aee.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x430.google.com
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


