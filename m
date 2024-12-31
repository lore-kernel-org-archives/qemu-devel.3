Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897C4E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 02:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSRdy-0006SH-23; Mon, 30 Dec 2024 21:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuqiang.wng@gmail.com>)
 id 1tSRUw-0004pI-Ml
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 20:56:42 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuqiang.wng@gmail.com>)
 id 1tSRUu-0003sv-VY
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 20:56:42 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2167141dfa1so124364765ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 17:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735610197; x=1736214997; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zvuT9FKOXYyWdztPcn6rB7JN9T8nOggUTHlm7D0ifFY=;
 b=mMDw9awqdLNX4JAVvlQP9c52APX7dU4FWdFPdrjBSiFCg8BTp1hnSs+XmeEqCeIzd9
 Ak4MEIl/vfvXYNet9P8Kpy3UnQIVXPum2Ih82JiugME/VAGa6EI1gg82+NoGLh+XUwdM
 PlciBtWpwJ72GFz/f/SuMifQovxk2wIE40sFQGcx6f8Z0dBcIwzCSj5T4MN2L5R9+LC8
 IgwUo7Of9P3a/HAyjrMhaf/xx2crIRVn1cBSdrzm2qgaaebn1Q9c2T+uBMkqog2htLqY
 5QSBG+iEDcyO4qfa6aCH1VehqO4phhjRgPLPCtW1S7u0hPrEGOf87Ve2XLDgYJ7HJqtZ
 a/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735610197; x=1736214997;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zvuT9FKOXYyWdztPcn6rB7JN9T8nOggUTHlm7D0ifFY=;
 b=hWywVz/TuhA12XTK9UGx4c9zBR/V5ElPpoUmQoTY4Scr0D09RHsvr8Nkbb5cTUTVDD
 22mb8fQR4vJ4eXWVIThKI18BLw/4zRqR8+lro5/zRhcfomQJiesVP2gSla9eO0jnAVA5
 4kcsy9e7GQJt6ilaWLGQ/zwHjVGzV86r776+yMOXqYkHM4YKpzK/92GdPfmygjDQV6iu
 wf83a9oas4KM1vCvuzFGemSDnGKsYhLGPmHOEf28Sfzx2binjq+k32hwy4DVVPkyv0be
 TdXm/mEYmwRs1BPWoFvZ2LnXL1BtjQ6l5aUJwJ52rVzz3rJ1Z/ZZmsafML6JpQTR3T0i
 Ku5A==
X-Gm-Message-State: AOJu0YytkI7pG1+YijSh2baD8QUsD0m9G4iC4/brotK8/8w0zYW55bld
 k4Vp6W3CEWkAH/i6vNdaiM5aSHcIGrHk6KqvYzreW6cegOD4Pgslb8ZVDYLlvHg=
X-Gm-Gg: ASbGnctc0C+NhmQAsVhVkCwjhMjaIXL4JkaSb+tAL/KRWyx5qsufdjETx6Qs4X+izev
 UWwZrDmT/jz28SiQbO2uKJ44z/niK0eiKHys626N17IO9E1bi8oOiCcAIpbpYuv6kq/CFgxaNBN
 uq7WK/NU8V+9we4c7SVBl6xQqnCYTQMGNWQKjqeOv91XdxxLSZ61aoWa4b0/mguN1cxFf3KW7n3
 EBLI1QYSmDm0et6Wh5wwNqYCaHaFGzmXoWUYYc3abK1Hm8eO2UmMfdtDDsz/Wnsqa6gt2LyyLh+
 Mg==
X-Google-Smtp-Source: AGHT+IFlmt/RbcGWF7ld7++qPRx2yTOMi8WB7gsMLM7Dp2tHM36reqNLdOBz0fdw9+V8osQfihDz6A==
X-Received: by 2002:a17:903:2ac3:b0:215:9eac:1857 with SMTP id
 d9443c01a7336-219da5b9caemr557937605ad.5.1735610197259; 
 Mon, 30 Dec 2024 17:56:37 -0800 (PST)
