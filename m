Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F228ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkR-0002Qb-Ci; Sat, 30 Aug 2025 11:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xu-0003N9-MR
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xs-00035l-Ms
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:26:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-77238cb3cbbso565449b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506364; x=1757111164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkQfzRBVz9LGX2QM0Sbr4ZLF3ewH7Bmx5RrPOumx3wA=;
 b=vkYwxBD/HzkyO9LxjvYUKvHT8qp2c525/oPrbeLH3Ea85tkEzqXSdsI7ThTe7EpNYp
 Q4fXymwDNA/rvSeQQXkC4w/mOOmfXGc5bnXDTU210otB4N/LVNyikUogGoufv2W1RkTk
 DfHg3Fm1uoZpySgIu0t2T+iLEMaB2zGDQ25qHYjbjixg6qkG/j2dQVIu6tma3tKjFlOi
 9jN0mVkVPF76FxpQ9B6TuEeZprWuOd1loRz4VNkwCs1K+uzF6EFWJvSyRoyLJyuPi7Ve
 O7g0G4URO7VQtvd9uPJcYSRVZPxgoUQ1vHUdvigoiB7Z4RE3HGDnO5DGdlssZC5L4nNZ
 K18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506364; x=1757111164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkQfzRBVz9LGX2QM0Sbr4ZLF3ewH7Bmx5RrPOumx3wA=;
 b=Up3gry7fPRZzSVsU3lRijyVDz1XVuskjIRBuzp99ziAp8s5uQZagc/CyfISMmMFXS0
 /iAmMn5v4Eg2Sd7MXBNnRcx5TQThOxsKI2wUyMsqwO3iQbYcgP3tjS0W91M0x4vAAKjQ
 QyX+dnfA9iXGnKZv/JPMYhU/A6JHQTXn3B3qdWhLulLjM5157m7Ta+/0OHj7DTIgjL2N
 OoC6FRDfRNYqEGpHlP8DPlmUkU6V8FfcYVjhiHS/OAZPxQW9lCOcXg/6epjZDxSgGByo
 mAA6SpEybyaP767AT8D+vfuRpU/8tqO0DwcV3NPeRZ7ZPaozWAww5CTVYbT06/jSqfTu
 siiQ==
X-Gm-Message-State: AOJu0YwZDMbstTzDAZhrGeEuMTVIrb8RtMbupbIUwrW6AvwQcXDHbl6b
 T1DSlrF9UkwvpF6H5U5yxcz31FY+Ts7H2HWm2E5HBYx7znKF8AFadZOWAazuEXOzmJ2X0i7Yn4i
 txmV3r5Q=
X-Gm-Gg: ASbGncvPSa8q10CGa+ltysOJhrXTpQZ5gg7QhGEfPP4W5gbSoQfsPYfJhCpZBfI50zA
 4BORG7uvKQIbG1YJ/nXBVTAQ6kaKU0ddBpEmewcJzYe2Gf8owFzV2bJz4iIZOmv5Ux7wqvxGlSp
 Dgwxsrmbz6jenSpFwg6cn6Kv9IL6IQ7o0gWCABrg1ja9oONbXtAMNURXCT8kPW82GdIqiq+HIP3
 xqQWD9Jw/+Ylg0g3ekNmZASqxxHchbOlnjoNd7T+ONxPzfmyjtu8mvyWg6eunxwE5kIMZdD5xd0
 4I7YWTwxUEO+iY9wLgY5Hb9QitSX42GrPIXNsIVfs0dYWVjlbpvlhaOzM0rYsQ+ckyuzLD75KLF
 uQAZVKQ68x23PyyGseS0rKWV4A0PESpFVqxyMYj3864d7zmOvcwyDqVmsK4Uy
X-Google-Smtp-Source: AGHT+IFslxS34ToofJkY0hOlSq4LPxUvYgT4UtQfkr/mOMBTE1PRYeZoQclUZj3HV8ICHVmfgRVS1A==
X-Received: by 2002:a05:6a00:3e18:b0:772:3c9:ce3e with SMTP id
 d2e1a72fcca58-7723e21f348mr265665b3a.7.1756506364417; 
 Fri, 29 Aug 2025 15:26:04 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:26:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 38/91] linux-user/x86_64: Fix dump of fs_base, gs_base
Date: Sat, 30 Aug 2025 08:23:34 +1000
Message-ID: <20250829222427.289668-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

We were storing the selector, not the base.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/x86_64/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 18d632ec34..12de1c54c7 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -44,8 +44,8 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
     r->pt.flags = tswapal(env->eflags);
     r->pt.sp = tswapal(env->regs[R_ESP]);
     r->pt.ss = tswapal(env->segs[R_SS].selector & 0xffff);
-    r->pt.fs_base = tswapal(env->segs[R_FS].selector & 0xffff);
-    r->pt.gs_base = tswapal(env->segs[R_GS].selector & 0xffff);
+    r->pt.fs_base = tswapal(env->segs[R_FS].base);
+    r->pt.gs_base = tswapal(env->segs[R_GS].base);
     r->pt.ds = tswapal(env->segs[R_DS].selector & 0xffff);
     r->pt.es = tswapal(env->segs[R_ES].selector & 0xffff);
     r->pt.fs = tswapal(env->segs[R_FS].selector & 0xffff);
-- 
2.43.0


