Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A46C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIFB-0001jF-N3; Fri, 10 Jul 2026 16:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIF4-0001ei-AD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:40 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEn-0000kA-RW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:37 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-845c92bc464so1259627b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716860; x=1784321660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9FVe4IDYzuWlBAdVKn89Oel+X5gqBqY4ENpHT0MrX5Q=;
 b=rszTJ0XCFgp4EQ2zXVI82oN5tZNn9S4HW3Xonoqt1nMeIjecdfk2c+b7b3nvgUB7oS
 TCGeN6FBnq5tZPF3M5zVNgbifvo3hKP/ETJUvT2ih5bHYViFeBSpQqDcBuT6mCcubVQx
 igVSS9EL7R2hYw4E3vEZICD69QZfLRS4c3vUElI3JVsRtCBSLk4ASbUFbYoa53jKrQSA
 J5ToyHuv/tN07Ah8i+2MAyjhKERNFdMKHpKZmJIpjH0RtMgulS1tVGSJ0hgum3ODiM34
 BcuAjIS/gxRbc8tu6UnO8ItNFtkGB1UdetvIt+sughG3CNJUPFLrr1mfPA7c70CYJqME
 WtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716860; x=1784321660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9FVe4IDYzuWlBAdVKn89Oel+X5gqBqY4ENpHT0MrX5Q=;
 b=VPsZTihSIwGSZwpDs0CiQtuMLU682sE/RB9jekY1R/GkvwS1TyqcG6DnDxsz8PdAyN
 KwmSAb9wCn5t+j1Y4+SBaXUU+DMrVvyWb7EDOqSCK3ohfN4HaG3kLMRKCQB4wc5X5/3v
 aY0s5RIvBLrZG1kHc7m6M9Q6Np2ZC6tGFoir6Y2nqXIwPQ/jRvgc1eic84dh1LMgRqAz
 uUl/+Chmpj+j+S20l4VN1iD2LvzQ8SOklkWjo/YtobZHqtlLjlAiXPGyT1Gf9pHCBCuu
 Hsr9NLQJqtad89ct8EhhP/6/TxqmLSb38XgnfajVaPeX4hqzc0ZkZecNmtb64k9cIpP2
 QCxQ==
X-Gm-Message-State: AOJu0YyEdT71BMN0cNvCCdoSufJE2xfL96o9krja8gf1l6QzwnxUBKfr
 J7pBA9DIlSGZU/6lk6Q8Gtu4AOfNxR9iDeQZcyNNtx2p3LeyKXsVbq+psgdVlodk87ZvYCnpFO1
 lishs
X-Gm-Gg: AfdE7cnMdqZqfqzJo/TdotMxLoneJnTduvHFJJTImblOkZWWlA+AkOntMl97HgTY/Vj
 zCmV02V677flkI+csuxd7Dqj8j0OPJy8xuNFJWqph3z5HXyilM45/uDy/8/hhlO9zMsQUFAPDnA
 2apgAeYNmsoHjkSofCmFpMIp9cr9VQFq2cOlOW4rlERnAooLfhUxqhMl0xaFSv3m4RZAT8EfExX
 xyak3qc17Tljx20fXbdkiltDckHkO/6lL4jvG0tsr5iwUEidaQhyVobfaXqy6WlKl3osnHNb3iy
 WxQi8OTtg02O1qwzP6fDEQNeIk3Wzzf4AJFqCtzeo7U9mGfZCaxGVc4DvwwxLObxqoC+qxUVko6
 o6jUbmLu5nKPH/vkLgcWcu2Zqq/BLb7lMFlGBa6VMR+PwEaYZ/FBWc+xDCP8Yfhy6lm1a9IEPZu
 QXD+vKvPRRIRiNYj3SUwaYhgKR9yXi
X-Received: by 2002:a05:6a00:3388:b0:845:d274:c021 with SMTP id
 d2e1a72fcca58-8488970be58mr554168b3a.58.1783716860358; 
 Fri, 10 Jul 2026 13:54:20 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 16/51] target/arm: Make check_watchpoint_in_range static
Date: Fri, 10 Jul 2026 13:53:26 -0700
Message-ID: <20260710205401.836304-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

This function is not used outside hyp_gdbstub.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h   | 1 -
 target/arm/hyp_gdbstub.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 49ec97bd1c..95f32ad308 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1975,7 +1975,6 @@ bool find_hw_breakpoint(CPUState *cpu, vaddr pc);
 int insert_hw_breakpoint(vaddr pc);
 int delete_hw_breakpoint(vaddr pc);
 
-bool check_watchpoint_in_range(int i, vaddr addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
 int insert_gdbstub_hw_watchpoint(vaddr addr, vaddr len, GdbBreakpointType type);
 int delete_gdbstub_hw_watchpoint(vaddr addr, vaddr len, GdbBreakpointType type);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index dda6946dda..c91efa7495 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -182,7 +182,7 @@ int insert_gdbstub_hw_watchpoint(vaddr addr, vaddr len, GdbBreakpointType type)
     return 0;
 }
 
-bool check_watchpoint_in_range(int i, vaddr addr)
+static bool check_watchpoint_in_range(int i, vaddr addr)
 {
     HWWatchpoint *wp = get_hw_wp(i);
     uint64_t addr_top, addr_bottom = wp->wvr;
-- 
2.43.0


