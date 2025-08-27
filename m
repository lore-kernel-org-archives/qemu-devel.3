Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6273BCA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPWm-0008SN-Sx; Wed, 27 Aug 2025 19:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWg-0008HZ-2T
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:58 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPWd-0005C0-QU
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:25:57 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b4c29d2ea05so1101648a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756337154; x=1756941954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGGtyPIF9xqz++XIAVqkzNlT+hk2ClPUujJ2E0FOM70=;
 b=NCfWsbeAsQqUzRrxu3w3p24tdUUgJf56hKT/lX/gSx5ZsN68tb7b+cnYTbY7aySTfR
 e/FCNveF4uHwD1l9WmJIqwTRyEupZ5v6c4dWZlCa8dUX3J9426urTpiuAf2i9yctq0UU
 /qK9A5So3cOuUpA1tIppA3tuCWIqY2GVSdvToREYnIip6W4bBrkOTNzcNppEMGJePeri
 6P1PDDwU0gjN3NhGHUM9wTG623MVL4IBvh73ZLT9NLsllFLxSQPTlLgDyRhKPgE0kL+r
 oZf7MWGTKIdm9fFsJthu1AZ2TssVOXUHhwmaXRCd7Trz4Rd71EAObKVasN8qd7M1Wb0/
 +rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756337154; x=1756941954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGGtyPIF9xqz++XIAVqkzNlT+hk2ClPUujJ2E0FOM70=;
 b=HYv1WrqbazUw/QxTN4Naac7pMwierycOy4O9izo3/2J1xep9egX2W8XR18PfKLwd/V
 7xYysnDKQdFvWc/306moVahzh+N8WptmBpChs0aRAruT6vYR83BMG8jrJpNW8uom5kDz
 h/mpebJXm7cNKAz60XMErZLxqjm+2tREGAFwtYzsbXsT2yQbNz04smqKt4kCwhMX4DOK
 yJvbLOKX+LgT2By9sQLuD5POY+MXoBU3fTh1F/1oNFPOyKwckZ+toP2QjPuqN2ZtJo4X
 6nCx/oXfXbHKamWrzbauMRxug7wG4GLorhNmyVVEY6d/pQI6MI9q/liOfzWHvT+iMq2i
 tFKw==
X-Gm-Message-State: AOJu0Yxd6Hu5s3RfM9G7SYxbg7ZEHCa4JyaZSm1QkHewyLDWk2oobgxB
 t0Bs6Q/FIZAz+uL5QYDV1TzHXbp0lyYiG2pFRkAmWoIRzZJvHXcxEbO9rOh7eMjwHuhezw+n1CT
 0erc/jj0=
X-Gm-Gg: ASbGnculGe2ee/l4UlzHZ2XQmhzuc3bJb1SPxvASlcXzzzkzcYOS2L64EmbCZL8KVer
 tFF+goTK6uYYF8P2UMYQtHKQoOL6aWaJXLK9y4KtDKNeFrvBA3wyPalTlR6ut+6Zz+ZIvjLywhn
 4072k37IrEFfgUE0SahwL8XGtMPqN9EBfQPm+lqA7QhFyPKEff8cPArEcZieeCeKu/7Pcp7nl2A
 b5s5zAkwnLEdmGftMZh4usKNuGxwOcxrg8A0y1hhF1oZvpFdndStAqEfxRlatdImAfj+z8eT7zd
 psyoviriuGRfK5PQrW1Fx61xGLk8SjnvWGyrPBZ9APluKRP7vd0ujkxlW9FnYEyfz5BZJIjPgdd
 2LzILGxpwKuLk4H58PrYzlQKM4w==
X-Google-Smtp-Source: AGHT+IHWAnWk48OHvWODzxhqiFX7GbA3PRUVGlNteV1/XTwFl9dK+tapwH3fnLi9Iz6o1bvS+dM5lA==
X-Received: by 2002:a17:903:11c7:b0:246:d5b3:6303 with SMTP id
 d9443c01a7336-248753a2961mr91270325ad.5.1756337154092; 
 Wed, 27 Aug 2025 16:25:54 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248cd627e40sm7282025ad.94.2025.08.27.16.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:25:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PULL 46/46] linux-user: do not print IP socket options by default
Date: Thu, 28 Aug 2025 09:20:23 +1000
Message-ID: <20250827232023.50398-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

From: Łukasz Stelmach <l.stelmach@samsung.com>

IP protocols should not be printed unless the socket is an IPv4 or
IPv6 one. Current arrangement erroneously prints IPPROTO_IP for Unix
domain sockets.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250827095412.2348821-1-l.stelmach@samsung.com>
---
 linux-user/strace.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3b744ccd4a..786354627a 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -586,23 +586,27 @@ print_socket_protocol(int domain, int type, int protocol)
         return;
     }
 
-    switch (protocol) {
-    case IPPROTO_IP:
-        qemu_log("IPPROTO_IP");
-        break;
-    case IPPROTO_TCP:
-        qemu_log("IPPROTO_TCP");
-        break;
-    case IPPROTO_UDP:
-        qemu_log("IPPROTO_UDP");
-        break;
-    case IPPROTO_RAW:
-        qemu_log("IPPROTO_RAW");
-        break;
-    default:
-        qemu_log("%d", protocol);
-        break;
+    if (domain == AF_INET || domain == AF_INET6) {
+        switch (protocol) {
+        case IPPROTO_IP:
+            qemu_log("IPPROTO_IP");
+            break;
+        case IPPROTO_TCP:
+            qemu_log("IPPROTO_TCP");
+            break;
+        case IPPROTO_UDP:
+            qemu_log("IPPROTO_UDP");
+            break;
+        case IPPROTO_RAW:
+            qemu_log("IPPROTO_RAW");
+            break;
+        default:
+            qemu_log("%d", protocol);
+            break;
+        }
+        return;
     }
+    qemu_log("%d", protocol);
 }
 
 
-- 
2.43.0


