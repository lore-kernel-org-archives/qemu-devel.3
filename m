Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D708CEFC41
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJU-0007TW-Uv; Tue, 08 Oct 2024 14:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJP-0007Qo-Q5
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJK-0002SQ-B1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b1335e4e4so59268885ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413508; x=1729018308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3MlKySkLCqcubwj2AlCHtEZtre6EurFM45v8Ib7p+Y=;
 b=ckAE1xcHhhyryqfgq6V8xT8/ESnVNIJOmcbSF05SvmOZaMq9YBMvqMNr8BsrjE/n1h
 FyjiLbRL8xhm64z6paSkVJFLR+qihdh7hWV6hMVbhfpvcLURLZvIQKZFatyNSUn2+l4H
 F015CgmNetOteGcZEckNBl81+5HSTrLThOWsvkHZ5d7yd4UBQYxX1wiPlpP4up9HIxMB
 Pi8qbEIb0fcoa7EeNXc9TfcmwV3xzpeETHOSaZ9uoBeLsEJuCXRguadE/QwP/cNjqp2N
 5fj93gKamV0TDpqtv8fseJ3Dd8GFVDz3ccj69EKxJf+BAMXdddp5uDODbz0MdigmuOqq
 eDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413508; x=1729018308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3MlKySkLCqcubwj2AlCHtEZtre6EurFM45v8Ib7p+Y=;
 b=MYKl+jAU10dVF1M6z1P/Bc6E7Ebj3tiHzn3vI8OKd4hJxJD9DX1SrmOo9u8wJpKTaI
 o4qihh4FJPT2+BeDUMtF4KAtcz69kJ7bw8d0Nw7jZLCcZ4jl9I5x1/oS5Qdfpfoxvujh
 NseHrE1eRl9IFdGAV1UPQUsUhE3n1kQ+59y4s0nVM+lwrI3f19i9TDDFk5Zr6KHYpSmS
 73rjzrXbQCF4x5bVmXQffpeyATVlrgBWSz0Q7OyYuaSJwuCici/N4JJyVQOA69Y5wszT
 g7g609yHl1je2WHzfNiMVV4+XroSXjB0wXln5P6dpjmrTqYIB0MKoLw87eUCDkfhAo2f
 vObw==
X-Gm-Message-State: AOJu0YxBEslOme7sjhVdIoNuuoo8tibHx2VoTx2Oy4cKbiXgLqgGESvC
 QgDBWnwgBYdmI7prVzSSfmiZvJkyAqm6vJWS/otoKe3iibsMM5yEpJDYfM+QS/k+CmKS/xrW7t0
 I
X-Google-Smtp-Source: AGHT+IEa+7ueo9qRjODzmJ3PWrseph8EsiTnAGeBakZxvc9x/8glG9Tcl6JScM5XspT42+CN/kfTHw==
X-Received: by 2002:a17:902:fc4e:b0:202:4666:f018 with SMTP id
 d9443c01a7336-20bfdfd2693mr274481165ad.15.1728413508303; 
 Tue, 08 Oct 2024 11:51:48 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 05/14] linux-user: Trace wait4()'s and waitpid()'s wstatus
Date: Tue,  8 Oct 2024 11:51:32 -0700
Message-ID: <20241008185141.20057-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Borrow the code for formatting the most frequent WIFEXITED() and
WIFSIGNALED() special cases from from the strace's printstatus().

Output examples:

    474729 wait4(-1,0x7f00767ff0a0,0,(nil)) = 474733 (wstatus={WIFEXITED(s) && WEXITSTATUS(s) == 1})
    475833 wait4(-1,0x7f7de61ff0a0,0,(nil)) = 475837 (wstatus={WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL})
    1168 waitpid(1171,0x7f44eea00340,0) = 1171 (wstatus={WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL})

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20241001193244.14939-1-iii@linux.ibm.com>
[rth: Drop extra output for NULL wstatus or error reading.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c    | 57 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  6 +++--
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index d3cdd09dc1..cf9eaf71c9 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4215,6 +4215,63 @@ print_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
+static void print_wstatus(int wstatus)
+{
+    if (WIFSIGNALED(wstatus)) {
+        qemu_log("{WIFSIGNALED(s) && WTERMSIG(s) == ");
+        print_signal(WTERMSIG(wstatus), 1);
+        if (WCOREDUMP(wstatus)) {
+            qemu_log(" && WCOREDUMP(s)");
+        }
+        qemu_log("}");
+    } else if (WIFEXITED(wstatus)) {
+        qemu_log("{WIFEXITED(s) && WEXITSTATUS(s) == %d}",
+                 WEXITSTATUS(wstatus));
+    } else {
+        print_number(wstatus, 1);
+    }
+}
+
+static void print_ret_wstatus(abi_long ret, abi_long wstatus_addr)
+{
+    int wstatus;
+
+    if (!print_syscall_err(ret)
+        && wstatus_addr
+        && get_user_s32(wstatus, wstatus_addr)) {
+        qemu_log(TARGET_ABI_FMT_ld " (wstatus=", ret);
+        print_wstatus(wstatus);
+        qemu_log(")");
+    }
+    qemu_log("\n");
+}
+#endif
+
+#ifdef TARGET_NR_wait4
+static void
+print_syscall_ret_wait4(CPUArchState *cpu_env,
+                        const struct syscallname *name,
+                        abi_long ret, abi_long arg0, abi_long arg1,
+                        abi_long arg2, abi_long arg3, abi_long arg4,
+                        abi_long arg5)
+{
+    print_ret_wstatus(ret, arg1);
+}
+#endif
+
+#ifdef TARGET_NR_waitpid
+static void
+print_syscall_ret_waitpid(CPUArchState *cpu_env,
+                          const struct syscallname *name,
+                          abi_long ret, abi_long arg0, abi_long arg1,
+                          abi_long arg2, abi_long arg3, abi_long arg4,
+                          abi_long arg5)
+{
+    print_ret_wstatus(ret, arg1);
+}
+#endif
+
 /*
  * An array of all of the syscalls we know about
  */
diff --git a/linux-user/strace.list b/linux-user/strace.list
index ef658224fc..f8899710b5 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1662,13 +1662,15 @@
 { TARGET_NR_vserver, "vserver" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_wait4
-{ TARGET_NR_wait4, "wait4" , "%s(%d,%p,%d,%p)", NULL, NULL },
+{ TARGET_NR_wait4, "wait4" , "%s(%d,%p,%d,%p)", NULL,
+                   print_syscall_ret_wait4 },
 #endif
 #ifdef TARGET_NR_waitid
 { TARGET_NR_waitid, "waitid" , "%s(%#x,%d,%p,%#x)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_waitpid
-{ TARGET_NR_waitpid, "waitpid" , "%s(%d,%p,%#x)", NULL, NULL },
+{ TARGET_NR_waitpid, "waitpid", "%s(%d,%p,%#x)", NULL,
+                     print_syscall_ret_waitpid },
 #endif
 #ifdef TARGET_NR_write
 { TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
-- 
2.43.0


