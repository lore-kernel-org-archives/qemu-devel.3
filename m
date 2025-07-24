Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C826CC87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetg0-0007PT-FV; Thu, 24 Jul 2025 06:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfz-0007MT-Ip
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:51 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfx-0007ys-Uj
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:51 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso1742511a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354788; x=1753959588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8ifgoqJl46kaAOZCsjI2tusnIxeOlRnTj/nT2cjUH4=;
 b=QvtBqUB2CpHKxcrHlotXX/H63K73Wwz/Zr+EeC1/PWfpLO4CYWRcXXk6PymxEpisln
 I4jZqi4mQewp5xW7i7pQCQuGCV9I3bX4/efyK3OHsIKATQ5CVab4vvl9CB4WKz9rkQa1
 F0KEpGvgrvipLTgeYTieAuCWAVznsHM8LJcropWl/QciyTgZhe8BiQ7xsKWhx4FFpJ8r
 dr8r97DoSrzmqpFH0wTJnW+DpnQIB2r6yNXwHSn7pCrbXnJcy7mgRlcsr/NnH0KXRUzC
 N3/0B8Djw4eL6krEhntcTNMTkMRNF6PyN6LcG2PNeXUckQ66HOMoqnt3Fg0J/rIF+x8F
 uWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354788; x=1753959588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8ifgoqJl46kaAOZCsjI2tusnIxeOlRnTj/nT2cjUH4=;
 b=J/QJwbh21QEGB/ahuTDU5s6Rcd49oFuU4uRVgLsnaRI49fMO6O6Qb5HfmKmGrf2Isg
 7tuczuMo3PDEs5IryCg6Rnr6yzo7+CDV0Dkfcqw+yMyK0R9Bd+mX8dJtZ36UwO823FDy
 lm4YrfH/bQrvn6OABuOSBMyIS9t9umG9Yfmu7guUFlbg8NEAJNBgkLT4rJhGGQEvbR8c
 351IDzQAdsv4yPw/H/ejGaDi7s8fmKiLN0No9cv0rtYbI/5XH7IWVggCw5lfYuHtNhS9
 b6PlQWIwiiSfcRuY97D5WvHg9yK/0n5St69NElwB11BFNZcQ6UTa1o0KMH/OZM/uH2Vv
 3b/g==
X-Gm-Message-State: AOJu0Yzw5/CaUt6OvF1x73QHJ1/azGnTxJ/Du1p2QeZZzNxGm2PFoqjv
 nH0GHgchV0as+aJ88yuDiGfNFj5lmAdMPyg8v+rNVxVyrFlGX2d5Uj51RZvdCepAgIE=
X-Gm-Gg: ASbGnctWt439VN0fig4R09kofS8C0wElw9oJCeARCmt7PHlNKwOBZNErl2kIRc9Y1MM
 0Wg9Hn+xW2KtJSr/qoyvs6EkuHimF16gBK5iUwi+qMVCY14wkM35s1VuZgwtJ9JbC8mP3CG5bbQ
 AZ3ZwlKYCYLOczUsEeTY2vSmTOl7lTb5/TBRZLIbhjJT2dzvfezNPq+fpJAyTCToXVCrU66syhz
 StjAMgnKFLscjfAAiMcrYyH+sTZ7uALCJpxg1KhfaGl5j+TAB4NqCtucFB2XDB0zy9KkjAE1viK
 sZKFxsbTXU0vubsJ6PMlJ4Dr+yZJxYwav0Ry9p1x/0rq7TlASEG63B0//LsZuMAlVuCTQgNB1nJ
 A1q1jImVWZu7torbbWGhg1TQ=
X-Google-Smtp-Source: AGHT+IFmrn5B6diiqWjwoT+AtJQCk+el2qrPXLFe/JrsuNqtsh5V4FdudtodexqKU3vhY7wu5cBJqg==
X-Received: by 2002:a05:6402:2712:b0:612:b552:5a36 with SMTP id
 4fb4d7f45d1cf-6149b43324bmr5903606a12.8.1753354788072; 
 Thu, 24 Jul 2025 03:59:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-614cd0d1ba0sm705678a12.11.2025.07.24.03.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 89C475F8D5;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 07/13] tests/tcg: skip libsyscall.so on softmmu tests
Date: Thu, 24 Jul 2025 11:59:33 +0100
Message-ID: <20250724105939.2393230-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

It isn't testing anything and just expanding the runtime of testing.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index af68f11664f..3d96182a7b9 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -155,6 +155,12 @@ VPATH+=$(PLUGIN_LIB)
 # For example, libpatch.so only needs to run against the arch-specific patch
 # target test, so we explicitly run it in the arch-specific Makefile.
 DISABLE_PLUGINS=libpatch.so
+
+# Likewise don't bother with the syscall plugin for softmmu
+ifneq ($(filter %-softmmu, $(TARGET)),)
+DISABLE_PLUGINS += libsyscall.so
+endif
+
 PLUGINS=$(filter-out $(DISABLE_PLUGINS), \
 	$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
 
-- 
2.47.2


