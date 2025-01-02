Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E7DE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPtt-0008OJ-7R; Thu, 02 Jan 2025 13:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTPtC-0008It-EZ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:25:57 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTPtA-0007uf-Kh
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:25:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso122670965e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735842341; x=1736447141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5MZZuqxD622nryIdDAIydJBHEZPb4zzJ2vYHU+DCJU=;
 b=bMnCqYdYWqB2o7ydaitSVSzD4oJ0StbMctbwe0+M7ZXEO17SKuClaS1VV6M3nBRz9w
 S8PIcBAA0qmHvU2r3F3A3HwybTDXKyDJNDSZGF6CxbyK3ALkiAbszHiVst9MK9k/zExC
 ONPlPp8kjUdlwBFdcuTsKY1A+lhq/rU4ugHnymmRwnXl+r1AkX21+J2E91h5ZFREE4KF
 gcvqAYUwYW4aMJ1iH72+k76oVZaqzAvCeSSi1NqLsUHXYqPjw3C9RCQB/yih/bH0bP8h
 otwh6ZWav0uGo2w1FutrqfjBlcsN7Uv2yWEZRJgM7SiK6HlL32IUR7FJf7NyTQhjRVh9
 TsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735842341; x=1736447141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5MZZuqxD622nryIdDAIydJBHEZPb4zzJ2vYHU+DCJU=;
 b=q3L9Ynt87Y55bg3rB2shYZ9g9PAo97YPt2ZCjtcCr4iA/9EKRDlzbXpNo3bGEKSO0D
 AKGvzoE7MV7Q3doNWoDW89HTdCpfwKK71AJUaRs35tSQZDzM5jkT4pc+MJv9K7VMmzF/
 D3RmjYpXXWSFm4K5VJ5NYdcXIVZQxg6Wn7CDUtqj04uh7d0UGt+D4L+AfEhZ3zjvCHfR
 PnffqpElJEYu+F4M7Ci4s0gfA0bbl4jwKTxVWmgOTqaKhGRxIZ+wUR9HLe6dWOMoKNkk
 wLpHlpAJ4oz2y7c89vEBC55KohJ2T5Vi8wHaA19qxRl4zCzXTmTihufNqQWou+TmSGBu
 Vn4A==
X-Gm-Message-State: AOJu0YwKawbzFopRFVsGlua2O88fOVBhqGTdieSO0rKL300o3rd77cie
 xiFSZKv8ddkDwM63JOsvJkH062OvFJlW1ju55j3PAu3KC7n9cXh2tVQt9vx6F3iv+XlobYPdRPN
 IzPV1Ug==
X-Gm-Gg: ASbGncvSZbgkWKR/zqvp6gcPqde3NGcMD3JCdy/pDzlkUvomfXiYakdzn3YCdu4z9Dm
 0KVD2yMd8WMckUKTLLqST1biUrsZ81Kq9OwQY+Iw8LD0MWrVA3fgh919UbPDuZdSpFClfFWfkWo
 MGrGUXbk8++pkHtnlpr6+enkRoZOZRwxdkYwtus7ej94HQ8929xPrvoKBNbgGFYIFfXJmxp3eAT
 AiHTP0ZAPR9M3PmWPKn5IaG4dEyTNPN/iV3x83VATfoGNwC0CGnAi6miR4IOh/bYw6QCZw09SbY
 jtcwM183eBCyoi2OzG0ZrVLg/AQ29ZI=
X-Google-Smtp-Source: AGHT+IEid+qm5vVH4qUyy9pqL4bxIijQTa/68t6jVfi6GChVFRq2uySRM+CVnJyIev3pDH7z3GTo0g==
X-Received: by 2002:a05:600c:468f:b0:434:a30b:5455 with SMTP id
 5b1f17b1804b1-43668b78728mr375470475e9.27.1735842340670; 
 Thu, 02 Jan 2025 10:25:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c488sm459203545e9.27.2025.01.02.10.25.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 10:25:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] accel/tcg: Implement cpu_exec_reset_hold() on user
 emulation
