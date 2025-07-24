Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF11C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetg2-0007SZ-8L; Thu, 24 Jul 2025 06:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfy-0007ME-OI
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:51 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfx-0007yU-1g
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:50 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae6fa02d8feso127277266b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354787; x=1753959587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaXIy0TZF7Lx3BTxPvhSWMcsUAYvvaGRMj44TBqIZqk=;
 b=r3jWisgxjaFMLVX5uBjaAoAKWNlq8N4yb0FHvAws334RtAAiEQIOHC8b5rszlFesdf
 Jo+BL1nU1OfRKKoFuX/qkFZTbNVr1HNuuE5zEgEriB+9nYn0p8/CcHm7w7UFMQxQC6XA
 SBhQTx7RMSd1JvqUAFpAW1+DuXjTjQsjSABxcyRXGwW2o9euS+/lbmdaI2+aShIkJYCj
 QPwysBU3oCdWQpd/yfsnNSQ7voPx33L75TOcDA3doGavTtupk53bV+mkxicQOxlypubk
 dgL0JqrRI21d+zQD4INK6zfTLy0zcvzykwBl0XCLdWFd/lFCnyhbCYutxX627DClJDjP
 4rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354787; x=1753959587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaXIy0TZF7Lx3BTxPvhSWMcsUAYvvaGRMj44TBqIZqk=;
 b=FvpZSRvgX5C5Wv6k4h2EoK7ldUOyIJOUSvHXwn/3qrBg14NNvzxfhH7BANbOpfpBY4
 SbHj4gZaIPc0oTW1C2cc6SpYxKP22ZKSgGcJudDhw/Ew/nBG8tx0tOoxU0ACDH+GIWnb
 /UUhuQ3oWboyGDCx8ku312PJb7IT17SxLWOzTauoNH+p9zUPbANq7wSs0kazkj02RXHv
 AjN94NIVS737dcLJTc9K0mghPvmYxCzh5U19FAxNwttKQV+WYVkGjUfGOAbbYrwrY/mj
 2GFcgCXL3q/BGnQkByz+SpTrUWTvcr0tH+ulboAhOHl7xJWq20VNEwrnSizJpZ1OAPpm
 jMnQ==
X-Gm-Message-State: AOJu0YxPeQDYB8UEhj75Ar7YpVE+6GjpJZulMbMmhGU0srzVzRPY9Jkz
 YxGpPlYfylOFIGU+imPR2iRf18SjtqM6FPOEHXuQ5/4s8EwMqZFe4dcwpN7d3Z70ZkfrntQbXEw
 FP1yy
X-Gm-Gg: ASbGncvNFgQiIw9QJ0EUMfuc1ItuEjQlYPRNU+bJP5vX1PSzPCsMziDIlY0ulSjuAeB
 LzJmZMGDm12SQnC4YuGCOwL8ui9ofiXxf1QGHQy+YQOGtampDuvcEfuvYHIEY+5siewW4NPG8bC
 wuHVzT14lSstQNwEGXsb+IAp2Rmjdy826SZw/D6VCBZsbxR1lA5RoFYCl2Qe1dJ8MLG4zn2owOP
 qjsfXj2YVb6R30faxX8I++JorjPALQeAZ6ONGXveNIcpUy1Rl/bd2Rhh5lGpDMEwIR1TwWFXGRv
 uLs3l5EXuMk5s4knCTd+xiBs4oPMzHYKH1DZUXXqNTyDTM1t1PCRTvYKEzdVTOhgnNnN286DVwf
 7DOAASLF4qf04Cdmz+oFfPcg=
X-Google-Smtp-Source: AGHT+IHEL/KzwMmfwkKAQYbG52krYzWMVnXqh5z+AKsRTYQ+pRID5BrQvyv65xd+Ac2qUurttMdNxA==
X-Received: by 2002:a17:906:6a23:b0:ae0:a813:1bc0 with SMTP id
 a640c23a62f3a-af2f9270a5amr598668366b.53.1753354787202; 
 Thu, 24 Jul 2025 03:59:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47c58bba3sm97872766b.5.2025.07.24.03.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9BCCD5F8E1;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 08/13] tests/tcg: remove ADDITIONAL_PLUGINS_TESTS
Date: Thu, 24 Jul 2025 11:59:34 +0100
Message-ID: <20250724105939.2393230-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

We never actually used this is the end. Remove it to enable
re-factoring.

Fixes: 7cefff22d54 (tests/tcg: add mechanism to run specific tests with plugins)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 3d96182a7b9..97ebe8f9bc9 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -169,11 +169,10 @@ PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
 # add some special helpers the run-plugin- rules can use below.
-# In more, extra tests can be added using ADDITIONAL_PLUGINS_TESTS variable.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS) $(ADDITIONAL_PLUGINS_TESTS),\
+	$(foreach t,$(MULTIARCH_TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif # MULTIARCH_TESTS
-- 
2.47.2


