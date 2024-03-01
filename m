Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E840CC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjL-0005PU-Ut; Fri, 01 Mar 2024 23:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1k-0003ze-Ig
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:59 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1h-0005zr-T7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:52 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e5dddd3b95so361841b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334648; x=1709939448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rYYyH2nCsC3OszbxYg3gYtAKvyiLKNjInne/wklRig=;
 b=PXdVjMPZ82/pp1kdK4kP72tSGkH1KBZJb4jb2e83ZY3ltJSxAjzXfXKErrTxFGioZT
 s58ro0dOrYANbVYwXHMnASFPOPoTpsu61k/ZV9nX+GEQQ60/A+KfRG3AhDiYZdBdFXrb
 VK29ofkRdnvJPivFQ5zhAefGojZlTg6yLQFr+bEBNg5f4raUXoic8N2t1xzldjMc66RD
 EWglPsDnxiA2kvbP8GD4nIIdAjbjSgJY+VNhETVnFPZMRa5ZtQYjsKCbDvcyipxI6SOA
 S/wl3pJcwNawQMsUrLawE5ZOJ33GsK17eo3TF87R8RJhm4Pp/QCqzCZBFmcPzQ95QNpk
 mRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334648; x=1709939448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rYYyH2nCsC3OszbxYg3gYtAKvyiLKNjInne/wklRig=;
 b=NgvImdX8goKmeBJtdz553LEurVD9zXoAN7owdP4Qjj8pC14B06230r/m02IbQf5NpY
 M6hBkTvxwqPJXkx/WOGcstaiR7kXUssS7omC/FlwAidg1555VDWw6kRZKFcBhi+R1kUn
 tLksPBTWzaLRdMNKJhNmjue57MNTns8X/31l5YXaxo13MA9MMAh4yVyamKGD9c6SqUI5
 OTYyH8EVgOGT11n5XfLLkiYaxgAAq0m6u+HZ7uv9g20g3WVIg2bc59TBkF1b3ze7OBVD
 mjdYn1sTn0bZ90Q8hLtrHbxWepR4cosyoq4HmdcmElkRexPnHpIxmQdIQFojY47LkI5J
 bTvg==
X-Gm-Message-State: AOJu0YwUYobvkA9OUEHiTFXwBqFb/YPef9hCg8237FfFsVaRZOE4+YfM
 l791qIFucvw+N7rNhG0SjyARYKk0LUOaw0FFUKxK6F5k/TucWvMaShvHZo/LwVlAnejA1rVtzIX
 4
X-Google-Smtp-Source: AGHT+IFmHDWb6XzdhSn+rF7/y3lEA/0PHMbVJ5DJ28KqheTyzL4ul6XvczyP9yQrE/mJ739SZxDNZA==
X-Received: by 2002:a05:6a20:9e49:b0:1a0:eb42:a708 with SMTP id
 mt9-20020a056a209e4900b001a0eb42a708mr8354340pzb.18.1709334648603; 
 Fri, 01 Mar 2024 15:10:48 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 58/60] linux-user: Add strace for shmat
Date: Fri,  1 Mar 2024 13:06:17 -1000
Message-Id: <20240301230619.661008-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c    | 24 ++++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index cf26e55264..8d13e55a5b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -670,6 +670,26 @@ print_semctl(CPUArchState *cpu_env, const struct syscallname *name,
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
+        FLAG_END
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
@@ -683,6 +703,10 @@ print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
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


