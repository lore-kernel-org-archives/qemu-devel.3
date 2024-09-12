Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD27EE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodhW-00068g-Tv; Thu, 12 Sep 2024 02:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhU-0005qx-RX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhS-0003SY-S6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cde6b5094so3336545e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726123984; x=1726728784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eioWWeRgyOaY5sg2V+9HU3V0/ONJkXh1P/1QORE0Zbo=;
 b=BLBofvVcZdlCbH+iihUUPlP7+Xv5cUkvHl+uwPx2tiIpHgXIk4K86NgkzbkjsHTsx3
 QKmBDhUeyb+ski4bjS739QZMQ13MY0/wveoDErXtwtSSq3c5MFQSH2cSoKzGMNUTjbjK
 mNLp+87yEgHrism6U0ZMxlFSdqDmVDFwiu/K5S78Qoh72NjaGDsUeFMpxiwAMlSadb+y
 v4W2kPDo+XhsVJON8lTStWxXEVSGmCd8gQK9EmNlD+Y+8cHsm0ofRNkK96x1Bczs14Pu
 NQfEcgsooBzdsayWvlc9elSlvXqjjIhGlfOUe9V2o7cdyQdw3JeT7hfLHuut6QhysaKA
 DWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123984; x=1726728784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eioWWeRgyOaY5sg2V+9HU3V0/ONJkXh1P/1QORE0Zbo=;
 b=B8KHIKqveLlaXrnVTRqcpfoUfvkHUqllDFOipmn/LxUNIk/MNNkYGt9zm9JDy2a5eI
 a58jo6rvtbpXw6LnVf17jtfFG6fogQHccN509RSg4lAQByopnUWfHiGXyPDcVDSEw+o4
 WxwqWtKVdnHzJ7j0lMAZz2yaJNQv7Qj/CypGTpQlxvtJRz2Zi4a1tBlyw+cSuHs92F0o
 IyQYj4VnN66372SEWJE1IbkVaOvgLsFkOkcmXQwcswoY2BrfQQxiB2UD2xDREqJ5IwbK
 /PxTL2QmWXWK546QitlTcbgauSeR4oSbOO6mhwBvmB7rYECpYuxw2tb81gMlNhammP7L
 OeBw==
X-Gm-Message-State: AOJu0Yw04lCnelxoHKq7fAMp6n4jlqRgcWne33PvrTmwVt8hqniHI4o1
 JrNY8A8geO5XCNNsfchAtjdawOJdakgZ78r/usMbnjGCPY5e81x6khERtCCj7FQcQhH2z/ksvir
 b
X-Google-Smtp-Source: AGHT+IHBZ3PKFWiZq9ZfWFSaoYJHdU6azIGsxv62XiZT0oOGNJtbGXli8k8VAFsCGgRYwjh240dnHA==
X-Received: by 2002:a05:600c:4ed1:b0:42c:aeaa:6aff with SMTP id
 5b1f17b1804b1-42cdb54078dmr13652955e9.10.1726123984467; 
 Wed, 11 Sep 2024 23:53:04 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca87acf26sm181419795e9.10.2024.09.11.23.53.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:53:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 51/61] hw/char: replace assert(0) with g_assert_not_reached()
Date: Thu, 12 Sep 2024 08:52:20 +0200
Message-ID: <20240912065227.67848-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Use of assert(false) can trip spurious control flow warnings from
some versions of GCC (i.e. using -fsanitize=thread with gcc-12):

  error: control reaches end of non-void function [-Werror=return-type]
        default:
            assert(0);
      | }
      | ^

Solve that by unifying the code base on g_assert_not_reached() instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-5-pierrick.bouvier@linaro.org>
[PMD: Add description suggested by Eric Blake]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/avr_usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index 5bcf9db0b7..e738a2ca97 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -86,7 +86,7 @@ static void update_char_mask(AVRUsartState *usart)
         usart->char_mask = 0b11111111;
         break;
     default:
-        assert(0);
+        g_assert_not_reached();
     }
 }
 
-- 
2.45.2


