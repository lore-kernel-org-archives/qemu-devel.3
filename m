Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C1AC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbg0y-0000T6-Pn; Wed, 07 Aug 2024 08:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg0v-0000F8-HV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg0t-0005PZ-SA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso11750855e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034613; x=1723639413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpWIKWWe5ixWDtiVxOKLp+Lsc4k9VqF1doDZjHB6Yj4=;
 b=IInkAKM10xipG/W6k2wTx+SRbrzWQJ87K115O67elcap3eDAka9ULldzrCN/no1z+U
 H6lgQfTJ/SciAR7V4NQGxTOl564byowSxdSyFhF8Tc0eZLpnGCJnx9PuHUDDYHekcps/
 gOkYet81qs8hfw9zg/eSrIPlbKw9wM8JTxSdAQxaUNlPZ0wpw7TU4KllXiW+OFB7eklo
 BSR349nFkOsrzLGJcaux/kdCII+lHvvqCLp2HNOucEQRErYNI8IJY/uLQJ6v45NGIPZo
 dCI23gA3n4wZUPc7vF6eI/nzZdm0lxwNhXwhQOMG6hmz65UsGqO6/dLjNDUSTelk3WwX
 UDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034613; x=1723639413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RpWIKWWe5ixWDtiVxOKLp+Lsc4k9VqF1doDZjHB6Yj4=;
 b=HxJFq6ub+mx2C0DM0QIgl/I/SutRNFYKEQYJsSGrrB19s+NLl6uHIuuUnwPe44nD0h
 PZu9BuI5Ta8J5oApxTW+mMsO5BlAPeR1qIo3yTEEl5uov78BhiObE+gOkBu5epev9mbU
 hOE0iRMxWmS4KePAN7ESI67PvyQILZe556KMK2nVzzPiFFF31mA/CAR7LoUfvW7BqUX4
 ypJqH29ldTz5KSO9EeViy5cWLmtN6YA8VKZT0o1ohfwll0eGuOHq7hiRzMeBa16+8cHh
 lJXQqZTFrkdUUSqRKAyTH0eE7ulBH8k327f8TikMyT4gSOpTNtxwAVFFyj8ql0CsUvyh
 weFQ==
X-Gm-Message-State: AOJu0YyLGeIGD8JWdw7j3SK4hOktQKOjt9W4/cXoDJEbWxQSgBylG8dC
 auFVWRYHDhyoIL/x4V7RM4Xyd0MyfSisf3+Y3E2855W+Q9fmfL8FfFimAw/1T04FQyxgha36d94
 D
X-Google-Smtp-Source: AGHT+IGHZcDQ8rE1wsFbjTo/aEaj72VTzl7StTe0h8wuh9gw31p3m0RF8vxvNO/OhyDv/mJY6in6yw==
X-Received: by 2002:a05:600c:154c:b0:426:6389:94c4 with SMTP id
 5b1f17b1804b1-428e6b956edmr116126765e9.37.1723034613204; 
 Wed, 07 Aug 2024 05:43:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290580cf79sm27443265e9.48.2024.08.07.05.43.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:43:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/5] linux-user: Add strace for sendto()
Date: Wed,  7 Aug 2024 14:43:05 +0200
Message-ID: <20240807124306.52903-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807124306.52903-1-philmd@linaro.org>
References: <20240807124306.52903-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 210ff86afc..98ef26b917 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3127,6 +3127,21 @@ print_bind(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_sendto
+static void
+print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_sockfd(arg0, 0);
+    print_buf_len(arg1, arg2, 0);
+    print_flags(msg_flags, arg3, 0);
+    print_sockaddr(arg4, arg5, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) || \
     defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64)
 static void
diff --git a/linux-user/strace.list b/linux-user/strace.list
index dfd4237d14..5a86419e7d 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1285,7 +1285,7 @@
 { TARGET_NR_sendmsg, "sendmsg" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_sendto
-{ TARGET_NR_sendto, "sendto" , NULL, NULL, NULL },
+{ TARGET_NR_sendto, "sendto" , NULL, print_sendto, NULL },
 #endif
 #ifdef TARGET_NR_setdomainname
 { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
-- 
2.45.2


