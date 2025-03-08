Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5460C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr275-0003L8-T7; Sat, 08 Mar 2025 16:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr273-0003J2-K1
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:41 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr271-0000xD-QN
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:41 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3913d45a148so594003f8f.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470818; x=1742075618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/rFt/QJLuWh25zQpEuk3M1G9rXxDyCO7fkiaWwlgSTQ=;
 b=mUoJ3EBOZzMFLrJEF6terg6MsJmZCXKoIE3DXgJQ4ZC3BfHryUtVkbQmyg0B6qaLp7
 VboFx0ZqIPUls3OvVaHrC3PQeWMDUytkGGU1ysu8uaSsCZRbEXdArjebTSUSJg+OIUf7
 kwSSfFhe878B5HmRUAUIP8iKC1KUC/ScqQbjcPX7sTA2tzTVr4nGDibvmdHUpLJQN3tx
 gjAaNVUOkTdqaSoULw4BzqgTZ9G6BkwqpisTI8leKSAJTdGc/Az8jLjNpcWIj+0VcD19
 7Jehab/nhwsAHSvNW2hCTMs7U4eEekh/fn0n32KkXGBjDOxIwVYcoti53ihaqPJ14Pbr
 C5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470818; x=1742075618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/rFt/QJLuWh25zQpEuk3M1G9rXxDyCO7fkiaWwlgSTQ=;
 b=l6pZwnT+NDLjFw263TXf2XB6nChL4h7UMj1VRA9ivZp10qb3PRNmiR2U8Sa0ypdVWy
 BkhVOr9B0XJIfsYhJQYMHMg232eWxlLHofXBFyGXp1HlaYaKOUEu0wq2enTtj16+8tgA
 zszNecY6rE1H1Ls39RY06bwdS7uFK2ShaX7DJkmMDMnCkZ3ziBrdS4YOyhgjNySLYi1P
 0aDXj1XdN1GFbzI5d1aaRr+LFnV+Ct47EICvLekNbIYDSn9otGgrDzUaBwDPDKvCoHR/
 l2VhbNf9jfGQYH5VwuPobal3KEi2OLVMEe8VH0Gu66hJ1gJzcO7+ZGhvWr771txtNN1D
 +wMg==
X-Gm-Message-State: AOJu0YwuEM9jJMSAx7OiVDdUe2T3WO5tcYtVMn9ih3AhFrnNCaDI/2nU
 X+eyPl8NUNIKK9rotacrlNNHd6sxyQeWt4f1DVmY/wmQrFbiCGPw8oTtC+lospllKg6JXyOxIPD
 e
X-Gm-Gg: ASbGncuNgyUuF+QsHtJ2/ufu3mM2kEIqhgp//IGvjzam2tNHjPlMtSQMiZSoYmBrE9L
 +H4ZC5vMARAV2rrFEIsSUiJZeMXmSg+AKvzFS2oRD0kV9oQ+xPa47ZysrygN0Kv0tgh1QeSw53D
 wSw1LYA720iZ+ANjBeEX5orZNQ4AKaR8JV8EzGkPbB1VDDYcwfRdAok6lOkmEB4x0BOqQoNv/2B
 ONlou5kZO4e/1j0ioK9ABW77Vn3xd0rqg7j1nCMbHXb0LHVfymo2W9UGZlxamv712Zishp9woLc
 b7qbK/tA9beoPhprMNXK47YNxvgyUiKYYh6qYZyviF13xc8=
X-Google-Smtp-Source: AGHT+IFEbvTgwTc8kjJFnGTDvulUcsSzcX5WaEtnaXlMw8BXIxY+qkZPbR8FIPv2ZEGhZ5fLArb84Q==
X-Received: by 2002:a5d:47c1:0:b0:391:2bcc:11f2 with SMTP id
 ffacd0b85a97d-39132d2ac45mr4864532f8f.1.1741470818313; 
 Sat, 08 Mar 2025 13:53:38 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01de21sm10077662f8f.59.2025.03.08.13.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C137C6047E;
 Sat,  8 Mar 2025 21:53:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/31] tests/vm: bump timeout for shutdown
Date: Sat,  8 Mar 2025 21:53:07 +0000
Message-Id: <20250308215326.2907828-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

On my fairly beefy machine the timeout was triggering leaving a
corrupted disk image due to power being pulled before the disk had
synced. Triple the timeout to avoid this.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-13-alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 6d41ac7574..9e879e966a 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -83,7 +83,7 @@ class BaseVM(object):
     # command to halt the guest, can be overridden by subclasses
     poweroff = "poweroff"
     # Time to wait for shutdown to finish.
-    shutdown_timeout_default = 30
+    shutdown_timeout_default = 90
     # enable IPv6 networking
     ipv6 = True
     # This is the timeout on the wait for console bytes.
-- 
2.39.5


