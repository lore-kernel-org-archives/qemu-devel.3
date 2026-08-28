Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF28C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvSs-0007mv-Rd; Fri, 28 Aug 2026 08:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSr-0007mF-0i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSn-0005Wh-Vi
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso6089305e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787919220; x=1788524020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wT2Ov8MI3C035TVM3YchRLigEacfsHxS5t2GnZHDLiw=;
 b=vmRtzLuTqhSC+TD9YKe+0J//min/quq9sWbEM5XB4r6zAvXthSa9nLZDVx2tGtYzht
 mEyso71injk7iEbcdk6WoyJmHaF8LgkegTqtgp4O4jkqFpHzGG9q706/Ku77dicK6Ek9
 l2uazKDv9SwykqP4kFIQUDlvaNqL0eRs60qLLhrsv8M7WDF318FUJkPsNFlWhIKnEoo5
 OaPkEoW2/KqwMt9IqFnoIEgb6HAGaJbewbabmpq1RGN7me+4Qmrd/2o3uFY2cqIuV5Ih
 Jnv7dFi2t5CzIm6n4/nQYcULJE3OH6r/K/Giv4UKQ2nnnL8iQJrCwMY4MUFSrksO97qO
 1N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919220; x=1788524020;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wT2Ov8MI3C035TVM3YchRLigEacfsHxS5t2GnZHDLiw=;
 b=jrJrdD2i0Lrd3YSSRBU8cwwMvBq5WYGF2eoNXy8cEq07Fp7ri+bR9M/L1FeP2EexnM
 ATIFTBxCClRhgDutc+vchjesl4WzG+6506QS2TjEiC828It7diQXh6tUu5wqw3x1ey5k
 IzaSRaqS61km7g7kuoCrOpbdIY/6kK9T+zwQwP0tkCfLm2kYf5Bhad01xRHOxTwBndhC
 6SdkWR7v0HbyiCFNacuCcWEYl7pacNSAxGKTTS3yJpaEXYo6e+mGBhQ3rMsSDaQLhAJt
 Rrazf37kceIhaK7OE7jk003lkb9RI3Sga8Qmsb+qXR6Xqmtiwp+hBIOUayHKkSWNJp05
 ulRA==
X-Gm-Message-State: AFuF++kYN9i4sxSyuQgUpp83YAXsFFwUFUw6M2Lxe3kLxQzauPtxaO4t
 t0dRdpchffXttVfbr7qa4ruVaIoYjBUY0CEa3Ymw6mG5hwF3nNziIdVMbHs88WTraOQ=
X-Gm-Gg: AR+sD12XnR4jHqGrWekB2gMg41ZLCQ8uluzWJ3RSChJ+/R21y76z0JkAKxEQ2tLZvFW
 UHRjFDIQJPDp8D+Q+5YOdwoeo3bxn2gwYQlNOV6HEFyAU1el7CLc5PkilCSjqwRD9Mx5ZZOVX5Z
 tien5j551ZENPtO8U5qOfxUHavo8xe+FkYwvHa13uCpjZJZPcqNUYdSYoWyqBkz1qPYTq9p/dEu
 DxxZl0BLl24ncymhW4UcXCeqb6ghkTYmzsjsO8aR9iD4GJdx4diQb7iTLGqBDAHPajdt4hmnu8H
 7k2JHKrHdgzkoMNaolocpylFvSzrketftzcIIAqNBulLrYGDE+1+KdtL9mbRtJji1bITxMi7OHR
 IBA63uuaXdPhgaBqwgSAiU/MjV5QJlIsveaUYLUR647dkNgGhz+Q8riMSXNkNY1akK3kneD/XXz
 4lJwLgv2yY8ZQaexKLDeCw9LiPtj0jhLUQlj6iX1P+Qehh6C13Vr/W4xabucru
X-Received: by 2002:a05:600c:1f82:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49b91c19d37mr101170005e9.2.1787919220205; 
 Fri, 28 Aug 2026 05:13:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9266be71sm119014175e9.2.2026.08.28.05.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:13:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0A2A65F9DA;
 Fri, 28 Aug 2026 13:13:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 2/6] tests/arm: add explicit CFLAGS for system build
Date: Fri, 28 Aug 2026 13:13:33 +0100
Message-ID: <20260828121337.2277303-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828121337.2277303-1-alex.bennee@linaro.org>
References: <20260828121337.2277303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The brew toolchain on macOS (arm-none-eabi-gcc) is a little different
from the default on Debian (arm-linux-gnueabihf-gcc) as a result it
defaults to an older architectural baseline (without isb's), assumes
softfloat and will get confused by including stdint.h without being
told it is compiling freestanding code.

Make these all explicit so we can build arm-softmmu tests on macOS.
The test-armv6m-undef is unaffected as it has it's very own build
stanza.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260824-fixes-for-11-2-v2-2-352c6b890402@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index b66074b0b43..3e8a9b4073e 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -29,7 +29,7 @@ ARM_TESTS+=$(patsubst $(ARM_SRC)/%.c, %, $(ARM_TEST_SRCS))
 CRT_PATH=$(ARM_SRC)
 LINK_SCRIPT=$(ARM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
+CFLAGS+=-march=armv7-a+fp -ffreestanding -nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 # building head blobs
-- 
2.47.3


