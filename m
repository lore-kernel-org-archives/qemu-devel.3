Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E2BCEFC41
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJc-0007Uk-BE; Tue, 08 Oct 2024 14:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJP-0007Qs-RE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:00 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJL-0002Sm-A1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:58 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e050190ddso1813995b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413512; x=1729018312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2PtOJCUNqbnhgRp0PzmkQFuI5aOsUosexzj1Se6aBs=;
 b=rW11cEZL+xp2lpFZYILKRLIQUxuRNA5t6Hg9xYgR2mhJXrnWNZaCCWXXlgZrZmiPfq
 09I04DChgsdEo+qjKvstqELJSR1I12az6My/jKaoeiyNzyHQBoK5Ja7820wn/4XqyCoD
 yQpGiG0Skng1w08gQ5HxX1x/z+2EGzIIKyO9Zi2W3399TAr2phh6HgE9GjjaLP2uA7d4
 Ocl04hyJKEKTpeKChaHcUrAFkh1Dfu/+HZvXWC/5tw9hy/c7IdgaBlImU4K/AQAywmCx
 w4XIujp2fvvoB7I0x5r2eft3iM42wafVMA4EroV1h65FMh5/z/uWRjSJ3AkfFebwROI7
 cUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413512; x=1729018312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2PtOJCUNqbnhgRp0PzmkQFuI5aOsUosexzj1Se6aBs=;
 b=OUfSaTHg9Z7DBQqiSOjp1UGyP9C9Ywgp5bN0jJUzkVNKRu35FDXcATrPA/VY9OG/vf
 KYwio+nkxDEPUK7/DDwUVIHERaqM5rBT6cYX3j8kM9TJ05o9BKjDslP1ZdMROBYbqSjD
 vax48R4JwkZYhlH+0qYkHOCawBpmkqEnpaVmNrCUdwnQ83fxxE02OmbrZC+bbzOdwf0j
 sKC/cK1sG+JbIa02gi5zZwecI3EIaAw1WjEvebE3tx2kKoxPtx6YTfYgk9EAIRDG6vQk
 imw2Kvt6ak8wjQfquTaJlxCB+Op6qaJWk3htC+JPDOQsJfBN/jViOQ6Kzo46CEdoaKLM
 MJWw==
X-Gm-Message-State: AOJu0YxPw02RzKT6MlBa/+3H0lMtf31jtZDwpyrakkMnJSFLq82oeQPo
 6pVJkTsCUP9C2a/C4LV6sD1pSu07dicSh01ASGopdiafbBFniSfmayuGCv9HWjGQjE3qgr1SHQp
 9
X-Google-Smtp-Source: AGHT+IFlFL1dKG6A2MSUK6LyPCHRvSyM3QoT1v7sCdeJQfyc+dT4NjZMk5pioVa6Mt/V6ZgTLgCE/A==
X-Received: by 2002:a05:6a20:d492:b0:1d2:f124:a1cb with SMTP id
 adf61e73a8af0-1d6dfa27999mr24547657637.9.1728413511984; 
 Tue, 08 Oct 2024 11:51:51 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 09/14] linux-user: Add strace for sendto()
Date: Tue,  8 Oct 2024 11:51:36 -0700
Message-ID: <20241008185141.20057-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240807124306.52903-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 245153c1ce..0263e6a396 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3142,6 +3142,21 @@ print_bind(CPUArchState *cpu_env, const struct syscallname *name,
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
index f8899710b5..64d24e16d0 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1288,7 +1288,7 @@
 { TARGET_NR_sendmsg, "sendmsg" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_sendto
-{ TARGET_NR_sendto, "sendto" , NULL, NULL, NULL },
+{ TARGET_NR_sendto, "sendto" , NULL, print_sendto, NULL },
 #endif
 #ifdef TARGET_NR_setdomainname
 { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
-- 
2.43.0


