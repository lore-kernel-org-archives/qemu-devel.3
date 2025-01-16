Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A88C02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLa-0003vH-Ki; Thu, 16 Jan 2025 11:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL2-0003WD-9o
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:20 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKv-0001Ee-Iu
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:19 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4368a293339so11632465e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043392; x=1737648192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjEsdOpQ49q8jWvklUeiIlGfQQiMPZKhuPb/zwxQMo4=;
 b=s/X2538taag0l1vyunYzxObcXr7d1ZMmD0SlOYJvw8df925aUV1aEvEc8zoOveoqKc
 s9uHm+eDDI3NuJlqVuU9iFxVjDYf4hxu36DZ3FlMEAArIpNm4vqSGW8wKVoXft+TvWF1
 Bqg0oKydoK4j0UMoBDEICcU1GO7NLPLpIDMN0yPkR3IjiICVy1pG52NZshhGB44TgjKv
 6Kq90CTjASm15/NPrKMs7wsNr5PkfSoYQIHdL0Xv8TMQDtz3/ZiaXOKg6z7AysfwvfrP
 /X+5+HAzjSVBx+BlQ55uG2ZN5W7rH2dtFoS3us3jwMUByx5oTVzTjOfl4toaCxXqLFCy
 Ep/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043392; x=1737648192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DjEsdOpQ49q8jWvklUeiIlGfQQiMPZKhuPb/zwxQMo4=;
 b=VDTIa0/3aiNAD3dErrMrh3vPZZwmwo50EU5ZbpJrYkj3fn7KLDfFgBK8reQRuDADBL
 Ji6xkq5/wYojB8jIFd4IqadcuKjDaGmtEVXQAW+7v3WLDFbfcLi664OTfpfxvxUu+yq9
 bWmKbjFUmD8m2iufNF6E1TpdgZG+sNlgZAzn4u/BdnOqBXW3PPiZaFqgNn9EglkSRE+j
 pDmeKUVre5kDbTukKwRrxMDmn0P5ZiVJawxq5dPgnYJnGsxGm85a5BQpPJVWzN0fBZx4
 vHQlVl9bcvD7bDeLWylKzGtor7wyOAxY/BNQUPEdhBXkmb6lHJXqkm/5aRIPOiGxQ9ph
 5ykA==
X-Gm-Message-State: AOJu0YxjmPkLCzeS5vKvaQ6lHNenzuiOxE69Fpd//OolaI6C0uz8kPW2
 26uG3foDjHQ8V6jfjF3qprfpAlQYf0sPi9q+VqtHRoskz2S31L+V30F1LWfrg+M=
X-Gm-Gg: ASbGncsvgBWffeveyaswYPeg3NUtszSWhUVeaEpkMy/vCbRupz6rdhm4CbkAQLm0I1q
 rBDHK3KQhUst3TcLIWeJl1TtPMrXrreqEHoG+h8qAbT4RHar1nydx8NZ4vLK+n818ELBX7UJHvM
 xlaBJpfKzOlrweGjBYtgaAjl/4WOk0guboIMgWrV0XTtE9YuffSQGNaXpi69TcbC5xEAn5aHcGq
 lPg5PjrdxsnacD2rn+Yx6P95xp4SeRFWAuSQxLkIkdfr0jocGlJ4HU=
X-Google-Smtp-Source: AGHT+IEHxgCJp4oURrwKXbO/1xEPMQIFNjtF48dw+0k//dMLWzV525ONV+vT5NoLsz0xEZV2arjBxg==
X-Received: by 2002:a05:600c:354e:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-436e269c42dmr352667015e9.10.1737043390405; 
 Thu, 16 Jan 2025 08:03:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275562sm205033f8f.66.2025.01.16.08.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 966B56083E;
 Thu, 16 Jan 2025 16:03:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 02/37] semihosting/uaccess: Briefly document returned values
Date: Thu, 16 Jan 2025 16:02:31 +0000
Message-Id: <20250116160306.1709518-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


