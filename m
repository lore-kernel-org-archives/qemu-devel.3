Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B11FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdmh-0005eH-5R; Wed, 22 Apr 2026 16:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlk-0004C1-MM
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlh-00030G-RD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso61245335e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888112; x=1777492912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XxTSWpAH8tY0MN9ilU96vSF7le76N/8yRt/4jboOEtI=;
 b=NbJiySVcpHHcDdapHKdEpVtf3KJ37AHphERUi7v1q6ttzBJ40hcF5iRP52t4llqo72
 YqSIcbBrubtxG8j35TcN2IX65y1HYGTS0ZQEjkKfSsbyJzlqVf8mVHJI+LyOY+wAUbTf
 1cDC7olwpNFG3L4t8N0r9LIXhMNnNqZcVaGdhI1950cl7hCf3MBHViqhDRLvVsSovzHa
 sEeEW4wrm2M2OOM1szFNvAXW5doLFFaYF+P4XSs4Uo1zszuwM35pd4z2atYP689Gk31H
 +qSqOiml+qT4EI+iSlh3vY8gbZsAngafgL2xwgKFNknZpLiEekRFCRO7/OemeEzjtdo5
 gCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888112; x=1777492912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XxTSWpAH8tY0MN9ilU96vSF7le76N/8yRt/4jboOEtI=;
 b=UGPOCwPRmxR3sfXl+2A86a+W3iKBLUmAzE44pTGwa17m2A3S4hSIZmYv9hN74XB2RW
 WpeJv8CbwPvHpwXss0+JHmsCcLaanT/uoNhKRBZV8FaqEvnIfRE7RCP72d3gQQUBF5Nm
 kmBkNlOlQiWXcS3FpVepYmVIDdPHxYVX2Yx/bslnWs2ao3STmGLAFEw4g48BLNzrOZAK
 ReKVjgjw0mK36i0lVOT3Ji9wlebWwhis3X6K8wGdbyOEHzFvxKIE1o+HBNwWkm2KxDxK
 gyMKDMUDcHL3K+LmPEU9w8+yYBQyGm3SskQze9mbPDyTLIDt5siFeZpn6wkgSrvlTDch
 nXrA==
X-Gm-Message-State: AOJu0YwNKJ1WCQd6A6k95LfdepAyDhcME1Flcc2jgVTsc9BNSiZMqk2v
 2haA1o1UUjn2/1gdqIm86KJvxyHTMKNVoaygwJEWdsiZknNxs5hoBfEdNEiOXTzhGXx22eioLnw
 3dVCdwho=
X-Gm-Gg: AeBDievKL/zMcCgng8kV3KTup7Lx5BjGGYc5FGqlPvDjt1VbSX57xVDYezE/OLdyRQX
 on3hLVKgLwlU4LQVSGNIl3xSZtqCZC+D/GyTRoh94N7BK+GH58n9rYtNlk3VpKcyQj8XgvFQ3BK
 QDSOn/UYk9vzPChU9QBiFYdwAGNIzyos8JaPJPJvWoQMJLZOvwqf0u8nGv/YJYgnHclFgmrB/XC
 y04cekKqTdp0GGozEnttdBzO4UNPETbH9TSUaW/LFkUdt1o5KDuFF8AKqcQgoeARV9LhyriaP4c
 x/6fLlTr1Os8lTeKuXhPkXT22H/t24cCtCeTumYveL5cAFgaocC5OqwQKHHS7UmyzGHOJbFFftc
 z8e55PsTdkNdOnoIGNWnNXAoaOV4R622bA42qApY76dB1O6rJ+PAK1byxUtqAdxsPr4zjhpt2UL
 aFIThUxeI0OaTvPITP2+s4KzYOIDa3EEemd+nD88i8hJCUx4znwpUhgblgqLEfuFC+Q4Wjx8+IU
 aCHwzyokw4=
X-Received: by 2002:a05:600c:c112:b0:486:fe83:861c with SMTP id
 5b1f17b1804b1-488fb896910mr276046575e9.7.1776888112032; 
 Wed, 22 Apr 2026 13:01:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393f5sm437734615e9.9.2026.04.22.13.01.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:01:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/48] physmem: Simplify dirty memory type checks with loop
Date: Wed, 22 Apr 2026 21:57:32 +0200
Message-ID: <20260422195746.88865-35-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bin Guo <guobin@linux.alibaba.com>

In physical_memory_range_includes_clean(), we have three nearly identical
if-statements checking different DIRTY_MEMORY types (VGA, CODE, MIGRATION).
This code duplication makes maintenance harder and increases the risk of
inconsistencies when adding new dirty memory types.

Replace the repetitive checks with a simple loop that iterates through
all DIRTY_MEMORY_NUM types, checking only those specified in the mask.
This reduces code size and makes it easier to add new dirty memory types
in the future.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260401100005.20651-1-guobin@linux.alibaba.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 4e26f1a1d42..c58d940e807 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -981,17 +981,11 @@ uint8_t physical_memory_range_includes_clean(ram_addr_t start,
 {
     uint8_t ret = 0;
 
-    if (mask & (1 << DIRTY_MEMORY_VGA) &&
-        !physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA)) {
-        ret |= (1 << DIRTY_MEMORY_VGA);
-    }
-    if (mask & (1 << DIRTY_MEMORY_CODE) &&
-        !physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)) {
-        ret |= (1 << DIRTY_MEMORY_CODE);
-    }
-    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
-        !physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATION)) {
-        ret |= (1 << DIRTY_MEMORY_MIGRATION);
+    for (int i = 0; i < DIRTY_MEMORY_NUM; i++) {
+        if ((mask & (1 << i)) &&
+            !physical_memory_all_dirty(start, length, i)) {
+            ret |= (1 << i);
+        }
     }
     return ret;
 }
-- 
2.53.0