Received: from wangfuqiang49-vm.localdomain ([114.67.220.238])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed52dfffsm23445223a91.5.2024.12.30.17.56.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Dec 2024 17:56:36 -0800 (PST)
From: fuqiang wang <fuqiang.wng@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>, huaminxu1@jd.com,
 fuqiang wang <fuqiang.wng@gmail.com>, wangfuqiang49 <wangfuqiang49@jd.com>
Subject: [PATCH 2/2] improve precision of throttle_pct
Date: Tue, 31 Dec 2024 09:56:14 +0800
Message-Id: <1735610174-37467-3-git-send-email-fuqiang.wng@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735610174-37467-1-git-send-email-fuqiang.wng@gmail.com>
References: <1735610174-37467-1-git-send-email-fuqiang.wng@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=fuqiang.wng@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Dec 2024 21:06:00 -0500
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

Using the current algorithm, there are issues with precision not being
handled correctly during division operations. (Even though double type
casting is used in the function, it does not seem to have any effect.)
Refer to the results of the test program from [1]. When there is a large
discrepancy between current and quota, there is a noticeable error.

The main derivation of the new algorithm is(For current > quota):
                   ring_full_time_us * current
    quota       = --------------------------------
                   ring_full_time_us + throttle_us

                   current - quota
    throttle_us = ----------------- * ring_full_time_us
                        quota

In the actual code, first calculate the value of
{(current-quota})\quota} and store the intermediate result as a double.
Then, multiply it by ring_full_time_us.

Test scenario:
- generate dirty pages program: tests/migration/stress, dirtyrate is
  about 1500MB/s with WP enable.
- dirtyring size : 65536
- dirtylimit: 333

To facilitate testing, merge both the new and old algorithms into the
same code, calculate the difference in throttle_us between them, and
track the value of the next non-linear adjustment after a linear
adjustment.

The test results are as follows:

- throttle_us difference:
  [19003, 24755, 25231, 14630, 25705]

  average: 21864

- next non-linear adjustment":
  [16764, 16368, 16357, 16591, 16347]

  average: 16485

Based on the test results, after merging this patch, the linear
adjustment value will increase, allowing the quota to be reached one
loop earlier.

[1]: https://github.com/cai-fuqiang/kernel_test/tree/master/dirty_throttle_pct_test

Signed-off-by: wangfuqiang49 <wangfuqiang49@jd.com>
---
 system/dirtylimit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index c7f663e5b9..25439e8e99 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -281,7 +281,7 @@ static void dirtylimit_set_throttle(CPUState *cpu,
 {
     int64_t ring_full_time_us = 0;
     uint64_t sleep_pct = 0;
-    uint64_t throttle_pct = 0;
+    double throttle_pct = 0;
     uint64_t throttle_us = 0;
     int64_t throtlle_us_old = cpu->throttle_us_per_full;
 
@@ -294,14 +294,14 @@ static void dirtylimit_set_throttle(CPUState *cpu,
 
     if (dirtylimit_need_linear_adjustment(quota, current)) {
         if (quota < current) {
-            throttle_pct  = (current - quota) * 100 / current;
+            throttle_pct  = (current - quota) / (double)quota;
             throttle_us =
-                ring_full_time_us * throttle_pct / (double)(100 - throttle_pct);
+                ring_full_time_us * throttle_pct;
             cpu->throttle_us_per_full += throttle_us;
         } else {
-            throttle_pct = (quota - current) * 100 / quota;
+            throttle_pct = (quota - current) / (double)current;
             throttle_us =
-                ring_full_time_us * throttle_pct / (double)(100 - throttle_pct);
+                ring_full_time_us * throttle_pct;
             cpu->throttle_us_per_full -= throttle_us;
         }
 
-- 
2.47.0


