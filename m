Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23A9C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpSl-0004gQ-Gq; Mon, 07 Jul 2025 13:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpN6-000653-Jc
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:11:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpN3-0003eS-Dg
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:11:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so30746555e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908271; x=1752513071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fEGrFzvbkD7rsSOvZ5d7uO6zmQ0v7qQeSAC4Ag5E10=;
 b=D6OZx2lHYc0AIO3CXQnT36Nbwex+L9sgPkbw9dVVeFQl4k6m4Ppa/uWS/TqOGrnlVf
 Qi1K4RSWtNJbOE1viOYp3j4uwPlvpLwHtBR/bBOabu9Xd+kP1BNrDjRmMSV1wEiENLp1
 LqIOjIvas/MRKDxT2k5F/MpXdyj85HckG3P8ntDKQEiaDAm/JA2NHeX+Nxg6luBqbtRV
 19sRE7UZ0DKhQqiiItGHw+keSns0IQVDgjExRo3cMCmFGcvcGCmHD97QRAJMYIZWUXin
 t30Pn4E4BTSnY8IxZUytNW7y558VVnB2TfpbR1gZiPiU6Aeiw10SJZfyOjC35+EMWu7B
 Xidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908271; x=1752513071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fEGrFzvbkD7rsSOvZ5d7uO6zmQ0v7qQeSAC4Ag5E10=;
 b=lG5MLLPeN+SRS54VsJTVDGUn0FUTke+QT61AAc0UKEoYprlQhhtpZvZSDUJM02wDiC
 6p3udCVxcj1SekJ0uB1rbtvJpu4+SE/NSqPSClNvd5XljauG8KpaGFAPIPpnpjgU9XNd
 MZIlbfSpVE6h89Jdr3Ea+nQVMt3xrYjEvJA5NhJLDN6Km8Rde4C6CxI95h5QoDULAd4l
 nHkw5YrmeP120DwzDLpJY3UlvBImwwGU1lFNRpzyM7GcXRYEnERF4KIdxFEJgpOFwpo7
 eJLp4g7LlDHdz+6Mb3RLq9sE0/QcL9R1rQjO4p3SeI96RjOeFOUNVJjxvv1Qr/q1ru2p
 SBUw==
X-Gm-Message-State: AOJu0YyVE5Buoil/3ju9iwBg1ZcWeR1QwwNYtohelpBExPA/3FUVgzwc
 VxB+r7b7b+1JzzBUukRC2yWS86SNNPG6IYcGHQX7J2k6+qx+FWBSlClFAZv+iW2ZL9TtU1ZljdF
 bJNAzvp0=
X-Gm-Gg: ASbGncsV75s0irexEu0+zOdIwDBTx8kIcUjbVTWPxNFXF8AcNXkzOZj7C8jvoW4EF7+
 Pml3s3q/yqbUgCSu3TbXNsY1FKH3RJl7neGdXEUfGcUvoADRppTQG7JxvhMmlK9VNnh6Y6Ptq8z
 C8FM41Qe/iBelmXgqcxdl5oLtZZgL1CkOXrFhEtmptRHfCNyXd+Txhj041TlWx9xSyvQMwVd/Xd
 4N1qFc9dAT4jHh2xP6fu8U1yL/wxdZ7awhKr7xMZIJHbnjE0F1aLUk255wBuYI8QnAuXgXKVS9n
 23W3CieDdOqtV3e+jk2qP3uRQKfhDyjb9nCEDS31ax2zWCVUf7rJitVAPXJVdQdOm2effNP3VqM
 Kp5g1UlQq37DMYFbp+Cz3v+kKvt+kiLjMXKOw
X-Google-Smtp-Source: AGHT+IEHuGUPWHX9daOsthlGvHjGQ/5le0kVE/naEFhfF+YwPcLnorNFJqFxxynz1JGE/W+ciHLjWQ==
X-Received: by 2002:a05:600c:648a:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-454b4e769e4mr128829825e9.10.1751908271206; 
 Mon, 07 Jul 2025 10:11:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b162a3ccsm117727735e9.12.2025.07.07.10.11.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:11:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/s390x/tcg: Use vaddr in s390_probe_access()
Date: Mon,  7 Jul 2025 19:10:59 +0200
Message-ID: <20250707171059.3064-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707171059.3064-1-philmd@linaro.org>
References: <20250707171059.3064-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Commit 70ebd9ce1cb ("s390x/tcg: Fault-safe memset") passed
vaddr type to access_prepare(), and commit b6c636f2cd6
("s390x/tcg: Fault-safe memmove") to do_access_get_byte(),
but declared S390Access::vaddr[1,2] as target_ulong.
Directly declare these as vaddr type, and have
s390_probe_access() use that type as argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index a03609a1406..f1acb1618f7 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -126,8 +126,8 @@ static inline void cpu_stsize_data_ra(CPUS390XState *env, uint64_t addr,
 
 /* An access covers at most 4096 bytes and therefore at most two pages. */
 typedef struct S390Access {
-    target_ulong vaddr1;
-    target_ulong vaddr2;
+    vaddr vaddr1;
+    vaddr vaddr2;
     void *haddr1;
     void *haddr2;
     uint16_t size1;
@@ -148,7 +148,7 @@ typedef struct S390Access {
  * For !CONFIG_USER_ONLY, the TEC is stored stored to env->tlb_fill_tec.
  * For CONFIG_USER_ONLY, the faulting address is stored to env->__excp_addr.
  */
-static inline int s390_probe_access(CPUArchState *env, target_ulong addr,
+static inline int s390_probe_access(CPUArchState *env, vaddr addr,
                                     int size, MMUAccessType access_type,
                                     int mmu_idx, bool nonfault,
                                     void **phost, uintptr_t ra)
@@ -258,7 +258,7 @@ static void access_memset(CPUS390XState *env, S390Access *desta,
 static uint8_t access_get_byte(CPUS390XState *env, S390Access *access,
                                int offset, uintptr_t ra)
 {
-    target_ulong vaddr = access->vaddr1;
+    vaddr vaddr = access->vaddr1;
     void *haddr = access->haddr1;
 
     if (unlikely(offset >= access->size1)) {
@@ -278,7 +278,7 @@ static uint8_t access_get_byte(CPUS390XState *env, S390Access *access,
 static void access_set_byte(CPUS390XState *env, S390Access *access,
                             int offset, uint8_t byte, uintptr_t ra)
 {
-    target_ulong vaddr = access->vaddr1;
+    vaddr vaddr = access->vaddr1;
     void *haddr = access->haddr1;
 
     if (unlikely(offset >= access->size1)) {
-- 
2.49.0


