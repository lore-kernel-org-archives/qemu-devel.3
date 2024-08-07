Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E86C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbg1B-0001IH-KY; Wed, 07 Aug 2024 08:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg13-0000o0-65
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg10-0005Q0-Jq
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428119da952so11823645e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034619; x=1723639419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pq1dTXzDXbRYVMh0ReJZN5GzV4YwZOctS4OmQtmosdA=;
 b=wq6tzVYgt5gfg6wgGuk4r5ia1NCr+XwFhTr5vUMdGT6ltYVA0ZyHpGOzXBFRvsQm4y
 aKfnL7rFqgOlDBQYGCh8X0GAd84j80zMaHfNDbLBKRejwxCRNFQdfNibAum0E+udB6UM
 g64v5CtGhxKy3IdKLoU3uxX7aoRLgFtsO7KFzkmU6vv/fXd/pDekWDLSO9Uoi9psCZoK
 kZyCI7oY6SQQ/OtTgcXSN6MJ+VQpeHYxJK9oOM++s4glTgRN6jXYhn+twkvqlOwQO47h
 9OdFxTwdTOOt5wwWUwQ8XGhcVltuCZGb4aniEmbmg96ngFnZsDQVE+nuUAGlarKqSJKs
 h8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034619; x=1723639419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pq1dTXzDXbRYVMh0ReJZN5GzV4YwZOctS4OmQtmosdA=;
 b=u0F1gb77BMdkrbw65sgw2SoINYEq4lMg9n+vdw1uYPrl7cLATOs57HYQcT1R4NNAOW
 EIQQTZt4yS1LYfI8PG1a1dT8l9b7QRLb8VnUftJLlY/jtS0kx8LnlkaxYZDEShAEoVBg
 2YawaJ5p+LaqKigw36mJbktXFMwpIdNLxUoybCj3QXyMZsJhPnzVtVF1dTPZzb5c0h3f
 NbDXFS+5U5FDVnLODLUxHCkaXiz2jgCyHOnDEn8r3voTToJyaLRn9Sog7AgXxa4MVuw+
 zLBddmt+/Ze0668e7ZUCS3vOq8QZ1V5Ri/UfrciQ+OtrjiG4JqDNh7QNcrVeheSt5d6S
 ClQw==
X-Gm-Message-State: AOJu0YyX25ypOvtVyx0X7InH8o6Wj9ikfPs1QKwvQ2GHMrYvnP3KNycW
 53Z19kVq2+lNphaxztS1Ftz9TZyuGX+xdjFq7EcaHH5qKwbsJj5vc+7I/9H+JYFVKpcFQXk2Awa
 Q
X-Google-Smtp-Source: AGHT+IH7S9E81PNnWavpi60hV7FbzEEzmSAiqmRxVasdEigs0LJE+vXIWJEju5IhoLjvD4dlrSsiJQ==
X-Received: by 2002:a05:600c:1f05:b0:427:d8f2:550 with SMTP id
 5b1f17b1804b1-428e6b043c1mr119371385e9.14.1723034619003; 
 Wed, 07 Aug 2024 05:43:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429059a6703sm27553805e9.37.2024.08.07.05.43.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:43:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/5] linux-user: Add strace for recvfrom()
Date: Wed,  7 Aug 2024 14:43:06 +0200
Message-ID: <20240807124306.52903-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807124306.52903-1-philmd@linaro.org>
References: <20240807124306.52903-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/strace.c    | 19 +++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 98ef26b917..d76907fdc9 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3127,6 +3127,25 @@ print_bind(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_recvfrom
+static void
+print_recvfrom(CPUArchState *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    abi_ulong addrlen;
+
+    get_user_ualx(addrlen, arg5, 0);
+
+    print_syscall_prologue(name);
+    print_sockfd(arg0, 0);
+    print_buf_len(arg1, arg2, 0);
+    print_flags(msg_flags, arg3, 0);
+    print_sockaddr(arg4, addrlen, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_sendto
 static void
 print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 5a86419e7d..77ca824f9c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1135,7 +1135,7 @@
 { TARGET_NR_recv, "recv" , "%s(%d,%p,%u,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_recvfrom
-{ TARGET_NR_recvfrom, "recvfrom" , NULL, NULL, NULL },
+{ TARGET_NR_recvfrom, "recvfrom" , NULL, print_recvfrom, NULL },
 #endif
 #ifdef TARGET_NR_recvmmsg
 { TARGET_NR_recvmmsg, "recvmmsg" , NULL, NULL, NULL },
-- 
2.45.2


