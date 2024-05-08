Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49136C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4d2C-00005V-M9; Wed, 08 May 2024 04:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s4d29-000055-Qv
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:52:18 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s4d26-0007eI-D7
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:52:16 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2e34e85ebf4so26572201fa.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715158332; x=1715763132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3SGXtYjHPhRPb+FEejg3JUt/LMp+FdVDAbFVCCpIL84=;
 b=PUx7ocJ6M+1uxbshIgeEJMPZIvwnzP4Ro/oQ2jbKYx/IXEBx5dAOMfWcM7koa0j0k5
 PoANJ99rYGw7vJQoMiteeCIGjrcxfQQ8ugQOWKO1I8VEXKZ+Rg3kii25koG6VdEQmt8x
 15ybzUPsG/cjtwpmHEa4TIxazA3AyoRgOOilfTIIa1557pAKscwcGX57geddbG9/J0pm
 SzrMp2n5x9VynZyLIeI9GvHyTB07YIUBYBzFETDPme3Cf9+Gq0k5Kj1uYuEfx+wVULzH
 BqLbBgvx5bDlvXHKvwtHouTftrUN57uHwOD1F+BX1FrpdILLr3h+mBBYEoemWNNu48i1
 fJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715158332; x=1715763132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3SGXtYjHPhRPb+FEejg3JUt/LMp+FdVDAbFVCCpIL84=;
 b=s+OMzFEjeSwe2lGG3INyxHoHeF+4KafTNX8ETGNZIK4EkiNdSVgsLk2zQ7gsfOC9y8
 lw8/UDuVW6NIAf8seiq3S5lA5Xcglx3ANnz010j8mSEZ24sHoMAFpdtCTwfTo2PkdpNB
 T2eef39jNYwb+yVK0nNyayfttuR7XwZ56bbqjxHHz/GYhD3zAiHhCMghxyNpHtAx+HZz
 SK3KiiZt24vSZP1zJxkCkPQZ1CokY3C3GVdxz+AosBrgAN8snzOf+U7QiRIAEMrxi61K
 SLeGlZ60K8Gek/Rh4laHRycQNcAaBzRRoq09zWjGLazjgZT1rzn8TGG+IlMAxezGY5ZG
 rJFg==
X-Gm-Message-State: AOJu0YyFtO62O/fPWKjshecYGnYQHve5uGZXz+n5SjYfp6led8ipZZEb
 yyUqhQJKb/0FIYLVRaJqLw0XW+fgQG/486HKKWr68h3xUHcJMtLlD4befydh/dU=
X-Google-Smtp-Source: AGHT+IFkm+ljq6UdQVMVe2Csab7s0/IPIRCRDtdV74A9n3BzoeszaBsxB1OTJpY1NRpWhh+jXo5A3Q==
X-Received: by 2002:a2e:9252:0:b0:2df:baf3:2ae3 with SMTP id
 38308e7fff4ca-2e447084aa1mr12087441fa.29.1715158332216; 
 Wed, 08 May 2024 01:52:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87b265dasm15391295e9.3.2024.05.08.01.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 01:52:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D99B5F9EB;
 Wed,  8 May 2024 09:52:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] tests/tcg: don't append QEMU_OPTS for armv6m-undef test
Date: Wed,  8 May 2024 09:52:07 +0100
Message-Id: <20240508085207.927687-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
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

We don't want to build on the default machine setup here but define a
custom one for the microbit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 4c9264057f..39e01ce49d 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -16,7 +16,7 @@ test-armv6m-undef: test-armv6m-undef.S
 		$< -o $@ -nostdlib -N -static \
 		-T $(ARM_SRC)/$@.ld
 
-run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
+run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,chardev=output -M microbit -kernel
 
 ARM_TESTS+=test-armv6m-undef
 
-- 
2.39.2


