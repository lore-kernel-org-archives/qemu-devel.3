Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D5AC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiX-0004AS-CP; Thu, 03 Jul 2025 07:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHga-0008E2-Jz
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgY-0003ys-6q
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so42290935e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540453; x=1752145253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYagbleC/hcq8JgGV1mXFBe9rSbch4M6pqZHxCjKKEU=;
 b=vDCf3Gpo+kXhMfr/F32mFMZvbFdeUaQQiNUCdAVM3d5/weDyIlKHjUUJW87xzZHybI
 xZDLPmHvSdawdqby9uziWox7BD4AcQ4jWPLNv3saLbUTVuogEapqi/w0DsavNm2lPdDq
 p9a9L3gJrivVUq0WpGoNqteYmj4GKGGqE8Gjk2d43v+jjnrkg/dC1JEoJvdjBTlJ7ML7
 S9etQpb7c8LXduNWERcrbjDXgyzXzwKu2dDJB3XHISkU3IOzCS/xLWQ6KyfvP0Cv8ZjU
 X2kz9SB5PQwbneoL8f2sCp+YYBk7AHUyZqRLvBBWz5mEfsrmWeRmyxvsuf1N+dEnm7cc
 jz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540453; x=1752145253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYagbleC/hcq8JgGV1mXFBe9rSbch4M6pqZHxCjKKEU=;
 b=PxMFuXG61H5XykGdBxkSOjwGsBE7onm78wJxNMdPx/HAr/1GQGjt6X96LxkcJ0wV+n
 LVqUBgpTHWqSudfKszU9CCeFuMM3lb+vXFCCRajOHiplXgE6ZeO6Lj8Fh4oVZtJbyX1h
 8duW8TX9xzLsltDirxmCWZ3n0wAB077b6ww7oXCbLXr3WKhsk3HnbPIdBqpcHgDio72w
 Y5rJ4HVW8aaAb3NEXlJ/fXFEaZZwDw0SD2iHsWUQg6QwlMJyvatb54CGegi9Od5u4glZ
 /Nu8Tpc5crS2JP347RUpxFPwuaYAzdaKka+RsD+W0Jr1DnSd//qXhCt/pYNy0sihobzy
 Uh+A==
X-Gm-Message-State: AOJu0YzDlgMtcyQNXjhCLbVza15jhVy+kLT/XN+BwdLd3mvX7ae45rWr
 znbpLIyjwUxFDbygNhbH+JQ9xO90PwWSL2OB8DXZSIhXo73Y2SYrt2ZvM6ec4plEuWcZecn3iLp
 SEcBU+V4=
X-Gm-Gg: ASbGncsVc0ZjVFP8SIRBdTbJ7xVJ3OYbyUD8B7ASHpsbk9/l8iwIOhqtgBG6OKZrHKE
 OLT+BsbgPGxSNFRCiJ1EA8F1urW0CHjl2l2/n/RsGb0PtoaKJ562lqEtf6kdbL+X86xktNOUKGM
 FpGoXWFAZVLJUPZiMqZ51M3TjYG4sPDxhR+y/5DDkCNqKCaWxZZNOc2O4zvoToNVnYEjEZgqYLN
 vMKm7zROSAU4xQIMzy5M1jQ8nKpT+maMzHm5Rox79j+9zDm+LrJFNNjKnu5mOBXwdv/vPem2DNu
 XU68Kkp7fOjgBb8yMsbeSCcD5ISoKvJ5YsEiDkPfjfef3+UXmEQF6+Wg7LodySk11d5674mQe/0
 tzEruD4gVkb2W09OKpYU42w==
X-Google-Smtp-Source: AGHT+IEUZBSTMiRrfLofYu4N1i7N32LdP3UEB9PeAX2Sv3szBKCnYkogmOlR7j4MaUfvKnOWbwm7rw==
X-Received: by 2002:a05:600c:4ecf:b0:450:d3b9:4b96 with SMTP id
 5b1f17b1804b1-454ac2da3bfmr24724685e9.13.1751540453164; 
 Thu, 03 Jul 2025 04:00:53 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e62144sm18639506f8f.92.2025.07.03.04.00.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 59/69] accel: Factor accel_cpu_realize() out
Date: Thu,  3 Jul 2025 12:55:25 +0200
Message-ID: <20250703105540.67664-60-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Factor accel_cpu_realize() out of accel_cpu_common_realize()
for re-use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/accel-internal.h | 2 ++
 accel/accel-common.c   | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/accel/accel-internal.h b/accel/accel-internal.h
index d3a4422cbf7..b541377c349 100644
--- a/accel/accel-internal.h
+++ b/accel/accel-internal.h
@@ -14,4 +14,6 @@
 
 void accel_init_ops_interfaces(AccelClass *ac);
 
+bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp);
+
 #endif /* ACCEL_SYSTEM_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 24038acf4aa..de010adb484 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -122,9 +122,8 @@ void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
     }
 }
 
-bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp)
 {
-    AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     /* target specific realization */
@@ -147,6 +146,11 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
+bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+{
+    return accel_cpu_realize(current_accel(), cpu, errp);
+}
+
 void accel_cpu_common_unrealize(CPUState *cpu)
 {
     AccelState *accel = current_accel();
-- 
2.49.0


