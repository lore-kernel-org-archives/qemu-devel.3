Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97588C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcm3g-0004pp-VN; Tue, 28 Jan 2025 08:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3b-0004hQ-3t
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:55:11 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3X-0006pf-Fk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:55:09 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so65060095e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072505; x=1738677305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggA0ewTkbOxosT43tBc3qZcSHcVtGttVuRMmEBH4Avg=;
 b=WNL80UOtDKMK4bCUSLNrd/AYAhOenlo5JlXmmnioR8E+j6/jUUnFVnVYrSk9csppiZ
 aj/EBYYv1Zws59vqO8QVFIPbByB66J154KogXoYg9vhMlPFku1afiR9qDiAzuhGboqC0
 J2MphyOusLUGVd1WmznuydhRT/djd8JHe14tmAr4LzJ03aC/A/wpsc/7bv2huJ5uiJ6o
 VaFVKTu7hJwaclyxmRQczIlxycau3o66gRzHfPjIV0OQgy3REFW2L3c5F3Mi+Ewh529l
 rk9fNyFAwugTdSZ+0j6QUIwwTVow/uLJnftVjlUNn0H5Zm2kfqfAn8cryKaiSumhzeCv
 q75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072505; x=1738677305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggA0ewTkbOxosT43tBc3qZcSHcVtGttVuRMmEBH4Avg=;
 b=udJEv8QM5TR9YHtDlJI4ChCLp0aavf6G9/7kTd1siCXQ19VimhKH1PPA9g8szDDgbK
 9VAc0Ql0+3keUA0FO3C0HgJh/w+KQUgWsdNwwpdYNDzv0JwH/0SBAOj1ZVKJfj4QR7xa
 te5U6/CxN6WDDwXhZpDkWv/Och9blnOnouj/QCV5/ZuFGX2znF6cbleZGGlthohDQkcw
 QI3uXh/gh4u7t5njmkVIU8Ur/bsLEuDiPgbsafIQHcKKqmLI8gxU/X30razZwfS6dE2v
 PPNY1MmP1n6UPIW+hfYEylqJixUnXY3O4m+QxzJw3KVzg/RKfxK7mPGGd1NdFHSUN08u
 S3Dg==
X-Gm-Message-State: AOJu0YxW9zFem1SdvMrDkRAQjFePhfDMSYmhkKNXlmXfAGsUHAjpCSyE
 Al524M8+YcJkR3eUSozMOykMjgVrxKb2Mhps1yHRIecXRvwzZeAjuE925SobNxT0hAMqF7ZZip+
 EhiE=
X-Gm-Gg: ASbGncvyIfjybDA/CUsFNAS9KngjDWU8idV0YcV1fbAEEnlsQwi0XjLJqsmhVued76+
 qnlsk2/KjFEYsEwwpLwJzkQAhQFENql+d/amPFnTcGi0fjC2gwdNN0Ua91DafCh8VtrjykusXuh
 da8N1HUNmMku8bI3mrRWzFxmBxeskIsFYVrLkjbwk6zcQTWFI88T3pjzaGOGfSFjfEB3poKiaS5
 /9DO0vibEmnvujHOwaCny6E9ZXMbdFIIhvWm14d0JPM0XRLta2I56+H9ZvGdqF6dDrKsSoO+enS
 2UF/pRQ5IaYK9HcOdMFHRUgvYeAZ1J3tbKjfKvTFKVCvwWyZpp1YExra+GjA20jzmg==
X-Google-Smtp-Source: AGHT+IFAivnCEuWa+s9CJzyy+us9FOYQbCNDZooO1DNzx3Fey9h77ZbMevgirnagF4Rvye36WUD3Ug==
X-Received: by 2002:a05:600c:4fc1:b0:434:f218:e1a8 with SMTP id
 5b1f17b1804b1-4389141c21cmr359787385e9.19.1738072505153; 
 Tue, 28 Jan 2025 05:55:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd573245sm170550175e9.33.2025.01.28.05.55.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 05:55:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/7] tests/qtest/migration: Allow using accelerators different
 of TCG / KVM
Date: Tue, 28 Jan 2025 14:54:29 +0100
Message-ID: <20250128135429.8500-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128135429.8500-1-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

There is no particular reason to restrict all the framework
to TCG or KVM, since we can check on a per-test basis which
accelerator is available (via MigrationTestEnv::has_$ACCEL).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/migration/framework.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 30808de14e0..e5f0712c266 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -950,11 +950,6 @@ MigrationTestEnv *migration_get_env(void)
     env->has_hvf = qtest_has_accel("hvf");
     env->has_tcg = qtest_has_accel("tcg");
 
-    if (!env->has_tcg && !env->has_kvm) {
-        g_test_skip("No KVM or TCG accelerator available");
-        return env;
-    }
-
     env->has_dirty_ring = env->has_kvm && kvm_dirty_ring_supported();
     env->has_uffd = ufd_version_check(&env->uffd_feature_thread_id);
     env->is_x86 = !strcmp(env->arch, "i386") || !strcmp(env->arch, "x86_64");
-- 
2.47.1


