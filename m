Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA66ACFB421
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 23:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxEHa-0006BY-IW; Sat, 05 Oct 2024 19:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHY-0006AT-3b
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:52 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHW-0004DL-Av
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:51 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e082bf1c7fso2329947a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728171229; x=1728776029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3MlKySkLCqcubwj2AlCHtEZtre6EurFM45v8Ib7p+Y=;
 b=EcBr3RROnng+Kwd7MidtFRmZhKsqTueJzo3ri8MjfFdWzInTss+j+LgDjdM2yzcDbw
 EUWs8WCI6A+zN6eApZYTel26gk0+/ljcwywAiIjGMgZKtHR9yMMUojX+swUmXGnJZ2ge
 Ob5+Xiw6BS94Eb9HtlidcHVITF3ceU0AmajrGowx/laz6jFkWKkroNUd1ugP8nFFkPb1
 XGhwE9RNvvNnKFbukjCQ+4JCbEZnWrDnjtktN9sAztfulnJmYEDy1iRfdOGA99Fcm742
 T5XlRZJAzMSMCPWe6Kz9/zo3IeXYu1KMqUTTZMlpHbPQORaM0fuXmpwwvuGzau7qMaNp
 yEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728171229; x=1728776029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3MlKySkLCqcubwj2AlCHtEZtre6EurFM45v8Ib7p+Y=;
 b=iKrHh/4CGFytxbNo+sVwAUtPqSiB/OyUfBNNmdx+4TMeanbkdf0Rw54OOxTgYWSgYV
 T6DPyxCr+S0iS3+UFN4DDqKh7WZLgJm4zqM3nw140U/7oGD/R6zECaU6uqd/CYiNppcS
 4s/cfOghsf1CFG2Eyeg3aiuvxhlePeLMNghe+kMR5qzsKqKKibJDoDIWlMVu6Sy2HaMS
 1g9EAdDPKbJE0h1OQYZrzjQKmLeKD2ocOQqf8hzt+lC+s+ANZhupogGB9tmL5OhRNltB
 s1nThVgpBfUEpAXxy+ululWdbF07Y59F2GaPYHV/11nPZX2kFC2Q+kyu235rxBFyqYXl
 0xxg==
X-Gm-Message-State: AOJu0Yyu1J5XRwV9dt741uoxW/akjTjgYs0WCngvBbAS/ZrTRNHeEFgl
 Nk1qwsSM2y/IYVRUDf3kFMA14uXLaPFEY98iHOF0r5I5mgFIoxf3D/Fp0dr/MU6080Q0mprPtDV
 W
X-Google-Smtp-Source: AGHT+IGq3p9VqELP9PXjvI3r57OJOmk0cuVTkV7kNU/+hzbRvy2+yy7SLLjWJpVurDnbDVgzag14mA==
X-Received: by 2002:a17:90a:c82:b0:2e0:80e8:a312 with SMTP id
 98e67ed59e1d1-2e1e63bb8a8mr8356508a91.34.1728171229044; 
 Sat, 05 Oct 2024 16:33:49 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b129cc2sm2394600a91.51.2024.10.05.16.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 16:33:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 05/10] linux-user: Trace wait4()'s and waitpid()'s wstatus
Date: Sat,  5 Oct 2024 16:33:38 -0700
Message-ID: <20241005233343.503426-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005233343.503426-1-richard.henderson@linaro.org>
References: <20241005233343.503426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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


