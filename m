Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB20C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84y1-0006ub-Ce; Thu, 24 Apr 2025 18:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84y0-0006nD-9T
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xy-00013t-Em
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so10071105e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533364; x=1746138164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3nBv1wq0iSqHo3T8AiwbSlooRvE9Xfj8Kh+6H3aSYc=;
 b=TJpX3oBJIldCb79w8BLF299QKONtKAmB0K5SeiZe7uavYIb1r3hB1iSa0Fnd2ZzXh+
 633zsWGNk5RGeQdSkbpp1Vnumqs/gCvua7ifI88GmHtnRaxo5QLOsJFKS00ZqH+38UYT
 gSNnoSl7f2v6UjpNR4O9DrwHWhOSEXu25CsAm8PdXUvMy7trGbAjlspJThccjx8SiZmY
 0layp4BtwokMO33/mxrJQbKtwe10xVad4MJDxIwuL05aZckFut12V4ww2YHZ83Y+uBrB
 0i/Aha1QI/yUzqHp7CFmPx8QEu9Ba1laL6gwkYdkcladnGtNR1yOZTW3E/IWbKc9vsXC
 j0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533364; x=1746138164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3nBv1wq0iSqHo3T8AiwbSlooRvE9Xfj8Kh+6H3aSYc=;
 b=I3BJcAexBPBB2l3VycL9RvhgDe0GBItSuYdYPCF6PQQ3XVjM2I7ekt/kNn5ie4bDOM
 m25+FErTwJrcnfCuY4D/id/W9YxBhAe0AVAJkX+9vAoH/FOYhEoWaac47mCrL1fPmHbg
 NBui5g7ex1M5DPjXW+Sl//qRyj6eK7tinJftvoFwiSq1uwG2qPBnI0F68RzAG6uoaUBd
 +SEE46/AZGtBUWDfUiAA8kgTeJUgm7KAKy+4TcITqieAGLBxZKkqqN9HwfX/JJXzpweT
 3s6s9wJrTvOTAAkhpiNvyegMT21puuBz8sc2TJuLKldTV6PtYyH2UJthUAUvqw06S99H
 tNPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWnAJw7JcIKiZb2OHj8hwzw47SqGQnwA55a+O2aINM4EBaFLbei0EqC4EKz++2T0NmFkoC44zgkfkU@nongnu.org
X-Gm-Message-State: AOJu0YykgZBZxW1bKyjdhUH/HnimZnCCoVJ2afCsaYPE+NIK2uKTmY1w
 ALGqRY1K0yqGKVA9FudPO+OfRxa5SOT6jurmLi4sNf49U5gIhXXlSjxFYinwI0M=
X-Gm-Gg: ASbGncscjfN4Vf0Q0w2SkvqxCKO17cTTbkY08+5XIOX/PLfyyJXBmzeA7GY7KHtt9x4
 mN+1gzA3qZShA+x4MUq4bAQnMKQAUQ06HoHb60lDKtQQxjsfe9Ht+G4a1wpMbvKLguTQsCR33MB
 x7XT+V4M04LT8fg+8IKlihFyNrzaDKLVdC2Goowgi09Fic8dgHHMrapwmEAU4FugmCgJigGRQEp
 HgDkmFVNJb5Z9CXQNkwWXWxaFsGC3oyWYTNPbWmbOyKiIAAtgg2gT2OLAiaO6fDAW8DoGpUL2yM
 ztAT6WI0rVhHFqgdsZPQg/lJm0rdI+4ZIi77/jgPqMooK1Ahs5UwKpm33+1MC006X1t697dzUHJ
 3eg+2Ce/NXfbcUupOHjTqR0b7VQ==
X-Google-Smtp-Source: AGHT+IGSg/IdYaeJuRxBRhjXnmgjgKmWquOZYWPhzZlep/8KVdHK3dZ+EHBfBONovSN44DoklZTwRA==
X-Received: by 2002:a05:6000:144e:b0:39c:1f10:d294 with SMTP id
 ffacd0b85a97d-3a072ac9c2fmr771940f8f.26.1745533364562; 
 Thu, 24 Apr 2025 15:22:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46538sm471329f8f.64.2025.04.24.15.22.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 18/21] qemu/target_info: Add target_aarch64() helper
Date: Fri, 25 Apr 2025 00:21:09 +0200
Message-ID: <20250424222112.36194-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
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

Add a helper to distinct the binary is targetting
Aarch64 or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 0224b35b166..395c009baf2 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -24,4 +24,11 @@ const char *target_name(void);
  */
 const char *target_machine_typename(void);
 
+/**
+ * target_aarch64:
+ *
+ * Returns whether the target architecture is Aarch64.
+ */
+bool target_aarch64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 0042769e3a2..7f1758ae34f 100644
--- a/target-info.c
+++ b/target-info.c
@@ -19,3 +19,8 @@ const char *target_machine_typename(void)
 {
     return target_info()->machine_typename;
 }
+
+bool target_aarch64(void)
+{
+    return target_info()->target_arch == SYS_EMU_TARGET_AARCH64;
+}
-- 
2.47.1


