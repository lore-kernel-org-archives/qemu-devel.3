Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11F7C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVo-0001mA-4p; Fri, 05 Jul 2024 04:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVD-00008P-Sq
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:14 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV6-0003GR-OU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:10 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-58b3fee65d8so1748269a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168862; x=1720773662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiGk7AOsQ7y9imsMVDdBn97JRYhfShbL95x+ZPjiJBo=;
 b=p/3gBxFIjh80qa7vlvJ2cJ+1QGonFr8N5Cg7WhWmErqugR7NAywRVRqHuAcnBtZ/NP
 M13O/i9QCWfxyPAMh0kyZ2qhZn+as1vpNDr2PWzVS7sQBCt8CtmvICOFVKl2CJ60hF+M
 WPm2pQlkcUeU8+jSB1NmrdzO+FcN0DDi0K13CDrqXEw8622YLgp1zEmqtQ5msMvUVSwl
 q7ObMAQFltDsOUoYkKIjuma7G70VlAFbzZ6g/NBFEYZs+JxwV43EB8ly41eKMMIhB6cq
 F8mKYcjPJxyRFcCsaB4JDGEhMlO5j1KBjSTtv1y2xC1/j0Q9A6mXmZWrYZfrFzZ4Kapx
 aUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168862; x=1720773662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aiGk7AOsQ7y9imsMVDdBn97JRYhfShbL95x+ZPjiJBo=;
 b=cwb3E8b3h9qk4GrJDAH4ER8n1UQA43QXLWvPDFeMOu3866XMcjYkV5GmGGO4fF5X+a
 sY0zIuj6J9K++5zveWZrfAphe8UG2GVATR9D0gK9nGxpvf8Epk4W/cA7O+3MXI5K1TCD
 LWX3YuPqhtM9nOP90+e4CVNS9AKXnROAtpBsB7uQSvOz2aeA3NZbwxmhryx01wN84cmw
 k9tVgVSF9AvOXjVRWTYki9LW+e+4Z70o6YSK9o8H00UcnTfcoNf3EO9wp+nK0yO7ydYQ
 HdoStL12rIbMuPPUjz2/P7Rf0tlktERGa7YO72LY3Ys+y9zx/i7EHatF1+uHVv7aQx7V
 c/vQ==
X-Gm-Message-State: AOJu0Yzy07tFqDEdQhyHTRIakVrWtd8uiKeLvAv6cnuhaCioytrBojfN
 UP5LLcA4x4SKr5lFTdpSPu9X8ZZK+isVi1ATWE8dBpZODjeCpg9ro0uoI7c0mQA=
X-Google-Smtp-Source: AGHT+IH/B5mhOwdoz/raCdw2lG4JqJQGZOlNY8IvR/VgEFCYLeWZ3CaFIZVAp7CRKfwS8WiD9AF0Ew==
X-Received: by 2002:a05:6402:2548:b0:57c:610a:6e7f with SMTP id
 4fb4d7f45d1cf-58e5984c803mr3243200a12.11.1720168862360; 
 Fri, 05 Jul 2024 01:41:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58d0bfeec43sm3091667a12.48.2024.07.05.01.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 609A76211C;
 Fri,  5 Jul 2024 09:40:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 17/40] tests/tcg/arm: Use -march and -mfpu for fcvt
Date: Fri,  5 Jul 2024 09:40:24 +0100
Message-Id: <20240705084047.857176-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Clang requires the architecture to be set properly
in order to assemble the half-precision instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-13-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/Makefile.target | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 95f891bf8c..8e287191af 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -29,8 +29,8 @@ test-arm-iwmmxt: test-arm-iwmmxt.S
 
 # Float-convert Tests
 ARM_TESTS += fcvt
-fcvt: LDFLAGS+=-lm
-# fcvt: CFLAGS+=-march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
+fcvt: LDFLAGS += -lm
+fcvt: CFLAGS += -march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
 run-fcvt: fcvt
 	$(call run-test,fcvt,$(QEMU) $<)
 	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
-- 
2.39.2


