Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C3EC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfJW-0000PZ-JY; Fri, 20 Jun 2025 13:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJR-0000Oo-Ll
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJQ-00049y-5e
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso16999745e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439638; x=1751044438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ja/mWaJxTqT9HY8GpbCcKbyHjlgZdtvBuMFDUY0S1Jw=;
 b=bYIttQivQOPdTpWCVW1qfEdkOUJ/S+WPzt3EKrrH05xCEasT5UvyYeiWlwi4eh8C5J
 EY0iGqnPDSqaqWpxpAje0v+CE/0jsZTaR67tg0j9qPhAsCDede5WDL8I54aY0lCk1Jxx
 Ylv1eQruzboh+r48OBZmPeqdOXspLSRg0cj76HUPdC5qljL0PsUCFLPRURE/DSDsoEsr
 yUOywoWneqZyu+0Jq2huPKnNilGdgj5MqQKOrTGe5jhO5Vykd/f7ybQXLF6Q7bXgx3ya
 IpezS/t1HXsQkQcFYvuSad7KohCM7E0dYleGiU1GFZcsq5efEN8P+p7HG2Lbn7NpXoNL
 ugVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439638; x=1751044438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ja/mWaJxTqT9HY8GpbCcKbyHjlgZdtvBuMFDUY0S1Jw=;
 b=pEh0YIFC3xX6c2lzYjyP8joyQgqhqXFaJnNy8hsdj3uuHC25GE/tt6Nj/+YGDfSYaq
 ZyAEtOdEcVR7j7uimOd2Z4C3CSJ/pV82u1UB/ZZ17/LggsQh6A6a0LUBhHd2v9LMuDlQ
 /FsXGYLDrMxH2tMG+bA8bHQirZNAlyQhKRvxYniyzFk5T0alrWPW6f1r3tZqm/QyDZfL
 MwylZ2esQj8R1h7OfmOaaOiHJ06ZblNZJ3q0H+2TFbixDS/rZXYabYddpfpBjgD8uWR6
 bBHjE9JOgBI6aL3mlP45ZHjd/b7z4El44v/sVAH/G/lgk8uGWFnVTVX5qrx0ZQCG15Eq
 +5Aw==
X-Gm-Message-State: AOJu0YzePLjxb+xiDjK2AcCUTNIjqd1UN7dSaWZQg7xTE7oCZXZOLZlF
 et7S36AQXG00FjN3gDN89d44RqHJRbH/WBoBFU4CAvEFdyIs8q8gMclpSxchbgQGmQPH+0mp2PW
 +dbUcnCE=
X-Gm-Gg: ASbGncs/F5MgyuZI3Gve4R0NTooy7UKOK+yrjgWxfkOXlov0aU9Si472EYnEjEXkbH4
 EEy+QJUJFlO87uUdA5GFrZu4/MVYbwqvCI1DlEaYDB1CS/+uJQupbR5HJsugEqF+awdiQuCaPRw
 GGXj6RChHdJ1s9hgEgQ3AJ7ur5l0V9xdwvPwrWRyrnJp4/a7OOcrUwLmqfhwTUGg1qUi28CWAWT
 Vtyh0wYBpH0NoWgjn/EfXpbMiCWMyT0xoB1TlSgStJkhTKogjIacLdc2Av4a21nXxQt35n6k1Mt
 ldlqeMqmFuICKJOOXAR6irhbu66FgiHnXzx6Uww2kiN7ZAgXfFhTHwZdA5AKinddmxQsYhiuita
 KZL3jNy4v83Yg6FEhzRbUPByx3gyjOC2H23yu
X-Google-Smtp-Source: AGHT+IHoG7iXCi0Xt0ylPgXt07b2kV32O4wxk0ckO4PWzFpmSrDwMon/+kesxjlV9bQsG5+1iEZqvg==
X-Received: by 2002:a05:600c:4684:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-453659cb92fmr32553385e9.20.1750439638298; 
 Fri, 20 Jun 2025 10:13:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364703701sm31541125e9.27.2025.06.20.10.13.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:13:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 03/48] system/cpus: Assert interrupt handling is done
 with BQL locked
Date: Fri, 20 Jun 2025 19:12:56 +0200
Message-ID: <20250620171342.92678-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
 accel/tcg/tcg-accel-ops.c | 2 --
 system/cpus.c             | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index da2e22a7dff..37b4b21f882 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -93,8 +93,6 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 /* mask must never be zero, except for A20 change call */
 void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
-    g_assert(bql_locked());
-
     cpu->interrupt_request |= mask;
 
     /*
diff --git a/system/cpus.c b/system/cpus.c
index d16b0dff989..a43e0e4e796 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -265,6 +265,8 @@ static void generic_handle_interrupt(CPUState *cpu, int mask)
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
+    g_assert(bql_locked());
+
     if (cpus_accel->handle_interrupt) {
         cpus_accel->handle_interrupt(cpu, mask);
     } else {
-- 
2.49.0


