Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B940CEFC41
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJf-0007XR-Pf; Tue, 08 Oct 2024 14:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJS-0007SP-RY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJL-0002T7-Ae
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:01 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71dfe07489dso2210912b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413513; x=1729018313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYBWpQBnXZ27uF3GVfCeocPGkAYUMjeFh2ALsFccVN8=;
 b=KWP0Qrk8sgrfWvJflShrddoSYkn0AoCoeq3iCKJ2KVRPqfvKS5IOAUYeHFBjn1arWu
 ILE5Rw8mYx4wcNGk1y2fBfbCMW+pIXH9QYQirGyaNNg1A58rZ+hNEwtABk5EPZEopvq0
 YjlSZ4A69Ba2IRuse5XYUrXtE35eQYRNyjInlWE/IsS/nd9dSE8B0htKe5K1wP5ERmP3
 k+lclaCf76NYOZmulzWILscuUbz4cgv4jb6bWZZkeNycekHKltptcDCIsOkKermGCXzq
 lDH3AxM+ySLOC03XzC/iEeLABayhHWCidXxh6bp0lT+Uw7hJn8ihqfUsdRBmlRdZtJ/r
 6b0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413513; x=1729018313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYBWpQBnXZ27uF3GVfCeocPGkAYUMjeFh2ALsFccVN8=;
 b=xBMvKeeE/Us1sCvCqW9pDIBi4GFKmvJf4XpeQ7qg45JxBqRxSHxSYUY+RTH82hBM2P
 FZNBxcsBW23Gdrhyp5zLJchKGgA+1VV5ZjkOMico50EGfoMfY0X3JFJj6T5qxZS8Ofmo
 BEJMSpqsVdAr6W1a5OdNNnuNn/FDpzffmQ5Mdl2EGjxyXnqn67XZEFWmquIRD/G4P507
 GkWN8+Sc2EyVM6VpoZJzoRemtD/ZUs4Z++FE0hTHWlKjdJryjctu//4FeUaDnvHK715R
 JkIuXl1Qgq9cPlibdLI6Psr7qFiHNQQnguOAbuZlA+QXQibJL2Fc/dSVFgRHdwPVHDav
 TRUA==
X-Gm-Message-State: AOJu0YzmocLBlF+sUhuKoD2Ai86fYHVEy8S4CJgEPoSLRra7nbLikw6u
 ThK1+bJhLzVFacuafECsSx4dCWcx5l8cIl+CcBRI/2yhNx4i7ik18QuksrqXg9ePgzELEz9zkce
 0
X-Google-Smtp-Source: AGHT+IGvuNBeVhBzUQji1m2qyWU+l6FkyhpJVHi0kCAQAIc3lNup0sEV6m0PkiB38KWyxOxfCJXIpw==
X-Received: by 2002:a05:6a21:1798:b0:1d5:10c3:ae43 with SMTP id
 adf61e73a8af0-1d6dfa45775mr21831835637.21.1728413513002; 
 Tue, 08 Oct 2024 11:51:53 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/14] linux-user: Add strace for recvfrom()
Date: Tue,  8 Oct 2024 11:51:37 -0700
Message-ID: <20241008185141.20057-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240807124306.52903-6-philmd@linaro.org>
[rth: Do not dump output buffers.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c    | 17 +++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0263e6a396..c3eb3a2706 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3142,6 +3142,23 @@ print_bind(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_recvfrom
+static void
+print_recvfrom(CPUArchState *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_sockfd(arg0, 0);
+    print_pointer(arg1, 0); /* output */
+    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
+    print_flags(msg_flags, arg3, 0);
+    print_pointer(arg4, 0); /* output */
+    print_pointer(arg5, 1); /* in/out */
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_sendto
 static void
 print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 64d24e16d0..0d69fb3150 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1138,7 +1138,7 @@
 { TARGET_NR_recv, "recv" , "%s(%d,%p,%u,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_recvfrom
-{ TARGET_NR_recvfrom, "recvfrom" , NULL, NULL, NULL },
+{ TARGET_NR_recvfrom, "recvfrom" , NULL, print_recvfrom, NULL },
 #endif
 #ifdef TARGET_NR_recvmmsg
 { TARGET_NR_recvmmsg, "recvmmsg" , NULL, NULL, NULL },
-- 
2.43.0


