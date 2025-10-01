Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30558CCD183
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v414T-0003WC-Ie; Wed, 01 Oct 2025 13:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4143-0002vw-La
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:31 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413T-00017z-RF
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:31 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso40602f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341345; x=1759946145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmAW5Wa2xprjni3CRQ6N2DgDe5FiwN23lEDho++REkQ=;
 b=D/XsCBaQrL3RiPWUrUvm6NKVXEBGqT9V1X6h0uWECsITAQ6wm0YdE6TMytGJvmk4BI
 b/SzIOdbtYzuEfTY6orna8Jk+8hFC+oaRxmwvbINcftiuFc/xLvBr9TtCl1DcZK85RhE
 ltzm61RPJLrTsV+mFBPDowUCzmmeyv0j4gDcFOiowo7En4Ed3sFwqDDEA14tQewUWHG5
 wKNIGSKAuZaRwIsEYy4fl61ko03b0BWfrKee8hO4XeZJDHb3dtIXVCXXH6Ng/Fn9vgth
 soyAEEc10FX6irETnXtzHxDdPJz7GPShLAQ8/LFnTXhW7Cr8d1tVt2o6FQvS7qbuep+3
 JWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341345; x=1759946145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmAW5Wa2xprjni3CRQ6N2DgDe5FiwN23lEDho++REkQ=;
 b=YTQIdICGsbrv0zlHzGWo5HNlVzLGx+a43zyGwd43ge7+7evmn9IhETJYEmn7F6oYVC
 7yr5rRBwok80ZtJrpGphvDdHLPhEuKTAn2ALQmRhP3QTOHn62P/WQK59wB+ClVU8SeSp
 TjwPlmG7xhxsCw/ZqqmKcHz2e+rIH5sO2n2TAFOou8/owRW50p9St/Ag036BpSvZ2KW8
 1DYL5TyCLoWa3jbd2n4fjoXvW6WKUxwwsS3darZaO+UBTQAZBl1oEUKE5RzvgP/2/kH/
 1RrFlsmtp1GppYbad0I16vo1DrRzPA9DOxcvAka7oewkUxcH06jIlWrwku1pqamF2mDi
 uEug==
X-Gm-Message-State: AOJu0YzuRhCaiImXVIAmZF4F3xidTPmQUWBlI0ywrz8kc2gyRZpcCF8l
 4CpHmEKI5LUi0rBDwYdWuC9EJeCdLfQ18suHqZF27PA5W7oCFRw/BnwtVp+s2r8kgus+KOGSTXt
 2YmMgB24uFA==
X-Gm-Gg: ASbGncslw2nh+uzn0kmVyiBAs/t311qBtbNjt/THBtZYtzmdd5JOACqXjkw8nypjpT1
 Z8M/x651WV28MHj83tPBx4t5n38Y1pS9zSCQayMz6ck1xs8LwFzzV4V/dVgyjspBvetaaqhXHPo
 4eL2cBIB9QvN+GcY2rHX9HLI2feMKhBiDfvgOWpTBJ/gb+Lsmx671uzXJvWFnjdKPMs2PIZPMJ0
 Ens0DG4smgqd1xzHGXF8y+Wj8abN96V73gGvxIo7x2+7wADoRAU+cKykYvAsZwqPQqPySlj8Duo
 14XlJ4MyJ08n1qsnAgxllFFJ6YXy7CU2EbHAT35efchmX7qTtr883VTkvfNmtjZAOiRtnxYADFl
 nyvF2QbRllj3cTp7sEp86UXrqt6ACrsJR4R0boKgKkyP6t37OGCoXOp7a6sDN9G1SfQgROYopDC
 AJAaTxT6I8YfHUUQv/CWh2FHzbyg==
X-Google-Smtp-Source: AGHT+IHlNku8HY2dcBGT95e9TRS1oHVvhrWrx9c4/rAc6yV10BpHA/xJYolz/jqf6VLW92jj9xdZnA==
X-Received: by 2002:a05:6000:43cc:20b0:415:15eb:216f with SMTP id
 ffacd0b85a97d-4255d299ecbmr353513f8f.2.1759341344950; 
 Wed, 01 Oct 2025 10:55:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8efffasm98981f8f.41.2025.10.01.10.55.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:55:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 10/18] system/physmem: Un-inline
 cpu_physical_memory_set_dirty_flag()
Date: Wed,  1 Oct 2025 19:54:39 +0200
Message-ID: <20251001175448.18933-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Avoid maintaining large functions in header, rely on the
linker to optimize at linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/ram_addr.h | 19 +------------------
 system/physmem.c          | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 2dcca260b2b..81d26eb1492 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -150,24 +150,7 @@ uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
                                                  ram_addr_t length,
                                                  uint8_t mask);
 
-static inline void cpu_physical_memory_set_dirty_flag(ram_addr_t addr,
-                                                      unsigned client)
-{
-    unsigned long page, idx, offset;
-    DirtyMemoryBlocks *blocks;
-
-    assert(client < DIRTY_MEMORY_NUM);
-
-    page = addr >> TARGET_PAGE_BITS;
-    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
-    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-
-    RCU_READ_LOCK_GUARD();
-
-    blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
-
-    set_bit_atomic(offset, blocks->blocks[idx]);
-}
+void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
 
 static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
                                                        ram_addr_t length,
diff --git a/system/physmem.c b/system/physmem.c
index 2667f289044..96d23630a12 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1014,6 +1014,24 @@ uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
     return ret;
 }
 
+void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client)
+{
+    unsigned long page, idx, offset;
+    DirtyMemoryBlocks *blocks;
+
+    assert(client < DIRTY_MEMORY_NUM);
+
+    page = addr >> TARGET_PAGE_BITS;
+    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
+    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+
+    RCU_READ_LOCK_GUARD();
+
+    blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
+
+    set_bit_atomic(offset, blocks->blocks[idx]);
+}
+
 /* Note: start and end must be within the same ram block.  */
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-- 
2.51.0


