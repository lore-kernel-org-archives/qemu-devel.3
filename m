Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BC7C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI1X-0001HS-5h; Wed, 26 Feb 2025 09:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0z-00011O-T2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:58 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0w-0005hY-QG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:57 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f29a1a93bso5565556f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578633; x=1741183433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zISDsjBmMmQ71Gb6oaelmScpNesPc2IfHlK0vGMPwP0=;
 b=jdsInQIaOc92j68cqFEK4rCHsyoS2RQT+dm9nLLzAOSxspDXCoZqmDGvokEuSPhEXo
 N7IFOXeO1NNzPZSMgDJcfHsknVmI9PykS+VyHBNaxvcqMtZK+vTnNYA9Fe+9IiD1cw9W
 IzhPrWs9Yno9tIscug4yAPtvJkERZtyQPOl2u6ldzKfdCsFR1OtWKQNxnfpeGxi+pmM4
 RKHNq1xPceoOOdzj166EMWlvDXBVwzpfS1YftZImvpak1SmUVPeIWXPJZ472dd9hNjj8
 586rJvTGvkg3yGNSYTHu6n0hxfuuYanHZ4ZU5EZoQTBC3PrblNa7/ezxzljik/CZI837
 YUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578633; x=1741183433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zISDsjBmMmQ71Gb6oaelmScpNesPc2IfHlK0vGMPwP0=;
 b=tsm/MTzUbgDZp/y+gygS/jE1Eu4lWi0CR7oP6/jVqwJPXJCymypCyOYmXyZtjYF3Yb
 A7CeAIZyZjtUUqBxvzQIkLs3e05KmcvJfJt6NVoWjDb7udWKI54oqtEA6979zrnZNzzp
 JlLhBMhwelxWfarkU9oRy3g7ndyWNLn/6mpQ4qoosoQU1TE7y5lhSybXFke+1sEqXi+P
 2W5+6TdWm594tM5JuyiLCMz4CkOpN1WaD5rTZvxw9qVssBJi07XKUphlmT3nsqPvYta6
 1eWuLQbh5+4AM55gRaU9KKKucFqHMwJ1ZV5a9RWmgA49jBbRaxMaIeOHluHeqOx3tBZF
 tAdg==
X-Gm-Message-State: AOJu0YzgF+KTqyzvvOs5vKqIbSgH86hrl2gXJ3PLbAZI3upFQjtRSGsQ
 t/ig+QZopzeYl3CgklIae4ROg83aRhVPVtQXJVcnsFVZHEJGvSGia4rff9K+4gU=
X-Gm-Gg: ASbGncsGVX1KZBZWr2XBpE1UmOZBCzFsFLelQJBk17QeOpBXeaxVufrMLWjTlUlEKRz
 UuPIsfELWUFWh1hh4OSPr8MgeKXNMaRHyHRCYuFjTH0pLWAG+LxGaTeXjibxrDy3VCUtjN8sLVr
 Q0QI+8MaLd5nAzX/Mdntpua0sPVISWaLsdPrwBJrlOXgKLlw3Y0iLFvVuATKkbwHlSebY87YZBp
 dONvzlq/qHZ9V6ObvjTY7PFAJzewyYB9fQ62IwNbf4rOr5OhiaF1PCXEWFn2rSt0dnZPZKiqa0s
 YS9msHPJngFu9M1c3LDohDh1/W71
X-Google-Smtp-Source: AGHT+IHAVSp/Vk9qJ+f8PZ/6Q7AR0sEr3gfMcHIuX2r0CcBzSrP/+q5OI9yk8z/9bJ0w2M+OjnH5dA==
X-Received: by 2002:a5d:6c6f:0:b0:38f:2a5e:ec5 with SMTP id
 ffacd0b85a97d-390d4f43052mr2726474f8f.24.1740578633165; 
 Wed, 26 Feb 2025 06:03:53 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52bbbbsm23282825e9.3.2025.02.26.06.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 24296603EA;
 Wed, 26 Feb 2025 14:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 12/25] tests/tcg: add message to _Static_assert in test-avx
Date: Wed, 26 Feb 2025 14:03:30 +0000
Message-Id: <20250226140343.3907080-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In preparation for enabling clang and avoiding:

  error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]

lets just add the message.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/test-avx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
index 230e6d84b8..43df2226b9 100644
--- a/tests/tcg/i386/test-avx.c
+++ b/tests/tcg/i386/test-avx.c
@@ -244,7 +244,7 @@ v4di indexd = {0x00000002ffffffcdull, 0xfffffff500000010ull,
                0x0000003afffffff0ull, 0x000000000000000eull};
 
 v4di gather_mem[0x20];
-_Static_assert(sizeof(gather_mem) == 1024);
+_Static_assert(sizeof(gather_mem) == 1024, "gather_mem not defined size");
 
 void init_f16reg(v4di *r)
 {
-- 
2.39.5


