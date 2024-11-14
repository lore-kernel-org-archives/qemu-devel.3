Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B952D68B35
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcHz-0004xb-8M; Thu, 14 Nov 2024 11:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHt-0004uf-17
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:41 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHr-0002Bo-Cd
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:40 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720be27db27so664200b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600098; x=1732204898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V73iy9O4QBEVFd3/BQLHjhP35QEkGTMYrTHTqx+CnQ4=;
 b=uEz9pAdQIWtQJ/jtFaIUuz24sY/RuCsfLygWC3BZ9i3ClJtnz73XrdlP9to5sb0usy
 OK16vRHVfjx8YuFl5P/sj7iQtL6ZqnwskyMeb4WbYd52C4gKr7JCOLWk4zlon+9FWAmc
 HmhNbzON9JGuSIMEGdkTZdMl9Gjhxw+6z3GZNVD/fgF+SmxBTQzJclYOY++avxrCA03/
 KzIoVKKIIhVJTGrAxNJuojWfjLepzvpHF3RMxn9I5HU77JpU1OPCK/VAZErmITyuOSBk
 DRSDYbnKxFqb7DI4ulnAUbAVb4td6KyDJXMz6eSPzgpxQqmPl7OdFYQyJP3oy4unZK+h
 lIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600098; x=1732204898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V73iy9O4QBEVFd3/BQLHjhP35QEkGTMYrTHTqx+CnQ4=;
 b=Q66DAFcSZNOnkBw1LU9O4TxsTD8zoaKNT4gEWlZutnZnAfBA7L0deLnf+mcHePpcvK
 Td9sagCTfA01QosV5AZ6EnOR7GREzq0X6+w5qjcWcT+hZdxUDsN5F8xy8gw4YETZgy6q
 QrQSAVgUyVzNON+YfMqQdSBj5OyK+Dvkk8er/E7+piZPN/upXbyRIrlmT5zlVIB4LQTr
 bEatAnbTXjc3C9TPQ5VrYRYvjnz9eNzMb9fsnBE0AO7867qnuSRqxhfxEGHMelpMZphY
 aOoBBDY/Ycp/2+MCNI03gxFPXNSXVFdDg7TcG8PRuFfvvZhofqUILLh154M6wuxmDISL
 3CnA==
X-Gm-Message-State: AOJu0Yx4+45c6HxY3xWugbBKjepv5SqguF0IRnIUOgD3FZZu2lfyOEb/
 9dUOTj/U3f8tpGH2d1ZbDrKr4alYgelbTk5LMBEE02CTAiWj55FK2mkkrFQILgZcbhlBVhwHHid
 6
X-Google-Smtp-Source: AGHT+IEYJK6UI4uKpmyyEECf0Os2bmLmCvDMldRXOxy4zA6Mj2Q3YhnggVlrohFXIGgZpzUqWYNX4Q==
X-Received: by 2002:a17:90b:28c7:b0:2e2:8d33:f79d with SMTP id
 98e67ed59e1d1-2e9e4bea639mr13502716a91.19.1731600097744; 
 Thu, 14 Nov 2024 08:01:37 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/54] accel/tcg: Assert bits in range in
 tlb_flush_range_by_mmuidx*
Date: Thu, 14 Nov 2024 08:00:43 -0800
Message-ID: <20241114160131.48616-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

The only target that does not use TARGET_LONG_BITS is Arm, which
only reduces bits based on TBI.  There is no point in handling
odd combinations of parameters.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 1346a26d90..5510f40333 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -792,20 +792,16 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
 
     assert_cpu_is_self(cpu);
     assert(len != 0);
+    assert(bits > TARGET_PAGE_BITS && bits <= TARGET_LONG_BITS);
 
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (bits == TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
         tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
         return;
     }
-    /* If no page bits are significant, this devolves to tlb_flush. */
-    if (bits < TARGET_PAGE_BITS) {
-        tlb_flush_by_mmuidx(cpu, idxmap);
-        return;
-    }
 
     /* This should already be page aligned */
     d.addr = addr & TARGET_PAGE_MASK;
@@ -832,20 +828,16 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     CPUState *dst_cpu;
 
     assert(len != 0);
+    assert(bits > TARGET_PAGE_BITS && bits <= TARGET_LONG_BITS);
 
     /*
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (bits == TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
         tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
         return;
     }
-    /* If no page bits are significant, this devolves to tlb_flush. */
-    if (bits < TARGET_PAGE_BITS) {
-        tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
-        return;
-    }
 
     /* This should already be page aligned */
     d.addr = addr & TARGET_PAGE_MASK;
-- 
2.43.0


