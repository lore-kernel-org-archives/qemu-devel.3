Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46950C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNznt-000557-Pn; Sun, 30 Jun 2024 15:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznP-0004sQ-MP
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:07 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznL-0007Xl-1S
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:07 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2bfdae7997aso1267650a91.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774061; x=1720378861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tgpppfkBVV9iuvGOhUUIIQbmuFzvgm7jwu3YigAnmAw=;
 b=pe6qW3RADlScF09CEEHvbu/qzMvZQ+FohB1mYZQ7qLFOd/KGzvGC7+tI/EvGnQN+Yc
 C2NzYLhV5YsP2OMM2ynQ4T2gfYtgAcod4NrU2xDuImU5DciMnMXhZYXmPqDitXRP9OxC
 t+lVdMqT0+8lbBsD4JyGPPdHYPHsAeKy1aegBV8qv2GnxJNC93ZW6cS3eHc3cFAq/bhR
 RI81M/5bik/P9WYjj+0+KEi77Ea4DtYmLi+mCy1XlMIERBJ7pEoj2YwbuLNymG06c5xT
 TXTY9hk7XvaS1KPaJWJw1bpc8bxCcs7cdmJneaSjV6aO1E/fnJXZtJ2C/f66gk0pYmI4
 mrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774061; x=1720378861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tgpppfkBVV9iuvGOhUUIIQbmuFzvgm7jwu3YigAnmAw=;
 b=n+5Trt4FGdAtK901ysCpdOdCchk5qzP6BTUTH6xuG/orM8sJvts7IQ8olTyIyk3kvh
 oTgH4YYbObVIMha2YH2R4R7VZ+Jm1SbX8Y6k0I6TKuNe8IK2HdKOKpPGmAoK8LHkD0NA
 7rzoc4VKXEA/0Udgm56JKZRC7TmNdNVs02ng5xLeCIUTJBZAa17LUNpY4POazz34Z644
 +jPsKlFetqzrHuYPey8rHT0B7nVwuswmVt/vho6CPuWUDV9dDLr4wAz49B8DfpUNBJBk
 l9LAzQWgxIpizxpiQBJt/iWCYi3UkH4WmxL1NV/CG40buwOAGgwx0AbpUPY43dvz6zc1
 EhzQ==
X-Gm-Message-State: AOJu0YwzvxEDCzyFtOxCovTMBMkyb/l2zflz6FY8EAIRNsvMq5CPtpjq
 BrERcaOUO2cYX5DvQL9lIMHHNKNky8lNhhAwKUbU7wqcJbMpkM7kpJ+3/o9lAayw1Arkk7SQoEh
 o
X-Google-Smtp-Source: AGHT+IFCXpYpVGnojg0mfObCr4UOqQMoUSRBgjCgnfB9eVdB6j/pLbOV19W8Tdrs6pTsSU9CwxMglw==
X-Received: by 2002:a17:90a:3488:b0:2c5:249d:67be with SMTP id
 98e67ed59e1d1-2c93d729fb2mr1385362a91.22.1719774061073; 
 Sun, 30 Jun 2024 12:01:01 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:01:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 09/14] tests/tcg/arm: Drop -N from LDFLAGS
Date: Sun, 30 Jun 2024 12:00:45 -0700
Message-Id: <20240630190050.160642-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

This is redudant with a linker script, and is not
supported by clang.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/arm/Makefile.softmmu-target | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 39e01ce49d..547063c08c 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -13,7 +13,7 @@ VPATH 		+= $(ARM_SRC)
 test-armv6m-undef: test-armv6m-undef.S
 	$(CC) -mcpu=cortex-m0 -mfloat-abi=soft \
 		-Wl,--build-id=none -x assembler-with-cpp \
-		$< -o $@ -nostdlib -N -static \
+		$< -o $@ -nostdlib -static \
 		-T $(ARM_SRC)/$@.ld
 
 run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,chardev=output -M microbit -kernel
@@ -30,7 +30,7 @@ CRT_PATH=$(ARM_SRC)
 LINK_SCRIPT=$(ARM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT)
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib -N $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
+LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 # building head blobs
 .PRECIOUS: $(CRT_OBJS)
-- 
2.34.1


