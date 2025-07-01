Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F97C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcCE-0000PE-3G; Tue, 01 Jul 2025 10:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBx-0008Rx-JI
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBq-0006zf-BU
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-453749af004so31491235e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380940; x=1751985740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7czh0UpphEfhU1XJFzgghIJVXGp1wbIMbp91nI0b7w=;
 b=XsctoRyMwRFjWe3WM7goYqxQzyhGek9HTy1oxfV2w5OQJriEre0+3ZjnycfuE0F1fW
 97y6UPytE001wPJvLytawN+/urCte64SAhTs0ufx/XPXvPkAIUQTR+Em43o09nKcVzvy
 Jc6vx5L0Z80eDbhe7JTqidu8NxqYfaeivR/kr6PPEYdqP1mO4gP3b2ctP6fER/Epkuee
 Cn4sQq93q2MomQWGpvJ1InX3X3BGrbzwhIIm7SA5/To9xNYaUki1wWsdstR0JiExW0fK
 tuQ27C1fSK2CuCAHETUderkcEC129qii6Vtlc+VKRmyjGwD4oUgUJnObtV72Dxx1f2Zo
 qNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380940; x=1751985740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7czh0UpphEfhU1XJFzgghIJVXGp1wbIMbp91nI0b7w=;
 b=S50WfZBDiv9Vd0/vLevGHRB5Tjpwa7wdLVmVXzsQ9MrENLXs/LXp2LfCbUaU8fPrr0
 vwv0Kz9U6C9IJO51dKzEywmtQUA19rSwDDQ1glxgISokH43E/2fZAbpV+wQBUS/llVxz
 dQWBmQTqPTxyfhMiadG6KQbBLhbDOIVXdROoA5Opwym8VwVshmjTdtZp+fEY8If8O78T
 lRWgRgPZOv3Df7JufOJfLpZgOXy8qN+CcOKYWzT59QDla6FmJqS/bxIVvfnoVnGPwjlc
 Wjq1z7prq+CyVf3kKEy1jfKPLPrCRrvmH3SOh7w2/sKVrZPmlMgzxs6ufJqMjoeztepT
 TwDA==
X-Gm-Message-State: AOJu0YziStm9AdONqkQIjz2aTa5WQIdjRr8GAqRtiMBv4ruUeFl5sfzr
 5fZsstgStHSXEJ12uIh4uT1mi1kdLqu/HM2U1eBJUySRheKGct2Jb+/zkT6ZWvS/PgdfAa524rq
 JDi5V
X-Gm-Gg: ASbGncsOB3bWC0Ub/728eFPmMWOi1gKnKswE5CoWkWXA++cl978ca1yT9K5mV+O5fBV
 7KAz5UeeiK+uHfZSEdXyohO2sYF7VKH5STKuL7Oi82WQDSjg07nqkrNlP23d4UUpG8VBVKa0+z9
 P6+x6ntDbi3zdFnMcqTu+M1QCFBdst8MWfXKpP8vg5oIVT2HkK5isBAcDdb+MorL8UY/Xa6gRPp
 ZcrDrwbaAvxMIsPW1kG4mIz5t6OOHbbKafDY16xMoZOPLcJtkVAbz06ZoVSn8tpbKgjjW1RYSbF
 3eT2fBJKG9R0+xgyDLsWJ0ED7TCcLM98qpjmBcbYNwQLAlwGguDF++OIUxAM02YsUU/UC5PcTgF
 +nrF4+XsX4yprzZ0iAdQo8jXCJQHhsLTJ1WOT
X-Google-Smtp-Source: AGHT+IGTmEw5CpiuoqoKCuB4ef1Buqx1fcm/24fB8+6JKolsDHnB1MyExyLovfIzA/p2FNXlI3PuXQ==
X-Received: by 2002:a05:600c:138d:b0:442:f97f:8174 with SMTP id
 5b1f17b1804b1-45394de29aamr153470745e9.18.1751380940355; 
 Tue, 01 Jul 2025 07:42:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a421434sm170100685e9.37.2025.07.01.07.42.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 22/68] accel/system: Remove
 AccelOpsClass::synchronize_pre_resume()
Date: Tue,  1 Jul 2025 16:39:30 +0200
Message-ID: <20250701144017.43487-23-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
 include/system/accel-ops.h | 1 -
 system/cpus.c              | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index fb199dc78f0..af54302409c 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -47,7 +47,6 @@ struct AccelOpsClass {
     void (*synchronize_post_init)(CPUState *cpu);
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
-    void (*synchronize_pre_resume)(bool step_pending);
 
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
diff --git a/system/cpus.c b/system/cpus.c
index 98ae8b1e271..2c3759ea9be 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -762,9 +762,6 @@ int vm_prepare_start(bool step_pending)
      * WHPX accelerator needs to know whether we are going to step
      * any CPUs, before starting the first one.
      */
-    if (cpus_accel->synchronize_pre_resume) {
-        cpus_accel->synchronize_pre_resume(step_pending);
-    }
     accel_pre_resume(MACHINE(qdev_get_machine()), step_pending);
 
     /* We are sending this now, but the CPUs will be resumed shortly later */
-- 
2.49.0


