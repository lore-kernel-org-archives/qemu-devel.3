Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8D8E7DF0F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmy2m-00057B-OW; Mon, 02 Feb 2026 12:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmy2j-0004zY-R1
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:48:58 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmy2h-0007Q2-Ks
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:48:57 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8842e5a2a1so681582666b.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770054534; x=1770659334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7C8vP99/FDl7HG2UzbPL/Ufps/3hX9Cnm9WVnskDmyc=;
 b=P9FHEUqjzhnNyNY7c6X4FN24/hWafMb7Se0m7XjK7wWDp6EXl4PUw1qCLeYZ/5miSw
 VSKj16E1JTFUA5bnAIFN/YaAjJOF9/XdGwX1ydb/7EN435Ijjb8lmbWjbjdQR0uYGjjy
 cF7rP8JYtb4SfnGIiONwjIrx91tS404k0DURyfYFMKS+/o45m/lX5D/ZyvIetosF5K6N
 /eyPH2KhzKncwoNCqsRgSvmiVPzTg1ELjW8F0LjYyUt8xtIyl4VjJ9wfigy47e8fI9EO
 jaRDuueH61aRZZQ6mwIZkhqWIFz+fHcDwjHs2gcjpoGAj94Him1F6AsR0M68DPo7g7Lx
 9nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054534; x=1770659334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7C8vP99/FDl7HG2UzbPL/Ufps/3hX9Cnm9WVnskDmyc=;
 b=FH/GGy5Zdwb+H3V1yPT0FQ2oDSv1y4o37etMZaIpUu3JtJeg2uJ6EFJco/LaCZIqL/
 htqQbIkqPMFJC5ZFDoZRKVykYh3jDLzz3ooh1Y0ADWwnFPIq6w0LD0pLyA0aZAW9LWh2
 oc77w57SwYe3GJVFnX3wocK3w3EoYv6Cs8fW1599lo83Ad71Pp01c3/JUKhR1ar7vWlm
 KA2LjNSkF5X4not9+NT9VMXW0BEniqMVJeFjKhy9ocFXCsHjKMoSzdG+A/Hhm6bFeuy3
 TAc39DpA9A+0MwSQaT5s0NVj8+ArdqdC4KZrTQ0T6T63kqPh8xv1P0GmLoRHLpiB1JCr
 2w/Q==
X-Gm-Message-State: AOJu0YzaBTF4mCsgI9YVwMieg7JBvMt/bhXU2HKtDi6BF17n+dwWKE0L
 WBRHzBm9YmjUq3hckR9dPiRuoYdd1BBrfgBi4uIQKWJxG3GrI0WglxH5L8PAXvVzFHg=
X-Gm-Gg: AZuq6aLWKc3lmpaN9/qw6wgn5plvyrchx3vvlS5kU+J97B3qjO+r2Lrg/GgVZmbjPRH
 S5gx0gSgHviypX9eBtugiEwvxIdZPxKCzNPFg5Wpy+nEZKzig59CsDOedwqusa8d3CGlstIg9Yc
 cJo7t7xcrIEle3YkKIcZXK4fZjjMbVpPdShrx6rpX/XD3PCPQckHPkE+zpLj1mNXNGGA9imn1Pf
 BuLyDMY4hDVkxfNUpcxTbXP2Kg9XCWelTPMjeBON2TN84mdS5F7mwhxDRWqgPqbU50l7vOxH1gp
 yFZmrm9gSiDYK07Yie+Pl724NCTKNQn6IPi9RfzYC9JbQJBqmRWUkK0XzYmVM0D7GsUTjfu4H8x
 VDZ2BnGMjruJrWfw7dRnjPZUmh8lGvYKCTYjQIXmLA2vie2eFxCOHO+ufiLK4rRHOqfUCNCVED6
 L/kXm55hkXk17C4xmAblvQqw==
X-Received: by 2002:a17:907:968c:b0:b7a:1be1:983 with SMTP id
 a640c23a62f3a-b8dff8071femr721571266b.63.1770054533621; 
 Mon, 02 Feb 2026 09:48:53 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbf2ed6f8sm898616966b.65.2026.02.02.09.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:48:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 02B005F7D8;
 Mon, 02 Feb 2026 17:48:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH] Makefile: add python script dependency for
 meson-buildoptions.sh
Date: Mon,  2 Feb 2026 17:48:49 +0000
Message-ID: <20260202174849.1949691-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If we update the script we should also make sure we regenerate the
help text.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9fb55dcf330..54547a37b1a 100644
--- a/Makefile
+++ b/Makefile
@@ -130,7 +130,7 @@ Makefile.mtest: build.ninja scripts/mtest2make.py
 
 .PHONY: update-buildoptions
 all update-buildoptions: $(SRC_PATH)/scripts/meson-buildoptions.sh
-$(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt
+$(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt $(SRC_PATH)/scripts/meson-buildoptions.py
 	$(MESON) introspect --buildoptions $(SRC_PATH)/meson.build | $(PYTHON) \
 	  scripts/meson-buildoptions.py > $@.tmp && mv $@.tmp $@
 endif
-- 
2.47.3


