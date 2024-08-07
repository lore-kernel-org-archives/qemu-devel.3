Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20280C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbfvk-0003Yl-Lj; Wed, 07 Aug 2024 08:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfvY-0003Om-Ui
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:38:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfvW-0004j8-TK
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:38:04 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3685a564bafso944691f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034281; x=1723639081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pq1dTXzDXbRYVMh0ReJZN5GzV4YwZOctS4OmQtmosdA=;
 b=excwC3Esi70I1NSvZC3VTe/TylvQ+2MuIGK/bizV+LPl/UjRYTPh9f1CQZ0AJ8ty8E
 kWTmggjWrGOgzKyk/MEpu2GlrzHPs1gOhQA+hWWXPQtq+v/hpwX7CRecl62QGsBBTMQL
 FuYPsGUvTcAC+0t575sf4kkhhhCJq4Qbz+saYocSYwBziiu7WQ1igTJKTWd3xw7+XEDb
 WycuX1V56C7meQHL/KrnGjKCeYgi102nEr8f4yn9vL+P/EGEEAacEPh/3YMZOGnNp//h
 XxFK3ePnlRIuT7+IOblkUgnJHsfwAMS8QNLIeTs/OHjBy8AKwLAxfpSIxck/vYsfCGUw
 BHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034281; x=1723639081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pq1dTXzDXbRYVMh0ReJZN5GzV4YwZOctS4OmQtmosdA=;
 b=U9xJAYY9v5AYJNzrxIBHk+UcMICXBfvnhKxGUEWegWfJhI1xc1xrchURkzMq6bCocM
 Y6Ybg2xfY/GdxHDQAtkzjtZTTK/T4idOV/U0MJ5iDEDDtiAWrNfC/WRLloNnX1+icdAS
 aMzVnhSvUtul+csEnfGwRfqwXz8Q5DrQOrz8C4XuM/AAA7hgOAI8VLhTJ58zre5TaRF5
 L1uo++Bgg26jD+wmSLKCpm5/kSduOtyXNsYMjqslPi8m8f80XbBWs+qosTh5A6nHAIIw
 oGDMBxn1v/KwbcqJbpX2LAfSJNNLm4HpgMY3pmXRF54pF3/iE3Or3xFZ56h0gINgcwX7
 9b0w==
X-Gm-Message-State: AOJu0YzrtJxNys3O+J4bh2DSahesa6ySIMI8gIY/okSx5tX2iIRX0z0/
 5tuFJjJXnIhPPSldf+9ztod4PgQRRcwCiGtJZeXSex3hblpdcTc1fRYnTHw3PQIA8q2561Zc8Hp
 D
X-Google-Smtp-Source: AGHT+IFicKdMpWJ9Ol7cxh/jMPaeCJdnUUlIMySUL5F9Gb9OOwnusGAOGI11yDrFMsAvk6Pdd76VgA==
X-Received: by 2002:adf:dd87:0:b0:367:f104:d9e8 with SMTP id
 ffacd0b85a97d-36bbc16102bmr12385015f8f.47.1723034280721; 
 Wed, 07 Aug 2024 05:38:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0de1csm16027213f8f.4.2024.08.07.05.37.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:38:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/4] linux-user: Add strace for recvfrom()
Date: Wed,  7 Aug 2024 14:37:34 +0200
Message-ID: <20240807123734.52501-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807123734.52501-1-philmd@linaro.org>
References: <20240807123734.52501-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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


