Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF53C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPku9-0005os-EY; Fri, 05 Jul 2024 11:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPku6-0005mU-DM
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:18 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktq-0000OE-VG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:18 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6fd513f18bso195533066b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193461; x=1720798261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nRoFsyx+m619boGjC+CQwE+ICP9tXSsJdqLrwUZiNk8=;
 b=lzFvXzTlOBxf2RWsQ/YuMko962ejhRQjy5R2AS+ELfom3HhD9Zzv582ceR8dfP6h1U
 stPMrtWGSqgZHQ3JJ0nYR4fQ6+TcW/Kn2C/umo4Raqczv0bh8M+t5iuy6oq2QMrS2vBd
 48tBTJ6Co6kQYzKiaemDfeZC/EJISXRefyQNKyVhDCWthAZvkYd3r4TeZFB2khkmjlic
 o2W+yDs5kLgWd/CVX9OhbyE430Gv0+5F80ty09Z1U1TJLQ7yFVgxECneN2gZv3D5lS6s
 22o5DLwo5+F8ssoUJZE5OUKVRLVMPNZguJpQZkrC8BlvJG3j9M8lJhmdhowuTTxuk4bc
 ac/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193461; x=1720798261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nRoFsyx+m619boGjC+CQwE+ICP9tXSsJdqLrwUZiNk8=;
 b=j7li3t3ZjrUSbcMr2JHdpuNm6OGQcny0NeRlloVcVOSNYp9XFadh5YveNQ6NRiHe27
 hltw6lx3iWBNqQqyNVizT2hpNNMDgMVvzNi+J1JrpKfBAKrtL4oEQj3xSIFQL0Hnk338
 b/nSMuNiQlygqkE5zumwS+9T/mOsZhr+B5c7Od53VXxDnOdQZOy0gzRcPIernmkVRU0Y
 9GGCrwyIB50+Tdabnmn/D2zeRaA0w5jFhOmQ7gmcX/uQSEzlviWLZ8L5c3HyHze14pdT
 GMWuozUcoGziVH80UI3rMh2U8PjEtIMK+I1lzM1lP2M8GUsEH56gH1rzfqdIz1thPBEd
 ZxfQ==
X-Gm-Message-State: AOJu0Yxypvxt3a3lAVhB/e5I9Q+LexTxEsAXdCax5nVv90XcUt7cUqMl
 u7Ogh4qBzndm9iUPJf5C4xP11gAK5+q1ojeQlRoNhotY06AhpH68wA+8pgzCT20=
X-Google-Smtp-Source: AGHT+IF/CA/2txbomjhD+huuTxiUAdoiiWAv2xIp0Hlgdebv2Ug0dpvKCtS4L1HwIdT+IsoPn8hY5w==
X-Received: by 2002:a17:906:48d8:b0:a77:da14:840a with SMTP id
 a640c23a62f3a-a77da1485b8mr91370166b.69.1720193460951; 
 Fri, 05 Jul 2024 08:31:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf6039asm688913266b.54.2024.07.05.08.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61CE262107;
 Fri,  5 Jul 2024 16:30:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 14/40] tests/tcg/arm: Drop -N from LDFLAGS
Date: Fri,  5 Jul 2024 16:30:26 +0100
Message-Id: <20240705153052.1219696-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

This is redudant with a linker script, and is not
supported by clang.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-10-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-15-alex.bennee@linaro.org>

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
2.39.2


