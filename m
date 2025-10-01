Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C719DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s8s-0002q2-KP; Wed, 01 Oct 2025 04:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s8Z-0002Wm-2V
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:36 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s7Z-0006UL-0k
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so47414205e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759307003; x=1759911803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyykhGLj1jkUgHcU5soenb3/DO81dJbtrcBKTf6Mydo=;
 b=KvYGZiKBEnzN05LRhz98nysbRl2XdBGQH43XofH8ysNmkzgCLWtKnR02uGCmTBX3fJ
 qggUWOonepueGaK8bcfAbC9oUQ0bC296igNXVvsyLjHIlHciE3JxpHqBUamEeokiyDbX
 hrIegZYqyli60gUgijX9L6KYfSkyFfdn/R7VifYcmRLlr77p+a9q1MmHknceB9BXii1E
 wuVohoQwhsAswTMfP79lrM75VrAoIHI1ou7j9LTVk1dFaDN7jN8ClsIsILNloXwsZLPv
 wxA5xZQwg9KYlPfT4nsA7sLWZ+agBh3w5jUknA7K97YT9zTFLdanltET3eKJZWeT/hQy
 Fc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759307003; x=1759911803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyykhGLj1jkUgHcU5soenb3/DO81dJbtrcBKTf6Mydo=;
 b=PYJxSAOce/TZTT15HMqZu9wfNaXK0RGEe+EKWh/U2lEROki62Hg2zMYyNLj4L0bGek
 +Kj+lce0O1KY04dpgfD7wZZVznJAA0ALv6DV9j/731k3mCeHRksbkozpwzZudh+2Lzrh
 9UqRcEc2i4U1uzqEMMJRetjpFaoSczRL1gjlwlzO2Yho1XpNfzqHW51Zimy3YAcHGUTn
 ExlAxZo34YgM3eBMXlI4go6RWJoh/p0l1JxM3eHJ3e7UfNO2tfjLoRGPFUazCjz9UhgI
 XndGNlFkubci5qSiVAnTUimnHv0nbzlpz2mOgj4LQD7kPulZNS7xIbl3CjxrYAR5136R
 JnNQ==
X-Gm-Message-State: AOJu0YxeqdbipqbiK4mNqxJtF22gIkEsfJEUqktQPJBbryombBFig6iB
 9x3Ad/BJPH8rXh6gPew/UpaWV/8oEHVhT0Fy3Fc7LcdC/SkuGbA7AvtFMBudTYpN4AVC53JyUbp
 cBDAyz0k8sA==
X-Gm-Gg: ASbGncv7hv43ruBUdrJCdH2JCGac6CnTWTw9eSLEbVlOw7P5roO42muEwQjEHHB2G+Q
 j1Lm8W/vVX7+moGCIrpef75qKsduEECG5ZxrAAR36o1HsQxg8r1xLViovu91a5elKlqj30uy2tg
 XolsH597WaO2vsRqa5fh6GFXAAf7F1WlfX0ybCC6+l2Haea40VqrgLI9gR4MU5pZTSzkLjrO0HB
 vZ2q9SR7I70ecdODSBHsKpmjtCeh574DvRLSHZhzlwS2rlTDI4/UmxOJNJ6tWCMBZklByQFdLhi
 g3fV7dxn04x/sAxOPoxjE2xa1fKRVwIPvceMw+EuUIYVBnf1dOiv4ke6TDM3gk110wWCd+Qug4V
 r6Sm5OwxBCnWPLBYYtRz3DQ/H9QBV+4+3P3ZabyrMeN5hlBjhpOJmVxsnpYQ7bDExqZgNSNy6xm
 4bzQb+EDxkuVNXp9fOGPu9
X-Google-Smtp-Source: AGHT+IEW9r/bw8qCoszWMVZkXC0nqD1HfNOEbFg+tiQXxaL8h0CvjflOEJAU8J3R9AYYkEr7d7Yj3w==
X-Received: by 2002:a05:600c:154e:b0:46e:6042:4667 with SMTP id
 5b1f17b1804b1-46e612e6912mr20563595e9.33.1759307003069; 
 Wed, 01 Oct 2025 01:23:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc88b0779sm25778005f8f.58.2025.10.01.01.23.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:23:22 -0700 (PDT)
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
Subject: [PATCH 21/25] system/physmem: Rename @start argument of
 physmem_test_and_clear_dirty()
Date: Wed,  1 Oct 2025 10:21:21 +0200
Message-ID: <20251001082127.65741-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Generally we want to clarify terminology and avoid confusions,
prefering @start with (exclusive) @end, and base @addr with
@length (for inclusive range).

Here as cpu_physical_memory_test_and_clear_dirty() operates on
a range, rename @start as @addr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ram_addr.h |  2 +-
 system/physmem.c          | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 7197913d761..3899c084076 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -166,7 +166,7 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
 void cpu_physical_memory_dirty_bits_cleared(ram_addr_t addr, ram_addr_t length);
 
-bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
+bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t addr,
                                               ram_addr_t length,
                                               unsigned client);
 
diff --git a/system/physmem.c b/system/physmem.c
index c475ce0a5db..9e36748dc4a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1092,7 +1092,7 @@ void cpu_physical_memory_set_dirty_range(ram_addr_t addr, ram_addr_t length,
 }
 
 /* Note: start and end must be within the same ram block.  */
-bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
+bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t addr,
                                               ram_addr_t length,
                                               unsigned client)
 {
@@ -1106,16 +1106,16 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
         return false;
     }
 
-    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    start_page = start >> TARGET_PAGE_BITS;
+    end = TARGET_PAGE_ALIGN(addr + length) >> TARGET_PAGE_BITS;
+    start_page = addr >> TARGET_PAGE_BITS;
     page = start_page;
 
     WITH_RCU_READ_LOCK_GUARD() {
         blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
-        ramblock = qemu_get_ram_block(start);
+        ramblock = qemu_get_ram_block(addr);
         /* Range sanity check on the ramblock */
-        assert(start >= ramblock->offset &&
-               start + length <= ramblock->offset + ramblock->used_length);
+        assert(addr >= ramblock->offset &&
+               addr + length <= ramblock->offset + ramblock->used_length);
 
         while (page < end) {
             unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
@@ -1134,7 +1134,7 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
     }
 
     if (dirty) {
-        cpu_physical_memory_dirty_bits_cleared(start, length);
+        cpu_physical_memory_dirty_bits_cleared(addr, length);
     }
 
     return dirty;
-- 
2.51.0