Date: Thu,  2 Jan 2025 19:25:21 +0100
Message-ID: <20250102182521.65428-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102182521.65428-1-philmd@linaro.org>
References: <20250102182521.65428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Commit bb6cf6f0168 ("accel/tcg: Factor tcg_cpu_reset_hold()
out") wanted to restrict tlb_flush() to system emulation,
but inadvertently also restricted tcg_flush_jmp_cache(),
which was before called on user emulation via:

  Realize -> Reset -> cpu_common_reset_hold()

Since threads (vCPUs) use a common CPUJumpCache, when many
threads are created / joined, they eventually end re-using
a CPUJumpCache entry, which was cleared when the first vCPU
was allocated (via Realize) but then stayed dirty, leading to:

  Thread 1 "qemu-s390x" received signal SIGABRT, Aborted.
  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
  44      ./nptl/pthread_kill.c: No such file or directory.
  (gdb) bt
  #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
  #1  0x00007ffff7c41e8f in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
  #2  0x00007ffff7bf2fb2 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
  #3  0x00007ffff7bdd472 in __GI_abort () at ./stdlib/abort.c:79
  #4  0x00007ffff7bdd395 in __assert_fail_base (fmt=0x7ffff7d51a90 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x5555556d71b8 "cpu->accel",
      file=file@entry=0x5555556d70e0 "cpu-target.c", line=line@entry=158, function=function@entry=0x5555556d7260 <__PRETTY_FUNCTION__.3> "cpu_exec_realizefn") at ./assert/assert.c:92
  #5  0x00007ffff7bebeb2 in __GI___assert_fail (assertion=assertion@entry=0x5555556d71b8 "cpu->accel", file=file@entry=0x5555556d70e0 "cpu-target.c", line=line@entry=158,
      function=function@entry=0x5555556d7260 <__PRETTY_FUNCTION__.3> "cpu_exec_realizefn") at ./assert/assert.c:101
  #6  0x00005555555d44ca in cpu_exec_realizefn (cpu=cpu@entry=0x5555557c28c0, errp=errp@entry=0x7fffffffe140) at cpu-target.c:158
  #7  0x000055555559f50b in s390_cpu_realizefn (dev=0x5555557c28c0, errp=0x7fffffffe1a0) at target/s390x/cpu.c:261
  #8  0x000055555563f78b in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffe2e0) at hw/core/qdev.c:510
  #9  0x000055555564365d in property_set_bool (obj=0x5555557c28c0, v=<optimized out>, name=<optimized out>, opaque=0x5555557a9140, errp=0x7fffffffe2e0) at qom/object.c:2362
  #10 0x0000555555646bbb in object_property_set (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", v=v@entry=0x5555557c6650, errp=errp@entry=0x7fffffffe2e0)
      at qom/object.c:1471
  #11 0x000055555564a45f in object_property_set_qobject (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", value=value@entry=0x5555557a7a90, errp=errp@entry=0x7fffffffe2e0)
      at qom/qom-qobject.c:28
  #12 0x0000555555647224 in object_property_set_bool (obj=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", value=value@entry=true, errp=errp@entry=0x7fffffffe2e0)
      at qom/object.c:1541
  #13 0x000055555564027c in qdev_realize (dev=<optimized out>, bus=bus@entry=0x0, errp=errp@entry=0x7fffffffe2e0) at hw/core/qdev.c:291
  #14 0x000055555559bb54 in cpu_create (typename=<optimized out>) at hw/core/cpu-common.c:57
  #15 0x000055555559a467 in main (argc=4, argv=0x7fffffffeaa8, envp=<optimized out>) at linux-user/main.c:811

Have cpu_exec_reset_hold() call the common tcg_exec_reset()
helper on user emulation, eventually calling tcg_flush_jmp_cache().

Fixes: bb6cf6f0168 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/user-exec-stub.c | 4 ----
 accel/tcg/user-exec.c      | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4fbe2dbdc88..2dc6fd9c4e8 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -14,10 +14,6 @@ void qemu_init_vcpu(CPUState *cpu)
 {
 }
 
-void cpu_exec_reset_hold(CPUState *cpu)
-{
-}
-
 /* User mode emulation does not support record/replay yet.  */
 
 bool replay_exception(void)
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 0561c4f6dc7..92640f07ed7 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -40,6 +40,11 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
+void cpu_exec_reset_hold(CPUState *cpu)
+{
+    tcg_exec_reset(cpu);
+}
+
 void cpu_interrupt(CPUState *cpu, int mask)
 {
     g_assert(bql_locked());
-- 
2.47.1


