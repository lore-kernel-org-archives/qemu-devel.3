Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B00D11196
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM4I-0006vu-JD; Wed, 26 Nov 2025 15:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM4D-0006L6-KF
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM49-0002ia-BO
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:43 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so502025e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188678; x=1764793478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yJMqELVhfkz7BjcKLlw9hrXWFRteZQ0RZVkFPdtBPU=;
 b=F8QGv8wokgullE0HuTKyGWgK+7p8Tru/xqO2s0jFUdwFl+eNXtGHtlcMaZQmEKoEGJ
 ZqOJxnBmevUeJx+6tstUgmWjbu0q1f5wj22T5tqbUFt+ojxu6W37PGeooylnhThje/Dg
 7MuWVA1Xxng1ucnltI2UEr/F7tHNPiqJQvym1MxYXBPBMkha6RyA4c7RKyIhCSAhJY0S
 gPtdkijEG3A6j3cFdKpLgci+cwgJPhQbYb71Z7SFQuxcEa7iDDrOmlTqJBkxwbwWU4on
 bVLBfKFjpG0hCFZW79irTcs4dJTZ4l7s+mrMiRvlf4j5fYvMw9NYRuBjq0PNvjI4sQ7R
 YWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188678; x=1764793478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6yJMqELVhfkz7BjcKLlw9hrXWFRteZQ0RZVkFPdtBPU=;
 b=F1xSITtWdwrFPh82gM3wmeeGmCGE0I95T7YeYW4xvw1Xlr6JJrgWEVK44+fa213gXi
 axA1mmzcpuGiWnbEYF1lON/GHa4gaRoO7i7L9NJ7gPKrsJwY4HUNjLfA/DVS8ujOPzFr
 2qQEFSyzekIoEoZsNFihL+nY2ZutPG42hZ2CdhMytcqnjnIGyRGaavFfx7xgcby83m1b
 kXFtBkdE4KAwLT/qNuIwMW+tZuHzmGuk9WnT10pvjWAqvlUTE7wznp+ZgTzW2FUiNG69
 67nMpygB1i9VJ3gFPVAE+H34vfKA9Z82U9DNJ1q8/uzA0VqG1zj6V1Pq6XHSzF55cfUe
 tMhg==
X-Gm-Message-State: AOJu0YxSF2ymE8ki1xxLE65ELTOHTimHF8y9tF14BJA6MHHzY4yEQkgT
 JlSu9zMNpwFQq2wTNhTshCEi4UM6FdCUKddIUtMAS7iEZIZ68scNCuw+K5n9L/mnIXAyuZard8s
 q7VKqQuvqshbx
X-Gm-Gg: ASbGncugC6HJ1l3w5Wd9CJfbprGdV7bi7wzX7rDKFgd7c1Esf4wcJL0jlkoJMblsi4H
 tk+ncUOsClWMim+dH4LafRJyZCyRks6/AL2SWUMdApCnLAlZrfyMDCWxpXoXpnS2Wh+oVy6m07o
 alJMC0dxSYNMn3ktT2nSEI+I4hScU8TjlUGYuhLh8tEw7ZAs3mfZAbjHlyCZql1FVGSSPCh1qho
 yBsYgmT6WL102gmxgEfUD71eWGV+gol3JqzgCaxyeHZgmQ+SIC5JZG7hsY6Dyar5sIppSs/Sqso
 zl2BLniUMrYkyHkqtXLPd4/l8IFhNmLfXNDIBRJGHwi/yOzDGfRg0+GEnlNeIoTF3AxtH7mkPzM
 E3qfwz/Khl0f5ia0MiLX51zncmD1JLqqvAqcbjCMBjzssdUV10Lg6++U3MTrIVqLnboJT5BjDnP
 so7otw1AssEKzjWknGjYD5krsnqSuuDeHmXZ1Er4A1o3kWTIaqN2gZJRGAELTR
