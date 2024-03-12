Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08620C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk71D-0003VW-0M; Tue, 12 Mar 2024 14:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70y-0003MZ-N7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70v-0000cB-R1
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41329b6286bso14727745e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268692; x=1710873492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=09aQF63pPHOllcqpbcVLj8Q606SuNrCw0WJNZs+4sLY=;
 b=dL20NEt8U99+WpjLVmbF2fkkSD7tFmqjoeMGHuH6mTpcXSr0VZ7GZob7jK/E0ajq+E
 pgHi9+t0JEvNwFUBJ5YAPXW21n63uEFv2VgX8AiErBSLdMAOV0+qqsqAKqniPrjbeW+A
 acwZlA7iXwjlLvv0A1DZDqDzidp25/+FWGXAHo63DcRbUCU9YgUwEXsA5p6qASxeu7aQ
 JLGS/rqgUPSM/ZsWSkQzosoeGCzHbDcaCNXYxZsWX+G8eidZOdw0Q8nkdSrTOmN8Ge8W
 1k2O2MUtvJ3ADHmUn4jYgfolLg80IJRjQNwVOwFQxljKHyLeJFsthO0sfq3wBwfoj7eS
 Kv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268692; x=1710873492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09aQF63pPHOllcqpbcVLj8Q606SuNrCw0WJNZs+4sLY=;
 b=DsEKRj89b2GnHfBr3C96Sycg63s2rAMyxR+Cn0nwnJvw7t/jiL3Yz2EshqvYZe9wM+
 capSidjQMYsmwXLShSYpW+At+9xcT1jImj4Rd/uQw9AUz60sgqjdSSzXlew4ifnbykp0
 iwwUViVi6Ibu2uk/9u/HUIsDU3pxS0HmhIWNYhEMXpBc5gGZab7FMVxHuBFujK8IaopR
 klTV6ktsA9W7jpJI5oGUOrW4PH7tW5AYhc6+iPE51iXxZ2S2AUDM7SAhkVkXPONpMrZ1
 HDlLdaiFjLxZEndfzHLCVx0ev7kFuP6YrD/IZsRtvVC8JOR0qGeqZn2L48E5zY20iMNF
 RKvA==
X-Gm-Message-State: AOJu0YzffBMYgnuUu3p93WRwXCl5ufa8KqA5tN5n1RHuMYm/3Ujynu09
 1ae/fZPynsHxMSV0s9tH2HCnUGcwbbHr7Ou9mJ7IHydy4+gYk50nOy3DM4qdqHuIU5o0+XApxX0
 b
X-Google-Smtp-Source: AGHT+IFcPmXgLbxw2ogGFg5MI9T/giG3aT3005B5qv1ibPNKlJ9Q5r8VGlh+3MXoVKMbNF18A9IhOQ==
X-Received: by 2002:a05:600c:548c:b0:413:271a:1e5e with SMTP id
 iv12-20020a05600c548c00b00413271a1e5emr691533wmb.38.1710268692473; 
 Tue, 12 Mar 2024 11:38:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b00412ee8e2f2asm19836337wmo.9.2024.03.12.11.38.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:38:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] tests/unit/socket-helpers: Don't close(-1)
Date: Tue, 12 Mar 2024 18:38:05 +0000
Message-Id: <20240312183810.557768-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183810.557768-1-peter.maydell@linaro.org>
References: <20240312183810.557768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In socket_check_afunix_support() we call socket(PF_UNIX, SOCK_STREAM, 0)
to see if it works, but we call close() on the result whether it
worked or not. Only close the fd if the socket() call succeeded.
Spotted by Coverity.

Resolves: Coverity CID 1497481

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/unit/socket-helpers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/unit/socket-helpers.c b/tests/unit/socket-helpers.c
index 6de27baee2e..f3439cc4e52 100644
--- a/tests/unit/socket-helpers.c
+++ b/tests/unit/socket-helpers.c
@@ -160,7 +160,6 @@ void socket_check_afunix_support(bool *has_afunix)
     int fd;
 
     fd = socket(PF_UNIX, SOCK_STREAM, 0);
-    close(fd);
 
 #ifdef _WIN32
     *has_afunix = (fd != (int)INVALID_SOCKET);
@@ -168,5 +167,8 @@ void socket_check_afunix_support(bool *has_afunix)
     *has_afunix = (fd >= 0);
 #endif
 
+    if (*has_afunix) {
+        close(fd);
+    }
     return;
 }
-- 
2.34.1


