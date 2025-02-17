Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25796C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0qA-0002wc-3o; Mon, 17 Feb 2025 08:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0q7-0002oo-Lf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:07:11 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0q5-0004qo-Pj
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:07:11 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220d601886fso55753125ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739797628; x=1740402428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fF0xXoskNTP3E7oiZ/UkECykSfMxXBb4Zdq1BDiDxuU=;
 b=RfN+EPQSS+s+1FApesuIFKuqLpIg8FpeGsnpIabQs6ofD87ohQZ+4/CEihnZ7a5E6G
 7sqXHKXHb+iMmK9FcQJCNurb1Lggihwc43+bQwwEyylf06UmtaVoMm6zjocmgRLzCKaM
 FiIlOV6kRoxJRHGJDUSINkm7J6iSidBiwTwfrtpJtOLZI4bE6jmFtfTnRcIIPgYQtZKp
 V5KFE+64Jgcnz9VzQJMyeeA3/pleGjFRNqR/Y6toamMt/9wMdYKgGAIt6ry+C/wIAqZt
 IfxQrSFh/uZ7wMjeOImOudNltGaz6OsOERE0+/3WezGtwE93Qc3hgBARxVtczsNqLeDK
 NZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797628; x=1740402428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fF0xXoskNTP3E7oiZ/UkECykSfMxXBb4Zdq1BDiDxuU=;
 b=QwojVe8xQ5NMs7rgo6pwDA36PDkQcSyIcyzR9Mxdl3wBmx5gSdu5BoCiat+tf/4MRq
 eiAWRSPGIY46Q5n5u8gEvyG/O9YGi3TY1Qqk6gX3c+Kikz9Ng9WLm3urTj+XM+nSwuBY
 falGXbMv/bm/2s7VAFlR687dheEJxnfmBqOTq/mCYSvvq+ImUFszpLDF6Co9xqpoLGca
 bn8ew02R0iTWXh6uDr+eyzinWzT02C/4YJzlOP4R/c9+6Y6mihK1DoPQFZ5bRGl5Jtbk
 W0DNi9cQl27kY1wxvzIK0vLsUA8musRz7jSN5fbLkf0zBTGTeoUSdGpTPtMcgQvIfGjn
 j63Q==
X-Gm-Message-State: AOJu0YxgsH+6XFgP2AL2jXpPYHEysFyQ4ormbvbreYWXLipOWFFLVxhM
 S7cNtGwAg0iVVDemNOcoxd1yJ4Ov3J24YkhuaC000/uBGh2GccjlrM8IDW8vYFQ9XTZC3xh5Wj8
 SA+c=
X-Gm-Gg: ASbGncuImAbxtL6b70uuu5hHvODZYM4ZE+FhxvkaExzB0Y1MDfKeaRgl5DkSoqxNVOH
 AaArU+zODOEXU8xjSRNE5OcejTvatsrIWtRbUtU0GKKh2DK0GbibSu1//LT+2SByfQXLfzOg2tG
 hSKP62lqpG2Oo/aq0QLMclKH5noMNQ4w/Lnq3q300YDW3Tcv8rBMLj4BcWDd7LzqfATAlyNfp8x
 w9Lr3irwqT+nDCvZ5xAFBNNFOSf2vkFfiXE138gcN6/rayflXgDoVHR598pJ42yg/4lbskrXFuh
 KV7R5g5rTyauKBZnLaMPFfoBh9xfxFTBK/HEkk0h5zU=
X-Google-Smtp-Source: AGHT+IFPQpPDy/cezqvNEv9XY8iEXFjhL0sQzbEoZN+4u/iZepNQE++4OS2Crbaxlua+gd1s+jilTg==
X-Received: by 2002:a05:6a20:3949:b0:1ee:bb7f:9b39 with SMTP id
 adf61e73a8af0-1eebb7f9e9amr1558071637.1.1739797627824; 
 Mon, 17 Feb 2025 05:07:07 -0800 (PST)
Received: from localhost.localdomain ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732771a01bbsm2490735b3a.78.2025.02.17.05.07.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Feb 2025 05:07:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] accel/tcg: Take mmap lock in the whole
 cpu_memory_rw_debug() function
Date: Mon, 17 Feb 2025 14:06:08 +0100
Message-ID: <20250217130610.18313-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217130610.18313-1-philmd@linaro.org>
References: <20250217130610.18313-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62c.google.com
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

Simplify user implementation of cpu_memory_rw_debug() by
taking the mmap lock globally. See commit 87ab2704296
("linux-user: Allow gdbstub to ignore page protection")
for why this lock is necessary.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 20933bde7d4..b5230ce1837 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -380,6 +380,8 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     int ret = -1;
     int fd = -1;
 
+    mmap_lock();
+
     while (len > 0) {
         page = addr & TARGET_PAGE_MASK;
         l = (page + TARGET_PAGE_SIZE) - addr;
@@ -414,11 +416,9 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                  * be under mmap_lock() in order to prevent the creation of
                  * another TranslationBlock in between.
                  */
-                mmap_lock();
                 tb_invalidate_phys_range(addr, addr + l - 1);
                 written = pwrite(fd, buf, l,
                                  (off_t)(uintptr_t)g2h_untagged(addr));
-                mmap_unlock();
                 if (written != l) {
                     goto out_close;
                 }
@@ -454,6 +454,8 @@ out_close:
         close(fd);
     }
 out:
+    mmap_unlock();
+
     return ret;
 }
 #endif
-- 
2.47.1


