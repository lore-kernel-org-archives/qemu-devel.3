Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E45CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FM4-0005jO-0g; Thu, 02 Oct 2025 05:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FLz-0005j0-AV
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FLq-0002RX-CA
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:11:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso4891935e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759396299; x=1760001099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBh/Z7iC7gam28+5s/jAixlIhv8zxAgNTRwgjWSp/5o=;
 b=lrFyMS8U0RZXKWgwNNFtG2ot29k5SKU5rNqkGwa4P9qi/N3FmzjLqhg6FWnrdWPXJ7
 nUUiiwKM1Qgcd12ekxoOECbxHNN1UZtcjAAh4brLzj5FUg5AwYS36oyTLJQGgd5J5gM8
 cP3kzurVf+kUM6zpfrBzZX4vaBgervDjZzzlzgbxj8wwev4+lqKJEoQHFPWkZ9wAgv+P
 LMXuviR1XvH3iwjMlvZoRfFYpZ6tM9KCZBxgvOqg/j8B8ys4+fC7ESPPVSXWQ54n30PP
 qIYZGvBROPJYTxJF3kUlp6ycY22WYsbx74T5MmxCyJNQAZOKxWKgYfXNw+wR6IgeuZ+m
 F/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759396299; x=1760001099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBh/Z7iC7gam28+5s/jAixlIhv8zxAgNTRwgjWSp/5o=;
 b=a64PPGrSZmyix0tpfkIQPKyEqEHaB3Kws3XGlH8GylCuTbMekMM+P2IYQSfJxAiK+n
 ttZsUGcWWps9G9hgcs7l4ZbbwLs9YOwEDN6U14V3Ip8kxP6uIfcqssJO5Scm8YyWAFEw
 J6tTdCmJcuILcHMyx1X/op8QT4zH/o41fbj5tj/IprzZ465lqhe5sH7MfSIF6DSp0I0U
 PotjYh9ZXHODdL+NoD82GJa5vz5cNqSM1qyYmg4KGE0J4mvMIZECEKF3Ih/cjQVcDR2c
 vejwY8lV5Hq3CpHru3Jn1utRMJJ52NTf3hrBirUeI2LToUFWkEpXPMQT7aWhgYb8UaZg
 tEWQ==
X-Gm-Message-State: AOJu0YxvteE8Goo87LE1MeW/xCDx4OU8my3e+j3LqpQfzKiINCOxVRne
 mI3pCvZaaqnx/Z144NLrkH6S3ixEQa2hkxez4cIrL8WG5NEXbZ+oWtuUS3RqxQYmZjgu7fwCqx5
 ncoq4MLVzZw==
X-Gm-Gg: ASbGncugrv/WGQFGrhRFRT/TgSXkpqQBHBk/ABUJ3mu4Bc3fn6upWE3S2Yx9GuE4bRM
 lUp9Vtxa9jJpEEwXUK4M6jJ8SS5ce4xyg+l7/sfAsDqPAHoUAxx53IK982yx0ZeEPlWbH7YovP1
 /tQ3IR4Cnl594WP6bjcEu8rQNMJrqoG+8oGkuUTO8rHEAzf1P/GLwz3xJuWoAm0Xxh03jxCjgJA
 OgEBtEGO1jWSAWaCLTZg1Gt6m6M6JeU7ISUVhrtMEI946RaPQxKTCgOF1Rd9h0tYieM5737cdzl
 HNtKVqGpfWREUNzXDhU9s2g46u3Ss0pxcLJv1KrEjdBJ7A99+/UJXlX/okOw1a2kNA+sRZzAYVD
 13ZVzvJ5elpVE/IHcTwpC6C68y//2szPY9t/NhDGpBZCixaOJtbfsHZ7a1KmY1upzxvhnvRo02l
 Lhws2uYvDYN8ijRrezTKrHpSzZn96m3hbT+u0a+Qpa
X-Google-Smtp-Source: AGHT+IHiqEMpgIHXASESBnzsc92TerJzhQwxp11wKy2nZc+tz5hb9NrUQJxRNjoHxox1tw7PUeKyhA==
X-Received: by 2002:a05:600c:15c5:b0:45b:910c:adf with SMTP id
 5b1f17b1804b1-46e68bef60emr12470165e9.12.1759396299421; 
 Thu, 02 Oct 2025 02:11:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693c9ca3sm25659995e9.22.2025.10.02.02.11.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 02:11:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/9] target/s390x: Factor diag_iplb_write() out
Date: Thu,  2 Oct 2025 11:11:24 +0200
Message-ID: <20251002091132.65703-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002091132.65703-1-philmd@linaro.org>
References: <20251002091132.65703-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/diag.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index da44b0133ed..ed320fc0c1f 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -73,6 +73,17 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
     return 0;
 }
 
+static void diag_iplb_write(IplParameterBlock *iplb, S390CPU *cpu, uint64_t addr)
+{
+    const size_t iplb_len = be32_to_cpu(iplb->len);
+
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_write(cpu, 0, iplb, iplb_len);
+    } else {
+        cpu_physical_memory_write(addr, iplb, iplb_len);
+    }
+}
+
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     bool valid;
@@ -164,11 +175,7 @@ out:
             return;
         }
 
-        if (!s390_is_pv()) {
-            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
-        } else {
-            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len));
-        }
+        diag_iplb_write(iplb, cpu, addr);
         env->regs[r1 + 1] = DIAG_308_RC_OK;
         return;
     case DIAG308_PV_START:
-- 
2.51.0


