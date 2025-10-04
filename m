Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45761CCD183
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wSs-00049s-Uc; Sat, 04 Oct 2025 03:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSr-00042Z-DX
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSp-0004zB-5a
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so21275695e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562033; x=1760166833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rs5ktVxUhrsP4KqLrnYdRPZ+tvphc+EfryWZu4COmK0=;
 b=ZUXAg6cHNyOvjU0X1pPbVb4wpk8scGSd2HLE4B3EH/6rUMatYAUdKq2ZTFubbzm53H
 YkkmIYPpXW0ZQSMUhTQv0C91ThHA1do5sAyCD3j9R1+NCspNjFguW5bI1ekbnT0LsjRT
 6d21ZYE10Xsbbhb5uFjBcx0kfGYLcIykvDZGaBoAQeJg9wQ+jx+AcJ+kzcMJNNpFqe5n
 zzUuWq1CbCAsmQQU3qN1MUmS+ii4W6Ek9hKTnS9GrEketcGaq4mT/04eAftUC5yEWnjV
 GH44QsNKCaQCdghgsQf9jTzLwV3BlPrsQaq9N/N1vM3KdGKBireJ2PC0FDZTppQhIHGC
 iqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562033; x=1760166833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rs5ktVxUhrsP4KqLrnYdRPZ+tvphc+EfryWZu4COmK0=;
 b=TN2ZqsjqwmDBTxU1j4fzzLy8ziNPvgj/wOMq32t9qGu7O6fMD0QJfyEc9JO/08QE2i
 mC+fTgIPKLgRFKtwSnCfxHE5Lz8dHEFMQJKisGnEnzXiU6CBJJ5oE/ahCFqH68EZ+h2e
 NF6rSNsL8UHW6wOtLsUuWCM2Lbm3NrO/O7eYIJfQI5WrZl8Z5VzO4zhpMukcYsEek4Ug
 qizeZH0gpLs/A7PT5nfXoG3XGwDciLhk6cWfKwlgw2HiRVcSWoea+9mtVN7pKdD4hsUn
 odQVex0iNM4BpDB55E9usCsyhdvTJfRtTsXlCDuXPqm4jb8X94AXEArU+lgR51yqFeG9
 JhZQ==
X-Gm-Message-State: AOJu0YxeW53EkN+eCuyNQgdrcQy/TfejR60P7adpa94HVGKatI9K8X19
 7iadZl3tcy2B0dmVrPGl6dDHwFtgFBzxWug9xkLf6XlPfvc+Bbu9k+QLqglPO0qpEc5ZsyYW/hW
 7Cv4rvL+z3w==
X-Gm-Gg: ASbGncsUAVTZRkdrCZs8Ks/GjlG4SsMzIlT/y722eJ3ANENfFIPAnG77c+i4ckVPys8
 7uf9L0UvVtX+5y3KzCBwkzUBil5apOfg7swopF+C5F1tyJKLOrfYjayoviVY4VbSCvlWnEOOnGX
 cnvI+SqLZyUHNEWth3CAT7+1J4Ht9qUmxkErW1kWjgtcmbAMX4nD0a1nlZJntLdjwiO64V3j7Pp
 C9eO5/wwdSD0SOtXas1q8QeK4zT3is7LclQBByx8VQi4zKwbIYBWRMb0Y2ugG3cBGwamB2YliVg
 4jFwj6kOF952GElveNNJTh7gY6oEtWlSWjKpEPVLB9vs1t8hdxvfJBDLiky65GBD6r6oppY99X0
 ryX5ZGobYKvCcB5N6cqWjESz8tJCXfO1gGF7EXpQSoU83HpEd/sYWo/GJd54yadnnkrTF+m/pF/
 0vkoeCqOcxaBlKrAiNb6uX6+22sZ/CxVJdOWXlzVtOtb4AOA==
X-Google-Smtp-Source: AGHT+IEcsjW9deqlM8zFJrMLRoh+qANkb0liTvrzgGTsnV7UIlDcYaXusJPfwf02/jOkDd9fTqZ6fQ==
X-Received: by 2002:a05:600c:8a16:10b0:46e:6a3f:6c6 with SMTP id
 5b1f17b1804b1-46e6a3f0734mr55258955e9.6.1759562032590; 
 Sat, 04 Oct 2025 00:13:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e970esm10956715f8f.35.2025.10.04.00.13.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/41] target/i386/arch_memory_mapping: Use
 address_space_memory_is_io()
Date: Sat,  4 Oct 2025 09:12:35 +0200
Message-ID: <20251004071307.37521-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Since all functions have an address space argument, it is
trivial to replace cpu_physical_memory_is_io() by
address_space_memory_is_io().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-4-philmd@linaro.org>
---
 target/i386/arch_memory_mapping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index a2398c21732..560f4689abc 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -35,7 +35,7 @@ static void walk_pte(MemoryMappingList *list, AddressSpace *as,
         }
 
         start_paddr = (pte & ~0xfff) & ~(0x1ULL << 63);
-        if (cpu_physical_memory_is_io(start_paddr)) {
+        if (address_space_is_io(as, start_paddr)) {
             /* I/O region */
             continue;
         }
@@ -65,7 +65,7 @@ static void walk_pte2(MemoryMappingList *list, AddressSpace *as,
         }
 
         start_paddr = pte & ~0xfff;
-        if (cpu_physical_memory_is_io(start_paddr)) {
+        if (address_space_is_io(as, start_paddr)) {
             /* I/O region */
             continue;
         }
@@ -100,7 +100,7 @@ static void walk_pde(MemoryMappingList *list, AddressSpace *as,
         if (pde & PG_PSE_MASK) {
             /* 2 MB page */
             start_paddr = (pde & ~0x1fffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
@@ -142,7 +142,7 @@ static void walk_pde2(MemoryMappingList *list, AddressSpace *as,
              */
             high_paddr = ((hwaddr)(pde & 0x1fe000) << 19);
             start_paddr = (pde & ~0x3fffff) | high_paddr;
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
@@ -203,7 +203,7 @@ static void walk_pdpe(MemoryMappingList *list, AddressSpace *as,
         if (pdpe & PG_PSE_MASK) {
             /* 1 GB page */
             start_paddr = (pdpe & ~0x3fffffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
-- 
2.51.0


