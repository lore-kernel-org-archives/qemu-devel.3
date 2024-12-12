Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE13E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhlt-0002V2-9i; Thu, 12 Dec 2024 06:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLhlr-0002UV-Px
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:54:19 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLhlp-0000Us-SE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:54:19 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso437678f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 03:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734004455; x=1734609255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EjT6SCOybnu/XpMhC/RGVVXaIvF4ar1s31Q/izSDY0Q=;
 b=Nu2k9MwT3ZjyUmma5iF0IUlmARqZuGx8kiIvWq4fstFCFDA2vRlLyq/DOyclg7+Vvn
 NuTzRTayK7yN65/hB/sRfRkpaJE/hFD0fMvd27uiIRC3KyNMoafAPb5vUNvfRvVC0SIb
 p2De7+yQZHXXOlD4m0IJbzrvPruNgnsyYyLFU33HECzc5kQVyiJb/wTSnD4n/m/gBERA
 UHvuHMdVAJ54tKheZfnix0ZdeXsGlw01hEoe3Wt379bj7Pw2DV35q/hZbjVrgKBuFLQz
 C3jNHTZuYtRYN4uqSS4q2aeVXIfsjlqZzAoHmj+bgUlaP1Tb8RlTcMajSORGQZ0ZDIOY
 cosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734004455; x=1734609255;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EjT6SCOybnu/XpMhC/RGVVXaIvF4ar1s31Q/izSDY0Q=;
 b=mQNAZ9Am9X0TLfHOCrj8VNUWGKNAhbZMyqTig+gXrtU7kBgxkZlVNl/UgA3iE9L+lD
 MlG6C/arw31HW9FDTCar6BDMSECyPptKsZ8D3T9fZO64ryEQ0V7zD9U19kGWTdGvmfCD
 eAhG3ireZ3shT98KYntoqCiBZlVDDZN0XlOMSk73TSHgLjg6q5jkoXXMUTR8VZvm1ofr
 y7mCGxckezRpTjAmd4vWEmgavPM7Pdi/J3BpbAuOnWdNfivZCgFtPmD3/gZQOZNzHHLs
 EPiPrhGOLwB4Qd+3EF6CNQP+uNG9wxWlStHGbg/67j4sCICU15Lzch3c6DriZOZDpLN1
 DVig==
X-Gm-Message-State: AOJu0YwLNwXsAyW/EhzYwa3op2VlaJtJY6bVgtzSxT85Fxiyo3oUxy3E
 XpqblQthivkC2o9g5jp3rgwgkjXHrFSTLerod08tuc+/GYFGvm4CEatBiy8bPNafNew1Pf/fDKb
 A
X-Gm-Gg: ASbGnctbdPz552535pkMFhPdgvp0XGBIR1/FagtOpgKB0p7zcFKJJtlN59omc+/QNuG
 eX2okcAc17N3hWcrWtk6gZyHdc9ueHuCjrqE0stTavpabrUKTpVJQ+JaTfQRE1kDx/OY8Sh8rOm
 nFc9WEHT0+am3iLKtcGfRu280hjSwVuWYkqSORZOwqd5rgEpgLaDZ9YZH+nmegrOi8TDLYWmBuY
 rtS0c97YyzMBeOOzjsxzSUqYBRxknHo4GkOBrS+wPmRI4PUEz7Ysyg0x6xqHaMrpBFdp0hAHddO
 eXcFWKLT3WxexhIrxSuBITLpEVAw43fvcNL+
X-Google-Smtp-Source: AGHT+IEfYbSoUMLflqdpaOQ4fS0GcEDokIdLlAomTsOo2Vft0iE1A4ybCHRMOgJMsGoGComdBUH64Q==
X-Received: by 2002:a05:6000:4026:b0:385:e9de:d521 with SMTP id
 ffacd0b85a97d-3864ce867a0mr5659114f8f.8.1734004455319; 
 Thu, 12 Dec 2024 03:54:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a5085sm3817100f8f.38.2024.12.12.03.54.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 03:54:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] semihosting/uaccess: Briefly document returned values
Date: Thu, 12 Dec 2024 12:54:13 +0100
Message-ID: <20241212115413.42109-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Since it is not obvious the get/put_user*() methods
can return an error, add brief docstrings about it.
Also remind to use *unlock_user() when appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/semihosting/uaccess.h | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index c2fa5a655de..6bc90b12d6f 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -19,41 +19,96 @@
 #include "exec/tswap.h"
 #include "exec/page-protection.h"
 
+/**
+ * get_user_u64:
+ *
+ * Returns: 0 on success, -1 on error.
+ */
 #define get_user_u64(val, addr)                                         \
     ({ uint64_t val_ = 0;                                               \
        int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
                                       &val_, sizeof(val_), 0);          \
        (val) = tswap64(val_); ret_; })
 
+/**
+ * get_user_u32:
+ *
+ * Returns: 0 on success, -1 on error.
+ */
 #define get_user_u32(val, addr)                                         \
     ({ uint32_t val_ = 0;                                               \
        int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
                                       &val_, sizeof(val_), 0);          \
        (val) = tswap32(val_); ret_; })
 
+/**
+ * get_user_u8:
+ *
+ * Returns: 0 on success, -1 on error.
+ */
 #define get_user_u8(val, addr)                                          \
     ({ uint8_t val_ = 0;                                                \
        int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \
                                       &val_, sizeof(val_), 0);          \
        (val) = val_; ret_; })
 
+/**
+ * get_user_ual:
+ *
+ * Returns: 0 on success, -1 on error.
+ */
 #define get_user_ual(arg, p) get_user_u32(arg, p)
 
+/**
+ * put_user_u64:
+ *
+ * Returns: 0 on success, -1 on error.
+ */
 #define put_user_u64(val, addr)                                         \
     ({ uint64_t val_ = tswap64(val);                                    \
        cpu_memory_rw_debug(env_cpu(env), (addr), &val_, sizeof(val_), 1); })
 
+/**
+ * put_user_u32:
+ *
+ * Returns: 0 on success, -1 on error.
+ */
 #define put_user_u32(val, addr)                                         \
     ({ uint32_t val_ = tswap32(val);                                    \
        cpu_memory_rw_debug(env_cpu(env), (addr), &val_, sizeof(val_), 1); })
 
+/**
+ * put_user_ual:
+ *
+ * Returns: 0 on success, -1 on error.
+ */
 #define put_user_ual(arg, p) put_user_u32(arg, p)
 
+/**
+ * uaccess_lock_user:
+ *
+ * The returned pointer should be freed using uaccess_unlock_user().
+ */
 void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
                         target_ulong len, bool copy);
+/**
+ * lock_user:
+ *
+ * The returned pointer should be freed using unlock_user().
+ */
 #define lock_user(type, p, len, copy) uaccess_lock_user(env, p, len, copy)
 
+/**
+ * uaccess_lock_user_string:
+ *
+ * The returned string should be freed using uaccess_unlock_user().
+ */
 char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr);
+/**
+ * uaccess_lock_user_string:
+ *
+ * The returned string should be freed using unlock_user().
+ */
 #define lock_user_string(p) uaccess_lock_user_string(env, p)
 
 void uaccess_unlock_user(CPUArchState *env, void *p,
-- 
2.45.2


