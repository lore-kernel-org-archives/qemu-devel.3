Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9853C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 17:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsrC-0007t7-8Y; Tue, 12 Aug 2025 13:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsrA-0007qM-8Q
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:32:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsr4-0003yd-UI
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:32:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so29369375e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755019927; x=1755624727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZK7A8+ExRknFiNdfDV5vU5WaW75p8NKzT4HVtbH740o=;
 b=m81caWUidj1GNk0uyHz7pt6LwPoZzRzKiuxocD4tlstbTEGZbwhDmmVd2mRwrCT9oy
 VOePg1yFGu/7cBG6jfS6bkPjx4qQR0dkW1Qd+pi2IN4PtgJYZVhNvD0egmw6eKrQf4fL
 cyUSLcSPur7AZzpyfsARBek26DioEf5QCip2lv+szGWSLwgkDP2zr94GbPK41red0PeD
 bGlOagoLYwuxzOZv1T86pbKbN+jCpXc5iH4S5IXPhSmAdwdcLZng+cXI8YVQPLV0BtV6
 eTy0msn2xhzjIB/KTsHdyQP4KxSPEq6jw0RN9DMqZMDLmNNwL6zCFNhwuFvBf1PXvcQU
 q0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755019927; x=1755624727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZK7A8+ExRknFiNdfDV5vU5WaW75p8NKzT4HVtbH740o=;
 b=Zb8nvPMtTpRYlU/NhVXUr99Pys+0OVjWibaRR7uz+IsXeSOfKNEbv7tJlN0ZOxNzEz
 ajai2FzNqUCM1sENzVdBiUcU5DDdgVihhP7+UBGP5pvO/5q/RCKh8wNEvVdb8optvQjp
 6F5pmOQ7QnlwbsB2gfTt2f4+OuFvQjC+ya8IB7lca94fPyPJaveoJ0Zai0B68rXIUmY2
 Dq2Wu4Jof2TBECR6+aQpsjCd4yQuZqu/Zk6k26D1eI4yvfmByDfnM+crQZEt9hOIsy/u
 tCYBhMH9GYjLzpe+3scOh57NNWKsEPo95h9QSqSG3nv/pO1aRbuMpa4TqY3U60xBnL3Q
 sz1w==
X-Gm-Message-State: AOJu0YygV38Bl3XKQriOYwawwB596e/2LuEFKJGwb7fPaEeDFKtFnuBD
 uPuSXfSjjhREFCqwn8uc2Xy07YtB4ke+RutaBC5w3ImQuEbA+q2+NHFzGLQKkK3FzRyx2aOa3H0
 avS39
X-Gm-Gg: ASbGncuLoakysuBFFhyN+yQkRNuDmtHIjlohPLcZtL50p04uNldoNQp7nY6r7eHbyUv
 E8ei8U2zP9osFCMHdhnCtcXWPBwOAMRK52V7HQCIeZ0BXMnvyUI6CEIroY4x6wb1pVX3mAvsPGQ
 hSlfpIkhXITBQsSxf2jGbsnSpHFaG02glMKguO3xA+kJ07gGl5+7yp9oCbSjfqCGpzNKz5d2s46
 XQmgQ6zuhJkci6rREJvRNq5DiUoTX7W9AfQCV8PsZ7u3M1gKl3hBpRsiEVBgagW6kSa/YLbhUcf
 xl5f5jA43+4V85eoT2zVuRVhSZFhm0J2hqJgWq46u8/MaDdEtL9lP9iQklLgvJyYYNcppnXc6PW
 pGPhBBlTHzQBMOWwAVIDPMCwxbY3vy2/KDr/zfxIyJht7pVYzU5uxMapk6QF92OoW/eEPu/vn
X-Google-Smtp-Source: AGHT+IF6L2amb9mC/f4dr0vYRS2UduHFNagtWxEQ9gdtXxP7Du3ELgIJJeJBf5DVEOhT8BtEy07eLQ==
X-Received: by 2002:a05:600c:3b1f:b0:459:d709:e5b0 with SMTP id
 5b1f17b1804b1-45a165a7227mr299915e9.5.1755019926647; 
 Tue, 12 Aug 2025 10:32:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459eec47306sm241996015e9.28.2025.08.12.10.32.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 10:32:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [RFC PATCH v2 09/10] target/arm/hvf: Consider EL2 acceleration for
 Silicon M3+ chipsets
Date: Tue, 12 Aug 2025 19:31:57 +0200
Message-ID: <20250812173157.86934-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812173157.86934-1-philmd@linaro.org>
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173157.86934-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Just a proof-of-concept...
---
 target/arm/hvf/hvf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9d702b82521..84c0c0275d6 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -571,6 +571,9 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
 
 bool host_cpu_feature_supported(enum arm_features feature)
 {
+    hv_return_t ret;
+    bool supported;
+
     if (!hvf_enabled()) {
         return false;
     }
@@ -582,6 +585,9 @@ bool host_cpu_feature_supported(enum arm_features feature)
     case ARM_FEATURE_GENERIC_TIMER:
         return true;
     case ARM_FEATURE_EL2:
+        ret = hv_vm_config_get_el2_supported(&supported);
+        assert_hvf_ok(ret);
+        return supported;
     case ARM_FEATURE_EL3:
         return false;
     default:
-- 
2.49.0


