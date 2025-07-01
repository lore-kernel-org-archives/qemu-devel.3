Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D15C8303D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcFd-0007DZ-Bn; Tue, 01 Jul 2025 10:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcEZ-0005BK-3y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:45:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcER-0007PY-IB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:45:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso57452325e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381109; x=1751985909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmQWEaJUD6g349jN49GBSvdCGbQvNn5YxEFdunGmRjs=;
 b=FX0ITPUePeezBiLLc+mNVROTGQQ4wHwtuK9DjmP9GPL2L+MIUswkfs/Vr5tjM+Fp9A
 TSD02POT8DUCatlJicLGBapGNTIzdpUEoWubNbIMrR4hzRHswwUc6ijeD7hksFMCNyfG
 OraN4QeFdMJ08Zko0DPPDUx8AFQYmdZsv013QWMoaLMbRTdkjnm8FUUXxvqaCHQJ37XK
 F0lqw0+9kqZKNslgD5WPe0inTYY4TVoh+Bi7ShcgMF/m+GeJxXhIUHLgoy3q8TCyPzuE
 GIJKY/E7Flogf2vaaAXTcBzUlQ2MEZLkvH0jPX7uxq0eQSiSZsS0zWuZZhf/5v/q4Xvu
 TMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381109; x=1751985909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmQWEaJUD6g349jN49GBSvdCGbQvNn5YxEFdunGmRjs=;
 b=gDtFPvJCVnCgU1H6ZSqnJBSrq0jEE5TFa/VfOpkqu4i8N78enygdlzvGZLQUUxf06d
 Jftq5wLcOMRyvwiOxs3Ij071KoWprntvF/tt6W+OYFGpylruicmXiu/RYFDGbVmseM0+
 uoW9wHlKMzV6FW5ceYsqjHqLoCz7DiRBYvB0/Rabj4iVSqkOXkJ8tq4WehZ7EK9bJufF
 u1tbEH5xG2WRH0RCzPfiePmO+d7WO+j0oY7KX0DNa7yI/gDoAZBtmbZUpWKjtFNPTPt8
 U8XWwm/iKxzQonlhjDaLQgVgO4OwTSuctPlh1w83GZIBJ4MQ1w4bUkjuXTzDXI5gVyA7
 2FOQ==
X-Gm-Message-State: AOJu0YzoJuopM2EQhI/9ciM0VxcxSkbGSKFYyhnRU9/YWKa5pWut7y8a
 ts1oXj47uZhwvuLB/bni3p31xBlxfBStTiZOOSYo+WfzlBxi+6TaHaHpT0/Wl1uUJl+2XVDYbuk
 +VsuV
X-Gm-Gg: ASbGncuhbxFpk+QYxc6A1PB2Z+ZR6BALCPH7p6zoSILNObLdUeGM6SnAXTBQzS0BpOB
 NAuX3ooAcVD/+cYRzp8asLF/Oc8ZbjDeRS+V52okKK1UBsm4kZW6grjOE5N7mGMghroA0OW8Sk1
 ws6tpgc/g40K4KdhKu8jOP7mqr92Vc9rq6SNOHZkul/cByuwuevNBwQ6d/vkktCCB/tO17/ZCa+
 qR2EZXfPg4KKktsL6rH1Ha2mgKe3Ie6ivafoOufZ6lHr9semj0G4e4nJBOl/++VUx6IAwH4Lt8m
 Sq3zjkPKqAt2P8ALnEIqIOedp4bx0IKB1pisD+DpJbRfNkC6bTxOMQ/kaw1RDYo7mOuhVC5GxBp
 UCTiyXk98JGQZKAgfd82txowYnl75luCcR6VY
X-Google-Smtp-Source: AGHT+IE0z83KkHA19IYpI+lmStABox+IEv+GpTh4hRM30gNWFz05G5ihGWtVoGvG9z+4ky43j1nq6w==
X-Received: by 2002:a05:600c:c4ac:b0:442:d9f2:c74e with SMTP id
 5b1f17b1804b1-4538ee5cd40mr161826115e9.23.1751381109044; 
 Tue, 01 Jul 2025 07:45:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f842sm13203409f8f.86.2025.07.01.07.45.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:45:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 54/68] accel: Factor accel_cpu_realize() out
Date: Tue,  1 Jul 2025 16:40:02 +0200
Message-ID: <20250701144017.43487-55-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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


