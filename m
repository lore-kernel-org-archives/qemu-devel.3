Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419AFC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UKv-0002cB-7I; Thu, 03 Apr 2025 19:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKk-000268-IE
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKj-0000mx-0u
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3996af42857so1747726f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724251; x=1744329051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYzlqi0+Jcd0Far/f+KTH2pwTyoIqbv8wkla1ahOpxo=;
 b=uAJ6PbHY+vw5/ZtcsVWRLszFrSUBlm2dD1/49lD9/5EtxFbEZd+Fqy/bYVPv6dIXv+
 txC4AnFYPRlqg9NxP52YN/2qNiSDs6s/EnY+JNTMw/nFd0ZWSFCVZbdpz+XZeXqShW/i
 HWSuUKnPTCwmsPgAbvw7KqmEtyfrG0hVnABJG24Adfy3kBH5JmAVcoPQ8oawnYYQLLBS
 inq918KyHTiQUYtmc2tFTE/U43/37DA5E2ReX80lYRKODixlrABTXRVvKiomiKs6G79C
 BUiFa6h/ej9xIkx9h1hq1ss5gGngpro1Fu6SA88IkjzWOxTPp5NyFfwGdQdXb8hExdj9
 knew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724251; x=1744329051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYzlqi0+Jcd0Far/f+KTH2pwTyoIqbv8wkla1ahOpxo=;
 b=mTJMdX69VM2bPuZRizR6lhm1+QEhC88Yi9Hea/ZTTGzTq5Uqb8z/nZiAzt6FYbco91
 zqpo/cypoA9xgzIeEqERMILJC/5t1WompJ3HJic2Tpxu6JnAqG621zZZ27/+bkyfpU4g
 ljIY6IJYqF3/ei5yU9ogNPvcncYjPnvqI9GYFQviVvWjfBH1/bVB7Yp5AsNy7QG9biP9
 YkmpL6AHpySpuBuO6IoyD5IniADBn4Cte3JugX6juiOEctdLQTPjD4QAe91xGWgn7AOW
 2eUCsbzouSsZ4PU3RtnDLH41aLqu+h9DFxW/0Z9RxOs8+MDXPGIYyr1usaslXGbP3vDB
 +kZA==
X-Gm-Message-State: AOJu0YwCpjHH45BzFbGcnkn2dusMd5A7DioZSrd6jv5sXGkbbU1o0zwl
 i7893QGv7D7FCSFS4+swX9QzdojkLQuovceh/gEsMW7AMCBwrzupqa1gN8Mm8jsMujqZmIGe8y1
 L
X-Gm-Gg: ASbGnctfSglmzwVt3iS8JpvYGA27JQfpQNejcord0mPW606YOZIQhPg+5ygx1mOnGBA
 Cqd5APQIRO2PvsWNlx2Sieheym8Wb0KqsnBywP4pej1GLaIGFVS5Lwy5Bp5OLMwrhL1VbPu66i0
 7q9xqNgNRtVB457taJF4QXB3v/cCoXgL6jJGHNj1sa1dgTe04siTmrsbe+HHzTYod0NWoVJVEge
 cvv876uCN5zw8Qpp8wxDZe61KS5J9q+5nTkNcLBGIamPTZSt3vD2tzMimE+bJBRZORffF81xoHU
 czwHR/bgO+naGC0WwNfqPSB45IpKjr0O1TiLBjc5Ok8Y9K2cj+kO23wQBU/OWnngXkyvk4xDihp
 T/MvYhYmqP4sWwiGIfj6bgjoYBiCUcg==
X-Google-Smtp-Source: AGHT+IHH8xgE0ZABsN+SmEvJf0Pebyy7lN9FyHpwBM251BV5j9CPsSGQKKfHmEgm4ozQamxpQl2p7Q==
X-Received: by 2002:a5d:5847:0:b0:39a:c9ae:9eea with SMTP id
 ffacd0b85a97d-39cb35aecc6mr838393f8f.10.1743724251102; 
 Thu, 03 Apr 2025 16:50:51 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d980sm2999728f8f.61.2025.04.03.16.50.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:50:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 15/19] accel: Include missing 'qemu/accel.h'
 header in accel-internal.h
Date: Fri,  4 Apr 2025 01:49:10 +0200
Message-ID: <20250403234914.9154-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

In file included from ../../accel/accel-target.c:29:
../../accel/accel-internal.h:13:32: error: unknown type name 'AccelClass'
   13 | void accel_init_ops_interfaces(AccelClass *ac);
      |                                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/accel-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/accel-internal.h b/accel/accel-internal.h
index 03426aa21ee..d3a4422cbf7 100644
--- a/accel/accel-internal.h
+++ b/accel/accel-internal.h
@@ -10,6 +10,8 @@
 #ifndef ACCEL_INTERNAL_H
 #define ACCEL_INTERNAL_H
 
+#include "qemu/accel.h"
+
 void accel_init_ops_interfaces(AccelClass *ac);
 
 #endif /* ACCEL_SYSTEM_H */
-- 
2.47.1


