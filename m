Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64273C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JP3-0005G8-T9; Tue, 22 Apr 2025 15:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLf-0000fg-8k
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLc-0006dI-Na
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:02 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2243803b776so87045375ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350319; x=1745955119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nr7dQ2xZvL2F3PC/UuWtMxSETtioG4RgNm5kcrKHZNI=;
 b=iIJTy9b8QIq1Dd0gBUdmRi1nlhnEWTYjEI3gEb5MY4ZeuqOURxloTYiQgMeQRSxWzB
 q+NpHzDhNfTiiF9UHi2yqYLZC+slwXyUzGd6bjQ5yDxvMQhA4I0a7Xx2MClOo9rtfOEs
 O4mLQobgQ5Bd9CFP8Novh0RmXWUk5dsP0b9be1fPtgybRUfq0RO5YQRitGIXwWI/Grb9
 fFs5Dzwy8UFnkSoHakgyYimyJxMVyDvCVzg7CvhJJ+VuRKpvEKdD/9RHLQ1Mw8AhNLG/
 clPKbB1QnwgAPMkGYdqekQkuwIcyyeFilylD6i3/rZ5Bb8BhJeMnOBTvixPcN8FWBn2I
 AODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350319; x=1745955119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nr7dQ2xZvL2F3PC/UuWtMxSETtioG4RgNm5kcrKHZNI=;
 b=dXfP2FBdIaxqpxIfWMG9M7bLwzJD6fw7WjQsTvfbEco8vvykpoR5rTfh2d2Pldk3Dq
 AQQefIM1Q8w9qj8lxR9GVaIY/U0iFYIOC7pvVXoR61W2gtK8RRujRDpn5aJ/x0aiAlk0
 HDi94RFKRHsKx5OwLzrn+7yyzjHcF2joizP1xpjeGCeJxu51wJqHqwHzFb8konZLilr/
 r3PDRwEen7bKzVGI1fHvpUvcFWEEgD0ejL4mh2dOdH0DYdF8QSc1Os8AZDgUgFUqu9mf
 Z8OTPLz8Jp+kkdD7BYRnKgVjm+5vbAPRyU0xqTj35z+WG+vBSL6fmtuuQHxBY6j662ER
 8LDw==
X-Gm-Message-State: AOJu0YyeSUzn8rgCBrifZbbmkAcljhlL2Rb/22GocPZAXcHZU5JfhRYw
 pSFtRsy3z+HtFRnt5FCjS1Rm2B0+4toQ0ZVDyE7k9rDBy4NYdf4F5lqw6HWdAKq5w+pHTXc9Wy8
 v
X-Gm-Gg: ASbGnctqXQCRX9IhRmAHJVbnzwgjYbrTN7kl3Oz7kVJXxsehoXrlZqbeqtuCab8GDHz
 tEXiulgVOuiblKkzK82thaSz0Y8visjzXzqFc70Ffhca+jaJPX2Q+G1DykJIMkCPmrupKfmngnb
 7KR+EA8FHG6tuDWZ7oMPkZEZ1dhUFQo4waT9HQW3+c6znkCyRg3ryFkeMCniyAiUjUX171Ca1it
 bqhRc99+pD10XruDPJEuVzLEnmYzlP5GTJ5w5B5UgkXdOIBR73Qf4fJcnP98y8u8/yrEMfZi4a5
 YEmkR2+48lMIxTiDqySXQ77pNhWr6iLlxQ+YvmlgYmbvvWDz3pwFIVdXQzD0fknVCmYdP3PDwGE
 =
X-Google-Smtp-Source: AGHT+IFLHwDdGKiedBK564XrP5c4CLhdhBGocIBxbmisAwAMdaZPsqMS4K0Q+pTG2B3RcfNFrP9UEg==
X-Received: by 2002:a17:902:f548:b0:223:635d:3e38 with SMTP id
 d9443c01a7336-22c535a4a89mr253599885ad.15.1745350318965; 
 Tue, 22 Apr 2025 12:31:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 058/147] include/system: Remove ifndef CONFIG_USER_ONLY in
 qtest.h
Date: Tue, 22 Apr 2025 12:26:47 -0700
Message-ID: <20250422192819.302784-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


