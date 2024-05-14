Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEF4C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wBl-0004wU-Vm; Tue, 14 May 2024 13:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBP-0004pw-I6
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:29 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wB2-0004tC-Kc
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:16 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so77038466b.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715708576; x=1716313376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SGXtYjHPhRPb+FEejg3JUt/LMp+FdVDAbFVCCpIL84=;
 b=CTMoFzUGl3qUcgomgI4RcY/lMFCmBEPf64YUQ6ofsWr7HxL4KssHzhgi6OmX2++3ZJ
 18RyrAl3hXT/qhJ9VufcmgcA8x9bdGujyIqc3BX+17Ba2fKFeqx6xhCpWbniO6mkv//z
 ly42mW/AW8NxK9cEjFP0lNTBNx8C4l/Mf2Oi/MZDrGpYpnvnVv1UzZVhEmsPNabnvyKx
 Jwp5j3gHf8NUGEe/2VBuy9u0juRCARddpoGtCnlus420O0FGgnDVDLe2Lh8FC+MBzs5y
 FGHUbTs3NjEHvvoMwhfpI3zIndF2kzb3r27GMmoQyBOLLoKTqK0rZP/wzxuUsOEAKwwb
 ipoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708576; x=1716313376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3SGXtYjHPhRPb+FEejg3JUt/LMp+FdVDAbFVCCpIL84=;
 b=n9c/JzKUYLoUuluZ/oHno/ZYtH3Lxn13p2nIomy6+i1QK0lHzrA8pTzcbgG4w0jy8G
 WQkn5KeUXLgEkBQjgQrIUTgW0NyE6RjxG4Si6ty+ntq6WCfltV5dHl85iRuD1q6S3uCJ
 oEv1xb6hh5gRsHx0aJUPVhuU7B+qO1RvsNKqDtDQHJJN32jYMoqEN03s7Oj1c8GXDywX
 CC4TTuL8TkdO7bDJ9QRvE3L94MadM8tb4UXF96VsjQwZggpv291eNVMXGlRlXHHhZoab
 lAZ0pvJmCZSM3d0D3L03y3RtteJcwIp9izpuOUeaDsWu2TS/gsoG2vPa/2uFJp2GNxLQ
 yxpw==
X-Gm-Message-State: AOJu0YwsoJ9iDokMWj9VwvXOakWa15U4F0CweBWVbgTDFI3a4N0XU4zA
 XS/jpFMNh22G4/HVUBJXGF293vWrbHsxKsL+sI2btGr/+XJA1ozuY9b7QSvdN4g=
X-Google-Smtp-Source: AGHT+IEMGc3kE9kaM8kXebO19zguiwMTIrcSMiT70XOCHnLFGxatL+wliQ1oj+I8sk4HZtDje3TAiA==
X-Received: by 2002:a17:906:2b9a:b0:a58:b479:8fdc with SMTP id
 a640c23a62f3a-a5a1155b441mr1298791266b.1.1715708576496; 
 Tue, 14 May 2024 10:42:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cf70sm743626566b.30.2024.05.14.10.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 10:42:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 072245FA18;
 Tue, 14 May 2024 18:42:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 01/11] tests/tcg: don't append QEMU_OPTS for armv6m-undef test
Date: Tue, 14 May 2024 18:42:43 +0100
Message-Id: <20240514174253.694591-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514174253.694591-1-alex.bennee@linaro.org>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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


