Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EECC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdA-000189-Bf; Fri, 17 Jan 2025 08:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0000x2-Gw
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:08 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcp-0002CR-1g
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:05 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so2822743a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121379; x=1737726179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvyvcMT5Ik5FGrm6V5mlorp+UlJN6JEGaToeVYNLLOk=;
 b=eUqBOWaNpZszfBaqsHYyNC/Zqb9cJv1JtN3sMKDijEeuYGl3O+qgdZuOynEPskL37y
 WKjwK9xL406c3JAl7EjfapiY2oDFdUGNteUNNT/ZO4Xh0OHMSNmmQbvhP1DyTHUZwGXQ
 dyw+0RzbCcre/Y7xB7VPPOgpn4TkC+9YEFqW7HDTWHl/ROdxPcto0XHlxkGWHIx8ufzO
 /VAzwW1iSYE22QhdvRNejcAn9IvGr5DcMFABXOvcCt56xbJ3enGFWjmjapw/WhJcVWWo
 H+MBwuDjlVTe214Mbm0MNlqoD5h32k8u13IgXYfpdoLGKE3zdpTGwpjFw65xV6hKNbPY
 rucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121379; x=1737726179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvyvcMT5Ik5FGrm6V5mlorp+UlJN6JEGaToeVYNLLOk=;
 b=X9FXAv45vIa2LS8eYroHl4UWZTh2mhMcr/jS7IoDaS1ac6ur4Z8fkDsJLEvWunOa/C
 cMY26HVYho9udfMmUer3L+wR4ikDw4aKwepLU0cuwyf47KeTkmJcyFEWu688KeyJAo1E
 lA5gE8GESeCB/LdDys+vhYxFHx7Htp+2vXT/zANPvECcvQ/wXxvweyy8VIObqOwEBr2W
 zOomB548CxuBHNQROl2/ETiDzGEPbS32PI9NPB8CVue0N6iTU+qTSjLIUs+ZRRmk0bTm
 XHwYII2p8xDDYK3HaWWKcNGo8vkpV2xzTD16PTR0dUmBxEaGqHoVGbkbJcA2uf7yKfH5
 iJew==
X-Gm-Message-State: AOJu0YxH7V9rpKCBXqoxflC3xXOs/CxBAnYVKcBonf/CCbJfUnU3xVSy
 jqHx6k5JdieRv9NNecESS2drLlR7AEaNa0JXxea+BYklHRGl30FAbCspLo7qC78=
X-Gm-Gg: ASbGncu3k2nE+WVwHUpVrJQxHzkd2ePSsGM3uZQMTlXNookcPxF619yqTpBt9LcpFHH
 RdIm+Q0CjQOKoWEc2fWeRWITqPKhgZmEAPE/odDSmxh7aBa1iK5MR27WS3I86VHTrowEoZQVfA4
 gtLYYMcG2lQr+V/uqS7q1LL5mMqhdVlopEWemB9O6o5mqOVHExzz8RkqAmtLznbwBpklyI3iOFm
 RWHUYc+Y2y/zuHXy8z+uRGUyaJR+yV5gxQCkO7P7diTx2AgqK0oT0k=
X-Google-Smtp-Source: AGHT+IGdIX39FQIwi493U0/Sk1pp8sfPj/O++TejDayneS+J1B2/mRRiqrIGHsqLzGnWtXtqt4nqBg==
X-Received: by 2002:a17:907:7e95:b0:ab2:ffcb:edb4 with SMTP id
 a640c23a62f3a-ab38b162801mr210575466b.25.1737121378573; 
 Fri, 17 Jan 2025 05:42:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f87d5asm170559766b.124.2025.01.17.05.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:42:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1300C60853;
 Fri, 17 Jan 2025 13:42:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 02/37] semihosting/uaccess: Briefly document returned values
Date: Fri, 17 Jan 2025 13:42:21 +0000
Message-Id: <20250117134256.2079356-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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
Message-Id: <20250116160306.1709518-3-alex.bennee@linaro.org>

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


