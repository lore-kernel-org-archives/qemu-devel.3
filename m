Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F16EC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kro-0006LN-Nf; Wed, 23 Apr 2025 20:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015O-Mx
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq9-0004iY-V2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so396922b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456000; x=1746060800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nr7dQ2xZvL2F3PC/UuWtMxSETtioG4RgNm5kcrKHZNI=;
 b=s1CKhxNxoPpLUyOiCcY4S2ZwP0lD5VJGHpaGnkKC3dlNM/LYaDjTnqqLxWfBrMXoyU
 e1TjXoWwaYpC8STmiJQ1wFjFhlO9hQ6nbM/c0v5z3/adwRGA0kx1eGyP358YBZXmRuDc
 TWqG8TYirNi128MWT8OXY00WQZwWWvHkT68e2eFpX8/IwQIOIswlhmG3+Kx0cZmzwD4j
 ADxUD37jiBJ4YxW5DH6fnUqvTzCuBUg0QpeI29s/L0lxz/6OXKWs+WVfy3vdfuOA5OiM
 YLQqsxL7A4o5wn+jwb+HLMKmCBNdQGceNWZYMT2d9WJ8OMlS6Xav2GZFm3l980s/4FsM
 2Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456000; x=1746060800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nr7dQ2xZvL2F3PC/UuWtMxSETtioG4RgNm5kcrKHZNI=;
 b=o0u7mOM98e2RjTAJ9pZXjIjdZ1PtI2jgT9mSsjkbxZx97vlu+tPxVhhcZ+DuloMOuX
 PTRE+x0qkTWnhAh3mkxbUjunk3dDkcnFJaNjlIDARmVjrjSDKV0TJ62kWXzde2Xx1yNp
 J51IKofWccHACXsJZURQ1t9d36pHxfLSdel1/V2b54ojK8ZLZ7bxwk0MYasLbNvPQKIQ
 kvFYLkDnOlb/SNRj3iIjpA2NewhVGlKd9YvrCf6F9cp7zD9XJgRASFDdVpvr6w8Gxw4M
 jWWF9x92UUJS32kRNtsMxTXRAuslutttlqcsufua0Q+07TKHrQOMZde/0HIBmbbQXU05
 3kUA==
X-Gm-Message-State: AOJu0YzrqbluyYKyr+8ugg0NeLo37zO2l5LkyspDS1oOo8nSe3TyTYQg
 1hv41MNC4DfzJ0F7eK4LOhmM5qFROVjCg9GJnGEGF4VJblV6RZHoIzOoSYcLnYODswgD2ehwvDu
 1
X-Gm-Gg: ASbGncsrWA5cZGOrBdlsb43b28HObiguevoV2WqALOfGWdcsvVKWE+RZqiJ4VNOmMXr
 BWOMQCJXyHulpbSflGbPfNVwk+uScntnKV2FkAO7VYauJg7lHKfbKSeUvaSu7xL29OAevfj9UaM
 nycjVGxtYsSUdYdxHBWktqXcbAo4EHFMwrLMW5TTa7DmJ6rGsDw91KcwjKQjGNBM9TB9z0TAEZl
 lSYmjkgLNgKnNaPK7mU52uLKCBq3Ph+gj8kvEkc+YdGY4EQxXf6ExyvpAGT41xA6ZH2D6ADRaSV
 yWdnIj2boxxUcCOQ+xBPNg5kTfG53l9Y78tuc1DXNyIdL1dHpE+mMdE5x2i7RvnsIITBJuO59AI
 =
X-Google-Smtp-Source: AGHT+IGRTJsXRrngSQE1HeWd3Vju3UMiKhQzgxcYdzKE0by1P+zikvtUSaSYeQoaYud1zZ0AoiQ9oQ==
X-Received: by 2002:a05:6a00:4b08:b0:736:476b:fcd3 with SMTP id
 d2e1a72fcca58-73e24b0c0a3mr1161545b3a.24.1745455999991; 
 Wed, 23 Apr 2025 17:53:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 058/148] include/system: Remove ifndef CONFIG_USER_ONLY in
 qtest.h
Date: Wed, 23 Apr 2025 17:48:03 -0700
Message-ID: <20250424004934.598783-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This is include/system, so CONFIG_USER_ONLY will never be true.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/qtest.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/system/qtest.h b/include/system/qtest.h
index 6ddddc501b..84b1f8c6ee 100644
--- a/include/system/qtest.h
+++ b/include/system/qtest.h
@@ -23,7 +23,6 @@ static inline bool qtest_enabled(void)
     return qtest_allowed;
 }
 
-#ifndef CONFIG_USER_ONLY
 void G_GNUC_PRINTF(2, 3) qtest_sendf(CharBackend *chr, const char *fmt, ...);
 void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words));
 bool qtest_driver(void);
@@ -33,6 +32,5 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
 void qtest_server_set_send_handler(void (*send)(void *, const char *),
                                  void *opaque);
 void qtest_server_inproc_recv(void *opaque, const char *buf);
-#endif
 
 #endif
-- 
2.43.0


