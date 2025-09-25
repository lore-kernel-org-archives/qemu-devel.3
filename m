Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E707ECAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 02:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1c92-0001xe-T0; Wed, 24 Sep 2025 22:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1c8z-0001ww-S9
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:55:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1c8x-0002WH-7U
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:55:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so310458f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758768934; x=1759373734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMSkQ8tS0Fq3QSh+vFnvslWSeFrUAxUcnptpA9cP+L4=;
 b=NXMwhVlA2jZsZhIoG/0DOBcr1eSNbEtKg/G9n9tZ4go3CtEqAXsL6RlOOHqcmfgquu
 mCFnSlhmdDUeD2RldT+Y4QcJGZgMbCXD76ivtTfwH3R714ZBrRrYrXMixcUfk2nzcSvC
 RRIUKhn8aj79U87S4Vl0QsbKFz37PBYtvB3U530nbvFvjyM+QO1VOIoOM3K1REDveWry
 Jbr3mNlV0DLPqpf3tU5zrcLInSmwmUIbYrd9hGlcrRDSWb3XWCrC5mwVBs7ZtoB5CYGL
 45AI9LPgsI+Rgl+dSI9+R5OVHmqVLwGAEJimhJvHOndy4izNdEXMrPItDf420co6H4IX
 HinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758768934; x=1759373734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GMSkQ8tS0Fq3QSh+vFnvslWSeFrUAxUcnptpA9cP+L4=;
 b=vXws8dwpFX8E/3ehasBfJrJ4TvX1OGyu5uFNDZ9ATtltCD0HvIiv3Gtvm/mu6+mD+I
 HRVFMl9QqqeXeLOC/6OzWSXiSp/Os95IcwvP+adPS9Bz13u4kRHZWrtOQ1U0+/TzPxYi
 jUlA5DeTQuynBakVF4qAuXRCvenZKxZjppths7RxxI2yiOXC6FzK0eH4lbO4Pyu6/RaB
 wAVzKCyBQRJlgLAnJXglU2ytz3iME8MF3FPqetGBXic8CSiAZKBtVxtnEvDp4NK6I+lw
 n5Nwk6iBzSov9xfi0VNBwvXdJcfHk5VnJevUkIKJQX7s3GFuF/24ozbZXk5mjmKADSpp
 fdGQ==
X-Gm-Message-State: AOJu0YyljbYx/AsNR263Hj/YTn4ZGeRpXIgBAj3GUrQ+RZ9FTb8CfD+9
 0YVB4vLJxxDepyTP43sk6wqvFnNDH9cXmJFpNlKFg3EUnd42nUWjIVcrNf/G+DS0Q613JIEfgdt
 6XpIYcSnMzA==
X-Gm-Gg: ASbGncvpBf1qrZr3GpMj0dU1iOtNb7SF7wvmST3HAsM3vlCn4quueFbItbrAhKCOiK2
 mhYmv2gAD6pFDclaHMb2Ng9tKvY8NqFVX8yt5OtgeYxWROzobEtqKoy7S0kXazVC3lx/mC60Gpr
 rYxFNBu9jzNkp4+2h5Po1b2fbd17FDf5beYNJJrsz2WCYM7ytYW3Oh9T4CDghdKCcMAG/k0Ad8z
 Tzviejg4r/ERm/3CrorCcSWMDvvWOYs/Si5fNnB0Wl3BzIAYmHgUKTeAFPl8OclnO/ieOQtUEJu
 BIn6E8iy7MIQIDShBZW9mqvkOdIUuQgGi0YH2B0LuL8WUCnYf2hmBiKA+RllmOz3iqqGkOx3rUw
 ruGFVbUxRkSfxw5eqEH9CxTzU7KdvNoqxHZNhxL/J7xQ95WaWiqjnXXF9zYv/KQynWOjKPNeS
X-Google-Smtp-Source: AGHT+IGUgr+uSOvWhJNgshrow4YUrsqarBBn7PfgQ8z4KuRBhxvHTHxpq90zU3j/a00h/1m/rIhrZQ==
X-Received: by 2002:a05:6000:607:b0:3e7:451f:3a6e with SMTP id
 ffacd0b85a97d-40e4bff51d6mr1567732f8f.51.1758768934460; 
 Wed, 24 Sep 2025 19:55:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb74e46bcsm939728f8f.8.2025.09.24.19.55.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 19:55:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 2/4] cpus: Access CPUState::thread_kicked atomically
Date: Thu, 25 Sep 2025 04:55:17 +0200
Message-ID: <20250925025520.71805-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925025520.71805-1-philmd@linaro.org>
References: <20250925025520.71805-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

cpus_kick_thread() is called via cpu_exit() -> qemu_cpu_kick(),
and also via gdb_syscall_handling(). Access the CPUState field
using atomic accesses. See commit 8ac2ca02744 ("accel: use atomic
accesses for exit_request") for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 6062226d4ac..818a8047198 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -480,10 +480,10 @@ void qemu_process_cpu_events(CPUState *cpu)
 
 void cpus_kick_thread(CPUState *cpu)
 {
-    if (cpu->thread_kicked) {
+    if (qatomic_read(&cpu->thread_kicked)) {
         return;
     }
-    cpu->thread_kicked = true;
+    qatomic_set(&cpu->thread_kicked, true);
 
 #ifndef _WIN32
     int err = pthread_kill(cpu->thread->thread, SIG_IPI);
-- 
2.51.0


