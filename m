Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C36CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 02:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1EvA-00030R-NI; Tue, 23 Sep 2025 22:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ev9-0002zt-G5
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:07:51 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ev1-0002c1-QW
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:07:51 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-33082c95fd0so5526671a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 19:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758679662; x=1759284462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpDWwmGB3FDcx3IksRaylh4MrMqkVjqSJs30QhIpAxg=;
 b=VppkE6KNC02/Ir9Je6Q5Yj9xEXHIIj6lK2lxtDjUxLF6ooigO9VdTT1Vq7YhMlkEeE
 mu1MTOuPYIn+ehz+BUB/74YbDN9eXPn3T4yimdRfveNtXQdhu5BDbU8TwpyF7m+uefPh
 7MDS8WbgN2gqHl2COnrh0qk/RosUqbR/qgMzkhRURTAuXQogvfxvomG6pwqvxOVnlIi/
 Bu1GNDqfvd+6qOsD9mNxxWyUdDBSuuTRVEiDOzIZ+5dVrI5uI7FhAAgZJ40e7ASNFlFo
 kM7X0KoXnHFsM7sxGe7totj6wfHs7tkp9332JlRmb+yz6PY6QRAo06lgn/JsB7/hpQgu
 iseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758679662; x=1759284462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpDWwmGB3FDcx3IksRaylh4MrMqkVjqSJs30QhIpAxg=;
 b=kSLC10Gtdq+AKSriFd8kOntZS05t3I840aA/X3h7QJoC5Wc3rhDStcgyp9nTC3QRHe
 mG2TrjK5dKh8jtsXAeclUk3Ho3B9WbcPmkw7Vb0/ew4He3QzA2aSTn0yiMnAQGt2akTM
 6ed1nciQszpo2OQDa7wJIESVAORIAg5vpuo4FKbg2vMXIeGZTvkXS1zYWIgllD77Nz0M
 rZCzduD09rE2r8hjzfRzxwdt8K5OMrNvUWC5AnlYk+06dguCynECCSI6AZgQgmkWUspe
 6aTjfsoAN06oQjj5uK8srZjoC7RH8HcsznKoBMJE0+Qd97oEyKWJpTDrwbqX2Lwx0Kep
 dfhA==
X-Gm-Message-State: AOJu0Ywyb2nGg0gZskfV9hILQwDytBmuSslvvbMdZxdqj1FrR91Mr2Fq
 k6nX5VGGue+t/c+lcjyIBad0WTIa/2qc+yClShMDWD3k+zEx0Yg2dshyKH3VPlvjww/GX8PTb0j
 Zdkmw
X-Gm-Gg: ASbGncuvFXBx7g2wLe7CgKBtd/MKCJUcjg262MA7TWp1p1CPiq44Bci8ygoy+KhcvGy
 7ZzqIuSMPLGel7z9+B97d0WOExZPc00BqZ10rXYF3LBzr2V27y+t4xHynkWpXOwwpRzWksgMS5D
 o794VvAy7u5pk2xjJf4kjPIUAPGaUbmsdchSdXmE64AJ1XwnUxX2Q32qLIL/uYaquV2K52QPFlu
 /GVR5h4LKQEYNeayc/elP+AkYRfiN354aXFemZwdOwEUqagIaE3ILfoUnql0bIvRD9IVJOsXwk3
 uRp91kQ86zgkPcRk2l3qPnWBKnUl7668tXXohsfEhXShCI8iUoirQ1P5JVl40nb8NGviBfxlWEq
 PM7AfV7FOAZiFNbFy2x8J/zh7avpnqbfxvW9OvC4=
X-Google-Smtp-Source: AGHT+IEV9YOSi1IisUEgR8K0mA2ffn94YvICW/k2Jx1BIJdgz//uM5/Le8u4Q8s001D17q1kTOPC4Q==
X-Received: by 2002:a17:90b:394a:b0:32f:469:954c with SMTP id
 98e67ed59e1d1-332a96fb67fmr4816850a91.34.1758679661859; 
 Tue, 23 Sep 2025 19:07:41 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bcd9afbsm565664a91.0.2025.09.23.19.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 19:07:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jonwilson030981@googlemail.com,
	Jon Wilson <jonwilson030981@gmail.com>
Subject: [PATCH 2/2] linux-user: Support MADV_DONTDUMP, MADV_DODUMP
Date: Tue, 23 Sep 2025 19:07:35 -0700
Message-ID: <20250924020735.3909216-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924020735.3909216-1-richard.henderson@linaro.org>
References: <20250924020735.3909216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

From: Jon Wilson <jonwilson030981@gmail.com>

Set and clear PAGE_DONTDUMP, and honor that in vma_dump_size.

Signed-off-by: Jon Wilson <jonwilson030981@gmail.com>
[rth: Use new page_set_flags semantics; also handle DODUMP]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/page-protection.h | 6 +++++-
 linux-user/elfload.c           | 4 ++--
 linux-user/mmap.c              | 6 ++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index 5a18f98a3a..c50ce57d15 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -30,7 +30,11 @@
 #define PAGE_PASSTHROUGH 0x40
 /* For linux-user, indicates that the page is MAP_ANON. */
 #define PAGE_ANON      0x0080
-
+/*
+ * For linux-user, indicates that the page should not be
+ * included in a core dump.
+ */
+#define PAGE_DONTDUMP  0x0100
 /* Target-specific bits that will be used via page_get_flags().  */
 #define PAGE_TARGET_1  0x0200
 #define PAGE_TARGET_2  0x0400
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 26c090c95d..b213f1a35b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2120,8 +2120,8 @@ static void bswap_note(struct elf_note *en)
  */
 static size_t vma_dump_size(vaddr start, vaddr end, int flags)
 {
-    /* The area must be readable. */
-    if (!(flags & PAGE_READ)) {
+    /* The area must be readable and dumpable. */
+    if (!(flags & PAGE_READ) || (flags & PAGE_DONTDUMP)) {
         return 0;
     }
 
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 0b69efe54c..35698c413c 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1254,6 +1254,12 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      */
     mmap_lock();
     switch (advice) {
+    case MADV_DONTDUMP:
+        page_set_flags(start, start + len - 1, PAGE_DONTDUMP, 0);
+        break;
+    case MADV_DODUMP:
+        page_set_flags(start, start + len - 1, 0, PAGE_DONTDUMP);
+        break;
     case MADV_WIPEONFORK:
     case MADV_KEEPONFORK:
         ret = -EINVAL;
-- 
2.43.0


