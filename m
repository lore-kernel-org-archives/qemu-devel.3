Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8039C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFe-00055g-2y; Tue, 14 Jan 2025 06:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFc-00054Q-63
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:28 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFa-0005Oq-BQ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:27 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d9f0a6adb4so2510967a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854705; x=1737459505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjEsdOpQ49q8jWvklUeiIlGfQQiMPZKhuPb/zwxQMo4=;
 b=BPqPKrdh83zFleyreV9o7NUjIxSBZhBPQipuGt3B3CRliJTPYr66/oycp9/vTRHmE5
 7SKUAjdg3s62dRNWlot7fo1qQyBjmX0WXx5ug8xidSLdGCg4W1qf2zPbCDWdcs2oRBKk
 tLmY+6EvbO7Y9XlRTw6Pg4coEufqViBygiJazyj1QS9hExBiXKdiWig7ytMl5AvJOUSE
 tN0h1WfD5M4595Myjk0YVulXtm4ld7R+DuXKDCCGKFCA+lane8zaqdfws9wS4PQgE4pl
 NQZvMWZAKJpHNdIKV1yU0iivpRhKvN43WjqHQiiIU5RCgvO5zwQBUu40KjQeYZVDkr07
 6Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854705; x=1737459505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DjEsdOpQ49q8jWvklUeiIlGfQQiMPZKhuPb/zwxQMo4=;
 b=NfA7oEGQSE5a6pBtbsoGNeS/qCLbZG2ekw1U1ZbEMZXLg8OoUI+moLlPWL0mAJOqTx
 V9RVrimPQ2jxliXXCxy65r8POEfUFTu5Ys1GOt3QjXow/Cmp9Eg56i1fTRz9WjDo4Jhb
 smbiY204YE1BcXGsFJRGaGqXGYD+C81Ccey7R2XG1dvpuNtpc1ow70qJxjNSwkhJWoIM
 u3lFUUlQOM7gmiO85vplb/4ByXC9BmuqzNv+D2MjNwY67GgvR9Ma3UJlGbjWxUgwb45l
 51WksIKWOMxgtcjGue+TgXXCgQmrAejaRuko1rCGB0DH8MGaTwvSseKrF7sw6KX5S6hY
 CKCQ==
X-Gm-Message-State: AOJu0YzDjFg+ZsLocEN72kjqSlqOC7Du/G52f6POeltn+9WeDZcUVKBR
 xVLxfx2wyafaONACBaCq/lOQJiX+14aWXsCU/mngQNOyOB5dH4Gxr8C+Pycli+8=
X-Gm-Gg: ASbGncvfiOtb+SZKcftKGPMoDQ44oCu7Av/NNRkOuohWFiNlZTVkSMCMlVJCYBv30Xf
 7uLqXK4MexG8kmAkjJILF2YDrfXL3m1hN/GO+lRpToHmwUpU9TpTblZgqprMnLvAN6/KoH16U4q
 Rb3ms6eU25tpXxJF9SptInWt3QFLJEOGAYkxLgJr4hqFqX+L1/TyLgAKfxwKza/UH12mXmFJZ+D
 1odDQFDpHpbfoK51RDrnPFxZn3AuAn7V8xUqsV39eGyXlg6YKQd8gw=
X-Google-Smtp-Source: AGHT+IGSD9s1d/TdeGuj73QWEAjuBQBDdnXger8Z32G05UFkWFvPAAkrHCypMyEB4mBX5iYNFEf+Mg==
X-Received: by 2002:a17:907:7f08:b0:aaf:c19b:728b with SMTP id
 a640c23a62f3a-ab2ab708d2cmr2339132566b.51.1736854704775; 
 Tue, 14 Jan 2025 03:38:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b0ab6sm615513066b.155.2025.01.14.03.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F296F5F92B;
 Tue, 14 Jan 2025 11:38:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 02/37] semihosting/uaccess: Briefly document returned values
Date: Tue, 14 Jan 2025 11:37:46 +0000
Message-Id: <20250114113821.768750-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Since it is not obvious the get/put_user*() methods
can return an error, add brief docstrings about it.
Also remind to use *unlock_user() when appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212115413.42109-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/semihosting/uaccess.h | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index c2fa5a655d..6bc90b12d6 100644
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
2.39.5


