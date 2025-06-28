Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B70C7EE2A
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 00:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVJN8-0006LY-Dn; Fri, 27 Jun 2025 20:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVJN6-0006Ky-I0
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 20:24:44 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uVJN4-0000qr-Tj
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 20:24:44 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-749248d06faso3077462b3a.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751070281; x=1751675081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjQ6iEKLubvqsBp+y2ymquojsyDr9w7rW+VsEASd2l8=;
 b=IxzFyYMHiw8IyrLT8tDTALgmsC97htijSG5KNyGQH/qJ/WiTvqMefYMTJ8NwMDtKXP
 oNbs5kWeiMtmEqg4Lbz4+Gyt8dzWZPwfCYrgwU5bVFp0/TN0aiZ29Wz+4wshSADXdbge
 sivSA2T7164se25gZX6PIoNPKUu/aCFp+Mef206OqfO1ZAvJMZ+pN+ltKVUMlfhLHkOL
 fHSf4s8QklbzW7mV9Y0Jc5DIOexuWj1ckUXUv49hRol9bkXoH5bjcLcakOJmNOt0tllb
 /KGODl+ELFoUqNeYYTR6zIP31K65HZfV6x4C+NoAjvKOxoG61xcjpsCDUX0DhLEFmmjS
 4KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751070281; x=1751675081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjQ6iEKLubvqsBp+y2ymquojsyDr9w7rW+VsEASd2l8=;
 b=jeT67QaoUPTPSrpWnAAu5HhyV3+LZt1KHawNyfhPJf4CM73GdrQbNdajvX9O27F/Dr
 SY713uEGuwpfSfbAKiKFL6xEW8Y6nk+9UKtxmE+LbtmvyH8TTE7ijWRbHbXCSIBAfNsQ
 4E2a4i4qlwq8pFBOFhLeNV9VBLEeTNRcJr4p0JjV7Jp9B+vvcTBWFbqoA9UcS/aLshiw
 lWzoZ66xeQ75+ksghrlwKxvs0xz5cPpd/EBxkgrot4B0SSFUCs/yBj94l+/s/rIB+kq2
 Jie6zSy2+aqml4HnpMk5Di2+/fdccCqITYEIJX4w/JI77NOuQNOmZTmJYe+/Z21QNAKR
 l06A==
X-Gm-Message-State: AOJu0YzjuFT//NyRZRqShzIpI64N3shAfUoEa5LlueOgU4DxKQ11vZbn
 RgpQbhkOT7VnL8CRCS9/+fZ38tmDViZfqVHdLgsMn731oufpAL+mVN1QxVSOI5FO5FDIGlukvHw
 FUAho
X-Gm-Gg: ASbGnctah8duPx3rQV/2GbJedapqGmFxf+K6ZzMF0f3idYjgspjnkZjHfVv/CeEOxXq
 4+GQ7lxuMgHn9v4pC/Iu+rHIYCw2r+YkOeS7RHjsVTCfr5mAwzchw5YKhbR/sDKFXvy73wT3oOf
 Co6AkdvMLL0QOWbDniUf2EI7WqqU4bu1HFKFmVEJ4o3A0jdpP55dT5hEU0hZnrttXEFVDPUv6su
 iLcJCXrUnTS35zuN8OKtNN3odNovbJxH6L7CdoVaH81h4oLnegUnk8OsvqFBzt2GeQlxTNjEaCq
 VZF5X89o9Jf4QIHrrjlqIhBeOq492Bnx4cHCuDgWNbbVrg3bqp2vUf2+upX2TQ==
X-Google-Smtp-Source: AGHT+IFUUHd6022wWNNFjuqd1W3vn0xZnmFgjKM6M6YpNzHecFpTFcodN4X7092PSlQdfjoWb4CRoQ==
X-Received: by 2002:a05:6a00:8c9:b0:748:ff39:a0ed with SMTP id
 d2e1a72fcca58-74af6f70b6cmr7446542b3a.20.1751070281503; 
 Fri, 27 Jun 2025 17:24:41 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af5579d37sm3025751b3a.81.2025.06.27.17.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 17:24:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org,
 philmd@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/2] system/rtc: introduce -rtc speed-factor option
Date: Fri, 27 Jun 2025 17:24:31 -0700
Message-ID: <20250628002431.41823-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
References: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

This option sets a factor on time spent for QEMU clocks since the
beginning of execution. It can be used to slow or accelerate time for a
guest, without impacting QEMU speed.
It can only be used with tcg.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/rtc.c    | 11 +++++++++++
 system/vl.c     |  9 +++++++++
 qemu-options.hx |  7 ++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/system/rtc.c b/system/rtc.c
index 56951288c40..ec063391b5c 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -188,4 +188,15 @@ void configure_rtc(QemuOpts *opts)
             exit(1);
         }
     }
+    value = qemu_opt_get(opts, "speed-factor");
+    if (value) {
+        if (qemu_strtod_finite(value, NULL, &clock_time_dilation)) {
+            error_report("invalid speed-factor factor '%s'", value);
+            exit(1);
+        }
+        if (clock_time_dilation <= 0.0f) {
+            error_report("speed-factor factor must be strictly positive");
+            exit(1);
+        }
+    }
 }
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c66..e1ea79c683c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -243,6 +243,9 @@ static QemuOptsList qemu_rtc_opts = {
         },{
             .name = "driftfix",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "speed-factor",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
@@ -2491,6 +2494,12 @@ static void configure_accelerators(const char *progname)
         error_report("-icount is not allowed with hardware virtualization");
         exit(1);
     }
+
+    if (clock_time_dilation != 1.0f && !tcg_enabled()) {
+        error_report("-rtc speed-factor is not allowed with "
+                     "hardware virtualization");
+        exit(1);
+    }
 }
 
 static void qemu_validate_options(const QDict *machine_opts)
diff --git a/qemu-options.hx b/qemu-options.hx
index 6bcbb8ccea0..9efdbfb3842 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4887,7 +4887,7 @@ SRST
 ERST
 
 DEF("rtc", HAS_ARG, QEMU_OPTION_rtc, \
-    "-rtc [base=utc|localtime|<datetime>][,clock=host|rt|vm][,driftfix=none|slew]\n" \
+    "-rtc [base=utc|localtime|<datetime>][,clock=host|rt|vm][,driftfix=none|slew][,speed-factor=value]\n" \
     "                set the RTC base and clock, enable drift fix for clock ticks (x86 only)\n",
     QEMU_ARCH_ALL)
 
@@ -4916,6 +4916,11 @@ SRST
     problems, specifically with Windows' ACPI HAL. This option will try
     to figure out how many timer interrupts were not processed by the
     Windows guest and will re-inject them.
+
+    It's possible to slow or accelerate time using ``speed-factor``,
+    which is a factor (real number) applied to QEMU clock. A value of 0.1 will
+    slow time by a factor of 10, and a value of 10 will accelerate it with the
+    same factor.
 ERST
 
 DEF("icount", HAS_ARG, QEMU_OPTION_icount, \
-- 
2.47.2


