Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BF6D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7koj-00078i-83; Sun, 03 Nov 2024 19:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koh-00078Q-Lu; Sun, 03 Nov 2024 19:19:35 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kog-0002G5-78; Sun, 03 Nov 2024 19:19:35 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-72061bfec2dso3400875b3a.2; 
 Sun, 03 Nov 2024 16:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679571; x=1731284371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRtDdUtAOQ8hbWJDgTNy6ROc/6VA9Q2cPv4bY78jXvQ=;
 b=Y3PSFh2PLeI4YXXXfzq4y+S57WjxxAZpNneVdcBQS6UhLV9m53DmHAkPh7fhOYV0/b
 N1tHDJ8kgzdgKAiH10hTPW7FtjONfGD57ci04ezI73QAJsvpATmAAh8ZH5rikKLm0RZg
 EfimqEVh4L25zeCZMw2u0BG9v8869kx4M4RS13im+DtK6n2eLuKmPauTBADOgspYNJyx
 RX0KIo98FPTiK0kWGpLZVjfLNgDlCg+82ZSVIDV9ojrslq3HjLmcWXOReRU6A0X2DtGc
 +9K2QJXPjAXpvx5OVprKwsFOnRPHPtHQ9b/Id8BbD513gs5kk8d2uAkhOxOjXBbk+1Ux
 /7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679571; x=1731284371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRtDdUtAOQ8hbWJDgTNy6ROc/6VA9Q2cPv4bY78jXvQ=;
 b=wgeeSZr89/gnZQc7W7LooD60vKh45wq7bMp2IVZlU79vKOF4WICX7qYAsWPnRR6hWU
 q2XQXrwpnJ+t6zo4J5kmr68a76StK5aDf6KcfdppCZ+WVLgJF4ujYU6+mKV2a2gO/oxH
 OJZLZArYQS3/Dt/6pnpdt8QvPIqFpAdqX+7LKfJ4aTzdAK4aJYy3SMO4IqqXiqKFxQjZ
 3AxWck3XAa6/TWsYGCESzdKiJYeId+6Bji6mpMdDvZkWbbqy8IkiY7D02AXQoQIEPcj0
 /a6tGbNxXebEKUwsfVRZ9DxNrQoKb/sOgy4EcOXy1gQ4LMKVighPgCKztnJ7rIr1pRD0
 +goQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcCzL5CiWjUklAnv6ywNOUCnOPZEzqx7gm05vXlvaxDbyCEePxyRRJowxuU738VtP0WpsvWFA1/g==@nongnu.org,
 AJvYcCWpopvkQiHv33O99aPZVZJtGzemXsxxd2fv8vejQRxqWwQZMM9EedkLfaFdlsu1VAlMbfDNi2S1FN4Q5U8=@nongnu.org
X-Gm-Message-State: AOJu0YwE7XQliDhrsCVOAwvWCnyQbPESHSZEIThryqsZU2WzUd5yJ7w+
 SmXcBZ28V9BGWpRIGkPKI/6D1jIpe90QMSY/Rb5PbawujM3+7+WiukSN6w==
X-Google-Smtp-Source: AGHT+IEYPUgF/yuVF6HC9OqFpJJti0BFo84aY+nmCP39Pt56CW1TWjaQTHKNO2JifwZ+2LNa1caG4Q==
X-Received: by 2002:a05:6a00:4fc4:b0:720:36c5:b53b with SMTP id
 d2e1a72fcca58-720c99b5c7fmr14477718b3a.17.1730679570929; 
 Sun, 03 Nov 2024 16:19:30 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/67] target/ppc: Fix mtDPDES targeting SMT siblings
Date: Mon,  4 Nov 2024 10:17:54 +1000
Message-ID: <20241104001900.682660-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

A typo in the loop over SMT threads to set irq level for doorbells
when storing to DPDES meant everything was aimed at the CPU executing
the instruction.

Cc: qemu-stable@nongnu.org
Fixes: d24e80b2ae ("target/ppc: Add msgsnd/p and DPDES SMT support")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/misc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 1b83971375..f0ca80153b 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -288,7 +288,7 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
         PowerPCCPU *ccpu = POWERPC_CPU(ccs);
         uint32_t thread_id = ppc_cpu_tir(ccpu);
 
-        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & (0x1 << thread_id));
+        ppc_set_irq(ccpu, PPC_INTERRUPT_DOORBELL, val & (0x1 << thread_id));
     }
     bql_unlock();
 }
-- 
2.45.2


