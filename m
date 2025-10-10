Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451D5CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75aB-0006fG-Tq; Fri, 10 Oct 2025 01:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75a8-0006el-FN
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75Zy-0000ZI-KZ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso10647225e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 22:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760073727; x=1760678527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRQbhXdP+qqKIMVw83BfzH46K0TELxGHmMmEZdJGSZA=;
 b=AqyaM079StAAmVzvS9Osh6zjD+6I+nZX3hAMdog9tLrJCEAffM+QCUg830w/x1pW3u
 2K9VZV007jsSVBF/rQjxWukL1sSh5DAgXtP1QFvr5mlC96HrUntdMXghO5tJwyTCJbg5
 9jPUqtCruqhRrdZaKIA6an2jsgpug9QT6u6yLELA1unZWgSt1HHQSLlKTFJS/BRSqP8/
 AcLyNJko1yOKvjT5PZbIj9tnLuN+InltznoktZrrTUNYhi9J234cv6G61HKnwgGR4GQ4
 Ym+CY1g8VYA+zugW3Z4vgoY7SqYgA6f7Fq8TPTMJkmhV/OYyeZCHUYokfYJy3YMGceBX
 fm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760073727; x=1760678527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRQbhXdP+qqKIMVw83BfzH46K0TELxGHmMmEZdJGSZA=;
 b=O5OLu3qVZCft2nwKP7KeO2OFEbVZLujXtX382+c5ZK1gly+yM8wbXfOfswsSF0RqI2
 yEswCId983CisriGhKoapUCNzT138UUexXs4ZZsY4y8d32ZPYs8Xhd0i+q2xz2Q9MvfF
 GVm7W9ZLjilJxe/vsgxg9aSU6aONSgneqNBU57aZ0IYTZgm2dwQ28vummAtNpYUmDsUA
 oovwmSwZlDlLX+YQFriTMiy42S7afUBpJn2WJq1U2J2LIWYZF09p24IDCqsi+p4jl0C0
 mBu6na2MoEyYAm1ekRgm1yQpdx+mLMR5h/XlqT15gVwcptQptJQSiZzIk9G+75+CPjEm
 TUjw==
X-Gm-Message-State: AOJu0YzqnHWxFSK4Ho+tR8AvKbJDrCCFRVzB7+YtDwzELyhxn4VT5b4T
 mcp+8zt4ZzVhJ1ejbKKp2YxYD9OBAb22UWQS3ZyU8WCD78Ush+Zwqts2foYU0CoF1pTe2R/Euv+
 fPH/91URtGw==
X-Gm-Gg: ASbGncucCcOhiDjzI/fxn1V8tCYFIglZ68pTTE2ouitQJVSQcCsT+cCgMeCxRuzlzB1
 Lf1Q6ZsaN40ZFfoZtbqrjfJBWGQbLvzdPc80BLLYLBZCBaFXTI+oPbcXHcG5Rwv8zU9tcyhRhEr
 masfq47UMiqF5/86jPR5MlqmvoDEE2kOQ7Jn0bThRO8/AlYTMPnTo5/C1giHLCHsRd5UGXSS/ga
 9LCwUjR7x9D003+glPfLpYfseLo4pEV6bSeGLvcqTxotAHJqjRR8x6Kndgnc/4Z97k+RP6srPkZ
 jcwqsI/8V0SkikBQdOjhwVJTfION1x5HdxKANZR4YBsY4qB5l+aJhNN0xElVkAPMOc90gQI8EdD
 9qbLBj4zVn94DuEL5YVzrAukgmlVxjGLybH7ReoVmTYvnCbK7akwehhCQCBTzI9Nnmfp7hdIRD/
 9h8aEKr00+k2q98jlDuxnoXA+5
X-Google-Smtp-Source: AGHT+IEoVr8DjNjqEun6+xZCRymEOOvuJIrjvf2F/TPovPpoXkd1RBC7mI3R5abuXLxwtCBuY1rlHw==
X-Received: by 2002:a05:600d:416b:b0:46e:2861:9eb2 with SMTP id
 5b1f17b1804b1-46fa9a8c2e1mr69447755e9.8.1760073727263; 
 Thu, 09 Oct 2025 22:22:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49c3e49sm26109195e9.16.2025.10.09.22.22.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 22:22:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/12] target/tricore: Remove unnecessary cast to target_ulong
Date: Fri, 10 Oct 2025 07:21:33 +0200
Message-ID: <20251010052141.42460-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010052141.42460-1-philmd@linaro.org>
References: <20251010052141.42460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 4f035b6f768..04319e107ba 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -37,7 +37,7 @@ static const gchar *tricore_gdb_arch_name(CPUState *cs)
 
 static void tricore_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    cpu_env(cs)->PC = value & ~(target_ulong)1;
+    cpu_env(cs)->PC = value & ~1;
 }
 
 static vaddr tricore_cpu_get_pc(CPUState *cs)
-- 
2.51.0


