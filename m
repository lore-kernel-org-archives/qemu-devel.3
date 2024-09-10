Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A7FECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzPj-0004Ga-8H; Tue, 10 Sep 2024 07:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzPV-00045z-Mm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:52:01 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzPT-0006Xr-F5
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:51:53 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c263118780so901110a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725969109; x=1726573909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0tP38q2aXeMtCrKpnNgEUV5n804wzkdrcUKmPP1+h0=;
 b=kSnLSsrUEFdPc6I9xKqoTH3UFAbmoOGg6/0qmx8B0sCbxlOq3LxgcQEPezDDL6RWX4
 ph95tO6IDCDpPbcKty/8sgrM64YiL5HgSjkYKQfJwHCQHU1XKwQKDZCMqwfBF1JzSnET
 5kUD9ekLsCGakPwu3MOTD8r0kxURtENbYN3lLj7Bukroine2EV5hxPUVs4ftlHWGSsKp
 qR9HTrGOuFJAMyZd0JGmMtul+6MNkJtA9XUC/R2pscAHHDra0UkFsBv3Q+vrW+n5N4lU
 5wqzueLujSlJ1ZwVdTMqFSqRLf6akfHFIDXfeMHeKQz81K1dW3GmKLAMnl4Ptr46WAnK
 hdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725969109; x=1726573909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0tP38q2aXeMtCrKpnNgEUV5n804wzkdrcUKmPP1+h0=;
 b=ErLyRjefuObG4fvRt4M3KpEcu+VgN2QEG8MmoprtS8MkZeYrgOmigMPPHvPuMPdUgs
 jL0K+7outKHXbusSt1NhpWl/Su+u9aRSYISa9StZoTwh5liIfVkoJmfYQpOy/4PlK18s
 eE5F4b4mUNOk+FoXFHtDxwRPMSfo8FHrKSQNMV4kpaEEsyEZXqxmI+Qo0Va6E7cg2edI
 Qninq3hB2DrCYzs2KBpXydy8U+Ltz4AzCQKC1Gjzh3BA4H27zJkf+o18a4O77Ubh3Mn1
 ojdHnTeSRPYQMd0E1F7CAlAtGwLezEytcfOxeObbG0m6lhBfiX2ZiiGLkmquvf0b3qHt
 ma1w==
X-Gm-Message-State: AOJu0YyMnNUnvEgc5QQoELKuUgEuJbxeY8EbxODsgPSVqTF//22mpmTr
 ATGnSyH1/fM31G52bWmR6/LW4vX6KzeN9ClnULeTtJldRNHpu5ed3Q94ldVdu+tzDXweHvEZtgK
 K
X-Google-Smtp-Source: AGHT+IEzXBUCDbooUfQmm1Y7MsfG8eOhWmJ4LhAsjX0o+QtCoHa6colNT/ObDxaXfyjiD47WeQWfIw==
X-Received: by 2002:a05:6402:448a:b0:5c2:632e:fad7 with SMTP id
 4fb4d7f45d1cf-5c3dc7955famr10749585a12.15.1725969108435; 
 Tue, 10 Sep 2024 04:51:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8cc33sm4188219a12.87.2024.09.10.04.51.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Sep 2024 04:51:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] tests/functional: Correct typo in test_netdev_ethtool.py
 SPDX tag
Date: Tue, 10 Sep 2024 13:51:28 +0200
Message-ID: <20240910115131.28766-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910115131.28766-1-philmd@linaro.org>
References: <20240910115131.28766-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Cc: Alex Bennée <alex.bennee@linaro.org>
Fixes: 9f95111474 ("tests/avocado: re-factor igb test to avoid timeouts")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_netdev_ethtool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_netdev_ethtool.py b/tests/functional/test_netdev_ethtool.py
index d5b911c918..ee1a397bd2 100755
--- a/tests/functional/test_netdev_ethtool.py
+++ b/tests/functional/test_netdev_ethtool.py
@@ -5,7 +5,7 @@
 # This test leverages ethtool's --test sequence to validate network
 # device behaviour.
 #
-# SPDX-License-Identifier: GPL-2.0-or-late
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 from unittest import skip
 from qemu_test import QemuSystemTest, Asset
-- 
2.45.2


