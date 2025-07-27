Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203EDC87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwoa-0001Hi-JT; Sun, 27 Jul 2025 04:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoY-00016V-Cz
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:02 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoW-0000An-Rs
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:02 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6097d144923so7568862a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605176; x=1754209976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iCEyg3QtmaVOQTKiwCx605AuN4cfCmZflK0AhNrDjw=;
 b=DI48LvQxVwkMTcD5ak9+P8YyqPhUQPYhQVefInAlsDeo2FBj1aQMCKF8rIUYdDxVNs
 4ZJybKfucZ+5dQ5E/9wXhpaxTYTWKaYEZoNiiqTnr/eIVNKVprFfFohdxeq27w6oQSVF
 BMIYa2+vJO7YlGSWea9czBlsRycT3NO1Q/o2WSlH64j/EQ01YhK5DkFQcmd/LKQFxYBJ
 e0Jb3hNxQB0b7A9JYLUCACWYUFvfPi/2dYAV5z6LWSkub1aU+PVZoCc+7XLMegQOrkhn
 plVy1M5IJafAialOz3z69cGcBZaF1d+VbPehYu00vJAhpHyXLtm27L3IU+PGDdg5TpmO
 +qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605176; x=1754209976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iCEyg3QtmaVOQTKiwCx605AuN4cfCmZflK0AhNrDjw=;
 b=CSQMprw8MMU/TuuVog2uBJpjknnxXjLNhxCE4FK/TA/bQo0DvyHffC4wgH4LY9IXth
 1K2d8bwGXWTAh+9d5dMy+wJ9IOrTMUDAvvieykRuzeKbIersQCBZDWuBFXaHTD15zn07
 SmmU3vF1UBgEQH9qAPRMAq750rZUmEceolE2eNkLpNfQpx8CqTabm5dUq3Vi1uHbt6hg
 XtjK3WvsXa0IuhA9Ea8xesXwggtAVyleTfTNgXaakHtzcpl3wLSsY6VTzHbn/R0/S82O
 EfhTyTod8jz9p2ERtliy9XnzxLzHerq219Rgr5vB0+iTCOohrJQfhJPaJiwH1RBiCRRN
 3EqQ==
X-Gm-Message-State: AOJu0Yx8w17xJbvHRLnSdR9ad1xsB8MIbvRUOyUMh0WKE3k/M1DKGs/d
 lvC42bz6BKtVIZVnTJ63xD5qqWcjRQr/1N7bKKU/gTZos6vIpkbAvr+avRqy5v3VnQE=
X-Gm-Gg: ASbGncuw88VtipAM6kYB1O4FMuYWP7xezg/LcAbNZP0d0+xkYfOVonxtHPuFh1t2xHh
 IgZHn9iI3ZUW9RzaakrSYfOYP6Y5hNDHIGTiY36pr2T6EUhwcRadqnI0EeUUGf7gSGjQ/jYXtL0
 3pocC6niAJ22HsAo2j4GoqNSMUWA+T/denw1c/cqrKfHPXLzIwNrHYus91fN8lRb8A/FxVTVmva
 bw9P2Fw/SOtEKZMJXw6IY15rKd5MxK/5bcjsGmh5z3bR5eHhtoUEhyYaSXdiCpN/mvnVPDBXEcl
 FZUnNGmtZ8yfmxYSqytIpg+FFKSIxt4SEUGlfEuVfDivqsIaU9KO2ziCpzzg0gDWqNhqNTHgtc7
 OdbsnqAdUUHXqMZcD+9s+Tyw=
X-Google-Smtp-Source: AGHT+IHaLqRHbk/3yNycK0qL3RcGkc505tSdIVezGRkMyzLs110VUOoB6j8Rtv2qQo1elBJhqpssQw==
X-Received: by 2002:a05:6402:31a1:b0:60c:5853:5b54 with SMTP id
 4fb4d7f45d1cf-614d1c06a2fmr8936646a12.14.1753605175923; 
 Sun, 27 Jul 2025 01:32:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500aedabfsm1775300a12.60.2025.07.27.01.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:32:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 30FD95F876;
 Sun, 27 Jul 2025 09:32:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 01/14] docs/user: clarify user-mode expects the same OS
Date: Sun, 27 Jul 2025 09:32:40 +0100
Message-ID: <20250727083254.3826585-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

While we somewhat cover this later when we talk about supported
operating systems make it clear in the front matter.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-2-alex.bennee@linaro.org>

diff --git a/docs/user/index.rst b/docs/user/index.rst
index 782d27cda27..2307580cb97 100644
--- a/docs/user/index.rst
+++ b/docs/user/index.rst
@@ -5,8 +5,9 @@ User Mode Emulation
 -------------------
 
 This section of the manual is the overall guide for users using QEMU
-for user-mode emulation.  In this mode, QEMU can launch
-processes compiled for one CPU on another CPU.
+for user-mode emulation. In this mode, QEMU can launch programs
+compiled for one CPU architecture on the same Operating System (OS)
+but running on a different CPU architecture.
 
 .. toctree::
    :maxdepth: 2
-- 
2.47.2


