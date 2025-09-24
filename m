Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3FECAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 02:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Evf-00038p-HC; Tue, 23 Sep 2025 22:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Evd-00037u-5t
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:08:21 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Evb-0002e2-7k
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:08:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77d94c6562fso6292998b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 19:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758679697; x=1759284497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpDWwmGB3FDcx3IksRaylh4MrMqkVjqSJs30QhIpAxg=;
 b=uQvw/9ESLMKiSMbhCF3/rtAmQn+coYU+sMJa/rziAxt7ZDLQaMWqwWAXKZgoRTPT7L
 X3ojBzeXTfYFc8TzFKZrZvt4WESe8iRxGHdqi3yVJVLhAXTvOBzwSyCijpPKyngZ1m85
 YNoUcnHvRrIRdco+fxJTEUU85O2peBaIOdZp3q83bDMVOFIiOqutPSHTtTqj4NTzMZBC
 mip8VRCw205N2krmPDqPOVDSfRKZu9i89gyBNVjBZF+Rq1WhfJ1Kx9FrZtvxZApHwqMw
 JrqXKaUFYpw0V+bSUR3sg1uep5RogON+Gz6FtN37Q0xX5N5UfXPCpwLGVPMV2kfE0Njp
 zY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758679697; x=1759284497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpDWwmGB3FDcx3IksRaylh4MrMqkVjqSJs30QhIpAxg=;
 b=muhqvANPOzorRDbklc/qOfbkwrX2AXUGR4MS0/iQC/GxzIshxe5JTb7uIqSV+q6E8u
 koOFgGTu32eTaU/9tlXYL9RjmnFO8teSxHyhiwb3OVd58qXvLCiIiTySQsebNDxNTOM4
 Pt+ZTB/f8Ob0u5OzTC1Fj0U6TPD6RFzyDGLjrRqaHORCyk0dWGa91++rWJpvTvSd4F/9
 BIYEeCD4KHJBwa11wNRzIqkZAFJ+de7CyNB4e2G/3GPJV6vx81X5DBgjTO7kWXeF+hz0
 kjYYAdwfIZQSfSOq+QY/+6aPoFV723ttaBqVFmI6/HE4lRDNtff/WcVqdeC2jl5yF89O
 bD7A==
X-Gm-Message-State: AOJu0YwVay1HaDwncFtxUAh4mMUKjrZ/lKOkLRxSz0UZpYL3UySsOG/y
 /MMYrzYsJD3pRFM2cxZV3rPctK3mXtHrdUoTdaDWfh99mIiGer85QJehOhKwBUSBK0D60YS4Rt4
 cbVeF
X-Gm-Gg: ASbGncvleVhknUJVevA3ryYbdFVj2bvQHvvjSkjovxmUkdIiw5bN1LaBcRnwEvaReYk
 gM+uJWBCUsQ3eCfJokQSJyrc8kHuByHd0yAcvH59rZAEtr30Vtu3TfHppognEK0ddQitDQBPTcc
 tpu8MIPeUSj4CA2XnoMwxHU3yYb8GPCg/S7RSft3uz93ow2/dLJeMk3zxuZLoQqTLBgzJP21/bj
 Sc9my2mnufL7JhnCrYeNggFtzLprAfMR/ymhYxKr+HMyQ6QOzyR+hkkZK8sAM68k5BBE++MsnZg
 NuHsEwkgOu+GmVSKeZRcj0qfmH/tfOhQZTK0ix+ser5juzS7BGtLAiPYyfduTVxjfS+CePMJ0t1
 wE6tQK0eoBidfCpRXDV7vvEBTzrKp
X-Google-Smtp-Source: AGHT+IHTpJEH5+aN3OlfIsrxQV5OWGFwyEgajXBJiTsfggLwyDsOwSuIfiSLedJHCTtZ9O8w+B8nxw==
X-Received: by 2002:a05:6a00:889:b0:77f:3f06:1f69 with SMTP id
 d2e1a72fcca58-77f538e1402mr5382626b3a.12.1758679697274; 
 Tue, 23 Sep 2025 19:08:17 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77d8c3adfd4sm15929130b3a.82.2025.09.23.19.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 19:08:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jonwilson030981@googlemail.com,
	Jon Wilson <jonwilson030981@gmail.com>
Subject: [PATCH 2/2] linux-user: Support MADV_DONTDUMP, MADV_DODUMP
Date: Tue, 23 Sep 2025 19:08:13 -0700
Message-ID: <20250924020813.3909287-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924020813.3909287-1-richard.henderson@linaro.org>
References: <20250924020813.3909287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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


