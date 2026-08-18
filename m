Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09501C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCj-0007Uq-RP; Tue, 18 Aug 2026 13:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCh-0007UF-VT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:24 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCg-0004nN-FY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:23 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8518b3ff3e9so138641b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072541; x=1787677341; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=slNkRqDBUzZYQOIVRMUpEwh3vDfThqwAyUd8JEWbOVA=;
 b=GELN8Hp9jmLMX27tvoczxyUPdNL1roHHD5JEi4zoPHs4eBbzMvM5qAAjtobEzc2n4I
 WZptP7G9YFcD+drFnsUzTsFTEcpN5zRjf/igupQ84hO5oW+oH5oapJBrIVOGOFiBfTBQ
 xWCSHOEvKN+4RMXPHTwB1mSJtCZxLaZ37tF6Rczh6rJSB4mE97YJV6rZAjXmqoSG62yG
 iSRGSZmXY18Abel11UxAxms4YDIixFyGB7RbuBeGewEpbNohY442AxtCBGIBG4OEf8KV
 BwqJVsWau5dCo7fdVypRJOLix0sjqCiUnIxLWdkue3fz7vG9ho6w8gICguFKlnIk6V8C
 +RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072541; x=1787677341;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=slNkRqDBUzZYQOIVRMUpEwh3vDfThqwAyUd8JEWbOVA=;
 b=P+JQ9Ro4inYhLz57ICcfUc8mTlUKE/Q/TPjeFQ/q9usjLIWqopcWiYAsBpcSJdPxvA
 GBEGRAV3qWzdKmVjfZlJtNufSfvrUd94or+vf3+7yTin8Q0x+YJNLMQWaRbUVXGcDgtT
 6aJ4ApLHiyJ2HeTh4ocdjKKA8UMxjgxYZ9NeBZ2jFzXkYeSNkSNQkncxoBHeKY1lLDf9
 eHhFcxjNd99FXJS2u7HRsPaHzARhwM1R78Bkqv/rdp8dpJ6JgQhajY2BUzm4z2xl5/k4
 BcX439sghYnvqHzV/hUnO/nMomNvbethlZjuKydlcBd3KVxi4Q9YiF/GDJ8ssQl3t3K3
 jpkA==
X-Gm-Message-State: AOJu0YwIetkKNKCEljJA1bwQUeZbVYVZZTsfDFBHrvQK7KjPsFtXwvOg
 KR73ZDAsEIAjlvoOT07YFCcGzMapqDnqnZf2A2edp0O4tUqWceofz2zIeKXwmtPbIazlUmdpynf
 wfso5zoI=
X-Gm-Gg: AR+sD13mKziFkPBphEJQN6GGHIteR01d0FpRhu5wcPYExHpNkukvjzjIGQNnKi5moOc
 fH7cXl+B9w17Qn9ham2M/EUCcKkrT4ovtm2N7xvaMqKkSVSOUIHmRSORUbIrjXWa5k1JoGTQpXE
 GchhIvGQ502Fh/n6AdiSCY8NLH224KAW8fKZo1Ob8rlL6pxSP4oSddYUsBh7mX/qxpSPiYt5RUB
 GtiKacMxM12Vattoy9DIBMPnlbNtymRonu0EyROgNuky4UmSQvqHfcMMMO26TAY9NHFL9OuvXF5
 h13Oc3LGttceLfawu7PKMaKWwxwib6w13egSukd49y4RnaZUm5qpg+hqerpe6xzXR+zOadyBacB
 LZfFmrooTLl96/09q3oq/EQaHP+OXVPaMjMgYLIIr9hhBNyozHm21GzSIbSFaFj/5g6px7b/k5T
 9h35MYoUqGpZFDMBGCieHT4UikyidIv8wsI29yy4SavaNJvkzQId3mbtpTnYqH+9CwyCCRpXql8
 Rw/6spmM19G0TzXXuZ1iAcvMP9LmmVAI7U=
X-Received: by 2002:a05:6a00:ab8a:b0:851:804c:f4eb with SMTP id
 d2e1a72fcca58-851b87eae5dmr14551436b3a.4.1787072540662; 
 Tue, 18 Aug 2026 10:02:20 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 19/38] util/cpuinfo-riscv: Detect Zbkb
Date: Tue, 18 Aug 2026 10:01:36 -0700
Message-ID: <20260818170155.1907006-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

RISCV_HWPROBE_EXT_ZBKB was introduced in linux 6.10
with the rest of the hwprobe api.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/riscv64/host/cpuinfo.h |  1 +
 util/cpuinfo-riscv.c                | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/host/include/riscv64/host/cpuinfo.h b/host/include/riscv64/host/cpuinfo.h
index b2b53dbf62..1f047051a3 100644
--- a/host/include/riscv64/host/cpuinfo.h
+++ b/host/include/riscv64/host/cpuinfo.h
@@ -12,6 +12,7 @@
 #define CPUINFO_ZBS             (1u << 3)
 #define CPUINFO_ZICOND          (1u << 4)
 #define CPUINFO_ZVE64X          (1u << 5)
+#define CPUINFO_ZBKB            (1u << 6)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
index 0291b7218a..8c48b1ea91 100644
--- a/util/cpuinfo-riscv.c
+++ b/util/cpuinfo-riscv.c
@@ -36,7 +36,7 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
 /* Called both as constructor and (possibly) via other constructors. */
 unsigned __attribute__((constructor)) cpuinfo_init(void)
 {
-    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS
+    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS | CPUINFO_ZBKB
                   | CPUINFO_ZICOND | CPUINFO_ZVE64X;
     unsigned info = cpuinfo;
 
@@ -60,6 +60,9 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 #if defined(__riscv_arch_test) && \
     (defined(__riscv_vector) || defined(__riscv_zve64x))
     info |= CPUINFO_ZVE64X;
+#endif
+#if defined(__riscv_arch_test) && defined(__riscv_zbkb)
+    info |= CPUINFO_ZBKB;
 #endif
     left &= ~info;
 
@@ -76,7 +79,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             info |= pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA : 0;
             info |= pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB : 0;
             info |= pair.value & RISCV_HWPROBE_EXT_ZBS ? CPUINFO_ZBS : 0;
-            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS);
+            info |= pair.value & RISCV_HWPROBE_EXT_ZBKB ? CPUINFO_ZBKB : 0;
+            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS | CPUINFO_ZBKB);
 #ifdef RISCV_HWPROBE_EXT_ZICOND
             info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
             left &= ~CPUINFO_ZICOND;
@@ -131,6 +135,15 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             left &= ~CPUINFO_ZBS;
         }
 
+        if (left & CPUINFO_ZBKB) {
+            /* Probe for Zbkb: brev8 zero,zero. */
+            got_sigill = 0;
+            asm volatile(".insn i 0x13, 5, zero, zero, 0x687"
+                         : : : "memory");
+            info |= got_sigill ? 0 : CPUINFO_ZBKB;
+            left &= ~CPUINFO_ZBKB;
+        }
+
         if (left & CPUINFO_ZICOND) {
             /* Probe for Zicond: czero.eqz zero,zero,zero. */
             got_sigill = 0;
-- 
2.43.0


