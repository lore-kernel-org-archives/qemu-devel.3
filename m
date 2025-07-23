Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3DCC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZzY-00077x-Ec; Wed, 23 Jul 2025 09:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZtB-0002qR-D0
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:52:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZt8-0002p2-JA
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:52:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so50960055e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753278724; x=1753883524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sErIHNuJGiieHnnNTlL18cbjNP1n0Jf/eJ1sooLpLjw=;
 b=xm7z/JsADWjEQDpEBhuQpOUmA2SbWJeEa/gBol++/EowxFirh9Au6w0v247ifhqU9B
 RCB9afHVG6IGrd5e99JkuS67KbfBU/JKPvqw0YvGBLMjnqHFhRAKCtKqy/bq7AsCYx0k
 Uyq9LEznP7gYXN8x/mOBZIfhPn2KNLKG2V4USGQTOP3xfnDo6bod+f7tlX0v7mda2r8m
 gLbtAO9d3ipbxz4VNd634uOQcDx9XlAeYoHouRJ8rx/xt7o8YOHRFTMRp5zKWbmRCBsX
 lEFrfYBI+iNhP3tFGIB4gHrMYFBhpwXUUDtUjXqL4k6powwEOPI2yymytj0BZOgW2ztj
 /a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278724; x=1753883524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sErIHNuJGiieHnnNTlL18cbjNP1n0Jf/eJ1sooLpLjw=;
 b=hOuu/ejV2CtTjF4TwQSCug7lQLFwlkMXKQSKjncwq0bE9KSafabtSYjbcFUsdxwBN7
 GpVcQFU+h1mVWaXO6WKZzaXwkNfpfAHJKYySuec2inOQxPnztXyt1ylpd52m8r9uMVhe
 Aj77lLmkbUX2PKjdTdV4eMn7QqXTP+oonzrmiAF+7k6jTV0YXzGgeadjmEoIY1HLiWAw
 9L7YIoPiyw5I2UJ1DdVZFlPEkwcfotmxC87wOK5+ItSOIyB59q8EteYmvKivXFOKGKyY
 T3D8gAER52p0WvLACLfiOqfnp3V7HHjqCY9MT1c5Zk1xPGxtKBKeS6iwMGohFziRJJb/
 0wIA==
X-Gm-Message-State: AOJu0YwGY+HcyvpAgequPfBTWgTscYnoXRcSgeCgi6rNXGi3PZlwbaxF
 sjnuGV7LhpZKrGTuTptOC5cMRzAHVazlDxwDp1W2c6RLIV14sLTf1WHTFss87N6bVQTlmLF+0ib
 UMYwB
X-Gm-Gg: ASbGncusQygdr6qPexaeOAejBgVfyibxvFvJJZQE0TP/8HIfaGQ7V2rRxvUj4MrU6rH
 3nwaQ768b1iH5AxeGbMdUa3Til0iNO+WJasbmf5yAo98wqnAYELhzMX0YiqQP9Ay9gvFmFs4Qjv
 SXpoF2Qe982uvgZoU3HuiunwwAQENDUN5fGaox+Be+zPOO22jcQvjAkhG5SIevivX0xuPv5De+U
 GIjDtZGXwVeY3pc4Dgh9c7OxEk7/dFXKu6XJiwTP3Kix39+CW6PNyEQnU3TBxiI/dE8cAgHHpbA
 HTv+E95yE9jmr1N5tt/avo6oLh3KXLccfwa0vqDeL4EowzhzjvczGqSBUHUP/wYNuh9oPYPRCXs
 W5Qa14vFAEYXdRmyKMD096klGJT5ERfzrop2301qS7+J7QIVdhK/Wyh79HKMEodU/ZMwxSiwM
X-Google-Smtp-Source: AGHT+IF2jLSlL/5bD5PGYKMnCSdo/K8e84jAX+hhADjVLT//YWG4YzDSSig2sL12YCHZyVOjxUOlSw==
X-Received: by 2002:a05:600c:4509:b0:456:133f:a02d with SMTP id
 5b1f17b1804b1-45868d2dd64mr27706105e9.17.1753278723806; 
 Wed, 23 Jul 2025 06:52:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca5c9edsm16632337f8f.88.2025.07.23.06.52.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Jul 2025 06:52:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 1/4] accel: Introduce
 AccelOpsClass::cpu_target_realize() hook
Date: Wed, 23 Jul 2025 15:51:53 +0200
Message-ID: <20250723135156.85426-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250723135156.85426-1-philmd@linaro.org>
References: <20250723135156.85426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Allow accelerators to set vCPU properties before its realization.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/accel-cpu-ops.h | 1 +
 accel/accel-common.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index 0674764914f..9c07a903ea0 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -34,6 +34,7 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 850c5ab4b8e..eecb2a292af 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -106,6 +106,11 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+    if (acc->ops
+        && acc->ops->cpu_target_realize
+        && !acc->ops->cpu_target_realize(cpu, errp)) {
+        return false;
+    }
 
     return true;
 }
-- 
2.49.0


