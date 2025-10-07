Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B940CCD185
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Ik-0002dQ-1N; Tue, 07 Oct 2025 07:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IE-0002WA-HQ
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:48 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66I6-0001JI-8p
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so1009740f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838134; x=1760442934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hh5wO1RfL5KSdXJKuGPnKWIJ/aE4KakJ9tCubA8v3Y=;
 b=OhTbI8Ke7WF7W1pDYjTXJC4QSZJb85D0txKjZuK9ePdJ/TFoEzNwLVWX1Q+qr0U9KW
 9mabtHE4o7TatMNyUhL8+pOFqIzJ7Rpc8o2l9J8rL40pMY8KkiRwQr2+P+aghV8/rzsk
 yZVx5CUJAXbVw+3Drp/P7f7Kx//SOuGVkgtjADOXZjfQSR72TZ/R39Gb7+B46Q/eibWS
 f8biATCe+x0mr6mY5YtQUUY2cD/1sH3A4irKbqiyjW+x0+MLXAVhz5raPtV6RRC53d4J
 K+LjKXgS7DPRmq9gzPSebqLIpHUUbit1ngyI4v1I9ru7GljpLLAuuEep7BpFRs1RGjfu
 bTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838134; x=1760442934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7hh5wO1RfL5KSdXJKuGPnKWIJ/aE4KakJ9tCubA8v3Y=;
 b=nZhvPgiFk1StaxR+z5ooxk3HqZ9OL2AsloCJ4bE5NNgHdUFBhe1PQsX3kBVXmitiod
 DLnlutECA8ksd24dPiCHJ/CzZ9g4gLImEoU5IdyeRR0RVmIyIly++rvjbCf1kmr+K0Bi
 6p2vz4PBCR9B/WTB0p/atj5krANlEnk/umaR8ApfDk66fka/RPQR8xBK+tlP/nmCgTCG
 YzVwLrUpjf92ovsGqc0sWVCmkDhDArGTR/83I7e4MfYmXv7IhomTq20voY3UfROYQPPF
 e/50j+kCeE0bnIxJfKikJxvIiLzHMN3sNvJB2kWrKMW3WVOSBlYPjE6dYzqPrSm7m2HC
 c8TA==
X-Gm-Message-State: AOJu0YwSVtgPyCC7pEZ1sPmNts/fU7EsojOcYXUTCkG1k8XBXbX00mk4
 a3ekdZLcLsVm4a1CvCj+oskyZAoW4XS6w+hA9Z6pVkEopKlcTjzr44oTQqO4BMGM1U8=
X-Gm-Gg: ASbGncvG++DZR3EBP4V/VCAa1di0Slc09V7hrbjUEgVhZk2lZnWD9RyI51QfDx7t2rp
 zxm81uCZIQEuI1SZPVcbGMGK5oePT1uiSAmRLD85U1w8nz4ALVzEKUzEauPvW3tMmyjmTKjoi1T
 3QOBITFFUdQ6LOV9PAwizD9RHMJEoHzOFUuqJHpfuqargAbWvNSw4n/HDeef2/IhUon6y7eddK0
 UbjBuRJUUScPTDWGlMbU2DtfJclfBKYbKJAq57y5PDsY2sYsXUpfWs/HyDmjLOl2KYGBefQmik8
 Pn3kAeln0ok22TJOuzJCoze9Gsd6fdBHVCW2Yp8TOnfSXbStUCARah3erE5wsPUX7GhJXtDRm6z
 ZYKQ7aUXtou9HimvENCEdYTnu90aNl/yT3DHsj+ZzoLF9C3rsdcZI6TqV/GyVkw==
X-Google-Smtp-Source: AGHT+IHElV+OAvLnVoNxqZ0u9sz1OZL7ZULJNRCFoQWSm3lF8kgAKLIipIKW/JTh89J9PQaBmQA3lg==
X-Received: by 2002:a5d:5f94:0:b0:3fa:2316:c21 with SMTP id
 ffacd0b85a97d-425671520a9mr9597353f8f.17.1759838133615; 
 Tue, 07 Oct 2025 04:55:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72362344sm205743565e9.15.2025.10.07.04.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A9F8B5FCE6;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/17] tests/functional: Re-activate the check-venv target
Date: Tue,  7 Oct 2025 12:55:16 +0100
Message-ID: <20251007115525.1998643-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add check-venv target as a dependency for the functional tests. This
causes Python modules listed in pythondeps.toml, under the testdeps
group, to be installed when 'make check-functional{-<ARCH>}' is executed
to prepare and run the functional tests.

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20251003141820.85278-2-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 62a4fc8ed31..e47ef4d45c9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -105,11 +105,11 @@ check-venv: $(TESTS_VENV_TOKEN)
 
 FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$(TARGETS)))
 .PHONY: $(FUNCTIONAL_TARGETS)
-$(FUNCTIONAL_TARGETS):
+$(FUNCTIONAL_TARGETS): check-venv
 	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
 
 .PHONY: check-functional
-check-functional:
+check-functional: check-venv
 	@$(NINJA) precache-functional
 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
 
-- 
2.47.3


