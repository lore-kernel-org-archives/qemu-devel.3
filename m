Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46599CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G4z-0003Fo-Di; Mon, 29 Sep 2025 11:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4k-00031R-7V
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:46:11 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4Y-00085d-46
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:45:57 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso26066885e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759160750; x=1759765550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skSiBrYgmNb3KW5VmEKPkKDMJ6jv8aZ6s7jfJf5MQP4=;
 b=E88KMOJbKblFnAt9IKKIUn/BOwloZwd1qfqpBsc1GnyzggaCxngQacaDlKkUQg7CBZ
 cRgo4dKKLta7e3UdI14G66gBBwnrfKtLzujAuL7Lxln5hY9ebzQ4TQLFius7EXmHFpBE
 p3M+FS08gOLX8aP4DfkKAT7zSPz9b66Qp2AYBZjLjRx+I57kjdPBWPwG1gMj8Cf4OtZF
 /vXbvgdXHE43O0QwRflMdkWD/sxTdf+WXT79/8OpVYYM9p4xb2wFjR91fKEJINcy7w+n
 gCLREiSaOlTopLBwSDtV8Gs+yg8dJ+GPK/wx1ZUfID8SETCpPCNo//NA3nMzhAZvEVZE
 EVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160750; x=1759765550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skSiBrYgmNb3KW5VmEKPkKDMJ6jv8aZ6s7jfJf5MQP4=;
 b=nB5r9XgIekpMqgAEV59pHUi+lAyMDAmptSx/yI27zZvgAItv1IRkZ7sJcgnxD8bOAi
 dymTyfzAznqSYrVTWkBicaqfV7PDFND6rxhOsZ0dMl27WGxh/PBchoDC7rbf97lFPday
 rBSM6/hBEgLZCKlDa0vYYGk59FCSlU5F7Z/NpGCeqsGpG62vyO7kt2si6O9Al96nIwWh
 zLghclb10muzJGGpuOCIlTb05Rq8qXZtkbYuw24OGgTIXX4ZT6ORE62m+bnw2SYSIdEd
 Yl3R381Mm5k9HhwPnJkq1pZ4HvUkZlFPHUMoXryaEYgn/xpoNt1EfTZW+5i+FclQt3PR
 J5vA==
X-Gm-Message-State: AOJu0YyXwiTajBC+0NlSHfzW1/VCu7XolA5k1GGAsl92QE0NO9b+gqBE
 3ufy88SOwAlK0Afl8KAoIyG63SovoL9MTq/udhLwUUwHK4kGfg2x2vVuFwSWSt3aamy3MIjFd8+
 x4Bc4ngHtGw==
X-Gm-Gg: ASbGncvPIaGWja4KYH9PnIvdIh8YAaz3QfEBEjemaa87aQWxNF7XpIpWaKn1Nlvi05v
 ljCIamNsJy+b7Pd8cLQxMMvUombYm7KsgfnCLmUbV1HgbBPrJXCfWdFs2lVbcg6fyNFt/KgJKRf
 KT1MEu01zewj5p51GiKlpebF1K+y4momI9NpA39Zyh+fshaDhEax09HVQEDVl6aSydiwm29eHVi
 o0KN93IQFg2CHVkGPR3R0gSxvvXyWdaU+UflsqkpzZPtjk6UQwvg/e6dfjLspU0PJT0bs6wZc3E
 92mUE0RocroqEV28Akxg69Bd8bc6y1VR9OWUle/8PzsdLKtt5SGm+NYh9asTEzuD45sIfN2ICY5
 6LjV8PbM8UEne/1VSiTO1G5KBfgiTA9eEeys2QToTUBf2W3AbpoLWZp9HveIrcy/3CSAPFnT7Qb
 t2G13b8JA=
X-Google-Smtp-Source: AGHT+IGsNO4ME1VQ2l5Lp9gwMoIxExUWy6pxs/+HaIF3NAnkZSji+lWI9Q/AGB1Bpc3JW6TXnXKfoQ==
X-Received: by 2002:a05:600d:112:b0:46d:38c4:1ac9 with SMTP id
 5b1f17b1804b1-46e58aac96bmr8112745e9.2.1759160750552; 
 Mon, 29 Sep 2025 08:45:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31bdesm229147985e9.11.2025.09.29.08.45.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 08:45:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: [PATCH 4/6] system/ramblock: Use ram_addr_t in
 ram_block_discard_guest_memfd_range
Date: Mon, 29 Sep 2025 17:45:27 +0200
Message-ID: <20250929154529.72504-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154529.72504-1-philmd@linaro.org>
References: <20250929154529.72504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Rename @start as @offset. Since it express an offset within a
RAMBlock, use the ram_addr_t type to make emphasis on the QEMU
intermediate address space represented.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ramblock.h |  3 ++-
 system/physmem.c          | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index e69af20b810..897c5333eaf 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -104,7 +104,8 @@ struct RamBlockAttributes {
 };
 
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
-int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+/* @offset: the offset within the RAMBlock */
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, ram_addr_t offset,
                                         size_t length);
 
 RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block);
diff --git a/system/physmem.c b/system/physmem.c
index 3766fae0aba..e2721b1902a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3920,7 +3920,7 @@ err:
     return ret;
 }
 
-int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, ram_addr_t offset,
                                         size_t length)
 {
     int ret = -1;
@@ -3928,17 +3928,17 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     /* ignore fd_offset with guest_memfd */
     ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                    start, length);
+                    offset, length);
 
     if (ret) {
         ret = -errno;
-        error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
-                     __func__, rb->idstr, start, length, ret);
+        error_report("%s: Failed to fallocate %s:" RAM_ADDR_FMT " +%zx (%d)",
+                     __func__, rb->idstr, offset, length, ret);
     }
 #else
     ret = -ENOSYS;
-    error_report("%s: fallocate not available %s:%" PRIx64 " +%zx (%d)",
-                 __func__, rb->idstr, start, length, ret);
+    error_report("%s: fallocate not available %s:" RAM_ADDR_FMT " +%zx (%d)",
+                 __func__, rb->idstr, offset, length, ret);
 #endif
 
     return ret;
-- 
2.51.0


