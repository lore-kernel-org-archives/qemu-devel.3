Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F80CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s8U-0002Ne-LU; Wed, 01 Oct 2025 04:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s8R-0002Di-Ah
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s7U-0006Rq-9y
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e4473d7f6so33824705e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306998; x=1759911798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrNgTPyJzvEO8S5hoH74TrA1pNzqvoSoa2IFmkmTeGg=;
 b=I5eY6cOMgHsTgRGtMHQrbiWn/5zesCz66QiPubgAcRPLYOQypUJVPhcy/zwoDgMHkH
 6uFUJ7/e+mrlun+8yqMKy3e9+m6ES+xo0xe3YLmXr6XhM5i/UZHyq4RZ/1r7LZ6gj5iI
 mCHZHO7gcQsyXY7hejbvWdma8i/FvqBy7N/2uAuomEUfEWle3gHEBUHP3uaGYFSfId4I
 47kYQWGvVdCaQyRQn8HCVvAcrlaM0UfBxkGfIN5aW5m2EOsykM4gIIrmP5nDAka3Afoi
 49AQJUlaXP2RVoPl727nxC2c0/F26dqjPvO+EsySBOsS+zpK3qThFBkdRbKNr3mEdRqs
 K6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306998; x=1759911798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VrNgTPyJzvEO8S5hoH74TrA1pNzqvoSoa2IFmkmTeGg=;
 b=dl+fb1GRbaPc3XyNfgnoOe7MDQXVDVDrnWu0yUX+9Z5VKGB9leSD20fgYGQODFsloR
 cw7yQNimvs6IjveX5DmxcXhvr1SGafGt1AnQzPU90qvvoksd8EZBmtzrl5MU1ZwLbyiX
 ID8vrG0B9dKB8ikd8Gz6nWoYk/jEuVZ8Mwb4v3kRPLc8jdMYw3tklF7g+X1RZi3y7NWG
 5X82zaT2wD3RnHzIMzh5EKYraqUfyo89abVPZsi7oHADNBRTzhnzzK5go4caA5/wVwcP
 fctj0JVrtpcrEgyPHikBjM4NNl30Alycr7K4UJ3qe5MMr5BBxtCbeEkz3dbytilyMRaP
 hyzA==
X-Gm-Message-State: AOJu0YxirSDMnFws8x58tJdBem+T/rsxMmShLrSWqOgt7H7ikKE2quA3
 AEvxjIhXxkjsRTAeCWfPY4ILYb4Pm9Shhe7nFX/27Ic2DKz8dcHsZHZBC3zU9gwjB5Sw4083glS
 OJdT3sMk8hQ==
X-Gm-Gg: ASbGncvzmFvVYB6KCs3UVSRy1TqV6JhUMGlaaeiE3abiWiUgDY2KRPiJ9foExx6e25r
 4c3N6nwOZQrIDo9YvvrOvcD+H1N1vDqOdjGXkynDfZcMnNWeSVSVgqsdZnDpabXoZokfbYLf/Be
 tF4nJh+SnkkX0y+LRbsppz5kGeUxIx3E6R34f9gYE7Jzs+ug2gMNSwvFNoMokzm21W/4CpmwNGs
 ES7bhRSVQCINFJIv45O+yGVytm11FPiNAcbbdE6LeQGLVVfkUnN27wKETck7+PBkVKMGOavtnYo
 FwaT9khDkJIwXGY7HvBBj6AMFVJ1SPMC+pqBw3cxbusUlyejQK8eabcfiemHn/YS0vpmmXaQH8J
 IgYPw1PmL6ij7qC9tSeYMRIn3oCVA9w/PhfuCB0u2mXILln4QrlG2r4cifys4ZXTe7yLInZYN6F
 HmvbgMAIxGEoOfLz5q5re7GdnMHmHiW6I=
X-Google-Smtp-Source: AGHT+IHmELa2DuEfVWDKNypuVulirBMMoxnOdm+AkbpdEdchyNTUzA1LDJJ69gO6XD2Qu34B2Kle9w==
X-Received: by 2002:a05:600c:a304:b0:46e:652e:168f with SMTP id
 5b1f17b1804b1-46e652e1d0fmr6748725e9.6.1759306997734; 
 Wed, 01 Oct 2025 01:23:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc88b0779sm25777665f8f.58.2025.10.01.01.23.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:23:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 20/25] system/physmem: Un-inline
 cpu_physical_memory_dirty_bits_cleared()
Date: Wed,  1 Oct 2025 10:21:20 +0200
Message-ID: <20251001082127.65741-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Avoid maintaining large functions in header, rely on the
linker to optimize at linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ram_addr.h | 11 ++---------
 system/physmem.c          |  7 +++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index e65f479e266..7197913d761 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -19,8 +19,6 @@
 #ifndef SYSTEM_RAM_ADDR_H
 #define SYSTEM_RAM_ADDR_H
 
-#include "system/tcg.h"
-#include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "system/ramblock.h"
 #include "system/memory.h"
@@ -166,13 +164,8 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                                 ram_addr_t pages);
 #endif /* not _WIN32 */
 
-static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t addr,
-                                                          ram_addr_t length)
-{
-    if (tcg_enabled()) {
-        tlb_reset_dirty_range_all(addr, length);
-    }
-}
+void cpu_physical_memory_dirty_bits_cleared(ram_addr_t addr, ram_addr_t length);
+
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
                                               unsigned client);
diff --git a/system/physmem.c b/system/physmem.c
index e78ca410ebf..c475ce0a5db 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -902,6 +902,13 @@ void tlb_reset_dirty_range_all(ram_addr_t addr, ram_addr_t length)
     }
 }
 
+void cpu_physical_memory_dirty_bits_cleared(ram_addr_t addr, ram_addr_t length)
+{
+    if (tcg_enabled()) {
+        tlb_reset_dirty_range_all(addr, length);
+    }
+}
+
 static bool physical_memory_get_dirty(ram_addr_t addr, ram_addr_t length,
                                       unsigned client)
 {
-- 
2.51.0


