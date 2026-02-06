Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB65CEE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQSH-0000HO-9L; Fri, 06 Feb 2026 13:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQSD-0008Q3-9K
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:21:18 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQSB-0005Bj-Jx
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:21:16 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso2131993f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770402073; x=1771006873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cs362kMbV2ODMlw0HAxMKgT3XjEZKtDm9LphEc59vjc=;
 b=NMoIAXblz1SKQq5sOTA3zSEwKDpBOowhc3FAPRsen13ODmdvVboddeH5qvxiZ8tC9L
 Axu5dA9wM/T1T1B0SkBgeFWotvUjrQjZLW+gu3TUzlnUES4KNml9QU/5ImxRkg/tE1rm
 WYqK+gW7haRg5T4ygpNpXLe2ViEcmK6IlMWpy1f5/quO1cjxEtEsDV+2PYyMwMz7Pyvk
 VJi9QAj3uBI1mJMjp7ku7vN2poLzNYWaJmarrT7LJK7qje7gcSSfpujFUHeR4OvBcUCG
 FjW88glTpnigY93ve6lsYklhK7ml5aioU+PaMWTjpbyFGYPih9VAlhpQzlhqD4OGX/0j
 yZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402073; x=1771006873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cs362kMbV2ODMlw0HAxMKgT3XjEZKtDm9LphEc59vjc=;
 b=wHbhzJDMDK7rvjlSCYkVNES5g/bS9/GWnwu2hfjMBh1oCnKjgxVQ5uNylF9NQgJT/G
 O9rTWZUD/OrGGmSK3MJ4fJx4kpIRPmmSJs+GN6MTv/KbS3kCaHY1QLgGt6Ut9bBgOSc4
 ecNK56YM8e1oJUW16HveaeXIxbJmZTvIexkqJYg/o+V6NgYOUMkbjmmqHTVUXGMaTsMo
 EmYhDUvYOu1jxAAHMKD1UvXgqlJARHpbhbmBvHDPfZoZH1Kr11dvjilaYxqtMpM5KBfr
 Yz/zlVdX6O3EAGzsOYwoc4QYtMXPS5kdpYUa/Swk/BTQfwBkZeugJlU0xnEXBqasOE4/
 RHXA==
X-Gm-Message-State: AOJu0Yyid2nBVEdb1J8lpfWm8cI3PPXjmZ42PpwODuxT/da08pS2ckAM
 b8jEh+npIyVHzEQE9CGlnpQkGpwCu63RfZFhKW+bZ+576G89yMYlmRZJvjRErJI5kAkH1xwJiQ6
 IedjCL4Y=
X-Gm-Gg: AZuq6aICPOpQF8gHwiWencn6OnXsU0TybNksGY8Eyy8zwMeWsg+NsDbKfDbxpFIIaGm
 hafYY3GfLGYVahuM/wBvVi+weOAWUQOygrU1wIZDDw1BhBBOCTcR7br2MNGoNEjK9EaN18F7swO
 bdhU6rPvjpck75fhJsHQZ9XTe4Jl5NCiBD9Rr+zhQC7QvNEiyCHSadCkvHSGYiYNZ3pl3ReLebU
 pxchgcSZPYO8qyvjY8ljmtRPGBvnvctiipjeu8CZBcVKO6LqPclToh25/Y9JC2GZslo7XkN7aFN
 ssaAUErqIJ0gzUNtr1SJfxo0zVXGTtK+Ysk+VHq+1Iinzrs2Ju6gDbCyd7Hkc+zU1xTkYjSV6Cr
 K4aDcjQK+r62XcRM9kaQ1cdqfDoKjaU6PFqQhT+KZcFhz3NQozRPYSpQviyc6KNDhlM8Jl0sg9+
 aUwpD8F84f9ZTEpJXj25zvkTdcTsB3LPzb5AJHmiMpahXJjsrDubYVMnZ3pgxS
X-Received: by 2002:a05:6000:2406:b0:430:f2ee:b21f with SMTP id
 ffacd0b85a97d-436293448eamr5865504f8f.22.1770402073077; 
 Fri, 06 Feb 2026 10:21:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fb16sm7616411f8f.25.2026.02.06.10.21.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 10:21:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/10] target/s390x: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
Date: Fri,  6 Feb 2026 19:19:53 +0100
Message-ID: <20260206181953.18683-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206181953.18683-1-philmd@linaro.org>
References: <20260206181953.18683-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The s390x target is a 64-bit one, so tcg_global_mem_new()
expands to tcg_global_mem_new_i64(). Use the latter which
is more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4dabd49840f..203afe265bc 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -217,9 +217,9 @@ void s390x_translate_init(void)
 
     for (i = 0; i < 16; i++) {
         snprintf(cpu_reg_names[i], sizeof(cpu_reg_names[0]), "r%d", i);
-        regs[i] = tcg_global_mem_new(tcg_env,
-                                     offsetof(CPUS390XState, regs[i]),
-                                     cpu_reg_names[i]);
+        regs[i] = tcg_global_mem_new_i64(tcg_env,
+                                         offsetof(CPUS390XState, regs[i]),
+                                         cpu_reg_names[i]);
     }
 }
 
-- 
2.52.0


