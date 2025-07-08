Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4E7C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAR-00033p-AZ; Tue, 08 Jul 2025 16:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDai-0000UJ-3B
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:03:06 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDab-0003KU-Vh
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:02:54 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae223591067so790638166b.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752001368; x=1752606168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9MeYWno9//WEkluE3Tl/0Oq7GlgozTz3zFV14cG8Q8=;
 b=fOcKVDs9SnFgbWGw7hLHFBsq9weFLss095UC214ppxvvmhPhEn/iRnLCTVkv7k3g1r
 SD61Xn4OL/v6YD8MUyNCp/Y85d6sdaAzHYEyQu0vx6zjN9OmXKE4Wly/wQIat4QpvrsG
 k2T5CL8s5NKQd1jfbjrk4+aB2pJAtusXQnSAFDxMt4nlyO/T5fn1Przf7O3YojEHrV4Z
 BnobxuwXB1CwIhJztVn2bq5CltEo6Q1N48hgmjlD67VYk0ChyHdBVl3/hxGHC694dZsQ
 5CPD8ObUGc01vk5knRjisDZIR8VEyeQcJKwRwFqh40sR03rc0S9ggTwLmSwBCbyjmQJM
 9BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001368; x=1752606168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9MeYWno9//WEkluE3Tl/0Oq7GlgozTz3zFV14cG8Q8=;
 b=BzUiBpsCNiQYoV18m9Eir9SQPS7frq36NYKXoU//AFi19do+/ekCEUlTcbtDimVCqm
 vNVBqzQiYNB2V0b9sJRv25vrUxo4A/9TVufbq38uNuZCXvEpGZUyGpTTc/DYX37Q5HYE
 Yf8MWj/SFY9XW3XkpPrOAHAQ6qhGmf3L+TCZrciwv1Gy6qkZPh4/d3va+crtsgQsNx2U
 agI0B70Y3y4kbS28dueN0A0adtLkJjbnVQMBvv1RlqGi2R7fg+3b90TTU+/HJKUV/Cj2
 Yikpyu9ZjqbNIozVUApGi5cQiMqqdcYKw+vsV0cgCpazGkyA1jfAwbO/zACUw2EMzzgq
 r2sQ==
X-Gm-Message-State: AOJu0YwVwAzrY+xi888TCRTLZyXq0CJOL5VlaaY/orGZMGK8x/rpZmd1
 p5BmNqqMllUv7FYi6K01IH08B3ScGdnmKeul5Bl5knWWug2wcE5ncJe9YIb0czvrw5IMq2KZNkP
 52R9K
X-Gm-Gg: ASbGnctS9yQdZ23/6SUkk0fCSg5gA/fC0B2kMofyoAqqBVieYb3PJHs6i9iVBvbg6JG
 npE5GVcpN1ZpiZCrjQ8YxbbCp+wlc1uJbYdyR9dZdSW6E//LDbUI+pIMZsk2XH/NrBVYp9dKpKc
 lgrs0z8pUTmIiJk4/TwBv/kJs9ZHULR7u1au4l877U2En8CipNq5HgvRsuHYhNJulucq/V82SZY
 Pq0CwWpM/Ea+BgWeE6o+NULNozJG/xg9PfogOKdTtDY+IpWWN9nlqypocbhJgphhUigXMCI622n
 anf335wxKzvSaWbdUcpL+rLFvHpijBT/94HBnmiyT2volOYUQpVnI4//j5GFFJ2nPhZLtyXxj1l
 S7Rsg0zKKyRCwM0IBqdcR+hyigWhmL3ixSjq9
X-Google-Smtp-Source: AGHT+IHUfown0RCeaPbaYi6Ti0Qx48c6i6HY1oN1sTkXfdLePbkDffIiRX1FBTDGzWBceusNHNsWwA==
X-Received: by 2002:a05:6000:41d5:b0:3a4:e5bc:9892 with SMTP id
 ffacd0b85a97d-3b4964c3dc3mr13388695f8f.21.1751995343022; 
 Tue, 08 Jul 2025 10:22:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4722597f0sm13733424f8f.68.2025.07.08.10.21.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 10:22:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v7 4/8] qemu/target-info: Add target_endian_mode()
Date: Tue,  8 Jul 2025 19:19:44 +0200
Message-ID: <20250708171949.62500-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708171949.62500-1-philmd@linaro.org>
References: <20250708171949.62500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

target_endian_mode() returns the default endianness (QAPI type)
of a target.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info-impl.h | 2 ++
 include/qemu/target-info-qapi.h | 8 ++++++++
 target-info-stub.c              | 1 +
 target-info.c                   | 5 +++++
 4 files changed, 16 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index a8b34d150ab..17887f64e26 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -22,6 +22,8 @@ typedef struct TargetInfo {
     const char *cpu_type;
     /* QOM typename machines for this binary must implement */
     const char *machine_typename;
+    /* related to TARGET_BIG_ENDIAN definition */
+    EndianMode endianness;
 } TargetInfo;
 
 /**
diff --git a/include/qemu/target-info-qapi.h b/include/qemu/target-info-qapi.h
index dae92c47eb1..bdf207e6a3e 100644
--- a/include/qemu/target-info-qapi.h
+++ b/include/qemu/target-info-qapi.h
@@ -9,6 +9,7 @@
 #ifndef QEMU_TARGET_INFO_EXTRA_H
 #define QEMU_TARGET_INFO_EXTRA_H
 
+#include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
 
 /**
@@ -18,4 +19,11 @@
  */
 SysEmuTarget target_arch(void);
 
+/**
+ * target_endian_mode:
+ *
+ * Returns: QAPI EndianMode enum (i.e. ENDIAN_MODE_LITTLE).
+ */
+EndianMode target_endian_mode(void);
+
 #endif
diff --git a/target-info-stub.c b/target-info-stub.c
index 2e4407ff04b..ca0caa3686c 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -18,6 +18,7 @@ static const TargetInfo target_info_stub = {
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
+    .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
 };
 
 const TargetInfo *target_info(void)
diff --git a/target-info.c b/target-info.c
index 8e29553b4ef..a756c0714c4 100644
--- a/target-info.c
+++ b/target-info.c
@@ -42,3 +42,8 @@ const char *target_machine_typename(void)
 {
     return target_info()->machine_typename;
 }
+
+EndianMode target_endian_mode(void)
+{
+    return target_info()->endianness;
+}
-- 
2.49.0


