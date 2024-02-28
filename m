Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956EBC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQUh-00080q-CN; Wed, 28 Feb 2024 15:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQUe-000806-Sm
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:25:32 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQUa-0007MR-0L
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:25:32 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5d8b276979aso96657a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709151926; x=1709756726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0U9PMwHiZszNU3T0CkEUezw6dw3Df8531lwjpQDns4A=;
 b=PbS9FMiRrGu4V+2whtbxugrsiDpcpFs0Y4PA7EVVH7mBeMGg3saF6BFjgYf3M48RLE
 2Tjr0DM2vh6iwvvYm7dk+J7IjfOnuNPMZrsBrLzgQMWDtmzdu99kqPoul5bS12TXG9ER
 7TmyifQDHt3JOsPN4h4vTRc5LT5C5unUhXlN7J+NXbhrio+Qr1y54KVfPjQzy9bPeQgK
 x9aWpWuUj72IWjMLb0XRIwX8i5D9U31HGQo9JQ0Tbapj5eKXbQ+o6B6JphGsWhGOjnP4
 /wBTvz+wfwpYkyFfJ3brcyaTBRCXCephq7d5Ps8hkc45fxVfsObugibGAQ0SbOgWrmUR
 bOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709151926; x=1709756726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0U9PMwHiZszNU3T0CkEUezw6dw3Df8531lwjpQDns4A=;
 b=hEWk/D4PZ6RatyB3njt/4K+buA78YLCZ8s6YD20WhMCN82Fry51hsSuTAkfFdI4w1U
 ImqLjMA6xbHETlSGf1ZQBuhslX6xOJ9GIWhxm2SCfYc+lUNmOsU6KPs86XRS4xWRlJ0v
 GovoQtrkNqibiSbSUDmg4PsURHwuj0BkzF3OevxpvbdvYPNtdMSTtTgZzrhY9nUzWdP2
 P60iIu1yfJg4Kx9FCSw2I5HZmVEj7WligsjeSZygs+ndWHhBZgY5GPiZML8DP0d4ZX3k
 8r3/kpBI98vB+6gmaxS2DK+in9TQB2Gx4t0ASierpUyolD1aKpWsNeCyZ34Iby7rRu7l
 R7qg==
X-Gm-Message-State: AOJu0YwCzyFcdxmx9if5ViPmwdFXCqYA5f2UO6RjizCEBlY1kLaOnUwL
 kQ7l7hOkiIpvu5buOjPwDwiMlmje2n6li4uOVK5CiUxIi6eSBOh382OgVyqqbA1QhiVOBhyf35y
 i
X-Google-Smtp-Source: AGHT+IGrFJIJTQgrMZlXVgIQeNd1TLRU+Oed90gJbzNNR97eRW8DTu3VIIaMmArgH+gnle4paNkhTQ==
X-Received: by 2002:a17:90b:3753:b0:299:a5a1:46e2 with SMTP id
 ne19-20020a17090b375300b00299a5a146e2mr244104pjb.25.1709151926253; 
 Wed, 28 Feb 2024 12:25:26 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 oh5-20020a17090b3a4500b0029ab712f648sm2118499pjb.38.2024.02.28.12.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 12:25:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.purdie@linuxfoundation.org, mjt@tls.msk.ru,
 iii@linux.ibm.com
Subject: [PATCH v2 3/5] linux-user: Add strace for shmat
Date: Wed, 28 Feb 2024 10:25:16 -1000
Message-Id: <20240228202518.33180-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228202518.33180-1-richard.henderson@linaro.org>
References: <20240228202518.33180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c    | 23 +++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index cf26e55264..47d6ec3263 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -670,6 +670,25 @@ print_semctl(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+static void
+print_shmat(CPUArchState *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    static const struct flags shmat_flags[] = {
+        FLAG_GENERIC(SHM_RND),
+        FLAG_GENERIC(SHM_REMAP),
+        FLAG_GENERIC(SHM_RDONLY),
+        FLAG_GENERIC(SHM_EXEC),
+    };
+
+    print_syscall_prologue(name);
+    print_raw_param(TARGET_ABI_FMT_ld, arg0, 0);
+    print_pointer(arg1, 0);
+    print_flags(shmat_flags, arg2, 1);
+    print_syscall_epilogue(name);
+}
+
 #ifdef TARGET_NR_ipc
 static void
 print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
@@ -683,6 +702,10 @@ print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
         print_ipc_cmd(arg3);
         qemu_log(",0x" TARGET_ABI_FMT_lx ")", arg4);
         break;
+    case IPCOP_shmat:
+        print_shmat(cpu_env, &(const struct syscallname){ .name = "shmat" },
+                    arg1, arg4, arg2, 0, 0, 0);
+        break;
     default:
         qemu_log(("%s("
                   TARGET_ABI_FMT_ld ","
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 6655d4f26d..dfd4237d14 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1398,7 +1398,7 @@
 { TARGET_NR_sgetmask, "sgetmask" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_shmat
-{ TARGET_NR_shmat, "shmat" , NULL, NULL, print_syscall_ret_addr },
+{ TARGET_NR_shmat, "shmat" , NULL, print_shmat, print_syscall_ret_addr },
 #endif
 #ifdef TARGET_NR_shmctl
 { TARGET_NR_shmctl, "shmctl" , NULL, NULL, NULL },
-- 
2.34.1


