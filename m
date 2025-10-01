Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F4CCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s7c-0001NE-KZ; Wed, 01 Oct 2025 04:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6y-0000uI-0B
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6R-0005lJ-TX
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:22:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so61752475e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306938; x=1759911738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xhfwnxQYenTq/tp2PJW4+khvxCsXeRr52wkCrvc1Lg=;
 b=XWefImCLVlMOl8WHLuDd5/aE+5OspPkeTbcdbMzWECR2TONXz+ff0iTFa0QIwjJ93J
 R7iVCKDcb5a7JW5bvREY9QIo9GUg/yFg0T8z47Dw/VX9fdopjgwCS96UIldiI13MmiXw
 ZVW3EwSSAvrhm4hcT7Sp9tCxDwebz1ZKImCSQJNDY13/r5MGuuLPuN8wC46xD/KS/ZWS
 Fj1b09mozhzBxkBjLzATi8oYhvtp2xLj05weL2YAOi2/v5nt4YpLBAhw7IPFqFwfE6vF
 RjbY+8u2572vzL7dM5NUoVMaey3zp3NDFtmql3rC/kloZDeq4CB+WQL31pdZb387ZRYs
 CvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306938; x=1759911738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xhfwnxQYenTq/tp2PJW4+khvxCsXeRr52wkCrvc1Lg=;
 b=QJk+f2k//a9OFuvxrpztoiUzP3aBFpEphBzgqN6bZYPOsPsu+vQTP3DAXZtvzBZYlv
 unvDE7/MdWYxB6vy8rJEUK+geeuefq/5NaO085JuBtwwKBiVVAfGfZ1ncFQUiu8v/5xP
 Th+9ZYZE8JuO2uX0XZLNnneeT/zsH5z3qPziAonT/GoEJwaqo0uTy4UpGW1a2HBbYSgC
 Lu2sYybe7qhHZ8QF5uPwOJfStbgSnHQ7eQ19j8m2GWop7RfFgYkBMTQYVSyRpWg0Dmc4
 3scMtEqAdTfbdHAB9vT6XZEwaS1m9zn/c/x4iZtrQ5Azx9SHB2ZkjuObG1jNh0RZaUZK
 CL4g==
X-Gm-Message-State: AOJu0YwbCbWL1j7r9gu1Gcy4KpvW3HtGUmnugHy1AcPsHoeYJItPds9o
 BC+G2c8ccicVLTMEo7bEgtZGDgV6OmVRTorsIrgJtxAIZ+WllyRS/cOgQZK+KAdA/qX/jZ8Unnz
 XgmnHncdQ4g==
X-Gm-Gg: ASbGncunqV7Z8mA8oki6yHC5q3Sh4HCsjV33HnsKTR96UUAb24Gn0w787bS1Gz9+NM7
 gfv6S2U1fF7dyHiD/binr6h53Ra4p4yQMOeU4T2Q7bYAVuMo1/9saSTNvUluzABhIoEt1ue8ViA
 lGYt3uuXL9BEYDxmN11mwRn03G0ogilU4jMTBHNeHH+XWUTfhoBzX/S4Vn3GxhS/oQK20r/Uftj
 zRcJt6oQ/8juG+Asl+apFhBLUFsqsCFTtgRbRLaITdDArH/GyMxWEBRhw+8vI2C3iJtVu/U3eVZ
 E0vvEyYeyMiIBSKcZzOd0RI3ACyre3hkECfV3PjdXPaCvIrbtnuVhwoEz3hmkXU0P0lQg9LGhkJ
 OU7CyyYdk/ydgO5A+09EMGLI4Fb2N1vO5s/NcbI6ObqneNUEsRnJTS99b52GT+hrzmpBRf2k2FM
 cCoKNYpr0kzMmbv5KZm7JuR/agAOCpLiA=
X-Google-Smtp-Source: AGHT+IE3/WBiSCnGGpTVJZHThDWbhBUy9EPBmlkD33neM3UntZWo4n6MtKxXgYiQOUKYg6/g1hOLew==
X-Received: by 2002:a05:600c:524e:b0:45f:2919:5e6c with SMTP id
 5b1f17b1804b1-46e6127c38emr26519685e9.16.1759306938235; 
 Wed, 01 Oct 2025 01:22:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6199f589sm28791645e9.10.2025.10.01.01.22.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:22:17 -0700 (PDT)
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
Subject: [PATCH 09/25] system/physmem: Rename @start argument of
 physical_memory_get_dirty()
Date: Wed,  1 Oct 2025 10:21:09 +0200
Message-ID: <20251001082127.65741-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Here as cpu_physical_memory_get_dirty() operates on a range,
rename @start as @addr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ram_addr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index f74a0ecee56..585ed78c767 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -142,7 +142,7 @@ static inline void qemu_ram_block_writeback(RAMBlock *block)
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
-static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
+static inline bool cpu_physical_memory_get_dirty(ram_addr_t addr,
                                                  ram_addr_t length,
                                                  unsigned client)
 {
@@ -153,8 +153,8 @@ static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
 
     assert(client < DIRTY_MEMORY_NUM);
 
-    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page = start >> TARGET_PAGE_BITS;
+    end = TARGET_PAGE_ALIGN(addr + length) >> TARGET_PAGE_BITS;
+    page = addr >> TARGET_PAGE_BITS;
 
     WITH_RCU_READ_LOCK_GUARD() {
         blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
-- 
2.51.0


