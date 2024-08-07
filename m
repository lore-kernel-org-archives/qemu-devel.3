Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB74FC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbfve-0003On-Lf; Wed, 07 Aug 2024 08:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfvT-0003O4-Dn
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:38:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfvR-0004iy-R1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:37:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-369cb9f086aso1085367f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034275; x=1723639075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpWIKWWe5ixWDtiVxOKLp+Lsc4k9VqF1doDZjHB6Yj4=;
 b=KhgLBKF0iP7sfipXXuR0qbs2SuHbO5PYsO6oPowTecPu1sFEj3BeuvcCB/4svFB58b
 kENjL0HtSCkv/1o/pMg035VBhj/K107kQqxGEA9tER0oYj7bw5JYwOyEtUbeZxZRHmfr
 XocxUC+dgBp0BJSgYXTpstzEMHZ2Ptbw7MssqnvVzkuwFhoLQzAruB7RoXRpRLHQoWnS
 OXyzdZG+xVRnCPKrV/M54xlDAo6dqoGoKIE5OropIY0ijRTnOtMpT2XmwnsZP1FOvEcy
 +BPhC3btFa80geS4gGMj9MZ7hXSKGWeZyf5DPZo3butXeINOGDqLgdeV0RCPYfUZrFQv
 rQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034275; x=1723639075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RpWIKWWe5ixWDtiVxOKLp+Lsc4k9VqF1doDZjHB6Yj4=;
 b=SJ/K9Zrp377PjIfImsR+BBb4PCg536SiMkB2cb6+BG0qF/bBvsJe0vF6CpLGPmuDlT
 A3U67NE3c3TUXGo3QUjU7gent8nRd/H54VLdIEcqmFau5b6pwmZAcuhAmIYPXh8eYVrL
 pAwjZikbJXOfUWo7/mpHa7BQ2vAiocuwbCY6/Ld+6bWmykrmOMLJdy+yUGFgMvEJY1pU
 tkx0MxeurCXcgpF8f/pndn/OphBDUA8s0PnjFfsiaE9rhtiwlAri9PHzOOqRfWmVOGTn
 c9TEMWZTBhoZJyTSqzm/QwvDvcAe2pNAAYHctYW8clZXLW5ycGscqZ0fwP9joPEAZy7j
 dOqQ==
X-Gm-Message-State: AOJu0Yw5znK0qgfNEbOhOS0ClBWIhoSoPDtOzOwskTGcNwn6UXBAoPqn
 iNwrOnMpyXlCvrfNYBWb3e5wUQJ3F3Facmu1s1U5iiVrzAOMKBGkjA1PVRH42QkVZR90f+yYMrQ
 K
X-Google-Smtp-Source: AGHT+IGWBokZAprO6MY1OBf7LHSQ/yhmmO5z5uqCjUx1MdlBbl6uDJ8ssEq8U4nKJZD3UAO62rSonQ==
X-Received: by 2002:adf:b51a:0:b0:368:30fe:ffd2 with SMTP id
 ffacd0b85a97d-36bbc10fb16mr13421243f8f.22.1723034275121; 
 Wed, 07 Aug 2024 05:37:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01eff1sm15850833f8f.44.2024.08.07.05.37.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:37:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] linux-user: Add strace for sendto()
Date: Wed,  7 Aug 2024 14:37:33 +0200
Message-ID: <20240807123734.52501-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807123734.52501-1-philmd@linaro.org>
References: <20240807123734.52501-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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


