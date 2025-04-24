Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E06DC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7knv-0006TV-72; Wed, 23 Apr 2025 20:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kn0-0005ac-BC
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmy-0004NU-AP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:05 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so306233b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455799; x=1746060599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXxySmM5H2uZxfcMpHXVVabc3DpRRBx3hmcc7DOhhC4=;
 b=Xy//jRBkDyFm+9cHsrYExfELxIjFDqJ6ljkXrA930Jy1EwQ0XK2BJPk7Y6AAayC97/
 5vd4BHHI82h0HaEM2QONZmkVPRIOIn0fuXXvUZxgiYS5C2rNF3b41xhkgwRGzLBqeG+2
 uy4WF2vx1v/UBhaPVmxmN95mMFD6UFr43kZ4TzMGvgwcXw6s6R4EfJXhiZoAz4SGkenB
 eOHlCXudPCt7MlEq3F9aUDHuCJi7xiujSzXCdaNeK7gcT+DAqEaW+LU830O183uhy/7s
 NbB3oZmHqO9/bv62YZcbW9goc2Ylq9c3osPdjnTzac7kykYBmsomkAjoNtp80mpMkdoa
 m2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455799; x=1746060599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXxySmM5H2uZxfcMpHXVVabc3DpRRBx3hmcc7DOhhC4=;
 b=Le6EmpZGGtjoENBJUpuGySbxHXpLS92AZiNKLnywpjvRXa3Kd+9e9UkNmbxP7Xf/gw
 0SI7Yuh2lCPXQLVIdpMI2kt27VCQbpGdjk2rR4o+S9OQv6mxX0CuYtOUWhAId8MqUKj3
 b7EcEUeAs41oB09ZD7XVetkIKdyEEowyZ7xHRPgULQiZKWt3S2Eq2yRg+6L5pUEVQhOY
 f12Nk7oRh+oZvouW5DmOzA0vrJCWLCBI+9fIsdr/LJfYuDMc3U7dZrv2uOAreD90RWC2
 12zM4lXDIyG0UDnqi7nWLGs7hsVxuOPpe1XekVHsKK2sfe4DWdCOd1InXhE3qcZjzvPJ
 6ymg==
X-Gm-Message-State: AOJu0YwAl8S9ZLVqswIAFijzfLBokofSm4C0EmWw92xZ8tDfQx0zKjYM
 Q5Gqr4wzHdL78MNyOrsT7TM+UPKhumGGYf7Efat/fUwzSmagiIb6G9aFKmRrjSsncyAMK964Ndc
 9
X-Gm-Gg: ASbGnctCbD+5uN/Z5v5/Ahh/WJUt03vhBT5Xd6AGRpnZqsrZ0zP830xkH8nQRB+kAFI
 dILvG1qlkMwLyy2JFriYR3g45lYnLSmJCyf7rBmCeBNDOVSzel7ms3gE3qCHzTOMqOWXm219nBF
 ooVsWIS3mp47zaps5iGsXZcibY483x0a+3+kmTZqdF/yUo84gLC3bynf3rQkd2iAIm28I8ZLB/K
 SabdzrNmczJXCJynodLSbLxUBJ0/t1/Ytqho+zk2hQHZu7fOmGgbTRnVHF2TyzIQmIC6qf5emHW
 TFF9u/+rfs6ofUrJ+i5BQqd8GIT9r4Qpl6Y36nJxrlC/wtng6rI9WDBOFI5fPe4xemZUTNWNl5Q
 =
X-Google-Smtp-Source: AGHT+IHVQPDY/KeKT12ZRKLCdvmM2ljPFYBpp5en5ZMZZQDQ7tJJlH9GOncUDKvcnNVHoCVfTU36bA==
X-Received: by 2002:a05:6a21:7101:b0:1f5:8d8f:27aa with SMTP id
 adf61e73a8af0-20444e6faccmr925241637.8.1745455799269; 
 Wed, 23 Apr 2025 17:49:59 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 032/148] accel/tcg: Remove mmap_lock/unlock from watchpoint.c
Date: Wed, 23 Apr 2025 17:47:37 -0700
Message-ID: <20250424004934.598783-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

The mmap_lock is user-only, whereas watchpoint.c
is only compiled for system mode.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/watchpoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index 65b21884ce..cfb37a49e7 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -124,17 +124,14 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
             }
             cpu->watchpoint_hit = wp;
 
-            mmap_lock();
             /* This call also restores vCPU state */
             tb_check_watchpoint(cpu, ra);
             if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                 cpu->exception_index = EXCP_DEBUG;
-                mmap_unlock();
                 cpu_loop_exit(cpu);
             } else {
                 /* Force execution of one insn next time.  */
                 cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
-                mmap_unlock();
                 cpu_loop_exit_noexc(cpu);
             }
         } else {
-- 
2.43.0


