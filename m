Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7F8E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzX-0004iX-6u; Thu, 09 Jan 2025 12:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzP-0004hS-96
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:36 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzN-0006yu-KJ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:35 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso222872966b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442390; x=1737047190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjEsdOpQ49q8jWvklUeiIlGfQQiMPZKhuPb/zwxQMo4=;
 b=ICWHP5oaVPqalbCZQ9bur6mGgSI/Zle7dN21vSJlV0teh9xNkcqypoTDryt26kP0XA
 j2JievHuD3+PaUZwTeA7eq9qsegwwfBFevay0T0xkYZn0ksTo3hBcAJrdEE3d4t/X1Le
 YVILv7MZzh8dWISjBHJ93Gzx9n45rRV/uW3XN3cMDFMjLYubu6ctOuYT+HZay4YYBRh1
 A0YwZBu7CDx6d2h+QNYvUCtl1RQjQHnsqcCg1g66GHG0WUDYcYnTWqv7dxvqECbXd1KX
 AF5BAGBww01tj6eV1N7jd/b+9Q0COWqyruoX/VOHlWEUcaZn1XFXqTCy5hs5nFQTjG15
 huUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442390; x=1737047190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DjEsdOpQ49q8jWvklUeiIlGfQQiMPZKhuPb/zwxQMo4=;
 b=ohw9SusHBta8Wg9bo9mjC1wIQHPAEgWxEWRw5TXZZ5oo0X43t/Wdy/GVUREONt7l5T
 J9HO6kKy5BN9UORWJBakue7IA8BFRzpxttZwbri4awHEWxo35QmbOOi6BFrAzZFMt3am
 Ju0NkELjDugWDdWOwB+VGyJ4DsF3UrTr20G+dhdeG0ljvEguZ32yDcAQfVqQF7HDsPQ1
 llGCE9E0FEL8P+h4kICX3hcmwwjxAUeZ9hGDC3VLIQNH7W4H0bETDdNeGnOYb3DS9IXM
 bYxGv4SDBuw86bXSaKHOsAoA+GfuZ27EUvPz8Aq71fNzz3gV5R0TryPxCaroPfYuY9LQ
 l6jg==
X-Gm-Message-State: AOJu0YzhMkAtIJLdtG+ErbnOQK3z1jINqIxQ0iRGbLRBceFDATABKvgq
 6KqoY4rhjFDaLuGGgsczD/jq0A1P3g6RbEt8tu4mCjKftU8CrMbUrd6izFMYvrk=
X-Gm-Gg: ASbGncsFrgdmBizJhjxA7QNZUgqbK1mdME2PtN0tE5qZlTwPcfVh2Q4XXgDMWl49yWf
 +BGg6ivvQmd8VHIzLew/cxjNL9DoMQugAIuNlvzqx8NFXniePbosvd9dTMdWYr5NJNUvttIaPb0
 wb8eFbKi1o8LaZs/VsNSCk+O2FstHPrsS1RYiLG0rKEzujIRLcERQRoJS5gwITTIZexfjdml07x
 iBC5FnmnaBkQx0gYA1CrBMJWeYC7F64u28vYPlu94dL7IH316bPdZ4=
X-Google-Smtp-Source: AGHT+IG4opGGhG1rDrCnze0YWcLspvZpuLl5akvU6vE11V5mE8vPm4tWROYbBoleWG+AAPFn6FLB9Q==
X-Received: by 2002:a17:906:fe0c:b0:aab:75f1:e51a with SMTP id
 a640c23a62f3a-ab2abc78dc8mr688853766b.38.1736442388881; 
 Thu, 09 Jan 2025 09:06:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905cd8asm89286566b.7.2025.01.09.09.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 043965F95A;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 02/22] semihosting/uaccess: Briefly document returned values
Date: Thu,  9 Jan 2025 17:05:59 +0000
Message-Id: <20250109170619.2271193-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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


