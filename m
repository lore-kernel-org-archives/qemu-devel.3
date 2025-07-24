Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECB6C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetg0-0007Q2-Na; Thu, 24 Jul 2025 06:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfw-0007Hw-Kc
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:48 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetft-0007xO-Jp
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:48 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ae6f8d3bcd4so157013366b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354784; x=1753959584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PE0ygnCXxcMjKWqLld40Yn+pNBLfsKsnunVdasDUmpw=;
 b=kPbpRs/v8VmJ2ID7Ph3HotHMRjvpOLF5wVTTI0WnngR2oNIpcbn1oy3EF4CasfN+n+
 TXWeMgkFewOu/qsLN5B59IDtbjEPllmolJWEj4SY8kmBs8otb/L5i57ZLpjs/cwGj2ur
 VIjmKxs2TH2lzlKEYmtObPx07dH4+sa8T+v/f2ztnjrIjcTMPLaPuwxL4bN4ieGHP73H
 L+tEF6h/Uc3IiD3+nAGPYQOzLy6gvi5YQyVJwIL4o9JSqnvhB+uOoE3OQHsFeolsHTXU
 PL+2sNPeH1RHZduVBboMDGzyRcJlSqUEn0f9prKWXk7DQaRn9Z9U06FVq2hJjs0hOQpA
 1AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354784; x=1753959584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PE0ygnCXxcMjKWqLld40Yn+pNBLfsKsnunVdasDUmpw=;
 b=v2VfO30IIUBdQvOWAbmz3eYFvKXQc28YfNxbfcazcS2dllEGdWD09XkEqPvn7PG+Q6
 wgByxzpHGi+j1PhGgTQR/65erVMrOU5xCWCXf5vT1TwdKOzIrA/y1wmZygE5aYqgmu7q
 xsVUqVWu/BYuTwwtrrVryYK12vQ01YcnlHGRlU/VFKLADYpbSIpWlUkZ0JYX0K4S2WAZ
 wLkZtkqmmOgBD+G+cmRofcLBmm9ms/SeZzJvJo2FHdkUXuo8BmhWi3MzB+xxRJJAs+1K
 DbAlS9mL+FB4/svAlPbSkrpAzp1cMiwkcIpihAjs6IhVh5qhU8U8AKIC8PRUEYDwiF0g
 NCFg==
X-Gm-Message-State: AOJu0Yxz9aGTLLdTIv3gZon2R3dgq2OjOQ+V8bjmehfMm5OQOgeDKI1M
 iB/iVpkjk3RRp0D4lV9OuXIkAmtVHNjQavLltDxIMH14CSGjIZGwtrF1rYncTREs+5Q=
X-Gm-Gg: ASbGncvVWQ3q69Et825ul8ptoyH7Wi4sVhVXUMkqaov48X6doaRcSWa5OPhfbPuP8OZ
 hnUSuhhUNdOHBLhv3mPt/UHlf7JoibPnCgyRRQYMwYyyYjWGJw8nLTs1A1PtBhGTqFaT6YWlSn7
 V9rIkYGHUVSb8g5TWI7PvSLQhmiOb6ytonJcU/RYW6oCv7jv9hktgFNhbdpF0CzEHedyi3347ep
 mHr3wRXGOdgABGyv4bjNDqyYO+vM+JFr4PmwH3hBo9BluxfxxG12UuWal2Ocx5k8g3dMCIEM3YB
 WfNvLYrwlhIUfGOhGkEBAjgor8ucdvN2DFJyZNcQpajSnROSLAtaKY5N08Oj3a5gFzEUKWWclwH
 SW20VuYk0H7mlKY9CCoOjlzI=
X-Google-Smtp-Source: AGHT+IEpe9vt926DfsbFEtvLt4SOFalPvWmbD3v+bJie3ICf4S6I+UGntGrvnIMVEwfsWxEybn28gg==
X-Received: by 2002:a17:907:3e1d:b0:ad5:74cd:1824 with SMTP id
 a640c23a62f3a-af2f865bea7mr619287066b.38.1753354783930; 
 Thu, 24 Jul 2025 03:59:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47f44eb00sm92874166b.73.2025.07.24.03.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 33CF05F89B;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 03/13] docs/user: clean up headings
Date: Thu, 24 Jul 2025 11:59:29 +0100
Message-ID: <20250724105939.2393230-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

This was a slightly duff format for rst, make it use proper headings.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/user/main.rst | 50 ++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/docs/user/main.rst b/docs/user/main.rst
index 9a1c60448c5..b8ff203c212 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -17,28 +17,34 @@ Features
 
 QEMU user space emulation has the following notable features:
 
-**System call translation:**
-   QEMU includes a generic system call translator. This means that the
-   parameters of the system calls can be converted to fix endianness and
-   32/64-bit mismatches between hosts and targets. IOCTLs can be
-   converted too.
-
-**POSIX signal handling:**
-   QEMU can redirect to the running program all signals coming from the
-   host (such as ``SIGALRM``), as well as synthesize signals from
-   virtual CPU exceptions (for example ``SIGFPE`` when the program
-   executes a division by zero).
-
-   QEMU relies on the host kernel to emulate most signal system calls,
-   for example to emulate the signal mask. On Linux, QEMU supports both
-   normal and real-time signals.
-
-**Threading:**
-   On Linux, QEMU can emulate the ``clone`` syscall and create a real
-   host thread (with a separate virtual CPU) for each emulated thread.
-   Note that not all targets currently emulate atomic operations
-   correctly. x86 and Arm use a global lock in order to preserve their
-   semantics.
+System call translation
+~~~~~~~~~~~~~~~~~~~~~~~
+
+QEMU includes a generic system call translator. This means that the
+parameters of the system calls can be converted to fix endianness
+and 32/64-bit mismatches between hosts and targets. IOCTLs can be
+converted too.
+
+POSIX signal handling
+~~~~~~~~~~~~~~~~~~~~~
+
+QEMU can redirect to the running program all signals coming from the
+host (such as ``SIGALRM``), as well as synthesize signals from
+virtual CPU exceptions (for example ``SIGFPE`` when the program
+executes a division by zero).
+
+QEMU relies on the host kernel to emulate most signal system calls,
+for example to emulate the signal mask. On Linux, QEMU supports both
+normal and real-time signals.
+
+Threading
+~~~~~~~~~
+
+On Linux, QEMU can emulate the ``clone`` syscall and create a real
+host thread (with a separate virtual CPU) for each emulated thread.
+Note that not all targets currently emulate atomic operations
+correctly. x86 and Arm use a global lock in order to preserve their
+semantics.
 
 QEMU was conceived so that ultimately it can emulate itself. Although it
 is not very useful, it is an important test to show the power of the
-- 
2.47.2


