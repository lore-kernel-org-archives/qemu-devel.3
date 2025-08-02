Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E2DC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLTz-0005y7-HN; Sat, 02 Aug 2025 19:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLTG-0004gk-UZ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:17:02 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLTF-0002h2-8g
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:58 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-61585dfc8f8so1028642eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176616; x=1754781416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTo58dUSNI3YDcTPhtLgzai3OOd/DYUGwbtHV5KS80Q=;
 b=xWyYa8giqh+xrl7MrrpsNuHiwVlKSf4QkZJfOd+BmvT++YYVqRVn9KMyHZ9q5uxcmw
 +qHwh9o7sH+xb0pfZ2WcyBS5QFwnWGVKY5Q/CpMtcwJw804hPfS1syB8x/ptn5QvTqhq
 VMm7iNZbp+RSFL77fYt4qqa/4gGH+REuK3E3rbNNI3gwXC/AhJQGriT9jLSEM4md+VUV
 7do5Kh/RjkfVCxHMcE6C44/YRyJ30DZxJinMqHeZyAqQ8CpjvKL3ROpUdScuq7DgYw/J
 U7dkQufYQrhNgvPH7GTBesEUsSQmDyLtaa1+tc93mLyY/JZS2plJcvKhIOeoZTELQOHD
 TDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176616; x=1754781416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YTo58dUSNI3YDcTPhtLgzai3OOd/DYUGwbtHV5KS80Q=;
 b=k+0MmVreXLL8W3uJcbTCYzZROMB5/36dxJsAuIU4DKjjT0U52wOF9e2ryZZhsYZ0wK
 zGuBDqldQoYFQMYStkwG2+ewNX00fvW/v4p9u2MMNa2ZSdMGX+td18BYVnr++usPxuTT
 /Ubr4XjTIr+1wP1bXxXOh7Pgd1ZmjeBZExKooE3OQXefTNS7C1EDApzuo1tbXypfa++x
 1kibYL2x01EiBniCoMIALWApTpt83pC6VUH/0wUZXPBZ1Dm5Jp6mcnPHuSDnpRyEf+rh
 feck5yrwwumYX5rzq6FmDpgJlq+s8nApqe02EJl2niSOop4Rnj+W5WcBJB3ehu2C2xEP
 WADA==
X-Gm-Message-State: AOJu0YyL3I2vbjhicFR9gWxbpSVi2lhNrr0TdwjCh2dokYGIaVwY5JAD
 fIPxx+ai0ItsDPbZzIXWANfxGqkn0/9ToX2HHi6jLEI51fPu3K1G+0s62SeiMqq8jOfIRiMvvoz
 1hPedkwQ=
X-Gm-Gg: ASbGncs9wvOU+01qvCdXquJj/ZYPe2Oo6b4avKKAGiYw8rWWoQvaKgvwIAMCqarWCDl
 WyNbWVhDGvGNjL7t7ugMBMbbBtfQuSMEoqv3LSHMAIQNFN32AqBzSJoVHApe8Lk01tiJVUIlImx
 51qHtTZ44qk0t9nhgpsCeUHsM1+FFlGk1gH5nEQoInHtBzk+h8IGEQXWZtuvticra4yVMjfKTOv
 Xp7+S3fbOpyXQAKZbBYC3aMgISWtJPD6NrnRAliM0+6LGKpuVg6GzvKPhg68EkKa8Mi15k5TBU4
 EcE8X95PmU+8o07Ux8cadXcx6RDKDtTcdH5xBYtEClQ1CDUCHCAwW/fl4ToU6CRrzSZKnm/jxaF
 cl//C7QjTZtYQneBCNTpMN0dCKVmWzSiXPtuXyfQa7LP3ykqx8upjAQLrws9lH70=
X-Google-Smtp-Source: AGHT+IELdCeNodyZ1q1Px1sxwPmB1QvMcmzxYYmjR6uhDOulWe9SGLbj42q0fGA2Ib64pgMztccEMg==
X-Received: by 2002:a05:6870:79e:b0:2ea:7963:534e with SMTP id
 586e51a60fabf-30b67607c9emr2697407fac.14.1754176616142; 
 Sat, 02 Aug 2025 16:16:56 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 94/95] linux-user/s390x: Move target_psw_t to signal.c
Date: Sun,  3 Aug 2025 09:04:58 +1000
Message-ID: <20250802230459.412251-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

Remove struct target_pt_regs as unused.
Move target_psw_t to signal.c, as it is used there.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/s390x/target_syscall.h | 22 ----------------------
 linux-user/s390x/signal.c         |  5 +++++
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/linux-user/s390x/target_syscall.h b/linux-user/s390x/target_syscall.h
index 4018988a25..f01f9a0baa 100644
--- a/linux-user/s390x/target_syscall.h
+++ b/linux-user/s390x/target_syscall.h
@@ -1,28 +1,6 @@
 #ifndef S390X_TARGET_SYSCALL_H
 #define S390X_TARGET_SYSCALL_H
 
-/* this typedef defines how a Program Status Word looks like */
-typedef struct {
-    abi_ulong mask;
-    abi_ulong addr;
-} __attribute__ ((aligned(8))) target_psw_t;
-
-/*
- * The pt_regs struct defines the way the registers are stored on
- * the stack during a system call.
- */
-
-#define TARGET_NUM_GPRS        16
-
-struct target_pt_regs {
-    abi_ulong args[1];
-    target_psw_t psw;
-    abi_ulong gprs[TARGET_NUM_GPRS];
-    abi_ulong orig_gpr2;
-    unsigned short ilen;
-    unsigned short trap;
-};
-
 #define UNAME_MACHINE "s390x"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index df49c24708..e964876123 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -33,6 +33,11 @@
 #define _SIGMASK_COPY_SIZE    (sizeof(unsigned long)*_SIGCONTEXT_NSIG_WORDS)
 #define S390_SYSCALL_OPCODE ((uint16_t)0x0a00)
 
+typedef struct {
+    abi_ulong mask;
+    abi_ulong addr;
+} __attribute__ ((aligned(8))) target_psw_t;
+
 typedef struct {
     target_psw_t psw;
     abi_ulong gprs[__NUM_GPRS];
-- 
2.43.0


