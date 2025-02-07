Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A08C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVZ5-0007Z3-Ki; Fri, 07 Feb 2025 16:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ0-0007BU-Nj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:03 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVYz-00022y-7C
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:02 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f61b01630so11042745ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 13:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738962420; x=1739567220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KwnHCfQIkLSuI5gCbIKhc6TbHv3lQ5OLotA3Bb1FOg=;
 b=tTcszQbiymLl49HQS9tEYc3GwkGRFqgAXF7r2M/7PFrTHzGC1Writw9H9JXtpaPlqf
 QGHAhzvyrg3uvYWfFG19i9pyMMJaV7hrR4Rvvtoag24oxYMAXfCWyJdZrESifDJfu7us
 etmrpDar4fS998rb55xtJuvIXfWJx4d8U6NX7CHQgRX9ens+9K+Ykguo3jvwvMHMLIv5
 ygAJ3Sci46VgvmXVeSL80ETLa1rEr9j26LpvVSFMadNw59+an1j9ZIvFYbwxOBkRY4W0
 oJVDK43o8kiPeZu2r8FPMSaLodtmUpcZK2CNrrVycsW1ZQSJxUN8P6HEJYJV0InaFIL7
 wuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738962420; x=1739567220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KwnHCfQIkLSuI5gCbIKhc6TbHv3lQ5OLotA3Bb1FOg=;
 b=jexzx+KQv3JiTHMzf384dobDDTNhELoenquj7gOiJPlb2UzDfT903QjG6SXHwWHd3u
 nvb2IGiA3m1SVVo50J79F6M7X/cTmFaDeVcHZwaIlV7rQdnMb7W49mM/kHvXtlQnSWgp
 J96zwU6L9JBwK2mfacq+D/k3U1S8mvEvTbnxc+cyvXtqUGWzywunUnJoc2dOYlygZE2M
 u1wOrwLdEVRPLsNP3WJdZXJLkQG+SwVf/s2Dv1JWjNi9xhguuX+shm35WSeHrNrzLrnO
 Uw7+mkmDzsbI3+v+KvQDQj3EPC5DVVZKg/OO61I/paSpk0Xhp0UUZOd1YRONVfdzSnxA
 JITQ==
X-Gm-Message-State: AOJu0YyY1N8E/L4jLQPJfTz3mPzrbtMxgbXOLFjlPqtp9APyv2pEUU+1
 7FMSoJP21wNkKIm+u3vyJbNWjQKIShmuknGZFqz1hOnhNIeon4wDx0m4TIKxHnJSYHVkpotdK99
 1
X-Gm-Gg: ASbGncv94Hi7ogzFcSNXTPpsFvN11gEnecuID9eWKF8HYNzQEoAMnXPcEIDygqeurww
 uiUXF2D004NZ4JJ0sT4Oo2aSWQf+XbjDDpHZahVZAr7JlFyOhzs9uIGMsVrAOmEOiWJ25feHTw8
 mk19Sm7IQTN5nid3dFznhQAJnyME1+rDlIDo0XBcaC9KC6SnOQK/fqnp8tH1LAXzK8OthvPQVxs
 P9j0vvTwWxssBOBT1pM24q3/IRH86hYoIIU4InMH7Ubd2qHxGp9dkaCwevhy+t+uLA+EK7J2Mz1
 CO0NjAoWRaCF4p8PZu5+M57tmVwN7t1cLuHoRu4UjRVjXaU=
X-Google-Smtp-Source: AGHT+IHAevrT7TY9yhFK2NZNLr20UqMQ7fJtLFsRoCuQq6YnJov1TZHuw6brOgYLRV02rraJX0hdvQ==
X-Received: by 2002:a05:6a20:7f81:b0:1d8:c74d:1ca0 with SMTP id
 adf61e73a8af0-1edf35c14eamr12564788637.11.1738962419835; 
 Fri, 07 Feb 2025 13:06:59 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af64c1dsm3539043a12.52.2025.02.07.13.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 13:06:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v4 2/9] meson: Disallow 64-bit on 32-bit KVM emulation
Date: Fri,  7 Feb 2025 13:06:48 -0800
Message-ID: <20250207210655.16717-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207210655.16717-1-richard.henderson@linaro.org>
References: <20250207210655.16717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Require a 64-bit host binary to spawn a 64-bit guest.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index e50a103f8a..1af8aeb194 100644
--- a/meson.build
+++ b/meson.build
@@ -277,21 +277,27 @@ else
   host_arch = cpu
 endif
 
-if cpu in ['x86', 'x86_64']
+if cpu == 'x86'
+  kvm_targets = ['i386-softmmu']
+elif cpu == 'x86_64'
   kvm_targets = ['i386-softmmu', 'x86_64-softmmu']
 elif cpu == 'aarch64'
   kvm_targets = ['aarch64-softmmu']
 elif cpu == 's390x'
   kvm_targets = ['s390x-softmmu']
-elif cpu in ['ppc', 'ppc64']
+elif cpu == 'ppc'
+  kvm_targets = ['ppc-softmmu']
+elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
-elif cpu in ['mips', 'mips64']
+elif cpu == 'mips'
+  kvm_targets = ['mips-softmmu', 'mipsel-softmmu']
+elif cpu == 'mips64'
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
-elif cpu in ['riscv32']
+elif cpu == 'riscv32'
   kvm_targets = ['riscv32-softmmu']
-elif cpu in ['riscv64']
+elif cpu == 'riscv64'
   kvm_targets = ['riscv64-softmmu']
-elif cpu in ['loongarch64']
+elif cpu == 'loongarch64'
   kvm_targets = ['loongarch64-softmmu']
 else
   kvm_targets = []
-- 
2.43.0


