Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5A8C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcL-0003ad-BO; Fri, 25 Jul 2025 11:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbt-0002nI-AI
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:26 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbr-0002QY-II
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:25 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so4117176a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458320; x=1754063120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xoU3B6IrYuHWtrEFBoP8PgcM1/fxyuux+neEj88fAEQ=;
 b=NQaiGZVBoiJQD0PttWIPY5MMtnJl1+FxavETak7eZL3yX5X5nSA5PvdemJzgGb8i1j
 FFhvcaXbeleR7knVkfOEN/41dBQlyKzIh2BJZ5E8XDwAWdDGdnPn0DItbWJqDwKvZVg5
 48DYQ8TlO2GNTg49ZrA1Q9MQVApZzjpswQQyJIdFKM6/2Ta+HU7ZwjWgBGRl+weF3OJE
 cOIa5wClb79Ggp0sjdMVS3kgw8szEcunnvxiMZbdid09VHm47pu1+hyAApfPpgO09bJq
 SO9EOdlhNgMEQ2IRmXYLd1nuaqVQEDIRje/soUqfuIRDFytf3Cb4OVAi2za+3qbpDgQm
 Kfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458320; x=1754063120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoU3B6IrYuHWtrEFBoP8PgcM1/fxyuux+neEj88fAEQ=;
 b=kI8XAzzqeVCm7RDm+ZbFuZqHelvGGtkFxOrzN1f82Pkb4bzJU0NQWvFCBwGzUWKFsH
 qO2+RDFONNaQXuUGv7zVacXfRQDHTYzHfybJFvUnv0nmoxkM0B9pZfyKcZVtj7kBrBHe
 v9mkz7ixa/vE9sZkRDcUUzWvNfQxOCMU4wNsby32O/yz0JUR/bAkJHEHWu3Ixzh7OkOp
 4/PtF7YNkZkEQVKYpSlkLwrg6m8RdvKZM3+prRBgG5PHfg27cJ5lMvWAEzaGFxN3YudQ
 zlnpTwf+BhdKvt7qnIItJepdbMApvJ6kAkk5rmfUb/ycmlKNtVZsdUr/8aFICU3i9oB5
 gk3w==
X-Gm-Message-State: AOJu0Yw+VmSrWyjPjPa0O+g4Bb2QTkwJHPI4GSDZkiW1+oCW3e1o3hAx
 q2ae5GyZHfDyBBUS0sjELPwhxmNaPv704myHaXJunS6YdgmXypZaBa5o1dMMQA3EuaY=
X-Gm-Gg: ASbGncvc9iOo6pKdJGesPDIxvkP10b+C8Vi8rabNxrELRb0QSOrilz2t5x61EPInoOY
 wPb8Y7XCVGcyNKY1F18kPlCyAfNUyL+K9Gnh6fHIp7ksGYxK5AWdUHE2Zsq9nZSivsmCFTzqgh2
 2kpSypKUTYFdpjmjgAQM8XL5smCgAg4p0Ybu4pJlIJZ0dDCbHHcIVH5HvfRtg8EC77b+oRwzdEz
 yrpQdsL7hjYCrycrBfBH26Yx44V1Aa8JcWoI+oDId9HitObJN1fs5J9+4Q9Aq5CA/So4oZ/hENQ
 bj99Y23Y88G3NCDOVi9b+KIvYUciKroeGVQfwvETzgQTMwu6/P9zb1Oloxa4UpBt5N7+aPk+Pta
 XxxPu/QVq5iPBv1BSAczMipqwxDeSSR6Hdg==
X-Google-Smtp-Source: AGHT+IESPAcQC5hk0L/kWZzNkIqZz0JHH6h0FndbLyRMPnvCwA2tc+6gIHBrT6WdNiW35Z/vuiTovQ==
X-Received: by 2002:a17:907:5ce:b0:ae2:a7aa:7efe with SMTP id
 a640c23a62f3a-af61a0f75fcmr277013266b.58.1753458319710; 
 Fri, 25 Jul 2025 08:45:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af63585ffe4sm10489366b.17.2025.07.25.08.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EBCEF5F845;
 Fri, 25 Jul 2025 16:45:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 01/14] docs/user: clarify user-mode expects the
 same OS
Date: Fri, 25 Jul 2025 16:45:04 +0100
Message-ID: <20250725154517.3523095-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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
---
 docs/user/index.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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


