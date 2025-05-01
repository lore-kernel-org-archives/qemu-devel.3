Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DFEC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbOz-0005US-G0; Thu, 01 May 2025 17:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOm-0004Qt-Rb
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:53 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOk-0002Ak-Di
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:52 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b0b2ce7cc81so1298234a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134688; x=1746739488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBxJ7AZiyX/+Jv6DfasHwGdvua+9mEIKfUGwWBF4FSg=;
 b=YAq8skbyzmt1XJhsFK6RBFF8JEkatwRw0rP4aryVsxkOwS1bnCM1QpZsHXxs2lkgJg
 YnjCiZE3WM0RYyy+wozSnOqIafyb87qTynzdeNcT9SR5W3CjA7ExtXvcq2sXnVs8HJEZ
 WdIFFMAJyM5Tddlcv/f+Dz9T5nKrCYhc1MAj5OMInGOzeUxAvdFndlSvW1etMG8UKF4Z
 hRnb3F/Af/kzIKkN2Rdl+vGQP0Q2o6/vOCU1ECb/LY3d9Y7+CeiqlVT++5fPVosrMEQE
 YoPVRnoEITG0LzIIceagJC0Smbk7AVzlx38dKmz01i8jKSMk7v7Yc2Z7RGp/LevCvAoA
 ETqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134688; x=1746739488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBxJ7AZiyX/+Jv6DfasHwGdvua+9mEIKfUGwWBF4FSg=;
 b=VfB7s0jxnja9qBjFmOoC8FNXywMQu+yQBIUCf2E8rxwqJ0zXMqb8hrKxTA5D1mgZcu
 LofXovSEoUK/KS9pQQb9lRNu81o+pB+AxaXEbBJvyE1JAn1AKMSpapmxCS3nGqbedHNf
 nCZ2y9PDZRwzdfq8mFaegTINNpueyR2rxTX/XBJEkS9obOWwDn5N8eDPU7qU5nz0AmhC
 /AcBx5CnIqqs61aWUfcenqKPv9UDZ8EJ0avaUqnMgruvKaqKEW/IvPfgxk6P0g2SLEFv
 NkLiHiV7Cjohj9h4dEeITFFPJXiTwVhKd4QqlBYCfE5sdbHZ5mXFXS6+4GCyqD15gjJG
 0Hgw==
X-Gm-Message-State: AOJu0YxGtU8ZXWBDN1n1eniuJwzcMVOiVRRHgjrp2LCuveVmx4uQRSTX
 /gMBhbAGaLWZxPjflC2fjxBojhz7IDb+2iBZvACJW6ihNJiAXg5+N7mBsBC3o0HbX/QzECVSmgU
 D
X-Gm-Gg: ASbGncvsW4k4Sn49BBTgnt1Xm/3OujpWx49Ygzr6oW9iKhfjOxIJWfBEOA2nBru1LQF
 6AEA5sJDPoVgS89D37Khwj9QX9vV4rhF74n6YENQ7LRNjkCfx2TliL6wQkrwU/08zt1IBAPmbqo
 uPFqTrssCM8tMAcKmiV41u8HcoHyCq+GbLHJzlgDpW6FQYo40QfF21mirENIUlVKL88rGL2UZtm
 DvyoIiZH6HZ/ZyEweC4WyhS8qyjGV93waUzR2UGtRtAc1weKQYCRvMox9uVDzY/ab45VDbpzzuE
 QBrB2ib+pkgUwAfs4PTZECdvuDCkFi05sZE8oZvA08l3RzXaP9swUdyFGv/Dlu03Q/p7u2/Kzkw
 =
X-Google-Smtp-Source: AGHT+IE8u2vxt+cFpmmSY7otVyuCvkoyl5ZqnajQV/a77E8NO6K62r/LmKxaGJ6qfHpi6EC00xqu1g==
X-Received: by 2002:a05:6a21:9985:b0:1fa:9819:c0a5 with SMTP id
 adf61e73a8af0-20cde952d8fmr641997637.11.1746134688198; 
 Thu, 01 May 2025 14:24:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/59] qemu/target_info: Add %target_cpu_type field to
 TargetInfo
Date: Thu,  1 May 2025 14:20:55 -0700
Message-ID: <20250501212113.2961531-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info-impl.h | 2 ++
 target-info-stub.c              | 6 +-----
 target-info.c                   | 5 +++++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index d0e8c86176..76766eeaae 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -14,6 +14,8 @@
 typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
+    /* runtime equivalent of CPU_RESOLVING_TYPE definition */
+    const char *cpu_type;
     /* QOM typename machines for this binary must implement */
     const char *machine_typename;
 } TargetInfo;
diff --git a/target-info-stub.c b/target-info-stub.c
index bcf834f71d..86da297277 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -14,6 +14,7 @@
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
 };
 
@@ -21,8 +22,3 @@ const TargetInfo *target_info(void)
 {
     return &target_info_stub;
 }
-
-const char *target_cpu_type(void)
-{
-    return CPU_RESOLVING_TYPE;
-}
diff --git a/target-info.c b/target-info.c
index 0042769e3a..5f5ef1f932 100644
--- a/target-info.c
+++ b/target-info.c
@@ -15,6 +15,11 @@ const char *target_name(void)
     return target_info()->target_name;
 }
 
+const char *target_cpu_type(void)
+{
+    return target_info()->cpu_type;
+}
+
 const char *target_machine_typename(void)
 {
     return target_info()->machine_typename;
-- 
2.43.0


