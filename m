Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E05C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXQ-0003M5-T1; Tue, 06 May 2025 10:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV3-0001SJ-RT
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJUz-00025D-Iy
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso36186925e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542540; x=1747147340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=laNSgZ2YaiiHIrfl+xZU7dbvVIxq1VzisjPBXcfl60o=;
 b=qf5jvsgBODS2lvieRoyzoG/TT5lQFacReP94OrBkQHI4X6zawTk395Ym72Z4/ZK4dx
 Zxs4idqMCy/eFzfkzKhqqABRGrF4HgSoyDSzzCGURa5HxMFGx16c5MJ1bguwSOOh7ePt
 JUQCXLlHQ4LCu87EXWrr5oNzSb26Sdmcs9nPbOACG+OnaF6I05AnKrF+pvo74yWHcYJ0
 xU3JZbq45uKJWXJZO/j4Kl6WwGUG8/bLQCdxAbKXew3xB1XuY72r4yQ1fNroC2M8CfyY
 nMkEUP6tYnW03S/XeGw76iuJ2VqaerLdLp/Jx5hPQxx0ecGb+vJ883ldwRy17gUeerzc
 DkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542540; x=1747147340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=laNSgZ2YaiiHIrfl+xZU7dbvVIxq1VzisjPBXcfl60o=;
 b=GiXOix8TwFwcVAHvsrwppesAWp4s0amXWSLxRBGNY/aDu4W+bcqyQb0FjInWUIiZNl
 fzOaNZSN8zocnXBiPRye0dgbVKuCxQzZTC8ktOrYHEpKMDoHHD4W4LxGvs+mqEJKMZP2
 XmlClX7lksvA24I9NydAS9Sj4tjuoyEFGfjGhS8E/0dXdE2XsnUmBC4GCvzizQUZhVlw
 Ax0zyCqS/QmiqIZWRDFf4aMoyyB3kJ7Lydqrx/2L76Vqzb8hXORz9cP3AVS6qvc4sEUt
 /lCMqrNEk1DTQH1dQDcRv0pRkeK15E+6GnsLGEKUdBFajH7YMWO337J0vJ8nrUriNRA3
 KIjw==
X-Gm-Message-State: AOJu0Yzus/ilVkwVQGiW+zjxVJQYCILrRAO/rDlI1acWFvVxC4SlKCYv
 9XrJz/2qnMKbL/T1YDNG4ygqDuveFxdXmrfP6UXtZxaTVrjxG0qvHsFymS/zrgm/8WbFTE3P2jh
 o
X-Gm-Gg: ASbGncvUDdFi48FbNSQEy+WyvjY3YmJKeTw0rVnNEJvyZW0vGkrePHwGld0vskSx0fX
 gIcbDMInttL3yg1zWhHNxCQWmgbhClUOsc7bnco80C9qZnF3tF/I7E7TaHdx6NLav0RKfTLUtn6
 h5zmK0c/Dun7p9zk32Bk3R4wXfVKiB7DEV9tQvQErPTJM7GCZC+xAYQ+5WZHRhmqQhlZeACdECL
 lIOUUeP++qRqT9wdXgubYXPNWUBrODHnCR5Gwo7pJVV4YjnCHKQos8fw86AZAh3Te0JmLTjCjHI
 EsLePJWDYBFMJSiQ6jf0OymeHPEFsiPc48mknv5dT4wA8HQ=
X-Google-Smtp-Source: AGHT+IGDex9cnapkFYlxgfB7v+wp3Uh2hqKdnQYEdcIySjNLP0OzgI0COE8eKkArH2GQc88fS8wJyA==
X-Received: by 2002:a05:600c:5487:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-441d3a56bc7mr274155e9.9.1746542539779; 
 Tue, 06 May 2025 07:42:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/32] hvf: only update sysreg from owning thread
Date: Tue,  6 May 2025 15:41:45 +0100
Message-ID: <20250506144214.1221450-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Mads Ynddal <m.ynddal@samsung.com>

hv_vcpu_set_sys_reg should only be called from the owning thread of the
vCPU, so to avoid crashes, the call to hvf_update_guest_debug is
dispatched to the individual threads.

Tested-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250402135229.28143-3-mads@ynddal.dk
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/hvf/hvf-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index d404e01adef..3fc65d6b231 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -58,8 +58,13 @@ int hvf_sw_breakpoints_active(CPUState *cpu)
     return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
 }
 
-int hvf_update_guest_debug(CPUState *cpu)
+static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
 {
     hvf_arch_update_guest_debug(cpu);
+}
+
+int hvf_update_guest_debug(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
     return 0;
 }
-- 
2.43.0


