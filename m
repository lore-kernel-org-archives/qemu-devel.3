Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433EFC87FD2
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwol-0001hx-KT; Sun, 27 Jul 2025 04:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoY-00016Z-H5
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:02 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoW-0000B2-Rp
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:02 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae3b336e936so687898066b.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605179; x=1754209979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMM/DF0PH1Ae514zCcDeAafowmFTAthBMPUUfVVGAHU=;
 b=XiAb6s0ReSnugIKeg7sJvIE2+/XUhQBMxIGwfCERf0tHSDRXrQyi8nAiOYIYDVGROG
 bs8MK+FWxSqz7U6n9XymTRXurMvwBH4YkLZTdzOqGaKD6WcJwRQvc6e2+h/yyO4FcSXX
 WF1ew3IWyWZKdPKyGQbBjV3sqligKWGvzSo9m0/z4ufv5HvNnTRN/E6BPuOSweM0+D8Y
 fc/LHLzPHkf7ZrKkwCaMX4aOT6t14quDiSjAShlK1RX5g5nRgVBEOq2ImOhmFixIcLiC
 0VAgDfqNavMEM4aT0icFVkv9CJ63zAd7u99i9UvV9yTPIFuNTVqL8RhhfbBzPIoDrlAo
 2ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605179; x=1754209979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMM/DF0PH1Ae514zCcDeAafowmFTAthBMPUUfVVGAHU=;
 b=cKKTdNBEqI6Y83TQFGQojbEcjP2q8Aiq6wy4DS/scxdlLSf1MxgLO0rmqKhBVfg6fM
 lWcIH7TBbSAXwHQknMv3zeKn3ouPqkjpnEsCjRw+0blUMNHQJZH09qoP54363WcEffAU
 GJqbIFIA5Eo6ijD8hnAJunat2cEkXIujyq4vy7crHSQCCRHkGqdg7pEknuslv2hIUBs4
 PrxCz2O5uLoSKPE3vq4P6kSwMzf2r6cyWjXWLokSTa5JU/gD/8o0szi+g1R93IzjF3si
 i3eycNF0g2dG7Jf8W+mlcryamFNnXTgStZJ7aJg+CQKzPcNzqSIAGT69M2K6mMVGJzFC
 0d9w==
X-Gm-Message-State: AOJu0YzOctyf72JAGGNpF4fPhPQNu9flPxQlcLBTuGIjjNCG5vcdKiDD
 gE4cbWE1CcokYP2E6QG/5KVBgxxaoNvm7MQMGy6hm6Z7a5nz+lPeOfCGFrpxX8qOZLI=
X-Gm-Gg: ASbGnct6u4zlwD7jP+TLxmQTIRUFIYsK8wgQHiIlY8Hvv2xrOQSoEf3U0SYKV0kRKhL
 8IBxmsS0is/FWw1pKPaqyE1rshweLPxQnOaFTQQ9BHTQdBMu6tKt5HS07NQwxH7koWkmL4l091S
 8PDyJEghiB3+ZMQjYQzuNZ+h9yghTHeBMDDQfpw0lCoeK4M9vF9skx3cpnpGBvbbIYl6Ex4QM3h
 A1w3vFbAeZ/2ihCB/NT9JKREX7S4KOTtOl9dlokYQVKiNotO2M12MscUVTiDJCGtUqDRu3468Fs
 adOygquofO+atiBiH4okiYXaArkY4zwPmcsjo5AVrotx82u3PtvYNvyBHixlwWq8x70PALO7gA/
 SeEK6jYR/LlHjM7Osufg/1p1PLBoYD6G5fw==
X-Google-Smtp-Source: AGHT+IEWllw90zIrqfthL0JiLe3iYpPNqi7Tztdxc0P4bjJKAiDkwl6FQhO0k/RflAnRhau8k0aUUQ==
X-Received: by 2002:a17:907:3e1d:b0:ade:4593:d7cd with SMTP id
 a640c23a62f3a-af61c8a6743mr892580266b.13.1753605178660; 
 Sun, 27 Jul 2025 01:32:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635a65fffsm252102566b.76.2025.07.27.01.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:32:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 584A55F89B;
 Sun, 27 Jul 2025 09:32:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/14] docs/user: clean up headings
Date: Sun, 27 Jul 2025 09:32:42 +0100
Message-ID: <20250727083254.3826585-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-4-alex.bennee@linaro.org>

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


