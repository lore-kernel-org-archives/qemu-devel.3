Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D18DCA0FE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzaz-0007th-Me; Fri, 30 Aug 2024 07:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sjzax-0007qq-De
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:15:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sjzau-00071z-2V
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:15:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-374b25263a3so224472f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 04:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725016506; x=1725621306;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UX1I+w8ByQPca3qnMONfIXIWlrYZp+DRzwa9VLHBlBE=;
 b=yrqCZcQFD+vh1xdkk0ObKOMwtjnaQe1aY0maaq+H+v3LEqfVvffFmqcrBA8eq4sDn0
 +/hhOoDektrQGe/EyYWWME6cFXpvs09TQxIunEN1TQATPTHSs5ffjHEraUednOSM31M2
 jnOniqh09+rRXdiVbYkrMd8dRyIlOCrveGRGIb93+mVVn0ebaCZBB40q1jYWJzfhsshZ
 Aq11HDzVuHJdOvnca78dY0pYEx5xOeGa1QwLqIK8LOxgsee4C9VAMfqgeAFdgywq4ZW9
 3myg18M6WxWz8qD4pPgMU08lDvrbwwxxN1XA8D4gWoHj8ZSoPanxG1GSfmdY/F25TBw8
 2T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725016506; x=1725621306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UX1I+w8ByQPca3qnMONfIXIWlrYZp+DRzwa9VLHBlBE=;
 b=S7w4XIqW/NOF9Ql8slyQrnAhaKbWabUVv+uGgexJqYf3HOvCMcF0AiZqCEELHuvHp5
 /FEr/J4J67m1EhlWF4MJkx/MipAGqIZbLMDjC9M21IPXNgqHCCaSM4kDdT7V5L/gYJpk
 hN8e1yom+Wrr3g201nxKGPfcokJOeSPWms/mMxJrAO+Th6JF6lWjFMfQyWHLmDqRw1sz
 xrXb5cWOUlk5a8mAHZotPyKCRtjJd7POlJV7eVW6urF5RtRloSEbscUBqs2gXaWqnEh6
 l2xtawrLBO9KLN+6PvQWFc8MYZaKGPEWa8VVr0O/jOZTMwDr2nRNREuz/S3vAxJZy/yN
 Uc/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkKDcBMFIT+pWuaCZ34wr5uTKS0C4YJh8R7/YwOr+Xn+HWM1DlWmo0M3iQDIGWlUvpfG+6YBskOIWE@nongnu.org
X-Gm-Message-State: AOJu0YyXTtcdSKTGB8r81FktnzJnuKc2CTDYxevpBgKuwRQ9tIjh714o
 sIVbwQFrenQx2qcvRmswTyoAaAc/E0rSL+E4HYpuZ8hQ4wQB8fw76BjXoPLnnd4=
X-Google-Smtp-Source: AGHT+IFNRvF35Y1a2a5LalbAm/b3WEqZt2TzYiJDJQUTH/9euy0HwTFGGi9Vvpy3KYZbRCHZ5njfHw==
X-Received: by 2002:a5d:424b:0:b0:368:6f30:ddf1 with SMTP id
 ffacd0b85a97d-3749b58750amr3845162f8f.59.1725016505105; 
 Fri, 30 Aug 2024 04:15:05 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4a590sm3713859f8f.9.2024.08.30.04.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 04:15:04 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] qemu/osdep: fix current process fds path for other OSes
Date: Fri, 30 Aug 2024 13:14:49 +0200
Message-ID: <20240830111451.3799490-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830111451.3799490-1-cleger@rivosinc.com>
References: <20240830111451.3799490-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

While Linux and Solaris uses /proc/self/fd, other OSes (MacOS,
FreeBSD) uses /dev/fd. In order to support theses OSes, use /dev/fd as
a fallback.

Fixes: 4ec5ebea078e ("qemu/osdep: Move close_all_open_fds() to oslib-posix")
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 util/oslib-posix.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 11b35e48fb..901dcccd73 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -814,8 +814,13 @@ static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
     int fd, dfd;
     DIR *dir;
     unsigned int skip_start = 0, skip_end = nskip;
+#if defined(CONFIG_LINUX) || defined(CONFIG_SOLARIS)
+    const char *self_fd = "/proc/self/fd";
+#else
+    const char *self_fd = "/dev/fd";
+#endif
 
-    dir = opendir("/proc/self/fd");
+    dir = opendir(self_fd);
     if (!dir) {
         /* If /proc is not mounted, there is nothing that can be done. */
         return false;
-- 
2.45.2


