Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29921C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6sN-0006Eq-FX; Thu, 23 Jan 2025 18:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sM-0006DY-Ak
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sK-0003v6-6C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43635796b48so10273555e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675878; x=1738280678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSvw35u1c/GeD9pKIKqf6WHVcOBbPhJhoq/j5sOwl2I=;
 b=GoRdQTBO60uisqPbsnCeaTXiqcwQ5VAL/Y/vqmdVvUMB93sGL3FBXU2mkaz5g1+AQ1
 07JppaTzUfZ4YljrB3RzYn34yLc5dWPVkmC4m/3Zqn7sQLgBFZ6ImFig1CEyQD2xfRhc
 AtbObKo7A4Kwz6bYz12mqVpFu0QPgoJD8qVO2wOyWvh4nCv9hSCuOayoBRCBxeFGcvYS
 Kk0umoxokrBnUqX8SuA5ctRAP2hIQKg6aS1O8WNJU4jjWZUowTHrFi28aSFHIzxTBA+U
 J9L+WNS4RyBfcbPGhgkLXJ35nQiPhSNLqeSsWsj9Mh9BgmS3jzbQkOf9K/ZNNVt9yVZl
 8zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675878; x=1738280678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSvw35u1c/GeD9pKIKqf6WHVcOBbPhJhoq/j5sOwl2I=;
 b=Wnf3F4KwCllpemmNB73YfgX1LUj7xm2ODDZJK+UsFumsQhl/2FezcsVY2lidrKxgqm
 sbrP47a8rc/1RUVq06+JW/rmsgXRrUdsR+E3od7ONTnXh4wg7KpfIwX7eKCMkTlsYMFR
 uOKhRNXpYTFpK3Q/JZnoQVY6EqfRUQwul+LljjJe1tkMRqwcqnjYbO5iQtIHfxPyejW7
 2i1o94aWeOCvCbo/CW6tnao265qg4/CCJjnyKvzdRnS8pXivx2hu5Y+2msKFgNFkoews
 gQn68v2y788LxZ4S1kILyB/SxHDboumn/pni4QCUAnh2UNEsIDlOtfQ539OAHu9prcar
 p2bw==
X-Gm-Message-State: AOJu0Yy3m4so1rS20WQDNcbZoihzwiFkop4FGG8fiDXF5Z7QscVidtBY
 ebn+pu7e3I6GdlpxMJaBK6syKhOy5LSQXjb9zvE22S2C8PdXl5PAzfq9Dbh8UGW2UpeMjWcketv
 F54s=
X-Gm-Gg: ASbGncti4jL4rroGFnRfeapUfQHvnuyH6In7p17I0HFlw5Hij1MYOR42UQzcbsX+lO8
 1r7AF5lBtxqjJHqCghA402kuYNbuk57pKjRI9PF2TC1JazAWmZxPVRliGRaiYomEbIIrAOBxwCi
 4q/IjMDV/S382+aiaxCsA/tVxLvluTzF8uRdcuCoFP+ajlZ+SOGBQQYBxZC1wVgVeKC9Y3g+sID
 WFZlGmPlJpiLHbUiHKmkZDHyLbev29gSelgs5OsNCCpd2ZTn+XQRbE1WecHT5tNyBeFdnA9FpBW
 y0m6F+t9jWKQ7IrTXmHQObqTDHJ6eJGPw4tb9Qv7XeFVLR3od8zo5Mjw3fPyQ9bEGg==
X-Google-Smtp-Source: AGHT+IGo8PNbuw90Bq4/JTfJj+icg7kmRyyI+cmqGdvUrpM4r/a237PZVlDOFDC6zvKvXQiH9M0QlA==
X-Received: by 2002:a05:600c:3d05:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-438b87f953fmr44596875e9.0.1737675878313; 
 Thu, 23 Jan 2025 15:44:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4857c3sm7081075e9.10.2025.01.23.15.44.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:44:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/20] cpus: Cache CPUClass early in instance_init() handler
Date: Fri, 24 Jan 2025 00:43:58 +0100
Message-ID: <20250123234415.59850-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cache CPUClass as early as possible, when the instance
is initialized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 cpu-target.c         | 3 ---
 hw/core/cpu-common.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 667688332c9..89874496a41 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -134,9 +134,6 @@ const VMStateDescription vmstate_cpu_common = {
 
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
 {
-    /* cache the cpu class for the hotpath */
-    cpu->cc = CPU_GET_CLASS(cpu);
-
     if (!accel_cpu_common_realize(cpu, errp)) {
         return false;
     }
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cb79566cc51..ff605059c15 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -238,6 +238,9 @@ static void cpu_common_initfn(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
+    /* cache the cpu class for the hotpath */
+    cpu->cc = CPU_GET_CLASS(cpu);
+
     gdb_init_cpu(cpu);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
-- 
2.47.1


