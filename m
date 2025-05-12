Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45E0C3ABDC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXYz-0005za-2E; Mon, 12 May 2025 14:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX5-0002bv-SG
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX2-00009i-Gk
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:43 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-af91fc1fa90so4001402a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073138; x=1747677938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AGfH/it6XrbUjxeSHUy0wlg4nMt2R7aYVYgAEJcCXI=;
 b=f+QMV1nsjyyRkTDfn65ao4In3RzHzJGgVKE0yJ/QcAI0CGc7COdiFMTystVCpH35mu
 rO4PWaOjL4qJZGmGNBC0Vw+ufqkqdF1Q4cjWRurpsJyFIjKh6BJF7kBFx/OSfS+HCCYl
 6WNXq2m/c31Xm6Gg3wPM1z3N1ch6A/L9ykKN9cyvpzkTAPRqafsCIcfSiQFttStEHsiS
 2A/uCYX9BoZh8uAbzB4vu6cFCq97wo1PaSITCV7eDh/ylNMeTTFgh3Lcu21gG6XqqWlC
 kgtJ14ofuaM6y0UEvebuHDnMeWzPDZeJDAAh53DZw0/3Ofc1DUEoYvgulSJ6ePMc6rt9
 I2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073138; x=1747677938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AGfH/it6XrbUjxeSHUy0wlg4nMt2R7aYVYgAEJcCXI=;
 b=C3SdTTAAchdaERbopoW8GSdTZkGwjNQS5QGVK+95gr+q+GmS5ltb8LovtiWnIPKZdG
 iDiFi0x3k70MMNezXwAxFdHpmWyTSNBoNELKg1S3kxbZ8Hj48x0aRepv/rcLnGa5h3t3
 utLCgS25px4+S7wKDhDgDlXOYoe6U1kA18yxzo2kbIejp8dz0kDBYM+pI8uRimD9U8dY
 lBbocXGPRyba4tOuBQO+/+R1k1FlAqcTCzaFLmlmLIrTqdP7CpaGw2AdrRGi0GilbFwy
 2JMTm/f7fkuKCeiJC4nsgEROHNkrzAPuklgtNv4vAfM4xucMXaXum6CjmGMj5lKRfaCp
 XNEg==
X-Gm-Message-State: AOJu0YxhmlJMuwlTA4nJdtRFb/ThPegdzTBZ5YLn+oY1Iwb6NsP17CyO
 KuDmEhGa26a4jJ0jRBDHUPY7v7KsFqHP5ijfm5Mv/fkqu0HqB2edTG+DtIo6S6ipoccE3rL7XRA
 u
X-Gm-Gg: ASbGncv5MNWRwa8GET220s1LG8JGrtlzsdYrwm29JkUT0zauYzs3Udy48oBp/VW6Lgf
 dDeZSfco16iqMqHvKzBSQ9GQ5wKg7U5HugoGKWExQwPhjhtkIzHNYOavQRoUnbmAjFD/zoGEfzd
 yDyiNt9VkR89W9M5OJNTZiDsMGY41K0cSP/ZH7a3CRCDNS9Qbv3dCOhiBOjzIOYl1NPGPTy3mnj
 O7EItpWXA17UT/h5M4zA73XoNtISVGY+eNtchayeAsEMxcvWRv81Kb8GfQca4WRWum2nA+AaFg0
 j58vFyAyboEUzgwjYClipwQKdS5jbgkdgwneMdNtdqnSt9PmA3c=
X-Google-Smtp-Source: AGHT+IFqLZqdqiB4vnCiLX+YhBjMM+mS8XRugjCd2bR2uEmufjtP7iuEmrJPLIQL55DxmxoR6NT1qQ==
X-Received: by 2002:a17:903:2344:b0:216:644f:bc0e with SMTP id
 d9443c01a7336-22fc8b58ed5mr234792585ad.24.1747073137679; 
 Mon, 12 May 2025 11:05:37 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 29/48] target/arm/ptw: replace target_ulong with int64_t
Date: Mon, 12 May 2025 11:04:43 -0700
Message-ID: <20250512180502.2395029-30-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

sextract64 returns a signed value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 89979c07e5a..68ec3f5e755 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     uint64_t ttbr;
     hwaddr descaddr, indexmask, indexmask_grainsize;
     uint32_t tableattrs;
-    target_ulong page_size;
+    uint64_t page_size;
     uint64_t attrs;
     int32_t stride;
     int addrsize, inputsize, outputsize;
@@ -1733,7 +1733,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * validation to do here.
      */
     if (inputsize < addrsize) {
-        target_ulong top_bits = sextract64(address, inputsize,
+        uint64_t top_bits = sextract64(address, inputsize,
                                            addrsize - inputsize);
         if (-top_bits != param.select) {
             /* The gap between the two regions is a Translation fault */
-- 
2.47.2


