Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17975C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpY9-00044l-Oq; Mon, 07 Jul 2025 13:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpWI-0000fg-To
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:20:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpWB-000540-Bc
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:20:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so1886079f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908832; x=1752513632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6jE+E8cLL9PvtEqsQIMM5Q/m0eFlodpHTi07huBO/s=;
 b=W2yzfMoRJ11v8bg8P+Qg4ls0nJaIPhvLMev1/23gceETeNRghxq96r17Q3W23VtfLj
 sJwezp3J24ng3cGsv2alz0/ew6MyWx+2orJKf7B9+D7dfR7MWxW12islGds7sZ/Z7mnP
 5u08tAe05DvA5FmsByc2GEqcC21Kf1H8X7v1xvAxx5thhlPnchhvef6zxy32SqnleTXp
 yaHb9VK5Se/ibRlx93mo7pNgNKylJNwijlz5UEyVHNjBd2a1KbvVaM0F6/ogflqCSyfO
 wQpg9oK8e+d+QL7hS3x6OI96DwE3EBvHRVBcmw8QErnd/zKx0X6aZTdhcvsaAWwNBKM4
 ZUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908832; x=1752513632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6jE+E8cLL9PvtEqsQIMM5Q/m0eFlodpHTi07huBO/s=;
 b=Ri/fYoS7fLPhlBybaGUxCqUiclM/6vNyC40NPifl21/YpLovxywsyAK3AeJZVA6ZRL
 EIpB9A+ALibe7L90V295BB0/t3cs4KLelj+S+8CaBYYTol/c5MMCt/AESnOHnsvDeDl2
 HPNvoFF6sW1OkB6nNGImzyDYEhIashlLEi8jloQ44BGhcMAWsCa9jZ5euxqxHsCG6v/x
 d7xlUJbvuQnqU5kRa4ypHehcrmft7ZS4SPKoYz/qY5xlV4HV/mBJVckzwGLh85r2Cw8c
 /NHo+po5NeEStuhX2sUNd7gXEYCIN2esyt0sjksffgZLJpubuFZykfrRHDAdTJ010uCb
 qw0w==
X-Gm-Message-State: AOJu0YyAXcpgV4037ldh4GXbflT3r35eYC3TjUi6QCuyoPgSunl488jq
 bAHv3/t/NsX2ohIkmsuFMTMpCS1Xj3E5+yTdw7eRmBQAgiDMtssNh7VL0Ooy6/uEirmf8mDudvE
 1ShKPbYM=
X-Gm-Gg: ASbGncs0fl1jRyV6gmLAF+NBzLYGuTtFtHPBA+AVZKxAe+NTOMutpy3+f09dCrAHy3l
 F5Ro3rG9jtBgCLa/9hizKr5S54aN+KWs9UnIar+GDgNPbXCs7NuKVKG7loaSwHUeZoFJTsuP+pS
 axIrKy2lGp/DKCqSf9Jjhsa6Kcfo1K8CnC/OeH38JHnKlUP5kDaYywKo+iienipvO9HMj6BfmFs
 RF2+1g7/o1xETs11KjTvZORjrqSZBBRxQXmu8GobUzlgyH0hn+siTu1c8OJMtW6R2wwoJVSqJTY
 FTH6Hd5X6ReOtGuYXHrDPWdI4LNYhKeJas34RB+j4J+mU3UMbPOeykmQMI+g8mFUAZMTTogyij2
 eSUynuW6zAuIy0fyWTVjDPhbEhqRUA7rAEvpr
X-Google-Smtp-Source: AGHT+IEBAmgTQWwQQDm+6K4rVCpjdWQ5u057LU8G4ktHHXd0VbtGTyL3sl9T3U7ABAnB++ZEW7nESw==
X-Received: by 2002:a05:6000:20c2:b0:3a4:f722:a46b with SMTP id
 ffacd0b85a97d-3b5dd15bdfcmr143247f8f.15.1751908831556; 
 Mon, 07 Jul 2025 10:20:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225afd4sm10589634f8f.83.2025.07.07.10.20.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:20:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v6 04/14] qemu/target-info: Introduce
 target_base_arch()
Date: Mon,  7 Jul 2025 19:19:58 +0200
Message-ID: <20250707172009.3884-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707172009.3884-1-philmd@linaro.org>
References: <20250707172009.3884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

target_base_arch() returns the base architecture as in QEMU
target/$arch/ path. For example, X86_64 is implemented in the
target/i386/ so its QEMU base arch is 'i386'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info-impl.h |  2 ++
 include/qemu/target-info-qapi.h |  7 +++++++
 target-info-stub.c              |  1 +
 target-info.c                   | 10 ++++++++++
 4 files changed, 20 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index a8b34d150ab..c5aea6fa6d2 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -16,6 +16,8 @@ typedef struct TargetInfo {
     const char *target_name;
     /* related to TARGET_ARCH definition */
     SysEmuTarget target_arch;
+    /* related to TARGET_BASE_ARCH definition (target/${base_arch}/ path) */
+    SysEmuTarget target_base_arch;
     /* runtime equivalent of TARGET_LONG_BITS definition */
     unsigned long_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
diff --git a/include/qemu/target-info-qapi.h b/include/qemu/target-info-qapi.h
index dae92c47eb1..5d63fc4ab84 100644
--- a/include/qemu/target-info-qapi.h
+++ b/include/qemu/target-info-qapi.h
@@ -18,4 +18,11 @@
  */
 SysEmuTarget target_arch(void);
 
+/**
+ * target_base_arch:
+ *
+ * Returns: QAPI SysEmuTarget enum (i.e. SYS_EMU_TARGET_I386).
+ */
+SysEmuTarget target_base_arch(void);
+
 #endif
diff --git a/target-info-stub.c b/target-info-stub.c
index 2e4407ff04b..c0f438b45c4 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -15,6 +15,7 @@
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
     .target_arch = SYS_EMU_TARGET__MAX,
+    .target_base_arch = SYS_EMU_TARGET__MAX,
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
diff --git a/target-info.c b/target-info.c
index 8e29553b4ef..46780ec5450 100644
--- a/target-info.c
+++ b/target-info.c
@@ -33,6 +33,16 @@ SysEmuTarget target_arch(void)
     return arch;
 }
 
+SysEmuTarget target_base_arch(void)
+{
+    SysEmuTarget base_arch = target_info()->target_base_arch;
+
+    if (base_arch == SYS_EMU_TARGET__MAX) {
+        base_arch = target_arch();
+    }
+    return base_arch;
+}
+
 const char *target_cpu_type(void)
 {
     return target_info()->cpu_type;
-- 
2.49.0