X-Google-Smtp-Source: AGHT+IEGVKafmRbeFXl1MqQBYmZ4+6jT1I5LjGzptRpCnwmOUAlCUx7J7kmTT4QS5Ry9D5Il0YgB4g==
X-Received: by 2002:a05:600c:354a:b0:477:97ca:b727 with SMTP id
 5b1f17b1804b1-477c01b21bcmr183773695e9.19.1764188678062; 
 Wed, 26 Nov 2025 12:24:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47903e65d51sm51883435e9.0.2025.11.26.12.24.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:24:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.0 v3 22/22] accel/tcg: Remove non-explicit endian
 cpu_ld/st*_data*() helpers
Date: Wed, 26 Nov 2025 21:21:58 +0100
Message-ID: <20251126202200.23100-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
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

All uses were converted to the explicit cpu_ld/st*_{be,le}_data*()
helpers, no need for the non-explicit versions anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 46 ------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..12dd38599a6 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -428,52 +428,6 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
-#if TARGET_BIG_ENDIAN
-# define cpu_lduw_data        cpu_lduw_be_data
-# define cpu_ldsw_data        cpu_ldsw_be_data
-# define cpu_ldl_data         cpu_ldl_be_data
-# define cpu_ldq_data         cpu_ldq_be_data
-# define cpu_lduw_data_ra     cpu_lduw_be_data_ra
-# define cpu_ldsw_data_ra     cpu_ldsw_be_data_ra
-# define cpu_ldl_data_ra      cpu_ldl_be_data_ra
-# define cpu_ldq_data_ra      cpu_ldq_be_data_ra
-# define cpu_lduw_mmuidx_ra   cpu_lduw_be_mmuidx_ra
-# define cpu_ldsw_mmuidx_ra   cpu_ldsw_be_mmuidx_ra
-# define cpu_ldl_mmuidx_ra    cpu_ldl_be_mmuidx_ra
-# define cpu_ldq_mmuidx_ra    cpu_ldq_be_mmuidx_ra
-# define cpu_stw_data         cpu_stw_be_data
-# define cpu_stl_data         cpu_stl_be_data
-# define cpu_stq_data         cpu_stq_be_data
-# define cpu_stw_data_ra      cpu_stw_be_data_ra
-# define cpu_stl_data_ra      cpu_stl_be_data_ra
-# define cpu_stq_data_ra      cpu_stq_be_data_ra
-# define cpu_stw_mmuidx_ra    cpu_stw_be_mmuidx_ra
-# define cpu_stl_mmuidx_ra    cpu_stl_be_mmuidx_ra
-# define cpu_stq_mmuidx_ra    cpu_stq_be_mmuidx_ra
-#else
-# define cpu_lduw_data        cpu_lduw_le_data
-# define cpu_ldsw_data        cpu_ldsw_le_data
-# define cpu_ldl_data         cpu_ldl_le_data
-# define cpu_ldq_data         cpu_ldq_le_data
-# define cpu_lduw_data_ra     cpu_lduw_le_data_ra
-# define cpu_ldsw_data_ra     cpu_ldsw_le_data_ra
-# define cpu_ldl_data_ra      cpu_ldl_le_data_ra
-# define cpu_ldq_data_ra      cpu_ldq_le_data_ra
-# define cpu_lduw_mmuidx_ra   cpu_lduw_le_mmuidx_ra
-# define cpu_ldsw_mmuidx_ra   cpu_ldsw_le_mmuidx_ra
-# define cpu_ldl_mmuidx_ra    cpu_ldl_le_mmuidx_ra
-# define cpu_ldq_mmuidx_ra    cpu_ldq_le_mmuidx_ra
-# define cpu_stw_data         cpu_stw_le_data
-# define cpu_stl_data         cpu_stl_le_data
-# define cpu_stq_data         cpu_stq_le_data
-# define cpu_stw_data_ra      cpu_stw_le_data_ra
-# define cpu_stl_data_ra      cpu_stl_le_data_ra
-# define cpu_stq_data_ra      cpu_stq_le_data_ra
-# define cpu_stw_mmuidx_ra    cpu_stw_le_mmuidx_ra
-# define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
-# define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
-#endif
-
 static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-- 
2.51.0


