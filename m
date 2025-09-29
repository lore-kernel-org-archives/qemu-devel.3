Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F6FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IjT-0007mx-AK; Mon, 29 Sep 2025 14:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IhU-0005Xh-FT
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IhM-0003ZD-F3
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so23889125e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170843; x=1759775643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LuYVzxDYsV8q8g9d3IDIaYEYUyrQfEG5rj8P4oQ0OGY=;
 b=gRJi/7gzSq/yfpGi8WyZTW5qyYYUjYmJoz6kMet0Y1p2m+lER/mu3FyfVNgj7LXkaa
 SCgwuH3TsBXFs6AcqdzPL0sqG97apwKcAPYRZY0cqihs3d2JsBwclqtoCSLLzK2tIAQd
 SdF+ZbeJ6w/KondjvB5oO5r/3J8Xn7Wx4PkfS2tLZ4h3MzSPAiFaPXxe2MkrNMzEciqp
 i7idffce6JCa/KBLBW7/iT98fFaZJoGUJHsFr5qYb47GX7wSoOJWVbDtVhpUxQs1131N
 c1CUI+f87woUqCiSm9fszGRG+Uly1wU4/LXh9u/JvMhypYjv3nymrwElOF+5jU463PZF
 GXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170843; x=1759775643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuYVzxDYsV8q8g9d3IDIaYEYUyrQfEG5rj8P4oQ0OGY=;
 b=TSgrL4A7AN6rWMVkw+OuBuyp7N7aeFop37Y4/UYjH/Lx/y+YuIunY+bg1uwyOJk1b1
 M5X/UmAZT9XbLh8t1Epf3H+w2Ft/c0JbOeZVTV0s9keBTBUiYDkhhC2kpj51cAClbPvH
 QkMqK45VG1ug8a8fRGaM+0ss7pJr/u5mRpsYfzAWHC9pKtWDCsgh2kEXSfTNICJU38Zq
 WCe2Av1WjzaOFgMlgIxVdPe551YcW/mU89tZVsujeHDA9z6E6PVXdzVnuIbpVRExydBk
 I1qewQgniTH/APExbpMCo5mm+IKC9Jw1kiCxHaxYLqrb91s6nwInc8f+SbCwRvOs+Iqu
 bTwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDbDTnQqQuEevYlnHAWerKyDc9cz0Yq4sokDg88pK9yNOHYUtZFS6sQvQlJKFqIXJcCqMw22KuuwV8@nongnu.org
X-Gm-Message-State: AOJu0Yx55FZ+UDYnQKwaKTrkf8lPGMqkb16ZJ3vAM8ZH+zGcUM4DJzC1
 ZKWc1H+MZbFT1qnwCog0ntvnkNP8/R5ZRcneHOGkkH6G5WDXFEEkxXrLbT3gIt7I+QY=
X-Gm-Gg: ASbGnctfnDIVX4Gd21zWke9ATt1EPhh8CiBJ+i5ysOsa5gCTr1GBx/kCKTWfYaFGOvQ
 FJMk13XOUJ+1TvJZTKyNNlXrcSMOAKTIMoa+Q4u70oFo9Rhf/ThSbXWRGIx9xmjVP32NvswiXJo
 bQCL1S2j1Pkzo++HjbXTfkYvq5ynBvpHr1fPtPM+WfZ7baSxZp/rYU23OAwVWdY7gQPCdqWCx1+
 DM8UAX9SCGscmFkyVjJxhKXjBonDkDsDxv9gMd1IBZgOz87l1yi16tgd246OaHEA/dNY6dUglk5
 C7yoLBlyjHKFUucmfVXdmXlkWIiGQ32iCHrSS8x9XwQNCkwIgMt1rOdTY76W0yoinrs2bL6GwwK
 H1QhUsO1qcPPJlMxSpxu8fM6LptaJNp5VlIo6wn2ANGKLzisESGCA8rNlhLWaOOUrhaRPtUFtXh
 QVGf9hrVZB+RlA5/+eBA==
X-Google-Smtp-Source: AGHT+IHxkSBKZz9UIKJGJ2MuyS+JOGfRYnVKVs7Y+XK907wXLr+RITSG6kYiNQobFw2cPjU7tACI6g==
X-Received: by 2002:a05:600c:a47:b0:45d:e6b6:55fe with SMTP id
 5b1f17b1804b1-46e32a32b56mr143974255e9.34.1759170842607; 
 Mon, 29 Sep 2025 11:34:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e46de67e1sm103906645e9.6.2025.09.29.11.34.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:34:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 12/15] system/physmem: Un-inline
 cpu_physical_memory_read/write()
Date: Mon, 29 Sep 2025 20:32:51 +0200
Message-ID: <20250929183254.85478-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Un-inline cpu_physical_memory_read() and cpu_physical_memory_write().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h | 12 ++----------
 system/physmem.c          | 10 ++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6c7d84aacb4..6e8cb530f6e 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -133,16 +133,8 @@ void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, bool is_write);
-static inline void cpu_physical_memory_read(hwaddr addr,
-                                            void *buf, hwaddr len)
-{
-    cpu_physical_memory_rw(addr, buf, len, false);
-}
-static inline void cpu_physical_memory_write(hwaddr addr,
-                                             const void *buf, hwaddr len)
-{
-    cpu_physical_memory_rw(addr, (void *)buf, len, true);
-}
+void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
+void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
                               bool is_write);
diff --git a/system/physmem.c b/system/physmem.c
index dc458cedc3f..5a0ee3b8e58 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3188,6 +3188,16 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
                      buf, len, is_write);
 }
 
+void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
+{
+    cpu_physical_memory_rw(addr, buf, len, false);
+}
+
+void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
+{
+    cpu_physical_memory_rw(addr, (void *)buf, len, true);
+}
+
 /* used for ROM loading : can write in RAM and ROM */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
-- 
2.51.0


